<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Metodo extends Model
{
    //
    protected $guarded = [];

    public function seguimientos()
    {
        return $this->belongsToMany(
            Seguimiento::class,
            'seguimiento_metodos',
            'metodo_id',
            'seguimiento_id'
        );
    }
}
