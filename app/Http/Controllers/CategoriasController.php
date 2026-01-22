<?php

namespace App\Http\Controllers;

use App\Models\Categoria;
use Illuminate\Http\Request;

class CategoriasController extends Controller
{
  public function index()
  {
    $categorias = Categoria::paginate(10);
    return inertia('admin/categorias/index', ['items' => $categorias]);
  }

  public function create() {}

  public function store(Request $request)
  {
    $validated = $request->validate([
      'nombre' => 'required',
    ]);
    Categoria::create($validated);
    return redirect()->route('categorias.index');
  }

  public function show(string $id) {}

  public function edit(Categoria $categoria) {}

  public function update(Request $request, Categoria $categoria)
  {
    $validated = $request->validate([
      'nombre' => 'required',

    ]);
    $categoria->update($validated);
    return redirect()->route('categorias.index');
  }

  public function destroy(string $id)
  {
    Categoria::find($id)->delete();
    return redirect()->route('categorias.index');
  }
}