<?php

namespace Database\Seeders;

use App\Models\Almacen;
use App\Models\Empresa;
use Illuminate\Database\Seeder;

/**
 * Crea la empresa y el almacén reservados para trabajos ESPORÁDICOS
 * (servicios eventuales sin contrato). Es idempotente: se puede correr
 * varias veces sin duplicar registros.
 */
class EsporadicoSeeder extends Seeder
{
  public function run(): void
  {
    $empresa = Empresa::firstOrCreate(
      ['nombre' => config('esporadico.empresa')],
      [
        'direccion' => 'N/A',
        'telefono' => 'N/A',
        'email' => 'esporadicos@local',
        'ciudad' => 'N/A',
        'activo' => true,
      ]
    );

    Almacen::firstOrCreate(
      ['nombre' => config('esporadico.almacen'), 'empresa_id' => $empresa->id],
      [
        'direccion' => 'N/A',
        'encargado' => 'N/A',
        'telefono' => 'N/A',
        'email' => 'esporadicos@local',
        'ciudad' => 'N/A',
      ]
    );
  }
}
