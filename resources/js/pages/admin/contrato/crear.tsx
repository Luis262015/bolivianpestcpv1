import AppLayout from '@/layouts/app-layout';
import { type BreadcrumbItem } from '@/types';
import { Head } from '@inertiajs/react';

const breadcrumbs: BreadcrumbItem[] = [
  {
    title: 'Contratos',
    href: '/contratos',
  },
];

export default function Crear() {
  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Contratos" />
    </AppLayout>
  );
}
