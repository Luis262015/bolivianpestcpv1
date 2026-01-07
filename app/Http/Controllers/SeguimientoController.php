<?php

namespace App\Http\Controllers;

use App\Models\Almacen;
use App\Models\Biologico;
use App\Models\Empresa;
use App\Models\Epp;
use App\Models\Especie;
use App\Models\Metodo;
use App\Models\Proteccion;
use App\Models\Seguimiento;
use App\Models\Signo;
use App\Models\TipoSeguimiento;
use Illuminate\Http\Request;

class SeguimientoController extends Controller
{
  public function index()
  {
    $empresas = Empresa::select('id', 'nombre')->get();
    $almacenes = Almacen::select('id', 'nombre')->get();
    $biologicos = Biologico::orderBy('nombre')->get();
    $epps = Epp::orderBy('nombre')->get();
    $metodos = Metodo::orderBy('nombre')->get();
    $protecciones = Proteccion::orderBy('nombre')->get();
    $signos = Signo::orderBy('nombre')->get();
    $tiposSeguimiento = TipoSeguimiento::orderBy('nombre')->get();
    $especies = Especie::orderBy('nombre')->get();
    return inertia('admin/seguimientos/lista', [
      'empresas' => $empresas,
      'almacenes' => $almacenes,
      'biologicos' => $biologicos,
      'epps' => $epps,
      'metodos' => $metodos,
      'protecciones' => $protecciones,
      'signos' => $signos,
      'tipoSeguimiento' => $tiposSeguimiento,
      'especies' => $especies,
    ]);
  }

  public function create()
  {
    $empresas = Empresa::select('id', 'nombre')->get();
    $almacenes = Almacen::select('id', 'nombre')->get();
    $biologicos = Biologico::orderBy('nombre')->get();
    $epps = Epp::orderBy('nombre')->get();
    $metodos = Metodo::orderBy('nombre')->get();
    $protecciones = Proteccion::orderBy('nombre')->get();
    $signos = Signo::orderBy('nombre')->get();
    return inertia('admin/seguimientos/crear', [
      'empresas' => $empresas,
      'almacenes' => $almacenes,
      'biologicos' => $biologicos,
      'epps' => $epps,
      'metodos' => $metodos,
      'protecciones' => $protecciones,
      'signos' => $signos,
    ]);
  }

  public function store(Request $request) {}

  public function show(string $id) {}

  public function edit(string $id) {}

  public function update(Request $request, string $id) {}

  public function destroy(string $id) {}
}