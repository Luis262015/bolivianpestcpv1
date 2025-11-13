import { Button } from '@/components/ui/button';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Input } from '@/components/ui/input';
import {
    Select,
    SelectContent,
    SelectItem,
    SelectTrigger,
    SelectValue,
} from '@/components/ui/select';
// import { Inertia } from '@inertiajs/inertia';
import { JSX, MouseEvent, useEffect, useRef, useState } from 'react';
import { v4 as uuidv4 } from 'uuid';

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

export default function DrawingBoard(): JSX.Element {
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
        setHistory((prev) => [
            ...prev,
            { shapes: [...shapes], texts: [...texts] },
        ]);
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
                if (
                    pos.x >= minX &&
                    pos.x <= maxX &&
                    pos.y >= minY &&
                    pos.y <= maxY
                )
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
        <div className="min-h-screen bg-gray-50 p-6">
            <div className="mx-auto grid max-w-7xl grid-cols-12 gap-6">
                <Card className="col-span-9">
                    <CardHeader>
                        <CardTitle>Editor 2D Avanzado</CardTitle>
                    </CardHeader>
                    <CardContent>
                        <div className="mb-4 flex flex-wrap items-center gap-3">
                            <Select
                                value={mode}
                                onValueChange={(v) => setMode(v as any)}
                            >
                                <SelectTrigger className="w-[180px]">
                                    <SelectValue placeholder="Herramienta" />
                                </SelectTrigger>
                                <SelectContent>
                                    <SelectItem value="wall">Pared</SelectItem>
                                    <SelectItem value="door">Puerta</SelectItem>
                                    <SelectItem value="square">
                                        Cuadro / Zona
                                    </SelectItem>
                                    <SelectItem value="arc">
                                        Arco 45°
                                    </SelectItem>
                                    <SelectItem value="text">
                                        Texto fijo
                                    </SelectItem>
                                    <SelectItem value="textListed">
                                        Texto listado
                                    </SelectItem>
                                </SelectContent>
                            </Select>

                            {(mode === 'door' ||
                                mode === 'square' ||
                                mode === 'arc') && (
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
                                    onValueChange={(v) =>
                                        setWallStyle(v as any)
                                    }
                                >
                                    <SelectTrigger className="w-[120px]">
                                        <SelectValue placeholder="Estilo" />
                                    </SelectTrigger>
                                    <SelectContent>
                                        <SelectItem value="solid">
                                            Continua
                                        </SelectItem>
                                        <SelectItem value="dashed">
                                            Punteada
                                        </SelectItem>
                                    </SelectContent>
                                </Select>
                            )}

                            {mode === 'arc' && (
                                <Select
                                    value={arcDirection}
                                    onValueChange={(v) =>
                                        setArcDirection(v as any)
                                    }
                                >
                                    <SelectTrigger className="w-[120px]">
                                        <SelectValue placeholder="Dirección" />
                                    </SelectTrigger>
                                    <SelectContent>
                                        <SelectItem value="up">
                                            Arriba
                                        </SelectItem>
                                        <SelectItem value="right">
                                            Derecha
                                        </SelectItem>
                                        <SelectItem value="down">
                                            Abajo
                                        </SelectItem>
                                        <SelectItem value="left">
                                            Izquierda
                                        </SelectItem>
                                    </SelectContent>
                                </Select>
                            )}

                            {(mode === 'text' || mode === 'textListed') && (
                                <>
                                    <Select
                                        value={textOrientation}
                                        onValueChange={(v) =>
                                            setTextOrientation(v as any)
                                        }
                                    >
                                        <SelectTrigger className="w-[140px]">
                                            <SelectValue placeholder="Orientación" />
                                        </SelectTrigger>
                                        <SelectContent>
                                            <SelectItem value="horizontal">
                                                Horizontal
                                            </SelectItem>
                                            <SelectItem value="vertical">
                                                Vertical
                                            </SelectItem>
                                        </SelectContent>
                                    </Select>
                                    <Input
                                        type="number"
                                        value={textFontSize}
                                        onChange={(e) =>
                                            setTextFontSize(
                                                Number(e.target.value),
                                            )
                                        }
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
                                    onChange={(e) =>
                                        setGridSize(Number(e.target.value))
                                    }
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
                                            onChange={(e) =>
                                                updateText(t.id, e.target.value)
                                            }
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
    );
}

// ----------------------------------------------------------------------------------------------
// import { Button } from '@/components/ui/button';
// import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
// import { Input } from '@/components/ui/input';
// import {
//     Select,
//     SelectContent,
//     SelectItem,
//     SelectTrigger,
//     SelectValue,
// } from '@/components/ui/select';
// // import { Inertia } from '@inertiajs/inertia';
// import { JSX, MouseEvent, useEffect, useRef, useState } from 'react';
// import { v4 as uuidv4 } from 'uuid';

// type Shape =
//     | {
//           id: string;
//           type: 'wall' | 'door';
//           x1: number;
//           y1: number;
//           x2: number;
//           y2: number;
//           color: string;
//       }
//     | {
//           id: string;
//           type: 'square';
//           x: number;
//           y: number;
//           w: number;
//           h: number;
//           color: string;
//       }
//     | {
//           id: string;
//           type: 'arc';
//           x: number;
//           y: number;
//           r: number;
//           direction: 'up' | 'right' | 'down' | 'left';
//           color: string;
//       };

// type TextItem = {
//     id: string;
//     text: string;
//     x: number;
//     y: number;
//     listed: boolean;
//     vertical: boolean;
// };

// type Dragging = {
//     type: 'text' | 'shape';
//     id: string;
//     offsetX: number;
//     offsetY: number;
// };

// export default function DrawingBoard(): JSX.Element {
//     const canvasRef = useRef<HTMLCanvasElement | null>(null);
//     const ctxRef = useRef<CanvasRenderingContext2D | null>(null);

//     const [mode, setMode] = useState<
//         'wall' | 'door' | 'square' | 'arc' | 'text' | 'textListed'
//     >('wall');
//     const [color, setColor] = useState('#1e40af');
//     const [arcDirection, setArcDirection] = useState<
//         'up' | 'right' | 'down' | 'left'
//     >('up');
//     const [textOrientation, setTextOrientation] = useState<
//         'horizontal' | 'vertical'
//     >('horizontal');
//     const [startPos, setStartPos] = useState<{ x: number; y: number } | null>(
//         null,
//     );
//     const [shapes, setShapes] = useState<Shape[]>([]);
//     const [preview, setPreview] = useState<Shape | null>(null);
//     const [texts, setTexts] = useState<TextItem[]>([]);
//     const [history, setHistory] = useState<
//         { shapes: Shape[]; texts: TextItem[] }[]
//     >([]);
//     const [dragging, setDragging] = useState<Dragging | null>(null);

//     useEffect(() => {
//         const canvas = canvasRef.current;
//         if (!canvas) return;
//         const ctx = canvas.getContext('2d');
//         if (!ctx) return;
//         ctxRef.current = ctx;
//         resizeCanvas();
//         window.addEventListener('resize', resizeCanvas);
//         return () => window.removeEventListener('resize', resizeCanvas);
//     }, []);

//     const resizeCanvas = () => {
//         const canvas = canvasRef.current;
//         if (!canvas || !ctxRef.current) return;
//         const rect = canvas.getBoundingClientRect();
//         canvas.width = rect.width;
//         canvas.height = rect.height;
//         redraw();
//     };

//     const saveHistory = () => {
//         setHistory((prev) => [
//             ...prev,
//             { shapes: [...shapes], texts: [...texts] },
//         ]);
//     };

//     const undo = () => {
//         if (history.length === 0) return;
//         const last = history[history.length - 1];
//         setShapes(last.shapes);
//         setTexts(last.texts);
//         setHistory(history.slice(0, -1));
//     };

//     const drawGrid = (ctx: CanvasRenderingContext2D) => {
//         const { width, height } = ctx.canvas;
//         const gridSize = 25;
//         ctx.beginPath();
//         ctx.strokeStyle = '#e5e7eb';
//         ctx.lineWidth = 1;
//         for (let x = 0; x <= width; x += gridSize) {
//             ctx.moveTo(x, 0);
//             ctx.lineTo(x, height);
//         }
//         for (let y = 0; y <= height; y += gridSize) {
//             ctx.moveTo(0, y);
//             ctx.lineTo(width, y);
//         }
//         ctx.stroke();
//         ctx.closePath();
//     };

//     const redraw = () => {
//         const ctx = ctxRef.current;
//         if (!ctx) return;
//         ctx.clearRect(0, 0, ctx.canvas.width, ctx.canvas.height);
//         drawGrid(ctx);
//         for (const s of shapes) drawShape(ctx, s);
//         if (preview) drawShape(ctx, preview, true);
//         for (const t of texts) drawText(ctx, t);
//     };

//     const drawShape = (
//         ctx: CanvasRenderingContext2D,
//         s: Shape,
//         isPreview = false,
//     ) => {
//         ctx.beginPath();
//         ctx.globalAlpha = isPreview ? 0.5 : 1;
//         switch (s.type) {
//             case 'wall':
//                 ctx.strokeStyle = '#000';
//                 ctx.lineWidth = 5;
//                 ctx.moveTo(s.x1, s.y1);
//                 ctx.lineTo(s.x2, s.y2);
//                 ctx.stroke();
//                 break;
//             case 'door':
//                 ctx.strokeStyle = s.color;
//                 ctx.lineWidth = 6;
//                 ctx.moveTo(s.x1, s.y1);
//                 ctx.lineTo(s.x2, s.y2);
//                 ctx.stroke();
//                 break;
//             case 'square':
//                 ctx.fillStyle = s.color;
//                 ctx.fillRect(s.x, s.y, s.w, s.h);
//                 break;
//             case 'arc':
//                 ctx.strokeStyle = s.color;
//                 ctx.lineWidth = 3;
//                 let startAngle = 0;
//                 switch (s.direction) {
//                     case 'up':
//                         startAngle = Math.PI;
//                         break;
//                     case 'right':
//                         startAngle = -Math.PI / 2;
//                         break;
//                     case 'down':
//                         startAngle = 0;
//                         break;
//                     case 'left':
//                         startAngle = Math.PI / 2;
//                         break;
//                 }
//                 ctx.arc(s.x, s.y, s.r, startAngle, startAngle + Math.PI / 4);
//                 ctx.stroke();
//                 break;
//         }
//         ctx.globalAlpha = 1;
//         ctx.closePath();
//     };

//     const drawText = (ctx: CanvasRenderingContext2D, t: TextItem) => {
//         ctx.fillStyle = t.listed ? '#111827' : '#9ca3af';
//         ctx.font = t.listed ? 'bold 16px sans-serif' : '14px sans-serif';
//         if (t.vertical) {
//             ctx.save();
//             ctx.translate(t.x, t.y);
//             ctx.rotate(-Math.PI / 2);
//             ctx.fillText(t.text, 0, 0);
//             ctx.restore();
//         } else {
//             ctx.fillText(t.text, t.x, t.y);
//         }
//     };

//     const getMousePos = (e: MouseEvent<HTMLCanvasElement>) => {
//         const rect = canvasRef.current?.getBoundingClientRect();
//         return {
//             x: e.clientX - (rect?.left ?? 0),
//             y: e.clientY - (rect?.top ?? 0),
//         };
//     };

//     const findShapeAtPos = (pos: { x: number; y: number }) => {
//         for (let i = shapes.length - 1; i >= 0; i--) {
//             const s = shapes[i];
//             if (s.type === 'door' || s.type === 'wall') {
//                 const minX = Math.min(s.x1, s.x2) - 5;
//                 const maxX = Math.max(s.x1, s.x2) + 5;
//                 const minY = Math.min(s.y1, s.y2) - 5;
//                 const maxY = Math.max(s.y1, s.y2) + 5;
//                 if (
//                     pos.x >= minX &&
//                     pos.x <= maxX &&
//                     pos.y >= minY &&
//                     pos.y <= maxY
//                 )
//                     return s;
//             } else if (s.type === 'square' || s.type === 'arc') {
//                 if (
//                     pos.x >= s.x - 5 &&
//                     pos.x <= s.x + (s.w || s.r) + 5 &&
//                     pos.y >= s.y - 5 &&
//                     pos.y <= s.y + (s.h || s.r) + 5
//                 )
//                     return s;
//             }
//         }
//         return null;
//     };

//     const handleMouseDown = (e: MouseEvent<HTMLCanvasElement>) => {
//         const pos = getMousePos(e);

//         // Drag texto
//         const clickedText = texts.find(
//             (t) => Math.abs(t.x - pos.x) < 50 && Math.abs(t.y - pos.y) < 15,
//         );
//         if (clickedText) {
//             setDragging({
//                 type: 'text',
//                 id: clickedText.id,
//                 offsetX: pos.x - clickedText.x,
//                 offsetY: pos.y - clickedText.y,
//             });
//             return;
//         }

//         // Drag shape
//         const clickedShape = findShapeAtPos(pos);
//         if (clickedShape) {
//             setDragging({
//                 type: 'shape',
//                 id: (clickedShape as any).id,
//                 offsetX: pos.x - (clickedShape as any).x || 0,
//                 offsetY: pos.y - (clickedShape as any).y || 0,
//             });
//             return;
//         }

//         // Texto
//         if (mode === 'text' || mode === 'textListed') {
//             const text = prompt('Ingrese texto:');
//             if (!text) return;
//             saveHistory();
//             setTexts((prev) => [
//                 ...prev,
//                 {
//                     id: uuidv4(),
//                     text,
//                     x: pos.x,
//                     y: pos.y,
//                     listed: mode === 'textListed',
//                     vertical: textOrientation === 'vertical',
//                 },
//             ]);
//             return;
//         }

//         setStartPos(pos);
//     };

//     const handleMouseMove = (e: MouseEvent<HTMLCanvasElement>) => {
//         const pos = getMousePos(e);
//         if (dragging) {
//             if (dragging.type === 'text') {
//                 setTexts((prev) =>
//                     prev.map((t) =>
//                         t.id === dragging.id
//                             ? {
//                                   ...t,
//                                   x: pos.x - dragging.offsetX,
//                                   y: pos.y - dragging.offsetY,
//                               }
//                             : t,
//                     ),
//                 );
//             } else if (dragging.type === 'shape') {
//                 setShapes((prev) =>
//                     prev.map((s) => {
//                         if (s.id !== dragging.id) return s;
//                         if (s.type === 'wall' || s.type === 'door') {
//                             const dx = pos.x - s.x1;
//                             const dy = pos.y - s.y1;
//                             return {
//                                 ...s,
//                                 x1: pos.x,
//                                 y1: pos.y,
//                                 x2: s.x2 + dx,
//                                 y2: s.y2 + dy,
//                             };
//                         } else {
//                             return { ...s, x: pos.x, y: pos.y };
//                         }
//                     }),
//                 );
//             }
//             redraw();
//             return;
//         }

//         if (!startPos) return;
//         let newPreview: Shape;
//         if (mode === 'wall' || mode === 'door') {
//             const dx = pos.x - startPos.x;
//             const dy = pos.y - startPos.y;
//             if (Math.abs(dx) > Math.abs(dy)) {
//                 newPreview = {
//                     id: uuidv4(),
//                     type: mode,
//                     x1: startPos.x,
//                     y1: startPos.y,
//                     x2: pos.x,
//                     y2: startPos.y,
//                     color,
//                 };
//             } else {
//                 newPreview = {
//                     id: uuidv4(),
//                     type: mode,
//                     x1: startPos.x,
//                     y1: startPos.y,
//                     x2: startPos.x,
//                     y2: pos.y,
//                     color,
//                 };
//             }
//         } else if (mode === 'square') {
//             newPreview = {
//                 id: uuidv4(),
//                 type: 'square',
//                 x: startPos.x,
//                 y: startPos.y,
//                 w: pos.x - startPos.x,
//                 h: pos.y - startPos.y,
//                 color,
//             };
//         } else if (mode === 'arc') {
//             const dx = pos.x - startPos.x;
//             const dy = pos.y - startPos.y;
//             const r = Math.sqrt(dx * dx + dy * dy);
//             newPreview = {
//                 id: uuidv4(),
//                 type: 'arc',
//                 x: startPos.x,
//                 y: startPos.y,
//                 r,
//                 direction: arcDirection,
//                 color,
//             };
//         } else return;

//         setPreview(newPreview);
//         redraw();
//     };

//     const handleMouseUp = () => {
//         if (dragging) {
//             saveHistory();
//             setDragging(null);
//             return;
//         }
//         if (preview) {
//             saveHistory();
//             setShapes((prev) => [...prev, preview]);
//             setPreview(null);
//             setStartPos(null);
//         }
//     };

//     useEffect(() => {
//         redraw();
//     }, [shapes, texts, preview]);

//     const clearCanvas = () => {
//         saveHistory();
//         setShapes([]);
//         setTexts([]);
//         setPreview(null);
//     };
//     const saveDrawing = () => {
//         const canvas = canvasRef.current;
//         if (!canvas) return;
//         const dataUrl = canvas.toDataURL('image/png');
//         // Inertia.post('/drawings', { image: dataUrl, texts });
//     };
//     const updateText = (id: string, newText: string) => {
//         setTexts((prev) =>
//             prev.map((t) => (t.id === id ? { ...t, text: newText } : t)),
//         );
//     };
//     const deleteText = (id: string) => {
//         saveHistory();
//         setTexts((prev) => prev.filter((t) => t.id !== id));
//     };

//     return (
//         <div className="min-h-screen bg-gray-50 p-6">
//             <div className="mx-auto grid max-w-7xl grid-cols-12 gap-6">
//                 <Card className="col-span-9">
//                     <CardHeader>
//                         <CardTitle>
//                             Editor 2D — Paredes, puertas, cuadros, arcos, textos
//                             y drag&drop
//                         </CardTitle>
//                     </CardHeader>
//                     <CardContent>
//                         <div className="mb-4 flex flex-wrap items-center gap-3">
//                             <Select
//                                 value={mode}
//                                 onValueChange={(v) => setMode(v as any)}
//                             >
//                                 <SelectTrigger className="w-[180px]">
//                                     <SelectValue placeholder="Herramienta" />
//                                 </SelectTrigger>
//                                 <SelectContent>
//                                     <SelectItem value="wall">Pared</SelectItem>
//                                     <SelectItem value="door">Puerta</SelectItem>
//                                     <SelectItem value="square">
//                                         Cuadro / Zona
//                                     </SelectItem>
//                                     <SelectItem value="arc">
//                                         Arco 45°
//                                     </SelectItem>
//                                     <SelectItem value="text">
//                                         Texto fijo
//                                     </SelectItem>
//                                     <SelectItem value="textListed">
//                                         Texto listado
//                                     </SelectItem>
//                                 </SelectContent>
//                             </Select>

//                             {(mode === 'door' ||
//                                 mode === 'square' ||
//                                 mode === 'arc') && (
//                                 <input
//                                     type="color"
//                                     value={color}
//                                     onChange={(e) => setColor(e.target.value)}
//                                     className="rounded border p-1"
//                                 />
//                             )}

//                             {mode === 'arc' && (
//                                 <Select
//                                     value={arcDirection}
//                                     onValueChange={(v) =>
//                                         setArcDirection(v as any)
//                                     }
//                                 >
//                                     <SelectTrigger className="w-[120px]">
//                                         <SelectValue placeholder="Dirección" />
//                                     </SelectTrigger>
//                                     <SelectContent>
//                                         <SelectItem value="up">
//                                             Arriba
//                                         </SelectItem>
//                                         <SelectItem value="right">
//                                             Derecha
//                                         </SelectItem>
//                                         <SelectItem value="down">
//                                             Abajo
//                                         </SelectItem>
//                                         <SelectItem value="left">
//                                             Izquierda
//                                         </SelectItem>
//                                     </SelectContent>
//                                 </Select>
//                             )}

//                             {(mode === 'text' || mode === 'textListed') && (
//                                 <Select
//                                     value={textOrientation}
//                                     onValueChange={(v) =>
//                                         setTextOrientation(v as any)
//                                     }
//                                 >
//                                     <SelectTrigger className="w-[140px]">
//                                         <SelectValue placeholder="Orientación" />
//                                     </SelectTrigger>
//                                     <SelectContent>
//                                         <SelectItem value="horizontal">
//                                             Horizontal
//                                         </SelectItem>
//                                         <SelectItem value="vertical">
//                                             Vertical
//                                         </SelectItem>
//                                     </SelectContent>
//                                 </Select>
//                             )}

//                             <Button variant="outline" onClick={undo}>
//                                 Deshacer
//                             </Button>
//                             <Button variant="outline" onClick={clearCanvas}>
//                                 Limpiar
//                             </Button>
//                             <Button onClick={saveDrawing}>Guardar plano</Button>
//                         </div>

//                         <div className="overflow-hidden rounded-lg border bg-white shadow">
//                             <canvas
//                                 ref={canvasRef}
//                                 className="h-[600px] w-full cursor-crosshair"
//                                 onMouseDown={handleMouseDown}
//                                 onMouseMove={handleMouseMove}
//                                 onMouseUp={handleMouseUp}
//                             />
//                         </div>
//                     </CardContent>
//                 </Card>

//                 <Card className="col-span-3">
//                     <CardHeader>
//                         <CardTitle>Textos listados</CardTitle>
//                     </CardHeader>
//                     <CardContent>
//                         {texts.filter((t) => t.listed).length === 0 ? (
//                             <p className="text-sm text-gray-400">
//                                 No hay textos listados aún
//                             </p>
//                         ) : (
//                             texts
//                                 .filter((t) => t.listed)
//                                 .map((t) => (
//                                     <div
//                                         key={t.id}
//                                         className="flex items-center gap-2 border-b py-1"
//                                     >
//                                         <Input
//                                             value={t.text}
//                                             onChange={(e) =>
//                                                 updateText(t.id, e.target.value)
//                                             }
//                                             className="flex-1 text-sm"
//                                         />
//                                         <Button
//                                             variant="destructive"
//                                             size="sm"
//                                             onClick={() => deleteText(t.id)}
//                                         >
//                                             ×
//                                         </Button>
//                                     </div>
//                                 ))
//                         )}
//                     </CardContent>
//                 </Card>
//             </div>
//         </div>
//     );
// }

//---------------------------------------------------------------------------------------------
// import { Button } from '@/components/ui/button';
// import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
// import { Input } from '@/components/ui/input';
// import {
//     Select,
//     SelectContent,
//     SelectItem,
//     SelectTrigger,
//     SelectValue,
// } from '@/components/ui/select';
// // import { Inertia } from '@inertiajs/inertia';
// import { JSX, MouseEvent, useEffect, useRef, useState } from 'react';
// import { v4 as uuidv4 } from 'uuid';

// type Shape =
//     | {
//           id: string;
//           type: 'wall' | 'door';
//           x1: number;
//           y1: number;
//           x2: number;
//           y2: number;
//           color: string;
//       }
//     | {
//           id: string;
//           type: 'square';
//           x: number;
//           y: number;
//           w: number;
//           h: number;
//           color: string;
//       };

// type TextItem = {
//     id: string;
//     text: string;
//     x: number;
//     y: number;
//     listed: boolean;
//     vertical: boolean;
// };

// type Dragging = {
//     type: 'text' | 'shape';
//     id: string;
//     offsetX: number;
//     offsetY: number;
// };

// export default function DrawingBoard(): JSX.Element {
//     const canvasRef = useRef<HTMLCanvasElement | null>(null);
//     const ctxRef = useRef<CanvasRenderingContext2D | null>(null);

//     const [mode, setMode] = useState<
//         'wall' | 'door' | 'square' | 'text' | 'textListed'
//     >('wall');
//     const [color, setColor] = useState('#1e40af');
//     const [textOrientation, setTextOrientation] = useState<
//         'horizontal' | 'vertical'
//     >('horizontal');
//     const [startPos, setStartPos] = useState<{ x: number; y: number } | null>(
//         null,
//     );
//     const [shapes, setShapes] = useState<Shape[]>([]);
//     const [preview, setPreview] = useState<Shape | null>(null);
//     const [texts, setTexts] = useState<TextItem[]>([]);
//     const [history, setHistory] = useState<
//         { shapes: Shape[]; texts: TextItem[] }[]
//     >([]);
//     const [dragging, setDragging] = useState<Dragging | null>(null);

//     useEffect(() => {
//         const canvas = canvasRef.current;
//         if (!canvas) return;
//         const ctx = canvas.getContext('2d');
//         if (!ctx) return;
//         ctxRef.current = ctx;
//         resizeCanvas();
//         window.addEventListener('resize', resizeCanvas);
//         return () => window.removeEventListener('resize', resizeCanvas);
//     }, []);

//     const resizeCanvas = () => {
//         const canvas = canvasRef.current;
//         if (!canvas || !ctxRef.current) return;
//         const rect = canvas.getBoundingClientRect();
//         canvas.width = rect.width;
//         canvas.height = rect.height;
//         redraw();
//     };

//     const saveHistory = () => {
//         setHistory((prev) => [
//             ...prev,
//             { shapes: [...shapes], texts: [...texts] },
//         ]);
//     };

//     const undo = () => {
//         if (history.length === 0) return;
//         const last = history[history.length - 1];
//         setShapes(last.shapes);
//         setTexts(last.texts);
//         setHistory(history.slice(0, -1));
//     };

//     const drawGrid = (ctx: CanvasRenderingContext2D) => {
//         const { width, height } = ctx.canvas;
//         const gridSize = 25;
//         ctx.beginPath();
//         ctx.strokeStyle = '#e5e7eb';
//         ctx.lineWidth = 1;
//         for (let x = 0; x <= width; x += gridSize) {
//             ctx.moveTo(x, 0);
//             ctx.lineTo(x, height);
//         }
//         for (let y = 0; y <= height; y += gridSize) {
//             ctx.moveTo(0, y);
//             ctx.lineTo(width, y);
//         }
//         ctx.stroke();
//         ctx.closePath();
//     };

//     const redraw = () => {
//         const ctx = ctxRef.current;
//         if (!ctx) return;
//         ctx.clearRect(0, 0, ctx.canvas.width, ctx.canvas.height);
//         drawGrid(ctx);
//         for (const s of shapes) drawShape(ctx, s);
//         if (preview) drawShape(ctx, preview, true);
//         for (const t of texts) drawText(ctx, t);
//     };

//     const drawShape = (
//         ctx: CanvasRenderingContext2D,
//         s: Shape,
//         isPreview = false,
//     ) => {
//         ctx.beginPath();
//         ctx.globalAlpha = isPreview ? 0.5 : 1;

//         switch (s.type) {
//             case 'wall':
//                 ctx.strokeStyle = '#000';
//                 ctx.lineWidth = 5;
//                 ctx.moveTo(s.x1, s.y1);
//                 ctx.lineTo(s.x2, s.y2);
//                 ctx.stroke();
//                 break;
//             case 'door':
//                 ctx.strokeStyle = s.color;
//                 ctx.lineWidth = 6;
//                 ctx.moveTo(s.x1, s.y1);
//                 ctx.lineTo(s.x2, s.y2);
//                 ctx.stroke();
//                 break;
//             case 'square':
//                 ctx.fillStyle = s.color;
//                 ctx.fillRect(s.x, s.y, 40, 40);
//                 break;
//         }

//         ctx.globalAlpha = 1;
//         ctx.closePath();
//     };

//     const drawText = (ctx: CanvasRenderingContext2D, t: TextItem) => {
//         ctx.fillStyle = t.listed ? '#111827' : '#9ca3af';
//         ctx.font = t.listed ? 'bold 16px sans-serif' : '14px sans-serif';

//         if (t.vertical) {
//             ctx.save();
//             ctx.translate(t.x, t.y);
//             ctx.rotate(-Math.PI / 2);
//             ctx.fillText(t.text, 0, 0);
//             ctx.restore();
//         } else {
//             ctx.fillText(t.text, t.x, t.y);
//         }
//     };

//     const getMousePos = (e: MouseEvent<HTMLCanvasElement>) => {
//         const rect = canvasRef.current?.getBoundingClientRect();
//         return {
//             x: e.clientX - (rect?.left ?? 0),
//             y: e.clientY - (rect?.top ?? 0),
//         };
//     };

//     const findShapeAtPos = (pos: { x: number; y: number }) => {
//         for (let i = shapes.length - 1; i >= 0; i--) {
//             const s = shapes[i];
//             if (s.type === 'door' || s.type === 'wall') {
//                 const minX = Math.min(s.x1, s.x2) - 5;
//                 const maxX = Math.max(s.x1, s.x2) + 5;
//                 const minY = Math.min(s.y1, s.y2) - 5;
//                 const maxY = Math.max(s.y1, s.y2) + 5;
//                 if (
//                     pos.x >= minX &&
//                     pos.x <= maxX &&
//                     pos.y >= minY &&
//                     pos.y <= maxY
//                 )
//                     return s;
//             } else {
//                 if (
//                     pos.x >= s.x &&
//                     pos.x <= s.x + s.w &&
//                     pos.y >= s.y &&
//                     pos.y <= s.y + s.h
//                 )
//                     return s;
//             }
//         }
//         return null;
//     };

//     const handleMouseDown = (e: MouseEvent<HTMLCanvasElement>) => {
//         const pos = getMousePos(e);

//         // Drag texto
//         const clickedText = texts.find(
//             (t) => Math.abs(t.x - pos.x) < 50 && Math.abs(t.y - pos.y) < 15,
//         );
//         if (clickedText) {
//             setDragging({
//                 type: 'text',
//                 id: clickedText.id,
//                 offsetX: pos.x - clickedText.x,
//                 offsetY: pos.y - clickedText.y,
//             });
//             return;
//         }

//         // Drag shape
//         const clickedShape = findShapeAtPos(pos);
//         if (clickedShape) {
//             setDragging({
//                 type: 'shape',
//                 id: (clickedShape as any).id,
//                 offsetX: pos.x - clickedShape.x1 ?? 0,
//                 offsetY: pos.y - clickedShape.y1 ?? 0,
//             });
//             return;
//         }

//         // Crear texto
//         if (mode === 'text' || mode === 'textListed') {
//             const text = prompt('Ingrese texto:');
//             if (!text) return;
//             saveHistory();
//             const newText: TextItem = {
//                 id: uuidv4(),
//                 text,
//                 x: pos.x,
//                 y: pos.y,
//                 listed: mode === 'textListed',
//                 vertical: textOrientation === 'vertical',
//             };
//             setTexts((prev) => [...prev, newText]);
//             return;
//         }

//         // Crear shapes
//         setStartPos(pos);
//     };

//     const handleMouseMove = (e: MouseEvent<HTMLCanvasElement>) => {
//         const pos = getMousePos(e);

//         if (dragging) {
//             if (dragging.type === 'text') {
//                 setTexts((prev) =>
//                     prev.map((t) =>
//                         t.id === dragging.id
//                             ? {
//                                   ...t,
//                                   x: pos.x - dragging.offsetX,
//                                   y: pos.y - dragging.offsetY,
//                               }
//                             : t,
//                     ),
//                 );
//             } else if (dragging.type === 'shape') {
//                 setShapes((prev) =>
//                     prev.map((s) => {
//                         if (s.id !== dragging.id) return s;
//                         if (s.type === 'door' || s.type === 'wall') {
//                             const dx = pos.x - s.x1;
//                             const dy = pos.y - s.y1;
//                             return {
//                                 ...s,
//                                 x1: pos.x,
//                                 y1: pos.y,
//                                 x2: s.x2 + dx,
//                                 y2: s.y2 + dy,
//                             };
//                         } else {
//                             return { ...s, x: pos.x, y: pos.y };
//                         }
//                     }),
//                 );
//             }
//             redraw();
//             return;
//         }

//         if (!startPos) return;
//         let newPreview: Shape;
//         if (mode === 'wall' || mode === 'door') {
//             const dx = pos.x - startPos.x;
//             const dy = pos.y - startPos.y;
//             if (Math.abs(dx) > Math.abs(dy)) {
//                 newPreview = {
//                     id: uuidv4(),
//                     type: mode,
//                     x1: startPos.x,
//                     y1: startPos.y,
//                     x2: pos.x,
//                     y2: startPos.y,
//                     color,
//                 };
//             } else {
//                 newPreview = {
//                     id: uuidv4(),
//                     type: mode,
//                     x1: startPos.x,
//                     y1: startPos.y,
//                     x2: startPos.x,
//                     y2: pos.y,
//                     color,
//                 };
//             }
//         } else if (mode === 'square') {
//             newPreview = {
//                 id: uuidv4(),
//                 type: 'square',
//                 x: startPos.x,
//                 y: startPos.y,
//                 w: 40,
//                 h: 40,
//                 color,
//             };
//         } else return;

//         setPreview(newPreview);
//         redraw();
//     };

//     const handleMouseUp = () => {
//         if (dragging) {
//             saveHistory();
//             setDragging(null);
//             return;
//         }
//         if (preview) {
//             saveHistory();
//             setShapes((prev) => [...prev, preview]);
//             setPreview(null);
//             setStartPos(null);
//         }
//     };

//     useEffect(() => {
//         redraw();
//     }, [shapes, texts, preview]);

//     const clearCanvas = () => {
//         saveHistory();
//         setShapes([]);
//         setTexts([]);
//         setPreview(null);
//     };

//     const saveDrawing = () => {
//         const canvas = canvasRef.current;
//         if (!canvas) return;
//         const dataUrl = canvas.toDataURL('image/png');
//         Inertia.post('/drawings', { image: dataUrl, texts });
//     };

//     const updateText = (id: string, newText: string) => {
//         setTexts((prev) =>
//             prev.map((t) => (t.id === id ? { ...t, text: newText } : t)),
//         );
//     };

//     const deleteText = (id: string) => {
//         saveHistory();
//         setTexts((prev) => prev.filter((t) => t.id !== id));
//     };

//     return (
//         <div className="min-h-screen bg-gray-50 p-6">
//             <div className="mx-auto grid max-w-7xl grid-cols-12 gap-6">
//                 <Card className="col-span-9">
//                     <CardHeader>
//                         <CardTitle>
//                             Editor 2D — Paredes, puertas, cuadros, textos y
//                             drag&drop
//                         </CardTitle>
//                     </CardHeader>
//                     <CardContent>
//                         <div className="mb-4 flex flex-wrap items-center gap-3">
//                             <Select
//                                 value={mode}
//                                 onValueChange={(v) => setMode(v as any)}
//                             >
//                                 <SelectTrigger className="w-[180px]">
//                                     <SelectValue placeholder="Herramienta" />
//                                 </SelectTrigger>
//                                 <SelectContent>
//                                     <SelectItem value="wall">Pared</SelectItem>
//                                     <SelectItem value="door">Puerta</SelectItem>
//                                     <SelectItem value="square">
//                                         Cuadro / Zona
//                                     </SelectItem>
//                                     <SelectItem value="text">
//                                         Texto fijo
//                                     </SelectItem>
//                                     <SelectItem value="textListed">
//                                         Texto listado
//                                     </SelectItem>
//                                 </SelectContent>
//                             </Select>

//                             {(mode === 'door' || mode === 'square') && (
//                                 <input
//                                     type="color"
//                                     value={color}
//                                     onChange={(e) => setColor(e.target.value)}
//                                     className="rounded border p-1"
//                                 />
//                             )}

//                             {(mode === 'text' || mode === 'textListed') && (
//                                 <Select
//                                     value={textOrientation}
//                                     onValueChange={(v) =>
//                                         setTextOrientation(v as any)
//                                     }
//                                 >
//                                     <SelectTrigger className="w-[140px]">
//                                         <SelectValue placeholder="Orientación" />
//                                     </SelectTrigger>
//                                     <SelectContent>
//                                         <SelectItem value="horizontal">
//                                             Horizontal
//                                         </SelectItem>
//                                         <SelectItem value="vertical">
//                                             Vertical
//                                         </SelectItem>
//                                     </SelectContent>
//                                 </Select>
//                             )}

//                             <Button variant="outline" onClick={undo}>
//                                 Deshacer
//                             </Button>
//                             <Button variant="outline" onClick={clearCanvas}>
//                                 Limpiar
//                             </Button>
//                             <Button onClick={saveDrawing}>Guardar plano</Button>
//                         </div>

//                         <div className="overflow-hidden rounded-lg border bg-white shadow">
//                             <canvas
//                                 ref={canvasRef}
//                                 className="h-[600px] w-full cursor-crosshair"
//                                 onMouseDown={handleMouseDown}
//                                 onMouseMove={handleMouseMove}
//                                 onMouseUp={handleMouseUp}
//                             />
//                         </div>
//                     </CardContent>
//                 </Card>

//                 <Card className="col-span-3">
//                     <CardHeader>
//                         <CardTitle>Textos listados</CardTitle>
//                     </CardHeader>
//                     <CardContent>
//                         {texts.filter((t) => t.listed).length === 0 ? (
//                             <p className="text-sm text-gray-400">
//                                 No hay textos listados aún
//                             </p>
//                         ) : (
//                             texts
//                                 .filter((t) => t.listed)
//                                 .map((t) => (
//                                     <div
//                                         key={t.id}
//                                         className="flex items-center gap-2 border-b py-1"
//                                     >
//                                         <Input
//                                             value={t.text}
//                                             onChange={(e) =>
//                                                 updateText(t.id, e.target.value)
//                                             }
//                                             className="flex-1 text-sm"
//                                         />
//                                         <Button
//                                             variant="destructive"
//                                             size="sm"
//                                             onClick={() => deleteText(t.id)}
//                                         >
//                                             ×
//                                         </Button>
//                                     </div>
//                                 ))
//                         )}
//                     </CardContent>
//                 </Card>
//             </div>
//         </div>
//     );
// }

// --------------------------------------------------------------------------------------
// import { Button } from '@/components/ui/button';
// import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
// import { Input } from '@/components/ui/input';
// import {
//     Select,
//     SelectContent,
//     SelectItem,
//     SelectTrigger,
//     SelectValue,
// } from '@/components/ui/select';
// // import { Inertia } from '@inertiajs/inertia';
// import { JSX, MouseEvent, useEffect, useRef, useState } from 'react';
// import { v4 as uuidv4 } from 'uuid';

// type Shape =
//     | {
//           id: string;
//           type: 'door';
//           x1: number;
//           y1: number;
//           x2: number;
//           y2: number;
//           color: string;
//       }
//     | {
//           id: string;
//           type: 'square';
//           x: number;
//           y: number;
//           w: number;
//           h: number;
//           color: string;
//       }
//     | { id: string; type: 'area'; x: number; y: number; w: number; h: number };

// type TextItem = {
//     id: string;
//     text: string;
//     x: number;
//     y: number;
//     listed: boolean;
//     vertical: boolean;
// };

// type Dragging = {
//     type: 'text' | 'shape';
//     id: string;
//     offsetX: number;
//     offsetY: number;
// };

// export default function DrawingBoard(): JSX.Element {
//     const canvasRef = useRef<HTMLCanvasElement | null>(null);
//     const ctxRef = useRef<CanvasRenderingContext2D | null>(null);

//     const [mode, setMode] = useState<
//         'door' | 'square' | 'area' | 'text' | 'textListed'
//     >('door');
//     const [color, setColor] = useState('#1e40af');
//     const [startPos, setStartPos] = useState<{ x: number; y: number } | null>(
//         null,
//     );
//     const [shapes, setShapes] = useState<Shape[]>([]);
//     const [preview, setPreview] = useState<Shape | null>(null);
//     const [texts, setTexts] = useState<TextItem[]>([]);
//     const [history, setHistory] = useState<
//         { shapes: Shape[]; texts: TextItem[] }[]
//     >([]);
//     const [dragging, setDragging] = useState<Dragging | null>(null);

//     useEffect(() => {
//         const canvas = canvasRef.current;
//         if (!canvas) return;
//         const ctx = canvas.getContext('2d');
//         if (!ctx) return;
//         ctxRef.current = ctx;
//         resizeCanvas();
//         window.addEventListener('resize', resizeCanvas);
//         return () => window.removeEventListener('resize', resizeCanvas);
//     }, []);

//     const resizeCanvas = () => {
//         const canvas = canvasRef.current;
//         if (!canvas || !ctxRef.current) return;
//         const rect = canvas.getBoundingClientRect();
//         canvas.width = rect.width;
//         canvas.height = rect.height;
//         redraw();
//     };

//     const saveHistory = () => {
//         setHistory((prev) => [
//             ...prev,
//             { shapes: [...shapes], texts: [...texts] },
//         ]);
//     };

//     const undo = () => {
//         if (history.length === 0) return;
//         const last = history[history.length - 1];
//         setShapes(last.shapes);
//         setTexts(last.texts);
//         setHistory(history.slice(0, -1));
//     };

//     const drawGrid = (ctx: CanvasRenderingContext2D) => {
//         const { width, height } = ctx.canvas;
//         const gridSize = 25;
//         ctx.beginPath();
//         ctx.strokeStyle = '#e5e7eb';
//         ctx.lineWidth = 1;
//         for (let x = 0; x <= width; x += gridSize) {
//             ctx.moveTo(x, 0);
//             ctx.lineTo(x, height);
//         }
//         for (let y = 0; y <= height; y += gridSize) {
//             ctx.moveTo(0, y);
//             ctx.lineTo(width, y);
//         }
//         ctx.stroke();
//         ctx.closePath();
//     };

//     const redraw = () => {
//         const ctx = ctxRef.current;
//         if (!ctx) return;
//         ctx.clearRect(0, 0, ctx.canvas.width, ctx.canvas.height);
//         drawGrid(ctx);
//         for (const s of shapes) drawShape(ctx, s);
//         if (preview) drawShape(ctx, preview, true);
//         for (const t of texts) drawText(ctx, t);
//     };

//     const drawShape = (
//         ctx: CanvasRenderingContext2D,
//         s: Shape,
//         isPreview = false,
//     ) => {
//         ctx.beginPath();
//         ctx.globalAlpha = isPreview ? 0.5 : 1;

//         switch (s.type) {
//             case 'door':
//                 ctx.strokeStyle = s.color;
//                 ctx.lineWidth = 6;
//                 ctx.moveTo(s.x1, s.y1);
//                 ctx.lineTo(s.x2, s.y2);
//                 ctx.stroke();
//                 break;
//             case 'square':
//                 ctx.fillStyle = s.color;
//                 ctx.fillRect(s.x, s.y, 40, 40); // tamaño fijo 40x40
//                 break;
//             case 'area':
//                 ctx.strokeStyle = '#000';
//                 ctx.lineWidth = 2;
//                 ctx.strokeRect(s.x, s.y, s.w, s.h);
//                 break;
//         }

//         ctx.globalAlpha = 1;
//         ctx.closePath();
//     };

//     const drawText = (ctx: CanvasRenderingContext2D, t: TextItem) => {
//         ctx.fillStyle = t.listed ? '#111827' : '#9ca3af';
//         ctx.font = t.listed ? 'bold 16px sans-serif' : '14px sans-serif';

//         if (t.vertical) {
//             ctx.save();
//             ctx.translate(t.x, t.y);
//             ctx.rotate(-Math.PI / 2);
//             ctx.fillText(t.text, 0, 0);
//             ctx.restore();
//         } else {
//             ctx.fillText(t.text, t.x, t.y);
//         }
//     };

//     const getMousePos = (e: MouseEvent<HTMLCanvasElement>) => {
//         const rect = canvasRef.current?.getBoundingClientRect();
//         return {
//             x: e.clientX - (rect?.left ?? 0),
//             y: e.clientY - (rect?.top ?? 0),
//         };
//     };

//     const findShapeAtPos = (pos: { x: number; y: number }) => {
//         for (let i = shapes.length - 1; i >= 0; i--) {
//             const s = shapes[i];
//             if (s.type === 'door') {
//                 const minX = Math.min(s.x1, s.x2) - 5;
//                 const maxX = Math.max(s.x1, s.x2) + 5;
//                 const minY = Math.min(s.y1, s.y2) - 5;
//                 const maxY = Math.max(s.y1, s.y2) + 5;
//                 if (
//                     pos.x >= minX &&
//                     pos.x <= maxX &&
//                     pos.y >= minY &&
//                     pos.y <= maxY
//                 )
//                     return s;
//             } else {
//                 if (
//                     pos.x >= s.x &&
//                     pos.x <= s.x + s.w &&
//                     pos.y >= s.y &&
//                     pos.y <= s.y + s.h
//                 )
//                     return s;
//             }
//         }
//         return null;
//     };

//     const handleMouseDown = (e: MouseEvent<HTMLCanvasElement>) => {
//         const pos = getMousePos(e);

//         // Drag texto listado
//         const clickedText = texts.find(
//             (t) =>
//                 Math.abs(t.x - pos.x) < 50 &&
//                 Math.abs(t.y - pos.y) < 15 &&
//                 t.listed,
//         );
//         if (clickedText) {
//             setDragging({
//                 type: 'text',
//                 id: clickedText.id,
//                 offsetX: pos.x - clickedText.x,
//                 offsetY: pos.y - clickedText.y,
//             });
//             return;
//         }

//         // Drag shape
//         const clickedShape = findShapeAtPos(pos);
//         if (clickedShape) {
//             setDragging({
//                 type: 'shape',
//                 id: (clickedShape as any).id,
//                 offsetX: pos.x - clickedShape.x1 ?? 0,
//                 offsetY: pos.y - clickedShape.y1 ?? 0,
//             });
//             return;
//         }

//         // Crear texto
//         if (mode === 'text' || mode === 'textListed') {
//             const text = prompt('Ingrese texto:');
//             if (!text) return;
//             const vertical = confirm('¿Desea que el texto sea vertical?');
//             saveHistory();
//             const newText: TextItem = {
//                 id: uuidv4(),
//                 text,
//                 x: pos.x,
//                 y: pos.y,
//                 listed: mode === 'textListed',
//                 vertical,
//             };
//             setTexts((prev) => [...prev, newText]);
//             return;
//         }

//         // Crear shapes
//         setStartPos(pos);
//     };

//     const handleMouseMove = (e: MouseEvent<HTMLCanvasElement>) => {
//         const pos = getMousePos(e);

//         // Dragging
//         if (dragging) {
//             if (dragging.type === 'text') {
//                 setTexts((prev) =>
//                     prev.map((t) =>
//                         t.id === dragging.id
//                             ? {
//                                   ...t,
//                                   x: pos.x - dragging.offsetX,
//                                   y: pos.y - dragging.offsetY,
//                               }
//                             : t,
//                     ),
//                 );
//             } else if (dragging.type === 'shape') {
//                 setShapes((prev) =>
//                     prev.map((s) => {
//                         if (s.id !== dragging.id) return s;
//                         if (s.type === 'door') {
//                             const dx = pos.x - s.x1;
//                             const dy = pos.y - s.y1;
//                             return {
//                                 ...s,
//                                 x1: pos.x,
//                                 y1: pos.y,
//                                 x2: s.x2 + dx,
//                                 y2: s.y2 + dy,
//                             };
//                         } else {
//                             const dx = pos.x - s.x;
//                             const dy = pos.y - s.y;
//                             return { ...s, x: pos.x, y: pos.y };
//                         }
//                     }),
//                 );
//             }
//             redraw();
//             return;
//         }

//         // Preview shapes
//         if (!startPos) return;
//         let newPreview: Shape;
//         if (mode === 'door') {
//             const dx = pos.x - startPos.x;
//             const dy = pos.y - startPos.y;
//             if (Math.abs(dx) > Math.abs(dy)) {
//                 newPreview = {
//                     id: uuidv4(),
//                     type: 'door',
//                     x1: startPos.x,
//                     y1: startPos.y,
//                     x2: pos.x,
//                     y2: startPos.y,
//                     color,
//                 };
//             } else {
//                 newPreview = {
//                     id: uuidv4(),
//                     type: 'door',
//                     x1: startPos.x,
//                     y1: startPos.y,
//                     x2: startPos.x,
//                     y2: pos.y,
//                     color,
//                 };
//             }
//         } else if (mode === 'square') {
//             newPreview = {
//                 id: uuidv4(),
//                 type: 'square',
//                 x: startPos.x,
//                 y: startPos.y,
//                 w: 40,
//                 h: 40,
//                 color,
//             };
//         } else if (mode === 'area') {
//             newPreview = {
//                 id: uuidv4(),
//                 type: 'area',
//                 x: startPos.x,
//                 y: startPos.y,
//                 w: pos.x - startPos.x,
//                 h: pos.y - startPos.y,
//             };
//         } else return;

//         setPreview(newPreview);
//         redraw();
//     };

//     const handleMouseUp = () => {
//         if (dragging) {
//             saveHistory();
//             setDragging(null);
//             return;
//         }
//         if (preview) {
//             saveHistory();
//             setShapes((prev) => [...prev, preview]);
//             setPreview(null);
//             setStartPos(null);
//         }
//     };

//     useEffect(() => {
//         redraw();
//     }, [shapes, texts, preview]);

//     const clearCanvas = () => {
//         saveHistory();
//         setShapes([]);
//         setTexts([]);
//         setPreview(null);
//     };

//     const saveDrawing = () => {
//         const canvas = canvasRef.current;
//         if (!canvas) return;
//         const dataUrl = canvas.toDataURL('image/png');
//         Inertia.post('/drawings', { image: dataUrl, texts });
//     };

//     const updateText = (id: string, newText: string) => {
//         setTexts((prev) =>
//             prev.map((t) => (t.id === id ? { ...t, text: newText } : t)),
//         );
//     };

//     const deleteText = (id: string) => {
//         saveHistory();
//         setTexts((prev) => prev.filter((t) => t.id !== id));
//     };

//     return (
//         <div className="min-h-screen bg-gray-50 p-6">
//             <div className="mx-auto grid max-w-7xl grid-cols-12 gap-6">
//                 <Card className="col-span-9">
//                     <CardHeader>
//                         <CardTitle>
//                             Editor 2D — drag & drop, áreas, textos, puertas y
//                             cuadrados
//                         </CardTitle>
//                     </CardHeader>
//                     <CardContent>
//                         <div className="mb-4 flex flex-wrap items-center gap-3">
//                             <Select
//                                 value={mode}
//                                 onValueChange={(v) => setMode(v as any)}
//                             >
//                                 <SelectTrigger className="w-[180px]">
//                                     <SelectValue placeholder="Herramienta" />
//                                 </SelectTrigger>
//                                 <SelectContent>
//                                     <SelectItem value="door">Puerta</SelectItem>
//                                     <SelectItem value="square">
//                                         Cuadro / Zona
//                                     </SelectItem>
//                                     <SelectItem value="area">
//                                         Área libre
//                                     </SelectItem>
//                                     <SelectItem value="text">
//                                         Texto fijo
//                                     </SelectItem>
//                                     <SelectItem value="textListed">
//                                         Texto listado
//                                     </SelectItem>
//                                 </SelectContent>
//                             </Select>

//                             {(mode === 'door' || mode === 'square') && (
//                                 <input
//                                     type="color"
//                                     value={color}
//                                     onChange={(e) => setColor(e.target.value)}
//                                     className="rounded border p-1"
//                                 />
//                             )}

//                             <Button variant="outline" onClick={undo}>
//                                 Deshacer
//                             </Button>
//                             <Button variant="outline" onClick={clearCanvas}>
//                                 Limpiar
//                             </Button>
//                             <Button onClick={saveDrawing}>Guardar plano</Button>
//                         </div>

//                         <div className="overflow-hidden rounded-lg border bg-white shadow">
//                             <canvas
//                                 ref={canvasRef}
//                                 className="h-[600px] w-full cursor-crosshair"
//                                 onMouseDown={handleMouseDown}
//                                 onMouseMove={handleMouseMove}
//                                 onMouseUp={handleMouseUp}
//                             />
//                         </div>
//                     </CardContent>
//                 </Card>

//                 <Card className="col-span-3">
//                     <CardHeader>
//                         <CardTitle>Textos listados</CardTitle>
//                     </CardHeader>
//                     <CardContent>
//                         {texts.filter((t) => t.listed).length === 0 ? (
//                             <p className="text-sm text-gray-400">
//                                 No hay textos listados aún
//                             </p>
//                         ) : (
//                             texts
//                                 .filter((t) => t.listed)
//                                 .map((t) => (
//                                     <div
//                                         key={t.id}
//                                         className="flex items-center gap-2 border-b py-1"
//                                     >
//                                         <Input
//                                             value={t.text}
//                                             onChange={(e) =>
//                                                 updateText(t.id, e.target.value)
//                                             }
//                                             className="flex-1 text-sm"
//                                         />
//                                         <Button
//                                             variant="destructive"
//                                             size="sm"
//                                             onClick={() => deleteText(t.id)}
//                                         >
//                                             ×
//                                         </Button>
//                                     </div>
//                                 ))
//                         )}
//                     </CardContent>
//                 </Card>
//             </div>
//         </div>
//     );
// }

// -------------------------------------------------------------------------------------------
// import { Button } from '@/components/ui/button';
// import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
// import { Input } from '@/components/ui/input';
// import {
//     Select,
//     SelectContent,
//     SelectItem,
//     SelectTrigger,
//     SelectValue,
// } from '@/components/ui/select';
// // import { Inertia } from '@inertiajs/inertia';
// import { JSX, MouseEvent, useEffect, useRef, useState } from 'react';
// import { v4 as uuidv4 } from 'uuid';

// type Shape =
//     | {
//           id: string;
//           type: 'door';
//           x1: number;
//           y1: number;
//           x2: number;
//           y2: number;
//       }
//     | {
//           id: string;
//           type: 'square';
//           x: number;
//           y: number;
//           w: number;
//           h: number;
//           color: string;
//       }
//     | { id: string; type: 'area'; x: number; y: number; w: number; h: number };

// type TextItem = {
//     id: string;
//     text: string;
//     x: number;
//     y: number;
//     listed: boolean;
//     vertical: boolean;
// };

// type Dragging = {
//     type: 'text' | 'shape';
//     id: string;
//     offsetX: number;
//     offsetY: number;
// };

// export default function DrawingBoard(): JSX.Element {
//     const canvasRef = useRef<HTMLCanvasElement | null>(null);
//     const ctxRef = useRef<CanvasRenderingContext2D | null>(null);

//     const [mode, setMode] = useState<
//         'door' | 'square' | 'area' | 'text' | 'textListed'
//     >('door');
//     const [color, setColor] = useState('#1e40af');
//     const [startPos, setStartPos] = useState<{ x: number; y: number } | null>(
//         null,
//     );
//     const [shapes, setShapes] = useState<Shape[]>([]);
//     const [preview, setPreview] = useState<Shape | null>(null);
//     const [texts, setTexts] = useState<TextItem[]>([]);
//     const [history, setHistory] = useState<
//         { shapes: Shape[]; texts: TextItem[] }[]
//     >([]);
//     const [dragging, setDragging] = useState<Dragging | null>(null);

//     useEffect(() => {
//         const canvas = canvasRef.current;
//         if (!canvas) return;
//         const ctx = canvas.getContext('2d');
//         if (!ctx) return;
//         ctxRef.current = ctx;
//         resizeCanvas();
//         window.addEventListener('resize', resizeCanvas);
//         return () => window.removeEventListener('resize', resizeCanvas);
//     }, []);

//     const resizeCanvas = () => {
//         const canvas = canvasRef.current;
//         if (!canvas || !ctxRef.current) return;
//         const rect = canvas.getBoundingClientRect();
//         canvas.width = rect.width;
//         canvas.height = rect.height;
//         redraw();
//     };

//     const saveHistory = () => {
//         setHistory((prev) => [
//             ...prev,
//             { shapes: [...shapes], texts: [...texts] },
//         ]);
//     };

//     const undo = () => {
//         if (history.length === 0) return;
//         const last = history[history.length - 1];
//         setShapes(last.shapes);
//         setTexts(last.texts);
//         setHistory(history.slice(0, -1));
//     };

//     const drawGrid = (ctx: CanvasRenderingContext2D) => {
//         const { width, height } = ctx.canvas;
//         const gridSize = 25;
//         ctx.beginPath();
//         ctx.strokeStyle = '#e5e7eb';
//         ctx.lineWidth = 1;
//         for (let x = 0; x <= width; x += gridSize) {
//             ctx.moveTo(x, 0);
//             ctx.lineTo(x, height);
//         }
//         for (let y = 0; y <= height; y += gridSize) {
//             ctx.moveTo(0, y);
//             ctx.lineTo(width, y);
//         }
//         ctx.stroke();
//         ctx.closePath();
//     };

//     const redraw = () => {
//         const ctx = ctxRef.current;
//         if (!ctx) return;
//         ctx.clearRect(0, 0, ctx.canvas.width, ctx.canvas.height);
//         drawGrid(ctx);
//         for (const s of shapes) drawShape(ctx, s);
//         if (preview) drawShape(ctx, preview, true);
//         for (const t of texts) drawText(ctx, t);
//     };

//     const drawShape = (
//         ctx: CanvasRenderingContext2D,
//         s: Shape,
//         isPreview = false,
//     ) => {
//         ctx.beginPath();
//         ctx.globalAlpha = isPreview ? 0.5 : 1;

//         switch (s.type) {
//             case 'door':
//                 ctx.strokeStyle = '#16a34a';
//                 ctx.lineWidth = 6;
//                 ctx.moveTo(s.x1, s.y1);
//                 ctx.lineTo(s.x2, s.y2);
//                 ctx.stroke();
//                 break;
//             case 'square':
//                 ctx.fillStyle = s.color;
//                 ctx.fillRect(s.x, s.y, 80, 80);
//                 ctx.strokeStyle = '#374151';
//                 ctx.strokeRect(s.x, s.y, 80, 80);
//                 break;
//             case 'area':
//                 ctx.strokeStyle = '#000';
//                 ctx.lineWidth = 2;
//                 ctx.strokeRect(s.x, s.y, s.w, s.h);
//                 break;
//         }

//         ctx.globalAlpha = 1;
//         ctx.closePath();
//     };

//     const drawText = (ctx: CanvasRenderingContext2D, t: TextItem) => {
//         ctx.fillStyle = t.listed ? '#111827' : '#9ca3af';
//         ctx.font = t.listed ? 'bold 16px sans-serif' : '14px sans-serif';

//         if (t.vertical) {
//             ctx.save();
//             ctx.translate(t.x, t.y);
//             ctx.rotate(-Math.PI / 2);
//             ctx.fillText(t.text, 0, 0);
//             ctx.restore();
//         } else {
//             ctx.fillText(t.text, t.x, t.y);
//         }
//     };

//     const getMousePos = (e: MouseEvent<HTMLCanvasElement>) => {
//         const rect = canvasRef.current?.getBoundingClientRect();
//         return {
//             x: e.clientX - (rect?.left ?? 0),
//             y: e.clientY - (rect?.top ?? 0),
//         };
//     };

//     const findShapeAtPos = (pos: { x: number; y: number }) => {
//         // Buscar el último shape que contenga el mouse
//         for (let i = shapes.length - 1; i >= 0; i--) {
//             const s = shapes[i];
//             if (s.type === 'door') {
//                 const minX = Math.min(s.x1, s.x2);
//                 const maxX = Math.max(s.x1, s.x2);
//                 const minY = Math.min(s.y1, s.y2);
//                 const maxY = Math.max(s.y1, s.y2);
//                 if (
//                     pos.x >= minX - 5 &&
//                     pos.x <= maxX + 5 &&
//                     pos.y >= minY - 5 &&
//                     pos.y <= maxY + 5
//                 ) {
//                     return s;
//                 }
//             } else {
//                 if (
//                     pos.x >= s.x &&
//                     pos.x <= s.x + s.w &&
//                     pos.y >= s.y &&
//                     pos.y <= s.y + s.h
//                 ) {
//                     return s;
//                 }
//             }
//         }
//         return null;
//     };

//     const handleMouseDown = (e: MouseEvent<HTMLCanvasElement>) => {
//         const pos = getMousePos(e);

//         // Drag texto listado
//         const clickedText = texts.find(
//             (t) =>
//                 Math.abs(t.x - pos.x) < 50 &&
//                 Math.abs(t.y - pos.y) < 15 &&
//                 t.listed,
//         );
//         if (clickedText) {
//             setDragging({
//                 type: 'text',
//                 id: clickedText.id,
//                 offsetX: pos.x - clickedText.x,
//                 offsetY: pos.y - clickedText.y,
//             });
//             return;
//         }

//         // Drag shape
//         const clickedShape = findShapeAtPos(pos);
//         if (clickedShape) {
//             setDragging({
//                 type: 'shape',
//                 id: (clickedShape as any).id,
//                 offsetX: 0,
//                 offsetY: 0,
//             });
//             return;
//         }

//         // Crear texto
//         if (mode === 'text' || mode === 'textListed') {
//             const text = prompt('Ingrese texto:');
//             if (!text) return;
//             const vertical = confirm('¿Desea que el texto sea vertical?');
//             saveHistory();
//             const newText: TextItem = {
//                 id: uuidv4(),
//                 text,
//                 x: pos.x,
//                 y: pos.y,
//                 listed: mode === 'textListed',
//                 vertical,
//             };
//             setTexts((prev) => [...prev, newText]);
//             return;
//         }

//         // Crear shapes
//         setStartPos(pos);
//     };

//     const handleMouseMove = (e: MouseEvent<HTMLCanvasElement>) => {
//         const pos = getMousePos(e);

//         // Dragging
//         if (dragging) {
//             if (dragging.type === 'text') {
//                 setTexts((prev) =>
//                     prev.map((t) =>
//                         t.id === dragging.id
//                             ? {
//                                   ...t,
//                                   x: pos.x - dragging.offsetX,
//                                   y: pos.y - dragging.offsetY,
//                               }
//                             : t,
//                     ),
//                 );
//             } else if (dragging.type === 'shape') {
//                 setShapes((prev) =>
//                     prev.map((s) => {
//                         if (s.id !== dragging.id) return s;
//                         if (s.type === 'door') {
//                             const dx = pos.x - s.x1;
//                             const dy = pos.y - s.y1;
//                             return {
//                                 ...s,
//                                 x1: pos.x,
//                                 y1: pos.y,
//                                 x2: s.x2 + dx,
//                                 y2: s.y2 + dy,
//                             };
//                         } else {
//                             const dx = pos.x - s.x;
//                             const dy = pos.y - s.y;
//                             return { ...s, x: pos.x, y: pos.y };
//                         }
//                     }),
//                 );
//             }
//             redraw();
//             return;
//         }

//         // Preview para dibujar
//         if (!startPos) return;
//         let newPreview: Shape;
//         if (mode === 'door') {
//             const dx = pos.x - startPos.x;
//             const dy = pos.y - startPos.y;
//             if (Math.abs(dx) > Math.abs(dy)) {
//                 newPreview = {
//                     id: uuidv4(),
//                     type: 'door',
//                     x1: startPos.x,
//                     y1: startPos.y,
//                     x2: pos.x,
//                     y2: startPos.y,
//                 };
//             } else {
//                 newPreview = {
//                     id: uuidv4(),
//                     type: 'door',
//                     x1: startPos.x,
//                     y1: startPos.y,
//                     x2: startPos.x,
//                     y2: pos.y,
//                 };
//             }
//         } else if (mode === 'square') {
//             newPreview = {
//                 id: uuidv4(),
//                 type: 'square',
//                 x: startPos.x,
//                 y: startPos.y,
//                 w: 80,
//                 h: 80,
//                 color,
//             };
//         } else if (mode === 'area') {
//             newPreview = {
//                 id: uuidv4(),
//                 type: 'area',
//                 x: startPos.x,
//                 y: startPos.y,
//                 w: pos.x - startPos.x,
//                 h: pos.y - startPos.y,
//             };
//         } else return;

//         setPreview(newPreview);
//         redraw();
//     };

//     const handleMouseUp = () => {
//         if (dragging) {
//             saveHistory();
//             setDragging(null);
//             return;
//         }
//         if (preview) {
//             saveHistory();
//             setShapes((prev) => [...prev, preview]);
//             setPreview(null);
//             setStartPos(null);
//         }
//     };

//     useEffect(() => {
//         redraw();
//     }, [shapes, texts, preview]);

//     const clearCanvas = () => {
//         saveHistory();
//         setShapes([]);
//         setTexts([]);
//         setPreview(null);
//     };

//     const saveDrawing = () => {
//         const canvas = canvasRef.current;
//         if (!canvas) return;
//         const dataUrl = canvas.toDataURL('image/png');
//         Inertia.post('/drawings', { image: dataUrl, texts });
//     };

//     const updateText = (id: string, newText: string) => {
//         setTexts((prev) =>
//             prev.map((t) => (t.id === id ? { ...t, text: newText } : t)),
//         );
//     };

//     const deleteText = (id: string) => {
//         saveHistory();
//         setTexts((prev) => prev.filter((t) => t.id !== id));
//     };

//     return (
//         <div className="min-h-screen bg-gray-50 p-6">
//             <div className="mx-auto grid max-w-7xl grid-cols-12 gap-6">
//                 <Card className="col-span-9">
//                     <CardHeader>
//                         <CardTitle>
//                             Editor 2D — drag & drop, áreas, textos y puertas
//                         </CardTitle>
//                     </CardHeader>
//                     <CardContent>
//                         <div className="mb-4 flex flex-wrap items-center gap-3">
//                             <Select
//                                 value={mode}
//                                 onValueChange={(v) => setMode(v as any)}
//                             >
//                                 <SelectTrigger className="w-[180px]">
//                                     <SelectValue placeholder="Herramienta" />
//                                 </SelectTrigger>
//                                 <SelectContent>
//                                     <SelectItem value="door">Puerta</SelectItem>
//                                     <SelectItem value="square">
//                                         Cuadro / Zona
//                                     </SelectItem>
//                                     <SelectItem value="area">
//                                         Área libre
//                                     </SelectItem>
//                                     <SelectItem value="text">
//                                         Texto fijo
//                                     </SelectItem>
//                                     <SelectItem value="textListed">
//                                         Texto listado
//                                     </SelectItem>
//                                 </SelectContent>
//                             </Select>

//                             {(mode === 'square' || mode === 'area') && (
//                                 <input
//                                     type="color"
//                                     value={color}
//                                     onChange={(e) => setColor(e.target.value)}
//                                     className="rounded border p-1"
//                                 />
//                             )}

//                             <Button variant="outline" onClick={undo}>
//                                 Deshacer
//                             </Button>
//                             <Button variant="outline" onClick={clearCanvas}>
//                                 Limpiar
//                             </Button>
//                             <Button onClick={saveDrawing}>Guardar plano</Button>
//                         </div>

//                         <div className="overflow-hidden rounded-lg border bg-white shadow">
//                             <canvas
//                                 ref={canvasRef}
//                                 className="h-[600px] w-full cursor-crosshair"
//                                 onMouseDown={handleMouseDown}
//                                 onMouseMove={handleMouseMove}
//                                 onMouseUp={handleMouseUp}
//                             />
//                         </div>
//                     </CardContent>
//                 </Card>

//                 <Card className="col-span-3">
//                     <CardHeader>
//                         <CardTitle>Textos listados</CardTitle>
//                     </CardHeader>
//                     <CardContent>
//                         {texts.filter((t) => t.listed).length === 0 ? (
//                             <p className="text-sm text-gray-400">
//                                 No hay textos listados aún
//                             </p>
//                         ) : (
//                             texts
//                                 .filter((t) => t.listed)
//                                 .map((t) => (
//                                     <div
//                                         key={t.id}
//                                         className="flex items-center gap-2 border-b py-1"
//                                     >
//                                         <Input
//                                             value={t.text}
//                                             onChange={(e) =>
//                                                 updateText(t.id, e.target.value)
//                                             }
//                                             className="flex-1 text-sm"
//                                         />
//                                         <Button
//                                             variant="destructive"
//                                             size="sm"
//                                             onClick={() => deleteText(t.id)}
//                                         >
//                                             ×
//                                         </Button>
//                                     </div>
//                                 ))
//                         )}
//                     </CardContent>
//                 </Card>
//             </div>
//         </div>
//     );
// }

// ------------------------------------------------------------------------------------------
// import { Button } from '@/components/ui/button';
// import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
// import { Input } from '@/components/ui/input';
// import {
//     Select,
//     SelectContent,
//     SelectItem,
//     SelectTrigger,
//     SelectValue,
// } from '@/components/ui/select';
// // import { Inertia } from '@inertiajs/inertia';
// import { JSX, MouseEvent, useEffect, useRef, useState } from 'react';
// import { v4 as uuidv4 } from 'uuid';

// type Shape =
//     | { type: 'door'; x1: number; y1: number; x2: number; y2: number }
//     | {
//           type: 'square';
//           x: number;
//           y: number;
//           w: number;
//           h: number;
//           color: string;
//       }
//     | {
//           type: 'area';
//           x: number;
//           y: number;
//           w: number;
//           h: number;
//           color: string;
//       };

// type TextItem = {
//     id: string;
//     text: string;
//     x: number;
//     y: number;
//     listed: boolean;
//     vertical: boolean;
// };

// export default function DrawingBoard(): JSX.Element {
//     const canvasRef = useRef<HTMLCanvasElement | null>(null);
//     const ctxRef = useRef<CanvasRenderingContext2D | null>(null);

//     const [mode, setMode] = useState<
//         'door' | 'square' | 'area' | 'text' | 'textListed'
//     >('door');
//     const [color, setColor] = useState('#1e40af');
//     const [startPos, setStartPos] = useState<{ x: number; y: number } | null>(
//         null,
//     );
//     const [shapes, setShapes] = useState<Shape[]>([]);
//     const [preview, setPreview] = useState<Shape | null>(null);
//     const [texts, setTexts] = useState<TextItem[]>([]);
//     const [draggingTextId, setDraggingTextId] = useState<string | null>(null);
//     const [lastPos, setLastPos] = useState<{ x: number; y: number } | null>(
//         null,
//     );
//     const [history, setHistory] = useState<
//         { shapes: Shape[]; texts: TextItem[] }[]
//     >([]);

//     useEffect(() => {
//         const canvas = canvasRef.current;
//         if (!canvas) return;
//         const ctx = canvas.getContext('2d');
//         if (!ctx) return;
//         ctxRef.current = ctx;
//         resizeCanvas();
//         window.addEventListener('resize', resizeCanvas);
//         return () => window.removeEventListener('resize', resizeCanvas);
//     }, []);

//     const resizeCanvas = () => {
//         const canvas = canvasRef.current;
//         if (!canvas || !ctxRef.current) return;
//         const rect = canvas.getBoundingClientRect();
//         canvas.width = rect.width;
//         canvas.height = rect.height;
//         redraw();
//     };

//     const saveHistory = () => {
//         setHistory((prev) => [
//             ...prev,
//             { shapes: [...shapes], texts: [...texts] },
//         ]);
//     };

//     const undo = () => {
//         if (history.length === 0) return;
//         const last = history[history.length - 1];
//         setShapes(last.shapes);
//         setTexts(last.texts);
//         setHistory(history.slice(0, -1));
//     };

//     const drawGrid = (ctx: CanvasRenderingContext2D) => {
//         const { width, height } = ctx.canvas;
//         const gridSize = 25;
//         ctx.beginPath();
//         ctx.strokeStyle = '#e5e7eb';
//         ctx.lineWidth = 1;
//         for (let x = 0; x <= width; x += gridSize) {
//             ctx.moveTo(x, 0);
//             ctx.lineTo(x, height);
//         }
//         for (let y = 0; y <= height; y += gridSize) {
//             ctx.moveTo(0, y);
//             ctx.lineTo(width, y);
//         }
//         ctx.stroke();
//         ctx.closePath();
//     };

//     const redraw = () => {
//         const ctx = ctxRef.current;
//         if (!ctx) return;
//         ctx.clearRect(0, 0, ctx.canvas.width, ctx.canvas.height);
//         drawGrid(ctx);
//         for (const s of shapes) drawShape(ctx, s);
//         if (preview) drawShape(ctx, preview, true);
//         for (const t of texts) drawText(ctx, t);
//     };

//     const drawShape = (
//         ctx: CanvasRenderingContext2D,
//         s: Shape,
//         isPreview = false,
//     ) => {
//         ctx.beginPath();
//         ctx.globalAlpha = isPreview ? 0.5 : 1;

//         switch (s.type) {
//             case 'door':
//                 ctx.strokeStyle = '#16a34a';
//                 ctx.lineWidth = 6;
//                 ctx.moveTo(s.x1, s.y1);
//                 ctx.lineTo(s.x2, s.y2);
//                 ctx.stroke();
//                 break;
//             case 'square':
//                 ctx.fillStyle = s.color;
//                 ctx.fillRect(s.x, s.y, 80, 80);
//                 ctx.strokeStyle = '#374151';
//                 ctx.strokeRect(s.x, s.y, 80, 80);
//                 break;
//             case 'area':
//                 ctx.fillStyle = s.color;
//                 ctx.fillRect(s.x, s.y, s.w, s.h);
//                 ctx.strokeStyle = '#1f2937';
//                 ctx.strokeRect(s.x, s.y, s.w, s.h);
//                 break;
//         }

//         ctx.globalAlpha = 1;
//         ctx.closePath();
//     };

//     const drawText = (ctx: CanvasRenderingContext2D, t: TextItem) => {
//         ctx.fillStyle = t.listed ? '#111827' : '#9ca3af';
//         ctx.font = t.listed ? 'bold 16px sans-serif' : '14px sans-serif';

//         if (t.vertical) {
//             ctx.save();
//             ctx.translate(t.x, t.y);
//             ctx.rotate(-Math.PI / 2);
//             ctx.fillText(t.text, 0, 0);
//             ctx.restore();
//         } else {
//             ctx.fillText(t.text, t.x, t.y);
//         }
//     };

//     const getMousePos = (
//         e: MouseEvent<HTMLCanvasElement>,
//     ): { x: number; y: number } => {
//         const rect = canvasRef.current?.getBoundingClientRect();
//         return {
//             x: e.clientX - (rect?.left ?? 0),
//             y: e.clientY - (rect?.top ?? 0),
//         };
//     };

//     const handleMouseDown = (e: MouseEvent<HTMLCanvasElement>) => {
//         const pos = getMousePos(e);

//         // Detectar si se hace click sobre un texto listado
//         const clickedText = texts.find(
//             (t) =>
//                 Math.abs(t.x - pos.x) < 50 &&
//                 Math.abs(t.y - pos.y) < 15 &&
//                 t.listed,
//         );
//         if (clickedText) {
//             setDraggingTextId(clickedText.id);
//             setLastPos(pos);
//             return;
//         }

//         if (mode === 'text' || mode === 'textListed') {
//             const text = prompt('Ingrese texto:');
//             if (!text) return;
//             const vertical = confirm('¿Desea que el texto sea vertical?');
//             saveHistory();
//             const newText: TextItem = {
//                 id: uuidv4(),
//                 text,
//                 x: pos.x,
//                 y: pos.y,
//                 listed: mode === 'textListed',
//                 vertical,
//             };
//             setTexts((prev) => [...prev, newText]);
//             return;
//         }

//         setStartPos(pos);
//     };

//     const handleMouseMove = (e: MouseEvent<HTMLCanvasElement>) => {
//         const current = getMousePos(e);

//         if (draggingTextId && lastPos) {
//             const dx = current.x - lastPos.x;
//             const dy = current.y - lastPos.y;
//             setTexts((prev) =>
//                 prev.map((t) =>
//                     t.id === draggingTextId
//                         ? { ...t, x: t.x + dx, y: t.y + dy }
//                         : t,
//                 ),
//             );
//             setLastPos(current);
//             return;
//         }

//         if (!startPos) return;
//         let newPreview: Shape;

//         if (mode === 'door') {
//             const dx = current.x - startPos.x;
//             const dy = current.y - startPos.y;
//             if (Math.abs(dx) > Math.abs(dy)) {
//                 newPreview = {
//                     type: 'door',
//                     x1: startPos.x,
//                     y1: startPos.y,
//                     x2: current.x,
//                     y2: startPos.y,
//                 };
//             } else {
//                 newPreview = {
//                     type: 'door',
//                     x1: startPos.x,
//                     y1: startPos.y,
//                     x2: startPos.x,
//                     y2: current.y,
//                 };
//             }
//         } else if (mode === 'square') {
//             newPreview = {
//                 type: 'square',
//                 x: startPos.x,
//                 y: startPos.y,
//                 w: 80,
//                 h: 80,
//                 color,
//             };
//         } else if (mode === 'area') {
//             newPreview = {
//                 type: 'area',
//                 x: startPos.x,
//                 y: startPos.y,
//                 w: current.x - startPos.x,
//                 h: current.y - startPos.y,
//                 color,
//             };
//         } else return;

//         setPreview(newPreview);
//         redraw();
//     };

//     const handleMouseUp = () => {
//         if (draggingTextId) {
//             saveHistory();
//             setDraggingTextId(null);
//             setLastPos(null);
//             return;
//         }

//         if (!startPos || !preview) return;
//         saveHistory();
//         setShapes((prev) => [...prev, preview]);
//         setStartPos(null);
//         setPreview(null);
//     };

//     useEffect(() => {
//         redraw();
//     }, [shapes, preview, texts]);

//     const clearCanvas = () => {
//         saveHistory();
//         setShapes([]);
//         setTexts([]);
//         setPreview(null);
//     };

//     const saveDrawing = () => {
//         const canvas = canvasRef.current;
//         if (!canvas) return;
//         const dataUrl = canvas.toDataURL('image/png');
//         // Inertia.post('/drawings', { image: dataUrl, texts });
//     };

//     const updateText = (id: string, newText: string) => {
//         setTexts((prev) =>
//             prev.map((t) => (t.id === id ? { ...t, text: newText } : t)),
//         );
//     };

//     const deleteText = (id: string) => {
//         saveHistory();
//         setTexts((prev) => prev.filter((t) => t.id !== id));
//     };

//     return (
//         <div className="min-h-screen bg-gray-50 p-6">
//             <div className="mx-auto grid max-w-7xl grid-cols-12 gap-6">
//                 <Card className="col-span-9">
//                     <CardHeader>
//                         <CardTitle>
//                             Editor 2D — áreas, textos, puertas y cuadrícula
//                         </CardTitle>
//                     </CardHeader>
//                     <CardContent>
//                         <div className="mb-4 flex flex-wrap items-center gap-3">
//                             <Select
//                                 value={mode}
//                                 onValueChange={(
//                                     v:
//                                         | 'door'
//                                         | 'square'
//                                         | 'area'
//                                         | 'text'
//                                         | 'textListed',
//                                 ) => setMode(v)}
//                             >
//                                 <SelectTrigger className="w-[180px]">
//                                     <SelectValue placeholder="Herramienta" />
//                                 </SelectTrigger>
//                                 <SelectContent>
//                                     <SelectItem value="door">Puerta</SelectItem>
//                                     <SelectItem value="square">
//                                         Cuadro / Zona
//                                     </SelectItem>
//                                     <SelectItem value="area">
//                                         Área libre
//                                     </SelectItem>
//                                     <SelectItem value="text">
//                                         Texto fijo
//                                     </SelectItem>
//                                     <SelectItem value="textListed">
//                                         Texto listado
//                                     </SelectItem>
//                                 </SelectContent>
//                             </Select>

//                             {(mode === 'square' || mode === 'area') && (
//                                 <input
//                                     type="color"
//                                     value={color}
//                                     onChange={(e) => setColor(e.target.value)}
//                                     className="rounded border p-1"
//                                 />
//                             )}

//                             <Button variant="outline" onClick={undo}>
//                                 Deshacer
//                             </Button>
//                             <Button variant="outline" onClick={clearCanvas}>
//                                 Limpiar
//                             </Button>
//                             <Button onClick={saveDrawing}>Guardar plano</Button>
//                         </div>

//                         <div className="overflow-hidden rounded-lg border bg-white shadow">
//                             <canvas
//                                 ref={canvasRef}
//                                 className="h-[600px] w-full cursor-crosshair"
//                                 onMouseDown={handleMouseDown}
//                                 onMouseMove={handleMouseMove}
//                                 onMouseUp={handleMouseUp}
//                             />
//                         </div>
//                     </CardContent>
//                 </Card>

//                 {/* Lista de textos */}
//                 <Card className="col-span-3">
//                     <CardHeader>
//                         <CardTitle>Textos listados</CardTitle>
//                     </CardHeader>
//                     <CardContent>
//                         {texts.filter((t) => t.listed).length === 0 ? (
//                             <p className="text-sm text-gray-400">
//                                 No hay textos listados aún
//                             </p>
//                         ) : (
//                             texts
//                                 .filter((t) => t.listed)
//                                 .map((t) => (
//                                     <div
//                                         key={t.id}
//                                         className="flex items-center gap-2 border-b py-1"
//                                     >
//                                         <Input
//                                             value={t.text}
//                                             onChange={(e) =>
//                                                 updateText(t.id, e.target.value)
//                                             }
//                                             className="flex-1 text-sm"
//                                         />
//                                         <Button
//                                             variant="destructive"
//                                             size="sm"
//                                             onClick={() => deleteText(t.id)}
//                                         >
//                                             ×
//                                         </Button>
//                                     </div>
//                                 ))
//                         )}
//                     </CardContent>
//                 </Card>
//             </div>
//         </div>
//     );
// }

// ---------------------------------------------------------------------------------------------
// import { Button } from '@/components/ui/button';
// import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
// import { Input } from '@/components/ui/input';
// import {
//     Select,
//     SelectContent,
//     SelectItem,
//     SelectTrigger,
//     SelectValue,
// } from '@/components/ui/select';
// // import { Inertia } from '@inertiajs/inertia';
// import { JSX, MouseEvent, useEffect, useRef, useState } from 'react';
// import { v4 as uuidv4 } from 'uuid';

// type Shape =
//     | { type: 'door'; x1: number; y1: number; x2: number; y2: number }
//     | {
//           type: 'square';
//           x: number;
//           y: number;
//           w: number;
//           h: number;
//           color: string;
//       };

// type TextItem = {
//     id: string;
//     text: string;
//     x: number;
//     y: number;
//     listed: boolean;
//     vertical?: boolean;
// };

// export default function DrawingBoard(): JSX.Element {
//     const canvasRef = useRef<HTMLCanvasElement | null>(null);
//     const ctxRef = useRef<CanvasRenderingContext2D | null>(null);

//     const [mode, setMode] = useState<'door' | 'square' | 'text' | 'textListed'>(
//         'door',
//     );
//     const [color, setColor] = useState('#1e40af');
//     const [startPos, setStartPos] = useState<{ x: number; y: number } | null>(
//         null,
//     );
//     const [shapes, setShapes] = useState<Shape[]>([]);
//     const [preview, setPreview] = useState<Shape | null>(null);
//     const [texts, setTexts] = useState<TextItem[]>([]);
//     const [draggingTextId, setDraggingTextId] = useState<string | null>(null);
//     const [lastPos, setLastPos] = useState<{ x: number; y: number } | null>(
//         null,
//     );
//     const [history, setHistory] = useState<
//         { shapes: Shape[]; texts: TextItem[] }[]
//     >([]);

//     useEffect(() => {
//         const canvas = canvasRef.current;
//         if (!canvas) return;
//         const ctx = canvas.getContext('2d');
//         if (!ctx) return;
//         ctxRef.current = ctx;
//         resizeCanvas();
//         window.addEventListener('resize', resizeCanvas);
//         return () => window.removeEventListener('resize', resizeCanvas);
//     }, []);

//     const resizeCanvas = () => {
//         const canvas = canvasRef.current;
//         if (!canvas || !ctxRef.current) return;
//         const rect = canvas.getBoundingClientRect();
//         canvas.width = rect.width;
//         canvas.height = rect.height;
//         redraw();
//     };

//     const saveHistory = () => {
//         setHistory((prev) => [
//             ...prev,
//             { shapes: [...shapes], texts: [...texts] },
//         ]);
//     };

//     const undo = () => {
//         if (history.length === 0) return;
//         const last = history[history.length - 1];
//         setShapes(last.shapes);
//         setTexts(last.texts);
//         setHistory(history.slice(0, -1));
//     };

//     const redraw = () => {
//         const ctx = ctxRef.current;
//         if (!ctx) return;
//         ctx.clearRect(0, 0, ctx.canvas.width, ctx.canvas.height);
//         for (const s of shapes) drawShape(ctx, s);
//         if (preview) drawShape(ctx, preview, true);
//         for (const t of texts) drawText(ctx, t);
//     };

//     const drawShape = (
//         ctx: CanvasRenderingContext2D,
//         s: Shape,
//         isPreview = false,
//     ) => {
//         ctx.beginPath();
//         ctx.globalAlpha = isPreview ? 0.5 : 1;

//         switch (s.type) {
//             case 'door':
//                 ctx.strokeStyle = '#16a34a';
//                 ctx.lineWidth = 6;
//                 ctx.moveTo(s.x1, s.y1);
//                 ctx.lineTo(s.x2, s.y2);
//                 ctx.stroke();
//                 break;
//             case 'square':
//                 ctx.fillStyle = s.color;
//                 ctx.fillRect(s.x, s.y, s.w, s.h);
//                 ctx.strokeStyle = '#374151';
//                 ctx.lineWidth = 1.5;
//                 ctx.strokeRect(s.x, s.y, s.w, s.h);
//                 break;
//         }

//         ctx.globalAlpha = 1;
//         ctx.closePath();
//     };

//     const drawText = (ctx: CanvasRenderingContext2D, t: TextItem) => {
//         ctx.fillStyle = t.listed ? '#111827' : '#9ca3af';
//         ctx.font = t.listed ? 'bold 16px sans-serif' : '14px sans-serif';
//         if (t.vertical) {
//             ctx.save();
//             ctx.translate(t.x, t.y);
//             ctx.rotate(-Math.PI / 2);
//             ctx.fillText(t.text, 0, 0);
//             ctx.restore();
//         } else {
//             ctx.fillText(t.text, t.x, t.y);
//         }
//     };

//     const getMousePos = (
//         e: MouseEvent<HTMLCanvasElement>,
//     ): { x: number; y: number } => {
//         const rect = canvasRef.current?.getBoundingClientRect();
//         return {
//             x: e.clientX - (rect?.left ?? 0),
//             y: e.clientY - (rect?.top ?? 0),
//         };
//     };

//     const handleMouseDown = (e: MouseEvent<HTMLCanvasElement>) => {
//         const pos = getMousePos(e);

//         const clickedText = texts.find(
//             (t) =>
//                 Math.abs(t.x - pos.x) < 50 &&
//                 Math.abs(t.y - pos.y) < 15 &&
//                 t.listed,
//         );
//         if (clickedText) {
//             setDraggingTextId(clickedText.id);
//             setLastPos(pos);
//             return;
//         }

//         if (mode === 'text' || mode === 'textListed') {
//             const text = prompt('Ingrese texto:');
//             if (!text) return;
//             const vertical = window.confirm(
//                 '¿Desea que el texto sea vertical?',
//             );
//             saveHistory();
//             const newText: TextItem = {
//                 id: uuidv4(),
//                 text,
//                 x: pos.x,
//                 y: pos.y,
//                 listed: mode === 'textListed',
//                 vertical,
//             };
//             setTexts((prev) => [...prev, newText]);
//             return;
//         }

//         setStartPos(pos);
//     };

//     const handleMouseMove = (e: MouseEvent<HTMLCanvasElement>) => {
//         const current = getMousePos(e);

//         if (draggingTextId && lastPos) {
//             const dx = current.x - lastPos.x;
//             const dy = current.y - lastPos.y;
//             setTexts((prev) =>
//                 prev.map((t) =>
//                     t.id === draggingTextId
//                         ? { ...t, x: t.x + dx, y: t.y + dy }
//                         : t,
//                 ),
//             );
//             setLastPos(current);
//             return;
//         }

//         if (!startPos) return;
//         let newPreview: Shape;

//         if (mode === 'door') {
//             const dx = current.x - startPos.x;
//             const dy = current.y - startPos.y;
//             if (Math.abs(dx) > Math.abs(dy)) {
//                 newPreview = {
//                     type: 'door',
//                     x1: startPos.x,
//                     y1: startPos.y,
//                     x2: current.x,
//                     y2: startPos.y,
//                 };
//             } else {
//                 newPreview = {
//                     type: 'door',
//                     x1: startPos.x,
//                     y1: startPos.y,
//                     x2: startPos.x,
//                     y2: current.y,
//                 };
//             }
//         } else if (mode === 'square') {
//             const fixedSize = 100;
//             newPreview = {
//                 type: 'square',
//                 x: current.x - fixedSize / 2,
//                 y: current.y - fixedSize / 2,
//                 w: fixedSize,
//                 h: fixedSize,
//                 color,
//             };
//         } else return;

//         setPreview(newPreview);
//         redraw();
//     };

//     const handleMouseUp = () => {
//         if (draggingTextId) {
//             saveHistory();
//             setDraggingTextId(null);
//             setLastPos(null);
//             return;
//         }

//         if (!startPos || !preview) return;
//         saveHistory();
//         setShapes((prev) => [...prev, preview]);
//         setStartPos(null);
//         setPreview(null);
//     };

//     useEffect(() => {
//         redraw();
//     }, [shapes, preview, texts]);

//     const clearCanvas = () => {
//         saveHistory();
//         setShapes([]);
//         setTexts([]);
//         setPreview(null);
//     };

//     const saveDrawing = () => {
//         const canvas = canvasRef.current;
//         if (!canvas) return;
//         const dataUrl = canvas.toDataURL('image/png');
//         // Inertia.post('/drawings', { image: dataUrl, texts });
//     };

//     const updateText = (id: string, newText: string) => {
//         setTexts((prev) =>
//             prev.map((t) => (t.id === id ? { ...t, text: newText } : t)),
//         );
//     };

//     const deleteText = (id: string) => {
//         saveHistory();
//         setTexts((prev) => prev.filter((t) => t.id !== id));
//     };

//     return (
//         <div className="min-h-screen bg-gray-50 p-6">
//             <div className="mx-auto grid max-w-7xl grid-cols-12 gap-6">
//                 {/* Canvas */}
//                 <Card className="col-span-9">
//                     <CardHeader>
//                         <CardTitle>
//                             Editor 2D — textos, puertas, zonas y deshacer
//                         </CardTitle>
//                     </CardHeader>
//                     <CardContent>
//                         <div className="mb-4 flex flex-wrap items-center gap-3">
//                             <Select
//                                 value={mode}
//                                 onValueChange={(
//                                     v:
//                                         | 'door'
//                                         | 'square'
//                                         | 'text'
//                                         | 'textListed',
//                                 ) => setMode(v)}
//                             >
//                                 <SelectTrigger className="w-[160px]">
//                                     <SelectValue placeholder="Herramienta" />
//                                 </SelectTrigger>
//                                 <SelectContent>
//                                     <SelectItem value="door">Puerta</SelectItem>
//                                     <SelectItem value="square">
//                                         Cuadro / Zona
//                                     </SelectItem>
//                                     <SelectItem value="text">
//                                         Texto fijo
//                                     </SelectItem>
//                                     <SelectItem value="textListed">
//                                         Texto listado
//                                     </SelectItem>
//                                 </SelectContent>
//                             </Select>

//                             {mode === 'square' && (
//                                 <input
//                                     type="color"
//                                     value={color}
//                                     onChange={(e) => setColor(e.target.value)}
//                                     className="rounded border p-1"
//                                 />
//                             )}

//                             <Button variant="outline" onClick={undo}>
//                                 Deshacer
//                             </Button>
//                             <Button variant="outline" onClick={clearCanvas}>
//                                 Limpiar
//                             </Button>
//                             <Button onClick={saveDrawing}>Guardar plano</Button>
//                         </div>

//                         <div className="overflow-hidden rounded-lg border bg-white shadow">
//                             <canvas
//                                 ref={canvasRef}
//                                 className="h-[600px] w-full cursor-crosshair"
//                                 onMouseDown={handleMouseDown}
//                                 onMouseMove={handleMouseMove}
//                                 onMouseUp={handleMouseUp}
//                             />
//                         </div>
//                     </CardContent>
//                 </Card>

//                 {/* Lista de textos */}
//                 <Card className="col-span-3">
//                     <CardHeader>
//                         <CardTitle>Textos listados</CardTitle>
//                     </CardHeader>
//                     <CardContent>
//                         {texts.filter((t) => t.listed).length === 0 ? (
//                             <p className="text-sm text-gray-400">
//                                 No hay textos listados aún
//                             </p>
//                         ) : (
//                             texts
//                                 .filter((t) => t.listed)
//                                 .map((t) => (
//                                     <div
//                                         key={t.id}
//                                         className="flex items-center gap-2 border-b py-1"
//                                     >
//                                         <Input
//                                             value={t.text}
//                                             onChange={(e) =>
//                                                 updateText(t.id, e.target.value)
//                                             }
//                                             className="flex-1 text-sm"
//                                         />
//                                         <Button
//                                             variant="destructive"
//                                             size="sm"
//                                             onClick={() => deleteText(t.id)}
//                                         >
//                                             ×
//                                         </Button>
//                                     </div>
//                                 ))
//                         )}
//                     </CardContent>
//                 </Card>
//             </div>
//         </div>
//     );
// }

// ---------------------------------------------------------------------------
// import { Button } from '@/components/ui/button';
// import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
// import {
//     Select,
//     SelectContent,
//     SelectItem,
//     SelectTrigger,
//     SelectValue,
// } from '@/components/ui/select';
// // import { Inertia } from '@inertiajs/inertia';
// import { JSX, MouseEvent, useEffect, useRef, useState } from 'react';
// import { v4 as uuidv4 } from 'uuid';

// /*
//   DrawingBoard avanzado (TypeScript + React)
//   - Paredes y puertas siempre rectas (horiz/vert)
//   - Cuadrados coloreados
//   - Dos tipos de texto: listado (aparece en panel) y simple
//   - Drag & drop para TODOS los elementos (líneas, cuadrados, textos)
//   - Undo / Redo
//   - Guardar (envía imagen + elementos al backend vía Inertia)

//   Guardar este archivo en:
//   resources/js/Pages/DrawingBoardAdvanced.tsx
// */

// type ElementType = 'wall' | 'door' | 'square' | 'text';

// type BaseElement = {
//     id: string;
//     type: ElementType;
// };

// type LineElement = BaseElement & {
//     type: 'wall' | 'door';
//     x1: number;
//     y1: number;
//     x2: number;
//     y2: number;
// };

// type SquareElement = BaseElement & {
//     type: 'square';
//     x: number;
//     y: number;
//     w: number;
//     h: number;
//     color: string;
// };

// type TextElement = BaseElement & {
//     type: 'text';
//     x: number;
//     y: number;
//     text: string;
//     color: string;
//     listed: boolean; // si aparece en panel lateral
// };

// type Drawable = LineElement | SquareElement | TextElement;

// export default function DrawingBoardAdvanced(): JSX.Element {
//     const canvasRef = useRef<HTMLCanvasElement | null>(null);
//     const ctxRef = useRef<CanvasRenderingContext2D | null>(null);

//     const [elements, setElements] = useState<Drawable[]>([]);
//     const [preview, setPreview] = useState<Drawable | null>(null);

//     const [tool, setTool] = useState<
//         'wall' | 'door' | 'square' | 'text' | 'textListed'
//     >('wall');
//     const [color, setColor] = useState<string>('#2563eb');

//     // drag state
//     const [draggingId, setDraggingId] = useState<string | null>(null);
//     const [dragOffset, setDragOffset] = useState<{
//         dx: number;
//         dy: number;
//     } | null>(null);

//     // drawing start
//     const [startPos, setStartPos] = useState<{ x: number; y: number } | null>(
//         null,
//     );

//     // history stacks for undo/redo
//     const [undoStack, setUndoStack] = useState<Drawable[][]>([]);
//     const [redoStack, setRedoStack] = useState<Drawable[][]>([]);

//     useEffect(() => {
//         const canvas = canvasRef.current;
//         if (!canvas) return;
//         const ctx = canvas.getContext('2d');
//         if (!ctx) return;
//         ctxRef.current = ctx;
//         resizeCanvas();
//         window.addEventListener('resize', resizeCanvas);
//         // keyboard shortcuts
//         const onKey = (ev: KeyboardEvent) => {
//             if ((ev.ctrlKey || ev.metaKey) && ev.key.toLowerCase() === 'z') {
//                 ev.preventDefault();
//                 undo();
//             }
//             if ((ev.ctrlKey || ev.metaKey) && ev.key.toLowerCase() === 'y') {
//                 ev.preventDefault();
//                 redo();
//             }
//         };
//         window.addEventListener('keydown', onKey);
//         return () => {
//             window.removeEventListener('resize', resizeCanvas);
//             window.removeEventListener('keydown', onKey);
//         };
//     }, []);

//     useEffect(() => {
//         redraw();
//     }, [elements, preview]);

//     const pushHistory = (next: Drawable[]) => {
//         setUndoStack((u) => [...u, elements.map((e) => cloneElement(e))]);
//         setRedoStack([]);
//     };

//     const undo = () => {
//         setUndoStack((u) => {
//             if (u.length === 0) return u;
//             const last = u[u.length - 1];
//             setRedoStack((r) => [...r, elements.map((e) => cloneElement(e))]);
//             setElements(last.map((e) => cloneElement(e)));
//             return u.slice(0, -1);
//         });
//     };

//     const redo = () => {
//         setRedoStack((r) => {
//             if (r.length === 0) return r;
//             const last = r[r.length - 1];
//             setUndoStack((u) => [...u, elements.map((e) => cloneElement(e))]);
//             setElements(last.map((e) => cloneElement(e)));
//             return r.slice(0, -1);
//         });
//     };

//     function cloneElement(e: Drawable): Drawable {
//         return JSON.parse(JSON.stringify(e)) as Drawable;
//     }

//     function resizeCanvas() {
//         const canvas = canvasRef.current;
//         const ctx = ctxRef.current;
//         if (!canvas || !ctx) return;
//         const rect = canvas.getBoundingClientRect();
//         canvas.width = rect.width * devicePixelRatio;
//         canvas.height = rect.height * devicePixelRatio;
//         canvas.style.width = `${rect.width}px`;
//         canvas.style.height = `${rect.height}px`;
//         ctx.setTransform(devicePixelRatio, 0, 0, devicePixelRatio, 0, 0);
//         redraw();
//     }

//     function redraw() {
//         const ctx = ctxRef.current;
//         const canvas = canvasRef.current;
//         if (!ctx || !canvas) return;
//         ctx.clearRect(0, 0, canvas.width, canvas.height);
//         // background
//         ctx.fillStyle = '#ffffff';
//         ctx.fillRect(
//             0,
//             0,
//             canvas.width / devicePixelRatio,
//             canvas.height / devicePixelRatio,
//         );

//         // draw elements
//         for (const e of elements) drawElement(ctx, e);
//         // preview on top
//         if (preview) drawElement(ctx, preview, true);
//     }

//     function drawElement(
//         ctx: CanvasRenderingContext2D,
//         e: Drawable,
//         isPreview = false,
//     ) {
//         ctx.save();
//         if (isPreview) ctx.globalAlpha = 0.5;

//         if (e.type === 'wall' || e.type === 'door') {
//             ctx.beginPath();
//             ctx.strokeStyle = e.type === 'wall' ? '#000' : '#16a34a';
//             ctx.lineWidth = e.type === 'wall' ? 5 : 3;
//             ctx.moveTo(e.x1, e.y1);
//             ctx.lineTo(e.x2, e.y2);
//             ctx.stroke();
//             ctx.closePath();
//         }

//         if (e.type === 'square') {
//             ctx.fillStyle = e.color;
//             ctx.fillRect(e.x, e.y, e.w, e.h);
//             ctx.strokeStyle = '#374151';
//             ctx.lineWidth = 1;
//             ctx.strokeRect(e.x, e.y, e.w, e.h);
//         }

//         if (e.type === 'text') {
//             ctx.fillStyle = e.color;
//             ctx.font = '16px sans-serif';
//             ctx.textBaseline = 'top';
//             ctx.fillText(e.text, e.x, e.y);
//             // if listed, draw a small marker
//             if (e.listed) {
//                 ctx.strokeStyle = '#1f2937';
//                 const w = ctx.measureText(e.text).width;
//                 ctx.strokeRect(e.x - 2, e.y - 2, w + 4, 20);
//             }
//         }

//         ctx.restore();
//     }

//     // geometry helpers
//     function distPointToSegment(
//         px: number,
//         py: number,
//         x1: number,
//         y1: number,
//         x2: number,
//         y2: number,
//     ) {
//         const A = px - x1;
//         const B = py - y1;
//         const C = x2 - x1;
//         const D = y2 - y1;

//         const dot = A * C + B * D;
//         const len_sq = C * C + D * D;
//         let param = -1;
//         if (len_sq !== 0) param = dot / len_sq;

//         let xx, yy;

//         if (param < 0) {
//             xx = x1;
//             yy = y1;
//         } else if (param > 1) {
//             xx = x2;
//             yy = y2;
//         } else {
//             xx = x1 + param * C;
//             yy = y1 + param * D;
//         }

//         const dx = px - xx;
//         const dy = py - yy;
//         return Math.sqrt(dx * dx + dy * dy);
//     }

//     function hitTest(
//         px: number,
//         py: number,
//     ): { element: Drawable | null; info?: any } {
//         // check in reverse order (topmost first)
//         for (let i = elements.length - 1; i >= 0; i--) {
//             const e = elements[i];
//             if (e.type === 'wall' || e.type === 'door') {
//                 const d = distPointToSegment(px, py, e.x1, e.y1, e.x2, e.y2);
//                 if (d <= 8) return { element: e, info: { index: i } };
//             }
//             if (e.type === 'square') {
//                 if (
//                     px >= e.x &&
//                     px <= e.x + e.w &&
//                     py >= e.y &&
//                     py <= e.y + e.h
//                 )
//                     return { element: e, info: { index: i } };
//             }
//             if (e.type === 'text') {
//                 const ctx = ctxRef.current;
//                 if (!ctx) continue;
//                 ctx.font = '16px sans-serif';
//                 const w = ctx.measureText(e.text).width;
//                 const h = 18;
//                 if (px >= e.x && px <= e.x + w && py >= e.y && py <= e.y + h)
//                     return { element: e, info: { index: i } };
//             }
//         }
//         return { element: null };
//     }

//     // Mouse handlers
//     const toCanvasCoords = (e: MouseEvent<HTMLCanvasElement>) => {
//         const rect = canvasRef.current!.getBoundingClientRect();
//         return { x: e.clientX - rect.left, y: e.clientY - rect.top };
//     };

//     const onMouseDown = (e: MouseEvent<HTMLCanvasElement>) => {
//         const pos = toCanvasCoords(e);
//         const hit = hitTest(pos.x, pos.y);

//         // if clicked on element, begin dragging it
//         if (hit.element) {
//             const el = hit.element;
//             setDraggingId(el.id);
//             if (el.type === 'square') {
//                 setDragOffset({ dx: pos.x - el.x, dy: pos.y - el.y });
//             } else if (el.type === 'text') {
//                 setDragOffset({ dx: pos.x - el.x, dy: pos.y - el.y });
//             } else {
//                 // for lines, compute offset as difference to x1,y1
//                 setDragOffset({
//                     dx: pos.x - (el as LineElement).x1,
//                     dy: pos.y - (el as LineElement).y1,
//                 });
//             }
//             // save state for undo
//             pushHistory(elements.map((e) => cloneElement(e)));
//             return;
//         }

//         // if tool is text -> add text immediately
//         if (tool === 'text' || tool === 'textListed') {
//             const txt = prompt('Ingrese texto:');
//             if (!txt) return;
//             pushHistory(elements.map((e) => cloneElement(e)));
//             const newText: TextElement = {
//                 id: uuidv4(),
//                 type: 'text',
//                 x: pos.x,
//                 y: pos.y,
//                 text: txt,
//                 color,
//                 listed: tool === 'textListed',
//             };
//             setElements((prev) => [...prev, newText]);
//             return;
//         }

//         // begin drawing for wall/door/square
//         setStartPos(pos);
//     };

//     const onMouseMove = (e: MouseEvent<HTMLCanvasElement>) => {
//         const pos = toCanvasCoords(e);
//         // dragging an element
//         if (draggingId && dragOffset) {
//             setElements((prev) =>
//                 prev.map((el) => {
//                     if (el.id !== draggingId) return el;
//                     if (el.type === 'square') {
//                         const s = el as SquareElement;
//                         return {
//                             ...s,
//                             x: pos.x - dragOffset.dx,
//                             y: pos.y - dragOffset.dy,
//                         };
//                     }
//                     if (el.type === 'text') {
//                         const t = el as TextElement;
//                         return {
//                             ...t,
//                             x: pos.x - dragOffset.dx,
//                             y: pos.y - dragOffset.dy,
//                         };
//                     }
//                     if (el.type === 'wall' || el.type === 'door') {
//                         const l = el as LineElement;
//                         // keep line orientation (horizontal/vertical) relative to original start
//                         // We'll move both points by delta
//                         const dx = pos.x - dragOffset.dx - l.x1;
//                         const dy = pos.y - dragOffset.dy - l.y1;
//                         return {
//                             ...l,
//                             x1: l.x1 + dx,
//                             y1: l.y1 + dy,
//                             x2: l.x2 + dx,
//                             y2: l.y2 + dy,
//                         };
//                     }
//                     return el;
//                 }),
//             );
//             return;
//         }

//         // drawing preview
//         if (!startPos) return;
//         if (tool === 'wall' || tool === 'door') {
//             const dx = pos.x - startPos.x;
//             const dy = pos.y - startPos.y;
//             let endX = pos.x;
//             let endY = pos.y;
//             if (Math.abs(dx) > Math.abs(dy))
//                 endY = startPos.y; // horizontal
//             else endX = startPos.x; // vertical
//             const previewLine: LineElement = {
//                 id: 'preview',
//                 type: tool,
//                 x1: startPos.x,
//                 y1: startPos.y,
//                 x2: endX,
//                 y2: endY,
//             };
//             setPreview(previewLine);
//             return;
//         }
//         if (tool === 'square') {
//             const w = pos.x - startPos.x;
//             const h = pos.y - startPos.y;
//             const previewSquare: SquareElement = {
//                 id: 'preview',
//                 type: 'square',
//                 x: startPos.x,
//                 y: startPos.y,
//                 w,
//                 h,
//                 color,
//             };
//             setPreview(previewSquare);
//             return;
//         }
//     };

//     const onMouseUp = (e?: MouseEvent<HTMLCanvasElement>) => {
//         // finish dragging
//         if (draggingId) {
//             setDraggingId(null);
//             setDragOffset(null);
//             return;
//         }

//         // finish drawing
//         if (!startPos || !preview) {
//             setStartPos(null);
//             setPreview(null);
//             return;
//         }

//         pushHistory(elements.map((e) => cloneElement(e)));
//         const newEl = { ...preview, id: uuidv4() } as Drawable;
//         setElements((prev) => [...prev, newEl]);
//         setStartPos(null);
//         setPreview(null);
//     };

//     // helper to find text list for sidepanel
//     const listedTexts = elements.filter(
//         (e) => e.type === 'text' && e.listed,
//     ) as TextElement[];

//     const updateText = (id: string, newText: string) => {
//         pushHistory(elements.map((e) => cloneElement(e)));
//         setElements((prev) =>
//             prev.map((el) =>
//                 el.id === id && el.type === 'text'
//                     ? { ...el, text: newText }
//                     : el,
//             ),
//         );
//     };

//     const deleteElement = (id: string) => {
//         pushHistory(elements.map((e) => cloneElement(e)));
//         setElements((prev) => prev.filter((e) => e.id !== id));
//     };

//     const clearAll = () => {
//         pushHistory(elements.map((e) => cloneElement(e)));
//         setElements([]);
//         setPreview(null);
//     };

//     const saveDrawing = () => {
//         const canvas = canvasRef.current;
//         if (!canvas) return;
//         const dataUrl = canvas.toDataURL('image/png');
//         // Inertia.post('/drawings', { image: dataUrl, elements });
//     };

//     return (
//         <div className="min-h-screen bg-gray-50 p-6">
//             <div className="max-w-8xl mx-auto grid grid-cols-12 gap-6">
//                 <Card className="col-span-9">
//                     <CardHeader>
//                         <CardTitle>DrawingBoard — Avanzado</CardTitle>
//                     </CardHeader>
//                     <CardContent>
//                         <div className="mb-4 flex items-center gap-3">
//                             <Select
//                                 value={tool}
//                                 onValueChange={(v: any) => setTool(v)}
//                             >
//                                 <SelectTrigger className="w-[180px]">
//                                     <SelectValue placeholder="Herramienta" />
//                                 </SelectTrigger>
//                                 <SelectContent>
//                                     <SelectItem value="wall">
//                                         Pared (recta)
//                                     </SelectItem>
//                                     <SelectItem value="door">
//                                         Puerta (recta)
//                                     </SelectItem>
//                                     <SelectItem value="square">
//                                         Cuadro / Zona
//                                     </SelectItem>
//                                     <SelectItem value="text">
//                                         Texto simple
//                                     </SelectItem>
//                                     <SelectItem value="textListed">
//                                         Texto listado
//                                     </SelectItem>
//                                 </SelectContent>
//                             </Select>

//                             {tool === 'square' && (
//                                 <input
//                                     type="color"
//                                     value={color}
//                                     onChange={(ev) => setColor(ev.target.value)}
//                                     className="rounded border p-1"
//                                 />
//                             )}

//                             <Button
//                                 variant="outline"
//                                 onClick={() => {
//                                     undo();
//                                 }}
//                             >
//                                 Deshacer
//                             </Button>
//                             <Button
//                                 variant="outline"
//                                 onClick={() => {
//                                     redo();
//                                 }}
//                             >
//                                 Rehacer
//                             </Button>
//                             <Button variant="outline" onClick={clearAll}>
//                                 Limpiar
//                             </Button>
//                             <Button onClick={saveDrawing}>Guardar</Button>
//                         </div>

//                         <div className="overflow-hidden rounded-lg border bg-white shadow">
//                             <div style={{ width: '100%', height: 600 }}>
//                                 <canvas
//                                     ref={canvasRef}
//                                     className="h-full w-full"
//                                     onMouseDown={onMouseDown}
//                                     onMouseMove={onMouseMove}
//                                     onMouseUp={onMouseUp}
//                                 />
//                             </div>
//                         </div>
//                     </CardContent>
//                 </Card>

//                 <Card className="col-span-3">
//                     <CardHeader>
//                         <CardTitle>Elementos / Textos listados</CardTitle>
//                     </CardHeader>
//                     <CardContent>
//                         <div className="space-y-3">
//                             <h4 className="text-sm font-medium">
//                                 Textos listados
//                             </h4>
//                             {listedTexts.length === 0 && (
//                                 <p className="text-sm text-gray-500">
//                                     No hay textos listados
//                                 </p>
//                             )}
//                             {listedTexts.map((t) => (
//                                 <div
//                                     key={t.id}
//                                     className="flex items-center gap-2"
//                                 >
//                                     <input
//                                         className="flex-1 rounded border p-1 text-sm"
//                                         value={t.text}
//                                         onChange={(e) =>
//                                             updateText(t.id, e.target.value)
//                                         }
//                                     />
//                                     <Button
//                                         variant="destructive"
//                                         size="sm"
//                                         onClick={() => deleteElement(t.id)}
//                                     >
//                                         Eliminar
//                                     </Button>
//                                 </div>
//                             ))}

//                             <hr className="my-3" />

//                             <h4 className="text-sm font-medium">
//                                 Todos los elementos
//                             </h4>
//                             <div className="space-y-1 text-sm">
//                                 {elements.map((el) => (
//                                     <div
//                                         key={el.id}
//                                         className="flex items-center justify-between rounded border p-1"
//                                     >
//                                         <div className="text-xs">
//                                             <strong>{el.type}</strong>
//                                             {el.type === 'text' && (
//                                                 <span>
//                                                     : "
//                                                     {(el as TextElement).text}"
//                                                 </span>
//                                             )}
//                                         </div>
//                                         <div className="flex gap-1">
//                                             <Button
//                                                 size="sm"
//                                                 variant="outline"
//                                                 onClick={() => {
//                                                     // center view on element (not implemented, placeholder)
//                                                 }}
//                                             >
//                                                 Ver
//                                             </Button>
//                                             <Button
//                                                 size="sm"
//                                                 variant="destructive"
//                                                 onClick={() =>
//                                                     deleteElement(el.id)
//                                                 }
//                                             >
//                                                 X
//                                             </Button>
//                                         </div>
//                                     </div>
//                                 ))}
//                             </div>
//                         </div>
//                     </CardContent>
//                 </Card>
//             </div>
//         </div>
//     );
// }

// ------------------------------------------------------------------
// import { Button } from '@/components/ui/button';
// import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
// import { Input } from '@/components/ui/input';
// import {
//     Select,
//     SelectContent,
//     SelectItem,
//     SelectTrigger,
//     SelectValue,
// } from '@/components/ui/select';
// // import { Inertia } from '@inertiajs/inertia';
// import { JSX, MouseEvent, useEffect, useRef, useState } from 'react';
// import { v4 as uuidv4 } from 'uuid';

// type Shape =
//     | { type: 'wall' | 'door'; x1: number; y1: number; x2: number; y2: number }
//     | {
//           type: 'square';
//           x: number;
//           y: number;
//           w: number;
//           h: number;
//           color: string;
//       };

// type TextItem = {
//     id: string;
//     text: string;
//     x: number;
//     y: number;
//     listed: boolean;
// };

// export default function DrawingBoard(): JSX.Element {
//     const canvasRef = useRef<HTMLCanvasElement | null>(null);
//     const ctxRef = useRef<CanvasRenderingContext2D | null>(null);

//     const [mode, setMode] = useState<
//         'wall' | 'door' | 'square' | 'text' | 'textListed'
//     >('wall');
//     const [color, setColor] = useState('#1e40af');
//     const [startPos, setStartPos] = useState<{ x: number; y: number } | null>(
//         null,
//     );
//     const [shapes, setShapes] = useState<Shape[]>([]);
//     const [preview, setPreview] = useState<Shape | null>(null);
//     const [texts, setTexts] = useState<TextItem[]>([]);
//     const [draggingTextId, setDraggingTextId] = useState<string | null>(null);
//     const [lastPos, setLastPos] = useState<{ x: number; y: number } | null>(
//         null,
//     );
//     const [history, setHistory] = useState<
//         { shapes: Shape[]; texts: TextItem[] }[]
//     >([]);

//     useEffect(() => {
//         const canvas = canvasRef.current;
//         if (!canvas) return;
//         const ctx = canvas.getContext('2d');
//         if (!ctx) return;
//         ctxRef.current = ctx;
//         resizeCanvas();
//         window.addEventListener('resize', resizeCanvas);
//         return () => window.removeEventListener('resize', resizeCanvas);
//     }, []);

//     const resizeCanvas = () => {
//         const canvas = canvasRef.current;
//         if (!canvas || !ctxRef.current) return;
//         const rect = canvas.getBoundingClientRect();
//         canvas.width = rect.width;
//         canvas.height = rect.height;
//         redraw();
//     };

//     const saveHistory = () => {
//         setHistory((prev) => [
//             ...prev,
//             { shapes: [...shapes], texts: [...texts] },
//         ]);
//     };

//     const undo = () => {
//         if (history.length === 0) return;
//         const last = history[history.length - 1];
//         setShapes(last.shapes);
//         setTexts(last.texts);
//         setHistory(history.slice(0, -1));
//     };

//     const redraw = () => {
//         const ctx = ctxRef.current;
//         if (!ctx) return;
//         ctx.clearRect(0, 0, ctx.canvas.width, ctx.canvas.height);
//         for (const s of shapes) drawShape(ctx, s);
//         if (preview) drawShape(ctx, preview, true);
//         for (const t of texts) drawText(ctx, t);
//     };

//     const drawShape = (
//         ctx: CanvasRenderingContext2D,
//         s: Shape,
//         isPreview = false,
//     ) => {
//         ctx.beginPath();
//         ctx.globalAlpha = isPreview ? 0.5 : 1;

//         switch (s.type) {
//             case 'wall':
//                 ctx.strokeStyle = '#000';
//                 ctx.lineWidth = 5;
//                 ctx.moveTo(s.x1, s.y1);
//                 ctx.lineTo(s.x2, s.y2);
//                 ctx.stroke();
//                 break;
//             case 'door':
//                 ctx.strokeStyle = '#16a34a';
//                 ctx.lineWidth = 3;
//                 ctx.moveTo(s.x1, s.y1);
//                 ctx.lineTo(s.x2, s.y2);
//                 ctx.stroke();
//                 break;
//             case 'square':
//                 ctx.fillStyle = s.color;
//                 ctx.fillRect(s.x, s.y, s.w, s.h);
//                 ctx.strokeStyle = '#374151';
//                 ctx.strokeRect(s.x, s.y, s.w, s.h);
//                 break;
//         }

//         ctx.globalAlpha = 1;
//         ctx.closePath();
//     };

//     const drawText = (ctx: CanvasRenderingContext2D, t: TextItem) => {
//         ctx.fillStyle = t.listed ? '#111827' : '#9ca3af';
//         ctx.font = t.listed ? 'bold 16px sans-serif' : '14px sans-serif';
//         ctx.fillText(t.text, t.x, t.y);
//     };

//     const getMousePos = (
//         e: MouseEvent<HTMLCanvasElement>,
//     ): { x: number; y: number } => {
//         const rect = canvasRef.current?.getBoundingClientRect();
//         return {
//             x: e.clientX - (rect?.left ?? 0),
//             y: e.clientY - (rect?.top ?? 0),
//         };
//     };

//     const handleMouseDown = (e: MouseEvent<HTMLCanvasElement>) => {
//         const pos = getMousePos(e);

//         // Detectar si se hace click sobre un texto listado
//         const clickedText = texts.find(
//             (t) =>
//                 Math.abs(t.x - pos.x) < 50 &&
//                 Math.abs(t.y - pos.y) < 15 &&
//                 t.listed,
//         );
//         if (clickedText) {
//             setDraggingTextId(clickedText.id);
//             setLastPos(pos);
//             return;
//         }

//         if (mode === 'text' || mode === 'textListed') {
//             const text = prompt('Ingrese texto:');
//             if (!text) return;
//             saveHistory();
//             const newText: TextItem = {
//                 id: uuidv4(),
//                 text,
//                 x: pos.x,
//                 y: pos.y,
//                 listed: mode === 'textListed',
//             };
//             setTexts((prev) => [...prev, newText]);
//             return;
//         }

//         setStartPos(pos);
//     };

//     const handleMouseMove = (e: MouseEvent<HTMLCanvasElement>) => {
//         const current = getMousePos(e);

//         // Si se está arrastrando un texto
//         if (draggingTextId && lastPos) {
//             const dx = current.x - lastPos.x;
//             const dy = current.y - lastPos.y;
//             setTexts((prev) =>
//                 prev.map((t) =>
//                     t.id === draggingTextId
//                         ? { ...t, x: t.x + dx, y: t.y + dy }
//                         : t,
//                 ),
//             );
//             setLastPos(current);
//             return;
//         }

//         if (!startPos) return;
//         let newPreview: Shape;

//         if (mode === 'wall' || mode === 'door') {
//             const dx = current.x - startPos.x;
//             const dy = current.y - startPos.y;
//             if (Math.abs(dx) > Math.abs(dy)) {
//                 newPreview = {
//                     type: mode,
//                     x1: startPos.x,
//                     y1: startPos.y,
//                     x2: current.x,
//                     y2: startPos.y,
//                 };
//             } else {
//                 newPreview = {
//                     type: mode,
//                     x1: startPos.x,
//                     y1: startPos.y,
//                     x2: startPos.x,
//                     y2: current.y,
//                 };
//             }
//         } else if (mode === 'square') {
//             const w = current.x - startPos.x;
//             const h = current.y - startPos.y;
//             newPreview = {
//                 type: 'square',
//                 x: startPos.x,
//                 y: startPos.y,
//                 w,
//                 h,
//                 color,
//             };
//         } else return;

//         setPreview(newPreview);
//         redraw();
//     };

//     const handleMouseUp = () => {
//         if (draggingTextId) {
//             saveHistory();
//             setDraggingTextId(null);
//             setLastPos(null);
//             return;
//         }

//         if (!startPos || !preview) return;
//         saveHistory();
//         setShapes((prev) => [...prev, preview]);
//         setStartPos(null);
//         setPreview(null);
//     };

//     useEffect(() => {
//         redraw();
//     }, [shapes, preview, texts]);

//     const clearCanvas = () => {
//         saveHistory();
//         setShapes([]);
//         setTexts([]);
//         setPreview(null);
//     };

//     const saveDrawing = () => {
//         const canvas = canvasRef.current;
//         if (!canvas) return;
//         const dataUrl = canvas.toDataURL('image/png');
//         Inertia.post('/drawings', { image: dataUrl, texts });
//     };

//     const updateText = (id: string, newText: string) => {
//         setTexts((prev) =>
//             prev.map((t) => (t.id === id ? { ...t, text: newText } : t)),
//         );
//     };

//     const deleteText = (id: string) => {
//         saveHistory();
//         setTexts((prev) => prev.filter((t) => t.id !== id));
//     };

//     return (
//         <div className="min-h-screen bg-gray-50 p-6">
//             <div className="mx-auto grid max-w-7xl grid-cols-12 gap-6">
//                 {/* Canvas */}
//                 <Card className="col-span-9">
//                     <CardHeader>
//                         <CardTitle>
//                             Editor 2D — textos, cuadrados y deshacer
//                         </CardTitle>
//                     </CardHeader>
//                     <CardContent>
//                         <div className="mb-4 flex flex-wrap items-center gap-3">
//                             <Select
//                                 value={mode}
//                                 onValueChange={(
//                                     v:
//                                         | 'wall'
//                                         | 'door'
//                                         | 'square'
//                                         | 'text'
//                                         | 'textListed',
//                                 ) => setMode(v)}
//                             >
//                                 <SelectTrigger className="w-[160px]">
//                                     <SelectValue placeholder="Herramienta" />
//                                 </SelectTrigger>
//                                 <SelectContent>
//                                     <SelectItem value="wall">Pared</SelectItem>
//                                     <SelectItem value="door">Puerta</SelectItem>
//                                     <SelectItem value="square">
//                                         Cuadro / Zona
//                                     </SelectItem>
//                                     <SelectItem value="text">
//                                         Texto fijo
//                                     </SelectItem>
//                                     <SelectItem value="textListed">
//                                         Texto listado
//                                     </SelectItem>
//                                 </SelectContent>
//                             </Select>

//                             {mode === 'square' && (
//                                 <input
//                                     type="color"
//                                     value={color}
//                                     onChange={(e) => setColor(e.target.value)}
//                                     className="rounded border p-1"
//                                 />
//                             )}

//                             <Button variant="outline" onClick={undo}>
//                                 Deshacer
//                             </Button>
//                             <Button variant="outline" onClick={clearCanvas}>
//                                 Limpiar
//                             </Button>
//                             <Button onClick={saveDrawing}>Guardar plano</Button>
//                         </div>

//                         <div className="overflow-hidden rounded-lg border bg-white shadow">
//                             <canvas
//                                 ref={canvasRef}
//                                 className="h-[600px] w-full cursor-crosshair"
//                                 onMouseDown={handleMouseDown}
//                                 onMouseMove={handleMouseMove}
//                                 onMouseUp={handleMouseUp}
//                             />
//                         </div>
//                     </CardContent>
//                 </Card>

//                 {/* Lista de textos */}
//                 <Card className="col-span-3">
//                     <CardHeader>
//                         <CardTitle>Textos listados</CardTitle>
//                     </CardHeader>
//                     <CardContent>
//                         {texts.filter((t) => t.listed).length === 0 ? (
//                             <p className="text-sm text-gray-400">
//                                 No hay textos listados aún
//                             </p>
//                         ) : (
//                             texts
//                                 .filter((t) => t.listed)
//                                 .map((t) => (
//                                     <div
//                                         key={t.id}
//                                         className="flex items-center gap-2 border-b py-1"
//                                     >
//                                         <Input
//                                             value={t.text}
//                                             onChange={(e) =>
//                                                 updateText(t.id, e.target.value)
//                                             }
//                                             className="flex-1 text-sm"
//                                         />
//                                         <Button
//                                             variant="destructive"
//                                             size="sm"
//                                             onClick={() => deleteText(t.id)}
//                                         >
//                                             ×
//                                         </Button>
//                                     </div>
//                                 ))
//                         )}
//                     </CardContent>
//                 </Card>
//             </div>
//         </div>
//     );
// }
