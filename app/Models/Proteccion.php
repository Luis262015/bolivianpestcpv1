<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Proteccion extends Model
{
    //
    protected $table = 'protecciones';
    protected $guarded = [];

    public function seguimientos()
    {
        return $this->belongsToMany(
            Seguimiento::class,
            'seguimiento_proteccions',
            'proteccion_id',
            'seguimiento_id'
        );
    }
}
