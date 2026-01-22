<?php

namespace App\Http\Controllers;

use App\Models\Gasto;
use Illuminate\Http\Request;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;

class GastosController extends Controller
{

  private $toValidated = [
    'total' => ['required', 'numeric', 'min:0'],
    'concepto' => ['required', 'string', 'max:255'],
    // 'detalle' => ['nullable', 'string'],
  ];

  public function index(Request $request)
  {
    $filters = $request->only([
      'concepto',
      // 'detalle',
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

    // if ($request->filled('detalle')) {
    //   $query->where('detalle', 'like', "%{$request->detalle}%");
    // }

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

  public function create()
  {
    return inertia('admin/gastos/crear', ['gasto' => new Gasto()]);
  }

  public function store(Request $request)
  {
    $validated = $request->validate($this->toValidated);

    $gasto = new Gasto();
    $gasto->user_id = Auth::id();
    $gasto->concepto = $validated['concepto'];
    $gasto->total = $validated['total'];
    $gasto->save();

    return redirect()->route('gastos.index');
  }



  public function edit(string $id)
  {
    $gasto = Gasto::find($id);
    return inertia('admin/gastos/editar', ['gasto' => $gasto]);
  }

  public function update(Request $request, string $id)
  {
    $validated = $request->validate($this->toValidated);

    $gasto = Gasto::find($id);
    // LOG: de todos los datos anteriores al cambio
    $user = Auth::user();
    Log::info("@@@--- Actualizacion de Gasto ---@@@");
    Log::info("Gasto Anterior: ID: " . $gasto->id . ", Concepto: " . $gasto->concepto . ", Total: " . $gasto->total . ", USER_ID: " . $gasto->user_id  . ", USER_AUTH: " . $user->id . " " . $user->name . " " . $user->email);
    // NUEVOS DATOS
    Log::info("Gasto Nuevo: ID: " . $gasto->id . ", Concepto: " . $validated['concepto'] . ", Total: " . $validated['total'] . ", USER_ID: " . $gasto->user_id  . ", USER_AUTH: " . $user->id . " " . $user->name . " " . $user->email);
    $gasto->update($validated);
    return redirect()->route('gastos.index');
  }

  public function destroy(string $id)
  {
    $gasto = Gasto::find($id);
    // LOG: de todos los datos anteriores al cambio
    $user = Auth::user();
    Log::info("@@@--- Eliminado de Gasto ---@@@");
    Log::info("Gasto Anterior: ID: " . $gasto->id . ", Concepto: " . $gasto->concepto . ", Detalle: " . $gasto->detalle . ", Total: " . $gasto->total . ", USER_ID: " . $gasto->user_id . ", TIENDA_ID: " . $gasto->tienda_id . ", USER_AUTH: " . $user->id . " " . $user->name . " " . $user->email);
    // Eliminar datos de gasto
    $gasto->delete();
    return redirect()->route('gastos.index');
  }

  /** FUNCIONES NO USADAS */
  public function show(string $id) {}
}
