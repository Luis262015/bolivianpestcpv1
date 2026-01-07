<?php

namespace App\Http\Controllers;

use App\Models\Almacen;
use App\Models\AlmacenArea;
use App\Models\AlmacenTrampa;
use App\Models\AlmancenInsectocutor;
use App\Models\Contacto;
use App\Models\Contrato;
use App\Models\ContratoDetalles;
use App\Models\Cronograma;
use App\Models\CuentaCobrar;
use App\Models\Empresa;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;

class ContratoController extends Controller
{

  // ARRAY para validacion de datos de formulario
  private $toValidated = [
    'nombre' => 'required|string|max:255',
    'direccion' => 'required|string|max:255',
    'telefono' => 'required|string|max:20',
    'email' => 'required|email',
    'ciudad' => 'required|string|max:100',
    'total' => 'required|numeric|min:0',
    'expiracion' => 'required|date',
    // 'acuenta' => 'required|numeric|min:0',
    // 'saldo' => 'required|numeric|min:0',

    'almacenes' => 'required|array|min:1',
    'almacenes.*.id' => 'integer',
    'almacenes.*.nombre' => 'required|string|max:255',
    'almacenes.*.direccion' => 'required|string|max:255',
    'almacenes.*.telefono' => 'required|string|max:255',
    'almacenes.*.email' => 'required|email',
    'almacenes.*.ciudad' => 'required|string|max:255',
    'almacenes.*.encargado' => 'required|string|max:255',

    'almacenes.*.almacen_trampa' => 'required|array|min:1',
    // 'almacenes.*.almacen_trampa.descripcion' => 'required|string|max:255',
    'almacenes.*.almacen_trampa.id' => 'integer',
    'almacenes.*.almacen_trampa.cantidad' => 'required|numeric|min:0',
    'almacenes.*.almacen_trampa.visitas' => 'required|numeric|min:0',
    'almacenes.*.almacen_trampa.precio' => 'required|numeric|min:0',
    'almacenes.*.almacen_trampa.total' => 'required|numeric|min:0',
    'almacenes.*.almacen_trampa.fechas_visitas' => 'sometimes|required|array|min:1',

    'almacenes.*.almacen_area' => 'required|array|min:1',
    // 'almacenes.*.almacen_area.descripcion' => 'required|string|max:255',
    'almacenes.*.almacen_area.id' => 'integer',
    'almacenes.*.almacen_area.area' => 'required|numeric|min:0',
    'almacenes.*.almacen_area.visitas' => 'required|numeric|min:0',
    'almacenes.*.almacen_area.precio' => 'required|numeric|min:0',
    'almacenes.*.almacen_area.total' => 'required|numeric|min:0',
    'almacenes.*.almacen_area.fechas_visitas' => 'sometimes|required|array|min:1',

    'almacenes.*.almacen_insectocutor' => 'required|array|min:1',
    // 'almacenes.*.almacen_insectocutor.descripcion' => 'required|string|max:255',
    'almacenes.*.almacen_insectocutor.id' => 'integer',
    'almacenes.*.almacen_insectocutor.cantidad' => 'required|numeric|min:0',
    'almacenes.*.almacen_insectocutor.precio' => 'required|numeric|min:0',
    'almacenes.*.almacen_insectocutor.total' => 'required|numeric|min:0',
  ];

  public function index()
  {
    $contratos = Contrato::with('detalles')
      ->with(['empresa' => function ($query) {
        $query->select('id', 'nombre');
      }])
      ->paginate(20);
    return inertia('admin/contrato/lista', ['contratos' => $contratos]);
  }

  public function create()
  {
    return inertia('admin/contrato/crear');
  }

  public function store(Request $request)
  {

    // dd($request);

    $validated = $request->validate($this->toValidated);

    // dd($validated);

    $totalSuma = 0;
    foreach ($validated['almacenes'] as $almacen) {
      // $totalSuma += $detalle['total'];
      $totalSuma += $almacen['almacen_trampa']['total'] + $almacen['almacen_area']['total'] + $almacen['almacen_insectocutor']['total'];
    }

    // dd($totalSuma);

    // CREAR EMPRESA
    $empresa = new Empresa();
    $empresa->nombre = $validated['nombre'];
    $empresa->direccion = $validated['direccion'];
    $empresa->telefono = $validated['telefono'];
    $empresa->email = $validated['email'];
    $empresa->ciudad = $validated['ciudad'];
    $empresa->activo = true;
    $empresa->save();

    // CREAR CONTRATO
    $contratoData = [
      'empresa_id' => $empresa->id,
      'total' => $totalSuma,
      'expiracion' => $validated['expiracion'],
    ];
    $contrato = Contrato::create($contratoData);

    // Detalles
    // foreach ($validated['detalles'] as $detalle) {
    //   $cotizacion->detalles()->create($detalle);
    // }

    // Almacenes
    foreach ($validated['almacenes'] as $almacen) {
      // CREAR DATOS DE ALMACEN
      $almacendb = new Almacen();
      $almacendb->empresa_id = $empresa->id;
      $almacendb->nombre = $almacen['nombre'];
      $almacendb->direccion = $almacen['direccion'];
      $almacendb->encargado = $almacen['encargado'];
      $almacendb->telefono = $almacen['telefono'];
      $almacendb->email = $almacen['email'];
      $almacendb->ciudad = $almacen['ciudad'];
      $almacendb->save();
      // - DATOS DE ALMANCEN TRAMPAS
      $trampas = new AlmacenTrampa();
      $trampas->almacen_id = $almacendb->id;
      $trampas->cantidad = $almacen['almacen_trampa']['cantidad'];
      $trampas->visitas = $almacen['almacen_trampa']['visitas'];
      $trampas->precio = $almacen['almacen_trampa']['precio'];
      $trampas->total = $almacen['almacen_trampa']['total'];
      $trampas->save();
      // - DATOS DE ALMANCEN AREAS
      $areas = new AlmacenArea();
      $areas->almacen_id = $almacendb->id;
      $areas->area = $almacen['almacen_area']['area'];
      $areas->visitas = $almacen['almacen_area']['visitas'];
      $areas->precio = $almacen['almacen_area']['precio'];
      $areas->total = $almacen['almacen_area']['total'];
      $areas->save();
      // - DATOS DE ALMANCEN INSECTOCUTORES
      $insect = new AlmancenInsectocutor();
      $insect->almacen_id = $almacendb->id;
      $insect->cantidad = $almacen['almacen_insectocutor']['cantidad'];
      $insect->precio = $almacen['almacen_insectocutor']['precio'];
      $insect->total = $almacen['almacen_insectocutor']['total'];
      $insect->save();

      // DETALLES DE CONTRATO
      $detalles = new ContratoDetalles();
      $detalles->contrato_id = $contrato->id;
      $detalles->nombre = $almacen['nombre'];
      $detalles->t_cantidad = $almacen['almacen_trampa']['cantidad'];
      $detalles->t_visitas = $almacen['almacen_trampa']['visitas'];
      $detalles->t_precio = $almacen['almacen_trampa']['precio'];
      $detalles->t_total = $almacen['almacen_trampa']['total'];
      $detalles->a_area = $almacen['almacen_area']['area'];
      $detalles->a_visitas = $almacen['almacen_area']['visitas'];
      $detalles->a_precio = $almacen['almacen_area']['precio'];
      $detalles->a_total = $almacen['almacen_area']['total'];
      $detalles->i_cantidad = $almacen['almacen_insectocutor']['cantidad'];
      $detalles->i_precio = $almacen['almacen_insectocutor']['precio'];
      $detalles->i_total = $almacen['almacen_insectocutor']['total'];
      $detalles->total = 0;
      $detalles->save();

      // FECHAS A CRONOGRAMA
      // -- Fechas trampas
      foreach ($almacen['almacen_trampa']['fechas_visitas'] as $fecha) {
        $cronograma = new Cronograma();
        $cronograma->almacen_id = $almacendb->id;
        $cronograma->user_id = Auth::id();
        $cronograma->tecnico_id = Auth::id();
        $cronograma->title = 'Trampas';
        $cronograma->date = $fecha;
        $cronograma->color = 'bg-yellow-500';
        $cronograma->status = 'pendiente';
        $cronograma->save();
      }
      // -- Fechas fumigacion
      foreach ($almacen['almacen_area']['fechas_visitas'] as $fecha) {
        $cronograma = new Cronograma();
        $cronograma->almacen_id = $almacendb->id;
        $cronograma->user_id = Auth::id();
        $cronograma->tecnico_id = Auth::id();
        $cronograma->title = 'Fumigacion';
        $cronograma->date = $fecha;
        $cronograma->color = 'bg-blue-500';
        $cronograma->status = 'pendiente';
        $cronograma->save();
      }
      // -------------
    }

    // Registro: CUENTAS por COBRAR
    $cuenta = new CuentaCobrar();
    $cuenta->contrato_id = $contrato->id;
    $cuenta->user_id = Auth::id();
    $cuenta->concepto = 'Contrato por cobrar #' . $contrato->id;
    $cuenta->detalles = 'Saldo pendiento por cobrar sobre contrato';
    $cuenta->total = $totalSuma;
    $cuenta->saldo = $totalSuma;
    $cuenta->estado = 'Pendiente';
    $cuenta->plan_pagos = false;
    $cuenta->save();

    // if ($validated['saldo'] > 0) {
    //   $cuentacobrar = new CuentaCobrar();
    //   $cuentacobrar->contrato_id = $contrato->id;
    //   $cuentacobrar->user_id = Auth::id();
    //   $cuentacobrar->total = $validated['total'];
    //   $cuentacobrar->a_cuenta = $validated['acuenta'];
    //   $cuentacobrar->saldo = $validated['saldo'];
    //   $cuentacobrar->estado = 'Pendiente';
    //   $cuentacobrar->save();
    // }

    return redirect()->route('contratos.index');
  }

  /**
   * Display the specified resource.
   */
  public function show(string $id)
  {
    //
  }

  /**
   * Show the form for editing the specified resource.
   */
  public function edit(string $id)
  {
    $contrato = Contrato::with(['detalles', 'empresa'])->findOrFail($id);
    $almacenes = Almacen::where('empresa_id', $contrato->empresa_id)->with(['almacenTrampa', 'almacenArea', 'almacenInsectocutor'])->get();
    return inertia('admin/contrato/editar', ['contrato' => $contrato, 'almacenes' => $almacenes]);
  }

  /**
   * Update the specified resource in storage.
   */
  public function update(Request $request, string $id)
  {

    // dd($request);

    $validated = $request->validate($this->toValidated);

    $totalSuma = 0;
    foreach ($validated['almacenes'] as $almacen) {
      $totalSuma += $almacen['almacen_trampa']['total'] + $almacen['almacen_area']['total'] + $almacen['almacen_insectocutor']['total'];
    }

    // dd($validated);

    $contrato = Contrato::with(['detalles', 'empresa'])->findOrFail($id);

    $contrato->update([
      'total' => $totalSuma,
      'expiracion' => $validated['expiracion'],
    ]);

    $empresa = Empresa::find($contrato->empresa_id);
    $empresa->update([
      'nombre' => $validated['nombre'],
      'direccion' => $validated['direccion'],
      'telefono' => $validated['telefono'],
      'email' => $validated['email'],
      'ciudad' => $validated['ciudad'],
    ]);


    foreach ($validated['almacenes'] as $almacen) {

      if (isset($almacen['id'])) {
        $almacenDB = Almacen::find($almacen['id']);
        $almacenDB->update([
          'nombre' => $almacen['nombre'],
          'direccion' => $almacen['direccion'],
          'telefono' => $almacen['telefono'],
          'email' => $almacen['email'],
          'ciudad' => $almacen['ciudad'],
          'encargado' => $almacen['encargado'],
        ]);
        // -- Actualizacion de trampas
        $trampas = AlmacenTrampa::where('almacen_id', $almacen['id'])->first();
        $trampas->cantidad = $almacen['almacen_trampa']['cantidad'];
        $trampas->visitas = $almacen['almacen_trampa']['visitas'];
        $trampas->precio = $almacen['almacen_trampa']['precio'];
        $trampas->total = $almacen['almacen_trampa']['total'];
        $trampas->update();
        // -- Actualizacion de areas
        $areas = AlmacenArea::where('almacen_id', $almacen['id'])->first();
        $areas->area = $almacen['almacen_area']['area'];
        $areas->visitas = $almacen['almacen_area']['visitas'];
        $areas->precio = $almacen['almacen_area']['precio'];
        $areas->total = $almacen['almacen_area']['total'];
        $areas->update();
        // -- Actualizacion de insectocutores
        $insect = AlmancenInsectocutor::where('almacen_id', $almacen['id'])->first();
        $insect->cantidad = $almacen['almacen_insectocutor']['cantidad'];
        $insect->precio = $almacen['almacen_insectocutor']['precio'];
        $insect->total = $almacen['almacen_insectocutor']['total'];
        $insect->update();

        $detalles = ContratoDetalles::where('contrato_id', $contrato['id'])->first();
        $detalles->nombre = $almacen['nombre'];
        $detalles->t_cantidad = $almacen['almacen_trampa']['cantidad'];
        $detalles->t_visitas = $almacen['almacen_trampa']['visitas'];
        $detalles->t_precio = $almacen['almacen_trampa']['precio'];
        $detalles->t_total = $almacen['almacen_trampa']['total'];
        $detalles->a_area = $almacen['almacen_area']['area'];
        $detalles->a_visitas = $almacen['almacen_area']['visitas'];
        $detalles->a_precio = $almacen['almacen_area']['precio'];
        $detalles->a_total = $almacen['almacen_area']['total'];
        $detalles->i_cantidad = $almacen['almacen_insectocutor']['cantidad'];
        $detalles->i_precio = $almacen['almacen_insectocutor']['precio'];
        $detalles->i_total = $almacen['almacen_insectocutor']['total'];
        $detalles->update();

        // $totalSuma += $almacen['almacen_trampa']['total'] + $almacen['almacen_area']['total'] + $almacen['almacen_insectocutor']['total'];
      } else {

        // CREAR DATOS DE ALMACEN
        $almacendb = new Almacen();
        $almacendb->empresa_id = $empresa->id;
        $almacendb->nombre = $almacen['nombre'];
        $almacendb->direccion = $almacen['direccion'];
        $almacendb->encargado = $almacen['encargado'];
        $almacendb->telefono = $almacen['telefono'];
        $almacendb->email = $almacen['email'];
        $almacendb->ciudad = $almacen['ciudad'];
        $almacendb->save();
        // - DATOS DE ALMANCEN TRAMPAS
        $trampas = new AlmacenTrampa();
        $trampas->almacen_id = $almacendb->id;
        $trampas->cantidad = $almacen['almacen_trampa']['cantidad'];
        $trampas->visitas = $almacen['almacen_trampa']['visitas'];
        $trampas->precio = $almacen['almacen_trampa']['precio'];
        $trampas->total = $almacen['almacen_trampa']['total'];
        $trampas->save();
        // - DATOS DE ALMANCEN AREAS
        $areas = new AlmacenArea();
        $areas->almacen_id = $almacendb->id;
        $areas->area = $almacen['almacen_area']['area'];
        $areas->visitas = $almacen['almacen_area']['visitas'];
        $areas->precio = $almacen['almacen_area']['precio'];
        $areas->total = $almacen['almacen_area']['total'];
        $areas->save();
        // - DATOS DE ALMANCEN INSECTOCUTORES
        $insect = new AlmancenInsectocutor();
        $insect->almacen_id = $almacendb->id;
        $insect->cantidad = $almacen['almacen_insectocutor']['cantidad'];
        $insect->precio = $almacen['almacen_insectocutor']['precio'];
        $insect->total = $almacen['almacen_insectocutor']['total'];
        $insect->save();

        // DETALLES DE CONTRATO
        $detalles = new ContratoDetalles();
        $detalles->contrato_id = $contrato->id;
        $detalles->nombre = $almacen['nombre'];
        $detalles->t_cantidad = $almacen['almacen_trampa']['cantidad'];
        $detalles->t_visitas = $almacen['almacen_trampa']['visitas'];
        $detalles->t_precio = $almacen['almacen_trampa']['precio'];
        $detalles->t_total = $almacen['almacen_trampa']['total'];
        $detalles->a_area = $almacen['almacen_area']['area'];
        $detalles->a_visitas = $almacen['almacen_area']['visitas'];
        $detalles->a_precio = $almacen['almacen_area']['precio'];
        $detalles->a_total = $almacen['almacen_area']['total'];
        $detalles->i_cantidad = $almacen['almacen_insectocutor']['cantidad'];
        $detalles->i_precio = $almacen['almacen_insectocutor']['precio'];
        $detalles->i_total = $almacen['almacen_insectocutor']['total'];
        $detalles->total = 0;
        $detalles->save();

        // $totalSuma += $almacen['almacen_trampa']['total'] + $almacen['almacen_area']['total'] + $almacen['almacen_insectocutor']['total'];
      }
    }

    $cuenta = CuentaCobrar::where('contrato_id', $contrato->id)->first();
    if ($cuenta->total == $cuenta->saldo) {
      $cuenta->saldo = $totalSuma;
    }
    $cuenta->total = $totalSuma;
    $cuenta->update();
    // dd("Actualizado");

    // $empresa = Empresa::where('nombre', $cotizacion['nombre'])->first();

    // // Actualizar solo los campos de cotización
    // $cotizacion->update([
    //   'nombre' => $validated['nombre'],
    //   'direccion' => $validated['direccion'],
    //   'telefono' => $validated['telefono'],
    //   'email' => $validated['email'],
    //   'ciudad' => $validated['ciudad'],
    // ]);

    // // Sincronizar almacenes: eliminar no enviados, actualizar o crear
    // $almacenIds = collect($validated['almacenes'])->pluck('id')->filter();
    // $cotizacion->almacenes()->whereNotIn('id', $almacenIds)->delete();

    // // foreach ($validated['almacenes'] as $almacen) {
    // //   $cotizacion->almacenes()->updateOrCreate(['id' => $almacen['id'] ?? null], $almacen);
    // // }

    // foreach ($validated['almacenes'] as $almacen) {
    //   if (isset($almacen['id'])) {
    //     Almacen::where('id', $almacen['id'])
    //       ->where('contrato_id', $cotizacion->id) // seguridad: solo almacenes de este contrato
    //       ->update([
    //         'nombre'     => $almacen['nombre'],
    //         'direccion'  => $validated['direccion'],
    //         'telefono'   => $validated['telefono'],
    //         'email'      => $validated['email'],
    //         'ciudad'     => $validated['ciudad'],
    //         'empresa_id' => $empresa->id,
    //       ]);
    //   } else {
    //     // Si no tiene ID → crear nuevo almacén
    //     Almacen::create([
    //       'nombre'       => $almacen['nombre'],
    //       'direccion'    => $validated['direccion'],
    //       'telefono'     => $validated['telefono'],
    //       'email'        => $validated['email'],
    //       'ciudad'       => $validated['ciudad'],
    //       'empresa_id'   => $empresa->id,
    //       'contrato_id'  => $cotizacion->id,
    //     ]);
    //   }
    // }

    // // Sincronizar detalles: eliminar no enviados, actualizar o crear
    // $detalleIds = collect($validated['detalles'])->pluck('id')->filter();
    // $cotizacion->detalles()->whereNotIn('id', $detalleIds)->delete();

    // foreach ($validated['detalles'] as $detalle) {
    //   $cotizacion->detalles()->updateOrCreate(['id' => $detalle['id'] ?? null], $detalle);
    // }

    return redirect()->route('contratos.index');
  }

  /**
   * Remove the specified resource from storage.
   */
  public function destroy(Contrato $contrato)
  {
    //
    $contrato->delete();
    return redirect()->route('contratos.index');
  }
}
