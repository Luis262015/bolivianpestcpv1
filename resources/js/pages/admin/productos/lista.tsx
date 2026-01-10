import AppLayout from '@/layouts/app-layout';
import { type BreadcrumbItem } from '@/types';
import { Head, Link, router, useForm, usePage } from '@inertiajs/react';
import { useEffect, useState } from 'react';

import CustomPagination from '@/components/CustomPagination';
import { Button } from '@/components/ui/button';
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
} from '@/components/ui/dialog';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from '@/components/ui/table';
import { CalendarClock, FileText, Plus, SquarePen, Trash2 } from 'lucide-react';
import { toast } from 'sonner';

const breadcrumbs: BreadcrumbItem[] = [
  { title: 'Productos', href: '/productos' },
];

interface Categoria {
  id: number;
  nombre: string;
}
interface Subcategoria {
  id: number;
  nombre: string;
}
interface Marca {
  id: number;
  nombre: string;
}

interface Producto {
  id: number;
  nombre: string;
  categoria: Categoria;
  subcategoria: Subcategoria;
  marca: Marca;
  stock: number;
}

interface ProductoVencimiento {
  id: number;
  codigo: string;
  vencimiento: string; // formato YYYY-MM-DD
}

interface HojaTecnica {
  id: number;
  titulo: string;
  archivo: string;
  url?: string; // url pública del archivo
}

interface ProductosPaginate {
  data: Producto[];
  links: { url: string | null; label: string; active: boolean }[];
}

export default function Index() {
  const { processing, delete: destroy } = useForm();
  const { productos } = usePage<{ productos: ProductosPaginate }>().props;

  // Estados comunes
  const [selectedProductoId, setSelectedProductoId] = useState<number | null>(
    null,
  );

  // Vencimientos
  const [openVencimientos, setOpenVencimientos] = useState(false);
  const [vencimientos, setVencimientos] = useState<ProductoVencimiento[]>([]);
  const vencimientoForm = useForm({ codigo: '', vencimiento: '' });

  // Hojas Técnicas
  const [openHojas, setOpenHojas] = useState(false);
  const [hojasTecnicas, setHojasTecnicas] = useState<HojaTecnica[]>([]);
  const [selectedFileName, setSelectedFileName] = useState('');
  const hojaForm = useForm({ titulo: '', archivo: null as File | null });

  // Cargar datos al abrir cada modal
  useEffect(() => {
    if (openVencimientos && selectedProductoId) {
      router.get(
        `/productos/${selectedProductoId}/vencimientos`,
        {},
        {
          preserveState: true,
          only: ['vencimientos'],
          onSuccess: (page: any) => {
            setVencimientos(page.props.vencimientos || []);
          },
          onError: () => toast.error('No se pudieron cargar los vencimientos'),
        },
      );
    }
  }, [openVencimientos, selectedProductoId]);

  useEffect(() => {
    if (openHojas && selectedProductoId) {
      router.get(
        `/productos/${selectedProductoId}/hojas-tecnicas`,
        {},
        {
          preserveState: true,
          only: ['hojas_tecnicas'],
          onSuccess: (page: any) => {
            setHojasTecnicas(page.props.hojas_tecnicas || []);
          },
          onError: () =>
            toast.error('No se pudieron cargar las hojas técnicas'),
        },
      );
    }
  }, [openHojas, selectedProductoId]);

  // ── Producto ────────────────────────────────────────────────────────
  const handleDeleteProducto = (id: number) => {
    if (confirm('¿Estás seguro de eliminar este producto?')) {
      destroy(`/productos/${id}`);
    }
  };

  // ── Vencimientos ────────────────────────────────────────────────────
  const handleSubmitVencimiento = (e: React.FormEvent) => {
    e.preventDefault();
    if (!selectedProductoId) return;

    vencimientoForm.post(`/productos/${selectedProductoId}/vencimientos`, {
      preserveScroll: true,
      onSuccess: () => {
        toast.success('Vencimiento registrado');
        vencimientoForm.reset();

        // // Recargar lista
        // router.reload({ only: ['vencimientos'] });

        // Recarga inteligente
        // router.reload({
        //   only: ['vencimientos'],
        //   // preserveState: true,
        //   // preserveScroll: true,
        //   preserveUrl: true,
        //   onSuccess: (page: any) => {
        //     setVencimientos(page.props.vencimientos || []);
        //   },
        //   onError: () => {
        //     toast.error('Error al recargar vencimientos');
        //   },
        // });

        // Cerramos modal y redirigimos a la lista principal
        setOpenVencimientos(false);
        router.visit('/productos', {
          preserveState: false, // ← importante para recarga completa
          preserveScroll: false,
        });
      },
      onError: () => toast.error('Error al guardar vencimiento'),
    });
  };

  const handleDeleteVencimiento = (id: number) => {
    if (!confirm('¿Eliminar este vencimiento?')) return;

    router.delete(`/productos/${selectedProductoId}/vencimientos/${id}`, {
      preserveScroll: true,
      onSuccess: () => {
        toast.success('Vencimiento eliminado');
        setVencimientos((prev) => prev.filter((v) => v.id !== id));
        // Cerramos modal y redirigimos a la lista principal
        setOpenVencimientos(false);
        router.visit('/productos', {
          preserveState: false, // ← importante para recarga completa
          preserveScroll: false,
        });
      },
    });
  };

  // ── Hojas Técnicas ──────────────────────────────────────────────────
  const handleFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (file) {
      hojaForm.setData('archivo', file);
      setSelectedFileName(file.name);
    }
  };

  const handleSubmitHoja = (e: React.FormEvent) => {
    e.preventDefault();
    if (!selectedProductoId || !hojaForm.data.titulo || !hojaForm.data.archivo)
      return;

    const formData = new FormData();
    formData.append('titulo', hojaForm.data.titulo);
    formData.append('archivo', hojaForm.data.archivo!);

    router.post(`/productos/${selectedProductoId}/hojas-tecnicas`, formData, {
      forceFormData: true,
      preserveScroll: true,
      onSuccess: () => {
        toast.success('Hoja técnica guardada');
        hojaForm.reset();
        setSelectedFileName('');

        // router.reload({ only: ['hojas_tecnicas'] });

        setOpenHojas(false);
        router.visit('/productos', {
          preserveState: false, // ← importante para recarga completa
          preserveScroll: false,
        });
      },
      onError: () => toast.error('Error al guardar hoja técnica'),
    });
  };

  const handleDeleteHoja = (id: number) => {
    if (!confirm('¿Eliminar esta hoja técnica?')) return;

    router.delete(`/productos/${selectedProductoId}/hojas-tecnicas/${id}`, {
      preserveScroll: true,
      onSuccess: () => {
        toast.success('Hoja técnica eliminada');
        setHojasTecnicas((prev) => prev.filter((h) => h.id !== id));

        setOpenHojas(false);
        router.visit('/productos', {
          preserveState: false, // ← importante para recarga completa
          preserveScroll: false,
        });
      },
    });
  };

  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Productos | List" />

      <div className="m-4">
        <div className="mb-6 flex items-center justify-between">
          <h1 className="text-2xl font-bold">Gestión de productos</h1>
          <Link href="/productos/create">
            <Button>
              <Plus className="mr-2 h-4 w-4" /> Nuevo Producto
            </Button>
          </Link>
        </div>

        {productos.data.length === 0 ? (
          <div className="py-10 text-center text-muted-foreground">
            No hay productos registrados aún...
          </div>
        ) : (
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead className="w-[80px]">ID</TableHead>
                <TableHead>Nombre</TableHead>
                <TableHead>Categoría</TableHead>
                <TableHead>Subcategoría</TableHead>
                <TableHead>Marca</TableHead>
                <TableHead>Stock</TableHead>
                <TableHead className="text-right">Acciones</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {productos.data.map((producto) => (
                <TableRow key={producto.id}>
                  <TableCell className="font-medium">{producto.id}</TableCell>
                  <TableCell>{producto.nombre}</TableCell>
                  <TableCell>{producto.categoria?.nombre ?? '—'}</TableCell>
                  <TableCell>{producto.subcategoria?.nombre ?? '—'}</TableCell>
                  <TableCell>{producto.marca?.nombre ?? '—'}</TableCell>
                  <TableCell>{producto.stock ?? '—'}</TableCell>
                  <TableCell className="space-x-1 text-right">
                    <Link href={`/productos/${producto.id}/edit`}>
                      <Button size="icon" variant="outline">
                        <SquarePen className="h-4 w-4" />
                      </Button>
                    </Link>

                    <Button
                      size="icon"
                      variant="outline"
                      onClick={() => {
                        setSelectedProductoId(producto.id);
                        setOpenVencimientos(true);
                      }}
                      title="Vencimientos"
                    >
                      <CalendarClock className="h-4 w-4" />
                    </Button>

                    <Button
                      size="icon"
                      variant="outline"
                      onClick={() => {
                        setSelectedProductoId(producto.id);
                        setOpenHojas(true);
                      }}
                      title="Hojas Técnicas"
                    >
                      <FileText className="h-4 w-4" />
                    </Button>

                    <Button
                      size="icon"
                      variant="destructive"
                      onClick={() => handleDeleteProducto(producto.id)}
                      disabled={processing}
                    >
                      <Trash2 className="h-4 w-4" />
                    </Button>
                  </TableCell>
                </TableRow>
              ))}
            </TableBody>
          </Table>
        )}

        <div className="mt-6">
          <CustomPagination links={productos.links} />
        </div>
      </div>

      {/* ── Diálogo Vencimientos ──────────────────────────────────────── */}
      <Dialog open={openVencimientos} onOpenChange={setOpenVencimientos}>
        <DialogContent className="sm:max-w-[600px]">
          <DialogHeader>
            <DialogTitle>Vencimientos del producto</DialogTitle>
            <DialogDescription>
              Gestión de lotes y fechas de vencimiento
            </DialogDescription>
          </DialogHeader>

          <div className="max-h-[50vh] overflow-y-auto py-4">
            {vencimientos.length === 0 ? (
              <p className="py-8 text-center text-muted-foreground">
                No hay vencimientos registrados
              </p>
            ) : (
              <div className="space-y-2">
                {vencimientos.map((v) => (
                  <div
                    key={v.id}
                    className="flex items-center justify-between rounded-md bg-muted/40 p-3"
                  >
                    <div>
                      <div className="font-medium">{v.codigo}</div>
                      <div className="text-sm text-muted-foreground">
                        Vence: {v.vencimiento}
                      </div>
                    </div>
                    <Button
                      size="icon"
                      variant="ghost"
                      className="text-destructive hover:text-destructive/90"
                      onClick={() => handleDeleteVencimiento(v.id)}
                    >
                      <Trash2 className="h-4 w-4" />
                    </Button>
                  </div>
                ))}
              </div>
            )}
          </div>

          <form
            onSubmit={handleSubmitVencimiento}
            className="space-y-4 border-t pt-4"
          >
            <div className="grid grid-cols-2 gap-4">
              <div className="space-y-2">
                <Label>Código/Lote</Label>
                <Input
                  value={vencimientoForm.data.codigo}
                  onChange={(e) =>
                    vencimientoForm.setData('codigo', e.target.value)
                  }
                  placeholder="Lote 0234"
                />
              </div>
              <div className="space-y-2">
                <Label>Fecha vencimiento</Label>
                <Input
                  type="date"
                  value={vencimientoForm.data.vencimiento}
                  onChange={(e) =>
                    vencimientoForm.setData('vencimiento', e.target.value)
                  }
                />
              </div>
            </div>

            <DialogFooter>
              <Button
                type="button"
                variant="outline"
                onClick={() => setOpenVencimientos(false)}
              >
                Cerrar
              </Button>
              <Button type="submit" disabled={vencimientoForm.processing}>
                {vencimientoForm.processing
                  ? 'Guardando...'
                  : 'Agregar vencimiento'}
              </Button>
            </DialogFooter>
          </form>
        </DialogContent>
      </Dialog>

      {/* ── Diálogo Hojas Técnicas ────────────────────────────────────── */}
      <Dialog open={openHojas} onOpenChange={setOpenHojas}>
        <DialogContent className="sm:max-w-[700px]">
          <DialogHeader>
            <DialogTitle>Hojas Técnicas / Fichas técnicas</DialogTitle>
            <DialogDescription>
              Documentos, especificaciones y certificados
            </DialogDescription>
          </DialogHeader>

          <div className="max-h-[50vh] overflow-y-auto py-4">
            {hojasTecnicas.length === 0 ? (
              <p className="py-8 text-center text-muted-foreground">
                No hay hojas técnicas cargadas
              </p>
            ) : (
              <div className="space-y-2">
                {hojasTecnicas.map((h) => (
                  <div
                    key={h.id}
                    className="flex items-center justify-between rounded-md bg-muted/40 p-3"
                  >
                    <div>
                      <div className="font-medium">{h.titulo}</div>
                      <div className="flex items-center gap-2 text-sm text-muted-foreground">
                        <span>{h.archivo}</span>
                        {h.url && (
                          <a
                            href={h.url}
                            target="_blank"
                            rel="noopener noreferrer"
                            className="text-xs text-primary hover:underline"
                          >
                            Ver archivo
                          </a>
                        )}
                      </div>
                    </div>
                    <Button
                      size="icon"
                      variant="ghost"
                      className="text-destructive hover:text-destructive/90"
                      onClick={() => handleDeleteHoja(h.id)}
                    >
                      <Trash2 className="h-4 w-4" />
                    </Button>
                  </div>
                ))}
              </div>
            )}
          </div>

          <form onSubmit={handleSubmitHoja} className="space-y-4 border-t pt-4">
            <div className="space-y-2">
              <Label>Título / Descripción</Label>
              <Input
                value={hojaForm.data.titulo}
                onChange={(e) => hojaForm.setData('titulo', e.target.value)}
                placeholder="Ficha técnica - Especificaciones 2025"
              />
            </div>

            <div className="space-y-2">
              <Label>Archivo</Label>
              <div className="flex items-center gap-3">
                <Button type="button" variant="outline" asChild>
                  <label className="cursor-pointer">
                    Seleccionar archivo
                    <input
                      type="file"
                      className="hidden"
                      accept=".pdf,.jpg,.jpeg,.png"
                      onChange={handleFileChange}
                    />
                  </label>
                </Button>
                {selectedFileName && (
                  <span className="max-w-[300px] truncate text-sm text-muted-foreground">
                    {selectedFileName}
                  </span>
                )}
              </div>
            </div>

            <DialogFooter>
              <Button
                type="button"
                variant="outline"
                onClick={() => setOpenHojas(false)}
              >
                Cerrar
              </Button>
              <Button
                type="submit"
                disabled={
                  hojaForm.processing ||
                  !hojaForm.data.titulo ||
                  !hojaForm.data.archivo
                }
              >
                {hojaForm.processing ? 'Subiendo...' : 'Subir nueva hoja'}
              </Button>
            </DialogFooter>
          </form>
        </DialogContent>
      </Dialog>
    </AppLayout>
  );
}
// ------------------------------------------------------------
// import AppLayout from '@/layouts/app-layout';
// import { type BreadcrumbItem } from '@/types';
// import { Head, Link, router, useForm, usePage } from '@inertiajs/react';
// import { useState } from 'react';

// import CustomPagination from '@/components/CustomPagination';
// import { Button } from '@/components/ui/button';
// import {
//   Dialog,
//   DialogContent,
//   DialogDescription,
//   DialogFooter,
//   DialogHeader,
//   DialogTitle,
// } from '@/components/ui/dialog';
// import { Input } from '@/components/ui/input';
// import { Label } from '@/components/ui/label';
// import {
//   Table,
//   TableBody,
//   TableCell,
//   TableHead,
//   TableHeader,
//   TableRow,
// } from '@/components/ui/table';
// import { CalendarClock, FileText, Plus, SquarePen, Trash2 } from 'lucide-react';
// import { toast } from 'sonner';

// const breadcrumbs: BreadcrumbItem[] = [
//   {
//     title: 'Productos',
//     href: '/productos',
//   },
// ];

// interface Categoria {
//   id: number;
//   nombre: string;
// }

// interface Subcategoria {
//   id: number;
//   nombre: string;
// }

// interface Marca {
//   id: number;
//   nombre: string;
// }

// interface Producto {
//   id: number;
//   nombre: string;
//   categoria: Categoria;
//   subcategoria: Subcategoria;
//   marca: Marca;
//   stock: number;
// }

// interface ProductoVencimiento {
//   id: number;
//   producto_id: number;
//   codigo: string;
//   vencimiento: string;
// }

// interface HojaTecnica {
//   id: number;
//   producto_id: number;
//   titulo: string;
//   imagen: string;
//   archivo: string; // ← agregado como pediste
// }

// interface ProductosPaginate {
//   data: Producto[];
//   links: { url: string | null; label: string; active: boolean }[];
// }

// export default function Index() {
//   const { processing, delete: destroy } = useForm();
//   const { productos } = usePage<{ productos: ProductosPaginate }>().props;

//   // Estados para diálogos
//   const [selectedProductoId, setSelectedProductoId] = useState<number | null>(
//     null,
//   );
//   const [openVencimientos, setOpenVencimientos] = useState(false);
//   const [openHojasTecnicas, setOpenHojasTecnicas] = useState(false);

//   // Formulario Vencimientos
//   const vencimientoForm = useForm<Partial<ProductoVencimiento>>({
//     codigo: '',
//     vencimiento: '',
//   });

//   // Formulario Hoja Técnica (usamos estado manual por FormData)
//   const [hojaFormData, setHojaFormData] = useState({
//     titulo: '',
//     archivo: null as File | null,
//   });
//   const [hojaProcessing, setHojaProcessing] = useState(false);
//   const [selectedFileName, setSelectedFileName] = useState<string>('');

//   const handleDeleteProducto = (id: number) => {
//     if (confirm('¿Estás seguro de eliminar este producto?')) {
//       destroy(`/productos/${id}`);
//     }
//   };

//   // ── Vencimientos ───────────────────────────────────────────────────
//   const openVencimientosDialog = (productoId: number) => {
//     setSelectedProductoId(productoId);
//     setOpenVencimientos(true);
//   };

//   const handleSubmitVencimiento = (e: React.FormEvent) => {
//     e.preventDefault();
//     if (!selectedProductoId) return;

//     vencimientoForm.post(`/productos/${selectedProductoId}/vencimientos`, {
//       onSuccess: () => {
//         toast.success('Vencimiento guardado');
//         vencimientoForm.reset();
//       },
//       onError: () => toast.error('Error al guardar vencimiento'),
//     });
//   };

//   // ── Hoja Técnica ───────────────────────────────────────────────────
//   const resetHojaForm = () => {
//     setHojaFormData({ titulo: '', archivo: null });
//     setSelectedFileName('');
//   };

//   const handleFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
//     const file = e.target.files?.[0];
//     if (file) {
//       setHojaFormData((prev) => ({ ...prev, archivo: file }));
//       setSelectedFileName(file.name);
//     }
//   };

//   const handleSubmitHojaTecnica = async (e: React.FormEvent) => {
//     e.preventDefault();
//     if (!selectedProductoId || !hojaFormData.titulo || !hojaFormData.archivo)
//       return;

//     setHojaProcessing(true);

//     const formData = new FormData();
//     formData.append('titulo', hojaFormData.titulo);
//     formData.append('archivo', hojaFormData.archivo);

//     try {
//       await router.post(
//         `/productos/${selectedProductoId}/hojas-tecnicas`,
//         formData,
//         {
//           forceFormData: true,
//           onSuccess: () => {
//             toast.success('Hoja técnica guardada correctamente');
//             resetHojaForm();
//           },
//           onError: () => toast.error('Error al guardar la hoja técnica'),
//           onFinish: () => setHojaProcessing(false),
//         },
//       );
//     } catch (error) {
//       console.error('Error:', error);
//       setHojaProcessing(false);
//     }
//   };

//   return (
//     <AppLayout breadcrumbs={breadcrumbs}>
//       <Head title="Productos | List" />

//       <div className="m-4">
//         <div className="mb-6 flex items-center justify-between">
//           <h1 className="text-2xl font-bold">Gestión de productos</h1>
//           <Link href="/productos/create">
//             <Button>
//               <Plus className="mr-2 h-4 w-4" /> Nuevo Producto
//             </Button>
//           </Link>
//         </div>

//         {productos.data.length === 0 ? (
//           <div className="py-10 text-center text-muted-foreground">
//             No hay productos registrados aún...
//           </div>
//         ) : (
//           <Table>
//             <TableHeader>
//               <TableRow>
//                 <TableHead className="w-[80px]">ID</TableHead>
//                 <TableHead>Nombre</TableHead>
//                 <TableHead>Categoría</TableHead>
//                 <TableHead>Subcategoría</TableHead>
//                 <TableHead>Marca</TableHead>
//                 <TableHead>Stock</TableHead>
//                 <TableHead className="text-right">Acciones</TableHead>
//               </TableRow>
//             </TableHeader>
//             <TableBody>
//               {productos.data.map((producto) => (
//                 <TableRow key={producto.id}>
//                   <TableCell className="font-medium">{producto.id}</TableCell>
//                   <TableCell>{producto.nombre}</TableCell>
//                   <TableCell>{producto.categoria?.nombre ?? '—'}</TableCell>
//                   <TableCell>{producto.subcategoria?.nombre ?? '—'}</TableCell>
//                   <TableCell>{producto.marca?.nombre ?? '—'}</TableCell>
//                   <TableCell>{producto.stock ?? '—'}</TableCell>
//                   <TableCell className="space-x-1 text-right">
//                     <Link href={`/productos/${producto.id}/edit`}>
//                       <Button size="icon" variant="outline">
//                         <SquarePen className="h-4 w-4" />
//                       </Button>
//                     </Link>

//                     <Button
//                       size="icon"
//                       variant="outline"
//                       onClick={() => openVencimientosDialog(producto.id)}
//                       title="Vencimientos"
//                     >
//                       <CalendarClock className="h-4 w-4" />
//                     </Button>

//                     <Button
//                       size="icon"
//                       variant="outline"
//                       onClick={() => {
//                         setSelectedProductoId(producto.id);
//                         setOpenHojasTecnicas(true);
//                       }}
//                       title="Hojas Técnicas"
//                     >
//                       <FileText className="h-4 w-4" />
//                     </Button>

//                     <Button
//                       size="icon"
//                       variant="destructive"
//                       onClick={() => handleDeleteProducto(producto.id)}
//                       disabled={processing}
//                     >
//                       <Trash2 className="h-4 w-4" />
//                     </Button>
//                   </TableCell>
//                 </TableRow>
//               ))}
//             </TableBody>
//           </Table>
//         )}

//         <div className="mt-6">
//           <CustomPagination links={productos.links} />
//         </div>
//       </div>

//       {/* Diálogo Vencimientos */}
//       <Dialog open={openVencimientos} onOpenChange={setOpenVencimientos}>
//         <DialogContent className="sm:max-w-[500px]">
//           <DialogHeader>
//             <DialogTitle>Gestión de Vencimientos</DialogTitle>
//             <DialogDescription>
//               Crea fechas de vencimiento para el producto seleccionado
//             </DialogDescription>
//           </DialogHeader>

//           <form onSubmit={handleSubmitVencimiento} className="space-y-4 py-4">
//             <div className="grid grid-cols-2 gap-4">
//               <div className="space-y-2">
//                 <Label htmlFor="codigo">Código / Lote</Label>
//                 <Input
//                   id="codigo"
//                   value={vencimientoForm.data.codigo ?? ''}
//                   onChange={(e) =>
//                     vencimientoForm.setData('codigo', e.target.value)
//                   }
//                   placeholder="Lote 001"
//                 />
//               </div>

//               <div className="space-y-2">
//                 <Label htmlFor="vencimiento">Fecha Vencimiento</Label>
//                 <Input
//                   id="vencimiento"
//                   type="date"
//                   value={vencimientoForm.data.vencimiento ?? ''}
//                   onChange={(e) =>
//                     vencimientoForm.setData('vencimiento', e.target.value)
//                   }
//                 />
//               </div>
//             </div>

//             <DialogFooter>
//               <Button
//                 type="button"
//                 variant="outline"
//                 onClick={() => setOpenVencimientos(false)}
//               >
//                 Cancelar
//               </Button>
//               <Button type="submit" disabled={vencimientoForm.processing}>
//                 Guardar Vencimiento
//               </Button>
//             </DialogFooter>
//           </form>
//         </DialogContent>
//       </Dialog>

//       {/* Diálogo Hojas Técnicas */}
//       <Dialog
//         open={openHojasTecnicas}
//         onOpenChange={(open) => {
//           setOpenHojasTecnicas(open);
//           if (!open) resetHojaForm();
//         }}
//       >
//         <DialogContent className="sm:max-w-[600px]">
//           <DialogHeader>
//             <DialogTitle>Gestión de Hojas Técnicas</DialogTitle>
//             <DialogDescription>
//               Sube fichas técnicas, especificaciones o certificados (PDF,
//               imágenes, etc.)
//             </DialogDescription>
//           </DialogHeader>

//           <form onSubmit={handleSubmitHojaTecnica} className="space-y-6 py-4">
//             <div className="space-y-2">
//               <Label htmlFor="titulo">Título / Descripción</Label>
//               <Input
//                 id="titulo"
//                 value={hojaFormData.titulo}
//                 onChange={(e) =>
//                   setHojaFormData((prev) => ({
//                     ...prev,
//                     titulo: e.target.value,
//                   }))
//                 }
//                 placeholder="Ficha Técnica - Versión 2.1 - 2025"
//                 required
//               />
//             </div>

//             <div className="space-y-2">
//               <Label htmlFor="archivo">Archivo</Label>
//               <div className="flex items-center gap-4">
//                 <Button
//                   type="button"
//                   variant="outline"
//                   onClick={() =>
//                     document.getElementById('file-input-hoja')?.click()
//                   }
//                 >
//                   Seleccionar archivo
//                 </Button>
//                 <input
//                   id="file-input-hoja"
//                   type="file"
//                   className="hidden"
//                   accept=".pdf,.jpg,.jpeg,.png"
//                   onChange={handleFileChange}
//                 />
//                 {selectedFileName && (
//                   <div className="max-w-[300px] truncate text-sm text-muted-foreground">
//                     {selectedFileName}
//                   </div>
//                 )}
//               </div>
//               <p className="text-xs text-muted-foreground">
//                 Archivos permitidos: PDF, JPG, PNG • Máximo recomendado: 10MB
//               </p>
//             </div>

//             <DialogFooter className="gap-2 sm:gap-0">
//               <Button
//                 type="button"
//                 variant="outline"
//                 onClick={() => setOpenHojasTecnicas(false)}
//               >
//                 Cancelar
//               </Button>
//               <Button
//                 type="submit"
//                 disabled={
//                   hojaProcessing ||
//                   !hojaFormData.titulo ||
//                   !hojaFormData.archivo
//                 }
//               >
//                 {hojaProcessing ? 'Guardando...' : 'Guardar Hoja Técnica'}
//               </Button>
//             </DialogFooter>
//           </form>
//         </DialogContent>
//       </Dialog>
//     </AppLayout>
//   );
// }
// ---------------------------------------------------
// import AppLayout from '@/layouts/app-layout';
// import { type BreadcrumbItem } from '@/types';
// import { Head, Link, useForm, usePage } from '@inertiajs/react';
// import { useState } from 'react';

// import CustomPagination from '@/components/CustomPagination';
// import { Button } from '@/components/ui/button';
// import {
//   Dialog,
//   DialogContent,
//   DialogDescription,
//   DialogFooter,
//   DialogHeader,
//   DialogTitle,
// } from '@/components/ui/dialog';
// import { Input } from '@/components/ui/input';
// import { Label } from '@/components/ui/label';
// import {
//   Table,
//   TableBody,
//   TableCell,
//   TableHead,
//   TableHeader,
//   TableRow,
// } from '@/components/ui/table';
// import { CalendarClock, FileText, Plus, SquarePen, Trash2 } from 'lucide-react';
// import { toast } from 'sonner'; // opcional - muy recomendado

// const breadcrumbs: BreadcrumbItem[] = [
//   {
//     title: 'Productos',
//     href: '/productos',
//   },
// ];

// interface Categoria {
//   id: number;
//   nombre: string;
// }

// interface Subcategoria {
//   id: number;
//   nombre: string;
// }

// interface Marca {
//   id: number;
//   nombre: string;
// }

// interface Producto {
//   id: number;
//   nombre: string;
//   categoria: Categoria;
//   subcategoria: Subcategoria;
//   marca: Marca;
//   stock: number;
//   vencimientos?: ProductoVencimiento[]; // ← agregamos relación (opcional)
//   hojas_tecnicas?: HojaTecnica[]; // ← agregamos relación (opcional)
// }

// interface ProductoVencimiento {
//   id: number;
//   producto_id: number;
//   codigo: string;
//   vencimiento: string; // formato YYYY-MM-DD
// }

// interface HojaTecnica {
//   id: number;
//   producto_id: number;
//   titulo: string;
//   imagen: string; // puede ser url o path
//   archivo?: string;
// }

// interface ProductosPaginate {
//   data: Producto[];
//   links: { url: string | null; label: string; active: boolean }[];
// }

// export default function Index() {
//   const { processing, delete: destroy } = useForm();
//   const { productos } = usePage<{ productos: ProductosPaginate }>().props;

//   // Estados para controlar qué producto está seleccionado y qué diálogo abrir
//   const [selectedProductoId, setSelectedProductoId] = useState<number | null>(
//     null,
//   );

//   // Diálogos
//   const [openVencimientos, setOpenVencimientos] = useState(false);
//   const [openHojasTecnicas, setOpenHojasTecnicas] = useState(false);

//   // Formularios
//   const vencimientoForm = useForm<Partial<ProductoVencimiento>>({
//     codigo: '',
//     vencimiento: '',
//   });

//   const hojaTecnicaForm = useForm<Partial<HojaTecnica>>({
//     titulo: '',
//     imagen: '', // aquí normalmente manejarías file upload
//   });

//   const handleDeleteProducto = (id: number) => {
//     if (confirm('¿Estás seguro de eliminar este producto?')) {
//       destroy(`/productos/${id}`);
//     }
//   };

//   // Abrir diálogo de vencimientos
//   const openVencimientosDialog = (productoId: number) => {
//     setSelectedProductoId(productoId);
//     setOpenVencimientos(true);
//     // Aquí podrías cargar los vencimientos existentes si no vienen en la prop
//     // Ejemplo: router.reload({ only: ['productos'], data: { producto_id: productoId } })
//   };

//   // Abrir diálogo de hojas técnicas
//   const openHojasTecnicasDialog = (productoId: number) => {
//     setSelectedProductoId(productoId);
//     setOpenHojasTecnicas(true);
//   };

//   // Ejemplo básico de guardar vencimiento (crear)
//   const handleSubmitVencimiento = (e: React.FormEvent) => {
//     e.preventDefault();
//     if (!selectedProductoId) return;

//     vencimientoForm.post(`/productos/${selectedProductoId}/vencimientos`, {
//       onSuccess: () => {
//         toast.success('Vencimiento guardado correctamente');
//         vencimientoForm.reset();
//         // Opcional: recargar la página o actualizar estado local
//       },
//       onError: (errors) => {
//         toast.error('Error al guardar vencimiento');
//         console.log(errors);
//       },
//     });
//   };

//   const handleSubmitHojaTecnica = (e: React.FormEvent) => {
//     e.preventDefault();
//     if (!selectedProductoId) return;

//     // Nota: si vas a subir imagen, deberías usar FormData
//     // Este ejemplo asume que imagen es un string (url/path)
//     hojaTecnicaForm.post(`/productos/${selectedProductoId}/hojas-tecnicas`, {
//       onSuccess: () => {
//         toast.success('Hoja técnica guardada');
//         hojaTecnicaForm.reset();
//       },
//     });
//   };

//   return (
//     <AppLayout breadcrumbs={breadcrumbs}>
//       <Head title="Productos | List" />

//       <div className="m-4">
//         <div className="mb-6 flex items-center justify-between">
//           <h1 className="text-2xl font-bold">Gestión de productos</h1>
//           <Link href="/productos/create">
//             <Button>
//               <Plus className="mr-2 h-4 w-4" /> Nuevo Producto
//             </Button>
//           </Link>
//         </div>

//         {productos.data.length === 0 ? (
//           <div className="py-10 text-center text-muted-foreground">
//             No hay productos registrados aún...
//           </div>
//         ) : (
//           <Table>
//             <TableHeader>
//               <TableRow>
//                 <TableHead className="w-[80px]">ID</TableHead>
//                 <TableHead>Nombre</TableHead>
//                 <TableHead>Categoría</TableHead>
//                 <TableHead>Subcategoría</TableHead>
//                 <TableHead>Marca</TableHead>
//                 <TableHead>Stock</TableHead>
//                 <TableHead className="text-right">Acciones</TableHead>
//               </TableRow>
//             </TableHeader>
//             <TableBody>
//               {productos.data.map((producto) => (
//                 <TableRow key={producto.id}>
//                   <TableCell className="font-medium">{producto.id}</TableCell>
//                   <TableCell>{producto.nombre}</TableCell>
//                   <TableCell>{producto.categoria?.nombre ?? '—'}</TableCell>
//                   <TableCell>{producto.subcategoria?.nombre ?? '—'}</TableCell>
//                   <TableCell>{producto.marca?.nombre ?? '—'}</TableCell>
//                   <TableCell>{producto.stock ?? '—'}</TableCell>
//                   <TableCell className="space-x-1 text-right">
//                     <Link href={`/productos/${producto.id}/edit`}>
//                       <Button size="icon" variant="outline">
//                         <SquarePen className="h-4 w-4" />
//                       </Button>
//                     </Link>

//                     <Button
//                       size="icon"
//                       variant="outline"
//                       onClick={() => openVencimientosDialog(producto.id)}
//                       title="Vencimientos"
//                     >
//                       <CalendarClock className="h-4 w-4" />
//                     </Button>

//                     <Button
//                       size="icon"
//                       variant="outline"
//                       onClick={() => openHojasTecnicasDialog(producto.id)}
//                       title="Hojas Técnicas"
//                     >
//                       <FileText className="h-4 w-4" />
//                     </Button>

//                     <Button
//                       size="icon"
//                       variant="destructive"
//                       onClick={() => handleDeleteProducto(producto.id)}
//                       disabled={processing}
//                     >
//                       <Trash2 className="h-4 w-4" />
//                     </Button>
//                   </TableCell>
//                 </TableRow>
//               ))}
//             </TableBody>
//           </Table>
//         )}

//         <div className="mt-6">
//           <CustomPagination links={productos.links} />
//         </div>
//       </div>

//       {/* ── Diálogo Vencimientos ──────────────────────────────────────── */}
//       <Dialog open={openVencimientos} onOpenChange={setOpenVencimientos}>
//         <DialogContent className="sm:max-w-[500px]">
//           <DialogHeader>
//             <DialogTitle>Gestión de Vencimientos</DialogTitle>
//             <DialogDescription>
//               Crea, edita o elimina fechas de vencimiento para este producto
//             </DialogDescription>
//           </DialogHeader>

//           <form onSubmit={handleSubmitVencimiento} className="space-y-4 py-4">
//             <div className="grid grid-cols-2 gap-4">
//               <div className="space-y-2">
//                 <Label htmlFor="codigo">Código / Lote</Label>
//                 <Input
//                   id="codigo"
//                   value={vencimientoForm.data.codigo}
//                   onChange={(e) =>
//                     vencimientoForm.setData('codigo', e.target.value)
//                   }
//                   placeholder="Lote 001"
//                 />
//               </div>

//               <div className="space-y-2">
//                 <Label htmlFor="vencimiento">Fecha Vencimiento</Label>
//                 <Input
//                   id="vencimiento"
//                   type="date"
//                   value={vencimientoForm.data.vencimiento}
//                   onChange={(e) =>
//                     vencimientoForm.setData('vencimiento', e.target.value)
//                   }
//                 />
//               </div>
//             </div>

//             <DialogFooter>
//               <Button
//                 type="button"
//                 variant="outline"
//                 onClick={() => setOpenVencimientos(false)}
//               >
//                 Cancelar
//               </Button>
//               <Button type="submit" disabled={vencimientoForm.processing}>
//                 Guardar Vencimiento
//               </Button>
//             </DialogFooter>
//           </form>

//           {/* Aquí podrías mostrar lista de vencimientos existentes con editar/eliminar */}
//           {/* Recomendación: crear componente separado para la tabla de vencimientos */}
//         </DialogContent>
//       </Dialog>

//       {/* ── Diálogo Hojas Técnicas ─────────────────────────────────────── */}
//       <Dialog open={openHojasTecnicas} onOpenChange={setOpenHojasTecnicas}>
//         <DialogContent className="sm:max-w-[600px]">
//           <DialogHeader>
//             <DialogTitle>Gestión de Hojas Técnicas</DialogTitle>
//             <DialogDescription>
//               Administra las hojas técnicas / fichas técnicas del producto
//             </DialogDescription>
//           </DialogHeader>

//           <form onSubmit={handleSubmitHojaTecnica} className="space-y-4 py-4">
//             <div className="space-y-2">
//               <Label htmlFor="titulo">Título / Nombre</Label>
//               <Input
//                 id="titulo"
//                 value={hojaTecnicaForm.data.titulo}
//                 onChange={(e) =>
//                   hojaTecnicaForm.setData('titulo', e.target.value)
//                 }
//                 placeholder="Ficha Técnica - Versión 2.1"
//               />
//             </div>

//             <div className="space-y-2">
//               <Label htmlFor="imagen">Imagen / Archivo</Label>
//               <Input
//                 id="imagen"
//                 type="text"
//                 value={hojaTecnicaForm.data.imagen}
//                 onChange={(e) =>
//                   hojaTecnicaForm.setData('imagen', e.target.value)
//                 }
//                 placeholder="https://... o ruta del archivo"
//               />
//               {/* Recomendación real: usar input type="file" + FormData */}
//             </div>

//             <DialogFooter>
//               <Button
//                 type="button"
//                 variant="outline"
//                 onClick={() => setOpenHojasTecnicas(false)}
//               >
//                 Cancelar
//               </Button>
//               <Button type="submit" disabled={hojaTecnicaForm.processing}>
//                 Guardar Hoja Técnica
//               </Button>
//             </DialogFooter>
//           </form>

//           {/* Aquí iría la lista de hojas técnicas existentes */}
//         </DialogContent>
//       </Dialog>
//     </AppLayout>
//   );
// }
// -----------------------------------------------------
// import AppLayout from '@/layouts/app-layout';
// import { type BreadcrumbItem } from '@/types';
// import { Head, Link, useForm, usePage } from '@inertiajs/react';

// import CustomPagination from '@/components/CustomPagination';
// import { Button } from '@/components/ui/button';
// import {
//   Table,
//   TableBody,
//   TableCell,
//   TableHead,
//   TableHeader,
//   TableRow,
// } from '@/components/ui/table';
// import { Plus, SquarePen, Trash2 } from 'lucide-react';

// const breadcrumbs: BreadcrumbItem[] = [
//   {
//     title: 'Productos',
//     href: '/productos',
//   },
// ];

// interface Categoria {
//   id: number;
//   nombre: string;
// }

// interface Subcategoria {
//   id: number;
//   nombre: string;
// }

// interface Marca {
//   id: number;
//   nombre: string;
// }

// interface Producto {
//   id: number;
//   nombre: string;
//   categoria: Categoria;
//   subcategoria: Subcategoria;
//   marca: Marca;
//   stock: number;
// }

// interface ProductoVencimiento {
//   id: number;
//   producto_id: number;
//   codigo: string;
//   vencimiento: string;
// }

// interface HojaTecnica {
//   id:number;
//   producto_id: number;
//   titulo: string;
//   imagen: string;
// }

// interface ProductosPaginate {
//   data: Producto[];
//   links: { url: string | null; label: string; active: boolean }[];
// }

// export default function Index() {
//   const { processing, delete: destroy } = useForm();
//   const { productos } = usePage<{ productos: ProductosPaginate }>().props;

//   const handleDelete = (id: number) => {
//     if (confirm('Estas seguro de eliminar el registro')) {
//       destroy(`/productos/${id}`);
//     }
//   };

//   return (
//     <AppLayout breadcrumbs={breadcrumbs}>
//       <Head title="Productos | List" />

//       <div className="m-4">
//         <div className="flex items-center">
//           <div className="me-5 mb-2 text-center text-2xl font-bold">
//             Gestión de productos
//           </div>
//           <Link href={'/productos/create'}>
//             <Button className="mb-4" size="sm">
//               <Plus className="mr-2 h-4 w-4" /> Nuevo Producto
//             </Button>
//           </Link>
//         </div>
//         {productos.data.length > 0 && (
//           <Table>
//             <TableHeader>
//               <TableRow>
//                 <TableHead className="w-[100px]">ID</TableHead>
//                 <TableHead>Nombre</TableHead>
//                 <TableHead>Categoria</TableHead>
//                 <TableHead>Subcategoria</TableHead>
//                 <TableHead>Marca</TableHead>
//                 <TableHead>Stock</TableHead>
//                 <TableHead>Acción</TableHead>
//               </TableRow>
//             </TableHeader>
//             <TableBody>
//               {productos.data.map((producto) => (
//                 <TableRow key={producto.id}>
//                   <TableCell className="font-medium">{producto.id}</TableCell>
//                   <TableCell>{producto.nombre}</TableCell>
//                   <TableCell>{producto.categoria?.nombre ?? '---'}</TableCell>
//                   <TableCell>
//                     {producto.subcategoria?.nombre ?? '---'}
//                   </TableCell>
//                   <TableCell>{producto.marca?.nombre ?? '---'}</TableCell>
//                   <TableCell>{producto.stock ?? '---'}</TableCell>
//                   <TableCell>
//                     <Link href={`/productos/${producto.id}/edit`}>
//                       <Button className="" size="icon" variant="outline">
//                         <SquarePen />
//                       </Button>
//                     </Link>
//                     <Button
//                       disabled={processing}
//                       className="ml-1"
//                       size="icon"
//                       variant="outline"
//                       onClick={() => handleDelete(producto.id)}
//                     >
//                       <Trash2 />
//                     </Button>
//                   </TableCell>
//                 </TableRow>
//               ))}
//             </TableBody>
//           </Table>
//         )}

//         <div className="my-2">
//           <CustomPagination links={productos.links} />
//         </div>
//       </div>
//     </AppLayout>
//   );
// }
