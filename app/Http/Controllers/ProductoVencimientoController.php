<?php

namespace App\Http\Controllers;

use App\Models\Producto;
use App\Models\ProductoVencimiento;
use Illuminate\Http\Request;
use Inertia\Inertia;

class ProductoVencimientoController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Producto $producto)
    {
        $vencimientos = $producto->vencimientos()
            ->latest('vencimiento')  // ordenar por fecha de vencimiento más reciente primero
            ->get()
            ->map(function ($item) {
                return [
                    'id'          => $item->id,
                    'codigo'      => $item->codigo,
                    // 'vencimiento' => $item->vencimiento->format('Y-m-d'),
                    'vencimiento' => $item->vencimiento,
                    // opcional: puedes agregar más campos útiles
                    // 'dias_restantes' => now()->diffInDays($item->vencimiento, false),
                ];
            });

        // return Inertia::render('Productos/Index', [
        //     'vencimientos' => $vencimientos,
        // ]);
        return inertia('admin/productos/lista', [
            'vencimientos' => $vencimientos,
        ]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request, Producto $producto)
    {
        $validated = $request->validate([
            'codigo'      => 'required|string|max:50',
            'vencimiento' => 'required|date|after_or_equal:today',
        ]);

        $producto->vencimientos()->create($validated);

        return back()->with('success', 'Fecha de vencimiento registrada correctamente');
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
    public function destroy(Producto $producto, ProductoVencimiento $vencimiento)
    {
        // Seguridad adicional: verificar que pertenece al producto
        if ($vencimiento->producto_id !== $producto->id) {
            abort(403);
        }

        $vencimiento->delete();

        return back()->with('success', 'Vencimiento eliminado');
    }
}