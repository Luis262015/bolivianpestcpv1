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
import { Head } from '@inertiajs/react';
// import { Inertia } from '@inertiajs/inertia';
import { JSX, MouseEvent, useEffect, useRef, useState } from 'react';
import { v4 as uuidv4 } from 'uuid';

const breadcrumbs: BreadcrumbItem[] = [
  {
    title: 'Mapas',
    href: '/mapas',
  },
];

type Shape =
  | {
      id: string;
      type: 'wall' | 'door';
      x1: number;
      y1: number;
      x2: number;
      y2: number;
      color: string;
      style?: 'solid' | 'dashed';
    }
  | {
      id: string;
      type: 'square';
      x: number;
      y: number;
      w: number;
      h: number;
      color: string;
    }
  | {
      id: string;
      type: 'arc';
      x: number;
      y: number;
      r: number;
      direction: 'up' | 'right' | 'down' | 'left';
      color: string;
    };

type TextItem = {
  id: string;
  text: string;
  x: number;
  y: number;
  listed: boolean;
  vertical: boolean;
  fontSize: number;
};

type Dragging = {
  type: 'text' | 'shape';
  id: string;
  offsetX: number;
  offsetY: number;
};

export default function Lista(): JSX.Element {
  const canvasRef = useRef<HTMLCanvasElement | null>(null);
  const ctxRef = useRef<CanvasRenderingContext2D | null>(null);

  const [mode, setMode] = useState<
    'wall' | 'door' | 'square' | 'arc' | 'text' | 'textListed'
  >('wall');
  const [color, setColor] = useState('#1e40af');
  const [arcDirection, setArcDirection] = useState<
    'up' | 'right' | 'down' | 'left'
  >('up');
  const [textOrientation, setTextOrientation] = useState<
    'horizontal' | 'vertical'
  >('horizontal');
  const [textFontSize, setTextFontSize] = useState<number>(16);
  const [wallStyle, setWallStyle] = useState<'solid' | 'dashed'>('solid');
  const [gridSize, setGridSize] = useState<number>(25);

  const [startPos, setStartPos] = useState<{ x: number; y: number } | null>(
    null,
  );
  const [shapes, setShapes] = useState<Shape[]>([]);
  const [preview, setPreview] = useState<Shape | null>(null);
  const [texts, setTexts] = useState<TextItem[]>([]);
  const [history, setHistory] = useState<
    { shapes: Shape[]; texts: TextItem[] }[]
  >([]);
  const [dragging, setDragging] = useState<Dragging | null>(null);

  useEffect(() => {
    const canvas = canvasRef.current;
    if (!canvas) return;
    const ctx = canvas.getContext('2d');
    if (!ctx) return;
    ctxRef.current = ctx;
    resizeCanvas();
    window.addEventListener('resize', resizeCanvas);
    return () => window.removeEventListener('resize', resizeCanvas);
  }, []);

  const resizeCanvas = () => {
    const canvas = canvasRef.current;
    if (!canvas || !ctxRef.current) return;
    const rect = canvas.getBoundingClientRect();
    canvas.width = rect.width;
    canvas.height = rect.height;
    redraw();
  };

  const saveHistory = () => {
    setHistory((prev) => [...prev, { shapes: [...shapes], texts: [...texts] }]);
  };

  const undo = () => {
    if (!history.length) return;
    const last = history[history.length - 1];
    setShapes(last.shapes);
    setTexts(last.texts);
    setHistory(history.slice(0, -1));
  };

  const drawGrid = (ctx: CanvasRenderingContext2D) => {
    const { width, height } = ctx.canvas;
    ctx.beginPath();
    ctx.strokeStyle = '#e5e7eb';
    ctx.lineWidth = 1;
    for (let x = 0; x <= width; x += gridSize) {
      ctx.moveTo(x, 0);
      ctx.lineTo(x, height);
    }
    for (let y = 0; y <= height; y += gridSize) {
      ctx.moveTo(0, y);
      ctx.lineTo(width, y);
    }
    ctx.stroke();
    ctx.closePath();
  };

  const redraw = () => {
    const ctx = ctxRef.current;
    if (!ctx) return;
    ctx.clearRect(0, 0, ctx.canvas.width, ctx.canvas.height);
    drawGrid(ctx);
    for (const s of shapes) drawShape(ctx, s);
    if (preview) drawShape(ctx, preview, true);
    for (const t of texts) drawText(ctx, t);
  };

  const drawShape = (
    ctx: CanvasRenderingContext2D,
    s: Shape,
    isPreview = false,
  ) => {
    ctx.beginPath();
    ctx.globalAlpha = isPreview ? 0.5 : 1;

    switch (s.type) {
      case 'wall':
        ctx.strokeStyle = '#000';
        ctx.lineWidth = 5;
        if (s.style === 'dashed') ctx.setLineDash([10, 5]);
        else ctx.setLineDash([]);
        ctx.moveTo(s.x1, s.y1);
        ctx.lineTo(s.x2, s.y2);
        ctx.stroke();
        ctx.setLineDash([]);
        break;
      case 'door':
        ctx.strokeStyle = s.color;
        ctx.lineWidth = 6;
        ctx.moveTo(s.x1, s.y1);
        ctx.lineTo(s.x2, s.y2);
        ctx.stroke();
        break;
      case 'square':
        ctx.fillStyle = s.color;
        ctx.fillRect(s.x, s.y, s.w, s.h);
        break;
      case 'arc':
        ctx.strokeStyle = s.color;
        ctx.lineWidth = 3;
        let startAngle = 0;
        switch (s.direction) {
          case 'up':
            startAngle = Math.PI;
            break;
          case 'right':
            startAngle = -Math.PI / 2;
            break;
          case 'down':
            startAngle = 0;
            break;
          case 'left':
            startAngle = Math.PI / 2;
            break;
        }
        ctx.arc(s.x, s.y, s.r, startAngle, startAngle + Math.PI / 4);
        ctx.stroke();
        break;
    }
    ctx.globalAlpha = 1;
    ctx.closePath();
  };

  const drawText = (ctx: CanvasRenderingContext2D, t: TextItem) => {
    ctx.fillStyle = t.listed ? '#111827' : '#9ca3af';
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

  const getMousePos = (e: MouseEvent<HTMLCanvasElement>) => {
    const rect = canvasRef.current?.getBoundingClientRect();
    return {
      x: e.clientX - (rect?.left ?? 0),
      y: e.clientY - (rect?.top ?? 0),
    };
  };

  const findShapeAtPos = (pos: { x: number; y: number }) => {
    for (let i = shapes.length - 1; i >= 0; i--) {
      const s = shapes[i];
      if (s.type === 'wall' || s.type === 'door') {
        const minX = Math.min(s.x1, s.x2) - 5;
        const maxX = Math.max(s.x1, s.x2) + 5;
        const minY = Math.min(s.y1, s.y2) - 5;
        const maxY = Math.max(s.y1, s.y2) + 5;
        if (pos.x >= minX && pos.x <= maxX && pos.y >= minY && pos.y <= maxY)
          return s;
      } else if (s.type === 'square' || s.type === 'arc') {
        if (
          pos.x >= s.x - 5 &&
          pos.x <= s.x + (s.w || s.r) + 5 &&
          pos.y >= s.y - 5 &&
          pos.y <= s.y + (s.h || s.r) + 5
        )
          return s;
      }
    }
    return null;
  };

  const handleMouseDown = (e: MouseEvent<HTMLCanvasElement>) => {
    const pos = getMousePos(e);

    const clickedText = texts.find(
      (t) => Math.abs(t.x - pos.x) < 50 && Math.abs(t.y - pos.y) < 15,
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

    const clickedShape = findShapeAtPos(pos);
    if (clickedShape) {
      setDragging({
        type: 'shape',
        id: (clickedShape as any).id,
        offsetX: pos.x - (clickedShape as any).x || 0,
        offsetY: pos.y - (clickedShape as any).y || 0,
      });
      return;
    }

    if (mode === 'text' || mode === 'textListed') {
      const text = prompt('Ingrese texto:');
      if (!text) return;
      saveHistory();
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
      return;
    }

    setStartPos(pos);
  };

  const handleMouseMove = (e: MouseEvent<HTMLCanvasElement>) => {
    const pos = getMousePos(e);
    if (dragging) {
      if (dragging.type === 'text') {
        setTexts((prev) =>
          prev.map((t) =>
            t.id === dragging.id
              ? {
                  ...t,
                  x: pos.x - dragging.offsetX,
                  y: pos.y - dragging.offsetY,
                }
              : t,
          ),
        );
      } else if (dragging.type === 'shape') {
        setShapes((prev) =>
          prev.map((s) => {
            if (s.id !== dragging.id) return s;
            if (s.type === 'wall' || s.type === 'door') {
              const dx = pos.x - s.x1;
              const dy = pos.y - s.y1;
              return {
                ...s,
                x1: pos.x,
                y1: pos.y,
                x2: s.x2 + dx,
                y2: s.y2 + dy,
              };
            } else {
              return { ...s, x: pos.x, y: pos.y };
            }
          }),
        );
      }
      redraw();
      return;
    }

    if (!startPos) return;
    let newPreview: Shape;
    if (mode === 'wall' || mode === 'door') {
      const dx = pos.x - startPos.x;
      const dy = pos.y - startPos.y;
      if (Math.abs(dx) > Math.abs(dy)) {
        newPreview = {
          id: uuidv4(),
          type: mode,
          x1: startPos.x,
          y1: startPos.y,
          x2: pos.x,
          y2: startPos.y,
          color,
          style: mode === 'wall' ? wallStyle : undefined,
        };
      } else {
        newPreview = {
          id: uuidv4(),
          type: mode,
          x1: startPos.x,
          y1: startPos.y,
          x2: startPos.x,
          y2: pos.y,
          color,
          style: mode === 'wall' ? wallStyle : undefined,
        };
      }
    } else if (mode === 'square') {
      newPreview = {
        id: uuidv4(),
        type: 'square',
        x: startPos.x,
        y: startPos.y,
        w: pos.x - startPos.x,
        h: pos.y - startPos.y,
        color,
      };
    } else if (mode === 'arc') {
      const dx = pos.x - startPos.x;
      const dy = pos.y - startPos.y;
      const r = Math.sqrt(dx * dx + dy * dy);
      newPreview = {
        id: uuidv4(),
        type: 'arc',
        x: startPos.x,
        y: startPos.y,
        r,
        direction: arcDirection,
        color,
      };
    } else return;
    setPreview(newPreview);
    redraw();
  };

  const handleMouseUp = () => {
    if (dragging) {
      saveHistory();
      setDragging(null);
      return;
    }
    if (preview) {
      saveHistory();
      setShapes((prev) => [...prev, preview]);
      setPreview(null);
      setStartPos(null);
    }
  };

  useEffect(() => {
    redraw();
  }, [shapes, texts, preview]);

  const clearCanvas = () => {
    saveHistory();
    setShapes([]);
    setTexts([]);
    setPreview(null);
  };
  const saveDrawing = () => {
    const canvas = canvasRef.current;
    if (!canvas) return;
    const dataUrl = canvas.toDataURL('image/png');
    // Inertia.post('/drawings', { image: dataUrl, texts });
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

  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Mapas" />
      <div className="p-6">
        <div className="text-2xl font-bold">Gestión de Mapas</div>
      </div>
      <div className="p-6">
        <div className="flex flex-wrap">
          <div className="me-5">
            <Label>Empresa</Label>
            <Select>
              <SelectTrigger className="w-80">
                <SelectValue placeholder="Pruebas"></SelectValue>
              </SelectTrigger>
            </Select>
          </div>
          <div>
            <Label>Almacen</Label>
            <Select>
              <SelectTrigger className="w-80">
                <SelectValue placeholder="Pruebas"></SelectValue>
              </SelectTrigger>
            </Select>
          </div>
        </div>
      </div>
      <div className="min-h-screen p-6">
        <div className="mx-auto grid max-w-7xl grid-cols-12 gap-6">
          <Card className="col-span-9">
            <CardHeader>
              <CardTitle>Editor 2D Avanzado</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="mb-4 flex flex-wrap items-center gap-3">
                <Select value={mode} onValueChange={(v) => setMode(v as any)}>
                  <SelectTrigger className="w-[180px]">
                    <SelectValue placeholder="Herramienta" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="wall">Pared</SelectItem>
                    <SelectItem value="door">Puerta</SelectItem>
                    <SelectItem value="square">Cuadro / Zona</SelectItem>
                    <SelectItem value="arc">Arco 45°</SelectItem>
                    <SelectItem value="text">Texto fijo</SelectItem>
                    <SelectItem value="textListed">Texto listado</SelectItem>
                  </SelectContent>
                </Select>

                {(mode === 'door' || mode === 'square' || mode === 'arc') && (
                  <input
                    type="color"
                    value={color}
                    onChange={(e) => setColor(e.target.value)}
                    className="rounded border p-1"
                  />
                )}

                {mode === 'wall' && (
                  <Select
                    value={wallStyle}
                    onValueChange={(v) => setWallStyle(v as any)}
                  >
                    <SelectTrigger className="w-[120px]">
                      <SelectValue placeholder="Estilo" />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="solid">Continua</SelectItem>
                      <SelectItem value="dashed">Punteada</SelectItem>
                    </SelectContent>
                  </Select>
                )}

                {mode === 'arc' && (
                  <Select
                    value={arcDirection}
                    onValueChange={(v) => setArcDirection(v as any)}
                  >
                    <SelectTrigger className="w-[120px]">
                      <SelectValue placeholder="Dirección" />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="up">Arriba</SelectItem>
                      <SelectItem value="right">Derecha</SelectItem>
                      <SelectItem value="down">Abajo</SelectItem>
                      <SelectItem value="left">Izquierda</SelectItem>
                    </SelectContent>
                  </Select>
                )}

                {(mode === 'text' || mode === 'textListed') && (
                  <>
                    <Select
                      value={textOrientation}
                      onValueChange={(v) => setTextOrientation(v as any)}
                    >
                      <SelectTrigger className="w-[140px]">
                        <SelectValue placeholder="Orientación" />
                      </SelectTrigger>
                      <SelectContent>
                        <SelectItem value="horizontal">Horizontal</SelectItem>
                        <SelectItem value="vertical">Vertical</SelectItem>
                      </SelectContent>
                    </Select>
                    <Input
                      type="number"
                      value={textFontSize}
                      onChange={(e) => setTextFontSize(Number(e.target.value))}
                      className="w-[80px]"
                      placeholder="Tamaño"
                    />
                  </>
                )}

                <div className="flex items-center gap-2">
                  <span>Grid:</span>
                  <Input
                    type="number"
                    value={gridSize}
                    onChange={(e) => setGridSize(Number(e.target.value))}
                    className="w-[60px]"
                  />
                </div>

                <Button variant="outline" onClick={undo}>
                  Deshacer
                </Button>
                <Button variant="outline" onClick={clearCanvas}>
                  Limpiar
                </Button>
                <Button onClick={saveDrawing}>Guardar plano</Button>
              </div>

              <div className="overflow-hidden rounded-lg border bg-white shadow">
                <canvas
                  ref={canvasRef}
                  className="h-[600px] w-full cursor-crosshair"
                  onMouseDown={handleMouseDown}
                  onMouseMove={handleMouseMove}
                  onMouseUp={handleMouseUp}
                />
              </div>
            </CardContent>
          </Card>

          <Card className="col-span-3">
            <CardHeader>
              <CardTitle>Textos listados</CardTitle>
            </CardHeader>
            <CardContent>
              {texts.filter((t) => t.listed).length === 0 ? (
                <p className="text-sm text-gray-400">
                  No hay textos listados aún
                </p>
              ) : (
                texts
                  .filter((t) => t.listed)
                  .map((t) => (
                    <div
                      key={t.id}
                      className="flex items-center gap-2 border-b py-1"
                    >
                      <Input
                        value={t.text}
                        onChange={(e) => updateText(t.id, e.target.value)}
                        className="flex-1 text-sm"
                      />
                      <Button
                        variant="destructive"
                        size="sm"
                        onClick={() => deleteText(t.id)}
                      >
                        ×
                      </Button>
                    </div>
                  ))
              )}
            </CardContent>
          </Card>
        </div>
      </div>
    </AppLayout>
  );
}
