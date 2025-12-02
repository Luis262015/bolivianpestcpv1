import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import AppLayout from '@/layouts/app-layout';
import { type BreadcrumbItem } from '@/types';
import { Head, useForm } from '@inertiajs/react';

import React from 'react';

const breadcrumbs: BreadcrumbItem[] = [
  {
    title: 'Proveedores',
    href: 'proveedores/create',
  },
];

const TiposEnum = ['Puntual', 'Responsable', 'Predispuesto', 'Lento'];

export default function Create() {
  const { data, setData, post, processing, errors } = useForm({
    nombre: '',
    direccion: '',
    contacto: '',
    telefono: '',
    email: '',
  });

  const handleSumit = (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    post('/proveedores');
  };

  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Proveedores | Create" />

      <div className="w-8/12 p-4">
        <form onSubmit={handleSumit} method="post" className="space-y-4">
          <div className="gap-1.5">
            <Input
              placeholder="Nombre"
              value={data.nombre}
              onChange={(e) => setData('nombre', e.target.value)}
            ></Input>
            {errors.nombre && (
              <div className="mt-1 flex items-center text-sm text-red-500">
                {errors.nombre}
              </div>
            )}
          </div>
          <div className="gap-1.5">
            <Input
              placeholder="Direccion"
              value={data.direccion}
              onChange={(e) => setData('direccion', e.target.value)}
            ></Input>
            {errors.direccion && (
              <div className="mt-1 flex items-center text-sm text-red-500">
                {errors.direccion}
              </div>
            )}
          </div>
          <div className="gap-1.5">
            <Input
              placeholder="Telefono"
              value={data.telefono}
              onChange={(e) => setData('telefono', e.target.value)}
            ></Input>
            {errors.telefono && (
              <div className="mt-1 flex items-center text-sm text-red-500">
                {errors.telefono}
              </div>
            )}
          </div>
          <div className="gap-1.5">
            <Input
              type="email"
              placeholder="Email"
              value={data.email}
              onChange={(e) => setData('email', e.target.value)}
            ></Input>
            {errors.email && (
              <div className="mt-1 flex items-center text-sm text-red-500">
                {errors.email}
              </div>
            )}
          </div>

          <div className="gap-1.5">
            <Input
              placeholder="Contacto"
              value={data.contacto}
              onChange={(e) => setData('contacto', e.target.value)}
            ></Input>
            {errors.contacto && (
              <div className="mt-1 flex items-center text-sm text-red-500">
                {errors.contacto}
              </div>
            )}
          </div>

          <Button disabled={processing} type="submit">
            Guardar Proveedor
          </Button>
        </form>
      </div>
    </AppLayout>
  );
}

// import AppLayout from '@/layouts/app-layout';
// import { type BreadcrumbItem } from '@/types';
// import { Head } from '@inertiajs/react';

// const breadcrumbs: BreadcrumbItem[] = [
//   {
//     title: 'Proveedores',
//     href: '/proveedores',
//   },
// ];

// export default function Crear() {
//   return (
//     <AppLayout breadcrumbs={breadcrumbs}>
//       <Head title="Proveedores" />
//     </AppLayout>
//   );
// }
