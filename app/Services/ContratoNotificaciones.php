<?php

declare(strict_types=1);

namespace App\Services;

use App\Models\Contrato;
use App\Models\User;
use Carbon\Carbon;

/**
 * Construye las alertas de vencimiento de contratos para la campana: contratos
 * ya VENCIDOS (recientes) y POR VENCER (próximos N días). Solo para
 * admin/superadmin, ya que la sección de contratos es exclusiva de esos roles.
 *
 * El cacheo y la mezcla con otras fuentes viven en {@see Notificaciones}.
 */
final class ContratoNotificaciones
{
    /** Días hacia adelante que se consideran "por vencer" (renovación). */
    private const DIAS_PROXIMOS = 30;

    /** Ventana hacia atrás, para no arrastrar contratos vencidos muy antiguos. */
    private const DIAS_VENCIDOS = 60;

    /** Máximo de alertas de esta fuente. */
    private const LIMITE = 12;

    /**
     * Alertas de contratos para el usuario dado (vacío si no es staff).
     *
     * @return list<array<string, mixed>>
     */
    public function paraUsuario(User $user): array
    {
        // Contratos es admin-only: no notificar a quien no puede verlos.
        if (! $user->hasAnyRole(['admin', 'superadmin'])) {
            return [];
        }

        $hoy = Carbon::today();
        $desde = $hoy->copy()->subDays(self::DIAS_VENCIDOS);
        $hasta = $hoy->copy()->addDays(self::DIAS_PROXIMOS);

        return Contrato::query()
            ->with('empresa:id,nombre')
            ->whereBetween('expiracion', [$desde->toDateString(), $hasta->toDateString()])
            ->orderBy('expiracion')
            ->limit(self::LIMITE)
            ->get(['id', 'empresa_id', 'total', 'expiracion'])
            ->map(fn (Contrato $c): array => $this->aNotificacion($c, $hoy))
            ->all();
    }

    /**
     * @return array<string, mixed>
     */
    private function aNotificacion(Contrato $c, Carbon $hoy): array
    {
        $fecha = Carbon::parse($c->expiracion)->startOfDay();
        // Signo: <0 vencido, 0 vence hoy, >0 por vencer.
        $dias = $hoy->diffInDays($fecha, false);
        $fechaCorta = $fecha->locale('es')->isoFormat('D MMM');

        [$tono, $tiempo] = match (true) {
            $dias < 0 => ['danger', 'Vencido · ' . $fechaCorta . ' · hace ' . abs($dias) . ' ' . (abs($dias) === 1 ? 'día' : 'días')],
            $dias === 0 => ['danger', 'Vence hoy · ' . $fechaCorta],
            $dias === 1 => ['warning', 'Vence mañana · ' . $fechaCorta],
            default => ['warning', "Vence en {$dias} días · {$fechaCorta}"],
        };

        $monto = 'Bs. ' . number_format((float) $c->total, 0, ',', '.');

        return [
            'id' => "contrato-{$c->id}",
            'title' => $c->empresa?->nombre ?? 'Contrato',
            'description' => 'Contrato · ' . $monto,
            'time' => $tiempo,
            'href' => '/contratos',
            'read' => false,
            'tone' => $tono,
            '_orden' => $dias,
        ];
    }
}
