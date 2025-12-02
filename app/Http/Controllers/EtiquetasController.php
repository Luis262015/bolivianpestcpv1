<?php

namespace App\Http\Controllers;

use App\Models\Etiqueta;
use Illuminate\Http\Request;

class EtiquetasController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
        $etiquetas = Etiqueta::select('id', 'nombre')->paginate(20);
        return inertia('admin/etiquetas/lista', ['etiquetas' => $etiquetas]);
        // return inertia('admin/etiquetas/lista');
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
        return inertia('admin/etiquetas/crear', ['cliente' => new Etiqueta()]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
        $validated = $request->validate(['nombre' => ['required', 'string', 'max:255'],]);

        Etiqueta::create($validated);

        return redirect()->route('etiquetas.index');
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
        $etiqueta = Etiqueta::find($id);
        return inertia('admin/etiquetas/editar', ['etiqueta' => $etiqueta]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
        $validated = $request->validate(['nombre' => ['required', 'string', 'max:255'],]);

        $etiqueta = Etiqueta::find($id);
        $etiqueta->update($validated);

        return redirect()->route('etiquetas.index');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
        $etiqueta = Etiqueta::find($id);
        $etiqueta->delete();

        return redirect()->route('etiquetas.index');
    }
}
