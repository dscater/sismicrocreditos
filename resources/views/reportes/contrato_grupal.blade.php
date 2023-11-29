<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <title>Contrato individual</title>
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
            width: 600px;
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

        .bold {
            font-weight: bold;
        }

        .parrafo {
            font-size: 10pt;
            text-align: justify;
            line-height: 25px;
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
    @inject('configuracion', 'App\Models\Configuracion')
    <div class="encabezado">
        {{-- <div class="logo">
            <img src="{{ asset('imgs/' . $configuracion->first()->logo) }}">
        </div> --}}
        <h2 class="titulo">
            {{ $configuracion->first()->razon_social }}
        </h2>
        <h4 class="texto">CONTRATO DE PRESTAMO DE DINERO</h4>
    </div>

    <p class="parrafo">
        Conste por el presente documento privado que podrá elevarse a categoría de documento público
        mediante reconocimiento de firmas y rubricas, ante autoridad competente a solicitud de cualquiera
        de las partes, el contrato de préstamo de dinero libremente contraído que se celebra de acuerdo a
        las siguientes clausulas:
    </p>
    <p class="parrafo">
        <span class="bold">PRIMERA.-</span> El contrato de préstamo de dinero que otorga la asociación de crédito
        “{{ $configuracion->first()->razon_social }}” representado por el/la asesor(a) de la ciudad de el alto
        {{ $prestamo->user_desembolso->full_name }} con
        C.I. {{ $prestamo->user_desembolso->full_ci }}. A favor de:
    </p>
    <p class="parrafo">
        {{ $prestamo->cliente->full_name }} con C.I. {{ $prestamo->cliente->full_ci }} {{ $prestamo->monto }}.- Bs
    </p>
    <p class="parrafo">
        Para efectos del presente contrato el Prestatario(a) en los términos y condiciones pactados a
        continuación que regirán la relación entre personas intervinientes con valor de ley entre ellas.
    </p>
    <p class="parrafo">
        <span class="bold">SEGUNDA.-</span> Por el presente contrato “{{ $configuracion->first()->razon_social }}”
        OTORGA UN PRESTAMO DE
        DINERO a favor del Prestatario(a) de {{ number_format($prestamo->monto, 2, '.', ',') }} ({{ $literal }})
        suma que será
        destinada a otorgar préstamos de dinero con intereses a las socias competentes de acuerdo a la
        planilla de desembolso que forma parte inseparable e indivisible del presente documento.
    </p>
    <p class="parrafo">
        <span class="bold">TERCERA.-</span> El Prestatario(a) se obliga a pagar intereses del 3% mensual sobre saldos
        de
        capital y
        el 1.9% por gastos de administración según el monto establecido.
    </p>
    <p class="parrafo">
        <span class="bold">CUARTA.-</span> El interés establecido regirá hasta {{ $prestamo->ultima_fecha_pago }}
        fecha de conclusión del
        ciclo de préstamo
        y se recargara con el interés penal en caso de mora.
    </p>
    <p class="parrafo">
        <span class="bold">QUINTA.-</span> El Prestatario(a) declara recibir de
        “{{ $configuracion->first()->razon_social }}” la suma indicada en
        la
        clausula segunda en el lugar y fecha que se establece en el documento “ENTREGA DE DINERO EN
        EFECTIVO”, documento parte del presente contrato de la que todos los componentes del
        Prestatario(a) se constituyen deudores incondicionales, obligándose a sus pagos semanales
        establecidos en forma y condiciones estipuladas en el presente contrato.
    </p>
    <p class="parrafo">
        <span class="bold">SEXTA.-</span> Autorizamos a {{ $configuracion->first()->razon_social }} a realizar la
        investigación de cualquier
        antecedente
        crediticio, judicial y/o la verificación de nuestros domicilios y trabajos así mismo sin el caso requiere
        autorizamos a reportar nuestros datos personales a un Buro de Información Crediticia en caso de
        que incurramos en algún tipo de incumplimiento financiero con {{ $configuracion->first()->razon_social }}.
    </p>
    <p class="parrafo">
        <span class="bold">SEPTIMA.-</span> Todas las socias del Prestatario(a) que suscriben el presente contrato, se
        convierten en
        garantes solidarias, mancomunadas e indivisibles con la totalidad de sus bienes habidos y por
        haber, del cumplimiento de la presente obligación. Así mismo asumen plena responsabilidad en
        caso de incumplimiento de cualquiera de las socias por el monto total de la deuda.
    </p>
    <p class="parrafo">
        <span class="bold">OCTAVA.-</span> “{{ $configuracion->first()->razon_social }}” y el Prestatario(a)
        declaramos en forma expresa nuestra
        conformidad con todas y cada una de las clausulas señaladas en el presente contrato de préstamo
        de dinero, obligándonos a su fiel y estricto cumplimiento. Y en señal de esta aceptación firmamos o
        estampamos nuestra huella digital en el presente contrato.
    </p>

    <table class="firmas">
        <tbody>
            <tr>
                <td class="top_punteado">{{ $prestamo->cliente->full_name }}</td>
                <td class="top_punteado">{{ $prestamo->user_desembolso->full_name }}</td>
            </tr>
            <tr>
                <td>{{ $prestamo->cliente->full_ci }}</td>
                <td>{{ $configuracion->first()->razon_social }}</td>
            </tr>
            <tr>
                <td></td>
                <td>{{ $prestamo->user_desembolso->full_ci }}</td>
            </tr>
        </tbody>
    </table>
</body>

</html>
