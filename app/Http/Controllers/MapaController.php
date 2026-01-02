<?php

namespace App\Http\Controllers;

use App\Models\Almacen;
use App\Models\Empresa;
use App\Models\Mapa;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class MapaController extends Controller
{
  public function index(Request $request)
  {
    $empresas = Empresa::all();
    $allAlmacenes = Almacen::all();

    $selectedEmpresa = $request->input('empresa_id');
    $selectedAlmacen = $request->input('almacen_id');

    $mapa = null;

    if ($selectedAlmacen) {
      $mapaModel = Mapa::where('almacen_id', $selectedAlmacen)->first();

      if ($mapaModel) {
        $data = json_decode($mapaModel->data, true);
        $mapa = [
          'texts' => $data['texts'] ?? [],
          'traps' => $data['traps'] ?? [],
          'background' => $mapaModel->background ? Storage::url($mapaModel->background) : null,
        ];
      }
    }

    // return Inertia::render('MapaEditor');
    return inertia('admin/mapas/lista', [
      'empresas' => $empresas,
      'allAlmacenes' => $allAlmacenes,
      'selectedEmpresa' => $selectedEmpresa,
      'selectedAlmacen' => $selectedAlmacen,
      'mapa' => $mapa,
    ]);
  }

  public function create() {}

  public function store(Request $request)
  {
    $validated = $request->validate([
      'almacen_id' => 'required|exists:almacenes,id',
      'texts'      => 'nullable|array',
      'traps'      => 'nullable|array',
      'background' => 'nullable|string', // data:image/... base64
    ]);

    $mapa = Mapa::updateOrCreate(
      ['almacen_id' => $validated['almacen_id']],
      [
        'data' => json_encode([
          'texts' => $validated['texts'] ?? [],
          'traps' => $validated['traps'] ?? [],
        ])
      ]
    );

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

  public function update(Request $request, string $id) {}

  public function destroy(string $id) {}
}
