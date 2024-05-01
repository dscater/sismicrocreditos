<?php

namespace App\Http\Controllers;

use App\Models\ActividadContingencia;
use App\Models\AmenazaSeguridad;
use App\Models\Caja;
use App\Models\CajaMovimiento;
use App\Models\Desembolso;
use App\Models\Grupo;
use App\Models\HistorialAccion;
use App\Models\Pago;
use App\Models\PlanContingencia;
use App\Models\Prestamo;
use App\Models\RolFuncion;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Log;
use PDF;

class UserController extends Controller
{
    public $validacion = [
        'nombre' => 'required|min:4',
        'paterno' => 'required|min:4',
        'ci_exp' => 'required',
        'tipo' => 'required',
        'acceso' => 'required',
    ];

    public $mensajes = [
        'nombre.required' => 'Este campo es obligatorio',
        'nombre.min' => 'Debes ingressar al menos 4 carácteres',
        'paterno.required' => 'Este campo es obligatorio',
        'paterno.min' => 'Debes ingresar al menos 4 carácteres',
        'ci.required' => 'Este campo es obligatorio',
        'ci.numeric' => 'Debes ingresar un valor númerico',
        'ci.unique' => 'Este número de C.I. ya fue registrado',
        'ci_exp.required' => 'Este campo es obligatorio',
        'dir.required' => 'Este campo es obligatorio',
        'dir.min' => 'Debes ingresar al menos 4 carácteres',
        'fono.required' => 'Este campo es obligatorio',
        'fono.min' => 'Debes ingresar al menos 4 carácteres',
        'cel.required' => 'Este campo es obligatorio',
        'cel.min' => 'Debes ingresar al menos 4 carácteres',
        'tipo.required' => 'Este campo es obligatorio',
    ];

    public $permisos = [
        'ADMINISTRADOR' => [
            'usuarios.index',
            'usuarios.create',
            'usuarios.edit',
            'usuarios.destroy',

            'salarios.index',
            'salarios.create',
            'salarios.edit',
            'salarios.destroy',

            'clientes.index',
            'clientes.create',
            'clientes.edit',
            'clientes.destroy',
            'clientes.historial',

            'cajas.index',
            'cajas.create',
            'cajas.edit',
            'cajas.destroy',

            'prestamos.individual',
            'prestamos.individual_contrato',
            'prestamos.individual_nuevo',
            'prestamos.individual_aprobar',
            'prestamos.individual_rechazar',
            'prestamos.grupal',
            'prestamos.grupal_contrato',
            'prestamos.grupal_nuevo',
            'prestamos.grupal_aprobar',
            'prestamos.grupal_rechazar',
            'prestamos.simulacion',


            "desembolsos.individual",
            "desembolsos.grupal",

            "pagos.individual",
            // "pagos.individual_store",
            "pagos.grupal",
            // "pagos.grupal_store",

            'control_prestamos.index',

            'configuracion.index',
            'configuracion.edit',

            "reportes.usuarios",
            "reportes.clientes",
            "reportes.prestamos_individual",
            "reportes.prestamos_grupal",
            "reportes.proximos_desembolsos_individual",
            "reportes.proximos_desembolsos_grupal",
            "reportes.prestamos_individual_mora",
            "reportes.prestamos_grupal_mora",
            "reportes.extracto_pagos_individual",
            "reportes.extracto_pagos_grupal",
            "reportes.prestamos_estado",
        ],
        "GERENTE" => [
            'cajas.index',

            'clientes.index',

            'prestamos.individual',
            'prestamos.individual_contrato',
            'prestamos.grupal',
            'prestamos.grupal_contrato',

            "reportes.clientes",
            "reportes.prestamos_individual",
            "reportes.prestamos_grupal",
            "reportes.proximos_desembolsos_individual",
            "reportes.proximos_desembolsos_grupal",
            "reportes.prestamos_individual_mora",
            "reportes.prestamos_grupal_mora",
            "reportes.prestamos_estado",
        ],
        "OFICIAL DE CRÉDITO" => [
            'clientes.index',
            'clientes.create',
            'clientes.edit',
            'clientes.destroy',

            'prestamos.individual',
            'prestamos.individual_contrato',
            'prestamos.individual_nuevo',
            'prestamos.individual_aprobar',
            'prestamos.grupal',
            'prestamos.grupal_contrato',
            'prestamos.grupal_nuevo',
            'prestamos.grupal_aprobar',
            'prestamos.simulacion',

            "desembolsos.individual",
            "desembolsos.grupal",

            "reportes.clientes",
            "reportes.prestamos_individual",
            "reportes.prestamos_grupal",
            "reportes.proximos_desembolsos_individual",
            "reportes.proximos_desembolsos_grupal",
            "reportes.prestamos_individual_mora",
            "reportes.prestamos_grupal_mora",
            "reportes.extracto_pagos_individual",
            "reportes.extracto_pagos_grupal",
            "reportes.prestamos_estado",
        ],
        "CAJERO" => [
            'cajas.index',
            'cajas.create',
            'cajas.edit',
            'cajas.destroy',

            'prestamos.individual',
            'prestamos.grupal',

            "desembolsos.individual",
            "desembolsos.grupal",

            "pagos.individual",
            "pagos.individual_store",
            "pagos.grupal",
            "pagos.grupal_store",

            "reportes.prestamos_individual_mora",
            "reportes.prestamos_grupal_mora",

            "reportes.extracto_pagos_individual",
            "reportes.extracto_pagos_grupal",
        ],
    ];


    public function index(Request $request)
    {
        $usuarios = User::where('id', '!=', 1)->get();
        return response()->JSON(['usuarios' => $usuarios, 'total' => count($usuarios)], 200);
    }

    public function store(Request $request)
    {
        $this->validacion['ci'] = 'required|numeric|digits_between:4, 20|unique:users,ci';
        $this->validacion['usuario'] = 'required|unique:users,usuario';
        $this->validacion['password'] = 'required|min:6';

        $request->validate($this->validacion, $this->mensajes);
        $request['fecha_registro'] = date('Y-m-d');
        DB::beginTransaction();
        try {
            // crear el Usuario
            $request["password"] = "123456";
            $nuevo_usuario = User::create(array_map('mb_strtoupper', $request->except('foto')));
            $nuevo_usuario->password = Hash::make($request->password);
            if ($request->hasFile('foto')) {
                $file = $request->foto;
                $nom_foto = time() . '_' . $nuevo_usuario->usuario . '.' . $file->getClientOriginalExtension();
                $nuevo_usuario->foto = $nom_foto;
                $file->move(public_path() . '/imgs/users/', $nom_foto);
            }
            $nuevo_usuario->save();

            $datos_original = HistorialAccion::getDetalleRegistro($nuevo_usuario, "users");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' REGISTRO UN USUARIO',
                'datos_original' => $datos_original,
                'modulo' => 'USUARIOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'usuario' => $nuevo_usuario,
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

    public function update(Request $request, User $usuario)
    {
        $this->validacion['ci'] = 'required|numeric|digits_between:4, 20|unique:users,ci,' . $usuario->id;
        $this->validacion['usuario'] = 'required|unique:users,usuario,' . $usuario->id;
        if ($request->password && trim($request->password) != "") {
            $this->validacion['password'] = 'required|min:6';
        }

        $request->validate($this->validacion, $this->mensajes);
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($usuario, "users");
            $usuario->update(array_map('mb_strtoupper', $request->except('foto')));

            if ($request->password && trim($request->password) != "") {
                $usuario->password = Hash::make($request->password);
            }

            if ($request->hasFile('foto')) {
                $antiguo = $usuario->foto;
                if ($antiguo != 'default.png') {
                    \File::delete(public_path() . '/imgs/users/' . $antiguo);
                }
                $file = $request->foto;
                $nom_foto = time() . '_' . $usuario->usuario . '.' . $file->getClientOriginalExtension();
                $usuario->foto = $nom_foto;
                $file->move(public_path() . '/imgs/users/', $nom_foto);
            }
            $usuario->save();

            $datos_nuevo = HistorialAccion::getDetalleRegistro($usuario, "users");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' MODIFICÓ UN USUARIO',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'USUARIOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'usuario' => $usuario,
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

    public function show(User $usuario)
    {
        return response()->JSON([
            'sw' => true,
            'usuario' => $usuario
        ], 200);
    }

    public function actualizaContrasenia(User $usuario, Request $request)
    {
        $request->validate([
            'password_actual' => ['required', function ($attribute, $value, $fail) use ($usuario, $request) {
                if (!\Hash::check($request->password_actual, $usuario->password)) {
                    return $fail(__('La contraseña no coincide con la actual.'));
                }
            }],
            'password' => 'required|confirmed|min:4',
            'password_confirmation' => 'required|min:4'
        ]);


        DB::beginTransaction();
        try {
            $usuario->password = Hash::make($request->password);
            $usuario->save();
            DB::commit();
            return response()->JSON([
                'sw' => true,
                'msj' => 'La contraseña se actualizó correctamente'
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->JSON([
                'sw' => false,
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function actualizaFoto(User $usuario, Request $request)
    {
        DB::beginTransaction();
        try {

            if ($request->hasFile('foto')) {
                $antiguo = $usuario->foto;
                if ($antiguo != 'default.png') {
                    \File::delete(public_path() . '/imgs/users/' . $antiguo);
                }
                $file = $request->foto;
                $nom_foto = time() . '_' . $usuario->usuario . '.' . $file->getClientOriginalExtension();
                $usuario->foto = $nom_foto;
                $file->move(public_path() . '/imgs/users/', $nom_foto);
            }
            $usuario->save();
            DB::commit();
            return response()->JSON([
                'sw' => true,
                'usuario' => $usuario,
                'msj' => 'Foto actualizada con éxito'
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->JSON([
                'sw' => false,
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function destroy(User $usuario)
    {
        DB::beginTransaction();
        try {
            $existe_prestamos = Prestamo::where("user_id", $usuario->id)->get();
            if (count($existe_prestamos) > 0) {
                throw new Exception("No es posible eliminar al empleado porque tiene préstamos registrados");
            }
            $existe_prestamos = Prestamo::where("user_desembolso_id", $usuario->id)->get();
            if (count($existe_prestamos) > 0) {
                throw new Exception("No es posible eliminar al empleado porque tiene préstamos registrados");
            }
            $existe_prestamos = Prestamo::where("user_aprobado_id", $usuario->id)->get();
            if (count($existe_prestamos) > 0) {
                throw new Exception("No es posible eliminar al empleado porque tiene préstamos registrados");
            }
            $existe_prestamos = CajaMovimiento::where("user_id", $usuario->id)->get();
            if (count($existe_prestamos) > 0) {
                throw new Exception("No es posible eliminar al empleado porque tiene registros en caja");
            }
            $existe_prestamos = Desembolso::where("user_id", $usuario->id)->get();
            if (count($existe_prestamos) > 0) {
                throw new Exception("No es posible eliminar al empleado porque tiene desembolsos realizados");
            }
            $existe_prestamos = Grupo::where("user_id", $usuario->id)->get();
            if (count($existe_prestamos) > 0) {
                throw new Exception("No es posible eliminar al empleado porque tiene préstamos registrados");
            }
            $existe_prestamos = Pago::where("user_id", $usuario->id)->get();
            if (count($existe_prestamos) > 0) {
                throw new Exception("No es posible eliminar al empleado porque tiene pagos registrados");
            }

            $datos_original = HistorialAccion::getDetalleRegistro($usuario, "users");
            $usuario->delete();
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' ELIMINÓ UN USUARIO',
                'datos_original' => $datos_original,
                'modulo' => 'USUARIOS',
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

    public function getPermisos(User $usuario)
    {
        $tipo = $usuario->tipo;
        return response()->JSON($this->permisos[$tipo]);
    }

    public function getInfoBox()
    {
        $tipo = Auth::user()->tipo;
        $array_infos = [];

        $total_saldo_caja = Caja::getSaldoTotal();

        // $saldo = Caja::find(1)->saldo;
        $array_infos[] = [
            'label' => 'Saldo en Caja',
            'cantidad' => number_format($total_saldo_caja, 2, ".", ""),
            'icon' => asset("imgs/" . ((float)$total_saldo_caja > 0 ? "circle_full_green.png" : "circle_empty.png")),
            "url" => "cajas.index"
        ];

        // $saldo = Caja::find(2)->saldo;
        // $array_infos[] = [
        //     'label' => 'Gastos Administrativos',
        //     'cantidad' => $saldo,
        //     'icon' => asset("imgs/" . ((float)$saldo > 0 ? "circle_full_green.png" : "circle_empty.png")),
        //     "url" => "cajas.index"
        // ];

        // $saldo = Caja::find(3)->saldo;
        // $array_infos[] = [
        //     'label' => 'Cargos por Multa',
        //     'cantidad' => $saldo,
        //     'icon' => asset("imgs/" . ((float)$saldo > 0 ? "circle_full_green.png" : "circle_empty.png")),
        //     "url" => "cajas.index"
        // ];

        // $saldo = Caja::find(4)->saldo;
        // $array_infos[] = [
        //     'label' => 'Intereses',
        //     'cantidad' => $saldo,
        //     'icon' => asset("imgs/" . ((float)$saldo > 0 ? "circle_full_green.png" : "circle_empty.png")),
        //     "url" => "cajas.index"
        // ];

        $array_infos[] = [
            'label' => 'Cajas',
            'cantidad' => 4,
            'icon' => asset("imgs/cash_machine.png"),
            "url" => "cajas.index"
        ];

        if (in_array('usuarios.index', $this->permisos[$tipo])) {
            $array_infos[] = [
                'label' => 'Empleados',
                'cantidad' => count(User::where('id', '!=', 1)->get()),
                'icon' => asset("imgs/people.png"),
                "url" => "usuarios.index"
            ];
        }

        if (in_array('prestamos.individual', $this->permisos[$tipo])) {
            $array_infos[] = [
                'label' => 'Préstamos individual',
                'cantidad' => count(Prestamo::where('tipo', 'INDIVIDUAL')->where("estado", "!=", "RECHAZADO")->get()),
                'icon' => asset("imgs/icon_inscripcion.png"),
                "url" => "prestamos.individual"
            ];
        }

        if (in_array('prestamos.grupal', $this->permisos[$tipo])) {
            $array_infos[] = [
                'label' => 'Préstamos grupal',
                'cantidad' => count(Grupo::all()),
                'icon' => asset("imgs/icon_inscripcion.png"),
                "url" => "prestamos.grupal"
            ];
        }
        return response()->JSON($array_infos);
    }

    public function userActual()
    {
        return response()->JSON(Auth::user());
    }

    public function getUsuario(User $usuario)
    {
        return response()->JSON($usuario);
    }

    public function getUsuarioTipo(Request $request)
    {
        $tipo = $request->tipo;
        $usuarios = [];
        if ($tipo != "todos") {
            if (is_array($tipo)) {
                $usuarios = User::where("id", "!=", 1)->whereIn("tipo", $tipo)->get();
            } else {
                $usuarios = User::where("id", "!=", 1)->where("tipo", $tipo)->get();
            }
        } else {
            $usuarios = User::where("id", "!=", 1)->get();
        }
        return response()->JSON($usuarios);
    }
    public function updatePassword(User $usuario, Request $request)
    {
        $usuario->password = Hash::make($request->password);
        $usuario->save();

        return response()->JSON([
            "sw" => true,
            "message" => "Contraseña actualizada con éxito"
        ]);
    }
}
