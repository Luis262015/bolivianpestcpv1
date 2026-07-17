<?php

namespace App\Http\Controllers;

use App\Models\Almacen;
use App\Models\Empresa;
use App\Models\Especie;
use App\Models\Seguimiento;
use App\Models\Trampa;
use App\Models\TrampaEspecieSeguimiento;
use App\Models\TrampaRoedorSeguimiento;
use App\Models\TrampaSeguimiento;
use Barryvdh\DomPDF\Facade\Pdf;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Validation\ValidationException;

/**
 * Este controlador cubre dos cosas distintas:
 *
 * 1. `show`/`update`: edición rápida de las trampas de un SEGUIMIENTO existente
 *    (modal ModalSeguimientoTrampa desde la lista). El {id} de esas rutas es un
 *    `seguimientos.id`, no un `trampa_seguimientos.id`: las pivotes se enlazan
 *    por `seguimiento_id`.
 *
 * 2. `store`/`destroy`: módulo TrampaSeguimiento, INCOMPLETO. Referencian
 *    `trampa_seguimiento_id`, columna que no existe en las pivotes. La tabla
 *    `trampa_seguimientos` está vacía y el enlace del menú está comentado.
 *    Siguen deshabilitados hasta que se defina el esquema.
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

  /**
   * Trampas registradas en un seguimiento ({id} = seguimientos.id).
   */
  public function show(Request $request, string $id)
  {
    $seguimiento = Seguimiento::with([
      'trampaEspeciesSeguimientos',
      'trampaRoedoresSeguimientos',
    ])->findOrFail($id);

    return response()->json([
      'trampa_especies_seguimientos' => $seguimiento->trampaEspeciesSeguimientos,
      'trampa_roedores_seguimientos' => $seguimiento->trampaRoedoresSeguimientos,
    ]);
  }

  /**
   * Sincroniza las trampas de un seguimiento ({id} = seguimientos.id).
   * Borra y recrea, igual que SeguimientoController@update.
   */
  public function update(Request $request, string $id)
  {
    // Validar fuera del try: los errores de validación deben llegar al
    // formulario como tales, no convertirse en un error genérico.
    $validated = $request->validate([
      'trampa_especies_seguimientos' => 'present|array',
      'trampa_especies_seguimientos.*.trampa_id' => 'required|integer|exists:trampas,id',
      'trampa_especies_seguimientos.*.especie_id' => 'required|integer|exists:especies,id',
      'trampa_especies_seguimientos.*.cantidad' => 'required|integer|min:0',
      'trampa_roedores_seguimientos' => 'present|array',
      'trampa_roedores_seguimientos.*.trampa_id' => 'required|integer|exists:trampas,id',
      'trampa_roedores_seguimientos.*.observacion' => 'nullable|string',
      'trampa_roedores_seguimientos.*.cantidad' => 'required|integer|min:0',
      // inicial/actual/merma son `double` en la BD: numeric, no integer.
      'trampa_roedores_seguimientos.*.inicial' => 'required|numeric|min:0',
      'trampa_roedores_seguimientos.*.actual' => 'required|numeric|min:0',
      'trampa_roedores_seguimientos.*.merma' => 'required|numeric|min:0',
    ]);

    $seguimiento = Seguimiento::findOrFail($id);

    Log::info('TrampaSeguimientoController@update', [
      'seguimiento_id' => $id,
      'user_id' => $request->user()?->id,
      'especies_count' => count($validated['trampa_especies_seguimientos']),
      'roedores_count' => count($validated['trampa_roedores_seguimientos']),
    ]);

    try {
      DB::beginTransaction();

      TrampaEspecieSeguimiento::where('seguimiento_id', $seguimiento->id)->delete();
      foreach ($validated['trampa_especies_seguimientos'] as $especie) {
        TrampaEspecieSeguimiento::create([
          'seguimiento_id' => $seguimiento->id,
          'trampa_id' => $especie['trampa_id'],
          'especie_id' => $especie['especie_id'],
          'cantidad' => $especie['cantidad'],
        ]);
      }

      // Roedores solo aplican a DESRATIZACION (tipo 1), igual que en store/update
      // del seguimiento: para otros tipos se limpian y no se recrean.
      TrampaRoedorSeguimiento::where('seguimiento_id', $seguimiento->id)->delete();
      if ($seguimiento->tipo_seguimiento_id == 1) {
        foreach ($validated['trampa_roedores_seguimientos'] as $roedor) {
          TrampaRoedorSeguimiento::create([
            'seguimiento_id' => $seguimiento->id,
            'trampa_id' => $roedor['trampa_id'],
            'observacion' => $roedor['observacion'] ?? null,
            'cantidad' => $roedor['cantidad'],
            'inicial' => $roedor['inicial'],
            'actual' => $roedor['actual'],
            'merma' => $roedor['merma'],
          ]);
        }
      }

      DB::commit();

      Log::info('TrampaSeguimientoController@update exitoso', [
        'seguimiento_id' => $id,
        'user_id' => $request->user()?->id,
      ]);

      return redirect()->route('seguimientos.index');
    } catch (ValidationException $e) {
      DB::rollBack();
      throw $e;
    } catch (\Throwable $e) {
      DB::rollBack();
      Log::error('TrampaSeguimientoController@update ERROR', [
        'seguimiento_id' => $id,
        'user_id' => $request->user()?->id,
        'error' => $e->getMessage(),
        'trace' => $e->getTraceAsString(),
      ]);
      return redirect()->back()
        ->withInput()
        ->with('error', 'Error al actualizar las trampas del seguimiento. Contacte al administrador.');
    }
  }

  public function store(Request $request)
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
