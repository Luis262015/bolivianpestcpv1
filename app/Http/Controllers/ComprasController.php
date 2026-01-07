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

    // dd($request);

    $validated = $request->validate([
      'proveedor_id' => 'nullable|exists:proveedores,id',
      'total' => 'required|numeric',
      // 'numero' => 'required|string|max:20',
      // 'autorizacion' => 'required|string|size:10',
      // 'control' => 'required|string',
      // 'observaciones' => 'required|string',
      // 'abonado' => 'required|numeric|min:0',
      'items' => 'required|array|min:1',
      'items.*.producto_id' => 'required|exists:productos,id',
      'items.*.cantidad' => 'required|numeric|min:1',
      'items.*.costo_unitario' => 'required|numeric',
      'items.*.precio_venta' => 'required|numeric',
    ]);

    // dd($validated);

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

        $producto->update([
          'stock' => $producto->stock + $item['cantidad'],
          'precio_compra' => $item['costo_unitario'],
          'precio_venta' => $item['precio_venta'],
        ]);

        // Registro de kardex
        Kardex::create([
          // 'tienda_id' => session('tienda_id'),
          'venta_id' => null,
          'compra_id' => $compra->id,
          'producto_id' => $producto->id,
          'tipo' => 'Entrada',
          'cantidad' => $item['cantidad'],
          'cantidad_saldo' => $producto->stock + $item['cantidad'],
          'costo_unitario' => $item['costo_unitario'],
        ]);
      }

      // Registro de cuenta por pagar, si es necesario
      // if ($validated['abonado'] < $total) {
      //   // Guardar cuenta por pagar
      //   CuentaPagar::create([
      //     'compra_id' =>  $compra->id,
      //     'proveedor_id' => $validated['proveedor_id'],
      //     'user_id' => Auth::id(),
      //     'total' => $total,
      //     'a_cuenta' => $validated['abonado'],
      //     'saldo' => $total - $validated['abonado'],
      //     'estado' => 'Pendiente',
      //     'fecha_pago' => Carbon::now(),
      //   ]);
      // }

      DB::commit();

      return redirect()->back()->with('success', "Compra guardada correctamente. Total: \${$validated['total']}");
    } catch (\Exception $e) {
      DB::rollBack();
      Log::error('Error al guardar compra:', ['error' => $e->getMessage()]);

      return redirect()->back()
        ->withInput()
        ->with('error', 'Error al guardar la compra: ' . $e->getMessage());
    }
  }

  public function show(string $id) {}

  public function edit(string $id) {}

  public function update(Request $request, string $id) {}

  public function destroy(string $id) {}
}
