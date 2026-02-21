<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Cronograma extends Model
{
    protected $guarded = [];

    public function empresa()
    {
        return $this->belongsTo(Empresa::class);
    }

    public function almacen()
    {
        return $this->belongsTo(Almacen::class);
    }

    public function tipo_seguimiento()
    {
        return $this->belongsTo(TipoSeguimiento::class);
    }
}
