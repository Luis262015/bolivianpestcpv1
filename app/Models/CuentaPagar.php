<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class CuentaPagar extends Model
{
    protected $table = 'cuentas_pagar';

    protected $guarded = [];

    public function proveedor()
    {
        return $this->belongsTo(Proveedor::class);
    }

    public function cuotas()
    {
        return $this->hasMany(PagarCuota::class);
    }
}
