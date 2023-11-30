import Vue from "vue";
import Router from "vue-router";

Vue.use(Router);

export default new Router({
    base: "/" + app_base,
    routes: [
        // INICIO
        {
            path: "/",
            name: "inicio",
            component: require("./components/Inicio.vue").default,
        },

        // LOGIN
        {
            path: "/login",
            name: "login",
            component: require("./Auth.vue").default,
        },

        // Usuarios
        {
            path: "/usuarios/perfil/:id",
            name: "usuarios.perfil",
            component: require("./components/modulos/usuarios/perfil.vue")
                .default,
            props: true,
        },
        {
            path: "/usuarios",
            name: "usuarios.index",
            component: require("./components/modulos/usuarios/index.vue")
                .default,
        },

        // Clientes
        {
            path: "/clientes",
            name: "clientes.index",
            component: require("./components/modulos/clientes/index.vue")
                .default,
        },

        // Cajas
        {
            path: "/caja",
            name: "cajas.index",
            component: require("./components/modulos/cajas/index.vue").default,
        },

        // Prestamos
        // individual
        {
            path: "/prestamos/individual",
            name: "prestamos.individual",
            component: require("./components/modulos/prestamos/individual.vue")
                .default,
        },
        {
            path: "/prestamos/individual/nuevo",
            name: "prestamos.individual_nuevo",
            component:
                require("./components/modulos/prestamos/individual_nuevo.vue")
                    .default,
        },
        // grupal
        {
            path: "/prestamos/grupal",
            name: "prestamos.grupal",
            component: require("./components/modulos/prestamos/grupal.vue")
                .default,
        },
        {
            path: "/prestamos/grupal/nuevo",
            name: "prestamos.grupal_nuevo",
            component:
                require("./components/modulos/prestamos/grupal_nuevo.vue")
                    .default,
        },

        // Desembolsos
        {
            path: "/desembolsos/individual",
            name: "desembolsos.individual",
            component:
                require("./components/modulos/desembolsos/individual.vue")
                    .default,
        },
        {
            path: "/desembolsos/grupal",
            name: "desembolsos.grupal",
            component: require("./components/modulos/desembolsos/grupal.vue")
                .default,
        },

        // Pagos
        // individual
        {
            path: "/pagos/individual",
            name: "pagos.individual",
            component: require("./components/modulos/pagos/individual.vue")
                .default,
        },
        {
            path: "/pagos/individual/ver_pagos/:id",
            name: "pagos.ver_pagos_individual",
            component:
                require("./components/modulos/pagos/VerPagosIndividual.vue")
                    .default,
            props: true,
        },
        // grupal
        {
            path: "/pagos/grupal",
            name: "pagos.grupal",
            component: require("./components/modulos/pagos/grupal.vue").default,
        },
        {
            path: "/pagos/grupal/ver_pagos/:id",
            name: "pagos.ver_pagos_grupal",
            component: require("./components/modulos/pagos/VerPagosGrupal.vue")
                .default,
            props: true,
        },

        // Configuración
        {
            path: "/configuracion",
            name: "configuracion",
            component: require("./components/modulos/configuracion/index.vue")
                .default,
            props: true,
        },

        // Reportes
        {
            path: "/reportes/usuarios",
            name: "reportes.usuarios",
            component: require("./components/modulos/reportes/usuarios.vue")
                .default,
            props: true,
        },
        {
            path: "/reportes/clientes",
            name: "reportes.clientes",
            component: require("./components/modulos/reportes/clientes.vue")
                .default,
            props: true,
        },
        {
            path: "/reportes/prestamos_individual",
            name: "reportes.prestamos_individual",
            component:
                require("./components/modulos/reportes/prestamos_individual.vue")
                    .default,
            props: true,
        },
        {
            path: "/reportes/prestamos_grupal",
            name: "reportes.prestamos_grupal",
            component:
                require("./components/modulos/reportes/prestamos_grupal.vue")
                    .default,
            props: true,
        },
        {
            path: "/reportes/proximos_desembolsos_individual",
            name: "reportes.proximos_desembolsos_individual",
            component:
                require("./components/modulos/reportes/proximos_desembolsos_individual.vue")
                    .default,
            props: true,
        },
        {
            path: "/reportes/proximos_desembolsos_grupal",
            name: "reportes.proximos_desembolsos_grupal",
            component:
                require("./components/modulos/reportes/proximos_desembolsos_grupal.vue")
                    .default,
            props: true,
        },
        {
            path: "/reportes/prestamos_individual_mora",
            name: "reportes.prestamos_individual_mora",
            component:
                require("./components/modulos/reportes/prestamos_individual_mora.vue")
                    .default,
            props: true,
        },
        {
            path: "/reportes/prestamos_grupal_mora",
            name: "reportes.prestamos_grupal_mora",
            component:
                require("./components/modulos/reportes/prestamos_grupal_mora.vue")
                    .default,
            props: true,
        },
        {
            path: "/reportes/extracto_pagos_individual",
            name: "reportes.extracto_pagos_individual",
            component:
                require("./components/modulos/reportes/extracto_pagos_individual.vue")
                    .default,
            props: true,
        },
        {
            path: "/reportes/extracto_pagos_grupal",
            name: "reportes.extracto_pagos_grupal",
            component:
                require("./components/modulos/reportes/extracto_pagos_grupal.vue")
                    .default,
            props: true,
        },

        // PÁGINA NO ENCONTRADA
        {
            path: "*",
            component: require("./components/modulos/errors/404.vue").default,
        },
    ],
    mode: "history",
    linkActiveClass: "active open",
});
