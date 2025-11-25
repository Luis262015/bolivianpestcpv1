// resources/js/Pages/Empresa/FormEmpresa.tsx
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Switch } from '@/components/ui/switch';
import { useForm } from '@inertiajs/react';

type Empresa = {
  id?: number;
  nombre?: string;
  direccion?: string;
  telefono?: string;
  email?: string;
  ciudad?: string;
  activo?: boolean;
};

export default function FormEmpresa({
  empresa,
  submitUrl,
  method,
}: {
  empresa?: Empresa;
  submitUrl: string;
  method: 'post' | 'put';
}) {
  const { data, setData, processing, errors, post, put } = useForm<Empresa>({
    nombre: empresa?.nombre ?? '',
    direccion: empresa?.direccion ?? '',
    telefono: empresa?.telefono ?? '',
    email: empresa?.email ?? '',
    ciudad: empresa?.ciudad ?? '',
    activo: empresa?.activo ?? true,
  });

  const submit = (e: React.FormEvent) => {
    e.preventDefault();
    method === 'post' ? post(submitUrl) : put(submitUrl);
  };

  return (
    <form onSubmit={submit} className="max-w-xl space-y-5">
      <div>
        <Label>Nombre</Label>
        <Input
          value={data.nombre}
          onChange={(e) => setData('nombre', e.target.value)}
        />
        {errors.nombre && (
          <p className="text-sm text-red-500">{errors.nombre}</p>
        )}
      </div>

      <div>
        <Label>Dirección</Label>
        <Input
          value={data.direccion}
          onChange={(e) => setData('direccion', e.target.value)}
        />
        {errors.direccion && (
          <p className="text-sm text-red-500">{errors.direccion}</p>
        )}
      </div>

      <div>
        <Label>Teléfono</Label>
        <Input
          value={data.telefono}
          onChange={(e) => setData('telefono', e.target.value)}
        />
        {errors.telefono && (
          <p className="text-sm text-red-500">{errors.telefono}</p>
        )}
      </div>

      <div>
        <Label>Email</Label>
        <Input
          type="email"
          value={data.email}
          onChange={(e) => setData('email', e.target.value)}
        />
        {errors.email && <p className="text-sm text-red-500">{errors.email}</p>}
      </div>

      <div>
        <Label>Ciudad</Label>
        <Input
          value={data.ciudad}
          onChange={(e) => setData('ciudad', e.target.value)}
        />
        {errors.ciudad && (
          <p className="text-sm text-red-500">{errors.ciudad}</p>
        )}
      </div>

      <div className="flex items-center gap-3">
        <Switch
          checked={data.activo}
          onCheckedChange={(val) => setData('activo', val)}
        />
        <Label>Activo</Label>
      </div>

      <Button disabled={processing} type="submit" className="w-full">
        {method === 'post' ? 'Crear Empresa' : 'Actualizar Empresa'}
      </Button>
    </form>
  );
}
