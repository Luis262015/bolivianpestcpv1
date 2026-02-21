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
use App\Models\Mapa;
use Barryvdh\DomPDF\Facade\Pdf;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Database\QueryException;

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

    'almacenes' => 'required|array|min:1',
    'almacenes.*.id' => 'integer',
    'almacenes.*.nombre' => 'required|string|max:255',
    'almacenes.*.direccion' => 'required|string|max:255',
    'almacenes.*.telefono' => 'required|string|max:255',
    'almacenes.*.email' => 'required|email',
    'almacenes.*.ciudad' => 'required|string|max:255',
    'almacenes.*.encargado' => 'required|string|max:255',

    'almacenes.*.almacen_trampa' => 'required|array|min:1',
    'almacenes.*.almacen_trampa.id' => 'integer',
    'almacenes.*.almacen_trampa.cantidad' => 'required|numeric|min:0',
    'almacenes.*.almacen_trampa.visitas' => 'required|numeric|min:0',
    'almacenes.*.almacen_trampa.precio' => 'required|numeric|min:0',
    'almacenes.*.almacen_trampa.total' => 'required|numeric|min:0',
    'almacenes.*.almacen_trampa.fechas_visitas' => 'sometimes|required|array|min:1',

    'almacenes.*.almacen_area' => 'required|array|min:1',
    'almacenes.*.almacen_area.id' => 'integer',
    'almacenes.*.almacen_area.area' => 'required|numeric|min:0',
    'almacenes.*.almacen_area.visitas' => 'required|numeric|min:0',
    'almacenes.*.almacen_area.precio' => 'required|numeric|min:0',
    'almacenes.*.almacen_area.total' => 'required|numeric|min:0',
    'almacenes.*.almacen_area.fechas_visitas' => 'sometimes|required|array|min:1',

    'almacenes.*.almacen_insectocutor' => 'required|array|min:1',
    'almacenes.*.almacen_insectocutor.id' => 'integer',
    'almacenes.*.almacen_insectocutor.cantidad' => 'required|numeric|min:0',
    'almacenes.*.almacen_insectocutor.visitas' => 'required|numeric|min:0',
    'almacenes.*.almacen_insectocutor.precio' => 'required|numeric|min:0',
    'almacenes.*.almacen_insectocutor.total' => 'required|numeric|min:0',
    'almacenes.*.almacen_insectocutor.fechas_visitas' => 'sometimes|required|array|min:1',
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
    $validated = $request->validate($this->toValidated);
    try {
      DB::beginTransaction();

      $totalSuma = 0;
      foreach ($validated['almacenes'] as $almacen) {
        $totalSuma += $almacen['almacen_trampa']['total'] + $almacen['almacen_area']['total'] + $almacen['almacen_insectocutor']['total'];
      }

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
        $insect->visitas = $almacen['almacen_insectocutor']['visitas'];
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
        $detalles->i_visitas = $almacen['almacen_insectocutor']['visitas'];
        $detalles->i_precio = $almacen['almacen_insectocutor']['precio'];
        $detalles->i_total = $almacen['almacen_insectocutor']['total'];
        $detalles->total = 0;
        $detalles->save();

        // FECHAS A CRONOGRAMA
        // -- Fechas trampas
        foreach ($almacen['almacen_trampa']['fechas_visitas'] as $fecha) {
          $cronograma = new Cronograma();
          $cronograma->empresa_id = $empresa->id;
          $cronograma->almacen_id = $almacendb->id;
          $cronograma->user_id = Auth::id();
          $cronograma->tecnico_id = Auth::id();
          $cronograma->tipo_seguimiento_id = 1;
          $cronograma->title = 'DESRATIZACION';
          $cronograma->date = $fecha;
          $cronograma->color = 'bg-yellow-500';
          $cronograma->status = 'pendiente';
          $cronograma->save();
        }
        // -- Fechas fumigacion
        foreach ($almacen['almacen_area']['fechas_visitas'] as $fecha) {
          $cronograma = new Cronograma();
          $cronograma->empresa_id = $empresa->id;
          $cronograma->almacen_id = $almacendb->id;
          $cronograma->user_id = Auth::id();
          $cronograma->tecnico_id = Auth::id();
          $cronograma->tipo_seguimiento_id = 2;
          $cronograma->title = 'DESINFECCION';
          $cronograma->date = $fecha;
          $cronograma->color = 'bg-blue-500';
          $cronograma->status = 'pendiente';
          $cronograma->save();
        }
        // -- Fechas insectocutores
        foreach ($almacen['almacen_insectocutor']['fechas_visitas'] as $fecha) {
          $cronograma = new Cronograma();
          $cronograma->empresa_id = $empresa->id;
          $cronograma->almacen_id = $almacendb->id;
          $cronograma->user_id = Auth::id();
          $cronograma->tecnico_id = Auth::id();
          $cronograma->tipo_seguimiento_id = 3;
          $cronograma->title = 'DESINSECTACION';
          $cronograma->date = $fecha;
          $cronograma->color = 'bg-pink-600';
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
      DB::commit();

      return redirect()->route('contratos.index');
    } catch (Exception | \Error | QueryException $e) {
      DB::rollBack();
      Log::error('Error al guardar compra:', ['error' => $e->getMessage()]);
      return redirect()->back()
        ->withInput()
        ->with('error', 'Error al guardar la compra: ' . $e->getMessage());
    }
  }

  public function edit(string $id)
  {
    $contrato = Contrato::with(['detalles', 'empresa'])->findOrFail($id);
    $almacenes = Almacen::where('empresa_id', $contrato->empresa_id)->with(['almacenTrampa', 'almacenArea', 'almacenInsectocutor'])->get();
    return inertia('admin/contrato/editar', ['contrato' => $contrato, 'almacenes' => $almacenes]);
  }

  public function update(Request $request, string $id)
  {

    $validated = $request->validate($this->toValidated);

    try {
      DB::beginTransaction();

      $totalSuma = 0;
      foreach ($validated['almacenes'] as $almacen) {
        $totalSuma += $almacen['almacen_trampa']['total'] + $almacen['almacen_area']['total'] + $almacen['almacen_insectocutor']['total'];
      }

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
          $insect->visitas = $almacen['almacen_insectocutor']['visitas'];
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
          $detalles->i_visitas = $almacen['almacen_insectocutor']['visitas'];
          $detalles->i_precio = $almacen['almacen_insectocutor']['precio'];
          $detalles->i_total = $almacen['almacen_insectocutor']['total'];
          $detalles->update();
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
          $insect->visitas = $almacen['almacen_insectocutor']['visitas'];
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
        }
      }

      $cuenta = CuentaCobrar::where('contrato_id', $contrato->id)->first();
      if ($cuenta->total == $cuenta->saldo) {
        $cuenta->saldo = $totalSuma;
      }
      $cuenta->total = $totalSuma;
      $cuenta->update();

      DB::commit();

      return redirect()->route('contratos.index');
    } catch (Exception | \Error | QueryException $e) {
      DB::rollBack();
      Log::error('Error:', ['error' => $e->getMessage()]);
      return redirect()->back()
        ->withInput()
        ->with('error', 'Error ' . $e->getMessage());
    }
  }

  public function destroy(string $id)
  {
    try {
      DB::beginTransaction();

      // Conseguir CONTRATO, EMPRESA, ALMACEN
      $contrato = Contrato::find($id);
      $empresa = Empresa::find($contrato->empresa_id);
      $almacenes = Almacen::where('empresa_id', $empresa->id)->get();

      // Eliminar cuentas por cobrar
      CuentaCobrar::where('contrato_id', $contrato->id)->delete();

      // Eliminar detalles de contrato
      ContratoDetalles::where('contrato_id', $contrato->id)->delete();

      // Eliminar mapas
      Mapa::where('empresa_id', $empresa->id)->delete();

      foreach ($almacenes as $almacen) {
        // Eliminar tareas de cronogramas
        Cronograma::where('almacen_id', $almacen->id)->delete();

        // Eliminar datos de almacenes
        AlmacenTrampa::where('almacen_id', $almacen->id)->delete();
        AlmacenArea::where('almacen_id', $almacen->id)->delete();
        AlmancenInsectocutor::where('almacen_id', $almacen->id)->delete();
      }

      // Eliminar almacenes
      Almacen::where('empresa_id', $empresa->id)->delete();

      // Eliminar contrato
      $contrato->delete();

      // Eliminar empresa
      $empresa->delete();

      DB::commit();
      return redirect()->route('contratos.index');
    } catch (Exception | \Error | QueryException $e) {
      DB::rollBack();
      Log::error('Error:', ['error' => $e->getMessage()]);
      return redirect()->back()
        ->withInput()
        ->with('error', 'Error ' . $e->getMessage());
    }
  }

  public function pdf(Request $request, string $id)
  {
    $contrato = Contrato::with(['empresa'])->find($id);
    $almacenes = Almacen::with(['almacenTrampa', 'almacenArea', 'almacenInsectocutor', 'tareas'])->where('empresa_id', $contrato->empresa_id)->get();
    $pdf = Pdf::loadView('pdf.contrato', compact(['contrato', 'almacenes']));
    $pdf->setPaper('letter', 'portrait');
    return $pdf->stream('contrato-' . now()->format('Y-m-d') . '.pdf');
  }

  /** FUNCIONES NO USADAS */
  // public function show(string $id) {}
}
