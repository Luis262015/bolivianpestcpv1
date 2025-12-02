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
    title: 'Subcategorias',
    href: '/subcategorias',
  },
];

interface Categoria {
  id: number;
  nombre: string;
}

interface Subcategoria {
  id: number;
  categoria: Categoria;
  nombre: string;
  imagen: string;
  orden: number;
}

interface SubcategoriasPaginate {
  data: Subcategoria[];
  links: { url: string | null; label: string; active: boolean }[];
}

export default function Index() {
  const { processing, delete: destroy } = useForm();
  const { subcategorias } = usePage<{ subcategorias: SubcategoriasPaginate }>()
    .props;

  const handleDelete = (id: number) => {
    if (confirm('Estas seguro de eliminar el registro')) {
      destroy(`/subcategorias/${id}`);
    }
  };

  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Subcategorias | List" />

      <div className="m-4">
        <Link href={'/subcategorias/create'}>
          <Button className="mb-4" size="sm">
            Nueva Subcategoria
          </Button>
        </Link>
        <div className="mb-2 text-center text-2xl">Lista de subcategorias</div>
        {subcategorias.data.length > 0 && (
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead className="w-[100px]">ID</TableHead>
                <TableHead>Nombre</TableHead>
                <TableHead>Orden</TableHead>
                <TableHead>Acción</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {subcategorias.data.map((subcategoria) => (
                <TableRow key={subcategoria.id}>
                  <TableCell className="font-medium">
                    {subcategoria.id}
                  </TableCell>
                  <TableCell>{subcategoria.nombre}</TableCell>
                  <TableCell>{subcategoria.categoria.nombre}</TableCell>
                  <TableCell>
                    <Link href={`/subcategorias/${subcategoria.id}/edit`}>
                      <Button className="" size="icon" variant="outline">
                        <SquarePen />
                      </Button>
                    </Link>
                    <Button
                      disabled={processing}
                      className="ml-1"
                      size="icon"
                      variant="outline"
                      onClick={() => handleDelete(subcategoria.id)}
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
          <CustomPagination links={subcategorias.links} />
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
//     title: 'Subcategorias',
//     href: '/subcategorias',
//   },
// ];

// export default function Lista() {
//   return (
//     <AppLayout breadcrumbs={breadcrumbs}>
//       <Head title="Subcategorias" />
//     </AppLayout>
//   );
// }
