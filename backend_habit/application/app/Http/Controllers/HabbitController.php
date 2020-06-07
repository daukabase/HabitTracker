<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Resources\HabbitResource;
use App\Habbit;
use App\Http\Requests;

class HabbitController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $habbit = Habbit::all();
        return HabbitResource::collection($habbit);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $habbit = new Habbit;
        $habbit->title = $request->input('title');
        $habbit->notes = $request->input('notes');
        $habbit->category_id = $request->input('category_id');
        $habbit->image_url = $request->input('image_url');
        $habbit->remind = $request->input('remind');
        $habbit->save();
        return new HabbitResource($habbit);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $article = Habbit::find($id);

        if( $article ){
            return new HabbitResource($article);
        }
        return "Habbit Not found"; // temporary error
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $habbit = Habbit::find($id);
        $habbit->title = $request->input('title');
        $habbit->notes = $request->input('notes');
        $habbit->category_id = $request->input('category_id');
        $habbit->image_url = $request->input('image_url');
        $habbit->remind = $request->input('remind');
        $habbit->save();
        return new HabbitResource($habbit);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $habbit = Habbit::findOrfail($id);
        if($habbit->delete()){
            return  new HabbitResource($habbit);
        }
        return "Error while deleting";
    }
}
