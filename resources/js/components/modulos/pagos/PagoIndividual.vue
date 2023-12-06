<template>
    <div
        class="modal fade"
        :class="{ show: bModal }"
        id="modal-default"
        aria-modal="true"
        role="dialog"
    >
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-success">
                    <h4 class="modal-title" v-html="tituloModal"></h4>
                    <button
                        type="button"
                        class="close"
                        data-dismiss="modal"
                        aria-label="Close"
                        @click="cierraModal"
                    >
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-12">
                            <p>
                                <strong>Cliente: </strong>
                                {{ prestamo.cliente.full_name }}
                            </p>
                            <p>
                                <strong>C.I.: </strong>
                                {{ prestamo.cliente.full_ci }}
                            </p>
                            <p><strong>Monto: </strong>{{ prestamo.monto }}</p>
                            <p class="mb-0">
                                <strong>Plazo: </strong> {{ prestamo.plazo }}
                            </p>
                        </div>
                    </div>
                    <div class="row" v-if="oPlanPago">
                        <div class="col-md-12">
                            <hr />
                        </div>
                        <div class="col-md-6 form-group">
                            <label>Nro. de cuota*</label>
                            <input
                                type="text"
                                class="form-control"
                                v-model="oPago.nro_cuota"
                                readonly
                            />
                        </div>
                        <div class="col-md-6 form-group">
                            <label>Capital*</label>
                            <input
                                type="text"
                                class="form-control"
                                v-model="oPago.monto"
                                readonly
                            />
                        </div>
                        <div class="col-md-6 form-group">
                            <label>Días Mora*</label>
                            <input
                                type="text"
                                class="form-control"
                                v-model="oPago.dias_mora"
                                readonly
                            />
                        </div>
                        <div class="col-md-6 form-group">
                            <label>Monto mora*</label>
                            <input
                                type="text"
                                class="form-control"
                                v-model="oPago.monto_mora"
                                readonly
                            />
                        </div>
                        <div class="col-md-6 form-group">
                            <label>Interes*</label>
                            <input
                                type="text"
                                class="form-control"
                                v-model="oPago.interes"
                                readonly
                            />
                        </div>
                        <div class="col-md-6 form-group">
                            <label>Monto total*</label>
                            <input
                                type="text"
                                class="form-control"
                                v-model="oPago.monto_total"
                                readonly
                            />
                        </div>
                    </div>
                    <div class="row" v-else>
                        <div class="col-md-12">
                            <h5 class="w-100 text-center text-gray">
                                No hay pagos para realizar
                            </h5>
                        </div>
                    </div>
                </div>
                <div class="modal-footer justify-content-between">
                    <button
                        type="button"
                        class="btn btn-default"
                        data-dismiss="modal"
                        @click="cierraModal"
                    >
                        Cerrar
                    </button>
                    <el-button
                        type="success"
                        class="bg-success"
                        :disabled="!oPlanPago"
                        :loading="enviando"
                        @click="setRegistroModal()"
                        v-html="textoBoton"
                    ></el-button>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    props: {
        muestra_modal: {
            type: Boolean,
            default: false,
        },
        prestamo: {
            type: Object,
            default: {
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
        },
    },
    watch: {
        muestra_modal: function (newVal, oldVal) {
            this.errors = [];
            if (newVal) {
                this.bModal = true;
                this.getNuevoPago();
            } else {
                this.bModal = false;
            }
        },
        prestamo: function (newVal) {
            this.getNuevoPago();
        },
    },
    computed: {
        tituloModal() {
            return '<i class="fa fa-plus"></i> REALIZAR PAGO';
        },
        textoBoton() {
            return '<i class="fa fa-check"></i> Registrar pago';
        },
    },
    data() {
        return {
            user: JSON.parse(localStorage.getItem("user")),
            bModal: this.muestra_modal,
            enviando: false,
            errors: [],
            oPlanPago: null,
            oPago: {
                prestamo_id: "",
                plan_pago_id: "",
                cliente_id: "",
                nro_cuota: "",
                monto: "",
                interes: "",
                dias_mora: "",
                monto_mora: "",
                monto_total: "",
            },
        };
    },
    mounted() {
        this.bModal = this.muestra_modal;
    },
    methods: {
        getNuevoPago() {
            if (this.prestamo.id != "") {
                axios
                    .get(
                        main_url +
                            "/admin/prestamos/get_pago/" +
                            this.prestamo.id
                    )
                    .then((response) => {
                        this.oPlanPago = response.data.plan_pago;
                        this.oPago.prestamo_id = this.prestamo.id;
                        this.oPago.plan_pago_id = this.oPlanPago.id;
                        this.oPago.cliente_id = this.prestamo.cliente_id;
                        this.oPago.nro_cuota = this.oPlanPago.nro_cuota;
                        this.oPago.interes = this.oPlanPago.interes;
                        this.oPago.monto = this.oPlanPago.capital;
                        this.oPago.dias_mora = response.data.dias_mora;
                        this.oPago.monto_mora = response.data.monto_mora;
                        this.oPago.monto_total =
                            parseFloat(this.oPago.monto) +
                            parseFloat(this.oPago.interes) +
                            parseFloat(this.oPago.monto_mora);
                        this.oPago.monto_total = parseFloat(
                            this.oPago.monto_total
                        ).toFixed(2);
                    })
                    .catch((error) => {
                        this.enviando = false;
                        if (error.response) {
                            if (error.response.status === 422) {
                                this.errors = error.response.data.errors;
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
                            }
                            if (
                                error.response.status === 420 ||
                                error.response.status === 419 ||
                                error.response.status === 401
                            ) {
                                window.location = "/";
                            }
                            if (
                                error.response.status === 500 ||
                                error.response.status === 400
                            ) {
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
        setRegistroModal() {
            this.enviando = true;
            axios
                .post(main_url + "/admin/pagos", this.oPago)
                .then((res) => {
                    this.enviando = false;
                    Swal.fire({
                        icon: "success",
                        title: res.data.msj,
                        showConfirmButton: false,
                        timer: 1500,
                    });
                    this.descargarComprobante(res.data.pago.id);
                    this.$emit("envioModal");
                })
                .catch((error) => {
                    this.enviando = false;
                    if (error.response) {
                        if (error.response.status === 422) {
                            this.errors = error.response.data.errors;
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

        // Dialog/modal
        cierraModal() {
            this.bModal = false;
            this.$emit("close");
        },
    },
};
</script>

<style></style>
