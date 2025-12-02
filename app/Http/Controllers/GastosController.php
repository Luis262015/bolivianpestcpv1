<?php

namespace App\Http\Controllers;

use App\Models\Gasto;
use Illuminate\Http\Request;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;

class GastosController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        //
        // return inertia('admin/gastos/lista');
        // ----------------------------------------
        $filters = $request->only([
            'concepto',
            'detalle',
            'total_min',
            'total_max',
            'fecha_desde',
            'fecha_hasta'
        ]);

        $query = Gasto::query();

        // === FILTROS DE TEXTO ===
        if ($request->filled('concepto')) {
            $query->where('concepto', 'like', "%{$request->concepto}%");
        }

        if ($request->filled('detalle')) {
            $query->where('detalle', 'like', "%{$request->detalle}%");
        }

        // === FILTROS NUMÉRICOS ===
        if ($request->filled('total_min')) {
            $query->where('total', '>=', $request->total_min);
        }

        if ($request->filled('total_max')) {
            $query->where('total', '<=', $request->total_max);
        }

        // === FILTRO DE FECHA USANDO SOLO created_at ===
        $hasDesde = $request->filled('fecha_desde');
        $hasHasta = $request->filled('fecha_hasta');

        if ($hasDesde || $hasHasta) {
            $query->where(function ($q) use ($request, $hasDesde, $hasHasta) {
                // Caso 1: Solo "fecha_desde" → todo el día
                if ($hasDesde && !$hasHasta) {
                    $desde = Carbon::parse($request->fecha_desde)->startOfDay();
                    $hasta = Carbon::parse($request->fecha_desde)->endOfDay();
                    $q->whereBetween('created_at', [$desde, $hasta]);
                }

                // Caso 2: Solo "fecha_hasta" → todo el día
                elseif (!$hasDesde && $hasHasta) {
                    $desde = Carbon::parse($request->fecha_hasta)->startOfDay();
                    $hasta = Carbon::parse($request->fecha_hasta)->endOfDay();
                    $q->whereBetween('created_at', [$desde, $hasta]);
                }

                // Caso 3: Ambos → rango completo
                else {
                    $desde = Carbon::parse($request->fecha_desde)->startOfDay();
                    $hasta = Carbon::parse($request->fecha_hasta)->endOfDay();
                    $q->whereBetween('created_at', [$desde, $hasta]);
                }
            });
        }

        $gastos = $query->orderBy('id', 'desc')->paginate(15);

        return inertia('admin/gastos/lista', [
            'gastos' => $gastos,
            'filters' => $filters,
        ]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
        return inertia('admin/gastos/crear', ['gasto' => new Gasto()]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
        //
        // dd($request);
        $validated = $request->validate([
            'total' => ['required', 'numeric', 'min:0'],
            'concepto' => ['required', 'string', 'max:255'],
            'detalle' => ['nullable', 'string'],
        ]);
        // dd($validated);
        $gasto = new Gasto();
        // $gasto->tienda_id = session('tienda_id');
        $gasto->user_id = Auth::id();
        $gasto->concepto = $validated['concepto'];
        $gasto->detalle = $validated['detalle'];
        $gasto->total = $validated['total'];
        $gasto->save();

        return redirect()->route('gastos.index');
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
        $gasto = Gasto::find($id);
        return inertia('admin/gastos/editar', ['gasto' => $gasto]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
        $validated = $request->validate([
            'total' => ['required', 'numeric', 'min:0'],
            'concepto' => ['required', 'string', 'max:255'],
            'detalle' => ['nullable', 'string'],
        ]);
        // Conseguir GASTO a editar
        $gasto = Gasto::find($id);
        // LOG: de todos los datos anteriores al cambio
        $user = Auth::user();
        Log::info("@@@--- Actualizacion de Gasto ---@@@");
        Log::info("Gasto Anterior: ID: " . $gasto->id . ", Concepto: " . $gasto->concepto . ", Detalle: " . $gasto->detalle . ", Total: " . $gasto->total . ", USER_ID: " . $gasto->user_id . ", TIENDA_ID: " . $gasto->tienda_id . ", USER_AUTH: " . $user->id . " " . $user->name . " " . $user->email);
        // NUEVOS DATOS
        Log::info("Gasto Nuevo: ID: " . $gasto->id . ", Concepto: " . $validated['concepto'] . ", Detalle: " . $validated['detalle'] . ", Total: " . $validated['total'] . ", USER_ID: " . $gasto->user_id . ", TIENDA_ID: " . $gasto->tienda_id . ", USER_AUTH: " . $user->id . " " . $user->name . " " . $user->email);
        $gasto->update($validated);
        return redirect()->route('gastos.index');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
        //
        $gasto = Gasto::find($id);
        // LOG: de todos los datos anteriores al cambio
        $user = Auth::user();
        Log::info("@@@--- Eliminado de Gasto ---@@@");
        Log::info("Gasto Anterior: ID: " . $gasto->id . ", Concepto: " . $gasto->concepto . ", Detalle: " . $gasto->detalle . ", Total: " . $gasto->total . ", USER_ID: " . $gasto->user_id . ", TIENDA_ID: " . $gasto->tienda_id . ", USER_AUTH: " . $user->id . " " . $user->name . " " . $user->email);
        // Eliminar datos de gasto
        $gasto->delete();
        return redirect()->route('gastos.index');
    }
}
