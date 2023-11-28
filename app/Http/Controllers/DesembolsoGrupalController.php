<?php

namespace App\Http\Controllers;

use App\Models\Caja;
use App\Models\CajaMovimiento;
use App\Models\Grupo;
use App\Models\HistorialAccion;
use App\Models\PlanPago;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class DesembolsoGrupalController extends Controller
{
    public function store(Grupo $grupo)
    {
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($grupo, "grupos");
            $grupo->desembolso = 1;
            $grupo->save();
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
            }

            // registrar movimiento de caja
            CajaMovimiento::create([
                "caja_id" => 1,
                "user_id" => Auth::user()->id,
                "monto" => $grupo->monto,
                "tipo" => "DEBITO",
                "glosa" => "DESEMBOLSO",
                "tipo_prestamo" => "GRUPAL",
                "grupo_id" => $grupo->id,
            ]);
            // actualizar saldos en cajas
            Caja::actualizaSaldos();

            $datos_nuevo = HistorialAccion::getDetalleRegistro($grupo, "grupos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' REALIZÓ EL DESEMBOLSO DE UN PRESTAMO GRUPAL',
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
                'msj' => 'El desembolso se llevo a cabo correctamente',
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->JSON([
                "message" => $e->getMessage()
            ], 400);
        }
    }
}
