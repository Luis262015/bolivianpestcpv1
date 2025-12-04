import { Button } from '@/components/ui/button';
import { Checkbox } from '@/components/ui/checkbox';
import {
  Dialog,
  DialogContent,
  DialogFooter,
  DialogHeader,
  DialogTitle,
} from '@/components/ui/dialog';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select';
import { Textarea } from '@/components/ui/textarea';
import { useForm } from '@inertiajs/react';
import { Plus, Trash2 } from 'lucide-react';
import React, { useState } from 'react';

interface Empresa {
  id: number;
  nombre: string;
}
interface Almacen {
  id: number;
  nombre: string;
}
interface Biologico {
  id: number;
  nombre: string;
}
interface Metodo {
  id: number;
  nombre: string;
}
interface EPP {
  id: number;
  nombre: string;
}
interface Proteccion {
  id: number;
  nombre: string;
}
interface Signo {
  id: number;
  nombre: string;
}
interface ProductoUsado {
  producto: string;
  cantidad: string;
}

interface ModalSeguimientoProps {
  open: boolean;
  onClose: () => void;
  empresas: Empresa[];
  almacenes: Almacen[];
  biologicos: Biologico[];
  metodos: Metodo[];
  epps: EPP[];
  protecciones: Proteccion[];
  signos: Signo[];
}

export default function ModalSeguimiento({
  open,
  onClose,
  empresas,
  almacenes,
  biologicos,
  metodos,
  epps,
  protecciones,
  signos,
}: ModalSeguimientoProps) {
  const [step, setStep] = useState(1);

  // Estados locales
  const [biologicosSel, setBiologicosSel] = useState<number[]>([]);
  const [metodosSel, setMetodosSel] = useState<number[]>([]);
  const [eppsSel, setEppsSel] = useState<number[]>([]);
  const [proteccionesSel, setProteccionesSel] = useState<number[]>([]);
  const [signosSel, setSignosSel] = useState<number[]>([]);

  const [labores, setLabores] = useState<string[]>(Array(11).fill(''));
  const [productos, setProductos] = useState<ProductoUsado[]>([
    { producto: '', cantidad: '' },
  ]);

  const { data, setData, post, processing, errors, reset } = useForm({
    empresa_id: '',
    almacen_id: '',
    labores: Array(11).fill(''),
    biologicos_ids: [] as number[],
    metodos_ids: [] as number[],
    epps_ids: [] as number[],
    protecciones_ids: [] as number[],
    signos_ids: [] as number[],
    productos_usados: [{ producto: '', cantidad: '' }],
    observaciones_especificas: '',
    encargado_nombre: '',
    encargado_cargo: '',
    firma_encargado: '',
    firma_supervisor: '',
    observaciones_generales: '',
  });

  const toggle = (
    arr: number[],
    setArr: React.Dispatch<React.SetStateAction<number[]>>,
    id: number,
  ) => {
    setArr((prev) =>
      prev.includes(id) ? prev.filter((x) => x !== id) : [...prev, id],
    );
  };

  const handleNext = () => {
    if (step === 1 && (!data.empresa_id || !data.almacen_id)) return;
    if (step === 2) setData('labores', labores);
    if (step === 3) setData('biologicos_ids', biologicosSel);
    if (step === 4) setData('metodos_ids', metodosSel);
    if (step === 5) setData('epps_ids', eppsSel);
    if (step === 6) setData('protecciones_ids', proteccionesSel);
    if (step === 7) setData('signos_ids', signosSel);
    if (step === 8) setData('productos_usados', productos);
    if (step === 9)
      setData('observaciones_especificas', data.observaciones_especificas);

    setStep((s) => Math.min(s + 1, 11));
  };

  const handleBack = () => setStep((s) => Math.max(s - 1, 1));

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    setData({
      ...data,
      biologicos_ids: biologicosSel,
      metodos_ids: metodosSel,
      epps_ids: eppsSel,
      protecciones_ids: proteccionesSel,
      signos_ids: signosSel,
      productos_usados: productos,
    });
    post('/seguimientos', { onSuccess: handleClose });
  };

  const handleClose = () => {
    // reset();
    setStep(1);
    setBiologicosSel([]);
    setMetodosSel([]);
    setEppsSel([]);
    setProteccionesSel([]);
    setSignosSel([]);
    setLabores(Array(11).fill(''));
    setProductos([{ producto: '', cantidad: '' }]);
    onClose();
  };

  // Helpers productos
  const addProducto = () =>
    setProductos([...productos, { producto: '', cantidad: '' }]);
  const removeProducto = (i: number) =>
    setProductos(productos.filter((_, idx) => idx !== i));
  const updateProducto = (
    i: number,
    field: 'producto' | 'cantidad',
    value: string,
  ) => {
    const updated = [...productos];
    updated[i][field] = value;
    setProductos(updated);
    setData('productos_usados', updated);
  };

  return (
    <Dialog open={open} onOpenChange={handleClose}>
      <DialogContent className="max-h-[90vh] overflow-y-auto sm:max-w-[800px]">
        <DialogHeader>
          <DialogTitle>Nuevo Seguimiento - Paso {step} de 11</DialogTitle>
          <div className="mt-3 h-2 w-full rounded-full bg-muted">
            <div
              className="h-2 rounded-full bg-primary transition-all"
              style={{ width: `${(step / 11) * 100}%` }}
            />
          </div>
        </DialogHeader>

        <form onSubmit={handleSubmit}>
          {/* PASO 1: Empresa y Almacén */}
          {step === 1 && (
            <div className="space-y-6 py-6">
              <div className="grid grid-cols-1 gap-5 md:grid-cols-2">
                <div className="space-y-2">
                  <Label>Empresa *</Label>
                  <Select
                    value={data.empresa_id}
                    onValueChange={(v) => setData('empresa_id', v)}
                  >
                    <SelectTrigger>
                      <SelectValue placeholder="Seleccionar empresa" />
                    </SelectTrigger>
                    <SelectContent>
                      {empresas.map((e) => (
                        <SelectItem key={e.id} value={e.id.toString()}>
                          {e.nombre}
                        </SelectItem>
                      ))}
                    </SelectContent>
                  </Select>
                  {errors.empresa_id && (
                    <p className="text-sm text-red-500">{errors.empresa_id}</p>
                  )}
                </div>
                <div className="space-y-2">
                  <Label>Almacén *</Label>
                  <Select
                    value={data.almacen_id}
                    onValueChange={(v) => setData('almacen_id', v)}
                  >
                    <SelectTrigger>
                      <SelectValue placeholder="Seleccionar almacén" />
                    </SelectTrigger>
                    <SelectContent>
                      {almacenes.map((a) => (
                        <SelectItem key={a.id} value={a.id.toString()}>
                          {a.nombre}
                        </SelectItem>
                      ))}
                    </SelectContent>
                  </Select>
                  {errors.almacen_id && (
                    <p className="text-sm text-red-500">{errors.almacen_id}</p>
                  )}
                </div>
              </div>
            </div>
          )}

          {/* PASO 2: 11 Labores */}
          {step === 2 && (
            <div className="space-y-5 py-6">
              <Label className="text-lg font-semibold">
                Labores Realizadas (11 campos)
              </Label>
              <div className="grid grid-cols-1 gap-4 sm:grid-cols-2">
                {labores.map((labor, i) => (
                  <Input
                    key={i}
                    placeholder={`Labor ${i + 1}`}
                    value={labor}
                    onChange={(e) => {
                      const updated = [...labores];
                      updated[i] = e.target.value;
                      setLabores(updated);
                    }}
                  />
                ))}
              </div>
            </div>
          )}

          {/* PASO 3: Biológicos */}
          {step === 3 && (
            <div className="space-y-5 py-6">
              <Label className="text-lg font-semibold">
                Biológicos Utilizados
              </Label>
              <div className="grid max-h-96 grid-cols-1 gap-3 overflow-y-auto md:grid-cols-2">
                {biologicos.map((b) => (
                  <label
                    key={b.id}
                    className="flex cursor-pointer items-center space-x-3 rounded-lg border p-4 hover:bg-accent has-[:checked]:bg-primary/10"
                  >
                    <Checkbox
                      checked={biologicosSel.includes(b.id)}
                      onCheckedChange={() =>
                        toggle(biologicosSel, setBiologicosSel, b.id)
                      }
                    />
                    <span>{b.nombre}</span>
                  </label>
                ))}
              </div>
            </div>
          )}

          {/* PASO 4: Métodos */}
          {step === 4 && (
            <div className="space-y-5 py-6">
              <Label className="text-lg font-semibold">
                Métodos de Aplicación
              </Label>
              <div className="grid max-h-96 grid-cols-1 gap-3 overflow-y-auto md:grid-cols-2">
                {metodos.map((m) => (
                  <label
                    key={m.id}
                    className="flex cursor-pointer items-center space-x-3 rounded-lg border p-4 hover:bg-accent has-[:checked]:bg-primary/10"
                  >
                    <Checkbox
                      checked={metodosSel.includes(m.id)}
                      onCheckedChange={() =>
                        toggle(metodosSel, setMetodosSel, m.id)
                      }
                    />
                    <span>{m.nombre}</span>
                  </label>
                ))}
              </div>
            </div>
          )}

          {/* PASO 5: EPP */}
          {step === 5 && (
            <div className="space-y-5 py-6">
              <Label className="text-lg font-semibold">
                Equipos de Protección Personal (EPP)
              </Label>
              <div className="grid max-h-96 grid-cols-1 gap-3 overflow-y-auto md:grid-cols-2">
                {epps.map((e) => (
                  <label
                    key={e.id}
                    className="flex cursor-pointer items-center space-x-3 rounded-lg border p-4 hover:bg-accent has-[:checked]:bg-primary/10"
                  >
                    <Checkbox
                      checked={eppsSel.includes(e.id)}
                      onCheckedChange={() => toggle(eppsSel, setEppsSel, e.id)}
                    />
                    <span>{e.nombre}</span>
                  </label>
                ))}
              </div>
            </div>
          )}

          {/* PASO 6: Métodos de Protección */}
          {step === 6 && (
            <div className="space-y-5 py-6">
              <Label className="text-lg font-semibold">
                Métodos de Protección Adicional
              </Label>
              <div className="grid max-h-96 grid-cols-1 gap-3 overflow-y-auto md:grid-cols-2">
                {protecciones.map((p) => (
                  <label
                    key={p.id}
                    className="flex cursor-pointer items-center space-x-3 rounded-lg border p-4 hover:bg-accent has-[:checked]:bg-primary/10"
                  >
                    <Checkbox
                      checked={proteccionesSel.includes(p.id)}
                      onCheckedChange={() =>
                        toggle(proteccionesSel, setProteccionesSel, p.id)
                      }
                    />
                    <span>{p.nombre}</span>
                  </label>
                ))}
              </div>
            </div>
          )}

          {/* PASO 7: Signos / Síntomas */}
          {step === 7 && (
            <div className="space-y-5 py-6">
              <Label className="text-lg font-semibold">
                Signos o Síntomas Observados
              </Label>
              <div className="grid max-h-96 grid-cols-1 gap-3 overflow-y-auto md:grid-cols-2">
                {signos.map((s) => (
                  <label
                    key={s.id}
                    className="flex cursor-pointer items-center space-x-3 rounded-lg border p-4 hover:bg-accent has-[:checked]:bg-primary/10"
                  >
                    <Checkbox
                      checked={signosSel.includes(s.id)}
                      onCheckedChange={() =>
                        toggle(signosSel, setSignosSel, s.id)
                      }
                    />
                    <span>{s.nombre}</span>
                  </label>
                ))}
              </div>
            </div>
          )}

          {/* PASO 8: Productos y Cantidades */}
          {step === 8 && (
            <div className="space-y-5 py-6">
              <div className="flex items-center justify-between">
                <Label className="text-lg font-semibold">
                  Productos Utilizados
                </Label>
                <Button type="button" size="sm" onClick={addProducto}>
                  <Plus className="mr-2 h-4 w-4" /> Agregar
                </Button>
              </div>
              <div className="space-y-4">
                {productos.map((p, i) => (
                  <div key={i} className="flex gap-3">
                    <Input
                      placeholder="Nombre del producto"
                      value={p.producto}
                      onChange={(e) =>
                        updateProducto(i, 'producto', e.target.value)
                      }
                      className="flex-1"
                    />
                    <Input
                      placeholder="Cantidad (ej: 500ml)"
                      value={p.cantidad}
                      onChange={(e) =>
                        updateProducto(i, 'cantidad', e.target.value)
                      }
                    />
                    {productos.length > 1 && (
                      <Button
                        type="button"
                        variant="ghost"
                        size="icon"
                        onClick={() => removeProducto(i)}
                      >
                        <Trash2 className="h-4 w-4 text-red-500" />
                      </Button>
                    )}
                  </div>
                ))}
              </div>
            </div>
          )}

          {/* PASO 9: Observaciones Específicas */}
          {step === 9 && (
            <div className="space-y-5 py-6">
              <Label className="text-lg font-semibold">
                Observaciones Específicas
              </Label>
              <Textarea
                rows={8}
                placeholder="Detalles adicionales del seguimiento..."
                value={data.observaciones_especificas}
                // onChange={(e) =>
                //   setData('observaciones_especificas', e.target.value)
                // }
              />
            </div>
          )}

          {/* PASO 10: Datos del Encargado y Firmas */}
          {step === 10 && (
            <div className="space-y-6 py-6">
              <Label className="text-lg font-semibold">
                Responsable y Firmas
              </Label>
              <div className="grid grid-cols-1 gap-5 sm:grid-cols-2">
                <div className="space-y-2">
                  <Label>Nombre del Encargado</Label>
                  <Input
                    value={data.encargado_nombre}
                    // onChange={(e) =>
                    //   setData('encargado_nombre', e.target.value)
                    // }
                  />
                </div>
                <div className="space-y-2">
                  <Label>Cargo</Label>
                  <Input
                    value={data.encargado_cargo}
                    // onChange={(e) => setData('encargado_cargo', e.target.value)}
                  />
                </div>
              </div>
              <div className="grid grid-cols-1 gap-5 sm:grid-cols-2">
                <div className="space-y-2">
                  <Label>Firma Encargado (texto o dibujar después)</Label>
                  <Input placeholder="Escriba su nombre completo como firma" />
                </div>
                <div className="space-y-2">
                  <Label>Firma Supervisor</Label>
                  <Input placeholder="Escriba su nombre completo como firma" />
                </div>
              </div>
            </div>
          )}

          {/* PASO 11: Observaciones Generales + Final */}
          {step === 11 && (
            <div className="space-y-6 py-6 text-center">
              <div className="mx-auto mb-4 size-20 rounded-full bg-green-100 p-5">
                <svg
                  className="size-full text-green-600"
                  fill="none"
                  stroke="currentColor"
                  viewBox="0 0 24 24"
                >
                  <path
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeWidth={2}
                    d="M5 13l4 4L19 7"
                  />
                </svg>
              </div>
              <h3 className="text-2xl font-bold">¡Todo listo!</h3>
              <p className="text-muted-foreground">
                Revisa y guarda el seguimiento.
              </p>
              <Textarea
                rows={5}
                placeholder="Observaciones generales finales (opcional)"
                value={data.observaciones_generales}
                // onChange={(e) =>
                //   setData('observaciones_generales', e.target.value)
                // }
              />
            </div>
          )}

          {/* Footer */}
          <DialogFooter className="mt-8 flex flex-wrap justify-between gap-3">
            {step > 1 && (
              <Button type="button" variant="outline" onClick={handleBack}>
                Atrás
              </Button>
            )}
            <Button type="button" variant="outline" onClick={handleClose}>
              Cancelar
            </Button>

            {step < 11 ? (
              <Button type="button" onClick={handleNext}>
                Siguiente
              </Button>
            ) : (
              <Button type="submit" disabled={processing}>
                {processing ? 'Guardando...' : 'Guardar Seguimiento'}
              </Button>
            )}
          </DialogFooter>
        </form>
      </DialogContent>
    </Dialog>
  );
}
// ------------------------------------------------------------------------------------------
// import { Button } from '@/components/ui/button';
// import { Checkbox } from '@/components/ui/checkbox'; // ← NUEVO
// import {
//   Dialog,
//   DialogContent,
//   DialogFooter,
//   DialogHeader,
//   DialogTitle,
// } from '@/components/ui/dialog';
// import { Input } from '@/components/ui/input';
// import { Label } from '@/components/ui/label';
// import {
//   Select,
//   SelectContent,
//   SelectItem,
//   SelectTrigger,
//   SelectValue,
// } from '@/components/ui/select';
// import { Textarea } from '@/components/ui/textarea';
// import { useForm } from '@inertiajs/react';
// import { Plus, Trash2 } from 'lucide-react';
// import React, { useState } from 'react';

// interface Empresa {
//   id: number;
//   nombre: string;
// }

// interface Almacen {
//   id: number;
//   nombre: string;
// }

// interface BiologicoDB {
//   id: number;
//   nombre: string;
// }

// interface EPP {
//   nombre: string;
// }

// interface ModalSeguimientoProps {
//   open: boolean;
//   onClose: () => void;
//   empresas: Empresa[];
//   almacenes: Almacen[];
//   biologicos: BiologicoDB[]; // ← Lista completa desde la DB
// }

// export default function ModalSeguimiento({
//   open,
//   onClose,
//   empresas,
//   almacenes,
//   biologicos, // ← Recibimos los biológicos reales
// }: ModalSeguimientoProps) {
//   const [step, setStep] = useState(1);

//   // Estado para los checkboxes (solo IDs)
//   const [biologicosSeleccionados, setBiologicosSeleccionados] = useState<
//     number[]
//   >([]);

//   // Estado para los EPPs (texto libre)
//   const [epps, setEpps] = useState<EPP[]>([{ nombre: '' }]);

//   const { data, setData, post, processing, errors, reset } = useForm({
//     empresa_id: '',
//     almacen_id: '',
//     observaciones: '',
//     biologicos_ids: [] as number[], // ← Ahora es un array de IDs
//     epps: [{ nombre: '' }],
//   });

//   const toggleBiologico = (id: number) => {
//     setBiologicosSeleccionados((prev) =>
//       prev.includes(id) ? prev.filter((b) => b !== id) : [...prev, id],
//     );
//   };

//   const handleNext = () => {
//     if (step === 1 && data.empresa_id && data.almacen_id) {
//       setStep(2);
//     } else if (step === 2) {
//       setData('biologicos_ids', biologicosSeleccionados);
//       setStep(step + 1);
//     }
//   };

//   const handleBack = () => {
//     setStep(step - 1);
//   };

//   const handleSubmit = (e: React.FormEvent) => {
//     e.preventDefault();

//     // Aseguramos que los IDs estén actualizados antes de enviar
//     setData('biologicos_ids', biologicosSeleccionados);

//     post('/seguimientos', {
//       onSuccess: () => {
//         handleClose();
//       },
//     });
//   };

//   const handleClose = () => {
//     reset();
//     setBiologicosSeleccionados([]);
//     setEpps([{ nombre: '' }]);
//     setStep(1);
//     onClose();
//   };

//   // --- Funciones EPP ---
//   const addEpp = () => {
//     setEpps([...epps, { nombre: '' }]);
//   };

//   const removeEpp = (index: number) => {
//     if (epps.length > 1) {
//       setEpps(epps.filter((_, i) => i !== index));
//     }
//   };

//   const updateEpp = (index: number, value: string) => {
//     const updated = [...epps];
//     updated[index].nombre = value;
//     setEpps(updated);
//     setData('epps', updated);
//   };

//   return (
//     <Dialog open={open} onOpenChange={handleClose}>
//       <DialogContent className="max-h-[90vh] overflow-y-auto sm:max-w-[700px]">
//         <DialogHeader>
//           <DialogTitle>Nuevo Seguimiento - Paso {step} de 3</DialogTitle>
//         </DialogHeader>

//         <form onSubmit={handleSubmit}>
//           {/* Paso 1: Datos básicos */}
//           {step === 1 && (
//             <div className="space-y-5 py-4">
//               <div className="space-y-2">
//                 <Label htmlFor="empresa_id">Empresa *</Label>
//                 <Select
//                   value={data.empresa_id}
//                   onValueChange={(value) => setData('empresa_id', value)}
//                 >
//                   <SelectTrigger>
//                     <SelectValue placeholder="Seleccionar empresa" />
//                   </SelectTrigger>
//                   <SelectContent>
//                     {empresas.map((empresa) => (
//                       <SelectItem
//                         key={empresa.id}
//                         value={empresa.id.toString()}
//                       >
//                         {empresa.nombre}
//                       </SelectItem>
//                     ))}
//                   </SelectContent>
//                 </Select>
//                 {errors.empresa_id && (
//                   <p className="text-sm text-red-500">{errors.empresa_id}</p>
//                 )}
//               </div>

//               <div className="space-y-2">
//                 <Label htmlFor="almacen_id">Almacén *</Label>
//                 <Select
//                   value={data.almacen_id}
//                   onValueChange={(value) => setData('almacen_id', value)}
//                 >
//                   <SelectTrigger>
//                     <SelectValue placeholder="Seleccionar almacén" />
//                   </SelectTrigger>
//                   <SelectContent>
//                     {almacenes.map((almacen) => (
//                       <SelectItem
//                         key={almacen.id}
//                         value={almacen.id.toString()}
//                       >
//                         {almacen.nombre}
//                       </SelectItem>
//                     ))}
//                   </SelectContent>
//                 </Select>
//                 {errors.almacen_id && (
//                   <p className="text-sm text-red-500">{errors.almacen_id}</p>
//                 )}
//               </div>

//               <div className="space-y-2">
//                 <Label htmlFor="observaciones">Observaciones</Label>
//                 <Textarea
//                   value={data.observaciones || ''}
//                   onChange={(e) => setData('observaciones', e.target.value)}
//                   rows={4}
//                   placeholder="Observaciones generales del seguimiento"
//                 />
//               </div>
//             </div>
//           )}

//           {/* Paso 2: Apliacaciones */}
//           {step === 2 && (
//             <div className="space-y-6 py-4">
//               <div>
//                 <Label className="text-lg font-semibold">Aplicaciones</Label>
//                 <p className="text-sm text-muted-foreground">
//                   Espacio donde se realizo las aplicaciones
//                 </p>
//               </div>
//             </div>
//           )}

//           {/* Paso 3: Biológicos con Checkboxes */}
//           {step === 3 && (
//             <div className="space-y-6 py-4">
//               <div>
//                 <Label className="text-lg font-semibold">
//                   Biológicos presentes en el seguimiento
//                 </Label>
//                 <p className="text-sm text-muted-foreground">
//                   Selecciona todos los que apliquen
//                 </p>
//               </div>

//               {biologicos.length === 0 ? (
//                 <p className="text-sm text-muted-foreground">
//                   No hay biológicos registrados en el sistema.
//                 </p>
//               ) : (
//                 <div className="grid max-h-[420px] grid-cols-1 gap-3 overflow-y-auto md:grid-cols-2">
//                   {biologicos.map((biologico) => (
//                     <label
//                       key={biologico.id}
//                       className="flex cursor-pointer items-center space-x-3 rounded-lg border p-4 transition-colors hover:bg-accent has-[:checked]:border-primary has-[:checked]:bg-primary/10"
//                     >
//                       <Checkbox
//                         checked={biologicosSeleccionados.includes(biologico.id)}
//                         onCheckedChange={() => toggleBiologico(biologico.id)}
//                       />
//                       <span className="text-sm font-medium">
//                         {biologico.nombre}
//                       </span>
//                     </label>
//                   ))}
//                 </div>
//               )}

//               {errors.biologicos_ids && (
//                 <p className="text-sm text-red-500">{errors.biologicos_ids}</p>
//               )}
//             </div>
//           )}

//           {/* Paso 4: EPP */}
//           {step === 4 && (
//             <div className="space-y-5 py-4">
//               <div className="flex items-center justify-between">
//                 <Label className="text-lg font-semibold">
//                   Equipos de Protección Personal (EPP)
//                 </Label>
//                 <Button type="button" size="sm" onClick={addEpp}>
//                   <Plus className="mr-2 h-4 w-4" />
//                   Agregar EPP
//                 </Button>
//               </div>

//               <div className="max-h-[400px] space-y-3 overflow-y-auto">
//                 {epps.map((epp, index) => (
//                   <div key={index} className="flex items-center gap-3">
//                     <Input
//                       value={epp.nombre}
//                       onChange={(e) => updateEpp(index, e.target.value)}
//                       placeholder={`EPP ${index + 1}`}
//                       className="flex-1"
//                     />
//                     {epps.length > 1 && (
//                       <Button
//                         type="button"
//                         variant="ghost"
//                         size="sm"
//                         onClick={() => removeEpp(index)}
//                       >
//                         <Trash2 className="h-4 w-4 text-red-500" />
//                       </Button>
//                     )}
//                   </div>
//                 ))}
//               </div>
//             </div>
//           )}

//           {/* Footer con botones */}
//           <DialogFooter className="mt-6 gap-3">
//             {step > 1 && (
//               <Button type="button" variant="outline" onClick={handleBack}>
//                 Atrás
//               </Button>
//             )}

//             <Button type="button" variant="outline" onClick={handleClose}>
//               Cancelar
//             </Button>

//             {step < 3 ? (
//               <Button
//                 type="button"
//                 onClick={handleNext}
//                 // disabled={
//                 //   (step === 1 && (!data.empresa_id || !data.almacen_id)) ||
//                 //   (step === 2 && biologicosSeleccionados.length === 0)
//                 // }
//               >
//                 Siguiente
//               </Button>
//             ) : (
//               <Button type="submit" disabled={processing}>
//                 {processing ? 'Guardando...' : 'Guardar Seguimiento'}
//               </Button>
//             )}
//           </DialogFooter>
//         </form>
//       </DialogContent>
//     </Dialog>
//   );
// }

// ------------------------------------------------------------------------------------------------------
// import { Button } from '@/components/ui/button';
// import {
//   Dialog,
//   DialogContent,
//   DialogFooter,
//   DialogHeader,
//   DialogTitle,
// } from '@/components/ui/dialog';
// import { Input } from '@/components/ui/input';
// import { Label } from '@/components/ui/label';
// import {
//   Select,
//   SelectContent,
//   SelectItem,
//   SelectTrigger,
//   SelectValue,
// } from '@/components/ui/select';
// import { Textarea } from '@/components/ui/textarea';
// import { useForm } from '@inertiajs/react';
// import { Plus, Trash2 } from 'lucide-react';
// import React, { useState } from 'react';

// interface Empresa {
//   id: number;
//   nombre: string;
// }

// interface Almacen {
//   id: number;
//   nombre: string;
// }

// interface Biologico {
//   nombre: string;
//   descripcion: string;
// }

// interface EPP {
//   nombre: string;
// }

// interface ModalSeguimientoProps {
//   open: boolean;
//   onClose: () => void;
//   empresas: Empresa[];
//   almacenes: Almacen[];
// }

// export default function ModalSeguimiento({
//   open,
//   onClose,
//   empresas,
//   almacenes,
// }: ModalSeguimientoProps) {
//   const [step, setStep] = useState(1);
//   const [biologicos, setBiologicos] = useState<Biologico[]>([
//     { nombre: '', descripcion: '' },
//   ]);
//   const [epps, setEpps] = useState<EPP[]>([{ nombre: '' }]);

//   const { data, setData, post, processing, errors, reset } = useForm({
//     empresa_id: '',
//     almacen_id: '',
//     observaciones: '',
//     biologicos: [{ nombre: '', descripcion: '' }],
//     epps: [{ nombre: '' }],
//   });

//   const handleNext = () => {
//     if (step === 1 && data.empresa_id && data.almacen_id) {
//       setStep(2);
//     } else if (step === 2) {
//       setData('biologicos', biologicos);
//       setStep(3);
//     }
//   };

//   const handleBack = () => {
//     setStep(step - 1);
//   };

//   const handleSubmit = (e: React.FormEvent) => {
//     e.preventDefault();

//     // Actualizar los datos del formulario con los arrays finales
//     setData({
//       ...data,
//       biologicos,
//       epps,
//     });

//     post('/seguimientos', {
//       onSuccess: () => {
//         handleClose();
//       },
//     });
//   };

//   const handleClose = () => {
//     reset();
//     setBiologicos([{ nombre: '', descripcion: '' }]);
//     setEpps([{ nombre: '' }]);
//     setStep(1);
//     onClose();
//   };

//   const addBiologico = () => {
//     setBiologicos([...biologicos, { nombre: '', descripcion: '' }]);
//   };

//   const removeBiologico = (index: number) => {
//     if (biologicos.length > 1) {
//       setBiologicos(biologicos.filter((_, i) => i !== index));
//     }
//   };

//   const updateBiologico = (
//     index: number,
//     field: keyof Biologico,
//     value: string,
//   ) => {
//     const updated = [...biologicos];
//     updated[index][field] = value;
//     setBiologicos(updated);
//   };

//   const addEpp = () => {
//     setEpps([...epps, { nombre: '' }]);
//   };

//   const removeEpp = (index: number) => {
//     if (epps.length > 1) {
//       setEpps(epps.filter((_, i) => i !== index));
//     }
//   };

//   const updateEpp = (index: number, value: string) => {
//     const updated = [...epps];
//     updated[index].nombre = value;
//     setEpps(updated);
//   };

//   return (
//     <Dialog open={open} onOpenChange={handleClose}>
//       <DialogContent className="sm:max-w-[600px]">
//         <DialogHeader>
//           <DialogTitle>Nuevo Seguimiento - Paso {step} de 3</DialogTitle>
//         </DialogHeader>

//         <form onSubmit={handleSubmit}>
//           {/* Paso 1: Datos básicos */}
//           {step === 1 && (
//             <div className="space-y-4 py-4">
//               <div className="space-y-2">
//                 <Label htmlFor="empresa_id">Empresa *</Label>
//                 <Select
//                   value={data.empresa_id}
//                   onValueChange={(value) => setData('empresa_id', value)}
//                 >
//                   <SelectTrigger>
//                     <SelectValue placeholder="Seleccionar empresa" />
//                   </SelectTrigger>
//                   <SelectContent>
//                     {empresas.map((empresa) => (
//                       <SelectItem
//                         key={empresa.id}
//                         value={empresa.id.toString()}
//                       >
//                         {empresa.nombre}
//                       </SelectItem>
//                     ))}
//                   </SelectContent>
//                 </Select>
//                 {errors.empresa_id && (
//                   <p className="text-sm text-red-500">{errors.empresa_id}</p>
//                 )}
//               </div>

//               <div className="space-y-2">
//                 <Label htmlFor="almacen_id">Almacén *</Label>
//                 <Select
//                   value={data.almacen_id}
//                   onValueChange={(value) => setData('almacen_id', value)}
//                 >
//                   <SelectTrigger>
//                     <SelectValue placeholder="Seleccionar almacén" />
//                   </SelectTrigger>
//                   <SelectContent>
//                     {almacenes.map((almacen) => (
//                       <SelectItem
//                         key={almacen.id}
//                         value={almacen.id.toString()}
//                       >
//                         {almacen.nombre}
//                       </SelectItem>
//                     ))}
//                   </SelectContent>
//                 </Select>
//                 {errors.almacen_id && (
//                   <p className="text-sm text-red-500">{errors.almacen_id}</p>
//                 )}
//               </div>

//               <div className="space-y-2">
//                 <Label htmlFor="observaciones">Observaciones</Label>
//                 <Textarea
//                   id="observaciones"
//                   value={data.observaciones}
//                   onChange={(e) => setData('observaciones', e.target.value)}
//                   rows={4}
//                   placeholder="Ingrese observaciones"
//                 />
//                 {errors.observaciones && (
//                   <p className="text-sm text-red-500">{errors.observaciones}</p>
//                 )}
//               </div>
//             </div>
//           )}

//           {/* Paso 2: Biológicos */}
//           {step === 2 && (
//             <div className="space-y-4 py-4">
//               <div className="flex items-center justify-between">
//                 <Label>Biológicos</Label>
//                 <Button type="button" size="sm" onClick={addBiologico}>
//                   <Plus className="mr-1 h-4 w-4" />
//                   Agregar
//                 </Button>
//               </div>

//               <div className="max-h-[400px] space-y-4 overflow-y-auto">
//                 {biologicos.map((biologico, index) => (
//                   <div key={index} className="space-y-3 rounded-lg border p-4">
//                     <div className="flex items-center justify-between">
//                       <span className="text-sm font-medium">
//                         Biológico {index + 1}
//                       </span>
//                       {biologicos.length > 1 && (
//                         <Button
//                           type="button"
//                           variant="ghost"
//                           size="sm"
//                           onClick={() => removeBiologico(index)}
//                         >
//                           <Trash2 className="h-4 w-4 text-red-500" />
//                         </Button>
//                       )}
//                     </div>

//                     <div className="space-y-2">
//                       <Label>Nombre *</Label>
//                       <Input
//                         value={biologico.nombre}
//                         onChange={(e) =>
//                           updateBiologico(index, 'nombre', e.target.value)
//                         }
//                         placeholder="Nombre del biológico"
//                       />
//                     </div>

//                     <div className="space-y-2">
//                       <Label>Descripción</Label>
//                       <Textarea
//                         value={biologico.descripcion}
//                         onChange={(e) =>
//                           updateBiologico(index, 'descripcion', e.target.value)
//                         }
//                         placeholder="Descripción del biológico"
//                         rows={3}
//                       />
//                     </div>
//                   </div>
//                 ))}
//               </div>
//             </div>
//           )}

//           {/* Paso 3: EPP */}
//           {step === 3 && (
//             <div className="space-y-4 py-4">
//               <div className="flex items-center justify-between">
//                 <Label>Equipos de Protección Personal (EPP)</Label>
//                 <Button type="button" size="sm" onClick={addEpp}>
//                   <Plus className="mr-1 h-4 w-4" />
//                   Agregar
//                 </Button>
//               </div>

//               <div className="max-h-[400px] space-y-3 overflow-y-auto">
//                 {epps.map((epp, index) => (
//                   <div key={index} className="flex items-center gap-2">
//                     <div className="flex-1">
//                       <Input
//                         value={epp.nombre}
//                         onChange={(e) => updateEpp(index, e.target.value)}
//                         placeholder={`EPP ${index + 1}`}
//                       />
//                     </div>
//                     {epps.length > 1 && (
//                       <Button
//                         type="button"
//                         variant="ghost"
//                         size="sm"
//                         onClick={() => removeEpp(index)}
//                       >
//                         <Trash2 className="h-4 w-4 text-red-500" />
//                       </Button>
//                     )}
//                   </div>
//                 ))}
//               </div>
//             </div>
//           )}

//           <DialogFooter className="gap-2">
//             {step > 1 && (
//               <Button type="button" variant="outline" onClick={handleBack}>
//                 Atrás
//               </Button>
//             )}

//             <Button type="button" variant="outline" onClick={handleClose}>
//               Cancelar
//             </Button>

//             {step < 3 ? (
//               <Button
//                 type="button"
//                 onClick={handleNext}
//                 disabled={step === 1 && (!data.empresa_id || !data.almacen_id)}
//               >
//                 Siguiente
//               </Button>
//             ) : (
//               <Button type="submit" disabled={processing}>
//                 {processing ? 'Guardando...' : 'Guardar Seguimiento'}
//               </Button>
//             )}
//           </DialogFooter>
//         </form>
//       </DialogContent>
//     </Dialog>
//   );
// }
