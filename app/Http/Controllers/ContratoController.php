<?php

namespace App\Http\Controllers;

use App\Models\Almacen;
use App\Models\Contrato;
use App\Models\CuentaCobrar;
use App\Models\Empresa;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class ContratoController extends Controller
{
  /**
   * Display a listing of the resource.
   */
  public function index()
  {
    //
    $contratos = Contrato::with('detalles')->get();
    return inertia('admin/contrato/lista', ['contratos' => $contratos]);
    // return inertia('admin/contrato/lista');
  }

  /**
   * Show the form for creating a new resource.
   */
  public function create()
  {
    //
    return inertia('admin/contrato/crear');
  }

  /**
   * Store a newly created resource in storage.
   */
  public function store(Request $request)
  {
    // dd($request);
    //
    $validated = $request->validate([
      'nombre' => 'required|string|max:255',
      'direccion' => 'required|string|max:255',
      'telefono' => 'required|string|max:20',
      'email' => 'required|email',
      'ciudad' => 'required|string|max:100',
      // 'almacen' => 'required|string|max:100',
      'total' => 'required|numeric|min:0',
      'acuenta' => 'required|numeric|min:0',
      'saldo' => 'required|numeric|min:0',
      'almacenes' => 'required|array|min:1',
      'almacenes.*.nombre' => 'required|string|max:255',
      'detalles' => 'required|array|min:1',
      'detalles.*.descripcion' => 'required|string',
      'detalles.*.area' => 'required|numeric|min:0',
      'detalles.*.precio_unitario' => 'required|numeric|min:0',
      'detalles.*.total' => 'required|numeric|min:0',
    ]);

    // dd($validated);

    $totalSuma = 0;
    foreach ($validated['detalles'] as $detalle) {
      $totalSuma += $detalle['total'];
    }

    // Extraer solo los campos que pertenecen a cotizaciones
    $cotizacionData = [
      'nombre' => $validated['nombre'],
      'direccion' => $validated['direccion'],
      'telefono' => $validated['telefono'],
      'email' => $validated['email'],
      'ciudad' => $validated['ciudad'],
      'almacen' => "",
      // 'total' => $validated['total'],      
      'total' => $totalSuma,
      'acuenta' => $validated['acuenta'],
      'saldo' => $validated['saldo'],
    ];
    $cotizacion = Contrato::create($cotizacionData);

    // Detalles
    foreach ($validated['detalles'] as $detalle) {
      $cotizacion->detalles()->create($detalle);
    }

    // CREAR EMPRESA
    $empresa = new Empresa();
    $empresa->nombre = $validated['nombre'];
    $empresa->direccion = $validated['direccion'];
    $empresa->telefono = $validated['telefono'];
    $empresa->email = $validated['email'];
    $empresa->ciudad = $validated['ciudad'];
    $empresa->almacen = "";
    $empresa->activo = true;
    $empresa->save();

    // Almacenes
    foreach ($validated['almacenes'] as $almacen) {
      $almacendb = new Almacen();
      $almacendb->nombre = $almacen['nombre'];
      $almacendb->direccion = $validated['direccion'];
      $almacendb->telefono = $validated['telefono'];
      $almacendb->email = $validated['email'];
      $almacendb->ciudad = $validated['ciudad'];
      $almacendb->empresa_id = $empresa->id;
      $almacendb->contrato_id = $cotizacion->id;
      $almacendb->save();
    }

    // CREAR ALMACEN
    // $almacen = new Almacen();
    // $almacen->nombre = $validated['nombre'];
    // $almacen->direccion = $validated['direccion'];
    // $almacen->telefono = $validated['telefono'];
    // $almacen->email = $validated['email'];
    // $almacen->ciudad = $validated['ciudad'];
    // $almacen->empresa_id = $empresa->id;
    // $almacen->save();



    // Registro: CUENTAS por COBRAR
    if ($validated['saldo'] > 0) {
      $cuentacobrar = new CuentaCobrar();
      $cuentacobrar->contrato_id = $cotizacion->id;
      $cuentacobrar->user_id = Auth::id();
      $cuentacobrar->total = $validated['total'];
      $cuentacobrar->a_cuenta = $validated['acuenta'];
      $cuentacobrar->saldo = $validated['saldo'];
      $cuentacobrar->estado = 'Pendiente';
      $cuentacobrar->save();
    }

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
    //
    //
    // dd("vlksdnvlnsl " . $id);
    $cotizacion = Contrato::with(['detalles', 'almacenes'])->findOrFail($id);
    // dd("vksdbvjks " . $cotizacion);
    // $cotizacion->load('detalles');
    return inertia('admin/contrato/crear', ['cotizacion' => $cotizacion]);
  }

  /**
   * Update the specified resource in storage.
   */
  public function update(Request $request, string $id)
  {

    // dd("TEST");

    //
    $cotizacion = Contrato::with(['detalles', 'almacenes'])->findOrFail($id);


    // dd($cotizacion);
    //
    $validated = $request->validate([
      'nombre' => 'required|string|max:255',
      'direccion' => 'required|string|max:255',
      'telefono' => 'required|string|max:20',
      'email' => 'required|email',
      'ciudad' => 'required|string|max:100',
      'almacenes' => 'required|array|min:1',
      // 'almacenes.*.id' => 'sometimes|exists:almacenes,id',
      'almacenes.*.nombre' => 'required|string|max:255',
      'detalles' => 'required|array|min:1',
      'detalles.*.id' => 'sometimes|exists:contrato_detalles,id', // Para editar existentes
      'detalles.*.descripcion' => 'required|string',
      'detalles.*.area' => 'required|numeric|min:0',
      'detalles.*.precio_unitario' => 'required|numeric|min:0',
      'detalles.*.total' => 'required|numeric|min:0',
      // 'detalles.*.area' => 'required|min:0',
      // 'detalles.*.precio_unitario' => 'required|min:0',
      // 'detalles.*.total' => 'required|min:0',
    ]);

    // dd($validated);

    $empresa = Empresa::where('nombre', $cotizacion['nombre'])->first();

    // Actualizar solo los campos de cotización
    $cotizacion->update([
      'nombre' => $validated['nombre'],
      'direccion' => $validated['direccion'],
      'telefono' => $validated['telefono'],
      'email' => $validated['email'],
      'ciudad' => $validated['ciudad'],
    ]);

    // Sincronizar almacenes: eliminar no enviados, actualizar o crear
    $almacenIds = collect($validated['almacenes'])->pluck('id')->filter();
    $cotizacion->almacenes()->whereNotIn('id', $almacenIds)->delete();

    // foreach ($validated['almacenes'] as $almacen) {
    //   $cotizacion->almacenes()->updateOrCreate(['id' => $almacen['id'] ?? null], $almacen);
    // }

    foreach ($validated['almacenes'] as $almacen) {
      if (isset($almacen['id'])) {
        Almacen::where('id', $almacen['id'])
          ->where('contrato_id', $cotizacion->id) // seguridad: solo almacenes de este contrato
          ->update([
            'nombre'     => $almacen['nombre'],
            'direccion'  => $validated['direccion'],
            'telefono'   => $validated['telefono'],
            'email'      => $validated['email'],
            'ciudad'     => $validated['ciudad'],
            'empresa_id' => $empresa->id,
          ]);
      } else {
        // Si no tiene ID → crear nuevo almacén
        Almacen::create([
          'nombre'       => $almacen['nombre'],
          'direccion'    => $validated['direccion'],
          'telefono'     => $validated['telefono'],
          'email'        => $validated['email'],
          'ciudad'       => $validated['ciudad'],
          'empresa_id'   => $empresa->id,
          'contrato_id'  => $cotizacion->id,
        ]);
      }
    }

    // Sincronizar detalles: eliminar no enviados, actualizar o crear
    $detalleIds = collect($validated['detalles'])->pluck('id')->filter();
    $cotizacion->detalles()->whereNotIn('id', $detalleIds)->delete();

    foreach ($validated['detalles'] as $detalle) {
      $cotizacion->detalles()->updateOrCreate(['id' => $detalle['id'] ?? null], $detalle);
    }

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