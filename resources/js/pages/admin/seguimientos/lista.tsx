import AppLayout from '@/layouts/app-layout';
import { type BreadcrumbItem } from '@/types';
import { Head } from '@inertiajs/react';

const breadcrumbs: BreadcrumbItem[] = [
  {
    title: 'Seguimientos',
    href: '/seguimientos',
  },
];

export default function Lista() {
  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Seguimientos" />
    </AppLayout>
  );
}
