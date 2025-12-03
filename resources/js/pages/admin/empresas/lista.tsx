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
    title: 'Empresas',
    href: '/empresas',
  },
];

interface Empresa {
  id: number;
  nombre: string;
  direccion: string;
  telefono: string;
  email: string;
  activo: boolean;
}

interface EmpresaPagination {
  data: Empresa[];
  links: { url: string | null; label: string; active: boolean }[];
}

export default function Lista() {
  const { processing, delete: destroy } = useForm();
  const { empresas } = usePage<{ empresas: EmpresaPagination }>().props;

  const handleDelete = (id: number) => {
    if (confirm('Estas seguro de eliminar el registro')) {
      destroy(`/empresas/${id}`);
    }
  };

  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Empresas" />

      <div className="m-4">
        <Link href={'/empresas/create'}>
          <Button className="mb-4" size="sm">
            Nueva Empresa
          </Button>
        </Link>
        <div className="mb-2 text-center text-2xl">Lista de Empresas</div>
        {empresas.data.length > 0 && (
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead className="w-[100px]">ID</TableHead>
                <TableHead>Nombre</TableHead>
                <TableHead>Email</TableHead>
                <TableHead>Celular</TableHead>
                <TableHead>Activo</TableHead>
                <TableHead>Acción</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {empresas.data.map((empresa) => (
                <TableRow key={empresa.id}>
                  <TableCell className="font-medium">{empresa.id}</TableCell>
                  <TableCell>{empresa.nombre}</TableCell>
                  <TableCell>{empresa.email}</TableCell>
                  <TableCell>{empresa.telefono}</TableCell>
                  <TableCell>{empresa.activo}</TableCell>

                  <TableCell>
                    <Link href={`/empresas/${empresa.id}/edit`}>
                      <Button className="" size="icon" variant="outline">
                        <SquarePen />
                      </Button>
                    </Link>
                    <Button
                      disabled={processing}
                      className="ml-1"
                      size="icon"
                      variant="outline"
                      onClick={() => handleDelete(empresa.id)}
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
          <CustomPagination links={empresas.links} />
        </div>
      </div>
    </AppLayout>
  );
}
