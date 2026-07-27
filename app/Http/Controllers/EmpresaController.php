<?php

namespace App\Http\Controllers;

use App\Models\Almacen;
use App\Models\Certificado;
use App\Models\Empresa;
use Barryvdh\DomPDF\Facade\Pdf;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;

class EmpresaController extends Controller
{
  private $toValidatedCert = [
    'titulo' => 'nullable|string',
    'establecimiento' => 'nullable|string',
    'actividad' => 'nullable|string',
    'validez' => 'nullable|string',
    'direccion' => 'nullable|string',
    'diagnostico' => 'nullable|string',
    'condicion' => 'nullable|string',
    'trabajo' => 'nullable|string',
    'plaguicidas' => 'nullable|string',
    'registro' => 'nullable|string',
    'area' => 'nullable|string',
    'acciones' => 'nullable|string',
    'ingredientes' => 'nullable|string',
    'logo' => 'nullable|image|max:2048',
    'created_at' => 'nullable|date',
  ];

  public function index(Request $request)
  {
    $user = $request->user();

    // El listado solo usa columnas básicas; de los certificados, solo lo que
    // muestra el modal (evita enviar los campos de texto largos en el JSON).
    $empresas = Empresa::query()
      ->select('id', 'nombre', 'direccion', 'telefono', 'email', 'activo')
      ->with('certificados:id,empresa_id,titulo,actividad,validez,created_at')
      ->when(
        $user->hasRole('cliente'),
        fn($q) => $q->whereIn('id', $user->empresas()->pluck('empresas.id'))
      )
      ->orderBy('id')
      ->paginate(20);

    return inertia('admin/empresas/lista', ['empresas' => $empresas]);
  }

  public function certificados(Request $request, string $id)
  {
    $validated = $request->validate($this->toValidatedCert);
    $empresa = Empresa::select('id')->findOrFail($id);

    try {
      // $validated solo contiene claves whitelisted por las reglas de arriba.
      $certificado = new Certificado(
        collect($validated)->except(['logo', 'created_at'])->toArray()
      );
      $certificado->empresa_id = $empresa->id;
      $certificado->user_id = Auth::id();
      $certificado->qrcode = '';
      $certificado->firmadigital = '';
      $certificado->logo = '';

      if ($request->hasFile('logo')) {
        $file = $request->file('logo');
        // Nombre generado por el servidor; extensión deducida del contenido
        // real (nunca el nombre/extensión que manda el navegador).
        $filename = uniqid() . '.' . $file->extension();
        $file->move(public_path('images/certificado'), $filename);
        $certificado->logo = 'images/certificado/' . $filename;
      }

      if (!empty($validated['created_at'])) {
        $certificado->created_at = $validated['created_at'];
      }

      $certificado->save();

      return redirect()->back()->with('success', 'Certificado creado exitosamente');
    } catch (\Throwable $e) {
      Log::error('Error al crear certificado', ['empresa_id' => $id, 'error' => $e->getMessage()]);
      return redirect()->back()
        ->withInput()
        ->withErrors(['error' => 'Error crítico al crear el certificado. Contacte al administrador.']);
    }
  }

  public function certificadopdf(Request $request, string $id)
  {
    $certificado = Certificado::findOrFail($id);

    // Un cliente solo puede generar PDFs de certificados de sus empresas.
    $user = $request->user();
    if (
      $user->hasRole('cliente')
      && !$user->empresas()->where('empresas.id', $certificado->empresa_id)->exists()
    ) {
      abort(403);
    }

    $pdf = Pdf::loadView('pdf.certificado', compact('certificado'));
    $pdf->setPaper('letter', 'landscape');
    return $pdf->stream('certificado-' . now()->format('Y-m-d') . '.pdf');
  }

  public function certificadoultimo()
  {
    $certificado = Certificado::latest()->firstOrFail();
    $pdf = Pdf::loadView('pdf.certificado', compact('certificado'));
    $pdf->setPaper('letter', 'landscape');
    return $pdf->stream('certificado-' . now()->format('Y-m-d') . '.pdf');
  }

  public function destroyCertificado(string $id)
  {
    try {
      $certificado = Certificado::findOrFail($id);

      // Solo borra archivos dentro del directorio de logos de certificados.
      if (
        !empty($certificado->logo)
        && str_starts_with($certificado->logo, 'images/certificado/')
        && file_exists(public_path($certificado->logo))
      ) {
        unlink(public_path($certificado->logo));
      }

      $certificado->delete();

      return redirect()->back()->with('success', 'Certificado eliminado correctamente');
    } catch (\Throwable $e) {
      Log::error('Error al eliminar certificado', ['certificado_id' => $id, 'error' => $e->getMessage()]);
      return redirect()->back()->with('error', 'Error al eliminar el certificado');
    }
  }

  public function getByEmpresa(Request $request, $empresaId)
  {
    // Un cliente solo puede listar almacenes de sus empresas asignadas.
    $user = $request->user();
    if (
      $user->hasRole('cliente')
      && !$user->empresas()->where('empresas.id', $empresaId)->exists()
    ) {
      abort(403);
    }

    $almacenes = Almacen::where('empresa_id', $empresaId)->get(['id', 'nombre']);
    return response()->json($almacenes);
  }
}