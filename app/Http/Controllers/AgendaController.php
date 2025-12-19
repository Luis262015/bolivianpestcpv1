<?php

namespace App\Http\Controllers;

use App\Models\Agenda;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use DateTime;

class AgendaController extends Controller
{
  public function index()
  {
    $tasks = Agenda::mine()
      ->orderBy('date')
      ->get()
      ->map(fn($task) => [
        'id' => (string) $task->id,
        'title' => $task->title,
        'date' => (new DateTime($task->date))->format('Y-m-d'),
        'color' => $task->color,
        'status' => $task->status,
      ]);
    return inertia('admin/agenda/index', [
      'initialTasks' => $tasks,
    ]);
  }

  public function create() {}

  public function store(Request $request)
  {
    $validated = $request->validate([
      'title' => 'required|string|max:255',
      'date' => 'required|date_format:Y-m-d',
      'color' => 'required|string|in:bg-red-500,bg-blue-500,bg-green-500,bg-yellow-500,bg-purple-500',
      'status' => 'required|in:pendiente,postergado,completado',
    ]);

    $task = Agenda::create([
      'user_id' => Auth::id(),
      ...$validated,
    ]);

    return response()->json([
      'id' => (string) $task->id,
      'title' => $task->title,
      'date' => (new DateTime($task->date))->format('Y-m-d'),
      'color' => $task->color,
      'status' => $task->status,
    ]);
  }

  public function show(string $id) {}

  public function edit(string $id) {}

  public function update(Request $request, Agenda $agenda)
  {
    $this->authorizeTask($agenda);

    $validated = $request->validate([
      'title' => 'sometimes|required|string|max:255',
      'date' => 'sometimes|required|date_format:Y-m-d',
      'color' => 'sometimes|required|string|in:bg-red-500,bg-blue-500,bg-green-500,bg-yellow-500,bg-purple-500',
      'status' => 'sometimes|required|in:pendiente,postergado,completado',
    ]);

    $agenda->update($validated);

    return response()->json([
      'id' => (string) $agenda->id,
      'title' => $agenda->title,
      'date' => (new DateTime($agenda->date))->format('Y-m-d'),
      'color' => $agenda->color,
      'status' => $agenda->status,
    ]);
  }

  public function destroy(Agenda $agenda)
  {
    //
    $this->authorizeTask($agenda);
    $agenda->delete();

    return response()->json(['message' => 'Tarea eliminada']);
  }

  // Método auxiliar para autorización
  protected function authorizeTask(Agenda $agenda)
  {
    if ($agenda->user_id !== Auth::id()) {
      abort(403);
    }
  }
}
