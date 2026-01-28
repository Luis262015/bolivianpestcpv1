<?php

namespace App\Http\Controllers;

use App\Models\Proteccion;
use Illuminate\Http\Request;

class ProteccionesController extends Controller
{
  public function index()
  {
    $protecciones = Proteccion::select('id', 'nombre')->paginate(20);
    return inertia('admin/protecciones/index', ['items' => $protecciones]);
  }

  public function store(Request $request)
  {
    $validated = $request->validate(['nombre' => ['required', 'string', 'max:255'],]);
    Proteccion::create($validated);
    return redirect()->route('protecciones.index');
  }

  public function update(Request $request, string $id)
  {
    $validated = $request->validate(['nombre' => ['required', 'string', 'max:255'],]);
    $proteccion = Proteccion::find($id);
    $proteccion->update($validated);
    return redirect()->route('protecciones.index');
  }

  public function destroy(string $id)
  {
    $proteccion = Proteccion::find($id);
    $proteccion->delete();
    return redirect()->route('protecciones.index');
  }

  /** FUNCIONES NO USADAS */
  // public function create()
  // {
  //   return inertia('admin/protecciones/crear', ['proteccion' => new Proteccion()]);
  // }
  // public function edit(string $id)
  // {
  //   $proteccion = Proteccion::find($id);
  //   return inertia('admin/protecciones/editar', ['proteccion' => $proteccion]);
  // }
  // public function show(string $id) {}
}
