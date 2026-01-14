<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Auth;

class Agenda extends Model
{
    //
    protected $fillable = [
        'user_id',
        'title',
        'date',
        'hour',
        'color',
        'status',
    ];

    protected $casts = [
        'date' => 'date:Y-m-d',
        'status' => 'string',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    // Scope para tareas del usuario autenticado
    public function scopeMine($query)
    {
        return $query->where('user_id', Auth::id());
    }
}
