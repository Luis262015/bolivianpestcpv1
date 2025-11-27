import { Button } from '@/components/ui/button';
import { Card, CardContent } from '@/components/ui/card';
import { Input } from '@/components/ui/input';
import AppLayout from '@/layouts/app-layout';
import { type BreadcrumbItem } from '@/types';
import { Head, router, useForm, usePage } from '@inertiajs/react';
import { format } from 'date-fns';
import {
  Download,
  Edit,
  FileSpreadsheet,
  FileText,
  Trash2,
} from 'lucide-react';

const breadcrumbs: BreadcrumbItem[] = [
  {
    title: 'Documetos',
    href: '/documentos',
  },
];

type Document = {
  id: number;
  nombre: string;
  descripcion: string | null;
  tipo: 'pdf' | 'docx' | 'excel';
  created_at: string;
};

type PageProps = {
  documents: {
    data: Document[];
    links: any[];
  };
  filters: {
    search?: string;
  };
};

export default function Lista() {
  const { documents, filters } = usePage<PageProps>().props;
  const { delete: destroy } = useForm();

  const getIcon = (tipo: string) => {
    switch (tipo) {
      case 'pdf':
        return <FileText className="h-10 w-10 text-red-600" />;
      case 'docx':
        return <FileText className="h-10 w-10 text-blue-600" />;
      case 'excel':
        return <FileSpreadsheet className="h-10 w-10 text-green-600" />;
      default:
        return <FileText className="h-10 w-10 text-gray-600" />;
    }
  };

  const handleSearch = (value: string) => {
    router.get(
      '/documents',
      { search: value },
      {
        preserveState: true,
        replace: true,
      },
    );
  };
  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Documentos" />
      <div className="mx-auto max-w-7xl px-4 py-10">
        <div className="mb-8 flex flex-col items-start justify-between gap-4 sm:flex-row sm:items-center">
          <h1 className="text-3xl font-bold">Mis Documentos</h1>
          <Button asChild>
            <a href="/documentos/create">+ Subir nuevo</a>
          </Button>
        </div>

        <div className="mb-8">
          <Input
            placeholder="Buscar por nombre..."
            defaultValue={filters.search || ''}
            onChange={(e) => handleSearch(e.target.value)}
            className="max-w-md"
          />
        </div>

        {documents.data.length === 0 ? (
          <div className="py-16 text-center">
            <p className="text-lg text-gray-500">No hay documentos aún</p>
            <Button asChild className="mt-4">
              <a href="/documentos/create">Subir el primero</a>
            </Button>
          </div>
        ) : (
          <div className="grid grid-cols-1 gap-6 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">
            {documents.data.map((doc) => (
              <Card key={doc.id} className="transition-shadow hover:shadow-lg">
                <CardContent className="flex flex-col items-center space-y-4 p-6 text-center">
                  {getIcon(doc.tipo)}

                  <div className="w-full flex-1 space-y-2">
                    <h3 className="line-clamp-2 text-lg font-semibold">
                      {doc.nombre}
                    </h3>
                    {doc.descripcion && (
                      <p className="line-clamp-2 text-sm text-gray-500">
                        "";
                        {doc.descripcion}
                      </p>
                    )}
                    <p className="text-xs text-gray-400">
                      {format(new Date(doc.created_at), 'dd/MM/yyyy')}
                    </p>
                  </div>

                  <div className="flex w-full flex-wrap justify-center gap-2">
                    <Button size="sm" variant="outline" asChild>
                      <a
                        href={`/documentos/${doc.id}/download`}
                        target="_blank"
                        rel="noopener noreferrer"
                      >
                        <Download className="mr-1 h-4 w-4" />
                        Descargar
                      </a>
                    </Button>

                    <Button size="sm" asChild>
                      <a href={`/documentos/${doc.id}/edit`}>
                        <Edit className="h-4 w-4" />
                      </a>
                    </Button>

                    <Button
                      size="sm"
                      variant="destructive"
                      onClick={() => {
                        if (
                          confirm(
                            '¿Seguro que quieres eliminar este documento?',
                          )
                        ) {
                          destroy(`/documentos/${doc.id}`, {
                            preserveState: false,
                          });
                        }
                      }}
                    >
                      <Trash2 className="h-4 w-4" />
                    </Button>
                  </div>
                </CardContent>
              </Card>
            ))}
          </div>
        )}

        {/* Paginación simple (sin route()) */}
        {documents.links && documents.links.length > 3 && (
          <div className="mt-12 flex justify-center">
            <div
              className="flex gap-2"
              dangerouslySetInnerHTML={{
                __html: documents.links
                  .map((link: any) => {
                    if (!link.url) {
                      return `<span class="px-4 py-2 bg-gray-200 text-gray-500 rounded cursor-not-allowed">${link.label}</span>`;
                    }
                    const isActive = link.active;
                    return `<a href="${link.url}" class="px-4 py-2 rounded ${
                      isActive
                        ? 'bg-primary text-white'
                        : 'bg-gray-100 hover:bg-gray-200'
                    }">${link.label}</a>`;
                  })
                  .join(''),
              }}
            />
          </div>
        )}
      </div>
    </AppLayout>
  );
}
