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
import axios from 'axios';
import { useEffect, useState } from 'react';
import { MultiSelect } from './MultiSelect';

const breadcrumbs: BreadcrumbItem[] = [
  {
    title: 'Productos',
    href: '/productos',
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

interface Unidad {
  id: number;
  nombre: string;
}

interface Producto {
  id: number;
  nombre: string;
  descripcion: string;
  stock_min: number;
  unidad_valor: string;
  unidad_id: number;
  marca_id: string;
  categoria_id: string;
  subcategoria_id: string;
  etiqueta_ids: number[];
}

interface PageProps {
  categorias: Categoria[];
  marcas: Marca[];
  subcategorias?: Subcategoria[];
  producto: Producto;
  [key: string]: unknown; // 👈 Esta línea soluciona el error
}

export default function Edit() {
  // const {
  //   categorias,
  //   marcas,
  //   subcategorias: initialSubcategorias = [],
  //   producto,
  // } = usePage<PageProps>().props;

  const {
    producto,
    categorias,
    marcas,
    subcategorias: initialSubcategorias = [],
    etiquetas,
    etiquetas_seleccionadas,
    unidades,
  } = usePage<{
    producto: Producto;
    categorias: Categoria[];
    marcas: Marca[];
    subcategorias: Subcategoria[];
    etiquetas: Etiqueta[];
    etiquetas_seleccionadas: number[];
    unidades: Unidad[];
  }>().props;

  const { data, setData, put, processing, errors, reset } = useForm({
    nombre: producto.nombre || '',
    descripcion: producto.descripcion || '',
    stock_min: producto.stock_min ? producto.stock_min : '0',
    unidad_valor: producto.unidad_valor ? producto.unidad_valor : '0',
    unidad_id: producto.unidad_id ? String(producto.unidad_id) : '',
    categoria_id: producto.categoria_id ? String(producto.categoria_id) : '',
    subcategoria_id: producto.subcategoria_id
      ? String(producto.subcategoria_id)
      : '',
    marca_id: producto.marca_id ? String(producto.marca_id) : '',
    etiqueta_ids: etiquetas_seleccionadas,
  });

  const [subcategorias, setSubcategorias] =
    useState<Subcategoria[]>(initialSubcategorias);
  const [loadingSubcategorias, setLoadingSubcategorias] = useState(false);

  // Cargar subcategorías al cambiar categoría
  useEffect(() => {
    if (!data.categoria_id) {
      setSubcategorias([]);
      setData('subcategoria_id', '');
      return;
    }

    // Si estamos editando y la categoría coincide con la del producto, usar las subcategorías iniciales
    if (data.categoria_id === String(producto?.categoria_id)) {
      setSubcategorias(initialSubcategorias);
      return;
    }

    const fetchSubcategorias = async () => {
      setLoadingSubcategorias(true);
      try {
        const response = await axios.get(
          `/api/subcategorias/${data.categoria_id}`,
        );
        setSubcategorias(response.data.subcategorias ?? []);
        setData('subcategoria_id', '');
      } catch (error) {
        console.error('Error al cargar subcategorías:', error);
        setSubcategorias([]);
      } finally {
        setLoadingSubcategorias(false);
      }
    };

    fetchSubcategorias();
  }, [
    data.categoria_id,
    producto?.categoria_id,
    initialSubcategorias,
    setData,
  ]);

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();

    // const payload = {
    //   ...data,
    //   categoria_id: data.categoria_id ? Number(data.categoria_id) : null,
    //   subcategoria_id: data.subcategoria_id
    //     ? Number(data.subcategoria_id)
    //     : null,
    //   marca_id: data.marca_id ? Number(data.marca_id) : null,
    // };

    put(`/productos/${producto.id}`, {
      onSuccess: () => {
        // Puedes agregar lógica de éxito, como un toast de notificación
        console.log('Producto actualizado');
      },
    });
  };

  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Productos | Edit" />

      <div className="mx-auto w-8/12 p-4">
        <div className="my-2 text-2xl font-bold">Editar Producto</div>
        <form onSubmit={handleSubmit} method="post" className="space-y-4">
          {/* NOMBRE */}
          <div className="gap-1.5">
            <Label>Nombre:</Label>
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

          {/* DESCRIPCION */}
          <div className="gap-1.5">
            <Label>Descripción</Label>
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
          {/* STOCK MIN */}
          <div className="gap-1.5">
            <Label>Stock minimo</Label>
            <Input
              type="number"
              placeholder="Stock Minimo"
              value={data.stock_min}
              onChange={(e) => setData('stock_min', Number(e.target.value))}
            ></Input>
            {errors.stock_min && (
              <div className="mt-1 flex items-center text-sm text-red-500">
                {errors.stock_min}
              </div>
            )}
          </div>
          {/* UNIDAD */}
          <div className="gap-1.5">
            <Label>Unidad: </Label>
            <div className="flex items-center">
              <Input
                type="number"
                placeholder="Cantidad"
                value={data.unidad_valor}
                onChange={(e) => setData('unidad_valor', e.target.value)}
              ></Input>
              {errors.unidad_valor && (
                <div className="mt-1 flex items-center text-sm text-red-500">
                  {errors.unidad_valor}
                </div>
              )}
              <Select
                onValueChange={(value) => setData('unidad_id', value)}
                value={data.unidad_id}
                disabled={processing}
              >
                <SelectTrigger>
                  <SelectValue placeholder="Seleccione una unidad"></SelectValue>
                </SelectTrigger>

                <SelectContent>
                  <SelectGroup>
                    <SelectLabel>Unidad</SelectLabel>
                    {unidades.map((marca) => (
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
          </div>

          {/* CATEGORIA */}
          <div className="gap-1.5">
            <Label>Selección de categoria</Label>
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
            <Label>Selección de subcategoria</Label>
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
            <Label>Selección de marca</Label>
            <Select
              onValueChange={(value) => setData('marca_id', value)}
              value={data.marca_id}
              disabled={processing}
            >
              <SelectTrigger>
                <SelectValue placeholder="Seleccione una marca"></SelectValue>
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
            <Label>Selecion de etiquetas</Label>
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

// export default function Editar() {
//   return (
//     <AppLayout breadcrumbs={breadcrumbs}>
//       <Head title="Productos" />
//     </AppLayout>
//   );
// }
