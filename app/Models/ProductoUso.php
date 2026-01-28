<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ProductoUso extends Model
{
    protected $guarded = [];

    public function producto()
    {
        return $this->belongsTo(Producto::class);
    }

    public function unidad()
    {
        return $this->belongsTo(Unidad::class);
    }
}
