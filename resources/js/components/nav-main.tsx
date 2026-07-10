import {
  SidebarGroup,
  SidebarGroupLabel,
  SidebarMenu,
  SidebarMenuButton,
  SidebarMenuItem,
  SidebarMenuSub,
  SidebarMenuSubButton,
  SidebarMenuSubItem,
} from '@/components/ui/sidebar';
import { resolveUrl } from '@/lib/utils';
import { type MainNavItem } from '@/types';
import { Link, usePage } from '@inertiajs/react';
import {
  Collapsible,
  CollapsibleContent,
  CollapsibleTrigger,
} from '@radix-ui/react-collapsible';
import { ChevronDown } from 'lucide-react';

export interface NavSectionGroup {
  label: string;
  items: MainNavItem[];
}

interface NavMainProps {
  sections: NavSectionGroup[];
}

/**
 * ¿La ruta actual corresponde a este href?
 * Coincide de forma exacta o cuando es una sub-ruta (`/empresas` ~ `/empresas/5`),
 * evitando falsos positivos entre prefijos parecidos (`/gastos` vs `/gastosfin`).
 */
function useIsActive() {
  const current = usePage().url.split('?')[0].replace(/\/$/, '');

  return (href?: MainNavItem['href']): boolean => {
    if (!href) return false;
    const target = resolveUrl(href).split('?')[0].replace(/\/$/, '');
    if (!target) return false;
    return current === target || current.startsWith(`${target}/`);
  };
}

function NavSection({ label, items }: { label: string; items: MainNavItem[] }) {
  const isActive = useIsActive();

  // Los ítems `hidden` no se dibujan en el sidebar (viven en pestañas), pero
  // siguen buscables desde la paleta ⌘K vía `flattenSections`.
  const visibleItems = items.filter((item) => !item.hidden);

  if (visibleItems.length === 0) return null;

  return (
    <nav aria-label={label}>
      <SidebarGroupLabel>{label}</SidebarGroupLabel>
      <SidebarMenu>
        {visibleItems.map((item) => {
          if (item.down) {
            const groupActive =
              item.subItems?.some((sub) => isActive(sub.href)) ?? false;

            return (
              <Collapsible
                key={item.title}
                asChild
                defaultOpen={groupActive}
                className="group/collapsible"
              >
                <SidebarMenuItem>
                  <CollapsibleTrigger asChild>
                    <SidebarMenuButton
                      tooltip={item.title}
                      isActive={groupActive}
                    >
                      {item.icon && <item.icon />}
                      <span>{item.title}</span>
                      <ChevronDown className="ml-auto transition-transform duration-200 group-data-[state=open]/collapsible:rotate-90" />
                    </SidebarMenuButton>
                  </CollapsibleTrigger>
                  <CollapsibleContent>
                    <SidebarMenuSub>
                      {item.subItems?.map((subItem) => {
                        const active = isActive(subItem.href);
                        return (
                          <SidebarMenuSubItem key={subItem.title}>
                            <SidebarMenuSubButton asChild isActive={active}>
                              <Link
                                href={subItem.href}
                                prefetch
                                aria-current={active ? 'page' : undefined}
                              >
                                <span>{subItem.title}</span>
                              </Link>
                            </SidebarMenuSubButton>
                          </SidebarMenuSubItem>
                        );
                      })}
                    </SidebarMenuSub>
                  </CollapsibleContent>
                </SidebarMenuItem>
              </Collapsible>
            );
          }

          const active = isActive(item.href);
          return (
            <SidebarMenuItem key={item.title}>
              <SidebarMenuButton
                asChild
                isActive={active}
                tooltip={{ children: item.title }}
              >
                <Link
                  href={item.href!}
                  prefetch
                  aria-current={active ? 'page' : undefined}
                >
                  {item.icon && <item.icon />}
                  <span>{item.title}</span>
                </Link>
              </SidebarMenuButton>
            </SidebarMenuItem>
          );
        })}
      </SidebarMenu>
    </nav>
  );
}

export function NavMain({ sections }: NavMainProps) {
  return (
    <SidebarGroup className="px-2 py-0">
      {sections.map((section) => (
        <NavSection
          key={section.label}
          label={section.label}
          items={section.items}
        />
      ))}
    </SidebarGroup>
  );
}
