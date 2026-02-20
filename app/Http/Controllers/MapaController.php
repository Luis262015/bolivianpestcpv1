<?php

namespace App\Http\Controllers;

use App\Models\Almacen;
use App\Models\Empresa;
use App\Models\Mapa;
use App\Models\Trampa;
use App\Models\TrampaTipo;
use App\Models\User;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Storage;
use Illuminate\Database\QueryException;

class MapaController extends Controller
{

  // public function index(Request $request)
  // {
  //   $user = $request->user();
  //   $mapa = Mapa::where('almacen_id', $request->almacen_id)
  //     ->with('trampas')
  //     ->first();

  //   if ($user->HasRole('cliente')) {
  //     $empresasUser = User::with('empresas')->find($user->id);
  //     $empresaUser = $empresasUser->empresas[0];
  //     $empresas = Empresa::select(['id', 'nombre'])->where('id', $empresaUser->id)->get();
  //     $almacenes = Almacen::select(['id', 'nombre', 'empresa_id'])->where('empresa_id', $empresaUser->id)->get();
  //   } else {
  //     $empresas = Empresa::all(['id', 'nombre']);
  //     $almacenes = Almacen::all(['id', 'nombre', 'empresa_id']);
  //   }

  //   return inertia('admin/mapas/lista', [
  //     // 'empresas' => Empresa::select('id', 'nombre')->get(),
  //     'empresas' => $empresas,
  //     // 'allAlmacenes' => Almacen::select('id', 'nombre', 'empresa_id')->get(),
  //     'allAlmacenes' => $almacenes,
  //     'trampaTipos' => TrampaTipo::select('id', 'nombre', 'imagen')->get(),
  //     'selectedEmpresa' => $mapa?->empresa_id,
  //     'selectedAlmacen' => $request->almacen_id,
  //     'mapa' => $mapa ? [
  //       'id' => $mapa->id,
  //       'background' => $mapa->background,
  //       'texts' => $mapa->texts ?? [],
  //       'trampas' => $mapa->trampas->map(function ($t) {
  //         return [
  //           'id' => $t->id,
  //           'trampa_tipo_id' => $t->trampa_tipo_id,
  //           'posx' => $t->posx,
  //           'posy' => $t->posy,
  //           'estado' => $t->estado,
  //         ];
  //       }),
  //     ] : null,
  //   ]);
  // }

  public function index(Request $request)
  {
    $user = $request->user();
    $almacenId = $request->almacen_id;

    /* =========================
       Empresas y almacenes
    ========================= */

    if ($user->hasRole('cliente')) {
      $empresasUser = User::with('empresas')->find($user->id);
      $empresaUser = $empresasUser->empresas->first();

      $empresas = Empresa::select('id', 'nombre')
        ->where('id', $empresaUser->id)
        ->get();

      $almacenes = Almacen::select('id', 'nombre', 'empresa_id')
        ->where('empresa_id', $empresaUser->id)
        ->get();
    } else {
      $empresas = Empresa::select('id', 'nombre')->get();
      $almacenes = Almacen::select('id', 'nombre', 'empresa_id')->get();
    }

    /* =========================
       Mapas del almacén
    ========================= */

    $mapas = collect();

    if ($almacenId) {
      $mapas = Mapa::with(['trampas' => function ($q) {
        $q->orderBy('numero');
      }])
        ->where('almacen_id', $almacenId)
        ->orderBy('id')
        ->get()
        ->map(function ($mapa) {
          return [
            'id' => $mapa->id,
            'empresa_id' => $mapa->empresa_id,
            'almacen_id' => $mapa->almacen_id,
            'titulo' => $mapa->titulo,
            'background' => $mapa->background,
            'texts' => $mapa->texts ?? [],
            'trampas' => $mapa->trampas->map(function ($t) {
              return [
                'id' => $t->id,
                'trampa_tipo_id' => $t->trampa_tipo_id,
                'posx' => $t->posx,
                'posy' => $t->posy,
                'estado' => $t->estado,
                'numero' => $t->numero,
                'identificador' => $t->identificador,
              ];
            }),
          ];
        });
    }

    /* =========================
       Render Inertia
    ========================= */

    return inertia('admin/mapas/lista', [
      'empresas' => $empresas,
      'allAlmacenes' => $almacenes,
      'trampaTipos' => TrampaTipo::select('id', 'nombre', 'imagen')->get(),

      // selección actual
      'selectedEmpresa' => $mapas->first()['empresa_id'] ?? null,
      'selectedAlmacen' => $almacenId,

      // 👇 CAMBIO CLAVE
      'mapas' => $mapas, // AHORA ES ARRAY
    ]);
  }

  public function store(Request $request)
  {
    // dd($request);

    $validated = $request->validate([
      'empresa_id'   => 'required|exists:empresas,id',
      'almacen_id'   => 'required|exists:almacenes,id',
      'titulo'       => 'nullable|string',
      'background'   => 'nullable|string', // puede ser dataURL o ruta
      'texts'        => 'nullable|array',
      'texts.*.id'   => 'required|string',
      'texts.*.text' => 'required|string',
      'texts.*.x'    => 'required|numeric',
      'texts.*.y'    => 'required|numeric',
      'texts.*.listed'   => 'boolean',
      'texts.*.vertical' => 'boolean',
      'texts.*.fontSize' => 'numeric',
      'trampas'      => 'nullable|array',
      'trampas.*.trampa_tipo_id' => 'required|exists:trampa_tipos,id',
      'trampas.*.posx'           => 'required|numeric',
      'trampas.*.posy'           => 'required|numeric',
      'trampas.*.estado'         => 'nullable|string|in:activo,inactivo,mantenimiento',
      'trampas.*.numero'         => 'nullable|integer',
      'trampas.*.identificador'  => 'required|string',

    ]);

    // dd($validated);

    try {
      DB::beginTransaction();

      // Crear el mapa
      $mapa = Mapa::create([
        'empresa_id' => $validated['empresa_id'],
        'almacen_id' => $validated['almacen_id'],
        'titulo'     => $validated['titulo'] ?? null,
        'user_id'    => Auth::id(),
        'texts'      => $validated['texts'] ?? [], // json o array según tu estructura
      ]);

      if ($request->filled('background')) {
        $base64 = $request->input('background');
        if (preg_match('/^data:image\/(\w+);base64,/', $base64, $match)) {
          $extension = strtolower($match[1]);
          $base64 = substr($base64, strpos($base64, ',') + 1);
          $imageData = base64_decode($base64);
          if ($imageData === false) {
            return back()->withErrors(['background' => 'Formato de imagen inválido']);
          }
          $directory = public_path('images/mapas');
          if (!file_exists($directory)) {
            mkdir($directory, 0755, true);
          }
          $filename = $mapa->almacen_id . '_' . time() . '.' . $extension;
          $fullPath = $directory . '/' . $filename;
          file_put_contents($fullPath, $imageData);
          $mapa->background = 'images/mapas/' . $filename;
          $mapa->save();
        }
      } else {
        if ($mapa->background) {
          $mapa->background = null;
          $mapa->save();
        }
      }

      // Guardar las trampas asociadas
      if (!empty($validated['trampas'])) {
        foreach ($validated['trampas'] as $trampaData) {
          Trampa::create([
            'almacen_id'       => $validated['almacen_id'],
            'trampa_tipo_id'   => $trampaData['trampa_tipo_id'],
            'mapa_id'          => $mapa->id,
            'tipo'             => "null", // si aún lo usas, sino eliminar
            'posx'             => $trampaData['posx'],
            'posy'             => $trampaData['posy'],
            'estado'           => $trampaData['estado'] ?? 'activo',
            'numero'           => $trampaData['numero'] ?? null,
            'identificador'    => $trampaData['identificador'],
          ]);
        }
      }

      DB::commit();
      return redirect()
        ->route('mapas.index')
        ->with('success', 'Mapa creado correctamente');
    } catch (Exception | \Error | QueryException $e) {
      DB::rollBack();
      Log::error('Error:', ['error' => $e->getMessage()]);
      return redirect()->back()
        ->withInput()
        ->with('error', 'Error ' . $e->getMessage());
    }
  }

  public function update(Request $request, string $id)
  {

    // dd($request);

    $validated = $request->validate([
      'empresa_id'   => 'required|exists:empresas,id',
      'almacen_id'   => 'required|exists:almacenes,id',
      'titulo'       => 'nullable|string',
      'background'   => 'nullable|string', // puede ser dataURL o ruta
      'texts'        => 'nullable|array',
      'texts.*.id'   => 'required|string',
      'texts.*.text' => 'required|string',
      'texts.*.x'    => 'required|numeric',
      'texts.*.y'    => 'required|numeric',
      'texts.*.listed'   => 'boolean',
      'texts.*.vertical' => 'boolean',
      'texts.*.fontSize' => 'numeric',
      'trampas'      => 'nullable|array',
      'trampas.*.id'         => 'nullable|integer',
      'trampas.*.trampa_tipo_id' => 'required|exists:trampa_tipos,id',
      'trampas.*.posx'           => 'required|numeric',
      'trampas.*.posy'           => 'required|numeric',
      'trampas.*.estado'         => 'nullable|string|in:activo,inactivo,mantenimiento',
      'trampas.*.numero'         => 'nullable|integer',
      'trampas.*.identificador'         => 'required|string',
    ]);


    // dd($validated);


    try {

      $mapa = Mapa::find($id);
      DB::beginTransaction();

      $mapa->update([
        'empresa_id' => $validated['empresa_id'],
        'almacen_id' => $validated['almacen_id'],
        'titulo'     => $validated['titulo'] ?? null,
        'texts'      => $validated['texts'] ?? $mapa->texts ?? [],
      ]);

      // Manejo de imagen de fondo (base64 → archivo en storage)
      if ($request->filled('background')) {
        $base64 = $request->input('background');

        if (preg_match('/^data:image\/(\w+);base64,/', $base64, $match)) {
          $extension = strtolower($match[1]);
          $base64 = substr($base64, strpos($base64, ',') + 1);
          $imageData = base64_decode($base64);

          if ($imageData === false) {
            return back()->withErrors(['background' => 'Formato de imagen inválido']);
          }

          $directory = public_path('images/mapas');
          if (!file_exists($directory)) {
            mkdir($directory, 0755, true);
          }
          $filename = $mapa->almacen_id . '_' . time() . '.' . $extension;
          $fullPath = $directory . '/' . $filename;
          file_put_contents($fullPath, $imageData);
          $mapa->background = 'images/mapas/' . $filename;
          $mapa->save();
          // $path = "mapas/{$mapa->almacen_id}_" . time() . ".{$extension}";
          // Storage::disk('public')->put($path, $imageData);          
          // if ($mapa->background) {
          //   Storage::disk('public')->delete($mapa->background);
          // }
          // $mapa->background = "/storage/" . $path;
          // $mapa->save();
        }
      } else {
        if ($validated['background'] === null) {
          $mapa->background = null;
          $mapa->save();
        }
      }


      $trampasRecibidas = collect($validated['trampas'] ?? []);
      $idsMantener = $trampasRecibidas->filter(fn($t) => !empty($t['id']))->pluck('id');
      // Eliminar las que ya no vienen
      $mapa->trampas()->whereNotIn('id', $idsMantener)->delete(); // 🔴🔴🔴 REVISAR 
      // Procesar cada trampa (crear o actualizar)
      foreach ($trampasRecibidas as $index => $trampaData) {
        $data = [
          'almacen_id'     => $validated['almacen_id'],
          'trampa_tipo_id' => $trampaData['trampa_tipo_id'],
          'posx'           => round($trampaData['posx']),
          'posy'           => round($trampaData['posy']),
          'estado'         => $trampaData['estado'] ?? 'activo',
          'numero'         => $trampaData['numero'] ?? ($index + 1),
          'identificador'         => $trampaData['identificador'],
        ];

        if (!empty($trampaData['id'])) {
          $mapa->trampas()->where('id', $trampaData['id'])->update($data);
        } else {
          $mapa->trampas()->create($data);
        }
      }
      DB::commit();

      return redirect()
        ->route('mapas.index')
        ->with('success', 'Mapa creado correctamente');
    } catch (Exception | \Error | QueryException $e) {
      DB::rollBack();
      return response()->json([
        'message' => 'Error al actualizar el mapa',
        'error' => $e->getMessage(),
      ], 500);
    }
  }


  /** FUNCIONES NO USADAS */
  // public function create() {}
  // public function show(string $id) {}
  // public function edit(string $id) {}
  // public function destroy(string $id) {}
}
