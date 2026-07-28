<?php

namespace App\Http\Controllers;

use App\Models\Almacen;
use App\Models\Aplicacion;
use App\Models\Biologico;
use App\Models\BufferProducto;
use App\Models\Cronograma;
use App\Models\Empresa;
use App\Models\Epp;
use App\Models\Especie;
use App\Models\Gasto;
use App\Models\Kardex;
use App\Models\Metodo;
use App\Models\Producto;
use App\Models\ProductoUso;
use App\Models\Proteccion;
use App\Models\Seguimiento;
use App\Models\SeguimientoBiologico;
use App\Models\SeguimientoEpp;
use App\Models\SeguimientoImage;
use App\Models\SeguimientoMetodo;
use App\Models\SeguimientoProteccion;
use App\Models\SeguimientoSigno;
use App\Models\Signo;
use App\Models\TipoSeguimiento;
use App\Models\Trampa;
use App\Models\TrampaTipo;
use App\Models\TrampaEspecieSeguimiento;
use App\Models\TrampaRoedorSeguimiento;
use App\Models\User;
use Barryvdh\DomPDF\Facade\Pdf;
use Carbon\Carbon;
use Carbon\CarbonInterface;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Validation\ValidationException;

class SeguimientoController extends Controller
{
  // empresa_id no se acepta del cliente: se deduce siempre del almacén.
  private $toValidated = [
    'almacen_id' => 'required|exists:almacenes,id',
    'tipo_seguimiento_id' => 'required|exists:tipo_seguimientos,id',
    'numero_tarea' => 'required|exists:cronogramas,id',
    'biologicos_ids' => 'nullable|array',
    'biologicos_ids.*' => 'integer',
    'metodos_ids' => 'nullable|array',
    'metodos_ids.*' => 'integer',
    'epps_ids' => 'nullable|array',
    'epps_ids.*' => 'integer',
    'protecciones_ids' => 'nullable|array',
    'protecciones_ids.*' => 'integer',
    'signos_ids' => 'nullable|array',
    'signos_ids.*' => 'integer',
    'productos_usados' => 'nullable|array',
    'productos_usados.*.producto_id' => 'required|integer|exists:productos,id',
    'productos_usados.*.cantidad' => 'required|numeric|min:0',
    'observaciones_especificas' => 'nullable|string',
    'encargado_nombre' => 'required|string|max:255',
    'encargado_cargo' => 'required|string|max:255',
    'observaciones_generales' => 'nullable|string',
    'aplicacion_data' => 'required|array',
    'aplicacion_data.paredes_internas' => 'required',
    'aplicacion_data.pisos' => 'required',
    'aplicacion_data.ambientes' => 'required',
    'aplicacion_data.trampas' => 'required',
    'aplicacion_data.trampas_cambiar' => 'required',
    'aplicacion_data.internas' => 'required',
    'aplicacion_data.externas' => 'required',
    'aplicacion_data.roedores' => 'required',
    'trampa_especies_seguimientos' => 'nullable|array',
    'trampa_especies_seguimientos.*.trampa_id' => 'required|integer|exists:trampas,id',
    'trampa_especies_seguimientos.*.especie_id' => 'required|integer|exists:especies,id',
    'trampa_especies_seguimientos.*.cantidad' => 'required|numeric',
    'trampa_roedores_seguimientos' => 'nullable|array',
    'trampa_roedores_seguimientos.*.trampa_id' => 'required|integer|exists:trampas,id',
    'trampa_roedores_seguimientos.*.observacion' => 'nullable|string',
    'trampa_roedores_seguimientos.*.cantidad' => 'required|numeric',
    'trampa_roedores_seguimientos.*.inicial' => 'required|numeric',
    'trampa_roedores_seguimientos.*.actual' => 'required|numeric',
    'trampa_roedores_seguimientos.*.merma' => 'required|numeric',
    'fecha' => 'nullable|date',
    'firma_encargado' => 'nullable|string',
    'firma_supervisor' => 'nullable|string',
    'imagenes' => 'nullable|array',
    'imagenes.*' => 'image|mimes:jpeg,jpg,png,webp,gif|max:8192',
    // Gastos asociados al seguimiento (usado sobre todo en trabajos esporádicos).
    'gastos' => 'nullable|array',
    'gastos.*.concepto' => 'required|string|max:255',
    'gastos.*.total' => 'required|numeric|min:0',
  ];

  public function index(Request $request)
  {
    $user = $request->user();
    $esCliente = $user->hasRole('cliente');

    $filters = $request->validate([
      'empresa_id' => 'nullable|integer',
      'almacen_id' => 'nullable|integer',
      'usuario_id' => 'nullable|integer',
      'tipo_seguimiento_id' => 'nullable|integer',
      'cronograma_id' => 'nullable|integer',
      'fecha_desde' => 'nullable|date',
      'fecha_hasta' => 'nullable|date',
    ]);

    // El cliente solo puede ver las empresas que tiene asignadas (y sus almacenes).
    $empresaIds = $esCliente ? $user->empresas()->pluck('empresas.id') : null;

    $empresas = $esCliente
      ? Empresa::select('id', 'nombre')->whereIn('id', $empresaIds)->get()
      : Empresa::select('id', 'nombre')->get();
    $almacenes = $esCliente
      ? Almacen::select('id', 'nombre', 'empresa_id')->whereIn('empresa_id', $empresaIds)->get()
      : Almacen::select('id', 'nombre')->get();

    // Catálogos: el frontend solo usa id + nombre.
    $biologicos = Biologico::select('id', 'nombre')->orderBy('nombre')->get();
    $epps = Epp::select('id', 'nombre')->orderBy('nombre')->get();
    $metodos = Metodo::select('id', 'nombre')->orderBy('nombre')->get();
    $protecciones = Proteccion::select('id', 'nombre')->orderBy('nombre')->get();
    $signos = Signo::select('id', 'nombre')->orderBy('nombre')->get();
    $tiposSeguimiento = TipoSeguimiento::select('id', 'nombre')->orderBy('nombre')->get();

    // El cliente no filtra por usuario; no le exponemos la lista completa.
    $usuarios = $esCliente
      ? collect()
      : User::select('id', 'name')->orderBy('name')->get();

    $query = Seguimiento::with([
      'user:id,name',
      'empresa:id,nombre',
      'almacen:id,nombre',
      'tipoSeguimiento:id,nombre',
      'trampaEspeciesSeguimientos',
      'trampaRoedoresSeguimientos',
    ])->latest();

    if ($esCliente) {
      $query->whereIn('empresa_id', $empresaIds);
    } else {
      if (!empty($filters['empresa_id'])) {
        $query->where('empresa_id', $filters['empresa_id']);
      }
      if (!empty($filters['almacen_id'])) {
        $query->where('almacen_id', $filters['almacen_id']);
      }
      if (!empty($filters['usuario_id'])) {
        $query->where('user_id', $filters['usuario_id']);
      }
    }

    if (!empty($filters['tipo_seguimiento_id'])) {
      $query->where('tipo_seguimiento_id', $filters['tipo_seguimiento_id']);
    }
    // Número de tarea del cronograma; el cliente también puede usarlo porque
    // el scoping por empresa ya se aplicó arriba.
    if (!empty($filters['cronograma_id'])) {
      $query->where('cronograma_id', $filters['cronograma_id']);
    }
    // Rangos directos sobre created_at (aprovechan el índice, whereDate no).
    if (!empty($filters['fecha_desde'])) {
      $query->where('created_at', '>=', $filters['fecha_desde']);
    }
    if (!empty($filters['fecha_hasta'])) {
      $query->where('created_at', '<', Carbon::parse($filters['fecha_hasta'])->addDay());
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
      'seguimientos' => $query->paginate(20)->withQueryString(),
      'usuarios' => $usuarios,
      'filters' => $filters,
    ]);
  }

  public function store(Request $request)
  {
    $this->decodificarArrays($request, [
      'biologicos_ids',
      'metodos_ids',
      'epps_ids',
      'protecciones_ids',
      'signos_ids',
      'productos_usados',
      'aplicacion_data',
      'trampa_especies_seguimientos',
      'trampa_roedores_seguimientos',
      'gastos',
    ]);

    // "Agregar gasto" inserta una fila en blanco en el paso 11. Si el técnico
    // no la llena, esa fila no puede tumbar el seguimiento entero: se descarta
    // antes de validar. Las filas a medio llenar sí se validan y se marcan.
    if (is_array($request->input('gastos'))) {
      $request->merge(['gastos' => $this->descartarGastosVacios($request->input('gastos'))]);
    }

    // Validar FUERA del try: los errores de validación deben llegar al
    // formulario como tales, no convertirse en un error genérico.
    $validated = $this->validarConLog($request, $this->toValidated, 'store', [
      'numero_tarea' => $request->input('numero_tarea'),
      'almacen_id' => $request->input('almacen_id'),
    ]);

    // La tarea debe cuadrar con el almacén/tipo enviados y estar libre.
    // El modal ya lo verifica, pero el backend no puede confiar en eso.
    $this->validarTarea($validated);

    $empresaId = Almacen::whereKey($validated['almacen_id'])->value('empresa_id');

    Log::info('SeguimientoController@store', [
      'user_id' => Auth::id(),
      'almacen_id' => $validated['almacen_id'],
      'numero_tarea' => $validated['numero_tarea'],
      'productos_count' => count($validated['productos_usados'] ?? []),
    ]);

    // Archivos escritos en disco dentro de la transacción (firmas e imágenes):
    // si hay rollback hay que borrarlos a mano, el rollback solo deshace la
    // base de datos.
    $archivosCreados = [];

    try {
      DB::beginTransaction();

      $seguimiento = new Seguimiento();
      $seguimiento->empresa_id = $empresaId;
      $seguimiento->almacen_id = $validated['almacen_id'];
      $seguimiento->user_id = Auth::id();
      $seguimiento->tipo_seguimiento_id = $validated['tipo_seguimiento_id'];
      $seguimiento->cronograma_id = $validated['numero_tarea'];
      $seguimiento->observaciones = $validated['observaciones_generales'] ?? null;
      $seguimiento->observacionesp = $validated['observaciones_especificas'] ?? null;
      $seguimiento->encargado_nombre = $validated['encargado_nombre'];
      $seguimiento->encargado_cargo = $validated['encargado_cargo'];
      $seguimiento->firma_encargado = $this->guardarFirma($request->input('firma_encargado'), 'firma_encargado', $archivosCreados);
      $seguimiento->firma_supervisor = $this->guardarFirma($request->input('firma_supervisor'), 'firma_supervisor', $archivosCreados);

      // Fecha retroactiva asignada al modelo: evita el UPDATE extra posterior.
      // El día lo elige el técnico, pero la hora es la del registro real: el
      // formulario solo manda "YYYY-MM-DD" y sin esto todos los seguimientos
      // caerían en 00:00:00, sin rastro de cuándo se hizo el trabajo.
      if (!empty($validated['fecha'])) {
        $marca = $this->fechaConHora($validated['fecha'], Carbon::now());
        $seguimiento->created_at = $marca;
        $seguimiento->updated_at = $marca;
      }

      $seguimiento->save();

      // Marcar la tarea como completada RECLAMÁNDOLA: el WHERE status
      // 'pendiente' hace que solo el primer envío afecte una fila. Sin esto,
      // dos envíos simultáneos (doble clic) pasan ambos por validarTarea y
      // duplican el seguimiento y el descuento de stock.
      $reclamada = Cronograma::whereKey($validated['numero_tarea'])
        ->where('status', 'pendiente')
        ->update(['status' => 'completado']);

      if ($reclamada === 0) {
        throw ValidationException::withMessages([
          'numero_tarea' => 'La tarea ya fue registrada por otro envío.',
        ]);
      }

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

      $this->guardarPivotes($seguimiento->id, $validated);

      // Uso de producto + descuento de stock (kardex/buffer).
      $this->registrarUsoProductos($seguimiento->id, $validated['productos_usados'] ?? []);

      // Trampas especies
      foreach ($validated['trampa_especies_seguimientos'] ?? [] as $tramp) {
        TrampaEspecieSeguimiento::create([
          'seguimiento_id' => $seguimiento->id,
          'trampa_id' => $tramp['trampa_id'],
          'especie_id' => $tramp['especie_id'],
          'cantidad' => $tramp['cantidad'],
        ]);
      }

      // Trampas roedores (solo DESRATIZACION)
      if ($validated['tipo_seguimiento_id'] == 1) {
        foreach ($validated['trampa_roedores_seguimientos'] ?? [] as $tramp) {
          TrampaRoedorSeguimiento::create([
            'seguimiento_id' => $seguimiento->id,
            'trampa_id' => $tramp['trampa_id'],
            'observacion' => $tramp['observacion'] ?? null,
            'cantidad' => $tramp['cantidad'],
            'inicial' => $tramp['inicial'],
            'actual' => $tramp['actual'],
            'merma' => $tramp['merma'],
          ]);
        }
      }

      // Gastos del seguimiento (opcional).
      foreach ($validated['gastos'] ?? [] as $gasto) {
        Gasto::create([
          'user_id' => Auth::id(),
          'seguimiento_id' => $seguimiento->id,
          'concepto' => $gasto['concepto'],
          'total' => $gasto['total'],
        ]);
      }

      $this->guardarImagenes($request, $seguimiento->id, $archivosCreados);

      DB::commit();

      Log::info('SeguimientoController@store exitoso', [
        'seguimiento_id' => $seguimiento->id,
        'user_id' => Auth::id(),
      ]);

      return redirect()->route('seguimientos.index');
    } catch (ValidationException $e) {
      DB::rollBack();
      $this->eliminarArchivos($archivosCreados);
      throw $e;
    } catch (\Throwable $e) {
      DB::rollBack();
      $this->eliminarArchivos($archivosCreados);
      Log::error('SeguimientoController@store ERROR', [
        'user_id' => Auth::id(),
        'error' => $e->getMessage(),
        'trace' => $e->getTraceAsString(),
      ]);
      return redirect()->back()
        ->withInput()
        ->with('error', 'Error al guardar el seguimiento. Contacte al administrador.');
    }
  }

  public function update(Request $request, string $id)
  {
    // Los gastos llegan como JSON string (multipart) igual que el resto de
    // arrays, pero se decodifican antes de validar para que apliquen las
    // mismas reglas que en el alta y los errores lleguen con la clave que el
    // modal usa para marcar la fila ("gastos.0.concepto").
    $request->merge([
      'gastos' => $this->descartarGastosVacios(
        json_decode($request->input('gastos', '[]'), true),
      ),
    ]);

    $validated = $this->validarConLog($request, [
      'almacen_id' => 'required|exists:almacenes,id',
      'tipo_seguimiento_id' => 'required|integer',
      'observaciones_especificas' => 'nullable|string',
      'encargado_nombre' => 'required|string|max:255',
      'encargado_cargo' => 'required|string|max:255',
      'observaciones_generales' => 'nullable|string',
      'created_at' => 'nullable|date',
      'imagenes' => 'nullable|array',
      'imagenes.*' => 'image|mimes:jpeg,jpg,png,webp,gif|max:8192',
      'gastos' => 'nullable|array',
      'gastos.*.concepto' => 'required|string|max:255',
      'gastos.*.total' => 'required|numeric|min:0',
    ], 'update', ['seguimiento_id' => $id]);

    // El modal de edición envía multipart: los arrays llegan como JSON string.
    $biologicosIds = json_decode($request->input('biologicos_ids', '[]'), true) ?? [];
    $metodosIds = json_decode($request->input('metodos_ids', '[]'), true) ?? [];
    $eppsIds = json_decode($request->input('epps_ids', '[]'), true) ?? [];
    $proteccionesIds = json_decode($request->input('protecciones_ids', '[]'), true) ?? [];
    $signosIds = json_decode($request->input('signos_ids', '[]'), true) ?? [];
    $productosUsados = json_decode($request->input('productos_usados', '[]'), true) ?? [];
    $aplicacionData = json_decode($request->input('aplicacion_data', '{}'), true) ?? [];
    $imagenesEliminar = json_decode($request->input('imagenes_eliminar', '[]'), true) ?? [];
    $trampaEspeciesSeguimientos = json_decode($request->input('trampa_especies_seguimientos', '[]'), true) ?? [];
    $trampaRoedoresSeguimientos = json_decode($request->input('trampa_roedores_seguimientos', '[]'), true) ?? [];

    $seguimiento = Seguimiento::findOrFail($id);

    Log::info('SeguimientoController@update', [
      'seguimiento_id' => $id,
      'user_id' => $request->user()?->id,
    ]);

    // Archivos que solo se borran si el cambio se confirma, y archivos nuevos
    // que solo sobreviven si se confirma. Ninguno se toca antes del commit.
    $archivosAEliminar = [];
    $archivosCreados = [];

    try {
      DB::beginTransaction();

      $seguimiento->encargado_nombre = $validated['encargado_nombre'];
      $seguimiento->encargado_cargo = $validated['encargado_cargo'];
      $seguimiento->observaciones = $validated['observaciones_generales'] ?? null;
      $seguimiento->observacionesp = $validated['observaciones_especificas'] ?? null;

      // Refirma: solo si llega un dataURL nuevo (una ruta existente se conserva).
      foreach (['firma_encargado', 'firma_supervisor'] as $campo) {
        $input = $request->input($campo);
        if ($input && str_starts_with($input, 'data:image')) {
          $archivosAEliminar[] = [$seguimiento->{$campo}, 'images/firmas/'];
          $seguimiento->{$campo} = $this->guardarFirma($input, $campo, $archivosCreados);
        }
      }

      // Al editar solo se corrige el día: la hora que se conserva es la que ya
      // tenía el seguimiento (cuándo se registró), no la de esta edición.
      if (!empty($validated['created_at'])) {
        $seguimiento->created_at = $this->fechaConHora(
          $validated['created_at'],
          $seguimiento->created_at ?? Carbon::now(),
        );
      }

      $seguimiento->save();

      // Actualizar aplicacion
      if (!empty($aplicacionData)) {
        $aplicacion = Aplicacion::firstOrNew(['seguimiento_id' => $seguimiento->id]);
        $aplicacion->paredes_internas = $aplicacionData['paredes_internas'] ?? 0;
        $aplicacion->pisos = $aplicacionData['pisos'] ?? 0;
        $aplicacion->ambientes = $aplicacionData['ambientes'] ?? 0;
        $aplicacion->trampas = $aplicacionData['trampas'] ?? 0;
        $aplicacion->trampas_cambiar = $aplicacionData['trampas_cambiar'] ?? 0;
        $aplicacion->internas = $aplicacionData['internas'] ?? 0;
        $aplicacion->externas = $aplicacionData['externas'] ?? 0;
        $aplicacion->roedores = $aplicacionData['roedores'] ?? 0;
        $aplicacion->save();
      }

      // Sincronizar relaciones (borrar y recrear).
      $this->limpiarPivotes($seguimiento->id);
      $this->guardarPivotes($seguimiento->id, [
        'biologicos_ids' => $biologicosIds,
        'metodos_ids' => $metodosIds,
        'epps_ids' => $eppsIds,
        'protecciones_ids' => $proteccionesIds,
        'signos_ids' => $signosIds,
      ]);

      // Sincronizar productos (sin ajuste de stock).
      ProductoUso::where('seguimiento_id', $seguimiento->id)->delete();
      $productos = Producto::whereIn('id', collect($productosUsados)->pluck('producto_id'))
        ->get()
        ->keyBy('id');
      foreach ($productosUsados as $prod) {
        $producto = $productos->get($prod['producto_id']);
        if ($producto) {
          ProductoUso::create([
            'producto_id' => $prod['producto_id'],
            'seguimiento_id' => $seguimiento->id,
            'unidad_id' => $producto->unidad_id,
            'cantidad' => $prod['cantidad'],
          ]);
        }
      }

      // Sincronizar trampas especies
      TrampaEspecieSeguimiento::where('seguimiento_id', $seguimiento->id)->delete();
      foreach ($trampaEspeciesSeguimientos as $tramp) {
        TrampaEspecieSeguimiento::create([
          'seguimiento_id' => $seguimiento->id,
          'trampa_id' => $tramp['trampa_id'],
          'especie_id' => $tramp['especie_id'],
          'cantidad' => $tramp['cantidad'],
        ]);
      }

      // Sincronizar trampas roedores (solo DESRATIZACION)
      TrampaRoedorSeguimiento::where('seguimiento_id', $seguimiento->id)->delete();
      if ($seguimiento->tipo_seguimiento_id == 1) {
        foreach ($trampaRoedoresSeguimientos as $tramp) {
          TrampaRoedorSeguimiento::create([
            'seguimiento_id' => $seguimiento->id,
            'trampa_id' => $tramp['trampa_id'],
            'observacion' => $tramp['observacion'] ?? null,
            'cantidad' => $tramp['cantidad'],
            'inicial' => $tramp['inicial'],
            'actual' => $tramp['actual'],
            'merma' => $tramp['merma'],
          ]);
        }
      }

      // Sincronizar gastos (borrar y recrear, como el resto de relaciones).
      // El autor que se guarda es el del seguimiento, no quien edita: el gasto
      // lo hizo el técnico que fue a campo, aunque después lo corrija un admin.
      Gasto::where('seguimiento_id', $seguimiento->id)->delete();
      foreach ($validated['gastos'] ?? [] as $gasto) {
        Gasto::create([
          'user_id' => $seguimiento->user_id,
          'seguimiento_id' => $seguimiento->id,
          'concepto' => $gasto['concepto'],
          'total' => $gasto['total'],
        ]);
      }

      // Eliminar imágenes marcadas (solo las que pertenecen a este seguimiento).
      // El registro se borra ahora, el archivo recién tras el commit: borrarlo
      // aquí sería irreversible y un rollback dejaría la fila apuntando a un
      // archivo que ya no existe.
      $imagenes = SeguimientoImage::whereIn('id', $imagenesEliminar)
        ->where('seguimiento_id', $seguimiento->id)
        ->get();
      foreach ($imagenes as $imagen) {
        $archivosAEliminar[] = [$imagen->imagen, 'images/seguimientos/'];
        $imagen->delete();
      }

      $this->guardarImagenes($request, $seguimiento->id, $archivosCreados);

      DB::commit();

      // Firmas reemplazadas e imágenes quitadas: se borran del disco recién
      // con el cambio ya confirmado.
      $this->eliminarArchivos($archivosAEliminar);

      Log::info('SeguimientoController@update exitoso', [
        'seguimiento_id' => $id,
        'user_id' => $request->user()?->id,
      ]);

      return redirect()->route('seguimientos.index');
    } catch (ValidationException $e) {
      DB::rollBack();
      $this->eliminarArchivos($archivosCreados);
      throw $e;
    } catch (\Throwable $e) {
      DB::rollBack();
      $this->eliminarArchivos($archivosCreados);
      Log::error('SeguimientoController@update ERROR', [
        'seguimiento_id' => $id,
        'user_id' => $request->user()?->id,
        'error' => $e->getMessage(),
        'trace' => $e->getTraceAsString(),
      ]);
      return redirect()->back()
        ->withInput()
        ->with('error', 'Error al actualizar el seguimiento. Contacte al administrador.');
    }
  }

  public function destroy(Request $request, string $id)
  {
    $seguimiento = Seguimiento::findOrFail($id);

    Log::info('SeguimientoController@destroy', [
      'seguimiento_id' => $id,
      'user_id' => $request->user()->id,
    ]);

    $archivosEliminar = [];

    try {
      DB::beginTransaction();

      // Imágenes: registros ahora, archivos después del commit.
      $imagenes = SeguimientoImage::where('seguimiento_id', $seguimiento->id)->get();
      foreach ($imagenes as $imagen) {
        $archivosEliminar[] = [$imagen->imagen, 'images/seguimientos/'];
        $imagen->delete();
      }
      $archivosEliminar[] = [$seguimiento->firma_encargado, 'images/firmas/'];
      $archivosEliminar[] = [$seguimiento->firma_supervisor, 'images/firmas/'];

      // Revertir stock por productos usados.
      $productosUsos = ProductoUso::where('seguimiento_id', $seguimiento->id)->get();
      $productos = Producto::whereIn('id', $productosUsos->pluck('producto_id'))
        ->get()
        ->keyBy('id');

      foreach ($productosUsos as $productoUso) {
        $producto = $productos->get($productoUso->producto_id);
        if ($producto) {
          $res = $productoUso->cantidad / $producto->unidad_valor;
          $parte_entera = (int) $res;
          $parte_decimal = ($res - $parte_entera) * $producto->unidad_valor;

          if ($parte_entera > 0) {
            Kardex::create([
              'venta_id' => null,
              'compra_id' => null,
              'producto_id' => $producto->id,
              'tipo' => 'Entrada',
              'cantidad' => $parte_entera,
              'cantidad_saldo' => $producto->stock + $parte_entera,
              'costo_unitario' => $producto->precio_compra ?? 0,
            ]);
            $producto->stock += $parte_entera;
            $producto->save();
          }

          // Revertir buffer si aplica
          if ($parte_decimal > 0) {
            $prodBuf = BufferProducto::where('producto_id', $producto->id)->first();
            if ($prodBuf) {
              $prodBuf->cantidad -= $parte_decimal;
              if ($prodBuf->cantidad <= 0) {
                $prodBuf->delete();
              } else {
                $prodBuf->save();
              }
            }
          }
        }
      }
      ProductoUso::where('seguimiento_id', $seguimiento->id)->delete();

      // Eliminar trampas y relaciones
      TrampaEspecieSeguimiento::where('seguimiento_id', $seguimiento->id)->delete();
      TrampaRoedorSeguimiento::where('seguimiento_id', $seguimiento->id)->delete();
      $this->limpiarPivotes($seguimiento->id);
      Aplicacion::where('seguimiento_id', $seguimiento->id)->delete();

      // Gastos asociados al seguimiento.
      Gasto::where('seguimiento_id', $seguimiento->id)->delete();

      // Revertir estado del cronograma
      Cronograma::whereKey($seguimiento->cronograma_id)->update(['status' => 'pendiente']);

      $seguimiento->delete();

      DB::commit();

      $this->eliminarArchivos($archivosEliminar);

      Log::info('SeguimientoController@destroy exitoso', [
        'seguimiento_id' => $id,
        'user_id' => $request->user()->id,
      ]);

      return redirect()->route('seguimientos.index');
    } catch (\Throwable $e) {
      DB::rollBack();
      Log::error('SeguimientoController@destroy ERROR', [
        'seguimiento_id' => $id,
        'user_id' => $request->user()->id,
        'error' => $e->getMessage(),
        'trace' => $e->getTraceAsString(),
      ]);
      return redirect()->back()
        ->withInput()
        ->with('error', 'Error al eliminar el seguimiento. Contacte al administrador.');
    }
  }

  public function pdf(Request $request, string $id)
  {
    $seguimiento = Seguimiento::with(['empresa', 'almacen', 'user', 'tipoSeguimiento', 'aplicacion', 'metodos', 'epps', 'proteccions', 'biologicos', 'signos', 'images', 'productoUsos.unidad', 'productoUsos.producto', 'roedores.trampa.mapa', 'insectocutores.especie', 'insectocutores.trampa.mapa'])
      ->findOrFail($id);

    $this->autorizarAccesoEmpresa($request, $seguimiento->empresa_id);

    // Siguiente tarea del cronograma del mismo almacén y tipo.
    $cronograma = Cronograma::query()
      ->where('almacen_id', $seguimiento->almacen_id)
      ->where('tipo_seguimiento_id', $seguimiento->tipo_seguimiento_id)
      ->where('id', '>', $seguimiento->cronograma_id)
      ->orderBy('id')
      ->first();

    $pdf = Pdf::loadView('pdf.seguimiento', compact('seguimiento', 'cronograma'));
    $pdf->setPaper('legal', 'portrait');

    return $pdf->stream(filename: 'seguimiento-' . now()->format('Y-m-d') . '.pdf');
  }

  /**
   * Trampas de un almacén ({id} es almacen_id; lo usa el modal de seguimiento).
   */
  public function trampas(Request $request, string $id)
  {
    $empresaId = Almacen::whereKey($id)->value('empresa_id');
    if (!$empresaId) {
      abort(404);
    }
    $this->autorizarAccesoEmpresa($request, $empresaId);

    $trampas = Trampa::with(['trampa_tipo', 'almacen'])->where('almacen_id', $id)->get();
    return response()->json($trampas);
  }

  public function especies(Request $request)
  {
    return response()->json(Especie::all(['id', 'nombre']));
  }

  /**
   * Tipos de trampa (para el alta rápida de trampas en seguimientos esporádicos).
   */
  public function trampaTipos(Request $request)
  {
    return response()->json(TrampaTipo::all(['id', 'nombre']));
  }

  /**
   * Alta rápida de una trampa SIN mapa, pensada para trabajos esporádicos.
   * Solo se permite sobre el almacén reservado ESPORADICO: no tiene sentido
   * crear trampas sueltas (sin mapa) en almacenes con contrato.
   */
  public function trampaRapida(Request $request)
  {
    $validated = $request->validate([
      'trampa_tipo_id' => 'required|exists:trampa_tipos,id',
      'identificador' => 'required|string|max:255',
    ]);

    $almacenId = Almacen::esporadicoId();
    if (!$almacenId) {
      abort(422, 'No existe el almacén ESPORADICO. Corra el seeder EsporadicoSeeder.');
    }

    // Numeración correlativa por almacén.
    $numero = (int) (Trampa::where('almacen_id', $almacenId)->max('numero') ?? 0) + 1;

    $trampa = Trampa::create([
      'almacen_id' => $almacenId,
      'mapa_id' => null,
      'trampa_tipo_id' => $validated['trampa_tipo_id'],
      'numero' => $numero,
      'tipo' => null,
      'posx' => 0,
      'posy' => 0,
      'identificador' => $validated['identificador'],
      'estado' => 'activo',
    ]);

    return response()->json($trampa->load(['trampa_tipo', 'almacen', 'mapa']));
  }

  public function show(Request $request, string $id)
  {
    $seguimiento = Seguimiento::with([
      'empresa',
      'almacen',
      'tipoSeguimiento',
      'aplicacion',
      'biologicos',
      'metodos',
      'epps',
      'proteccions',
      'signos',
      'images',
      'trampaEspeciesSeguimientos',
      'trampaRoedoresSeguimientos',
      'gastos',
    ])->findOrFail($id);

    $this->autorizarAccesoEmpresa($request, $seguimiento->empresa_id);

    $productosUsos = DB::table('producto_usos')
      ->join('productos', 'producto_usos.producto_id', '=', 'productos.id')
      ->where('producto_usos.seguimiento_id', $id)
      ->select('producto_usos.producto_id', 'producto_usos.cantidad', 'productos.nombre as nombre_producto')
      ->get();

    if ($request->wantsJson()) {
      return response()->json([
        ...$seguimiento->toArray(),
        'productos_usos' => $productosUsos,
      ]);
    }

    return redirect()->route('seguimientos.index');
  }

  /* ==================== Helpers ==================== */

  /**
   * La tarea del cronograma tiene que corresponder al almacén y al tipo de
   * seguimiento enviados, seguir pendiente y no tener ya un seguimiento.
   * Sin esto se puede completar la tarea de otra empresa o duplicar la carga.
   */
  private function validarTarea(array $validated): void
  {
    // `numero_tarea` ya pasó por exists:cronogramas,id.
    $cronograma = Cronograma::whereKey($validated['numero_tarea'])
      ->select('id', 'almacen_id', 'tipo_seguimiento_id', 'status')
      ->first();

    $errores = [];

    if ((int) $cronograma->almacen_id !== (int) $validated['almacen_id']) {
      $errores[] = 'La tarea no pertenece al almacén seleccionado.';
    }

    if ((int) $cronograma->tipo_seguimiento_id !== (int) $validated['tipo_seguimiento_id']) {
      $errores[] = 'La tarea no corresponde al tipo de seguimiento seleccionado.';
    }

    if ($cronograma->status !== 'pendiente') {
      $errores[] = 'La tarea ya no está pendiente.';
    }

    if (Seguimiento::where('cronograma_id', $cronograma->id)->exists()) {
      $errores[] = 'La tarea ya tiene un seguimiento registrado.';
    }

    if ($errores) {
      Log::warning('SeguimientoController@store tarea inválida', [
        'user_id' => Auth::id(),
        'numero_tarea' => $cronograma->id,
        'almacen_id_tarea' => $cronograma->almacen_id,
        'almacen_id_enviado' => $validated['almacen_id'],
        'tipo_tarea' => $cronograma->tipo_seguimiento_id,
        'tipo_enviado' => $validated['tipo_seguimiento_id'],
        'status' => $cronograma->status,
        'errores' => $errores,
      ]);

      throw ValidationException::withMessages(['numero_tarea' => $errores]);
    }
  }

  /**
   * Un cliente solo puede acceder a datos de sus empresas asignadas.
   */
  private function autorizarAccesoEmpresa(Request $request, ?int $empresaId): void
  {
    $user = $request->user();
    if (
      $user->hasRole('cliente')
      && !$user->empresas()->where('empresas.id', $empresaId)->exists()
    ) {
      abort(403);
    }
  }

  /**
   * Decodifica los arrays que el modal manda serializados.
   *
   * En multipart cada elemento anidado cuenta como una variable de entrada y
   * PHP corta el POST en silencio al pasar `max_input_vars` (1000 por defecto).
   * Un almacén con 142 trampas manda ~1136 variables solo en trampas: las
   * últimas filas llegaban truncadas y reventaban contra `required` sin que
   * nada explicara por qué. Serializado, cada array ocupa una sola variable.
   *
   * Solo se toca lo que viene como string: un array real (petición JSON, o los
   * tests) se deja intacto.
   */
  private function decodificarArrays(Request $request, array $campos): void
  {
    $decodificados = [];

    foreach ($campos as $campo) {
      $valor = $request->input($campo);

      if (is_string($valor)) {
        $decodificados[$campo] = json_decode($valor, true) ?? [];
      }
    }

    if ($decodificados) {
      $request->merge($decodificados);
    }
  }

  /**
   * Valida dejando rastro en el log de lo que falló.
   *
   * Una ValidationException no pasa por el catch(\Throwable) que loguea los
   * errores, así que un rechazo de validación no dejaba ninguna huella en el
   * servidor: el técnico veía "revisa los campos" y desde el log no había forma
   * de saber qué campo lo causó.
   */
  private function validarConLog(Request $request, array $reglas, string $accion, array $contexto = []): array
  {
    try {
      return $request->validate($reglas);
    } catch (ValidationException $e) {
      Log::warning("SeguimientoController@{$accion} validación fallida", [
        'user_id' => Auth::id(),
        'errores' => $e->errors(),
        ...$contexto,
      ]);
      throw $e;
    }
  }

  /**
   * Descarta las filas de gasto que llegan completamente en blanco.
   *
   * Una fila sin concepto ni total es ruido del formulario, no un gasto que el
   * técnico quiso registrar. Las filas a medio llenar se conservan a propósito
   * para que la validación las señale en vez de tragárselas en silencio.
   */
  private function descartarGastosVacios(mixed $gastos): array
  {
    if (!is_array($gastos)) {
      return [];
    }

    $vacio = static fn ($valor): bool => trim((string) ($valor ?? '')) === '';

    return array_values(array_filter(
      $gastos,
      static fn ($gasto): bool => is_array($gasto)
        && !($vacio($gasto['concepto'] ?? null) && $vacio($gasto['total'] ?? null)),
    ));
  }

  /**
   * Combina la fecha elegida en el formulario con una hora de referencia.
   *
   * Los inputs type="date" mandan solo "YYYY-MM-DD", que Carbon interpreta como
   * medianoche. Si el valor ya trae hora se respeta tal cual y no se toca.
   */
  private function fechaConHora(string $fecha, CarbonInterface $hora): Carbon
  {
    $parsed = Carbon::parse($fecha);

    return preg_match('/^\d{4}-\d{2}-\d{2}$/', trim($fecha)) === 1
      ? $parsed->setTimeFrom($hora)
      : $parsed;
  }

  /**
   * Guarda una firma en base64 como PNG con nombre generado por el servidor.
   *
   * Las rutas escritas se acumulan en $creados para que quien abre la
   * transacción pueda borrarlas si termina haciendo rollback: el archivo se
   * escribe antes del commit y, sin esa limpieza, un fallo posterior deja el
   * PNG huérfano en disco para siempre.
   */
  private function guardarFirma(?string $base64, string $prefijo, ?array &$creados = null): ?string
  {
    if (!$base64) {
      return null;
    }

    $data = base64_decode(
      str_replace(['data:image/png;base64,', ' '], ['', '+'], $base64),
      true
    );
    if ($data === false || @getimagesizefromstring($data) === false) {
      throw ValidationException::withMessages([$prefijo => 'La firma no es una imagen válida.']);
    }

    $directory = public_path('images/firmas');
    // La doble comprobación cubre la carrera entre dos peticiones simultáneas:
    // el mkdir del segundo falla porque el primero ya creó el directorio.
    if (!is_dir($directory) && !@mkdir($directory, 0755, true) && !is_dir($directory)) {
      throw new \RuntimeException("No se pudo crear el directorio de firmas: {$directory}");
    }

    $filename = $prefijo . '_' . uniqid() . '.png';

    // Sin esta comprobación una escritura fallida (permisos, disco lleno)
    // devolvería la ruta igualmente y el seguimiento quedaría en la base de
    // datos apuntando a un archivo que no existe.
    if (file_put_contents($directory . '/' . $filename, $data) === false) {
      throw new \RuntimeException("No se pudo escribir la firma: {$filename}");
    }

    $ruta = 'images/firmas/' . $filename;

    if ($creados !== null) {
      $creados[] = [$ruta, 'images/firmas/'];
    }

    return $ruta;
  }

  /**
   * Guarda las imágenes adjuntas (ya validadas como imagen) con nombre y
   * extensión generados por el servidor.
   *
   * Igual que guardarFirma(), acumula en $creados las rutas escritas para que
   * el llamador pueda borrarlas si la transacción acaba en rollback.
   */
  private function guardarImagenes(Request $request, int $seguimientoId, ?array &$creados = null): void
  {
    if (!$request->hasFile('imagenes')) {
      return;
    }

    $directory = public_path('images/seguimientos');
    // Doble comprobación: entre el is_dir y el mkdir puede colarse otra petición.
    if (!is_dir($directory) && !@mkdir($directory, 0755, true) && !is_dir($directory)) {
      throw new \RuntimeException("No se pudo crear el directorio de imágenes: {$directory}");
    }

    foreach ($request->file('imagenes') as $imagen) {
      $filename = $this->optimizarYGuardarImagen($imagen, $directory);
      $ruta = 'images/seguimientos/' . $filename;

      if ($creados !== null) {
        $creados[] = [$ruta, 'images/seguimientos/'];
      }

      SeguimientoImage::create([
        'seguimiento_id' => $seguimientoId,
        'imagen' => $ruta,
      ]);
    }
  }

  /** Lado mayor máximo. El informe las coloca a 220-480 px; de más no sirve. */
  private const IMAGEN_LADO_MAX = 1600;

  /** Umbral para no reprocesar lo que ya viene ligero (evita perder calidad). */
  private const IMAGEN_PESO_MAX = 500 * 1024;

  private const IMAGEN_CALIDAD = 82;

  /**
   * Normaliza la foto a JPEG y la reduce si hace falta.
   *
   * Se convierte SIEMPRE a JPEG (no WebP) porque el destino final de estas
   * fotos es el informe Word, y PhpWord no sabe embeber WebP. Un PNG de cámara
   * de 1 MB pasa a ~100 KB sin diferencia visible a los tamaños en que se
   * imprime.
   *
   * Si GD no puede procesarla se guarda el original tal cual: es preferible
   * conservar la evidencia aunque no esté optimizada a perderla.
   *
   * @return string Nombre del archivo guardado.
   */
  private function optimizarYGuardarImagen($imagen, string $directorio): string
  {
    $rutaTemporal = $imagen->getRealPath();
    $info = @getimagesize($rutaTemporal);

    // Formatos que GD no sabe leer (p. ej. HEIC): se conservan sin tocar.
    $lector = $info ? $this->lectorGd($info[2]) : null;

    if (!$lector) {
      $filename = uniqid() . '.' . $imagen->extension();
      $imagen->move($directorio, $filename);

      return $filename;
    }

    [$ancho, $alto] = $info;
    $ladoMayor = max($ancho, $alto);

    // Ya es un JPEG pequeño y ligero: reprocesarlo sólo degradaría la imagen.
    $yaOptimizada = $info[2] === IMAGETYPE_JPEG
      && $ladoMayor <= self::IMAGEN_LADO_MAX
      && $imagen->getSize() <= self::IMAGEN_PESO_MAX;

    if ($yaOptimizada) {
      $filename = uniqid() . '.jpg';
      $imagen->move($directorio, $filename);

      return $filename;
    }

    $origen = @$lector($rutaTemporal);

    if (!$origen) {
      $filename = uniqid() . '.' . $imagen->extension();
      $imagen->move($directorio, $filename);

      return $filename;
    }

    // GD descarta el EXIF, así que la rotación hay que aplicarla a los píxeles;
    // si no, las fotos de móvil se guardan tumbadas.
    $origen = $this->corregirOrientacion($origen, $rutaTemporal, $info[2]);
    $ancho  = imagesx($origen);
    $alto   = imagesy($origen);

    $escala = $ladoMayor > self::IMAGEN_LADO_MAX
      ? self::IMAGEN_LADO_MAX / max($ancho, $alto)
      : 1.0;

    $nuevoAncho = max(1, (int) round($ancho * $escala));
    $nuevoAlto  = max(1, (int) round($alto * $escala));

    $destino = imagecreatetruecolor($nuevoAncho, $nuevoAlto);

    // JPEG no tiene canal alfa: sin este fondo, las zonas transparentes de un
    // PNG se volverían negras.
    $blanco = imagecolorallocate($destino, 255, 255, 255);
    imagefilledrectangle($destino, 0, 0, $nuevoAncho, $nuevoAlto, $blanco);

    imagecopyresampled($destino, $origen, 0, 0, 0, 0, $nuevoAncho, $nuevoAlto, $ancho, $alto);

    $filename = uniqid() . '.jpg';
    imagejpeg($destino, $directorio . DIRECTORY_SEPARATOR . $filename, self::IMAGEN_CALIDAD);

    imagedestroy($origen);
    imagedestroy($destino);

    return $filename;
  }

  /** Función de GD capaz de leer ese tipo, o null si no hay soporte. */
  private function lectorGd(int $tipo): ?callable
  {
    $lectores = [
      IMAGETYPE_JPEG => 'imagecreatefromjpeg',
      IMAGETYPE_PNG  => 'imagecreatefrompng',
      IMAGETYPE_GIF  => 'imagecreatefromgif',
      IMAGETYPE_WEBP => 'imagecreatefromwebp',
      IMAGETYPE_BMP  => 'imagecreatefrombmp',
    ];

    $lector = $lectores[$tipo] ?? null;

    return $lector && function_exists($lector) ? $lector : null;
  }

  /** Aplica a los píxeles la rotación que venía declarada en el EXIF. */
  private function corregirOrientacion($imagen, string $ruta, int $tipo)
  {
    if ($tipo !== IMAGETYPE_JPEG || !function_exists('exif_read_data')) {
      return $imagen;
    }

    // Un EXIF malformado hace que exif_read_data emita un warning que Laravel
    // convierte en excepción. Sin este try, una sola foto con la cabecera rota
    // abortaría el guardado completo del seguimiento.
    try {
      $exif = @exif_read_data($ruta);
    } catch (\Throwable $e) {
      return $imagen;
    }

    $orientacion = (int) ($exif['Orientation'] ?? 0);

    $grados = match ($orientacion) {
      3 => 180,
      6 => -90,
      8 => 90,
      default => 0,
    };

    if ($grados === 0) {
      return $imagen;
    }

    $rotada = @imagerotate($imagen, $grados, 0);

    if (!$rotada) {
      return $imagen;
    }

    imagedestroy($imagen);

    return $rotada;
  }

  private function guardarPivotes(int $seguimientoId, array $datos): void
  {
    $pivotes = [
      'biologicos_ids' => [SeguimientoBiologico::class, 'biologico_id'],
      'metodos_ids' => [SeguimientoMetodo::class, 'metodo_id'],
      'epps_ids' => [SeguimientoEpp::class, 'epp_id'],
      'protecciones_ids' => [SeguimientoProteccion::class, 'proteccion_id'],
      'signos_ids' => [SeguimientoSigno::class, 'signo_id'],
    ];

    foreach ($pivotes as $clave => [$modelo, $columna]) {
      foreach ($datos[$clave] ?? [] as $ind) {
        $modelo::create([
          'seguimiento_id' => $seguimientoId,
          $columna => $ind,
        ]);
      }
    }
  }

  private function limpiarPivotes(int $seguimientoId): void
  {
    SeguimientoBiologico::where('seguimiento_id', $seguimientoId)->delete();
    SeguimientoMetodo::where('seguimiento_id', $seguimientoId)->delete();
    SeguimientoEpp::where('seguimiento_id', $seguimientoId)->delete();
    SeguimientoProteccion::where('seguimiento_id', $seguimientoId)->delete();
    SeguimientoSigno::where('seguimiento_id', $seguimientoId)->delete();
  }

  /**
   * Uso de producto + descuento de stock. Unifica las dos ramas (con y sin
   * buffer) manteniendo exactamente la misma aritmética de siempre.
   */
  private function registrarUsoProductos(int $seguimientoId, array $productosUsados): void
  {
    if (empty($productosUsados)) {
      return;
    }

    $productos = Producto::whereIn('id', collect($productosUsados)->pluck('producto_id'))
      ->get()
      ->keyBy('id');

    foreach ($productosUsados as $prod) {
      $producto = $productos->get($prod['producto_id']);

      ProductoUso::create([
        'producto_id' => $prod['producto_id'],
        'seguimiento_id' => $seguimientoId,
        'unidad_id' => $producto->unidad_id,
        'cantidad' => $prod['cantidad'],
      ]);

      // res = (cantidad + buffer existente) / unidad_valor
      $prodBuf = BufferProducto::where('producto_id', $prod['producto_id'])->first();
      $res = ($prod['cantidad'] + ($prodBuf->cantidad ?? 0)) / $producto->unidad_valor;
      $parte_entera = (int) $res;
      $parte_decimal = ($res - $parte_entera) * $producto->unidad_valor;

      Kardex::create([
        'venta_id' => null,
        'compra_id' => null,
        'producto_id' => $producto->id,
        'tipo' => 'Salida',
        'cantidad' => $parte_entera,
        'cantidad_saldo' => $producto->stock - $parte_entera,
        'costo_unitario' => $producto->precio_compra ?? 0,
      ]);

      // Descontar la parte entera del stock.
      $producto->stock = $producto->stock - $parte_entera;
      $producto->save();

      // La parte decimal queda en el buffer.
      if ($prodBuf) {
        $prodBuf->cantidad = $parte_decimal;
        $prodBuf->save();
      } elseif ($parte_decimal > 0) {
        $nuevoBuf = new BufferProducto();
        $nuevoBuf->producto_id = $prod['producto_id'];
        $nuevoBuf->cantidad = $parte_decimal;
        $nuevoBuf->save();
      }
    }
  }

  /**
   * Borra un lote de archivos. Se usa siempre FUERA de la transacción: tras el
   * commit para lo que quedó obsoleto, y tras el rollback para lo que se
   * escribió y ya no corresponde. El rollback solo deshace la base de datos.
   *
   * @param array<int, array{0: ?string, 1: string}> $archivos Pares [ruta, prefijo].
   */
  private function eliminarArchivos(array $archivos): void
  {
    foreach ($archivos as [$ruta, $prefijo]) {
      $this->eliminarArchivo($ruta, $prefijo);
    }
  }

  private function eliminarArchivo(?string $ruta, string $prefijo): void
  {
    // Solo archivos dentro del directorio esperado.
    if ($ruta && str_starts_with($ruta, $prefijo) && file_exists(public_path($ruta))) {
      @unlink(public_path($ruta));
    }
  }
}
