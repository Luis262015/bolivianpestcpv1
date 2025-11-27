import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from '@/components/ui/card';
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
import AppLayout from '@/layouts/app-layout';
import { type BreadcrumbItem } from '@/types';
import { Head, router } from '@inertiajs/react';

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

interface User {
  id: number;
  name: string;
}

interface Seguimiento {
  id: number;
  cliente_id: number;
  user_id: number;
  cantidad: number;
  internas: number;
  externas: number;
  observaciones: string | null;
  created_at: string;
  cliente: Empresa;
  user: User;
}

interface Props {
  seguimientos: Seguimiento[];
  empresas: Empresa[];
  empresaSeleccionado?: string;
}

export default function Lista({
  seguimientos,
  empresas,
  empresaSeleccionado,
}: Props) {
  const handleClienteChange = (empresaId: string) => {
    if (empresaId === 'todos') {
      router.get('seguimientos.index');
    } else {
      // router.get(route('seguimientos.index', { cliente_id: empresaId }));
      router.get(`/seguimientos?empresa_id=${empresaId}`);
    }
  };
  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Seguimientos" />
      <div className="container mx-auto py-8">
        <Card>
          <CardHeader>
            <CardTitle>Seguimientos</CardTitle>
            <CardDescription>
              Listado de seguimientos por cliente
            </CardDescription>
          </CardHeader>
          <CardContent>
            <div className="mb-6">
              <label className="mb-2 block text-sm font-medium">
                Filtrar por Cliente
              </label>
              <Select
                value={empresaSeleccionado || 'todos'}
                onValueChange={handleClienteChange}
              >
                <SelectTrigger className="w-full md:w-[300px]">
                  <SelectValue placeholder="Selecciona un cliente" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="todos">Todos los clientes</SelectItem>
                  {empresas.map((cliente) => (
                    <SelectItem key={cliente.id} value={cliente.id.toString()}>
                      {cliente.nombre}
                    </SelectItem>
                  ))}
                </SelectContent>
              </Select>
            </div>

            {seguimientos.length === 0 ? (
              <div className="py-8 text-center text-muted-foreground">
                No hay seguimientos para mostrar
              </div>
            ) : (
              <div className="rounded-md border">
                <Table>
                  <TableHeader>
                    <TableRow>
                      <TableHead>Cliente</TableHead>
                      <TableHead>Usuario</TableHead>
                      <TableHead className="text-right">Cantidad</TableHead>
                      <TableHead className="text-right">Internas</TableHead>
                      <TableHead className="text-right">Externas</TableHead>
                      <TableHead>Observaciones</TableHead>
                      <TableHead>Fecha</TableHead>
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    {seguimientos.map((seguimiento) => (
                      <TableRow key={seguimiento.id}>
                        <TableCell className="font-medium">
                          {seguimiento.cliente.nombre}
                        </TableCell>
                        <TableCell>{seguimiento.user.name}</TableCell>
                        <TableCell className="text-right">
                          {seguimiento.cantidad}
                        </TableCell>
                        <TableCell className="text-right">
                          {seguimiento.internas}
                        </TableCell>
                        <TableCell className="text-right">
                          {seguimiento.externas}
                        </TableCell>
                        <TableCell className="max-w-xs truncate">
                          {seguimiento.observaciones || '-'}
                        </TableCell>
                        <TableCell>
                          {new Date(seguimiento.created_at).toLocaleDateString(
                            'es-ES',
                          )}
                        </TableCell>
                      </TableRow>
                    ))}
                  </TableBody>
                </Table>
              </div>
            )}
          </CardContent>
        </Card>
      </div>
    </AppLayout>
  );
}
