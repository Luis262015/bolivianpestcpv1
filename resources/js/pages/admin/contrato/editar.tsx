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

// ─── Interfaces ────────────────────────────────────────────────────────────────

interface AlmacenTrampa {
  id?: number;
  cantidad: number;
  visitas: number;
  precio: number;
  total: number;
  fechas_visitas?: string[];
}

interface AlmacenArea {
  id?: number;
  area: number;
  visitas: number;
  precio: number;
  total: number;
  fechas_visitas?: string[];
}

interface AlmacenInsectocutor {
  id?: number;
  cantidad: number;
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
  encargado: string;
  almacen_trampa: AlmacenTrampa;
  almacen_area: AlmacenArea;
  almacen_insectocutor: AlmacenInsectocutor;
}

interface Empresa {
  id: number;
  nombre: string;
  email: string;
  direccion: string;
  ciudad: string;
  telefono: string;
}

interface Contrato {
  id: number;
  total: number;
  expiracion: string;
  empresa: Empresa;
}

interface FormData {
  nombre: string;
  email: string;
  direccion: string;
  ciudad: string;
  telefono: string;
  expiracion: string;
  total: number;
  almacenes: Almacen[];
}

interface Props {
  contrato: Contrato;
  almacenes: Almacen[];
}

// ─── Helpers ───────────────────────────────────────────────────────────────────

const calcularTotalTrampas = (
  cantidad: number,
  visitas: number,
  precio: number,
) => cantidad * visitas * precio;

const calcularTotalArea = (area: number, visitas: number, precio: number) =>
  area * visitas * precio;

const calcularTotalInsectocutor = (visitas: number, precio: number) =>
  visitas * precio;

const emptyAlmacen = (): Almacen => ({
  nombre: '',
  direccion: '',
  telefono: '',
  email: '',
  ciudad: '',
  encargado: '',
  almacen_trampa: {
    cantidad: 0,
    visitas: 1,
    precio: 0,
    total: 0,
    fechas_visitas: [''],
  },
  almacen_area: {
    area: 0,
    visitas: 1,
    precio: 0,
    total: 0,
    fechas_visitas: [''],
  },
  almacen_insectocutor: {
    cantidad: 0,
    visitas: 1,
    precio: 0,
    total: 0,
    fechas_visitas: [''],
  },
});

// ─── Mapear almacenes que vienen del backend ────────────────────────────────────
// El backend retorna almacen_trampa, almacen_area, almacen_insectocutor como objetos
// con los campos de la BD. Normalizamos aquí.
const mapAlmacenFromBackend = (a: any): Almacen => {
  const trampaVisitas = a.almacen_trampa?.visitas ?? 1;
  const areaVisitas = a.almacen_area?.visitas ?? 1;
  const insectVisitas = a.almacen_insectocutor?.visitas ?? 1;

  return {
    id: a.id,
    nombre: a.nombre ?? '',
    direccion: a.direccion ?? '',
    telefono: a.telefono ?? '',
    email: a.email ?? '',
    ciudad: a.ciudad ?? '',
    encargado: a.encargado ?? '',
    almacen_trampa: {
      id: a.almacen_trampa?.id,
      cantidad: a.almacen_trampa?.cantidad ?? 0,
      visitas: trampaVisitas,
      precio: a.almacen_trampa?.precio ?? 0,
      total: a.almacen_trampa?.total ?? 0,
      // Si no vienen fechas guardadas, generamos slots vacíos
      fechas_visitas:
        a.almacen_trampa?.fechas_visitas ?? Array(trampaVisitas).fill(''),
    },
    almacen_area: {
      id: a.almacen_area?.id,
      area: a.almacen_area?.area ?? 0,
      visitas: areaVisitas,
      precio: a.almacen_area?.precio ?? 0,
      total: a.almacen_area?.total ?? 0,
      fechas_visitas:
        a.almacen_area?.fechas_visitas ?? Array(areaVisitas).fill(''),
    },
    almacen_insectocutor: {
      id: a.almacen_insectocutor?.id,
      cantidad: a.almacen_insectocutor?.cantidad ?? 0,
      visitas: insectVisitas,
      precio: a.almacen_insectocutor?.precio ?? 0,
      total: a.almacen_insectocutor?.total ?? 0,
      fechas_visitas:
        a.almacen_insectocutor?.fechas_visitas ?? Array(insectVisitas).fill(''),
    },
  };
};

// ─── Componente principal ──────────────────────────────────────────────────────

export default function EditarContrato({ contrato, almacenes }: Props) {
  const breadcrumbs: BreadcrumbItem[] = [
    { title: 'Contratos', href: '/contratos' },
    {
      title: `Editar Contrato #${contrato.id}`,
      href: `/contratos/${contrato.id}/edit`,
    },
  ];

  const { data, setData, put, processing, errors } = useForm<FormData>({
    nombre: contrato.empresa?.nombre ?? '',
    email: contrato.empresa?.email ?? '',
    direccion: contrato.empresa?.direccion ?? '',
    ciudad: contrato.empresa?.ciudad ?? '',
    telefono: contrato.empresa?.telefono ?? '',
    expiracion: contrato.expiracion ?? '',
    total: contrato.total ?? 0,
    almacenes:
      almacenes?.length > 0
        ? almacenes.map(mapAlmacenFromBackend)
        : [emptyAlmacen()],
  });

  console.log(almacenes);

  // ─── Actualizar campos de trampas ─────────────────────────────────────────
  const updateTrampaField = (
    index: number,
    field: keyof AlmacenTrampa,
    value: number | string,
  ) => {
    const updated = [...data.almacenes];
    const trampa = { ...updated[index].almacen_trampa };

    if (field === 'visitas') {
      const newVisitas = Number(value);
      trampa.visitas = newVisitas;
      const curr = trampa.fechas_visitas || [];
      trampa.fechas_visitas =
        newVisitas > curr.length
          ? [...curr, ...Array(newVisitas - curr.length).fill('')]
          : curr.slice(0, newVisitas);
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

  // ─── Actualizar campos de área ────────────────────────────────────────────
  const updateAreaField = (
    index: number,
    field: keyof AlmacenArea,
    value: number | string,
  ) => {
    const updated = [...data.almacenes];
    const area = { ...updated[index].almacen_area };

    if (field === 'visitas') {
      const newVisitas = Number(value);
      area.visitas = newVisitas;
      const curr = area.fechas_visitas || [];
      area.fechas_visitas =
        newVisitas > curr.length
          ? [...curr, ...Array(newVisitas - curr.length).fill('')]
          : curr.slice(0, newVisitas);
    } else if (field !== 'fechas_visitas') {
      (area[field] as number) = Number(value);
    }

    area.total = calcularTotalArea(area.area, area.visitas, area.precio);
    updated[index].almacen_area = area;
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

  // ─── Actualizar campos de insectocutores ──────────────────────────────────
  const updateInsectocutorField = (
    index: number,
    field: keyof AlmacenInsectocutor,
    value: number | string,
  ) => {
    const updated = [...data.almacenes];
    const insect = { ...updated[index].almacen_insectocutor };

    if (field === 'visitas') {
      const newVisitas = Number(value);
      insect.visitas = newVisitas;
      const curr = insect.fechas_visitas || [];
      insect.fechas_visitas =
        newVisitas > curr.length
          ? [...curr, ...Array(newVisitas - curr.length).fill('')]
          : curr.slice(0, newVisitas);
    } else if (field !== 'fechas_visitas') {
      (insect[field] as number) = Number(value);
    }

    insect.total = calcularTotalInsectocutor(insect.visitas, insect.precio);
    updated[index].almacen_insectocutor = insect;
    setData('almacenes', updated);
  };

  const updateInsectocutorFechaVisita = (
    almacenIndex: number,
    visitaIndex: number,
    fecha: string,
  ) => {
    const updated = [...data.almacenes];
    const fechas = [
      ...(updated[almacenIndex].almacen_insectocutor.fechas_visitas || []),
    ];
    fechas[visitaIndex] = fecha;
    updated[almacenIndex].almacen_insectocutor.fechas_visitas = fechas;
    setData('almacenes', updated);
  };

  // ─── Agregar / eliminar almacenes ─────────────────────────────────────────
  const addAlmacen = () =>
    setData('almacenes', [...data.almacenes, emptyAlmacen()]);

  const removeAlmacen = (index: number) => {
    if (data.almacenes.length > 1) {
      setData(
        'almacenes',
        data.almacenes.filter((_, i) => i !== index),
      );
    }
  };

  // ─── Total general ────────────────────────────────────────────────────────
  const granTotal = useMemo(
    () =>
      data.almacenes.reduce(
        (sum, a) =>
          sum +
          Number(a.almacen_trampa?.total ?? 0) +
          Number(a.almacen_area?.total ?? 0) +
          Number(a.almacen_insectocutor?.total ?? 0),
        0,
      ),
    [data.almacenes],
  );

  // ─── Submit ───────────────────────────────────────────────────────────────
  const handleSubmit: FormEventHandler = (e) => {
    e.preventDefault();
    put(`/contratos/${contrato.id}`, {
      // Inertia's put() no acepta payload como segundo arg, usamos setData antes del put
    } as any);
  };

  // Actualizamos total antes de enviar
  const handleSubmitWithTotal: FormEventHandler = (e) => {
    e.preventDefault();
    setData('total', granTotal);
    // Pequeño timeout para que setData se procese antes del put
    setTimeout(() => {
      // put(route('contratos.update', contrato.id));
      put(`/contratos/${contrato.id}`);
    }, 0);
  };

  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title={`Editar Contrato #${contrato.id}`} />

      <div className="py-5">
        <div className="mx-auto max-w-7xl sm:px-6 lg:px-8">
          <Card>
            <CardHeader>
              <CardTitle>Editar Contrato #{contrato.id}</CardTitle>
              <CardDescription>
                Modifique los datos del cliente y los servicios por almacén
              </CardDescription>
            </CardHeader>

            <CardContent>
              <form onSubmit={handleSubmitWithTotal} className="space-y-10">
                {/* ── DATOS DEL CLIENTE ─────────────────────────────────── */}
                <div className="space-y-6">
                  <h3 className="text-lg font-semibold">
                    Información del Cliente
                  </h3>

                  {/* Mostrar errores globales si los hay */}
                  {Object.keys(errors).length > 0 && (
                    <div className="rounded-md border border-red-300 bg-red-50 p-4 text-sm text-red-700">
                      Revise los campos con errores antes de guardar.
                    </div>
                  )}

                  <div className="grid grid-cols-1 gap-6 md:grid-cols-2">
                    <div>
                      <Label>Nombre del cliente</Label>
                      <Input
                        value={data.nombre}
                        onChange={(e) => setData('nombre', e.target.value)}
                        placeholder="Ej. Empresa S.A."
                      />
                      {errors.nombre && (
                        <p className="mt-1 text-xs text-red-500">
                          {errors.nombre}
                        </p>
                      )}
                    </div>

                    <div>
                      <Label>Fecha de finalización del contrato</Label>
                      <Input
                        type="date"
                        value={data.expiracion}
                        onChange={(e) => setData('expiracion', e.target.value)}
                      />
                      {errors.expiracion && (
                        <p className="mt-1 text-xs text-red-500">
                          {errors.expiracion}
                        </p>
                      )}
                    </div>

                    <div>
                      <Label>Email</Label>
                      <Input
                        type="email"
                        value={data.email}
                        onChange={(e) => setData('email', e.target.value)}
                        placeholder="Ej. contacto@empresa.com"
                      />
                      {errors.email && (
                        <p className="mt-1 text-xs text-red-500">
                          {errors.email}
                        </p>
                      )}
                    </div>

                    <div>
                      <Label>Teléfono</Label>
                      <Input
                        value={data.telefono}
                        onChange={(e) => setData('telefono', e.target.value)}
                        placeholder="Ej. 76543210"
                      />
                      {errors.telefono && (
                        <p className="mt-1 text-xs text-red-500">
                          {errors.telefono}
                        </p>
                      )}
                    </div>

                    <div>
                      <Label>Ciudad</Label>
                      <Input
                        value={data.ciudad}
                        onChange={(e) => setData('ciudad', e.target.value)}
                        placeholder="Ej. La Paz"
                      />
                      {errors.ciudad && (
                        <p className="mt-1 text-xs text-red-500">
                          {errors.ciudad}
                        </p>
                      )}
                    </div>

                    <div>
                      <Label>Dirección</Label>
                      <Input
                        value={data.direccion}
                        onChange={(e) => setData('direccion', e.target.value)}
                        placeholder="Ej. Av. Principal #123"
                      />
                      {errors.direccion && (
                        <p className="mt-1 text-xs text-red-500">
                          {errors.direccion}
                        </p>
                      )}
                    </div>
                  </div>
                </div>

                {/* ── ALMACENES ──────────────────────────────────────────── */}
                <div className="space-y-6">
                  <div className="flex items-center justify-between">
                    <h3 className="text-lg font-semibold">Almacenes</h3>
                    <Button type="button" size="sm" onClick={addAlmacen}>
                      <Plus className="mr-2 h-4 w-4" /> Agregar Almacén
                    </Button>
                  </div>

                  {data.almacenes.map((almacen, index) => (
                    <Card key={almacen.id ?? index} className="border-2">
                      <CardHeader>
                        <div className="flex items-center justify-between">
                          <CardTitle className="text-lg">
                            Almacén #{index + 1} —{' '}
                            {almacen.nombre || 'Sin nombre'}
                            {almacen.id && (
                              <span className="ml-2 text-sm font-normal text-muted-foreground">
                                (ID: {almacen.id})
                              </span>
                            )}
                          </CardTitle>
                          {data.almacenes.length > 1 && (
                            <Button
                              type="button"
                              variant="ghost"
                              size="icon"
                              onClick={() => removeAlmacen(index)}
                              className="text-red-600 hover:text-red-700"
                            >
                              <Trash2 className="h-4 w-4" />
                            </Button>
                          )}
                        </div>
                      </CardHeader>

                      <CardContent className="space-y-6">
                        {/* Datos generales del almacén */}
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
                            <Label>Email</Label>
                            <Input
                              type="email"
                              value={almacen.email}
                              onChange={(e) =>
                                setData(
                                  `almacenes.${index}.email` as any,
                                  e.target.value,
                                )
                              }
                              placeholder="Ej. almacen@empresa.com"
                            />
                          </div>
                          <div>
                            <Label>Dirección</Label>
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
                          </div>
                          <div>
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
                          </div>
                          <div>
                            <Label>Encargado</Label>
                            <Input
                              value={almacen.encargado}
                              onChange={(e) =>
                                setData(
                                  `almacenes.${index}.encargado` as any,
                                  e.target.value,
                                )
                              }
                              placeholder="Ej. Pablo Pérez"
                            />
                          </div>
                          <div>
                            <Label>Teléfono</Label>
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
                          </div>
                        </div>

                        {/* ── SERVICIO POR TRAMPAS ────────────────────── */}
                        <div className="rounded-lg border bg-amber-300/10 p-4">
                          <h4 className="mb-4 font-semibold text-primary">
                            Servicio por Trampas (Desratización)
                          </h4>
                          <div className="grid grid-cols-1 gap-4 md:grid-cols-4">
                            <div>
                              <Label>Cantidad</Label>
                              <Input
                                type="number"
                                min="0"
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
                                min="0"
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
                                min="0"
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
                                      required
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
                                  <div
                                    key={visitaIndex}
                                    className="flex items-end gap-1"
                                  >
                                    <div className="flex-1">
                                      <Label className="text-xs">
                                        Visita {visitaIndex + 1}
                                      </Label>
                                      <Input
                                        type="date"
                                        required
                                        value={
                                          almacen.almacen_trampa
                                            .fechas_visitas?.[visitaIndex] || ''
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
                                    <Button
                                      type="button"
                                      variant="ghost"
                                      size="icon"
                                      className="mb-0.5 shrink-0 text-red-500 hover:text-red-700"
                                      onClick={() =>
                                        updateTrampaFechaVisita(
                                          index,
                                          visitaIndex,
                                          '',
                                        )
                                      }
                                    >
                                      <Trash2 className="h-4 w-4" />
                                    </Button>
                                  </div>
                                ))}
                              </div>
                            </div>
                          )}

                          <p className="mt-4 text-right text-lg font-bold">
                            Total anual: Bs.{' '}
                            {Number(almacen.almacen_trampa.total).toFixed(2)}
                          </p>
                        </div>

                        {/* ── SERVICIO POR ÁREA ───────────────────────── */}
                        <div className="rounded-lg border bg-blue-500/10 p-4">
                          <h4 className="mb-4 font-semibold text-primary">
                            Servicio por Área (m²) — Fumigación
                          </h4>
                          <div className="grid grid-cols-1 gap-4 md:grid-cols-4">
                            <div>
                              <Label>Área (m²)</Label>
                              <Input
                                type="number"
                                step="0.01"
                                min="0"
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
                                min="0"
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
                                min="0"
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
                                  <div
                                    key={visitaIndex}
                                    className="flex items-end gap-1"
                                  >
                                    <div className="flex-1">
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
                                    <Button
                                      type="button"
                                      variant="ghost"
                                      size="icon"
                                      className="mb-0.5 shrink-0 text-red-500 hover:text-red-700"
                                      onClick={() =>
                                        updateAreaFechaVisita(
                                          index,
                                          visitaIndex,
                                          '',
                                        )
                                      }
                                    >
                                      <Trash2 className="h-4 w-4" />
                                    </Button>
                                  </div>
                                ))}
                              </div>
                            </div>
                          )}

                          <p className="mt-4 text-right text-lg font-bold">
                            Total anual: Bs.{' '}
                            {Number(almacen.almacen_area.total).toFixed(2)}
                          </p>
                        </div>

                        {/* ── SERVICIO POR INSECTOCUTORES ─────────────── */}
                        <div className="rounded-lg border bg-red-700/10 p-4">
                          <h4 className="mb-4 font-semibold text-primary">
                            Servicio por Insectocutores
                          </h4>
                          <div className="grid grid-cols-1 gap-4 md:grid-cols-4">
                            <div>
                              <Label>Cantidad</Label>
                              <Input
                                type="number"
                                step="0.01"
                                min="0"
                                value={almacen.almacen_insectocutor.cantidad}
                                onChange={(e) =>
                                  updateInsectocutorField(
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
                                min="0"
                                value={almacen.almacen_insectocutor.visitas}
                                onChange={(e) =>
                                  updateInsectocutorField(
                                    index,
                                    'visitas',
                                    e.target.value,
                                  )
                                }
                              />
                            </div>
                            <div>
                              <Label>Precio</Label>
                              <Input
                                type="number"
                                step="0.01"
                                min="0"
                                value={almacen.almacen_insectocutor.precio}
                                onChange={(e) =>
                                  updateInsectocutorField(
                                    index,
                                    'precio',
                                    e.target.value,
                                  )
                                }
                              />
                            </div>
                          </div>

                          {/* {almacen.almacen_insectocutor.visitas > 0 && (
                            <div className="mt-6 space-y-3">
                              <div className="flex items-center gap-2">
                                <Calendar className="h-4 w-4 text-primary" />
                                <Label className="text-sm font-semibold">
                                  Fechas programadas de visitas
                                </Label>
                              </div>
                              <div className="grid grid-cols-2 gap-3 md:grid-cols-3 lg:grid-cols-4">
                                {Array.from({
                                  length: almacen.almacen_insectocutor.visitas,
                                }).map((_, visitaIndex) => (
                                  <div key={visitaIndex}>
                                    <Label className="text-xs">
                                      Visita {visitaIndex + 1}
                                    </Label>
                                    <Input
                                      type="date"
                                      required
                                      value={
                                        almacen.almacen_insectocutor
                                          .fechas_visitas?.[visitaIndex] || ''
                                      }
                                      onChange={(e) =>
                                        updateInsectocutorFechaVisita(
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

                          {almacen.almacen_insectocutor.visitas > 0 && (
                            <div className="mt-6 space-y-3">
                              <div className="flex items-center gap-2">
                                <Calendar className="h-4 w-4 text-primary" />
                                <Label className="text-sm font-semibold">
                                  Fechas programadas de visitas
                                </Label>
                              </div>
                              <div className="grid grid-cols-2 gap-3 md:grid-cols-3 lg:grid-cols-4">
                                {Array.from({
                                  length: almacen.almacen_insectocutor.visitas,
                                }).map((_, visitaIndex) => (
                                  <div
                                    key={visitaIndex}
                                    className="flex items-end gap-1"
                                  >
                                    <div className="flex-1">
                                      <Label className="text-xs">
                                        Visita {visitaIndex + 1}
                                      </Label>
                                      <Input
                                        type="date"
                                        required
                                        value={
                                          almacen.almacen_insectocutor
                                            .fechas_visitas?.[visitaIndex] || ''
                                        }
                                        onChange={(e) =>
                                          updateInsectocutorFechaVisita(
                                            index,
                                            visitaIndex,
                                            e.target.value,
                                          )
                                        }
                                        className="text-sm"
                                      />
                                    </div>
                                    <Button
                                      type="button"
                                      variant="ghost"
                                      size="icon"
                                      className="mb-0.5 shrink-0 text-red-500 hover:text-red-700"
                                      onClick={() =>
                                        updateInsectocutorFechaVisita(
                                          index,
                                          visitaIndex,
                                          '',
                                        )
                                      }
                                    >
                                      <Trash2 className="h-4 w-4" />
                                    </Button>
                                  </div>
                                ))}
                              </div>
                            </div>
                          )}

                          <p className="mt-4 text-right text-lg font-bold">
                            Total anual: Bs.{' '}
                            {Number(almacen.almacen_insectocutor.total).toFixed(
                              2,
                            )}
                          </p>
                        </div>

                        {/* Total por almacén */}
                        <div className="flex justify-end">
                          <div className="text-right">
                            <p className="text-sm text-muted-foreground">
                              Total este almacén
                            </p>
                            <p className="text-2xl font-bold text-primary">
                              Bs.{' '}
                              {Number(
                                Number(almacen.almacen_trampa.total) +
                                  Number(almacen.almacen_area.total) +
                                  Number(almacen.almacen_insectocutor.total),
                              ).toFixed(2)}
                            </p>
                          </div>
                        </div>
                      </CardContent>
                    </Card>
                  ))}
                </div>

                {/* ── RESUMEN FINAL ──────────────────────────────────────── */}
                <Card className="border-2 bg-primary/5">
                  <CardContent className="pt-8">
                    <div className="space-y-6 text-right">
                      <div className="text-2xl font-bold text-primary">
                        TOTAL DEL CONTRATO: Bs. {Number(granTotal).toFixed(2)}
                      </div>
                    </div>
                  </CardContent>
                </Card>

                {/* ── ACCIONES ──────────────────────────────────────────── */}
                <div className="flex justify-end gap-4 pt-8">
                  <Button
                    type="button"
                    variant="outline"
                    onClick={() => router.visit('/contratos')}
                  >
                    Cancelar
                  </Button>
                  <Button type="submit" disabled={processing}>
                    {processing ? 'Guardando...' : 'Actualizar Contrato'}
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
// *********************************************************************************
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
// import AppLayout from '@/layouts/app-layout';
// import { type BreadcrumbItem } from '@/types';
// import { Head, router, useForm } from '@inertiajs/react';
// import { Plus, Trash2 } from 'lucide-react';
// import { FormEventHandler, useMemo } from 'react';

// /* ============================================================
//    Breadcrumbs
// ============================================================ */
// const breadcrumbs: BreadcrumbItem[] = [
//   { title: 'Contratos', href: '/contratos' },
//   { title: 'Editar Contrato', href: '/contratos/create' },
// ];

// /* ============================================================
//    Interfaces
// ============================================================ */
// interface Empresa {
//   nombre: string;
//   direccion: string;
//   telefono: string;
//   email: string;
//   ciudad: string;
// }

// interface Contrato {
//   id?: number;
//   empresa?: Empresa;
//   expiracion?: string;
//   total?: number;
// }

// interface AlmacenTrampa {
//   cantidad: number;
//   visitas: number;
//   precio: number;
//   total: number;
//   fechas_visitas: string[];
// }

// interface AlmacenArea {
//   area: number;
//   visitas: number;
//   precio: number;
//   total: number;
//   fechas_visitas: string[];
// }

// interface AlmacenInsectocutor {
//   cantidad: number;
//   visitas: number;
//   precio: number;
//   total: number;
// }

// interface Almacen {
//   nombre: string;
//   direccion: string;
//   telefono: string;
//   email: string;
//   ciudad: string;
//   encargado: string;
//   almacen_trampa: AlmacenTrampa;
//   almacen_area: AlmacenArea;
//   almacen_insectocutor: AlmacenInsectocutor;
// }

// interface FormData {
//   expiracion: string;
//   total: number;

//   nombre: string;
//   direccion: string;
//   telefono: string;
//   email: string;
//   ciudad: string;

//   almacenes: Almacen[];
// }

// interface Props {
//   contrato?: Contrato;
//   almacenes: Almacen[];
// }

// /* ============================================================
//    Componente
// ============================================================ */
// export default function CotizacionForm({ contrato, almacenes }: Props) {
//   console.log(contrato);
//   console.log(almacenes);

//   const { data, setData, post, put, processing, errors } = useForm<FormData>({
//     expiracion: contrato?.expiracion ?? '',
//     total: contrato?.total ?? 0,

//     nombre: contrato?.empresa?.nombre ?? '',
//     direccion: contrato?.empresa?.direccion ?? '',
//     telefono: contrato?.empresa?.telefono ?? '',
//     email: contrato?.empresa?.email ?? '',
//     ciudad: contrato?.empresa?.ciudad ?? '',

//     almacenes:
//       almacenes.length > 0
//         ? almacenes
//         : [
//             {
//               nombre: '',
//               direccion: '',
//               telefono: '',
//               email: '',
//               ciudad: '',
//               encargado: '',
//               almacen_trampa: {
//                 cantidad: 0,
//                 visitas: 1,
//                 precio: 0,
//                 total: 0,
//                 fechas_visitas: [''],
//               },
//               almacen_area: {
//                 area: 0,
//                 visitas: 1,
//                 precio: 0,
//                 total: 0,
//                 fechas_visitas: [''],
//               },
//               almacen_insectocutor: {
//                 cantidad: 0,
//                 visitas: 0,
//                 precio: 0,
//                 total: 0,
//               },
//             },
//           ],
//   });

//   console.log(errors);

//   /* ============================================================
//      Cálculos
//   ============================================================ */
//   const granTotal = useMemo(() => {
//     return data.almacenes.reduce((sum, a) => {
//       return (
//         sum +
//         Number(a.almacen_trampa.total) +
//         Number(a.almacen_area.total) +
//         Number(a.almacen_insectocutor.total)
//       );
//     }, 0);
//   }, [data.almacenes]);

//   /* ============================================================
//      Updates
//   ============================================================ */
//   const updateTrampa = (
//     index: number,
//     field: keyof AlmacenTrampa,
//     value: number | string,
//   ) => {
//     const updated = [...data.almacenes];
//     const t = { ...updated[index].almacen_trampa };

//     if (field === 'visitas') {
//       const v = Number(value);
//       t.visitas = v;
//       t.fechas_visitas = Array(v).fill('');
//     } else {
//       (t[field] as number) = Number(value);
//     }

//     t.total = t.cantidad * t.visitas * t.precio;
//     updated[index].almacen_trampa = t;
//     setData('almacenes', updated);
//   };

//   const updateArea = (
//     index: number,
//     field: keyof AlmacenArea,
//     value: number | string,
//   ) => {
//     const updated = [...data.almacenes];
//     const a = { ...updated[index].almacen_area };

//     if (field === 'visitas') {
//       const v = Number(value);
//       a.visitas = v;
//       a.fechas_visitas = Array(v).fill('');
//     } else {
//       (a[field] as number) = Number(value);
//     }

//     a.total = a.area * a.visitas * a.precio;
//     updated[index].almacen_area = a;
//     setData('almacenes', updated);
//   };

//   const updateInsectocutor = (
//     index: number,
//     field: keyof AlmacenInsectocutor,
//     value: number | string,
//   ) => {
//     const updated = [...data.almacenes];
//     const i = { ...updated[index].almacen_insectocutor };

//     (i[field] as number) = Number(value);
//     i.total = i.visitas * i.precio;

//     updated[index].almacen_insectocutor = i;
//     setData('almacenes', updated);
//   };

//   const addAlmacen = () => {
//     setData('almacenes', [
//       ...data.almacenes,
//       {
//         nombre: '',
//         direccion: '',
//         telefono: '',
//         email: '',
//         ciudad: '',
//         encargado: '',
//         almacen_trampa: {
//           cantidad: 0,
//           visitas: 1,
//           precio: 0,
//           total: 0,
//           fechas_visitas: [''],
//         },
//         almacen_area: {
//           area: 0,
//           visitas: 1,
//           precio: 0,
//           total: 0,
//           fechas_visitas: [''],
//         },
//         almacen_insectocutor: {
//           cantidad: 0,
//           visitas: 0,
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

//   /* ============================================================
//      Submit
//   ============================================================ */
//   const handleSubmit: FormEventHandler = (e) => {
//     e.preventDefault();

//     const payload = {
//       ...data,
//       total: granTotal,
//     };

//     contrato?.id
//       ? put(`/contratos/${contrato.id}`, payload)
//       : post('/contratos', payload);
//   };

//   /* ============================================================
//      Render
//   ============================================================ */
//   return (
//     <AppLayout breadcrumbs={breadcrumbs}>
//       <Head title={contrato ? 'Editar Contrato' : 'Nuevo Contrato'} />

//       <div className="mx-auto max-w-7xl py-6">
//         <Card>
//           <CardHeader>
//             <CardTitle>
//               {contrato ? 'Editar Contrato' : 'Nuevo Contrato'}
//             </CardTitle>
//             <CardDescription>
//               Complete los datos del cliente y los servicios
//             </CardDescription>
//           </CardHeader>

//           <CardContent>
//             <form onSubmit={handleSubmit} className="space-y-8">
//               <div className="grid gap-4 md:grid-cols-2">
//                 <div>
//                   <Label>Cliente</Label>
//                   <Input
//                     value={data.nombre}
//                     onChange={(e) => setData('nombre', e.target.value)}
//                   />
//                 </div>

//                 <div>
//                   <Label>Expiración</Label>
//                   <Input
//                     type="date"
//                     value={data.expiracion}
//                     onChange={(e) => setData('expiracion', e.target.value)}
//                   />
//                 </div>

//                 <div>
//                   <Label>Email</Label>
//                   <Input
//                     type="email"
//                     value={data.email}
//                     onChange={(e) => setData('email', e.target.value)}
//                   />
//                 </div>
//                 <div>
//                   <Label>Teléfono</Label>
//                   <Input
//                     value={data.telefono}
//                     onChange={(e) => setData('telefono', e.target.value)}
//                   />
//                 </div>
//                 <div>
//                   <Label>Ciudad</Label>
//                   <Input
//                     value={data.ciudad}
//                     onChange={(e) => setData('ciudad', e.target.value)}
//                   />
//                 </div>
//                 <div>
//                   <Label>Dirección</Label>
//                   <Input
//                     value={data.direccion}
//                     onChange={(e) => setData('direccion', e.target.value)}
//                   />
//                 </div>
//               </div>

//               <div className="flex justify-between">
//                 <h3 className="text-lg font-semibold">Almacenes</h3>
//                 <Button type="button" onClick={addAlmacen}>
//                   <Plus className="mr-2 h-4 w-4" /> Agregar
//                 </Button>
//               </div>

//               {data.almacenes.map((a, i) => (
//                 // <Card key={i} className="border">
//                 //   <CardHeader className="flex flex-row justify-between">
//                 //     <CardTitle>Almacén #{i + 1}</CardTitle>
//                 //     {data.almacenes.length > 1 && (
//                 //       <Button
//                 //         variant="ghost"
//                 //         size="icon"
//                 //         onClick={() => removeAlmacen(i)}
//                 //       >
//                 //         <Trash2 className="h-4 w-4 text-red-600" />
//                 //       </Button>
//                 //     )}
//                 //   </CardHeader>

//                 //   <CardContent className="space-y-4">
//                 //     <div className="grid gap-4 md:grid-cols-3">
//                 //       <Input
//                 //         placeholder="Nombre"
//                 //         value={a.nombre}
//                 //         onChange={(e) =>
//                 //           setData(
//                 //             `almacenes.${i}.nombre` as any,
//                 //             e.target.value,
//                 //           )
//                 //         }
//                 //       />
//                 //       <Input
//                 //         type="number"
//                 //         placeholder="Trampas"
//                 //         value={a.almacen_trampa.cantidad}
//                 //         onChange={(e) =>
//                 //           updateTrampa(i, 'cantidad', e.target.value)
//                 //         }
//                 //       />
//                 //       <Input
//                 //         type="number"
//                 //         placeholder="Área m²"
//                 //         value={a.almacen_area.area}
//                 //         onChange={(e) => updateArea(i, 'area', e.target.value)}
//                 //       />
//                 //     </div>

//                 //     <div className="text-right font-bold text-primary">
//                 //       Total almacén: Bs.{' '}
//                 //       {(
//                 //         a.almacen_trampa.total +
//                 //         a.almacen_area.total +
//                 //         a.almacen_insectocutor.total
//                 //       ).toFixed(2)}
//                 //     </div>
//                 //   </CardContent>
//                 // </Card>
//                 <Card key={i} className="border-2">
//                   <CardHeader>
//                     <div className="flex items-center justify-between">
//                       <CardTitle className="text-lg">
//                         Almacén #{i + 1}
//                       </CardTitle>
//                       {almacenes.length > 1 && (
//                         <Button
//                           type="button"
//                           variant="ghost"
//                           size="icon"
//                           onClick={() => removeAlmacen(i)}
//                           className="text-red-600"
//                         >
//                           <Trash2 className="h-4 w-4" />
//                         </Button>
//                       )}
//                     </div>
//                   </CardHeader>

//                   <CardContent className="space-y-4">
//                     <div className="grid grid-cols-1 gap-4 md:grid-cols-2">
//                       <div>
//                         <Label>Nombre del almacén</Label>
//                         <Input
//                           value={a.nombre}
//                           onChange={(e) =>
//                             setData(
//                               `almacenes.${i}.nombre` as any,
//                               e.target.value,
//                             )
//                           }
//                           placeholder="Ej. Almacén Central"
//                         />
//                       </div>
//                       <div>
//                         <Label>Email</Label>
//                         <Input
//                           type="email"
//                           value={a.email}
//                           onChange={(e) =>
//                             setData(
//                               `almacenes.${i}.email` as any,
//                               e.target.value,
//                             )
//                           }
//                           placeholder="Ej. almacen@empresa.com"
//                         />
//                       </div>
//                       <div>
//                         <Label>Direccion</Label>
//                         <Input
//                           value={a.direccion}
//                           onChange={(e) =>
//                             setData(
//                               `almacenes.${i}.direccion` as any,
//                               e.target.value,
//                             )
//                           }
//                           placeholder="Ej. Calle #111"
//                         />
//                       </div>
//                       <div>
//                         <Label>Ciudad</Label>
//                         <Input
//                           value={a.ciudad}
//                           onChange={(e) =>
//                             setData(
//                               `almacenes.${i}.ciudad` as any,
//                               e.target.value,
//                             )
//                           }
//                           placeholder="Ej. La Paz"
//                         />
//                       </div>

//                       <div>
//                         <Label>Encargado</Label>
//                         <Input
//                           value={a.encargado}
//                           onChange={(e) =>
//                             setData(
//                               `almacenes.${i}.encargado` as any,
//                               e.target.value,
//                             )
//                           }
//                           placeholder="Ej. Pablo Perez"
//                         />
//                       </div>
//                       <div>
//                         <Label>Telefono</Label>
//                         <Input
//                           value={a.telefono}
//                           onChange={(e) =>
//                             setData(
//                               `almacenes.${i}.telefono` as any,
//                               e.target.value,
//                             )
//                           }
//                           placeholder="Ej. 76543211"
//                         />
//                       </div>
//                     </div>

//                     {/* === SERVICIO POR TRAMPAS === */}
//                     <div className="rounded-lg border bg-amber-300/10 p-4">
//                       <h4 className="mb-4 font-semibold text-primary">
//                         Servicio por Trampas
//                       </h4>
//                       <div className="grid grid-cols-1 gap-4 md:grid-cols-4">
//                         <div>
//                           <Label>Cantidad</Label>
//                           <Input
//                             type="number"
//                             value={a.almacen_trampa.cantidad}
//                             onChange={(e) =>
//                               updateTrampa(i, 'cantidad', e.target.value)
//                             }
//                           />
//                         </div>
//                         <div>
//                           <Label>Visitas/año</Label>
//                           <Input
//                             type="number"
//                             min="1"
//                             value={a.almacen_trampa.visitas}
//                             onChange={(e) =>
//                               updateTrampa(i, 'visitas', e.target.value)
//                             }
//                           />
//                         </div>
//                         <div>
//                           <Label>Precio mensual</Label>
//                           <Input
//                             type="number"
//                             step="0.01"
//                             value={a.almacen_trampa.precio}
//                             onChange={(e) =>
//                               updateTrampa(i, 'precio', e.target.value)
//                             }
//                           />
//                         </div>
//                       </div>

//                       {/* Fechas de visitas para trampas */}
//                       {/* {a.almacen_trampa.visitas > 0 && (
//                         <div className="mt-6 space-y-3">
//                           <div className="flex items-center gap-2">
//                             <Calendar className="h-4 w-4 text-primary" />
//                             <Label className="text-sm font-semibold">
//                               Fechas programadas de visitas
//                             </Label>
//                           </div>
//                           <div className="grid grid-cols-2 gap-3 md:grid-cols-3 lg:grid-cols-4">
//                             {Array.from({
//                               length: a.almacen_trampa.visitas,
//                             }).map((_, visitaIndex) => (
//                               <div key={visitaIndex}>
//                                 <Label className="text-xs">
//                                   Visita {visitaIndex + 1}
//                                 </Label>
//                                 <Input
//                                   type="date"
//                                   value={
//                                     a.almacen_trampa.fechas_visitas?.[
//                                       visitaIndex
//                                     ] || ''
//                                   }
//                                   onChange={(e) =>
//                                     updateTrampaFechaVisita(
//                                       i,
//                                       visitaIndex,
//                                       e.target.value,
//                                     )
//                                   }
//                                   className="text-sm"
//                                 />
//                               </div>
//                             ))}
//                           </div>
//                         </div>
//                       )} */}

//                       <p className="mt-4 text-right text-lg font-bold">
//                         {/* Total anual: Bs. {a.almacen_trampa.total.toFixed(2)} */}
//                         Total anual: Bs.{' '}
//                         {Number(a.almacen_trampa.total).toFixed(2)}
//                       </p>
//                     </div>

//                     {/* === SERVICIO POR ÁREA === */}
//                     <div className="rounded-lg border bg-blue-500/10 p-4">
//                       <h4 className="mb-4 font-semibold text-primary">
//                         Servicio por Área (m²)
//                       </h4>
//                       <div className="grid grid-cols-1 gap-4 md:grid-cols-4">
//                         <div>
//                           <Label>Área (m²)</Label>
//                           <Input
//                             type="number"
//                             step="0.01"
//                             value={a.almacen_area.area}
//                             onChange={(e) =>
//                               updateArea(i, 'area', e.target.value)
//                             }
//                           />
//                         </div>
//                         <div>
//                           <Label>Visitas/año</Label>
//                           <Input
//                             type="number"
//                             min="1"
//                             value={a.almacen_area.visitas}
//                             onChange={(e) =>
//                               updateArea(i, 'visitas', e.target.value)
//                             }
//                           />
//                         </div>
//                         <div>
//                           <Label>Precio m²/mes</Label>
//                           <Input
//                             type="number"
//                             step="0.01"
//                             value={a.almacen_area.precio}
//                             onChange={(e) =>
//                               updateArea(i, 'precio', e.target.value)
//                             }
//                           />
//                         </div>
//                       </div>

//                       {/* Fechas de visitas para área */}
//                       {/* {a.almacen_area.visitas > 0 && (
//                         <div className="mt-6 space-y-3">
//                           <div className="flex items-center gap-2">
//                             <Calendar className="h-4 w-4 text-primary" />
//                             <Label className="text-sm font-semibold">
//                               Fechas programadas de visitas
//                             </Label>
//                           </div>
//                           <div className="grid grid-cols-2 gap-3 md:grid-cols-3 lg:grid-cols-4">
//                             {Array.from({
//                               length: a.almacen_area.visitas,
//                             }).map((_, visitaIndex) => (
//                               <div key={visitaIndex}>
//                                 <Label className="text-xs">
//                                   Visita {visitaIndex + 1}
//                                 </Label>
//                                 <Input
//                                   type="date"
//                                   value={
//                                     a.almacen_area.fechas_visitas?.[
//                                       visitaIndex
//                                     ] || ''
//                                   }
//                                   onChange={(e) =>
//                                     updateAreaFechaVisita(
//                                       i,
//                                       visitaIndex,
//                                       e.target.value,
//                                     )
//                                   }
//                                   className="text-sm"
//                                 />
//                               </div>
//                             ))}
//                           </div>
//                         </div>
//                       )} */}

//                       <p className="mt-4 text-right text-lg font-bold">
//                         {/* Total anual: Bs. {a.almacen_area.total.toFixed(2)} */}
//                         Total anual: Bs.{' '}
//                         {Number(a.almacen_area.total).toFixed(2)}
//                       </p>
//                     </div>

//                     {/* === SERVICIO POR INSECTOCUTOR === */}
//                     {/* <div className="rounded-lg border bg-muted/40 p-4"> */}
//                     <div className="rounded-lg border bg-red-700/10 p-4">
//                       <h4 className="mb-4 font-semibold text-primary">
//                         Servicio por Insectocutores
//                       </h4>
//                       <div className="grid grid-cols-1 gap-4 md:grid-cols-4">
//                         <div>
//                           <Label>Cantidad: </Label>
//                           <Input
//                             type="number"
//                             step="0.01"
//                             value={a.almacen_insectocutor.cantidad}
//                             onChange={(e) =>
//                               updateInsectocutor(i, 'cantidad', e.target.value)
//                             }
//                           />
//                         </div>
//                         <div>
//                           <Label>Visitas: </Label>
//                           <Input
//                             type="number"
//                             step="0.01"
//                             value={a.almacen_insectocutor.visitas}
//                             onChange={(e) =>
//                               updateInsectocutor(i, 'visitas', e.target.value)
//                             }
//                           />
//                         </div>

//                         <div>
//                           <Label>Precio: </Label>
//                           <Input
//                             type="number"
//                             step="0.01"
//                             value={a.almacen_insectocutor.precio}
//                             onChange={(e) =>
//                               updateInsectocutor(i, 'precio', e.target.value)
//                             }
//                           />
//                         </div>
//                       </div>

//                       <p className="mt-4 text-right text-lg font-bold">
//                         Total anual: Bs.{' '}
//                         {/* {a.almacen_insectocutor.total.toFixed(2)} */}
//                         {Number(a.almacen_insectocutor.total).toFixed(2)}
//                       </p>
//                     </div>

//                     <div className="flex justify-end">
//                       <div className="text-right">
//                         <p className="text-sm text-muted-foreground">
//                           Total este almacén
//                         </p>
//                         <p className="text-2xl font-bold text-primary">
//                           Bs.{' '}
//                           {/* {(
//                             a.almacen_trampa.total +
//                             a.almacen_area.total +
//                             a.almacen_insectocutor.total
//                           ).toFixed(2)} */}
//                           {Number(
//                             Number(a.almacen_trampa.total) +
//                               Number(a.almacen_area.total) +
//                               Number(a.almacen_insectocutor.total),
//                           ).toFixed(2)}
//                         </p>
//                       </div>
//                     </div>
//                   </CardContent>
//                 </Card>
//               ))}

//               <div className="text-right text-2xl font-bold text-primary">
//                 {/* TOTAL CONTRATO: Bs. {granTotal.toFixed(2)} */}
//                 TOTAL CONTRATO: Bs. {Number(granTotal).toFixed(2)}
//               </div>

//               <div className="flex justify-end gap-4">
//                 <Button
//                   type="button"
//                   variant="outline"
//                   onClick={() => router.visit('/contratos')}
//                 >
//                   Cancelar
//                 </Button>
//                 <Button type="submit" disabled={processing}>
//                   {processing ? 'Guardando...' : 'Guardar'}
//                 </Button>
//               </div>
//             </form>
//           </CardContent>
//         </Card>
//       </div>
//     </AppLayout>
//   );
// }

// // ---------------------------------------------------------------------
// // import { Button } from '@/components/ui/button';
// // import {
// //   Card,
// //   CardContent,
// //   CardDescription,
// //   CardHeader,
// //   CardTitle,
// // } from '@/components/ui/card';
// // import { Input } from '@/components/ui/input';
// // import { Label } from '@/components/ui/label';
// // import AppLayout from '@/layouts/app-layout';
// // import { type BreadcrumbItem } from '@/types';
// // import { Head, router, useForm } from '@inertiajs/react';
// // import { Calendar, Plus, Trash2 } from 'lucide-react';
// // import { FormEventHandler, useMemo } from 'react';

// // const breadcrumbs: BreadcrumbItem[] = [
// //   { title: 'Contratos', href: '/contratos' },
// //   { title: 'Editar Contrato', href: '/contratos/create' },
// // ];

// // interface Empresa {
// //   id: number;
// //   nombre: string;
// //   direccion: string;
// //   telefono: string;
// //   email: string;
// //   ciudad: string;
// // }

// // interface Contrato {
// //   id?: number;
// //   empresa: Empresa;
// //   expiracion: string;
// //   total: number;
// // }

// // interface Almacen {
// //   id?: number;
// //   nombre: string;
// //   direccion: string;
// //   telefono: string;
// //   email: string;
// //   ciudad: string;
// //   encargado: string;
// //   almacen_trampa: AlmacenTrampa;
// //   almacen_area: AlmacenArea;
// //   almacen_insectocutor: AlmancenInsectocutor;
// // }

// // interface AlmacenTrampa {
// //   // descripcion: string;
// //   cantidad: number;
// //   visitas: number;
// //   precio: number;
// //   total: number;
// //   fechas_visitas?: string[];
// // }

// // interface AlmacenArea {
// //   // descripcion: string;
// //   area: number;
// //   visitas: number;
// //   precio: number;
// //   total: number;
// //   fechas_visitas?: string[];
// // }

// // interface AlmancenInsectocutor {
// //   // descripcion: string;
// //   cantidad: number;
// //   precio: number;
// //   total: number;
// // }

// // interface Props {
// //   contrato: Contrato;
// //   almacenes: Almacen[];
// // }

// // export default function CotizacionForm({ contrato, almacenes }: Props) {
// //   console.log('-----------------');
// //   console.log(contrato);
// //   console.log('-----------------');
// //   console.log(almacenes);
// //   console.log('-----------------');

// //   const { data, setData, post, put, processing, errors } = useForm<
// //     [Contrato, Almacen[]]
// //   >({
// //     // expiracion: contrato?.fecha_fin_contrato ?? '',
// //     expiracion: contrato.expiracion ?? '',
// //     total: contrato?.total ?? 0,

// //     nombre: contrato?.empresa.nombre ?? '',
// //     direccion: contrato?.empresa.direccion ?? '',
// //     telefono: contrato?.empresa.telefono ?? '',
// //     email: contrato?.empresa.email ?? '',
// //     ciudad: contrato?.empresa.ciudad ?? '',

// //     almacenes_in:
// //       almacenes?.length > 0
// //         ? almacenes.map((a) => ({
// //             id: a.id,
// //             nombre: a.nombre ?? '',
// //             direccion: a.direccion ?? '',
// //             telefono: a.telefono ?? '',
// //             email: a.email ?? '',
// //             ciudad: a.ciudad ?? '',
// //             encargado: a.encargado ?? '',
// //             almacen_trampa: {
// //               // descripcion:
// //               //   a.almacen_trampa?.descripcion ??
// //               //   'Control de roedores con trampas',
// //               cantidad: a.almacen_trampa?.cantidad ?? 0,
// //               visitas: a.almacen_trampa?.visitas ?? 1,
// //               precio: a.almacen_trampa?.precio ?? 0,
// //               total: a.almacen_trampa?.total ?? 0,
// //               fechas_visitas:
// //                 a.almacen_trampa?.fechas_visitas ?? Array(1).fill(''),
// //             },
// //             almacen_area: {
// //               // descripcion: a.almacen_area?.descripcion ?? 'Fumigación general',
// //               area: a.almacen_area?.area ?? 0,
// //               visitas: a.almacen_area?.visitas ?? 1,
// //               precio: a.almacen_area?.precio ?? 0,
// //               total: a.almacen_area?.total ?? 0,
// //               fechas_visitas:
// //                 a.almacen_area?.fechas_visitas ?? Array(1).fill(''),
// //             },
// //             almacen_insectocutor: {
// //               // descripcion:
// //               //   a.almacen_insectocutor?.descripcion ?? 'Insectocutores',
// //               cantidad: a.almacen_insectocutor?.cantidad ?? 0,
// //               precio: a.almacen_insectocutor?.precio ?? 0,
// //               total: a.almacen_insectocutor?.total ?? 0,
// //             },
// //           }))
// //         : [
// //             {
// //               nombre: '',
// //               direccion: '',
// //               telefono: '',
// //               email: '',
// //               ciudad: '',
// //               encargado: '',
// //               // contacto_id: contactos[0]?.id ?? 0,
// //               almacen_trampa: {
// //                 // descripcion: 'Control de roedores con trampas',
// //                 cantidad: 0,
// //                 visitas: 1,
// //                 precio: 0,
// //                 total: 0,
// //                 fechas_visitas: Array(1).fill(''),
// //               },
// //               almacen_area: {
// //                 // descripcion: 'Fumigación general',
// //                 area: 0,
// //                 visitas: 1,
// //                 precio: 0,
// //                 total: 0,
// //                 fechas_visitas: Array(1).fill(''),
// //               },
// //               almacen_insectocutor: {
// //                 // descripcion: 'Insectocutores',
// //                 cantidad: 0,
// //                 precio: 0,
// //                 total: 0,
// //               },
// //             },
// //           ],
// //   });

// //   // === CÁLCULO AUTOMÁTICO DE TOTALES ===
// //   const calcularTotalTrampas = (
// //     cantidad: number,
// //     visitas: number,
// //     precio: number,
// //   ) => {
// //     return cantidad * visitas * precio;
// //   };

// //   const calcularTotalArea = (area: number, visitas: number, precio: number) => {
// //     return area * visitas * precio;
// //   };

// //   const calcularTotalInsectocutor = (cantidad: number, precio: number) => {
// //     return cantidad * precio;
// //   };

// //   // Actualizar totales cuando cambian los campos
// //   const updateTrampaField = (
// //     index: number,
// //     field: keyof AlmacenTrampa,
// //     value: number | string,
// //   ) => {
// //     const updated = [...almacenes];
// //     const trampa = { ...updated[index].almacen_trampa };

// //     // if (field === 'descripcion') {
// //     //   trampa.descripcion = value as string;
// //     // } else
// //     if (field === 'visitas') {
// //       const newVisitas = Number(value);
// //       trampa.visitas = newVisitas;
// //       // Ajustar el array de fechas según la cantidad de visitas
// //       const currentFechas = trampa.fechas_visitas || [];
// //       if (newVisitas > currentFechas.length) {
// //         trampa.fechas_visitas = [
// //           ...currentFechas,
// //           ...Array(newVisitas - currentFechas.length).fill(''),
// //         ];
// //       } else {
// //         trampa.fechas_visitas = currentFechas.slice(0, newVisitas);
// //       }
// //     } else if (field !== 'fechas_visitas') {
// //       (trampa[field] as number) = Number(value);
// //     }

// //     trampa.total = calcularTotalTrampas(
// //       trampa.cantidad,
// //       trampa.visitas,
// //       trampa.precio,
// //     );
// //     updated[index].almacen_trampa = trampa;

// //     setData('almacenes', updated);
// //   };

// //   const updateAreaField = (
// //     index: number,
// //     field: keyof AlmacenArea,
// //     value: number | string,
// //   ) => {
// //     const updated = [...almacenes];
// //     const area = { ...updated[index].almacen_area };

// //     // if (field === 'descripcion') {
// //     //   area.descripcion = value as string;
// //     // } else
// //     if (field === 'visitas') {
// //       const newVisitas = Number(value);
// //       area.visitas = newVisitas;
// //       // Ajustar el array de fechas según la cantidad de visitas
// //       const currentFechas = area.fechas_visitas || [];
// //       if (newVisitas > currentFechas.length) {
// //         area.fechas_visitas = [
// //           ...currentFechas,
// //           ...Array(newVisitas - currentFechas.length).fill(''),
// //         ];
// //       } else {
// //         area.fechas_visitas = currentFechas.slice(0, newVisitas);
// //       }
// //     } else if (field !== 'fechas_visitas') {
// //       (area[field] as number) = Number(value);
// //     }

// //     area.total = calcularTotalArea(area.area, area.visitas, area.precio);
// //     updated[index].almacen_area = area;

// //     setData('almacenes', updated);
// //   };

// //   const updateInsectocutorField = (
// //     index: number,
// //     field: keyof AlmancenInsectocutor,
// //     value: number | string,
// //   ) => {
// //     const updated = [...almacenes];
// //     const insectocutor = { ...updated[index].almacen_insectocutor };

// //     (insectocutor[field] as number) = Number(value);

// //     insectocutor.total = calcularTotalInsectocutor(
// //       insectocutor.cantidad,
// //       insectocutor.precio,
// //     );
// //     updated[index].almacen_insectocutor = insectocutor;

// //     setData('almacenes', updated);
// //   };

// //   const updateTrampaFechaVisita = (
// //     almacenIndex: number,
// //     visitaIndex: number,
// //     fecha: string,
// //   ) => {
// //     const updated = [...almacenes];
// //     const fechas = [
// //       ...(updated[almacenIndex].almacen_trampa.fechas_visitas || []),
// //     ];
// //     fechas[visitaIndex] = fecha;
// //     updated[almacenIndex].almacen_trampa.fechas_visitas = fechas;
// //     setData('almacenes', updated);
// //   };

// //   const updateAreaFechaVisita = (
// //     almacenIndex: number,
// //     visitaIndex: number,
// //     fecha: string,
// //   ) => {
// //     const updated = [...almacenes];
// //     const fechas = [
// //       ...(updated[almacenIndex].almacen_area.fechas_visitas || []),
// //     ];
// //     fechas[visitaIndex] = fecha;
// //     updated[almacenIndex].almacen_area.fechas_visitas = fechas;
// //     setData('almacenes', updated);
// //   };

// //   const totalAlmacenes = useMemo(() => {
// //     return almacenes.reduce((sum, a) => {
// //       return (
// //         sum +
// //         (a.almacen_trampa?.total ?? 0) +
// //         (a.almacen_area?.total ?? 0) +
// //         (a.almacen_insectocutor?.total ?? 0)
// //       );
// //     }, 0);
// //   }, [almacenes]);

// //   const granTotal = totalAlmacenes;
// //   // const saldoCalculado = granTotal - (data.acuenta ?? 0);

// //   const addAlmacen = () => {
// //     setData('almacenes', [
// //       ...almacenes,
// //       {
// //         nombre: '',
// //         direccion: '',
// //         telefono: '',
// //         email: '',
// //         ciudad: '',
// //         encargado: '',

// //         almacen_trampa: {
// //           cantidad: 0,
// //           visitas: 1,
// //           precio: 0,
// //           total: 0,
// //           fechas_visitas: Array(1).fill(''),
// //         },
// //         almacen_area: {
// //           area: 0,
// //           visitas: 1,
// //           precio: 0,
// //           total: 0,
// //           fechas_visitas: Array(1).fill(''),
// //         },
// //         almacen_insectocutor: {
// //           cantidad: 0,
// //           precio: 0,
// //           total: 0,
// //         },
// //       },
// //     ]);
// //   };

// //   const removeAlmacen = (index: number) => {
// //     if (almacenes.length > 1) {
// //       setData(
// //         'almacenes',
// //         almacenes.filter((_, i) => i !== index),
// //       );
// //     }
// //   };

// //   const handleSubmit: FormEventHandler = (e) => {
// //     e.preventDefault();
// //     const payload = {
// //       ...data,
// //       total: granTotal,
// //     };

// //     if (contrato?.id) {
// //       put(`/contratos/${contrato.id}`, payload as any);
// //     } else {
// //       post('/contratos', payload as any);
// //     }
// //   };

// //   return (
// //     <AppLayout breadcrumbs={breadcrumbs}>
// //       <Head title={contrato ? 'Editar Contrato' : 'Nuevo Contrato'} />

// //       <div className="py-5">
// //         <div className="mx-auto max-w-7xl sm:px-6 lg:px-8">
// //           <Card>
// //             <CardHeader>
// //               <CardTitle>
// //                 {contrato ? 'Editar Contrato' : 'Nuevo Contrato'}
// //               </CardTitle>
// //               <CardDescription>
// //                 Complete los datos del cliente y los servicios por almacén
// //               </CardDescription>
// //             </CardHeader>

// //             <CardContent>
// //               <form onSubmit={handleSubmit} className="space-y-10">
// //                 {/* === CLIENTE === */}
// //                 <div className="space-y-6">
// //                   <h3 className="text-lg font-semibold">
// //                     Información del Cliente
// //                   </h3>
// //                   <div className="grid grid-cols-1 gap-6 md:grid-cols-2">
// //                     <div>
// //                       <Label>Nombre del cliente</Label>
// //                       <Input
// //                         value={data.nombre}
// //                         onChange={(e) => setData('nombre', e.target.value)}
// //                       />
// //                     </div>
// //                     <div>
// //                       <Label>Fecha de finalización del contrato</Label>
// //                       <Input
// //                         type="date"
// //                         value={data.fecha_fin_contrato}
// //                         onChange={(e) =>
// //                           setData('fecha_fin_contrato', e.target.value)
// //                         }
// //                       />
// //                     </div>
// // <div>
// //   <Label>Email</Label>
// //   <Input
// //     type="email"
// //     value={data.email}
// //     onChange={(e) => setData('email', e.target.value)}
// //   />
// // </div>
// // <div>
// //   <Label>Teléfono</Label>
// //   <Input
// //     value={data.telefono}
// //     onChange={(e) => setData('telefono', e.target.value)}
// //   />
// // </div>
// // <div>
// //   <Label>Ciudad</Label>
// //   <Input
// //     value={data.ciudad}
// //     onChange={(e) => setData('ciudad', e.target.value)}
// //   />
// // </div>
// // <div>
// //   <Label>Dirección</Label>
// //   <Input
// //     value={data.direccion}
// //     onChange={(e) => setData('direccion', e.target.value)}
// //   />
// // </div>
// //                   </div>
// //                 </div>

// //                 {/* === ALMACENES === */}
// //                 <div className="space-y-6">
// //                   <div className="flex items-center justify-between">
// //                     <h3 className="text-lg font-semibold">Almacenes</h3>
// //                     <Button type="button" size="sm" onClick={addAlmacen}>
// //                       <Plus className="mr-2 h-4 w-4" /> Agregar Almacén
// //                     </Button>
// //                   </div>

// //                   {almacenes.map((almacen, index) => (
// //                     <Card key={index} className="border-2">
// //                       <CardHeader>
// //                         <div className="flex items-center justify-between">
// //                           <CardTitle className="text-lg">
// //                             Almacén #{index + 1} —{' '}
// //                             {almacen.nombre || 'Sin nombre'}
// //                           </CardTitle>
// //                           {almacenes.length > 1 && (
// //                             <Button
// //                               type="button"
// //                               variant="ghost"
// //                               size="icon"
// //                               onClick={() => removeAlmacen(index)}
// //                               className="text-red-600"
// //                             >
// //                               <Trash2 className="h-4 w-4" />
// //                             </Button>
// //                           )}
// //                         </div>
// //                       </CardHeader>

// //                       <CardContent className="space-y-4">
// //                         <div className="grid grid-cols-1 gap-4 md:grid-cols-2">
// //                           <div>
// //                             <Label>Nombre del almacén</Label>
// //                             <Input
// //                               value={almacen.nombre}
// //                               onChange={(e) =>
// //                                 setData(
// //                                   `almacenes.${index}.nombre` as any,
// //                                   e.target.value,
// //                                 )
// //                               }
// //                               placeholder="Ej. Almacén Central"
// //                             />
// //                           </div>
// //                           <div>
// //                             <Label>Email</Label>
// //                             <Input
// //                               type="email"
// //                               value={almacen.email}
// //                               onChange={(e) =>
// //                                 setData(
// //                                   `almacenes.${index}.email` as any,
// //                                   e.target.value,
// //                                 )
// //                               }
// //                               placeholder="Ej. almacen@empresa.com"
// //                             />
// //                           </div>
// //                           <div>
// //                             <Label>Direccion</Label>
// //                             <Input
// //                               value={almacen.direccion}
// //                               onChange={(e) =>
// //                                 setData(
// //                                   `almacenes.${index}.direccion` as any,
// //                                   e.target.value,
// //                                 )
// //                               }
// //                               placeholder="Ej. Calle #111"
// //                             />
// //                           </div>
// //                           <div>
// //                             <Label>Ciudad</Label>
// //                             <Input
// //                               value={almacen.ciudad}
// //                               onChange={(e) =>
// //                                 setData(
// //                                   `almacenes.${index}.ciudad` as any,
// //                                   e.target.value,
// //                                 )
// //                               }
// //                               placeholder="Ej. La Paz"
// //                             />
// //                           </div>

// //                           <div>
// //                             <Label>Encargado</Label>
// //                             <Input
// //                               value={almacen.encargado}
// //                               onChange={(e) =>
// //                                 setData(
// //                                   `almacenes.${index}.encargado` as any,
// //                                   e.target.value,
// //                                 )
// //                               }
// //                               placeholder="Ej. Pablo Perez"
// //                             />
// //                           </div>
// //                           <div>
// //                             <Label>Telefono</Label>
// //                             <Input
// //                               value={almacen.telefono}
// //                               onChange={(e) =>
// //                                 setData(
// //                                   `almacenes.${index}.telefono` as any,
// //                                   e.target.value,
// //                                 )
// //                               }
// //                               placeholder="Ej. 76543211"
// //                             />
// //                           </div>
// //                         </div>

// //                         {/* === SERVICIO POR TRAMPAS === */}
// //                         <div className="rounded-lg border bg-amber-300/10 p-4">
// //                           <h4 className="mb-4 font-semibold text-primary">
// //                             Servicio por Trampas
// //                           </h4>
// //                           <div className="grid grid-cols-1 gap-4 md:grid-cols-4">
// //                             <div>
// //                               <Label>Cantidad</Label>
// //                               <Input
// //                                 type="number"
// //                                 value={almacen.almacen_trampa.cantidad}
// //                                 onChange={(e) =>
// //                                   updateTrampaField(
// //                                     index,
// //                                     'cantidad',
// //                                     e.target.value,
// //                                   )
// //                                 }
// //                               />
// //                             </div>
// //                             <div>
// //                               <Label>Visitas/año</Label>
// //                               <Input
// //                                 type="number"
// //                                 min="1"
// //                                 value={almacen.almacen_trampa.visitas}
// //                                 onChange={(e) =>
// //                                   updateTrampaField(
// //                                     index,
// //                                     'visitas',
// //                                     e.target.value,
// //                                   )
// //                                 }
// //                               />
// //                             </div>
// //                             <div>
// //                               <Label>Precio mensual</Label>
// //                               <Input
// //                                 type="number"
// //                                 step="0.01"
// //                                 value={almacen.almacen_trampa.precio}
// //                                 onChange={(e) =>
// //                                   updateTrampaField(
// //                                     index,
// //                                     'precio',
// //                                     e.target.value,
// //                                   )
// //                                 }
// //                               />
// //                             </div>
// //                           </div>

// //                           {/* Fechas de visitas para trampas */}
// //                           {almacen.almacen_trampa.visitas > 0 && (
// //                             <div className="mt-6 space-y-3">
// //                               <div className="flex items-center gap-2">
// //                                 <Calendar className="h-4 w-4 text-primary" />
// //                                 <Label className="text-sm font-semibold">
// //                                   Fechas programadas de visitas
// //                                 </Label>
// //                               </div>
// //                               <div className="grid grid-cols-2 gap-3 md:grid-cols-3 lg:grid-cols-4">
// //                                 {Array.from({
// //                                   length: almacen.almacen_trampa.visitas,
// //                                 }).map((_, visitaIndex) => (
// //                                   <div key={visitaIndex}>
// //                                     <Label className="text-xs">
// //                                       Visita {visitaIndex + 1}
// //                                     </Label>
// //                                     <Input
// //                                       type="date"
// //                                       value={
// //                                         almacen.almacen_trampa.fechas_visitas?.[
// //                                           visitaIndex
// //                                         ] || ''
// //                                       }
// //                                       onChange={(e) =>
// //                                         updateTrampaFechaVisita(
// //                                           index,
// //                                           visitaIndex,
// //                                           e.target.value,
// //                                         )
// //                                       }
// //                                       className="text-sm"
// //                                     />
// //                                   </div>
// //                                 ))}
// //                               </div>
// //                             </div>
// //                           )}

// //                           <p className="mt-4 text-right text-lg font-bold">
// //                             Total anual: Bs.{' '}
// //                             {almacen.almacen_trampa.total.toFixed(2)}
// //                           </p>
// //                         </div>

// //                         {/* === SERVICIO POR ÁREA === */}
// //                         <div className="rounded-lg border bg-blue-500/10 p-4">
// //                           <h4 className="mb-4 font-semibold text-primary">
// //                             Servicio por Área (m²)
// //                           </h4>
// //                           <div className="grid grid-cols-1 gap-4 md:grid-cols-4">
// //                             <div>
// //                               <Label>Área (m²)</Label>
// //                               <Input
// //                                 type="number"
// //                                 step="0.01"
// //                                 value={almacen.almacen_area.area}
// //                                 onChange={(e) =>
// //                                   updateAreaField(index, 'area', e.target.value)
// //                                 }
// //                               />
// //                             </div>
// //                             <div>
// //                               <Label>Visitas/año</Label>
// //                               <Input
// //                                 type="number"
// //                                 min="1"
// //                                 value={almacen.almacen_area.visitas}
// //                                 onChange={(e) =>
// //                                   updateAreaField(
// //                                     index,
// //                                     'visitas',
// //                                     e.target.value,
// //                                   )
// //                                 }
// //                               />
// //                             </div>
// //                             <div>
// //                               <Label>Precio m²/mes</Label>
// //                               <Input
// //                                 type="number"
// //                                 step="0.01"
// //                                 value={almacen.almacen_area.precio}
// //                                 onChange={(e) =>
// //                                   updateAreaField(
// //                                     index,
// //                                     'precio',
// //                                     e.target.value,
// //                                   )
// //                                 }
// //                               />
// //                             </div>
// //                           </div>

// //                           {/* Fechas de visitas para área */}
// //                           {almacen.almacen_area.visitas > 0 && (
// //                             <div className="mt-6 space-y-3">
// //                               <div className="flex items-center gap-2">
// //                                 <Calendar className="h-4 w-4 text-primary" />
// //                                 <Label className="text-sm font-semibold">
// //                                   Fechas programadas de visitas
// //                                 </Label>
// //                               </div>
// //                               <div className="grid grid-cols-2 gap-3 md:grid-cols-3 lg:grid-cols-4">
// //                                 {Array.from({
// //                                   length: almacen.almacen_area.visitas,
// //                                 }).map((_, visitaIndex) => (
// //                                   <div key={visitaIndex}>
// //                                     <Label className="text-xs">
// //                                       Visita {visitaIndex + 1}
// //                                     </Label>
// //                                     <Input
// //                                       type="date"
// //                                       value={
// //                                         almacen.almacen_area.fechas_visitas?.[
// //                                           visitaIndex
// //                                         ] || ''
// //                                       }
// //                                       onChange={(e) =>
// //                                         updateAreaFechaVisita(
// //                                           index,
// //                                           visitaIndex,
// //                                           e.target.value,
// //                                         )
// //                                       }
// //                                       className="text-sm"
// //                                     />
// //                                   </div>
// //                                 ))}
// //                               </div>
// //                             </div>
// //                           )}

// //                           <p className="mt-4 text-right text-lg font-bold">
// //                             Total anual: Bs.{' '}
// //                             {almacen.almacen_area.total.toFixed(2)}
// //                           </p>
// //                         </div>

// //                         {/* === SERVICIO POR INSECTOCUTOR === */}
// //                         {/* <div className="rounded-lg border bg-muted/40 p-4"> */}
// //                         <div className="rounded-lg border bg-red-700/10 p-4">
// //                           <h4 className="mb-4 font-semibold text-primary">
// //                             Servicio por Insectocutores
// //                           </h4>
// //                           <div className="grid grid-cols-1 gap-4 md:grid-cols-4">
// //                             <div>
// //                               <Label>Cantidad: </Label>
// //                               <Input
// //                                 type="number"
// //                                 step="0.01"
// //                                 value={almacen.almacen_insectocutor.cantidad}
// //                                 onChange={(e) =>
// //                                   updateInsectocutorField(
// //                                     index,
// //                                     'cantidad',
// //                                     e.target.value,
// //                                   )
// //                                 }
// //                               />
// //                             </div>

// //                             <div>
// //                               <Label>Precio: </Label>
// //                               <Input
// //                                 type="number"
// //                                 step="0.01"
// //                                 value={almacen.almacen_insectocutor.precio}
// //                                 onChange={(e) =>
// //                                   updateInsectocutorField(
// //                                     index,
// //                                     'precio',
// //                                     e.target.value,
// //                                   )
// //                                 }
// //                               />
// //                             </div>
// //                           </div>

// //                           <p className="mt-4 text-right text-lg font-bold">
// //                             Total anual: Bs.{' '}
// //                             {almacen.almacen_insectocutor.total.toFixed(2)}
// //                           </p>
// //                         </div>

// //                         <div className="flex justify-end">
// //                           <div className="text-right">
// //                             <p className="text-sm text-muted-foreground">
// //                               Total este almacén
// //                             </p>
// //                             <p className="text-2xl font-bold text-primary">
// //                               Bs.{' '}
// //                               {(
// //                                 almacen.almacen_trampa.total +
// //                                 almacen.almacen_area.total +
// //                                 almacen.almacen_insectocutor.total
// //                               ).toFixed(2)}
// //                             </p>
// //                           </div>
// //                         </div>
// //                       </CardContent>
// //                     </Card>
// //                   ))}
// //                 </div>

// //                 {/* === RESUMEN FINAL === */}
// //                 <Card className="border-2 bg-primary/5">
// //                   <CardContent className="pt-8">
// //                     <div className="space-y-6 text-right">
// //                       <div className="text-2xl font-bold text-primary">
// //                         TOTAL DEL CONTRATO: Bs. {granTotal.toFixed(2)}
// //                       </div>
// //                     </div>
// //                   </CardContent>
// //                 </Card>

// //                 <div className="flex justify-end gap-4 pt-8">
// //                   <Button
// //                     type="button"
// //                     variant="outline"
// //                     onClick={() => router.visit('/contratos')}
// //                   >
// //                     Cancelar
// //                   </Button>
// //                   <Button type="submit" disabled={processing}>
// //                     {processing
// //                       ? 'Guardando...'
// //                       : contrato
// //                         ? 'Actualizar'
// //                         : 'Crear Contrato'}
// //                   </Button>
// //                 </div>
// //               </form>
// //             </CardContent>
// //           </Card>
// //         </div>
// //       </div>
// //     </AppLayout>
// //   );
// // }
