<?php

namespace Tests\Feature;

use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Spatie\Permission\Models\Role;
use Tests\TestCase;

/**
 * Guardado de un seguimiento con "Gastos relacionados (opcional)" (paso 11
 * del modal). El bloque es opcional, pero cada fila que se agrega trae sus
 * propias reglas required.
 */
class SeguimientoGastosTest extends TestCase
{
  use RefreshDatabase;

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
      'nombre' => 'Almacen Test',
      'empresa_id' => $empresaId,
    ]);
    DB::table('tipo_seguimientos')->insert([
      ['id' => 2, 'nombre' => 'FUMIGACION'],
    ]);
    $cronogramaId = DB::table('cronogramas')->insertGetId([
      'empresa_id' => $empresaId,
      'almacen_id' => $almacenId,
      'user_id' => $user->id,
      'tecnico_id' => $user->id,
      'tipo_seguimiento_id' => 2,
      'title' => 'Tarea Test',
      'date' => '2026-07-16',
      'status' => 'pendiente',
    ]);

    return compact('user', 'almacenId', 'cronogramaId');
  }

  private function payload(int $almacenId, int $cronogramaId, array $extra = []): array
  {
    return array_merge([
      'almacen_id' => $almacenId,
      'tipo_seguimiento_id' => 2,
      'numero_tarea' => $cronogramaId,
      'encargado_nombre' => 'Juan',
      'encargado_cargo' => 'Jefe',
      'aplicacion_data' => [
        'paredes_internas' => 'no',
        'pisos' => 'no',
        'ambientes' => 'no',
        'trampas' => 'no',
        'trampas_cambiar' => 'no',
        'internas' => 'no',
        'externas' => 'no',
        'roedores' => 'no',
      ],
    ], $extra);
  }

  public function test_guarda_un_seguimiento_con_un_gasto_bien_llenado(): void
  {
    ['user' => $user, 'almacenId' => $a, 'cronogramaId' => $c] = $this->contexto();

    $this->actingAs($user)
      ->post('/seguimientos', $this->payload($a, $c, [
        'gastos' => [
          ['concepto' => 'Transporte', 'total' => '150.50'],
        ],
      ]))
      ->assertRedirect(route('seguimientos.index'));

    $this->assertDatabaseCount('seguimientos', 1);
    $this->assertDatabaseHas('gastos', [
      'concepto' => 'Transporte',
      'total' => 150.50,
      'seguimiento_id' => DB::table('seguimientos')->value('id'),
    ]);
  }

  public function test_una_fila_de_gasto_vacia_no_debe_tumbar_el_seguimiento(): void
  {
    ['user' => $user, 'almacenId' => $a, 'cronogramaId' => $c] = $this->contexto();

    // El técnico pulsa "Agregar gasto" y no llena nada (o se arrepiente y no
    // borra la fila). El seguimiento entero es lo que importa: no puede
    // perderse por una fila en blanco que el usuario no pidió.
    $this->actingAs($user)
      ->post('/seguimientos', $this->payload($a, $c, [
        'gastos' => [
          ['concepto' => '', 'total' => ''],
        ],
      ]))
      ->assertRedirect(route('seguimientos.index'));

    $this->assertDatabaseCount('seguimientos', 1);
    $this->assertDatabaseCount('gastos', 0);
  }

  public function test_una_fila_a_medio_llenar_si_se_marca_como_error(): void
  {
    ['user' => $user, 'almacenId' => $a, 'cronogramaId' => $c] = $this->contexto();

    // Aquí el técnico sí escribió algo: tragárselo en silencio perdería un
    // gasto real, así que se rechaza y el modal marca el campo.
    $this->actingAs($user)
      ->post('/seguimientos', $this->payload($a, $c, [
        'gastos' => [
          ['concepto' => 'Transporte', 'total' => ''],
        ],
      ]))
      ->assertSessionHasErrors('gastos.0.total');

    $this->assertDatabaseCount('seguimientos', 0);
  }

  public function test_las_filas_vacias_no_descuadran_los_indices_de_error(): void
  {
    ['user' => $user, 'almacenId' => $a, 'cronogramaId' => $c] = $this->contexto();

    // Con una fila vacía delante, el error debe apuntar a la fila que el
    // modal seguirá mostrando en primera posición, no a un índice fantasma.
    $this->actingAs($user)
      ->post('/seguimientos', $this->payload($a, $c, [
        'gastos' => [
          ['concepto' => '', 'total' => ''],
          ['concepto' => '', 'total' => '80'],
        ],
      ]))
      ->assertSessionHasErrors('gastos.0.concepto');
  }

  /**
   * El modal de edición manda multipart: los arrays viajan como JSON string.
   */
  private function editarGastos(User $user, int $seguimientoId, int $almacenId, array $gastos): \Illuminate\Testing\TestResponse
  {
    return $this->actingAs($user)->put("/seguimientos/{$seguimientoId}", [
      'almacen_id' => $almacenId,
      'tipo_seguimiento_id' => 2,
      'encargado_nombre' => 'Juan',
      'encargado_cargo' => 'Jefe',
      'gastos' => json_encode($gastos),
    ]);
  }

  public function test_al_editar_se_pueden_agregar_corregir_y_borrar_gastos(): void
  {
    ['user' => $user, 'almacenId' => $a, 'cronogramaId' => $c] = $this->contexto();

    $this->actingAs($user)->post('/seguimientos', $this->payload($a, $c, [
      'gastos' => [['concepto' => 'Transporte', 'total' => '100']],
    ]))->assertRedirect(route('seguimientos.index'));

    $seguimientoId = (int) DB::table('seguimientos')->value('id');

    // Corregir el monto del existente y agregar uno nuevo.
    $this->editarGastos($user, $seguimientoId, $a, [
      ['concepto' => 'Transporte', 'total' => '175.25'],
      ['concepto' => 'Viáticos', 'total' => '60'],
    ])->assertRedirect(route('seguimientos.index'));

    $this->assertDatabaseCount('gastos', 2);
    $this->assertDatabaseHas('gastos', ['concepto' => 'Transporte', 'total' => 175.25]);
    $this->assertDatabaseHas('gastos', ['concepto' => 'Viáticos', 'total' => 60]);

    // Quitarlos todos.
    $this->editarGastos($user, $seguimientoId, $a, [])
      ->assertRedirect(route('seguimientos.index'));

    $this->assertDatabaseCount('gastos', 0);
    $this->assertDatabaseCount('seguimientos', 1);
  }

  public function test_al_editar_una_fila_vacia_tampoco_tumba_el_seguimiento(): void
  {
    ['user' => $user, 'almacenId' => $a, 'cronogramaId' => $c] = $this->contexto();

    $this->actingAs($user)->post('/seguimientos', $this->payload($a, $c))
      ->assertRedirect(route('seguimientos.index'));

    $seguimientoId = (int) DB::table('seguimientos')->value('id');

    $this->editarGastos($user, $seguimientoId, $a, [
      ['concepto' => '', 'total' => ''],
      ['concepto' => 'Peaje', 'total' => '20'],
    ])->assertRedirect(route('seguimientos.index'));

    $this->assertDatabaseCount('gastos', 1);
    $this->assertDatabaseHas('gastos', ['concepto' => 'Peaje']);
  }

  public function test_el_gasto_editado_conserva_al_tecnico_del_seguimiento(): void
  {
    ['user' => $user, 'almacenId' => $a, 'cronogramaId' => $c] = $this->contexto();

    $this->actingAs($user)->post('/seguimientos', $this->payload($a, $c))
      ->assertRedirect(route('seguimientos.index'));

    $seguimientoId = (int) DB::table('seguimientos')->value('id');

    // Un admin corrige el gasto: el autor sigue siendo quien fue a campo.
    $admin = User::factory()->create();
    Role::findOrCreate('admin', 'web');
    $admin->assignRole('admin');

    $this->editarGastos($admin, $seguimientoId, $a, [
      ['concepto' => 'Transporte', 'total' => '90'],
    ])->assertRedirect(route('seguimientos.index'));

    $this->assertDatabaseHas('gastos', [
      'concepto' => 'Transporte',
      'user_id' => $user->id,
    ]);
  }

  public function test_la_validacion_fallida_queda_registrada_en_el_log(): void
  {
    ['user' => $user, 'almacenId' => $a, 'cronogramaId' => $c] = $this->contexto();

    // Sin esto una ValidationException no dejaba rastro en el servidor y no
    // había forma de saber qué campo rechazó el seguimiento.
    Log::shouldReceive('info')->zeroOrMoreTimes();
    Log::shouldReceive('warning')
      ->once()
      ->withArgs(function (string $mensaje, array $contexto): bool {
        return $mensaje === 'SeguimientoController@store validación fallida'
          && array_key_exists('gastos.0.total', $contexto['errores']);
      });

    $this->actingAs($user)->post('/seguimientos', $this->payload($a, $c, [
      'gastos' => [['concepto' => 'Transporte', 'total' => '']],
    ]));
  }

  public function test_el_detalle_expone_los_gastos_para_el_modal_de_edicion(): void
  {
    ['user' => $user, 'almacenId' => $a, 'cronogramaId' => $c] = $this->contexto();

    $this->actingAs($user)->post('/seguimientos', $this->payload($a, $c, [
      'gastos' => [['concepto' => 'Transporte', 'total' => '100']],
    ]))->assertRedirect(route('seguimientos.index'));

    $seguimientoId = (int) DB::table('seguimientos')->value('id');

    $this->actingAs($user)
      ->getJson("/seguimientos/{$seguimientoId}")
      ->assertOk()
      ->assertJsonPath('gastos.0.concepto', 'Transporte');
  }
}
