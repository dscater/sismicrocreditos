<template>
    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Desembolso Individual</h1>
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
                                                    class="btn btn-primary"
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
                                            <thead class="bg-primary">
                                                <tr>
                                                    <th>Nombre Cliente</th>
                                                    <th>Monto</th>
                                                    <th>Plazo</th>
                                                    <th>Fecha de Desembolso</th>
                                                    <th>Estado Desembolso</th>
                                                    <th width="20%">Acción</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr
                                                    v-for="item in listPrestamos"
                                                >
                                                    <td>
                                                        {{
                                                            item.cliente
                                                                .full_name
                                                        }}
                                                    </td>
                                                    <td>{{ item.monto }}</td>
                                                    <td>{{ item.plazo }}</td>
                                                    <td>
                                                        {{
                                                            item.fecha_desembolso_t
                                                                ? item.fecha_desembolso_t
                                                                : "S/A"
                                                        }}
                                                    </td>
                                                    <td
                                                        class="text-center font-weight-bold"
                                                        :class="{
                                                            'bg-warning':
                                                                item.desembolso ==
                                                                0,
                                                            'bg-success':
                                                                item.desembolso ==
                                                                1,
                                                        }"
                                                    >
                                                        {{
                                                            item.desembolso == 1
                                                                ? "ENTREGADO"
                                                                : "PENDIENTE"
                                                        }}
                                                    </td>
                                                    <td>
                                                        <button
                                                            class="inline-block btn btn-xs btn-primary"
                                                            v-if="
                                                                item.desembolso ==
                                                                1
                                                            "
                                                        >
                                                            <i
                                                                class="fa fa-file-pdf"
                                                            ></i>
                                                            Plan de Pago
                                                        </button>
                                                        <button
                                                            class="inline-block btn btn-xs btn-success"
                                                            v-if="
                                                                item.sw_desembolso &&
                                                                item.desembolso ==
                                                                    0
                                                            "
                                                            @click="
                                                                realizarDesembolso(
                                                                    item
                                                                )
                                                            "
                                                        >
                                                            <i
                                                                class="fa fa-hand-holding-usd"
                                                            ></i>
                                                            Realizar Desembolso
                                                        </button>
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
        <DesembolsoIndividual
            :muestra_modal="muestra_modal"
            :prestamo="oPrestamo"
            @close="muestra_modal = false"
            @envioModal="empezarBusqueda"
        ></DesembolsoIndividual>
    </div>
</template>

<script>
import DesembolsoIndividual from "./DesembolsoIndividual.vue";
export default {
    components: {
        DesembolsoIndividual,
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
            },
        };
    },
    mounted() {
        this.loadingWindow.close();
    },
    methods: {
        realizarDesembolso(item) {
            this.oPrestamo = item;
            this.muestra_modal = true;
        },
        empezarBusqueda() {
            this.muestra_modal = false;
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
