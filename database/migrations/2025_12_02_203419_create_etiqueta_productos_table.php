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
      $table->foreignId('etiqueta_id')->constrained('etiquetas');
      $table->foreignId('producto_id')->constrained('productos');
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
    Schema::dropIfExists('etiqueta_productos');
  }
};
