<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateGrupoPlanPagosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('grupo_plan_pagos', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("grupo_id");
            $table->integer("nro_cuota");
            $table->decimal("saldo_inicial", 24, 2);
            $table->decimal("capital", 24, 2);
            $table->decimal("interes", 24, 2);
            $table->decimal("saldo", 24, 2);
            $table->decimal("cuota", 24, 2);
            $table->string("cancelado", 100);
            $table->date("fecha_pago")->nullable();
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
        Schema::dropIfExists('grupo_plan_pagos');
    }
}
