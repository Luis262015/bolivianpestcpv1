import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Textarea } from '@/components/ui/textarea';
import AppLayout from '@/layouts/app-layout';
import { type BreadcrumbItem } from '@/types';
import { Head, useForm } from '@inertiajs/react';

const breadcrumbs: BreadcrumbItem[] = [
  {
    title: 'Gastos',
    href: 'gastos',
  },
  {
    title: 'Hacer Gasto',
    href: 'gastos/create',
  },
];

export default function Dashboard() {
  const { data, setData, post, processing, errors } = useForm({
    concepto: '',
    detalle: '',
    total: '',
  });
  const handleSumit = (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    post('/gastos');
  };

  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Gastos | Create" />
      <div className="w-8/12 p-4">
        <form onSubmit={handleSumit} method="post" className="space-y-4">
          <div className="gap-1.5">
            <Input
              type="number"
              step={'0.01'}
              placeholder="Total ej. (10.90 decimal o 10 entero)"
              value={data.total}
              onChange={(e) => setData('total', e.target.value)}
            ></Input>
            {errors.total && (
              <div className="mt-1 flex items-center text-sm text-red-500">
                {errors.total}
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
            <Textarea
              placeholder="Detalles"
              value={data.detalle}
              onChange={(e) => setData('detalle', e.target.value)}
            ></Textarea>
            {errors.detalle && (
              <div className="mt-1 flex items-center text-sm text-red-500">
                {errors.detalle}
              </div>
            )}
          </div>

          <Button disabled={processing} type="submit">
            Guardar Gasto
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
//     title: 'Gastos',
//     href: '/gastos',
//   },
// ];

// export default function Crear() {
//   return (
//     <AppLayout breadcrumbs={breadcrumbs}>
//       <Head title="Gastos" />
//     </AppLayout>
//   );
// }
