import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
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

const breadcrumbs: BreadcrumbItem[] = [
  {
    title: 'Subcategorias',
    href: '/subcategorias',
  },
  {
    title: 'Crear',
    href: '/subcategorias/create',
  },
];

interface Categoria {
  id: number;
  nombre: string;
}

export default function Create() {
  const { categorias } = usePage<{ categorias: Categoria[] }>().props;

  const { data, setData, post, processing, errors } = useForm({
    nombre: '',
    orden: '',
    imagen: '',
    categoria_id: '',
  });

  const handleSumit = (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    const dataToSend = {
      ...data,
      orden: data.orden === '' ? null : Number(data.orden),
      categoria_id: data.categoria_id === '' ? null : Number(data.categoria_id),
    } as unknown as Record<string, any>;
    post('/subcategorias', dataToSend);
  };

  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Subcategorias | Create" />

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
              type="number"
              placeholder="Orden"
              value={data.orden}
              onChange={(e) => setData('orden', e.target.value)}
            ></Input>
            {errors.orden && (
              <div className="mt-1 flex items-center text-sm text-red-500">
                {errors.orden}
              </div>
            )}
          </div>

          <div className="gap-1.5">
            <Select
              onValueChange={(value) => setData('categoria_id', value)}
              value={data.categoria_id}
              disabled={processing}
            >
              <SelectTrigger>
                <SelectValue></SelectValue>
              </SelectTrigger>

              <SelectContent>
                <SelectGroup>
                  <SelectLabel>Categorias</SelectLabel>
                  {categorias.map((categoria) => (
                    <SelectItem key={categoria.id} value={String(categoria.id)}>
                      {categoria.nombre}
                    </SelectItem>
                  ))}
                </SelectGroup>
              </SelectContent>
            </Select>
            {errors.categoria_id && (
              <div className="mt-1 flex items-center text-sm text-red-500">
                {errors.categoria_id}
              </div>
            )}
          </div>

          {/* <div className="gap-1.5">
            <select
              id="tipo_select"              
              className="flex h-10 w-full rounded-md border border-input bg-background px-3 py-2 text-sm ring-offset-background file:border-0 file:bg-transparent file:text-sm file:font-medium placeholder:text-muted-foreground focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 focus-visible:outline-none disabled:cursor-not-allowed disabled:opacity-50"
              value={data.tipo}
              onChange={(e) => setData('tipo', e.target.value)}
            >
              <option value="" disabled>
                Selecciona una opción
              </option>
              {TiposEnum.map((tipo) => (
                <option key={tipo} value={tipo}>
                  {tipo}
                </option>
              ))}
            </select>

            {errors.tipo && ( 
              <div className="mt-1 flex items-center text-sm text-red-500">
                {errors.tipo}
              </div>
            )}
          </div> */}

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
//     title: 'Subcategorias',
//     href: '/subcategorias',
//   },
// ];

// export default function Crear() {
//   return (
//     <AppLayout breadcrumbs={breadcrumbs}>
//       <Head title="Subcategorias" />
//     </AppLayout>
//   );
// }
