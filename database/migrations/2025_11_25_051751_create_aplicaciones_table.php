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
      $table->string('oficinas');
      $table->string('pisos');
      $table->string('banos');
      $table->string('cocinas');
      $table->string('almacenes');
      $table->string('porteria');
      $table->string('policial');
      $table->string('trampas');
      $table->string('trampas_cambiar');
      $table->string('internas');
      $table->string('externas');
      $table->string('roedores');
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
