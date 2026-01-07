import { Button } from '@/components/ui/button';
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
import { Head, Link, useForm } from '@inertiajs/react';
import { format } from 'date-fns';
import { Edit, Plus, Trash2 } from 'lucide-react';

const breadcrumbs: BreadcrumbItem[] = [
  {
    title: 'Cotizaciones',
    href: '/cotizaciones',
  },
];

interface Cotizacion {
  id: number;
  nombre: string;
  total: number;
  created_at: string;
  // ... otros campos
  detalles: { id: number; descripcion: string /* ... */ }[];
}

interface Props {
  cotizaciones: Cotizacion[];
}

export default function Lista({ cotizaciones }: Props) {
  const { processing, delete: destroy } = useForm();

  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Cotizaciones" />

      <div className="p-6">
        <div className="flex items-center">
          <div className="me-5 text-2xl font-bold">Gestión de Cotizaciones</div>
          <Link href="/cotizaciones/create">
            <Button>
              <Plus className="mr-2 h-4 w-4" /> Nuevo
            </Button>
          </Link>
        </div>
        <Table className="mt-6">
          <TableHeader>
            <TableRow>
              <TableHead className="text-center">Nombre</TableHead>
              <TableHead className="text-center">Total</TableHead>
              <TableHead className="text-center">Fecha</TableHead>
              <TableHead className="text-center">Acciones</TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {cotizaciones.map((cot) => (
              <TableRow key={cot.id}>
                <TableCell>{cot.nombre}</TableCell>

                <TableCell className="text-right font-mono text-[1rem]">
                  <span className="font-bold">Bs.</span>{' '}
                  {cot.total.toLocaleString('es-BO')}
                </TableCell>
                <TableCell className="text-center font-mono text-xs text-muted-foreground sm:text-sm">
                  {(() => {
                    const dateStr = cot.created_at;
                    if (!dateStr) return '-';

                    const date = new Date(dateStr);
                    if (isNaN(date.getTime())) return '-';

                    return format(date, 'dd/MM/yyyy HH:mm:ss');
                  })()}
                </TableCell>

                <TableCell className="flex justify-center gap-2">
                  <Link href={`/cotizaciones/${cot.id}/edit`}>
                    <Button variant="outline" size="icon">
                      <Edit className="h-4 w-4" />
                    </Button>
                  </Link>
                  {/* Agrega botón de eliminar si lo necesitas */}
                  <Button
                    disabled={processing}
                    size="icon"
                    variant="outline"
                    onClick={() => handleDelete(cot.id)}
                  >
                    <Trash2 className="h-4 w-4" />
                  </Button>
                </TableCell>
              </TableRow>
            ))}
          </TableBody>
        </Table>
      </div>
    </AppLayout>
  );
}
