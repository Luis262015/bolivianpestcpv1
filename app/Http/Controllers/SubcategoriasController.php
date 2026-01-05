<?php

namespace App\Http\Controllers;

use App\Models\Categoria;
use App\Models\Subcategoria;
use Illuminate\Http\Request;

class SubcategoriasController extends Controller
{

  private $toValidated = [
    'nombre' => ['required', 'string', 'max:255'],
    'categoria_id' => ['required', 'integer']
  ];

  public function index()
  {
    $subcategorias = Subcategoria::with(['categoria' => function ($query) {
      $query->select('id', 'nombre');
    }])->paginate(20);
    $categorias = Categoria::select('id', 'nombre')->get();

    // dd($subcategorias);
    return inertia('admin/subcategorias/index', ['subcategorias' => $subcategorias, 'categorias' => $categorias]);
  }

  public function create()
  {
    $categorias = Categoria::all('id', 'nombre');
    return inertia('admin/subcategorias/crear', ['categorias' => $categorias]);
  }

  public function store(Request $request)
  {
    // dd($request);
    $validated = $request->validate($this->toValidated);
    // dd($validated);
    Subcategoria::create($validated);
    return redirect()->route('subcategorias.index');
  }

  public function show(string $id) {}

  public function edit(string $id)
  {
    $categorias = Categoria::all('id', 'nombre');
    $subcategoria = Subcategoria::find($id);
    return inertia('admin/subcategorias/editar', ['subcategoria' => $subcategoria, 'categorias' => $categorias]);
  }

  public function update(Request $request, string $id)
  {
    $validated = $request->validate($this->toValidated);

    $subcategoria = Subcategoria::find($id);
    $subcategoria->update($validated);
    return redirect()->route('subcategorias.index');
  }

  public function destroy(string $id)
  {
    $subcategoria = Subcategoria::find($id);
    $subcategoria->delete();
    return redirect()->route('subcategorias.index');
  }
}
