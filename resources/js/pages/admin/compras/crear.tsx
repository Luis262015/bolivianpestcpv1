import { Button } from '@/components/ui/button';
import {
  Command,
  CommandEmpty,
  CommandGroup,
  CommandInput,
  CommandItem,
  CommandList,
} from '@/components/ui/command';
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
  Popover,
  PopoverContent,
  PopoverTrigger,
} from '@/components/ui/popover';
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select'; // ← Select de shadcn
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
import { Head, router } from '@inertiajs/react';
import axios from 'axios';
import { Check, ChevronsUpDown, Plus, X } from 'lucide-react';
import { useEffect, useMemo, useState } from 'react';

const breadcrumbs: BreadcrumbItem[] = [
  { title: 'Compras', href: 'compras/create' },
];

// === Interfaces ===
interface Proveedor {
  id: number;
  nombre: string;
  direccion: string;
  telefono: string;
  email: string;
  contacto: string;
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

export default function Compra({ proveedores: proveedoresIniciales }: Props) {
  const [open, setOpen] = useState(false);
  const [query, setQuery] = useState('');
  const [searchResults, setSearchResults] = useState<Producto[]>([]);
  const [selectedProduct, setSelectedProduct] = useState<Producto | null>(null);
  const [loading, setLoading] = useState(false);
  const [quantity, setQuantity] = useState(1);
  const [items, setItems] = useState<ItemCompra[]>([]);
  const [proveedorId, setProveedorId] = useState<string>(''); // ← string para Select
  // const [proveedorId, setProveedorId] = useState<number | null>(null);
  // const [abonadoInput, setAbonadoInput] = useState(0);

  const [savingProveedor, setSavingProveedor] = useState(false);

  const [proveedorForm, setProveedorForm] = useState({
    nombre: '',
    direccion: '',
    telefono: '',
    email: '',
    contacto: '',
  });
  const guardarProveedor = async () => {
    if (!proveedorForm.nombre) {
      alert('El nombre del proveedor es obligatorio');
      return;
    }

    try {
      setSavingProveedor(true);

      const response = await axios.post(
        '/proveedores/storemodal',
        proveedorForm,
      );

      const nuevoProveedor: Proveedor = response.data;

      // Actualiza la lista
      setProveedores((prev) => [...prev, nuevoProveedor]);

      // Selecciona el nuevo proveedor
      setProveedorId(String(nuevoProveedor.id));

      // Limpia formulario y cierra modal
      setProveedorForm({
        nombre: '',
        direccion: '',
        telefono: '',
        email: '',
        contacto: '',
      });

      setModalOpen(false);
    } catch (error) {
      console.error(error);
      alert('Error al guardar proveedor');
    } finally {
      setSavingProveedor(false);
    }
  };

  // Estado para la lista de proveedores (se actualizará al crear uno nuevo)
  const [proveedores, setProveedores] =
    useState<Proveedor[]>(proveedoresIniciales);
  // === Estado del modal de proveedor ===
  const [modalOpen, setModalOpen] = useState(false);

  // Callback cuando se crea el proveedor
  // const handleProveedorCreado = (nuevo: { id: number; nombre: string }) => {
  //   console.log('************************ CREADO ********************');
  //   setProveedores((prev) => [...prev, nuevo]);
  //   setProveedorId(String(nuevo.id)); // lo selecciona automáticamente
  // };

  // const { data, setData, errors } = useForm<CompraFormData>({
  //   proveedor_id: null,
  //   items: [],
  // });

  //   // === Búsqueda con debounce ===
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

  // === Cálculos ===
  const totalCompra = useMemo(
    () => items.reduce((sum, i) => sum + i.costo_total, 0),
    [items],
  );
  // const saldo = useMemo(
  //   () => Math.max(0, totalCompra - abonadoInput),
  //   [totalCompra, abonadoInput],
  // );

  //   // === Agregar producto ===
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

  //   // === Actualizar item ===
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

  //   // === Enviar formulario ===
  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();

    if (items.length === 0) {
      alert('Selecciona un proveedor y al menos un producto');
      return;
    }

    const payload = {
      proveedor_id: proveedorId,
      total: totalCompra,
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

      <div className="p-6">
        <h1 className="mb-6 text-3xl font-bold">Registro de Compra</h1>

        <form onSubmit={handleSubmit} className="space-y-6">
          {/* === Datos de Factura === */}
          <div className="grid grid-cols-1 gap-4 pb-1 md:grid-cols-2"></div>

          <div className="flex justify-between">
            {/* === Búsqueda de Producto === */}
            <div className="flex items-end gap-3 pb-4">
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

            {/* === Proveedor con Select de shadcn + botón modal === */}
            <div className="space-y-2">
              <Label>Proveedor</Label>
              <div className="flex gap-3">
                <Select value={proveedorId} onValueChange={setProveedorId}>
                  <SelectTrigger className="flex-1">
                    <SelectValue placeholder="Selecciona un proveedor" />
                  </SelectTrigger>
                  <SelectContent>
                    {proveedores.map((p) => (
                      <SelectItem key={p.id} value={String(p.id)}>
                        {p.nombre}
                      </SelectItem>
                    ))}
                  </SelectContent>
                </Select>

                <Button
                  type="button"
                  variant="outline"
                  onClick={() => setModalOpen(true)}
                >
                  <Plus className="mr-2 h-4 w-4" />
                  Agregar
                </Button>
              </div>
            </div>
          </div>

          {/* === Tabla de Items === */}
          <Table className="">
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
                      Bs. {item.costo_total.toFixed(2)}
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
                Total Compra (Bs.):{' '}
                <span className="ms-3 text-green-600">
                  {totalCompra.toFixed(2)}
                </span>
              </div>
            </div>
          )}

          {/* === Guardar === */}
          <div className="flex justify-end">
            <Button type="submit" disabled={items.length === 0}>
              Guardar Compra
            </Button>
          </div>
        </form>
      </div>
      {/* ===== MODAL PROVEEDOR ===== */}
      <Dialog open={modalOpen} onOpenChange={setModalOpen}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>Nuevo Proveedor</DialogTitle>
          </DialogHeader>

          <div className="space-y-3">
            {Object.entries(proveedorForm).map(([key, value]) => (
              <Input
                key={key}
                placeholder={key}
                value={value}
                onChange={(e) =>
                  setProveedorForm({
                    ...proveedorForm,
                    [key]: e.target.value,
                  })
                }
              />
            ))}
          </div>

          <DialogFooter>
            <Button variant="outline" onClick={() => setModalOpen(false)}>
              Cancelar
            </Button>
            <Button onClick={guardarProveedor} disabled={savingProveedor}>
              {savingProveedor ? 'Guardando...' : 'Guardar'}
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </AppLayout>
  );
}
