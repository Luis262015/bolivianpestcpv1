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
    title: 'Epps',
    href: '/epps',
  },
];

interface Epp {
  id: number;
  nombre: string;
}

interface EppsPaginate {
  data: Epp[];
  links: { url: string | null; label: string; active: boolean }[];
}

export default function Index() {
  const { processing, delete: destroy } = useForm();
  const { epps } = usePage<{ epps: EppsPaginate }>().props;

  const handleDelete = (id: number) => {
    if (confirm('Estas seguro de eliminar el registro')) {
      destroy(`/epps/${id}`);
    }
  };

  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Epp | List" />

      <div className="m-4">
        <Link href={'/epps/create'}>
          <Button className="mb-4" size="sm">
            Nuevo EPP
          </Button>
        </Link>
        <div className="mb-2 text-center text-2xl">Lista EPPS</div>
        {epps.data.length > 0 && (
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead className="w-[100px]">ID</TableHead>
                <TableHead>Nombre</TableHead>
                <TableHead>Acción</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {epps.data.map((categoria) => (
                <TableRow key={categoria.id}>
                  <TableCell className="font-medium">{categoria.id}</TableCell>
                  <TableCell>{categoria.nombre}</TableCell>

                  <TableCell>
                    <Link href={`/epps/${categoria.id}/edit`}>
                      <Button className="" size="icon" variant="outline">
                        <SquarePen />
                      </Button>
                    </Link>
                    <Button
                      disabled={processing}
                      className="ml-1"
                      size="icon"
                      variant="outline"
                      onClick={() => handleDelete(categoria.id)}
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
          <CustomPagination links={epps.links} />
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
//     title: 'Etiquetas',
//     href: '/etiquetas',
//   },
// ];

// export default function Lista() {
//   return (
//     <AppLayout breadcrumbs={breadcrumbs}>
//       <Head title="Etiquetas" />
//     </AppLayout>
//   );
// }
