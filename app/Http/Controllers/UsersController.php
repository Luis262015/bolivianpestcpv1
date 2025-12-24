<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Spatie\Permission\Models\Role;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\Rules;
use Illuminate\Validation\Rule;

class UsersController extends Controller
{
  public function index()
  {
    // $roles = Role::select('id', 'name')->where('name', '!=', 'superadmin')->get();
    $usuarios = User::select('id', 'name', 'email')->with('roles')->paginate(20);
    $roles = Role::select('id', 'name')->where('name', '!=', 'superadmin')->get();
    return inertia('admin/usuarios/index', ['users' => $usuarios, 'roles' => $roles]);
  }

  public function create()
  {
    $roles = Role::select('id', 'name')->where('name', '!=', 'superadmin')->get();
    return inertia('admin/usuarios/crear', ['usuario' => new User(), 'roles' => $roles]);
  }

  public function store(Request $request)
  {

    // dd($request);

    $validated = $request->validate([
      'name' => 'required|string|min:5|max:255',
      'email' => 'required|string|lowercase|email|max:255|unique:' . User::class,
      'password' => ['required', 'confirmed', Rules\Password::defaults()],
      'role' => ['required', Rule::exists('roles', 'id')->whereNot('name', 'superadmin')],
      'enable' => 'sometimes|boolean', // Acepta true/false, 1/0, "1"/"0"
    ]);
    $user = User::create(
      [
        'name' => $validated['name'],
        'email' => $validated['email'],
        'password' => Hash::make($validated['password']),
        'enable' => $validated['enable'] ?? false, // Por defecto false
      ]
    );
    $role = Role::findById($validated['role']);
    $user->assignRole($role);
    return redirect()->route('usuarios.index')->with('success', 'Usuario creado y rol asignado correctamente.');
  }

  public function show(string $id) {}

  public function edit(User $usuario)
  {
    $usuario->load('roles');
    return inertia('admin/usuarios/editar', [
      'user' => [
        'id' => $usuario->id,
        'name' => $usuario->name,
        'email' => $usuario->email,
        'role' => $usuario->roles->first(),
        'enable' => $usuario->enable,
      ],
      'roles' => Role::all(['id', 'name']),
    ]);
  }

  public function update(Request $request, User $usuario)
  {
    $request->validate([
      'name' => 'required|string|max:255',
      'email' => 'required|email|unique:users,email,' . $usuario->id,
      'password' => 'nullable|min:8|confirmed',
      'role' => 'nullable|exists:roles,id',
      'enable' => 'sometimes|boolean', // Acepta true/false, 1/0, "1"/"0"
    ]);
    $data = [
      'name' => $request->name,
      'email' => $request->email,
      'enable' => $request->enable,
    ];
    if ($request->filled('password')) {
      $data['password'] = Hash::make($request->password);
    }
    $usuario->update($data);
    // Asignar rol con Spatie
    if ($request->role) {
      $role = Role::find($request->role);
      $usuario->syncRoles([$role->name]);
    } else {
      $usuario->syncRoles([]);
    }
    return redirect()->route('usuarios.index')->with('success', 'Usuario actualizado');
  }

  public function destroy(string $id)
  {
    $user = User::find($id);
    $user->deleteOrFail();
    return redirect()->route('usuarios.index')->with('success', 'Usuario eliminado');
  }
}
