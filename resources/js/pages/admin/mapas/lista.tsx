'use client';

import { usePermissions } from '@/hooks/usePermissions';
import AppLayout from '@/layouts/app-layout';
import { type BreadcrumbItem } from '@/types';
import { Head, router } from '@inertiajs/react';

import { Button } from '@/components/ui/button';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Label } from '@/components/ui/label';
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select';

// import CanvasEditor, { MapEditorState } from '@/Components/CanvasEditor';

import { useEffect, useState } from 'react';
import { v4 as uuidv4 } from 'uuid';
import CanvasEditor, { MapEditorState } from './CanvasEditor';

/* =======================
   Tipos
======================= */

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

interface Props {
  empresas: Empresa[];
  allAlmacenes: Almacen[];
  trampaTipos: TrampaTipo[];
  selectedEmpresa?: number | null;
  selectedAlmacen?: number | null;
  mapas?: {
    id: number;
    background: string | null;
    texts: any[];
    trampas: any[];
  }[];
}

const breadcrumbs: BreadcrumbItem[] = [{ title: 'Mapas', href: '/mapas' }];

/* =======================
   Componente
======================= */

export default function MapaEditor(props: Props) {
  const { hasRole } = usePermissions();

  const [selectedEmpresa, setSelectedEmpresa] = useState<number | null>(
    props.selectedEmpresa ?? null,
  );
  const [selectedAlmacen, setSelectedAlmacen] = useState<number | null>(
    props.selectedAlmacen ?? null,
  );
  const [filteredAlmacenes, setFilteredAlmacenes] = useState<Almacen[]>([]);
  const [mapEditors, setMapEditors] = useState<MapEditorState[]>([]);

  /* =======================
     Filtro almacenes
  ======================= */

  useEffect(() => {
    if (!selectedEmpresa) {
      setFilteredAlmacenes([]);
      setSelectedAlmacen(null);
      return;
    }

    const list = props.allAlmacenes.filter(
      (a) => a.empresa_id === selectedEmpresa,
    );
    setFilteredAlmacenes(list);

    if (selectedAlmacen && !list.some((a) => a.id === selectedAlmacen)) {
      setSelectedAlmacen(null);
    }
  }, [selectedEmpresa, props.allAlmacenes]);

  /* =======================
     Cargar mapas
  ======================= */

  useEffect(() => {
    if (!selectedAlmacen) {
      setMapEditors([]);
      return;
    }

    router.get(
      '/mapas',
      { almacen_id: selectedAlmacen },
      {
        preserveState: true,
        replace: true,
        onSuccess: (page) => {
          const mapas = page.props.mapas as Props['mapas'];

          if (!mapas || mapas.length === 0) {
            setMapEditors([]);
            return;
          }

          setMapEditors(
            mapas.map((m) => ({
              localId: uuidv4(),
              mapaId: m.id,
              texts: m.texts ?? [],
              traps: (m.trampas ?? []).map((t: any) => ({
                ...t,
                tempId: uuidv4(),
              })),
              background: m.background ?? null,
            })),
          );
        },
      },
    );
  }, [selectedAlmacen]);

  /* =======================
     Acciones
  ======================= */

  const addNewMap = () => {
    if (!selectedAlmacen) return;

    setMapEditors((prev) => [
      ...prev,
      {
        localId: uuidv4(),
        mapaId: undefined,
        texts: [],
        traps: [],
        background: null,
      },
    ]);
  };

  const saveMap = (mapa: MapEditorState) => {
    if (!selectedEmpresa || !selectedAlmacen) return;

    router[mapa.mapaId ? 'put' : 'post'](
      mapa.mapaId ? `/mapas/${mapa.mapaId}` : '/mapas',
      {
        empresa_id: selectedEmpresa,
        almacen_id: selectedAlmacen,
        background: mapa.background,
        texts: mapa.texts,
        trampas: mapa.traps.map((t, index) => ({
          id: t.id,
          trampa_tipo_id: t.trampa_tipo_id,
          posx: Math.round(t.posx),
          posy: Math.round(t.posy),
          estado: t.estado ?? 'activo',
          numero: index + 1,
        })),
      },
      {
        preserveScroll: true,
        onSuccess: () => {
          alert('Mapa guardado correctamente');
        },
        onError: () => {
          alert('Error al guardar el mapa');
        },
      },
    );
  };

  /* =======================
     Render
  ======================= */

  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Gestión de Mapas" />

      <div className="space-y-6 p-6">
        <h1 className="text-2xl font-bold">Gestión de Mapas de Trampas</h1>

        {/* Selectores */}
        <div className="flex flex-wrap gap-6">
          <div>
            <Label>Empresa</Label>
            <Select
              value={selectedEmpresa?.toString() ?? ''}
              onValueChange={(v) => setSelectedEmpresa(Number(v))}
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
              onValueChange={(v) => setSelectedAlmacen(Number(v))}
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

        {/* Botón agregar */}
        {(hasRole('admin') || hasRole('superadmin')) && selectedAlmacen && (
          <Button onClick={addNewMap}>➕ AGREGAR NUEVO MAPA</Button>
        )}

        {/* Mapas */}
        <div className="space-y-6">
          {mapEditors.map((mapa, index) => (
            <Card key={mapa.localId}>
              <CardHeader className="flex flex-row items-center justify-between">
                <CardTitle>
                  Mapa #{index + 1} {mapa.mapaId ? '(Existente)' : '(Nuevo)'}
                </CardTitle>

                {(hasRole('admin') || hasRole('superadmin')) && (
                  <Button onClick={() => saveMap(mapa)}>Guardar mapa</Button>
                )}
              </CardHeader>

              <CardContent>
                <CanvasEditor
                  mapa={mapa}
                  trampaTipos={props.trampaTipos}
                  onChange={(updated) =>
                    setMapEditors((prev) =>
                      prev.map((m) =>
                        m.localId === updated.localId ? updated : m,
                      ),
                    )
                  }
                />
              </CardContent>
            </Card>
          ))}
        </div>
      </div>
    </AppLayout>
  );
}

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
// import { Slider } from '@/components/ui/slider';
// import { usePermissions } from '@/hooks/usePermissions';
// import AppLayout from '@/layouts/app-layout';
// import { type BreadcrumbItem } from '@/types';
// import { Head, router } from '@inertiajs/react';
// import { Hand } from 'lucide-react';
// import { ChangeEvent, MouseEvent, useEffect, useRef, useState } from 'react';
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
//   | { type: 'trap'; tempId: string; offsetX: number; offsetY: number }
//   | { type: 'pan'; startX: number; startY: number };

// interface Props {
//   empresas: Empresa[];
//   allAlmacenes: Almacen[];
//   trampaTipos: TrampaTipo[];
//   selectedEmpresa?: number | null;
//   selectedAlmacen?: number | null;
//   mapa?: {
//     id: number;
//     background: string | null;
//     texts: TextItem[];
//     trampas: Trap[];
//   } | null;
// }

// export default function MapaEditor(props: Props) {
//   const { hasRole } = usePermissions();

//   const CANVAS_WIDTH = 1000;
//   const CANVAS_HEIGHT = 700;

//   const canvasRef = useRef<HTMLCanvasElement | null>(null);
//   const containerRef = useRef<HTMLDivElement | null>(null);
//   const ctxRef = useRef<CanvasRenderingContext2D | null>(null);
//   const backgroundImageRef = useRef<HTMLImageElement | null>(null);
//   const trapImagesRef = useRef<Record<number, HTMLImageElement>>({});

//   // const [mode, setMode] = useState<'text' | 'textListed' | number>('text');
//   const [mode, setMode] = useState<number | null>(null);

//   const [textOrientation, setTextOrientation] = useState<
//     'horizontal' | 'vertical'
//   >('horizontal');
//   const [textFontSize, setTextFontSize] = useState<number>(16);
//   const [gridSize] = useState<number>(25);

//   const [texts, setTexts] = useState<TextItem[]>([]);
//   const [traps, setTraps] = useState<Trap[]>([]);
//   const [background, setBackground] = useState<string | null>(null);
//   const [history, setHistory] = useState<
//     { texts: TextItem[]; traps: Trap[] }[]
//   >([]);
//   const [dragging, setDragging] = useState<Dragging | null>(null);

//   const [trapSize, setTrapSize] = useState<number>(30); // tamaño base en px

//   // Estados para zoom y pan
//   const [zoom, setZoom] = useState<number>(100);
//   const [panMode, setPanMode] = useState<boolean>(false);
//   const [panOffset, setPanOffset] = useState<{ x: number; y: number }>({
//     x: 0,
//     y: 0,
//   });

//   const [selectedEmpresa, setSelectedEmpresa] = useState<number | null>(
//     props.selectedEmpresa ?? null,
//   );
//   const [filteredAlmacenes, setFilteredAlmacenes] = useState<Almacen[]>([]);
//   const [selectedAlmacen, setSelectedAlmacen] = useState<number | null>(
//     props.selectedAlmacen ?? null,
//   );

//   const downloadCanvasImage = () => {
//     const canvas = canvasRef.current;
//     if (!canvas) return;

//     // Crear imagen en PNG
//     const dataURL = canvas.toDataURL('image/png');

//     // Crear link temporal
//     const link = document.createElement('a');
//     link.href = dataURL;
//     link.download = `mapa-trampas-${selectedAlmacen ?? 'preview'}.png`;

//     // Forzar descarga
//     document.body.appendChild(link);
//     link.click();
//     document.body.removeChild(link);
//   };

//   // Cargar mapa automáticamente cuando cambie el almacén seleccionado
//   useEffect(() => {
//     if (!selectedAlmacen) {
//       setTexts([]);
//       setTraps([]);
//       setBackground(null);
//       return;
//     }

//     router.get(
//       '/mapas',
//       { almacen_id: selectedAlmacen },
//       {
//         preserveState: true,
//         preserveScroll: true,
//         replace: true,
//         onSuccess: (page) => {
//           const mapaData = page.props.mapa as Props['mapa'];

//           if (mapaData) {
//             setTexts(mapaData.texts ?? []);
//             setTraps(
//               (mapaData.trampas ?? []).map((t) => ({
//                 ...t,
//                 tempId: uuidv4(),
//               })),
//             );
//             setBackground(mapaData.background ?? null);
//           } else {
//             setTexts([]);
//             setTraps([]);
//             setBackground(null);
//           }
//         },
//       },
//     );
//   }, [selectedAlmacen]);

//   // Cargar imágenes de trampas
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

//   // Filtro de almacenes por empresa
//   useEffect(() => {
//     if (selectedEmpresa) {
//       const almacenesFiltrados = (props.allAlmacenes ?? []).filter(
//         (a) => a.empresa_id === selectedEmpresa,
//       );
//       setFilteredAlmacenes(almacenesFiltrados);

//       if (
//         selectedAlmacen &&
//         !almacenesFiltrados.some((a) => a.id === selectedAlmacen)
//       ) {
//         setSelectedAlmacen(null);
//       }
//     } else {
//       setFilteredAlmacenes([]);
//       setSelectedAlmacen(null);
//     }
//   }, [selectedEmpresa, props.allAlmacenes]);

//   // Configuración del canvas
//   useEffect(() => {
//     const canvas = canvasRef.current;
//     if (!canvas) return;
//     canvas.width = CANVAS_WIDTH;
//     canvas.height = CANVAS_HEIGHT;
//     ctxRef.current = canvas.getContext('2d')!;
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
//   }, [texts, traps, background, zoom, panOffset]);

//   const redraw = () => {
//     const ctx = ctxRef.current;
//     if (!ctx) return;

//     ctx.clearRect(0, 0, ctx.canvas.width, ctx.canvas.height);
//     ctx.save();

//     // Aplicar transformaciones de zoom y pan
//     const scale = zoom / 100;
//     ctx.translate(panOffset.x, panOffset.y);
//     ctx.scale(scale, scale);

//     // if (backgroundImageRef.current) {
//     //   ctx.drawImage(
//     //     backgroundImageRef.current,
//     //     0,
//     //     0,
//     //     CANVAS_WIDTH,
//     //     CANVAS_HEIGHT,
//     //   );
//     // }
//     if (backgroundImageRef.current) {
//       ctx.save();
//       ctx.globalAlpha = 0.8; // 90% de opacidad SOLO para el fondo
//       ctx.drawImage(
//         backgroundImageRef.current,
//         0,
//         0,
//         CANVAS_WIDTH,
//         CANVAS_HEIGHT,
//       );
//       ctx.restore();
//     }

//     // Grid
//     ctx.strokeStyle = '#e5e7eb';
//     ctx.lineWidth = 1 / scale;
//     for (let x = 0; x <= CANVAS_WIDTH; x += gridSize) {
//       ctx.beginPath();
//       ctx.moveTo(x, 0);
//       ctx.lineTo(x, CANVAS_HEIGHT);
//       ctx.stroke();
//     }
//     for (let y = 0; y <= CANVAS_HEIGHT; y += gridSize) {
//       ctx.beginPath();
//       ctx.moveTo(0, y);
//       ctx.lineTo(CANVAS_WIDTH, y);
//       ctx.stroke();
//     }

//     // Textos
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

//     const size = trapSize; //******************************* */
//     const half = size / 2; //******************************* */

//     // Trampas con índice
//     traps.forEach((trap, index) => {
//       const img = trapImagesRef.current[trap.trampa_tipo_id];
//       if (img?.complete) {
//         // ctx.drawImage(img, trap.posx - 22, trap.posy - 22, 40, 40);
//         // ctx.drawImage(img, trap.posx - 22, trap.posy - 22, 30, 30); //*************************************** */

//         ctx.drawImage(img, trap.posx - half, trap.posy - half, size, size);
//       } else {
//         ctx.fillStyle = '#9ca3af';
//         // ctx.fillRect(trap.posx - 22, trap.posy - 22, 40, 40);
//         // ctx.fillRect(trap.posx - 22, trap.posy - 22, 30, 30); //************************************** */

//         ctx.fillRect(trap.posx - half, trap.posy - half, size, size);

//         ctx.fillStyle = '#ef4444';
//         ctx.font = 'bold 10px sans-serif';
//         ctx.textAlign = 'center';
//         ctx.fillText('?', trap.posx, trap.posy + 4);
//       }

//       const label = String(index + 1);
//       ctx.save();
//       ctx.beginPath();
//       // ctx.arc(trap.posx, trap.posy - 28, 14, 0, Math.PI * 2); //****************************************** */
//       ctx.arc(trap.posx, trap.posy - size, size / 2, 0, Math.PI * 2);
//       switch (trap.trampa_tipo_id) {
//         case 1:
//           ctx.fillStyle = '#0CB362';
//           break;
//         case 2:
//           ctx.fillStyle = '#feaf10'; // cambiar
//           break;
//         case 3:
//           ctx.fillStyle = '#F17051';
//           break;
//         case 4:
//           ctx.fillStyle = '#D73554';
//           break;
//         case 5:
//           ctx.fillStyle = '#C949DE'; //
//           break;
//       }
//       // ctx.fillStyle = '#15803d';
//       ctx.fill();
//       ctx.fillStyle = '#ffffff';
//       // ctx.font = 'bold 14px sans-serif';
//       ctx.font = 'bold 10px sans-serif';
//       ctx.textAlign = 'center';
//       ctx.textBaseline = 'middle';
//       // ctx.fillText(label, trap.posx, trap.posy - 28);//*************************************** */
//       ctx.fillText(label, trap.posx, trap.posy - size);
//       ctx.restore();
//     });

//     ctx.restore();
//   };

//   // Conversión de coordenadas del canvas considerando zoom y pan
//   const getMousePos = (e: MouseEvent<HTMLCanvasElement>) => {
//     const rect = canvasRef.current?.getBoundingClientRect();
//     const scale = zoom / 100;
//     const rawX = e.clientX - (rect?.left ?? 0);
//     const rawY = e.clientY - (rect?.top ?? 0);

//     return {
//       x: (rawX - panOffset.x) / scale,
//       y: (rawY - panOffset.y) / scale,
//     };
//   };

//   const handleMouseDown = (e: MouseEvent<HTMLCanvasElement>) => {
//     if (!hasRole('admin') && !hasRole('superadmin')) return;
//     if (!selectedAlmacen) return;

//     const pos = getMousePos(e);

//     // Si está en modo pan, iniciar arrastre de vista
//     if (panMode) {
//       setDragging({
//         type: 'pan',
//         startX: e.clientX - panOffset.x,
//         startY: e.clientY - panOffset.y,
//       });
//       return;
//     }

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

//     const clickedTrap = traps.find(
//       // (t) => Math.hypot(t.posx - pos.x, t.posy - pos.y) < 15,
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

//     // if (mode === 'text' || mode === 'textListed') {
//     //   const text = prompt('Ingrese el texto:');
//     //   if (!text) return;
//     //   setTexts((prev) => [
//     //     ...prev,
//     //     {
//     //       id: uuidv4(),
//     //       text,
//     //       x: pos.x,
//     //       y: pos.y,
//     //       listed: mode === 'textListed',
//     //       vertical: textOrientation === 'vertical',
//     //       fontSize: textFontSize,
//     //     },
//     //   ]);
//     // } else if (typeof mode === 'number') {
//     //   setTraps((prev) => [
//     //     ...prev,
//     //     {
//     //       tempId: uuidv4(),
//     //       trampa_tipo_id: mode,
//     //       posx: pos.x,
//     //       posy: pos.y,
//     //       estado: 'activo',
//     //     },
//     //   ]);
//     // }

//     if (typeof mode === 'number') {
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

//     if (dragging.type === 'pan') {
//       setPanOffset({
//         x: e.clientX - dragging.startX,
//         y: e.clientY - dragging.startY,
//       });
//       return;
//     }

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

//   const handleMouseUp = () => setDragging(null);

//   const handleContextMenu = (e: MouseEvent<HTMLCanvasElement>) => {
//     e.preventDefault();
//     if (panMode) return;

//     const pos = getMousePos(e);
//     const clickedTrap = traps.find(
//       (t) => Math.hypot(t.posx - pos.x, t.posy - pos.y) < 15,
//     );
//     if (clickedTrap && confirm('¿Eliminar esta trampa?')) {
//       setTraps((prev) => prev.filter((t) => t.tempId !== clickedTrap.tempId));
//     }
//   };

//   const saveDrawing = () => {
//     if (!selectedAlmacen) {
//       alert('Seleccione un almacén primero');
//       return;
//     }

//     const isUpdate = !!props.mapa?.id;

//     router[isUpdate ? 'put' : 'post'](
//       isUpdate ? `/mapas/${props.mapa?.id}` : '/mapas',
//       {
//         empresa_id: selectedEmpresa,
//         almacen_id: selectedAlmacen,
//         background,
//         texts,
//         trampas: traps.map((t, index) => ({
//           id: t.id,
//           trampa_tipo_id: t.trampa_tipo_id,
//           posx: Math.round(t.posx),
//           posy: Math.round(t.posy),
//           estado: t.estado ?? 'activo',
//           numero: index + 1,
//         })),
//       },
//       {
//         preserveState: true,
//         preserveScroll: true,
//         onSuccess: () => {
//           alert(`Mapa ${isUpdate ? 'actualizado' : 'creado'} exitosamente`);
//         },
//         onError: (errors) => {
//           console.error(errors);
//           alert('Error al guardar el mapa');
//         },
//       },
//     );
//   };

//   const handleEmpresaChange = (value: string) => {
//     setSelectedEmpresa(Number(value));
//     setSelectedAlmacen(null);
//   };

//   const handleAlmacenChange = (value: string) => {
//     setSelectedAlmacen(Number(value));
//   };

//   const handleBackgroundUpload = (e: ChangeEvent<HTMLInputElement>) => {
//     const file = e.target.files?.[0];
//     if (!file) return;
//     const reader = new FileReader();
//     reader.onload = (ev) => setBackground(ev.target?.result as string);
//     reader.readAsDataURL(file);
//   };

//   const handleZoomChange = (value: number[]) => {
//     setZoom(value[0]);
//   };

//   const resetView = () => {
//     setZoom(100);
//     setPanOffset({ x: 0, y: 0 });
//   };

//   return (
//     <AppLayout breadcrumbs={breadcrumbs}>
//       <Head title="Editor de Mapa de Trampas" />

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

//         {(hasRole('superadmin') || hasRole('admin')) && selectedAlmacen && (
//           <div className="space-y-4">
//             {/* Controles de Zoom y Pan */}
//             <div className="flex flex-wrap items-center gap-4 rounded-lg border p-4">
//               <div className="flex items-center gap-3">
//                 <Label className="whitespace-nowrap">Zoom: {zoom}%</Label>
//                 <Slider
//                   value={[zoom]}
//                   onValueChange={handleZoomChange}
//                   min={25}
//                   max={300}
//                   step={5}
//                   className="w-48"
//                 />
//               </div>

//               <Button
//                 variant={panMode ? 'default' : 'outline'}
//                 size="sm"
//                 onClick={() => setPanMode(!panMode)}
//                 className="gap-2"
//               >
//                 <Hand className="h-4 w-4" />
//                 {panMode ? 'Modo Pan Activo' : 'Activar Pan'}
//               </Button>

//               <Button variant="outline" size="sm" onClick={resetView}>
//                 Restablecer Vista
//               </Button>
//             </div>

//             {/* Herramientas */}
//             <div className="flex flex-wrap items-center gap-3">
//               <Select
//                 value={mode?.toString()}
//                 // onValueChange={(v) =>
//                 //   setMode(
//                 //     isNaN(Number(v)) ? (v as 'text' | 'textListed') : Number(v),
//                 //   )
//                 // }
//                 onValueChange={(v) => setMode(Number(v))}
//               >
//                 <SelectTrigger className="w-64">
//                   <SelectValue placeholder="Herramienta" />
//                 </SelectTrigger>
//                 <SelectContent>
//                   {/* <SelectItem value="text">Agregar texto</SelectItem>
//                   <SelectItem value="textListed">
//                     Agregar texto (listado)
//                   </SelectItem> */}
//                   {props.trampaTipos.map((tipo) => (
//                     <SelectItem key={tipo.id} value={tipo.id.toString()}>
//                       {tipo.nombre}
//                     </SelectItem>
//                   ))}
//                 </SelectContent>
//               </Select>

//               {/* {(mode === 'text' || mode === 'textListed') && (
//                 <>
//                   <Select
//                     value={textOrientation}
//                     onValueChange={(v) => setTextOrientation(v as any)}
//                   >
//                     <SelectTrigger className="w-36">
//                       <SelectValue placeholder="Orientación" />
//                     </SelectTrigger>
//                     <SelectContent>
//                       <SelectItem value="horizontal">Horizontal</SelectItem>
//                       <SelectItem value="vertical">Vertical</SelectItem>
//                     </SelectContent>
//                   </Select>

//                   <div className="flex items-center gap-2">
//                     <Label>Tamaño:</Label>
//                     <Input
//                       type="number"
//                       value={textFontSize}
//                       onChange={(e) => setTextFontSize(Number(e.target.value))}
//                       className="w-20"
//                       min={8}
//                       max={48}
//                     />
//                   </div>
//                 </>
//               )} */}

//               <div className="flex items-center gap-3">
//                 <Label className="whitespace-nowrap">
//                   Tamaño trampa: {trapSize}px
//                 </Label>
//                 <Slider
//                   value={[trapSize]}
//                   onValueChange={(v) => setTrapSize(v[0])}
//                   min={10}
//                   max={80}
//                   step={2}
//                   className="w-48"
//                 />
//               </div>

//               <div className="flex items-center gap-3">
//                 <Label>Fondo:</Label>
//                 <Input
//                   type="file"
//                   accept="image/*"
//                   onChange={handleBackgroundUpload}
//                   className="w-64"
//                 />
//                 {background && (
//                   <Button
//                     variant="outline"
//                     size="sm"
//                     onClick={() => setBackground(null)}
//                   >
//                     Quitar fondo
//                   </Button>
//                 )}
//               </div>

//               <div className="flex gap-2">
//                 <Button
//                   variant="outline"
//                   className="gap-2"
//                   onClick={downloadCanvasImage}
//                 >
//                   ⬇ Descargar PNG
//                 </Button>
//                 <Button
//                   variant="outline"
//                   onClick={() => setHistory((prev) => prev.slice(0, -1))}
//                 >
//                   Deshacer
//                 </Button>
//                 <Button
//                   variant="outline"
//                   onClick={() => {
//                     setTexts([]);
//                     setTraps([]);
//                   }}
//                 >
//                   Limpiar
//                 </Button>
//                 <Button onClick={saveDrawing}>
//                   {props.mapa?.id ? 'Actualizar Mapa' : 'Guardar Mapa'}
//                 </Button>
//               </div>
//             </div>
//           </div>
//         )}

//         <Card className="rounded-none border-muted py-2 shadow-muted">
//           <CardContent className="overflow-auto p-0">
//             <div className="mx-auto w-fit" ref={containerRef}>
//               <canvas
//                 ref={canvasRef}
//                 width={CANVAS_WIDTH}
//                 height={CANVAS_HEIGHT}
//                 className={`h-[700px] w-[1000px] touch-none border bg-white ${
//                   panMode
//                     ? 'cursor-grab active:cursor-grabbing'
//                     : 'cursor-crosshair'
//                 }`}
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
//                       onChange={(e) =>
//                         setTexts((prev) =>
//                           prev.map((tx) =>
//                             tx.id === t.id
//                               ? { ...tx, text: e.target.value }
//                               : tx,
//                           ),
//                         )
//                       }
//                       className="flex-1"
//                     />
//                     <Button
//                       variant="destructive"
//                       size="icon"
//                       onClick={() =>
//                         setTexts((prev) => prev.filter((tx) => tx.id !== t.id))
//                       }
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
