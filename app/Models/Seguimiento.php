<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Seguimiento extends Model
{
    //
    protected $guarded = [];

    public function empresa()
    {
        return $this->belongsTo(Empresa::class);
    }

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function almacen(): BelongsTo
    {
        return $this->belongsTo(Almacen::class);
    }

    public function aplicacion()
    {
        return $this->hasOne(Aplicacion::class);
    }

    public function biologicos()
    {
        return $this->belongsToMany(
            Biologico::class,
            'seguimiento_biologicos', // ← AQUÍ ESPECIFICAMOS TU TABLA
            'seguimiento_id',
            'biologico_id'
        );
    }
    public function epps()
    {
        return $this->belongsToMany(
            Epp::class,
            'seguimiento_epps', // ← AQUÍ ESPECIFICAMOS TU TABLA
            'seguimiento_id',
            'epp_id'
        );
    }
    public function metodos()
    {
        return $this->belongsToMany(
            Metodo::class,
            'seguimiento_metodos', // ← AQUÍ ESPECIFICAMOS TU TABLA
            'seguimiento_id',
            'metodo_id'
        );
    }
    public function proteccions()
    {
        return $this->belongsToMany(
            Proteccion::class,
            'seguimiento_protecciones', // ← AQUÍ ESPECIFICAMOS TU TABLA
            'seguimiento_id',
            'proteccion_id'
        );
    }
    public function signos()
    {
        return $this->belongsToMany(
            Signo::class,
            'seguimiento_signos', // ← AQUÍ ESPECIFICAMOS TU TABLA
            'seguimiento_id',
            'signo_id'
        );
    }

    public function especies()
    {
        return $this->belongsToMany(
            Especie::class,
            'seguimiento_especies', // ← AQUÍ ESPECIFICAMOS TU TABLA
            'seguimiento_id',
            'especie_id'
        );
    }

    public function tipoSeguimiento()
    {
        return $this->belongsTo(TipoSeguimiento::class);
    }

    public function images()
    {
        return $this->hasMany(SeguimientoImage::class);
    }

    public function productoUsos()
    {
        return $this->hasMany(ProductoUso::class);
    }

    public function roedores()
    {
        return $this->hasMany(TrampaRoedorSeguimiento::class);
    }

    public function insectocutores()
    {
        return $this->hasMany(TrampaEspecieSeguimiento::class);
    }

    public function trampaEspeciesSeguimientos()
    {
        return $this->hasMany(TrampaEspecieSeguimiento::class);
    }

    public function trampaRoedoresSeguimientos()
    {
        return $this->hasMany(TrampaRoedorSeguimiento::class);
    }
}
