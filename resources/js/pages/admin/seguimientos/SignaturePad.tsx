// resources/js/Components/SignaturePad.tsx
import { useEffect, useRef } from 'react';

interface Props {
  width?: number;
  height?: number;
  onChange?: (dataUrl: string) => void;
}

export default function SignaturePad({
  width = 400,
  height = 200,
  onChange,
}: Props) {
  const canvasRef = useRef<HTMLCanvasElement>(null);
  const drawing = useRef(false);
  const lastPoint = useRef<{ x: number; y: number } | null>(null);
  const hasContent = useRef(false);

  // Configura el canvas para pantallas de alta densidad (DPI) una sola vez.
  useEffect(() => {
    const canvas = canvasRef.current;
    if (!canvas) return;

    const ratio = window.devicePixelRatio || 1;
    canvas.width = width * ratio;
    canvas.height = height * ratio;
    canvas.style.width = `${width}px`;
    canvas.style.height = `${height}px`;

    const ctx = canvas.getContext('2d');
    if (!ctx) return;
    ctx.scale(ratio, ratio);
    ctx.lineWidth = 2;
    ctx.lineCap = 'round';
    ctx.lineJoin = 'round';
    ctx.strokeStyle = '#000';
  }, [width, height]);

  const getPoint = (e: React.PointerEvent) => {
    const canvas = canvasRef.current!;
    const rect = canvas.getBoundingClientRect();
    return {
      x: e.clientX - rect.left,
      y: e.clientY - rect.top,
    };
  };

  const startDraw = (e: React.PointerEvent) => {
    e.preventDefault();
    if (!canvasRef.current) return;

    // Captura el puntero para seguir recibiendo eventos aunque salga del canvas.
    canvasRef.current.setPointerCapture(e.pointerId);

    drawing.current = true;
    lastPoint.current = getPoint(e);
  };

  const draw = (e: React.PointerEvent) => {
    if (!drawing.current || !canvasRef.current || !lastPoint.current) return;
    e.preventDefault();

    const ctx = canvasRef.current.getContext('2d');
    if (!ctx) return;

    const point = getPoint(e);

    ctx.beginPath();
    ctx.moveTo(lastPoint.current.x, lastPoint.current.y);
    ctx.lineTo(point.x, point.y);
    ctx.stroke();

    lastPoint.current = point;
    hasContent.current = true;
  };

  const endDraw = (e: React.PointerEvent) => {
    if (!drawing.current) return;
    drawing.current = false;
    lastPoint.current = null;

    if (canvasRef.current?.hasPointerCapture(e.pointerId)) {
      canvasRef.current.releasePointerCapture(e.pointerId);
    }

    if (hasContent.current && canvasRef.current && onChange) {
      onChange(canvasRef.current.toDataURL('image/png'));
    }
  };

  const clear = () => {
    const canvas = canvasRef.current;
    if (!canvas) return;

    const ctx = canvas.getContext('2d');
    if (!ctx) return;

    // clearRect en coordenadas del canvas real (afectado por el scale del DPI).
    const ratio = window.devicePixelRatio || 1;
    ctx.clearRect(0, 0, canvas.width / ratio, canvas.height / ratio);

    hasContent.current = false;
    lastPoint.current = null;
    if (onChange) onChange('');
  };

  return (
    <div className="space-y-2">
      <canvas
        ref={canvasRef}
        className="touch-none rounded-md border bg-white"
        onPointerDown={startDraw}
        onPointerMove={draw}
        onPointerUp={endDraw}
        onPointerCancel={endDraw}
        onPointerLeave={endDraw}
      ></canvas>

      <button
        type="button"
        className="rounded-md border px-3 py-1 text-sm"
        onClick={clear}
      >
        Limpiar firma
      </button>
    </div>
  );
}
