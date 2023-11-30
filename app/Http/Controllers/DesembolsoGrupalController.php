<?php

namespace App\Http\Controllers;

use App\Models\Caja;
use App\Models\CajaMovimiento;
use App\Models\Grupo;
use App\Models\HistorialAccion;
use App\Models\PlanPago;
use Exception;
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
            // validar saldo desembolso en caja
            $total_saldo_desembolso = Caja::getSaldoDesembolsos();
            if ((float)$grupo->monto > (float)$total_saldo_desembolso) {
                throw new Exception("El monto para DESEMBOLSOS de " . $total_saldo_desembolso . ", no es suficiente para el monto solicitado de " . $grupo->monto);
            }

            $datos_original = HistorialAccion::getDetalleRegistro($grupo, "grupos");
            $grupo->user_desembolso_id = Auth::user()->id;
            $grupo->desembolso = 1;
            $grupo->save();

            // registrar movimiento de caja
            CajaMovimiento::create([
                "caja_id" => 1,
                "user_id" => Auth::user()->id,
                "monto" => $grupo->monto,
                "tipo" => "DEBITO",
                "glosa" => "DESEMBOLSO",
                "tipo_prestamo" => "GRUPAL",
                "grupo_id" => $grupo->id,
                "fecha_registro" => date("Y-m-d")
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
