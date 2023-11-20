<?php

namespace App\Http\Controllers;

use App\Models\ActividadContingencia;
use App\Models\AmenazaSeguridad;
use App\Models\PlanContingencia;
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

        $pdf = PDF::loadView('reportes.usuarios', compact('usuarios'))->setPaper('legal', 'landscape');

        // ENUMERAR LAS PÁGINAS USANDO CANVAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

        return $pdf->download('Usuarios.pdf');
    }

    public function plan_contingencia(Request $request)
    {
        $filtro =  $request->filtro;
        $tipo =  $request->tipo;

        if ($filtro == 'Filtrar') {
            $request->validate([
                "tipo" => "required"
            ], [
                "tipo.required" => "Debes seleccionar una opción"
            ]);
        }

        $plan_contingencias = PlanContingencia::all();
        $roles_funciones = RolFuncion::all();
        $amenazas_seguridad = AmenazaSeguridad::all();
        $actividades_contingencias = ActividadContingencia::all();

        $pdf = PDF::loadView('reportes.plan_contingencias', compact('plan_contingencias', 'roles_funciones', 'amenazas_seguridad', 'actividades_contingencias', 'filtro', 'tipo'))
            ->setPaper('legal', 'landscape');

        // ENUMERAR LAS PÁGINAS USANDO CANVAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

        return $pdf->download('plan_contingencias.pdf');
    }
    public function cantidad_plan_contingencia(Request $request)
    {
        $filtro =  $request->filtro;
        $tipo =  $request->tipo;

        if ($filtro == 'Tipo') {
            $request->validate([
                "tipo" => "required"
            ], [
                "tipo.required" => "Debes seleccionar una opción"
            ]);
        }

        $plan_contingencias = PlanContingencia::all();
        $roles_funciones = RolFuncion::all();
        $amenazas_seguridad = AmenazaSeguridad::all();
        $actividades_contingencias = ActividadContingencia::all();

        $datos = [];

        $datos = [
            ["PLAN DE CONTINGENCIAS", (int)count($plan_contingencias)],
            ["ROLES Y FUNCIONES", (int)count($roles_funciones)],
            ["AMENAZAS Y SEGURIDAD", (int)count($amenazas_seguridad)],
            ["ACTIVIDADES DE CONTINGENCIAS", (int)count($actividades_contingencias)],
        ];

        if ($filtro != 'Todos' && $tipo == 'PLAN DE CONTINGENCIAS') {
            $datos = [
                ["PLAN DE CONTINGENCIAS", (int)count($plan_contingencias)],
            ];
        }

        if ($filtro != 'Todos' && $tipo == 'ROLES Y FUNCIONES') {
            $datos = [
                ["ROLES Y FUNCIONES", (int)count($roles_funciones)],
            ];
        }

        if ($filtro != 'Todos' && $tipo == 'AMENAZAS Y SEGURIDAD') {
            $datos = [
                ["AMENAZAS Y SEGURIDAD", (int)count($amenazas_seguridad)],
            ];
        }

        if ($filtro != 'Todos' && $tipo == 'ACTIVIDADES DE CONTINGENCIAS') {
            $datos = [
                ["ACTIVIDADES DE CONTINGENCIAS", (int)count($actividades_contingencias)],
            ];
        }

        return response()->JSON([
            "datos" => $datos
        ]);
    }
}
