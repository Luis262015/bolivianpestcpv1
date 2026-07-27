<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
  /**
   * La subcategoría ya existía como taxonomía (tabla `subcategorias`, su CRUD y
   * el selector en cascada del formulario de productos), pero faltaba la
   * columna donde guardarla: el formulario la enviaba y el controlador la
   * descartaba en silencio.
   *
   * Nullable porque los productos existentes no tienen ninguna asignada, y
   * porque la subcategoría es opcional igual que la categoría.
   */
  public function up(): void
  {
    Schema::table('productos', function (Blueprint $table) {
      $table->foreignId('subcategoria_id')
        ->nullable()
        ->after('categoria_id')
        ->constrained('subcategorias')
        ->nullOnDelete();
    });
  }

  public function down(): void
  {
    Schema::table('productos', function (Blueprint $table) {
      $table->dropForeign(['subcategoria_id']);
      $table->dropColumn('subcategoria_id');
    });
  }
};
