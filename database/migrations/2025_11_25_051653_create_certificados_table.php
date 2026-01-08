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
      // $table->date('validez');
      $table->string('validez');
      $table->string('direccion');
      $table->string('diagnostico');
      $table->string('condicion');
      $table->string('trabajo');
      $table->string('plaguicidas');
      $table->string('registro');
      $table->string('area');
      $table->string('acciones');
      $table->string('logo')->nullable();
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
