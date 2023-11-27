<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateGrupoPagosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('grupo_pagos', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("user_id");
            $table->unsignedBigInteger("grupo_id");
            $table->unsignedBigInteger("grupal_plan_pago_id");
            $table->unsignedBigInteger("cliente_id");
            $table->integer("nro_cuota");
            $table->decimal("monto", 24, 2);
            $table->decimal("interes", 24, 2);
            $table->integer("dias_mora");
            $table->decimal("monto_mora", 24, 2)->nullable();
            $table->decimal("monto_total", 24, 2);
            $table->date("fecha_pago");
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('grupo_pagos');
    }
}
