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
    Schema::create('kardexes', function (Blueprint $table) {
      $table->id();
      $table->foreignId('venta_id')->nullable()->constrained('ventas');
      $table->foreignId('compra_id')->nullable()->constrained('compras');
      $table->foreignId('producto_id')->nullable()->constrained('productos');
      $table->enum('tipo', ['Entrada', 'Salida']);
      $table->integer('cantidad');
      $table->integer('cantidad_saldo');
      $table->double('costo_unitario');
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
    Schema::dropIfExists('kardexes');
  }
};
