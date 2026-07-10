<?php

namespace App\Http\Controllers;

use App\Models\Almacen;
use App\Models\Empresa;
use App\Models\Especie;
use App\Models\Trampa;
use App\Models\TrampaSeguimiento;
use Barryvdh\DomPDF\Facade\Pdf;
use Illuminate\Http\Request;

/**
 * FEATURE DESHABILITADA / INCOMPLETA.
 *
 * Las tablas `trampa_especie_seguimientos` / `trampa_roedor_seguimientos`
 * solo tienen `seguimiento_id` (no existe `trampa_seguimiento_id`), por lo que
 * el store/destroy originales referenciaban una columna inexistente y el
 * update operaba sobre el modelo Seguimiento equivocado, corrompiendo datos
 * del seguimiento principal. La tabla `trampa_seguimientos` está vacía y el
 * enlace del menú está comentado.
 *
 * Hasta que se defina el esquema (agregar `trampa_seguimiento_id` a las
 * pivote) las escrituras devuelven error en vez de ejecutar lógica rota.
 * Rutas restringidas a admin/superadmin.
 */
class TrampaSeguimientoController extends Controller
{
  public function index()
  {
    return inertia('admin/trampas/index', [
      'empresas' => Empresa::select('id', 'nombre')->get(),
      'almacenes' => Almacen::select('id', 'nombre', 'empresa_id')->get(),
      // No se cargan trampaEspecies/RoedoresSeguimientos: esas relaciones usan
      // `trampa_seguimiento_id`, columna que no existe (ver nota de clase).
      'seguimientos' => TrampaSeguimiento::with([
        'user:id,name',
        'almacen:id,nombre',
      ])->latest()->paginate(50),
    ]);
  }

  public function store(Request $request)
  {
    return $this->deshabilitada();
  }

  public function update(Request $request, string $id)
  {
    return $this->deshabilitada();
  }

  public function destroy(string $id)
  {
    return $this->deshabilitada();
  }

  public function trampas(Request $request, string $id)
  {
    $trampas = Trampa::with(['trampa_tipo', 'almacen', 'mapa'])
      ->where('almacen_id', $id)
      ->where('estado', '!=', 'inactivo')
      ->get();

    return response()->json($trampas);
  }

  public function especies(Request $request)
  {
    return response()->json(Especie::all(['id', 'nombre']));
  }

  public function pdf(Request $request, string $id)
  {
    $seguimiento = TrampaSeguimiento::with([
      'trampaEspeciesSeguimientos',
      'trampaRoedoresSeguimientos',
      'user:id,name',
      'almacen:id,nombre',
    ])->findOrFail($id);

    $pdf = Pdf::loadView('pdf.trampas', compact('seguimiento'));
    $pdf->setPaper('legal', 'portrait');

    return $pdf->stream(filename: 'seguimiento-trampas-' . now()->format('Y-m-d') . '.pdf');
  }

  private function deshabilitada()
  {
    return back()->with('error', 'El módulo de seguimiento de trampas está deshabilitado.');
  }
}
