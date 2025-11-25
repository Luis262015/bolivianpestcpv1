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
  Factory,
  Files,
  HandCoins,
  HandHelping,
  Handshake,
  Keyboard,
  Locate,
  NotebookPen,
  ShoppingBasket,
  SquareChartGantt,
  TicketPercent,
  TrendingDown,
  TrendingUp,
  Users,
  Wrench,
} from 'lucide-react';
import AppLogo from './app-logo';

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
        href: '/ventas',
      },
      {
        title: 'Cotizaciones',
        href: '/ventas/create',
      },
      {
        title: 'Contratos',
        href: '/ventas/create',
      },
    ],
  },
  {
    title: 'Cronogramas',
    icon: CalendarDays,
    href: '/cuentascobrar',
  },

  {
    title: 'Mapas',
    icon: Locate,
    href: '/cuentascobrar',
  },
  {
    title: 'Seguimientos',
    icon: NotebookPen,
    href: '/cuentascobrar',
  },
];

// Contabilidad

const mainNavItems3: MainNavItem[] = [
  {
    title: 'Cuentas por Cobrar',
    icon: TrendingUp,
    href: '/cuentascobrar',
  },
  {
    title: 'Cuentas por Pagar',
    icon: TrendingDown,
    subItems: [
      {
        title: 'Lista',
        href: '/cuentaspagar',
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

  {
    title: 'Ingresos',
    icon: HandCoins,
    href: '/ingresos',
  },
  {
    title: 'Retiros',
    icon: HandHelping,
    href: '/retiros',
  },
  {
    title: 'Gastos',
    icon: TicketPercent,
    href: '/gastos',
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
      //   {
      //     title: 'Carga Masiva',
      //     href: '/productos/upload',
      //   },
      {
        title: 'Lista',
        href: '/productos',
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
    title: 'Documentos',
    icon: Files,
    href: '/cuentascobrar',
  },

  {
    title: 'Usuarios',
    icon: Users,
    down: true,
    subItems: [
      {
        title: 'Agregar Usuario',
        href: '/usuarios/create',
      },
      {
        title: 'Lista',
        href: '/usuarios',
      },
    ],
  },

  {
    title: 'Configuraciones',
    icon: Wrench,
    down: true,
    subItems: [
      {
        title: 'Roles',
        href: '/roles',
      },
      {
        title: 'Configs',
        href: '/configs',
      },
    ],
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
