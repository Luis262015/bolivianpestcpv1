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
        Schema::create('trampa_roedor_seguimientos', function (Blueprint $table) {
            $table->id();
            $table->foreignId('trampa_seguimiento_id')->constrained('trampa_seguimientos');
            $table->foreignId('trampa_id')->constrained('trampas');
            $table->string('observacion');
            $table->integer('cantidad');
            $table->double('inicial');
            $table->double('merma');
            $table->double('actual');
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
        Schema::dropIfExists('trampa_roedor_seguimientos');
    }
};
