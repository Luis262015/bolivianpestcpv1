import AppLayout from '@/layouts/app-layout';
import { type BreadcrumbItem } from '@/types';
import { Head, useForm } from '@inertiajs/react';

import { Button } from '@/components/ui/button';
import {
  Command,
  CommandGroup,
  CommandInput,
  CommandItem,
} from '@/components/ui/command';
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
} from '@/components/ui/select';
import { cn } from '@/lib/utils';
import { router } from '@inertiajs/react';
import axios from 'axios';
import { Check, ChevronsUpDown, Plus, X } from 'lucide-react';
import { useEffect, useMemo, useState } from 'react';

const breadcrumbs: BreadcrumbItem[] = [
  { title: 'Ventas', href: '/ventas' },
  { title: 'Hacer Venta', href: '/ventas/create' },
];

interface Product {
  id: number;
  nombre: string;
  precio_venta: number;
}

interface SaleItem extends Product {
  quantity: number;
}

interface Cliente {
  id: number;
  nombres: string;
}

export default function Venta() {
  const [open, setOpen] = useState(false);
  const [query, setQuery] = useState('');
  const [searchResults, setSearchResults] = useState<Product[]>([]);
  const [selectedProduct, setSelectedProduct] = useState<Product | null>(null);
  const [loading, setLoading] = useState(false);
  const [quantity, setQuantity] = useState(1);
  const [saleItems, setSaleItems] = useState<SaleItem[]>([]);

  // Nuevos estados
  const [autorizacion, setAutorizacion] = useState('');
  const [control, setControl] = useState('');
  const [numero, setNumero] = useState('');
  const [iva, setIva] = useState(0);
  const [aCuenta, setACuenta] = useState(0);
  const [metodoPago, setMetodoPago] = useState('');

  // Buscador de clientes
  const [openCliente, setOpenCliente] = useState(false);
  const [queryCliente, setQueryCliente] = useState('');
  const [searchResultsCliente, setSearchResultsCliente] = useState<Cliente[]>(
    [],
  );
  const [selectedCliente, setSelectedCliente] = useState<Cliente | null>(null);
  const [loadingCliente, setLoadingCliente] = useState(false);

  // Inertia Form
  const { post, processing, errors } = useForm();

  // Búsqueda con debounce
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

  // Búsqueda de clientes
  useEffect(() => {
    if (queryCliente.length < 2) {
      setSearchResultsCliente([]);
      return;
    }

    const delayDebounce = setTimeout(async () => {
      setLoadingCliente(true);
      try {
        const { data } = await axios.get(`/clientes/search?q=${queryCliente}`);
        setSearchResultsCliente(data);
      } catch (error) {
        console.error('Error al buscar clientes:', error);
      } finally {
        setLoadingCliente(false);
      }
    }, 300);

    return () => clearTimeout(delayDebounce);
  }, [queryCliente]);

  // Agregar producto
  const handleAddProduct = () => {
    if (!selectedProduct || quantity <= 0) return;

    const existingIndex = saleItems.findIndex(
      (i) => i.id === selectedProduct.id,
    );
    if (existingIndex !== -1) {
      const updated = [...saleItems];
      updated[existingIndex].quantity += quantity;
      setSaleItems(updated);
    } else {
      setSaleItems([...saleItems, { ...selectedProduct, quantity }]);
    }

    setSelectedProduct(null);
    setQuery('');
    setSearchResults([]);
    setQuantity(1);
    setOpen(false);
  };

  const handleRemoveProduct = (id: number) => {
    setSaleItems(saleItems.filter((i) => i.id !== id));
  };

  // Cálculos
  const subtotal = useMemo(() => {
    return saleItems.reduce(
      (sum, item) => sum + item.precio_venta * item.quantity,
      0,
    );
  }, [saleItems]);

  const total = subtotal + iva;
  const saldo = total - aCuenta;

  // handleSubmit actualizado
  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();

    if (saleItems.length === 0 || !metodoPago || !selectedCliente) {
      alert('Agrega productos, selecciona método de pago y un cliente');
      return;
    }

    const payload = {
      cliente_id: selectedCliente.id,
      numero,
      autorizacion,
      control,
      iva,
      subtotal,
      abonado: aCuenta,
      saldo,
      metodo_pago: metodoPago,
      total,
      items: saleItems.map((i) => ({
        producto_id: i.id,
        cantidad: i.quantity,
        precio_unitario: i.precio_venta,
        subtotal: i.precio_venta * i.quantity,
      })),
    };

    router.post('/ventas', payload, {
      onSuccess: () => {
        alert('Venta guardada exitosamente');
        setSaleItems([]);
        setAutorizacion('');
        setControl('');
        setNumero('');
        setIva(0);
        setACuenta(0);
        setMetodoPago('');
        setSelectedCliente(null);
        setQueryCliente('');
      },
      onError: (errors) => {
        console.error('Errores:', errors);
      },
    });
  };

  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Ventas | Crear" />
      <form
        onSubmit={handleSubmit}
        className="mx-auto max-w-3xl space-y-6 rounded-lg border p-6 shadow-lg"
      >
        <h2 className="text-2xl font-bold">Hacer Venta</h2>

        {/* BUSCADOR DE CLIENTE */}
        <div className="flex items-end gap-2 border-b pb-4">
          <div className="flex-grow">
            <Label>Buscar Cliente *</Label>
            <Popover open={openCliente} onOpenChange={setOpenCliente}>
              <PopoverTrigger asChild>
                <Button variant="outline" className="w-full justify-between">
                  {selectedCliente
                    ? `${selectedCliente.nombres}`
                    : 'Buscar cliente...'}
                  <ChevronsUpDown className="ml-2 h-4 w-4 opacity-50" />
                </Button>
              </PopoverTrigger>
              <PopoverContent className="w-full p-0">
                <Command shouldFilter={false}>
                  <CommandInput
                    placeholder="Nombre, CI o teléfono..."
                    value={queryCliente}
                    onValueChange={setQueryCliente}
                  />
                  <CommandGroup className="max-h-60 overflow-auto">
                    {loadingCliente && (
                      <div className="p-3 text-sm">Buscando...</div>
                    )}
                    {!loadingCliente &&
                      searchResultsCliente.length === 0 &&
                      queryCliente.length >= 2 && (
                        <div className="p-3 text-sm">Sin resultados</div>
                      )}
                    {searchResultsCliente.map((cliente) => (
                      <CommandItem
                        key={cliente.id}
                        onSelect={() => {
                          setSelectedCliente(cliente);
                          setQueryCliente(cliente.nombres);
                          setOpenCliente(false);
                        }}
                      >
                        <Check
                          className={cn(
                            'mr-2 h-4 w-4',
                            selectedCliente?.id === cliente.id
                              ? 'opacity-100'
                              : 'opacity-0',
                          )}
                        />
                        <div>
                          <p>{cliente.nombres}</p>
                        </div>
                      </CommandItem>
                    ))}
                  </CommandGroup>
                </Command>
              </PopoverContent>
            </Popover>
          </div>
          {selectedCliente && (
            <Button
              type="button"
              variant="ghost"
              size="icon"
              onClick={() => {
                setSelectedCliente(null);
                setQueryCliente('');
              }}
            >
              <X className="h-4 w-4" />
            </Button>
          )}
        </div>

        {/* 1. Búsqueda de Producto */}
        <div className="flex items-end gap-2 border-b pb-4">
          <div className="flex-grow">
            <Label>Buscar Producto</Label>
            <Popover open={open} onOpenChange={setOpen}>
              <PopoverTrigger asChild>
                <Button variant="outline" className="w-full justify-between">
                  {selectedProduct ? selectedProduct.nombre : 'Buscar...'}
                  <ChevronsUpDown className="ml-2 h-4 w-4 opacity-50" />
                </Button>
              </PopoverTrigger>
              <PopoverContent className="w-full p-0">
                <Command shouldFilter={false}>
                  <CommandInput
                    placeholder="Nombre del producto..."
                    value={query}
                    onValueChange={setQuery}
                  />
                  <CommandGroup className="max-h-60 overflow-auto">
                    {loading && <div className="p-3 text-sm">Buscando...</div>}
                    {!loading &&
                      searchResults.length === 0 &&
                      query.length >= 2 && (
                        <div className="p-3 text-sm">Sin resultados</div>
                      )}
                    {searchResults.map((p) => (
                      <CommandItem
                        key={p.id}
                        onSelect={() => {
                          setSelectedProduct(p);
                          setQuery(p.nombre);
                          setOpen(false);
                        }}
                      >
                        <Check
                          className={cn(
                            'mr-2 h-4 w-4',
                            selectedProduct?.id === p.id
                              ? 'opacity-100'
                              : 'opacity-0',
                          )}
                        />
                        {p.nombre} — ${p.precio_venta.toFixed(2)}
                      </CommandItem>
                    ))}
                  </CommandGroup>
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
              onChange={(e) => setQuantity(Math.max(1, Number(e.target.value)))}
              disabled={!selectedProduct}
            />
          </div>

          <Button
            type="button"
            onClick={handleAddProduct}
            disabled={!selectedProduct}
          >
            <Plus className="mr-1 h-4 w-4" /> Añadir
          </Button>
        </div>

        {/* 2. Detalle de Venta */}
        <div>
          <h3 className="mb-3 text-xl font-semibold">Detalle</h3>
          {saleItems.length === 0 ? (
            <p className="text-gray-500 italic">Sin productos</p>
          ) : (
            <ul className="divide-y rounded border">
              {saleItems.map((item) => (
                <li
                  key={item.id}
                  className="flex items-center justify-between p-3"
                >
                  <div>
                    <p className="font-medium">{item.nombre}</p>
                    <p className="text-sm text-gray-600">
                      {item.quantity} × ${item.precio_venta.toFixed(2)} = $
                      {(item.quantity * item.precio_venta).toFixed(2)}
                    </p>
                  </div>
                  <Button
                    type="button"
                    variant="ghost"
                    size="icon"
                    onClick={() => handleRemoveProduct(item.id)}
                  >
                    <X className="h-4 w-4 text-red-500" />
                  </Button>
                </li>
              ))}
            </ul>
          )}
        </div>

        {/* 3. Campos adicionales */}
        <div className="grid grid-cols-1 gap-4 sm:grid-cols-3">
          <div>
            <Label>Autorización</Label>
            <Input
              value={autorizacion}
              onChange={(e) => setAutorizacion(e.target.value)}
              placeholder="Opcional"
            />
          </div>
          <div>
            <Label>Control</Label>
            <Input
              value={control}
              onChange={(e) => setControl(e.target.value)}
              placeholder="Opcional"
            />
          </div>
          <div>
            <Label>Número</Label>
            <Input
              value={numero}
              onChange={(e) => setNumero(e.target.value)}
              placeholder="Opcional"
            />
          </div>
        </div>

        {/* 4. IVA y Totales */}
        <div className="space-y-4 rounded border p-4">
          <div className="grid grid-cols-2 gap-4 sm:grid-cols-4">
            <div>
              <Label>Subtotal</Label>
              <p className="font-semibold">${subtotal.toFixed(2)}</p>
            </div>
            <div>
              <Label>IVA</Label>
              <Input
                type="number"
                min="0"
                step="0.01"
                value={iva}
                onChange={(e) => setIva(Number(e.target.value))}
              />
            </div>
            <div>
              <Label>Total</Label>
              <p className="text-lg font-bold text-green-600">
                ${total.toFixed(2)}
              </p>
            </div>
            <div>
              <Label>Saldo</Label>
              <p
                className={cn(
                  'font-bold',
                  saldo < 0 ? 'text-red-600' : 'text-blue-600',
                )}
              >
                ${saldo.toFixed(2)}
              </p>
            </div>
          </div>

          <div className="grid grid-cols-1 gap-4 sm:grid-cols-2">
            <div>
              <Label>A cuenta</Label>
              <Input
                type="number"
                min="0"
                step="0.01"
                value={aCuenta}
                onChange={(e) => setACuenta(Number(e.target.value))}
              />
            </div>
            <div>
              <Label>Método de Pago</Label>
              <Select value={metodoPago} onValueChange={setMetodoPago}>
                <SelectTrigger>
                  <SelectValue placeholder="Seleccionar..." />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="Efectivo">Efectivo</SelectItem>
                  <SelectItem value="Tarjeta">Tarjeta</SelectItem>
                  <SelectItem value="Billetera Movil">
                    Billetera Móvil
                  </SelectItem>
                  <SelectItem value="Transferencia">Transferencia</SelectItem>
                </SelectContent>
              </Select>
            </div>
          </div>
        </div>

        {/* Errores */}
        {/* {errors.items && <p className="text-sm text-red-600">{errors.items}</p>}
        {errors.metodo_pago && (
          <p className="text-sm text-red-600">{errors.metodo_pago}</p>
        )} */}

        {/* Botón Enviar */}
        <Button
          type="submit"
          className="w-full"
          disabled={saleItems.length === 0 || processing || !metodoPago}
        >
          {processing
            ? 'Guardando...'
            : `Completar Venta (${saleItems.length} producto${saleItems.length !== 1 ? 's' : ''})`}
        </Button>
      </form>
    </AppLayout>
  );
}
