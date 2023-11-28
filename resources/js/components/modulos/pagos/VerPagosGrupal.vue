<template>
    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Pagos Grupal > Ver Pagos</h1>
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
                                name: 'pagos.grupal',
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
                                            <strong>Nombre del grupo: </strong>
                                            {{ oGrupo?.nombre }}
                                        </p>
                                        <p><strong>Integrantes: </strong></p>
                                        <ul>
                                            <li
                                                v-for="item in oGrupo?.prestamos"
                                            >
                                                {{ item.cliente.full_name }} -
                                                {{ item.cliente.full_ci }}
                                            </li>
                                        </ul>
                                        <p>
                                            <strong>Monto: </strong
                                            >{{ oGrupo?.monto }}
                                        </p>
                                        <p>
                                            <strong>Plazo: </strong>
                                            {{ oGrupo?.plazo }}
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div
                        class="col-md-12"
                        v-if="oGrupo?.grupo_pagos.length > 0"
                    >
                        <h4 class="w-100 text-center">
                            LISTA DE PAGOS REALIZADOS
                        </h4>
                    </div>
                    <div
                        class="col-md-12"
                        v-if="oGrupo?.grupo_pagos.length > 0"
                        v-for="item in oGrupo?.grupo_pagos"
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
            oGrupo: {
                nombre: "",
                integrantes: 3,
                monto: 0,
                plazo: 12,
                grupo_pagos: [],
                prestamos: [],
            },
        };
    },
    mounted() {
        this.loadingWindow.close();
        this.getGrupo();
    },
    methods: {
        getGrupo() {
            axios
                .get(main_url + "/admin/grupos/" + this.id)
                .then((response) => {
                    this.oGrupo = response.data.grupo;
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
