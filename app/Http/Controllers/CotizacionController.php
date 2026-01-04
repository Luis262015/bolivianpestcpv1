<?php

namespace App\Http\Controllers;

use App\Models\Cotizacion;
use App\Models\CotizacionDetalles;
use Illuminate\Http\Request;

class CotizacionController extends Controller
{

  private $toValidated = [
    'nombre' => 'required|string|max:255',
    'email' => 'required|email',
    'telefono' => 'required|string|max:20',
    // 'direccion' => 'required|string|max:255',
    // 'ciudad' => 'required|string|max:100',
    'total' => 'required|numeric|min:0',
    // 'acuenta' => 'required|numeric|min:0',
    // 'saldo' => 'required|numeric|min:0',

    'detalles' => 'required|array|min:1',
    'detalles.*.nombre' => 'required|string|max:255',

    // 'almacenes.*.almacen_trampa' => 'required|array|min:1',
    // 'almacenes.*.almacen_trampa.descripcion' => 'required|string|max:255',
    'detalles.*.t_cantidad' => 'required|numeric|min:0',
    'detalles.*.t_visitas' => 'required|numeric|min:0',
    'detalles.*.t_precio' => 'required|numeric|min:0',
    'detalles.*.t_total' => 'required|numeric|min:0',
    // 'almacenes.*.almacen_trampa.fechas_visitas' => 'required|array|min:1',

    // 'almacenes.*.almacen_area' => 'required|array|min:1',
    // 'almacenes.*.almacen_area.descripcion' => 'required|string|max:255',
    'detalles.*.a_area' => 'required|numeric|min:0',
    'detalles.*.a_visitas' => 'required|numeric|min:0',
    'detalles.*.a_precio' => 'required|numeric|min:0',
    'detalles.*.a_total' => 'required|numeric|min:0',
    // 'almacenes.*.almacen_area.fechas_visitas' => 'required|array|min:1',

    // 'almacenes.*.almacen_insectocutor' => 'required|array|min:1',
    // 'almacenes.*.almacen_insectocutor.descripcion' => 'required|string|max:255',
    'detalles.*.i_cantidad' => 'required|numeric|min:0',
    'detalles.*.i_precio' => 'required|numeric|min:0',
    'detalles.*.i_total' => 'required|numeric|min:0',
  ];

  public function index()
  {
    $cotizaciones = Cotizacion::with('detalles')->get();
    return inertia('admin/cotizacion/lista', ['cotizaciones' => $cotizaciones]);
  }

  public function create()
  {
    return inertia('admin/cotizacion/crear');
  }

  public function store(Request $request)
  {
    // $validated = $request->validate([
    //   'nombre' => 'required|string|max:255',
    //   'direccion' => 'required|string|max:255',
    //   'telefono' => 'required|string|max:20',
    //   'email' => 'required|email',
    //   'ciudad' => 'required|string|max:100',
    //   'detalles' => 'required|array|min:1',
    //   'detalles.*.descripcion' => 'required|string',
    //   'detalles.*.area' => 'required|numeric|min:0',
    //   'detalles.*.precio_unitario' => 'required|numeric|min:0',
    //   'detalles.*.total' => 'required|numeric|min:0',
    // ]);

    // dd("CREAR COTIZACION");
    // dd($request);

    $validated = $request->validate($this->toValidated);

    // dd($validated);

    $totalSuma = 0;
    foreach ($validated['detalles'] as $detalle) {
      $totalSuma += $detalle['t_total'] + $detalle['a_total'] +  $detalle['i_total'];
    }

    // dd($totalSuma);

    // Extraer solo los campos que pertenecen a cotizaciones
    $cotizacionData = [
      'nombre' => $validated['nombre'],
      'email' => $validated['email'],
      'telefono' => $validated['telefono'],
      // 'direccion' => $validated['direccion'],
      // 'ciudad' => $validated['ciudad'],
      'total' => $totalSuma,
    ];

    $cotizacion = Cotizacion::create($cotizacionData);

    foreach ($validated['detalles'] as $detalle) {
      // Guardar detalles de cotizacion
      $cotizacion_detalles = new CotizacionDetalles();
      $cotizacion_detalles->cotizacion_id = $cotizacion->id;
      $cotizacion_detalles->nombre = $detalle['nombre'];
      // - servicio de trampas
      $cotizacion_detalles->t_cantidad = $detalle['t_cantidad'];
      $cotizacion_detalles->t_visitas = $detalle['t_visitas'];
      $cotizacion_detalles->t_precio = $detalle['t_precio'];
      $cotizacion_detalles->t_total = $detalle['t_total'];
      // - servicio por area
      $cotizacion_detalles->a_area = $detalle['a_area'];
      $cotizacion_detalles->a_visitas = $detalle['a_visitas'];
      $cotizacion_detalles->a_precio = $detalle['a_precio'];
      $cotizacion_detalles->a_total = $detalle['a_total'];
      // - servicio por insectocutores
      $cotizacion_detalles->i_cantidad = $detalle['i_cantidad'];
      $cotizacion_detalles->i_precio = $detalle['i_precio'];
      $cotizacion_detalles->i_total = $detalle['i_total'];

      $cotizacion_detalles->total = $detalle['t_total'] + $detalle['a_total'] +  $detalle['i_total'];

      $cotizacion_detalles->save();
    }

    return redirect()->route('cotizaciones.index');
  }

  public function show(string $id) {}

  public function edit(string $id)
  {
    $cotizacion = Cotizacion::with('detalles')->findOrFail($id);
    // dd($cotizacion);
    return inertia('admin/cotizacion/crear', ['cotizacion' => $cotizacion]);
  }

  public function update(Request $request, string $id)
  {
    $cotizacion = Cotizacion::with('detalles')->findOrFail($id);

    $validated = $request->validate($this->toValidated);

    // $validated = $request->validate([
    //   'nombre' => 'required|string|max:255',
    //   'direccion' => 'required|string|max:255',
    //   'telefono' => 'required|string|max:20',
    //   'email' => 'required|email',
    //   'ciudad' => 'required|string|max:100',
    //   'detalles' => 'required|array|min:1',
    //   'detalles.*.id' => 'sometimes|exists:cotizacion_detalles,id', // Para editar existentes
    //   'detalles.*.descripcion' => 'required|string',
    //   'detalles.*.area' => 'required|numeric|min:0',
    //   'detalles.*.precio_unitario' => 'required|numeric|min:0',
    //   'detalles.*.total' => 'required|numeric|min:0',
    //   // 'detalles.*.area' => 'required|min:0',
    //   // 'detalles.*.precio_unitario' => 'required|min:0',
    //   // 'detalles.*.total' => 'required|min:0',
    // ]);

    // Actualizar solo los campos de cotización
    $cotizacion->update([
      'nombre' => $validated['nombre'],
      // 'direccion' => $validated['direccion'],
      'telefono' => $validated['telefono'],
      'email' => $validated['email'],
      // 'ciudad' => $validated['ciudad'],
    ]);

    // Sincronizar detalles: eliminar no enviados, actualizar o crear
    $detalleIds = collect($validated['detalles'])->pluck('id')->filter();
    $cotizacion->detalles()->whereNotIn('id', $detalleIds)->delete();

    foreach ($validated['detalles'] as $detalle) {
      $cotizacion->detalles()->updateOrCreate(['id' => $detalle['id'] ?? null, 'total' => $detalle['total'] ?? 0], $detalle);
    }

    return redirect()->route('cotizaciones.index');
  }

  public function destroy(Cotizacion $cotizacion)
  {
    $cotizacion->delete();
    return redirect()->route('cotizaciones.index');
  }
}
