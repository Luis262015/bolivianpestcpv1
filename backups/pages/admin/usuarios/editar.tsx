import InputError from '@/components/input-error';
import { Button } from '@/components/ui/button';
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
import { Switch } from '@/components/ui/switch';
import AppLayout from '@/layouts/app-layout';
import { type BreadcrumbItem } from '@/types';
import { Head, router, useForm, usePage } from '@inertiajs/react';

const breadcrumbs: BreadcrumbItem[] = [
  { title: 'Usuarios', href: '/usuarios' },
  { title: 'Editar Usuario', href: '#' },
];

interface Role {
  id: number;
  name: string;
}

interface User {
  id: number;
  name: string;
  email: string;
  role: Role | null;
  enable: boolean;
}

export default function Edit() {
  const { user, roles } = usePage<{ user: User; roles: Role[] }>().props;

  const { data, setData, put, processing, errors } = useForm({
    name: user.name,
    email: user.email,
    password: '',
    password_confirmation: '',
    role: user.role?.id.toString() || '',
    enable: user.enable,
  });

  const handleSubmit = (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();

    const dataToSend: Record<string, any> = {
      name: data.name,
      email: data.email,
      role: data.role === '' ? null : Number(data.role),
      enable: data.enable,
    };

    // Solo enviar contraseña si se ingresó
    if (data.password) {
      dataToSend.password = data.password;
      dataToSend.password_confirmation = data.password_confirmation;
    }

    router.put(`/usuarios/${user.id}`, dataToSend, {
      onSuccess: () => {
        // Opcional: mostrar mensaje o redirigir
      },
      onError: (errors) => {
        console.error('Errores:', errors);
      },
    });
  };

  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Usuarios | Editar" />

      <div className="w-8/12 p-4">
        <form onSubmit={handleSubmit} method="put" className="space-y-4">
          {/* Nombre */}
          <div className="gap-1.5">
            <Input
              placeholder="Nombre"
              value={data.name}
              onChange={(e) => setData('name', e.target.value)}
            />
            {errors.name && (
              <div className="mt-1 flex items-center text-sm text-red-500">
                {errors.name}
              </div>
            )}
          </div>

          {/* Email */}
          <div className="gap-1.5">
            <Input
              type="email"
              placeholder="Email"
              value={data.email}
              onChange={(e) => setData('email', e.target.value)}
            />
            {errors.email && (
              <div className="mt-1 flex items-center text-sm text-red-500">
                {errors.email}
              </div>
            )}
          </div>

          {/* Contraseña (opcional) */}
          <div className="grid gap-2">
            <Input
              id="password"
              type="password"
              placeholder="Nueva contraseña (dejar vacío para no cambiar)"
              autoComplete="new-password"
              onChange={(e) => setData('password', e.target.value)}
            />
            <InputError message={errors.password} />
          </div>

          {/* Confirmar contraseña */}
          <div className="grid gap-2">
            <Input
              id="password_confirmation"
              type="password"
              placeholder="Confirmar nueva contraseña"
              autoComplete="new-password"
              onChange={(e) => setData('password_confirmation', e.target.value)}
            />
            <InputError message={errors.password_confirmation} />
          </div>

          {/* Rol */}
          <div className="gap-1.5">
            <Select
              onValueChange={(value) => setData('role', value)}
              value={data.role}
              disabled={processing}
            >
              <SelectTrigger>
                <SelectValue placeholder="Seleccionar rol" />
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
            {errors.role && (
              <div className="mt-1 flex items-center text-sm text-red-500">
                {errors.role}
              </div>
            )}
          </div>
          <div className="flex items-center space-x-2">
            <Switch
              id="enable"
              checked={data.enable}
              onCheckedChange={(checked) => setData('enable', checked)}
              disabled={processing}
            />
            <Label htmlFor="enable">Habilitar usuario</Label>
          </div>

          {errors.enable && (
            <div className="mt-1 flex items-center text-sm text-red-500">
              {errors.enable}
            </div>
          )}

          {/* Botón */}
          <Button disabled={processing} type="submit">
            {processing ? 'Guardando...' : 'Actualizar Usuario'}
          </Button>
        </form>
      </div>
    </AppLayout>
  );
}
