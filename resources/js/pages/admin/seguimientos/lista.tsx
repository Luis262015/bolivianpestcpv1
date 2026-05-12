import CustomPagination from '@/components/CustomPagination';
import { Button } from '@/components/ui/button';
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select';
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
import { Head, Link, router } from '@inertiajs/react';
import { format } from 'date-fns';
import { Edit2, FileChartColumn, Pencil, Plus, Trash2 } from 'lucide-react';
import { useState } from 'react';
import ModalEditarSeguimiento from './ModalEditarSeguimiento';
import ModalSeguimiento from './ModalSeguimiento';
import ModalSeguimientoTrampa from './ModalSeguimientoTrampa';

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

interface Usuario {
  id: number;
  name: string;
}

interface ActiveFilters {
  empresa_id?: string;
  almacen_id?: string;
  usuario_id?: string;
  tipo_seguimiento_id?: string;
  fecha_desde?: string;
  fecha_hasta?: string;
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
  seguimientos: any;
  usuarios: Usuario[];
  filters: ActiveFilters;
}

const handleDelete = (id: number) => {
  if (confirm('¿Estás seguro?')) {
    router.delete(`/seguimientos/${id}`);
  }
};

const handlePDF = (id: number) => {
  window.open(`/seguimientos/${id}/pdf`, '_blank');
};

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
  usuarios,
  filters: activeFilters,
}: Props) {
  const [modalOpen, setModalOpen] = useState(false);

  const { hasRole, hasPermission } = usePermissions();

  const [openTrampa, setOpenTrampa] = useState(false);
  const [selectedSeguimiento, setSelectedSeguimiento] = useState<any>(null);

  const [editModalOpen, setEditModalOpen] = useState(false);
  const [seguimientoToEditId, setSeguimientoToEditId] = useState<number | null>(null);

  const [filters, setFilters] = useState({
    empresa_id: activeFilters?.empresa_id ?? '',
    almacen_id: activeFilters?.almacen_id ?? '',
    usuario_id: activeFilters?.usuario_id ?? '',
    tipo_seguimiento_id: activeFilters?.tipo_seguimiento_id ?? '',
    fecha_desde: activeFilters?.fecha_desde ?? '',
    fecha_hasta: activeFilters?.fecha_hasta ?? '',
  });

  const applyFilters = () => {
    const params: Record<string, string> = {};
    Object.entries(filters).forEach(([key, value]) => {
      if (value) params[key] = value;
    });
    router.get('/seguimientos', params, { preserveScroll: true });
  };

  const resetFilters = () => {
    setFilters({
      empresa_id: '',
      almacen_id: '',
      usuario_id: '',
      tipo_seguimiento_id: '',
      fecha_desde: '',
      fecha_hasta: '',
    });
    router.get('/seguimientos', {}, { preserveScroll: true });
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
                  Gestión de Seguimientos
                </h2>
                {(hasRole('tecnico') ||
                  hasRole('superadmin') ||
                  hasRole('admin')) && (
                  <>
                    <Button onClick={() => setModalOpen(true)} className="me-3">
                      <Plus className="h-4 w-4" />
                      Nuevo
                    </Button>
                    <Link href="/acciones">
                      <Button className="bg-sky-700">
                        Acciones complementarias
                      </Button>
                    </Link>
                  </>
                )}
              </div>

              {/* Filtros */}
              <div className="mb-6 grid gap-4 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-6">
                <div>
                  <label className="mb-1 block text-sm font-medium text-gray-700">
                    Empresa
                  </label>
                  <Select
                    value={filters.empresa_id || '_all'}
                    onValueChange={(v) =>
                      setFilters((f) => ({ ...f, empresa_id: v === '_all' ? '' : v }))
                    }
                  >
                    <SelectTrigger className="w-full">
                      <SelectValue placeholder="Todas" />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="_all">Todas</SelectItem>
                      {empresas.map((e) => (
                        <SelectItem key={e.id} value={String(e.id)}>
                          {e.nombre}
                        </SelectItem>
                      ))}
                    </SelectContent>
                  </Select>
                </div>

                <div>
                  <label className="mb-1 block text-sm font-medium text-gray-700">
                    Almacén
                  </label>
                  <Select
                    value={filters.almacen_id || '_all'}
                    onValueChange={(v) =>
                      setFilters((f) => ({ ...f, almacen_id: v === '_all' ? '' : v }))
                    }
                  >
                    <SelectTrigger className="w-full">
                      <SelectValue placeholder="Todos" />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="_all">Todos</SelectItem>
                      {almacenes.map((a) => (
                        <SelectItem key={a.id} value={String(a.id)}>
                          {a.nombre}
                        </SelectItem>
                      ))}
                    </SelectContent>
                  </Select>
                </div>

                <div>
                  <label className="mb-1 block text-sm font-medium text-gray-700">
                    Usuario
                  </label>
                  <Select
                    value={filters.usuario_id || '_all'}
                    onValueChange={(v) =>
                      setFilters((f) => ({ ...f, usuario_id: v === '_all' ? '' : v }))
                    }
                  >
                    <SelectTrigger className="w-full">
                      <SelectValue placeholder="Todos" />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="_all">Todos</SelectItem>
                      {usuarios.map((u) => (
                        <SelectItem key={u.id} value={String(u.id)}>
                          {u.name}
                        </SelectItem>
                      ))}
                    </SelectContent>
                  </Select>
                </div>

                <div>
                  <label className="mb-1 block text-sm font-medium text-gray-700">
                    Tipo
                  </label>
                  <Select
                    value={filters.tipo_seguimiento_id || '_all'}
                    onValueChange={(v) =>
                      setFilters((f) => ({
                        ...f,
                        tipo_seguimiento_id: v === '_all' ? '' : v,
                      }))
                    }
                  >
                    <SelectTrigger className="w-full">
                      <SelectValue placeholder="Todos" />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="_all">Todos</SelectItem>
                      {tipoSeguimiento.map((t) => (
                        <SelectItem key={t.id} value={String(t.id)}>
                          {t.nombre}
                        </SelectItem>
                      ))}
                    </SelectContent>
                  </Select>
                </div>

                <div>
                  <label className="mb-1 block text-sm font-medium text-gray-700">
                    Desde
                  </label>
                  <input
                    type="date"
                    value={filters.fecha_desde}
                    onChange={(e) =>
                      setFilters((f) => ({ ...f, fecha_desde: e.target.value }))
                    }
                    className="w-full rounded-md border border-gray-300 px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500"
                  />
                </div>

                <div>
                  <label className="mb-1 block text-sm font-medium text-gray-700">
                    Hasta
                  </label>
                  <input
                    type="date"
                    value={filters.fecha_hasta}
                    onChange={(e) =>
                      setFilters((f) => ({ ...f, fecha_hasta: e.target.value }))
                    }
                    className="w-full rounded-md border border-gray-300 px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500"
                  />
                </div>
              </div>

              <div className="mb-4 flex gap-2">
                <Button onClick={applyFilters}>Filtrar</Button>
                <Button variant="outline" onClick={resetFilters}>
                  Limpiar
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
                        <TableHead className="text-center">Tipo</TableHead>
                        <TableHead className="text-center">Fecha</TableHead>
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
                          <TableCell className="text-center font-medium">
                            {seguimiento.tipo_seguimiento?.nombre}
                          </TableCell>
                          <TableCell className="text-center font-mono text-xs text-muted-foreground sm:text-sm">
                            {format(seguimiento.created_at, 'dd/MM/yyyy HH:mm:ss')}
                          </TableCell>
                          <TableCell className="flex gap-2">
                            {(hasRole('superadmin') ||
                              hasRole('admin') ||
                              hasRole('tecnico')) && (
                              <Button
                                size="icon"
                                variant="outline"
                                onClick={() => {
                                  setSeguimientoToEditId(seguimiento.id);
                                  setEditModalOpen(true);
                                }}
                              >
                                <Pencil className="h-4 w-4" />
                              </Button>
                            )}

                            {(hasRole('superadmin') || hasRole('admin')) && (
                              <Button
                                size="icon"
                                variant="outline"
                                onClick={() => handleDelete(seguimiento.id)}
                              >
                                <Trash2 className="h-4 w-4" />
                              </Button>
                            )}

                            <Button
                              size="icon"
                              variant="outline"
                              onClick={() => handlePDF(seguimiento.id)}
                            >
                              <FileChartColumn className="h-4 w-4" />
                            </Button>

                            {Number(seguimiento.tipo_seguimiento_id) !== 2 && (
                              <Button
                                size="icon"
                                variant="outline"
                                onClick={() => {
                                  setSelectedSeguimiento(seguimiento);
                                  setOpenTrampa(true);
                                }}
                              >
                                <Edit2 className="h-4 w-4" />
                              </Button>
                            )}
                          </TableCell>
                        </TableRow>
                      ))}
                    </TableBody>
                  </Table>
                ) : null}

                {seguimientos?.links && seguimientos.links.length > 3 && (
                  <div className="mt-4">
                    <CustomPagination links={seguimientos.links} />
                  </div>
                )}

                {(!seguimientos?.data || seguimientos.data.length === 0) && (
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

      <ModalEditarSeguimiento
        open={editModalOpen}
        onClose={() => {
          setEditModalOpen(false);
          setSeguimientoToEditId(null);
        }}
        seguimientoId={seguimientoToEditId}
        metodos={metodos}
        epps={epps}
        protecciones={protecciones}
        biologicos={biologicos}
        signos={signos}
        especies={especies}
        tipoSeguimiento={tipoSeguimiento}
      />

      {selectedSeguimiento && (
        <ModalSeguimientoTrampa
          open={openTrampa}
          onClose={() => {
            setOpenTrampa(false);
            setSelectedSeguimiento(null);
          }}
          seguimientoId={selectedSeguimiento.id}
          almacenId={selectedSeguimiento.almacen_id}
          tipoSeguimiento={String(selectedSeguimiento.tipo_seguimiento_id)}
          initialData={{
            trampa_especies_seguimientos:
              selectedSeguimiento.trampa_especies_seguimientos,
            trampa_roedores_seguimientos:
              selectedSeguimiento.trampa_roedores_seguimientos,
          }}
        />
      )}
    </AppLayout>
  );
}
