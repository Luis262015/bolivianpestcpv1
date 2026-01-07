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
    Schema::create('compras', function (Blueprint $table) {
      $table->id();
      $table->foreignId('user_id')->constrained('users');
      $table->foreignId('proveedor_id')->nullable()->constrained('proveedores');
      $table->double('total');
      // $table->double('abonado');
      // $table->double('saldo');
      $table->text('observaciones')->nullable();
      $table->enum('tipo', ['Compra', 'Credito', 'Adelanto', 'Anulado']);
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
    Schema::dropIfExists('compras');
  }
};
