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
    title: 'Retiros',
    href: '/retiros',
  },
];

interface Retiro {
  id: number;
  concepto: string;
  monto: number;
  tipo: string;
}

interface RetirosPaginate {
  data: Retiro[];
  links: { url: string | null; label: string; active: boolean }[];
}

export default function Index() {
  const { processing, delete: destroy } = useForm();
  const { retiros } = usePage<{ retiros: RetirosPaginate }>().props;

  const handleDelete = (id: number) => {
    if (confirm('Estas seguro de eliminar el registro')) {
      destroy(`/retiros/${id}`);
    }
  };

  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Retiros | List" />

      <div className="m-4">
        <Link href={'/retiros/create'}>
          <Button className="mb-4" size="sm">
            Hacer Retiro
          </Button>
        </Link>
        <div className="mb-2 text-center text-2xl">Lista de retiros</div>
        {retiros.data.length > 0 && (
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead className="w-[100px]">ID</TableHead>
                <TableHead>Concepto</TableHead>
                <TableHead>Total</TableHead>
                <TableHead>Tipo</TableHead>
                <TableHead>Acción</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {retiros.data.map((retiro) => (
                <TableRow key={retiro.id}>
                  <TableCell className="font-medium">{retiro.id}</TableCell>
                  <TableCell>{retiro.concepto}</TableCell>
                  <TableCell>{retiro.monto}</TableCell>
                  <TableCell>{retiro.tipo}</TableCell>
                  <TableCell>
                    <Link href={`/retiros/${retiro.id}/edit`}>
                      <Button className="" size="icon" variant="outline">
                        <SquarePen />
                      </Button>
                    </Link>
                    <Button
                      disabled={processing}
                      className="ml-1"
                      size="icon"
                      variant="outline"
                      onClick={() => handleDelete(retiro.id)}
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
          <CustomPagination links={retiros.links} />
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
//     title: 'Retiros',
//     href: '/retiros',
//   },
// ];

// export default function Lista() {
//   return (
//     <AppLayout breadcrumbs={breadcrumbs}>
//       <Head title="Retiros" />
//     </AppLayout>
//   );
// }
