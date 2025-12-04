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
import { Textarea } from '@/components/ui/textarea';
import AppLayout from '@/layouts/app-layout';
import { type BreadcrumbItem } from '@/types';
import { Head, router, useForm } from '@inertiajs/react';
import { Plus, Trash2 } from 'lucide-react';
import { FormEventHandler } from 'react';

const breadcrumbs: BreadcrumbItem[] = [
  { title: 'Contratos', href: '/contratos' },
];

interface CotizacionDetalle {
  descripcion: string;
  area: number;
  precio_unitario: number;
  total: number;
}

interface Almacen {
  id: number;
  nombre: string;
}

interface Cotizacion {
  id?: number;
  nombre: string;
  direccion: string;
  telefono: string;
  email: string;
  ciudad: string;
  almacen: string;
  total: number;
  acuenta: number;
  saldo: number;
  almacenes: Almacen[];
  detalles: CotizacionDetalle[];
}

interface Props {
  cotizacion?: Cotizacion;
}

export default function CotizacionForm({ cotizacion }: Props) {
  const { data, setData, post, put, processing, errors } = useForm<Cotizacion>({
    nombre: cotizacion?.nombre || '',
    direccion: cotizacion?.direccion || '',
    telefono: cotizacion?.telefono || '',
    email: cotizacion?.email || '',
    ciudad: cotizacion?.ciudad || '',
    almacen: cotizacion?.almacen || '',
    total: cotizacion?.total || 0,
    acuenta: cotizacion?.acuenta || 0,
    saldo: cotizacion?.saldo || 0,
    almacenes: cotizacion?.almacenes?.map((d) => ({
      id: d.id || 0,
      nombre: d.nombre || '',
    })) || [{ id: 0, nombre: '' }],
    detalles: cotizacion?.detalles?.map((d) => ({
      descripcion: d.descripcion || '',
      area: Number(d.area) || 0,
      precio_unitario: Number(d.precio_unitario) || 0,
      total: Number(d.total) || 0,
    })) || [{ descripcion: '', area: 0, precio_unitario: 0, total: 0 }],
  });

  // === FUNCIONES PARA ALMACENES ===
  const addAlmacen = () => {
    setData('almacenes', [...data.almacenes, { id: 0, nombre: '' }]);
  };

  const removeAlmacen = (index: number) => {
    if (data.almacenes.length > 1) {
      setData(
        'almacenes',
        data.almacenes.filter((_, i) => i !== index),
      );
    }
  };

  const updateAlmacen = (
    index: number,
    field: keyof Almacen,
    value: string | number,
  ) => {
    const nuevos = [...data.almacenes];
    nuevos[index] = { ...nuevos[index], [field]: value };
    setData('almacenes', nuevos);
  };
  // ------------------------------------

  const handleSubmit: FormEventHandler = (e) => {
    e.preventDefault();
    const payload = {
      ...data,
      total: totalGeneral,
      saldo: saldoCalculado,
    };

    if (cotizacion?.id) {
      put(`/contratos/${cotizacion.id}`, payload as any);
    } else {
      post('/contratos', payload as any);
    }
  };

  const addDetalle = () => {
    setData('detalles', [
      ...data.detalles,
      { descripcion: '', area: 0, precio_unitario: 0, total: 0 },
    ]);
  };

  const removeDetalle = (index: number) => {
    if (data.detalles.length > 1) {
      setData(
        'detalles',
        data.detalles.filter((_, i) => i !== index),
      );
    }
  };

  const updateDetalle = (
    index: number,
    field: keyof CotizacionDetalle,
    value: string | number,
  ) => {
    const newDetalles = [...data.detalles];
    newDetalles[index] = { ...newDetalles[index], [field]: value };

    // Calcular total automáticamente
    if (field === 'area' || field === 'precio_unitario') {
      const area = field === 'area' ? Number(value) : newDetalles[index].area;
      const precio =
        field === 'precio_unitario'
          ? Number(value)
          : newDetalles[index].precio_unitario;
      newDetalles[index].total = area * precio;
    }

    setData('detalles', newDetalles);
  };

  const calcularGranTotal = () => {
    return data.detalles.reduce((sum, detalle) => {
      return sum + Number(detalle.total || 0);
    }, 0);
  };

  // Este es el total que se guarda en la cotización
  const totalGeneral = calcularGranTotal();

  // Saldo automático
  const saldoCalculado = totalGeneral - (data.acuenta || 0);

  const handleAcuentaChange = (value: number) => {
    setData('acuenta', value);
    setData('saldo', totalGeneral - value);
  };

  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title={cotizacion ? 'Editar Contrato' : 'Crear Contrato'} />
      <>
        <Head title={cotizacion ? 'Editar Contrato' : 'Nuevo Contrato'} />

        <div className="py-5">
          <div className="mx-auto max-w-7xl sm:px-6 lg:px-8">
            <Card>
              <CardHeader>
                <CardTitle>
                  {cotizacion ? 'Editar Contrato' : 'Nueva Contrato'}
                </CardTitle>
                <CardDescription>
                  Complete la información del cliente y los detalles del
                  contrato
                </CardDescription>
              </CardHeader>

              <CardContent>
                <form onSubmit={handleSubmit} className="space-y-8">
                  {/* Información del Cliente */}
                  <div className="space-y-4">
                    <h3 className="text-lg font-semibold">
                      Información del Cliente
                    </h3>

                    <div className="grid grid-cols-1 gap-4 md:grid-cols-2">
                      <div>
                        <Label htmlFor="nombre">Nombre</Label>
                        <Input
                          id="nombre"
                          value={data.nombre}
                          onChange={(e) => setData('nombre', e.target.value)}
                          className={errors.nombre ? 'border-red-500' : ''}
                        />
                        {errors.nombre && (
                          <p className="mt-1 text-sm text-red-500">
                            {errors.nombre}
                          </p>
                        )}
                      </div>

                      <div>
                        <Label htmlFor="email">Email</Label>
                        <Input
                          id="email"
                          type="email"
                          value={data.email}
                          onChange={(e) => setData('email', e.target.value)}
                          className={errors.email ? 'border-red-500' : ''}
                        />
                        {errors.email && (
                          <p className="mt-1 text-sm text-red-500">
                            {errors.email}
                          </p>
                        )}
                      </div>

                      <div>
                        <Label htmlFor="telefono">Teléfono</Label>
                        <Input
                          id="telefono"
                          value={data.telefono}
                          onChange={(e) => setData('telefono', e.target.value)}
                          className={errors.telefono ? 'border-red-500' : ''}
                        />
                        {errors.telefono && (
                          <p className="mt-1 text-sm text-red-500">
                            {errors.telefono}
                          </p>
                        )}
                      </div>

                      <div>
                        <Label htmlFor="ciudad">Ciudad</Label>
                        <Input
                          id="ciudad"
                          value={data.ciudad}
                          onChange={(e) => setData('ciudad', e.target.value)}
                          className={errors.ciudad ? 'border-red-500' : ''}
                        />
                        {errors.ciudad && (
                          <p className="mt-1 text-sm text-red-500">
                            {errors.ciudad}
                          </p>
                        )}
                      </div>

                      {/* <div className="md:col-span-2"> */}
                      <div className="">
                        <Label htmlFor="direccion">Dirección</Label>
                        <Input
                          id="direccion"
                          value={data.direccion}
                          onChange={(e) => setData('direccion', e.target.value)}
                          className={errors.direccion ? 'border-red-500' : ''}
                        />
                        {errors.direccion && (
                          <p className="mt-1 text-sm text-red-500">
                            {errors.direccion}
                          </p>
                        )}
                      </div>
                      {/* <div>
                        <Label htmlFor="almacen">Almacen</Label>
                        <Input
                          id="almacen"
                          value={data.almacen}
                          onChange={(e) => setData('almacen', e.target.value)}
                          className={errors.almacen ? 'border-red-500' : ''}
                        />
                        {errors.almacen && (
                          <p className="mt-1 text-sm text-red-500">
                            {errors.almacen}
                          </p>
                        )}
                      </div> */}
                    </div>
                  </div>

                  {/* === ALMACENES MÚLTIPLES === */}
                  <div className="space-y-4">
                    <div className="flex items-center justify-between">
                      <h3 className="text-lg font-semibold">Almacenes</h3>
                      <Button
                        type="button"
                        variant="outline"
                        size="sm"
                        onClick={addAlmacen}
                      >
                        <Plus className="mr-2 h-4 w-4" />
                        Agregar Almacén
                      </Button>
                    </div>

                    {data.almacenes.map((almacen, index) => (
                      <div key={index} className="flex items-end gap-3">
                        <div className="flex-1">
                          <Label htmlFor={`almacen-${index}`}>
                            Almacén {index + 1}
                          </Label>
                          <Input
                            id={`almacen-${index}`}
                            value={almacen.nombre}
                            onChange={(e) =>
                              updateAlmacen(index, 'nombre', e.target.value)
                            }
                            placeholder="Ej: Almacén Central, Sucursal Norte..."
                            className={
                              errors[`almacenes.${index}`]
                                ? 'border-red-500'
                                : ''
                            }
                          />
                          {errors[`almacenes.${index}.nombre`] && (
                            <p className="mt-1 text-sm text-red-500">
                              {errors[`almacenes.${index}.nombre`]}
                            </p>
                          )}
                        </div>

                        {data.almacenes.length > 1 && (
                          <Button
                            type="button"
                            variant="ghost"
                            size="sm"
                            onClick={() => removeAlmacen(index)}
                            className="mb-1 text-red-600 hover:text-red-800"
                          >
                            <Trash2 className="h-4 w-4" />
                          </Button>
                        )}
                      </div>
                    ))}
                  </div>

                  {/* Detalles de la Cotización */}
                  <div className="space-y-4">
                    <div className="flex items-center justify-between">
                      <h3 className="text-lg font-semibold">
                        Detalles del contrato
                      </h3>
                      <Button
                        type="button"
                        variant="outline"
                        size="sm"
                        onClick={addDetalle}
                      >
                        <Plus className="mr-2 h-4 w-4" />
                        Agregar Detalle
                      </Button>
                    </div>

                    {data.detalles.map((detalle, index) => (
                      <Card key={index} className="border-2">
                        <CardContent className="">
                          <div className="space-y-4">
                            <div className="flex items-center justify-between">
                              <span className="text-sm font-medium">
                                Detalle #{index + 1}
                              </span>
                              {data.detalles.length > 1 && (
                                <Button
                                  type="button"
                                  variant="ghost"
                                  size="sm"
                                  onClick={() => removeDetalle(index)}
                                  className="text-red-500 hover:text-red-700"
                                >
                                  <Trash2 className="h-4 w-4" />
                                </Button>
                              )}
                            </div>

                            <div className="grid grid-cols-1 gap-4 md:grid-cols-4">
                              <div>
                                <Label htmlFor={`descripcion-${index}`}>
                                  Descripción
                                </Label>
                                <Textarea
                                  id={`descripcion-${index}`}
                                  value={detalle.descripcion}
                                  onChange={(e) =>
                                    updateDetalle(
                                      index,
                                      'descripcion',
                                      e.target.value,
                                    )
                                  }
                                  rows={3}
                                  className={
                                    errors[`detalles.${index}.descripcion`]
                                      ? 'border-red-500'
                                      : ''
                                  }
                                />
                                {errors[`detalles.${index}.descripcion`] && (
                                  <p className="mt-1 text-sm text-red-500">
                                    {errors[`detalles.${index}.descripcion`]}
                                  </p>
                                )}
                              </div>
                              <div>
                                <Label htmlFor={`area-${index}`}>
                                  Área (m²)
                                </Label>
                                <Input
                                  id={`area-${index}`}
                                  type="number"
                                  step="0.01"
                                  value={detalle.area}
                                  onChange={(e) =>
                                    updateDetalle(
                                      index,
                                      'area',
                                      parseFloat(e.target.value) || 0,
                                    )
                                  }
                                  className={
                                    errors[`detalles.${index}.area`]
                                      ? 'border-red-500'
                                      : ''
                                  }
                                />
                                {errors[`detalles.${index}.area`] && (
                                  <p className="mt-1 text-sm text-red-500">
                                    {errors[`detalles.${index}.area`]}
                                  </p>
                                )}
                              </div>

                              <div>
                                <Label htmlFor={`precio-${index}`}>
                                  Precio Unitario
                                </Label>
                                <Input
                                  id={`precio-${index}`}
                                  type="number"
                                  step="0.01"
                                  value={detalle.precio_unitario}
                                  onChange={(e) =>
                                    updateDetalle(
                                      index,
                                      'precio_unitario',
                                      parseFloat(e.target.value) || 0,
                                    )
                                  }
                                  className={
                                    errors[`detalles.${index}.precio_unitario`]
                                      ? 'border-red-500'
                                      : ''
                                  }
                                />
                                {errors[
                                  `detalles.${index}.precio_unitario`
                                ] && (
                                  <p className="mt-1 text-sm text-red-500">
                                    {
                                      errors[
                                        `detalles.${index}.precio_unitario`
                                      ]
                                    }
                                  </p>
                                )}
                              </div>

                              <div>
                                <Label htmlFor={`total-${index}`}>Total</Label>
                                <Input
                                  id={`total-${index}`}
                                  type="number"
                                  step="0.01"
                                  value={Number(detalle.total || 0).toFixed(2)}
                                  readOnly
                                  // className="bg-gray-50"
                                />
                              </div>
                            </div>
                          </div>
                        </CardContent>
                      </Card>
                    ))}

                    {/* Total General */}
                    <div className="flex justify-end">
                      <Card className="w-full">
                        <CardContent className="pt-6">
                          <div className="flex items-center justify-between text-lg font-bold">
                            <span>Total General:</span>
                            <span className="text-2xl">
                              Bs. {calcularGranTotal().toFixed(2)}
                            </span>
                            <span>A Cuenta</span>
                            <span>
                              <Input
                                id="acuenta"
                                type="number"
                                step="0.01"
                                min="0"
                                value={data.acuenta || ''}
                                onChange={(e) =>
                                  handleAcuentaChange(
                                    parseFloat(e.target.value) || 0,
                                  )
                                }
                                className="w-48"
                              />
                            </span>
                            <span>Saldo:</span>
                            <span
                              className={
                                saldoCalculado < 0
                                  ? 'text-red-600'
                                  : 'text-green-600'
                              }
                            >
                              ${saldoCalculado.toFixed(2)}
                            </span>
                          </div>
                        </CardContent>
                      </Card>
                    </div>
                  </div>

                  {/* Botones de Acción */}
                  <div className="flex justify-end gap-4">
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
                          : 'Guardar'}
                    </Button>
                  </div>
                </form>
              </CardContent>
            </Card>
          </div>
        </div>
      </>
    </AppLayout>
  );
}
