<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Storage;

class Documento extends Model
{
    //
    protected $guarded = [];

    // Accessor para URL pública
    public function getUrlAttribute(): string
    {
        return Storage::url($this->ruta);
    }
}
