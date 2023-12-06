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
                            <p><strong>Monto: </strong>{{ prestamo.monto }}</p>
                            <p><strong>Plazo: </strong> {{ prestamo.plazo }}</p>
                        </div>
                    </div>
                    <div class="card">
                        <div class="card-body">
                            <div class="row">
                                <div class="form-group col-md-12">
                                    <label
                                        :class="{
                                            'text-danger': errors.cancelado,
                                        }"
                                        >¿Registrar gastos
                                        administrativos?</label
                                    >
                                    <el-switch
                                        :class="{
                                            'is-invalid': errors.cancelado,
                                        }"
                                        style="display: block"
                                        v-model="oDesembolso.cancelado"
                                        active-color="#13ce66"
                                        inactive-color="#ff4949"
                                        active-text="SI"
                                        inactive-text="NO"
                                        active-value="SI"
                                        inactive-value="NO"
                                    >
                                    </el-switch>
                                    <span
                                        class="error invalid-feedback"
                                        v-if="errors.cancelado"
                                        v-text="errors.cancelado[0]"
                                    ></span>
                                </div>
                                <div class="col-md-12 form-group">
                                    <label>Gastos administrativos:</label>
                                    <input
                                        type="number"
                                        class="form-control"
                                        v-model="oDesembolso.monto"
                                        :disabled="
                                            oDesembolso.cancelado == 'NO'
                                        "
                                    />
                                </div>
                            </div>
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
            } else {
                this.bModal = false;
            }
        },
        prestamo() {
            this.getGastosAdministrativos();
        },
    },
    computed: {
        tituloModal() {
            return '<i class="fa fa-hand-holding-usd"></i> REALIZAR DESEMBOLSO';
        },
        textoBoton() {
            return '<i class="fa fa-check"></i> Realizar desembolso';
        },
    },
    data() {
        return {
            user: JSON.parse(localStorage.getItem("user")),
            bModal: this.muestra_modal,
            enviando: false,
            errors: [],
            oDesembolso: {
                user_id: "",
                tipo_prestamo: "INDIVIDUAL",
                prestamo_id: "",
                grupo_id: "",
                monto: 0,
                cancelado: "NO",
            },
        };
    },
    mounted() {
        this.bModal = this.muestra_modal;
        this.getGastosAdministrativos();
    },
    methods: {
        getGastosAdministrativos() {
            let monto = parseFloat(this.prestamo.monto);
            this.oDesembolso.prestamo_id = this.prestamo.id;
            this.oDesembolso.monto = monto * 0.02;
        },
        setRegistroModal() {
            this.enviando = true;
            axios
                .post(
                    main_url +
                        "/admin/desembolsos/individual/" +
                        this.prestamo.id,
                    this.oDesembolso
                )
                .then((res) => {
                    this.enviando = false;
                    Swal.fire({
                        icon: "success",
                        title: res.data.msj,
                        showConfirmButton: false,
                        timer: 1500,
                    });
                    this.$emit("envioModal", res.data.prestamo);
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
                        if (error.response.status === 500 || error.response.status === 400) {
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
