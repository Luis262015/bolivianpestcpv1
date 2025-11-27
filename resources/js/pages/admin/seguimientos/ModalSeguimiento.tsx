import { Button } from '@/components/ui/button';
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
  nombre: string;
  descripcion: string;
}

interface EPP {
  nombre: string;
}

interface ModalSeguimientoProps {
  open: boolean;
  onClose: () => void;
  empresas: Empresa[];
  almacenes: Almacen[];
}

export default function ModalSeguimiento({
  open,
  onClose,
  empresas,
  almacenes,
}: ModalSeguimientoProps) {
  const [step, setStep] = useState(1);
  const [biologicos, setBiologicos] = useState<Biologico[]>([
    { nombre: '', descripcion: '' },
  ]);
  const [epps, setEpps] = useState<EPP[]>([{ nombre: '' }]);

  const { data, setData, post, processing, errors, reset } = useForm({
    empresa_id: '',
    almacen_id: '',
    observaciones: '',
    biologicos: [{ nombre: '', descripcion: '' }],
    epps: [{ nombre: '' }],
  });

  const handleNext = () => {
    if (step === 1 && data.empresa_id && data.almacen_id) {
      setStep(2);
    } else if (step === 2) {
      setData('biologicos', biologicos);
      setStep(3);
    }
  };

  const handleBack = () => {
    setStep(step - 1);
  };

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();

    // Actualizar los datos del formulario con los arrays finales
    setData({
      ...data,
      biologicos,
      epps,
    });

    post('/seguimientos', {
      onSuccess: () => {
        handleClose();
      },
    });
  };

  const handleClose = () => {
    reset();
    setBiologicos([{ nombre: '', descripcion: '' }]);
    setEpps([{ nombre: '' }]);
    setStep(1);
    onClose();
  };

  const addBiologico = () => {
    setBiologicos([...biologicos, { nombre: '', descripcion: '' }]);
  };

  const removeBiologico = (index: number) => {
    if (biologicos.length > 1) {
      setBiologicos(biologicos.filter((_, i) => i !== index));
    }
  };

  const updateBiologico = (
    index: number,
    field: keyof Biologico,
    value: string,
  ) => {
    const updated = [...biologicos];
    updated[index][field] = value;
    setBiologicos(updated);
  };

  const addEpp = () => {
    setEpps([...epps, { nombre: '' }]);
  };

  const removeEpp = (index: number) => {
    if (epps.length > 1) {
      setEpps(epps.filter((_, i) => i !== index));
    }
  };

  const updateEpp = (index: number, value: string) => {
    const updated = [...epps];
    updated[index].nombre = value;
    setEpps(updated);
  };

  return (
    <Dialog open={open} onOpenChange={handleClose}>
      <DialogContent className="sm:max-w-[600px]">
        <DialogHeader>
          <DialogTitle>Nuevo Seguimiento - Paso {step} de 3</DialogTitle>
        </DialogHeader>

        <form onSubmit={handleSubmit}>
          {/* Paso 1: Datos básicos */}
          {step === 1 && (
            <div className="space-y-4 py-4">
              <div className="space-y-2">
                <Label htmlFor="empresa_id">Empresa *</Label>
                <Select
                  value={data.empresa_id}
                  onValueChange={(value) => setData('empresa_id', value)}
                >
                  <SelectTrigger>
                    <SelectValue placeholder="Seleccionar empresa" />
                  </SelectTrigger>
                  <SelectContent>
                    {empresas.map((empresa) => (
                      <SelectItem
                        key={empresa.id}
                        value={empresa.id.toString()}
                      >
                        {empresa.nombre}
                      </SelectItem>
                    ))}
                  </SelectContent>
                </Select>
                {errors.empresa_id && (
                  <p className="text-sm text-red-500">{errors.empresa_id}</p>
                )}
              </div>

              <div className="space-y-2">
                <Label htmlFor="almacen_id">Almacén *</Label>
                <Select
                  value={data.almacen_id}
                  onValueChange={(value) => setData('almacen_id', value)}
                >
                  <SelectTrigger>
                    <SelectValue placeholder="Seleccionar almacén" />
                  </SelectTrigger>
                  <SelectContent>
                    {almacenes.map((almacen) => (
                      <SelectItem
                        key={almacen.id}
                        value={almacen.id.toString()}
                      >
                        {almacen.nombre}
                      </SelectItem>
                    ))}
                  </SelectContent>
                </Select>
                {errors.almacen_id && (
                  <p className="text-sm text-red-500">{errors.almacen_id}</p>
                )}
              </div>

              <div className="space-y-2">
                <Label htmlFor="observaciones">Observaciones</Label>
                <Textarea
                  id="observaciones"
                  value={data.observaciones}
                  onChange={(e) => setData('observaciones', e.target.value)}
                  rows={4}
                  placeholder="Ingrese observaciones"
                />
                {errors.observaciones && (
                  <p className="text-sm text-red-500">{errors.observaciones}</p>
                )}
              </div>
            </div>
          )}

          {/* Paso 2: Biológicos */}
          {step === 2 && (
            <div className="space-y-4 py-4">
              <div className="flex items-center justify-between">
                <Label>Biológicos</Label>
                <Button type="button" size="sm" onClick={addBiologico}>
                  <Plus className="mr-1 h-4 w-4" />
                  Agregar
                </Button>
              </div>

              <div className="max-h-[400px] space-y-4 overflow-y-auto">
                {biologicos.map((biologico, index) => (
                  <div key={index} className="space-y-3 rounded-lg border p-4">
                    <div className="flex items-center justify-between">
                      <span className="text-sm font-medium">
                        Biológico {index + 1}
                      </span>
                      {biologicos.length > 1 && (
                        <Button
                          type="button"
                          variant="ghost"
                          size="sm"
                          onClick={() => removeBiologico(index)}
                        >
                          <Trash2 className="h-4 w-4 text-red-500" />
                        </Button>
                      )}
                    </div>

                    <div className="space-y-2">
                      <Label>Nombre *</Label>
                      <Input
                        value={biologico.nombre}
                        onChange={(e) =>
                          updateBiologico(index, 'nombre', e.target.value)
                        }
                        placeholder="Nombre del biológico"
                      />
                    </div>

                    <div className="space-y-2">
                      <Label>Descripción</Label>
                      <Textarea
                        value={biologico.descripcion}
                        onChange={(e) =>
                          updateBiologico(index, 'descripcion', e.target.value)
                        }
                        placeholder="Descripción del biológico"
                        rows={3}
                      />
                    </div>
                  </div>
                ))}
              </div>
            </div>
          )}

          {/* Paso 3: EPP */}
          {step === 3 && (
            <div className="space-y-4 py-4">
              <div className="flex items-center justify-between">
                <Label>Equipos de Protección Personal (EPP)</Label>
                <Button type="button" size="sm" onClick={addEpp}>
                  <Plus className="mr-1 h-4 w-4" />
                  Agregar
                </Button>
              </div>

              <div className="max-h-[400px] space-y-3 overflow-y-auto">
                {epps.map((epp, index) => (
                  <div key={index} className="flex items-center gap-2">
                    <div className="flex-1">
                      <Input
                        value={epp.nombre}
                        onChange={(e) => updateEpp(index, e.target.value)}
                        placeholder={`EPP ${index + 1}`}
                      />
                    </div>
                    {epps.length > 1 && (
                      <Button
                        type="button"
                        variant="ghost"
                        size="sm"
                        onClick={() => removeEpp(index)}
                      >
                        <Trash2 className="h-4 w-4 text-red-500" />
                      </Button>
                    )}
                  </div>
                ))}
              </div>
            </div>
          )}

          <DialogFooter className="gap-2">
            {step > 1 && (
              <Button type="button" variant="outline" onClick={handleBack}>
                Atrás
              </Button>
            )}

            <Button type="button" variant="outline" onClick={handleClose}>
              Cancelar
            </Button>

            {step < 3 ? (
              <Button
                type="button"
                onClick={handleNext}
                disabled={step === 1 && (!data.empresa_id || !data.almacen_id)}
              >
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
