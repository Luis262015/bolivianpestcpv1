import { cn, resolveUrl } from '@/lib/utils';
import { Link, usePage } from '@inertiajs/react';

export interface SectionTab {
  title: string;
  href: string;
}

/**
 * Barra de pestañas de sección (navegación secundaria). Reemplaza a los
 * submenús del sidebar: cada pestaña es un destino Inertia y la activa se
 * deriva de la URL actual, de modo que cambiar de sección es un solo click
 * y las hermanas quedan siempre a la vista.
 */
export function SectionTabs({
  tabs,
  className,
}: {
  tabs: SectionTab[];
  className?: string;
}) {
  const current = usePage().url.split('?')[0].replace(/\/$/, '');

  const isActive = (href: string): boolean => {
    const target = resolveUrl(href).split('?')[0].replace(/\/$/, '');
    if (!target) return false;
    return current === target || current.startsWith(`${target}/`);
  };

  // Con una sola pestaña no aporta nada: no la renderizamos.
  if (tabs.length <= 1) return null;

  return (
    <nav aria-label="Secciones" className={cn('border-b', className)}>
      <ul className="-mb-px flex gap-1 overflow-x-auto">
        {tabs.map((tab) => {
          const active = isActive(tab.href);
          return (
            <li key={tab.href}>
              <Link
                href={tab.href}
                prefetch
                aria-current={active ? 'page' : undefined}
                className={cn(
                  'inline-flex h-10 items-center whitespace-nowrap border-b-2 px-4 text-sm font-medium transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring',
                  active
                    ? 'border-primary text-foreground'
                    : 'border-transparent text-muted-foreground hover:border-muted-foreground/40 hover:text-foreground',
                )}
              >
                {tab.title}
              </Link>
            </li>
          );
        })}
      </ul>
    </nav>
  );
}
