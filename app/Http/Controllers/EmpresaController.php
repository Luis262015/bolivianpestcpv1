<?php

namespace App\Http\Controllers;

use App\Models\Certificado;
use App\Models\Empresa;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Barryvdh\DomPDF\Facade\Pdf;
use Illuminate\Support\Facades\Log;

class EmpresaController extends Controller
{
  private $toValidatedCert = [
    'titulo' => 'required|string',
    'actividad' => 'required|string',
    'validez' => 'required|string',
    'direccion' => 'required|string',
    'diagnostico' => 'required|string',
    'condicion' => 'required|string',
    'trabajo' => 'required|string',
    'plaguicidas' => 'required|string',
    'registro' => 'required|string',
    'area' => 'required|string',
    'acciones' => 'required|string',
    'logo' => 'nullable|image|max:2048',
  ];

  public function index()
  {
    $empresas = Empresa::with(['certificados'])->paginate(10);
    return inertia('admin/empresas/lista', ['empresas' => $empresas]);
  }

  public function create()
  {
    return inertia('admin/empresas/crear');
  }

  public function store(Request $request) {}

  public function show(string $id) {}

  public function edit(Empresa $empresa) {}

  public function update(Request $request, Empresa $empresa) {}

  public function destroy(string $id) {}

  public function certificados(Request $request, string $id)
  {
    $validated = $request->validate($this->toValidatedCert);

    try {
      // Generar QR Code

      // Guardar informacion del certificado
      $certificado = new Certificado();
      $certificado->empresa_id = $id;
      $certificado->user_id = Auth::id();
      $certificado->qrcode = '';
      $certificado->firmadigital = '';
      $certificado->titulo = $validated['titulo'];
      $certificado->actividad = $validated['actividad'];
      $certificado->validez = $validated['validez'];
      $certificado->direccion = $validated['direccion'];
      $certificado->diagnostico = $validated['diagnostico'];
      $certificado->condicion = $validated['condicion'];
      $certificado->trabajo = $validated['trabajo'];
      $certificado->plaguicidas = $validated['plaguicidas'];
      $certificado->registro = $validated['registro'];
      $certificado->area = $validated['area'];
      $certificado->acciones = $validated['acciones'];

      $path = '';
      if ($request->hasFile('logo')) {
        $path = $request->file('logo')->store('logos', 'public');
      }

      $certificado->logo = $path;

      $certificado->save();

      return redirect()->back()->with('success', 'Certificado creado exitosamente');
    } catch (\Error $e) {
      Log::info("ERROR ******************** " . $e->getMessage());
      return redirect()->back()
        ->withInput()
        ->withErrors('error', 'Error crítico al crear el certificado. Contacte al administrador.');
    } catch (\Exception $e) {
      Log::info("EXCEPTION ******************** " . $e->getMessage());
      return redirect()->back()
        ->withInput()
        ->withErrors('error', 'Error crítico al crear el certificado. Contacte al administrador.');
    }
  }

  public function certificadopdf(Request $request, string $id)
  {
    // $certificado = Certificado::find($request->id);
    $certificado = Certificado::find($id);
    // Cargar la vista Blade con los datos
    $pdf = Pdf::loadView('pdf.certificado', compact('certificado'));
    // Opcional: configurar tamaño, orientación, etc.
    $pdf->setPaper('letter', 'landscape');
    return $pdf->stream('certificado-' . now()->format('Y-m-d') . '.pdf');
    // o ->download() si quieres forzar descarga
  }

  public function certificadoultimo()
  {
    $certificado = Certificado::latest()->first();
    // Cargar la vista Blade con los datos
    $pdf = Pdf::loadView('pdf.certificado', compact('certificado'));
    // Opcional: configurar tamaño, orientación, etc.
    $pdf->setPaper('letter', 'landscape');
    return $pdf->stream('certificado-' . now()->format('Y-m-d') . '.pdf');
    // o ->download() si quieres forzar descarga
  }
}