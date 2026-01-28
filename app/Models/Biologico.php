<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Biologico extends Model
{
    protected $guarded = [];

    public function seguimientos()
    {
        return $this->belongsToMany(
            Seguimiento::class,
            'seguimiento_biologicos',
            'biologico_id',
            'seguimiento_id'
        );
    }
}
