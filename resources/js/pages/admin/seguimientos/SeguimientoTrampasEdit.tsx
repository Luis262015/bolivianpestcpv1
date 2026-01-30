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
import axios from 'axios';
import { useEffect, useState } from 'react';

/* =======================
   Interfaces
======================= */

interface TrampaTipo {
  id: number;
  nombre: string;
}

interface Trampa {
  id: number;
  numero: number;
  mapa_id: number;
  trampa_tipo: TrampaTipo;
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
  trampa_id: number;
  observacion?: string;
  cantidad: number;
  inicial: number;
  merma: number;
  actual: number;
}

interface SeguimientoTrampasProps {
  almacenId: number;
  value: {
    trampa_especies_seguimientos: TrampaEspecieSeguimientos[];
    trampa_roedores_seguimientos: TrampaRoedoresSeguimiento[];
  };
  onChange: (value: SeguimientoTrampasProps['value']) => void;
}

/* =======================
   Componente
======================= */

export default function SeguimientoTrampasEdit({
  almacenId,
  value,
  onChange,
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
     Cargar trampas
  ======================= */

  useEffect(() => {
    if (!almacenId) return;

    const load = async () => {
      const trampasRes = await axios.get(
        `/trampaseguimientos/${almacenId}/trampas`,
      );
      setTrampas(trampasRes.data);

      const especiesRes = await axios.get('/trampaseguimientos/especies');
      setEspecies(especiesRes.data);
    };

    load();
  }, [almacenId]);

  useEffect(() => {
    if (!trampas.length) return;

    const insectosMap: Record<number, TrampaEspecieSeguimientos[]> = {};
    const roedoresMap: Record<number, TrampaRoedoresSeguimiento> = {};

    // Inicializar estructuras vacías
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

    // Cargar insectos existentes
    value.trampa_especies_seguimientos.forEach((i) => {
      if (!insectosMap[i.trampa_id]) {
        insectosMap[i.trampa_id] = [];
      }
      insectosMap[i.trampa_id].push(i);
    });

    // Cargar roedores existentes
    value.trampa_roedores_seguimientos.forEach((r) => {
      roedoresMap[r.trampa_id] = {
        ...r,
        merma: r.inicial - r.actual,
      };
    });

    setInsectos(insectosMap);
    setRoedores(roedoresMap);
  }, [trampas]);

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

      updated.merma = updated.inicial - updated.actual;

      return { ...prev, [trampaId]: updated };
    });
  };

  /* =======================
     Render
  ======================= */

  if (!trampas.length) {
    return (
      <p className="text-sm text-muted-foreground">
        No existen trampas registradas para este almacén
      </p>
    );
  }

  return (
    <div className="space-y-6">
      {trampas.map((trampa) => (
        <div key={trampa.id} className="space-y-4 rounded-lg border p-4">
          <div>
            <h4 className="font-semibold">Trampa #{trampa.numero}</h4>
            <p className="text-sm text-muted-foreground">
              Tipo: {trampa.trampa_tipo.nombre}
            </p>
          </div>

          {/* INSECTOS */}
          {trampa.trampa_tipo.nombre === 'insecto' && (
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
          )}

          {/* ROEDORES */}
          {trampa.trampa_tipo.nombre !== 'insecto' && (
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
                  placeholder="Cantidad"
                  value={roedores[trampa.id]?.cantidad}
                  onChange={(e) =>
                    updateRoedor(trampa.id, 'cantidad', Number(e.target.value))
                  }
                />
              </div>
              <div>
                <Label className="text-xs">Inicial</Label>
                <Input
                  type="number"
                  placeholder="Inicial"
                  value={roedores[trampa.id]?.inicial}
                  onChange={(e) =>
                    updateRoedor(trampa.id, 'inicial', Number(e.target.value))
                  }
                />
              </div>

              <div>
                <Label className="text-xs">Actual</Label>
                <Input
                  type="number"
                  placeholder="Actual"
                  value={roedores[trampa.id]?.actual}
                  onChange={(e) =>
                    updateRoedor(trampa.id, 'actual', Number(e.target.value))
                  }
                />
              </div>
              <div>
                <Label className="text-xs">Merma</Label>
                <Input disabled value={roedores[trampa.id]?.merma} />
              </div>
            </div>
          )}
        </div>
      ))}
    </div>
  );
}
