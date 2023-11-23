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
                                                    <th>Estado</th>
                                                    <th>Fecha Registro</th>
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
                                                    <td
                                                        class="text-center font-weight-bold"
                                                        :class="{
                                                            'bg-warning':
                                                                item.estado ==
                                                                'PRE APROBADO',
                                                            'bg-danger':
                                                                item.estado ==
                                                                'RECHAZADO',
                                                            'bg-success':
                                                                item.estado ==
                                                                'APROBADO',
                                                            'bg-gray':
                                                                item.estado ==
                                                                'FINALIZADO',
                                                        }"
                                                    >
                                                        {{ item.estado }}
                                                    </td>
                                                    <td>
                                                        {{
                                                            item.fecha_registro_t
                                                        }}
                                                    </td>
                                                    <td>
                                                        <button
                                                            class="inline-block btn btn-xs btn-success"
                                                            v-if="
                                                                item.desembolso ==
                                                                    0 &&
                                                                item.estado !=
                                                                    'APROBADO' &&
                                                                item.estado !=
                                                                    'FINALIZADO'
                                                            "
                                                            @click="
                                                                aprobarPrestamo(
                                                                    item
                                                                )
                                                            "
                                                        >
                                                            <i
                                                                class="fa fa-thumbs-up"
                                                            ></i>
                                                            Aprobar
                                                        </button>
                                                        <button
                                                            class="inline-block btn btn-xs btn-danger"
                                                            v-if="
                                                                item.desembolso ==
                                                                0
                                                            "
                                                            @click="
                                                                rechazarPrestamo(
                                                                    item
                                                                )
                                                            "
                                                        >
                                                            <i
                                                                class="fa fa-thumbs-down"
                                                            ></i>
                                                            Rechazar
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
        aprobarPrestamo(item) {
            this.oPrestamo = item;
            this.muestra_modal = true;
        },
        rechazarPrestamo(item) {
            let id = item.id;
            let descripcion = `<div clas="text-center">`;
            descripcion += `<p><strong>Cliente: </strong> ${item.cliente.full_name}</p>`;
            descripcion += `<p><strong>Monto: </strong> ${item.monto}</p>`;
            descripcion += `<p><strong>Plazo: </strong> ${item.plazo}</p>`;
            descripcion += `</div>`;
            Swal.fire({
                title: "¿Quierés rechazar este préstamo?",
                html: descripcion,
                showCancelButton: true,
                confirmButtonColor: "#c82333",
                confirmButtonText: "Si, rechazar",
                cancelButtonText: "No, cancelar",
                denyButtonText: `No, cancelar`,
            }).then((result) => {
                /* Read more about isConfirmed, isDenied below */
                if (result.isConfirmed) {
                    axios
                        .post(
                            main_url +
                                "/admin/prestamos/individual/rechazar/" +
                                id,
                            {
                                _method: "PUT",
                            }
                        )
                        .then((res) => {
                            this.empezarBusqueda();
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
