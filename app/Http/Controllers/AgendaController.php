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
    'hour' => 'sometimes|nullable|date_format:H:i',
    // 'hour' => 'sometimes|string',
    'color' => 'sometimes|required|string|in:bg-red-500,bg-blue-500,bg-green-500,bg-yellow-500,bg-purple-500,bg-pink-600,bg-teal-500',
    'status' => 'sometimes|required|in:pendiente,postergado,completado',
  ];

  public function index()
  {
    $tareas = Agenda::get(['id', 'title', 'date', 'color', 'status', 'user_id']);
    return inertia('admin/agenda/index', [ // Ajusta la ruta del componente Inertia si es necesario
      'tareas' => $tareas,
    ]);
  }

  public function create() {}

  public function store(Request $request)
  {
    // dd($request);
    $validated = $request->validate($this->toValidated);


    // $validated['hour'] = $validated['hour'] . ":00";

    $task = Agenda::create([
      'user_id' => Auth::id(),
      ...$validated,
    ]);

    // $task = new Agenda();
    // $task->user_id = Auth::id();
    // $task->title = $validated['title'];
    // $task->date = $validated['date'];
    // $task->hour = $validated['hour'];
    // $task->color = $validated['color'];

    return redirect()->route('agendas.index')->with('success', 'Tarea creada correctamente');
  }

  public function show(string $id) {}

  public function edit(string $id) {}

  public function update(Request $request, Agenda $agenda)
  {
    $this->authorizeTask($agenda);

    $validated = $request->validate($this->toValidated);
    $agenda->update($validated);

    return redirect()->route('agendas.index')->with('success', 'Tarea actualizada correctamente');
  }

  public function destroy(Agenda $agenda)
  {
    $this->authorizeTask($agenda);
    $agenda->delete();
    return redirect()->route('agendas.index')->with('success', 'Tarea eliminada correctamente');
  }

  // Método auxiliar para autorización
  protected function authorizeTask(Agenda $agenda)
  {
    if ($agenda->user_id !== Auth::id()) {
      abort(403);
    }
  }
}
