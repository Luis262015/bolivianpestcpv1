<?php

namespace App\Http\Controllers;

use App\Models\Accion;
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
use PhpOffice\PhpWord\SimpleType\JcTable;
use PhpOffice\PhpWord\SimpleType\TblWidth;
use PhpOffice\PhpWord\Style\Language;
use PhpOffice\PhpWord\Style\Cell;


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
    $acciones = [];

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

      $acciones = Accion::with(['accionTrampas.trampa', 'imagenes'])
        ->where('almacen_id', $request->almacen_id)
        ->whereBetween('created_at', [
          $request->fecha_inicio . ' 00:00:00',
          $request->fecha_fin . ' 23:59:59',
        ])
        ->orderBy('created_at', 'asc')
        ->get();

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
      'acciones'     => $acciones,
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

  private function procesarDatosTrampas($seguimientos)
  {
    $agrupado = [];

    foreach ($seguimientos as $seguimiento) {
      foreach ($seguimiento->roedores as $rodente) {
        $trampa = $rodente->trampa;

        // Validar que existan las relaciones necesarias
        if (!$trampa || !$trampa->mapa || !$trampa->trampa_tipo) {
          continue;
        }

        // Clave única para agrupar por Mapa y Tipo de Trampa
        $key = "{$trampa->mapa->id}-{$trampa->trampa_tipo->id}";

        if (!isset($agrupado[$key])) {
          $agrupado[$key] = [
            'mapa_titulo'     => $trampa->mapa->titulo,
            'tipo_nombre'     => $trampa->trampa_tipo->nombre,
            'trampa_ids'      => [], // Para contar trampas únicas
            'cantidad_total'  => 0   // Para sumar roedores
          ];
        }

        // Agregamos el ID de la trampa (usaremos array_unique luego)
        $agrupado[$key]['trampa_ids'][] = $trampa->id;

        // Sumamos la cantidad de roedores
        $agrupado[$key]['cantidad_total'] += (int) $rodente->cantidad;
      }
    }

    // 2. Formatear el array final para el frontend
    return array_values(array_map(function ($item) {
      return [
        'cantidad_trampas' => count(array_unique($item['trampa_ids'])),
        'tipo_nombre'      => $item['tipo_nombre'],
        'cantidad'         => $item['cantidad_total'],
        'mapa_titulo'      => $item['mapa_titulo'],
      ];
    }, $agrupado));
  }

  private function procesarDatosReporte($seguimientos)
  {
    $agrupado = [];

    foreach ($seguimientos as $seguimiento) {
      foreach ($seguimiento->roedores as $rodente) {
        $trampa = $rodente->trampa;

        if (!$trampa || !$trampa->mapa) {
          continue;
        }

        // Clave única por Seguimiento + Mapa
        $key = "{$seguimiento->id}-{$trampa->mapa->id}";

        if (!isset($agrupado[$key])) {
          $agrupado[$key] = [
            'seguimiento_id'      => $seguimiento->id,
            'seguimiento_fecha'   => $seguimiento->created_at, // Ajusta al nombre real del campo
            'mapa_titulo'         => $trampa->mapa->titulo,
            'trampa_ids'          => [],
            'cantidad_total'      => 0,
            'inicial_total'       => 0,
            'merma_total'         => 0,
            'actual_total'        => 0,
          ];
        }

        $agrupado[$key]['trampa_ids'][] = $trampa->id;
        $agrupado[$key]['cantidad_total'] += (int) $rodente->cantidad;
        $agrupado[$key]['inicial_total'] += (int) $rodente->inicial;
        $agrupado[$key]['merma_total'] += (int) $rodente->merma;
        $agrupado[$key]['actual_total'] += (int) $rodente->actual;
      }
    }

    return array_values(array_map(function ($item) {
      $porcentajeMerma = $item['inicial_total'] > 0
        ? round(($item['merma_total'] / $item['inicial_total']) * 100, 2)
        : 0;

      return [
        'seguimiento_fecha' => $item['seguimiento_fecha'],
        'mapa_titulo'       => $item['mapa_titulo'],
        'cantidad_trampas'  => count(array_unique($item['trampa_ids'])),
        'cantidad'          => $item['cantidad_total'],
        'inicial'           => $item['inicial_total'],
        'merma'             => $item['merma_total'],
        'actual'            => $item['actual_total'],
        'porcentaje_merma'  => $porcentajeMerma,
      ];
    }, $agrupado));
  }

  private function procesarDatosPorMapa($seguimientos)
  {
    $agrupadoPorMapa = [];

    foreach ($seguimientos as $seguimiento) {
      foreach ($seguimiento->roedores as $rodente) {
        $trampa = $rodente->trampa;

        if (!$trampa || !$trampa->mapa) {
          continue;
        }

        $mapaTitulo = $trampa->mapa->titulo;

        // Clave única por Seguimiento + Mapa
        $key = "{$seguimiento->id}-{$trampa->mapa->id}";

        if (!isset($agrupadoPorMapa[$mapaTitulo][$key])) {
          $agrupadoPorMapa[$mapaTitulo][$key] = [
            'seguimiento_id'      => $seguimiento->id,
            'seguimiento_fecha'   => $seguimiento->created_at,
            'mapa_titulo'         => $mapaTitulo,
            'trampa_ids'          => [],
            'cantidad_total'      => 0,
            'inicial_total'       => 0,
            'merma_total'         => 0,
            'actual_total'        => 0,
          ];
        }

        $agrupadoPorMapa[$mapaTitulo][$key]['trampa_ids'][] = $trampa->id;
        $agrupadoPorMapa[$mapaTitulo][$key]['cantidad_total'] += (int) $rodente->cantidad;
        $agrupadoPorMapa[$mapaTitulo][$key]['inicial_total'] += (int) $rodente->inicial;
        $agrupadoPorMapa[$mapaTitulo][$key]['merma_total'] += (int) $rodente->merma;
        $agrupadoPorMapa[$mapaTitulo][$key]['actual_total'] += (int) $rodente->actual;
      }
    }

    // Transformar a estructura final
    $resultado = [];

    foreach ($agrupadoPorMapa as $mapaTitulo => $datos) {
      $filas = array_values(array_map(function ($item) {
        $porcentajeMerma = $item['inicial_total'] > 0
          ? round(($item['merma_total'] / $item['inicial_total']) * 100, 2)
          : 0;

        return [
          'seguimiento_fecha' => $item['seguimiento_fecha'],
          'mapa_titulo'       => $item['mapa_titulo'],
          'cantidad_trampas'  => count(array_unique($item['trampa_ids'])),
          'cantidad'          => $item['cantidad_total'],
          'inicial'           => $item['inicial_total'],
          'merma'             => $item['merma_total'],
          'actual'            => $item['actual_total'],
          'porcentaje_merma'  => $porcentajeMerma,
        ];
      }, $datos));

      // Calcular totales por mapa
      $totalesMapa = $this->calcularTotales($filas);

      $resultado[$mapaTitulo] = [
        'filas' => $filas,
        'totales' => $totalesMapa
      ];
    }

    return $resultado;
  }

  private function calcularTotales($filas)
  {
    $suma = array_reduce(
      $filas,
      function ($acc, $row) {
        return [
          'cantidad_trampas' => $acc['cantidad_trampas'] + $row['cantidad_trampas'],
          'cantidad' => $acc['cantidad'] + $row['cantidad'],
          'inicial' => $acc['inicial'] + $row['inicial'],
          'merma' => $acc['merma'] + $row['merma'],
          'actual' => $acc['actual'] + $row['actual'],
        ];
      },
      [
        'cantidad_trampas' => 0,
        'cantidad' => 0,
        'inicial' => 0,
        'merma' => 0,
        'actual' => 0
      ]
    );

    $suma['porcentaje_merma'] = $suma['inicial'] > 0
      ? round(($suma['merma'] / $suma['inicial']) * 100, 2)
      : 0;

    return $suma;
  }

  private function configurarEstilos($phpWord)
  {
    // Estilo para título principal
    $phpWord->addTitleStyle(1, [
      'size' => 20,
      'bold' => true,
      'color' => '1F4E78',
      'name' => 'Arial',
    ]);

    // Estilo para título de mapa
    $phpWord->addTitleStyle(2, [
      'size' => 14,
      'bold' => true,
      'color' => '2E5C8A',
      'name' => 'Arial',
    ]);

    // Estilo para tabla
    $phpWord->addTableStyle('tabla_reporte', [
      'borderSize' => 6,
      'borderColor' => '999999',
      'cellMargin' => 80,
      'bgColor' => 'FFFFFF',
    ]);

    // Estilo para celda de encabezado
    $phpWord->addCellStyle('celda_encabezado', [
      'borderSize' => 6,
      'borderColor' => '1F4E78',
      'bgColor' => '1F4E78',
      'valign' => 'center',
    ]);

    // Estilo para celda normal
    $phpWord->addCellStyle('celda_normal', [
      'borderSize' => 6,
      'borderColor' => '999999',
      'valign' => 'center',
    ]);

    // Estilo para celda de totales
    $phpWord->addCellStyle('celda_totales', [
      'borderSize' => 6,
      'borderColor' => '1F4E78',
      'bgColor' => 'D6EAF8',
      'valign' => 'center',
    ]);

    // Estilo de fuente para encabezado
    $phpWord->addFontStyle('fuente_encabezado', [
      'size' => 10,
      'bold' => true,
      'color' => 'FFFFFF',
      'name' => 'Arial',
    ]);

    // Estilo de fuente para celda normal
    $phpWord->addFontStyle('fuente_normal', [
      'size' => 10,
      'color' => '000000',
      'name' => 'Arial',
    ]);

    // Estilo de fuente para totales
    $phpWord->addFontStyle('fuente_totales', [
      'size' => 10,
      'bold' => true,
      'color' => '1F4E78',
      'name' => 'Arial',
    ]);
  }

  private function agregarTablaPorMapa($section, $mapaTitulo, $datos, $phpWord)
  {
    $filas = $datos['filas'];
    $totales = $datos['totales'];

    // Título del mapa
    // $section->addText(
    //   '📍 ' . strtoupper($mapaTitulo),
    //   ['size' => 14, 'bold' => true, 'color' => '2E5C8A', 'name' => 'Arial', 'spaceBefore' => 200, 'spaceAfter' => 100]
    // );

    $section->addText(
      strtoupper($mapaTitulo),
      ['size' => 12, 'bold' => true]
    );

    $phpWord->addTableStyle('tabla_reporte', [
      'borderSize' => 6,          // grosor borde
      'borderColor' => '000000',  // color borde negro
      'cellMargin' => 80,         // espacio interno
      'alignment' => JcTable::CENTER,
      // 'width' => 100 * 50,        // 100%
      'unit' => TblWidth::PERCENT,
    ], [
      'bgColor' => 'D9D9D9',      // fondo encabezado
    ]);

    // Crear tabla
    $table = $section->addTable('tabla_reporte');

    // Encabezados de la tabla
    $table->addRow(400);
    $headers = [
      'Fecha Seguimiento' => 2000,
      '# Trampas' => 1000,
      'Cantidad' => 1000,
      'Inicial' => 1000,
      'Merma' => 1000,
      'Actual' => 1000,
      '% Merma' => 1000,
    ];

    foreach ($headers as $header => $width) {
      $table->addCell($width, ['celda_encabezado'])
        ->addText($header, ['fuente_encabezado'], ['align' => 'center']);
    }

    // Filas de datos
    if (count($filas) > 0) {
      foreach ($filas as $fila) {
        $table->addRow(400);

        // Fecha
        $fecha = date('d/m/Y', strtotime($fila['seguimiento_fecha']));
        $table->addCell(2000, ['celda_normal'])
          ->addText($fecha, ['fuente_normal'], ['align' => 'center']);

        // Cantidad Trampas
        $table->addCell(1200, ['celda_normal'])
          ->addText($fila['cantidad_trampas'], ['fuente_normal'], ['align' => 'center']);

        // Cantidad
        $table->addCell(1200, ['celda_normal'])
          ->addText($fila['cantidad'], ['fuente_normal'], ['align' => 'center']);

        // Inicial
        $table->addCell(1200, ['celda_normal'])
          ->addText($fila['inicial'], ['fuente_normal'], ['align' => 'center']);

        // Merma
        $table->addCell(1200, ['celda_normal'])
          ->addText($fila['merma'], ['fuente_normal'], ['align' => 'center']);

        // Actual
        $table->addCell(1200, ['celda_normal'])
          ->addText($fila['actual'], ['fuente_normal'], ['align' => 'center']);

        // % Merma
        $table->addCell(1200, ['celda_normal'])
          ->addText(number_format($fila['porcentaje_merma'], 2) . '%', ['fuente_normal'], ['align' => 'center']);
      }

      // Fila de totales por mapa
      $table->addRow(400);
      $table->addCell(2000, ['celda_totales'])
        ->addText('TOTALES MAPA', ['fuente_totales'], ['align' => 'center']);
      $table->addCell(1200, ['celda_totales'])
        ->addText($totales['cantidad_trampas'], ['fuente_totales'], ['align' => 'center']);
      $table->addCell(1200, ['celda_totales'])
        ->addText($totales['cantidad'], ['fuente_totales'], ['align' => 'center']);
      $table->addCell(1200, ['celda_totales'])
        ->addText($totales['inicial'], ['fuente_totales'], ['align' => 'center']);
      $table->addCell(1200, ['celda_totales'])
        ->addText($totales['merma'], ['fuente_totales'], ['align' => 'center']);
      $table->addCell(1200, ['celda_totales'])
        ->addText($totales['actual'], ['fuente_totales'], ['align' => 'center']);
      $table->addCell(1200, ['celda_totales'])
        ->addText(number_format($totales['porcentaje_merma'], 2) . '%', ['fuente_totales'], ['align' => 'center']);
    } else {
      $table->addRow(400);
      $table->addCell(9200, ['celda_normal'])
        ->addText('No hay datos disponibles para este mapa', ['fuente_normal', 'italic' => true, 'color' => '999999'], ['align' => 'center']);
    }

    $section->addTextBreak(1);
  }

  // private function procesarDatosInsectocutores($seguimientos)
  // {
  //   $agrupadoPorMapa = [];

  //   foreach ($seguimientos as $seguimiento) {
  //     foreach ($seguimiento->insectocutores as $insectocutor) {
  //       $trampa = $insectocutor->trampa;

  //       // Validar que exista la trampa y el mapa
  //       if (!$trampa || !$trampa->mapa) {
  //         continue;
  //       }

  //       $mapaTitulo = $trampa->mapa->titulo;
  //       $mapaId = $trampa->mapa->id;

  //       // Clave única por mapa
  //       $key = $mapaId;

  //       if (!isset($agrupadoPorMapa[$key])) {
  //         $agrupadoPorMapa[$key] = [
  //           'mapa_id'    => $mapaId,
  //           'mapa_titulo' => $mapaTitulo,
  //           'cantidad_total' => 0,
  //         ];
  //       }

  //       // Sumar cantidad de insectocutores
  //       $agrupadoPorMapa[$key]['cantidad_total'] += (int) $insectocutor->cantidad;
  //     }
  //   }

  //   // Transformar a array indexado y ordenar por mapa
  //   $filas = array_values($agrupadoPorMapa);

  //   // Ordenar por título de mapa (opcional)
  //   usort($filas, function ($a, $b) {
  //     return strcmp($a['mapa_titulo'], $b['mapa_titulo']);
  //   });

  //   // Agregar número de fila (NRO)
  //   return array_map(function ($fila, $index) {
  //     return [
  //       'nro'                => $index + 1,
  //       'mapa_titulo'        => $fila['mapa_titulo'],
  //       'cantidad_insectocutores' => $fila['cantidad_total'],
  //     ];
  //   }, $filas, array_keys($filas));
  // }

  private function procesarDatosInsectocutores($seguimientos)
  {
    $agrupadoPorMapa = [];

    foreach ($seguimientos as $seguimiento) {
      foreach ($seguimiento->insectocutores as $insectocutor) {
        $trampa = $insectocutor->trampa;

        if (!$trampa || !$trampa->mapa) {
          continue;
        }

        $mapaTitulo = $trampa->mapa->titulo;
        $mapaId = $trampa->mapa->id;
        $key = $mapaId;

        if (!isset($agrupadoPorMapa[$key])) {
          $agrupadoPorMapa[$key] = [
            'mapa_id'         => $mapaId,
            'mapa_titulo'     => $mapaTitulo,
            'trampa_ids'      => [],
            'cantidad_total'  => 0,
          ];
        }

        // Guardar ID de trampa para contar únicas
        $agrupadoPorMapa[$key]['trampa_ids'][] = $trampa->id;

        // Sumar cantidad de insectocutores
        $agrupadoPorMapa[$key]['cantidad_total'] += (int) $insectocutor->cantidad;
      }
    }

    $filas = array_values($agrupadoPorMapa);

    usort($filas, function ($a, $b) {
      return strcmp($a['mapa_titulo'], $b['mapa_titulo']);
    });

    return array_map(function ($fila, $index) {
      return [
        'nro'                     => $index + 1,
        'mapa_titulo'             => $fila['mapa_titulo'],
        'cantidad_trampa_id'      => count(array_unique($fila['trampa_ids'])),
        'cantidad_insectocutores' => $fila['cantidad_total'],
      ];
    }, $filas, array_keys($filas));
  }

  public function storeWord(Request $request)
  {

    // dd($request);
    // return;

    $acciones = Accion::with(['accionTrampas.trampa', 'imagenes'])
      ->where('almacen_id', $request->almacen_id)
      ->whereBetween('created_at', [
        $request->fecha_inicio . ' 00:00:00',
        $request->fecha_fin . ' 23:59:59',
      ])
      ->orderBy('created_at', 'asc')
      ->get();

    // dd($acciones);
    // return;


    $seguimientos = Seguimiento::with([
      'almacen',
      'insectocutores.especie',
      'insectocutores.trampa.mapa',
      'roedores.trampa.mapa',
      'roedores.trampa.trampa_tipo',
      'images',
      'tipoSeguimiento'
    ])->whereIn('id', $request->seguimiento_ids)->get();



    // dd($seguimientos[8]);
    // return;

    // 1. Procesamiento de datos para la tabla
    $datosTabla = $this->procesarDatosTrampas($seguimientos);
    // Log::info($datosTabla);
    // return;

    $datosTablaX1 = $this->procesarDatosReporte($seguimientos);
    // Log::info($datosTablaX1);
    // return;

    $datosPorMapa = $this->procesarDatosPorMapa($seguimientos);
    // Log::info("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
    // Log::info(count($datosPorMapa));
    // foreach ($datosPorMapa as $dato) {
    //   Log::info(($dato['filas']));
    // }
    // Log::info("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
    // return;

    $datosTablaX2 = $this->procesarDatosInsectocutores($seguimientos);


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
        'alignment' => JcTable::CENTER,
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
    $section->addText('CONTROL INTEGRAL DE PLAGAS', [
      'bold' => true,
      'size' => 11,
      'underline' => 'single',
    ], [
      'alignment' => Jc::CENTER,
      'lineHeight' => 1,
    ]);
    $section->addText('"_________"', [
      'bold' => true,
      'size' => 11,
      'underline' => 'single',
    ], [
      'alignment' => Jc::CENTER,
      'lineHeight' => 1,
    ]);
    $section->addTextBreak();

    // ---------------------SECCION: INTRODUCCION ----------------------------
    $section->addText('INTRODUCCIÓN:', [
      'bold' => true,
      'size' => 11,
      'underline' => 'single',
    ]);
    $section->addTextBreak();

    $section->addText(
      'Las Buenas Prácticas de Almacenamiento BPAS son una herramienta básica para la obtención de productos seguros para el consumo y se focaliza en la higiene y en cómo se deben manipular estos siendo su aplicación obligatoria.',
      [],
      [
        'alignment' => Jc::BOTH,
        'lineHeight' => 1.15
      ]
    );
    $section->addTextBreak();

    $section->addText(
      'La importancia de controlar las plagas radica en las pérdidas que estas ocasionan a través de mercaderías arruinadas, alimentos contaminados, potenciales demandas, productos mal utilizados para el control, daños a estructuras físicas de la empresa, pérdida de imagen, etc. ',
      [],
      [
        'alignment' => Jc::BOTH,
        'lineHeight' => 1.15
      ]
    );
    $section->addTextBreak();

    $section->addText(
      'Dando cumplimiento al CONTROL DE PLAGAS para esta gestión que se realiza a la empresa “____________________” pasamos a desglosar las actividades alcanzadas para el mes de ___________ en lo que se refiere al almacén de productos.',
      [],
      [
        'alignment' => Jc::BOTH,
        'lineHeight' => 1.15
      ]
    );
    $section->addTextBreak();

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
    $section->addTextBreak();

    $section->addText('METODOLOGIA:', [
      'bold' => true,
      'size' => 11,
      'underline' => 'single',
    ]);
    $section->addTextBreak();
    $section->addText('Respecto al trabajo realizado se tomará en cuenta tres etapas:');
    $section->addTextBreak();
    $section->addListItem('Lo que se realizó el presente mes');
    $section->addListItem('El balance análisis.');
    $section->addListItem('Las recomendaciones para el próximo mes.');
    $section->addTextBreak();

    // ---------------------SECCION: LO QUE SE REALIZO EN LA VISITA ----------------------------

    $section->addText('LO QUE SE REALIZO EN LA VISITA', [
      'bold' => true,
      'size' => 11,
      'underline' => 'single',
    ]);
    $section->addTextBreak();

    // ---------------------SUBSECCION: DESRATIZACION ----------------------------

    $section->addText('1) DESRATIZACIÓN', [
      'bold' => true,
      'size' => 11,
      'underline' => 'single',
    ]);

    // ************************************************************************************
    // FOTOS DE VISITAS POR SEGUIMIENTO ***********************************************
    // ************************************************************************************

    if ($seguimientos) {
      foreach ($seguimientos as $value) {
        if ($value->tipo_seguimiento_id == 1) {
          $section->addText('Seguimiento ' . $value->created_at, [
            'bold' => true,
            'size' => 11,
            'underline' => 'single',
          ]);

          // if ($value->images) {
          //   foreach ($value->images as $v) {

          //     $section->addImage(public_path($v->imagen), [
          //       'width'  => 200,
          //       'height' => 100,
          //       'alignment' => Jc::CENTER,
          //     ]);
          //   }
          // }
          if ($value->images) {
            foreach ($value->images as $v) {
              $imagePath = public_path($v->imagen);

              if (!empty($v->imagen) && file_exists($imagePath) && is_file($imagePath)) {
                try {
                  $section->addImage($imagePath, [
                    'width' => 200,
                    'height' => 100,
                    'alignment' => Jc::CENTER,
                  ]);
                } catch (\Exception $e) {
                  Log::warning('No se pudo agregar la imagen al documento', [
                    'path' => $imagePath,
                    'error' => $e->getMessage(),
                  ]);
                }
              }
            }
          }
        }
      }
    }

    // ************************************************************************************
    // TABLA CANTIDAD DE TRAMPAS x TIPO y CANTIDAD DE ROEDORES CAPTURADOS *****************
    // ************************************************************************************
    $phpWord->addTableStyle('tablaCantidadDeTrampasPorTipo', [
      'borderSize' => 6,          // grosor borde
      'borderColor' => '000000',  // color borde negro
      'cellMargin' => 80,         // espacio interno
      'alignment' => JcTable::CENTER,
      // 'width' => 100 * 50,        // 100%
      'unit' => TblWidth::PERCENT,
    ], [
      'bgColor' => 'D9D9D9',      // fondo encabezado
    ]);

    $table = $section->addTable('tablaCantidadDeTrampasPorTipo');
    $table->addRow();
    $table->addCell()->addText('TIPOS DE TRAMPAS', ['bold' => true]);
    $table->addCell()->addText('CANTIDAD', ['bold' => true]);
    $table->addCell()->addText('CAPTURA', ['bold' => true]);

    $table->addCell()->addText('AREA', ['bold' => true]);
    $table->addCell()->addText('OBSERV.', ['bold' => true]);

    if ($datosTabla) {
      foreach ($datosTabla as $dato) {
        $table->addRow();
        $table->addCell()->addText($dato['tipo_nombre']); // Tipo de trampa
        $table->addCell()->addText($dato['cantidad_trampas']); // Cantidad
        $table->addCell()->addText($dato['cantidad']); // Capturados
        $table->addCell()->addText($dato['mapa_titulo']); // Mapa titulo        
        $table->addCell()->addText(''); // Observaciones
      }
    }


    $section->addTextBreak();

    $section->addText(
      'Los rodenticidas utilizados para el trabajo son  en presentación de pellets  y bloques parafinados de acuerdo a la ubicación de las trampas sea exterior o interior se coloca el respectivo rodenticida esto esta en función tambien del nivel de riesgo de la presencia de plaga.',
      [],
      [
        'alignment' => Jc::BOTH,
        'lineHeight' => 1.15
      ]
    );

    $phpWord->addTableStyle('tablaCebo', [
      'borderSize' => 6,          // grosor borde
      'borderColor' => '000000',  // color borde negro
      'cellMargin' => 80,         // espacio interno
      'alignment' => JcTable::CENTER,
      // 'width' => 100 * 50,        // 100%
      'unit' => TblWidth::PERCENT,
    ], [
      'bgColor' => 'D9D9D9',      // fondo encabezado
    ]);

    $table = $section->addTable('tablaCebo');

    $table->addRow();
    $table->addCell(2000)->addText('NOMBRE COMERCIAL', ['bold' => true]);
    $table->addCell(2000)->addText('INGREDIENTE ACTIVO', ['bold' => true]);
    $table->addCell(2000)->addText('COMPOSICION', ['bold' => true]);
    $table->addCell(2000)->addText('CLASE', ['bold' => true]);

    $table->addRow();
    $table->addCell(2000)->addText('RODENTICIDA KLERAT');
    $table->addCell(2000)->addText('BRODIFACOUM (3-3-4 bromo 1-1 bifenil-4-il-1-2-3-4 tetrahidro1-naftalenil-4 hidrocumarina)');
    $table->addCell(2000)->addText('Rodenticida Monosodico de Actividad Prolongada Cebo en Granos.');
    $table->addCell(2000)->addText('CLARODENTICIDA RATICIDA MONOSODICOSE');

    $table->addRow();
    $table->addCell(2000)->addText('GRUPO QUIMICO', ['bold' => true]);
    $table->addCell(2000)->addText('TIPO FORMULACION', ['bold' => true]);
    $table->addCell(2000)->addText('NUMERO DE REGISTRO', ['bold' => true]);
    $table->addCell(2000)->addText('PRESENTACION', ['bold' => true]);

    $table->addRow();
    $table->addCell(2000)->addText('BRODIFACOUM   WARFARINICO');
    $table->addCell(2000)->addText('CEBO EN PELLETS');
    $table->addCell(2000)->addText('INSO NRO. BR1020ROAB01');
    $table->addCell(2000)->addText('IMG');

    $section->addTextBreak();

    $phpWord->addTableStyle('tablaBloques', [
      'borderSize' => 6,          // grosor borde
      'borderColor' => '000000',  // color borde negro
      'cellMargin' => 80,         // espacio interno
      'alignment' => JcTable::CENTER,
      // 'width' => 100 * 50,        // 100%
      'unit' => TblWidth::PERCENT,
    ], [
      'bgColor' => 'D9D9D9',      // fondo encabezado
    ]);

    $table = $section->addTable('tablaBloques');

    $table->addRow();
    $table->addCell(2000)->addText('NOMBRE COMERCIAL', ['bold' => true]);
    $table->addCell(2000)->addText('INGREDIENTE ACTIVO', ['bold' => true]);
    $table->addCell(2000)->addText('COMPOSICION', ['bold' => true]);
    $table->addCell(2000)->addText('CLASE', ['bold' => true]);

    $table->addRow();
    $table->addCell(2000)->addText('RODENTICIDA KLERAT');
    $table->addCell(2000)->addText('BRODIFACOUM');
    $table->addCell(2000)->addText('Brodifacoum……0.05g Beozoato de denatonium …..0.01 g Excipientes c.s. 1kg Cebo en Granos.');
    $table->addCell(2000)->addText('RODENTICIDA RATICIDA MONOSODICO');
    $table->addRow();

    $table->addCell(2000)->addText('GRUPO QUIMICO', ['bold' => true]);
    $table->addCell(2000)->addText('TIPO FORMULACION', ['bold' => true]);
    $table->addCell(2000)->addText('NUMERO DE REGISTRO', ['bold' => true]);
    $table->addCell(2000)->addText('PRESENTACION', ['bold' => true]);
    $table->addRow();

    $table->addCell(2000)->addText('BRODIFACOUM   WARFARINICO');
    $table->addCell(2000)->addText('BLOQUES PARAFINICOS');
    $table->addCell(2000)->addText('INSO NRO. BRO913ROBB01');
    $table->addCell(2000)->addText('IMG');

    $section->addTextBreak();
    $section->addTextBreak();

    // ---------------------SUBSECCION: SEGUIMIENTO DE LAS UNIDADES DE CONTROL ----------------------------
    $section->addText('2) SEGUIMIENTO DE LAS UNIDADES DE CONTROL', [
      'bold' => true,
      'size' => 11,
      'underline' => 'single',
    ]);
    $section->addTextBreak();
    $section->addText(
      'Se realizaron tres seguimientos al sistema de control de roedores ________ según cronograma de actividades.',
      [],
      [
        'alignment' => Jc::BOTH,
        'lineHeight' => 1.15
      ]
    );
    $section->addTextBreak();

    // ************************************************************************************
    // TABLA FECHAS DE SEGUIMIENTOS *****************
    // ************************************************************************************

    $phpWord->addTableStyle('tablaFechaSeguimientos', [
      'borderSize' => 6,          // grosor borde
      'borderColor' => '000000',  // color borde negro
      'cellMargin' => 80,         // espacio interno
      'alignment' => JcTable::CENTER,
      // 'width' => 100 * 50,        // 100%
      'unit' => TblWidth::PERCENT,
    ], [
      'bgColor' => 'D9D9D9',      // fondo encabezado
    ]);

    $section->addText('TABLA: Cronograma de actividades', [
      'bold' => true,
      'size' => 11,
      'underline' => 'single',
    ]);

    $section->addTextBreak();

    $table = $section->addTable('tablaFechaSeguimientos');
    $table->addRow();
    // $table->addCell()->addText("FECHA SEGUIMIENTO", ['bold' => true]);
    // $table->addCell()->addText("TIPO SEGUIMIENTO", ['bold' => true]);
    $table->addCell(5000, ['valign' => 'center'])->addText(
      "FECHA SEGUIMIENTO",
      ['bold' => true],
      ['alignment' => 'center']
    );

    $table->addCell(5000, ['valign' => 'center'])->addText(
      "TIPO SEGUIMIENTO",
      ['bold' => true],
      ['alignment' => 'center']
    );

    // foreach ($seguimientos as $seg) {
    //   $table->addRow();
    //   $table->addCell()->addText($seg->created_at); // fecha
    //   $table->addCell()->addText($seg->tipoSeguimiento->nombre); // tipo      
    // }
    foreach ($seguimientos as $seg) {
      $table->addRow();

      $table->addCell(5000)->addText(
        Carbon::parse($seg->created_at)->format('d/m/Y H:i')
      );

      $table->addCell(5000)->addText(
        $seg->tipoSeguimiento->nombre ?? ''
      );
    }
    $section->addTextBreak();
    $section->addTextBreak();


    $phpWord->addTableStyle('tablaResumenGlobal', [
      'borderSize' => 6,          // grosor borde
      'borderColor' => '000000',  // color borde negro
      'cellMargin' => 80,         // espacio interno
      'alignment' => JcTable::CENTER,
      // 'width' => 100 * 50,        // 100%
      'unit' => TblWidth::PERCENT,
    ], [
      'bgColor' => 'D9D9D9',      // fondo encabezado
    ]);

    $table = $section->addTable('tablaResumenGlobal');
    $table->addRow();
    $table->addCell()->addText("SEGUIMIENTO", ['bold' => true]);
    $table->addCell()->addText("MAPA", ['bold' => true]);
    $table->addCell()->addText("TRAMPAS", ['bold' => true]);
    $table->addCell()->addText("CAPTURADOS", ['bold' => true]);
    foreach ($datosTablaX1 as $dato) {
      $table->addRow();
      $table->addCell()->addText($dato['seguimiento_fecha']);
      $table->addCell()->addText($dato['mapa_titulo']);
      $table->addCell()->addText($dato['cantidad_trampas']);
      $table->addCell()->addText($dato['cantidad']);
    }

    $section->addTextBreak();
    $section->addTextBreak();




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

    // Tablas por Mapa
    foreach ($datosPorMapa as $mapaTitulo => $datos) {
      $this->agregarTablaPorMapa($section, $mapaTitulo, $datos, $phpWord);
    }

    $section->addText(
      'Analizando las tablas de pesos respecto al porcentaje de merma se establece que este no pasa del 5% con relación al Peso Total 100% lo que significa que no ha existido consumo por parte de roedores ni su presencia en las fechas evaluadas. Este porcentaje esta relacionado con perdidas por medio ambiente vale decir condiciones de humedad, temperatura, vientos lluvia, etc. que afectan a los cebos colocados.',
      [],
      [
        'alignment' => Jc::BOTH,
        'lineHeight' => 1.15
      ]
    );

    $section->addTextBreak();

    $section->addText(
      'La Grafica 1 muestra la DL50 (dosis letal media) de los ingredientes activos de los rodenticidas mostrando que brodifacoum es el ingrediente mas efectivo ya que su porcentaje tanto para rata y raton es el mas bajo por lo tanto mas toxico necesitando menor consumo para ser mas efectivo.',
      [],
      [
        'alignment' => Jc::BOTH,
        'lineHeight' => 1.15
      ]
    );

    $section->addTextBreak();

    $section->addImage(public_path('images/informe/Tabla-DL50.png'), [
      'width'  => 300,
      // 'height' => 100,
      'alignment' => Jc::CENTER,
    ]);

    $section->addTextBreak();

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
      // 'height' => 100,
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

    // Función helper para agregar imagen base64
    // $agregarImagen = function ($section, $base64) {
    //   if (!$base64) return;

    //   // Quitar el prefijo data:image/png;base64,
    //   $base64 = preg_replace('/^data:image\/\w+;base64,/', '', $base64);

    //   // Guardar como archivo temporal
    //   $tmpFile = tempnam(sys_get_temp_dir(), 'chart_') . '.png';
    //   file_put_contents($tmpFile, base64_decode($base64));

    //   // Agregar al documento
    //   $section->addImage($tmpFile, [
    //     'width'  => 600,
    //     'height' => 300,
    //     'alignment' => Jc::CENTER,
    //   ]);

    //   // Eliminar archivo temporal
    //   unlink($tmpFile);
    // };

    $section->addTextBreak();

    $chartsPorMapa   = $request->charts_por_mapa ?? [];
    $titulosPorMapa  = $request->charts_por_mapa_titulos ?? [];

    foreach ($chartsPorMapa as $index => $chartBase64) {
      // Agregar título del mapa      

      $titulo = $titulosPorMapa[$index] ?? "Mapa " . ($index + 1);
      $section->addTitle($titulo, 2);
      $section->addTextBreak(1);

      // Agregar imagen
      // $agregarImagen($section, $chartBase64);
      $graf = $this->saveBase64Image($chartBase64, 'chartX_' . $index);
      $section->addImage($graf, [
        'width'  => 300,
        // 'height' => 300,
        'alignment' => Jc::CENTER,
      ]);

      $section->addTextBreak(1);
    }


    // ************************************************************************************
    // GRAFICA: MONITOREO DE ROEDORES (X ALMACEN)
    // ************************************************************************************    


    // -------------------------------- xxxxxx (INICIO) SECCION NO AGREGADA EN INFORME xxxxxxxxxxxxx
    // [TABLA DE TRAMPAS]
    // Crear tabla
    $section->addTextBreak();
    // $section->addText('Peso de trampas', ['bold' => true]);

    // $table = $section->addTable('tablaInforme');

    // $table->addRow();
    // $table->addCell(2000)->addText('Trampa', ['bold' => true]);
    // $table->addCell(2000)->addText('Inicial', ['bold' => true]);
    // $table->addCell(2000)->addText('Merma', ['bold' => true]);
    // $table->addCell(2000)->addText('Actual', ['bold' => true]);
    // $table->addCell(3500)->addText('Observaciones', ['bold' => true]);

    // foreach ($datosRoedores as $trampa => $data) {

    //   $table->addRow();
    //   $table->addCell(2000)->addText($trampa);
    //   $table->addCell(2000)->addText($data['inicial']);
    //   $table->addCell(2000)->addText($data['merma']);
    //   $table->addCell(2000)->addText($data['actual']);
    //   $table->addCell(3500)->addText($data['actual']);
    // }

    // SEGUIMIENTO DE TRAMAPAS    

    // if ($chart3) {
    //   // $section->addPageBreak();
    //   $section->addText('Comparación de pesos por trampa', ['bold' => true]);
    //   $section->addImage($chart3, ['width' => 300]);
    // }

    // if ($chart4) {
    //   // $section->addPageBreak();
    //   $section->addText('Valores por trampa', ['bold' => true]);
    //   $section->addImage($chart4, ['width' => 300]);
    // }


    // -------------------------------- xxxxxx (FIN) SECCION NO AGREGADA EN INFORME xxxxxxxxxxxxx    

    // ---------------------SECCION: BARRERAS FISICAS DE EXCLUCION (INSECTOCUTORES) ----------------------------        
    $section->addText('3) BARRERAS FISICAS DE EXCLUCION (INSECTOCUTORES)', [
      'bold' => true,
      'size' => 11,
      'underline' => 'single',
    ]);

    $section->addTextBreak();

    $section->addText(
      'Para el control de insectos voladores se ha implementado tres insectocutores se realizó el seguimiento de cada uno de los insectocutores revisando el tipo de insecto encontrado y la cantidad, con esta información se ha podido calcular la incidencia y severidad se muestra a través de gráficos las tendencias y análisis respectivos',
      [],
      [
        'alignment' => Jc::BOTH,
        'lineHeight' => 1.15
      ]
    );

    $section->addTextBreak();

    $section->addText('TABLA: CANTIDAD DE INSECTOCUTORES', [
      'bold' => true,
      'size' => 11,
      'underline' => 'single',
    ]);

    $section->addTextBreak();

    // Encabezado
    // $section->addText(
    //   'REPORTE DE INSECTOCUTORES POR MAPA',
    //   ['size' => 20, 'bold' => true, 'color' => '1F4E78', 'name' => 'Arial', 'align' => 'center']
    // );

    // $section->addText(
    //   'Fecha de Generación: ' . date('d/m/Y H:i:s'),
    //   ['size' => 11, 'color' => '666666', 'name' => 'Arial', 'align' => 'center', 'spaceAfter' => 200]
    // );

    $phpWord->addTableStyle('tabla_reporte', [
      'borderSize' => 6,          // grosor borde
      'borderColor' => '000000',  // color borde negro
      'cellMargin' => 80,         // espacio interno
      'alignment' => JcTable::CENTER,
      // 'width' => 100 * 50,        // 100%
      'unit' => TblWidth::PERCENT,
    ], [
      'bgColor' => 'D9D9D9',      // fondo encabezado
    ]);

    // Tabla
    $table = $section->addTable('tabla_reporte');

    // Encabezados (4 columnas ahora)
    $table->addRow(400);
    $headers = [
      'NRO' => 800,
      'MAPA TÍTULO' => 3500,
      'CANTIDAD TRAMPA ID' => 1500,
      'CANTIDAD INSECTOCUTORES' => 2000
    ];

    foreach ($headers as $header => $width) {
      $table->addCell($width, ['celda_encabezado'])
        ->addText($header, ['fuente_encabezado'], ['align' => 'center']);
    }

    // Filas de datos
    $totalTrampas = 0;
    $totalInsectocutores = 0;

    foreach ($datosTablaX2 as $fila) {
      $table->addRow(400);

      // NRO
      $table->addCell(800, ['celda_normal'])
        ->addText($fila['nro'], ['fuente_normal'], ['align' => 'center']);

      // MAPA TÍTULO
      $table->addCell(3500, ['celda_normal'])
        ->addText($fila['mapa_titulo'], ['fuente_normal']);

      // CANTIDAD TRAMPA ID
      $table->addCell(1500, ['celda_normal'])
        ->addText($fila['cantidad_trampa_id'], ['fuente_normal'], ['align' => 'center']);

      // CANTIDAD INSECTOCUTORES
      $table->addCell(2000, ['celda_normal'])
        ->addText($fila['cantidad_insectocutores'], ['fuente_normal'], ['align' => 'center']);

      $totalTrampas += $fila['cantidad_trampa_id'];
      $totalInsectocutores += $fila['cantidad_insectocutores'];
    }

    // Fila de totales
    $table->addRow(400);
    $table->addCell(800, ['celda_totales'])
      ->addText('-', ['fuente_totales'], ['align' => 'center']);
    $table->addCell(3500, ['celda_totales'])
      ->addText('TOTAL GENERAL', ['fuente_totales']);
    $table->addCell(1500, ['celda_totales'])
      ->addText($totalTrampas, ['fuente_totales'], ['align' => 'center']);
    $table->addCell(2000, ['celda_totales'])
      ->addText($totalInsectocutores, ['fuente_totales'], ['align' => 'center']);

    // Encabezado
    // $section->addText(
    //   'REPORTE DE INSECTOCUTORES POR MAPA',
    //   ['size' => 20, 'bold' => true, 'color' => '1F4E78', 'name' => 'Arial', 'align' => 'center']
    // );

    // $section->addText(
    //   'Fecha de Generación: ' . date('d/m/Y H:i:s'),
    //   ['size' => 11, 'color' => '666666', 'name' => 'Arial', 'align' => 'center', 'spaceAfter' => 200]
    // );

    // $section->addTextBreak(1);

    // // Tabla
    // $table = $section->addTable('tabla_reporte');

    // // Encabezados
    // $table->addRow(400);
    // $headers = ['NRO', 'MAPA TÍTULO', 'CANTIDAD INSECTOCUTORES'];
    // $widths = [800, 4000, 2000];

    // foreach ($headers as $index => $header) {
    //   $table->addCell($widths[$index], ['celda_encabezado'])
    //     ->addText($header, ['fuente_encabezado'], ['align' => 'center']);
    // }

    // // Filas de datos
    // $totalGeneral = 0;
    // foreach ($datosTablaX2 as $fila) {
    //   $table->addRow(400);

    //   $table->addCell(800, ['celda_normal'])
    //     ->addText($fila['nro'], ['fuente_normal'], ['align' => 'center']);

    //   $table->addCell(4000, ['celda_normal'])
    //     ->addText($fila['mapa_titulo'], ['fuente_normal']);

    //   $table->addCell(2000, ['celda_normal'])
    //     ->addText($fila['cantidad_insectocutores'], ['fuente_normal'], ['align' => 'center']);

    //   $totalGeneral += $fila['cantidad_insectocutores'];
    // }

    // // Fila de totales
    // $table->addRow(400);
    // $table->addCell(800, ['celda_totales'])
    //   ->addText('-', ['fuente_totales'], ['align' => 'center']);
    // $table->addCell(4000, ['celda_totales'])
    //   ->addText('TOTAL GENERAL', ['fuente_totales']);
    // $table->addCell(2000, ['celda_totales'])
    //   ->addText($totalGeneral, ['fuente_totales'], ['align' => 'center']);

    // $table = $section->addTable();
    // $table->addRow();
    // $table->addCell()->addText("Nro", ['bold' => true]);
    // $table->addCell()->addText("LUGAR", ['bold' => true]);
    // $table->addCell()->addText("CANTIDAD", ['bold' => true]);

    // $table->addRow();
    // $table->addCell()->addText('');
    // $table->addCell()->addText('');
    // $table->addCell()->addText('');

    // $table->addRow();
    // $table->addCell()->addText('TOTAL');
    // $table->addCell()->addText('');
    // $table->addCell()->addText('');

    $section->addTextBreak();
    $section->addText(
      'La incidencia es el número de individuos que están presentes en un determinado lugar la gráfica de incidencia muestra la presencia en estado adulto de los tres tipos de insectos que se ha logrado capturar que son mosca, mosquito y polillas en este estado no realizan daño directo sino tienen una actividad de colocar huevos para completar su metamorfosis.',
      [],
      [
        'alignment' => Jc::BOTH,
        'lineHeight' => 1.15
      ]
    );
    $section->addTextBreak();
    $section->addText(
      'Para realizar el calculo de la incidencia se toma en cuenta las cuatro visitas realizadas en los formularios de conformidad se saca el promedio de los 3 insectocutores por visita y se llena la tabla que se muestra a continuación.',
      [],
      [
        'alignment' => Jc::BOTH,
        'lineHeight' => 1.15
      ]
    );

    $section->addTextBreak();
    $section->addText('Incidencia de insectos', ['bold' => true]);

    $phpWord->addTableStyle('tabla_reporte_incidencia', [
      'borderSize' => 6,          // grosor borde
      'borderColor' => '000000',  // color borde negro
      'cellMargin' => 80,         // espacio interno
      'alignment' => JcTable::CENTER,
      // 'width' => 100 * 50,        // 100%
      'unit' => TblWidth::PERCENT,
    ], [
      'bgColor' => 'D9D9D9',      // fondo encabezado
    ]);

    $table = $section->addTable('tabla_reporte_incidencia');

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



    $section->addText('');

    // if ($chart1) {
    //   $section->addTextBreak();
    //   $section->addText('Total insectos por especie');
    //   $section->addImage($chart1, ['width' => 300]);
    // }

    // [TABLA DE INCIDENCIA]

    if ($chart2) {
      // $section->addPageBreak();
      $section->addText('INCIDENCIA DE INSECTOS VOLADORES');
      $section->addImage($chart2, ['width' => 300]);
    }
    $section->addTextBreak();
    $section->addText(
      'Se tiene el promedio bajo para las tres observaciones realizada entre los meses de enero y febrero  el mes: mosquito 9%) para la polilla (4%) y finalmente para la mosca (3%) donde la presencia de los tres insectos evaluados es una incidencia baja. estos datos pueden ser debidos a los cambios bruscos de temperatura y humedad en todo caso no existe afectación a los ambientes ni productos evaluados. ',
      [],
      [
        'alignment' => Jc::BOTH,
        'lineHeight' => 1.15
      ]
    );
    $section->addTextBreak();

    $section->addText(
      'Finalmente podemos concluir que la incidencia para los meses de enero y febrero se mantiene baja y al capturar insectos en su etapa adulta cortamos totalmente su ciclo biológico evitando daño a los productos.',
      [],
      [
        'alignment' => Jc::BOTH,
        'lineHeight' => 1.15
      ]
    );

    // [TABLA DE SEVERIDAD]
    $section->addTextBreak();
    $section->addText(
      'La severidad se entiende como la mayor cantidad de individuos concentrados en un almacén determinado este parámetro ayuda para identificar donde se concentra más y que especie de insectos tienen mayor presencia para tomar medidas de control si fuese necesario.',
      [],
      [
        'alignment' => Jc::BOTH,
        'lineHeight' => 1.15
      ]
    );

    $section->addTextBreak();

    $section->addText(
      'Para realizar el cálculo de la severidad se toma en cuenta las tres visitas realizadas en los formularios de conformidad se saca un promedio de las tres visitas  y se llena la tabla que se muestra a continuación.',
      [],
      [
        'alignment' => Jc::BOTH,
        'lineHeight' => 1.15
      ]
    );

    $section->addTextBreak();
    $section->addText('Severidad de insectos', ['bold' => true]);

    $section->addTextBreak();
    $section->addTextBreak();

    $phpWord->addTableStyle('tabla_reporte_severidad', [
      'borderSize' => 6,          // grosor borde
      'borderColor' => '000000',  // color borde negro
      'cellMargin' => 80,         // espacio interno
      'alignment' => JcTable::CENTER,
      // 'width' => 100 * 50,        // 100%
      'unit' => TblWidth::PERCENT,
    ], [
      'bgColor' => 'D9D9D9',      // fondo encabezado
    ]);

    $table = $section->addTable('tabla_reporte_severidad');

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
        // $table->addCell()->addText(round($valor / count($datosPorFecha), 0, PHP_ROUND_HALF_DOWN));
        $table->addCell()->addText((int)($valor / count($datosPorFecha)));
      }
    }

    $section->addTextBreak();

    if ($chart5) {
      // $section->addPageBreak();
      $section->addText('GRAFICO: SEVERIDAD DE INSECTOS VOLADORES');
      $section->addImage($chart5, ['width' => 300]);
    }

    $section->addTextBreak();


    $section->addTextBreak();
    $section->addText(
      'Los resultados de la severidad para el mes de enero y febrero muestran en promedio una concentración muy baja de moscas (1%) mosquitos (2%) y polilla (1%) porcentajes que para fines de análisis no se tomara en cuenta ya que no afectan a la producción de las bebidas en la planta.',
      [],
      [
        'alignment' => Jc::BOTH,
        'lineHeight' => 1.15
      ]
    );



    $section->addTextBreak();



    $section->addTextBreak(1);



    $section->addTextBreak();

    // ---------------------SECCION: ACTIVIDADES COMPLEMENTARIAS DE CONTROL ----------------------------        
    $section->addText('ACTIVIDADES COMPLEMENTARIAS DE CONTROL', [
      'bold' => true,
      'size' => 11,
      'underline' => 'single',
    ]);

    // [DESCRIPCION]
    // [IMAGENES]
    $section->addTextBreak();

    if ($acciones) {
      foreach ($acciones as $accion) {
        $section->addTextBreak();
        $section->addText($accion->created_at);
        $section->addTextBreak();
        $section->addText($accion->descripcion);
        $section->addTextBreak();
        if ($accion->imagenes) {
          foreach ($accion->imagenes as $img) {
            $section->addImage(public_path($img->imagen), [
              'width'  => 200,
              // 'height' => 100,
              'alignment' => Jc::CENTER,
            ]);
          }
        }
      }
    }




    // ---------------------SECCION: RECOMENDACIONES PARA LA PROXIMA VISITA: ----------------------------        
    $this->pie($section, $request);

    $file = storage_path('app/informe.docx');
    if (!$file) {
      $file = storage_path('app\\informe.docx');
    }

    IOFactory::createWriter($phpWord, 'Word2007')->save($file);

    // Log::info('SEGUNDA SECCION GGGGGG');
    return;

    return response()->json(['ok' => true]);
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
    $section->addTextBreak();
    $section->addText('RECOMENDACIONES PARA LA PROXIMA VISITA:', [
      'bold' => true,
      'size' => 11,
      'underline' => 'single',
    ]);

    $section->addTextBreak();
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
    $section->addTextBreak();
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
    $section->addTextBreak();
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
    $section->addTextBreak();
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
    $section->addTextBreak();
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
