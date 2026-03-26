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
import { tableStyles } from '@/lib/table-styles';
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
  trampa_tipo_id: number;
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

interface Props {
  empresas: Empresa[];
  almacenes: Almacen[];
  seguimientos: Seguimiento[];
  acciones: Accion[];
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
  acciones,
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

  console.log('@@@@');
  console.log(acciones);
  console.log('@@@@');

  const totalesPorcentajes = (totales: TotalData[]) => {
    const data: any = {};
    totales.forEach((tot, index) => {
      // console.log('--');
      // console.log(tot);
      data[index] = {
        mes: tot.mes,
        inicial_sum: tot.inicial_sum,
        inicial_por: (100).toFixed(2),
        merma_sum: tot.merma_sum,
        merma_por: ((tot.merma_sum * 100) / tot.inicial_sum).toFixed(2),
        actual_sum: tot.actual_sum,
        actual_por: ((tot.actual_sum * 100) / tot.inicial_sum).toFixed(2),
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
  console.log('***************');
  console.log(totalesPorcentajesValues);
  console.log('***************');

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
        acc[tipo].capturas += Number(r.cantidad) ?? 0;

        return acc;
      }, {}),
  ).map((item: any) => {
    const trampas = item.trampas.size;
    const capturas = Number(item.capturas);

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
      acc.capturas += Number(item.capturas);
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

  const datosSeguimiento = tablaSanitariaPorSeguimiento(seguimientos);

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

    console.log('++++++++++++++++++++++++');
    console.log(seguimientosFiltrados);
    console.log('++++++++++++++++++++++++');

    seguimientosFiltrados.forEach((seg) => {
      const seguimientoId = Number(seg.id);

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
        d.cebo_inicial += Number(r.inicial) ?? 0;
        d.merma += Number(r.merma) ?? 0;
        d.cebo_actual += Number(r.actual) ?? 0;
        d.capturados += Number(r.cantidad) ?? 0;
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
      .filter((seg) => Number(seg.tipo_seguimiento_id) === 1) // solo DESRATIZACION
      .forEach((seg) => {
        seg.roedores.forEach((roedor) => {
          const trampaId = Number(roedor.trampa_id);
          console.log('**** TRAMPA_TIPO_ID: ' + roedor.trampa.trampa_tipo_id);

          if (Number(roedor.trampa.trampa_tipo_id) !== 4) {
            if (!datosPorTrampa[trampaId]) {
              datosPorTrampa[trampaId] = {
                trampa_id: trampaId,
                inicial: 0,
                merma: 0,
                actual: 0,
                observaciones: [],
              };
            }

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
      // const fecha = new Date(seg.created_at).toLocaleDateString();
      const fecha = `${new Date(seg.created_at).toLocaleDateString()}-${seg.id}`;
      const cantidadesPorEspecie: { [especie: string]: number } = {};

      especies.forEach((esp) => {
        cantidadesPorEspecie[esp] = 0;
      });

      seg.insectocutores.forEach((ins) => {
        cantidadesPorEspecie[ins.especie.nombre] += Number(ins.cantidad);
      });

      return { fecha, cantidades: cantidadesPorEspecie };
    });

    const totales: { [especie: string]: number } = {};
    especies.forEach((esp) => {
      totales[esp] = datosPorFecha.reduce(
        (sum, dato) => sum + Number(dato.cantidades[esp]),
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
        color: `hsl(${(index * 160) / datosInsectocutores.especies.length}, 60%, 48%)`,
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
        charts_por_mapa_titulos: graficosPorMapa.map((g: any) => g.mapa), // ← títulos
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
      alert('Error al generar Word');
    } finally {
      setExportando(false);
    }
  };

  // COLORES
  const coloresRoedores = {
    inicial: {
      label: 'inicial',
      color: '#8064a2',
    },
    merma: {
      label: 'merma',
      color: '#bb4d4b',
    },
    actual: {
      label: 'actual',
      color: '#9bbb59',
    },
  };

  const coloresInsectos = {
    mosquito: '#f79647',
    mosca: '#33558b',
    polilla: '#4aacc5',
  };

  return (
    <AppLayout breadcrumbs={[{ title: 'Informes', href: '/informes' }]}>
      <Head title="Informes" />

      <div className="space-y-6 p-6">
        {/* *********** SECCION BUSQUEDA ************************** */}
        <div className="space-y-3 p-2">
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
          {/* Fechas */}

          <div className="grid grid-cols-2 gap-4">
            <div>
              <Label>Fecha inicial</Label>
              <Input
                type="date"
                value={fechaInicio}
                // onChange={(e) => setFechaInicio(e.target.value)}
                onChange={(e) => onFechaChange(e.target.value, fechaFin)}
              />
            </div>
            <div>
              <Label>Fecha final</Label>
              <Input
                type="date"
                value={fechaFin}
                // onChange={(e) => setFechaFin(e.target.value)}
                onChange={(e) => onFechaChange(fechaInicio, e.target.value)}
              />
            </div>
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
                <strong>Período:</strong>{' '}
                {new Date(fechaInicio).toLocaleDateString('es-ES')} -{' '}
                {new Date(fechaFin).toLocaleDateString('es-ES')}
              </p>
              <p>
                <strong>Fecha de generación:</strong>{' '}
                {new Date().toLocaleDateString('es-ES')}
              </p>
            </div>
          </div>

          {/* --------------------------- LISTA DE SEGUIMIENTOS ----------------------------------------- */}
          {/* Tabla SEGUIMIENTOS */}
          <div>
            <div className="font-mono text-[1rem] underline">
              TABLA: LISTA DE SEGUIMIENTOS
            </div>
            <div className="w-full overflow-x-auto rounded-lg border border-slate-200 shadow-sm">
              <Table className={tableStyles.table}>
                <TableHeader>
                  <TableRow className={tableStyles.header.row}>
                    <TableHead className={tableStyles.header.cell}>
                      ID
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
              <h2 className="text-[1rem]">Informe de Trampas</h2>
            </div>
            <h2 className="font-mono text-[1rem] underline">
              TABLA 1: CANTIDAD TOTAL DE TRAMPAS
            </h2>
            <div className="rounded-md border">
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
            <h2 className="font-mono text-[1rem] underline">
              TABLA 2: CANTIDAD DE TRAMPAS POR TIPO
            </h2>
            <div className="rounded-md border">
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
                      {totalSeguimientos}
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
            <h2 className="font-mono text-[1rem] underline">
              TABLA 3: FECHAS DE SEGUIMIENTOS EN ALMACEN
            </h2>
            <div className="rounded-md border">
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
            <h2 className="font-mono text-[1rem] underline">
              TABLA 4: ANALISIS TOTALES DE ALMACEN
            </h2>
            <div className="rounded-md border">
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
                        {item.ceboInicial}
                      </TableCell>
                      <TableCell className={tableStyles.cell}>
                        {item.merma}
                      </TableCell>
                      <TableCell className={tableStyles.cell}>
                        {item.ceboActual}
                      </TableCell>
                      <TableCell className={tableStyles.cell}>
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

            <h2 className="font-mono text-[1rem] underline">
              TABLA 5: ANALISIS POR FECHA DE SEGUIMIENTO
            </h2>
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
                        {row.cebo_inicial}
                      </TableCell>
                      <TableCell className={tableStyles.cell}>
                        {row.merma}
                      </TableCell>
                      <TableCell className={tableStyles.cell}>
                        {row.cebo_actual}
                      </TableCell>
                      <TableCell className={tableStyles.cell}>
                        {((row.merma * 100) / row.cebo_inicial).toFixed(1)}%
                      </TableCell>
                      <TableCell className={tableStyles.cell}>
                        {row.capturados}
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
                      {totalesResumen.cebo_inicial}
                    </TableCell>
                    <TableCell className={tableStyles.totalCell}>
                      {totalesResumen.merma}
                    </TableCell>
                    <TableCell className={tableStyles.totalCell}>
                      {totalesResumen.cebo_actual}
                    </TableCell>
                    <TableCell className={tableStyles.totalCell}>
                      {(
                        (totalesResumen.merma * 100) /
                        totalesResumen.cebo_inicial
                      ).toFixed(2)}
                      %
                    </TableCell>
                    <TableCell className={tableStyles.totalCell}>
                      {totalesResumen.capturados}
                    </TableCell>
                  </TableRow>

                  <TableRow className={tableStyles.totalRow}>
                    <TableCell className={tableStyles.totalCell}>
                      TOTAL
                    </TableCell>
                    <TableCell className={tableStyles.totalNumeric}>
                      {totalesResumen.cebo_inicial}
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
                      {totalesResumen.merma}
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
            <h2 className="font-mono text-[1rem] underline">
              TABLA 6: ANALISIS POR FECHA DE SEGUIMIENTO Y TIPO DE TRAMPA
            </h2>
            <div className="rounded-md border">
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
                        {row.cebo_inicial}
                      </TableCell>
                      <TableCell className={tableStyles.cell}>
                        {row.merma}
                      </TableCell>
                      <TableCell className={tableStyles.cell}>
                        {row.cebo_actual}
                      </TableCell>
                      <TableCell className={tableStyles.cell}>
                        {row.capturados}
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
                      {totalesSeguimiento.cebo_inicial}
                    </TableCell>
                    <TableCell className={tableStyles.totalCell}>
                      {totalesSeguimiento.merma}
                    </TableCell>
                    <TableCell className={tableStyles.totalCell}>
                      {totalesSeguimiento.cebo_actual}
                    </TableCell>
                    <TableCell className={tableStyles.totalCell}>
                      {totalesSeguimiento.capturados}
                    </TableCell>
                  </TableRow>
                </TableBody>
              </Table>
            </div>
            <br />

            <h2 className="font-mono text-[1rem] font-bold underline">
              TABLA 7: ANALISIS POR FECHA DE SEGUIMIENTO Y MAPA
            </h2>
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
                        {row.cebo_inicial}
                      </TableCell>
                      <TableCell className={tableStyles.cell}>
                        {row.merma}
                      </TableCell>
                      <TableCell className={tableStyles.cell}>
                        {row.cebo_actual}
                      </TableCell>
                      <TableCell className={tableStyles.cell}>
                        {((row.merma * 100) / row.cebo_inicial).toFixed(1)}%
                      </TableCell>
                      <TableCell className={tableStyles.cell}>
                        {row.capturados}
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
                      {totalesResumen.cebo_inicial}
                    </TableCell>
                    <TableCell className={tableStyles.totalCell}>
                      {totalesResumen.merma}
                    </TableCell>
                    <TableCell className={tableStyles.totalCell}>
                      {totalesResumen.cebo_actual}
                    </TableCell>
                    <TableCell className={tableStyles.totalCell}>
                      {(
                        (totalesResumen.merma * 100) /
                        totalesResumen.cebo_inicial
                      ).toFixed(2)}
                      %
                    </TableCell>
                    <TableCell className={tableStyles.totalCell}>
                      {totalesResumen.capturados}
                    </TableCell>
                  </TableRow>
                  <TableRow className={tableStyles.totalRow}>
                    <TableCell className={tableStyles.totalCell}>
                      TOTAL
                    </TableCell>
                    <TableCell className={tableStyles.totalNumeric}>
                      {totalesResumen.cebo_inicial}
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
                      {totalesResumen.merma}
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
            ))} */}

            {graficosPorMapa.map((item: any, index: number) => (
              <div key={index} className="mb-10">
                <h3 className="font-mono">
                  GRAFICO: {item.mapa} - PORCENTAJES
                </h3>
                <br />

                <ChartContainer
                  config={{
                    merma_porcentaje: {
                      label: '% Merma',
                    },
                  }}
                  className="h-[300px]"
                  ref={(el) => {
                    graficosPorMapaRefs.current[index] = el;
                  }}
                >
                  <BarChart data={item.data}>
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
                      fill={coloresRoedores.merma.color}
                      radius={4}
                    >
                      <LabelList
                        dataKey="merma_porcentaje"
                        position="top"
                        fontSize={12}
                        // formatter={(value: number) => value.toFixed(2)}
                      />
                    </Bar>
                    <Bar
                      dataKey="actual_porcentaje"
                      fill={coloresRoedores.actual.color}
                      radius={4}
                    >
                      <LabelList
                        dataKey="actual_porcentaje"
                        position="top"
                        fontSize={12}
                        // formatter={(value: number) => value.toFixed(2)}
                      />
                    </Bar>
                    <Bar
                      dataKey="total_porcentaje"
                      fill={coloresRoedores.inicial.color}
                      radius={4}
                    >
                      <LabelList
                        dataKey="total_porcentaje"
                        position="top"
                        fontSize={12}
                        // formatter={(value: number) => value.toFixed(2)}
                      />
                    </Bar>
                  </BarChart>
                </ChartContainer>
              </div>
            ))}
            {/* ************** TABLA DE ROEDORES (CALCULAR POR CADA ALMACEN) ****************************** */}
            <h2 className="font-mono text-[1rem] underline">
              TABLA 8: SEGUIMIENTO PESO DE TRAMPAS
            </h2>
            <div className="rounded-md border">
              <Table className={tableStyles.table}>
                <TableHeader>
                  <TableRow className={tableStyles.header.row}>
                    <TableHead className={tableStyles.header.cell}>
                      Nro Trampa
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
                            {dato.trampa_id}
                          </TableCell>
                          <TableCell className={tableStyles.cell}>
                            {dato.inicial}
                          </TableCell>
                          <TableCell className={tableStyles.cell}>
                            {dato.merma}
                          </TableCell>
                          <TableCell className={tableStyles.cell}>
                            {dato.actual}
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
                        <TableCell className={tableStyles.totalCell}>
                          TOTAL
                        </TableCell>
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
                        <TableCell className={tableStyles.totalCell}>
                          TOTAL
                        </TableCell>
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
                        <TableCell className={tableStyles.totalCell}>
                          MERMA
                        </TableCell>
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
                        <TableCell className={tableStyles.totalCell}>
                          PESO ACTUAL
                        </TableCell>
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
                        <TableCell className={tableStyles.totalCell}>
                          MERMA CONSUMO
                        </TableCell>
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
                        <TableCell className={tableStyles.totalCell}>
                          MERMA M.A.
                        </TableCell>
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
                      <TableCell colSpan={6} className={tableStyles.totalRow}>
                        Sin resultados
                      </TableCell>
                    </TableRow>
                  )}
                </TableBody>
              </Table>
            </div>

            <br />

            {/* GRÁFICO 3: Comparación Inicial/Merma/Actual (Líneas) */}
            {datosRoedores.length > 0 && (
              <div>
                <div className="font-mono">
                  GRÁFICO: COMPARACIÓN DE PESOS POR TRAMPA
                </div>
                <br />
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
                      className="font-bold"
                      label={{
                        value: '--- TRAMPA ---',
                        position: 'insideBottom',
                        offset: 0,
                      }}
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
                      <LabelList
                        dataKey="inicial"
                        position="top"
                        fontSize={12}
                        // formatter={(value: number) => value.toFixed(2)}
                      />
                    </Line>
                    <Line
                      type="monotone"
                      dataKey="merma"
                      stroke={coloresRoedores.merma.color}
                      strokeWidth={2}
                      name="Merma"
                    >
                      <LabelList
                        dataKey="merma"
                        position="top"
                        fontSize={12}
                        // formatter={(value: number) => value.toFixed(2)}
                      />
                    </Line>
                    <Line
                      type="monotone"
                      dataKey="actual"
                      stroke={coloresRoedores.actual.color}
                      strokeWidth={2}
                      name="Actual"
                    >
                      <LabelList
                        dataKey="actual"
                        position="top"
                        fontSize={12}
                        // formatter={(value: number) => value.toFixed(2)}
                      />
                    </Line>
                  </LineChart>
                </ChartContainer>
              </div>
            )}
            <br />

            {/* GRÁFICO 4: Barras agrupadas por trampa */}
            {datosRoedores.length > 0 && (
              <div>
                <div className="font-mono">GRÁFICO: VALORES POR TRAMPA</div>
                <br />
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
                      className="font-bold"
                      label={{
                        value: '--- TRAMPA ---',
                        position: 'insideBottom',
                        offset: 0,
                      }}
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
                      fill={coloresRoedores.inicial.color}
                      radius={4}
                      name="Inicial"
                    >
                      <LabelList
                        dataKey="inicial"
                        position="top"
                        fontSize={12}
                        // formatter={(value: number) => value.toFixed(2)}
                      />
                    </Bar>
                    <Bar
                      dataKey="merma"
                      fill={coloresRoedores.merma.color}
                      radius={4}
                      name="Merma"
                    >
                      <LabelList
                        dataKey="merma"
                        position="top"
                        fontSize={12}
                        // formatter={(value: number) => value.toFixed(2)}
                      />
                    </Bar>
                    <Bar
                      dataKey="actual"
                      fill={coloresRoedores.actual.color}
                      radius={4}
                      name="Actual"
                    >
                      <LabelList
                        dataKey="actual"
                        position="top"
                        fontSize={12}
                        // formatter={(value: number) => value.toFixed(2)}
                      />
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
                <div className="mb-4 text-[1rem] font-bold">
                  GRÁFICO: RESUMEN
                </div>
                <ChartContainer
                  config={chartConfigRoedores}
                  className="h-[300px]"
                  ref={chartResumenTrampasRef}
                >
                  <BarChart data={totalesPorcentajesValues}>
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
                      fill={coloresRoedores.inicial.color}
                      radius={4}
                      name="Inicial"
                    >
                      <LabelList
                        dataKey="inicial_por"
                        position="top"
                        fontSize={12}
                        // formatter={(value: number) => value.toFixed(2)}
                      />
                    </Bar>
                    <Bar
                      dataKey="merma_por"
                      fill={coloresRoedores.merma.color}
                      radius={4}
                      name="Merma"
                    >
                      <LabelList
                        dataKey="merma_por"
                        position="top"
                        fontSize={12}
                        // formatter={(value: number) => value.toFixed(2)}
                      />
                    </Bar>
                    <Bar
                      dataKey="actual_por"
                      fill={coloresRoedores.actual.color}
                      radius={4}
                      name="Actual"
                    >
                      <LabelList
                        dataKey="actual_por"
                        position="top"
                        fontSize={12}
                        // formatter={(value: number) => value.toFixed(2)}
                      />
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

          <hr />

          <div className="bg-red-700/10 p-5">
            <div className="mb-6">
              <h2 className="text-2xl font-bold">Insectocutores</h2>
              <h2 className="text-[1rem]">Informe de Insectocutores</h2>
            </div>
            {/* **************** INSECTOCUTORES POR ALMACEN ************************ */}
            <h2 className="font-mono text-[1rem] underline">
              TABLA 9: CANTIDAD TOTAL DE INSECTOCUTORES
            </h2>
            <div className="rounded-md border">
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
                <div className="font-mono">
                  GRAFICO: TOTAL DE INSECTOS POR ESPECIE
                </div>
                <br />
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
                    <XAxis
                      dataKey="especie"
                      className="font-bold"
                      label={{
                        value: '--- ESPECIES ---',
                        position: 'insideBottom',
                        offset: 0,
                      }}
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
                        fontSize={12}
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
              <div className="font-mono text-[1rem] underline">
                TABLA 10: INCIDENCIA DE INSECTOS VOLADORES{' '}
              </div>
              <div className="rounded-md border">
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
                                {dato.fecha}
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
                <div className="font-mono">
                  GRÁFICO DE INCIDENCIA: EVOLUCIÓN DE INSECTOS POR FECHA
                </div>
                <br />
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
                    <XAxis
                      dataKey="fecha"
                      className="font-bold"
                      label={{
                        value: '--- Fechas de seguimiento ---',
                        position: 'insideBottom',
                        offset: 0,
                      }}
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
                    {datosInsectocutores.especies.map((especie) => (
                      <Bar
                        key={especie}
                        dataKey={especie}
                        fill={chartConfigInsectos[especie]?.color}
                        radius={4}
                      >
                        <LabelList
                          dataKey={especie}
                          position="top"
                          fontSize={12}
                        />
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
              <div className="font-mono text-[1rem] underline">
                TABLA 11: SEVERIDAD DE INSECTOS VOLADORES{' '}
              </div>
              <div className="rounded-md border">
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
                                {dato.fecha}
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
                              {/* {datosInsectocutores.totales[especie]} */}
                              {(
                                datosInsectocutores.totales[especie] / 3
                              ).toFixed(0)}
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
                              {/* {(
                                datosInsectocutores.promedios[especie] /
                                datosInsectocutores.datosPorFecha.length
                              ).toFixed(2)} */}
                              {(
                                datosInsectocutores.promedios[especie] / 3
                              ).toFixed(0)}
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
                <div className="font-mono">GRÁFICO DE SEVERIDAD</div>
                <br />
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

                    <XAxis
                      dataKey="especie"
                      className="font-bold"
                      label={{
                        value: '--- ESPECIES ---',
                        position: 'insideBottom',
                        offset: 0,
                      }}
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
                        // fill={`hsl(${(index * 360) / datosInsectocutores.datosPorFecha.length},70%,50%)`}
                        fill={`hsl(${(index * 160) / datosInsectocutores.especies.length}, 60%, 48%)`}
                        radius={4}
                        name={dato.fecha}
                      >
                        <LabelList
                          dataKey={dato.fecha}
                          position="top"
                          fontSize={12}
                        />
                      </Bar>
                    ))}
                  </BarChart>
                </ChartContainer>
              </div>
            )}
          </div>
          <div className="mt-10">
            <div className="text-2xl font-bold underline">
              ACCIONES COMPLEMENTARIAS
            </div>
            {acciones.map((dato, index) => (
              <div className="">
                <div>
                  Fecha:{' '}
                  <span>
                    {new Date(dato.created_at).toLocaleDateString('es-ES')}
                  </span>
                </div>
                <div>
                  Descripcion: <span>{dato.descripcion}</span>
                </div>
                <div>
                  IMAGENES:
                  {dato.imagenes.map((img) => (
                    <img src={img.imagen} alt="" width={300} />
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
