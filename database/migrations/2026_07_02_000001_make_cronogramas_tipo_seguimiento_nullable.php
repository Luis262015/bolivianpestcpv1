<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
  /**
   * Las tareas creadas desde el calendario no tienen tipo de seguimiento
   * (el formulario no lo pide); con la columna NOT NULL ese INSERT falla
   * bajo STRICT_TRANS_TABLES. Las creadas desde contratos sí lo llevan.
   */
  public function up(): void
  {
    Schema::table('cronogramas', function (Blueprint $table) {
      $table->unsignedBigInteger('tipo_seguimiento_id')->nullable()->change();
    });
  }

  public function down(): void
  {
    Schema::table('cronogramas', function (Blueprint $table) {
      $table->unsignedBigInteger('tipo_seguimiento_id')->nullable(false)->change();
    });
  }
};
