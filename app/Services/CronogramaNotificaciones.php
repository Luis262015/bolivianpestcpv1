<?php

declare(strict_types=1);

namespace App\Services;

use App\Models\Cronograma;
use App\Models\User;
use Carbon\Carbon;

/**
 * Construye las alertas de cronograma para la campana de notificaciones:
 * visitas VENCIDAS (pendientes/postergadas con fecha pasada) y PRÓXIMAS
 * (hoy + N días). No persiste nada: son alertas en vivo derivadas del
 * cronograma, con el mismo contrato que el componente `NotificationsMenu`.
 *
 * El cacheo y la mezcla con otras fuentes viven en {@see Notificaciones}.
 */
final class CronogramaNotificaciones
{
    /** Días hacia adelante que se consideran "próximas". */
    private const DIAS_PROXIMOS = 3;

    /** Ventana hacia atrás, para no arrastrar pendientes muy antiguos. */
    private const DIAS_VENCIDAS = 30;

    /** Máximo de alertas de esta fuente. */
    private const LIMITE = 12;

    /**
     * Alertas para el usuario dado.
     *
     * @return list<array<string, mixed>>
     */
    public function paraUsuario(User $user): array
    {
        // Cliente: solo sus empresas. Staff (admin/tecnico/…): global (null).
        $empresaIds = $user->hasRole('cliente')
            ? $user->empresas()->pluck('empresas.id')->all()
            : null;

        return $this->construir($empresaIds);
    }

    /**
     * @param  array<int>|null  $empresaIds  null = sin acotar (staff)
     * @return list<array<string, mixed>>
     */
    private function construir(?array $empresaIds): array
    {
        $hoy = Carbon::today();
        $desde = $hoy->copy()->subDays(self::DIAS_VENCIDAS);
        $hasta = $hoy->copy()->addDays(self::DIAS_PROXIMOS);

        return Cronograma::query()
            ->with([
                'empresa:id,nombre',
                'almacen:id,nombre',
                'tipo_seguimiento:id,nombre',
            ])
            ->whereIn('status', ['pendiente', 'postergado'])
            ->whereBetween('date', [$desde->toDateString(), $hasta->toDateString()])
            ->when($empresaIds !== null, fn ($q) => $q->whereIn('empresa_id', $empresaIds))
            ->orderBy('date')
            ->limit(self::LIMITE)
            ->get()
            ->map(fn (Cronograma $c): array => $this->aNotificacion($c, $hoy))
            ->all();
    }

    /**
     * Convierte un cronograma en un ítem de notificación del front.
     *
     * @return array<string, mixed>
     */
    private function aNotificacion(Cronograma $c, Carbon $hoy): array
    {
        $fecha = Carbon::parse($c->date)->startOfDay();
        // Signo: <0 vencida, 0 hoy, >0 próxima.
        $dias = $hoy->diffInDays($fecha, false);
        // Fecha absoluta en español, p. ej. "10 jun", para señalar el registro.
        $fechaCorta = $fecha->locale('es')->isoFormat('D MMM');

        [$tono, $tiempo] = match (true) {
            $dias < 0 => ['danger', 'Vencida · ' . $fechaCorta . ' · hace ' . abs($dias) . ' ' . (abs($dias) === 1 ? 'día' : 'días')],
            $dias === 0 => ['warning', 'Hoy · ' . $fechaCorta],
            $dias === 1 => ['default', 'Mañana · ' . $fechaCorta],
            default => ['default', "En {$dias} días · {$fechaCorta}"],
        };

        $detalle = collect([$c->almacen?->nombre, $c->tipo_seguimiento?->nombre])
            ->filter()
            ->implode(' · ');

        // Link directo al registro: filtra el calendario por su almacén (así se
        // cargan sus tareas) y `focus` le indica cuál abrir/resaltar. Sin
        // almacén, cae a la vista global igualmente enfocada.
        $href = $c->almacen_id
            ? "/cronogramas?almacen_id={$c->almacen_id}&focus={$c->id}"
            : "/cronogramas?ver_todas=1&focus={$c->id}";

        return [
            // Prefijo para no colisionar con ids de otras fuentes al mezclar.
            'id' => "cronograma-{$c->id}",
            'title' => $c->empresa?->nombre ?? $c->title ?? 'Visita de cronograma',
            'description' => $detalle ?: null,
            'time' => $tiempo,
            'href' => $href,
            'read' => false,
            'tone' => $tono,
            // Clave de orden (se elimina en el agregador): más vencido primero.
            '_orden' => $dias,
        ];
    }
}
