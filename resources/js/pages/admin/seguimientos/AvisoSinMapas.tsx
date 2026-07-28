import { Alert, AlertDescription, AlertTitle } from '@/components/ui/alert';
import { usePage } from '@inertiajs/react';
import axios from 'axios';
import { TriangleAlertIcon } from 'lucide-react';
import { useEffect, useState } from 'react';

/**
 * Las trampas se dibujan sobre un mapa del almacén: si el almacén no tiene
 * ningún mapa, el paso de trampas queda vacío y el seguimiento se guarda sin
 * datos de trampas. Este aviso lo dice, en vez de dejar al técnico frente a una
 * lista vacía sin saber por qué.
 *
 * No aplica al almacén ESPORADICO: ahí las trampas se dan de alta a mano, sin
 * mapa, así que no tener mapas es lo normal y el aviso sería ruido.
 */
export default function AvisoSinMapas({ almacenId }: { almacenId: number }) {
  const esporadicoAlmacenId = (usePage().props as any)
    .esporadicoAlmacenId as number | null;

  const [sinMapas, setSinMapas] = useState(false);

  useEffect(() => {
    if (!almacenId || almacenId === esporadicoAlmacenId) {
      setSinMapas(false);
      return;
    }

    // Evita que la respuesta de un almacén anterior pise a la del actual.
    let vigente = true;

    axios
      .get(`/trampaseguimientos/${almacenId}/mapas`)
      .then((r) => {
        if (vigente) setSinMapas(r.data.length === 0);
      })
      .catch(() => {
        // Que falle la consulta no significa que no haya mapas: no se avisa.
        if (vigente) setSinMapas(false);
      });

    return () => {
      vigente = false;
    };
  }, [almacenId, esporadicoAlmacenId]);

  if (!sinMapas) return null;

  return (
    <Alert className="border-amber-500/50 bg-amber-50 text-amber-900 dark:bg-amber-950/40 dark:text-amber-100">
      <TriangleAlertIcon />
      <AlertTitle>Este almacén no tiene mapas registrados</AlertTitle>
      <AlertDescription className="text-amber-800 dark:text-amber-200">
        <p>
          Las trampas pertenecen a un mapa del almacén, así que el paso de
          trampas quedará vacío y el seguimiento se guardará sin datos de
          trampas.
        </p>
        <p>
          Si el almacén debería tener trampas, cree primero su mapa en el módulo
          Mapas.
        </p>
      </AlertDescription>
    </Alert>
  );
}
