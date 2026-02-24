import CustomPagination from '@/components/CustomPagination';
import { Button } from '@/components/ui/button';
import {
  Dialog,
  DialogContent,
  DialogFooter,
  DialogHeader,
  DialogTitle,
} from '@/components/ui/dialog';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from '@/components/ui/table';
import { Textarea } from '@/components/ui/textarea';
import { usePermissions } from '@/hooks/usePermissions';
import AppLayout from '@/layouts/app-layout';
import { type BreadcrumbItem } from '@/types';
import { Head, useForm, usePage } from '@inertiajs/react';
import { Eye, File, FileText } from 'lucide-react';
import { useState } from 'react';
import { toast } from 'sonner';

const breadcrumbs: BreadcrumbItem[] = [
  { title: 'Empresas', href: '/empresas' },
];

interface Certificado {
  titulo: string;
  establecimiento: string;
  actividad: string;
  validez: string;
  direccion: string;
  diagnostico: string;
  condicion: string;
  trabajo: string;
  plaguicidas: string;
  registro: string;
  area: string;
  acciones: string;
  ingredientes: string;
  logo: File | null;
}

interface CertificadoListado {
  id: number;
  titulo: string;
  actividad: string;
  validez: string;
  created_at: string;
}

interface Empresa {
  id: number;
  nombre: string;
  direccion: string;
  telefono: string;
  email: string;
  activo: boolean;
  certificados?: CertificadoListado[];
}

interface EmpresaPagination {
  data: Empresa[];
  links: { url: string | null; label: string; active: boolean }[];
}

export default function Lista() {
  const { empresas } = usePage<{ empresas: EmpresaPagination }>().props;
  const { hasRole, hasAnyRole, hasPermission } = usePermissions();

  const [openCreate, setOpenCreate] = useState(false);
  const [openList, setOpenList] = useState(false);
  const [empresaSeleccionada, setEmpresaSeleccionada] =
    useState<Empresa | null>(null);

  const { data, setData, post, processing, reset } = useForm<Certificado>({
    titulo: '',
    establecimiento: '',
    actividad: '',
    validez: '',
    direccion: '',
    diagnostico: '',
    condicion: '',
    trabajo: '',
    plaguicidas: '',
    registro: '',
    area: '',
    acciones: '',
    ingredientes: '',
    logo: null,
  });

  const openCrearCertificado = (empresa: Empresa) => {
    setEmpresaSeleccionada(empresa);
    setOpenCreate(true);
  };

  const openListaCertificados = (empresa: Empresa) => {
    setEmpresaSeleccionada(empresa);
    setOpenList(true);
  };

  const submit = () => {
    if (!empresaSeleccionada) return;

    post(`/empresas/${empresaSeleccionada.id}/certificados`, {
      forceFormData: true,

      onSuccess: () => {
        console.log('SUCCESS');
        window.open(`/empresas/certificadoultimo`, '_blank');
        reset();
        setOpenCreate(false);
        toast.success('Certificado creado con éxito');
      },
      onError: (errors) => {
        console.log('ERROR');
        console.log(errors);
        toast.error('No se pudo crear el certificado');
      },
    });
  };

  const handleDownloadPDF = (id: number) => {
    console.log('Print PDF id=' + id);
    window.open(`/empresas/${id}/certificadopdf`, '_blank');
  };

  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Empresas" />

      <div className="m-4">
        <div className="mb-2 text-2xl font-bold">Gestión de Empresas</div>

        <Table>
          <TableHeader>
            <TableRow>
              <TableHead>ID</TableHead>
              <TableHead>Nombre</TableHead>
              <TableHead>Email</TableHead>
              <TableHead>Celular</TableHead>
              {/* <TableHead>Activo</TableHead> */}
              <TableHead>Certificados</TableHead>
            </TableRow>
          </TableHeader>

          <TableBody>
            {empresas.data.map((empresa) => (
              <TableRow key={empresa.id}>
                <TableCell>{empresa.id}</TableCell>
                <TableCell>{empresa.nombre}</TableCell>
                <TableCell>{empresa.email}</TableCell>
                <TableCell>{empresa.telefono}</TableCell>
                {/* <TableCell>{empresa.activo ? 'Activo' : 'Inactivo'}</TableCell> */}

                <TableCell className="space-x-2">
                  {(hasRole('superadmin') || hasRole('admin')) && (
                    <Button
                      size="sm"
                      variant="default"
                      onClick={() => openCrearCertificado(empresa)}
                    >
                      <File className="mr-1 h-4 w-4" />
                      Crear
                    </Button>
                  )}

                  <Button
                    size="sm"
                    variant="outline"
                    onClick={() => openListaCertificados(empresa)}
                  >
                    <Eye className="mr-1 h-4 w-4" />
                    Ver
                  </Button>
                </TableCell>
              </TableRow>
            ))}
          </TableBody>
        </Table>

        <CustomPagination links={empresas.links} />
      </div>

      {/* DIALOG CREAR CERTIFICADO */}
      <Dialog open={openCreate} onOpenChange={setOpenCreate}>
        <DialogContent
          className="max-h-[90vh] overflow-y-auto sm:max-w-[800px]"
          onInteractOutside={(e) => e.preventDefault()}
        >
          <DialogHeader>
            <DialogTitle>
              Crear Certificado – {empresaSeleccionada?.nombre}
            </DialogTitle>
          </DialogHeader>

          <div className="grid grid-cols-1 gap-4 md:grid-cols-2">
            <div className="md:col-span-2">
              <Label>Logo</Label>
              <Input
                type="file"
                accept="image/*"
                onChange={(e) =>
                  setData('logo', e.target.files ? e.target.files[0] : null)
                }
              />
            </div>
            <div className="md:col-span-2">
              <Label htmlFor="titulo">CERTIFICADO DE:</Label>
              <Input
                id="titulo"
                value={data.titulo}
                onChange={(e) => setData('titulo', e.target.value)}
                placeholder="Ej: CONTROL DE VECTORES"
              />
            </div>
            <div className="md:col-span-2">
              <Label htmlFor="establecimiento">Al establecimiento:</Label>
              <Input
                id="establecimiento"
                value={data.establecimiento}
                onChange={(e) => setData('establecimiento', e.target.value)}
                placeholder="Nombre del establecimiento"
              />
            </div>
            <div>
              <Label htmlFor="actividad">Actividad del solicitante</Label>
              <Input
                id="actividad"
                value={data.actividad}
                onChange={(e) => setData('actividad', e.target.value)}
                placeholder="Ej: CAFE ESPACIO CULTURAL"
              />
            </div>

            <div>
              <Label htmlFor="validez">Validez de la certificación</Label>
              <Input
                id="validez"
                value={data.validez}
                onChange={(e) => setData('validez', e.target.value)}
                placeholder="Ej: 90 DIAS HABILES DEL ..."
              />
            </div>

            <div className="md:col-span-2">
              <Label htmlFor="direccion">Dirección</Label>
              <Input
                id="direccion"
                value={data.direccion}
                onChange={(e) => setData('direccion', e.target.value)}
                placeholder="Av. Principal 123, La Paz"
              />
            </div>

            <div className="md:col-span-2">
              <Label htmlFor="diagnostico">Diagnóstico</Label>
              <Input
                id="diagnostico"
                value={data.diagnostico}
                onChange={(e) => setData('diagnostico', e.target.value)}
                placeholder="Descripción del diagnóstico inicial..."
              />
            </div>

            <div className="md:col-span-2">
              <Label htmlFor="condicion">Condición sanitaria</Label>
              <Input
                id="condicion"
                value={data.condicion}
                onChange={(e) => setData('condicion', e.target.value)}
                placeholder="Ej: BUENA LIMPIEZA"
              />
            </div>

            <div className="">
              <Label htmlFor="trabajo">Trabajo realizado</Label>
              <Textarea
                id="trabajo"
                value={data.trabajo}
                onChange={(e) => setData('trabajo', e.target.value)}
              />
            </div>
            <div></div>

            {/* Puedes seguir con los demás... */}
            <div>
              <Label htmlFor="plaguicidas">Plaguicidas utilizados</Label>
              <Textarea
                id="plaguicidas"
                value={data.plaguicidas}
                onChange={(e) => setData('plaguicidas', e.target.value)}
              />
            </div>

            <div>
              <Label htmlFor="registro">Registros:</Label>
              <Textarea
                id="registro"
                value={data.registro}
                onChange={(e) => setData('registro', e.target.value)}
              />
            </div>

            <div className="">
              <Label htmlFor="trabajo">Ingrediente activo</Label>
              <Textarea
                id="ingredientes"
                value={data.ingredientes}
                onChange={(e) => setData('ingredientes', e.target.value)}
              />
            </div>
            <div></div>

            <div>
              <Label htmlFor="validez">Area tratada:</Label>
              <Input
                id="area"
                value={data.area}
                onChange={(e) => setData('area', e.target.value)}
                placeholder="Ej: 800 M2"
              />
            </div>

            <div>
              <Label htmlFor="validez">Acciones correctivas:</Label>
              <Input
                id="acciones"
                value={data.acciones}
                onChange={(e) => setData('acciones', e.target.value)}
                placeholder="Ej: CONTINUAR CON EL ORDEN Y LA LIMPIEZA"
              />
            </div>

            {/* {(
              Object.keys(data).filter(
                (k) => k !== 'logo',
              ) as (keyof Certificado)[]
            ).map((field) => (
              <div key={field}>
                <Label>{field}</Label>
                <Input
                  value={data[field] as string}
                  onChange={(e) => setData(field, e.target.value)}
                />
              </div>
            ))} */}
          </div>

          <DialogFooter>
            <Button variant="secondary" onClick={() => setOpenCreate(false)}>
              Cancelar
            </Button>
            <Button onClick={submit} disabled={processing}>
              Guardar
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>

      {/* DIALOG LISTA CERTIFICADOS */}
      <Dialog open={openList} onOpenChange={setOpenList}>
        <DialogContent
          className="sm:max-w-[700px]"
          onInteractOutside={(e) => e.preventDefault()}
          onEscapeKeyDown={(e) => e.preventDefault()}
        >
          <DialogHeader>
            <DialogTitle>
              Certificados – {empresaSeleccionada?.nombre}
            </DialogTitle>
          </DialogHeader>

          {empresaSeleccionada?.certificados?.length ? (
            <Table>
              <TableHeader>
                <TableRow>
                  <TableHead>ID</TableHead>
                  <TableHead>Título</TableHead>
                  {/* <TableHead>Validez</TableHead> */}
                  <TableHead>Acción</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {empresaSeleccionada.certificados.map((c) => (
                  <TableRow key={c.id}>
                    <TableCell>{c.id}</TableCell>
                    <TableCell>{c.titulo}</TableCell>
                    {/* <TableCell>{c.validez}</TableCell> */}
                    <TableCell>
                      <Button
                        size="sm"
                        variant="outline"
                        onClick={() => handleDownloadPDF(c.id)}
                      >
                        <FileText className="mr-1 h-4 w-4" />
                        Generar PDF
                      </Button>
                    </TableCell>
                  </TableRow>
                ))}
              </TableBody>
            </Table>
          ) : (
            <p className="text-sm text-muted-foreground">
              No hay certificados registrados.
            </p>
          )}

          <DialogFooter>
            <Button onClick={() => setOpenList(false)}>Cerrar</Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </AppLayout>
  );
}
