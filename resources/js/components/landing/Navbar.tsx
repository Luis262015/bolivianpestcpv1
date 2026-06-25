// resources/js/components/landing/Navbar.tsx

import { Button } from '@/components/ui/button';
import { Facebook, Instagram, MapPin, Menu, Phone } from 'lucide-react';
import { useEffect, useState } from 'react';

import { Sheet, SheetContent, SheetTrigger } from '@/components/ui/sheet';

const navigation = [
  { name: 'Inicio', href: '#' },
  { name: 'Nosotros', href: '#nosotros' },
  { name: 'Servicios', href: '#servicios' },
  { name: 'Portafolio', href: '#portafolio' },
  // { name: 'Clientes', href: '#clientes' },
  { name: 'Contáctenos', href: '#contacto' },
];

interface NavbarProps {
  logo?: string;
  ctaText?: string;
  whatsapp?: string;
  facebook?: string;
  instagram?: string;
  location?: string;
}

export default function Navbar({
  logo = '/images/logo.png',
  ctaText = 'Cotizar',
  whatsapp = 'https://wa.me/59176738282',
  facebook = 'https://www.facebook.com/p/Bolivian-Pest-Higiene-Ambiental-61572172198692/',
  instagram = 'https://www.instagram.com/bolivian_pest?igsh=MTF4dHFjZGoxMzlocQ==',
  location = 'https://maps.app.goo.gl/jUskCwmwawdAVt9A8?g_st=awb',
}: NavbarProps) {
  const socials = [
    { label: 'Instagram', href: instagram, Icon: Instagram },
    { label: 'Facebook', href: facebook, Icon: Facebook },
    { label: 'WhatsApp', href: whatsapp, Icon: Phone },
    { label: 'Ubicación', href: location, Icon: MapPin },
  ];

  const [scrolled, setScrolled] = useState(false);
  const [activeId, setActiveId] = useState('');

  useEffect(() => {
    const onScroll = () => setScrolled(window.scrollY > 24);
    onScroll();
    window.addEventListener('scroll', onScroll, { passive: true });
    return () => window.removeEventListener('scroll', onScroll);
  }, []);

  // Scroll spy: marca la sección visible en el nav
  useEffect(() => {
    const ids = navigation
      .map((n) => n.href)
      .filter((h) => h.startsWith('#') && h.length > 1)
      .map((h) => h.slice(1));
    const sections = ids
      .map((id) => document.getElementById(id))
      .filter((el): el is HTMLElement => el !== null);
    if (sections.length === 0) return;

    const observer = new IntersectionObserver(
      (entries) => {
        const visible = entries
          .filter((e) => e.isIntersecting)
          .sort((a, b) => b.intersectionRatio - a.intersectionRatio);
        if (visible[0]) setActiveId(visible[0].target.id);
      },
      { rootMargin: '-45% 0px -50% 0px', threshold: [0, 0.25, 0.5, 1] },
    );
    sections.forEach((s) => observer.observe(s));

    // Cerca del tope → "Inicio" activo
    const onTop = () => {
      if (window.scrollY < 120) setActiveId('');
    };
    window.addEventListener('scroll', onTop, { passive: true });
    onTop();

    return () => {
      observer.disconnect();
      window.removeEventListener('scroll', onTop);
    };
  }, []);

  const isActive = (href: string) =>
    href === '#' ? activeId === '' : href === `#${activeId}`;

  return (
    <header
      className={`fixed top-0 right-0 left-0 z-50 border-b transition-all duration-300 ${
        scrolled
          ? 'border-white/10 bg-[#013147]/90 shadow-lg shadow-black/20 backdrop-blur-md'
          : 'border-transparent bg-gradient-to-b from-black/55 via-black/25 to-transparent'
      }`}
    >
      <nav className="relative container mx-auto flex h-16 items-center justify-between px-4 md:h-[68px] lg:px-8">
        {/* Logo */}
        <a href="#" className="flex items-center gap-3">
          <img
            src={logo}
            alt="BolivianPest"
            className={`object-contain transition-all duration-300 ${
              scrolled ? 'h-10' : 'h-12'
            } w-auto`}
          />
        </a>

        {/* Menú en pantallas grandes */}
        <div className="absolute left-1/2 hidden -translate-x-1/2 lg:block">
          <div className="flex items-center gap-1 rounded-full border border-white/10 bg-white/5 p-1 backdrop-blur-sm">
            {navigation.map((item) => {
              const active = isActive(item.href);
              return (
                <a
                  key={item.name}
                  href={item.href}
                  aria-current={active ? 'page' : undefined}
                  className={`rounded-full px-4 py-1.5 text-sm font-medium transition-colors duration-200 ${
                    active
                      ? 'bg-cyan-400/20 text-cyan-100 ring-1 ring-cyan-300/30'
                      : 'text-white/80 hover:bg-white/10 hover:text-white'
                  }`}
                >
                  {item.name}
                </a>
              );
            })}
          </div>
        </div>

        {/* Redes + CTA + botón móvil */}
        <div className="flex items-center gap-3">
          {/* Iconos redes sociales (md+) */}
          <div className="hidden items-center gap-1 md:flex">
            {socials.map(({ label, href, Icon }) => (
              <a
                key={label}
                href={href}
                target="_blank"
                rel="noopener noreferrer"
                aria-label={label}
                className="flex h-9 w-9 items-center justify-center rounded-full text-white/80 transition-all duration-200 hover:scale-110 hover:bg-white/10 hover:text-cyan-300"
              >
                <Icon className="h-[18px] w-[18px]" />
              </a>
            ))}
          </div>

          {/* Divisor */}
          <span className="hidden h-6 w-px bg-white/15 lg:block" />

          {/* CTA WhatsApp (lg+) */}
          <a
            href={whatsapp}
            target="_blank"
            rel="noopener noreferrer"
            className="hidden items-center gap-2 rounded-full bg-green-600 px-5 py-2 text-sm font-semibold text-white shadow-lg shadow-green-900/30 ring-1 ring-green-400/30 transition-all duration-200 hover:scale-105 hover:bg-green-500 hover:shadow-green-500/30 lg:inline-flex"
          >
            <Phone className="h-4 w-4" />
            {ctaText}
          </a>

          {/* Menú hamburguesa (móvil) */}
          <Sheet>
            <SheetTrigger asChild>
              <Button
                variant="ghost"
                size="icon"
                aria-label="Abrir menú"
                className="text-white hover:bg-white/10 lg:hidden"
              >
                <Menu className="h-6 w-6" />
              </Button>
            </SheetTrigger>
            <SheetContent
              side="right"
              className="border-white/10 bg-[#013147]/95 backdrop-blur-md"
            >
              <div className="mt-10 flex flex-col gap-2 px-2">
                {navigation.map((item) => {
                  const active = isActive(item.href);
                  return (
                    <a
                      key={item.name}
                      href={item.href}
                      aria-current={active ? 'page' : undefined}
                      className={`rounded-lg px-3 py-2.5 text-lg font-medium transition-colors hover:bg-white/10 hover:text-cyan-300 ${
                        active ? 'bg-white/10 text-cyan-300' : 'text-white'
                      }`}
                    >
                      {item.name}
                    </a>
                  );
                })}

                <a
                  href={whatsapp}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="mt-3 inline-flex items-center justify-center gap-2 rounded-full bg-green-600 px-5 py-3 font-semibold text-white transition hover:bg-green-500"
                >
                  <Phone className="h-5 w-5" />
                  Cotizar por WhatsApp
                </a>

                <div className="mt-6 flex gap-3 px-3">
                  {socials.map(({ label, href, Icon }) => (
                    <a
                      key={label}
                      href={href}
                      target="_blank"
                      rel="noopener noreferrer"
                      aria-label={label}
                      className="flex h-10 w-10 items-center justify-center rounded-full bg-white/10 text-white transition hover:bg-white/20 hover:text-cyan-300"
                    >
                      <Icon className="h-5 w-5" />
                    </a>
                  ))}
                </div>
              </div>
            </SheetContent>
          </Sheet>
        </div>
      </nav>
    </header>
  );
}
