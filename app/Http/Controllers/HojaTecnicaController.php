<?php

namespace App\Http\Controllers;

use App\Models\HojaTecnica;
use App\Models\Producto;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Inertia\Inertia;

class HojaTecnicaController extends Controller
{
    public function index(Producto $producto)
    {
        $hojas = $producto->hojasTecnicas()
            ->latest()           // ordenar por creación más reciente primero
            ->get()
            ->map(function ($item) {
                return [
                    'id'      => $item->id,
                    'titulo'  => $item->titulo,
                    'archivo' => $item->archivo,           // nombre o ruta relativa
                    'url'     => $item->archivo
                        ? Storage::url($item->archivo)
                        : null,                            // url pública completa
                    // opcional: fecha de subida
                    'created_at' => $item->created_at->format('d/m/Y H:i'),
                ];
            });

        // return Inertia::render('Productos/Index', [
        //     'hojas_tecnicas' => $hojas,
        // ]);
        return inertia('admin/productos/lista', [
            'hojas_tecnicas' => $hojas,
        ]);
    }



    public function store(Request $request, Producto $producto)
    {
        $validated = $request->validate([
            'titulo'  => 'required|string|max:255',
            'archivo' => 'required|file|mimes:pdf,jpg,jpeg,png|max:10240', // 10MB
        ]);

        // Guardar archivo
        $path = $request->file('archivo')->store('hojas-tecnicas', 'public');

        $producto->hojasTecnicas()->create([
            'titulo'  => $validated['titulo'],
            'archivo' => $path,
            // 'imagen'  => $this->generateThumbnailIfImage($path) // opcional
        ]);

        // return back()
        //     ->with('success', 'Hoja técnica cargada correctamente');

        return redirect('/productos')
            ->with('success', 'Hoja técnica guardada correctamente');
    }



    public function destroy(Producto $producto, HojaTecnica $hojaTecnica)
    {
        if ($hojaTecnica->producto_id !== $producto->id) {
            abort(403);
        }

        // Eliminar archivo físico
        if ($hojaTecnica->archivo) {
            Storage::disk('public')->delete($hojaTecnica->archivo);
        }

        $hojaTecnica->delete();

        // return back()->with('success', 'Hoja técnica eliminada');

        return redirect('/productos')
            ->with('success', 'Hoja técnica eliminada correctamente');
    }

    /** FUNCIONES NO USADAS */
    public function create() {}
    public function show(string $id) {}
    public function edit(string $id) {}
    public function update(Request $request, string $id) {}
}
