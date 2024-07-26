<?php

namespace App\Http\Controllers;

use App\Models\HistorialAccion;
use App\Models\TipoCliente;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class TipoClienteController extends Controller
{
    public $validacion = [
        'nombre' => 'required|min:1',
    ];

    public $mensajes = [
        'nombre.required' => 'Este campo es obligatorio',
        'nombre.min' => 'Debes ingresar al menos :min',
    ];

    public function index(Request $request)
    {

        $tipo_clientes = TipoCliente::orderBy("id", "desc")->get();
        return response()->JSON(['tipo_clientes' => $tipo_clientes, 'total' => count($tipo_clientes)], 200);
    }

    public function store(Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);
        $request["fecha_registro"] = date("Y-m-d");
        DB::beginTransaction();
        try {
            // crear el TipoCliente
            $nuevo_tipo_cliente = TipoCliente::create(array_map('mb_strtoupper', $request->all()));

            $datos_original = HistorialAccion::getDetalleRegistro($nuevo_tipo_cliente, "tipo_clientes");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->tipo_cliente . ' REGISTRO EL SALARIO DE UN EMPLEADO',
                'datos_original' => $datos_original,
                'modulo' => 'SALARIOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'tipo_cliente' => $nuevo_tipo_cliente,
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

    public function update(Request $request, TipoCliente $tipo_cliente)
    {
        $request->validate($this->validacion, $this->mensajes);
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($tipo_cliente, "tipo_clientes");
            $tipo_cliente->update(array_map('mb_strtoupper', $request->all()));

            $datos_nuevo = HistorialAccion::getDetalleRegistro($tipo_cliente, "tipo_clientes");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->tipo_cliente . ' MODIFICÓ EL SALARIO DE UN EMPLEADO',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'SALARIOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'tipo_cliente' => $tipo_cliente,
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

    public function show(TipoCliente $tipo_cliente)
    {
        return response()->JSON([
            'sw' => true,
            'tipo_cliente' => $tipo_cliente
        ], 200);
    }
    public function destroy(TipoCliente $tipo_cliente)
    {
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($tipo_cliente, "tipo_clientes");
            $tipo_cliente->delete();
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->tipo_cliente . ' ELIMINÓ EL SALARIO DE UN EMPLEADO',
                'datos_original' => $datos_original,
                'modulo' => 'SALARIOS',
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
