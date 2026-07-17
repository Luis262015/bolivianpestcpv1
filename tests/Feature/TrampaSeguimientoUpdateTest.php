<?php

namespace Tests\Feature;

use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\DB;
use Spatie\Permission\Models\Role;
use Tests\TestCase;

/**
 * Edición rápida de trampas de un seguimiento (modal ModalSeguimientoTrampa).
 * El {id} de la ruta es un seguimientos.id.
 */
class TrampaSeguimientoUpdateTest extends TestCase
{
  use RefreshDatabase;

  private function crearEscenario(int $tipoSeguimientoId = 1): array
  {
    $user = User::factory()->create();

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
    $trampaTipoId = DB::table('trampa_tipos')->insertGetId([
      'nombre' => 'cebadera',
      'imagen' => 'cebadera.png',
    ]);
    $trampaId = DB::table('trampas')->insertGetId([
      'numero' => 1,
      'identificador' => 'T-01',
      'almacen_id' => $almacenId,
      'mapa_id' => $mapaId,
      'trampa_tipo_id' => $trampaTipoId,
      'posx' => 0,
      'posy' => 0,
      'estado' => 'activo',
    ]);
    $especieId = DB::table('especies')->insertGetId(['nombre' => 'Rata']);

    // tipo_seguimiento_id 1 = DESRATIZACION (el único con roedores).
    DB::table('tipo_seguimientos')->insert([
      ['id' => 1, 'nombre' => 'DESRATIZACION'],
      ['id' => 2, 'nombre' => 'FUMIGACION'],
    ]);

    $cronogramaId = DB::table('cronogramas')->insertGetId([
      'empresa_id' => $empresaId,
      'almacen_id' => $almacenId,
      'user_id' => $user->id,
      'tecnico_id' => $user->id,
      'tipo_seguimiento_id' => $tipoSeguimientoId,
      'title' => 'Tarea Test',
      'date' => '2026-07-16',
    ]);

    $seguimientoId = DB::table('seguimientos')->insertGetId([
      'empresa_id' => $empresaId,
      'almacen_id' => $almacenId,
      'user_id' => $user->id,
      'tipo_seguimiento_id' => $tipoSeguimientoId,
      'cronograma_id' => $cronogramaId,
      'encargado_nombre' => 'Juan',
      'encargado_cargo' => 'Jefe',
    ]);

    return compact('user', 'seguimientoId', 'trampaId', 'especieId', 'almacenId');
  }

  private function actuandoComo(User $user, string $rol): User
  {
    Role::findOrCreate($rol, 'web');
    $user->assignRole($rol);

    return $user;
  }

  public function test_persiste_los_roedores_editados(): void
  {
    ['user' => $user, 'seguimientoId' => $seguimientoId, 'trampaId' => $trampaId] = $this->crearEscenario();

    // Dato previo que debe ser reemplazado, no duplicado.
    DB::table('trampa_roedor_seguimientos')->insert([
      'seguimiento_id' => $seguimientoId,
      'trampa_id' => $trampaId,
      'observacion' => 'viejo',
      'cantidad' => 0,
      'inicial' => 10,
      'merma' => 0,
      'actual' => 10,
    ]);

    $this->actingAs($this->actuandoComo($user, 'tecnico'))
      ->put("/trampaseguimientos/{$seguimientoId}", [
        'trampa_especies_seguimientos' => [],
        'trampa_roedores_seguimientos' => [[
          'trampa_id' => $trampaId,
          'observacion' => 'nuevo',
          'cantidad' => 3,
          'inicial' => 10,
          'actual' => 4,
          'merma' => 6,
        ]],
      ])
      ->assertRedirect(route('seguimientos.index'));

    $roedores = DB::table('trampa_roedor_seguimientos')
      ->where('seguimiento_id', $seguimientoId)->get();

    $this->assertCount(1, $roedores, 'Debe reemplazar, no duplicar.');
    $this->assertSame('nuevo', $roedores[0]->observacion);
    $this->assertEquals(3, $roedores[0]->cantidad);
    $this->assertEquals(6, $roedores[0]->merma);
  }

  public function test_persiste_los_insectos_editados(): void
  {
    ['user' => $user, 'seguimientoId' => $seguimientoId, 'trampaId' => $trampaId, 'especieId' => $especieId] =
      $this->crearEscenario(tipoSeguimientoId: 2);

    $this->actingAs($this->actuandoComo($user, 'tecnico'))
      ->put("/trampaseguimientos/{$seguimientoId}", [
        'trampa_especies_seguimientos' => [[
          'trampa_id' => $trampaId,
          'especie_id' => $especieId,
          'cantidad' => 7,
        ]],
        'trampa_roedores_seguimientos' => [],
      ])
      ->assertRedirect(route('seguimientos.index'));

    $this->assertDatabaseHas('trampa_especie_seguimientos', [
      'seguimiento_id' => $seguimientoId,
      'trampa_id' => $trampaId,
      'cantidad' => 7,
    ]);
  }

  public function test_no_guarda_roedores_si_el_tipo_no_es_desratizacion(): void
  {
    ['user' => $user, 'seguimientoId' => $seguimientoId, 'trampaId' => $trampaId] =
      $this->crearEscenario(tipoSeguimientoId: 2);

    $this->actingAs($this->actuandoComo($user, 'tecnico'))
      ->put("/trampaseguimientos/{$seguimientoId}", [
        'trampa_especies_seguimientos' => [],
        'trampa_roedores_seguimientos' => [[
          'trampa_id' => $trampaId,
          'observacion' => 'x',
          'cantidad' => 1,
          'inicial' => 5,
          'actual' => 2,
          'merma' => 3,
        ]],
      ]);

    $this->assertDatabaseMissing('trampa_roedor_seguimientos', [
      'seguimiento_id' => $seguimientoId,
    ]);
  }

  public function test_show_devuelve_las_trampas_del_seguimiento(): void
  {
    ['user' => $user, 'seguimientoId' => $seguimientoId, 'trampaId' => $trampaId] = $this->crearEscenario();

    DB::table('trampa_roedor_seguimientos')->insert([
      'seguimiento_id' => $seguimientoId,
      'trampa_id' => $trampaId,
      'observacion' => 'obs',
      'cantidad' => 2,
      'inicial' => 8,
      'merma' => 3,
      'actual' => 5,
    ]);

    $this->actingAs($this->actuandoComo($user, 'tecnico'))
      ->getJson("/trampaseguimientos/{$seguimientoId}")
      ->assertOk()
      ->assertJsonPath('trampa_roedores_seguimientos.0.observacion', 'obs')
      ->assertJsonPath('trampa_roedores_seguimientos.0.cantidad', 2);
  }

  public function test_rechaza_cantidades_invalidas(): void
  {
    ['user' => $user, 'seguimientoId' => $seguimientoId, 'trampaId' => $trampaId] = $this->crearEscenario();

    $this->actingAs($this->actuandoComo($user, 'tecnico'))
      ->put("/trampaseguimientos/{$seguimientoId}", [
        'trampa_especies_seguimientos' => [],
        'trampa_roedores_seguimientos' => [[
          'trampa_id' => $trampaId,
          'observacion' => null,
          'cantidad' => -5,
          'inicial' => 10,
          'actual' => 4,
          'merma' => 6,
        ]],
      ])
      ->assertSessionHasErrors('trampa_roedores_seguimientos.0.cantidad');
  }

  public function test_un_cliente_no_puede_editar_trampas(): void
  {
    ['user' => $user, 'seguimientoId' => $seguimientoId] = $this->crearEscenario();

    $this->actingAs($this->actuandoComo($user, 'cliente'))
      ->put("/trampaseguimientos/{$seguimientoId}", [
        'trampa_especies_seguimientos' => [],
        'trampa_roedores_seguimientos' => [],
      ])
      ->assertForbidden();
  }
}
