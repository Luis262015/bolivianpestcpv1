<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
  /**
   * Índices para las consultas del dashboard (filtros por fecha y status).
   * Los foreign keys ya tienen índice propio vía constrained().
   */
  public function up(): void
  {
    Schema::table('seguimientos', function (Blueprint $table) {
      $table->index('created_at', 'seguimientos_created_at_index');
      $table->index(['empresa_id', 'created_at'], 'seguimientos_empresa_created_index');
    });

    Schema::table('cronogramas', function (Blueprint $table) {
      $table->index(['status', 'date'], 'cronogramas_status_date_index');
      $table->index('date', 'cronogramas_date_index');
    });

    Schema::table('trampa_roedor_seguimientos', function (Blueprint $table) {
      $table->index('created_at', 'trampa_roedor_seg_created_index');
    });

    Schema::table('trampa_especie_seguimientos', function (Blueprint $table) {
      $table->index('created_at', 'trampa_especie_seg_created_index');
    });
  }

  public function down(): void
  {
    Schema::table('seguimientos', function (Blueprint $table) {
      $table->dropIndex('seguimientos_created_at_index');
      $table->dropIndex('seguimientos_empresa_created_index');
    });

    Schema::table('cronogramas', function (Blueprint $table) {
      $table->dropIndex('cronogramas_status_date_index');
      $table->dropIndex('cronogramas_date_index');
    });

    Schema::table('trampa_roedor_seguimientos', function (Blueprint $table) {
      $table->dropIndex('trampa_roedor_seg_created_index');
    });

    Schema::table('trampa_especie_seguimientos', function (Blueprint $table) {
      $table->dropIndex('trampa_especie_seg_created_index');
    });
  }
};
