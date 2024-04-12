<template>
    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Pagos Grupal</h1>
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
                                            Buscar préstamo Grupal
                                        </h4>
                                    </div>
                                    <div class="col-md-8 offset-md-2">
                                        <div class="input-group">
                                            <input
                                                type="text"
                                                class="form-control"
                                                placeholder="Nombre Grupo"
                                                v-model="txt_nombre"
                                                @keyup="empezarBusqueda"
                                            />
                                            <div class="input-group-append">
                                                <button
                                                    class="btn btn-sucess"
                                                    type="button"
                                                    @click="empezarBusqueda"
                                                >
                                                    <i class="fa fa-search"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row mt-3" v-if="txt_nombre != ''">
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
                                                    <th>Nombre Grupo</th>
                                                    <th>Nro. Integrantes</th>
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
                                                        data-col="Nombre Grupo:"
                                                    >
                                                        {{ item.nombre }}
                                                    </td>
                                                    <td
                                                        data-col="Nro. Integrantes:"
                                                    >
                                                        {{ item.integrantes }}
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
                                                                    'pagos.grupal_store'
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
                                                            Registrar Pago
                                                        </button>
                                                        <button
                                                            class="inline-block btn btn-xs bg-orange text-white mb-1"
                                                            v-if="
                                                                item.nro_pagos_realizados <
                                                                    item.plazo &&
                                                                permisos.includes(
                                                                    'pagos.grupal_store'
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
                                                                item.grupo_pagos
                                                                    .length > 0
                                                            "
                                                            :to="{
                                                                name: 'pagos.ver_pagos_grupal',
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
        <PagoGrupal
            :muestra_modal="muestra_modal"
            :grupo="oGrupo"
            @close="muestra_modal = false"
            @envioModal="empezarBusqueda"
        ></PagoGrupal>
        <PagoGrupalTotal
            :muestra_modal="muestra_modal_total"
            :grupo="oGrupo"
            @close="muestra_modal_total = false"
            @envioModal="empezarBusqueda"
        ></PagoGrupalTotal>
    </div>
</template>

<script>
import PagoGrupal from "./PagoGrupal.vue";
import PagoGrupalTotal from "./PagoGrupalTotal.vue";
export default {
    components: {
        PagoGrupal,
        PagoGrupalTotal,
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
            txt_nombre: "",
            loading: false,
            setTimeOutBusqueda: null,
            muestra_modal: false,
            muestra_modal_total: false,
            oGrupo: {
                nombre: "",
                integrantes: 3,
                monto: 0,
                plazo: 12,
                prestamos: [],
            },
        };
    },
    mounted() {
        this.loadingWindow.close();
    },
    methods: {
        nuevoPago(item) {
            this.oGrupo = item;
            this.muestra_modal = true;
        },
        nuevoPagoTotal(item) {
            this.oGrupo = item;
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
                .get(main_url + "/admin/prestamos/grupal/grupo_nombre", {
                    params: {
                        nombre: this.txt_nombre,
                    },
                })
                .then((response) => {
                    this.loading = false;
                    this.listPrestamos = response.data.grupos;
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
