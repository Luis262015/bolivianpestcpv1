<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Producto extends Model
{
    //
    protected $guarded = [];

    public function categoria()
    {
        return $this->belongsTo(Categoria::class);
    }

    public function subcategoria()
    {
        return $this->belongsTo(Subcategoria::class);
    }

    public function marca()
    {
        return $this->belongsTo(Marca::class);
    }

    public function etiquetas()
    {
        return $this->belongsToMany(
            Etiqueta::class,
            'etiqueta_productos', // ← AQUÍ ESPECIFICAMOS TU TABLA
            'producto_id',
            'etiqueta_id'
        );
    }
}
