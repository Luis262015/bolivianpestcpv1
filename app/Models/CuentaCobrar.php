<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class CuentaCobrar extends Model
{
    protected $table = 'cuentas_cobrar';

    public function cuotas()
    {
        return $this->hasMany(CobrarCuota::class);
    }
}
