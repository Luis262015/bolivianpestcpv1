<?php

namespace App\Http\Controllers;

use App\Models\CuentaCobrar;
use Illuminate\Http\Request;

class CuentasPorCobrarController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
        $cuentascobrar = CuentaCobrar::select('id', 'venta_id', 'cliente_id', 'total', 'a_cuenta', 'saldo', 'estado', 'fecha_pago')
            ->with(['cliente' => function ($query) {
                $query->select('id', 'nombre');
            }])
            ->paginate(20);
        return inertia('admin/cuentasporcobrar/lista', ['cuentascobrar' =>  $cuentascobrar]);
        // return inertia('admin/cuentasporcobrar/lista');
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
    public function store(Request $request)
    {
        //
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
