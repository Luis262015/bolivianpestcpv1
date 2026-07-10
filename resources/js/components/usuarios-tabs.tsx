import { SectionTabs, type SectionTab } from '@/components/section-tabs';

/**
 * Pestañas de la sección Usuarios. Sustituye al submenú del sidebar
 * (Usuarios / Roles). Ambas viven solo en la navegación de admin y comparten
 * nivel de acceso, así que se muestran siempre juntas.
 */
export function UsuariosTabs() {
  const tabs: SectionTab[] = [
    { title: 'Usuarios', href: '/usuarios' },
    { title: 'Roles', href: '/roles' },
  ];

  return <SectionTabs tabs={tabs} className="mb-6" />;
}
