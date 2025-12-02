import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Textarea } from '@/components/ui/textarea';
import AppLayout from '@/layouts/app-layout';
import { type BreadcrumbItem } from '@/types';
import { Head, useForm } from '@inertiajs/react';

const breadcrumbs: BreadcrumbItem[] = [
  {
    title: 'Gastos',
    href: '/gastos',
  },
];

interface Gasto {
  id: number;
  concepto: string;
  detalle: string;
  total: number;
}

export default function Edit({ gasto }: { gasto: Gasto }) {
  const { data, setData, put, processing, errors } = useForm({
    concepto: gasto.concepto,
    detalle: gasto.detalle,
    total: gasto.total,
  });

  const handleSumit = (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    put(`/gastos/${gasto.id}`);
  };

  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Gastos | Edit" />
      <div className="w-8/12 p-4">
        <form onSubmit={handleSumit} method="post" className="space-y-4">
          <div className="gap-1.5">
            <Input
              placeholder="Total ej. (10.90 decimal o 10 entero)"
              value={data.total}
              onChange={(e) => setData('total', Number(e.target.value))}
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

// export default function Editar() {
//   return (
//     <AppLayout breadcrumbs={breadcrumbs}>
//       <Head title="Gastos" />
//     </AppLayout>
//   );
// }
