<?php

namespace App\Http\Controllers;

use App\Models\Grupo;
use App\Models\GrupoPlanPago;
use App\Models\PlanPago;
use App\Models\Prestamo;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

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

        // MORAS INDIVUDALES
        $prestamos_con_mora = Prestamo::select("prestamos.*")
            ->whereExists(function ($query) use ($fecha_actual) {
                $query->select(DB::raw(1))
                    ->from("plan_pagos")
                    ->whereRaw("plan_pagos.prestamo_id = prestamos.id")
                    ->where("plan_pagos.fecha_pago", "<", $fecha_actual)
                    ->where("cancelado", "NO");
            })
            ->where("tipo", "INDIVIDUAl")
            ->where("desembolso", 1)
            ->get();

        foreach ($prestamos_con_mora as $key => $pm) {
            // agregar prestamo
            $listMorasIndividual[] = [
                "prestamo" => $pm->load(["cliente"]),
                "total_moras" => 0,
                "total_monto_mora" => 0,
                "total_plan_pagos" => count($pm->plan_pagos),
                "total_dias_mora" => 0
            ];

            // buscar y sumar esos plan de pagos + 30 Bs por dia
            $plan_pagos_moras = PlanPago::where("prestamo_id", $pm->id)
                ->where("fecha_pago", "<", $fecha_actual)
                ->where("cancelado", "NO")
                ->orderBy("fecha_pago", "asc")
                ->get();
            foreach ($plan_pagos_moras as $item) {
                // dias mora
                $fecha_pago = $item->fecha_pago;
                $dias_mora = PrestamoController::obtenerDiferenciaDias($fecha_actual, $fecha_pago);
                $monto_mora = 30 * $dias_mora; // nuevo 30bs por dia mora

                $listMorasIndividual[$key]["total_moras"] = (int)$listMorasIndividual[$key]["total_moras"] + 1;
                $listMorasIndividual[$key]["total_monto_mora"] = (float)$listMorasIndividual[$key]["total_monto_mora"] + (float)$monto_mora;
                $listMorasIndividual[$key]["total_dias_mora"] = (int)$listMorasIndividual[$key]["total_dias_mora"] + $dias_mora;
            }
        }

        // GRUPALES
        $listDesembolsosGrupal = Grupo::with(["prestamos.cliente"])->where("fecha_desembolso", $fecha_actual)->get();
        $listPagosGrupal = GrupoPlanPago::with(["grupo.prestamos.cliente"])->where("fecha_pago", $fecha_actual)->where("cancelado", "NO")->get();

        // armar moras grupal
        $listMorasGrupal = [];
        $grupos_con_mora = Grupo::select("grupos.*")
            ->whereExists(function ($query) use ($fecha_actual) {
                $query->select(DB::raw(1))
                    ->from("grupo_plan_pagos")
                    ->whereRaw("grupo_plan_pagos.grupo_id = grupos.id")
                    ->where("grupo_plan_pagos.fecha_pago", "<", $fecha_actual)
                    ->where("cancelado", "NO");
            })
            ->where("desembolso", 1)
            ->get();

        foreach ($grupos_con_mora as $key => $pm) {
            // agregar grupo
            $listMorasGrupal[] = [
                "grupo" => $pm->load(["prestamos.cliente"]),
                "total_moras" => 0,
                "total_monto_mora" => 0,
                "total_plan_pagos" => count($pm->grupo_plan_pagos),
                "total_dias_mora" => 0
            ];

            // buscar y sumar esos plan de pagos + 30 Bs por dia
            $plan_pagos_moras = GrupoPlanPago::where("grupo_id", $pm->id)
                ->where("fecha_pago", "<", $fecha_actual)
                ->where("cancelado", "NO")
                ->orderBy("fecha_pago", "asc")
                ->get();
            foreach ($plan_pagos_moras as $item) {
                // dias mora
                $fecha_pago = $item->fecha_pago;
                $dias_mora = PrestamoController::obtenerDiferenciaDias($fecha_actual, $fecha_pago);
                $monto_mora = 30 * $dias_mora; // nuevo 30bs por dia mora

                $listMorasGrupal[$key]["total_moras"] = (int)$listMorasGrupal[$key]["total_moras"] + 1;
                $listMorasGrupal[$key]["total_monto_mora"] = (float)$listMorasGrupal[$key]["total_monto_mora"] + (float)$monto_mora;
                $listMorasGrupal[$key]["total_dias_mora"] = (int)$listMorasGrupal[$key]["total_dias_mora"] + $dias_mora;
            }
        }

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
