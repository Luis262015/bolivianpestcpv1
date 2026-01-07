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
import { ChevronDown, ChevronUp, SquarePen, Trash2 } from 'lucide-react';
import { useState } from 'react';

const breadcrumbs: BreadcrumbItem[] = [
  {
    title: 'Compras',
    href: '/Compras',
  },
];

interface Cliente {
  id: number;
  nombre: string;
}

interface VentaDetalle {
  id: number;
  producto: {
    id: number;
    nombre: string;
  };
  precio_venta: number;
  cantidad: number;
  total: number;
}

interface Venta {
  id: number;
  cliente: Cliente;
  total: number;
  tipo: string;
  metodo: string;
  detalles: VentaDetalle[]; // <-- Añadido
}

interface VentasPaginate {
  data: Venta[];
  links: { url: string | null; label: string; active: boolean }[];
}

export default function Index() {
  const { processing, delete: destroy } = useForm();
  const { ventas } = usePage<{ ventas: VentasPaginate }>().props;

  // Estado para controlar qué fila está expandida
  const [expandedRow, setExpandedRow] = useState<number | null>(null);

  const toggleRow = (id: number) => {
    setExpandedRow(expandedRow === id ? null : id);
  };

  const handleDelete = (id: number) => {
    if (confirm('Estas seguro de eliminar el registro')) {
      destroy(`/compras/${id}`);
    }
  };

  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Compras | List" />

      <div className="m-4">
        <div className="flex">
          <div className="me-5 mb-2 text-2xl font-bold">Gestión de ventas</div>

          <Link href={'/ventas/create'}>
            <Button className="mb-4" size="sm">
              Hacer Venta
            </Button>
          </Link>
        </div>

        {ventas.data.length > 0 ? (
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead className="w-12"></TableHead>
                <TableHead className="w-[100px]">ID</TableHead>
                <TableHead>Cliente</TableHead>
                <TableHead>Total</TableHead>
                <TableHead>Tipo</TableHead>
                <TableHead>Metodo</TableHead>
                <TableHead>Acción</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {ventas.data.map((venta) => (
                <>
                  {/* Fila principal */}
                  <TableRow key={venta.id}>
                    <TableCell>
                      <Button
                        size="icon"
                        variant="ghost"
                        onClick={() => toggleRow(venta.id)}
                      >
                        {expandedRow === venta.id ? (
                          <ChevronUp className="h-4 w-4" />
                        ) : (
                          <ChevronDown className="h-4 w-4" />
                        )}
                      </Button>
                    </TableCell>
                    <TableCell className="font-medium">{venta.id}</TableCell>
                    <TableCell>{venta.cliente?.nombre ?? '---'}</TableCell>
                    <TableCell>{venta.total}</TableCell>
                    <TableCell>{venta.tipo}</TableCell>
                    <TableCell>{venta.metodo}</TableCell>
                    <TableCell className="flex gap-1">
                      <Link href={`/ventas/edit/${venta.id}`}>
                        <Button size="icon" variant="outline">
                          <SquarePen className="h-4 w-4" />
                        </Button>
                      </Link>
                      <Button
                        disabled={processing}
                        size="icon"
                        variant="outline"
                        onClick={() => handleDelete(venta.id)}
                      >
                        <Trash2 className="h-4 w-4" />
                      </Button>
                    </TableCell>
                  </TableRow>

                  {/* Subtabla desplegable */}
                  {expandedRow === venta.id && (
                    <TableRow>
                      <TableCell colSpan={9} className="p-0">
                        <div className="border-t bg-muted/30">
                          <div className="p-4">
                            <h4 className="mb-3 text-sm font-semibold">
                              Detalles de la compra
                            </h4>
                            {venta.detalles.length > 0 ? (
                              <Table>
                                <TableHeader>
                                  <TableRow>
                                    <TableHead>Producto</TableHead>
                                    <TableHead>Cantidad</TableHead>
                                    <TableHead>Precio Venta</TableHead>
                                    <TableHead>Total</TableHead>
                                  </TableRow>
                                </TableHeader>
                                <TableBody>
                                  {venta.detalles.map((detalle) => (
                                    <TableRow key={detalle.id}>
                                      <TableCell>
                                        {detalle.producto.nombre}
                                      </TableCell>
                                      <TableCell>{detalle.cantidad}</TableCell>
                                      <TableCell>
                                        {detalle.precio_venta}
                                      </TableCell>
                                      <TableCell>{detalle.total}</TableCell>
                                    </TableRow>
                                  ))}
                                </TableBody>
                              </Table>
                            ) : (
                              <p className="text-sm text-muted-foreground">
                                No hay detalles para esta compra.
                              </p>
                            )}
                          </div>
                        </div>
                      </TableCell>
                    </TableRow>
                  )}
                </>
              ))}
            </TableBody>
          </Table>
        ) : (
          <p className="text-center text-muted-foreground">
            No hay compras registradas.
          </p>
        )}

        <div className="my-2">
          <CustomPagination links={ventas.links} />
        </div>
      </div>
    </AppLayout>
  );
}
