<?php

namespace App\Http\Controllers;

use App\Models\Compra;
use App\Models\CompraDetalle;
use App\Models\CuentaPagar;
use App\Models\Kardex;
use App\Models\Producto;
use App\Models\Proveedor;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;
use Illuminate\Database\QueryException;
use Carbon\Carbon;

class ComprasController extends Controller
{
  public function index()
  {
    $compras = Compra::with(['proveedor', 'detalles.producto'])
      ->paginate(20);
    return inertia('admin/compras/lista', ['compras' => $compras]);
  }

  public function create()
  {
    $proveedores = Proveedor::all()->map(fn($p) => [
      'id' => $p->id,
      'nombre' => $p->nombre
    ]);
    return inertia('admin/compras/crear', ['compra' => new Compra(), 'proveedores' => $proveedores]);
  }

  public function store(Request $request)
  {
    $validated = $request->validate([
      'proveedor_id' => 'nullable|exists:proveedores,id',
      'total' => 'required|numeric',
      'items' => 'required|array|min:1',
      'items.*.producto_id' => 'required|exists:productos,id',
      'items.*.cantidad' => 'required|numeric|min:1',
      'items.*.costo_unitario' => 'required|numeric',
      'items.*.precio_venta' => 'required|numeric',
    ]);

    try {
      DB::beginTransaction();
      // Crear compra
      $compra = Compra::create([
        'user_id' => Auth::id(),
        'proveedor_id' => $validated['proveedor_id'],
        'observaciones' => '',
        'total' => $validated['total'],
        'tipo' => 'Compra',
      ]);

      // Guardar detalles
      foreach ($validated['items'] as $item) {
        // $costoTotal = $item['cantidad'] * $item['costo_unitario'];

        CompraDetalle::create([
          'compra_id' => $compra->id,
          'producto_id' => $item['producto_id'],
          'cantidad' => $item['cantidad'],
          'precio_compra' => $item['costo_unitario'],
          'precio_venta' => $item['precio_venta'],
          'descripcion' => '',
        ]);

        // Opcional: Actualizar precio_compra y precio_venta del producto
        // $producto = Producto::where('producto_id', $item['producto_id'])
        //     ->where('tienda_id', session('tienda_id'))
        //     ->first();
        $producto = Producto::find($item['producto_id']);
        $stock_producto = $producto->stock;

        $producto->update([
          'stock' => $producto->stock + $item['cantidad'],
          'precio_compra' => $item['costo_unitario'],
          'precio_venta' => $item['precio_venta'],
        ]);

        // Registro de kardex
        Kardex::create([
          'venta_id' => null,
          'compra_id' => $compra->id,
          'producto_id' => $producto->id,
          'tipo' => 'Entrada',
          'cantidad' => $item['cantidad'],
          'cantidad_saldo' => $stock_producto + $item['cantidad'],
          'costo_unitario' => $item['costo_unitario'],
        ]);
      }

      DB::commit();

      // return redirect()->back()->with('success', "Compra guardada correctamente. Total: \${$validated['total']}");
      return redirect()->route('compras.index')->with('success', "Compra guardada correctamente. Total: \${$validated['total']}");
    } catch (\Exception | \Error | QueryException $e) {
      DB::rollBack();
      Log::error('Error al guardar compra:', ['error' => $e->getMessage()]);

      return redirect()->back()
        ->withInput()
        ->with('error', 'Error al guardar la compra: ' . $e->getMessage());
    }
  }

  public function destroy(string $id)
  {

    try {
      DB::beginTransaction();
      $compra = Compra::find($id);
      // Conseguir compra detalles
      $compradetalles = CompraDetalle::where('compra_id', $id)->get();

      // dd($compradetalles);

      foreach ($compradetalles as $detalle) {
        // Actualizacion de stock de producto
        $producto = Producto::find($detalle['producto_id']);
        $producto->stock = $producto->stock - $detalle['cantidad'];
        $producto->update();
      }

      // Eliminar Kardex
      Kardex::where('compra_id', $id)->delete();

      // Eliminar Compra Detalles
      CompraDetalle::where('compra_id', $id)->delete();

      // Eliminar compra
      $compra->delete();

      DB::commit();

      return redirect()->route('compras.index')->with('success', "Compra eliminada correctamente.");
    } catch (\Exception | \Error | QueryException $e) {
      DB::rollBack();
      Log::error('Error al eliminar compra:', ['error' => $e->getMessage()]);

      return redirect()->back()
        ->withInput()
        ->with('error', 'Error al eliminar la compra: ' . $e->getMessage());
    }
  }

  /** FUNCIONES NO USADAS */
  public function show(string $id) {}

  public function edit(string $id) {}

  public function update(Request $request, string $id) {}
}
