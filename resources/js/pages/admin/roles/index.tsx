import { Badge } from '@/components/ui/badge';
import { Button } from '@/components/ui/button';
import {
  Dialog,
  DialogContent,
  DialogDescription,
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
  SelectItem,
  SelectTrigger,
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
import { ChevronDown, ChevronUp, Edit, Plus, Trash2 } from 'lucide-react';
import { useState } from 'react';

interface Permission {
  id: number;
  name: string;
}

interface Role {
  id: number;
  name: string;
  permissions: Permission[];
}

interface RolesPaginate {
  data: Role[];
  links: { url: string | null; label: string; active: boolean }[];
}

const breadcrumbs: BreadcrumbItem[] = [
  { title: 'Roles y Permisos', href: '/roles' },
];

export default function RolesIndex() {
  const { roles, permissions } = usePage<{
    roles: RolesPaginate;
    permissions: Permission[];
  }>().props;
  const [expandedRows, setExpandedRows] = useState<Set<number>>(new Set());
  const [editRole, setEditRole] = useState<Role | null>(null);
  const [roleName, setRoleName] = useState('');
  const [selectedPermissions, setSelectedPermissions] = useState<number[]>([]);
  const [isOpen, setIsOpen] = useState(false);

  const toggleRow = (roleId: number) => {
    const newExpanded = new Set(expandedRows);
    if (newExpanded.has(roleId)) {
      newExpanded.delete(roleId);
    } else {
      newExpanded.add(roleId);
    }
    setExpandedRows(newExpanded);
  };

  const handleCreate = (e: React.FormEvent) => {
    e.preventDefault();
    if (!roleName) return;

    router.post(
      '/roles',
      {
        name: roleName,
        permissions: selectedPermissions,
      },
      {
        onSuccess: () => {
          setRoleName('');
          setSelectedPermissions([]);
          setIsOpen(false);
        },
      },
    );
  };

  const handleEdit = (e: React.FormEvent) => {
    e.preventDefault();
    if (!editRole || !roleName) return;

    router.put(
      `/roles/${editRole.id}`,
      {
        name: roleName,
        permissions: selectedPermissions,
      },
      {
        onSuccess: () => {
          setEditRole(null);
          setRoleName('');
          setSelectedPermissions([]);
          setIsOpen(false);
        },
      },
    );
  };

  const handleDelete = (id: number) => {
    if (confirm('¿Estás seguro?')) {
      router.delete(`/roles/${id}`);
    }
  };

  const openEditModal = (role: Role) => {
    setEditRole(role);
    setRoleName(role.name);
    setSelectedPermissions(role.permissions.map((p) => p.id));
    setIsOpen(true);
  };

  const openCreateModal = () => {
    setEditRole(null);
    setRoleName('');
    setSelectedPermissions([]);
    setIsOpen(true);
  };

  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Roles y Permisos" />

      <div className="m-4">
        <div className="mb-4 flex items-center">
          <h1 className="me-5 text-2xl font-bold">
            Gestión de Roles y Permisos
          </h1>
          <Dialog open={isOpen} onOpenChange={setIsOpen}>
            <DialogTrigger asChild>
              <Button onClick={openCreateModal}>
                <Plus className="mr-2 h-4 w-4" /> Nuevo Rol
              </Button>
            </DialogTrigger>
            <DialogContent className="max-w-md">
              <DialogHeader>
                <DialogTitle>
                  {editRole ? 'Editar Rol' : 'Crear Rol'}
                </DialogTitle>
                <DialogDescription>
                  Asigna nombre y permisos al rol.
                </DialogDescription>
              </DialogHeader>
              <form
                onSubmit={editRole ? handleEdit : handleCreate}
                className="space-y-4"
              >
                <div>
                  <Label htmlFor="name">Nombre del Rol</Label>
                  <Input
                    id="name"
                    value={roleName}
                    onChange={(e) => setRoleName(e.target.value)}
                    required
                  />
                </div>
                <div>
                  <Label>Permisos</Label>
                  <Select
                    onValueChange={(value) => {
                      const id = parseInt(value);
                      setSelectedPermissions((prev) =>
                        prev.includes(id)
                          ? prev.filter((p) => p !== id)
                          : [...prev, id],
                      );
                    }}
                  >
                    <SelectTrigger>Selecciona permisos</SelectTrigger>
                    <SelectContent>
                      {permissions.map((perm) => (
                        <SelectItem key={perm.id} value={perm.id.toString()}>
                          {perm.name}
                          {selectedPermissions.includes(perm.id) && ' ✓'}
                        </SelectItem>
                      ))}
                    </SelectContent>
                  </Select>
                  {/* Lista de seleccionados */}
                  <div className="mt-2 space-y-1">
                    {selectedPermissions.map((id) => {
                      const perm = permissions.find((p) => p.id === id);
                      return perm ? (
                        <Badge key={id} variant="secondary">
                          {perm.name}
                        </Badge>
                      ) : null;
                    })}
                  </div>
                </div>
                <DialogFooter>
                  <Button type="submit" className="w-full">
                    {editRole ? 'Actualizar' : 'Crear'}
                  </Button>
                </DialogFooter>
              </form>
            </DialogContent>
          </Dialog>
        </div>

        {roles.data.length > 0 ? (
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead className="w-12"></TableHead>
                <TableHead>Nombre</TableHead>
                <TableHead>Permisos Asignados</TableHead>
                <TableHead>Acciones</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {roles.data.map((role) => (
                <>
                  <TableRow key={role.id}>
                    <TableCell>
                      <Button
                        variant="ghost"
                        size="icon"
                        onClick={() => toggleRow(role.id)}
                      >
                        {expandedRows.has(role.id) ? (
                          <ChevronUp className="h-4 w-4" />
                        ) : (
                          <ChevronDown className="h-4 w-4" />
                        )}
                      </Button>
                    </TableCell>
                    <TableCell className="font-medium">{role.name}</TableCell>
                    <TableCell>
                      <div className="flex flex-wrap gap-1">
                        {role.permissions.slice(0, 3).map((perm) => (
                          <Badge key={perm.id} variant="outline">
                            {perm.name}
                          </Badge>
                        ))}
                        {role.permissions.length > 3 && (
                          <Badge variant="secondary">
                            +{role.permissions.length - 3}
                          </Badge>
                        )}
                      </div>
                    </TableCell>
                    <TableCell className="flex gap-2">
                      <Button
                        size="icon"
                        variant="outline"
                        onClick={() => openEditModal(role)}
                      >
                        <Edit className="h-4 w-4" />
                      </Button>
                      <Button
                        size="icon"
                        variant="outline"
                        onClick={() => handleDelete(role.id)}
                      >
                        <Trash2 className="h-4 w-4" />
                      </Button>
                    </TableCell>
                  </TableRow>
                  {expandedRows.has(role.id) && (
                    <TableRow>
                      <TableCell colSpan={4} className="p-0">
                        <div className="border-t p-4">
                          <h4 className="mb-2 font-semibold">
                            Todos los Permisos:
                          </h4>
                          <div className="flex flex-wrap gap-1">
                            {role.permissions.map((perm) => (
                              <Badge key={perm.id} variant="secondary">
                                {perm.name}
                              </Badge>
                            ))}
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
            No hay roles creados.
          </p>
        )}
      </div>
    </AppLayout>
  );
}
