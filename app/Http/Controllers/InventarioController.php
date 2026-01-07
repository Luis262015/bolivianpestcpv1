<?php

namespace App\Http\Controllers;

use App\Models\Kardex;
use Illuminate\Http\Request;

class InventarioController extends Controller
{
  public function index()
  {
    $lista = Kardex::with(['producto'])->paginate(20);
    return inertia('admin/inventario/lista', ['lista' => $lista]);
  }

  public function create() {}

  public function store(Request $request) {}

  public function show(string $id) {}

  public function edit(string $id) {}

  public function update(Request $request, string $id) {}

  public function destroy(string $id) {}
}
