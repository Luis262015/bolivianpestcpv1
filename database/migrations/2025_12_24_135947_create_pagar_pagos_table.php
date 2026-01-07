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
    Schema::create('pagar_pagos', function (Blueprint $table) {
      $table->id();
      $table->foreignId('cuenta_pagar_id')->constrained('cuentas_pagar')->cascadeOnDelete();
      $table->foreignId('cuota_id')->nullable()->constrained('pagar_cuotas')->nullOnDelete();
      $table->date('fecha_pago');
      $table->decimal('monto', 12, 2);
      $table->string('metodo_pago')->nullable();
      $table->text('observacion')->nullable();
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
    Schema::dropIfExists('pagar_pagos');
  }
};
