<?php

namespace Tests\Feature;

use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\DB;
use Spatie\Permission\Models\Role;
use Tests\TestCase;

/**
 * created_at de un seguimiento: el día lo elige el técnico en el formulario,
 * la hora sale del reloj (registro) o se conserva la original (edición).
 * Los inputs type="date" mandan solo "YYYY-MM-DD".
 */
class SeguimientoFechaHoraTest extends TestCase
{
  use RefreshDatabase;

  private function crearSeguimiento(string $createdAt): array
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
    DB::table('tipo_seguimientos')->insert([
      ['id' => 1, 'nombre' => 'DESRATIZACION'],
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
    ]);
    $seguimientoId = DB::table('seguimientos')->insertGetId([
      'empresa_id' => $empresaId,
      'almacen_id' => $almacenId,
      'user_id' => $user->id,
      'tipo_seguimiento_id' => 2,
      'cronograma_id' => $cronogramaId,
      'encargado_nombre' => 'Juan',
      'encargado_cargo' => 'Jefe',
      'created_at' => $createdAt,
      'updated_at' => $createdAt,
    ]);

    Role::findOrCreate('tecnico', 'web');
    $user->assignRole('tecnico');

    return compact('user', 'seguimientoId', 'almacenId');
  }

  private function editarFecha(User $user, int $seguimientoId, int $almacenId, string $fecha): void
  {
    $this->actingAs($user)
      ->put("/seguimientos/{$seguimientoId}", [
        'almacen_id' => $almacenId,
        'tipo_seguimiento_id' => 2,
        'encargado_nombre' => 'Juan',
        'encargado_cargo' => 'Jefe',
        'created_at' => $fecha,
      ])
      ->assertRedirect(route('seguimientos.index'));
  }

  public function test_al_editar_mueve_el_dia_y_conserva_la_hora_del_registro(): void
  {
    ['user' => $user, 'seguimientoId' => $id, 'almacenId' => $almacenId] =
      $this->crearSeguimiento('2026-07-20 16:42:11');

    // Se edita días después: la hora guardada debe seguir siendo la del trabajo.
    Carbon::setTestNow('2026-07-27 09:05:00');
    $this->editarFecha($user, $id, $almacenId, '2026-07-25');
    Carbon::setTestNow();

    $createdAt = Carbon::parse(DB::table('seguimientos')->where('id', $id)->value('created_at'));

    $this->assertSame('2026-07-25', $createdAt->toDateString());
    $this->assertSame('16:42:11', $createdAt->toTimeString(), 'No debe reemplazar la hora original.');
  }

  public function test_al_editar_no_reinicia_a_medianoche(): void
  {
    ['user' => $user, 'seguimientoId' => $id, 'almacenId' => $almacenId] =
      $this->crearSeguimiento('2026-07-20 16:42:11');

    // Guardar sin tocar la fecha tampoco debe perder la hora.
    $this->editarFecha($user, $id, $almacenId, '2026-07-20');

    $createdAt = Carbon::parse(DB::table('seguimientos')->where('id', $id)->value('created_at'));

    $this->assertSame('2026-07-20 16:42:11', $createdAt->toDateTimeString());
  }

  public function test_registros_antiguos_a_medianoche_se_respetan(): void
  {
    // Datos previos al cambio: no hay hora real que conservar, no se inventa.
    ['user' => $user, 'seguimientoId' => $id, 'almacenId' => $almacenId] =
      $this->crearSeguimiento('2026-07-20 00:00:00');

    Carbon::setTestNow('2026-07-27 09:05:00');
    $this->editarFecha($user, $id, $almacenId, '2026-07-21');
    Carbon::setTestNow();

    $createdAt = Carbon::parse(DB::table('seguimientos')->where('id', $id)->value('created_at'));

    $this->assertSame('2026-07-21 00:00:00', $createdAt->toDateTimeString());
  }
}
