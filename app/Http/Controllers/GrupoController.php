<?php

namespace App\Http\Controllers;

use App\Models\Grupo;
use Illuminate\Http\Request;

class GrupoController extends Controller
{
    public function show(Grupo $grupo)
    {

        return response()->JSON([
            "grupo" => $grupo->load(["grupo_pagos.user", "prestamos.cliente"]),
        ]);
    }
}
