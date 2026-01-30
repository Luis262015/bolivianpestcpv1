// import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
// import { Input } from '@/components/ui/input';
// import { Label } from '@/components/ui/label';
// import { Textarea } from '@/components/ui/textarea';
// import { useEffect, useState } from 'react';

// interface TrampaEspecieSeguimiento {
//   id?: number; // existe cuando editas
//   trampa_id: number;
//   especie_id: number;
//   cantidad: number;
// }

// interface TrampaRoedoresSeguimiento {
//   id?: number; // existe cuando editas
//   trampa_id: number;
//   cantidad?: number; // opcional si no lo usas
//   inicial: number;
//   actual: number;
//   merma: number;
//   observacion?: string;
// }

// interface Trampa {
//   id: number;
//   codigo: string;
//   trampa_tipo: {
//     id: number;
//     nombre: 'insecto' | 'roedor';
//   };
// }

// interface Especie {
//   id: number;
//   nombre: string;
// }

// interface Seguimiento {
//   id: number;
//   trampa_especies_seguimientos: TrampaEspecieSeguimiento[];
//   trampa_roedores_seguimientos: TrampaRoedoresSeguimiento[];
// }

// interface Props {
//   trampas: Trampa[];
//   especies: Especie[];
//   value: Seguimiento;
//   onChange: (data: {
//     trampa_especies_seguimientos: TrampaEspecieSeguimiento[];
//     trampa_roedores_seguimientos: TrampaRoedoresSeguimiento[];
//   }) => void;
// }

// export default function ModalSeguimientoTrampa({
//   trampas,
//   especies,
//   value,
//   onChange,
// }: Props) {
//   const [insectos, setInsectos] = useState<
//     Record<number, TrampaEspecieSeguimiento[]>
//   >({});
//   const [roedores, setRoedores] = useState<
//     Record<number, TrampaRoedoresSeguimiento>
//   >({});

//   /* ----------------------------------------
//    Inicializar datos SOLO desde props
//   ----------------------------------------- */
//   useEffect(() => {
//     if (!trampas.length) return;

//     const insectosInit: Record<number, TrampaEspecieSeguimiento[]> = {};
//     const roedoresInit: Record<number, TrampaRoedoresSeguimiento> = {};

//     trampas.forEach((t) => {
//       if (t.trampa_tipo.nombre === 'insecto') {
//         insectosInit[t.id] = [];
//       } else {
//         roedoresInit[t.id] = {
//           trampa_id: t.id,
//           observacion: '',
//           cantidad: 0,
//           inicial: 0,
//           actual: 0,
//           merma: 0,
//         };
//       }
//     });

//     // Cargar insectos existentes
//     value.trampa_especies_seguimientos?.forEach((i) => {
//       if (!insectosInit[i.trampa_id]) {
//         insectosInit[i.trampa_id] = [];
//       }
//       insectosInit[i.trampa_id].push(i);
//     });

//     // Cargar roedores existentes
//     value.trampa_roedores_seguimientos?.forEach((r) => {
//       roedoresInit[r.trampa_id] = {
//         ...r,
//         merma: r.inicial - r.actual,
//       };
//     });

//     setInsectos(insectosInit);
//     setRoedores(roedoresInit);
//   }, [trampas, value]);

//   /* ----------------------------------------
//    Propagar cambios al padre
//   ----------------------------------------- */
//   useEffect(() => {
//     onChange({
//       trampa_especies_seguimientos: Object.values(insectos).flat(),
//       trampa_roedores_seguimientos: Object.values(roedores),
//     });
//   }, [insectos, roedores]);

//   /* ----------------------------------------
//    Handlers
//   ----------------------------------------- */
//   const updateRoedor = <K extends keyof TrampaRoedoresSeguimiento>(
//     trampaId: number,
//     field: K,
//     value: TrampaRoedoresSeguimiento[K],
//   ) => {
//     setRoedores((prev) => {
//       const current = prev[trampaId];

//       const updated = {
//         ...current,
//         [field]: value,
//       };

//       const inicial =
//         field === 'inicial' ? Number(value) : Number(updated.inicial);

//       const actual =
//         field === 'actual' ? Number(value) : Number(updated.actual);

//       updated.merma = inicial - actual;

//       return { ...prev, [trampaId]: updated };
//     });
//   };
//   /* ----------------------------------------
//    Render
//   ----------------------------------------- */
//   return (
//     <div className="space-y-6">
//       {trampas.map((trampa) => (
//         <Card key={trampa.id}>
//           <CardHeader>
//             <CardTitle>
//               {trampa.codigo} – {trampa.trampa_tipo.nombre}
//             </CardTitle>
//           </CardHeader>

//           <CardContent className="space-y-4">
//             {/* INSECTOS */}
//             {trampa.trampa_tipo.nombre === 'insecto' &&
//               especies.map((esp) => {
//                 const current =
//                   insectos[trampa.id]?.find((i) => i.especie_id === esp.id)
//                     ?.cantidad || 0;

//                 return (
//                   <div
//                     key={esp.id}
//                     className="grid grid-cols-2 items-center gap-2"
//                   >
//                     <Label>{esp.nombre}</Label>
//                     <Input
//                       type="number"
//                       value={current}
//                       min={0}
//                       onChange={(e) => {
//                         const val = Number(e.target.value);
//                         setInsectos((prev) => {
//                           const list = prev[trampa.id] ?? [];
//                           const idx = list.findIndex(
//                             (i) => i.especie_id === esp.id,
//                           );

//                           if (idx >= 0) {
//                             list[idx].cantidad = val;
//                           } else {
//                             list.push({
//                               trampa_id: trampa.id,
//                               especie_id: esp.id,
//                               cantidad: val,
//                             });
//                           }

//                           return {
//                             ...prev,
//                             [trampa.id]: [...list],
//                           };
//                         });
//                       }}
//                     />
//                   </div>
//                 );
//               })}

//             {/* ROEDORES */}
//             {trampa.trampa_tipo.nombre === 'roedor' && (
//               <div className="grid grid-cols-2 gap-4">
//                 <Input
//                   type="number"
//                   placeholder="Inicial"
//                   value={roedores[trampa.id]?.inicial || 0}
//                   onChange={(e) =>
//                     updateRoedor(trampa.id, 'inicial', Number(e.target.value))
//                   }
//                 />
//                 <Input
//                   type="number"
//                   placeholder="Actual"
//                   value={roedores[trampa.id]?.actual || 0}
//                   onChange={(e) =>
//                     updateRoedor(trampa.id, 'actual', Number(e.target.value))
//                   }
//                 />
//                 <Input
//                   type="number"
//                   placeholder="Merma"
//                   value={roedores[trampa.id]?.merma || 0}
//                   disabled
//                 />
//                 <Textarea
//                   placeholder="Observación"
//                   value={roedores[trampa.id]?.observacion || ''}
//                   onChange={(e) =>
//                     updateRoedor(trampa.id, 'observacion', e.target.value)
//                   }
//                 />
//               </div>
//             )}
//           </CardContent>
//         </Card>
//       ))}
//     </div>
//   );
// }

// *******************************************************************
import { Button } from '@/components/ui/button';
import {
  Dialog,
  DialogContent,
  DialogFooter,
  DialogHeader,
  DialogTitle,
} from '@/components/ui/dialog';
import { useForm } from '@inertiajs/react';
import { useEffect } from 'react';
import SeguimientoTrampasEdit, {
  TrampaEspecieSeguimientos,
  TrampaRoedoresSeguimiento,
} from './SeguimientoTrampasEdit';

interface ModalSeguimientoTrampaProps {
  open: boolean;
  onClose: () => void;
  seguimientoId: number;
  almacenId: number;

  initialData: {
    trampa_especies_seguimientos: TrampaEspecieSeguimientos[];
    trampa_roedores_seguimientos: TrampaRoedoresSeguimiento[];
  };
}

export default function ModalSeguimientoTrampa({
  open,
  onClose,
  seguimientoId,
  almacenId,
  initialData,
}: ModalSeguimientoTrampaProps) {
  const { data, setData, put, processing, reset } = useForm({
    trampa_especies_seguimientos:
      initialData.trampa_especies_seguimientos ?? [],
    trampa_roedores_seguimientos:
      initialData.trampa_roedores_seguimientos ?? [],
  });

  console.log('***** INITIAL ******');
  console.log(initialData);
  console.log('***** INITIAL ******');

  // Mantener sincronizado si cambian los datos iniciales
  useEffect(() => {
    setData(
      'trampa_especies_seguimientos',
      initialData.trampa_especies_seguimientos ?? [],
    );
    setData(
      'trampa_roedores_seguimientos',
      initialData.trampa_roedores_seguimientos ?? [],
    );
  }, [initialData]);

  const handleSubmit = () => {
    put(`/seguimientos/${seguimientoId}/trampas`, {
      onSuccess: () => {
        reset();
        onClose();
      },
    });
  };

  const handleClose = () => {
    reset();
    onClose();
  };

  return (
    <Dialog open={open} onOpenChange={(v) => !v && handleClose()}>
      <DialogContent
        className="max-h-[90vh] overflow-y-auto sm:max-w-[800px]"
        onInteractOutside={(e) => e.preventDefault()}
      >
        <DialogHeader>
          <DialogTitle>Editar seguimiento de trampas</DialogTitle>
        </DialogHeader>

        {/* PASO 9 */}
        <div className="py-6">
          <SeguimientoTrampasEdit
            almacenId={almacenId}
            value={{
              trampa_especies_seguimientos: data.trampa_especies_seguimientos,
              trampa_roedores_seguimientos: data.trampa_roedores_seguimientos,
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
        </div>

        <DialogFooter className="flex justify-between gap-3">
          <Button type="button" variant="outline" onClick={handleClose}>
            Cancelar
          </Button>

          <Button onClick={handleSubmit} disabled={processing}>
            {processing ? 'Guardando...' : 'Guardar cambios'}
          </Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}
