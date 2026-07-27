import { Card, CardContent } from '@/components/ui/card';
import { useMemo } from 'react';

/**
 * Resumen de las trampas que se están registrando en el seguimiento:
 * cuántas hay de cada tipo y el total. Se calcula sobre la lista que
 * realmente se muestra, no sobre todas las trampas del almacén.
 */

interface TrampaResumible {
  trampa_tipo: { nombre: string };
}

export default function ResumenTrampas({
  trampas,
}: {
  trampas: TrampaResumible[];
}) {
  const conteoPorTipo = useMemo(() => {
    const porTipo = new Map<string, number>();

    trampas.forEach((t) => {
      const nombre = t.trampa_tipo.nombre;
      porTipo.set(nombre, (porTipo.get(nombre) ?? 0) + 1);
    });

    // De mayor a menor cantidad; a igualdad, alfabético para que el orden
    // no baile entre renders.
    return [...porTipo.entries()].sort(
      (a, b) => b[1] - a[1] || a[0].localeCompare(b[0]),
    );
  }, [trampas]);

  if (!trampas.length) return null;

  return (
    <Card className="gap-0 py-4">
      <CardContent className="flex flex-wrap items-center gap-x-8 gap-y-4 px-4">
        <div>
          <p className="text-xs text-muted-foreground">Total de trampas</p>
          <p className="text-2xl leading-tight font-bold">{trampas.length}</p>
        </div>

        <div className="hidden h-10 w-px self-center bg-border sm:block" />

        {conteoPorTipo.map(([nombre, cantidad]) => (
          <div key={nombre}>
            <p className="text-xs text-muted-foreground capitalize">{nombre}</p>
            <p className="text-lg leading-tight font-semibold">{cantidad}</p>
          </div>
        ))}
      </CardContent>
    </Card>
  );
}
