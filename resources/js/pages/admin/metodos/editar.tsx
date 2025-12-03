import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import AppLayout from '@/layouts/app-layout';
import { type BreadcrumbItem } from '@/types';
import { Head, useForm } from '@inertiajs/react';

const breadcrumbs: BreadcrumbItem[] = [
  {
    title: 'Metodos',
    href: '/metodos',
  },
  {
    title: 'Editar',
    href: '/metodos/edit',
  },
];

interface Metodo {
  id: number;
  nombre: string;
}

export default function Edit({ metodo }: { metodo: Metodo }) {
  const { data, setData, put, processing, errors } = useForm({
    nombre: metodo.nombre,
  });

  const handleSumit = (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    put(`/metodos/${metodo.id}`);
  };

  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Metodo | Edit" />

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
            Actualizar Metodo
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

// export default function Editar() {
//   return (
//     <AppLayout breadcrumbs={breadcrumbs}>
//       <Head title="Etiquetas" />
//     </AppLayout>
//   );
// }
