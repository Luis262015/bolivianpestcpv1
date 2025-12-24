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
    Schema::create('contactos', function (Blueprint $table) {
      $table->id();
      $table->foreignId('almacen_id')->constrained('almacenes');
      $table->string('nombre');
      $table->string('telefono');
      $table->string('email');
      $table->string('ci');
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
    Schema::dropIfExists('contactos');
  }
};
