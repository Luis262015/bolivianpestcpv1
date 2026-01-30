<?php

use App\Http\Controllers\AgendaController;
use App\Http\Controllers\BiologicosController;
use App\Http\Controllers\CategoriasController;
use App\Http\Controllers\CertificadosController;
use App\Http\Controllers\ComprasController;
use App\Http\Controllers\ConfigsController;
use App\Http\Controllers\ContratoController;
use App\Http\Controllers\CotizacionController;
use App\Http\Controllers\CronogramaController;
use App\Http\Controllers\CuentasPorCobrarController;
use App\Http\Controllers\CuentasPorPagarController;
use App\Http\Controllers\DocumentosController;
use App\Http\Controllers\EmpresaController;
use App\Http\Controllers\EppsController;
use App\Http\Controllers\EspeciesController;
use App\Http\Controllers\EstadosController;
use App\Http\Controllers\EtiquetasController;
use App\Http\Controllers\GastosController;
use App\Http\Controllers\GastosExController;
use App\Http\Controllers\GastosFinController;
use App\Http\Controllers\GastosOpController;
use App\Http\Controllers\HojaTecnicaController;
use App\Http\Controllers\InformesController;
use App\Http\Controllers\IngresosController;
use App\Http\Controllers\InventarioController;
use App\Http\Controllers\MapaController;
use App\Http\Controllers\MarcasController;
use App\Http\Controllers\MetodosController;
use App\Http\Controllers\ProductosController;
use App\Http\Controllers\ProductoVencimientoController;
use App\Http\Controllers\ProteccionesController;
use App\Http\Controllers\ProveedoresController;
use App\Http\Controllers\RetirosController;
use App\Http\Controllers\RolePermissionController;
use App\Http\Controllers\SeguimientoController;
use App\Http\Controllers\SignosController;
use App\Http\Controllers\SubcategoriasController;
use App\Http\Controllers\TiposController;
use App\Http\Controllers\TrampaSeguimientoController;
use App\Http\Controllers\UnidadesController;
use App\Http\Controllers\UsersController;
use App\Http\Controllers\VentasController;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;
use Laravel\Fortify\Features;

Route::get('/', function () {
    return Inertia::render('landing', [
        'canRegister' => Features::enabled(Features::registration()),
    ]);
})->name('home');

// ------ PRUEBAS DE LANDING --------------------
Route::get('/landing', function () {
    return Inertia::render('landing');
})->name('landing');

// ------ PRUEBAS DE MAPA --------------------
Route::get('/drawing', function () {
    return Inertia::render('drawing');
})->name('drawing');

// ------ PRUEBAS DE CALENDARIO --------------------
Route::get('/calendar', function () {
    return Inertia::render('calendar');
})->name('calendar');


Route::middleware(['auth', 'verified'])->group(function () {
    Route::get('dashboard', function () {
        return Inertia::render('dashboard');
    })->name('dashboard');

    /// ********** EMPRESAS *****************
    Route::post('/empresas/{id}/certificados', [EmpresaController::class, 'certificados'])->name('empresas.certificados');
    Route::get('/empresas/{id}/certificadopdf', [EmpresaController::class, 'certificadopdf'])->name('empresas.certificadopdf');
    Route::get('/empresas/certificadoultimo', [EmpresaController::class, 'certificadoultimo'])->name('empresas.certificadoultimo');
    Route::get('/empresas/{empresa}/almacenes', [EmpresaController::class, 'getByEmpresa']);
    Route::resource('empresas', EmpresaController::class);
    Route::get('/contratos/{id}/pdf', [ContratoController::class, 'pdf'])->name('contratos.pdf');
    Route::resource('contratos', ContratoController::class);
    Route::get('/cotizaciones/{id}/pdf', [CotizacionController::class, 'pdf'])->name('cotizaciones.pdf');
    Route::resource('cotizaciones', CotizacionController::class);
    Route::resource('cronogramas', CronogramaController::class);
    Route::resource('mapas', MapaController::class);
    Route::get('/seguimientos/{id}/pdf', [SeguimientoController::class, 'pdf'])->name('seguimientos.pdf');
    Route::get('/seguimientos/{id}/trampas', [SeguimientoController::class, 'trampas'])->name('seguimientos.trampas');
    Route::get('/seguimientos/especies', [SeguimientoController::class, 'especies'])->name('seguimientos.especies');
    Route::resource('seguimientos', SeguimientoController::class);
    Route::get('/trampaseguimientos/{id}/trampas', [TrampaSeguimientoController::class, 'trampas'])->name('trampaseguimientos.trampas');
    Route::get('/trampaseguimientos/{id}/pdf', [TrampaSeguimientoController::class, 'pdf'])->name('trampaseguimientos.pdf');
    Route::get('/trampaseguimientos/especies', [TrampaSeguimientoController::class, 'especies'])->name('trampaseguimientos.especies');
    Route::resource('trampaseguimientos', TrampaSeguimientoController::class);
    Route::resource('biologicos', BiologicosController::class);
    Route::resource('epps', EppsController::class);
    Route::resource('metodos', MetodosController::class);
    Route::resource('protecciones', ProteccionesController::class);
    Route::resource('signos', SignosController::class);
    Route::resource('tipos', TiposController::class);
    Route::resource('especies', EspeciesController::class);
    Route::resource('unidades', UnidadesController::class);
    Route::get('/informes/obtener', [InformesController::class, 'obtenerEstado'])->name('estados.obtener');
    // Route::get('/informes/empresas', [InformesController::class, 'getEmpresas'])->name('estados.empresas');
    // Route::get('/informes/almacenes/{empresa}', [InformesController::class, 'getAlmacen'])->name('estados.almacenes');
    // Route::get('/informes/seguimientos/{almacen}', [InformesController::class, 'getSeguimientos'])->name('estados.seguimiento');
    Route::resource('informes', InformesController::class);
    // Route::get('/certificados/pdf', [CertificadosController::class, 'pdf'])->name('certificados.pdf');
    // Route::resource('certificados', CertificadosController::class);

    /// ********** CONTABILIDAD *****************    
    Route::post('/cuentasporcobrar/{id}/cobrar', [CuentasPorCobrarController::class, 'cobrar'])->name('cuentasporcobrar.cobrar');
    Route::post('/cuentasporcobrar/{id}/cuotas', [CuentasPorCobrarController::class, 'cuotas'])->name('cuentasporcobrar.cuotas');
    Route::resource('cuentasporcobrar', CuentasPorCobrarController::class);
    Route::post('/cuentasporpagar/{id}/pagar', [CuentasPorPagarController::class, 'pagar'])->name('cuentasporpagar.pagar');
    Route::post('/cuentasporpagar/{id}/cuotas', [CuentasPorPagarController::class, 'cuotas'])->name('cuentasporpagar.cuotas');
    Route::resource('cuentasporpagar', CuentasPorPagarController::class);
    Route::resource('compras', ComprasController::class);
    Route::resource('ventas', VentasController::class);
    Route::resource('ingresos', IngresosController::class);
    // Route::resource('retiros', RetirosController::class);
    Route::resource('gastos', GastosController::class);
    Route::resource('gastosop', GastosOpController::class);
    Route::resource('gastosfin', GastosFinController::class);
    Route::resource('gastosex', GastosExController::class);
    Route::get('/estados/obtenercierre', [EstadosController::class, 'obtenerCierre'])->name('estados.obtenercierre');
    Route::get('/estados/obtener', [EstadosController::class, 'obtenerEstado'])->name('estados.obtener');
    Route::post('/estados/cierre', [EstadosController::class, 'cierre'])->name('estados.cierre');
    Route::get('/estados/{id}/pdf', [EstadosController::class, 'pdf'])->name('estados.pdf');
    Route::resource('estados', EstadosController::class);

    Route::resource('categorias', CategoriasController::class);
    Route::resource('subcategorias', SubcategoriasController::class);
    Route::resource('marcas', MarcasController::class);
    Route::resource('etiquetas', EtiquetasController::class);

    Route::get('/productos/test', [ProductosController::class, 'test'])->name('productos.test');
    Route::get('/productos/subcategorias/{categoria}', [ProductosController::class, 'getSubcategorias'])->name('productos.subcategorias');
    Route::get('/productos/search', [ProductosController::class, 'search'])->name('productos.search');
    Route::get('/productos/{hojaTecnica}/download', [ProductosController::class, 'download'])->name('productos.download');
    Route::resource('productos', ProductosController::class);

    Route::prefix('productos/{producto}')->group(function () {
        // Vencimientos
        Route::get('vencimientos', [ProductoVencimientoController::class, 'index'])
            ->name('productos.vencimientos.index');

        Route::post('vencimientos', [ProductoVencimientoController::class, 'store'])
            ->name('productos.vencimientos.store');

        Route::delete('vencimientos/{vencimiento}', [ProductoVencimientoController::class, 'destroy'])
            ->name('productos.vencimientos.destroy');

        // Hojas técnicas
        Route::get('hojas-tecnicas', [HojaTecnicaController::class, 'index'])
            ->name('productos.hojas-tecnicas.index');

        Route::post('hojas-tecnicas', [HojaTecnicaController::class, 'store'])
            ->name('productos.hojas-tecnicas.store');

        Route::delete('hojas-tecnicas/{hojaTecnica}', [HojaTecnicaController::class, 'destroy'])
            ->name('productos.hojas-tecnicas.destroy');
    });

    Route::resource('inventarios', InventarioController::class);

    Route::post('/proveedores/storemodal', [ProveedoresController::class, 'storeModal'])->name('proveedores.storemodal');
    Route::resource('proveedores', ProveedoresController::class);

    /// ********** USUARIO ************************
    Route::resource('agendas', AgendaController::class);
    Route::resource('usuarios', UsersController::class);
    Route::get('/documentos/{documento}/download', [DocumentosController::class, 'download'])->name('documentos.download');
    Route::resource('documentos', DocumentosController::class);
    Route::resource('configs', ConfigsController::class);
    Route::resource('roles', RolePermissionController::class);
});

require __DIR__ . '/settings.php';
