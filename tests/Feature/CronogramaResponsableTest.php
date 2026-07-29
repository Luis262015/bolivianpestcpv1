<?php

namespace Tests\Feature;

use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\DB;
use Spatie\Permission\Models\Role;
use Tests\TestCase;

/**
 * El dropdown "Usuario responsable" del cronograma solo ofrece personal
 * interno (superadmin, admin, técnico). Los clientes quedan fuera tanto del
 * catálogo que se envía a la vista como de la validación de escritura.
 */
class CronogramaResponsableTest extends TestCase
{
  use RefreshDatabase;

  private function contexto(): array
  {
    foreach (['superadmin', 'admin', 'tecnico', 'cliente'] as $rol) {
      Role::findOrCreate($rol, 'web');
    }

    $admin = User::factory()->create(['name' => 'Admin Test']);
    $admin->assignRole('admin');

    $tecnico = User::factory()->create(['name' => 'Tecnico Test']);
    $tecnico->assignRole('tecnico');

    $cliente = User::factory()->create(['name' => 'Cliente Test']);
    $cliente->assignRole('cliente');

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

    return compact('admin', 'tecnico', 'cliente', 'almacenId');
  }

  public function test_el_catalogo_de_responsables_excluye_a_los_clientes(): void
  {
    ['admin' => $admin, 'tecnico' => $tecnico, 'cliente' => $cliente] = $this->contexto();

    $response = $this->actingAs($admin)->get(route('cronogramas.index'));

    $response->assertOk();
    $usuarios = collect($response->viewData('page')['props']['usuarios']);

    $this->assertContains($admin->id, $usuarios->pluck('id')->all());
    $this->assertContains($tecnico->id, $usuarios->pluck('id')->all());
    $this->assertNotContains($cliente->id, $usuarios->pluck('id')->all());
  }

  public function test_no_se_puede_crear_una_tarea_con_un_cliente_como_responsable(): void
  {
    ['admin' => $admin, 'cliente' => $cliente, 'almacenId' => $almacenId] = $this->contexto();

    $this->actingAs($admin)
      ->post(route('cronogramas.store'), [
        'title' => 'DESRATIZACION',
        'date' => '2026-08-01',
        'color' => 'bg-yellow-500',
        'status' => 'pendiente',
        'user_id' => $cliente->id,
        'tecnico_id' => $cliente->id,
        'almacen_id' => $almacenId,
      ])
      ->assertSessionHasErrors(['user_id', 'tecnico_id']);

    $this->assertDatabaseCount('cronogramas', 0);
  }

  public function test_se_puede_crear_una_tarea_con_un_tecnico_como_responsable(): void
  {
    ['admin' => $admin, 'tecnico' => $tecnico, 'almacenId' => $almacenId] = $this->contexto();

    $this->actingAs($admin)
      ->post(route('cronogramas.store'), [
        'title' => 'DESRATIZACION',
        'date' => '2026-08-01',
        'color' => 'bg-yellow-500',
        'status' => 'pendiente',
        'user_id' => $tecnico->id,
        'tecnico_id' => $tecnico->id,
        'almacen_id' => $almacenId,
      ])
      ->assertSessionHasNoErrors();

    $this->assertDatabaseHas('cronogramas', [
      'user_id' => $tecnico->id,
      'tecnico_id' => $tecnico->id,
      'almacen_id' => $almacenId,
    ]);
  }

  public function test_no_se_puede_reasignar_una_tarea_a_un_cliente(): void
  {
    ['admin' => $admin, 'tecnico' => $tecnico, 'cliente' => $cliente, 'almacenId' => $almacenId] = $this->contexto();

    $cronogramaId = DB::table('cronogramas')->insertGetId([
      'empresa_id' => DB::table('almacenes')->where('id', $almacenId)->value('empresa_id'),
      'almacen_id' => $almacenId,
      'user_id' => $tecnico->id,
      'tecnico_id' => $tecnico->id,
      'title' => 'DESRATIZACION',
      'date' => '2026-08-01',
      'status' => 'pendiente',
    ]);

    $this->actingAs($admin)
      ->put(route('cronogramas.update', $cronogramaId), ['user_id' => $cliente->id])
      ->assertSessionHasErrors('user_id');

    $this->assertDatabaseHas('cronogramas', [
      'id' => $cronogramaId,
      'user_id' => $tecnico->id,
    ]);
  }
}
