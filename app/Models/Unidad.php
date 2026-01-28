<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Unidad extends Model
{
    protected $table = 'unidades';

    protected $guarded = [];

    public function productoUsos()
    {
        return $this->hasMany(ProductoUso::class);
    }
}
