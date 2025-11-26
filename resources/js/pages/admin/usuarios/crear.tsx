import AppLayout from '@/layouts/app-layout';
import { type BreadcrumbItem } from '@/types';
import { Head } from '@inertiajs/react';

const breadcrumbs: BreadcrumbItem[] = [
  {
    title: 'Usuarios',
    href: '/usuarios',
  },
];

export default function Crear() {
  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Usuarios" />
    </AppLayout>
  );
}
