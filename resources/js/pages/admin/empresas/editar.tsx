import AppLayout from '@/layouts/app-layout';
import { type BreadcrumbItem } from '@/types';
import { Head } from '@inertiajs/react';
import FormEmpresa from './FormEmpresa';

const breadcrumbs: BreadcrumbItem[] = [
  {
    title: 'Empresas',
    href: '/empresas',
  },
  {
    title: 'Editar',
    href: '/empresas',
  },
];

export default function Edit({ empresa }: { empresa: any }) {
  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Editar" />
      <div className="p-6">
        <h1 className="mb-4 text-xl font-bold">Editar Empresa</h1>
        <FormEmpresa
          empresa={empresa}
          submitUrl={`/empresas/${empresa.id}`}
          method="put"
        />
      </div>
    </AppLayout>
  );
}
