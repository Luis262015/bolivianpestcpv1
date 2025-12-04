<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Empresa extends Model
{
    //
    protected $guarded = [];

    public function almacenes()
    {
        return $this->hasMany(Almacen::class);
    }
}
