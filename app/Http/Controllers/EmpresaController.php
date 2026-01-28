<?php

namespace App\Http\Controllers;

use App\Models\Almacen;
use App\Models\Certificado;
use App\Models\Empresa;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Barryvdh\DomPDF\Facade\Pdf;
use Exception;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Database\QueryException;

class EmpresaController extends Controller
{
  private $toValidatedCert = [
    'titulo' => 'required|string',
    'establecimiento' => 'required|string',
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

  public function index(Request $request)
  {
    $user = $request->user();
    if ($user->HasRole('cliente')) {
      $empresas = User::with('empresas')->find($user->id);
      $empresa = $empresas->empresas[0];
      $empresas = Empresa::with(['certificados'])->where('id', $empresa->id)->paginate(10);
    } else {
      $empresas = Empresa::with(['certificados'])->paginate(10);
    }
    return inertia('admin/empresas/lista', ['empresas' => $empresas]);
  }

  public function create()
  {
    return inertia('admin/empresas/crear');
  }

  public function certificados(Request $request, string $id)
  {
    // dd($request);
    $validated = $request->validate($this->toValidatedCert);

    try {
      DB::beginTransaction();
      // Generar QR Code

      // Guardar informacion del certificado
      $certificado = new Certificado();
      $certificado->empresa_id = $id;
      $certificado->user_id = Auth::id();
      $certificado->qrcode = '';
      $certificado->firmadigital = '';
      $certificado->titulo = $validated['titulo'];
      $certificado->establecimiento = $validated['establecimiento'];
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
        // GUARDAR IMAGEN A PUBLIC
        $file = $request->file('logo');
        $filename = uniqid() . '_' . $file->getClientOriginalName();
        $file->move(
          public_path('images/certificado'),
          $filename
        );
        $path = 'images/certificado/' . $filename;
      }

      $certificado->logo = $path;

      $certificado->save();
      DB::commit();

      return redirect()->back()->with('success', 'Certificado creado exitosamente');
    } catch (Exception | \Error | QueryException $e) {
      DB::rollBack();
      Log::info("ERROR ******************** " . $e->getMessage());
      return redirect()->back()
        ->withInput()
        ->withErrors('error', 'Error crítico al crear el certificado. Contacte al administrador.');
    }
  }

  public function certificadopdf(Request $request, string $id)
  {
    $certificado = Certificado::find($id);
    $pdf = Pdf::loadView('pdf.certificado', compact('certificado'));
    $pdf->setPaper('letter', 'landscape');
    return $pdf->stream('certificado-' . now()->format('Y-m-d') . '.pdf');
  }

  public function certificadoultimo()
  {
    $certificado = Certificado::latest()->first();
    $pdf = Pdf::loadView('pdf.certificado', compact('certificado'));
    $pdf->setPaper('letter', 'landscape');
    return $pdf->stream('certificado-' . now()->format('Y-m-d') . '.pdf');
  }

  public function getByEmpresa($empresaId)
  {
    $almacenes = Almacen::where('empresa_id', $empresaId)->get(['id', 'nombre']);
    return response()->json($almacenes);
  }

  /* FUNCIONES NO UTILIZADAS */
  // public function store(Request $request) {}
  // public function show(string $id) {}
  // public function edit(Empresa $empresa) {}
  // public function update(Request $request, Empresa $empresa) {}
  // public function destroy(string $id) {}
}
