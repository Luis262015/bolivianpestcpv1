import InputError from '@/components/input-error';
import { Button } from '@/components/ui/button';
import { Checkbox } from '@/components/ui/checkbox';
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
import {
  HoverCard,
  HoverCardContent,
  HoverCardTrigger,
} from '@/components/ui/hover-card';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import {
  Popover,
  PopoverContent,
  PopoverTrigger,
} from '@/components/ui/popover';
import { Textarea } from '@/components/ui/textarea';
import { cn } from '@/lib/utils';
import { useForm } from '@inertiajs/react';
import axios from 'axios';
import {
  Check,
  ChevronsUpDown,
  InfoIcon,
  Loader2,
  Plus,
  RotateCcw,
  Trash2,
} from 'lucide-react';
import React, { useEffect, useState } from 'react';
import SeguimientoTrampasEdit, {
  TrampaEspecieSeguimientos,
  TrampaRoedoresSeguimiento,
} from './SeguimientoTrampasEdit';
import SignaturePad from './SignaturePad';

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
interface Especie {
  id: number;
  nombre: string;
}
interface TipoSeguimiento {
  id: number;
  nombre: string;
}

interface Unidad {
  id: number;
  nombre: string;
}

interface Producto {
  id: number;
  nombre: string;
  precio_compra: number;
  precio_venta: number;
  stock: number;
  unidad: Unidad;
}

interface ProductoUsado {
  producto_id: number;
  nombre_producto: string;
  producto: string;
  cantidad: string;
}

interface Aplicacion {
  paredes_internas: number;
  pisos: number;
  ambientes: number;
  trampas: number;
  trampas_cambiar: number;
  internas: number;
  externas: number;
  roedores: number;
}

interface ModalEditarSeguimientoProps {
  open: boolean;
  onClose: () => void;
  seguimientoId: number | null;
  biologicos: Biologico[];
  metodos: Metodo[];
  epps: EPP[];
  protecciones: Proteccion[];
  signos: Signo[];
  especies: Especie[];
  tipoSeguimiento: TipoSeguimiento[];
}

const emptyAplicacion: Aplicacion = {
  paredes_internas: 0,
  pisos: 0,
  ambientes: 0,
  trampas: 0,
  trampas_cambiar: 0,
  internas: 0,
  externas: 0,
  roedores: 0,
};

export default function ModalEditarSeguimiento({
  open,
  onClose,
  seguimientoId,
  biologicos,
  metodos,
  epps,
  protecciones,
  signos,
  especies,
  tipoSeguimiento,
}: ModalEditarSeguimientoProps) {
  const [step, setStep] = useState(1);
  const [loadingData, setLoadingData] = useState(false);

  const [biologicosSel, setBiologicosSel] = useState<number[]>([]);
  const [metodosSel, setMetodosSel] = useState<number[]>([]);
  const [eppsSel, setEppsSel] = useState<number[]>([]);
  const [proteccionesSel, setProteccionesSel] = useState<number[]>([]);
  const [signosSel, setSignosSel] = useState<number[]>([]);

  const [aplicacion, setAplicacion] = useState<Aplicacion>(emptyAplicacion);
  const [productos, setProductos] = useState<ProductoUsado[]>([]);

  const [openP, setOpenP] = useState(false);
  const [query, setQuery] = useState('');
  const [searchResults, setSearchResults] = useState<Producto[]>([]);
  const [selectedProduct, setSelectedProduct] = useState<Producto | null>(null);
  const [loading, setLoading] = useState(false);
  const [quantity, setQuantity] = useState('1');

  const [firmaEncargado, setFirmaEncargado] = useState('');
  const [firmaSupervisor, setFirmaSupervisor] = useState('');
  const [firmaEncargadoExistente, setFirmaEncargadoExistente] = useState('');
  const [firmaSupervisorExistente, setFirmaSupervisorExistente] = useState('');

  const [tipoSeguimientoSel, setTipoSeguimientoSel] = useState('TIPO');
  const [empresaNombre, setEmpresaNombre] = useState('');
  const [almacenNombre, setAlmacenNombre] = useState('');

  const [imagenesExistentes, setImagenesExistentes] = useState<
    { id: number; imagen: string }[]
  >([]);
  const [imagenesEliminar, setImagenesEliminar] = useState<number[]>([]);

  const { data, setData, transform, post, processing, errors, reset } = useForm(
    {
      empresa_id: '',
      almacen_id: '',
      tipo_seguimiento_id: '',
      aplicacion_data: emptyAplicacion,
      biologicos_ids: [] as number[],
      metodos_ids: [] as number[],
      epps_ids: [] as number[],
      protecciones_ids: [] as number[],
      signos_ids: [] as number[],
      productos_usados: [] as ProductoUsado[],
      observaciones_especificas: '',
      encargado_nombre: '',
      encargado_cargo: '',
      firma_encargado: '',
      firma_supervisor: '',
      observaciones_generales: '',
      trampa_especies_seguimientos: [] as TrampaEspecieSeguimientos[],
      trampa_roedores_seguimientos: [] as TrampaRoedoresSeguimiento[],
      created_at: '',
      imagenes: [] as File[],
      imagenes_eliminar: [] as number[],
    },
  );

  // Carga datos al abrir el modal
  useEffect(() => {
    if (!open || !seguimientoId) return;

    setLoadingData(true);
    axios
      .get(`/seguimientos/${seguimientoId}`)
      .then((res) => {
        const s = res.data;

        console.log('********************************');
        console.log('seguimiento data:', s);
        console.log('********************************');

        const tipo = tipoSeguimiento.find(
          (t) => Number(t.id) === Number(s.tipo_seguimiento_id),
        );
        setTipoSeguimientoSel(tipo?.nombre ?? 'TIPO');
        setEmpresaNombre(s.empresa?.nombre ?? '');
        setAlmacenNombre(s.almacen?.nombre ?? '');

        const productosIniciales: ProductoUsado[] = (
          s.productos_usos ?? []
        ).map((pu: any) => ({
          producto_id: pu.producto_id,
          nombre_producto: pu.nombre_producto ?? `Producto #${pu.producto_id}`,
          producto: pu.nombre_producto ?? `Producto #${pu.producto_id}`,
          cantidad: String(pu.cantidad),
        }));

        const ap = s.aplicacion ?? emptyAplicacion;
        const aplicacionInicial: Aplicacion = {
          paredes_internas: ap.paredes_internas ?? 0,
          pisos: ap.pisos ?? 0,
          ambientes: ap.ambientes ?? 0,
          trampas: ap.trampas ?? 0,
          trampas_cambiar: ap.trampas_cambiar ?? 0,
          internas: ap.internas ?? 0,
          externas: ap.externas ?? 0,
          roedores: ap.roedores ?? 0,
        };

        setBiologicosSel(s.biologicos?.map((b: any) => b.id) ?? []);
        setMetodosSel(s.metodos?.map((m: any) => m.id) ?? []);
        setEppsSel(s.epps?.map((e: any) => e.id) ?? []);
        setProteccionesSel(s.proteccions?.map((p: any) => p.id) ?? []);
        setSignosSel(s.signos?.map((si: any) => si.id) ?? []);
        setAplicacion(aplicacionInicial);
        setProductos(productosIniciales);
        setFirmaEncargadoExistente(s.firma_encargado ?? '');
        setFirmaSupervisorExistente(s.firma_supervisor ?? '');
        setImagenesExistentes(
          (s.images ?? []).map((img: any) => ({
            id: img.id,
            imagen: img.imagen,
          })),
        );
        setImagenesEliminar([]);

        setData({
          empresa_id: String(s.empresa_id),
          almacen_id: String(s.almacen_id),
          tipo_seguimiento_id: String(s.tipo_seguimiento_id),
          aplicacion_data: aplicacionInicial,
          biologicos_ids: s.biologicos?.map((b: any) => b.id) ?? [],
          metodos_ids: s.metodos?.map((m: any) => m.id) ?? [],
          epps_ids: s.epps?.map((e: any) => e.id) ?? [],
          protecciones_ids: s.proteccions?.map((p: any) => p.id) ?? [],
          signos_ids: s.signos?.map((si: any) => si.id) ?? [],
          productos_usados: productosIniciales,
          observaciones_especificas: s.observacionesp ?? '',
          encargado_nombre: s.encargado_nombre ?? '',
          encargado_cargo: s.encargado_cargo ?? '',
          firma_encargado: '',
          firma_supervisor: '',
          observaciones_generales: s.observaciones ?? '',
          trampa_especies_seguimientos: s.trampa_especies_seguimientos ?? [],
          trampa_roedores_seguimientos: s.trampa_roedores_seguimientos ?? [],
          created_at: s.created_at ? s.created_at.split('T')[0] : '',
          imagenes: [],
          imagenes_eliminar: [],
        });
      })
      .catch((err) => console.error('Error al cargar seguimiento:', err))
      .finally(() => setLoadingData(false));
  }, [open, seguimientoId]);

  // Búsqueda de productos con debounce
  useEffect(() => {
    if (query.length < 2) {
      setSearchResults([]);
      return;
    }
    const delay = setTimeout(async () => {
      setLoading(true);
      try {
        const { data: res } = await axios.get(`/productos/search?q=${query}`);
        setSearchResults(res);
      } catch {
        // silent
      } finally {
        setLoading(false);
      }
    }, 300);
    return () => clearTimeout(delay);
  }, [query]);

  useEffect(() => {
    if (firmaEncargado) setData('firma_encargado', firmaEncargado);
  }, [firmaEncargado]);

  useEffect(() => {
    if (firmaSupervisor) setData('firma_supervisor', firmaSupervisor);
  }, [firmaSupervisor]);

  const resetDialogState = () => {
    reset();
    setStep(1);
    setBiologicosSel([]);
    setMetodosSel([]);
    setEppsSel([]);
    setProteccionesSel([]);
    setSignosSel([]);
    setAplicacion(emptyAplicacion);
    setProductos([]);
    setSelectedProduct(null);
    setQuery('');
    setQuantity('1');
    setFirmaEncargado('');
    setFirmaSupervisor('');
    setFirmaEncargadoExistente('');
    setFirmaSupervisorExistente('');
    setTipoSeguimientoSel('TIPO');
    setEmpresaNombre('');
    setAlmacenNombre('');
    setImagenesExistentes([]);
    setImagenesEliminar([]);
  };

  const handleClose = () => {
    resetDialogState();
    onClose();
  };

  const toggle = (
    arr: number[],
    setArr: React.Dispatch<React.SetStateAction<number[]>>,
    id: number,
  ) => {
    setArr((prev) =>
      prev.includes(id) ? prev.filter((x) => x !== id) : [...prev, id],
    );
  };

  const updateAplicacion = (field: keyof Aplicacion, value: string) => {
    const numericValue = value === '' ? 0 : Number(value);
    setAplicacion((prev) => ({ ...prev, [field]: numericValue }));
  };

  const addProducto = () => {
    if (!selectedProduct || !quantity || parseFloat(quantity) < 0.01) return;

    if (productos.some((p) => p.producto_id === selectedProduct.id)) {
      alert('Este producto ya fue agregado');
      return;
    }

    const nuevo: ProductoUsado = {
      producto_id: selectedProduct.id,
      nombre_producto: selectedProduct.nombre,
      producto: selectedProduct.nombre,
      cantidad: quantity,
    };

    const updated = [...productos, nuevo];
    setProductos(updated);
    setData('productos_usados', updated);
    setSelectedProduct(null);
    setQuery('');
    setQuantity('1');
    setOpenP(false);
  };

  const removeProducto = (i: number) => {
    const updated = productos.filter((_, idx) => idx !== i);
    setProductos(updated);
    setData('productos_usados', updated);
  };

  const handleNext = () => {
    if (step === 2) setData('aplicacion_data', aplicacion);
    if (step === 3) setData('metodos_ids', metodosSel);
    if (step === 4) setData('productos_usados', productos);
    if (step === 5) setData('epps_ids', eppsSel);
    if (step === 6) setData('protecciones_ids', proteccionesSel);
    if (step === 7) setData('biologicos_ids', biologicosSel);
    if (step === 8) setData('signos_ids', signosSel);
    if (step === 11 && (!data.encargado_nombre || !data.encargado_cargo))
      return;
    setStep((s) => Math.min(s + 1, 13));
  };

  const handleBack = () => setStep((s) => Math.max(s - 1, 1));

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();

    const finalData = {
      ...data,
      _method: 'PUT',
      biologicos_ids: biologicosSel,
      metodos_ids: metodosSel,
      epps_ids: eppsSel,
      protecciones_ids: proteccionesSel,
      signos_ids: signosSel,
      productos_usados: productos,
      firma_encargado: firmaEncargado || firmaEncargadoExistente,
      firma_supervisor: firmaSupervisor || firmaSupervisorExistente,
      aplicacion_data: aplicacion,
      imagenes_eliminar: imagenesEliminar,
    };

    transform(() => finalData);

    post(`/seguimientos/${seguimientoId}`, {
      forceFormData: true,
      onSuccess: handleClose,
    });
  };

  const metodosGrupoA = metodos.filter((m) => m.id >= 1 && m.id <= 3);
  const metodosGrupoB = metodos.filter((m) => m.id > 3);

  return (
    <Dialog
      open={open}
      onOpenChange={(isOpen) => {
        if (!isOpen) handleClose();
      }}
    >
      <DialogContent
        className="max-h-[90vh] overflow-y-auto sm:max-w-[800px]"
        // onInteractOutside={(e) => e.preventDefault()}
        // onEscapeKeyDown={(e) => e.preventDefault()}
      >
        <DialogHeader>
          <DialogTitle className="text-[1rem]">
            Editar Seguimiento – Paso {step} de 13
          </DialogTitle>
          <div className="mt-3 h-2 w-full rounded-full bg-muted">
            <div
              className="h-2 rounded-full bg-primary transition-all"
              style={{ width: `${(step / 13) * 100}%` }}
            />
          </div>
        </DialogHeader>

        {loadingData ? (
          <div className="flex items-center justify-center py-20">
            <Loader2 className="h-8 w-8 animate-spin text-muted-foreground" />
          </div>
        ) : (
          <form onSubmit={handleSubmit}>
            {/* PASO 1: Datos del seguimiento + fecha */}
            {step === 1 && (
              <div className="space-y-6 py-6">
                <div className="grid grid-cols-1 gap-5 md:grid-cols-2">
                  <div className="space-y-2">
                    <Label>Empresa</Label>
                    <Input value={empresaNombre} disabled />
                  </div>
                  <div className="space-y-2">
                    <Label>Almacén</Label>
                    <Input value={almacenNombre} disabled />
                  </div>
                </div>
                <div className="space-y-2">
                  <Label>Tipo de Seguimiento</Label>
                  <Input value={tipoSeguimientoSel} disabled />
                </div>
                <div className="space-y-2">
                  <Label htmlFor="created_at">Fecha del Seguimiento</Label>
                  <Input
                    id="created_at"
                    type="date"
                    value={data.created_at}
                    onChange={(e) => setData('created_at', e.target.value)}
                  />
                </div>
              </div>
            )}

            {/* PASO 2: Labores */}
            {step === 2 && (
              <div className="space-y-5">
                <div className="my-3 text-lg font-semibold">
                  Seguimiento {tipoSeguimientoSel}
                </div>
                <div className="my-2">Labores Desarrolladas</div>

                {tipoSeguimientoSel !== 'INSECTOCUTORES' && (
                  <>
                    {tipoSeguimientoSel === 'DESRATIZACION' ? (
                      <div className="grid grid-cols-1 gap-4 sm:grid-cols-2">
                        {(
                          [
                            ['trampas', 'Cantidad Trampas'],
                            ['trampas_cambiar', 'Trampas Cambiadas'],
                            ['internas', 'Trampas Internas'],
                            ['externas', 'Trampas Externas'],
                            ['roedores', 'Roedores encontrados'],
                          ] as [keyof Aplicacion, string][]
                        ).map(([field, label]) => (
                          <div
                            key={field}
                            className="flex items-center justify-between"
                          >
                            <Label>{label}</Label>
                            <Input
                              className="w-auto"
                              type="number"
                              value={aplicacion[field]}
                              onChange={(e) =>
                                updateAplicacion(field, e.target.value)
                              }
                            />
                          </div>
                        ))}
                      </div>
                    ) : (
                      <>
                        <div className="my-3 text-[.9rem] text-gray-500">
                          Desinfeccion
                        </div>
                        <div className="grid grid-cols-1 gap-4 sm:grid-cols-2">
                          <div className="flex items-center justify-between">
                            <Label>Cantidad Ambientes</Label>
                            <Input
                              className="w-auto"
                              type="number"
                              value={aplicacion.ambientes}
                              onChange={(e) =>
                                updateAplicacion('ambientes', e.target.value)
                              }
                            />
                          </div>
                        </div>
                        <div className="my-3 text-[.9rem] text-gray-500">
                          Fumigacion
                        </div>
                        <div className="grid grid-cols-1 gap-4 sm:grid-cols-2">
                          <div className="flex items-center justify-between">
                            <Label>Cantidad Pisos</Label>
                            <Input
                              className="w-auto"
                              type="number"
                              value={aplicacion.pisos}
                              onChange={(e) =>
                                updateAplicacion('pisos', e.target.value)
                              }
                            />
                          </div>
                          <div className="flex items-center justify-between">
                            <Label>Paredes Internas</Label>
                            <Input
                              className="w-auto"
                              type="number"
                              value={aplicacion.paredes_internas}
                              onChange={(e) =>
                                updateAplicacion(
                                  'paredes_internas',
                                  e.target.value,
                                )
                              }
                            />
                          </div>
                        </div>
                      </>
                    )}
                  </>
                )}
              </div>
            )}

            {/* PASO 3: Métodos */}
            {step === 3 && (
              <div className="space-y-5">
                <div className="my-3 text-lg font-semibold">
                  Seguimiento {tipoSeguimientoSel}
                </div>
                <div className="my-2">Método Utilizado</div>

                {tipoSeguimientoSel !== 'INSECTOCUTORES' && (
                  <div className="grid max-h-96 grid-cols-1 gap-3 overflow-y-auto md:grid-cols-2">
                    {(tipoSeguimientoSel === 'DESRATIZACION'
                      ? metodosGrupoA
                      : metodosGrupoB
                    ).map((m) => (
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
                )}
              </div>
            )}

            {/* PASO 4: Productos */}
            {step === 4 && (
              <div className="space-y-5">
                <div className="my-3 text-lg font-semibold">
                  Seguimiento {tipoSeguimientoSel}
                </div>
                <div className="my-2">Productos Utilizados</div>

                <div className="flex items-end gap-3">
                  <div className="flex-grow space-y-2">
                    <Label>Buscar Producto</Label>
                    <Popover open={openP} onOpenChange={setOpenP}>
                      <PopoverTrigger asChild>
                        <Button
                          type="button"
                          variant="outline"
                          role="combobox"
                          className="w-full justify-between"
                        >
                          {selectedProduct
                            ? `${selectedProduct.nombre} (unidad = ${selectedProduct.unidad.nombre})`
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
                            {loading && (
                              <CommandEmpty>Buscando...</CommandEmpty>
                            )}
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
                                    if (product.stock <= 0) return;
                                    setSelectedProduct(product);
                                    setQuery(product.nombre);
                                    setOpenP(false);
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
                                      Unidad: {product.unidad.nombre} | Stock:{' '}
                                      {product.stock}
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

                  <div className="space-y-2">
                    <div className="flex items-center gap-1.5">
                      <Label>Cantidad Usada</Label>
                      <HoverCard openDelay={200} closeDelay={100}>
                        <HoverCardTrigger asChild>
                          <InfoIcon className="h-4 w-4 cursor-help text-muted-foreground transition-colors hover:text-foreground" />
                        </HoverCardTrigger>
                        <HoverCardContent className="w-72 text-sm">
                          La cantidad usada es en cantidad de la{' '}
                          <strong>unidad del producto</strong>.
                        </HoverCardContent>
                      </HoverCard>
                    </div>
                    <Input
                      type="number"
                      step="0.01"
                      min="0.01"
                      placeholder="Cantidad"
                      value={quantity}
                      onChange={(e) => setQuantity(e.target.value)}
                      className="w-32"
                    />
                  </div>

                  <Button
                    type="button"
                    onClick={addProducto}
                    disabled={!selectedProduct || !quantity}
                    className="h-10"
                  >
                    <Plus className="mr-1 h-4 w-4" />
                    Añadir
                  </Button>
                </div>

                <div className="space-y-4">
                  {productos.length === 0 ? (
                    <p className="py-8 text-center text-sm text-muted-foreground">
                      No hay productos agregados.
                    </p>
                  ) : (
                    productos.map((p, i) => (
                      <div
                        key={i}
                        className="flex items-center gap-3 rounded-lg border p-3"
                      >
                        <div className="flex-1">
                          <p className="font-medium">{p.nombre_producto}</p>
                          <p className="text-sm text-muted-foreground">
                            Cantidad: {p.cantidad}
                          </p>
                        </div>
                        <Button
                          type="button"
                          variant="ghost"
                          size="icon"
                          onClick={() => removeProducto(i)}
                        >
                          <Trash2 className="h-4 w-4 text-red-500" />
                        </Button>
                      </div>
                    ))
                  )}
                </div>
              </div>
            )}

            {/* PASO 5: EPP */}
            {step === 5 && (
              <div className="space-y-5">
                <div className="my-3 text-lg font-semibold">
                  Seguimiento {tipoSeguimientoSel}
                </div>
                <div className="my-2">Equipos de Protección Personal (EPP)</div>
                <div className="mt-6 grid max-h-96 grid-cols-1 gap-3 overflow-y-auto md:grid-cols-2">
                  {epps.map((e) => (
                    <label
                      key={e.id}
                      className="flex cursor-pointer items-center space-x-3 rounded-lg border p-4 hover:bg-accent has-[:checked]:bg-primary/10"
                    >
                      <Checkbox
                        checked={eppsSel.includes(e.id)}
                        onCheckedChange={() =>
                          toggle(eppsSel, setEppsSel, e.id)
                        }
                      />
                      <span>{e.nombre}</span>
                    </label>
                  ))}
                </div>
              </div>
            )}

            {/* PASO 6: Protecciones */}
            {step === 6 && (
              <div className="space-y-5">
                <div className="my-3 text-lg font-semibold">
                  Seguimiento {tipoSeguimientoSel}
                </div>
                <div className="my-2">
                  Métodos de Protección Adoptadas para Terceros
                </div>
                <div className="mt-6 grid max-h-96 grid-cols-1 gap-3 overflow-y-auto md:grid-cols-2">
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
              <div className="space-y-5">
                <div className="my-3 text-lg font-semibold">
                  Seguimiento {tipoSeguimientoSel}
                </div>
                <div className="my-2">Observaciones de Ciclos Biológicos</div>

                {tipoSeguimientoSel === 'FUMIGACION' && (
                  <div className="mt-6 grid max-h-96 grid-cols-1 gap-3 overflow-y-auto md:grid-cols-2">
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
                )}
              </div>
            )}

            {/* PASO 8: Signos */}
            {step === 8 && (
              <div className="space-y-5">
                <div className="my-3 text-lg font-semibold">
                  Seguimiento {tipoSeguimientoSel}
                </div>
                <div className="my-2">Observaciones de Signos de Roedores</div>

                {tipoSeguimientoSel === 'DESRATIZACION' && (
                  <div className="mt-6 grid max-h-96 grid-cols-1 gap-3 overflow-y-auto md:grid-cols-2">
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
                )}
              </div>
            )}

            {/* PASO 9: Trampas */}
            {step === 9 && (
              <div className="space-y-5">
                <div className="my-3 text-lg font-semibold">
                  Seguimiento {tipoSeguimientoSel}
                </div>
                <div className="my-2">Seguimiento de trampas</div>

                {tipoSeguimientoSel !== 'FUMIGACION' && (
                  <SeguimientoTrampasEdit
                    almacenId={Number(data.almacen_id)}
                    tipoSeguimiento={data.tipo_seguimiento_id}
                    value={{
                      trampa_especies_seguimientos:
                        data.trampa_especies_seguimientos,
                      trampa_roedores_seguimientos:
                        data.trampa_roedores_seguimientos,
                    }}
                    onChange={(val) => {
                      setData(
                        'trampa_especies_seguimientos',
                        val.trampa_especies_seguimientos,
                      );
                      setData(
                        'trampa_roedores_seguimientos',
                        val.trampa_roedores_seguimientos,
                      );
                    }}
                  />
                )}
              </div>
            )}

            {/* PASO 10: Observaciones Específicas */}
            {step === 10 && (
              <div className="space-y-5">
                <div className="my-3 text-lg font-semibold">
                  Seguimiento {tipoSeguimientoSel}
                </div>
                <div className="my-2">Observaciones Bolivian PEST</div>
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

            {/* PASO 11: Encargado y Firmas */}
            {step === 11 && (
              <div className="space-y-6">
                <div className="my-3 text-lg font-semibold">
                  Seguimiento {tipoSeguimientoSel}
                </div>
                <div className="my-2">Responsable y Firmas</div>

                <div className="grid grid-cols-1 gap-5 sm:grid-cols-2">
                  <div className="space-y-2">
                    <Label>Nombre del Encargado *</Label>
                    <Input
                      value={data.encargado_nombre}
                      onChange={(e) =>
                        setData('encargado_nombre', e.target.value)
                      }
                      required
                    />
                    <InputError message={errors.encargado_nombre} />
                  </div>
                  <div className="space-y-2">
                    <Label>Cargo *</Label>
                    <Input
                      value={data.encargado_cargo}
                      onChange={(e) =>
                        setData('encargado_cargo', e.target.value)
                      }
                      required
                    />
                    <InputError message={errors.encargado_cargo} />
                  </div>
                </div>

                <div className="grid grid-cols-1 gap-5 sm:grid-cols-2">
                  <div className="space-y-2">
                    <Label>Firma Encargado</Label>
                    {firmaEncargadoExistente && !firmaEncargado && (
                      <div className="mb-2">
                        <p className="mb-1 text-xs text-muted-foreground">
                          Firma actual:
                        </p>
                        <img
                          src={`/${firmaEncargadoExistente}`}
                          alt="Firma actual encargado"
                          className="w-40 border"
                        />
                      </div>
                    )}
                    <SignaturePad onChange={(d) => setFirmaEncargado(d)} />
                    {firmaEncargado && (
                      <img
                        src={firmaEncargado}
                        alt="Nueva firma encargado"
                        className="w-40 border"
                      />
                    )}
                  </div>
                  <div className="space-y-2">
                    <Label>Firma Supervisor</Label>
                    {firmaSupervisorExistente && !firmaSupervisor && (
                      <div className="mb-2">
                        <p className="mb-1 text-xs text-muted-foreground">
                          Firma actual:
                        </p>
                        <img
                          src={`/${firmaSupervisorExistente}`}
                          alt="Firma actual supervisor"
                          className="w-40 border"
                        />
                      </div>
                    )}
                    <SignaturePad onChange={(d) => setFirmaSupervisor(d)} />
                    {firmaSupervisor && (
                      <img
                        src={firmaSupervisor}
                        alt="Nueva firma supervisor"
                        className="w-40 border"
                      />
                    )}
                  </div>
                </div>
              </div>
            )}

            {/* PASO 12: Imágenes */}
            {step === 12 && (
              <div className="space-y-6">
                <div className="my-3 text-lg font-semibold">
                  Seguimiento {tipoSeguimientoSel}
                </div>
                <div className="my-2">Imágenes</div>

                {/* Imágenes existentes */}
                {imagenesExistentes.length > 0 && (
                  <div className="space-y-2">
                    <Label>Imágenes actuales</Label>
                    <p className="text-xs text-muted-foreground">
                      Presiona el ícono de eliminar para marcar una imagen. Se
                      borrará al guardar.
                    </p>
                    <div className="grid grid-cols-3 gap-3">
                      {imagenesExistentes.map((img) => {
                        const marcada = imagenesEliminar.includes(img.id);
                        return (
                          <div
                            key={img.id}
                            className={`relative rounded-md border p-1 transition-opacity ${marcada ? 'opacity-40' : ''}`}
                          >
                            <img
                              src={`/${img.imagen}`}
                              alt="imagen seguimiento"
                              className="h-24 w-full rounded object-cover"
                            />
                            <Button
                              type="button"
                              size="icon"
                              variant={marcada ? 'outline' : 'destructive'}
                              className="absolute top-1 right-1 h-6 w-6"
                              onClick={() => {
                                if (marcada) {
                                  setImagenesEliminar((prev) =>
                                    prev.filter((id) => id !== img.id),
                                  );
                                } else {
                                  setImagenesEliminar((prev) => [
                                    ...prev,
                                    img.id,
                                  ]);
                                }
                              }}
                            >
                              {marcada ? (
                                <RotateCcw className="h-3 w-3" />
                              ) : (
                                <Trash2 className="h-3 w-3" />
                              )}
                            </Button>
                          </div>
                        );
                      })}
                    </div>
                    {imagenesEliminar.length > 0 && (
                      <p className="text-xs text-red-500">
                        {imagenesEliminar.length} imagen(es) marcadas para
                        eliminar.
                      </p>
                    )}
                  </div>
                )}

                {/* Nuevas imágenes */}
                <div className="space-y-2">
                  <Label>Agregar nuevas imágenes</Label>
                  <input
                    type="file"
                    multiple
                    accept="image/*"
                    className="rounded-2xl border-2 p-3"
                    onChange={(e) => {
                      if (e.target.files) {
                        setData('imagenes', Array.from(e.target.files));
                      }
                    }}
                  />
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
                            className="h-24 w-full rounded object-cover"
                          />
                          <span className="mt-1 text-xs">{file.name}</span>
                        </div>
                      ))}
                    </div>
                  )}
                </div>
              </div>
            )}

            {/* PASO 13: Observaciones Generales + Envío */}
            {step === 13 && (
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
                  Revisa y guarda los cambios.
                </p>
                <Textarea
                  rows={5}
                  placeholder="Observaciones generales (opcional)"
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

              {step < 13 ? (
                <Button asChild>
                  <button type="button" onClick={handleNext}>
                    Siguiente
                  </button>
                </Button>
              ) : (
                <Button type="submit" disabled={processing}>
                  {processing ? 'Guardando...' : 'Guardar Cambios'}
                </Button>
              )}
            </DialogFooter>
          </form>
        )}
      </DialogContent>
    </Dialog>
  );
}
