<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class TrampaRoedorSeguimiento extends Model
{
    //
    protected $guarded = [];

    public function trampa()
    {
        return $this->belongsTo(Trampa::class);
    }

    public function seguimiento()
    {
        return $this->belongsTo(Seguimiento::class);
    }
}
