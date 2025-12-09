// 'use client';

// import { useState, useEffect } from 'react';



// export default function SplashScreen() {
//   const [show, setShow] = useState(true);
  

//   useEffect(() => {
//     const timer = setTimeout(() => {
//       setShow(false);
//     }, 2000);

//     return () => clearTimeout(timer);
//   }, []);

//   return (
//     <div 
//       className={`fixed inset-0 z-[9999] flex items-center justify-center bg-[#013147] transition-opacity duration-700 ease-out ${
//         show ? 'opacity-100' : 'opacity-0 pointer-events-none'
//       }`}
//     >
//         <div className="animate-[pulse_2s_ease-in-out]">
//         <img
//       src= "/images/LogoFC.svg"
//       alt="BolivianPest"
//       width={320}
//       height={320}
//       className="w-80 md:w-96 h-auto drop-shadow-2xl"
//     />
//     </div>
//       {/* <div className="animate-pulse">
//         <Shield className="h-20 w-20 text-white" />
//       </div> */}
//     </div>
//   );
// }
'use client';

import { useState, useEffect } from 'react';


export default function SplashScreen() {
  const [isLoading, setIsLoading] = useState(true);

  useEffect(() => {
    // 1. Esperamos que carguen TODAS las imágenes de la página
    const images = document.querySelectorAll('img');
    let loadedImages = 0;

    if (images.length === 0) {
      // Si no hay imágenes, quitamos el splash rápido
      setTimeout(() => setIsLoading(false), 300);
      return;
    }

    const imageLoaded = () => {
      loadedImages++;
      if (loadedImages === images.length) {
        // Todas las imágenes cargaron → quitamos el splash
        setIsLoading(false);
      }
    };

    images.forEach((img) => {
      if (img.complete) {
        imageLoaded();
      } else {
        img.addEventListener('load', imageLoaded);
        img.addEventListener('error', imageLoaded); // por si falla alguna
      }
    });

    // 2. También esperamos que carguen las fuentes (opcional pero recomendado)
    if ('fonts' in document) {
      document.fonts.ready.then(() => {
        // Si ya terminaron las imágenes o no hay, quitamos el splash
        if (loadedImages >= images.length) {
          setIsLoading(false);
        }
      });
    }

    // 3. Máximo 6 segundos (por si algo falla, nunca se queda colgado)
    const maxTimeout = setTimeout(() => {
      setIsLoading(false);
    }, 6000);

    return () => {
      clearTimeout(maxTimeout);
    };
  }, []);

  if (!isLoading) return null;

  return (
    <div className="fixed inset-0 z-[9999] flex items-center justify-center bg-[#013147] transition-opacity duration-700 ease-out">
      <div className="text-center">
        <div className="animate-pulse mb-8">
          <img
            src="/images/LogoFC.webp"
            className="w-64 md:w-80 h-auto mx-auto animate-[float_3s_ease-in-out_infinite] drop-shadow-2xl"
            
          />
          {/* Pequeño destello que pasa por encima */}
            <div className="absolute top-0 left-0 w-full h-full overflow-hidden">
                <div className="absolute top-10 -left-32 w-32 h-64 bg-gradient-to-r from-transparent via-white/30 to-transparent rotate-12 animate-shine" />
            </div>
        </div>

        {/* Barra de progreso opcional (queda muy pro) */}
        {/* <div className="w-64 h-2 bg-white/20 rounded-full overflow-hidden mx-auto">
          <div className="h-full bg-white rounded-full animate-pulse w-3/4" />
        </div> */}

        <p className="mt-6 text-white/80 text-sm animate-pulse">
          Cargando...
        </p>
      </div>
    </div>
  );
}