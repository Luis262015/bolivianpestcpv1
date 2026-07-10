<?php

namespace App\Http\Controllers;

use App\Models\Cronograma;
use App\Models\Seguimiento;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\DB;

class DashboardController extends Controller
{
  private const MESES = ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'];

  /**
   * Dashboard operativo (staff) o recortado (cliente) según rol.
   */
  public function index()
  {
    $user = auth()->user();

    if ($user->hasRole('cliente')) {
      return $this->clienteDashboard($user);
    }

    return $this->adminDashboard();
  }

  private function adminDashboard()
  {
    $hoy = Carbon::today();
    $ayer = Carbon::yesterday();
    $inicioMes = Carbon::now()->startOfMonth();
    $finMes = Carbon::now()->endOfMonth();

    /* ---------- KPIs ---------- */
    // Hoy y ayer en una sola consulta, con rango sargable sobre created_at.
    $dias = Seguimiento::where('created_at', '>=', $ayer)
      ->selectRaw('COALESCE(SUM(created_at >= ?), 0) as hoy, COALESCE(SUM(created_at < ?), 0) as ayer', [$hoy, $hoy])
      ->first();

    $porStatus = Cronograma::whereIn('status', ['pendiente', 'postergado'])
      ->select('status', DB::raw('COUNT(*) as total'))
      ->groupBy('status')
      ->pluck('total', 'status');

    [$roedoresCapturados, $roedoresCapturadosPrev] = $this->roedoresCapturados(null);

    /* ---------- Servicios por mes (últimos 12 meses) ---------- */
    $crudos = $this->serviciosPorPeriodo(null);
    $serviciosPorMes = $this->serieMensual($crudos);

    /* ---------- Cumplimiento de cronograma (mes actual, por fecha de tarea) ---------- */
    $cumplimiento = Cronograma::whereBetween('date', [$inicioMes->toDateString(), $finMes->toDateString()])
      ->select('status', DB::raw('COUNT(*) as total'))
      ->groupBy('status')
      ->pluck('total', 'status');

    $cumplimientoCronograma = [
      ['estado' => 'Completado', 'total' => (int) ($cumplimiento['completado'] ?? 0), 'fill' => '#22c55e'],
      ['estado' => 'Pendiente', 'total' => (int) ($cumplimiento['pendiente'] ?? 0), 'fill' => '#f59e0b'],
      ['estado' => 'Postergado', 'total' => (int) ($cumplimiento['postergado'] ?? 0), 'fill' => '#ef4444'],
    ];

    return inertia('dashboard', [
      'stats' => [
        'serviciosHoy' => (int) $dias->hoy,
        'serviciosAyer' => (int) $dias->ayer,
        'serviciosMes' => (int) ($crudos[Carbon::now()->format('Y-m')] ?? 0),
        'serviciosMesAnterior' => (int) ($crudos[Carbon::now()->subMonth()->format('Y-m')] ?? 0),
        'cronogramaPendiente' => (int) ($porStatus['pendiente'] ?? 0),
        'cronogramaPostergado' => (int) ($porStatus['postergado'] ?? 0),
        'roedoresCapturados' => $roedoresCapturados,
        'roedoresCapturadosPrev' => $roedoresCapturadosPrev,
      ],
      'serviciosPorMes' => $serviciosPorMes,
      'cumplimientoCronograma' => $cumplimientoCronograma,
      'topEspecies' => $this->topEspecies(null),
      'proximasVisitas' => $this->proximasVisitas(null, conTecnico: true),
    ]);
  }

  /**
   * Dashboard recortado para clientes: solo datos de las empresas asignadas
   * al usuario logueado. No expone métricas globales del sistema.
   */
  private function clienteDashboard(User $user)
  {
    // Solo los ids: evita hidratar modelos Empresa completos.
    $empresaIds = $user->empresas()->pluck('empresas.id')->all();

    /* ---------- KPIs (acotados a sus empresas) ---------- */
    $porStatus = Cronograma::whereIn('empresa_id', $empresaIds)
      ->whereIn('status', ['pendiente', 'postergado'])
      ->select('status', DB::raw('COUNT(*) as total'))
      ->groupBy('status')
      ->pluck('total', 'status');

    [$roedoresCapturados, $roedoresCapturadosPrev] = $this->roedoresCapturados($empresaIds);

    $especiesDetectadas = (int) DB::table('trampa_especie_seguimientos')
      ->join('seguimientos', 'seguimientos.id', '=', 'trampa_especie_seguimientos.seguimiento_id')
      ->whereIn('seguimientos.empresa_id', $empresaIds)
      ->where('trampa_especie_seguimientos.created_at', '>=', Carbon::now()->subDays(90))
      ->sum('trampa_especie_seguimientos.cantidad');

    /* ---------- Servicios por mes (últimos 12 meses) ---------- */
    $crudos = $this->serviciosPorPeriodo($empresaIds);
    $serviciosPorMes = $this->serieMensual($crudos);

    return inertia('dashboard-cliente', [
      'stats' => [
        'serviciosMes' => (int) ($crudos[Carbon::now()->format('Y-m')] ?? 0),
        'serviciosMesAnterior' => (int) ($crudos[Carbon::now()->subMonth()->format('Y-m')] ?? 0),
        'cronogramaPendiente' => (int) ($porStatus['pendiente'] ?? 0),
        'cronogramaPostergado' => (int) ($porStatus['postergado'] ?? 0),
        'roedoresCapturados' => $roedoresCapturados,
        'roedoresCapturadosPrev' => $roedoresCapturadosPrev,
        'especiesDetectadas' => $especiesDetectadas,
      ],
      'serviciosPorMes' => $serviciosPorMes,
      'topEspecies' => $this->topEspecies($empresaIds),
      'proximasVisitas' => $this->proximasVisitas($empresaIds),
    ]);
  }

  /* ==================== Helpers compartidos ==================== */

  /**
   * Roedores capturados en los últimos 90 días y en los 90 anteriores,
   * en una sola consulta. $empresaIds === null significa "sin acotar"
   * (staff); un array (aunque esté vacío) acota siempre al cliente.
   */
  private function roedoresCapturados(?array $empresaIds): array
  {
    $hace90 = Carbon::now()->subDays(90);

    $totales = DB::table('trampa_roedor_seguimientos')
      ->when($empresaIds !== null, function ($q) use ($empresaIds) {
        $q->join('seguimientos', 'seguimientos.id', '=', 'trampa_roedor_seguimientos.seguimiento_id')
          ->whereIn('seguimientos.empresa_id', $empresaIds);
      })
      ->where('trampa_roedor_seguimientos.created_at', '>=', Carbon::now()->subDays(180))
      ->selectRaw(
        'COALESCE(SUM(CASE WHEN trampa_roedor_seguimientos.created_at >= ? THEN cantidad END), 0) as actual,
         COALESCE(SUM(CASE WHEN trampa_roedor_seguimientos.created_at < ? THEN cantidad END), 0) as previo',
        [$hace90, $hace90]
      )
      ->first();

    return [(int) $totales->actual, (int) $totales->previo];
  }

  /**
   * Conteo de seguimientos por periodo 'Y-m' de los últimos 12 meses.
   */
  private function serviciosPorPeriodo(?array $empresaIds): Collection
  {
    return Seguimiento::query()
      ->when($empresaIds !== null, fn($q) => $q->whereIn('empresa_id', $empresaIds))
      ->where('created_at', '>=', Carbon::now()->subMonths(11)->startOfMonth())
      ->select(
        DB::raw("DATE_FORMAT(created_at, '%Y-%m') as periodo"),
        DB::raw('COUNT(*) as total')
      )
      ->groupBy('periodo')
      ->pluck('total', 'periodo');
  }

  /**
   * Convierte los conteos por periodo en la serie de 12 meses que grafica el front.
   */
  private function serieMensual(Collection $crudos): array
  {
    $serie = [];
    for ($i = 11; $i >= 0; $i--) {
      $fecha = Carbon::now()->subMonths($i);
      $serie[] = [
        'mes' => self::MESES[$fecha->month - 1] . ' ' . $fecha->format('y'),
        'total' => (int) ($crudos[$fecha->format('Y-m')] ?? 0),
      ];
    }

    return $serie;
  }

  /**
   * Top plagas / especies detectadas (últimos 90 días).
   */
  private function topEspecies(?array $empresaIds): Collection
  {
    return DB::table('trampa_especie_seguimientos')
      ->join('especies', 'especies.id', '=', 'trampa_especie_seguimientos.especie_id')
      ->when($empresaIds !== null, function ($q) use ($empresaIds) {
        $q->join('seguimientos', 'seguimientos.id', '=', 'trampa_especie_seguimientos.seguimiento_id')
          ->whereIn('seguimientos.empresa_id', $empresaIds);
      })
      ->where('trampa_especie_seguimientos.created_at', '>=', Carbon::now()->subDays(90))
      ->select('especies.nombre', DB::raw('SUM(trampa_especie_seguimientos.cantidad) as total'))
      ->groupBy('especies.id', 'especies.nombre')
      ->orderByDesc('total')
      ->limit(6)
      ->get()
      ->map(fn($r) => ['nombre' => $r->nombre, 'total' => (int) $r->total])
      ->values();
  }

  /**
   * Próximas visitas del cronograma pendiente (hoy en adelante).
   */
  private function proximasVisitas(?array $empresaIds, bool $conTecnico = false): Collection
  {
    $relaciones = ['empresa:id,nombre', 'almacen:id,nombre', 'tipo_seguimiento:id,nombre'];
    if ($conTecnico) {
      $relaciones[] = 'tecnico:id,name';
    }

    return Cronograma::with($relaciones)
      ->when($empresaIds !== null, fn($q) => $q->whereIn('empresa_id', $empresaIds))
      ->where('status', 'pendiente')
      ->where('date', '>=', Carbon::today()->toDateString())
      ->orderBy('date')
      ->limit(8)
      ->get()
      ->map(fn($c) => array_merge([
        'id' => $c->id,
        'title' => $c->title,
        'date' => $c->date,
        'empresa' => $c->empresa?->nombre,
        'almacen' => $c->almacen?->nombre,
        'tipo' => $c->tipo_seguimiento?->nombre,
      ], $conTecnico ? ['tecnico' => $c->tecnico?->name] : []));
  }
}
