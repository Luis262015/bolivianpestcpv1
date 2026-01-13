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
    // 'title' => 'required|string|max:255',
    // 'date' => 'required|date',
    // 'color' => 'required|string',
    // 'status' => 'required|in:pendiente,postergado,completado',
    // 'user_id' => 'required|exists:users,id',
    // 'tecnico_id' => 'required|exists:users,id',
    // 'almacen_id' => 'required|exists:almacenes,id',
    'title' => 'sometimes|required|string|max:255',
    'date' => 'sometimes|required|date',
    'color' => 'sometimes|required|string',
    'status' => 'sometimes|required|in:pendiente,postergado,completado',
    'user_id' => 'sometimes|required|exists:users,id',
    'tecnico_id' => 'sometimes|required|exists:users,id',
    'almacen_id' => 'sometimes|required|exists:almacenes,id',
  ];

  public function index(Request $request)
  {

    $user = $request->user();

    // dd($user);


    $filters = $request->only(['empresa_id', 'almacen_id']);

    if ($user->HasRole('cliente')) {
      $empresasUser = User::with('empresas')->find($user->id);
      // dd($empresasUser);
      // dd($empresas->empresas[0]);
      $empresaUser = $empresasUser->empresas[0];
      // dd($empresaUser);
      // dd($empresaUser->id);

      $empresas = Empresa::select(['id', 'nombre'])->where('id', $empresaUser->id)->get();
      // dd($empresas);

      $almacenes = Almacen::select(['id', 'nombre', 'empresa_id'])->where('empresa_id', $empresaUser->id)->get();
      // dd($almacenes);
    } else {
      $empresas = Empresa::all(['id', 'nombre']);
      $almacenes = Almacen::all(['id', 'nombre', 'empresa_id']);
    }

    $usuarios = User::all(['id', 'name as nombre']); // Ajusta si el campo es 'nombre' en lugar de 'name'

    $tareas = [];
    if (isset($filters['almacen_id'])) {
      $tareas = Cronograma::where('almacen_id', $filters['almacen_id'])
        ->get(['id', 'title', 'date', 'color', 'status', 'user_id', 'almacen_id']);
    }

    return inertia('admin/cronogramas/prueba', [ // Ajusta la ruta del componente Inertia si es necesario
      'empresas' => $empresas,
      'almacenes' => $almacenes,
      'usuarios' => $usuarios,
      'tareas' => $tareas,
      'filters' => $filters,
    ]);

    // return inertia('admin/cronogramas/prueba', [
    //   'empresas' => $empresas,
    //   'almacenes' => $almacenes,
    //   'usuarios' => $usuarios,
    //   // 'tareas' => $tareas,
    //   'filters' => [
    //     'empresa_id' => $empresaId ? (int) $empresaId : null,
    //     'almacen_id' => $almacenId ? (int) $almacenId : null,
    //   ],
    // ]);
  }

  public function create() {}

  public function store(Request $request)
  {

    // dd($request);

    $validated = $request->validate($this->toValidated);

    // dd($validated);

    $tarea = Cronograma::create($validated);

    return redirect()->route('cronogramas.index', $request->only(['empresa_id', 'almacen_id']))
      ->with('success', 'Tarea creada correctamente.');
  }

  public function show(string $id) {}

  public function edit(string $id) {}

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

  public function getAlmacenes() {}
}
