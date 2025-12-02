import { Button } from '@/components/ui/button';
import {
  Command,
  CommandEmpty,
  CommandGroup,
  CommandInput,
  CommandItem,
  CommandList,
} from '@/components/ui/command';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import {
  Popover,
  PopoverContent,
  PopoverTrigger,
} from '@/components/ui/popover';
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from '@/components/ui/table';
import AppLayout from '@/layouts/app-layout';
import { cn } from '@/lib/utils';
import { type BreadcrumbItem } from '@/types';
import { Head, router, useForm } from '@inertiajs/react';
import axios from 'axios';
import { Check, ChevronsUpDown, Plus, X } from 'lucide-react';
import { useEffect, useMemo, useState } from 'react';

const breadcrumbs: BreadcrumbItem[] = [
  {
    title: 'Compras',
    href: 'compras/create',
  },
];

// === Interfaces ===
interface Proveedor {
  value: number;
  label: string;
}

interface Producto {
  id: number;
  nombre: string;
  precio_compra: number;
  precio_venta: number;
}

interface ItemCompra {
  producto_id: number;
  nombre_producto: string;
  cantidad: number;
  costo_unitario: number;
  costo_total: number;
  precio_venta: number;
}

interface CompraFormData {
  proveedor_id: number | null;
  numero: string;
  autorizacion: string;
  control: string;
  observaciones: string;
  abonado: number;
  items: Array<{
    producto_id: number;
    cantidad: number;
    costo_unitario: number;
    precio_venta: number;
  }>;
}

interface Props {
  proveedores: Proveedor[];
}

// === Componente ===
export default function Compra({ proveedores }: Props) {
  const [open, setOpen] = useState(false);
  const [query, setQuery] = useState('');
  const [searchResults, setSearchResults] = useState<Producto[]>([]);
  const [selectedProduct, setSelectedProduct] = useState<Producto | null>(null);
  const [loading, setLoading] = useState(false);
  const [quantity, setQuantity] = useState(1);
  const [items, setItems] = useState<ItemCompra[]>([]);
  const [proveedorId, setProveedorId] = useState<number | null>(null);
  const [abonadoInput, setAbonadoInput] = useState(0);

  const { data, setData, errors } = useForm<CompraFormData>({
    proveedor_id: null,
    numero: '',
    autorizacion: '',
    control: '',
    observaciones: '',
    abonado: 0,
    items: [],
  });

  // === Búsqueda con debounce ===
  useEffect(() => {
    if (query.length < 2) {
      setSearchResults([]);
      return;
    }

    const delayDebounce = setTimeout(async () => {
      setLoading(true);
      try {
        const { data } = await axios.get(`/productos/search?q=${query}`);
        setSearchResults(data);
      } catch (error) {
        console.error('Error al buscar productos:', error);
      } finally {
        setLoading(false);
      }
    }, 300);

    return () => clearTimeout(delayDebounce);
  }, [query]);

  // === Sincronizar abonado con useForm ===
  useEffect(() => {
    setData('abonado', abonadoInput);
  }, [abonadoInput, setData]);

  // === Cálculos ===
  const totalCompra = useMemo(() => {
    return items.reduce((sum, i) => sum + i.costo_total, 0);
  }, [items]);

  const saldo = useMemo(() => {
    return Math.max(0, totalCompra - abonadoInput);
  }, [totalCompra, abonadoInput]);

  // === Agregar producto ===
  const agregarItem = () => {
    if (!selectedProduct || quantity < 1) return;

    const existe = items.some((i) => i.producto_id === selectedProduct.id);
    if (existe) {
      alert('Este producto ya fue agregado');
      return;
    }

    const nuevo: ItemCompra = {
      producto_id: selectedProduct.id,
      nombre_producto: selectedProduct.nombre,
      cantidad: quantity,
      costo_unitario: selectedProduct.precio_compra,
      costo_total: quantity * selectedProduct.precio_compra,
      precio_venta: selectedProduct.precio_venta,
    };

    setItems([...items, nuevo]);
    setSelectedProduct(null);
    setQuery('');
    setQuantity(1);
    setOpen(false);
  };

  // === Actualizar item ===
  const actualizarItem = (
    index: number,
    campo: 'cantidad' | 'costo_unitario' | 'precio_venta',
    valor: string,
  ) => {
    const num = parseFloat(valor) || 0;
    const updated = [...items];
    updated[index][campo] = num;

    if (campo === 'cantidad' || campo === 'costo_unitario') {
      updated[index].costo_total =
        updated[index].cantidad * updated[index].costo_unitario;
    }

    setItems(updated);
  };

  // === Eliminar item ===
  const eliminarItem = (index: number) => {
    setItems(items.filter((_, i) => i !== index));
  };

  // === Enviar formulario ===
  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();

    if (!proveedorId || items.length === 0) {
      alert('Selecciona un proveedor y al menos un producto');
      return;
    }

    const payload = {
      proveedor_id: proveedorId,
      numero: data.numero,
      autorizacion: data.autorizacion,
      control: data.control,
      observaciones: data.observaciones,
      abonado: abonadoInput,
      items: items.map((i) => ({
        producto_id: i.producto_id,
        cantidad: i.cantidad,
        costo_unitario: i.costo_unitario,
        precio_venta: i.precio_venta,
      })),
    };

    router.post('/compras', payload, {
      onSuccess: () => {
        alert('Compra guardada exitosamente');
      },
      onError: (errors) => {
        console.error('Errores:', errors);
      },
    });
  };

  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Compras | Crear" />

      <div className="mx-auto max-w-6xl p-6">
        <h1 className="mb-6 text-3xl font-bold">Registro de Compra</h1>

        <form onSubmit={handleSubmit} className="space-y-6">
          {/* === Datos de Factura === */}
          <div className="grid grid-cols-1 gap-4 border-b pb-6 md:grid-cols-2">
            <div>
              <Label htmlFor="numero">Número de Factura *</Label>
              <Input
                id="numero"
                value={data.numero}
                onChange={(e) => setData('numero', e.target.value)}
                placeholder="Ej: 001-001-000123"
              />
              {errors.numero && (
                <p className="mt-1 text-sm text-red-500">{errors.numero}</p>
              )}
            </div>

            <div>
              <Label htmlFor="autorizacion">Autorización SRI *</Label>
              <Input
                id="autorizacion"
                value={data.autorizacion}
                onChange={(e) => setData('autorizacion', e.target.value)}
                placeholder="10 dígitos"
                maxLength={10}
              />
              {errors.autorizacion && (
                <p className="mt-1 text-sm text-red-500">
                  {errors.autorizacion}
                </p>
              )}
            </div>

            <div>
              <Label htmlFor="control">Control Interno</Label>
              <Input
                id="control"
                value={data.control}
                onChange={(e) => setData('control', e.target.value)}
                placeholder="Opcional"
              />
            </div>

            <div>
              <Label htmlFor="observaciones">Observaciones</Label>
              <Input
                id="observaciones"
                value={data.observaciones}
                onChange={(e) => setData('observaciones', e.target.value)}
                placeholder="Notas adicionales"
              />
            </div>

            <div>
              <Label htmlFor="abonado">Abonado</Label>
              <Input
                id="abonado"
                type="number"
                step="0.01"
                min="0"
                value={abonadoInput}
                onChange={(e) =>
                  setAbonadoInput(parseFloat(e.target.value) || 0)
                }
                placeholder="0.00"
              />
            </div>

            <div>
              <Label>Saldo</Label>
              <div className="flex h-10 items-center rounded-md border bg-muted px-3 font-medium text-muted-foreground">
                $ {saldo.toFixed(2)}
              </div>
            </div>
          </div>

          {/* === Proveedor === */}
          <div>
            <Label>Proveedor *</Label>
            <select
              className="w-full rounded-md border p-2"
              onChange={(e) => setProveedorId(parseInt(e.target.value))}
              value={proveedorId || ''}
            >
              <option value="">Selecciona un proveedor</option>
              {proveedores.map((p) => (
                <option key={p.value} value={p.value}>
                  {p.label}
                </option>
              ))}
            </select>
            {errors.proveedor_id && (
              <p className="mt-1 text-sm text-red-500">{errors.proveedor_id}</p>
            )}
          </div>

          {/* === Búsqueda de Producto === */}
          <div className="flex items-end gap-3 border-b pb-4">
            <div className="flex-grow">
              <Label>Buscar Producto</Label>
              <Popover open={open} onOpenChange={setOpen}>
                <PopoverTrigger asChild>
                  <Button
                    variant="outline"
                    role="combobox"
                    className="w-full justify-between"
                  >
                    {selectedProduct
                      ? selectedProduct.nombre
                      : 'Buscar producto...'}
                    <ChevronsUpDown className="ml-2 h-4 w-4 shrink-0 opacity-50" />
                  </Button>
                </PopoverTrigger>
                <PopoverContent className="w-full p-0" align="start">
                  <Command shouldFilter={false}>
                    <CommandInput
                      placeholder="Escribe para buscar..."
                      value={query}
                      onValueChange={setQuery}
                    />
                    <CommandList>
                      {loading && <CommandEmpty>Buscando...</CommandEmpty>}
                      {!loading && query.length < 2 && (
                        <CommandEmpty>
                          Escribe al menos 2 caracteres
                        </CommandEmpty>
                      )}
                      {!loading &&
                        searchResults.length === 0 &&
                        query.length >= 2 && (
                          <CommandEmpty>
                            No se encontraron productos
                          </CommandEmpty>
                        )}
                      <CommandGroup>
                        {searchResults.map((product) => (
                          <CommandItem
                            key={product.id}
                            onSelect={() => {
                              setSelectedProduct(product);
                              setQuery(product.nombre);
                              setOpen(false);
                            }}
                          >
                            <Check
                              className={cn(
                                'mr-2 h-4 w-4',
                                selectedProduct?.id === product.id
                                  ? 'opacity-100'
                                  : 'opacity-0',
                              )}
                            />
                            <div>
                              <div>{product.nombre}</div>
                              <div className="text-xs text-gray-500">
                                Compra: ${product.precio_compra} | Venta: $
                                {product.precio_venta}
                              </div>
                            </div>
                          </CommandItem>
                        ))}
                      </CommandGroup>
                    </CommandList>
                  </Command>
                </PopoverContent>
              </Popover>
            </div>

            <div className="w-20">
              <Label>Cant.</Label>
              <Input
                type="number"
                min="1"
                value={quantity}
                onChange={(e) =>
                  setQuantity(Math.max(1, parseInt(e.target.value) || 1))
                }
                className="text-center"
                disabled={!selectedProduct}
              />
            </div>

            <Button
              type="button"
              onClick={agregarItem}
              disabled={!selectedProduct}
              className="h-10"
            >
              <Plus className="mr-1 h-4 w-4" />
              Añadir
            </Button>
          </div>

          {/* === Tabla de Items === */}
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead>Producto</TableHead>
                <TableHead>Cantidad</TableHead>
                <TableHead>Costo Unitario</TableHead>
                <TableHead>Costo Total</TableHead>
                <TableHead>Precio Venta</TableHead>
                <TableHead>Acción</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {items.length === 0 ? (
                <TableRow>
                  <TableCell colSpan={6} className="text-center text-gray-500">
                    No hay productos agregados
                  </TableCell>
                </TableRow>
              ) : (
                items.map((item, index) => (
                  <TableRow key={index}>
                    <TableCell>{item.nombre_producto}</TableCell>
                    <TableCell>
                      <Input
                        type="number"
                        min="1"
                        value={item.cantidad}
                        onChange={(e) =>
                          actualizarItem(index, 'cantidad', e.target.value)
                        }
                        className="w-20"
                      />
                    </TableCell>
                    <TableCell>
                      <Input
                        type="number"
                        step="0.01"
                        value={item.costo_unitario}
                        onChange={(e) =>
                          actualizarItem(
                            index,
                            'costo_unitario',
                            e.target.value,
                          )
                        }
                        className="w-24"
                      />
                    </TableCell>
                    <TableCell className="font-medium">
                      $ {item.costo_total.toFixed(2)}
                    </TableCell>
                    <TableCell>
                      <Input
                        type="number"
                        step="0.01"
                        value={item.precio_venta}
                        onChange={(e) =>
                          actualizarItem(index, 'precio_venta', e.target.value)
                        }
                        className="w-24"
                      />
                    </TableCell>
                    <TableCell>
                      <Button
                        variant="destructive"
                        size="sm"
                        onClick={() => eliminarItem(index)}
                      >
                        <X className="h-4 w-4" />
                      </Button>
                    </TableCell>
                  </TableRow>
                ))
              )}
            </TableBody>
          </Table>

          {/* === Totales === */}
          {items.length > 0 && (
            <div className="space-y-2 border-t pt-4 text-right text-lg font-bold">
              <div>
                Total Compra:{' '}
                <span className="text-green-600">
                  ${totalCompra.toFixed(2)}
                </span>
              </div>
              <div>
                Abonado:{' '}
                <span className="text-blue-600">
                  ${abonadoInput.toFixed(2)}
                </span>
              </div>
              <div
                className={cn(saldo > 0 ? 'text-red-600' : 'text-green-600')}
              >
                Saldo: ${saldo.toFixed(2)}
              </div>
            </div>
          )}

          {/* === Enviar === */}
          <div className="flex justify-end">
            <Button type="submit" disabled={!proveedorId || items.length === 0}>
              Guardar Compra
            </Button>
          </div>
        </form>
      </div>
    </AppLayout>
  );
}

// import AppLayout from '@/layouts/app-layout';
// import { type BreadcrumbItem } from '@/types';
// import { Head } from '@inertiajs/react';

// const breadcrumbs: BreadcrumbItem[] = [
//   {
//     title: 'Compras',
//     href: '/compras',
//   },
// ];

// export default function Crear() {
//   return (
//     <AppLayout breadcrumbs={breadcrumbs}>
//       <Head title="Compras" />
//     </AppLayout>
//   );
// }
