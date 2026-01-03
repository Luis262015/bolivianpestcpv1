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

      $table->string('nombre');

      // Almacen trampas
      $table->integer('t_cantidad');
      $table->integer('t_visitas');
      $table->decimal('t_precio', 10, 2);
      $table->decimal('t_total', 10, 2);
      // Almacen area
      $table->integer('a_area');
      $table->integer('a_visitas');
      $table->decimal('a_precio', 10, 2);
      $table->decimal('a_total', 10, 2);
      // Almacen insectocutores
      $table->integer('i_cantidad');
      $table->decimal('i_precio', 10, 2);
      $table->decimal('i_total', 10, 2);

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
