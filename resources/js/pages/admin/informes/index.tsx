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
import html2canvas from 'html2canvas';
import jsPDF from 'jspdf';
import { Download } from 'lucide-react';
import { useMemo, useRef, useState } from 'react';
import {
  Bar,
  BarChart,
  CartesianGrid,
  Legend,
  Line,
  LineChart,
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

interface Seguimiento {
  id: number;
  created_at: string;
  insectocutores: Insectocutor[];
  roedores: Roedor[];
}

interface Props {
  empresas: Empresa[];
  almacenes: Almacen[];
  seguimientos: Seguimiento[];
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
  filters,
}: Props) {
  const [empresaId, setEmpresaId] = useState(filters.empresa_id?.toString());
  const [almacenId, setAlmacenId] = useState(filters.almacen_id?.toString());
  const [fechaInicio, setFechaInicio] = useState(filters.fecha_inicio ?? '');
  const [fechaFin, setFechaFin] = useState(filters.fecha_fin ?? '');
  const [exportando, setExportando] = useState(false);

  const contenidoRef = useRef<HTMLDivElement>(null);

  console.log(seguimientos);

  // Procesar datos de insectocutores
  const datosInsectocutores = useMemo(() => {
    const especiesSet = new Set<string>();
    seguimientos.forEach((seg) => {
      seg.insectocutores.forEach((ins) => {
        especiesSet.add(ins.especie.nombre);
      });
    });
    const especies = Array.from(especiesSet).sort();

    const datosPorFecha = seguimientos.map((seg) => {
      const fecha = new Date(seg.created_at).toLocaleDateString();
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

    return { especies, datosPorFecha, totales };
  }, [seguimientos]);

  // Procesar datos de roedores
  const datosRoedores = useMemo(() => {
    const datosPorFechaTrampa: {
      [key: string]: {
        fecha: string;
        trampa_id: number;
        inicial: number;
        merma: number;
        actual: number;
        observaciones: string[];
      };
    } = {};

    seguimientos.forEach((seg) => {
      const fecha = new Date(seg.created_at).toLocaleDateString();

      seg.roedores.forEach((roedor) => {
        const key = `${fecha}-${roedor.trampa_id}`;

        if (!datosPorFechaTrampa[key]) {
          datosPorFechaTrampa[key] = {
            fecha,
            trampa_id: roedor.trampa_id,
            inicial: 0,
            merma: 0,
            actual: 0,
            observaciones: [],
          };
        }

        datosPorFechaTrampa[key].inicial += roedor.inicial;
        datosPorFechaTrampa[key].merma += roedor.merma;
        datosPorFechaTrampa[key].actual += roedor.actual;
        if (roedor.observacion) {
          datosPorFechaTrampa[key].observaciones.push(roedor.observacion);
        }
      });
    });

    return Object.values(datosPorFechaTrampa).sort((a, b) => {
      if (a.fecha !== b.fecha) {
        return a.fecha.localeCompare(b.fecha);
      }
      return a.trampa_id - b.trampa_id;
    });
  }, [seguimientos]);

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
      color: 'hsl(var(--chart-1))',
    },
    merma: {
      label: 'Merma',
      color: 'hsl(var(--chart-2))',
    },
    actual: {
      label: 'Actual',
      color: 'hsl(var(--chart-3))',
    },
  };

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

  const onEmpresaChange = (value: string) => {
    setEmpresaId(value);
    setAlmacenId(undefined);
    setFechaInicio('');
    setFechaFin('');

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

  const exportarPDF = async () => {
    if (!contenidoRef.current) return;

    setExportando(true);

    try {
      const elemento = contenidoRef.current;

      // Clonar el elemento para no afectar el DOM original
      const clone = elemento.cloneNode(true) as HTMLElement;

      // Convertir colores oklch a rgb en el clon
      const convertirColores = (el: HTMLElement) => {
        const computedStyle = window.getComputedStyle(el);

        // Convertir background-color
        if (computedStyle.backgroundColor) {
          el.style.backgroundColor = computedStyle.backgroundColor;
        }

        // Convertir color
        if (computedStyle.color) {
          el.style.color = computedStyle.color;
        }

        // Convertir border-color
        if (computedStyle.borderColor) {
          el.style.borderColor = computedStyle.borderColor;
        }

        // Convertir fill y stroke para SVG
        if (computedStyle.fill && computedStyle.fill !== 'none') {
          el.style.fill = computedStyle.fill;
        }
        if (computedStyle.stroke && computedStyle.stroke !== 'none') {
          el.style.stroke = computedStyle.stroke;
        }

        // Recursivamente para todos los hijos
        Array.from(el.children).forEach((child) => {
          convertirColores(child as HTMLElement);
        });
      };

      // Aplicar conversión de colores
      convertirColores(clone);

      // Agregar el clon temporalmente al DOM
      clone.style.position = 'absolute';
      clone.style.left = '-9999px';
      clone.style.top = '0';
      document.body.appendChild(clone);

      // Crear el canvas del contenido clonado
      const canvas = await html2canvas(clone, {
        scale: 2,
        useCORS: true,
        logging: false,
        backgroundColor: '#ffffff',
        onclone: (clonedDoc) => {
          // Asegurar que todos los estilos estén aplicados
          const clonedElement = clonedDoc.querySelector('[data-export]');
          if (clonedElement) {
            (clonedElement as HTMLElement).style.display = 'block';
          }
        },
      });

      // Remover el clon del DOM
      document.body.removeChild(clone);

      const imgData = canvas.toDataURL('image/png');

      const pdf = new jsPDF({
        orientation: 'landscape',
        unit: 'mm',
        format: 'a4',
      });

      const imgWidth = 297;
      const pageHeight = 210;
      const imgHeight = (canvas.height * imgWidth) / canvas.width;
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

  return (
    <AppLayout breadcrumbs={[{ title: 'Informes', href: '/informes' }]}>
      <Head title="Informes" />

      <div className="space-y-6 p-6">
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
          onValueChange={setAlmacenId}
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
            onChange={(e) => setFechaInicio(e.target.value)}
          />
          <Input
            type="date"
            value={fechaFin}
            onChange={(e) => setFechaFin(e.target.value)}
          />
        </div>

        {/* Botones */}
        <div className="flex gap-4">
          <Button
            onClick={buscar}
            disabled={!empresaId || !almacenId || !fechaInicio || !fechaFin}
          >
            Buscar
          </Button>

          {seguimientos.length > 0 && (
            <Button
              onClick={exportarPDF}
              disabled={exportando}
              variant="outline"
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
          )}
        </div>

        {/* Contenido a exportar */}
        <div ref={contenidoRef} data-export className="space-y-6 bg-white p-6">
          {/* Encabezado del informe */}
          <div className="mb-6">
            <h1 className="text-2xl font-bold">Informe de Seguimiento</h1>
            <div className="mt-2 text-sm text-gray-600">
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

          {/* Tabla SEGUIMIENTOS */}
          <div>
            <div className="mb-2 text-[1rem] font-bold">SEGUIMIENTOS</div>
            <Table>
              <TableHeader>
                <TableRow>
                  <TableHead>ID</TableHead>
                  <TableHead>Fecha</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {seguimientos.length ? (
                  seguimientos.map((s) => (
                    <TableRow key={s.id}>
                      <TableCell>{s.id}</TableCell>
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

          {/* TABLA DE INSECTOCUTORES */}
          <div>
            <div className="mb-2 text-[1rem] font-bold">
              INCIDENCIA DE INSECTOS VOLADORES
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
                      {datosInsectocutores.datosPorFecha.map((dato, index) => (
                        <TableRow key={index}>
                          <TableCell className="font-medium">
                            {dato.fecha}
                          </TableCell>
                          {datosInsectocutores.especies.map((especie) => (
                            <TableCell key={especie} className="text-center">
                              {dato.cantidades[especie]}
                            </TableCell>
                          ))}
                        </TableRow>
                      ))}
                      <TableRow className="bg-muted/50 font-bold">
                        <TableCell>TOTAL</TableCell>
                        {datosInsectocutores.especies.map((especie) => (
                          <TableCell key={especie} className="text-center">
                            {datosInsectocutores.totales[especie]}
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

          {/* GRÁFICO 1: Totales por Especie (Barras) */}
          {datosInsectocutores.especies.length > 0 && (
            <div>
              <div className="mb-4 text-[1rem] font-bold">
                GRÁFICO: TOTAL DE INSECTOS POR ESPECIE
              </div>
              <ChartContainer
                config={chartConfigInsectos}
                className="h-[300px]"
              >
                <BarChart
                  data={Object.entries(datosInsectocutores.totales).map(
                    ([especie, total]) => ({
                      especie,
                      cantidad: total,
                      fill: chartConfigInsectos[especie]?.color,
                    }),
                  )}
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

          {/* GRÁFICO 2: Evolución por Fecha (Barras Apiladas) */}
          {datosInsectocutores.especies.length > 0 && (
            <div>
              <div className="mb-4 text-[1rem] font-bold">
                GRÁFICO: EVOLUCIÓN DE INSECTOS POR FECHA
              </div>
              <ChartContainer
                config={chartConfigInsectos}
                className="h-[300px]"
              >
                <BarChart
                  data={datosInsectocutores.datosPorFecha.map((dato) => ({
                    fecha: dato.fecha,
                    ...dato.cantidades,
                  }))}
                >
                  <CartesianGrid strokeDasharray="3 3" />
                  <XAxis dataKey="fecha" />
                  <YAxis />
                  <ChartTooltip content={<ChartTooltipContent />} />
                  <Legend />
                  {datosInsectocutores.especies.map((especie) => (
                    <Bar
                      key={especie}
                      dataKey={especie}
                      stackId="a"
                      fill={chartConfigInsectos[especie]?.color}
                    />
                  ))}
                </BarChart>
              </ChartContainer>
            </div>
          )}

          {/* TABLA DE ROEDORES */}
          <div>
            <div className="mb-2 text-[1rem] font-bold">
              SEGUIMIENTO PESO DE TRAMPAS
            </div>
            <div className="rounded-md border">
              <Table>
                <TableHeader>
                  <TableRow>
                    <TableHead className="font-bold">
                      Fecha de Seguimiento
                    </TableHead>
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
                    <TableHead className="font-bold">Observación</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {datosRoedores.length > 0 ? (
                    <>
                      {datosRoedores.map((dato, index) => (
                        <TableRow key={index}>
                          <TableCell className="font-medium">
                            {dato.fecha}
                          </TableCell>
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
                          </TableCell>
                          <TableCell>
                            {dato.observaciones.join(', ') || '-'}
                          </TableCell>
                        </TableRow>
                      ))}
                      <TableRow className="bg-muted/50 font-bold">
                        <TableCell colSpan={2}>TOTAL</TableCell>
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
                            (sum, dato) => sum + dato.actual,
                            0,
                          )}
                        </TableCell>
                        <TableCell>-</TableCell>
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

          {/* GRÁFICO 3: Comparación Inicial/Merma/Actual (Líneas) */}
          {datosRoedores.length > 0 && (
            <div>
              <div className="mb-4 text-[1rem] font-bold">
                GRÁFICO: COMPARACIÓN DE PESOS POR TRAMPA
              </div>
              <ChartContainer
                config={chartConfigRoedores}
                className="h-[300px]"
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

          {/* GRÁFICO 4: Barras agrupadas por trampa */}
          {datosRoedores.length > 0 && (
            <div>
              <div className="mb-4 text-[1rem] font-bold">
                GRÁFICO: VALORES POR TRAMPA
              </div>
              <ChartContainer
                config={chartConfigRoedores}
                className="h-[300px]"
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
        </div>
      </div>
    </AppLayout>
  );
}
// *************************************************************
// import { Button } from '@/components/ui/button';
// import {
//   ChartConfig,
//   ChartContainer,
//   ChartTooltip,
//   ChartTooltipContent,
// } from '@/components/ui/chart';
// import { Input } from '@/components/ui/input';
// import {
//   Select,
//   SelectContent,
//   SelectItem,
//   SelectTrigger,
//   SelectValue,
// } from '@/components/ui/select';
// import {
//   Table,
//   TableBody,
//   TableCell,
//   TableHead,
//   TableHeader,
//   TableRow,
// } from '@/components/ui/table';
// import AppLayout from '@/layouts/app-layout';
// import { Head, router } from '@inertiajs/react';
// import { useMemo, useState } from 'react';
// import {
//   Bar,
//   BarChart,
//   CartesianGrid,
//   Line,
//   LineChart,
//   XAxis,
//   YAxis,
// } from 'recharts';

// interface Empresa {
//   id: number;
//   nombre: string;
// }

// interface Almacen {
//   id: number;
//   nombre: string;
// }

// interface Especie {
//   id: number;
//   nombre: string;
// }

// interface Insectocutor {
//   id: number;
//   trampa_id: number;
//   especie: Especie;
//   cantidad: number;
// }

// interface Roedor {
//   id: number;
//   trampa_id: number;
//   observacion: string;
//   inicial: number;
//   actual: number;
//   merma: number;
// }

// interface Seguimiento {
//   id: number;
//   created_at: string;
//   insectocutores: Insectocutor[];
//   roedores: Roedor[];
// }

// interface Props {
//   empresas: Empresa[];
//   almacenes: Almacen[];
//   seguimientos: Seguimiento[];
//   filters: {
//     empresa_id?: number;
//     almacen_id?: number;
//     fecha_inicio?: string;
//     fecha_fin?: string;
//   };
// }

// export default function Lista({
//   empresas,
//   almacenes,
//   seguimientos,
//   filters,
// }: Props) {
//   const [empresaId, setEmpresaId] = useState(filters.empresa_id?.toString());
//   const [almacenId, setAlmacenId] = useState(filters.almacen_id?.toString());
//   const [fechaInicio, setFechaInicio] = useState(filters.fecha_inicio ?? '');
//   const [fechaFin, setFechaFin] = useState(filters.fecha_fin ?? '');

//   console.log(seguimientos);

//   // Procesar datos de insectocutores
//   const datosInsectocutores = useMemo(() => {
//     // Obtener todas las especies únicas
//     const especiesSet = new Set<string>();
//     seguimientos.forEach((seg) => {
//       seg.insectocutores.forEach((ins) => {
//         especiesSet.add(ins.especie.nombre);
//       });
//     });
//     const especies = Array.from(especiesSet).sort();

//     // Agrupar por fecha de seguimiento
//     const datosPorFecha = seguimientos.map((seg) => {
//       const fecha = new Date(seg.created_at).toLocaleDateString();
//       const cantidadesPorEspecie: { [especie: string]: number } = {};

//       // Inicializar todas las especies en 0
//       especies.forEach((esp) => {
//         cantidadesPorEspecie[esp] = 0;
//       });

//       // Sumar cantidades por especie
//       seg.insectocutores.forEach((ins) => {
//         cantidadesPorEspecie[ins.especie.nombre] += ins.cantidad;
//       });

//       return { fecha, cantidades: cantidadesPorEspecie };
//     });

//     // Calcular totales por especie
//     const totales: { [especie: string]: number } = {};
//     especies.forEach((esp) => {
//       totales[esp] = datosPorFecha.reduce(
//         (sum, dato) => sum + dato.cantidades[esp],
//         0,
//       );
//     });

//     return { especies, datosPorFecha, totales };
//   }, [seguimientos]);

//   // Procesar datos de roedores
//   const datosRoedores = useMemo(() => {
//     // Agrupar por fecha y trampa
//     const datosPorFechaTrampa: {
//       [key: string]: {
//         fecha: string;
//         trampa_id: number;
//         inicial: number;
//         merma: number;
//         actual: number;
//         observaciones: string[];
//       };
//     } = {};

//     seguimientos.forEach((seg) => {
//       const fecha = new Date(seg.created_at).toLocaleDateString();

//       seg.roedores.forEach((roedor) => {
//         const key = `${fecha}-${roedor.trampa_id}`;

//         if (!datosPorFechaTrampa[key]) {
//           datosPorFechaTrampa[key] = {
//             fecha,
//             trampa_id: roedor.trampa_id,
//             inicial: 0,
//             merma: 0,
//             actual: 0,
//             observaciones: [],
//           };
//         }

//         datosPorFechaTrampa[key].inicial += roedor.inicial;
//         datosPorFechaTrampa[key].merma += roedor.merma;
//         datosPorFechaTrampa[key].actual += roedor.actual;
//         if (roedor.observacion) {
//           datosPorFechaTrampa[key].observaciones.push(roedor.observacion);
//         }
//       });
//     });

//     return Object.values(datosPorFechaTrampa).sort((a, b) => {
//       if (a.fecha !== b.fecha) {
//         return a.fecha.localeCompare(b.fecha);
//       }
//       return a.trampa_id - b.trampa_id;
//     });
//   }, [seguimientos]);

//   const buscar = () => {
//     router.get(
//       '/informes',
//       {
//         empresa_id: empresaId,
//         almacen_id: almacenId,
//         fecha_inicio: fechaInicio,
//         fecha_fin: fechaFin,
//         buscar: 1,
//       },
//       {
//         preserveState: true,
//         replace: true,
//       },
//     );
//   };

//   const onEmpresaChange = (value: string) => {
//     setEmpresaId(value);
//     setAlmacenId(undefined);
//     setFechaInicio('');
//     setFechaFin('');

//     router.get(
//       '/informes',
//       { empresa_id: value },
//       {
//         preserveState: true,
//         replace: true,
//         only: ['almacenes', 'filters'],
//       },
//     );
//   };

//   return (
//     <AppLayout breadcrumbs={[{ title: 'Informes', href: '/informes' }]}>
//       <Head title="Informes" />

//       <div className="space-y-6 p-6">
//         {/* Empresa */}
//         <Select value={empresaId} onValueChange={onEmpresaChange}>
//           <SelectTrigger>
//             <SelectValue placeholder="Seleccione empresa" />
//           </SelectTrigger>
//           <SelectContent>
//             {empresas.map((e) => (
//               <SelectItem key={e.id} value={String(e.id)}>
//                 {e.nombre}
//               </SelectItem>
//             ))}
//           </SelectContent>
//         </Select>
//         {/* Almacén */}
//         <Select
//           value={almacenId}
//           onValueChange={setAlmacenId}
//           disabled={!empresaId}
//         >
//           <SelectTrigger>
//             <SelectValue placeholder="Seleccione almacén" />
//           </SelectTrigger>
//           <SelectContent>
//             {almacenes.map((a) => (
//               <SelectItem key={a.id} value={String(a.id)}>
//                 {a.nombre}
//               </SelectItem>
//             ))}
//           </SelectContent>
//         </Select>
//         {/* Fechas */}
//         <div className="grid grid-cols-2 gap-4">
//           <Input
//             type="date"
//             value={fechaInicio}
//             onChange={(e) => setFechaInicio(e.target.value)}
//           />
//           <Input
//             type="date"
//             value={fechaFin}
//             onChange={(e) => setFechaFin(e.target.value)}
//           />
//         </div>
//         {/* Botón buscar */}
//         <Button
//           onClick={buscar}
//           disabled={!empresaId || !almacenId || !fechaInicio || !fechaFin}
//         >
//           Buscar
//         </Button>
//         {/* TABLA DE INSECTOCUTORES - NUEVA VERSIÓN */}
//         <div className="text-[1rem] font-bold">
//           INCIDENCIA DE INSECTOS VOLADORES
//         </div>
//         <div className="rounded-md border">
//           <Table>
//             <TableHeader>
//               <TableRow>
//                 <TableHead className="font-bold">
//                   Fecha de Seguimiento
//                 </TableHead>
//                 {datosInsectocutores.especies.map((especie) => (
//                   <TableHead key={especie} className="text-center font-bold">
//                     {especie}
//                   </TableHead>
//                 ))}
//               </TableRow>
//             </TableHeader>
//             <TableBody>
//               {datosInsectocutores.datosPorFecha.length > 0 ? (
//                 <>
//                   {datosInsectocutores.datosPorFecha.map((dato, index) => (
//                     <TableRow key={index}>
//                       <TableCell className="font-medium">
//                         {dato.fecha}
//                       </TableCell>
//                       {datosInsectocutores.especies.map((especie) => (
//                         <TableCell key={especie} className="text-center">
//                           {dato.cantidades[especie]}
//                         </TableCell>
//                       ))}
//                     </TableRow>
//                   ))}
//                   {/* Fila de TOTALES */}
//                   <TableRow className="bg-muted/50 font-bold">
//                     <TableCell>TOTAL</TableCell>
//                     {datosInsectocutores.especies.map((especie) => (
//                       <TableCell key={especie} className="text-center">
//                         {datosInsectocutores.totales[especie]}
//                       </TableCell>
//                     ))}
//                   </TableRow>
//                 </>
//               ) : (
//                 <TableRow>
//                   <TableCell
//                     colSpan={datosInsectocutores.especies.length + 1}
//                     className="text-center"
//                   >
//                     Sin resultados
//                   </TableCell>
//                 </TableRow>
//               )}
//             </TableBody>
//           </Table>
//         </div>
//         // Después de tu tabla de insectocutores, agrega:
//         <div className="mt-6">
//           <div className="mb-4 text-[1rem] font-bold">
//             GRÁFICO DE INSECTOS POR ESPECIE
//           </div>
//           <ChartContainer
//             config={datosInsectocutores.especies.reduce(
//               (acc, especie, index) => {
//                 acc[especie] = {
//                   label: especie,
//                   color: `hsl(${(index * 360) / datosInsectocutores.especies.length}, 70%, 50%)`,
//                 };
//                 return acc;
//               },
//               {} as ChartConfig,
//             )}
//             className="h-[300px]"
//           >
//             <BarChart
//               data={Object.entries(datosInsectocutores.totales).map(
//                 ([especie, total]) => ({
//                   especie,
//                   cantidad: total,
//                 }),
//               )}
//             >
//               <CartesianGrid strokeDasharray="3 3" />
//               <XAxis dataKey="especie" />
//               <YAxis />
//               <ChartTooltip content={<ChartTooltipContent />} />
//               <Bar dataKey="cantidad" fill="var(--color-especie)" radius={8} />
//             </BarChart>
//           </ChartContainer>
//         </div>
//         <div className="mt-6">
//           <div className="mb-4 text-[1rem] font-bold">
//             EVOLUCIÓN DE INSECTOS POR FECHA
//           </div>
//           <ChartContainer
//             config={datosInsectocutores.especies.reduce(
//               (acc, especie, index) => {
//                 acc[especie] = {
//                   label: especie,
//                   color: `hsl(${(index * 360) / datosInsectocutores.especies.length}, 70%, 50%)`,
//                 };
//                 return acc;
//               },
//               {} as ChartConfig,
//             )}
//             className="h-[300px]"
//           >
//             <BarChart
//               data={datosInsectocutores.datosPorFecha.map((dato) => ({
//                 fecha: dato.fecha,
//                 ...dato.cantidades,
//               }))}
//             >
//               <CartesianGrid strokeDasharray="3 3" />
//               <XAxis dataKey="fecha" />
//               <YAxis />
//               <ChartTooltip content={<ChartTooltipContent />} />
//               {datosInsectocutores.especies.map((especie) => (
//                 <Bar
//                   key={especie}
//                   dataKey={especie}
//                   stackId="a"
//                   fill={`var(--color-${especie})`}
//                   radius={[4, 4, 0, 0]}
//                 />
//               ))}
//             </BarChart>
//           </ChartContainer>
//         </div>
//         {/* TABLA DE ROEDORES - NUEVA VERSIÓN */}
//         <div className="text-[1rem] font-bold">SEGUIMIENTO PESO DE TRAMPAS</div>
//         <div className="rounded-md border">
//           <Table>
//             <TableHeader>
//               <TableRow>
//                 <TableHead className="font-bold">
//                   Fecha de Seguimiento
//                 </TableHead>
//                 <TableHead className="text-center font-bold">
//                   Nro Trampa
//                 </TableHead>
//                 <TableHead className="text-center font-bold">Inicial</TableHead>
//                 <TableHead className="text-center font-bold">Merma</TableHead>
//                 <TableHead className="text-center font-bold">Actual</TableHead>
//                 <TableHead className="font-bold">Observación</TableHead>
//               </TableRow>
//             </TableHeader>
//             <TableBody>
//               {datosRoedores.length > 0 ? (
//                 <>
//                   {datosRoedores.map((dato, index) => (
//                     <TableRow key={index}>
//                       <TableCell className="font-medium">
//                         {dato.fecha}
//                       </TableCell>
//                       <TableCell className="text-center">
//                         {dato.trampa_id}
//                       </TableCell>
//                       <TableCell className="text-center">
//                         {dato.inicial}
//                       </TableCell>
//                       <TableCell className="text-center">
//                         {dato.merma}
//                       </TableCell>
//                       <TableCell className="text-center">
//                         {dato.actual}
//                       </TableCell>
//                       <TableCell>
//                         {dato.observaciones.join(', ') || '-'}
//                       </TableCell>
//                     </TableRow>
//                   ))}
//                   {/* Fila de TOTALES */}
//                   <TableRow className="bg-muted/50 font-bold">
//                     <TableCell colSpan={2}>TOTAL</TableCell>
//                     <TableCell className="text-center">
//                       {datosRoedores.reduce(
//                         (sum, dato) => sum + dato.inicial,
//                         0,
//                       )}
//                     </TableCell>
//                     <TableCell className="text-center">
//                       {datosRoedores.reduce((sum, dato) => sum + dato.merma, 0)}
//                     </TableCell>
//                     <TableCell className="text-center">
//                       {datosRoedores.reduce(
//                         (sum, dato) => sum + dato.actual,
//                         0,
//                       )}
//                     </TableCell>
//                     <TableCell>-</TableCell>
//                   </TableRow>
//                 </>
//               ) : (
//                 <TableRow>
//                   <TableCell colSpan={6} className="text-center">
//                     Sin resultados
//                   </TableCell>
//                 </TableRow>
//               )}
//             </TableBody>
//           </Table>
//         </div>
//         <div className="mt-6">
//           <div className="mb-4 text-[1rem] font-bold">
//             GRÁFICO DE PESO DE TRAMPAS
//           </div>
//           <ChartContainer
//             config={
//               {
//                 inicial: {
//                   label: 'Inicial',
//                   color: 'hsl(var(--chart-1))',
//                 },
//                 merma: {
//                   label: 'Merma',
//                   color: 'hsl(var(--chart-2))',
//                 },
//                 actual: {
//                   label: 'Actual',
//                   color: 'hsl(var(--chart-3))',
//                 },
//               } satisfies ChartConfig
//             }
//             className="h-[300px]"
//           >
//             <LineChart data={datosRoedores}>
//               <CartesianGrid strokeDasharray="3 3" />
//               <XAxis
//                 dataKey="trampa_id"
//                 tickFormatter={(value) => `T${value}`}
//               />
//               <YAxis />
//               <ChartTooltip content={<ChartTooltipContent />} />
//               <Line
//                 type="monotone"
//                 dataKey="inicial"
//                 stroke="var(--color-inicial)"
//                 strokeWidth={2}
//               />
//               <Line
//                 type="monotone"
//                 dataKey="merma"
//                 stroke="var(--color-merma)"
//                 strokeWidth={2}
//               />
//               <Line
//                 type="monotone"
//                 dataKey="actual"
//                 stroke="var(--color-actual)"
//                 strokeWidth={2}
//               />
//             </LineChart>
//           </ChartContainer>
//         </div>
//       </div>
//     </AppLayout>
//   );
// }
// *************************************************************
// import { Button } from '@/components/ui/button';
// import { Input } from '@/components/ui/input';
// import {
//   Select,
//   SelectContent,
//   SelectItem,
//   SelectTrigger,
//   SelectValue,
// } from '@/components/ui/select';
// import {
//   Table,
//   TableBody,
//   TableCell,
//   TableHead,
//   TableHeader,
//   TableRow,
// } from '@/components/ui/table';
// import AppLayout from '@/layouts/app-layout';
// import { Head, router } from '@inertiajs/react';
// import { useState } from 'react';

// interface Empresa {
//   id: number;
//   nombre: string;
// }

// interface Almacen {
//   id: number;
//   nombre: string;
// }

// interface Especie {
//   id: number;
//   nombre: string;
// }

// interface Insectocutor {
//   id: number;
//   trampa_id: number;
//   especie: Especie;
//   cantidad: number;
// }

// interface Roedor {
//   id: number;
//   trampa_id: number;
//   observacion: string;
//   inicial: number;
//   actual: number;
//   merma: number;
// }

// interface Seguimiento {
//   id: number;
//   created_at: string;
//   insectocutores: Insectocutor[];
//   roedores: Roedor[];
// }

// interface Props {
//   empresas: Empresa[];
//   almacenes: Almacen[];
//   seguimientos: Seguimiento[];
//   filters: {
//     empresa_id?: number;
//     almacen_id?: number;
//     fecha_inicio?: string;
//     fecha_fin?: string;
//   };
// }

// export default function Lista({
//   empresas,
//   almacenes,
//   seguimientos,
//   filters,
// }: Props) {
//   const [empresaId, setEmpresaId] = useState(filters.empresa_id?.toString());
//   const [almacenId, setAlmacenId] = useState(filters.almacen_id?.toString());
//   const [fechaInicio, setFechaInicio] = useState(filters.fecha_inicio ?? '');
//   const [fechaFin, setFechaFin] = useState(filters.fecha_fin ?? '');

//   console.log(seguimientos);

//   const buscar = () => {
//     router.get(
//       '/informes',
//       {
//         empresa_id: empresaId,
//         almacen_id: almacenId,
//         fecha_inicio: fechaInicio,
//         fecha_fin: fechaFin,
//         buscar: 1, // 👈 flag importante
//       },
//       {
//         preserveState: true,
//         replace: true,
//       },
//     );
//   };

//   const onEmpresaChange = (value: string) => {
//     setEmpresaId(value);
//     setAlmacenId(undefined);
//     setFechaInicio('');
//     setFechaFin('');

//     router.get(
//       '/informes',
//       { empresa_id: value },
//       {
//         preserveState: true,
//         replace: true,
//         only: ['almacenes', 'filters'],
//       },
//     );
//   };

//   return (
//     <AppLayout breadcrumbs={[{ title: 'Informes', href: '/informes' }]}>
//       <Head title="Informes" />

//       <div className="space-y-6 p-6">
//         {/* Empresa */}
//         <Select value={empresaId} onValueChange={onEmpresaChange}>
//           <SelectTrigger>
//             <SelectValue placeholder="Seleccione empresa" />
//           </SelectTrigger>
//           <SelectContent>
//             {empresas.map((e) => (
//               <SelectItem key={e.id} value={String(e.id)}>
//                 {e.nombre}
//               </SelectItem>
//             ))}
//           </SelectContent>
//         </Select>

//         {/* Almacén */}
//         <Select
//           value={almacenId}
//           onValueChange={setAlmacenId}
//           disabled={!empresaId}
//         >
//           <SelectTrigger>
//             <SelectValue placeholder="Seleccione almacén" />
//           </SelectTrigger>
//           <SelectContent>
//             {almacenes.map((a) => (
//               <SelectItem key={a.id} value={String(a.id)}>
//                 {a.nombre}
//               </SelectItem>
//             ))}
//           </SelectContent>
//         </Select>

//         {/* Fechas */}
//         <div className="grid grid-cols-2 gap-4">
//           <Input
//             type="date"
//             value={fechaInicio}
//             onChange={(e) => setFechaInicio(e.target.value)}
//           />
//           <Input
//             type="date"
//             value={fechaFin}
//             onChange={(e) => setFechaFin(e.target.value)}
//           />
//         </div>

//         {/* Botón buscar */}
//         <Button
//           onClick={buscar}
//           disabled={!empresaId || !almacenId || !fechaInicio || !fechaFin}
//         >
//           Buscar
//         </Button>

//         {/* Tabla */}
//         <div className="text-[1rem] font-bold">SEGUIMIENTOS</div>
//         <Table>
//           <TableHeader>
//             <TableRow>
//               <TableHead>ID</TableHead>
//               <TableHead>Fecha</TableHead>
//             </TableRow>
//           </TableHeader>
//           <TableBody>
//             {seguimientos.length ? (
//               seguimientos.map((s) => (
//                 <TableRow key={s.id}>
//                   <TableCell>{s.id}</TableCell>
//                   <TableCell>
//                     {new Date(s.created_at).toLocaleString()}
//                   </TableCell>
//                 </TableRow>
//               ))
//             ) : (
//               <TableRow>
//                 <TableCell colSpan={2} className="text-center">
//                   Sin resultados
//                 </TableCell>
//               </TableRow>
//             )}
//           </TableBody>
//         </Table>

//         {/* TABLA DE INSECTOCUTORES */}
//         <div className="text-[1rem] font-bold">
//           INCIDENCIA DE INSECTOS VOLADORES
//         </div>
//         <Table>
//           <TableHeader>
//             <TableRow>
//               <TableHead>Fecha</TableHead>
//               <TableHead>Nro Trampa</TableHead>
//               <TableHead>Especie</TableHead>
//               <TableHead>Cantidad</TableHead>
//             </TableRow>
//           </TableHeader>
//           <TableBody>
//             {seguimientos.length ? (
//               seguimientos.flatMap((seg) =>
//                 seg.insectocutores.map((ins) => (
//                   <TableRow key={`${seg.id}-${ins.id}`}>
//                     <TableCell>
//                       {new Date(seg.created_at).toLocaleDateString()}
//                     </TableCell>
//                     <TableCell>{ins.trampa_id}</TableCell>
//                     <TableCell>{ins.especie.nombre}</TableCell>
//                     <TableCell>{ins.cantidad}</TableCell>
//                   </TableRow>
//                 )),
//               )
//             ) : (
//               <TableRow>
//                 <TableCell colSpan={4} className="text-center">
//                   Sin resultados
//                 </TableCell>
//               </TableRow>
//             )}
//           </TableBody>
//         </Table>
//         {/* TABLA DE ROEDORES */}
//         <div className="text-[1rem] font-bold">SEGUIMIENTO PESO DE TRAMPAS</div>
//         <Table>
//           <TableHeader>
//             <TableRow>
//               <TableHead>Fecha</TableHead>
//               <TableHead>Nro Trampa</TableHead>
//               <TableHead>Inicial</TableHead>
//               <TableHead>Merma</TableHead>
//               <TableHead>Actual</TableHead>
//               <TableHead>Observacion</TableHead>
//             </TableRow>
//           </TableHeader>
//           <TableBody>
//             {seguimientos.length ? (
//               seguimientos.flatMap((seg) =>
//                 seg.roedores.map((ins) => (
//                   <TableRow key={`${seg.id}-${ins.id}`}>
//                     <TableCell>
//                       {new Date(seg.created_at).toLocaleDateString()}
//                     </TableCell>
//                     <TableCell>{ins.trampa_id}</TableCell>
//                     <TableCell>{ins.inicial}</TableCell>
//                     <TableCell>{ins.merma}</TableCell>
//                     <TableCell>{ins.actual}</TableCell>
//                     <TableCell>{ins.observacion}</TableCell>
//                   </TableRow>
//                 )),
//               )
//             ) : (
//               <TableRow>
//                 <TableCell colSpan={4} className="text-center">
//                   Sin resultados
//                 </TableCell>
//               </TableRow>
//             )}
//           </TableBody>
//         </Table>
//       </div>
//     </AppLayout>
//   );
// }

// ------------------------------------------------------
// import {
//   Select,
//   SelectContent,
//   SelectItem,
//   SelectTrigger,
//   SelectValue,
// } from '@/components/ui/select';
// import {
//   Table,
//   TableBody,
//   TableCell,
//   TableHead,
//   TableHeader,
//   TableRow,
// } from '@/components/ui/table';
// import AppLayout from '@/layouts/app-layout';
// import { Head, router } from '@inertiajs/react';

// interface Empresa {
//   id: number;
//   nombre: string;
// }

// interface Almacen {
//   id: number;
//   nombre: string;
// }

// interface Seguimiento {
//   id: number;
//   created_at: string;
// }

// interface Props {
//   empresas: Empresa[];
//   almacenes: Almacen[];
//   seguimientos: Seguimiento[];
//   filters: {
//     empresa_id?: number;
//     almacen_id?: number;
//   };
// }

// export default function Lista({
//   empresas,
//   almacenes,
//   seguimientos,
//   filters,
// }: Props) {
//   const onEmpresaChange = (value: string) => {
//     router.get(
//       '/informes',
//       { empresa_id: value },
//       { preserveState: true, replace: true },
//     );
//   };

//   const onAlmacenChange = (value: string) => {
//     router.get(
//       '/informes',
//       {
//         empresa_id: filters.empresa_id,
//         almacen_id: value,
//       },
//       { preserveState: true, replace: true },
//     );
//   };

//   return (
//     <AppLayout breadcrumbs={[{ title: 'Informes', href: '/informes' }]}>
//       <Head title="Informes" />

//       <div className="space-y-6">
//         {/* Empresa */}
//         <Select
//           value={filters.empresa_id?.toString()}
//           onValueChange={onEmpresaChange}
//         >
//           <SelectTrigger>
//             <SelectValue placeholder="Seleccione empresa" />
//           </SelectTrigger>
//           <SelectContent>
//             {empresas.map((e) => (
//               <SelectItem key={e.id} value={String(e.id)}>
//                 {e.nombre}
//               </SelectItem>
//             ))}
//           </SelectContent>
//         </Select>

//         {/* Almacén */}
//         <Select
//           value={filters.almacen_id?.toString()}
//           onValueChange={onAlmacenChange}
//           disabled={!filters.empresa_id}
//         >
//           <SelectTrigger>
//             <SelectValue placeholder="Seleccione almacén" />
//           </SelectTrigger>
//           <SelectContent>
//             {almacenes.map((a) => (
//               <SelectItem key={a.id} value={String(a.id)}>
//                 {a.nombre}
//               </SelectItem>
//             ))}
//           </SelectContent>
//         </Select>

//         {/* Tabla */}
//         <Table>
//           <TableHeader>
//             <TableRow>
//               <TableHead>ID</TableHead>
//               <TableHead>Fecha</TableHead>
//             </TableRow>
//           </TableHeader>
//           <TableBody>
//             {seguimientos.length > 0 ? (
//               seguimientos.map((s) => (
//                 <TableRow key={s.id}>
//                   <TableCell>{s.id}</TableCell>
//                   <TableCell>
//                     {new Date(s.created_at).toLocaleString()}
//                   </TableCell>
//                 </TableRow>
//               ))
//             ) : (
//               <TableRow>
//                 <TableCell colSpan={2} className="text-center">
//                   No hay seguimientos
//                 </TableCell>
//               </TableRow>
//             )}
//           </TableBody>
//         </Table>
//       </div>
//     </AppLayout>
//   );
// }
