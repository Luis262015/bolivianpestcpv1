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
    Schema::create('cronogramas', function (Blueprint $table) {
      $table->id();
      $table->foreignId('almacen_id')->constrained('almacenes');
      $table->foreignId('user_id')->constrained('users');
      $table->foreignId('tecnico_id')->constrained('users');
      $table->string('title');
      $table->date('date');                    // fecha de la tarea (yyyy-MM-dd)
      $table->string('color')->default('bg-blue-500');
      $table->enum('status', ['pendiente', 'postergado', 'completado'])->default('pendiente');
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
    Schema::dropIfExists('cronogramas');
  }
};