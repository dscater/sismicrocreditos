<template>
    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Préstamos - Simulación</h1>
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
                                    <div class="col-md-12 mt-3">
                                        <div class="card">
                                            <div class="card-body">
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="row">
                                                            <div
                                                                class="form-group col-md-4"
                                                            >
                                                                <label
                                                                    :class="{
                                                                        'text-danger':
                                                                            errors.nombre,
                                                                    }"
                                                                    >Nombre*</label
                                                                >
                                                                <el-input
                                                                    placeholder="Nombre"
                                                                    :class="{
                                                                        'is-invalid':
                                                                            errors.nombre,
                                                                    }"
                                                                    v-model="
                                                                        oPrestamo
                                                                            .cliente
                                                                            .nombre
                                                                    "
                                                                    clearable
                                                                    :readonly="
                                                                        oPrestamo.registrar_como ==
                                                                        'ANTIGUO'
                                                                    "
                                                                >
                                                                </el-input>
                                                                <span
                                                                    class="error invalid-feedback"
                                                                    v-if="
                                                                        errors.nombre
                                                                    "
                                                                    v-text="
                                                                        errors
                                                                            .nombre[0]
                                                                    "
                                                                ></span>
                                                            </div>
                                                            <div
                                                                class="form-group col-md-4"
                                                            >
                                                                <label
                                                                    :class="{
                                                                        'text-danger':
                                                                            errors.segundo_nombre,
                                                                    }"
                                                                    >Segundo
                                                                    Nombre</label
                                                                >
                                                                <el-input
                                                                    placeholder="Segundo Nombre"
                                                                    :class="{
                                                                        'is-invalid':
                                                                            errors.segundo_nombre,
                                                                    }"
                                                                    v-model="
                                                                        oPrestamo
                                                                            .cliente
                                                                            .segundo_nombre
                                                                    "
                                                                    clearable
                                                                    :readonly="
                                                                        oPrestamo.registrar_como ==
                                                                        'ANTIGUO'
                                                                    "
                                                                >
                                                                </el-input>
                                                                <span
                                                                    class="error invalid-feedback"
                                                                    v-if="
                                                                        errors.segundo_nombre
                                                                    "
                                                                    v-text="
                                                                        errors
                                                                            .segundo_nombre[0]
                                                                    "
                                                                ></span>
                                                            </div>
                                                            <div
                                                                class="form-group col-md-4"
                                                            >
                                                                <label
                                                                    :class="{
                                                                        'text-danger':
                                                                            errors.paterno,
                                                                    }"
                                                                    >Ap.
                                                                    Paterno*</label
                                                                >

                                                                <el-input
                                                                    placeholder="Ap. Paterno"
                                                                    :class="{
                                                                        'is-invalid':
                                                                            errors.paterno,
                                                                    }"
                                                                    v-model="
                                                                        oPrestamo
                                                                            .cliente
                                                                            .paterno
                                                                    "
                                                                    clearable
                                                                    :readonly="
                                                                        oPrestamo.registrar_como ==
                                                                        'ANTIGUO'
                                                                    "
                                                                >
                                                                </el-input>
                                                                <span
                                                                    class="error invalid-feedback"
                                                                    v-if="
                                                                        errors.paterno
                                                                    "
                                                                    v-text="
                                                                        errors
                                                                            .paterno[0]
                                                                    "
                                                                ></span>
                                                            </div>
                                                            <div
                                                                class="form-group col-md-4"
                                                            >
                                                                <label
                                                                    :class="{
                                                                        'text-danger':
                                                                            errors.materno,
                                                                    }"
                                                                    >Ap.
                                                                    Materno</label
                                                                >

                                                                <el-input
                                                                    placeholder="Ap. Materno"
                                                                    :class="{
                                                                        'is-invalid':
                                                                            errors.materno,
                                                                    }"
                                                                    v-model="
                                                                        oPrestamo
                                                                            .cliente
                                                                            .materno
                                                                    "
                                                                    clearable
                                                                    :readonly="
                                                                        oPrestamo.registrar_como ==
                                                                        'ANTIGUO'
                                                                    "
                                                                >
                                                                </el-input>
                                                                <span
                                                                    class="error invalid-feedback"
                                                                    v-if="
                                                                        errors.materno
                                                                    "
                                                                    v-text="
                                                                        errors
                                                                            .materno[0]
                                                                    "
                                                                ></span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-12">
                                                        <div class="row">
                                                            <div
                                                                class="col-md-6 col-md-offset-3 form-group"
                                                            >
                                                                <label
                                                                    >Monto a
                                                                    prestar*</label
                                                                >
                                                                <input
                                                                    type="number"
                                                                    class="form-control"
                                                                    :class="{
                                                                        'is-invalid':
                                                                            errors.monto,
                                                                    }"
                                                                    v-model="
                                                                        oPrestamo.monto
                                                                    "
                                                                />
                                                                <span
                                                                    class="error invalid-feedback d-block"
                                                                    v-if="
                                                                        errors.monto
                                                                    "
                                                                    v-text="
                                                                        errors
                                                                            .monto[0]
                                                                    "
                                                                ></span>
                                                            </div>
                                                            <div
                                                                class="col-md-6 col-md-offset-3 form-group"
                                                            >
                                                                <label
                                                                    >Plazo
                                                                    (Cuotas)*</label
                                                                >
                                                                <input
                                                                    type="number"
                                                                    class="form-control"
                                                                    v-model="
                                                                        oPrestamo.plazo
                                                                    "
                                                                />
                                                                <span
                                                                    class="error invalid-feedback"
                                                                    v-if="
                                                                        errors.plazo
                                                                    "
                                                                    v-text="
                                                                        errors
                                                                            .plazo[0]
                                                                    "
                                                                ></span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="card-footer border-top">
                                                <div class="row">
                                                    <div
                                                        class="col-md-12 d-flex justify-content-center"
                                                    >
                                                        <button
                                                            class="btn btn-primary ml-1"
                                                            v-html="
                                                                txtBtnFinalizar
                                                            "
                                                            :disabled="enviando"
                                                            @click="
                                                                descargarPlanPagos
                                                            "
                                                        ></button>
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
            </div>
        </section>
    </div>
</template>

<script>
export default {
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
            total_pasos: 4,
            paso_actual: 1,
            oPrestamo: {
                registrar_como: "NUEVO",
                user_id: "",
                cliente_id: "",
                tipo: "",
                grupo_id: "",
                monto: "",
                plazo: 12,
                f_ci: "",
                f_luz: "",
                f_agua: "",
                croquis: "",
                documento_1: "",
                documento_2: "",
                documento_3: "",
                documento_4: "",
                estado: "",
                cliente: {
                    id: 0,
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
            url_principal: main_url,
            txt_ci: "",
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
            enviando: false,
        };
    },
    computed: {
        txtBtnFinalizar() {
            if (this.enviando) {
                return '<i class="fa fa-spinner fa-spin"></i> Enviando...';
            }
            return 'Generar <i class="fa fa-list-alt"></i>';
        },
    },
    mounted() {
        this.loadingWindow.close();
    },
    methods: {
        descargarPlanPagos() {
            let config = {
                responseType: "blob",
            };
            axios
                .post(
                    main_url +
                        "/admin/prestamos/simulacion/plan_pago_simulacion",
                    this.oPrestamo,
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
    },
};
</script>

<style></style>
