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
use Barryvdh\DomPDF\Facade\Pdf;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use Carbon\Carbon;

class EstadosController extends Controller
{
  public function index()
  {
    $estados = EstadoResultado::all();
    return inertia('admin/estados/index', ['estados' => $estados]);
  }

  public function obtenerCierre()
  {
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

    $f_inicio = Carbon::parse($request->fecha_inicio)->startOfDay(); // Establece a 00:00:00
    $f_fin = Carbon::parse($request->fecha_fin)->endOfDay(); // Establece a 23:59:59

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

    $estado = new EstadoResultado();
    $estado->fecha_inicio = Carbon::parse($validated['fecha_inicio']);
    $estado->fecha_fin =  Carbon::parse($validated['fecha_fin']);
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
  private function calcularVentas($inicio, $fin)
  {
    return Venta::whereBetween('created_at', [$inicio, $fin])->sum('total');
  }

  private function calcularCobros($inicio, $fin)
  {
    return CobrarPago::whereBetween('created_at', [$inicio, $fin])->sum('monto');
  }

  private function calcularOtrosIngresos($inicio, $fin)
  {
    return Ingreso::whereBetween('created_at', [$inicio, $fin])->sum('total');
  }

  // ------------------------
  // - COSTOS
  // ------------------------
  private function calcularCompras($inicio, $fin)
  {
    return Compra::whereBetween('created_at', [$inicio, $fin])->sum('total');
  }

  // ------------------------
  // - GASTOS
  // ------------------------

  private function calcularGastosOperativos($inicio, $fin)
  {
    return GastoOperativo::whereBetween('created_at', [$inicio, $fin])->sum('total');
  }

  private function calcularGastosFinancieros($inicio, $fin)
  {
    return GastoFinanciero::whereBetween('created_at', [$inicio, $fin])->sum('total');
  }

  private function calcularGastosExtraordinarios($inicio, $fin)
  {
    return GastoExtra::whereBetween('created_at', [$inicio, $fin])->sum('total');
  }

  private function calcularCajaChica($inicio, $fin)
  {
    return Gasto::whereBetween('created_at', [$inicio, $fin])->sum('total');
  }

  private function calcularPagos($inicio, $fin)
  {
    return PagarPago::whereBetween('created_at', [$inicio, $fin])->sum('monto');
  }

  public function pdf(Request $request, string $id)
  {
    $estado = EstadoResultado::find($id);
    $pdf = Pdf::loadView('pdf.cierre', compact('estado'));
    $pdf->setPaper('letter', 'portrait');
    return $pdf->stream(filename: 'cierre-' . now()->format('Y-m-d') . '.pdf');
  }

  /** FUNCIONES NO USADAS */
  // public function create() {}
  // public function store(Request $request) {}
  // public function show(string $id) {}
  // public function edit(string $id) {}
  // public function update(Request $request, string $id) {}
  // public function destroy(string $id) {}
}
