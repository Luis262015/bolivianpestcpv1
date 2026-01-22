<?php

namespace App\Http\Controllers;

use App\Models\CuentaOperativo;
use App\Models\GastoOperativo;
use Illuminate\Http\Request;

class GastosOpController extends Controller
{

  private $toValidated = [
    'concepto' => ['required', 'string', 'max:255'],
    'total' => ['required', 'numeric', 'min:0'],
    'cuenta_id' => ['required', 'integer']
  ];

  public function index()
  {
    $gastosop = GastoOperativo::paginate(20);
    $cuentas = CuentaOperativo::select(['id', 'nombre'])->get();
    return inertia('admin/gastosOp/index', ['gastos' => $gastosop, 'cuentas' => $cuentas]);
  }



  public function store(Request $request)
  {
    $validated = $request->validate($this->toValidated);
    GastoOperativo::create($validated);
    return redirect()->route('gastosop.index');
  }



  public function update(Request $request, string $id)
  {
    $validated = $request->validate($this->toValidated);
    $gasto = GastoOperativo::find($id);
    $gasto->update($validated);
    return redirect()->route('gastosop.index');
  }

  public function destroy(string $id)
  {
    $gasto = GastoOperativo::find($id);
    $gasto->delete();
    return redirect()->route('gastosop.index');
  }

  /** FUNCIONES NO USADAS */
  public function create() {}
  public function show(string $id) {}

  public function edit(string $id) {}
}
