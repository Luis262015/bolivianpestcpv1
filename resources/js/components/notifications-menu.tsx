import { Button } from '@/components/ui/button';
import {
  Popover,
  PopoverContent,
  PopoverTrigger,
} from '@/components/ui/popover';
import { cn } from '@/lib/utils';
import { router, usePage } from '@inertiajs/react';
import { Bell, Check } from 'lucide-react';
import { useMemo, useState } from 'react';

export type NotificationTone = 'default' | 'success' | 'warning' | 'danger';

export interface NotificationItem {
  id: string | number;
  title: string;
  description?: string;
  /** Texto ya formateado, p. ej. "hace 2 días" o "en 3 días". */
  time?: string;
  /** Destino Inertia al hacer click (opcional). */
  href?: string;
  read?: boolean;
  tone?: NotificationTone;
}

const toneDot: Record<NotificationTone, string> = {
  default: 'bg-blue-500',
  success: 'bg-emerald-500',
  warning: 'bg-amber-500',
  danger: 'bg-red-500',
};

/**
 * Campana de notificaciones del header. Solo se listan las NO leídas: al
 * marcarlas leídas desaparecen del panel.
 *
 * Los datos llegan por el prop compartido `notificaciones` (ver
 * `HandleInertiaRequests::share()`), así que no requiere estado del servidor.
 */
export function NotificationsMenu() {
  const shared =
    ((usePage().props as unknown) as { notificaciones?: NotificationItem[] })
      .notificaciones ?? [];

  const [items, setItems] = useState<NotificationItem[]>(shared);
  const [open, setOpen] = useState(false);

  // Solo las no leídas se muestran y cuentan.
  const visibles = useMemo(() => items.filter((n) => !n.read), [items]);
  const unread = visibles.length;

  const markAllRead = () =>
    setItems((prev) => prev.map((n) => ({ ...n, read: true })));

  const onItemClick = (n: NotificationItem) => {
    setItems((prev) =>
      prev.map((x) => (x.id === n.id ? { ...x, read: true } : x)),
    );
    if (n.href) {
      setOpen(false);
      router.visit(n.href);
    }
  };

  return (
    <Popover open={open} onOpenChange={setOpen}>
      <PopoverTrigger asChild>
        <Button
          variant="ghost"
          size="icon"
          aria-label={
            unread > 0
              ? `Notificaciones (${unread} sin leer)`
              : 'Notificaciones'
          }
          className="relative"
        >
          <Bell className="size-5" />
          {unread > 0 && (
            <span className="bg-destructive text-destructive-foreground absolute -top-0.5 -right-0.5 flex h-4 min-w-4 items-center justify-center rounded-full px-1 text-[10px] leading-none font-semibold">
              {unread > 9 ? '9+' : unread}
            </span>
          )}
        </Button>
      </PopoverTrigger>

      <PopoverContent
        align="end"
        sideOffset={8}
        className="flex max-h-[28rem] w-80 flex-col p-0"
      >
        <div className="flex shrink-0 items-center justify-between border-b px-4 py-3">
          <div className="flex items-center gap-2">
            <span className="text-sm font-semibold">Notificaciones</span>
            {unread > 0 && (
              <span className="bg-muted text-muted-foreground rounded-full px-1.5 py-0.5 text-[10px] font-medium">
                {unread} nuevas
              </span>
            )}
          </div>
          {unread > 0 && (
            <button
              type="button"
              onClick={markAllRead}
              className="text-muted-foreground hover:text-foreground inline-flex items-center gap-1 text-xs transition-colors"
            >
              <Check className="size-3" /> Marcar leídas
            </button>
          )}
        </div>

        {unread === 0 ? (
          <div className="flex flex-col items-center justify-center gap-2 px-4 py-10 text-center">
            <span className="bg-muted text-muted-foreground flex size-10 items-center justify-center rounded-full">
              <Bell className="size-5" />
            </span>
            <p className="text-muted-foreground text-sm">
              No tienes notificaciones
            </p>
          </div>
        ) : (
          <ul className="min-h-0 flex-1 divide-y overflow-y-auto overscroll-contain">
            {visibles.map((n) => (
              <li key={n.id}>
                <button
                  type="button"
                  onClick={() => onItemClick(n)}
                  className="hover:bg-muted/60 flex w-full gap-3 px-4 py-3 text-left transition-colors"
                >
                  <span
                    className={cn(
                      'mt-1.5 size-2 shrink-0 rounded-full',
                      toneDot[n.tone ?? 'default'],
                    )}
                  />
                  <div className="min-w-0 flex-1">
                    <p className="truncate text-sm font-medium">{n.title}</p>
                    {n.description && (
                      <p className="text-muted-foreground truncate text-xs">
                        {n.description}
                      </p>
                    )}
                    {n.time && (
                      <p className="text-muted-foreground mt-0.5 text-[11px]">
                        {n.time}
                      </p>
                    )}
                  </div>
                </button>
              </li>
            ))}
          </ul>
        )}
      </PopoverContent>
    </Popover>
  );
}
