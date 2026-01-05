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
use App\Http\Controllers\IngresosController;
use App\Http\Controllers\InventarioController;
use App\Http\Controllers\MapaController;
use App\Http\Controllers\MarcasController;
use App\Http\Controllers\MetodosController;
use App\Http\Controllers\ProductosController;
use App\Http\Controllers\ProteccionesController;
use App\Http\Controllers\ProveedoresController;
use App\Http\Controllers\RetirosController;
use App\Http\Controllers\RolePermissionController;
use App\Http\Controllers\SeguimientoController;
use App\Http\Controllers\SignosController;
use App\Http\Controllers\SubcategoriasController;
use App\Http\Controllers\TiposController;
use App\Http\Controllers\UnidadesController;
use App\Http\Controllers\UsersController;
use App\Http\Controllers\VentasController;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;
use Laravel\Fortify\Features;

Route::get('/', function () {
    return Inertia::render('welcome', [
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
    Route::resource('empresas', EmpresaController::class);
    Route::resource('contratos', ContratoController::class);
    Route::resource('cotizaciones', CotizacionController::class);
    Route::resource('cronogramas', CronogramaController::class);
    Route::resource('mapas', MapaController::class);
    Route::resource('seguimientos', SeguimientoController::class);
    Route::resource('biologicos', BiologicosController::class);
    Route::resource('epps', EppsController::class);
    Route::resource('metodos', MetodosController::class);
    Route::resource('protecciones', ProteccionesController::class);
    Route::resource('signos', SignosController::class);
    Route::resource('tipos', TiposController::class);
    Route::resource('especies', EspeciesController::class);
    Route::resource('unidades', UnidadesController::class);
    Route::get('/certificados/pdf', [CertificadosController::class, 'pdf'])->name('certificados.pdf');
    Route::resource('certificados', CertificadosController::class);

    /// ********** CONTABILIDAD *****************    
    Route::resource('cuentasporcobrar', CuentasPorCobrarController::class);
    Route::resource('cuentasporpagar', CuentasPorPagarController::class);
    Route::resource('compras', ComprasController::class);
    Route::resource('ventas', VentasController::class);
    Route::resource('ingresos', IngresosController::class);
    Route::resource('retiros', RetirosController::class);
    Route::resource('gastos', GastosController::class);
    Route::resource('gastosop', GastosOpController::class);
    Route::resource('gastosfin', GastosFinController::class);
    Route::resource('gastosex', GastosExController::class);
    Route::resource('estados', EstadosController::class);

    Route::resource('categorias', CategoriasController::class);
    Route::resource('subcategorias', SubcategoriasController::class);
    Route::resource('marcas', MarcasController::class);
    Route::resource('etiquetas', EtiquetasController::class);

    Route::get('/productos/test', [ProductosController::class, 'test'])->name('productos.test');
    Route::get('/productos/subcategorias/{categoria}', [ProductosController::class, 'getSubcategorias'])->name('productos.subcategorias');
    Route::get('/productos/search', [ProductosController::class, 'search'])->name('productos.search');
    Route::resource('productos', ProductosController::class);

    Route::resource('inventarios', InventarioController::class);

    Route::post('/proveedores/storemodal', [ProveedoresController::class, 'storeModal']);
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
