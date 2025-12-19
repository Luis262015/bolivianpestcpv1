<?php

namespace App\Http\Controllers;

use App\Models\CuentaPagar;
use Illuminate\Http\Request;

class CuentasPorPagarController extends Controller
{
  public function index()
  {
    $cuentaspagar = CuentaPagar::select()->with(['proveedor' => function ($query) {
      $query->select('id', 'nombre');
    }])->paginate(20);
    return inertia('admin/cuentasporpagar/lista', ['cuentaspagar' => $cuentaspagar]);
  }

  public function create() {}

  public function store(Request $request) {}

  public function show(string $id) {}

  public function edit(string $id) {}

  public function update(Request $request, string $id) {}

  public function destroy(string $id) {}
}
