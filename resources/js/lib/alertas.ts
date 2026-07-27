import Swal from 'sweetalert2';

/**
 * Capa única sobre SweetAlert2. Sustituye a alert() / confirm() / prompt()
 * nativos, que bloquean el hilo, no se pueden estilizar y en algunos
 * navegadores el usuario puede silenciarlos ("no volver a mostrar").
 *
 * Centralizar aquí el estilo evita repetir la configuración en cada pantalla:
 * si mañana cambia la paleta, se cambia en un solo sitio.
 */

// Clases Tailwind compartidas. El modo oscuro funciona porque SweetAlert2
// monta en <body>, descendiente de <html class="dark">, y el proyecto define
// `@custom-variant dark (&:is(.dark *))`.
const clasesBase = {
  popup:
    'rounded-2xl border border-slate-200 bg-white text-slate-900 shadow-lg dark:border-slate-700 dark:bg-slate-900 dark:text-slate-100',
  title: 'text-lg font-semibold',
  htmlContainer: 'text-sm text-slate-600 dark:text-slate-300',
  confirmButton:
    'inline-flex items-center justify-center rounded-lg px-4 py-2 text-sm font-medium text-white shadow-sm focus:outline-none',
  cancelButton:
    'inline-flex items-center justify-center rounded-lg border border-slate-300 bg-white px-4 py-2 text-sm font-medium text-slate-700 shadow-sm hover:bg-slate-50 focus:outline-none dark:border-slate-600 dark:bg-slate-800 dark:text-slate-200 dark:hover:bg-slate-700',
  actions: 'gap-2',
} as const;

type OpcionesConfirmar = {
  titulo?: string;
  texto?: string;
  /** Etiqueta del botón que ejecuta la acción. */
  confirmar?: string;
  cancelar?: string;
  /** Pinta el botón en rojo y marca la acción como irreversible. */
  destructivo?: boolean;
};

/**
 * Reemplazo de `confirm()`. Devuelve true sólo si el usuario confirma;
 * cerrar con Escape o pulsar fuera cuenta como cancelar.
 *
 * @example
 * if (await confirmar({ texto: 'Se eliminará el registro.', destructivo: true })) {
 *   router.delete(url);
 * }
 */
export async function confirmar({
  titulo = '¿Estás seguro?',
  texto,
  confirmar: etiquetaConfirmar,
  cancelar = 'Cancelar',
  destructivo = false,
}: OpcionesConfirmar = {}): Promise<boolean> {
  const resultado = await Swal.fire({
    title: titulo,
    text: texto,
    icon: destructivo ? 'warning' : 'question',
    showCancelButton: true,
    confirmButtonText: etiquetaConfirmar ?? (destructivo ? 'Eliminar' : 'Aceptar'),
    cancelButtonText: cancelar,
    reverseButtons: true,
    focusCancel: destructivo,
    buttonsStyling: false,
    customClass: {
      ...clasesBase,
      confirmButton: `${clasesBase.confirmButton} ${
        destructivo
          ? 'bg-red-600 hover:bg-red-700'
          : 'bg-slate-900 hover:bg-slate-800 dark:bg-slate-100 dark:text-slate-900 dark:hover:bg-white'
      }`,
    },
  });

  return resultado.isConfirmed;
}

/** Aviso modal que exige confirmación explícita. Reemplaza a `alert()`. */
export async function avisar({
  titulo = 'Aviso',
  texto,
  icono = 'info',
}: {
  titulo?: string;
  texto?: string;
  icono?: 'info' | 'success' | 'error' | 'warning';
} = {}): Promise<void> {
  await Swal.fire({
    title: titulo,
    text: texto,
    icon: icono,
    confirmButtonText: 'Entendido',
    buttonsStyling: false,
    customClass: {
      ...clasesBase,
      confirmButton: `${clasesBase.confirmButton} bg-slate-900 hover:bg-slate-800 dark:bg-slate-100 dark:text-slate-900 dark:hover:bg-white`,
    },
  });
}

// Notificación efímera en una esquina: no interrumpe el flujo. Se usa para
// validaciones y confirmaciones de éxito, donde el alert() nativo obligaba
// a un clic extra sin aportar nada.
const Notificacion = Swal.mixin({
  toast: true,
  position: 'top-end',
  showConfirmButton: false,
  timer: 3500,
  timerProgressBar: true,
  customClass: { popup: `${clasesBase.popup} !p-3` },
});

export function notificarExito(mensaje: string): void {
  void Notificacion.fire({ icon: 'success', title: mensaje });
}

export function notificarError(mensaje: string): void {
  void Notificacion.fire({ icon: 'error', title: mensaje, timer: 5000 });
}

/**
 * Reemplazo de `prompt()`. Devuelve null si el usuario cancela, de modo que
 * se pueda distinguir "canceló" de "escribió una cadena vacía".
 */
export async function pedirTexto({
  titulo = 'Ingrese un valor',
  valorInicial = '',
  marcador = '',
}: {
  titulo?: string;
  valorInicial?: string;
  marcador?: string;
} = {}): Promise<string | null> {
  const resultado = await Swal.fire({
    title: titulo,
    input: 'text',
    inputValue: valorInicial,
    inputPlaceholder: marcador,
    showCancelButton: true,
    confirmButtonText: 'Aceptar',
    cancelButtonText: 'Cancelar',
    reverseButtons: true,
    buttonsStyling: false,
    customClass: {
      ...clasesBase,
      input:
        'rounded-lg border border-slate-300 bg-white text-slate-900 dark:border-slate-600 dark:bg-slate-800 dark:text-slate-100',
      confirmButton: `${clasesBase.confirmButton} bg-slate-900 hover:bg-slate-800 dark:bg-slate-100 dark:text-slate-900 dark:hover:bg-white`,
    },
  });

  return resultado.isConfirmed ? (resultado.value ?? '') : null;
}
