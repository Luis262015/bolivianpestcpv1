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
        Schema::create('seguimientos', function (Blueprint $table) {
            $table->id();
            $table->foreignId('empresa_id')->constrained('empresas');
            $table->foreignId('user_id')->constrained('users');
            $table->foreignId('almacen_id')->constrained('almacenes');
            $table->foreignId('tipo_seguimiento_id')->constrained('tipo_seguimientos');
            $table->string('cambiar_trampas');
            $table->string('cantidad_trampas');
            $table->string('internas_trampas');
            $table->string('externas_trampas');
            $table->string('roedores');
            $table->text('observaciones');
            $table->text('observacionesp');
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
        Schema::dropIfExists('seguimientos');
    }
};