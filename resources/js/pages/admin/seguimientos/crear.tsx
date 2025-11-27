import { Button } from '@/components/ui/button';
import AppLayout from '@/layouts/app-layout';
import { type BreadcrumbItem } from '@/types';
import { Head } from '@inertiajs/react';
import { Plus } from 'lucide-react';
import { useState } from 'react';
import ModalSeguimiento from './ModalSeguimiento';

const breadcrumbs: BreadcrumbItem[] = [
  {
    title: 'Seguimientos',
    href: '/seguimientos',
  },
];

interface Empresa {
  id: number;
  nombre: string;
}

interface Almacen {
  id: number;
  nombre: string;
}

interface Props {
  empresas: Empresa[];
  almacenes: Almacen[];
  seguimientos: any; // Aquí puedes definir el tipo completo
}

export default function Crear({ empresas, almacenes, seguimientos }: Props) {
  const [modalOpen, setModalOpen] = useState(false);

  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Seguimientos" />

      <div className="py-12">
        <div className="mx-auto max-w-7xl sm:px-6 lg:px-8">
          <div className="overflow-hidden bg-white shadow-sm sm:rounded-lg">
            <div className="p-6">
              <div className="mb-6 flex items-center justify-between">
                <h2 className="text-2xl font-semibold">Seguimientos</h2>
                <Button onClick={() => setModalOpen(true)}>
                  <Plus className="mr-2 h-4 w-4" />
                  Nuevo Seguimiento
                </Button>
              </div>
              <div className="space-y-4">
                {seguimientos?.data && seguimientos.data.length > 0 ? (
                  seguimientos.data.map((seguimiento: any) => (
                    <div key={seguimiento.id} className="rounded-lg border p-4">
                      <h3 className="font-medium">
                        {seguimiento.empresa?.nombre}
                      </h3>
                      <p className="text-sm text-gray-600">
                        {seguimiento.almacen?.nombre}
                      </p>
                      <p className="mt-2 text-sm">
                        {seguimiento.observaciones}
                      </p>
                    </div>
                  ))
                ) : (
                  <p className="py-8 text-center text-gray-500">
                    No hay seguimientos registrados
                  </p>
                )}
              </div>
            </div>
          </div>
        </div>
      </div>

      <ModalSeguimiento
        open={modalOpen}
        onClose={() => setModalOpen(false)}
        empresas={empresas}
        almacenes={almacenes}
      />
    </AppLayout>
  );
}
