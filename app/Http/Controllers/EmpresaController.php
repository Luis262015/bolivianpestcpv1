<?php

namespace App\Http\Controllers;

use App\Models\Empresa;
use Illuminate\Http\Request;

class EmpresaController extends Controller
{
  public function index()
  {
    $empresas = Empresa::paginate(10);
    return inertia('admin/empresas/lista', ['empresas' => $empresas]);
  }

  public function create()
  {
    return inertia('admin/empresas/crear');
  }

  public function store(Request $request)
  {
    $validated = $request->validate([
      'nombre' => 'required',
      'direccion' => 'required',
      'telefono' => 'nullable',
      'email' => 'required|email',
      'ciudad' => 'required',
      'activo' => 'boolean',
    ]);

    Empresa::create($validated);
    return redirect()->route('empresas.index');
  }

  public function show(string $id) {}

  public function edit(Empresa $empresa)
  {
    dd("LLEGO INFORMACION " . $empresa);
    return inertia('admin/empresas/editar', ['empresa' => $empresa]);
  }

  public function update(Request $request, Empresa $empresa)
  {
    $validated = $request->validate([
      'nombre' => 'required',
      'direccion' => 'required',
      'telefono' => 'nullable',
      'email' => 'required|email',
      'ciudad' => 'required',
      'activo' => 'boolean',
    ]);
    $empresa->update($validated);
    return redirect()->route('empresas.index');
  }

  public function destroy(string $id)
  {
    Empresa::find($id)->delete();
    return redirect()->route('empresas.index');
  }
}
