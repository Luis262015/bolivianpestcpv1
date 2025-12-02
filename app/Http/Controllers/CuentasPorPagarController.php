<?php

namespace App\Http\Controllers;

use App\Models\CuentaPagar;
use Illuminate\Http\Request;

class CuentasPorPagarController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
        $cuentaspagar = CuentaPagar::select()->with(['proveedor' => function ($query) {
            $query->select('id', 'nombre');
        }])->paginate(20);
        return inertia('admin/cuentasporpagar/lista', ['cuentaspagar' => $cuentaspagar]);
        // return inertia('admin/cuentasporpagar/lista');
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
