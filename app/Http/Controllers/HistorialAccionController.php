<?php

namespace App\Http\Controllers;

use App\Models\HistorialAccion;
use Illuminate\Http\Request;

class HistorialAccionController extends Controller
{
    public function index(Request $request)
    {
        $historial_accions = HistorialAccion::with(["user"])->orderBy("created_at", "desc")->get();
        return response()->JSON(['historial_accions' => $historial_accions, 'total' => count($historial_accions)], 200);
    }
}
