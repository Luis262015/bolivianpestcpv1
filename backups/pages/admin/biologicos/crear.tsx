import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import AppLayout from '@/layouts/app-layout';
import { type BreadcrumbItem } from '@/types';
import { Head, useForm } from '@inertiajs/react';

const breadcrumbs: BreadcrumbItem[] = [
  {
    title: 'Biologicos',
    href: '/biologicos',
  },
  {
    title: 'Crear',
    href: '/biologicos/create',
  },
];

export default function Create() {
  const { data, setData, post, processing, errors } = useForm({
    nombre: '',
  });

  const handleSumit = (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    post('/biologicos');
  };

  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Etiquetas | Create" />

      <div className="w-8/12 p-4">
        <form onSubmit={handleSumit} method="post" className="space-y-4">
          {/* NOMBRE */}
          <div className="gap-1.5">
            <Input
              placeholder="Nombre"
              value={data.nombre}
              onChange={(e) => setData('nombre', e.target.value)}
            ></Input>
            {errors.nombre && (
              <div className="mt-1 flex items-center text-sm text-red-500">
                {errors.nombre}
              </div>
            )}
          </div>

          <Button disabled={processing} type="submit">
            Guardar Ciclo Biologico
          </Button>
        </form>
      </div>
    </AppLayout>
  );
}
