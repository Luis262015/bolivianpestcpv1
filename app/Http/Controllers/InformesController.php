<?php

namespace App\Http\Controllers;

use App\Models\Almacen;
use App\Models\Empresa;
use App\Models\Seguimiento;
use App\Models\SeguimientoImage;
use App\Models\Trampa;
use App\Models\TrampaRoedorSeguimiento;
use App\Models\User;
use Illuminate\Http\Request;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use PhpOffice\PhpWord\PhpWord;
use PhpOffice\PhpWord\IOFactory;
use PhpOffice\PhpWord\SimpleType\Jc;
use PhpOffice\PhpWord\Style\Language;


class InformesController extends Controller
{
  /**
   * Requerimiento de datos para realizar un INFORME
   * @param Request $request
   * @return \Inertia\Response
   */
  public function index(Request $request)
  {

    $user = $request->user();

    // CONSEGUIMOS DATOS DE EMPRESAS
    if ($user->HasRole('cliente')) {
      $empresasUser = User::with('empresas')->find($user->id);
      $empresaUser = $empresasUser->empresas[0];
      $empresas = Empresa::select(['id', 'nombre'])->where('id', $empresaUser->id)->get();
    } else {
      $empresas = Empresa::select('id', 'nombre')->get();
    }

    // CONSEGUIMOS DATOS DE ALMACENES
    $almacenes = [];
    if ($request->empresa_id) {
      $almacenes = Almacen::where('empresa_id', $request->empresa_id)
        ->select('id', 'nombre')
        ->get();
    }

    // 🔴 SOLO buscar si presiona el botón
    $seguimientos = [];
    $trampas_insect = 0;
    $trampas_rat = 0;
    $totales = [];

    if (
      $request->filled('buscar') &&
      $request->almacen_id &&
      $request->fecha_inicio &&
      $request->fecha_fin
    ) {

      // Validar si quieres asegurarte que venga empresa_id
      $request->validate([
        'empresa_id' => 'required|integer|exists:empresas,id',
      ]);

      // LISTA DE SEGUIMIENTOS
      $seguimientos = Seguimiento::with(['almacen', 'roedores.trampa.trampa_tipo', 'roedores.trampa.mapa', 'insectocutores.especie', 'tipoSeguimiento', 'user'])
        ->where('almacen_id', $request->almacen_id)
        ->whereBetween('created_at', [
          $request->fecha_inicio . ' 00:00:00',
          $request->fecha_fin . ' 23:59:59',
        ])
        ->orderBy('created_at', 'asc')
        ->get(['id', 'tipo_seguimiento_id', 'user_id', 'created_at', 'encargado_nombre', 'encargado_cargo', 'almacen_id']);

      $totales = TrampaRoedorSeguimiento::query()
        ->join('seguimientos', 'seguimientos.id', '=', 'trampa_roedor_seguimientos.seguimiento_id')
        ->where('seguimientos.almacen_id', $request->almacen_id)
        ->whereBetween('seguimientos.created_at', [
          $request->fecha_inicio . ' 00:00:00',
          $request->fecha_fin . ' 23:59:59',
        ])
        ->selectRaw("
        DATE_FORMAT(seguimientos.created_at, '%Y-%m') as mes,
        SUM(trampa_roedor_seguimientos.inicial) as inicial_sum,
        SUM(trampa_roedor_seguimientos.merma) as merma_sum,
        SUM(trampa_roedor_seguimientos.actual) as actual_sum,

        AVG(trampa_roedor_seguimientos.inicial) as inicial_avg,
        AVG(trampa_roedor_seguimientos.merma) as merma_avg,
        AVG(trampa_roedor_seguimientos.actual) as actual_avg
    ")
        ->groupBy(DB::raw("DATE_FORMAT(seguimientos.created_at, '%Y-%m')"))
        ->orderBy('mes')
        ->get();

      // CONTEO DE TRAMPAS
      $trampas = Trampa::where('almacen_id', $request->almacen_id)->get();
      $trampas_insect = $trampas->where('trampa_tipo_id', 2)->count();
      $trampas_rat = $trampas->where('trampa_tipo_id', '!=', 2)->count();
    }
    return inertia('admin/informes/index', [
      'empresas'     => $empresas,
      'almacenes'    => $almacenes,
      'seguimientos' => $seguimientos,
      'trampasinsect' => $trampas_insect,
      'trampasrat' => $trampas_rat,
      'totales' => $totales,
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

    // $seguimientoIds = $request->input('seguimiento_ids', []);

    $seguimientos = Seguimiento::with([
      'insectocutores.especie',
      'roedores'
    ])->whereIn('id', $request->seguimiento_ids)->get();

    // Log::info($seguimientos);




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

    // Log::info($especies);



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

    // Log::info(print_r($datosRoedores, true));


    $chart1 = $this->saveBase64Image($request->chart1, 'chart1');
    $chart2 = $this->saveBase64Image($request->chart2, 'chart2');
    $chart3 = $this->saveBase64Image($request->chart3, 'chart3');
    $chart4 = $this->saveBase64Image($request->chart4, 'chart4');
    $chart5 = $this->saveBase64Image($request->chart5, 'chart5');
    $chart6 = $this->saveBase64Image($request->chart6, 'chart6');



    // Crear Word
    $phpWord = new PhpWord();

    // Idioma español
    $phpWord->getSettings()->setThemeFontLang(
      new Language(Language::ES_ES)
    );

    $phpWord->addParagraphStyle('global', [
      'lineHeight' => 1.15,
      'spaceAfter' => 0,
      'spaceBefore' => 0,
    ]);

    $phpWord->addTableStyle(
      'tablaInforme',
      [
        'borderSize' => 6,
        'borderColor' => '000000',
        'cellMargin' => 80,
        'alignment' => \PhpOffice\PhpWord\SimpleType\JcTable::CENTER,
        // 'layout' => \PhpOffice\PhpWord\Style\Table::LAYOUT_FIXED,
      ],
      [
        'bgColor' => 'D9D9D9' // estilo para la fila encabezado
      ]
    );

    // $section = $phpWord->addSection([
    //   'orientation' => 'landscape'
    // ]);



    $section1 = $phpWord->addSection([
      'orientation' => 'portrait',
      'marginTop' => 2500,
      'marginBottom' => 1417,
      'marginLeft' => 2500,
      'marginRight' => 1700,
      'differentFirstPageHeaderFooter' => true
    ]);

    // Log::info('CONFIGURACIONES');

    $this->caratula($section1, $request);

    // Log::info('PRIMERA SECCION');

    $section = $phpWord->addSection([
      'orientation' => 'portrait',
      'marginLeft' => 2500,
    ]);



    // ---------------------SECCION: TITULO GENERAL DEL DOCUMENTO ----------------------------
    // INFORME TECNICO
    $section->addText('INFORME TECNICO', [
      'bold' => true,
      'size' => 11,
      'underline' => 'single',
    ], [
      'alignment' => Jc::CENTER,
      'lineHeight' => 1,
    ]);
    $section->addText('CONTROL DE PLAGAS', [
      'bold' => true,
      'size' => 11,
      'underline' => 'single',
    ], [
      'alignment' => Jc::CENTER,
      'lineHeight' => 1,
    ]);
    $section->addText('"ALMACEN _________"', [
      'bold' => true,
      'size' => 11,
      'underline' => 'single',
    ], [
      'alignment' => Jc::CENTER,
      'lineHeight' => 1,
    ]);

    // ---------------------SECCION: INTRODUCCION ----------------------------
    $section->addText('INTRODUCCIÓN:', [
      'bold' => true,
      'size' => 11,
      'underline' => 'single',
    ]);
    $section->addText(
      'Las Buenas Prácticas de Almacenamiento BPAS son una herramienta básica para la obtención de productos seguros para el consumo y se focaliza en la higiene y en cómo se deben manipular estos siendo su aplicación obligatoria.',
      [],
      [
        'alignment' => Jc::BOTH,
        'lineHeight' => 1.15
      ]
    );
    $section->addText(
      'La importancia de controlar las plagas radica en las pérdidas que estas ocasionan a través de mercaderías arruinadas, alimentos contaminados, potenciales demandas, productos mal utilizados para el control, daños a estructuras físicas de la empresa, pérdida de imagen, etc. ',
      [],
      [
        'alignment' => Jc::BOTH,
        'lineHeight' => 1.15
      ]
    );
    $section->addText(
      'Dando cumplimiento al CONTROL DE PLAGAS para esta gestión que se realiza a la empresa “____________________” pasamos a desglosar las actividades alcanzadas para el mes de ___________ en lo que se refiere al almacén de productos.',
      [],
      [
        'alignment' => Jc::BOTH,
        'lineHeight' => 1.15
      ]
    );
    $section->addText('OBJETIVO:', [
      'bold' => true,
      'size' => 11,
      'underline' => 'single',
    ]);
    $section->addText(
      'Contribuir a la mejora del almacenamiento de los productos dentro la empresa ________ por medios de controles integrados de plagas aportando a la conservación de los productos libres de contaminantes.',
      [],
      [
        'alignment' => Jc::BOTH,
        'lineHeight' => 1.15
      ]
    );
    $section->addText('METODOLOGIA:', [
      'bold' => true,
      'size' => 11,
      'underline' => 'single',
    ]);
    $section->addText('Respecto al trabajo realizado se tomará en cuenta tres etapas:');
    $section->addListItem('Lo que se realizó el presente mes');
    $section->addListItem('El balance análisis.');
    $section->addListItem('Las recomendaciones para el próximo mes.');




    // ---------------------SECCION: LO QUE SE REALIZO EN LA VISITA ----------------------------

    $section->addText('LO QUE SE REALIZO EN LA VISITA', [
      'bold' => true,
      'size' => 11,
      'underline' => 'single',
    ]);


    // ---------------------SUBSECCION: DESRATIZACION ----------------------------

    $section->addText('1) DESRATIZACIÓN', [
      'bold' => true,
      'size' => 11,
      'underline' => 'single',
    ]);

    // ************************************************************************************
    // FOTOS DE VISITAS POR SEGUIMIENTO ***********************************************
    // ************************************************************************************

    // ************************************************************************************
    // TABLA CANTIDAD DE TRAMPAS x TIPO y CANTIDAD DE ROEDORES CAPTURADOS *****************
    // ************************************************************************************

    $section->addText(
      'Los rodenticidas utilizados para el trabajo son  en presentación de pellets  y bloques parafinados de acuerdo a la ubicación de las trampas sea exterior o interior se coloca el respectivo rodenticida esto esta en función tambien del nivel de riesgo de la presencia de plaga.',
      [],
      [
        'alignment' => Jc::BOTH,
        'lineHeight' => 1.15
      ]
    );

    $table = $section->addTable('tablaCebo');

    $table->addRow();
    $table->addCell(2000)->addText('NOMBRE COMERCIAL', ['bold' => true]);
    $table->addCell(2000)->addText('INGREDIENTE ACTIVO', ['bold' => true]);
    $table->addCell(2000)->addText('COMPOSICION', ['bold' => true]);
    $table->addCell(2000)->addText('CLASE', ['bold' => true]);

    $table->addCell(2000)->addText('RODENTICIDA KLERAT');
    $table->addCell(2000)->addText('BRODIFACOUM (3-3-4 bromo 1-1 bifenil-4-il-1-2-3-4 tetrahidro1-naftalenil-4 hidrocumarina)');
    $table->addCell(2000)->addText('Rodenticida Monosodico de Actividad Prolongada Cebo en Granos.');
    $table->addCell(2000)->addText('CLARODENTICIDA RATICIDA MONOSODICOSE');

    $table->addCell(2000)->addText('GRUPO QUIMICO', ['bold' => true]);
    $table->addCell(2000)->addText('TIPO FORMULACION', ['bold' => true]);
    $table->addCell(2000)->addText('NUMERO DE REGISTRO', ['bold' => true]);
    $table->addCell(2000)->addText('PRESENTACION', ['bold' => true]);

    $table->addCell(2000)->addText('BRODIFACOUM   WARFARINICO');
    $table->addCell(2000)->addText('CEBO EN PELLETS');
    $table->addCell(2000)->addText('INSO NRO. BR1020ROAB01');
    $table->addCell(2000)->addText('IMG');

    $table = $section->addTable('tablaBloques');

    $table->addRow();
    $table->addCell(2000)->addText('NOMBRE COMERCIAL', ['bold' => true]);
    $table->addCell(2000)->addText('INGREDIENTE ACTIVO', ['bold' => true]);
    $table->addCell(2000)->addText('COMPOSICION', ['bold' => true]);
    $table->addCell(2000)->addText('CLASE', ['bold' => true]);

    $table->addCell(2000)->addText('RODENTICIDA KLERAT');
    $table->addCell(2000)->addText('BRODIFACOUM');
    $table->addCell(2000)->addText('Brodifacoum……0.05g Beozoato de denatonium …..0.01 g Excipientes c.s. 1kg Cebo en Granos.');
    $table->addCell(2000)->addText('RODENTICIDA RATICIDA MONOSODICO');

    $table->addCell(2000)->addText('GRUPO QUIMICO', ['bold' => true]);
    $table->addCell(2000)->addText('TIPO FORMULACION', ['bold' => true]);
    $table->addCell(2000)->addText('NUMERO DE REGISTRO', ['bold' => true]);
    $table->addCell(2000)->addText('PRESENTACION', ['bold' => true]);

    $table->addCell(2000)->addText('BRODIFACOUM   WARFARINICO');
    $table->addCell(2000)->addText('BLOQUES PARAFINICOS');
    $table->addCell(2000)->addText('INSO NRO. BRO913ROBB01');
    $table->addCell(2000)->addText('IMG');

    // ---------------------SUBSECCION: SEGUIMIENTO DE LAS UNIDADES DE CONTROL ----------------------------
    $section->addText('SEGUIMIENTO DE LAS UNIDADES DE CONTROL', [
      'bold' => true,
      'size' => 11,
      'underline' => 'single',
    ]);



    // ************************************************************************************
    // TABLA FECHAS DE SEGUIMIENTOS *****************
    // ************************************************************************************

    // ************************************************************************************
    // TABLA CANTIDAD DE TRAMPAS x TIPO y CANTIDAD DE ROEDORES CAPTURADOS (EN CADA SEGUIMIENTO) ***
    // ************************************************************************************    

    // ---------------------SUBSECCION: BALANCE Y ANALISIS ----------------------------    
    $section->addText('BALANCE Y ANALISIS.', [
      'bold' => true,
      'size' => 11,
      'underline' => 'single',
    ]);
    $section->addText(
      'Se cumplió con el seguimiento de las 68 unidades de control de roedores procediendo al pesaje de los cebos de las trampas a continuación se muestras los cuadros resúmenes de estas  actividades.',
      [],
      [
        'alignment' => Jc::BOTH,
        'lineHeight' => 1.15
      ]
    );

    $section->addText(
      'Los cuadros muestran los pesos obtenidos por fechas de seguimiento se verifica el peso total la merma y peso actual de las 68 unidades de control de roedores.',
      [],
      [
        'alignment' => Jc::BOTH,
        'lineHeight' => 1.15
      ]
    );

    // ************************************************************************************
    // TABLA RESUMEN X (CADA SEGUIMIENTO Y CADA ALMACEN) ***
    // ************************************************************************************    

    $section->addText(
      'Analizando las tablas de pesos respecto al porcentaje de merma se establece que este no pasa del 5% con relación al Peso Total 100% lo que significa que no ha existido consumo por parte de roedores ni su presencia en las fechas evaluadas. Este porcentaje esta relacionado con perdidas por medio ambiente vale decir condiciones de humedad, temperatura, vientos lluvia, etc. que afectan a los cebos colocados.',
      [],
      [
        'alignment' => Jc::BOTH,
        'lineHeight' => 1.15
      ]
    );

    $section->addText(
      'La Grafica 1 muestra la DL50 (dosis letal media) de los ingredientes activos de los rodenticidas mostrando que brodifacoum es el ingrediente mas efectivo ya que su porcentaje tanto para rata y raton es el mas bajo por lo tanto mas toxico necesitando menor consumo para ser mas efectivo.',
      [],
      [
        'alignment' => Jc::BOTH,
        'lineHeight' => 1.15
      ]
    );

    $section->addImage(public_path('images/informe/Tabla-DL50.png'), [
      'width'  => 200,
      'height' => 100,
      'alignment' => Jc::CENTER,
    ]);


    // ************************************************************************************
    // GRAFICA: IMAGEN DESDE PUBLIC ***
    // ************************************************************************************    

    $section->addText(
      'La Grafica 2 muestra la cantidad de cebo que debe ingerir un roedor según los ingredientes activos para que se cumpla la DL50 (dosis letal media) y pueda ser eliminado. Corroborando que el ingrediente activo BRODIFACOUM es el mas efectivo con un consumo minimo.',
      [],
      [
        'alignment' => Jc::BOTH,
        'lineHeight' => 1.15
      ]
    );

    $section->addImage(public_path('images/informe/Grafica-3.png'), [
      'width'  => 200,
      'height' => 100,
      'alignment' => Jc::CENTER,
    ]);

    // ************************************************************************************
    // GRAFICA: IMAGEN DESDE PUBLIC ***
    // ************************************************************************************    

    $section->addText(
      'La Grafica 3 muestra el % de consumo quincenal  de los tres segumientos mensuales en la planta de produccion VF y los Almacenes dos y eventos, a la fecha de evaluación esta merma es debido a causas medioambientales ya que no se tuvo reporte de presencia y/o captura de roedor. ',
      [],
      [
        'alignment' => Jc::BOTH,
        'lineHeight' => 1.15
      ]
    );



    // ************************************************************************************
    // GRAFICA: MONITOREO DE ROEDORES (X ALMACEN)
    // ************************************************************************************    


    // -------------------------------- xxxxxx (INICIO) SECCION NO AGREGADA EN INFORME xxxxxxxxxxxxx
    // [TABLA DE TRAMPAS]
    // Crear tabla
    $section->addTextBreak();
    $section->addText('Peso de trampas', ['bold' => true]);

    $table = $section->addTable('tablaInforme');

    $table->addRow();
    $table->addCell(2000)->addText('Trampa', ['bold' => true]);
    $table->addCell(2000)->addText('Inicial', ['bold' => true]);
    $table->addCell(2000)->addText('Merma', ['bold' => true]);
    $table->addCell(2000)->addText('Actual', ['bold' => true]);
    $table->addCell(3500)->addText('Observaciones', ['bold' => true]);

    foreach ($datosRoedores as $trampa => $data) {

      $table->addRow();
      $table->addCell(2000)->addText($trampa);
      $table->addCell(2000)->addText($data['inicial']);
      $table->addCell(2000)->addText($data['merma']);
      $table->addCell(2000)->addText($data['actual']);
      $table->addCell(3500)->addText($data['actual']);
    }

    // SEGUIMIENTO DE TRAMAPAS    

    if ($chart3) {
      // $section->addPageBreak();
      $section->addText('Comparación de pesos por trampa', ['bold' => true]);
      $section->addImage($chart3, ['width' => 300]);
    }

    if ($chart4) {
      // $section->addPageBreak();
      $section->addText('Valores por trampa', ['bold' => true]);
      $section->addImage($chart4, ['width' => 300]);
    }


    // -------------------------------- xxxxxx (FIN) SECCION NO AGREGADA EN INFORME xxxxxxxxxxxxx    

    // ---------------------SECCION: BARRERAS FISICAS DE EXCLUCION (INSECTOCUTORES) ----------------------------        
    $section->addText('BARRERAS FISICAS DE EXCLUCION (INSECTOCUTORES)', [
      'bold' => true,
      'size' => 11,
      'underline' => 'single',
    ]);

    $section->addText(
      'Para el control de insectos voladores se ha implementado tres insectocutores se realizó el seguimiento de cada uno de los insectocutores revisando el tipo de insecto encontrado y la cantidad, con esta información se ha podido calcular la incidencia y severidad se muestra a través de gráficos las tendencias y análisis respectivos',
      [],
      [
        'alignment' => Jc::BOTH,
        'lineHeight' => 1.15
      ]
    );

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

    $section->addText(
      'La incidencia es el número de individuos que están presentes en un determinado lugar la gráfica de incidencia muestra la presencia en estado adulto de los tres tipos de insectos que se ha logrado capturar que son mosca, mosquito y polillas en este estado no realizan daño directo sino tienen una actividad de colocar huevos para completar su metamorfosis.',
      [],
      [
        'alignment' => Jc::BOTH,
        'lineHeight' => 1.15
      ]
    );
    $section->addText(
      'Para realizar el calculo de la incidencia se toma en cuenta las cuatro visitas realizadas en los formularios de conformidad se saca el promedio de los 3 insectocutores por visita y se llena la tabla que se muestra a continuación.',
      [],
      [
        'alignment' => Jc::BOTH,
        'lineHeight' => 1.15
      ]
    );




    $section->addText('');

    if ($chart1) {
      $section->addTextBreak();
      $section->addText('Total insectos por especie');
      $section->addImage($chart1, ['width' => 300]);
    }

    // [TABLA DE INCIDENCIA]

    if ($chart2) {
      // $section->addPageBreak();
      $section->addText('INCIDENCIA DE INSECTOS VOLADORES');
      $section->addImage($chart2, ['width' => 300]);
    }

    // [TABLA DE SEVERIDAD]

    if ($chart2) {
      // $section->addPageBreak();
      $section->addText('SEVERIDAD DE INSECTOS VOLADORES');
      $section->addImage($chart2, ['width' => 300]);
    }

    $section->addText(
      'Los resultados de la severidad para el mes de enero y febrero muestran en promedio una concentración muy baja de moscas (1%) mosquitos (2%) y polilla (1%) porcentajes que para fines de análisis no se tomara en cuenta ya que no afectan a la producción de las bebidas en la planta.',
      [],
      [
        'alignment' => Jc::BOTH,
        'lineHeight' => 1.15
      ]
    );

    $section->addTextBreak();

    // ---------------------SECCION: ACTIVIDADES COMPLEMENTARIAS DE CONTROL ----------------------------        
    $section->addText('ACTIVIDADES COMPLEMENTARIAS DE CONTROL', [
      'bold' => true,
      'size' => 11,
      'underline' => 'single',
    ]);

    // [DESCRIPCION]
    // [IMAGENES]





    // ---------------------SECCION: RECOMENDACIONES PARA LA PROXIMA VISITA: ----------------------------        
    $this->pie($section, $request);

    $file = storage_path('app/informe.docx');
    if (!$file) {
      $file = storage_path('app\\informe.docx');
    }

    IOFactory::createWriter($phpWord, 'Word2007')->save($file);

    Log::info('SEGUNDA SECCION GGGGGG');
    return;

    return response()->json(['ok XXXX' => true]);
  }

  public function caratula($section, $request)
  {
    $header = $section->addHeader('first');

    $header->addImage(
      public_path('images/informe/membretado.png'),
      [
        'width' => 595,
        'height' => 842,

        'positioning' => 'absolute',

        'posHorizontal' => 'left',
        'posHorizontalRel' => 'page',
        'posHorizontalOffset' => 0,

        'posVertical' => 'top',
        'posVerticalRel' => 'page',
        'posVerticalOffset' => 0,

        'wrappingStyle' => 'behind'
      ]
    );

    $section->addText('La Paz ' . Carbon::now()->translatedFormat('d \d\e F \d\e Y'), [
      'name' => 'Calibri',
      'size' => 11,
      'lang' => 'es-ES'
    ]);
    $section->addText('CITE: ', [
      'bold' => true,
      'size' => 12,
      'underline' => 'single',
    ]);
    $section->addTextBreak(3);

    $section->addText('Señor:');
    $section->addText('___________________');
    $section->addText('Presente .-');
    $section->addTextBreak(4);

    $section->addText(
      'De mi mayor consideración:',
      [
        'name' => 'Calibri',
        'size' => 11,
        'lang' => 'es-ES'
      ]
    );
    $section->addText(
      'Adjunto al presente remito a usted el Informe técnico sobre el Control Integral de Plagas realizado en los almacenes _______________, valido por el mes de __________ desratización y fumigación.',
      [],
      [
        'alignment' => Jc::BOTH,
        'lineHeight' => 1.15
      ]
    );
    $section->addText(
      'Sin otro particular saludo a usted con las consideraciones más distinguidas de mi respeto personal.',
      [],
      [
        'alignment' => Jc::BOTH,
        'lineHeight' => 1.15
      ]
    );
    $section->addText('Atentamente');
    $section->addTextBreak(4);

    $section->addText(
      'Ing. Agr. Freddy Montero Castillo',
      ['size' => 10],
      [
        'alignment' => Jc::CENTER,
        'lineHeight' => 1,
        'spaceAfter' => 0
      ]
    );
    $section->addText(
      'GERENTE PROPIETARIO',
      ['size' => 10, 'bold' => true],
      [
        'alignment' => Jc::CENTER,
        'lineHeight' => 1,
        'spaceAfter' => 0
      ]
    );
    $section->addText(
      'BOLIVIAN PEST HIGIENE AMBIENTAL',
      ['size' => 10],
      [
        'alignment' => Jc::CENTER,
        'lineHeight' => 1,
        'spaceAfter' => 0
      ]
    );
    $section->addText(
      'Telf: 2240974, Cel: 76738282',
      ['size' => 10],
      [
        'alignment' => Jc::CENTER,
        'lineHeight' => 1,
        'spaceAfter' => 0
      ]
    );


    $section->addPageBreak();
  }

  public function pie($section, $request)
  {
    $section->addText('RECOMENDACIONES PARA LA PROXIMA VISITA:', [
      'bold' => true,
      'size' => 11,
      'underline' => 'single',
    ]);
    $section->addListItem(
      'La recomendación del orden y limpieza para el mantenimiento de los procesos de control de plagas es necesario recalcarlos para los encargados de los almacenes, estibadores y ayudantes de los almacenes.',
      0,
      [],
      null,
      [
        'alignment' => Jc::BOTH,
        'lineHeight' => 1.15,
        'spaceBefore' => 0,
        'spaceAfter' => 0
      ]
    );
    $section->addListItem(
      'Para mantener el efecto del trabajo realizado recomendamos tener cuidado con las unidades de control evitando golpes, y recojo de sustancias pegajosas.',
      0,
      [],
      null,
      [
        'alignment' => Jc::BOTH,
        'lineHeight' => 1.15,
        'spaceBefore' => 0,
        'spaceAfter' => 0
      ]
    );
    $section->addListItem(
      'En el ingreso de nueva mercadería a los almacenes verificando siempre la existencia de plagas que puedan alterar el control integral en el cual se está trabajando.',
      0,
      [],
      null,
      [
        'alignment' => Jc::BOTH,
        'lineHeight' => 1.15,
        'spaceBefore' => 0,
        'spaceAfter' => 0
      ]
    );
    $section->addListItem(
      'Mantener con protección los puntos de ingreso de personal y producto para evitar el ingreso de contaminantes al almacén.',
      0,
      [],
      null,
      [
        'alignment' => Jc::BOTH,
        'lineHeight' => 1.15,
        'spaceBefore' => 0,
        'spaceAfter' => 0
      ]
    );
    $section->addListItem(
      'Se debe tener cuidado de cerrar las puertas una vez ingresado el personal o la mercadería en el sentido que si se dejan abiertas cualquier ave puede ingresar y contaminar los productos que se resguardan',
      0,
      [],
      null,
      [
        'alignment' => Jc::BOTH,
        'lineHeight' => 1.15,
        'spaceBefore' => 0,
        'spaceAfter' => 0
      ]

    );
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
