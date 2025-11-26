import AppLayout from '@/layouts/app-layout';
import { type BreadcrumbItem } from '@/types';
import { Head } from '@inertiajs/react';

const breadcrumbs: BreadcrumbItem[] = [
  {
    title: 'Productos',
    href: '/productos',
  },
];

export default function Editar() {
  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Productos" />
    </AppLayout>
  );
}
