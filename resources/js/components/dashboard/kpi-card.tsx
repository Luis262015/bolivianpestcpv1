import { Card, CardContent } from '@/components/ui/card';
import { cn } from '@/lib/utils';
import { TrendingDown, TrendingUp } from 'lucide-react';
import type { ReactNode } from 'react';

export type KpiTone = 'default' | 'success' | 'warning' | 'danger';

/** Chip del icono según el tono (con variantes para modo oscuro). */
const toneChip: Record<KpiTone, string> = {
  default: 'text-blue-600 bg-blue-100 dark:bg-blue-950/60 dark:text-blue-400',
  success:
    'text-emerald-600 bg-emerald-100 dark:bg-emerald-950/60 dark:text-emerald-400',
  warning: 'text-amber-600 bg-amber-100 dark:bg-amber-950/60 dark:text-amber-400',
  danger: 'text-red-600 bg-red-100 dark:bg-red-950/60 dark:text-red-400',
};

/**
 * Calcula la variación porcentual actual vs. anterior. Devuelve `null` cuando
 * no hay base de comparación (para no mostrar un delta engañoso).
 */
export function delta(actual: number, anterior: number): number | null {
  if (anterior === 0) return actual > 0 ? 100 : null;
  return Math.round(((actual - anterior) / anterior) * 100);
}

/**
 * Tarjeta de KPI compartida por los dashboards (admin y cliente): título,
 * valor grande, chip de icono por tono y una píldora de tendencia opcional.
 */
export function KpiCard({
  title,
  value,
  icon,
  trend,
  hint,
  tone = 'default',
}: {
  title: string;
  value: number | string;
  icon: ReactNode;
  trend?: number | null;
  hint?: string;
  tone?: KpiTone;
}) {
  const hasTrend = trend !== undefined && trend !== null;
  const positive = hasTrend && trend >= 0;

  return (
    <Card className="gap-0 py-0 transition-shadow hover:shadow-md">
      <CardContent className="p-5">
        <div className="flex items-center justify-between">
          <span className="text-muted-foreground text-sm font-medium">
            {title}
          </span>
          <span
            className={cn(
              'flex size-9 shrink-0 items-center justify-center rounded-lg',
              toneChip[tone],
            )}
          >
            {icon}
          </span>
        </div>

        <div className="mt-3 text-3xl font-bold tracking-tight tabular-nums">
          {value}
        </div>

        <div className="mt-2 flex flex-wrap items-center gap-2 text-xs">
          {hasTrend && (
            <span
              className={cn(
                'inline-flex items-center gap-0.5 rounded-full px-1.5 py-0.5 font-medium',
                positive
                  ? 'bg-emerald-100 text-emerald-700 dark:bg-emerald-950/60 dark:text-emerald-400'
                  : 'bg-red-100 text-red-700 dark:bg-red-950/60 dark:text-red-400',
              )}
            >
              {positive ? (
                <TrendingUp className="size-3" />
              ) : (
                <TrendingDown className="size-3" />
              )}
              {Math.abs(trend)}%
            </span>
          )}
          {hint && <span className="text-muted-foreground">{hint}</span>}
        </div>
      </CardContent>
    </Card>
  );
}
