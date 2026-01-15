<?php

namespace App\Http\Controllers;

use App\Models\CobrarPago;
use App\Models\Compra;
use App\Models\EstadoResultado;
use App\Models\Gasto;
use App\Models\GastoExtra;
use App\Models\GastoFinanciero;
use App\Models\GastoOperativo;
use App\Models\Ingreso;
use App\Models\PagarPago;
use App\Models\User;
use App\Models\Venta;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class EstadosController extends Controller
{
  /**
   * Display a listing of the resource.
   */
  public function index(Request $request)
  {
    $estados = EstadoResultado::all();
    return inertia('admin/estados/index', ['estados' => $estados]);
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

  public function obtenerCierre(Request $request)
  {
    // $request->validate([
    //   'fecha_inicio' => 'required|date',
    //   'fecha_fin' => 'required|date|after_or_equal:fecha_inicio',
    // ]);
    $fecha_inicio = null;
    $fecha_fin = now();

    // Obtener ultimo cierre
    $ultimoEstado = EstadoResultado::orderBy('id', 'desc')->first();
    if ($ultimoEstado) {
      $fecha_inicio = $ultimoEstado->created_at;
    } else {
      $user = User::find(1);
      $fecha_inicio = $user->created_at;
    }

    // dd($fecha_inicio);
    Log::info("Fecha inicio: " . $fecha_inicio);
    // return response()->json($fecha_inicio);

    // Aquí deberías obtener los datos reales de tu base de datos
    // Este es un ejemplo de estructura de datos
    $estado = [
      'ingresos' => [
        'ventas' => $this->calcularVentas($fecha_inicio, $fecha_fin),
        'cobros' => $this->calcularCobros($fecha_inicio, $fecha_fin),
        'otros_ingresos' => $this->calcularOtrosIngresos($fecha_inicio, $fecha_fin),
      ],
      'costos' => [
        'compras' => $this->calcularCompras($fecha_inicio, $fecha_fin),
      ],
      'gastos' => [
        'operativos' => $this->calcularGastosOperativos($fecha_inicio, $fecha_fin),
        'financieros' => $this->calcularGastosFinancieros($fecha_inicio, $fecha_fin),
        'extraordinarios' => $this->calcularGastosExtraordinarios($fecha_inicio, $fecha_fin),
        'caja_chica' => $this->calcularCajaChica($fecha_inicio, $fecha_fin),
        'pagos' => $this->calcularPagos($fecha_inicio, $fecha_fin),
      ],
      'fecha_inicio' => $fecha_inicio,
      'fecha_fin' => $fecha_fin,
    ];

    return response()->json($estado);
  }


  public function obtenerEstado(Request $request)
  {
    $request->validate([
      'fecha_inicio' => 'required|date',
      'fecha_fin' => 'required|date|after_or_equal:fecha_inicio',
    ]);

    $f_inicio = \Carbon\Carbon::parse($request->fecha_inicio)->startOfDay(); // Establece a 00:00:00
    $f_fin = \Carbon\Carbon::parse($request->fecha_fin)->endOfDay(); // Establece a 23:59:59

    // Aquí deberías obtener los datos reales de tu base de datos
    // Este es un ejemplo de estructura de datos
    $estado = [
      'ingresos' => [
        'ventas' => $this->calcularVentas($f_inicio, $f_fin),
        'cobros' => $this->calcularCobros($f_inicio, $f_fin),
        'otros_ingresos' => $this->calcularOtrosIngresos($f_inicio, $f_fin),
      ],
      'costos' => [
        'compras' => $this->calcularCompras($f_inicio, $f_fin),
      ],
      'gastos' => [
        'operativos' => $this->calcularGastosOperativos($f_inicio, $f_fin),
        'financieros' => $this->calcularGastosFinancieros($f_inicio, $f_fin),
        'extraordinarios' => $this->calcularGastosExtraordinarios($f_inicio, $f_fin),
        'caja_chica' => $this->calcularCajaChica($f_inicio, $f_fin),
        'pagos' => $this->calcularPagos($f_inicio, $f_fin),
      ],
      'fecha_inicio' => $f_inicio,
      'fecha_fin' => $f_fin,
    ];

    return response()->json($estado);
  }

  public function cierre(Request $request)
  {

    // dd($request);

    $validated = $request->validate([
      'fecha_inicio' => 'required|date',
      'fecha_fin' => 'required|date',

      'ventas' => 'required|numeric',
      'cobros' => 'required|numeric',
      'otros_ingresos' => 'required|numeric',
      'ingresos_totales' => 'required|numeric',

      'compras' => 'required|numeric',
      'costos_totales' => 'required|numeric',

      'utilidad_bruta' => 'required|numeric',

      'operativos' => 'required|numeric',
      'financieros' => 'required|numeric',
      'extras' => 'required|numeric',
      'caja_chica' => 'required|numeric',
      'pagos' => 'required|numeric',
      'gastos_totales' => 'required|numeric',

      'utilidad_neta' => 'required|numeric',
    ]);

    // Aquí guardarías el cierre en la base de datos
    // Por ejemplo:
    // CierreFinanciero::create($request->all());
    $estado = new EstadoResultado();
    $estado->fecha_inicio = $validated['fecha_inicio'];
    $estado->fecha_fin = $validated['fecha_fin'];
    $estado->ventas = $validated['ventas'];
    $estado->cobrado = $validated['cobros'];
    $estado->otros_ingresos = $validated['otros_ingresos'];
    $estado->ingresos_totales = $validated['ingresos_totales'];
    $estado->compras = $validated['compras'];
    $estado->costo_total = $validated['costos_totales'];
    $estado->utilidad_bruta = $validated['utilidad_bruta'];
    $estado->gastosop = $validated['operativos'];
    $estado->gastosfin = $validated['financieros'];
    $estado->gastosext = $validated['extras'];
    $estado->gastos = $validated['caja_chica'];
    $estado->pagos = $validated['pagos'];
    $estado->total_gastos = $validated['gastos_totales'];
    $estado->utilidad_neta = $validated['utilidad_neta'];
    $estado->save();

    return redirect()->route('estados.index')
      ->with('success', 'Estado financiero cerrado correctamente');
  }

  // ------------------------
  // - INGRESOS
  // ------------------------

  // Métodos auxiliares para cálculos (reemplaza con tu lógica real)
  private function calcularVentas($inicio, $fin)
  {
    // $f_inicio = \Carbon\Carbon::parse($inicio)->startOfDay(); // Establece a 00:00:00
    // $f_fin = \Carbon\Carbon::parse($fin)->endOfDay(); // Establece a 23:59:59

    return Venta::whereBetween('created_at', [$inicio, $fin])->sum('total');
    // return 150000.00; // Ejemplo
  }
  private function calcularCobros($inicio, $fin)
  {
    // $f_inicio = \Carbon\Carbon::parse($inicio)->startOfDay(); // Establece a 00:00:00
    // $f_fin = \Carbon\Carbon::parse($fin)->endOfDay(); // Establece a 23:59:59

    return CobrarPago::whereBetween('created_at', [$inicio, $fin])->sum('monto');
    // return 150000.00; // Ejemplo
  }

  private function calcularOtrosIngresos($inicio, $fin)
  {
    // $f_inicio = \Carbon\Carbon::parse($inicio)->startOfDay(); // Establece a 00:00:00
    // $f_fin = \Carbon\Carbon::parse($fin)->endOfDay(); // Establece a 23:59:59
    return Ingreso::whereBetween('created_at', [$inicio, $fin])->sum('total');
    // return 5000.00; // Ejemplo
  }

  // ------------------------
  // - COSTOS
  // ------------------------
  private function calcularCompras($inicio, $fin)
  {
    // $f_inicio = \Carbon\Carbon::parse($inicio)->startOfDay(); // Establece a 00:00:00
    // $f_fin = \Carbon\Carbon::parse($fin)->endOfDay(); // Establece a 23:59:59
    return Compra::whereBetween('created_at', [$inicio, $fin])->sum('total');
    // return 80000.00; // Ejemplo
  }

  // ------------------------
  // - GASTOS
  // ------------------------

  private function calcularGastosOperativos($inicio, $fin)
  {
    // $f_inicio = \Carbon\Carbon::parse($inicio)->startOfDay(); // Establece a 00:00:00
    // $f_fin = \Carbon\Carbon::parse($fin)->endOfDay(); // Establece a 23:59:59
    return GastoOperativo::whereBetween('created_at', [$inicio, $fin])->sum('total');
    // return 20000.00; // Ejemplo
  }

  private function calcularGastosFinancieros($inicio, $fin)
  {
    // $f_inicio = \Carbon\Carbon::parse($inicio)->startOfDay(); // Establece a 00:00:00
    // $f_fin = \Carbon\Carbon::parse($fin)->endOfDay(); // Establece a 23:59:59
    return GastoFinanciero::whereBetween('created_at', [$inicio, $fin])->sum('total');
    // return 3000.00; // Ejemplo
  }

  private function calcularGastosExtraordinarios($inicio, $fin)
  {
    // $f_inicio = \Carbon\Carbon::parse($inicio)->startOfDay(); // Establece a 00:00:00
    // $f_fin = \Carbon\Carbon::parse($fin)->endOfDay(); // Establece a 23:59:59
    return GastoExtra::whereBetween('created_at', [$inicio, $fin])->sum('total');
    // return 2000.00; // Ejemplo
  }

  private function calcularCajaChica($inicio, $fin)
  {
    // $f_inicio = \Carbon\Carbon::parse($inicio)->startOfDay(); // Establece a 00:00:00
    // $f_fin = \Carbon\Carbon::parse($fin)->endOfDay(); // Establece a 23:59:59
    return Gasto::whereBetween('created_at', [$inicio, $fin])->sum('total');
    // return 1500.00; // Ejemplo
  }
  private function calcularPagos($inicio, $fin)
  {
    // $f_inicio = \Carbon\Carbon::parse($inicio)->startOfDay(); // Establece a 00:00:00
    // $f_fin = \Carbon\Carbon::parse($fin)->endOfDay(); // Establece a 23:59:59
    return PagarPago::whereBetween('created_at', [$inicio, $fin])->sum('monto');
    // return 1500.00; // Ejemplo
  }
}
