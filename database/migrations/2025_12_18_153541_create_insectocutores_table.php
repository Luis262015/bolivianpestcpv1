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
    Schema::create('insectocutores', function (Blueprint $table) {
      $table->id();
      $table->foreignId('almacen_id')->constrained('almacenes');
      $table->foreignId('mapa_id')->constrained('mapas');
      $table->integer('posx');
      $table->integer('posy');
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
    Schema::dropIfExists('insectocutores');
  }
};
