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
import { Plus } from 'lucide-react';

const breadcrumbs: BreadcrumbItem[] = [
  {
    title: 'Contratos',
    href: '/contratos',
  },
];

interface Empresa {
  id: number;
  nombre: string;
}

interface Contrato {
  id: number;
  nombre: string;
  total: number;
  acuenta: number;
  saldo: number;
  empresa: Empresa;
  detalles: { id: number; descripcion: string /* ... */ }[];
}

interface ContratosPaginate {
  data: Contrato[];
  links: { url: string | null; label: string; active: boolean }[];
}

export default function Lista() {
  const { processing, delete: destroy } = useForm();
  const { contratos } = usePage<{ contratos: ContratosPaginate }>().props;

  console.log(contratos);

  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="contratos" />

      <div className="p-6">
        <div className="flex items-center">
          <div className="me-5 text-2xl font-bold">Gestión de Contratos</div>
          <Link href="/contratos/create">
            <Button>
              <Plus className="mr-2 h-4 w-4" /> Nuevo
            </Button>
          </Link>
        </div>
        <Table>
          <TableHeader>
            <TableRow>
              <TableHead>Cliente</TableHead>
              <TableHead>Total</TableHead>
              {/* <TableHead>A Cuenta</TableHead>
              <TableHead>Saldo</TableHead> */}
              <TableHead>Acciones</TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {contratos.data.map((cot) => (
              <TableRow key={cot.id}>
                <TableCell>{cot.empresa.nombre}</TableCell>
                <TableCell>{cot.total}</TableCell>
                {/* <TableCell>{cot.acuenta}</TableCell>
                <TableCell>{cot.saldo}</TableCell> */}
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
