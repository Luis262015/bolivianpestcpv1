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
    Schema::create('seguimientos', function (Blueprint $table) {
      $table->id();
      $table->foreignId('empresa_id')->constrained('empresas');
      $table->foreignId('almacen_id')->constrained('almacenes');
      $table->foreignId('user_id')->constrained('users');
      $table->foreignId('tipo_seguimiento_id')->nullable()->constrained('tipo_seguimientos');

      $table->string('encargado_nombre')->nullable();
      $table->string('encargado_cargo')->nullable();
      $table->string('firma_encargado')->nullable();
      $table->string('firma_supervisor')->nullable();

      $table->string('paredes_internas')->nullable();
      $table->string('cantidad_pisos')->nullable();
      $table->string('cantidad_trampas')->nullable();
      $table->string('cambiar_trampas')->nullable();
      $table->string('internas_trampas')->nullable();
      $table->string('externas_trampas')->nullable();
      $table->string('roedores')->nullable();
      $table->text('observaciones')->nullable();
      $table->text('observacionesp')->nullable();
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
    Schema::dropIfExists('seguimientos');
  }
};
