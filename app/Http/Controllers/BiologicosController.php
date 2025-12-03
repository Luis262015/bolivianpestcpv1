<?php

namespace App\Http\Controllers;

use App\Models\Biologico;
use Illuminate\Http\Request;

class BiologicosController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
        $biologicos = Biologico::select('id', 'nombre')->paginate(20);
        return inertia('admin/biologicos/lista', ['biologicos' => $biologicos]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
        return inertia('admin/biologicos/crear', ['biologico' => new Biologico()]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
        $validated = $request->validate(['nombre' => ['required', 'string', 'max:255'],]);

        Biologico::create($validated);

        return redirect()->route('biologicos.index');
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
        $biologico = Biologico::find($id);
        return inertia('admin/biologicos/editar', ['biologico' => $biologico]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
        $validated = $request->validate(['nombre' => ['required', 'string', 'max:255'],]);

        $biologico = Biologico::find($id);
        $biologico->update($validated);

        return redirect()->route('biologicos.index');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
        $biologico = Biologico::find($id);
        $biologico->delete();

        return redirect()->route('biologicos.index');
    }
}
