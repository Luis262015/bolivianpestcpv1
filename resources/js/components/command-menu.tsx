import { Button } from '@/components/ui/button';
import {
  CommandDialog,
  CommandEmpty,
  CommandGroup,
  CommandInput,
  CommandItem,
  CommandList,
} from '@/components/ui/command';
import {
  adminSections,
  clienteSections,
  flattenSections,
  type FlatNavItem,
} from '@/config/navigation';
import { usePermissions } from '@/hooks/usePermissions';
import { router } from '@inertiajs/react';
import { Search } from 'lucide-react';
import { useEffect, useMemo, useState } from 'react';

interface FlatNavGroup {
  label: string;
  items: FlatNavItem[];
}

function groupByLabel(items: FlatNavItem[]): FlatNavGroup[] {
  const groups: FlatNavGroup[] = [];
  for (const item of items) {
    let group = groups.find((g) => g.label === item.group);
    if (!group) {
      group = { label: item.group, items: [] };
      groups.push(group);
    }
    group.items.push(item);
  }
  return groups;
}

export function CommandMenu() {
  const [open, setOpen] = useState(false);
  const [isMac, setIsMac] = useState(false);
  const { hasRole } = usePermissions();

  const isAdmin = hasRole('admin') || hasRole('superadmin');
  const sections = isAdmin ? adminSections : clienteSections;
  const groups = useMemo(
    () => groupByLabel(flattenSections(sections)),
    [sections],
  );

  useEffect(() => {
    setIsMac(/Mac|iPhone|iPad/i.test(navigator.userAgent));

    const onKeyDown = (e: KeyboardEvent) => {
      if (e.key.toLowerCase() === 'k' && (e.metaKey || e.ctrlKey)) {
        e.preventDefault();
        setOpen((prev) => !prev);
      }
    };
    document.addEventListener('keydown', onKeyDown);
    return () => document.removeEventListener('keydown', onKeyDown);
  }, []);

  const go = (href: string) => {
    setOpen(false);
    router.visit(href);
  };

  return (
    <>
      <Button
        variant="outline"
        size="sm"
        onClick={() => setOpen(true)}
        aria-label="Buscar y navegar"
        className="text-muted-foreground h-9 w-full max-w-56 justify-start gap-2 font-normal"
      >
        <Search className="h-4 w-4" />
        <span>Buscar…</span>
        <kbd className="bg-muted text-muted-foreground pointer-events-none ml-auto hidden h-5 items-center gap-1 rounded border px-1.5 font-mono text-[10px] font-medium select-none sm:inline-flex">
          {isMac ? '⌘' : 'Ctrl'} K
        </kbd>
      </Button>

      <CommandDialog
        open={open}
        onOpenChange={setOpen}
        title="Buscar sección"
        description="Escribe para ir a cualquier sección del panel."
      >
        <CommandInput placeholder="Buscar sección… (ej. cotizaciones, gastos, roles)" />
        <CommandList>
          <CommandEmpty>Sin resultados.</CommandEmpty>
          {groups.map((group) => (
            <CommandGroup key={group.label} heading={group.label}>
              {group.items.map((item) => (
                <CommandItem
                  key={`${group.label}-${item.href}`}
                  value={`${group.label} ${item.title}`}
                  onSelect={() => go(item.href)}
                >
                  {item.icon && <item.icon className="text-muted-foreground" />}
                  <span>{item.title}</span>
                </CommandItem>
              ))}
            </CommandGroup>
          ))}
        </CommandList>
      </CommandDialog>
    </>
  );
}
