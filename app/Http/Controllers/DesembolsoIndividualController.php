<?php

namespace App\Http\Controllers;

use App\Models\Caja;
use App\Models\CajaMovimiento;
use App\Models\HistorialAccion;
use App\Models\Prestamo;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class DesembolsoIndividualController extends Controller
{
    public function store(Prestamo $prestamo)
    {
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($prestamo, "prestamos");
            $prestamo->desembolso = 1;
            $prestamo->save();

            // registrar las fechas de pagos
            $plan_pagos = $prestamo->plan_pagos;
            $fecha_desembolso = $prestamo->fecha_desembolso;
            $fecha_proximo_pago = $fecha_desembolso;
            foreach ($plan_pagos as $key => $pp) {
                $fecha_proximo_pago = date("Y-m-d", strtotime($fecha_proximo_pago . "+7days"));
                $pp->fecha_pago = $fecha_proximo_pago;
                $pp->save();
            }

            // registrar movimiento de caja
            CajaMovimiento::create([
                "caja_id" => 1,
                "user_id" => Auth::user()->id,
                "monto" => $prestamo->monto,
                "tipo" => "DEBITO",
                "glosa" => "DESEMBOLSO",
                "tipo_prestamo" => "INDIVIDUAL",
                "prestamo_id" => $prestamo->id,
            ]);

            // actualizar saldos en cajas
            Caja::actualizaSaldos();

            $datos_nuevo = HistorialAccion::getDetalleRegistro($prestamo, "prestamos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' REALIZÓ EL DESEMBOLSO DE UN PRESTAMO',
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
