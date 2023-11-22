<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateClientesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('clientes', function (Blueprint $table) {
            $table->id();
            $table->string("nombre", 155);
            $table->string("segundo_nombre", 155)->nullable();
            $table->string("paterno", 155);
            $table->string("materno")->nullable();
            $table->string("dir", 300);
            $table->string("ci", 155);
            $table->string("ci_exp", 155);
            $table->string("cel", 155);
            $table->string("fono", 155)->nullable();
            $table->integer("edad");
            $table->string("referencia", 500);
            $table->string("cel_ref", 155);
            $table->string("parentesco", 255);
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
        Schema::dropIfExists('clientes');
    }
}
