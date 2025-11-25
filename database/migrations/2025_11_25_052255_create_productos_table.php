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
            $table->string('nombre');
            $table->string('imagen')->nullable();
            $table->integer('orden')->nullable();
            $table->string('descripcion')->nullable();
            $table->decimal('costo', 10, 2)->nullable();
            $table->decimal('precio', 10, 2)->nullable();
            $table->integer('stock')->nullable();
            $table->integer('stock_min')->nullable();
            $table->foreignId('marca_id')->constrained('marcas');
            $table->foreignId('categoria_id')->constrained('categorias');
            $table->foreignId('subcategoria_id')->constrained('subcategorias');
            $table->foreignId('proveedor_id')->constrained('proveedores');
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