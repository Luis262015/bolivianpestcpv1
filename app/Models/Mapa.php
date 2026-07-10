<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Mapa extends Model
{
    protected $guarded = [];

    use HasFactory;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'empresa_id',
        'almacen_id',
        'user_id',
        'data',
        'titulo',
        'background',
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'data' => 'array',         // Convierte automáticamente el JSON a array al acceder
        'created_at' => 'datetime',
        'updated_at' => 'datetime',
    ];


    public function empresa()
    {
        return $this->belongsTo(Empresa::class);
    }

    /**
     * Relación con el almacén
     */
    public function almacen(): BelongsTo
    {
        return $this->belongsTo(Almacen::class);
    }

    /**
     * Textos del mapa. `data` históricamente guarda solo el tamaño de trampa
     * (entero), por eso se tolera que no sea array.
     */
    public function getTextsAttribute(): array
    {
        return is_array($this->data) ? ($this->data['texts'] ?? []) : [];
    }

    /**
     * Tamaño de trampa guardado en `data`.
     */
    public function getTrapSizeAttribute(): int
    {
        return is_array($this->data)
            ? (int) ($this->data['trapSize'] ?? 20)
            : (int) ($this->data ?? 20);
    }

    public function trampas()
    {
        return $this->hasMany(Trampa::class);
    }
}
