import { wayfinder } from '@laravel/vite-plugin-wayfinder';
import tailwindcss from '@tailwindcss/vite';
import react from '@vitejs/plugin-react';
import laravel from 'laravel-vite-plugin';
import { defineConfig } from 'vite';

export default defineConfig({
    plugins: [
        laravel({
            input: ['resources/css/app.css', 'resources/js/app.tsx'],
            ssr: 'resources/js/ssr.tsx',
            refresh: true,
        }),
        react({
            babel: {
                plugins: ['babel-plugin-react-compiler'],
            },
        }),
        tailwindcss(),
        wayfinder({
            formVariants: true,
        }),
    ],
    esbuild: {
        jsx: 'automatic',
        // Red de seguridad: marca console.log/debug como libres de efectos para
        // que el minificador los elimine del build de producción. No se usa
        // `drop: ['console']` a propósito, porque eso también borraría los
        // console.error de los bloques catch, que sí queremos conservar.
        pure: ['console.log', 'console.debug'],
    },
});
