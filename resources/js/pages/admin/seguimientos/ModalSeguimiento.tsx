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
import SignaturePad from './SignaturePad';

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
    imagenes: [] as File[],
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
    if (step === 3) setData('metodos_ids', metodosSel);
    if (step === 4) setData('productos_usados', productos);
    if (step === 5) setData('epps_ids', eppsSel);
    if (step === 6) setData('protecciones_ids', proteccionesSel);
    if (step === 7) setData('biologicos_ids', biologicosSel);
    if (step === 8) setData('signos_ids', signosSel);
    if (step === 9)
      setData('observaciones_especificas', data.observaciones_especificas);

    setStep((s) => Math.min(s + 1, 12));
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
    reset();
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

  const [firmaEncargado, setFirmaEncargado] = useState<string>('');
  const [firmaSupervisor, setFirmaSupervisor] = useState<string>('');

  return (
    // <Dialog open={open} onOpenChange={handleClose}>
    <Dialog
      open={open}
      onOpenChange={(isOpen) => {
        if (!isOpen) onClose();
      }}
    >
      <DialogContent className="max-h-[90vh] overflow-y-auto sm:max-w-[800px]">
        <DialogHeader>
          <DialogTitle>Nuevo Seguimiento - Paso {step} de 12</DialogTitle>
          <div className="mt-3 h-2 w-full rounded-full bg-muted">
            <div
              className="h-2 rounded-full bg-primary transition-all"
              style={{ width: `${(step / 12) * 100}%` }}
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
                    <p className="text-sm text-red-500">
                      {errors.empresa_id || 'Error en empresa'}
                    </p>
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
                Labores Desarrolladas
              </Label>
              <div className="grid grid-cols-1 gap-4 sm:grid-cols-2">
                <Input
                  placeholder="Cantidad Oficinas"
                  type="number"
                  step={'0.01'}
                />
                <Input
                  placeholder="Cantidad Pisos"
                  type="number"
                  step={'0.01'}
                />
                <Input
                  placeholder="Cantidad Baños"
                  type="number"
                  step={'0.01'}
                />
                <Input
                  placeholder="Cantidad Cocinas"
                  type="number"
                  step={'0.01'}
                />
                <Input
                  placeholder="Cantidad Almacenes"
                  type="number"
                  step={'0.01'}
                />
                <Input placeholder="Porteria" type="number" step={'0.01'} />
                <Input
                  placeholder="Dormitorio Policial"
                  type="number"
                  step={'0.01'}
                />
                <Input
                  placeholder="Cant. Paredes Internas"
                  type="number"
                  step={'0.01'}
                />
                <Input
                  placeholder="Cant. Trampas"
                  type="number"
                  step={'0.01'}
                />
                <Input
                  placeholder="Trampas Cambiadas"
                  type="number"
                  step={'0.01'}
                />
                <Input
                  placeholder="Roedores encontrados"
                  type="number"
                  step={'0.01'}
                />
                <Input
                  placeholder="Trampas Internas"
                  type="number"
                  step={'0.01'}
                />
                <Input
                  placeholder="Trampas Externas"
                  type="number"
                  step={'0.01'}
                />
              </div>
            </div>
          )}

          {/* PASO 3: Métodos */}
          {step === 3 && (
            <div className="space-y-5 py-6">
              <Label className="text-lg font-semibold">Método Utilizado</Label>
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

          {/* PASO 4: Productos y Cantidades */}
          {step === 4 && (
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
                      className=""
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

          {/* PASO 5: EPP */}
          {step === 5 && (
            <div className="space-y-5 py-6">
              <Label className="text-lg font-semibold">
                Equipos de Protección Personal Utilizados (EPP)
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
                Métodos de Protección Adoptadas para Terceros
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

          {/* PASO 7: Biológicos */}
          {step === 7 && (
            <div className="space-y-5 py-6">
              <Label className="text-lg font-semibold">
                Observaciones de Ciclos Biológicos
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

          {/* PASO 8: Signos / Síntomas */}
          {step === 8 && (
            <div className="space-y-5 py-6">
              <Label className="text-lg font-semibold">
                Observaciones de Signos de Roedores
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

          {/* PASO 9: Observaciones Específicas */}
          {step === 9 && (
            <div className="space-y-5 py-6">
              <Label className="text-lg font-semibold">
                Observaciones Bolivian PEST
              </Label>
              <Textarea
                rows={8}
                placeholder="Detalles adicionales del seguimiento..."
                value={data.observaciones_especificas}
                onChange={(e) =>
                  setData('observaciones_especificas', e.target.value)
                }
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
                    onChange={(e) =>
                      setData('encargado_nombre', e.target.value)
                    }
                  />
                </div>
                <div className="space-y-2">
                  <Label>Cargo</Label>
                  <Input
                    value={data.encargado_cargo}
                    onChange={(e) => setData('encargado_cargo', e.target.value)}
                  />
                </div>
              </div>
              <div className="grid grid-cols-1 gap-5 sm:grid-cols-2">
                <div className="space-y-2">
                  <Label>Firma Encargado (texto o dibujar después)</Label>
                  {/* <Input placeholder="Escriba su nombre completo como firma" /> */}
                  <SignaturePad onChange={(data) => setFirmaEncargado(data)} />
                  {firmaEncargado && (
                    <img
                      src={firmaEncargado}
                      alt="Firma Encargado"
                      className="w-40 border"
                    />
                  )}
                </div>
                <div className="space-y-2">
                  <Label>Firma Supervisor</Label>
                  {/* <Input placeholder="Escriba su nombre completo como firma" /> */}
                  <SignaturePad onChange={(data) => setFirmaSupervisor(data)} />

                  {firmaSupervisor && (
                    <img
                      src={firmaSupervisor}
                      alt="Firma Supervisor"
                      className="w-40 border"
                    />
                  )}
                </div>
              </div>
            </div>
          )}

          {/* PASO 11: Imagenes de  */}
          {step === 11 && (
            <div className="space-y-4">
              <h3 className="text-lg font-semibold">Subir imágenes</h3>

              <p className="text-sm text-muted-foreground">
                Puedes adjuntar imágenes relacionadas al seguimiento (opcional).
              </p>

              <input
                type="file"
                multiple
                accept="image/*"
                onChange={(e) => {
                  if (e.target.files) {
                    setData('imagenes', Array.from(e.target.files));
                  }
                }}
              />

              {/* Preview */}
              {data.imagenes.length > 0 && (
                <div className="mt-4 grid grid-cols-3 gap-3">
                  {data.imagenes.map((file, index) => (
                    <div
                      key={index}
                      className="flex flex-col items-center rounded-md border p-2"
                    >
                      <img
                        src={URL.createObjectURL(file)}
                        alt="preview"
                        className="h-32 w-full rounded object-cover"
                      />
                      <span className="mt-1 text-xs">{file.name}</span>
                    </div>
                  ))}
                </div>
              )}
            </div>
          )}

          {/* PASO 12: Observaciones Generales + Final */}
          {step === 12 && (
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
                onChange={(e) =>
                  setData('observaciones_generales', e.target.value)
                }
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

            {step < 12 ? (
              // <Button type="button" onClick={handleNext}>
              //   Siguiente
              // </Button>
              <Button asChild>
                <button type="button" onClick={handleNext}>
                  Siguiente
                </button>
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
