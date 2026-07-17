<?php

namespace Tests\Feature;

use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\DB;
use Spatie\Permission\Models\Role;
use Tests\TestCase;

/**
 * "CANT. TRAMPAS" del informe debe contar solo las trampas vigentes.
 *
 * Las trampas retiradas del mapa que tienen historial no se borran: quedan en
 * `estado = inactivo` (ver MapaController@update). El mapa del informe ya las
 * filtra, así que el conteo tiene que hacer lo mismo o ambos se contradicen.
 */
class InformesConteoTrampasTest extends TestCase
{
    use RefreshDatabase;

    private const TIPO_INSECTO = 2;

    private array $ctx;

    protected function setUp(): void
    {
        parent::setUp();

        $this->registrarDateFormatEnSqlite();

        $user = User::factory()->create();
        Role::findOrCreate('admin', 'web');
        $user->assignRole('admin');

        $empresaId = DB::table('empresas')->insertGetId([
            'nombre' => 'Empresa Test',
            'direccion' => 'Calle 1',
            'telefono' => '000',
            'email' => 'test@empresa.test',
            'ciudad' => 'Santa Cruz',
        ]);
        $almacenId = DB::table('almacenes')->insertGetId([
            'nombre' => 'Almacen Test',
            'empresa_id' => $empresaId,
        ]);
        $mapaId = DB::table('mapas')->insertGetId([
            'titulo' => 'Mapa Test',
            'empresa_id' => $empresaId,
            'almacen_id' => $almacenId,
            'user_id' => $user->id,
        ]);

        $this->ctx = compact('user', 'empresaId', 'almacenId', 'mapaId');
    }

    /**
     * InformesController@index arma `totales` con DATE_FORMAT, que es de MySQL,
     * y la suite corre en SQLite. Se registra un equivalente mínimo para poder
     * ejercitar el endpoint; es ajeno al conteo que se prueba aquí.
     */
    private function registrarDateFormatEnSqlite(): void
    {
        $conexion = DB::connection();

        if ($conexion->getDriverName() !== 'sqlite') {
            return;
        }

        $conexion->getPdo()->sqliteCreateFunction('DATE_FORMAT', function (?string $fecha, string $formato) {
            if ($fecha === null) {
                return null;
            }

            return date(strtr($formato, ['%Y' => 'Y', '%m' => 'm', '%d' => 'd']), strtotime($fecha));
        }, 2);
    }

    private function crearTrampa(string $identificador, int $tipoId, string $estado): int
    {
        $trampaTipoId = DB::table('trampa_tipos')->insertGetId([
            'id' => $tipoId,
            'nombre' => $tipoId === self::TIPO_INSECTO ? 'insecto' : 'cebadera',
            'imagen' => 'x.png',
        ]);

        return DB::table('trampas')->insertGetId([
            'numero' => 1,
            'identificador' => $identificador,
            'almacen_id' => $this->ctx['almacenId'],
            'mapa_id' => $this->ctx['mapaId'],
            'trampa_tipo_id' => $trampaTipoId,
            'posx' => 0,
            'posy' => 0,
            'estado' => $estado,
        ]);
    }

    private function consultarInforme()
    {
        return $this->actingAs($this->ctx['user'])->get('/informes?' . http_build_query([
            'buscar' => 1,
            'empresa_id' => $this->ctx['empresaId'],
            'almacen_id' => $this->ctx['almacenId'],
            'fecha_inicio' => '2026-01-01',
            'fecha_fin' => '2026-12-31',
        ]));
    }

    public function test_no_cuenta_las_trampas_inactivas(): void
    {
        // Escenario: la cebadera T-01 se retiró del mapa (queda inactiva por su
        // historial) y se colocó una T-01 de insectos en su lugar.
        $this->crearTrampa('T-01', 1, 'inactivo');
        $this->crearTrampa('T-01', self::TIPO_INSECTO, 'activo');

        $this->consultarInforme()
            ->assertOk()
            ->assertInertia(
                fn($page) => $page
                    ->where('trampasinsect', 1)
                    // Sin el filtro, la cebadera retirada seguiría sumando aquí.
                    ->where('trampasrat', 0)
            );
    }

    public function test_cuenta_las_trampas_vigentes(): void
    {
        $this->crearTrampa('T-01', 1, 'activo');
        $this->crearTrampa('T-02', self::TIPO_INSECTO, 'activo');

        $this->consultarInforme()
            ->assertOk()
            ->assertInertia(
                fn($page) => $page
                    ->where('trampasinsect', 1)
                    ->where('trampasrat', 1)
            );
    }

    public function test_cuenta_las_trampas_en_mantenimiento(): void
    {
        // "mantenimiento" sigue siendo una trampa vigente: el mapa la dibuja.
        $this->crearTrampa('T-01', 1, 'mantenimiento');

        $this->consultarInforme()
            ->assertOk()
            ->assertInertia(fn($page) => $page->where('trampasrat', 1));
    }
}
