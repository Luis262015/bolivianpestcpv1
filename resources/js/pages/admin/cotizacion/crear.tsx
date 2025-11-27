// resources/js/Pages/Cotizaciones/Form.tsx
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
  { title: 'Cotizaciones', href: '/cotizaciones' },
];

interface CotizacionDetalle {
  descripcion: string;
  area: number;
  precio_unitario: number;
  total: number;
}

interface Cotizacion {
  id?: number;
  nombre: string;
  direccion: string;
  telefono: string;
  email: string;
  ciudad: string;
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
    detalles: cotizacion?.detalles?.map((d) => ({
      descripcion: d.descripcion || '',
      area: Number(d.area) || 0,
      precio_unitario: Number(d.precio_unitario) || 0,
      total: Number(d.total) || 0,
    })) || [{ descripcion: '', area: 0, precio_unitario: 0, total: 0 }],
  });

  const handleSubmit: FormEventHandler = (e) => {
    e.preventDefault();

    if (cotizacion?.id) {
      put(`/cotizaciones/${cotizacion.id}`);
    } else {
      post('/cotizaciones');
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

  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title={cotizacion ? 'Editar Cotización' : 'Crear Cotización'} />
      <>
        <Head title={cotizacion ? 'Editar Cotización' : 'Nueva Cotización'} />

        <div className="py-5">
          <div className="mx-auto max-w-7xl sm:px-6 lg:px-8">
            <Card>
              <CardHeader>
                <CardTitle>
                  {cotizacion ? 'Editar Cotización' : 'Nueva Cotización'}
                </CardTitle>
                <CardDescription>
                  Complete la información del cliente y los detalles de la
                  cotización
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

                      <div className="md:col-span-2">
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
                    </div>
                  </div>

                  {/* Detalles de la Cotización */}
                  <div className="space-y-4">
                    <div className="flex items-center justify-between">
                      <h3 className="text-lg font-semibold">
                        Detalles de la Cotización
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
                        <CardContent className="pt-6">
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

                            <div className="grid grid-cols-1 gap-4 md:grid-cols-3">
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
                                  className="bg-gray-50"
                                />
                              </div>
                            </div>
                          </div>
                        </CardContent>
                      </Card>
                    ))}

                    {/* Total General */}
                    <div className="flex justify-end">
                      <Card className="w-full md:w-96">
                        <CardContent className="pt-6">
                          <div className="flex items-center justify-between text-lg font-bold">
                            <span>Total General:</span>
                            <span className="text-2xl">
                              ${calcularGranTotal().toFixed(2)}
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

// -----------------------------------------------------------
// // resources/js/Pages/Cotizaciones/Crear.tsx
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
// import { FormEventHandler } from 'react';

// const breadcrumbs: BreadcrumbItem[] = [
//   { title: 'Cotizaciones', href: '/cotizaciones' },
// ];

// interface CotizacionDetalle {
//   descripcion: string;
//   area: number;
//   precio_unitario: number;
//   total: number;
// }

// interface Cotizacion {
//   id?: number;
//   nombre: string;
//   direccion: string;
//   telefono: string;
//   email: string;
//   ciudad: string;
//   detalles: CotizacionDetalle[];
// }

// interface Props {
//   cotizacion?: Cotizacion;
// }

// export default function Crear({ cotizacion }: Props) {
//   const { data, setData, post, put, processing, errors } = useForm<Cotizacion>({
//     nombre: cotizacion?.nombre || '',
//     direccion: cotizacion?.direccion || '',
//     telefono: cotizacion?.telefono || '',
//     email: cotizacion?.email || '',
//     ciudad: cotizacion?.ciudad || '',
//     detalles: cotizacion?.detalles || [
//       { descripcion: '', area: 0, precio_unitario: 0, total: 0 },
//     ],
//   });

//   const handleSubmit: FormEventHandler = (e) => {
//     e.preventDefault();

//     if (cotizacion?.id) {
//       put(`/cotizaciones/${cotizacion.id}`); // Usar ruta directa
//     } else {
//       post('/cotizaciones'); // Usar ruta directa
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
//     return data.detalles.reduce(
//       (sum, detalle) => sum + Number(detalle.total || 0),
//       0,
//     );
//   };

//   return (
//     <AppLayout breadcrumbs={breadcrumbs}>
//       <Head title={cotizacion ? 'Editar Cotización' : 'Crear Cotización'} />

//       <>
//         <Head title={cotizacion ? 'Editar Cotización' : 'Nueva Cotización'} />

//         <div className="py-12">
//           <div className="mx-auto max-w-7xl sm:px-6 lg:px-8">
//             <Card>
//               <CardHeader>
//                 <CardTitle>
//                   {cotizacion ? 'Editar Cotización' : 'Nueva Cotización'}
//                 </CardTitle>
//                 <CardDescription>
//                   Complete la información del cliente y los detalles de la
//                   cotización
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

//                       <div className="md:col-span-2">
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

//                   {/* Detalles de la Cotización */}
//                   <div className="space-y-4">
//                     <div className="flex items-center justify-between">
//                       <h3 className="text-lg font-semibold">
//                         Detalles de la Cotización
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
//                         <CardContent className="pt-6">
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

//                             <div>
//                               <Label htmlFor={`descripcion-${index}`}>
//                                 Descripción
//                               </Label>
//                               <Textarea
//                                 id={`descripcion-${index}`}
//                                 value={detalle.descripcion}
//                                 onChange={(e) =>
//                                   updateDetalle(
//                                     index,
//                                     'descripcion',
//                                     e.target.value,
//                                   )
//                                 }
//                                 rows={3}
//                                 className={
//                                   errors[`detalles.${index}.descripcion`]
//                                     ? 'border-red-500'
//                                     : ''
//                                 }
//                               />
//                               {errors[`detalles.${index}.descripcion`] && (
//                                 <p className="mt-1 text-sm text-red-500">
//                                   {errors[`detalles.${index}.descripcion`]}
//                                 </p>
//                               )}
//                             </div>

//                             <div className="grid grid-cols-1 gap-4 md:grid-cols-3">
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
//                                   value={detalle.total.toFixed(2)}
//                                   readOnly
//                                   className="bg-gray-50"
//                                 />
//                               </div>
//                             </div>
//                           </div>
//                         </CardContent>
//                       </Card>
//                     ))}

//                     {/* Total General */}
//                     <div className="flex justify-end">
//                       <Card className="w-full md:w-96">
//                         <CardContent className="pt-6">
//                           <div className="flex items-center justify-between text-lg font-bold">
//                             <span>Total General:</span>
//                             <span className="text-2xl">
//                               ${calcularGranTotal().toFixed(2)}
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
//                       onClick={() => router.visit('cotizaciones.index')}
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
// -----------------------------------------------------------------
// import { Button } from '@/components/ui/button';
// import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
// import {
//   Form,
//   FormControl,
//   FormField,
//   FormItem,
//   FormLabel,
//   FormMessage,
// } from '@/components/ui/form';
// import { Input } from '@/components/ui/input';
// import AppLayout from '@/layouts/app-layout';
// import { type BreadcrumbItem } from '@/types';
// import { Head, router } from '@inertiajs/react';
// import { Plus, Trash2 } from 'lucide-react';
// import { useEffect } from 'react';
// import { useFieldArray, useForm } from 'react-hook-form';

// const breadcrumbs: BreadcrumbItem[] = [
//   { title: 'Cotizaciones', href: '/cotizaciones' },
// ];

// // Formato chileno: 1234.56 → 1.234,56
// const formatCL = (value: number | string): string => {
//   if (value === '' || value === null || value === undefined) return '';
//   const num =
//     typeof value === 'string'
//       ? parseFloat(value.replace(/\./g, '').replace(',', '.')) || 0
//       : value;
//   return num.toLocaleString('es-CL', {
//     minimumFractionDigits: 2,
//     maximumFractionDigits: 2,
//   });
// };

// // Parsear formato chileno → número
// const parseCL = (value: string): number => {
//   if (!value) return 0;
//   return parseFloat(value.replace(/\./g, '').replace(',', '.')) || 0;
// };

// interface Props {
//   cotizacion?: {
//     id?: number;
//     nombre: string;
//     direccion: string;
//     telefono: string;
//     email: string;
//     ciudad: string;
//     detalles: {
//       id?: number;
//       descripcion: string;
//       area: number | string;
//       precio_unitario: number | string;
//       total: number | string;
//     }[];
//   };
// }

// export default function Crear({ cotizacion }: Props) {
//   const form = useForm<any>({
//     defaultValues: cotizacion || {
//       nombre: '',
//       direccion: '',
//       telefono: '',
//       email: '',
//       ciudad: '',
//       detalles: [
//         {
//           descripcion: '',
//           area: '0,00',
//           precio_unitario: '0,00',
//           total: '0,00',
//         },
//       ],
//     },
//   });

//   const { fields, append, remove } = useFieldArray({
//     control: form.control,
//     name: 'detalles',
//   });

//   useEffect(() => {
//     if (cotizacion) {
//       form.reset({
//         ...cotizacion,
//         detalles: cotizacion.detalles.map((d) => ({
//           ...d,
//           area: formatCL(d.area),
//           precio_unitario: formatCL(d.precio_unitario),
//           total: formatCL(d.total),
//         })),
//       });
//     }
//   }, [cotizacion]);

//   const calculateTotal = (index: number) => {
//     const areaStr = form.getValues(`detalles.${index}.area`) as string;
//     const precioStr = form.getValues(
//       `detalles.${index}.precio_unitario`,
//     ) as string;
//     const area = parseCL(areaStr);
//     const precio = parseCL(precioStr);
//     const total = area * precio;
//     form.setValue(`detalles.${index}.total`, formatCL(total));
//   };

//   const onSubmit = (data: any) => {
//     // Convertir a números antes de enviar
//     const cleaned = {
//       ...data,
//       detalles: data.detalles.map((d: any) => ({
//         ...d,
//         area: parseCL(d.area),
//         precio_unitario: parseCL(d.precio_unitario),
//         total: parseCL(d.total),
//       })),
//     };

//     if (cotizacion?.id) {
//       router.put(`/cotizaciones/${cotizacion.id}`, cleaned);
//     } else {
//       router.post('/cotizaciones', cleaned);
//     }
//   };

//   const addDetalle = () => {
//     append({
//       descripcion: '',
//       area: '0,00',
//       precio_unitario: '0,00',
//       total: '0,00',
//     });
//   };

//   return (
//     <AppLayout breadcrumbs={breadcrumbs}>
//       <Head title={cotizacion ? 'Editar Cotización' : 'Crear Cotización'} />
//       <Card className="mx-auto max-w-5xl">
//         <CardHeader>
//           <CardTitle>
//             {cotizacion ? 'Editar Cotización' : 'Crear Cotización'}
//           </CardTitle>
//         </CardHeader>
//         <CardContent>
//           <Form {...form}>
//             <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-8">
//               <div className="grid grid-cols-1 gap-6 md:grid-cols-2">
//                 {['nombre', 'direccion', 'telefono', 'email', 'ciudad'].map(
//                   (field) => (
//                     <FormField
//                       key={field}
//                       control={form.control}
//                       name={field}
//                       render={({ field: f }) => (
//                         <FormItem>
//                           <FormLabel>
//                             {field.charAt(0).toUpperCase() + field.slice(1)}
//                           </FormLabel>
//                           <FormControl>
//                             <Input
//                               {...f}
//                               type={field === 'email' ? 'email' : 'text'}
//                             />
//                           </FormControl>
//                           <FormMessage />
//                         </FormItem>
//                       )}
//                     />
//                   ),
//                 )}
//               </div>

//               <div className="space-y-6">
//                 <div className="flex items-center justify-between">
//                   <h3 className="text-lg font-semibold">
//                     Detalles de la Cotización
//                   </h3>
//                   <Button type="button" size="sm" onClick={addDetalle}>
//                     <Plus className="mr-2 h-4 w-4" /> Agregar ítem
//                   </Button>
//                 </div>

//                 {fields.map((field, index) => (
//                   <div
//                     key={field.id}
//                     className="grid grid-cols-12 items-end gap-4 border-b pb-6"
//                   >
//                     <div className="col-span-5">
//                       <FormField
//                         control={form.control}
//                         name={`detalles.${index}.descripcion`}
//                         render={({ field }) => (
//                           <FormItem>
//                             <FormLabel>Descripción</FormLabel>
//                             <FormControl>
//                               <Input
//                                 {...field}
//                                 placeholder="Ej: Pintura interior"
//                               />
//                             </FormControl>
//                             <FormMessage />
//                           </FormItem>
//                         )}
//                       />
//                     </div>

//                     <div className="col-span-2">
//                       <FormField
//                         control={form.control}
//                         name={`detalles.${index}.area`}
//                         render={({ field }) => (
//                           <FormItem>
//                             <FormLabel>Área (m²)</FormLabel>
//                             <FormControl>
//                               <Input
//                                 {...field}
//                                 value={formatCL(field.value)}
//                                 onChange={(e) => {
//                                   field.onChange(e.target.value);
//                                   calculateTotal(index);
//                                 }}
//                                 placeholder="0,00"
//                               />
//                             </FormControl>
//                             <FormMessage />
//                           </FormItem>
//                         )}
//                       />
//                     </div>

//                     <div className="col-span-2">
//                       <FormField
//                         control={form.control}
//                         name={`detalles.${index}.precio_unitario`}
//                         render={({ field }) => (
//                           <FormItem>
//                             <FormLabel>Precio Unit.</FormLabel>
//                             <FormControl>
//                               <Input
//                                 {...field}
//                                 value={formatCL(field.value)}
//                                 onChange={(e) => {
//                                   field.onChange(e.target.value);
//                                   calculateTotal(index);
//                                 }}
//                                 placeholder="0,00"
//                               />
//                             </FormControl>
//                             <FormMessage />
//                           </FormItem>
//                         )}
//                       />
//                     </div>

//                     <div className="col-span-2">
//                       <FormField
//                         control={form.control}
//                         name={`detalles.${index}.total`}
//                         render={({ field }) => (
//                           <FormItem>
//                             <FormLabel>Total</FormLabel>
//                             <FormControl>
//                               <Input
//                                 value={formatCL(field.value)}
//                                 readOnly
//                                 className="bg-muted"
//                               />
//                             </FormControl>
//                           </FormItem>
//                         )}
//                       />
//                     </div>

//                     <Button
//                       type="button"
//                       variant="destructive"
//                       size="icon"
//                       onClick={() => remove(index)}
//                       disabled={fields.length === 1}
//                     >
//                       <Trash2 className="h-4 w-4" />
//                     </Button>
//                   </div>
//                 ))}

//                 {/* Total General */}
//                 <div className="flex justify-end">
//                   <div className="space-y-2 border-t pt-4 text-right">
//                     <p className="text-lg font-medium">Total Cotización</p>
//                     <p className="text-3xl font-bold text-primary">
//                       {formatCL(
//                         form
//                           .watch('detalles')
//                           ?.reduce(
//                             (sum: number, d: any) => sum + parseCL(d.total),
//                             0,
//                           ) || 0,
//                       )}
//                     </p>
//                   </div>
//                 </div>
//               </div>

//               <div className="flex justify-end gap-4">
//                 <Button
//                   type="button"
//                   variant="outline"
//                   onClick={() => router.visit('/cotizaciones')}
//                 >
//                   Cancelar
//                 </Button>
//                 <Button type="submit" size="lg">
//                   {cotizacion ? 'Actualizar Cotización' : 'Crear Cotización'}
//                 </Button>
//               </div>
//             </form>
//           </Form>
//         </CardContent>
//       </Card>
//     </AppLayout>
//   );
// }

// -------------------------------------------------------------------
// import { Button } from '@/components/ui/button';
// import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
// import {
//   Form,
//   FormControl,
//   FormField,
//   FormItem,
//   FormLabel,
//   FormMessage,
// } from '@/components/ui/form';
// import { Input } from '@/components/ui/input';
// import AppLayout from '@/layouts/app-layout';
// import { type BreadcrumbItem } from '@/types';
// import { CotizacionForm, cotizacionSchema } from '@/types/cotizacion';
// import { zodResolver } from '@hookform/resolvers/zod';
// import { Head, router } from '@inertiajs/react';
// import { Trash2 } from 'lucide-react';
// import { useEffect } from 'react';
// import { useFieldArray, useForm } from 'react-hook-form';

// const breadcrumbs: BreadcrumbItem[] = [
//   {
//     title: 'Cotizaciones',
//     href: '/cotizaciones',
//   },
// ];

// interface Props {
//   cotizacion?: CotizacionForm;
// }

// export default function Crear({ cotizacion }: Props) {
//   const form = useForm<CotizacionForm>({
//     resolver: zodResolver(cotizacionSchema),
//     defaultValues: cotizacion || {
//       nombre: '',
//       direccion: '',
//       telefono: '',
//       email: '',
//       ciudad: '',
//       detalles: [{ descripcion: '', area: 0, precio_unitario: 0, total: 0 }],
//     },
//   });

//   const { fields, append, remove } = useFieldArray({
//     control: form.control,
//     name: 'detalles',
//   });

//   useEffect(() => {
//     if (cotizacion) {
//       form.reset(cotizacion);
//     }
//   }, [cotizacion]);

//   const onSubmit = (data: CotizacionForm) => {
//     if (cotizacion?.id) {
//       router.put(`/cotizaciones/${cotizacion.id}`, data);
//     } else {
//       router.post('/cotizaciones', data);
//     }
//   };

//   const addDetalle = () => {
//     append({ descripcion: '', area: 0, precio_unitario: 0, total: 0 });
//   };

//   const calculateTotal = (index: number) => {
//     const area = form.getValues(`detalles.${index}.area`);
//     const precio = form.getValues(`detalles.${index}.precio_unitario`);
//     form.setValue(`detalles.${index}.total`, area * precio);
//   };

//   return (
//     <AppLayout breadcrumbs={breadcrumbs}>
//       <Head title="Cotizaciones" />
//       <Card className="mx-auto max-w-4xl">
//         <CardHeader>
//           <CardTitle>
//             {cotizacion ? 'Editar Cotización' : 'Crear Cotización'}
//           </CardTitle>
//         </CardHeader>
//         <CardContent>
//           <Form {...form}>
//             <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-6">
//               {/* Campos principales */}
//               <FormField
//                 control={form.control}
//                 name="nombre"
//                 render={({ field }) => (
//                   <FormItem>
//                     <FormLabel>Nombre</FormLabel>
//                     <FormControl>
//                       <Input {...field} />
//                     </FormControl>
//                     <FormMessage />
//                   </FormItem>
//                 )}
//               />
//               <FormField
//                 control={form.control}
//                 name="direccion"
//                 render={({ field }) => (
//                   <FormItem>
//                     <FormLabel>Dirección</FormLabel>
//                     <FormControl>
//                       <Input {...field} />
//                     </FormControl>
//                     <FormMessage />
//                   </FormItem>
//                 )}
//               />
//               <FormField
//                 control={form.control}
//                 name="telefono"
//                 render={({ field }) => (
//                   <FormItem>
//                     <FormLabel>Teléfono</FormLabel>
//                     <FormControl>
//                       <Input {...field} />
//                     </FormControl>
//                     <FormMessage />
//                   </FormItem>
//                 )}
//               />
//               <FormField
//                 control={form.control}
//                 name="email"
//                 render={({ field }) => (
//                   <FormItem>
//                     <FormLabel>Email</FormLabel>
//                     <FormControl>
//                       <Input type="email" {...field} />
//                     </FormControl>
//                     <FormMessage />
//                   </FormItem>
//                 )}
//               />
//               <FormField
//                 control={form.control}
//                 name="ciudad"
//                 render={({ field }) => (
//                   <FormItem>
//                     <FormLabel>Ciudad</FormLabel>
//                     <FormControl>
//                       <Input {...field} />
//                     </FormControl>
//                     <FormMessage />
//                   </FormItem>
//                 )}
//               />

//               {/* Detalles dinámicos */}
//               <div className="space-y-4">
//                 <h3 className="text-lg font-semibold">Detalles</h3>
//                 {fields.map((field, index) => (
//                   <div
//                     key={field.id}
//                     className="grid grid-cols-5 items-end gap-4"
//                   >
//                     <FormField
//                       control={form.control}
//                       name={`detalles.${index}.descripcion`}
//                       render={({ field }) => (
//                         <FormItem>
//                           <FormLabel>Descripción</FormLabel>
//                           <FormControl>
//                             <Input {...field} />
//                           </FormControl>
//                           <FormMessage />
//                         </FormItem>
//                       )}
//                     />
//                     <FormField
//                       control={form.control}
//                       name={`detalles.${index}.area`}
//                       render={({ field }) => (
//                         <FormItem>
//                           <FormLabel>Área</FormLabel>
//                           <FormControl>
//                             <Input
//                               type="number"
//                               {...field}
//                               onChange={(e) => {
//                                 field.onChange(+e.target.value);

//                                 calculateTotal(index);
//                               }}
//                             />
//                           </FormControl>
//                           <FormMessage />
//                         </FormItem>
//                       )}
//                     />
//                     <FormField
//                       control={form.control}
//                       name={`detalles.${index}.precio_unitario`}
//                       render={({ field }) => (
//                         <FormItem>
//                           <FormLabel>Precio Unitario</FormLabel>
//                           <FormControl>
//                             <Input
//                               type="number"
//                               step="0.01"
//                               {...field}
//                               onChange={(e) => {
//                                 field.onChange(+e.target.value);

//                                 calculateTotal(index);
//                               }}
//                             />
//                           </FormControl>
//                           <FormMessage />
//                         </FormItem>
//                       )}
//                     />
//                     <FormField
//                       control={form.control}
//                       name={`detalles.${index}.total`}
//                       render={({ field }) => (
//                         <FormItem>
//                           <FormLabel>Total</FormLabel>
//                           <FormControl>
//                             <Input type="number" {...field} readOnly />
//                           </FormControl>
//                           <FormMessage />
//                         </FormItem>
//                       )}
//                     />
//                     <Button
//                       type="button"
//                       variant="destructive"
//                       onClick={() => remove(index)}
//                       disabled={fields.length === 1}
//                     >
//                       <Trash2 className="h-4 w-4" />
//                     </Button>
//                   </div>
//                 ))}
//                 <Button type="button" onClick={addDetalle}>
//                   Agregar Detalle
//                 </Button>
//               </div>

//               <Button type="submit">
//                 {cotizacion ? 'Actualizar' : 'Crear'}
//               </Button>
//             </form>
//           </Form>
//         </CardContent>
//       </Card>
//     </AppLayout>
//   );
// }
