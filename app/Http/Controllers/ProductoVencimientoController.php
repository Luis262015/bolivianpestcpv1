<?php

namespace App\Http\Controllers;

use App\Models\Producto;
use App\Models\ProductoVencimiento;
use Illuminate\Http\Request;
use Inertia\Inertia;

class ProductoVencimientoController extends Controller
{
  public function index(Producto $producto)
  {
    $vencimientos = $producto->vencimientos()
      ->latest('vencimiento')  // ordenar por fecha de vencimiento más reciente primero
      ->get()
      ->map(function ($item) {
        return [
          'id'          => $item->id,
          'codigo'      => $item->codigo,
          'vencimiento' => $item->vencimiento,
        ];
      });
    return inertia('admin/productos/lista', [
      'vencimientos' => $vencimientos,
    ]);
  }

  public function store(Request $request, Producto $producto)
  {
    $validated = $request->validate([
      'codigo'      => 'required|string|max:50',
      'vencimiento' => 'required|date|after_or_equal:today',
    ]);
    $producto->vencimientos()->create($validated);
    // Redirección simple - Inertia la manejará correctamente
    return redirect('/productos')
      ->with('success', 'Vencimiento registrado correctamente');
  }

  public function destroy(Producto $producto, ProductoVencimiento $vencimiento)
  {
    // Seguridad adicional: verificar que pertenece al producto
    if ($vencimiento->producto_id !== $producto->id) {
      abort(403);
    }

    $vencimiento->delete();

    return redirect('/productos')
      ->with('success', 'Vencimiento registrado correctamente');
  }

  /** FUNCIONES NO USADAS */
  // public function create() {}
  // public function show(string $id) {}
  // public function edit(string $id) {}
  // public function update(Request $request, string $id) {}
}
