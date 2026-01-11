import CustomPagination from '@/components/CustomPagination';
import { Button } from '@/components/ui/button';
import {
  Dialog,
  DialogContent,
  DialogFooter,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
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
import { Head, router, useForm, usePage } from '@inertiajs/react';
import { Edit, Plus, Trash2 } from 'lucide-react';
import { useState } from 'react';

const breadcrumbs: BreadcrumbItem[] = [
  {
    title: 'Ingresos',
    href: '/ingresos',
  },
];

const titlePage = 'Ingresos';
const urlPage = '/ingresos';

interface Ingreso {
  id: number;
  concepto: string;
  total: number;
}

interface IngresosPaginate {
  data: Ingreso[];
  links: { url: string | null; label: string; active: boolean }[];
}

export default function Index() {
  const { processing, delete: destroy } = useForm();
  const { ingresos } = usePage<{ ingresos: IngresosPaginate }>().props;

  const [editItem, setEditItem] = useState<Ingreso | null>(null);
  const [itemConcept, setItemConcept] = useState('');
  const [itemAmount, setItemAmount] = useState(0);
  const [isOpen, setIsOpen] = useState(false);
  const handleCreate = (e: React.FormEvent) => {
    e.preventDefault();
    if (!itemConcept) return;

    router.post(
      urlPage,
      {
        concepto: itemConcept,
        total: itemAmount,
      },
      {
        onSuccess: () => {
          setItemConcept('');
          setIsOpen(false);
        },
      },
    );
  };

  const handleEdit = (e: React.FormEvent) => {
    e.preventDefault();
    if (!editItem || !itemConcept) return;

    router.put(
      `${urlPage}/${editItem.id}`,
      {
        concepto: itemConcept,
        total: itemAmount,
      },
      {
        onSuccess: () => {
          setEditItem(null);
          setItemConcept('');
          setItemAmount(0);
          setIsOpen(false);
        },
      },
    );
  };

  const handleDelete = (id: number) => {
    if (confirm('Estas seguro de eliminar el registro')) {
      destroy(`/ingresos/${id}`);
    }
  };

  const openEditModal = (item: Ingreso) => {
    setEditItem(item);
    setItemConcept(item.concepto);
    setItemAmount(item.total);
    setIsOpen(true);
  };

  const openCreateModal = () => {
    setEditItem(null);
    setItemConcept('');
    setItemAmount(0);
    setIsOpen(true);
  };

  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Ingresos | List" />
      <div className="m-4">
        <div className="flex items-center">
          <div className="me-5 text-2xl font-bold">Gestión de ingresos</div>
          <Dialog open={isOpen} onOpenChange={setIsOpen}>
            <DialogTrigger asChild>
              <Button onClick={openCreateModal}>
                <Plus className="mr-2 h-4 w-4" /> Nuevo
              </Button>
            </DialogTrigger>
            <DialogContent className="max-w-md">
              <DialogHeader>
                <DialogTitle>{editItem ? 'Editar' : 'Crear'}</DialogTitle>
              </DialogHeader>
              <form
                onSubmit={editItem ? handleEdit : handleCreate}
                className="space-y-4"
              >
                <div>
                  <Label htmlFor="concept">Concepto:</Label>
                  <Input
                    id="concepto"
                    value={itemConcept}
                    onChange={(e) => setItemConcept(e.target.value)}
                    required
                  />
                </div>
                <div>
                  <Label htmlFor="amount">Monto:</Label>
                  <Input
                    id="monto"
                    type="number"
                    value={itemAmount}
                    onChange={(e) => setItemAmount(Number(e.target.value))}
                    required
                  />
                </div>

                <DialogFooter>
                  <Button type="submit" className="w-full">
                    {editItem ? 'Actualizar' : 'Crear'}
                  </Button>
                </DialogFooter>
              </form>
            </DialogContent>
          </Dialog>
        </div>

        {/* <Link href={'/ingresos/create'}>
          <Button className="mb-4" size="sm">
            Agrega Ingreso
          </Button>
        </Link> */}
        {/* <div className="mb-2 text-center text-2xl">Lista de ingresos</div> */}
        {ingresos.data.length > 0 && (
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead className="w-[100px]">ID</TableHead>
                <TableHead>Concepto</TableHead>
                <TableHead>Total</TableHead>
                <TableHead>Acción</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {ingresos.data.map((gasto) => (
                <TableRow key={gasto.id}>
                  <TableCell className="font-medium">{gasto.id}</TableCell>
                  <TableCell>{gasto.concepto}</TableCell>
                  <TableCell>{gasto.total}</TableCell>
                  <TableCell>
                    <Button
                      size="icon"
                      variant="outline"
                      onClick={() => openEditModal(gasto)}
                    >
                      <Edit className="h-4 w-4" />
                    </Button>
                    {/* <Link href={`/ingresos/${gasto.id}/edit`}>
                      <Button className="" size="icon" variant="outline">
                        <SquarePen />
                      </Button>
                    </Link> */}
                    <Button
                      disabled={processing}
                      className="ml-1"
                      size="icon"
                      variant="destructive"
                      onClick={() => handleDelete(gasto.id)}
                    >
                      <Trash2 />
                    </Button>
                  </TableCell>
                </TableRow>
              ))}
            </TableBody>
          </Table>
        )}

        <div className="my-2">
          <CustomPagination links={ingresos.links} />
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
//     title: 'Ingresos',
//     href: '/ingresos',
//   },
// ];

// export default function Lista() {
//   return (
//     <AppLayout breadcrumbs={breadcrumbs}>
//       <Head title="Ingresos" />
//     </AppLayout>
//   );
// }
