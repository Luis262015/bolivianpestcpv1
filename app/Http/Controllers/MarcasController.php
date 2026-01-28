<?php

namespace App\Http\Controllers;

use App\Models\Marca;
use Illuminate\Http\Request;

class MarcasController extends Controller
{

  public function index()
  {
    $marcas = Marca::paginate(10);
    return inertia('admin/marcas/index', ['items' => $marcas]);
  }

  public function store(Request $request)
  {
    $validated = $request->validate([
      'nombre' => ['required', 'string', 'max:255'],
    ]);
    Marca::create($validated);
    return redirect()->route('marcas.index');
  }

  public function update(Request $request, string $id)
  {
    $validated = $request->validate([
      'nombre' => ['required', 'string', 'max:255'],
    ]);
    $marca = Marca::find($id);
    $marca->update($validated);
    return redirect()->route('marcas.index');
  }

  public function destroy(string $id)
  {
    $marca = Marca::find($id);
    $marca->delete();
    return redirect()->route('marcas.index');
  }

  /** FUNCIONES NO USADAS */
  // public function create()
  // {
  //   return inertia('admin/marcas/crear');
  // }
  // public function edit(Marca $marca)
  // {
  //   return inertia('admin/marcas/editar', ['marca' => $marca]);
  // }
  // public function show(string $id) {}
}
