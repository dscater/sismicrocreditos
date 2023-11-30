<template>
    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Pagos Individual > Ver Pagos</h1>
                    </div>
                </div>
            </div>
        </section>
        <section class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-3">
                        <router-link
                            class="btn btn-default btn-flat btn-block"
                            :to="{
                                name: 'pagos.individual',
                            }"
                        >
                            <i class="fa fa-arrow-left"></i> Volver
                        </router-link>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-12">
                                        <p>
                                            <strong>Cliente: </strong>
                                            {{ oPrestamo.cliente.full_name }}
                                        </p>
                                        <p>
                                            <strong>C.I.: </strong>
                                            {{ oPrestamo.cliente.full_ci }}
                                        </p>
                                        <p>
                                            <strong>Monto: </strong
                                            >{{ oPrestamo.monto }}
                                        </p>
                                        <p class="mb-0">
                                            <strong>Plazo: </strong>
                                            {{ oPrestamo.plazo }}
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12" v-if="oPrestamo?.pagos?.length > 0">
                        <h4 class="w-100 text-center">
                            LISTA DE PAGOS REALIZADOS
                        </h4>
                    </div>
                    <div
                        class="col-md-12"
                        v-if="oPrestamo?.pagos?.length > 0"
                        v-for="item in oPrestamo.pagos"
                    >
                        <div class="card">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-4">
                                        <p>
                                            <strong>Nro. Cuota: </strong>
                                            {{ item.nro_cuota }}
                                        </p>
                                    </div>
                                    <div class="col-md-4">
                                        <p>
                                            <strong>Fecha: </strong>
                                            {{ item.fecha_pago }}
                                        </p>
                                    </div>
                                    <div class="col-md-4">
                                        <p>
                                            <strong>Capital: </strong>
                                            {{ item.monto }}
                                        </p>
                                    </div>
                                    <div class="col-md-4">
                                        <p>
                                            <strong>Interés: </strong>
                                            {{ item.interes }}
                                        </p>
                                    </div>
                                    <div class="col-md-4">
                                        <p>
                                            <strong>Días mora: </strong>
                                            {{ item.dias_mora }}
                                        </p>
                                    </div>
                                    <div class="col-md-4">
                                        <p>
                                            <strong>Monto mora: </strong>
                                            {{ item.monto_mora }}
                                        </p>
                                    </div>
                                    <div class="col-md-4">
                                        <p>
                                            <strong>Usuario: </strong>
                                            {{ item.user.usuario }}
                                        </p>
                                    </div>
                                </div>
                            </div>
                            <div class="card-footer">
                                <button
                                    class="btn btn-primary"
                                    @click="descargarComprobante(item.id)"
                                >
                                    <i class="fa fa-file-pdf"></i> Comprobante
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
</template>

<script>
export default {
    props: ["id"],
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
        this.getPrestamo();
    },
    methods: {
        getPrestamo() {
            axios
                .get(main_url + "/admin/prestamos/" + this.id)
                .then((response) => {
                    this.oPrestamo = response.data.prestamo;
                });
        },
        descargarComprobante(id) {
            let config = {
                responseType: "blob",
            };
            axios
                .post(main_url + "/admin/pagos/comprobante/" + id, null, config)
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
    },
};
</script>

<style>
.tabla_prestamos tbody tr td {
    vertical-align: middle;
}
</style>
