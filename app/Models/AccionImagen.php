<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class AccionImagen extends Model
{

    protected $table = 'accion_imagenes';

    protected $guarded = [];

    public function accion()
    {
        return $this->belongsTo(Accion::class);
    }
}
