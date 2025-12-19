<?php

namespace App\Http\Controllers;

use App\Models\Unidad;
use Illuminate\Http\Request;

class UnidadesController extends Controller
{
  public function index()
  {
    $unidades = Unidad::select('id', 'nombre')->paginate(20);
    return inertia('admin/unidades/index', ['items' => $unidades]);
  }

  public function create() {}


  public function store(Request $request)
  {
    $validated = $request->validate(['nombre' => ['required', 'string', 'max:255'],]);
    Unidad::create($validated);
    return redirect()->route('unidades.index');
  }

  public function show(string $id) {}

  public function edit(string $id) {}

  public function update(Request $request, string $id)
  {
    $validated = $request->validate(['nombre' => ['required', 'string', 'max:255'],]);
    $unidad = Unidad::find($id);
    $unidad->update($validated);
    return redirect()->route('unidades.index');
  }

  public function destroy(string $id)
  {
    $metodo = Unidad::find($id);
    $metodo->delete();
    return redirect()->route('unidades.index');
  }
}