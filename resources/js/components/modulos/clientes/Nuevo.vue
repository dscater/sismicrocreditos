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
                    <form>
                        <div class="row">
                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger': errors.nombre,
                                    }"
                                    >Nombre*</label
                                >
                                <el-input
                                    placeholder="Nombre"
                                    :class="{ 'is-invalid': errors.nombre }"
                                    v-model="cliente.nombre"
                                    clearable
                                >
                                </el-input>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.nombre"
                                    v-text="errors.nombre[0]"
                                ></span>
                            </div>
                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger': errors.segundo_nombre,
                                    }"
                                    >Segundo Nombre</label
                                >
                                <el-input
                                    placeholder="Segundo Nombre"
                                    :class="{
                                        'is-invalid': errors.segundo_nombre,
                                    }"
                                    v-model="cliente.segundo_nombre"
                                    clearable
                                >
                                </el-input>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.segundo_nombre"
                                    v-text="errors.segundo_nombre[0]"
                                ></span>
                            </div>
                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger': errors.paterno,
                                    }"
                                    >Ap. Paterno*</label
                                >

                                <el-input
                                    placeholder="Ap. Paterno"
                                    :class="{ 'is-invalid': errors.paterno }"
                                    v-model="cliente.paterno"
                                    clearable
                                >
                                </el-input>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.paterno"
                                    v-text="errors.paterno[0]"
                                ></span>
                            </div>
                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger': errors.materno,
                                    }"
                                    >Ap. Materno</label
                                >
                                <el-input
                                    placeholder="Ap. Materno"
                                    :class="{ 'is-invalid': errors.materno }"
                                    v-model="cliente.materno"
                                    clearable
                                >
                                </el-input>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.materno"
                                    v-text="errors.materno[0]"
                                ></span>
                            </div>
                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger': errors.ci,
                                    }"
                                    >C.I.*</label
                                >
                                <el-input
                                    placeholder="Número de C.I."
                                    :class="{ 'is-invalid': errors.ci }"
                                    v-model="cliente.ci"
                                    clearable
                                >
                                </el-input>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.ci"
                                    v-text="errors.ci[0]"
                                ></span>
                            </div>
                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger': errors.ci_exp,
                                    }"
                                    >Expedido*</label
                                >
                                <el-select
                                    class="w-100 d-block"
                                    :class="{
                                        'is-invalid': errors.ci_exp,
                                    }"
                                    v-model="cliente.ci_exp"
                                    clearable
                                >
                                    <el-option
                                        v-for="(item, index) in listExpedido"
                                        :key="index"
                                        :value="item.value"
                                        :label="item.label"
                                    >
                                    </el-option>
                                </el-select>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.ci_exp"
                                    v-text="errors.ci_exp[0]"
                                ></span>
                            </div>
                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger': errors.cel,
                                    }"
                                    >Celular*</label
                                >
                                <el-input
                                    placeholder="Celular"
                                    :class="{ 'is-invalid': errors.cel }"
                                    v-model="cliente.cel"
                                    clearable
                                >
                                </el-input>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.cel"
                                    v-text="errors.cel[0]"
                                ></span>
                            </div>
                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger': errors.fono,
                                    }"
                                    >Teléfono</label
                                >
                                <el-input
                                    placeholder="Teléfono"
                                    :class="{ 'is-invalid': errors.fono }"
                                    v-model="cliente.fono"
                                    clearable
                                >
                                </el-input>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.fono"
                                    v-text="errors.fono[0]"
                                ></span>
                            </div>
                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger': errors.edad,
                                    }"
                                    >Edad*</label
                                >
                                <input
                                    type="number"
                                    placeholder="Edad"
                                    class="form-control"
                                    :class="{ 'is-invalid': errors.edad }"
                                    v-model="cliente.edad"
                                />
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.edad"
                                    v-text="errors.edad[0]"
                                ></span>
                            </div>
                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger': errors.dir,
                                    }"
                                    >Dirección*</label
                                >
                                <el-input
                                    placeholder="Dirección"
                                    :class="{ 'is-invalid': errors.dir }"
                                    v-model="cliente.dir"
                                    clearable
                                >
                                </el-input>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.dir"
                                    v-text="errors.dir[0]"
                                ></span>
                            </div>
                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger': errors.referencia,
                                    }"
                                    >Nombre Referencia*</label
                                >
                                <el-input
                                    placeholder="Nombre Referencia"
                                    :class="{ 'is-invalid': errors.referencia }"
                                    v-model="cliente.referencia"
                                    clearable
                                >
                                </el-input>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.referencia"
                                    v-text="errors.referencia[0]"
                                ></span>
                            </div>
                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger': errors.cel_ref,
                                    }"
                                    >Teléfono Referencia*</label
                                >
                                <el-input
                                    placeholder="Teléfono Referencia"
                                    :class="{ 'is-invalid': errors.cel_ref }"
                                    v-model="cliente.cel_ref"
                                    clearable
                                >
                                </el-input>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.cel_ref"
                                    v-text="errors.cel_ref[0]"
                                ></span>
                            </div>
                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger': errors.parentesco,
                                    }"
                                    >Parentesco*</label
                                >
                                <el-input
                                    placeholder="Parentesco"
                                    :class="{ 'is-invalid': errors.parentesco }"
                                    v-model="cliente.parentesco"
                                    clearable
                                >
                                </el-input>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.parentesco"
                                    v-text="errors.parentesco[0]"
                                ></span>
                            </div>
                        </div>
                    </form>
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
                        >{{ textoBoton }}</el-button
                    >
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
        accion: {
            type: String,
            default: "nuevo",
        },
        cliente: {
            type: Object,
            default: {
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
            },
        },
    },
    watch: {
        muestra_modal: function (newVal, oldVal) {
            this.errors = [];
            if (newVal) {
                // this.$refs.input_file.value = null;
                this.bModal = true;
            } else {
                this.bModal = false;
            }
        },
    },
    computed: {
        tituloModal() {
            if (this.accion == "nuevo") {
                return '<i class="fa fa-plus"></i> AGREGAR CLIENTE';
            } else {
                return '<i class="fa fa-edit"></i> MODIFICAR REGISTRO';
            }
        },
        textoBoton() {
            if (this.accion == "nuevo") {
                return "Registrar";
            } else {
                return "Actualizar";
            }
        },
    },
    data() {
        return {
            user: JSON.parse(localStorage.getItem("user")),
            bModal: this.muestra_modal,
            enviando: false,
            listExpedido: [
                { value: "LP", label: "La Paz" },
                { value: "CB", label: "Cochabamba" },
                { value: "SC", label: "Santa Cruz" },
                { value: "CH", label: "Chuquisaca" },
                { value: "OR", label: "Oruro" },
                { value: "PT", label: "Potosi" },
                { value: "TJ", label: "Tarija" },
                { value: "PD", label: "Pando" },
                { value: "BN", label: "Beni" },
            ],
            errors: [],
        };
    },
    mounted() {
        this.bModal = this.muestra_modal;
    },
    methods: {
        setRegistroModal() {
            this.enviando = true;
            try {
                this.textoBtn = "Enviando...";
                let url = main_url + "/admin/clientes";
                let config = {
                    headers: {
                        "Content-Type": "multipart/form-data",
                    },
                };
                let formdata = new FormData();
                formdata.append(
                    "nombre",
                    this.cliente.nombre ? this.cliente.nombre : ""
                );
                formdata.append(
                    "segundo_nombre",
                    this.cliente.segundo_nombre
                        ? this.cliente.segundo_nombre
                        : ""
                );
                formdata.append(
                    "paterno",
                    this.cliente.paterno ? this.cliente.paterno : ""
                );
                formdata.append(
                    "materno",
                    this.cliente.materno ? this.cliente.materno : ""
                );
                formdata.append(
                    "dir",
                    this.cliente.dir ? this.cliente.dir : ""
                );
                formdata.append("ci", this.cliente.ci ? this.cliente.ci : "");
                formdata.append(
                    "ci_exp",
                    this.cliente.ci_exp ? this.cliente.ci_exp : ""
                );
                formdata.append(
                    "cel",
                    this.cliente.cel ? this.cliente.cel : ""
                );
                formdata.append(
                    "fono",
                    this.cliente.fono ? this.cliente.fono : ""
                );
                formdata.append(
                    "edad",
                    this.cliente.edad ? this.cliente.edad : ""
                );
                formdata.append(
                    "referencia",
                    this.cliente.referencia ? this.cliente.referencia : ""
                );
                formdata.append(
                    "cel_ref",
                    this.cliente.cel_ref ? this.cliente.cel_ref : ""
                );
                formdata.append(
                    "parentesco",
                    this.cliente.parentesco ? this.cliente.parentesco : ""
                );

                if (this.accion == "edit") {
                    url = main_url + "/admin/clientes/" + this.cliente.id;
                    formdata.append("_method", "PUT");
                }
                axios
                    .post(url, formdata, config)
                    .then((res) => {
                        this.enviando = false;
                        Swal.fire({
                            icon: "success",
                            title: res.data.msj,
                            showConfirmButton: false,
                            timer: 1500,
                        });
                        this.limpiaCliente();
                        this.$emit("envioModal");
                        this.errors = [];
                        if (this.accion == "edit") {
                            this.textoBtn = "Actualizar";
                        } else {
                            this.textoBtn = "Registrar";
                        }
                    })
                    .catch((error) => {
                        this.enviando = false;
                        if (this.accion == "edit") {
                            this.textoBtn = "Actualizar";
                        } else {
                            this.textoBtn = "Registrar";
                        }
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
            } catch (e) {
                this.enviando = false;
                console.log(e);
            }
        },
        cargaImagen(e) {
            this.cliente.foto = e.target.files[0];
        },
        // Dialog/modal
        cierraModal() {
            this.bModal = false;
            this.$emit("close");
        },
        limpiaCliente() {
            this.errors = [];
            this.cliente.nombre = "";
            this.cliente.segundo_nombre = "";
            this.cliente.paterno = "";
            this.cliente.materno = "";
            this.cliente.dir = "";
            this.cliente.ci = "";
            this.cliente.ci_exp = "";
            this.cliente.cel = "";
            this.cliente.fono = "";
            this.cliente.edad = "";
            this.cliente.referencia = "";
            this.cliente.cel_ref = "";
            this.cliente.parentesco = "";
        },
    },
};
</script>

<style></style>
