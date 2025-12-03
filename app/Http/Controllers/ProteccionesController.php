<?php

namespace App\Http\Controllers;

use App\Models\Proteccion;
use Illuminate\Http\Request;

class ProteccionesController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
        $protecciones = Proteccion::select('id', 'nombre')->paginate(20);
        return inertia('admin/protecciones/lista', ['protecciones' => $protecciones]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
        return inertia('admin/protecciones/crear', ['proteccion' => new Proteccion()]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
        $validated = $request->validate(['nombre' => ['required', 'string', 'max:255'],]);

        Proteccion::create($validated);

        return redirect()->route('protecciones.index');
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
        $proteccion = Proteccion::find($id);
        return inertia('admin/protecciones/editar', ['proteccion' => $proteccion]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
        $validated = $request->validate(['nombre' => ['required', 'string', 'max:255'],]);

        $proteccion = Proteccion::find($id);
        $proteccion->update($validated);

        return redirect()->route('protecciones.index');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
        $proteccion = Proteccion::find($id);
        $proteccion->delete();

        return redirect()->route('protecciones.index');
    }
}
