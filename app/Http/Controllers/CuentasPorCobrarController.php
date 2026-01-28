<?php

namespace App\Http\Controllers;

use App\Models\CobrarCuota;
use App\Models\CobrarPago;
use App\Models\CuentaCobrar;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Database\QueryException;

use function Symfony\Component\Clock\now;

class CuentasPorCobrarController extends Controller
{
  private $toValidated = [
    'concepto' => ['required', 'string', 'max:255'],
    'detalles' => ['required', 'string', 'max:255'],
    'total' => ['required', 'numeric', 'min:0'],
    // 'saldo' => ['required', 'numeric', 'min:0'],
    // 'estado' => 'required|in:Pendiente,Cancelado',
    'cuotas' => 'array',
    'cuotas.*.id' => 'integer',
    'cuotas.*.numero_cuota' => 'integer',
    'cuotas.*.fecha_vencimiento' => 'date',
    'cuotas.*.monto' => 'numeric|min:0',
    'cuotas.*.estado' => 'in:pendiente,pagado,vencido',
  ];
  private $toValidatedCobro = [
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
    $cuentascobrar = CuentaCobrar::with(['cuotas'])->paginate(20);
    return inertia('admin/cuentasporcobrar/lista', ['cuentascobrar' =>  $cuentascobrar]);
  }

  public function store(Request $request)
  {
    $validated = $request->validate($this->toValidated);

    $cuenta = new CuentaCobrar();
    $cuenta->user_id = Auth::id();
    $cuenta->concepto = $validated['concepto'];
    $cuenta->detalles = $validated['detalles'];
    $cuenta->total = $validated['total'];
    $cuenta->saldo = $validated['total'];
    $cuenta->estado = 'Pendiente';
    $cuenta->plan_pagos = $request['con_plan_pagos'];
    $cuenta->save();

    if ($request['con_plan_pagos'] == true) {
      foreach ($validated['cuotas'] as $cuota) {
        $cuota_cobro = new CobrarCuota();
        $cuota_cobro->cuenta_cobrar_id = $cuenta->id;
        $cuota_cobro->numero_cuota = $cuota['numero_cuota'];
        $cuota_cobro->fecha_vencimiento = $cuota['fecha_vencimiento'];
        $cuota_cobro->monto = $cuota['monto'];
        $cuota_cobro->estado = $cuota['estado'];
        $cuota_cobro->save();
      }
    }

    return redirect()->route('cuentasporcobrar.index');
  }



  public function destroy(string $id)
  {
    $cuenta = CuentaCobrar::find($id);
    if ($cuenta->contrato_id != null) {
      return redirect()->back()
        ->withInput()
        ->withErrors(['error', 'No se puede eliminar el registro']);
    }
    try {
      DB::beginTransaction();
      $pagos = CobrarPago::where('cuenta_cobrar_id', $cuenta->id)->get();
      if (count($pagos) > 0) {
        throw new Exception('No se puede eliminar el registro');
      }
      CobrarCuota::where('cuenta_cobrar_id', $cuenta->id)->delete();
      $cuenta->delete();
      DB::commit();
      return redirect()->back()->with('success', "Mensaje");
    } catch (Exception | \Error | QueryException $e) {
      DB::rollBack();
      Log::error('Error:', ['error' => $e->getMessage()]);
      return redirect()->back()
        ->withInput()
        ->withErrors(['error', 'ERROR:' . $e->getMessage()]);
    }
  }

  public function cobrar(Request $request, string $id)
  {
    $validated = $request->validate($this->toValidatedCobro);

    $cuenta_cobrar = CuentaCobrar::find($id);

    foreach ($validated['cuotas_ids'] as $id_cuota) {
      // Actualizar estado
      $cobrar_cuota = CobrarCuota::find($id_cuota);
      $cobrar_cuota->estado = 'pagado';
      $cobrar_cuota->update();
      // Guardar pago
      $cobrar_pago = new CobrarPago();
      $cobrar_pago->cuenta_cobrar_id = $id;
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
    return redirect()->route('cuentasporcobrar.index');
  }

  public function cuotas(Request $request)
  {
    $validated = $request->validate($this->toValidatedCuota);

    $cuenta_cobrar = CuentaCobrar::find($validated['id']);
    $cuenta_cobrar->plan_pagos = true;
    $cuenta_cobrar->update();

    foreach ($validated['cuotas'] as $cuota) {
      $cuota_cobro = new CobrarCuota();
      $cuota_cobro->cuenta_cobrar_id = $cuenta_cobrar->id;
      $cuota_cobro->numero_cuota = $cuota['numero_cuota'];
      $cuota_cobro->fecha_vencimiento = $cuota['fecha_vencimiento'];
      $cuota_cobro->monto = $cuota['monto'];
      $cuota_cobro->estado = $cuota['estado'];
      $cuota_cobro->save();
    }
    return redirect()->route('cuentasporcobrar.index');
  }

  /** FUNCIONES NO USADAS */
  // public function create() {}
  // public function show(string $id) {}
  // public function edit(string $id) {}
  // public function update(Request $request, string $id) {}
}
