import { Button } from '@/components/ui/button';
import {
  Dialog,
  DialogContent,
  DialogFooter,
  DialogHeader,
  DialogTitle,
} from '@/components/ui/dialog';
import { useForm } from '@inertiajs/react';
import axios from 'axios';
import { useEffect, useState } from 'react';
import SeguimientoTrampasEdit, {
  TrampaEspecieSeguimientos,
  TrampaRoedoresSeguimiento,
} from './SeguimientoTrampasEdit';

interface ModalSeguimientoTrampaProps {
  open: boolean;
  onClose: () => void;
  seguimientoId: number;
  almacenId: number;
  tipoSeguimiento: string;
  initialData: {
    trampa_especies_seguimientos: TrampaEspecieSeguimientos[];
    trampa_roedores_seguimientos: TrampaRoedoresSeguimiento[];
  };
}
interface TrampaFormData {
  trampa_especies_seguimientos: TrampaEspecieSeguimientos[];
  trampa_roedores_seguimientos: TrampaRoedoresSeguimiento[];
}

export default function ModalSeguimientoTrampa({
  open,
  onClose,
  seguimientoId,
  almacenId,
  tipoSeguimiento,
  initialData,
}: ModalSeguimientoTrampaProps) {
  const [loading, setLoading] = useState(false);

  // const { data, setData, put, processing, reset } = useForm({
  //   trampa_especies_seguimientos: [],
  //   trampa_roedores_seguimientos: [],
  // });

  const { data, setData, put, processing, reset } = useForm<TrampaFormData>({
    trampa_especies_seguimientos: [],
    trampa_roedores_seguimientos: [],
  });

  useEffect(() => {
    if (!open) return;

    const fetchData = async () => {
      setLoading(true);

      try {
        const response = await axios.get(
          `/trampaseguimientos/${seguimientoId}`,
        );

        const dbData = response.data;

        console.log('***************************************');
        console.log(dbData);
        console.log('***************************************');

        const hasDbData =
          (dbData.trampa_especies_seguimientos?.length ?? 0) > 0 ||
          (dbData.trampa_roedores_seguimientos?.length ?? 0) > 0;

        if (hasDbData) {
          setData({
            trampa_especies_seguimientos:
              dbData.trampa_especies_seguimientos ?? [],
            trampa_roedores_seguimientos:
              dbData.trampa_roedores_seguimientos ?? [],
          });
        } else {
          // 👉 fallback a los datos enviados desde Lista
          setData({
            trampa_especies_seguimientos:
              initialData.trampa_especies_seguimientos ?? [],
            trampa_roedores_seguimientos:
              initialData.trampa_roedores_seguimientos ?? [],
          });
        }
      } catch (error) {
        // fallback si falla la petición
        setData({
          trampa_especies_seguimientos:
            initialData.trampa_especies_seguimientos ?? [],
          trampa_roedores_seguimientos:
            initialData.trampa_roedores_seguimientos ?? [],
        });
      } finally {
        setLoading(false);
      }
    };

    fetchData();
  }, [open, seguimientoId]);

  const handleSubmit = () => {
    put(`/trampaseguimientos/${seguimientoId}`, {
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
      <DialogContent className="max-h-[90vh] overflow-y-auto sm:max-w-[800px]">
        <DialogHeader>
          <DialogTitle>
            Editar seguimiento de trampas {tipoSeguimiento} -{' '}
            {typeof tipoSeguimiento}
          </DialogTitle>
        </DialogHeader>

        {loading ? (
          <div className="py-10 text-center text-muted-foreground">
            Cargando datos...
          </div>
        ) : (
          <div className="py-6">
            <SeguimientoTrampasEdit
              almacenId={almacenId}
              tipoSeguimiento={tipoSeguimiento}
              value={data}
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
        )}

        <DialogFooter className="flex justify-between gap-3">
          <Button type="button" variant="outline" onClick={handleClose}>
            Cancelar
          </Button>

          <Button onClick={handleSubmit} disabled={processing || loading}>
            {processing ? 'Guardando...' : 'Guardar cambios'}
          </Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}

// *******************************************************************
// import { Button } from '@/components/ui/button';
// import {
//   Dialog,
//   DialogContent,
//   DialogFooter,
//   DialogHeader,
//   DialogTitle,
// } from '@/components/ui/dialog';
// import { useForm } from '@inertiajs/react';
// import { useEffect } from 'react';
// import SeguimientoTrampasEdit, {
//   TrampaEspecieSeguimientos,
//   TrampaRoedoresSeguimiento,
// } from './SeguimientoTrampasEdit';

// interface ModalSeguimientoTrampaProps {
//   open: boolean;
//   onClose: () => void;
//   seguimientoId: number;
//   almacenId: number;

//   initialData: {
//     trampa_especies_seguimientos: TrampaEspecieSeguimientos[];
//     trampa_roedores_seguimientos: TrampaRoedoresSeguimiento[];
//   };
// }

// export default function ModalSeguimientoTrampa({
//   open,
//   onClose,
//   seguimientoId,
//   almacenId,
//   initialData,
// }: ModalSeguimientoTrampaProps) {
//   const { data, setData, put, processing, reset } = useForm({
//     trampa_especies_seguimientos:
//       initialData.trampa_especies_seguimientos ?? [],
//     trampa_roedores_seguimientos:
//       initialData.trampa_roedores_seguimientos ?? [],
//   });

//   // console.log('***** INITIAL ******');
//   // console.log(initialData);
//   // console.log('***** INITIAL ******');

//   // Mantener sincronizado si cambian los datos iniciales
//   useEffect(() => {
//     setData(
//       'trampa_especies_seguimientos',
//       initialData.trampa_especies_seguimientos ?? [],
//     );
//     setData(
//       'trampa_roedores_seguimientos',
//       initialData.trampa_roedores_seguimientos ?? [],
//     );
//   }, [initialData]);

//   const handleSubmit = () => {
//     // put(`/seguimientos/${seguimientoId}/trampas`, {
//     put(`/trampaseguimientos/${seguimientoId}`, {
//       onSuccess: () => {
//         reset();
//         onClose();
//       },
//     });
//   };

//   const handleClose = () => {
//     reset();
//     onClose();
//   };

//   return (
//     <Dialog open={open} onOpenChange={(v) => !v && handleClose()}>
//       <DialogContent
//         className="max-h-[90vh] overflow-y-auto sm:max-w-[800px]"
//         // onInteractOutside={(e) => e.preventDefault()}
//       >
//         <DialogHeader>
//           <DialogTitle>Editar seguimiento de trampas</DialogTitle>
//         </DialogHeader>

//         {/* PASO 9 */}
//         <div className="py-6">
//           <SeguimientoTrampasEdit
//             almacenId={almacenId}
//             value={{
//               trampa_especies_seguimientos: data.trampa_especies_seguimientos,
//               trampa_roedores_seguimientos: data.trampa_roedores_seguimientos,
//             }}
//             onChange={(val) => {
//               setData(
//                 'trampa_especies_seguimientos',
//                 val.trampa_especies_seguimientos,
//               );
//               setData(
//                 'trampa_roedores_seguimientos',
//                 val.trampa_roedores_seguimientos,
//               );
//             }}
//           />
//         </div>

//         <DialogFooter className="flex justify-between gap-3">
//           <Button type="button" variant="outline" onClick={handleClose}>
//             Cancelar
//           </Button>

//           <Button onClick={handleSubmit} disabled={processing}>
//             {processing ? 'Guardando...' : 'Guardar cambios'}
//           </Button>
//         </DialogFooter>
//       </DialogContent>
//     </Dialog>
//   );
// }
