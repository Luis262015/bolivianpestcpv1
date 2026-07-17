<?php

namespace Tests\Feature;

use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\DB;
use Spatie\Permission\Models\Role;
use Tests\TestCase;

/**
 * Dos trampas vigentes del mismo almacén no pueden compartir identificador.
 * Las inactivas sí: son trampas retiradas que se conservan por su historial.
 */
class MapaIdentificadorUnicoTest extends TestCase
{
  use RefreshDatabase;

  private const TIPO_CEBADERA = 1;
  private const TIPO_INSECTO  = 2;

  private User $user;
  private int $empresaId;
  private int $almacenId;
  private int $mapaId;

  protected function setUp(): void
  {
    parent::setUp();

    $this->user = User::factory()->create();
    Role::findOrCreate('admin', 'web');
    $this->user->assignRole('admin');

    $this->empresaId = DB::table('empresas')->insertGetId([
      'nombre' => 'Empresa Test',
      'direccion' => 'Calle 1',
      'telefono' => '000',
      'email' => 'test@empresa.test',
      'ciudad' => 'Santa Cruz',
    ]);
    $this->almacenId = DB::table('almacenes')->insertGetId([
      'nombre' => 'Almacen Test',
      'empresa_id' => $this->empresaId,
    ]);
    $this->mapaId = DB::table('mapas')->insertGetId([
      'titulo' => 'Mapa Test',
      'empresa_id' => $this->empresaId,
      'almacen_id' => $this->almacenId,
      'user_id' => $this->user->id,
    ]);

    foreach ([self::TIPO_CEBADERA => 'cebadera', self::TIPO_INSECTO => 'insecto'] as $id => $nombre) {
      DB::table('trampa_tipos')->insert(['id' => $id, 'nombre' => $nombre, 'imagen' => 'x.png']);
    }
  }

  private function trampaExistente(string $identificador, string $estado, ?int $mapaId = null): int
  {
    return DB::table('trampas')->insertGetId([
      'numero' => 1,
      'identificador' => $identificador,
      'almacen_id' => $this->almacenId,
      'mapa_id' => $mapaId ?? $this->mapaId,
      'trampa_tipo_id' => self::TIPO_CEBADERA,
      'posx' => 0,
      'posy' => 0,
      'estado' => $estado,
    ]);
  }

  private function payloadTrampa(array $overrides = []): array
  {
    return array_merge([
      'trampa_tipo_id' => self::TIPO_INSECTO,
      'posx' => 10,
      'posy' => 10,
      'estado' => 'activo',
      'numero' => 1,
      'identificador' => 'T-01',
    ], $overrides);
  }

  private function guardarMapa(array $trampas)
  {
    return $this->actingAs($this->user)->put("/mapas/{$this->mapaId}", [
      'almacen_id' => $this->almacenId,
      'titulo' => 'Mapa Test',
      'trampas' => $trampas,
    ]);
  }

  public function test_rechaza_dos_trampas_vigentes_con_el_mismo_identificador(): void
  {
    $this->guardarMapa([
      $this->payloadTrampa(['identificador' => 'T-01']),
      $this->payloadTrampa(['identificador' => 'T-01', 'numero' => 2]),
    ])->assertSessionHasErrors('trampas');

    $this->assertDatabaseCount('trampas', 0);
  }

  public function test_el_mensaje_de_error_nombra_el_identificador_repetido(): void
  {
    $this->guardarMapa([
      $this->payloadTrampa(['identificador' => 'T-07']),
      $this->payloadTrampa(['identificador' => 'T-07', 'numero' => 2]),
    ]);

    $errores = session('errors')->get('trampas');
    $this->assertStringContainsString('T-07', $errores[0]);
  }

  public function test_ignora_mayusculas_y_espacios_al_comparar(): void
  {
    // MySQL colaciona sin distinguir may/min: "t-01" y "T-01" chocarían en BD.
    $this->guardarMapa([
      $this->payloadTrampa(['identificador' => 'T-01']),
      $this->payloadTrampa(['identificador' => ' t-01 ', 'numero' => 2]),
    ])->assertSessionHasErrors('trampas');
  }

  public function test_permite_reemplazar_una_trampa_retirada_por_otra_con_el_mismo_nombre(): void
  {
    // El escenario real: la cebadera T-01 quedó inactiva al retirarla del mapa
    // y se coloca una T-01 de insectos en su lugar.
    $this->trampaExistente('T-01', 'inactivo');

    $this->guardarMapa([
      $this->payloadTrampa(['identificador' => 'T-01']),
    ])->assertSessionHasNoErrors();

    $this->assertDatabaseHas('trampas', [
      'identificador' => 'T-01',
      'trampa_tipo_id' => self::TIPO_INSECTO,
      'estado' => 'activo',
    ]);
  }

  public function test_permite_el_mismo_identificador_en_otro_mapa_del_almacen(): void
  {
    // Cada plano numera sus trampas desde 1: en un almacén con varios mapas es
    // normal que todos tengan su "T-01". Los informes agrupan por mapa, así que
    // no hay ambigüedad. Validar por almacén rompería la edición de mapas.
    $otroMapaId = DB::table('mapas')->insertGetId([
      'titulo' => 'Otro Mapa',
      'empresa_id' => $this->empresaId,
      'almacen_id' => $this->almacenId,
      'user_id' => $this->user->id,
    ]);
    $this->trampaExistente('T-01', 'activo', $otroMapaId);

    $this->guardarMapa([
      $this->payloadTrampa(['identificador' => 'T-01']),
    ])->assertSessionHasNoErrors();
  }

  public function test_permite_conservar_una_trampa_existente_del_mismo_mapa(): void
  {
    // Reguardar el mapa sin tocar la trampa no debe chocar consigo misma.
    $trampaId = $this->trampaExistente('T-01', 'activo');

    $this->guardarMapa([
      $this->payloadTrampa(['id' => $trampaId, 'identificador' => 'T-01']),
    ])->assertSessionHasNoErrors();
  }

  public function test_permite_el_mismo_identificador_en_otro_almacen(): void
  {
    $otroAlmacenId = DB::table('almacenes')->insertGetId([
      'nombre' => 'Otro Almacen',
      'empresa_id' => $this->empresaId,
    ]);
    DB::table('trampas')->insert([
      'numero' => 1,
      'identificador' => 'T-01',
      'almacen_id' => $otroAlmacenId,
      'mapa_id' => null,
      'trampa_tipo_id' => self::TIPO_CEBADERA,
      'posx' => 0,
      'posy' => 0,
      'estado' => 'activo',
    ]);

    $this->guardarMapa([
      $this->payloadTrampa(['identificador' => 'T-01']),
    ])->assertSessionHasNoErrors();
  }

  public function test_rechaza_duplicados_tambien_al_crear_un_mapa(): void
  {
    $this->actingAs($this->user)->post('/mapas', [
      'almacen_id' => $this->almacenId,
      'titulo' => 'Mapa Nuevo',
      'trampas' => [
        $this->payloadTrampa(['identificador' => 'T-01']),
        $this->payloadTrampa(['identificador' => 'T-01', 'numero' => 2]),
      ],
    ])->assertSessionHasErrors('trampas');
  }
}
