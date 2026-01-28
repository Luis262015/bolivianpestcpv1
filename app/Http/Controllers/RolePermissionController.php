<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Spatie\Permission\Models\Permission;
use Spatie\Permission\Models\Role;

class RolePermissionController extends Controller
{
  public function index()
  {
    $roles = Role::with('permissions')->paginate(10);
    $permissions = Permission::all();
    return inertia('admin/roles/index', [
      'roles' => $roles,
      'permissions' => $permissions,
    ]);
  }

  public function store(Request $request)
  {
    $request->validate([
      'name' => 'required|unique:roles,name',
      'permissions' => 'array',
      'permissions.*' => 'exists:permissions,id',
    ]);
    $role = Role::create(['name' => $request->name]);
    $role->givePermissionTo($request->permissions ?? []);
    return redirect()->back()->with('success', 'Rol creado exitosamente.');
  }

  public function update(Request $request, Role $role)
  {
    $request->validate([
      'name' => 'required|unique:roles,name,' . $role->id,
      'permissions' => 'array',
      'permissions.*' => 'exists:permissions,id',
    ]);
    $role->update(['name' => $request->name]);
    $role->syncPermissions($request->permissions ?? []);
    return redirect()->back()->with('success', 'Rol actualizado exitosamente.');
  }

  public function destroy(Role $role)
  {
    $role->delete();
    return redirect()->back()->with('success', 'Rol eliminado.');
  }

  public function assignToUser(Request $request, Role $role)
  {
    $request->validate([
      'user_id' => 'required|exists:users,id',
    ]);
    $user = User::find($request->user_id);
    $user->assignRole($role->name);
    return redirect()->back()->with('success', 'Rol asignado al usuario.');
  }

  /** FUNCIONES NO USADAS */
  // public function create() {}
  // public function show(string $id) {}
  // public function edit(string $id) {}
}
