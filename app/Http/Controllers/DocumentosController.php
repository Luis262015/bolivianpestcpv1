<?php

namespace App\Http\Controllers;

use App\Models\Documento;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class DocumentosController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        //
        $search = $request->get('search');

        $documents = Documento::query()
            ->when($search, fn($q) => $q->where('nombre', 'like', "%{$search}%"))
            ->latest()
            ->paginate(12)
            ->withQueryString();

        return inertia('admin/documentos/lista', [
            'documents' => $documents,
            'filters' => ['search' => $search],
        ]);
        // return inertia('admin/documentos/lista');
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
        return inertia('admin/documentos/crear');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
        $validated = $request->validate([
            'nombre'      => 'required|string|max:255',
            'descripcion' => 'nullable|string',
            'archivo'     => 'required|file|mimes:pdf,docx,xlsx,xls|max:10240',
        ]);

        $file = $request->file('archivo');
        $extension = strtolower($file->getClientOriginalExtension());

        $tipo = match ($extension) {
            'pdf'           => 'pdf',
            'docx'          => 'docx',
            'xlsx', 'xls'   => 'excel',
            default         => 'otro',
        };

        $path = $file->store('documents', 'local'); // o 'public'

        Documento::create([
            'nombre'      => $validated['nombre'],
            'descripcion' => $validated['descripcion'],
            'tipo'        => $tipo,
            'ruta'        => $path,
        ]);

        return redirect()->route('documentos.index')->with('success', 'Documento subido correctamente');
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
    public function edit(Documento $documento)
    {
        //
        return inertia('admin/documentos/editar', [
            'document' => $documento->only(['id', 'nombre', 'descripcion', 'tipo', 'ruta'])
        ]);
        // return inertia('admin/documentos/editar');
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Documento $documento)
    {
        // dd($request->all());
        //
        $rules = [
            'nombre'      => 'required|string|max:255',
            'descripcion' => 'nullable|string',
        ];

        // Si sube nuevo archivo → validar, si no → opcional
        if ($request->hasFile('archivo')) {
            $rules['archivo'] = 'required|file|mimes:pdf,docx,xlsx,xls|max:10240';
        }

        $validated = $request->validate($rules);

        $documento->update([
            'nombre'      => $validated['nombre'],
            'descripcion' => $validated['descripcion'] ?? null,
        ]);

        if ($request->hasFile('archivo')) {
            // Borrar el anterior
            Storage::disk('local')->delete($documento->ruta);

            $file = $request->file('archivo');
            $extension = strtolower($file->getClientOriginalExtension());
            $tipo = match ($extension) {
                'pdf' => 'pdf',
                'docx' => 'docx',
                default => 'excel',
            };

            $path = $file->store('documentos', 'local');

            $documento->update([
                'ruta' => $path,
                'tipo' => $tipo,
            ]);
        }

        return redirect()->route('documentos.index')->with('success', 'Documento actualizado');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }

    // DESCARGA SEGURA (solo autenticados)
    public function download(Documento $documento)
    {
        $filePath = storage_path('app/private/' . $documento->ruta);
        // dd($filePath . $documento->ruta);

        if (!file_exists($filePath)) {
            abort(404, 'Archivo no encontrado');
        }

        return response()->download(
            $filePath,
            $documento->nombre . '.' . pathinfo($documento->ruta, PATHINFO_EXTENSION)
        );
    }
}
