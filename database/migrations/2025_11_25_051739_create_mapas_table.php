<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
  /**
   * Run the migrations.
   */
  public function up(): void
  {
    Schema::create('mapas', function (Blueprint $table) {
      $table->id();
      $table->foreignId('empresa_id')->constrained('empresas');
      $table->foreignId('almacen_id')->constrained('almacenes');
      $table->foreignId('user_id')->constrained('users');

      // Datos del dibujo (textos + trampas) en JSON
      $table->json('data')->nullable();

      // Ruta de la imagen de fondo (ej: "mapas/almacen_5_2026.png")
      $table->string('background')->nullable();

      $table->timestamp('created_at')->useCurrent();
      $table->timestamp('updated_at')->useCurrent();
      // $table->timestamps();
    });
  }

  /**
   * Reverse the migrations.
   */
  public function down(): void
  {
    Schema::dropIfExists('mapas');
  }
};
