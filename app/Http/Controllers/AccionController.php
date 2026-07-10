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
use App\Models\Trampa;
use App\Models\TrampaTipo;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class AccionController extends Controller
{
  public function index(Request $request)
  {
    return inertia('admin/acciones/index', [
      'acciones' => Accion::with([
        'empresa:id,nombre',
        'almacen:id,nombre',
        'accionTrampas.tipo',
        'accionProductos',
        'imagenes',
      ])
        ->latest()
        ->paginate(10),

      'empresas' => Empresa::select('id', 'nombre')->get(),
      'almacenes' => Almacen::select('id', 'nombre')->get(),
      'trampaTipos' => TrampaTipo::select('id', 'nombre')->get(),
    ]);
  }

  public function store(Request $request)
  {
    // Validar fuera del try para que los errores lleguen al formulario como tales.
    $validated = $request->validate([
      'almacen_id' => 'required|exists:almacenes,id',
      'descripcion' => 'required|string',
      'costo' => 'required|numeric|min:0',
      'trampas' => 'nullable|array',
      'trampas.*.trampa_tipo_id' => 'required|integer|exists:trampa_tipos,id',
      'trampas.*.trampa_codigo' => 'required|string|max:255',
      'productos' => 'nullable|array',
      'productos.*.producto_id' => 'required|integer|exists:productos,id',
      'productos.*.cantidad' => 'required|numeric|min:0',
      'imagenes' => 'nullable|array',
      'imagenes.*' => 'image|max:4096',
    ]);

    // La empresa se deduce del almacén: evita pares empresa/almacén inconsistentes.
    $empresaId = Almacen::whereKey($validated['almacen_id'])->value('empresa_id');

    try {
      DB::beginTransaction();

      $accion = new Accion();
      $accion->empresa_id = $empresaId;
      $accion->almacen_id = $validated['almacen_id'];
      $accion->user_id = Auth::id();
      $accion->descripcion = $validated['descripcion'];
      $accion->costo = $validated['costo'];
      $accion->save();

      $this->guardarImagenes($request, $accion->id);

      // Trampas creadas por la acción (fuera de mapa).
      foreach ($validated['trampas'] ?? [] as $tramp) {
        $trampa = Trampa::create([
          'almacen_id' => $validated['almacen_id'],
          'mapa_id' => null,
          'trampa_tipo_id' => $tramp['trampa_tipo_id'],
          'numero' => 0,
          'tipo' => '',
          'posx' => 0,
          'posy' => 0,
          'identificador' => $tramp['trampa_codigo'],
          'estado' => '',
        ]);

        AccionTrampa::create([
          'accion_id' => $accion->id,
          'trampa_id' => $trampa->id,
        ]);
      }

      // Productos usados + descuento de stock (kardex/buffer).
      $this->registrarUsoProductos($accion->id, $validated['productos'] ?? []);

      DB::commit();

      return back()->with('success', 'Acción registrada correctamente.');
    } catch (\Throwable $e) {
      DB::rollBack();
      Log::error('AccionController@store ERROR', ['error' => $e->getMessage()]);
      return back()->withInput()->with('error', 'Error al registrar la acción. Contacte al administrador.');
    }
  }

  public function update(Request $request, Accion $accion)
  {
    $validated = $request->validate([
      'almacen_id' => 'required|exists:almacenes,id',
      'descripcion' => 'required|string',
      'costo' => 'required|numeric|min:0',
    ]);

    // La empresa se deduce del almacén.
    $validated['empresa_id'] = Almacen::whereKey($validated['almacen_id'])->value('empresa_id');

    $accion->update($validated);

    return back()->with('success', 'Acción actualizada correctamente.');
  }

  public function destroy(Accion $accion)
  {
    try {
      DB::beginTransaction();

      // Revertir stock de los productos usados.
      $productosUsos = $accion->accionProductos()->get();
      $productos = Producto::whereIn('id', $productosUsos->pluck('producto_id'))
        ->get()
        ->keyBy('id');

      foreach ($productosUsos as $uso) {
        $producto = $productos->get($uso->producto_id);
        if (!$producto) {
          continue;
        }

        $res = $uso->cantidad / $producto->unidad_valor;
        $parteEntera = (int) $res;
        $parteDecimal = ($res - $parteEntera) * $producto->unidad_valor;

        if ($parteEntera > 0) {
          Kardex::create([
            'venta_id' => null,
            'compra_id' => null,
            'producto_id' => $producto->id,
            'tipo' => 'Entrada',
            'cantidad' => $parteEntera,
            'cantidad_saldo' => $producto->stock + $parteEntera,
            'costo_unitario' => $producto->precio_compra ?? 0,
          ]);
          $producto->stock += $parteEntera;
          $producto->save();
        }

        if ($parteDecimal > 0) {
          $buffer = BufferProducto::where('producto_id', $producto->id)->first();
          if ($buffer) {
            $buffer->cantidad -= $parteDecimal;
            $buffer->cantidad <= 0 ? $buffer->delete() : $buffer->save();
          }
        }
      }

      // Borrar archivos e hijos (los FK son ON DELETE RESTRICT: hay que
      // eliminarlos explícitamente antes que la acción).
      $imagenes = $accion->imagenes()->get();
      foreach ($imagenes as $imagen) {
        $this->eliminarArchivo($imagen->imagen);
      }
      $accion->imagenes()->delete();
      $accion->accionProductos()->delete();

      // Trampas creadas por esta acción: quitar el vínculo y borrar las que
      // no tengan seguimientos u otras acciones dependientes.
      $trampaIds = $accion->accionTrampas()->pluck('trampa_id');
      $accion->accionTrampas()->delete();

      if ($trampaIds->isNotEmpty()) {
        Trampa::whereIn('id', $trampaIds)
          ->whereDoesntHave('especieSeguimientos')
          ->whereDoesntHave('roedorSeguimientos')
          ->whereDoesntHave('accionTrampas')
          ->delete();
      }

      $accion->delete();

      DB::commit();

      return back()->with('success', 'Acción eliminada correctamente.');
    } catch (\Throwable $e) {
      DB::rollBack();
      Log::error('AccionController@destroy ERROR', ['accion_id' => $accion->id, 'error' => $e->getMessage()]);
      return back()->with('error', 'No se pudo eliminar la acción. Contacte al administrador.');
    }
  }

  /* ==================== Helpers ==================== */

  private function guardarImagenes(Request $request, int $accionId): void
  {
    if (!$request->hasFile('imagenes')) {
      return;
    }

    $directory = public_path('images/acciones');
    if (!is_dir($directory)) {
      mkdir($directory, 0755, true);
    }

    foreach ($request->file('imagenes') as $imagen) {
      // Nombre y extensión generados por el servidor (nunca el del navegador).
      $filename = uniqid() . '.' . $imagen->extension();
      $imagen->move($directory, $filename);
      AccionImagen::create([
        'accion_id' => $accionId,
        'imagen' => 'images/acciones/' . $filename,
      ]);
    }
  }

  /**
   * Registra el uso de productos y descuenta stock. Unifica las ramas con y
   * sin buffer manteniendo la misma aritmética que el resto del sistema.
   */
  private function registrarUsoProductos(int $accionId, array $productosUsados): void
  {
    if (empty($productosUsados)) {
      return;
    }

    $productos = Producto::whereIn('id', collect($productosUsados)->pluck('producto_id'))
      ->get()
      ->keyBy('id');

    foreach ($productosUsados as $item) {
      $producto = $productos->get($item['producto_id']);

      AccionProducto::create([
        'accion_id' => $accionId,
        'producto_id' => $item['producto_id'],
        'unidad_id' => $producto->unidad_id,
        'cantidad' => $item['cantidad'],
      ]);

      $buffer = BufferProducto::where('producto_id', $item['producto_id'])->first();
      $res = ($item['cantidad'] + ($buffer->cantidad ?? 0)) / $producto->unidad_valor;
      $parteEntera = (int) $res;
      $parteDecimal = ($res - $parteEntera) * $producto->unidad_valor;

      Kardex::create([
        'venta_id' => null,
        'compra_id' => null,
        'producto_id' => $producto->id,
        'tipo' => 'Salida',
        'cantidad' => $parteEntera,
        'cantidad_saldo' => $producto->stock - $parteEntera,
        'costo_unitario' => $producto->precio_compra ?? 0,
      ]);

      $producto->stock -= $parteEntera;
      $producto->save();

      if ($buffer) {
        $buffer->cantidad = $parteDecimal;
        $buffer->save();
      } elseif ($parteDecimal > 0) {
        $nuevo = new BufferProducto();
        $nuevo->producto_id = $item['producto_id'];
        $nuevo->cantidad = $parteDecimal;
        $nuevo->save();
      }
    }
  }

  private function eliminarArchivo(?string $ruta): void
  {
    if ($ruta && str_starts_with($ruta, 'images/acciones/') && file_exists(public_path($ruta))) {
      @unlink(public_path($ruta));
    }
  }
}
