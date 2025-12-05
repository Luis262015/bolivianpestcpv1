// resources/js/Components/SignaturePad.tsx
import { useRef } from 'react';

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

  const startDraw = (e: React.MouseEvent | React.TouchEvent) => {
    drawing.current = true;
    draw(e);
  };

  const endDraw = () => {
    drawing.current = false;
    if (canvasRef.current && onChange) {
      const data = canvasRef.current.toDataURL('image/png');
      onChange(data);
    }
  };

  const draw = (e: any) => {
    if (!drawing.current || !canvasRef.current) return;

    const canvas = canvasRef.current;
    const ctx = canvas.getContext('2d')!;
    const rect = canvas.getBoundingClientRect();

    const x = (e.clientX || e.touches?.[0]?.clientX) - rect.left;
    const y = (e.clientY || e.touches?.[0]?.clientY) - rect.top;

    ctx.lineWidth = 2;
    ctx.lineCap = 'round';
    ctx.strokeStyle = '#000';
    ctx.lineTo(x, y);
    ctx.stroke();
    ctx.beginPath();
    ctx.moveTo(x, y);
  };

  const clear = () => {
    if (canvasRef.current) {
      const ctx = canvasRef.current.getContext('2d')!;
      ctx.clearRect(0, 0, width, height);
      ctx.beginPath();
      if (onChange) onChange('');
    }
  };

  return (
    <div className="space-y-2">
      <canvas
        ref={canvasRef}
        width={width}
        height={height}
        className="rounded-md border bg-white"
        onMouseDown={startDraw}
        onMouseUp={endDraw}
        onMouseMove={draw}
        onMouseLeave={endDraw}
        onTouchStart={startDraw}
        onTouchEnd={endDraw}
        onTouchMove={draw}
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
