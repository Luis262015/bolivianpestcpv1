<?php

namespace App\Http\Controllers;

use App\Models\Signo;
use Illuminate\Http\Request;

class SignosController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
        $signos = Signo::select('id', 'nombre')->paginate(20);
        return inertia('admin/signos/lista', ['signos' => $signos]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
        return inertia('admin/signos/crear', ['signos' => new Signo()]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
        $validated = $request->validate(['nombre' => ['required', 'string', 'max:255'],]);

        Signo::create($validated);

        return redirect()->route('signos.index');
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
        $signo = Signo::find($id);
        return inertia('admin/signos/editar', ['signo' => $signo]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
        $validated = $request->validate(['nombre' => ['required', 'string', 'max:255'],]);

        $signo = Signo::find($id);
        $signo->update($validated);

        return redirect()->route('signos.index');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
        $signo = Signo::find($id);
        $signo->delete();

        return redirect()->route('signos.index');
    }
}
