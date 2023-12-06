<template>
    <!-- Main Sidebar Container -->
    <aside class="main-sidebar sidebar-dark-warning">
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
            <nav class="mt-2 pr-0 pl-1">
                <ul
                    class="nav nav-pills nav-sidebar flex-column text-xs nav-flat nav-child-indent"
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
                            permisos.includes('clientes.index') ||
                            permisos.includes('salarios.index') ||
                            permisos.includes('pagos.individual') ||
                            permisos.includes('pagos.grupal') ||
                            permisos.includes('desembolsos.individual') ||
                            permisos.includes('desembolsos.grupal') ||
                            permisos.includes('prestamos.individual') ||
                            permisos.includes('prestamos.grupal') ||
                            permisos.includes('cajas.index') ||
                            permisos.includes('clientes.index') ||
                            permisos.includes('salarios.index')
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
                            $route.name == 'pagos.grupal' ||
                            $route.name == 'pagos.ver_pagos_individual' ||
                            $route.name == 'pagos.ver_pagos_grupal'
                                ? 'menu-is-opening menu-open active'
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
                        <ul
                            class="nav nav-treeview"
                            :style="{
                                display:
                                    $route.name == 'pagos.individual' ||
                                    $route.name == 'pagos.grupal' ||
                                    $route.name ==
                                        'pagos.ver_pagos_individual' ||
                                    $route.name == 'pagos.ver_pagos_grupal'
                                        ? 'block'
                                        : 'none',
                            }"
                        >
                            <li
                                class="nav-item"
                                v-if="permisos.includes('pagos.individual')"
                            >
                                <router-link
                                    exact
                                    :to="{ name: 'pagos.individual' }"
                                    class="nav-link"
                                    :class="[
                                        $route.name == 'pagos.individual' ||
                                        $route.name ==
                                            'pagos.ver_pagos_individual'
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
                                    :class="[
                                        $route.name == 'pagos.grupal' ||
                                        $route.name == 'pagos.ver_pagos_grupal'
                                            ? 'active'
                                            : '',
                                    ]"
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
                                ? 'menu-is-opening menu-open active'
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
                        <ul
                            class="nav nav-treeview"
                            :style="{
                                display:
                                    $route.name == 'desembolsos.individual' ||
                                    $route.name == 'desembolsos.grupal'
                                        ? 'block'
                                        : 'none',
                            }"
                        >
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
                            permisos.includes('prestamos.simulacion') ||
                            permisos.includes('prestamos.grupal')
                        "
                        :class="[
                            $route.name == 'prestamos.individual' ||
                            $route.name == 'prestamos.grupal' ||
                            $route.name == 'prestamos.simulacion' ||
                            $route.name == 'prestamos.individual_nuevo' ||
                            $route.name == 'prestamos.grupal_nuevo'
                                ? 'menu-is-opening menu-open active'
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
                        <ul
                            class="nav nav-treeview"
                            :style="{
                                display:
                                    $route.name == 'prestamos.individual' ||
                                    $route.name == 'prestamos.simulacion' ||
                                    $route.name == 'prestamos.grupal' ||
                                    $route.name ==
                                        'prestamos.individual_nuevo' ||
                                    $route.name == 'prestamos.grupal_nuevo'
                                        ? 'block'
                                        : 'none',
                            }"
                        >
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
                                    :class="[
                                        $route.name == 'prestamos.grupal' ||
                                        $route.name == 'prestamos.grupal_nuevo'
                                            ? 'active'
                                            : '',
                                    ]"
                                    v-loading.fullscreen.lock="
                                        fullscreenLoading
                                    "
                                >
                                    <i class="nav-icon far fa-circle"></i>
                                    <p>Grupal</p>
                                </router-link>
                            </li>
                            <li
                                class="nav-item"
                                v-if="permisos.includes('prestamos.simulacion')"
                            >
                                <router-link
                                    exact
                                    :to="{ name: 'prestamos.simulacion' }"
                                    class="nav-link"
                                    :class="[
                                        $route.name == 'prestamos.simulacion'
                                            ? 'active'
                                            : '',
                                    ]"
                                    v-loading.fullscreen.lock="
                                        fullscreenLoading
                                    "
                                >
                                    <i class="nav-icon far fa-circle"></i>
                                    <p>Simulación</p>
                                </router-link>
                            </li>
                        </ul>
                    </li>
                    <li
                        class="nav-item"
                        v-if="permisos.includes('cajas.index')"
                    >
                        <router-link
                            :to="{ name: 'cajas.index' }"
                            class="nav-link"
                        >
                            <i class="fa fa-cash-register nav-icon"></i>
                            <p>Caja</p>
                        </router-link>
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
                        class="nav-item"
                        v-if="permisos.includes('salarios.index')"
                    >
                        <router-link
                            exact
                            :to="{ name: 'salarios.index' }"
                            class="nav-link"
                            v-loading.fullscreen.lock="fullscreenLoading"
                        >
                            <i class="nav-icon fas fa-list"></i>
                            <p>Salarios</p>
                        </router-link>
                    </li>
                    <li
                        class="nav-header font-weight-bold"
                        v-if="
                            permisos.includes('reportes.usuarios') ||
                            permisos.includes('reportes.clientes') ||
                            permisos.includes(
                                'reportes.prestamos_individual'
                            ) ||
                            permisos.includes('reportes.prestamos_grupal') ||
                            permisos.includes(
                                'reportes.proximos_desembolsos_individual'
                            ) ||
                            permisos.includes(
                                'reportes.proximos_desembolsos_grupal'
                            ) ||
                            permisos.includes(
                                'reportes.prestamos_individual_mora'
                            ) ||
                            permisos.includes(
                                'reportes.prestamos_grupal_mora'
                            ) ||
                            permisos.includes(
                                'reportes.extracto_pagos_individual'
                            ) ||
                            permisos.includes('reportes.extracto_pagos_grupal')
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
                    <li
                        class="nav-item"
                        v-if="permisos.includes('reportes.clientes')"
                    >
                        <router-link
                            :to="{ name: 'reportes.clientes' }"
                            class="nav-link"
                        >
                            <i class="fas fa-file-pdf nav-icon"></i>
                            <p>Lista de Clientes</p>
                        </router-link>
                    </li>
                    <li
                        class="nav-item"
                        v-if="
                            permisos.includes('reportes.prestamos_individual')
                        "
                    >
                        <router-link
                            :to="{ name: 'reportes.prestamos_individual' }"
                            class="nav-link"
                        >
                            <i class="fas fa-file-pdf nav-icon"></i>
                            <p>Préstamos Individual</p>
                        </router-link>
                    </li>
                    <li
                        class="nav-item"
                        v-if="permisos.includes('reportes.prestamos_grupal')"
                    >
                        <router-link
                            :to="{ name: 'reportes.prestamos_grupal' }"
                            class="nav-link"
                        >
                            <i class="fas fa-file-pdf nav-icon"></i>
                            <p>Préstamos Grupal</p>
                        </router-link>
                    </li>
                    <li
                        class="nav-item"
                        v-if="
                            permisos.includes(
                                'reportes.proximos_desembolsos_individual'
                            )
                        "
                    >
                        <router-link
                            :to="{
                                name: 'reportes.proximos_desembolsos_individual',
                            }"
                            class="nav-link"
                        >
                            <i class="fas fa-file-pdf nav-icon"></i>
                            <p>Próximos Desembolsos Individual</p>
                        </router-link>
                    </li>
                    <li
                        class="nav-item"
                        v-if="
                            permisos.includes(
                                'reportes.proximos_desembolsos_grupal'
                            )
                        "
                    >
                        <router-link
                            :to="{
                                name: 'reportes.proximos_desembolsos_grupal',
                            }"
                            class="nav-link"
                        >
                            <i class="fas fa-file-pdf nav-icon"></i>
                            <p>Próximos Desembolsos Grupal</p>
                        </router-link>
                    </li>
                    <li
                        class="nav-item"
                        v-if="
                            permisos.includes(
                                'reportes.prestamos_individual_mora'
                            )
                        "
                    >
                        <router-link
                            :to="{ name: 'reportes.prestamos_individual_mora' }"
                            class="nav-link"
                        >
                            <i class="fas fa-file-pdf nav-icon"></i>
                            <p>Moras Préstamos Individual</p>
                        </router-link>
                    </li>
                    <li
                        class="nav-item"
                        v-if="
                            permisos.includes('reportes.prestamos_grupal_mora')
                        "
                    >
                        <router-link
                            :to="{ name: 'reportes.prestamos_grupal_mora' }"
                            class="nav-link"
                        >
                            <i class="fas fa-file-pdf nav-icon"></i>
                            <p>Moras Préstamos Grupal</p>
                        </router-link>
                    </li>
                    <li
                        class="nav-item"
                        v-if="
                            permisos.includes(
                                'reportes.extracto_pagos_individual'
                            )
                        "
                    >
                        <router-link
                            :to="{ name: 'reportes.extracto_pagos_individual' }"
                            class="nav-link"
                        >
                            <i class="fas fa-file-pdf nav-icon"></i>
                            <p>Extracto Pagos Individual</p>
                        </router-link>
                    </li>
                    <li
                        class="nav-item"
                        v-if="
                            permisos.includes('reportes.extracto_pagos_grupal')
                        "
                    >
                        <router-link
                            :to="{ name: 'reportes.extracto_pagos_grupal' }"
                            class="nav-link"
                        >
                            <i class="fas fa-file-pdf nav-icon"></i>
                            <p>Extracto Pagos Grupal</p>
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
