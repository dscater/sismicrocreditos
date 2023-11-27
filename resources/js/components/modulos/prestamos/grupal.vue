<template>
    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Préstamos Grupal</h1>
                    </div>
                </div>
            </div>
        </section>
        <section class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-3">
                        <router-link
                            v-if="permisos.includes('prestamos.grupal_nuevo')"
                            :to="{ name: 'prestamos.grupal_nuevo' }"
                            class="btn btn-primary btn-flat btn-block"
                        >
                            <i class="fa fa-plus"></i>
                            Nuevo
                        </router-link>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-12">
                                        <h4 class="w-100 text-center">
                                            Buscar préstamo Grupal
                                        </h4>
                                    </div>
                                    <div class="col-md-8 offset-md-2">
                                        <div class="input-group">
                                            <input
                                                type="text"
                                                class="form-control"
                                                placeholder="Nombre Grupo"
                                                v-model="txt_nombre"
                                                @keyup="empezarBusqueda"
                                            />
                                            <div class="input-group-append">
                                                <button
                                                    class="btn btn-primary"
                                                    type="button"
                                                    @click="empezarBusqueda"
                                                >
                                                    <i class="fa fa-search"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row mt-3" v-if="txt_nombre != ''">
                                    <div
                                        class="col-md-12"
                                        v-if="oGrupo && !loading"
                                    >
                                        <table
                                            class="table table-bordered tabla_prestamos"
                                        >
                                            <thead class="bg-primary">
                                                <tr>
                                                    <th>Nombre Grupo</th>
                                                    <th>Nro. Integrantes</th>
                                                    <th>Monto</th>
                                                    <th>Plazo</th>
                                                    <th>Estado</th>
                                                    <th>Fecha Registro</th>
                                                    <th width="20%">Acción</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td>{{ oGrupo.nombre }}</td>
                                                    <td>
                                                        {{ oGrupo.integrantes }}
                                                    </td>
                                                    <td>{{ oGrupo.monto }}</td>
                                                    <td>{{ oGrupo.plazo }}</td>
                                                    <td
                                                        class="text-center font-weight-bold"
                                                        :class="{
                                                            'bg-warning':
                                                                oGrupo.estado ==
                                                                'PRE APROBADO',
                                                            'bg-danger':
                                                                oGrupo.estado ==
                                                                'RECHAZADO',
                                                            'bg-success':
                                                                oGrupo.estado ==
                                                                'APROBADO',
                                                            'bg-gray':
                                                                oGrupo.estado ==
                                                                'FINALIZADO',
                                                        }"
                                                    >
                                                        {{ oGrupo.estado }}
                                                    </td>
                                                    <td>
                                                        {{
                                                            oGrupo.fecha_registro_t
                                                        }}
                                                    </td>
                                                    <td>
                                                        <button
                                                            class="inline-block btn btn-xs btn-success"
                                                            v-if="
                                                                oGrupo.desembolso ==
                                                                    0 &&
                                                                oGrupo.estado !=
                                                                    'APROBADO' &&
                                                                oGrupo.estado !=
                                                                    'FINALIZADO'
                                                            "
                                                            @click="
                                                                aprobarPrestamo(
                                                                    oGrupo
                                                                )
                                                            "
                                                        >
                                                            <i
                                                                class="fa fa-thumbs-up"
                                                            ></i>
                                                            Aprobar
                                                        </button>
                                                        <button
                                                            class="inline-block btn btn-xs btn-danger"
                                                            v-if="
                                                                oGrupo.desembolso ==
                                                                0
                                                            "
                                                            @click="
                                                                rechazarPrestamo(
                                                                    oGrupo
                                                                )
                                                            "
                                                        >
                                                            <i
                                                                class="fa fa-thumbs-down"
                                                            ></i>
                                                            Rechazar
                                                        </button>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="col-md-12" v-else>
                                        <h5
                                            class="w-100 text-center text-gray"
                                            v-show="!loading"
                                        >
                                            No se encontrarón registros...
                                        </h5>
                                    </div>
                                    <div class="col-md-12" v-if="loading">
                                        <h5 class="w-100 text-center text-gray">
                                            Buscando...
                                        </h5>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <AprobacionGrupal
            :muestra_modal="muestra_modal"
            :grupo="oGrupo"
            @close="muestra_modal = false"
            @envioModal="empezarBusqueda"
        ></AprobacionGrupal>
    </div>
</template>

<script>
import AprobacionGrupal from "./AprobacionGrupal.vue";
export default {
    components: {
        AprobacionGrupal,
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
            txt_nombre: "",
            loading: false,
            setTimeOutBusqueda: null,
            muestra_modal: false,
            oGrupo: null,
        };
    },
    mounted() {
        this.loadingWindow.close();
    },
    methods: {
        aprobarPrestamo(item) {
            this.oPrestamo = item;
            this.muestra_modal = true;
        },
        rechazarPrestamo(item) {
            let id = item.id;
            let descripcion = `<div clas="text-center">`;
            descripcion += `<p><strong>Cliente: </strong> ${item.cliente.full_name}</p>`;
            descripcion += `<p><strong>Monto: </strong> ${item.monto}</p>`;
            descripcion += `<p><strong>Plazo: </strong> ${item.plazo}</p>`;
            descripcion += `</div>`;
            Swal.fire({
                title: "¿Quierés rechazar este préstamo?",
                html: descripcion,
                showCancelButton: true,
                confirmButtonColor: "#c82333",
                confirmButtonText: "Si, rechazar",
                cancelButtonText: "No, cancelar",
                denyButtonText: `No, cancelar`,
            }).then((result) => {
                /* Read more about isConfirmed, isDenied below */
                if (result.isConfirmed) {
                    axios
                        .post(
                            main_url +
                                "/admin/prestamos/individual/rechazar/" +
                                id,
                            {
                                _method: "PUT",
                            }
                        )
                        .then((res) => {
                            this.empezarBusqueda();
                            Swal.fire({
                                icon: "success",
                                title: res.data.msj,
                                showConfirmButton: false,
                                timer: 1500,
                            });
                        })
                        .catch((error) => {
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
                }
            });
        },
        empezarBusqueda() {
            this.muestra_modal = false;
            this.loading = true;
            clearInterval(this.setTimeOutBusqueda);
            this.setTimeOutBusqueda = setTimeout(() => {
                this.buscarGrupoNombre();
            }, 700);
        },
        buscarGrupoNombre() {
            axios
                .get(main_url + "/admin/prestamos/grupal/grupo_nombre", {
                    params: {
                        nombre: this.txt_nombre,
                    },
                })
                .then((response) => {
                    this.loading = false;
                    this.oGrupo = response.data.grupo;
                })
                .catch((error) => {
                    this.loading = false;
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
        },
    },
};
</script>

<style>
.tabla_prestamos tbody tr td {
    vertical-align: middle;
}
</style>
