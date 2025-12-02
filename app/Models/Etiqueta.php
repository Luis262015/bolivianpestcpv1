<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Etiqueta extends Model
{
    //
    protected $guarded = [];

    public function productos()
    {
        return $this->belongsToMany(
            Producto::class,
            'etiqueta_productos',
            'etiqueta_id',
            'producto_id'
        );
    }
}
