<?php

namespace App\Http\Controllers;

use App\Models\Biologico;
use Illuminate\Http\Request;

class BiologicosController extends Controller
{
  public function index()
  {
    $biologicos = Biologico::select('id', 'nombre')->paginate(20);
    return inertia('admin/biologicos/index', ['items' => $biologicos]);
  }

  public function store(Request $request)
  {
    $validated = $request->validate(['nombre' => ['required', 'string', 'max:255'],]);
    Biologico::create($validated);
    return redirect()->route('biologicos.index');
  }

  public function update(Request $request, string $id)
  {
    $validated = $request->validate(['nombre' => ['required', 'string', 'max:255'],]);
    $biologico = Biologico::find($id);
    $biologico->update($validated);
    return redirect()->route('biologicos.index');
  }

  public function destroy(string $id)
  {
    $biologico = Biologico::find($id);
    $biologico->delete();
    return redirect()->route('biologicos.index');
  }

  /** FUNCIONES NO USADAS */
  // public function create() {}
  // public function show(string $id) {}
  // public function edit(string $id) {}
}
