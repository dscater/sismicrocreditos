<template>
    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Préstamos Individual - Nuevo</h1>
                    </div>
                </div>
            </div>
        </section>
        <section class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-3">
                        <router-link
                            v-if="permisos.includes('prestamos.individual')"
                            :to="{ name: 'prestamos.individual' }"
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
                                    <div class="col-md-12">
                                        <div class="pasos">
                                            <div
                                                class="paso"
                                                :class="{
                                                    active: paso_actual == 1,
                                                }"
                                                @click="irPaso(1)"
                                            >
                                                <span class="nro_paso">1</span>
                                                <span class="txt_paso"
                                                    >Requisito de Pre
                                                    Aprobación</span
                                                >
                                            </div>
                                            <div
                                                class="paso"
                                                :class="{
                                                    active: paso_actual == 2,
                                                }"
                                                @click="irPaso(2)"
                                            >
                                                <span class="nro_paso">2</span>
                                                <span class="txt_paso"
                                                    >Formulario de Cliente</span
                                                >
                                            </div>
                                            <div
                                                class="paso"
                                                :class="{
                                                    active: paso_actual == 3,
                                                }"
                                                @click="irPaso(3)"
                                            >
                                                <span class="nro_paso">3</span>
                                                <span class="txt_paso"
                                                    >Monto y Plazo</span
                                                >
                                            </div>
                                            <div
                                                class="paso"
                                                :class="{
                                                    active: paso_actual == 4,
                                                }"
                                                @click="irPaso(4)"
                                            >
                                                <span class="nro_paso">4</span>
                                                <span class="txt_paso"
                                                    >Plan de Pagos</span
                                                >
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-12 mt-3">
                                        <div class="card">
                                            <div class="card-header bg-primary">
                                                <h4
                                                    class="text-lg mb-0"
                                                    v-html="tituloPaso"
                                                ></h4>
                                            </div>
                                            <div class="card-body">
                                                <div class="row">
                                                    <!-- PASO 1 -->
                                                    <div
                                                        class="col-md-12"
                                                        v-if="paso_actual == 1"
                                                    >
                                                        <div class="row">
                                                            <div
                                                                class="col-md-3"
                                                            >
                                                                <div
                                                                    class="icheck-primary d-inline"
                                                                >
                                                                    <input
                                                                        type="checkbox"
                                                                        id="checkboxPrimary1"
                                                                        v-model="
                                                                            oPrestamo.f_ci
                                                                        "
                                                                    />
                                                                    <label
                                                                        for="checkboxPrimary1"
                                                                        >Fotocopia
                                                                        de C.I.
                                                                    </label>
                                                                </div>
                                                                <span
                                                                    class="error invalid-feedback"
                                                                    v-if="
                                                                        errors.f_ci
                                                                    "
                                                                    v-text="
                                                                        errors
                                                                            .f_ci[0]
                                                                    "
                                                                ></span>
                                                            </div>
                                                            <div
                                                                class="col-md-3"
                                                            >
                                                                <div
                                                                    class="icheck-primary d-inline"
                                                                >
                                                                    <input
                                                                        type="checkbox"
                                                                        id="checkboxPrimary2"
                                                                        v-model="
                                                                            oPrestamo.f_luz
                                                                        "
                                                                    />
                                                                    <label
                                                                        for="checkboxPrimary2"
                                                                        >Fotocopia
                                                                        de Luz
                                                                    </label>
                                                                </div>
                                                                <span
                                                                    class="error invalid-feedback"
                                                                    v-if="
                                                                        errors.f_luz
                                                                    "
                                                                    v-text="
                                                                        errors
                                                                            .f_luz[0]
                                                                    "
                                                                ></span>
                                                            </div>
                                                            <div
                                                                class="col-md-3"
                                                            >
                                                                <div
                                                                    class="icheck-primary d-inline"
                                                                >
                                                                    <input
                                                                        type="checkbox"
                                                                        id="checkboxPrimary3"
                                                                        v-model="
                                                                            oPrestamo.f_agua
                                                                        "
                                                                    />
                                                                    <label
                                                                        for="checkboxPrimary3"
                                                                        >Fotocopia
                                                                        de Agua
                                                                    </label>
                                                                </div>
                                                                <span
                                                                    class="error invalid-feedback"
                                                                    v-if="
                                                                        errors.f_agua
                                                                    "
                                                                    v-text="
                                                                        errors
                                                                            .f_agua[0]
                                                                    "
                                                                ></span>
                                                            </div>
                                                            <div
                                                                class="col-md-3"
                                                            >
                                                                <div
                                                                    class="icheck-primary d-inline"
                                                                >
                                                                    <input
                                                                        type="checkbox"
                                                                        id="checkboxPrimary4"
                                                                        v-model="
                                                                            oPrestamo.croquis
                                                                        "
                                                                    />
                                                                    <label
                                                                        for="checkboxPrimary4"
                                                                        >Croquis
                                                                    </label>
                                                                </div>
                                                                <span
                                                                    class="error invalid-feedback"
                                                                    v-if="
                                                                        errors.croquis
                                                                    "
                                                                    v-text="
                                                                        errors
                                                                            .croquis[0]
                                                                    "
                                                                ></span>
                                                            </div>
                                                        </div>
                                                        <div class="row mt-3">
                                                            <div
                                                                class="col-md-12"
                                                            >
                                                                <h5
                                                                    class="w-100 text-center"
                                                                >
                                                                    Papeles de
                                                                    Garantías/Papeles
                                                                    de Autos
                                                                </h5>
                                                            </div>
                                                            <div
                                                                class="col-md-12"
                                                            >
                                                                <label
                                                                    >Nombre del
                                                                    documento</label
                                                                >
                                                            </div>
                                                            <div
                                                                class="col-md-12 form-group"
                                                            >
                                                                <el-input
                                                                    placeholder="Documento 1"
                                                                    :class="{
                                                                        'is-invalid':
                                                                            errors.documento_1,
                                                                    }"
                                                                    v-model="
                                                                        oPrestamo.documento_1
                                                                    "
                                                                    clearable
                                                                >
                                                                </el-input>
                                                                <span
                                                                    class="error invalid-feedback"
                                                                    v-if="
                                                                        errors.documento_1
                                                                    "
                                                                    v-text="
                                                                        errors
                                                                            .documento_1[0]
                                                                    "
                                                                ></span>
                                                            </div>
                                                            <div
                                                                class="col-md-12 form-group"
                                                            >
                                                                <el-input
                                                                    placeholder="Documento 2"
                                                                    :class="{
                                                                        'is-invalid':
                                                                            errors.documento_2,
                                                                    }"
                                                                    v-model="
                                                                        oPrestamo.documento_2
                                                                    "
                                                                    clearable
                                                                >
                                                                </el-input>
                                                                <span
                                                                    class="error invalid-feedback"
                                                                    v-if="
                                                                        errors.documento_2
                                                                    "
                                                                    v-text="
                                                                        errors
                                                                            .documento_2[0]
                                                                    "
                                                                ></span>
                                                            </div>
                                                            <div
                                                                class="col-md-12 form-group"
                                                            >
                                                                <el-input
                                                                    placeholder="Documento 3"
                                                                    :class="{
                                                                        'is-invalid':
                                                                            errors.documento_3,
                                                                    }"
                                                                    v-model="
                                                                        oPrestamo.documento_3
                                                                    "
                                                                    clearable
                                                                >
                                                                </el-input>
                                                                <span
                                                                    class="error invalid-feedback"
                                                                    v-if="
                                                                        errors.documento_3
                                                                    "
                                                                    v-text="
                                                                        errors
                                                                            .documento_3[0]
                                                                    "
                                                                ></span>
                                                            </div>
                                                            <div
                                                                class="col-md-12 form-group"
                                                            >
                                                                <el-input
                                                                    placeholder="Documento 4"
                                                                    :class="{
                                                                        'is-invalid':
                                                                            errors.documento_4,
                                                                    }"
                                                                    v-model="
                                                                        oPrestamo.documento_4
                                                                    "
                                                                    clearable
                                                                >
                                                                </el-input>
                                                                <span
                                                                    class="error invalid-feedback"
                                                                    v-if="
                                                                        errors.documento_4
                                                                    "
                                                                    v-text="
                                                                        errors
                                                                            .documento_4[0]
                                                                    "
                                                                ></span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!-- PASO 2 -->
                                                    <div
                                                        class="col-md-12"
                                                        v-if="paso_actual == 2"
                                                    >
                                                        <div class="row">
                                                            <div
                                                                class="col-md-12 mb-4"
                                                            >
                                                                <label
                                                                    >Registrar
                                                                    como:</label
                                                                >
                                                                <select
                                                                    class="form-control"
                                                                    v-model="
                                                                        oPrestamo.registrar_como
                                                                    "
                                                                >
                                                                    <option
                                                                        v-for="item in [
                                                                            'NUEVO',
                                                                            'ANTIGUO',
                                                                        ]"
                                                                        :key="
                                                                            item
                                                                        "
                                                                        :value="
                                                                            item
                                                                        "
                                                                        :label="
                                                                            item
                                                                        "
                                                                    ></option>
                                                                </select>
                                                            </div>
                                                            <div
                                                                class="col-md-12"
                                                            >
                                                                <h5
                                                                    class="w-100 text-center"
                                                                >
                                                                    Información
                                                                    del Cliente
                                                                </h5>
                                                            </div>
                                                            <div
                                                                class="col-md-8 offset-md-2"
                                                                v-if="
                                                                    oPrestamo.registrar_como ==
                                                                    'ANTIGUO'
                                                                "
                                                            >
                                                                <div
                                                                    class="input-group"
                                                                >
                                                                    <input
                                                                        type="text"
                                                                        class="form-control"
                                                                        placeholder="Ingresar C.I."
                                                                        v-model="
                                                                            txt_ci
                                                                        "
                                                                    />
                                                                    <div
                                                                        class="input-group-append"
                                                                    >
                                                                        <button
                                                                            class="btn btn-primary"
                                                                            type="button"
                                                                            @click="
                                                                                buscarCliente
                                                                            "
                                                                        >
                                                                            <i
                                                                                class="fa fa-search"
                                                                            ></i>
                                                                            Buscar
                                                                        </button>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div
                                                            class="row"
                                                            v-if="
                                                                oPrestamo &&
                                                                oPrestamo.cliente
                                                            "
                                                        >
                                                            <div
                                                                class="form-group col-md-4"
                                                            >
                                                                <label
                                                                    :class="{
                                                                        'text-danger':
                                                                            errors.nombre,
                                                                    }"
                                                                    >Nombre*</label
                                                                >
                                                                <el-input
                                                                    placeholder="Nombre"
                                                                    :class="{
                                                                        'is-invalid':
                                                                            errors.nombre,
                                                                    }"
                                                                    v-model="
                                                                        oPrestamo
                                                                            .cliente
                                                                            .nombre
                                                                    "
                                                                    clearable
                                                                    :readonly="
                                                                        oPrestamo.registrar_como ==
                                                                        'ANTIGUO'
                                                                    "
                                                                >
                                                                </el-input>
                                                                <span
                                                                    class="error invalid-feedback"
                                                                    v-if="
                                                                        errors.nombre
                                                                    "
                                                                    v-text="
                                                                        errors
                                                                            .nombre[0]
                                                                    "
                                                                ></span>
                                                            </div>
                                                            <div
                                                                class="form-group col-md-4"
                                                            >
                                                                <label
                                                                    :class="{
                                                                        'text-danger':
                                                                            errors.segundo_nombre,
                                                                    }"
                                                                    >Segundo
                                                                    Nombre</label
                                                                >
                                                                <el-input
                                                                    placeholder="Segundo Nombre"
                                                                    :class="{
                                                                        'is-invalid':
                                                                            errors.segundo_nombre,
                                                                    }"
                                                                    v-model="
                                                                        oPrestamo
                                                                            .cliente
                                                                            .segundo_nombre
                                                                    "
                                                                    clearable
                                                                    :readonly="
                                                                        oPrestamo.registrar_como ==
                                                                        'ANTIGUO'
                                                                    "
                                                                >
                                                                </el-input>
                                                                <span
                                                                    class="error invalid-feedback"
                                                                    v-if="
                                                                        errors.segundo_nombre
                                                                    "
                                                                    v-text="
                                                                        errors
                                                                            .segundo_nombre[0]
                                                                    "
                                                                ></span>
                                                            </div>
                                                            <div
                                                                class="form-group col-md-4"
                                                            >
                                                                <label
                                                                    :class="{
                                                                        'text-danger':
                                                                            errors.paterno,
                                                                    }"
                                                                    >Ap.
                                                                    Paterno*</label
                                                                >

                                                                <el-input
                                                                    placeholder="Ap. Paterno"
                                                                    :class="{
                                                                        'is-invalid':
                                                                            errors.paterno,
                                                                    }"
                                                                    v-model="
                                                                        oPrestamo
                                                                            .cliente
                                                                            .paterno
                                                                    "
                                                                    clearable
                                                                    :readonly="
                                                                        oPrestamo.registrar_como ==
                                                                        'ANTIGUO'
                                                                    "
                                                                >
                                                                </el-input>
                                                                <span
                                                                    class="error invalid-feedback"
                                                                    v-if="
                                                                        errors.paterno
                                                                    "
                                                                    v-text="
                                                                        errors
                                                                            .paterno[0]
                                                                    "
                                                                ></span>
                                                            </div>
                                                            <div
                                                                class="form-group col-md-4"
                                                            >
                                                                <label
                                                                    :class="{
                                                                        'text-danger':
                                                                            errors.materno,
                                                                    }"
                                                                    >Ap.
                                                                    Materno</label
                                                                >
                                                                <el-input
                                                                    placeholder="Ap. Materno"
                                                                    :class="{
                                                                        'is-invalid':
                                                                            errors.materno,
                                                                    }"
                                                                    v-model="
                                                                        oPrestamo
                                                                            .cliente
                                                                            .materno
                                                                    "
                                                                    clearable
                                                                    :readonly="
                                                                        oPrestamo.registrar_como ==
                                                                        'ANTIGUO'
                                                                    "
                                                                >
                                                                </el-input>
                                                                <span
                                                                    class="error invalid-feedback"
                                                                    v-if="
                                                                        errors.materno
                                                                    "
                                                                    v-text="
                                                                        errors
                                                                            .materno[0]
                                                                    "
                                                                ></span>
                                                            </div>
                                                            <div
                                                                class="form-group col-md-4"
                                                            >
                                                                <label
                                                                    :class="{
                                                                        'text-danger':
                                                                            errors.ci,
                                                                    }"
                                                                    >C.I.*</label
                                                                >
                                                                <el-input
                                                                    placeholder="Número de C.I."
                                                                    :class="{
                                                                        'is-invalid':
                                                                            errors.ci,
                                                                    }"
                                                                    v-model="
                                                                        oPrestamo
                                                                            .cliente
                                                                            .ci
                                                                    "
                                                                    clearable
                                                                    :readonly="
                                                                        oPrestamo.registrar_como ==
                                                                        'ANTIGUO'
                                                                    "
                                                                >
                                                                </el-input>
                                                                <span
                                                                    class="error invalid-feedback"
                                                                    v-if="
                                                                        errors.ci
                                                                    "
                                                                    v-text="
                                                                        errors
                                                                            .ci[0]
                                                                    "
                                                                ></span>
                                                            </div>
                                                            <div
                                                                class="form-group col-md-4"
                                                            >
                                                                <label
                                                                    :class="{
                                                                        'text-danger':
                                                                            errors.ci_exp,
                                                                    }"
                                                                    >Expedido*</label
                                                                >
                                                                <el-select
                                                                    class="w-100 d-block"
                                                                    :class="{
                                                                        'is-invalid':
                                                                            errors.ci_exp,
                                                                    }"
                                                                    v-model="
                                                                        oPrestamo
                                                                            .cliente
                                                                            .ci_exp
                                                                    "
                                                                    clearable
                                                                    :readonly="
                                                                        oPrestamo.registrar_como ==
                                                                        'ANTIGUO'
                                                                    "
                                                                >
                                                                    <el-option
                                                                        v-for="(
                                                                            item,
                                                                            index
                                                                        ) in listExpedido"
                                                                        :key="
                                                                            index
                                                                        "
                                                                        :value="
                                                                            item.value
                                                                        "
                                                                        :label="
                                                                            item.label
                                                                        "
                                                                    >
                                                                    </el-option>
                                                                </el-select>
                                                                <span
                                                                    class="error invalid-feedback"
                                                                    v-if="
                                                                        errors.ci_exp
                                                                    "
                                                                    v-text="
                                                                        errors
                                                                            .ci_exp[0]
                                                                    "
                                                                ></span>
                                                            </div>
                                                            <div
                                                                class="form-group col-md-4"
                                                            >
                                                                <label
                                                                    :class="{
                                                                        'text-danger':
                                                                            errors.cel,
                                                                    }"
                                                                    >Celular*</label
                                                                >
                                                                <el-input
                                                                    placeholder="Celular"
                                                                    :class="{
                                                                        'is-invalid':
                                                                            errors.cel,
                                                                    }"
                                                                    v-model="
                                                                        oPrestamo
                                                                            .cliente
                                                                            .cel
                                                                    "
                                                                    clearable
                                                                    :readonly="
                                                                        oPrestamo.registrar_como ==
                                                                        'ANTIGUO'
                                                                    "
                                                                >
                                                                </el-input>
                                                                <span
                                                                    class="error invalid-feedback"
                                                                    v-if="
                                                                        errors.cel
                                                                    "
                                                                    v-text="
                                                                        errors
                                                                            .cel[0]
                                                                    "
                                                                ></span>
                                                            </div>
                                                            <div
                                                                class="form-group col-md-4"
                                                            >
                                                                <label
                                                                    :class="{
                                                                        'text-danger':
                                                                            errors.fono,
                                                                    }"
                                                                    >Teléfono</label
                                                                >
                                                                <el-input
                                                                    placeholder="Teléfono"
                                                                    :class="{
                                                                        'is-invalid':
                                                                            errors.fono,
                                                                    }"
                                                                    v-model="
                                                                        oPrestamo
                                                                            .cliente
                                                                            .fono
                                                                    "
                                                                    clearable
                                                                    :readonly="
                                                                        oPrestamo.registrar_como ==
                                                                        'ANTIGUO'
                                                                    "
                                                                >
                                                                </el-input>
                                                                <span
                                                                    class="error invalid-feedback"
                                                                    v-if="
                                                                        errors.fono
                                                                    "
                                                                    v-text="
                                                                        errors
                                                                            .fono[0]
                                                                    "
                                                                ></span>
                                                            </div>
                                                            <div
                                                                class="form-group col-md-4"
                                                            >
                                                                <label
                                                                    :class="{
                                                                        'text-danger':
                                                                            errors.edad,
                                                                    }"
                                                                    >Edad*</label
                                                                >
                                                                <input
                                                                    type="number"
                                                                    placeholder="Edad"
                                                                    class="form-control"
                                                                    :class="{
                                                                        'is-invalid':
                                                                            errors.edad,
                                                                    }"
                                                                    v-model="
                                                                        oPrestamo
                                                                            .cliente
                                                                            .edad
                                                                    "
                                                                    :readonly="
                                                                        oPrestamo.registrar_como ==
                                                                        'ANTIGUO'
                                                                    "
                                                                />
                                                                <span
                                                                    class="error invalid-feedback"
                                                                    v-if="
                                                                        errors.edad
                                                                    "
                                                                    v-text="
                                                                        errors
                                                                            .edad[0]
                                                                    "
                                                                ></span>
                                                            </div>
                                                            <div
                                                                class="form-group col-md-4"
                                                            >
                                                                <label
                                                                    :class="{
                                                                        'text-danger':
                                                                            errors.dir,
                                                                    }"
                                                                    >Dirección*</label
                                                                >
                                                                <el-input
                                                                    placeholder="Dirección"
                                                                    :class="{
                                                                        'is-invalid':
                                                                            errors.dir,
                                                                    }"
                                                                    v-model="
                                                                        oPrestamo
                                                                            .cliente
                                                                            .dir
                                                                    "
                                                                    clearable
                                                                    :readonly="
                                                                        oPrestamo.registrar_como ==
                                                                        'ANTIGUO'
                                                                    "
                                                                >
                                                                </el-input>
                                                                <span
                                                                    class="error invalid-feedback"
                                                                    v-if="
                                                                        errors.dir
                                                                    "
                                                                    v-text="
                                                                        errors
                                                                            .dir[0]
                                                                    "
                                                                ></span>
                                                            </div>
                                                            <div
                                                                class="form-group col-md-4"
                                                            >
                                                                <label
                                                                    :class="{
                                                                        'text-danger':
                                                                            errors.referencia,
                                                                    }"
                                                                    >Nombre
                                                                    Referencia*</label
                                                                >
                                                                <el-input
                                                                    placeholder="Nombre Referencia"
                                                                    :class="{
                                                                        'is-invalid':
                                                                            errors.referencia,
                                                                    }"
                                                                    v-model="
                                                                        oPrestamo
                                                                            .cliente
                                                                            .referencia
                                                                    "
                                                                    clearable
                                                                    :readonly="
                                                                        oPrestamo.registrar_como ==
                                                                        'ANTIGUO'
                                                                    "
                                                                >
                                                                </el-input>
                                                                <span
                                                                    class="error invalid-feedback"
                                                                    v-if="
                                                                        errors.referencia
                                                                    "
                                                                    v-text="
                                                                        errors
                                                                            .referencia[0]
                                                                    "
                                                                ></span>
                                                            </div>
                                                            <div
                                                                class="form-group col-md-4"
                                                            >
                                                                <label
                                                                    :class="{
                                                                        'text-danger':
                                                                            errors.cel_ref,
                                                                    }"
                                                                    >Teléfono
                                                                    Referencia*</label
                                                                >
                                                                <el-input
                                                                    placeholder="Teléfono Referencia"
                                                                    :class="{
                                                                        'is-invalid':
                                                                            errors.cel_ref,
                                                                    }"
                                                                    v-model="
                                                                        oPrestamo
                                                                            .cliente
                                                                            .cel_ref
                                                                    "
                                                                    clearable
                                                                    :readonly="
                                                                        oPrestamo.registrar_como ==
                                                                        'ANTIGUO'
                                                                    "
                                                                >
                                                                </el-input>
                                                                <span
                                                                    class="error invalid-feedback"
                                                                    v-if="
                                                                        errors.cel_ref
                                                                    "
                                                                    v-text="
                                                                        errors
                                                                            .cel_ref[0]
                                                                    "
                                                                ></span>
                                                            </div>
                                                            <div
                                                                class="form-group col-md-4"
                                                            >
                                                                <label
                                                                    :class="{
                                                                        'text-danger':
                                                                            errors.parentesco,
                                                                    }"
                                                                    >Parentesco*</label
                                                                >
                                                                <el-input
                                                                    placeholder="Parentesco"
                                                                    :class="{
                                                                        'is-invalid':
                                                                            errors.parentesco,
                                                                    }"
                                                                    v-model="
                                                                        oPrestamo
                                                                            .cliente
                                                                            .parentesco
                                                                    "
                                                                    clearable
                                                                    :readonly="
                                                                        oPrestamo.registrar_como ==
                                                                        'ANTIGUO'
                                                                    "
                                                                >
                                                                </el-input>
                                                                <span
                                                                    class="error invalid-feedback"
                                                                    v-if="
                                                                        errors.parentesco
                                                                    "
                                                                    v-text="
                                                                        errors
                                                                            .parentesco[0]
                                                                    "
                                                                ></span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!-- PASO 3 -->
                                                    <div
                                                        class="col-md-12"
                                                        v-if="paso_actual == 3"
                                                    >
                                                        <div class="row">
                                                            <div
                                                                class="col-md-6 col-md-offset-3 form-group"
                                                            >
                                                                <label
                                                                    >Monto a
                                                                    prestar*</label
                                                                >
                                                                <input
                                                                    type="number"
                                                                    class="form-control"
                                                                    v-model="
                                                                        oPrestamo.monto
                                                                    "
                                                                />
                                                                <span
                                                                    class="error invalid-feedback"
                                                                    v-if="
                                                                        errors.monto
                                                                    "
                                                                    v-text="
                                                                        errors
                                                                            .monto[0]
                                                                    "
                                                                ></span>
                                                            </div>
                                                            <div
                                                                class="col-md-6 col-md-offset-3 form-group"
                                                            >
                                                                <label
                                                                    >Plazo
                                                                    (Cuotas)*</label
                                                                >
                                                                <input
                                                                    type="number"
                                                                    class="form-control"
                                                                    v-model="
                                                                        oPrestamo.plazo
                                                                    "
                                                                />
                                                                <span
                                                                    class="error invalid-feedback"
                                                                    v-if="
                                                                        errors.plazo
                                                                    "
                                                                    v-text="
                                                                        errors
                                                                            .plazo[0]
                                                                    "
                                                                ></span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!-- PASO 4 -->
                                                    <div
                                                        class="col-md-12"
                                                        v-if="paso_actual == 4"
                                                    >
                                                        <div class="row">
                                                            <div
                                                                class="col-md-6 offset-md-3 text-center"
                                                            >
                                                                <span
                                                                    class="btn_descargar"
                                                                    @click="
                                                                        descargarPlanPagos
                                                                    "
                                                                >
                                                                    <img
                                                                        :src="
                                                                            url_principal +
                                                                            '/imgs/listado.png'
                                                                        "
                                                                        alt=""
                                                                    /><br />
                                                                    Descargar
                                                                    plan de
                                                                    pagos
                                                                </span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="card-footer border-top">
                                                <div class="row">
                                                    <div
                                                        class="col-md-12 d-flex justify-content-center"
                                                    >
                                                        <button
                                                            class="btn btn-default mr-1"
                                                            @click="
                                                                cambiaPaso(-1)
                                                            "
                                                        >
                                                            <i
                                                                class="fa fa-arrow-left"
                                                            ></i>
                                                            Anterior
                                                        </button>
                                                        <button
                                                            v-if="
                                                                paso_actual <
                                                                total_pasos
                                                            "
                                                            class="btn btn-primary ml-1"
                                                            @click="
                                                                cambiaPaso(1)
                                                            "
                                                        >
                                                            Siguiente
                                                            <i
                                                                class="fa fa-arrow-right"
                                                            ></i>
                                                        </button>
                                                        <button
                                                            v-if="
                                                                paso_actual ==
                                                                total_pasos
                                                            "
                                                            class="btn btn-primary ml-1"
                                                        >
                                                            Finalizar
                                                            <i
                                                                class="fa fa-flag-checkered"
                                                            ></i>
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
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
            user: JSON.parse(localStorage.getItem("user")),
            permisos:
                typeof localStorage.getItem("permisos") == "string"
                    ? JSON.parse(localStorage.getItem("permisos"))
                    : JSON.parse(localStorage.getItem("permisos")),
            fullscreenLoading: true,
            loadingWindow: Loading.service({
                fullscreen: this.fullscreenLoading,
            }),
            total_pasos: 4,
            paso_actual: 1,
            oPrestamo: {
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
            url_principal: main_url,
            txt_ci: "",
            listExpedido: [
                { value: "LP", label: "La Paz" },
                { value: "CB", label: "Cochabamba" },
                { value: "SC", label: "Santa Cruz" },
                { value: "CH", label: "Chuquisaca" },
                { value: "OR", label: "Oruro" },
                { value: "PT", label: "Potosi" },
                { value: "TJ", label: "Tarija" },
                { value: "PD", label: "Pando" },
                { value: "BN", label: "Beni" },
            ],
            errors: [],
        };
    },
    computed: {
        tituloPaso() {
            let titulo = "";
            switch (this.paso_actual) {
                case 1:
                    titulo = "Requisito de Pre Aprobación";
                    break;
                case 2:
                    titulo = "Formulario de Cliente";
                    break;
                case 3:
                    titulo = "Monto y Plazo";
                    break;
                case 4:
                    titulo = "Plan de Pagos";
                    break;
            }
            return titulo;
        },
    },
    mounted() {
        this.loadingWindow.close();
    },
    methods: {
        buscarCliente() {
            if (this.txt_ci.trim() != "") {
                axios
                    .get(main_url + "/admin/clientes/buscar_ci", {
                        params: {
                            ci: this.txt_ci,
                        },
                    })
                    .then((response) => {
                        this.oPrestamo.cliente = response.data.cliente;
                    })
                    .catch((error) => {
                        if (error.response) {
                            if (
                                error.response.status === 420 ||
                                error.response.status === 419 ||
                                error.response.status === 401
                            ) {
                                window.location = "/";
                            }
                            if (
                                error.response.status === 500 ||
                                error.response.status === 404
                            ) {
                                Swal.fire({
                                    icon: "error",
                                    title: "Error",
                                    html: error.response.data.message,
                                    showConfirmButton: true,
                                    confirmButtonColor: "#1976d2",
                                    confirmButtonText: "Aceptar",
                                });
                            }
                        }
                    });
            } else {
                Swal.fire({
                    icon: "error",
                    title: "Error",
                    html: "Debes ingresar un número de C.I.",
                    showConfirmButton: true,
                    confirmButtonColor: "#1976d2",
                    confirmButtonText: "Aceptar",
                });
            }
        },
        descargarPlanPagos() {
            let config = {
                responseType: "blob",
            };
            axios
                .post(
                    main_url +
                        "/admin/prestamos/simulacion/simulacion_plan_pago",
                    this.oPrestamo,
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
                                confirmButtonColor: "#1976d2",
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
        // PASOS
        irPaso(paso) {
            this.paso_actual = paso;
        },
        cambiaPaso(cambio) {
            this.paso_actual = this.paso_actual + cambio;
            if (this.paso_actual > this.total_pasos) {
                this.paso_actual = this.total_pasos;
            }
            if (this.paso_actual < 1) {
                this.paso_actual = 1;
            }
        },
        cambio() {
            console.log(this.oPrestamo);
        },
    },
};
</script>

<style>
.pasos {
    display: grid;
    grid-template-columns: 1fr 1fr 1fr 1fr;
}

.pasos .paso {
    cursor: pointer;
}

.pasos .paso .nro_paso {
    color: #666666;
}

.pasos .paso .nro_paso {
    border: solid 1px #666666;
    border-radius: 50%;
    padding: 10px 14px;
    height: 40px;
    width: 40px;
}

.pasos .paso.active .nro_paso {
    background-color: var(--principal);
    color: white;
}

.btn_descargar {
    cursor: pointer;
}

.btn_descargar:hover {
    color: var(--principal);
}
.btn_descargar img {
    width: 100px;
}
</style>
