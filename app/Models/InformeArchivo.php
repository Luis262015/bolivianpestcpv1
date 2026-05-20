<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class InformeArchivo extends Model
{
    protected $fillable = ['empresa_id', 'user_id', 'nombre_original', 'ruta'];

    public function empresa()
    {
        return $this->belongsTo(Empresa::class);
    }

    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
