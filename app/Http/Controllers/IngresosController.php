<?php

namespace App\Http\Controllers;

use App\Models\Ingreso;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;

class IngresosController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
        $ingresos = [];
        $ingresos = Ingreso::select('id', 'concepto', 'monto')->paginate(20);
        return inertia('admin/ingresos/lista', ['ingresos' => $ingresos]);
        // return inertia('admin/ingresos/lista');
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
        return inertia('admin/ingresos/crear', ['ingreso' => new Ingreso()]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
        $validated = $request->validate([
            'monto' => ['required', 'numeric', 'min:0'],
            'concepto' => ['required', 'string', 'max:255'],
        ]);
        $ingreso = new Ingreso();
        // $ingreso->tienda_id = session('tienda_id');
        $ingreso->user_id = Auth::id();
        $ingreso->concepto = $validated['concepto'];
        $ingreso->monto = $validated['monto'];
        $ingreso->save();

        return redirect()->route('ingresos.index');
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
        $ingreso = Ingreso::find($id);
        return inertia('admin/ingresos/editar', ['ingreso' => $ingreso]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
        $validated = $request->validate([
            'monto' => ['required', 'numeric', 'min:0'],
            'concepto' => ['required', 'string', 'max:255'],
        ]);
        $ingreso = Ingreso::find($id);
        $user = Auth::user();
        Log::info("@@@--- Actualizacion de Ingreso ---@@@");
        Log::info("Ingreso Anterior: ID: " . $ingreso->id . ", Concepto: " . $ingreso->concepto . ", Total: " . $ingreso->monto . ", USER_ID: " . $ingreso->user_id . ", TIENDA_ID: " . $ingreso->tienda_id . ", USER_AUTH: " . $user->id . " " . $user->name . " " . $user->email);
        // NUEVOS DATOS
        Log::info("Ingreso Nuevo: ID: " . $ingreso->id . ", Concepto: " . $validated['concepto'] . ", Total: " . $validated['monto'] . ", USER_ID: " . $ingreso->user_id . ", TIENDA_ID: " . $ingreso->tienda_id . ", USER_AUTH: " . $user->id . " " . $user->name . " " . $user->email);
        $ingreso->update($validated);
        return redirect()->route('ingresos.index');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
        $ingreso = Ingreso::find($id);
        $user = Auth::user();
        Log::info("@@@--- Eliminado de Ingreso ---@@@");
        Log::info("Ingreso Anterior: ID: " . $ingreso->id . ", Concepto: " . $ingreso->concepto . ", Total: " . $ingreso->monto . ", USER_ID: " . $ingreso->user_id . ", TIENDA_ID: " . $ingreso->tienda_id . ", USER_AUTH: " . $user->id . " " . $user->name . " " . $user->email);
        $ingreso->delete();
        return redirect()->route('ingresos.index');
    }
}
