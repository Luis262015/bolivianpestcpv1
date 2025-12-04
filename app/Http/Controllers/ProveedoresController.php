<?php

namespace App\Http\Controllers;

use App\Models\Proveedor;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class ProveedoresController extends Controller
{
  /**
   * Display a listing of the resource.
   */
  public function index()
  {
    //
    $proveedores = Proveedor::paginate(20);
    return inertia('admin/proveedores/lista', ['proveedores' => $proveedores]);
    // return inertia('admin/proveedores/lista');
  }

  /**
   * Show the form for creating a new resource.
   */
  public function create()
  {
    //
    return inertia('admin/proveedores/crear', ['proveedor' => new Proveedor()]);
  }

  /**
   * Store a newly created resource in storage.
   */
  public function store(Request $request)
  {
    //
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

  /**
   * Display the specified resource.
   */
  public function show(string $id)
  {
    //
  }

  /**
   * Show the form for editing the specified resource.
   */
  public function edit(string $id)
  {
    //
    $proveedor = Proveedor::find($id);
    return inertia('admin/proveedores/editar', ['proveedor' => $proveedor]);
  }

  /**
   * Update the specified resource in storage.
   */
  public function update(Request $request, string $id)
  {
    //
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

  /**
   * Remove the specified resource from storage.
   */
  public function destroy(string $id)
  {
    //
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

    // $validated = $request->validate([
    //   'nombre'     => 'required|string|max:255',
    //   'direccion'  => 'nullable|string|max:500',
    //   'telefono'   => 'nullable|string|max:20',
    //   'email'      => 'nullable|email|max:255',
    //   'contacto'   => 'nullable|string|max:255',
    // ]);

    // // Crear el proveedor
    // $proveedor = Proveedor::create($validated);

    // // Opción 1 (recomendada): Flash simple + redirect back
    // return back()->with('flash', [
    //   'proveedor' => [
    //     'id'     => $proveedor->id,
    //     'nombre' => $proveedor->nombre,
    //   ]
    // ]);
  }
}
