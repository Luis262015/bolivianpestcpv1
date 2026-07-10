<?php

declare(strict_types=1);

namespace App\Services;

use App\Models\Producto;
use App\Models\User;

/**
 * Construye las alertas de stock bajo: productos cuyo `stock` cayó a/bajo su
 * `stock_min`. Es inventario interno de la empresa, no del cliente, así que
 * solo se notifica a staff (no clientes).
 *
 * A diferencia de las otras fuentes no hay fecha: la urgencia (`_orden`) es el
 * déficit `stock - stock_min` (más negativo = más agotado = más urgente), que
 * interleava de forma natural con las alertas por fecha.
 *
 * El cacheo y la mezcla con otras fuentes viven en {@see Notificaciones}.
 */
final class ProductoNotificaciones
{
    /** Máximo de alertas de esta fuente. */
    private const LIMITE = 12;

    /**
     * Alertas de stock bajo para el usuario dado (vacío para clientes).
     *
     * @return list<array<string, mixed>>
     */
    public function paraUsuario(User $user): array
    {
        // El stock es interno; los clientes no gestionan inventario.
        if ($user->hasRole('cliente')) {
            return [];
        }

        return Producto::query()
            ->whereNotNull('stock')
            ->whereColumn('stock', '<=', 'stock_min')
            ->orderByRaw('stock - stock_min') // más agotado primero
            ->limit(self::LIMITE)
            ->get(['id', 'nombre', 'stock', 'stock_min'])
            ->map(fn (Producto $p): array => $this->aNotificacion($p))
            ->all();
    }

    /**
     * @return array<string, mixed>
     */
    private function aNotificacion(Producto $p): array
    {
        $stock = (int) $p->stock;
        $min = (int) $p->stock_min;
        $agotado = $stock <= 0;
        // Mostrar 0 si el stock quedó negativo (dato de sobreconsumo).
        $mostrado = max(0, $stock);

        return [
            'id' => "producto-{$p->id}",
            'title' => $p->nombre ?: 'Producto',
            'description' => "Quedan {$mostrado} · mín. {$min}",
            'time' => $agotado ? 'Sin stock' : 'Stock bajo',
            'href' => '/productos',
            'read' => false,
            'tone' => $agotado ? 'danger' : 'warning',
            '_orden' => $stock - $min, // déficit: más negativo = más urgente
        ];
    }
}
