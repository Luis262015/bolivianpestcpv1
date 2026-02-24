'use client';

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
import { Slider } from '@/components/ui/slider';
import { Download, Hand, RotateCcw, Trash2 } from 'lucide-react';
import { ChangeEvent, MouseEvent, useEffect, useRef, useState } from 'react';
import { v4 as uuidv4 } from 'uuid';

import {
  Dialog,
  DialogContent,
  DialogFooter,
  DialogHeader,
  DialogTitle,
} from '@/components/ui/dialog';

/* =======================
   Tipos
======================= */

export type Trap = {
  tempId: string;
  trampa_tipo_id: number;
  posx: number;
  posy: number;
  identificador: string; // 👈 nuevo
};

export type MapEditorState = {
  localId: string;
  mapaId?: number;
  titulo: string; // 👈 nuevo
  traps: Trap[];
  background: string | null;
};

type Dragging =
  | { type: 'trap'; tempId: string; offsetX: number; offsetY: number }
  | { type: 'pan'; startX: number; startY: number };

interface Props {
  mapa: MapEditorState;
  trampaTipos: { id: number; nombre: string; imagen: string | null }[];
  onChange: (mapa: MapEditorState) => void;
}

/* =======================
   Componente
======================= */

export default function CanvasEditor({ mapa, trampaTipos, onChange }: Props) {
  const CANVAS_WIDTH = 1000;
  const CANVAS_HEIGHT = 700;

  const canvasRef = useRef<HTMLCanvasElement | null>(null);
  const ctxRef = useRef<CanvasRenderingContext2D | null>(null);
  const bgImageRef = useRef<HTMLImageElement | null>(null);
  const trapImagesRef = useRef<Record<number, HTMLImageElement>>({});
  const fileInputRef = useRef<HTMLInputElement | null>(null);

  const [mode, setMode] = useState<number | null>(null);
  const [trapSize, setTrapSize] = useState(30);
  const [zoom, setZoom] = useState(100);
  const [panMode, setPanMode] = useState(false);
  const [panOffset, setPanOffset] = useState({ x: 0, y: 0 });
  const [dragging, setDragging] = useState<Dragging | null>(null);
  const [wheelPan, setWheelPan] = useState(false);

  const TRAP_TYPE_COLORS: Record<number, string> = {
    1: '#ef4444', // rojo
    2: '#3b82f6', // azul
    3: '#22c55e', // verde
    4: '#f59e0b', // amarillo
    5: '#a855f7', // morado
  };

  const [dialogOpen, setDialogOpen] = useState(false);
  const [identificador, setIdentificador] = useState('');
  const [errorIdentificador, setErrorIdentificador] = useState('');
  const [pendingTrap, setPendingTrap] = useState<{
    posx: number;
    posy: number;
    trampa_tipo_id: number;
  } | null>(null);
  const inputRef = useRef<HTMLInputElement>(null);
  // foco automático al abrir
  useEffect(() => {
    if (dialogOpen) {
      setTimeout(() => {
        inputRef.current?.focus();
      }, 50);
    }
  }, [dialogOpen]);

  /* =======================
     Cargar imágenes
  ======================= */

  // useEffect(() => {
  //   trampaTipos.forEach((t) => {
  //     if (t.imagen && !trapImagesRef.current[t.id]) {
  //       const img = new Image();
  //       img.src = t.imagen;
  //       img.crossOrigin = 'anonymous';
  //       trapImagesRef.current[t.id] = img;
  //     }
  //   });
  // }, [trampaTipos]);

  useEffect(() => {
    trampaTipos.forEach((t) => {
      if (t.imagen && !trapImagesRef.current[t.id]) {
        const img = new Image();

        img.onload = () => {
          redraw(); // 👈 clave
        };

        img.src = t.imagen;
        img.crossOrigin = 'anonymous';

        trapImagesRef.current[t.id] = img;
      }
    });
  }, [trampaTipos]);

  useEffect(() => {
    if (!mapa.background) {
      bgImageRef.current = null;
      redraw();
      return;
    }

    const img = new Image();
    img.src = mapa.background;
    img.onload = () => {
      bgImageRef.current = img;
      redraw();
    };
  }, [mapa.background]);

  useEffect(() => {
    const canvas = canvasRef.current;
    if (!canvas) return;
    canvas.width = CANVAS_WIDTH;
    canvas.height = CANVAS_HEIGHT;
    ctxRef.current = canvas.getContext('2d');
    redraw();
  }, []);

  useEffect(() => {
    redraw();
  }, [mapa.traps, zoom, panOffset, trapSize]);

  const resetZoom = () => {
    setZoom(100);
    setPanOffset({ x: 0, y: 0 });
  };

  /* =======================
     Render canvas
  ======================= */

  const redraw = () => {
    const ctx = ctxRef.current;
    if (!ctx) return;

    ctx.clearRect(0, 0, CANVAS_WIDTH, CANVAS_HEIGHT);
    ctx.save();

    const scale = zoom / 100;
    ctx.translate(panOffset.x, panOffset.y);
    ctx.scale(scale, scale);

    if (bgImageRef.current) {
      ctx.drawImage(bgImageRef.current, 0, 0, CANVAS_WIDTH, CANVAS_HEIGHT);
    }

    const half = trapSize / 2;

    // mapa.traps.forEach((trap, index) => {

    const typeCounters: Record<number, number> = {};

    mapa.traps.forEach((trap) => {
      const img = trapImagesRef.current[trap.trampa_tipo_id];

      if (img?.complete) {
        ctx.drawImage(
          img,
          trap.posx - half,
          trap.posy - half,
          trapSize,
          trapSize,
        );
      } else {
        ctx.fillStyle = '#9ca3af';
        ctx.fillRect(trap.posx - half, trap.posy - half, trapSize, trapSize);
      }

      // Número
      ctx.beginPath();
      ctx.arc(trap.posx, trap.posy - trapSize, trapSize / 2, 0, Math.PI * 2);
      // ctx.fillStyle = '#15803d';

      const color = TRAP_TYPE_COLORS[trap.trampa_tipo_id] ?? '#6b7280';
      ctx.fillStyle = color;

      ctx.fill();

      ctx.fillStyle = '#fff';
      ctx.font = 'bold 10px sans-serif';
      ctx.textAlign = 'center';
      ctx.textBaseline = 'middle';
      // ctx.fillText(String(index + 1), trap.posx, trap.posy - trapSize);

      typeCounters[trap.trampa_tipo_id] =
        (typeCounters[trap.trampa_tipo_id] ?? 0) + 1;

      const number = typeCounters[trap.trampa_tipo_id];

      // ctx.fillText(String(number), trap.posx, trap.posy - trapSize);

      ctx.fillText(trap.identificador, trap.posx, trap.posy - trapSize);
    });

    ctx.restore();
  };

  const getTrapSummary = () => {
    const counts: Record<number, number> = {};

    mapa.traps.forEach((t) => {
      counts[t.trampa_tipo_id] = (counts[t.trampa_tipo_id] ?? 0) + 1;
    });

    return trampaTipos
      .map((tipo) => ({
        ...tipo,
        count: counts[tipo.id] ?? 0,
        color: TRAP_TYPE_COLORS[tipo.id] ?? '#6b7280',
      }))
      .filter((t) => t.count > 0);
  };

  const drawExportOverlay = (ctx: CanvasRenderingContext2D) => {
    const padding = 20;

    /* ===========
     TÍTULO
  =========== */
    ctx.save();

    ctx.fillStyle = '#111';
    ctx.font = 'bold 26px sans-serif';
    ctx.textAlign = 'left';
    ctx.textBaseline = 'top';

    ctx.fillText(mapa.titulo ?? 'Mapa', padding, padding);

    /* ===========
     CONTAR TRAMPAS POR TIPO
  =========== */
    const counts: Record<number, number> = {};

    mapa.traps.forEach((t) => {
      counts[t.trampa_tipo_id] = (counts[t.trampa_tipo_id] ?? 0) + 1;
    });

    /* ===========
     LEYENDA
  =========== */
    let y = padding + 40;

    ctx.font = 'bold 14px sans-serif';
    ctx.fillStyle = '#111';
    ctx.fillText('Resumen de trampas', padding, y);

    y += 20;

    ctx.font = '13px sans-serif';

    trampaTipos.forEach((tipo) => {
      const count = counts[tipo.id] ?? 0;
      if (count === 0) return;

      const color = TRAP_TYPE_COLORS[tipo.id] ?? '#6b7280';

      /* círculo color */
      ctx.beginPath();
      ctx.fillStyle = color;
      ctx.arc(padding + 6, y + 7, 6, 0, Math.PI * 2);
      ctx.fill();

      /* texto */
      ctx.fillStyle = '#111';
      ctx.fillText(`${tipo.nombre}: ${count}`, padding + 18, y);

      y += 18;
    });

    ctx.restore();
  };

  /* =======================
     Helpers
  ======================= */

  const getMousePos = (e: MouseEvent<HTMLCanvasElement>) => {
    const rect = canvasRef.current!.getBoundingClientRect();
    const scale = zoom / 100;
    return {
      x: (e.clientX - rect.left - panOffset.x) / scale,
      y: (e.clientY - rect.top - panOffset.y) / scale,
    };
  };

  const findTrapAt = (x: number, y: number) =>
    mapa.traps.find((t) => Math.hypot(t.posx - x, t.posy - y) < trapSize / 2);

  /* =======================
     Eventos mouse
  ======================= */

  const handleMouseDown = (e: MouseEvent<HTMLCanvasElement>) => {
    const pos = getMousePos(e);

    // Botón central = Pan
    if (e.button === 1) {
      e.preventDefault();
      setWheelPan(true);
      setDragging({
        type: 'pan',
        startX: e.clientX - panOffset.x,
        startY: e.clientY - panOffset.y,
      });
      return;
    }

    // Click derecho = eliminar
    if (e.button === 2) {
      const trap = findTrapAt(pos.x, pos.y);
      if (trap) {
        onChange({
          ...mapa,
          traps: mapa.traps.filter((t) => t.tempId !== trap.tempId),
        });
      }
      return;
    }

    if (panMode) {
      setDragging({
        type: 'pan',
        startX: e.clientX - panOffset.x,
        startY: e.clientY - panOffset.y,
      });
      return;
    }

    const trap = findTrapAt(pos.x, pos.y);
    if (trap) {
      setDragging({
        type: 'trap',
        tempId: trap.tempId,
        offsetX: pos.x - trap.posx,
        offsetY: pos.y - trap.posy,
      });
      return;
    }

    // if (typeof mode === 'number') {
    //   onChange({
    //     ...mapa,
    //     traps: [
    //       ...mapa.traps,
    //       {
    //         tempId: uuidv4(),
    //         trampa_tipo_id: mode,
    //         posx: pos.x,
    //         posy: pos.y,
    //       },
    //     ],
    //   });
    // }

    if (typeof mode === 'number') {
      setPendingTrap({
        posx: pos.x,
        posy: pos.y,
        trampa_tipo_id: mode,
      });

      setIdentificador('');
      setErrorIdentificador('');
      setDialogOpen(true);
    }
  };

  const handleMouseMove = (e: MouseEvent<HTMLCanvasElement>) => {
    if (!dragging) return;

    if (dragging.type === 'pan') {
      setPanOffset({
        x: e.clientX - dragging.startX,
        y: e.clientY - dragging.startY,
      });
      return;
    }

    const pos = getMousePos(e);
    onChange({
      ...mapa,
      traps: mapa.traps.map((t) =>
        t.tempId === dragging.tempId
          ? {
              ...t,
              posx: pos.x - dragging.offsetX,
              posy: pos.y - dragging.offsetY,
            }
          : t,
      ),
    });
  };

  const handleMouseUp = () => {
    setDragging(null);
    setWheelPan(false);
  };

  /* =======================
     Acciones
  ======================= */

  const handleBackgroundUpload = (e: ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (!file) return;

    const reader = new FileReader();
    reader.onload = (ev) =>
      onChange({ ...mapa, background: ev.target?.result as string });
    reader.readAsDataURL(file);
  };

  const removeBackground = () => {
    onChange({ ...mapa, background: null });
    if (fileInputRef.current) fileInputRef.current.value = '';
  };

  // const downloadPNG = () => {
  //   const canvas = canvasRef.current;
  //   if (!canvas) return;
  //   const link = document.createElement('a');
  //   link.download = `mapa-${mapa.mapaId ?? 'nuevo'}.png`;
  //   link.href = canvas.toDataURL('image/png');
  //   link.click();
  // };

  // const downloadPNG = () => {
  //   const canvas = canvasRef.current;
  //   if (!canvas) return;

  //   const ctx = ctxRef.current;
  //   if (!ctx) return;

  //   /* redibujar base */
  //   redraw();

  //   /* dibujar overlay export */
  //   drawExportOverlay(ctx);

  //   /* exportar */
  //   const link = document.createElement('a');
  //   link.download = `mapa-${mapa.mapaId ?? 'nuevo'}.png`;
  //   link.href = canvas.toDataURL('image/png');
  //   link.click();

  //   /* volver a dibujar sin overlay */
  //   redraw();
  // };

  const downloadPNG = () => {
    const canvas = canvasRef.current;
    if (!canvas) return;

    const summary = getTrapSummary();

    /* altura extra para resumen */
    const summaryHeight = 40 + summary.length * 20 + 30;

    /* canvas temporal */
    const exportCanvas = document.createElement('canvas');
    exportCanvas.width = canvas.width;
    exportCanvas.height = canvas.height + summaryHeight;

    const ctx = exportCanvas.getContext('2d');
    if (!ctx) return;

    /* fondo blanco */
    ctx.fillStyle = '#ffffff';
    ctx.fillRect(0, 0, exportCanvas.width, exportCanvas.height);

    /* ============
     DIBUJAR MAPA
  ============ */
    ctx.drawImage(canvas, 0, 0);

    /* ============
     TÍTULO
  ============ */
    let y = canvas.height + 30;

    ctx.fillStyle = '#111';
    ctx.font = 'bold 20px sans-serif';
    ctx.fillText(mapa.titulo ?? 'Mapa', 20, y);

    y += 25;

    ctx.font = 'bold 14px sans-serif';
    ctx.fillText('Resumen de trampas', 20, y);

    y += 20;

    /* ============
     RESUMEN
  ============ */
    ctx.font = '13px sans-serif';

    summary.forEach((item) => {
      /* círculo color */
      ctx.beginPath();
      ctx.fillStyle = item.color;
      // ctx.arc(26, y + 6, 6, 0, Math.PI * 2);
      ctx.arc(26, y - 2, 6, 0, Math.PI * 2);
      ctx.fill();

      /* texto */
      ctx.fillStyle = '#111';
      ctx.fillText(`${item.nombre}: total = ${item.count}`, 40, y);

      y += 18;
    });

    /* ============
     EXPORTAR
  ============ */
    const link = document.createElement('a');
    link.download = `mapa-${mapa.mapaId ?? 'nuevo'}.png`;
    link.href = exportCanvas.toDataURL('image/png');
    link.click();
  };

  const clearMap = () => {
    if (!confirm('¿Limpiar este mapa?')) return;
    onChange({ ...mapa, traps: [] });
  };

  const confirmAddTrap = () => {
    if (!identificador.trim()) {
      setErrorIdentificador('El identificador es obligatorio');
      return;
    }

    const exists = mapa.traps.some(
      (t) => t.identificador === identificador.trim(),
    );

    if (exists) {
      setErrorIdentificador('Ya existe ese identificador');
      return;
    }

    if (!pendingTrap) return;

    onChange({
      ...mapa,
      traps: [
        ...mapa.traps,
        {
          tempId: uuidv4(),
          trampa_tipo_id: pendingTrap.trampa_tipo_id,
          identificador: identificador.trim(),
          posx: pendingTrap.posx,
          posy: pendingTrap.posy,
        },
      ],
    });

    setDialogOpen(false);
    setPendingTrap(null);
  };

  /* =======================
     Render
  ======================= */

  return (
    <div className="space-y-4">
      <div className="flex w-72 flex-col gap-1">
        <Label>Título del mapa</Label>
        <Input
          value={mapa.titulo ?? ''}
          placeholder="Ej: Planta almacén norte"
          onChange={(e) =>
            onChange({
              ...mapa,
              titulo: e.target.value,
            })
          }
        />
      </div>
      <div className="flex flex-wrap gap-3 rounded-lg border p-4">
        <Select onValueChange={(v) => setMode(Number(v))}>
          <SelectTrigger className="w-56">
            <SelectValue placeholder="Trampa" />
          </SelectTrigger>
          <SelectContent>
            {trampaTipos.map((t) => (
              <SelectItem key={t.id} value={String(t.id)}>
                {t.nombre}
              </SelectItem>
            ))}
          </SelectContent>
        </Select>

        <div className="flex items-center gap-2">
          <Label>Tamaño</Label>
          <Slider
            value={[trapSize]}
            min={10}
            max={80}
            step={2}
            onValueChange={(v) => setTrapSize(v[0])}
            className="w-36"
          />
        </div>

        <div className="flex items-center gap-2">
          <Label>Zoom {zoom}%</Label>
          <Slider
            value={[zoom]}
            min={25}
            max={300}
            step={5}
            onValueChange={(v) => setZoom(v[0])}
            className="w-36"
          />
        </div>

        <Button variant="outline" size="sm" onClick={resetZoom}>
          <RotateCcw className="mr-2 h-4 w-4" />
          Reestablecer Zoom
        </Button>

        <Button
          variant={panMode ? 'default' : 'outline'}
          size="sm"
          onClick={() => setPanMode(!panMode)}
        >
          <Hand className="mr-2 h-4 w-4" />
          Pan
        </Button>

        <Input
          ref={fileInputRef}
          type="file"
          accept="image/*"
          onChange={handleBackgroundUpload}
          className="w-64"
        />

        {mapa.background && (
          <Button variant="outline" size="sm" onClick={removeBackground}>
            Quitar fondo
          </Button>
        )}

        <Button variant="outline" size="sm" onClick={downloadPNG}>
          <Download className="mr-2 h-4 w-4" />
          Descargar PNG
        </Button>

        <Button variant="destructive" size="sm" onClick={clearMap}>
          <Trash2 className="mr-2 h-4 w-4" />
          Limpiar
        </Button>
      </div>

      <canvas
        ref={canvasRef}
        className={`border bg-white ${
          panMode || wheelPan
            ? 'cursor-grab active:cursor-grabbing'
            : 'cursor-crosshair'
        }`}
        onContextMenu={(e) => e.preventDefault()}
        onMouseDown={handleMouseDown}
        onMouseMove={handleMouseMove}
        onMouseUp={handleMouseUp}
        onMouseLeave={handleMouseUp}
      />

      {/* <Dialog open={dialogOpen} onOpenChange={setDialogOpen}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>Identificador de la trampa</DialogTitle>
          </DialogHeader>

          <div className="space-y-2">
            <Label>Identificador</Label>
            <Input
              ref={inputRef}
              value={identificador}
              onChange={(e) => {
                setIdentificador(e.target.value);
                setErrorIdentificador('');
              }}
              placeholder="Ej: T-01"
            />

            {errorIdentificador && (
              <p className="text-sm text-red-500">{errorIdentificador}</p>
            )}
          </div>

          <DialogFooter>
            <Button variant="outline" onClick={() => setDialogOpen(false)}>
              Cancelar
            </Button>

            <Button onClick={confirmAddTrap}>Agregar</Button>
          </DialogFooter>
        </DialogContent>
      </Dialog> */}

      <Dialog open={dialogOpen} onOpenChange={setDialogOpen}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>Identificador de la trampa</DialogTitle>
          </DialogHeader>

          <form
            onSubmit={(e) => {
              e.preventDefault();
              confirmAddTrap();
            }}
          >
            <div className="space-y-2">
              <Label>Identificador</Label>

              <Input
                ref={inputRef}
                value={identificador}
                onChange={(e) => {
                  setIdentificador(e.target.value);
                  setErrorIdentificador('');
                }}
                placeholder="Ej: T-01"
              />

              {errorIdentificador && (
                <p className="text-sm text-red-500">{errorIdentificador}</p>
              )}
            </div>

            <DialogFooter>
              <Button
                type="button"
                variant="outline"
                onClick={() => setDialogOpen(false)}
              >
                Cancelar
              </Button>

              <Button type="submit">Agregar</Button>
            </DialogFooter>
          </form>
        </DialogContent>
      </Dialog>
    </div>
  );
}

// 'use client';

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
// import { Slider } from '@/components/ui/slider';
// import { Hand } from 'lucide-react';
// import { ChangeEvent, MouseEvent, useEffect, useRef, useState } from 'react';
// import { v4 as uuidv4 } from 'uuid';

// /* =======================
//    Tipos
// ======================= */

// export type TextItem = {
//   id: string;
//   text: string;
//   x: number;
//   y: number;
//   listed: boolean;
//   vertical: boolean;
//   fontSize: number;
// };

// export type Trap = {
//   tempId: string;
//   id?: number;
//   trampa_tipo_id: number;
//   posx: number;
//   posy: number;
//   estado?: string;
// };

// export type MapEditorState = {
//   localId: string;
//   mapaId?: number;
//   texts: TextItem[];
//   traps: Trap[];
//   background: string | null;
// };

// type Dragging =
//   | { type: 'trap'; tempId: string; offsetX: number; offsetY: number }
//   | { type: 'pan'; startX: number; startY: number };

// interface Props {
//   mapa: MapEditorState;
//   trampaTipos: { id: number; nombre: string; imagen: string | null }[];
//   onChange: (mapa: MapEditorState) => void;
// }

// /* =======================
//    Componente
// ======================= */

// export default function CanvasEditor({ mapa, trampaTipos, onChange }: Props) {
//   const CANVAS_WIDTH = 1000;
//   const CANVAS_HEIGHT = 700;

//   const canvasRef = useRef<HTMLCanvasElement | null>(null);
//   const ctxRef = useRef<CanvasRenderingContext2D | null>(null);
//   const bgImageRef = useRef<HTMLImageElement | null>(null);
//   const trapImagesRef = useRef<Record<number, HTMLImageElement>>({});

//   const [mode, setMode] = useState<number | null>(null);
//   const [trapSize, setTrapSize] = useState<number>(30);
//   const [zoom, setZoom] = useState<number>(100);
//   const [panMode, setPanMode] = useState<boolean>(false);
//   const [panOffset, setPanOffset] = useState({ x: 0, y: 0 });
//   const [dragging, setDragging] = useState<Dragging | null>(null);

//   /* =======================
//      Cargar imágenes
//   ======================= */

//   useEffect(() => {
//     trampaTipos.forEach((tipo) => {
//       if (tipo.imagen && !trapImagesRef.current[tipo.id]) {
//         const img = new Image();
//         img.src = tipo.imagen;
//         img.crossOrigin = 'anonymous';
//         trapImagesRef.current[tipo.id] = img;
//       }
//     });
//   }, [trampaTipos]);

//   useEffect(() => {
//     if (!mapa.background) {
//       bgImageRef.current = null;
//       redraw();
//       return;
//     }

//     const img = new Image();
//     img.src = mapa.background;
//     img.onload = () => {
//       bgImageRef.current = img;
//       redraw();
//     };
//   }, [mapa.background]);

//   useEffect(() => {
//     const canvas = canvasRef.current;
//     if (!canvas) return;
//     canvas.width = CANVAS_WIDTH;
//     canvas.height = CANVAS_HEIGHT;
//     ctxRef.current = canvas.getContext('2d');
//     redraw();
//   }, []);

//   useEffect(() => {
//     redraw();
//   }, [mapa.traps, mapa.background, zoom, panOffset, trapSize]);

//   /* =======================
//      Dibujar canvas
//   ======================= */

//   const redraw = () => {
//     const ctx = ctxRef.current;
//     if (!ctx) return;

//     ctx.clearRect(0, 0, CANVAS_WIDTH, CANVAS_HEIGHT);
//     ctx.save();

//     const scale = zoom / 100;
//     ctx.translate(panOffset.x, panOffset.y);
//     ctx.scale(scale, scale);

//     if (bgImageRef.current) {
//       ctx.globalAlpha = 0.85;
//       ctx.drawImage(bgImageRef.current, 0, 0, CANVAS_WIDTH, CANVAS_HEIGHT);
//       ctx.globalAlpha = 1;
//     }

//     const half = trapSize / 2;

//     mapa.traps.forEach((trap, index) => {
//       const img = trapImagesRef.current[trap.trampa_tipo_id];

//       if (img?.complete) {
//         ctx.drawImage(
//           img,
//           trap.posx - half,
//           trap.posy - half,
//           trapSize,
//           trapSize,
//         );
//       } else {
//         ctx.fillStyle = '#9ca3af';
//         ctx.fillRect(trap.posx - half, trap.posy - half, trapSize, trapSize);
//       }

//       // Número
//       ctx.beginPath();
//       ctx.arc(trap.posx, trap.posy - trapSize, trapSize / 2, 0, Math.PI * 2);
//       ctx.fillStyle = '#15803d';
//       ctx.fill();

//       ctx.fillStyle = '#fff';
//       ctx.font = 'bold 10px sans-serif';
//       ctx.textAlign = 'center';
//       ctx.textBaseline = 'middle';
//       ctx.fillText(String(index + 1), trap.posx, trap.posy - trapSize);
//     });

//     ctx.restore();
//   };

//   /* =======================
//      Mouse helpers
//   ======================= */

//   const getMousePos = (e: MouseEvent<HTMLCanvasElement>) => {
//     const rect = canvasRef.current!.getBoundingClientRect();
//     const scale = zoom / 100;

//     return {
//       x: (e.clientX - rect.left - panOffset.x) / scale,
//       y: (e.clientY - rect.top - panOffset.y) / scale,
//     };
//   };

//   const handleMouseDown = (e: MouseEvent<HTMLCanvasElement>) => {
//     const pos = getMousePos(e);

//     if (panMode) {
//       setDragging({
//         type: 'pan',
//         startX: e.clientX - panOffset.x,
//         startY: e.clientY - panOffset.y,
//       });
//       return;
//     }

//     const clickedTrap = mapa.traps.find(
//       (t) => Math.hypot(t.posx - pos.x, t.posy - pos.y) < trapSize / 2,
//     );

//     if (clickedTrap) {
//       setDragging({
//         type: 'trap',
//         tempId: clickedTrap.tempId,
//         offsetX: pos.x - clickedTrap.posx,
//         offsetY: pos.y - clickedTrap.posy,
//       });
//       return;
//     }

//     if (typeof mode === 'number') {
//       onChange({
//         ...mapa,
//         traps: [
//           ...mapa.traps,
//           {
//             tempId: uuidv4(),
//             trampa_tipo_id: mode,
//             posx: pos.x,
//             posy: pos.y,
//             estado: 'activo',
//           },
//         ],
//       });
//     }
//   };

//   const handleMouseMove = (e: MouseEvent<HTMLCanvasElement>) => {
//     if (!dragging) return;

//     if (dragging.type === 'pan') {
//       setPanOffset({
//         x: e.clientX - dragging.startX,
//         y: e.clientY - dragging.startY,
//       });
//       return;
//     }

//     const pos = getMousePos(e);

//     onChange({
//       ...mapa,
//       traps: mapa.traps.map((t) =>
//         t.tempId === dragging.tempId
//           ? {
//               ...t,
//               posx: pos.x - dragging.offsetX,
//               posy: pos.y - dragging.offsetY,
//             }
//           : t,
//       ),
//     });
//   };

//   const handleMouseUp = () => setDragging(null);

//   /* =======================
//      Acciones
//   ======================= */

//   const handleBackgroundUpload = (e: ChangeEvent<HTMLInputElement>) => {
//     const file = e.target.files?.[0];
//     if (!file) return;
//     const reader = new FileReader();
//     reader.onload = (ev) =>
//       onChange({ ...mapa, background: ev.target?.result as string });
//     reader.readAsDataURL(file);
//   };

//   const removeBackground = () => {
//     onChange({ ...mapa, background: null });
//   };

//   const downloadPNG = () => {
//     const canvas = canvasRef.current;
//     if (!canvas) return;
//     const link = document.createElement('a');
//     link.download = `mapa-${mapa.mapaId ?? 'nuevo'}.png`;
//     link.href = canvas.toDataURL('image/png');
//     link.click();
//   };

//   const clearMap = () => {
//     if (!confirm('¿Limpiar este mapa?')) return;
//     onChange({ ...mapa, traps: [], texts: [] });
//   };

//   /* =======================
//      Render
//   ======================= */

//   return (
//     <div className="space-y-4">
//       {/* Herramientas */}
//       <div className="flex flex-wrap items-center gap-3 rounded-lg border p-4">
//         <Select onValueChange={(v) => setMode(Number(v))}>
//           <SelectTrigger className="w-60">
//             <SelectValue placeholder="Herramienta" />
//           </SelectTrigger>
//           <SelectContent>
//             {trampaTipos.map((t) => (
//               <SelectItem key={t.id} value={t.id.toString()}>
//                 {t.nombre}
//               </SelectItem>
//             ))}
//           </SelectContent>
//         </Select>

//         <div className="flex items-center gap-2">
//           <Label>Tamaño trampa: {trapSize}px</Label>
//           <Slider
//             value={[trapSize]}
//             min={10}
//             max={80}
//             step={2}
//             className="w-40"
//             onValueChange={(v) => setTrapSize(v[0])}
//           />
//         </div>

//         <div className="flex items-center gap-2">
//           <Label>Zoom {zoom}%</Label>
//           <Slider
//             value={[zoom]}
//             min={25}
//             max={300}
//             step={5}
//             className="w-40"
//             onValueChange={(v) => setZoom(v[0])}
//           />
//         </div>

//         <Button
//           variant={panMode ? 'default' : 'outline'}
//           size="sm"
//           onClick={() => setPanMode(!panMode)}
//         >
//           <Hand className="mr-2 h-4 w-4" />
//           Pan
//         </Button>

//         <Label>Fondo</Label>
//         <Input
//           type="file"
//           accept="image/*"
//           onChange={handleBackgroundUpload}
//           className="w-64"
//         />

//         {mapa.background && (
//           <Button variant="outline" size="sm" onClick={removeBackground}>
//             Quitar fondo
//           </Button>
//         )}

//         <Button variant="outline" size="sm" onClick={downloadPNG}>
//           ⬇ Descargar PNG
//         </Button>

//         <Button variant="destructive" size="sm" onClick={clearMap}>
//           Limpiar
//         </Button>
//       </div>

//       {/* Canvas */}
//       <canvas
//         ref={canvasRef}
//         width={CANVAS_WIDTH}
//         height={CANVAS_HEIGHT}
//         className={`border bg-white ${
//           panMode ? 'cursor-grab active:cursor-grabbing' : 'cursor-crosshair'
//         }`}
//         onMouseDown={handleMouseDown}
//         onMouseMove={handleMouseMove}
//         onMouseUp={handleMouseUp}
//         onMouseLeave={handleMouseUp}
//       />
//     </div>
//   );
// }

// 'use client';

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
// import { Slider } from '@/components/ui/slider';
// import { Hand } from 'lucide-react';
// import { ChangeEvent, MouseEvent, useEffect, useRef, useState } from 'react';
// import { v4 as uuidv4 } from 'uuid';

// /* =======================
//    Tipos
// ======================= */

// export type TextItem = {
//   id: string;
//   text: string;
//   x: number;
//   y: number;
//   listed: boolean;
//   vertical: boolean;
//   fontSize: number;
// };

// export type Trap = {
//   tempId: string;
//   id?: number;
//   trampa_tipo_id: number;
//   posx: number;
//   posy: number;
//   estado?: string;
// };

// export type MapEditorState = {
//   localId: string;
//   mapaId?: number;
//   texts: TextItem[];
//   traps: Trap[];
//   background: string | null;
// };

// type Dragging =
//   | { type: 'trap'; tempId: string; offsetX: number; offsetY: number }
//   | { type: 'pan'; startX: number; startY: number };

// interface Props {
//   mapa: MapEditorState;
//   trampaTipos: { id: number; nombre: string; imagen: string | null }[];
//   onChange: (mapa: MapEditorState) => void;
// }

// /* =======================
//    Componente
// ======================= */

// export default function CanvasEditor({ mapa, trampaTipos, onChange }: Props) {
//   const CANVAS_WIDTH = 1000;
//   const CANVAS_HEIGHT = 700;

//   const canvasRef = useRef<HTMLCanvasElement | null>(null);
//   const ctxRef = useRef<CanvasRenderingContext2D | null>(null);
//   const bgImageRef = useRef<HTMLImageElement | null>(null);
//   const trapImagesRef = useRef<Record<number, HTMLImageElement>>({});

//   const [mode, setMode] = useState<number | null>(null);
//   const [trapSize, setTrapSize] = useState(30);
//   const [zoom, setZoom] = useState(100);
//   const [panMode, setPanMode] = useState(false);
//   const [panOffset, setPanOffset] = useState({ x: 0, y: 0 });
//   const [dragging, setDragging] = useState<Dragging | null>(null);

//   /* =======================
//      Carga imágenes
//   ======================= */

//   useEffect(() => {
//     trampaTipos.forEach((t) => {
//       if (t.imagen && !trapImagesRef.current[t.id]) {
//         const img = new Image();
//         img.src = t.imagen;
//         img.crossOrigin = 'anonymous';
//         trapImagesRef.current[t.id] = img;
//       }
//     });
//   }, [trampaTipos]);

//   useEffect(() => {
//     if (!mapa.background) {
//       bgImageRef.current = null;
//       redraw();
//       return;
//     }

//     const img = new Image();
//     img.src = mapa.background;
//     img.onload = () => {
//       bgImageRef.current = img;
//       redraw();
//     };
//   }, [mapa.background]);

//   useEffect(() => {
//     const canvas = canvasRef.current;
//     if (!canvas) return;
//     canvas.width = CANVAS_WIDTH;
//     canvas.height = CANVAS_HEIGHT;
//     ctxRef.current = canvas.getContext('2d');
//     redraw();
//   }, []);

//   useEffect(() => {
//     redraw();
//   }, [mapa.texts, mapa.traps, zoom, panOffset, trapSize]);

//   /* =======================
//      Dibujo
//   ======================= */

//   const redraw = () => {
//     const ctx = ctxRef.current;
//     if (!ctx) return;

//     ctx.clearRect(0, 0, CANVAS_WIDTH, CANVAS_HEIGHT);
//     ctx.save();

//     const scale = zoom / 100;
//     ctx.translate(panOffset.x, panOffset.y);
//     ctx.scale(scale, scale);

//     if (bgImageRef.current) {
//       ctx.globalAlpha = 0.85;
//       ctx.drawImage(bgImageRef.current, 0, 0, CANVAS_WIDTH, CANVAS_HEIGHT);
//       ctx.globalAlpha = 1;
//     }

//     mapa.traps.forEach((trap, index) => {
//       const img = trapImagesRef.current[trap.trampa_tipo_id];
//       const half = trapSize / 2;

//       if (img?.complete) {
//         ctx.drawImage(
//           img,
//           trap.posx - half,
//           trap.posy - half,
//           trapSize,
//           trapSize,
//         );
//       }

//       ctx.fillStyle = '#15803d';
//       ctx.beginPath();
//       ctx.arc(trap.posx, trap.posy - trapSize, trapSize / 2, 0, Math.PI * 2);
//       ctx.fill();

//       ctx.fillStyle = '#fff';
//       ctx.font = 'bold 10px sans-serif';
//       ctx.textAlign = 'center';
//       ctx.textBaseline = 'middle';
//       ctx.fillText(String(index + 1), trap.posx, trap.posy - trapSize);
//     });

//     ctx.restore();
//   };

//   /* =======================
//      Mouse helpers
//   ======================= */

//   const getMousePos = (e: MouseEvent<HTMLCanvasElement>) => {
//     const rect = canvasRef.current!.getBoundingClientRect();
//     const scale = zoom / 100;
//     return {
//       x: (e.clientX - rect.left - panOffset.x) / scale,
//       y: (e.clientY - rect.top - panOffset.y) / scale,
//     };
//   };

//   const handleMouseDown = (e: MouseEvent<HTMLCanvasElement>) => {
//     const pos = getMousePos(e);

//     if (panMode) {
//       setDragging({
//         type: 'pan',
//         startX: e.clientX - panOffset.x,
//         startY: e.clientY - panOffset.y,
//       });
//       return;
//     }

//     const clicked = mapa.traps.find(
//       (t) => Math.hypot(t.posx - pos.x, t.posy - pos.y) < trapSize / 2,
//     );

//     if (clicked) {
//       setDragging({
//         type: 'trap',
//         tempId: clicked.tempId,
//         offsetX: pos.x - clicked.posx,
//         offsetY: pos.y - clicked.posy,
//       });
//       return;
//     }

//     if (typeof mode === 'number') {
//       onChange({
//         ...mapa,
//         traps: [
//           ...mapa.traps,
//           {
//             tempId: uuidv4(),
//             trampa_tipo_id: mode,
//             posx: pos.x,
//             posy: pos.y,
//             estado: 'activo',
//           },
//         ],
//       });
//     }
//   };

//   const handleMouseMove = (e: MouseEvent<HTMLCanvasElement>) => {
//     if (!dragging) return;

//     if (dragging.type === 'pan') {
//       setPanOffset({
//         x: e.clientX - dragging.startX,
//         y: e.clientY - dragging.startY,
//       });
//       return;
//     }

//     const pos = getMousePos(e);

//     onChange({
//       ...mapa,
//       traps: mapa.traps.map((t) =>
//         t.tempId === dragging.tempId
//           ? {
//               ...t,
//               posx: pos.x - dragging.offsetX,
//               posy: pos.y - dragging.offsetY,
//             }
//           : t,
//       ),
//     });
//   };

//   const handleMouseUp = () => setDragging(null);

//   /* =======================
//      Fondo
//   ======================= */

//   const handleBackgroundUpload = (e: ChangeEvent<HTMLInputElement>) => {
//     const file = e.target.files?.[0];
//     if (!file) return;
//     const reader = new FileReader();
//     reader.onload = (ev) =>
//       onChange({ ...mapa, background: ev.target?.result as string });
//     reader.readAsDataURL(file);
//   };

//   /* =======================
//      Render
//   ======================= */

//   return (
//     <div className="space-y-4">
//       {/* Herramientas */}
//       <div className="flex flex-wrap items-center gap-3">
//         <Select onValueChange={(v) => setMode(Number(v))}>
//           <SelectTrigger className="w-60">
//             <SelectValue placeholder="Herramienta" />
//           </SelectTrigger>
//           <SelectContent>
//             {trampaTipos.map((t) => (
//               <SelectItem key={t.id} value={t.id.toString()}>
//                 {t.nombre}
//               </SelectItem>
//             ))}
//           </SelectContent>
//         </Select>

//         <Label>Zoom {zoom}%</Label>
//         <Slider
//           value={[zoom]}
//           min={50}
//           max={300}
//           step={5}
//           className="w-40"
//           onValueChange={(v) => setZoom(v[0])}
//         />

//         <Button
//           variant={panMode ? 'default' : 'outline'}
//           size="sm"
//           onClick={() => setPanMode(!panMode)}
//         >
//           <Hand className="mr-2 h-4 w-4" />
//           Pan
//         </Button>

//         <Label>Fondo</Label>
//         <Input type="file" accept="image/*" onChange={handleBackgroundUpload} />
//       </div>

//       {/* Canvas */}
//       <canvas
//         ref={canvasRef}
//         className="border bg-white"
//         onMouseDown={handleMouseDown}
//         onMouseMove={handleMouseMove}
//         onMouseUp={handleMouseUp}
//         onMouseLeave={handleMouseUp}
//       />
//     </div>
//   );
// }
