<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class AccionTrampa extends Model
{
    protected $guarded = [];

    public function tipo()
    {
        return $this->belongsTo(TrampaTipo::class);
    }

    public function trampa()
    {
        return $this->belongsTo(Trampa::class);
    }
}
