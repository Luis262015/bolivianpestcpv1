import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select';
import { notificarError } from '@/lib/alertas';
import axios from 'axios';
import { useEffect, useMemo, useState } from 'react';
import ResumenTrampas from './ResumenTrampas';

/* =======================
   Interfaces
======================= */

interface TrampaTipo {
  id: number;
  nombre: string;
}

interface Almacen {
  id: number;
  nombre: string;
}

interface Mapa {
  id: number;
  titulo: string;
}

interface Trampa {
  id: number;
  numero: number;
  identificador: string;
  mapa_id: number | null;
  trampa_tipo: TrampaTipo;
  almacen: Almacen;
  mapa: Mapa | null;
}

interface Especie {
  id: number;
  nombre: string;
}

export interface TrampaEspecieSeguimientos {
  trampa_id: number;
  especie_id: number;
  cantidad: number;
}

export interface TrampaRoedoresSeguimiento {
  almacen: string;
  trampa_id: number;
  observacion?: string;
  cantidad: number;
  inicial: number;
  merma: number;
  actual: number;
}

interface SeguimientoTrampasProps {
  almacenId: number;
  tipoSeguimiento: string;
  value: {
    trampa_especies_seguimientos: TrampaEspecieSeguimientos[];
    trampa_roedores_seguimientos: TrampaRoedoresSeguimiento[];
  };
  onChange: (value: SeguimientoTrampasProps['value']) => void;
  // Habilita el alta rápida de trampas (sin mapa). Solo para el almacén ESPORADICO.
  permitirAltaRapida?: boolean;
}

/* =======================
   Componente
======================= */

export default function SeguimientoTrampas({
  almacenId,
  tipoSeguimiento,
  value,
  onChange,
  permitirAltaRapida = false,
}: SeguimientoTrampasProps) {
  const [trampas, setTrampas] = useState<Trampa[]>([]);
  const [especies, setEspecies] = useState<Especie[]>([]);

  const [insectos, setInsectos] = useState<
    Record<number, TrampaEspecieSeguimientos[]>
  >({});

  const [roedores, setRoedores] = useState<
    Record<number, TrampaRoedoresSeguimiento>
  >({});

  /* =======================
     Alta rápida de trampas (esporádicos)
  ======================= */

  const [tipos, setTipos] = useState<TrampaTipo[]>([]);
  const [nuevoTipoId, setNuevoTipoId] = useState<string>('');
  const [nuevoIdentificador, setNuevoIdentificador] = useState('');
  const [creando, setCreando] = useState(false);

  // Los tipos ofrecidos coinciden con la vista actual: roedores en
  // DESRATIZACION, insectos en el resto.
  const tiposFiltrados = useMemo(
    () =>
      tipoSeguimiento === '1'
        ? tipos.filter((t) => t.nombre !== 'insecto')
        : tipos.filter((t) => t.nombre === 'insecto'),
    [tipos, tipoSeguimiento],
  );

  useEffect(() => {
    if (!permitirAltaRapida) return;
    axios.get('/seguimientos/trampa-tipos').then((r) => setTipos(r.data));
  }, [permitirAltaRapida]);

  // Mantener seleccionado un tipo válido dentro de los filtrados.
  useEffect(() => {
    if (!tiposFiltrados.some((t) => t.id.toString() === nuevoTipoId)) {
      setNuevoTipoId(tiposFiltrados[0]?.id?.toString() ?? '');
    }
  }, [tiposFiltrados, nuevoTipoId]);

  const agregarTrampaRapida = async () => {
    if (!nuevoTipoId || !nuevoIdentificador.trim()) return;
    setCreando(true);
    try {
      const { data: t } = await axios.post<Trampa>(
        '/seguimientos/trampa-rapida',
        {
          trampa_tipo_id: Number(nuevoTipoId),
          identificador: nuevoIdentificador.trim(),
        },
      );

      // Las trampas sin mapa se agregan al final, después de las de los mapas.
      setTrampas((prev) => [...prev, t]);

      if (t.trampa_tipo.nombre === 'insecto') {
        setInsectos((prev) => ({ ...prev, [t.id]: [] }));
      } else {
        setRoedores((prev) => ({
          ...prev,
          [t.id]: {
            almacen: t.almacen?.nombre ?? '',
            trampa_id: t.id,
            observacion: '',
            cantidad: 0,
            inicial: 0,
            actual: 0,
            merma: 0,
          },
        }));
      }

      setNuevoIdentificador('');
    } catch {
      notificarError(
        'No se pudo crear la trampa. Revisa el tipo y el identificador.',
      );
    } finally {
      setCreando(false);
    }
  };

  /* =======================
     Cargar trampas
  ======================= */

  useEffect(() => {
    if (!almacenId) return;

    const load = async () => {
      const trampasRes = await axios.get(
        `/trampaseguimientos/${almacenId}/trampas`,
      );

      // El backend ya las devuelve por orden de mapa y número de trampa.
      const trampasOrdenadas: Trampa[] = trampasRes.data;
      setTrampas(trampasOrdenadas);

      const especiesRes = await axios.get('/trampaseguimientos/especies');
      setEspecies(especiesRes.data);

      const insectosInit: any = {};
      const roedoresInit: any = {};

      trampasOrdenadas.forEach((t: Trampa) => {
        if (t.trampa_tipo.nombre === 'insecto') {
          insectosInit[t.id] = [];
        } else {
          roedoresInit[t.id] = {
            almacen: t.almacen?.nombre ?? '',
            mapa: t.mapa?.titulo ?? '',
            trampa_id: t.id,
            observacion: '',
            cantidad: 0,
            inicial: 0,
            actual: 0,
            merma: 0,
          };
        }
      });

      setInsectos(insectosInit);
      setRoedores(roedoresInit);
    };

    load();
  }, [almacenId]);

  /* =======================
     Emitir cambios al padre
  ======================= */

  useEffect(() => {
    onChange({
      trampa_especies_seguimientos: Object.values(insectos).flat(),
      trampa_roedores_seguimientos: Object.values(roedores),
    });
  }, [insectos, roedores]);

  /* =======================
     Helpers insectos
  ======================= */

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
    value: any,
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

  /* =======================
     Helpers roedores
  ======================= */

  const updateRoedor = (
    trampaId: number,
    field: keyof TrampaRoedoresSeguimiento,
    value: number | string,
  ) => {
    setRoedores((prev) => {
      const current = prev[trampaId];
      const updated = { ...current, [field]: value };

      // Normalizar numéricos: nunca negativos
      updated.inicial = Math.max(0, Number(updated.inicial) || 0);
      updated.cantidad = Math.max(0, Number(updated.cantidad) || 0);
      updated.actual = Math.max(0, Number(updated.actual) || 0);

      // El "Actual" nunca puede superar al "Inicial" (total)
      if (updated.actual > updated.inicial) {
        updated.actual = updated.inicial;
      }

      // La merma nunca es negativa
      updated.merma = Math.max(0, updated.inicial - updated.actual);

      return { ...prev, [trampaId]: updated };
    });
  };

  /* =======================
     Render
  ======================= */

  // Solo se muestran las trampas del tipo que corresponde al seguimiento; la
  // numeración de fila se calcula sobre esa lista visible.
  const trampasVisibles = useMemo(
    () =>
      trampas.filter((t) =>
        tipoSeguimiento === '1'
          ? t.trampa_tipo.nombre !== 'insecto'
          : t.trampa_tipo.nombre === 'insecto',
      ),
    [trampas, tipoSeguimiento],
  );

  const altaRapida = permitirAltaRapida && (
    <div className="space-y-3 rounded-lg border border-dashed p-4">
      <h4 className="text-sm font-semibold">Agregar trampa (sin mapa)</h4>
      <div className="grid grid-cols-1 items-end gap-3 md:grid-cols-3">
        <div>
          <Label className="text-xs">Tipo de trampa</Label>
          <Select value={nuevoTipoId} onValueChange={setNuevoTipoId}>
            <SelectTrigger>
              <SelectValue placeholder="Tipo" />
            </SelectTrigger>
            <SelectContent>
              {tiposFiltrados.map((t) => (
                <SelectItem key={t.id} value={t.id.toString()}>
                  {t.nombre}
                </SelectItem>
              ))}
            </SelectContent>
          </Select>
        </div>
        <div>
          <Label className="text-xs">Identificador</Label>
          <Input
            placeholder="Ej. T-01"
            value={nuevoIdentificador}
            onChange={(e) => setNuevoIdentificador(e.target.value)}
          />
        </div>
        <Button
          type="button"
          onClick={agregarTrampaRapida}
          disabled={creando || !nuevoTipoId || !nuevoIdentificador.trim()}
        >
          {creando ? 'Agregando...' : '+ Agregar trampa'}
        </Button>
      </div>
    </div>
  );

  return (
    <div className="space-y-6">
      {altaRapida}

      <ResumenTrampas trampas={trampasVisibles} />

      {!trampasVisibles.length ? (
        <p className="text-sm text-muted-foreground">
          No existen trampas registradas para este almacén
        </p>
      ) : tipoSeguimiento === '1' ? (
        <>
          {/* ROEDORES */}
          {trampasVisibles.map((trampa, fila) => (
            <div key={trampa.id} className="space-y-4 rounded-lg border p-4">
              <div>
                <h4 className="flex items-center gap-2 font-semibold">
                  <span className="flex h-6 w-6 shrink-0 items-center justify-center rounded-full bg-muted text-xs font-bold text-muted-foreground">
                    {fila + 1}
                  </span>
                  <span>
                    Trampa{' '}
                    <span className="text-[1rem] text-red-500">
                      {trampa.identificador}
                    </span>
                  </span>
                </h4>
                <p className="text-sm text-muted-foreground">
                  Tipo: {trampa.trampa_tipo.nombre}
                </p>
                <p className="text-sm text-muted-foreground">
                  Mapa: {trampa.mapa?.titulo ?? 'Sin mapa'}
                </p>
              </div>

              <div className="grid grid-cols-2 gap-3 md:grid-cols-5">
                <div>
                  <Label className="text-xs">Observacion</Label>

                  <Input
                    placeholder="Obs."
                    value={roedores[trampa.id]?.observacion || ''}
                    onChange={(e) =>
                      updateRoedor(trampa.id, 'observacion', e.target.value)
                    }
                  />
                </div>
                <div>
                  <Label className="text-xs">Atrapados</Label>
                  <Input
                    type="number"
                    min={0}
                    placeholder="Cantidad"
                    value={roedores[trampa.id]?.cantidad}
                    onChange={(e) =>
                      updateRoedor(
                        trampa.id,
                        'cantidad',
                        Number(e.target.value),
                      )
                    }
                  />
                </div>
                <div>
                  <Label className="text-xs">Inicial</Label>
                  <Input
                    type="number"
                    min={0}
                    placeholder="Inicial"
                    value={roedores[trampa.id]?.inicial}
                    onChange={(e) =>
                      updateRoedor(trampa.id, 'inicial', Number(e.target.value))
                    }
                    disabled={
                      trampa.trampa_tipo.id === 4 || trampa.trampa_tipo.id === 5
                    }
                  />
                </div>

                <div>
                  <Label className="text-xs">Actual</Label>
                  <Input
                    type="number"
                    min={0}
                    max={roedores[trampa.id]?.inicial}
                    placeholder="Actual"
                    value={roedores[trampa.id]?.actual}
                    onChange={(e) =>
                      updateRoedor(trampa.id, 'actual', Number(e.target.value))
                    }
                    disabled={
                      trampa.trampa_tipo.id === 4 || trampa.trampa_tipo.id === 5
                    }
                  />
                </div>
                <div>
                  <Label className="text-xs">Merma</Label>
                  <Input disabled value={roedores[trampa.id]?.merma} />
                </div>
              </div>
            </div>
          ))}
        </>
      ) : (
        <>
          {/* INSECTOS */}
          {trampasVisibles.map((trampa, fila) => (
            <div key={trampa.id} className="space-y-4 rounded-lg border p-4">
              <div>
                <h4 className="flex items-center gap-2 font-semibold">
                  <span className="flex h-6 w-6 shrink-0 items-center justify-center rounded-full bg-muted text-xs font-bold text-muted-foreground">
                    {fila + 1}
                  </span>
                  <span>
                    Trampa{' '}
                    <span className="text-[1rem] text-red-500">
                      {trampa.identificador}
                    </span>
                  </span>
                </h4>
                <p className="text-sm text-muted-foreground">
                  Tipo: {trampa.trampa_tipo.nombre}
                </p>
                <p className="text-sm text-muted-foreground">
                  Mapa: {trampa.mapa?.titulo ?? 'Sin mapa'}
                </p>
              </div>
              <div className="space-y-3">
                <Button
                  type="button"
                  size="sm"
                  onClick={() => addInsecto(trampa.id)}
                >
                  + Agregar especie
                </Button>

                {insectos[trampa.id]?.map((i, idx) => (
                  <div key={idx} className="grid grid-cols-3 items-end gap-3">
                    <div>
                      <Label className="text-xs">Especie</Label>
                      <Select
                        value={i.especie_id.toString()}
                        onValueChange={(v) =>
                          updateInsecto(trampa.id, idx, 'especie_id', Number(v))
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
                    </div>

                    <div>
                      <Label className="text-xs">Cantidad</Label>
                      <Input
                        type="number"
                        min={0}
                        value={i.cantidad}
                        onChange={(e) =>
                          updateInsecto(
                            trampa.id,
                            idx,
                            'cantidad',
                            Number(e.target.value),
                          )
                        }
                      />
                    </div>

                    <Button
                      type="button"
                      variant="destructive"
                      size="sm"
                      onClick={() => removeInsecto(trampa.id, idx)}
                    >
                      Eliminar
                    </Button>
                  </div>
                ))}
              </div>
            </div>
          ))}
        </>
      )}
    </div>
  );
}
