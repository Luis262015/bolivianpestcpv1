import { Button } from '@/components/ui/button';
import {
  Dialog,
  DialogContent,
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
import { router, useForm } from '@inertiajs/react';
import axios from 'axios';
import { useEffect, useState } from 'react';

interface Empresa {
  id: number;
  nombre: string;
}
interface Almacen {
  id: number;
  nombre: string;
}

interface TrampaTipo {
  id: number;
  nombre: string;
}

interface Trampa {
  id: number;
  almacen_id: number;
  mapa_id: number;
  trampa_tipo_id: number;
  numero: number;
  tipo: string;
  posx: number;
  posy: number;
  estado: string;
  trampa_tipo: TrampaTipo;
}

interface Especie {
  id: number;
  nombre: string;
}

interface TrampaEspecieSeguimientos {
  id?: number;
  trampa_seguimiento_id?: number;
  trampa_id: number;
  especie_id: number;
  cantidad: number;
}

interface TrampaRoedoresSeguimiento {
  id?: number;
  trampa_seguimiento_id?: number;
  trampa_id: number;
  cantidad: number;
  inicial: number;
  merma: number;
  actual: number;
}

interface TrampaSeguimiento {
  id?: number;
  almacen_id: number;
  mapa_id: number;
  trampa_especies_seguimientos?: TrampaEspecieSeguimientos[];
  trampa_roedores_seguimientos?: TrampaRoedoresSeguimiento[];
}

interface ModalTrampasProps {
  open: boolean;
  onClose: () => void;
  empresas: Empresa[];
  almacenes: Almacen[];
  seguimiento?: TrampaSeguimiento | null;
}

export default function ModalTrampas({
  open,
  onClose,
  empresas,
  almacenes,
  seguimiento = null,
}: ModalTrampasProps) {
  const { data, setData, post, put, processing, errors, reset } = useForm({
    empresa_id: '',
    almacen_id: '',
    mapa_id: '',
  });

  const [almacenesFiltrados, setAlmacenesFiltrados] =
    useState<Almacen[]>(almacenes);
  const [trampasFiltrados, setTrampasFiltrados] = useState<Trampa[]>([]);
  const [especies, setEspecies] = useState<Especie[]>([]);

  // Estado para seguimientos de insectos
  const [seguimientosInsectos, setSeguimientosInsectos] = useState<
    Record<number, TrampaEspecieSeguimientos[]>
  >({});

  // Estado para seguimientos de roedores
  const [seguimientosRoedores, setSeguimientosRoedores] = useState<
    Record<number, TrampaRoedoresSeguimiento>
  >({});

  const isEditMode = !!seguimiento?.id;

  // Cargar datos cuando es modo edición
  useEffect(() => {
    if (seguimiento && open) {
      // Cargar empresa y almacén
      const almacen = almacenes.find((a) => a.id === seguimiento.almacen_id);
      if (almacen) {
        setData({
          empresa_id: '', // Necesitarías obtener el empresa_id del almacén
          almacen_id: seguimiento.almacen_id.toString(),
          mapa_id: seguimiento.mapa_id.toString(),
        });

        // Cargar trampas del almacén
        loadTrampas(seguimiento.almacen_id.toString());

        // Cargar seguimientos existentes
        if (seguimiento.trampa_especies_seguimientos) {
          const insectosMap: Record<number, TrampaEspecieSeguimientos[]> = {};
          seguimiento.trampa_especies_seguimientos.forEach((seg) => {
            if (!insectosMap[seg.trampa_id]) {
              insectosMap[seg.trampa_id] = [];
            }
            insectosMap[seg.trampa_id].push(seg);
          });
          setSeguimientosInsectos(insectosMap);
        }

        if (seguimiento.trampa_roedores_seguimientos) {
          const roedoresMap: Record<number, TrampaRoedoresSeguimiento> = {};
          seguimiento.trampa_roedores_seguimientos.forEach((seg) => {
            roedoresMap[seg.trampa_id] = seg;
          });
          setSeguimientosRoedores(roedoresMap);
        }
      }
    }
  }, [seguimiento, open]);

  const loadTrampas = async (almacenId: string) => {
    try {
      const response = await axios.get(
        `/trampaseguimientos/${almacenId}/trampas`,
      );
      setTrampasFiltrados(response.data);

      const responseEspecies = await axios.get('/trampaseguimientos/especies');
      setEspecies(responseEspecies.data);

      // Inicializar seguimientos vacíos para nuevas trampas
      if (!isEditMode) {
        const insectosInit: Record<number, TrampaEspecieSeguimientos[]> = {};
        const roedoresInit: Record<number, TrampaRoedoresSeguimiento> = {};

        response.data.forEach((trampa: Trampa) => {
          if (trampa.trampa_tipo.nombre === 'insecto') {
            insectosInit[trampa.id] = [];
          } else {
            roedoresInit[trampa.id] = {
              trampa_id: trampa.id,
              cantidad: 0,
              inicial: 0,
              merma: 0,
              actual: 0,
            };
          }
        });

        setSeguimientosInsectos(insectosInit);
        setSeguimientosRoedores(roedoresInit);
      }
    } catch (error) {
      console.error('Error al cargar trampas:', error);
      setTrampasFiltrados([]);
    }
  };

  // Agregar especie a seguimiento de insectos
  const agregarEspecieInsecto = (trampaId: number) => {
    setSeguimientosInsectos((prev) => ({
      ...prev,
      [trampaId]: [
        ...(prev[trampaId] || []),
        {
          trampa_id: trampaId,
          especie_id: especies[0]?.id || 0,
          cantidad: 0,
        },
      ],
    }));
  };

  // Actualizar especie en seguimiento de insectos
  const actualizarEspecieInsecto = (
    trampaId: number,
    index: number,
    field: keyof TrampaEspecieSeguimientos,
    value: any,
  ) => {
    setSeguimientosInsectos((prev) => ({
      ...prev,
      [trampaId]: prev[trampaId].map((seg, i) =>
        i === index ? { ...seg, [field]: value } : seg,
      ),
    }));
  };

  // Eliminar especie de seguimiento de insectos
  const eliminarEspecieInsecto = (trampaId: number, index: number) => {
    setSeguimientosInsectos((prev) => ({
      ...prev,
      [trampaId]: prev[trampaId].filter((_, i) => i !== index),
    }));
  };

  // Actualizar seguimiento de roedores
  const actualizarRoedor = (
    trampaId: number,
    field: keyof TrampaRoedoresSeguimiento,
    value: number,
  ) => {
    setSeguimientosRoedores((prev) => {
      const current = prev[trampaId] || {
        trampa_id: trampaId,
        cantidad: 0,
        inicial: 0,
        merma: 0,
        actual: 0,
      };

      const updated = { ...current, [field]: value };

      // Calcular "actual" automáticamente
      if (field === 'inicial' || field === 'merma') {
        updated.actual = updated.inicial - updated.merma;
      }

      return {
        ...prev,
        [trampaId]: updated,
      };
    });
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();

    const payload = {
      almacen_id: parseInt(data.almacen_id),
      mapa_id: parseInt(data.mapa_id) || trampasFiltrados[0]?.mapa_id,
      trampa_especies_seguimientos: Object.values(seguimientosInsectos).flat(),
      trampa_roedores_seguimientos: Object.values(seguimientosRoedores),
    };

    try {
      if (isEditMode) {
        router.put(`/trampaseguimientos/${seguimiento.id}`, payload as any, {
          preserveState: true,
        });
      } else {
        router.post('/trampaseguimientos', payload as any, {
          preserveState: true,
        });
      }

      // if (isEditMode) {
      //   await axios.put(`/trampaseguimientos/${seguimiento.id}`, payload);
      // } else {
      //   await axios.post('/trampaseguimientos', payload);
      // }

      reset();
      setSeguimientosInsectos({});
      setSeguimientosRoedores({});
      setTrampasFiltrados([]);
      onClose();
    } catch (error) {
      console.error('Error al guardar seguimiento:', error);
    }
  };

  return (
    <Dialog
      open={open}
      onOpenChange={(isOpen) => {
        if (!isOpen) {
          reset();
          setSeguimientosInsectos({});
          setSeguimientosRoedores({});
          setTrampasFiltrados([]);
          onClose();
        }
      }}
    >
      <DialogContent className="max-h-[90vh] max-w-4xl overflow-y-auto">
        <DialogHeader>
          <DialogTitle>
            {isEditMode ? 'Editar' : 'Nuevo'} seguimiento de trampas
          </DialogTitle>
        </DialogHeader>

        <form onSubmit={handleSubmit} className="space-y-4">
          <div className="grid grid-cols-1 gap-5 md:grid-cols-2">
            <div className="space-y-2">
              <Label>Empresa *</Label>
              <Select
                value={data.empresa_id}
                onValueChange={async (v) => {
                  setData('empresa_id', v);
                  setData('almacen_id', '');

                  if (v) {
                    try {
                      const response = await axios.get(
                        `/empresas/${v}/almacenes`,
                      );
                      setAlmacenesFiltrados(response.data);
                    } catch (error) {
                      console.error('Error al cargar almacenes:', error);
                      setAlmacenesFiltrados([]);
                    }
                  } else {
                    setAlmacenesFiltrados([]);
                  }
                }}
                disabled={isEditMode}
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
                <p className="text-sm text-red-500">{errors.empresa_id}</p>
              )}
            </div>

            <div className="space-y-2">
              <Label>Almacén *</Label>
              <Select
                value={data.almacen_id}
                onValueChange={async (v) => {
                  setData('almacen_id', v);
                  if (v) {
                    loadTrampas(v);
                  } else {
                    setTrampasFiltrados([]);
                  }
                }}
                disabled={isEditMode}
              >
                <SelectTrigger>
                  <SelectValue placeholder="Seleccionar almacén" />
                </SelectTrigger>
                <SelectContent>
                  {almacenesFiltrados.map((a) => (
                    <SelectItem key={a.id} value={a.id.toString()}>
                      {a.nombre}
                    </SelectItem>
                  ))}
                </SelectContent>
              </Select>
            </div>
          </div>

          {trampasFiltrados.length > 0 && (
            <div className="mt-6 space-y-6">
              <h3 className="text-lg font-semibold">Seguimiento de Trampas</h3>

              {trampasFiltrados.map((trampa) => (
                <div
                  key={trampa.id}
                  className="space-y-4 rounded-lg border p-4"
                >
                  <div className="flex items-center justify-between">
                    <div>
                      <h4 className="font-medium">Trampa #{trampa.numero}</h4>
                      <p className="text-sm text-gray-600">
                        Tipo: {trampa.trampa_tipo.nombre}
                      </p>
                    </div>
                  </div>

                  {trampa.trampa_tipo.nombre === 'insecto' ? (
                    <div className="space-y-3">
                      <div className="flex items-center justify-between">
                        <Label>Especies capturadas</Label>
                        <Button
                          type="button"
                          size="sm"
                          onClick={() => agregarEspecieInsecto(trampa.id)}
                        >
                          + Agregar Especie
                        </Button>
                      </div>

                      {seguimientosInsectos[trampa.id]?.map((seg, index) => (
                        <div
                          key={index}
                          className="grid grid-cols-3 items-end gap-3"
                        >
                          <div className="space-y-1">
                            <Label className="text-xs">Especie</Label>
                            <Select
                              value={seg.especie_id.toString()}
                              onValueChange={(v) =>
                                actualizarEspecieInsecto(
                                  trampa.id,
                                  index,
                                  'especie_id',
                                  parseInt(v),
                                )
                              }
                            >
                              <SelectTrigger>
                                <SelectValue />
                              </SelectTrigger>
                              <SelectContent>
                                {especies.map((esp) => (
                                  <SelectItem
                                    key={esp.id}
                                    value={esp.id.toString()}
                                  >
                                    {esp.nombre}
                                  </SelectItem>
                                ))}
                              </SelectContent>
                            </Select>
                          </div>

                          <div className="space-y-1">
                            <Label className="text-xs">Cantidad</Label>
                            <Input
                              type="number"
                              min="0"
                              value={seg.cantidad}
                              onChange={(e) =>
                                actualizarEspecieInsecto(
                                  trampa.id,
                                  index,
                                  'cantidad',
                                  parseInt(e.target.value) || 0,
                                )
                              }
                            />
                          </div>

                          <Button
                            type="button"
                            variant="destructive"
                            size="sm"
                            onClick={() =>
                              eliminarEspecieInsecto(trampa.id, index)
                            }
                          >
                            Eliminar
                          </Button>
                        </div>
                      ))}
                    </div>
                  ) : (
                    <div className="grid grid-cols-2 gap-4 md:grid-cols-4">
                      <div className="space-y-1">
                        <Label className="text-xs">Cantidad</Label>
                        <Input
                          type="number"
                          min="0"
                          value={seguimientosRoedores[trampa.id]?.cantidad || 0}
                          onChange={(e) =>
                            actualizarRoedor(
                              trampa.id,
                              'cantidad',
                              parseInt(e.target.value) || 0,
                            )
                          }
                        />
                      </div>

                      <div className="space-y-1">
                        <Label className="text-xs">Inicial</Label>
                        <Input
                          type="number"
                          min="0"
                          value={seguimientosRoedores[trampa.id]?.inicial || 0}
                          onChange={(e) =>
                            actualizarRoedor(
                              trampa.id,
                              'inicial',
                              parseInt(e.target.value) || 0,
                            )
                          }
                        />
                      </div>

                      <div className="space-y-1">
                        <Label className="text-xs">Merma</Label>
                        <Input
                          type="number"
                          min="0"
                          value={seguimientosRoedores[trampa.id]?.merma || 0}
                          onChange={(e) =>
                            actualizarRoedor(
                              trampa.id,
                              'merma',
                              parseInt(e.target.value) || 0,
                            )
                          }
                        />
                      </div>

                      <div className="space-y-1">
                        <Label className="text-xs">Actual</Label>
                        <Input
                          type="number"
                          value={seguimientosRoedores[trampa.id]?.actual || 0}
                          disabled
                          className="bg-gray-100"
                        />
                      </div>
                    </div>
                  )}
                </div>
              ))}
            </div>
          )}

          <div className="flex justify-end gap-3 pt-4">
            <Button
              type="button"
              variant="outline"
              onClick={() => {
                reset();
                setSeguimientosInsectos({});
                setSeguimientosRoedores({});
                setTrampasFiltrados([]);
                onClose();
              }}
            >
              Cancelar
            </Button>
            <Button
              type="submit"
              disabled={processing || trampasFiltrados.length === 0}
            >
              {processing
                ? 'Guardando...'
                : isEditMode
                  ? 'Actualizar'
                  : 'Guardar'}
            </Button>
          </div>
        </form>
      </DialogContent>
    </Dialog>
  );
}
// ----------------------------------------------------
// import {
//   Dialog,
//   DialogContent,
//   DialogHeader,
//   DialogTitle,
// } from '@/components/ui/dialog';
// import { Label } from '@/components/ui/label';
// import {
//   Select,
//   SelectContent,
//   SelectItem,
//   SelectTrigger,
//   SelectValue,
// } from '@/components/ui/select';
// import { useForm } from '@inertiajs/react';
// import axios from 'axios';
// import { useState } from 'react';

// interface Empresa {
//   id: number;
//   nombre: string;
// }
// interface Almacen {
//   id: number;
//   nombre: string;
// }

// interface TrampaTipo {
//   id: number;
//   nombre: string;
// }

// interface Trampa {
//   id: number;
//   almacen_id: number;
//   mapa_id: number;
//   trampa_tipo_id: number;
//   numero: number;
//   tipo: string;
//   posx: number;
//   posy: number;
//   estado: string;
//   trampa_tipo: TrampaTipo;
// }

// interface Especie {
//   id: number;
//   nombre: string;
// }

// interface TrampaEspecieSeguimientos {
//   id: number;
//   trampa_seguimiento_id: number;
//   trampa_id: number;
//   especie_id: number;
//   cantidad: number;
// }

// interface TrampaRoedoresSeguimiento {
//   id: number;
//   trampa_seguimiento_id: number;
//   trampa_id: number;
//   cantidad: number;
//   inicial: number;
//   merma: number;
//   actual: number;
// }

// interface TrampaSeguimiento {
//   id: number;
//   almacen_id: number;
//   mapa_id: number;
// }

// interface ModalTrampasProps {
//   open: boolean;
//   onClose: () => void;
//   empresas: Empresa[];
//   almacenes: Almacen[];
// }

// export default function ModalTrampas({
//   open,
//   onClose,
//   empresas,
//   almacenes,
// }: ModalTrampasProps) {
//   const { data, setData, post, processing, errors, reset } = useForm({
//     empresa_id: '',
//     almacen_id: '',
//   });
//   const [almacenesFiltrados, setAlmacenesFiltrados] =
//     useState<Almacen[]>(almacenes);
//   const [trampasFiltrados, setTrampasFiltrados] = useState<Trampa[]>();

//   const [especies, setEspecies] = useState<Especie[]>();

//   return (
//     <Dialog
//       open={open}
//       onOpenChange={(isOpen) => {
//         if (!isOpen) onClose();
//       }}
//     >
//       <DialogContent>
//         <DialogHeader>
//           <DialogTitle>Nuevo seguimiento de trampas</DialogTitle>
//         </DialogHeader>
//         <div className="space-y-4">
//           <div className="grid grid-cols-1 gap-5 md:grid-cols-2">
//             <div className="space-y-2">
//               <Label>Empresa *</Label>
//               {/* <Select
//                     value={data.empresa_id}
//                     onValueChange={(v) => setData('empresa_id', v)}
//                   > */}
//               <Select
//                 value={data.empresa_id}
//                 onValueChange={async (v) => {
//                   setData('empresa_id', v);
//                   setData('almacen_id', ''); // resetear almacén seleccionado

//                   if (v) {
//                     try {
//                       const response = await axios.get(
//                         `/empresas/${v}/almacenes`,
//                       );
//                       setAlmacenesFiltrados(response.data);
//                     } catch (error) {
//                       console.error('Error al cargar almacenes:', error);
//                       setAlmacenesFiltrados([]);
//                     }
//                   } else {
//                     setAlmacenesFiltrados([]);
//                   }
//                 }}
//               >
//                 <SelectTrigger>
//                   <SelectValue placeholder="Seleccionar empresa" />
//                 </SelectTrigger>
//                 <SelectContent>
//                   {empresas.map((e) => (
//                     <SelectItem key={e.id} value={e.id.toString()}>
//                       {e.nombre}
//                     </SelectItem>
//                   ))}
//                 </SelectContent>
//               </Select>
//               {errors.empresa_id && (
//                 <p className="text-sm text-red-500">
//                   {errors.empresa_id || 'Error en empresa'}
//                 </p>
//               )}
//             </div>
//             <div className="space-y-2">
//               <Label>Almacén *</Label>
//               <Select
//                 value={data.almacen_id}
//                 onValueChange={async (v) => {
//                   setData('almacen_id', v);
//                   if (v) {
//                     try {
//                       const response = await axios.get(
//                         `/seguimientos/${v}/trampas`,
//                       );
//                       console.log('RESPONSE *****');
//                       console.log(response.data);
//                       setTrampasFiltrados(response.data);

//                       const responseA = await axios.get(
//                         `/seguimientos/especies`,
//                       );
//                       console.log(responseA);
//                       setEspecies(responseA.data);
//                     } catch (error) {
//                       console.error('Error al cargar almacenes:', error);
//                       setTrampasFiltrados([]);
//                     }
//                   } else {
//                     setTrampasFiltrados([]);
//                   }
//                 }}
//               >
//                 <SelectTrigger>
//                   <SelectValue placeholder="Seleccionar almacén" />
//                 </SelectTrigger>
//                 <SelectContent>
//                   {almacenesFiltrados.map((a) => (
//                     <SelectItem key={a.id} value={a.id.toString()}>
//                       {a.nombre}
//                     </SelectItem>
//                   ))}
//                 </SelectContent>
//               </Select>
//             </div>
//             <div>
//               {trampasFiltrados?.map((a) => (
//                 <>
//                   <div>{a.numero}</div>
//                   <div>{a.trampa_tipo.nombre}</div>
//                 </>
//               ))}
//             </div>
//           </div>
//         </div>
//       </DialogContent>
//     </Dialog>
//   );
// }
