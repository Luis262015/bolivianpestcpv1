<?php

namespace App\Http\Controllers;

use App\Models\Certificado;
use App\Models\Empresa;
use Barryvdh\DomPDF\Facade\Pdf;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class CertificadosController extends Controller
{
  public function index()
  {
    $certificados = Certificado::with('empresa')->paginate(20);
    return inertia('admin/certificados/lista', ['certificados' => $certificados]);
  }

  public function create()
  {
    $empresas = Empresa::all('id', 'nombre');
    return inertia('admin/certificados/crear', ['empresas' => $empresas]);
  }

  public function store(Request $request)
  {
    $validated = $request->validate([
      'qrcode' => ['required', 'string', 'max:255'],
      'firmadigital' => ['required', 'string', 'max:255'],
      'titulo' => ['required', 'string', 'max:255'],
      'actividad' => ['required', 'string', 'max:255'],
      'validez' => ['required', 'date'],
      'direccion' => ['required', 'string', 'max:255'],
      'diagnostico' => ['required', 'string', 'max:255'],
      'condicion' => ['required', 'string', 'max:255'],
      'trabajo' => ['required', 'string', 'max:255'],
      'plaguicidas' => ['required', 'string', 'max:255'],
      'registro' => ['required', 'date'],
      'area' => ['required', 'string', 'max:255'],
      'acciones' => ['required', 'string', 'max:255'],
      'empresa_id' => ['required', 'integer']
    ]);

    Certificado::create([
      'user_id' => Auth::id(),
      'qrcode' => $validated['qrcode'],
      'firmadigital' => $validated['firmadigital'],
      'titulo' => $validated['titulo'],
      'actividad' => $validated['actividad'],
      'validez' => $validated['validez'],
      'direccion' => $validated['direccion'],
      'diagnostico' => $validated['diagnostico'],
      'condicion' => $validated['condicion'],
      'trabajo' => $validated['trabajo'],
      'plaguicidas' => $validated['plaguicidas'],
      'registro' => $validated['registro'],
      'area' => $validated['area'],
      'acciones' => $validated['acciones'],
      'empresa_id' => $validated['empresa_id'],
    ]);
    return redirect()->route('certificados.index');
  }

  public function show(string $id) {}

  public function edit(string $id)
  {
    $empresas = Empresa::all('id', 'nombre');
    $certificado = Certificado::find($id);
    return inertia('admin/certificados/editar', ['certificado' => $certificado, 'empresas' => $empresas]);
  }

  public function update(Request $request, string $id)
  {
    $validated = $request->validate([
      'qrcode' => ['required', 'string', 'max:255'],
      'firmadigital' => ['required', 'string', 'max:255'],
      'titulo' => ['required', 'string', 'max:255'],
      'actividad' => ['required', 'string', 'max:255'],
      'validez' => ['required', 'date'],
      'direccion' => ['required', 'string', 'max:255'],
      'diagnostico' => ['required', 'string', 'max:255'],
      'condicion' => ['required', 'string', 'max:255'],
      'trabajo' => ['required', 'string', 'max:255'],
      'plaguicidas' => ['required', 'string', 'max:255'],
      'registro' => ['required', 'date'],
      'area' => ['required', 'string', 'max:255'],
      'acciones' => ['required', 'string', 'max:255'],
      'empresa_id' => ['required', 'integer']
    ]);

    $certificado = Certificado::find($id);
    $certificado->update($validated);

    return redirect()->route('certificados.index');
  }

  public function destroy(string $id)
  {
    $certificado = Certificado::find($id);
    $certificado->delete();
    return redirect()->route('certificados.index');
  }

  public function pdf(Request $request)
  {
    $certificado = Certificado::find($request->id);
    // Cargar la vista Blade con los datos
    $pdf = Pdf::loadView('pdf.certificado', compact('certificado'));
    // Opcional: configurar tamaño, orientación, etc.
    $pdf->setPaper('a4', 'landscape');
    return $pdf->stream('certificado-' . now()->format('Y-m-d') . '.pdf');
    // o ->download() si quieres forzar descarga
  }
}
