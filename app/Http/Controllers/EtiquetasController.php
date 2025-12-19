<?php

namespace App\Http\Controllers;

use App\Models\Etiqueta;
use Illuminate\Http\Request;

class EtiquetasController extends Controller
{
  public function index()
  {
    $etiquetas = Etiqueta::select('id', 'nombre')->paginate(20);
    return inertia('admin/etiquetas/index', ['items' => $etiquetas]);
  }

  public function create()
  {
    return inertia('admin/etiquetas/crear', ['cliente' => new Etiqueta()]);
  }

  public function store(Request $request)
  {
    $validated = $request->validate(['nombre' => ['required', 'string', 'max:255'],]);
    Etiqueta::create($validated);
    return redirect()->route('etiquetas.index');
  }

  public function show(string $id) {}

  public function edit(string $id)
  {
    $etiqueta = Etiqueta::find($id);
    return inertia('admin/etiquetas/editar', ['etiqueta' => $etiqueta]);
  }

  public function update(Request $request, string $id)
  {
    $validated = $request->validate(['nombre' => ['required', 'string', 'max:255'],]);
    $etiqueta = Etiqueta::find($id);
    $etiqueta->update($validated);
    return redirect()->route('etiquetas.index');
  }

  public function destroy(string $id)
  {
    $etiqueta = Etiqueta::find($id);
    $etiqueta->delete();
    return redirect()->route('etiquetas.index');
  }
}