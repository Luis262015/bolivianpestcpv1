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
    titulo: string | null;
    texts: any[];
    trampas: any[];
    trapSize?: number;
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
    // if (!selectedEmpresa) {
    //   setFilteredAlmacenes([]);
    //   setSelectedAlmacen(null);
    //   return;
    // }

    // const list = props.allAlmacenes.filter(
    //   (a) => a.empresa_id === selectedEmpresa,
    // );
    // setFilteredAlmacenes(list);

    // if (selectedAlmacen && !list.some((a) => a.id === selectedAlmacen)) {
    //   setSelectedAlmacen(null);
    // }
    if (!selectedEmpresa) {
      setFilteredAlmacenes([]);
      setSelectedAlmacen(null);
      return;
    }

    const list = props.allAlmacenes.filter(
      (a) => Number(a.empresa_id) === Number(selectedEmpresa),
    );

    setFilteredAlmacenes(list);

    if (
      selectedAlmacen &&
      !list.some((a) => Number(a.id) === Number(selectedAlmacen))
    ) {
      setSelectedAlmacen(null);
    }
  }, [selectedEmpresa, props.allAlmacenes]);

  /* =======================
     Cargar mapas
  ======================= */

  // useEffect(() => {
  //   if (!selectedAlmacen) {
  //     setMapEditors([]);
  //     return;
  //   }

  //   router.get(
  //     '/mapas',
  //     { almacen_id: selectedAlmacen },
  //     {
  //       preserveState: true,
  //       replace: true,
  //       onSuccess: (page) => {
  //         const mapas = page.props.mapas as Props['mapas'];

  //         if (!mapas || mapas.length === 0) {
  //           setMapEditors([]);
  //           return;
  //         }

  //         setMapEditors(
  //           mapas.map((m) => ({
  //             localId: uuidv4(),
  //             mapaId: m.id,
  //             titulo: m.titulo ?? '', // 👈 nuevo
  //             texts: m.texts ?? [],
  //             traps: (m.trampas ?? []).map((t: any) => ({
  //               ...t,
  //               tempId: uuidv4(),
  //             })),
  //             background: m.background ?? null,
  //           })),
  //         );
  //       },
  //     },
  //   );
  // }, [selectedAlmacen]);

  useEffect(() => {
    loadMaps();
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
        titulo: '', // 👈 nuevo
        texts: [],
        traps: [],
        background: null,
        trapSize: 30,
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
        titulo: mapa.titulo, // 👈 nuevo
        background: mapa.background,
        trap_size: mapa.trapSize,
        // texts: mapa.texts,
        trampas: mapa.traps.map((t, index) => ({
          // id: t.id,
          trampa_tipo_id: t.trampa_tipo_id,
          posx: Math.round(t.posx),
          posy: Math.round(t.posy),
          // estado: t.estado ?? 'activo',
          identificador: t.identificador,
          numero: index + 1,
        })),
      },
      {
        preserveScroll: true,
        onSuccess: () => {
          loadMaps(); // 👈 recarga mapas desde BD
          alert('Mapa guardado correctamente');
        },
        onError: () => {
          alert('Error al guardar el mapa');
        },
      },
    );
  };

  const deleteMap = (mapaId?: number) => {
    if (!mapaId) return;

    if (!confirm('¿Estás seguro de eliminar este mapa?')) return;

    router.delete(`/mapas/${mapaId}`, {
      data: {
        almacen_id: selectedAlmacen, // 🔥 CLAVE
      },
      preserveScroll: true,
      onSuccess: () => {
        loadMaps(); // recargar mapas
        alert('Mapa eliminado correctamente');
      },
      onError: () => {
        alert('Error al eliminar el mapa');
      },
    });
  };

  const loadMaps = () => {
    if (!selectedAlmacen) return;

    router.get(
      '/mapas',
      { almacen_id: selectedAlmacen },
      {
        preserveState: true,
        replace: true,
        only: ['mapas'], // 👈 clave para que solo refresque mapas
        onSuccess: (page) => {
          const mapas = page.props.mapas as Props['mapas'];

          // console.log('----------------------------------------------------');
          // console.log('Respuesta del servidor:', page.props); // 🔥 DEBUG
          // console.log('Mapas cargados:', mapas); // 🔥 DEBUG
          // console.log('----------------------------------------------------');

          if (!mapas || mapas.length === 0) {
            setMapEditors([]);
            return;
          }

          setMapEditors(
            mapas.map((m) => ({
              localId: uuidv4(),
              mapaId: m.id,
              titulo: m.titulo ?? '',
              texts: m.texts ?? [],
              traps: (m.trampas ?? []).map((t: any) => ({
                ...t,
                tempId: uuidv4(),
              })),
              background: m.background ?? null,
              // trapSize: 30,
              trapSize: m.trapSize ?? 30, // 🔥 Asegura que trapSize se cargue desde el servidor
            })),
          );
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
                  <div className="flex gap-2">
                    <Button onClick={() => saveMap(mapa)}>Guardar mapa</Button>

                    {mapa.mapaId && (
                      <Button
                        variant="destructive"
                        onClick={() => deleteMap(mapa.mapaId)}
                      >
                        Eliminar
                      </Button>
                    )}
                  </div>
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
