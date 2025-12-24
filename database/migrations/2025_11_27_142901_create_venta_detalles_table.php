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
    Schema::create('venta_detalles', function (Blueprint $table) {
      $table->id();
      $table->foreignId('venta_id')->constrained('ventas');
      $table->foreignId('producto_id')->nullable()->constrained('productos');

      $table->double('precio_venta');
      $table->integer('cantidad');
      $table->double('total');

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
    Schema::dropIfExists('venta_detalles');
  }
};
