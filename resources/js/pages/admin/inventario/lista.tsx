import CustomPagination from '@/components/CustomPagination';
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

const breadcrumbs: BreadcrumbItem[] = [
  {
    title: 'Inventarios',
    href: '/inventarios',
  },
];

interface Producto {
  id: number;
  nombre: string;
}

interface Kardex {
  id: number;
  venta_id: number;
  compra_id: number;
  producto_id: number;
  producto: Producto;
  tipo: string;
  cantidad: number;
  cantidad_saldo: number;
  costo_unitario: number;
}

interface KardexPaginate {
  data: Kardex[];
  links: { url: string | null; label: string; active: boolean }[];
}

export default function Lista() {
  const { processing, delete: destroy } = useForm();
  const { lista } = usePage<{ lista: KardexPaginate }>().props;

  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Inventarios" />
      <div className="m-4">
        <div className="flex">
          <div className="me-5 mb-2 text-2xl font-bold">Gestión de Kardex</div>

          {/* <Link href={'/compras/create'}>
            <Button className="mb-4" size="sm">
              Hacer Compra
            </Button>
          </Link> */}
        </div>

        {lista.data.length > 0 ? (
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead className="w-[100px]">ID</TableHead>
                <TableHead>Producto</TableHead>
                <TableHead>Costo/Precio</TableHead>
                <TableHead>Cantidad</TableHead>
                <TableHead>Total</TableHead>
                <TableHead>Tipo</TableHead>
                <TableHead>Cantidad Saldo</TableHead>
                {/* <TableHead>Acción</TableHead> */}
              </TableRow>
            </TableHeader>
            <TableBody>
              {lista.data.map((kardex) => (
                <>
                  {/* Fila principal */}
                  <TableRow key={kardex.id}>
                    <TableCell className="font-medium">{kardex.id}</TableCell>
                    <TableCell>{kardex.producto?.nombre ?? '---'}</TableCell>
                    <TableCell>{kardex.costo_unitario}</TableCell>
                    <TableCell>{kardex.cantidad}</TableCell>
                    <TableCell>
                      {kardex.costo_unitario * kardex.cantidad}
                    </TableCell>
                    <TableCell>{kardex.tipo}</TableCell>
                    <TableCell>{kardex.cantidad_saldo}</TableCell>

                    {/* <TableCell>{kardex.abonado}</TableCell>
                    <TableCell>{kardex.saldo}</TableCell> */}
                    {/* <TableCell className="flex gap-1">
                      <Link href={`/kardexs/edit/${kardex.id}`}>
                        <Button size="icon" variant="outline">
                          <SquarePen className="h-4 w-4" />
                        </Button>
                      </Link>
                      <Button
                        disabled={processing}
                        size="icon"
                        variant="outline"
                        onClick={() => handleDelete(kardex.id)}
                      >
                        <Trash2 className="h-4 w-4" />
                      </Button>
                    </TableCell> */}
                  </TableRow>
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
          <CustomPagination links={lista.links} />
        </div>
      </div>
    </AppLayout>
  );
}
