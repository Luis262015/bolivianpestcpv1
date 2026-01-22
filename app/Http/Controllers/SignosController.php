<?php

namespace App\Http\Controllers;

use App\Models\Signo;
use Illuminate\Http\Request;

class SignosController extends Controller
{
  public function index()
  {
    $signos = Signo::select('id', 'nombre')->paginate(20);
    return inertia('admin/signos/index', ['items' => $signos]);
  }

  public function create()
  {
    return inertia('admin/signos/crear', ['signos' => new Signo()]);
  }

  public function store(Request $request)
  {
    $validated = $request->validate(['nombre' => ['required', 'string', 'max:255'],]);
    Signo::create($validated);
    return redirect()->route('signos.index');
  }



  public function edit(string $id)
  {
    $signo = Signo::find($id);
    return inertia('admin/signos/editar', ['signo' => $signo]);
  }

  public function update(Request $request, string $id)
  {
    $validated = $request->validate(['nombre' => ['required', 'string', 'max:255'],]);
    $signo = Signo::find($id);
    $signo->update($validated);
    return redirect()->route('signos.index');
  }

  public function destroy(string $id)
  {
    $signo = Signo::find($id);
    $signo->delete();
    return redirect()->route('signos.index');
  }

  /** FUNCIONES NO USADAS */
  public function show(string $id) {}
}
