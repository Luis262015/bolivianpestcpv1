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
import AppLayout from '@/layouts/app-layout';
import { type BreadcrumbItem } from '@/types';
import { Head, useForm, usePage } from '@inertiajs/react';
import { Eye, File, FileText } from 'lucide-react';
import { useState } from 'react';

const breadcrumbs: BreadcrumbItem[] = [
  { title: 'Empresas', href: '/empresas' },
];

interface Certificado {
  titulo: string;
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

  const [openCreate, setOpenCreate] = useState(false);
  const [openList, setOpenList] = useState(false);
  const [empresaSeleccionada, setEmpresaSeleccionada] =
    useState<Empresa | null>(null);

  const { data, setData, post, processing, reset } = useForm<Certificado>({
    titulo: '',
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
        reset();
        setOpenCreate(false);
      },
    });
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
              <TableHead>Activo</TableHead>
              <TableHead>Acciones</TableHead>
            </TableRow>
          </TableHeader>

          <TableBody>
            {empresas.data.map((empresa) => (
              <TableRow key={empresa.id}>
                <TableCell>{empresa.id}</TableCell>
                <TableCell>{empresa.nombre}</TableCell>
                <TableCell>{empresa.email}</TableCell>
                <TableCell>{empresa.telefono}</TableCell>
                <TableCell>{empresa.activo ? 'Activo' : 'Inactivo'}</TableCell>

                <TableCell className="space-x-2">
                  <Button
                    size="sm"
                    variant="outline"
                    onClick={() => openCrearCertificado(empresa)}
                  >
                    <File className="mr-1 h-4 w-4" />
                    Crear
                  </Button>

                  <Button
                    size="sm"
                    variant="secondary"
                    onClick={() => openListaCertificados(empresa)}
                  >
                    <Eye className="mr-1 h-4 w-4" />
                    Ver Certificados
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
        <DialogContent className="max-w-3xl">
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

            {(
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
            ))}
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
        <DialogContent className="max-w-2xl">
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
                  <TableHead>Validez</TableHead>
                  <TableHead>Acción</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {empresaSeleccionada.certificados.map((c) => (
                  <TableRow key={c.id}>
                    <TableCell>{c.id}</TableCell>
                    <TableCell>{c.titulo}</TableCell>
                    <TableCell>{c.validez}</TableCell>
                    <TableCell>
                      <Button size="sm" variant="outline">
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

// ----------------------------------------------------------------------
// import CustomPagination from '@/components/CustomPagination';
// import { Button } from '@/components/ui/button';
// import {
//   Dialog,
//   DialogContent,
//   DialogFooter,
//   DialogHeader,
//   DialogTitle,
// } from '@/components/ui/dialog';
// import { Input } from '@/components/ui/input';
// import { Label } from '@/components/ui/label';
// import {
//   Table,
//   TableBody,
//   TableCell,
//   TableHead,
//   TableHeader,
//   TableRow,
// } from '@/components/ui/table';
// import AppLayout from '@/layouts/app-layout';
// import { type BreadcrumbItem } from '@/types';
// import { Head, useForm, usePage } from '@inertiajs/react';
// import { File } from 'lucide-react';
// import { useState } from 'react';

// const breadcrumbs: BreadcrumbItem[] = [
//   {
//     title: 'Empresas',
//     href: '/empresas',
//   },
// ];

// interface Empresa {
//   id: number;
//   nombre: string;
//   direccion: string;
//   telefono: string;
//   email: string;
//   activo: boolean;
// }

// interface Certificado {
//   titulo: string;
//   actividad: string;
//   validez: string;
//   direccion: string;
//   diagnostico: string;
//   condicion: string;
//   trabajo: string;
//   plaguicidas: string;
//   registro: string;
//   area: string;
//   acciones: string;
//   logo: File | null;
// }

// interface EmpresaPagination {
//   data: Empresa[];
//   links: { url: string | null; label: string; active: boolean }[];
// }

// export default function Lista() {
//   // const { processing, delete: destroy } = useForm();
//   const { empresas } = usePage<{ empresas: EmpresaPagination }>().props;

//   const [open, setOpen] = useState(false);
//   const [empresaId, setEmpresaId] = useState<number | null>(null);

//   const {
//     data,
//     setData,
//     post,
//     processing,
//     reset,
//     delete: destroy,
//   } = useForm<Certificado>({
//     titulo: '',
//     actividad: '',
//     validez: '',
//     direccion: '',
//     diagnostico: '',
//     condicion: '',
//     trabajo: '',
//     plaguicidas: '',
//     registro: '',
//     area: '',
//     acciones: '',
//     logo: null,
//   });

//   const handleDelete = (id: number) => {
//     if (confirm('Estas seguro de eliminar el registro')) {
//       destroy(`/empresas/${id}`);
//     }
//   };

//   const handleCertificado = (id: number) => {
//     setEmpresaId(id);
//     setOpen(true);
//   };

//   const submit = () => {
//     if (!empresaId) return;

//     post(`/empresas/${empresaId}/certificados`, {
//       onSuccess: () => {
//         reset();
//         setOpen(false);
//       },
//     });
//   };

//   return (
//     <AppLayout breadcrumbs={breadcrumbs}>
//       <Head title="Empresas" />

//       <div className="m-4">
//         <div className="mb-2 text-2xl font-bold">Gestión de Empresas</div>
//         {empresas.data.length > 0 && (
//           <Table>
//             <TableHeader>
//               <TableRow>
//                 <TableHead className="w-[100px]">ID</TableHead>
//                 <TableHead className="text-center">Nombre</TableHead>
//                 <TableHead>Email</TableHead>
//                 <TableHead>Celular</TableHead>
//                 <TableHead>Activo</TableHead>
//                 <TableHead>Acción</TableHead>
//               </TableRow>
//             </TableHeader>
//             <TableBody>
//               {empresas.data.map((empresa) => (
//                 <TableRow key={empresa.id}>
//                   <TableCell className="font-medium">{empresa.id}</TableCell>
//                   <TableCell>{empresa.nombre}</TableCell>
//                   <TableCell>{empresa.email}</TableCell>
//                   <TableCell>{empresa.telefono}</TableCell>
//                   <TableCell>
//                     <span
//                       className={`rounded-full px-2 py-1 text-xs ${
//                         Number(empresa.activo) === 0
//                           ? 'bg-red-100 text-red-800'
//                           : 'bg-green-100 text-green-800'
//                       }`}
//                     >
//                       {Number(empresa.activo) == 1 ? 'Activo' : 'Inactivo'}
//                     </span>
//                   </TableCell>

//                   <TableCell>
//                     <Button
//                       variant="outline"
//                       size="sm"
//                       onClick={() => handleCertificado(empresa.id)}
//                     >
//                       <File />
//                       Crear Certificado
//                     </Button>
//                   </TableCell>
//                 </TableRow>
//               ))}
//             </TableBody>
//           </Table>
//         )}

//         <div className="my-2">
//           <CustomPagination links={empresas.links} />
//         </div>
//       </div>

//       {/* DIALOG CREAR CERTIFICADO */}
//       <Dialog open={open} onOpenChange={setOpen}>
//         <DialogContent className="max-w-3xl">
//           <DialogHeader>
//             <DialogTitle>Crear Certificado</DialogTitle>
//           </DialogHeader>

//           <div className="grid grid-cols-1 gap-4 md:grid-cols-2">
//             {/* INPUT LOGO */}
//             <div className="space-y-1 md:col-span-2">
//               <Label htmlFor="logo">Logo de la Empresa</Label>
//               <Input
//                 id="logo"
//                 type="file"
//                 accept="image/*"
//                 onChange={(e) =>
//                   setData('logo', e.target.files ? e.target.files[0] : null)
//                 }
//               />
//             </div>

//             {/* INPUTS DE TEXTO */}
//             {(
//               Object.keys(data).filter(
//                 (key) => key !== 'logo',
//               ) as (keyof Certificado)[]
//             ).map((field) => (
//               <div key={field} className="space-y-1">
//                 <Label htmlFor={field}>
//                   {field.charAt(0).toUpperCase() + field.slice(1)}
//                 </Label>
//                 <Input
//                   id={field}
//                   value={data[field] as string}
//                   onChange={(e) => setData(field, e.target.value)}
//                 />
//               </div>
//             ))}
//           </div>

//           <DialogFooter>
//             <Button
//               variant="secondary"
//               type="button"
//               onClick={() => setOpen(false)}
//             >
//               Cancelar
//             </Button>
//             <Button onClick={submit} disabled={processing}>
//               Guardar Certificado
//             </Button>
//           </DialogFooter>
//         </DialogContent>
//       </Dialog>

//     </AppLayout>
//   );
// }
