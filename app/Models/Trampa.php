<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Trampa extends Model
{
    protected $guarded = [];

    public function trampa_tipo()
    {
        return $this->belongsTo(TrampaTipo::class);
    }

    public function almacen()
    {
        return $this->belongsTo(Almacen::class);
    }
}