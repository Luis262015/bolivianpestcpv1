<?php

namespace App\Http\Controllers;

use App\Models\Almacen;
use App\Models\Cronograma;
use App\Models\Empresa;
use App\Models\User;
use Illuminate\Http\Request;

class CronogramaController extends Controller
{
  private $toValidated = [
    'title' => 'sometimes|required|string|max:255',
    'date' => 'sometimes|required|date',
    'color' => 'sometimes|required|string',
    'status' => 'sometimes|required|in:pendiente,postergado,completado',
    'user_id' => 'sometimes|required|exists:users,id',
    'tecnico_id' => 'sometimes|required|exists:users,id',
    'almacen_id' => 'sometimes|required|exists:almacenes,id',
    'empresa_id' => 'sometimes|required|exists:empresas,id',
  ];

  public function index(Request $request)
  {
    $user = $request->user();

    // =============================
    // Filtros
    // =============================
    $filters = $request->only([
      'empresa_id',
      'almacen_id',
      'ver_todas',
    ]);

    // =============================
    // Empresas y almacenes visibles
    // =============================
    if ($user->hasRole('cliente')) {
      $empresasUser = User::with('empresas')->find($user->id);
      $empresaUser = $empresasUser->empresas[0];

      $empresas = Empresa::select(['id', 'nombre'])
        ->where('id', $empresaUser->id)
        ->get();

      $almacenes = Almacen::select(['id', 'nombre', 'empresa_id'])
        ->where('empresa_id', $empresaUser->id)
        ->get();
    } else {
      $empresas = Empresa::all(['id', 'nombre']);
      $almacenes = Almacen::all(['id', 'nombre', 'empresa_id']);
    }

    // =============================
    // Usuarios
    // =============================
    $usuarios = User::all(['id', 'name as nombre']);

    // =============================
    // Tareas (lógica principal)
    // =============================
    $tareasQuery = Cronograma::query();

    if (!empty($filters['almacen_id'])) {
      // 📍 Vista por almacén
      $tareasQuery->where('almacen_id', $filters['almacen_id']);
    } elseif ($request->boolean('ver_todas')) {
      // 🌍 Vista global (solo si se presionó el botón)

      if ($user->hasRole('cliente')) {
        // Cliente: solo tareas de sus almacenes
        $tareasQuery->whereIn(
          'almacen_id',
          $almacenes->pluck('id')
        );
      }
      // Admin / superadmin: ve todo (sin filtro)
    } else {
      // ❌ Sin almacén y sin "ver todas" → no mostrar nada
      $tareasQuery->whereRaw('1 = 0');
    }

    $tareas = $tareasQuery->get([
      'id',
      'title',
      'date',
      'color',
      'status',
      'user_id',
      'almacen_id',
    ]);

    // =============================
    // Inertia
    // =============================
    return inertia('admin/cronogramas/prueba', [
      'empresas' => $empresas,
      'almacenes' => $almacenes,
      'usuarios' => $usuarios,
      'tareas' => $tareas,
      'filters' => $filters,
    ]);
  }

  public function store(Request $request)
  {
    $validated = $request->validate($this->toValidated);
    // dd($validated);
    Cronograma::create($validated);
    return redirect()->route('cronogramas.index', $request->only(['empresa_id', 'almacen_id']))
      ->with('success', 'Tarea creada correctamente.');
  }

  public function update(Request $request, Cronograma $cronograma)
  {
    $validated = $request->validate($this->toValidated);
    $cronograma->update($validated);
    return redirect()->route('cronogramas.index', $request->only(['empresa_id', 'almacen_id']))
      ->with('success', 'Tarea actualizada correctamente.');
  }

  public function destroy(Cronograma $tarea)
  {
    $tarea->delete();
    return redirect()->route('cronogramas.index');
  }

  public function verificar($numero)
  {
    $cronograma = Cronograma::where('id', $numero)
      ->select('id', 'empresa_id', 'almacen_id', 'tipo_seguimiento_id', 'status')
      ->first();

    if (!$cronograma) {
      return response()->json([
        'exists' => false
      ]);
    }

    return response()->json([
      'exists' => true,
      'data' => $cronograma
    ]);
  }
}
