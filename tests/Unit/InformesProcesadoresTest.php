<?php

namespace Tests\Unit;

use App\Http\Controllers\InformesController;
use App\Models\Mapa;
use App\Models\Seguimiento;
use App\Models\Trampa;
use App\Models\TrampaEspecieSeguimiento;
use App\Models\TrampaRoedorSeguimiento;
use App\Models\TrampaTipo;
use ReflectionMethod;
use Tests\TestCase;

/**
 * Los procesadores del informe Word solo deben leer roedores de seguimientos
 * DESRATIZACION (tipo 1) e insectocutores de INSECTOCUTORES (tipo 3).
 *
 * Motivo: existen seguimientos de otros tipos con filas de roedores en cero
 * (basura histórica del modal de creación) que, sin el filtro, agregan filas
 * vacías a las tablas e inflan la cantidad de trampas del informe.
 */
class InformesProcesadoresTest extends TestCase
{
  private function invocar(string $metodo, $seguimientos)
  {
    $ref = new ReflectionMethod(InformesController::class, $metodo);
    $ref->setAccessible(true);

    return $ref->invoke(new InformesController(), collect($seguimientos));
  }

  private function mapa(int $id, string $titulo): Mapa
  {
    $mapa = new Mapa(['titulo' => $titulo]);
    $mapa->id = $id;

    return $mapa;
  }

  private function trampa(int $id, Mapa $mapa, int $tipoId, string $tipoNombre): Trampa
  {
    $tipo = new TrampaTipo(['nombre' => $tipoNombre]);
    $tipo->id = $tipoId;

    $trampa = new Trampa();
    $trampa->id = $id;
    $trampa->mapa_id = $mapa->id;
    $trampa->setRelation('mapa', $mapa);
    $trampa->setRelation('trampa_tipo', $tipo);

    return $trampa;
  }

  private function seguimiento(int $id, int $tipo, array $roedores = [], array $insectocutores = []): Seguimiento
  {
    $seguimiento = new Seguimiento();
    $seguimiento->id = $id;
    $seguimiento->tipo_seguimiento_id = $tipo;
    $seguimiento->created_at = '2026-07-01 10:00:00';
    $seguimiento->setRelation('roedores', collect($roedores));
    $seguimiento->setRelation('insectocutores', collect($insectocutores));

    return $seguimiento;
  }

  private function roedor(Trampa $trampa, float $inicial, float $actual, int $cantidad = 0): TrampaRoedorSeguimiento
  {
    $r = new TrampaRoedorSeguimiento([
      'cantidad' => $cantidad,
      'inicial' => $inicial,
      'actual' => $actual,
      'merma' => $inicial - $actual,
    ]);
    $r->trampa_id = $trampa->id;
    $r->setRelation('trampa', $trampa);

    return $r;
  }

  public function test_procesar_datos_trampas_ignora_roedores_de_seguimientos_no_desratizacion(): void
  {
    $mapa = $this->mapa(1, 'Planta');
    $caja = $this->trampa(10, $mapa, 3, 'caja');

    $desrat = $this->seguimiento(1, 1, roedores: [$this->roedor($caja, 10, 6, 2)]);

    // Visita de insectocutores con el bloque de roedores en cero que el modal
    // sincronizaba: 78 trampas fantasma si no se filtra.
    $fantasmas = [];
    for ($i = 0; $i < 78; $i++) {
      $fantasmas[] = $this->roedor($this->trampa(100 + $i, $mapa, 3, 'caja'), 0, 0);
    }
    $insecto = $this->seguimiento(2, 3, roedores: $fantasmas);

    $filas = $this->invocar('procesarDatosTrampas', [$desrat, $insecto]);

    $this->assertCount(1, $filas);
    $this->assertSame(1, $filas[0]['cantidad_trampas'], 'Solo la trampa de la visita DESRATIZACION');
    $this->assertSame(2, $filas[0]['cantidad']);
  }

  public function test_procesar_datos_reporte_no_genera_filas_para_visitas_no_desratizacion(): void
  {
    $mapa = $this->mapa(1, 'Planta');
    $caja = $this->trampa(10, $mapa, 3, 'caja');

    $desrat = $this->seguimiento(1, 1, roedores: [$this->roedor($caja, 10, 6)]);
    $insecto = $this->seguimiento(2, 3, roedores: [$this->roedor($caja, 0, 0)]);

    $filas = $this->invocar('procesarDatosReporte', [$desrat, $insecto]);

    $this->assertCount(1, $filas, 'La visita de insectocutores no debe producir fila');
    $this->assertSame(10, $filas[0]['inicial']);
    $this->assertSame(4, $filas[0]['merma']);
    $this->assertSame(40.0, $filas[0]['porcentaje_merma']);
  }

  public function test_procesar_datos_por_mapa_no_genera_filas_para_visitas_no_desratizacion(): void
  {
    $mapa = $this->mapa(1, 'Planta');
    $caja = $this->trampa(10, $mapa, 3, 'caja');

    $desrat = $this->seguimiento(1, 1, roedores: [$this->roedor($caja, 10, 6)]);
    $insecto = $this->seguimiento(2, 3, roedores: [$this->roedor($caja, 0, 0)]);

    $porMapa = $this->invocar('procesarDatosPorMapa', [$desrat, $insecto]);

    $this->assertArrayHasKey('Planta', $porMapa);
    $this->assertCount(1, $porMapa['Planta']['filas']);
    $this->assertSame(40.0, $porMapa['Planta']['totales']['porcentaje_merma']);
  }

  public function test_procesar_datos_insectocutores_solo_lee_seguimientos_tipo_3(): void
  {
    $mapa = $this->mapa(1, 'Planta');
    $insectocutora = $this->trampa(20, $mapa, 2, 'insecto');

    $captura = function (int $cantidad) use ($insectocutora) {
      $i = new TrampaEspecieSeguimiento(['cantidad' => $cantidad]);
      $i->trampa_id = $insectocutora->id;
      $i->setRelation('trampa', $insectocutora);

      return $i;
    };

    $tipo3 = $this->seguimiento(1, 3, insectocutores: [$captura(5)]);
    // Una fumigación con capturas registradas no debe entrar a la tabla 5
    // (procesarInsectocutoresPorFecha tampoco la cuenta: serían inconsistentes).
    $tipo2 = $this->seguimiento(2, 2, insectocutores: [$captura(9)]);

    $filas = $this->invocar('procesarDatosInsectocutores', [$tipo3, $tipo2]);

    $this->assertCount(1, $filas);
    $this->assertSame(5, $filas[0]['cantidad_insectocutores']);
  }
}
