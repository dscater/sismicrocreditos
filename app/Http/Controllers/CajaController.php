<?php

namespace App\Http\Controllers;

use App\Models\Caja;
use App\Models\CajaMovimiento;
use App\Models\HistorialAccion;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class CajaController extends Controller
{
    public $validacion = [
        'glosa' => 'required',
        'monto' => 'required|numeric|min:1',
    ];

    public $mensajes = [
        'glosa.required' => 'Este campo es obligatorio',
        'monto.required' => 'Este campo es obligatorio',
        'monto.numeric' => 'Debes ingressar un valor númerico',
        'monto.min' => 'Debes ingressar al menos :min',
    ];

    public function index(Request $request)
    {
        $per_page = 10;
        $total_saldo_caja = Caja::getSaldoTotal();
        if (isset($request->fecha_ini) && isset($request->fecha_fin) && $request->fecha_ini && $request->fecha_fin && $request->fecha_ini != '' && $request->fecha_fin != '') {
            $fecha_ini = $request->fecha_ini;
            $fecha_fin = $request->fecha_fin;
        }
        $caja_movimientos = CajaMovimiento::with(["user"])->whereBetween("fecha_registro", [$fecha_ini, $fecha_fin])->paginate($per_page);

        return response()->JSON(['caja_movimientos' => $caja_movimientos, "per_page" => $per_page, "total_saldo_caja" => $total_saldo_caja], 200);
    }

    public function store(Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);
        $request["fecha_registro"] = date("Y-m-d");
        DB::beginTransaction();
        try {
            $caja_id = 1;
            $tipo = "CRÉDITO";

            $caja_movimiento = CajaMovimiento::create([
                "caja_id" => $caja_id,
                "user_id" => Auth::user()->id,
                "monto" => $request->monto,
                "tipo" => $tipo,
                "glosa" => $request->glosa,
                "fecha_registro" => date("Y-m-d"),
            ]);

            Caja::actualizaSaldos();

            $datos_original = HistorialAccion::getDetalleRegistro($caja_movimiento, "caja_movimientos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->caja . ' REGISTRO UN MOVIMINETO DE CAJA',
                'datos_original' => $datos_original,
                'modulo' => 'CAJA',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'caja_movimiento' => $caja_movimiento,
                'msj' => 'El registro se realizó de forma correcta',
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->JSON([
                'sw' => false,
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function update(Request $request, Caja $caja)
    {
        $this->validacion['ci'] = 'required|numeric|digits_between:4, 20|unique:cajas,ci,' . $caja->id;

        $request->validate($this->validacion, $this->mensajes);
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($caja, "cajas");
            $caja->update(array_map('mb_strtoupper', $request->all()));

            $datos_nuevo = HistorialAccion::getDetalleRegistro($caja, "cajas");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->caja . ' MODIFICÓ UN CLIENTE',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'CLIENTES',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'caja' => $caja,
                'msj' => 'El registro se actualizó de forma correcta'
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->JSON([
                'sw' => false,
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function show(Caja $caja)
    {
        return response()->JSON([
            'sw' => true,
            'caja' => $caja
        ], 200);
    }
    public function destroy(Caja $caja)
    {
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($caja, "cajas");
            $caja->delete();
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->caja . ' ELIMINÓ UN CLIENTE',
                'datos_original' => $datos_original,
                'modulo' => 'CLIENTES',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'msj' => 'El registro se eliminó correctamente'
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->JSON([
                'sw' => false,
                'message' => $e->getMessage(),
            ], 500);
        }
    }
}
