<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Signo extends Model
{
    //
    protected $guarded = [];

    public function seguimientos()
    {
        return $this->belongsToMany(
            Seguimiento::class,
            'seguimiento_signos',
            'signo_id',
            'seguimiento_id'
        );
    }
}
