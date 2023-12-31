<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateGruposTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('grupos', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("user_id");
            $table->unsignedBigInteger("user_desembolso_id")->nullable();
            $table->unsignedBigInteger("user_aprobado_id")->nullable();
            $table->string("nombre", 255)->unique();
            $table->integer("integrantes");
            $table->decimal("monto", 24, 2);
            $table->integer("plazo");
            $table->integer("desembolso")->default(0);
            $table->date("fecha_desembolso")->nullable();
            $table->string("estado", 155);
            $table->integer("finalizado")->default(0);
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
        Schema::dropIfExists('grupos');
    }
}
