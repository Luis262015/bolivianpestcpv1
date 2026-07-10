<?php

declare(strict_types=1);

namespace App\Services;

use App\Models\User;
use Illuminate\Support\Facades\Cache;

/**
 * Agregador de la campana de notificaciones: reúne las alertas de todas las
 * fuentes (cronograma, agenda, …), las ordena por urgencia y las cachea, para
 * que la campana del layout global no dispare consultas en cada navegación.
 *
 * Para sumar una fuente nueva basta con inyectar su builder y añadirlo al
 * `array_merge` de {@see construir()}.
 */
final class Notificaciones
{
    /** Máximo de notificaciones combinadas mostradas en la campana. */
    private const LIMITE = 20;

    /** Máximo por fuente, para que ninguna acapare la campana. */
    private const MAX_POR_FUENTE = 5;

    public function __construct(
        private readonly CronogramaNotificaciones $cronograma,
        private readonly AgendaNotificaciones $agenda,
        private readonly ContratoNotificaciones $contrato,
        private readonly ProductoNotificaciones $producto,
        private readonly ProductoVencimientoNotificaciones $productoVencimiento,
        private readonly CuentaNotificaciones $cuenta,
    ) {}

    /**
     * Notificaciones del usuario (cacheadas 60s).
     *
     * @return list<array<string, mixed>>
     */
    public function paraUsuario(User $user): array
    {
        return Cache::remember(
            "notif_{$user->id}",
            60,
            fn (): array => $this->construir($user),
        );
    }

    /**
     * @return list<array<string, mixed>>
     */
    private function construir(User $user): array
    {
        $items = array_merge(
            $this->cronograma->paraUsuario($user),
            $this->agenda->paraUsuario($user),
            $this->contrato->paraUsuario($user),
            $this->producto->paraUsuario($user),
            $this->productoVencimiento->paraUsuario($user),
            $this->cuenta->paraUsuario($user),
        );

        // Más urgente primero. `_orden` es una clave de urgencia genérica: días
        // con signo para fuentes por fecha (negativo = vencido), y déficit de
        // stock para productos. Menor = más urgente.
        usort($items, static fn (array $a, array $b): int => $a['_orden'] <=> $b['_orden']);

        // Se conservan los más urgentes, pero con tope por fuente para que una
        // sola (p. ej. agenda) no acapare la campana. La fuente se deduce del
        // prefijo del id ("cronograma-…", "agenda-…", "cobrar-…", …).
        $conteo = [];
        $resultado = [];

        foreach ($items as $n) {
            $fuente = explode('-', (string) $n['id'], 2)[0];

            if (($conteo[$fuente] ?? 0) >= self::MAX_POR_FUENTE) {
                continue;
            }

            $conteo[$fuente] = ($conteo[$fuente] ?? 0) + 1;
            unset($n['_orden']); // clave interna, no llega al front
            $resultado[] = $n;

            if (count($resultado) >= self::LIMITE) {
                break;
            }
        }

        return $resultado;
    }
}
