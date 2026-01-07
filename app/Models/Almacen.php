<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Almacen extends Model
{
    protected $table = 'almacenes';
    protected $guarded = [];

    public function almacenTrampa()
    {
        return $this->hasOne(AlmacenTrampa::class);
    }

    public function almacenArea()
    {
        return $this->hasOne(AlmacenArea::class);
    }

    public function almacenInsectocutor()
    {
        return $this->hasOne(AlmancenInsectocutor::class);
    }
}
