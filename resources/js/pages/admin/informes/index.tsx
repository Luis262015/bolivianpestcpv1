import { Button } from '@/components/ui/button';
import {
  ChartConfig,
  ChartContainer,
  ChartTooltip,
  ChartTooltipContent,
} from '@/components/ui/chart';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select';
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from '@/components/ui/table';
import AppLayout from '@/layouts/app-layout';
import { confirmar, notificarError } from '@/lib/alertas';
import { tableStyles } from '@/lib/table-styles';
import { Head, router, usePage } from '@inertiajs/react';
import axios from 'axios';
import { Download, Trash2, Upload } from 'lucide-react';
import { useEffect, useMemo, useRef, useState } from 'react';
import {
  Bar,
  BarChart,
  CartesianGrid,
  LabelList,
  Legend,
  Line,
  LineChart,
  Tooltip,
  XAxis,
  YAxis,
} from 'recharts';

interface Empresa {
  id: number;
  nombre: string;
}

interface Almacen {
  id: number;
  nombre: string;
}

interface Especie {
  id: number;
  nombre: string;
}

interface Insectocutor {
  id: number;
  trampa_id: number;
  especie: Especie;
  cantidad: number;
}

interface Trampa {
  id: number;
  trampa_tipo_id: number;
  identificador: string;
  // 'inactivo' = retirada del mapa. Sus pesajes del periodo siguen siendo
  // válidos, pero ya no figura entre las trampas instaladas hoy.
  estado?: string;
  mapa?: { id: number; titulo: string };
}

interface Roedor {
  id: number;
  trampa_id: number;
  observacion: string;
  inicial: number;
  actual: number;
  merma: number;
  trampa: Trampa;
}

interface TipoSeguimiento {
  id: number;
  nombre: string;
}

interface User {
  id: number;
  name: string;
}

interface TotalData {
  mes: string;
  inicial_sum: number;
  merma_sum: number;
  actual_sum: number;
  inicial_avg: number;
  merma_avg: number;
  actual_avg: number;
}

interface Seguimiento {
  id: number;
  created_at: string;
  insectocutores: Insectocutor[];
  roedores: Roedor[];
  tipo_seguimiento_id: number;
  tipo_seguimiento: TipoSeguimiento;
  user: User;
  encargado_nombre: string;
  encargado_cargo: string;
  totales: TotalData[];
  cronograma_id: number;
}

interface Imagen {
  id: number;
  imagen: string;
}

interface Accion {
  id: number;
  descripcion: string;
  imagenes: Imagen[];
  created_at: string;
}

interface InformeArchivo {
  id: number;
  empresa_id: number;
  nombre_original: string;
  created_at: string;
  empresa: { id: number; nombre: string };
  user: { id: number; name: string };
}

interface Props {
  empresas: Empresa[];
  almacenes: Almacen[];
  seguimientos: Seguimiento[];
  acciones: Accion[];
  trampasinsect?: number;
  trampasrat?: number;
  // Trampas que salieron del mapa DENTRO del período, separadas por motivo:
  // `cambio_tipo` = el punto sigue ahí con otro tipo de trampa; `retirada` = el
  // punto desapareció. Lo calcula el backend porque la vista solo recibe los
  // seguimientos del rango y no puede saber qué pasó después.
  trampasRetiradas?: { cambio_tipo: number[]; retirada: number[] };
  totales: TotalData[];
  archivos: InformeArchivo[];
  filters: {
    empresa_id?: number;
    almacen_id?: number;
    fecha_inicio?: string;
    fecha_fin?: string;
    tipo_filtro?: string;
    mes_inicio?: string;
    anio_inicio?: string;
    mes_fin?: string;
    anio_fin?: string;
    anio?: string;
  };
}

// Formatea números mostrando como máximo 2 decimales (sin ceros de relleno).
// Los enteros quedan sin decimales; 12.300001 -> "12.3", 12.005 -> "12.01".
const n2 = (v: number | string) => {
  const num = Number(v);
  return Number.isFinite(num) ? String(Number(num.toFixed(2))) : String(v);
};

// Degradado vertical reutilizable para las barras de los gráficos del informe:
// color pleno arriba → más claro (60%) abajo, para un acabado más profesional.
// Se coloca dentro de un <defs> del propio gráfico y se referencia con url(#id).
const BarGradient = ({ id, color }: { id: string; color: string }) => (
  <linearGradient id={id} x1="0" y1="0" x2="0" y2="1">
    <stop offset="0%" stopColor={color} stopOpacity={1} />
    <stop offset="100%" stopColor={color} stopOpacity={0.6} />
  </linearGradient>
);

// Rótulo unificado para tablas y gráficos: barra de acento corporativa +
// versalitas, en lugar del antiguo font-mono subrayado (aspecto de informe).
const captionClass =
  'mb-3 border-l-4 border-[#1B3A6B] pl-3 text-sm font-semibold uppercase tracking-wide text-[#1B3A6B]';

// Nota bajo el título de una tabla, para explicar qué representa o cómo se
// calcula. Va en el contenedor exportado, así que también sale en el PDF.
const descClass = 'mb-3 max-w-3xl text-xs leading-relaxed text-slate-600';

// Clases completas, no interpoladas: Tailwind sólo conserva las que aparecen
// literalmente en el código, así que `border-${color}-500` no funcionaría.
const ACENTOS = {
  amber: 'border-amber-500 bg-amber-50',
  rose: 'border-rose-500 bg-rose-50',
  sky: 'border-sky-500 bg-sky-50',
} as const;

/**
 * Cabecera de sección del informe. Separa los bloques temáticos
 * (desratización, insectocutores, acciones) apoyándose en tres señales a la
 * vez —franja de color, fondo tintado y regla superior— para que el corte se
 * siga leyendo en el PDF impreso, donde el color puede perderse.
 */
const SeccionInforme = ({
  titulo,
  subtitulo,
  acento,
}: {
  titulo: string;
  subtitulo?: string;
  acento: keyof typeof ACENTOS;
}) => (
  <div className={`mb-6 rounded-lg border-l-8 px-5 py-4 ${ACENTOS[acento]}`}>
    <h2 className="text-2xl font-bold tracking-tight text-slate-900">
      {titulo}
    </h2>
    {subtitulo && <p className="text-sm text-slate-600">{subtitulo}</p>}
  </div>
);

/** Corte entre secciones. Va ENTRE las tarjetas, no dentro de ninguna. */
const SeparadorSeccion = () => (
  <div className="my-12 border-t-4 border-double border-slate-300" />
);

export default function Lista({
  empresas,
  almacenes,
  seguimientos,
  acciones,
  trampasinsect,
  trampasrat,
  trampasRetiradas: idsRetiradas,
  totales,
  archivos,
  filters,
}: Props) {
  const { auth } = usePage().props;
  const esAdminOSuperadmin =
    auth.roles.includes('admin') || auth.roles.includes('superadmin');
  const puedeExportarWord = esAdminOSuperadmin;

  const [subiendoArchivo, setSubiendoArchivo] = useState(false);
  const [archivoSeleccionado, setArchivoSeleccionado] = useState<File | null>(
    null,
  );
  const [empresaArchivoId, setEmpresaArchivoId] = useState('');

  const subirArchivo = async () => {
    if (!archivoSeleccionado || !empresaArchivoId) return;
    setSubiendoArchivo(true);
    const formData = new FormData();
    formData.append('archivo', archivoSeleccionado);
    formData.append('empresa_id', empresaArchivoId);
    router.post('/informe-archivos', formData as any, {
      forceFormData: true,
      onFinish: () => {
        setSubiendoArchivo(false);
        setArchivoSeleccionado(null);
        setEmpresaArchivoId('');
      },
    });
  };

  const eliminarArchivo = async (id: number) => {
    if (
      !(await confirmar({
        titulo: '¿Eliminar este archivo?',
        destructivo: true,
      }))
    )
      return;
    router.delete(`/informe-archivos/${id}`);
  };

  const [empresaId, setEmpresaId] = useState(filters.empresa_id?.toString());
  const [almacenId, setAlmacenId] = useState(filters.almacen_id?.toString());
  const [fechaInicio, setFechaInicio] = useState(filters.fecha_inicio ?? '');
  const [fechaFin, setFechaFin] = useState(filters.fecha_fin ?? '');

  type ModoFiltro = 'fechas' | 'meses' | 'anio';
  const anioActual = new Date().getFullYear();
  const aniosDisponibles = Array.from({ length: anioActual - 2019 }, (_, i) =>
    (anioActual - i).toString(),
  );
  const mesesNombres = [
    'Enero',
    'Febrero',
    'Marzo',
    'Abril',
    'Mayo',
    'Junio',
    'Julio',
    'Agosto',
    'Septiembre',
    'Octubre',
    'Noviembre',
    'Diciembre',
  ];

  const [modoFiltro, setModoFiltro] = useState<ModoFiltro>(
    (filters.tipo_filtro as ModoFiltro) ?? 'fechas',
  );
  const [mesInicio, setMesInicio] = useState(filters.mes_inicio ?? '1');
  const [anioInicio, setAnioInicio] = useState(
    filters.anio_inicio ?? anioActual.toString(),
  );
  const [mesFin, setMesFin] = useState(filters.mes_fin ?? '12');
  const [anioFin, setAnioFin] = useState(
    filters.anio_fin ?? anioActual.toString(),
  );
  const [anioSeleccionado, setAnioSeleccionado] = useState(
    filters.anio ?? anioActual.toString(),
  );

  const [exportando, setExportando] = useState(false);

  const contenidoRef = useRef<HTMLDivElement>(null);

  const chartRoedoresLineRef = useRef<HTMLDivElement>(null); // COMPARACION DE PESOS POR TRAMPA
  const chartRoedoresBarRef = useRef<HTMLDivElement>(null); //  VALORES POR TRAMPA
  const chartResumenTrampasRef = useRef<HTMLDivElement>(null); // RESUMEN

  const chartInsectosRef = useRef<HTMLDivElement>(null); // CHART TOTAL INSECTOS POR ESPECIE
  const chartEvolucionRef = useRef<HTMLDivElement>(null); // EVOLUCION INSECTOS POR FECHA
  const chartSeveridadRef = useRef<HTMLDivElement>(null); // SEVERIDAD

  const graficosPorMapaRefs = useRef<(HTMLDivElement | null)[]>([]);

  const totalesPorcentajes = (totales: TotalData[]) => {
    const data: any = {};
    totales.forEach((tot, index) => {
      // Sin cebo inicial el porcentaje no existe: evita NaN/Infinity en la tabla.
      const inicial = Number(tot.inicial_sum);
      data[index] = {
        mes: tot.mes,
        inicial_sum: tot.inicial_sum,
        inicial_por: (100).toFixed(2),
        merma_sum: tot.merma_sum,
        merma_por:
          inicial > 0 ? ((tot.merma_sum * 100) / inicial).toFixed(2) : '0.00',
        actual_sum: tot.actual_sum,
        actual_por:
          inicial > 0 ? ((tot.actual_sum * 100) / inicial).toFixed(2) : '0.00',
      };
    });

    return Object.values(data).map((d: any) => ({
      mes: d.mes,
      inicial_sum: d.inicial_sum,
      inicial_por: d.inicial_por,
      merma_sum: d.merma_sum,
      merma_por: d.merma_por,
      actual_sum: d.actual_sum,
      actual_por: d.actual_por,
    }));
  };

  const totalesPorcentajesValues = totalesPorcentajes(totales);

  /**
   * SEGUIMIENTOS
   */

  const totalSeguimientos = seguimientos.length;

  // Las tablas de roedores solo deben leer seguimientos de DESRATIZACION:
  // hay seguimientos de otros tipos con filas de roedores en cero (basura
  // histórica del modal) que inflan trampas/promedios si no se filtran.
  const seguimientosDesrat = seguimientos.filter(
    (s: any) => Number(s.tipo_seguimiento_id) === 1,
  );

  const resumen = Object.values(
    seguimientosDesrat
      .flatMap((s) => s.roedores)
      .reduce((acc: any, r: any) => {
        const tipo = r.trampa.trampa_tipo.nombre;
        const trampaId = r.trampa.id;

        if (!acc[tipo]) {
          acc[tipo] = {
            tipo,
            trampas: new Set(),
            capturas: 0,
          };
        }

        acc[tipo].trampas.add(trampaId);
        acc[tipo].capturas += Number(r.cantidad) ?? 0;

        return acc;
      }, {}),
  ).map((item: any) => {
    const trampas = item.trampas.size;
    const capturas = Number(item.capturas);

    const incidencia =
      trampas * seguimientosDesrat.length > 0
        ? ((capturas / (trampas * seguimientosDesrat.length)) * 100).toFixed(2)
        : 0;

    return {
      tipo: item.tipo,
      trampas,
      revisiones: seguimientosDesrat.length,
      capturas,
      incidencia,
    };
  });

  const total = resumen.reduce(
    (acc: any, item: any) => {
      acc.trampas += item.trampas;
      acc.capturas += Number(item.capturas);
      return acc;
    },
    { trampas: 0, capturas: 0 },
  );

  /**
   * DESRATIZACION DATOS
   */

  const resumenMeses = Object.values(
    seguimientosDesrat.reduce((acc: any, s: any) => {
      const fecha = new Date(s.created_at);

      const key = `${fecha.getFullYear()}-${fecha.getMonth() + 1}`;

      const mesTexto = fecha.toLocaleString('es-ES', {
        month: 'long',
        year: 'numeric',
      });

      if (!acc[key]) {
        acc[key] = {
          mes: mesTexto,
          seguimientos: 0,
          trampas: new Set(),
          capturas: 0,
        };
      }

      acc[key].seguimientos++;

      s.roedores.forEach((r: any) => {
        acc[key].trampas.add(r.trampa.id);
        acc[key].capturas += Number(r.cantidad) ?? 0;
      });

      return acc;
    }, {}),
  ).map((item: any) => {
    const trampas = item.trampas.size;
    const incidencia =
      trampas && item.seguimientos
        ? (
            (Number(item.capturas) / (trampas * item.seguimientos)) *
            100
          ).toFixed(2)
        : 0;

    return {
      mes: item.mes,
      seguimientos: item.seguimientos,
      trampas,
      capturas: Number(item.capturas),
      incidencia,
    };
  });

  const resumenPorAlmacen = (seguimientos: any[]) => {
    const almacenes: any = {};

    seguimientos.forEach((seg) => {
      const almacenId = seg.almacen.id;
      const almacenNombre = seg.almacen.nombre;

      if (!almacenes[almacenId]) {
        almacenes[almacenId] = {
          almacen: almacenNombre,
          seguimientos: 0,
          trampasSet: new Set(),
          capturas: 0,
        };
      }

      // contar seguimiento
      almacenes[almacenId].seguimientos += 1;

      seg.roedores.forEach((r: any) => {
        // contar trampa única
        almacenes[almacenId].trampasSet.add(r.trampa_id);

        // sumar capturas
        almacenes[almacenId].capturas += Number(r.cantidad) ?? 0;
      });
    });

    return Object.values(almacenes).map((a: any) => {
      const trampas = a.trampasSet.size;

      return {
        almacen: a.almacen,
        seguimientos: a.seguimientos,
        trampas: trampas,
        capturas: Number(a.capturas),
        incidencia:
          trampas > 0
            ? ((Number(a.capturas) / trampas) * 100).toFixed(2) + '%'
            : '0%',
      };
    });
  };

  const tablaAlmacenes = resumenPorAlmacen(seguimientosDesrat);

  const tablaCeboPorAlmacen = (seguimientos: any[]) => {
    const almacenes: any = {};

    seguimientos.forEach((seg) => {
      const almacenId = seg.almacen.id;
      const almacenNombre = seg.almacen.nombre;

      if (!almacenes[almacenId]) {
        almacenes[almacenId] = {
          almacen: almacenNombre,
          trampasSet: new Set(),
          ceboInicial: 0,
          merma: 0,
          ceboActual: 0,
          capturados: 0,
        };
      }

      seg.roedores.forEach((r: any) => {
        // guardar trampa única
        almacenes[almacenId].trampasSet.add(r.trampa_id);

        // sumar valores
        almacenes[almacenId].ceboInicial += Number(r.inicial) ?? 0;
        almacenes[almacenId].merma += Number(r.merma) ?? 0;
        almacenes[almacenId].ceboActual += Number(r.actual) ?? 0;
        almacenes[almacenId].capturados += Number(r.cantidad) ?? 0;
      });
    });

    return Object.values(almacenes).map((a: any) => ({
      almacen: a.almacen,
      trampas: a.trampasSet.size,
      ceboInicial: Number(a.ceboInicial),
      merma: Number(a.merma),
      ceboActual: Number(a.ceboActual),
      capturados: Number(a.capturados),
    }));
  };

  const tablaCebo = tablaCeboPorAlmacen(seguimientosDesrat);

  const tablaSanitariaPorAlmacen = (seguimientos: any[]) => {
    const almacenes: any = {};

    seguimientos.forEach((seg) => {
      const almacenId = seg.almacen.id;
      const almacenNombre = seg.almacen.nombre;

      if (!almacenes[almacenId]) {
        almacenes[almacenId] = {
          almacen: almacenNombre,
          tipos: {},
        };
      }

      seg.roedores.forEach((r: any) => {
        const tipo = r.trampa.trampa_tipo.nombre; // golpe / viva

        if (!almacenes[almacenId].tipos[tipo]) {
          almacenes[almacenId].tipos[tipo] = {
            trampasSet: new Set(),
            cebo_inicial: 0,
            merma: 0,
            cebo_actual: 0,
            capturados: 0,
          };
        }

        const data = almacenes[almacenId].tipos[tipo];

        // trampas únicas
        data.trampasSet.add(r.trampa_id);

        // sumatorias
        data.cebo_inicial += Number(r.inicial) ?? 0;
        data.merma += Number(r.merma) ?? 0;
        data.cebo_actual += Number(r.actual) ?? 0;
        data.capturados += Number(r.cantidad) ?? 0;
      });
    });

    const resultado: any[] = [];

    Object.values(almacenes).forEach((a: any) => {
      Object.entries(a.tipos).forEach(([tipo, data]: any) => {
        resultado.push({
          almacen: a.almacen,
          tipo: tipo.toUpperCase(),
          trampas: data.trampasSet.size,
          cebo_inicial: Number(data.cebo_inicial),
          merma: Number(data.merma),
          cebo_actual: Number(data.cebo_actual),
          capturados: Number(data.capturados),
        });
      });
    });

    return resultado;
  };

  const datosSanitarios = tablaSanitariaPorAlmacen(seguimientosDesrat);

  const totalesDatosSanitario = datosSanitarios.reduce(
    (acc: any, row: any) => {
      acc.trampas += row.trampas;
      acc.cebo_inicial += row.cebo_inicial;
      acc.merma += row.merma;
      acc.cebo_actual += row.cebo_actual;
      acc.capturados += row.capturados;
      return acc;
    },
    { trampas: 0, cebo_inicial: 0, merma: 0, cebo_actual: 0, capturados: 0 },
  );

  const tablaSanitariaPorSeguimiento = (seguimientos: any[]) => {
    const data: any = {};

    seguimientos.forEach((seg) => {
      // const seguimientoId = seg.id;
      const seguimientoId = seg.created_at;
      const almacenNombre = seg.almacen.nombre;

      if (!data[seguimientoId]) {
        data[seguimientoId] = {
          seguimiento: seguimientoId,
          almacen: almacenNombre,
          fecha: seg.fecha,
          tipos: {},
        };
      }

      seg.roedores.forEach((r: any) => {
        const tipo = r.trampa.trampa_tipo.nombre;

        if (!data[seguimientoId].tipos[tipo]) {
          data[seguimientoId].tipos[tipo] = {
            trampasSet: new Set(),
            cebo_inicial: 0,
            merma: 0,
            cebo_actual: 0,
            capturados: 0,
          };
        }

        const t = data[seguimientoId].tipos[tipo];

        // trampas únicas
        t.trampasSet.add(r.trampa_id);

        // sumatorias
        t.cebo_inicial += Number(r.inicial) ?? 0;
        t.merma += Number(r.merma) ?? 0;
        t.cebo_actual += Number(r.actual) ?? 0;
        t.capturados += Number(r.cantidad) ?? 0;
      });
    });

    const resultado: any[] = [];

    Object.values(data).forEach((s: any) => {
      Object.entries(s.tipos).forEach(([tipo, t]: any) => {
        resultado.push({
          seguimiento: s.seguimiento,
          almacen: s.almacen,
          fecha: s.fecha,
          tipo: tipo.toUpperCase(),
          trampas: t.trampasSet.size,
          cebo_inicial: Number(t.cebo_inicial),
          merma: Number(t.merma),
          cebo_actual: Number(t.cebo_actual),
          capturados: Number(t.capturados),
        });
      });
    });

    return resultado;
  };

  const datosSeguimiento = tablaSanitariaPorSeguimiento(seguimientosDesrat);

  const totalesSeguimiento = datosSeguimiento.reduce(
    (acc: any, row: any) => {
      acc.trampas += Number(row.trampas);
      acc.cebo_inicial += Number(row.cebo_inicial);
      acc.merma += Number(row.merma);
      acc.cebo_actual += Number(row.cebo_actual);
      acc.capturados += Number(row.capturados);
      return acc;
    },
    {
      trampas: 0,
      cebo_inicial: 0,
      merma: 0,
      cebo_actual: 0,
      capturados: 0,
    },
  );

  const tablaSeguimientoResumen = (seguimientos: any[]) => {
    const data: any = {};

    const seguimientosFiltrados = seguimientos.filter(
      (seg) => Number(seg.tipo_seguimiento_id) === 1, // ← solo DESRATIZACION
    );

    seguimientosFiltrados.forEach((seg) => {
      const seguimientoId = Number(seg.id);

      if (!data[seguimientoId]) {
        data[seguimientoId] = {
          seguimiento: seguimientoId,
          fecha: seg.created_at,
          almacen: seg.almacen.nombre,
          trampasSet: new Set(),
          cebo_inicial: 0,
          merma: 0,
          cebo_actual: 0,
          capturados: 0,
        };
      }

      seg.roedores.forEach((r: any) => {
        const d = data[seguimientoId];

        // trampas únicas
        d.trampasSet.add(r.trampa_id);

        // sumatorias
        d.cebo_inicial += Number(r.inicial) ?? 0;
        d.merma += Number(r.merma) ?? 0;
        d.cebo_actual += Number(r.actual) ?? 0;
        d.capturados += Number(r.cantidad) ?? 0;
      });
    });

    return Object.values(data).map((d: any) => ({
      seguimiento: d.seguimiento,
      fecha: d.fecha,
      almacen: d.almacen,
      trampas: d.trampasSet.size,
      cebo_inicial: Number(d.cebo_inicial),
      merma: Number(d.merma),
      cebo_actual: Number(d.cebo_actual),
      capturados: Number(d.capturados),
    }));
  };

  const datosSeguimientoResumen = tablaSeguimientoResumen(seguimientos);

  const totalesResumen = datosSeguimientoResumen.reduce(
    (acc: any, row: any) => {
      acc.trampas += Number(row.trampas);
      acc.cebo_inicial += Number(row.cebo_inicial);
      acc.merma += Number(row.merma);
      acc.cebo_actual += Number(row.cebo_actual);
      acc.capturados += Number(row.capturados);
      return acc;
    },
    {
      trampas: 0,
      cebo_inicial: 0,
      merma: 0,
      cebo_actual: 0,
      capturados: 0,
    },
  );

  const porcentajeMerma =
    totalesResumen.cebo_inicial > 0
      ? (totalesResumen.merma * 100) / totalesResumen.cebo_inicial
      : 0;

  const graficosPorAlmacen = Object.values(
    datosSeguimientoResumen.reduce((acc: any, row: any) => {
      if (!acc[row.almacen]) {
        acc[row.almacen] = {
          almacen: row.almacen,
          data: [],
        };
      }

      const porcentajeMerma =
        Number(row.cebo_inicial) > 0
          ? (Number(row.merma) * 100) / Number(row.cebo_inicial)
          : 0;

      acc[row.almacen].data.push({
        // row.seguimiento es el ID numérico; usarlo como Date daba 1/1/1970.
        fecha: new Date(row.fecha).toLocaleDateString('es-ES'),
        merma_porcentaje: Number(porcentajeMerma.toFixed(2)),
      });

      return acc;
    }, {}),
  );

  // Procesar datos de roedores
  // const datosRoedores = useMemo(() => {
  //   const datosPorFechaTrampa: {
  //     [key: string]: {
  //       fecha: string;
  //       trampa_id: number;
  //       inicial: number;
  //       merma: number;
  //       actual: number;
  //       observaciones: string[];
  //     };
  //   } = {};

  //   seguimientos.forEach((seg) => {
  //     const fecha = new Date(seg.created_at).toLocaleDateString();

  //     seg.roedores.forEach((roedor) => {
  //       const key = `${fecha}-${roedor.trampa_id}`;

  //       if (!datosPorFechaTrampa[key]) {
  //         datosPorFechaTrampa[key] = {
  //           fecha,
  //           trampa_id: roedor.trampa_id,
  //           inicial: 0,
  //           merma: 0,
  //           actual: 0,
  //           observaciones: [],
  //         };
  //       }

  //       datosPorFechaTrampa[key].inicial += roedor.inicial;
  //       datosPorFechaTrampa[key].merma += roedor.merma;
  //       datosPorFechaTrampa[key].actual += roedor.actual;

  //       if (roedor.observacion) {
  //         datosPorFechaTrampa[key].observaciones.push(roedor.observacion);
  //       }
  //     });
  //   });

  //   return Object.values(datosPorFechaTrampa)
  //     .map((item) => ({
  //       ...item,
  //       inicial: Math.round(item.inicial),
  //       merma: Math.round(item.merma),
  //       actual: Math.round(item.actual),
  //     }))
  //     .sort((a, b) => {
  //       if (a.fecha !== b.fecha) {
  //         return a.fecha.localeCompare(b.fecha);
  //       }
  //       return a.trampa_id - b.trampa_id;
  //     });
  // }, [seguimientos]);

  const datosRoedores = useMemo(() => {
    const datosPorTrampa: {
      [key: number]: {
        trampa_id: number;
        indent: string;
        mapa: string;
        inicial: number;
        merma: number;
        actual: number;
        observaciones: string[];
        retirada: boolean;
      };
    } = {};

    seguimientos
      .filter((seg) => Number(seg.tipo_seguimiento_id) === 1) // solo DESRATIZACION
      .forEach((seg) => {
        seg.roedores.forEach((roedor) => {
          const trampaId = Number(roedor.trampa_id);

          // Excluir viva (4) y pegajosa (5): no llevan cebo, sus pesos son
          // siempre cero y solo diluyen la tabla. Con "||" la condición era
          // una tautología y nunca excluía nada.
          if (
            Number(roedor.trampa.trampa_tipo_id) !== 4 &&
            Number(roedor.trampa.trampa_tipo_id) !== 5
          ) {
            if (!datosPorTrampa[trampaId]) {
              datosPorTrampa[trampaId] = {
                trampa_id: trampaId,
                indent: '',
                mapa: '',
                inicial: 0,
                merma: 0,
                actual: 0,
                observaciones: [],
                retirada: false,
              };
            }

            datosPorTrampa[trampaId].indent = roedor.trampa.identificador;
            datosPorTrampa[trampaId].mapa = roedor.trampa.mapa?.titulo ?? '';
            // Misma fuente que el aviso: sólo lo ocurrido dentro del período.
            datosPorTrampa[trampaId].retirada =
              (idsRetiradas?.cambio_tipo ?? []).includes(trampaId) ||
              (idsRetiradas?.retirada ?? []).includes(trampaId);

            datosPorTrampa[trampaId].inicial += Number(roedor.inicial);
            datosPorTrampa[trampaId].merma += Number(roedor.merma);
            datosPorTrampa[trampaId].actual += Number(roedor.actual);

            if (roedor.observacion) {
              datosPorTrampa[trampaId].observaciones.push(roedor.observacion);
            }
          }
        });
      });

    return Object.values(datosPorTrampa)
      .map((item) => ({
        ...item,
        inicial: Math.round(item.inicial),
        merma: Math.round(item.merma),
        actual: Math.round(item.actual),
      }))
      .sort((a, b) => {
        // Agrupa por mapa; dentro de cada mapa ordena por identificador (natural).
        const porMapa = a.mapa.localeCompare(b.mapa, undefined, {
          numeric: true,
          sensitivity: 'base',
        });
        if (porMapa !== 0) return porMapa;
        return a.indent.localeCompare(b.indent, undefined, {
          numeric: true,
          sensitivity: 'base',
        });
      });
  }, [seguimientos, idsRetiradas]);

  /**
   * Trampas del informe que salieron del mapa DENTRO del período, separadas en
   * cambios de tipo y retiros reales. Qué IDs entran en cada grupo lo decide el
   * backend (InformesController@trampasRetiradasEnPeriodo); aquí sólo se les
   * pone identificador y mapa para mostrarlos.
   *
   * Sus pesajes son válidos y se conservan en las tablas: el aviso existe para
   * explicar por qué el detalle no cuadra con el mapa actual, no para ocultarlo.
   */
  const trampasRetiradas = useMemo(() => {
    const setCambio = new Set(idsRetiradas?.cambio_tipo ?? []);
    const setRetiro = new Set(idsRetiradas?.retirada ?? []);
    const vistas = new Map<number, { identificador: string; mapa: string }>();
    const cambios = new Map<number, { identificador: string; mapa: string }>();
    const retiradas = new Map<
      number,
      { identificador: string; mapa: string }
    >();

    seguimientos
      .filter((seg) => Number(seg.tipo_seguimiento_id) === 1)
      .forEach((seg) => {
        seg.roedores.forEach((roedor) => {
          const t = roedor.trampa;
          if (!t) return;

          const info = {
            identificador: t.identificador,
            mapa: t.mapa?.titulo ?? '',
          };

          vistas.set(t.id, info);
          if (setCambio.has(t.id)) cambios.set(t.id, info);
          if (setRetiro.has(t.id)) retiradas.set(t.id, info);
        });
      });

    const ordenar = (
      m: Map<number, { identificador: string; mapa: string }>,
    ) =>
      [...m.values()].sort((a, b) => {
        const porMapa = a.mapa.localeCompare(b.mapa, undefined, {
          numeric: true,
          sensitivity: 'base',
        });
        if (porMapa !== 0) return porMapa;
        return a.identificador.localeCompare(b.identificador, undefined, {
          numeric: true,
          sensitivity: 'base',
        });
      });

    return {
      total: vistas.size,
      cambios: ordenar(cambios),
      retiradas: ordenar(retiradas),
      // Filas del detalle que ya no corresponden a una trampa del mapa actual.
      afectadas: cambios.size + retiradas.size,
    };
  }, [seguimientos, idsRetiradas]);

  const tablaSeguimientoResumenX = (seguimientos: any[]) => {
    const data: any = {};

    seguimientos.forEach((seg) => {
      const seguimientoId = seg.id;

      seg.roedores.forEach((r: any) => {
        const mapaId = r.trampa.mapa_id;
        const mapaTitulo = r.trampa.mapa.titulo;
        const key = `${seguimientoId}-${mapaId}`;

        if (!data[key]) {
          data[key] = {
            seguimiento: seguimientoId,
            fecha: seg.created_at, // ← agrega esto
            mapa: mapaTitulo,
            trampasSet: new Set(),
            cebo_inicial: 0,
            merma: 0,
            cebo_actual: 0,
            capturados: 0,
          };
        }

        const d = data[key];
        d.trampasSet.add(r.trampa_id);
        d.cebo_inicial += Number(r.inicial) ?? 0;
        d.merma += Number(r.merma) ?? 0;
        d.cebo_actual += Number(r.actual) ?? 0;
        d.capturados += Number(r.cantidad) ?? 0;
      });
    });

    return Object.values(data).map((d: any) => ({
      seguimiento: d.seguimiento,
      fecha: d.fecha, // ← agrega esto
      mapa: d.mapa,
      trampas: d.trampasSet.size,
      cebo_inicial: Number(d.cebo_inicial),
      merma: Number(d.merma),
      cebo_actual: Number(d.cebo_actual),
      capturados: Number(d.capturados),
    }));
  };

  const datosSeguimientoResumenX = tablaSeguimientoResumenX(seguimientosDesrat);

  const graficosPorMapa = Object.values(
    datosSeguimientoResumenX.reduce((acc: any, row: any) => {
      const key = row.mapa;

      if (!acc[key]) {
        acc[key] = {
          mapa: row.mapa,
          data: [],
        };
      }

      const porcentajeMerma =
        row.cebo_inicial > 0 ? (row.merma * 100) / row.cebo_inicial : 0;
      const porcentajeActual =
        row.cebo_inicial > 0 ? (row.cebo_actual * 100) / row.cebo_inicial : 0;

      acc[key].data.push({
        fecha: new Date(row.fecha).toLocaleDateString('es-ES'),
        fechaRaw: new Date(row.fecha), // ← para ordenar
        merma_porcentaje: Number(porcentajeMerma.toFixed(2)),
        total_porcentaje: Number(100),
        actual_porcentaje: Number(porcentajeActual.toFixed(2)),
      });

      return acc;
    }, {}),
  ).map((item: any) => ({
    ...item,
    data: item.data
      .sort((a: any, b: any) => a.fechaRaw - b.fechaRaw) // ← orden ascendente
      .map(({ fechaRaw, ...rest }: any) => rest), // ← elimina fechaRaw del resultado
  }));

  /**
   * INSECTOCUTORES DATOS
   */
  // Procesar datos de insectocutores
  const datosInsectocutores = useMemo(() => {
    // Filtrar solo tipo_seguimiento_id = 3
    const seguimientosFiltrados = seguimientos.filter(
      (seg) => Number(seg.tipo_seguimiento_id) === 3,
    );
    const especiesSet = new Set<string>();
    seguimientosFiltrados.forEach((seg) => {
      seg.insectocutores.forEach((ins) => {
        especiesSet.add(ins.especie.nombre);
      });
    });
    const especies = Array.from(especiesSet).sort();

    const datosPorFecha = seguimientosFiltrados.map((seg) => {
      // "fecha" lleva el id para ser clave única (dos visitas el mismo día);
      // "fechaLabel" es lo que se muestra en tablas y ejes.
      const fecha = `${new Date(seg.created_at).toLocaleDateString()}-${seg.id}`;
      const fechaLabel = new Date(seg.created_at).toLocaleDateString('es-ES');
      const cantidadesPorEspecie: { [especie: string]: number } = {};

      especies.forEach((esp) => {
        cantidadesPorEspecie[esp] = 0;
      });

      seg.insectocutores.forEach((ins) => {
        cantidadesPorEspecie[ins.especie.nombre] += Number(ins.cantidad);
      });

      return { fecha, fechaLabel, cantidades: cantidadesPorEspecie };
    });

    const totales: { [especie: string]: number } = {};
    especies.forEach((esp) => {
      totales[esp] = datosPorFecha.reduce(
        (sum, dato) => sum + Number(dato.cantidades[esp]),
        0,
      );
    });

    const totalSeguimientos = seguimientosFiltrados.length || 1;

    // Promedios de valores brutos (incidencia)
    const promedios: { [especie: string]: number } = {};
    especies.forEach((esp) => {
      promedios[esp] = totales[esp] / totalSeguimientos;
    });

    // Totales y promedios de severidad (valores ya divididos entre 3 por fila)
    const totalesSev: { [especie: string]: number } = {};
    const promediosSev: { [especie: string]: number } = {};
    especies.forEach((esp) => {
      totalesSev[esp] = datosPorFecha.reduce(
        (sum, dato) => sum + Math.floor(Number(dato.cantidades[esp]) / 3),
        0,
      );
      promediosSev[esp] = totalesSev[esp] / totalSeguimientos;
    });

    return {
      especies,
      datosPorFecha,
      totales,
      promedios,
      totalesSev,
      promediosSev,
    };
  }, [seguimientos]);

  const totalFechas = datosInsectocutores.datosPorFecha.length || 1;

  // const dataPromedio = datosInsectocutores.datosPorFecha.map((dato) => ({
  //   fecha: dato.fecha,
  //   ...Object.fromEntries(
  //     Object.entries(dato.cantidades).map(([key, value]) => [
  //       key,
  //       value / totalFechas,
  //     ]),
  //   ),
  // }));

  const dataSeveridadPivot = useMemo(() => {
    const fechas = datosInsectocutores.datosPorFecha.map((d) => d.fecha);

    return datosInsectocutores.especies.map((especie) => {
      const row: any = { especie };

      datosInsectocutores.datosPorFecha.forEach((dato) => {
        // row[dato.fecha] = Math.floor(
        //   dato.cantidades[especie] /
        //     (datosInsectocutores.datosPorFecha.length || 1),
        // );
        row[dato.fecha] = Math.floor(Number(dato.cantidades[especie]) / 3);
      });

      return row;
    });
  }, [datosInsectocutores]);

  // const seguimientosRoedores = useMemo(() => {
  //   const seguimientosFiltrados = seguimientos.filter(
  //     (seg) => seg.tipo_seguimiento_id !== 3,
  //   );
  //   return seguimientosFiltrados;
  // }, [seguimientos]);

  const incidenciaTotal =
    total.trampas * seguimientosDesrat.length > 0
      ? (
          (total.capturas / (total.trampas * seguimientosDesrat.length)) *
          100
        ).toFixed(2)
      : 0;
  const colorIncidencia = (valor: number) => {
    if (valor === 0) return 'text-green-600';
    if (valor < 5) return 'text-yellow-600';
    return 'text-red-600';
  };

  // Configuración de colores para gráficos de insectocutores
  const chartConfigInsectos = useMemo(() => {
    const config: ChartConfig = {};
    datosInsectocutores.especies.forEach((especie, index) => {
      config[especie] = {
        label: especie,
        color: `hsl(${(index * 160) / datosInsectocutores.especies.length}, 60%, 48%)`,
      };
    });
    return config;
  }, [datosInsectocutores.especies]);

  // Configuración de colores para gráficos de roedores
  const chartConfigRoedores: ChartConfig = {
    inicial: {
      label: 'Inicial',
      color: '#2563eb', // azul
    },
    merma: {
      label: 'Merma',
      color: '#f59e0b', // ámbar
    },
    actual: {
      label: 'Actual',
      color: '#16a34a', // verde
    },
  };

  /**
   * ----------------------------------------------------------------------------
   * FUNCIONES
   * ----------------------------------------------------------------------------
   */
  const buscar = () => {
    let fi = fechaInicio;
    let ff = fechaFin;
    const extraParams: Record<string, string | number | undefined> = {
      tipo_filtro: modoFiltro,
    };

    if (modoFiltro === 'meses') {
      const y1 = parseInt(anioInicio);
      const m1 = parseInt(mesInicio);
      const y2 = parseInt(anioFin);
      const m2 = parseInt(mesFin);
      fi = `${y1}-${String(m1).padStart(2, '0')}-01`;
      const ultimoDia = new Date(y2, m2, 0).getDate();
      ff = `${y2}-${String(m2).padStart(2, '0')}-${ultimoDia}`;
      extraParams.mes_inicio = mesInicio;
      extraParams.anio_inicio = anioInicio;
      extraParams.mes_fin = mesFin;
      extraParams.anio_fin = anioFin;
    } else if (modoFiltro === 'anio') {
      fi = `${anioSeleccionado}-01-01`;
      ff = `${anioSeleccionado}-12-31`;
      extraParams.anio = anioSeleccionado;
    }

    router.get(
      '/informes',
      {
        empresa_id: empresaId,
        almacen_id: almacenId,
        fecha_inicio: fi,
        fecha_fin: ff,
        buscar: 1,
        ...extraParams,
      },
      {
        preserveState: true,
        replace: true,
      },
    );
  };

  const puedesBuscar = (() => {
    if (!empresaId || !almacenId) return false;
    if (modoFiltro === 'fechas') return !!(fechaInicio && fechaFin);
    if (modoFiltro === 'meses')
      return !!(mesInicio && anioInicio && mesFin && anioFin);
    if (modoFiltro === 'anio') return !!anioSeleccionado;
    return false;
  })();

  const formatearFecha = (fechaStr: string) => {
    if (!fechaStr) return '';
    const [y, m, d] = fechaStr.split('-').map(Number);
    return new Date(y, m - 1, d).toLocaleDateString('es-ES');
  };

  const periodoLabel = (() => {
    if (
      modoFiltro === 'meses' &&
      filters.mes_inicio &&
      filters.anio_inicio &&
      filters.mes_fin &&
      filters.anio_fin
    ) {
      const mi = parseInt(filters.mes_inicio) - 1;
      const mf = parseInt(filters.mes_fin) - 1;
      return `${mesesNombres[mi]} ${filters.anio_inicio} - ${mesesNombres[mf]} ${filters.anio_fin}`;
    }
    if (modoFiltro === 'anio' && filters.anio) {
      return `Año ${filters.anio}`;
    }
    return `${formatearFecha(filters.fecha_inicio ?? fechaInicio)} - ${formatearFecha(filters.fecha_fin ?? fechaFin)}`;
  })();

  // 3. En onEmpresaChange, no resetees las fechas si ya tenías filtros activos
  const onEmpresaChange = (value: string) => {
    setEmpresaId(value);
    setAlmacenId(''); // string vacío, no undefined

    router.get(
      '/informes',
      { empresa_id: value },
      {
        preserveState: true,
        replace: true,
        only: ['almacenes', 'filters'],
      },
    );
  };

  // 1. Agrega este useEffect para sincronizar cuando cambien los filters
  useEffect(() => {
    setEmpresaId(filters.empresa_id?.toString() ?? '');
    setAlmacenId(filters.almacen_id?.toString() ?? '');
    setFechaInicio(filters.fecha_inicio ?? '');
    setFechaFin(filters.fecha_fin ?? '');
    setModoFiltro((filters.tipo_filtro as ModoFiltro) ?? 'fechas');
    setMesInicio(filters.mes_inicio ?? '1');
    setAnioInicio(filters.anio_inicio ?? anioActual.toString());
    setMesFin(filters.mes_fin ?? '12');
    setAnioFin(filters.anio_fin ?? anioActual.toString());
    setAnioSeleccionado(filters.anio ?? anioActual.toString());
  }, [
    filters.empresa_id,
    filters.almacen_id,
    filters.fecha_inicio,
    filters.fecha_fin,
    filters.tipo_filtro,
    filters.mes_inicio,
    filters.anio_inicio,
    filters.mes_fin,
    filters.anio_fin,
    filters.anio,
  ]);

  const onAlmacenChange = (value: string) => {
    setAlmacenId(value);

    router.get(
      '/informes',
      {
        empresa_id: empresaId,
        almacen_id: value,
      },
      {
        preserveState: true,
        replace: true,
        only: ['almacenes', 'filters'],
      },
    );
  };

  const onFechaChange = (inicio: string, fin: string) => {
    setFechaInicio(inicio);
    setFechaFin(fin);

    router.get(
      '/informes',
      {
        empresa_id: empresaId,
        almacen_id: almacenId,
        fecha_inicio: inicio || undefined,
        fecha_fin: fin || undefined,
      },
      {
        preserveState: true,
        replace: true,
        only: ['filters'],
      },
    );
  };

  const exportarPDF = async () => {
    if (!contenidoRef.current) return;

    setExportando(true);

    try {
      const elemento = contenidoRef.current;

      // Clonar el elemento para no afectar el DOM original
      const clone = elemento.cloneNode(true) as HTMLElement;

      // Convertir colores (evita problemas con OKLCH de Tailwind/Shadcn)
      const convertirColores = (el: HTMLElement) => {
        const computedStyle = window.getComputedStyle(el);

        if (computedStyle.backgroundColor) {
          el.style.backgroundColor = computedStyle.backgroundColor;
        }

        if (computedStyle.color) {
          el.style.color = computedStyle.color;
        }

        if (computedStyle.borderColor) {
          el.style.borderColor = computedStyle.borderColor;
        }

        if (computedStyle.fill && computedStyle.fill !== 'none') {
          el.style.fill = computedStyle.fill;
        }

        if (computedStyle.stroke && computedStyle.stroke !== 'none') {
          el.style.stroke = computedStyle.stroke;
        }

        Array.from(el.children).forEach((child) =>
          convertirColores(child as HTMLElement),
        );
      };

      convertirColores(clone);

      // Agregar clon temporal
      // clone.style.position = 'absolute';
      // clone.style.left = '-9999px';
      // clone.style.top = '0';

      clone.style.position = 'fixed';
      clone.style.left = '0';
      clone.style.top = '0';
      clone.style.zIndex = '-1';
      clone.style.width = elemento.offsetWidth + 'px';
      clone.style.background = '#ffffff';

      document.body.appendChild(clone);

      // Import dinámico: jspdf + html-to-image pesan ~600 kB y sólo hacen
      // falta al exportar, no al abrir la pantalla de informes.
      const [htmlToImage, { default: jsPDF }] = await Promise.all([
        import('html-to-image'),
        import('jspdf'),
      ]);

      // 🔹 Aquí reemplazamos html2canvas por html-to-image
      const imgData = await htmlToImage.toPng(clone, {
        pixelRatio: 2,
        backgroundColor: '#ffffff',

        // IMPORTANTE: evita el error de fonts cross-origin
        skipFonts: true,

        cacheBust: true,
      });

      // remover clon
      document.body.removeChild(clone);

      // Crear PDF
      const pdf = new jsPDF({
        orientation: 'landscape', // landscape, portrait
        unit: 'mm',
        format: 'a4',
      });

      const img = new Image();
      img.src = imgData;

      await new Promise((resolve) => {
        img.onload = resolve;
      });

      const imgWidth = 297;
      const pageHeight = 210;
      const imgHeight = (img.height * imgWidth) / img.width;

      let heightLeft = imgHeight;
      let position = 0;

      pdf.addImage(imgData, 'PNG', 0, position, imgWidth, imgHeight);
      heightLeft -= pageHeight;

      while (heightLeft > 0) {
        position = heightLeft - imgHeight;
        pdf.addPage();
        pdf.addImage(imgData, 'PNG', 0, position, imgWidth, imgHeight);
        heightLeft -= pageHeight;
      }

      const empresaNombre =
        empresas.find((e) => e.id === Number(empresaId))?.nombre || 'empresa';

      const almacenNombre =
        almacenes.find((a) => a.id === Number(almacenId))?.nombre || 'almacen';

      const nombreArchivo = `informe_${empresaNombre}_${almacenNombre}_${fechaInicio}_${fechaFin}.pdf`;

      pdf.save(nombreArchivo);
    } catch (error) {
      console.error('Error al exportar PDF:', error);
      notificarError('Error al generar el PDF. Por favor, intente nuevamente.');
    } finally {
      setExportando(false);
    }
  };

  const exportarWord = async () => {
    if (!contenidoRef.current) return;

    setExportando(true);

    // Guardamos la posición de scroll: capturar cada gráfico requiere hacerle
    // scrollIntoView, lo que deja la página desplazada hasta el último gráfico.
    // Al terminar restauramos la posición para que el scroll no "salte" solo.
    const scrollXPrevio = window.scrollX;
    const scrollYPrevio = window.scrollY;

    try {
      // Se carga una sola vez aquí, no en cada captura de gráfico.
      const htmlToImage = await import('html-to-image');

      const seguimientoIds = seguimientos.map((s) => s.id);

      const capturarGrafico = async (ref: HTMLDivElement | null) => {
        if (!ref) return null;
        ref.scrollIntoView({ block: 'nearest', behavior: 'instant' });
        await new Promise<void>((resolve) =>
          requestAnimationFrame(() => requestAnimationFrame(resolve)),
        );
        return htmlToImage.toPng(ref, {
          pixelRatio: 2,
          backgroundColor: '#ffffff',
          skipFonts: true,
          width: ref.offsetWidth,
          height: ref.offsetHeight,
        });
      };

      const chart1 = await capturarGrafico(chartInsectosRef.current);
      const chart2 = await capturarGrafico(chartEvolucionRef.current);
      const chart3 = await capturarGrafico(chartRoedoresLineRef.current);
      const chart4 = await capturarGrafico(chartRoedoresBarRef.current);
      const chart5 = await capturarGrafico(chartSeveridadRef.current);
      const chart6 = await capturarGrafico(chartResumenTrampasRef.current);

      // Gráficos por mapa — secuencial para que scrollIntoView funcione correctamente
      const chartsPorMapa: (string | null)[] = [];
      for (let i = 0; i < graficosPorMapa.length; i++) {
        chartsPorMapa.push(
          await capturarGrafico(graficosPorMapaRefs.current[i] ?? null),
        );
      }

      // router.post('/informes/exportar-word', {
      //   chart1,
      //   chart2,
      //   chart3,
      //   chart4,
      //   chart5,
      //   chart6,
      //   // 👇 NUEVO
      //   charts_por_mapa: chartsPorMapa,
      //   charts_por_mapa_titulos: graficosPorMapa.map((g: any) => g.mapa), // ← títulos
      //   seguimiento_ids: seguimientoIds,
      //   datosInsectocutores,
      //   datosRoedores,
      //   empresa_id: empresaId,
      //   almacen_id: almacenId,
      //   fecha_inicio: fechaInicio,
      //   fecha_fin: fechaFin,
      // });

      await axios.post('/informes/exportar-word', {
        chart1,
        chart2,
        chart3,
        chart4,
        chart5,
        chart6,
        charts_por_mapa: chartsPorMapa,
        charts_por_mapa_titulos: graficosPorMapa.map((g: any) => g.mapa),
        seguimiento_ids: seguimientoIds,
        datosInsectocutores,
        datosRoedores,
        empresa_id: empresaId,
        almacen_id: almacenId,
        fecha_inicio: fechaInicio,
        fecha_fin: fechaFin,
      });

      window.open('/informes/exportar-word-download');
    } catch (error) {
      console.error(error);
      notificarError('Error al generar Word');
    } finally {
      setExportando(false);
      // Restaura la posición de scroll previa al capturado de gráficos.
      window.scrollTo(scrollXPrevio, scrollYPrevio);
    }
  };

  // const exportarWord = async () => {
  //   if (!contenidoRef.current) return;

  //   setExportando(true);

  //   try {
  //     const seguimientoIds = seguimientos.map((s) => s.id);

  //     const capturarGrafico = async (ref: HTMLDivElement | null) => {
  //       if (!ref) return null;
  //       return await htmlToImage.toPng(ref, {
  //         pixelRatio: 2,
  //         backgroundColor: '#ffffff',
  //         skipFonts: true,
  //       });
  //     };

  //     const [chart1, chart2, chart3, chart4, chart5, chart6] =
  //       await Promise.all([
  //         capturarGrafico(chartInsectosRef.current),
  //         capturarGrafico(chartEvolucionRef.current),
  //         capturarGrafico(chartRoedoresLineRef.current),
  //         capturarGrafico(chartRoedoresBarRef.current),
  //         capturarGrafico(chartSeveridadRef.current),
  //         capturarGrafico(chartResumenTrampasRef.current),
  //       ]);

  //     const chartsPorMapa = await Promise.all(
  //       graficosPorMapaRefs.current.map((ref) => capturarGrafico(ref)),
  //     );

  //     // Obtener el token CSRF desde la meta tag de Laravel
  //     const csrfToken = (
  //       document.querySelector('meta[name="csrf-token"]') as HTMLMetaElement
  //     )?.content;

  //     const response = await fetch('/informes/exportar-word', {
  //       method: 'POST',

  //       body: JSON.stringify({
  //         chart1,
  //         chart2,
  //         chart3,
  //         chart4,
  //         chart5,
  //         chart6,
  //         charts_por_mapa: chartsPorMapa,
  //         charts_por_mapa_titulos: graficosPorMapa.map((g: any) => g.mapa),
  //         seguimiento_ids: seguimientoIds,
  //         datosInsectocutores,
  //         datosRoedores,
  //         empresa_id: empresaId,
  //         almacen_id: almacenId,
  //         fecha_inicio: fechaInicio,
  //         fecha_fin: fechaFin,
  //       }),
  //     });

  //     if (!response.ok) {
  //       throw new Error(`Error del servidor: ${response.status}`);
  //     }

  //     window.open('/informes/exportar-word-download');
  //   } catch (error) {
  //     console.error(error);
  //     alert('Error al generar Word');
  //   } finally {
  //     setExportando(false);
  //   }
  // };

  // COLORES
  const coloresRoedores = {
    inicial: {
      label: 'inicial',
      color: '#2563eb', // azul — cebo inicial
    },
    merma: {
      label: 'merma',
      color: '#f59e0b', // ámbar — merma / consumo
    },
    actual: {
      label: 'actual',
      color: '#16a34a', // verde — cebo actual (lo que queda)
    },
  };

  const coloresInsectos = {
    mosquito: '#f79647',
    mosca: '#33558b',
    polilla: '#4aacc5',
  };

  // Estilo compartido para TODOS los gráficos del informe:
  // - fondo en degradado (claro/oscuro)
  // - más ancho (w-full) y más alto para mejor proporción
  // - ejes, etiquetas y valores más oscuros, gruesos y grandes (más legibles)
  // Nota: estas clases también se capturan con html-to-image al exportar a Word,
  // por lo que el degradado y la tipografía mejorada aparecen también en el informe.
  const chartClass = [
    'h-[380px] w-full max-w-[800px] rounded-2xl border p-5 shadow-sm',
    'bg-gradient-to-br from-sky-50 via-white to-violet-50',
    'border-slate-200/70 dark:border-slate-700',
    'dark:bg-gradient-to-br dark:from-slate-800 dark:via-slate-900 dark:to-slate-800',
    // Números de los ejes (ticks): oscuros, semibold y más grandes
    '[&_.recharts-cartesian-axis-tick_text]:fill-slate-700 [&_.recharts-cartesian-axis-tick_text]:font-semibold [&_.recharts-cartesian-axis-tick_text]:[font-size:13px]',
    'dark:[&_.recharts-cartesian-axis-tick_text]:fill-slate-200',
    // Títulos de ejes: oscuros, negrita y grandes
    '[&_.recharts-label]:fill-slate-800 [&_.recharts-label]:font-bold [&_.recharts-label]:[font-size:14px]',
    'dark:[&_.recharts-label]:fill-slate-100',
    // Valores sobre barras/líneas (LabelList): más pequeños para no saturar
    // (selector más específico que .recharts-label → gana sobre lo de arriba)
    '[&_.recharts-label-list_.recharts-label]:!font-semibold [&_.recharts-label-list_.recharts-label]:![font-size:10px] [&_.recharts-label-list_.recharts-label]:fill-slate-700',
    'dark:[&_.recharts-label-list_.recharts-label]:fill-slate-200',
    // Leyenda más visible
    '[&_.recharts-legend-item-text]:!text-slate-700 [&_.recharts-legend-item-text]:font-medium',
    'dark:[&_.recharts-legend-item-text]:!text-slate-200',
    // Líneas de los ejes más suaves
    '[&_.recharts-cartesian-axis-line]:stroke-slate-300 [&_.recharts-cartesian-axis-tick-line]:stroke-slate-300',
  ].join(' ');

  // Margen del área de trazado. El `top` holgado evita que las etiquetas de
  // valor (position="top") se recorten cuando la barra llega al máximo
  // (p. ej. 100 con dominio [0,100]); el `right` deja aire a la última barra.
  const chartMargin = { top: 28, right: 16, bottom: 4, left: 4 };

  // Filtra los datos antes del renderizado del gráfico
  const datosFiltrados = datosRoedores.filter((item) => {
    // Muestra la trampa solo si al menos uno de los valores tiene dato
    return (
      (item.inicial !== null &&
        item.inicial !== undefined &&
        item.inicial !== 0) || // quita el !== 0 si el 0 es un valor válido para ti
      (item.merma !== null && item.merma !== undefined && item.merma !== 0) ||
      (item.actual !== null && item.actual !== undefined && item.actual !== 0)
    );
  });

  // Estrategia anti-solapamiento: las etiquetas de valor sobre las barras/puntos
  // solo se muestran cuando hay pocos elementos. Con más, se ocultan (el valor
  // sigue disponible en el tooltip al pasar el cursor). Ajusta MAX_LABELS a gusto.
  const MAX_LABELS = 8;
  const showLabelsRoedores = datosFiltrados.length <= MAX_LABELS;
  const showLabelsResumen = totalesPorcentajesValues.length <= 12;
  const showLabelsEvolucion =
    datosInsectocutores.datosPorFecha.length <= MAX_LABELS;
  const showLabelsSeveridad =
    datosInsectocutores.datosPorFecha.length <= MAX_LABELS;

  return (
    <AppLayout breadcrumbs={[{ title: 'Informes', href: '/informes' }]}>
      <Head title="Informes" />

      <div className="mx-auto max-w-[1400px] space-y-6 p-6">
        {/* *********** SECCION BUSQUEDA ************************** */}
        <div className="space-y-4 rounded-xl border border-slate-200 bg-white p-5 shadow-sm">
          <h2 className="text-lg font-semibold text-slate-900">
            Generar informe
          </h2>
          {/* Empresa */}
          <Label>Seleccione una empresa</Label>
          <Select value={empresaId} onValueChange={onEmpresaChange}>
            <SelectTrigger>
              <SelectValue placeholder="Seleccione empresa" />
            </SelectTrigger>
            <SelectContent>
              {empresas.map((e) => (
                <SelectItem key={e.id} value={String(e.id)}>
                  {e.nombre}
                </SelectItem>
              ))}
            </SelectContent>
          </Select>
          {/* Almacén */}
          <Label>Seleccione un almacen</Label>
          <Select
            value={almacenId}
            // onValueChange={setAlmacenId}
            onValueChange={onAlmacenChange}
            disabled={!empresaId}
          >
            <SelectTrigger>
              <SelectValue placeholder="Seleccione almacén" />
            </SelectTrigger>
            <SelectContent>
              {almacenes.map((a) => (
                <SelectItem key={a.id} value={String(a.id)}>
                  {a.nombre}
                </SelectItem>
              ))}
            </SelectContent>
          </Select>
          {/* Tipo de filtro */}
          <div>
            <Label>Tipo de período</Label>
            <div className="mt-2 flex gap-6">
              {(['fechas', 'meses', 'anio'] as const).map((modo) => (
                <label
                  key={modo}
                  className="flex cursor-pointer items-center gap-2 text-sm"
                >
                  <input
                    type="radio"
                    value={modo}
                    checked={modoFiltro === modo}
                    onChange={() => setModoFiltro(modo)}
                    className="accent-primary"
                  />
                  {modo === 'fechas'
                    ? 'Rango de fechas'
                    : modo === 'meses'
                      ? 'Rango de meses'
                      : 'Por año'}
                </label>
              ))}
            </div>
          </div>

          {/* Filtro: Rango de fechas */}
          {modoFiltro === 'fechas' && (
            <div className="grid grid-cols-1 gap-4 sm:grid-cols-2">
              <div>
                <Label>Fecha inicial</Label>
                <Input
                  type="date"
                  value={fechaInicio}
                  onChange={(e) => onFechaChange(e.target.value, fechaFin)}
                />
              </div>
              <div>
                <Label>Fecha final</Label>
                <Input
                  type="date"
                  value={fechaFin}
                  onChange={(e) => onFechaChange(fechaInicio, e.target.value)}
                />
              </div>
            </div>
          )}

          {/* Filtro: Rango de meses */}
          {modoFiltro === 'meses' && (
            <div className="grid grid-cols-1 gap-4 sm:grid-cols-2">
              <div>
                <Label>Mes inicio</Label>
                <div className="flex gap-2">
                  <Select value={mesInicio} onValueChange={setMesInicio}>
                    <SelectTrigger className="flex-1">
                      <SelectValue placeholder="Mes" />
                    </SelectTrigger>
                    <SelectContent>
                      {mesesNombres.map((nombre, idx) => (
                        <SelectItem key={idx + 1} value={String(idx + 1)}>
                          {nombre}
                        </SelectItem>
                      ))}
                    </SelectContent>
                  </Select>
                  <Select value={anioInicio} onValueChange={setAnioInicio}>
                    <SelectTrigger className="w-[100px]">
                      <SelectValue placeholder="Año" />
                    </SelectTrigger>
                    <SelectContent>
                      {aniosDisponibles.map((a) => (
                        <SelectItem key={a} value={a}>
                          {a}
                        </SelectItem>
                      ))}
                    </SelectContent>
                  </Select>
                </div>
              </div>
              <div>
                <Label>Mes fin</Label>
                <div className="flex gap-2">
                  <Select value={mesFin} onValueChange={setMesFin}>
                    <SelectTrigger className="flex-1">
                      <SelectValue placeholder="Mes" />
                    </SelectTrigger>
                    <SelectContent>
                      {mesesNombres.map((nombre, idx) => (
                        <SelectItem key={idx + 1} value={String(idx + 1)}>
                          {nombre}
                        </SelectItem>
                      ))}
                    </SelectContent>
                  </Select>
                  <Select value={anioFin} onValueChange={setAnioFin}>
                    <SelectTrigger className="w-[100px]">
                      <SelectValue placeholder="Año" />
                    </SelectTrigger>
                    <SelectContent>
                      {aniosDisponibles.map((a) => (
                        <SelectItem key={a} value={a}>
                          {a}
                        </SelectItem>
                      ))}
                    </SelectContent>
                  </Select>
                </div>
              </div>
            </div>
          )}

          {/* Filtro: Por año */}
          {modoFiltro === 'anio' && (
            <div className="w-[200px]">
              <Label>Año</Label>
              <Select
                value={anioSeleccionado}
                onValueChange={setAnioSeleccionado}
              >
                <SelectTrigger>
                  <SelectValue placeholder="Seleccione año" />
                </SelectTrigger>
                <SelectContent>
                  {aniosDisponibles.map((a) => (
                    <SelectItem key={a} value={a}>
                      {a}
                    </SelectItem>
                  ))}
                </SelectContent>
              </Select>
            </div>
          )}

          {/* Botones */}
          <div className="flex flex-wrap gap-3 pt-2">
            <Button
              onClick={buscar}
              disabled={!puedesBuscar}
              className="w-full sm:w-auto sm:min-w-[200px]"
            >
              Buscar
            </Button>

            {seguimientos.length > 0 && (
              <>
                <Button
                  onClick={exportarPDF}
                  disabled={exportando}
                  className="bg-red-800 text-white"
                >
                  {exportando ? (
                    'Exportando...'
                  ) : (
                    <>
                      <Download className="mr-2 h-4 w-4" />
                      Exportar PDF
                    </>
                  )}
                </Button>
                {puedeExportarWord && (
                  <Button
                    onClick={exportarWord}
                    disabled={exportando}
                    className="bg-blue-800 text-white"
                  >
                    {exportando ? (
                      'Exportando...'
                    ) : (
                      <>
                        <Download className="mr-2 h-4 w-4" />
                        Exportar Word
                      </>
                    )}
                  </Button>
                )}
              </>
            )}
          </div>
        </div>

        {/* *********** SECCION ARCHIVOS WORD ************************** */}
        <div className="space-y-4 rounded-lg border border-slate-200 p-4">
          <h2 className="text-lg font-semibold text-slate-900">
            Informes Word
          </h2>

          {/* Formulario de subida — solo admin/superadmin */}
          {esAdminOSuperadmin && (
            <div className="flex flex-wrap items-end gap-3 rounded-md bg-slate-50 p-3">
              <div className="min-w-[180px] flex-1">
                <Label>Empresa</Label>
                <Select
                  value={empresaArchivoId}
                  onValueChange={setEmpresaArchivoId}
                >
                  <SelectTrigger>
                    <SelectValue placeholder="Seleccione empresa" />
                  </SelectTrigger>
                  <SelectContent>
                    {empresas.map((e) => (
                      <SelectItem key={e.id} value={String(e.id)}>
                        {e.nombre}
                      </SelectItem>
                    ))}
                  </SelectContent>
                </Select>
              </div>
              <div className="min-w-[220px] flex-1">
                <Label>Archivo Word (.docx)</Label>
                <Input
                  type="file"
                  accept=".docx,.doc"
                  onChange={(e) =>
                    setArchivoSeleccionado(e.target.files?.[0] ?? null)
                  }
                />
              </div>
              <Button
                onClick={subirArchivo}
                disabled={
                  subiendoArchivo || !archivoSeleccionado || !empresaArchivoId
                }
                className="bg-blue-700 text-white"
              >
                <Upload className="mr-2 h-4 w-4" />
                {subiendoArchivo ? 'Subiendo...' : 'Subir'}
              </Button>
            </div>
          )}

          {/* Tabla de archivos */}
          {archivos.length > 0 ? (
            <div className="overflow-x-auto rounded-lg border border-slate-200">
              <Table className={tableStyles.table}>
                <TableHeader>
                  <TableRow className={tableStyles.header.row}>
                    <TableHead className={tableStyles.header.cell}>
                      Empresa
                    </TableHead>
                    <TableHead className={tableStyles.header.cell}>
                      Archivo
                    </TableHead>
                    <TableHead className={tableStyles.header.cell}>
                      Subido por
                    </TableHead>
                    <TableHead className={tableStyles.header.cell}>
                      Fecha
                    </TableHead>
                    <TableHead className={tableStyles.header.cell}>
                      Acciones
                    </TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {archivos.map((a, idx) => (
                    <TableRow
                      key={a.id}
                      className={tableStyles.row(idx % 2 === 0)}
                    >
                      <TableCell className={tableStyles.cell}>
                        {a.empresa.nombre}
                      </TableCell>
                      <TableCell className={tableStyles.cell}>
                        {a.nombre_original}
                      </TableCell>
                      <TableCell className={tableStyles.cell}>
                        {a.user.name}
                      </TableCell>
                      <TableCell className={tableStyles.datestr}>
                        {new Date(a.created_at).toLocaleString('es-ES')}
                      </TableCell>
                      <TableCell className={tableStyles.cell}>
                        <div className="flex gap-2">
                          <a
                            href={`/informe-archivos/${a.id}/download`}
                            aria-label={`Descargar ${a.nombre_original}`}
                          >
                            <Button
                              size="sm"
                              variant="outline"
                              aria-label="Descargar archivo"
                              title="Descargar"
                            >
                              <Download className="h-4 w-4" />
                            </Button>
                          </a>
                          {esAdminOSuperadmin && (
                            <Button
                              size="sm"
                              variant="destructive"
                              aria-label="Eliminar archivo"
                              title="Eliminar"
                              onClick={() => eliminarArchivo(a.id)}
                            >
                              <Trash2 className="h-4 w-4" />
                            </Button>
                          )}
                        </div>
                      </TableCell>
                    </TableRow>
                  ))}
                </TableBody>
              </Table>
            </div>
          ) : (
            <p className="text-sm text-slate-500">
              No hay archivos subidos aún.
            </p>
          )}
        </div>

        {/* Contenido a exportar */}
        <div ref={contenidoRef} data-export className="space-y-6 bg-white">
          {/* Nota de coherencia: sin esto, el total de trampas del informe no
              cuadra con las del mapa actual y parece un error de datos. */}
          {trampasRetiradas.afectadas > 0 && (
            <div className="mb-6 rounded-xl border border-amber-300 bg-amber-50 p-4">
              <p className="text-sm font-semibold text-amber-900">
                Durante el período hubo cambios en las trampas del mapa
              </p>
              <p className="mt-1 text-sm text-amber-800">
                Las tablas de detalle muestran una fila por cada trampa
                instalada, por lo que un mismo punto de control aparece más de
                una vez si se le cambió el tipo de trampa. El total de unidades
                sí cuenta cada punto una sola vez, y por eso no coincide con la
                suma de las filas.
              </p>

              {trampasRetiradas.cambios.length > 0 && (
                <details className="mt-2">
                  <summary className="cursor-pointer text-xs font-medium text-amber-900">
                    {trampasRetiradas.cambios.length}{' '}
                    {trampasRetiradas.cambios.length === 1
                      ? 'punto cambió de tipo de trampa'
                      : 'puntos cambiaron de tipo de trampa'}{' '}
                    (siguen instalados)
                  </summary>
                  <ul className="mt-2 flex flex-wrap gap-1.5">
                    {trampasRetiradas.cambios.map((t) => (
                      <li
                        key={`c-${t.mapa}-${t.identificador}`}
                        className="rounded bg-amber-100 px-2 py-0.5 text-xs text-amber-900"
                      >
                        {t.mapa ? `${t.mapa} · ` : ''}
                        {t.identificador}
                      </li>
                    ))}
                  </ul>
                </details>
              )}

              {trampasRetiradas.retiradas.length > 0 && (
                <details className="mt-2">
                  <summary className="cursor-pointer text-xs font-medium text-amber-900">
                    {trampasRetiradas.retiradas.length}{' '}
                    {trampasRetiradas.retiradas.length === 1
                      ? 'punto fue retirado'
                      : 'puntos fueron retirados'}{' '}
                    del mapa
                  </summary>
                  <ul className="mt-2 flex flex-wrap gap-1.5">
                    {trampasRetiradas.retiradas.map((t) => (
                      <li
                        key={`r-${t.mapa}-${t.identificador}`}
                        className="rounded bg-amber-100 px-2 py-0.5 text-xs text-amber-900"
                      >
                        {t.mapa ? `${t.mapa} · ` : ''}
                        {t.identificador}
                      </li>
                    ))}
                  </ul>
                </details>
              )}
            </div>
          )}

          {/* --------------------------- DATOS DEL INFORME ----------------------------------------- */}
          {/* Encabezado del informe */}
          <div className="mb-6 rounded-xl border border-slate-200 bg-white p-6 shadow-sm">
            <h1 className="text-2xl font-bold text-slate-900">
              Informe de Seguimiento
            </h1>
            <dl className="mt-4 grid grid-cols-1 gap-x-10 gap-y-2 text-sm sm:grid-cols-2">
              <div className="flex gap-2">
                <dt className="font-semibold text-slate-500">Empresa:</dt>
                <dd className="text-slate-900">
                  {empresas.find((e) => e.id === Number(empresaId))?.nombre}
                </dd>
              </div>
              <div className="flex gap-2">
                <dt className="font-semibold text-slate-500">Almacén:</dt>
                <dd className="text-slate-900">
                  {almacenes.find((a) => a.id === Number(almacenId))?.nombre}
                </dd>
              </div>
              <div className="flex gap-2">
                <dt className="font-semibold text-slate-500">Período:</dt>
                <dd className="text-slate-900">{periodoLabel}</dd>
              </div>
              <div className="flex gap-2">
                <dt className="font-semibold text-slate-500">
                  Fecha de generación:
                </dt>
                <dd className="text-slate-900">
                  {new Date().toLocaleDateString('es-ES')}
                </dd>
              </div>
            </dl>
          </div>

          {/* --------------------------- LISTA DE SEGUIMIENTOS ----------------------------------------- */}
          {/* Tabla SEGUIMIENTOS */}
          <div>
            <div className={captionClass}>TABLA: LISTA DE SEGUIMIENTOS</div>
            <div className="w-full overflow-x-auto rounded-lg border border-slate-200 shadow-sm">
              <Table className={tableStyles.table}>
                <TableHeader>
                  <TableRow className={tableStyles.header.row}>
                    <TableHead className={tableStyles.header.cell}>
                      ID
                    </TableHead>
                    <TableHead className={tableStyles.header.cell}>
                      ID CRONOGRAMA
                    </TableHead>
                    <TableHead className={tableStyles.header.cell}>
                      TECNICO
                    </TableHead>
                    <TableHead className={tableStyles.header.cell}>
                      ENCARGADO
                    </TableHead>
                    <TableHead className={tableStyles.header.cell}>
                      TIPO
                    </TableHead>
                    <TableHead className={tableStyles.header.cell}>
                      FECHA
                    </TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {seguimientos.length ? (
                    seguimientos.map((s, idx) => (
                      <TableRow
                        key={s.id}
                        className={tableStyles.row(idx % 2 === 0)}
                      >
                        <TableCell className={tableStyles.cell}>
                          {s.id}
                        </TableCell>
                        <TableCell className={tableStyles.cell}>
                          {s.cronograma_id}
                        </TableCell>
                        <TableCell className={tableStyles.cell}>
                          {s.user.name}
                        </TableCell>
                        <TableCell className={tableStyles.cell}>
                          {s.encargado_nombre}
                        </TableCell>
                        <TableCell className={tableStyles.cell}>
                          {s.tipo_seguimiento.nombre}
                        </TableCell>
                        <TableCell className={tableStyles.datestr}>
                          {/* {new Date(s.created_at).toLocaleString()} */}
                          {new Date(s.created_at).toLocaleDateString('es-ES')}
                        </TableCell>
                      </TableRow>
                    ))
                  ) : (
                    <TableRow>
                      <TableCell colSpan={6} className="text-center">
                        Sin resultados
                      </TableCell>
                    </TableRow>
                  )}
                </TableBody>
              </Table>
            </div>
          </div>

          {/* --------------------------- CANTIDAD DE TRAMPAS ----------------------------------------- */}

          <div className="rounded-xl border border-slate-200 bg-white p-6 shadow-sm">
            <SeccionInforme
              titulo="Desratización"
              subtitulo="Informe de Trampas"
              acento="amber"
            />
            <h2 className={captionClass}>TABLA 1: CANTIDAD TOTAL DE TRAMPAS</h2>
            <p className={descClass}>
              Trampas de control de roedores instaladas actualmente en el
              almacén. No incluye las retiradas del mapa, por lo que puede
              diferir del número de trampas monitoreadas durante el período que
              aparece en las tablas siguientes.
            </p>
            <div className="overflow-x-auto rounded-md border">
              <Table className={tableStyles.table}>
                <TableHeader>
                  <TableRow className={tableStyles.header.row}>
                    <TableHead className={tableStyles.header.cell}>
                      ALMACEN
                    </TableHead>
                    <TableHead className={tableStyles.header.cell}>
                      CANT. TRAMPAS
                    </TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  <TableRow>
                    <TableCell className={tableStyles.cell}>
                      {
                        almacenes.find((a) => a.id === Number(almacenId))
                          ?.nombre
                      }
                    </TableCell>
                    <TableCell className="text-center font-mono">
                      {trampasrat}
                    </TableCell>
                  </TableRow>
                </TableBody>
              </Table>
            </div>
            <br />
            {/* ********************* TABLA CANTIDAD DE TRAMPAS x TIPO y CANTIDAD DE ROEDORES CAPTURADOS ***************** ----------------------------------------- */}
            <h2 className={captionClass}>
              TABLA 2: CANTIDAD DE TRAMPAS POR TIPO
            </h2>
            <p className={descClass}>
              Desglose por tipo de trampa. «Capturas» es el total de roedores
              registrados en el período y la «incidencia» expresa esas capturas
              por trampa y por visita, de modo que los tipos con distinto número
              de unidades puedan compararse entre sí. Si a un punto de control se
              le cambió el tipo de trampa durante el período, aparece en las dos
              filas correspondientes, así que las filas pueden sumar más que el
              total de unidades: ese total cuenta cada punto una sola vez.
            </p>
            <div className="overflow-x-auto rounded-md border">
              <Table className={tableStyles.table}>
                <TableHeader>
                  <TableRow className={tableStyles.header.row}>
                    <TableHead className={tableStyles.header.cell}>
                      Tipo
                    </TableHead>
                    <TableHead className={tableStyles.header.cell}>
                      Trampas
                    </TableHead>
                    <TableHead className={tableStyles.header.cell}>
                      Seguimientos
                    </TableHead>
                    <TableHead className={tableStyles.header.cell}>
                      Capturas
                    </TableHead>
                    <TableHead className={tableStyles.header.cell}>
                      Incidencia %
                    </TableHead>
                  </TableRow>
                </TableHeader>

                <TableBody>
                  {resumen.map((item: any) => (
                    <TableRow key={item.tipo}>
                      <TableCell className={tableStyles.cell}>
                        {item.tipo}
                      </TableCell>

                      <TableCell className={tableStyles.cell}>
                        {item.trampas}
                      </TableCell>

                      <TableCell className={tableStyles.cell}>
                        {item.revisiones}
                      </TableCell>

                      <TableCell className={tableStyles.cell}>
                        {item.capturas}
                      </TableCell>

                      <TableCell className={tableStyles.numeric}>
                        {item.incidencia}%
                      </TableCell>
                    </TableRow>
                  ))}

                  {/* TOTAL */}
                  <TableRow className={tableStyles.totalRow}>
                    <TableCell className={tableStyles.totalCell}>
                      TOTAL
                    </TableCell>

                    <TableCell className={tableStyles.totalCell}>
                      {total.trampas}
                    </TableCell>

                    <TableCell className={tableStyles.totalCell}>
                      {seguimientosDesrat.length}
                    </TableCell>

                    <TableCell className={tableStyles.totalCell}>
                      {total.capturas}
                    </TableCell>

                    <TableCell className={tableStyles.totalNumeric}>
                      {incidenciaTotal}%
                    </TableCell>
                  </TableRow>
                </TableBody>
              </Table>
            </div>
            <div className="my-2 text-[0.8rem] italic">
              Cálculo de incidencia: ((capturas * 100) / trampas) / seguimientos
            </div>
            <br />
            {/* ********************* TABLA FECHAS DE SEGUIMIENTOS (DESRATIZACION) ***************** ----------------------------------------- */}
            <h2 className={captionClass}>
              TABLA 3: FECHAS DE SEGUIMIENTOS EN ALMACEN
            </h2>
            <p className={descClass}>
              Actividad agrupada por mes: cuántas visitas se realizaron, cuántas
              trampas se revisaron y cuántos roedores se capturaron. Permite ver
              la evolución del período y detectar meses con mayor presión de
              plaga.
            </p>
            <div className="overflow-x-auto rounded-md border">
              <Table className={tableStyles.table}>
                <TableHeader>
                  <TableRow className={tableStyles.header.row}>
                    <TableHead className={tableStyles.header.cell}>
                      Mes
                    </TableHead>
                    <TableHead className={tableStyles.header.cell}>
                      Seguimientos
                    </TableHead>
                    <TableHead className={tableStyles.header.cell}>
                      Trampas
                    </TableHead>
                    <TableHead className={tableStyles.header.cell}>
                      Capturas
                    </TableHead>
                    <TableHead className={tableStyles.header.cell}>
                      Incidencia (%)
                    </TableHead>
                  </TableRow>
                </TableHeader>

                <TableBody>
                  {resumenMeses.map((item: any, index: number) => (
                    <TableRow key={index}>
                      <TableCell className={tableStyles.cell}>
                        {item.mes}
                      </TableCell>

                      <TableCell className={tableStyles.cell}>
                        {item.seguimientos}
                      </TableCell>

                      <TableCell className={tableStyles.cell}>
                        {item.trampas}
                      </TableCell>

                      <TableCell className={tableStyles.cell}>
                        {item.capturas}
                      </TableCell>

                      <TableCell className={tableStyles.numeric}>
                        {item.incidencia} %
                      </TableCell>
                    </TableRow>
                  ))}
                </TableBody>
              </Table>
            </div>
            <div className="my-2 text-[0.8rem] italic">
              Cálculo de incidencia: ((capturas * 100) / trampas) / seguimientos
            </div>
            <br />
            {/* ********************* TABLA CANTIDAD DE TRAMPAS x TIPO y CANTIDAD DE ROEDORES CAPTURADOS (EN CADA SEGUIMIENTO) ***************** ----------------------------------------- */}
            {/* <h2 className="text-[1rem] font-bold">
              TABLA: CAPTURA DE ROEDORES POR TRAMPAS POR ALMACEN
            </h2>
            <div className="overflow-x-auto rounded-md border">
              <Table>
                <TableHeader>
                  <TableRow>
                    <TableHead>Almacén</TableHead>
                    <TableHead className="text-right">Seguimientos</TableHead>
                    <TableHead className="text-right">Trampas</TableHead>
                    <TableHead className="text-right">Capturas</TableHead>
                    <TableHead className="text-right">Incidencia</TableHead>
                  </TableRow>
                </TableHeader>

                <TableBody>
                  {tablaAlmacenes.map((item: any, index) => (
                    <TableRow key={index}>
                      <TableCell>{item.almacen}</TableCell>
                      <TableCell className="text-right">
                        {item.seguimientos}
                      </TableCell>
                      <TableCell className="text-right">
                        {item.trampas}
                      </TableCell>
                      <TableCell className="text-right">
                        {item.capturas}
                      </TableCell>
                      <TableCell className="text-right">
                        {item.incidencia}
                      </TableCell>
                    </TableRow>
                  ))}
                </TableBody>
              </Table>
            </div> */}
            {/* ********************* TABLA RESUMEN X (CADA SEGUIMIENTO Y CADA ALMACEN) ***************** ----------------------------------------- */}
            <h2 className={captionClass}>
              TABLA 4: ANALISIS TOTALES DE ALMACEN
            </h2>
            <p className={descClass}>
              Balance de cebo acumulado del período. El «cebo inicial» es el peso
              colocado, la «merma» lo que se perdió respecto de ese peso y el
              «cebo actual» lo que quedó al final. La merma no equivale
              necesariamente a consumo por roedores: la humedad y la temperatura
              también reducen el peso.
            </p>
            <div className="overflow-x-auto rounded-md border">
              <Table className={tableStyles.table}>
                <TableHeader>
                  <TableRow className={tableStyles.header.row}>
                    <TableHead className={tableStyles.header.cell}>
                      ALMACÉN
                    </TableHead>
                    <TableHead className={tableStyles.header.cell}>
                      TRAMPAS
                    </TableHead>
                    <TableHead className={tableStyles.header.cell}>
                      CEBO INICIAL
                    </TableHead>
                    <TableHead className={tableStyles.header.cell}>
                      MERMA
                    </TableHead>
                    <TableHead className={tableStyles.header.cell}>
                      CEBO ACTUAL
                    </TableHead>
                    <TableHead className={tableStyles.header.cell}>
                      ROEDORES CAPTURADOS
                    </TableHead>
                  </TableRow>
                </TableHeader>

                <TableBody>
                  {tablaCebo.map((item: any, index) => (
                    <TableRow key={index}>
                      <TableCell className={tableStyles.cell}>
                        {item.almacen}
                      </TableCell>
                      <TableCell className={tableStyles.cell}>
                        {item.trampas}
                      </TableCell>
                      <TableCell className={tableStyles.cell}>
                        {n2(item.ceboInicial)}
                      </TableCell>
                      <TableCell className={tableStyles.cell}>
                        {n2(item.merma)}
                      </TableCell>
                      <TableCell className={tableStyles.cell}>
                        {n2(item.ceboActual)}
                      </TableCell>
                      <TableCell className={tableStyles.cell}>
                        {n2(item.capturados)}
                      </TableCell>
                    </TableRow>
                  ))}
                </TableBody>
              </Table>
            </div>
            <br />
            {/* <Table>
              <TableHeader>
                <TableRow>
                  <TableHead>ALMACÉN</TableHead>
                  <TableHead className="text-right">TIPO TRAMPA</TableHead>
                  <TableHead className="text-right">TRAMPAS</TableHead>
                  <TableHead className="text-right">CEBO INICIAL</TableHead>
                  <TableHead className="text-right">MERMA</TableHead>
                  <TableHead className="text-right">CEBO ACTUAL</TableHead>
                  <TableHead className="text-right">
                    ROEDORES CAPTURADOS
                  </TableHead>
                </TableRow>
              </TableHeader>

              <TableBody>
                {datosSanitarios.map((row: any, index: number) => (
                  <TableRow key={index}>
                    <TableCell>{row.almacen}</TableCell>
                    <TableCell className="text-right">{row.tipo}</TableCell>
                    <TableCell className="text-right">{row.trampas}</TableCell>
                    <TableCell className="text-right">
                      {n2(row.cebo_inicial)}
                    </TableCell>
                    <TableCell className="text-right">{n2(row.merma)}</TableCell>
                    <TableCell className="text-right">
                      {n2(row.cebo_actual)}
                    </TableCell>
                    <TableCell className="text-right">
                      {n2(row.capturados)}
                    </TableCell>
                  </TableRow>
                ))}
                <TableRow className="bg-muted font-bold">
                  <TableCell colSpan={2}>TOTAL</TableCell>
                  <TableCell className="text-right">
                    {totalesDatosSanitario.trampas}
                  </TableCell>
                  <TableCell className="text-right">
                    {n2(totalesDatosSanitario.cebo_inicial)}
                  </TableCell>
                  <TableCell className="text-right">
                    {n2(totalesDatosSanitario.merma)}
                  </TableCell>
                  <TableCell className="text-right">
                    {n2(totalesDatosSanitario.cebo_actual)}
                  </TableCell>
                  <TableCell className="text-right">
                    {n2(totalesDatosSanitario.capturados)}
                  </TableCell>
                </TableRow>
              </TableBody>
            </Table> */}

            <h2 className={captionClass}>
              TABLA 5: ANALISIS POR FECHA DE SEGUIMIENTO
            </h2>
            <p className={descClass}>
              El mismo balance de la tabla anterior, pero visita a visita. El «%
              merma» es la proporción de cebo perdida sobre el peso inicial de
              esa fecha, y sirve para comparar visitas con distinta cantidad de
              cebo colocado.
            </p>
            <div>
              <Table className={tableStyles.table}>
                <TableHeader>
                  <TableRow className={tableStyles.header.row}>
                    <TableHead className={tableStyles.header.cell}>
                      SEGUIMIENTO
                    </TableHead>
                    <TableHead className={tableStyles.header.cell}>
                      TRAMPAS
                    </TableHead>
                    <TableHead className={tableStyles.header.cell}>
                      CEBO INICIAL
                    </TableHead>
                    <TableHead className={tableStyles.header.cell}>
                      MERMA
                    </TableHead>
                    <TableHead className={tableStyles.header.cell}>
                      CEBO ACTUAL
                    </TableHead>
                    <TableHead className={tableStyles.header.cell}>
                      % MERMA
                    </TableHead>
                    <TableHead className={tableStyles.header.cell}>
                      ROEDORES CAPTURADOS
                    </TableHead>
                  </TableRow>
                </TableHeader>

                <TableBody>
                  {datosSeguimientoResumen.map((row: any, index: number) => (
                    <TableRow key={index}>
                      <TableCell className={tableStyles.datestr}>
                        {new Date(row.fecha).toLocaleDateString('es-ES')}
                      </TableCell>
                      <TableCell className={tableStyles.cell}>
                        {row.trampas}
                      </TableCell>
                      <TableCell className={tableStyles.cell}>
                        {n2(row.cebo_inicial)}
                      </TableCell>
                      <TableCell className={tableStyles.cell}>
                        {n2(row.merma)}
                      </TableCell>
                      <TableCell className={tableStyles.cell}>
                        {n2(row.cebo_actual)}
                      </TableCell>
                      <TableCell className={tableStyles.cell}>
                        {((row.merma * 100) / row.cebo_inicial).toFixed(1)}%
                      </TableCell>
                      <TableCell className={tableStyles.cell}>
                        {n2(row.capturados)}
                      </TableCell>
                    </TableRow>
                  ))}

                  {/* TOTAL */}
                  <TableRow className={tableStyles.totalRow}>
                    <TableCell className={tableStyles.totalCell} colSpan={1}>
                      TOTAL
                    </TableCell>
                    <TableCell className={tableStyles.totalCell}>
                      {totalesResumen.trampas}
                    </TableCell>
                    <TableCell className={tableStyles.totalCell}>
                      {n2(totalesResumen.cebo_inicial)}
                    </TableCell>
                    <TableCell className={tableStyles.totalCell}>
                      {n2(totalesResumen.merma)}
                    </TableCell>
                    <TableCell className={tableStyles.totalCell}>
                      {n2(totalesResumen.cebo_actual)}
                    </TableCell>
                    <TableCell className={tableStyles.totalCell}>
                      {(
                        (totalesResumen.merma * 100) /
                        totalesResumen.cebo_inicial
                      ).toFixed(2)}
                      %
                    </TableCell>
                    <TableCell className={tableStyles.totalCell}>
                      {n2(totalesResumen.capturados)}
                    </TableCell>
                  </TableRow>

                  <TableRow className={tableStyles.totalRow}>
                    <TableCell className={tableStyles.totalCell}>
                      TOTAL
                    </TableCell>
                    <TableCell className={tableStyles.totalNumeric}>
                      {n2(totalesResumen.cebo_inicial)}
                    </TableCell>
                    <TableCell className={tableStyles.totalNumeric}>
                      100%
                    </TableCell>
                  </TableRow>
                  <TableRow className={tableStyles.totalRow}>
                    <TableCell className={tableStyles.totalCell}>
                      MERMA
                    </TableCell>
                    <TableCell className={tableStyles.totalNumeric}>
                      {n2(totalesResumen.merma)}
                    </TableCell>
                    <TableCell className={tableStyles.totalNumeric}>
                      {(
                        (totalesResumen.merma * 100) /
                        totalesResumen.cebo_inicial
                      ).toFixed(2)}
                      %
                    </TableCell>
                  </TableRow>
                  <TableRow className={tableStyles.totalRow}>
                    <TableCell className={tableStyles.totalCell}>
                      CAUSAS
                    </TableCell>
                    <TableCell className={tableStyles.totalNumeric} colSpan={2}>
                      {porcentajeMerma <= 10 ? 'MEDIO AMBIENTE' : 'CONSUMO'}
                    </TableCell>
                  </TableRow>
                </TableBody>
              </Table>
            </div>
            <br />
            <h2 className={captionClass}>
              TABLA 6: ANALISIS POR FECHA DE SEGUIMIENTO Y TIPO DE TRAMPA
            </h2>
            <p className={descClass}>
              Desglosa cada visita según el tipo de trampa, para identificar qué
              tipo concentra el consumo y las capturas en cada fecha.
            </p>
            <div className="overflow-x-auto rounded-md border">
              <Table className={tableStyles.table}>
                <TableHeader>
                  <TableRow className={tableStyles.header.row}>
                    <TableHead className={tableStyles.header.cell}>
                      SEGUIMIENTO
                    </TableHead>
                    <TableHead className={tableStyles.header.cell}>
                      TIPO TRAMPA
                    </TableHead>
                    <TableHead className={tableStyles.header.cell}>
                      TRAMPAS
                    </TableHead>
                    <TableHead className={tableStyles.header.cell}>
                      CEBO INICIAL
                    </TableHead>
                    <TableHead className={tableStyles.header.cell}>
                      MERMA
                    </TableHead>
                    <TableHead className={tableStyles.header.cell}>
                      CEBO ACTUAL
                    </TableHead>
                    <TableHead className={tableStyles.header.cell}>
                      ROEDORES CAPTURADOS
                    </TableHead>
                  </TableRow>
                </TableHeader>

                <TableBody>
                  {datosSeguimiento.map((row: any, index: number) => (
                    <TableRow key={index}>
                      <TableCell className={tableStyles.datestr}>
                        {new Date(row.seguimiento).toLocaleDateString('es-ES')}
                      </TableCell>
                      <TableCell className={tableStyles.cell}>
                        {row.tipo}
                      </TableCell>
                      <TableCell className={tableStyles.cell}>
                        {row.trampas}
                      </TableCell>
                      <TableCell className={tableStyles.cell}>
                        {n2(row.cebo_inicial)}
                      </TableCell>
                      <TableCell className={tableStyles.cell}>
                        {n2(row.merma)}
                      </TableCell>
                      <TableCell className={tableStyles.cell}>
                        {n2(row.cebo_actual)}
                      </TableCell>
                      <TableCell className={tableStyles.cell}>
                        {n2(row.capturados)}
                      </TableCell>
                    </TableRow>
                  ))}
                  {/* FILA TOTAL */}
                  <TableRow className={tableStyles.totalRow}>
                    <TableCell className={tableStyles.totalCell} colSpan={2}>
                      TOTAL
                    </TableCell>
                    <TableCell className={tableStyles.totalCell}>
                      {totalesSeguimiento.trampas}
                    </TableCell>
                    <TableCell className={tableStyles.totalCell}>
                      {n2(totalesSeguimiento.cebo_inicial)}
                    </TableCell>
                    <TableCell className={tableStyles.totalCell}>
                      {n2(totalesSeguimiento.merma)}
                    </TableCell>
                    <TableCell className={tableStyles.totalCell}>
                      {n2(totalesSeguimiento.cebo_actual)}
                    </TableCell>
                    <TableCell className={tableStyles.totalCell}>
                      {n2(totalesSeguimiento.capturados)}
                    </TableCell>
                  </TableRow>
                </TableBody>
              </Table>
            </div>
            <br />

            <h2 className={captionClass}>
              TABLA 7: ANALISIS POR FECHA DE SEGUIMIENTO Y MAPA
            </h2>
            <p className={descClass}>
              Desglosa cada visita por mapa o sector del almacén, para localizar
              en qué zonas se concentra la actividad de roedores.
            </p>
            <div className="rounded-md border bg-amber-100 p-4">
              <Table className={tableStyles.table}>
                <TableHeader>
                  <TableRow className={tableStyles.header.row}>
                    <TableHead className={tableStyles.header.cell}>
                      SEGUIMIENTO
                    </TableHead>
                    <TableHead className={tableStyles.header.cell}>
                      MAPA
                    </TableHead>
                    <TableHead className={tableStyles.header.cell}>
                      TRAMPAS
                    </TableHead>
                    <TableHead className={tableStyles.header.cell}>
                      CEBO INICIAL
                    </TableHead>
                    <TableHead className={tableStyles.header.cell}>
                      MERMA
                    </TableHead>
                    <TableHead className={tableStyles.header.cell}>
                      CEBO ACTUAL
                    </TableHead>
                    <TableHead className={tableStyles.header.cell}>
                      % MERMA
                    </TableHead>
                    <TableHead className={tableStyles.header.cell}>
                      ROEDORES CAPTURADOS
                    </TableHead>
                  </TableRow>
                </TableHeader>

                <TableBody>
                  {datosSeguimientoResumenX.map((row: any, index: number) => (
                    <TableRow key={index}>
                      <TableCell className={tableStyles.datestr}>
                        {new Date(row.fecha).toLocaleDateString('es-ES')}
                      </TableCell>
                      <TableCell className={tableStyles.cell}>
                        {row.mapa}
                      </TableCell>
                      <TableCell className={tableStyles.cell}>
                        {row.trampas}
                      </TableCell>
                      <TableCell className={tableStyles.cell}>
                        {n2(row.cebo_inicial)}
                      </TableCell>
                      <TableCell className={tableStyles.cell}>
                        {n2(row.merma)}
                      </TableCell>
                      <TableCell className={tableStyles.cell}>
                        {n2(row.cebo_actual)}
                      </TableCell>
                      <TableCell className={tableStyles.cell}>
                        {((row.merma * 100) / row.cebo_inicial).toFixed(1)}%
                      </TableCell>
                      <TableCell className={tableStyles.cell}>
                        {n2(row.capturados)}
                      </TableCell>
                    </TableRow>
                  ))}

                  {/* TOTAL - colSpan aumenta a 3 para cubrir seguimiento + almacen + mapa */}
                  <TableRow className={tableStyles.totalRow}>
                    <TableCell className={tableStyles.totalCell} colSpan={2}>
                      TOTAL
                    </TableCell>
                    <TableCell className={tableStyles.totalCell}>
                      {totalesResumen.trampas}
                    </TableCell>
                    <TableCell className={tableStyles.totalCell}>
                      {n2(totalesResumen.cebo_inicial)}
                    </TableCell>
                    <TableCell className={tableStyles.totalCell}>
                      {n2(totalesResumen.merma)}
                    </TableCell>
                    <TableCell className={tableStyles.totalCell}>
                      {n2(totalesResumen.cebo_actual)}
                    </TableCell>
                    <TableCell className={tableStyles.totalCell}>
                      {(
                        (totalesResumen.merma * 100) /
                        totalesResumen.cebo_inicial
                      ).toFixed(2)}
                      %
                    </TableCell>
                    <TableCell className={tableStyles.totalCell}>
                      {n2(totalesResumen.capturados)}
                    </TableCell>
                  </TableRow>
                  <TableRow className={tableStyles.totalRow}>
                    <TableCell className={tableStyles.totalCell}>
                      TOTAL
                    </TableCell>
                    <TableCell className={tableStyles.totalNumeric}>
                      {n2(totalesResumen.cebo_inicial)}
                    </TableCell>
                    <TableCell className={tableStyles.totalNumeric}>
                      100%
                    </TableCell>
                  </TableRow>
                  <TableRow className={tableStyles.totalRow}>
                    <TableCell className={tableStyles.totalCell}>
                      MERMA
                    </TableCell>
                    <TableCell className={tableStyles.totalNumeric}>
                      {n2(totalesResumen.merma)}
                    </TableCell>
                    <TableCell className={tableStyles.totalNumeric}>
                      {(
                        (totalesResumen.merma * 100) /
                        totalesResumen.cebo_inicial
                      ).toFixed(2)}
                      %
                    </TableCell>
                  </TableRow>
                  <TableRow className={tableStyles.totalRow}>
                    <TableCell className={tableStyles.totalCell}>
                      CAUSAS
                    </TableCell>
                    <TableCell className={tableStyles.totalNumeric} colSpan={2}>
                      {porcentajeMerma <= 10 ? 'MEDIO AMBIENTE' : 'CONSUMO'}
                    </TableCell>
                  </TableRow>
                </TableBody>
              </Table>
            </div>
            <br />

            {/* {graficosPorAlmacen.map((alm: any, index: number) => (
              <div key={index} className="mb-10">
                <h3 className="mb-4 text-lg font-semibold">{alm.almacen}</h3>

                <ChartContainer
                  config={{
                    merma_porcentaje: {
                      label: '% Merma',
                    },
                  }}
                  // className="h-[300px] w-full"
                  className={chartClass}
                >
                  <BarChart data={alm.data}>
                    <CartesianGrid vertical={false} />

                    <XAxis dataKey="fecha" tickLine={false} axisLine={false} />

                    <YAxis domain={[0, 100]} tickFormatter={(v) => `${v}%`} />

                    <Tooltip formatter={(value: any) => `${value}%`} />

                    <Bar dataKey="merma_porcentaje" fill="#ef4444" radius={4} />
                  </BarChart>
                </ChartContainer>
              </div>
            ))} */}

            {graficosPorMapa.map((item: any, index: number) => (
              <div key={index} className="mb-10">
                <h3 className={captionClass}>
                  GRAFICO: {item.mapa} - PORCENTAJES
                </h3>
                <br />

                <ChartContainer
                  config={{
                    merma_porcentaje: {
                      label: '% Merma',
                    },
                  }}
                  className={chartClass}
                  ref={(el) => {
                    graficosPorMapaRefs.current[index] = el;
                  }}
                >
                  <BarChart data={item.data} margin={chartMargin}>
                    <defs>
                      <BarGradient
                        id="grad-inicial"
                        color={coloresRoedores.inicial.color}
                      />
                      <BarGradient
                        id="grad-merma"
                        color={coloresRoedores.merma.color}
                      />
                      <BarGradient
                        id="grad-actual"
                        color={coloresRoedores.actual.color}
                      />
                    </defs>
                    <CartesianGrid vertical={false} />
                    <XAxis
                      dataKey="fecha"
                      tickLine={false}
                      axisLine={false}
                      className="font-bold"
                      label={{
                        value: '--- Fecha seguimiento ---',
                        position: 'insideBottom',
                        offset: 0,
                      }}
                      height={48}
                      tickMargin={10}
                    />
                    <YAxis
                      domain={[0, 100]}
                      tickFormatter={(v) => `${v}%`}
                      className="font-bold"
                      label={{
                        value: 'Porcentaje de consumo',
                        angle: -90,
                        position: 'insideCenter',
                        dx: -20,
                      }}
                    />
                    <Tooltip formatter={(value: any) => `${value}%`} />
                    <Bar
                      dataKey="merma_porcentaje"
                      fill="url(#grad-merma)"
                      radius={4}
                    >
                      {item.data.length <= MAX_LABELS && (
                        <LabelList
                          dataKey="merma_porcentaje"
                          position="top"
                          fontSize={10}
                          formatter={(v: any) => n2(v)}
                        />
                      )}
                    </Bar>
                    <Bar
                      dataKey="actual_porcentaje"
                      fill="url(#grad-actual)"
                      radius={4}
                    >
                      {item.data.length <= MAX_LABELS && (
                        <LabelList
                          dataKey="actual_porcentaje"
                          position="top"
                          fontSize={10}
                          formatter={(v: any) => n2(v)}
                        />
                      )}
                    </Bar>
                    <Bar
                      dataKey="total_porcentaje"
                      fill="url(#grad-inicial)"
                      radius={4}
                    >
                      {item.data.length <= MAX_LABELS && (
                        <LabelList
                          dataKey="total_porcentaje"
                          position="top"
                          fontSize={10}
                          formatter={(v: any) => n2(v)}
                        />
                      )}
                    </Bar>
                  </BarChart>
                </ChartContainer>
              </div>
            ))}
            {/* ************** TABLA DE ROEDORES (CALCULAR POR CADA ALMACEN) ****************************** */}
            <h2 className={captionClass}>
              TABLA 8: SEGUIMIENTO PESO DE TRAMPAS
            </h2>
            <p className={descClass}>
              Detalle por trampa de los pesos acumulados en el período. Solo
              incluye trampas con cebo, por lo que las de captura viva y las
              pegajosas no aparecen aquí. La columna «RESULTADO» interpreta el %
              de merma: hasta el 10 % se atribuye a{' '}
              <strong>Medio Ambiente</strong> (pérdida de peso por humedad y
              temperatura) y por encima de ese umbral a{' '}
              <strong>Consumo</strong> por roedores.
            </p>
            <div className="overflow-x-auto rounded-md border">
              <Table className={tableStyles.table}>
                <TableHeader>
                  <TableRow className={tableStyles.header.row}>
                    <TableHead className={tableStyles.header.cell}>
                      Numero
                    </TableHead>
                    <TableHead className={tableStyles.header.cell}>
                      ID Trampa
                    </TableHead>
                    <TableHead className={tableStyles.header.cell}>
                      Mapa
                    </TableHead>
                    <TableHead className={tableStyles.header.cell}>
                      Inicial
                    </TableHead>
                    <TableHead className={tableStyles.header.cell}>
                      Merma
                    </TableHead>
                    <TableHead className={tableStyles.header.cell}>
                      Actual
                    </TableHead>
                    <TableHead className={tableStyles.header.cell}>
                      % merma
                    </TableHead>
                    <TableHead className={tableStyles.header.cell}>
                      RESULTADO
                    </TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {datosRoedores.length > 0 ? (
                    <>
                      {datosRoedores.map((dato, index) => (
                        <TableRow key={index}>
                          <TableCell className={tableStyles.cell}>
                            {index + 1}
                          </TableCell>
                          <TableCell className={tableStyles.cell}>
                            {dato.indent}
                            {dato.retirada && (
                              <span
                                title="Esta trampa dejó de estar en el mapa durante el período: el punto se reequipó con otro tipo o se retiró"
                                className="ml-1.5 rounded bg-amber-100 px-1.5 py-0.5 text-[10px] font-medium text-amber-900"
                              >
                                fuera del mapa
                              </span>
                            )}
                          </TableCell>
                          <TableCell className={tableStyles.cell}>
                            {dato.mapa}
                          </TableCell>
                          <TableCell className={tableStyles.cell}>
                            {n2(dato.inicial)}
                          </TableCell>
                          <TableCell className={tableStyles.cell}>
                            {n2(dato.merma)}
                          </TableCell>
                          <TableCell className={tableStyles.cell}>
                            {n2(dato.actual)}
                          </TableCell>
                          <TableCell className={tableStyles.datestr}>
                            {dato.inicial > 0
                              ? ((dato.merma * 100) / dato.inicial).toFixed(2)
                              : '-'}
                          </TableCell>
                          <TableCell className={tableStyles.cell}>
                            {dato.inicial > 0
                              ? (dato.merma * 100) / dato.inicial <= 10
                                ? 'Medio Ambiente'
                                : 'Consumo'
                              : '-'}
                          </TableCell>
                        </TableRow>
                      ))}
                      <TableRow className={tableStyles.totalRow}>
                        <TableCell
                          colSpan={2}
                          className={tableStyles.totalCell}
                        >
                          TOTAL
                        </TableCell>
                        <TableCell
                          className={tableStyles.totalCell}
                        ></TableCell>
                        <TableCell className={tableStyles.totalCell}>
                          {datosRoedores.reduce(
                            (sum, dato) => sum + dato.inicial,
                            0,
                          )}
                        </TableCell>
                        <TableCell className={tableStyles.totalCell}>
                          {datosRoedores.reduce(
                            (sum, dato) => sum + dato.merma,
                            0,
                          )}
                        </TableCell>
                        <TableCell className={tableStyles.totalCell}>
                          {datosRoedores.reduce(
                            // (sum, dato) => sum + (dato.inicial - dato.merma),
                            (sum, dato) => sum + dato.actual,
                            0,
                          )}
                        </TableCell>
                        <TableCell className={tableStyles.totalCell}>
                          -
                        </TableCell>
                        <TableCell className={tableStyles.totalCell}>
                          -
                        </TableCell>
                      </TableRow>
                      <TableRow className={tableStyles.totalRow}>
                        <TableCell
                          colSpan={2}
                          className={tableStyles.totalCell}
                        >
                          TOTAL
                        </TableCell>
                        <TableCell
                          className={tableStyles.totalCell}
                        ></TableCell>
                        <TableCell className={tableStyles.totalNumeric}>
                          {datosRoedores.reduce(
                            (sum, dato) => sum + dato.inicial,
                            0,
                          )}
                        </TableCell>
                        <TableCell className={tableStyles.totalNumeric}>
                          100 %
                        </TableCell>
                      </TableRow>
                      <TableRow className={tableStyles.totalRow}>
                        <TableCell
                          colSpan={2}
                          className={tableStyles.totalCell}
                        >
                          MERMA
                        </TableCell>
                        <TableCell
                          className={tableStyles.totalCell}
                        ></TableCell>
                        <TableCell className={tableStyles.totalNumeric}>
                          {datosRoedores.reduce(
                            (sum, dato) => sum + dato.merma,
                            0,
                          )}
                        </TableCell>
                        <TableCell className={tableStyles.totalNumeric}>
                          {(
                            (datosRoedores.reduce(
                              (sum, dato) => sum + dato.merma,
                              0,
                            ) *
                              100) /
                            datosRoedores.reduce(
                              (sum, dato) => sum + dato.inicial,
                              0,
                            )
                          ).toFixed(2)}{' '}
                          %
                        </TableCell>
                      </TableRow>
                      <TableRow className={tableStyles.totalRow}>
                        <TableCell
                          colSpan={2}
                          className={tableStyles.totalCell}
                        >
                          PESO ACTUAL
                        </TableCell>
                        <TableCell
                          className={tableStyles.totalCell}
                        ></TableCell>
                        <TableCell className={tableStyles.totalNumeric}>
                          {datosRoedores.reduce(
                            (sum, dato) => sum + (dato.inicial - dato.merma),
                            0,
                          )}
                        </TableCell>
                        <TableCell className={tableStyles.totalNumeric}>
                          {(
                            (datosRoedores.reduce(
                              (sum, dato) => sum + (dato.inicial - dato.merma),
                              0,
                            ) *
                              100) /
                            datosRoedores.reduce(
                              (sum, dato) => sum + dato.inicial,
                              0,
                            )
                          ).toFixed(2)}{' '}
                          %
                        </TableCell>
                      </TableRow>
                      <TableRow className={tableStyles.totalRow}>
                        <TableCell
                          colSpan={2}
                          className={tableStyles.totalCell}
                        >
                          MERMA CONSUMO
                        </TableCell>
                        <TableCell
                          className={tableStyles.totalCell}
                        ></TableCell>
                        <TableCell className={tableStyles.totalNumeric}>
                          {datosRoedores.reduce((sum, dato) => {
                            const inicial = dato.inicial;
                            const actual = inicial - dato.merma;
                            const porcentaje = (dato.merma * 100) / inicial;

                            if (porcentaje > 10) {
                              return sum + dato.merma;
                            }
                            return sum;
                          }, 0)}
                        </TableCell>
                        <TableCell className={tableStyles.totalNumeric}>
                          {(
                            (datosRoedores.reduce((sum, dato) => {
                              const inicial = dato.inicial;
                              const actual = inicial - dato.merma;
                              const porcentaje = (dato.merma * 100) / inicial;

                              if (porcentaje > 10) {
                                return sum + dato.merma;
                              }
                              return sum;
                            }, 0) *
                              100) /
                            datosRoedores.reduce(
                              (sum, dato) => sum + dato.merma,
                              0,
                            )
                          ).toFixed(2)}{' '}
                          %
                        </TableCell>
                      </TableRow>
                      <TableRow className={tableStyles.totalRow}>
                        <TableCell
                          colSpan={2}
                          className={tableStyles.totalCell}
                        >
                          MERMA M.A.
                        </TableCell>
                        <TableCell
                          className={tableStyles.totalCell}
                        ></TableCell>
                        <TableCell className={tableStyles.totalNumeric}>
                          {datosRoedores.reduce((sum, dato) => {
                            const inicial = dato.inicial;
                            const actual = inicial - dato.merma;
                            const porcentaje = (dato.merma * 100) / inicial;

                            if (porcentaje <= 10) {
                              return sum + dato.merma;
                            }
                            return sum;
                          }, 0)}
                        </TableCell>
                        <TableCell className={tableStyles.totalNumeric}>
                          {(
                            (datosRoedores.reduce((sum, dato) => {
                              const inicial = dato.inicial;
                              const actual = inicial - dato.merma;
                              const porcentaje = (dato.merma * 100) / inicial;

                              if (porcentaje <= 10) {
                                return sum + dato.merma;
                              }
                              return sum;
                            }, 0) *
                              100) /
                            datosRoedores.reduce(
                              (sum, dato) => sum + dato.merma,
                              0,
                            )
                          ).toFixed(2)}{' '}
                          %
                        </TableCell>
                      </TableRow>
                    </>
                  ) : (
                    <TableRow>
                      <TableCell colSpan={8} className={tableStyles.totalRow}>
                        Sin resultados
                      </TableCell>
                    </TableRow>
                  )}
                </TableBody>
              </Table>
            </div>

            <br />

            {/* GRÁFICO 3: Comparación Inicial/Merma/Actual (Líneas) */}
            {datosFiltrados.length > 0 && (
              <div>
                <div className={captionClass}>
                  GRÁFICO: COMPARACIÓN DE PESOS POR TRAMPA
                </div>
                <br />
                <ChartContainer
                  config={chartConfigRoedores}
                  className={chartClass}
                  ref={chartRoedoresLineRef}
                >
                  <LineChart data={datosFiltrados} margin={chartMargin}>
                    <CartesianGrid strokeDasharray="3 3" />
                    <XAxis
                      // dataKey="trampa_id"
                      dataKey="indent"
                      tickFormatter={(value) => `${value}`}
                      className="font-bold"
                      label={{
                        value: '--- TRAMPA ---',
                        position: 'insideBottom',
                        offset: 0,
                      }}
                      height={48}
                      tickMargin={10}
                    />
                    <YAxis
                      className="font-bold"
                      label={{
                        value: 'Cantidad de consumo',
                        angle: -90,
                        position: 'insideCenter',
                        dx: -10,
                      }}
                    />
                    <ChartTooltip content={<ChartTooltipContent />} />
                    <Legend />
                    <Line
                      type="monotone"
                      dataKey="inicial"
                      stroke={coloresRoedores.inicial.color}
                      strokeWidth={2}
                      name="Inicial"
                    >
                      {showLabelsRoedores && (
                        <LabelList
                          dataKey="inicial"
                          position="top"
                          fontSize={10}
                          formatter={(v: any) => n2(v)}
                        />
                      )}
                    </Line>
                    <Line
                      type="monotone"
                      dataKey="merma"
                      stroke={coloresRoedores.merma.color}
                      strokeWidth={2}
                      name="Merma"
                    >
                      {showLabelsRoedores && (
                        <LabelList
                          dataKey="merma"
                          position="top"
                          fontSize={10}
                          formatter={(v: any) => n2(v)}
                        />
                      )}
                    </Line>
                    <Line
                      type="monotone"
                      dataKey="actual"
                      stroke={coloresRoedores.actual.color}
                      strokeWidth={2}
                      name="Actual"
                    >
                      {showLabelsRoedores && (
                        <LabelList
                          dataKey="actual"
                          position="top"
                          fontSize={10}
                          formatter={(v: any) => n2(v)}
                        />
                      )}
                    </Line>
                  </LineChart>
                </ChartContainer>
              </div>
            )}
            <br />

            {/* GRÁFICO 4: Barras agrupadas por trampa */}
            {datosFiltrados.length > 0 && (
              <div>
                <div className={captionClass}>GRÁFICO: VALORES POR TRAMPA</div>
                <br />
                <ChartContainer
                  config={chartConfigRoedores}
                  className={chartClass}
                  ref={chartRoedoresBarRef}
                >
                  <BarChart data={datosFiltrados} margin={chartMargin}>
                    <defs>
                      <BarGradient
                        id="grad-inicial"
                        color={coloresRoedores.inicial.color}
                      />
                      <BarGradient
                        id="grad-merma"
                        color={coloresRoedores.merma.color}
                      />
                      <BarGradient
                        id="grad-actual"
                        color={coloresRoedores.actual.color}
                      />
                    </defs>
                    <CartesianGrid strokeDasharray="3 3" />
                    <XAxis
                      dataKey="indent"
                      tickFormatter={(value) => `${value}`}
                      className="font-bold"
                      label={{
                        value: '--- TRAMPA ---',
                        position: 'insideBottom',
                        offset: 0,
                      }}
                      height={48}
                      tickMargin={10}
                    />
                    <YAxis
                      className="font-bold"
                      label={{
                        value: 'Cantidad de consumo',
                        angle: -90,
                        position: 'insideCenter',
                        dx: -10,
                      }}
                    />
                    <ChartTooltip content={<ChartTooltipContent />} />
                    <Legend />
                    <Bar
                      dataKey="inicial"
                      fill="url(#grad-inicial)"
                      radius={4}
                      name="Inicial"
                    >
                      {showLabelsRoedores && (
                        <LabelList
                          dataKey="inicial"
                          position="top"
                          fontSize={10}
                          formatter={(v: any) => n2(v)}
                        />
                      )}
                    </Bar>
                    <Bar
                      dataKey="merma"
                      fill="url(#grad-merma)"
                      radius={4}
                      name="Merma"
                    >
                      {showLabelsRoedores && (
                        <LabelList
                          dataKey="merma"
                          position="top"
                          fontSize={10}
                          formatter={(v: any) => n2(v)}
                        />
                      )}
                    </Bar>
                    <Bar
                      dataKey="actual"
                      fill="url(#grad-actual)"
                      radius={4}
                      name="Actual"
                    >
                      {showLabelsRoedores && (
                        <LabelList
                          dataKey="actual"
                          position="top"
                          fontSize={10}
                          formatter={(v: any) => n2(v)}
                        />
                      )}
                    </Bar>
                  </BarChart>
                </ChartContainer>
              </div>
            )}
            <br />

            <div className="mb-6">
              <h2 className="text-xl font-bold">Informe de Trampas</h2>
            </div>
            {/* GRÁFICO 4: Barras agrupadas por trampa */}
            {totalesPorcentajesValues.length > 0 && (
              <div>
                <div className={captionClass}>GRÁFICO: RESUMEN</div>
                <ChartContainer
                  config={chartConfigRoedores}
                  className={chartClass}
                  ref={chartResumenTrampasRef}
                >
                  <BarChart
                    data={totalesPorcentajesValues}
                    margin={chartMargin}
                  >
                    <defs>
                      <BarGradient
                        id="grad-inicial"
                        color={coloresRoedores.inicial.color}
                      />
                      <BarGradient
                        id="grad-merma"
                        color={coloresRoedores.merma.color}
                      />
                      <BarGradient
                        id="grad-actual"
                        color={coloresRoedores.actual.color}
                      />
                    </defs>
                    <CartesianGrid strokeDasharray="3 3" />
                    <XAxis
                      dataKey="mes"
                      tickFormatter={(value) => `${value}`}
                      className="font-bold"
                      label={{
                        value: '--- Fechas de seguimiento ---',
                        position: 'insideBottom',
                        offset: 0,
                      }}
                      height={48}
                      tickMargin={10}
                    />
                    <YAxis
                      className="font-bold"
                      label={{
                        value: 'Porcentaje de consumo',
                        angle: -90,
                        position: 'insideCenter',
                        dx: -10,
                      }}
                      // domain={[0, (dataMax: number) => dataMax * 1.2]}
                    />
                    <ChartTooltip content={<ChartTooltipContent />} />
                    <Legend />
                    <Bar
                      dataKey="inicial_por"
                      fill="url(#grad-inicial)"
                      radius={4}
                      name="Inicial"
                    >
                      {showLabelsResumen && (
                        <LabelList
                          dataKey="inicial_por"
                          position="top"
                          fontSize={10}
                          formatter={(v: any) => n2(v)}
                        />
                      )}
                    </Bar>
                    <Bar
                      dataKey="merma_por"
                      fill="url(#grad-merma)"
                      radius={4}
                      name="Merma"
                    >
                      {showLabelsResumen && (
                        <LabelList
                          dataKey="merma_por"
                          position="top"
                          fontSize={10}
                          formatter={(v: any) => n2(v)}
                        />
                      )}
                    </Bar>
                    <Bar
                      dataKey="actual_por"
                      fill="url(#grad-actual)"
                      radius={4}
                      name="Actual"
                    >
                      {showLabelsResumen && (
                        <LabelList
                          dataKey="actual_por"
                          position="top"
                          fontSize={10}
                          formatter={(v: any) => n2(v)}
                        />
                      )}
                    </Bar>
                  </BarChart>
                </ChartContainer>
              </div>
            )}
          </div>

          {/* ********************* GRAFICA: MONITOREO DE ROEDORES (X ALMACEN) ***************** ----------------------------------------- */}

          {/* ************************************************************************************************************************** */}
          {/* --------------------------- CANTIDAD DE INSECTOCUTORES ----------------------------------------- */}
          {/* ************************************************************************************************************************** */}

          <SeparadorSeccion />

          <div className="rounded-xl border border-slate-200 bg-white p-6 shadow-sm">
            <SeccionInforme
              titulo="Insectocutores"
              subtitulo="Informe de Insectocutores"
              acento="rose"
            />
            {/* **************** INSECTOCUTORES POR ALMACEN ************************ */}
            <h2 className={captionClass}>
              TABLA 9: CANTIDAD TOTAL DE INSECTOCUTORES
            </h2>
            <p className={descClass}>
              Equipos de control de insectos voladores instalados actualmente en
              el almacén. Al igual que en la tabla 1, no incluye los retirados.
            </p>
            <div className="overflow-x-auto rounded-md border">
              <Table className={tableStyles.table}>
                <TableHeader>
                  <TableRow className={tableStyles.header.row}>
                    <TableHead className={tableStyles.header.cell}>
                      ALMACEN
                    </TableHead>
                    <TableHead className={tableStyles.header.cell}>
                      CANT. INSECTOCUTORES
                    </TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  <TableRow>
                    <TableCell className={tableStyles.cell}>
                      {
                        almacenes.find((a) => a.id === Number(almacenId))
                          ?.nombre
                      }
                    </TableCell>
                    <TableCell className={tableStyles.cell}>
                      {trampasinsect}
                    </TableCell>
                  </TableRow>
                </TableBody>
              </Table>
            </div>
            <br />
            {/* **************** GRAFICOS DE TODOS LOS ALMACENES ************************ */}
            {/* GRÁFICO 1: CANTIDAD Totales por Especie (Barras) */}
            {datosInsectocutores.especies.length > 0 && (
              <div>
                <div className={captionClass}>
                  GRAFICO: TOTAL DE INSECTOS POR ESPECIE
                </div>
                <br />
                <ChartContainer
                  config={chartConfigInsectos}
                  className={chartClass}
                  ref={chartInsectosRef}
                >
                  <BarChart
                    data={Object.entries(datosInsectocutores.totales).map(
                      ([especie, total], i) => ({
                        especie,
                        cantidad: total,
                        fill: `url(#grad-tot-${i})`,
                      }),
                    )}
                    barCategoryGap="20%"
                    margin={chartMargin}
                  >
                    <defs>
                      {Object.keys(datosInsectocutores.totales).map(
                        (esp, i) => (
                          <BarGradient
                            key={esp}
                            id={`grad-tot-${i}`}
                            color={chartConfigInsectos[esp]?.color ?? '#888'}
                          />
                        ),
                      )}
                    </defs>
                    <CartesianGrid strokeDasharray="3 3" />
                    <XAxis
                      dataKey="especie"
                      className="font-bold"
                      label={{
                        value: '--- ESPECIES ---',
                        position: 'insideBottom',
                        offset: 0,
                      }}
                      height={48}
                      tickMargin={10}
                    />
                    <YAxis
                      className="font-bold"
                      label={{
                        value: 'Cantidad capturados',
                        angle: -90,
                        position: 'insideCenter',
                        dx: -10,
                      }}
                    />
                    <ChartTooltip content={<ChartTooltipContent />} />
                    <Bar dataKey="cantidad" radius={8}>
                      <LabelList
                        dataKey="cantidad"
                        position="top"
                        fontSize={10}
                        formatter={(v: any) => n2(v)}
                      />
                    </Bar>
                  </BarChart>
                </ChartContainer>
              </div>
            )}
            <br />
            {/* **************** SECCION POR ALMACEN ************************ */}
            {/* --------------------------- INCIDENCIA ----------------------------------------- */}
            {/* TABLA DE INSECTOCUTORES "INCIDENCIA" */}
            <div>
              <div className={captionClass}>
                TABLA 10: INCIDENCIA DE INSECTOS VOLADORES{' '}
              </div>
              <p className={descClass}>
                Insectos capturados por especie en cada fecha de seguimiento.
                Refleja cuántos ejemplares se registraron, es decir la magnitud
                absoluta de la presencia de cada especie a lo largo del período.
              </p>
              <div className="overflow-x-auto rounded-md border">
                <Table className={tableStyles.table}>
                  <TableHeader>
                    <TableRow className={tableStyles.header.row}>
                      <TableHead className={tableStyles.header.cell}>
                        Fecha de Seguimiento
                      </TableHead>
                      {datosInsectocutores.especies.map((especie) => (
                        <TableHead
                          className={tableStyles.header.cell}
                          key={especie}
                        >
                          {especie}
                        </TableHead>
                      ))}
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    {datosInsectocutores.datosPorFecha.length > 0 ? (
                      <>
                        {datosInsectocutores.datosPorFecha.map(
                          (dato, index) => (
                            <TableRow key={index}>
                              <TableCell className={tableStyles.datestr}>
                                {dato.fechaLabel}
                              </TableCell>
                              {datosInsectocutores.especies.map((especie) => (
                                <TableCell
                                  className={tableStyles.cell}
                                  key={especie}
                                >
                                  {dato.cantidades[especie]}
                                </TableCell>
                              ))}
                            </TableRow>
                          ),
                        )}
                        <TableRow className={tableStyles.totalRow}>
                          <TableCell className={tableStyles.totalCell}>
                            TOTAL
                          </TableCell>
                          {datosInsectocutores.especies.map((especie) => (
                            <TableCell
                              className={tableStyles.totalCell}
                              key={especie}
                            >
                              {datosInsectocutores.totales[especie]}
                            </TableCell>
                          ))}
                        </TableRow>
                        <TableRow className={tableStyles.totalRow}>
                          <TableCell className={tableStyles.totalCell}>
                            PROMEDIO
                          </TableCell>
                          {datosInsectocutores.especies.map((especie) => (
                            <TableCell
                              className={tableStyles.totalCell}
                              key={especie}
                            >
                              {datosInsectocutores.promedios[especie].toFixed(
                                2,
                              )}
                            </TableCell>
                          ))}
                        </TableRow>
                      </>
                    ) : (
                      <TableRow>
                        <TableCell
                          className={tableStyles.totalCell}
                          colSpan={datosInsectocutores.especies.length + 1}
                        >
                          Sin resultados
                        </TableCell>
                      </TableRow>
                    )}
                  </TableBody>
                </Table>
              </div>
            </div>
            <br />
            {/* GRÁFICO INCIDENCIA */}
            {datosInsectocutores.especies.length > 0 && (
              <div>
                <div className={captionClass}>
                  GRÁFICO DE INCIDENCIA: EVOLUCIÓN DE INSECTOS POR FECHA
                </div>
                <br />
                <ChartContainer
                  config={chartConfigInsectos}
                  className={chartClass}
                  ref={chartEvolucionRef}
                >
                  <BarChart
                    data={datosInsectocutores.datosPorFecha.map((dato) => ({
                      fecha: dato.fechaLabel,
                      ...dato.cantidades,
                    }))}
                    barGap={4}
                    barCategoryGap="20%"
                    margin={chartMargin}
                  >
                    <defs>
                      {datosInsectocutores.especies.map((esp, i) => (
                        <BarGradient
                          key={esp}
                          id={`grad-evo-${i}`}
                          color={chartConfigInsectos[esp]?.color ?? '#888'}
                        />
                      ))}
                    </defs>
                    <CartesianGrid strokeDasharray="3 3" />
                    <XAxis
                      dataKey="fecha"
                      className="font-bold"
                      label={{
                        value: '--- Fechas de seguimiento ---',
                        position: 'insideBottom',
                        offset: 0,
                      }}
                      height={48}
                      tickMargin={10}
                    />
                    <YAxis
                      domain={[0, 100]}
                      tickFormatter={(value) => `${value}`}
                      className="font-bold"
                      label={{
                        value: 'Nivel de incidencia',
                        angle: -90,
                        position: 'insideCenter',
                        dx: -10,
                      }}
                    />
                    <ChartTooltip content={<ChartTooltipContent />} />
                    <Legend />
                    {datosInsectocutores.especies.map((especie, i) => (
                      <Bar
                        key={especie}
                        dataKey={especie}
                        fill={`url(#grad-evo-${i})`}
                        radius={4}
                      >
                        {showLabelsEvolucion && (
                          <LabelList
                            dataKey={especie}
                            position="top"
                            fontSize={10}
                            formatter={(v: any) => n2(v)}
                          />
                        )}
                      </Bar>
                    ))}
                  </BarChart>
                </ChartContainer>
              </div>
            )}
            <br />
            {/* --------------------------- SEVERIDAD ----------------------------------------- */}
            {/* TABLA DE INSECTOCUTORES "SEVERIDAD" */}
            <div>
              <div className={captionClass}>
                TABLA 11: SEVERIDAD DE INSECTOS VOLADORES{' '}
              </div>
              <p className={descClass}>
                Pondera las capturas de la tabla anterior para estimar el grado
                de afectación por especie en cada fecha. Mientras la incidencia
                indica cuántos insectos hubo, la severidad valora la gravedad de
                esa presencia.
              </p>
              <div className="overflow-x-auto rounded-md border">
                <Table className={tableStyles.table}>
                  <TableHeader>
                    <TableRow className={tableStyles.header.row}>
                      <TableHead className={tableStyles.header.cell}>
                        Fecha de Seguimiento
                      </TableHead>
                      {datosInsectocutores.especies.map((especie) => (
                        <TableHead
                          className={tableStyles.header.cell}
                          key={especie}
                        >
                          {especie}
                        </TableHead>
                      ))}
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    {datosInsectocutores.datosPorFecha.length > 0 ? (
                      <>
                        {datosInsectocutores.datosPorFecha.map(
                          (dato, index) => (
                            <TableRow key={index}>
                              <TableCell className={tableStyles.datestr}>
                                {dato.fechaLabel}
                              </TableCell>
                              {datosInsectocutores.especies.map((especie) => (
                                <TableCell
                                  className={tableStyles.cell}
                                  key={especie}
                                >
                                  {/* {Math.floor(
                                    dato.cantidades[especie] /
                                      datosInsectocutores.datosPorFecha.length,
                                  )} */}
                                  {Math.floor(dato.cantidades[especie] / 3)}
                                </TableCell>
                              ))}
                            </TableRow>
                          ),
                        )}
                        <TableRow className={tableStyles.totalRow}>
                          <TableCell className={tableStyles.totalCell}>
                            TOTAL
                          </TableCell>
                          {datosInsectocutores.especies.map((especie) => (
                            <TableCell
                              className={tableStyles.totalCell}
                              key={especie}
                            >
                              {datosInsectocutores.totalesSev[especie]}
                            </TableCell>
                          ))}
                        </TableRow>
                        <TableRow className={tableStyles.totalRow}>
                          <TableCell className={tableStyles.totalCell}>
                            PROMEDIO
                          </TableCell>
                          {datosInsectocutores.especies.map((especie) => (
                            <TableCell
                              className={tableStyles.totalCell}
                              key={especie}
                            >
                              {datosInsectocutores.promediosSev[
                                especie
                              ].toFixed(1)}
                            </TableCell>
                          ))}
                        </TableRow>
                      </>
                    ) : (
                      <TableRow className={tableStyles.totalRow}>
                        <TableCell
                          className={tableStyles.totalCell}
                          colSpan={datosInsectocutores.especies.length + 1}
                        >
                          Sin resultados
                        </TableCell>
                      </TableRow>
                    )}
                  </TableBody>
                </Table>
              </div>
            </div>
            <br />
            {/* GRÁFICO SEVERIDAD */}
            {datosInsectocutores.especies.length > 0 && (
              <div>
                <div className={captionClass}>GRÁFICO DE SEVERIDAD</div>
                <br />
                <ChartContainer
                  config={chartConfigInsectos}
                  className={chartClass}
                  ref={chartSeveridadRef}
                >
                  <BarChart
                    data={dataSeveridadPivot}
                    barGap={4}
                    barCategoryGap="20%"
                    margin={chartMargin}
                  >
                    <defs>
                      {datosInsectocutores.datosPorFecha.map((dato, index) => (
                        <BarGradient
                          key={dato.fecha}
                          id={`grad-sev-${index}`}
                          color={`hsl(${(index * 160) / datosInsectocutores.especies.length}, 60%, 48%)`}
                        />
                      ))}
                    </defs>
                    <CartesianGrid strokeDasharray="3 3" />

                    {/* AHORA X ES ESPECIE */}

                    <XAxis
                      dataKey="especie"
                      className="font-bold"
                      label={{
                        value: '--- ESPECIES ---',
                        position: 'insideBottom',
                        offset: 0,
                      }}
                      height={48}
                      tickMargin={10}
                    />

                    <YAxis
                      domain={[0, 10]}
                      tickFormatter={(value) => `${value}`}
                      className="font-bold"
                      label={{
                        value: 'Nivel de severidad',
                        angle: -90,
                        position: 'insideCenter',
                        dx: -10,
                      }}
                    />

                    <ChartTooltip content={<ChartTooltipContent />} />
                    <Legend />

                    {/* LAS BARRAS SON LAS FECHAS */}
                    {datosInsectocutores.datosPorFecha.map((dato, index) => (
                      <Bar
                        key={dato.fecha}
                        dataKey={dato.fecha}
                        fill={`url(#grad-sev-${index})`}
                        radius={4}
                        name={dato.fechaLabel}
                      >
                        {showLabelsSeveridad && (
                          <LabelList
                            dataKey={dato.fecha}
                            position="top"
                            fontSize={10}
                            formatter={(v: any) => n2(v)}
                          />
                        )}
                      </Bar>
                    ))}
                  </BarChart>
                </ChartContainer>
              </div>
            )}
          </div>
          <SeparadorSeccion />

          <div>
            <SeccionInforme
              titulo="Acciones complementarias"
              subtitulo="Trabajos adicionales realizados en el período"
              acento="sky"
            />
            {acciones.map((dato) => (
              <div key={dato.id} className="mb-6">
                <div>
                  Fecha:{' '}
                  <span>
                    {new Date(dato.created_at).toLocaleDateString('es-ES')}
                  </span>
                </div>
                <div>
                  Descripcion: <span>{dato.descripcion}</span>
                </div>
                <div className="mt-2 flex flex-wrap gap-2">
                  {dato.imagenes.map((img) => (
                    <img
                      key={img.id}
                      src={img.imagen}
                      alt={`Imagen de la acción del ${new Date(dato.created_at).toLocaleDateString('es-ES')}`}
                      width={300}
                      loading="lazy"
                      className="h-auto rounded-md border"
                    />
                  ))}
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>
    </AppLayout>
  );
}
