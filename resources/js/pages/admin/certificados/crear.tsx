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
    title: 'Certificados',
    href: '/certificados',
  },
  {
    title: 'Crear',
    href: '/certificados/create',
  },
];

interface Empresa {
  id: number;
  nombre: string;
}

export default function Crear() {
  const { empresas } = usePage<{ empresas: Empresa[] }>().props;

  const { data, setData, post, processing, errors } = useForm({
    qrcode: '',
    firmadigital: '',
    titulo: '',
    actividad: '',
    validez: '',
    direccion: '',
    diagnostico: '',
    condicion: '',
    trabajo: '',
    plaguicidas: '',
    registro: '',
    area: '',
    acciones: '',
    empresa_id: '',
  });

  const handleSumit = (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    const dataToSend = {
      ...data,
      empresa_id: data.empresa_id === '' ? null : Number(data.empresa_id),
    } as unknown as Record<string, any>;
    post('/certificados', dataToSend);
  };

  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Certificados" />
      <div className="w-8/12 p-4">
        <form onSubmit={handleSumit} method="post" className="space-y-4">
          {/** EMPRESAS */}
          <div className="gap-1.5">
            <Select
              onValueChange={(value) => setData('empresa_id', value)}
              value={data.empresa_id}
              disabled={processing}
            >
              <SelectTrigger>
                <SelectValue></SelectValue>
              </SelectTrigger>

              <SelectContent>
                <SelectGroup>
                  <SelectLabel>Empresas</SelectLabel>
                  {empresas.map((empresa) => (
                    <SelectItem key={empresa.id} value={String(empresa.id)}>
                      {empresa.nombre}
                    </SelectItem>
                  ))}
                </SelectGroup>
              </SelectContent>
            </Select>
            {errors.empresa_id && (
              <div className="mt-1 flex items-center text-sm text-red-500">
                {errors.empresa_id}
              </div>
            )}
          </div>
          {/* QR CODE */}
          <div className="gap-1.5">
            <Input
              placeholder="QR Code"
              value={data.qrcode}
              onChange={(e) => setData('qrcode', e.target.value)}
            ></Input>
            {errors.qrcode && (
              <div className="mt-1 flex items-center text-sm text-red-500">
                {errors.qrcode}
              </div>
            )}
          </div>
          {/* firmadigital */}
          <div className="gap-1.5">
            <Input
              placeholder="Firma Digital"
              value={data.firmadigital}
              onChange={(e) => setData('firmadigital', e.target.value)}
            ></Input>
            {errors.firmadigital && (
              <div className="mt-1 flex items-center text-sm text-red-500">
                {errors.firmadigital}
              </div>
            )}
          </div>
          {/* titulo */}
          <div className="gap-1.5">
            <Input
              placeholder="Titulo"
              value={data.titulo}
              onChange={(e) => setData('titulo', e.target.value)}
            ></Input>
            {errors.titulo && (
              <div className="mt-1 flex items-center text-sm text-red-500">
                {errors.titulo}
              </div>
            )}
          </div>
          {/* actividad */}
          <div className="gap-1.5">
            <Input
              placeholder="Actividad"
              value={data.actividad}
              onChange={(e) => setData('actividad', e.target.value)}
            ></Input>
            {errors.actividad && (
              <div className="mt-1 flex items-center text-sm text-red-500">
                {errors.actividad}
              </div>
            )}
          </div>
          {/* validez */}
          <div className="gap-1.5">
            <Input
              type="date"
              placeholder="validez"
              value={data.validez}
              onChange={(e) => setData('validez', e.target.value)}
            ></Input>
            {errors.validez && (
              <div className="mt-1 flex items-center text-sm text-red-500">
                {errors.validez}
              </div>
            )}
          </div>
          {/* direccion */}
          <div className="gap-1.5">
            <Input
              placeholder="direccion"
              value={data.direccion}
              onChange={(e) => setData('direccion', e.target.value)}
            ></Input>
            {errors.direccion && (
              <div className="mt-1 flex items-center text-sm text-red-500">
                {errors.direccion}
              </div>
            )}
          </div>
          {/* diagnostico */}
          <div className="gap-1.5">
            <Input
              placeholder="diagnostico"
              value={data.diagnostico}
              onChange={(e) => setData('diagnostico', e.target.value)}
            ></Input>
            {errors.diagnostico && (
              <div className="mt-1 flex items-center text-sm text-red-500">
                {errors.diagnostico}
              </div>
            )}
          </div>
          {/* condicion */}
          <div className="gap-1.5">
            <Input
              placeholder="condicion"
              value={data.condicion}
              onChange={(e) => setData('condicion', e.target.value)}
            ></Input>
            {errors.condicion && (
              <div className="mt-1 flex items-center text-sm text-red-500">
                {errors.condicion}
              </div>
            )}
          </div>
          {/* trabajo */}
          <div className="gap-1.5">
            <Input
              placeholder="trabajo"
              value={data.trabajo}
              onChange={(e) => setData('trabajo', e.target.value)}
            ></Input>
            {errors.trabajo && (
              <div className="mt-1 flex items-center text-sm text-red-500">
                {errors.trabajo}
              </div>
            )}
          </div>
          {/* plaguicidas */}
          <div className="gap-1.5">
            <Input
              placeholder="plaguicidas"
              value={data.plaguicidas}
              onChange={(e) => setData('plaguicidas', e.target.value)}
            ></Input>
            {errors.plaguicidas && (
              <div className="mt-1 flex items-center text-sm text-red-500">
                {errors.plaguicidas}
              </div>
            )}
          </div>
          {/* registro */}
          <div className="gap-1.5">
            <Input
              type="date"
              placeholder="registro"
              value={data.registro}
              onChange={(e) => setData('registro', e.target.value)}
            ></Input>
            {errors.registro && (
              <div className="mt-1 flex items-center text-sm text-red-500">
                {errors.registro}
              </div>
            )}
          </div>
          {/* area */}
          <div className="gap-1.5">
            <Input
              placeholder="area"
              value={data.area}
              onChange={(e) => setData('area', e.target.value)}
            ></Input>
            {errors.area && (
              <div className="mt-1 flex items-center text-sm text-red-500">
                {errors.area}
              </div>
            )}
          </div>
          {/* acciones */}
          <div className="gap-1.5">
            <Input
              placeholder="acciones"
              value={data.acciones}
              onChange={(e) => setData('acciones', e.target.value)}
            ></Input>
            {errors.acciones && (
              <div className="mt-1 flex items-center text-sm text-red-500">
                {errors.acciones}
              </div>
            )}
          </div>

          <Button disabled={processing} type="submit">
            Guardar Certificado
          </Button>
        </form>
      </div>
    </AppLayout>
  );
}
