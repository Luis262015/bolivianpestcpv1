<?php

namespace App\Http\Controllers;

use App\Models\Agenda;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use DateTime;

class AgendaController extends Controller
{

  private $toValidated = [
    'title' => 'sometimes|required|string|max:255',
    'date' => 'sometimes|required|date_format:Y-m-d',
    'color' => 'sometimes|required|string|in:bg-red-500,bg-blue-500,bg-green-500,bg-yellow-500,bg-purple-500,bg-pink-600,bg-teal-500',
    'status' => 'sometimes|required|in:pendiente,postergado,completado',
  ];

  public function index()
  {
    // $tasks = Agenda::mine()
    //   ->orderBy('date')
    //   ->get()
    //   ->map(fn($task) => [
    //     'id' => (string) $task->id,
    //     'title' => $task->title,
    //     'date' => (new DateTime($task->date))->format('Y-m-d'),
    //     'color' => $task->color,
    //     'status' => $task->status,
    //   ]);
    // return inertia('admin/agenda/index', [
    //   'initialTasks' => $tasks,      
    // ]);

    $tareas = Agenda::get(['id', 'title', 'date', 'color', 'status', 'user_id']);


    return inertia('admin/agenda/index', [ // Ajusta la ruta del componente Inertia si es necesario
      'tareas' => $tareas,
    ]);
  }

  public function create() {}

  public function store(Request $request)
  {
    $validated = $request->validate($this->toValidated);
    $task = Agenda::create([
      'user_id' => Auth::id(),
      ...$validated,
    ]);

    return redirect()->route('agendas.index')->with('success', 'Tarea creada correctamente');

    // return response()->json([
    //   'id' => (string) $task->id,
    //   'title' => $task->title,
    //   'date' => (new DateTime($task->date))->format('Y-m-d'),
    //   'color' => $task->color,
    //   'status' => $task->status,
    // ]);
  }

  public function show(string $id) {}

  public function edit(string $id) {}

  public function update(Request $request, Agenda $agenda)
  {

    // dd($agenda);
    //dd($request);

    $this->authorizeTask($agenda);

    $validated = $request->validate($this->toValidated);

    $agenda->update($validated);

    return redirect()->route('agendas.index')->with('success', 'Tarea actualizada correctamente');

    // return response()->json([
    //   'id' => (string) $agenda->id,
    //   'title' => $agenda->title,
    //   'date' => (new DateTime($agenda->date))->format('Y-m-d'),
    //   'color' => $agenda->color,
    //   'status' => $agenda->status,
    // ]);
  }

  public function destroy(Agenda $agenda)
  {
    $this->authorizeTask($agenda);
    $agenda->delete();
    return redirect()->route('agendas.index')->with('success', 'Tarea eliminada correctamente');
    // return response()->json(['message' => 'Tarea eliminada']);

  }

  // Método auxiliar para autorización
  protected function authorizeTask(Agenda $agenda)
  {
    if ($agenda->user_id !== Auth::id()) {
      abort(403);
    }
  }
}