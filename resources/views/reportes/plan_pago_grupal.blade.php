<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <title>Plan de Pago Grupal</title>
    <style type="text/css">
        * {
            font-family: sans-serif;
        }

        @page {
            margin-top: 1cm;
            margin-bottom: 1cm;
            margin-left: 1.5cm;
            margin-right: 1cm;
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
            font-size: 9pt;
        }

        table tbody tr td {
            font-size: 8pt;
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
            background: rgb(236, 236, 236);
        }

        .bg-principal {
            background: #222222;
            color: white;
        }

        .txt_rojo {}

        .img_celda img {
            width: 45px;
        }

        .bold {
            font-weight: bold;
        }

        .nueva_pagina {
            page-break-after: always;
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
        <h4 class="texto">PLAN DE PAGOS</h4>
        <h4 class="fecha">GRUPAL</h4>
        <h4 class="fecha">Expedido: {{ date('d-m-Y') }}</h4>
    </div>
    <table border="1">
        <tbody>
            <tr>
                <td class="bold gray" width="14%">Nombre Grupo: </td>
                <td colspan="3">{{ $datos['nombre'] }} </td>
            </tr>
            <tr>
                <td class="bold gray" width="8%">Monto: </td>
                <td colspan="3">{{ number_format($datos['monto'], 2, '.', ',') }} <span
                        class="literal">({{ $literal }})</span></td>
            </tr>
            <tr>
                <td class="bold gray">Plazo: </td>
                <td>{{ $datos['plazo'] }} cuotas</td>
                <td class="bold gray">Interés: </td>
                <td>4.9%</td>
            </tr>
        </tbody>
    </table>
    <table border="1">
        <thead>
            <tr>
                <th width="5%"></th>
                <th>Saldo inicial</th>
                <th>Capital</th>
                <th>Interes</th>
                <th>Saldo</th>
                <th>Cuota Semanal</th>
            </tr>
        </thead>
        <tbody>
            @foreach ($plan_pago as $pp)
                <tr>
                    <td class="centreado">{{ $pp['nro'] }}</td>
                    <td class="centreado">{{ $pp['saldo_inicial'] }}</td>
                    <td class="centreado">{{ $pp['capital'] }}</td>
                    <td class="centreado">{{ $pp['interes'] }}</td>
                    <td class="centreado">{{ $pp['saldo'] }}</td>
                    <td class="centreado">{{ $cuota_fija }}</td>
                </tr>
            @endforeach
        </tbody>
    </table>

    @if ($grupo)
        @foreach ($grupo->prestamos as $prestamo)
            <div class="nueva_pagina"></div>
            @php
                $array_monto = explode('.', $prestamo->monto);
                $literal = $convertir->convertir($array_monto[0]);
                $literal .= ' ' . $array_monto[1] . '/100.' . ' Bolivianos';
            @endphp
            <div class="encabezado">
                <div class="logo">
                    <img src="{{ asset('imgs/' . $configuracion->first()->logo) }}">
                </div>
                <h2 class="titulo">
                    {{ $configuracion->first()->razon_social }}
                </h2>
                <h4 class="texto">PLAN DE PAGOS</h4>
                <h4 class="fecha">GRUPAL</h4>
                <h4 class="fecha">Expedido: {{ date('d-m-Y') }}</h4>
            </div>
            <table border="1">
                <tbody>
                    <tr>
                        <td class="bold gray" width="8%">Nombre: </td>
                        <td>{{ $prestamo->cliente->nombre }} {{ $prestamo->cliente->paterno }}
                            {{ $prestamo->cliente->materno }}</td>
                        <td class="bold gray" width="8%">C.I.: </td>
                        <td>{{ $prestamo->cliente->ci }} {{ $prestamo->cliente->ci_exp }}</td>
                    </tr>
                    <tr>
                        <td class="bold gray" width="8%">Monto: </td>
                        <td colspan="3">{{ number_format($prestamo->monto, 2, '.', ',') }} <span
                                class="literal">({{ $literal }})</span></td>
                    </tr>
                    <tr>
                        <td class="bold gray">Plazo: </td>
                        <td>{{ $prestamo->plazo }} cuotas</td>
                        <td class="bold gray">Interés: </td>
                        <td>4.9%</td>
                    </tr>
                </tbody>
            </table>
            <table border="1">
                <thead>
                    <tr>
                        <th width="5%"></th>
                        <th>Saldo inicial</th>
                        <th>Capital</th>
                        <th>Interes</th>
                        <th>Saldo</th>
                        <th>Cuota Semanal</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach ($prestamo->plan_pagos as $ppc)
                        <tr>
                            <td class="centreado">{{ $ppc->nro }}</td>
                            <td class="centreado">{{ $ppc->saldo_inicial }}</td>
                            <td class="centreado">{{ $ppc->capital }}</td>
                            <td class="centreado">{{ $ppc->interes }}</td>
                            <td class="centreado">{{ $ppc->saldo }}</td>
                            <td class="centreado">{{ $ppc->cuota }}</td>
                        </tr>
                    @endforeach
                </tbody>
            </table>
        @endforeach
    @endif
</body>

</html>
