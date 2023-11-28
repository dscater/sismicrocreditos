<template>
    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Desembolso Grupal</h1>
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
                                            <thead class="bg-primary">
                                                <tr>
                                                    <th>Nombre Grupo</th>
                                                    <th>Nro. Integrantes</th>
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
                                                        {{ item.nombre }}
                                                    </td>
                                                    <td>
                                                        {{ item.integrantes }}
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
        <DesembolsoGrupal
            :muestra_modal="muestra_modal"
            :grupo="oGrupo"
            @close="muestra_modal = false"
            @envioModal="empezarBusqueda"
        ></DesembolsoGrupal>
    </div>
</template>

<script>
import DesembolsoGrupal from "./DesembolsoGrupal.vue";
export default {
    components: {
        DesembolsoGrupal,
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
        realizarDesembolso(item) {
            this.oGrupo = item;
            this.muestra_modal = true;
        },
        empezarBusqueda() {
            this.muestra_modal = false;
            this.loading = true;
            clearInterval(this.setTimeOutBusqueda);
            this.setTimeOutBusqueda = setTimeout(() => {
                this.buscaPrestamosGrupo();
            }, 700);
        },
        buscaPrestamosGrupo() {
            axios
                .get(main_url + "/admin/prestamos/grupal/grupo_nombre", {
                    params: {
                        ci: this.txt_nombre,
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
