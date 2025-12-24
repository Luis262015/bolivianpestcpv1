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
      $table->double('cuentascobrar');
      $table->double('pagos');
      $table->double('ventas');
      $table->double('ingresos');
      $table->double('total_utilidad');
      $table->double('cuentaspagar');
      $table->double('compras');
      $table->double('gastosop');
      $table->double('gastosfin');
      $table->double('gastosext');
      $table->double('gastos');
      $table->double('retiros');
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
