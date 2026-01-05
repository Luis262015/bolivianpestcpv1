import { NavFooter } from '@/components/nav-footer';
import { NavMain } from '@/components/nav-main';
import { NavUser } from '@/components/nav-user';
import {
  Sidebar,
  SidebarContent,
  SidebarFooter,
  SidebarHeader,
  SidebarMenu,
  SidebarMenuButton,
  SidebarMenuItem,
} from '@/components/ui/sidebar';
import { dashboard } from '@/routes';
import { type MainNavItem, NavItem } from '@/types';
import { Link } from '@inertiajs/react';
import {
  Apple,
  CalendarDays,
  ChartCandlestick,
  Factory,
  Files,
  HandCoins,
  Handshake,
  Keyboard,
  Locate,
  NotebookPen,
  NotebookTabs,
  ShoppingBasket,
  ShoppingCart,
  SquareChartGantt,
  TicketPercent,
  TrendingDown,
  TrendingUp,
  Users,
  Wrench,
} from 'lucide-react';
import AppLogo from './app-logo';

// const { hasPermission } = usePermissions();

const mainNavItems: NavItem[] = [
  {
    title: 'Abrir Caja',
    href: '/cajas/create',
    icon: Keyboard,
  },
];

// Clientes

const mainNavItems2: MainNavItem[] = [
  {
    title: 'Empresas',
    icon: Factory,
    down: true,
    subItems: [
      {
        title: 'Lista',
        href: '/empresas',
      },
      {
        title: 'Contratos',
        href: '/contratos',
      },
      {
        title: 'Cotizaciones',
        href: '/cotizaciones',
      },
    ],
  },

  {
    title: 'Cronogramas',
    icon: CalendarDays,
    href: '/cronogramas',
  },

  {
    title: 'Mapas',
    icon: Locate,
    href: '/mapas',
  },

  {
    title: 'Seguimientos',
    icon: NotebookPen,
    href: '/seguimientos',
    down: true,
    subItems: [
      {
        title: 'Lista',
        href: '/seguimientos',
      },
      {
        title: 'Tipos',
        href: '/tipos',
      },
      {
        title: 'Biologicos',
        href: '/biologicos',
      },
      {
        title: 'Epps',
        href: '/epps',
      },
      {
        title: 'Metodos',
        href: '/metodos',
      },
      {
        title: 'Protecciones',
        href: '/protecciones',
      },
      {
        title: 'Signos',
        href: '/signos',
      },
      {
        title: 'Especies',
        href: '/especies',
      },
    ],
  },
];

// Contabilidad

const mainNavItems3: MainNavItem[] = [
  {
    title: 'Ventas',
    icon: ShoppingCart,
    down: true,
    subItems: [
      {
        title: 'Realizar Venta',
        href: '/ventas/create',
      },
      {
        title: 'Lista',
        href: '/ventas',
      },
    ],
  },
  {
    title: 'Compras',
    icon: ShoppingBasket,
    down: true,
    subItems: [
      {
        title: 'Realizar Compra',
        href: '/compras/create',
      },
      {
        title: 'Lista',
        href: '/compras',
      },
    ],
  },

  // {
  //   title: 'Ingresos',
  //   icon: TrendingUp,
  //   down: true,
  //   subItems: [
  //     {
  //       title: 'Cuentas por Cobrar',
  //       icon: TrendingUp,
  //       href: '/cuentasporcobrar',
  //     },
  //     {
  //       title: 'Ingresos',
  //       icon: HandCoins,
  //       href: '/ingresos',
  //     },
  //   ],
  // },

  // {
  //   title: 'Egresos',
  //   icon: TrendingDown,
  //   down: false,
  //   subItems: [
  //     {
  //       title: 'Cuentas por Pagar',
  //       icon: TrendingDown,
  //       href: '/cuentasporpagar',
  //     },
  //     // {
  //     //   title: 'Retiros',
  //     //   icon: HandHelping,
  //     //   href: '/retiros',
  //     // },
  //     // {
  //     //   title: 'Gastos',
  //     //   icon: TicketPercent,
  //     //   href: '/gastos',
  //     // },
  //   ],
  // },

  {
    title: 'Estados Financieros',
    icon: ChartCandlestick,
    href: '/estados',
  },

  {
    title: 'Cuentas por Cobrar',
    icon: TrendingUp,
    href: '/cuentasporcobrar',
  },
  {
    title: 'Cuentas por Pagar',
    icon: TrendingDown,
    href: '/cuentasporpagar',
  },

  {
    title: 'Ingresos',
    icon: HandCoins,
    href: '/ingresos',
  },
  // {
  //   title: 'Retiros',
  //   icon: HandHelping,
  //   href: '/retiros',
  // },
  {
    title: 'Gastos',
    icon: TicketPercent,
    href: '/gastos',
    down: true,
    subItems: [
      {
        title: 'Financieros',
        href: '/gastosfin',
      },
      {
        title: 'Operativos',
        href: '/gastosop',
      },
      {
        title: 'Extras',
        href: '/gastosex',
      },
      {
        title: 'Caja Chica',
        href: '/gastos',
      },
    ],
  },
  {
    title: 'Productos',
    icon: Apple,
    down: true,
    subItems: [
      {
        title: 'Agregar Producto',
        href: '/productos/create',
      },
      {
        title: 'Lista',
        href: '/productos',
      },
      {
        title: 'Unidades',
        href: '/unidades',
      },
      {
        title: 'Categorias',
        href: '/categorias',
      },
      {
        title: 'Subcategorias',
        href: '/subcategorias',
      },
      {
        title: 'Marcas',
        href: '/marcas',
      },
      {
        title: 'Etiquetas',
        href: '/etiquetas',
      },
    ],
  },
  {
    title: 'Proveedores',
    icon: Handshake,
    href: '/proveedores',
  },
  {
    title: 'Inventario',
    icon: SquareChartGantt,
    href: '/inventarios',
  },
];

// Usuario
const mainNavItems4: MainNavItem[] = [
  {
    title: 'Agenda',
    icon: NotebookTabs,
    href: '/agendas',
  },
  {
    title: 'Documentos',
    icon: Files,
    href: '/documentos',
  },

  {
    title: 'Usuarios',
    icon: Users,
    down: true,
    subItems: [
      {
        title: 'Usuarios',
        href: '/usuarios',
      },
      {
        title: 'Roles',
        href: '/roles',
      },
    ],
  },

  {
    title: 'Configuraciones',
    icon: Wrench,
    href: '/configs',
  },
];

const footerNavItems: NavItem[] = [
  // {
  //     title: 'Repository',
  //     href: 'https://github.com/laravel/react-starter-kit',
  //     icon: Folder,
  // },
  // {
  //     title: 'Documentation',
  //     href: 'https://laravel.com/docs/starter-kits#react',
  //     icon: BookOpen,
  // },
];

export function AppSidebar() {
  return (
    <Sidebar collapsible="icon" variant="inset">
      <SidebarHeader>
        <SidebarMenu>
          <SidebarMenuItem>
            <SidebarMenuButton size="lg" asChild>
              <Link href={dashboard()} prefetch>
                <AppLogo />
              </Link>
            </SidebarMenuButton>
          </SidebarMenuItem>
        </SidebarMenu>
      </SidebarHeader>

      <SidebarContent>
        <NavMain
          items={mainNavItems}
          items2={mainNavItems2}
          items3={mainNavItems3}
          items4={mainNavItems4}
        />
      </SidebarContent>

      <SidebarFooter>
        <NavFooter items={footerNavItems} className="mt-auto" />
        <NavUser />
      </SidebarFooter>
    </Sidebar>
  );
}

// --------------------------------------------------------------
// import { NavFooter } from '@/components/nav-footer';
// import { NavMain } from '@/components/nav-main';
// import { NavUser } from '@/components/nav-user';
// import {
//     Sidebar,
//     SidebarContent,
//     SidebarFooter,
//     SidebarHeader,
//     SidebarMenu,
//     SidebarMenuButton,
//     SidebarMenuItem,
// } from '@/components/ui/sidebar';
// import { dashboard } from '@/routes';
// import { type NavItem } from '@/types';
// import { Link } from '@inertiajs/react';
// import { BookOpen, Folder, LayoutGrid } from 'lucide-react';
// import AppLogo from './app-logo';

// const mainNavItems: NavItem[] = [
//     {
//         title: 'Dashboard',
//         href: dashboard(),
//         icon: LayoutGrid,
//     },
// ];

// const footerNavItems: NavItem[] = [
//     {
//         title: 'Repository',
//         href: 'https://github.com/laravel/react-starter-kit',
//         icon: Folder,
//     },
//     {
//         title: 'Documentation',
//         href: 'https://laravel.com/docs/starter-kits#react',
//         icon: BookOpen,
//     },
// ];

// export function AppSidebar() {
//     return (
//         <Sidebar collapsible="icon" variant="inset">
//             <SidebarHeader>
//                 <SidebarMenu>
//                     <SidebarMenuItem>
//                         <SidebarMenuButton size="lg" asChild>
//                             <Link href={dashboard()} prefetch>
//                                 <AppLogo />
//                             </Link>
//                         </SidebarMenuButton>
//                     </SidebarMenuItem>
//                 </SidebarMenu>
//             </SidebarHeader>

//             <SidebarContent>
//                 <NavMain items={mainNavItems} />
//             </SidebarContent>

//             <SidebarFooter>
//                 <NavFooter items={footerNavItems} className="mt-auto" />
//                 <NavUser />
//             </SidebarFooter>
//         </Sidebar>
//     );
// }
