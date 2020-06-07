<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateChallengeProgressesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('challenge_progresses', function (Blueprint $table) {
            $table->id();
            $table->integer('marker_user_id');
            $table->integer('owner_user_id');
            $table->integer('challenge_id');
            $table->integer('mark');
            $table->date('date');
            $table->foreign('challenge_id')->references('id')->on('challenges');
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
        Schema::dropIfExists('challenge_progresses');
    }
}
