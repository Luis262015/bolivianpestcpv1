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
    Schema::create('almacen_areas', function (Blueprint $table) {
      $table->id();
      $table->foreignId('almacen_id')->constrained('almacenes');
      $table->string('descripcion');
      $table->integer('area');
      $table->integer('visitas');
      $table->double('precio');
      $table->double('total');
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
    Schema::dropIfExists('almacen_areas');
  }
};
