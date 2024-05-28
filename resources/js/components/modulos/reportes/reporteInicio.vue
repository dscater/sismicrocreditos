<template>
    <div class="row">
        <div class="col-md-12">
            <div class="row">
                <div class="col-md-4 mx-auto">
                    <label
                        :class="{
                            'text-danger': errors.gestion,
                        }"
                        class="w-100 text-center mb-0"
                        >Gestión</label
                    >
                    <input
                        type="number"
                        v-model="oReporte.gestion"
                        filterable
                        placeholder="Ingresar gestión"
                        class="form-control rounded-0 text-center"
                        :class="{
                            'is-invalid': errors.gestion,
                        }"
                        @change="generaReporte()"
                    />
                    <span
                        class="error invalid-feedback"
                        v-if="errors.gestion"
                        v-text="errors.gestion[0]"
                    ></span>
                </div>
            </div>
        </div>
        <div class="col-12" id="container"></div>
        <div class="col-12 mt-3" id="container2"></div>
    </div>
</template>

<script>
export default {
    data() {
        return {
            loadingWindow: Loading.service({
                fullscreen: this.fullscreenLoading,
            }),
            errors: [],
            oReporte: {
                gestion: this.getAnioActual(),
            },
            enviando: false,
            textoBtn: "Generar Reporte",
            errors: [],
        };
    },
    mounted() {
        this.loadingWindow.close();
        this.generaReporte();
    },
    methods: {
        limpiarFormulario() {
            this.oReporte.gestion = "Todos";
        },
        generaReporte() {
            this.enviando = true;
            axios
                .post(
                    main_url + "/admin/reportes/prestamos_estado",
                    this.oReporte
                )
                .then((response) => {
                    this.enviando = false;
                    let categorias = response.data.categories;
                    Highcharts.chart("container", {
                        chart: {
                            type: "column",
                        },
                        title: {
                            align: "center",
                            text: "Préstamos",
                        },
                        xAxis: {
                            categories: categorias,
                        },
                        yAxis: {
                            min: 0,
                            title: {
                                text: "Total",
                            },
                        },
                        legend: {
                            enabled: true,
                        },
                        plotOptions: {
                            series: {
                                borderWidth: 0,
                                dataLabels: {
                                    enabled: true,
                                    format: "{point.y:.0f}",
                                },
                            },
                        },
                        series: response.data.series1,
                    });
                    Highcharts.chart("container2", {
                        chart: {
                            type: "column",
                        },
                        title: {
                            align: "center",
                            text: "Préstamos",
                        },
                        xAxis: {
                            categories: categorias,
                        },
                        yAxis: {
                            min: 0,
                            title: {
                                text: "Total",
                            },
                        },
                        legend: {
                            enabled: true,
                        },
                        plotOptions: {
                            series: {
                                borderWidth: 0,
                                dataLabels: {
                                    enabled: true,
                                    format: "{point.y:.0f}",
                                },
                            },
                        },
                        series: response.data.series2,
                    });
                })
                .catch(async (error) => {
                    this.enviando = false;
                    if (error.response) {
                        if (error.response.status === 422) {
                            this.errors = responseObj.errors;
                        }
                        if (
                            error.response.status === 420 ||
                            error.response.status === 419 ||
                            error.response.status === 401
                        ) {
                            Swal.fire({
                                icon: "error",
                                title: "Error",
                                html: responseObj.message,
                                showConfirmButton: false,
                                timer: 2000,
                            });
                            window.location = "/";
                        }
                    }
                });
        },
    },
};
</script>

<style></style>
