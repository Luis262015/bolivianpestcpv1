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
import { Head, router, usePage } from '@inertiajs/react';
import { Edit, Plus, Trash2 } from 'lucide-react';
import { useState } from 'react';

// ----- INTERFACES

interface Categoria {
  id: number;
  nombre: string;
}

interface Item {
  id: number;
  nombre: string;
  categoria_id: number;
  categoria: Categoria;
}

interface ItemsPaginate {
  data: Item[];
  links: { url: string | null; label: string; active: boolean }[];
}

// ------ CONSTANTES

const titlePage = 'Subcategorias';
const urlPage = '/subcategorias';

const breadcrumbs: BreadcrumbItem[] = [{ title: titlePage, href: urlPage }];

// ------ PRINCIPAL

export default function Index() {
  const { subcategorias, categorias } = usePage<{
    subcategorias: ItemsPaginate;
    categorias: Categoria[];
  }>().props;

  const { errors } = usePage().props as { errors: Record<string, string> };

  const [editItem, setEditItem] = useState<Item | null>(null);
  const [itemName, setItemName] = useState('');
  const [itemRole, setItemRole] = useState(0);

  const [isOpen, setIsOpen] = useState(false);

  const handleCreate = (e: React.FormEvent) => {
    e.preventDefault();
    console.log('handleCreate');
    if (!itemName) return;

    router.post(
      urlPage,
      {
        nombre: itemName,
        categoria_id: itemRole,
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
    if (!editItem || !itemName) return;

    router.put(
      `${urlPage}/${editItem.id}`,
      {
        nombre: itemName,
        categoria_id: itemRole,
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
    setItemName('');
    setIsOpen(false);
  };

  const handleDelete = (id: number) => {
    if (confirm('¿Estás seguro?')) {
      router.delete(`${urlPage}/${id}`);
    }
  };

  const openEditModal = (item: Item) => {
    setEditItem(item);
    setItemName(item.nombre);
    setItemRole(item.categoria_id);
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
        <div className="mb-4 flex items-center">
          <h1 className="me-5 text-2xl font-bold">Gestión de {titlePage}</h1>

          <Dialog open={isOpen} onOpenChange={setIsOpen}>
            <DialogTrigger asChild>
              <Button onClick={openCreateModal}>
                <Plus className="mr-2 h-4 w-4" /> Nueva Subcategoria
              </Button>
            </DialogTrigger>
            <DialogContent className="max-w-md" aria-describedby="uu">
              <DialogHeader>
                <DialogTitle>
                  {editItem ? 'Editar Usuario' : 'Nuevo Usuario'}
                </DialogTitle>
              </DialogHeader>
              <form
                onSubmit={editItem ? handleEdit : handleCreate}
                className="space-y-4"
              >
                {/* {({ processing, errors }) => (
                  <> */}
                <div>
                  <Label htmlFor="name">Nombre:</Label>
                  <Input
                    id="nombre"
                    value={itemName}
                    tabIndex={1}
                    onChange={(e) => setItemName(e.target.value)}
                    required
                  />
                  <InputError message={errors.name} />
                </div>
                {/* <div>
                  <Label htmlFor="name">Email:</Label>
                  <Input
                    id="email"
                    value={itemEmail}
                    tabIndex={2}
                    onChange={(e) => setItemEmail(e.target.value)}
                    required
                  />
                  <InputError message={errors.email} />
                </div> */}

                {/* {editItem == null ? (
                  <>
                    <div>
                      <Label htmlFor="password">Password</Label>
                      <Input
                        id="password"
                        type="password"
                        value={itemPassword}
                        onChange={(e) => setItemPassword(e.target.value)}
                        required
                        tabIndex={3}
                        autoComplete="new-password"
                        name="password"
                        placeholder="Password"
                      />
                      <InputError message={errors.password} />
                    </div>
                    <div>
                      <Label htmlFor="password_confirmation">
                        Confirm password
                      </Label>
                      <Input
                        id="password_confirmation"
                        type="password"
                        value={itemConfPassword}
                        onChange={(e) => setItemConfPassword(e.target.value)}
                        tabIndex={4}
                        autoComplete="new-password"
                        name="password_confirmation"
                        placeholder="Confirm password"
                        required
                      />
                      <InputError message={errors.password_confirmation} />
                    </div>
                  </>
                ) : (
                  ''
                )} */}

                <div>
                  <Label>Selección de rol</Label>
                  <Select
                    onValueChange={(value) => setItemRole(Number(value))}
                    value={String(itemRole)}
                    // disabled={processing}
                  >
                    <SelectTrigger>
                      <SelectValue></SelectValue>
                    </SelectTrigger>

                    <SelectContent>
                      <SelectGroup>
                        <SelectLabel>Roles</SelectLabel>
                        {categorias.map((rol) => (
                          <SelectItem key={rol.id} value={String(rol.id)}>
                            {rol.nombre}
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
                {/* </>
                )} */}
              </form>
            </DialogContent>
          </Dialog>
        </div>

        {subcategorias.data.length > 0 ? (
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead className="w-12"></TableHead>
                <TableHead>Nombre</TableHead>
                <TableHead>Categoria</TableHead>
                <TableHead>Acciones</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {subcategorias.data.map((item) => (
                <>
                  <TableRow key={item.id}>
                    <TableCell className="font-medium">{item.id}</TableCell>
                    <TableCell className="font-medium">{item.nombre}</TableCell>
                    <TableCell className="font-medium">
                      {item.categoria.nombre}
                      {/* {item.categorias.length > 0
                        ? item.categorias.map((r) => r.nombre).join(', ')
                        : '—'} */}
                    </TableCell>
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
