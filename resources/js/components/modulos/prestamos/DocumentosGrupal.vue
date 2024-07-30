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
                            <p>
                                <strong>Fecha de desembolso: </strong
                                >{{ grupo.fecha_desembolso }}
                            </p>
                        </div>
                        <div class="col-12">
                            <hr />
                            <h4 class="w-100 text-center">Documentos</h4>
                        </div>
                        <div
                            class="col-md-12"
                            v-for="prestamo in grupo?.prestamos"
                        >
                            <div class="card">
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-12">
                                            <p>
                                                <strong>Integrante: </strong
                                                >{{
                                                    prestamo.cliente.full_name
                                                }}
                                            </p>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-12">
                                            <div class="input-group">
                                                <input
                                                    class="form-control rounded-0"
                                                    v-model="
                                                        prestamo.documento_1
                                                    "
                                                    readonly
                                                />
                                                <div
                                                    class="input-group-prepend"
                                                >
                                                    <div
                                                        class="contenedor_file"
                                                    >
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
                                                            <i
                                                                class="fa fa-download"
                                                            ></i>
                                                            Descargar
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="input-group">
                                                <input
                                                    class="form-control rounded-0"
                                                    v-model="
                                                        prestamo.documento_2
                                                    "
                                                    readonly
                                                />
                                                <div
                                                    class="input-group-prepend"
                                                >
                                                    <div
                                                        class="contenedor_file"
                                                    >
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
                                                            <i
                                                                class="fa fa-download"
                                                            ></i>
                                                            Descargar
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="input-group">
                                                <input
                                                    class="form-control rounded-0"
                                                    v-model="
                                                        prestamo.documento_3
                                                    "
                                                    readonly
                                                />
                                                <div
                                                    class="input-group-prepend"
                                                >
                                                    <div
                                                        class="contenedor_file"
                                                    >
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
                                                            <i
                                                                class="fa fa-download"
                                                            ></i>
                                                            Descargar
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="input-group">
                                                <input
                                                    class="form-control rounded-0"
                                                    v-model="
                                                        prestamo.documento_4
                                                    "
                                                    readonly
                                                />
                                                <div
                                                    class="input-group-prepend"
                                                >
                                                    <div
                                                        class="contenedor_file"
                                                    >
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
                                                            <i
                                                                class="fa fa-download"
                                                            ></i>
                                                            Descargar
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer justify-content-end">
                    <button
                        type="button"
                        class="btn btn-default"
                        data-dismiss="modal"
                        @click="cierraModal"
                    >
                        Cerrar
                    </button>
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
        muestra_modal_docs: function (newVal, oldVal) {
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
            return '<i class="fa fa-edit"></i> PRÉSTAMO GRUPAL - DOCUMENTOS';
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
            fecha_desembolso: this.grupo.fecha_desembolso,
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
