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

interface Seguimiento {
  id: number;
  created_at: string;
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

      <div className="space-y-6">
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
