// ------------------------------------------------------------------------------
import { Link } from '@inertiajs/react';
import { Facebook, Instagram, Linkedin, Mail, MapPin } from 'lucide-react';
import { useState } from 'react';

interface NavbarProps {
  logo?: string;
}

export default function Navbar({ logo = '/images/logo.png' }: NavbarProps) {
  const [open, setOpen] = useState(false);

  return (
    <nav className="fixed z-50 w-full bg-[#013147b3] shadow-sm backdrop-blur-md transition-all duration-300">
      <div className="mx-auto bg-[#fd0f3b] px-4">
        <div className="mx-auto flex max-w-[1300px] items-center justify-between px-4 py-1 text-[.8rem]">
          <div className="flex">
            <Mail size={20} className="me-2" />
            <span className="me-4">info@bolivianpest.com</span>
            <MapPin size={20} className="me-2" />
            <span>info@bolivianpest.com</span>
          </div>
          <div className="flex gap-3">
            <Facebook size={20} />
            <Instagram size={20} />
            <Linkedin size={20} />
          </div>
        </div>
      </div>
      <div className="mx-auto flex max-w-[1300px] items-center justify-between px-4 py-3">
        {/* LOGO */}
        <Link href="/" className="flex items-center">
          <img
            src={logo}
            alt="Logo"
            className="h-12 w-auto object-contain md:h-14"
          />
        </Link>

        {/* BOTÓN MENÚ MÓVIL */}
        <button
          onClick={() => setOpen(!open)}
          className="text-3xl text-white focus:outline-none md:hidden"
        >
          ☰
        </button>

        {/* MENÚ ESCRITORIO */}
        <ul className="hidden gap-8 text-[1rem] text-white md:flex">
          <li>
            <Link href="/" className="hover:text-yellow-300">
              Inicio
            </Link>
          </li>
          <li>
            <Link href="/servicios" className="hover:text-yellow-300">
              Nosotros
            </Link>
          </li>
          <li>
            <Link href="/portafolio" className="hover:text-yellow-300">
              Servicios
            </Link>
          </li>
          <li>
            <Link href="/contacto" className="hover:text-yellow-300">
              Portafolio
            </Link>
          </li>
          <li>
            <Link href="/contacto" className="hover:text-yellow-300">
              Elígenos
            </Link>
          </li>

          <li>
            <Link className="rounded-full bg-[#fd0f3b] px-4 py-2 hover:bg-[#fd0ffb]">
              Contactenos
            </Link>
          </li>
        </ul>
      </div>

      {/* MENÚ MÓVIL */}
      {open && (
        <ul className="mt-3 flex flex-col space-y-4 bg-[#013147b3] px-6 py-4 text-white backdrop-blur-md md:hidden">
          <li>
            <Link href="/" onClick={() => setOpen(false)}>
              Inicio
            </Link>
          </li>
          <li>
            <Link href="/servicios" onClick={() => setOpen(false)}>
              Servicios
            </Link>
          </li>
          <li>
            <Link href="/portafolio" onClick={() => setOpen(false)}>
              Portafolio
            </Link>
          </li>
          <li>
            <Link href="/contacto" onClick={() => setOpen(false)}>
              Contacto
            </Link>
          </li>
          <li>
            <Link className="rouded-full bg-[#fd0f3b]">Contactenos</Link>
          </li>
        </ul>
      )}
    </nav>
  );
}

//-----------------------------------------------------------------------------------------------
// import { Button } from '@headlessui/react';
// import { Link } from '@inertiajs/react';
// import { useEffect, useState } from 'react';

// interface NavbarProps {
//   logo?: string;
//   solidBg?: string; // fondo sólido
//   solidText?: string; // texto sólido
//   transparentText?: string; // texto cuando está transparente
//   transparent?: boolean; // inicia transparente
// }

// export default function Navbar({
//   logo = '/images/logo.png',
//   transparent = true,
// }: NavbarProps) {
//   const [open, setOpen] = useState(false);
//   const [solid, setSolid] = useState(!transparent);

//   useEffect(() => {
//     if (!transparent) return;

//     const handleScroll = () => {
//       setSolid(window.scrollY > 50);
//     };

//     window.addEventListener('scroll', handleScroll);
//     return () => window.removeEventListener('scroll', handleScroll);
//   }, [transparent]);

//   return (
//     <nav
//       // className={`fixed z-50 w-full transition-all duration-300 ${solid ? `${solidBg} ${solidText} shadow-md` : `bg-transparent ${transparentText}`} `}
//       className={`fixed z-50 w-full bg-[#013147b3] shadow-sm backdrop-blur-md transition-all duration-300`}
//     >
//       <div className="mx-auto flex max-w-7xl max-w-[1300px] items-center justify-between px-4 py-3">
//         {/* LOGO */}
//         <Link href="/" className="flex items-center">
//           <img
//             src={logo}
//             alt="Logo"
//             className="h-12 w-auto object-contain transition-all md:h-14"
//           />
//         </Link>

//         {/* BOTÓN MENÚ MÓVIL */}
//         <button
//           onClick={() => setOpen(!open)}
//           className="text-3xl focus:outline-none md:hidden"
//         >
//           ☰
//         </button>

//         {/* MENÚ ESCRITORIO */}
//         <ul className="hidden gap-8 text-lg md:flex">
//           <li>
//             <Link href="/" className="hover:text-yellow-300">
//               Inicio
//             </Link>
//           </li>
//           <li>
//             <Link href="/servicios" className="hover:text-[#fd0f3b]">
//               Servicios
//             </Link>
//           </li>
//           <li>
//             <Link href="/portafolio" className="hover:text-yellow-300">
//               Portafolio
//             </Link>
//           </li>
//           <li>
//             <Link href="/contacto" className="hover:text-yellow-300">
//               Contacto
//             </Link>
//           </li>
//           <li>
//             <Button></Button>
//           </li>
//         </ul>
//       </div>

//       {/* MENÚ MÓVIL */}
//       {open && (
//         <ul className="mt-3 flex animate-[slideDown_0.3s_ease] flex-col space-y-4 bg-blue-950 px-6 py-4 text-lg md:hidden">
//           <li>
//             <Link href="/" onClick={() => setOpen(false)}>
//               Inicio
//             </Link>
//           </li>
//           <li>
//             <Link
//               href="/servicios"
//               className="text-center hover:text-[#fd0f3b]"
//               onClick={() => setOpen(false)}
//             >
//               Servicios
//             </Link>
//           </li>
//           <li>
//             <Link href="/portafolio" onClick={() => setOpen(false)}>
//               Portafolio
//             </Link>
//           </li>
//           <li>
//             <Link href="/contacto" onClick={() => setOpen(false)}>
//               Contacto
//             </Link>
//           </li>
//         </ul>
//       )}
//     </nav>
//   );
// }
