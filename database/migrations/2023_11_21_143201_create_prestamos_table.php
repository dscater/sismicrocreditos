<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreatePrestamosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('prestamos', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("user_id");
            $table->unsignedBigInteger("user_desembolso_id")->nullable();
            $table->unsignedBigInteger("user_aprobado_id")->nullable();
            $table->unsignedBigInteger("cliente_id");
            $table->string("tipo", 155);
            $table->unsignedBigInteger("grupo_id")->nullable();
            $table->decimal("monto", 24, 2);
            $table->integer("plazo");
            $table->integer("f_ci");
            $table->integer("f_luz");
            $table->integer("f_agua");
            $table->integer("croquis");
            $table->string("documento_1")->nullable();
            $table->string("documento_2")->nullable();
            $table->string("documento_3")->nullable();
            $table->string("documento_4")->nullable();
            $table->string("estado", 155);
            $table->integer("desembolso")->default(0);
            $table->date("fecha_desembolso")->nullable();
            $table->integer("finalizado")->default(0);
            $table->date("fecha_registro");
            $table->timestamps();

            $table->foreign("user_id")->on("users")->references("id");
            $table->foreign("cliente_id")->on("clientes")->references("id");
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('prestamos');
    }
}
