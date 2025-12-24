<?php

namespace App\Http\Controllers;

use App\Models\Categoria;
use App\Models\Etiqueta;
use App\Models\Marca;
use App\Models\Producto;
use App\Models\Subcategoria;
use App\Models\Unidad;
use Illuminate\Http\Request;

class ProductosController extends Controller
{
  public function index()
  {
    $productos = Producto::select('id', 'nombre', 'categoria_id', 'subcategoria_id', 'marca_id')
      ->with(['categoria' => function ($query) {
        $query->select('id', 'nombre');
      }])
      ->with(['subcategoria' => function ($query) {
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
    $unidades = Unidad::all();
    return inertia('admin/productos/crear', ['producto' => new Producto(), 'categorias' => $categorias, 'subcategorias' => $subcategorias, 'marcas' => $marcas, 'etiquetas' => $etiquetas, 'etiquetas_sugeridas' => ['Nuevo', 'Oferta', 'Envío Gratis', 'Orgánico', 'Importado'], 'unidades' => $unidades]);
  }

  public function store(Request $request)
  {
    $validated = $request->validate([
      'nombre' => 'required|string|max:255',
      'imagen' => 'nullable|string|max:50',
      'orden' => 'nullable',
      'codigo' => 'nullable',
      'descripcion' => 'nullable|string',
      'ruta' => 'nullable|string',

      'marca_id' => 'required|exists:marcas,id',
      'categoria_id' => 'required|exists:categorias,id',
      'subcategoria_id' => 'nullable|integer',
      'etiqueta_ids' => 'nullable|array',
      'etiqueta_ids.*' => 'exists:etiquetas,id',
    ]);
    $producto = new Producto();
    $producto->nombre = $validated['nombre'];
    $producto->imagen = $validated['imagen'];
    $producto->orden = $validated['orden'];
    $producto->codigo = $validated['codigo'];
    $producto->descripcion = $validated['descripcion'];
    $producto->ruta = $validated['ruta'];
    $producto->marca_id = $validated['marca_id'];
    $producto->categoria_id = $validated['categoria_id'];
    $producto->subcategoria_id = $validated['subcategoria_id'];
    $producto->save();

    // Sincronizar etiquetas
    if (!empty($validated['etiqueta_ids'])) {
      $producto->etiquetas()->sync($validated['etiqueta_ids']);
    } else {
      $producto->etiquetas()->detach(); // Limpiar si no hay
    }


    return redirect()->route('productos.index')->with('success', 'Producto creado con éxito');
  }

  public function show(string $id) {}

  public function edit(string $id)
  {
    $categorias = Categoria::all('id', 'nombre');
    $subcategorias = Subcategoria::all('id', 'nombre');
    $marcas = Marca::all('id', 'nombre');
    $producto = Producto::find($id);
    $etiquetas = Etiqueta::all('id', 'nombre');
    return inertia('admin/productos/editar', ['producto' => $producto, 'categorias' => $categorias, 'subcategorias' => $subcategorias, 'marcas' => $marcas, 'etiquetas' => $etiquetas, 'etiquetas_seleccionadas' => $producto->etiquetas->pluck('id')->toArray() ?? [],]);
  }

  public function update(Request $request, string $id)
  {
    $validated = $request->validate([
      'nombre' => 'required|string|max:255',
      'imagen' => 'nullable|string|max:50',
      'orden' => 'nullable',
      'codigo' => 'nullable',
      'descripcion' => 'nullable|string',
      'ruta' => 'nullable|string',

      'marca_id' => 'required|exists:marcas,id',
      'categoria_id' => 'required|exists:categorias,id',
      'subcategoria_id' => 'nullable|integer',
      'etiqueta_ids' => 'nullable|array',
      'etiqueta_ids.*' => 'exists:etiquetas,id',
    ]);
    $producto = Producto::find($id);
    $producto->nombre = $validated['nombre'];
    // $producto->imagen = $validated['imagen'];
    $producto->orden = $validated['orden'];
    $producto->codigo = $validated['codigo'];
    $producto->descripcion = $validated['descripcion'];
    // $producto->ruta = $validated['ruta'];
    $producto->marca_id = $validated['marca_id'];
    $producto->categoria_id = $validated['categoria_id'];
    $producto->subcategoria_id = $validated['subcategoria_id'];
    $producto->update();
    // Sincronizar etiquetas
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
}
