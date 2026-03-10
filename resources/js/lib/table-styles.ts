// lib/table-styles.ts
import { cn } from '@/lib/utils';

export const tableStyles = {
  // Contenedor principal
  container:
    'rounded-lg border border-slate-200 bg-white shadow-sm overflow-hidden',

  // Wrapper con scroll horizontal
  wrapper:
    'w-full overflow-x-auto rounded-lg border border-slate-200 shadow-sm',

  // Tabla con ancho mínimo para evitar compresión
  table: 'min-w-[800px] w-full caption-bottom text-sm',

  // Header sticky
  header: {
    row: 'border-b border-slate-200 hover:bg-transparent',
    cell: 'h-12 px-4 text-left align-middle font-semibold text-slate-600 uppercase text-xs tracking-wider bg-slate-50 sticky top-0 z-10',
  },

  // Filas del body
  row: (isEven?: boolean) =>
    cn(
      'border-b border-slate-100 transition-colors data-[state=selected]:bg-slate-100',
      isEven === undefined && 'hover:bg-slate-50/50',
      isEven === true && 'bg-white hover:bg-slate-50/50',
      isEven === false && 'bg-slate-50/60 hover:bg-slate-50/80',
    ),

  // Celdas estándar
  cell: 'p-4 align-middle text-slate-700',

  // Celda numérica/monospace para montos
  numeric: 'p-4 align-middle text-right font-mono tabular-nums text-slate-700',

  // Celda de monto destacado (totales, importantes)
  currency:
    'p-4 align-middle text-right font-mono tabular-nums font-medium text-slate-900',

  // Celda de monto destacado (totales, importantes)
  datestr: 'p-4 align-middle font-mono tabular-nums font-medium text-slate-900',

  // Badges de estado
  badge: (variant: 'success' | 'warning' | 'danger' | 'info' | 'neutral') =>
    cn(
      'inline-flex items-center rounded-full px-2.5 py-0.5 text-xs font-medium',
      variant === 'success' && 'bg-emerald-100 text-emerald-800',
      variant === 'warning' && 'bg-amber-100 text-amber-800',
      variant === 'danger' && 'bg-red-100 text-red-800',
      variant === 'info' && 'bg-blue-100 text-blue-800',
      variant === 'neutral' && 'bg-slate-100 text-slate-800',
    ),

  // Fila de totales/resumen
  totalRow:
    'bg-slate-100 font-semibold border-t-2 border-slate-300 hover:bg-slate-100',
  totalCell: 'p-4 align-middle font-semibold text-slate-900',
  totalNumeric:
    'p-4 align-middle text-right font-mono tabular-nums font-bold text-slate-900',

  // Texto auxiliar
  muted: 'text-slate-500 text-xs',
  caption: 'mt-2 text-xs text-slate-500 text-center',
};
