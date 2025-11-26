<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Categoria extends Model
{
    //
    protected $guarded = [];

    public function subcategorias()
    {
        return $this->hasMany(Subcategoria::class);
    }
}