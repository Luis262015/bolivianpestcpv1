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
import { Head, Link } from '@inertiajs/react';

const breadcrumbs: BreadcrumbItem[] = [
  {
    title: 'Contratos',
    href: '/contratos',
  },
];

interface Cotizacion {
  id: number;
  nombre: string;
  // ... otros campos
  detalles: { id: number; descripcion: string /* ... */ }[];
}

interface Props {
  contratos: Cotizacion[];
}

export default function Lista({ contratos }: Props) {
  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="contratos" />

      <div className="p-6">
        <Link href="/contratos/create">
          <Button>Crear Nueva</Button>
        </Link>
        <Table>
          <TableHeader>
            <TableRow>
              <TableHead>Nombre</TableHead>
              <TableHead>Acciones</TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {contratos.map((cot) => (
              <TableRow key={cot.id}>
                <TableCell>{cot.nombre}</TableCell>
                <TableCell>
                  <Link href={`/contratos/${cot.id}/edit`}>
                    <Button variant="outline">Editar</Button>
                  </Link>
                  {/* Agrega botón de eliminar si lo necesitas */}
                </TableCell>
              </TableRow>
            ))}
          </TableBody>
        </Table>
      </div>
    </AppLayout>
  );
}

// import AppLayout from '@/layouts/app-layout';
// import { type BreadcrumbItem } from '@/types';
// import { Head } from '@inertiajs/react';

// const breadcrumbs: BreadcrumbItem[] = [
//   {
//     title: 'Contratos',
//     href: '/contratos',
//   },
// ];

// export default function Lista() {
//   return (
//     <AppLayout breadcrumbs={breadcrumbs}>
//       <Head title="Contratos" />
//     </AppLayout>
//   );
// }
