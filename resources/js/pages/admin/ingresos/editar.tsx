import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import AppLayout from '@/layouts/app-layout';
import { type BreadcrumbItem } from '@/types';
import { Head, useForm } from '@inertiajs/react';

const breadcrumbs: BreadcrumbItem[] = [
  {
    title: 'Ingresos',
    href: '/ingresos',
  },
];

interface Ingreso {
  id: number;
  concepto: string;
  monto: number;
}

export default function Edit({ ingreso }: { ingreso: Ingreso }) {
  const { data, setData, put, processing, errors } = useForm({
    concepto: ingreso.concepto,
    monto: ingreso.monto,
  });

  const handleSumit = (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    put(`/ingresos/${ingreso.id}`);
  };

  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Ingresos | Edit" />

      <div className="w-8/12 p-4">
        <form onSubmit={handleSumit} method="post" className="space-y-4">
          <div className="gap-1.5">
            <Input
              placeholder="Monto ej. (10.90 decimal o 10 entero)"
              value={data.monto}
              onChange={(e) => setData('monto', Number(e.target.value))}
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

          <Button disabled={processing} type="submit">
            Guardar Ingreso
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
//     title: 'Ingresos',
//     href: '/ingresos',
//   },
// ];

// export default function Editar() {
//   return (
//     <AppLayout breadcrumbs={breadcrumbs}>
//       <Head title="Ingresos" />
//     </AppLayout>
//   );
// }
