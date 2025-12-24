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
    Schema::create('seguimiento_metodos', function (Blueprint $table) {
      $table->id();
      $table->foreignId('metodo_id')->constrained('metodos');
      $table->foreignId('seguimiento_id')->constrained('seguimientos');
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
    Schema::dropIfExists('seguimiento_metodos');
  }
};
