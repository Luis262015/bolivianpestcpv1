<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Empresa extends Model
{
    //
    protected $guarded = [];

    public function almacenes()
    {
        return $this->hasMany(Almacen::class);
    }

    public function certificados()
    {
        return $this->hasMany(Certificado::class);
    }
    public function users()
    {
        return $this->belongsToMany(User::class, 'usuario_empresa', 'empresa_id', 'user_id');
    }
}
