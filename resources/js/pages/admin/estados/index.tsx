import { Alert, AlertDescription } from '@/components/ui/alert';
import { Button } from '@/components/ui/button';
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from '@/components/ui/card';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Separator } from '@/components/ui/separator';
import AppLayout from '@/layouts/app-layout';
import { type BreadcrumbItem } from '@/types';
import { Head, router } from '@inertiajs/react';
import {
  AlertCircle,
  Calendar,
  CheckCircle2,
  FileText,
  Loader2,
} from 'lucide-react';
import { useState } from 'react';

interface EstadoResultados {
  ingresos: {
    ventas: number;
    cobros: number;
    otros_ingresos: number;
  };
  costos: {
    compras: number;
  };
  gastos: {
    operativos: number;
    financieros: number;
    extraordinarios: number;
    caja_chica: number;
    pagos: number;
  };
  fecha_inicio: string;
  fecha_fin: string;
}

const breadcrumbs: BreadcrumbItem[] = [
  {
    title: 'Estados',
    href: '/estados',
  },
];

export default function Lista() {
  const [fechaInicio, setFechaInicio] = useState('');
  const [fechaFin, setFechaFin] = useState('');
  const [estado, setEstado] = useState<EstadoResultados | null>(null);
  const [loading, setLoading] = useState(false);
  const [procesando, setProcesando] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [success, setSuccess] = useState<string | null>(null);

  // Calcular totales
  const ingresosTotales = estado
    ? estado.ingresos.ventas +
      estado.ingresos.otros_ingresos +
      estado.ingresos.cobros
    : 0;

  const costosTotales = estado ? estado.costos.compras : 0;

  const utilidadBruta = ingresosTotales - costosTotales;

  const gastosTotales = estado
    ? estado.gastos.operativos +
      estado.gastos.financieros +
      estado.gastos.extraordinarios +
      estado.gastos.caja_chica +
      estado.gastos.pagos
    : 0;

  const utilidadNeta = utilidadBruta - gastosTotales;

  const handleCargarDatos = async () => {
    if (!fechaInicio || !fechaFin) {
      setError('Por favor selecciona ambas fechas');
      setSuccess(null);
      return;
    }

    setLoading(true);
    setError(null);
    setSuccess(null);

    try {
      const response = await fetch(
        `/estados/obtener?fecha_inicio=${fechaInicio}&fecha_fin=${fechaFin}`,
      );

      if (!response.ok) {
        throw new Error('Error al cargar los datos');
      }

      const data = await response.json();
      setEstado(data);
      setSuccess('Datos cargados correctamente');
    } catch (err) {
      setError(
        'No se pudieron cargar los datos. Por favor intenta nuevamente.',
      );
      setEstado(null);
    } finally {
      setLoading(false);
    }
  };

  const handleCierre = () => {
    if (!estado) return;

    setProcesando(true);
    setError(null);
    setSuccess(null);

    router.post(
      '/estados/cierre',
      {
        fecha_inicio: estado.fecha_inicio,
        fecha_fin: estado.fecha_fin,
        ingresos_totales: ingresosTotales,
        costos_totales: costosTotales,
        utilidad_bruta: utilidadBruta,
        gastos_totales: gastosTotales,
        utilidad_neta: utilidadNeta,
      },
      {
        onSuccess: () => {
          setSuccess('Cierre realizado correctamente');
          setEstado(null);
          setFechaInicio('');
          setFechaFin('');
        },
        onError: (errors) => {
          setError(
            'No se pudo realizar el cierre. Por favor verifica los datos.',
          );
        },
        onFinish: () => setProcesando(false),
      },
    );
  };

  const formatCurrency = (value: number) => {
    return new Intl.NumberFormat('es-BO', {
      style: 'currency',
      currency: 'BOB',
      minimumFractionDigits: 2,
    }).format(value);
  };

  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Estados Financieros" />

      <div className="space-y-6">
        {/* Alertas */}
        {error && (
          <Alert variant="destructive">
            <AlertCircle className="h-4 w-4" />
            <AlertDescription>{error}</AlertDescription>
          </Alert>
        )}

        {success && (
          <Alert className="border-green-500 bg-green-50">
            <CheckCircle2 className="h-4 w-4 text-green-600" />
            <AlertDescription className="text-green-600">
              {success}
            </AlertDescription>
          </Alert>
        )}

        {/* Filtros de fecha */}
        <Card>
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              <Calendar className="h-5 w-5" />
              Periodo a Consultar
            </CardTitle>
            <CardDescription>
              Selecciona el rango de fechas para generar el estado de resultados
            </CardDescription>
          </CardHeader>
          <CardContent>
            <div className="grid grid-cols-1 gap-4 md:grid-cols-3">
              <div className="space-y-2">
                <Label htmlFor="fecha_inicio">Fecha Inicio</Label>
                <Input
                  id="fecha_inicio"
                  type="date"
                  value={fechaInicio}
                  onChange={(e) => setFechaInicio(e.target.value)}
                />
              </div>

              <div className="space-y-2">
                <Label htmlFor="fecha_fin">Fecha Fin</Label>
                <Input
                  id="fecha_fin"
                  type="date"
                  value={fechaFin}
                  onChange={(e) => setFechaFin(e.target.value)}
                  min={fechaInicio}
                />
              </div>

              <div className="flex items-end">
                <Button
                  onClick={handleCargarDatos}
                  disabled={loading}
                  className="w-full"
                >
                  {loading && <Loader2 className="mr-2 h-4 w-4 animate-spin" />}
                  Cargar Datos
                </Button>
              </div>
            </div>
          </CardContent>
        </Card>

        {/* Estado de Resultados */}
        {estado && (
          <Card>
            <CardHeader>
              <CardTitle className="flex items-center gap-2">
                <FileText className="h-5 w-5" />
                Estado de Resultados
              </CardTitle>
              <CardDescription>
                Del {new Date(estado.fecha_inicio).toLocaleDateString('es-BO')}{' '}
                al {new Date(estado.fecha_fin).toLocaleDateString('es-BO')}
              </CardDescription>
            </CardHeader>
            <CardContent className="space-y-4">
              {/* INGRESOS */}
              <div>
                <h3 className="mb-2 text-lg font-semibold">INGRESOS</h3>
                <div className="space-y-1 pl-4">
                  <div className="flex justify-between">
                    <span>Ventas</span>
                    <span className="font-mono">
                      {formatCurrency(estado.ingresos.ventas)}
                    </span>
                  </div>
                  <div className="flex justify-between">
                    <span>Cobrado (x Cobrar)</span>
                    <span className="font-mono">
                      {formatCurrency(estado.ingresos.cobros)}
                    </span>
                  </div>
                  <div className="flex justify-between">
                    <span>Otros ingresos</span>
                    <span className="font-mono">
                      {formatCurrency(estado.ingresos.otros_ingresos)}
                    </span>
                  </div>
                </div>
                <Separator className="my-2" />
                <div className="flex justify-between font-semibold">
                  <span>= INGRESOS TOTALES</span>
                  <span className="font-mono">
                    {formatCurrency(ingresosTotales)}
                  </span>
                </div>
              </div>

              <Separator className="my-4" />

              {/* COSTOS */}
              <div>
                <h3 className="mb-2 text-lg font-semibold">(-) COSTOS</h3>
                <div className="space-y-1 pl-4">
                  <div className="flex justify-between">
                    <span>Compras</span>
                    <span className="font-mono text-red-600">
                      -{formatCurrency(estado.costos.compras)}
                    </span>
                  </div>
                </div>
                <Separator className="my-2" />
                <div className="flex justify-between font-semibold">
                  <span>= COSTO TOTAL</span>
                  <span className="font-mono text-red-600">
                    -{formatCurrency(costosTotales)}
                  </span>
                </div>
              </div>

              <Separator className="my-4" />

              {/* UTILIDAD BRUTA */}
              <div className="flex justify-between rounded bg-blue-50 p-3 text-lg font-bold">
                <span>= UTILIDAD BRUTA</span>
                <span
                  className={`font-mono ${utilidadBruta >= 0 ? 'text-green-600' : 'text-red-600'}`}
                >
                  {formatCurrency(utilidadBruta)}
                </span>
              </div>

              <Separator className="my-4" />

              {/* GASTOS */}
              <div>
                <h3 className="mb-2 text-lg font-semibold">(-) GASTOS</h3>
                <div className="space-y-1 pl-4">
                  <div className="flex justify-between">
                    <span>Operativos</span>
                    <span className="font-mono text-red-600">
                      -{formatCurrency(estado.gastos.operativos)}
                    </span>
                  </div>
                  <div className="flex justify-between">
                    <span>Financieros</span>
                    <span className="font-mono text-red-600">
                      -{formatCurrency(estado.gastos.financieros)}
                    </span>
                  </div>
                  <div className="flex justify-between">
                    <span>Extraordinarios</span>
                    <span className="font-mono text-red-600">
                      -{formatCurrency(estado.gastos.extraordinarios)}
                    </span>
                  </div>
                  <div className="flex justify-between">
                    <span>Caja chica</span>
                    <span className="font-mono text-red-600">
                      -{formatCurrency(estado.gastos.caja_chica)}
                    </span>
                  </div>
                  <div className="flex justify-between">
                    <span>Pagos (x Pagar)</span>
                    <span className="font-mono text-red-600">
                      -{formatCurrency(estado.gastos.caja_chica)}
                    </span>
                  </div>
                </div>
                <Separator className="my-2" />
                <div className="flex justify-between font-semibold">
                  <span>= GASTOS TOTALES</span>
                  <span className="font-mono text-red-600">
                    -{formatCurrency(gastosTotales)}
                  </span>
                </div>
              </div>

              <Separator className="my-4" />

              {/* UTILIDAD NETA */}
              <div className="flex justify-between rounded-lg bg-gradient-to-r from-green-50 to-blue-50 p-4 text-xl font-bold">
                <span>= UTILIDAD NETA DEL MES</span>
                <span
                  className={`font-mono ${utilidadNeta >= 0 ? 'text-green-600' : 'text-red-600'}`}
                >
                  {formatCurrency(utilidadNeta)}
                </span>
              </div>

              {/* Botón de cierre */}
              <div className="pt-4">
                <Button
                  onClick={handleCierre}
                  disabled={procesando}
                  className="w-full"
                  size="lg"
                >
                  {procesando && (
                    <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                  )}
                  Realizar Cierre
                </Button>
              </div>
            </CardContent>
          </Card>
        )}

        {/* Mensaje cuando no hay datos */}
        {!estado && !loading && (
          <Card>
            <CardContent className="py-12">
              <div className="text-center text-muted-foreground">
                <FileText className="mx-auto mb-4 h-12 w-12 opacity-50" />
                <p>
                  Selecciona un rango de fechas y haz clic en "Cargar Datos"
                  para ver el estado de resultados
                </p>
              </div>
            </CardContent>
          </Card>
        )}
      </div>
    </AppLayout>
  );
}

// ---------------------------------------------
// import AppLayout from '@/layouts/app-layout';
// import { type BreadcrumbItem } from '@/types';
// import { Head } from '@inertiajs/react';

// const breadcrumbs: BreadcrumbItem[] = [
//   {
//     title: 'Estados',
//     href: '/estados',
//   },
// ];

// export default function Lista() {
//   return (
//     <AppLayout breadcrumbs={breadcrumbs}>
//       <Head title="Estados Financieros" />
//     </AppLayout>
//   );
// }
