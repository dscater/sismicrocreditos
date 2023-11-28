<?php

namespace App\Http\Controllers;

use App\Models\Cliente;
use App\Models\HistorialAccion;
use App\Models\Interes;
use App\Models\Prestamo;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class PrestamoIndividualController extends Controller
{
    public function cliente_ci(Request $request)
    {
        $cliente = Cliente::where("ci", $request->ci)->get()->first();
        $prestamos = [];
        if ($cliente) {
            $filtro = $request->filtro;
            $prestamos = Prestamo::with(["cliente", "pagos"])->where("cliente_id", $cliente->id)->where("tipo", "INDIVIDUAL")->orderBy("id", "desc")->get();
        }
        return response()->JSON([
            "sw" => true,
            "prestamos" => $prestamos
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
            $prestamo->fecha_desembolso = NULL;
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
        $datos = PrestamoController::armarDatos($request);

        $errors = PrestamoController::validarPlanPagosIndividual($datos);
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
}
