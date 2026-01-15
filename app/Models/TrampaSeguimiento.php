<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class TrampaSeguimiento extends Model
{
    //
    protected $guarded = [];

    public function trampaEspeciesSeguimientos()
    {
        return $this->hasMany(TrampaEspecieSeguimiento::class)->with('especie');
    }

    public function trampaRoedoresSeguimientos()
    {
        return $this->hasMany(TrampaRoedorSeguimiento::class);
    }

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function almacen()
    {
        return $this->belongsTo(Almacen::class);
    }
}
