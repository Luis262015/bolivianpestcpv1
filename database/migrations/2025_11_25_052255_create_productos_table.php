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
    Schema::create('productos', function (Blueprint $table) {
      $table->id();
      $table->foreignId('categoria_id')->nullable()->constrained('categorias');
      $table->foreignId('marca_id')->nullable()->constrained('marcas');
      $table->foreignId('unidad_id')->nullable()->constrained('unidades');
      $table->string('nombre');
      $table->string('descripcion')->nullable();
      $table->integer('unidad_valor')->default(1);
      $table->integer('stock')->nullable();
      $table->integer('stock_min')->default(1);
      $table->decimal('precio_compra', 10, 2)->nullable();
      $table->decimal('precio_venta', 10, 2)->nullable();
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
    Schema::dropIfExists('productos');
  }
};
