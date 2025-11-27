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
import { SquarePen, Trash2 } from 'lucide-react';

const breadcrumbs: BreadcrumbItem[] = [
  {
    title: 'Cuentas Por Cobrar',
    href: '/Compras',
  },
];

interface Cliente {
  id: number;
  nombre: string;
}

interface CuentaCobrar {
  id: number;
  venta_id: number;
  cliente: Cliente;
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
      <Head title="Compras | List" />

      <div className="m-4">
        <div className="mb-2 text-center text-2xl">
          Lista Cuentas por Cobrar
        </div>
        {cuentascobrar.data.length > 0 && (
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead className="w-[100px]">ID</TableHead>
                <TableHead>Venta ID</TableHead>
                <TableHead>Cliente</TableHead>
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
                  <TableCell>{compra.venta_id}</TableCell>
                  <TableCell>{compra.cliente.nombre}</TableCell>
                  <TableCell>{compra.total}</TableCell>
                  <TableCell>{compra.a_cuenta}</TableCell>
                  <TableCell>{compra.saldo}</TableCell>
                  <TableCell>{compra.estado}</TableCell>
                  <TableCell>
                    <Link href={`/compras/edit/${compra.id}`}>
                      <Button className="" size="icon" variant="outline">
                        <SquarePen />
                      </Button>
                    </Link>
                    <Button
                      disabled={processing}
                      className="ml-1"
                      size="icon"
                      variant="outline"
                      onClick={() => handleDelete(compra.id)}
                    >
                      <Trash2 />
                    </Button>
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
