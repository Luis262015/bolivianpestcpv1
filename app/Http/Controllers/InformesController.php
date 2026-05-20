<?php

namespace App\Http\Controllers;

use App\Models\Accion;
use App\Models\Almacen;
use App\Models\Empresa;
use App\Models\InformeArchivo;
use App\Models\Seguimiento;
use App\Models\SeguimientoImage;
use App\Models\Trampa;
use App\Models\TrampaRoedorSeguimiento;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use PhpOffice\PhpWord\IOFactory;
use PhpOffice\PhpWord\PhpWord;
use PhpOffice\PhpWord\SimpleType\Jc;
use PhpOffice\PhpWord\SimpleType\JcTable;
use PhpOffice\PhpWord\SimpleType\TblWidth;
use PhpOffice\PhpWord\Style\Language;

class InformesController extends Controller
{
    // Paleta de colores corporativa
    private const C_NAVY    = '1B3A6B';  // Azul oscuro — cabeceras, banners
    private const C_BLUE    = '2E75B6';  // Azul medio — totales, acentos
    private const C_LIGHT   = 'DEEAF1';  // Azul muy claro — filas alternas
    private const C_BORDER  = 'BDD7EE';  // Borde azul claro
    private const C_WHITE   = 'FFFFFF';
    private const C_TEXT    = '1A1A1A';  // Texto casi negro

    // Estilos de celda
    private const CELDA_ENCABEZADO = ['bgColor' => '1B3A6B', 'borderSize' => 4, 'borderColor' => '1B3A6B', 'valign' => 'center'];
    private const CELDA_NORMAL     = ['bgColor' => 'FFFFFF', 'borderSize' => 4, 'borderColor' => 'BDD7EE', 'valign' => 'center'];
    private const CELDA_ALT        = ['bgColor' => 'DEEAF1', 'borderSize' => 4, 'borderColor' => 'BDD7EE', 'valign' => 'center'];
    private const CELDA_TOTALES    = ['bgColor' => '2E75B6', 'borderSize' => 4, 'borderColor' => '2E75B6', 'valign' => 'center'];
    private const CELDA_LABEL      = ['bgColor' => 'DEEAF1', 'borderSize' => 4, 'borderColor' => 'BDD7EE', 'valign' => 'center'];

    public function index(Request $request)
    {
        $user = $request->user();

        $empresasDelUsuario = [];
        if ($user->hasRole('cliente')) {
            $empresasUser       = User::with('empresas')->find($user->id);
            $empresaUser        = $empresasUser->empresas[0];
            $empresas           = Empresa::select(['id', 'nombre'])->where('id', $empresaUser->id)->get();
            $empresasDelUsuario = [$empresaUser->id];
        } else {
            $empresas = Empresa::select('id', 'nombre')->get();
        }

        $almacenes = [];
        if ($request->empresa_id) {
            $almacenes = Almacen::where('empresa_id', $request->empresa_id)
                ->select('id', 'nombre')
                ->get();
        }

        $seguimientos  = [];
        $trampas_insect = 0;
        $trampas_rat   = 0;
        $totales       = [];
        $acciones      = [];

        if ($request->filled('buscar') && $request->almacen_id && $request->fecha_inicio && $request->fecha_fin) {
            $request->validate([
                'empresa_id' => 'required|integer|exists:empresas,id',
            ]);

            $fechaInicio = $request->fecha_inicio . ' 00:00:00';
            $fechaFin    = $request->fecha_fin . ' 23:59:59';

            $seguimientos = Seguimiento::with([
                'almacen',
                'roedores.trampa.trampa_tipo',
                'roedores.trampa.mapa',
                'insectocutores.especie',
                'tipoSeguimiento',
                'user',
            ])
                ->where('almacen_id', $request->almacen_id)
                ->whereBetween('created_at', [$fechaInicio, $fechaFin])
                ->orderBy('created_at')
                ->get(['id', 'tipo_seguimiento_id', 'user_id', 'created_at', 'encargado_nombre', 'encargado_cargo', 'almacen_id', 'cronograma_id']);

            $acciones = Accion::with(['accionTrampas.trampa', 'imagenes'])
                ->where('almacen_id', $request->almacen_id)
                ->whereBetween('created_at', [$fechaInicio, $fechaFin])
                ->orderBy('created_at')
                ->get();

            $totales = TrampaRoedorSeguimiento::query()
                ->join('seguimientos', 'seguimientos.id', '=', 'trampa_roedor_seguimientos.seguimiento_id')
                ->where('seguimientos.almacen_id', $request->almacen_id)
                ->whereBetween('seguimientos.created_at', [$fechaInicio, $fechaFin])
                ->selectRaw("
                    DATE_FORMAT(seguimientos.created_at, '%Y-%m') as mes,
                    SUM(trampa_roedor_seguimientos.inicial) as inicial_sum,
                    SUM(trampa_roedor_seguimientos.merma)   as merma_sum,
                    SUM(trampa_roedor_seguimientos.actual)  as actual_sum,
                    AVG(trampa_roedor_seguimientos.inicial) as inicial_avg,
                    AVG(trampa_roedor_seguimientos.merma)   as merma_avg,
                    AVG(trampa_roedor_seguimientos.actual)  as actual_avg
                ")
                ->groupBy(DB::raw("DATE_FORMAT(seguimientos.created_at, '%Y-%m')"))
                ->orderBy('mes')
                ->get();

            $trampas        = Trampa::where('almacen_id', $request->almacen_id)->get();
            $trampas_insect = $trampas->where('trampa_tipo_id', 2)->count();
            $trampas_rat    = $trampas->where('trampa_tipo_id', '!=', 2)->count();
        }

        $archivosQuery = InformeArchivo::with(['empresa', 'user'])->orderBy('created_at', 'desc');

        if ($user->hasRole('cliente') && count($empresasDelUsuario) > 0) {
            $archivosQuery->whereIn('empresa_id', $empresasDelUsuario);
        }

        return inertia('admin/informes/index', [
            'empresas'      => $empresas,
            'almacenes'     => $almacenes,
            'seguimientos'  => $seguimientos,
            'acciones'      => $acciones,
            'trampasinsect' => $trampas_insect,
            'trampasrat'    => $trampas_rat,
            'totales'       => $totales,
            'archivos'      => $archivosQuery->get(),
            'filters'       => $request->only(
                'empresa_id',
                'almacen_id',
                'fecha_inicio',
                'fecha_fin',
                'tipo_filtro',
                'mes_inicio',
                'anio_inicio',
                'mes_fin',
                'anio_fin',
                'anio'
            ),
        ]);
    }

    public function obtenerEstado(Request $request)
    {
        $validated = $request->validate([
            'fecha_inicio' => 'required|date',
            'fecha_fin'    => 'required|date|after_or_equal:fecha_inicio',
            'almacen_id'   => 'required|integer|exists:almacenes,id',
        ]);

        return response()->json([
            'imagenes' => $this->conseguirImagenes(
                Carbon::parse($validated['fecha_inicio'])->startOfDay(),
                Carbon::parse($validated['fecha_fin'])->endOfDay(),
                $validated['almacen_id']
            ),
        ]);
    }

    public function storeWord(Request $request)
    {
        $request->validate([
            'almacen_id'        => 'required|integer|exists:almacenes,id',
            'fecha_inicio'      => 'required|date',
            'fecha_fin'         => 'required|date|after_or_equal:fecha_inicio',
            'seguimiento_ids'   => 'required|array',
            'seguimiento_ids.*' => 'integer|exists:seguimientos,id',
        ]);

        $fechaInicio = $request->fecha_inicio . ' 00:00:00';
        $fechaFin    = $request->fecha_fin . ' 23:59:59';

        $acciones = Accion::with(['accionTrampas.trampa', 'imagenes'])
            ->where('almacen_id', $request->almacen_id)
            ->whereBetween('created_at', [$fechaInicio, $fechaFin])
            ->orderBy('created_at')
            ->get();

        $seguimientos = Seguimiento::with([
            'almacen',
            'insectocutores.especie',
            'insectocutores.trampa.mapa',
            'roedores.trampa.mapa',
            'roedores.trampa.trampa_tipo',
            'images',
            'tipoSeguimiento',
            'metodos',
        ])->whereIn('id', $request->seguimiento_ids)->get();

        $datosTabla   = $this->procesarDatosTrampas($seguimientos);
        $datosTablaX1 = $this->procesarDatosReporte($seguimientos);
        $datosPorMapa = $this->procesarDatosPorMapa($seguimientos);
        $datosTablaX2 = $this->procesarDatosInsectocutores($seguimientos);

        [$especies, $datosPorFecha] = $this->procesarInsectocutoresPorFecha($seguimientos);

        $chart2 = $this->saveBase64Image($request->chart2, 'chart2');
        $chart5 = $this->saveBase64Image($request->chart5, 'chart5');

        $almacen       = Almacen::with('empresa')->find($request->almacen_id);
        $empresaNombre = $almacen->empresa->nombre ?? '';
        $almacenNombre = $almacen->nombre ?? '';

        $fechaInicioC = Carbon::parse($request->fecha_inicio);
        $fechaFinC    = Carbon::parse($request->fecha_fin);
        $periodoTexto = $fechaInicioC->month === $fechaFinC->month
            ? ucfirst($fechaInicioC->locale('es')->translatedFormat('F \d\e Y'))
            : ucfirst($fechaInicioC->locale('es')->translatedFormat('F')) . ' y ' . ucfirst($fechaFinC->locale('es')->translatedFormat('F \d\e Y'));

        $encargadoNombre      = $seguimientos->first()?->encargado_nombre ?? '';
        $encargadoCargo       = $seguimientos->first()?->encargado_cargo ?? '';
        $countDesrat          = $seguimientos->where('tipo_seguimiento_id', 1)->count();
        $countInsect          = $seguimientos->where('tipo_seguimiento_id', 3)->count();
        $totalTrampasRoedores = array_sum(array_column($datosTabla, 'cantidad_trampas'));
        $totalInsectocutores  = array_sum(array_column($datosTablaX2, 'cantidad_trampa_id'));

        $sumasEsp = array_fill_keys($especies, 0);
        foreach ($datosPorFecha as $data) {
            foreach ($especies as $esp) {
                $sumasEsp[$esp] += ($data[$esp] ?? 0);
            }
        }
        $totalEsp  = array_sum($sumasEsp);
        $pctInsect = [];
        if ($totalEsp > 0) {
            foreach ($sumasEsp as $esp => $suma) {
                $pctInsect[$esp] = round(($suma / $totalEsp) * 100);
            }
        }
        $textoEspecies = empty($pctInsect)
            ? 'los insectos evaluados'
            : implode(', ', array_map(fn($esp) => strtolower($esp) . ' (' . ($pctInsect[$esp] ?? 0) . '%)', $especies));

        $phpWord = new PhpWord();
        $phpWord->getSettings()->setThemeFontLang(new Language(Language::ES_ES));
        $phpWord->addParagraphStyle('global', ['lineHeight' => 1.15, 'spaceAfter' => 0, 'spaceBefore' => 0]);
        $this->configurarEstilos($phpWord);

        $section1 = $phpWord->addSection([
            'orientation'                    => 'portrait',
            'marginTop'                      => 2500,
            'marginBottom'                   => 1417,
            'marginLeft'                     => 2500,
            'marginRight'                    => 1700,
            'differentFirstPageHeaderFooter' => true,
        ]);
        $this->caratula($section1, $request, $almacenNombre, $periodoTexto, $encargadoNombre, $encargadoCargo);

        $section = $phpWord->addSection([
            'orientation' => 'portrait',
            'marginLeft'  => 2500,
        ]);

        $this->agregaIntroObjMetodo($section, $empresaNombre, $almacenNombre, $periodoTexto);

        $justified = ['alignment' => Jc::BOTH, 'lineHeight' => 1.15, 'spaceBefore' => 80, 'spaceAfter' => 80];

        $this->addSectionTitle($section, 'Lo que se realizó en la visita');

        $this->addSectionTitle($section, '1) Desratización');

        $this->agregaFotosSeguimientos($section, $seguimientos);
        $this->agregaTabla1($section, $datosTabla);
        $this->agregaTablasRodenticidas($section);

        $this->addSectionTitle($section, '2) Seguimiento de las unidades de control');
        $section->addText('Se realizaron ' . $countDesrat . ' seguimiento' . ($countDesrat !== 1 ? 's' : '') . ' al sistema de control de roedores según cronograma de actividades.', 'fuente_normal', $justified);

        $this->agregaTabla2($section, $seguimientos);
        $this->agregaTabla3($section, $datosTablaX1);

        $this->addSectionTitle($section, 'Balance y Análisis');
        $section->addText('Se cumplió con el seguimiento de las ' . $totalTrampasRoedores . ' unidades de control de roedores procediendo al pesaje de los cebos de las trampas, a continuación se muestran los cuadros resúmenes de estas actividades.', 'fuente_normal', $justified);
        $section->addText('Los cuadros muestran los pesos obtenidos por fechas de seguimiento, se verifica el peso total la merma y peso actual de las ' . $totalTrampasRoedores . ' unidades de control de roedores.', 'fuente_normal', $justified);

        $this->agregaTabla4($section, $datosPorMapa);

        $section->addText('La Grafica 2 muestra la cantidad de cebo que debe ingerir un roedor según los ingredientes activos para que se cumpla la DL50 (dosis letal media) y pueda ser eliminado. Corroborando que el ingrediente activo BRODIFACOUM es el mas efectivo con un consumo minimo.', 'fuente_normal', $justified);
        $this->addImageSafe($section, public_path('images/informe/Grafica-3.png'), ['width' => 240, 'alignment' => Jc::CENTER]);

        $section->addText('La Grafica 3 muestra el % de consumo quincenal de los ' . $countDesrat . ' seguimientos mensuales en el almacén ' . $almacenNombre . ', a la fecha de evaluación esta merma es debido a causas medioambientales ya que no se tuvo reporte de presencia y/o captura de roedor.', 'fuente_normal', $justified);
        $section->addTextBreak();

        foreach ($request->charts_por_mapa ?? [] as $index => $chartBase64) {
            $titulo = $request->charts_por_mapa_titulos[$index] ?? 'Mapa ' . ($index + 1);
            $section->addTitle($titulo, 2);
            $section->addTextBreak(1);
            $this->addImageSafe($section, $this->saveBase64Image($chartBase64, 'chartX_' . $index), ['width' => 300, 'alignment' => Jc::CENTER]);
            $section->addTextBreak(1);
        }
        $section->addTextBreak();

        // INICIA: INSECTOCUTORES
        if ($seguimientos->contains('tipo_seguimiento_id', 3)) {
            $this->addSectionTitle($section, '3) Barreras físicas de exclusión (Insectocutores)');
            $section->addText('Para el control de insectos voladores se han implementado ' . $totalInsectocutores . ' insectocutor' . ($totalInsectocutores !== 1 ? 'es' : '') . '. Se realizó el seguimiento revisando el tipo de insecto encontrado y la cantidad, con esta información se ha podido calcular la incidencia y severidad se muestra a través de gráficos las tendencias y análisis respectivos.', 'fuente_normal', $justified);

            $this->agregaTabla5($section, $datosTablaX2);

            $section->addText('La incidencia es el número de individuos que están presentes en un determinado lugar la gráfica de incidencia muestra la presencia en estado adulto de los tres tipos de insectos que se ha logrado capturar que son mosca, mosquito y polillas en este estado no realizan daño directo sino tienen una actividad de colocar huevos para completar su metamorfosis.', 'fuente_normal', $justified);
            $section->addText('Para realizar el cálculo de la incidencia se toma en cuenta las ' . $countInsect . ' visitas realizadas en los formularios de conformidad se saca el promedio de los ' . $totalInsectocutores . ' insectocutores por visita y se llena la tabla que se muestra a continuación.', 'fuente_normal', $justified);

            $this->agregaTablaIncidencia($section, $especies, $datosPorFecha, $chart2);

            $section->addText('Se tiene el promedio para las ' . $countInsect . ' observaciones realizadas en el período ' . $periodoTexto . ': ' . $textoEspecies . '. La presencia de los insectos evaluados es una incidencia baja. Estos datos pueden ser debidos a los cambios bruscos de temperatura y humedad, en todo caso no existe afectación a los ambientes ni productos evaluados.', 'fuente_normal', $justified);
            $section->addText('Finalmente podemos concluir que la incidencia para el período ' . $periodoTexto . ' se mantiene baja y al capturar insectos en su etapa adulta cortamos totalmente su ciclo biológico evitando daño a los productos.', 'fuente_normal', $justified);
            $section->addText('La severidad se entiende como la mayor cantidad de individuos concentrados en un almacén determinado este parámetro ayuda para identificar donde se concentra más y que especie de insectos tienen mayor presencia para tomar medidas de control si fuese necesario.', 'fuente_normal', $justified);
            $section->addText('Para realizar el cálculo de la severidad se toma en cuenta las ' . $countInsect . ' visitas realizadas en los formularios de conformidad se saca un promedio de las ' . $countInsect . ' visitas y se llena la tabla que se muestra a continuación.', 'fuente_normal', $justified);

            $this->agregaTablaSeveridad($section, $especies, $datosPorFecha, $chart5);

            $section->addText('Los resultados de la severidad para el período ' . $periodoTexto . ' muestran en promedio una concentración muy baja de ' . $textoEspecies . ', porcentajes que para fines de análisis no se tomarán en cuenta ya que no afectan a la producción en el almacén ' . $almacenNombre . '.', 'fuente_normal', $justified);
            $section->addTextBreak(2);
        }
        // FINALIZA: INSECTOCUTORES


        $seguimientosFumigacion = $seguimientos->where('tipo_seguimiento_id', 2)->values();

        $metodosEnFumigacion = $seguimientosFumigacion
            ->flatMap(fn($s) => $s->metodos->pluck('nombre'))
            ->unique();

        if ($metodosEnFumigacion->contains('Aspersion')) {
            $this->agregarPulverizacion($section, $justified, $seguimientosFumigacion);
        }

        if ($metodosEnFumigacion->intersect(['Fumigacion', 'Niebla', 'Nebulizacion'])->isNotEmpty()) {
            $this->agregarFumigacion($section, $justified, $seguimientosFumigacion);
        }


        $this->agregaActividadesExtras($section, $acciones);
        $this->pie($section, $request);

        IOFactory::createWriter($phpWord, 'Word2007')->save(storage_path('app/informe.docx'));

        return response()->json(['ok' => true]);
    }

    public function downloadWord()
    {
        $nombreArchivo = 'informe_' . now()->format('dmY_His') . '.docx';
        return response()->download(storage_path('app/informe.docx'), $nombreArchivo);
    }

    // -------------------------------------------------------------------------
    // Helpers de datos
    // -------------------------------------------------------------------------

    private function addImageSafe($container, ?string $path, array $options): void
    {
        if (empty($path) || !file_exists($path) || !is_file($path)) {
            return;
        }
        try {
            $container->addImage($path, $options);
        } catch (\Exception $e) {
            // La imagen no pudo embeberse; se omite y se continúa
        }
    }

    private function saveBase64Image(?string $base64, string $name): ?string
    {
        if (!$base64) {
            return null;
        }

        $data = base64_decode(substr($base64, strpos($base64, ',') + 1));
        $path = storage_path("app/{$name}.png");
        file_put_contents($path, $data);

        return $path;
    }

    private function conseguirImagenes(Carbon $inicio, Carbon $fin, int $almacenId)
    {
        return SeguimientoImage::whereHas('seguimiento', fn($q) => $q->where('almacen_id', $almacenId))
            ->whereBetween('created_at', [$inicio, $fin])
            ->get();
    }

    private function procesarInsectocutoresPorFecha($seguimientos): array
    {
        $especies     = [];
        $datosPorFecha = [];

        foreach ($seguimientos as $seg) {
            if ($seg->tipo_seguimiento_id != 3) {
                continue;
            }
            $fecha = $seg->created_at->format('d/m/Y');
            $datosPorFecha[$fecha] ??= [];

            foreach ($seg->insectocutores as $ins) {
                $nombre = $ins->especie->nombre;
                $especies[$nombre] = true;
                $datosPorFecha[$fecha][$nombre] = ($datosPorFecha[$fecha][$nombre] ?? 0) + $ins->cantidad;
            }
        }

        return [array_keys($especies), $datosPorFecha];
    }

    private function procesarDatosTrampas($seguimientos): array
    {
        $agrupado = [];

        foreach ($seguimientos as $seguimiento) {
            foreach ($seguimiento->roedores as $rodente) {
                $trampa = $rodente->trampa;

                if (!$trampa || !$trampa->mapa || !$trampa->trampa_tipo) {
                    continue;
                }

                $key = "{$trampa->mapa->id}-{$trampa->trampa_tipo->id}";

                $agrupado[$key] ??= [
                    'mapa_titulo'    => $trampa->mapa->titulo,
                    'tipo_nombre'    => $trampa->trampa_tipo->nombre,
                    'trampa_ids'     => [],
                    'cantidad_total' => 0,
                ];

                $agrupado[$key]['trampa_ids'][]  = $trampa->id;
                $agrupado[$key]['cantidad_total'] += (int) $rodente->cantidad;
            }
        }

        return array_values(array_map(fn($item) => [
            'cantidad_trampas' => count(array_unique($item['trampa_ids'])),
            'tipo_nombre'      => $item['tipo_nombre'],
            'cantidad'         => $item['cantidad_total'],
            'mapa_titulo'      => $item['mapa_titulo'],
        ], $agrupado));
    }

    private function procesarDatosReporte($seguimientos): array
    {
        $agrupado = [];

        foreach ($seguimientos as $seguimiento) {
            foreach ($seguimiento->roedores as $rodente) {
                $trampa = $rodente->trampa;

                if (!$trampa || !$trampa->mapa) {
                    continue;
                }

                $key = "{$seguimiento->id}-{$trampa->mapa->id}";

                $agrupado[$key] ??= [
                    'seguimiento_fecha' => $seguimiento->created_at,
                    'mapa_titulo'       => $trampa->mapa->titulo,
                    'trampa_ids'        => [],
                    'cantidad_total'    => 0,
                    'inicial_total'     => 0,
                    'merma_total'       => 0,
                    'actual_total'      => 0,
                ];

                $agrupado[$key]['trampa_ids'][]    = $trampa->id;
                $agrupado[$key]['cantidad_total']  += (int) $rodente->cantidad;
                $agrupado[$key]['inicial_total']   += (int) $rodente->inicial;
                $agrupado[$key]['merma_total']     += (int) $rodente->merma;
                $agrupado[$key]['actual_total']    += (int) $rodente->actual;
            }
        }

        return array_values(array_map(fn($item) => [
            'seguimiento_fecha' => $item['seguimiento_fecha'],
            'mapa_titulo'       => $item['mapa_titulo'],
            'cantidad_trampas'  => count(array_unique($item['trampa_ids'])),
            'cantidad'          => $item['cantidad_total'],
            'inicial'           => $item['inicial_total'],
            'merma'             => $item['merma_total'],
            'actual'            => $item['actual_total'],
            'porcentaje_merma'  => $item['inicial_total'] > 0
                ? round(($item['merma_total'] / $item['inicial_total']) * 100, 2)
                : 0,
        ], $agrupado));
    }

    private function procesarDatosPorMapa($seguimientos): array
    {
        $agrupadoPorMapa = [];

        foreach ($seguimientos as $seguimiento) {
            foreach ($seguimiento->roedores as $rodente) {
                $trampa = $rodente->trampa;

                if (!$trampa || !$trampa->mapa) {
                    continue;
                }

                $mapaTitulo = $trampa->mapa->titulo;
                $key        = "{$seguimiento->id}-{$trampa->mapa->id}";

                $agrupadoPorMapa[$mapaTitulo][$key] ??= [
                    'seguimiento_fecha' => $seguimiento->created_at,
                    'mapa_titulo'       => $mapaTitulo,
                    'trampa_ids'        => [],
                    'cantidad_total'    => 0,
                    'inicial_total'     => 0,
                    'merma_total'       => 0,
                    'actual_total'      => 0,
                ];

                $agrupadoPorMapa[$mapaTitulo][$key]['trampa_ids'][]    = $trampa->id;
                $agrupadoPorMapa[$mapaTitulo][$key]['cantidad_total']  += (int) $rodente->cantidad;
                $agrupadoPorMapa[$mapaTitulo][$key]['inicial_total']   += (int) $rodente->inicial;
                $agrupadoPorMapa[$mapaTitulo][$key]['merma_total']     += (int) $rodente->merma;
                $agrupadoPorMapa[$mapaTitulo][$key]['actual_total']    += (int) $rodente->actual;
            }
        }

        $resultado = [];

        foreach ($agrupadoPorMapa as $mapaTitulo => $datos) {
            $filas = array_values(array_map(fn($item) => [
                'seguimiento_fecha' => $item['seguimiento_fecha'],
                'mapa_titulo'       => $item['mapa_titulo'],
                'cantidad_trampas'  => count(array_unique($item['trampa_ids'])),
                'cantidad'          => $item['cantidad_total'],
                'inicial'           => $item['inicial_total'],
                'merma'             => $item['merma_total'],
                'actual'            => $item['actual_total'],
                'porcentaje_merma'  => $item['inicial_total'] > 0
                    ? round(($item['merma_total'] / $item['inicial_total']) * 100, 2)
                    : 0,
            ], $datos));

            $resultado[$mapaTitulo] = [
                'filas'   => $filas,
                'totales' => $this->calcularTotales($filas),
            ];
        }

        return $resultado;
    }

    private function calcularTotales(array $filas): array
    {
        $suma = array_reduce($filas, fn($acc, $row) => [
            'cantidad_trampas' => $acc['cantidad_trampas'] + $row['cantidad_trampas'],
            'cantidad'         => $acc['cantidad'] + $row['cantidad'],
            'inicial'          => $acc['inicial'] + $row['inicial'],
            'merma'            => $acc['merma'] + $row['merma'],
            'actual'           => $acc['actual'] + $row['actual'],
        ], ['cantidad_trampas' => 0, 'cantidad' => 0, 'inicial' => 0, 'merma' => 0, 'actual' => 0]);

        $suma['porcentaje_merma'] = $suma['inicial'] > 0
            ? round(($suma['merma'] / $suma['inicial']) * 100, 2)
            : 0;

        return $suma;
    }

    private function procesarDatosInsectocutores($seguimientos): array
    {
        $agrupadoPorMapa = [];

        foreach ($seguimientos as $seguimiento) {
            foreach ($seguimiento->insectocutores as $insectocutor) {
                $trampa = $insectocutor->trampa;

                if (!$trampa || !$trampa->mapa) {
                    continue;
                }

                $mapaId = $trampa->mapa->id;

                $agrupadoPorMapa[$mapaId] ??= [
                    'mapa_titulo'    => $trampa->mapa->titulo,
                    'trampa_ids'     => [],
                    'cantidad_total' => 0,
                ];

                $agrupadoPorMapa[$mapaId]['trampa_ids'][]    = $trampa->id;
                $agrupadoPorMapa[$mapaId]['cantidad_total']  += (int) $insectocutor->cantidad;
            }
        }

        $filas = array_values($agrupadoPorMapa);
        usort($filas, fn($a, $b) => strcmp($a['mapa_titulo'], $b['mapa_titulo']));

        return array_map(fn($fila, $index) => [
            'nro'                     => $index + 1,
            'mapa_titulo'             => $fila['mapa_titulo'],
            'cantidad_trampa_id'      => count(array_unique($fila['trampa_ids'])),
            'cantidad_insectocutores' => $fila['cantidad_total'],
        ], $filas, array_keys($filas));
    }

    // -------------------------------------------------------------------------
    // Construcción del documento Word
    // -------------------------------------------------------------------------

    private function configurarEstilos(PhpWord $phpWord): void
    {
        $phpWord->addTitleStyle(1, ['size' => 16, 'bold' => true, 'color' => self::C_NAVY, 'name' => 'Calibri']);
        $phpWord->addTitleStyle(2, ['size' => 12, 'bold' => true, 'color' => self::C_BLUE, 'name' => 'Calibri']);

        $tableDefaults = [
            'borderSize'  => 4,
            'borderColor' => self::C_BORDER,
            'cellMargin'  => 120,
            'alignment'   => JcTable::CENTER,
            'unit'        => TblWidth::PERCENT,
            'width'       => 100 * 50,
        ];

        $tableStyles = [
            'tabla_reporte',
            'tablaCebo',
            'tablaBloques',
            'tablaCantidadDeTrampasPorTipo',
            'tablaFechaSeguimientos',
            'tablaResumenGlobal',
            'tabla_reporte_incidencia',
            'tabla_reporte_severidad',
        ];
        foreach ($tableStyles as $style) {
            $phpWord->addTableStyle($style, $tableDefaults, ['bgColor' => self::C_NAVY]);
        }

        // Fuentes
        $phpWord->addFontStyle('fuente_encabezado', ['size' => 10, 'bold' => true, 'color' => self::C_WHITE, 'name' => 'Calibri']);
        $phpWord->addFontStyle('fuente_normal',     ['size' => 10, 'color' => self::C_TEXT,  'name' => 'Calibri']);
        $phpWord->addFontStyle('fuente_totales',    ['size' => 10, 'bold' => true, 'color' => self::C_WHITE, 'name' => 'Calibri']);
        $phpWord->addFontStyle('fuente_label',      ['size' => 10, 'bold' => true, 'color' => self::C_NAVY,  'name' => 'Calibri']);
    }

    private function addSectionTitle($section, string $texto): void
    {
        $section->addText(
            strtoupper($texto),
            ['bold' => true, 'size' => 11, 'color' => self::C_NAVY, 'name' => 'Calibri'],
            [
                'borderBottomSize'  => 8,
                'borderBottomColor' => self::C_BLUE,
                'spaceBefore'       => 160,
                'spaceAfter'        => 120,
            ]
        );
    }

    private function caratula($section, Request $request, string $almacenNombre, string $periodoTexto, string $encargadoNombre, string $encargadoCargo): void
    {
        $header = $section->addHeader('first');
        $this->addImageSafe($header, public_path('images/informe/membretado.png'), [
            'width'               => 595,
            'height'              => 842,
            'positioning'         => 'absolute',
            'posHorizontal'       => 'left',
            'posHorizontalRel'    => 'page',
            'posHorizontalOffset' => 0,
            'posVertical'         => 'top',
            'posVerticalRel'      => 'page',
            'posVerticalOffset'   => 0,
            'wrappingStyle'       => 'behind',
        ]);

        $centered  = ['alignment' => Jc::CENTER, 'lineHeight' => 1, 'spaceAfter' => 0];
        $justified = ['alignment' => Jc::BOTH, 'lineHeight' => 1.15];

        $section->addText('La Paz ' . Carbon::now()->locale('es')->translatedFormat('d \d\e F \d\e Y'), ['name' => 'Calibri', 'size' => 11, 'lang' => 'es-ES']);
        $section->addText('CITE: ', ['bold' => true, 'size' => 12, 'underline' => 'single']);
        $section->addTextBreak(2);

        $section->addText($encargadoCargo ? 'Señor ' . $encargadoCargo . ':' : 'Señor:');
        $section->addText($encargadoNombre ?: '___________________');
        $section->addText('Presente .-');
        $section->addTextBreak(2);

        $section->addText('De mi mayor consideración:', ['name' => 'Calibri', 'size' => 11, 'lang' => 'es-ES']);
        $section->addText('Adjunto al presente remito a usted el Informe técnico sobre el Control Integral de Plagas realizado en el almacén ' . $almacenNombre . ', válido para el período de ' . $periodoTexto . ' en lo que se refiere a desratización y fumigación.', [], $justified);
        $section->addText('Sin otro particular saludo a usted con las consideraciones más distinguidas de mi respeto personal.', [], $justified);
        $section->addText('Atentamente');
        $section->addTextBreak(2);

        $this->addImageSafe($section, public_path('images/certificado/firma.png'), ['width' => 100, 'alignment' => Jc::CENTER]);
        $section->addText('Ing. Agr. Freddy Montero Castillo', ['size' => 10, 'name' => 'Calibri'], $centered);
        $section->addText('GERENTE PROPIETARIO',               ['size' => 10, 'bold' => true, 'name' => 'Calibri'], $centered);
        $section->addText('BOLIVIAN PEST HIGIENE AMBIENTAL',   ['size' => 10, 'name' => 'Calibri'], $centered);
        $section->addText('Telf: 2240974, Cel: 76738282',      ['size' => 10, 'name' => 'Calibri'], $centered);
        $this->addImageSafe($section, public_path('images/certificado/sello.png'), ['width' => 80, 'alignment' => Jc::CENTER]);

        $section->addPageBreak();
    }

    private function pie($section, Request $request): void
    {
        $this->addSectionTitle($section, 'Recomendaciones para la próxima visita');

        $listStyle = ['alignment' => Jc::BOTH, 'lineHeight' => 1.15, 'spaceBefore' => 60, 'spaceAfter' => 60];

        foreach (
            [
                'Recalcar la importancia del orden y limpieza a los encargados de los almacenes, estibadores y ayudantes, como parte del mantenimiento del control integral de plagas.',
                'Tener cuidado con las unidades de control evitando golpes y el recojo de sustancias pegajosas para mantener el efecto del trabajo realizado.',
                'Verificar siempre la existencia de plagas en el ingreso de nueva mercadería a los almacenes para no alterar el control integral en curso.',
                'Mantener protegidos los puntos de ingreso de personal y producto para evitar el ingreso de contaminantes al almacén.',
                'Cerrar las puertas inmediatamente después del ingreso de personal o mercadería para evitar que aves u otras plagas ingresen y contaminen los productos resguardados.',
            ] as $item
        ) {
            $section->addListItem($item, 0, 'fuente_normal', null, $listStyle);
        }
        $section->addTextBreak(2);
    }

    private function agregaIntroObjMetodo($section, string $empresaNombre, string $almacenNombre, string $periodoTexto): void
    {
        $centered  = ['alignment' => Jc::CENTER, 'spaceAfter' => 60];
        $justified = ['alignment' => Jc::BOTH, 'lineHeight' => 1.15, 'spaceBefore' => 80, 'spaceAfter' => 80];
        $titleFont = ['bold' => true, 'size' => 14, 'color' => self::C_NAVY, 'name' => 'Calibri'];

        $section->addText('INFORME TÉCNICO', $titleFont, $centered);
        $section->addText('CONTROL INTEGRAL DE PLAGAS', $titleFont, $centered);
        $section->addText('"' . $empresaNombre . '"', ['size' => 12, 'color' => self::C_BLUE, 'name' => 'Calibri', 'italic' => true], $centered);
        $section->addTextBreak(1);

        $this->addSectionTitle($section, 'Introducción');
        $section->addText('Las Buenas Prácticas de Almacenamiento BPAS son una herramienta básica para la obtención de productos seguros para el consumo y se focaliza en la higiene y en cómo se deben manipular estos siendo su aplicación obligatoria.', 'fuente_normal', $justified);
        $section->addText('La importancia de controlar las plagas radica en las pérdidas que estas ocasionan a través de mercaderías arruinadas, alimentos contaminados, potenciales demandas, productos mal utilizados para el control, daños a estructuras físicas de la empresa, pérdida de imagen, etc.', 'fuente_normal', $justified);
        $section->addText('Dando cumplimiento al CONTROL DE PLAGAS para esta gestión que se realiza a la empresa "' . $empresaNombre . '" pasamos a desglosar las actividades alcanzadas para el período de ' . $periodoTexto . ' en lo que se refiere al almacén ' . $almacenNombre . '.', 'fuente_normal', $justified);

        $this->addSectionTitle($section, 'Objetivo');
        $section->addText('Contribuir a la mejora del almacenamiento de los productos dentro la empresa ' . $empresaNombre . ' por medios de controles integrados de plagas aportando a la conservación de los productos libres de contaminantes.', 'fuente_normal', $justified);

        $this->addSectionTitle($section, 'Metodología');
        $section->addText('Respecto al trabajo realizado se tomará en cuenta tres etapas:', 'fuente_normal', $justified);
        $listStyle = ['alignment' => Jc::BOTH, 'lineHeight' => 1.15, 'spaceBefore' => 40, 'spaceAfter' => 40];
        $section->addListItem('Lo que se realizó el presente mes.',  0, 'fuente_normal', null, $listStyle);
        $section->addListItem('El balance y análisis.',              0, 'fuente_normal', null, $listStyle);
        $section->addListItem('Las recomendaciones para el próximo mes.', 0, 'fuente_normal', null, $listStyle);
        $section->addTextBreak(1);
    }

    private function agregarTablaProducto($section, string $nombre, array $datos): void
    {
        $section->addText(
            strtoupper($nombre),
            ['bold' => true, 'size' => 10, 'color' => self::C_BLUE, 'name' => 'Calibri'],
            ['spaceBefore' => 80, 'spaceAfter' => 60]
        );

        $table = $section->addTable('tablaCebo');
        foreach ($datos as $fila) {
            [$label1, $val1, $label2, $val2] = $fila;
            $table->addRow(400);
            $table->addCell(1800, self::CELDA_LABEL)->addText($label1, 'fuente_label');
            $table->addCell(2700, self::CELDA_NORMAL)->addText($val1,  'fuente_normal');
            $table->addCell(1800, self::CELDA_LABEL)->addText($label2, 'fuente_label');
            $table->addCell(2700, self::CELDA_NORMAL)->addText($val2,  'fuente_normal');
        }
        $section->addTextBreak(1);
    }

    private function agregaTablasRodenticidas($section): void
    {
        $justified = ['alignment' => Jc::BOTH, 'lineHeight' => 1.15, 'spaceBefore' => 80, 'spaceAfter' => 80];

        $section->addText('Los rodenticidas utilizados para el trabajo son  en presentación de pellets  y bloques parafinados de acuerdo a la ubicación de las trampas sea exterior o interior se coloca el respectivo rodenticida esto esta en función tambien del nivel de riesgo de la presencia de plaga.', 'fuente_normal', $justified);

        $this->agregarTablaProducto($section, 'Rodenticida KLERAT — Pellets', [
            ['Nombre Comercial', 'RODENTICIDA KLERAT',     'Clase',              'RATICIDA MONOSODICO'],
            ['Ingrediente Activo', 'BRODIFACOUM (3-3-4 bromo 1-1 bifenil-4-il-1-2-3-4 tetrahidro1-naftalenil-4 hidrocumarina)', 'Composición', 'Rodenticida Monosodico de Actividad Prolongada Cebo en Granos'],
            ['Grupo Químico',    'BRODIFACOUM WARFARÍNICO', 'Tipo Formulación',  'CEBO EN PELLETS'],
            ['Nro. Registro',    'INSO NRO. BR1020ROAB01', 'Presentación',      'Pellets'],
        ]);

        $this->agregarTablaProducto($section, 'Rodenticida KLERAT — Bloques Parafinados', [
            ['Nombre Comercial', 'RODENTICIDA KLERAT',     'Clase',             'RATICIDA MONOSODICO'],
            ['Ingrediente Activo', 'BRODIFACOUM',          'Composición',       'Brodifacoum 0.05g · Benzoato de denatonium 0.01g · Excipientes c.s. 1kg'],
            ['Grupo Químico',    'BRODIFACOUM WARFARÍNICO', 'Tipo Formulación', 'BLOQUES PARAFÍNICOS'],
            ['Nro. Registro',    'INSO NRO. BRO913ROBB01', 'Presentación',     'Bloques parafinados'],
        ]);
    }

    private function agregaActividadesExtras($section, $acciones): void
    {
        $this->addSectionTitle($section, 'Actividades complementarias de control');

        $justified = ['alignment' => Jc::BOTH, 'lineHeight' => 1.15, 'spaceBefore' => 60, 'spaceAfter' => 60];

        foreach ($acciones as $accion) {
            $section->addText(
                Carbon::parse($accion->created_at)->format('d/m/Y H:i'),
                ['bold' => true, 'size' => 10, 'color' => self::C_NAVY, 'name' => 'Calibri'],
                ['spaceBefore' => 120, 'spaceAfter' => 60]
            );
            $section->addText($accion->descripcion, 'fuente_normal', $justified);

            foreach ($accion->imagenes as $img) {
                $this->addImageSafe($section, public_path($img->imagen), ['width' => 220, 'alignment' => Jc::CENTER]);
            }
        }
    }

    private function agregaFotosSeguimientos($section, $seguimientos): void
    {
        foreach ($seguimientos as $value) {
            if ($value->tipo_seguimiento_id != 1) {
                continue;
            }

            $section->addText('Seguimiento ' . $value->created_at, ['bold' => true, 'size' => 11, 'underline' => 'single']);

            foreach ($value->images as $v) {
                $imagePath = public_path($v->imagen);

                if (empty($v->imagen) || !file_exists($imagePath) || !is_file($imagePath)) {
                    continue;
                }

                try {
                    $section->addImage($imagePath, ['width' => 200, 'height' => 100, 'alignment' => Jc::CENTER]);
                } catch (\Exception $e) {
                    // La imagen no pudo embeberse; se omite y se continúa
                }
            }
        }
    }

    private function agregaTabla1($section, array $datosTabla): void
    {
        $table = $section->addTable('tablaCantidadDeTrampasPorTipo');
        $table->addRow(420);
        foreach (['TIPO DE TRAMPA' => 3000, 'CANTIDAD' => 1500, 'CAPTURAS' => 1500, 'ÁREA / MAPA' => 3000] as $h => $w) {
            $table->addCell($w, self::CELDA_ENCABEZADO)->addText($h, 'fuente_encabezado', ['alignment' => Jc::CENTER]);
        }

        foreach ($datosTabla as $i => $dato) {
            $celda = $i % 2 === 0 ? self::CELDA_NORMAL : self::CELDA_ALT;
            $table->addRow(380);
            $table->addCell(3000, $celda)->addText($dato['tipo_nombre'],     'fuente_normal');
            $table->addCell(1500, $celda)->addText($dato['cantidad_trampas'], 'fuente_normal', ['alignment' => Jc::CENTER]);
            $table->addCell(1500, $celda)->addText($dato['cantidad'],        'fuente_normal', ['alignment' => Jc::CENTER]);
            $table->addCell(3000, $celda)->addText($dato['mapa_titulo'],     'fuente_normal');
        }
        $section->addTextBreak(1);
    }

    private function agregaTabla2($section, $seguimientos): void
    {
        $table = $section->addTable('tablaFechaSeguimientos');
        $table->addRow(420);
        $table->addCell(5000, self::CELDA_ENCABEZADO)->addText('FECHA DE SEGUIMIENTO', 'fuente_encabezado', ['alignment' => Jc::CENTER]);
        $table->addCell(5000, self::CELDA_ENCABEZADO)->addText('TIPO DE SEGUIMIENTO',  'fuente_encabezado', ['alignment' => Jc::CENTER]);

        foreach ($seguimientos as $i => $seg) {
            $celda = $i % 2 === 0 ? self::CELDA_NORMAL : self::CELDA_ALT;
            $table->addRow(380);
            $table->addCell(5000, $celda)->addText(Carbon::parse($seg->created_at)->format('d/m/Y H:i'), 'fuente_normal', ['alignment' => Jc::CENTER]);
            $table->addCell(5000, $celda)->addText($seg->tipoSeguimiento->nombre ?? '', 'fuente_normal', ['alignment' => Jc::CENTER]);
        }

        $section->addTextBreak(1);
    }

    private function agregaTabla3($section, array $datosTablaX1): void
    {
        $table = $section->addTable('tablaResumenGlobal');
        $table->addRow(420);
        foreach (['SEGUIMIENTO' => 2500, 'MAPA' => 3500, 'TRAMPAS' => 1500, 'CAPTURADOS' => 1500] as $h => $w) {
            $table->addCell($w, self::CELDA_ENCABEZADO)->addText($h, 'fuente_encabezado', ['alignment' => Jc::CENTER]);
        }

        foreach ($datosTablaX1 as $i => $dato) {
            $celda = $i % 2 === 0 ? self::CELDA_NORMAL : self::CELDA_ALT;
            $table->addRow(380);
            $table->addCell(2500, $celda)->addText(Carbon::parse($dato['seguimiento_fecha'])->format('d/m/Y'), 'fuente_normal', ['alignment' => Jc::CENTER]);
            $table->addCell(3500, $celda)->addText($dato['mapa_titulo'],    'fuente_normal');
            $table->addCell(1500, $celda)->addText($dato['cantidad_trampas'], 'fuente_normal', ['alignment' => Jc::CENTER]);
            $table->addCell(1500, $celda)->addText($dato['cantidad'],        'fuente_normal', ['alignment' => Jc::CENTER]);
        }

        $section->addTextBreak(1);
    }

    private function agregaTabla4($section, array $datosPorMapa): void
    {
        $justified = ['alignment' => Jc::BOTH, 'lineHeight' => 1.15];

        foreach ($datosPorMapa as $mapaTitulo => $datos) {
            $this->agregarTablaPorMapa($section, $mapaTitulo, $datos);
        }

        $section->addText('Analizando las tablas de pesos respecto al porcentaje de merma se establece que este no pasa del 5% con relación al Peso Total 100% lo que significa que no ha existido consumo por parte de roedores ni su presencia en las fechas evaluadas. Este porcentaje esta relacionado con perdidas por medio ambiente vale decir condiciones de humedad, temperatura, vientos lluvia, etc. que afectan a los cebos colocados.', [], $justified);
        $section->addTextBreak();
        $section->addText('La Grafica 1 muestra la DL50 (dosis letal media) de los ingredientes activos de los rodenticidas mostrando que brodifacoum es el ingrediente mas efectivo ya que su porcentaje tanto para rata y raton es el mas bajo por lo tanto mas toxico necesitando menor consumo para ser mas efectivo.', [], $justified);
        $section->addTextBreak();
        $this->addImageSafe($section, public_path('images/informe/Tabla-DL50.png'), ['width' => 300, 'alignment' => Jc::CENTER]);
        $section->addTextBreak();
    }

    private function agregaTabla5($section, array $datosTablaX2): void
    {
        $section->addText('TABLA: CANTIDAD DE INSECTOCUTORES', ['bold' => true, 'size' => 11, 'underline' => 'single']);
        $section->addTextBreak();

        $table = $section->addTable('tabla_reporte');
        $table->addRow(400);

        $headers = [
            'NRO'                     => 800,
            'MAPA TÍTULO'             => 3500,
            'CANTIDAD TRAMPA ID'      => 1500,
            'CANTIDAD INSECTOCUTORES' => 2000,
        ];
        foreach ($headers as $header => $width) {
            $table->addCell($width, self::CELDA_ENCABEZADO)->addText($header, 'fuente_encabezado', ['align' => 'center']);
        }

        $totalTrampas        = 0;
        $totalInsectocutores = 0;

        foreach ($datosTablaX2 as $fila) {
            $table->addRow(400);
            $table->addCell(800,  self::CELDA_NORMAL)->addText($fila['nro'],                     'fuente_normal', ['align' => 'center']);
            $table->addCell(3500, self::CELDA_NORMAL)->addText($fila['mapa_titulo'],             'fuente_normal');
            $table->addCell(1500, self::CELDA_NORMAL)->addText($fila['cantidad_trampa_id'],      'fuente_normal', ['align' => 'center']);
            $table->addCell(2000, self::CELDA_NORMAL)->addText($fila['cantidad_insectocutores'], 'fuente_normal', ['align' => 'center']);

            $totalTrampas        += $fila['cantidad_trampa_id'];
            $totalInsectocutores += $fila['cantidad_insectocutores'];
        }

        $table->addRow(400);
        $table->addCell(800,  self::CELDA_TOTALES)->addText('-',             'fuente_totales', ['align' => 'center']);
        $table->addCell(3500, self::CELDA_TOTALES)->addText('TOTAL GENERAL', 'fuente_totales');
        $table->addCell(1500, self::CELDA_TOTALES)->addText($totalTrampas,        'fuente_totales', ['align' => 'center']);
        $table->addCell(2000, self::CELDA_TOTALES)->addText($totalInsectocutores, 'fuente_totales', ['align' => 'center']);
    }

    private function agregarTablaPorMapa($section, string $mapaTitulo, array $datos): void
    {
        $filas   = $datos['filas'];
        $totales = $datos['totales'];

        $section->addText(strtoupper($mapaTitulo), ['size' => 12, 'bold' => true]);

        $table = $section->addTable('tabla_reporte');
        $table->addRow(400);

        $headers = [
            'Fecha Seguimiento' => 2000,
            '# Trampas'         => 1000,
            'Cantidad'          => 1000,
            'Inicial'           => 1000,
            'Merma'             => 1000,
            'Actual'            => 1000,
            '% Merma'           => 1000,
        ];
        foreach ($headers as $header => $width) {
            $table->addCell($width, self::CELDA_ENCABEZADO)->addText($header, 'fuente_encabezado', ['align' => 'center']);
        }

        if (count($filas) > 0) {
            foreach ($filas as $i => $fila) {
                $celda = $i % 2 === 0 ? self::CELDA_NORMAL : self::CELDA_ALT;
                $table->addRow(380);
                $table->addCell(2000, $celda)->addText(date('d/m/Y', strtotime($fila['seguimiento_fecha'])), 'fuente_normal', ['alignment' => Jc::CENTER]);
                $table->addCell(1100, $celda)->addText($fila['cantidad_trampas'],                            'fuente_normal', ['alignment' => Jc::CENTER]);
                $table->addCell(1100, $celda)->addText($fila['cantidad'],                                    'fuente_normal', ['alignment' => Jc::CENTER]);
                $table->addCell(1100, $celda)->addText($fila['inicial'],                                     'fuente_normal', ['alignment' => Jc::CENTER]);
                $table->addCell(1100, $celda)->addText($fila['merma'],                                       'fuente_normal', ['alignment' => Jc::CENTER]);
                $table->addCell(1100, $celda)->addText($fila['actual'],                                      'fuente_normal', ['alignment' => Jc::CENTER]);
                $table->addCell(1100, $celda)->addText(number_format($fila['porcentaje_merma'], 2) . '%',    'fuente_normal', ['alignment' => Jc::CENTER]);
            }

            $table->addRow(420);
            $table->addCell(2000, self::CELDA_TOTALES)->addText('TOTALES',                                              'fuente_totales', ['alignment' => Jc::CENTER]);
            $table->addCell(1100, self::CELDA_TOTALES)->addText($totales['cantidad_trampas'],                           'fuente_totales', ['alignment' => Jc::CENTER]);
            $table->addCell(1100, self::CELDA_TOTALES)->addText($totales['cantidad'],                                   'fuente_totales', ['alignment' => Jc::CENTER]);
            $table->addCell(1100, self::CELDA_TOTALES)->addText($totales['inicial'],                                    'fuente_totales', ['alignment' => Jc::CENTER]);
            $table->addCell(1100, self::CELDA_TOTALES)->addText($totales['merma'],                                      'fuente_totales', ['alignment' => Jc::CENTER]);
            $table->addCell(1100, self::CELDA_TOTALES)->addText($totales['actual'],                                     'fuente_totales', ['alignment' => Jc::CENTER]);
            $table->addCell(1100, self::CELDA_TOTALES)->addText(number_format($totales['porcentaje_merma'], 2) . '%',  'fuente_totales', ['alignment' => Jc::CENTER]);
        } else {
            $table->addRow(380);
            $table->addCell(9200, self::CELDA_NORMAL)
                ->addText('No hay datos disponibles para este mapa', ['size' => 10, 'italic' => true, 'color' => '888888', 'name' => 'Calibri'], ['alignment' => Jc::CENTER]);
        }

        $section->addTextBreak(1);
    }

    private function agregaTablaIncidencia($section, array $especies, array $datosPorFecha, ?string $chart2): void
    {
        $section->addText('TABLA: INCIDENCIA DE INSECTOS VOLADORES', ['bold' => true, 'size' => 11, 'underline' => 'single', 'name' => 'Calibri'], ['spaceBefore' => 80, 'spaceAfter' => 60]);

        $table = $section->addTable('tabla_reporte_incidencia');
        $table->addRow(420);
        $table->addCell(2000, self::CELDA_ENCABEZADO)->addText('FECHA', 'fuente_encabezado', ['alignment' => Jc::CENTER]);
        foreach ($especies as $esp) {
            $table->addCell(1800, self::CELDA_ENCABEZADO)->addText(strtoupper($esp), 'fuente_encabezado', ['alignment' => Jc::CENTER]);
        }

        $totalesInc = array_fill_keys($especies, 0);
        $numFechasInc = count($datosPorFecha);
        $i = 0;
        foreach ($datosPorFecha as $fecha => $data) {
            $celda = $i++ % 2 === 0 ? self::CELDA_NORMAL : self::CELDA_ALT;
            $table->addRow(380);
            $table->addCell(2000, $celda)->addText($fecha, 'fuente_normal', ['alignment' => Jc::CENTER]);
            foreach ($especies as $esp) {
                $val = $data[$esp] ?? 0;
                $totalesInc[$esp] += $val;
                $table->addCell(1800, $celda)->addText($val, 'fuente_normal', ['alignment' => Jc::CENTER]);
            }
        }

        $table->addRow(420);
        $table->addCell(2000, self::CELDA_TOTALES)->addText('TOTAL', 'fuente_totales', ['alignment' => Jc::CENTER]);
        foreach ($especies as $esp) {
            $table->addCell(1800, self::CELDA_TOTALES)->addText($totalesInc[$esp], 'fuente_totales', ['alignment' => Jc::CENTER]);
        }

        $table->addRow(420);
        $table->addCell(2000, self::CELDA_TOTALES)->addText('PROMEDIO', 'fuente_totales', ['alignment' => Jc::CENTER]);
        foreach ($especies as $esp) {
            $promedio = $numFechasInc > 0 ? round($totalesInc[$esp] / $numFechasInc, 1) : 0;
            $table->addCell(1800, self::CELDA_TOTALES)->addText($promedio, 'fuente_totales', ['alignment' => Jc::CENTER]);
        }

        $section->addTextBreak(1);
        if ($chart2) {
            $section->addText('INCIDENCIA DE INSECTOS VOLADORES', ['bold' => true, 'size' => 10, 'color' => self::C_NAVY, 'name' => 'Calibri'], ['alignment' => Jc::CENTER]);
            $this->addImageSafe($section, $chart2, ['width' => 340, 'alignment' => Jc::CENTER]);
        }
        $section->addTextBreak(1);
    }

    private function agregaTablaSeveridad($section, array $especies, array $datosPorFecha, ?string $chart5): void
    {
        $section->addText('TABLA: SEVERIDAD DE INSECTOS VOLADORES', ['bold' => true, 'size' => 11, 'underline' => 'single', 'name' => 'Calibri'], ['spaceBefore' => 80, 'spaceAfter' => 60]);

        $table = $section->addTable('tabla_reporte_severidad');
        $table->addRow(420);
        $table->addCell(2000, self::CELDA_ENCABEZADO)->addText('FECHA', 'fuente_encabezado', ['alignment' => Jc::CENTER]);
        foreach ($especies as $esp) {
            $table->addCell(1800, self::CELDA_ENCABEZADO)->addText(strtoupper($esp), 'fuente_encabezado', ['alignment' => Jc::CENTER]);
        }

        $totalesSev = array_fill_keys($especies, 0);
        $numFechas  = count($datosPorFecha);
        $i = 0;
        foreach ($datosPorFecha as $fecha => $data) {
            $celda = $i++ % 2 === 0 ? self::CELDA_NORMAL : self::CELDA_ALT;
            $table->addRow(380);
            $table->addCell(2000, $celda)->addText($fecha, 'fuente_normal', ['alignment' => Jc::CENTER]);
            foreach ($especies as $esp) {
                $val = (int)(($data[$esp] ?? 0) / 3);
                $totalesSev[$esp] += $val;
                $table->addCell(1800, $celda)->addText($val, 'fuente_normal', ['alignment' => Jc::CENTER]);
            }
        }

        $table->addRow(420);
        $table->addCell(2000, self::CELDA_TOTALES)->addText('TOTAL', 'fuente_totales', ['alignment' => Jc::CENTER]);
        foreach ($especies as $esp) {
            $table->addCell(1800, self::CELDA_TOTALES)->addText($totalesSev[$esp], 'fuente_totales', ['alignment' => Jc::CENTER]);
        }

        $table->addRow(420);
        $table->addCell(2000, self::CELDA_TOTALES)->addText('PROMEDIO', 'fuente_totales', ['alignment' => Jc::CENTER]);
        foreach ($especies as $esp) {
            $promedio = $numFechas > 0 ? round($totalesSev[$esp] / $numFechas, 1) : 0;
            $table->addCell(1800, self::CELDA_TOTALES)->addText($promedio, 'fuente_totales', ['alignment' => Jc::CENTER]);
        }

        $section->addTextBreak(1);
        if ($chart5) {
            $section->addText('GRÁFICO: SEVERIDAD DE INSECTOS VOLADORES', ['bold' => true, 'size' => 10, 'color' => self::C_NAVY, 'name' => 'Calibri'], ['alignment' => Jc::CENTER]);
            $this->addImageSafe($section, $chart5, ['width' => 340, 'alignment' => Jc::CENTER]);
        }
        $section->addTextBreak(2);
    }

    private function agregarPulverizacion($section, $justified, $seguimientos): void
    {
        $this->addSectionTitle($section, 'Pulverizacion');
        $section->addText('Se procedió a realizar la PULVERIZACION de los almacenes planta principal, Almacen dos y Almacen Eventos el insecticida que se utilizo fue FENDONA es un insecticida del grupo de los piretroides el ingrediente activo es la alfacipermetrina a un porcentaje del 6% de solución concentrada, es un piretroide sintético contiene 600 gramos de ingrediente activo por litro de producción comercial.', 'fuente_normal', $justified);

        $this->agregarTablaProducto($section, 'Insecticida FENDONA 6% SC — Pulverización', [
            ['Nombre Comercial',  'FENDONA 6% SC',                               'Clase',             'INSECTICIDA DE CONTROL SANITARIO'],
            ['Ingrediente Activo', 'ALFACIPERMETRINA 6%',                          'Composición',       'Suspensión concentrada con base de piretroide'],
            ['Grupo Químico',     'INSECTICIDA PIRETROIDE SISTÉMICO',             'Tipo Formulación',  'SUSPENSIÓN CONCENTRADA'],
            ['Nro. Registro',     'INSO: BR1212ILSC02',                           'Presentación',      'Concentrado emulsionable'],
        ]);

        $section->addText('Es de clase III Moderadamente Tóxico Banda Azul registrado y autorizado en Bolivia por el I.N.S.O. posee gran residualidad y acción rápida, controla eficazmente insectos voladores y rastreros tiene un buen poder de volteo y controla plagas activas en el momento de su aplicación. Se trabajo en todos los ambientes del Almacén.', 'fuente_normal', $justified);
        $section->addText('Se trabajó con una dosificación del 50% (50 ml/10000ml) volumen/volumen del producto mencionado es decir 50ml/10 l de disolvente (H₂O) dosis adecuada para trabajar contra insectos voladores y rastreros.', 'fuente_normal', $justified);
        $section->addText('Después de la realización del proceso de pulverización en el almacén no se ha encontrado insectos vivos en ningún estado de su ciclo de vida (Huevo-Larva-Pupa-Adulto invernante).', 'fuente_normal', $justified);
        $section->addTextBreak(1);

        $conAspercion = $seguimientos->filter(
            fn($s) => $s->metodos->pluck('nombre')->contains('Aspersion')
        );

        foreach ($conAspercion as $seg) {
            foreach ($seg->images as $img) {
                $imagePath = public_path($img->imagen);
                if (empty($img->imagen) || !file_exists($imagePath) || !is_file($imagePath)) {
                    continue;
                }
                try {
                    $section->addImage($imagePath, ['width' => 200, 'height' => 100, 'alignment' => Jc::CENTER]);
                } catch (\Exception $e) {
                    // La imagen no pudo embeberse; se omite y se continúa
                }
            }
        }
    }

    private function agregarFumigacion($section, $justified, $seguimientos): void
    {
        $this->addSectionTitle($section, 'Fumigacion');
        $this->agregarTablaProducto($section, 'Insecticida TITANE DELTA — Termonebulización', [
            ['Nombre Comercial',  'TITANE DELTA',                                 'Clase',             'INSECTICIDA CLASE II — Etiqueta Amarilla'],
            ['Ingrediente Activo', 'LAMBDACYHALOTRINA AL 5%',                       'Composición',       'Lambdacyhalotrina 5% EC · Otros ingredientes 95%'],
            ['Grupo Químico',     'INSECTICIDA PIRETROIDE',                        'Tipo Formulación',  'CONCENTRACIÓN EMULSIONABLE'],
            ['Nro. Registro',     'INSO NRO. INO219ILEC01',                        'Presentación',      'Botella de 1 Lt.'],
        ]);

        $section->addText('Se realizó la preparación del producto colocando 50 ml de Titane Delta al tanque de la termonebulizadora en el que estaba el Aceite Vegetal; posteriormente en el compartimiento de agua se colocó 5 Lt. de solución, se encendió el termonebulizador y estaba lista para su uso.', 'fuente_normal', $justified);
        $section->addText('Por recomendaciones técnicas se trabajó con una dosis de 50 ml / 2 lt de coadyuvante aceite vegetal ECOPLUS, viene en presentación de concentrado emulsionable cuyo registro SENASAG es 2845, es un éster metílico de aceite vegetal.', 'fuente_normal', $justified);
        $section->addTextBreak(1);

        $conFumigacion = $seguimientos->filter(
            fn($s) => $s->metodos->pluck('nombre')->intersect(['Fumigacion', 'Niebla', 'Nebulizacion'])->isNotEmpty()
        );

        foreach ($conFumigacion as $seg) {
            foreach ($seg->images as $img) {
                $imagePath = public_path($img->imagen);
                if (empty($img->imagen) || !file_exists($imagePath) || !is_file($imagePath)) {
                    continue;
                }
                try {
                    $section->addImage($imagePath, ['width' => 200, 'height' => 100, 'alignment' => Jc::CENTER]);
                } catch (\Exception $e) {
                    // La imagen no pudo embeberse; se omite y se continúa
                }
            }
        }
    }
}
