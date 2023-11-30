<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <title>PrestamosIndividual</title>
    <style type="text/css">
        * {
            font-family: sans-serif;
        }

        @page {
            margin-top: 1.5cm;
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
        <h4 class="texto">PRÉSTAMOS INDIVIDUAL</h4>
        <h4 class="fecha">Expedido: {{ date('d-m-Y') }}</h4>
    </div>
    <table border="1">
        <thead class="bg-principal">
            <tr>
                <th width="3%">N°</th>
                <th>CLIENTE</th>
                <th>C.I.</th>
                <th>MONTO</th>
                <th>PLAZO</th>
                <th>F. DE C.I.</th>
                <th>F. DE LUZ</th>
                <th>F. DE AGUA</th>
                <th>CROQUIS</th>
                <th>DOCUMENTO 1</th>
                <th>DOCUMENTO 2</th>
                <th>DOCUMENTO 3</th>
                <th>DOCUMENTO 4</th>
                <th>ESTADO</th>
                <th>DESEMBOLSO</th>
                <th>FECHA DESEMBOLSO</th>
                <th width="9%">FECHA DE REGISTRO</th>
            </tr>
        </thead>
        <tbody>
            @php
                $cont = 1;
            @endphp
            @foreach ($prestamos as $value)
                <tr>
                    <td class="centreado">{{ $cont++ }}</td>
                    <td class="centreado">{{ $value->cliente->full_name }}</td>
                    <td class="centreado">{{ $value->cliente->full_ci }}</td>
                    <td class="centreado">{{ $value->monto }}</td>
                    <td class="centreado">{{ $value->plazo }}</td>
                    <td class="centreado">{{ $value->f_ci == 1 ? 'SI' : 'NO' }}</td>
                    <td class="centreado">{{ $value->f_luz == 1 ? 'SI' : 'NO' }}</td>
                    <td class="centreado">{{ $value->f_agua == 1 ? 'SI' : 'NO' }}</td>
                    <td class="centreado">{{ $value->croquis == 1 ? 'SI' : 'NO' }}</td>
                    <td class="centreado">{{ $value->documento_1 }}</td>
                    <td class="centreado">{{ $value->documento_2 }}</td>
                    <td class="centreado">{{ $value->documento_3 }}</td>
                    <td class="centreado">{{ $value->documento_4 }}</td>
                    <td class="centreado">{{ $value->estado }}</td>
                    <td class="centreado">{{ $value->desembolso == 1 ? 'ENTREGADO' : 'PENDIENTE' }}</td>
                    <td class="centreado">{{ $value->fecha_desembolso ? $value->fecha_desembolso : 'S/F' }}</td>
                    <td class="centreado">{{ $value->fecha_registro ? $value->fecha_registro : 'S/F' }}</td>
                </tr>
            @endforeach
        </tbody>
    </table>
</body>

</html>
