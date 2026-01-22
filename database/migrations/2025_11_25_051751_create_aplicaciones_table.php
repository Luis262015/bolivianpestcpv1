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
    Schema::create('aplicaciones', function (Blueprint $table) {
      $table->id();
      $table->foreignId('seguimiento_id')->constrained('seguimientos');
      // Fumigaciones
      $table->integer('pisos');
      $table->integer('paredes_internas');
      // Desinfeccion
      $table->integer('ambientes');
      // $table->integer('oficinas');
      // $table->integer('banos');
      // $table->integer('cocinas');
      // $table->integer('almacenes');
      // $table->integer('porteria');
      // $table->integer('policial');
      // Control de roedores
      $table->integer('internas');
      $table->integer('externas');
      $table->integer('trampas');
      $table->integer('trampas_cambiar');
      $table->integer('roedores');
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
    Schema::dropIfExists('aplicaciones');
  }
};