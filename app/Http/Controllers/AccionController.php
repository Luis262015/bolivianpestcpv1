<?php

namespace App\Http\Controllers;

use App\Models\Accion;
use App\Models\AccionImagen;
use App\Models\AccionProducto;
use App\Models\AccionTrampa;
use App\Models\Almacen;
use App\Models\BufferProducto;
use App\Models\Empresa;
use App\Models\Kardex;
use App\Models\Producto;
use App\Models\ProductoUso;
use App\Models\Trampa;
use App\Models\TrampaTipo;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Exception;
use Illuminate\Database\QueryException;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class AccionController extends Controller
{

  public function index(Request $request)
  {
    // $empresas = Empresa::select('id', 'nombre')->get();
    // $almacenes = Almacen::select('id', 'nombre')->get();
    // $user = $request->user();

    // if ($user->HasRole('cliente')) {
    //     $empresasUser = User::with('empresas')->find($user->id);
    //     $empresaUser = $empresasUser->empresas[0];
    //     $acciones = Accion::with(['user', 'empresa', 'almacen'])->where('empresa_id', $empresaUser->id)->paginate(20);
    // } else {

    //     $acciones = Accion::with(['user', 'empresa', 'almacen'])->paginate(20);
    // }
    // return inertia('admin/acciones/index', [
    //     'empresas' => $empresas,
    //     'almacenes' => $almacenes,
    //     'acciones' => $acciones,
    // ]);

    return inertia('admin/acciones/index', [
      'acciones' => Accion::with([
        'empresa',
        'almacen',
        'accionTrampas.tipo',
        'accionProductos',
        'imagenes'
      ])
        ->latest()
        ->paginate(10),

      'empresas' => Empresa::select('id', 'nombre')->get(),
      'almacenes' => Almacen::select('id', 'nombre')->get(),
      'trampaTipos' => TrampaTipo::select('id', 'nombre')->get(),
    ]);
    // return inertia("admin/acciones/index");
  }


  public function create() {}


  public function store(Request $request)
  {

    // dd($request);

    try {

      DB::beginTransaction();
      $validated = $request->validate([
        'empresa_id' => 'required|exists:empresas,id',
        'almacen_id' => 'required|exists:almacenes,id',
        'descripcion' => 'required|string',
        'costo' => 'required|numeric|min:0',
        'trampas' => 'nullable|array',
        'trampas.*.trampa_tipo_id' => 'required|numeric',
        'trampas.*.trampa_codigo' => 'required|string',
        'productos' => 'nullable|array',
        'productos.*.producto_id' => 'required|numeric',
        'productos.*.cantidad' => 'required|numeric',
      ]);

      Log::info('AAAAA');


      // $accion = Accion::create($validated);
      $accion = new Accion();
      $accion->empresa_id = $validated['empresa_id'];
      $accion->almacen_id = $validated['almacen_id'];
      $accion->user_id = Auth::id();
      $accion->descripcion = $validated['descripcion'];
      $accion->costo = $validated['costo'];
      $accion->save();
      Log::info('BBBBBB');

      // if ($request->hasFile('imagenes')) {
      //   foreach ($request->file('imagenes') as $file) {
      //     $path = $file->store('acciones', 'public');

      //     $accion->imagenes()->create([
      //       'imagen' => $path,
      //     ]);
      //   }
      // }

      // Guardar imágenes adicionales
      if ($request->hasFile('imagenes')) {
        foreach ($request->file('imagenes') as $imagen) {
          $directory = public_path('images/acciones');
          if (!file_exists($directory)) {
            mkdir($directory, 0755, true);
          }
          $filename = uniqid() . '_' . $imagen->getClientOriginalName();
          $imagen->move($directory, $filename);
          $imagenDB = new AccionImagen();
          $imagenDB->accion_id = $accion->id;
          $imagenDB->imagen = 'images/acciones/' . $filename;
          $imagenDB->save();
        }
      }

      // Guardar trampas
      if ($validated['trampas']) {
        foreach ($validated['trampas'] as $tramp) {
          $trampa = new Trampa();
          $trampa->almacen_id = $validated['almacen_id'];
          $trampa->mapa_id = null;
          $trampa->trampa_tipo_id = $tramp['trampa_tipo_id'];
          $trampa->numero = 0;
          $trampa->tipo = '';
          $trampa->posx = 0;
          $trampa->posy = 0;
          $trampa->identificador = $tramp['trampa_codigo'];
          $trampa->estado = '';
          $trampa->save();
          Log::info('CCCCCC');

          $accion_trampa = new AccionTrampa();
          $accion_trampa->accion_id = $accion->id;
          $accion_trampa->trampa_id = $trampa->id;
          $accion_trampa->save();
          Log::info('DDDDDD');
        }
      }

      // Guardar productos
      if (isset($validated['productos'])) {
        foreach ($validated['productos'] as $product) {
          $producto = Producto::find($product['producto_id']);
          $accion_producto = new AccionProducto();
          $accion_producto->accion_id = $accion->id;
          $accion_producto->producto_id = $product['producto_id'];
          $accion_producto->unidad_id = $producto->unidad_id;
          $accion_producto->cantidad = $product['cantidad'];
          $accion_producto->save();
          Log::info('FFFFFFF');

          // *******************************************
          // Logica para descuento de stock  
          // *******************************************          

          // Buscar si existe producto en buffer productos
          $prodBuf = BufferProducto::where('producto_id', $product['producto_id'])->first();
          if ($prodBuf) {
            // Usar producto buffer

            // Calculo inicial: res = cantidad / unidad_valor
            $res = ($product['cantidad'] + $prodBuf['cantidad']) / $producto->unidad_valor;
            $parte_entera = (int) $res;
            $parte_decimal = $res - $parte_entera;
            Log::info('GGGGGGG');

            Kardex::create([
              'venta_id' => null,
              'compra_id' => null,
              'producto_id' => $producto->id,
              'tipo' => 'Salida',
              'cantidad' => $parte_entera,
              'cantidad_saldo' => $producto->stock - $parte_entera,
              'costo_unitario' => $producto->precio_compra,
            ]);
            Log::info('HHHHHHHH');

            // Descontar la parte entera del STOCK
            $producto->stock = $producto->stock - $parte_entera;
            $producto->save();
            Log::info('IIIIIIII');

            // Agregar la parte decimal en registro
            $prodBuf->cantidad = $parte_decimal * $producto->unidad_valor;
            $prodBuf->save();
            Log::info('JJJJJJJ');
          } else {

            // Calculo inicial: res = cantidad / unidad_valor            
            $res = $product['cantidad'] / $producto->unidad_valor;
            $parte_entera = (int) $res;
            $parte_decimal = $res - $parte_entera;
            Log::info('KKKKKKKK');

            Kardex::create([
              'venta_id' => null,
              'compra_id' => null,
              'producto_id' => $producto->id,
              'tipo' => 'Salida',
              'cantidad' => $parte_entera,
              'cantidad_saldo' => $producto->stock - $parte_entera,
              'costo_unitario' => $producto->precio_compra,
            ]);
            Log::info('LLLLLLLLL');

            // Descontar la parte entera del STOCK
            $producto->stock = $producto->stock - $parte_entera;
            $producto->save();
            Log::info('MMMMMMMMM');

            // Agregar la parte decimal en registro, solo si la parte decimal es mayor a 0
            $parte_decimal = $parte_decimal * $producto->unidad_valor;
            // Log::info('EEEEEE ' . $parte_decimal);
            if ($parte_decimal > 0) {
              $prodBuf = new BufferProducto();
              $prodBuf->producto_id = $product['producto_id'];
              $prodBuf->cantidad = $parte_decimal;
              $prodBuf->save();
              Log::info('NNNNNNNNN');
            }
          }
        }
      }


      DB::commit();
      return back();
    } catch (Exception | \Error | QueryException $e) {
      DB::rollBack();
      Log::info($e->getMessage());
      return back()->with('error', $e->getMessage());
    }
  }



  public function show(string $id) {}


  public function edit(string $id) {}


  public function update(Request $request, Accion $accion)
  {
    $validated = $request->validate([
      'empresa_id' => 'required|exists:empresas,id',
      'almacen_id' => 'required|exists:almacenes,id',
      'descripcion' => 'required|string',
      'costo' => 'required|numeric|min:0'
    ]);

    $accion->update($validated);

    return back();
  }


  public function destroy(Accion $accion)
  {
    $accion->delete();
    return back();
  }
}
