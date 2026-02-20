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
     * Accesor para obtener los textos del mapa
     */
    public function getTextsAttribute(): array
    {
        return $this->data['texts'] ?? [];
    }

    /**
     * Accesor para obtener las trampas del mapa
     */
    public function getTrapsAttribute(): array
    {
        return $this->data['traps'] ?? [];
    }

    /**
     * Mutador para actualizar los textos (ejemplo de uso: $mapa->texts = [...])
     */
    public function setTextsAttribute(array $texts): void
    {
        $data = $this->data ?? [];
        $data['texts'] = $texts;
        $this->data = $data;
    }

    /**
     * Mutador para actualizar las trampas
     */
    public function setTrapsAttribute(array $traps): void
    {
        $data = $this->data ?? [];
        $data['traps'] = $traps;
        $this->data = $data;
    }

    public function trampas()
    {
        return $this->hasMany(Trampa::class);
    }
}
