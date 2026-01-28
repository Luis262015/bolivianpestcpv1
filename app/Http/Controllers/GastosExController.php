<?php

namespace App\Http\Controllers;

use App\Models\CuentaExtra;
use App\Models\GastoExtra;
use Illuminate\Http\Request;

class GastosExController extends Controller
{
  private $toValidated = [
    'concepto' => ['required', 'string', 'max:255'],
    'total' => ['required', 'numeric', 'min:0'],
    'cuenta_id' => ['required', 'integer']
  ];
  public function index()
  {
    $gastosex = GastoExtra::paginate(20);
    $cuentas = CuentaExtra::select(['id', 'nombre'])->get();
    return inertia('admin/gastosEx/index', ['gastos' => $gastosex, 'cuentas' => $cuentas]);
  }

  public function store(Request $request)
  {
    $validated = $request->validate($this->toValidated);
    GastoExtra::create($validated);
    return redirect()->route('gastosex.index');
  }

  public function update(Request $request, string $id)
  {
    $validated = $request->validate($this->toValidated);
    $gasto = GastoExtra::find($id);
    $gasto->update($validated);
    return redirect()->route('gastosex.index');
  }

  public function destroy(string $id)
  {
    $gasto = GastoExtra::find($id);
    $gasto->delete();
    return redirect()->route('gastosex.index');
  }

  /** FUNCIONES NO USADAS */
  // public function create() {}
  // public function show(string $id) {}
  // public function edit(string $id) {}
}
