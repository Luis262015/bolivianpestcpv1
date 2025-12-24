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
    Schema::create('etiqueta_productos', function (Blueprint $table) {
      $table->id();

      $table->unsignedBigInteger('etiqueta_id');
      $table->unsignedBigInteger('producto_id');

      $table->timestamp('created_at')->useCurrent();
      $table->timestamp('updated_at')->useCurrent();
      // $table->timestamps();

      $table->foreign('etiqueta_id')->references('id')->on('etiquetas');
      $table->foreign('producto_id')->references('id')->on('productos');
      // $table->timestamps();
    });
  }

  /**
   * Reverse the migrations.
   */
  public function down(): void
  {
    Schema::dropIfExists('etiqueta_productos');
  }
};
