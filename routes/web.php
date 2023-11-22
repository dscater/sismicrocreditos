<?php

use App\Http\Controllers\ActividadContingenciaController;
use App\Http\Controllers\AmenazaSeguridadController;
use App\Http\Controllers\CajaController;
use App\Http\Controllers\CajaMovimientoController;
use App\Http\Controllers\ClienteController;
use App\Http\Controllers\ConfiguracionController;
use App\Http\Controllers\LoginController;
use App\Http\Controllers\PagoController;
use App\Http\Controllers\PlanContingenciaController;
use App\Http\Controllers\PrestamoController;
use App\Http\Controllers\ReporteController;
use App\Http\Controllers\RolFuncionController;
use App\Http\Controllers\UserController;
use App\Models\RolFuncion;
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

// CONFIGURACIÓN
Route::get('/configuracion/getConfiguracion', [ConfiguracionController::class, 'getConfiguracion']);

Route::middleware(['auth'])->group(function () {
    Route::post('/configuracion/update', [ConfiguracionController::class, 'update']);

    Route::prefix('admin')->group(function () {
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

        // plan_contingencias
        Route::resource('plan_contingencias', PlanContingenciaController::class)->only([
            'index', 'store', 'update', 'destroy', 'show'
        ]);

        // clientes
        Route::get("clientes/buscar_ci", [ClienteController::class, 'buscar_ci']);
        Route::resource('clientes', ClienteController::class)->only([
            'index', 'store', 'update', 'destroy', 'show'
        ]);

        // prestamos
        Route::resource('prestamos', PrestamoController::class)->only([
            'index', 'store', 'update', 'destroy', 'show'
        ]);

        // cajas
        Route::resource('cajas', CajaController::class)->only([
            'index', 'store', 'update', 'destroy', 'show'
        ]);

        // caja_movimientos
        Route::resource('caja_movimientos', CajaMovimientoController::class)->only([
            'index', 'store', 'update', 'destroy', 'show'
        ]);

        // pagos
        Route::resource('pagos', PagoController::class)->only([
            'index', 'store', 'update', 'destroy', 'show'
        ]);

        // REPORTES
        Route::post('reportes/usuarios', [ReporteController::class, 'usuarios']);
    });
});

// ADMINISTRACIÓN
Route::get('/{optional?}', function () {
    return view('app');
})->name('base_path')->where('optional', '.*');
