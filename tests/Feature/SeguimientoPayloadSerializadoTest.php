<?php

namespace Tests\Feature;

use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\DB;
use Spatie\Permission\Models\Role;
use Tests\TestCase;

/**
 * El modal manda los arrays serializados en JSON.
 *
 * Enviarlos anidados hacía que PHP cortara el POST en silencio al pasar
 * max_input_vars (1000): un almacén con 142 trampas manda ~1136 variables solo
 * en trampas y las últimas filas llegaban truncadas, reventando contra
 * `required` sin explicación. Serializado cada array ocupa una sola variable.
 */
class SeguimientoPayloadSerializadoTest extends TestCase
{
  use RefreshDatabase;

  private const TRAMPAS = 142;

  private function contexto(): array
  {
    $user = User::factory()->create();
    Role::findOrCreate('tecnico', 'web');
    $user->assignRole('tecnico');

    $empresaId = DB::table('empresas')->insertGetId([
      'nombre' => 'Empresa Test',
      'direccion' => 'Calle 1',
      'telefono' => '000',
      'email' => 'test@empresa.test',
      'ciudad' => 'Santa Cruz',
    ]);
    $almacenId = DB::table('almacenes')->insertGetId([
      'nombre' => 'Almacen Grande',
      'empresa_id' => $empresaId,
    ]);
    DB::table('tipo_seguimientos')->insert([['id' => 1, 'nombre' => 'DESRATIZACION']]);
    $tipoTrampaId = DB::table('trampa_tipos')->insertGetId([
      'nombre' => 'roedor',
      'imagen' => 'roedor.png',
    ]);

    // Un almacén del tamaño del que destapó el problema.
    $trampaIds = [];
    for ($i = 1; $i <= self::TRAMPAS; $i++) {
      $trampaIds[] = DB::table('trampas')->insertGetId([
        'almacen_id' => $almacenId,
        'trampa_tipo_id' => $tipoTrampaId,
        'numero' => $i,
        'posx' => 0,
        'posy' => 0,
        'identificador' => "T{$i}",
        'estado' => 'activa',
      ]);
    }

    $cronogramaId = DB::table('cronogramas')->insertGetId([
      'empresa_id' => $empresaId,
      'almacen_id' => $almacenId,
      'user_id' => $user->id,
      'tecnico_id' => $user->id,
      'tipo_seguimiento_id' => 1,
      'title' => 'DESRATIZACION',
      'date' => '2026-11-28',
      'status' => 'pendiente',
    ]);

    return compact('user', 'almacenId', 'cronogramaId', 'trampaIds');
  }

  public function test_acepta_el_payload_serializado_con_todas_las_trampas(): void
  {
    ['user' => $user, 'almacenId' => $a, 'cronogramaId' => $c, 'trampaIds' => $trampaIds] =
      $this->contexto();

    $roedores = array_map(static fn (int $id): array => [
      'trampa_id' => $id,
      'observacion' => '',
      'cantidad' => 0,
      'inicial' => 0,
      'actual' => 0,
      'merma' => 0,
    ], $trampaIds);

    $this->actingAs($user)
      ->post('/seguimientos', [
        'almacen_id' => $a,
        'tipo_seguimiento_id' => 1,
        'numero_tarea' => $c,
        'encargado_nombre' => 'Juan',
        'encargado_cargo' => 'Jefe',
        // Tal como los manda el modal: un string por array.
        'aplicacion_data' => json_encode([
          'paredes_internas' => 'no',
          'pisos' => 'no',
          'ambientes' => 'no',
          'trampas' => 'si',
          'trampas_cambiar' => 'no',
          'internas' => 'no',
          'externas' => 'no',
          'roedores' => 'si',
        ]),
        'metodos_ids' => json_encode([]),
        'epps_ids' => json_encode([]),
        'protecciones_ids' => json_encode([]),
        'biologicos_ids' => json_encode([]),
        'signos_ids' => json_encode([]),
        'productos_usados' => json_encode([]),
        'trampa_especies_seguimientos' => json_encode([]),
        'trampa_roedores_seguimientos' => json_encode($roedores),
        'gastos' => json_encode([['concepto' => 'Transporte', 'total' => '150']]),
      ])
      ->assertRedirect(route('seguimientos.index'));

    $seguimientoId = DB::table('seguimientos')->value('id');

    $this->assertDatabaseCount('seguimientos', 1);
    $this->assertSame(
      self::TRAMPAS,
      DB::table('trampa_roedor_seguimientos')->where('seguimiento_id', $seguimientoId)->count(),
      'No debe perderse ninguna fila de trampa.',
    );
    $this->assertDatabaseHas('gastos', ['concepto' => 'Transporte']);
  }

  public function test_los_errores_siguen_apuntando_a_la_fila_culpable(): void
  {
    ['user' => $user, 'almacenId' => $a, 'cronogramaId' => $c, 'trampaIds' => $trampaIds] =
      $this->contexto();

    // Serializar no puede costar la precisión del error: el modal necesita el
    // índice de la fila para marcarla en el paso 9.
    $roedores = array_map(static fn (int $id): array => [
      'trampa_id' => $id,
      'observacion' => '',
      'cantidad' => 0,
      'inicial' => 0,
      'actual' => 0,
      'merma' => 0,
    ], array_slice($trampaIds, 0, 3));

    $roedores[1]['cantidad'] = '';

    $this->actingAs($user)
      ->post('/seguimientos', [
        'almacen_id' => $a,
        'tipo_seguimiento_id' => 1,
        'numero_tarea' => $c,
        'encargado_nombre' => 'Juan',
        'encargado_cargo' => 'Jefe',
        'aplicacion_data' => json_encode([
          'paredes_internas' => 'no',
          'pisos' => 'no',
          'ambientes' => 'no',
          'trampas' => 'si',
          'trampas_cambiar' => 'no',
          'internas' => 'no',
          'externas' => 'no',
          'roedores' => 'si',
        ]),
        'trampa_roedores_seguimientos' => json_encode($roedores),
      ])
      ->assertSessionHasErrors('trampa_roedores_seguimientos.1.cantidad');

    $this->assertDatabaseCount('seguimientos', 0);
  }
}
