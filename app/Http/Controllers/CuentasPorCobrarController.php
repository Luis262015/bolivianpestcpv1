<?php

namespace App\Http\Controllers;

use App\Models\CuentaCobrar;
use Illuminate\Http\Request;

class CuentasPorCobrarController extends Controller
{
  public function index()
  {
    $cuentascobrar = CuentaCobrar::paginate(20);
    return inertia('admin/cuentasporcobrar/lista', ['cuentascobrar' =>  $cuentascobrar]);
  }

  public function create() {}

  public function store(Request $request) {}

  public function show(string $id) {}

  public function edit(string $id) {}

  public function update(Request $request, string $id) {}

  public function destroy(string $id) {}
}
