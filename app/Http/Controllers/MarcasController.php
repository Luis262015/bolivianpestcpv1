<?php

namespace App\Http\Controllers;

use App\Models\Marca;
use Illuminate\Http\Request;

class MarcasController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
        $marcas = Marca::paginate(10);
        return inertia('admin/marcas/lista', ['marcas' => $marcas]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
        return inertia('admin/marcas/crear');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
        $validated = $request->validate([
            'nombre' => ['required', 'string', 'max:255'],
            'orden' => ['required', 'integer', 'min:0'],
            'imagen' => ['nullable', 'string', 'max:255'],
        ]);

        Marca::create($validated);

        return redirect()->route('marcas.index');
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
    public function edit(Marca $marca)
    {
        //
        return inertia('admin/marcas/editar', ['marca' => $marca]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
        $validated = $request->validate([
            'nombre' => ['required', 'string', 'max:255'],
            'orden' => ['required', 'integer', 'min:0'],
            'imagen' => ['nullable', 'string', 'max:255'],
        ]);
        $marca = Marca::find($id);
        $marca->update($validated);

        return redirect()->route('marcas.index');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
        $marca = Marca::find($id);
        $marca->delete();

        return redirect()->route('marcas.index');
    }
}
