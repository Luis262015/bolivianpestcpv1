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
import { Head, Link } from '@inertiajs/react';

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
  // ... otros campos
  detalles: { id: number; descripcion: string /* ... */ }[];
}

interface Props {
  cotizaciones: Cotizacion[];
}

export default function Lista({ cotizaciones }: Props) {
  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Cotizaciones" />

      <div className="p-6">
        <Link href="/cotizaciones/create">
          <Button>Nueva Cotizacion</Button>
        </Link>
        <Table>
          <TableHeader>
            <TableRow>
              <TableHead>Nombre</TableHead>
              <TableHead>Total</TableHead>
              <TableHead>Acciones</TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {cotizaciones.map((cot) => (
              <TableRow key={cot.id}>
                <TableCell>{cot.nombre}</TableCell>
                <TableCell>{cot.total}</TableCell>
                <TableCell>
                  <Link href={`/cotizaciones/${cot.id}/edit`}>
                    <Button variant="outline">Editar</Button>
                  </Link>
                  {/* Agrega botón de eliminar si lo necesitas */}
                </TableCell>
              </TableRow>
            ))}
          </TableBody>
        </Table>
      </div>
    </AppLayout>
  );
}
