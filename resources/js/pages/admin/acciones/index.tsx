'use client';

import AppLayout from '@/layouts/app-layout';
import { type BreadcrumbItem } from '@/types';
import { Head, useForm } from '@inertiajs/react';
import { useEffect, useState } from 'react';

import { Button } from '@/components/ui/button';
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from '@/components/ui/dialog';
import { Input } from '@/components/ui/input';
import { Textarea } from '@/components/ui/textarea';

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

import {
  Command,
  CommandEmpty,
  CommandGroup,
  CommandInput,
  CommandItem,
  CommandList,
} from '@/components/ui/command';

import axios from 'axios';

const breadcrumbs: BreadcrumbItem[] = [
  {
    title: 'Acciones Complementarias',
    href: '/acciones',
  },
];

type ProductoUtilizado = {
  producto_id: string;
  producto_nombre?: string; // 👈 NUEVO
  cantidad: string;
};

type Trampa = {
  trampa_codigo: string;
  trampa_tipo_id: string;
};

interface Props {
  acciones: any;
  empresas: any[];
  almacenes: any[];
  trampaTipos: any[];
  // productos: any[]; // 👈 NUEVO
}

export default function Lista({
  acciones,
  empresas,
  almacenes,
  trampaTipos,
  // productos,
}: Props) {
  const [open, setOpen] = useState(false);
  const [editing, setEditing] = useState<any>(null);

  const [query, setQuery] = useState('');
  const [searchResults, setSearchResults] = useState<any[]>([]);
  const [loading, setLoading] = useState(false);
  const [openProductoIndex, setOpenProductoIndex] = useState<number | null>(
    null,
  );

  const [imagenesExistentes, setImagenesExistentes] = useState<any[]>([]);
  // const [openProductoIndex, setOpenProductoIndex] = useState<number | null>(
  //   null,
  // );

  const {
    data,
    setData,
    post,
    put,
    delete: destroy,
    reset,
  } = useForm({
    empresa_id: '',
    almacen_id: '',
    descripcion: '',
    costo: '',
    trampas: [] as Trampa[],
    productos: [] as ProductoUtilizado[], // 👈 NUEVO
    imagenes: [] as File[], // 👈 NUEVO
  });

  const submit = (e: any) => {
    e.preventDefault();

    if (editing) {
      put(`/acciones/${editing.id}`, {
        forceFormData: true,
        onSuccess: () => {
          reset();
          setEditing(null);
          setOpen(false);
        },
      });
    } else {
      post('/acciones', {
        forceFormData: true,
        onSuccess: () => {
          reset();
          setOpen(false);
        },
      });
    }
  };

  const editAccion = (accion: any) => {
    setEditing(accion);
    setData({
      empresa_id: accion.empresa_id,
      almacen_id: accion.almacen_id,
      descripcion: accion.descripcion,
      costo: accion.costo,
      // trampas: accion.trampas.map((t: any) => ({
      //   trampa_codigo: t.trampa_codigo,
      //   trampa_tipo_id: t.trampa_tipo_id,
      // })),
      trampas:
        accion.trampas?.map((t: any) => ({
          trampa_codigo: t.trampa_codigo,
          trampa_tipo_id: t.trampa_tipo_id,
        })) ?? [],
      productos:
        accion.productos?.map((p: any) => ({
          producto_id: p.id.toString(),
          producto_nombre: p.nombre, // 👈 IMPORTANTE
          cantidad: p.pivot?.cantidad ?? '',
        })) ?? [],
    });
    setImagenesExistentes(accion.imagenes ?? []);
    setOpen(true);
  };

  const addTrampa = () => {
    setData('trampas', [
      ...data.trampas,
      { trampa_codigo: '', trampa_tipo_id: '' },
    ]);
  };

  const removeTrampa = (index: number) => {
    const nuevas = [...data.trampas];
    nuevas.splice(index, 1);
    setData('trampas', nuevas);
  };

  const updateTrampa = (index: number, field: keyof Trampa, value: string) => {
    const nuevas = [...data.trampas];
    nuevas[index][field] = value;
    setData('trampas', nuevas);
  };

  const addProducto = () => {
    setData('productos', [
      ...data.productos,
      { producto_id: '', producto_nombre: '', cantidad: '' },
    ]);
  };

  const removeProducto = (index: number) => {
    const nuevos = [...data.productos];
    nuevos.splice(index, 1);
    setData('productos', nuevos);
  };

  const updateProducto = <K extends keyof ProductoUtilizado>(
    index: number,
    field: K,
    value: ProductoUtilizado[K],
  ) => {
    const nuevos = [...data.productos];
    nuevos[index][field] = value;
    setData('productos', nuevos);
  };

  // 🔎 Búsqueda de productos con debounce
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

  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Acciones Complementarias" />

      <div className="space-y-4 p-6">
        <Dialog open={open} onOpenChange={setOpen}>
          <DialogTrigger asChild>
            <Button>Nueva Acción</Button>
          </DialogTrigger>

          <DialogContent>
            <DialogHeader>
              <DialogTitle>
                {editing ? 'Editar Acción' : 'Nueva Acción'}
              </DialogTitle>
            </DialogHeader>

            <form onSubmit={submit} className="space-y-4">
              <select
                className="w-full rounded border p-2"
                value={data.empresa_id}
                onChange={(e) => setData('empresa_id', e.target.value)}
              >
                <option value="">Seleccione Empresa</option>
                {empresas.map((e) => (
                  <option key={e.id} value={e.id}>
                    {e.nombre}
                  </option>
                ))}
              </select>

              <select
                className="w-full rounded border p-2"
                value={data.almacen_id}
                onChange={(e) => setData('almacen_id', e.target.value)}
              >
                <option value="">Seleccione Almacén</option>
                {almacenes.map((a) => (
                  <option key={a.id} value={a.id}>
                    {a.nombre}
                  </option>
                ))}
              </select>

              <Textarea
                placeholder="Descripción"
                value={data.descripcion}
                onChange={(e) => setData('descripcion', e.target.value)}
              />

              <Input
                type="number"
                step="0.01"
                placeholder="Costo"
                value={data.costo}
                onChange={(e) => setData('costo', e.target.value)}
              />

              <div className="space-y-3 rounded border p-3">
                <div className="flex items-center justify-between">
                  <h3 className="font-semibold">Trampas</h3>
                  <Button type="button" size="sm" onClick={addTrampa}>
                    Agregar
                  </Button>
                </div>

                {data.trampas.map((trampa, index) => (
                  <div
                    key={index}
                    className="grid grid-cols-3 items-end gap-2 rounded border p-2"
                  >
                    <Input
                      placeholder="ID TRAMPA"
                      value={trampa.trampa_codigo}
                      onChange={(e) =>
                        updateTrampa(index, 'trampa_codigo', e.target.value)
                      }
                    />

                    <select
                      className="rounded border p-2"
                      value={trampa.trampa_tipo_id}
                      onChange={(e) =>
                        updateTrampa(index, 'trampa_tipo_id', e.target.value)
                      }
                    >
                      <option value="">Tipo</option>
                      {trampaTipos.map((tipo) => (
                        <option key={tipo.id} value={tipo.id}>
                          {tipo.nombre}
                        </option>
                      ))}
                    </select>

                    <Button
                      type="button"
                      variant="destructive"
                      size="sm"
                      onClick={() => removeTrampa(index)}
                    >
                      X
                    </Button>
                  </div>
                ))}
              </div>

              <div className="space-y-4 border-t pt-4">
                <div className="flex items-center justify-between">
                  <h3 className="font-semibold">Productos Utilizados</h3>
                  <Button type="button" size="sm" onClick={addProducto}>
                    Agregar
                  </Button>
                </div>

                {data.productos.map((producto, index) => (
                  <div key={index} className="flex items-start gap-2">
                    {/* Selector con buscador */}
                    <Popover
                      open={openProductoIndex === index}
                      onOpenChange={(o) => {
                        setOpenProductoIndex(o ? index : null);
                        if (!o) {
                          setQuery('');
                          setSearchResults([]);
                        }
                      }}
                    >
                      <PopoverTrigger asChild>
                        <Button
                          type="button"
                          variant="outline"
                          role="combobox"
                          className="w-64 justify-between"
                        >
                          {producto.producto_nombre || 'Seleccionar producto'}
                        </Button>
                      </PopoverTrigger>

                      <PopoverContent className="w-64 p-0">
                        <Command>
                          <CommandInput
                            placeholder="Buscar producto..."
                            value={query}
                            onValueChange={(value) => setQuery(value)}
                          />

                          <CommandList>
                            {loading && (
                              <div className="p-2 text-sm text-muted-foreground">
                                Buscando...
                              </div>
                            )}

                            {!loading &&
                              searchResults.length === 0 &&
                              query.length >= 2 && (
                                <CommandEmpty>
                                  No se encontraron productos
                                </CommandEmpty>
                              )}

                            <CommandGroup>
                              {searchResults.map((p) => (
                                <CommandItem
                                  key={p.id}
                                  value={p.nombre}
                                  onSelect={() => {
                                    updateProducto(
                                      index,
                                      'producto_id',
                                      p.id.toString(),
                                    );
                                    updateProducto(
                                      index,
                                      'producto_nombre',
                                      p.nombre,
                                    ); // 👈 NUEVO

                                    setQuery('');
                                    setSearchResults([]);
                                    setOpenProductoIndex(null);
                                  }}
                                >
                                  {p.nombre}
                                </CommandItem>
                              ))}
                            </CommandGroup>
                          </CommandList>
                        </Command>
                      </PopoverContent>
                    </Popover>

                    {/* Cantidad */}
                    <Input
                      type="number"
                      placeholder="Cantidad"
                      value={producto.cantidad}
                      onChange={(e) =>
                        updateProducto(index, 'cantidad', e.target.value)
                      }
                      className="w-32"
                    />

                    <Button
                      type="button"
                      variant="destructive"
                      onClick={() => removeProducto(index)}
                    >
                      X
                    </Button>
                  </div>
                ))}
              </div>

              <div className="space-y-2 border-t pt-4">
                <h3 className="font-semibold">Imágenes</h3>

                <Input
                  type="file"
                  multiple
                  accept="image/*"
                  onChange={(e) => {
                    if (e.target.files) {
                      setData('imagenes', Array.from(e.target.files));
                    }
                  }}
                />
                {imagenesExistentes.length > 0 && (
                  <div className="grid grid-cols-3 gap-2">
                    {imagenesExistentes.map((img) => (
                      <img
                        key={img.id}
                        src={`/storage/${img.imagen}`}
                        className="h-24 w-full rounded object-cover"
                      />
                    ))}
                  </div>
                )}
              </div>

              <Button type="submit" className="w-full">
                Guardar
              </Button>
            </form>
          </DialogContent>
        </Dialog>

        {/* TABLA */}

        <Table>
          <TableHeader>
            <TableRow>
              <TableHead>Empresa</TableHead>
              <TableHead>Almacén</TableHead>
              <TableHead>Descripción</TableHead>
              <TableHead>Costo</TableHead>
              <TableHead>Acciones</TableHead>
            </TableRow>
          </TableHeader>

          <TableBody>
            {acciones.data.map((accion: any) => (
              <TableRow key={accion.id}>
                <TableCell>{accion.empresa.nombre}</TableCell>
                <TableCell>{accion.almacen.nombre}</TableCell>
                <TableCell
                  className="max-w-[200px] truncate"
                  title={accion.descripcion}
                >
                  {accion.descripcion}
                </TableCell>
                <TableCell>{accion.costo}</TableCell>
                <TableCell className="space-x-2">
                  <Button size="sm" onClick={() => editAccion(accion)}>
                    Editar
                  </Button>
                  <Button
                    size="sm"
                    variant="destructive"
                    onClick={() => destroy(`/acciones/${accion.id}`)}
                  >
                    Eliminar
                  </Button>
                </TableCell>
              </TableRow>
            ))}
          </TableBody>
        </Table>

        {/* PAGINACIÓN SIMPLE */}
        <div className="flex gap-2">
          {acciones.links.map((link: any, i: number) => (
            <Button
              key={i}
              variant={link.active ? 'default' : 'outline'}
              disabled={!link.url}
              onClick={() => link.url && window.location.assign(link.url)}
              dangerouslySetInnerHTML={{ __html: link.label }}
            />
          ))}
        </div>
      </div>
    </AppLayout>
  );
}
// ---------------------------------------------------
// import AppLayout from '@/layouts/app-layout';
// import { type BreadcrumbItem } from '@/types';
// import { Head } from '@inertiajs/react';

// const breadcrumbs: BreadcrumbItem[] = [
//   {
//     title: 'Acciones Complementarias',
//     href: '/acciones',
//   },
// ];

// export default function Lista() {
//   return (
//     <AppLayout breadcrumbs={breadcrumbs}>
//       <Head title="Acciones Complementarias" />
//     </AppLayout>
//   );
// }
