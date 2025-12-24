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
    Schema::create('certificados', function (Blueprint $table) {
      $table->id();
      $table->foreignId('empresa_id')->constrained('empresas');
      $table->foreignId('user_id')->constrained('users');
      $table->string('qrcode');
      $table->string('firmadigital');
      $table->string('titulo');
      $table->string('actividad');
      $table->date('validez');
      $table->string('direccion');
      $table->text('diagnostico');
      $table->text('condicion');
      $table->text('trabajo');
      $table->text('plaguicidas');
      $table->date('registro');
      $table->text('area');
      $table->text('acciones');
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
    Schema::dropIfExists('certificados');
  }
};
