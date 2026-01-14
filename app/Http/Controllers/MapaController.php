<?php

namespace App\Http\Controllers;

use App\Models\Almacen;
use App\Models\Empresa;
use App\Models\Mapa;
use App\Models\Trampa;
use App\Models\TrampaTipo;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;

class MapaController extends Controller
{
  public function index(Request $request)
  {
    $user = $request->user();

    // Filtros básicos (puedes ajustar según tus necesidades)
    // $mapas = Mapa::query()
    //   ->with(['empresa', 'almacen'])
    //   ->when($request->empresa_id, fn($q) => $q->where('empresa_id', $request->empresa_id))
    //   ->when($request->almacen_id, fn($q) => $q->where('almacen_id', $request->almacen_id))
    //   ->when($user->hasRole('admin') && !$user->hasRole('superadmin'), function ($q) use ($user) {
    //     // Si es admin normal, solo ve los mapas de su empresa
    //     $q->where('empresa_id', $user->empresa_id);
    //   })
    //   ->latest()
    //   ->paginate(15);
    //
    // return inertia('admin/mapas/lista', [
    //   'mapas' => $mapas->withQueryString(),
    //   'empresas' => Empresa::select('id', 'nombre')
    //     ->when(
    //       $user->hasRole('admin') && !$user->hasRole('superadmin'),
    //       fn($q) => $q->where('id', $user->empresa_id)
    //     )
    //     ->get(),
    //   'almacenes' => Almacen::select('id', 'nombre', 'empresa_id')
    //     ->when(
    //       $user->hasRole('admin') && !$user->hasRole('superadmin'),
    //       fn($q) => $q->where('empresa_id', $user->empresa_id)
    //     )
    //     ->get(),
    //   // Opción A: Nombre más claro y consistente con lo que usa el frontend
    //   'allAlmacenes' => Almacen::select('id', 'nombre', 'empresa_id')
    //     ->when(
    //       $user->hasRole('admin') && !$user->hasRole('superadmin'),
    //       fn($q) => $q->where('empresa_id', $user->empresa_id)
    //     )
    //     ->get(),
    //   'filters' => $request->only(['empresa_id', 'almacen_id']),
    //   'trampaTipos' => TrampaTipo::select('id', 'nombre', 'imagen')->get(),
    // ]);

    // Modo "cargar mapa para editar"
    $mapa = Mapa::where('almacen_id', $request->almacen_id)
      ->with('trampas')
      ->first();

    return inertia('admin/mapas/lista', [
      'empresas' => Empresa::select('id', 'nombre')->get(),
      'allAlmacenes' => Almacen::select('id', 'nombre', 'empresa_id')->get(),
      'trampaTipos' => TrampaTipo::select('id', 'nombre', 'imagen')->get(),
      'selectedEmpresa' => $mapa?->empresa_id,
      'selectedAlmacen' => $request->almacen_id,
      'mapa' => $mapa ? [
        'id' => $mapa->id,
        'background' => $mapa->background,
        'texts' => $mapa->texts ?? [],
        'trampas' => $mapa->trampas->map(function ($t) {
          return [
            'id' => $t->id,
            'trampa_tipo_id' => $t->trampa_tipo_id,
            'posx' => $t->posx,
            'posy' => $t->posy,
            'estado' => $t->estado,
          ];
        }),
      ] : null,
    ]);

    // $user = $request->user();
    // // dd($user);

    // if ($user->HasRole('cliente')) {
    //   $empresasUser = User::with('empresas')->find($user->id);
    //   $empresaUser = $empresasUser->empresas[0];

    //   $empresas = Empresa::select()->where('id', $empresaUser->id)->get();
    //   // dd($empresas);
    //   $allAlmacenes = Almacen::select()->where('empresa_id', $empresaUser->id)->get();
    // } else {
    //   $empresas = Empresa::all();
    //   $allAlmacenes = Almacen::all();
    // }

    // $selectedEmpresa = $request->input('empresa_id');
    // $selectedAlmacen = $request->input('almacen_id');

    // $mapa = null;

    // if ($selectedAlmacen) {
    //   $mapaModel = Mapa::where('almacen_id', $selectedAlmacen)->first();

    //   if ($mapaModel) {
    //     $data = json_decode($mapaModel->data, true);
    //     $mapa = [
    //       'texts' => $data['texts'] ?? [],
    //       'traps' => $data['traps'] ?? [],
    //       'background' => $mapaModel->background ? Storage::url($mapaModel->background) : null,
    //     ];
    //   }
    // }

    // // return Inertia::render('MapaEditor');
    // return inertia('admin/mapas/lista', [
    //   'empresas' => $empresas,
    //   'allAlmacenes' => $allAlmacenes,
    //   'selectedEmpresa' => $selectedEmpresa,
    //   'selectedAlmacen' => $selectedAlmacen,
    //   'mapa' => $mapa,
    //   'trampaTipos' => TrampaTipo::select('id', 'nombre', 'imagen')->get(),
    // ]);
  }

  public function create() {}

  public function store(Request $request)
  {

    // dd($request);

    $validated = $request->validate([
      'empresa_id'   => 'required|exists:empresas,id',
      'almacen_id'   => 'required|exists:almacenes,id',
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
    ]);

    // dd($validated);

    // Crear el mapa
    $mapa = Mapa::create([
      'empresa_id' => $validated['empresa_id'],
      'almacen_id' => $validated['almacen_id'],
      'user_id'    => Auth::id(),
      // 'background' => $validated['background'],
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

        // $path = "mapas/{$mapa->almacen_id}_" . time() . ".{$extension}";
        $path = "mapas/{$mapa->almacen_id}_" . time() . ".{$extension}";
        Storage::disk('public')->put($path, $imageData);

        // Eliminar fondo anterior si existía
        if ($mapa->background) {
          Storage::disk('public')->delete($mapa->background);
        }

        $mapa->background = "/storage/" . $path;
        $mapa->save();
      }
    } else {
      // Si se quitó el fondo → eliminarlo
      if ($mapa->background) {
        Storage::disk('public')->delete($mapa->background);
        $mapa->background = null;
        $mapa->save();
      }
    }

    // Guardar las trampas asociadas
    if (!empty($validated['trampas'])) {
      foreach ($validated['trampas'] as $trampaData) {
        // $mapa->trampas()->create([
        Trampa::create([
          'almacen_id'       => $validated['almacen_id'],
          'trampa_tipo_id'   => $trampaData['trampa_tipo_id'],
          'mapa_id'          => $mapa->id,
          'tipo'             => "null", // si aún lo usas, sino eliminar
          'posx'             => $trampaData['posx'],
          'posy'             => $trampaData['posy'],
          'estado'           => $trampaData['estado'] ?? 'activo',
          'numero'           => $trampaData['numero'] ?? null,
        ]);
      }
    }

    return redirect()
      ->route('mapas.index')
      ->with('success', 'Mapa creado correctamente');

    // $validated = $request->validate([
    //   'empresa_id' => 'required|exists:empresas,id',
    //   'almacen_id' => 'required|exists:almacenes,id',
    //   'texts'      => 'nullable|array',
    //   'traps'      => 'nullable|array',
    //   'background' => 'nullable|string', // data:image/... base64
    // ]);

    // dd($validated);

    $mapa = Mapa::updateOrCreate(
      [
        'empresa_id' => $validated['empresa_id'],
        'almacen_id' => $validated['almacen_id'],
        'user_id' => Auth::id(),
      ],
      [
        'data' => json_encode([
          'texts' => $validated['texts'] ?? [],
          'traps' => $validated['traps'] ?? [],
        ])
      ]
    );

    // dd("Success");

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

        $path = "mapas/{$mapa->almacen_id}_" . time() . ".{$extension}";
        Storage::disk('public')->put($path, $imageData);

        // Eliminar fondo anterior si existía
        if ($mapa->background) {
          Storage::disk('public')->delete($mapa->background);
        }

        $mapa->background = $path;
        $mapa->save();
      }
    } else {
      // Si se quitó el fondo → eliminarlo
      if ($mapa->background) {
        Storage::disk('public')->delete($mapa->background);
        $mapa->background = null;
        $mapa->save();
      }
    }

    return back()->with('success', 'Mapa guardado correctamente');
  }

  public function show(string $id) {}

  public function edit(string $id) {}

  public function update(Request $request, string $id)
  {

    // dd($id);
    // dd($request);
    // dd($request->background === null);

    $validated = $request->validate([
      'empresa_id'   => 'required|exists:empresas,id',
      'almacen_id'   => 'required|exists:almacenes,id',
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
    ]);

    $mapa = Mapa::find($id);

    DB::beginTransaction();

    try {



      $mapa->update([
        'empresa_id' => $validated['empresa_id'],
        'almacen_id' => $validated['almacen_id'],
        // 'background' => $validated['background'],
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

          // $path = "mapas/{$mapa->almacen_id}_" . time() . ".{$extension}";
          $path = "mapas/{$mapa->almacen_id}_" . time() . ".{$extension}";
          Storage::disk('public')->put($path, $imageData);

          // Eliminar fondo anterior si existía
          if ($mapa->background) {
            Storage::disk('public')->delete($mapa->background);
          }

          $mapa->background = "/storage/" . $path;
          $mapa->save();
        }
      } else {
        // Si se quitó el fondo → eliminarlo
        // if ($mapa->background) {
        if ($validated['background'] === null) {
          Storage::disk('public')->delete($mapa->background);
          $mapa->background = null;
          $mapa->save();
        }
      }

      $trampasRecibidas = collect($validated['trampas'] ?? []);

      $idsMantener = $trampasRecibidas->filter(fn($t) => !empty($t['id']))->pluck('id');

      // Eliminar las que ya no vienen
      $mapa->trampas()->whereNotIn('id', $idsMantener)->delete();

      // Procesar cada trampa (crear o actualizar)
      foreach ($trampasRecibidas as $index => $trampaData) {
        $data = [
          'almacen_id'     => $validated['almacen_id'],
          'trampa_tipo_id' => $trampaData['trampa_tipo_id'],
          'posx'           => round($trampaData['posx']),
          'posy'           => round($trampaData['posy']),
          'estado'         => $trampaData['estado'] ?? 'activo',
          'numero'         => $trampaData['numero'] ?? ($index + 1),
        ];

        if (!empty($trampaData['id'])) {
          $mapa->trampas()->where('id', $trampaData['id'])->update($data);
        } else {
          $mapa->trampas()->create($data);
        }
      }

      DB::commit();

      return response()->json([
        'message' => 'Mapa actualizado correctamente',
        'mapa' => $mapa->fresh(['trampas']),
      ]);
    } catch (\Exception $e) {
      DB::rollBack();
      return response()->json([
        'message' => 'Error al actualizar el mapa',
        'error' => $e->getMessage(),
      ], 500);
    }
  }

  public function destroy(string $id) {}
}
