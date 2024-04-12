<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <title>Historial Crediticio</title>
    <style type="text/css">
        * {
            font-family: sans-serif;
        }

        @page {
            margin-top: 1cm;
            margin-bottom: 0.5cm;
            margin-left: 0.5cm;
            margin-right: 0.5cm;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            table-layout: fixed;
            margin-top: 20px;
            page-break-before: avoid;
        }

        table thead tr th,
        tbody tr td {
            padding: 3px;
            word-wrap: break-word;
        }

        table thead tr th {
            font-size: 7.5pt;
        }

        table tbody tr td {
            font-size: 6.5pt;
        }


        .encabezado {
            width: 100%;
        }

        .logo img {
            position: absolute;
            width: 200px;
            height: 90px;
            top: -20px;
            left: 0px;
        }

        h2.titulo {
            width: 450px;
            margin: auto;
            margin-top: 0PX;
            margin-bottom: 15px;
            text-align: center;
            font-size: 14pt;
        }

        .texto {
            width: 250px;
            text-align: center;
            margin: auto;
            margin-top: 15px;
            font-weight: bold;
            font-size: 1.1em;
        }

        .fecha {
            width: 250px;
            text-align: center;
            margin: auto;
            margin-top: 15px;
            font-weight: normal;
            font-size: 0.85em;
        }

        .total {
            text-align: right;
            padding-right: 15px;
            font-weight: bold;
        }

        table {
            width: 100%;
        }

        table thead {
            background: rgb(236, 236, 236)
        }

        tr {
            page-break-inside: avoid !important;
        }

        .centreado {
            padding-left: 0px;
            text-align: center;
        }

        .datos {
            margin-left: 15px;
            border-top: solid 1px;
            border-collapse: collapse;
            width: 250px;
        }

        .txt {
            font-weight: bold;
            text-align: right;
            padding-right: 5px;
        }

        .txt_center {
            font-weight: bold;
            text-align: center;
        }

        .cumplimiento {
            position: absolute;
            width: 150px;
            right: 0px;
            top: 86px;
        }

        .b_top {
            border-top: solid 1px black;
        }

        .gray {
            background: rgb(237, 237, 237);
        }

        .bg-principal {
            background: #222222;
            color: white;
        }

        .txt_rojo {}


        .img_celda img {
            width: 45px;
        }

        .nueva_pagina {
            page-break-after: always;
        }

        .subtitulo {
            font-size: 0.9em;
        }

        .txtinfo {
            font-weight: bold;
        }

        .border-bot {
            border-bottom: dotted 0.7px black;
        }

        .table-info {
            margin-top: 4px;
            border-collapse: separate;
            border-spacing: 35px 0px;
        }

        .bordeado {
            border: solid 0.7px black;
            height: 14px;
        }

        .bold {
            font-weight: bold;
        }

        .text-md {
            font-size: 0.8em;
        }

        .foto {
            width: 14%;
            padding: 0px;
            padding-bottom: 5px;
        }

        .foto img {
            width: 100%;
        }

        .bg-principal {
            background: #222222;
            color: white;
        }
    </style>
</head>

<body>
    @inject('configuracion', 'App\Models\Configuracion')
    <div class="encabezado">
        <div class="logo">
            <img src="{{ asset('imgs/' . $configuracion->first()->logo) }}">
        </div>
        <h2 class="titulo">
            {{ $configuracion->first()->razon_social }}
        </h2>
        <h4 class="texto">HISTORIAL CREDITICIO</h4>
        <h4 class="fecha">Expedido: {{ date('d-m-Y') }}</h4>
    </div>



    <h2 class="subtitulo centreado">DATOS DEL CLIENTE</h2>
    <table class="table-info">
        <tbody>
            <tr>
                <td class="centreado border-bot">{{ $cliente->paterno }}</td>
                <td class="centreado border-bot">{{ $cliente->materno }}</td>
                <td class="centreado border-bot">{{ $cliente->nombre }}</td>
                <td class="centreado border-bot">{{ $cliente->segundo_nombre }}</td>
            </tr>
            <tr>
                <td class="centreado txtinfo">Ap. Paterno</td>
                <td class="centreado txtinfo">Ap. Materno</td>
                <td class="centreado txtinfo">Nombre</td>
                <td class="centreado txtinfo">Segundo Nombre</td>
            </tr>
            <tr>
                <td class="centreado border-bot">{{ $cliente->full_ci }}</td>
                <td class="centreado border-bot">{{ $cliente->cel }}</td>
                <td class="centreado border-bot">{{ $cliente->edad }}</td>
                <td class="centreado border-bot">{{ $cliente->dir }}</td>
            </tr>
            <tr>
                <td class="centreado txtinfo">Cédula de Identidad</td>
                <td class="centreado txtinfo">Teléfono/Celular</td>
                <td class="centreado txtinfo">Edad</td>
                <td class="centreado txtinfo">Dirección</td>
            </tr>
            <tr>
                <td class="centreado border-bot">{{ $cliente->referencia }}</td>
                <td class="centreado border-bot">{{ $cliente->cel_ref }}</td>
                <td class="centreado border-bot">{{ $cliente->parentesco }}</td>
                <td class="centreado border-bot">{{ $cliente->cel }}</td>
            </tr>
            <tr>
                <td class="centreado txtinfo">Referencia</td>
                <td class="centreado txtinfo">Celular Referencia</td>
                <td class="centreado txtinfo">Parentesco</td>
                <td class="centreado txtinfo">Celular</td>
            </tr>
            <tr>
                <td class="centreado border-bot">{{ $cliente->fecha_registro_t }}</td>
                <td></td>
                <td></td>
                <td></td>
            </tr>
            <tr>
                <td class="centreado txtinfo">Fecha de Registro</td>
                <td></td>
                <td></td>
                <td></td>
            </tr>
        </tbody>
    </table>
    <h2 class="subtitulo centreado">INFORMACIÓN DE PRÉSTAMOS</h2>
    <table border="1">
        <thead class="bg-principal">
            <tr>
                <th width="3%">N°</th>
                <th>Tipo Préstamo</th>
                <th>Monto Préstamo</th>
                <th>Plazo<br><small>(Semanas)</small></th>
                <th>Pagos a Tiempo</th>
                <th>Pagos con Mora</th>
                <th>Pagos pendientes</th>
                <th>Estado Préstamo</th>
                <th>Fecha de Registro</th>
                <th>Fecha de desembolso</th>
                <th>Estado Desembolso</th>
            </tr>
        </thead>
        <tbody>
            @php
                $suma_monto = 0;
                $cont = 1;
                $total_tiempo = 0;
                $total_mora = 0;
                $total_pendiente = 0;
            @endphp
            @foreach ($cliente->prestamos as $prestamo)
                <tr>
                    <td>{{ $cont++ }}</td>
                    <td>{{ $prestamo->tipo }}
                        @if ($prestamo->tipo == 'GRUPAL')
                            <br /><small
                                style="font-size:0.85em;font-weight:bold;">({{ $prestamo->grupo->nombre }})</small>
                        @endif
                    </td>
                    <td class="centreado">{{ $prestamo->monto }}
                        @if ($prestamo->tipo == 'GRUPAL')
                            <br /><small
                                style="font-size:0.95em;font-weight:bold;">({{ $prestamo->grupo->monto }})</small>
                        @endif
                    </td>
                    <td class="centreado">{{ $prestamo->plazo }}</td>
                    <td class="centreado">
                        @if ($prestamo->tipo == 'INDIVIDUAL')
                            {{ $prestamo->pagos_tiempo }}
                        @else
                            {{ $prestamo->grupo->pagos_tiempo }}
                        @endif
                    </td>
                    <td class="centreado">
                        @if ($prestamo->tipo == 'INDIVIDUAL')
                            {{ $prestamo->pagos_mora }}
                        @else
                            {{ $prestamo->grupo->pagos_mora }}
                        @endif
                    </td>
                    <td class="centreado">
                        @if ($prestamo->tipo == 'INDIVIDUAL')
                            {{ $prestamo->desembolso == 1 ? $prestamo->pagos_pendiente : '-' }}
                        @else
                            {{ $prestamo->grupo->pagos_pendiente }}
                        @endif
                    </td>
                    <td>{{ $prestamo->finalizado == 1 ? 'CANCELADO' : $prestamo->estado }}</td>
                    <td>{{ $prestamo->fecha_registro_t }}</td>
                    <td>{{ $prestamo->fecha_desembolso ? $prestamo->fecha_desembolso_t : '' }}</td>
                    <td>{{ $prestamo->desembolso == 1 ? 'ENTREGADO' : 'PENDIENTE' }}</td>
                </tr>
                @php
                    $suma_monto = (float) $suma_monto + (float) $prestamo->monto;
                    if ($prestamo->tipo == 'INDIVIDUAL') {
                        $total_tiempo = (int) $total_tiempo + (int) $prestamo->pagos_tiempo;
                    } else {
                        $total_tiempo = (int) $total_tiempo + (int) $prestamo->grupo->pagos_tiempo;
                    }
                    if ($prestamo->tipo == 'INDIVIDUAL') {
                        $total_mora = (int) $total_mora + (int) $prestamo->pagos_mora;
                    } else {
                        $total_tiempo = (int) $total_tiempo + (int) $prestamo->grupo->pagos_mora;
                    }
                    if ($prestamo->tipo == 'INDIVIDUAL') {
                        if ($prestamo->desembolso == 1) {
                            $total_pendiente = (int) $total_pendiente + (int) $prestamo->pagos_pendiente;
                        }
                    } elseif ($prestamo->grupo->desembolso == 1) {
                        $total_pendiente = (int) $total_pendiente + (int) $prestamo->grupo->pagos_pendiente;
                    }
                @endphp
            @endforeach

            <tr class=gray>
                <td class="centreado bold text-md"></td>
                <td class="centreado bold text-md">TOTAL</td>
                <td class="centreado bold text-md">{{ number_format($suma_monto, 2, '.', '') }}</td>
                <td class="centreado bold text-md"></td>
                <td class="centreado bold text-md">{{ $total_tiempo }}</td>
                <td class="centreado bold text-md">{{ $total_mora }}</td>
                <td class="centreado bold text-md">{{ $total_pendiente }}</td>
                <td class="centreado bold text-md"></td>
                <td class="centreado bold text-md"></td>
                <td class="centreado bold text-md"></td>
                <td class="centreado bold text-md"></td>
            </tr>
        </tbody>
    </table>
</body>

</html>
