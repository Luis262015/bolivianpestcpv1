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
    Schema::create('estado_resultados', function (Blueprint $table) {
      $table->id();
      $table->timestamp('fecha_inicio')->nullable();
      $table->timestamp('fecha_fin')->nullable();
      $table->double('ventas');
      $table->double('cobrado');
      $table->double('otros_ingresos');
      $table->double('ingresos_totales');
      $table->double('compras');
      $table->double('costo_total');
      $table->double('utilidad_bruta');
      $table->double('gastosop');
      $table->double('gastosfin');
      $table->double('gastosext');
      $table->double('gastos');
      $table->double('pagos');
      $table->double('total_gastos');
      $table->double('utilidad_neta');
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
    Schema::dropIfExists('estado_resultados');
  }
};
