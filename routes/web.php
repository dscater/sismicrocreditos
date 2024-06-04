<?php

use App\Http\Controllers\BackupController;
use App\Http\Controllers\CajaController;
use App\Http\Controllers\CajaMovimientoController;
use App\Http\Controllers\ClienteController;
use App\Http\Controllers\ConfiguracionController;
use App\Http\Controllers\ControlPrestamoController;
use App\Http\Controllers\DesembolsoController;
use App\Http\Controllers\DesembolsoGrupalController;
use App\Http\Controllers\DesembolsoIndividualController;
use App\Http\Controllers\GrupoController;
use App\Http\Controllers\HistorialAccionController;
use App\Http\Controllers\LoginController;
use App\Http\Controllers\PagoController;
use App\Http\Controllers\PrestamoController;
use App\Http\Controllers\PrestamoGrupalController;
use App\Http\Controllers\PrestamoIndividualController;
use App\Http\Controllers\ReporteController;
use App\Http\Controllers\SalarioController;
use App\Http\Controllers\UserController;
use App\Models\Caja;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Route;

// VACIAR CACHE
Route::get('/cache_clear', function () {
    Artisan::call("route:clear");
    Artisan::call("route:cache");
    Artisan::call("view:clear");
    Artisan::call("config:cache");
    Artisan::call("optimize");

    return 'Cache borrada correctamente<br/><a href="' . url("/") . '">Volver al inicio<a>';
});

// LOGIN
Route::post('/login', [LoginController::class, 'login']);
Route::post('/logout', [LoginController::class, 'logout']);
Route::get('/corrige_moras', function () {
    DB::update("UPDATE caja_movimientos SET caja_id=3 WHERE glosa='PAGO MORA'");
    Caja::actualizaSaldos();

    return '<a href="/">Volver al inicio</a>';
});

// CONFIGURACIÓN
Route::get('/configuracion/getConfiguracion', [ConfiguracionController::class, 'getConfiguracion']);

Route::middleware(['auth'])->group(function () {
    Route::post('/configuracion/update', [ConfiguracionController::class, 'update']);

    Route::prefix('admin')->group(function () {
        // BACKUP
        Route::get('/backup/download', [BackupController::class, 'download']);

        // HISTORIAL DE ACCIONES (LOGS)
        Route::get('/historial_accions', [HistorialAccionController::class, 'index'])->name("historial_accions.index");

        // Usuarios
        Route::post('usuarios/updatePassword/{usuario}', [UserController::class, 'updatePassword']);
        Route::get('usuarios/getUsuarioTipo', [UserController::class, 'getUsuarioTipo']);
        Route::get('usuarios/getUsuario/{usuario}', [UserController::class, 'getUsuario']);
        Route::patch('usuarios/asignarConfiguracion/{usuario}', [UserController::class, 'asignarConfiguracion']);
        Route::get('usuarios/userActual', [UserController::class, 'userActual']);
        Route::get('usuarios/getInfoBox', [UserController::class, 'getInfoBox']);
        Route::get('usuarios/getPermisos/{usuario}', [UserController::class, 'getPermisos']);
        Route::get('usuarios/getEncargadosRepresentantes', [UserController::class, 'getEncargadosRepresentantes']);
        Route::post('usuarios/actualizaContrasenia/{usuario}', [UserController::class, 'actualizaContrasenia']);
        Route::post('usuarios/actualizaFoto/{usuario}', [UserController::class, 'actualizaFoto']);
        Route::resource('usuarios', UserController::class)->only([
            'index', 'store', 'update', 'destroy', 'show'
        ]);

        // clientes
        Route::get("clientes/buscar_ci", [ClienteController::class, 'buscar_ci']);
        Route::post('clientes/historial/{cliente}', [ClienteController::class, 'historial']);
        Route::resource('clientes', ClienteController::class)->only([
            'index', 'store', 'update', 'destroy', 'show'
        ]);

        // prestamos
        Route::patch("prestamos/actualizar_fecha_desembolso/{prestamo}", [PrestamoController::class, 'actualizar_fecha_desembolso']);
        Route::patch("prestamos/actualizar_fecha_desembolso_grupal/{grupo}", [PrestamoController::class, 'actualizar_fecha_desembolso_grupal']);
        Route::get("prestamos/get_pago_grupal/{grupo}", [PrestamoController::class, 'get_pago_grupal']);
        Route::get("prestamos/get_pago_grupal_total/{grupo}", [PrestamoController::class, 'get_pago_grupal_total']);
        Route::get("prestamos/get_pago/{prestamo}", [PrestamoController::class, 'get_pago']);
        Route::get("prestamos/get_pago_total/{prestamo}", [PrestamoController::class, 'get_pago_total']);
        Route::post("prestamos/simulacion/plan_pago_grupal", [PrestamoController::class, 'plan_pago_grupal']);
        Route::post("prestamos/simulacion/plan_pago_individual", [PrestamoController::class, 'plan_pago_individual']);
        Route::post("prestamos/plan_pago_individual/plan_reimpresion", [PrestamoController::class, 'plan_reimpresion']);
        Route::post("prestamos/simulacion/plan_pago_simulacion", [PrestamoController::class, 'plan_pago_simulacion']);
        Route::post("prestamos/contrato_grupal/{grupo}", [PrestamoController::class, 'contrato_grupal']);
        Route::post("prestamos/contrato_individual/{prestamo}", [PrestamoController::class, 'contrato_individual']);
        Route::resource('prestamos', PrestamoController::class)->only([
            'index', 'store', 'update', 'destroy', 'show'
        ]);

        // prestamos-individual
        Route::put("prestamos/individual/rechazar/{prestamo}", [PrestamoIndividualController::class, 'rechazar']);
        Route::put("prestamos/individual/aprobar/{prestamo}", [PrestamoIndividualController::class, 'aprobar']);
        Route::get("prestamos/individual/cliente_ci", [PrestamoIndividualController::class, 'cliente_ci']);
        Route::resource('prestamos/individual', PrestamoIndividualController::class)->only([
            'index', 'store', 'update', 'destroy', 'show'
        ]);

        // prestamos-grupal
        Route::put("prestamos/grupal/rechazar/{grupo}", [PrestamoGrupalController::class, 'rechazar']);
        Route::put("prestamos/grupal/aprobar/{grupo}", [PrestamoGrupalController::class, 'aprobar']);
        Route::get("prestamos/grupal/grupo_nombre", [PrestamoGrupalController::class, 'grupo_nombre']);
        Route::resource('prestamos/grupal', PrestamoGrupalController::class)->only([
            'index', 'store', 'update', 'destroy', 'show'
        ]);

        // desembolsos-individual
        Route::post("desembolsos/individual/{prestamo}", [DesembolsoIndividualController::class, 'store']);
        Route::post("desembolsos/individual/comprobante/{prestamo}", [DesembolsoIndividualController::class, 'comprobante']);

        // desembolsos-grupal
        Route::post("desembolsos/grupal/{grupo}", [DesembolsoGrupalController::class, 'store']);
        Route::post("desembolsos/grupal/comprobante/{grupo}", [DesembolsoGrupalController::class, 'comprobante']);

        // cajas
        Route::resource('cajas', CajaController::class)->only([
            'index', 'store', 'update', 'destroy', 'show'
        ]);

        // caja_movimientos
        Route::resource('caja_movimientos', CajaMovimientoController::class)->only([
            'index', 'store', 'update', 'destroy', 'show'
        ]);

        // pagos
        Route::post("pagos/exportacion_individual/{prestamo}", [PagoController::class, 'exportacion_individual']);
        Route::post("pagos/exportacion_grupal/{grupo}", [PagoController::class, 'exportacion_grupal']);
        Route::post("pagos/comprobante/{pago}", [PagoController::class, 'comprobante']);
        Route::post("pagos/store_grupal", [PagoController::class, 'store_grupal']);
        Route::resource('pagos', PagoController::class)->only([
            'index', 'store', 'update', 'destroy', 'show'
        ]);

        // grupos
        Route::resource('grupos', GrupoController::class)->only([
            'index', 'store', 'update', 'destroy', 'show'
        ]);

        // salarios
        Route::resource('salarios', SalarioController::class)->only([
            'index', 'store', 'update', 'destroy', 'show'
        ]);

        // Control Prestamos
        Route::get("control_prestamos/getInfo", [ControlPrestamoController::class, 'getInfo']);

        // REPORTES
        Route::post('reportes/usuarios', [ReporteController::class, 'usuarios']);
        Route::post('reportes/clientes', [ReporteController::class, 'clientes']);
        Route::post('reportes/prestamos_individual', [ReporteController::class, 'prestamos_individual']);
        Route::post('reportes/prestamos_grupal', [ReporteController::class, 'prestamos_grupal']);
        Route::post('reportes/proximos_desembolsos_individual', [ReporteController::class, 'proximos_desembolsos_individual']);
        Route::post('reportes/proximos_desembolsos_grupal', [ReporteController::class, 'proximos_desembolsos_grupal']);
        Route::post('reportes/prestamos_individual_mora', [ReporteController::class, 'prestamos_individual_mora']);
        Route::post('reportes/prestamos_grupal_mora', [ReporteController::class, 'prestamos_grupal_mora']);
        Route::post('reportes/extracto_pagos_individual', [ReporteController::class, 'extracto_pagos_individual']);
        Route::post('reportes/extracto_pagos_grupal', [ReporteController::class, 'extracto_pagos_grupal']);
        Route::post('reportes/prestamos_estado', [ReporteController::class, 'prestamos_estado']);
    });
});

// ADMINISTRACIÓN
Route::get('/{optional?}', function () {
    return view('app');
})->name('base_path')->where('optional', '.*');
