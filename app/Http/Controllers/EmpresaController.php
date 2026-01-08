<?php

namespace App\Http\Controllers;

use App\Models\Certificado;
use App\Models\Empresa;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class EmpresaController extends Controller
{

  private $toValidated = [
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

  public function store(Request $request)
  {
    $validated = $request->validate([
      'nombre' => 'required',
      'direccion' => 'required',
      'telefono' => 'nullable',
      'email' => 'required|email',
      'ciudad' => 'required',
      'activo' => 'boolean',
    ]);

    Empresa::create($validated);
    return redirect()->route('empresas.index');
  }

  public function show(string $id) {}

  public function edit(Empresa $empresa)
  {
    dd("LLEGO INFORMACION " . $empresa);
    return inertia('admin/empresas/editar', ['empresa' => $empresa]);
  }

  public function update(Request $request, Empresa $empresa)
  {
    $validated = $request->validate([
      'nombre' => 'required',
      'direccion' => 'required',
      'telefono' => 'nullable',
      'email' => 'required|email',
      'ciudad' => 'required',
      'activo' => 'boolean',
    ]);
    $empresa->update($validated);
    return redirect()->route('empresas.index');
  }

  public function destroy(string $id)
  {
    Empresa::find($id)->delete();
    return redirect()->route('empresas.index');
  }

  public function certificados(Request $request, string $id)
  {
    // dd($request);
    // dd($id);

    $validated = $request->validate($this->toValidated);

    // dd($validated);

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
  }
}
