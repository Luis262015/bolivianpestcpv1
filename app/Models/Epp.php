<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Epp extends Model
{
    //
    protected $guarded = [];

    public function seguimientos()
    {
        return $this->belongsToMany(
            Seguimiento::class,
            'seguimiento_epps',
            'epp_id',
            'seguimiento_id'
        );
    }
}
