import { KpiCard, delta } from '@/components/dashboard/kpi-card';
import { Badge } from '@/components/ui/badge';
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from '@/components/ui/card';
import {
  ChartConfig,
  ChartContainer,
  ChartTooltip,
  ChartTooltipContent,
} from '@/components/ui/chart';
import AppLayout from '@/layouts/app-layout';
import { dashboard } from '@/routes';
import { type BreadcrumbItem } from '@/types';
import { Head, Link, usePage } from '@inertiajs/react';
import { format } from 'date-fns';
import { es } from 'date-fns/locale';
import { Bug, CalendarClock, ClipboardCheck, Rat } from 'lucide-react';
import {
  Bar,
  BarChart,
  CartesianGrid,
  LabelList,
  XAxis,
  YAxis,
} from 'recharts';

const breadcrumbs: BreadcrumbItem[] = [
  {
    title: 'Dashboard',
    href: dashboard().url,
  },
];

interface Stats {
  serviciosMes: number;
  serviciosMesAnterior: number;
  cronogramaPendiente: number;
  cronogramaPostergado: number;
  roedoresCapturados: number;
  roedoresCapturadosPrev: number;
  especiesDetectadas: number;
}

interface ProximaVisita {
  id: number;
  title: string;
  date: string;
  empresa: string | null;
  almacen: string | null;
  tipo: string | null;
}

interface DashboardClienteProps {
  stats: Stats;
  serviciosPorMes: { mes: string; total: number }[];
  topEspecies: { nombre: string; total: number }[];
  proximasVisitas: ProximaVisita[];
}

const serviciosConfig = {
  total: { label: 'Servicios', color: 'var(--primary)' },
} satisfies ChartConfig;

const especiesConfig = {
  total: { label: 'Detecciones', color: '#0ea5e9' },
} satisfies ChartConfig;

/** Saludo según la hora local. */
function saludoActual(): string {
  const h = new Date().getHours();
  if (h < 12) return 'Buenos días';
  if (h < 19) return 'Buenas tardes';
  return 'Buenas noches';
}

export default function DashboardCliente({
  stats,
  serviciosPorMes,
  topEspecies,
  proximasVisitas,
}: DashboardClienteProps) {
  const { props } = usePage();
  const userName = props.auth?.user?.name ?? '';

  const totalServiciosAnio = serviciosPorMes.reduce((a, b) => a + b.total, 0);

  const fechaHoy = format(new Date(), "EEEE, d 'de' MMMM", { locale: es });
  const fechaCap = fechaHoy.charAt(0).toUpperCase() + fechaHoy.slice(1);

  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Dashboard" />
      <div className="flex h-full flex-1 flex-col gap-4 p-4">
        {/* Encabezado */}
        <div className="flex flex-col gap-1">
          <h1 className="text-2xl font-bold tracking-tight">
            {saludoActual()}
            {userName ? `, ${userName.split(' ')[0]}` : ''}
          </h1>
          <p className="text-muted-foreground text-sm">
            Resumen de sus establecimientos · {fechaCap}
          </p>
        </div>

        {/* Banda 1: KPIs (solo datos de sus empresas) */}
        <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-4">
          <KpiCard
            title="Servicios del mes"
            value={stats.serviciosMes}
            icon={<ClipboardCheck className="size-4" />}
            trend={delta(stats.serviciosMes, stats.serviciosMesAnterior)}
            hint="vs. mes anterior"
          />
          <KpiCard
            title="Visitas pendientes"
            value={stats.cronogramaPendiente}
            icon={<CalendarClock className="size-4" />}
            hint={`${stats.cronogramaPostergado} postergadas`}
            tone="warning"
          />
          <KpiCard
            title="Roedores capturados"
            value={stats.roedoresCapturados}
            icon={<Rat className="size-4" />}
            trend={delta(stats.roedoresCapturados, stats.roedoresCapturadosPrev)}
            hint="últimos 90 días"
            tone="danger"
          />
          <KpiCard
            title="Plagas detectadas"
            value={stats.especiesDetectadas}
            icon={<Bug className="size-4" />}
            hint="últimos 90 días"
          />
        </div>

        {/* Banda 2: Servicios por mes */}
        <Card>
          <CardHeader>
            <CardTitle>Servicios por mes</CardTitle>
            <CardDescription>
              {totalServiciosAnio.toLocaleString('es-BO')} servicios en los
              últimos 12 meses
            </CardDescription>
          </CardHeader>
          <CardContent>
            <ChartContainer
              config={serviciosConfig}
              className="max-h-[280px] w-full"
            >
              <BarChart accessibilityLayer data={serviciosPorMes}>
                <defs>
                  <linearGradient
                    id="fillServiciosCliente"
                    x1="0"
                    y1="0"
                    x2="0"
                    y2="1"
                  >
                    <stop
                      offset="0%"
                      stopColor="var(--color-total)"
                      stopOpacity={0.95}
                    />
                    <stop
                      offset="100%"
                      stopColor="var(--color-total)"
                      stopOpacity={0.55}
                    />
                  </linearGradient>
                </defs>
                <CartesianGrid vertical={false} strokeDasharray="3 3" />
                <XAxis
                  dataKey="mes"
                  tickLine={false}
                  axisLine={false}
                  tickMargin={8}
                  fontSize={11}
                />
                <ChartTooltip
                  cursor={{ fill: 'var(--muted)', opacity: 0.4 }}
                  content={<ChartTooltipContent />}
                />
                <Bar
                  dataKey="total"
                  fill="url(#fillServiciosCliente)"
                  radius={[6, 6, 0, 0]}
                  maxBarSize={44}
                />
              </BarChart>
            </ChartContainer>
          </CardContent>
        </Card>

        {/* Banda 3: Plagas + Próximas visitas */}
        <div className="grid gap-4 lg:grid-cols-3">
          <Card>
            <CardHeader>
              <CardTitle className="flex items-center gap-2">
                <Bug className="size-4" /> Plagas más detectadas
              </CardTitle>
              <CardDescription>Últimos 90 días</CardDescription>
            </CardHeader>
            <CardContent>
              {topEspecies.length === 0 ? (
                <p className="text-muted-foreground py-16 text-center text-sm">
                  Sin detecciones (últimos 90 días)
                </p>
              ) : (
                <ChartContainer
                  config={especiesConfig}
                  className="max-h-[260px] w-full"
                >
                  <BarChart
                    accessibilityLayer
                    data={topEspecies}
                    layout="vertical"
                    margin={{ left: 8, right: 28 }}
                  >
                    <XAxis type="number" hide />
                    <YAxis
                      dataKey="nombre"
                      type="category"
                      tickLine={false}
                      axisLine={false}
                      width={110}
                      tick={{ fontSize: 11 }}
                    />
                    <ChartTooltip content={<ChartTooltipContent hideLabel />} />
                    <Bar
                      dataKey="total"
                      fill="var(--color-total)"
                      radius={5}
                      maxBarSize={26}
                    >
                      <LabelList
                        dataKey="total"
                        position="right"
                        className="fill-foreground"
                        fontSize={11}
                      />
                    </Bar>
                  </BarChart>
                </ChartContainer>
              )}
            </CardContent>
          </Card>

          <Card className="lg:col-span-2">
            <CardHeader>
              <CardTitle className="flex items-center gap-2">
                <CalendarClock className="size-4" /> Próximas visitas
              </CardTitle>
              <CardDescription>
                Cronograma pendiente, de hoy en adelante
              </CardDescription>
            </CardHeader>
            <CardContent>
              {proximasVisitas.length === 0 ? (
                <p className="text-muted-foreground py-16 text-center text-sm">
                  No hay visitas pendientes programadas
                </p>
              ) : (
                <ul className="flex flex-col gap-1">
                  {proximasVisitas.map((v) => {
                    const fecha = new Date(v.date);
                    return (
                      <li key={v.id}>
                        <Link
                          href="/cronogramas"
                          className="hover:bg-muted/60 group flex items-center gap-3 rounded-lg p-2 transition-colors"
                        >
                          <div className="bg-muted text-muted-foreground group-hover:bg-background flex size-11 shrink-0 flex-col items-center justify-center rounded-lg border transition-colors">
                            <span className="text-foreground text-sm font-bold leading-none">
                              {format(fecha, 'dd')}
                            </span>
                            <span className="text-[10px] uppercase">
                              {format(fecha, 'MMM', { locale: es })}
                            </span>
                          </div>
                          <div className="min-w-0 flex-1">
                            <p className="truncate text-sm font-medium">
                              {v.empresa ?? v.title}
                            </p>
                            <p className="text-muted-foreground truncate text-xs">
                              {[v.almacen, v.tipo].filter(Boolean).join(' · ') ||
                                'Sin detalles'}
                            </p>
                          </div>
                          <Badge variant="outline" className="shrink-0">
                            {format(fecha, "dd 'de' MMM", { locale: es })}
                          </Badge>
                        </Link>
                      </li>
                    );
                  })}
                </ul>
              )}
            </CardContent>
          </Card>
        </div>
      </div>
    </AppLayout>
  );
}
