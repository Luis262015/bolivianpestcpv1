<?php

namespace Tests\Feature;

use App\Models\HojaTecnica;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use Spatie\Permission\Models\Role;
use Tests\TestCase;

/**
 * Borrado de hojas técnicas / fichas técnicas desde el modal de la lista de
 * productos. Cubre el caso de los registros antiguos, cuyo PDF ya no está en
 * disco: la fila debe borrarse igual, sin 500 ni 403.
 */
class HojaTecnicaEliminarTest extends TestCase
{
  use RefreshDatabase;

  /** @return array{0: \App\Models\User, 1: int} */
  private function contexto(): array
  {
    $user = User::factory()->create();
    Role::findOrCreate('admin', 'web');
    $user->assignRole('admin');

    $categoriaId = DB::table('categorias')->insertGetId(['nombre' => 'Insecticidas']);
    $productoId = DB::table('productos')->insertGetId([
      'nombre' => 'FENDONA',
      'categoria_id' => $categoriaId,
    ]);

    return [$user, $productoId];
  }

  public function test_elimina_una_hoja_tecnica_existente_aunque_falte_el_archivo(): void
  {
    [$user, $productoId] = $this->contexto();

    $hojaId = DB::table('hoja_tecnicas')->insertGetId([
      'producto_id' => $productoId,
      'titulo' => 'FICHA TECNICA FENDONA',
      'archivo' => 'hojas-tecnicas/ya-no-existe.pdf',
      'created_at' => '2026-05-01 21:10:58',
      'updated_at' => '2026-05-01 21:10:58',
    ]);

    $this->actingAs($user)
      ->delete("/productos/{$productoId}/hojas-tecnicas/{$hojaId}")
      ->assertRedirect('/productos')
      ->assertSessionHas('success');

    $this->assertDatabaseMissing('hoja_tecnicas', ['id' => $hojaId]);
  }

  public function test_elimina_tambien_el_archivo_en_disco(): void
  {
    Storage::fake('local');
    [$user, $productoId] = $this->contexto();

    Storage::disk('local')->put('hojas-tecnicas/ficha.pdf', 'contenido');

    $hoja = HojaTecnica::create([
      'producto_id' => $productoId,
      'titulo' => 'HOJA DE SEGURIDAD',
      'archivo' => 'hojas-tecnicas/ficha.pdf',
    ]);

    $this->actingAs($user)
      ->delete("/productos/{$productoId}/hojas-tecnicas/{$hoja->id}")
      ->assertRedirect('/productos');

    Storage::disk('local')->assertMissing('hojas-tecnicas/ficha.pdf');
    $this->assertDatabaseMissing('hoja_tecnicas', ['id' => $hoja->id]);
  }

  public function test_no_permite_borrar_una_hoja_de_otro_producto(): void
  {
    [$user, $productoId] = $this->contexto();

    $otroProductoId = DB::table('productos')->insertGetId([
      'nombre' => 'KLERAT',
      'categoria_id' => DB::table('categorias')->insertGetId(['nombre' => 'Rodenticidas']),
    ]);

    $hojaId = DB::table('hoja_tecnicas')->insertGetId([
      'producto_id' => $otroProductoId,
      'titulo' => 'FICHA TECNICA KLERAT',
      'archivo' => 'hojas-tecnicas/klerat.pdf',
      'created_at' => now(),
      'updated_at' => now(),
    ]);

    $this->actingAs($user)
      ->delete("/productos/{$productoId}/hojas-tecnicas/{$hojaId}")
      ->assertForbidden();

    $this->assertDatabaseHas('hoja_tecnicas', ['id' => $hojaId]);
  }
}
