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
        Schema::create('ventas', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained('users');
            $table->foreignId('cliente_id')->nullable()->constrained('clientes');
            $table->string('numero')->nullable();
            $table->string('autorizacion')->nullable();
            $table->string('control')->nullable();
            $table->double('subtotal');
            $table->double('iva');
            $table->double('total');
            $table->double('a_cuenta');
            $table->double('saldo');
            $table->double('saldo_t');
            $table->double('descuento');
            $table->enum('tipo', ['Venta', 'Pago', 'Adelanto', 'Anulado']);
            $table->enum('metodo', ['Efectivo', 'Tarjeta', 'Billetera Movil', 'Transferencia']);
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
        Schema::dropIfExists('ventas');
    }
};
