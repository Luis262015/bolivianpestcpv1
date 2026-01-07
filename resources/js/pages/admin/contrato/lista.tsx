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
import { format } from 'date-fns';
import { Edit, Plus, Trash2 } from 'lucide-react';

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
  expiracion: string;
  created_at: string;
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
        <Table className="mt-6">
          <TableHeader>
            <TableRow>
              <TableHead>Cliente</TableHead>
              <TableHead className="text-center">Total</TableHead>
              <TableHead className="text-center">Expiracion</TableHead>
              <TableHead className="text-center">Fecha</TableHead>
              {/* <TableHead>A Cuenta</TableHead>
              <TableHead>Saldo</TableHead> */}
              <TableHead className="text-center">Acciones</TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {contratos.data.map((cot) => (
              <TableRow key={cot.id}>
                <TableCell>{cot.empresa.nombre}</TableCell>
                <TableCell className="text-right font-mono text-[1rem]">
                  <span className="font-bold">Bs.</span>{' '}
                  {cot.total.toLocaleString('es-BO')}
                </TableCell>
                <TableCell className="text-center font-mono text-xs text-muted-foreground sm:text-sm">
                  {/* {cot.expiracion} */}
                  {(() => {
                    const dateStr = cot.expiracion;
                    if (!dateStr) return '-';

                    const date = new Date(dateStr);
                    if (isNaN(date.getTime())) return '-';

                    return format(date, 'dd/MM/yyyy HH:mm:ss');
                  })()}
                </TableCell>
                <TableCell className="text-center font-mono text-xs text-muted-foreground sm:text-sm">
                  {/* {cot.created_at} */}
                  {(() => {
                    const dateStr = cot.created_at;
                    if (!dateStr) return '-';

                    const date = new Date(dateStr);
                    if (isNaN(date.getTime())) return '-';

                    return format(date, 'dd/MM/yyyy HH:mm:ss');
                  })()}
                </TableCell>
                {/* <TableCell>{cot.acuenta}</TableCell>
                <TableCell>{cot.saldo}</TableCell> */}
                <TableCell className="flex justify-center gap-2">
                  <Link href={`/contratos/${cot.id}/edit`}>
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
        <div className="my-2">
          <CustomPagination links={contratos.links} />
        </div>
      </div>
    </AppLayout>
  );
}
