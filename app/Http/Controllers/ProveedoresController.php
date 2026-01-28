<?php

namespace App\Http\Controllers;

use App\Models\Proveedor;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class ProveedoresController extends Controller
{
  private $validated = [
    'nombre' => ['required', 'string', 'max:255'],
    'direccion' => ['nullable', 'string', 'max:255'],
    'telefono' => ['required', 'string', 'max:255'],
    'email' => ['nullable', 'string', 'max:255'],
    'contacto' => ['required', 'string', 'max:255'],
  ];

  public function index()
  {
    $proveedores = Proveedor::paginate(20);
    return inertia('admin/proveedores/index', ['items' => $proveedores]);
  }

  public function store(Request $request)
  {
    $validate = $request->validate($this->validated);
    Proveedor::create($validate);
    return redirect()->route('proveedores.index');
  }

  public function update(Request $request, string $id)
  {
    $validated = $request->validate($this->validated);
    $proveedor = Proveedor::find($id);
    $proveedor->update($validated);
    return redirect()->route('proveedores.index');
  }

  public function destroy(string $id)
  {
    $proveedor = Proveedor::find($id);
    $proveedor->delete();
    return redirect()->route('proveedores.index');
  }

  /** FUNCIONES NO USADAS */
  // public function create()
  // {
  //   return inertia('admin/proveedores/crear', ['proveedor' => new Proveedor()]);
  // }
  // public function edit(string $id)
  // {
  //   $proveedor = Proveedor::find($id);
  //   return inertia('admin/proveedores/editar', ['proveedor' => $proveedor]);
  // }
  // public function show(string $id) {}
  // public function storeModal(Request $request)
  // {
  //   $validated = $request->validate([
  //     'nombre' => ['required', 'string', 'max:255'],
  //     'direccion' => ['nullable', 'string', 'max:255'],
  //     'telefono' => ['required', 'string', 'max:255'],
  //     'email' => ['nullable', 'string', 'max:255'],
  //     'contacto' => ['required', 'string', 'max:255'],
  //   ]);
  //   $proveedor = Proveedor::create($validated);
  //   return response()->json($proveedor);
  // }
}
