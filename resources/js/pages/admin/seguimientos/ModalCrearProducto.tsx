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
  SelectGroup,
  SelectItem,
  SelectLabel,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select';
import axios from 'axios';
import { Loader2 } from 'lucide-react';
import React, { useEffect, useState } from 'react';
import { MultiSelect } from '../productos/MultiSelect';

interface Unidad {
  id: number;
  nombre: string;
}
interface Categoria {
  id: number;
  nombre: string;
}
interface Marca {
  id: number;
  nombre: string;
}
interface Etiqueta {
  id: number;
  nombre: string;
}

export interface ProductoCreado {
  id: number;
  nombre: string;
  precio_compra: number;
  precio_venta: number;
  stock: number;
  unidad: Unidad;
}

interface Props {
  open: boolean;
  onClose: () => void;
  onProductoCreado: (producto: ProductoCreado) => void;
  nombreInicial?: string;
}

export default function ModalCrearProducto({
  open,
  onClose,
  onProductoCreado,
  nombreInicial = '',
}: Props) {
  const [loadingData, setLoadingData] = useState(false);
  const [submitting, setSubmitting] = useState(false);
  const [errors, setErrors] = useState<Record<string, string>>({});

  const [categorias, setCategorias] = useState<Categoria[]>([]);
  const [marcas, setMarcas] = useState<Marca[]>([]);
  const [etiquetas, setEtiquetas] = useState<Etiqueta[]>([]);
  const [unidades, setUnidades] = useState<Unidad[]>([]);

  const emptyForm = {
    nombre: '',
    descripcion: '',
    stock_min: 0,
    unidad_valor: '',
    unidad_id: '',
    marca_id: '',
    categoria_id: '',
    etiqueta_ids: [] as number[],
  };

  const [form, setForm] = useState(emptyForm);

  useEffect(() => {
    if (!open) return;

    setForm({ ...emptyForm, nombre: nombreInicial });
    setErrors({});
    setLoadingData(true);

    axios
      .get('/productos/formdata')
      .then(({ data }) => {
        setCategorias(data.categorias);
        setMarcas(data.marcas);
        setEtiquetas(data.etiquetas);
        setUnidades(data.unidades);
      })
      .catch(console.error)
      .finally(() => setLoadingData(false));
  }, [open]);

  // Sincronizar nombre si el query cambia mientras está cerrado y luego se abre
  useEffect(() => {
    if (open) setForm((prev) => ({ ...prev, nombre: nombreInicial }));
  }, [nombreInicial]);

  const set = (field: string, value: any) =>
    setForm((prev) => ({ ...prev, [field]: value }));

  const handleClose = () => {
    setForm(emptyForm);
    setErrors({});
    onClose();
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setSubmitting(true);
    setErrors({});

    try {
      const payload = {
        ...form,
        categoria_id:
          form.categoria_id === '' ? null : Number(form.categoria_id),
        marca_id: form.marca_id === '' ? null : Number(form.marca_id),
        unidad_id: Number(form.unidad_id),
        stock_min: Number(form.stock_min),
        unidad_valor: Number(form.unidad_valor),
      };

      const { data } = await axios.post('/productos/storemodal', payload);
      onProductoCreado(data);
      handleClose();
    } catch (err: any) {
      if (err.response?.status === 422) {
        const serverErrors: Record<string, string[]> =
          err.response.data.errors ?? {};
        setErrors(
          Object.fromEntries(
            Object.entries(serverErrors).map(([k, v]) => [k, v[0]]),
          ),
        );
      }
    } finally {
      setSubmitting(false);
    }
  };

  return (
    <Dialog
      open={open}
      onOpenChange={(isOpen) => {
        if (!isOpen) handleClose();
      }}
    >
      <DialogContent className="sm:max-w-[550px]">
        <DialogHeader>
          <DialogTitle>Nuevo Producto</DialogTitle>
        </DialogHeader>

        {loadingData ? (
          <div className="flex justify-center py-10">
            <Loader2 className="h-6 w-6 animate-spin text-muted-foreground" />
          </div>
        ) : (
          <form onSubmit={handleSubmit} className="space-y-4 py-2">
            {/* Nombre */}
            <div className="space-y-1">
              <Label>Nombre *</Label>
              <Input
                value={form.nombre}
                onChange={(e) => set('nombre', e.target.value)}
                placeholder="Nombre del producto"
              />
              {errors.nombre && (
                <p className="text-sm text-red-500">{errors.nombre}</p>
              )}
            </div>

            {/* Descripción */}
            <div className="space-y-1">
              <Label>Descripción</Label>
              <Input
                value={form.descripcion}
                onChange={(e) => set('descripcion', e.target.value)}
                placeholder="Descripción (opcional)"
              />
            </div>

            {/* Unidad de empaque */}
            <div className="space-y-1">
              <Label>Unidad de empaque *</Label>
              <div className="flex gap-2">
                <Input
                  type="number"
                  placeholder="Cantidad"
                  value={form.unidad_valor}
                  onChange={(e) => set('unidad_valor', e.target.value)}
                  className="w-28"
                />
                <Select
                  value={form.unidad_id}
                  onValueChange={(v) => set('unidad_id', v)}
                >
                  <SelectTrigger className="flex-1">
                    <SelectValue placeholder="Selecciona unidad" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectGroup>
                      <SelectLabel>Unidades</SelectLabel>
                      {unidades.map((u) => (
                        <SelectItem key={u.id} value={String(u.id)}>
                          {u.nombre}
                        </SelectItem>
                      ))}
                    </SelectGroup>
                  </SelectContent>
                </Select>
              </div>
              {errors.unidad_valor && (
                <p className="text-sm text-red-500">{errors.unidad_valor}</p>
              )}
              {errors.unidad_id && (
                <p className="text-sm text-red-500">{errors.unidad_id}</p>
              )}
            </div>

            {/* Stock mínimo */}
            <div className="space-y-1">
              <Label>Stock mínimo</Label>
              <Input
                type="number"
                value={form.stock_min}
                onChange={(e) => set('stock_min', e.target.value)}
              />
              {errors.stock_min && (
                <p className="text-sm text-red-500">{errors.stock_min}</p>
              )}
            </div>

            {/* Categoría */}
            <div className="space-y-1">
              <Label>Categoría</Label>
              <Select
                value={form.categoria_id}
                onValueChange={(v) => set('categoria_id', v)}
              >
                <SelectTrigger>
                  <SelectValue placeholder="Selecciona una categoría" />
                </SelectTrigger>
                <SelectContent>
                  <SelectGroup>
                    <SelectLabel>Categorías</SelectLabel>
                    {categorias.map((c) => (
                      <SelectItem key={c.id} value={String(c.id)}>
                        {c.nombre}
                      </SelectItem>
                    ))}
                  </SelectGroup>
                </SelectContent>
              </Select>
            </div>

            {/* Marca */}
            <div className="space-y-1">
              <Label>Marca</Label>
              <Select
                value={form.marca_id}
                onValueChange={(v) => set('marca_id', v)}
              >
                <SelectTrigger>
                  <SelectValue placeholder="Selecciona una marca" />
                </SelectTrigger>
                <SelectContent>
                  <SelectGroup>
                    <SelectLabel>Marcas</SelectLabel>
                    {marcas.map((m) => (
                      <SelectItem key={m.id} value={String(m.id)}>
                        {m.nombre}
                      </SelectItem>
                    ))}
                  </SelectGroup>
                </SelectContent>
              </Select>
            </div>

            {/* Etiquetas */}
            <div className="space-y-1">
              <Label>Etiquetas</Label>
              <MultiSelect
                opciones={etiquetas}
                seleccionadas={form.etiqueta_ids}
                onChange={(ids) => set('etiqueta_ids', ids)}
              />
            </div>

            <DialogFooter className="pt-2">
              <Button
                type="button"
                variant="outline"
                onClick={handleClose}
                disabled={submitting}
              >
                Cancelar
              </Button>
              <Button type="submit" disabled={submitting}>
                {submitting ? 'Guardando...' : 'Crear Producto'}
              </Button>
            </DialogFooter>
          </form>
        )}
      </DialogContent>
    </Dialog>
  );
}
