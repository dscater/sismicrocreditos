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
                            <p>
                                <strong>Fecha de desembolso: </strong>
                                {{ prestamo.fecha_desembolso }}
                            </p>
                        </div>
                        <div class="col-md-12">
                            <div class="input-group">
                                <input
                                    class="form-control rounded-0"
                                    v-model="prestamo.documento_1"
                                    readonly
                                />
                                <div class="input-group-prepend">
                                    <div class="contenedor_file">
                                        <button
                                            :disabled="
                                                prestamo.documento_1_f_url
                                                    ? false
                                                    : true
                                            "
                                            @click="
                                                descargarArchivo(
                                                    prestamo.documento_1_f_url
                                                )
                                            "
                                        >
                                            <i class="fa fa-download"></i>
                                            Descargar
                                        </button>
                                    </div>
                                </div>
                            </div>
                            <div class="input-group">
                                <input
                                    class="form-control rounded-0"
                                    v-model="prestamo.documento_2"
                                    readonly
                                />
                                <div class="input-group-prepend">
                                    <div class="contenedor_file">
                                        <button
                                            :disabled="
                                                prestamo.documento_2_f_url
                                                    ? false
                                                    : true
                                            "
                                            @click="
                                                descargarArchivo(
                                                    prestamo.documento_2_f_url
                                                )
                                            "
                                        >
                                            <i class="fa fa-download"></i>
                                            Descargar
                                        </button>
                                    </div>
                                </div>
                            </div>
                            <div class="input-group">
                                <input
                                    class="form-control rounded-0"
                                    v-model="prestamo.documento_3"
                                    readonly
                                />
                                <div class="input-group-prepend">
                                    <div class="contenedor_file">
                                        <button
                                            :disabled="
                                                prestamo.documento_3_f_url
                                                    ? false
                                                    : true
                                            "
                                            @click="
                                                descargarArchivo(
                                                    prestamo.documento_3_f_url
                                                )
                                            "
                                        >
                                            <i class="fa fa-download"></i>
                                            Descargar
                                        </button>
                                    </div>
                                </div>
                            </div>
                            <div class="input-group">
                                <input
                                    class="form-control rounded-0"
                                    v-model="prestamo.documento_4"
                                    readonly
                                />
                                <div class="input-group-prepend">
                                    <div class="contenedor_file">
                                        <button
                                            :disabled="
                                                prestamo.documento_4_f_url
                                                    ? false
                                                    : true
                                            "
                                            @click="
                                                descargarArchivo(
                                                    prestamo.documento_4_f_url
                                                )
                                            "
                                        >
                                            <i class="fa fa-download"></i>
                                            Descargar
                                        </button>
                                    </div>
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
                    <!-- <el-button
                        type="success"
                        class="bg-success"
                        :loading="enviando"
                        @click="setRegistroModal()"
                        v-html="textoBoton"
                    ></el-button> -->
                </div>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    props: {
        muestra_modal_docs: {
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
        muestra_modal_docs: function (newVal, oldVal) {
            this.errors = [];
            if (newVal) {
                this.bModal = true;
                this.fecha_desembolso = this.prestamo.fecha_desembolso;
            } else {
                this.bModal = false;
            }
        },
    },
    computed: {
        tituloModal() {
            return '<i class="fa fa-edit"></i> MODFICIAR PRÉSTAMO - FECHA DE DESEMBOLSO';
        },
        textoBoton() {
            return '<i class="fa fa-edit"></i> Actualizar préstamo';
        },
    },
    data() {
        return {
            user: JSON.parse(localStorage.getItem("user")),
            bModal: this.muestra_modal_docs,
            enviando: false,
            errors: [],
            fecha_desembolso: this.prestamo.fecha_desembolso,
        };
    },
    mounted() {
        this.bModal = this.muestra_modal_docs;
    },
    methods: {
        descargarArchivo(url) {
            console.log(url);
            window.open(url, "_blank");
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
