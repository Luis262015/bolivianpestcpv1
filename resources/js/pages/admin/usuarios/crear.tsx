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
import { Head, useForm, usePage } from '@inertiajs/react';

const breadcrumbs: BreadcrumbItem[] = [
  {
    title: 'Usuarios',
    href: '/usuarios',
  },
  {
    title: 'Usuarios',
    href: '/usuarios/create',
  },
];

interface Role {
  id: number;
  name: string;
}

export default function Create() {
  const { roles } = usePage<{ roles: Role[] }>().props;

  const { data, setData, post, processing, errors } = useForm({
    name: '',
    email: '',
    password: '',
    password_confirmation: '',
    role: '',
    enable: false,
  });

  const handleSumit = (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    const dataToSend = {
      ...data,
      orden: data.role === '' ? null : Number(data.role),
      enable: data.enable ? 1 : 0, // o true/false según tu backend
    } as unknown as Record<string, any>;
    post('/usuarios', dataToSend);
  };

  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Usuarios | Create" />

      <div className="w-8/12 p-4">
        <form onSubmit={handleSumit} method="post" className="space-y-4">
          <div className="gap-1.5">
            <Input
              placeholder="Nombre"
              value={data.name}
              onChange={(e) => setData('name', e.target.value)}
            ></Input>
            {errors.name && (
              <div className="mt-1 flex items-center text-sm text-red-500">
                {errors.name}
              </div>
            )}
          </div>
          <div className="gap-1.5">
            <Input
              type="email"
              placeholder="Email"
              value={data.email}
              onChange={(e) => setData('email', e.target.value)}
            ></Input>
            {errors.email && (
              <div className="mt-1 flex items-center text-sm text-red-500">
                {errors.email}
              </div>
            )}
          </div>

          <div className="grid gap-2">
            <Input
              id="password"
              type="password"
              required
              tabIndex={3}
              autoComplete="new-password"
              name="password"
              placeholder="Password"
              onChange={(e) => setData('password', e.target.value)}
            />
            <InputError message={errors.password} />
          </div>

          <div className="grid gap-2">
            <Input
              id="password_confirmation"
              type="password"
              required
              tabIndex={4}
              autoComplete="new-password"
              name="password_confirmation"
              placeholder="Confirm password"
              onChange={(e) => setData('password_confirmation', e.target.value)}
            />
            <InputError message={errors.password_confirmation} />
          </div>

          <div className="gap-1.5">
            <Select
              onValueChange={(value) => setData('role', value)}
              value={data.role}
              disabled={processing}
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

          <Button disabled={processing} type="submit">
            Guardar Usuario
          </Button>
        </form>
      </div>
    </AppLayout>
  );
}
