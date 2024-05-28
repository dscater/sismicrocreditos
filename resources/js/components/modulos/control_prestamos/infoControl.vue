<template>
    <div class="row">
        <div class="col-12">
            <div class="row">
                <h4
                    v-html="fecha_atual"
                    class="font-weihgt-bold text-center w-100"
                ></h4>
            </div>
            <div class="row">
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header bg-warning">
                            <div class="row">
                                <div class="col-md-12">
                                    <h4 class="w-100 text-center">
                                        Desembolos Préstamo Individual
                                        <i class="fa fa-user"></i>
                                    </h4>
                                </div>
                            </div>
                        </div>
                        <div class="card-body overflow-auto">
                            <div class="row">
                                <div class="col-md-12">
                                    <p class="mb-0">
                                        Total:
                                        {{ listDesembolsosIndividual.length }}
                                        registro(s)
                                    </p>
                                    <table class="table table-bordered">
                                        <thead>
                                            <tr>
                                                <th>Cliente(s)</th>
                                                <th>Monto Préstamo</th>
                                                <!-- <th>Acción</th> -->
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <template
                                                v-if="
                                                    listDesembolsosIndividual.length >
                                                    0
                                                "
                                            >
                                                <tr
                                                    v-for="item in listDesembolsosIndividual"
                                                >
                                                    <td>
                                                        {{
                                                            item.cliente
                                                                .full_name
                                                        }}
                                                    </td>
                                                    <td>
                                                        {{ item.monto }}
                                                    </td>
                                                    <!-- <td>Ver</td> -->
                                                </tr>
                                            </template>
                                            <tr v-else>
                                                <td colspan="2">
                                                    NO SE ENCONTRO NINGUN
                                                    REGISTRO
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header bg-warning">
                            <div class="row">
                                <div class="col-md-12">
                                    <h4 class="w-100 text-center">
                                        Desembolos Préstamos Grupal
                                        <i class="fa fa-users"></i>
                                    </h4>
                                </div>
                            </div>
                        </div>
                        <div class="card-body overflow-auto">
                            <div class="row">
                                <div class="col-md-12">
                                    <p class="mb-0">
                                        Total:
                                        {{ listDesembolsosGrupal.length }}
                                        registro(s)
                                    </p>
                                    <table class="table table-bordered">
                                        <thead>
                                            <tr>
                                                <th>Nombre del Grupo</th>
                                                <th>Integrantes</th>
                                                <th>Monto Préstamo</th>
                                                <!-- <th>Acción</th> -->
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <template
                                                v-if="
                                                    listDesembolsosGrupal.length >
                                                    0
                                                "
                                            >
                                                <tr
                                                    v-for="item in listDesembolsosGrupal"
                                                >
                                                    <td>
                                                        {{ item.nombre }}
                                                    </td>
                                                    <td>
                                                        <ul class="pl-3">
                                                            <li
                                                                v-for="integrante in item.prestamos"
                                                            >
                                                                {{
                                                                    integrante
                                                                        .cliente
                                                                        .full_name
                                                                }}
                                                            </li>
                                                        </ul>
                                                    </td>
                                                    <td>
                                                        {{ item.monto }}
                                                    </td>
                                                    <!-- <td>Ver</td> -->
                                                </tr>
                                            </template>
                                            <tr v-else>
                                                <td colspan="2">
                                                    NO SE ENCONTRO NINGUN
                                                    REGISTRO
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header bg-success">
                            <div class="row">
                                <div class="col-md-12">
                                    <h4 class="w-100 text-center">
                                        Pagos Préstamos Individual
                                        <i class="fa fa-user"></i>
                                    </h4>
                                </div>
                            </div>
                        </div>
                        <div class="card-body overflow-auto">
                            <div class="row">
                                <div class="col-md-12">
                                    <p class="mb-0">
                                        Total:
                                        {{ listPagosIndividual.length }}
                                        registro(s)
                                    </p>
                                    <table class="table table-bordered">
                                        <thead>
                                            <tr>
                                                <th>Cliente(s)</th>
                                                <th>Monto Préstamo</th>
                                                <th>Nro. Cuota</th>
                                                <th>Monto Cuota</th>
                                                <!-- <th>Acción</th> -->
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <template
                                                v-if="
                                                    listPagosIndividual.length >
                                                    0
                                                "
                                            >
                                                <tr
                                                    v-for="item in listPagosIndividual"
                                                >
                                                    <td>
                                                        {{
                                                            item.prestamo
                                                                .cliente
                                                                .full_name
                                                        }}
                                                    </td>
                                                    <td>
                                                        {{
                                                            item.prestamo.monto
                                                        }}
                                                    </td>
                                                    <td>
                                                        {{ item.nro_cuota }}
                                                    </td>
                                                    <td>
                                                        {{ item.cuota }}
                                                    </td>
                                                    <!-- <td>Ver</td> -->
                                                </tr>
                                            </template>
                                            <tr v-else>
                                                <td colspan="4">
                                                    NO SE ENCONTRO NINGUN
                                                    REGISTRO
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header bg-success">
                            <div class="row">
                                <div class="col-md-12">
                                    <h4 class="w-100 text-center">
                                        Pagos Préstamos Grupal
                                        <i class="fa fa-users"></i>
                                    </h4>
                                </div>
                            </div>
                        </div>
                        <div class="card-body overflow-auto">
                            <div class="row">
                                <div class="col-md-12">
                                    <p class="mb-0">
                                        Total:
                                        {{ listPagosGrupal.length }}
                                        registro(s)
                                    </p>
                                    <table class="table table-bordered">
                                        <thead>
                                            <tr>
                                                <th>Nombre del Grupo</th>
                                                <th>Integrantes</th>
                                                <th>Monto Préstamo</th>
                                                <th>Nro. Cuota</th>
                                                <th>Monto Cuota</th>
                                                <!-- <th>Acción</th> -->
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <template
                                                v-if="
                                                    listPagosGrupal.length > 0
                                                "
                                            >
                                                <tr
                                                    v-for="item in listPagosGrupal"
                                                >
                                                    <td>
                                                        {{ item.grupo.nombre }}
                                                    </td>
                                                    <td>
                                                        <ul class="pl-3">
                                                            <li
                                                                v-for="integrante in item
                                                                    .grupo
                                                                    .prestamos"
                                                            >
                                                                {{
                                                                    integrante
                                                                        .cliente
                                                                        .full_name
                                                                }}
                                                            </li>
                                                        </ul>
                                                    </td>
                                                    <td>
                                                        {{ item.grupo.monto }}
                                                    </td>
                                                    <td>
                                                        {{ item.nro_cuota }}
                                                    </td>
                                                    <td>
                                                        {{ item.cuota }}
                                                    </td>
                                                    <!-- <td>Ver</td> -->
                                                </tr>
                                            </template>
                                            <tr v-else>
                                                <td colspan="5">
                                                    NO SE ENCONTRO NINGUN
                                                    REGISTRO
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header bg-red">
                            <div class="row">
                                <div class="col-md-12">
                                    <h4 class="w-100 text-center">
                                        Moras Préstamos Individual
                                        <i class="fa fa-user"></i>
                                    </h4>
                                </div>
                            </div>
                        </div>
                        <div class="card-body overflow-auto">
                            <div class="row">
                                <div class="col-md-12">
                                    <p class="mb-0">
                                        Total:
                                        {{ listMorasIndividual.length }}
                                        registro(s)
                                    </p>
                                    <table class="table table-bordered">
                                        <thead>
                                            <tr>
                                                <th>Cliente(s)</th>
                                                <th>Monto Préstamo</th>
                                                <th>
                                                    Cantidad Cuotas Con mora
                                                </th>
                                                <th>Total Días Mora</th>
                                                <th>Total Moras Acumulado</th>
                                                <!-- <th>Acción</th> -->
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <template
                                                v-if="
                                                    listMorasIndividual.length >
                                                    0
                                                "
                                            >
                                                <tr
                                                    v-for="item in listMorasIndividual"
                                                >
                                                    <td>
                                                        {{
                                                            item.prestamo
                                                                .cliente
                                                                .full_name
                                                        }}
                                                    </td>
                                                    <td>
                                                        {{
                                                            item.prestamo.monto
                                                        }}
                                                    </td>
                                                    <td class="text-center">
                                                        {{ item.total_moras }}
                                                        /
                                                        {{
                                                            item.total_plan_pagos
                                                        }}
                                                    </td>
                                                    <td class="text-center">
                                                        {{
                                                            item.total_dias_mora
                                                        }}
                                                    </td>
                                                    <td class="text-center">
                                                        {{
                                                            item.total_monto_mora
                                                        }}
                                                    </td>
                                                    <!-- <td>Ver</td> -->
                                                </tr>
                                            </template>
                                            <tr v-else>
                                                <td colspan="7">
                                                    NO SE ENCONTRO NINGUN
                                                    REGISTRO
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header bg-red">
                            <div class="row">
                                <div class="col-md-12">
                                    <h4 class="w-100 text-center">
                                        Moras Préstamos Grupal
                                        <i class="fa fa-users"></i>
                                    </h4>
                                </div>
                            </div>
                        </div>
                        <div class="card-body overflow-auto">
                            <div class="row">
                                <div class="col-md-12">
                                    <p class="mb-0">
                                        Total:
                                        {{ listMorasGrupal.length }}
                                        registro(s)
                                    </p>
                                    <table class="table table-bordered">
                                        <thead>
                                            <tr>
                                                <th>Nombre del Grupo</th>
                                                <th>Integrantes</th>
                                                <th>Monto Préstamo</th>
                                                <th>
                                                    Cantidad Cuotas Con mora
                                                </th>
                                                <th>Total Días Mora</th>
                                                <th>Total Moras Acumulado</th>
                                                <!-- <th>Acción</th> -->
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <template
                                                v-if="
                                                    listMorasGrupal.length > 0
                                                "
                                            >
                                                <tr
                                                    v-for="item in listMorasGrupal"
                                                >
                                                    <td>
                                                        {{ item.grupo.nombre }}
                                                    </td>
                                                    <td>
                                                        <ul class="pl-3">
                                                            <li
                                                                v-for="integrante in item
                                                                    .grupo
                                                                    .prestamos"
                                                            >
                                                                {{
                                                                    integrante
                                                                        .cliente
                                                                        .full_name
                                                                }}
                                                            </li>
                                                        </ul>
                                                    </td>
                                                    <td>
                                                        {{ item.grupo.monto }}
                                                    </td>
                                                    <td class="text-center">
                                                        {{ item.total_moras }}
                                                        /
                                                        {{
                                                            item.total_plan_pagos
                                                        }}
                                                    </td>
                                                    <td class="text-center">
                                                        {{
                                                            item.total_dias_mora
                                                        }}
                                                    </td>
                                                    <td class="text-center">
                                                        {{
                                                            item.total_monto_mora
                                                        }}
                                                    </td>
                                                    <!-- <td>Ver</td> -->
                                                </tr>
                                            </template>
                                            <tr v-else>
                                                <td colspan="8">
                                                    NO SE ENCONTRO NINGUN
                                                    REGISTRO
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
export default {
    data() {
        return {
            user: JSON.parse(localStorage.getItem("user")),
            permisos:
                typeof localStorage.getItem("permisos") == "string"
                    ? JSON.parse(localStorage.getItem("permisos"))
                    : JSON.parse(localStorage.getItem("permisos")),
            fullscreenLoading: true,
            loadingWindow: Loading.service({
                fullscreen: this.fullscreenLoading,
            }),
            listDesembolsosIndividual: [],
            listDesembolsosGrupal: [],
            listPagosIndividual: [],
            listPagosGrupal: [],
            listMorasIndividual: [],
            listMorasGrupal: [],
            txt_fecha1: "",
            loading: false,
            fecha_atual: this.getFechaActual(),
        };
    },
    mounted() {
        this.loadingWindow.close();
        this.getInfoPrestamos();
    },
    methods: {
        getInfoPrestamos() {
            axios
                .get(main_url + "/admin/control_prestamos/getInfo")
                .then((response) => {
                    this.fecha_atual = response.data.fecha_txt;
                    this.listDesembolsosIndividual =
                        response.data.listDesembolsosIndividual;
                    this.listDesembolsosGrupal =
                        response.data.listDesembolsosGrupal;
                    this.listPagosIndividual =
                        response.data.listPagosIndividual;
                    this.listPagosGrupal = response.data.listPagosGrupal;
                    this.listMorasIndividual =
                        response.data.listMorasIndividual;
                    this.listMorasGrupal = response.data.listMorasGrupal;
                });
        },
    },
};
</script>

<style>
.tabla_prestamos tbody tr td {
    vertical-align: middle;
}

.contenedor_control_prestamos table tbody tr td {
    font-size: 0.85em;
}
</style>
