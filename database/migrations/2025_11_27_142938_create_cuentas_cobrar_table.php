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
        Schema::create('cuentas_cobrar', function (Blueprint $table) {
            $table->id();

            $table->foreignId('venta_id')->constrained('ventas');
            $table->foreignId('cliente_id')->constrained('clientes');
            $table->foreignId('user_id')->constrained('users');

            $table->double('total');
            $table->double('a_cuenta');
            $table->double('saldo');
            $table->enum('estado', ['Pendiente', 'Cancelado']);
            $table->date('fecha_pago');

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
        Schema::dropIfExists('cuentas_cobrar');
    }
};
