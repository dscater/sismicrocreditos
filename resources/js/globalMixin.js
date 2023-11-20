import axios from "axios";

export default {
    methods: {
        reemplazaBr(texto) {
            const textoConLineas = texto.replace(/<br\s*\/?>/g, "\n");
            // Eliminar saltos de línea adicionales
            const textoLimpio = textoConLineas.replace(/\n\s*\n/g, "\n");
            return textoLimpio;
        },
        getFormatoFecha(date) {
            if (date) {
                return this.$moment(String(date)).format("DD/MM/YYYY");
            }
            return "";
        },
        getAnioActual() {
            return this.$moment().format("YYYY");
        },
        getFechaActual() {
            return this.$moment().format("YYYY-MM-DD");
        },
        getHoraActual() {
            return this.$moment().format("HH:mm");
        },
        getUsuariosTipo(tipo) {
            return new Promise((resolve, reject) => {
                axios
                    .get(main_url + "/admin/usuarios/getUsuarioTipo", {
                        params: {
                            tipo: tipo,
                        },
                    })
                    .then((response) => {
                        resolve(response);
                    })
                    .catch((error) => {
                        reject(error);
                    });
            });
        },
        getUsuarioById(id) {
            return new Promise((resolve, reject) => {
                axios
                    .get(main_url + "/admin/usuarios/getUsuario/" + id)
                    .then((response) => {
                        resolve(response);
                    })
                    .catch((error) => {
                        reject(error);
                    });
            });
        },
    },
};
