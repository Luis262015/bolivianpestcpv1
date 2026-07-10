<?php

declare(strict_types=1);

namespace App\Services;

use App\Models\Agenda;
use App\Models\User;
use Carbon\Carbon;

/**
 * Construye las alertas de la agenda personal para la campana: tareas
 * VENCIDAS (pendientes/postergadas con fecha pasada) y PRÓXIMAS (hoy + N días),
 * acotadas al propio usuario. Mismo contrato que `NotificationsMenu`.
 *
 * El cacheo y la mezcla con otras fuentes viven en {@see Notificaciones}.
 */
final class AgendaNotificaciones
{
    /** Días hacia adelante que se consideran "próximas". */
    private const DIAS_PROXIMOS = 3;

    /** Ventana hacia atrás, para no arrastrar pendientes muy antiguos. */
    private const DIAS_VENCIDAS = 30;

    /** Máximo de alertas de esta fuente. */
    private const LIMITE = 12;

    /**
     * Alertas de agenda del usuario dado.
     *
     * @return list<array<string, mixed>>
     */
    public function paraUsuario(User $user): array
    {
        $hoy = Carbon::today();
        $desde = $hoy->copy()->subDays(self::DIAS_VENCIDAS);
        $hasta = $hoy->copy()->addDays(self::DIAS_PROXIMOS);

        return Agenda::query()
            ->where('user_id', $user->id)
            ->whereIn('status', ['pendiente', 'postergado'])
            ->whereBetween('date', [$desde->toDateString(), $hasta->toDateString()])
            ->orderBy('date')
            ->limit(self::LIMITE)
            ->get(['id', 'title', 'date', 'hour', 'status'])
            ->map(fn (Agenda $a): array => $this->aNotificacion($a, $hoy))
            ->all();
    }

    /**
     * @return array<string, mixed>
     */
    private function aNotificacion(Agenda $a, Carbon $hoy): array
    {
        $fecha = Carbon::parse($a->date)->startOfDay();
        // Signo: <0 vencida, 0 hoy, >0 próxima.
        $dias = $hoy->diffInDays($fecha, false);
        $fechaCorta = $fecha->locale('es')->isoFormat('D MMM');

        [$tono, $tiempo] = match (true) {
            $dias < 0 => ['danger', 'Vencida · ' . $fechaCorta . ' · hace ' . abs($dias) . ' ' . (abs($dias) === 1 ? 'día' : 'días')],
            $dias === 0 => ['warning', 'Hoy · ' . $fechaCorta],
            $dias === 1 => ['default', 'Mañana · ' . $fechaCorta],
            default => ['default', "En {$dias} días · {$fechaCorta}"],
        };

        // Etiqueta "Agenda" (+ hora si existe) para distinguirla en la lista.
        $hora = $a->hour ? Carbon::parse($a->hour)->format('H:i') : null;
        $detalle = collect(['Agenda', $hora])->filter()->implode(' · ');

        return [
            'id' => "agenda-{$a->id}",
            'title' => $a->title ?: 'Tarea de agenda',
            'description' => $detalle,
            'time' => $tiempo,
            'href' => "/agendas?focus={$a->id}",
            'read' => false,
            'tone' => $tono,
            '_orden' => $dias,
        ];
    }
}
