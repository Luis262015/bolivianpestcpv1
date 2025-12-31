import AppearanceTabs from '@/components/appearance-tabs';
import HeadingSmall from '@/components/heading-small';
import AppLayout from '@/layouts/app-layout';
import { type BreadcrumbItem } from '@/types';
import { Head } from '@inertiajs/react';

const breadcrumbs: BreadcrumbItem[] = [
  {
    title: 'Configuraciones',
    href: '/configs',
  },
];

export default function Index() {
  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Configuraciones" />
      <div className="m-5 space-y-6">
        <HeadingSmall
          title="Configuración de apariencia"
          description="Actualice la configuración de apariencia de su cuenta"
        />
        <AppearanceTabs />
      </div>
    </AppLayout>
  );
}
