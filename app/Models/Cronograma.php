<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Cronograma extends Model
{
    protected $guarded = [];

    // Laravel castea sola la PK (id), pero no las FK: sin esto PDO las
    // devuelve como string en los hostings que usan prepares emuladas y las
    // comparaciones estrictas del front (task.user_id === u.id) fallan.
    // OJO: 'date' se deja sin castear a propósito; el front espera "Y-m-d".
    protected function casts(): array
    {
        return [
            'user_id' => 'integer',
            'tecnico_id' => 'integer',
            'empresa_id' => 'integer',
            'almacen_id' => 'integer',
            'tipo_seguimiento_id' => 'integer',
        ];
    }

    public function empresa()
    {
        return $this->belongsTo(Empresa::class);
    }

    public function almacen()
    {
        return $this->belongsTo(Almacen::class);
    }

    public function tipo_seguimiento()
    {
        return $this->belongsTo(TipoSeguimiento::class);
    }

    public function tecnico()
    {
        return $this->belongsTo(User::class, 'tecnico_id');
    }
}
