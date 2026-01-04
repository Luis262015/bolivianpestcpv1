<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Almacen extends Model
{
    protected $table = 'almacenes';
    protected $guarded = [];

    public function almacenesTrampa()
    {
        return $this->hasMany(AlmacenTrampa::class);
    }

    public function almacenesAreas()
    {
        return $this->hasMany(AlmacenArea::class);
    }

    public function almacenInsectocutores()
    {
        return $this->hasMany(AlmancenInsectocutor::class);
    }
}
