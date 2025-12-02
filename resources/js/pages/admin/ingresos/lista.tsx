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
    title: 'Ingresos',
    href: '/ingresos',
  },
];

interface Ingreso {
  id: number;
  concepto: string;
  monto: number;
}

interface IngresosPaginate {
  data: Ingreso[];
  links: { url: string | null; label: string; active: boolean }[];
}

export default function Index() {
  const { processing, delete: destroy } = useForm();
  const { ingresos } = usePage<{ ingresos: IngresosPaginate }>().props;

  const handleDelete = (id: number) => {
    if (confirm('Estas seguro de eliminar el registro')) {
      destroy(`/ingresos/${id}`);
    }
  };

  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Ingresos | List" />
      <div className="m-4">
        <Link href={'/ingresos/create'}>
          <Button className="mb-4" size="sm">
            Agrega Ingreso
          </Button>
        </Link>
        <div className="mb-2 text-center text-2xl">Lista de ingresos</div>
        {ingresos.data.length > 0 && (
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead className="w-[100px]">ID</TableHead>
                <TableHead>Concepto</TableHead>
                <TableHead>Total</TableHead>
                <TableHead>Acción</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {ingresos.data.map((gasto) => (
                <TableRow key={gasto.id}>
                  <TableCell className="font-medium">{gasto.id}</TableCell>
                  <TableCell>{gasto.concepto}</TableCell>
                  <TableCell>{gasto.monto}</TableCell>
                  <TableCell>
                    <Link href={`/ingresos/${gasto.id}/edit`}>
                      <Button className="" size="icon" variant="outline">
                        <SquarePen />
                      </Button>
                    </Link>
                    <Button
                      disabled={processing}
                      className="ml-1"
                      size="icon"
                      variant="outline"
                      onClick={() => handleDelete(gasto.id)}
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
          <CustomPagination links={ingresos.links} />
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
//     title: 'Ingresos',
//     href: '/ingresos',
//   },
// ];

// export default function Lista() {
//   return (
//     <AppLayout breadcrumbs={breadcrumbs}>
//       <Head title="Ingresos" />
//     </AppLayout>
//   );
// }
