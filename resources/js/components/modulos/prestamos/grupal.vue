<template>
    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Préstamos Grupal</h1>
                    </div>
                </div>
            </div>
        </section>
        <section class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-3">
                        <router-link
                            v-if="permisos.includes('prestamos.grupal_nuevo')"
                            :to="{ name: 'prestamos.grupal_nuevo' }"
                            class="btn btn-success btn-flat btn-block"
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
                                                    <th>Estado</th>
                                                    <th>Fecha Registro</th>
                                                    <th width="20%">Acción</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr
                                                    v-for="item in listPrestamos"
                                                >
                                                    <td data-col="Nombre Grupo:">
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
                                                        data-col=""
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
                                                    <td
                                                        data-col="Fecha Registro:"
                                                    >
                                                        {{
                                                            item.fecha_registro_t
                                                        }}
                                                    </td>
                                                    <td data-col="Acción:">
                                                        <button
                                                            v-if="
                                                                item.estado ==
                                                                    'APROBADO' &&
                                                                permisos.includes(
                                                                    'prestamos.grupal_contrato'
                                                                )
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
                                                                    'FINALIZADO' &&
                                                                permisos.includes(
                                                                    'prestamos.grupal_aprobar'
                                                                )
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
                                                                    0 &&
                                                                permisos.includes(
                                                                    'prestamos.grupal_rechazar'
                                                                )
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
        <AprobacionGrupal
            :muestra_modal="muestra_modal"
            :grupo="oGrupo"
            @close="muestra_modal = false"
            @envioModal="nuevoAprobado"
        ></AprobacionGrupal>
    </div>
</template>

<script>
import AprobacionGrupal from "./AprobacionGrupal.vue";
export default {
    components: {
        AprobacionGrupal,
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
            listPrestamos: [],
        };
    },
    mounted() {
        this.loadingWindow.close();
    },
    methods: {
        nuevoAprobado(grupo) {
            this.descargarContrato(grupo);
            this.empezarBusqueda();
        },
        descargarContrato(item) {
            let config = {
                responseType: "blob",
            };
            axios
                .post(
                    main_url + "/admin/prestamos/contrato_grupal/" + item.id,
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
                                confirmButtonColor: "#339431",
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
                    main_url + "/admin/prestamos/simulacion/plan_pago_grupal",
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
                                confirmButtonColor: "#339431",
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
            this.oGrupo = item;
            this.muestra_modal = true;
        },
        rechazarPrestamo(item) {
            let id = item.id;
            let descripcion = `<div clas="text-left">`;
            descripcion += `<p><strong>Monto: </strong> ${item.monto}</p>`;
            descripcion += `<p><strong>Integrantes: </strong></p>
                            <ul class="text-left">`;
            item.prestamos.forEach((item) => {
                descripcion += `<li v-for="item in grupo?.prestamos">
                                    ${item.cliente.full_name} -  ${item.cliente.full_ci}
                                </li>`;
            });
            descripcion += `</ul>`;
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
                            main_url + "/admin/prestamos/grupal/rechazar/" + id,
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
                this.buscarGrupoNombre();
            }, 700);
        },
        buscarGrupoNombre() {
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
