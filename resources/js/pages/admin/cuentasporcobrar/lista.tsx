import CustomPagination from '@/components/CustomPagination';
import { Button } from '@/components/ui/button';
import { Checkbox } from '@/components/ui/checkbox';
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
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
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from '@/components/ui/table';
import { Textarea } from '@/components/ui/textarea';
import AppLayout from '@/layouts/app-layout';
import { type BreadcrumbItem } from '@/types';
import { Head, router, useForm, usePage } from '@inertiajs/react';
import { Banknote, ClipboardList, Edit, Plus, Trash2, X } from 'lucide-react';
import { useState } from 'react';
import { toast } from 'sonner';

const breadcrumbs: BreadcrumbItem[] = [
  {
    title: 'Cuentas Por Cobrar',
    href: '/cuentasporcobrar',
  },
];

interface CuentaCobrar {
  id: number;
  venta_id: number;
  contrato_id: number;
  cliente_id: number;
  user_id: number;
  concepto: string;
  detalles: string;
  total: number;
  saldo: number;
  estado: string;
  plan_pagos: boolean;
  // fecha_pago: string;
  cuotas?: CobrarCuota[];
}

interface CobrarCuota {
  id: number;
  cuenta_cobrar_id: number;
  numero_cuota: number;
  fecha_vencimiento: string;
  monto: number;
  estado: string;
}

interface CuentasCobrarPaginate {
  data: CuentaCobrar[];
  links: { url: string | null; label: string; active: boolean }[];
}

export default function Index() {
  const [open, setOpen] = useState(false);
  const [openCuotas, setOpenCuotas] = useState(false);
  const [openCobrar, setOpenCobrar] = useState(false);
  const [editingId, setEditingId] = useState<number | null>(null);
  const [selectedCuentaId, setSelectedCuentaId] = useState<number | null>(null);
  // const [cuotas, setCuotas] = useState Omit < CobrarCuota, 'id' | 'cuenta_cobrar_id' > [] > []));
  const [totalCobrar, setTotalCobrar] = useState<number | null>(null);

  const [cuotas, setCuotas] = useState<
    Omit<CobrarCuota, 'id' | 'cuenta_cobrar_id'>[]
  >([]);
  const [editingCuotaIndex, setEditingCuotaIndex] = useState<number | null>(
    null,
  );
  const [selectedCuotasToPay, setSelectedCuotasToPay] = useState<number[]>([]);
  const [currentCuotasList, setCurrentCuotasList] = useState<CobrarCuota[]>([]);

  const { delete: destroy } = useForm();
  const { cuentascobrar } = usePage<{ cuentascobrar: CuentasCobrarPaginate }>()
    .props;

  const { data, setData, post, put, processing, errors, reset } = useForm({
    concepto: '',
    detalles: '',
    total: '',
    saldo: '',
    estado: 'Pendiente',
    // fecha_pago: '',
    con_plan_pagos: false,
    cuotas: [] as Omit<CobrarCuota, 'id' | 'cuenta_cobrar_id'>[],
  });

  console.log(errors);

  const {
    data: cuotaData,
    setData: setCuotaData,
    post: postCuota,
    reset: resetCuota,
  } = useForm({
    numero_cuota: '',
    fecha_vencimiento: '',
    monto: '',
    estado: 'Pendiente',
  });

  const {
    data: pagoData,
    setData: setPagoData,
    post: postPago,
    processing: processingPago,
    reset: resetPago,
  } = useForm({
    cuotas_ids: [] as number[],
    fecha_pago: new Date().toISOString().split('T')[0],
    metodo_pago: 'efectivo',
    referencia: '',
    notas: '',
  });

  const handleDelete = (id: number) => {
    if (confirm('¿Estás seguro de eliminar el registro?')) {
      destroy(`/cuentasporcobrar/${id}`, {
        preserveScroll: true,
        preserveState: true,
        onSuccess: () => {
          console.log('Eliminado sin recargar estado');
          toast.success('Eliminado con exito');
        },
        onError: (errors) => {
          console.log('Error al eliminar: ' + errors[0] + ' : ' + errors[1]);
          toast.error(errors[1]);
        },
      });
    }
  };

  const handleEdit = (cuenta: CuentaCobrar) => {
    setEditingId(cuenta.id);
    setData({
      concepto: cuenta.concepto,
      detalles: cuenta.detalles,
      total: cuenta.total.toString(),
      saldo: cuenta.saldo.toString(),
      estado: cuenta.estado,
      // fecha_pago: cuenta.fecha_pago,
      con_plan_pagos: false,
    });
    setOpen(true);
  };

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();

    const formData = {
      concepto: data.concepto,
      detalles: data.detalles,
      total: data.total,
      saldo: data.saldo,
      estado: data.estado,
      // fecha_pago: data.fecha_pago,
      con_plan_pagos: data.con_plan_pagos,
      cuotas: data.con_plan_pagos ? cuotas : [],
    };

    if (editingId) {
      router.put(`/cuentasporcobrar/${editingId}`, formData, {
        onSuccess: () => {
          setOpen(false);
          reset();
          setEditingId(null);
          setCuotas([]);
        },
      });
    } else {
      router.post('/cuentasporcobrar', formData, {
        onSuccess: () => {
          setOpen(false);
          reset();
          setCuotas([]);
        },
      });
    }
  };

  const handleOpenChange = (newOpen: boolean) => {
    setOpen(newOpen);
    if (!newOpen) {
      reset();
      setEditingId(null);
      setCuotas([]);
    }
  };

  // Funciones para gestionar cuotas
  // const handleOpenCuotas = (cuentaId: number) => {
  const handleOpenCuotas = (cuenta: CuentaCobrar) => {
    setTotalCobrar(cuenta.total);
    setSelectedCuentaId(cuenta.id);
    setCuotas([]);
    setOpenCuotas(true);
  };

  const handleAddCuota = () => {
    if (
      !cuotaData.numero_cuota ||
      !cuotaData.fecha_vencimiento ||
      !cuotaData.monto
    ) {
      alert('Por favor completa todos los campos de la cuota');
      return;
    }

    if (editingCuotaIndex !== null) {
      // Editar cuota existente
      const updatedCuotas = [...cuotas];
      updatedCuotas[editingCuotaIndex] = {
        numero_cuota: parseInt(cuotaData.numero_cuota),
        fecha_vencimiento: cuotaData.fecha_vencimiento,
        monto: parseFloat(cuotaData.monto),
        estado: cuotaData.estado,
      };
      setCuotas(updatedCuotas);
      setEditingCuotaIndex(null);
    } else {
      // Agregar nueva cuota
      setCuotas([
        ...cuotas,
        {
          numero_cuota: parseInt(cuotaData.numero_cuota),
          fecha_vencimiento: cuotaData.fecha_vencimiento,
          monto: parseFloat(cuotaData.monto),
          estado: cuotaData.estado,
        },
      ]);
    }
    resetCuota();
  };

  const handleEditCuota = (index: number) => {
    const cuota = cuotas[index];
    setCuotaData({
      numero_cuota: cuota.numero_cuota.toString(),
      fecha_vencimiento: cuota.fecha_vencimiento,
      monto: cuota.monto.toString(),
      estado: cuota.estado,
    });
    setEditingCuotaIndex(index);
  };

  const handleDeleteCuota = (index: number) => {
    setCuotas(cuotas.filter((_, i) => i !== index));
  };

  const handleSaveCuotas = () => {
    if (selectedCuentaId) {
      const formData = {
        cuotas: cuotas,
        id: selectedCuentaId,
      };

      // postCuota(`/cuentasporcobrar/${selectedCuentaId}/cuotas`, {
      //   data: { cuotas },
      //   onSuccess: () => {
      //     setOpenCuotas(false);
      //     setCuotas([]);
      //     setSelectedCuentaId(null);
      //     resetCuota();
      //   },
      // });
      router.post(`/cuentasporcobrar/${selectedCuentaId}/cuotas`, formData, {
        onSuccess: () => {
          setOpenCuotas(false);
          setCuotas([]);
          setSelectedCuentaId(null);
          resetCuota();
        },
        onError: (e) => {
          console.log(e);
        },
      });
    }
  };

  const handleCloseCuotas = () => {
    setOpenCuotas(false);
    setCuotas([]);
    setSelectedCuentaId(null);
    setEditingCuotaIndex(null);
    resetCuota();
  };

  // Funciones para cobrar
  const handleOpenCobrar = (cuenta: CuentaCobrar) => {
    setSelectedCuentaId(cuenta.id);
    setCurrentCuotasList(cuenta.cuotas || []);
    setSelectedCuotasToPay([]);
    resetPago();
    setOpenCobrar(true);
  };

  const handleToggleCuota = (cuotaId: number) => {
    setSelectedCuotasToPay((prev) =>
      prev.includes(cuotaId)
        ? prev.filter((id) => id !== cuotaId)
        : [...prev, cuotaId],
    );
  };

  const handleSubmitPago = (e: React.FormEvent) => {
    e.preventDefault();

    if (selectedCuotasToPay.length === 0) {
      alert('Debes seleccionar al menos una cuota para pagar');
      return;
    }

    const formData = {
      ...pagoData,
      cuotas_ids: selectedCuotasToPay,
      total_cobro: calculateTotalSelected(),
    };

    if (selectedCuentaId) {
      // postPago(`/cuentasporcobrar/${selectedCuentaId}/cobrar`, {
      //   data: {
      //     ...pagoData,
      //     cuotas_ids: selectedCuotasToPay,
      //   },
      //   onSuccess: () => {
      //     setOpenCobrar(false);
      //     setSelectedCuentaId(null);
      //     setSelectedCuotasToPay([]);
      //     setCurrentCuotasList([]);
      //     resetPago();
      //   },
      // });
      router.post(`/cuentasporcobrar/${selectedCuentaId}/cobrar`, formData, {
        onSuccess: () => {
          setOpenCobrar(false);
          setSelectedCuentaId(null);
          setSelectedCuotasToPay([]);
          setCurrentCuotasList([]);
          resetPago();
        },
      });
    }
  };

  const calculateTotalSelected = () => {
    return currentCuotasList
      .filter((cuota) => selectedCuotasToPay.includes(cuota.id))
      .reduce((sum, cuota) => sum + Number(cuota.monto), 0);
  };

  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Cuentas por cobrar" />
      <div className="p-6">
        <div className="mb-4 flex items-center">
          <div className="me-5 text-2xl font-bold">
            Gestión de Cuentas por Cobrar
          </div>
          <Dialog open={open} onOpenChange={handleOpenChange}>
            <DialogTrigger asChild>
              <Button>
                <Plus className="mr-2 h-4 w-4" /> Nuevo
              </Button>
            </DialogTrigger>
            <DialogContent className="max-h-[90vh] max-w-3xl overflow-y-auto">
              <DialogHeader>
                <DialogTitle>
                  {editingId ? 'Editar' : 'Crear'} Cuenta por Cobrar
                </DialogTitle>
                <DialogDescription>
                  {editingId
                    ? 'Modifica los datos de la cuenta por cobrar'
                    : 'Completa los datos para crear una nueva cuenta por cobrar'}
                </DialogDescription>
              </DialogHeader>
              <form onSubmit={handleSubmit}>
                <div className="grid gap-4 py-4">
                  <div className="grid gap-2">
                    <Label htmlFor="concepto">Concepto</Label>
                    <Input
                      id="concepto"
                      value={data.concepto}
                      onChange={(e) => setData('concepto', e.target.value)}
                    />
                    {errors.concepto && (
                      <span className="text-sm text-red-500">
                        {errors.concepto}
                      </span>
                    )}
                  </div>

                  <div className="grid gap-2">
                    <Label htmlFor="detalles">Detalles</Label>
                    <Textarea
                      id="detalles"
                      value={data.detalles}
                      onChange={(e) => setData('detalles', e.target.value)}
                      rows={3}
                    />
                    {errors.detalles && (
                      <span className="text-sm text-red-500">
                        {errors.detalles}
                      </span>
                    )}
                  </div>

                  <div className="grid grid-cols-2 gap-4">
                    <div className="grid gap-2">
                      <Label htmlFor="total">Total</Label>
                      <Input
                        id="total"
                        type="number"
                        step="0.01"
                        value={data.total}
                        onChange={(e) => setData('total', e.target.value)}
                      />
                      {errors.total && (
                        <span className="text-sm text-red-500">
                          {errors.total}
                        </span>
                      )}
                    </div>
                    <div className="grid gap-2">
                      <Label htmlFor="saldo">Saldo</Label>
                      <Input
                        id="saldo"
                        type="number"
                        step="0.01"
                        value={data.saldo}
                        onChange={(e) => setData('saldo', e.target.value)}
                      />
                      {errors.saldo && (
                        <span className="text-sm text-red-500">
                          {errors.saldo}
                        </span>
                      )}
                    </div>
                  </div>

                  <div className="grid grid-cols-2 gap-4">
                    <div className="grid gap-2">
                      <Label htmlFor="estado">Estado</Label>
                      <Select
                        value={data.estado}
                        onValueChange={(value) => setData('estado', value)}
                      >
                        <SelectTrigger>
                          <SelectValue placeholder="Selecciona un estado" />
                        </SelectTrigger>
                        <SelectContent>
                          <SelectItem value="Pendiente">Pendiente</SelectItem>
                          <SelectItem value="Cancelado">Cancelado</SelectItem>
                        </SelectContent>
                      </Select>
                      {errors.estado && (
                        <span className="text-sm text-red-500">
                          {errors.estado}
                        </span>
                      )}
                    </div>
                    {/* <div className="grid gap-2">
                      <Label htmlFor="fecha_pago">Fecha de Pago</Label>
                      <Input
                        id="fecha_pago"
                        type="date"
                        value={data.fecha_pago}
                        onChange={(e) => setData('fecha_pago', e.target.value)}
                      />
                      {errors.fecha_pago && (
                        <span className="text-sm text-red-500">
                          {errors.fecha_pago}
                        </span>
                      )}
                    </div> */}
                  </div>

                  {/* Checkbox para plan de pagos */}
                  {!editingId && (
                    <div className="flex items-center space-x-2">
                      <Checkbox
                        id="con_plan_pagos"
                        checked={data.con_plan_pagos}
                        onCheckedChange={(checked) =>
                          setData('con_plan_pagos', checked as boolean)
                        }
                      />
                      <Label
                        htmlFor="con_plan_pagos"
                        className="cursor-pointer text-sm font-medium"
                      >
                        Crear plan de pagos (cuotas)
                      </Label>
                    </div>
                  )}

                  {/* Sección de cuotas si está activado */}
                  {!editingId && data.con_plan_pagos && (
                    <div className="space-y-4 rounded-lg border p-4">
                      <h3 className="font-semibold">Plan de Pagos</h3>

                      {/* Formulario para agregar cuota */}
                      <div className="rounded-lg border bg-muted/50 p-3">
                        <h4 className="mb-3 text-sm font-medium">
                          {editingCuotaIndex !== null ? 'Editar' : 'Agregar'}{' '}
                          Cuota
                        </h4>
                        <div className="grid grid-cols-2 gap-3">
                          <div className="grid gap-2">
                            <Label htmlFor="numero_cuota_nuevo">N° Cuota</Label>
                            <Input
                              id="numero_cuota_nuevo"
                              type="number"
                              value={cuotaData.numero_cuota}
                              onChange={(e) =>
                                setCuotaData('numero_cuota', e.target.value)
                              }
                            />
                          </div>
                          <div className="grid gap-2">
                            <Label htmlFor="fecha_vencimiento_nuevo">
                              Fecha Venc.
                            </Label>
                            <Input
                              id="fecha_vencimiento_nuevo"
                              type="date"
                              value={cuotaData.fecha_vencimiento}
                              onChange={(e) =>
                                setCuotaData(
                                  'fecha_vencimiento',
                                  e.target.value,
                                )
                              }
                            />
                          </div>
                          <div className="grid gap-2">
                            <Label htmlFor="monto_nuevo">Monto</Label>
                            <Input
                              id="monto_nuevo"
                              type="number"
                              step="0.01"
                              value={cuotaData.monto}
                              onChange={(e) =>
                                setCuotaData('monto', e.target.value)
                              }
                            />
                          </div>
                          <div className="grid gap-2">
                            <Label htmlFor="estado_cuota_nuevo">Estado</Label>
                            <Select
                              value={cuotaData.estado}
                              onValueChange={(value) =>
                                setCuotaData('estado', value)
                              }
                            >
                              <SelectTrigger>
                                <SelectValue />
                              </SelectTrigger>
                              <SelectContent>
                                <SelectItem value="pendiente">
                                  Pendiente
                                </SelectItem>
                                <SelectItem value="pagado">Pagado</SelectItem>
                                <SelectItem value="vencido">Vencido</SelectItem>
                              </SelectContent>
                            </Select>
                          </div>
                        </div>
                        <div className="mt-3 flex justify-end gap-2">
                          {editingCuotaIndex !== null && (
                            <Button
                              type="button"
                              variant="outline"
                              size="sm"
                              onClick={() => {
                                setEditingCuotaIndex(null);
                                resetCuota();
                              }}
                            >
                              Cancelar
                            </Button>
                          )}
                          <Button
                            type="button"
                            size="sm"
                            onClick={handleAddCuota}
                          >
                            {editingCuotaIndex !== null
                              ? 'Actualizar'
                              : 'Agregar'}
                          </Button>
                        </div>
                      </div>

                      {/* Lista de cuotas agregadas */}
                      {cuotas.length > 0 && (
                        <div className="rounded-lg border">
                          <Table>
                            <TableHeader>
                              <TableRow>
                                <TableHead>N° Cuota</TableHead>
                                <TableHead>Fecha Venc.</TableHead>
                                <TableHead>Monto</TableHead>
                                <TableHead>Estado</TableHead>
                                <TableHead className="text-right">
                                  Acciones
                                </TableHead>
                              </TableRow>
                            </TableHeader>
                            <TableBody>
                              {cuotas.map((cuota, index) => (
                                <TableRow key={index}>
                                  <TableCell>{cuota.numero_cuota}</TableCell>
                                  <TableCell>
                                    {cuota.fecha_vencimiento}
                                  </TableCell>
                                  <TableCell>
                                    {cuota.monto.toFixed(2)}
                                  </TableCell>
                                  <TableCell>{cuota.estado}</TableCell>
                                  <TableCell className="text-right">
                                    <Button
                                      type="button"
                                      variant="outline"
                                      size="icon"
                                      onClick={() => handleEditCuota(index)}
                                    >
                                      <Edit className="h-4 w-4" />
                                    </Button>
                                    <Button
                                      type="button"
                                      variant="outline"
                                      size="icon"
                                      className="ml-1"
                                      onClick={() => handleDeleteCuota(index)}
                                    >
                                      <X className="h-4 w-4" />
                                    </Button>
                                  </TableCell>
                                </TableRow>
                              ))}
                            </TableBody>
                          </Table>
                          <div className="border-t p-3">
                            <div className="flex justify-between font-semibold">
                              <span>Total Cuotas:</span>
                              <span>
                                {cuotas
                                  .reduce((sum, cuota) => sum + cuota.monto, 0)
                                  .toFixed(2)}
                              </span>
                            </div>
                          </div>
                        </div>
                      )}
                    </div>
                  )}
                </div>
                <DialogFooter>
                  <Button
                    type="button"
                    variant="outline"
                    onClick={() => handleOpenChange(false)}
                  >
                    Cancelar
                  </Button>
                  <Button
                    type="submit"
                    disabled={
                      processing ||
                      cuotas.reduce((sum, cuota) => sum + cuota.monto, 0) !=
                        Number(data.total)
                    }
                  >
                    {processing ? 'Guardando...' : 'Guardar'}
                  </Button>
                </DialogFooter>
              </form>
            </DialogContent>
          </Dialog>
        </div>

        {/* Dialog para gestionar cuotas (plan de pagos existente) */}
        <Dialog open={openCuotas} onOpenChange={setOpenCuotas}>
          <DialogContent className="max-h-[90vh] max-w-4xl overflow-y-auto">
            <DialogHeader>
              <DialogTitle>Plan de Pagos - Cuotas</DialogTitle>
              <DialogDescription>
                Gestiona las cuotas de pago para esta cuenta por cobrar
                {/* <p className="mt-3 text-[1rem] font-bold text-black"></p> */}
              </DialogDescription>
              <DialogDescription className="text-[1rem] font-bold text-black">
                TOTAL A COBRAR: {totalCobrar}
              </DialogDescription>
            </DialogHeader>

            <div className="space-y-4">
              {/* Formulario para agregar/editar cuota */}
              <div className="rounded-lg border p-4">
                <h3 className="mb-3 font-semibold">
                  {editingCuotaIndex !== null ? 'Editar' : 'Agregar'} Cuota
                </h3>
                <div className="grid grid-cols-2 gap-4">
                  <div className="grid gap-2">
                    <Label htmlFor="numero_cuota">Número de Cuota</Label>
                    <Input
                      id="numero_cuota"
                      type="number"
                      value={cuotaData.numero_cuota}
                      onChange={(e) =>
                        setCuotaData('numero_cuota', e.target.value)
                      }
                    />
                  </div>
                  <div className="grid gap-2">
                    <Label htmlFor="fecha_vencimiento">
                      Fecha de Vencimiento
                    </Label>
                    <Input
                      id="fecha_vencimiento"
                      type="date"
                      value={cuotaData.fecha_vencimiento}
                      onChange={(e) =>
                        setCuotaData('fecha_vencimiento', e.target.value)
                      }
                    />
                  </div>
                  <div className="grid gap-2">
                    <Label htmlFor="monto">Monto</Label>
                    <Input
                      id="monto"
                      type="number"
                      step="0.01"
                      value={cuotaData.monto}
                      onChange={(e) => setCuotaData('monto', e.target.value)}
                    />
                  </div>
                  <div className="grid gap-2">
                    <Label htmlFor="estado_cuota">Estado</Label>
                    <Select
                      value={cuotaData.estado}
                      onValueChange={(value) => setCuotaData('estado', value)}
                    >
                      <SelectTrigger>
                        <SelectValue placeholder="Selecciona un estado" />
                      </SelectTrigger>
                      <SelectContent>
                        <SelectItem value="pendiente">Pendiente</SelectItem>
                        <SelectItem value="pagado">Pagado</SelectItem>
                        <SelectItem value="vencido">Vencido</SelectItem>
                      </SelectContent>
                    </Select>
                  </div>
                </div>
                <div className="mt-3 flex justify-end gap-2">
                  {editingCuotaIndex !== null && (
                    <Button
                      type="button"
                      variant="outline"
                      onClick={() => {
                        setEditingCuotaIndex(null);
                        resetCuota();
                      }}
                    >
                      Cancelar Edición
                    </Button>
                  )}
                  <Button type="button" onClick={handleAddCuota}>
                    {editingCuotaIndex !== null
                      ? 'Actualizar Cuota'
                      : 'Agregar Cuota'}
                  </Button>
                </div>
              </div>

              {/* Lista de cuotas */}
              {cuotas.length > 0 && (
                <div className="rounded-lg border">
                  <Table>
                    <TableHeader>
                      <TableRow>
                        <TableHead>N° Cuota</TableHead>
                        <TableHead>Fecha Venc.</TableHead>
                        <TableHead>Monto</TableHead>
                        <TableHead>Estado</TableHead>
                        <TableHead className="text-right">Acciones</TableHead>
                      </TableRow>
                    </TableHeader>
                    <TableBody>
                      {cuotas.map((cuota, index) => (
                        <TableRow key={index}>
                          <TableCell>{cuota.numero_cuota}</TableCell>
                          <TableCell>{cuota.fecha_vencimiento}</TableCell>
                          <TableCell>{cuota.monto.toFixed(2)}</TableCell>
                          <TableCell>{cuota.estado}</TableCell>
                          <TableCell className="text-right">
                            <Button
                              variant="outline"
                              size="icon"
                              onClick={() => handleEditCuota(index)}
                            >
                              <Edit className="h-4 w-4" />
                            </Button>
                            <Button
                              variant="outline"
                              size="icon"
                              className="ml-1"
                              onClick={() => handleDeleteCuota(index)}
                            >
                              <X className="h-4 w-4" />
                            </Button>
                          </TableCell>
                        </TableRow>
                      ))}
                    </TableBody>
                  </Table>
                  <div className="p-4">
                    <div className="flex justify-between text-sm font-semibold">
                      <span>Total:</span>
                      <span>
                        {cuotas
                          .reduce((sum, cuota) => sum + cuota.monto, 0)
                          .toFixed(2)}
                      </span>
                    </div>
                  </div>
                </div>
              )}
            </div>

            <DialogFooter>
              <Button
                type="button"
                variant="outline"
                onClick={handleCloseCuotas}
              >
                Cancelar
              </Button>
              <Button
                type="button"
                onClick={handleSaveCuotas}
                disabled={
                  cuotas.length === 0 ||
                  cuotas.reduce((sum, cuota) => sum + cuota.monto, 0) !=
                    totalCobrar
                }
              >
                Guardar Plan de Pagos
              </Button>
            </DialogFooter>
          </DialogContent>
        </Dialog>

        {/* Dialog para cobrar */}
        <Dialog open={openCobrar} onOpenChange={setOpenCobrar}>
          <DialogContent className="max-h-[90vh] max-w-3xl overflow-y-auto">
            <DialogHeader>
              <DialogTitle>Registrar Cobro</DialogTitle>
              <DialogDescription>
                Selecciona las cuotas que deseas cobrar
              </DialogDescription>
            </DialogHeader>

            <form onSubmit={handleSubmitPago}>
              <div className="space-y-4">
                {/* Lista de cuotas pendientes */}
                <div className="rounded-lg border">
                  <Table>
                    <TableHeader>
                      <TableRow>
                        <TableHead className="w-12"></TableHead>
                        <TableHead>N° Cuota</TableHead>
                        <TableHead>Fecha Venc.</TableHead>
                        <TableHead>Monto</TableHead>
                        <TableHead>Estado</TableHead>
                      </TableRow>
                    </TableHeader>
                    <TableBody>
                      {currentCuotasList
                        .filter((cuota) => cuota.estado !== 'Pagado')
                        .map((cuota) => (
                          <TableRow key={cuota.id}>
                            <TableCell>
                              <Checkbox
                                checked={selectedCuotasToPay.includes(cuota.id)}
                                onCheckedChange={() => {
                                  cuota.estado === 'pendiente'
                                    ? handleToggleCuota(cuota.id)
                                    : '';
                                }}
                              />
                            </TableCell>
                            <TableCell>{cuota.numero_cuota}</TableCell>
                            <TableCell>{cuota.fecha_vencimiento}</TableCell>
                            <TableCell>
                              {Number(cuota.monto).toFixed(2)}
                            </TableCell>
                            <TableCell>
                              <span
                                className={`rounded-full px-2 py-1 text-xs ${
                                  cuota.estado === 'Vencido'
                                    ? 'bg-red-100 text-red-800'
                                    : 'bg-yellow-100 text-yellow-800'
                                }`}
                              >
                                {cuota.estado}
                              </span>
                            </TableCell>
                          </TableRow>
                        ))}
                    </TableBody>
                  </Table>

                  {selectedCuotasToPay.length > 0 && (
                    <div className="border-t bg-muted/50 p-4">
                      <div className="flex justify-between text-lg font-semibold">
                        <span>Total a Cobrar:</span>
                        <span>
                          {Number(calculateTotalSelected()).toFixed(2)}
                        </span>
                      </div>
                    </div>
                  )}
                </div>

                {/* Datos del pago */}
                <div className="space-y-4 rounded-lg border p-4">
                  <h3 className="font-semibold">Información del Pago</h3>

                  <div className="grid grid-cols-2 gap-4">
                    {/* <div className="grid gap-2">
                      <Label htmlFor="fecha_pago_cobro">Fecha de Pago</Label>
                      <Input
                        id="fecha_pago_cobro"
                        type="date"
                        value={pagoData.fecha_pago}
                        onChange={(e) =>
                          setPagoData('fecha_pago', e.target.value)
                        }
                        required
                      />
                    </div> */}

                    <div className="grid gap-2">
                      <Label htmlFor="metodo_pago">Método de Pago</Label>
                      <Select
                        value={pagoData.metodo_pago}
                        onValueChange={(value) =>
                          setPagoData('metodo_pago', value)
                        }
                      >
                        <SelectTrigger>
                          <SelectValue />
                        </SelectTrigger>
                        <SelectContent>
                          <SelectItem value="efectivo">Efectivo</SelectItem>
                          <SelectItem value="transferencia">
                            Transferencia
                          </SelectItem>
                          <SelectItem value="tarjeta">Tarjeta</SelectItem>
                          <SelectItem value="qr">QR</SelectItem>
                        </SelectContent>
                      </Select>
                    </div>
                  </div>

                  {/* <div className="grid gap-2">
                    <Label htmlFor="referencia">
                      Referencia / N° Transacción
                    </Label>
                    <Input
                      id="referencia"
                      value={pagoData.referencia}
                      onChange={(e) =>
                        setPagoData('referencia', e.target.value)
                      }
                      placeholder="Opcional"
                    />
                  </div> */}

                  {/* <div className="grid gap-2">
                    <Label htmlFor="notas">Notas</Label>
                    <Textarea
                      id="notas"
                      value={pagoData.notas}
                      onChange={(e) => setPagoData('notas', e.target.value)}
                      rows={3}
                      placeholder="Observaciones adicionales..."
                    />
                  </div> */}
                </div>
              </div>

              <DialogFooter className="mt-4">
                <Button
                  type="button"
                  variant="outline"
                  onClick={() => setOpenCobrar(false)}
                >
                  Cancelar
                </Button>
                <Button
                  type="submit"
                  disabled={processingPago || selectedCuotasToPay.length === 0}
                >
                  {processingPago ? 'Procesando...' : 'Registrar Cobro'}
                </Button>
              </DialogFooter>
            </form>
          </DialogContent>
        </Dialog>

        {cuentascobrar.data.length > 0 ? (
          <>
            <Table>
              <TableHeader>
                <TableRow>
                  <TableHead className="w-[100px]">ID</TableHead>
                  <TableHead>Cliente</TableHead>
                  <TableHead>Total</TableHead>
                  <TableHead>A Cuenta</TableHead>
                  <TableHead>Saldo</TableHead>
                  <TableHead>Estado</TableHead>
                  <TableHead>Acción</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {cuentascobrar.data.map((cuenta) => (
                  <TableRow key={cuenta.id}>
                    <TableCell className="font-medium">{cuenta.id}</TableCell>
                    <TableCell>{cuenta.contrato_id}</TableCell>
                    <TableCell>{cuenta.total}</TableCell>
                    <TableCell>{cuenta.total - cuenta.saldo}</TableCell>
                    <TableCell>{cuenta.saldo}</TableCell>
                    <TableCell>{cuenta.estado}</TableCell>
                    <TableCell>
                      <div className="flex gap-1">
                        {!!cuenta.plan_pagos && (
                          <Button
                            variant="outline"
                            size="sm"
                            onClick={() => handleOpenCobrar(cuenta)}
                          >
                            <Banknote className="mr-1 h-4 w-4" /> Cobrar
                          </Button>
                        )}

                        {!cuenta.plan_pagos && (
                          <Button
                            variant="outline"
                            size="sm"
                            // onClick={() => handleOpenCuotas(cuenta.id)}
                            onClick={() => handleOpenCuotas(cuenta)}
                          >
                            <ClipboardList className="mr-1 h-4 w-4" /> Plan
                            Pagos
                          </Button>
                        )}

                        <Button
                          variant="outline"
                          size="icon"
                          onClick={() => handleEdit(cuenta)}
                        >
                          <Edit className="h-4 w-4" />
                        </Button>
                        <Button
                          disabled={processing}
                          size="icon"
                          variant="destructive"
                          onClick={() => handleDelete(cuenta.id)}
                        >
                          <Trash2 className="h-4 w-4" />
                        </Button>
                      </div>
                    </TableCell>
                  </TableRow>
                ))}
              </TableBody>
            </Table>
            <div className="my-2">
              <CustomPagination links={cuentascobrar.links} />
            </div>
          </>
        ) : (
          <div className="py-10 text-center text-muted-foreground">
            No hay cuentas por cobrar registradas
          </div>
        )}
      </div>
    </AppLayout>
  );
}
