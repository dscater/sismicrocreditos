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
use PDF;
use App\library\numero_a_letras\src\NumeroALetras;

class DesembolsoGrupalController extends Controller
{
    public function store(Grupo $grupo, Request $request)
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


            // registrar DESEMBOLSO
            $grupo->desembolso()->create([
                "user_id" => Auth::user()->id,
                "tipo_prestamo" => "GRUPAL",
                "monto" => $request->monto,
                "cancelado" => $request->cancelado,
                "fecha_registro" => date("Y-m-d")
            ]);

            // REGISTRAR GASTOS ADMINISTRATIVOS
            if ($request->cancelado == 'SI') {
                // registrar movimiento de caja
                CajaMovimiento::create([
                    "caja_id" => 2,
                    "user_id" => Auth::user()->id,
                    "monto" => $request->monto,
                    "tipo" => "CRÉDITO",
                    "glosa" => "GASTOS ADMINISTRATIVOS",
                    "tipo_prestamo" => "GRUPAL",
                    "grupo_id" => $grupo->id,
                    "fecha_registro" => date("Y-m-d")
                ]);
            }

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

    public function comprobante(Grupo $grupo)
    {
        if ($grupo->desembolso) {
            $desembolso = $grupo->o_desembolso;
            Log::debug($desembolso);
            $monto_entregado = $grupo->monto;

            if ($desembolso->cancelado == 'SI') {
                $monto_entregado = (float)$grupo->monto - (float)$desembolso->monto;
            }

            $convertir = new NumeroALetras();
            $array_monto = explode('.', $monto_entregado);
            $literal_entregado = $convertir->convertir($array_monto[0]);
            $literal_entregado .= " " . (isset($array_monto[1]) ? $array_monto[1] : '00') . "/100." . " Bolivianos";

            $array_monto = explode('.', $grupo->monto);
            $literal_prestamo = $convertir->convertir($array_monto[0]);
            $literal_prestamo .= " " . (isset($array_monto[1]) ? $array_monto[1] : '00') . "/100." . " Bolivianos";


            $tamanio_reporte = array(0, 0, 612, 360);

            $pdf = PDF::loadView('reportes.desembolso_grupal', compact('desembolso', "grupo", "monto_entregado", "literal_entregado", "literal_prestamo"));
            $pdf->setPaper($tamanio_reporte);
            // ENUMERAR LAS PÁGINAS USANDO CANVAS
            $pdf->output();
            $dom_pdf = $pdf->getDomPDF();
            $canvas = $dom_pdf->get_canvas();
            $alto = $canvas->get_height();
            $ancho = $canvas->get_width();
            $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

            return $pdf->download('ComprobanteDesembolso.pdf');
        }

        return response()->JSON([
            "sw" => false,
            "message" => "No se encontró el desembolso del préstamo",
        ], 500);
    }
}
