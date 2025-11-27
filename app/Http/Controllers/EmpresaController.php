<?php

namespace App\Http\Controllers;

use App\Models\Empresa;
use Illuminate\Http\Request;

class EmpresaController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
        $empresas = Empresa::paginate(10);
        return inertia('admin/empresas/lista', ['empresas' => $empresas]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
        return inertia('admin/empresas/crear');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
        $validated = $request->validate([
            'nombre' => 'required',
            'direccion' => 'required',
            'telefono' => 'nullable',
            'email' => 'required|email',
            'ciudad' => 'required',
            'activo' => 'boolean',
        ]);

        Empresa::create($validated);
        return redirect()->route('empresas.index');
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
    public function edit(Empresa $empresa)
    {
        //
        dd("LLEGO INFORMACION " . $empresa);
        return inertia('admin/empresas/editar', ['empresa' => $empresa]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Empresa $empresa)
    {
        //
        $validated = $request->validate([
            'nombre' => 'required',
            'direccion' => 'required',
            'telefono' => 'nullable',
            'email' => 'required|email',
            'ciudad' => 'required',
            'activo' => 'boolean',
        ]);

        $empresa->update($validated);
        return redirect()->route('empresas.index');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
        Empresa::find($id)->delete();
        return redirect()->route('empresas.index');
    }
}
