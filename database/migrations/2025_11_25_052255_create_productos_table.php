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
        Schema::create('productos', function (Blueprint $table) {
            $table->id();
            $table->foreignId('categoria_id')->nullable()->constrained('categorias');
            $table->foreignId('subcategoria_id')->nullable()->constrained('subcategorias');
            $table->foreignId('marca_id')->nullable()->constrained('marcas');
            $table->foreignId('unidad_id')->nullable()->constrained('unidades');
            $table->string('nombre');
            $table->string('imagen')->nullable();
            $table->integer('orden')->nullable()->default(0);
            $table->string('codigo')->nullable();
            $table->string('descripcion')->nullable();
            $table->decimal('precio_compra', 10, 2)->nullable();
            $table->decimal('precio_venta', 10, 2)->nullable();
            $table->integer('stock')->nullable();
            $table->integer('stock_min')->nullable();
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
        Schema::dropIfExists('productos');
    }
};
