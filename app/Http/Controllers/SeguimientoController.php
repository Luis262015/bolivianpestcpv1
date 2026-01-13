<?php

namespace App\Http\Controllers;

use App\Models\Almacen;
use App\Models\Aplicacion;
use App\Models\Biologico;
use App\Models\Cronograma;
use App\Models\Empresa;
use App\Models\Epp;
use App\Models\Especie;
use App\Models\Metodo;
use App\Models\Proteccion;
use App\Models\Seguimiento;
use App\Models\SeguimientoBiologico;
use App\Models\SeguimientoEpp;
use App\Models\SeguimientoEspecie;
use App\Models\SeguimientoImage;
use App\Models\SeguimientoMetodo;
use App\Models\SeguimientoProteccion;
use App\Models\SeguimientoSigno;
use App\Models\Signo;
use App\Models\TipoSeguimiento;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;
use Barryvdh\DomPDF\Facade\Pdf;
use Illuminate\Database\QueryException;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class SeguimientoController extends Controller
{
  private $toValidated = [
    'empresa_id' => 'required|integer',
    'almacen_id' => 'required|integer',
    'tipo_seguimiento_id' => 'required|integer',
    'numero_tarea' => 'required|integer',
    // 'labores' => 'required|array|min:1',
    'biologicos_ids' => 'nullable|array',
    'metodos_ids' => 'nullable|array',
    'epps_ids' => 'nullable|array',
    'protecciones_ids' => 'nullable|array',
    'signos_ids' => 'nullable|array',
    'productos_usados' => 'nullable|array',
    'observaciones_especificas' => 'nullable|string',
    'encargado_nombre' => 'required|string',
    'encargado_cargo' => 'required|string',
    'observaciones_generales' => 'nullable|string',
    'aplicacion_data' => 'array|min:1',
    'especies_ids' => 'nullable|array'
  ];
  public function index(Request $request)
  {
    $empresas = Empresa::select('id', 'nombre')->get();
    $almacenes = Almacen::select('id', 'nombre')->get();
    $biologicos = Biologico::orderBy('nombre')->get();
    $epps = Epp::orderBy('nombre')->get();
    $metodos = Metodo::orderBy('nombre')->get();
    $protecciones = Proteccion::orderBy('nombre')->get();
    $signos = Signo::orderBy('nombre')->get();
    $tiposSeguimiento = TipoSeguimiento::orderBy('nombre')->get();
    $especies = Especie::orderBy('nombre')->get();

    $user = $request->user();
    if ($user->HasRole('cliente')) {
      $empresasUser = User::with('empresas')->find($user->id);
      $empresaUser = $empresasUser->empresas[0];
      $seguimientos = Seguimiento::with(['user', 'empresa', 'almacen'])->where('empresa_id', $empresaUser->id)->paginate(20);
    } else {

      $seguimientos = Seguimiento::with(['user', 'empresa', 'almacen'])->paginate(20);
    }


    return inertia('admin/seguimientos/lista', [
      'empresas' => $empresas,
      'almacenes' => $almacenes,
      'biologicos' => $biologicos,
      'epps' => $epps,
      'metodos' => $metodos,
      'protecciones' => $protecciones,
      'signos' => $signos,
      'tipoSeguimiento' => $tiposSeguimiento,
      'especies' => $especies,
      'seguimientos' => $seguimientos,
    ]);
  }

  public function create()
  {

    $empresas = Empresa::select('id', 'nombre')->get();
    $almacenes = Almacen::select('id', 'nombre')->get();
    $biologicos = Biologico::orderBy('nombre')->get();
    $epps = Epp::orderBy('nombre')->get();
    $metodos = Metodo::orderBy('nombre')->get();
    $protecciones = Proteccion::orderBy('nombre')->get();
    $signos = Signo::orderBy('nombre')->get();
    return inertia('admin/seguimientos/crear', [
      'empresas' => $empresas,
      'almacenes' => $almacenes,
      'biologicos' => $biologicos,
      'epps' => $epps,
      'metodos' => $metodos,
      'protecciones' => $protecciones,
      'signos' => $signos,
    ]);
  }

  public function store(Request $request)
  {
    // dd($request);

    $validated = $request->validate($this->toValidated);

    // dd($validated);

    $seguimiento = new Seguimiento();
    $seguimiento->empresa_id = $validated['empresa_id'];
    $seguimiento->almacen_id = $validated['almacen_id'];
    $seguimiento->user_id = Auth::id();
    $seguimiento->tipo_seguimiento_id = $validated['tipo_seguimiento_id'];
    $seguimiento->observaciones = $validated['observaciones_generales'];
    $seguimiento->observacionesp = $validated['observaciones_especificas'];
    $seguimiento->encargado_nombre = $validated['encargado_nombre'];
    $seguimiento->encargado_cargo = $validated['encargado_cargo'];

    // Procesar base64 a archivo
    if ($request->firma_encargado) {
      $image = $request->firma_encargado;
      $image = str_replace('data:image/png;base64,', '', $image);
      $image = str_replace(' ', '+', $image);
      $imageName = 'firma_encargado_' . time() . '.png';

      Storage::disk('public')->put('firmas/' . $imageName, base64_decode($image));
      $seguimiento['firma_encargado'] = 'firmas/' . $imageName;
    }

    if ($request->firma_supervisor) {
      $image = $request->firma_supervisor;
      $image = str_replace('data:image/png;base64,', '', $image);
      $image = str_replace(' ', '+', $image);
      $imageName = 'firma_supervisor_' . time() . '.png';

      Storage::disk('public')->put('firmas/' . $imageName, base64_decode($image));
      $seguimiento['firma_supervisor'] = 'firmas/' . $imageName;
    }

    $seguimiento->save();

    // Actualizacion de la tarea en cronograma
    $tarea = Cronograma::find($validated['numero_tarea']);
    $tarea->status = 'completado';
    $tarea->update();

    // Aplicacion
    $aplicacion = new Aplicacion();
    $aplicacion->seguimiento_id = $seguimiento->id;
    $aplicacion->paredes_internas = $validated['aplicacion_data']['paredes_internas'];
    $aplicacion->oficinas = $validated['aplicacion_data']['oficinas'];
    $aplicacion->pisos = $validated['aplicacion_data']['pisos'];
    $aplicacion->banos = $validated['aplicacion_data']['banos'];
    $aplicacion->cocinas = $validated['aplicacion_data']['cocinas'];
    $aplicacion->almacenes = $validated['aplicacion_data']['almacenes'];
    $aplicacion->porteria = $validated['aplicacion_data']['porteria'];
    $aplicacion->policial = $validated['aplicacion_data']['policial'];
    $aplicacion->trampas = $validated['aplicacion_data']['trampas'];
    $aplicacion->trampas_cambiar = $validated['aplicacion_data']['trampas_cambiar'];
    $aplicacion->internas = $validated['aplicacion_data']['internas'];
    $aplicacion->externas = $validated['aplicacion_data']['externas'];
    $aplicacion->roedores = $validated['aplicacion_data']['roedores'];
    $aplicacion->save();

    foreach ($validated['biologicos_ids'] as $ind) {
      $biologicos = new SeguimientoBiologico();
      $biologicos->seguimiento_id = $seguimiento->id;
      $biologicos->biologico_id = $ind;
      $biologicos->save();
    }

    foreach ($validated['metodos_ids'] as $ind) {
      $metodos = new SeguimientoMetodo();
      $metodos->seguimiento_id = $seguimiento->id;
      $metodos->metodo_id = $ind;
      $metodos->save();
    }

    foreach ($validated['epps_ids'] as $ind) {
      $epps = new SeguimientoEpp();
      $epps->seguimiento_id = $seguimiento->id;
      $epps->epp_id = $ind;
      $epps->save();
    }

    foreach ($validated['protecciones_ids'] as $ind) {
      $proteccion = new SeguimientoProteccion();
      $proteccion->seguimiento_id = $seguimiento->id;
      $proteccion->proteccion_id = $ind;
      $proteccion->save();
    }

    foreach ($validated['signos_ids'] as $ind) {
      $signo = new SeguimientoSigno();
      $signo->seguimiento_id = $seguimiento->id;
      $signo->signo_id = $ind;
      $signo->save();
    }

    // Guardar especies
    foreach ($validated['especies_ids'] as $espec) {
      $especie = new SeguimientoEspecie();
      $especie->seguimiento_id = $seguimiento->id;
      $especie->especie_id = $espec['especie_id'];
      $especie->cantidad = $espec['cantidad'];
      $especie->save();
    }

    // Guardar imágenes adicionales
    if ($request->hasFile('imagenes')) {
      // $imagenes = [];
      foreach ($request->file('imagenes') as $imagen) {
        // $imagenes[] = $imagen->store('seguimientos', 'public');
        $imagen = $imagen->store('seguimientos', 'public');
        $imagenDB = new SeguimientoImage();
        $imagenDB->seguimiento_id = $seguimiento->id;
        $imagenDB->imagen = $imagen;
        $imagenDB->save();
      }
      // $validated['imagenes'] = json_encode($imagenes);
    }

    return redirect()->route('seguimientos.index');
  }

  public function show(string $id) {}

  public function edit(string $id) {}

  public function update(Request $request, string $id) {}

  public function destroy(string $id)
  {
    try {
      DB::beginTransaction();
      $seguimiento = Seguimiento::find($id);
      // Eliminar imagenes
      SeguimientoImage::where('seguimiento_id', $seguimiento->id)->delete();
      // Eliminar especies
      SeguimientoEspecie::where('seguimiento_id', $seguimiento->id)->delete();
      // Eliminar signos
      SeguimientoSigno::where('seguimiento_id', $seguimiento->id)->delete();
      // Eliminar protecciones
      SeguimientoProteccion::where('seguimiento_id', $seguimiento->id)->delete();
      // Eliminar epps
      SeguimientoEpp::where('seguimiento_id', $seguimiento->id)->delete();
      // Eliminar metodos
      SeguimientoMetodo::where('seguimiento_id', $seguimiento->id)->delete();
      // Eliminar biologicos
      SeguimientoBiologico::where('seguimiento_id', $seguimiento->id)->delete();
      // Eliminar aplicaciones
      Aplicacion::where('seguimiento_id', $seguimiento->id)->delete();
      // Eliminar seguimiento
      $seguimiento->delete();

      // Transacciones .....
      DB::commit();
      // return redirect()->back()->with('success', "Mensaje");
      return redirect()->route('seguimientos.index');
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
    $seguimiento = Seguimiento::with(['empresa', 'almacen', 'user', 'tipoSeguimiento', 'aplicacion', 'metodos', 'epps', 'proteccions', 'biologicos', 'signos', 'images', 'especies'])->find($id);
    // Cargar la vista Blade con los datos
    $pdf = Pdf::loadView('pdf.seguimiento', compact('seguimiento'));
    // Opcional: configurar tamaño, orientación, etc. ('portrait' -> vertical, 'landscape' -> horizontal)
    $pdf->setPaper('legal', 'portrait');
    return $pdf->stream(filename: 'seguimiento-' . now()->format('Y-m-d') . '.pdf');
    // o ->download() si quieres forzar descarga
  }
}
