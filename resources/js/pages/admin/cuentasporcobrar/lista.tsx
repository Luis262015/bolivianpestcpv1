import AppLayout from '@/layouts/app-layout';
import { type BreadcrumbItem } from '@/types';
import { Head } from '@inertiajs/react';

const breadcrumbs: BreadcrumbItem[] = [
  {
    title: 'Cuentas por cobrar',
    href: '/cuentasporcobrar',
  },
];

export default function Lista() {
  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Cuentas Por Cobrar" />
    </AppLayout>
  );
}
