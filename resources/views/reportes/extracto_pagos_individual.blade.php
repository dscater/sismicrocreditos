<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <title>ExtratoPagosIndividuales</title>
    <style type="text/css">
        * {
            font-family: sans-serif;
        }

        @page {
            margin-top: 1.5cm;
            margin-bottom: 1.5cm;
            margin-left: 2cm;
            margin-right: 1.5cm;
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
            font-size: 7pt;
        }

        table tbody tr td {
            font-size: 6pt;
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

        .bold {
            font-weight: bold;
        }

        .font-md {
            font-size: 10pt;
        }

        .derecha {
            text-align: right;
        }

        .nueva_pagina {
            page-break-before: always;
        }
    </style>
</head>

<body>
    @inject('configuracion', 'App\Models\Configuracion')
    @php
        $fecha_actual = date('Y-m-d');
    @endphp
    @foreach ($prestamos as $key => $value)
        <div class="encabezado">
            <div class="logo">
                <img src="{{ asset('imgs/' . $configuracion->first()->logo) }}">
            </div>
            <h2 class="titulo">
                {{ $configuracion->first()->razon_social }}
            </h2>
            <h4 class="texto">EXTRACTO PAGOS INDIVIDUALES</h4>
            <h4 class="fecha">Expedido: {{ date('d-m-Y') }}</h4>
        </div>
        <table border="1" class="cliente">
            <tbody>
                <tr>
                    <td class="bold gray" width="14%">CLIENTE: </td>
                    <td>{{ $value->cliente->full_name }}</td>
                    <td width="6%" class="bold gray">C.I.: </td>
                    <td width="30%">{{ $value->cliente->full_ci }}</td>
                </tr>
                <tr>
                    <td class="bold gray">MONTO PRÉSTAMO: </td>
                    <td colspan="3">{{ $value->monto }}</td>
                </tr>
            </tbody>
        </table>
        <h4 class="centreado font-md">EXTRACTO DE PAGOS</h4>
        @php
            $plan_pagos = App\Models\PlanPago::where('prestamo_id', $value->id)->get();
        @endphp
        <table border="1">
            <thead>
                <tr>
                    <th width="10%">NRO. CUOTA</th>
                    <th>MONTO</th>
                    <th>DÍAS MORA</th>
                    <th>MONTO MORA</th>
                    <th>FECHA PAGO</th>
                    <th>ESTADO</th>
                </tr>
            </thead>
            <tbody>
                @php
                    $total = 0;
                @endphp
                @foreach ($plan_pagos as $ppm)
                    @php
                        $fecha_pago = $ppm->fecha_pago;
                        if ($ppm->cancelado == 'SI') {
                            $pago = App\Models\Pago::where('plan_pago_id', $ppm->id)
                                ->get()
                                ->first();
                            $dias_mora = 0;
                            $monto_mora = 0;
                            if (!$pago) {
                                $ultimo_pago = $value->ultimo_pago;
                                // $fecha_pago = $ultimo_pago->fecha_pago;
                                $dias_mora = App\Models\Prestamo::obtenerDiferenciaDias(
                                    $ultimo_pago->fecha_pago,
                                    $ppm->fecha_pago,
                                );
                                $monto_mora = 0;
                                if ($dias_mora > 0) {
                                    // $monto_mora = ($value->monto / 100) * 0.3 * $dias_mora;//antiguo
                                    $monto_mora = 3 * $dias_mora; //nuevo 3 Bs por dia
                                }
                            } else {
                                $dias_mora = $pago->dias_mora;
                                $monto_mora = $pago->monto_mora;
                            }
                        } else {
                            $dias_mora = App\Models\Prestamo::obtenerDiferenciaDias($fecha_actual, $ppm->fecha_pago);
                            $monto_mora = 0;
                            if ($dias_mora > 0) {
                                // $monto_mora = ($value->monto / 100) * 0.3 * $dias_mora;//antiguo
                                $monto_mora = 3 * $dias_mora; //nuevo 3 Bs por dia
                            }
                            $total += (float) $monto_mora;
                        }
                    @endphp
                    <tr>
                        <td class="centreado">{{ $ppm->nro_cuota }}</td>
                        <td class="centreado">{{ $ppm->cuota }}</td>
                        <td class="centreado">{{ $dias_mora > 0 || $ppm->cancelado == 'SI' ? $dias_mora : '-' }}</td>
                        <td class="centreado">{{ number_format($monto_mora, 2, ',', '.') }}</td>
                        <td class="centreado">{{ date('d/m/Y', strtotime($fecha_pago)) }}</td>
                        <td class="centreado">{{ $ppm->cancelado == 'SI' ? 'PAGADO' : 'SIN PAGAR' }}</td>
                    </tr>
                @endforeach
            </tbody>
        </table>
        @if ($key < count($prestamos) - 1)
            <div class="nueva_pagina"></div>
        @endif
    @endforeach
</body>

</html>
