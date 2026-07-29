<?php

namespace App\Http\Controllers;

use App\Models\Almacen;
use App\Models\Cronograma;
use App\Models\Empresa;
use App\Models\TipoSeguimiento;
use App\Models\User;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;
use Illuminate\Validation\Rules\In;

class CronogramaController extends Controller
{
  // Los ids se consultan una sola vez por request: la regla se arma dos veces
  // (user_id y tecnico_id) y el catálogo no cambia a mitad de validación.
  private ?In $reglaResponsable = null;

  // Reglas para update: cada campo es opcional (el drag & drop manda solo la
  // fecha), pero si viene, debe ser válido. empresa_id no se acepta del
  // cliente: se deduce siempre del almacén.
  private function reglasActualizacion(): array
  {
    return [
      'title' => 'sometimes|required|string|max:255',
      'date' => 'sometimes|required|date',
      'color' => 'sometimes|required|string|max:100',
      'status' => 'sometimes|required|in:pendiente,postergado,completado',
      'user_id' => ['sometimes', 'required', $this->reglaResponsable()],
      'tecnico_id' => ['sometimes', 'required', $this->reglaResponsable()],
      'almacen_id' => 'sometimes|required|exists:almacenes,id',
      'tipo_seguimiento_id' => 'sometimes|nullable|exists:tipo_seguimientos,id',
    ];
  }

  // El responsable de una tarea siempre es personal interno (superadmin,
  // admin o técnico); un cliente nunca puede quedar asignado.
  private function usuariosResponsables(): Builder
  {
    return User::whereDoesntHave('roles', fn(Builder $q) => $q->where('name', 'cliente'));
  }

  private function reglaResponsable(): In
  {
    return $this->reglaResponsable ??= Rule::in($this->usuariosResponsables()->pluck('id')->all());
  }

  public function index(Request $request)
  {
    $user = $request->user();
    $esCliente = $user->hasRole('cliente');

    $filters = $request->validate([
      'empresa_id' => 'nullable|integer',
      'almacen_id' => 'nullable|integer',
      'ver_todas' => 'nullable|boolean',
    ]);

    // =============================
    // Empresas y almacenes visibles
    // =============================
    if ($esCliente) {
      $empresaIds = $user->empresas()->pluck('empresas.id');

      $empresas = Empresa::select('id', 'nombre')->whereIn('id', $empresaIds)->get();
      $almacenes = Almacen::select('id', 'nombre', 'empresa_id')
        ->whereIn('empresa_id', $empresaIds)
        ->get();
    } else {
      $empresas = Empresa::select('id', 'nombre')->get();
      $almacenes = Almacen::select('id', 'nombre', 'empresa_id')->get();
    }

    // El dropdown "Usuario responsable" solo existe para staff; no exponer
    // la lista de usuarios a clientes. Y los propios clientes tampoco son
    // asignables como responsables, así que quedan fuera del catálogo.
    $usuarios = $esCliente
      ? collect()
      : $this->usuariosResponsables()->orderBy('name')->get(['id', 'name as nombre']);

    // Catálogo de tipos de seguimiento (para elegir el tipo al crear la tarea).
    $tiposSeguimiento = TipoSeguimiento::select('id', 'nombre')->orderBy('id')->get();

    // =============================
    // Tareas (lógica principal)
    // =============================
    $columnas = ['id', 'title', 'date', 'color', 'status', 'user_id', 'almacen_id', 'tipo_seguimiento_id'];

    if (!empty($filters['almacen_id'])) {
      // 📍 Vista por almacén: un cliente solo puede consultar sus almacenes.
      if ($esCliente && !$almacenes->contains('id', (int) $filters['almacen_id'])) {
        abort(403);
      }
      $tareas = Cronograma::where('almacen_id', $filters['almacen_id'])->get($columnas);
    } elseif ($request->boolean('ver_todas')) {
      // 🌍 Vista global: cliente acotado a sus almacenes, staff ve todo.
      $tareas = Cronograma::query()
        ->when($esCliente, fn($q) => $q->whereIn('almacen_id', $almacenes->pluck('id')))
        ->get($columnas);
    } else {
      // ❌ Sin almacén y sin "ver todas" → nada que consultar.
      $tareas = collect();
    }

    return inertia('admin/cronogramas/prueba', [
      'empresas' => $empresas,
      'almacenes' => $almacenes,
      'usuarios' => $usuarios,
      'tiposSeguimiento' => $tiposSeguimiento,
      'tareas' => $tareas,
      'filters' => $filters,
    ]);
  }

  public function store(Request $request)
  {
    $validated = $request->validate([
      'title' => 'required|string|max:255',
      'date' => 'required|date',
      'color' => 'required|string|max:100',
      'status' => 'required|in:pendiente,postergado,completado',
      'user_id' => ['required', $this->reglaResponsable()],
      'tecnico_id' => ['required', $this->reglaResponsable()],
      'almacen_id' => 'required|exists:almacenes,id',
      'tipo_seguimiento_id' => 'nullable|exists:tipo_seguimientos,id',
    ]);

    // La empresa se deduce del almacén: evita pares empresa/almacén inconsistentes.
    $validated['empresa_id'] = Almacen::whereKey($validated['almacen_id'])->value('empresa_id');

    Cronograma::create($validated);

    return redirect()->route('cronogramas.index', $request->only(['empresa_id', 'almacen_id', 'ver_todas']))
      ->with('success', 'Tarea creada correctamente.');
  }

  public function update(Request $request, Cronograma $cronograma)
  {
    $validated = $request->validate($this->reglasActualizacion());

    if (isset($validated['almacen_id'])) {
      $validated['empresa_id'] = Almacen::whereKey($validated['almacen_id'])->value('empresa_id');
    }

    $cronograma->update($validated);

    return redirect()->route('cronogramas.index', $request->only(['empresa_id', 'almacen_id', 'ver_todas']))
      ->with('success', 'Tarea actualizada correctamente.');
  }

  public function destroy(Cronograma $cronograma)
  {
    $cronograma->delete();
    return redirect()->route('cronogramas.index');
  }

  public function verificar($numero)
  {
    $cronograma = Cronograma::whereKey($numero)
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
