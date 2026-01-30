<?php

namespace App\Http\Controllers;

use App\Models\Categoria;
use App\Models\Etiqueta;
use App\Models\HojaTecnica;
use App\Models\Marca;
use App\Models\Producto;
use App\Models\ProductoVencimiento;
use App\Models\Subcategoria;
use App\Models\Unidad;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Storage;

class ProductosController extends Controller
{

  private $validate = [
    'nombre' => 'required|string|max:255',
    'descripcion' => 'nullable|string',
    'stock_min' => 'required|numeric',
    'unidad_valor' => 'required|numeric',
    'unidad_id' => 'required|exists:unidades,id',
    'marca_id' => 'nullable|exists:marcas,id',
    'categoria_id' => 'nullable|exists:categorias,id',
    'etiqueta_ids' => 'nullable|array',
    'etiqueta_ids.*' => 'exists:etiquetas,id',
  ];

  public function index()
  {
    $productos = Producto::select('id', 'nombre', 'categoria_id', 'marca_id', 'stock')
      ->with(['categoria' => function ($query) {
        $query->select('id', 'nombre');
      }])
      ->with(['marca' => function ($query) {
        $query->select('id', 'nombre');
      }])
      ->paginate(20);
    return inertia('admin/productos/lista', ['productos' => $productos]);
  }

  public function create()
  {
    $categorias = Categoria::all('id', 'nombre');
    $subcategorias = Subcategoria::all('id', 'nombre');
    $marcas = Marca::all('id', 'nombre');
    $etiquetas = Etiqueta::all('id', 'nombre');
    $unidades = Unidad::all('id', 'nombre');
    return inertia('admin/productos/crear', ['producto' => new Producto(), 'categorias' => $categorias, 'subcategorias' => $subcategorias, 'marcas' => $marcas, 'etiquetas' => $etiquetas, 'etiquetas_sugeridas' => ['Nuevo', 'Oferta', 'Envío Gratis', 'Orgánico', 'Importado'], 'unidades' => $unidades]);
  }

  public function store(Request $request)
  {

    $validated = $request->validate($this->validate);

    $producto = new Producto();
    $producto->categoria_id = $validated['categoria_id'];
    $producto->marca_id = $validated['marca_id'];
    $producto->unidad_id = $validated['unidad_id'];
    $producto->nombre = $validated['nombre'];
    $producto->descripcion = $validated['descripcion'];
    $producto->unidad_valor = $validated['unidad_valor'];
    $producto->stock_min = $validated['stock_min'];
    $producto->save();

    // Sincronizar etiquetas
    if (!empty($validated['etiqueta_ids'])) {
      $producto->etiquetas()->sync($validated['etiqueta_ids']);
    } else {
      $producto->etiquetas()->detach(); // Limpiar si no hay
    }
    return redirect()->route('productos.index')->with('success', 'Producto creado con éxito');
  }

  public function edit(string $id)
  {
    $producto = Producto::find($id);
    $categorias = Categoria::all('id', 'nombre');
    $subcategorias = Subcategoria::all('id', 'nombre');
    $marcas = Marca::all('id', 'nombre');
    $etiquetas = Etiqueta::all('id', 'nombre');
    $unidades = Unidad::all('id', 'nombre');
    return inertia('admin/productos/editar', ['producto' => $producto, 'categorias' => $categorias, 'subcategorias' => $subcategorias, 'unidades' => $unidades, 'marcas' => $marcas, 'etiquetas' => $etiquetas, 'etiquetas_seleccionadas' => $producto->etiquetas->pluck('id')->toArray() ?? [],]);
  }

  public function update(Request $request, string $id)
  {

    $validated = $request->validate($this->validate);

    $producto = Producto::find($id);
    $producto->categoria_id = $validated['categoria_id'];
    $producto->marca_id = $validated['marca_id'];
    $producto->unidad_id = $validated['unidad_id'];
    $producto->nombre = $validated['nombre'];
    $producto->descripcion = $validated['descripcion'];
    $producto->unidad_valor = $validated['unidad_valor'];
    $producto->stock_min = $validated['stock_min'];
    $producto->update();
    $producto->etiquetas()->sync($request->etiqueta_ids ?? []);
    return redirect()->route('productos.index');
  }

  public function destroy(string $id)
  {
    $producto = Producto::find($id);
    $producto->delete();
    return redirect()->route('productos.index');
  }

  public function search(Request $request)
  {
    $query = $request->input('q');
    $productos = Producto::query()
      ->where('nombre', 'like', "%{$query}%")
      ->select('id', 'nombre', 'precio_venta', 'precio_compra')
      ->take(20)
      ->get();
    return response()->json($productos);
  }

  public function getSubcategorias(Categoria $categoria)
  {
    return response()->json(['subcategorias' => $categoria->subcategorias()->select('id', 'nombre')->get()]);
  }

  public function storeVencimiento(Request $request, Producto $producto)
  {
    $validated = $request->validate([
      'codigo'      => 'required|string|max:50',
      'vencimiento' => 'required|date|after_or_equal:today',
    ]);
    $producto_vencimiento = new ProductoVencimiento();
    $producto_vencimiento->producto_id = $producto->id;
    $producto_vencimiento->codigo = $validated['codigo'];
    $producto_vencimiento->vencimiento = $validated['vencimiento'];
    $producto_vencimiento->save();

    return back()->with('success', 'Fecha de vencimiento registrada correctamente');
  }

  public function deleteVencimiento(Producto $producto, ProductoVencimiento $vencimiento)
  {
    // Seguridad adicional: verificar que pertenece al producto
    if ($vencimiento->producto_id !== $producto->id) {
      abort(403);
    }
    $vencimiento->delete();
    return back()->with('success', 'Vencimiento eliminado');
  }

  public function storeHojaTecnica(Request $request, Producto $producto)
  {
    try {
      DB::beginTransaction();

      $validated = $request->validate([
        'titulo'  => 'required|string|max:255',
        'archivo' => 'required|file|mimes:pdf,jpg,jpeg,png|max:10240', // 10MB
      ]);

      // Guardar archivo
      $path = $request->file('archivo')->store('hojasTecnicas', 'private');

      $producto->hojasTecnicas()->create([
        'titulo'  => $validated['titulo'],
        'archivo' => $path,
      ]);

      DB::commit();
      return back()
        ->with('success', 'Hoja técnica cargada correctamente');
    } catch (\Exception | \Error $e) {
      DB::rollBack();
      Log::error('Error:', ['error' => $e->getMessage()]);
      return redirect()->back()
        ->withInput()
        ->with('error', 'Error ' . $e->getMessage());
    }
  }

  public function deleteHojaTecnica(Producto $producto, HojaTecnica $hojaTecnica)
  {
    if ($hojaTecnica->producto_id !== $producto->id) {
      abort(403);
    }
    // Eliminar archivo físico
    if ($hojaTecnica->archivo) {
      Storage::disk('local')->delete($hojaTecnica->archivo);
    }
    $hojaTecnica->delete();
    return back()->with('success', 'Hoja técnica eliminada');
  }

  public function download(HojaTecnica $hojaTecnica)
  {
    // dd($hojaTecnica);
    $filePath = storage_path('app/private/' . $hojaTecnica->archivo);
    // dd($filePath);
    if (!file_exists($filePath)) {
      abort(404, 'Archivo no encontrado');
    }
    return response()->download(
      $filePath,
      $hojaTecnica->titulo . '.' . pathinfo($hojaTecnica->archivo, PATHINFO_EXTENSION)
    );
  }

  /** FUNCIONES NO USADAS */
  // public function show(string $id) {}
}
