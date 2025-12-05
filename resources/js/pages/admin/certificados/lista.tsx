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
import { FileText, SquarePen, Trash2 } from 'lucide-react';

const breadcrumbs: BreadcrumbItem[] = [
  {
    title: 'Certificados',
    href: '/certificados',
  },
];

interface Empresa {
  id: number;
  nombre: string;
}

interface Certificado {
  id: number;
  empresa: Empresa;
  titulo: string;
  registro: string;
}

interface CertificadosPaginate {
  data: Certificado[];
  links: { url: string | null; label: string; active: boolean }[];
}

export default function Lista() {
  const { processing, delete: destroy } = useForm();
  const { certificados } = usePage<{ certificados: CertificadosPaginate }>()
    .props;

  const handleDelete = (id: number) => {
    if (confirm('Estas seguro de eliminar el registro')) {
      destroy(`/certificados/${id}`);
    }
  };

  const generarPdf = (id: number) => {
    // Mantiene todos los filtros actuales de la tabla
    window.open(`/certificados/pdf?id=${id}`, '_blank');
  };

  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Certificados" />
      <div className="m-4">
        <Link href={'/certificados/create'}>
          <Button className="mb-4" size="sm">
            Nuevo Certificado
          </Button>
        </Link>
        <div className="mb-2 text-center text-2xl">Lista de Certificados</div>
        {certificados.data.length > 0 && (
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead className="w-[100px]">ID</TableHead>
                <TableHead>Empresa</TableHead>
                <TableHead>Titulo</TableHead>
                <TableHead>Registro</TableHead>
                <TableHead>Acción</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {certificados.data.map((certificado) => (
                <TableRow key={certificado.id}>
                  <TableCell className="font-medium">
                    {certificado.id}
                  </TableCell>
                  <TableCell>{certificado.empresa.nombre}</TableCell>
                  <TableCell>{certificado.titulo}</TableCell>
                  <TableCell>{certificado.registro}</TableCell>
                  <TableCell>
                    <Button
                      onClick={() => generarPdf(certificado.id)}
                      className=""
                      size="icon"
                      variant="outline"
                    >
                      <FileText />
                    </Button>

                    <Link href={`/certificados/${certificado.id}/edit`}>
                      <Button className="" size="icon" variant="outline">
                        <SquarePen />
                      </Button>
                    </Link>
                    <Button
                      disabled={processing}
                      className="ml-1"
                      size="icon"
                      variant="outline"
                      onClick={() => handleDelete(certificado.id)}
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
          <CustomPagination links={certificados.links} />
        </div>
      </div>
    </AppLayout>
  );
}
