<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Contrato extends Model
{
    //
    protected $guarded = [];

    public function detalles(): HasMany
    {
        return $this->hasMany(ContratoDetalles::class);
    }
}
