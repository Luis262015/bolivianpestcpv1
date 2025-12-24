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
    Schema::create('cotizacion_detalles', function (Blueprint $table) {
      $table->id();
      $table->foreignId('cotizacion_id')->constrained('cotizaciones');
      $table->string('descripcion');
      $table->string('area');
      $table->integer('cantidad');
      $table->integer('visitas');
      $table->decimal('precio_unitario', 10, 2);
      $table->decimal('total', 10, 2);
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
    Schema::dropIfExists('cotizacion_detalles');
  }
};
