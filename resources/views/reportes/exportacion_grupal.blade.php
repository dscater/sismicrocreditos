<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <title>Lista de Pagos</title>
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
            font-size: 8pt;
        }

        table tbody tr td {
            font-size: 7pt;
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
            background: rgb(202, 202, 202);
        }

        .bg-principal {
            background: #222222;
            color: white;
        }

        .txt_rojo {}

        .img_celda img {
            width: 45px;
        }

        .info {
            width: 80%;
            margin: auto;
            margin-top: 30px;
        }

        .bold {
            font-weight: bold;
        }

        .subtitulo {
            font-size: 0.8em;
            text-align: center;
        }

        .bg-principal {
            background: #222222;
            color: white;
        }

        .text-md {
            font-size: 9pt;
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
        <h4 class="texto">LISTA DE PAGOS</h4>
        <h4 class="fecha">Expedido: {{ date('d-m-Y') }}</h4>
    </div>

    <table class="info">
        <tbody>
            <tr>
                <td class="bold" width="10%">Nombre Grupo:</td>
                <td colspan="3">{{ $grupo->nombre }}</td>
                <td class="bold">Monto Préstamo:</td>
                <td>{{ $grupo->monto }}</td>
                <td class="bold">Fecha de Registro:</td>
                <td>{{ $grupo->fecha_registro_t }}</td>
            </tr>
        </tbody>
    </table>

    <h4 class="subtitulo">PAGOS REALIZADOS</h4>
    <table border="1">
        <thead class="bg-principal">
            <tr>
                <th width="5%">N° Cuota</th>
                <th>Fecha</th>
                <th>Capital</th>
                <th>Interés</th>
                <th>Días Mora</th>
                <th>Monto Mora</th>
                <th>Total Cancelado</th>
                <th>Descripción</th>
                <th>Usuario</th>
            </tr>
        </thead>
        <tbody>
            @php
                $suma_total = 0;
            @endphp
            @foreach ($pagos as $pago)
                <tr>
                    <td class="centreado">
                        @if ($pago->tipo_pago == 'CUOTA')
                            {{ $pago->nro_cuota }}
                        @else
                            -
                        @endif
                    </td>
                    <td>{{ $pago->fecha_pago }}</td>
                    <td>{{ $pago->monto }}</td>
                    <td>{{ $pago->interes }}</td>
                    <td>{{ $pago->dias_mora }}</td>
                    <td>{{ $pago->monto_mora }}</td>
                    <td>{{ $pago->monto_total }}</td>
                    <td>{{ $pago->tipo_pago == 'CUOTA' ? 'PAGO DE CUOTA' : 'LIQUIDACIÓN TOTAL DEL PRÉSTAMO' }}</td>
                    <td>{{ $pago->user->usuario }}</td>
                </tr>
                @php
                    $suma_total = (float) $suma_total + (float) $pago->monto_total;
                @endphp
            @endforeach
            <tr class="bg-principal">
                <td></td>
                <td class="text-md bold" colspan="5">TOTAL</td>
                <td class="text-md bold">{{ number_format($suma_total, 2, '.', '') }}</td>
                <td></td>
                <td></td>
            </tr>
        </tbody>
    </table>
</body>

</html>
