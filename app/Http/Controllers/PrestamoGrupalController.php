<?php

namespace App\Http\Controllers;

use App\Models\Cliente;
use App\Models\Grupo;
use App\Models\HistorialAccion;
use App\Models\Interes;
use App\Models\PlanPago;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class PrestamoGrupalController extends Controller
{
    public function grupo_nombre(Request $request)
    {
        $grupos = Grupo::with(["prestamos.cliente", "grupo_pagos"])->where("nombre", "LIKE", "%$request->nombre%")->orderBy("id", "desc")->get();
        return response()->JSON([
            "sw" => true,
            "grupos" => $grupos
        ]);
    }

    public function aprobar(Grupo $grupo, Request $request)
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

        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($grupo, "grupos");
            // actualizando el estado del grupo
            $grupo->estado = 'APROBADO';
            $grupo->user_aprobado_id = Auth::user()->id;
            $grupo->fecha_desembolso = $request->fecha_desembolso;
            $grupo->save();

            // actualizando el estado de los integrantes por separado
            foreach ($grupo->prestamos  as $prestamo) {
                $prestamo->estado = 'APROBADO';
                $prestamo->user_aprobado_id = Auth::user()->id;
                $prestamo->fecha_desembolso = $request->fecha_desembolso;
                $prestamo->save();
            }

            // registrar las fechas de pagos
            $plan_pagos = $grupo->grupo_plan_pagos;
            $fecha_desembolso = $grupo->fecha_desembolso;
            $fecha_proximo_pago = $fecha_desembolso;
            foreach ($plan_pagos as $key => $pp) {
                $fecha_proximo_pago = date("Y-m-d", strtotime($fecha_proximo_pago . "+7days"));
                $pp->fecha_pago = $fecha_proximo_pago;
                $pp->save();
            }

            // actualizar el plan por separado de los prestamos
            $grupo_plan_pagos = $grupo->grupo_plan_pagos;
            foreach ($grupo->prestamos as $prestamo) {
                foreach ($grupo_plan_pagos as $gpp) {
                    $pp = PlanPago::where("prestamo_id", $prestamo->id)->where("nro_cuota", $gpp->nro_cuota)->get()->first();
                    $pp->fecha_pago = $gpp->fecha_pago;
                    $pp->save();
                }
                $prestamo->user_desembolso_id = Auth::user()->id;
                $prestamo->desembolso = 1;
                $prestamo->save();
            }

            $datos_nuevo = HistorialAccion::getDetalleRegistro($grupo, "grupos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' APROBO UN PRÉSTAMO GRUPAL',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'PRESTAMOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);
            DB::commit();
            return response()->JSON([
                'sw' => true,
                'grupo' => $grupo,
                'msj' => 'El préstamo se aprobo correctamente',
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->JSON([
                "message" => $e->getMessage()
            ], 400);
        }
    }

    public function rechazar(Grupo $grupo)
    {
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($grupo, "grupos");
            // actualizando el estado del grupo
            $grupo->estado = 'RECHAZADO';
            $grupo->user_aprobado_id = NULL;
            $grupo->fecha_desembolso = NULL;
            $grupo->save();
            // actualizando el estado de los integrantes por separado
            foreach ($grupo->prestamos  as $prestamo) {
                $prestamo->estado = 'RECHAZADO';
                $prestamo->user_aprobado_id = NULL;
                $prestamo->fecha_desembolso = NULL;
                $prestamo->save();
            }

            $datos_nuevo = HistorialAccion::getDetalleRegistro($grupo, "grupos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' RECHAZO UN PRÉSTAMO GRUPAL',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'PRESTAMOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);
            DB::commit();
            return response()->JSON([
                'sw' => true,
                'grupo' => $grupo,
                'msj' => 'El préstamo se rechazo correctamente',
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->JSON([
                "message" => $e->getMessage()
            ], 400);
        }
    }

    public function store(Request $request)
    {
        $datos = PrestamoGrupalController::armarDatos($request);
        $errors = PrestamoGrupalController::validarFormulario($datos);
        if (count($errors) > 0) {
            return response()->JSON([
                "errors" => $errors
            ], 422);
        }
        DB::beginTransaction();
        try {
            $interes = Interes::get()->last();
            $valor_interes = 4.9;
            if ($interes) {
                $valor_interes = (float)$interes->interes;
            }
            $interes_semanal = ($valor_interes / 4) / 100;
            $interes_semanal = round($interes_semanal, 5);
            $interes_semanal = (float)$interes_semanal;


            // REGISTRAR EL GRUPO
            $grupo = Grupo::create([
                "user_id" => Auth::user()->id,
                "nombre" => mb_strtoupper($datos["nombre"]),
                "integrantes" => $datos["integrantes"],
                "monto" => $datos["monto"],
                "plazo" => $datos["plazo"],
                "estado" => "PRE APROBADO",
                "fecha_registro" => date("Y-m-d")
            ]);

            // REGISTRAR LOS PRESTAMOS CON SU PLAN DE PAGO
            foreach ($datos["prestamos"] as $dp) {
                $cuota_fija = PrestamoController::getCuotaFija($dp["monto"], $grupo->plazo, $interes_semanal);
                $plan_pago = PrestamoController::getPlanPago($dp["monto"], $grupo->plazo, $cuota_fija, $interes_semanal);

                if (isset($dp["registrar_como"]) && $dp["registrar_como"] == "NUEVO") {
                    $cliente = Cliente::create([
                        "nombre" => mb_strtoupper($dp["cliente"]["nombre"]),
                        "segundo_nombre" => mb_strtoupper($dp["cliente"]["segundo_nombre"]),
                        "paterno" => mb_strtoupper($dp["cliente"]["paterno"]),
                        "materno" => mb_strtoupper($dp["cliente"]["materno"]),
                        "dir" => mb_strtoupper($dp["cliente"]["dir"]),
                        "ci" => mb_strtoupper($dp["cliente"]["ci"]),
                        "ci_exp" => mb_strtoupper($dp["cliente"]["ci_exp"]),
                        "cel" => mb_strtoupper($dp["cliente"]["cel"]),
                        "fono" => mb_strtoupper($dp["cliente"]["fono"]),
                        "edad" => mb_strtoupper($dp["cliente"]["edad"]),
                        "referencia" => mb_strtoupper($dp["cliente"]["referencia"]),
                        "cel_ref" => mb_strtoupper($dp["cliente"]["cel_ref"]),
                        "parentesco" => mb_strtoupper($dp["cliente"]["parentesco"]),
                        "fecha_registro" => date("Y-m-d")
                    ]);
                } else {
                    $cliente = Cliente::findOrFail($dp["cliente"]["id"]);
                }

                $nuevo_prestamo = $grupo->prestamos()->create([
                    "user_id" => Auth::user()->id,
                    "cliente_id" => $cliente->id,
                    "tipo" => "GRUPAL",
                    "monto" => $dp["monto"],
                    "plazo" => $grupo->plazo,
                    "f_ci" => (int)$dp["f_ci"],
                    "f_luz" => (int)$dp["f_luz"],
                    "f_agua" => (int)$dp["f_agua"],
                    "croquis" => (int)$dp["croquis"],
                    "documento_1" => $dp["documento_1"],
                    "documento_2" => $dp["documento_2"],
                    "documento_3" => $dp["documento_3"],
                    "documento_4" => $dp["documento_4"],
                    "estado" => $grupo->estado,
                    "fecha_registro" => date("Y-m-d")
                ]);

                // registrar plan de pago
                foreach ($plan_pago as $pp) {
                    $nuevo_prestamo->plan_pagos()->create([
                        "nro_cuota" => $pp["nro"],
                        "saldo_inicial" => $pp["saldo_inicial"],
                        "capital" => $pp["capital"],
                        "interes" => $pp["interes"],
                        "saldo" => $pp["saldo"],
                        "cuota" => $cuota_fija,
                        "cancelado" => "NO",
                    ]);
                }

                $datos_original = HistorialAccion::getDetalleRegistro($nuevo_prestamo, "prestamos");
                HistorialAccion::create([
                    'user_id' => Auth::user()->id,
                    'accion' => 'CREACIÓN',
                    'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' REGISTRO UN PRESTAMO',
                    'datos_original' => $datos_original,
                    'modulo' => 'PRESTAMOS',
                    'fecha' => date('Y-m-d'),
                    'hora' => date('H:i:s')
                ]);
            }

            // REGISTRAR EL PLAN DE PAGOS GRUPAL
            $cuota_fija = PrestamoController::getCuotaFija($grupo->monto, $grupo->plazo, $interes_semanal);
            $plan_pago = PrestamoController::getPlanPago($grupo->monto, $grupo->plazo, $cuota_fija, $interes_semanal);
            foreach ($plan_pago as $pp) {
                $grupo->grupo_plan_pagos()->create([
                    "nro_cuota" => $pp["nro"],
                    "saldo_inicial" => $pp["saldo_inicial"],
                    "capital" => $pp["capital"],
                    "interes" => $pp["interes"],
                    "saldo" => $pp["saldo"],
                    "cuota" => $cuota_fija,
                    "cancelado" => "NO",
                ]);
            }

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'grupo' => $grupo,
                'msj' => 'El registro se realizó de forma correcta',
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->JSON([
                "message" => $e->getMessage()
            ], 400);
        }
    }

    public static function armarDatos($request)
    {
        $datos = [
            "id" => isset($request->id) ? $request->id : 0,
            "nombre" => $request->nombre,
            "integrantes" => $request->integrantes,
            "monto" => $request->monto,
            "plazo" => $request->plazo,
            "prestamos" => []
        ];
        if ($request["prestamos"]) {
            foreach ($request["prestamos"] as $prestamo) {
                $datos["prestamos"][] = [
                    "registrar_como" => isset($prestamo["registrar_como"]) ? $prestamo["registrar_como"] : '',
                    "user_id" => $prestamo["user_id"],
                    "cliente_id" => $prestamo["cliente_id"],
                    "tipo" => $prestamo["tipo"],
                    "grupo_id" => $prestamo["grupo_id"],
                    "monto" => $prestamo["monto"],
                    "plazo" => $prestamo["plazo"],
                    "f_ci" => $prestamo["f_ci"],
                    "f_luz" => $prestamo["f_luz"],
                    "f_agua" => $prestamo["f_agua"],
                    "croquis" => $prestamo["croquis"],
                    "documento_1" => $prestamo["documento_1"],
                    "documento_2" => $prestamo["documento_2"],
                    "documento_3" => $prestamo["documento_3"],
                    "documento_4" => $prestamo["documento_4"],
                    "estado" => $prestamo["estado"],
                    "cliente" => [
                        "id" => $prestamo["cliente"]["id"],
                        "nombre" => $prestamo["cliente"]["nombre"],
                        "segundo_nombre" => $prestamo["cliente"]["segundo_nombre"],
                        "paterno" => $prestamo["cliente"]["paterno"],
                        "materno" => $prestamo["cliente"]["materno"],
                        "dir" => $prestamo["cliente"]["dir"],
                        "ci" => $prestamo["cliente"]["ci"],
                        "ci_exp" => $prestamo["cliente"]["ci_exp"],
                        "cel" => $prestamo["cliente"]["cel"],
                        "fono" => $prestamo["cliente"]["fono"],
                        "edad" => $prestamo["cliente"]["edad"],
                        "referencia" => $prestamo["cliente"]["referencia"],
                        "cel_ref" => $prestamo["cliente"]["cel_ref"],
                        "parentesco" => $prestamo["cliente"]["parentesco"],
                    ]
                ];
            }
        }
        return $datos;
    }

    public static function validarFormulario($datos)
    {
        $errors = [];
        if (!$datos["nombre"]  || trim($datos["nombre"]) == '') {
            $errors["nombre"] = ["Debes ingresar un nombre de grupo"];
        }
        if (!preg_match('/^[a-zA-Z\s]+$/', $datos["nombre"])) {
            $errors["nombre"] = ["El nombre del grupo solo debe contener solo letras y espacios"];
        }

        $existe_grupo = Grupo::where("nombre", trim($datos["nombre"]))->get()->first();
        if ($existe_grupo) {
            $errors["nombre"] = ["El nombre de grupo ingresado ya éxiste"];
        }

        if (trim($datos["integrantes"]) == '' || (float)$datos["integrantes"] <= 0) {
            $errors["integrantes"] = ["Debes ingresar la cantidad de integrantes del grupo"];
        }

        if ($datos["integrantes"] < 2 || $datos["integrantes"] > 3) {
            $errors["integrantes"] = ["La cantidad de integrantes permitido es de 2 ó 3"];
        }
        if (trim($datos["monto"]) == '' || (float)$datos["monto"] <= 0) {
            $errors["monto"] = ["Debes ingresar un monto valido"];
        }

        $prestamos = count($datos["prestamos"]);
        if (!$prestamos || $prestamos <= 0) {
            $errors["prestamos"] = ["Debes agregar por lo menos dos préstamos"];
        }

        if (self::getSumaPrestamos($datos["prestamos"]) != (float)$datos["monto"]) {
            $errors["monto_grupal"] = ["La suma de montos de cada integrantes es de <strong>" . self::getSumaPrestamos($datos["prestamos"]) . "</strong> debe ser igual al monto grupal <strong>" . $datos["monto"] . "</strong>"];
        }

        foreach ($datos["prestamos"] as $key => $prestamo) {
            if (trim($prestamo["monto"]) == '' || (float)$prestamo["monto"] <= 0) {
                $errors["monto_" . $key] = ["Debes ingresar un monto valido - <strong>Integrante " . ($key + 1) . "</strong>"];
            }
            if (trim($prestamo["plazo"]) == '' || (float)$prestamo["plazo"] <= 0) {
                $errors["plazo_" . $key] = ["Debes ingresar un plazo valido - <strong>Integrante " . ($key + 1) . "</strong>"];
            } else {
                if ((float)$prestamo["plazo"] > 12) {
                    $errors["plazo_" . $key] = ["El plazo no puede ser mayor a 12 semanas - <strong>Integrante " . ($key + 1) . "</strong>"];
                }
            }
            if (trim($prestamo["f_ci"]) == '' || !(float)$prestamo["f_ci"]) {
                $errors["f_ci_" . $key] = ["La fotocopia de C.I. es oblitagoria - <strong>Integrante " . ($key + 1) . "</strong>"];
            }
            if (trim($prestamo["f_luz"]) == '' || !(float)$prestamo["f_luz"]) {
                $errors["f_luz_" . $key] = ["La fotocopia de luz es oblitagoria - <strong>Integrante " . ($key + 1) . "</strong>"];
            }
            if (trim($prestamo["f_agua"]) == '' || !(float)$prestamo["f_agua"]) {
                $errors["f_agua_" . $key] = ["La fotocopia de agua es oblitagoria - <strong>Integrante " . ($key + 1) . "</strong>"];
            }
            if (trim($prestamo["croquis"]) == '' || !(float)$prestamo["croquis"]) {
                $errors["croquis_" . $key] = ["El croquis es oblitagorio - <strong>Integrante " . ($key + 1) . "</strong>"];
            }

            $registrar_como = $prestamo["registrar_como"];
            $cliente = $prestamo["cliente"];
            if (!$cliente["nombre"] || trim($cliente["nombre"]) == '') {
                $errors["nombre_" . $key] = ["Debes ingresar ingresar el nombre del cliente - <strong>Integrante " . ($key + 1) . "</strong>"];
            }
            if (!$cliente["paterno"] || trim($cliente["paterno"]) == '') {
                $errors["paterno_" . $key] = ["Debes ingresar el apellido paterno del cliente - <strong>Integrante " . ($key + 1) . "</strong>"];
            }

            if ($registrar_como == 'NUEVO') {
                $existe_ci = Cliente::where("ci", $prestamo["cliente"]["ci"])->get()->first();
                if ($existe_ci) {
                    $errors["ci_" . $key] = ["Ya hay un cliente registrado con el C.I. " . $prestamo["cliente"]["ci"] . " - <strong>Integrante " . ($key + 1) . "</strong>"];
                }
            } else {
                $existe_ci = Cliente::where("ci", $prestamo["cliente"]["ci"])->where("id", "!=", $prestamo["cliente"]["id"])->get()->first();
                if ($existe_ci) {
                    $errors["ci_" . $key] = ["Ya hay un cliente registrado con el C.I. " . $prestamo["cliente"]["ci"] . " - <strong>Integrante " . ($key + 1) . "</strong>"];
                }
            }

            if (!$cliente["ci"] || trim($cliente["ci"]) == '') {
                $errors["ci_" . $key] = ["Debes ingresar el C.I. del cliente - <strong>Integrante " . ($key + 1) . "</strong>"];
            }
            if (!$cliente["ci_exp"] || trim($cliente["ci_exp"]) == '') {
                $errors["ci_exp_" . $key] = ["Debes seleccionar el campo Expedido - <strong>Integrante " . ($key + 1) . "</strong>"];
            }
            if (!$cliente["cel"] || trim($cliente["cel"]) == '') {
                $errors["cel_" . $key] = ["Debes ingresar el celular del cliente - <strong>Integrante " . ($key + 1) . "</strong>"];
            }
            if (!$cliente["edad"] || trim($cliente["edad"]) == '') {
                $errors["edad_" . $key] = ["Debes ingresar la edad del cliente - <strong>Integrante " . ($key + 1) . "</strong>"];
            }
            if (!$cliente["referencia"] || trim($cliente["referencia"]) == '') {
                $errors["referencia_" . $key] = ["Debes ingresar la referencia del cliente - <strong>Integrante " . ($key + 1) . "</strong>"];
            }
            if (!$cliente["cel_ref"] || trim($cliente["cel_ref"]) == '') {
                $errors["cel_ref_" . $key] = ["Debes ingresar el celular de referencia del cliente - <strong>Integrante " . ($key + 1) . "</strong>"];
            }
            if (!$cliente["parentesco"] || trim($cliente["parentesco"]) == '') {
                $errors["parentesco_" . $key] = ["Debes ingresar el parentesco - <strong>Integrante " . ($key + 1) . "</strong>"];
            }
        }
        return $errors;
    }

    public static function getSumaPrestamos($prestamos)
    {
        $suma = 0;
        foreach ($prestamos  as $p) {
            $suma += (float)$p["monto"];
        }
        return $suma;
    }
}
