<?php

namespace App\Http\Controllers;

use App\Models\Especie;
use Illuminate\Http\Request;

class EspeciesController extends Controller
{
  public function index()
  {
    $especies = Especie::select('id', 'nombre')->paginate(20);
    return inertia('admin/especies/index', ['items' => $especies]);
  }

  public function create() {}

  public function store(Request $request)
  {
    $validated = $request->validate(['nombre' => ['required', 'string', 'max:255'],]);
    Especie::create($validated);
    return redirect()->route('especies.index');
  }

  public function show(string $id) {}

  public function edit(string $id) {}

  public function update(Request $request, string $id)
  {
    $validated = $request->validate(['nombre' => ['required', 'string', 'max:255'],]);
    $signo = Especie::find($id);
    $signo->update($validated);
    return redirect()->route('especies.index');
  }

  public function destroy(string $id)
  {
    $metodo = Especie::find($id);
    $metodo->delete();
    return redirect()->route('especies.index');
  }
}