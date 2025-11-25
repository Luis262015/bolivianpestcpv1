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
    title: 'Crear',
    href: '/empresas/create',
  },
];

export default function Crear() {
  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Empresas" />
      <div className="p-6">
        <h1 className="mb-4 text-xl font-bold">Crear Empresa</h1>
        <FormEmpresa submitUrl="/empresas" method="post" />
      </div>
    </AppLayout>
  );
}
