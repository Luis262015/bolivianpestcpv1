<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class EstadosController extends Controller
{
  /**
   * Display a listing of the resource.
   */
  public function index(Request $request)
  {
    return inertia('admin/estados/index');
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
  public function update(Request $request, string $id)
  {
    //
  }

  /**
   * Remove the specified resource from storage.
   */
  public function destroy(string $id)
  {
    //
  }


  public function obtenerEstado(Request $request)
  {
    $request->validate([
      'fecha_inicio' => 'required|date',
      'fecha_fin' => 'required|date|after_or_equal:fecha_inicio',
    ]);

    // Aquí deberías obtener los datos reales de tu base de datos
    // Este es un ejemplo de estructura de datos
    $estado = [
      'ingresos' => [
        'ventas' => $this->calcularVentas($request->fecha_inicio, $request->fecha_fin),
        'otros_ingresos' => $this->calcularOtrosIngresos($request->fecha_inicio, $request->fecha_fin),
      ],
      'costos' => [
        'compras' => $this->calcularCompras($request->fecha_inicio, $request->fecha_fin),
      ],
      'gastos' => [
        'operativos' => $this->calcularGastosOperativos($request->fecha_inicio, $request->fecha_fin),
        'financieros' => $this->calcularGastosFinancieros($request->fecha_inicio, $request->fecha_fin),
        'extraordinarios' => $this->calcularGastosExtraordinarios($request->fecha_inicio, $request->fecha_fin),
        'caja_chica' => $this->calcularCajaChica($request->fecha_inicio, $request->fecha_fin),
      ],
      'fecha_inicio' => $request->fecha_inicio,
      'fecha_fin' => $request->fecha_fin,
    ];

    return response()->json($estado);
  }

  public function cierre(Request $request)
  {
    $request->validate([
      'fecha_inicio' => 'required|date',
      'fecha_fin' => 'required|date',
      'ingresos_totales' => 'required|numeric',
      'costos_totales' => 'required|numeric',
      'utilidad_bruta' => 'required|numeric',
      'gastos_totales' => 'required|numeric',
      'utilidad_neta' => 'required|numeric',
    ]);

    // Aquí guardarías el cierre en la base de datos
    // Por ejemplo:
    // CierreFinanciero::create($request->all());

    return redirect()->route('estados.index')
      ->with('success', 'Estado financiero cerrado correctamente');
  }

  // Métodos auxiliares para cálculos (reemplaza con tu lógica real)
  private function calcularVentas($inicio, $fin)
  {
    // return Venta::whereBetween('fecha', [$inicio, $fin])->sum('total');
    return 150000.00; // Ejemplo
  }

  private function calcularOtrosIngresos($inicio, $fin)
  {
    return 5000.00; // Ejemplo
  }

  private function calcularCompras($inicio, $fin)
  {
    return 80000.00; // Ejemplo
  }

  private function calcularGastosOperativos($inicio, $fin)
  {
    return 20000.00; // Ejemplo
  }

  private function calcularGastosFinancieros($inicio, $fin)
  {
    return 3000.00; // Ejemplo
  }

  private function calcularGastosExtraordinarios($inicio, $fin)
  {
    return 2000.00; // Ejemplo
  }

  private function calcularCajaChica($inicio, $fin)
  {
    return 1500.00; // Ejemplo
  }
}