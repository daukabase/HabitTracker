<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateChallengeAskMarksTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('challenge_ask_marks', function (Blueprint $table) {
            $table->id();
            $table->integer('user_id');
            $table->integer('challenge_id');
            $table->integer('status');
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
        Schema::dropIfExists('challenge_ask_marks');
    }
}
