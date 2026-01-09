// resources/js/Pages/Mapas/MapaEditor.tsx
import { Button } from '@/components/ui/button';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select';
import AppLayout from '@/layouts/app-layout';
import { type BreadcrumbItem } from '@/types';
import { Head, router } from '@inertiajs/react';
import {
  ChangeEvent,
  JSX,
  MouseEvent,
  useEffect,
  useRef,
  useState,
} from 'react';
import { v4 as uuidv4 } from 'uuid';

const breadcrumbs: BreadcrumbItem[] = [{ title: 'Mapas', href: '/mapas' }];

interface Empresa {
  id: number;
  nombre: string;
}

interface Almacen {
  id: number;
  nombre: string;
  empresa_id: number;
}

type TextItem = {
  id: string;
  text: string;
  x: number;
  y: number;
  listed: boolean;
  vertical: boolean;
  fontSize: number;
};

type Trap = {
  id: string;
  type: 'mouse' | 'insect' | 'caja' | 'viva' | 'pegajosa';
  x: number;
  y: number;
};

type Dragging =
  | { type: 'text'; id: string; offsetX: number; offsetY: number }
  | { type: 'trap'; id: string; offsetX: number; offsetY: number };

interface Props {
  empresas: Empresa[];
  allAlmacenes: Almacen[];
  selectedEmpresa?: number | null;
  selectedAlmacen?: number | null;
  mapa?: {
    texts: TextItem[];
    traps: Trap[];
    background: string | null;
  };
}

export default function MapaEditor(props: Props): JSX.Element {
  const CANVAS_WIDTH = 1000;
  const CANVAS_HEIGHT = 700;

  const canvasRef = useRef<HTMLCanvasElement | null>(null);
  const ctxRef = useRef<CanvasRenderingContext2D | null>(null);
  const backgroundImageRef = useRef<HTMLImageElement | null>(null);

  const insectTrapImageRef = useRef<HTMLImageElement>(new Image());
  const mouseTrapImageRef = useRef<HTMLImageElement>(new Image());
  const cajaTrapImageRef = useRef<HTMLImageElement>(new Image());
  const vivaTrapImageRef = useRef<HTMLImageElement>(new Image());
  const pegajosaTrapImageRef = useRef<HTMLImageElement>(new Image());

  const [mode, setMode] = useState<
    | 'text'
    | 'textListed'
    | 'mouseTrap'
    | 'insectTrap'
    | 'cajaTrap'
    | 'vivaTrap'
    | 'pegajosaTrap'
  >('text');
  const [textOrientation, setTextOrientation] = useState<
    'horizontal' | 'vertical'
  >('horizontal');
  const [textFontSize, setTextFontSize] = useState<number>(16);
  const [gridSize, setGridSize] = useState<number>(25);

  const [texts, setTexts] = useState<TextItem[]>([]);
  const [traps, setTraps] = useState<Trap[]>([]);
  const [background, setBackground] = useState<string | null>(null);
  const [history, setHistory] = useState<
    { texts: TextItem[]; traps: Trap[] }[]
  >([]);
  const [dragging, setDragging] = useState<Dragging | null>(null);

  const [selectedEmpresa, setSelectedEmpresa] = useState<number | null>(
    props.selectedEmpresa ?? null,
  );
  const [filteredAlmacenes, setFilteredAlmacenes] = useState<Almacen[]>([]);
  const [selectedAlmacen, setSelectedAlmacen] = useState<number | null>(
    props.selectedAlmacen ?? null,
  );

  const deleteTrap = (id: string) => {
    saveHistory();
    setTraps((prev) => prev.filter((t) => t.id !== id));
  };

  const handleContextMenu = (e: MouseEvent<HTMLCanvasElement>) => {
    e.preventDefault();

    const pos = getMousePos(e);

    const clickedTrap = traps.find(
      (t) => Math.hypot(t.x - pos.x, t.y - pos.y) < 15,
    );

    if (clickedTrap) {
      const confirmDelete = confirm('¿Eliminar esta trampa?');
      if (confirmDelete) {
        deleteTrap(clickedTrap.id);
      }
    }
  };

  useEffect(() => {
    mouseTrapImageRef.current.src = '/images/trampas/trampa_raton.jpg';
    insectTrapImageRef.current.src = '/images/trampas/trampa_insecto.jpg';
    cajaTrapImageRef.current.src = '/images/trampas/caja_negra.jpg';
    vivaTrapImageRef.current.src = '/images/trampas/captura_viva.jpg';
    pegajosaTrapImageRef.current.src = '/images/trampas/pegajosa.png';
  }, []);

  useEffect(() => {
    if (selectedEmpresa) {
      setFilteredAlmacenes(
        props.allAlmacenes.filter((a) => a.empresa_id === selectedEmpresa),
      );
      if (
        selectedAlmacen &&
        !props.allAlmacenes.find(
          (a) => a.id === selectedAlmacen && a.empresa_id === selectedEmpresa,
        )
      ) {
        setSelectedAlmacen(null);
      }
    } else {
      setFilteredAlmacenes([]);
      setSelectedAlmacen(null);
    }
  }, [selectedEmpresa, props.allAlmacenes]);

  useEffect(() => {
    if (props.mapa) {
      setTexts(props.mapa.texts || []);
      setTraps(props.mapa.traps || []);
      setBackground(props.mapa.background);
    } else {
      setTexts([]);
      setTraps([]);
      setBackground(null);
    }
    setHistory([]);
  }, [props.mapa]);

  useEffect(() => {
    const canvas = canvasRef.current;
    if (!canvas) return;
    const ctx = canvas.getContext('2d');
    if (!ctx) return;
    ctxRef.current = ctx;

    // Tamaño fijo REAL del canvas
    canvas.width = CANVAS_WIDTH;
    canvas.height = CANVAS_HEIGHT;

    redraw();
  }, []);

  useEffect(() => {
    if (background) {
      const img = new Image();
      img.src = background;
      img.onload = () => {
        backgroundImageRef.current = img;
        redraw();
      };
    } else {
      backgroundImageRef.current = null;
      redraw();
    }
  }, [background]);

  useEffect(() => {
    redraw();
  }, [texts, traps, background]);

  const resizeCanvas = () => {
    const canvas = canvasRef.current;
    if (!canvas || !ctxRef.current) return;
    const rect = canvas.getBoundingClientRect();
    canvas.width = rect.width;
    canvas.height = rect.height;
    redraw();
  };

  const saveHistory = () => {
    setHistory((prev) => [...prev, { texts: [...texts], traps: [...traps] }]);
  };

  const undo = () => {
    if (!history.length) return;
    const last = history[history.length - 1];
    setTexts(last.texts);
    setTraps(last.traps);
    setHistory(history.slice(0, -1));
  };

  const drawGrid = (ctx: CanvasRenderingContext2D) => {
    const { width, height } = ctx.canvas;
    ctx.strokeStyle = '#e5e7eb';
    ctx.lineWidth = 1;
    for (let x = 0; x <= width; x += gridSize) {
      ctx.beginPath();
      ctx.moveTo(x, 0);
      ctx.lineTo(x, height);
      ctx.stroke();
    }
    for (let y = 0; y <= height; y += gridSize) {
      ctx.beginPath();
      ctx.moveTo(0, y);
      ctx.lineTo(width, y);
      ctx.stroke();
    }
  };

  const redraw = () => {
    const ctx = ctxRef.current;
    if (!ctx) return;
    ctx.clearRect(0, 0, ctx.canvas.width, ctx.canvas.height);

    if (backgroundImageRef.current) {
      ctx.drawImage(
        backgroundImageRef.current,
        0,
        0,
        ctx.canvas.width,
        ctx.canvas.height,
      );
    }

    drawGrid(ctx);

    texts.forEach((t) => drawText(ctx, t));
    // traps.forEach((t) => drawTrap(ctx, t));
    traps.forEach((t, index) => drawTrap(ctx, t, index));
  };

  const drawText = (ctx: CanvasRenderingContext2D, t: TextItem) => {
    ctx.fillStyle = t.listed ? '#111827' : '#6b7280';
    ctx.font = `${t.fontSize}px sans-serif`;

    if (t.vertical) {
      ctx.save();
      ctx.translate(t.x, t.y);
      ctx.rotate(-Math.PI / 2);
      ctx.fillText(t.text, 0, 0);
      ctx.restore();
    } else {
      ctx.fillText(t.text, t.x, t.y);
    }
  };

  // const drawTrap = (ctx: CanvasRenderingContext2D, trap: Trap) => {
  //   const img =
  //     trap.type === 'mouse'
  //       ? mouseTrapImageRef.current
  //       : insectTrapImageRef.current;
  //   if (img.complete) {
  //     ctx.drawImage(img, trap.x - 15, trap.y - 15, 45, 45);
  //   }
  // };

  const drawTrap = (
    ctx: CanvasRenderingContext2D,
    trap: Trap,
    index: number,
  ) => {
    // const img =
    //   trap.type === 'mouse'
    //     ? mouseTrapImageRef.current
    //     : insectTrapImageRef.current;

    // const trapImageRefs = {
    //   mouse: mouseTrapImageRef,
    //   insect: insectTrapImageRef,
    //   caja: cajaTrapImageRef,
    //   viva: vivaTrapImageRef,
    //   pegajosa: pegajosaTrapImageRef
    // }
    // const img = trapImageRefs[trap.type]?.current;

    const img =
      trap.type === 'mouse'
        ? mouseTrapImageRef.current
        : trap.type === 'insect'
          ? insectTrapImageRef.current
          : trap.type === 'caja'
            ? cajaTrapImageRef.current
            : trap.type === 'viva'
              ? vivaTrapImageRef.current
              : pegajosaTrapImageRef.current;

    // Dibujo de la trampa
    if (img.complete) {
      ctx.drawImage(img, trap.x - 15, trap.y - 15, 45, 45);
    }

    // ===== DIBUJAR ÍNDICE =====
    const label = String(index + 1);

    ctx.save();

    // Fondo circular
    ctx.beginPath();
    ctx.arc(trap.x, trap.y - 22, 10, 0, Math.PI * 2);
    // ctx.fillStyle = '#111827'; // gris oscuro
    ctx.fillStyle = '#0f0'; // gris oscuro
    ctx.fill();

    // Texto del índice
    // ctx.fillStyle = '#ffffff';
    ctx.fillStyle = '#f00';
    ctx.font = '12px sans-serif';
    ctx.textAlign = 'center';
    ctx.textBaseline = 'middle';
    ctx.fillText(label, trap.x, trap.y - 22);

    ctx.restore();
  };

  const getMousePos = (e: MouseEvent<HTMLCanvasElement>) => {
    const rect = canvasRef.current?.getBoundingClientRect();
    return {
      x: e.clientX - (rect?.left ?? 0),
      y: e.clientY - (rect?.top ?? 0),
    };
  };

  const handleMouseDown = (e: MouseEvent<HTMLCanvasElement>) => {
    if (!selectedAlmacen) return;

    const pos = getMousePos(e);

    // Buscar texto clickeado
    const clickedText = texts.find(
      (t) => Math.abs(t.x - pos.x) < 60 && Math.abs(t.y - pos.y) < 20,
    );
    if (clickedText) {
      setDragging({
        type: 'text',
        id: clickedText.id,
        offsetX: pos.x - clickedText.x,
        offsetY: pos.y - clickedText.y,
      });
      return;
    }

    // Buscar trampa clickeada
    const clickedTrap = traps.find(
      (t) => Math.hypot(t.x - pos.x, t.y - pos.y) < 15,
    );
    if (clickedTrap) {
      setDragging({
        type: 'trap',
        id: clickedTrap.id,
        offsetX: pos.x - clickedTrap.x,
        offsetY: pos.y - clickedTrap.y,
      });
      return;
    }

    // Agregar nuevo elemento
    saveHistory();

    if (mode === 'text' || mode === 'textListed') {
      const text = prompt('Ingrese el texto:');
      if (!text) return;
      setTexts((prev) => [
        ...prev,
        {
          id: uuidv4(),
          text,
          x: pos.x,
          y: pos.y,
          listed: mode === 'textListed',
          vertical: textOrientation === 'vertical',
          fontSize: textFontSize,
        },
      ]);
    } else if (
      mode === 'mouseTrap' ||
      mode === 'insectTrap' ||
      mode === 'cajaTrap' ||
      mode === 'vivaTrap' ||
      mode === 'pegajosaTrap'
    ) {
      setTraps((prev) => [
        ...prev,
        {
          id: uuidv4(),
          // type: mode === 'mouseTrap' ? 'mouse' : 'insect',
          type:
            mode === 'mouseTrap'
              ? 'mouse'
              : mode === 'insectTrap'
                ? 'insect'
                : mode === 'cajaTrap'
                  ? 'caja'
                  : mode === 'vivaTrap'
                    ? 'viva'
                    : 'pegajosa',
          x: pos.x,
          y: pos.y,
        },
      ]);
    }
  };

  const handleMouseMove = (e: MouseEvent<HTMLCanvasElement>) => {
    if (!dragging) return;
    const pos = getMousePos(e);

    if (dragging.type === 'text') {
      setTexts((prev) =>
        prev.map((t) =>
          t.id === dragging.id
            ? { ...t, x: pos.x - dragging.offsetX, y: pos.y - dragging.offsetY }
            : t,
        ),
      );
    } else if (dragging.type === 'trap') {
      setTraps((prev) =>
        prev.map((t) =>
          t.id === dragging.id
            ? { ...t, x: pos.x - dragging.offsetX, y: pos.y - dragging.offsetY }
            : t,
        ),
      );
    }

    redraw();
  };

  const handleMouseUp = () => {
    if (dragging) {
      setDragging(null);
    }
  };

  const clearCanvas = () => {
    saveHistory();
    setTexts([]);
    setTraps([]);
  };

  const saveDrawing = () => {
    if (!selectedAlmacen) {
      alert('Seleccione un almacén primero');
      return;
    }

    router.post(
      'mapas',
      {
        empresa_id: selectedEmpresa,
        almacen_id: selectedAlmacen,
        texts,
        traps,
        background,
      },
      {
        preserveState: true,
        onSuccess: () => {
          alert('Mapa guardado exitosamente');
        },
        onError: (errors) => {
          console.error(errors);
          alert('Error al guardar el mapa');
        },
      },
    );
  };

  const updateText = (id: string, newText: string) => {
    setTexts((prev) =>
      prev.map((t) => (t.id === id ? { ...t, text: newText } : t)),
    );
  };

  const deleteText = (id: string) => {
    saveHistory();
    setTexts((prev) => prev.filter((t) => t.id !== id));
  };

  const handleBackgroundUpload = (e: ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (!file) return;
    const reader = new FileReader();
    reader.onload = (ev) => setBackground(ev.target?.result as string);
    reader.readAsDataURL(file);
  };

  const handleEmpresaChange = (value: string) => {
    const empresaId = Number(value);
    setSelectedEmpresa(empresaId);
  };

  const handleAlmacenChange = (value: string) => {
    const almacenId = Number(value);
    setSelectedAlmacen(almacenId);
    router.get(
      'mapas',
      {
        empresa_id: selectedEmpresa,
        almacen_id: almacenId,
      },
      {
        preserveState: true,
        replace: true,
      },
    );
  };

  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Mapas de Control de Plagas" />

      <div className="space-y-6 p-6">
        <h1 className="text-2xl font-bold">Gestión de Mapas de Trampas</h1>

        <div className="flex flex-wrap gap-6">
          <div>
            <Label>Empresa</Label>
            <Select
              value={selectedEmpresa?.toString() ?? ''}
              onValueChange={handleEmpresaChange}
            >
              <SelectTrigger className="w-72">
                <SelectValue placeholder="Seleccione empresa" />
              </SelectTrigger>
              <SelectContent>
                {props.empresas.map((e) => (
                  <SelectItem key={e.id} value={e.id.toString()}>
                    {e.nombre}
                  </SelectItem>
                ))}
              </SelectContent>
            </Select>
          </div>

          <div>
            <Label>Almacén</Label>
            <Select
              value={selectedAlmacen?.toString() ?? ''}
              onValueChange={handleAlmacenChange}
              disabled={!selectedEmpresa}
            >
              <SelectTrigger className="w-72">
                <SelectValue placeholder="Seleccione almacén" />
              </SelectTrigger>
              <SelectContent>
                {filteredAlmacenes.map((a) => (
                  <SelectItem key={a.id} value={a.id.toString()}>
                    {a.nombre}
                  </SelectItem>
                ))}
              </SelectContent>
            </Select>
          </div>
        </div>

        <div className="flex flex-wrap items-center gap-3">
          <Select value={mode} onValueChange={(v) => setMode(v as any)}>
            <SelectTrigger className="w-64">
              <SelectValue placeholder="Herramienta" />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value="text">Agregar texto</SelectItem>
              <SelectItem value="textListed">
                Agregar texto (listado)
              </SelectItem>
              <SelectItem value="mouseTrap">Trampa para ratones</SelectItem>
              <SelectItem value="insectTrap">Trampa para insectos</SelectItem>
              <SelectItem value="cajaTrap">Trampa Caja</SelectItem>
              <SelectItem value="vivaTrap">Trampa viva</SelectItem>
              <SelectItem value="pegajosaTrap">Trampa Pegajosa</SelectItem>
            </SelectContent>
          </Select>

          {(mode === 'text' || mode === 'textListed') && (
            <>
              <Select
                value={textOrientation}
                onValueChange={(v) => setTextOrientation(v as any)}
              >
                <SelectTrigger className="w-36">
                  <SelectValue placeholder="Orientación" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="horizontal">Horizontal</SelectItem>
                  <SelectItem value="vertical">Vertical</SelectItem>
                </SelectContent>
              </Select>

              <div className="flex items-center gap-2">
                <Label>Tamaño:</Label>
                <Input
                  type="number"
                  value={textFontSize}
                  onChange={(e) => setTextFontSize(Number(e.target.value))}
                  className="w-20"
                  min={8}
                  max={48}
                />
              </div>
            </>
          )}

          {/* <div className="flex items-center gap-2">
            <span>Grid:</span>
            <Input
              type="number"
              value={gridSize}
              onChange={(e) => setGridSize(Number(e.target.value))}
              className="w-20"
              min={10}
              step={5}
            />
          </div> */}

          <div className="flex items-center gap-3">
            <Label>Fondo:</Label>
            <Input
              type="file"
              accept="image/*"
              onChange={handleBackgroundUpload}
              className="w-64"
              disabled={!selectedAlmacen}
            />
            {background && (
              <Button
                variant="outline"
                size="sm"
                onClick={() => setBackground(null)}
              >
                Quitar fondo
              </Button>
            )}
          </div>

          <div className="flex gap-2">
            <Button variant="outline" onClick={undo}>
              Deshacer
            </Button>
            <Button variant="outline" onClick={clearCanvas}>
              Limpiar
            </Button>
            <Button onClick={saveDrawing} disabled={!selectedAlmacen}>
              Guardar mapa
            </Button>
          </div>
        </div>

        <Card className="rounded-none border-muted py-2 shadow-muted">
          <CardContent className="overflow-auto p-0">
            <div className="mx-auto w-fit">
              <canvas
                ref={canvasRef}
                width={CANVAS_WIDTH}
                height={CANVAS_HEIGHT}
                // className="h-[700px] w-full cursor-crosshair touch-none bg-white"
                className="h-[700px] w-[1000px] cursor-crosshair touch-none border bg-white"
                onMouseDown={handleMouseDown}
                onMouseMove={handleMouseMove}
                onMouseUp={handleMouseUp}
                onMouseLeave={handleMouseUp}
                onContextMenu={handleContextMenu}
              />
            </div>
          </CardContent>
        </Card>

        {texts.filter((t) => t.listed).length > 0 && (
          <Card>
            <CardHeader>
              <CardTitle>Elementos listados</CardTitle>
            </CardHeader>
            <CardContent className="space-y-2">
              {texts
                .filter((t) => t.listed)
                .map((t) => (
                  <div
                    key={t.id}
                    className="flex items-center gap-3 border-b pb-2"
                  >
                    <Input
                      value={t.text}
                      onChange={(e) => updateText(t.id, e.target.value)}
                      className="flex-1"
                    />
                    <Button
                      variant="destructive"
                      size="icon"
                      onClick={() => deleteText(t.id)}
                    >
                      ×
                    </Button>
                  </div>
                ))}
            </CardContent>
          </Card>
        )}
      </div>
    </AppLayout>
  );
}
