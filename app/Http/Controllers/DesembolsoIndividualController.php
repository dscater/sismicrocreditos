<?php

namespace App\Http\Controllers;

use App\Models\Caja;
use App\Models\CajaMovimiento;
use App\Models\HistorialAccion;
use App\Models\Prestamo;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use PDF;
use App\library\numero_a_letras\src\NumeroALetras;
use Illuminate\Support\Facades\Log;

class DesembolsoIndividualController extends Controller
{
    public function store(Prestamo $prestamo, Request $request)
    {
        DB::beginTransaction();
        try {
            // validar saldo desembolso en caja
            $total_saldo_desembolso = Caja::getSaldoDesembolsos();
            if ((float)$prestamo->monto > (float)$total_saldo_desembolso) {
                throw new Exception("El monto para DESEMBOLSOS de " . $total_saldo_desembolso . ", no es suficiente para el monto solicitado de " . $prestamo->monto);
            }

            $datos_original = HistorialAccion::getDetalleRegistro($prestamo, "prestamos");
            $prestamo->user_desembolso_id = Auth::user()->id;
            $prestamo->desembolso = 1;
            $prestamo->save();

            // registrar movimiento de caja
            CajaMovimiento::create([
                "caja_id" => 1,
                "user_id" => Auth::user()->id,
                "monto" => $prestamo->monto,
                "tipo" => "DEBITO",
                "glosa" => "DESEMBOLSO",
                "tipo_prestamo" => "INDIVIDUAL",
                "prestamo_id" => $prestamo->id,
                "fecha_registro" => date("Y-m-d")
            ]);

            // registrar DESEMBOLSO
            $prestamo->o_desembolso()->create([
                "user_id" => Auth::user()->id,
                "tipo_prestamo" => "INDIVIDUAL",
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
                    "tipo_prestamo" => "INDIVIDUAL",
                    "prestamo_id" => $prestamo->id,
                    "fecha_registro" => date("Y-m-d")
                ]);
            }

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

    public function comprobante(Prestamo $prestamo)
    {
        if ($prestamo->desembolso) {
            $desembolso = $prestamo->o_desembolso;
            Log::debug($desembolso);
            $monto_entregado = $prestamo->monto;

            if ($desembolso->cancelado == 'SI') {
                $monto_entregado = (float)$prestamo->monto - (float)$desembolso->monto;
            }

            $convertir = new NumeroALetras();
            $array_monto = explode('.', $monto_entregado);
            $literal_entregado = $convertir->convertir($array_monto[0]);
            $literal_entregado .= " " . (isset($array_monto[1]) ? $array_monto[1] : '00') . "/100." . " Bolivianos";

            $array_monto = explode('.', $prestamo->monto);
            $literal_prestamo = $convertir->convertir($array_monto[0]);
            $literal_prestamo .= " " . (isset($array_monto[1]) ? $array_monto[1] : '00') . "/100." . " Bolivianos";


            $tamanio_reporte = array(0, 0, 612, 360);

            $pdf = PDF::loadView('reportes.desembolso_individual', compact('desembolso', "prestamo", "monto_entregado", "literal_entregado", "literal_prestamo"));
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
