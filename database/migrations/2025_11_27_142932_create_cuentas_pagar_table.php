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
    Schema::create('cuentas_pagar', function (Blueprint $table) {
      $table->id();

      $table->foreignId('compra_id')->nullable()->constrained('compras');
      $table->foreignId('proveedor_id')->nullable()->constrained('proveedores');
      $table->foreignId('user_id')->constrained('users');

      $table->string('concepto');
      $table->string('detalles');
      $table->double('total');
      $table->double('saldo');
      $table->enum('estado', ['Pendiente', 'Cancelado']);
      $table->date('fecha_pago')->nullable();
      $table->boolean('plan_pagos');

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
    Schema::dropIfExists('cuentas_pagar');
  }
};
