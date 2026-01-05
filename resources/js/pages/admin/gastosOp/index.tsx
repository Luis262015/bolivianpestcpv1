import CustomPagination from '@/components/CustomPagination';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from '@/components/ui/table';
import AppLayout from '@/layouts/app-layout';
import { type BreadcrumbItem } from '@/types';
import { Head, Link, router, useForm, usePage } from '@inertiajs/react';
import { format } from 'date-fns';
import {
  ChevronDown,
  ChevronUp,
  Filter,
  SquarePen,
  Trash2,
  X,
} from 'lucide-react';
import { useEffect, useState } from 'react';

const breadcrumbs: BreadcrumbItem[] = [{ title: 'Gastos', href: '/gastos' }];

interface Gasto {
  id: number;
  concepto: string;
  detalle: string;
  total: number;
  created_at?: string;
  fecha_gasto?: string;
}

interface GastosPaginate {
  data: Gasto[];
  links: { url: string | null; label: string; active: boolean }[];
}

interface Filters {
  concepto: string;
  detalle: string;
  total_min: string;
  total_max: string;
  fecha_desde: string;
  fecha_hasta: string;
}

export default function GastosOp() {
  const { processing, delete: destroy } = useForm();
  const { gastos, filters = {} } = usePage<{
    gastos: GastosPaginate;
    filters?: Partial<Filters>;
  }>().props;

  // Estado de filtros
  const [localFilters, setLocalFilters] = useState<Filters>({
    concepto: filters.concepto || '',
    detalle: filters.detalle || '',
    total_min: filters.total_min || '',
    total_max: filters.total_max || '',
    fecha_desde: filters.fecha_desde || '',
    fecha_hasta: filters.fecha_hasta || '',
  });

  // Estado del colapso (SIEMPRE controlado)
  const [isFilterOpen, setIsFilterOpen] = useState(false);

  // Debounce + envío seguro
  useEffect(() => {
    const timer = setTimeout(() => {
      const payload = Object.fromEntries(
        Object.entries(localFilters).filter(
          ([_, value]) => value !== '' && value !== null && value !== undefined,
        ),
      ) as Record<string, string>;

      router.get('/gastos', payload, {
        preserveState: true,
        replace: true,
        preserveScroll: true,
      });
    }, 400);

    return () => clearTimeout(timer);
  }, [localFilters]);

  const handleDelete = (id: number) => {
    if (confirm('¿Estás seguro de eliminar el registro?')) {
      destroy(`/gastos/${id}`, {
        onSuccess: () => {
          const payload = Object.fromEntries(
            Object.entries(localFilters).filter(
              ([_, v]) => v !== '' && v !== null,
            ),
          ) as Record<string, string>;
          router.visit('/gastos', { data: payload, preserveState: true });
        },
      });
    }
  };

  const resetFilters = () => {
    setLocalFilters({
      concepto: '',
      detalle: '',
      total_min: '',
      total_max: '',
      fecha_desde: '',
      fecha_hasta: '',
    });
  };

  const hasActiveFilters = Object.values(localFilters).some(
    (value) => value !== '' && value !== null && value !== undefined,
  );

  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Gastos | Lista" />

      <div className="m-4">
        {/* Botones principales */}
        <div className="mb-4 flex flex-col items-start gap-3 sm:flex-row sm:items-center">
          <h1 className="me-5 text-2xl font-bold">Gestión de Gastos</h1>

          <div className="flex gap-2">
            {/* BOTÓN FILTROS SIEMPRE VISIBLE */}
            <Button
              variant="outline"
              size="sm"
              onClick={() => setIsFilterOpen(!isFilterOpen)}
            >
              <Filter className="mr-1 h-4 w-4" />
              Filtros
              {isFilterOpen ? (
                <ChevronUp className="ml-1 h-4 w-4" />
              ) : (
                <ChevronDown className="ml-1 h-4 w-4" />
              )}
            </Button>

            {/* BOTÓN LIMPIAR */}
            {hasActiveFilters && (
              <Button variant="outline" size="sm" onClick={resetFilters}>
                <X className="mr-1 h-4 w-4" />
                Limpiar
              </Button>
            )}
          </div>
        </div>

        {/* FILTROS COLAPSABLES EN TODAS LAS PANTALLAS */}
        <div
          className={`overflow-hidden transition-all duration-300 ease-in-out ${isFilterOpen ? 'max-h-[600px] opacity-100' : 'max-h-0 opacity-0'} `}
        >
          <div className="mb-6 space-y-4 rounded-lg bg-muted/40 p-4 pb-6">
            <div className="flex items-center gap-2 text-sm font-medium text-foreground">
              <Filter className="h-4 w-4" />
              Filtros avanzados
            </div>

            <div className="grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-3">
              {/* Concepto */}
              <div>
                <Label htmlFor="concepto">Concepto</Label>
                <Input
                  id="concepto"
                  placeholder="Ej: Alquiler"
                  value={localFilters.concepto}
                  onChange={(e) =>
                    setLocalFilters({
                      ...localFilters,
                      concepto: e.target.value,
                    })
                  }
                />
              </div>

              {/* Detalle */}
              <div>
                <Label htmlFor="detalle">Detalle</Label>
                <Input
                  id="detalle"
                  placeholder="Ej: Oficina centro"
                  value={localFilters.detalle}
                  onChange={(e) =>
                    setLocalFilters({
                      ...localFilters,
                      detalle: e.target.value,
                    })
                  }
                />
              </div>

              {/* Total mínimo */}
              <div>
                <Label htmlFor="total_min">Total mínimo</Label>
                <Input
                  id="total_min"
                  type="number"
                  placeholder="0"
                  value={localFilters.total_min}
                  onChange={(e) =>
                    setLocalFilters({
                      ...localFilters,
                      total_min: e.target.value,
                    })
                  }
                />
              </div>

              {/* Total máximo */}
              <div>
                <Label htmlFor="total_max">Total máximo</Label>
                <Input
                  id="total_max"
                  type="number"
                  placeholder="10000"
                  value={localFilters.total_max}
                  onChange={(e) =>
                    setLocalFilters({
                      ...localFilters,
                      total_max: e.target.value,
                    })
                  }
                />
              </div>

              {/* Fecha desde */}
              <div>
                <Label htmlFor="fecha_desde">Fecha desde</Label>
                <Input
                  id="fecha_desde"
                  type="date"
                  value={localFilters.fecha_desde}
                  onChange={(e) =>
                    setLocalFilters({
                      ...localFilters,
                      fecha_desde: e.target.value,
                    })
                  }
                />
              </div>

              {/* Fecha hasta */}
              <div>
                <Label htmlFor="fecha_hasta">Fecha hasta</Label>
                <Input
                  id="fecha_hasta"
                  type="date"
                  value={localFilters.fecha_hasta}
                  onChange={(e) =>
                    setLocalFilters({
                      ...localFilters,
                      fecha_hasta: e.target.value,
                    })
                  }
                />
              </div>
            </div>
          </div>
        </div>

        {/* Título */}
        <div className="mb-2 text-center text-2xl">Lista de gastos</div>

        {/* Tabla */}
        {gastos.data.length > 0 ? (
          <div className="overflow-x-auto">
            <Table>
              <TableHeader>
                <TableRow>
                  <TableHead className="w-[80px]">ID</TableHead>
                  <TableHead>Concepto</TableHead>
                  <TableHead>Detalle</TableHead>
                  <TableHead className="text-right">Total</TableHead>
                  <TableHead className="text-center">Fecha</TableHead>
                  <TableHead className="text-center">Acción</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {gastos.data.map((gasto) => (
                  <TableRow key={gasto.id}>
                    <TableCell className="font-medium">{gasto.id}</TableCell>
                    <TableCell>{gasto.concepto}</TableCell>
                    <TableCell>{gasto.detalle}</TableCell>
                    <TableCell className="text-right">
                      Bs. {gasto.total.toLocaleString('es-BO')}
                    </TableCell>
                    <TableCell className="text-center font-mono text-xs text-muted-foreground sm:text-sm">
                      {(() => {
                        const dateStr = gasto.fecha_gasto || gasto.created_at;
                        if (!dateStr) return '-';

                        const date = new Date(dateStr);
                        if (isNaN(date.getTime())) return '-';

                        return format(date, 'dd/MM/yyyy HH:mm:ss');
                      })()}
                    </TableCell>
                    <TableCell className="flex justify-center gap-1">
                      <Link href={`/gastos/${gasto.id}/edit`}>
                        <Button size="icon" variant="outline">
                          <SquarePen className="h-4 w-4" />
                        </Button>
                      </Link>
                      <Button
                        disabled={processing}
                        size="icon"
                        variant="outline"
                        onClick={() => handleDelete(gasto.id)}
                      >
                        <Trash2 className="h-4 w-4" />
                      </Button>
                    </TableCell>
                  </TableRow>
                ))}
              </TableBody>
            </Table>
          </div>
        ) : (
          <div className="py-12 text-center text-muted-foreground">
            No se encontraron gastos con los filtros aplicados.
          </div>
        )}

        {/* Paginación */}
        <div className="my-4">
          <CustomPagination links={gastos.links} />
        </div>
      </div>
    </AppLayout>
  );
}

// import AppLayout from '@/layouts/app-layout';
// import { type BreadcrumbItem } from '@/types';
// import { Head } from '@inertiajs/react';

// const breadcrumbs: BreadcrumbItem[] = [
//   {
//     title: 'Gastos',
//     href: '/gastos',
//   },
// ];

// export default function Lista() {
//   return (
//     <AppLayout breadcrumbs={breadcrumbs}>
//       <Head title="Gastos" />
//     </AppLayout>
//   );
// }
