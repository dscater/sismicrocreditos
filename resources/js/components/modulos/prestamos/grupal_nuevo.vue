<template>
    <div class="content-wrapper contenedor_prestamos_grupal">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Préstamos Grupal - Nuevo</h1>
                    </div>
                </div>
            </div>
        </section>
        <section class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-3">
                        <router-link
                            v-if="permisos.includes('prestamos.grupal')"
                            :to="{ name: 'prestamos.grupal' }"
                            class="btn btn-default btn-flat btn-block"
                        >
                            <i class="fa fa-arrow-left"></i>
                            Volver
                        </router-link>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-4 form-group">
                                        <label>Nombre del grupo*</label>
                                        <el-input
                                            placeholder="Nombre del grupo"
                                            :class="{
                                                'is-invalid': errors.nombre,
                                            }"
                                            v-model="oGrupo.nombre"
                                            clearable
                                        >
                                        </el-input>
                                        <span
                                            class="error invalid-feedback"
                                            v-if="errors.nombre"
                                            v-text="errors.nombre[0]"
                                        ></span>
                                    </div>
                                    <div class="col-md-4 form-group">
                                        <label
                                            >Integrantes*
                                            <i
                                                class="fa fa-sync"
                                                @click="actualizarIntegrantes"
                                            ></i
                                        ></label>
                                        <input
                                            type="number"
                                            placeholder="Integrantes"
                                            class="form-control"
                                            :class="{
                                                'is-invalid':
                                                    errors.integrantes,
                                            }"
                                            v-model="oGrupo.integrantes"
                                            @change="actualizarIntegrantes"
                                            @keyup="actualizarIntegrantes"
                                        />
                                        <span
                                            class="error invalid-feedback"
                                            v-if="errors.integrantes"
                                            v-text="errors.integrantes[0]"
                                        ></span>
                                    </div>
                                    <div class="col-md-4 form-group">
                                        <label>Monto grupal*</label>
                                        <input
                                            type="number"
                                            placeholder="Monto grupal"
                                            class="form-control"
                                            :class="{
                                                'is-invalid': errors.monto,
                                            }"
                                            v-model="oGrupo.monto"
                                            @change="divideMonto"
                                            @keyup="divideMonto"
                                        />
                                        <span
                                            class="error invalid-feedback"
                                            v-if="errors.monto"
                                            v-text="errors.monto[0]"
                                        ></span>
                                    </div>
                                    <div class="col-md-4 form-group">
                                        <label>Plazo*</label>
                                        <input
                                            type="number"
                                            placeholder="Plazo"
                                            class="form-control"
                                            :class="{
                                                'is-invalid': errors.plazo,
                                            }"
                                            v-model="oGrupo.plazo"
                                        />
                                        <span
                                            class="error invalid-feedback"
                                            v-if="errors.plazo"
                                            v-text="errors.plazo[0]"
                                        ></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div
                    class="row"
                    v-show="oGrupo.monto && parseFloat(oGrupo.monto) > 0"
                >
                    <div class="col-md-12">
                        <div class="integrantes">
                            <div
                                v-for="(item, index) in oGrupo.prestamos"
                                class="integrante"
                                :class="{
                                    active: i_integrante == index,
                                }"
                                @click="mostrarIntegrante(index)"
                            >
                                <span class="txt_integrante"
                                    ><i class="fa fa-user"></i>
                                    <span
                                        v-text="
                                            item.cliente.nombre ||
                                            item.cliente.paterno
                                                ? item.cliente.nombre +
                                                  ' ' +
                                                  item.cliente.paterno
                                                : 'Integrante ' + (index + 1)
                                        "
                                    ></span
                                ></span>
                            </div>
                        </div>
                    </div>
                    <Prestamo
                        v-for="(item, index) in oGrupo.prestamos"
                        :key="index"
                        :index_prestamo="index"
                        :errores="errors"
                        :prestamo="item"
                        v-show="i_integrante == index"
                        :plazo_prestamos="oGrupo.plazo"
                    ></Prestamo>
                </div>
                <div class="row pb-4">
                    <div class="col-md-3">
                        <button
                            class="btn btn-success btn-block btn-flat"
                            v-html="txtBtnFinalizar"
                            :disabled="
                                enviando ||
                                !oGrupo.monto ||
                                parseFloat(oGrupo.monto) <= 0
                            "
                            @click="registrarPrestamo"
                        ></button>
                    </div>
                </div>
            </div>
        </section>
    </div>
</template>

<script>
import Prestamo from "./parcial/Prestamo.vue";
export default {
    components: {
        Prestamo,
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
            oGrupo: {
                nombre: "",
                integrantes: 3,
                monto: 0,
                plazo: 12,
                prestamos: [
                    {
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
                    {
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
                    {
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
                ],
            },
            i_integrante: 0,
            errors: [],
            enviando: false,
        };
    },
    computed: {
        txtBtnFinalizar() {
            if (this.enviando) {
                return '<i class="fa fa-spinner fa-spin"></i> Enviando...';
            }
            return 'Finalizar <i class="fa fa-flag-checkered"></i>';
        },
    },
    mounted() {
        this.loadingWindow.close();
    },
    methods: {
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
        registrarPrestamo() {
            this.enviando = true;
            axios
                .post(main_url + "/admin/prestamos/grupal", this.oGrupo)
                .then((res) => {
                    setTimeout(() => {
                        this.enviando = false;
                    }, 1000);
                    Swal.fire({
                        icon: "success",
                        title: res.data.msj,
                        showConfirmButton: false,
                        timer: 1500,
                    });
                    this.descargarPlanPagos(res.data.grupo);
                    this.errors = [];
                    this.$router.push({ name: "prestamos.grupal" });
                })
                .catch(async (error) => {
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
                            error.response.status == 400
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
        },
        divideMonto() {
            let nro_integrantes = this.oGrupo.prestamos.length;
            if (
                this.oGrupo.monto &&
                parseFloat(this.oGrupo.monto) > 0 &&
                nro_integrantes > 0
            ) {
                let monto_dividido =
                    parseFloat(this.oGrupo.monto) / nro_integrantes;
                monto_dividido = parseFloat(monto_dividido).toFixed(2);
                this.oGrupo.prestamos.forEach((el) => {
                    el.monto = monto_dividido;
                });
            }
        },
        verificaMontoGrupal(index, monto) {
            let monto_grupal = this.oGrupo.monto;
            let suma_actual = this.getSumaMontoPrestamos();
            if (suma_actual != monto_grupal) {
                Swal.fire({
                    icon: "error",
                    title: "Error",
                    html: "",
                    showConfirmButton: true,
                    confirmButtonColor: "#339431",
                    confirmButtonText: "Aceptar",
                });
            }
        },
        getSumaMontoPrestamos() {
            const sumaTotal = this.oGrupo.prestamos.reduce(
                (acumulador, objeto) => acumulador + objeto.monto,
                0
            );
            return sumaTotal;
        },
        actualizarIntegrantes() {
            if (
                this.oGrupo &&
                this.oGrupo.integrantes &&
                this.oGrupo.integrantes >= 2 &&
                this.oGrupo.integrantes <= 3
            ) {
                let cantidad_actual = this.oGrupo.integrantes;
                let integrantes_actual = this.oGrupo.prestamos.length;
                if (cantidad_actual > integrantes_actual) {
                    this.oGrupo.prestamos.push({
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
                    });
                } else if (cantidad_actual != integrantes_actual) {
                    this.oGrupo.prestamos.splice(2, 1);
                }
                this.divideMonto();
            } else {
                Swal.fire({
                    icon: "error",
                    title: "Error",
                    html: "La cantidad de integrantes deben ser 2 ó 3",
                    showConfirmButton: true,
                    confirmButtonColor: "#339431",
                    confirmButtonText: "Aceptar",
                });
            }
        },
        mostrarIntegrante(i) {
            this.i_integrante = i;
        },
    },
};
</script>

<style>
.contenedor_prestamos_grupal .integrantes {
    display: flex;
    justify-content: space-around;
}
.contenedor_prestamos_grupal .integrantes .integrante {
    cursor: pointer;
    padding: 15px;
    font-weight: bold;
    background-color: white;
    border: solid 1px rgb(212, 211, 211);
    text-align: center;
    flex: 1;
    transition: 0.4s all;
}

.contenedor_prestamos_grupal .integrantes .integrante:hover {
    background-color: var(--principal);
    color: white;
}
.contenedor_prestamos_grupal .integrantes .integrante.active {
    background-color: var(--principal);
    color: white;
}

@media (max-width: 800px) {
    .txt_integrante {
        display: flex;
        justify-content: center;
        align-items: center;
        flex-direction: column;
    }
}
</style>
