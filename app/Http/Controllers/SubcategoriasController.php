<?php

namespace App\Http\Controllers;

use App\Models\Categoria;
use App\Models\Subcategoria;
use Illuminate\Http\Request;

class SubcategoriasController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
        $subcategorias = Subcategoria::with(['categoria' => function ($query) {
            $query->select('id', 'nombre');
        }])->paginate(20);
        return inertia('admin/subcategorias/lista', ['subcategorias' => $subcategorias]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
        $categorias = Categoria::all('id', 'nombre');
        return inertia('admin/subcategorias/crear', ['categorias' => $categorias]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
        $validated = $request->validated([
            'nombre' => ['required', 'string', 'max:255'],
            'orden' => ['required', 'integer', 'min:0'],
            'imagen' => ['nullable', 'string', 'max:255'],
            'categoria_id' => ['required', 'integer']
        ]);
        Subcategoria::create($validated);
        return redirect()->route('subcategorias.index');
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
        $categorias = Categoria::all('id', 'nombre');
        $subcategoria = Subcategoria::find($id);
        return inertia('admin/subcategorias/edit', ['subcategoria' => $subcategoria, 'categorias' => $categorias]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
        $validated = $request->validated([
            'nombre' => ['required', 'string', 'max:255'],
            'orden' => ['required', 'integer', 'min:0'],
            'imagen' => ['nullable', 'string', 'max:255'],
            'categoria_id' => ['required', 'integer']
        ]);
        $subcategoria = Subcategoria::find($id);
        $subcategoria->update($validated);

        return redirect()->route('subcategorias.index');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
        $subcategoria = Subcategoria::find($id);
        $subcategoria->delete();
        return redirect()->route('subcategorias.index');
    }
}