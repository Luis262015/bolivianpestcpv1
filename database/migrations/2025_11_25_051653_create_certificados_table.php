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
      $table->string('qrcode')->nullable();
      $table->string('firmadigital')->nullable();
      $table->string('titulo')->nullable();
      $table->string('establecimiento')->nullable();
      $table->string('actividad')->nullable();
      // $table->date('validez');
      $table->string('validez')->nullable();
      $table->string('direccion')->nullable();
      $table->string('diagnostico')->nullable();
      $table->string('condicion')->nullable();
      $table->string('trabajo')->nullable();
      $table->string('plaguicidas')->nullable();
      $table->string('registro')->nullable();
      $table->string('area')->nullable();
      $table->string('acciones')->nullable();
      $table->string('logo')->nullable()->nullable();
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
