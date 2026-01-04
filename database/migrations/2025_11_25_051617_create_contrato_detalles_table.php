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
    Schema::create('contrato_detalles', function (Blueprint $table) {
      $table->id();
      $table->foreignId('contrato_id')->constrained('contratos');

      $table->string('nombre');

      // Almacen trampas
      $table->string('t_cantidad');
      $table->string('t_visitas');
      $table->string('t_precio');
      $table->string('t_total');
      // Almacen area
      $table->string('a_area');
      $table->string('a_visitas');
      $table->string('a_precio');
      $table->string('a_total');
      // Almacen insectocutores
      $table->string('i_cantidad');
      $table->string('i_precio');
      $table->string('i_total');

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
    Schema::dropIfExists('contrato_detalles');
  }
};