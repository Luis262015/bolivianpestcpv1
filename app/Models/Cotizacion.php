<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Cotizacion extends Model
{
    //
    protected $table = 'cotizaciones';
    protected $guarded = [];

    public function detalles(): HasMany
    {
        return $this->hasMany(CotizacionDetalles::class);
    }
}
