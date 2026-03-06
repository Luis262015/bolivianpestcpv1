<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Accion extends Model
{
    protected $table = 'acciones';

    protected $guarded = [];

    public function empresa()
    {
        return $this->belongsTo(Empresa::class);
    }

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function almacen()
    {
        return $this->belongsTo(Almacen::class);
    }

    public function accionTrampas()
    {
        return $this->hasMany(AccionTrampa::class);
    }

    public function accionProductos()
    {
        return $this->hasMany(AccionProducto::class);
    }

    public function imagenes()
    {
        return $this->hasMany(AccionImagen::class);
    }
}
