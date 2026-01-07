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
import { Head } from '@inertiajs/react';
import { Edit, Plus, Trash2 } from 'lucide-react';
import { useState } from 'react';
import ModalSeguimiento from './ModalSeguimiento';

const breadcrumbs: BreadcrumbItem[] = [
  {
    title: 'Seguimientos',
    href: '/seguimientos',
  },
];

interface Empresa {
  id: number;
  nombre: string;
}

interface Almacen {
  id: number;
  nombre: string;
}

interface Metodo {
  id: number;
  nombre: string;
}
interface Epp {
  id: number;
  nombre: string;
}
interface Proteccion {
  id: number;
  nombre: string;
}
interface Biologico {
  id: number;
  nombre: string;
}
interface Signo {
  id: number;
  nombre: string;
}

interface Especie {
  id: number;
  nombre: string;
}

interface TipoSeguimiento {
  id: number;
  nombre: string;
}

interface Props {
  empresas: Empresa[];
  almacenes: Almacen[];
  metodos: Metodo[];
  epps: Epp[];
  protecciones: Proteccion[];
  biologicos: Biologico[];
  signos: Signo[];
  especies: Especie[];
  tipoSeguimiento: TipoSeguimiento[];
  seguimientos: any; // Aquí puedes definir el tipo completo
}

export default function Lista({
  empresas,
  almacenes,
  seguimientos,
  metodos,
  epps,
  protecciones,
  biologicos,
  signos,
  especies,
  tipoSeguimiento,
}: Props) {
  const [modalOpen, setModalOpen] = useState(false);

  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Seguimientos" />

      <div className="">
        <div className="mx-auto max-w-7xl">
          <div className="overflow-hidden sm:rounded-lg">
            <div className="p-6">
              <div className="mb-6 flex items-center">
                <h2 className="me-5 text-2xl font-semibold">
                  Gestión de Seguimientos
                </h2>
                <Button onClick={() => setModalOpen(true)}>
                  <Plus className="mr-2 h-4 w-4" />
                  Nuevo
                </Button>
              </div>
              <div className="space-y-4">
                {seguimientos?.data && seguimientos.data.length > 0 ? (
                  <Table>
                    <TableHeader>
                      <TableRow>
                        <TableHead className="w-12"></TableHead>
                        <TableHead>Empresa</TableHead>
                        <TableHead>Almacen</TableHead>
                        <TableHead>Usuario</TableHead>
                        <TableHead>Acciones</TableHead>
                      </TableRow>
                    </TableHeader>
                    <TableBody>
                      {seguimientos.data.map((seguimiento: any) => (
                        <TableRow key={seguimiento.id}>
                          <TableCell className="font-medium">
                            {seguimiento.id}
                          </TableCell>
                          <TableCell className="font-medium">
                            {seguimiento.empresa?.nombre}
                          </TableCell>
                          <TableCell className="font-medium">
                            {seguimiento.almacen?.nombre}
                          </TableCell>
                          <TableCell className="font-medium">
                            {seguimiento.user?.name}
                          </TableCell>
                          <TableCell className="flex gap-2">
                            <Button
                              size="icon"
                              variant="outline"
                              // onClick={() => openEditModal(seguimiento)}
                            >
                              <Edit className="h-4 w-4" />
                            </Button>
                            <Button
                              size="icon"
                              variant="outline"
                              // onClick={() => handleDelete(seguimiento.id)}
                            >
                              <Trash2 className="h-4 w-4" />
                            </Button>
                          </TableCell>
                        </TableRow>
                      ))}
                    </TableBody>
                  </Table>
                ) : (
                  // seguimientos.data.map((seguimiento: any) => (

                  //   <div key={seguimiento.id} className="rounded-lg p-4">
                  //     <h3 className="font-medium">
                  //       {seguimiento.empresa?.nombre}
                  //     </h3>
                  //     <p className="text-sm text-gray-600">
                  //       {seguimiento.almacen?.nombre}
                  //     </p>
                  //     <p className="mt-2 text-sm">
                  //       {seguimiento.observaciones}
                  //     </p>
                  //   </div>
                  // ))
                  <p className="py-8 text-center text-gray-500">
                    No hay seguimientos registrados
                  </p>
                )}
              </div>
            </div>
          </div>
        </div>
      </div>

      <ModalSeguimiento
        open={modalOpen}
        onClose={() => setModalOpen(false)}
        empresas={empresas}
        almacenes={almacenes}
        metodos={metodos}
        epps={epps}
        protecciones={protecciones}
        biologicos={biologicos}
        signos={signos}
        especies={especies}
        tipoSeguimiento={tipoSeguimiento}
      />
    </AppLayout>
  );
}

// import {
//   Card,
//   CardContent,
//   CardDescription,
//   CardHeader,
//   CardTitle,
// } from '@/components/ui/card';
// import {
//   Select,
//   SelectContent,
//   SelectItem,
//   SelectTrigger,
//   SelectValue,
// } from '@/components/ui/select';
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
// import { Head, router } from '@inertiajs/react';

// const breadcrumbs: BreadcrumbItem[] = [
//   {
//     title: 'Seguimientos',
//     href: '/seguimientos',
//   },
// ];

// interface Empresa {
//   id: number;
//   nombre: string;
// }

// interface User {
//   id: number;
//   name: string;
// }

// interface Seguimiento {
//   id: number;
//   cliente_id: number;
//   user_id: number;
//   cantidad: number;
//   internas: number;
//   externas: number;
//   observaciones: string | null;
//   created_at: string;
//   cliente: Empresa;
//   user: User;
// }

// interface Props {
//   seguimientos: Seguimiento[];
//   empresas: Empresa[];
//   empresaSeleccionado?: string;
// }

// export default function Lista({
//   seguimientos,
//   empresas,
//   empresaSeleccionado,
// }: Props) {
//   const handleClienteChange = (empresaId: string) => {
//     if (empresaId === 'todos') {
//       router.get('seguimientos.index');
//     } else {
//       // router.get(route('seguimientos.index', { cliente_id: empresaId }));
//       router.get(`/seguimientos?empresa_id=${empresaId}`);
//     }
//   };
//   return (
//     <AppLayout breadcrumbs={breadcrumbs}>
//       <Head title="Seguimientos" />
//       <div className="container mx-auto py-8">
//         <Card>
//           <CardHeader>
//             <CardTitle>Seguimientos</CardTitle>
//             <CardDescription>
//               Listado de seguimientos por cliente
//             </CardDescription>
//           </CardHeader>
//           <CardContent>
//             <div className="mb-6">
//               <label className="mb-2 block text-sm font-medium">
//                 Filtrar por Cliente
//               </label>
//               <Select
//                 value={empresaSeleccionado || 'todos'}
//                 onValueChange={handleClienteChange}
//               >
//                 <SelectTrigger className="w-full md:w-[300px]">
//                   <SelectValue placeholder="Selecciona un cliente" />
//                 </SelectTrigger>
//                 <SelectContent>
//                   <SelectItem value="todos">Todos los clientes</SelectItem>
//                   {empresas.map((cliente) => (
//                     <SelectItem key={cliente.id} value={cliente.id.toString()}>
//                       {cliente.nombre}
//                     </SelectItem>
//                   ))}
//                 </SelectContent>
//               </Select>
//             </div>

//             {seguimientos.length === 0 ? (
//               <div className="py-8 text-center text-muted-foreground">
//                 No hay seguimientos para mostrar
//               </div>
//             ) : (
//               <div className="rounded-md border">
//                 <Table>
//                   <TableHeader>
//                     <TableRow>
//                       <TableHead>Cliente</TableHead>
//                       <TableHead>Usuario</TableHead>
//                       <TableHead className="text-right">Cantidad</TableHead>
//                       <TableHead className="text-right">Internas</TableHead>
//                       <TableHead className="text-right">Externas</TableHead>
//                       <TableHead>Observaciones</TableHead>
//                       <TableHead>Fecha</TableHead>
//                     </TableRow>
//                   </TableHeader>
//                   <TableBody>
//                     {seguimientos.map((seguimiento) => (
//                       <TableRow key={seguimiento.id}>
//                         <TableCell className="font-medium">
//                           {seguimiento.cliente.nombre}
//                         </TableCell>
//                         <TableCell>{seguimiento.user.name}</TableCell>
//                         <TableCell className="text-right">
//                           {seguimiento.cantidad}
//                         </TableCell>
//                         <TableCell className="text-right">
//                           {seguimiento.internas}
//                         </TableCell>
//                         <TableCell className="text-right">
//                           {seguimiento.externas}
//                         </TableCell>
//                         <TableCell className="max-w-xs truncate">
//                           {seguimiento.observaciones || '-'}
//                         </TableCell>
//                         <TableCell>
//                           {new Date(seguimiento.created_at).toLocaleDateString(
//                             'es-ES',
//                           )}
//                         </TableCell>
//                       </TableRow>
//                     ))}
//                   </TableBody>
//                 </Table>
//               </div>
//             )}
//           </CardContent>
//         </Card>
//       </div>
//     </AppLayout>
//   );
// }
