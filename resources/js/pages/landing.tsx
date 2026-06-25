import CountUp from '@/components/landing/CountUp';
import Navbar from '@/components/landing/Navbar';
import Reveal from '@/components/landing/Reveal';
import WhatsAppFloat from '@/components/landing/WhatsAppFloat';
import {
  Accordion,
  AccordionContent,
  AccordionItem,
  AccordionTrigger,
} from '@/components/ui/accordion';
import { Head, usePage } from '@inertiajs/react';
import { ComponentType, useEffect } from 'react';
import { Autoplay, EffectFade, Navigation, Pagination } from 'swiper/modules';
import { Swiper, SwiperSlide } from 'swiper/react';
import styles from './landing.module.css';

import SplashScreen from '@/components/SplashScreen';
import {
  ArrowRight,
  BadgeCheck,
  Bug,
  Building2,
  Check,
  CheckCircle2,
  Clock,
  Facebook,
  Factory,
  Home,
  HouseWifi,
  Instagram,
  Leaf,
  Mail,
  MapPin,
  Phone,
  Play,
  Rat,
  Settings,
  Shield,
  ShieldCheck,
  Siren,
  Snail,
  Sparkles,
  Star,
} from 'lucide-react';
import 'swiper/css';
import 'swiper/css/autoplay';
import 'swiper/css/effect-fade';
import 'swiper/css/navigation';
import 'swiper/css/pagination';

// Mapa de iconos: las colecciones guardan el nombre del icono como texto.
const ICONS: Record<string, ComponentType<{ size?: number; strokeWidth?: number; className?: string }>> = {
  Factory, Rat, Snail, HouseWifi, Building2, Siren, Settings, ShieldCheck,
  BadgeCheck, Bug, Home, Shield, Sparkles, Leaf, Clock, Phone, Star, CheckCircle2,
};
const iconFor = (name?: string) => ICONS[name ?? ''] ?? ShieldCheck;

/* ------------------------------------------------------------------ */
/* Valores por defecto (se usan si la configuración no está cargada)   */
/* ------------------------------------------------------------------ */
const DEFAULT_SLIDES = [
  { img: '/images/slider/sli1.webp', alt: 'Servicio de control de plagas en hogar boliviano - Fumigación profesional' },
  { img: '/images/slider/sli2.webp', alt: 'Equipo profesional de Bolivian Pest realizando fumigación comercial' },
  { img: '/images/slider/sli3.webp', alt: 'Control de termitas y roedores en oficinas y negocios' },
  { img: '/images/slider/sli4.webp', alt: 'Servicio de fumigación 24/7 para emergencias de plagas' },
];

const DEFAULT_FEATURES = [
  { icon: '/images/icons/coberturab.svg', title: 'Cobertura Integral', alt: 'Servicio de control de plagas con cobertura nacional en Bolivia' },
  { icon: '/images/icons/tiempob.svg', title: 'Tiempos de respuesta rápidos', alt: 'Respuesta rápida de emergencia en control de plagas' },
  { icon: '/images/icons/serviciob.svg', title: 'Servicios comerciales', alt: 'Servicios de fumigación para negocios y empresas' },
  { icon: '/images/icons/emergenciab.svg', title: 'Servicio de Emergencia 24/7', alt: 'Servicio de emergencia de control de plagas disponible 24 horas' },
];

const DEFAULT_SERVICES = [
  { img: '/images/servicio-fumigacion-comercial.webp', alt: 'Fumigación comercial para negocios', icon: 'Factory', category: 'Comercial', title: 'Soluciones comerciales para el control de plagas', desc: 'Protección completa para restaurantes, oficinas y negocios. Cumplimos normas de salubridad — garantía de resultados.' },
  { img: '/images/servicio-exterminacion-termitas.webp', alt: 'Exterminación profesional de termitas y roedores', icon: 'Rat', category: 'Termitas & Roedores', title: 'Control de termitas y roedores', desc: 'Eliminación total y prevención de daños estructurales. Si vuelven, volvemos gratis — garantía escrita.' },
  { img: '/images/servicio-hogar-inteligente.webp', alt: 'Control de plagas en espacios exteriores', icon: 'Snail', category: 'Exteriores', title: 'Control de plagas en exteriores', desc: 'Disfrute su patio sin mosquitos, hormigas ni plagas. Tratamientos ecológicos seguros para mascotas.' },
  { img: '/images/servicio-control-exteriores.webp', alt: 'Protección completa del hogar contra plagas', icon: 'HouseWifi', category: 'Residencial', title: 'Protección residencial completa', desc: 'Hogar seguro para su familia — sin cucarachas, hormigas ni chinches. Inspección gratuita incluida.' },
  { img: '/images/servicio-fumigacion-residencial.webp', alt: 'Protección completa del hogar contra plagas', icon: 'Building2', category: 'Hogar', title: 'Control de plagas residenciales', desc: 'Protección completa para su hogar — cucarachas, hormigas y más. Visitas programadas o servicio único. Sin compromiso.' },
];

const DEFAULT_PORTFOLIO_VIDEOS = [
  { id: '7471413968603467063', label: 'Control en hogares' },
  { id: '7470332967810780422', label: 'Plagas en negocios' },
  { id: '7468916199028509957', label: 'Control en exteriores' },
];

const DEFAULT_OURFEATURES = [
  { icon: 'Siren', iconWrap: 'bg-red-50 text-red-600 dark:bg-red-950/40 dark:text-red-400', title: 'Servicios de emergencia', desc: 'Estamos disponibles las 24 horas para atender su emergencia, incluso feriados.' },
  { icon: 'Settings', iconWrap: 'bg-blue-50 text-blue-600 dark:bg-blue-950/40 dark:text-blue-400', title: 'Tratamientos personalizados', desc: 'Cada propiedad es única, por lo que diseñamos soluciones específicas para su caso.' },
  { icon: 'ShieldCheck', iconWrap: 'bg-green-50 text-green-600 dark:bg-green-950/40 dark:text-green-400', title: 'Profesionales certificados', desc: 'Nuestro equipo está altamente capacitado, certificado y con años de experiencia comprobada.' },
  { icon: 'BadgeCheck', iconWrap: 'bg-emerald-50 text-emerald-600 dark:bg-emerald-950/40 dark:text-emerald-400', title: 'Resultados garantizados', desc: 'Respaldamos nuestro trabajo con garantía por escrito. Si vuelven, ¡volvemos gratis!' },
];

const DEFAULT_BENEFITS = [
  'Experiencia en la que puede confiar',
  'Disponibilidad 24/7',
  'Profesionales certificados',
  'Soluciones asequibles',
  'Enfoque ecológico',
  'Técnicas avanzadas',
  'Servicio centrado en el cliente',
  'Compromiso con la excelencia',
];

const DEFAULT_STATS = [
  { end: 29, suffix: '+', label: 'Años de experiencia' },
  { end: 2, suffix: 'K', label: 'Proyectos finalizados' },
  { end: 50, suffix: '', label: 'Equipo dedicado' },
  { end: 98, suffix: '%', label: 'Clientes satisfechos' },
];

const DEFAULT_CHIPS = ['Disponibles 24/7', 'En toda Bolivia', 'Garantía por escrito'];

const DEFAULT_FAQS = [
  { question: '¿Qué tipos de plagas tratan?', answer: '<p>Controlamos una amplia variedad de plagas, incluyendo <strong>roedores, hormigas, cucarachas, termitas, chinches, mosquitos, arañas y fauna silvestre.</strong></p><p>Aplicamos métodos específicos según la especie para garantizar resultados efectivos.</p>' },
  { question: '¿Son seguros sus métodos de control de plagas para mis mascotas?', answer: '<p>Sí. Todos nuestros productos y procedimientos están certificados y son seguros para mascotas y personas, siempre y cuando se sigan las indicaciones del técnico. Utilizamos productos de baja toxicidad, aprobados por <strong>SENASAG</strong>, y aplicados bajo estándares profesionales para evitar cualquier riesgo. Además, brindamos instrucciones claras sobre el tiempo de reingreso y cuidados posteriores para garantizar la seguridad de tus animales domésticos.</p>' },
  { question: '¿Con qué frecuencia debo programar los servicios?', answer: '<p>La frecuencia depende del tipo de plaga y del entorno:</p><ul><li><strong>Hogares:</strong> cada 3 a 4 meses suele ser suficiente para mantener un ambiente libre de plagas.</li><li><strong>Comercios:</strong> recomendamos un servicio mensual o bimensual, especialmente si hay almacenamiento de alimentos.</li><li><strong>Industrias y restaurantes:</strong> servicios mensuales o incluso quincenales, de acuerdo con normas de salubridad.</li></ul><p>Nuestros técnicos evalúan tu caso y generan un plan personalizado según el nivel de infestación y las características del lugar.</p>' },
  { question: '¿Ofrecen servicios de control de plagas de emergencia?', answer: '<p>Sí, contamos con servicios de emergencia para infestaciones severas o situaciones que requieren atención inmediata, como:</p><ul><li><strong>Nidos de avispas</strong></li><li><strong>Presencia elevada de roedores</strong></li><li><strong>Brotes de cucarachas en cocinas o negocios</strong></li><li><strong>Invasión de chinches</strong></li><li><strong>Plagas que afecten la operación de tu empresa</strong></li></ul><p>Atendemos en el menor tiempo posible para controlar rápidamente el problema y evitar riesgos para tu salud o tu actividad comercial.</p>' },
  { question: '¿Cómo sé si tengo una plaga?', answer: '<p>Algunas señales comunes incluyen:</p><ul><li><strong>Excrementos pequeños o manchas oscuras (roedores, cucarachas).</strong></li><li><strong>Ruidos dentro de paredes o techos.</strong></li><li><strong>Olores fuertes o desagradables, especialmente en cocinas o depósitos.</strong></li><li><strong>Huecos o montículos en madera o suelo (termitas).</strong></li></ul><p>Si notas cualquiera de estos signos, lo ideal es solicitar una inspección profesional, ya que muchas plagas se esconden y solo un técnico puede detectarlas a tiempo.</p>' },
];

export default function Landing() {
  const { props } = usePage();
  const settings = (props.settings ?? {}) as Record<string, unknown>;

  // Helper de configuración: cfg(key, default)
  const cfg = <T,>(key: string, fallback: T): T => {
    const v = settings[key];
    return v === undefined || v === null || v === '' ? fallback : (v as T);
  };

  // Colecciones
  const slides = cfg('hero.slides', DEFAULT_SLIDES);
  const chips = cfg('hero.chips', DEFAULT_CHIPS);
  const features = cfg('features.items', DEFAULT_FEATURES);
  const benefits = cfg('about.benefits', DEFAULT_BENEFITS);
  const stats = cfg('about.stats', DEFAULT_STATS);
  const services = cfg('services.items', DEFAULT_SERVICES);
  const portfolioVideos = cfg('portfolio.videos', DEFAULT_PORTFOLIO_VIDEOS);
  const ourFeatures = cfg('ourfeatures.items', DEFAULT_OURFEATURES);
  const faqs = cfg('faq.items', DEFAULT_FAQS);

  // Datos de contacto / redes
  const whatsappLink = cfg('social.whatsapp', 'https://wa.me/59176738282');
  const whatsappNumber = cfg('contact.whatsapp_number', '59176738282');
  const tiktokUser = cfg('portfolio.tiktok_user', 'bolivian_pest');
  const facebookLink = cfg('social.facebook', 'https://www.facebook.com/p/Bolivian-Pest-Higiene-Ambiental-61572172198692/');
  const instagramLink = cfg('social.instagram', 'https://www.instagram.com/bolivian_pest?igsh=MTF4dHFjZGoxMzlocQ==');
  const tiktokLink = cfg('social.tiktok', `https://www.tiktok.com/@${tiktokUser}`);
  const emailAddr = cfg('contact.email', 'info@bolivianpest.com');
  const locationLink = cfg('contact.location_link', 'https://maps.app.goo.gl/jUskCwmwawdAVt9A8?g_st=awb');

  const contactInfo = [
    { Icon: Phone, label: 'Teléfono / WhatsApp', value: cfg('contact.phone', '+591 76738282'), href: whatsappLink },
    { Icon: Mail, label: 'Correo electrónico', value: emailAddr, href: `mailto:${emailAddr}` },
    { Icon: MapPin, label: 'Ubicación', value: cfg('contact.location', 'La Paz, Bolivia'), href: locationLink },
    { Icon: Clock, label: 'Atención', value: cfg('contact.schedule', '24/7 · los 365 días'), href: null as string | null },
  ];

  // Carga el script de TikTok al montar para que renderice los embeds
  // de forma fiable (también tras navegación SPA de Inertia).
  useEffect(() => {
    const script = document.createElement('script');
    script.src = 'https://www.tiktok.com/embed.js';
    script.async = true;
    document.body.appendChild(script);
    return () => {
      script.remove();
    };
  }, []);

  const origin = typeof window !== 'undefined' ? window.location.origin : 'https://bolivianpest.com';

  return (
    <>
      <SplashScreen screen={cfg('brand.logo_splash', '/images/LogoBlack.png')} />

      {/* pestaña de navegador */}
      <Head
        title={cfg('seo.title', 'Control de Plagas en Bolivia | Bolivian Pest - Fumigación Profesional')}
        meta={[
          {
            name: 'description',
            content: cfg(
              'seo.description',
              'Bolivian Pest: Servicios profesionales de control de plagas en Bolivia. Fumigación, exterminación de termitas, roedores y más. Atención 24/7. Contacto: +591 76738282',
            ),
          },
          {
            name: 'keywords',
            content: cfg(
              'seo.keywords',
              'control de plagas Bolivia, fumigación La Paz, exterminación de termitas, exterminador roedores, servicios de fumigación Bolivia, empresa control plagas',
            ),
          },
          {
            name: 'author',
            content: 'Bolivian Pest - Higiene Ambiental',
          },
          {
            name: 'robots',
            content: 'index, follow',
          },
          { property: 'og:title', content: cfg('seo.title', 'Control de Plagas en Bolivia | Bolivian Pest') },
          {
            property: 'og:description',
            content: cfg(
              'seo.description',
              'Servicios profesionales de control de plagas en Bolivia. Fumigación, exterminación de termitas, roedores y más. Atención 24/7.',
            ),
          },
          { property: 'og:image', content: cfg('seo.og_image', '/images/og-image.svg') },
          { property: 'og:url', content: 'https://bolivianpest.com' },
          { property: 'og:type', content: 'website' },
          { property: 'og:locale', content: 'es_BO' },
          { property: 'og:site_name', content: 'Bolivian Pest' },
          { name: 'twitter:card', content: 'summary_large_image' },
          { name: 'twitter:title', content: cfg('seo.title', 'Control de Plagas en Bolivia | Bolivian Pest') },
          {
            name: 'twitter:description',
            content: cfg(
              'seo.description',
              'Servicios profesionales de control de plagas en Bolivia. Fumigación, exterminación de termitas, roedores y más. Atención 24/7.',
            ),
          },
          { name: 'twitter:image', content: cfg('seo.og_image', '/images/og-image.svg') },
          { name: 'twitter:site', content: '@bolivian_pest' },
          { name: 'theme-color', content: '#013147' },
        ]}
      >
        <link rel="canonical" href={origin} />
        <link rel="preconnect" href="https://fonts.bunny.net" />
        <link
          href="https://fonts.bunny.net/css?family=inter:200,300,300i,400,400i,500,500i,600,600i,700,800,900"
          rel="stylesheet"
        />
      </Head>

      {/* JSON-LD Structured Data */}
      <script
        type="application/ld+json"
        dangerouslySetInnerHTML={{
          __html: JSON.stringify([
            {
              '@context': 'https://schema.org',
              '@type': 'LocalBusiness',
              name: 'Bolivian Pest - Control de Plagas',
              description:
                'Servicios profesionales de control de plagas en Bolivia. Fumigación, exterminación de termitas, roedores, cucarachas y más. Atención 24/7.',
              url: origin,
              telephone: cfg('contact.phone', '+591 76738282'),
              email: emailAddr,
              address: {
                '@type': 'PostalAddress',
                addressLocality: 'La Paz',
                addressCountry: 'BO',
              },
              geo: {
                '@type': 'GeoCoordinates',
                latitude: -16.499473655781642,
                longitude: -68.12636138046955,
              },
              openingHoursSpecification: {
                '@type': 'OpeningHoursSpecification',
                dayOfWeek: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'],
                opens: '00:00',
                closes: '23:59',
              },
              priceRange: '$$',
              serviceType: [
                'Control de Plagas',
                'Fumigación',
                'Exterminación de Termitas',
                'Exterminación de Roedores',
                'Control de Cucarachas',
                'Control de Hormigas',
              ],
              areaServed: {
                '@type': 'Country',
                name: 'Bolivia',
              },
              image: `${origin}/images/og-image.svg`,
            },
            {
              '@context': 'https://schema.org',
              '@type': 'Organization',
              name: 'Bolivian Pest',
              url: origin,
              logo: `${origin}/images/LogoFC.svg`,
              sameAs: [facebookLink, instagramLink],
              contactPoint: {
                '@type': 'ContactPoint',
                telephone: cfg('contact.phone', '+591 76738282'),
                contactType: 'customer service',
                availableLanguage: 'Spanish',
              },
            },
          ]),
        }}
      />

      <Navbar
        logo={cfg('brand.logo_navbar', '/images/LogoHFCWhite.png')}
        ctaText={cfg('brand.navbar_cta', 'Cotizar')}
        whatsapp={whatsappLink}
        facebook={facebookLink}
        instagram={instagramLink}
        location={locationLink}
      />

      <div className="relative h-[88vh] min-h-[540px] w-full overflow-hidden">
        <Swiper
          spaceBetween={0}
          effect={'fade'}
          loop={true}
          autoplay={{ delay: 9000, disableOnInteraction: false }}
          modules={[Autoplay, EffectFade, Navigation, Pagination]}
          className="mySwiper h-full w-full"
        >
          {slides.map((slide, i) => (
            <SwiperSlide key={i}>
              <img
                src={slide.img}
                className="h-full w-full scale-105 object-cover"
                alt={slide.alt}
                loading={i === 0 ? 'eager' : 'lazy'}
              />
            </SwiperSlide>
          ))}
        </Swiper>

        {/* Overlay con degradado de marca (de oscuro a transparente) */}
        <div className="pointer-events-none absolute inset-0 z-10 bg-gradient-to-r from-[#013147]/95 via-[#013147]/70 to-[#013147]/40" />
        <div className="pointer-events-none absolute inset-0 z-10 bg-gradient-to-t from-[#01243a]/80 via-transparent to-transparent" />

        {/* Overlay con texto y personaje */}
        <div className="absolute inset-0 z-20 flex items-center justify-center">
          <div className="w-full max-w-[1000px] px-6 md:px-10">
            <div className="grid grid-cols-1 items-center gap-8 lg:grid-cols-2 lg:gap-12">
              {/* Personaje - se oculta en ≤1024px (lg y menores) */}
              <div className="hero-anim hidden justify-self-end lg:block" style={{ animationDelay: '0.1s' }}>
                <img
                  src={cfg('hero.character_image', '/images/cta/personaje.webp')}
                  alt="Profesional de Bolivian Pest listo para ayudarlo"
                  className="h-auto max-w-full drop-shadow-2xl"
                />
              </div>

              {/* Texto - centrado en móvil, alineado a la izquierda en desktop */}
              <div className="mx-auto max-w-xl text-center lg:mx-0 lg:text-left">
                <span
                  className="hero-anim mb-5 inline-flex items-center gap-2 rounded-full border border-cyan-300/30 bg-cyan-400/10 px-4 py-1.5 text-xs font-semibold tracking-wide text-cyan-200 uppercase backdrop-blur-sm sm:text-sm"
                  style={{ animationDelay: '0.05s' }}
                >
                  <ShieldCheck className="h-4 w-4" />
                  {cfg('hero.badge', 'Técnicos certificados SENASAG')}
                </span>

                <h1
                  className="hero-anim mb-4 text-3xl leading-[1.1] font-extrabold tracking-tight text-balance text-white drop-shadow-2xl sm:text-4xl md:text-5xl lg:text-[3.1rem]"
                  style={{ animationDelay: '0.15s' }}
                >
                  {cfg('hero.title', 'Elimine cualquier plaga en')}{' '}
                  <span className="text-cyan-300">{cfg('hero.title_highlight', '24 horas')}</span>
                </h1>

                <p
                  className="hero-anim max-w-md text-base leading-relaxed text-pretty text-white/85 drop-shadow-lg max-lg:mx-auto sm:text-lg"
                  style={{ animationDelay: '0.3s' }}
                >
                  {cfg(
                    'hero.subtitle',
                    'Desde termitas hasta roedores, exterminación profesional garantizada. Sin compromiso — agende su inspección hoy.',
                  )}
                </p>

                {/* Chips de confianza (info clave, sin saturar el titular) */}
                <ul
                  className="hero-anim mt-5 flex flex-wrap justify-center gap-x-4 gap-y-2 lg:justify-start"
                  style={{ animationDelay: '0.4s' }}
                >
                  {chips.map((item) => (
                    <li
                      key={item}
                      className="inline-flex items-center gap-1.5 text-sm font-medium text-white/90"
                    >
                      <CheckCircle2 className="h-4 w-4 shrink-0 text-cyan-300" />
                      {item}
                    </li>
                  ))}
                </ul>

                {/* CTAs del Hero */}
                <div
                  className="hero-anim mt-7 flex flex-col gap-3 sm:flex-row sm:justify-center lg:justify-start"
                  style={{ animationDelay: '0.5s' }}
                >
                  <a
                    href={cfg('hero.cta_link', whatsappLink)}
                    target="_blank"
                    rel="noopener noreferrer"
                    className="inline-flex items-center justify-center gap-2 rounded-lg bg-green-600 px-6 py-3.5 font-semibold text-white shadow-xl shadow-green-900/30 transition-all duration-300 hover:scale-105 hover:bg-green-500 hover:shadow-2xl"
                  >
                    <Phone className="h-5 w-5" />
                    {cfg('hero.cta_text', 'Llamar ahora +591 76738282')}
                  </a>
                  <a
                    href="#servicios"
                    className="inline-flex items-center justify-center gap-2 rounded-lg border-2 border-white/40 bg-white/5 px-6 py-3.5 font-semibold text-white backdrop-blur-sm transition-all duration-300 hover:scale-105 hover:border-white/70 hover:bg-white/15"
                  >
                    Ver servicios
                  </a>
                </div>
              </div>
            </div>
          </div>
        </div>

      </div>

      {/* <!-- Features --> */}
      <section className="relative z-30 -mt-px px-4 sm:px-6 lg:px-8">
        <div className="container mx-auto -translate-y-8 md:-translate-y-10">
          <div className="grid grid-cols-1 gap-4 rounded-2xl bg-white p-4 shadow-[0_20px_60px_-15px_rgba(1,49,71,0.35)] sm:grid-cols-2 sm:gap-5 sm:p-6 lg:grid-cols-4 dark:bg-gray-800">
            {features.map((f, i) => (
              <Reveal
                key={f.title}
                variant="up"
                delay={i * 100}
                className="group flex items-center gap-4 rounded-xl p-4 transition-all duration-300 hover:bg-[#013147]/[0.04] sm:flex-col sm:items-start lg:flex-row lg:items-center dark:hover:bg-white/5"
              >
                <div className="flex h-[64px] w-[64px] shrink-0 items-center justify-center rounded-full bg-[#013147] shadow-lg shadow-[#013147]/30 transition-transform duration-300 group-hover:scale-110 group-hover:rotate-6">
                  <img src={f.icon} className="w-[32px]" alt={f.alt} />
                </div>
                <h3 className="text-[18px] leading-snug font-bold text-[#013147] dark:text-white">
                  {f.title}
                </h3>
              </Reveal>
            ))}
          </div>
        </div>
      </section>

      {/* <!-- about us --> */}
      <section className="about-us flex justify-center" id="nosotros">
        <div className="container w-full">
          <div className="about-wrapper grid grid-cols-1 items-center gap-[10px] lg:grid-cols-2">
            {/* <!-- Columna Izquierda - Imagen Principal + Círculos de Insectos --> */}
            <div className={`about-image mt-8 ml-24 md:mt-12  lg:mt-20 lg:ml-1 ${styles.aboutImage}`}>

              <div className=
              {`main-circle overflow-hidden rounded-full border-[12px] shadow-2xl ${styles.aboutImageU}`}>
                <img
                  src={cfg('about.image_main', '/images/about-equipo-trabajo.webp')}
                  className="h-[100%] w-[100%] object-cover"
                  alt="Equipo profesional de fumigación Bolivian Pest"
                />
              </div>
              {/* <!-- Círculos flotantes de insectos --> */}
              <div className=
              {`floating-bug bug-1 overflow-hidden rounded-full border-[8px] shadow-2xl ${styles.aboutImageD}`}>
                <img
                  src={cfg('about.image_1', '/images/about-mosquito.webp')}
                  className="h-[100%] w-[100%] object-cover"
                  alt="Plaga de mosquito en el hogar"
                />
              </div>
              <div className=
              {`floating-bug bug-2 absolute overflow-hidden rounded-full border-[8px] shadow-2xl ${styles.aboutImageT}`}>
                <img
                  src={cfg('about.image_2', '/images/about-tecnico-fumigando.webp')}
                  className="h-[100%] w-[100%] object-cover"
                  alt="Escarabajo como plaga"
                />
              </div>
              <div className=
              {`floating-bug bug-3  overflow-hidden rounded-full border-[8px] shadow-2xl ${styles.aboutImageC}`}>
                <img
                  src={cfg('about.image_3', '/images/about/siete.webp')}
                  className="h-[100%] w-[100%] object-cover"
                  alt="Cucaracha como plaga doméstica"
                />
              </div>
            </div>

            {/* <!-- Columna Derecha - Texto y Estadísticas --> */}
            <div className="about-content mt-8 ml-2 md:mt-12 md:ml-12 lg:mt-20 lg:ml-20">
              <Reveal variant="right">
                <span className={`section-tag ${styles.sectionTag}`}>
                  {cfg('about.tag', 'Acerca de Nosotros')}
                </span>
                <h2 className={`section-title ${styles.sectionTitle}`}>
                  {cfg('about.title', 'Protegiendo hogares,')}
                  <span> {cfg('about.title_highlight', 'negocios y comunidades')}</span>
                </h2>

                <p className={`about-text ${styles.aboutText}`}>
                  {cfg(
                    'about.text',
                    'Nuestra misión es simple: brindar servicios confiables de control de plagas que garanticen un ambiente limpio, seguro y confortable para todos. Con años de experiencia y un enfoque centrado en el cliente, nos esforzamos al máximo para eliminar las plagas y prevenir su regreso.',
                  )}
                </p>
              </Reveal>

              <div className={`benefits-grid ${styles.aboutBenefit}`}>
                {benefits.map((b) => (
                  <div key={b} className={`benefit-item ${styles.aboutBenefitItem}`}>
                    <span className="check">
                      <Check size={32} />
                    </span>
                    {b}
                  </div>
                ))}
              </div>

              {/* <!-- Video Thumbnail --> */}
              <div className={`video-thumb ${styles.aboutVideoThumb}`}>
                <img src={cfg('about.video_thumb', '/images/about/diez.webp')} alt="Nuestro equipo" />
                <div className={`play-button ${styles.aboutPlayButton}`}>
                  <Play size={50} />
                </div>
              </div>

              {/* <!-- Estadísticas --> */}
              <div className={`stats-grid ${styles.aboutStats}`}>
                {stats.map((st) => (
                  <div className="stat" key={st.label}>
                    <h3>
                      <CountUp end={Number(st.end)} suffix={st.suffix} />
                    </h3>
                    <p>{st.label}</p>
                  </div>
                ))}
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* <!-- Services --> */}
      <section
        className="services ml-8 mr-8 mt-8 flex justify-center md:mt-12 lg:mt-20"
        id="servicios"
      >
        <div className="container w-full">
          {/* <!-- Tag y título --> */}
          <Reveal variant="up" className="section-header text-center">
            <span className={`section-tag ${styles.sectionTag}`}>
              {cfg('services.tag', 'Servicios')}
            </span>
            <h2 className={`section-title ${styles.sectionTitle}`}>
              {cfg('services.title', 'Soluciones expertas para cualquier')}
              <span className="text-green"> {cfg('services.title_highlight', 'problema de plagas')}</span>
            </h2>
          </Reveal>

          {/* <!-- Slider de Servicios --> */}
          <div className={`${styles.servicesSliderWrap} mt-2 md:mt-6 lg:mt-10`}>
          <Swiper
            pagination={{
              type: 'fraction',
            }}
            navigation={true}
            autoplay={{ delay: 9000, disableOnInteraction: false }}
            modules={[Autoplay, Pagination, Navigation]}
            className={`${styles.servicesSwiper} mySwiper`}
            spaceBetween={30}
            loop={true}
            breakpoints={{
              0: {
                slidesPerView: 1,
              },
              768: {
                slidesPerView: 2,
              },
              1024: {
                slidesPerView: 3,
              },
            }}
          >
            {services.map((s) => {
              const Icon = iconFor(s.icon);
              return (
                <SwiperSlide key={s.title}>
                  <div className={styles.serviceCard}>
                    <div className={styles.serviceImg}>
                      <img src={s.img} alt={s.alt} loading="lazy" />
                      <span className={styles.serviceCategory}>{s.category}</span>
                      <div className={styles.serviceIcon}>
                        <Icon size={26} strokeWidth={2.2} />
                      </div>
                    </div>
                    <div className={styles.serviceBody}>
                      <h3>{s.title}</h3>
                      <p>{s.desc}</p>
                      <a
                        href={whatsappLink}
                        target="_blank"
                        rel="noopener noreferrer"
                        className={styles.serviceReadMore}
                      >
                        Solicitar servicio
                        <span className={styles.serviceArrow}>
                          <ArrowRight size={15} />
                        </span>
                      </a>
                    </div>
                  </div>
                </SwiperSlide>
              );
            })}
          </Swiper>
          </div>

          {/* <!-- Texto final --> */}
          <div className={`services-cta ${styles.serviceCta}`}>
            <p>
              {cfg('services.cta_text', '¿Listo para un hogar libre de plagas?')}
              <a
                href="#contact"
                className={`cta-link ${styles.serviceCtaLink}`}
              >
                {cfg('services.cta_link_text', '¡Contáctenos hoy!')}
              </a>
            </p>
          </div>
        </div>
      </section>

      {/* <!-- our features --> */}
      <section
        className="our-features mx-auto mt-8 px-4 sm:px-6 md:mt-16 lg:mt-24 lg:px-8"
        id="nuestros-servicios"
      >
        <div className="container mx-auto">
          <div className="grid grid-cols-1 items-stretch gap-10 lg:grid-cols-2 lg:gap-16">
            {/* Columna Izquierda - Texto + Características */}
            <div className="features-content flex flex-col">
              <Reveal variant="left">
                <span className={`section-tag ${styles.sectionTag}`}>
                  {cfg('ourfeatures.tag', 'Nuestros servicios')}
                </span>
                <h2 className={`section-title ${styles.sectionTitle}`}>
                  {cfg('ourfeatures.title', 'Su socio de confianza en')}
                  <span className="text-green"> {cfg('ourfeatures.title_highlight', 'control de plagas')}</span>
                </h2>

                <p className="mt-4 max-w-lg text-base leading-relaxed text-gray-500 dark:text-gray-400">
                  {cfg(
                    'ourfeatures.text',
                    'Entendemos lo frustrantes y molestas que pueden ser las plagas, por eso nos comprometemos a brindar soluciones rápidas, confiables y efectivas. Contamos con un equipo de expertos certificados, métodos ecológicos y una atención al cliente inigualable.',
                  )}
                </p>
              </Reveal>

              {/* Lista de características */}
              <div className="mt-8 flex flex-col gap-2 lg:mt-10">
                {ourFeatures.map((f, i) => {
                  const Icon = iconFor(f.icon);
                  return (
                    <Reveal
                      key={f.title}
                      variant="up"
                      delay={i * 100}
                      className="group flex items-start gap-4 rounded-2xl border border-transparent p-4 transition-all duration-300 hover:border-[#013147]/10 hover:bg-[#013147]/[0.03] hover:shadow-sm dark:hover:bg-white/5"
                    >
                      <div
                        className={`flex h-12 w-12 shrink-0 items-center justify-center rounded-xl transition-transform duration-300 group-hover:scale-110 ${f.iconWrap}`}
                      >
                        <Icon className="h-6 w-6" strokeWidth={2.2} />
                      </div>
                      <div>
                        <h4 className="mb-1 text-lg font-bold text-[#013147] dark:text-white">
                          {f.title}
                        </h4>
                        <p className="text-sm leading-relaxed text-gray-500 dark:text-gray-400">
                          {f.desc}
                        </p>
                      </div>
                    </Reveal>
                  );
                })}
              </div>
            </div>

            {/* Columna Derecha - Imagen grande con CTA flotante */}
            <Reveal variant="right" className="h-full">
              <div className="relative h-full min-h-[360px] sm:min-h-[460px] lg:min-h-full">
                <div className="h-full overflow-hidden rounded-3xl shadow-2xl shadow-[#013147]/25">
                  <img
                    src={cfg('ourfeatures.image', '/images/features/seis.webp')}
                    alt="Técnico profesional realizando servicio de fumigación"
                    className="h-full w-full object-cover"
                    loading="lazy"
                  />
                </div>

                {/* Gradiente inferior para legibilidad */}
                <div className="pointer-events-none absolute inset-x-0 bottom-0 h-1/3 rounded-b-3xl bg-gradient-to-t from-[#013147]/75 to-transparent" />

                {/* Badge flotante de confianza */}
                <div className="absolute top-4 left-4 flex items-center gap-3 rounded-2xl bg-white/95 px-4 py-3 shadow-xl backdrop-blur-sm dark:bg-gray-800/95">
                  <div className="flex h-10 w-10 items-center justify-center rounded-full bg-[#013147] text-white">
                    <ShieldCheck className="h-5 w-5" />
                  </div>
                  <div className="leading-tight">
                    <p className="text-lg font-extrabold text-[#013147] dark:text-white">
                      {cfg('ourfeatures.badge_years', '29+ años')}
                    </p>
                    <p className="text-xs text-gray-500 dark:text-gray-400">
                      {cfg('ourfeatures.badge_text', 'protegiendo Bolivia')}
                    </p>
                  </div>
                </div>

                {/* CTA flotante */}
                <a
                  href={whatsappLink}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="absolute bottom-5 left-1/2 inline-flex -translate-x-1/2 items-center gap-2 rounded-full bg-green-600 px-6 py-3 font-semibold text-white shadow-xl shadow-green-900/40 transition-all duration-300 hover:scale-105 hover:bg-green-500 sm:left-auto sm:right-5 sm:translate-x-0"
                >
                  <Phone className="h-5 w-5" />
                  Contáctanos
                </a>
              </div>
            </Reveal>
          </div>
        </div>
      </section>

      {/* <!-- our portafolio  --> */}
      <section
        className="our-portfolio mt-8 flex justify-center md:mt-16 lg:mt-24"
        id="portafolio"
      >
        <div className="container w-full">
          {/* <!-- Tag y título --> */}
          <Reveal variant="up" className="section-header text-center">
            <span className={`section-tag ${styles.sectionTag}`}>
              {cfg('portfolio.tag', 'Portafolio')}
            </span>
            <h2 className={`section-title ${styles.sectionTitle}`}>
              {cfg('portfolio.title', 'Descubra nuestra trayectoria comprobada en')}
              <span className="text-green">
                {' '}
                {cfg('portfolio.title_highlight', 'soluciones para eliminar plagas')}
              </span>
            </h2>
            <p className="mx-auto mt-4 max-w-2xl text-base leading-relaxed text-gray-500 dark:text-gray-400">
              {cfg(
                'portfolio.desc',
                'Vea nuestro trabajo real en acción. Casos de control de plagas en hogares, negocios y exteriores, directo desde nuestro TikTok.',
              )}
            </p>
          </Reveal>

          {/* Grilla de videos */}
          <div className="mt-10 flex flex-wrap justify-center gap-6 md:mt-14 md:gap-8">
            {portfolioVideos.map((v, i) => (
              <Reveal key={v.id} variant="up" delay={i * 120}>
                <div className="group overflow-hidden rounded-2xl shadow-xl shadow-[#013147]/10 transition-all duration-300 hover:-translate-y-2 hover:shadow-2xl hover:shadow-[#013147]/25">
                  <div className="tiktok-video-wrapper">
                    <blockquote
                      className="tiktok-embed"
                      cite={`https://www.tiktok.com/@${tiktokUser}/video/${v.id}`}
                      data-video-id={v.id}
                      style={{ maxWidth: '325px', minWidth: '325px' }}
                    >
                      <section>
                        <a
                          href={`https://www.tiktok.com/@${tiktokUser}/video/${v.id}?refer=embed`}
                          aria-label={v.label}
                        ></a>
                      </section>
                    </blockquote>
                  </div>
                </div>
              </Reveal>
            ))}
          </div>

          {/* CTA: perfil de TikTok */}
          <Reveal variant="up" className="mt-10 flex justify-center md:mt-12">
            <a
              href={tiktokLink}
              target="_blank"
              rel="noopener noreferrer"
              className="inline-flex items-center gap-2 rounded-full bg-[#013147] px-7 py-3 font-semibold text-white shadow-lg shadow-[#013147]/20 transition-all duration-300 hover:scale-105 hover:bg-[#02547a]"
            >
              <Play className="h-5 w-5" />
              Ver más en @{tiktokUser}
              <ArrowRight className="h-4 w-4" />
            </a>
          </Reveal>
          </div>
      </section>

      {/* <!-- por que elegirnos --> */}
      <section
        className="why-choose mt-8 flex justify-center md:mt-16 lg:mt-24"
        id="why-choose"
      >
        <div className="container w-full">
          {/* <!-- Tag y título --> */}
          <Reveal variant="up" className="section-header text-center">
            <span className={`section-tag ${styles.sectionTag}`}>
              {cfg('why.tag', '¿Por qué elegirnos?')}
            </span>
            <h2 className={`section-title ${styles.sectionTitle}`}>
              {cfg('why.title', '¿Qué nos convierte en la mejor opción')}
              <span className="text-green"> {cfg('why.title_highlight', 'para usted?')}</span>
            </h2>
            <p className={`section-desc ${styles.sectionDescription}`}>
              {cfg(
                'why.desc',
                '29 años de experiencia en Bolivia. Técnicos certificados SENASAG. Productos ecológicos seguros para niños y mascotas. Atención 24/7.',
              )}
            </p>
          </Reveal>



          {/* <!-- CTA final --> */}
          <div className={`why-cta ${styles.whyCta}`}>
            <a
              href={cfg('why.cta_link', 'mailto:info@bolivianpest.com')}
              target="_blank"
              className="btn-free"
            >
              {cfg('why.cta_text', '¡Haga su cita hoy! Disponible de inmediato — Inspección gratuita sin compromiso')}
            </a>
          </div>
        </div>
      </section>

      {/* <!-- frequently questions --> */}
      <section
        className="faq-section mt-10 flex justify-center md:mt-16 lg:mt-24 xl:mt-28"
        id="faq"
      >
        <div className="container w-full">
          <div className={`faq-wrapper ${styles.faqWrapper}`}>
            {/* <!-- Imágenes decorativas izquierda (ocultas cuando el grid pasa a 1 columna) --> */}
            <div className={`faqImages hidden min-[851px]:block ${styles.faqImages}`}>
              <img
                src={cfg('faq.image_1', '/images/questions/doce.webp')}
                alt="Técnico fumigando en propiedad"
                className={`img-1 ${styles.faqImg1}`}
              />
              <img
                src={cfg('faq.image_2', '/images/questions-equipo-profesional.webp')}
                alt="Equipo certificado Bolivian Pest"
                className={`img-2 ${styles.faqImg2}`}
              />
              <img
                src={cfg('faq.image_3', '/images/questions/seis.webp')}
                alt="Fumigación en espacios exteriores"
                className={`img-3 ${styles.faqImg3}`}
              />
            </div>

            {/* <!-- Contenido FAQ derecha --> */}
            <div className="faq-content">
              <Reveal variant="right">
                <span className={`section-tag ${styles.sectionTag}`}>
                  {cfg('faq.tag', 'Preguntas frecuentes')}
                </span>
                <h2 className={`section-title ${styles.sectionTitle}`}>
                  {cfg('faq.title', 'Encuentre respuestas útiles a sus dudas sobre')}
                  <span className="text-green"> {cfg('faq.title_highlight', 'el control de plagas')}</span>
                </h2>
              </Reveal>
              <Reveal variant="up" className="mt-6">
                <Accordion
                  type="single"
                  collapsible
                  className="flex w-full flex-col gap-3"
                  defaultValue="item-0"
                >
                  {faqs.map((f, idx) => (
                    <AccordionItem
                      key={idx}
                      value={`item-${idx}`}
                      className="overflow-hidden rounded-2xl border border-gray-200 bg-white px-4 shadow-sm transition-all last:border-b data-[state=open]:border-cyan-400 data-[state=open]:shadow-md sm:px-5 dark:border-gray-700 dark:bg-gray-800/60 dark:data-[state=open]:border-cyan-500"
                    >
                      <AccordionTrigger className="gap-3 py-4 text-left text-base font-semibold text-[#013147] hover:no-underline data-[state=open]:text-cyan-600 md:py-5 md:text-lg dark:text-white dark:data-[state=open]:text-cyan-400">
                        <span className="flex items-center gap-3">
                          <span className="flex h-7 w-7 shrink-0 items-center justify-center rounded-full bg-cyan-100 text-sm font-bold text-cyan-700 dark:bg-cyan-950 dark:text-cyan-300">
                            {idx + 1}
                          </span>
                          {f.question}
                        </span>
                      </AccordionTrigger>
                      <AccordionContent className="space-y-2.5 pl-10 text-[15px] leading-relaxed text-gray-600 [&_li]:marker:text-cyan-500 [&_strong]:font-semibold [&_strong]:text-[#013147] [&_ul]:list-disc [&_ul]:space-y-1.5 [&_ul]:pl-5 dark:text-gray-300 dark:[&_strong]:text-white">
                        <div dangerouslySetInnerHTML={{ __html: f.answer }} />
                      </AccordionContent>
                    </AccordionItem>
                  ))}
                </Accordion>
              </Reveal>
            </div>
          </div>
        </div>
      </section>
      {/* <!-- Contacto --> */}
      <section
        className="relative mt-10 overflow-hidden bg-gradient-to-br from-[#013147] to-[#01243a] py-16 md:mt-16 md:py-20 lg:mt-24 lg:py-24"
        id="contacto"
      >
        {/* Brillo decorativo de fondo */}
        <div className="pointer-events-none absolute -top-24 -right-24 h-72 w-72 rounded-full bg-cyan-500/10 blur-3xl" />
        <div className="pointer-events-none absolute -bottom-24 -left-24 h-72 w-72 rounded-full bg-cyan-400/10 blur-3xl" />

        <div className="relative container mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
          {/* Encabezado */}
          <Reveal variant="up" className="mb-10 text-center md:mb-14">
            <span className="inline-flex items-center gap-2 rounded-full border border-cyan-300/30 bg-cyan-400/10 px-4 py-1.5 text-sm font-semibold tracking-wide text-cyan-200 uppercase backdrop-blur-sm">
              {cfg('contact.tag', 'Contacto')}
            </span>
            <h2 className="mt-4 text-3xl font-extrabold tracking-tight text-balance text-white sm:text-4xl">
              {cfg('contact.title', '¿Listo para un espacio libre de plagas?')}
            </h2>
            <p className="mx-auto mt-3 max-w-2xl text-base leading-relaxed text-white/70">
              {cfg(
                'contact.subtitle',
                'Escríbanos y le respondemos a la brevedad. Inspección sin compromiso — atención en toda Bolivia.',
              )}
            </p>
          </Reveal>

          <div className="grid grid-cols-1 items-stretch gap-8 lg:grid-cols-2 lg:gap-12">
            {/* Izquierda: mapa + tarjetas de contacto */}
            <Reveal variant="left" className="order-2 flex flex-col gap-5 lg:order-1">
              <div className="relative min-h-[280px] grow overflow-hidden rounded-2xl shadow-2xl ring-1 ring-white/15">
                <iframe
                  title="Ubicación de Bolivian Pest en La Paz"
                  src={cfg(
                    'contact.map_embed',
                    'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d239.0954346072869!2d-68.12636138046955!3d-16.499473655781642!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x915f210059ecf6c7%3A0xca158fcbb8866f59!2sBolivianPest!5e0!3m2!1ses!2sbo!4v1772571664453!5m2!1ses!2sbo',
                  )}
                  loading="lazy"
                  referrerPolicy="no-referrer-when-downgrade"
                  className="absolute inset-0 h-full w-full border-0"
                />
              </div>

              {/* Tarjetas de contacto */}
              <div className="grid gap-3 sm:grid-cols-2">
                {contactInfo.map(({ Icon, label, value, href }) => {
                  const inner = (
                    <>
                      <span className="flex h-11 w-11 shrink-0 items-center justify-center rounded-xl bg-cyan-500/20 text-cyan-300 ring-1 ring-cyan-300/20">
                        <Icon className="h-5 w-5" strokeWidth={2.2} />
                      </span>
                      <span className="min-w-0">
                        <span className="block text-xs text-white/50">
                          {label}
                        </span>
                        <span className="block truncate font-semibold text-white">
                          {value}
                        </span>
                      </span>
                    </>
                  );
                  const cls =
                    'flex items-center gap-3 rounded-xl border border-white/10 bg-white/5 p-3 backdrop-blur-sm transition-colors';
                  return href ? (
                    <a
                      key={label}
                      href={href}
                      target="_blank"
                      rel="noopener noreferrer"
                      className={`${cls} hover:border-cyan-300/30 hover:bg-white/10`}
                    >
                      {inner}
                    </a>
                  ) : (
                    <div key={label} className={cls}>
                      {inner}
                    </div>
                  );
                })}
              </div>
            </Reveal>

            {/* Derecha: formulario */}
            <Reveal variant="right" className="order-1 lg:order-2">
              <div className="rounded-2xl bg-white p-6 shadow-2xl md:p-8 lg:p-10 dark:bg-gray-800">
                <h3 className="text-2xl font-bold text-[#013147] dark:text-white">
                  {cfg('contact.form_title', 'Solicite su cotización')}
                </h3>
                <p className="mt-1 mb-6 text-sm text-gray-500 dark:text-gray-400">
                  {cfg('contact.form_subtitle', 'Complete el formulario y le escribimos por WhatsApp.')}
                </p>

                <form
                  className="space-y-5"
                  onSubmit={(e) => {
                    e.preventDefault();
                    const fd = new FormData(e.currentTarget);
                    const msg =
                      `Hola Bolivian Pest 👋\n` +
                      `Nombre: ${fd.get('nombre')}\n` +
                      `Ciudad: ${fd.get('ciudad') || '—'}\n` +
                      `Email: ${fd.get('email')}\n` +
                      `Teléfono: ${fd.get('telefono') || '—'}\n\n` +
                      `${fd.get('mensaje')}`;
                    window.open(
                      `https://wa.me/${whatsappNumber}?text=${encodeURIComponent(msg)}`,
                      '_blank',
                      'noopener,noreferrer',
                    );
                  }}
                >
                  <div className="grid grid-cols-1 gap-5 sm:grid-cols-2">
                    <div>
                      <label
                        htmlFor="c-nombre"
                        className="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-300"
                      >
                        Nombre completo{' '}
                        <span className="text-red-500">*</span>
                      </label>
                      <input
                        id="c-nombre"
                        name="nombre"
                        type="text"
                        autoComplete="name"
                        required
                        placeholder="Tu nombre"
                        className="w-full rounded-lg border border-gray-300 bg-white px-4 py-3 text-gray-900 outline-none transition focus:border-cyan-500 focus:ring-2 focus:ring-cyan-500/40 dark:border-gray-600 dark:bg-gray-700 dark:text-white"
                      />
                    </div>

                    <div>
                      <label
                        htmlFor="c-ciudad"
                        className="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-300"
                      >
                        Ciudad
                      </label>
                      <input
                        id="c-ciudad"
                        name="ciudad"
                        type="text"
                        autoComplete="address-level2"
                        placeholder="La Paz, Santa Cruz, etc."
                        className="w-full rounded-lg border border-gray-300 bg-white px-4 py-3 text-gray-900 outline-none transition focus:border-cyan-500 focus:ring-2 focus:ring-cyan-500/40 dark:border-gray-600 dark:bg-gray-700 dark:text-white"
                      />
                    </div>
                  </div>

                  <div className="grid grid-cols-1 gap-5 sm:grid-cols-2">
                    <div>
                      <label
                        htmlFor="c-email"
                        className="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-300"
                      >
                        Email <span className="text-red-500">*</span>
                      </label>
                      <input
                        id="c-email"
                        name="email"
                        type="email"
                        autoComplete="email"
                        required
                        placeholder="tu@email.com"
                        className="w-full rounded-lg border border-gray-300 bg-white px-4 py-3 text-gray-900 outline-none transition focus:border-cyan-500 focus:ring-2 focus:ring-cyan-500/40 dark:border-gray-600 dark:bg-gray-700 dark:text-white"
                      />
                    </div>

                    <div>
                      <label
                        htmlFor="c-telefono"
                        className="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-300"
                      >
                        Teléfono
                      </label>
                      <input
                        id="c-telefono"
                        name="telefono"
                        type="tel"
                        autoComplete="tel"
                        placeholder="+591 7XXX XXXX"
                        className="w-full rounded-lg border border-gray-300 bg-white px-4 py-3 text-gray-900 outline-none transition focus:border-cyan-500 focus:ring-2 focus:ring-cyan-500/40 dark:border-gray-600 dark:bg-gray-700 dark:text-white"
                      />
                    </div>
                  </div>

                  <div>
                    <label
                      htmlFor="c-mensaje"
                      className="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-300"
                    >
                      Mensaje <span className="text-red-500">*</span>
                    </label>
                    <textarea
                      id="c-mensaje"
                      name="mensaje"
                      rows={5}
                      required
                      placeholder="Cuéntenos sobre su problema de plagas, el tipo de inmueble o cualquier consulta..."
                      className="w-full resize-none rounded-lg border border-gray-300 bg-white px-4 py-3 text-gray-900 outline-none transition focus:border-cyan-500 focus:ring-2 focus:ring-cyan-500/40 dark:border-gray-600 dark:bg-gray-700 dark:text-white"
                    />
                  </div>

                  <button
                    type="submit"
                    className="inline-flex w-full items-center justify-center gap-2 rounded-lg bg-green-600 px-8 py-3.5 font-semibold text-white shadow-lg shadow-green-900/30 transition-all duration-300 hover:scale-[1.02] hover:bg-green-500 focus:ring-2 focus:ring-green-500 focus:ring-offset-2 focus:outline-none sm:w-auto"
                  >
                    <Phone className="h-5 w-5" />
                    Enviar por WhatsApp
                  </button>
                </form>
              </div>
            </Reveal>
          </div>
        </div>
      </section>

      {/* <!-- Footer --> */}
      <footer className="relative bg-[#011a2b] text-gray-400">
        {/* Borde superior sutil */}
        <div className="absolute inset-x-0 top-0 h-px bg-gradient-to-r from-transparent via-white/15 to-transparent" />

        <div className="container mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
          {/* Parte superior */}
          <div className="grid grid-cols-1 gap-10 py-14 sm:grid-cols-2 lg:grid-cols-[1.7fr_1fr_1fr_1.3fr] lg:gap-12 md:py-16">
            {/* Marca */}
            <div className="sm:col-span-2 lg:col-span-1">
              <img
                src={cfg('brand.logo_footer', '/images/LogoHFCWhite.png')}
                alt="Bolivian Pest"
                className="h-14 w-auto object-contain"
              />
              <p className="mt-4 max-w-sm text-sm leading-relaxed text-gray-400">
                {cfg(
                  'brand.footer_description',
                  'Creamos entornos seguros y libres de plagas para hogares y negocios en toda Bolivia, con soluciones eficaces, ecológicas y certificadas.',
                )}
              </p>
              <div className="mt-5 flex gap-3">
                <a
                  href={instagramLink}
                  target="_blank"
                  rel="noopener noreferrer"
                  aria-label="Instagram"
                  className="flex h-10 w-10 items-center justify-center rounded-full bg-white/5 text-gray-300 transition-all duration-300 hover:-translate-y-1 hover:bg-white/10 hover:text-pink-400"
                >
                  <Instagram className="h-5 w-5" />
                </a>
                <a
                  href={facebookLink}
                  target="_blank"
                  rel="noopener noreferrer"
                  aria-label="Facebook"
                  className="flex h-10 w-10 items-center justify-center rounded-full bg-white/5 text-gray-300 transition-all duration-300 hover:-translate-y-1 hover:bg-white/10 hover:text-blue-400"
                >
                  <Facebook className="h-5 w-5" />
                </a>
                <a
                  href={whatsappLink}
                  target="_blank"
                  rel="noopener noreferrer"
                  aria-label="WhatsApp"
                  className="flex h-10 w-10 items-center justify-center rounded-full bg-white/5 text-gray-300 transition-all duration-300 hover:-translate-y-1 hover:bg-white/10 hover:text-green-400"
                >
                  <Phone className="h-5 w-5" />
                </a>
              </div>
            </div>

            {/* Navegación */}
            <div>
              <h3 className="text-sm font-semibold tracking-wider text-white uppercase">
                Navegación
              </h3>
              <ul className="mt-5 space-y-3 text-sm">
                {[
                  { label: 'Inicio', href: '#' },
                  { label: 'Nosotros', href: '#nosotros' },
                  { label: 'Servicios', href: '#servicios' },
                  { label: 'Portafolio', href: '#portafolio' },
                  { label: 'Preguntas frecuentes', href: '#faq' },
                  { label: 'Contacto', href: '#contacto' },
                ].map((l) => (
                  <li key={l.label}>
                    <a
                      href={l.href}
                      className="inline-block text-gray-400 transition-all duration-200 hover:translate-x-1 hover:text-cyan-300"
                    >
                      {l.label}
                    </a>
                  </li>
                ))}
              </ul>
            </div>

            {/* Servicios */}
            <div>
              <h3 className="text-sm font-semibold tracking-wider text-white uppercase">
                Servicios
              </h3>
              <ul className="mt-5 space-y-3 text-sm">
                {[
                  { label: 'Control comercial', href: '#servicios' },
                  { label: 'Termitas y roedores', href: '#servicios' },
                  { label: 'Control residencial', href: '#servicios' },
                  { label: 'Control en exteriores', href: '#servicios' },
                  {
                    label: 'Emergencia 24/7',
                    href: whatsappLink,
                  },
                ].map((l) => (
                  <li key={l.label}>
                    <a
                      href={l.href}
                      className="inline-block text-gray-400 transition-all duration-200 hover:translate-x-1 hover:text-cyan-300"
                    >
                      {l.label}
                    </a>
                  </li>
                ))}
              </ul>
            </div>

            {/* Contacto */}
            <div>
              <h3 className="text-sm font-semibold tracking-wider text-white uppercase">
                Contacto
              </h3>
              <ul className="mt-5 space-y-3.5 text-sm">
                {contactInfo.map(({ Icon, value, href }) => (
                  <li key={value} className="flex items-start gap-3">
                    <Icon className="mt-0.5 h-4 w-4 shrink-0 text-cyan-400" />
                    {href ? (
                      <a
                        href={href}
                        target="_blank"
                        rel="noopener noreferrer"
                        className="text-gray-400 transition-colors hover:text-cyan-300"
                      >
                        {value}
                      </a>
                    ) : (
                      <span className="text-gray-400">{value}</span>
                    )}
                  </li>
                ))}
                <li className="flex items-start gap-3 pt-1">
                  <ShieldCheck className="mt-0.5 h-4 w-4 shrink-0 text-cyan-400" />
                  <a
                    href="/login"
                    className="text-gray-400 transition-colors hover:text-cyan-300"
                  >
                    Acceso al sistema
                  </a>
                </li>
              </ul>
            </div>
          </div>

          {/* Divisor */}
          <div className="h-px bg-white/10" />

          {/* Parte inferior: powered by (sutil) */}
          <div className="py-6 text-center">
            <p className="text-xs text-gray-600">
              Powered by{' '}
              <a
                href="https://bitdesarrollo.net"
                target="_blank"
                rel="noopener noreferrer"
                className="text-gray-500 transition-colors hover:text-cyan-400"
              >
                Bitdesarrollo
              </a>
            </p>
          </div>
        </div>
      </footer>

      {/* Botón flotante de WhatsApp */}
      <WhatsAppFloat phone={whatsappNumber} />
    </>
  );
}
