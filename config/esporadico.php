<?php

return [
  // Empresa y almacén reservados para tareas/seguimientos ESPORÁDICOS
  // (servicios eventuales que no provienen de un contrato). El seeder
  // EsporadicoSeeder los crea con estos nombres y el resto del sistema
  // los resuelve por nombre a través de App\Models\Almacen::esporadico().
  'empresa' => 'ESPORADICOS',
  'almacen' => 'ESPORADICO',
];
