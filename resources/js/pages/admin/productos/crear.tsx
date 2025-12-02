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
import axios from 'axios';
import { useEffect, useState } from 'react';
import { MultiSelect } from './MultiSelect';

const breadcrumbs: BreadcrumbItem[] = [
  {
    title: 'Productos',
    href: '/productos',
  },
  {
    title: 'Crear',
    href: '/productos/create',
  },
];

interface Categoria {
  id: number;
  nombre: string;
}

interface Subcategoria {
  id: number;
  nombre: string;
}

interface Marca {
  id: number;
  nombre: string;
}

interface Etiqueta {
  id: number;
  nombre: string;
}

interface ProductoFormData {
  nombre: string;
  imagen: string;
  orden: string;
  codigo: string;
  descripcion: string;
  ruta: string;
  marca_id: string;
  categoria_id: string;
  subcategoria_id: string;
  etiqueta_ids: number[];
}

export default function Create() {
  const { categorias, marcas, etiquetas } = usePage<{
    categorias: Categoria[];
    marcas: Marca[];
    etiquetas: Etiqueta[];
  }>().props;

  // const { subcategorias } = usePage<{ subcategorias: Subcategoria[] }>().props;

  const { data, setData, post, processing, errors } = useForm<ProductoFormData>(
    {
      nombre: '',
      imagen: '',
      orden: '',
      codigo: '',
      descripcion: '',
      ruta: '',
      marca_id: '',
      categoria_id: '',
      subcategoria_id: '',
      etiqueta_ids: [],
    },
  );

  // Estado local para subcategorías
  const [subcategorias, setSubcategorias] = useState<Subcategoria[]>([]);
  const [loadingSubcategorias, setLoadingSubcategorias] = useState(false);

  // Cargar subcategorías cuando cambie la categoría
  useEffect(() => {
    // Evitar peticiones si no hay categoría válida
    if (!data.categoria_id || data.categoria_id === '') {
      setSubcategorias([]);
      setData('subcategoria_id', '');
      return;
    }

    let isCancelled = false;

    const fetchSubcategorias = async () => {
      setLoadingSubcategorias(true);
      try {
        const response = await axios.get(
          `/productos/subcategorias/${data.categoria_id}`,
        );
        if (!isCancelled) {
          setSubcategorias(response.data.subcategorias ?? []);
          setData('subcategoria_id', '');
        }
      } catch (error: any) {
        if (!isCancelled) {
          console.error('Error al cargar subcategorías:', error);
          setSubcategorias([]);
          // Opcional: mostrar toast de error
        }
      } finally {
        if (!isCancelled) {
          setLoadingSubcategorias(false);
        }
      }
    };

    fetchSubcategorias();

    return () => {
      isCancelled = true;
    };
  }, [data.categoria_id, setData]);

  const handleSumit = (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    const dataToSend = {
      ...data,
      categoria_id: data.categoria_id === '' ? null : Number(data.categoria_id),
      subcategoria_id:
        data.subcategoria_id === '' ? null : Number(data.subcategoria_id),
      marca_id: data.marca_id === '' ? null : Number(data.marca_id),
    } as unknown as Record<string, any>;
    post('/productos', dataToSend);
  };

  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Productos | Create" />

      <div className="w-8/12 p-4">
        <form onSubmit={handleSumit} method="post" className="space-y-4">
          {/* NOMBRE */}
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
          {/* ORDEN */}
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
          {/* CODIGO */}
          <div className="gap-1.5">
            <Input
              placeholder="Codigo"
              value={data.codigo}
              onChange={(e) => setData('codigo', e.target.value)}
            ></Input>
            {errors.codigo && (
              <div className="mt-1 flex items-center text-sm text-red-500">
                {errors.codigo}
              </div>
            )}
          </div>

          {/* DESCRIPCION */}
          <div className="gap-1.5">
            <Input
              placeholder="Descripcion"
              value={data.descripcion}
              onChange={(e) => setData('descripcion', e.target.value)}
            ></Input>
            {errors.descripcion && (
              <div className="mt-1 flex items-center text-sm text-red-500">
                {errors.descripcion}
              </div>
            )}
          </div>

          {/* CATEGORIA */}
          <div className="gap-1.5">
            <Select
              value={data.categoria_id}
              onValueChange={(value) => setData('categoria_id', value)}
              disabled={processing}
            >
              <SelectTrigger>
                <SelectValue placeholder="Selecciona una categoría" />
              </SelectTrigger>
              <SelectContent>
                <SelectGroup>
                  <SelectLabel>Categorías</SelectLabel>
                  {categorias.map((cat) => (
                    <SelectItem key={cat.id} value={String(cat.id)}>
                      {cat.nombre}
                    </SelectItem>
                  ))}
                </SelectGroup>
              </SelectContent>
            </Select>
            {errors.categoria_id && (
              <p className="mt-1 text-sm text-red-500">{errors.categoria_id}</p>
            )}
          </div>
          {/* SUBCATEGORIAS */}
          <div className="gap-1.5">
            <Select
              value={data.subcategoria_id}
              onValueChange={(value) => setData('subcategoria_id', value)}
              disabled={
                !data.categoria_id || loadingSubcategorias || processing
              }
            >
              <SelectTrigger>
                <SelectValue
                  placeholder={
                    loadingSubcategorias
                      ? 'Cargando subcategorías...'
                      : !data.categoria_id
                        ? 'Selecciona una categoría primero'
                        : subcategorias.length === 0
                          ? 'No hay subcategorías'
                          : 'Selecciona una subcategoría'
                  }
                />
              </SelectTrigger>
              <SelectContent>
                <SelectGroup>
                  <SelectLabel>Subcategorías</SelectLabel>
                  {subcategorias.length > 0 ? (
                    subcategorias.map((sub) => (
                      <SelectItem key={sub.id} value={String(sub.id)}>
                        {sub.nombre}
                      </SelectItem>
                    ))
                  ) : (
                    <div className="px-2 py-1.5 text-sm text-muted-foreground">
                      No hay subcategorías disponibles
                    </div>
                  )}
                </SelectGroup>
              </SelectContent>
            </Select>
            {errors.subcategoria_id && (
              <p className="mt-1 text-sm text-red-500">
                {errors.subcategoria_id}
              </p>
            )}
          </div>
          {/* MARCA */}
          <div className="gap-1.5">
            <Select
              onValueChange={(value) => setData('marca_id', value)}
              value={data.marca_id}
              disabled={processing}
            >
              <SelectTrigger>
                <SelectValue></SelectValue>
              </SelectTrigger>

              <SelectContent>
                <SelectGroup>
                  <SelectLabel>Marcas</SelectLabel>
                  {marcas.map((marca) => (
                    <SelectItem key={marca.id} value={String(marca.id)}>
                      {marca.nombre}
                    </SelectItem>
                  ))}
                </SelectGroup>
              </SelectContent>
            </Select>
            {errors.marca_id && (
              <div className="mt-1 flex items-center text-sm text-red-500">
                {errors.marca_id}
              </div>
            )}
          </div>

          <div className="gap-1.5">
            {/* <label className="mb-1 block text-sm font-medium text-gray-700">
              Etiquetas
            </label> */}
            <MultiSelect
              opciones={etiquetas}
              seleccionadas={data.etiqueta_ids}
              onChange={(ids) => setData('etiqueta_ids', ids)}
            />
            {errors.etiqueta_ids && (
              <p className="mt-1 text-sm text-red-500">{errors.etiqueta_ids}</p>
            )}
          </div>

          <Button type="submit" disabled={processing}>
            {processing ? 'Guardando...' : 'Guardar Producto'}
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
//     title: 'Productos',
//     href: '/productos',
//   },
// ];

// export default function Crear() {
//   return (
//     <AppLayout breadcrumbs={breadcrumbs}>
//       <Head title="Productos" />
//     </AppLayout>
//   );
// }
