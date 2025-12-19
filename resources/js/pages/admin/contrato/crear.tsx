import { Button } from '@/components/ui/button';
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from '@/components/ui/card';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import AppLayout from '@/layouts/app-layout';
import { type BreadcrumbItem } from '@/types';
import { Head, router, useForm } from '@inertiajs/react';
import { Calendar, Plus, Trash2 } from 'lucide-react';
import { FormEventHandler, useMemo } from 'react';

const breadcrumbs: BreadcrumbItem[] = [
  { title: 'Contratos', href: '/contratos' },
];

// interface Contacto {
//   id: number;
//   nombre: string;
//   telefono?: string;
// }

interface AlmacenTrampa {
  descripcion: string;
  cantidad: number;
  visitas: number;
  precio: number;
  total: number;
  fechas_visitas?: string[];
}

interface AlmacenArea {
  descripcion: string;
  area: number;
  visitas: number;
  precio: number;
  total: number;
  fechas_visitas?: string[];
}

interface Almacen {
  id?: number;
  nombre: string;
  direccion: string;
  telefono: string;
  email: string;
  ciudad: string;
  // contacto_id: number;
  almacen_trampa: AlmacenTrampa;
  almacen_area: AlmacenArea;
}

interface Cotizacion {
  id?: number;
  nombre: string;
  direccion: string;
  telefono: string;
  email: string;
  ciudad: string;
  fecha_fin_contrato: string;
  total: number;
  // acuenta: number;
  // saldo: number;
  almacenes: Almacen[];
}

interface Props {
  cotizacion?: Cotizacion;
  // contactos: Contacto[];
}

export default function CotizacionForm({ cotizacion }: Props) {
  const { data, setData, post, put, processing, errors } = useForm<Cotizacion>({
    nombre: cotizacion?.nombre ?? '',
    direccion: cotizacion?.direccion ?? '',
    telefono: cotizacion?.telefono ?? '',
    email: cotizacion?.email ?? '',
    ciudad: cotizacion?.ciudad ?? '',
    fecha_fin_contrato: cotizacion?.fecha_fin_contrato ?? '',
    total: cotizacion?.total ?? 0,
    // acuenta: cotizacion?.acuenta ?? 0,
    // saldo: cotizacion?.saldo ?? 0,

    almacenes:
      cotizacion?.almacenes?.length > 0
        ? cotizacion.almacenes.map((a) => ({
            id: a.id,
            nombre: a.nombre ?? '',
            direccion: a.direccion ?? '',
            telefono: a.telefono ?? '',
            email: a.email ?? '',
            ciudad: a.ciudad ?? '',
            // contacto_id: a.contacto_id ?? contactos[0]?.id ?? 0,
            almacen_trampa: {
              descripcion:
                a.almacen_trampa?.descripcion ??
                'Control de roedores con trampas',
              cantidad: a.almacen_trampa?.cantidad ?? 0,
              visitas: a.almacen_trampa?.visitas ?? 1,
              precio: a.almacen_trampa?.precio ?? 0,
              total: a.almacen_trampa?.total ?? 0,
              fechas_visitas:
                a.almacen_trampa?.fechas_visitas ?? Array(1).fill(''),
            },
            almacen_area: {
              descripcion: a.almacen_area?.descripcion ?? 'Fumigación general',
              area: a.almacen_area?.area ?? 0,
              visitas: a.almacen_area?.visitas ?? 1,
              precio: a.almacen_area?.precio ?? 0,
              total: a.almacen_area?.total ?? 0,
              fechas_visitas:
                a.almacen_area?.fechas_visitas ?? Array(1).fill(''),
            },
          }))
        : [
            {
              nombre: '',
              direccion: '',
              telefono: '',
              email: '',
              ciudad: '',
              // contacto_id: contactos[0]?.id ?? 0,
              almacen_trampa: {
                descripcion: 'Control de roedores con trampas',
                cantidad: 0,
                visitas: 1,
                precio: 0,
                total: 0,
                fechas_visitas: Array(1).fill(''),
              },
              almacen_area: {
                descripcion: 'Fumigación general',
                area: 0,
                visitas: 1,
                precio: 0,
                total: 0,
                fechas_visitas: Array(1).fill(''),
              },
            },
          ],
  });

  // === CÁLCULO AUTOMÁTICO DE TOTALES ===
  const calcularTotalTrampas = (
    cantidad: number,
    visitas: number,
    precio: number,
  ) => {
    return cantidad * visitas * precio;
  };

  const calcularTotalArea = (area: number, visitas: number, precio: number) => {
    return area * visitas * precio;
  };

  // Actualizar totales cuando cambian los campos
  const updateTrampaField = (
    index: number,
    field: keyof AlmacenTrampa,
    value: number | string,
  ) => {
    const updated = [...data.almacenes];
    const trampa = { ...updated[index].almacen_trampa };

    if (field === 'descripcion') {
      trampa.descripcion = value as string;
    } else if (field === 'visitas') {
      const newVisitas = Number(value);
      trampa.visitas = newVisitas;
      // Ajustar el array de fechas según la cantidad de visitas
      const currentFechas = trampa.fechas_visitas || [];
      if (newVisitas > currentFechas.length) {
        trampa.fechas_visitas = [
          ...currentFechas,
          ...Array(newVisitas - currentFechas.length).fill(''),
        ];
      } else {
        trampa.fechas_visitas = currentFechas.slice(0, newVisitas);
      }
    } else if (field !== 'fechas_visitas') {
      (trampa[field] as number) = Number(value);
    }

    trampa.total = calcularTotalTrampas(
      trampa.cantidad,
      trampa.visitas,
      trampa.precio,
    );
    updated[index].almacen_trampa = trampa;

    setData('almacenes', updated);
  };

  const updateAreaField = (
    index: number,
    field: keyof AlmacenArea,
    value: number | string,
  ) => {
    const updated = [...data.almacenes];
    const area = { ...updated[index].almacen_area };

    if (field === 'descripcion') {
      area.descripcion = value as string;
    } else if (field === 'visitas') {
      const newVisitas = Number(value);
      area.visitas = newVisitas;
      // Ajustar el array de fechas según la cantidad de visitas
      const currentFechas = area.fechas_visitas || [];
      if (newVisitas > currentFechas.length) {
        area.fechas_visitas = [
          ...currentFechas,
          ...Array(newVisitas - currentFechas.length).fill(''),
        ];
      } else {
        area.fechas_visitas = currentFechas.slice(0, newVisitas);
      }
    } else if (field !== 'fechas_visitas') {
      (area[field] as number) = Number(value);
    }

    area.total = calcularTotalArea(area.area, area.visitas, area.precio);
    updated[index].almacen_area = area;

    setData('almacenes', updated);
  };

  const updateTrampaFechaVisita = (
    almacenIndex: number,
    visitaIndex: number,
    fecha: string,
  ) => {
    const updated = [...data.almacenes];
    const fechas = [
      ...(updated[almacenIndex].almacen_trampa.fechas_visitas || []),
    ];
    fechas[visitaIndex] = fecha;
    updated[almacenIndex].almacen_trampa.fechas_visitas = fechas;
    setData('almacenes', updated);
  };

  const updateAreaFechaVisita = (
    almacenIndex: number,
    visitaIndex: number,
    fecha: string,
  ) => {
    const updated = [...data.almacenes];
    const fechas = [
      ...(updated[almacenIndex].almacen_area.fechas_visitas || []),
    ];
    fechas[visitaIndex] = fecha;
    updated[almacenIndex].almacen_area.fechas_visitas = fechas;
    setData('almacenes', updated);
  };

  const totalAlmacenes = useMemo(() => {
    return data.almacenes.reduce((sum, a) => {
      return (
        sum + (a.almacen_trampa?.total ?? 0) + (a.almacen_area?.total ?? 0)
      );
    }, 0);
  }, [data.almacenes]);

  const granTotal = totalAlmacenes;
  // const saldoCalculado = granTotal - (data.acuenta ?? 0);

  const addAlmacen = () => {
    setData('almacenes', [
      ...data.almacenes,
      {
        nombre: '',
        direccion: '',
        telefono: '',
        email: '',
        ciudad: '',
        // contacto_id: contactos[0]?.id ?? 0,
        almacen_trampa: {
          descripcion: 'Control de roedores con trampas',
          cantidad: 0,
          visitas: 12,
          precio: 0,
          total: 0,
          fechas_visitas: Array(12).fill(''),
        },
        almacen_area: {
          descripcion: 'Fumigación general',
          area: 0,
          visitas: 12,
          precio: 0,
          total: 0,
          fechas_visitas: Array(12).fill(''),
        },
      },
    ]);
  };

  const removeAlmacen = (index: number) => {
    if (data.almacenes.length > 1) {
      setData(
        'almacenes',
        data.almacenes.filter((_, i) => i !== index),
      );
    }
  };

  const handleSubmit: FormEventHandler = (e) => {
    e.preventDefault();
    const payload = {
      ...data,
      total: granTotal,
      // saldo: saldoCalculado,
    };

    if (cotizacion?.id) {
      put(`/contratos/${cotizacion.id}`, payload as any);
    } else {
      post('/contratos', payload as any);
    }
  };

  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title={cotizacion ? 'Editar Contrato' : 'Nuevo Contrato'} />

      <div className="py-5">
        <div className="mx-auto max-w-7xl sm:px-6 lg:px-8">
          <Card>
            <CardHeader>
              <CardTitle>
                {cotizacion ? 'Editar Contrato' : 'Nuevo Contrato'}
              </CardTitle>
              <CardDescription>
                Complete los datos del cliente y los servicios por almacén
              </CardDescription>
            </CardHeader>

            <CardContent>
              <form onSubmit={handleSubmit} className="space-y-10">
                {/* === CLIENTE === */}
                <div className="space-y-6">
                  <h3 className="text-lg font-semibold">
                    Información del Cliente
                  </h3>
                  <div className="grid grid-cols-1 gap-6 md:grid-cols-2">
                    <div>
                      <Label>Nombre del cliente</Label>
                      <Input
                        value={data.nombre}
                        onChange={(e) => setData('nombre', e.target.value)}
                      />
                    </div>
                    <div>
                      <Label>Fecha de finalización del contrato</Label>
                      <Input
                        type="date"
                        value={data.fecha_fin_contrato}
                        onChange={(e) =>
                          setData('fecha_fin_contrato', e.target.value)
                        }
                      />
                    </div>
                    <div>
                      <Label>Email</Label>
                      <Input
                        type="email"
                        value={data.email}
                        onChange={(e) => setData('email', e.target.value)}
                      />
                    </div>
                    <div>
                      <Label>Teléfono</Label>
                      <Input
                        value={data.telefono}
                        onChange={(e) => setData('telefono', e.target.value)}
                      />
                    </div>
                    <div>
                      <Label>Ciudad</Label>
                      <Input
                        value={data.ciudad}
                        onChange={(e) => setData('ciudad', e.target.value)}
                      />
                    </div>
                    <div>
                      <Label>Dirección</Label>
                      <Input
                        value={data.direccion}
                        onChange={(e) => setData('direccion', e.target.value)}
                      />
                    </div>
                  </div>
                </div>

                {/* === ALMACENES === */}
                <div className="space-y-6">
                  <div className="flex items-center justify-between">
                    <h3 className="text-lg font-semibold">Almacenes</h3>
                    <Button
                      type="button"
                      variant="outline"
                      size="sm"
                      onClick={addAlmacen}
                    >
                      <Plus className="mr-2 h-4 w-4" /> Agregar Almacén
                    </Button>
                  </div>

                  {data.almacenes.map((almacen, index) => (
                    <Card key={index} className="border-2">
                      <CardHeader>
                        <div className="flex items-center justify-between">
                          <CardTitle className="text-lg">
                            Almacén #{index + 1} —{' '}
                            {almacen.nombre || 'Sin nombre'}
                          </CardTitle>
                          {data.almacenes.length > 1 && (
                            <Button
                              type="button"
                              variant="ghost"
                              size="icon"
                              onClick={() => removeAlmacen(index)}
                              className="text-red-600"
                            >
                              <Trash2 className="h-4 w-4" />
                            </Button>
                          )}
                        </div>
                      </CardHeader>

                      <CardContent className="space-y-4">
                        <div className="grid grid-cols-1 gap-4 md:grid-cols-2">
                          <div>
                            <Label>Nombre del almacén</Label>
                            <Input
                              value={almacen.nombre}
                              onChange={(e) =>
                                setData(
                                  `almacenes.${index}.nombre` as any,
                                  e.target.value,
                                )
                              }
                              placeholder="Ej. Almacén Central"
                            />
                          </div>
                          <div>
                            <Label>Direccion</Label>
                            <Input
                              value={almacen.direccion}
                              onChange={(e) =>
                                setData(
                                  `almacenes.${index}.direccion` as any,
                                  e.target.value,
                                )
                              }
                              placeholder="Ej. Almacén Central"
                            />
                          </div>
                          <div>
                            <Label>Telefono</Label>
                            <Input
                              value={almacen.direccion}
                              onChange={(e) =>
                                setData(
                                  `almacenes.${index}.direccion` as any,
                                  e.target.value,
                                )
                              }
                              placeholder="Ej. Almacén Central"
                            />
                          </div>
                          <div>
                            <Label>Email</Label>
                            <Input
                              value={almacen.direccion}
                              onChange={(e) =>
                                setData(
                                  `almacenes.${index}.direccion` as any,
                                  e.target.value,
                                )
                              }
                              placeholder="Ej. Almacén Central"
                            />
                          </div>
                          <div>
                            <Label>Ciudad</Label>
                            <Input
                              value={almacen.direccion}
                              onChange={(e) =>
                                setData(
                                  `almacenes.${index}.direccion` as any,
                                  e.target.value,
                                )
                              }
                              placeholder="Ej. Almacén Central"
                            />
                          </div>
                          {/* <div>
                            <Label>Contacto responsable</Label>
                            <Select
                              value={String(almacen.contacto_id)}
                              onValueChange={(value) =>
                                setData(
                                  `almacenes.${index}.contacto_id` as any,
                                  Number(value),
                                )
                              }
                            >
                              <SelectTrigger>
                                <SelectValue placeholder="Seleccionar contacto" />
                              </SelectTrigger>
                              <SelectContent>
                                {contactos.map((c) => (
                                  <SelectItem key={c.id} value={String(c.id)}>
                                    {c.nombre}{' '}
                                    {c.telefono ? `— ${c.telefono}` : ''}
                                  </SelectItem>
                                ))}
                              </SelectContent>
                            </Select>
                          </div> */}
                        </div>

                        {/* === SERVICIO POR TRAMPAS === */}
                        <div className="rounded-lg border bg-muted/40 p-4">
                          <h4 className="mb-4 font-semibold text-primary">
                            Servicio por Trampas
                          </h4>
                          <div className="grid grid-cols-1 gap-4 md:grid-cols-4">
                            <div className="">
                              <Label>Descripción</Label>
                              <Input
                                value={almacen.almacen_trampa.descripcion}
                                onChange={(e) =>
                                  updateTrampaField(
                                    index,
                                    'descripcion',
                                    e.target.value,
                                  )
                                }
                              />
                            </div>
                            <div>
                              <Label>Cantidad</Label>
                              <Input
                                type="number"
                                value={almacen.almacen_trampa.cantidad}
                                onChange={(e) =>
                                  updateTrampaField(
                                    index,
                                    'cantidad',
                                    e.target.value,
                                  )
                                }
                              />
                            </div>
                            <div>
                              <Label>Visitas/año</Label>
                              <Input
                                type="number"
                                min="1"
                                value={almacen.almacen_trampa.visitas}
                                onChange={(e) =>
                                  updateTrampaField(
                                    index,
                                    'visitas',
                                    e.target.value,
                                  )
                                }
                              />
                            </div>
                            <div>
                              <Label>Precio mensual</Label>
                              <Input
                                type="number"
                                step="0.01"
                                value={almacen.almacen_trampa.precio}
                                onChange={(e) =>
                                  updateTrampaField(
                                    index,
                                    'precio',
                                    e.target.value,
                                  )
                                }
                              />
                            </div>
                          </div>

                          {/* Fechas de visitas para trampas */}
                          {almacen.almacen_trampa.visitas > 0 && (
                            <div className="mt-6 space-y-3">
                              <div className="flex items-center gap-2">
                                <Calendar className="h-4 w-4 text-primary" />
                                <Label className="text-sm font-semibold">
                                  Fechas programadas de visitas
                                </Label>
                              </div>
                              <div className="grid grid-cols-2 gap-3 md:grid-cols-3 lg:grid-cols-4">
                                {Array.from({
                                  length: almacen.almacen_trampa.visitas,
                                }).map((_, visitaIndex) => (
                                  <div key={visitaIndex}>
                                    <Label className="text-xs">
                                      Visita {visitaIndex + 1}
                                    </Label>
                                    <Input
                                      type="date"
                                      value={
                                        almacen.almacen_trampa.fechas_visitas?.[
                                          visitaIndex
                                        ] || ''
                                      }
                                      onChange={(e) =>
                                        updateTrampaFechaVisita(
                                          index,
                                          visitaIndex,
                                          e.target.value,
                                        )
                                      }
                                      className="text-sm"
                                    />
                                  </div>
                                ))}
                              </div>
                            </div>
                          )}

                          <p className="mt-4 text-right text-lg font-bold">
                            Total anual: Bs.{' '}
                            {almacen.almacen_trampa.total.toFixed(2)}
                          </p>
                        </div>

                        {/* === SERVICIO POR ÁREA === */}
                        <div className="rounded-lg border bg-muted/40 p-4">
                          <h4 className="mb-4 font-semibold text-primary">
                            Servicio por Área (m²)
                          </h4>
                          <div className="grid grid-cols-1 gap-4 md:grid-cols-4">
                            <div className="">
                              <Label>Descripción</Label>
                              <Input
                                value={almacen.almacen_area.descripcion}
                                onChange={(e) =>
                                  updateAreaField(
                                    index,
                                    'descripcion',
                                    e.target.value,
                                  )
                                }
                              />
                            </div>
                            <div>
                              <Label>Área (m²)</Label>
                              <Input
                                type="number"
                                step="0.01"
                                value={almacen.almacen_area.area}
                                onChange={(e) =>
                                  updateAreaField(index, 'area', e.target.value)
                                }
                              />
                            </div>
                            <div>
                              <Label>Visitas/año</Label>
                              <Input
                                type="number"
                                min="1"
                                value={almacen.almacen_area.visitas}
                                onChange={(e) =>
                                  updateAreaField(
                                    index,
                                    'visitas',
                                    e.target.value,
                                  )
                                }
                              />
                            </div>
                            <div>
                              <Label>Precio m²/mes</Label>
                              <Input
                                type="number"
                                step="0.01"
                                value={almacen.almacen_area.precio}
                                onChange={(e) =>
                                  updateAreaField(
                                    index,
                                    'precio',
                                    e.target.value,
                                  )
                                }
                              />
                            </div>
                          </div>

                          {/* Fechas de visitas para área */}
                          {almacen.almacen_area.visitas > 0 && (
                            <div className="mt-6 space-y-3">
                              <div className="flex items-center gap-2">
                                <Calendar className="h-4 w-4 text-primary" />
                                <Label className="text-sm font-semibold">
                                  Fechas programadas de visitas
                                </Label>
                              </div>
                              <div className="grid grid-cols-2 gap-3 md:grid-cols-3 lg:grid-cols-4">
                                {Array.from({
                                  length: almacen.almacen_area.visitas,
                                }).map((_, visitaIndex) => (
                                  <div key={visitaIndex}>
                                    <Label className="text-xs">
                                      Visita {visitaIndex + 1}
                                    </Label>
                                    <Input
                                      type="date"
                                      value={
                                        almacen.almacen_area.fechas_visitas?.[
                                          visitaIndex
                                        ] || ''
                                      }
                                      onChange={(e) =>
                                        updateAreaFechaVisita(
                                          index,
                                          visitaIndex,
                                          e.target.value,
                                        )
                                      }
                                      className="text-sm"
                                    />
                                  </div>
                                ))}
                              </div>
                            </div>
                          )}

                          <p className="mt-4 text-right text-lg font-bold">
                            Total anual: Bs.{' '}
                            {almacen.almacen_area.total.toFixed(2)}
                          </p>
                        </div>

                        <div className="flex justify-end">
                          <div className="text-right">
                            <p className="text-sm text-muted-foreground">
                              Total este almacén
                            </p>
                            <p className="text-2xl font-bold text-primary">
                              Bs.{' '}
                              {(
                                almacen.almacen_trampa.total +
                                almacen.almacen_area.total
                              ).toFixed(2)}
                            </p>
                          </div>
                        </div>
                      </CardContent>
                    </Card>
                  ))}
                </div>

                {/* === RESUMEN FINAL === */}
                <Card className="border-2 bg-primary/5">
                  <CardContent className="pt-8">
                    <div className="space-y-6 text-right">
                      <div className="text-2xl font-bold text-primary">
                        TOTAL DEL CONTRATO: Bs. {granTotal.toFixed(2)}
                      </div>

                      {/* <div className="flex items-center justify-end gap-8">
                        <Label className="text-lg">A cuenta:</Label>
                        <Input
                          type="number"
                          step="0.01"
                          className="w-64 text-lg"
                          value={data.acuenta || ''}
                          onChange={(e) =>
                            setData('acuenta', Number(e.target.value) || 0)
                          }
                        />
                        <span className="text-lg font-medium">Saldo:</span>
                        <span
                          className={`text-2xl font-bold ${saldoCalculado < 0 ? 'text-red-600' : 'text-green-600'}`}
                        >
                          Bs. {saldoCalculado.toFixed(2)}
                        </span>
                      </div> */}
                    </div>
                  </CardContent>
                </Card>

                <div className="flex justify-end gap-4 pt-8">
                  <Button
                    type="button"
                    variant="outline"
                    onClick={() => router.visit('/contratos')}
                  >
                    Cancelar
                  </Button>
                  <Button type="submit" disabled={processing}>
                    {processing
                      ? 'Guardando...'
                      : cotizacion
                        ? 'Actualizar'
                        : 'Crear Contrato'}
                  </Button>
                </div>
              </form>
            </CardContent>
          </Card>
        </div>
      </div>
    </AppLayout>
  );
}
// -----------------------------------------------------------------
// // resources/js/Pages/Contratos/CotizacionForm.tsx
// import { Button } from '@/components/ui/button';
// import {
//   Card,
//   CardContent,
//   CardDescription,
//   CardHeader,
//   CardTitle,
// } from '@/components/ui/card';
// import { Input } from '@/components/ui/input';
// import { Label } from '@/components/ui/label';
// import {
//   Select,
//   SelectContent,
//   SelectItem,
//   SelectTrigger,
//   SelectValue,
// } from '@/components/ui/select';
// import AppLayout from '@/layouts/app-layout';
// import { type BreadcrumbItem } from '@/types';
// import { Head, router, useForm } from '@inertiajs/react';
// import { Plus, Trash2 } from 'lucide-react';
// import { FormEventHandler, useMemo } from 'react';

// const breadcrumbs: BreadcrumbItem[] = [
//   { title: 'Contratos', href: '/contratos' },
// ];

// interface Contacto {
//   id: number;
//   nombre: string;
//   telefono?: string;
// }

// interface AlmacenTrampa {
//   descripcion: string;
//   cantidad: number;
//   visitas: number;
//   precio: number;
//   total: number;
// }

// interface AlmacenArea {
//   descripcion: string;
//   area: number;
//   visitas: number;
//   precio: number;
//   total: number;
// }

// interface Almacen {
//   id?: number;
//   nombre: string;
//   contacto_id: number;
//   almacen_trampa: AlmacenTrampa;
//   almacen_area: AlmacenArea;
// }

// interface Cotizacion {
//   id?: number;
//   nombre: string;
//   direccion: string;
//   telefono: string;
//   email: string;
//   ciudad: string;
//   fecha_fin_contrato: string;
//   total: number;
//   acuenta: number;
//   saldo: number;
//   almacenes: Almacen[];
// }

// interface Props {
//   cotizacion?: Cotizacion;
//   contactos: Contacto[];
// }

// export default function CotizacionForm({ cotizacion, contactos }: Props) {
//   const { data, setData, post, put, processing, errors } = useForm<Cotizacion>({
//     nombre: cotizacion?.nombre ?? '',
//     direccion: cotizacion?.direccion ?? '',
//     telefono: cotizacion?.telefono ?? '',
//     email: cotizacion?.email ?? '',
//     ciudad: cotizacion?.ciudad ?? '',
//     fecha_fin_contrato: cotizacion?.fecha_fin_contrato ?? '',
//     total: cotizacion?.total ?? 0,
//     acuenta: cotizacion?.acuenta ?? 0,
//     saldo: cotizacion?.saldo ?? 0,

//     almacenes:
//       cotizacion?.almacenes?.length > 0
//         ? cotizacion.almacenes.map((a) => ({
//             id: a.id,
//             nombre: a.nombre ?? '',
//             contacto_id: a.contacto_id ?? contactos[0]?.id ?? 0,
//             almacen_trampa: {
//               descripcion:
//                 a.almacen_trampa?.descripcion ??
//                 'Control de roedores con trampas',
//               cantidad: a.almacen_trampa?.cantidad ?? 0,
//               visitas: a.almacen_trampa?.visitas ?? 12,
//               precio: a.almacen_trampa?.precio ?? 0,
//               total: a.almacen_trampa?.total ?? 0,
//             },
//             almacen_area: {
//               descripcion: a.almacen_area?.descripcion ?? 'Fumigación general',
//               area: a.almacen_area?.area ?? 0,
//               visitas: a.almacen_area?.visitas ?? 12,
//               precio: a.almacen_area?.precio ?? 0,
//               total: a.almacen_area?.total ?? 0,
//             },
//           }))
//         : [
//             {
//               nombre: '',
//               contacto_id: contactos[0]?.id ?? 0,
//               almacen_trampa: {
//                 descripcion: 'Control de roedores con trampas',
//                 cantidad: 0,
//                 visitas: 12,
//                 precio: 0,
//                 total: 0,
//               },
//               almacen_area: {
//                 descripcion: 'Fumigación general',
//                 area: 0,
//                 visitas: 12,
//                 precio: 0,
//                 total: 0,
//               },
//             },
//           ],
//   });

//   // === CÁLCULO AUTOMÁTICO DE TOTALES ===
//   const calcularTotalTrampas = (
//     cantidad: number,
//     visitas: number,
//     precio: number,
//   ) => {
//     return cantidad * visitas * precio;
//   };

//   const calcularTotalArea = (area: number, visitas: number, precio: number) => {
//     return area * visitas * precio;
//   };

//   // Actualizar totales cuando cambian los campos
//   const updateTrampaField = (
//     index: number,
//     field: keyof AlmacenTrampa,
//     value: number | string,
//   ) => {
//     const updated = [...data.almacenes];
//     const trampa = { ...updated[index].almacen_trampa };

//     if (field === 'descripcion') {
//       trampa.descripcion = value as string;
//     } else {
//       (trampa[field] as number) = Number(value);
//     }

//     trampa.total = calcularTotalTrampas(
//       trampa.cantidad,
//       trampa.visitas,
//       trampa.precio,
//     );
//     updated[index].almacen_trampa = trampa;

//     setData('almacenes', updated);
//   };

//   const updateAreaField = (
//     index: number,
//     field: keyof AlmacenArea,
//     value: number | string,
//   ) => {
//     const updated = [...data.almacenes];
//     const area = { ...updated[index].almacen_area };

//     if (field === 'descripcion') {
//       area.descripcion = value as string;
//     } else {
//       (area[field] as number) = Number(value);
//     }

//     area.total = calcularTotalArea(area.area, area.visitas, area.precio);
//     updated[index].almacen_area = area;

//     setData('almacenes', updated);
//   };

//   const totalAlmacenes = useMemo(() => {
//     return data.almacenes.reduce((sum, a) => {
//       return (
//         sum + (a.almacen_trampa?.total ?? 0) + (a.almacen_area?.total ?? 0)
//       );
//     }, 0);
//   }, [data.almacenes]);

//   const granTotal = totalAlmacenes;
//   const saldoCalculado = granTotal - (data.acuenta ?? 0);

//   const addAlmacen = () => {
//     setData('almacenes', [
//       ...data.almacenes,
//       {
//         nombre: '',
//         contacto_id: contactos[0]?.id ?? 0,
//         almacen_trampa: {
//           descripcion: 'Control de roedores con trampas',
//           cantidad: 0,
//           visitas: 12,
//           precio: 0,
//           total: 0,
//         },
//         almacen_area: {
//           descripcion: 'Fumigación general',
//           area: 0,
//           visitas: 12,
//           precio: 0,
//           total: 0,
//         },
//       },
//     ]);
//   };

//   const removeAlmacen = (index: number) => {
//     if (data.almacenes.length > 1) {
//       setData(
//         'almacenes',
//         data.almacenes.filter((_, i) => i !== index),
//       );
//     }
//   };

//   const handleSubmit: FormEventHandler = (e) => {
//     e.preventDefault();
//     const payload = {
//       ...data,
//       total: granTotal,
//       saldo: saldoCalculado,
//     };

//     if (cotizacion?.id) {
//       put(`/contratos/${cotizacion.id}`, payload as any);
//     } else {
//       post('/contratos', payload as any);
//     }
//   };

//   return (
//     <AppLayout breadcrumbs={breadcrumbs}>
//       <Head title={cotizacion ? 'Editar Contrato' : 'Nuevo Contrato'} />

//       <div className="py-5">
//         <div className="mx-auto max-w-7xl sm:px-6 lg:px-8">
//           <Card>
//             <CardHeader>
//               <CardTitle>
//                 {cotizacion ? 'Editar Contrato' : 'Nuevo Contrato'}
//               </CardTitle>
//               <CardDescription>
//                 Complete los datos del cliente y los servicios por almacén
//               </CardDescription>
//             </CardHeader>

//             <CardContent>
//               <form onSubmit={handleSubmit} className="space-y-10">
//                 {/* === CLIENTE === */}
//                 <div className="space-y-6">
//                   <h3 className="text-lg font-semibold">
//                     Información del Cliente
//                   </h3>
//                   <div className="grid grid-cols-1 gap-6 md:grid-cols-2">
//                     <div>
//                       <Label>Nombre del cliente</Label>
//                       <Input
//                         value={data.nombre}
//                         onChange={(e) => setData('nombre', e.target.value)}
//                       />
//                     </div>
//                     <div>
//                       <Label>Fecha de finalización del contrato</Label>
//                       <Input
//                         type="date"
//                         value={data.fecha_fin_contrato}
//                         onChange={(e) =>
//                           setData('fecha_fin_contrato', e.target.value)
//                         }
//                       />
//                     </div>
//                     <div>
//                       <Label>Email</Label>
//                       <Input
//                         type="email"
//                         value={data.email}
//                         onChange={(e) => setData('email', e.target.value)}
//                       />
//                     </div>
//                     <div>
//                       <Label>Teléfono</Label>
//                       <Input
//                         value={data.telefono}
//                         onChange={(e) => setData('telefono', e.target.value)}
//                       />
//                     </div>
//                     <div>
//                       <Label>Ciudad</Label>
//                       <Input
//                         value={data.ciudad}
//                         onChange={(e) => setData('ciudad', e.target.value)}
//                       />
//                     </div>
//                     <div>
//                       <Label>Dirección</Label>
//                       <Input
//                         value={data.direccion}
//                         onChange={(e) => setData('direccion', e.target.value)}
//                       />
//                     </div>
//                   </div>
//                 </div>

//                 {/* === ALMACENES === */}
//                 <div className="space-y-6">
//                   <div className="flex items-center justify-between">
//                     <h3 className="text-lg font-semibold">Almacenes</h3>
//                     <Button
//                       type="button"
//                       variant="outline"
//                       size="sm"
//                       onClick={addAlmacen}
//                     >
//                       <Plus className="mr-2 h-4 w-4" /> Agregar Almacén
//                     </Button>
//                   </div>

//                   {data.almacenes.map((almacen, index) => (
//                     <Card key={index} className="border-2">
//                       <CardHeader>
//                         <div className="flex items-center justify-between">
//                           <CardTitle className="text-lg">
//                             Almacén #{index + 1} —{' '}
//                             {almacen.nombre || 'Sin nombre'}
//                           </CardTitle>
//                           {data.almacenes.length > 1 && (
//                             <Button
//                               type="button"
//                               variant="ghost"
//                               size="icon"
//                               onClick={() => removeAlmacen(index)}
//                               className="text-red-600"
//                             >
//                               <Trash2 className="h-4 w-4" />
//                             </Button>
//                           )}
//                         </div>
//                       </CardHeader>

//                       <CardContent className="space-y-8">
//                         <div className="grid grid-cols-1 gap-4 md:grid-cols-2">
//                           <div>
//                             <Label>Nombre del almacén</Label>
//                             <Input
//                               value={almacen.nombre}
//                               onChange={(e) =>
//                                 setData(
//                                   `almacenes.${index}.nombre` as any,
//                                   e.target.value,
//                                 )
//                               }
//                               placeholder="Ej. Almacén Central"
//                             />
//                           </div>
//                           <div>
//                             <Label>Contacto responsable</Label>
//                             <Select
//                               value={String(almacen.contacto_id)}
//                               onValueChange={(value) =>
//                                 setData(
//                                   `almacenes.${index}.contacto_id` as any,
//                                   Number(value),
//                                 )
//                               }
//                             >
//                               <SelectTrigger>
//                                 <SelectValue placeholder="Seleccionar contacto" />
//                               </SelectTrigger>
//                               <SelectContent>
//                                 {contactos.map((c) => (
//                                   <SelectItem key={c.id} value={String(c.id)}>
//                                     {c.nombre}{' '}
//                                     {c.telefono ? `— ${c.telefono}` : ''}
//                                   </SelectItem>
//                                 ))}
//                               </SelectContent>
//                             </Select>
//                           </div>
//                         </div>

//                         {/* === SERVICIO POR TRAMPAS === */}
//                         <div className="rounded-lg border bg-muted/40 p-6">
//                           <h4 className="mb-4 font-semibold text-primary">
//                             Servicio por Trampas
//                           </h4>
//                           <div className="grid grid-cols-1 gap-4 md:grid-cols-4">
//                             <div className="md:col-span-2">
//                               <Label>Descripción</Label>
//                               <Input
//                                 value={almacen.almacen_trampa.descripcion}
//                                 onChange={(e) =>
//                                   updateTrampaField(
//                                     index,
//                                     'descripcion',
//                                     e.target.value,
//                                   )
//                                 }
//                               />
//                             </div>
//                             <div>
//                               <Label>Cantidad</Label>
//                               <Input
//                                 type="number"
//                                 value={almacen.almacen_trampa.cantidad}
//                                 onChange={(e) =>
//                                   updateTrampaField(
//                                     index,
//                                     'cantidad',
//                                     e.target.value,
//                                   )
//                                 }
//                               />
//                             </div>
//                             <div>
//                               <Label>Visitas/año</Label>
//                               <Input
//                                 type="number"
//                                 min="1"
//                                 value={almacen.almacen_trampa.visitas}
//                                 onChange={(e) =>
//                                   updateTrampaField(
//                                     index,
//                                     'visitas',
//                                     e.target.value,
//                                   )
//                                 }
//                               />
//                             </div>
//                             <div>
//                               <Label>Precio mensual</Label>
//                               <Input
//                                 type="number"
//                                 step="0.01"
//                                 value={almacen.almacen_trampa.precio}
//                                 onChange={(e) =>
//                                   updateTrampaField(
//                                     index,
//                                     'precio',
//                                     e.target.value,
//                                   )
//                                 }
//                               />
//                             </div>
//                           </div>
//                           <p className="mt-4 text-right text-lg font-bold">
//                             Total anual: Bs.{' '}
//                             {almacen.almacen_trampa.total.toFixed(2)}
//                           </p>
//                         </div>

//                         {/* === SERVICIO POR ÁREA === */}
//                         <div className="rounded-lg border bg-muted/40 p-6">
//                           <h4 className="mb-4 font-semibold text-primary">
//                             Servicio por Área (m²)
//                           </h4>
//                           <div className="grid grid-cols-1 gap-4 md:grid-cols-4">
//                             <div className="md:col-span-2">
//                               <Label>Descripción</Label>
//                               <Input
//                                 value={almacen.almacen_area.descripcion}
//                                 onChange={(e) =>
//                                   updateAreaField(
//                                     index,
//                                     'descripcion',
//                                     e.target.value,
//                                   )
//                                 }
//                               />
//                             </div>
//                             <div>
//                               <Label>Área (m²)</Label>
//                               <Input
//                                 type="number"
//                                 step="0.01"
//                                 value={almacen.almacen_area.area}
//                                 onChange={(e) =>
//                                   updateAreaField(index, 'area', e.target.value)
//                                 }
//                               />
//                             </div>
//                             <div>
//                               <Label>Visitas/año</Label>
//                               <Input
//                                 type="number"
//                                 min="1"
//                                 value={almacen.almacen_area.visitas}
//                                 onChange={(e) =>
//                                   updateAreaField(
//                                     index,
//                                     'visitas',
//                                     e.target.value,
//                                   )
//                                 }
//                               />
//                             </div>
//                             <div>
//                               <Label>Precio m²/mes</Label>
//                               <Input
//                                 type="number"
//                                 step="0.01"
//                                 value={almacen.almacen_area.precio}
//                                 onChange={(e) =>
//                                   updateAreaField(
//                                     index,
//                                     'precio',
//                                     e.target.value,
//                                   )
//                                 }
//                               />
//                             </div>
//                           </div>
//                           <p className="mt-4 text-right text-lg font-bold">
//                             Total anual: Bs.{' '}
//                             {almacen.almacen_area.total.toFixed(2)}
//                           </p>
//                         </div>

//                         <div className="flex justify-end">
//                           <div className="text-right">
//                             <p className="text-sm text-muted-foreground">
//                               Total este almacén
//                             </p>
//                             <p className="text-2xl font-bold text-primary">
//                               Bs.{' '}
//                               {(
//                                 almacen.almacen_trampa.total +
//                                 almacen.almacen_area.total
//                               ).toFixed(2)}
//                             </p>
//                           </div>
//                         </div>
//                       </CardContent>
//                     </Card>
//                   ))}
//                 </div>

//                 {/* === RESUMEN FINAL === */}
//                 <Card className="border-2 bg-primary/5">
//                   <CardContent className="pt-8">
//                     <div className="space-y-6 text-right">
//                       <div className="text-3xl font-bold text-primary">
//                         TOTAL DEL CONTRATO: Bs. {granTotal.toFixed(2)}
//                       </div>

//                       <div className="flex items-center justify-end gap-8">
//                         <Label className="text-lg">A cuenta:</Label>
//                         <Input
//                           type="number"
//                           step="0.01"
//                           className="w-64 text-lg"
//                           value={data.acuenta || ''}
//                           onChange={(e) =>
//                             setData('acuenta', Number(e.target.value) || 0)
//                           }
//                         />
//                         <span className="text-lg font-medium">Saldo:</span>
//                         <span
//                           className={`text-2xl font-bold ${saldoCalculado < 0 ? 'text-red-600' : 'text-green-600'}`}
//                         >
//                           Bs. {saldoCalculado.toFixed(2)}
//                         </span>
//                       </div>
//                     </div>
//                   </CardContent>
//                 </Card>

//                 <div className="flex justify-end gap-4 pt-8">
//                   <Button
//                     type="button"
//                     variant="outline"
//                     onClick={() => router.visit('/contratos')}
//                   >
//                     Cancelar
//                   </Button>
//                   <Button type="submit" disabled={processing}>
//                     {processing
//                       ? 'Guardando...'
//                       : cotizacion
//                         ? 'Actualizar'
//                         : 'Crear Contrato'}
//                   </Button>
//                 </div>
//               </form>
//             </CardContent>
//           </Card>
//         </div>
//       </div>
//     </AppLayout>
//   );
// }
// -------------------------------------------------------------
// // resources/js/Pages/Contratos/CotizacionForm.tsx
// import { Button } from '@/components/ui/button';
// import {
//   Card,
//   CardContent,
//   CardDescription,
//   CardHeader,
//   CardTitle,
// } from '@/components/ui/card';
// import { Input } from '@/components/ui/input';
// import { Label } from '@/components/ui/label';
// import { Textarea } from '@/components/ui/textarea';
// import AppLayout from '@/layouts/app-layout';
// import { type BreadcrumbItem } from '@/types';
// import { Head, router, useForm } from '@inertiajs/react';
// import { Plus, Trash2 } from 'lucide-react';
// import { FormEventHandler, useMemo } from 'react';

// const breadcrumbs: BreadcrumbItem[] = [
//   { title: 'Contratos', href: '/contratos' },
// ];

// interface CotizacionDetalle {
//   descripcion: string;
//   area: number;
//   precio_unitario: number;
//   total: number;
// }

// interface AlmacenTrampa {
//   descripcion: string;
//   cantidad: number;
//   visitas: number;
//   precio: number;
//   total: number;
// }

// interface AlmacenArea {
//   descripcion: string;
//   area: number;
//   visitas: number;
//   precio: number;
//   total: number;
// }

// interface Contacto {
//   nombre: string;
// }

// interface Almacen {
//   id?: number;
//   nombre: string;
//   contacto: Contacto;
//   almacen_trampa: AlmacenTrampa;
//   almacen_area: AlmacenArea;
// }

// interface Cotizacion {
//   id?: number;
//   nombre: string;
//   direccion: string;
//   telefono: string;
//   email: string;
//   ciudad: string;
//   total: number;
//   acuenta: number;
//   saldo: number;
//   almacenes: Almacen[];
//   detalles: CotizacionDetalle[];
// }

// interface Props {
//   cotizacion?: Cotizacion;
// }

// export default function CotizacionForm({ cotizacion }: Props) {
//   const { data, setData, post, put, processing, errors } = useForm<Cotizacion>({
//     nombre: cotizacion?.nombre || '',
//     direccion: cotizacion?.direccion || '',
//     telefono: cotizacion?.telefono || '',
//     email: cotizacion?.email || '',
//     ciudad: cotizacion?.ciudad || '',
//     total: cotizacion?.total || 0,
//     acuenta: cotizacion?.acuenta || 0,
//     saldo: cotizacion?.saldo || 0,

//     // Almacenes completos
//     almacenes:
//       cotizacion?.almacenes?.length > 0
//         ? cotizacion.almacenes.map((a) => ({
//             id: a.id,
//             nombre: a.nombre || '',
//             contacto: { nombre: a.contacto?.nombre || '' },
//             almacen_trampa: {
//               descripcion: a.almacen_trampa?.descripcion || '',
//               cantidad: a.almacen_trampa?.cantidad || 0,
//               visitas: a.almacen_trampa?.visitas || 12,
//               precio: a.almacen_trampa?.precio || 0,
//               total: a.almacen_trampa?.total || 0,
//             },
//             almacen_area: {
//               descripcion: a.almacen_area?.descripcion || '',
//               area: a.almacen_area?.area || 0,
//               visitas: a.almacen_area?.visitas || 12,
//               precio: a.almacen_area?.precio || 0,
//               total: a.almacen_area?.total || 0,
//             },
//           }))
//         : [
//             {
//               nombre: '',
//               contacto: { nombre: '' },
//               almacen_trampa: {
//                 descripcion: '',
//                 cantidad: 0,
//                 visitas: 12,
//                 precio: 0,
//                 total: 0,
//               },
//               almacen_area: {
//                 descripcion: '',
//                 area: 0,
//                 visitas: 12,
//                 precio: 0,
//                 total: 0,
//               },
//             },
//           ],

//     // Detalles
//     detalles:
//       cotizacion?.detalles?.length > 0
//         ? cotizacion.detalles.map((d) => ({
//             descripcion: d.descripcion || '',
//             area: Number(d.area) || 0,
//             precio_unitario: Number(d.precio_unitario) || 0,
//             total: Number(d.total) || 0,
//           }))
//         : [{ descripcion: '', area: 0, precio_unitario: 0, total: 0 }],
//   });

//   // === ALMACENES ===
//   const addAlmacen = () => {
//     setData('almacenes', [
//       ...data.almacenes,
//       {
//         nombre: '',
//         contacto: { nombre: '' },
//         almacen_trampa: {
//           descripcion: '',
//           cantidad: 0,
//           visitas: 12,
//           precio: 0,
//           total: 0,
//         },
//         almacen_area: {
//           descripcion: '',
//           area: 0,
//           visitas: 12,
//           precio: 0,
//           total: 0,
//         },
//       },
//     ]);
//   };

//   const removeAlmacen = (index: number) => {
//     if (data.almacenes.length > 1) {
//       setData(
//         'almacenes',
//         data.almacenes.filter((_, i) => i !== index),
//       );
//     }
//   };

//   // === DETALLES ===
//   const addDetalle = () => {
//     setData('detalles', [
//       ...data.detalles,
//       { descripcion: '', area: 0, precio_unitario: 0, total: 0 },
//     ]);
//   };

//   const removeDetalle = (index: number) => {
//     if (data.detalles.length > 1) {
//       setData(
//         'detalles',
//         data.detalles.filter((_, i) => i !== index),
//       );
//     }
//   };

//   const updateDetalle = (
//     index: number,
//     field: keyof CotizacionDetalle,
//     value: string | number,
//   ) => {
//     const newDetalles = [...data.detalles];
//     newDetalles[index] = { ...newDetalles[index], [field]: value };

//     if (field === 'area' || field === 'precio_unitario') {
//       const area = field === 'area' ? Number(value) : newDetalles[index].area;
//       const precio =
//         field === 'precio_unitario'
//           ? Number(value)
//           : newDetalles[index].precio_unitario;
//       newDetalles[index].total = area * precio;
//     }

//     setData('detalles', newDetalles);
//   };

//   // === CÁLCULOS ===
//   const totalDetalles = useMemo(() => {
//     return data.detalles.reduce((sum, d) => sum + (d.total || 0), 0);
//   }, [data.detalles]);

//   const totalAlmacenes = useMemo(() => {
//     return data.almacenes.reduce((sum, a) => {
//       const trampa = a.almacen_trampa?.total || 0;
//       const area = a.almacen_area?.total || 0;
//       return sum + trampa + area;
//     }, 0);
//   }, [data.almacenes]);

//   const granTotal = totalDetalles + totalAlmacenes;

//   const saldoCalculado = granTotal - (data.acuenta || 0);

//   const handleAcuentaChange = (value: number) => {
//     setData('acuenta', value);
//     setData('saldo', granTotal - value);
//   };

//   const handleSubmit: FormEventHandler = (e) => {
//     e.preventDefault();

//     const payload = {
//       ...data,
//       total: granTotal,
//       saldo: saldoCalculado,
//     };

//     if (cotizacion?.id) {
//       put(`/contratos/${cotizacion.id}`, payload as any);
//     } else {
//       post('/contratos', payload as any);
//     }
//   };

//   return (
//     <AppLayout breadcrumbs={breadcrumbs}>
//       <Head title={cotizacion ? 'Editar Contrato' : 'Nuevo Contrato'} />

//       <div className="py-5">
//         <div className="mx-auto max-w-7xl sm:px-6 lg:px-8">
//           <Card>
//             <CardHeader>
//               <CardTitle>
//                 {cotizacion ? 'Editar Contrato' : 'Nuevo Contrato'}
//               </CardTitle>
//               <CardDescription>
//                 Complete la información del cliente, almacenes y detalles del
//                 servicio
//               </CardDescription>
//             </CardHeader>

//             <CardContent>
//               <form onSubmit={handleSubmit} className="space-y-10">
//                 {/* === CLIENTE === */}
//                 <div className="space-y-4">
//                   <h3 className="text-lg font-semibold">
//                     Información del Cliente
//                   </h3>
//                   <div className="grid grid-cols-1 gap-4 md:grid-cols-2">
//                     <div>
//                       <Label>Nombre</Label>
//                       <Input
//                         value={data.nombre}
//                         onChange={(e) => setData('nombre', e.target.value)}
//                       />
//                       {errors.nombre && (
//                         <p className="mt-1 text-sm text-red-500">
//                           {errors.nombre}
//                         </p>
//                       )}
//                     </div>
//                     <div>
//                       <Label>Email</Label>
//                       <Input
//                         type="email"
//                         value={data.email}
//                         onChange={(e) => setData('email', e.target.value)}
//                       />
//                       {errors.email && (
//                         <p className="mt-1 text-sm text-red-500">
//                           {errors.email}
//                         </p>
//                       )}
//                     </div>
//                     <div>
//                       <Label>Teléfono</Label>
//                       <Input
//                         value={data.telefono}
//                         onChange={(e) => setData('telefono', e.target.value)}
//                       />
//                       {errors.telefono && (
//                         <p className="mt-1 text-sm text-red-500">
//                           {errors.telefono}
//                         </p>
//                       )}
//                     </div>
//                     <div>
//                       <Label>Ciudad</Label>
//                       <Input
//                         value={data.ciudad}
//                         onChange={(e) => setData('ciudad', e.target.value)}
//                       />
//                       {errors.ciudad && (
//                         <p className="mt-1 text-sm text-red-500">
//                           {errors.ciudad}
//                         </p>
//                       )}
//                     </div>
//                     <div className="md:col-span-2">
//                       <Label>Dirección</Label>
//                       <Input
//                         value={data.direccion}
//                         onChange={(e) => setData('direccion', e.target.value)}
//                       />
//                       {errors.direccion && (
//                         <p className="mt-1 text-sm text-red-500">
//                           {errors.direccion}
//                         </p>
//                       )}
//                     </div>
//                   </div>
//                 </div>

//                 {/* === ALMACENES COMPLETOS === */}
//                 <div className="space-y-6">
//                   <div className="flex items-center justify-between">
//                     <h3 className="text-lg font-semibold">
//                       Almacenes / Sucursales
//                     </h3>
//                     <Button
//                       type="button"
//                       variant="outline"
//                       size="sm"
//                       onClick={addAlmacen}
//                     >
//                       <Plus className="mr-2 h-4 w-4" /> Agregar Almacén
//                     </Button>
//                   </div>

//                   {data.almacenes.map((almacen, index) => (
//                     <Card key={index} className="border-2">
//                       <CardHeader>
//                         <div className="flex items-center justify-between">
//                           <CardTitle className="text-lg">
//                             Almacén #{index + 1}
//                           </CardTitle>
//                           {data.almacenes.length > 1 && (
//                             <Button
//                               type="button"
//                               variant="ghost"
//                               size="icon"
//                               onClick={() => removeAlmacen(index)}
//                               className="text-red-600"
//                             >
//                               <Trash2 className="h-4 w-4" />
//                             </Button>
//                           )}
//                         </div>
//                       </CardHeader>
//                       <CardContent className="space-y-6">
//                         <div className="grid grid-cols-1 gap-4 md:grid-cols-2">
//                           <div>
//                             <Label>Nombre del almacén</Label>
//                             <Input
//                               value={almacen.nombre}
//                               onChange={(e) =>
//                                 setData(
//                                   `almacenes.${index}.nombre` as any,
//                                   e.target.value,
//                                 )
//                               }
//                               placeholder="Almacén Central, Sucursal Norte..."
//                             />
//                             {errors[`almacenes.${index}.nombre`] && (
//                               <p className="mt-1 text-sm text-red-500">
//                                 {errors[`almacenes.${index}.nombre`]}
//                               </p>
//                             )}
//                           </div>
//                           <div>
//                             <Label>Contacto</Label>
//                             <Input
//                               value={almacen.contacto?.nombre || ''}
//                               onChange={(e) =>
//                                 setData(
//                                   `almacenes.${index}.contacto.nombre` as any,
//                                   e.target.value,
//                                 )
//                               }
//                               placeholder="Nombre del responsable"
//                             />
//                           </div>
//                         </div>

//                         {/* Trampas */}
//                         <div className="rounded-lg border bg-muted/40 p-5">
//                           <h4 className="mb-4 font-medium text-primary">
//                             Servicio por Trampas
//                           </h4>
//                           <div className="grid grid-cols-1 gap-4 md:grid-cols-5">
//                             <div className="md:col-span-2">
//                               <Label>Descripción</Label>
//                               <Input
//                                 value={
//                                   almacen.almacen_trampa?.descripcion || ''
//                                 }
//                                 onChange={(e) =>
//                                   setData(
//                                     `almacenes.${index}.almacen_trampa.descripcion` as any,
//                                     e.target.value,
//                                   )
//                                 }
//                               />
//                             </div>
//                             <div>
//                               <Label>Cantidad</Label>
//                               <Input
//                                 type="number"
//                                 value={almacen.almacen_trampa?.cantidad || 0}
//                                 onChange={(e) => {
//                                   const cant = Number(e.target.value);
//                                   const precio =
//                                     almacen.almacen_trampa?.precio || 0;
//                                   setData(
//                                     `almacenes.${index}.almacen_trampa.cantidad` as any,
//                                     cant,
//                                   );
//                                   setData(
//                                     `almacenes.${index}.almacen_trampa.total` as any,
//                                     cant * precio,
//                                   );
//                                 }}
//                               />
//                             </div>
//                             <div>
//                               <Label>Visitas/año</Label>
//                               <Input
//                                 type="number"
//                                 value={almacen.almacen_trampa?.visitas || 12}
//                                 onChange={(e) =>
//                                   setData(
//                                     `almacenes.${index}.almacen_trampa.visitas` as any,
//                                     Number(e.target.value),
//                                   )
//                                 }
//                               />
//                             </div>
//                             <div>
//                               <Label>Precio mensual</Label>
//                               <Input
//                                 type="number"
//                                 step="0.01"
//                                 value={almacen.almacen_trampa?.precio || 0}
//                                 onChange={(e) => {
//                                   const precio = Number(e.target.value);
//                                   const cant =
//                                     almacen.almacen_trampa?.cantidad || 0;
//                                   setData(
//                                     `almacenes.${index}.almacen_trampa.precio` as any,
//                                     precio,
//                                   );
//                                   setData(
//                                     `almacenes.${index}.almacen_trampa.total` as any,
//                                     precio * cant,
//                                   );
//                                 }}
//                               />
//                             </div>
//                           </div>
//                           <p className="mt-3 text-right font-semibold">
//                             Total: Bs.{' '}
//                             {(almacen.almacen_trampa?.total || 0).toFixed(2)}
//                           </p>
//                         </div>

//                         {/* Área */}
//                         <div className="rounded-lg border bg-muted/40 p-5">
//                           <h4 className="mb-4 font-medium text-primary">
//                             Servicio por Área (m²)
//                           </h4>
//                           <div className="grid grid-cols-1 gap-4 md:grid-cols-5">
//                             <div className="md:col-span-2">
//                               <Label>Descripción</Label>
//                               <Input
//                                 value={almacen.almacen_area?.descripcion || ''}
//                                 onChange={(e) =>
//                                   setData(
//                                     `almacenes.${index}.almacen_area.descripcion` as any,
//                                     e.target.value,
//                                   )
//                                 }
//                               />
//                             </div>
//                             <div>
//                               <Label>Área (m²)</Label>
//                               <Input
//                                 type="number"
//                                 step="0.01"
//                                 value={almacen.almacen_area?.area || 0}
//                                 onChange={(e) => {
//                                   const area = Number(e.target.value);
//                                   const precio =
//                                     almacen.almacen_area?.precio || 0;
//                                   setData(
//                                     `almacenes.${index}.almacen_area.area` as any,
//                                     area,
//                                   );
//                                   setData(
//                                     `almacenes.${index}.almacen_area.total` as any,
//                                     area * precio,
//                                   );
//                                 }}
//                               />
//                             </div>
//                             <div>
//                               <Label>Visitas/año</Label>
//                               <Input
//                                 type="number"
//                                 value={almacen.almacen_area?.visitas || 12}
//                                 onChange={(e) =>
//                                   setData(
//                                     `almacenes.${index}.almacen_area.visitas` as any,
//                                     Number(e.target.value),
//                                   )
//                                 }
//                               />
//                             </div>
//                             <div>
//                               <Label>Precio m²/mes</Label>
//                               <Input
//                                 type="number"
//                                 step="0.01"
//                                 value={almacen.almacen_area?.precio || 0}
//                                 onChange={(e) => {
//                                   const precio = Number(e.target.value);
//                                   const area = almacen.almacen_area?.area || 0;
//                                   setData(
//                                     `almacenes.${index}.almacen_area.precio` as any,
//                                     precio,
//                                   );
//                                   setData(
//                                     `almacenes.${index}.almacen_area.total` as any,
//                                     precio * area,
//                                   );
//                                 }}
//                               />
//                             </div>
//                           </div>
//                           <p className="mt-3 text-right font-semibold">
//                             Total: Bs.{' '}
//                             {(almacen.almacen_area?.total || 0).toFixed(2)}
//                           </p>
//                         </div>

//                         <div className="flex justify-end">
//                           <div className="text-right">
//                             <p className="text-sm text-muted-foreground">
//                               Total este almacén
//                             </p>
//                             <p className="text-2xl font-bold text-primary">
//                               Bs.{' '}
//                               {(
//                                 (almacen.almacen_trampa?.total || 0) +
//                                 (almacen.almacen_area?.total || 0)
//                               ).toFixed(2)}
//                             </p>
//                           </div>
//                         </div>
//                       </CardContent>
//                     </Card>
//                   ))}
//                 </div>

//                 {/* === DETALLES ADICIONALES === */}
//                 <div className="space-y-4">
//                   <div className="flex items-center justify-between">
//                     <h3 className="text-lg font-semibold">
//                       Detalles Adicionales
//                     </h3>
//                     <Button
//                       type="button"
//                       variant="outline"
//                       size="sm"
//                       onClick={addDetalle}
//                     >
//                       <Plus className="mr-2 h-4 w-4" /> Agregar Detalle
//                     </Button>
//                   </div>

//                   {data.detalles.map((detalle, index) => (
//                     <Card key={index}>
//                       <CardContent className="pt-6">
//                         <div className="mb-4 flex justify-between">
//                           <span className="font-medium">
//                             Detalle #{index + 1}
//                           </span>
//                           {data.detalles.length > 1 && (
//                             <Button
//                               type="button"
//                               variant="ghost"
//                               size="sm"
//                               onClick={() => removeDetalle(index)}
//                               className="text-red-600"
//                             >
//                               <Trash2 className="h-4 w-4" />
//                             </Button>
//                           )}
//                         </div>
//                         <div className="grid grid-cols-1 gap-4 md:grid-cols-4">
//                           <div>
//                             <Label>Descripción</Label>
//                             <Textarea
//                               value={detalle.descripcion}
//                               onChange={(e) =>
//                                 updateDetalle(
//                                   index,
//                                   'descripcion',
//                                   e.target.value,
//                                 )
//                               }
//                               rows={3}
//                             />
//                           </div>
//                           <div>
//                             <Label>Área (m²)</Label>
//                             <Input
//                               type="number"
//                               step="0.01"
//                               value={detalle.area}
//                               onChange={(e) =>
//                                 updateDetalle(
//                                   index,
//                                   'area',
//                                   parseFloat(e.target.value) || 0,
//                                 )
//                               }
//                             />
//                           </div>
//                           <div>
//                             <Label>Precio Unitario</Label>
//                             <Input
//                               type="number"
//                               step="0.01"
//                               value={detalle.precio_unitario}
//                               onChange={(e) =>
//                                 updateDetalle(
//                                   index,
//                                   'precio_unitario',
//                                   parseFloat(e.target.value) || 0,
//                                 )
//                               }
//                             />
//                           </div>
//                           <div>
//                             <Label>Total</Label>
//                             <Input value={detalle.total.toFixed(2)} readOnly />
//                           </div>
//                         </div>
//                       </CardContent>
//                     </Card>
//                   ))}
//                 </div>

//                 {/* === RESUMEN FINAL === */}
//                 <Card className="bg-primary/5">
//                   <CardContent className="pt-6">
//                     <div className="space-y-3 text-right">
//                       <div className="flex justify-end gap-8 text-lg">
//                         <span>Total Almacenes:</span>
//                         <span className="w-40 font-bold">
//                           Bs. {totalAlmacenes.toFixed(2)}
//                         </span>
//                       </div>
//                       <div className="flex justify-end gap-8 text-lg">
//                         <span>+ Detalles:</span>
//                         <span className="w-40 font-bold">
//                           Bs. {totalDetalles.toFixed(2)}
//                         </span>
//                       </div>
//                       <div className="border-t-2 border-primary pt-3">
//                         <div className="flex justify-end gap-8 text-2xl font-bold text-primary">
//                           <span>GRAN TOTAL:</span>
//                           <span className="w-48">
//                             Bs. {granTotal.toFixed(2)}
//                           </span>
//                         </div>
//                       </div>

//                       <div className="mt-6 flex items-center justify-end gap-8">
//                         <Label htmlFor="acuenta" className="text-lg">
//                           A cuenta:
//                         </Label>
//                         <Input
//                           id="acuenta"
//                           type="number"
//                           step="0.01"
//                           className="w-48 text-lg"
//                           value={data.acuenta || ''}
//                           onChange={(e) =>
//                             handleAcuentaChange(parseFloat(e.target.value) || 0)
//                           }
//                         />
//                         <span className="text-lg font-medium">Saldo:</span>
//                         <span
//                           className={`text-2xl font-bold ${saldoCalculado < 0 ? 'text-red-600' : 'text-green-600'}`}
//                         >
//                           Bs. {saldoCalculado.toFixed(2)}
//                         </span>
//                       </div>
//                     </div>
//                   </CardContent>
//                 </Card>

//                 {/* === BOTONES === */}
//                 <div className="flex justify-end gap-4 pt-6">
//                   <Button
//                     type="button"
//                     variant="outline"
//                     onClick={() => router.visit('/contratos')}
//                   >
//                     Cancelar
//                   </Button>
//                   <Button type="submit" disabled={processing}>
//                     {processing
//                       ? 'Guardando...'
//                       : cotizacion
//                         ? 'Actualizar'
//                         : 'Crear Contrato'}
//                   </Button>
//                 </div>
//               </form>
//             </CardContent>
//           </Card>
//         </div>
//       </div>
//     </AppLayout>
//   );
// }
// -------------------------------------------------------------------
// import { Button } from '@/components/ui/button';
// import {
//   Card,
//   CardContent,
//   CardDescription,
//   CardHeader,
//   CardTitle,
// } from '@/components/ui/card';
// import { Input } from '@/components/ui/input';
// import { Label } from '@/components/ui/label';
// import { Textarea } from '@/components/ui/textarea';
// import AppLayout from '@/layouts/app-layout';
// import { type BreadcrumbItem } from '@/types';
// import { Head, router, useForm } from '@inertiajs/react';
// import { Plus, Trash2 } from 'lucide-react';
// import { FormEventHandler, useMemo } from 'react';

// const breadcrumbs: BreadcrumbItem[] = [
//   { title: 'Contratos', href: '/contratos' },
// ];

// interface CotizacionDetalle {
//   descripcion: string;
//   area: number;
//   precio_unitario: number;
//   total: number;
// }

// interface AlmacenTrampa {
//   id?: number;
//   descripcion: string;
//   cantidad: number;
//   visitas: number;
//   precio: number;
//   total: number;
// }

// interface AlmacenArea {
//   id?: number;
//   descripcion: string;
//   area: number;
//   visitas: number;
//   precio: number;
//   total: number;
// }

// interface Contacto {
//   id?: number;
//   nombre: string;
// }

// interface Almacen {
//   id?: number;
//   almacen_trampa: AlmacenTrampa;
//   almacen_area: AlmacenArea;
//   contacto: Contacto;
//   nombre: string;
// }

// interface Cotizacion {
//   id?: number;
//   nombre: string;
//   direccion: string;
//   telefono: string;
//   email: string;
//   ciudad: string;
//   almacen: string;
//   total: number;
//   acuenta: number;
//   saldo: number;
//   almacenes: Almacen[];
//   detalles: CotizacionDetalle[];
// }

// interface Props {
//   cotizacion?: Cotizacion;
// }

// export default function CotizacionForm({ cotizacion }: Props) {
//   const { data, setData, post, put, processing, errors } = useForm<Cotizacion>({
//     nombre: cotizacion?.nombre || '',
//     direccion: cotizacion?.direccion || '',
//     telefono: cotizacion?.telefono || '',
//     email: cotizacion?.email || '',
//     ciudad: cotizacion?.ciudad || '',
//     almacen: cotizacion?.almacen || '',
//     total: cotizacion?.total || 0,
//     acuenta: cotizacion?.acuenta || 0,
//     saldo: cotizacion?.saldo || 0,
//     almacenes: cotizacion?.almacenes?.map((d) => ({
//       id: d.id || 0,
//       nombre: d.nombre || '',
//     })) || [{ id: 0, nombre: '' }],
//     detalles: cotizacion?.detalles?.map((d) => ({
//       descripcion: d.descripcion || '',
//       area: Number(d.area) || 0,
//       precio_unitario: Number(d.precio_unitario) || 0,
//       total: Number(d.total) || 0,
//     })) || [{ descripcion: '', area: 0, precio_unitario: 0, total: 0 }],
//   });

//   // === FUNCIONES PARA ALMACENES ===
//   const addAlmacen = () => {
//     setData('almacenes', [...data.almacenes, { id: 0, nombre: '' }]);
//   };

//   const removeAlmacen = (index: number) => {
//     if (data.almacenes.length > 1) {
//       setData(
//         'almacenes',
//         data.almacenes.filter((_, i) => i !== index),
//       );
//     }
//   };

//   const updateAlmacen = (
//     index: number,
//     field: keyof Almacen,
//     value: string | number,
//   ) => {
//     const nuevos = [...data.almacenes];
//     nuevos[index] = { ...nuevos[index], [field]: value };
//     setData('almacenes', nuevos);
//   };
//   // ------------------------------------

//   const handleSubmit: FormEventHandler = (e) => {
//     e.preventDefault();
//     const payload = {
//       ...data,
//       total: totalGeneral,
//       saldo: saldoCalculado,
//     };
//     if (cotizacion?.id) {
//       put(`/contratos/${cotizacion.id}`, payload as any);
//     } else {
//       post('/contratos', payload as any);
//     }
//   };

//   const addDetalle = () => {
//     setData('detalles', [
//       ...data.detalles,
//       { descripcion: '', area: 0, precio_unitario: 0, total: 0 },
//     ]);
//   };

//   const removeDetalle = (index: number) => {
//     if (data.detalles.length > 1) {
//       setData(
//         'detalles',
//         data.detalles.filter((_, i) => i !== index),
//       );
//     }
//   };

//   const updateDetalle = (
//     index: number,
//     field: keyof CotizacionDetalle,
//     value: string | number,
//   ) => {
//     const newDetalles = [...data.detalles];
//     newDetalles[index] = { ...newDetalles[index], [field]: value };

//     // Calcular total automáticamente
//     if (field === 'area' || field === 'precio_unitario') {
//       const area = field === 'area' ? Number(value) : newDetalles[index].area;
//       const precio =
//         field === 'precio_unitario'
//           ? Number(value)
//           : newDetalles[index].precio_unitario;
//       newDetalles[index].total = area * precio;
//     }

//     setData('detalles', newDetalles);
//   };

//   const calcularGranTotal = () => {
//     return data.detalles.reduce((sum, detalle) => {
//       return sum + Number(detalle.total || 0);
//     }, 0);
//   };

//   // Este es el total que se guarda en la cotización
//   // const totalGeneral = calcularGranTotal();
//   const totalGeneral = useMemo(() => calcularGranTotal(), [data.detalles]);

//   // Saldo automático
//   const saldoCalculado = totalGeneral - (data.acuenta || 0);

//   const handleAcuentaChange = (value: number) => {
//     setData('acuenta', value);
//     setData('saldo', totalGeneral - value);
//   };

//   return (
//     <AppLayout breadcrumbs={breadcrumbs}>
//       <Head title={cotizacion ? 'Editar Contrato' : 'Crear Contrato'} />
//       <>
//         <Head title={cotizacion ? 'Editar Contrato' : 'Nuevo Contrato'} />

//         <div className="py-5">
//           <div className="mx-auto max-w-7xl sm:px-6 lg:px-8">
//             <Card>
//               <CardHeader>
//                 <CardTitle>
//                   {cotizacion ? 'Editar Contrato' : 'Nueva Contrato'}
//                 </CardTitle>
//                 <CardDescription>
//                   Complete la información del cliente y los detalles del
//                   contrato
//                 </CardDescription>
//               </CardHeader>

//               <CardContent>
//                 <form onSubmit={handleSubmit} className="space-y-8">
//                   {/* Información del Cliente */}
//                   <div className="space-y-4">
//                     <h3 className="text-lg font-semibold">
//                       Información del Cliente
//                     </h3>

//                     <div className="grid grid-cols-1 gap-4 md:grid-cols-2">
//                       <div>
//                         <Label htmlFor="nombre">Nombre</Label>
//                         <Input
//                           id="nombre"
//                           value={data.nombre}
//                           onChange={(e) => setData('nombre', e.target.value)}
//                           className={errors.nombre ? 'border-red-500' : ''}
//                         />
//                         {errors.nombre && (
//                           <p className="mt-1 text-sm text-red-500">
//                             {errors.nombre}
//                           </p>
//                         )}
//                       </div>

//                       <div>
//                         <Label htmlFor="email">Email</Label>
//                         <Input
//                           id="email"
//                           type="email"
//                           value={data.email}
//                           onChange={(e) => setData('email', e.target.value)}
//                           className={errors.email ? 'border-red-500' : ''}
//                         />
//                         {errors.email && (
//                           <p className="mt-1 text-sm text-red-500">
//                             {errors.email}
//                           </p>
//                         )}
//                       </div>

//                       <div>
//                         <Label htmlFor="telefono">Teléfono</Label>
//                         <Input
//                           id="telefono"
//                           value={data.telefono}
//                           onChange={(e) => setData('telefono', e.target.value)}
//                           className={errors.telefono ? 'border-red-500' : ''}
//                         />
//                         {errors.telefono && (
//                           <p className="mt-1 text-sm text-red-500">
//                             {errors.telefono}
//                           </p>
//                         )}
//                       </div>

//                       <div>
//                         <Label htmlFor="ciudad">Ciudad</Label>
//                         <Input
//                           id="ciudad"
//                           value={data.ciudad}
//                           onChange={(e) => setData('ciudad', e.target.value)}
//                           className={errors.ciudad ? 'border-red-500' : ''}
//                         />
//                         {errors.ciudad && (
//                           <p className="mt-1 text-sm text-red-500">
//                             {errors.ciudad}
//                           </p>
//                         )}
//                       </div>

//                       {/* <div className="md:col-span-2"> */}
//                       <div className="">
//                         <Label htmlFor="direccion">Dirección</Label>
//                         <Input
//                           id="direccion"
//                           value={data.direccion}
//                           onChange={(e) => setData('direccion', e.target.value)}
//                           className={errors.direccion ? 'border-red-500' : ''}
//                         />
//                         {errors.direccion && (
//                           <p className="mt-1 text-sm text-red-500">
//                             {errors.direccion}
//                           </p>
//                         )}
//                       </div>
//                     </div>
//                   </div>

//                   {/* === ALMACENES MÚLTIPLES === */}
//                   <div className="space-y-4">
//                     <div className="flex items-center justify-between">
//                       <h3 className="text-lg font-semibold">Almacenes</h3>
//                       <Button
//                         type="button"
//                         variant="outline"
//                         size="sm"
//                         onClick={addAlmacen}
//                       >
//                         <Plus className="mr-2 h-4 w-4" />
//                         Agregar Almacén
//                       </Button>
//                     </div>

//                     {data.almacenes.map((almacen, index) => (
//                       <div key={index} className="flex items-end gap-3">
//                         <div className="flex-1">
//                           <Label htmlFor={`almacen-${index}`}>
//                             Almacén {index + 1}
//                           </Label>
//                           <Input
//                             id={`almacen-${index}`}
//                             value={almacen.nombre}
//                             onChange={(e) =>
//                               updateAlmacen(index, 'nombre', e.target.value)
//                             }
//                             placeholder="Ej: Almacén Central, Sucursal Norte..."
//                             className={
//                               errors[`almacenes.${index}`]
//                                 ? 'border-red-500'
//                                 : ''
//                             }
//                           />
//                           {errors[`almacenes.${index}.nombre`] && (
//                             <p className="mt-1 text-sm text-red-500">
//                               {errors[`almacenes.${index}.nombre`]}
//                             </p>
//                           )}
//                         </div>

//                         {data.almacenes.length > 1 && (
//                           <Button
//                             type="button"
//                             variant="ghost"
//                             size="sm"
//                             onClick={() => removeAlmacen(index)}
//                             className="mb-1 text-red-600 hover:text-red-800"
//                           >
//                             <Trash2 className="h-4 w-4" />
//                           </Button>
//                         )}
//                       </div>
//                     ))}
//                   </div>

//                   {/* Detalles de la Cotización */}
//                   <div className="space-y-4">
//                     <div className="flex items-center justify-between">
//                       <h3 className="text-lg font-semibold">
//                         Detalles del contrato
//                       </h3>
//                       <Button
//                         type="button"
//                         variant="outline"
//                         size="sm"
//                         onClick={addDetalle}
//                       >
//                         <Plus className="mr-2 h-4 w-4" />
//                         Agregar Detalle
//                       </Button>
//                     </div>

//                     {data.detalles.map((detalle, index) => (
//                       <Card key={index} className="border-2">
//                         <CardContent className="">
//                           <div className="space-y-4">
//                             <div className="flex items-center justify-between">
//                               <span className="text-sm font-medium">
//                                 Detalle #{index + 1}
//                               </span>
//                               {data.detalles.length > 1 && (
//                                 <Button
//                                   type="button"
//                                   variant="ghost"
//                                   size="sm"
//                                   onClick={() => removeDetalle(index)}
//                                   className="text-red-500 hover:text-red-700"
//                                 >
//                                   <Trash2 className="h-4 w-4" />
//                                 </Button>
//                               )}
//                             </div>

//                             <div className="grid grid-cols-1 gap-4 md:grid-cols-4">
//                               <div>
//                                 <Label htmlFor={`descripcion-${index}`}>
//                                   Descripción
//                                 </Label>
//                                 <Textarea
//                                   id={`descripcion-${index}`}
//                                   value={detalle.descripcion}
//                                   onChange={(e) =>
//                                     updateDetalle(
//                                       index,
//                                       'descripcion',
//                                       e.target.value,
//                                     )
//                                   }
//                                   rows={3}
//                                   className={
//                                     errors[`detalles.${index}.descripcion`]
//                                       ? 'border-red-500'
//                                       : ''
//                                   }
//                                 />
//                                 {errors[`detalles.${index}.descripcion`] && (
//                                   <p className="mt-1 text-sm text-red-500">
//                                     {errors[`detalles.${index}.descripcion`]}
//                                   </p>
//                                 )}
//                               </div>
//                               <div>
//                                 <Label htmlFor={`area-${index}`}>
//                                   Área (m²)
//                                 </Label>
//                                 <Input
//                                   id={`area-${index}`}
//                                   type="number"
//                                   step="0.01"
//                                   value={detalle.area}
//                                   onChange={(e) =>
//                                     updateDetalle(
//                                       index,
//                                       'area',
//                                       parseFloat(e.target.value) || 0,
//                                     )
//                                   }
//                                   className={
//                                     errors[`detalles.${index}.area`]
//                                       ? 'border-red-500'
//                                       : ''
//                                   }
//                                 />
//                                 {errors[`detalles.${index}.area`] && (
//                                   <p className="mt-1 text-sm text-red-500">
//                                     {errors[`detalles.${index}.area`]}
//                                   </p>
//                                 )}
//                               </div>

//                               <div>
//                                 <Label htmlFor={`precio-${index}`}>
//                                   Precio Unitario
//                                 </Label>
//                                 <Input
//                                   id={`precio-${index}`}
//                                   type="number"
//                                   step="0.01"
//                                   value={detalle.precio_unitario}
//                                   onChange={(e) =>
//                                     updateDetalle(
//                                       index,
//                                       'precio_unitario',
//                                       parseFloat(e.target.value) || 0,
//                                     )
//                                   }
//                                   className={
//                                     errors[`detalles.${index}.precio_unitario`]
//                                       ? 'border-red-500'
//                                       : ''
//                                   }
//                                 />
//                                 {errors[
//                                   `detalles.${index}.precio_unitario`
//                                 ] && (
//                                   <p className="mt-1 text-sm text-red-500">
//                                     {
//                                       errors[
//                                         `detalles.${index}.precio_unitario`
//                                       ]
//                                     }
//                                   </p>
//                                 )}
//                               </div>

//                               <div>
//                                 <Label htmlFor={`total-${index}`}>Total</Label>
//                                 <Input
//                                   id={`total-${index}`}
//                                   type="number"
//                                   step="0.01"
//                                   value={Number(detalle.total || 0).toFixed(2)}
//                                   readOnly
//                                 />
//                               </div>
//                             </div>
//                           </div>
//                         </CardContent>
//                       </Card>
//                     ))}

//                     {/* Total General */}
//                     <div className="flex justify-end">
//                       <Card className="w-full">
//                         <CardContent className="pt-6">
//                           <div className="flex items-center justify-between text-lg font-bold">
//                             <span>Total General:</span>
//                             <span className="text-2xl">
//                               Bs. {calcularGranTotal().toFixed(2)}
//                             </span>
//                             <span>A Cuenta</span>
//                             <span>
//                               <Input
//                                 id="acuenta"
//                                 type="number"
//                                 step="0.01"
//                                 min="0"
//                                 value={data.acuenta || ''}
//                                 onChange={(e) =>
//                                   handleAcuentaChange(
//                                     parseFloat(e.target.value) || 0,
//                                   )
//                                 }
//                                 className="w-48"
//                               />
//                             </span>
//                             <span>Saldo:</span>
//                             <span
//                               className={
//                                 saldoCalculado < 0
//                                   ? 'text-red-600'
//                                   : 'text-green-600'
//                               }
//                             >
//                               ${saldoCalculado.toFixed(2)}
//                             </span>
//                           </div>
//                         </CardContent>
//                       </Card>
//                     </div>
//                   </div>

//                   {/* Botones de Acción */}
//                   <div className="flex justify-end gap-4">
//                     <Button
//                       type="button"
//                       variant="outline"
//                       onClick={() => router.visit('/cotizaciones')}
//                     >
//                       Cancelar
//                     </Button>
//                     <Button type="submit" disabled={processing}>
//                       {processing
//                         ? 'Guardando...'
//                         : cotizacion
//                           ? 'Actualizar'
//                           : 'Guardar'}
//                     </Button>
//                   </div>
//                 </form>
//               </CardContent>
//             </Card>
//           </div>
//         </div>
//       </>
//     </AppLayout>
//   );
// }
