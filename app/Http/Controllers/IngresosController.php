<?php

namespace App\Http\Controllers;

use App\Models\Ingreso;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;

class IngresosController extends Controller
{
  private $toValidate = [
    'total' => ['required', 'numeric', 'min:0'],
    'concepto' => ['required', 'string', 'max:255'],
  ];

  public function index()
  {
    $ingresos = [];
    $ingresos = Ingreso::select('id', 'concepto', 'total')->paginate(20);
    return inertia('admin/ingresos/lista', ['ingresos' => $ingresos]);
  }

  public function create()
  {
    return inertia('admin/ingresos/crear', ['ingreso' => new Ingreso()]);
  }

  public function store(Request $request)
  {
    $validated = $request->validate($this->toValidate);
    $ingreso = new Ingreso();
    $ingreso->user_id = Auth::id();
    $ingreso->concepto = $validated['concepto'];
    $ingreso->total = $validated['total'];
    $ingreso->save();
    return redirect()->route('ingresos.index');
  }

  public function edit(string $id)
  {
    $ingreso = Ingreso::find($id);
    return inertia('admin/ingresos/editar', ['ingreso' => $ingreso]);
  }

  public function update(Request $request, string $id)
  {
    $validated = $request->validate($this->toValidate);
    $ingreso = Ingreso::find($id);
    $user = Auth::user();
    Log::info("@@@--- Actualizacion de Ingreso ---@@@");
    Log::info("Ingreso Anterior: ID: " . $ingreso->id . ", Concepto: " . $ingreso->concepto . ", Total: " . $ingreso->monto . ", USER_ID: " . $ingreso->user_id . ", USER_AUTH: " . $user->id . " " . $user->name . " " . $user->email);
    Log::info("Ingreso Nuevo: ID: " . $ingreso->id . ", Concepto: " . $validated['concepto'] . ", Total: " . $validated['total'] . ", USER_ID: " . $ingreso->user_id . ", USER_AUTH: " . $user->id . " " . $user->name . " " . $user->email);
    $ingreso->update($validated);
    return redirect()->route('ingresos.index');
  }

  public function destroy(string $id)
  {
    $ingreso = Ingreso::find($id);
    $user = Auth::user();
    Log::info("@@@--- Eliminado de Ingreso ---@@@");
    Log::info("Ingreso Anterior: ID: " . $ingreso->id . ", Concepto: " . $ingreso->concepto . ", Total: " . $ingreso->monto . ", USER_ID: " . $ingreso->user_id .  ", USER_AUTH: " . $user->id . " " . $user->name . " " . $user->email);
    $ingreso->delete();
    return redirect()->route('ingresos.index');
  }

  /** FUNCIONES NO USADAS */
  // public function show(string $id) {}
}
