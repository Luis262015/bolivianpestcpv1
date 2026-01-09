<?php

namespace App\Http\Controllers;

use App\Models\Cotizacion;
use App\Models\CotizacionDetalles;
use Barryvdh\DomPDF\Facade\Pdf;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Database\QueryException;

class CotizacionController extends Controller
{

  private $toValidated = [
    'nombre' => 'required|string|max:255',
    'email' => 'required|email',
    'telefono' => 'required|string|max:20',
    'total' => 'required|numeric|min:0',

    'detalles' => 'required|array|min:1',
    'detalles.*.nombre' => 'required|string|max:255',
    'detalles.*.t_cantidad' => 'required|numeric|min:0',
    'detalles.*.t_visitas' => 'required|numeric|min:0',
    'detalles.*.t_precio' => 'required|numeric|min:0',
    'detalles.*.t_total' => 'required|numeric|min:0',
    'detalles.*.a_area' => 'required|numeric|min:0',
    'detalles.*.a_visitas' => 'required|numeric|min:0',
    'detalles.*.a_precio' => 'required|numeric|min:0',
    'detalles.*.a_total' => 'required|numeric|min:0',
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
    $validated = $request->validate($this->toValidated);

    try {
      DB::beginTransaction();
      // Transacciones .....
      $totalSuma = 0;
      foreach ($validated['detalles'] as $detalle) {
        $totalSuma += $detalle['t_total'] + $detalle['a_total'] +  $detalle['i_total'];
      }

      // Extraer solo los campos que pertenecen a cotizaciones
      $cotizacionData = [
        'nombre' => $validated['nombre'],
        'email' => $validated['email'],
        'telefono' => $validated['telefono'],
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

      DB::commit();
      return redirect()->route('cotizaciones.index');
    } catch (\Exception | \Error $e) {
      DB::rollBack();
      Log::error('Error:', ['error' => $e->getMessage()]);
      return redirect()->back()
        ->withInput()
        ->with('error', 'Error ' . $e->getMessage());
    }
  }

  public function show(string $id) {}

  public function edit(string $id)
  {
    $cotizacion = Cotizacion::with('detalles')->findOrFail($id);
    return inertia('admin/cotizacion/crear', ['cotizacion' => $cotizacion]);
  }

  public function update(Request $request, string $id)
  {
    try {
      DB::beginTransaction();
      $cotizacion = Cotizacion::with('detalles')->findOrFail($id);
      $validated = $request->validate($this->toValidated);

      $totalSuma = 0;
      foreach ($validated['detalles'] as $detalle) {
        $totalSuma += $detalle['t_total'] + $detalle['a_total'] +  $detalle['i_total'];
      }

      // Actualizar solo los campos de cotización
      $cotizacion->update([
        'nombre' => $validated['nombre'],
        'telefono' => $validated['telefono'],
        'email' => $validated['email'],
        'total' => $totalSuma,
      ]);

      // Sincronizar detalles: eliminar no enviados, actualizar o crear
      $detalleIds = collect($validated['detalles'])->pluck('id')->filter();
      $cotizacion->detalles()->whereNotIn('id', $detalleIds)->delete();

      foreach ($validated['detalles'] as $detalle) {
        $cotizacion->detalles()->updateOrCreate(['id' => $detalle['id'] ?? null, 'total' => $detalle['total'] ?? 0], $detalle);
      }
      DB::commit();
      return redirect()->route('cotizaciones.index');
    } catch (\Exception | \Error $e) {
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
      $cotizacion = Cotizacion::find($id);
      $cotizacion_detalles = CotizacionDetalles::where('cotizacion_id', $cotizacion->id)->delete();
      $cotizacion->delete();
      DB::commit();
      return redirect()->route('cotizaciones.index');
    } catch (\Exception | \Error | QueryException $e) {
      DB::rollBack();
      Log::error('Error:', ['error' => $e->getMessage()]);
      return redirect()->back()
        ->withInput()
        ->with('error', 'Error ' . $e->getMessage());
    }
  }

  public function pdf(Request $request, string $id)
  {
    $cotizacion = Cotizacion::with(['detalles'])->find($id);
    // Cargar la vista Blade con los datos
    $pdf = Pdf::loadView('pdf.cotizacion', compact(['cotizacion']));
    // Opcional: configurar tamaño, orientación, etc. ('portrait' -> vertical, 'landscape' -> horizontal)
    $pdf->setPaper('letter', 'portrait');
    return $pdf->stream('cotizacion-' . now()->format('Y-m-d') . '.pdf');
    // o ->download() si quieres forzar descarga
  }
}