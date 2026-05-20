<?php

namespace App\Http\Controllers;

use App\Models\Empresa;
use App\Models\InformeArchivo;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class InformeArchivoController extends Controller
{
    public function store(Request $request)
    {
        $user = $request->user();

        if (!$user->hasAnyRole(['admin', 'superadmin'])) {
            abort(403);
        }

        $request->validate([
            'empresa_id' => 'required|integer|exists:empresas,id',
            'archivo'    => 'required|file|mimes:docx,doc|max:20480',
        ]);

        $archivo   = $request->file('archivo');
        $nombreOriginal = $archivo->getClientOriginalName();
        $ruta      = $archivo->storeAs(
            'informes/' . $request->empresa_id,
            now()->format('dmY_His') . '_' . $nombreOriginal,
            'local'
        );

        InformeArchivo::create([
            'empresa_id'      => $request->empresa_id,
            'user_id'         => $user->id,
            'nombre_original' => $nombreOriginal,
            'ruta'            => $ruta,
        ]);

        return back()->with('success', 'Archivo subido correctamente.');
    }

    public function download(InformeArchivo $informeArchivo, Request $request)
    {
        $user = $request->user();

        if ($user->hasRole('cliente')) {
            $empresasUser = User::with('empresas')->find($user->id);
            $empresaIds   = $empresasUser->empresas->pluck('id')->toArray();

            if (!in_array($informeArchivo->empresa_id, $empresaIds)) {
                abort(403);
            }
        }

        if (!Storage::disk('local')->exists($informeArchivo->ruta)) {
            abort(404);
        }

        return Storage::disk('local')->download(
            $informeArchivo->ruta,
            $informeArchivo->nombre_original
        );
    }

    public function destroy(InformeArchivo $informeArchivo, Request $request)
    {
        $user = $request->user();

        if (!$user->hasAnyRole(['admin', 'superadmin'])) {
            abort(403);
        }

        Storage::disk('local')->delete($informeArchivo->ruta);
        $informeArchivo->delete();

        return back()->with('success', 'Archivo eliminado correctamente.');
    }
}
