import AppLayout from '@/layouts/app-layout';
import { type BreadcrumbItem } from '@/types';
import { Head } from '@inertiajs/react';

const breadcrumbs: BreadcrumbItem[] = [
  {
    title: 'Compras',
    href: '/compras',
  },
];

export default function Crear() {
  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Compras" />
    </AppLayout>
  );
}
