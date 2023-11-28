<?php

namespace App\Http\Controllers;

use App\Models\Caja;
use App\Models\CajaMovimiento;
use App\Models\HistorialAccion;
use App\Models\Pago;
use App\Models\PlanPago;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class PagoController extends Controller
{
    public function store(Request $request)
    {
        DB::beginTransaction();
        try {
            $pago = Pago::create([
                "user_id" => Auth::user()->id,
                "prestamo_id" => $request->prestamo_id,
                "plan_pago_id" => $request->plan_pago_id,
                "cliente_id" => $request->cliente_id,
                "nro_cuota" => $request->nro_cuota,
                "monto" => $request->monto,
                "interes" => $request->interes,
                "dias_mora" => $request->dias_mora,
                "monto_mora" => $request->monto_mora,
                "monto_total" => $request->monto_total,
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
                ]);
            }

            // actualizar saldos en cajas
            Caja::actualizaSaldos();

            // Actualizar PLAN DE PAGO a CANCELADO(SI)
            $plan_pago = PlanPago::find($pago->plan_pago_id);
            $plan_pago->cancelado = "SI";
            $plan_pago->save();

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
}
