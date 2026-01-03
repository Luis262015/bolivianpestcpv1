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
import { Plus, Trash2 } from 'lucide-react';
import { FormEventHandler, useMemo } from 'react';

const breadcrumbs: BreadcrumbItem[] = [
  { title: 'Cotizaciones', href: '/cotizaciones' },
  { title: 'Nueva Cotizacion', href: '/cotizaciones/create' },
];

interface Cotizacion {
  id?: number;
  nombre: string;
  email: string;
  // direccion: string;
  // ciudad: string;
  telefono: string;
  // fecha_fin_contrato: string;
  total: number;
  detalles: Detalle[];
}

interface Detalle {
  id?: number;
  nombre: string;
  t_cantidad: number;
  t_visitas: number;
  t_precio: number;
  t_total: number;
  a_area: number;
  a_visitas: number;
  a_precio: number;
  a_total: number;
  i_cantidad: number;
  i_precio: number;
  i_total: number;
}

// interface Almacen {
//   id?: number;
//   nombre: string;
//   // direccion: string;
//   // telefono: string;
//   // email: string;
//   // ciudad: string;
//   // encargado: string;
//   almacen_trampa: AlmacenTrampa;
//   almacen_area: AlmacenArea;
//   almacen_insectocutor: AlmancenInsectocutor;
// }

// interface AlmacenTrampa {
//   // descripcion: string;
//   cantidad: number;
//   visitas: number;
//   precio: number;
//   total: number;
//   // fechas_visitas?: string[];
// }

// interface AlmacenArea {
//   // descripcion: string;
//   area: number;
//   visitas: number;
//   precio: number;
//   total: number;
//   // fechas_visitas?: string[];
// }

// interface AlmancenInsectocutor {
//   // descripcion: string;
//   cantidad: number;
//   precio: number;
//   total: number;
// }

interface Props {
  cotizacion: Cotizacion;
}

export default function CotizacionForm({ cotizacion }: Props) {
  console.log(cotizacion);

  const { data, setData, post, put, processing, errors } = useForm<Cotizacion>({
    nombre: cotizacion?.nombre ?? '',
    telefono: cotizacion?.telefono ?? '',
    email: cotizacion?.email ?? '',
    total: cotizacion?.total ?? 0,

    detalles:
      cotizacion?.detalles?.length > 0
        ? cotizacion.detalles.map((a) => ({
            id: a.id,
            nombre: a.nombre ?? '',
            t_cantidad: a.t_cantidad ?? 0,
            t_visitas: a.t_visitas ?? 1,
            t_precio: a.t_precio ?? 0,
            t_total: a.t_total ?? 0,
            a_area: a.a_area ?? 0,
            a_visitas: a.a_visitas ?? 1,
            a_precio: a.a_precio ?? 0,
            a_total: a.a_total ?? 0,
            i_cantidad: a.i_cantidad ?? 0,
            i_precio: a.i_precio ?? 0,
            i_total: a.i_total ?? 0,
            // direccion: a.direccion ?? '',
            // telefono: a.telefono ?? '',
            // email: a.email ?? '',
            // ciudad: a.ciudad ?? '',
            // encargado: a.encargado ?? '',
            // almacen_trampa: {
            //   // descripcion:
            //   //   a.almacen_trampa?.descripcion ??
            //   //   'Control de roedores con trampas',
            //   cantidad: a.t_cantidad ?? 0,
            //   visitas: a.t_visitas ?? 1,
            //   precio: a.t_precio ?? 0,
            //   total: a.t_total ?? 0,
            //   // fechas_visitas:
            //   //   a.almacen_trampa?.fechas_visitas ?? Array(1).fill(''),
            // },
            // almacen_area: {
            //   // descripcion: a.almacen_area?.descripcion ?? 'Fumigación general',
            //   area: a.a_area ?? 0,
            //   visitas: a.a_visitas ?? 1,
            //   precio: a.a_precio ?? 0,
            //   total: a.a_total ?? 0,
            //   // fechas_visitas:
            //   //   a.almacen_area?.fechas_visitas ?? Array(1).fill(''),
            // },
            // almacen_insectocutor: {
            //   // descripcion:
            //   //   a.almacen_insectocutor?.descripcion ?? 'Insectocutores',
            //   cantidad: a.i_cantidad ?? 0,
            //   precio: a.i_precio ?? 0,
            //   total: a.i_total ?? 0,
            // },
          }))
        : [
            {
              nombre: '',
              t_cantidad: 0,
              t_visitas: 1,
              t_precio: 0,
              t_total: 0,
              a_area: 0,
              a_visitas: 1,
              a_precio: 0,
              a_total: 0,
              i_cantidad: 0,
              i_precio: 0,
              i_total: 0,
              // direccion: '',
              // telefono: '',
              // email: '',
              // ciudad: '',
              // encargado: '',
              // contacto_id: contactos[0]?.id ?? 0,
              // almacen_trampa: {
              //   // descripcion: 'Control de roedores con trampas',
              //   cantidad: 0,
              //   visitas: 1,
              //   precio: 0,
              //   total: 0,
              //   // fechas_visitas: Array(1).fill(''),
              // },
              // almacen_area: {
              //   // descripcion: 'Fumigación general',
              //   area: 0,
              //   visitas: 1,
              //   precio: 0,
              //   total: 0,
              //   // fechas_visitas: Array(1).fill(''),
              // },
              // almacen_insectocutor: {
              //   // descripcion: 'Insectocutores',
              //   cantidad: 0,
              //   precio: 0,
              //   total: 0,
              // },
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

  const calcularTotalInsectocutor = (cantidad: number, precio: number) => {
    return cantidad * precio;
  };

  // Actualizar totales cuando cambian los campos
  const updateTrampaField = (
    index: number,
    field: keyof Detalle,
    value: number | string,
  ) => {
    const updated = [...data.detalles];
    const trampa = { ...updated[index] };

    // if (field === 'descripcion') {
    //   trampa.descripcion = value as string;
    // } else
    // if (field === 'visitas') {
    //   const newVisitas = Number(value);
    //   trampa.visitas = newVisitas;
    //   // Ajustar el array de fechas según la cantidad de visitas
    //   const currentFechas = trampa.fechas_visitas || [];
    //   if (newVisitas > currentFechas.length) {
    //     trampa.fechas_visitas = [
    //       ...currentFechas,
    //       ...Array(newVisitas - currentFechas.length).fill(''),
    //     ];
    //   } else {
    //     trampa.fechas_visitas = currentFechas.slice(0, newVisitas);
    //   }
    // } else if (field !== 'fechas_visitas') {
    // }
    (trampa[field] as number) = Number(value);

    trampa.t_total = calcularTotalTrampas(
      trampa.t_cantidad,
      trampa.t_visitas,
      trampa.t_precio,
    );
    updated[index] = trampa;

    setData('detalles', updated);
  };

  const updateAreaField = (
    index: number,
    field: keyof Detalle,
    value: number | string,
  ) => {
    const updated = [...data.detalles];
    const area = { ...updated[index] };

    // if (field === 'descripcion') {
    //   area.descripcion = value as string;
    // } else
    // if (field === 'visitas') {
    //   const newVisitas = Number(value);
    //   area.visitas = newVisitas;
    //   // Ajustar el array de fechas según la cantidad de visitas
    //   const currentFechas = area.fechas_visitas || [];
    //   if (newVisitas > currentFechas.length) {
    //     area.fechas_visitas = [
    //       ...currentFechas,
    //       ...Array(newVisitas - currentFechas.length).fill(''),
    //     ];
    //   } else {
    //     area.fechas_visitas = currentFechas.slice(0, newVisitas);
    //   }
    // } else if (field !== 'fechas_visitas') {
    // }
    (area[field] as number) = Number(value);

    area.a_total = calcularTotalArea(
      area.a_area,
      area.a_visitas,
      area.a_precio,
    );
    updated[index] = area;

    setData('detalles', updated);
  };

  const updateInsectocutorField = (
    index: number,
    field: keyof Detalle,
    value: number | string,
  ) => {
    const updated = [...data.detalles];
    const insectocutor = { ...updated[index] };

    // if (field === 'descripcion') {
    //   insectocutor.descripcion = value as string;
    // } else {
    //   (insectocutor[field] as number) = Number(value);
    // }

    (insectocutor[field] as number) = Number(value);

    insectocutor.i_total = calcularTotalInsectocutor(
      insectocutor.i_cantidad,
      insectocutor.i_precio,
    );
    updated[index] = insectocutor;

    setData('detalles', updated);
  };

  // const updateTrampaFechaVisita = (
  //   almacenIndex: number,
  //   visitaIndex: number,
  //   fecha: string,
  // ) => {
  //   const updated = [...data.almacenes];
  //   const fechas = [
  //     ...(updated[almacenIndex].almacen_trampa.fechas_visitas || []),
  //   ];
  //   fechas[visitaIndex] = fecha;
  //   updated[almacenIndex].almacen_trampa.fechas_visitas = fechas;
  //   setData('almacenes', updated);
  // };

  // const updateAreaFechaVisita = (
  //   almacenIndex: number,
  //   visitaIndex: number,
  //   fecha: string,
  // ) => {
  //   const updated = [...data.almacenes];
  //   const fechas = [
  //     ...(updated[almacenIndex].almacen_area.fechas_visitas || []),
  //   ];
  //   fechas[visitaIndex] = fecha;
  //   updated[almacenIndex].almacen_area.fechas_visitas = fechas;
  //   setData('almacenes', updated);
  // };

  const totalAlmacenes = useMemo(() => {
    return data.detalles.reduce((sum, a) => {
      return (
        sum +
        (Number(a.t_total) ?? 0) +
        (Number(a.a_total) ?? 0) +
        (Number(a.i_total) ?? 0)
      );
    }, 0);
  }, [data.detalles]);

  const granTotal = totalAlmacenes;
  // const saldoCalculado = granTotal - (data.acuenta ?? 0);

  const addAlmacen = () => {
    setData('detalles', [
      ...data.detalles,
      {
        nombre: '',
        t_cantidad: 0,
        t_visitas: 1,
        t_precio: 0,
        t_total: 0,
        a_area: 0,
        a_visitas: 1,
        a_precio: 0,
        a_total: 0,
        i_cantidad: 0,
        i_precio: 0,
        i_total: 0,

        // direccion: '',
        // telefono: '',
        // email: '',
        // ciudad: '',
        // encargado: '',
        // contacto_id: contactos[0]?.id ?? 0,
        // almacen_trampa: {
        //   // descripcion: 'Control de roedores con trampas',
        //   cantidad: 0,
        //   visitas: 1,
        //   precio: 0,
        //   total: 0,
        //   // fechas_visitas: Array(1).fill(''),
        // },
        // almacen_area: {
        //   // descripcion: 'Fumigación general',
        //   area: 0,
        //   visitas: 1,
        //   precio: 0,
        //   total: 0,
        //   // fechas_visitas: Array(1).fill(''),
        // },
        // almacen_insectocutor: {
        //   // descripcion: 'Insectocutores',
        //   cantidad: 0,
        //   precio: 0,
        //   total: 0,
        // },
      },
    ]);
  };

  const removeAlmacen = (index: number) => {
    if (data.detalles.length > 1) {
      setData(
        'detalles',
        data.detalles.filter((_, i) => i !== index),
      );
    }
  };

  const handleSubmit: FormEventHandler = (e) => {
    e.preventDefault();
    const payload = {
      ...data,

      total: granTotal,
    };

    if (cotizacion?.id) {
      put(`/cotizaciones/${cotizacion.id}`, payload as any);
    } else {
      post('/cotizaciones', payload as any);
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
                {cotizacion ? 'Editar Cotizacion' : 'Nuevo Cotizacion'}
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
                    {/* <div>
                      <Label>Fecha de finalización del contrato</Label>
                      <Input
                        type="date"
                        value={data.fecha_fin_contrato}
                        onChange={(e) =>
                          setData('fecha_fin_contrato', e.target.value)
                        }
                      />
                    </div> */}
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
                    {/* <div>
                      <Label>Ciudad</Label>
                      <Input
                        value={data.ciudad}
                        onChange={(e) => setData('ciudad', e.target.value)}
                      />
                    </div> */}
                    {/* <div>
                      <Label>Dirección</Label>
                      <Input
                        value={data.direccion}
                        onChange={(e) => setData('direccion', e.target.value)}
                      />
                    </div> */}
                  </div>
                </div>

                {/* === ALMACENES === */}
                <div className="space-y-6">
                  <div className="flex items-center justify-between">
                    <h3 className="text-lg font-semibold">Almacenes</h3>
                    <Button type="button" size="sm" onClick={addAlmacen}>
                      <Plus className="mr-2 h-4 w-4" /> Agregar Almacén
                    </Button>
                  </div>

                  {data.detalles.map((almacen, index) => (
                    <Card key={index} className="border-2">
                      <CardHeader>
                        <div className="flex items-center justify-between">
                          <CardTitle className="text-lg">
                            Almacén #{index + 1} —{' '}
                            {almacen.nombre || 'Sin nombre'}
                          </CardTitle>
                          {data.detalles.length > 1 && (
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
                                  `detalles.${index}.nombre` as any,
                                  e.target.value,
                                )
                              }
                              placeholder="Ej. Almacén Central"
                            />
                          </div>
                          {/* <div>
                            <Label>Email</Label>
                            <Input
                              value={almacen.email}
                              onChange={(e) =>
                                setData(
                                  `almacenes.${index}.email` as any,
                                  e.target.value,
                                )
                              }
                              placeholder="Ej. almacen@empresa.com"
                            />
                          </div> */}
                          {/* <div>
                            <Label>Direccion</Label>
                            <Input
                              value={almacen.direccion}
                              onChange={(e) =>
                                setData(
                                  `almacenes.${index}.direccion` as any,
                                  e.target.value,
                                )
                              }
                              placeholder="Ej. Calle #111"
                            />
                          </div> */}
                          {/* <div>
                            <Label>Ciudad</Label>
                            <Input
                              value={almacen.ciudad}
                              onChange={(e) =>
                                setData(
                                  `almacenes.${index}.ciudad` as any,
                                  e.target.value,
                                )
                              }
                              placeholder="Ej. La Paz"
                            />
                          </div> */}

                          {/* <div>
                            <Label>Encargado</Label>
                            <Input
                              value={almacen.encargado}
                              onChange={(e) =>
                                setData(
                                  `almacenes.${index}.encargado` as any,
                                  e.target.value,
                                )
                              }
                              placeholder="Ej. Pablo Perez"
                            />
                          </div> */}
                          {/* <div>
                            <Label>Telefono</Label>
                            <Input
                              value={almacen.telefono}
                              onChange={(e) =>
                                setData(
                                  `almacenes.${index}.telefono` as any,
                                  e.target.value,
                                )
                              }
                              placeholder="Ej. 76543211"
                            />
                          </div> */}
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
                        <div className="rounded-lg border bg-amber-300/10 p-4">
                          <h4 className="mb-4 font-semibold text-primary">
                            Servicio por Trampas
                          </h4>
                          <div className="grid grid-cols-1 gap-4 md:grid-cols-4">
                            {/* <div className="">
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
                            </div> */}
                            <div>
                              <Label>Cantidad</Label>
                              <Input
                                type="number"
                                value={almacen.t_cantidad}
                                onChange={(e) =>
                                  updateTrampaField(
                                    index,
                                    't_cantidad',
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
                                value={almacen.t_visitas}
                                onChange={(e) =>
                                  updateTrampaField(
                                    index,
                                    't_visitas',
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
                                value={almacen.t_precio}
                                onChange={(e) =>
                                  updateTrampaField(
                                    index,
                                    't_precio',
                                    e.target.value,
                                  )
                                }
                              />
                            </div>
                          </div>

                          {/* Fechas de visitas para trampas */}
                          {/* {almacen.almacen_trampa.visitas > 0 && (
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
                          )} */}

                          <p className="mt-4 text-right text-lg font-bold">
                            Total anual: Bs.{' '}
                            {Number(almacen.t_total).toFixed(2)}
                          </p>
                        </div>

                        {/* === SERVICIO POR ÁREA === */}
                        {/* <div className="rounded-lg border bg-muted/40 p-4"> */}
                        <div className="rounded-lg border bg-blue-500/10 p-4">
                          <h4 className="mb-4 font-semibold text-primary">
                            Servicio por Área (m²)
                          </h4>
                          <div className="grid grid-cols-1 gap-4 md:grid-cols-4">
                            {/* <div className="">
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
                            </div> */}
                            <div>
                              <Label>Área (m²)</Label>
                              <Input
                                type="number"
                                step="0.01"
                                value={almacen.a_area}
                                onChange={(e) =>
                                  updateAreaField(
                                    index,
                                    'a_area',
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
                                value={almacen.a_visitas}
                                onChange={(e) =>
                                  updateAreaField(
                                    index,
                                    'a_visitas',
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
                                value={almacen.a_precio}
                                onChange={(e) =>
                                  updateAreaField(
                                    index,
                                    'a_precio',
                                    e.target.value,
                                  )
                                }
                              />
                            </div>
                          </div>

                          {/* Fechas de visitas para área */}
                          {/* {almacen.almacen_area.visitas > 0 && (
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
                          )} */}

                          <p className="mt-4 text-right text-lg font-bold">
                            Total anual: Bs.{' '}
                            {Number(almacen.a_total).toFixed(2)}
                          </p>
                        </div>

                        {/* === SERVICIO POR INSECTOCUTOR === */}
                        {/* <div className="rounded-lg border bg-muted/40 p-4"> */}
                        <div className="rounded-lg border bg-red-700/10 p-4">
                          <h4 className="mb-4 font-semibold text-primary">
                            Servicio por Insectocutores
                          </h4>
                          <div className="grid grid-cols-1 gap-4 md:grid-cols-4">
                            {/* <div className="">
                              <Label>Descripción</Label>
                              <Input
                                value={almacen.almacen_insectocutor.descripcion}
                                onChange={(e) =>
                                  updateInsectocutorField(
                                    index,
                                    'descripcion',
                                    e.target.value,
                                  )
                                }
                              />
                            </div> */}
                            <div>
                              <Label>Cantidad: </Label>
                              <Input
                                type="number"
                                step="0.01"
                                value={almacen.i_cantidad}
                                onChange={(e) =>
                                  updateInsectocutorField(
                                    index,
                                    'i_cantidad',
                                    e.target.value,
                                  )
                                }
                              />
                            </div>

                            <div>
                              <Label>Precio: </Label>
                              <Input
                                type="number"
                                step="0.01"
                                value={almacen.i_precio}
                                onChange={(e) =>
                                  updateInsectocutorField(
                                    index,
                                    'i_precio',
                                    e.target.value,
                                  )
                                }
                              />
                            </div>
                          </div>

                          <p className="mt-4 text-right text-lg font-bold">
                            Total anual: Bs.{' '}
                            {Number(almacen.i_total).toFixed(2)}
                          </p>
                        </div>

                        <div className="flex justify-end">
                          <div className="text-right">
                            <p className="text-sm text-muted-foreground">
                              Total este almacén
                            </p>
                            <p className="text-2xl font-bold text-primary">
                              Bs.{' '}
                              {Number(
                                Number(almacen.t_total) +
                                  Number(almacen.a_total) +
                                  Number(almacen.i_total),
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
                        Total del Contrato: Bs. {Number(granTotal).toFixed(2)}
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
                    onClick={() => router.visit('/cotizaciones')}
                  >
                    Cancelar
                  </Button>
                  <Button type="submit" disabled={processing}>
                    {processing
                      ? 'Guardando...'
                      : cotizacion
                        ? 'Actualizar'
                        : 'Crear Cotizacion'}
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
