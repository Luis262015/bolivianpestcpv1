// resources/js/components/landing/Navbar.tsx   (o donde lo tengas)

import { Button } from '@/components/ui/button';
import { Facebook, Instagram, MapPin, Menu, Phone } from 'lucide-react';
import { useState } from 'react';

import { Sheet, SheetContent, SheetTrigger } from '@/components/ui/sheet';

const navigation = [
  { name: 'Inicio', href: '#' },
  { name: 'Nosotros', href: '#nosotros' },
  { name: 'Servicios', href: '#servicios' },
  { name: 'Portafolio', href: '#portafolio' },
  { name: 'Clientes', href: '#clientes' },
  { name: 'Contáctenos', href: '#contacto' },
];

interface NavbarProps {
  logo?: string;
}

export default function Navbar({ logo = '/images/logo.png' }: NavbarProps) {
  const [open, setOpen] = useState(false);
  return (
    <header className="fixed top-0 right-0 left-0 z-50 bg-gray-900/50 shadow-lg">
      <nav className="container mx-auto flex h-16 items-center justify-between px-4 lg:px-8">
        {/* Logo + Nombre */}
        <div className="flex items-center gap-3">
          <img
            src={logo}
            alt="BolivianPest"
            className="h-60 w-60 object-contain"
          />
        </div>

        {/* Menú en pantallas grandes */}
        <div className="hidden items-center gap-8 lg:flex">
          {navigation.map((item) => (
            <a
              key={item.name}
              href={item.href}
              className="font-medium text-white transition-colors duration-200 hover:text-cyan-300"
            >
              {item.name}
            </a>
          ))}
        </div>

        {/* Redes sociales + botón móvil */}
        <div className="flex items-center gap-4">
          {/* Iconos redes sociales (pantallas grandes) */}
          <div className="hidden items-center gap-3 md:flex">
            <a
              href="#"
              target="_blank"
              className="text-white transition hover:text-cyan-300"
            >
              <Instagram className="h-5 w-5" />
            </a>
            <a
              href="https://www.facebook.com/p/Bolivian-Pest-Higiene-Ambiental-61572172198692/"
              target="_blank"
              className="text-white transition hover:text-cyan-300"
            >
              <Facebook className="h-5 w-5" />
            </a>
            <a
              href="https://wa.me/59176738282"
              target="_blank"
              className="text-white transition hover:text-cyan-300"
            >
              <Phone className="h-5 w-5" />
            </a>
            <a
              href="https://maps.app.goo.gl/jUskCwmwawdAVt9A8?g_st=awb"
              target="_blank"
              className="text-white transition hover:text-cyan-300"
            >
              <MapPin className="h-5 w-5" />
            </a>
          </div>

          {/* Menú hamburguesa (móvil) */}
          <Sheet>
            <SheetTrigger asChild>
              <Button
                variant="ghost"
                size="icon"
                className="text-white hover:bg-gray-800/40 lg:hidden"
              >
                <Menu className="h-6 w-6" />
              </Button>
            </SheetTrigger>
            <SheetContent
              side="right"
              className="border-red-800/0 bg-gray-700/40"
            >
              <div className="mt-8 flex flex-col gap-6">
                {navigation.map((item) => (
                  <a
                    key={item.name}
                    href={item.href}
                    className="ml-3 text-lg font-medium text-white hover:text-cyan-300"
                  >
                    {item.name}
                  </a>
                ))}
                <div className="mt-6 ml-3 flex gap-4">
                  <a href="#" target="_blank" className="text-white">
                    <Instagram className="h-6 w-6" />
                  </a>
                  <a
                    href="https://www.facebook.com/p/Bolivian-Pest-Higiene-Ambiental-61572172198692/"
                    target="_blank"
                    className="text-white"
                  >
                    <Facebook className="h-6 w-6" />
                  </a>
                  <a
                    href="https://wa.me/59176738282"
                    target="_blank"
                    className="text-white"
                  >
                    <Phone className="h-6 w-6" />
                  </a>
                  <a
                    href="https://maps.app.goo.gl/jUskCwmwawdAVt9A8?g_st=awb"
                    target="_blank"
                  >
                    <MapPin className="h-6 w-6" />
                  </a>
                </div>
              </div>
            </SheetContent>
          </Sheet>
        </div>
      </nav>
    </header>
  );
}
