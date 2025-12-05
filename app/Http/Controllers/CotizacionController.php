<?php

namespace App\Http\Controllers;

use App\Models\Cotizacion;
use Illuminate\Http\Request;

class CotizacionController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
        $cotizaciones = Cotizacion::with('detalles')->get();
        return inertia('admin/cotizacion/lista', ['cotizaciones' => $cotizaciones]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
        return inertia('admin/cotizacion/crear');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
        $validated = $request->validate([
            'nombre' => 'required|string|max:255',
            'direccion' => 'required|string|max:255',
            'telefono' => 'required|string|max:20',
            'email' => 'required|email',
            'ciudad' => 'required|string|max:100',
            'detalles' => 'required|array|min:1',
            'detalles.*.descripcion' => 'required|string',
            'detalles.*.area' => 'required|numeric|min:0',
            'detalles.*.precio_unitario' => 'required|numeric|min:0',
            'detalles.*.total' => 'required|numeric|min:0',
        ]);

        $totalSuma = 0;
        foreach ($validated['detalles'] as $detalle) {
            $totalSuma += $detalle['total'];
        }

        // Extraer solo los campos que pertenecen a cotizaciones
        $cotizacionData = [
            'nombre' => $validated['nombre'],
            'direccion' => $validated['direccion'],
            'telefono' => $validated['telefono'],
            'email' => $validated['email'],
            'ciudad' => $validated['ciudad'],
            'total' => $totalSuma,
        ];

        $cotizacion = Cotizacion::create($cotizacionData);

        foreach ($validated['detalles'] as $detalle) {
            $cotizacion->detalles()->create($detalle);
        }

        return redirect()->route('cotizaciones.index');
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
    // public function edit(string $id)
    {
        //
        // dd("vlksdnvlnsl " . $id);
        $cotizacion = Cotizacion::with('detalles')->findOrFail($id);
        // dd("vksdbvjks " . $cotizacion);
        // $cotizacion->load('detalles');
        return inertia('admin/cotizacion/crear', ['cotizacion' => $cotizacion]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        $cotizacion = Cotizacion::with('detalles')->findOrFail($id);
        //
        $validated = $request->validate([
            'nombre' => 'required|string|max:255',
            'direccion' => 'required|string|max:255',
            'telefono' => 'required|string|max:20',
            'email' => 'required|email',
            'ciudad' => 'required|string|max:100',
            'detalles' => 'required|array|min:1',
            'detalles.*.id' => 'sometimes|exists:cotizacion_detalles,id', // Para editar existentes
            'detalles.*.descripcion' => 'required|string',
            'detalles.*.area' => 'required|numeric|min:0',
            'detalles.*.precio_unitario' => 'required|numeric|min:0',
            'detalles.*.total' => 'required|numeric|min:0',
            // 'detalles.*.area' => 'required|min:0',
            // 'detalles.*.precio_unitario' => 'required|min:0',
            // 'detalles.*.total' => 'required|min:0',
        ]);

        // Actualizar solo los campos de cotización
        $cotizacion->update([
            'nombre' => $validated['nombre'],
            'direccion' => $validated['direccion'],
            'telefono' => $validated['telefono'],
            'email' => $validated['email'],
            'ciudad' => $validated['ciudad'],
        ]);

        // Sincronizar detalles: eliminar no enviados, actualizar o crear
        $detalleIds = collect($validated['detalles'])->pluck('id')->filter();
        $cotizacion->detalles()->whereNotIn('id', $detalleIds)->delete();

        foreach ($validated['detalles'] as $detalle) {
            $cotizacion->detalles()->updateOrCreate(['id' => $detalle['id'] ?? null], $detalle);
        }

        return redirect()->route('cotizaciones.index');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Cotizacion $cotizacion)
    {
        //
        $cotizacion->delete();
        return redirect()->route('cotizaciones.index');
    }
}