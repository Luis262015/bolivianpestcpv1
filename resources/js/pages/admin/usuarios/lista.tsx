import AppLayout from '@/layouts/app-layout';
import { type BreadcrumbItem } from '@/types';
import { Head } from '@inertiajs/react';

const breadcrumbs: BreadcrumbItem[] = [
  {
    title: 'Usuarios',
    href: '/usuarios',
  },
];

export default function Lista() {
  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Usuarios" />
      <h1>Lista de Usuarios</h1>
    </AppLayout>
  );
}
