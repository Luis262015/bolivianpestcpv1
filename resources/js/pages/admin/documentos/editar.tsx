import { Alert, AlertDescription } from '@/components/ui/alert';
import { Button } from '@/components/ui/button';
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from '@/components/ui/card';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Textarea } from '@/components/ui/textarea';
import AppLayout from '@/layouts/app-layout';
import { cn } from '@/lib/utils';
import { type BreadcrumbItem } from '@/types';
import { Head, router, usePage } from '@inertiajs/react';
import { ArrowLeft, FileSpreadsheet, FileText, Upload, X } from 'lucide-react';
import { FormEvent, useRef, useState } from 'react';

const breadcrumbs: BreadcrumbItem[] = [
  {
    title: 'Documetos',
    href: '/documentos',
  },
];

type DocumentProps = {
  id: number;
  nombre: string;
  descripcion: string | null;
  tipo: 'pdf' | 'docx' | 'excel';
  ruta: string;
};
export default function Editar() {
  const { document: doc } = usePage<{ document: DocumentProps }>().props;

  const [nombre, setNombre] = useState(doc.nombre);
  const [descripcion, setDescripcion] = useState(doc.descripcion || '');
  const [archivo, setArchivo] = useState<File | null>(null);
  const [dragActive, setDragActive] = useState(false);
  const [errors, setErrors] = useState<Record<string, string>>({});
  const fileInputRef = useRef<HTMLInputElement>(null);

  const handleDrag = (e: React.DragEvent) => {
    e.preventDefault();
    e.stopPropagation();
    if (e.type === 'dragenter' || e.type === 'dragover') setDragActive(true);
    else if (e.type === 'dragleave') setDragActive(false);
  };

  const handleDrop = (e: React.DragEvent) => {
    e.preventDefault();
    e.stopPropagation();
    setDragActive(false);
    if (e.dataTransfer.files?.[0])
      handleFileChange({ target: { files: e.dataTransfer.files } } as any);
  };

  const handleFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    if (e.target.files?.[0]) {
      const file = e.target.files[0];
      const validExtensions = ['.pdf', '.docx', '.xlsx', '.xls'];
      const ext = '.' + file.name.split('.').pop()?.toLowerCase();
      if (!validExtensions.includes(ext)) {
        alert('Solo PDF, Word o Excel');
        return;
      }
      if (file.size > 10 * 1024 * 1024) {
        alert('Máx 10 MB');
        return;
      }
      setArchivo(file);
    }
  };

  const removeFile = () => {
    setArchivo(null);
    if (fileInputRef.current) fileInputRef.current.value = '';
  };

  const getFileIcon = (tipoOrFile: string | File) => {
    let tipo =
      typeof tipoOrFile === 'string'
        ? tipoOrFile
        : tipoOrFile.name.toLowerCase().includes('.pdf')
          ? 'pdf'
          : tipoOrFile.name.endsWith('.docx')
            ? 'docx'
            : 'excel';
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

  const submit = (e: FormEvent) => {
    e.preventDefault();

    // Crear FormData manual
    const formData = new FormData();
    formData.append('nombre', nombre);
    formData.append('descripcion', descripcion);
    if (archivo) formData.append('archivo', archivo);

    // SPOOFING: Envía POST pero Laravel lo trata como PUT
    formData.append('_method', 'PUT');

    // Debug: Ver qué se envía
    console.log('Enviando FormData:');
    for (const [key, value] of formData.entries()) {
      console.log(key, value);
    }

    router.post(`/documentos/${doc.id}`, formData, {
      forceFormData: true,
      onSuccess: () => {
        console.log('¡Éxito! Documento actualizado');
        removeFile();
      },
      onError: (serverErrors) => {
        console.log('Errores del servidor:', serverErrors);
        setErrors(serverErrors);
      },
    });
  };

  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Documentos" />
      <div className="mx-auto max-w-3xl px-4 py-10">
        <div className="mb-8 flex items-center gap-4">
          <Button variant="ghost" size="icon" asChild>
            <a href="/documents">
              <ArrowLeft className="h-5 w-5" />
            </a>
          </Button>
          <h1 className="text-3xl font-bold">Editar Documento</h1>
        </div>

        <Card>
          <CardHeader>
            <CardTitle>Modificar documento</CardTitle>
            <CardDescription>
              Cambia nombre, descripción o reemplaza el archivo
            </CardDescription>
          </CardHeader>
          <CardContent>
            <form onSubmit={submit} className="space-y-6">
              <div>
                <Label htmlFor="nombre">Nombre</Label>
                <Input
                  id="nombre"
                  value={nombre}
                  onChange={(e) => setNombre(e.target.value)}
                  required
                />
                {errors.nombre && (
                  <Alert variant="destructive" className="mt-2">
                    <AlertDescription>{errors.nombre}</AlertDescription>
                  </Alert>
                )}
              </div>

              <div>
                <Label htmlFor="descripcion">Descripción</Label>
                <Textarea
                  id="descripcion"
                  value={descripcion}
                  onChange={(e) => setDescripcion(e.target.value)}
                  rows={3}
                />
              </div>

              {/* Archivo actual */}
              {!archivo && (
                <div className="rounded-lg border bg-gray-50 p-4">
                  <div className="flex items-center gap-4">
                    {getFileIcon(doc.tipo)}
                    <div>
                      <p className="font-medium">Actual</p>
                      <p className="text-sm text-gray-600">
                        {doc.nombre}.{doc.tipo === 'excel' ? 'xlsx' : doc.tipo}
                      </p>
                    </div>
                  </div>
                </div>
              )}

              {/* Nuevo archivo */}
              <div>
                <Label>Nuevo archivo (opcional)</Label>
                <div
                  onDragEnter={handleDrag}
                  onDragLeave={handleDrag}
                  onDragOver={handleDrag}
                  onDrop={handleDrop}
                  className={cn(
                    'relative mt-2 flex h-56 w-full cursor-pointer flex-col items-center justify-center rounded-lg border-2 border-dashed transition-all',
                    dragActive
                      ? 'border-primary bg-primary/5'
                      : 'border-gray-300',
                    archivo
                      ? 'border-green-500 bg-green-50'
                      : 'hover:border-gray-400',
                  )}
                >
                  <input
                    ref={fileInputRef}
                    id="archivo"
                    type="file"
                    accept=".pdf,.docx,.xlsx,.xls"
                    onChange={handleFileChange}
                    className="absolute inset-0 z-10 h-full w-full cursor-pointer opacity-0"
                  />

                  {!archivo ? (
                    <div className="p-8 text-center">
                      <Upload
                        className={cn(
                          'mx-auto mb-4 h-12 w-12',
                          dragActive ? 'text-primary' : 'text-gray-400',
                        )}
                      />
                      <p className="text-lg font-medium">
                        {dragActive ? 'Suelta aquí' : 'Arrastra nuevo archivo'}
                      </p>
                      <p className="mt-2 text-sm text-gray-500">o haz clic</p>
                    </div>
                  ) : (
                    <div className="flex w-full items-center gap-4 p-6">
                      {getFileIcon(archivo)}
                      <div className="min-w-0 flex-1">
                        <p className="truncate font-medium">{archivo.name}</p>
                        <p className="text-sm text-gray-500">
                          {(archivo.size / 1024 / 1024).toFixed(2)} MB
                        </p>
                      </div>
                      <Button
                        type="button"
                        variant="ghost"
                        size="icon"
                        onClick={(e) => {
                          e.stopPropagation();
                          removeFile();
                        }}
                      >
                        <X className="h-5 w-5" />
                      </Button>
                    </div>
                  )}
                </div>
                {errors.archivo && (
                  <Alert variant="destructive" className="mt-2">
                    <AlertDescription>{errors.archivo}</AlertDescription>
                  </Alert>
                )}
              </div>

              <div className="flex gap-4">
                <Button type="submit" disabled={false}>
                  Guardar cambios
                </Button>
                <Button type="button" variant="outline" asChild>
                  <a href="/documents">Cancelar</a>
                </Button>
              </div>
            </form>
          </CardContent>
        </Card>
      </div>
    </AppLayout>
  );
}
