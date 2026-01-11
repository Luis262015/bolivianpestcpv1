import CustomPagination from '@/components/CustomPagination';
import InputError from '@/components/input-error';
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
  Select,
  SelectContent,
  SelectGroup,
  SelectItem,
  SelectLabel,
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
import { Head, router, useForm, usePage } from '@inertiajs/react';
import { format } from 'date-fns';
import { Edit, Plus, Trash2 } from 'lucide-react';
import { useState } from 'react';

const titlePage = 'Gastos Operativos';
const urlPage = '/gastosop';

const breadcrumbs: BreadcrumbItem[] = [
  { title: 'Gastos Financieros', href: '/gastosop' },
];

interface Cuenta {
  id: number;
  nombre: string;
}

interface GastoOp {
  id: number;
  cuenta_id: number;
  concepto: string;
  total: number;
  created_at?: string;
}

interface GastosPaginate {
  data: GastoOp[];
  links: { url: string | null; label: string; active: boolean }[];
}

export default function GastosFin() {
  const { processing, delete: destroy } = useForm();
  const { errors } = usePage().props as { errors: Record<string, string> };
  const { gastos, cuentas } = usePage<{
    gastos: GastosPaginate;
    cuentas: Cuenta[];
  }>().props;

  const [editItem, setEditItem] = useState<GastoOp | null>(null);

  const [itemConcept, setItemConcept] = useState('');
  const [itemCuenta, setItemCuenta] = useState(0);
  const [itemTotal, setItemTotal] = useState(0);

  const [isOpen, setIsOpen] = useState(false);

  const handleCreate = (e: React.FormEvent) => {
    e.preventDefault();
    console.log('handleCreate');
    if (!itemConcept) return;

    router.post(
      urlPage,
      {
        cuenta_id: itemCuenta,
        concepto: itemConcept,
        total: itemTotal,
      },
      {
        onSuccess: () => {
          cleanDataForm();
        },
      },
    );
  };

  const handleEdit = (e: React.FormEvent) => {
    e.preventDefault();
    console.log('handleEdit');
    if (!editItem || !itemConcept) return;

    router.put(
      `${urlPage}/${editItem.id}`,
      {
        cuenta_id: itemCuenta,
        concepto: itemConcept,
        total: itemTotal,
      },
      {
        onSuccess: () => {
          cleanDataForm();
        },
      },
    );
  };

  const cleanDataForm = () => {
    setEditItem(null);
    setItemConcept('');
    setItemCuenta(0);
    setItemTotal(0);
    setIsOpen(false);
  };

  const handleDelete = (id: number) => {
    if (confirm('¿Estás seguro?')) {
      router.delete(`${urlPage}/${id}`);
    }
  };

  const openEditModal = (item: GastoOp) => {
    setEditItem(item);
    setItemConcept(item.concepto);
    setItemCuenta(item.cuenta_id);
    setItemTotal(item.total);
    setIsOpen(true);
  };

  const openCreateModal = () => {
    setEditItem(null);
    setItemConcept('');
    setItemCuenta(0);
    setItemTotal(0);
    setIsOpen(true);
  };

  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Gastos Financieros" />

      <div className="m-4">
        {/* Botones principales */}
        <div className="mb-4 flex flex-col items-start gap-3 sm:flex-row sm:items-center">
          <h1 className="me-5 text-2xl font-bold">
            Gestión de Gastos Operativos
          </h1>
          <Dialog open={isOpen} onOpenChange={setIsOpen}>
            <DialogTrigger asChild>
              <Button onClick={openCreateModal}>
                <Plus className="mr-2 h-4 w-4" /> Nuevo
              </Button>
            </DialogTrigger>
            <DialogContent className="max-w-md" aria-describedby="uu">
              <DialogHeader>
                <DialogTitle>
                  {editItem ? 'Editar Gasto' : 'Nuevo Gasto'}
                </DialogTitle>
              </DialogHeader>
              <form
                onSubmit={editItem ? handleEdit : handleCreate}
                className="space-y-4"
              >
                <div>
                  <Label htmlFor="name">Concepto:</Label>
                  <Input
                    id="concepto"
                    value={itemConcept}
                    tabIndex={1}
                    onChange={(e) => setItemConcept(e.target.value)}
                    required
                  />
                  <InputError message={errors.concepto} />
                </div>
                <div>
                  <Label htmlFor="name">Total:</Label>
                  <Input
                    id="total"
                    type="number"
                    value={itemTotal}
                    tabIndex={1}
                    onChange={(e) => setItemTotal(Number(e.target.value))}
                    required
                  />
                  <InputError message={errors.name} />
                </div>

                <div>
                  <Label>Selección de cuenta</Label>
                  <Select
                    onValueChange={(value) => setItemCuenta(Number(value))}
                    value={String(itemCuenta)}
                    // disabled={processing}
                  >
                    <SelectTrigger>
                      <SelectValue></SelectValue>
                    </SelectTrigger>

                    <SelectContent>
                      <SelectGroup>
                        <SelectLabel>Roles</SelectLabel>
                        {cuentas.map((cuenta) => (
                          <SelectItem key={cuenta.id} value={String(cuenta.id)}>
                            {cuenta.nombre}
                          </SelectItem>
                        ))}
                      </SelectGroup>
                    </SelectContent>
                  </Select>
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

        {/* Tabla */}
        {gastos.data.length > 0 ? (
          <div className="overflow-x-auto">
            <Table>
              <TableHeader>
                <TableRow>
                  <TableHead className="w-[80px]">ID</TableHead>
                  <TableHead>Concepto</TableHead>
                  <TableHead className="text-right">Total</TableHead>
                  <TableHead className="text-center">Fecha</TableHead>
                  <TableHead className="text-center">Acción</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {gastos.data.map((gasto) => (
                  <TableRow key={gasto.id}>
                    <TableCell className="font-medium">{gasto.id}</TableCell>
                    <TableCell>{gasto.concepto}</TableCell>
                    <TableCell className="text-right">
                      Bs. {gasto.total.toLocaleString('es-BO')}
                    </TableCell>
                    <TableCell className="text-center font-mono text-xs text-muted-foreground sm:text-sm">
                      {(() => {
                        const dateStr = gasto.created_at;
                        if (!dateStr) return '-';

                        const date = new Date(dateStr);
                        if (isNaN(date.getTime())) return '-';

                        return format(date, 'dd/MM/yyyy HH:mm:ss');
                      })()}
                    </TableCell>
                    <TableCell className="flex justify-center gap-1">
                      <Button
                        size="icon"
                        variant="outline"
                        onClick={() => openEditModal(gasto)}
                      >
                        <Edit className="h-4 w-4" />
                      </Button>
                      {/* <Link href={`/gastos/${gasto.id}/edit`}>
                        <Button size="icon" variant="outline">
                          <SquarePen className="h-4 w-4" />
                        </Button>
                      </Link> */}
                      <Button
                        disabled={processing}
                        size="icon"
                        variant="destructive"
                        onClick={() => handleDelete(gasto.id)}
                      >
                        <Trash2 className="h-4 w-4" />
                      </Button>
                    </TableCell>
                  </TableRow>
                ))}
              </TableBody>
            </Table>
          </div>
        ) : (
          <div className="text-center text-muted-foreground">
            No hay registros.
          </div>
        )}

        {/* Paginación */}
        <div className="my-4">
          <CustomPagination links={gastos.links} />
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
//     title: 'Gastos',
//     href: '/gastos',
//   },
// ];

// export default function Lista() {
//   return (
//     <AppLayout breadcrumbs={breadcrumbs}>
//       <Head title="Gastos" />
//     </AppLayout>
//   );
// }
