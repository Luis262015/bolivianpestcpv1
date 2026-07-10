import { type NavSectionGroup } from '@/components/nav-main';
import { resolveUrl } from '@/lib/utils';
import { dashboard } from '@/routes';
import {
  Apple,
  Bug,
  CalendarDays,
  ChartCandlestick,
  Factory,
  FileChartColumn,
  Files,
  Globe,
  HandCoins,
  Handshake,
  type LucideIcon,
  LayoutGrid,
  Locate,
  NotebookPen,
  NotebookTabs,
  ShoppingBasket,
  ShoppingCart,
  SquareChartGantt,
  Tags,
  TicketPercent,
  TrendingDown,
  TrendingUp,
  Users,
  Wrench,
} from 'lucide-react';

/**
 * Fuente única de la navegación del panel. La consumen tanto el sidebar
 * (`AppSidebar`) como la paleta de comandos (`CommandMenu`), de modo que
 * cualquier cambio de menú se hace en un solo lugar y ambos respetan los roles.
 */
export const adminSections: NavSectionGroup[] = [
  {
    label: 'Cliente',
    items: [
      { title: 'Dashboard', icon: LayoutGrid, href: dashboard() },
      // Empresas migró a pestañas en la página (Lista/Contratos/Cotizaciones):
      // el sidebar es un solo link y las hermanas viven como tabs. Contratos y
      // Cotizaciones se marcan `hidden` para seguir siendo buscables en ⌘K.
      { title: 'Empresas', icon: Factory, href: '/empresas' },
      { title: 'Contratos', icon: Factory, href: '/contratos', hidden: true },
      { title: 'Cotizaciones', icon: Factory, href: '/cotizaciones', hidden: true },
      { title: 'Cronogramas', icon: CalendarDays, href: '/cronogramas' },
      { title: 'Mapas', icon: Locate, href: '/mapas' },
      { title: 'Seguimientos', icon: NotebookPen, href: '/seguimientos' },
      { title: 'Informes', icon: FileChartColumn, href: '/informes' },
    ],
  },
  {
    label: 'Contabilidad',
    items: [
      // "Crear" vive como botón en cada lista → enlace directo, sin submenú.
      { title: 'Ventas', icon: ShoppingCart, href: '/ventas' },
      { title: 'Compras', icon: ShoppingBasket, href: '/compras' },
      { title: 'Estados Financieros', icon: ChartCandlestick, href: '/estados' },
      { title: 'Cuentas por Cobrar', icon: TrendingUp, href: '/cuentasporcobrar' },
      { title: 'Cuentas por Pagar', icon: TrendingDown, href: '/cuentasporpagar' },
      { title: 'Ingresos', icon: HandCoins, href: '/ingresos' },
      // Gastos migró a pestañas (Financieros/Operativos/Extras/Caja Chica): el
      // sidebar es un link único que aterriza en Financieros, y las 4 quedan
      // buscables en ⌘K con su nombre real. Los `hidden` van antes del link
      // visible para que el dedupe por href de `flattenSections` conserve el
      // nombre específico ("Financieros") en vez del genérico ("Gastos").
      { title: 'Financieros', icon: TicketPercent, href: '/gastosfin', hidden: true },
      { title: 'Operativos', icon: TicketPercent, href: '/gastosop', hidden: true },
      { title: 'Extras', icon: TicketPercent, href: '/gastosex', hidden: true },
      { title: 'Caja Chica', icon: TicketPercent, href: '/gastos', hidden: true },
      { title: 'Gastos', icon: TicketPercent, href: '/gastosfin' },
      { title: 'Productos', icon: Apple, href: '/productos' },
      { title: 'Proveedores', icon: Handshake, href: '/proveedores' },
      { title: 'Inventario', icon: SquareChartGantt, href: '/inventarios' },
    ],
  },
  {
    label: 'Catálogos',
    items: [
      {
        title: 'Seguimientos',
        icon: Bug,
        down: true,
        subItems: [
          { title: 'Tipos', href: '/tipos' },
          { title: 'Biologicos', href: '/biologicos' },
          { title: 'Epps', href: '/epps' },
          { title: 'Metodos', href: '/metodos' },
          { title: 'Protecciones', href: '/protecciones' },
          { title: 'Signos', href: '/signos' },
          { title: 'Especies', href: '/especies' },
        ],
      },
      {
        title: 'Productos',
        icon: Tags,
        down: true,
        subItems: [
          { title: 'Unidades', href: '/unidades' },
          { title: 'Categorias', href: '/categorias' },
          { title: 'Subcategorias', href: '/subcategorias' },
          { title: 'Marcas', href: '/marcas' },
          { title: 'Etiquetas', href: '/etiquetas' },
        ],
      },
    ],
  },
  {
    label: 'Usuario',
    items: [
      { title: 'Agenda', icon: NotebookTabs, href: '/agendas' },
      { title: 'Documentos', icon: Files, href: '/documentos' },
      // Usuarios migró a pestañas (Usuarios/Roles): link único en el sidebar y
      // Roles marcado `hidden` para seguir siendo buscable en ⌘K.
      { title: 'Usuarios', icon: Users, href: '/usuarios' },
      { title: 'Roles', icon: Users, href: '/roles', hidden: true },
      { title: 'Sitio Web', icon: Globe, href: '/sitio' },
      { title: 'Configuraciones', icon: Wrench, href: '/configs' },
    ],
  },
];

export const clienteSections: NavSectionGroup[] = [
  {
    label: 'Menú',
    items: [
      { title: 'Dashboard', icon: LayoutGrid, href: dashboard() },
      { title: 'Empresa', icon: Factory, href: '/empresas' },
      { title: 'Cronogramas', icon: CalendarDays, href: '/cronogramas' },
      { title: 'Mapas', icon: Locate, href: '/mapas' },
      { title: 'Seguimientos', icon: NotebookPen, href: '/seguimientos' },
      { title: 'Informes', icon: FileChartColumn, href: '/informes' },
      { title: 'Productos', icon: Apple, href: '/productos' },
      { title: 'Documentos', icon: Files, href: '/documentos' },
    ],
  },
];

export interface FlatNavItem {
  title: string;
  href: string;
  group: string;
  icon?: LucideIcon | null;
}

/**
 * Aplana las secciones a una lista de destinos navegables para la paleta ⌘K.
 * Los ítems con submenú se expanden a "Padre: Hijo" para que sean buscables.
 */
export function flattenSections(sections: NavSectionGroup[]): FlatNavItem[] {
  const flat: FlatNavItem[] = [];
  const seen = new Set<string>();

  // Deduplica por destino: si dos ítems apuntan al mismo href (p. ej. el link
  // visible "Gastos" y el `hidden` "Financieros" → /gastosfin) se conserva el
  // primero, por lo que el nombre específico gana si va antes en la config.
  const push = (entry: FlatNavItem): void => {
    if (seen.has(entry.href)) return;
    seen.add(entry.href);
    flat.push(entry);
  };

  for (const section of sections) {
    for (const item of section.items) {
      if (item.subItems?.length) {
        for (const sub of item.subItems) {
          push({
            title: `${item.title}: ${sub.title}`,
            href: resolveUrl(sub.href),
            group: section.label,
            icon: item.icon,
          });
        }
      } else if (item.href) {
        push({
          title: item.title,
          href: resolveUrl(item.href),
          group: section.label,
          icon: item.icon,
        });
      }
    }
  }

  return flat;
}
