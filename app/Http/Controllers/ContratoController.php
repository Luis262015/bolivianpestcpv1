<?php

namespace App\Http\Controllers;

use App\Models\Almacen;
use App\Models\Contrato;
use App\Models\CuentaCobrar;
use App\Models\Empresa;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class ContratoController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
        $contratos = Contrato::with('detalles')->get();
        return inertia('admin/contrato/lista', ['contratos' => $contratos]);
        // return inertia('admin/contrato/lista');
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
        return inertia('admin/contrato/crear');
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
            'almacen' => 'required|string|max:100',
            'total' => 'required|numeric|min:0',
            'acuenta' => 'required|numeric|min:0',
            'saldo' => 'required|numeric|min:0',
            'detalles' => 'required|array|min:1',
            'detalles.*.descripcion' => 'required|string',
            'detalles.*.area' => 'required|numeric|min:0',
            'detalles.*.precio_unitario' => 'required|numeric|min:0',
            'detalles.*.total' => 'required|numeric|min:0',
        ]);

        // Extraer solo los campos que pertenecen a cotizaciones
        $cotizacionData = [
            'nombre' => $validated['nombre'],
            'direccion' => $validated['direccion'],
            'telefono' => $validated['telefono'],
            'email' => $validated['email'],
            'ciudad' => $validated['ciudad'],
            'almacen' => $validated['almacen'],
            'total' => $validated['total'],
            'acuenta' => $validated['acuenta'],
            'saldo' => $validated['saldo'],
        ];

        $cotizacion = Contrato::create($cotizacionData);

        foreach ($validated['detalles'] as $detalle) {
            $cotizacion->detalles()->create($detalle);
        }

        // CREAR EMPRESA
        $empresa = new Empresa();
        $empresa->nombre = $validated['nombre'];
        $empresa->direccion = $validated['direccion'];
        $empresa->telefono = $validated['telefono'];
        $empresa->email = $validated['email'];
        $empresa->ciudad = $validated['ciudad'];
        $empresa->almacen = $validated['almacen'];
        $empresa->activo = true;
        $empresa->save();

        // CREAR ALMACEN
        $almacen = new Almacen();
        $almacen->nombre = $validated['nombre'];
        $almacen->direccion = $validated['direccion'];
        $almacen->telefono = $validated['telefono'];
        $almacen->email = $validated['email'];
        $almacen->ciudad = $validated['ciudad'];
        $almacen->empresa_id = $empresa->id;
        $almacen->save();



        if ($validated['saldo'] > 0) {
            $cuentacobrar = new CuentaCobrar();
            $cuentacobrar->contrato_id = $cotizacion->id;
            $cuentacobrar->user_id = Auth::id();
            $cuentacobrar->total = $validated['total'];
            $cuentacobrar->a_cuenta = $validated['acuenta'];
            $cuentacobrar->saldo = $validated['saldo'];
            $cuentacobrar->estado = 'Pendiente';
            $cuentacobrar->save();
        }

        return redirect()->route('contratos.index');
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
        //
        // dd("vlksdnvlnsl " . $id);
        $cotizacion = Contrato::with('detalles')->findOrFail($id);
        // dd("vksdbvjks " . $cotizacion);
        // $cotizacion->load('detalles');
        return inertia('admin/contrato/crear', ['cotizacion' => $cotizacion]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
        $cotizacion = Contrato::with('detalles')->findOrFail($id);
        //
        $validated = $request->validate([
            'nombre' => 'required|string|max:255',
            'direccion' => 'required|string|max:255',
            'telefono' => 'required|string|max:20',
            'email' => 'required|email',
            'ciudad' => 'required|string|max:100',
            'detalles' => 'required|array|min:1',
            'detalles.*.id' => 'sometimes|exists:contrato_detalles,id', // Para editar existentes
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

        return redirect()->route('contratos.index');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Contrato $contrato)
    {
        //
        $contrato->delete();
        return redirect()->route('contratos.index');
    }
}
