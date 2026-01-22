<?php

namespace App\Http\Controllers;

use App\Models\Almacen;
use App\Models\Empresa;
use App\Models\Seguimiento;
use App\Models\SeguimientoImage;
use Illuminate\Http\Request;
use Carbon\Carbon;
use Illuminate\Support\Facades\Log;

class InformesController extends Controller
{
    public function index(Request $request)
    {
        // return inertia('admin/informes/index');

        // -----------------------------
        // $empresas = Empresa::select('id', 'nombre')->get();

        // $almacenes = [];
        // if ($request->empresa_id) {
        //     Log::info("Conseguir almacenes");
        //     $almacenes = Almacen::where('empresa_id', $request->empresa_id)
        //         ->select('id', 'nombre')
        //         ->get();
        // }

        // $seguimientos = [];
        // if ($request->almacen_id) {
        //     $seguimientos = Seguimiento::where('almacen_id', $request->almacen_id)
        //         ->latest()
        //         ->get(['id', 'created_at']);
        // }

        // return inertia('admin/informes/index', [
        //     'empresas'     => $empresas,
        //     'almacenes'    => $almacenes,
        //     'seguimientos' => $seguimientos,
        //     'filters' => $request->only('empresa_id', 'almacen_id'),
        // ]);

        // -------------------------------------
        $empresas = Empresa::select('id', 'nombre')->get();

        $almacenes = [];
        if ($request->empresa_id) {
            $almacenes = Almacen::where('empresa_id', $request->empresa_id)
                ->select('id', 'nombre')
                ->get();
        }

        // 🔴 SOLO buscar si presiona el botón
        $seguimientos = [];
        if (
            $request->filled('buscar') &&
            $request->almacen_id &&
            $request->fecha_inicio &&
            $request->fecha_fin
        ) {
            $seguimientos = Seguimiento::where('almacen_id', $request->almacen_id)
                ->whereBetween('created_at', [
                    $request->fecha_inicio . ' 00:00:00',
                    $request->fecha_fin . ' 23:59:59',
                ])
                ->orderBy('created_at', 'desc')
                ->get(['id', 'created_at']);
        }

        return inertia('admin/informes/index', [
            'empresas'     => $empresas,
            'almacenes'    => $almacenes,
            'seguimientos' => $seguimientos,
            'filters' => $request->only(
                'empresa_id',
                'almacen_id',
                'fecha_inicio',
                'fecha_fin'
            ),
        ]);
    }

    public function create() {}

    public function store(Request $request) {}

    public function show(string $id) {}

    public function edit(string $id) {}

    public function update(Request $request, string $id) {}

    public function destroy(string $id) {}

    public function obtenerEstado(Request $request)
    {
        $request->validate([
            'fecha_inicio' => 'required|date',
            'fecha_fin' => 'required|date|after_or_equal:fecha_inicio',
        ]);

        $f_inicio = Carbon::parse($request->fecha_inicio)->startOfDay(); // Establece a 00:00:00
        $f_fin = Carbon::parse($request->fecha_fin)->endOfDay(); // Establece a 23:59:59

        // Aquí deberías obtener los datos reales de tu base de datos
        // Este es un ejemplo de estructura de datos
        // $estado = [
        //     'ingresos' => [
        //         'ventas' => $this->calcularVentas($f_inicio, $f_fin),
        //         'cobros' => $this->calcularCobros($f_inicio, $f_fin),
        //         'otros_ingresos' => $this->calcularOtrosIngresos($f_inicio, $f_fin),
        //     ],
        //     'costos' => [
        //         'compras' => $this->calcularCompras($f_inicio, $f_fin),
        //     ],
        //     'gastos' => [
        //         'operativos' => $this->calcularGastosOperativos($f_inicio, $f_fin),
        //         'financieros' => $this->calcularGastosFinancieros($f_inicio, $f_fin),
        //         'extraordinarios' => $this->calcularGastosExtraordinarios($f_inicio, $f_fin),
        //         'caja_chica' => $this->calcularCajaChica($f_inicio, $f_fin),
        //         'pagos' => $this->calcularPagos($f_inicio, $f_fin),
        //     ],
        //     'fecha_inicio' => $f_inicio,
        //     'fecha_fin' => $f_fin,
        // ];

        // Conseguir imagenes

        // Conseguir datos de productos usados
        // Conseguir trampas seguimiento ROEDORES
        // Conseguir trampas seguimiento INSECTOS

        $almacen_id = 1;

        $informe = [

            'imagenes' => $this->conseguirImagenes($f_inicio, $f_fin, $almacen_id),
        ];

        return response()->json($informe);
    }

    private function conseguirImagenes($inicio, $fin, $almacen_id)
    {
        return SeguimientoImage::whereBetween('created_at', [$inicio, $fin])->where('almacen');
    }

    private function getEmpresas()
    {
        $empresas = Empresa::select('id', 'nombre')->get();
        // dd($empresas);
        return  response()->json($empresas);
    }

    private function getAlmacen(Request $request, string $id)
    {
        $almacenes = Almacen::where('empresa_id', $id)->select('id', 'nombre')->get();
        return response()->json($almacenes);
    }

    private function getSeguimientos(Request $request, string $id)
    {
        $seguimientos = Seguimiento::where('almacen_id', $id)->select('id', 'created_at')->latest()->get();
        return response()->json($seguimientos);
    }
}
