import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import AppLayout from '@/layouts/app-layout';
import { type BreadcrumbItem } from '@/types';
import { Head, useForm } from '@inertiajs/react';

const breadcrumbs: BreadcrumbItem[] = [
  {
    title: 'Tipos',
    href: '/tipos',
  },
  {
    title: 'Crear',
    href: '/tipos/create',
  },
];

export default function Create() {
  const { data, setData, post, processing, errors } = useForm({
    nombre: '',
    descripcion: '',
  });

  const handleSumit = (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    post('/tipos');
  };

  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Tipos | Create" />

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
          <div className="gap-1.5">
            <Input
              placeholder="Descripcion"
              value={data.descripcion}
              onChange={(e) => setData('descripcion', e.target.value)}
            ></Input>
            {errors.descripcion && (
              <div className="mt-1 flex items-center text-sm text-red-500">
                {errors.descripcion}
              </div>
            )}
          </div>

          <Button disabled={processing} type="submit">
            Guardar Tipo Seguimiento
          </Button>
        </form>
      </div>
    </AppLayout>
  );
}

// import AppLayout from '@/layouts/app-layout';
// import { type BreadcrumbItem } from '@/types';
// import { Head } from '@inertiajs/react';

// const breadcrumbs: BreadcrumbItem[] = [
//   {
//     title: 'Etiquetas',
//     href: '/etiquetas',
//   },
// ];

// export default function Crear() {
//   return (
//     <AppLayout breadcrumbs={breadcrumbs}>
//       <Head title="Etiquetas" />
//     </AppLayout>
//   );
// }
