import { SectionTabs, type SectionTab } from '@/components/section-tabs';

/**
 * Pestañas de la sección Gastos. Sustituye al submenú del sidebar
 * (Financieros / Operativos / Extras / Caja Chica). Las cuatro viven solo en
 * la navegación de admin (Contabilidad) y comparten nivel de acceso, así que
 * se muestran siempre juntas.
 */
export function GastosTabs() {
  const tabs: SectionTab[] = [
    { title: 'Financieros', href: '/gastosfin' },
    { title: 'Operativos', href: '/gastosop' },
    { title: 'Extras', href: '/gastosex' },
    { title: 'Caja Chica', href: '/gastos' },
  ];

  return <SectionTabs tabs={tabs} className="mb-6" />;
}
