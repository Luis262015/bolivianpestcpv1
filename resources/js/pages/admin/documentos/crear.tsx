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
import { Head, useForm } from '@inertiajs/react';
import { FileSpreadsheet, FileText, Upload, X } from 'lucide-react';
import { FormEvent, useState } from 'react';

const breadcrumbs: BreadcrumbItem[] = [
  {
    title: 'Documetos',
    href: '/documentos',
  },
];

export default function Crear() {
  const { data, setData, post, processing, errors, reset } = useForm({
    nombre: '',
    descripcion: '',
    archivo: null as File | null,
  });

  const [dragActive, setDragActive] = useState(false);

  const handleDrag = (e: React.DragEvent) => {
    e.preventDefault();
    e.stopPropagation();
    if (e.type === 'dragenter' || e.type === 'dragover') {
      setDragActive(true);
    } else if (e.type === 'dragleave') {
      setDragActive(false);
    }
  };

  const handleDrop = (e: React.DragEvent) => {
    e.preventDefault();
    e.stopPropagation();
    setDragActive(false);
    if (e.dataTransfer.files?.[0]) {
      handleFile(e.dataTransfer.files[0]);
    }
  };

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    e.preventDefault();
    if (e.target.files?.[0]) {
      handleFile(e.target.files[0]);
    }
  };

  const handleFile = (file: File) => {
    const validExtensions = ['.pdf', '.docx', '.xlsx', '.xls'];
    const ext = '.' + file.name.split('.').pop()?.toLowerCase();

    if (!validExtensions.includes(ext)) {
      alert('Solo se permiten archivos PDF, Word (.docx) o Excel (.xlsx/.xls)');
      return;
    }
    if (file.size > 10 * 1024 * 1024) {
      alert('El archivo no puede pesar más de 10 MB');
      return;
    }
    setData('archivo', file);
  };

  const getFileIcon = () => {
    if (!data.archivo) return null;
    const name = data.archivo.name.toLowerCase();
    if (name.endsWith('.pdf'))
      return <FileText className="h-10 w-10 text-red-600" />;
    if (name.endsWith('.docx'))
      return <FileText className="h-10 w-10 text-blue-600" />;
    if (name.endsWith('.xlsx') || name.endsWith('.xls'))
      return <FileSpreadsheet className="h-10 w-10 text-green-600" />;
    return <FileText className="h-10 w-10 text-gray-600" />;
  };

  const removeFile = () => {
    setData('archivo', null);
    const input = document.getElementById('dropzone-file') as HTMLInputElement;
    if (input) input.value = '';
  };

  const submit = (e: FormEvent) => {
    e.preventDefault();
    if (!data.archivo) return;

    post('/documentos', {
      forceFormData: true,
      onSuccess: () => {
        reset();
        removeFile();
      },
    });
  };

  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Documentos" />
      <div className="mx-auto max-w-3xl py-10">
        <Card>
          <CardHeader>
            <CardTitle>Subir Documento</CardTitle>
            <CardDescription>
              Arrastra tu archivo o haz clic para seleccionar (PDF, Word o
              Excel)
            </CardDescription>
          </CardHeader>

          <CardContent>
            <form onSubmit={submit} className="space-y-6">
              <div>
                <Label htmlFor="nombre">Nombre del documento</Label>
                <Input
                  id="nombre"
                  value={data.nombre}
                  onChange={(e) => setData('nombre', e.target.value)}
                  required
                  placeholder="Ej: Contrato 2025 - Cliente XYZ"
                />
                {errors.nombre && (
                  <p className="mt-1 text-sm text-red-600">{errors.nombre}</p>
                )}
              </div>

              <div>
                <Label htmlFor="descripcion">Descripción (opcional)</Label>
                <Textarea
                  id="descripcion"
                  value={data.descripcion || ''}
                  onChange={(e) => setData('descripcion', e.target.value)}
                  placeholder="Información adicional sobre el documento..."
                  rows={3}
                />
              </div>

              {/* Drag & Drop Zone */}
              <div>
                <Label>Archivo</Label>
                <div
                  onDragEnter={handleDrag}
                  onDragLeave={handleDrag}
                  onDragOver={handleDrag}
                  onDrop={handleDrop}
                  className={cn(
                    'relative mt-2 flex h-64 w-full cursor-pointer flex-col items-center justify-center rounded-lg border-2 border-dashed transition-all',
                    dragActive
                      ? 'border-primary bg-primary/5'
                      : 'border-gray-300',
                    data.archivo
                      ? 'border-green-500 bg-green-50'
                      : 'hover:border-gray-400',
                  )}
                >
                  <input
                    id="dropzone-file"
                    type="file"
                    accept=".pdf,.docx,.xlsx,.xls"
                    onChange={handleChange}
                    className="absolute inset-0 z-10 h-full w-full cursor-pointer opacity-0"
                  />

                  {!data.archivo ? (
                    <div className="p-10 text-center">
                      <Upload
                        className={cn(
                          'mx-auto mb-4 h-12 w-12',
                          dragActive ? 'text-primary' : 'text-gray-400',
                        )}
                      />
                      <p className="text-lg font-medium">
                        {dragActive
                          ? 'Suelta el archivo aquí'
                          : 'Arrastra un archivo aquí'}
                      </p>
                      <p className="mt-2 text-sm text-gray-500">
                        o haz clic para seleccionar
                      </p>
                      <p className="mt-4 text-xs text-gray-400">
                        Formatos permitidos: PDF, Word (.docx), Excel (.xlsx,
                        .xls) · Máx. 10 MB
                      </p>
                    </div>
                  ) : (
                    <div className="flex w-full items-center gap-4 p-8">
                      {getFileIcon()}
                      <div className="min-w-0 flex-1">
                        <p className="truncate font-medium">
                          {data.archivo.name}
                        </p>
                        <p className="text-sm text-gray-500">
                          {(data.archivo.size / 1024 / 1024).toFixed(2)} MB
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
                  <Alert variant="destructive" className="mt-3">
                    <AlertDescription>{errors.archivo}</AlertDescription>
                  </Alert>
                )}
              </div>

              <div className="flex gap-4">
                <Button type="submit" disabled={processing || !data.archivo}>
                  {processing ? 'Subiendo...' : 'Subir Documento'}
                </Button>
                <Button
                  type="button"
                  variant="outline"
                  onClick={() => {
                    reset();
                    removeFile();
                  }}
                >
                  Limpiar
                </Button>
              </div>
            </form>
          </CardContent>
        </Card>
      </div>
    </AppLayout>
  );
}
