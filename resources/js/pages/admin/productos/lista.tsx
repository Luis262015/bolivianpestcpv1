import AppLayout from '@/layouts/app-layout';
import { type BreadcrumbItem } from '@/types';
import { Head, Link, useForm, usePage } from '@inertiajs/react';

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
import { Plus, SquarePen, Trash2 } from 'lucide-react';

const breadcrumbs: BreadcrumbItem[] = [
  {
    title: 'Productos',
    href: '/productos',
  },
];

interface Categoria {
  id: number;
  nombre: string;
}

interface Subcategoria {
  id: number;
  nombre: string;
}

interface Marca {
  id: number;
  nombre: string;
}

interface Producto {
  id: number;
  nombre: string;
  categoria: Categoria;
  subcategoria: Subcategoria;
  marca: Marca;
}

interface ProductosPaginate {
  data: Producto[];
  links: { url: string | null; label: string; active: boolean }[];
}

export default function Index() {
  const { processing, delete: destroy } = useForm();
  const { productos } = usePage<{ productos: ProductosPaginate }>().props;

  const handleDelete = (id: number) => {
    if (confirm('Estas seguro de eliminar el registro')) {
      destroy(`/productos/${id}`);
    }
  };

  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Productos | List" />

      <div className="m-4">
        <div className="flex items-center">
          <div className="me-5 mb-2 text-center text-2xl">
            Lista de productos
          </div>
          <Link href={'/productos/create'}>
            <Button className="mb-4" size="sm">
              <Plus className="mr-2 h-4 w-4" /> Nuevo Producto
            </Button>
          </Link>
        </div>
        {productos.data.length > 0 && (
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead className="w-[100px]">ID</TableHead>
                <TableHead>Nombre</TableHead>
                <TableHead>Categoria</TableHead>
                <TableHead>Subcategoria</TableHead>
                <TableHead>Marca</TableHead>
                <TableHead>Acción</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {productos.data.map((producto) => (
                <TableRow key={producto.id}>
                  <TableCell className="font-medium">{producto.id}</TableCell>
                  <TableCell>{producto.nombre}</TableCell>
                  <TableCell>{producto.categoria?.nombre ?? '---'}</TableCell>
                  <TableCell>
                    {producto.subcategoria?.nombre ?? '---'}
                  </TableCell>
                  <TableCell>{producto.marca?.nombre ?? '---'}</TableCell>
                  <TableCell>
                    <Link href={`/productos/${producto.id}/edit`}>
                      <Button className="" size="icon" variant="outline">
                        <SquarePen />
                      </Button>
                    </Link>
                    <Button
                      disabled={processing}
                      className="ml-1"
                      size="icon"
                      variant="outline"
                      onClick={() => handleDelete(producto.id)}
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
          <CustomPagination links={productos.links} />
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
//     title: 'Productos',
//     href: '/productos',
//   },
// ];

// export default function Lista() {
//   return (
//     <AppLayout breadcrumbs={breadcrumbs}>
//       <Head title="Productos" />
//     </AppLayout>
//   );
// }
