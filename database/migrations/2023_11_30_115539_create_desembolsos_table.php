<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateDesembolsosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('desembolsos', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("user_id");
            $table->string("tipo_prestamo", 155)->nullable();
            $table->unsignedBigInteger("prestamo_id")->nullable();
            $table->unsignedBigInteger("grupo_id")->nullable();
            $table->decimal("monto", 24, 2);
            $table->string("cancelado", 100);
            $table->date("fecha_registro");
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
        Schema::dropIfExists('desembolsos');
    }
}
