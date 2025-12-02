import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import AppLayout from '@/layouts/app-layout';
import { type BreadcrumbItem } from '@/types';
import { Head, useForm } from '@inertiajs/react';

const breadcrumbs: BreadcrumbItem[] = [
  {
    title: 'Categorias',
    href: 'categorias/create',
  },
];

export default function Create() {
  const { data, setData, post, processing, errors } = useForm({
    nombre: '',
    imagen: '',
    orden: '',
  });

  const handleSumit = (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    post('/categorias');
  };

  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Categorias | Create" />

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
          {/* IMAGEN */}
          {/* <div className="gap-1.5">
            <Input
              placeholder="Apeliidos"
              value={data.apellidos}
              onChange={(e) => setData('apellidos', e.target.value)}
            ></Input>
            {errors.apellidos && (
              <div className="mt-1 flex items-center text-sm text-red-500">
                {errors.apellidos}
              </div>
            )}
          </div> */}
          {/* CELULAR */}
          <div className="gap-1.5">
            <Input
              type="number"
              placeholder="Orden"
              value={data.orden}
              onChange={(e) => setData('orden', e.target.value)}
            ></Input>
            {errors.orden && (
              <div className="mt-1 flex items-center text-sm text-red-500">
                {errors.orden}
              </div>
            )}
          </div>
          <Button disabled={processing} type="submit">
            Guardar Categoria
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
//     title: 'Categorias',
//     href: '/categorias',
//   },
// ];

// export default function Crear() {
//   return (
//     <AppLayout breadcrumbs={breadcrumbs}>
//       <Head title="Categorias" />
//     </AppLayout>
//   );
// }
