<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;


class CotizacionDetalles extends Model
{
    //
    protected $guarded = [];

    protected $casts = [
        'area' => 'decimal:2',
        'precio_unitario' => 'decimal:2',
        'total' => 'decimal:2',
    ];

    public function cotizacion(): BelongsTo
    {
        return $this->belongsTo(Cotizacion::class);
    }
}
