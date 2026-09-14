<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Casts\Attribute;
use Illuminate\Database\Eloquent\Model;

class Certificado extends Model
{
    protected $guarded = [];

    /**
     * El listado de empresas muestra cuándo se emitió cada certificado. Se
     * formatea en el servidor para que la hora salga siempre en la zona de
     * la aplicación (America/La_Paz) y no en la del navegador del cliente.
     */
    protected $appends = ['fecha_hora'];

    protected function fechaHora(): Attribute
    {
        return Attribute::get(
            fn (): ?string => $this->created_at?->format('d/m/Y H:i')
        );
    }

    public function empresa()
    {
        return $this->belongsTo(Empresa::class);
    }
}
