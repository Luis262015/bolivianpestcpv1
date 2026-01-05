<?php

namespace App\Http\Controllers;

use App\Models\CuentaFinanciero;
use App\Models\GastoFinanciero;
use Illuminate\Http\Request;

class GastosFinController extends Controller
{

  private $toValidated = [
    'concepto' => ['required', 'string', 'max:255'],
    'total' => ['required', 'numeric', 'min:0'],
    'cuenta_id' => ['required', 'integer']
  ];
  public function index()
  {
    $gastosfin = GastoFinanciero::paginate(20);
    $cuentas = CuentaFinanciero::select(['id', 'nombre'])->get();
    return inertia('admin/gastosFin/index', ['gastos' => $gastosfin, 'cuentas' => $cuentas]);
  }

  public function create() {}

  public function store(Request $request)
  {
    // dd($request);
    $validated = $request->validate($this->toValidated);
    // dd($validated);
    GastoFinanciero::create($validated);
    return redirect()->route('gastosfin.index');
  }

  public function show(string $id) {}

  public function edit(string $id) {}

  public function update(Request $request, string $id)
  {
    dd($request);
    $validated = $request->validate($this->toValidated);
    $gasto = GastoFinanciero::find($id);
    $gasto->update($validated);
    return redirect()->route('gastosfin.index');
  }

  public function destroy(string $id) {}
}
