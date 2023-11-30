<?php

namespace App\Http\Controllers;

use App\Models\Grupo;
use Illuminate\Http\Request;

class GrupoController extends Controller
{

    public function index()
    {

        $grupos = Grupo::orderBy("id", "desc")->get();
        return response()->JSON(['grupos' => $grupos, 'total' => count($grupos)], 200);
    }

    public function show(Grupo $grupo)
    {

        return response()->JSON([
            "grupo" => $grupo->load(["grupo_pagos.user", "prestamos.cliente"]),
        ]);
    }
}
