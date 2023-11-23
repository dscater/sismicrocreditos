<template>
    <!-- Main Sidebar Container -->
    <aside class="main-sidebar sidebar-dark-primary">
        <!-- Brand Logo -->
        <router-link exact :to="{ name: 'inicio' }" class="brand-link bg-dark">
            <img
                :src="configuracion.path_image"
                alt="Logo"
                class="brand-image img-circle elevation-3"
                style="opacity: 0.8"
            />
            <!-- <span
                class="brand-text font-weight-light"
                v-text="configuracion.alias"
            ></span> -->
        </router-link>

        <!-- Sidebar -->
        <div class="sidebar p-0">
            <!-- Sidebar user (optional) -->
            <div class="user-panel mt-3 pb-3 mb-3 d-flex">
                <div class="image">
                    <img
                        :src="user_sidebar.path_image"
                        class="img-circle elevation-2"
                        alt="User Image"
                    />
                </div>
                <div class="info">
                    <router-link
                        exact
                        :to="{
                            name: 'usuarios.perfil',
                            params: { id: user.id },
                        }"
                        class="d-block"
                        v-text="user_sidebar.full_name"
                    ></router-link>
                </div>
            </div>

            <!-- SidebarSearch Form -->
            <div class="form-inline pl-1 pr-1">
                <div class="input-group" data-widget="sidebar-search">
                    <input
                        class="form-control form-control-sidebar bg-white"
                        type="search"
                        placeholder="Buscar Modulo"
                        aria-label="Search"
                    />
                    <div class="input-group-append">
                        <button class="btn btn-sidebar bg-white">
                            <i class="fas fa-search fa-fw"></i>
                        </button>
                    </div>
                </div>
            </div>

            <!-- Sidebar Menu -->
            <nav class="mt-2 pr-1 pl-1">
                <ul
                    class="nav nav-pills nav-sidebar flex-column text-xs nav-flat"
                    data-widget="treeview"
                    role="menu"
                    data-accordion="false"
                >
                    <!-- Add icons to the links using the .nav-icon class with font-awesome or any other icon font library -->
                    <li class="nav-item">
                        <router-link
                            exact
                            :to="{ name: 'inicio' }"
                            class="nav-link"
                        >
                            <i class="nav-icon fas fa-home"></i>
                            <p>Inicio</p>
                        </router-link>
                    </li>
                    <li
                        class="nav-header font-weight-bold"
                        v-if="
                            permisos.includes('usuarios.index') ||
                            permisos.includes('clientes.index')
                        "
                    >
                        ADMINISTRACIÓN:
                    </li>
                    <li
                        class="nav-item"
                        v-if="
                            permisos.includes('pagos.individual') ||
                            permisos.includes('pagos.grupal')
                        "
                        :class="[
                            $route.name == 'pagos.individual' ||
                            $route.name == 'pagos.grupal'
                                ? 'menu-is-opening menu-open'
                                : '',
                        ]"
                    >
                        <a href="#" class="nav-link">
                            <i class="nav-icon fas fa-clipboard-list"></i>
                            <p>
                                Pagos
                                <i class="fas fa-angle-left right"></i>
                            </p>
                        </a>
                        <ul class="nav nav-treeview">
                            <li
                                class="nav-item"
                                v-if="permisos.includes('pagos.individual')"
                            >
                                <router-link
                                    exact
                                    :to="{ name: 'pagos.individual' }"
                                    class="nav-link"
                                    :class="[
                                        $route.name == 'pagos.individual'
                                            ? 'active'
                                            : '',
                                    ]"
                                    v-loading.fullscreen.lock="
                                        fullscreenLoading
                                    "
                                >
                                    <i class="nav-icon far fa-circle"></i>
                                    <p>Individual</p>
                                </router-link>
                            </li>
                            <li
                                class="nav-item"
                                v-if="permisos.includes('pagos.grupal')"
                            >
                                <router-link
                                    exact
                                    :to="{ name: 'pagos.grupal' }"
                                    class="nav-link"
                                    v-loading.fullscreen.lock="
                                        fullscreenLoading
                                    "
                                >
                                    <i class="nav-icon far fa-circle"></i>
                                    <p>Grupal</p>
                                </router-link>
                            </li>
                        </ul>
                    </li>
                    <li
                        class="nav-item"
                        v-if="
                            permisos.includes('desembolsos.individual') ||
                            permisos.includes('desembolsos.grupal')
                        "
                        :class="[
                            $route.name == 'desembolsos.individual' ||
                            $route.name == 'desembolsos.grupal'
                                ? 'menu-is-opening menu-open'
                                : '',
                        ]"
                    >
                        <a href="#" class="nav-link">
                            <i class="nav-icon fas fa-hand-holding-usd"></i>
                            <p>
                                Desembolsos
                                <i class="fas fa-angle-left right"></i>
                            </p>
                        </a>
                        <ul class="nav nav-treeview">
                            <li
                                class="nav-item"
                                v-if="
                                    permisos.includes('desembolsos.individual')
                                "
                            >
                                <router-link
                                    exact
                                    :to="{ name: 'desembolsos.individual' }"
                                    class="nav-link"
                                    :class="[
                                        $route.name == 'desembolsos.individual'
                                            ? 'active'
                                            : '',
                                    ]"
                                    v-loading.fullscreen.lock="
                                        fullscreenLoading
                                    "
                                >
                                    <i class="nav-icon far fa-circle"></i>
                                    <p>Individual</p>
                                </router-link>
                            </li>
                            <li
                                class="nav-item"
                                v-if="permisos.includes('desembolsos.grupal')"
                            >
                                <router-link
                                    exact
                                    :to="{ name: 'desembolsos.grupal' }"
                                    class="nav-link"
                                    v-loading.fullscreen.lock="
                                        fullscreenLoading
                                    "
                                >
                                    <i class="nav-icon far fa-circle"></i>
                                    <p>Grupal</p>
                                </router-link>
                            </li>
                        </ul>
                    </li>
                    <li
                        class="nav-item"
                        v-if="
                            permisos.includes('prestamos.individual') ||
                            permisos.includes('prestamos.grupal')
                        "
                        :class="[
                            $route.name == 'prestamos.individual' ||
                            $route.name == 'prestamos.grupal' ||
                            $route.name == 'prestamos.individual_nuevo'
                                ? 'menu-is-opening menu-open'
                                : '',
                        ]"
                    >
                        <a href="#" class="nav-link">
                            <i class="nav-icon fas fa-list-alt"></i>
                            <p>
                                Préstamos
                                <i class="fas fa-angle-left right"></i>
                            </p>
                        </a>
                        <ul class="nav nav-treeview">
                            <li
                                class="nav-item"
                                v-if="permisos.includes('prestamos.individual')"
                            >
                                <router-link
                                    exact
                                    :to="{ name: 'prestamos.individual' }"
                                    class="nav-link"
                                    :class="[
                                        $route.name == 'prestamos.individual' ||
                                        $route.name ==
                                            'prestamos.individual_nuevo'
                                            ? 'active'
                                            : '',
                                    ]"
                                    v-loading.fullscreen.lock="
                                        fullscreenLoading
                                    "
                                >
                                    <i class="nav-icon far fa-circle"></i>
                                    <p>Individual</p>
                                </router-link>
                            </li>
                            <li
                                class="nav-item"
                                v-if="permisos.includes('prestamos.grupal')"
                            >
                                <router-link
                                    exact
                                    :to="{ name: 'prestamos.grupal' }"
                                    class="nav-link"
                                    v-loading.fullscreen.lock="
                                        fullscreenLoading
                                    "
                                >
                                    <i class="nav-icon far fa-circle"></i>
                                    <p>Grupal</p>
                                </router-link>
                            </li>
                        </ul>
                    </li>
                    <li
                        class="nav-item"
                    >
                        <a href="" class="nav-link">
                            <i class="fa fa-cash-register nav-icon"></i>
                            <p>Caja</p>
                        </a>
                    </li>
                    <li
                        class="nav-item"
                        v-if="permisos.includes('clientes.index')"
                    >
                        <router-link
                            :to="{ name: 'clientes.index' }"
                            class="nav-link"
                        >
                            <i class="fa fa-user-friends nav-icon"></i>
                            <p>Clientes</p>
                        </router-link>
                    </li>
                    <li
                        class="nav-item"
                        v-if="permisos.includes('usuarios.index')"
                    >
                        <router-link
                            exact
                            :to="{ name: 'usuarios.index' }"
                            class="nav-link"
                            v-loading.fullscreen.lock="fullscreenLoading"
                        >
                            <i class="nav-icon fas fa-users"></i>
                            <p>Empleados</p>
                        </router-link>
                    </li>
                    <li
                        class="nav-header font-weight-bold"
                        v-if="
                            permisos.includes('reportes.usuarios') ||
                            permisos.includes('reportes.plan_contingencia') ||
                            permisos.includes(
                                'reportes.cantidad_plan_contingencia'
                            )
                        "
                    >
                        REPORTES:
                    </li>
                    <li
                        class="nav-item"
                        v-if="permisos.includes('reportes.usuarios')"
                    >
                        <router-link
                            :to="{ name: 'reportes.usuarios' }"
                            class="nav-link"
                        >
                            <i class="fas fa-file-pdf nav-icon"></i>
                            <p>Lista de Usuarios</p>
                        </router-link>
                    </li>
                    <li class="nav-header font-weight-bold">OTRAS OPCIONES:</li>
                    <li
                        class="nav-item"
                        v-if="permisos.includes('configuracion.index')"
                    >
                        <router-link
                            :to="{ name: 'configuracion' }"
                            class="nav-link"
                        >
                            <i class="nav-icon fas fa-cog"></i>
                            <p>Configurar Sistema</p>
                        </router-link>
                    </li>
                    <li class="nav-item">
                        <router-link
                            exact
                            :to="{
                                name: 'usuarios.perfil',
                                params: { id: user.id },
                            }"
                            class="nav-link"
                        >
                            <i class="nav-icon fas fa-user"></i>
                            <p>Perfil</p>
                        </router-link>
                    </li>
                    <li class="nav-item">
                        <a
                            href="#"
                            class="nav-link"
                            @click.prevent="logout()"
                            v-loading.fullscreen.lock="fullscreenLoading"
                        >
                            <i class="fas fa-power-off nav-icon"></i>
                            <p>Salir</p>
                        </a>
                    </li>
                </ul>
            </nav>
            <!-- /.sidebar-menu -->
        </div>
        <!-- /.sidebar -->
    </aside>
</template>

<script>
export default {
    props: ["user_sidebar", "configuracion"],
    data() {
        return {
            user: JSON.parse(localStorage.getItem("user")),
            fullscreenLoading: false,
            permisos:
                typeof localStorage.getItem("permisos") == "string"
                    ? JSON.parse(localStorage.getItem("permisos"))
                    : localStorage.getItem("permisos"),
            timeoutId: null,
        };
    },
    mounted() {
        // Configurar el temporizador para llamar a logout después de 5 minutos de inactividad
        this.resetLogoutTimer();
        window.addEventListener("mousemove", this.resetLogoutTimer);
    },
    methods: {
        logout() {
            this.fullscreenLoading = true;
            axios.post(main_url + "/logout").then((res) => {
                let self = this;
                setTimeout(function () {
                    self.$router.push({ name: "login" });
                    localStorage.clear();
                    location.reload();
                }, 500);
            });
        },
        resetLogoutTimer() {
            // Reiniciar el temporizador cuando se detecta actividad
            clearTimeout(this.timeoutId);
            this.timeoutId = setTimeout(() => {
                this.logout();
            }, 10 * 60 * 1000); // 10 minutos en milisegundos
        },
    },
    beforeDestroy() {
        // Limpiar el temporizador y quitar el evento cuando se destruye el componente
        clearTimeout(this.timeoutId);
        window.removeEventListener("mousemove", this.resetLogoutTimer);
    },
};
</script>

<style>
.user-panel .info {
    display: flex;
    height: 100%;
    align-items: center;
}
.user-panel .info a {
    font-size: 0.8em;
}

.main-sidebar .image img {
    min-height: 30px;
}
</style>
