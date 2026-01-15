<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class TrampaEspecieSeguimiento extends Model
{
    protected $guarded = [];

    public function especie()
    {
        return $this->belongsTo(Especie::class);
    }
}
