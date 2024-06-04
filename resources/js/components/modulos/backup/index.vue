<template>
    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Backup de la base de datos</h1>
                    </div>
                </div>
            </div>
        </section>
        <section class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header bg-success">
                                <div class="row">
                                    <div class="col-md-3">
                                        <button
                                            v-if="
                                                permisos.includes(
                                                    'configuracion.edit'
                                                )
                                            "
                                            class="btn btn-warning btn-flat btn-block"
                                            @click="descargarBackup()"
                                        >
                                            <i class="fa fa-download"></i>
                                            Descargar base de datos
                                        </button>
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
            permisos: localStorage.getItem("permisos"),
            // config table
            loading: false,
            // Fin config table

            fullscreenLoading: true,
            loadingWindow: Loading.service({
                fullscreen: this.fullscreenLoading,
            }),
            errors: [],
            nombre_bd: "",
            archivo_sql: null,
            enviando: false,
            texto_pre: "",
        };
    },
    mounted() {
        this.loadingWindow.close();
    },
    methods: {
        getFile(e) {
            this.archivo_sql = e.target.files[0];
        },
        descargarBackup() {
            axios.get("/admin/backup/download").then((response) => {
                window.open(response.data.url);
            });
        },
    },
};
</script>

<style>
.el-descriptions-item__cell.el-descriptions-item__label.is-bordered-label {
    background: var(--principal) !important;
}
</style>
