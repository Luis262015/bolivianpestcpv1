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
import { usePermissions } from '@/hooks/usePermissions';
import AppLayout from '@/layouts/app-layout';
import { type BreadcrumbItem } from '@/types';
import { Head, router } from '@inertiajs/react';
import { ChangeEvent, MouseEvent, useEffect, useRef, useState } from 'react';
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

interface TrampaTipo {
  id: number;
  nombre: string;
  imagen: string | null;
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
  tempId: string;
  id?: number;
  trampa_tipo_id: number;
  posx: number;
  posy: number;
  estado?: string;
};

type Dragging =
  | { type: 'text'; id: string; offsetX: number; offsetY: number }
  | { type: 'trap'; tempId: string; offsetX: number; offsetY: number };

interface Props {
  empresas: Empresa[];
  allAlmacenes: Almacen[];
  trampaTipos: TrampaTipo[];
  selectedEmpresa?: number | null;
  selectedAlmacen?: number | null;
  mapa?: {
    id: number;
    background: string | null;
    texts: TextItem[];
    trampas: Trap[]; // Aquí usamos el tipo Trap que ya tienes definido
  } | null; // ← Permitimos null explícitamente
}

export default function MapaEditor(props: Props) {
  const { hasRole } = usePermissions();

  const CANVAS_WIDTH = 1000;
  const CANVAS_HEIGHT = 700;

  const canvasRef = useRef<HTMLCanvasElement | null>(null);
  const ctxRef = useRef<CanvasRenderingContext2D | null>(null);
  const backgroundImageRef = useRef<HTMLImageElement | null>(null);
  const trapImagesRef = useRef<Record<number, HTMLImageElement>>({});

  const [mode, setMode] = useState<'text' | 'textListed' | number>('text');
  const [textOrientation, setTextOrientation] = useState<
    'horizontal' | 'vertical'
  >('horizontal');
  const [textFontSize, setTextFontSize] = useState<number>(16);
  const [gridSize] = useState<number>(25);

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

  // Cargar mapa automáticamente cuando cambie el almacén seleccionado
  useEffect(() => {
    if (!selectedAlmacen) {
      setTexts([]);
      setTraps([]);
      setBackground(null);
      return;
    }

    router.get(
      '/mapas',
      { almacen_id: selectedAlmacen },
      {
        preserveState: true,
        preserveScroll: true,
        replace: true,
        onSuccess: (page) => {
          const mapaData = page.props.mapa as Props['mapa']; // ← casteamos al tipo correcto

          if (mapaData) {
            setTexts(mapaData.texts ?? []);
            setTraps(
              (mapaData.trampas ?? []).map((t) => ({
                ...t,
                tempId: uuidv4(), // generamos tempId para el frontend
              })),
            );
            setBackground(mapaData.background ?? null);
          } else {
            setTexts([]);
            setTraps([]);
            setBackground(null);
          }
        },
      },
    );
  }, [selectedAlmacen]);
  // useEffect(() => {
  //   if (!selectedAlmacen) {
  //     setTexts([]);
  //     setTraps([]);
  //     setBackground(null);
  //     return;
  //   }

  //   router.get(
  //     '/mapas',
  //     { almacen_id: selectedAlmacen },
  //     {
  //       preserveState: true,
  //       preserveScroll: true,
  //       replace: true,
  //       onSuccess: (page) => {
  //         const mapa = page.props.mapa;
  //         if (mapa) {
  //           setTexts(mapa.texts || []);
  //           setTraps(
  //             mapa.trampas.map((t: any) => ({
  //               ...t,
  //               tempId: uuidv4(), // Generamos tempId para drag en frontend
  //             })) || [],
  //           );
  //           setBackground(mapa.background);
  //         } else {
  //           // No hay mapa → canvas en blanco
  //           setTexts([]);
  //           setTraps([]);
  //           setBackground(null);
  //         }
  //       },
  //     },
  //   );
  // }, [selectedAlmacen]);

  // Cargar imágenes de trampas
  useEffect(() => {
    props.trampaTipos.forEach((tipo) => {
      if (tipo.imagen && !trapImagesRef.current[tipo.id]) {
        const img = new Image();
        img.src = tipo.imagen;
        img.crossOrigin = 'anonymous';
        trapImagesRef.current[tipo.id] = img;
      }
    });
  }, [props.trampaTipos]);

  // Filtro de almacenes por empresa
  useEffect(() => {
    if (selectedEmpresa) {
      const almacenesFiltrados = (props.allAlmacenes ?? []).filter(
        (a) => a.empresa_id === selectedEmpresa,
      );
      setFilteredAlmacenes(almacenesFiltrados);

      if (
        selectedAlmacen &&
        !almacenesFiltrados.some((a) => a.id === selectedAlmacen)
      ) {
        setSelectedAlmacen(null);
      }
    } else {
      setFilteredAlmacenes([]);
      setSelectedAlmacen(null);
    }
  }, [selectedEmpresa, props.allAlmacenes]);

  // Configuración del canvas
  useEffect(() => {
    const canvas = canvasRef.current;
    if (!canvas) return;
    canvas.width = CANVAS_WIDTH;
    canvas.height = CANVAS_HEIGHT;
    ctxRef.current = canvas.getContext('2d')!;
    redraw();
  }, []);

  useEffect(() => {
    console.log('******* ' + background);
    if (background) {
      console.log('vdvsdvsdv');
      const img = new Image();
      // img.src = '/storage/' + background;
      img.src = background;
      console.log(img);
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

    // Grid
    ctx.strokeStyle = '#e5e7eb';
    ctx.lineWidth = 1;
    for (let x = 0; x <= ctx.canvas.width; x += gridSize) {
      ctx.beginPath();
      ctx.moveTo(x, 0);
      ctx.lineTo(x, ctx.canvas.height);
      ctx.stroke();
    }
    for (let y = 0; y <= ctx.canvas.height; y += gridSize) {
      ctx.beginPath();
      ctx.moveTo(0, y);
      ctx.lineTo(ctx.canvas.width, y);
      ctx.stroke();
    }

    // Textos
    texts.forEach((t) => {
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
    });

    // Trampas con índice
    traps.forEach((trap, index) => {
      const img = trapImagesRef.current[trap.trampa_tipo_id];
      if (img?.complete) {
        ctx.drawImage(img, trap.posx - 22, trap.posy - 22, 44, 44);
      } else {
        ctx.fillStyle = '#9ca3af';
        ctx.fillRect(trap.posx - 22, trap.posy - 22, 44, 44);
        ctx.fillStyle = '#ef4444';
        ctx.font = 'bold 10px sans-serif';
        ctx.textAlign = 'center';
        ctx.fillText('?', trap.posx, trap.posy + 4);
      }

      const label = String(index + 1);
      ctx.save();
      ctx.beginPath();
      ctx.arc(trap.posx, trap.posy - 28, 14, 0, Math.PI * 2);
      ctx.fillStyle = '#15803d';
      ctx.fill();
      ctx.fillStyle = '#ffffff';
      ctx.font = 'bold 14px sans-serif';
      ctx.textAlign = 'center';
      ctx.textBaseline = 'middle';
      ctx.fillText(label, trap.posx, trap.posy - 28);
      ctx.restore();
    });
  };

  // Funciones de interacción con el canvas (mouse down, move, up, context menu)
  const getMousePos = (e: MouseEvent<HTMLCanvasElement>) => {
    const rect = canvasRef.current?.getBoundingClientRect();
    return {
      x: e.clientX - (rect?.left ?? 0),
      y: e.clientY - (rect?.top ?? 0),
    };
  };

  const handleMouseDown = (e: MouseEvent<HTMLCanvasElement>) => {
    if (!hasRole('admin') && !hasRole('superadmin')) return;
    if (!selectedAlmacen) return;

    const pos = getMousePos(e);

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

    const clickedTrap = traps.find(
      (t) => Math.hypot(t.posx - pos.x, t.posy - pos.y) < 15,
    );
    if (clickedTrap) {
      setDragging({
        type: 'trap',
        tempId: clickedTrap.tempId,
        offsetX: pos.x - clickedTrap.posx,
        offsetY: pos.y - clickedTrap.posy,
      });
      return;
    }

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
    } else if (typeof mode === 'number') {
      setTraps((prev) => [
        ...prev,
        {
          tempId: uuidv4(),
          trampa_tipo_id: mode,
          posx: pos.x,
          posy: pos.y,
          estado: 'activo',
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
          t.tempId === dragging.tempId
            ? {
                ...t,
                posx: pos.x - dragging.offsetX,
                posy: pos.y - dragging.offsetY,
              }
            : t,
        ),
      );
    }
    redraw();
  };

  const handleMouseUp = () => setDragging(null);

  const handleContextMenu = (e: MouseEvent<HTMLCanvasElement>) => {
    e.preventDefault();
    const pos = getMousePos(e);
    const clickedTrap = traps.find(
      (t) => Math.hypot(t.posx - pos.x, t.posy - pos.y) < 15,
    );
    if (clickedTrap && confirm('¿Eliminar esta trampa?')) {
      setTraps((prev) => prev.filter((t) => t.tempId !== clickedTrap.tempId));
    }
  };

  const saveDrawing = () => {
    if (!selectedAlmacen) {
      alert('Seleccione un almacén primero');
      return;
    }

    const isUpdate = !!props.mapa?.id;

    router[isUpdate ? 'put' : 'post'](
      isUpdate ? `/mapas/${props.mapa?.id}` : '/mapas',
      {
        empresa_id: selectedEmpresa,
        almacen_id: selectedAlmacen,
        background,
        texts,
        trampas: traps.map((t, index) => ({
          id: t.id,
          trampa_tipo_id: t.trampa_tipo_id,
          posx: Math.round(t.posx),
          posy: Math.round(t.posy),
          estado: t.estado ?? 'activo',
          numero: index + 1,
        })),
      },
      {
        preserveState: true,
        preserveScroll: true,
        onSuccess: () => {
          alert(`Mapa ${isUpdate ? 'actualizado' : 'creado'} exitosamente`);
        },
        onError: (errors) => {
          console.error(errors);
          alert('Error al guardar el mapa');
        },
      },
    );
  };

  const handleEmpresaChange = (value: string) => {
    setSelectedEmpresa(Number(value));
    setSelectedAlmacen(null); // Resetear almacén al cambiar empresa
  };

  const handleAlmacenChange = (value: string) => {
    setSelectedAlmacen(Number(value));
  };

  const handleBackgroundUpload = (e: ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (!file) return;
    const reader = new FileReader();
    reader.onload = (ev) => setBackground(ev.target?.result as string);
    reader.readAsDataURL(file);
  };

  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Editor de Mapa de Trampas" />

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

        {(hasRole('superadmin') || hasRole('admin')) && selectedAlmacen && (
          <div className="flex flex-wrap items-center gap-3">
            {/* Herramientas */}
            <Select
              value={mode.toString()}
              onValueChange={(v) =>
                setMode(
                  isNaN(Number(v)) ? (v as 'text' | 'textListed') : Number(v),
                )
              }
            >
              <SelectTrigger className="w-64">
                <SelectValue placeholder="Herramienta" />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="text">Agregar texto</SelectItem>
                <SelectItem value="textListed">
                  Agregar texto (listado)
                </SelectItem>
                {props.trampaTipos.map((tipo) => (
                  <SelectItem key={tipo.id} value={tipo.id.toString()}>
                    {tipo.nombre}
                  </SelectItem>
                ))}
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

            <div className="flex items-center gap-3">
              <Label>Fondo:</Label>
              <Input
                type="file"
                accept="image/*"
                onChange={handleBackgroundUpload}
                className="w-64"
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
              <Button
                variant="outline"
                onClick={() => setHistory((prev) => prev.slice(0, -1))}
              >
                Deshacer
              </Button>
              <Button
                variant="outline"
                onClick={() => {
                  setTexts([]);
                  setTraps([]);
                }}
              >
                Limpiar
              </Button>
              <Button onClick={saveDrawing}>
                {props.mapa?.id ? 'Actualizar Mapa' : 'Guardar Mapa'}
              </Button>
            </div>
          </div>
        )}

        <Card className="rounded-none border-muted py-2 shadow-muted">
          <CardContent className="overflow-auto p-0">
            <div className="mx-auto w-fit">
              <canvas
                ref={canvasRef}
                width={CANVAS_WIDTH}
                height={CANVAS_HEIGHT}
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
                      onChange={(e) =>
                        setTexts((prev) =>
                          prev.map((tx) =>
                            tx.id === t.id
                              ? { ...tx, text: e.target.value }
                              : tx,
                          ),
                        )
                      }
                      className="flex-1"
                    />
                    <Button
                      variant="destructive"
                      size="icon"
                      onClick={() =>
                        setTexts((prev) => prev.filter((tx) => tx.id !== t.id))
                      }
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
// --------------------------------------------------------
// // resources/js/Pages/Mapas/MapaEditor.tsx
// import { Button } from '@/components/ui/button';
// import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
// import { Input } from '@/components/ui/input';
// import { Label } from '@/components/ui/label';
// import {
//   Select,
//   SelectContent,
//   SelectItem,
//   SelectTrigger,
//   SelectValue,
// } from '@/components/ui/select';
// import { usePermissions } from '@/hooks/usePermissions';
// import AppLayout from '@/layouts/app-layout';
// import { type BreadcrumbItem } from '@/types';
// import { Head, router } from '@inertiajs/react';
// import {
//   ChangeEvent,
//   JSX,
//   MouseEvent,
//   useEffect,
//   useRef,
//   useState,
// } from 'react';
// import { v4 as uuidv4 } from 'uuid';

// const breadcrumbs: BreadcrumbItem[] = [{ title: 'Mapas', href: '/mapas' }];

// interface Empresa {
//   id: number;
//   nombre: string;
// }

// interface Almacen {
//   id: number;
//   nombre: string;
//   empresa_id: number;
// }

// interface TrampaTipo {
//   id: number;
//   nombre: string;
//   imagen: string | null;
// }

// type TextItem = {
//   id: string;
//   text: string;
//   x: number;
//   y: number;
//   listed: boolean;
//   vertical: boolean;
//   fontSize: number;
// };

// type Trap = {
//   tempId: string;
//   id?: number;
//   trampa_tipo_id: number;
//   posx: number;
//   posy: number;
//   estado?: string;
// };

// type Dragging =
//   | { type: 'text'; id: string; offsetX: number; offsetY: number }
//   | { type: 'trap'; tempId: string; offsetX: number; offsetY: number };

// interface Props {
//   empresas: Empresa[];
//   allAlmacenes: Almacen[];
//   trampaTipos: TrampaTipo[];
//   selectedEmpresa?: number | null;
//   selectedAlmacen?: number | null;
//   mapa?: {
//     id?: number;
//     background: string | null;
//     texts: TextItem[];
//     trampas: Trap[];
//   };
// }

// export default function MapaEditor(props: Props): JSX.Element {
//   console.log(props);

//   const { hasRole } = usePermissions();

//   const CANVAS_WIDTH = 1000;
//   const CANVAS_HEIGHT = 700;

//   const canvasRef = useRef<HTMLCanvasElement | null>(null);
//   const ctxRef = useRef<CanvasRenderingContext2D | null>(null);
//   const backgroundImageRef = useRef<HTMLImageElement | null>(null);
//   const trapImagesRef = useRef<Record<number, HTMLImageElement>>({});

//   const [mode, setMode] = useState<'text' | 'textListed' | number>('text');
//   const [textOrientation, setTextOrientation] = useState<
//     'horizontal' | 'vertical'
//   >('horizontal');
//   const [textFontSize, setTextFontSize] = useState<number>(16);
//   const [gridSize, setGridSize] = useState<number>(25);

//   const [texts, setTexts] = useState<TextItem[]>([]);
//   const [traps, setTraps] = useState<Trap[]>([]);
//   const [background, setBackground] = useState<string | null>(null);
//   const [history, setHistory] = useState<
//     { texts: TextItem[]; traps: Trap[] }[]
//   >([]);
//   const [dragging, setDragging] = useState<Dragging | null>(null);

//   const [selectedEmpresa, setSelectedEmpresa] = useState<number | null>(
//     props.selectedEmpresa ?? null,
//   );
//   const [filteredAlmacenes, setFilteredAlmacenes] = useState<Almacen[]>([]);
//   const [selectedAlmacen, setSelectedAlmacen] = useState<number | null>(
//     props.selectedAlmacen ?? null,
//   );

//   useEffect(() => {
//     if (props.mapa) {
//       setTexts(props.mapa.texts || []);
//       setTraps(props.mapa.trampas || []);
//       setBackground(props.mapa.background);
//     } else {
//       setTexts([]);
//       setTraps([]);
//       setBackground(null);
//     }
//     setHistory([]);
//   }, [props.mapa]);

//   useEffect(() => {
//     props.trampaTipos.forEach((tipo) => {
//       if (tipo.imagen && !trapImagesRef.current[tipo.id]) {
//         const img = new Image();
//         img.src = tipo.imagen;
//         img.crossOrigin = 'anonymous';
//         trapImagesRef.current[tipo.id] = img;
//       }
//     });
//   }, [props.trampaTipos]);

//   useEffect(() => {
//     if (selectedEmpresa) {
//       setFilteredAlmacenes(
//         props.allAlmacenes.filter((a) => a.empresa_id === selectedEmpresa),
//       );
//       if (
//         selectedAlmacen &&
//         !props.allAlmacenes.find(
//           (a) => a.id === selectedAlmacen && a.empresa_id === selectedEmpresa,
//         )
//       ) {
//         setSelectedAlmacen(null);
//       }
//     } else {
//       setFilteredAlmacenes([]);
//       setSelectedAlmacen(null);
//     }
//   }, [selectedEmpresa, props.allAlmacenes]);

//   useEffect(() => {
//     const canvas = canvasRef.current;
//     if (!canvas) return;
//     const ctx = canvas.getContext('2d');
//     if (!ctx) return;
//     ctxRef.current = ctx;

//     canvas.width = CANVAS_WIDTH;
//     canvas.height = CANVAS_HEIGHT;

//     redraw();
//   }, []);

//   useEffect(() => {
//     if (background) {
//       const img = new Image();
//       img.src = background;
//       img.onload = () => {
//         backgroundImageRef.current = img;
//         redraw();
//       };
//     } else {
//       backgroundImageRef.current = null;
//       redraw();
//     }
//   }, [background]);

//   useEffect(() => {
//     redraw();
//   }, [texts, traps, background]);

//   const saveHistory = () => {
//     setHistory((prev) => [...prev, { texts: [...texts], traps: [...traps] }]);
//   };

//   const undo = () => {
//     if (!history.length) return;
//     const last = history[history.length - 1];
//     setTexts(last.texts);
//     setTraps(last.traps);
//     setHistory(history.slice(0, -1));
//   };

//   const drawGrid = (ctx: CanvasRenderingContext2D) => {
//     const { width, height } = ctx.canvas;
//     ctx.strokeStyle = '#e5e7eb';
//     ctx.lineWidth = 1;
//     for (let x = 0; x <= width; x += gridSize) {
//       ctx.beginPath();
//       ctx.moveTo(x, 0);
//       ctx.lineTo(x, height);
//       ctx.stroke();
//     }
//     for (let y = 0; y <= height; y += gridSize) {
//       ctx.beginPath();
//       ctx.moveTo(0, y);
//       ctx.lineTo(width, y);
//       ctx.stroke();
//     }
//   };

//   const redraw = () => {
//     const ctx = ctxRef.current;
//     if (!ctx) return;
//     ctx.clearRect(0, 0, ctx.canvas.width, ctx.canvas.height);

//     if (backgroundImageRef.current) {
//       ctx.drawImage(
//         backgroundImageRef.current,
//         0,
//         0,
//         ctx.canvas.width,
//         ctx.canvas.height,
//       );
//     }

//     drawGrid(ctx);

//     texts.forEach((t) => {
//       ctx.fillStyle = t.listed ? '#111827' : '#6b7280';
//       ctx.font = `${t.fontSize}px sans-serif`;

//       if (t.vertical) {
//         ctx.save();
//         ctx.translate(t.x, t.y);
//         ctx.rotate(-Math.PI / 2);
//         ctx.fillText(t.text, 0, 0);
//         ctx.restore();
//       } else {
//         ctx.fillText(t.text, t.x, t.y);
//       }
//     });

//     traps.forEach((trap, index) => {
//       const img = trapImagesRef.current[trap.trampa_tipo_id];
//       if (img?.complete) {
//         ctx.drawImage(img, trap.posx - 22, trap.posy - 22, 44, 44);
//       } else {
//         ctx.fillStyle = '#9ca3af';
//         ctx.fillRect(trap.posx - 22, trap.posy - 22, 44, 44);
//         ctx.fillStyle = '#ef4444';
//         ctx.font = 'bold 10px sans-serif';
//         ctx.textAlign = 'center';
//         ctx.fillText('?', trap.posx, trap.posy + 4);
//       }

//       const label = String(index + 1);
//       ctx.save();
//       ctx.beginPath();
//       ctx.arc(trap.posx, trap.posy - 28, 14, 0, Math.PI * 2);
//       ctx.fillStyle = '#15803d';
//       ctx.fill();
//       ctx.fillStyle = '#ffffff';
//       ctx.font = 'bold 14px sans-serif';
//       ctx.textAlign = 'center';
//       ctx.textBaseline = 'middle';
//       ctx.fillText(label, trap.posx, trap.posy - 28);
//       ctx.restore();
//     });
//   };

//   const getMousePos = (e: MouseEvent<HTMLCanvasElement>) => {
//     const rect = canvasRef.current?.getBoundingClientRect();
//     return {
//       x: e.clientX - (rect?.left ?? 0),
//       y: e.clientY - (rect?.top ?? 0),
//     };
//   };

//   const handleMouseDown = (e: MouseEvent<HTMLCanvasElement>) => {
//     if (!hasRole('admin') && !hasRole('superadmin')) return;
//     if (!selectedAlmacen) return;

//     const pos = getMousePos(e);

//     const clickedText = texts.find(
//       (t) => Math.abs(t.x - pos.x) < 60 && Math.abs(t.y - pos.y) < 20,
//     );
//     if (clickedText) {
//       setDragging({
//         type: 'text',
//         id: clickedText.id,
//         offsetX: pos.x - clickedText.x,
//         offsetY: pos.y - clickedText.y,
//       } as { type: 'text'; id: string; offsetX: number; offsetY: number });
//       return;
//     }

//     const clickedTrap = traps.find(
//       (t) => Math.hypot(t.posx - pos.x, t.posy - pos.y) < 15,
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

//     saveHistory();

//     if (mode === 'text' || mode === 'textListed') {
//       const text = prompt('Ingrese el texto:');
//       if (!text) return;
//       setTexts((prev) => [
//         ...prev,
//         {
//           id: uuidv4(),
//           text,
//           x: pos.x,
//           y: pos.y,
//           listed: mode === 'textListed',
//           vertical: textOrientation === 'vertical',
//           fontSize: textFontSize,
//         },
//       ]);
//     } else if (typeof mode === 'number') {
//       setTraps((prev) => [
//         ...prev,
//         {
//           tempId: uuidv4(),
//           trampa_tipo_id: mode,
//           posx: pos.x,
//           posy: pos.y,
//           estado: 'activo',
//         },
//       ]);
//     }
//   };

//   const handleMouseMove = (e: MouseEvent<HTMLCanvasElement>) => {
//     if (!dragging) return;
//     const pos = getMousePos(e);

//     if (dragging.type === 'text') {
//       setTexts((prev) =>
//         prev.map((t) =>
//           t.id === dragging.id
//             ? { ...t, x: pos.x - dragging.offsetX, y: pos.y - dragging.offsetY }
//             : t,
//         ),
//       );
//     } else if (dragging.type === 'trap') {
//       setTraps((prev) =>
//         prev.map((t) =>
//           t.tempId === dragging.tempId
//             ? {
//                 ...t,
//                 posx: pos.x - dragging.offsetX,
//                 posy: pos.y - dragging.offsetY,
//               }
//             : t,
//         ),
//       );
//     }

//     redraw();
//   };

//   const handleMouseUp = () => {
//     if (dragging) {
//       setDragging(null);
//     }
//   };

//   const handleContextMenu = (e: MouseEvent<HTMLCanvasElement>) => {
//     e.preventDefault();

//     const pos = getMousePos(e);

//     const clickedTrap = traps.find(
//       (t) => Math.hypot(t.posx - pos.x, t.posy - pos.y) < 15,
//     );

//     if (clickedTrap) {
//       const confirmDelete = confirm('¿Eliminar esta trampa?');
//       if (confirmDelete) {
//         setTraps((prev) => prev.filter((t) => t.tempId !== clickedTrap.tempId));
//       }
//     }
//   };

//   const clearCanvas = () => {
//     saveHistory();
//     setTexts([]);
//     setTraps([]);
//   };

//   const saveDrawing = () => {
//     if (!selectedAlmacen) {
//       alert('Seleccione un almacén primero');
//       return;
//     }

//     const isUpdate = !!props.mapa?.id;

//     router.post(
//       '/mapas',
//       {
//         mapa_id: props.mapa?.id,
//         empresa_id: selectedEmpresa,
//         almacen_id: selectedAlmacen,
//         texts,
//         trampas: traps.map((t, index) => ({
//           id: t.id,
//           trampa_tipo_id: t.trampa_tipo_id,
//           posx: Math.round(t.posx),
//           posy: Math.round(t.posy),
//           estado: t.estado ?? 'activo',
//           numero: index + 1,
//         })),
//         background,
//       },
//       {
//         preserveState: true,
//         onSuccess: () => {
//           alert('Mapa guardado exitosamente');
//         },
//         onError: (errors) => {
//           console.error(errors);
//           alert('Error al guardar el mapa');
//         },
//       },
//     );
//   };

//   const updateText = (id: string, newText: string) => {
//     setTexts((prev) =>
//       prev.map((t) => (t.id === id ? { ...t, text: newText } : t)),
//     );
//   };

//   const deleteText = (id: string) => {
//     saveHistory();
//     setTexts((prev) => prev.filter((t) => t.id !== id));
//   };

//   const handleBackgroundUpload = (e: ChangeEvent<HTMLInputElement>) => {
//     const file = e.target.files?.[0];
//     if (!file) return;
//     const reader = new FileReader();
//     reader.onload = (ev) => setBackground(ev.target?.result as string);
//     reader.readAsDataURL(file);
//   };

//   const handleEmpresaChange = (value: string) => {
//     const empresaId = Number(value);
//     setSelectedEmpresa(empresaId);
//   };

//   const handleAlmacenChange = (value: string) => {
//     const almacenId = Number(value);
//     setSelectedAlmacen(almacenId);
//     router.get(
//       '/mapas',
//       {
//         empresa_id: selectedEmpresa,
//         almacen_id: almacenId,
//       },
//       {
//         preserveState: true,
//         replace: true,
//       },
//     );
//   };

//   return (
//     <AppLayout breadcrumbs={breadcrumbs}>
//       <Head title="Mapas de Control de Plagas" />

//       <div className="space-y-6 p-6">
//         <h1 className="text-2xl font-bold">Gestión de Mapas de Trampas</h1>

//         <div className="flex flex-wrap gap-6">
//           <div>
//             <Label>Empresa</Label>
//             <Select
//               value={selectedEmpresa?.toString() ?? ''}
//               onValueChange={handleEmpresaChange}
//             >
//               <SelectTrigger className="w-72">
//                 <SelectValue placeholder="Seleccione empresa" />
//               </SelectTrigger>
//               <SelectContent>
//                 {props.empresas.map((e) => (
//                   <SelectItem key={e.id} value={e.id.toString()}>
//                     {e.nombre}
//                   </SelectItem>
//                 ))}
//               </SelectContent>
//             </Select>
//           </div>

//           <div>
//             <Label>Almacén</Label>
//             <Select
//               value={selectedAlmacen?.toString() ?? ''}
//               onValueChange={handleAlmacenChange}
//               disabled={!selectedEmpresa}
//             >
//               <SelectTrigger className="w-72">
//                 <SelectValue placeholder="Seleccione almacén" />
//               </SelectTrigger>
//               <SelectContent>
//                 {filteredAlmacenes.map((a) => (
//                   <SelectItem key={a.id} value={a.id.toString()}>
//                     {a.nombre}
//                   </SelectItem>
//                 ))}
//               </SelectContent>
//             </Select>
//           </div>
//         </div>

//         {(hasRole('superadmin') || hasRole('admin')) && (
//           <div className="flex flex-wrap items-center gap-3">
//             <Select
//               value={mode.toString()}
//               onValueChange={(v) =>
//                 setMode(
//                   isNaN(Number(v)) ? (v as 'text' | 'textListed') : Number(v),
//                 )
//               }
//             >
//               <SelectTrigger className="w-64">
//                 <SelectValue placeholder="Herramienta" />
//               </SelectTrigger>
//               <SelectContent>
//                 <SelectItem value="text">Agregar texto</SelectItem>
//                 <SelectItem value="textListed">
//                   Agregar texto (listado)
//                 </SelectItem>
//                 {props.trampaTipos.map((tipo) => (
//                   <SelectItem key={tipo.id} value={tipo.id.toString()}>
//                     {tipo.nombre}
//                   </SelectItem>
//                 ))}
//               </SelectContent>
//             </Select>

//             {(mode === 'text' || mode === 'textListed') && (
//               <>
//                 <Select
//                   value={textOrientation}
//                   onValueChange={(v) =>
//                     setTextOrientation(v as 'horizontal' | 'vertical')
//                   }
//                 >
//                   <SelectTrigger className="w-36">
//                     <SelectValue placeholder="Orientación" />
//                   </SelectTrigger>
//                   <SelectContent>
//                     <SelectItem value="horizontal">Horizontal</SelectItem>
//                     <SelectItem value="vertical">Vertical</SelectItem>
//                   </SelectContent>
//                 </Select>

//                 <div className="flex items-center gap-2">
//                   <Label>Tamaño:</Label>
//                   <Input
//                     type="number"
//                     value={textFontSize}
//                     onChange={(e) => setTextFontSize(Number(e.target.value))}
//                     className="w-20"
//                     min={8}
//                     max={48}
//                   />
//                 </div>
//               </>
//             )}

//             <div className="flex items-center gap-3">
//               <Label>Fondo:</Label>
//               <Input
//                 type="file"
//                 accept="image/*"
//                 onChange={handleBackgroundUpload}
//                 className="w-64"
//                 disabled={!selectedAlmacen}
//               />
//               {background && (
//                 <Button
//                   variant="outline"
//                   size="sm"
//                   onClick={() => setBackground(null)}
//                 >
//                   Quitar fondo
//                 </Button>
//               )}
//             </div>

//             <div className="flex gap-2">
//               <Button variant="outline" onClick={undo}>
//                 Deshacer
//               </Button>
//               <Button variant="outline" onClick={clearCanvas}>
//                 Limpiar
//               </Button>
//               <Button onClick={saveDrawing} disabled={!selectedAlmacen}>
//                 Guardar mapa
//               </Button>
//             </div>
//           </div>
//         )}

//         <Card className="rounded-none border-muted py-2 shadow-muted">
//           <CardContent className="overflow-auto p-0">
//             <div className="mx-auto w-fit">
//               <canvas
//                 ref={canvasRef}
//                 width={CANVAS_WIDTH}
//                 height={CANVAS_HEIGHT}
//                 className="h-[700px] w-[1000px] cursor-crosshair touch-none border bg-white"
//                 onMouseDown={handleMouseDown}
//                 onMouseMove={handleMouseMove}
//                 onMouseUp={handleMouseUp}
//                 onMouseLeave={handleMouseUp}
//                 onContextMenu={handleContextMenu}
//               />
//             </div>
//           </CardContent>
//         </Card>

//         {texts.filter((t) => t.listed).length > 0 && (
//           <Card>
//             <CardHeader>
//               <CardTitle>Elementos listados</CardTitle>
//             </CardHeader>
//             <CardContent className="space-y-2">
//               {texts
//                 .filter((t) => t.listed)
//                 .map((t) => (
//                   <div
//                     key={t.id}
//                     className="flex items-center gap-3 border-b pb-2"
//                   >
//                     <Input
//                       value={t.text}
//                       onChange={(e) => updateText(t.id, e.target.value)}
//                       className="flex-1"
//                     />
//                     <Button
//                       variant="destructive"
//                       size="icon"
//                       onClick={() => deleteText(t.id)}
//                     >
//                       ×
//                     </Button>
//                   </div>
//                 ))}
//             </CardContent>
//           </Card>
//         )}
//       </div>
//     </AppLayout>
//   );
// }

//------------------------------------------------------------------
// // resources/js/Pages/Mapas/MapaEditor.tsx
// import { Button } from '@/components/ui/button';
// import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
// import { Input } from '@/components/ui/input';
// import { Label } from '@/components/ui/label';
// import {
//   Select,
//   SelectContent,
//   SelectItem,
//   SelectTrigger,
//   SelectValue,
// } from '@/components/ui/select';
// import { usePermissions } from '@/hooks/usePermissions';
// import AppLayout from '@/layouts/app-layout';
// import { type BreadcrumbItem } from '@/types';
// import { Head, router } from '@inertiajs/react';
// import {
//   ChangeEvent,
//   JSX,
//   MouseEvent,
//   useEffect,
//   useRef,
//   useState,
// } from 'react';
// import { v4 as uuidv4 } from 'uuid';

// const breadcrumbs: BreadcrumbItem[] = [{ title: 'Mapas', href: '/mapas' }];

// interface Empresa {
//   id: number;
//   nombre: string;
// }

// interface Almacen {
//   id: number;
//   nombre: string;
//   empresa_id: number;
// }

// type TextItem = {
//   id: string;
//   text: string;
//   x: number;
//   y: number;
//   listed: boolean;
//   vertical: boolean;
//   fontSize: number;
// };

// type Trap = {
//   id: string;
//   type: 'mouse' | 'insect' | 'caja' | 'viva' | 'pegajosa';
//   x: number;
//   y: number;
// };

// type Dragging =
//   | { type: 'text'; id: string; offsetX: number; offsetY: number }
//   | { type: 'trap'; id: string; offsetX: number; offsetY: number };

// interface Props {
//   empresas: Empresa[];
//   allAlmacenes: Almacen[];
//   selectedEmpresa?: number | null;
//   selectedAlmacen?: number | null;
//   mapa?: {
//     texts: TextItem[];
//     traps: Trap[];
//     background: string | null;
//   };
// }

// export default function MapaEditor(props: Props): JSX.Element {
//   const { hasRole, hasAnyRole, hasPermission } = usePermissions();

//   const CANVAS_WIDTH = 1000;
//   const CANVAS_HEIGHT = 700;

//   const canvasRef = useRef<HTMLCanvasElement | null>(null);
//   const ctxRef = useRef<CanvasRenderingContext2D | null>(null);
//   const backgroundImageRef = useRef<HTMLImageElement | null>(null);

//   const insectTrapImageRef = useRef<HTMLImageElement>(new Image());
//   const mouseTrapImageRef = useRef<HTMLImageElement>(new Image());
//   const cajaTrapImageRef = useRef<HTMLImageElement>(new Image());
//   const vivaTrapImageRef = useRef<HTMLImageElement>(new Image());
//   const pegajosaTrapImageRef = useRef<HTMLImageElement>(new Image());

//   const [mode, setMode] = useState<
//     | 'text'
//     | 'textListed'
//     | 'mouseTrap'
//     | 'insectTrap'
//     | 'cajaTrap'
//     | 'vivaTrap'
//     | 'pegajosaTrap'
//   >('text');
//   const [textOrientation, setTextOrientation] = useState<
//     'horizontal' | 'vertical'
//   >('horizontal');
//   const [textFontSize, setTextFontSize] = useState<number>(16);
//   const [gridSize, setGridSize] = useState<number>(25);

//   const [texts, setTexts] = useState<TextItem[]>([]);
//   const [traps, setTraps] = useState<Trap[]>([]);
//   const [background, setBackground] = useState<string | null>(null);
//   const [history, setHistory] = useState<
//     { texts: TextItem[]; traps: Trap[] }[]
//   >([]);
//   const [dragging, setDragging] = useState<Dragging | null>(null);

//   const [selectedEmpresa, setSelectedEmpresa] = useState<number | null>(
//     props.selectedEmpresa ?? null,
//   );
//   const [filteredAlmacenes, setFilteredAlmacenes] = useState<Almacen[]>([]);
//   const [selectedAlmacen, setSelectedAlmacen] = useState<number | null>(
//     props.selectedAlmacen ?? null,
//   );

//   const deleteTrap = (id: string) => {
//     saveHistory();
//     setTraps((prev) => prev.filter((t) => t.id !== id));
//   };

//   const handleContextMenu = (e: MouseEvent<HTMLCanvasElement>) => {
//     e.preventDefault();

//     const pos = getMousePos(e);

//     const clickedTrap = traps.find(
//       (t) => Math.hypot(t.x - pos.x, t.y - pos.y) < 15,
//     );

//     if (clickedTrap) {
//       const confirmDelete = confirm('¿Eliminar esta trampa?');
//       if (confirmDelete) {
//         deleteTrap(clickedTrap.id);
//       }
//     }
//   };

//   useEffect(() => {
//     mouseTrapImageRef.current.src = '/images/trampas/trampa_raton.jpg';
//     insectTrapImageRef.current.src = '/images/trampas/trampa_insecto.jpg';
//     cajaTrapImageRef.current.src = '/images/trampas/caja_negra.jpg';
//     vivaTrapImageRef.current.src = '/images/trampas/captura_viva.jpg';
//     pegajosaTrapImageRef.current.src = '/images/trampas/pegajosa.png';
//   }, []);

//   useEffect(() => {
//     if (selectedEmpresa) {
//       setFilteredAlmacenes(
//         props.allAlmacenes.filter((a) => a.empresa_id === selectedEmpresa),
//       );
//       if (
//         selectedAlmacen &&
//         !props.allAlmacenes.find(
//           (a) => a.id === selectedAlmacen && a.empresa_id === selectedEmpresa,
//         )
//       ) {
//         setSelectedAlmacen(null);
//       }
//     } else {
//       setFilteredAlmacenes([]);
//       setSelectedAlmacen(null);
//     }
//   }, [selectedEmpresa, props.allAlmacenes]);

//   useEffect(() => {
//     if (props.mapa) {
//       setTexts(props.mapa.texts || []);
//       setTraps(props.mapa.traps || []);
//       setBackground(props.mapa.background);
//     } else {
//       setTexts([]);
//       setTraps([]);
//       setBackground(null);
//     }
//     setHistory([]);
//   }, [props.mapa]);

//   useEffect(() => {
//     const canvas = canvasRef.current;
//     if (!canvas) return;
//     const ctx = canvas.getContext('2d');
//     if (!ctx) return;
//     ctxRef.current = ctx;

//     // Tamaño fijo REAL del canvas
//     canvas.width = CANVAS_WIDTH;
//     canvas.height = CANVAS_HEIGHT;

//     redraw();
//   }, []);

//   useEffect(() => {
//     if (background) {
//       const img = new Image();
//       img.src = background;
//       img.onload = () => {
//         backgroundImageRef.current = img;
//         redraw();
//       };
//     } else {
//       backgroundImageRef.current = null;
//       redraw();
//     }
//   }, [background]);

//   useEffect(() => {
//     redraw();
//   }, [texts, traps, background]);

//   const resizeCanvas = () => {
//     const canvas = canvasRef.current;
//     if (!canvas || !ctxRef.current) return;
//     const rect = canvas.getBoundingClientRect();
//     canvas.width = rect.width;
//     canvas.height = rect.height;
//     redraw();
//   };

//   const saveHistory = () => {
//     setHistory((prev) => [...prev, { texts: [...texts], traps: [...traps] }]);
//   };

//   const undo = () => {
//     if (!history.length) return;
//     const last = history[history.length - 1];
//     setTexts(last.texts);
//     setTraps(last.traps);
//     setHistory(history.slice(0, -1));
//   };

//   const drawGrid = (ctx: CanvasRenderingContext2D) => {
//     const { width, height } = ctx.canvas;
//     ctx.strokeStyle = '#e5e7eb';
//     ctx.lineWidth = 1;
//     for (let x = 0; x <= width; x += gridSize) {
//       ctx.beginPath();
//       ctx.moveTo(x, 0);
//       ctx.lineTo(x, height);
//       ctx.stroke();
//     }
//     for (let y = 0; y <= height; y += gridSize) {
//       ctx.beginPath();
//       ctx.moveTo(0, y);
//       ctx.lineTo(width, y);
//       ctx.stroke();
//     }
//   };

//   const redraw = () => {
//     const ctx = ctxRef.current;
//     if (!ctx) return;
//     ctx.clearRect(0, 0, ctx.canvas.width, ctx.canvas.height);

//     if (backgroundImageRef.current) {
//       ctx.drawImage(
//         backgroundImageRef.current,
//         0,
//         0,
//         ctx.canvas.width,
//         ctx.canvas.height,
//       );
//     }

//     drawGrid(ctx);

//     texts.forEach((t) => drawText(ctx, t));
//     // traps.forEach((t) => drawTrap(ctx, t));
//     traps.forEach((t, index) => drawTrap(ctx, t, index));
//   };

//   const drawText = (ctx: CanvasRenderingContext2D, t: TextItem) => {
//     ctx.fillStyle = t.listed ? '#111827' : '#6b7280';
//     ctx.font = `${t.fontSize}px sans-serif`;

//     if (t.vertical) {
//       ctx.save();
//       ctx.translate(t.x, t.y);
//       ctx.rotate(-Math.PI / 2);
//       ctx.fillText(t.text, 0, 0);
//       ctx.restore();
//     } else {
//       ctx.fillText(t.text, t.x, t.y);
//     }
//   };

//   // const drawTrap = (ctx: CanvasRenderingContext2D, trap: Trap) => {
//   //   const img =
//   //     trap.type === 'mouse'
//   //       ? mouseTrapImageRef.current
//   //       : insectTrapImageRef.current;
//   //   if (img.complete) {
//   //     ctx.drawImage(img, trap.x - 15, trap.y - 15, 45, 45);
//   //   }
//   // };

//   const drawTrap = (
//     ctx: CanvasRenderingContext2D,
//     trap: Trap,
//     index: number,
//   ) => {
//     // const img =
//     //   trap.type === 'mouse'
//     //     ? mouseTrapImageRef.current
//     //     : insectTrapImageRef.current;

//     // const trapImageRefs = {
//     //   mouse: mouseTrapImageRef,
//     //   insect: insectTrapImageRef,
//     //   caja: cajaTrapImageRef,
//     //   viva: vivaTrapImageRef,
//     //   pegajosa: pegajosaTrapImageRef
//     // }
//     // const img = trapImageRefs[trap.type]?.current;

//     const img =
//       trap.type === 'mouse'
//         ? mouseTrapImageRef.current
//         : trap.type === 'insect'
//           ? insectTrapImageRef.current
//           : trap.type === 'caja'
//             ? cajaTrapImageRef.current
//             : trap.type === 'viva'
//               ? vivaTrapImageRef.current
//               : pegajosaTrapImageRef.current;

//     // Dibujo de la trampa
//     if (img.complete) {
//       ctx.drawImage(img, trap.x - 15, trap.y - 15, 45, 45);
//     }

//     // ===== DIBUJAR ÍNDICE =====
//     const label = String(index + 1);

//     ctx.save();

//     // Fondo circular
//     ctx.beginPath();
//     ctx.arc(trap.x, trap.y - 22, 10, 0, Math.PI * 2);
//     // ctx.fillStyle = '#111827'; // gris oscuro
//     ctx.fillStyle = '#0f0'; // gris oscuro
//     ctx.fill();

//     // Texto del índice
//     // ctx.fillStyle = '#ffffff';
//     ctx.fillStyle = '#f00';
//     ctx.font = '12px sans-serif';
//     ctx.textAlign = 'center';
//     ctx.textBaseline = 'middle';
//     ctx.fillText(label, trap.x, trap.y - 22);

//     ctx.restore();
//   };

//   const getMousePos = (e: MouseEvent<HTMLCanvasElement>) => {
//     const rect = canvasRef.current?.getBoundingClientRect();
//     return {
//       x: e.clientX - (rect?.left ?? 0),
//       y: e.clientY - (rect?.top ?? 0),
//     };
//   };

//   const handleMouseDown = (e: MouseEvent<HTMLCanvasElement>) => {
//     if (!hasRole('admin') || !hasRole('superadmin')) return;

//     if (!selectedAlmacen) return;

//     const pos = getMousePos(e);

//     // Buscar texto clickeado
//     const clickedText = texts.find(
//       (t) => Math.abs(t.x - pos.x) < 60 && Math.abs(t.y - pos.y) < 20,
//     );
//     if (clickedText) {
//       setDragging({
//         type: 'text',
//         id: clickedText.id,
//         offsetX: pos.x - clickedText.x,
//         offsetY: pos.y - clickedText.y,
//       });
//       return;
//     }

//     // Buscar trampa clickeada
//     const clickedTrap = traps.find(
//       (t) => Math.hypot(t.x - pos.x, t.y - pos.y) < 15,
//     );
//     if (clickedTrap) {
//       setDragging({
//         type: 'trap',
//         id: clickedTrap.id,
//         offsetX: pos.x - clickedTrap.x,
//         offsetY: pos.y - clickedTrap.y,
//       });
//       return;
//     }

//     // Agregar nuevo elemento
//     saveHistory();

//     if (mode === 'text' || mode === 'textListed') {
//       const text = prompt('Ingrese el texto:');
//       if (!text) return;
//       setTexts((prev) => [
//         ...prev,
//         {
//           id: uuidv4(),
//           text,
//           x: pos.x,
//           y: pos.y,
//           listed: mode === 'textListed',
//           vertical: textOrientation === 'vertical',
//           fontSize: textFontSize,
//         },
//       ]);
//     } else if (
//       mode === 'mouseTrap' ||
//       mode === 'insectTrap' ||
//       mode === 'cajaTrap' ||
//       mode === 'vivaTrap' ||
//       mode === 'pegajosaTrap'
//     ) {
//       setTraps((prev) => [
//         ...prev,
//         {
//           id: uuidv4(),
//           // type: mode === 'mouseTrap' ? 'mouse' : 'insect',
//           type:
//             mode === 'mouseTrap'
//               ? 'mouse'
//               : mode === 'insectTrap'
//                 ? 'insect'
//                 : mode === 'cajaTrap'
//                   ? 'caja'
//                   : mode === 'vivaTrap'
//                     ? 'viva'
//                     : 'pegajosa',
//           x: pos.x,
//           y: pos.y,
//         },
//       ]);
//     }
//   };

//   const handleMouseMove = (e: MouseEvent<HTMLCanvasElement>) => {
//     if (!dragging) return;
//     const pos = getMousePos(e);

//     if (dragging.type === 'text') {
//       setTexts((prev) =>
//         prev.map((t) =>
//           t.id === dragging.id
//             ? { ...t, x: pos.x - dragging.offsetX, y: pos.y - dragging.offsetY }
//             : t,
//         ),
//       );
//     } else if (dragging.type === 'trap') {
//       setTraps((prev) =>
//         prev.map((t) =>
//           t.id === dragging.id
//             ? { ...t, x: pos.x - dragging.offsetX, y: pos.y - dragging.offsetY }
//             : t,
//         ),
//       );
//     }

//     redraw();
//   };

//   const handleMouseUp = () => {
//     if (dragging) {
//       setDragging(null);
//     }
//   };

//   const clearCanvas = () => {
//     saveHistory();
//     setTexts([]);
//     setTraps([]);
//   };

//   const saveDrawing = () => {
//     if (!selectedAlmacen) {
//       alert('Seleccione un almacén primero');
//       return;
//     }

//     // Preparar datos de trampas para el formato de BD
//     const trapsParaGuardar = traps.map((trap, index) => ({
//       almacen_id: selectedAlmacen,
//       posx: Math.round(trap.x), // o trap.x si aceptas decimales
//       posy: Math.round(trap.y),
//       tipo: trap.type, // 'mouse', 'insect', 'caja', 'viva', 'pegajosa'
//       numero: index + 1, // muy útil para identificarlas en reportes
//       estado: 'activo', // ← valor por defecto que tú decidas
//     }));

//     router.post(
//       'mapas',
//       {
//         empresa_id: selectedEmpresa,
//         almacen_id: selectedAlmacen,
//         texts,
//         traps,
//         trapsG: trapsParaGuardar,
//         background,
//       },
//       {
//         preserveState: true,
//         onSuccess: () => {
//           alert('Mapa guardado exitosamente');
//         },
//         onError: (errors) => {
//           console.error(errors);
//           alert('Error al guardar el mapa');
//         },
//       },
//     );
//   };

//   const updateText = (id: string, newText: string) => {
//     setTexts((prev) =>
//       prev.map((t) => (t.id === id ? { ...t, text: newText } : t)),
//     );
//   };

//   const deleteText = (id: string) => {
//     saveHistory();
//     setTexts((prev) => prev.filter((t) => t.id !== id));
//   };

//   const handleBackgroundUpload = (e: ChangeEvent<HTMLInputElement>) => {
//     const file = e.target.files?.[0];
//     if (!file) return;
//     const reader = new FileReader();
//     reader.onload = (ev) => setBackground(ev.target?.result as string);
//     reader.readAsDataURL(file);
//   };

//   const handleEmpresaChange = (value: string) => {
//     const empresaId = Number(value);
//     setSelectedEmpresa(empresaId);
//   };

//   const handleAlmacenChange = (value: string) => {
//     const almacenId = Number(value);
//     setSelectedAlmacen(almacenId);
//     router.get(
//       'mapas',
//       {
//         empresa_id: selectedEmpresa,
//         almacen_id: almacenId,
//       },
//       {
//         preserveState: true,
//         replace: true,
//       },
//     );
//   };

//   return (
//     <AppLayout breadcrumbs={breadcrumbs}>
//       <Head title="Mapas de Control de Plagas" />

//       <div className="space-y-6 p-6">
//         <h1 className="text-2xl font-bold">Gestión de Mapas de Trampas</h1>

//         <div className="flex flex-wrap gap-6">
//           <div>
//             <Label>Empresa</Label>
//             <Select
//               value={selectedEmpresa?.toString() ?? ''}
//               onValueChange={handleEmpresaChange}
//             >
//               <SelectTrigger className="w-72">
//                 <SelectValue placeholder="Seleccione empresa" />
//               </SelectTrigger>
//               <SelectContent>
//                 {props.empresas.map((e) => (
//                   <SelectItem key={e.id} value={e.id.toString()}>
//                     {e.nombre}
//                   </SelectItem>
//                 ))}
//               </SelectContent>
//             </Select>
//           </div>

//           <div>
//             <Label>Almacén</Label>
//             <Select
//               value={selectedAlmacen?.toString() ?? ''}
//               onValueChange={handleAlmacenChange}
//               disabled={!selectedEmpresa}
//             >
//               <SelectTrigger className="w-72">
//                 <SelectValue placeholder="Seleccione almacén" />
//               </SelectTrigger>
//               <SelectContent>
//                 {filteredAlmacenes.map((a) => (
//                   <SelectItem key={a.id} value={a.id.toString()}>
//                     {a.nombre}
//                   </SelectItem>
//                 ))}
//               </SelectContent>
//             </Select>
//           </div>
//         </div>

//         {(hasRole('superadmin') || hasRole('admin')) && (
//           <div className="flex flex-wrap items-center gap-3">
//             <Select value={mode} onValueChange={(v) => setMode(v as any)}>
//               <SelectTrigger className="w-64">
//                 <SelectValue placeholder="Herramienta" />
//               </SelectTrigger>
//               <SelectContent>
//                 <SelectItem value="text">Agregar texto</SelectItem>
//                 <SelectItem value="textListed">
//                   Agregar texto (listado)
//                 </SelectItem>
//                 <SelectItem value="mouseTrap">Trampa para ratones</SelectItem>
//                 <SelectItem value="insectTrap">Trampa para insectos</SelectItem>
//                 <SelectItem value="cajaTrap">Trampa Caja</SelectItem>
//                 <SelectItem value="vivaTrap">Trampa viva</SelectItem>
//                 <SelectItem value="pegajosaTrap">Trampa Pegajosa</SelectItem>
//               </SelectContent>
//             </Select>

//             {(mode === 'text' || mode === 'textListed') && (
//               <>
//                 <Select
//                   value={textOrientation}
//                   onValueChange={(v) => setTextOrientation(v as any)}
//                 >
//                   <SelectTrigger className="w-36">
//                     <SelectValue placeholder="Orientación" />
//                   </SelectTrigger>
//                   <SelectContent>
//                     <SelectItem value="horizontal">Horizontal</SelectItem>
//                     <SelectItem value="vertical">Vertical</SelectItem>
//                   </SelectContent>
//                 </Select>

//                 <div className="flex items-center gap-2">
//                   <Label>Tamaño:</Label>
//                   <Input
//                     type="number"
//                     value={textFontSize}
//                     onChange={(e) => setTextFontSize(Number(e.target.value))}
//                     className="w-20"
//                     min={8}
//                     max={48}
//                   />
//                 </div>
//               </>
//             )}

//             {/* <div className="flex items-center gap-2">
//             <span>Grid:</span>
//             <Input
//               type="number"
//               value={gridSize}
//               onChange={(e) => setGridSize(Number(e.target.value))}
//               className="w-20"
//               min={10}
//               step={5}
//             />
//           </div> */}

//             <div className="flex items-center gap-3">
//               <Label>Fondo:</Label>
//               <Input
//                 type="file"
//                 accept="image/*"
//                 onChange={handleBackgroundUpload}
//                 className="w-64"
//                 disabled={!selectedAlmacen}
//               />
//               {background && (
//                 <Button
//                   variant="outline"
//                   size="sm"
//                   onClick={() => setBackground(null)}
//                 >
//                   Quitar fondo
//                 </Button>
//               )}
//             </div>

//             <div className="flex gap-2">
//               <Button variant="outline" onClick={undo}>
//                 Deshacer
//               </Button>
//               <Button variant="outline" onClick={clearCanvas}>
//                 Limpiar
//               </Button>
//               <Button onClick={saveDrawing} disabled={!selectedAlmacen}>
//                 Guardar mapa
//               </Button>
//             </div>
//           </div>
//         )}

//         <Card className="rounded-none border-muted py-2 shadow-muted">
//           <CardContent className="overflow-auto p-0">
//             <div className="mx-auto w-fit">
//               <canvas
//                 ref={canvasRef}
//                 width={CANVAS_WIDTH}
//                 height={CANVAS_HEIGHT}
//                 // className="h-[700px] w-full cursor-crosshair touch-none bg-white"
//                 className="h-[700px] w-[1000px] cursor-crosshair touch-none border bg-white"
//                 onMouseDown={handleMouseDown}
//                 onMouseMove={handleMouseMove}
//                 onMouseUp={handleMouseUp}
//                 onMouseLeave={handleMouseUp}
//                 onContextMenu={handleContextMenu}
//               />
//             </div>
//           </CardContent>
//         </Card>

//         {texts.filter((t) => t.listed).length > 0 && (
//           <Card>
//             <CardHeader>
//               <CardTitle>Elementos listados</CardTitle>
//             </CardHeader>
//             <CardContent className="space-y-2">
//               {texts
//                 .filter((t) => t.listed)
//                 .map((t) => (
//                   <div
//                     key={t.id}
//                     className="flex items-center gap-3 border-b pb-2"
//                   >
//                     <Input
//                       value={t.text}
//                       onChange={(e) => updateText(t.id, e.target.value)}
//                       className="flex-1"
//                     />
//                     <Button
//                       variant="destructive"
//                       size="icon"
//                       onClick={() => deleteText(t.id)}
//                     >
//                       ×
//                     </Button>
//                   </div>
//                 ))}
//             </CardContent>
//           </Card>
//         )}
//       </div>
//     </AppLayout>
//   );
// }
