<?php

namespace Tests\Feature;

use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\DB;
use Spatie\Permission\Models\Role;
use Tests\TestCase;

/**
 * Mapas de un almacén: lo consulta el aviso "este almacén no tiene mapas" de
 * los modales de nuevo/editar seguimiento. El {id} de la ruta es un almacenes.id.
 */
class AlmacenMapasEndpointTest extends TestCase
{
  use RefreshDatabase;

  private function crearAlmacen(): array
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

    return compact('user', 'empresaId', 'almacenId');
  }

  private function actuandoComo(User $user, string $rol): User
  {
    Role::findOrCreate($rol, 'web');
    $user->assignRole($rol);

    return $user;
  }

  public function test_devuelve_los_mapas_del_almacen(): void
  {
    ['user' => $user, 'empresaId' => $empresaId, 'almacenId' => $almacenId] = $this->crearAlmacen();

    DB::table('mapas')->insert([
      'titulo' => 'Planta baja',
      'empresa_id' => $empresaId,
      'almacen_id' => $almacenId,
      'user_id' => $user->id,
    ]);

    $this->actingAs($this->actuandoComo($user, 'tecnico'))
      ->getJson("/trampaseguimientos/{$almacenId}/mapas")
      ->assertOk()
      ->assertJsonCount(1)
      ->assertJsonPath('0.titulo', 'Planta baja');
  }

  public function test_devuelve_vacio_si_el_almacen_no_tiene_mapas(): void
  {
    ['user' => $user, 'almacenId' => $almacenId] = $this->crearAlmacen();

    $this->actingAs($this->actuandoComo($user, 'tecnico'))
      ->getJson("/trampaseguimientos/{$almacenId}/mapas")
      ->assertOk()
      ->assertJsonCount(0);
  }

  public function test_un_cliente_no_puede_consultar_los_mapas(): void
  {
    ['user' => $user, 'almacenId' => $almacenId] = $this->crearAlmacen();

    $this->actingAs($this->actuandoComo($user, 'cliente'))
      ->getJson("/trampaseguimientos/{$almacenId}/mapas")
      ->assertForbidden();
  }
}
