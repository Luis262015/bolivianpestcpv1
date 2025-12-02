<?php

namespace App\Http\Controllers;

use App\Models\Categoria;
use App\Models\Etiqueta;
use App\Models\Marca;
use App\Models\Producto;
use App\Models\Subcategoria;
use Illuminate\Http\Request;

class ProductosController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
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
        // return inertia('admin/productos/lista');
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
        $categorias = Categoria::all('id', 'nombre');
        $subcategorias = Subcategoria::all('id', 'nombre');
        $marcas = Marca::all('id', 'nombre');
        $etiquetas = Etiqueta::all('id', 'nombre');

        return inertia('admin/productos/crear', ['producto' => new Producto(), 'categorias' => $categorias, 'subcategorias' => $subcategorias, 'marcas' => $marcas, 'etiquetas' => $etiquetas, 'etiquetas_sugeridas' => ['Nuevo', 'Oferta', 'Envío Gratis', 'Orgánico', 'Importado'],]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
        //        
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
        // $producto = Producto::create($validated);
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


        // CREAR EL PRODUCTO PARA TODAS LAS TIENDAS
        // $tiendas = Tienda::all('id');

        // PRODUCTOS TIENDA
        // foreach ($tiendas as $tienda) {
        //     $producto_tienda = new ProductoTienda();
        //     $producto_tienda->tienda_id = $tienda->id;
        //     $producto_tienda->producto_id = $producto->id;
        //     $producto_tienda->nombre = $validated['nombre'];
        //     $producto_tienda->stock = 0;
        //     $producto_tienda->stock_minimo = 0;
        //     $producto_tienda->precio_compra = 0;
        //     $producto_tienda->precio_venta = 0;
        //     $producto_tienda->comision = 0;
        //     $producto_tienda->habilitado = null;
        //     $producto_tienda->en_web = null;
        //     $producto_tienda->save();

        //     $producto_tienda_stock = new ProductoTiendaStock();
        //     $producto_tienda_stock->producto_tienda_id = $producto_tienda->id;
        //     $producto_tienda_stock->comprados = 0;
        //     $producto_tienda_stock->vendidos = 0;
        //     $producto_tienda_stock->save();
        // }

        // Sincronizar etiquetas
        if (!empty($validated['etiqueta_ids'])) {
            $producto->etiquetas()->sync($validated['etiqueta_ids']);
        } else {
            $producto->etiquetas()->detach(); // Limpiar si no hay
        }


        return redirect()->route('productos.index')->with('success', 'Producto creado con éxito');
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        //
        $categorias = Categoria::all('id', 'nombre');
        $subcategorias = Subcategoria::all('id', 'nombre');
        $marcas = Marca::all('id', 'nombre');
        $producto = Producto::find($id);

        $etiquetas = Etiqueta::all('id', 'nombre');
        return inertia('admin/productos/editar', ['producto' => $producto, 'categorias' => $categorias, 'subcategorias' => $subcategorias, 'marcas' => $marcas, 'etiquetas' => $etiquetas, 'etiquetas_seleccionadas' => $producto->etiquetas->pluck('id')->toArray() ?? [],]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
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

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $producto = Producto::find($id);
        $producto->delete();
        return redirect()->route('productos.index');
    }

    public function search(Request $request)
    {
        // dd("SEARCH");
        $query = $request->input('q');

        // $productos = Producto::query()
        //   ->join('producto_tiendas', 'producto_tiendas.producto_id', '=', 'productos.id')
        //   ->where('productos.nombre', 'like', "%{$query}%")
        //   ->select('productos.id', 'productos.nombre', 'producto_tiendas.precio_venta')
        //   ->where('producto_tiendas.tienda_id', session('tienda_id'))
        //   ->take(10)
        //   ->get();


        $productos = Producto::query()
            ->where('nombre', 'like', "%{$query}%")
            ->select('id', 'nombre', 'precio_venta', 'precio_compra')
            ->take(20)
            ->get();

        // dd($productos);
        return response()->json($productos);
    }

    public function getSubcategorias(Categoria $categoria)
    {
        return response()->json(['subcategorias' => $categoria->subcategorias()->select('id', 'nombre')->get()]);
    }

    public function test()
    {
        dd("TEST");
    }
}
