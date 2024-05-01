<?php

namespace App\Http\Controllers;

use App\Models\Cliente;
use App\Models\Grupo;
use App\Models\GrupoPlanPago;
use App\Models\Interes;
use App\Models\PlanPago;
use App\Models\Prestamo;
use DateTime;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use PDF;
use App\library\numero_a_letras\src\NumeroALetras;

class PrestamoController extends Controller
{
    public function show(Prestamo $prestamo)
    {
        return response()->JSON([
            "prestamo" => $prestamo->load(["cliente", "plan_pagos", "pagos.user"]),
        ]);
    }

    public function actualizar_fecha_desembolso(Prestamo $prestamo, Request $request)
    {
        $request->validate([
            "fecha_desembolso" => "required|date"
        ], [
            "fecha_desembolso.required" => "Debes seleccionar una fecha",
            "fecha_desembolso.date" => "Debes ingresar una fecha valida",
        ]);

        $fecha_actual = date("Y-m-d");
        if ($request->fecha_desembolso < $fecha_actual) {
            return response()->JSON([
                "errors" => [
                    "fecha_desembolso" => ["La fecha ingresada no puede ser igual o menor a la fecha actual"]
                ]
            ], 422);
        }

        if ($request->fecha_desembolso) {
            $prestamo->fecha_desembolso = $request->fecha_desembolso;
        }
        $prestamo->save();
        // actualizar las fechas de pagos
        $plan_pagos = PlanPago::where("prestamo_id", $prestamo->id)->orderBy("nro_cuota", "asc")->get();
        $fecha_proximo_pago = $request->fecha_desembolso;
        foreach ($plan_pagos as $key => $pp) {
            $fecha_proximo_pago = date("Y-m-d", strtotime($fecha_proximo_pago . "+7days"));
            $pp->fecha_pago = $fecha_proximo_pago;
            $pp->save();
        }

        return response()->JSON([
            "msj" => "Fecha de desembolso actualizado",
        ], 200);
    }


    public function actualizar_fecha_desembolso_grupal(Grupo $grupo, Request $request)
    {
        $request->validate([
            "fecha_desembolso" => "required|date"
        ], [
            "fecha_desembolso.required" => "Debes seleccionar una fecha",
            "fecha_desembolso.date" => "Debes ingresar una fecha valida",
        ]);

        $fecha_actual = date("Y-m-d");
        if ($request->fecha_desembolso < $fecha_actual) {
            return response()->JSON([
                "errors" => [
                    "fecha_desembolso" => ["La fecha ingresada no puede ser igual o menor a la fecha actual"]
                ]
            ], 422);
        }

        if ($request->fecha_desembolso) {
            $grupo->fecha_desembolso = $request->fecha_desembolso;
            foreach ($grupo->prestamos as $prestamo) {
                $prestamo->fecha_desembolso = $request->fecha_desembolso;
                $prestamo->save();
            }
            $grupo->save();
        }

        // registrar las fechas de pagos
        $plan_pagos = GrupoPlanPago::where("grupo_id", $grupo->id)->orderBy("nro_cuota", "asc")->get();
        $fecha_desembolso = $request->fecha_desembolso;
        $fecha_proximo_pago = $fecha_desembolso;
        foreach ($plan_pagos as $key => $pp) {
            $fecha_proximo_pago = date("Y-m-d", strtotime($fecha_proximo_pago . "+7days"));
            $pp->fecha_pago = $fecha_proximo_pago;
            $pp->save();
        }

        // actualizar el plan por separado de los prestamos
        foreach ($grupo->prestamos as $prestamo) {
            foreach ($plan_pagos as $gpp) {
                $pp = PlanPago::where("prestamo_id", $prestamo->id)->where("nro_cuota", $gpp->nro_cuota)->get()->first();
                $pp->fecha_pago = $gpp->fecha_pago;
                $pp->save();
            }
            $prestamo->save();
        }

        return response()->JSON([
            "msj" => "Fecha de desembolso actualizado",
        ], 200);
    }

    public function get_pago(Prestamo $prestamo)
    {
        // obtener el primer pago
        $dias_mora = 0;
        $monto_mora = 0;
        $plan_pago = PlanPago::where("prestamo_id", $prestamo->id)->where("cancelado", "NO")->orderBy("nro_cuota", "asc")->get()->first();

        $prestamo = $plan_pago->prestamo;
        if ($plan_pago) {
            // VERIFICAR LOS DÍAS DE MORA
            $fecha_actual = date("Y-m-d");
            $fecha_pago = $plan_pago->fecha_pago;
            // Obtener los días transcurridos
            $dias_mora = self::obtenerDiferenciaDias($fecha_actual, $fecha_pago);
            if ($dias_mora > 0) {
                // $monto_mora = (($prestamo->monto / 100) * 0.3) * $dias_mora; //antiguo
                $monto_mora = 30 * $dias_mora; // nuevo 30bs por dia mora
            }

            // fin calcular monto mora
            return response()->JSON([
                "sw" => true,
                "plan_pago" => $plan_pago,
                "dias_mora" => $dias_mora,
                "monto_mora" => $monto_mora,
            ]);
        } else {
            return response()->JSON([
                "sw" => false,
                "message" => "No se encontró ningun pago para realizar"
            ], 400);
        }
    }

    public function get_pago_total(Prestamo $prestamo)
    {

        $total_capital = 0;
        $total_interes = 0;
        $total_moras = 0;
        $total_dias_mora = 0;

        $plan_pagos = PlanPago::where("prestamo_id", $prestamo->id)->where("cancelado", "NO")->orderBy("nro_cuota", "asc")->get();

        if (count($plan_pagos) > 0) {
            foreach ($plan_pagos as $plan_pago) {
                // obtener moras
                $dias_mora = 0;
                $monto_mora = 0;
                // VERIFICAR LOS DÍAS DE MORA
                $fecha_actual = date("Y-m-d");
                $fecha_pago = $plan_pago->fecha_pago;
                // Obtener los días transcurridos
                $dias_mora = self::obtenerDiferenciaDias($fecha_actual, $fecha_pago);
                if ($dias_mora > 0) {
                    $total_dias_mora = (int)$total_dias_mora + $dias_mora;
                    // $monto_mora = (($prestamo->monto / 100) * 0.3) * $dias_mora; // antiguo
                    $monto_mora = 30 * $dias_mora; // nuevo 30bs por dia mora
                }

                $total_capital = (float)$total_capital + (float)$plan_pago->capital;
                $total_interes = (float)$total_interes + (float)$plan_pago->interes;
                $total_moras = (float)$total_moras + (float)$monto_mora;
            }

            $total_capital = number_format($total_capital, 2, ".", "");
            $total_interes = number_format($total_interes, 2, ".", "");
            $total_moras = number_format($total_moras, 2, ".", "");

            // fin calcular monto mora
            return response()->JSON([
                "sw" => true,
                "total_capital" => $total_capital,
                "total_interes" => $total_interes,
                "total_moras" => $total_moras,
                "total_dias_mora" => $total_dias_mora,
                "plan_pagos" => $plan_pagos,
            ]);
        } else {
            return response()->JSON([
                "sw" => false,
                "message" => "No se encontró ningun pago para realizar"
            ], 400);
        }
    }

    public function get_pago_grupal(Grupo $grupo)
    {
        // obtener el primer pago
        $dias_mora = 0;
        $monto_mora = 0;
        $plan_pago = GrupoPlanPago::where("grupo_id", $grupo->id)->where("cancelado", "NO")->orderBy("nro_cuota", "asc")->get()->first();

        $grupo = $plan_pago->grupo;
        if ($plan_pago) {
            // VERIFICAR LOS DÍAS DE MORA
            $fecha_actual = date("Y-m-d");
            $fecha_pago = $plan_pago->fecha_pago;
            // Obtener los días transcurridos
            $dias_mora = self::obtenerDiferenciaDias($fecha_actual, $fecha_pago);
            if ($dias_mora > 0) {
                // $monto_mora = (($grupo->monto / 100) * 0.3) * $dias_mora;//antiguo
                $monto_mora = 30 * $dias_mora; // nuevo 30bs por dia mora
            }

            // fin calcular monto mora
            return response()->JSON([
                "sw" => true,
                "plan_pago" => $plan_pago,
                "dias_mora" => $dias_mora,
                "monto_mora" => $monto_mora,
            ]);
        } else {
            return response()->JSON([
                "sw" => false,
                "message" => "No se encontró ningun pago para realizar"
            ], 400);
        }
    }

    public function get_pago_grupal_total(Grupo $grupo)
    {
        $total_capital = 0;
        $total_interes = 0;
        $total_moras = 0;
        $total_dias_mora = 0;

        // obtener pland de pagos grupal
        $grupo_plan_pagos = GrupoPlanPago::where("grupo_id", $grupo->id)->where("cancelado", "NO")->orderBy("nro_cuota", "asc")->get();

        if (count($grupo_plan_pagos) > 0) {

            foreach ($grupo_plan_pagos as $plan_pago) {
                // obtener moras
                $dias_mora = 0;
                $monto_mora = 0;
                // VERIFICAR LOS DÍAS DE MORA
                $fecha_actual = date("Y-m-d");
                $fecha_pago = $plan_pago->fecha_pago;
                // Obtener los días transcurridos
                $dias_mora = self::obtenerDiferenciaDias($fecha_actual, $fecha_pago);
                if ($dias_mora > 0) {
                    $total_dias_mora = (int)$total_dias_mora + $dias_mora;
                    // $monto_mora = (($grupo->monto / 100) * 0.3) * $dias_mora;//antiguo
                    $monto_mora = 30 * $dias_mora; // nuevo 30bs por dia mora
                }
                $total_capital = (float)$total_capital + (float)$plan_pago->capital;
                $total_interes = (float)$total_interes + (float)$plan_pago->interes;
                $total_moras = (float)$total_moras + (float)$monto_mora;
            }

            $total_capital = number_format($total_capital, 2, ".", "");
            $total_interes = number_format($total_interes, 2, ".", "");
            $total_moras = number_format($total_moras, 2, ".", "");

            // fin calcular monto mora
            return response()->JSON([
                "sw" => true,
                "total_capital" => $total_capital,
                "total_interes" => $total_interes,
                "total_moras" => $total_moras,
                "total_dias_mora" => $total_dias_mora,
                "plan_pagos" => $grupo_plan_pagos,
            ]);
        } else {
            return response()->JSON([
                "sw" => false,
                "message" => "No se encontró ningun pago para realizar"
            ], 400);
        }
    }

    public static function obtenerDiferenciaDias($fecha1, $fecha2)
    {
        $date1 = new DateTime($fecha1);
        $date2 = new DateTime($fecha2);

        $diferencia = $date1->diff($date2);

        if ($date1 >= $date2) {
            return $diferencia->days;
        } else {
            return -$diferencia->days;
        }
    }

    public function plan_pago_simulacion(Request $request)
    {

        $errors = [];
        $datos = [
            "monto" => $request["monto"],
            "plazo" => $request["plazo"],
            "cliente" => [
                "nombre" => mb_strtoupper($request["cliente"]["nombre"]),
                "segundo_nombre" => mb_strtoupper($request["cliente"]["segundo_nombre"]),
                "paterno" => mb_strtoupper($request["cliente"]["paterno"]),
                "materno" => mb_strtoupper($request["cliente"]["materno"]),
                "ci" => "S/N",
                "ci_exp" => "",
            ]
        ];

        if (trim($datos["monto"]) == '' || (float)$datos["monto"] <= 0) {
            $errors["monto"] = ["Debes ingresar un monto valido"];
        }
        if (trim($datos["plazo"]) == '' || (float)$datos["plazo"] <= 0) {
            $errors["plazo"] = ["Debes ingresar un plazo valido"];
        } else {
            if ((float)$datos["plazo"] > 12) {
                $errors["plazo"] = ["El plazo no puede ser mayor a 12 semanas"];
            }
        }
        $cliente = $datos["cliente"];
        if (!$cliente["nombre"] || trim($cliente["nombre"]) == '') {
            $errors["nombre"] = ["Debes ingresar ingresar el nombre del cliente"];
        }
        if (!$cliente["paterno"] || trim($cliente["paterno"]) == '') {
            $errors["paterno"] = ["Debes ingresar el apellido paterno del cliente"];
        }

        if (count($errors) > 0) {
            return response()->JSON([
                "errors" => $errors
            ], 422);
        }
        try {
            $interes = Interes::get()->last();
            $valor_interes = 4.9;
            if ($interes) {
                $valor_interes = (float)$interes->interes;
            }
            $interes_semanal = ($valor_interes / 4) / 100;
            $interes_semanal = round($interes_semanal, 5);
            $interes_semanal = (float)$interes_semanal;
            $cuota_fija = self::getCuotaFija($datos["monto"], $datos["plazo"], $interes_semanal);
            $plan_pago = self::getPlanPago($datos["monto"], $datos["plazo"], $cuota_fija, $interes_semanal);

            $convertir = new NumeroALetras();
            $array_monto = explode('.', $datos["monto"]);

            $literal = $convertir->convertir($array_monto[0]);
            $literal .= " " . (isset($array_monto[1]) ? $array_monto[1] : '00') . "/100." . " Bolivianos";
            $simulacion = true;
            $pdf = PDF::loadView('reportes.plan_pago', compact('datos', "interes_semanal", "cuota_fija", "plan_pago", "literal", "valor_interes", "simulacion"))->setPaper('letter', 'portrait');

            // ENUMERAR LAS PÁGINAS USANDO CANVAS
            $pdf->output();
            $dom_pdf = $pdf->getDomPDF();
            $canvas = $dom_pdf->get_canvas();
            $alto = $canvas->get_height();
            $ancho = $canvas->get_width();
            $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

            return $pdf->download('PlanPagoSimulacion.pdf');
        } catch (\Exception $e) {
            return response()->JSON([
                "message" => $e->getMessage()
            ], 400);
        }
    }

    public function plan_reimpresion(Request $request)
    {
        $datos = self::armarDatos($request);

        try {
            $interes = Interes::get()->last();
            $valor_interes = 4.9;
            if ($interes) {
                $valor_interes = (float)$interes->interes;
            }
            $interes_semanal = ($valor_interes / 4) / 100;
            $interes_semanal = round($interes_semanal, 5);
            $interes_semanal = (float)$interes_semanal;
            $cuota_fija = self::getCuotaFija($datos["monto"], $datos["plazo"], $interes_semanal);
            $prestamo = Prestamo::find($request->id);
            if (count($prestamo->plan_pagos) > 0) {
                $plan_pago = $prestamo->plan_pagos;
            } else {
                $plan_pago = self::getPlanPago($datos["monto"], $datos["plazo"], $cuota_fija, $interes_semanal);
            }

            $convertir = new NumeroALetras();
            $array_monto = explode('.', $datos["monto"]);

            $literal = $convertir->convertir($array_monto[0]);
            $literal .= " " . (isset($array_monto[1]) ? $array_monto[1] : '00') . "/100." . " Bolivianos";
            $pdf = PDF::loadView('reportes.plan_pago', compact('datos', "interes_semanal", "cuota_fija", "plan_pago", "literal", "valor_interes"))->setPaper('letter', 'portrait');

            // ENUMERAR LAS PÁGINAS USANDO CANVAS
            $pdf->output();
            $dom_pdf = $pdf->getDomPDF();
            $canvas = $dom_pdf->get_canvas();
            $alto = $canvas->get_height();
            $ancho = $canvas->get_width();
            $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

            return $pdf->download('PlanPagoSimulacion.pdf');
        } catch (\Exception $e) {
            return response()->JSON([
                "message" => $e->getMessage()
            ], 400);
        }
    }
    public function plan_pago_individual(Request $request)
    {
        $datos = self::armarDatos($request);

        $valida_monto = isset($request->valida_monto) ? $request->valida_monto : true;
        $errors = self::validarPlanPagosIndividual($datos, $valida_monto);
        if (count($errors) > 0) {
            return response()->JSON([
                "errors" => $errors
            ], 422);
        }
        try {
            $interes = Interes::get()->last();
            $valor_interes = 4.9;
            if ($interes) {
                $valor_interes = (float)$interes->interes;
            }
            $interes_semanal = ($valor_interes / 4) / 100;
            $interes_semanal = round($interes_semanal, 5);
            $interes_semanal = (float)$interes_semanal;
            $cuota_fija = self::getCuotaFija($datos["monto"], $datos["plazo"], $interes_semanal);
            $plan_pago = self::getPlanPago($datos["monto"], $datos["plazo"], $cuota_fija, $interes_semanal);

            $convertir = new NumeroALetras();
            $array_monto = explode('.', $datos["monto"]);

            $literal = $convertir->convertir($array_monto[0]);
            $literal .= " " . (isset($array_monto[1]) ? $array_monto[1] : '00') . "/100." . " Bolivianos";
            $pdf = PDF::loadView('reportes.plan_pago', compact('datos', "interes_semanal", "cuota_fija", "plan_pago", "literal", "valor_interes"))->setPaper('letter', 'portrait');

            // ENUMERAR LAS PÁGINAS USANDO CANVAS
            $pdf->output();
            $dom_pdf = $pdf->getDomPDF();
            $canvas = $dom_pdf->get_canvas();
            $alto = $canvas->get_height();
            $ancho = $canvas->get_width();
            $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

            return $pdf->download('PlanPagoSimulacion.pdf');
        } catch (\Exception $e) {
            return response()->JSON([
                "message" => $e->getMessage()
            ], 400);
        }
    }

    public function plan_pago_grupal(Request $request)
    {
        $datos = PrestamoGrupalController::armarDatos($request);
        try {
            $interes = Interes::get()->last();
            $valor_interes = 4.9;
            if ($interes) {
                $valor_interes = (float)$interes->interes;
            }
            $interes_semanal = ($valor_interes / 4) / 100;
            $interes_semanal = round($interes_semanal, 5);
            $interes_semanal = (float)$interes_semanal;
            $cuota_fija = self::getCuotaFija($datos["monto"], $datos["plazo"], $interes_semanal);

            $convertir = new NumeroALetras();
            $array_monto = explode('.', $datos["monto"]);
            $literal = $convertir->convertir($array_monto[0]);
            $literal .= " " . (isset($array_monto[1]) ? $array_monto[1] : '00') . "/100." . " Bolivianos";

            $id = 0;
            $grupo = null;
            if ($datos["id"] != 0) {
                $grupo = Grupo::find($datos["id"]);
                $datos["prestamos"] = $grupo->prestamos;
                $plan_pago = $grupo->grupo_plan_pagos;
            } else {
                $plan_pago = self::getPlanPago($datos["monto"], $datos["plazo"], $cuota_fija, $interes_semanal);
            }

            $pdf = PDF::loadView('reportes.plan_pago_grupal', compact('datos', "interes_semanal", "cuota_fija", "plan_pago", "literal", "valor_interes", "grupo", "convertir"))->setPaper('letter', 'portrait');

            // ENUMERAR LAS PÁGINAS USANDO CANVAS
            $pdf->output();
            $dom_pdf = $pdf->getDomPDF();
            $canvas = $dom_pdf->get_canvas();
            $alto = $canvas->get_height();
            $ancho = $canvas->get_width();
            $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

            return $pdf->download('PlanPagoSimulacion.pdf');
        } catch (\Exception $e) {
            return response()->JSON([
                "message" => $e->getMessage()
            ], 400);
        }
    }

    public function contrato_individual(Prestamo $prestamo)
    {
        try {
            $interes = Interes::get()->last();
            $valor_interes = 4.9;
            if ($interes) {
                $valor_interes = (float)$interes->interes;
            }

            $convertir = new NumeroALetras();
            $array_monto = explode('.', $prestamo->monto);
            $literal = $convertir->convertir($array_monto[0]);
            $literal .= " " . $array_monto[1] . "/100." . " Bolivianos";
            $pdf = PDF::loadView('reportes.contrato_individual', compact('prestamo', "literal", "valor_interes"))->setPaper('legal', 'portrait');

            // ENUMERAR LAS PÁGINAS USANDO CANVAS
            $pdf->output();
            $dom_pdf = $pdf->getDomPDF();
            $canvas = $dom_pdf->get_canvas();
            $alto = $canvas->get_height();
            $ancho = $canvas->get_width();
            $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

            return $pdf->download('PlanPagoSimulacion.pdf');
        } catch (\Exception $e) {
            return response()->JSON([
                "message" => $e->getMessage()
            ], 400);
        }
    }

    public function contrato_grupal(Grupo $grupo)
    {
        try {
            $interes = Interes::get()->last();
            $valor_interes = 4.9;
            if ($interes) {
                $valor_interes = (float)$interes->interes;
            }
            $convertir = new NumeroALetras();
            $array_monto = explode('.', $grupo->monto);
            $literal = $convertir->convertir($array_monto[0]);
            $literal .= " " . $array_monto[1] . "/100." . " Bolivianos";
            $pdf = PDF::loadView('reportes.contrato_grupal', compact('grupo', "literal", "valor_interes"))->setPaper('legal', 'portrait');

            // ENUMERAR LAS PÁGINAS USANDO CANVAS
            $pdf->output();
            $dom_pdf = $pdf->getDomPDF();
            $canvas = $dom_pdf->get_canvas();
            $alto = $canvas->get_height();
            $ancho = $canvas->get_width();
            $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

            return $pdf->download('PlanPagoSimulacion.pdf');
        } catch (\Exception $e) {
            return response()->JSON([
                "message" => $e->getMessage()
            ], 400);
        }
    }

    public static function armarDatos($request)
    {
        $datos = [
            "registrar_como" => $request["registrar_como"],
            "user_id" => $request["user_id"],
            "cliente_id" => $request["cliente_id"],
            "tipo" => $request["tipo"],
            "grupo_id" => $request["grupo_id"],
            "monto" => $request["monto"],
            "plazo" => $request["plazo"],
            "f_ci" => $request["f_ci"],
            "f_luz" => $request["f_luz"],
            "f_agua" => $request["f_agua"],
            "croquis" => $request["croquis"],
            "documento_1" => $request["documento_1"],
            "documento_2" => $request["documento_2"],
            "documento_3" => $request["documento_3"],
            "documento_4" => $request["documento_4"],
            "estado" => $request["estado"],
            "cliente" => [
                "id" => $request["cliente"]["id"],
                "nombre" => $request["cliente"]["nombre"],
                "segundo_nombre" => $request["cliente"]["segundo_nombre"],
                "paterno" => $request["cliente"]["paterno"],
                "materno" => $request["cliente"]["materno"],
                "dir" => $request["cliente"]["dir"],
                "ci" => $request["cliente"]["ci"],
                "ci_exp" => $request["cliente"]["ci_exp"],
                "cel" => $request["cliente"]["cel"],
                "fono" => $request["cliente"]["fono"],
                "edad" => $request["cliente"]["edad"],
                "referencia" => $request["cliente"]["referencia"],
                "cel_ref" => $request["cliente"]["cel_ref"],
                "parentesco" => $request["cliente"]["parentesco"],
            ]
        ];


        return $datos;
    }

    public static function getCuotaFija($monto, $plazo, $interes_semanal)
    {
        $cuota_fija = (float)$interes_semanal * (float)$monto;
        $cuota_fija = $cuota_fija / (1 - pow(1 + (float)$interes_semanal, -(float)$plazo));
        $cuota_fija = round($cuota_fija, 2);
        return $cuota_fija;
    }

    public static function getPlanPago($monto, $plazo, $cuota_fija, $interes_semanal)
    {
        $plan_pago = [];
        $interes_inicial = (float)$monto * (float)$interes_semanal;
        $interes_inicial = floor($interes_inicial * 100000) / 100000;
        $index = 0;
        for ($i = 1; $i <= $plazo; $i++) {
            $saldo_inicial = $monto;
            $interes = $interes_inicial;
            if ($i > 1) {
                $saldo_inicial = (float)$plan_pago[$index - 1]["saldo_inicial"] - (float)$plan_pago[$index - 1]["capital"];
                $interes = (float)$saldo_inicial * (float)$interes_semanal;
                $interes = floor($interes * 100000) / 100000;
            }
            $capital = (float)$cuota_fija - (float)$interes;
            $capital =  floor($capital * 100) / 100;;
            $saldo = (float)$saldo_inicial - (float)$capital;
            $saldo =  floor($saldo * 100) / 100;;
            if ($i == $plazo) {
                if ($saldo_inicial != $capital) {
                    $saldo = 0;
                    if ($saldo_inicial < $capital) {
                        $saldo_inicial = $capital;
                    } else {
                        $capital = $saldo_inicial;
                    }
                }
            }
            $plan_pago[] = [
                "nro" => $i,
                "saldo_inicial" => $saldo_inicial,
                "capital" => $capital,
                "interes" => $interes,
                "saldo" => $saldo,
            ];
            $index++;
        }
        return $plan_pago;
    }

    public static function validarPlanPagosIndividual($datos, $valida_monto = true)
    {
        $errors = [];
        if (trim($datos["monto"]) == '' || (float)$datos["monto"] <= 0) {
            $errors["monto"] = ["Debes ingresar un monto valido"];
        } elseif (!filter_var((float)$datos["monto"], FILTER_VALIDATE_INT) && $valida_monto) {
            $errors["monto"] = ["El monto debe ser un número entero"];
        }
        if (trim($datos["plazo"]) == '' || (float)$datos["plazo"] <= 0) {
            $errors["plazo"] = ["Debes ingresar un plazo valido"];
        } else {
            if ((float)$datos["plazo"] > 12) {
                $errors["plazo"] = ["El plazo no puede ser mayor a 12 semanas"];
            }
        }
        if (trim($datos["f_ci"]) == '' || !(float)$datos["f_ci"]) {
            $errors["f_ci"] = ["La fotocopia de C.I. es oblitagoria"];
        }
        if (trim($datos["f_luz"]) == '' || !(float)$datos["f_luz"]) {
            $errors["f_luz"] = ["La fotocopia de luz es oblitagoria"];
        }
        if (trim($datos["f_agua"]) == '' || !(float)$datos["f_agua"]) {
            $errors["f_agua"] = ["La fotocopia de agua es oblitagoria"];
        }
        if (trim($datos["croquis"]) == '' || !(float)$datos["croquis"]) {
            $errors["croquis"] = ["El croquis es oblitagorio"];
        }

        $registrar_como = $datos["registrar_como"];
        $cliente = $datos["cliente"];
        if (!$cliente["nombre"] || trim($cliente["nombre"]) == '') {
            $errors["nombre"] = ["Debes ingresar ingresar el nombre del cliente"];
        } elseif (!preg_match('/^[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ\s]+$/', $cliente["nombre"])) {
            $errors["nombre"] = ["El nombre solo debe contener letras"];
        }
        if (!$cliente["paterno"] || trim($cliente["paterno"]) == '') {
            $errors["paterno"] = ["Debes ingresar el apellido paterno del cliente"];
        } elseif (!preg_match('/^[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ\s]+$/', $cliente["paterno"])) {
            $errors["paterno"] = ["El apellido paterno solo debe contener letras"];
        }
        if ($cliente["segundo_nombre"] || trim($cliente["segundo_nombre"]) != '') {
            if (!preg_match('/^[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ\s]+$/', $cliente["segundo_nombre"])) {
                $errors["segundo_nombre"] = ["El segundo nombre solo debe contener letras"];
            }
        }
        if ($cliente["materno"] || trim($cliente["materno"]) != '') {
            if (!preg_match('/^[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ\s]+$/', $cliente["materno"])) {
                $errors["materno"] = ["El apellido materno solo debe contener letras"];
            }
        }

        if ($registrar_como == 'NUEVO') {
            $existe_ci = Cliente::where("ci", $datos["cliente"]["ci"])->get()->first();
            if ($existe_ci) {
                $errors["ci"] = ["Ya hay un cliente registrado con el C.I. " . $datos["cliente"]["ci"]];
            }
        } else {
            $existe_ci = Cliente::where("ci", $datos["cliente"]["ci"])->where("id", "!=", $datos["cliente"]["id"])->get()->first();
            if ($existe_ci) {
                $errors["ci"] = ["Ya hay un cliente registrado con el C.I. " . $datos["cliente"]["ci"]];
            }
        }

        if (!$cliente["ci"] || trim($cliente["ci"]) == '') {
            $errors["ci"] = ["Debes ingresar el C.I. del cliente"];
        } elseif (!ctype_digit($cliente["ci"])) {
            $errors["ci"] = ["El nro. de C.I. solo debe contener números"];
        }
        if (!$cliente["ci_exp"] || trim($cliente["ci_exp"]) == '') {
            $errors["ci_exp"] = ["Debes seleccionar el campo Expedido"];
        }
        if (!$cliente["cel"] || trim($cliente["cel"]) == '') {
            $errors["cel"] = ["Debes ingresar el celular del cliente"];
        } elseif (!preg_match('/^[0-9]{8}$/', $cliente["cel"])) {
            $errors["cel"] = ["El número de celular debe tener 8 dígitos y ser numérico"];
        }
        if (!$cliente["edad"] || trim($cliente["edad"]) == '') {
            $errors["edad"] = ["Debes ingresar la edad del cliente"];
        }
        if (!$cliente["dir"] || trim($cliente["dir"]) == '') {
            $errors["dir"] = ["Debes ingresar la dirección del cliente"];
        }
        if (!$cliente["referencia"] || trim($cliente["referencia"]) == '') {
            $errors["referencia"] = ["Debes ingresar la referencia del cliente"];
        }
        if (!$cliente["cel_ref"] || trim($cliente["cel_ref"]) == '') {
            $errors["cel_ref"] = ["Debes ingresar el celular de referencia del cliente"];
        } elseif (!preg_match('/^[0-9]{8}$/', $cliente["cel"])) {
            $errors["cel_ref"] = ["El número de celular debe tener 8 dígitos y ser numérico"];
        }
        if (!$cliente["parentesco"] || trim($cliente["parentesco"]) == '') {
            $errors["parentesco"] = ["Debes ingresar el parentesco"];
        }
        return $errors;
    }
}
