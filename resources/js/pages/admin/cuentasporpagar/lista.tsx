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
import { Banknote } from 'lucide-react';

const breadcrumbs: BreadcrumbItem[] = [
  {
    title: 'Cuentas Por Pagar',
    href: '/Compras',
  },
];

interface Proveedor {
  id: number;
  nombre: string;
}

interface CuentaPagar {
  id: number;
  compra_id: number;
  proveedor: Proveedor;
  total: number;
  a_cuenta: number;
  saldo: number;
  estado: string;
  fecha_pago: string;
}

interface CuentasPagarPaginate {
  data: CuentaPagar[];
  links: { url: string | null; label: string; active: boolean }[];
}

export default function Index() {
  const { processing, delete: destroy } = useForm();
  const { cuentaspagar } = usePage<{ cuentaspagar: CuentasPagarPaginate }>()
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
        <div className="mb-2 text-center text-2xl">Lista Cuentas por Pagar</div>
        {cuentaspagar.data.length > 0 && (
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead className="w-[100px]">ID</TableHead>
                <TableHead>Compra ID</TableHead>
                <TableHead>Proveedor</TableHead>
                <TableHead>Total</TableHead>
                <TableHead>A Cuenta</TableHead>
                <TableHead>Saldo</TableHead>
                <TableHead>Estado</TableHead>
                <TableHead>Acción</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {cuentaspagar.data.map((compra) => (
                <TableRow key={compra.id}>
                  <TableCell className="font-medium">{compra.id}</TableCell>
                  <TableCell>{compra.compra_id}</TableCell>
                  <TableCell>{compra.proveedor.nombre}</TableCell>
                  <TableCell>{compra.total}</TableCell>
                  <TableCell>{compra.a_cuenta}</TableCell>
                  <TableCell>{compra.saldo}</TableCell>
                  <TableCell>{compra.estado}</TableCell>
                  <TableCell>
                    <Link href={`/compras/edit/${compra.id}`}>
                      <Button className="" variant="outline">
                        <Banknote /> Pagar
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
          <CustomPagination links={cuentaspagar.links} />
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
//     title: 'Cuentas por Pagar',
//     href: '/cuentasporpagar',
//   },
// ];

// export default function Lista() {
//   return (
//     <AppLayout breadcrumbs={breadcrumbs}>
//       <Head title="Cuentas por pagar" />
//     </AppLayout>
//   );
// }
