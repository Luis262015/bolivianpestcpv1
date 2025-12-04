<?php

namespace App\Http\Controllers;

use App\Models\Almacen;
use App\Models\Biologico;
use App\Models\Empresa;
use App\Models\Epp;
use App\Models\Metodo;
use App\Models\Proteccion;
use App\Models\Seguimiento;
use App\Models\Signo;
use Illuminate\Http\Request;

class SeguimientoController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
        // $empresaId = $request->query('empresa_id');
        // $query = Seguimiento::with(['empresa', 'user']);
        // if ($empresaId) {
        //     $query->where('empresa_id', $empresaId);
        // }
        // $seguimientos = $query->latest()->get();
        // $empresas = Empresa::select('id', 'nombre')->orderBy('nombre')->get();
        // return inertia('admin/seguimientos/lista', [
        //     'seguimientos' => $seguimientos,
        //     'empresas' => $empresas,
        //     'empresaSeleccionado' => $empresaId,
        // ]);

        $empresas = Empresa::select('id', 'nombre')->get();
        $almacenes = Almacen::select('id', 'nombre')->get();
        $biologicos = Biologico::orderBy('nombre')->get();
        $epps = Epp::orderBy('nombre')->get();
        $metodos = Metodo::orderBy('nombre')->get();
        $protecciones = Proteccion::orderBy('nombre')->get();
        $signos = Signo::orderBy('nombre')->get();

        return inertia('admin/seguimientos/lista', [
            'empresas' => $empresas,
            'almacenes' => $almacenes,
            'biologicos' => $biologicos,
            'epps' => $epps,
            'metodos' => $metodos,
            'protecciones' => $protecciones,
            'signos' => $signos,
        ]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
        $empresas = Empresa::select('id', 'nombre')->get();
        $almacenes = Almacen::select('id', 'nombre')->get();
        $biologicos = Biologico::orderBy('nombre')->get();
        $epps = Epp::orderBy('nombre')->get();
        $metodos = Metodo::orderBy('nombre')->get();
        $protecciones = Proteccion::orderBy('nombre')->get();
        $signos = Signo::orderBy('nombre')->get();

        return inertia('admin/seguimientos/crear', [
            'empresas' => $empresas,
            'almacenes' => $almacenes,
            'biologicos' => $biologicos,
            'epps' => $epps,
            'metodos' => $metodos,
            'protecciones' => $protecciones,
            'signos' => $signos,
        ]);

        // return inertia('admin/seguimientos/crear');
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
