<?php

namespace App\Http\Controllers;

use App\Models\Retiro;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;

class RetirosController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
        $retiros = [];
        // $user = Auth::user();
        // if ($user->hasRole('vendedor')) {
        //     if (session('tienda_id') != null) {
        //         $retiros = Retiro::where('tienda_id', session('tienda_id'))->select('id', 'concepto', 'monto', 'tipo')->paginate(20);
        //     }
        // } else {
        //     $retiros = Retiro::select('id', 'concepto', 'monto', 'tipo')->paginate(20);
        // }
        $retiros = Retiro::select('id', 'concepto', 'monto', 'tipo')->paginate(20);
        return inertia('admin/retiros/lista', ['retiros' => $retiros]);
        // return inertia('admin/retiros/lista');
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
        return inertia('admin/retiros/crear', ['retiro' => new Retiro()]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
        //
        $validated = $request->validate([
            'monto' => ['required', 'numeric', 'min:0'],
            'concepto' => ['required', 'string', 'max:255'],
            'tipo' => ['required', 'string', 'in:Retiro,Retiro dueño'],
        ]);

        $retiro = new Retiro();
        // $retiro->tienda_id = session('tienda_id');
        $retiro->user_id = Auth::id();
        $retiro->concepto = $validated['concepto'];
        $retiro->monto = $validated['monto'];
        $retiro->tipo = $validated['tipo'];
        $retiro->save();

        return redirect()->route('retiros.index');
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
        $retiro = Retiro::find($id);
        return inertia('admin/retiros/editar', ['retiro' => $retiro]);
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
            'tipo' => ['required', 'string', 'in:Retiro,Retiro dueño'],
        ]);

        $retiro = Retiro::find($id);
        $user = Auth::user();
        Log::info("@@@--- Actualizacion de Retiro ---@@@");
        Log::info("Retiro Anterior: ID: " . $retiro->id . ", Concepto: " . $retiro->concepto . ", Total: " . $retiro->monto . ", Tipo: " . $retiro->tipo . ", USER_ID: " . $retiro->user_id . ", TIENDA_ID: " . $retiro->tienda_id . ", USER_AUTH: " . $user->id . " " . $user->name . " " . $user->email);
        // NUEVOS DATOS
        Log::info("Retiro Nuevo: ID: " . $retiro->id . ", Concepto: " . $validated['concepto'] . ", Total: " . $validated['monto'] . ", Tipo: " . $validated['tipo'] . ", USER_ID: " . $retiro->user_id . ", TIENDA_ID: " . $retiro->tienda_id . ", USER_AUTH: " . $user->id . " " . $user->name . " " . $user->email);
        $retiro->update($validated);
        return redirect()->route('retiros.index');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
        $retiro = Retiro::find($id);
        $user = Auth::user();
        Log::info("@@@--- Actualizacion de Retiro ---@@@");
        Log::info("Retiro Anterior: ID: " . $retiro->id . ", Concepto: " . $retiro->concepto . ", Total: " . $retiro->monto . ", Tipo: " . $retiro->tipo . ", USER_ID: " . $retiro->user_id . ", TIENDA_ID: " . $retiro->tienda_id . ", USER_AUTH: " . $user->id . " " . $user->name . " " . $user->email);
        $retiro->delete();
        return redirect()->route('retiros.index');
    }
}
