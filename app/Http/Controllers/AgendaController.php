<?php

namespace App\Http\Controllers;

use App\Models\Agenda;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class AgendaController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //

        $tasks = Agenda::mine()
            ->orderBy('date')
            ->get()
            ->map(fn($task) => [
                'id' => (string) $task->id,
                'title' => $task->title,
                'date' => $task->date->format('Y-m-d'),
                'color' => $task->color,
                'status' => $task->status,
            ]);

        // dd($tasks);

        return inertia('admin/agenda/index', [
            'initialTasks' => $tasks,
        ]);
        // return inertia('admin/agenda/index');
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
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
            'date' => $task->date->format('Y-m-d'),
            'color' => $task->color,
            'status' => $task->status,
        ]);
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Agenda $agenda)
    {
        //
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
            'date' => $agenda->date->format('Y-m-d'),
            'color' => $agenda->color,
            'status' => $agenda->status,
        ]);
    }

    /**
     * Remove the specified resource from storage.
     */
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
