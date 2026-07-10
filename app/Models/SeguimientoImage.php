<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class SeguimientoImage extends Model
{
    protected $guarded = [];

    public function seguimiento(): BelongsTo
    {
        return $this->belongsTo(Seguimiento::class);
    }
}
