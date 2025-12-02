import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import {
  Select,
  SelectContent,
  SelectGroup,
  SelectItem,
  SelectLabel,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select';
import AppLayout from '@/layouts/app-layout';
import { type BreadcrumbItem } from '@/types';
import { Head, useForm, usePage } from '@inertiajs/react';

import React from 'react';

const breadcrumbs: BreadcrumbItem[] = [
  {
    title: 'Subcategorias',
    href: '/subcategorias',
  },
];

interface Categoria {
  id: number;
  nombre: string;
}

interface Subcategoria {
  id: number;
  nombre: string;
  orden: number;
  categoria_id: number;
}

interface PageProps {
  subcategoria: Subcategoria;
  categorias: Categoria[];
  [key: string]: unknown; // 👈 Esta línea soluciona el error
}

interface SubcategoriaFormData {
  nombre: string;
  orden: string;
  categoria_id: string;
}

export default function Edit() {
  // 1. Obtener los datos inyectados por el controlador
  const { subcategoria, categorias } = usePage<PageProps>().props;

  // 2. Definir breadcrumbs con el nombre de la subcategoría
  const breadcrumbs: BreadcrumbItem[] = [
    { title: 'Subcategorías', href: '/subcategorias' },
    {
      title: `Editar: ${subcategoria.nombre}`,
      href: `/subcategorias/${subcategoria.id}/edit`,
    },
  ];

  // 3. Inicializar el estado del formulario con los datos existentes
  const { data, setData, put, processing, errors } =
    useForm<SubcategoriaFormData>({
      // Convertimos los campos a string para compatibilidad con Input/Select
      nombre: subcategoria.nombre,
      orden: String(subcategoria.orden ?? ''), // Si es null, lo inicializa como string vacío
      categoria_id: String(subcategoria.categoria_id),
    });

  const handleSumit = (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();

    // 4. Utilizar el método PUT para la actualización
    // Se envía al endpoint /subcategorias/{id}
    put(`/subcategorias/${subcategoria.id}`, {
      onSuccess: () => {
        // Puedes agregar lógica de éxito, como un toast de notificación
        console.log('Subcategoría actualizada');
      },
    });
  };

  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title={`Subcategorías | Editar: ${subcategoria.nombre}`} />

      <div className="flex justify-center p-8">
        <div className="w-full max-w-xl rounded-lg p-6">
          {/* <h2 className="mb-6 text-center text-2xl font-semibold text-gray-700">
            Editar Subcategoría: {subcategoria.nombre}
          </h2> */}

          <form onSubmit={handleSumit} method="post" className="space-y-4">
            {/* Campo Nombre */}
            <div className="space-y-1.5">
              <Label htmlFor="nombre">Nombre</Label>
              <Input
                id="nombre"
                placeholder="Nombre de la Subcategoría"
                value={data.nombre}
                onChange={(e) => setData('nombre', e.target.value)}
              />
              {errors.nombre && (
                <p className="text-sm text-red-500">{errors.nombre}</p>
              )}
            </div>

            {/* Campo Orden */}
            <div className="space-y-1.5">
              <Label htmlFor="orden">Orden</Label>
              <Input
                id="orden"
                type="number"
                placeholder="Orden de visualización (ej: 1)"
                value={data.orden}
                onChange={(e) => setData('orden', e.target.value)}
              />
              {errors.orden && (
                <p className="text-sm text-red-500">{errors.orden}</p>
              )}
            </div>

            {/* Campo Categoria (SELECT de Shadcn UI) */}
            <div className="space-y-1.5">
              <Label htmlFor="categoria_id">Categoría Principal</Label>
              <Select
                onValueChange={(value) => setData('categoria_id', value)}
                value={data.categoria_id} // El valor inicial se establece aquí
                disabled={processing}
              >
                <SelectTrigger className="w-full">
                  <SelectValue placeholder="Seleccione una Categoría" />
                </SelectTrigger>
                <SelectContent>
                  <SelectGroup>
                    <SelectLabel>Categorías</SelectLabel>
                    {categorias.map((categoria) => (
                      <SelectItem
                        key={categoria.id}
                        value={String(categoria.id)}
                      >
                        {categoria.nombre}
                      </SelectItem>
                    ))}
                  </SelectGroup>
                </SelectContent>
              </Select>

              {errors.categoria_id && (
                <p className="text-sm text-red-500">{errors.categoria_id}</p>
              )}
            </div>

            <Button disabled={processing} type="submit" className="w-full">
              {processing ? 'Actualizando...' : 'Guardar Cambios'}
            </Button>
          </form>
        </div>
      </div>
    </AppLayout>
  );
}

// import AppLayout from '@/layouts/app-layout';
// import { type BreadcrumbItem } from '@/types';
// import { Head } from '@inertiajs/react';

// const breadcrumbs: BreadcrumbItem[] = [
//   {
//     title: 'Subcategorias',
//     href: '/subcategorias',
//   },
// ];

// export default function Editar() {
//   return (
//     <AppLayout breadcrumbs={breadcrumbs}>
//       <Head title="Subcategorias" />
//     </AppLayout>
//   );
// }
