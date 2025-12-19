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
import { Head, router, usePage } from '@inertiajs/react';
import { Edit, Plus, Trash2 } from 'lucide-react';
import { useState } from 'react';

// ----- INTERFACES

interface Item {
  id: number;
  nombre: string;
}

interface ItemsPaginate {
  data: Item[];
  links: { url: string | null; label: string; active: boolean }[];
}

// ------ CONSTANTES

const titlePage = 'Especies';
const urlPage = '/especies';

const breadcrumbs: BreadcrumbItem[] = [{ title: titlePage, href: urlPage }];

// ------ PRINCIPAL

export default function Index() {
  const { items } = usePage<{
    items: ItemsPaginate;
  }>().props;

  const [editItem, setEditItem] = useState<Item | null>(null);
  const [itemName, setItemName] = useState('');
  const [isOpen, setIsOpen] = useState(false);

  const handleCreate = (e: React.FormEvent) => {
    e.preventDefault();
    if (!itemName) return;

    router.post(
      urlPage,
      {
        nombre: itemName,
      },
      {
        onSuccess: () => {
          setItemName('');
          setIsOpen(false);
        },
      },
    );
  };

  const handleEdit = (e: React.FormEvent) => {
    e.preventDefault();
    if (!editItem || !itemName) return;

    router.put(
      `${urlPage}/${editItem.id}`,
      {
        nombre: itemName,
      },
      {
        onSuccess: () => {
          setEditItem(null);
          setItemName('');
          setIsOpen(false);
        },
      },
    );
  };

  const handleDelete = (id: number) => {
    if (confirm('¿Estás seguro?')) {
      router.delete(`${urlPage}/${id}`);
    }
  };

  const openEditModal = (item: Item) => {
    setEditItem(item);
    setItemName(item.nombre);
    setIsOpen(true);
  };

  const openCreateModal = () => {
    setEditItem(null);
    setItemName('');
    setIsOpen(true);
  };

  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title={titlePage} />

      <div className="m-4">
        <div className="mb-4 flex items-center justify-between">
          <h1 className="text-2xl font-bold">Gestión de {titlePage}</h1>
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
                  <Label htmlFor="name">Nombre: {titlePage}</Label>
                  <Input
                    id="nombre"
                    value={itemName}
                    onChange={(e) => setItemName(e.target.value)}
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

        {items.data.length > 0 ? (
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead className="w-12"></TableHead>
                <TableHead>Nombre</TableHead>
                <TableHead>Acciones</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {items.data.map((item) => (
                <>
                  <TableRow key={item.id}>
                    <TableCell className="font-medium">{item.id}</TableCell>
                    <TableCell className="font-medium">{item.nombre}</TableCell>
                    <TableCell className="flex gap-2">
                      <Button
                        size="icon"
                        variant="outline"
                        onClick={() => openEditModal(item)}
                      >
                        <Edit className="h-4 w-4" />
                      </Button>
                      <Button
                        size="icon"
                        variant="outline"
                        onClick={() => handleDelete(item.id)}
                      >
                        <Trash2 className="h-4 w-4" />
                      </Button>
                    </TableCell>
                  </TableRow>
                </>
              ))}
            </TableBody>
          </Table>
        ) : (
          <p className="text-center text-muted-foreground">No hay registros.</p>
        )}
      </div>
    </AppLayout>
  );
}
