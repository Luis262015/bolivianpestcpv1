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
import { Banknote, Plus } from 'lucide-react';

const breadcrumbs: BreadcrumbItem[] = [
  {
    title: 'Cuentas Por Cobrar',
    href: '/Compras',
  },
];

// interface Cliente {
//   id: number;
//   nombre: string;
// }

interface User {
  id: number;
  nombre: String;
}

interface CuentaCobrar {
  id: number;
  contrato_id: number;
  user_id: number;
  // cliente: Cliente;
  total: number;
  a_cuenta: number;
  saldo: number;
  estado: string;
  fecha_pago: string;
}

interface CuentasCobrarPaginate {
  data: CuentaCobrar[];
  links: { url: string | null; label: string; active: boolean }[];
}

export default function Index() {
  const { processing, delete: destroy } = useForm();
  const { cuentascobrar } = usePage<{ cuentascobrar: CuentasCobrarPaginate }>()
    .props;

  const handleDelete = (id: number) => {
    if (confirm('Estas seguro de eliminar el registro')) {
      destroy(`/compras/${id}`);
    }
  };

  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Cuentas por cobrar" />

      <div className="p-6">
        <div className="flex items-center">
          <div className="me-5 text-2xl font-bold">
            Gestión de Cuentas por Cobrar
          </div>
          <Link href="/cotizaciones/create">
            <Button>
              <Plus className="mr-2 h-4 w-4" /> Nuevo
            </Button>
          </Link>
        </div>
        {cuentascobrar.data.length > 0 && (
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead className="w-[100px]">ID</TableHead>
                <TableHead>Contrato ID</TableHead>
                <TableHead>User ID</TableHead>
                <TableHead>Total</TableHead>
                <TableHead>A Cuenta</TableHead>
                <TableHead>Saldo</TableHead>
                <TableHead>Estado</TableHead>
                <TableHead>Acción</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {cuentascobrar.data.map((compra) => (
                <TableRow key={compra.id}>
                  <TableCell className="font-medium">{compra.id}</TableCell>
                  <TableCell>{compra.contrato_id}</TableCell>
                  <TableCell>{compra.user_id}</TableCell>
                  <TableCell>{compra.total}</TableCell>
                  <TableCell>{compra.a_cuenta}</TableCell>
                  <TableCell>{compra.saldo}</TableCell>
                  <TableCell>{compra.estado}</TableCell>
                  <TableCell>
                    <Link href={`/compras/edit/${compra.id}`}>
                      <Button className="" variant="outline">
                        <Banknote /> Cobrar
                      </Button>
                    </Link>
                    {/* <Button
                      disabled={processing}
                      className="ml-1"
                      size="icon"
                      variant="outline"
                      onClick={() => handleDelete(compra.id)}
                    >
                      <Trash2 />
                    </Button> */}
                  </TableCell>
                </TableRow>
              ))}
            </TableBody>
          </Table>
        )}

        <div className="my-2">
          <CustomPagination links={cuentascobrar.links} />
        </div>
      </div>
    </AppLayout>
  );
}
