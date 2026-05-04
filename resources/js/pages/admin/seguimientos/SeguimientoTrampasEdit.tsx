import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select';
import axios from 'axios';
import { useEffect, useState } from 'react';

/* ======================= */

interface TrampaTipo {
  id: number;
  nombre: string;
}

interface Trampa {
  id: number;
  identificador: string;
  trampa_tipo: TrampaTipo;
}

interface Especie {
  id: number;
  nombre: string;
}

/* ======================= */

export interface TrampaEspecieSeguimientos {
  trampa_id: number;
  especie_id: number;
  cantidad: number;
}

export interface TrampaRoedoresSeguimiento {
  trampa_id: number;
  observacion?: string;
  cantidad: number;
  inicial: number;
  merma: number;
  actual: number;
}

interface Props {
  almacenId: number;
  tipoSeguimiento: string;
  value: {
    trampa_especies_seguimientos: TrampaEspecieSeguimientos[];
    trampa_roedores_seguimientos: TrampaRoedoresSeguimiento[];
  };
  onChange: (value: Props['value']) => void;
}

/* ======================= */

export default function SeguimientoTrampasEdit({
  almacenId,
  tipoSeguimiento,
  value,
  onChange,
}: Props) {
  const [trampas, setTrampas] = useState<Trampa[]>([]);
  const [especies, setEspecies] = useState<Especie[]>([]);

  const [insectos, setInsectos] = useState<
    Record<number, TrampaEspecieSeguimientos[]>
  >({});

  const [roedores, setRoedores] = useState<
    Record<number, TrampaRoedoresSeguimiento>
  >({});

  const [initialized, setInitialized] = useState(false);

  /* ======================= */
  /* CARGA INICIAL */
  /* ======================= */

  useEffect(() => {
    if (!almacenId) return;

    const load = async () => {
      const trampasRes = await axios.get(
        `/trampaseguimientos/${almacenId}/trampas`,
      );
      const especiesRes = await axios.get('/trampaseguimientos/especies');

      setTrampas(trampasRes.data);
      setEspecies(especiesRes.data);
    };

    load();
  }, [almacenId]);

  /* ======================= */
  /* INIT DESDE VALUE */
  /* ======================= */

  useEffect(() => {
    if (!trampas.length) return;
    if (initialized) return;

    console.log('✅ INIT DESDE VALUE:', value);

    const insectosMap: Record<number, TrampaEspecieSeguimientos[]> = {};
    const roedoresMap: Record<number, TrampaRoedoresSeguimiento> = {};

    // Inicializar estructuras
    trampas.forEach((t) => {
      if (t.trampa_tipo.nombre === 'insecto') {
        insectosMap[t.id] = [];
      } else {
        roedoresMap[t.id] = {
          trampa_id: t.id,
          observacion: '',
          cantidad: 0,
          inicial: 0,
          actual: 0,
          merma: 0,
        };
      }
    });

    // Cargar insectos
    value.trampa_especies_seguimientos.forEach((i) => {
      const trampaId = Number(i.trampa_id);

      if (!insectosMap[trampaId]) {
        insectosMap[trampaId] = [];
      }

      insectosMap[trampaId].push({
        trampa_id: trampaId,
        especie_id: Number(i.especie_id),
        cantidad: Number(i.cantidad),
      });
    });

    // Cargar roedores
    value.trampa_roedores_seguimientos.forEach((r) => {
      const trampaId = Number(r.trampa_id);

      roedoresMap[trampaId] = {
        trampa_id: trampaId,
        observacion: r.observacion ?? '',
        cantidad: Number(r.cantidad),
        inicial: Number(r.inicial),
        actual: Number(r.actual),
        merma: Number(r.inicial) - Number(r.actual),
      };
    });

    setInsectos(insectosMap);
    setRoedores(roedoresMap);
    setInitialized(true);
  }, [trampas, value, initialized]);

  /* ======================= */
  /* SYNC AL PADRE */
  /* ======================= */

  useEffect(() => {
    if (!initialized) return;

    onChange({
      trampa_especies_seguimientos: Object.values(insectos).flat(),
      trampa_roedores_seguimientos: Object.values(roedores),
    });
  }, [insectos, roedores, initialized]);

  /* ======================= */
  /* ROEDORES */
  /* ======================= */

  const updateRoedor = (
    id: number,
    field: keyof TrampaRoedoresSeguimiento,
    value: number | string,
  ) => {
    setRoedores((prev) => {
      const current = prev[id];

      const updated = { ...current, [field]: value };
      updated.merma = updated.inicial - updated.actual;

      return { ...prev, [id]: updated };
    });
  };

  /* ======================= */
  /* INSECTOS */
  /* ======================= */

  const addInsecto = (trampaId: number) => {
    setInsectos((prev) => ({
      ...prev,
      [trampaId]: [
        ...(prev[trampaId] || []),
        {
          trampa_id: trampaId,
          especie_id: especies[0]?.id ?? 0,
          cantidad: 0,
        },
      ],
    }));
  };

  const updateInsecto = (
    trampaId: number,
    index: number,
    field: keyof TrampaEspecieSeguimientos,
    value: number,
  ) => {
    setInsectos((prev) => ({
      ...prev,
      [trampaId]: prev[trampaId].map((i, idx) =>
        idx === index ? { ...i, [field]: value } : i,
      ),
    }));
  };

  const removeInsecto = (trampaId: number, index: number) => {
    setInsectos((prev) => ({
      ...prev,
      [trampaId]: prev[trampaId].filter((_, i) => i !== index),
    }));
  };

  const isRoedores = tipoSeguimiento === '1';

  /* ======================= */

  if (!initialized) {
    return <div className="py-6 text-center">Cargando datos...</div>;
  }

  return (
    <div className="space-y-6">
      {/* <div>{tipoSeguimiento}</div>
      <div>{typeof tipoSeguimiento}</div> */}

      {trampas.map((t) => (
        <>
          {isRoedores && (
            <>
              {/* ======================= */}
              {/* ROEDORES */}
              {/* ======================= */}
              {t.trampa_tipo.nombre !== 'insecto' && (
                <div key={t.id} className="space-y-4 rounded-lg border p-4">
                  <div>
                    <h4 className="font-semibold">{t.identificador}</h4>
                    <p className="text-sm text-muted-foreground">
                      {t.trampa_tipo.nombre}
                    </p>
                  </div>
                  <div className="grid grid-cols-2 gap-3 md:grid-cols-5">
                    <Input
                      placeholder="Obs"
                      value={roedores[t.id]?.observacion || ''}
                      onChange={(e) =>
                        updateRoedor(t.id, 'observacion', e.target.value)
                      }
                    />

                    <Input
                      type="number"
                      placeholder="Cantidad"
                      value={roedores[t.id]?.cantidad}
                      onChange={(e) =>
                        updateRoedor(t.id, 'cantidad', Number(e.target.value))
                      }
                    />

                    <Input
                      type="number"
                      placeholder="Inicial"
                      value={roedores[t.id]?.inicial}
                      onChange={(e) =>
                        updateRoedor(t.id, 'inicial', Number(e.target.value))
                      }
                      disabled={
                        t.trampa_tipo.id === 4 || t.trampa_tipo.id === 5
                      }
                    />

                    <Input
                      type="number"
                      placeholder="Actual"
                      value={roedores[t.id]?.actual}
                      onChange={(e) =>
                        updateRoedor(t.id, 'actual', Number(e.target.value))
                      }
                      disabled={
                        t.trampa_tipo.id === 4 || t.trampa_tipo.id === 5
                      }
                    />

                    <Input disabled value={roedores[t.id]?.merma} />
                  </div>
                </div>
              )}
            </>
          )}

          {!isRoedores && (
            <>
              {/* ======================= */}
              {/* INSECTOS */}
              {/* ======================= */}
              {t.trampa_tipo.nombre === 'insecto' && (
                <div key={t.id} className="space-y-4 rounded-lg border p-4">
                  <div>
                    <h4 className="font-semibold">{t.identificador}</h4>
                    <p className="text-sm text-muted-foreground">
                      {t.trampa_tipo.nombre}
                    </p>
                  </div>
                  <div className="space-y-3">
                    <Button size="sm" onClick={() => addInsecto(t.id)}>
                      + Agregar especie
                    </Button>

                    {insectos[t.id]?.map((i, idx) => (
                      <div key={idx} className="grid grid-cols-3 gap-3">
                        <Select
                          value={i.especie_id.toString()}
                          onValueChange={(v) =>
                            updateInsecto(t.id, idx, 'especie_id', Number(v))
                          }
                        >
                          <SelectTrigger>
                            <SelectValue />
                          </SelectTrigger>
                          <SelectContent>
                            {especies.map((e) => (
                              <SelectItem key={e.id} value={e.id.toString()}>
                                {e.nombre}
                              </SelectItem>
                            ))}
                          </SelectContent>
                        </Select>

                        <Input
                          type="number"
                          value={i.cantidad}
                          onChange={(e) =>
                            updateInsecto(
                              t.id,
                              idx,
                              'cantidad',
                              Number(e.target.value),
                            )
                          }
                        />

                        <Button
                          variant="destructive"
                          onClick={() => removeInsecto(t.id, idx)}
                        >
                          Eliminar
                        </Button>
                      </div>
                    ))}
                  </div>
                </div>
              )}
            </>
          )}
        </>
      ))}
    </div>
  );
}

// ----------------------------------------------------------------------------
// import { Button } from '@/components/ui/button';
// import { Input } from '@/components/ui/input';
// import { Label } from '@/components/ui/label';
// import {
//   Select,
//   SelectContent,
//   SelectItem,
//   SelectTrigger,
//   SelectValue,
// } from '@/components/ui/select';
// import axios from 'axios';
// import { useEffect, useState } from 'react';

// /* =======================
//    Interfaces
// ======================= */

// interface TrampaTipo {
//   id: number;
//   nombre: string;
// }

// interface Trampa {
//   id: number;
//   numero: number;
//   identificador: string;
//   mapa_id: number;
//   trampa_tipo: TrampaTipo;
// }

// interface Especie {
//   id: number;
//   nombre: string;
// }

// export interface TrampaEspecieSeguimientos {
//   trampa_id: number;
//   especie_id: number;
//   cantidad: number;
// }

// export interface TrampaRoedoresSeguimiento {
//   trampa_id: number;
//   observacion?: string;
//   cantidad: number;
//   inicial: number;
//   merma: number;
//   actual: number;
// }

// interface SeguimientoTrampasProps {
//   almacenId: number;
//   tipoSeguimiento: string;
//   value: {
//     trampa_especies_seguimientos: TrampaEspecieSeguimientos[];
//     trampa_roedores_seguimientos: TrampaRoedoresSeguimiento[];
//   };
//   onChange: (value: SeguimientoTrampasProps['value']) => void;
// }

// /* =======================
//    Componente
// ======================= */

// export default function SeguimientoTrampasEdit({
//   almacenId,
//   tipoSeguimiento,
//   value,
//   onChange,
// }: SeguimientoTrampasProps) {
//   const [trampas, setTrampas] = useState<Trampa[]>([]);
//   const [especies, setEspecies] = useState<Especie[]>([]);

//   const [insectos, setInsectos] = useState<
//     Record<number, TrampaEspecieSeguimientos[]>
//   >({});

//   const [roedores, setRoedores] = useState<
//     Record<number, TrampaRoedoresSeguimiento>
//   >({});

//   /* =======================
//      Cargar trampas
//   ======================= */

//   const [initialized, setInitialized] = useState(false);

//   useEffect(() => {
//     console.log('📥 VALUE RECIBIDO EN HIJO:', value);
//   }, [value]);

//   useEffect(() => {
//     if (!initialized) return;

//     console.log('📤 Enviando al padre (YA INICIALIZADO)');

//     onChange({
//       trampa_especies_seguimientos: Object.values(insectos).flat(),
//       trampa_roedores_seguimientos: Object.values(roedores),
//     });
//   }, [insectos, roedores, initialized]);

//   useEffect(() => {
//     if (!almacenId) return;

//     const load = async () => {
//       const trampasRes = await axios.get(
//         `/trampaseguimientos/${almacenId}/trampas`,
//       );
//       setTrampas(trampasRes.data);

//       const especiesRes = await axios.get('/trampaseguimientos/especies');
//       setEspecies(especiesRes.data);
//     };

//     load();
//   }, [almacenId]);

//   useEffect(() => {
//     if (!trampas.length) return;
//     if (initialized) return;

//     console.log('✅ Inicializando desde value REAL', value);

//     const insectosMap: Record<number, TrampaEspecieSeguimientos[]> = {};
//     const roedoresMap: Record<number, TrampaRoedoresSeguimiento> = {};

//     // Inicializar
//     trampas.forEach((t) => {
//       if (t.trampa_tipo.nombre === 'insecto') {
//         insectosMap[t.id] = [];
//       } else {
//         roedoresMap[t.id] = {
//           trampa_id: t.id,
//           observacion: '',
//           cantidad: 0,
//           inicial: 0,
//           actual: 0,
//           merma: 0,
//         };
//       }
//     });

//     // 🔥 IMPORTANTE: usar value REAL
//     value.trampa_roedores_seguimientos.forEach((r) => {
//       roedoresMap[r.trampa_id] = {
//         trampa_id: r.trampa_id,
//         observacion: r.observacion ?? '',
//         cantidad: r.cantidad,
//         inicial: r.inicial,
//         actual: r.actual,
//         merma: r.inicial - r.actual,
//       };
//     });

//     setInsectos(insectosMap);
//     setRoedores(roedoresMap);

//     setInitialized(true);
//   }, [trampas, value]);

//   // useEffect(() => {
//   //   if (!trampas.length) return;

//   //   // 🛑 evitar reinicializar si ya hay datos
//   //   if (Object.keys(insectos).length > 0 || Object.keys(roedores).length > 0) {
//   //     console.log('⛔ Ya inicializado, no sobreescribo');
//   //     return;
//   //   }

//   //   console.log('✅ Inicializando desde value');

//   //   const insectosMap: Record<number, TrampaEspecieSeguimientos[]> = {};
//   //   const roedoresMap: Record<number, TrampaRoedoresSeguimiento> = {};

//   //   // Inicializar
//   //   trampas.forEach((t) => {
//   //     if (t.trampa_tipo.nombre === 'insecto') {
//   //       insectosMap[t.id] = [];
//   //     } else {
//   //       roedoresMap[t.id] = {
//   //         trampa_id: t.id,
//   //         observacion: '',
//   //         cantidad: 0,
//   //         inicial: 0,
//   //         actual: 0,
//   //         merma: 0,
//   //       };
//   //     }
//   //   });

//   //   // Cargar desde value
//   //   value.trampa_especies_seguimientos.forEach((i) => {
//   //     if (!insectosMap[i.trampa_id]) {
//   //       insectosMap[i.trampa_id] = [];
//   //     }
//   //     insectosMap[i.trampa_id].push(i);
//   //   });

//   //   value.trampa_roedores_seguimientos.forEach((r) => {
//   //     roedoresMap[r.trampa_id] = {
//   //       ...r,
//   //       merma: r.inicial - r.actual,
//   //     };
//   //   });

//   //   setInsectos(insectosMap);
//   //   setRoedores(roedoresMap);
//   // }, [trampas, value]);

//   // useEffect(() => {
//   //   if (!trampas.length) return;

//   //   const insectosMap: Record<number, TrampaEspecieSeguimientos[]> = {};
//   //   const roedoresMap: Record<number, TrampaRoedoresSeguimiento> = {};

//   //   console.log('🔵 VALUE DESDE PADRE');
//   //   console.log('Insectos:', value.trampa_especies_seguimientos);
//   //   console.log('Roedores:', value.trampa_roedores_seguimientos);

//   //   // Inicializar estructuras vacías
//   //   trampas.forEach((t) => {
//   //     if (t.trampa_tipo.nombre === 'insecto') {
//   //       insectosMap[t.id] = [];
//   //     } else {
//   //       roedoresMap[t.id] = {
//   //         trampa_id: t.id,
//   //         observacion: '',
//   //         cantidad: 0,
//   //         inicial: 0,
//   //         actual: 0,
//   //         merma: 0,
//   //       };
//   //     }
//   //   });

//   //   // Cargar insectos existentes
//   //   value.trampa_especies_seguimientos.forEach((i) => {
//   //     console.log('🟡 Cargando insecto:', i);
//   //     if (!insectosMap[i.trampa_id]) {
//   //       insectosMap[i.trampa_id] = [];
//   //     }
//   //     insectosMap[i.trampa_id].push(i);
//   //   });

//   //   // Cargar roedores existentes
//   //   value.trampa_roedores_seguimientos.forEach((r) => {
//   //     console.log('🟠 Cargando roedor:', r);
//   //     roedoresMap[r.trampa_id] = {
//   //       ...r,
//   //       merma: r.inicial - r.actual,
//   //     };
//   //   });

//   //   console.log('🟢 Estado inicial insectosMap:', insectosMap);
//   //   console.log('🔴 Estado inicial roedoresMap:', roedoresMap);

//   //   setInsectos(insectosMap);
//   //   setRoedores(roedoresMap);
//   // }, [trampas, value]);

//   /* =======================
//      Emitir cambios al padre
//   ======================= */

//   useEffect(() => {
//     onChange({
//       trampa_especies_seguimientos: Object.values(insectos).flat(),
//       trampa_roedores_seguimientos: Object.values(roedores),
//     });
//   }, [insectos, roedores]);

//   /* =======================
//      Helpers insectos
//   ======================= */

//   const addInsecto = (trampaId: number) => {
//     setInsectos((prev) => ({
//       ...prev,
//       [trampaId]: [
//         ...(prev[trampaId] || []),
//         {
//           trampa_id: trampaId,
//           especie_id: especies[0]?.id ?? 0,
//           cantidad: 0,
//         },
//       ],
//     }));
//   };

//   const updateInsecto = (
//     trampaId: number,
//     index: number,
//     field: keyof TrampaEspecieSeguimientos,
//     value: any,
//   ) => {
//     setInsectos((prev) => ({
//       ...prev,
//       [trampaId]: prev[trampaId].map((i, idx) =>
//         idx === index ? { ...i, [field]: value } : i,
//       ),
//     }));
//   };

//   const removeInsecto = (trampaId: number, index: number) => {
//     setInsectos((prev) => ({
//       ...prev,
//       [trampaId]: prev[trampaId].filter((_, i) => i !== index),
//     }));
//   };

//   /* =======================
//      Helpers roedores
//   ======================= */

//   const updateRoedor = (
//     trampaId: number,
//     field: keyof TrampaRoedoresSeguimiento,
//     value: number | string,
//   ) => {
//     setRoedores((prev) => {
//       const current = prev[trampaId];
//       const updated = { ...current, [field]: value };

//       updated.merma = updated.inicial - updated.actual;

//       return { ...prev, [trampaId]: updated };
//     });
//   };

//   /* =======================
//      Render
//   ======================= */

//   if (!trampas.length) {
//     return (
//       <p className="text-sm text-muted-foreground">
//         No existen trampas registradas para este almacén {tipoSeguimiento}
//       </p>
//     );
//   }

//   return (
//     <div className="space-y-6">
//       <div>{tipoSeguimiento}</div>
//       <div>{typeof tipoSeguimiento}</div>
//       {tipoSeguimiento === '1' ? (
//         <>
//           <div>AAAAAAAAAAAAAAAAAAAA</div>
//           <div>{tipoSeguimiento}</div>
//           {trampas.map((trampa) => (
//             <>
//               {/* ROEDORES */}
//               {trampa.trampa_tipo.nombre !== 'insecto' && (
//                 <div
//                   key={trampa.id}
//                   className="space-y-4 rounded-lg border p-4"
//                 >
//                   <div>
//                     <h4 className="font-semibold">
//                       Trampa:{' '}
//                       <span className="text-[1rem] text-red-500">
//                         {trampa.identificador}
//                       </span>
//                     </h4>
//                     <p className="text-sm text-muted-foreground">
//                       Tipo: {trampa.trampa_tipo.nombre}
//                     </p>
//                   </div>

//                   <div className="grid grid-cols-2 gap-3 md:grid-cols-5">
//                     <div>
//                       <Label className="text-xs">Observacion</Label>

//                       <Input
//                         placeholder="Obs."
//                         value={roedores[trampa.id]?.observacion || ''}
//                         onChange={(e) =>
//                           updateRoedor(trampa.id, 'observacion', e.target.value)
//                         }
//                       />
//                     </div>
//                     <div>
//                       <Label className="text-xs">Atrapados</Label>
//                       <Input
//                         type="number"
//                         placeholder="Cantidad"
//                         value={roedores[trampa.id]?.cantidad}
//                         onChange={(e) =>
//                           updateRoedor(
//                             trampa.id,
//                             'cantidad',
//                             Number(e.target.value),
//                           )
//                         }
//                       />
//                     </div>
//                     <div>
//                       <Label className="text-xs">Inicial</Label>
//                       <Input
//                         type="number"
//                         placeholder="Inicial"
//                         value={roedores[trampa.id]?.inicial}
//                         onChange={(e) =>
//                           updateRoedor(
//                             trampa.id,
//                             'inicial',
//                             Number(e.target.value),
//                           )
//                         }
//                       />
//                       <div>{roedores[trampa.id]?.inicial}</div>
//                       <div>{typeof roedores[trampa.id]?.inicial}</div>
//                     </div>

//                     <div>
//                       <Label className="text-xs">Actual</Label>
//                       <Input
//                         type="number"
//                         placeholder="Actual"
//                         value={roedores[trampa.id]?.actual}
//                         onChange={(e) =>
//                           updateRoedor(
//                             trampa.id,
//                             'actual',
//                             Number(e.target.value),
//                           )
//                         }
//                       />
//                     </div>
//                     <div>
//                       <Label className="text-xs">Merma</Label>
//                       <Input disabled value={roedores[trampa.id]?.merma} />
//                     </div>
//                   </div>
//                 </div>
//               )}
//             </>
//           ))}
//         </>
//       ) : (
//         <>
//           {/* <div>BBBBBBBBBBBBBBBB</div>
//           <div>{tipoSeguimiento}</div> */}
//           {trampas.map((trampa) => (
//             <>
//               {/* <div key={trampa.id} className="space-y-4 rounded-lg border p-4"> */}
//               {/* INSECTOS */}
//               {trampa.trampa_tipo.nombre === 'insecto' && (
//                 <div
//                   key={trampa.id}
//                   className="space-y-4 rounded-lg border p-4"
//                 >
//                   <div>
//                     <h4 className="font-semibold">
//                       Trampa{' '}
//                       <span className="text-[1rem] text-red-500">
//                         {trampa.identificador}
//                       </span>
//                     </h4>
//                     <p className="text-sm text-muted-foreground">
//                       Tipo: {trampa.trampa_tipo.nombre}
//                     </p>
//                   </div>
//                   <div className="space-y-3">
//                     <Button
//                       type="button"
//                       size="sm"
//                       onClick={() => addInsecto(trampa.id)}
//                     >
//                       + Agregar especie
//                     </Button>

//                     {insectos[trampa.id]?.map((i, idx) => (
//                       <div
//                         key={idx}
//                         className="grid grid-cols-3 items-end gap-3"
//                       >
//                         <div>
//                           <Label className="text-xs">Especie</Label>
//                           <Select
//                             value={i.especie_id.toString()}
//                             onValueChange={(v) =>
//                               updateInsecto(
//                                 trampa.id,
//                                 idx,
//                                 'especie_id',
//                                 Number(v),
//                               )
//                             }
//                           >
//                             <SelectTrigger>
//                               <SelectValue />
//                             </SelectTrigger>
//                             <SelectContent>
//                               {especies.map((e) => (
//                                 <SelectItem key={e.id} value={e.id.toString()}>
//                                   {e.nombre}
//                                 </SelectItem>
//                               ))}
//                             </SelectContent>
//                           </Select>
//                         </div>

//                         <div>
//                           <Label className="text-xs">Cantidad</Label>
//                           <Input
//                             type="number"
//                             min={0}
//                             value={i.cantidad}
//                             onChange={(e) =>
//                               updateInsecto(
//                                 trampa.id,
//                                 idx,
//                                 'cantidad',
//                                 Number(e.target.value),
//                               )
//                             }
//                           />
//                         </div>

//                         <Button
//                           type="button"
//                           variant="destructive"
//                           size="sm"
//                           onClick={() => removeInsecto(trampa.id, idx)}
//                         >
//                           Eliminar
//                         </Button>
//                       </div>
//                     ))}
//                   </div>
//                 </div>
//               )}
//             </>
//           ))}
//         </>
//       )}
//     </div>
//   );
// }
