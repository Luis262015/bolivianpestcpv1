<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Certificado extends Model
{
    protected $guarded = [];

    public function empresa()
    {
        return $this->belongsTo(Empresa::class);
    }
}
