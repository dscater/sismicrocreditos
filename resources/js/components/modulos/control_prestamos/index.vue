<template>
    <div class="content-wrapper contenedor_control_prestamos">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Control de Préstamos</h1>
                    </div>
                </div>
            </div>
        </section>
        <section class="content">
            <div class="container-fluid">
                <infoControl></infoControl>
            </div>
        </section>
    </div>
</template>

<script>
import infoControl from "./infoControl";
export default {
    components: {
        infoControl,
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
        };
    },
    mounted() {
        this.loadingWindow.close();
    },
    methods: {},
};
</script>
