<?php

namespace App\Http\Controllers;

use App\Models\HistorialAccion;
use App\Models\Salario;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class SalarioController extends Controller
{
    public $validacion = [
        'salario' => 'required|numeric|min:1',
    ];

    public $mensajes = [
        'user_id.required' => 'Este campo es obligatorio',
        'user_id.unique' => 'Este usuario ya tiene un salario registrado',
        'salario.required' => 'Este campo es obligatorio',
        'salario.min' => 'Debes ingressar al menos :min',
    ];

    public function index(Request $request)
    {

        $salarios = Salario::with("user")->orderBy("id", "desc")->get();
        return response()->JSON(['salarios' => $salarios, 'total' => count($salarios)], 200);
    }

    public function store(Request $request)
    {
        $this->validacion['user_id'] = 'required|unique:salarios,user_id';
        $request->validate($this->validacion, $this->mensajes);
        $request["fecha_registro"] = date("Y-m-d");
        DB::beginTransaction();
        try {
            // crear el Salario
            $nuevo_salario = Salario::create(array_map('mb_strtoupper', $request->all()));

            $datos_original = HistorialAccion::getDetalleRegistro($nuevo_salario, "salarios");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->salario . ' REGISTRO EL SALARIO DE UN EMPLEADO',
                'datos_original' => $datos_original,
                'modulo' => 'SALARIOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'salario' => $nuevo_salario,
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

    public function update(Request $request, Salario $salario)
    {
        $this->validacion['user_id'] = 'required|unique:salarios,user_id,' . $salario->id;
        $request->validate($this->validacion, $this->mensajes);
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($salario, "salarios");
            $salario->update(array_map('mb_strtoupper', $request->all()));

            $datos_nuevo = HistorialAccion::getDetalleRegistro($salario, "salarios");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->salario . ' MODIFICÓ EL SALARIO DE UN EMPLEADO',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'SALARIOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'salario' => $salario,
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

    public function show(Salario $salario)
    {
        return response()->JSON([
            'sw' => true,
            'salario' => $salario
        ], 200);
    }
    public function destroy(Salario $salario)
    {
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($salario, "salarios");
            $salario->delete();
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->salario . ' ELIMINÓ EL SALARIO DE UN EMPLEADO',
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
