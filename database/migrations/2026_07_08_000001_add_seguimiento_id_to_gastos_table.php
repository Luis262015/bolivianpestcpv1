<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
  /**
   * Enlaza (opcionalmente) un gasto con un seguimiento. Los gastos generales
   * quedan con seguimiento_id = null; los registrados dentro de un seguimiento
   * quedan etiquetados. Al borrar el seguimiento se ponen en null (el
   * controlador ya los elimina explícitamente).
   */
  public function up(): void
  {
    Schema::table('gastos', function (Blueprint $table) {
      $table->foreignId('seguimiento_id')
        ->nullable()
        ->after('user_id')
        ->constrained('seguimientos')
        ->nullOnDelete();
    });
  }

  public function down(): void
  {
    Schema::table('gastos', function (Blueprint $table) {
      $table->dropForeign(['seguimiento_id']);
      $table->dropColumn('seguimiento_id');
    });
  }
};
