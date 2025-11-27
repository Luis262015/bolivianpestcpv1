import { z } from 'zod';

// // Helper para convertir string con formato chileno → number
const parseChileanNumber = (val: string | number): number => {
  if (typeof val === 'number') return val;
  if (!val) return 0;
  const cleaned = val.toString().trim().replace(/\./g, '').replace(/,/g, '.');
  return parseFloat(cleaned) || 0;
};

// // Esquema que acepta string O number, pero siempre devuelve number
const numberFromStringOrNumber = z
  .union([z.string(), z.number()])
  .transform((val) => {
    return parseChileanNumber(val as any);
  });

// export const cotizacionSchema = z.object({
//   id: z.number().optional(),
//   nombre: z.string().min(1, 'Requerido'),
//   direccion: z.string().min(1, 'Requerido'),
//   telefono: z.string().min(1, 'Requerido'),
//   email: z.string().email('Email inválido'),
//   ciudad: z.string().min(1, 'Requerido'),
//   detalles: z
//     .array(
//       z.object({
//         id: z.number().optional(),
//         descripcion: z.string().min(1, 'Requerido'),
//         area: numberFromStringOrNumber,
//         precio_unitario: numberFromStringOrNumber,
//         total: numberFromStringOrNumber,
//       }),
//     )
//     .min(1, 'Debe haber al menos un detalle'),
// });

// export type CotizacionForm = z.infer<typeof cotizacionSchema>;
// ------------------------------------------------

export const cotizacionSchema = z.object({
  id: z.number().optional(),
  nombre: z.string().min(1, 'Requerido'),
  direccion: z.string().min(1, 'Requerido'),
  telefono: z.string().min(1, 'Requerido'),
  email: z.string().email('Email inválido'),
  ciudad: z.string().min(1, 'Requerido'),
  detalles: z
    .array(
      z.object({
        id: z.number().optional(),
        descripcion: z.string().min(1, 'Requerido'),
        // area: z.number().min(0, 'Debe ser positivo'),
        area: z.number().min(0, 'Debe ser positivo'),
        precio_unitario: z.number().min(0, 'Debe ser positivo'),
        total: z.number().min(0, 'Debe ser positivo'),
      }),
    )
    .min(1, 'Al menos un detalle'),
});

export type CotizacionForm = z.infer<typeof cotizacionSchema>;
