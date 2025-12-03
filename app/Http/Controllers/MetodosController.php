<?php

namespace App\Http\Controllers;

use App\Models\Metodo;
use Illuminate\Http\Request;

class MetodosController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
        $metodos = Metodo::select('id', 'nombre')->paginate(20);
        return inertia('admin/metodos/lista', ['metodos' => $metodos]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
        return inertia('admin/metodos/crear', ['metodo' => new Metodo()]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
        $validated = $request->validate(['nombre' => ['required', 'string', 'max:255'],]);

        Metodo::create($validated);

        return redirect()->route('metodos.index');
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
        $metodo = Metodo::find($id);
        return inertia('admin/metodos/editar', ['metodo' => $metodo]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
        $validated = $request->validate(['nombre' => ['required', 'string', 'max:255'],]);

        $metodo = Metodo::find($id);
        $metodo->update($validated);

        return redirect()->route('metodos.index');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
        $metodo = Metodo::find($id);
        $metodo->delete();

        return redirect()->route('metodos.index');
    }
}
