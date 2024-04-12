<template>
    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Pagos Individual</h1>
                    </div>
                </div>
            </div>
        </section>
        <section class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-12">
                                        <h4 class="w-100 text-center">
                                            Buscar préstamo individual
                                        </h4>
                                    </div>
                                    <div class="col-md-8 offset-md-2">
                                        <div class="input-group">
                                            <input
                                                type="text"
                                                class="form-control"
                                                placeholder="Ingresar C.I."
                                                v-model="txt_ci"
                                                @keyup="empezarBusqueda"
                                            />
                                            <div class="input-group-append">
                                                <button
                                                    class="btn btn-success"
                                                    type="button"
                                                    @click="empezarBusqueda"
                                                >
                                                    <i class="fa fa-search"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row mt-3" v-if="txt_ci != ''">
                                    <div
                                        class="col-md-12"
                                        v-if="
                                            listPrestamos.length > 0 && !loading
                                        "
                                    >
                                        <table
                                            class="table table-bordered tabla_prestamos"
                                        >
                                            <thead class="bg-success">
                                                <tr>
                                                    <th>Nombre Cliente</th>
                                                    <th>Monto</th>
                                                    <th>Plazo</th>
                                                    <th>
                                                        Nro. Pagos Realizados
                                                    </th>
                                                    <th>Estado Préstamo</th>
                                                    <th width="20%">Acción</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr
                                                    v-for="item in listPrestamos"
                                                >
                                                    <td
                                                        data-col="Nombre Cliente:"
                                                    >
                                                        {{
                                                            item.cliente
                                                                .full_name
                                                        }}
                                                    </td>
                                                    <td data-col="Monto:">
                                                        {{ item.monto }}
                                                    </td>
                                                    <td data-col="Plazo:">
                                                        {{ item.plazo }}
                                                    </td>
                                                    <td
                                                        data-col="Nro. Pagos Realizados:"
                                                    >
                                                        <span
                                                            class="text-md badge badge-info"
                                                            >{{
                                                                item.nro_pagos_realizados
                                                            }}</span
                                                        >
                                                    </td>
                                                    <td
                                                        data-col="Estado Préstamo:"
                                                    >
                                                        <span
                                                            class="text-md badge"
                                                            :class="[
                                                                item.finalizado ==
                                                                0
                                                                    ? 'badge-warning'
                                                                    : 'badge-success',
                                                            ]"
                                                            >{{
                                                                item.finalizado ==
                                                                0
                                                                    ? "PENDIENTE"
                                                                    : "CANCELADO"
                                                            }}</span
                                                        >
                                                    </td>
                                                    <td data-col="Acción:">
                                                        <button
                                                            class="inline-block btn btn-xs btn-primary mb-1"
                                                            v-if="
                                                                item.nro_pagos_realizados <
                                                                    item.plazo &&
                                                                permisos.includes(
                                                                    'pagos.individual_store'
                                                                ) &&
                                                                item.desembolso ==
                                                                    1
                                                            "
                                                            @click="
                                                                nuevoPago(item)
                                                            "
                                                        >
                                                            <i
                                                                class="fa fa-plus"
                                                            ></i>
                                                            Registrar Cuota
                                                        </button>
                                                        <button
                                                            class="inline-block btn btn-xs bg-orange text-white mb-1"
                                                            v-if="
                                                                item.nro_pagos_realizados <
                                                                    item.plazo &&
                                                                permisos.includes(
                                                                    'pagos.individual_store'
                                                                ) &&
                                                                item.desembolso ==
                                                                    1
                                                            "
                                                            @click="
                                                                nuevoPagoTotal(
                                                                    item
                                                                )
                                                            "
                                                        >
                                                            <i
                                                                class="fa fa-money-check-alt"
                                                            ></i>
                                                            Liquidar deuda
                                                        </button>
                                                        <router-link
                                                            class="inline-block btn btn-xs btn-success mb-1"
                                                            v-if="
                                                                item.pagos
                                                                    .length > 0
                                                            "
                                                            :to="{
                                                                name: 'pagos.ver_pagos_individual',
                                                                params: {
                                                                    id: item.id,
                                                                },
                                                            }"
                                                        >
                                                            <i
                                                                class="fa fa-list-alt"
                                                            ></i>
                                                            Pagos realizados
                                                        </router-link>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="col-md-12" v-else>
                                        <h5
                                            class="w-100 text-center text-gray"
                                            v-show="!loading"
                                        >
                                            No se encontrarón registros...
                                        </h5>
                                    </div>
                                    <div class="col-md-12" v-if="loading">
                                        <h5 class="w-100 text-center text-gray">
                                            Buscando...
                                        </h5>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <PagoIndividual
            :muestra_modal="muestra_modal"
            :prestamo="oPrestamo"
            @close="muestra_modal = false"
            @envioModal="empezarBusqueda"
        ></PagoIndividual>
        <PagoIndividualTotal
            :muestra_modal="muestra_modal_total"
            :prestamo="oPrestamo"
            @close="muestra_modal_total = false"
            @envioModal="empezarBusqueda"
        ></PagoIndividualTotal>
    </div>
</template>

<script>
import PagoIndividual from "./PagoIndividual.vue";
import PagoIndividualTotal from "./PagoIndividualTotal.vue";
export default {
    components: {
        PagoIndividual,
        PagoIndividualTotal,
    },
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
            listPrestamos: [],
            txt_ci: "",
            loading: false,
            setTimeOutBusqueda: null,
            muestra_modal: false,
            muestra_modal_total: false,
            oPrestamo: {
                user_id: "",
                cliente_id: "",
                tipo: "",
                grupo_id: "",
                monto: "",
                plazo: "",
                f_ci: "",
                f_luz: "",
                f_agua: "",
                croquis: "",
                documento_1: "",
                documento_2: "",
                documento_3: "",
                documento_4: "",
                estado: "",
                desembolso: "",
                fecha_desembolso: "",
                fecha_registro: "",
                finalizado: "",
                cliente: {
                    nombre: "",
                    segundo_nombre: "",
                    paterno: "",
                    materno: "",
                    dir: "",
                    ci: "",
                    ci_exp: "",
                    cel: "",
                    fono: "",
                    edad: "",
                    referencia: "",
                    cel_ref: "",
                    parentesco: "",
                    fecha_registro: "",
                    full_name: "",
                },
                pagos: [],
            },
        };
    },
    mounted() {
        this.loadingWindow.close();
    },
    methods: {
        nuevoPago(item) {
            this.oPrestamo = item;
            this.muestra_modal = true;
        },
        nuevoPagoTotal(item) {
            this.oPrestamo = item;
            this.muestra_modal_total = true;
        },
        empezarBusqueda() {
            this.muestra_modal = false;
            this.muestra_modal_total = false;
            this.loading = true;
            clearInterval(this.setTimeOutBusqueda);
            this.setTimeOutBusqueda = setTimeout(() => {
                this.buscaPrestamosCliente();
            }, 700);
        },
        buscaPrestamosCliente() {
            axios
                .get(main_url + "/admin/prestamos/individual/cliente_ci", {
                    params: {
                        ci: this.txt_ci,
                        filtro: "todos",
                    },
                })
                .then((response) => {
                    this.loading = false;
                    this.listPrestamos = response.data.prestamos;
                })
                .catch((error) => {
                    this.loading = false;
                    if (error.response) {
                        if (error.response.status === 422) {
                            this.errors = error.response.data.errors;
                        }
                        if (
                            error.response.status === 420 ||
                            error.response.status === 419 ||
                            error.response.status === 401
                        ) {
                            window.location = "/";
                        }
                        if (error.response.status === 500) {
                            Swal.fire({
                                icon: "error",
                                title: "Error",
                                html: error.response.data.message,
                                showConfirmButton: false,
                                timer: 2000,
                            });
                        }
                    }
                });
        },
    },
};
</script>

<style>
.tabla_prestamos tbody tr td {
    vertical-align: middle;
}
</style>
