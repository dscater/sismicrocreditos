<template>
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
                                    >Requisito de Pre Aprobación</span
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
                                <span class="txt_paso">Monto y Plazo</span>
                            </div>
                            <div
                                class="paso"
                                :class="{
                                    active: paso_actual == 4,
                                }"
                                @click="irPaso(4)"
                            >
                                <span class="nro_paso">4</span>
                                <span class="txt_paso">Plan de Pagos</span>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12 mt-3">
                        <div class="card">
                            <div class="card-header bg-success">
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
                                            <div class="col-md-3">
                                                <div
                                                    class="icheck-warning d-inline"
                                                >
                                                    <input
                                                        type="checkbox"
                                                        id="checkboxPrimary1"
                                                        v-model="prestamo.f_ci"
                                                    />
                                                    <label
                                                        for="checkboxPrimary1"
                                                        >Fotocopia de C.I.
                                                    </label>
                                                </div>
                                                <span
                                                    class="error invalid-feedback d-block"
                                                    v-if="
                                                        errors?.[
                                                            'f_ci_' +
                                                                index_prestamo
                                                        ]
                                                    "
                                                    v-html="
                                                        errors?.[
                                                            'f_ci_' +
                                                                index_prestamo
                                                        ][0]
                                                    "
                                                ></span>
                                            </div>
                                            <div class="col-md-3">
                                                <div
                                                    class="icheck-warning d-inline"
                                                >
                                                    <input
                                                        type="checkbox"
                                                        id="checkboxPrimary2"
                                                        v-model="prestamo.f_luz"
                                                    />
                                                    <label
                                                        for="checkboxPrimary2"
                                                        >Fotocopia de Luz
                                                    </label>
                                                </div>
                                                <span
                                                    class="error invalid-feedback d-block"
                                                    v-if="
                                                        errors?.[
                                                            'f_luz_' +
                                                                index_prestamo
                                                        ]
                                                    "
                                                    v-html="
                                                        errors?.[
                                                            'f_luz_' +
                                                                index_prestamo
                                                        ][0]
                                                    "
                                                ></span>
                                            </div>
                                            <div class="col-md-3">
                                                <div
                                                    class="icheck-warning d-inline"
                                                >
                                                    <input
                                                        type="checkbox"
                                                        id="checkboxPrimary3"
                                                        v-model="
                                                            prestamo.f_agua
                                                        "
                                                    />
                                                    <label
                                                        for="checkboxPrimary3"
                                                        >Fotocopia de Agua
                                                    </label>
                                                </div>
                                                <span
                                                    class="error invalid-feedback d-block"
                                                    v-if="
                                                        errors?.[
                                                            'f_agua_' +
                                                                index_prestamo
                                                        ]
                                                    "
                                                    v-html="
                                                        errors?.[
                                                            'f_agua_' +
                                                                index_prestamo
                                                        ][0]
                                                    "
                                                ></span>
                                            </div>
                                            <div class="col-md-3">
                                                <div
                                                    class="icheck-warning d-inline"
                                                >
                                                    <input
                                                        type="checkbox"
                                                        id="checkboxPrimary4"
                                                        v-model="
                                                            prestamo.croquis
                                                        "
                                                    />
                                                    <label
                                                        for="checkboxPrimary4"
                                                        >Croquis
                                                    </label>
                                                </div>
                                                <span
                                                    class="error invalid-feedback d-block"
                                                    v-if="
                                                        errors?.[
                                                            'croquis_' +
                                                                index_prestamo
                                                        ]
                                                    "
                                                    v-html="
                                                        errors?.[
                                                            'croquis_' +
                                                                index_prestamo
                                                        ][0]
                                                    "
                                                ></span>
                                            </div>
                                        </div>
                                        <div class="row mt-3">
                                            <div class="col-md-12">
                                                <h5 class="w-100 text-center">
                                                    Papeles de Garantías/Papeles
                                                    de Autos
                                                </h5>
                                            </div>
                                            <div class="col-md-12">
                                                <label
                                                    >Nombre del documento</label
                                                >
                                            </div>
                                            <div class="col-md-12 form-group">
                                                <div class="input-group">
                                                    <input
                                                        placeholder="Documento 1"
                                                        class="form-control"
                                                        :class="{
                                                            'is-invalid':
                                                                errors.documento_1,
                                                        }"
                                                        v-model="
                                                            prestamo.documento_1
                                                        "
                                                        clearable
                                                    />
                                                    <div
                                                        class="input-group-prepend"
                                                    >
                                                        <div
                                                            class="contenedor_file"
                                                        >
                                                            <input
                                                                type="file"
                                                            />
                                                        </div>
                                                    </div>
                                                </div>
                                                <span
                                                    class="error invalid-feedback d-block"
                                                    v-if="
                                                        errors?.[
                                                            'documento_1_' +
                                                                index_prestamo
                                                        ]
                                                    "
                                                    v-html="
                                                        errors?.[
                                                            'documento_1_' +
                                                                index_prestamo
                                                        ][0]
                                                    "
                                                ></span>
                                            </div>
                                            <div class="col-md-12 form-group">
                                                <div class="input-group">
                                                    <input
                                                        placeholder="Documento 2"
                                                        class="form-control"
                                                        :class="{
                                                            'is-invalid':
                                                                errors.documento_2,
                                                        }"
                                                        v-model="
                                                            prestamo.documento_2
                                                        "
                                                        clearable
                                                    />
                                                    <div
                                                        class="input-group-prepend"
                                                    >
                                                        <div
                                                            class="contenedor_file"
                                                        >
                                                            <input
                                                                type="file"
                                                            />
                                                        </div>
                                                    </div>
                                                </div>
                                                <span
                                                    class="error invalid-feedback d-block"
                                                    v-if="
                                                        errors?.[
                                                            'documento_2_' +
                                                                index_prestamo
                                                        ]
                                                    "
                                                    v-html="
                                                        errors?.[
                                                            'documento_2_' +
                                                                index_prestamo
                                                        ][0]
                                                    "
                                                ></span>
                                            </div>
                                            <div class="col-md-12 form-group">
                                                <div class="input-group">
                                                    <input
                                                        placeholder="Documento 3"
                                                        class="form-control"
                                                        :class="{
                                                            'is-invalid':
                                                                errors.documento_3,
                                                        }"
                                                        v-model="
                                                            prestamo.documento_3
                                                        "
                                                        clearable
                                                    />
                                                    <div
                                                        class="input-group-prepend"
                                                    >
                                                        <div
                                                            class="contenedor_file"
                                                        >
                                                            <input
                                                                type="file"
                                                            />
                                                        </div>
                                                    </div>
                                                </div>
                                                <span
                                                    class="error invalid-feedback d-block"
                                                    v-if="
                                                        errors?.[
                                                            'documento_3_' +
                                                                index_prestamo
                                                        ]
                                                    "
                                                    v-html="
                                                        errors?.[
                                                            'documento_3_' +
                                                                index_prestamo
                                                        ][0]
                                                    "
                                                ></span>
                                            </div>
                                            <div class="col-md-12 form-group">
                                                <div class="input-group">
                                                    <input
                                                        placeholder="Documento 4"
                                                        class="form-control"
                                                        :class="{
                                                            'is-invalid':
                                                                errors.documento_4,
                                                        }"
                                                        v-model="
                                                            prestamo.documento_4
                                                        "
                                                        clearable
                                                    />
                                                    <div
                                                        class="input-group-prepend"
                                                    >
                                                        <div
                                                            class="contenedor_file"
                                                        >
                                                            <input
                                                                type="file"
                                                            />
                                                        </div>
                                                    </div>
                                                </div>
                                                <span
                                                    class="error invalid-feedback d-block"
                                                    v-if="
                                                        errors?.[
                                                            'documento_4_' +
                                                                index_prestamo
                                                        ]
                                                    "
                                                    v-html="
                                                        errors?.[
                                                            'documento_4_' +
                                                                index_prestamo
                                                        ][0]
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
                                            <div class="col-md-12 mb-4">
                                                <label>Registrar como:</label>
                                                <select
                                                    class="form-control"
                                                    v-model="
                                                        prestamo.registrar_como
                                                    "
                                                >
                                                    <option
                                                        v-for="item in [
                                                            'NUEVO',
                                                            'ANTIGUO',
                                                        ]"
                                                        :key="item"
                                                        :value="item"
                                                        :label="item"
                                                    ></option>
                                                </select>
                                            </div>
                                            <div class="col-md-12">
                                                <h5 class="w-100 text-center">
                                                    Información del Cliente
                                                </h5>
                                            </div>
                                            <div
                                                class="col-md-8 offset-md-2"
                                                v-if="
                                                    prestamo.registrar_como ==
                                                    'ANTIGUO'
                                                "
                                            >
                                                <div class="input-group">
                                                    <input
                                                        type="text"
                                                        class="form-control"
                                                        placeholder="Ingresar C.I."
                                                        v-model="txt_ci"
                                                    />
                                                    <div
                                                        class="input-group-append"
                                                    >
                                                        <button
                                                            class="btn btn-success"
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
                                            v-if="prestamo && prestamo.cliente"
                                        >
                                            <div class="form-group col-md-4">
                                                <label
                                                    :class="{
                                                        'text-danger':
                                                            errors?.[
                                                                'nombre_' +
                                                                    index_prestamo
                                                            ],
                                                    }"
                                                    >Nombre*</label
                                                >
                                                <el-input
                                                    placeholder="Nombre"
                                                    :class="{
                                                        'is-invalid':
                                                            errors?.[
                                                                'nombre_' +
                                                                    index_prestamo
                                                            ],
                                                    }"
                                                    v-model="
                                                        prestamo.cliente.nombre
                                                    "
                                                    clearable
                                                    :readonly="
                                                        prestamo.registrar_como ==
                                                        'ANTIGUO'
                                                    "
                                                >
                                                </el-input>
                                                <span
                                                    class="error invalid-feedback d-block"
                                                    v-if="
                                                        errors?.[
                                                            'nombre_' +
                                                                index_prestamo
                                                        ]
                                                    "
                                                    v-html="
                                                        errors?.[
                                                            'nombre_' +
                                                                index_prestamo
                                                        ][0]
                                                    "
                                                ></span>
                                            </div>
                                            <div class="form-group col-md-4">
                                                <label
                                                    :class="{
                                                        'text-danger':
                                                            errors?.[
                                                                'segundo_nombre_' +
                                                                    index_prestamo
                                                            ],
                                                    }"
                                                    >Segundo Nombre</label
                                                >
                                                <el-input
                                                    placeholder="Segundo Nombre"
                                                    :class="{
                                                        'is-invalid':
                                                            errors?.[
                                                                'segundo_nombre_' +
                                                                    index_prestamo
                                                            ],
                                                    }"
                                                    v-model="
                                                        prestamo.cliente
                                                            .segundo_nombre
                                                    "
                                                    clearable
                                                    :readonly="
                                                        prestamo.registrar_como ==
                                                        'ANTIGUO'
                                                    "
                                                >
                                                </el-input>
                                                <span
                                                    class="error invalid-feedback d-block"
                                                    v-if="
                                                        errors?.[
                                                            'segundo_nombre_' +
                                                                index_prestamo
                                                        ]
                                                    "
                                                    v-html="
                                                        errors?.[
                                                            'segundo_nombre_' +
                                                                index_prestamo
                                                        ][0]
                                                    "
                                                ></span>
                                            </div>
                                            <div class="form-group col-md-4">
                                                <label
                                                    :class="{
                                                        'text-danger':
                                                            errors?.[
                                                                'paterno_' +
                                                                    index_prestamo
                                                            ],
                                                    }"
                                                    >Ap. Paterno*</label
                                                >

                                                <el-input
                                                    placeholder="Ap. Paterno"
                                                    :class="{
                                                        'is-invalid':
                                                            errors?.[
                                                                'paterno_' +
                                                                    index_prestamo
                                                            ],
                                                    }"
                                                    v-model="
                                                        prestamo.cliente.paterno
                                                    "
                                                    clearable
                                                    :readonly="
                                                        prestamo.registrar_como ==
                                                        'ANTIGUO'
                                                    "
                                                >
                                                </el-input>
                                                <span
                                                    class="error invalid-feedback d-block"
                                                    v-if="
                                                        errors?.[
                                                            'paterno_' +
                                                                index_prestamo
                                                        ]
                                                    "
                                                    v-html="
                                                        errors?.[
                                                            'paterno_' +
                                                                index_prestamo
                                                        ][0]
                                                    "
                                                ></span>
                                            </div>
                                            <div class="form-group col-md-4">
                                                <label
                                                    :class="{
                                                        'text-danger':
                                                            errors?.[
                                                                'materno_' +
                                                                    index_prestamo
                                                            ],
                                                    }"
                                                    >Ap. Materno</label
                                                >
                                                <el-input
                                                    placeholder="Ap. Materno"
                                                    :class="{
                                                        'is-invalid':
                                                            errors?.[
                                                                'materno_' +
                                                                    index_prestamo
                                                            ],
                                                    }"
                                                    v-model="
                                                        prestamo.cliente.materno
                                                    "
                                                    clearable
                                                    :readonly="
                                                        prestamo.registrar_como ==
                                                        'ANTIGUO'
                                                    "
                                                >
                                                </el-input>
                                                <span
                                                    class="error invalid-feedback d-block"
                                                    v-if="
                                                        errors?.[
                                                            'materno_' +
                                                                index_prestamo
                                                        ]
                                                    "
                                                    v-html="
                                                        errors?.[
                                                            'materno_' +
                                                                index_prestamo
                                                        ][0]
                                                    "
                                                ></span>
                                            </div>
                                            <div class="form-group col-md-4">
                                                <label
                                                    :class="{
                                                        'text-danger':
                                                            errors?.[
                                                                'ci_' +
                                                                    index_prestamo
                                                            ],
                                                    }"
                                                    >C.I.*</label
                                                >
                                                <input
                                                    type="number"
                                                    placeholder="Número de C.I."
                                                    class="form-control"
                                                    :class="{
                                                        'is-invalid':
                                                            errors?.[
                                                                'ci_' +
                                                                    index_prestamo
                                                            ],
                                                    }"
                                                    v-model="
                                                        prestamo.cliente.ci
                                                    "
                                                    clearable
                                                    :readonly="
                                                        prestamo.registrar_como ==
                                                        'ANTIGUO'
                                                    "
                                                />
                                                <span
                                                    class="error invalid-feedback d-block"
                                                    v-if="
                                                        errors?.[
                                                            'ci_' +
                                                                index_prestamo
                                                        ]
                                                    "
                                                    v-html="
                                                        errors?.[
                                                            'ci_' +
                                                                index_prestamo
                                                        ][0]
                                                    "
                                                ></span>
                                            </div>
                                            <div class="form-group col-md-4">
                                                <label
                                                    :class="{
                                                        'text-danger':
                                                            errors?.[
                                                                'ci_exp_' +
                                                                    index_prestamo
                                                            ],
                                                    }"
                                                    >Expedido*</label
                                                >
                                                <el-select
                                                    class="w-100 d-block"
                                                    :class="{
                                                        'is-invalid':
                                                            errors?.[
                                                                'ci_exp_' +
                                                                    index_prestamo
                                                            ],
                                                    }"
                                                    v-model="
                                                        prestamo.cliente.ci_exp
                                                    "
                                                    clearable
                                                    :readonly="
                                                        prestamo.registrar_como ==
                                                        'ANTIGUO'
                                                    "
                                                >
                                                    <el-option
                                                        v-for="(
                                                            item, index
                                                        ) in listExpedido"
                                                        :key="index"
                                                        :value="item.value"
                                                        :label="item.label"
                                                    >
                                                    </el-option>
                                                </el-select>
                                                <span
                                                    class="error invalid-feedback d-block"
                                                    v-if="
                                                        errors?.[
                                                            'ci_exp_' +
                                                                index_prestamo
                                                        ]
                                                    "
                                                    v-html="
                                                        errors?.[
                                                            'ci_exp_' +
                                                                index_prestamo
                                                        ][0]
                                                    "
                                                ></span>
                                            </div>
                                            <div class="form-group col-md-4">
                                                <label
                                                    :class="{
                                                        'text-danger':
                                                            errors?.[
                                                                'cel_' +
                                                                    index_prestamo
                                                            ],
                                                    }"
                                                    >Celular*</label
                                                >
                                                <input
                                                    type="number"
                                                    class="form-control"
                                                    placeholder="Celular"
                                                    :class="{
                                                        'is-invalid':
                                                            errors?.[
                                                                'cel_' +
                                                                    index_prestamo
                                                            ],
                                                    }"
                                                    v-model="
                                                        prestamo.cliente.cel
                                                    "
                                                    clearable
                                                    :readonly="
                                                        prestamo.registrar_como ==
                                                        'ANTIGUO'
                                                    "
                                                />
                                                <span
                                                    class="error invalid-feedback d-block"
                                                    v-if="
                                                        errors?.[
                                                            'cel_' +
                                                                index_prestamo
                                                        ]
                                                    "
                                                    v-html="
                                                        errors?.[
                                                            'cel_' +
                                                                index_prestamo
                                                        ][0]
                                                    "
                                                ></span>
                                            </div>
                                            <div class="form-group col-md-4">
                                                <label
                                                    :class="{
                                                        'text-danger':
                                                            errors?.[
                                                                'fono_' +
                                                                    index_prestamo
                                                            ],
                                                    }"
                                                    >Teléfono</label
                                                >
                                                <input
                                                    type="number"
                                                    placeholder="Teléfono"
                                                    class="form-control"
                                                    :class="{
                                                        'is-invalid':
                                                            errors?.[
                                                                'fono_' +
                                                                    index_prestamo
                                                            ],
                                                    }"
                                                    v-model="
                                                        prestamo.cliente.fono
                                                    "
                                                    clearable
                                                    :readonly="
                                                        prestamo.registrar_como ==
                                                        'ANTIGUO'
                                                    "
                                                />
                                                <span
                                                    class="error invalid-feedback d-block"
                                                    v-if="
                                                        errors?.[
                                                            'fono_' +
                                                                index_prestamo
                                                        ]
                                                    "
                                                    v-html="
                                                        errors?.[
                                                            'fono_' +
                                                                index_prestamo
                                                        ][0]
                                                    "
                                                ></span>
                                            </div>
                                            <div class="form-group col-md-4">
                                                <label
                                                    :class="{
                                                        'text-danger':
                                                            errors?.[
                                                                'edad_' +
                                                                    index_prestamo
                                                            ],
                                                    }"
                                                    >Edad*</label
                                                >
                                                <input
                                                    type="number"
                                                    placeholder="Edad"
                                                    class="form-control"
                                                    :class="{
                                                        'is-invalid':
                                                            errors?.[
                                                                'edad_' +
                                                                    index_prestamo
                                                            ],
                                                    }"
                                                    v-model="
                                                        prestamo.cliente.edad
                                                    "
                                                    :readonly="
                                                        prestamo.registrar_como ==
                                                        'ANTIGUO'
                                                    "
                                                />
                                                <span
                                                    class="error invalid-feedback d-block"
                                                    v-if="
                                                        errors?.[
                                                            'edad_' +
                                                                index_prestamo
                                                        ]
                                                    "
                                                    v-html="
                                                        errors?.[
                                                            'edad_' +
                                                                index_prestamo
                                                        ][0]
                                                    "
                                                ></span>
                                            </div>
                                            <div class="form-group col-md-4">
                                                <label
                                                    :class="{
                                                        'text-danger':
                                                            errors?.[
                                                                'dir_' +
                                                                    index_prestamo
                                                            ],
                                                    }"
                                                    >Dirección*</label
                                                >
                                                <el-input
                                                    placeholder="Dirección"
                                                    :class="{
                                                        'is-invalid':
                                                            errors?.[
                                                                'dir_' +
                                                                    index_prestamo
                                                            ],
                                                    }"
                                                    v-model="
                                                        prestamo.cliente.dir
                                                    "
                                                    clearable
                                                    :readonly="
                                                        prestamo.registrar_como ==
                                                        'ANTIGUO'
                                                    "
                                                >
                                                </el-input>
                                                <span
                                                    class="error invalid-feedback d-block"
                                                    v-if="
                                                        errors?.[
                                                            'dir_' +
                                                                index_prestamo
                                                        ]
                                                    "
                                                    v-html="
                                                        errors?.[
                                                            'dir_' +
                                                                index_prestamo
                                                        ][0]
                                                    "
                                                ></span>
                                            </div>
                                            <div class="form-group col-md-4">
                                                <label
                                                    :class="{
                                                        'text-danger':
                                                            errors?.[
                                                                'referencia_' +
                                                                    index_prestamo
                                                            ],
                                                    }"
                                                    >Nombre Referencia*</label
                                                >
                                                <el-input
                                                    placeholder="Nombre Referencia"
                                                    :class="{
                                                        'is-invalid':
                                                            errors?.[
                                                                'referencia_' +
                                                                    index_prestamo
                                                            ],
                                                    }"
                                                    v-model="
                                                        prestamo.cliente
                                                            .referencia
                                                    "
                                                    clearable
                                                    :readonly="
                                                        prestamo.registrar_como ==
                                                        'ANTIGUO'
                                                    "
                                                >
                                                </el-input>
                                                <span
                                                    class="error invalid-feedback d-block"
                                                    v-if="
                                                        errors?.[
                                                            'referencia_' +
                                                                index_prestamo
                                                        ]
                                                    "
                                                    v-html="
                                                        errors?.[
                                                            'referencia_' +
                                                                index_prestamo
                                                        ][0]
                                                    "
                                                ></span>
                                            </div>
                                            <div class="form-group col-md-4">
                                                <label
                                                    :class="{
                                                        'text-danger':
                                                            errors?.[
                                                                'cel_ref_' +
                                                                    index_prestamo
                                                            ],
                                                    }"
                                                    >Teléfono Referencia*</label
                                                >
                                                <el-input
                                                    placeholder="Teléfono Referencia"
                                                    :class="{
                                                        'is-invalid':
                                                            errors?.[
                                                                'cel_ref_' +
                                                                    index_prestamo
                                                            ],
                                                    }"
                                                    v-model="
                                                        prestamo.cliente.cel_ref
                                                    "
                                                    clearable
                                                    :readonly="
                                                        prestamo.registrar_como ==
                                                        'ANTIGUO'
                                                    "
                                                >
                                                </el-input>
                                                <span
                                                    class="error invalid-feedback d-block"
                                                    v-if="
                                                        errors?.[
                                                            'cel_ref_' +
                                                                index_prestamo
                                                        ]
                                                    "
                                                    v-html="
                                                        errors?.[
                                                            'cel_ref_' +
                                                                index_prestamo
                                                        ][0]
                                                    "
                                                ></span>
                                            </div>
                                            <div class="form-group col-md-4">
                                                <label
                                                    :class="{
                                                        'text-danger':
                                                            errors?.[
                                                                'parentesco_' +
                                                                    index_prestamo
                                                            ],
                                                    }"
                                                    >Parentesco*</label
                                                >
                                                <el-input
                                                    placeholder="Parentesco"
                                                    :class="{
                                                        'is-invalid':
                                                            errors?.[
                                                                'parentesco_' +
                                                                    index_prestamo
                                                            ],
                                                    }"
                                                    v-model="
                                                        prestamo.cliente
                                                            .parentesco
                                                    "
                                                    clearable
                                                    :readonly="
                                                        prestamo.registrar_como ==
                                                        'ANTIGUO'
                                                    "
                                                >
                                                </el-input>
                                                <span
                                                    class="error invalid-feedback d-block"
                                                    v-if="
                                                        errors?.[
                                                            'parentesco_' +
                                                                index_prestamo
                                                        ]
                                                    "
                                                    v-html="
                                                        errors?.[
                                                            'parentesco_' +
                                                                index_prestamo
                                                        ][0]
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
                                                <label>Monto a prestar*</label>
                                                <input
                                                    type="number"
                                                    class="form-control"
                                                    v-model="prestamo.monto"
                                                    @change="modificaMonto"
                                                    @keyup="modificaMonto"
                                                />
                                                <span
                                                    class="error invalid-feedback d-block"
                                                    v-if="
                                                        errors?.[
                                                            'monto_' +
                                                                index_prestamo
                                                        ]
                                                    "
                                                    v-html="
                                                        errors?.[
                                                            'monto_' +
                                                                index_prestamo
                                                        ][0]
                                                    "
                                                ></span>
                                            </div>
                                            <div
                                                class="col-md-6 col-md-offset-3 form-group"
                                            >
                                                <label>Plazo (Cuotas)*</label>
                                                <input
                                                    type="number"
                                                    class="form-control"
                                                    v-model="prestamo.plazo"
                                                    readonly
                                                />
                                                <span
                                                    class="error invalid-feedback d-block"
                                                    v-if="
                                                        errors?.[
                                                            'plazo_' +
                                                                index_prestamo
                                                        ]
                                                    "
                                                    v-html="
                                                        errors?.[
                                                            'plazo_' +
                                                                index_prestamo
                                                        ][0]
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
                                                    @click="descargarPlanPagos"
                                                >
                                                    <img
                                                        :src="
                                                            url_principal +
                                                            '/imgs/listado.png'
                                                        "
                                                        alt=""
                                                    /><br />
                                                    Descargar plan de pagos
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
                                            @click="cambiaPaso(-1)"
                                        >
                                            <i class="fa fa-arrow-left"></i>
                                            Anterior
                                        </button>
                                        <button
                                            v-if="paso_actual < total_pasos"
                                            class="btn btn-success ml-1"
                                            @click="cambiaPaso(1)"
                                        >
                                            Siguiente
                                            <i class="fa fa-arrow-right"></i>
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
</template>
<script>
export default {
    props: {
        errores: null,
        plazo_prestamos: {
            type: Number,
            default: 12,
        },
        index_prestamo: {
            type: Number,
            default: 0,
        },
        prestamo: {
            type: Object,
            default: {
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
        },
    },
    data() {
        return {
            total_pasos: 4,
            paso_actual: 1,
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
            errors: this.errores,
            enviando: false,
        };
    },
    watch: {
        errores(newVal) {
            this.errors = newVal;
        },
        plazo_prestamos(newVal) {
            this.prestamo.plazo = newVal;
        },
    },
    computed: {
        txtBtnFinalizar() {
            if (this.enviando) {
                return '<i class="fa fa-spinner fa-spin"></i> Enviando...';
            }
            return 'Finalizar <iclass="fa fa-flag-checkered"></iclass=>';
        },
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
    mounted() {},
    methods: {
        modificaMonto() {
            // this.$emit("actualiza_monto", this.index_prestamo, this.prestamo.monto);
        },
        buscarCliente() {
            if (this.txt_ci.trim() != "") {
                axios
                    .get(main_url + "/admin/clientes/buscar_ci", {
                        params: {
                            ci: this.txt_ci,
                        },
                    })
                    .then((response) => {
                        this.prestamo.cliente = response.data.cliente;
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
                                    confirmButtonColor: "#339431",
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
                    confirmButtonColor: "#339431",
                    confirmButtonText: "Aceptar",
                });
            }
        },
        descargarPlanPagos() {
            let config = {
                responseType: "blob",
            };
            this.prestamo["valida_monto"] = false;
            axios
                .post(
                    main_url +
                        "/admin/prestamos/simulacion/plan_pago_individual",
                    this.prestamo,
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
                                confirmButtonColor: "#339431",
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
            console.log(this.prestamo);
        },
    },
};
</script>
