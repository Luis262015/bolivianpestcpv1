import { Button } from '@/components/ui/button';
import {
  ChartConfig,
  ChartContainer,
  ChartTooltip,
  ChartTooltipContent,
} from '@/components/ui/chart';
import { Input } from '@/components/ui/input';
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
import { Head, router } from '@inertiajs/react';
// import html2canvas from 'html2canvas';
import * as htmlToImage from 'html-to-image';
import jsPDF from 'jspdf';
import { Download } from 'lucide-react';
import { useEffect, useMemo, useRef, useState } from 'react';
import {
  Bar,
  BarChart,
  CartesianGrid,
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

interface Roedor {
  id: number;
  trampa_id: number;
  observacion: string;
  inicial: number;
  actual: number;
  merma: number;
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
}

interface Props {
  empresas: Empresa[];
  almacenes: Almacen[];
  seguimientos: Seguimiento[];
  trampasinsect?: number;
  trampasrat?: number;
  totales: TotalData[];
  filters: {
    empresa_id?: number;
    almacen_id?: number;
    fecha_inicio?: string;
    fecha_fin?: string;
  };
}

export default function Lista({
  empresas,
  almacenes,
  seguimientos,
  trampasinsect,
  trampasrat,
  totales,
  filters,
}: Props) {
  const [empresaId, setEmpresaId] = useState(filters.empresa_id?.toString());
  const [almacenId, setAlmacenId] = useState(filters.almacen_id?.toString());
  const [fechaInicio, setFechaInicio] = useState(filters.fecha_inicio ?? '');
  const [fechaFin, setFechaFin] = useState(filters.fecha_fin ?? '');

  const [exportando, setExportando] = useState(false);

  const contenidoRef = useRef<HTMLDivElement>(null);

  const chartRoedoresLineRef = useRef<HTMLDivElement>(null); // COMPARACION DE PESOS POR TRAMPA
  const chartRoedoresBarRef = useRef<HTMLDivElement>(null); //  VALORES POR TRAMPA
  const chartResumenTrampasRef = useRef<HTMLDivElement>(null); // RESUMEN

  const chartInsectosRef = useRef<HTMLDivElement>(null); // CHART TOTAL INSECTOS POR ESPECIE
  const chartEvolucionRef = useRef<HTMLDivElement>(null); // EVOLUCION INSECTOS POR FECHA
  const chartSeveridadRef = useRef<HTMLDivElement>(null); // SEVERIDAD

  const graficosPorMapaRefs = useRef<(HTMLDivElement | null)[]>([]);

  /**
   * SEGUIMIENTOS
   */

  const totalSeguimientos = seguimientos.length;

  const resumen = Object.values(
    seguimientos
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
        acc[tipo].capturas += r.cantidad ?? 0;

        return acc;
      }, {}),
  ).map((item: any) => {
    const trampas = item.trampas.size;
    const capturas = item.capturas;

    const incidencia =
      trampas * totalSeguimientos > 0
        ? ((capturas / (trampas * totalSeguimientos)) * 100).toFixed(2)
        : 0;

    return {
      tipo: item.tipo,
      trampas,
      revisiones: totalSeguimientos,
      capturas,
      incidencia,
    };
  });

  const total = resumen.reduce(
    (acc: any, item: any) => {
      acc.trampas += item.trampas;
      acc.capturas += item.capturas;
      return acc;
    },
    { trampas: 0, capturas: 0 },
  );

  /**
   * DESRATIZACION DATOS
   */

  const resumenMeses = Object.values(
    seguimientos.reduce((acc: any, s: any) => {
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
        acc[key].capturas += r.cantidad ?? 0;
      });

      return acc;
    }, {}),
  ).map((item: any) => {
    const trampas = item.trampas.size;
    const incidencia =
      trampas && item.seguimientos
        ? ((item.capturas / (trampas * item.seguimientos)) * 100).toFixed(2)
        : 0;

    return {
      mes: item.mes,
      seguimientos: item.seguimientos,
      trampas,
      capturas: item.capturas,
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
        almacenes[almacenId].capturas += r.cantidad ?? 0;
      });
    });

    return Object.values(almacenes).map((a: any) => {
      const trampas = a.trampasSet.size;

      return {
        almacen: a.almacen,
        seguimientos: a.seguimientos,
        trampas: trampas,
        capturas: a.capturas,
        incidencia:
          trampas > 0 ? ((a.capturas / trampas) * 100).toFixed(2) + '%' : '0%',
      };
    });
  };

  const tablaAlmacenes = resumenPorAlmacen(seguimientos);

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
        almacenes[almacenId].ceboInicial += r.inicial ?? 0;
        almacenes[almacenId].merma += r.merma ?? 0;
        almacenes[almacenId].ceboActual += r.actual ?? 0;
        almacenes[almacenId].capturados += r.cantidad ?? 0;
      });
    });

    return Object.values(almacenes).map((a: any) => ({
      almacen: a.almacen,
      trampas: a.trampasSet.size,
      ceboInicial: a.ceboInicial,
      merma: a.merma,
      ceboActual: a.ceboActual,
      capturados: a.capturados,
    }));
  };

  const tablaCebo = tablaCeboPorAlmacen(seguimientos);

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
        data.cebo_inicial += r.inicial ?? 0;
        data.merma += r.merma ?? 0;
        data.cebo_actual += r.actual ?? 0;
        data.capturados += r.cantidad ?? 0;
      });
    });

    const resultado: any[] = [];

    Object.values(almacenes).forEach((a: any) => {
      Object.entries(a.tipos).forEach(([tipo, data]: any) => {
        resultado.push({
          almacen: a.almacen,
          tipo: tipo.toUpperCase(),
          trampas: data.trampasSet.size,
          cebo_inicial: data.cebo_inicial,
          merma: data.merma,
          cebo_actual: data.cebo_actual,
          capturados: data.capturados,
        });
      });
    });

    return resultado;
  };

  const datosSanitarios = tablaSanitariaPorAlmacen(seguimientos);

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
      const seguimientoId = seg.id;
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
        t.cebo_inicial += r.inicial ?? 0;
        t.merma += r.merma ?? 0;
        t.cebo_actual += r.actual ?? 0;
        t.capturados += r.cantidad ?? 0;
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
          cebo_inicial: t.cebo_inicial,
          merma: t.merma,
          cebo_actual: t.cebo_actual,
          capturados: t.capturados,
        });
      });
    });

    return resultado;
  };

  const datosSeguimiento = tablaSanitariaPorSeguimiento(seguimientos);

  const totalesSeguimiento = datosSeguimiento.reduce(
    (acc: any, row: any) => {
      acc.trampas += row.trampas;
      acc.cebo_inicial += row.cebo_inicial;
      acc.merma += row.merma;
      acc.cebo_actual += row.cebo_actual;
      acc.capturados += row.capturados;
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
      (seg) => seg.tipo_seguimiento_id === 1, // ← solo DESRATIZACION
    );

    console.log('++++++++++++++++++++++++');
    console.log(seguimientosFiltrados);
    console.log('++++++++++++++++++++++++');

    seguimientosFiltrados.forEach((seg) => {
      const seguimientoId = seg.id;

      console.log(seg.created_at);

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
        d.cebo_inicial += r.inicial ?? 0;
        d.merma += r.merma ?? 0;
        d.cebo_actual += r.actual ?? 0;
        d.capturados += r.cantidad ?? 0;
      });
    });

    console.log('++++++++++++++++++++++++');
    console.log(data);
    console.log('++++++++++++++++++++++++');

    return Object.values(data).map((d: any) => ({
      seguimiento: d.seguimiento,
      fecha: d.fecha,
      almacen: d.almacen,
      trampas: d.trampasSet.size,
      cebo_inicial: d.cebo_inicial,
      merma: d.merma,
      cebo_actual: d.cebo_actual,
      capturados: d.capturados,
    }));
  };

  const datosSeguimientoResumen = tablaSeguimientoResumen(seguimientos);

  const totalesResumen = datosSeguimientoResumen.reduce(
    (acc: any, row: any) => {
      acc.trampas += row.trampas;
      acc.cebo_inicial += row.cebo_inicial;
      acc.merma += row.merma;
      acc.cebo_actual += row.cebo_actual;
      acc.capturados += row.capturados;
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
        row.cebo_inicial > 0 ? (row.merma * 100) / row.cebo_inicial : 0;

      acc[row.almacen].data.push({
        fecha: new Date(row.seguimiento).toLocaleDateString('es-ES'),
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
        inicial: number;
        merma: number;
        actual: number;
        observaciones: string[];
      };
    } = {};

    seguimientos
      .filter((seg) => seg.tipo_seguimiento_id === 1) // solo DESRATIZACION
      .forEach((seg) => {
        seg.roedores.forEach((roedor) => {
          const trampaId = roedor.trampa_id;

          if (!datosPorTrampa[trampaId]) {
            datosPorTrampa[trampaId] = {
              trampa_id: trampaId,
              inicial: 0,
              merma: 0,
              actual: 0,
              observaciones: [],
            };
          }

          datosPorTrampa[trampaId].inicial += roedor.inicial;
          datosPorTrampa[trampaId].merma += roedor.merma;
          datosPorTrampa[trampaId].actual += roedor.actual;

          if (roedor.observacion) {
            datosPorTrampa[trampaId].observaciones.push(roedor.observacion);
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
      .sort((a, b) => a.trampa_id - b.trampa_id); // orden por nro trampa
  }, [seguimientos]);

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
        d.cebo_inicial += r.inicial ?? 0;
        d.merma += r.merma ?? 0;
        d.cebo_actual += r.actual ?? 0;
        d.capturados += r.cantidad ?? 0;
      });
    });

    return Object.values(data).map((d: any) => ({
      seguimiento: d.seguimiento,
      fecha: d.fecha, // ← agrega esto
      mapa: d.mapa,
      trampas: d.trampasSet.size,
      cebo_inicial: d.cebo_inicial,
      merma: d.merma,
      cebo_actual: d.cebo_actual,
      capturados: d.capturados,
    }));
  };

  const datosSeguimientoResumenX = tablaSeguimientoResumenX(seguimientos);

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

      acc[key].data.push({
        fecha: new Date(row.fecha).toLocaleDateString('es-ES'),
        fechaRaw: new Date(row.fecha), // ← para ordenar
        merma_porcentaje: Number(porcentajeMerma.toFixed(2)),
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
      (seg) => seg.tipo_seguimiento_id === 3,
    );
    const especiesSet = new Set<string>();
    seguimientosFiltrados.forEach((seg) => {
      seg.insectocutores.forEach((ins) => {
        especiesSet.add(ins.especie.nombre);
      });
    });
    const especies = Array.from(especiesSet).sort();

    const datosPorFecha = seguimientosFiltrados.map((seg) => {
      // const fecha = new Date(seg.created_at).toLocaleDateString();
      const fecha = `${new Date(seg.created_at).toLocaleDateString()}-${seg.id}`;
      const cantidadesPorEspecie: { [especie: string]: number } = {};

      especies.forEach((esp) => {
        cantidadesPorEspecie[esp] = 0;
      });

      seg.insectocutores.forEach((ins) => {
        cantidadesPorEspecie[ins.especie.nombre] += ins.cantidad;
      });

      return { fecha, cantidades: cantidadesPorEspecie };
    });

    const totales: { [especie: string]: number } = {};
    especies.forEach((esp) => {
      totales[esp] = datosPorFecha.reduce(
        (sum, dato) => sum + dato.cantidades[esp],
        0,
      );
    });

    // Promedios por especie
    const totalSeguimientos = seguimientosFiltrados.length || 1;

    const promedios: { [especie: string]: number } = {};
    especies.forEach((esp) => {
      promedios[esp] = totales[esp] / totalSeguimientos;
    });

    return { especies, datosPorFecha, totales, promedios };
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
        row[dato.fecha] = Math.floor(
          dato.cantidades[especie] /
            (datosInsectocutores.datosPorFecha.length || 1),
        );
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
    total.trampas * totalSeguimientos > 0
      ? ((total.capturas / (total.trampas * totalSeguimientos)) * 100).toFixed(
          2,
        )
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
        color: `hsl(${(index * 360) / datosInsectocutores.especies.length}, 70%, 50%)`,
      };
    });
    return config;
  }, [datosInsectocutores.especies]);

  // Configuración de colores para gráficos de roedores
  const chartConfigRoedores: ChartConfig = {
    inicial: {
      label: 'Inicial',
      // color: 'hsl(var(--chart-1))',
      color: '#f00',
    },
    merma: {
      label: 'Merma',
      // color: 'hsl(var(--chart-2))',
      color: '#0f0',
    },
    actual: {
      label: 'Actual',
      // color: 'hsl(var(--chart-3))',
      color: '#00f',
    },
  };

  /**
   * ----------------------------------------------------------------------------
   * FUNCIONES
   * ----------------------------------------------------------------------------
   */
  const buscar = () => {
    router.get(
      '/informes',
      {
        empresa_id: empresaId,
        almacen_id: almacenId,
        fecha_inicio: fechaInicio,
        fecha_fin: fechaFin,
        buscar: 1,
      },
      {
        preserveState: true,
        replace: true,
      },
    );
  };

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
  }, [
    filters.empresa_id,
    filters.almacen_id,
    filters.fecha_inicio,
    filters.fecha_fin,
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
      alert('Error al generar el PDF. Por favor, intente nuevamente.');
    } finally {
      setExportando(false);
    }
  };

  const exportarWord = async () => {
    if (!contenidoRef.current) return;

    setExportando(true);

    try {
      const seguimientoIds = seguimientos.map((s) => s.id);

      const chart1 = chartInsectosRef.current
        ? await htmlToImage.toPng(chartInsectosRef.current, {
            pixelRatio: 2,
            backgroundColor: '#ffffff',
            skipFonts: true,
          })
        : null;

      const chart2 = chartEvolucionRef.current
        ? await htmlToImage.toPng(chartEvolucionRef.current, {
            pixelRatio: 2,
            backgroundColor: '#ffffff',
            skipFonts: true,
          })
        : null;

      const chart3 = chartRoedoresLineRef.current
        ? await htmlToImage.toPng(chartRoedoresLineRef.current, {
            pixelRatio: 2,
            backgroundColor: '#ffffff',
            skipFonts: true,
          })
        : null;

      const chart4 = chartRoedoresBarRef.current
        ? await htmlToImage.toPng(chartRoedoresBarRef.current, {
            pixelRatio: 2,
            backgroundColor: '#ffffff',
            skipFonts: true,
          })
        : null;

      const chart5 = chartSeveridadRef.current
        ? await htmlToImage.toPng(chartSeveridadRef.current, {
            pixelRatio: 2,
            backgroundColor: '#ffffff',
            skipFonts: true,
          })
        : null;

      const chart6 = chartResumenTrampasRef.current
        ? await htmlToImage.toPng(chartResumenTrampasRef.current, {
            pixelRatio: 2,
            backgroundColor: '#ffffff',
            skipFonts: true,
          })
        : null;

      const capturarGrafico = async (ref: HTMLDivElement | null) => {
        if (!ref) return null;
        return await htmlToImage.toPng(ref, {
          pixelRatio: 2,
          backgroundColor: '#ffffff',
          skipFonts: true,
        });
      };

      // Gráficos dinámicos por mapa
      const chartsPorMapa = await Promise.all(
        graficosPorMapaRefs.current.map((ref) => capturarGrafico(ref)),
      );

      router.post('/informes/exportar-word', {
        chart1,
        chart2,
        chart3,
        chart4,
        chart5,
        chart6,
        // 👇 NUEVO
        charts_por_mapa: chartsPorMapa,
        seguimiento_ids: seguimientoIds,
        datosInsectocutores,
        datosRoedores,
        empresa_id: empresaId,
        almacen_id: almacenId,
        fecha_inicio: fechaInicio,
        fecha_fin: fechaFin,
      });

      // window.open('/informes/exportar-word-download');
    } catch (error) {
      console.error(error);
      alert('Error al generar Word');
    } finally {
      setExportando(false);
    }
  };

  return (
    <AppLayout breadcrumbs={[{ title: 'Informes', href: '/informes' }]}>
      <Head title="Informes" />

      <div className="space-y-6 p-6">
        {/* *********** SECCION BUSQUEDA ************************** */}
        <div className="space-y-3 p-2">
          {/* Empresa */}
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
          {/* Fechas */}
          <div className="grid grid-cols-2 gap-4">
            <Input
              type="date"
              value={fechaInicio}
              // onChange={(e) => setFechaInicio(e.target.value)}
              onChange={(e) => onFechaChange(e.target.value, fechaFin)}
            />
            <Input
              type="date"
              value={fechaFin}
              // onChange={(e) => setFechaFin(e.target.value)}
              onChange={(e) => onFechaChange(fechaInicio, e.target.value)}
            />
          </div>
          {/* Botones */}
          <div className="flex gap-4">
            <Button
              onClick={buscar}
              disabled={!empresaId || !almacenId || !fechaInicio || !fechaFin}
              // disabled={!empresaId || !fechaInicio || !fechaFin}
              className="w-[250px]"
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
                <Button
                  onClick={exportarWord}
                  className="bg-blue-800 text-white"
                >
                  <Download className="mr-2 h-4 w-4" />
                  Exportar Word
                </Button>
              </>
            )}
          </div>
        </div>

        {/* Contenido a exportar */}
        <div ref={contenidoRef} data-export className="space-y-6 bg-white">
          {/* --------------------------- DATOS DEL INFORME ----------------------------------------- */}
          {/* Encabezado del informe */}
          <div className="mb-6">
            <h1 className="text-3xl font-bold">Informe de Seguimiento</h1>
            <div className="mt-2 space-y-3 text-gray-700">
              <p>
                <strong>Empresa:</strong>{' '}
                {empresas.find((e) => e.id === Number(empresaId))?.nombre}
              </p>
              <p>
                <strong>Almacén:</strong>{' '}
                {almacenes.find((a) => a.id === Number(almacenId))?.nombre}
              </p>
              <p>
                <strong>Período:</strong> {fechaInicio} - {fechaFin}
              </p>
              <p>
                <strong>Fecha de generación:</strong>{' '}
                {new Date().toLocaleDateString()}
              </p>
            </div>
          </div>

          {/* --------------------------- LISTA DE SEGUIMIENTOS ----------------------------------------- */}
          {/* Tabla SEGUIMIENTOS */}
          <div>
            <div className="mb-2 text-[1rem] font-bold">
              TABLA: LISTA DE SEGUIMIENTOS
            </div>
            <div className="rounded-md border">
              <Table>
                <TableHeader>
                  <TableRow>
                    <TableHead>ID</TableHead>
                    <TableHead>TECNICO</TableHead>
                    <TableHead>ENCARGADO</TableHead>
                    <TableHead>TIPO</TableHead>
                    <TableHead>ALMACEN</TableHead>
                    <TableHead>FECHA</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {seguimientos.length ? (
                    seguimientos.map((s) => (
                      <TableRow key={s.id}>
                        <TableCell>{s.id}</TableCell>
                        <TableCell>{s.user.name}</TableCell>
                        <TableCell>{s.encargado_nombre}</TableCell>
                        <TableCell>{s.tipo_seguimiento.nombre}</TableCell>
                        <TableCell></TableCell>
                        <TableCell>
                          {new Date(s.created_at).toLocaleString()}
                        </TableCell>
                      </TableRow>
                    ))
                  ) : (
                    <TableRow>
                      <TableCell colSpan={2} className="text-center">
                        Sin resultados
                      </TableCell>
                    </TableRow>
                  )}
                </TableBody>
              </Table>
            </div>
          </div>

          {/* --------------------------- CANTIDAD DE TRAMPAS ----------------------------------------- */}

          <hr />
          <div className="bg-amber-300/12 p-5">
            <div className="mb-6">
              <h2 className="text-2xl font-bold">Desratización</h2>
              <h2 className="text-[1rem] font-bold">Informe de Trampas</h2>
            </div>
            <h2 className="text-[1rem] font-bold">
              TABLA: TOTAL DE CANTIDAD DE TRAMPAS
            </h2>
            <div className="rounded-md border">
              <Table>
                <TableHeader>
                  <TableRow>
                    <TableHead>ALMACEN</TableHead>
                    <TableHead>CANT. TRAMPAS</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  <TableRow>
                    <TableCell>
                      {
                        almacenes.find((a) => a.id === Number(almacenId))
                          ?.nombre
                      }
                    </TableCell>
                    <TableCell>{trampasrat}</TableCell>
                  </TableRow>
                </TableBody>
              </Table>
            </div>
            <br />
            {/* ********************* TABLA CANTIDAD DE TRAMPAS x TIPO y CANTIDAD DE ROEDORES CAPTURADOS ***************** ----------------------------------------- */}
            <h2 className="text-[1rem] font-bold">
              TABLA: CANTIDAD DE TRAMPAS POR TIPO
            </h2>
            <div className="rounded-md border">
              <Table className="">
                <TableHeader>
                  <TableRow>
                    <TableHead>Tipo</TableHead>
                    <TableHead className="text-right">Trampas</TableHead>
                    <TableHead className="text-right">Revisiones</TableHead>
                    <TableHead className="text-right">Capturas</TableHead>
                    <TableHead className="text-right">Incidencia %</TableHead>
                  </TableRow>
                </TableHeader>

                <TableBody>
                  {resumen.map((item: any) => (
                    <TableRow key={item.tipo}>
                      <TableCell className="font-medium capitalize">
                        {item.tipo}
                      </TableCell>

                      <TableCell className="text-right">
                        {item.trampas}
                      </TableCell>

                      <TableCell className="text-right">
                        {item.revisiones}
                      </TableCell>

                      <TableCell className="text-right">
                        {item.capturas}
                      </TableCell>

                      <TableCell
                        className={`text-right font-semibold ${colorIncidencia(
                          Number(item.incidencia),
                        )}`}
                      >
                        {item.incidencia}%
                      </TableCell>
                    </TableRow>
                  ))}

                  {/* TOTAL */}
                  <TableRow className="font-bold">
                    <TableCell>TOTAL</TableCell>

                    <TableCell className="text-right">
                      {total.trampas}
                    </TableCell>

                    <TableCell className="text-right">
                      {totalSeguimientos}
                    </TableCell>

                    <TableCell className="text-right">
                      {total.capturas}
                    </TableCell>

                    <TableCell
                      className={`text-right ${colorIncidencia(Number(incidenciaTotal))}`}
                    >
                      {incidenciaTotal}%
                    </TableCell>
                  </TableRow>
                </TableBody>
              </Table>
            </div>
            <br />
            {/* ********************* TABLA FECHAS DE SEGUIMIENTOS (DESRATIZACION) ***************** ----------------------------------------- */}
            <h2 className="text-[1rem] font-bold">
              TABLA: FECHAS DE SEGUIMIENTOS EMPRESA
            </h2>
            <div className="rounded-md border">
              <Table>
                <TableHeader>
                  <TableRow>
                    <TableHead>Mes</TableHead>
                    <TableHead className="text-right">Seguimientos</TableHead>
                    <TableHead className="text-right">Trampas</TableHead>
                    <TableHead className="text-right">Capturas</TableHead>
                    <TableHead className="text-right">Incidencia (%)</TableHead>
                  </TableRow>
                </TableHeader>

                <TableBody>
                  {resumenMeses.map((item: any, index: number) => (
                    <TableRow key={index}>
                      <TableCell className="font-medium capitalize">
                        {item.mes}
                      </TableCell>

                      <TableCell className="text-right">
                        {item.seguimientos}
                      </TableCell>

                      <TableCell className="text-right">
                        {item.trampas}
                      </TableCell>

                      <TableCell className="text-right">
                        {item.capturas}
                      </TableCell>

                      <TableCell className="text-right font-semibold">
                        {item.incidencia} %
                      </TableCell>
                    </TableRow>
                  ))}
                </TableBody>
              </Table>
            </div>
            <br />
            {/* ********************* TABLA CANTIDAD DE TRAMPAS x TIPO y CANTIDAD DE ROEDORES CAPTURADOS (EN CADA SEGUIMIENTO) ***************** ----------------------------------------- */}
            {/* <h2 className="text-[1rem] font-bold">
              TABLA: CAPTURA DE ROEDORES POR TRAMPAS POR ALMACEN
            </h2>
            <div className="rounded-md border">
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
            <h2 className="text-[1rem] font-bold">
              TABLA: ANALISIS DE ALMACEN
            </h2>
            <div className="rounded-md border">
              <Table>
                <TableHeader>
                  <TableRow>
                    <TableHead>ALMACÉN</TableHead>
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
                  {tablaCebo.map((item: any, index) => (
                    <TableRow key={index}>
                      <TableCell>{item.almacen}</TableCell>
                      <TableCell className="text-right">
                        {item.trampas}
                      </TableCell>
                      <TableCell className="text-right">
                        {item.ceboInicial}
                      </TableCell>
                      <TableCell className="text-right">{item.merma}</TableCell>
                      <TableCell className="text-right">
                        {item.ceboActual}
                      </TableCell>
                      <TableCell className="text-right">
                        {item.capturados}
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
                      {row.cebo_inicial}
                    </TableCell>
                    <TableCell className="text-right">{row.merma}</TableCell>
                    <TableCell className="text-right">
                      {row.cebo_actual}
                    </TableCell>
                    <TableCell className="text-right">
                      {row.capturados}
                    </TableCell>
                  </TableRow>
                ))}
                <TableRow className="bg-muted font-bold">
                  <TableCell colSpan={2}>TOTAL</TableCell>
                  <TableCell className="text-right">
                    {totalesDatosSanitario.trampas}
                  </TableCell>
                  <TableCell className="text-right">
                    {totalesDatosSanitario.cebo_inicial}
                  </TableCell>
                  <TableCell className="text-right">
                    {totalesDatosSanitario.merma}
                  </TableCell>
                  <TableCell className="text-right">
                    {totalesDatosSanitario.cebo_actual}
                  </TableCell>
                  <TableCell className="text-right">
                    {totalesDatosSanitario.capturados}
                  </TableCell>
                </TableRow>
              </TableBody>
            </Table> */}

            <h2 className="text-[1rem] font-bold">
              TABLA: ANALISIS POR FECHA DE SEGUIMIENTO
            </h2>
            <div>
              <Table>
                <TableHeader>
                  <TableRow>
                    <TableHead>SEGUIMIENTO</TableHead>
                    {/* <TableHead>FECHA</TableHead> */}
                    {/* <TableHead className="text-right">ALMACÉN</TableHead> */}
                    <TableHead className="text-right">TRAMPAS</TableHead>
                    <TableHead className="text-right">CEBO INICIAL</TableHead>
                    <TableHead className="text-right">MERMA</TableHead>
                    <TableHead className="text-right">CEBO ACTUAL</TableHead>
                    <TableHead className="text-right">PORCENTAJE</TableHead>
                    <TableHead className="text-right">
                      ROEDORES CAPTURADOS
                    </TableHead>
                  </TableRow>
                </TableHeader>

                <TableBody>
                  {datosSeguimientoResumen.map((row: any, index: number) => (
                    <TableRow key={index}>
                      {/* <TableCell>{row.seguimiento}</TableCell> */}
                      <TableCell className="font-mono text-xs text-muted-foreground sm:text-sm">
                        {new Date(row.fecha).toLocaleDateString('es-ES')}
                      </TableCell>
                      {/* <TableCell className="text-right">{row.almacen}</TableCell> */}
                      <TableCell className="text-right">
                        {row.trampas}
                      </TableCell>
                      <TableCell className="text-right">
                        {row.cebo_inicial}
                      </TableCell>
                      <TableCell className="text-right">{row.merma}</TableCell>
                      <TableCell className="text-right">
                        {row.cebo_actual}
                      </TableCell>
                      <TableCell className="text-right">
                        {((row.merma * 100) / row.cebo_inicial).toFixed(1)}%
                      </TableCell>
                      <TableCell className="text-right">
                        {row.capturados}
                      </TableCell>
                    </TableRow>
                  ))}

                  {/* TOTAL */}
                  <TableRow className="bg-muted font-bold">
                    <TableCell colSpan={1}>TOTAL</TableCell>
                    <TableCell className="text-right">
                      {totalesResumen.trampas}
                    </TableCell>
                    <TableCell className="text-right">
                      {totalesResumen.cebo_inicial}
                    </TableCell>
                    <TableCell className="text-right">
                      {totalesResumen.merma}
                    </TableCell>
                    <TableCell className="text-right">
                      {totalesResumen.cebo_actual}
                    </TableCell>
                    <TableCell className="text-right">
                      {(
                        (totalesResumen.merma * 100) /
                        totalesResumen.cebo_inicial
                      ).toFixed(2)}
                      %
                    </TableCell>
                    <TableCell className="text-right">
                      {totalesResumen.capturados}
                    </TableCell>
                  </TableRow>
                  <TableRow className="font-bold">
                    <TableCell>TOTAL</TableCell>
                    <TableCell>{totalesResumen.cebo_inicial}</TableCell>
                    <TableCell>100%</TableCell>
                  </TableRow>
                  <TableRow className="font-bold">
                    <TableCell>MERMA</TableCell>
                    <TableCell>{totalesResumen.merma}</TableCell>
                    <TableCell>
                      {(
                        (totalesResumen.merma * 100) /
                        totalesResumen.cebo_inicial
                      ).toFixed(2)}
                      %
                    </TableCell>
                  </TableRow>
                  <TableRow className="font-bold">
                    <TableCell>CAUSAS</TableCell>
                    <TableCell>
                      {porcentajeMerma < 9
                        ? 'MA'
                        : porcentajeMerma >= 9 && porcentajeMerma < 15
                          ? 'MECÁNICO'
                          : 'CONSUMO'}
                    </TableCell>
                  </TableRow>
                </TableBody>
              </Table>
            </div>
            <br />
            <h2 className="text-[1rem] font-bold">
              TABLA: ANALISIS POR FECHA DE SEGUIMIENTO Y TIPO DE TRAMPA
            </h2>
            <div className="rounded-md border">
              <Table>
                <TableHeader>
                  <TableRow>
                    <TableHead>SEGUIMIENTO</TableHead>
                    {/* <TableHead className="text-right">ALMACÉN</TableHead> */}
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
                  {datosSeguimiento.map((row: any, index: number) => (
                    <TableRow key={index}>
                      {/* <TableCell>{row.seguimiento}</TableCell> */}
                      <TableCell className="font-mono text-xs text-muted-foreground sm:text-sm">
                        {new Date(row.seguimiento).toLocaleDateString('es-ES')}
                      </TableCell>
                      {/* <TableCell className="text-right">
                        {row.almacen}
                      </TableCell> */}
                      <TableCell className="text-right">{row.tipo}</TableCell>
                      <TableCell className="text-right">
                        {row.trampas}
                      </TableCell>
                      <TableCell className="text-right">
                        {row.cebo_inicial}
                      </TableCell>
                      <TableCell className="text-right">{row.merma}</TableCell>
                      <TableCell className="text-right">
                        {row.cebo_actual}
                      </TableCell>
                      <TableCell className="text-right">
                        {row.capturados}
                      </TableCell>
                    </TableRow>
                  ))}
                  {/* FILA TOTAL */}
                  <TableRow className="bg-muted font-bold">
                    <TableCell colSpan={2}>TOTAL</TableCell>
                    <TableCell className="text-right">
                      {totalesSeguimiento.trampas}
                    </TableCell>
                    <TableCell className="text-right">
                      {totalesSeguimiento.cebo_inicial}
                    </TableCell>
                    <TableCell className="text-right">
                      {totalesSeguimiento.merma}
                    </TableCell>
                    <TableCell className="text-right">
                      {totalesSeguimiento.cebo_actual}
                    </TableCell>
                    <TableCell className="text-right">
                      {totalesSeguimiento.capturados}
                    </TableCell>
                  </TableRow>
                </TableBody>
              </Table>
            </div>
            <br />

            <h2 className="text-[1rem] font-bold">
              TABLA: ANALISIS POR FECHA DE SEGUIMIENTO Y MAPA
            </h2>
            <div className="rounded-md border">
              <Table>
                <TableHeader>
                  <TableRow>
                    <TableHead>SEGUIMIENTO</TableHead>
                    {/* <TableHead className="text-right">ALMACÉN</TableHead> */}
                    <TableHead className="text-right">MAPA</TableHead>
                    <TableHead className="text-right">TRAMPAS</TableHead>
                    <TableHead className="text-right">CEBO INICIAL</TableHead>
                    <TableHead className="text-right">MERMA</TableHead>
                    <TableHead className="text-right">CEBO ACTUAL</TableHead>
                    <TableHead className="text-right">PORCENTAJE</TableHead>
                    <TableHead className="text-right">
                      ROEDORES CAPTURADOS
                    </TableHead>
                  </TableRow>
                </TableHeader>

                <TableBody>
                  {datosSeguimientoResumenX.map((row: any, index: number) => (
                    <TableRow key={index}>
                      <TableCell className="font-mono text-xs text-muted-foreground sm:text-sm">
                        {new Date(row.fecha).toLocaleDateString('es-ES')}
                      </TableCell>
                      {/* <TableCell className="text-right">
                        {row.almacen}
                      </TableCell> */}
                      <TableCell className="text-right">{row.mapa}</TableCell>
                      <TableCell className="text-right">
                        {row.trampas}
                      </TableCell>
                      <TableCell className="text-right">
                        {row.cebo_inicial}
                      </TableCell>
                      <TableCell className="text-right">{row.merma}</TableCell>
                      <TableCell className="text-right">
                        {row.cebo_actual}
                      </TableCell>
                      <TableCell className="text-right">
                        {((row.merma * 100) / row.cebo_inicial).toFixed(1)}%
                      </TableCell>
                      <TableCell className="text-right">
                        {row.capturados}
                      </TableCell>
                    </TableRow>
                  ))}

                  {/* TOTAL - colSpan aumenta a 3 para cubrir seguimiento + almacen + mapa */}
                  <TableRow className="bg-muted font-bold">
                    <TableCell colSpan={2}>TOTAL</TableCell>
                    <TableCell className="text-right">
                      {totalesResumen.trampas}
                    </TableCell>
                    <TableCell className="text-right">
                      {totalesResumen.cebo_inicial}
                    </TableCell>
                    <TableCell className="text-right">
                      {totalesResumen.merma}
                    </TableCell>
                    <TableCell className="text-right">
                      {totalesResumen.cebo_actual}
                    </TableCell>
                    <TableCell className="text-right">
                      {(
                        (totalesResumen.merma * 100) /
                        totalesResumen.cebo_inicial
                      ).toFixed(2)}
                      %
                    </TableCell>
                    <TableCell className="text-right">
                      {totalesResumen.capturados}
                    </TableCell>
                  </TableRow>
                  <TableRow className="font-bold">
                    <TableCell>TOTAL</TableCell>
                    <TableCell>{totalesResumen.cebo_inicial}</TableCell>
                    <TableCell>100%</TableCell>
                  </TableRow>
                  <TableRow className="font-bold">
                    <TableCell>MERMA</TableCell>
                    <TableCell>{totalesResumen.merma}</TableCell>
                    <TableCell>
                      {(
                        (totalesResumen.merma * 100) /
                        totalesResumen.cebo_inicial
                      ).toFixed(2)}
                      %
                    </TableCell>
                  </TableRow>
                  <TableRow className="font-bold">
                    <TableCell>CAUSAS</TableCell>
                    <TableCell>
                      {porcentajeMerma < 9
                        ? 'MA'
                        : porcentajeMerma >= 9 && porcentajeMerma < 15
                          ? 'MECÁNICO'
                          : 'CONSUMO'}
                    </TableCell>
                  </TableRow>
                </TableBody>
              </Table>
            </div>

            {graficosPorAlmacen.map((alm: any, index: number) => (
              <div key={index} className="mb-10">
                <h3 className="mb-4 text-lg font-semibold">{alm.almacen}</h3>

                <ChartContainer
                  config={{
                    merma_porcentaje: {
                      label: '% Merma',
                    },
                  }}
                  // className="h-[300px] w-full"
                  className="h-[300px]"
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
            ))}

            {graficosPorMapa.map((item: any, index: number) => (
              <div
                key={index}
                className="mb-10"
                ref={(el) => {
                  graficosPorMapaRefs.current[index] = el;
                }}
              >
                <h3 className="mb-4 text-lg font-semibold">{item.mapa}</h3>

                <ChartContainer
                  config={{
                    merma_porcentaje: {
                      label: '% Merma',
                    },
                  }}
                  className="h-[300px]"
                >
                  <BarChart data={item.data}>
                    <CartesianGrid vertical={false} />
                    <XAxis dataKey="fecha" tickLine={false} axisLine={false} />
                    <YAxis domain={[0, 100]} tickFormatter={(v) => `${v}%`} />
                    <Tooltip formatter={(value: any) => `${value}%`} />
                    <Bar dataKey="merma_porcentaje" fill="#ef4444" radius={4} />
                  </BarChart>
                </ChartContainer>
              </div>
            ))}
            {/* ************** TABLA DE ROEDORES (CALCULAR POR CADA ALMACEN) ****************************** */}
            <h2 className="text-[1rem] font-bold">
              TABLA: SEGUIMIENTO PESO DE TRAMPAS
            </h2>
            <div className="rounded-md border">
              <div className="rounded-md border">
                <Table>
                  <TableHeader>
                    <TableRow>
                      {/* <TableHead className="font-bold">
                      Fecha de Seguimiento
                    </TableHead> */}
                      <TableHead className="text-center font-bold">
                        Nro Trampa
                      </TableHead>
                      <TableHead className="text-center font-bold">
                        Inicial
                      </TableHead>
                      <TableHead className="text-center font-bold">
                        Merma
                      </TableHead>
                      <TableHead className="text-center font-bold">
                        Actual
                      </TableHead>
                      {/* <TableHead className="font-bold">Observación</TableHead> */}
                      <TableHead className="text-center font-bold">
                        % merma
                      </TableHead>
                      <TableHead className="font-bold">RESULTADO</TableHead>
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    {datosRoedores.length > 0 ? (
                      <>
                        {datosRoedores.map((dato, index) => (
                          <TableRow key={index}>
                            {/* <TableCell className="font-medium">
                            {dato.fecha}
                          </TableCell> */}
                            <TableCell className="text-center">
                              {dato.trampa_id}
                            </TableCell>
                            <TableCell className="text-center">
                              {dato.inicial}
                            </TableCell>
                            <TableCell className="text-center">
                              {dato.merma}
                            </TableCell>
                            <TableCell className="text-center">
                              {dato.actual}
                              {/* {dato.inicial - dato.merma} */}
                            </TableCell>
                            {/* <TableCell>
                            {dato.observaciones.join(', ') || '-'}
                          </TableCell> */}
                            <TableCell className="text-center">
                              {dato.inicial > 0
                                ? ((dato.merma * 100) / dato.inicial).toFixed(2)
                                : '-'}
                            </TableCell>
                            <TableCell>
                              {dato.inicial > 0
                                ? (dato.merma * 100) / dato.inicial <= 25
                                  ? 'Medio Ambiente'
                                  : 'Consumo'
                                : '-'}
                            </TableCell>
                          </TableRow>
                        ))}
                        <TableRow className="bg-muted/50 font-bold">
                          <TableCell className="text-center">TOTAL</TableCell>
                          <TableCell className="text-center">
                            {datosRoedores.reduce(
                              (sum, dato) => sum + dato.inicial,
                              0,
                            )}
                          </TableCell>
                          <TableCell className="text-center">
                            {datosRoedores.reduce(
                              (sum, dato) => sum + dato.merma,
                              0,
                            )}
                          </TableCell>
                          <TableCell className="text-center">
                            {datosRoedores.reduce(
                              // (sum, dato) => sum + (dato.inicial - dato.merma),
                              (sum, dato) => sum + dato.actual,
                              0,
                            )}
                          </TableCell>
                          <TableCell>-</TableCell>
                          <TableCell>-</TableCell>
                        </TableRow>
                        <TableRow className="text-center">
                          <TableCell>TOTAL</TableCell>
                          <TableCell>
                            {datosRoedores.reduce(
                              (sum, dato) => sum + dato.inicial,
                              0,
                            )}
                          </TableCell>
                          <TableCell>100 %</TableCell>
                        </TableRow>
                        <TableRow className="text-center">
                          <TableCell>MERMA</TableCell>
                          <TableCell>
                            {datosRoedores.reduce(
                              (sum, dato) => sum + dato.merma,
                              0,
                            )}
                          </TableCell>
                          <TableCell>
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
                        <TableRow className="text-center">
                          <TableCell>PESO ACTUAL</TableCell>
                          <TableCell>
                            {datosRoedores.reduce(
                              (sum, dato) => sum + (dato.inicial - dato.merma),
                              0,
                            )}
                          </TableCell>
                          <TableCell>
                            {(
                              (datosRoedores.reduce(
                                (sum, dato) =>
                                  sum + (dato.inicial - dato.merma),
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
                        <TableRow className="text-center">
                          <TableCell>CONSUMO</TableCell>
                          <TableCell>
                            {datosRoedores.reduce((sum, dato) => {
                              const inicial = dato.inicial;
                              const actual = inicial - dato.merma;
                              const porcentaje = (dato.merma * 100) / inicial;

                              if (porcentaje > 25) {
                                return sum + actual;
                              }
                              return sum;
                            }, 0)}
                          </TableCell>
                          <TableCell>
                            {(
                              (datosRoedores.reduce((sum, dato) => {
                                const inicial = dato.inicial;
                                const actual = inicial - dato.merma;
                                const porcentaje = (dato.merma * 100) / inicial;

                                if (porcentaje > 25) {
                                  return sum + actual;
                                }
                                return sum;
                              }, 0) *
                                100) /
                              datosRoedores.reduce(
                                (sum, dato) =>
                                  sum + (dato.inicial - dato.merma),
                                0,
                              )
                            ).toFixed(2)}{' '}
                            %
                          </TableCell>
                        </TableRow>
                        <TableRow className="text-center">
                          <TableCell>MEDIO AMBIENTE</TableCell>
                          <TableCell>
                            {datosRoedores.reduce((sum, dato) => {
                              const inicial = dato.inicial;
                              const actual = inicial - dato.merma;
                              const porcentaje = (dato.merma * 100) / inicial;

                              if (porcentaje <= 25) {
                                return sum + actual;
                              }
                              return sum;
                            }, 0)}
                          </TableCell>
                          <TableCell>
                            {(
                              (datosRoedores.reduce((sum, dato) => {
                                const inicial = dato.inicial;
                                const actual = inicial - dato.merma;
                                const porcentaje = (dato.merma * 100) / inicial;

                                if (porcentaje <= 25) {
                                  return sum + actual;
                                }
                                return sum;
                              }, 0) *
                                100) /
                              datosRoedores.reduce(
                                (sum, dato) =>
                                  sum + (dato.inicial - dato.merma),
                                0,
                              )
                            ).toFixed(2)}{' '}
                            %
                          </TableCell>
                        </TableRow>
                      </>
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
            <br />

            {/* GRÁFICO 3: Comparación Inicial/Merma/Actual (Líneas) */}
            {datosRoedores.length > 0 && (
              <div>
                <div className="mb-4 text-[1rem] font-bold">
                  GRÁFICO: COMPARACIÓN DE PESOS POR TRAMPA
                </div>
                <ChartContainer
                  config={chartConfigRoedores}
                  className="h-[300px]"
                  ref={chartRoedoresLineRef}
                >
                  <LineChart data={datosRoedores}>
                    <CartesianGrid strokeDasharray="3 3" />
                    <XAxis
                      dataKey="trampa_id"
                      tickFormatter={(value) => `T${value}`}
                    />
                    <YAxis />
                    <ChartTooltip content={<ChartTooltipContent />} />
                    <Legend />
                    <Line
                      type="monotone"
                      dataKey="inicial"
                      stroke="var(--color-inicial)"
                      strokeWidth={2}
                      name="Inicial"
                    />
                    <Line
                      type="monotone"
                      dataKey="merma"
                      stroke="var(--color-merma)"
                      strokeWidth={2}
                      name="Merma"
                    />
                    <Line
                      type="monotone"
                      dataKey="actual"
                      stroke="var(--color-actual)"
                      strokeWidth={2}
                      name="Actual"
                    />
                  </LineChart>
                </ChartContainer>
              </div>
            )}
            <br />

            {/* GRÁFICO 4: Barras agrupadas por trampa */}
            {datosRoedores.length > 0 && (
              <div>
                <div className="mb-4 text-[1rem] font-bold">
                  GRÁFICO: VALORES POR TRAMPA
                </div>
                <ChartContainer
                  config={chartConfigRoedores}
                  className="h-[300px]"
                  ref={chartRoedoresBarRef}
                >
                  <BarChart data={datosRoedores}>
                    <CartesianGrid strokeDasharray="3 3" />
                    <XAxis
                      dataKey="trampa_id"
                      tickFormatter={(value) => `T${value}`}
                    />
                    <YAxis />
                    <ChartTooltip content={<ChartTooltipContent />} />
                    <Legend />
                    <Bar
                      dataKey="inicial"
                      fill="var(--color-inicial)"
                      radius={4}
                      name="Inicial"
                    />
                    <Bar
                      dataKey="merma"
                      fill="var(--color-merma)"
                      radius={4}
                      name="Merma"
                    />
                    <Bar
                      dataKey="actual"
                      fill="var(--color-actual)"
                      radius={4}
                      name="Actual"
                    />
                  </BarChart>
                </ChartContainer>
              </div>
            )}
            <br />

            <div className="mb-6">
              <h2 className="text-xl font-bold">Informe de Trampas</h2>
            </div>
            {/* GRÁFICO 4: Barras agrupadas por trampa */}
            {totales.length > 0 && (
              <div>
                <div className="mb-4 text-[1rem] font-bold">
                  GRÁFICO: RESUMEN
                </div>
                <ChartContainer
                  config={chartConfigRoedores}
                  className="h-[300px]"
                  ref={chartResumenTrampasRef}
                >
                  <BarChart data={totales}>
                    <CartesianGrid strokeDasharray="3 3" />
                    <XAxis
                      dataKey="mes"
                      tickFormatter={(value) => `T${value}`}
                    />
                    <YAxis />
                    <ChartTooltip content={<ChartTooltipContent />} />
                    <Legend />
                    <Bar
                      dataKey="inicial_avg"
                      fill="var(--color-inicial)"
                      radius={4}
                      name="Inicial"
                    />
                    <Bar
                      dataKey="merma_avg"
                      fill="var(--color-merma)"
                      radius={4}
                      name="Merma"
                    />
                    <Bar
                      dataKey="actual_avg"
                      fill="var(--color-actual)"
                      radius={4}
                      name="Actual"
                    />
                  </BarChart>
                </ChartContainer>
              </div>
            )}
          </div>

          {/* ********************* GRAFICA: MONITOREO DE ROEDORES (X ALMACEN) ***************** ----------------------------------------- */}

          {/* ************************************************************************************************************************** */}
          {/* --------------------------- CANTIDAD DE INSECTOCUTORES ----------------------------------------- */}
          {/* ************************************************************************************************************************** */}

          <hr />

          <div className="bg-red-700/10 p-5">
            <div className="mb-6">
              <h2 className="text-2xl font-bold">Insectocutores</h2>
              <br />
              <h2 className="text-xl font-bold">Informe de Insectocutores</h2>
            </div>
            {/* **************** INSECTOCUTORES POR ALMACEN ************************ */}
            <div className="rounded-md border">
              <Table>
                <TableHeader>
                  <TableRow>
                    <TableHead>ALMACEN</TableHead>
                    <TableHead>CANT. INSECTOCUTORES</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  <TableRow>
                    <TableCell>
                      {
                        almacenes.find((a) => a.id === Number(almacenId))
                          ?.nombre
                      }
                    </TableCell>
                    <TableCell>{trampasinsect}</TableCell>
                  </TableRow>
                </TableBody>
              </Table>
            </div>
            {/* **************** GRAFICOS DE TODOS LOS ALMACENES ************************ */}
            {/* GRÁFICO 1: CANTIDAD Totales por Especie (Barras) */}
            {datosInsectocutores.especies.length > 0 && (
              <div>
                <div className="mb-4 text-[1rem] font-bold">
                  GRÁFICO: TOTAL DE INSECTOS POR ESPECIE
                </div>
                <ChartContainer
                  config={chartConfigInsectos}
                  className="h-[300px]"
                  ref={chartInsectosRef}
                >
                  <BarChart
                    data={Object.entries(datosInsectocutores.totales).map(
                      ([especie, total]) => ({
                        especie,
                        cantidad: total,
                        fill: chartConfigInsectos[especie]?.color,
                      }),
                    )}
                    barCategoryGap="20%"
                  >
                    <CartesianGrid strokeDasharray="3 3" />
                    <XAxis dataKey="especie" />
                    <YAxis />
                    <ChartTooltip content={<ChartTooltipContent />} />
                    <Bar dataKey="cantidad" radius={8} />
                  </BarChart>
                </ChartContainer>
              </div>
            )}
            {/* **************** SECCION POR ALMACEN ************************ */}
            {/* --------------------------- INCIDENCIA ----------------------------------------- */}
            {/* TABLA DE INSECTOCUTORES "INCIDENCIA" */}
            <div>
              <div className="mb-2 text-[1rem] font-bold">
                INCIDENCIA DE INSECTOS VOLADORES{' '}
              </div>
              <div className="rounded-md border">
                <Table>
                  <TableHeader>
                    <TableRow>
                      <TableHead className="font-bold">
                        Fecha de Seguimiento
                      </TableHead>
                      {datosInsectocutores.especies.map((especie) => (
                        <TableHead
                          key={especie}
                          className="text-center font-bold"
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
                              <TableCell className="font-medium">
                                {dato.fecha}
                              </TableCell>
                              {datosInsectocutores.especies.map((especie) => (
                                <TableCell
                                  key={especie}
                                  className="text-center"
                                >
                                  {dato.cantidades[especie]}
                                </TableCell>
                              ))}
                            </TableRow>
                          ),
                        )}
                        <TableRow className="bg-muted/50 font-bold">
                          <TableCell>TOTAL</TableCell>
                          {datosInsectocutores.especies.map((especie) => (
                            <TableCell key={especie} className="text-center">
                              {datosInsectocutores.totales[especie]}
                            </TableCell>
                          ))}
                        </TableRow>
                        <TableRow>
                          <TableCell>PROMEDIO</TableCell>
                          {datosInsectocutores.especies.map((especie) => (
                            <TableCell key={especie} className="text-center">
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
                          colSpan={datosInsectocutores.especies.length + 1}
                          className="text-center"
                        >
                          Sin resultados
                        </TableCell>
                      </TableRow>
                    )}
                  </TableBody>
                </Table>
              </div>
            </div>
            {/* GRÁFICO INCIDENCIA */}
            {datosInsectocutores.especies.length > 0 && (
              <div>
                <div className="mb-4 text-[1rem] font-bold">
                  GRÁFICO DE INCIDENCIA: EVOLUCIÓN DE INSECTOS POR FECHA
                </div>
                <ChartContainer
                  config={chartConfigInsectos}
                  className="h-[300px]"
                  ref={chartEvolucionRef}
                >
                  <BarChart
                    data={datosInsectocutores.datosPorFecha.map((dato) => ({
                      fecha: dato.fecha,
                      ...dato.cantidades,
                    }))}
                    barGap={4}
                    barCategoryGap="20%"
                  >
                    <CartesianGrid strokeDasharray="3 3" />
                    <XAxis dataKey="fecha" />
                    <YAxis
                      domain={[0, 100]}
                      tickFormatter={(value) => `${value}`}
                    />
                    <ChartTooltip content={<ChartTooltipContent />} />
                    <Legend />
                    {datosInsectocutores.especies.map((especie) => (
                      <Bar
                        key={especie}
                        dataKey={especie}
                        fill={chartConfigInsectos[especie]?.color}
                        radius={4}
                      />
                    ))}
                  </BarChart>
                </ChartContainer>
              </div>
            )}
            {/* --------------------------- SEVERIDAD ----------------------------------------- */}
            {/* TABLA DE INSECTOCUTORES "SEVERIDAD" */}
            <div>
              <div className="mb-2 text-[1rem] font-bold">
                SEVERIDAD DE INSECTOS VOLADORES{' '}
              </div>
              <div className="rounded-md border">
                <Table>
                  <TableHeader>
                    <TableRow>
                      <TableHead className="font-bold">
                        Fecha de Seguimiento
                      </TableHead>
                      {datosInsectocutores.especies.map((especie) => (
                        <TableHead
                          key={especie}
                          className="text-center font-bold"
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
                              <TableCell className="font-medium">
                                {dato.fecha}
                              </TableCell>
                              {datosInsectocutores.especies.map((especie) => (
                                <TableCell
                                  key={especie}
                                  className="text-center"
                                >
                                  {Math.floor(
                                    dato.cantidades[especie] /
                                      datosInsectocutores.datosPorFecha.length,
                                  )}
                                </TableCell>
                              ))}
                            </TableRow>
                          ),
                        )}
                        <TableRow className="bg-muted/50 font-bold">
                          <TableCell>TOTAL</TableCell>
                          {datosInsectocutores.especies.map((especie) => (
                            <TableCell key={especie} className="text-center">
                              {datosInsectocutores.totales[especie]}
                            </TableCell>
                          ))}
                        </TableRow>
                        <TableRow>
                          <TableCell>PROMEDIO</TableCell>
                          {datosInsectocutores.especies.map((especie) => (
                            <TableCell key={especie} className="text-center">
                              {(
                                datosInsectocutores.promedios[especie] /
                                datosInsectocutores.datosPorFecha.length
                              ).toFixed(2)}
                            </TableCell>
                          ))}
                        </TableRow>
                      </>
                    ) : (
                      <TableRow>
                        <TableCell
                          colSpan={datosInsectocutores.especies.length + 1}
                          className="text-center"
                        >
                          Sin resultados
                        </TableCell>
                      </TableRow>
                    )}
                  </TableBody>
                </Table>
              </div>
            </div>
            {/* GRÁFICO SEVERIDAD */}
            {datosInsectocutores.especies.length > 0 && (
              <div>
                <div className="mb-4 text-[1rem] font-bold">
                  GRÁFICO DE SEVERIDAD
                </div>
                <ChartContainer
                  config={chartConfigInsectos}
                  className="h-[300px]"
                  ref={chartSeveridadRef}
                >
                  <BarChart
                    data={dataSeveridadPivot}
                    barGap={4}
                    barCategoryGap="20%"
                  >
                    <CartesianGrid strokeDasharray="3 3" />

                    {/* AHORA X ES ESPECIE */}
                    <XAxis dataKey="especie" />

                    <YAxis
                      domain={[0, 33]}
                      tickFormatter={(value) => `${value}`}
                    />

                    <ChartTooltip content={<ChartTooltipContent />} />
                    <Legend />

                    {/* LAS BARRAS SON LAS FECHAS */}
                    {datosInsectocutores.datosPorFecha.map((dato, index) => (
                      <Bar
                        key={dato.fecha}
                        dataKey={dato.fecha}
                        fill={`hsl(${(index * 360) / datosInsectocutores.datosPorFecha.length},70%,50%)`}
                        radius={4}
                        name={dato.fecha}
                      />
                    ))}
                  </BarChart>
                </ChartContainer>
              </div>
            )}
          </div>
        </div>
      </div>
    </AppLayout>
  );
}
