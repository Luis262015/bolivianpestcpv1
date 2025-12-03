<?php

namespace App\Http\Controllers;

use App\Models\TipoSeguimiento;
use Illuminate\Http\Request;

class TiposController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
        $tipos = TipoSeguimiento::select('id', 'nombre', 'descripcion')->paginate(20);
        return inertia('admin/tipos/lista', ['tipos' => $tipos]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
        return inertia('admin/tipos/crear', ['epp' => new TipoSeguimiento()]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
        $validated = $request->validate(['nombre' => ['required', 'string', 'max:255'], 'descripcion' => ['nullable', 'string', 'max:255']]);

        TipoSeguimiento::create($validated);

        return redirect()->route('tipos.index');
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
        $tipo = TipoSeguimiento::find($id);
        return inertia('admin/tipos/editar', ['tipo' => $tipo]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
        $validated = $request->validate(['nombre' => ['required', 'string', 'max:255'], 'descripcion' => ['nullable', 'string', 'max:255']]);

        $tipo = TipoSeguimiento::find($id);
        $tipo->update($validated);

        return redirect()->route('tipos.index');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
        $tipo = TipoSeguimiento::find($id);
        $tipo->delete();

        return redirect()->route('tipos.index');
    }
}
