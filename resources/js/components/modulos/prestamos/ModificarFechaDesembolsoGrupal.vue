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
                                <strong>Nombre del grupo: </strong>
                                {{ grupo?.nombre }}
                            </p>
                            <p><strong>Integrantes: </strong></p>
                            <ul>
                                <li v-for="item in grupo?.prestamos">
                                    {{ item.cliente.full_name }} -
                                    {{ item.cliente.full_ci }}
                                </li>
                            </ul>
                            <p><strong>Monto: </strong>{{ grupo?.monto }}</p>
                            <p><strong>Plazo: </strong> {{ grupo?.plazo }}</p>
                        </div>
                        <div class="col-md-12">
                            <label>Fecha de desembolso*</label>
                            <input
                                type="date"
                                v-model="fecha_desembolso"
                                class="form-control"
                            />
                            <span
                                class="error invalid-feedback d-block"
                                v-if="errors.fecha_desembolso"
                                v-text="errors.fecha_desembolso[0]"
                            ></span>
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
        muestra_modal_fecha: {
            type: Boolean,
            default: false,
        },
        grupo: {
            type: Object,
            default: {
                user_id: "",
                nombre: "",
                integrantes: "",
                monto: "",
                plazo: "",
                estado: "",
                fecha_registro: "",
            },
        },
    },
    watch: {
        muestra_modal_fecha: function (newVal, oldVal) {
            this.errors = [];
            if (newVal) {
                this.bModal = true;
                this.fecha_desembolso = this.grupo.fecha_desembolso;
            } else {
                this.bModal = false;
            }
        },
    },
    computed: {
        tituloModal() {
            return '<i class="fa fa-edit"></i> MODIFICAR PRÉSTAMO - FECHA DE DESEMBOLSO';
        },
        textoBoton() {
            return '<i class="fa fa-edit"></i> Actualizar préstamo';
        },
    },
    data() {
        return {
            user: JSON.parse(localStorage.getItem("user")),
            bModal: this.muestra_modal_fecha,
            enviando: false,
            errors: [],
            fecha_desembolso: this.grupo.fecha_desembolso,
        };
    },
    mounted() {
        this.bModal = this.muestra_modal_fecha;
    },
    methods: {
        setRegistroModal() {
            this.enviando = true;
            axios
                .post(
                    main_url +
                        "/admin/prestamos/actualizar_fecha_desembolso_grupal/" +
                        this.grupo.id,
                    {
                        _method: "PATCH",
                        fecha_desembolso: this.fecha_desembolso,
                    }
                )
                .then((res) => {
                    this.enviando = false;
                    Swal.fire({
                        icon: "success",
                        title: res.data.msj,
                        showConfirmButton: false,
                        timer: 1500,
                    });
                    this.$emit("envioModal", res.data.grupo);
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
