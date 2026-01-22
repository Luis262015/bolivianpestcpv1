<?php

namespace App\Http\Controllers;

use App\Models\Retiro;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;

class RetirosController extends Controller
{
  public function index()
  {
    $retiros = [];
    $retiros = Retiro::select('id', 'concepto', 'monto', 'tipo')->paginate(20);
    return inertia('admin/retiros/lista', ['retiros' => $retiros]);
  }

  public function create()
  {
    return inertia('admin/retiros/crear', ['retiro' => new Retiro()]);
  }

  public function store(Request $request)
  {
    $validated = $request->validate([
      'monto' => ['required', 'numeric', 'min:0'],
      'concepto' => ['required', 'string', 'max:255'],
      'tipo' => ['required', 'string', 'in:Retiro,Retiro dueño'],
    ]);
    $retiro = new Retiro();
    $retiro->user_id = Auth::id();
    $retiro->concepto = $validated['concepto'];
    $retiro->monto = $validated['monto'];
    $retiro->tipo = $validated['tipo'];
    $retiro->save();
    return redirect()->route('retiros.index');
  }



  public function edit(string $id)
  {
    $retiro = Retiro::find($id);
    return inertia('admin/retiros/editar', ['retiro' => $retiro]);
  }

  public function update(Request $request, string $id)
  {
    $validated = $request->validate([
      'monto' => ['required', 'numeric', 'min:0'],
      'concepto' => ['required', 'string', 'max:255'],
      'tipo' => ['required', 'string', 'in:Retiro,Retiro dueño'],
    ]);
    $retiro = Retiro::find($id);
    $user = Auth::user();
    Log::info("@@@--- Actualizacion de Retiro ---@@@");
    Log::info("Retiro Anterior: ID: " . $retiro->id . ", Concepto: " . $retiro->concepto . ", Total: " . $retiro->monto . ", Tipo: " . $retiro->tipo . ", USER_ID: " . $retiro->user_id . ", TIENDA_ID: " . $retiro->tienda_id . ", USER_AUTH: " . $user->id . " " . $user->name . " " . $user->email);
    Log::info("Retiro Nuevo: ID: " . $retiro->id . ", Concepto: " . $validated['concepto'] . ", Total: " . $validated['monto'] . ", Tipo: " . $validated['tipo'] . ", USER_ID: " . $retiro->user_id . ", TIENDA_ID: " . $retiro->tienda_id . ", USER_AUTH: " . $user->id . " " . $user->name . " " . $user->email);
    $retiro->update($validated);
    return redirect()->route('retiros.index');
  }

  public function destroy(string $id)
  {
    $retiro = Retiro::find($id);
    $user = Auth::user();
    Log::info("@@@--- Actualizacion de Retiro ---@@@");
    Log::info("Retiro Anterior: ID: " . $retiro->id . ", Concepto: " . $retiro->concepto . ", Total: " . $retiro->monto . ", Tipo: " . $retiro->tipo . ", USER_ID: " . $retiro->user_id . ", TIENDA_ID: " . $retiro->tienda_id . ", USER_AUTH: " . $user->id . " " . $user->name . " " . $user->email);
    $retiro->delete();
    return redirect()->route('retiros.index');
  }

  /** FUNCIONES NO USADAS */

  public function show(string $id) {}
}
