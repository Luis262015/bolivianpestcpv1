import { Button } from '@/components/ui/button';
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from '@/components/ui/table';
import { usePermissions } from '@/hooks/usePermissions';
import AppLayout from '@/layouts/app-layout';
import { type BreadcrumbItem } from '@/types';
import { Head, router } from '@inertiajs/react';
import { format } from 'date-fns';
import { Edit, FileChartColumn, Plus, Trash2 } from 'lucide-react';
import { useState } from 'react';
import ModalTrampas from './ModalTrampas';

const breadcrumbs: BreadcrumbItem[] = [
  {
    title: 'Trampa Seguimiento',
    href: '/trampaseguimientos',
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

interface TipoSeguimiento {
  id: number;
  nombre: string;
}

interface Props {
  empresas: Empresa[];
  almacenes: Almacen[];
  tipoSeguimiento: TipoSeguimiento[];
  seguimientos: any; // Aquí puedes definir el tipo completo
}

interface TrampaEspecieSeguimientos {
  id?: number;
  trampa_seguimiento_id?: number;
  trampa_id: number;
  especie_id: number;
  cantidad: number;
}

interface TrampaRoedoresSeguimiento {
  id?: number;
  trampa_seguimiento_id?: number;
  trampa_id: number;
  cantidad: number;
  inicial: number;
  merma: number;
  actual: number;
}

interface TrampaSeguimiento {
  id?: number;
  almacen_id: number;
  mapa_id: number;
  trampa_especies_seguimientos?: TrampaEspecieSeguimientos[];
  trampa_roedores_seguimientos?: TrampaRoedoresSeguimiento[];
}

const handleDelete = (id: number) => {
  if (confirm('¿Estás seguro?')) {
    router.delete(`/trampaseguimientos/${id}`);
  }
};

const handlePDF = (id: number) => {
  console.log('Imprimir PDF');
  window.open(`/trampaseguimientos/${id}/pdf`, '_blank');
};

export default function Lista({
  empresas,
  almacenes,
  seguimientos,
  tipoSeguimiento,
}: Props) {
  const [modalOpen, setModalOpen] = useState(false);
  // const [modalTrapsOpen, setModalTrapsOpen] = useState(false);

  const [seguimientoSeleccionado, setSeguimientoSeleccionado] =
    useState<TrampaSeguimiento | null>(null);

  const { hasRole, hasAnyRole, hasPermission } = usePermissions();

  // Para CREAR un nuevo seguimiento
  const handleNuevoSeguimiento = () => {
    console.log('vlnsldvnlsd');
    setSeguimientoSeleccionado(null);
    setModalOpen(true);
  };

  // Para EDITAR un seguimiento existente
  const handleEditarSeguimiento = (seguimiento: TrampaSeguimiento) => {
    setSeguimientoSeleccionado(seguimiento);
    setModalOpen(true);
  };

  const handleCloseModal = () => {
    setModalOpen(false);
    setSeguimientoSeleccionado(null);
  };

  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Seguimientos" />

      <div className="">
        <div className="mx-auto max-w-7xl">
          <div className="overflow-hidden sm:rounded-lg">
            <div className="p-6">
              <div className="mb-6 flex items-center">
                <h2 className="me-5 text-2xl font-semibold">
                  Gestión de Trampa Seguimientos
                </h2>
                {(hasRole('tecnico') ||
                  hasRole('superadmin') ||
                  hasRole('admin')) && (
                  <>
                    <Button
                      onClick={() => handleNuevoSeguimiento()}
                      className="me-3"
                    >
                      <Plus className="h-4 w-4" />
                      Nuevo
                    </Button>
                    {/* <Button
                      onClick={() => setModalTrapsOpen(true)}
                      className="me-3"
                    >
                      <Plus className="h-4 w-4" />
                      Reporte Trampas
                    </Button> */}
                  </>
                )}
              </div>
              <div className="space-y-4">
                {seguimientos?.data && seguimientos.data.length > 0 ? (
                  <Table>
                    <TableHeader>
                      <TableRow>
                        <TableHead className="w-12"></TableHead>
                        <TableHead className="text-center">Almacen</TableHead>
                        <TableHead className="text-center">Usuario</TableHead>
                        <TableHead className="text-center">Fecha</TableHead>
                        <TableHead className="text-center">Acciones</TableHead>
                      </TableRow>
                    </TableHeader>
                    <TableBody>
                      {seguimientos.data.map((seguimiento: any) => (
                        <TableRow key={seguimiento.id}>
                          <TableCell className="font-medium">
                            {seguimiento.id}
                          </TableCell>
                          <TableCell className="font-medium">
                            {seguimiento.almacen?.nombre}
                          </TableCell>
                          <TableCell className="font-medium">
                            {seguimiento.user?.name}
                          </TableCell>
                          <TableCell className="text-center font-mono text-xs text-muted-foreground sm:text-sm">
                            {format(
                              seguimiento.created_at,
                              'dd/MM/yyyy HH:mm:ss',
                            )}
                          </TableCell>
                          {/* <TableCell className="font-medium">
                            {seguimiento.almacen?.nombre}
                          </TableCell> */}
                          <TableCell className="flex justify-center gap-2">
                            <Button
                              size="icon"
                              variant="outline"
                              onClick={() =>
                                handleEditarSeguimiento(seguimiento)
                              }
                            >
                              <Edit className="h-4 w-4" />
                            </Button>
                            <Button
                              size="icon"
                              variant="outline"
                              onClick={() => handleDelete(seguimiento.id)}
                            >
                              <Trash2 className="h-4 w-4" />
                            </Button>
                            <Button
                              size="icon"
                              variant="outline"
                              onClick={() => handlePDF(seguimiento.id)}
                            >
                              <FileChartColumn className="h-4 w-4" />
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

      <ModalTrampas
        open={modalOpen}
        onClose={() => setModalOpen(false)}
        empresas={empresas}
        almacenes={almacenes}
        seguimiento={seguimientoSeleccionado}
      />
    </AppLayout>
  );
}
