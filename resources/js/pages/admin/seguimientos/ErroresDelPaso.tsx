import { AlertCircle } from 'lucide-react';

/**
 * Errores de validación del seguimiento, en lenguaje del formulario.
 *
 * No todos los pasos pueden marcar el campo culpable: el paso de trampas
 * delega en un componente hijo que no conoce los errores, así que sin este
 * resumen el técnico solo veía "revisa los campos marcados" sin ninguna marca.
 */

const ETIQUETA_RAIZ: Record<string, string> = {
  empresa_id: 'Empresa',
  almacen_id: 'Almacén',
  tipo_seguimiento_id: 'Tipo de seguimiento',
  numero_tarea: 'Tarea',
  aplicacion_data: 'Labores',
  metodos_ids: 'Métodos',
  productos_usados: 'Productos',
  epps_ids: 'EPP',
  protecciones_ids: 'Métodos de protección',
  biologicos_ids: 'Biológicos',
  signos_ids: 'Signos / síntomas',
  trampa_especies_seguimientos: 'Trampas de insectos',
  trampa_roedores_seguimientos: 'Trampas de roedores',
  observaciones_especificas: 'Observaciones específicas',
  gastos: 'Gastos',
  imagenes: 'Imágenes',
  observaciones_generales: 'Observaciones generales',
  encargado_nombre: 'Nombre del encargado',
  encargado_cargo: 'Cargo del encargado',
  firma_encargado: 'Firma del encargado',
  firma_supervisor: 'Firma del supervisor',
  fecha: 'Fecha',
  created_at: 'Fecha',
};

const legible = (texto: string) => texto.replaceAll('_', ' ');

/**
 * "trampa_roedores_seguimientos.2.merma" → "Trampas de roedores · fila 3 · merma"
 */
export function describirCampo(clave: string): string {
  const [raiz, indice, sub] = clave.split('.');
  const base = ETIQUETA_RAIZ[raiz] ?? legible(raiz);

  if (indice === undefined) return base;
  if (sub === undefined) return `${base} · ${legible(indice)}`;

  return `${base} · fila ${Number(indice) + 1} · ${legible(sub)}`;
}

interface Props {
  errors: Record<string, string>;
  paso: number;
  pasoPorCampo: Record<string, number>;
}

export default function ErroresDelPaso({ errors, paso, pasoPorCampo }: Props) {
  const propios = Object.entries(errors).filter(
    ([campo]) => pasoPorCampo[campo.split('.')[0]] === paso,
  );

  if (propios.length === 0) return null;

  return (
    <div
      role="alert"
      className="mt-4 rounded-lg border border-red-300 bg-red-50 p-3 dark:border-red-900 dark:bg-red-950/40"
    >
      <div className="flex items-center gap-2 text-sm font-medium text-red-700 dark:text-red-300">
        <AlertCircle className="h-4 w-4 shrink-0" />
        {propios.length === 1
          ? 'Hay un error en este paso'
          : `Hay ${propios.length} errores en este paso`}
      </div>
      <ul className="mt-2 space-y-1 text-sm text-red-700 dark:text-red-300">
        {propios.map(([campo, mensaje]) => (
          <li key={campo}>
            <span className="font-medium">{describirCampo(campo)}:</span>{' '}
            {mensaje}
          </li>
        ))}
      </ul>
    </div>
  );
}
