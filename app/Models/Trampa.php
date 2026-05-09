<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Trampa extends Model
{
    protected $guarded = [];

    public function trampa_tipo()
    {
        return $this->belongsTo(TrampaTipo::class);
    }

    public function almacen()
    {
        return $this->belongsTo(Almacen::class);
    }

    public function mapa()
    {
        return $this->belongsTo(Mapa::class);
    }

    public function especieSeguimientos()
    {
        return $this->hasMany(TrampaEspecieSeguimiento::class);
    }

    public function roedorSeguimientos()
    {
        return $this->hasMany(TrampaRoedorSeguimiento::class);
    }

    public function accionTrampas()
    {
        return $this->hasMany(AccionTrampa::class);
    }

    public function tieneDependencias(): bool
    {
        return $this->especieSeguimientos()->exists()
            || $this->roedorSeguimientos()->exists()
            || $this->accionTrampas()->exists();
    }
}
