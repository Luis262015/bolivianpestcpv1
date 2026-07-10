<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ProductoVencimiento extends Model
{
    protected $guarded = [];

    public function producto()
    {
        return $this->belongsTo(Producto::class);
    }
}