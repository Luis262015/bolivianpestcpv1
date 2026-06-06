import { Badge } from '@/components/ui/badge';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import {
  ChartConfig,
  ChartContainer,
  ChartTooltip,
  ChartTooltipContent,
} from '@/components/ui/chart';
import AppLayout from '@/layouts/app-layout';
import { dashboard } from '@/routes';
import { type BreadcrumbItem } from '@/types';
import { Head, Link } from '@inertiajs/react';
import { format } from 'date-fns';
import { es } from 'date-fns/locale';
import {
  Bug,
  CalendarClock,
  ClipboardCheck,
  Rat,
  TrendingDown,
  TrendingUp,
} from 'lucide-react';
import {
  Bar,
  BarChart,
  CartesianGrid,
  Cell,
  LabelList,
  Pie,
  PieChart,
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
  serviciosHoy: number;
  serviciosAyer: number;
  serviciosMes: number;
  serviciosMesAnterior: number;
  cronogramaPendiente: number;
  cronogramaPostergado: number;
  roedoresCapturados: number;
  roedoresCapturadosPrev: number;
}

interface ProximaVisita {
  id: number;
  title: string;
  date: string;
  empresa: string | null;
  almacen: string | null;
  tipo: string | null;
  tecnico: string | null;
}

interface DashboardProps {
  stats: Stats;
  serviciosPorMes: { mes: string; total: number }[];
  cumplimientoCronograma: { estado: string; total: number; fill: string }[];
  topEspecies: { nombre: string; total: number }[];
  proximasVisitas: ProximaVisita[];
}

const serviciosConfig = {
  total: { label: 'Servicios', color: '#2563eb' },
} satisfies ChartConfig;

const especiesConfig = {
  total: { label: 'Detecciones', color: '#0ea5e9' },
} satisfies ChartConfig;

function delta(actual: number, anterior: number): number | null {
  if (anterior === 0) return actual > 0 ? 100 : null;
  return Math.round(((actual - anterior) / anterior) * 100);
}

function KpiCard({
  title,
  value,
  icon,
  trend,
  hint,
  tone = 'default',
}: {
  title: string;
  value: number | string;
  icon: React.ReactNode;
  trend?: number | null;
  hint?: string;
  tone?: 'default' | 'warning' | 'danger';
}) {
  const toneRing =
    tone === 'danger'
      ? 'text-red-600 bg-red-100 dark:bg-red-950'
      : tone === 'warning'
        ? 'text-amber-600 bg-amber-100 dark:bg-amber-950'
        : 'text-blue-600 bg-blue-100 dark:bg-blue-950';

  return (
    <Card className="gap-2 py-4">
      <CardHeader className="flex flex-row items-center justify-between space-y-0">
        <CardTitle className="text-muted-foreground text-sm font-medium">
          {title}
        </CardTitle>
        <span className={`rounded-lg p-2 ${toneRing}`}>{icon}</span>
      </CardHeader>
      <CardContent>
        <div className="text-3xl font-bold tracking-tight">{value}</div>
        <div className="mt-1 flex items-center gap-2 text-xs">
          {trend !== undefined && trend !== null && (
            <span
              className={`inline-flex items-center gap-0.5 font-medium ${
                trend >= 0 ? 'text-emerald-600' : 'text-red-600'
              }`}
            >
              {trend >= 0 ? (
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

export default function Dashboard({
  stats,
  serviciosPorMes,
  cumplimientoCronograma,
  topEspecies,
  proximasVisitas,
}: DashboardProps) {
  const totalCumplimiento = cumplimientoCronograma.reduce(
    (a, b) => a + b.total,
    0,
  );

  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Dashboard" />
      <div className="flex h-full flex-1 flex-col gap-4 p-4">
        {/* Banda 1: KPIs */}
        <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-4">
          <KpiCard
            title="Servicios hoy"
            value={stats.serviciosHoy}
            icon={<ClipboardCheck className="size-4" />}
            trend={delta(stats.serviciosHoy, stats.serviciosAyer)}
            hint="vs. ayer"
          />
          <KpiCard
            title="Servicios del mes"
            value={stats.serviciosMes}
            icon={<ClipboardCheck className="size-4" />}
            trend={delta(stats.serviciosMes, stats.serviciosMesAnterior)}
            hint="vs. mes anterior"
          />
          <KpiCard
            title="Cronograma pendiente"
            value={stats.cronogramaPendiente}
            icon={<CalendarClock className="size-4" />}
            hint={`${stats.cronogramaPostergado} postergados`}
            tone="warning"
          />
          <KpiCard
            title="Roedores capturados"
            value={stats.roedoresCapturados}
            icon={<Rat className="size-4" />}
            trend={delta(
              stats.roedoresCapturados,
              stats.roedoresCapturadosPrev,
            )}
            hint="últimos 90 días"
            tone="danger"
          />
        </div>

        {/* Banda 2: Operación */}
        <div className="grid gap-4 lg:grid-cols-3">
          <Card className="lg:col-span-2">
            <CardHeader>
              <CardTitle>Servicios por mes</CardTitle>
            </CardHeader>
            <CardContent>
              <ChartContainer
                config={serviciosConfig}
                className="max-h-[280px] w-full"
              >
                <BarChart accessibilityLayer data={serviciosPorMes}>
                  <CartesianGrid vertical={false} />
                  <XAxis
                    dataKey="mes"
                    tickLine={false}
                    axisLine={false}
                    tickMargin={8}
                  />
                  <ChartTooltip content={<ChartTooltipContent />} />
                  <Bar
                    dataKey="total"
                    fill="var(--color-total)"
                    radius={[4, 4, 0, 0]}
                  />
                </BarChart>
              </ChartContainer>
            </CardContent>
          </Card>

          <Card>
            <CardHeader>
              <CardTitle>Cumplimiento de cronograma</CardTitle>
            </CardHeader>
            <CardContent className="flex flex-col items-center">
              {totalCumplimiento === 0 ? (
                <p className="text-muted-foreground py-12 text-sm">
                  Sin tareas este mes
                </p>
              ) : (
                <>
                  <ChartContainer
                    config={{}}
                    className="mx-auto aspect-square max-h-[200px]"
                  >
                    <PieChart>
                      <ChartTooltip content={<ChartTooltipContent hideLabel />} />
                      <Pie
                        data={cumplimientoCronograma}
                        dataKey="total"
                        nameKey="estado"
                        innerRadius={55}
                        strokeWidth={2}
                      >
                        {cumplimientoCronograma.map((entry) => (
                          <Cell key={entry.estado} fill={entry.fill} />
                        ))}
                      </Pie>
                    </PieChart>
                  </ChartContainer>
                  <div className="mt-2 flex flex-wrap justify-center gap-3 text-xs">
                    {cumplimientoCronograma.map((c) => (
                      <span key={c.estado} className="flex items-center gap-1.5">
                        <span
                          className="size-2.5 rounded-[2px]"
                          style={{ backgroundColor: c.fill }}
                        />
                        {c.estado} ({c.total})
                      </span>
                    ))}
                  </div>
                </>
              )}
            </CardContent>
          </Card>
        </div>

        {/* Banda 3: Plagas + Próximas visitas */}
        <div className="grid gap-4 lg:grid-cols-3">
          <Card>
            <CardHeader>
              <CardTitle className="flex items-center gap-2">
                <Bug className="size-4" /> Plagas más detectadas
              </CardTitle>
            </CardHeader>
            <CardContent>
              {topEspecies.length === 0 ? (
                <p className="text-muted-foreground py-12 text-center text-sm">
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
                    margin={{ left: 8, right: 24 }}
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
                      radius={4}
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
            </CardHeader>
            <CardContent>
              {proximasVisitas.length === 0 ? (
                <p className="text-muted-foreground py-12 text-center text-sm">
                  No hay visitas pendientes programadas
                </p>
              ) : (
                <div className="divide-y">
                  {proximasVisitas.map((v) => (
                    <Link
                      key={v.id}
                      href="/cronogramas"
                      className="hover:bg-muted/50 flex items-center justify-between gap-3 py-2.5 transition-colors"
                    >
                      <div className="min-w-0">
                        <p className="truncate text-sm font-medium">
                          {v.empresa ?? v.title}
                        </p>
                        <p className="text-muted-foreground truncate text-xs">
                          {[v.almacen, v.tipo, v.tecnico]
                            .filter(Boolean)
                            .join(' · ')}
                        </p>
                      </div>
                      <Badge variant="outline" className="shrink-0">
                        {format(new Date(v.date), "dd 'de' MMM", { locale: es })}
                      </Badge>
                    </Link>
                  ))}
                </div>
              )}
            </CardContent>
          </Card>
        </div>
      </div>
    </AppLayout>
  );
}
