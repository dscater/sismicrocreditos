<template>
    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Caja</h1>
                    </div>
                </div>
            </div>
        </section>
        <section class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-4 offset-md-4">
                        <div class="card">
                            <div
                                class="card-body"
                                :class="{
                                    'bg-success':
                                        parseFloat(total_saldo_caja) > 0,
                                    'bg-danger':
                                        parseFloat(total_saldo_caja) <= 0,
                                }"
                            >
                                <p
                                    class="text-lg font-weight-bold mb-0 w-100 text-center"
                                >
                                    SALDO: {{ total_saldo_caja }}
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-3">
                        <button
                            v-if="permisos.includes('cajas.create')"
                            class="btn btn-primary btn-flat btn-block"
                            @click="
                                abreModal('nuevo');
                                limpiaCaja();
                            "
                        >
                            <i class="fa fa-plus"></i>
                            Nuevo
                        </button>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="row mb-2">
                                            <div class="col-md-4 offset-md-2">
                                                <label>Fecha inicio:</label>
                                                <input
                                                    type="date"
                                                    class="form-control"
                                                    v-model="fecha_ini"
                                                    @change="empezarBusqueda"
                                                    @keyup="empezarBusqueda"
                                                />
                                            </div>
                                            <div class="col-md-4">
                                                <label>Fecha fin:</label>
                                                <input
                                                    type="date"
                                                    class="form-control"
                                                    v-model="fecha_fin"
                                                    @change="empezarBusqueda"
                                                    @keyup="empezarBusqueda"
                                                />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-12">
                                        <table class="table table-bordered">
                                            <thead class="bg-primary">
                                                <tr>
                                                    <th width="15%">
                                                        Fecha de Registro
                                                    </th>
                                                    <th>Usuario</th>
                                                    <th>Monto</th>
                                                    <th>Tipo Movimiento</th>
                                                    <th>Glosa</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <template
                                                    v-if="
                                                        listRegistros.length >
                                                            0 && !buscando
                                                    "
                                                >
                                                    <tr
                                                        v-for="item in listRegistros"
                                                    >
                                                        <td>
                                                            {{
                                                                item.fecha_registro_t
                                                            }}
                                                        </td>
                                                        <td>
                                                            {{
                                                                item.user
                                                                    .usuario
                                                            }}
                                                        </td>
                                                        <td>
                                                            {{ item.monto }}
                                                        </td>
                                                        <td>
                                                            <span
                                                                class="badge"
                                                                :class="[
                                                                    item.tipo ==
                                                                    'CRÉDITO'
                                                                        ? 'badge-success'
                                                                        : 'badge-danger',
                                                                ]"
                                                            >
                                                                {{ item.tipo }}
                                                            </span>
                                                        </td>
                                                        <td>
                                                            {{ item.glosa }}
                                                        </td>
                                                    </tr>
                                                </template>
                                                <template v-else>
                                                    <tr v-if="!buscando">
                                                        <td
                                                            colspan="5"
                                                            class="text-center"
                                                        >
                                                            NO SE ENCONTRARÓN
                                                            REGISTROS
                                                        </td>
                                                    </tr>
                                                    <tr v-else>
                                                        <td
                                                            colspan="5"
                                                            class="text-center"
                                                        >
                                                            BUSCANDO...
                                                        </td>
                                                    </tr>
                                                </template>
                                            </tbody>
                                        </table>
                                    </div>
                                    <b-col
                                        sm="12"
                                        md="12"
                                        class="my-1"
                                        v-if="perPage"
                                    >
                                        <b-pagination
                                            class="justify-content-center"
                                            v-model="currentPage"
                                            :total-rows="totalRows"
                                            :per-page="perPage"
                                        ></b-pagination>
                                    </b-col>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <Nuevo
            :muestra_modal="muestra_modal"
            :accion="modal_accion"
            :caja_movimiento="oCajaMovimiento"
            @close="muestra_modal = false"
            @envioModal="getCajas"
        ></Nuevo>
    </div>
</template>

<script>
import Nuevo from "./Nuevo.vue";
export default {
    components: {
        Nuevo,
    },
    data() {
        return {
            user: JSON.parse(localStorage.getItem("user")),
            permisos:
                typeof localStorage.getItem("permisos") == "string"
                    ? JSON.parse(localStorage.getItem("permisos"))
                    : JSON.parse(localStorage.getItem("permisos")),
            search: "",
            listRegistros: [],
            fullscreenLoading: true,
            loadingWindow: Loading.service({
                fullscreen: this.fullscreenLoading,
            }),
            muestra_modal: false,
            modal_accion: "nuevo",
            oCajaMovimiento: {
                id: 0,
                caja_id: "",
                user_id: "",
                monto: "",
                tipo: "",
                glosa: "",
                tipo_prestamo: "",
                prestamo_id: "",
                grupo_id: "",
            },
            buscando: false,
            total_saldo_caja: 0,
            fecha_ini: this.getFechaActual(),
            fecha_fin: this.getFechaActual(),
            currentPage: 1,
            perPage: 5,
            totalRows: 0,
            filter: null,
            setTimeOutBuscarMovimientos: null,
        };
    },
    watch: {
        currentPage(newVal) {
            this.getCajas(newVal);
        },
    },
    mounted() {
        this.loadingWindow.close();
        this.getCajas();
    },
    methods: {
        empezarBusqueda() {
            this.buscando = true;
            this.setTimeOutBuscarMovimientos = setTimeout(() => {
                this.getCajas();
            }, 500);
        },
        // Seleccionar Opciones de Tabla
        editarRegistro(item) {
            this.oCajaMovimiento.id = item.id;
            this.oCajaMovimiento.caja_id = item.caja_id ? item.caja_id : "";
            this.oCajaMovimiento.user_id = item.user_id ? item.user_id : "";
            this.oCajaMovimiento.monto = item.monto ? item.monto : "";
            this.oCajaMovimiento.tipo = item.tipo ? item.tipo : "";
            this.oCajaMovimiento.glosa = item.glosa ? item.glosa : "";
            this.oCajaMovimiento.tipo_prestamo = item.tipo_prestamo
                ? item.tipo_prestamo
                : "";
            this.oCajaMovimiento.prestamo_id = item.prestamo_id
                ? item.prestamo_id
                : "";
            this.oCajaMovimiento.grupo_id = item.grupo_id ? item.grupo_id : "";
            this.modal_accion = "edit";
            this.muestra_modal = true;
        },

        // Listar Cajas
        getCajas(pagina = 1) {
            this.buscando = true;
            this.muestra_modal = false;
            let url = main_url + "/admin/cajas";
            axios
                .get(url, {
                    params: {
                        page: pagina,
                        fecha_ini: this.fecha_ini,
                        fecha_fin: this.fecha_fin,
                    },
                })
                .then((res) => {
                    this.buscando = false;
                    this.listRegistros = res.data.caja_movimientos.data;
                    this.totalRows = res.data.caja_movimientos.total;
                    this.perPage = res.data.per_page;
                    this.total_saldo_caja = res.data.total_saldo_caja;
                });
        },
        eliminaCaja(id, descripcion) {
            Swal.fire({
                title: "¿Quierés eliminar este registro?",
                html: `<strong>${descripcion}</strong>`,
                showCancelButton: true,
                confirmButtonColor: "#c82333",
                confirmButtonText: "Si, eliminar",
                cancelButtonText: "No, cancelar",
                denyButtonText: `No, cancelar`,
            }).then((result) => {
                /* Read more about isConfirmed, isDenied below */
                if (result.isConfirmed) {
                    axios
                        .post(main_url + "/admin/cajas/" + id, {
                            _method: "DELETE",
                        })
                        .then((res) => {
                            this.getCajas();
                            this.filter = "";
                            Swal.fire({
                                icon: "success",
                                title: res.data.msj,
                                showConfirmButton: false,
                                timer: 1500,
                            });
                        })
                        .catch((error) => {
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
                }
            });
        },
        abreModal(tipo_accion = "nuevo", caja_movimiento = null) {
            this.muestra_modal = true;
            this.modal_accion = tipo_accion;
            if (caja_movimiento) {
                this.oCajaMovimiento = caja_movimiento;
            }
        },
        limpiaCaja() {
            this.oCajaMovimiento.caja_id = "";
            this.oCajaMovimiento.user_id = "";
            this.oCajaMovimiento.monto = "";
            this.oCajaMovimiento.tipo = "";
            this.oCajaMovimiento.glosa = "";
            this.oCajaMovimiento.tipo_prestamo = "";
            this.oCajaMovimiento.prestamo_id = "";
            this.oCajaMovimiento.grupo_id = "";
        },
        formatoFecha(date) {
            return this.$moment(String(date)).format("DD/MM/YYYY");
        },
    },
};
</script>

<style></style>
