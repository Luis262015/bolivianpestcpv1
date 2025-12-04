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

interface Tienda {
  id: number;
  nombre: string;
}

interface Proveedor {
  id: number;
  nombre: string;
}

interface CompraDetalle {
  id: number;
  producto: {
    id: number;
    nombre: string;
  };
  cantidad: number;
  precio_compra: number;
  precio_venta: number;
}

interface Compra {
  id: number;
  tienda: Tienda;
  proveedor: Proveedor;
  total: number;
  abonado: number;
  saldo: number;
  tipo: string;
  detalles: CompraDetalle[]; // <-- Añadido
}

interface ComprasPaginate {
  data: Compra[];
  links: { url: string | null; label: string; active: boolean }[];
}

export default function Index() {
  const { processing, delete: destroy } = useForm();
  const { compras } = usePage<{ compras: ComprasPaginate }>().props;

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
        <Link href={'/compras/create'}>
          <Button className="mb-4" size="sm">
            Hacer Compra
          </Button>
        </Link>

        <div className="mb-2 text-center text-2xl">Lista de compras</div>

        {compras.data.length > 0 ? (
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead className="w-12"></TableHead>
                <TableHead className="w-[100px]">ID</TableHead>
                {/* <TableHead>Tienda</TableHead> */}
                <TableHead>Proveedor</TableHead>
                <TableHead>Total</TableHead>
                <TableHead>Abonado</TableHead>
                <TableHead>Saldo</TableHead>
                <TableHead>Tipo</TableHead>
                <TableHead>Acción</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {compras.data.map((compra) => (
                <>
                  {/* Fila principal */}
                  <TableRow key={compra.id}>
                    <TableCell>
                      <Button
                        size="icon"
                        variant="ghost"
                        onClick={() => toggleRow(compra.id)}
                      >
                        {expandedRow === compra.id ? (
                          <ChevronUp className="h-4 w-4" />
                        ) : (
                          <ChevronDown className="h-4 w-4" />
                        )}
                      </Button>
                    </TableCell>
                    <TableCell className="font-medium">{compra.id}</TableCell>
                    {/* <TableCell>{compra.nombre}</TableCell> */}
                    <TableCell>{compra.proveedor.nombre}</TableCell>
                    <TableCell>{compra.total}</TableCell>
                    <TableCell>{compra.abonado}</TableCell>
                    <TableCell>{compra.saldo}</TableCell>
                    <TableCell>{compra.tipo}</TableCell>
                    <TableCell className="flex gap-1">
                      <Link href={`/compras/edit/${compra.id}`}>
                        <Button size="icon" variant="outline">
                          <SquarePen className="h-4 w-4" />
                        </Button>
                      </Link>
                      <Button
                        disabled={processing}
                        size="icon"
                        variant="outline"
                        onClick={() => handleDelete(compra.id)}
                      >
                        <Trash2 className="h-4 w-4" />
                      </Button>
                    </TableCell>
                  </TableRow>

                  {/* Subtabla desplegable */}
                  {expandedRow === compra.id && (
                    <TableRow>
                      <TableCell colSpan={9} className="p-0">
                        <div className="border-t bg-muted/30">
                          <div className="p-4">
                            <h4 className="mb-3 text-sm font-semibold">
                              Detalles de la compra
                            </h4>
                            {compra.detalles.length > 0 ? (
                              <Table>
                                <TableHeader>
                                  <TableRow>
                                    <TableHead>Producto</TableHead>
                                    <TableHead>Cantidad</TableHead>
                                    <TableHead>Precio Compra</TableHead>
                                    <TableHead>Precio Venta</TableHead>
                                  </TableRow>
                                </TableHeader>
                                <TableBody>
                                  {compra.detalles.map((detalle) => (
                                    <TableRow key={detalle.id}>
                                      <TableCell>
                                        {detalle.producto.nombre}
                                      </TableCell>
                                      <TableCell>{detalle.cantidad}</TableCell>
                                      <TableCell>
                                        {detalle.precio_compra}
                                      </TableCell>
                                      <TableCell>
                                        {detalle.precio_venta}
                                      </TableCell>
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
          <CustomPagination links={compras.links} />
        </div>
      </div>
    </AppLayout>
  );
}

// import AppLayout from '@/layouts/app-layout';
// import { type BreadcrumbItem } from '@/types';
// import { Head } from '@inertiajs/react';

// const breadcrumbs: BreadcrumbItem[] = [
//   {
//     title: 'Compras',
//     href: '/compras',
//   },
// ];

// export default function Lista() {
//   return (
//     <AppLayout breadcrumbs={breadcrumbs}>
//       <Head title="Compras" />
//     </AppLayout>
//   );
// }
