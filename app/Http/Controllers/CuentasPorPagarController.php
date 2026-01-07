<?php

namespace App\Http\Controllers;

use App\Models\CuentaPagar;
use App\Models\PagarCuota;
use App\Models\PagarPago;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class CuentasPorPagarController extends Controller
{
  private $toValidated = [
    'concepto' => ['required', 'string', 'max:255'],
    'detalles' => ['required', 'string', 'max:255'],
    'total' => ['required', 'numeric', 'min:0'],
    'saldo' => ['required', 'numeric', 'min:0'],
    'estado' => 'required|in:Pendiente,Cancelado',
    'cuotas' => 'array',
    'cuotas.*.id' => 'integer',
    'cuotas.*.numero_cuota' => 'integer',
    'cuotas.*.fecha_vencimiento' => 'date',
    'cuotas.*.monto' => 'numeric|min:0',
    'cuotas.*.estado' => 'in:pendiente,pagado,vencido',
  ];
  private $toValidatedPago = [
    'metodo_pago' => 'required|string',
    'total_cobro' => 'required|numeric',
    'cuotas_ids' => 'array|min:1',
  ];
  private $toValidatedCuota = [
    'id' => 'required|integer',
    'cuotas' => 'required|array|min:1',
    'cuotas.*.numero_cuota' => 'integer',
    'cuotas.*.fecha_vencimiento' => 'date',
    'cuotas.*.monto' => 'numeric|min:0',
    'cuotas.*.estado' => 'in:pendiente,pagado,vencido',
  ];
  public function index()
  {
    // $cuentaspagar = CuentaPagar::select()->with(['proveedor' => function ($query) {
    //   $query->select('id', 'nombre');
    // }])->paginate(20);

    $cuentaspagar = CuentaPagar::with(['cuotas'])->paginate(20);
    return inertia('admin/cuentasporpagar/lista', ['cuentaspagar' => $cuentaspagar]);
  }

  public function create() {}

  public function store(Request $request)
  {
    $validated = $request->validate($this->toValidated);

    $cuenta = new CuentaPagar();
    $cuenta->user_id = Auth::id();
    $cuenta->concepto = $validated['concepto'];
    $cuenta->detalles = $validated['detalles'];
    $cuenta->total = $validated['total'];
    $cuenta->saldo = $validated['saldo'];
    $cuenta->estado = $validated['estado'];
    $cuenta->plan_pagos = $request['con_plan_pagos'];
    $cuenta->save();

    if ($request['con_plan_pagos'] == true) {
      foreach ($validated['cuotas'] as $cuota) {
        $cuota_cobro = new PagarCuota();
        $cuota_cobro->cuenta_pagar_id = $cuenta->id;
        $cuota_cobro->numero_cuota = $cuota['numero_cuota'];
        $cuota_cobro->fecha_vencimiento = $cuota['fecha_vencimiento'];
        $cuota_cobro->monto = $cuota['monto'];
        $cuota_cobro->estado = $cuota['estado'];
        $cuota_cobro->save();
      }
    }

    return redirect()->route('cuentasporpagar.index');
  }

  public function show(string $id) {}

  public function edit(string $id) {}

  public function update(Request $request, string $id) {}

  public function destroy(string $id) {}

  public function pagar(Request $request, string $id)
  {
    $validated = $request->validate($this->toValidatedPago);

    $cuenta_cobrar = CuentaPagar::find($id);

    foreach ($validated['cuotas_ids'] as $id_cuota) {
      // Actualizar estado
      $cobrar_cuota = PagarCuota::find($id_cuota);
      $cobrar_cuota->estado = 'pagado';
      $cobrar_cuota->update();
      // Guardar pago
      $cobrar_pago = new PagarPago();
      $cobrar_pago->cuenta_pagar_id = $id;
      $cobrar_pago->cuota_id = $cobrar_cuota->id;
      $cobrar_pago->fecha_pago = now();
      $cobrar_pago->monto = $cobrar_cuota->monto;
      $cobrar_pago->metodo_pago = $validated['metodo_pago'];
      $cobrar_pago->save();
      // Actualizar estado de cuenta por cobrar
      $cuenta_cobrar->saldo -= $cobrar_cuota->monto;
      if ($cuenta_cobrar->saldo <= 0) {
        $cuenta_cobrar->estado = 'Cancelado';
      }
      $cuenta_cobrar->update();
    }
    return redirect()->route('cuentasporpagar.index');
  }

  public function cuotas(Request $request)
  {
    $validated = $request->validate($this->toValidatedCuota);

    $cuenta_cobrar = CuentaPagar::find($validated['id']);
    $cuenta_cobrar->plan_pagos = true;
    $cuenta_cobrar->update();

    foreach ($validated['cuotas'] as $cuota) {
      $cuota_cobro = new PagarCuota();
      $cuota_cobro->cuenta_pagar_id = $cuenta_cobrar->id;
      $cuota_cobro->numero_cuota = $cuota['numero_cuota'];
      $cuota_cobro->fecha_vencimiento = $cuota['fecha_vencimiento'];
      $cuota_cobro->monto = $cuota['monto'];
      $cuota_cobro->estado = $cuota['estado'];
      $cuota_cobro->save();
    }
    return redirect()->route('cuentasporpagar.index');
  }
}
