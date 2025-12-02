import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import AppLayout from '@/layouts/app-layout';
import { type BreadcrumbItem } from '@/types';
import { Head, useForm } from '@inertiajs/react';

const breadcrumbs: BreadcrumbItem[] = [
  {
    title: 'Retiros',
    href: 'retiros',
  },
  {
    title: 'Hacer Retiro',
    href: 'retiros/create',
  },
];

const TiposEnum = ['Retiro', 'Retiro dueño'];

export default function Create() {
  const { data, setData, post, processing, errors } = useForm({
    concepto: '',
    monto: '',
    tipo: '',
  });
  const handleSumit = (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    post('/retiros');
  };

  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Retiros | Create" />

      <div className="w-8/12 p-4">
        <form onSubmit={handleSumit} method="post" className="space-y-4">
          <div className="gap-1.5">
            <Input
              placeholder="Monto ej. (10.90 decimal o 10 entero)"
              value={data.monto}
              onChange={(e) => setData('monto', e.target.value)}
            ></Input>
            {errors.monto && (
              <div className="mt-1 flex items-center text-sm text-red-500">
                {errors.monto}
              </div>
            )}
          </div>
          <div className="gap-1.5">
            <Input
              placeholder="Concepto"
              value={data.concepto}
              onChange={(e) => setData('concepto', e.target.value)}
            ></Input>
            {errors.concepto && (
              <div className="mt-1 flex items-center text-sm text-red-500">
                {errors.concepto}
              </div>
            )}
          </div>

          <div className="gap-1.5">
            <select
              id="tipo_select"
              // 1. Usa tu componente Shadcn/Tailwind si tienes uno para Select
              className="flex h-10 w-full rounded-md border border-input bg-background px-3 py-2 text-sm ring-offset-background file:border-0 file:bg-transparent file:text-sm file:font-medium placeholder:text-muted-foreground focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 focus-visible:outline-none disabled:cursor-not-allowed disabled:opacity-50"
              value={data.tipo} // Asumiendo que ahora quieres el campo 'tipo'
              onChange={(e) => setData('tipo', e.target.value)}
            >
              <option value="" disabled>
                Selecciona una opción
              </option>
              {TiposEnum.map((tipo) => (
                <option key={tipo} value={tipo}>
                  {tipo}
                </option>
              ))}
            </select>

            {errors.tipo && ( // Muestra el error si existe para el campo 'tipo'
              <div className="mt-1 flex items-center text-sm text-red-500">
                {errors.tipo}
              </div>
            )}
          </div>

          <Button disabled={processing} type="submit">
            Guardar Retiro
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
//     title: 'Retiros',
//     href: '/retiros',
//   },
// ];

// export default function Crear() {
//   return (
//     <AppLayout breadcrumbs={breadcrumbs}>
//       <Head title="Retiros" />
//     </AppLayout>
//   );
// }
