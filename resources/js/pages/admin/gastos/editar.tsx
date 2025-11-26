import AppLayout from '@/layouts/app-layout';
import { type BreadcrumbItem } from '@/types';
import { Head } from '@inertiajs/react';

const breadcrumbs: BreadcrumbItem[] = [
  {
    title: 'Gastos',
    href: '/gastos',
  },
];

export default function Editar() {
  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Gastos" />
    </AppLayout>
  );
}
