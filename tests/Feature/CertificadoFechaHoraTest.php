<?php

namespace Tests\Feature;

use App\Models\Certificado;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\DB;
use Spatie\Permission\Models\Role;
use Tests\TestCase;

/**
 * El modal "Certificados" de empresas muestra cuándo se emitió cada uno.
 * La fecha se formatea en el servidor (zona de la app) y viaja como
 * `fecha_hora`, para que el navegador no la desplace de huso horario.
 */
class CertificadoFechaHoraTest extends TestCase
{
  use RefreshDatabase;

  public function test_el_listado_de_empresas_envia_la_fecha_y_hora_del_certificado(): void
  {
    $user = User::factory()->create();
    Role::findOrCreate('admin', 'web');
    $user->assignRole('admin');

    $empresaId = DB::table('empresas')->insertGetId([
      'nombre' => 'LA CASCADA LTDA',
      'direccion' => 'Calle Santa Rosa 471',
      'telefono' => '000',
      'email' => 'cascada@empresa.test',
      'ciudad' => 'La Paz',
    ]);

    DB::table('certificados')->insert([
      'empresa_id' => $empresaId,
      'user_id' => $user->id,
      'titulo' => 'CONTROL DE VECTORES',
      'actividad' => 'ELABORADORA DE BEBIDAS',
      'validez' => '90 DIAS HABILES',
      'created_at' => '2026-04-04 15:30:00',
      'updated_at' => '2026-04-04 15:30:00',
    ]);

    $this->actingAs($user)
      ->get('/empresas')
      ->assertOk()
      ->assertInertia(
        fn($page) => $page
          ->component('admin/empresas/lista')
          ->where('empresas.data.0.certificados.0.fecha_hora', '04/04/2026 15:30')
      );
  }

  public function test_el_accesor_no_revienta_si_no_hay_fecha(): void
  {
    $this->assertNull((new Certificado())->fecha_hora);
  }
}
