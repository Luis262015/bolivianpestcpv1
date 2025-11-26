import AppLayout from '@/layouts/app-layout';
import { type BreadcrumbItem } from '@/types';
import { Head } from '@inertiajs/react';

const breadcrumbs: BreadcrumbItem[] = [
  {
    title: 'Categorias',
    href: '/categorias',
  },
];

export default function Crear() {
  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Categorias" />
    </AppLayout>
  );
}
