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
}
