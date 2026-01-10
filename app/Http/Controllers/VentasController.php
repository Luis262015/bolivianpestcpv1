<?php

namespace App\Http\Controllers;

use App\Models\Kardex;
use App\Models\Producto;
use App\Models\Venta;
use App\Models\VentaDetalle;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class VentasController extends Controller
{
  public function index()
  {
    $ventas = Venta::with(['cliente', 'detalles.producto'])->paginate(20);
    return inertia('admin/ventas/index', ['ventas' => $ventas]);
  }

  public function create()
  {
    return inertia('admin/ventas/crear');
  }

  public function store(Request $request)
  {
    // dd($request);

    $validated = $request->validate([
      'cliente_id' => 'nullable|exists:clientes.id',
      'metodo_pago' => 'required|string',
      'total' => 'required|numeric',
      'items' => 'required|array|min:1',
      'items.*.producto_id' => 'required|exists:productos,id',
      'items.*.cantidad' => 'required|numeric|min:1',
      'items.*.precio_unitario' => 'required|numeric',
    ]);

    // dd($validated);


    try {
      DB::beginTransaction();
      // Crear venta
      $venta = Venta::create([
        'user_id' => Auth::id(),
        'cliente_id' => $validated['cliente_id'] ?? null,
        'total' => $validated['total'],
        'tipo' => 'Venta',
        'metodo' => $validated['metodo_pago'],
        // 'observaciones' => '',
      ]);

      foreach ($validated['items'] as $item) {
        VentaDetalle::create([
          'venta_id' => $venta->id,
          'producto_id' => $item['producto_id'],
          'precio_venta' => $item['precio_unitario'],
          'cantidad' => $item['cantidad'],
          'total' => $item['precio_unitario'] * $item['cantidad'],
        ]);

        $producto = Producto::find($item['producto_id']);

        $producto_stock = $producto->stock;

        $producto->update([
          'stock' => $producto->stock - $item['cantidad'],
        ]);

        Kardex::create([
          // 'tienda_id' => session('tienda_id'),
          'venta_id' => $venta->id,
          'compra_id' => null,
          'producto_id' => $producto->id,
          'tipo' => 'Salida',
          'cantidad' => $item['cantidad'],
          'cantidad_saldo' => $producto_stock - $item['cantidad'],
          'costo_unitario' => $item['precio_unitario'],
        ]);
      }

      DB::commit();

      return redirect()->back()->with('success', "Venta guardada correctamente. Total: \${$validated['total']}");
    } catch (\Exception $e) {
      DB::rollBack();
      Log::error('Error al guardar venta:', ['error' => $e->getMessage()]);
      return redirect()->back()
        ->withInput()
        ->with('error', 'Error al guardar la venta: ' . $e->getMessage());
    }
  }

  public function show(string $id) {}

  public function edit(string $id) {}

  public function update(Request $request, string $id) {}

  public function destroy(string $id) {}
}
