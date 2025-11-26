import AppLayout from '@/layouts/app-layout';
import { type BreadcrumbItem } from '@/types';
import { Head } from '@inertiajs/react';

const breadcrumbs: BreadcrumbItem[] = [
  {
    title: 'Cuentas por Pagar',
    href: '/cuentasporpagar',
  },
];

export default function Pagar() {
  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Cuentas por pagar" />
    </AppLayout>
  );
}
