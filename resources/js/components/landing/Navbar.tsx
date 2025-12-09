// resources/js/components/landing/Navbar.tsx   (o donde lo tengas)

import { Instagram, Facebook, Phone, MapPin, Menu } from "lucide-react"
import { Button } from "@/components/ui/button"
import { useState } from 'react';

import {
  Sheet,
  SheetContent,
  SheetTrigger,
} from "@/components/ui/sheet"

const navigation = [
  { name: "Inicio", href: "#" },
  { name: "Nosotros", href: "#nosotros" },
  { name: "Servicios", href: "#servicios" },
  { name: "Portafolio", href: "#portafolio" },
  { name: "Clientes", href: "#clientes" },
  { name: "Contáctenos", href: "#contacto" },
]

interface NavbarProps {
  logo?: string;
}
  

export default function Navbar({ logo = '/images/logo.png' }: NavbarProps) {
  const [open, setOpen] = useState(false);
  return (
    <header className="fixed top-0 left-0 right-0 z-50 bg-gray-900/50 shadow-lg">
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
        <div className="hidden lg:flex items-center gap-8">
          {navigation.map((item) => (
            <a
              key={item.name}
              href={item.href}
              className="text-white font-medium hover:text-cyan-300 transition-colors duration-200"
            >
              {item.name}
            </a>
          ))}
        </div>

        {/* Redes sociales + botón móvil */}
        <div className="flex items-center gap-4">
          {/* Iconos redes sociales (pantallas grandes) */}
          <div className="hidden md:flex items-center gap-3">
            <a href="#" target="_blank" className="text-white hover:text-cyan-300 transition">
              <Instagram className="h-5 w-5" />
            </a>
            <a href="https://www.facebook.com/p/Bolivian-Pest-Higiene-Ambiental-61572172198692/" target="_blank" className="text-white hover:text-cyan-300 transition">
              <Facebook className="h-5 w-5" />
            </a>
            <a href="https://wa.me/59176738282" target="_blank" className="text-white hover:text-cyan-300 transition">
              <Phone className="h-5 w-5" />
            </a>
            <a href="https://maps.app.goo.gl/jUskCwmwawdAVt9A8?g_st=awb" target="_blank" className="text-white hover:text-cyan-300 transition">
              <MapPin className="h-5 w-5" />
            </a>
          </div>

          {/* Menú hamburguesa (móvil) */}
          <Sheet>
            <SheetTrigger asChild>
              <Button variant="ghost" size="icon" className="lg:hidden text-white hover:bg-gray-800/40">
                <Menu className="h-6 w-6" />
              </Button>
            </SheetTrigger>
            <SheetContent side="right" className="bg-gray-700/40 border-red-800/0">
              <div className="flex flex-col gap-6 mt-8">
                {navigation.map((item) => (
                  <a
                    key={item.name}
                    href={item.href}
                    className="text-white text-lg font-medium hover:text-cyan-300 ml-3"
                  >
                    {item.name}
                  </a>
                ))}
                <div className="flex gap-4 mt-6 ml-3">
                  <a href="#" target="_blank" className="text-white"><Instagram className="h-6 w-6" /></a>
                  <a href="https://www.facebook.com/p/Bolivian-Pest-Higiene-Ambiental-61572172198692/" target="_blank" className="text-white"><Facebook className="h-6 w-6" /></a>
                  <a href="https://wa.me/59176738282" target="_blank" className="text-white"><Phone className="h-6 w-6" /></a>
                  <a href="https://maps.app.goo.gl/jUskCwmwawdAVt9A8?g_st=awb" target="_blank"><MapPin className="h-6 w-6" />
            </a>
                </div>
              </div>
            </SheetContent>
          </Sheet>
        </div>
      </nav>
    </header>
  )
}