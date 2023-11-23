<?php

namespace App\Http\Controllers;

use App\Models\Pago;
use Illuminate\Http\Request;

class PagoController extends Controller
{
    public function store(Request $request)
    {
        DB::beginTransaction();
        try {

            $pago = Pago::create([
                "prestamo_id" => $request->prestamo_id,
                "plan_pago_id" => $request->plan_pago_id,
                "cliente_id" => $request->cliente_id,
                "nro_cuota" => $request->nro_cuota,
                "monto" => $request->monto,
                "dias_mora" => $request->dias_mora,
                "monto_mora" => $request->monto_mora,
                "monto_total" => $request->monto_total,
                "fecha_pago" => date("Y-m-d"),
            ]);

            // registrar movimiento de caja cuota
            CajaMovimiento::create([
                "caja_id" => 1,
                "user_id" => Auth::user()->id,
                "monto" => $pago->monto,
                "tipo" => "CRÉDITO",
                "glosa" => "PAGO CUOTA PRESTAMO",
                "prestamo_id" => $pago->prestamo_id,
            ]);

            // registrar movimiento de caja cuota
            

            // actualizar saldos en cajas
            Caja::actualizaSaldos();

            $datos_original = HistorialAccion::getDetalleRegistro($pago, "pagos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' REALIZÓ EL DESEMBOLSO DE UN PRESTAMO',
                'datos_original' => $datos_original,
                'modulo' => 'PRESTAMOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);
            DB::commit();
            return response()->JSON([
                'sw' => true,
                'pago' => $pago,
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
