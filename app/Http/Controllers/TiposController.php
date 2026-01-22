<?php

namespace App\Http\Controllers;

use App\Models\TipoSeguimiento;
use Illuminate\Http\Request;

class TiposController extends Controller
{
  public function index()
  {
    $tipos = TipoSeguimiento::select('id', 'nombre')->paginate(20);
    return inertia('admin/tipos/index', ['items' => $tipos]);
  }

  public function create()
  {
    return inertia('admin/tipos/crear', ['epp' => new TipoSeguimiento()]);
  }

  public function store(Request $request)
  {
    $validated = $request->validate(['nombre' => ['required', 'string', 'max:255']]);
    TipoSeguimiento::create($validated);
    return redirect()->route('tipos.index');
  }



  public function edit(string $id)
  {
    $tipo = TipoSeguimiento::find($id);
    return inertia('admin/tipos/editar', ['tipo' => $tipo]);
  }

  public function update(Request $request, string $id)
  {
    $validated = $request->validate(['nombre' => ['required', 'string', 'max:255']]);
    $tipo = TipoSeguimiento::find($id);
    $tipo->update($validated);
    return redirect()->route('tipos.index');
  }

  public function destroy(string $id)
  {
    $tipo = TipoSeguimiento::find($id);
    $tipo->delete();
    return redirect()->route('tipos.index');
  }

  /** FUNCIONES NO USADAS */

  public function show(string $id) {}
}
