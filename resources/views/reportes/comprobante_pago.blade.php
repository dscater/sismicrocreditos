<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <title>ComprobantePago</title>
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
            font-size: 9pt;
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
            width: 400px;
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

        .bold {
            font-weight: bold;
        }

        .derecha {
            text-align: right;
        }

        .text-lg {
            font-size: 10pt;
        }

        .firmas {
            margin-top: 70px;
            border-collapse: separate;
            border-spacing: 40px 0px;
        }

        .firmas td {
            text-align: center;
            padding: 0px;
        }

        .top_punteado {
            border-top: dotted 1px black;
        }
    </style>
</head>

<body>
    @php
        $array_meses = [
            '01' => 'Enero',
            '02' => 'Febrero',
            '03' => 'Marzo',
            '04' => 'Abril',
            '05' => 'Mayo',
            '06' => 'Junio',
            '07' => 'Julio',
            '08' => 'Agosto',
            '09' => 'Septiembre',
            '10' => 'Octubre',
            '11' => 'Novimebre',
            '12' => 'Diciembre',
        ];
    @endphp
    @inject('configuracion', 'App\Models\Configuracion')
    <div class="encabezado">
        <div class="logo">
            <img src="{{ asset('imgs/' . $configuracion->first()->logo) }}">
        </div>
        <h2 class="titulo">
            {{ $configuracion->first()->razon_social }}
        </h2>
        <h4 class="fecha">El Alto, {{ date('d') }} de {{ $array_meses[date('m')] }} de {{ date('Y') }}</h4>
        <h4 class="texto">COMPROBANTE DE PAGO</h4>
        @if ($pago->prestamo)
            <table>
                <tbody>
                    <tr>
                        <td class="bold derecha" width="25%">Cliente: </td>
                        <td colspan="3">{{ $pago->cliente->full_name }}</td>
                    </tr>
                    <tr>
                        <td class="bold derecha">Monto Pagado: </td>
                        <td colspan="3">{{ number_format($pago->monto, 2, '.', ',') }}
                        </td>
                    </tr>
                    <tr>
                        <td class="bold derecha">Interes: </td>
                        <td colspan="3">{{ number_format($pago->interes, 2, '.', ',') }}
                        </td>
                    </tr>
                    <tr>
                        <td class="bold derecha">Monto mora: </td>
                        <td colspan="3">{{ number_format($pago->monto_mora, 2, '.', ',') }}
                        </td>
                    </tr>
                    <tr>
                        <td class="bold derecha">Saldo: </td>
                        <td colspan="3">{{ number_format($pago->plan_pago->saldo, 2, '.', ',') }}
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4" class="text-lg bold centreado">TOTAL PAGADO:
                            {{ number_format($pago->monto_total, 2, '.', ',') }}
                            ({{ $literal }})
                        </td>
                    </tr>
                </tbody>
            </table>
            <table class="firmas">
                <tbody>
                    <tr>
                        <td class="top_punteado">{{ $pago->cliente->full_name }}</td>
                        <td class="top_punteado">{{ $pago->user->full_name }}</td>
                    </tr>
                    <tr>
                        <td>{{ $pago->cliente->full_ci }}</td>
                        <td>{{ $configuracion->first()->razon_social }}</td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>{{ $pago->user->full_ci }}</td>
                    </tr>
                </tbody>
            </table>
        @elseif($pago->grupo)
            <table>
                <tbody>
                    <tr>
                        <td class="bold derecha" width="25%">Nombre Grupo: </td>
                        <td colspan="3">{{ $pago->grupo->nombre }}</td>
                    </tr>
                    <tr>
                        <td class="bold derecha">Integrantes: </td>
                        <td colspan="3">
                            @foreach ($pago->grupo->prestamos as $key_inte=>$inte)
                                {{ $inte->cliente->full_name }}
                                @if($key_inte < count($pago->grupo->prestamos) - 1)
                                <span>, </span>
                                @endif
                            @endforeach
                        </td>
                    </tr>
                    <tr>
                        <td class="bold derecha">Monto Pagado: </td>
                        <td colspan="3">{{ number_format($pago->monto, 2, '.', ',') }}
                        </td>
                    </tr>
                    <tr>
                        <td class="bold derecha">Interes: </td>
                        <td colspan="3">{{ number_format($pago->interes, 2, '.', ',') }}
                        </td>
                    </tr>
                    <tr>
                        <td class="bold derecha">Monto mora: </td>
                        <td colspan="3">{{ number_format($pago->monto_mora, 2, '.', ',') }}
                        </td>
                    </tr>
                    <tr>
                        <td class="bold derecha">Saldo: </td>
                        <td colspan="3">{{ number_format($pago->grupo_plan_pago->saldo, 2, '.', ',') }}
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4" class="text-lg bold centreado">TOTAL PAGADO:
                            {{ number_format($pago->monto_total, 2, '.', ',') }}
                            ({{ $literal }})
                        </td>
                    </tr>
                </tbody>
            </table>
            <table class="firmas">
                <tbody>
                    <tr>
                        <td class="top_punteado">{{ $pago->grupo->nombre }}</td>
                        <td class="top_punteado">{{ $pago->user->full_name }}</td>
                    </tr>
                    <tr>
                        <td>REPRESENTANTE</td>
                        <td>{{ $configuracion->first()->razon_social }}</td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>{{ $pago->user->full_ci }}</td>
                    </tr>
                </tbody>
            </table>
        @endif
    </div>
</body>

</html>
