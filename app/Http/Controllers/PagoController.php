<?php

namespace App\Http\Controllers;

use App\Models\Caja;
use App\Models\CajaMovimiento;
use App\Models\Grupo;
use App\Models\GrupoPago;
use App\Models\GrupoPlanPago;
use App\Models\HistorialAccion;
use App\Models\Pago;
use App\Models\PlanPago;
use App\Models\Prestamo;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use PDF;
use App\library\numero_a_letras\src\NumeroALetras;
use Illuminate\Support\Facades\Log;

class PagoController extends Controller
{
    public function store(Request $request)
    {
        DB::beginTransaction();
        try {
            $pago = Pago::create([
                "user_id" => Auth::user()->id,
                "tipo_prestamo" => "INDIVIDUAL",
                "prestamo_id" => $request->prestamo_id,
                "plan_pago_id" => $request->plan_pago_id,
                "cliente_id" => $request->cliente_id,
                "nro_cuota" => $request->nro_cuota ? $request->nro_cuota : 0,
                "monto" => $request->monto,
                "interes" => $request->interes,
                "dias_mora" => $request->dias_mora,
                "monto_mora" => $request->monto_mora,
                "monto_total" => $request->monto_total,
                "tipo_pago" => $request->tipo_pago,
                "fecha_pago" => date("Y-m-d"),
            ]);

            // registrar movimiento PAGO CUOTA
            CajaMovimiento::create([
                "caja_id" => 1,
                "user_id" => Auth::user()->id,
                "monto" => $pago->monto,
                "tipo" => "CRÉDITO",
                "glosa" => "PAGO CUOTA PRESTAMO",
                "tipo_prestamo" => "INDIVIDUAL",
                "prestamo_id" => $pago->prestamo_id,
                "fecha_registro" => date("Y-m-d")
            ]);

            // registrar movimiento INTERES
            CajaMovimiento::create([
                "caja_id" => 4,
                "user_id" => Auth::user()->id,
                "monto" => $pago->interes,
                "tipo" => "CRÉDITO",
                "glosa" => "INTERES",
                "tipo_prestamo" => "INDIVIDUAL",
                "prestamo_id" => $pago->prestamo_id,
                "fecha_registro" => date("Y-m-d")
            ]);

            if ((int)$pago->dias_mora > 0) {
                // registrar movimiento MORA si existe
                CajaMovimiento::create([
                    "caja_id" => 4,
                    "user_id" => Auth::user()->id,
                    "monto" => $pago->interes,
                    "tipo" => "CRÉDITO",
                    "glosa" => "PAGO MORA",
                    "tipo_prestamo" => "INDIVIDUAL",
                    "prestamo_id" => $pago->prestamo_id,
                    "fecha_registro" => date("Y-m-d")
                ]);
            }

            // actualizar saldos en cajas
            Caja::actualizaSaldos();

            if ($pago->tipo_pago == 'TOTAL') {
                // SE PAGO LA DEUDA TOTAL
                $prestamo = Prestamo::find($pago->prestamo_id);

                $plan_pagos = PlanPago::where("prestamo_id", $prestamo->id)
                    ->where("cancelado", "NO")
                    ->get();
                foreach ($plan_pagos as $plan_pago) {
                    $plan_pago->cancelado = "SI";
                    $plan_pago->save();
                }
                $prestamo->finalizado = 1;
                $prestamo->save();
            } else {
                // SE PAGO UNA CUOTA
                // Actualizar PLAN DE PAGO a CANCELADO(SI)
                $plan_pago = PlanPago::find($pago->plan_pago_id);
                $plan_pago->cancelado = "SI";
                $plan_pago->save();
                Pago::verifica_individual($pago->prestamo);
            }

            $datos_original = HistorialAccion::getDetalleRegistro($pago, "pagos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' REGISTRO EL PAGO DE UN PRESTAMO',
                'datos_original' => $datos_original,
                'modulo' => 'PAGOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);
            DB::commit();
            return response()->JSON([
                'sw' => true,
                'pago' => $pago,
                'msj' => 'El pago se registro correctamente',
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->JSON([
                "message" => $e->getMessage()
            ], 400);
        }
    }
    public function store_grupal(Request $request)
    {
        DB::beginTransaction();
        try {
            $pago = Pago::create([
                "user_id" => Auth::user()->id,
                "tipo_prestamo" => "GRUPAL",
                "grupo_id" => $request->grupo_id,
                "grupo_plan_pago_id" => $request->plan_pago_id,
                "nro_cuota" => $request->nro_cuota ? $request->nro_cuota : 0,
                "monto" => $request->monto,
                "interes" => $request->interes,
                "dias_mora" => $request->dias_mora,
                "monto_mora" => $request->monto_mora,
                "monto_total" => $request->monto_total,
                "tipo_pago" => $request->tipo_pago,
                "fecha_pago" => date("Y-m-d"),
            ]);

            // registrar movimiento PAGO CUOTA
            CajaMovimiento::create([
                "caja_id" => 1,
                "user_id" => Auth::user()->id,
                "monto" => $pago->monto,
                "tipo" => "CRÉDITO",
                "glosa" => "PAGO CUOTA PRESTAMO",
                "tipo_prestamo" => "GRUPAL",
                "grupo_id" => $pago->grupo_id,
                "fecha_registro" => date("Y-m-d")
            ]);

            // registrar movimiento INTERES
            CajaMovimiento::create([
                "caja_id" => 4,
                "user_id" => Auth::user()->id,
                "monto" => $pago->interes,
                "tipo" => "CRÉDITO",
                "glosa" => "INTERES",
                "tipo_prestamo" => "GRUPAL",
                "grupo_id" => $pago->grupo_id,
                "fecha_registro" => date("Y-m-d")
            ]);

            if ((int)$pago->dias_mora > 0) {
                // registrar movimiento MORA si existe
                CajaMovimiento::create([
                    "caja_id" => 4,
                    "user_id" => Auth::user()->id,
                    "monto" => $pago->interes,
                    "tipo" => "CRÉDITO",
                    "glosa" => "PAGO MORA",
                    "tipo_prestamo" => "GRUPAL",
                    "grupo_id" => $pago->grupo_id,
                    "fecha_registro" => date("Y-m-d")
                ]);
            }

            // actualizar saldos en cajas
            Caja::actualizaSaldos();

            if ($pago->tipo_pago == 'TOTAL') {
                // se pago el total del prestamo
                $grupo = Grupo::find($request->grupo_id);
                $grupo_plan_pagos = GrupoPlanPago::where("grupo_id", $grupo->id)
                    ->where("cancelado", "NO")
                    ->get();
                foreach ($grupo_plan_pagos as $grupo_plan_pago) {
                    $grupo_plan_pago->cancelado = "SI";
                    $grupo_plan_pago->save();
                }

                foreach ($grupo->prestamos as $prestamo) {
                    $pps = PlanPago::where("prestamo_id", $prestamo->id)->where("cancelado", "NO")->get();
                    foreach ($pps as $pp) {
                        $pp->cancelado = "SI";
                        $pp->save();
                    }
                }
                $grupo->finalizado = 1;
                $grupo->save();
            } else {
                // SE PAGO UNA CUOTA
                // Actualizar PLAN DE PAGO a CANCELADO(SI)
                $plan_pago = GrupoPlanPago::find($pago->grupo_plan_pago_id);
                $plan_pago->cancelado = "SI";
                $plan_pago->save();
                $grupo = Grupo::find($request->grupo_id);
                foreach ($grupo->prestamos as $prestamo) {
                    $pp = PlanPago::where("prestamo_id", $prestamo->id)->where("nro_cuota", $plan_pago->nro_cuota)->get()->first();
                    $pp->cancelado = "SI";
                    $pp->save();
                }
                Pago::verifica_grupal($grupo);
            }

            $datos_original = HistorialAccion::getDetalleRegistro($pago, "pagos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' REGISTRO EL PAGO DE UN PRESTAMO GRUPAL',
                'datos_original' => $datos_original,
                'modulo' => 'PAGOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);
            DB::commit();
            return response()->JSON([
                'sw' => true,
                'pago' => $pago,
                'msj' => 'El pago se registro correctamente',
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->JSON([
                "message" => $e->getMessage()
            ], 400);
        }
    }

    public function comprobante(Pago $pago)
    {
        $convertir = new NumeroALetras();
        $array_monto = explode('.', $pago->monto_total);
        $literal = $convertir->convertir($array_monto[0]);
        $literal .= " " . (isset($array_monto[1]) ? $array_monto[1] : '00') . "/100." . " Bolivianos";

        $tamanio_reporte = array(0, 0, 612, 360);
        $pdf = PDF::loadView('reportes.comprobante_pago', compact('pago', "literal"));
        $pdf->setPaper($tamanio_reporte);
        // ENUMERAR LAS PÁGINAS USANDO CANVAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

        return $pdf->download('ComprobantePago.pdf');
    }
    public function comprobante_grupal(Grupo $grupo)
    {
    }
}
