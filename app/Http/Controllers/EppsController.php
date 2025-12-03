<?php

namespace App\Http\Controllers;

use App\Models\Epp;
use Illuminate\Http\Request;

class EppsController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
        $epps = Epp::select('id', 'nombre')->paginate(20);
        return inertia('admin/epps/lista', ['epps' => $epps]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
        return inertia('admin/epps/crear', ['epp' => new Epp()]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
        $validated = $request->validate(['nombre' => ['required', 'string', 'max:255'],]);

        Epp::create($validated);

        return redirect()->route('epps.index');
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
        $epp = Epp::find($id);
        return inertia('admin/epps/editar', ['epp' => $epp]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
        $validated = $request->validate(['nombre' => ['required', 'string', 'max:255'],]);

        $epp = Epp::find($id);
        $epp->update($validated);

        return redirect()->route('epps.index');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
        $epp = Epp::find($id);
        $epp->delete();

        return redirect()->route('epps.index');
    }
}
