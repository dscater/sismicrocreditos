<template>
    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Préstamos Individual</h1>
                    </div>
                </div>
            </div>
        </section>
        <section class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-3">
                        <router-link
                            v-if="
                                permisos.includes('prestamos.individual_nuevo')
                            "
                            :to="{ name: 'prestamos.individual_nuevo' }"
                            class="btn btn-primary btn-flat btn-block"
                        >
                            <i class="fa fa-plus"></i>
                            Nuevo
                        </router-link>
                    </div>
                </div>
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
                                                            v-if="
                                                                item.estado ==
                                                                'APROBADO'
                                                            "
                                                            class="inline-block btn btn-xs btn-success"
                                                            @click="
                                                                descargarContrato(
                                                                    item
                                                                )
                                                            "
                                                        >
                                                            <i
                                                                class="fa fa-file-pdf"
                                                            ></i>
                                                            Contrato
                                                        </button>
                                                        <button
                                                            class="inline-block btn btn-xs btn-primary"
                                                            @click="
                                                                descargarPlanPagos(
                                                                    item
                                                                )
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
        <AprobacionIndividual
            :muestra_modal="muestra_modal"
            :prestamo="oPrestamo"
            @close="muestra_modal = false"
            @envioModal="nuevoAprobado"
        ></AprobacionIndividual>
    </div>
</template>

<script>
import AprobacionIndividual from "./AprobacionIndividual.vue";
export default {
    components: {
        AprobacionIndividual,
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
        nuevoAprobado(prestamo) {
            this.descargarContrato(prestamo);
            this.empezarBusqueda();
        },
        descargarContrato(item) {
            let config = {
                responseType: "blob",
            };
            axios
                .post(
                    main_url +
                        "/admin/prestamos/contrato_individual/" +
                        item.id,
                    null,
                    config
                )
                .then((res) => {
                    this.errors = [];
                    this.enviando = false;
                    let pdfBlob = new Blob([res.data], {
                        type: "application/pdf",
                    });
                    let urlReporte = URL.createObjectURL(pdfBlob);
                    window.open(urlReporte);
                })
                .catch(async (error) => {
                    let responseObj = await error.response.data.text();
                    responseObj = JSON.parse(responseObj);
                    console.log(error);
                    this.enviando = false;
                    if (error.response) {
                        if (error.response.status === 422) {
                            this.errors = responseObj.errors;
                            let mensaje = `<ul class="text-left">`;
                            for (let key in this.errors) {
                                if (this.errors.hasOwnProperty(key)) {
                                    const value = this.errors[key];
                                    if (Array.isArray(value)) {
                                        value.forEach((error) => {
                                            mensaje += `<li><span>${error.trim()}</span></li>`;
                                        });
                                    }
                                }
                            }
                            mensaje += `<ul/>`;
                            Swal.fire({
                                icon: "error",
                                title: "Tienes los siguientes errores en el formulario",
                                html: mensaje,
                                showConfirmButton: true,
                                confirmButtonColor: "#1976d2",
                                confirmButtonText: "Aceptar",
                            });
                            1;
                        }
                        if (
                            error.response.status === 420 ||
                            error.response.status === 419 ||
                            error.response.status === 401 ||
                            error.response.status === 400
                        ) {
                            Swal.fire({
                                icon: "error",
                                title: "Error",
                                html: responseObj.message,
                                showConfirmButton: false,
                                timer: 2000,
                            });
                            if (error.response.status != 400) {
                                window.location = "/";
                            }
                        }
                    }
                });
        },
        descargarPlanPagos(item) {
            let config = {
                responseType: "blob",
            };
            axios
                .post(
                    main_url +
                        "/admin/prestamos/simulacion/plan_pago_individual",
                    item,
                    config
                )
                .then((res) => {
                    this.errors = [];
                    this.enviando = false;
                    let pdfBlob = new Blob([res.data], {
                        type: "application/pdf",
                    });
                    let urlReporte = URL.createObjectURL(pdfBlob);
                    window.open(urlReporte);
                })
                .catch(async (error) => {
                    let responseObj = await error.response.data.text();
                    responseObj = JSON.parse(responseObj);
                    console.log(error);
                    this.enviando = false;
                    if (error.response) {
                        if (error.response.status === 422) {
                            this.errors = responseObj.errors;
                            let mensaje = `<ul class="text-left">`;
                            for (let key in this.errors) {
                                if (this.errors.hasOwnProperty(key)) {
                                    const value = this.errors[key];
                                    if (Array.isArray(value)) {
                                        value.forEach((error) => {
                                            mensaje += `<li><span>${error.trim()}</span></li>`;
                                        });
                                    }
                                }
                            }
                            mensaje += `<ul/>`;
                            Swal.fire({
                                icon: "error",
                                title: "Tienes los siguientes errores en el formulario",
                                html: mensaje,
                                showConfirmButton: true,
                                confirmButtonColor: "#1976d2",
                                confirmButtonText: "Aceptar",
                            });
                            1;
                        }
                        if (
                            error.response.status === 420 ||
                            error.response.status === 419 ||
                            error.response.status === 401 ||
                            error.response.status === 400
                        ) {
                            Swal.fire({
                                icon: "error",
                                title: "Error",
                                html: responseObj.message,
                                showConfirmButton: false,
                                timer: 2000,
                            });
                            if (error.response.status != 400) {
                                window.location = "/";
                            }
                        }
                    }
                });
        },
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
