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
use App\Models\Producto;
use App\Models\ProductoUso;
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
use App\Models\Trampa;
use App\Models\TrampaEspecieSeguimiento;
use App\Models\TrampaRoedorSeguimiento;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;
use Barryvdh\DomPDF\Facade\Pdf;
use Exception;
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
    'especies_ids' => 'nullable|array',
    'trampa_especies_seguimientos' => 'nullable|array',
    'trampa_roedores_seguimientos' => 'nullable|array'
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
      $seguimientos = Seguimiento::with(['user', 'empresa', 'almacen', 'tipoSeguimiento'])->where('empresa_id', $empresaUser->id)->paginate(20);
    } else {

      $seguimientos = Seguimiento::with(['user', 'empresa', 'almacen', 'trampaEspeciesSeguimientos', 'trampaRoedoresSeguimientos', 'tipoSeguimiento'])->paginate(20);
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

  public function store(Request $request)
  {

    try {
      DB::beginTransaction();

      $validated = $request->validate($this->toValidated);

      $seguimiento = new Seguimiento();
      $seguimiento->empresa_id = $validated['empresa_id'];
      $seguimiento->almacen_id = $validated['almacen_id'];
      $seguimiento->user_id = Auth::id();
      $seguimiento->tipo_seguimiento_id = $validated['tipo_seguimiento_id'];
      $seguimiento->cronograma_id = $validated['numero_tarea'];
      $seguimiento->observaciones = $validated['observaciones_generales'];
      $seguimiento->observacionesp = $validated['observaciones_especificas'];
      $seguimiento->encargado_nombre = $validated['encargado_nombre'];
      $seguimiento->encargado_cargo = $validated['encargado_cargo'];

      if ($request->firma_encargado) {
        $image = $request->firma_encargado;
        $image = str_replace('data:image/png;base64,', '', $image);
        $image = str_replace(' ', '+', $image);
        $imageName = 'firma_encargado_' . time() . '.png';
        $directory = public_path('images/firmas');
        if (!file_exists($directory)) {
          mkdir($directory, 0755, true);
        }
        $fullPath = $directory . '/' . $imageName;
        file_put_contents($fullPath, base64_decode($image));
        $seguimiento['firma_encargado'] = 'images/firmas/' . $imageName;
      }

      if ($request->firma_supervisor) {
        $image = $request->firma_supervisor;
        $image = str_replace('data:image/png;base64,', '', $image);
        $image = str_replace(' ', '+', $image);
        $imageName = 'firma_supervisor_' . time() . '.png';
        $directory = public_path('images/firmas');
        if (!file_exists($directory)) {
          mkdir($directory, 0755, true);
        }
        $fullPath = $directory . '/' . $imageName;
        file_put_contents($fullPath, base64_decode($image));
        $seguimiento['firma_supervisor'] = 'images/firmas/' . $imageName;
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
      $aplicacion->pisos = $validated['aplicacion_data']['pisos'];
      $aplicacion->ambientes = $validated['aplicacion_data']['ambientes'];
      $aplicacion->trampas = $validated['aplicacion_data']['trampas'];
      $aplicacion->trampas_cambiar = $validated['aplicacion_data']['trampas_cambiar'];
      $aplicacion->internas = $validated['aplicacion_data']['internas'];
      $aplicacion->externas = $validated['aplicacion_data']['externas'];
      $aplicacion->roedores = $validated['aplicacion_data']['roedores'];
      $aplicacion->save();

      if (isset($validated['biologicos_ids'])) {
        foreach ($validated['biologicos_ids'] as $ind) {
          $biologicos = new SeguimientoBiologico();
          $biologicos->seguimiento_id = $seguimiento->id;
          $biologicos->biologico_id = $ind;
          $biologicos->save();
        }
      }

      if (isset($validated['metodos_ids'])) {
        foreach ($validated['metodos_ids'] as $ind) {
          $metodos = new SeguimientoMetodo();
          $metodos->seguimiento_id = $seguimiento->id;
          $metodos->metodo_id = $ind;
          $metodos->save();
        }
      }

      if (isset($validated['epps_ids'])) {
        foreach ($validated['epps_ids'] as $ind) {
          $epps = new SeguimientoEpp();
          $epps->seguimiento_id = $seguimiento->id;
          $epps->epp_id = $ind;
          $epps->save();
        }
      }

      if (isset($validated['protecciones_ids'])) {
        foreach ($validated['protecciones_ids'] as $ind) {
          $proteccion = new SeguimientoProteccion();
          $proteccion->seguimiento_id = $seguimiento->id;
          $proteccion->proteccion_id = $ind;
          $proteccion->save();
        }
      }

      if (isset($validated['signos_ids'])) {
        foreach ($validated['signos_ids'] as $ind) {
          $signo = new SeguimientoSigno();
          $signo->seguimiento_id = $seguimiento->id;
          $signo->signo_id = $ind;
          $signo->save();
        }
      }

      // Guardar USO DE PRODUCTO
      if (isset($validated['productos_usados'])) {
        foreach ($validated['productos_usados'] as $prod) {
          $producto = Producto::find($prod['producto_id']);
          $producto_usado = new ProductoUso();
          $producto_usado->producto_id = $prod['producto_id'];
          $producto_usado->seguimiento_id = $seguimiento->id;
          $producto_usado->unidad_id = $producto->unidad_id;
          $producto_usado->cantidad = $prod['cantidad'];
          $producto_usado->save();
          // Logica para descuento de stock  
          // *******************************************
        }
      }

      // GUARDAR TRAMPAS
      // Trampas especies
      if (isset($validated['trampa_especies_seguimientos'])) {
        foreach ($validated['trampa_especies_seguimientos'] as $tramp) {
          $trampa = new TrampaEspecieSeguimiento();
          $trampa->seguimiento_id = $seguimiento->id;
          $trampa->trampa_id = $tramp['trampa_id'];
          $trampa->especie_id = $tramp['especie_id'];
          $trampa->cantidad = $tramp['cantidad'];
          $trampa->save();
        }
      }

      // Trampas roedores
      if (isset($validated['trampa_roedores_seguimientos'])) {
        foreach ($validated['trampa_roedores_seguimientos'] as $tramp) {
          $trampa = new TrampaRoedorSeguimiento();
          $trampa->seguimiento_id = $seguimiento->id;
          $trampa->trampa_id = $tramp['trampa_id'];
          $trampa->observacion = $tramp['observacion'];
          $trampa->cantidad = $tramp['cantidad'];
          $trampa->inicial = $tramp['inicial'];
          $trampa->actual = $tramp['actual'];
          $trampa->merma = $tramp['merma'];
          $trampa->save();
        }
      }


      // Guardar imágenes adicionales
      if ($request->hasFile('imagenes')) {
        foreach ($request->file('imagenes') as $imagen) {
          $directory = public_path('images/seguimientos');
          if (!file_exists($directory)) {
            mkdir($directory, 0755, true);
          }
          $filename = uniqid() . '_' . $imagen->getClientOriginalName();
          $imagen->move($directory, $filename);
          $imagenDB = new SeguimientoImage();
          $imagenDB->seguimiento_id = $seguimiento->id;
          $imagenDB->imagen = 'images/seguimientos/' . $filename;
          $imagenDB->save();
        }
      }

      DB::commit();
      return redirect()->route('seguimientos.index');
    } catch (Exception | \Error | QueryException $e) {
      DB::rollBack();
      Log::error('Error:', ['error' => $e->getMessage()]);
      return redirect()->back()
        ->withInput()
        ->with('error', 'Error ' . $e->getMessage());
    }
  }

  public function destroy(Request $request, string $id)
  {
    $user = $request->user();
    if ($user->HasRole('cliente')) {
      return redirect()->back()
        ->withInput()
        ->with('error', 'Error: No puede eliminar el registro');
    }


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

      DB::commit();

      return redirect()->route('seguimientos.index');
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
    $seguimiento = Seguimiento::with(['empresa', 'almacen', 'user', 'tipoSeguimiento', 'aplicacion', 'metodos', 'epps', 'proteccions', 'biologicos', 'signos', 'images', 'especies', 'productoUsos.unidad', 'productoUsos.producto', 'roedores', 'insectocutores.especie'])->find($id);
    // Conseguir siguiente registro de cronograma del mismo tipo y misma empresa
    // cronogramas(id,empresa_id,almacen_id,tipo_seguimiento_id)
    // Si hiciera una funcion devolver(id, almacen_id, tipo_seguimiento_id), como conseguiria
    // un cronograma del id siguiente si existe del mismo almacen y del mismo tipo_seguimiendo
    // dd($seguimiento);

    $cronograma = Cronograma::query()
      ->where('almacen_id', $seguimiento->almacen->id)
      ->where('tipo_seguimiento_id', $seguimiento->tipoSeguimiento->id)
      ->where('id', '>', $seguimiento->cronograma_id)           // ← clave
      ->orderBy('id', 'asc')            // el más cercano hacia adelante
      ->first();                        // solo el primero (el inmediato siguiente)

    // dd($cronograma);

    $pdf = Pdf::loadView('pdf.seguimiento', compact('seguimiento', 'cronograma'));
    $pdf->setPaper('legal', 'portrait');



    return $pdf->stream(filename: 'seguimiento-' . now()->format('Y-m-d') . '.pdf');
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

  /** FUNCIONES NO USADAS */
  // public function create() {}
  // public function show(string $id) {}
  // public function edit(string $id) {}
  // public function update(Request $request, string $id) {}
}
