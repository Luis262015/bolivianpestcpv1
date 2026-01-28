<?php

namespace App\Http\Controllers;

use App\Models\Almacen;
use App\Models\Empresa;
use App\Models\Especie;
use App\Models\Trampa;
use App\Models\TrampaEspecieSeguimiento;
use App\Models\TrampaRoedorSeguimiento;
use App\Models\TrampaSeguimiento;
use Barryvdh\DomPDF\Facade\Pdf;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class TrampaSeguimientoController extends Controller
{
  public function index()
  {
    $empresas = Empresa::select('id', 'nombre')->get();
    $almacenes = Almacen::select('id', 'nombre')->get();
    $seguimientos = TrampaSeguimiento::with(['trampaEspeciesSeguimientos', 'trampaRoedoresSeguimientos', 'user', 'almacen'])->paginate(50);
    return inertia('admin/trampas/index', [
      'empresas' => $empresas,
      'almacenes' => $almacenes,
      'seguimientos' => $seguimientos,
    ]);
  }

  public function store(Request $request)
  {
    $trampa_seguimiento = new TrampaSeguimiento();
    $trampa_seguimiento->almacen_id = $request->almacen_id;
    $trampa_seguimiento->mapa_id = $request->mapa_id;
    $trampa_seguimiento->user_id = Auth::id();
    $trampa_seguimiento->observaciones = "Guardado";
    $trampa_seguimiento->save();
    foreach ($request->trampa_especies_seguimientos as $especie) {
      TrampaEspecieSeguimiento::create([
        'trampa_seguimiento_id' => $trampa_seguimiento->id,
        'trampa_id' => $especie['trampa_id'],
        'especie_id' => $especie['especie_id'],
        'cantidad' => $especie['cantidad'],
      ]);
    }
    foreach ($request->trampa_roedores_seguimientos as $roedor) {
      TrampaRoedorSeguimiento::create([
        'trampa_seguimiento_id' => $trampa_seguimiento->id,
        'trampa_id' => $roedor['trampa_id'],
        'cantidad' => $roedor['cantidad'],
        'inicial' => $roedor['inicial'],
        'merma' => $roedor['merma'],
        'actual' => $roedor['actual'],
      ]);
    }
    return redirect()->back()->with('success', 'Seguimiento guardardo correctamente');
  }

  public function update(Request $request, string $id)
  {
    $trampa_seguimiento = TrampaSeguimiento::findOrFail($id);
    // Actualizar datos principales
    $trampa_seguimiento->update([
      'almacen_id' => $request->almacen_id,
      'mapa_id' => $request->mapa_id,
      'user_id' => Auth::id(),
      'observaciones' => 'Actualizado',
    ]);
    // Sincronizar seguimientos de especies
    if ($request->has('trampa_especies_seguimientos')) {
      // Eliminar los anteriores
      $trampa_seguimiento->trampaEspeciesSeguimientos()->delete();
      // Crear los nuevos
      foreach ($request->trampa_especies_seguimientos as $especie) {
        $trampa_seguimiento->trampaEspeciesSeguimientos()->create([
          'trampa_id' => $especie['trampa_id'],
          'especie_id' => $especie['especie_id'],
          'cantidad' => $especie['cantidad'],
        ]);
      }
    }
    // Sincronizar seguimientos de roedores
    if ($request->has('trampa_roedores_seguimientos')) {
      // Eliminar los anteriores
      $trampa_seguimiento->trampaRoedoresSeguimientos()->delete();
      // Crear los nuevos
      foreach ($request->trampa_roedores_seguimientos as $roedor) {
        $trampa_seguimiento->trampaRoedoresSeguimientos()->create([
          'trampa_id' => $roedor['trampa_id'],
          'cantidad' => $roedor['cantidad'],
          'inicial' => $roedor['inicial'],
          'merma' => $roedor['merma'],
          'actual' => $roedor['actual'],
        ]);
      }
    }
    return redirect()->back()->with('success', 'Seguimiento actualizado correctamente');
  }

  public function destroy(string $id)
  {
    $trampaseguimiento = TrampaSeguimiento::find($id);
    TrampaEspecieSeguimiento::where('trampa_seguimiento_id', $id)->delete();
    TrampaRoedorSeguimiento::where('trampa_seguimiento_id', $id)->delete();
    $trampaseguimiento->delete();
    return redirect()->back()->with('success', 'Seguimiento eliminado correctamente');
  }

  public function trampas(Request $request, string $id)
  {
    $trampas = Trampa::with(['trampa_tipo', 'almacen'])->where('almacen_id', $id)->get();
    return response()->json($trampas);
  }

  public function especies(Request $request)
  {
    $especies = Especie::all(['id', 'nombre']);
    return response()->json($especies);
  }

  public function pdf(Request $request, string $id)
  {
    $seguimiento = TrampaSeguimiento::with(['trampaEspeciesSeguimientos', 'trampaRoedoresSeguimientos', 'user', 'almacen'])->find($id);
    $pdf = Pdf::loadView('pdf.trampas', compact('seguimiento'));
    $pdf->setPaper('legal', 'portrait');
    return $pdf->stream(filename: 'seguimiento-trampas-' . now()->format('Y-m-d') . '.pdf');
  }

  /** FUNCIONES NO USADAS */
  // public function create() {}
  // public function show(string $id) {}
  // public function edit(string $id) {}
}
