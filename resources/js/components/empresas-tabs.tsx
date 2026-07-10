import { SectionTabs, type SectionTab } from '@/components/section-tabs';
import { usePermissions } from '@/hooks/usePermissions';

/**
 * Pestañas de la sección Empresas. Sustituye al submenú del sidebar
 * (Lista / Contratos / Cotizaciones). Contratos y Cotizaciones son
 * exclusivas de admin/superadmin (ver `role:admin|superadmin` en las rutas),
 * así que solo se muestran a esos roles.
 */
export function EmpresasTabs() {
  const { hasAnyRole } = usePermissions();
  const isAdmin = hasAnyRole(['admin', 'superadmin']);

  const tabs: SectionTab[] = [
    { title: 'Lista', href: '/empresas' },
    ...(isAdmin
      ? [
          { title: 'Contratos', href: '/contratos' },
          { title: 'Cotizaciones', href: '/cotizaciones' },
        ]
      : []),
  ];

  return <SectionTabs tabs={tabs} className="mb-6" />;
}
