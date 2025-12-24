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
    Schema::create('pagar_cuotas', function (Blueprint $table) {
      $table->id();
      $table->foreignId('cuenta_pagar_id')->constrained('cuentas_pagar')->cascadeOnDelete();
      $table->integer('numero_cuota');
      $table->date('fecha_vencimiento');
      $table->decimal('monto', 12, 2);
      $table->enum('estado', ['pendiente', 'pagado', 'vencido'])->default('pendiente');
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
    Schema::dropIfExists('pagar_cuotas');
  }
};
