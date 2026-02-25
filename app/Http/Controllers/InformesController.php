<?php

namespace App\Http\Controllers;

use App\Models\Almacen;
use App\Models\Empresa;
use App\Models\Seguimiento;
use App\Models\SeguimientoImage;
use App\Models\User;
use Illuminate\Http\Request;
use Carbon\Carbon;
use Illuminate\Support\Facades\Log;
use PhpOffice\PhpWord\PhpWord;
use PhpOffice\PhpWord\IOFactory;

class InformesController extends Controller
{
  public function index(Request $request)
  {
    $user = $request->user();
    if ($user->HasRole('cliente')) {
      $empresasUser = User::with('empresas')->find($user->id);
      $empresaUser = $empresasUser->empresas[0];
      $empresas = Empresa::select(['id', 'nombre'])->where('id', $empresaUser->id)->get();
    } else {
      $empresas = Empresa::select('id', 'nombre')->get();
    }

    $almacenes = [];
    if ($request->empresa_id) {
      $almacenes = Almacen::where('empresa_id', $request->empresa_id)
        ->select('id', 'nombre')
        ->get();
    }
    // 🔴 SOLO buscar si presiona el botón
    $seguimientos = [];
    if (
      $request->filled('buscar') &&
      $request->almacen_id &&
      $request->fecha_inicio &&
      $request->fecha_fin
    ) {
      $seguimientos = Seguimiento::with(['roedores', 'insectocutores.especie'])->where('almacen_id', $request->almacen_id)
        ->whereBetween('created_at', [
          $request->fecha_inicio . ' 00:00:00',
          $request->fecha_fin . ' 23:59:59',
        ])
        ->orderBy('created_at', 'desc')
        ->get(['id', 'tipo_seguimiento_id', 'created_at']);
    }
    return inertia('admin/informes/index', [
      'empresas'     => $empresas,
      'almacenes'    => $almacenes,
      'seguimientos' => $seguimientos,
      'filters' => $request->only(
        'empresa_id',
        'almacen_id',
        'fecha_inicio',
        'fecha_fin'
      ),
    ]);
  }

  public function obtenerEstado(Request $request)
  {
    $request->validate([
      'fecha_inicio' => 'required|date',
      'fecha_fin' => 'required|date|after_or_equal:fecha_inicio',
    ]);
    $f_inicio = Carbon::parse($request->fecha_inicio)->startOfDay(); // Establece a 00:00:00
    $f_fin = Carbon::parse($request->fecha_fin)->endOfDay(); // Establece a 23:59:59
    $almacen_id = 1;
    $informe = [
      'imagenes' => $this->conseguirImagenes($f_inicio, $f_fin, $almacen_id),
    ];
    return response()->json($informe);
  }

  private function saveBase64Image($base64, $name)
  {
    if (!$base64) return null;

    preg_match('/^data:image\/(\w+);base64,/', $base64, $type);

    $data = substr($base64, strpos($base64, ',') + 1);
    $data = base64_decode($data);

    $path = storage_path("app/$name.png");

    file_put_contents($path, $data);

    return $path;
  }

  private function conseguirImagenes($inicio, $fin, $almacen_id)
  {
    return SeguimientoImage::whereBetween('created_at', [$inicio, $fin])->where('almacen');
  }

  public function storeWord(Request $request)
  {
    // if (!$request->imagen) {
    //   return response()->json(['error' => 'No se recibió imagen'], 400);
    // }

    // $image = $request->imagen;

    // // Extraer tipo y data base64 correctamente
    // if (!preg_match('/^data:image\/(\w+);base64,/', $image, $type)) {
    //   return response()->json(['error' => 'Formato base64 inválido'], 400);
    // }

    // $image = substr($image, strpos($image, ',') + 1);
    // $image = str_replace(' ', '+', $image);

    // $imageData = base64_decode($image);

    // if ($imageData === false) {
    //   return response()->json(['error' => 'Base64 corrupto'], 400);
    // }

    // // Guardar imagen temporal
    // $imagePath = storage_path('app/informe.png');
    // file_put_contents($imagePath, $imageData);

    // // Validar que realmente sea una imagen
    // if (!file_exists($imagePath) || filesize($imagePath) < 1000) {
    //   return response()->json(['error' => 'Imagen inválida'], 400);
    // }

    $chart1 = $this->saveBase64Image($request->chart1, 'chart1');
    $chart2 = $this->saveBase64Image($request->chart2, 'chart2');
    $chart3 = $this->saveBase64Image($request->chart3, 'chart3');
    $chart4 = $this->saveBase64Image($request->chart4, 'chart4');

    // Crear Word
    $phpWord = new PhpWord();

    // $section = $phpWord->addSection([
    //   'orientation' => 'landscape'
    // ]);

    $section = $phpWord->addSection([
      'orientation' => 'portrait'
    ]);

    $section->addText('INFORME');

    // $section->addImage($imagePath, [
    //   'width' => 1000
    // ]);

    $section->addTextBreak();

    // $section->addImage(
    //   realpath($imagePath),
    //   [
    //     'width' => 300,
    //     'alignment' => 'center'
    //   ]
    // );

    if ($chart1) {
      $section->addTextBreak();
      $section->addText('Total insectos por especie');
      $section->addImage($chart1, ['width' => 700]);
    }

    if ($chart2) {
      $section->addPageBreak();
      $section->addText('Evolución de insectos');
      $section->addImage($chart2, ['width' => 700]);
    }

    if ($chart3) {
      $section->addPageBreak();
      $section->addText('Comparación de pesos por trampa');
      $section->addImage($chart3, ['width' => 700]);
    }

    if ($chart4) {
      $section->addPageBreak();
      $section->addText('Valores por trampa');
      $section->addImage($chart4, ['width' => 700]);
    }

    $file = storage_path('app/informe.docx');

    IOFactory::createWriter($phpWord, 'Word2007')->save($file);

    return response()->json(['ok' => true]);
  }

  public function downloadWord()
  {
    return response()->download(storage_path('app/informe.docx'));
  }


  /** FUNCIONES NO USADAS */
  // public function create() {}
  // public function store(Request $request) {}
  // public function show(string $id) {}
  // public function edit(string $id) {}
  // public function update(Request $request, string $id) {}
  // public function destroy(string $id) {}

  // private function getEmpresas()
  // {
  //   $empresas = Empresa::select('id', 'nombre')->get();
  //   return  response()->json($empresas);
  // }
  // private function getAlmacen(Request $request, string $id)
  // {
  //   $almacenes = Almacen::where('empresa_id', $id)->select('id', 'nombre')->get();
  //   return response()->json($almacenes);
  // }

  // private function getSeguimientos(Request $request, string $id)
  // {
  //   $seguimientos = Seguimiento::where('almacen_id', $id)->select('id', 'created_at')->latest()->get();
  //   return response()->json($seguimientos);
  // }
}
