<?php

namespace App\Http\Controllers;

use App\Models\Metodo;
use Illuminate\Http\Request;

class MetodosController extends Controller
{
  public function index()
  {
    $metodos = Metodo::select('id', 'nombre')->paginate(20);
    return inertia('admin/metodos/index', ['items' => $metodos]);
  }

  public function store(Request $request)
  {
    $validated = $request->validate(['nombre' => ['required', 'string', 'max:255'],]);
    Metodo::create($validated);
    return redirect()->route('metodos.index');
  }

  public function update(Request $request, string $id)
  {
    $validated = $request->validate(['nombre' => ['required', 'string', 'max:255'],]);
    $metodo = Metodo::find($id);
    $metodo->update($validated);
    return redirect()->route('metodos.index');
  }

  public function destroy(string $id)
  {
    $metodo = Metodo::find($id);
    $metodo->delete();
    return redirect()->route('metodos.index');
  }

  /** FUNCIONES NO USADAS */
  // public function create()
  // {
  //   return inertia('admin/metodos/crear', ['metodo' => new Metodo()]);
  // }
  // public function edit(string $id)
  // {
  //   $metodo = Metodo::find($id);
  //   return inertia('admin/metodos/editar', ['metodo' => $metodo]);
  // }
  // public function show(string $id) {}
}
