<?php

namespace App\Http\Controllers;

use App\Models\Grupo;
use App\Models\GrupoPlanPago;
use App\Models\PlanPago;
use App\Models\Prestamo;
use Illuminate\Http\Request;

class ControlPrestamoController extends Controller
{
    public function getInfo(Request $request)
    {
        $array_meses = [
            "01" => "ENERO",
            "02" => "FEBRERO",
            "03" => "MARZO",
            "04" => "ABRIL",
            "05" => "MAYO",
            "06" => "JUNIO",
            "07" => "JULIO",
            "08" => "AGOSTO",
            "09" => "SEPTIEMBRE",
            "10" => "OCTUBRE",
            "11" => "NOVIEMBRE",
            "12" => "DICIEMBRE",
        ];

        $array_dias = [
            "1" => "LUNES",
            "2" => "MARTES",
            "3" => "MIERCOLES",
            "4" => "JUEVES",
            "5" => "VIERNES",
            "6" => "SÁBADO",
            "0" => "DOMINGO",
        ];

        $listDesembolsosIndividual = [];
        $listDesembolsosGrupal = [];
        $listPagosIndividual = [];
        $listPagosGrupal = [];
        $listMorasIndividual = [];
        $listMorasGrupal = [];

        $dia = date("w");
        $mes = date("m");

        $fecha_txt = $array_dias[$dia] . " " . date("d") . " de " . $array_meses[$mes] . " de " . date("Y");
        $fecha_actual = date("Y-m-d");

        // INDIVIDUALES
        $listDesembolsosIndividual = Prestamo::with(["cliente"])->where("fecha_desembolso", $fecha_actual)->where("grupo_id", NULL)->get();
        $listPagosIndividual = PlanPago::with(["prestamo.cliente"])->select("plan_pagos.*")
            ->join("prestamos", "prestamos.id", "=", "plan_pagos.prestamo_id")
            ->where("prestamos.grupo_id", NULL)
            ->where("plan_pagos.fecha_pago", $fecha_actual)
            ->where("plan_pagos.cancelado", "NO")
            ->get();
        $listMorasIndividual = PlanPago::with(["prestamo.cliente"])->select("plan_pagos.*")
            ->join("prestamos", "prestamos.id", "=", "plan_pagos.prestamo_id")
            ->where("prestamos.grupo_id", NULL)
            ->where("plan_pagos.fecha_pago", "<", $fecha_actual)
            ->where("plan_pagos.cancelado", "NO")
            ->get();

        // GRUPALES
        $listDesembolsosGrupal = Grupo::with(["prestamos.cliente"])->where("fecha_desembolso", $fecha_actual)->get();
        $listPagosGrupal = GrupoPlanPago::with(["grupo.prestamos.cliente"])->where("fecha_pago", $fecha_actual)->where("cancelado", "NO")->get();
        $listMorasGrupal = GrupoPlanPago::with(["grupo.prestamos.cliente"])->where("fecha_pago", "<", $fecha_actual)->where("cancelado", "NO")->get();

        return response()->JSON([
            "listDesembolsosIndividual" => $listDesembolsosIndividual,
            "listDesembolsosGrupal" => $listDesembolsosGrupal,
            "listPagosIndividual" => $listPagosIndividual,
            "listPagosGrupal" => $listPagosGrupal,
            "listMorasIndividual" => $listMorasIndividual,
            "listMorasGrupal" => $listMorasGrupal,
            "fecha_txt" => $fecha_txt,
        ]);
    }
}
