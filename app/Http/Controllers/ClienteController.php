<?php

namespace App\Http\Controllers;

use App\Models\Cliente;
use App\Models\HistorialAccion;
use App\Models\Prestamo;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use PDF;

class ClienteController extends Controller
{
    public $validacion = [
        'nombre' => 'required|min:4|regex:/^[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ\s]+$/',
        'paterno' => 'required|min:4|regex:/^[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ\s]+$/',
        'ci_exp' => 'required',
        'dir' => 'required',
        'cel' => 'required|regex:/^[0-9]{8}$/',
        'edad' => 'required',
        'dir' => 'required',
        'referencia' => 'required|regex:/^[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ\s]+$/',
        'cel_ref' => 'required|regex:/^[0-9]{8}$/',
        'parentesco' => 'required|regex:/^[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ\s]+$/',
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
        'cel.required' => 'Este campo es obligatorio',
        'cel.min' => 'Debes ingresar al menos 4 carácteres',
        'cel.regex' => 'Este formato no esta permitido',
        'edad.required' => 'Este campo es obligatorio',
        'dir.required' => 'Este campo es obligatorio',
        'cel_ref.required' => 'Este campo es obligatorio',
        'cel_ref.regex' => 'Este formato no esta permitido',
        'parentesco.required' => 'Este campo es obligatorio',
        'segundo_nombre.regex' => 'Este formato no esta permitido',
        'materno.regex' => 'Este formato no esta permitido',
    ];

    public function index(Request $request)
    {
        $clientes = Cliente::orderBy("id", "desc")->get();
        return response()->JSON(['clientes' => $clientes, 'total' => count($clientes)], 200);
    }

    public function buscar_ci(Request $request)
    {
        $cliente = Cliente::where("ci", $request->ci)->get()->first();
        if ($cliente) {
            return response()->JSON(['cliente' => $cliente], 200);
        }
        return response()->JSON(['message' => "No se encontrarón registros con ese número de C.I."], 404);
    }

    public function store(Request $request)
    {
        $this->validacion['ci'] = 'required|numeric|digits_between:4, 20|unique:clientes,ci';
        if (trim($request->segundo_nombre) != "") {
            $this->validacion['segundo_nombre'] = 'required|min:4|regex:/^[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ\s]+$/';
        }
        if (trim($request->materno) != "") {
            $this->validacion['materno'] = 'required|min:4|regex:/^[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ\s]+$/';
        }
        $request->validate($this->validacion, $this->mensajes);
        $request["fecha_registro"] = date("Y-m-d");
        DB::beginTransaction();
        try {
            // crear el Cliente
            $nuevo_cliente = Cliente::create(array_map('mb_strtoupper', $request->all()));

            $datos_original = HistorialAccion::getDetalleRegistro($nuevo_cliente, "clientes");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->cliente . ' REGISTRO UN CLIENTE',
                'datos_original' => $datos_original,
                'modulo' => 'CLIENTES',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'cliente' => $nuevo_cliente,
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

    public function update(Request $request, Cliente $cliente)
    {
        $this->validacion['ci'] = 'required|numeric|digits_between:4, 20|unique:clientes,ci,' . $cliente->id;
        if (trim($request->segundo_nombre) != "") {
            $this->validacion['segundo_nombre'] = 'required|min:4|regex:/^[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ\s]+$/';
        }
        if (trim($request->materno) != "") {
            $this->validacion['materno'] = 'required|min:4|regex:/^[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ\s]+$/';
        }
        $request->validate($this->validacion, $this->mensajes);
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($cliente, "clientes");
            $cliente->update(array_map('mb_strtoupper', $request->all()));

            $datos_nuevo = HistorialAccion::getDetalleRegistro($cliente, "clientes");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->cliente . ' MODIFICÓ UN CLIENTE',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'CLIENTES',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'cliente' => $cliente,
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

    public function show(Cliente $cliente)
    {
        return response()->JSON([
            'sw' => true,
            'cliente' => $cliente
        ], 200);
    }

    public function historial(Cliente $cliente)
    {
        $pdf = PDF::loadView('reportes.historial', compact('cliente'))->setPaper('letter', 'landscape');

        // ENUMERAR LAS PÁGINAS USANDO CANVAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

        return $pdf->download('HistorialCrediticio.pdf');
    }

    public function destroy(Cliente $cliente)
    {
        DB::beginTransaction();
        try {
            $existe_prestamos = Prestamo::where("cliente_id", $cliente->id)->get();
            if (count($existe_prestamos) > 0) {
                throw new Exception("No es posible eliminar al cliente porque tiene préstamos registrados");
            }

            $datos_original = HistorialAccion::getDetalleRegistro($cliente, "clientes");
            $cliente->delete();
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->cliente . ' ELIMINÓ UN CLIENTE',
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
