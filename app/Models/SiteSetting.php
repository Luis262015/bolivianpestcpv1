<?php

declare(strict_types=1);

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class SiteSetting extends Model
{
    protected $fillable = [
        'key',
        'value',
        'type',
        'group',
        'label',
        'order',
    ];

    /**
     * Mapa plano key => valor (los tipos json se decodifican) para consumir
     * en el landing. Pensado para usarse en una sola consulta.
     *
     * @return array<string, mixed>
     */
    public static function map(): array
    {
        return static::query()
            ->orderBy('order')
            ->get()
            ->mapWithKeys(function (SiteSetting $s): array {
                $value = $s->value;
                if ($s->type === 'json') {
                    $value = json_decode($s->value ?? 'null', true);
                }
                return [$s->key => $value];
            })
            ->toArray();
    }

    /**
     * Configuraciones agrupadas (con metadata) para el editor del admin.
     *
     * @return array<string, array<int, array<string, mixed>>>
     */
    public static function grouped(): array
    {
        return static::query()
            ->orderBy('group')
            ->orderBy('order')
            ->get()
            ->map(fn (SiteSetting $s): array => [
                'key'   => $s->key,
                'value' => $s->type === 'json' ? json_decode($s->value ?? 'null', true) : $s->value,
                'type'  => $s->type,
                'group' => $s->group,
                'label' => $s->label,
                'order' => $s->order,
            ])
            ->groupBy('group')
            ->toArray();
    }
}
