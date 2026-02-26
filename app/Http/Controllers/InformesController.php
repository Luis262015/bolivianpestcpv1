<?php

namespace App\Http\Controllers;

use App\Models\Almacen;
use App\Models\Empresa;
use App\Models\Seguimiento;
use App\Models\SeguimientoImage;
use App\Models\TrampaRoedorSeguimiento;
use App\Models\User;
use Illuminate\Http\Request;
use Carbon\Carbon;
use Illuminate\Support\Facades\Log;
use PhpOffice\PhpWord\PhpWord;
use PhpOffice\PhpWord\IOFactory;
use PhpOffice\PhpWord\SimpleType\Jc;


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

    // -----------------------------------------------------------------------------

    // Log::info($request->seguimiento_ids);
    $seguimientoIds = $request->input('seguimiento_ids', []);
    $seguimientos = Seguimiento::with([
      'insectocutores.especie',
      'roedores'
    ])->whereIn('id', $request->seguimiento_ids)->get();

    $especies = [];
    $datosPorFecha = [];

    foreach ($seguimientos as $seg) {

      if ($seg->tipo_seguimiento_id != 3) {
        continue;
      }

      $fecha = $seg->created_at->format('d/m/Y');

      if (!isset($datosPorFecha[$fecha])) {
        $datosPorFecha[$fecha] = [];
      }

      foreach ($seg->insectocutores as $ins) {

        $nombre = $ins->especie->nombre;
        $especies[$nombre] = true;

        if (!isset($datosPorFecha[$fecha][$nombre])) {
          $datosPorFecha[$fecha][$nombre] = 0;
        }

        $datosPorFecha[$fecha][$nombre] += $ins->cantidad;
      }
    }

    $especies = array_keys($especies);

    $datosRoedores = [];

    foreach ($seguimientos as $seg) {

      foreach ($seg->roedores as $r) {

        $key = $r->trampa_id;

        if (!isset($datosRoedores[$key])) {
          $datosRoedores[$key] = [
            'inicial' => 0,
            'merma' => 0,
            'actual' => 0,
          ];
        }

        $datosRoedores[$key]['inicial'] += $r->inicial;
        $datosRoedores[$key]['merma'] += $r->merma;
        $datosRoedores[$key]['actual'] += $r->actual;
      }
    }

    // Log::info($seguimientos);
    // return;

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

    $phpWord->addParagraphStyle('global', [
      'lineHeight' => 1.15,
      'spaceAfter' => 0,
      'spaceBefore' => 0,
    ]);

    // CARATULA

    $section->addText('INFORME');
    $section->addText('Fecha:');
    $section->addText('CITE ');
    $section->addTextBreak();
    $section->addText('De mi mayor consideración:');
    $section->addText('Adjunto al presente remito a usted el Informe técnico sobre el Control Integral de Plagas realizado en los almacenes Tunari Cochabamba, valido por el mes de diciembre desratización y fumigación.');
    $section->addText('Sin otro particular saludo a usted con las consideraciones más distinguidas de mi respeto personal.');
    $section->addText('Atentamente');
    $section->addPageBreak();

    // INFORME TECNICO
    $section->addText('INFORME TECNICO');
    $section->addText('CONTROL DE PLAGAS');
    $section->addText('"ALMACEN ************');
    $section->addText('INTRODUCCIÓN:');
    $section->addText('Las Buenas Prácticas de Almacenamiento BPAS son una herramienta básica para la obtención de productos seguros para el consumo y se focaliza en la higiene y en cómo se deben manipular estos siendo su aplicación obligatoria.');
    $section->addText('La importancia de controlar las plagas radica en las pérdidas que estas ocasionan a través de mercaderías arruinadas, alimentos contaminados, potenciales demandas, productos mal utilizados para el control, daños a estructuras físicas de la empresa, pérdida de imagen, etc. ');
    $section->addText('Dando cumplimiento al CONTROL DE PLAGAS para esta gestión que se realiza a la empresa “RANSA ALMACEN ILLIMANI” pasamos a desglosar las actividades alcanzadas para el mes de enero 2024 en lo que se refiere al almacén de productos.');
    $section->addText('OBJETIVO:');
    $section->addText('Contribuir a la mejora del almacenamiento de los productos dentro la empresa RANSA por medios de controles integrados de plagas aportando a la conservación de los productos libres de contaminantes.');
    $section->addText('METODOLOGIA:');
    $section->addText('Respecto al trabajo realizado se tomará en cuenta tres etapas:');
    $section->addText('- Lo que se realizó el presente mes');
    $section->addText('- El balance análisis.');
    $section->addText('- Las recomendaciones para el próximo mes.');

    // Lo que se realizo en la visita
    $section->addText('LO QUE SE REALIZO EN EL MES DE ********');
    // FOTOS

    // Balance y análisis
    $section->addText('BALANCE Y ANALISIS.');
    $section->addText('Se cumplió con el mantenimiento del control integral de plagas propuesto con el seguimiento de las [X] unidades de control de roedores para el pesaje de las unidades de control');

    // [TABLA DE TRAMPAS]
    // Crear tabla
    $section->addTextBreak();
    $section->addText('Peso de trampas', ['bold' => true]);

    $table = $section->addTable();

    $table->addRow();
    $table->addCell()->addText('Trampa');
    $table->addCell()->addText('Inicial');
    $table->addCell()->addText('Merma');
    $table->addCell()->addText('Actual');

    foreach ($datosRoedores as $trampa => $data) {

      $table->addRow();
      $table->addCell()->addText($trampa);
      $table->addCell()->addText($data['inicial']);
      $table->addCell()->addText($data['merma']);
      $table->addCell()->addText($data['actual']);
    }

    // SEGUIMIENTO DE TRAMAPAS
    $section->addText('SEGUIMIENTO PESO DE TRAMPAS');

    if ($chart3) {
      // $section->addPageBreak();
      $section->addText('Comparación de pesos por trampa');
      $section->addImage($chart3, ['width' => 300]);
    }

    if ($chart4) {
      // $section->addPageBreak();
      $section->addText('Valores por trampa');
      $section->addImage($chart4, ['width' => 300]);
    }

    // [RESUMEN DE SEGUIMIENTOS DE TRAMPAS]
    // [TABLA RESUMEN]
    // [GRAFICO DE REGISTRO QUINCENAL]

    $section->addText('BARRERAS FISICAS DE EXCLUCION (INSECTOCUTORES)');
    $section->addText('Para el control de insectos voladores se ha implementado tres insectocutores se realizó el seguimiento de cada uno de los insectocutores revisando el tipo de insecto encontrado y la cantidad, con esta información se ha podido calcular la incidencia y severidad se muestra a través de gráficos las tendencias y análisis respectivos');

    $section->addText('CANTIDAD DE INSECTOCUTORES');

    $section->addTextBreak();
    $section->addText('Incidencia de insectos', ['bold' => true]);

    $table = $section->addTable();

    $table->addRow();
    $table->addCell()->addText('Fecha');

    foreach ($especies as $esp) {
      $table->addCell()->addText($esp);
    }

    foreach ($datosPorFecha as $fecha => $data) {

      $table->addRow();
      $table->addCell()->addText($fecha);

      foreach ($especies as $esp) {
        $valor = $data[$esp] ?? 0;
        $table->addCell()->addText($valor);
      }
    }



    $section->addText('La incidencia es el número de individuos que están presentes en un determinado lugar la gráfica de incidencia muestra la presencia en estado adulto de los tres tipos de insectos que se ha logrado capturar que son mosca, mosquito y polillas en este estado no realizan daño directo sino tienen una actividad de colocar huevos para completar su metamorfosis.');
    $section->addText('Para realizar el calculo de la incidencia se toma en cuenta las cuatro visitas realizadas en los formularios de conformidad se saca el promedio de los 3 insectocutores por visita y se llena la tabla que se muestra a continuación.');
    $section->addText('');



    if ($chart1) {
      $section->addTextBreak();
      $section->addText('Total insectos por especie');
      $section->addImage($chart1, ['width' => 300]);
    }

    // [TABLA DE INCIDENCIA]

    if ($chart2) {
      // $section->addPageBreak();
      $section->addText('Evolución de insectos');
      $section->addImage($chart2, ['width' => 300]);
    }

    // [TABLA DE SEVERIDAD]

    if ($chart2) {
      // $section->addPageBreak();
      $section->addText('Evolución de insectos');
      $section->addImage($chart2, ['width' => 300]);
    }

    $section->addTextBreak();

    $section->addText('RECOMENDACIONES PARA LA PROXIMA VISITA:');
    $section->addText('- La recomendación del orden y limpieza para el mantenimiento de los procesos de control de plagas es necesario recalcarlos para los encargados de los almacenes, estibadores y ayudantes de los almacenes.');
    $section->addText('- Para mantener el efecto del trabajo realizado recomendamos tener cuidado con las unidades de control evitando golpes, y recojo de sustancias pegajosas.');
    $section->addText('- En el ingreso de nueva mercadería a los almacenes verificando siempre la existencia de plagas que puedan alterar el control integral en el cual se está trabajando.');
    $section->addText('- Mantener con protección los puntos de ingreso de personal y producto para evitar el ingreso de contaminantes al almacén.');
    $section->addText('- Se debe tener cuidado de cerrar las puertas una vez ingresado el personal o la mercadería en el sentido que si se dejan abiertas cualquier ave puede ingresar y contaminar los productos que se resguardan');

    // $section->addImage(
    //   realpath($imagePath),
    //   [
    //     'width' => 300,
    //     'alignment' => 'center'
    //   ]
    // );





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
