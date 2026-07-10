<?php

declare(strict_types=1);

namespace App\Services;

use App\Models\ProductoVencimiento;
use App\Models\User;
use Carbon\Carbon;

/**
 * Construye las alertas de vencimiento de productos: lotes
 * (`producto_vencimientos`) ya VENCIDOS (recientes) o POR VENCER (próximos N
 * días). Es inventario interno, así que solo se notifica a staff (no clientes).
 *
 * El cacheo y la mezcla con otras fuentes viven en {@see Notificaciones}.
 */
final class ProductoVencimientoNotificaciones
{
    /** Días hacia adelante que se consideran "por vencer". */
    private const DIAS_PROXIMOS = 30;

    /** Ventana hacia atrás, para no arrastrar lotes vencidos muy antiguos. */
    private const DIAS_VENCIDOS = 60;

    /** Máximo de alertas de esta fuente. */
    private const LIMITE = 12;

    /**
     * Alertas de vencimiento de lotes para el usuario dado (vacío para clientes).
     *
     * @return list<array<string, mixed>>
     */
    public function paraUsuario(User $user): array
    {
        // El inventario es interno; los clientes no lo gestionan.
        if ($user->hasRole('cliente')) {
            return [];
        }

        $hoy = Carbon::today();
        $desde = $hoy->copy()->subDays(self::DIAS_VENCIDOS);
        $hasta = $hoy->copy()->addDays(self::DIAS_PROXIMOS);

        return ProductoVencimiento::query()
            ->with('producto:id,nombre')
            ->whereBetween('vencimiento', [$desde->toDateString(), $hasta->toDateString()])
            ->orderBy('vencimiento')
            ->limit(self::LIMITE)
            ->get(['id', 'producto_id', 'codigo', 'vencimiento'])
            ->map(fn (ProductoVencimiento $v): array => $this->aNotificacion($v, $hoy))
            ->all();
    }

    /**
     * @return array<string, mixed>
     */
    private function aNotificacion(ProductoVencimiento $v, Carbon $hoy): array
    {
        $fecha = Carbon::parse($v->vencimiento)->startOfDay();
        // Signo: <0 vencido, 0 vence hoy, >0 por vencer.
        $dias = $hoy->diffInDays($fecha, false);
        $fechaCorta = $fecha->locale('es')->isoFormat('D MMM');

        [$tono, $tiempo] = match (true) {
            $dias < 0 => ['danger', 'Vencido · ' . $fechaCorta . ' · hace ' . abs($dias) . ' ' . (abs($dias) === 1 ? 'día' : 'días')],
            $dias === 0 => ['danger', 'Vence hoy · ' . $fechaCorta],
            $dias === 1 => ['warning', 'Vence mañana · ' . $fechaCorta],
            default => ['warning', "Vence en {$dias} días · {$fechaCorta}"],
        };

        $lote = $v->codigo ? "Lote {$v->codigo}" : 'Vencimiento de lote';

        return [
            'id' => "vencimiento-{$v->id}",
            'title' => $v->producto?->nombre ?? 'Producto',
            'description' => $lote,
            'time' => $tiempo,
            'href' => "/productos/{$v->producto_id}/vencimientos",
            'read' => false,
            'tone' => $tono,
            '_orden' => $dias,
        ];
    }
}
