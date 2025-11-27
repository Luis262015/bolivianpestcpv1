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
      <div className="mx-3 space-y-6">
        <HeadingSmall
          title="Appearance settings"
          description="Update your account's appearance settings"
        />
        <AppearanceTabs />
      </div>
    </AppLayout>
  );
}
