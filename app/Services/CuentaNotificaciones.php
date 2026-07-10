<?php

declare(strict_types=1);

namespace App\Services;

use App\Models\CuentaCobrar;
use App\Models\CuentaPagar;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Model;

/**
 * Alertas de cuentas por cobrar y por pagar. Combina dos disparadores:
 *  - Por vencimiento: usando la próxima cuota pendiente (plan de pagos) o la
 *    `fecha_pago` de la cuenta → vencidas y próximas, con urgencia por fecha.
 *  - Saldos pendientes sin fecha: recordatorio de menor prioridad.
 *
 * Contabilidad es admin-only, así que solo se notifica a admin/superadmin.
 * El cacheo y la mezcla con otras fuentes viven en {@see Notificaciones}.
 */
final class CuentaNotificaciones
{
    /** Días hacia adelante que se consideran "por vencer". */
    private const DIAS_HORIZONTE = 15;

    /** Urgencia asignada a un pendiente sin fecha (≈ "atender este mes"). */
    private const ORDEN_SIN_FECHA = 30;

    /** Máximo de alertas de esta fuente. */
    private const LIMITE = 12;

    /**
     * @return list<array<string, mixed>>
     */
    public function paraUsuario(User $user): array
    {
        if (! $user->hasAnyRole(['admin', 'superadmin'])) {
            return [];
        }

        $hoy = Carbon::today();

        $items = array_merge(
            $this->cuentas(CuentaCobrar::query(), 'cobrar', '/cuentasporcobrar', 'Por cobrar', $hoy),
            $this->cuentas(CuentaPagar::query(), 'pagar', '/cuentasporpagar', 'Por pagar', $hoy),
        );

        usort($items, static fn (array $a, array $b): int => $a['_orden'] <=> $b['_orden']);

        return array_slice($items, 0, self::LIMITE);
    }

    /**
     * @param  Builder<Model>  $query
     * @return list<array<string, mixed>>
     */
    private function cuentas(Builder $query, string $tipo, string $href, string $etiqueta, Carbon $hoy): array
    {
        return $query
            ->where('estado', 'Pendiente')
            ->where('saldo', '>', 0)
            // Próxima cuota pendiente (si hay plan de pagos); null en otro caso.
            ->withMin(
                ['cuotas as proxima_cuota' => fn ($q) => $q->whereIn('estado', ['pendiente', 'vencido'])],
                'fecha_vencimiento',
            )
            ->limit(200)
            ->get()
            ->map(fn (Model $c): array => $this->aNotificacion($c, $tipo, $href, $etiqueta, $hoy))
            ->all();
    }

    /**
     * @return array<string, mixed>
     */
    private function aNotificacion(Model $c, string $tipo, string $href, string $etiqueta, Carbon $hoy): array
    {
        $due = $c->proxima_cuota ?? $c->fecha_pago;
        $monto = 'Bs. ' . number_format((float) $c->saldo, 0, ',', '.');

        if ($due !== null) {
            $fecha = Carbon::parse($due)->startOfDay();
            $dias = $hoy->diffInDays($fecha, false);
            $fechaCorta = $fecha->locale('es')->isoFormat('D MMM');
            $orden = $dias;

            [$tono, $tiempo] = match (true) {
                $dias < 0 => ['danger', 'Vencida · ' . $fechaCorta . ' · hace ' . abs($dias) . ' ' . (abs($dias) === 1 ? 'día' : 'días')],
                $dias === 0 => ['danger', 'Vence hoy · ' . $fechaCorta],
                $dias === 1 => ['warning', 'Vence mañana · ' . $fechaCorta],
                $dias <= self::DIAS_HORIZONTE => ['warning', "Vence en {$dias} días · {$fechaCorta}"],
                // Con fecha pero lejana: recordatorio de baja prioridad.
                default => ['default', 'Vence ' . $fechaCorta],
            };
        } else {
            [$tono, $tiempo, $orden] = ['default', 'Pendiente', self::ORDEN_SIN_FECHA];
        }

        return [
            'id' => "{$tipo}-{$c->id}",
            'title' => $c->concepto ?: ($tipo === 'cobrar' ? 'Cuenta por cobrar' : 'Cuenta por pagar'),
            'description' => "{$etiqueta} · {$monto}",
            'time' => $tiempo,
            'href' => $href,
            'read' => false,
            'tone' => $tono,
            '_orden' => $orden,
        ];
    }
}
