<?php

namespace App\Http\Controllers;

use App\Models\Epp;
use Illuminate\Http\Request;

class EppsController extends Controller
{
  public function index()
  {
    $epps = Epp::select('id', 'nombre')->paginate(20);
    return inertia('admin/epps/index', ['items' => $epps]);
  }

  public function create()
  {
    return inertia('admin/epps/crear', ['epp' => new Epp()]);
  }

  public function store(Request $request)
  {
    $validated = $request->validate(['nombre' => ['required', 'string', 'max:255'],]);
    Epp::create($validated);
    return redirect()->route('epps.index');
  }

  public function show(string $id) {}

  public function edit(string $id)
  {
    $epp = Epp::find($id);
    return inertia('admin/epps/editar', ['epp' => $epp]);
  }

  public function update(Request $request, string $id)
  {
    $validated = $request->validate(['nombre' => ['required', 'string', 'max:255'],]);
    $epp = Epp::find($id);
    $epp->update($validated);
    return redirect()->route('epps.index');
  }

  public function destroy(string $id)
  {
    $epp = Epp::find($id);
    $epp->delete();
    return redirect()->route('epps.index');
  }
}