<?php

namespace App\Http\Controllers;

use App\Models\Proveedor;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class ProveedoresController extends Controller
{
  public function index()
  {
    $proveedores = Proveedor::paginate(20);
    return inertia('admin/proveedores/index', ['items' => $proveedores]);
  }

  public function create()
  {
    return inertia('admin/proveedores/crear', ['proveedor' => new Proveedor()]);
  }

  public function store(Request $request)
  {
    $validate = $request->validate(
      [
        'nombre' => ['required', 'string', 'max:255'],
        'direccion' => ['nullable', 'string', 'max:255'],
        'telefono' => ['required', 'string', 'max:255'],
        'email' => ['nullable', 'string', 'max:255'],
        'contacto' => ['required', 'string', 'max:255'],
      ]
    );
    Proveedor::create($validate);
    return redirect()->route('proveedores.index');
  }

  public function show(string $id) {}

  public function edit(string $id)
  {
    $proveedor = Proveedor::find($id);
    return inertia('admin/proveedores/editar', ['proveedor' => $proveedor]);
  }

  public function update(Request $request, string $id)
  {
    $validated = $request->validate([
      'nombre' => ['required', 'string', 'max:255'],
      'direccion' => ['nullable', 'string', 'max:255'],
      'telefono' => ['required', 'string', 'max:255'],
      'email' => ['nullable', 'string', 'max:255'],
      'contacto' => ['required', 'string', 'max:255'],
    ]);
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

  public function storeModal(Request $request)
  {
    $validated = $request->validate([
      'nombre' => ['required', 'string', 'max:255'],
      'direccion' => ['nullable', 'string', 'max:255'],
      'telefono' => ['required', 'string', 'max:255'],
      'email' => ['nullable', 'string', 'max:255'],
      'contacto' => ['required', 'string', 'max:255'],
    ]);
    $proveedor = Proveedor::create($validated);
    // Cargamos TODOS los proveedores actualizados
    $proveedores = Proveedor::all(['id', 'nombre'])->map(function ($p) {
      return [
        'id' => $p->id,
        'nombre' => $p->nombre,
      ];
    });
    // Devolvemos solo los datos necesarios (sin redirección completa)
    return back()->with([
      'proveedor' => $proveedor,           // 👈 ESTE ES EL QUE FALTABA
      'proveedor_nuevo_id' => $proveedor->id,   // ← Para seleccionarlo automáticamente
      'proveedores' => $proveedores,           // ← Esto actualiza el select
      'success' => 'Proveedor creado correctamente',
    ]);
  }
}