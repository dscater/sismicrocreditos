<?php

namespace App\Http\Controllers;

use App\Models\Grupo;
use Illuminate\Http\Request;

class PrestamoGrupalController extends Controller
{
    public function grupo_nombre(Request $request)
    {
        return response()->JSON([
            "sw" => true,
        ]);
    }

    public function aprobar(Prestamo $prestamo, Request $request)
    {
        $request->validate([
            "fecha_desembolso" => "required|date"
        ], [
            "fecha_desembolso.required" => "Debes seleccionar una fecha",
            "fecha_desembolso.date" => "Debes ingresar una fecha valida",
        ]);

        $fecha_actual = date("Y-m-d");
        if ($request->fecha_desembolso <= $fecha_actual) {
            return response()->JSON([
                "errors" => [
                    "fecha_desembolso" => ["La fecha ingresada no puede ser igual o menor a la fecha actual"]
                ]
            ], 422);
        }

        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($prestamo, "prestamos");
            $prestamo->estado = 'APROBADO';
            $prestamo->fecha_desembolso = $request->fecha_desembolso;
            $prestamo->save();

            $datos_nuevo = HistorialAccion::getDetalleRegistro($prestamo, "prestamos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' APROBO UN PRÉSTAMO',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'PRESTAMOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);
            DB::commit();
            return response()->JSON([
                'sw' => true,
                'prestamo' => $prestamo,
                'msj' => 'El préstamo se aprobo correctamente',
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->JSON([
                "message" => $e->getMessage()
            ], 400);
        }
    }

    public function rechazar(Prestamo $prestamo)
    {
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($prestamo, "prestamos");
            $prestamo->estado = 'RECHAZADO';
            $prestamo->save();

            $datos_nuevo = HistorialAccion::getDetalleRegistro($prestamo, "prestamos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' RECHAZO UN PRÉSTAMO',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'PRESTAMOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);
            DB::commit();
            return response()->JSON([
                'sw' => true,
                'prestamo' => $prestamo,
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
            $cuota_fija = PrestamoController::getCuotaFija($datos["monto"], $datos["plazo"], $interes_semanal);
            $plan_pago = PrestamoController::getPlanPago($datos["monto"], $datos["plazo"], $cuota_fija, $interes_semanal);

            if ($datos["registrar_como"] == "NUEVO") {
                $cliente = Cliente::create([
                    "nombre" => mb_strtoupper($datos["cliente"]["nombre"]),
                    "segundo_nombre" => mb_strtoupper($datos["cliente"]["segundo_nombre"]),
                    "paterno" => mb_strtoupper($datos["cliente"]["paterno"]),
                    "materno" => mb_strtoupper($datos["cliente"]["materno"]),
                    "dir" => mb_strtoupper($datos["cliente"]["dir"]),
                    "ci" => mb_strtoupper($datos["cliente"]["ci"]),
                    "ci_exp" => mb_strtoupper($datos["cliente"]["ci_exp"]),
                    "cel" => mb_strtoupper($datos["cliente"]["cel"]),
                    "fono" => mb_strtoupper($datos["cliente"]["fono"]),
                    "edad" => mb_strtoupper($datos["cliente"]["edad"]),
                    "referencia" => mb_strtoupper($datos["cliente"]["referencia"]),
                    "cel_ref" => mb_strtoupper($datos["cliente"]["cel_ref"]),
                    "parentesco" => mb_strtoupper($datos["cliente"]["parentesco"]),
                    "fecha_registro" => date("Y-m-d")
                ]);
            } else {
                $cliente = Cliente::findOrFail($datos["cliente"]["id"]);
            }

            $nuevo_prestamo = Prestamo::create([
                "user_id" => Auth::user()->id,
                "cliente_id" => $cliente->id,
                "tipo" => "INDIVIDUAL",
                "monto" => $datos["monto"],
                "plazo" => $datos["plazo"],
                "f_ci" => (int)$datos["f_ci"],
                "f_luz" => (int)$datos["f_luz"],
                "f_agua" => (int)$datos["f_agua"],
                "croquis" => (int)$datos["croquis"],
                "documento_1" => $datos["documento_1"],
                "documento_2" => $datos["documento_2"],
                "documento_3" => $datos["documento_3"],
                "documento_4" => $datos["documento_4"],
                "estado" => "PRE APROBADO",
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


            DB::commit();
            return response()->JSON([
                'sw' => true,
                'prestamo' => $nuevo_prestamo,
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
            "nombre" => $request->nombre,
            "integrantes" => $request->integrantes,
            "monto" => $request->monto,
            "prestamos" => []
        ];
        if ($request["prestamos"]) {
            foreach ($request["prestamos"] as $prestamo) {
                $datos["prestamos"][] = [
                    "registrar_como" => $prestamo["registrar_como"],
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
        if (trim($datos["nombre"]) == '' || (float)$datos["nombre"] <= 0) {
            $errors["nombre"] = ["Debes ingresar un nombre de grupo"];
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

        foreach ($datos["prestamos"] as $key => $prestamo) {
            if (trim($datos["monto"]) == '' || (float)$datos["monto"] <= 0) {
                $errors["monto_" . $key] = ["Debes ingresar un monto valido - Integrante " . ($key + 1)];
            }
            if (trim($datos["plazo"]) == '' || (float)$datos["plazo"] <= 0) {
                $errors["plazo_" . $key] = ["Debes ingresar un plazo valido - Integrante " . ($key + 1)];
            } else {
                if ((float)$datos["plazo"] > 12) {
                    $errors["plazo_" . $key] = ["El plazo no puede ser mayor a 12 semanas - Integrante " . ($key + 1)];
                }
            }
            if (trim($datos["f_ci"]) == '' || !(float)$datos["f_ci"]) {
                $errors["f_ci_" . $key] = ["La fotocopia de C.I. es oblitagoria - Integrante " . ($key + 1)];
            }
            if (trim($datos["f_luz"]) == '' || !(float)$datos["f_luz"]) {
                $errors["f_luz_" . $key] = ["La fotocopia de luz es oblitagoria - Integrante " . ($key + 1)];
            }
            if (trim($datos["f_agua"]) == '' || !(float)$datos["f_agua"]) {
                $errors["f_agua_" . $key] = ["La fotocopia de agua es oblitagoria - Integrante " . ($key + 1)];
            }
            if (trim($datos["croquis"]) == '' || !(float)$datos["croquis"]) {
                $errors["croquis_" . $key] = ["El croquis es oblitagorio - Integrante " . ($key + 1)];
            }

            $registrar_como = $datos["registrar_como"];
            $cliente = $datos["cliente"];
            if (!$cliente["nombre"] || trim($cliente["nombre"]) == '') {
                $errors["nombre_" . $key] = ["Debes ingresar ingresar el nombre del cliente - Integrante " . ($key + 1)];
            }
            if (!$cliente["paterno"] || trim($cliente["paterno"]) == '') {
                $errors["paterno_" . $key] = ["Debes ingresar el apellido paterno del cliente - Integrante " . ($key + 1)];
            }

            if ($registrar_como == 'NUEVO') {
                $existe_ci = Cliente::where("ci", $datos["cliente"]["ci"])->get()->first();
                if ($existe_ci) {
                    $errors["ci_" . $key] = ["Ya hay un cliente registrado con el C.I. " . $datos["cliente"]["ci"] . " - Integrante " . ($key + 1)];
                }
            } else {
                $existe_ci = Cliente::where("ci", $datos["cliente"]["ci"])->where("id", "!=", $datos["cliente"]["id"])->get()->first();
                if ($existe_ci) {
                    $errors["ci_" . $key] = ["Ya hay un cliente registrado con el C.I. " . $datos["cliente"]["ci"] . " - Integrante " . ($key + 1)];
                }
            }

            if (!$cliente["ci"] || trim($cliente["ci"]) == '') {
                $errors["ci_" . $key] = ["Debes ingresar el C.I. del cliente - Integrante " . ($key + 1)];
            }
            if (!$cliente["ci_exp"] || trim($cliente["ci_exp"]) == '') {
                $errors["ci_exp_" . $key] = ["Debes seleccionar el campo Expedido - Integrante " . ($key + 1)];
            }
            if (!$cliente["cel"] || trim($cliente["cel"]) == '') {
                $errors["cel_" . $key] = ["Debes ingresar el celular del cliente - Integrante " . ($key + 1)];
            }
            if (!$cliente["edad"] || trim($cliente["edad"]) == '') {
                $errors["edad_" . $key] = ["Debes ingresar la edad del cliente - Integrante " . ($key + 1)];
            }
            if (!$cliente["referencia"] || trim($cliente["referencia"]) == '') {
                $errors["referencia_" . $key] = ["Debes ingresar la referencia del cliente - Integrante " . ($key + 1)];
            }
            if (!$cliente["cel_ref"] || trim($cliente["cel_ref"]) == '') {
                $errors["cel_ref_" . $key] = ["Debes ingresar el celular de referencia del cliente - Integrante " . ($key + 1)];
            }
            if (!$cliente["parentesco"] || trim($cliente["parentesco"]) == '') {
                $errors["parentesco_" . $key] = ["Debes ingresar el parentesco - Integrante " . ($key + 1)];
            }
        }
        return $errors;
    }
}
