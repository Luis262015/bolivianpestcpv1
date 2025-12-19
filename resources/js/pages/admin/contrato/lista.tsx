import CustomPagination from '@/components/CustomPagination';
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
import { Head, Link, useForm, usePage } from '@inertiajs/react';

const breadcrumbs: BreadcrumbItem[] = [
  {
    title: 'Contratos',
    href: '/contratos',
  },
];

interface Contrato {
  id: number;
  nombre: string;
  total: number;
  acuenta: number;
  saldo: number;
  detalles: { id: number; descripcion: string /* ... */ }[];
}

interface ContratosPaginate {
  data: Contrato[];
  links: { url: string | null; label: string; active: boolean }[];
}

export default function Lista() {
  const { processing, delete: destroy } = useForm();
  const { contratos } = usePage<{ contratos: ContratosPaginate }>().props;

  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="contratos" />

      <div className="p-6">
        <Link href="/contratos/create">
          <Button>Nuevo Contrato</Button>
        </Link>
        <Table>
          <TableHeader>
            <TableRow>
              <TableHead>Nombre</TableHead>
              <TableHead>Total</TableHead>
              <TableHead>A Cuenta</TableHead>
              <TableHead>Saldo</TableHead>
              <TableHead>Acciones</TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {contratos.data.map((cot) => (
              <TableRow key={cot.id}>
                <TableCell>{cot.nombre}</TableCell>
                <TableCell>{cot.total}</TableCell>
                <TableCell>{cot.acuenta}</TableCell>
                <TableCell>{cot.saldo}</TableCell>
                <TableCell>
                  <Link href={`/contratos/${cot.id}/edit`}>
                    <Button variant="outline">Editar</Button>
                  </Link>
                  {/* Agrega botón de eliminar si lo necesitas */}
                </TableCell>
              </TableRow>
            ))}
          </TableBody>
        </Table>
        <div className="my-2">
          <CustomPagination links={contratos.links} />
        </div>
      </div>
    </AppLayout>
  );
}
