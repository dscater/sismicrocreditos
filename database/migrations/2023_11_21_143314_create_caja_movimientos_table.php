<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCajaMovimientosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('caja_movimientos', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("caja_id");
            $table->unsignedBigInteger("user_id");
            $table->decimal("monto", 24, 2);
            $table->enum("tipo", ["CRÉDITO", "DEBITO"]);
            $table->enum("glosa", ["GASTOS ADMINISTRATIVOS", "DESEMBOLSO", "PAGO CUOTA PRESTAMO", "INTERES", "PAGO MORA", "ABONO CAPITAL"]);
            $table->string("tipo_prestamo", 155)->nullable();
            $table->unsignedBigInteger("prestamo_id")->nullable();
            $table->unsignedBigInteger("grupo_id")->nullable();
            $table->date("fecha_registro")->nullable();
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
        Schema::dropIfExists('caja_movimientos');
    }
}
