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
    Schema::create('almacenes', function (Blueprint $table) {
      $table->id();
      $table->foreignId('empresa_id')->constrained('empresas');
      $table->string('nombre');
      $table->string('direccion')->nullable();
      $table->string('encargado')->nullable();
      $table->string('telefono')->nullable();
      $table->string('email')->nullable();
      $table->string('ciudad')->nullable();
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
    Schema::dropIfExists('almacenes');
  }
};
