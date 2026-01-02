<?php

namespace App\Http\Controllers;

use App\Models\Almacen;
use App\Models\Cronograma;
use App\Models\Empresa;
use App\Models\User;
use Illuminate\Http\Request;

class CronogramaController extends Controller
{
  public function index(Request $request)
  {

    $empresaId = $request->query('empresa_id');
    $almacenId = $request->query('almacen_id');

    $empresas = Empresa::select('id', 'nombre')->orderBy('nombre')->get();
    $almacenes = $empresaId
      ? Almacen::where('empresa_id', $empresaId)->select('id', 'nombre', 'empresa_id')->orderBy('nombre')->get()
      : collect();

    $usuarios = User::select('id', 'name as nombre', 'email')->orderBy('name')->get();

    // $query = Cronograma::query()
    //   ->with('user:id,name')
    //   ->select('id', 'titulo as title', 'fecha as date', 'color', 'estado as status', 'user_id', 'empresa_id', 'almacen_id');

    // if ($empresaId) {
    //   $query->where('empresa_id', $empresaId);
    // }
    // if ($almacenId) {
    //   $query->where('almacen_id', $almacenId);
    // }

    // $tareas = $query->get()->map(function ($tarea) {
    //   return [
    //     'id' => $tarea->id,
    //     'title' => $tarea->title,
    //     'date' => $tarea->date->format('Y-m-d'),
    //     'color' => $tarea->color ?? 'bg-blue-500',
    //     'status' => $tarea->status ?? 'pendiente',
    //     'user_id' => $tarea->user_id,
    //     'empresa_id' => $tarea->empresa_id,
    //     'almacen_id' => $tarea->almacen_id,
    //   ];
    // });

    return inertia('admin/cronogramas/prueba', [
      'empresas' => $empresas,
      'almacenes' => $almacenes,
      'usuarios' => $usuarios,
      // 'tareas' => $tareas,
      'filters' => [
        'empresa_id' => $empresaId ? (int) $empresaId : null,
        'almacen_id' => $almacenId ? (int) $almacenId : null,
      ],
    ]);
  }

  public function create() {}

  public function store(Request $request)
  {
    $validated = $request->validate([
      'title' => 'required|string|max:255',
      'date' => 'required|date',
      'color' => 'required|string|max:50',
      'status' => 'required|in:pendiente,postergado,completado',
      'user_id' => 'required|exists:users,id',
      'empresa_id' => 'required|exists:empresas,id',
      'almacen_id' => 'required|exists:almacenes,id',
    ]);

    Cronograma::create([
      'titulo' => $validated['title'],
      'fecha' => $validated['date'],
      'color' => $validated['color'],
      'estado' => $validated['status'],
      'user_id' => $validated['user_id'],
      'empresa_id' => $validated['empresa_id'],
      'almacen_id' => $validated['almacen_id'],
    ]);

    return redirect()->route('cronogramas.index');
  }

  public function show(string $id) {}

  public function edit(string $id) {}

  public function update(Request $request, Cronograma $tarea)
  {
    $validated = $request->validate([
      'title' => 'required|string|max:255',
      'date' => 'required|date',
      'color' => 'required|string|max:50',
      'status' => 'required|in:pendiente,postergado,completado',
      'user_id' => 'required|exists:users,id',
      'empresa_id' => 'required|exists:empresas,id',
      'almacen_id' => 'required|exists:almacenes,id',
    ]);

    $tarea->update([
      'titulo' => $validated['title'],
      'fecha' => $validated['date'],
      'color' => $validated['color'],
      'estado' => $validated['status'],
      'user_id' => $validated['user_id'],
      'empresa_id' => $validated['empresa_id'],
      'almacen_id' => $validated['almacen_id'],
    ]);

    return redirect()->route('cronogramas.index');
  }

  public function destroy(Cronograma $tarea)
  {
    $tarea->delete();

    return redirect()->route('cronogramas.index');
  }
}
