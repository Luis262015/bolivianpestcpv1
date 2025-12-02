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
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
        $compras = Compra::with(['tienda', 'proveedor', 'detalles.producto'])
            ->paginate(20);
        return inertia('admin/compras/lista', ['compras' => $compras]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
        $proveedores = Proveedor::all()->map(fn($p) => [
            'value' => $p->id,
            'label' => $p->razon_social
        ]);
        return inertia('admin/compras/crear', ['compra' => new Compra(), 'proveedores' => $proveedores]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
        $validated = $request->validate([
            'proveedor_id' => 'required|exists:proveedores,id',
            'numero' => 'required|string|max:20',
            'autorizacion' => 'required|string|size:10',
            'control' => 'required|string',
            'observaciones' => 'required|string',
            'abonado' => 'required|numeric|min:0',
            'items' => 'required|array|min:1',
            'items.*.producto_id' => 'required|exists:productos,id',
            'items.*.cantidad' => 'required|numeric|min:1',
            'items.*.costo_unitario' => 'required|numeric',
            'items.*.precio_venta' => 'required|numeric',
        ]);

        // dd($validated);

        try {
            DB::beginTransaction();

            // Calcular total
            $total = collect($validated['items'])->sum(function ($item) {
                return $item['cantidad'] * $item['costo_unitario'];
            });

            // Crear compra
            $compra = Compra::create([
                'user_id' => Auth::id(),
                'proveedor_id' => $validated['proveedor_id'],
                'numero' => $validated['numero'],
                'autorizacion' => $validated['autorizacion'],
                'control' => $validated['control'],
                'observaciones' => $validated['observaciones'],
                'total' => $total,
                'abonado' => $validated['abonado'],
                'saldo' => $total - $validated['abonado'],
                'tipo' => 'Compra',
            ]);

            // Guardar detalles
            foreach ($validated['items'] as $item) {
                $costoTotal = $item['cantidad'] * $item['costo_unitario'];

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
            if ($validated['abonado'] < $total) {
                // Guardar cuenta por pagar
                CuentaPagar::create([
                    'compra_id' =>  $compra->id,
                    'proveedor_id' => $producto->id,
                    'user_id' => Auth::id(),
                    'total' => $total,
                    'a_cuenta' => $validated['abonado'],
                    'saldo' => $total - $validated['abonado'],
                    'estado' => 'Pendiente',
                    'fecha_pago' => Carbon::now(),
                ]);
            }

            DB::commit();

            return redirect()->back()->with('success', "Compra guardada correctamente. Total: \${$total}");
        } catch (\Exception $e) {
            DB::rollBack();
            Log::error('Error al guardar compra:', ['error' => $e->getMessage()]);

            return redirect()->back()
                ->withInput()
                ->with('error', 'Error al guardar la compra: ' . $e->getMessage());
        }
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
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }
}
