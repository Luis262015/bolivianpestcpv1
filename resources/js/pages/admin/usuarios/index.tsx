import CustomPagination from '@/components/CustomPagination';
import InputError from '@/components/input-error';
import { Button } from '@/components/ui/button';
import { Checkbox } from '@/components/ui/checkbox';
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
import { Edit, Eye, EyeOff, Plus, RotateCcw, Trash2 } from 'lucide-react';
import { useState } from 'react';

// ----- INTERFACES

interface Role {
  id: number;
  name: string;
}

interface Empresa {
  id: number;
  nombre: string;
}

interface Item {
  id: number;
  name: string;
  email: string;
  roles: Role[];
  empresas: Empresa[];
}

interface ItemsPaginate {
  data: Item[];
  links: { url: string | null; label: string; active: boolean }[];
}

// ------ CONSTANTES

const titlePage = 'Usuarios';
const urlPage = '/usuarios';

const breadcrumbs: BreadcrumbItem[] = [{ title: titlePage, href: urlPage }];

// ------ PRINCIPAL

export default function Index() {
  const { users, roles, empresas } = usePage<{
    users: ItemsPaginate;
    roles: Role[];
    empresas: Empresa[];
  }>().props;

  const { errors } = usePage().props as { errors: Record<string, string> };

  const [editItem, setEditItem] = useState<Item | null>(null);
  const [itemName, setItemName] = useState('');
  const [itemEmail, setItemEmail] = useState('');
  const [itemPassword, setItemPassword] = useState('');
  const [itemConfPassword, setItemConfPassword] = useState('');
  const [itemRole, setItemRole] = useState(0);
  const [itemEmpresas, setItemEmpresas] = useState<number[]>([]);

  const [isOpen, setIsOpen] = useState(false);

  const [showPassword, setShowPassword] = useState(false);

  const toggleEmpresa = (id: number) => {
    setItemEmpresas((prev) =>
      prev.includes(id) ? prev.filter((e) => e !== id) : [...prev, id],
    );
  };

  const toggleAllEmpresas = () => {
    if (itemEmpresas.length === empresas.length) {
      setItemEmpresas([]);
    } else {
      setItemEmpresas(empresas.map((e) => e.id));
    }
  };

  const allChecked =
    empresas.length > 0 && itemEmpresas.length === empresas.length;
  const someChecked = itemEmpresas.length > 0 && !allChecked;

  const handleCreate = (e: React.FormEvent) => {
    e.preventDefault();
    if (!itemName) return;

    router.post(
      urlPage,
      {
        name: itemName,
        email: itemEmail,
        password: itemPassword,
        password_confirmation: itemConfPassword,
        role: itemRole,
        empresas: itemEmpresas,
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
    if (!editItem || !itemName) return;

    router.put(
      `${urlPage}/${editItem.id}`,
      {
        name: itemName,
        email: itemEmail,
        password: itemPassword,
        password_confirmation: itemConfPassword,
        role: itemRole,
        empresas: itemEmpresas,
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
    setItemEmail('');
    setItemPassword('');
    setItemConfPassword('');
    setItemEmpresas([]);
    setIsOpen(false);
  };

  const handleDelete = (id: number) => {
    if (confirm('¿Estás seguro?')) {
      router.delete(`${urlPage}/${id}`);
    }
  };

  const openEditModal = (item: Item) => {
    setEditItem(item);
    setItemName(item.name);
    setItemEmail(item.email);
    setItemRole(item.roles[0].id);
    setItemEmpresas(item.empresas.map((e) => e.id));
    setIsOpen(true);
  };

  const openCreateModal = () => {
    setEditItem(null);
    setItemName('');
    setItemEmail('');
    setItemPassword('');
    setItemConfPassword('');
    setItemEmpresas([]);
    setIsOpen(true);
  };

  const generatePassword = (length = 12) => {
    const chars =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()_+';
    let password = '';

    for (let i = 0; i < length; i++) {
      password += chars.charAt(Math.floor(Math.random() * chars.length));
    }

    setItemPassword(password);
    setItemConfPassword(password);
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
                <Plus className="mr-2 h-4 w-4" /> Nuevo Usuario
              </Button>
            </DialogTrigger>
            <DialogContent
              className="max-w-md"
              aria-describedby="uu"
              onInteractOutside={(e) => e.preventDefault()}
              onEscapeKeyDown={(e) => e.preventDefault()}
            >
              <DialogHeader>
                <DialogTitle>
                  {editItem ? 'Editar Usuario' : 'Nuevo Usuario'}
                </DialogTitle>
              </DialogHeader>
              <form
                onSubmit={editItem ? handleEdit : handleCreate}
                className="space-y-4"
              >
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
                <div>
                  <Label htmlFor="name">Email:</Label>
                  <Input
                    id="email"
                    value={itemEmail}
                    tabIndex={2}
                    onChange={(e) => setItemEmail(e.target.value)}
                    required
                  />
                  <InputError message={errors.email} />
                </div>

                {editItem == null ? (
                  <>
                    <div>
                      <Label htmlFor="password">Password</Label>
                      <div className="flex items-center justify-center gap-2">
                        <Input
                          id="password"
                          type={showPassword ? 'text' : 'password'}
                          value={itemPassword}
                          onChange={(e) => setItemPassword(e.target.value)}
                          required
                          tabIndex={3}
                          autoComplete="new-password"
                          name="password"
                          placeholder="Password"
                        />
                        <button
                          type="button"
                          onClick={() => setShowPassword(!showPassword)}
                          className=""
                        >
                          {showPassword ? <EyeOff /> : <Eye />}
                        </button>
                        <Button
                          type="button"
                          variant="outline"
                          onClick={() => generatePassword()}
                        >
                          <RotateCcw />
                        </Button>
                      </div>
                      <InputError message={errors.password} />
                    </div>
                    <div>
                      <Label htmlFor="password_confirmation">
                        Confirm password
                      </Label>
                      <Input
                        id="password_confirmation"
                        type={showPassword ? 'text' : 'password'}
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
                )}

                <div>
                  <Label>Selección de rol</Label>
                  <Select
                    onValueChange={(value) => setItemRole(Number(value))}
                    value={String(itemRole)}
                  >
                    <SelectTrigger>
                      <SelectValue></SelectValue>
                    </SelectTrigger>

                    <SelectContent>
                      <SelectGroup>
                        <SelectLabel>Roles</SelectLabel>
                        {roles.map((rol) => (
                          <SelectItem key={rol.id} value={String(rol.id)}>
                            {rol.name}
                          </SelectItem>
                        ))}
                      </SelectGroup>
                    </SelectContent>
                  </Select>
                </div>

                <div>
                  <Label>Selección de EMPRESA</Label>
                  <div className="mt-1 max-h-40 overflow-y-auto rounded-md border p-2">
                    <div className="mb-1 flex items-center gap-2 border-b pb-2">
                      <Checkbox
                        id="all-empresas"
                        checked={allChecked ? true : someChecked ? 'indeterminate' : false}
                        onCheckedChange={toggleAllEmpresas}
                      />
                      <Label
                        htmlFor="all-empresas"
                        className="cursor-pointer font-medium"
                      >
                        Todas las empresas
                      </Label>
                    </div>
                    <div className="space-y-2 pt-1">
                      {empresas.map((empresa) => (
                        <div key={empresa.id} className="flex items-center gap-2">
                          <Checkbox
                            id={`empresa-${empresa.id}`}
                            checked={itemEmpresas.includes(empresa.id)}
                            onCheckedChange={() => toggleEmpresa(empresa.id)}
                          />
                          <Label
                            htmlFor={`empresa-${empresa.id}`}
                            className="cursor-pointer"
                          >
                            {empresa.nombre}
                          </Label>
                        </div>
                      ))}
                    </div>
                  </div>
                  {itemEmpresas.length > 0 && (
                    <p className="mt-1 text-xs text-muted-foreground">
                      {allChecked
                        ? 'Todas las empresas seleccionadas'
                        : `${itemEmpresas.length} empresa${itemEmpresas.length !== 1 ? 's' : ''} seleccionada${itemEmpresas.length !== 1 ? 's' : ''}`}
                    </p>
                  )}
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

        {users.data.length > 0 ? (
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead className="w-12"></TableHead>
                <TableHead>Nombre</TableHead>
                <TableHead>Email</TableHead>
                <TableHead>Role</TableHead>
                <TableHead>Acciones</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {users.data.map((item) => (
                <>
                  <TableRow key={item.id}>
                    <TableCell className="font-medium">{item.id}</TableCell>
                    <TableCell className="font-medium">{item.name}</TableCell>
                    <TableCell className="font-medium">{item.email}</TableCell>
                    <TableCell className="font-medium">
                      {item.roles.length > 0
                        ? item.roles.map((r) => r.name).join(', ')
                        : '—'}
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
        ) : null}
        {users.links && users.links.length > 3 && (
          <div className="mt-4">
            <CustomPagination links={users.links} />
          </div>
        )}
        {users.data.length === 0 && (
          <p className="text-center text-muted-foreground">No hay registros.</p>
        )}
      </div>
    </AppLayout>
  );
}
