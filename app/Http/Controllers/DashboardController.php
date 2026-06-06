<?php

namespace App\Http\Controllers;

use App\Models\Cronograma;
use App\Models\Seguimiento;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;

class DashboardController extends Controller
{
  /**
   * Dashboard operativo (vista admin).
   */
  public function index()
  {
    $hoy = Carbon::today();
    $ayer = Carbon::yesterday();
    $inicioMes = Carbon::now()->startOfMonth();
    $finMes = Carbon::now()->endOfMonth();
    $inicioMesAnterior = Carbon::now()->subMonth()->startOfMonth();
    $finMesAnterior = Carbon::now()->subMonth()->endOfMonth();

    /* ---------- KPIs ---------- */
    $serviciosHoy = Seguimiento::whereDate('created_at', $hoy)->count();
    $serviciosAyer = Seguimiento::whereDate('created_at', $ayer)->count();
    $serviciosMes = Seguimiento::whereBetween('created_at', [$inicioMes, $finMes])->count();
    $serviciosMesAnterior = Seguimiento::whereBetween('created_at', [$inicioMesAnterior, $finMesAnterior])->count();

    $cronogramaPendiente = Cronograma::where('status', 'pendiente')->count();
    $cronogramaPostergado = Cronograma::where('status', 'postergado')->count();

    // Roedores capturados: ventana de 90 días vs. los 90 días anteriores.
    $roedoresCapturados = (int) DB::table('trampa_roedor_seguimientos')
      ->where('created_at', '>=', Carbon::now()->subDays(90))
      ->sum('cantidad');
    $roedoresCapturadosPrev = (int) DB::table('trampa_roedor_seguimientos')
      ->whereBetween('created_at', [Carbon::now()->subDays(180), Carbon::now()->subDays(90)])
      ->sum('cantidad');

    /* ---------- Servicios por mes (últimos 12 meses) ---------- */
    $desde = Carbon::now()->subMonths(11)->startOfMonth();
    $crudos = Seguimiento::where('created_at', '>=', $desde)
      ->select(
        DB::raw("DATE_FORMAT(created_at, '%Y-%m') as periodo"),
        DB::raw('COUNT(*) as total')
      )
      ->groupBy('periodo')
      ->pluck('total', 'periodo');

    $meses = ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'];
    $serviciosPorMes = [];
    for ($i = 11; $i >= 0; $i--) {
      $fecha = Carbon::now()->subMonths($i);
      $clave = $fecha->format('Y-m');
      $serviciosPorMes[] = [
        'mes' => $meses[$fecha->month - 1] . ' ' . $fecha->format('y'),
        'total' => (int) ($crudos[$clave] ?? 0),
      ];
    }

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

    /* ---------- Top plagas / especies detectadas (últimos 90 días) ---------- */
    // Las especies se capturan por trampa en trampa_especie_seguimientos (cantidad = ejemplares).
    $topEspecies = DB::table('trampa_especie_seguimientos')
      ->join('especies', 'especies.id', '=', 'trampa_especie_seguimientos.especie_id')
      ->where('trampa_especie_seguimientos.created_at', '>=', Carbon::now()->subDays(90))
      ->select('especies.nombre', DB::raw('SUM(trampa_especie_seguimientos.cantidad) as total'))
      ->groupBy('especies.id', 'especies.nombre')
      ->orderByDesc('total')
      ->limit(6)
      ->get()
      ->map(fn($r) => ['nombre' => $r->nombre, 'total' => (int) $r->total])
      ->values();

    /* ---------- Próximas visitas (cronograma pendiente) ---------- */
    $proximasVisitas = Cronograma::with(['empresa:id,nombre', 'almacen:id,nombre', 'tipo_seguimiento:id,nombre'])
      ->leftJoin('users', 'users.id', '=', 'cronogramas.tecnico_id')
      ->where('cronogramas.status', 'pendiente')
      ->whereDate('cronogramas.date', '>=', $hoy)
      ->orderBy('cronogramas.date')
      ->limit(8)
      ->select('cronogramas.*', 'users.name as tecnico')
      ->get()
      ->map(fn($c) => [
        'id' => $c->id,
        'title' => $c->title,
        'date' => $c->date,
        'empresa' => $c->empresa?->nombre,
        'almacen' => $c->almacen?->nombre,
        'tipo' => $c->tipo_seguimiento?->nombre,
        'tecnico' => $c->tecnico,
      ]);

    return inertia('dashboard', [
      'stats' => [
        'serviciosHoy' => $serviciosHoy,
        'serviciosAyer' => $serviciosAyer,
        'serviciosMes' => $serviciosMes,
        'serviciosMesAnterior' => $serviciosMesAnterior,
        'cronogramaPendiente' => $cronogramaPendiente,
        'cronogramaPostergado' => $cronogramaPostergado,
        'roedoresCapturados' => $roedoresCapturados,
        'roedoresCapturadosPrev' => $roedoresCapturadosPrev,
      ],
      'serviciosPorMes' => $serviciosPorMes,
      'cumplimientoCronograma' => $cumplimientoCronograma,
      'topEspecies' => $topEspecies,
      'proximasVisitas' => $proximasVisitas,
    ]);
  }
}
