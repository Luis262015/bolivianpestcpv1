import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select';
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from '@/components/ui/table';
import AppLayout from '@/layouts/app-layout';
import { Head, router } from '@inertiajs/react';
import { useState } from 'react';

interface Empresa {
  id: number;
  nombre: string;
}

interface Almacen {
  id: number;
  nombre: string;
}

interface Especie {
  id: number;
  nombre: string;
}

interface Insectocutor {
  id: number;
  trampa_id: number;
  especie: Especie;
  cantidad: number;
}

interface Roedor {
  id: number;
  trampa_id: number;
  observacion: string;
  inicial: number;
  actual: number;
  merma: number;
}

interface Seguimiento {
  id: number;
  created_at: string;
  insectocutores: Insectocutor[];
  roedores: Roedor[];
}

interface Props {
  empresas: Empresa[];
  almacenes: Almacen[];
  seguimientos: Seguimiento[];
  filters: {
    empresa_id?: number;
    almacen_id?: number;
    fecha_inicio?: string;
    fecha_fin?: string;
  };
}

export default function Lista({
  empresas,
  almacenes,
  seguimientos,
  filters,
}: Props) {
  const [empresaId, setEmpresaId] = useState(filters.empresa_id?.toString());
  const [almacenId, setAlmacenId] = useState(filters.almacen_id?.toString());
  const [fechaInicio, setFechaInicio] = useState(filters.fecha_inicio ?? '');
  const [fechaFin, setFechaFin] = useState(filters.fecha_fin ?? '');

  const buscar = () => {
    router.get(
      '/informes',
      {
        empresa_id: empresaId,
        almacen_id: almacenId,
        fecha_inicio: fechaInicio,
        fecha_fin: fechaFin,
        buscar: 1, // 👈 flag importante
      },
      {
        preserveState: true,
        replace: true,
      },
    );
  };

  const onEmpresaChange = (value: string) => {
    setEmpresaId(value);
    setAlmacenId(undefined);
    setFechaInicio('');
    setFechaFin('');

    router.get(
      '/informes',
      { empresa_id: value },
      {
        preserveState: true,
        replace: true,
        only: ['almacenes', 'filters'],
      },
    );
  };

  return (
    <AppLayout breadcrumbs={[{ title: 'Informes', href: '/informes' }]}>
      <Head title="Informes" />

      <div className="space-y-6 p-6">
        {/* Empresa */}
        <Select value={empresaId} onValueChange={onEmpresaChange}>
          <SelectTrigger>
            <SelectValue placeholder="Seleccione empresa" />
          </SelectTrigger>
          <SelectContent>
            {empresas.map((e) => (
              <SelectItem key={e.id} value={String(e.id)}>
                {e.nombre}
              </SelectItem>
            ))}
          </SelectContent>
        </Select>

        {/* Almacén */}
        <Select
          value={almacenId}
          onValueChange={setAlmacenId}
          disabled={!empresaId}
        >
          <SelectTrigger>
            <SelectValue placeholder="Seleccione almacén" />
          </SelectTrigger>
          <SelectContent>
            {almacenes.map((a) => (
              <SelectItem key={a.id} value={String(a.id)}>
                {a.nombre}
              </SelectItem>
            ))}
          </SelectContent>
        </Select>

        {/* Fechas */}
        <div className="grid grid-cols-2 gap-4">
          <Input
            type="date"
            value={fechaInicio}
            onChange={(e) => setFechaInicio(e.target.value)}
          />
          <Input
            type="date"
            value={fechaFin}
            onChange={(e) => setFechaFin(e.target.value)}
          />
        </div>

        {/* Botón buscar */}
        <Button
          onClick={buscar}
          disabled={!empresaId || !almacenId || !fechaInicio || !fechaFin}
        >
          Buscar
        </Button>

        {/* Tabla */}
        <div className="text-[1rem] font-bold">SEGUIMIENTOS</div>
        <Table>
          <TableHeader>
            <TableRow>
              <TableHead>ID</TableHead>
              <TableHead>Fecha</TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {seguimientos.length ? (
              seguimientos.map((s) => (
                <TableRow key={s.id}>
                  <TableCell>{s.id}</TableCell>
                  <TableCell>
                    {new Date(s.created_at).toLocaleString()}
                  </TableCell>
                </TableRow>
              ))
            ) : (
              <TableRow>
                <TableCell colSpan={2} className="text-center">
                  Sin resultados
                </TableCell>
              </TableRow>
            )}
          </TableBody>
        </Table>

        {/* TABLA DE INSECTOCUTORES */}
        <div className="text-[1rem] font-bold">
          INCIDENCIA DE INSECTOS VOLADORES
        </div>
        <Table>
          <TableHeader>
            <TableRow>
              <TableHead>Fecha</TableHead>
              <TableHead>Nro Trampa</TableHead>
              <TableHead>Especie</TableHead>
              <TableHead>Cantidad</TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {seguimientos.length ? (
              seguimientos.flatMap((seg) =>
                seg.insectocutores.map((ins) => (
                  <TableRow key={`${seg.id}-${ins.id}`}>
                    <TableCell>
                      {new Date(seg.created_at).toLocaleDateString()}
                    </TableCell>
                    <TableCell>{ins.trampa_id}</TableCell>
                    <TableCell>{ins.especie.nombre}</TableCell>
                    <TableCell>{ins.cantidad}</TableCell>
                  </TableRow>
                )),
              )
            ) : (
              <TableRow>
                <TableCell colSpan={4} className="text-center">
                  Sin resultados
                </TableCell>
              </TableRow>
            )}
          </TableBody>
        </Table>
        {/* TABLA DE ROEDORES */}
        <div className="text-[1rem] font-bold">SEGUIMIENTO PESO DE TRAMPAS</div>
        <Table>
          <TableHeader>
            <TableRow>
              <TableHead>Fecha</TableHead>
              <TableHead>Nro Trampa</TableHead>
              <TableHead>Inicial</TableHead>
              <TableHead>Merma</TableHead>
              <TableHead>Actual</TableHead>
              <TableHead>Observacion</TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {seguimientos.length ? (
              seguimientos.flatMap((seg) =>
                seg.roedores.map((ins) => (
                  <TableRow key={`${seg.id}-${ins.id}`}>
                    <TableCell>
                      {new Date(seg.created_at).toLocaleDateString()}
                    </TableCell>
                    <TableCell>{ins.trampa_id}</TableCell>
                    <TableCell>{ins.inicial}</TableCell>
                    <TableCell>{ins.merma}</TableCell>
                    <TableCell>{ins.actual}</TableCell>
                    <TableCell>{ins.observacion}</TableCell>
                  </TableRow>
                )),
              )
            ) : (
              <TableRow>
                <TableCell colSpan={4} className="text-center">
                  Sin resultados
                </TableCell>
              </TableRow>
            )}
          </TableBody>
        </Table>
      </div>
    </AppLayout>
  );
}

// ------------------------------------------------------
// import {
//   Select,
//   SelectContent,
//   SelectItem,
//   SelectTrigger,
//   SelectValue,
// } from '@/components/ui/select';
// import {
//   Table,
//   TableBody,
//   TableCell,
//   TableHead,
//   TableHeader,
//   TableRow,
// } from '@/components/ui/table';
// import AppLayout from '@/layouts/app-layout';
// import { Head, router } from '@inertiajs/react';

// interface Empresa {
//   id: number;
//   nombre: string;
// }

// interface Almacen {
//   id: number;
//   nombre: string;
// }

// interface Seguimiento {
//   id: number;
//   created_at: string;
// }

// interface Props {
//   empresas: Empresa[];
//   almacenes: Almacen[];
//   seguimientos: Seguimiento[];
//   filters: {
//     empresa_id?: number;
//     almacen_id?: number;
//   };
// }

// export default function Lista({
//   empresas,
//   almacenes,
//   seguimientos,
//   filters,
// }: Props) {
//   const onEmpresaChange = (value: string) => {
//     router.get(
//       '/informes',
//       { empresa_id: value },
//       { preserveState: true, replace: true },
//     );
//   };

//   const onAlmacenChange = (value: string) => {
//     router.get(
//       '/informes',
//       {
//         empresa_id: filters.empresa_id,
//         almacen_id: value,
//       },
//       { preserveState: true, replace: true },
//     );
//   };

//   return (
//     <AppLayout breadcrumbs={[{ title: 'Informes', href: '/informes' }]}>
//       <Head title="Informes" />

//       <div className="space-y-6">
//         {/* Empresa */}
//         <Select
//           value={filters.empresa_id?.toString()}
//           onValueChange={onEmpresaChange}
//         >
//           <SelectTrigger>
//             <SelectValue placeholder="Seleccione empresa" />
//           </SelectTrigger>
//           <SelectContent>
//             {empresas.map((e) => (
//               <SelectItem key={e.id} value={String(e.id)}>
//                 {e.nombre}
//               </SelectItem>
//             ))}
//           </SelectContent>
//         </Select>

//         {/* Almacén */}
//         <Select
//           value={filters.almacen_id?.toString()}
//           onValueChange={onAlmacenChange}
//           disabled={!filters.empresa_id}
//         >
//           <SelectTrigger>
//             <SelectValue placeholder="Seleccione almacén" />
//           </SelectTrigger>
//           <SelectContent>
//             {almacenes.map((a) => (
//               <SelectItem key={a.id} value={String(a.id)}>
//                 {a.nombre}
//               </SelectItem>
//             ))}
//           </SelectContent>
//         </Select>

//         {/* Tabla */}
//         <Table>
//           <TableHeader>
//             <TableRow>
//               <TableHead>ID</TableHead>
//               <TableHead>Fecha</TableHead>
//             </TableRow>
//           </TableHeader>
//           <TableBody>
//             {seguimientos.length > 0 ? (
//               seguimientos.map((s) => (
//                 <TableRow key={s.id}>
//                   <TableCell>{s.id}</TableCell>
//                   <TableCell>
//                     {new Date(s.created_at).toLocaleString()}
//                   </TableCell>
//                 </TableRow>
//               ))
//             ) : (
//               <TableRow>
//                 <TableCell colSpan={2} className="text-center">
//                   No hay seguimientos
//                 </TableCell>
//               </TableRow>
//             )}
//           </TableBody>
//         </Table>
//       </div>
//     </AppLayout>
//   );
// }
