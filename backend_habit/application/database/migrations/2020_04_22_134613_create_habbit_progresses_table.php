<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateHabbitProgressesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('habbit_progresses', function (Blueprint $table) {
            $table->id();
            $table->integer('user_id');
            $table->integer('habbit_id');
            $table->date('date');
            $table->foreign('habbit_id')->references('id')->on('habbits');
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
        Schema::dropIfExists('habbit_progresses');
    }
}
