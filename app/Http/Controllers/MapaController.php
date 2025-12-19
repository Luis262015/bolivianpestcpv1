<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class MapaController extends Controller
{
  public function index(Request $request)
  {
    return inertia('admin/mapas/lista');
  }

  public function create() {}

  public function store(Request $request) {}

  public function show(string $id) {}

  public function edit(string $id) {}

  public function update(Request $request, string $id) {}

  public function destroy(string $id) {}
}
