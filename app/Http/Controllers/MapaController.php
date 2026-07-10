<?php

namespace App\Http\Controllers;

use App\Models\Almacen;
use App\Models\Empresa;
use App\Models\Mapa;
use App\Models\Trampa;
use App\Models\TrampaTipo;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Validation\ValidationException;

class MapaController extends Controller
{
  // SVG excluido a propósito (permite scripts embebidos).
  private const EXTENSIONES_IMAGEN = ['png', 'jpg', 'jpeg', 'gif', 'webp'];

  // empresa_id no se acepta del cliente: se deduce siempre del almacén.
  private $toValidated = [
    'almacen_id'   => 'required|exists:almacenes,id',
    'titulo'       => 'nullable|string|max:255',
    'background'   => 'nullable|string', // dataURL reemplaza, ruta conserva, null quita
    'trap_size'    => 'nullable|integer|min:1|max:200',
    'texts'        => 'nullable|array',
    'texts.*.id'   => 'required|string',
    'texts.*.text' => 'required|string',
    'texts.*.x'    => 'required|numeric',
    'texts.*.y'    => 'required|numeric',
    'texts.*.listed'   => 'boolean',
    'texts.*.vertical' => 'boolean',
    'texts.*.fontSize' => 'numeric',
    'trampas'      => 'nullable|array',
    'trampas.*.id'             => 'nullable|integer',
    'trampas.*.trampa_tipo_id' => 'required|exists:trampa_tipos,id',
    'trampas.*.posx'           => 'required|numeric',
    'trampas.*.posy'           => 'required|numeric',
    'trampas.*.estado'         => 'nullable|string|in:activo,inactivo,mantenimiento',
    'trampas.*.numero'         => 'nullable|integer',
    'trampas.*.identificador'  => 'required|string|max:255',
  ];

  public function index(Request $request)
  {
    $user = $request->user();
    $esCliente = $user->hasRole('cliente');
    $almacenId = $request->integer('almacen_id') ?: null;

    /* =========================
       Empresas y almacenes
    ========================= */
    if ($esCliente) {
      $empresaIds = $user->empresas()->pluck('empresas.id');

      $empresas = Empresa::select('id', 'nombre')->whereIn('id', $empresaIds)->get();
      $almacenes = Almacen::select('id', 'nombre', 'empresa_id')
        ->whereIn('empresa_id', $empresaIds)
        ->get();
    } else {
      $empresas = Empresa::select('id', 'nombre')->get();
      $almacenes = Almacen::select('id', 'nombre', 'empresa_id')->get();
    }

    // Evitar IDOR: el cliente solo puede consultar almacenes de sus empresas.
    if ($esCliente && $almacenId && !$almacenes->contains('id', $almacenId)) {
      abort(403);
    }

    /* =========================
       Mapas del almacén
    ========================= */
    $mapas = collect();

    if ($almacenId) {
      $mapas = Mapa::with(['trampas' => function ($q) {
        $q->where('estado', '!=', 'inactivo')
          ->orderBy('numero')
          // Una sola consulta por dependencia en vez de 3 exists() por trampa.
          ->withExists(['especieSeguimientos', 'roedorSeguimientos', 'accionTrampas']);
      }])
        ->where('almacen_id', $almacenId)
        ->orderBy('id')
        ->get()
        ->map(fn($mapa) => [
          'id' => $mapa->id,
          'empresa_id' => $mapa->empresa_id,
          'almacen_id' => $mapa->almacen_id,
          'titulo' => $mapa->titulo,
          'background' => $mapa->background,
          'texts' => $mapa->texts,
          'trapSize' => $mapa->trap_size,
          'trampas' => $mapa->trampas->map(fn($t) => [
            'id' => $t->id,
            'trampa_tipo_id' => $t->trampa_tipo_id,
            'posx' => $t->posx,
            'posy' => $t->posy,
            'estado' => $t->estado,
            'numero' => $t->numero,
            'identificador' => $t->identificador,
            'puede_eliminar' => !$t->especie_seguimientos_exists
              && !$t->roedor_seguimientos_exists
              && !$t->accion_trampas_exists,
          ]),
        ]);
    }

    return inertia('admin/mapas/lista', [
      'empresas' => $empresas,
      'allAlmacenes' => $almacenes,
      'trampaTipos' => TrampaTipo::select('id', 'nombre', 'imagen')->get(),
      'selectedEmpresa' => $mapas->first()['empresa_id'] ?? null,
      'selectedAlmacen' => $almacenId,
      'mapas' => $mapas,
    ]);
  }

  public function store(Request $request)
  {
    $validated = $request->validate($this->toValidated);
    $empresaId = Almacen::whereKey($validated['almacen_id'])->value('empresa_id');

    $background = $this->procesarBackground($validated['background'] ?? null, null);

    try {
      DB::transaction(function () use ($validated, $empresaId, $background) {
        $mapa = Mapa::create([
          'empresa_id' => $empresaId,
          'almacen_id' => $validated['almacen_id'],
          'titulo'     => $validated['titulo'] ?? null,
          'user_id'    => Auth::id(),
          'data'       => $validated['trap_size'] ?? 30, // trapSize
          'background' => $background,
        ]);

        $mapa->trampas()->createMany(
          collect($validated['trampas'] ?? [])->values()->map(fn($t, $i) => $this->datosTrampa($t, $i, $validated['almacen_id']))
        );
      });
    } catch (\Throwable $e) {
      $this->eliminarArchivoBackground($background);
      Log::error('Error al crear mapa', ['almacen_id' => $validated['almacen_id'], 'error' => $e->getMessage()]);
      return back()->withInput()->withErrors(['mapa' => 'Error al crear el mapa.']);
    }

    return redirect()
      ->route('mapas.index', ['almacen_id' => $validated['almacen_id']])
      ->with('success', 'Mapa creado correctamente');
  }

  public function update(Request $request, Mapa $mapa)
  {
    $validated = $request->validate($this->toValidated);
    $empresaId = Almacen::whereKey($validated['almacen_id'])->value('empresa_id');

    $backgroundAnterior = $mapa->background;
    $background = $this->procesarBackground($validated['background'] ?? null, $backgroundAnterior);

    try {
      DB::transaction(function () use ($validated, $empresaId, $background, $mapa) {
        $mapa->update([
          'empresa_id' => $empresaId,
          'almacen_id' => $validated['almacen_id'],
          'titulo'     => $validated['titulo'] ?? null,
          'data'       => $validated['trap_size'] ?? 30, // trapSize
          'background' => $background,
        ]);

        $recibidas = collect($validated['trampas'] ?? []);
        $idsEnviados = $recibidas->pluck('id')->filter()->all();

        // Trampas quitadas del mapa: borrar las libres, ocultar las que
        // tienen seguimientos/acciones (no se pueden borrar por FK).
        [$conDeps, $sinDeps] = $mapa->trampas()
          ->whereNotIn('id', $idsEnviados)
          ->withExists(['especieSeguimientos', 'roedorSeguimientos', 'accionTrampas'])
          ->get()
          ->partition(
            fn($t) => $t->especie_seguimientos_exists
              || $t->roedor_seguimientos_exists
              || $t->accion_trampas_exists
          );

        if ($sinDeps->isNotEmpty()) {
          Trampa::whereIn('id', $sinDeps->pluck('id'))->delete();
        }
        if ($conDeps->isNotEmpty()) {
          Trampa::whereIn('id', $conDeps->pluck('id'))->update(['estado' => 'inactivo']);
        }

        // Actualizar existentes y crear nuevas.
        foreach ($recibidas->values() as $index => $trampaData) {
          $data = $this->datosTrampa($trampaData, $index, $validated['almacen_id']);

          if (!empty($trampaData['id'])) {
            $mapa->trampas()->whereKey($trampaData['id'])->update($data);
          } else {
            $mapa->trampas()->create($data);
          }
        }
      });
    } catch (\Throwable $e) {
      if ($background !== $backgroundAnterior) {
        $this->eliminarArchivoBackground($background);
      }
      Log::error('Error al actualizar mapa', ['mapa_id' => $mapa->id, 'error' => $e->getMessage()]);
      return back()->withInput()->withErrors(['mapa' => 'Error al actualizar el mapa.']);
    }

    // El archivo anterior se borra recién con el cambio confirmado en BD.
    if ($background !== $backgroundAnterior) {
      $this->eliminarArchivoBackground($backgroundAnterior);
    }

    return redirect()
      ->route('mapas.index', ['almacen_id' => $validated['almacen_id']])
      ->with('success', 'Mapa actualizado correctamente');
  }

  public function destroy(Request $request, Mapa $mapa)
  {
    // Las trampas con seguimientos o acciones no pueden borrarse (FK);
    // avisar en vez de reventar con error SQL.
    $tieneDependencias = $mapa->trampas()
      ->where(function ($q) {
        $q->whereHas('especieSeguimientos')
          ->orWhereHas('roedorSeguimientos')
          ->orWhereHas('accionTrampas');
      })
      ->exists();

    if ($tieneDependencias) {
      return back()->withErrors([
        'mapa' => 'No se puede eliminar el mapa: tiene trampas con seguimientos o acciones registrados.',
      ]);
    }

    DB::transaction(function () use ($mapa) {
      $mapa->trampas()->delete();
      $mapa->delete();
    });

    $this->eliminarArchivoBackground($mapa->background);

    return redirect()->route('mapas.index', [
      'almacen_id' => $request->input('almacen_id'),
    ]);
  }

  /* ==================== Helpers ==================== */

  private function datosTrampa(array $trampaData, int $index, int|string $almacenId): array
  {
    return [
      'almacen_id'     => $almacenId,
      'trampa_tipo_id' => $trampaData['trampa_tipo_id'],
      'posx'           => round($trampaData['posx']),
      'posy'           => round($trampaData['posy']),
      'estado'         => $trampaData['estado'] ?? 'activo',
      'numero'         => $trampaData['numero'] ?? ($index + 1),
      'identificador'  => $trampaData['identificador'],
    ];
  }

  /**
   * Resuelve el background: null quita el fondo, un dataURL guarda archivo
   * nuevo, cualquier otra cadena (ruta existente) conserva el actual.
   * No borra el archivo anterior: eso lo decide el caller tras el commit.
   */
  private function procesarBackground(?string $input, ?string $actual): ?string
  {
    if ($input === null || $input === '') {
      return null;
    }

    if (!preg_match('/^data:image\/(\w+);base64,/', $input, $match)) {
      return $actual;
    }

    $extension = strtolower($match[1]);
    if (!in_array($extension, self::EXTENSIONES_IMAGEN, true)) {
      throw ValidationException::withMessages(['background' => 'Formato de imagen no permitido.']);
    }

    $imageData = base64_decode(substr($input, strpos($input, ',') + 1), true);
    if ($imageData === false || @getimagesizefromstring($imageData) === false) {
      throw ValidationException::withMessages(['background' => 'Imagen de fondo inválida.']);
    }

    $directory = public_path('images/mapas');
    if (!is_dir($directory)) {
      mkdir($directory, 0755, true);
    }

    $filename = uniqid('mapa_') . '.' . $extension;
    file_put_contents($directory . '/' . $filename, $imageData);

    return 'images/mapas/' . $filename;
  }

  private function eliminarArchivoBackground(?string $path): void
  {
    // Solo archivos dentro del directorio de fondos de mapas.
    if ($path && str_starts_with($path, 'images/mapas/') && file_exists(public_path($path))) {
      @unlink(public_path($path));
    }
  }
}
