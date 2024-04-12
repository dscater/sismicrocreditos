<?php

namespace App\Http\Controllers;

use App\Models\ActividadContingencia;
use App\Models\AmenazaSeguridad;
use App\Models\Cliente;
use App\Models\Grupo;
use App\Models\Pago;
use App\Models\PlanContingencia;
use App\Models\Prestamo;
use App\Models\RolFuncion;
use App\Models\User;
use Illuminate\Http\Request;
use PDF;

class ReporteController extends Controller
{
    public function usuarios(Request $request)
    {
        $filtro =  $request->filtro;
        $usuarios = User::where('id', '!=', 1)->orderBy("paterno", "ASC")->get();

        if ($filtro == 'Tipo de usuario') {
            $request->validate([
                'tipo' => 'required',
            ]);
            $usuarios = User::where('id', '!=', 1)->where('tipo', $request->tipo)->orderBy("paterno", "ASC")->get();
        }

        $pdf = PDF::loadView('reportes.usuarios', compact('usuarios'))->setPaper('letter', 'portrait');

        // ENUMERAR LAS PÁGINAS USANDO CANVAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

        return $pdf->download('Usuarios.pdf');
    }
    public function clientes(Request $request)
    {
        $filtro =  $request->filtro;
        $fecha_ini =  $request->fecha_ini;
        $fecha_fin =  $request->fecha_fin;

        $clientes = Cliente::all();

        if ($filtro == 'Rango de fechas') {
            $request->validate([
                'fecha_ini' => 'required|date',
                'fecha_fin' => 'required|date',
            ], [
                'fecha_ini.required' => 'Debes seleccionar una fecha de inicio',
                'fecha_fin.required' => 'Debes seleccionar una fecha de fin',
                'fecha_ini.date' => 'Debes ingresar una fecha de inicio valida',
                'fecha_fin.date' => 'Debes ingresar una fecha de fin valida',
            ]);
            $clientes = Cliente::whereBetween("fecha_registro", [$fecha_ini, $fecha_fin])->get();
        }

        $pdf = PDF::loadView('reportes.clientes', compact('clientes'))->setPaper('letter', 'landscape');

        // ENUMERAR LAS PÁGINAS USANDO CANVAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

        return $pdf->download('clientes.pdf');
    }

    public function prestamos_individual(Request $request)
    {
        $filtro =  $request->filtro;
        $prestamos = Prestamo::where("tipo", "INDIVIDUAL")->get();

        if ($filtro != 'TODOS') {
            $prestamos = Prestamo::where("tipo", "INDIVIDUAL")->where("estado", $filtro)->get();
        }

        $pdf = PDF::loadView('reportes.prestamos_individual', compact('prestamos'))->setPaper('legal', 'landscape');

        // ENUMERAR LAS PÁGINAS USANDO CANVAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

        return $pdf->download('prestamos_individual.pdf');
    }
    public function prestamos_grupal(Request $request)
    {
        $filtro =  $request->filtro;
        $grupos = Grupo::all();

        if ($filtro != 'TODOS') {
            $grupos = Grupo::where("estado", $filtro)->get();
        }

        $pdf = PDF::loadView('reportes.prestamos_grupal', compact('grupos'))->setPaper('legal', 'landscape');

        // ENUMERAR LAS PÁGINAS USANDO CANVAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

        return $pdf->download('prestamos_grupal.pdf');
    }
    public function proximos_desembolsos_individual(Request $request)
    {
        $filtro =  $request->filtro;
        $prestamos = Prestamo::where("tipo", "INDIVIDUAL")->where("fecha_desembolso", ">", date("Y-m-d"))->get();
        $pdf = PDF::loadView('reportes.proximos_desembolsos_individual', compact('prestamos'))->setPaper('letter', 'portrait');

        // ENUMERAR LAS PÁGINAS USANDO CANVAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

        return $pdf->download('proximos_desembolsos_individual.pdf');
    }
    public function proximos_desembolsos_grupal(Request $request)
    {
        $filtro =  $request->filtro;
        $grupos = Grupo::where("fecha_desembolso", ">", date("Y-m-d"))->get();
        $pdf = PDF::loadView('reportes.proximos_desembolsos_grupal', compact('grupos'))->setPaper('letter', 'landscape');

        // ENUMERAR LAS PÁGINAS USANDO CANVAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

        return $pdf->download('proximos_desembolsos_grupal.pdf');
    }
    public function prestamos_individual_mora(Request $request)
    {
        $filtro =  $request->filtro;
        $fecha_ini =  $request->fecha_ini;
        $fecha_fin =  $request->fecha_fin;
        $prestamos = Prestamo::select("prestamos.*")
            ->join("plan_pagos", "plan_pagos.prestamo_id", "=", "prestamos.id")
            ->where("prestamos.desembolso", 1)
            ->where("plan_pagos.cancelado", "NO")
            ->where("plan_pagos.fecha_pago", "<", date("Y-m-d"))
            ->distinct()
            ->get();

        if ($filtro != 'Todos') {
            $prestamos = Prestamo::select("prestamos.*")
                ->join("plan_pagos", "plan_pagos.prestamo_id", "=", "prestamos.id")
                ->where("prestamos.desembolso", 1)
                ->where("plan_pagos.cancelado", "NO")
                ->whereBetween("plan_pagos.fecha_pago", [$fecha_ini, $fecha_fin])
                ->where("plan_pagos.fecha_pago", "<", date("Y-m-d"))
                ->distinct()
                ->get();
        }
        $pdf = PDF::loadView('reportes.prestamos_individual_mora', compact('prestamos'))->setPaper('letter', 'portrait');

        // ENUMERAR LAS PÁGINAS USANDO CANVAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

        return $pdf->download('prestamos_individual_mora.pdf');
    }
    public function prestamos_grupal_mora(Request $request)
    {
        $filtro =  $request->filtro;
        $fecha_ini =  $request->fecha_ini;
        $fecha_fin =  $request->fecha_fin;

        $grupos = Grupo::select("grupos.*")
            ->join("grupo_plan_pagos", "grupo_plan_pagos.grupo_id", "=", "grupos.id")
            ->where("grupos.desembolso", 1)
            ->where("grupo_plan_pagos.cancelado", "NO")
            ->where("grupo_plan_pagos.fecha_pago", "<", date("Y-m-d"))
            ->distinct()
            ->get();
        if ($filtro != 'Todos') {
            $grupos = Grupo::select("grupos.*")
                ->join("grupo_plan_pagos", "grupo_plan_pagos.grupo_id", "=", "grupos.id")
                ->where("grupos.desembolso", 1)
                ->where("grupo_plan_pagos.cancelado", "NO")
                ->whereBetween("grupo_plan_pagos.fecha_pago", [$fecha_ini, $fecha_fin])
                ->where("grupo_plan_pagos.fecha_pago", "<", date("Y-m-d"))
                ->distinct()
                ->get();
        }
        $pdf = PDF::loadView('reportes.prestamos_grupal_mora', compact('grupos'))->setPaper('letter', 'landscape');

        // ENUMERAR LAS PÁGINAS USANDO CANVAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

        return $pdf->download('prestamos_grupal_mora.pdf');
    }
    public function extracto_pagos_individual(Request $request)
    {
        $request->validate([
            "filtro" => "required"
        ], [
            "filtro.required" => "Debes seleccionar un registro"
        ]);

        $filtro =  $request->filtro;
        $prestamos = Prestamo::where("tipo", "INDIVIDUAL")->where("cliente_id", $filtro)->get();

        $pdf = PDF::loadView('reportes.extracto_pagos_individual', compact('prestamos'))->setPaper('letter', 'portrait');

        // ENUMERAR LAS PÁGINAS USANDO CANVAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

        return $pdf->download('extracto_pagos_individual.pdf');
    }
    public function extracto_pagos_grupal(Request $request)
    {
        $request->validate([
            "filtro" => "required"
        ], [
            "filtro.required" => "Debes seleccionar un registro"
        ]);

        $filtro =  $request->filtro;
        $grupos = Grupo::where("id", $filtro)->get();

        $pdf = PDF::loadView('reportes.extracto_pagos_grupal', compact('grupos'))->setPaper('letter', 'portrait');

        // ENUMERAR LAS PÁGINAS USANDO CANVAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

        return $pdf->download('extracto_pagos_grupal.pdf');
    }

    public function prestamos_estado(Request $request)
    {
        $gestion = $request->gestion;

        $categories = []; // meses

        // $series1 = [
        //     ["name" => "PRE APROBADOS", "data" => []],
        //     ["name" => "APROBADOS", "data" => []],
        //     ["name" => "RECHAZADOS", "data" => []]
        // ];

        $series1 = [
            [
                "name" => "PRE APROBADOS", "data" => [],
                "color" => "#156082"
            ],
            [
                "name" => "APROBADOS", "data" => [],
                "color" => "#E97132"
            ],
            [
                "name" => "RECHAZADOS", "data" => [],
                "color" => "#196B24"
            ]
        ];

        // $series2 = [
        //     ["name" => "CLIENTES CON MORA", "data" => []],
        //     ["name" => "CLIENTES PAGO EN FECHA", "data" => []],
        //     ["name" => "CLIENTES FINALIZADOS", "data" => []]
        // ];

        $series2 = [
            [
                "name" => "CLIENTES CON MORA", "data" => [],
                "color" => "#156082"

            ],
            [
                "name" => "CLIENTES PAGO EN FECHA", "data" => [],
                "color" => "#E97132"

            ],
            [
                "name" => "CLIENTES FINALIZADOS", "data" => [],
                "color" => "#196B24"
            ]
        ];


        $array_meses = [
            1 => "Enero",
            2 => "Febrero",
            3 => "Marzo",
            4 => "Abril",
            5 => "Mayo",
            6 => "Junio",
            7 => "Julio",
            8 => "Agosto",
            9 => "Septiembre",
            10 => "Octubre",
            11 => "Noviembre",
            12 => "Diciembre",
        ];

        $gestion_actual = date("Y");
        if ($gestion <= $gestion_actual) {
            $enero = 1;
            $ultimo_mes = 12;
            if ($gestion == $gestion_actual) {
                $mes_actual = (int)date("m");
                $ultimo_mes = $mes_actual;
            }
            for ($i = $enero; $i <= $ultimo_mes; $i++) {
                $categories[] = $array_meses[$i];

                $mes_txt = $i < 10 ? '0' . $i : $i;
                $fecha_buscar = $gestion . "-" . $mes_txt;

                // PRE APROBADOS
                $prestamos = Prestamo::where("tipo", "INDIVIDUAL")
                    ->where("fecha_registro", "LIKE", "$fecha_buscar%")
                    ->get();
                $grupos = Grupo::where("desembolso", 0)
                    ->where("fecha_registro", "LIKE", "$fecha_buscar%")
                    ->get();

                $series1[0]["data"][] = (int)(count($prestamos) + count($grupos));

                // APROBADOS
                $prestamos = Prestamo::where("tipo", "INDIVIDUAL")
                    ->where("fecha_aprobado", "LIKE", "$fecha_buscar%")
                    ->get();
                $grupos = Grupo::where("desembolso", 0)
                    ->where("fecha_aprobado", "LIKE", "$fecha_buscar%")
                    ->get();
                $series1[1]["data"][] = (int)(count($prestamos) + count($grupos));

                // RECHAZADOS
                $prestamos = Prestamo::where("tipo", "INDIVIDUAL")
                    ->where("fecha_rechazado", "LIKE", "$fecha_buscar%")
                    ->get();
                $grupos = Grupo::where("desembolso", 0)
                    ->where("fecha_rechazado", "LIKE", "$fecha_buscar%")
                    ->get();
                $series1[2]["data"][] = (int)(count($prestamos) + count($grupos));

                // CON MORA
                $prestamos = Pago::where("fecha_pago", "LIKE", "$fecha_buscar%")->where("dias_mora", ">", 0)->get();
                $series2[0]["data"][] = (int)(count($prestamos) + count($grupos));
                // PAGOS EN FECHA
                $prestamos = Pago::where("fecha_pago", "LIKE", "$fecha_buscar%")->where("dias_mora", 0)->get();
                $series2[1]["data"][] = (int)(count($prestamos) + count($grupos));

                // FINALIZADOS
                $prestamos = Prestamo::where("tipo", "INDIVIDUAL")
                    ->where("finalizado", 1)
                    ->where("updated_at", "LIKE", "$fecha_buscar%")
                    ->get();
                $grupos = Grupo::where("desembolso", 0)
                    ->where("finalizado", 1)
                    ->where("updated_at", "LIKE", "$fecha_buscar%")
                    ->get();

                $series2[2]["data"][] = (int)(count($prestamos) + count($grupos));
            }
        }

        return response()->JSON([
            "categories" => $categories,
            "series1" => $series1,
            "series2" => $series2,
        ]);
    }
}
