import Navbar from '@/components/landing/Navbar';
import {
  Accordion,
  AccordionContent,
  AccordionItem,
  AccordionTrigger,
} from '@/components/ui/accordion';
import { Head, usePage } from '@inertiajs/react';
import { Autoplay, EffectFade, Navigation, Pagination } from 'swiper/modules';
import { Swiper, SwiperSlide } from 'swiper/react';
import { Textarea } from "@/components/ui/textarea"
import styles from './landing.module.css';

import SplashScreen from '@/components/SplashScreen';
import {
  BadgeCheck,
  Building2,
  Check,
  CheckCircle2,
  Clock,
  Facebook,
  Factory,
  HouseWifi,
  Instagram,
  Mail,
  Phone,
  Play,
  Rat,
  Settings,
  ShieldCheck,
  Siren,
  Snail,
} from 'lucide-react';
import WhyHighlightCard from '@/components/WhyHighlightCard';
import { Input } from "@/components/ui/input";
import { Button } from '@/components/ui/button';
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from '@/components/ui/card';
import { Label } from '@/components/ui/label';
import 'swiper/css';
import 'swiper/css/autoplay';
import 'swiper/css/effect-fade';
import 'swiper/css/navigation';
import 'swiper/css/pagination';

export default function Landing() {
  const { component } = usePage();

  return (
    <>
      <SplashScreen screen="/images/LogoBlack.png" />

      {/* pestaña de navegador */}
      <Head
        title="Control de Plagas en Bolivia | Bolivian Pest - Fumigación Profesional"
        meta={[
          {
            name: 'description',
            content:
              'Bolivian Pest: Servicios profesionales de control de plagas en Bolivia. Fumigación, exterminación de termitas, roedores y más. Atención 24/7. Contacto: +591 76738282',
          },
          {
            name: 'keywords',
            content:
              'control de plagas Bolivia, fumigación La Paz, exterminación de termitas, exterminador roedores, servicios de fumigación Bolivia, empresa control plagas',
          },
          {
            name: 'author',
            content: 'Bolivian Pest - Higiene Ambiental',
          },
          {
            name: 'robots',
            content: 'index, follow',
          },
          { property: 'og:title', content: 'Control de Plagas en Bolivia | Bolivian Pest' },
          {
            property: 'og:description',
            content:
              'Servicios profesionales de control de plagas en Bolivia. Fumigación, exterminación de termitas, roedores y más. Atención 24/7.',
          },
          { property: 'og:image', content: '/images/og-image.svg' },
          { property: 'og:url', content: 'https://bolivianpest.com' },
          { property: 'og:type', content: 'website' },
          { property: 'og:locale', content: 'es_BO' },
          { property: 'og:site_name', content: 'Bolivian Pest' },
          { name: 'twitter:card', content: 'summary_large_image' },
          { name: 'twitter:title', content: 'Control de Plagas en Bolivia | Bolivian Pest' },
          {
            name: 'twitter:description',
            content:
              'Servicios profesionales de control de plagas en Bolivia. Fumigación, exterminación de termitas, roedores y más. Atención 24/7.',
          },
          { name: 'twitter:image', content: '/images/og-image.svg' },
          { name: 'twitter:site', content: '@bolivian_pest' },
          { name: 'theme-color', content: '#013147' },
        ]}
      >
        <link rel="canonical" href={`${typeof window !== 'undefined' ? window.location.origin : 'https://bolivianpest.com'}`} />
        <link rel="preconnect" href="https://fonts.bunny.net" />
        <link
          href="https://fonts.bunny.net/css?family=inter:200,300,300i,400,400i,500,500i,600,600i,700,800,900"
          rel="stylesheet"
        />
        <script async src="https://www.tiktok.com/embed.js"></script>
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
              url: `${typeof window !== 'undefined' ? window.location.origin : 'https://bolivianpest.com'}`,
              telephone: '+591 76738282',
              email: 'info@bolivianpest.com',
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
              image: `${typeof window !== 'undefined' ? window.location.origin : 'https://bolivianpest.com'}/images/og-image.svg`,
            },
            {
              '@context': 'https://schema.org',
              '@type': 'Organization',
              name: 'Bolivian Pest',
              url: `${typeof window !== 'undefined' ? window.location.origin : 'https://bolivianpest.com'}`,
              logo: `${typeof window !== 'undefined' ? window.location.origin : 'https://bolivianpest.com'}/images/LogoFC.svg`,
              sameAs: [
                'https://www.facebook.com/p/Bolivian-Pest-Higiene-Ambiental-61572172198692/',
                'https://instagram.com/bolivian_pest',
              ],
              contactPoint: {
                '@type': 'ContactPoint',
                telephone: '+591 76738282',
                contactType: 'customer service',
                availableLanguage: 'Spanish',
              },
            },
            {
              '@context': 'https://schema.org',
              '@type': 'FAQPage',
              mainEntity: [
                {
                  '@type': 'Question',
                  name: '¿Qué tipos de plagas tratan en Bolivian Pest?',
                  acceptedAnswer: {
                    '@type': 'Answer',
                    text: 'Controlamos una amplia variedad de plagas incluyendo roedores, hormigas, cucarachas, termitas, chinches, mosquitos, arañas y fauna silvestre. Aplicamos métodos específicos según la especie para garantizar resultados efectivos.',
                  },
                },
                {
                  '@type': 'Question',
                  name: '¿Son seguros sus métodos de control de plagas para mis mascotas?',
                  acceptedAnswer: {
                    '@type': 'Answer',
                    text: 'Sí. Todos nuestros productos y procedimientos están certificados y son seguros para mascotas y personas. Utilizamos productos de baja toxicidad aprobados por SENASAG y aplicados bajo estándares profesionales.',
                  },
                },
                {
                  '@type': 'Question',
                  name: '¿Con qué frecuencia debo programar los servicios de control de plagas?',
                  acceptedAnswer: {
                    '@type': 'Answer',
                    text: 'La frecuencia depende del tipo de plaga y del entorno. Para hogares recomendamos cada 3 a 4 meses. Para comercios y restaurantes recomendamos servicios mensuales o quincenales según normas de salubridad.',
                  },
                },
                {
                  '@type': 'Question',
                  name: '¿Ofrecen servicios de control de plagas de emergencia?',
                  acceptedAnswer: {
                    '@type': 'Answer',
                    text: 'Sí, contamos con servicios de emergencia para infestaciones severas como nidos de avispas, presencia elevada de roedores, brotes de cucarachas en cocinas o invasiones de chinches. Atendemos en el menor tiempo posible.',
                  },
                },
                {
                  '@type': 'Question',
                  name: '¿Cómo sé si tengo una plaga?',
                  acceptedAnswer: {
                    '@type': 'Answer',
                    text: 'Algunas señales comunes incluyen: excrementos pequeños o manchas oscuras, ruidos dentro de paredes o techos, olores fuertes desagradables, y huecos o montículos en madera o suelo. Si notas estos signos, solicita una inspección profesional.',
                  },
                },
              ],
            },
          ]),
        }}
      />

      <Navbar logo="/images/LogoHFCWhite.png" />

      <div className="relative">
        <Swiper
          spaceBetween={30}
          effect={'fade'}
          loop={true}
          autoplay={{ delay: 9000, disableOnInteraction: false }}
          modules={[Autoplay, EffectFade, Navigation, Pagination]}
          className="mySwiper h-full w-full"
        >
          {/* Overlay azul semitransparente */}
          <div className="pointer-events-none absolute inset-0 z-10 bg-gray-900/80" />
          <SwiperSlide>
            <img
              src="/images/slider/sli1.webp"
              className="h-full w-full object-cover"
              alt="Servicio de control de plagas en hogar boliviano - Fumigación profesional"
              loading="lazy"
            />
          </SwiperSlide>
          <SwiperSlide>
            <img
              src="/images/slider/sli2.webp"
              className="h-full w-full object-cover"
              alt="Equipo profesional de Bolivian Pest realizando fumigación comercial"
              loading="lazy"
            />
          </SwiperSlide>
          <SwiperSlide>
            <img
              src="/images/slider/sli3.webp"
              className="h-full w-full object-cover"
              alt="Control de termitas y roedores en oficinas y negocios"
              loading="lazy"
            />
          </SwiperSlide>
          <SwiperSlide>
            <img
              src="/images/slider/sli4.webp"
              className="h-full w-full object-cover"
              alt="Servicio de fumigación 24/7 para emergencias de plagas"
              loading="lazy"
            />
          </SwiperSlide>
        </Swiper>

        {/* Overlay con texto y personaje */}
        <div className="absolute inset-0 z-10 flex items-center justify-center">
          <div className="w-full max-w-[1000px] px-6 md:px-10">
            <div className="grid grid-cols-1 items-center gap-8 lg:grid-cols-2 lg:gap-12">
              {/* Personaje - se oculta en ≤1024px (lg y menores) */}
              <div className="hidden justify-self-end lg:block">
                <img
                  src="/images/cta/personaje.webp"
                  alt="Profesional de Bolivian Pest listo para ayudarlo"
                  className="h-auto max-w-full"
                />
              </div>

              {/* Texto - centrado en móvil, alineado a la izquierda en desktop */}
              <div className="text-center lg:text-left">
                <h1 className="/* ≤ 425px */ /* 426px - 640px */ /* 768px+ */ /* 1024px+ */ mb-3 text-2xl leading-tight font-bold text-white drop-shadow-2xl sm:mb-4 sm:text-3xl md:text-4xl lg:text-5xl xl:text-[2.8rem]">
                  Elimine cualquier plaga en 24 horas — Técnicos certificados disponibles 24/7 en toda Bolivia
                </h1>

                <p className="/* ≤ 425px → más pequeño */ /* 426px - 640px */ /* 768px+ */ /* 1024px+ */ text-sm leading-relaxed text-white drop-shadow-lg sm:text-base md:text-lg lg:text-xl">
                  Desde termitas hasta roedores, exterminación profesional garantizada.
                  Sin compromiso — llámenos hoy y agenda su inspección.
                </p>

                {/* CTAs del Hero */}
                <div className="mt-6 flex flex-col gap-4 sm:flex-row sm:justify-center lg:justify-start">
                  <a
                    href="https://wa.me/59176738282"
                    target="_blank"
                    rel="noopener noreferrer"
                    className="inline-flex items-center justify-center gap-2 rounded-lg bg-green-600 px-6 py-3 font-semibold text-white transition hover:bg-green-700"
                  >
                    <Phone className="h-5 w-5" />
                    Llamar ahora +591 76738282
                  </a>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      {/* <!-- Features --> */}
      <section className="">
        <div className="features grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4">
          <div className="feature-box flex border-2 border-s-0 p-[20px] text-left">
            <div className="icon-circle flex h-[70px] w-[70px] items-center justify-center rounded-full bg-[#013147]">
              <img
                src="/images/icons/coberturab.svg"
                className="w-[35px]"
                alt="Servicio de control de plagas con cobertura nacional en Bolivia"
              />
            </div>
            <div className="ms-4">
              <h3 className="text-[20px] font-bold">Cobertura Integral</h3>

            </div>
          </div>

          <div className="feature-box flex border-2 border-s-0 p-[20px] text-left">
            <div className="icon-circle flex h-[70px] w-[70px] items-center justify-center rounded-full bg-[#013147]">
              <img
                src="/images/icons/tiempob.svg"
                className="w-[35px]"
                alt="Respuesta rápida de emergencia en control de plagas"
              />
            </div>
            <div className="ms-4">
              <h3 className="text-[20px] font-bold">
                Tiempos de respuesta <br />
                rapidos
              </h3>

            </div>
          </div>

          <div className="feature-box flex border-2 border-s-0 p-[20px] text-left">
            <div className="icon-circle flex h-[70px] w-[70px] items-center justify-center rounded-full bg-[#013147]">
              <img
                src="/images/icons/serviciob.svg"
                className="w-[35px]"
                alt="Servicios de fumigación para negocios y empresas"
              />
            </div>
            <div className="ms-4">
              <h3
                className="text-[20px] font-bold"
                // style={{ background: 'var(--color-text-title)' }}
              >
                Servicios <br /> comerciales
              </h3>

            </div>
          </div>

          <div className="feature-box flex border-2 border-s-0 border-e-0 p-[20px] text-left">
            <div className="icon-circle flex h-[70px] w-[70px] items-center justify-center rounded-full bg-[#013147]">
              <img
                src="/images/icons/emergenciab.svg"
                className="w-[35px]"
                alt="Servicio de emergencia de control de plagas disponible 24 horas"
              />
            </div>
            <div className="ms-4">
              <h3 className="text-[20px] font-bold">
                Servicio de <br /> Emergencia 24/7
              </h3>

            </div>
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
                  src="/images/about-equipo-trabajo.webp"
                  className="h-[100%] w-[100%] object-cover"
                  alt="Equipo profesional de fumigación Bolivian Pest"
                />
              </div>
              {/* <!-- Círculos flotantes de insectos --> */}
              <div className=
              {`floating-bug bug-1 overflow-hidden rounded-full border-[8px] shadow-2xl ${styles.aboutImageD}`}>
                <img
                  src="/images/about-mosquito.webp"
                  className="h-[100%] w-[100%] object-cover"
                  alt="Plaga de mosquito en el hogar"
                />
              </div>
              <div className=
              {`floating-bug bug-2 absolute overflow-hidden rounded-full border-[8px] shadow-2xl ${styles.aboutImageT}`}>
                <img
                  src="/images/about-tecnico-fumigando.webp"
                  className="h-[100%] w-[100%] object-cover"
                  alt="Escarabajo como plaga"
                />
              </div>
              <div className=
              {`floating-bug bug-3  overflow-hidden rounded-full border-[8px] shadow-2xl ${styles.aboutImageC}`}>
                <img
                  src="/images/about/siete.webp"
                  className="h-[100%] w-[100%] object-cover"
                  alt="Cucaracha como plaga doméstica"
                />
              </div>
            </div>

            {/* <!-- Columna Derecha - Texto y Estadísticas --> */}
            <div className="about-content mt-8 ml-2 md:mt-12 md:ml-12 lg:mt-20 lg:ml-20">
              <span className={`section-tag ${styles.sectionTag}`}>
                Acerca de Nosotros
              </span>
              <h2 className={`section-title ${styles.sectionTitle}`}>
                Protegiendo hogares,
                <span> negocios y comunidades</span>
              </h2>

              <p className={`about-text ${styles.aboutText}`}>
                Nuestra misión es simple: brindar servicios confiables de
                control de plagas que garanticen un ambiente limpio, seguro y
                confortable para todos. Con años de experiencia y un enfoque
                centrado en el cliente, nos esforzamos al máximo para eliminar
                las plagas y prevenir su regreso.
              </p>

              <div className={`benefits-grid ${styles.aboutBenefit}`}>
                <div className={`benefit-item ${styles.aboutBenefitItem}`}>
                  <span className="check">
                    <Check size={32} />
                  </span>
                  Experiencia en la que puede confiar
                </div>
                <div className={`benefit-item ${styles.aboutBenefitItem}`}>
                  <span className="check">
                    <Check size={32} />
                  </span>
                  Disponibilidad 24/7
                </div>
                <div className={`benefit-item ${styles.aboutBenefitItem}`}>
                  <span className="check">
                    <Check size={32} />
                  </span>{' '}
                  Profesionales certificados
                </div>
                <div className={`benefit-item ${styles.aboutBenefitItem}`}>
                  <span className="check">
                    <Check size={32} />
                  </span>{' '}
                  Soluciones asequibles
                </div>
                <div className={`benefit-item ${styles.aboutBenefitItem}`}>
                  <span className="check">
                    <Check size={32} />
                  </span>{' '}
                  Enfoque ecológico
                </div>
                <div className={`benefit-item ${styles.aboutBenefitItem}`}>
                  <span className="check">
                    <Check size={32} />
                  </span>{' '}
                  Técnicas avanzadas
                </div>
                <div className={`benefit-item ${styles.aboutBenefitItem}`}>
                  <span className="check">
                    <Check size={32} />
                  </span>{' '}
                  Servicio centrado en el cliente
                </div>
                <div className={`benefit-item ${styles.aboutBenefitItem}`}>
                  <span className="check">
                    <Check size={32} />
                  </span>{' '}
                  Compromiso con la excelencia
                </div>
              </div>

              {/* <!-- Video Thumbnail --> */}
              <div className={`video-thumb ${styles.aboutVideoThumb}`}>
                <img src="/images/about/diez.webp" alt="Nuestro equipo" />
                <div className={`play-button ${styles.aboutPlayButton}`}>
                  <Play size={50} />
                </div>
              </div>

              {/* <!-- Estadísticas --> */}
              <div className={`stats-grid ${styles.aboutStats}`}>
                <div className="stat">
                  <h3>29+</h3>
                  <p>Años de experiencia</p>
                </div>
                <div className="stat">
                  <h3>2K</h3>
                  <p>Proyectos finalizados</p>
                </div>
                <div className="stat">
                  <h3>50</h3>
                  <p>Equipo dedicado</p>
                </div>
                <div className="stat">
                  <h3>98%</h3>
                  <p>Clientes satisfechos</p>
                </div>
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
          <div className="section-header text-center">
            <span className={`section-tag ${styles.sectionTag}`}>
              Servicios
            </span>
            <h2 className={`section-title ${styles.sectionTitle}`}>
              Soluciones expertas para cualquier
              <span className="text-green"> problema de plagas</span>
            </h2>
          </div>

          {/* <!-- Slider de Servicios --> */}
          <Swiper
            pagination={{
              type: 'fraction',
            }}
            navigation={true}
            autoplay={{ delay: 9000, disableOnInteraction: false }}
            modules={[Autoplay, Pagination, Navigation]}
            className="mySwiper mt-2 md:mt-6 lg:mt-10"
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
            <SwiperSlide>
              <div className={styles.serviceCard}>
                <div className={styles.serviceImg}>
                  <img src="/images/servicio-fumigacion-comercial.webp" alt="Fumigación comercial para negocios" />
                </div>
                <div className={styles.serviceIcon}>
                  {/* <i className="fas fa-building"></i> */}
                  <Factory size={30} />
                </div>
                <h3>Soluciones comerciales para el control de plagas</h3>
                <p>
                  Protección completa para restaurantes, oficinas y negocios.
                  Cumplimos normas de salubridad — garantía de resultados.
                </p>
                <a href="https://wa.me/59176738282" className={styles.serviceReadMore}>
                  Solicitar servicio →
                </a>
              </div>
            </SwiperSlide>
            <SwiperSlide>
              <div className={styles.serviceCard}>
                <div className={styles.serviceImg}>
                  <img src="/images/servicio-exterminacion-termitas.webp" alt="Exterminación profesional de termitas y roedores" />
                </div>
                <div className={styles.serviceIcon}>
                  <Rat size={30} />
                </div>
                <h3>Control de termitas y roedores</h3>
                <p>
                  Eliminación total y prevención de daños estructurales.
                  Si vuelven, volvemos gratis — garantía escrita.
                </p>
                <a href="https://wa.me/59176738282" className={styles.serviceReadMore}>
                  Solicitar servicio →
                </a>
              </div>
            </SwiperSlide>
            <SwiperSlide>
              <div className={styles.serviceCard}>
                <div className={styles.serviceImg}>
                  <img src="/images/servicio-hogar-inteligente.webp" alt="Control de plagas en espacios exteriores" />
                </div>
                <div className={styles.serviceIcon}>
                  <Snail size={30} />
                </div>
                <h3>Control de plagas en exteriores</h3>
                <p>
                  Disfrute su patio sin mosquitos, hormigas ni plagas.
                  Tratamientos ecológicos seguros para mascotas.
                </p>
                <a href="https://wa.me/59176738282" className={styles.serviceReadMore}>
                  Solicitar servicio →
                </a>
              </div>
            </SwiperSlide>
            <SwiperSlide>
              <div className={styles.serviceCard}>
                <div className={styles.serviceImg}>
                  <img src="/images/servicio-control-exteriores.webp" alt="Protección completa del hogar contra plagas" />
                </div>
                <div className={styles.serviceIcon}>
                  <HouseWifi size={30} />
                </div>
                <h3>Protección residencial completa</h3>
                <p>
                  Hogar seguro para su familia — sin cucarachas, hormigas ni chinches.
                  Inspección gratuita incluída.
                </p>
                <a href="https://wa.me/59176738282" className={styles.serviceReadMore}>
                  Solicitar servicio →
                </a>
              </div>
            </SwiperSlide>
            <SwiperSlide>
              <div className={styles.serviceCard}>
                <div className={styles.serviceImg}>
                  <img src="/images/servicio-fumigacion-residencial.webp" alt="Protección completa del hogar contra plagas" />
                </div>
                <div className={styles.serviceIcon}>
                  <Building2 size={30} />
                </div>
                <h3>Control de plagas residenciales</h3>
                <p>
                  Protección completa para su hogar — cucarachas, hormigas y más.
                  Visitas programadas o servicio único. Sin compromiso.
                </p>
                <a href="https://wa.me/59176738282" className={styles.serviceReadMore}>
                  Solicitar servicio →
                </a>
              </div>
            </SwiperSlide>
          </Swiper>

          {/* <!-- Texto final --> */}
          <div className={`services-cta ${styles.serviceCta}`}>
            <p>
              ¿Listo para un hogar libre de plagas?
              <a
                href="#contact"
                className={`cta-link ${styles.serviceCtaLink}`}
              >
                ¡Contáctenos hoy!
              </a>
            </p>
          </div>
        </div>
      </section>

      {/* <!-- our features --> */}
      <section
        className={`our-features mr-8 ml-8 mt-2 flex justify-center md:mt-6 lg:mt-10 ${styles.ourFeatures}`}
        id="servicios"
      >
        <div className="container w-full">
          <div className="features-wrapper /* Móvil: 1 columna por defecto (sm) */ /* Tabletas y Escritorios medianos: 2 columnas */ grid grid-cols-1 items-center gap-[100px] md:grid-cols-2">
            {/* <!-- Columna Izquierda - Texto + Características --> */}
            <div className="features-content">
              <span className={`section-tag ${styles.sectionTag}`}>
                Nuestros servicios
              </span>
              <h2 className={`section-title ${styles.sectionTitle}`}>
                Su socio de confianza en
                <span className="text-green"> control de plagas</span>
              </h2>

              <p className={`features-text ${styles.featuresText}`}>
                Entendemos lo frustrantes y molestas que pueden ser las plagas,
                por eso nos comprometemos a brindar soluciones rápidas,
                confiables y efectivas. Contamos con un equipo de expertos
                certificados, métodos ecológicos y una atención al cliente
                inigualable.
              </p>

              <div
                className={`features-grid mt-12 md:mt-16 lg:mt-24 ${styles.featuresGrid}`}
              >
                {/* Feature 1 - Servicios de emergencia */}
                <div
                  className={`features-item ${styles.featuresItem} group transition-all duration-300 hover:-translate-y-2 hover:scale-105 hover:shadow-xl`}
                >
                  <div
                    className={`features-icon ${styles.featuresIcon} text-red-600 group-hover:text-red-500`}
                  >
                    <Siren className="h-12 w-12" strokeWidth={2.2} />
                  </div>
                  <div className={`features-text ${styles.featuresText}`}>
                    <h4 className="text-white-900 mb-2 text-xl font-bold transition-colors group-hover:text-red-700 md:text-2xl">
                      Servicios de emergencia
                    </h4>
                    <p className="leading-relaxed text-gray-500">
                      Estamos disponibles las 24 horas para atender su
                      emergencia, incluso feriados.
                    </p>
                  </div>
                </div>

                {/* Feature 2 - Tratamientos personalizados */}
                <div
                  className={`features-item ${styles.featuresItem} group transition-all duration-300 hover:-translate-y-2 hover:scale-105 hover:shadow-xl`}
                >
                  <div
                    className={`features-icon ${styles.featuresIcon} text-blue-600 group-hover:text-blue-500`}
                  >
                    <Settings className="h-12 w-12" strokeWidth={2.2} />
                  </div>
                  <div className={`features-text ${styles.featuresText}`}>
                    <h4 className="text-white-900 mb-2 text-xl font-bold transition-colors group-hover:text-blue-700 md:text-2xl">
                      Tratamientos personalizados
                    </h4>
                    <p className="leading-relaxed text-gray-500">
                      Cada propiedad es única, por lo que diseñamos soluciones
                      específicas para su caso.
                    </p>
                  </div>
                </div>

                {/* Feature 3 - Profesionales certificados */}
                <div
                  className={`features-item ${styles.featuresItem} group transition-all duration-300 hover:-translate-y-2 hover:scale-105 hover:shadow-xl`}
                >
                  <div
                    className={`features-icon ${styles.featuresIcon} text-green-600 group-hover:text-green-500`}
                  >
                    <ShieldCheck className="h-12 w-12" strokeWidth={2.2} />
                  </div>
                  <div className={`features-text ${styles.featuresText}`}>
                    <h4 className="text-white-900 mb-2 text-xl font-bold transition-colors group-hover:text-green-700 md:text-2xl">
                      <strong>Profesionales certificados</strong>
                    </h4>
                    <p className="leading-relaxed text-gray-500">
                      Nuestro equipo está altamente capacitado, certificado y
                      con años de experiencia comprobada.
                    </p>
                  </div>
                </div>

                {/* Feature 4 - Resultados garantizados */}
                <div
                  className={`features-item ${styles.featuresItem} group transition-all duration-300 hover:-translate-y-2 hover:scale-105 hover:shadow-xl`}
                >
                  <div
                    className={`features-icon ${styles.featuresIcon} text-emerald-600 group-hover:text-emerald-500`}
                  >
                    <BadgeCheck className="h-12 w-12" strokeWidth={2.2} />
                  </div>
                  <div className={`features-text ${styles.featuresText}`}>
                    <h4 className="text-white-900 mb-2 text-xl font-bold transition-colors group-hover:text-emerald-700 md:text-2xl">
                      Resultados garantizados
                    </h4>
                    <p className="leading-relaxed text-gray-500">
                      Respaldamos nuestro trabajo con garantía por escrito. Si
                      vuelven, ¡volvemos gratis!
                    </p>
                  </div>
                </div>
              </div>
            </div>
            {/* <!-- Columna Derecha - Imagen + Botón flotante --> */}
            <div className={`features-image ${styles.featuresImage}`}>
              <img
                src="/images/features/seis.webp"
                alt="Técnico profesional realizando servicio de fumigación"
              />

              {/* <!-- Botón circular flotante --> */}
              <a
                href="https://wa.me/59176738282"
                className={`features-btn ${styles.featuresBtn}`}
              >
                <i className="fas fa-phone"></i>
                <span>Contactanos</span>
              </a>
            </div>
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
          <div className="section-header text-center">
            <span className={`section-tag ${styles.sectionTag}`}>
              Portafolio
            </span>
            <h2 className={`section-title ${styles.sectionTitle}`}>
              Descubra nuestra trayectoria comprobada en
              <span className="text-green">
                {' '}
                soluciones para eliminar plagas
              </span>
            </h2>
          </div>
          <div
            className={`portfolio-grid mt-8 md:mt-16 lg:mt-24 ${styles.portfolioGrid}`}
            id="portfolioGrid"
            >
              {/* Item 1 - Control de Plagas en Hogar */}
              <div className={`portfolio-item home ${styles.portfolioItem}`}>
                {/* Reemplazamos img + overlay por el embed de TikTok */}
                <div className="tiktok-video-wrapper">
                  <blockquote
                    className="tiktok-embed"
                    cite="https://www.tiktok.com/@bolivian_pest/video/7471413968603467063"
                    data-video-id="7471413968603467063"
                    style={{ maxWidth: "325px", minWidth: "325px" }}
                  >
                    <section>
                      <a href="https://www.tiktok.com/@bolivian_pest/video/7471413968603467063?refer=embed">
                      </a>
                    </section>
                  </blockquote>
                </div>

              </div>

              {/* Item 2 - Plagas en Negocios */}
              <div className={`portfolio-item commercial ${styles.portfolioItem}`}>
                <div className="tiktok-video-wrapper">
                  <blockquote
                    className="tiktok-embed"
                    cite="https://www.tiktok.com/@bolivian_pest/video/7470332967810780422"
                    data-video-id="7471413968603467063"
                    style={{ maxWidth: "325px", minWidth: "325px" }}
                  >
                    <section>
                      <a href="https://www.tiktok.com/@bolivian_pest/video/7470332967810780422?refer=embed">
                      </a>
                    </section>
                  </blockquote>
                </div>
              </div>

              {/* Repite el mismo patrón para los otros 4 items... */}

              {/* Ejemplo para el último */}
              <div className={`portfolio-item outdoor ${styles.portfolioItem}`}>
                <div className="tiktok-video-wrapper">
                  <blockquote
                    className="tiktok-embed"
                    cite="https://www.tiktok.com/@bolivian_pest/video/7468916199028509957"
                    data-video-id="7471413968603467063"
                    style={{ maxWidth: "325px", minWidth: "325px" }}
                  >
                    <section>
                      <a href="https://www.tiktok.com/@bolivian_pest/video/7468916199028509957?refer=embed">
                      </a>
                    </section>
                  </blockquote>
                </div>
              </div>
            </div>
          </div>
      </section>

      {/* <!-- por que elegirnos --> */}
      <section
        className="why-choose mt-8 flex justify-center md:mt-16 lg:mt-24"
        id="why-choose"
      >
        <div className="container w-full">
          {/* <!-- Tag y título --> */}
          <div className="section-header text-center">
            <span className={`section-tag ${styles.sectionTag}`}>
              ¿Por qué elegirnos?
            </span>
            <h2 className={`section-title ${styles.sectionTitle}`}>
              ¿Qué nos convierte en la mejor opción
              <span className="text-green"> para usted?</span>
            </h2>
            <p className={`section-desc ${styles.sectionDescription}`}>
              29 años de experiencia en Bolivia. Técnicos certificados SENASAG.
              Productos ecológicos seguros para niños y mascotas. Atención 24/7.
            </p>
          </div>



          {/* <!-- CTA final --> */}
          <div className={`why-cta ${styles.whyCta}`}>
            <a
              href="mailto:info@bolivianpest.com"
              target="_blank"
              className="btn-free"
            >
              ¡Haga su cita hoy! Disponible de inmediato — Inspección gratuita sin compromiso
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
            {/* <!-- Imágenes decorativas izquierda --> */}
            <div className={`faqImages ${styles.faqImages}`}>
              <img
                src="/images/questions/doce.webp"
                alt="Técnico fumigando en propiedad"
                className={`img-1 ${styles.faqImg1}`}
              />
              <img
                src="/images/questions-equipo-profesional.webp"
                alt="Equipo certificado Bolivian Pest"
                className={`img-2 ${styles.faqImg2}`}
              />
              <img
                src="/images/questions/seis.webp"
                alt="Fumigación en espacios exteriores"
                className={`img-3 ${styles.faqImg3}`}
              />
            </div>

            {/* <!-- Contenido FAQ derecha --> */}
            <div className="faq-content">
              <span className={`section-tag ${styles.sectionTag}`}>
                Preguntas frecuentes
              </span>
              <h2 className={`section-title ${styles.sectionTitle}`}>
                Encuentre respuestas útiles a sus dudas sobre
                <span className="text-green">el control de plagas</span>
              </h2>
              <Accordion
                type="single"
                collapsible
                className="w-full pl-8 pr-8"
                defaultValue="item-1"
              >
                   {' '}
                <AccordionItem value="item-1">
                       {' '}
                  <AccordionTrigger className="text-lg text-cyan-500 no-underline hover:text-cyan-700 hover:no-underline">
                    1. ¿Qué tipos de plagas tratan?
                  </AccordionTrigger>
                       {' '}
                  <AccordionContent className="flex flex-col text-left">
                           {' '}
                    <p>Controlamos una amplia variedad de plagas, incluyendo</p>
                             {' '}
                    <p>
                      <strong>
                        {' '}
                        roedores, hormigas, cucarachas, termitas, chinches,
                        mosquitos, arañas y fauna silvestre.
                      </strong>
                    </p>
                             {' '}
                    <p>
                      Aplicamos métodos específicos según la especie para
                      garantizar resultados efectivos.        {' '}
                    </p>
                         {' '}
                  </AccordionContent>
                     {' '}
                </AccordionItem>
                   {' '}
                <AccordionItem value="item-2">
                       {' '}
                  <AccordionTrigger className="text-lg text-cyan-500 no-underline hover:text-cyan-700 hover:no-underline">
                    2. ¿Son seguros sus métodos de control de plagas para mis
                    mascotas?
                  </AccordionTrigger>
                       {' '}
                  <AccordionContent className="flex flex-col text-left">
                           {' '}
                    <p>
                      {' '}
                      Sí. Todos nuestros productos y procedimientos están
                      certificados y son seguros para mascotas y personas,
                      siempre y cuando se sigan las indicaciones del técnico.
                      Utilizamos productos de baja toxicidad, aprobados por{' '}
                      <strong>SENASAG</strong>, y aplicados bajo estándares
                      profesionales para evitar cualquier riesgo. Además,
                      brindamos instrucciones claras sobre el tiempo de
                      reingreso y cuidados posteriores para garantizar la
                      seguridad de tus animales domésticos.        {' '}
                    </p>
                         {' '}
                  </AccordionContent>
                     {' '}
                </AccordionItem>
                   {' '}
                <AccordionItem value="item-3">
                       {' '}
                  <AccordionTrigger className="text-lg text-cyan-500 no-underline hover:text-cyan-700 hover:no-underline">
                    3. ¿Con qué frecuencia debo programar los servicios de
                    control de plagas?
                  </AccordionTrigger>
                       {' '}
                  <AccordionContent className="flex flex-col text-left">
                           {' '}
                    <p>
                      La frecuencia depende del tipo de plaga y del entorno:
                    </p>
                    <ul>
                      <li>
                        <strong>Hogares:</strong> cada 3 a 4 meses suele ser
                        suficiente para mantener un ambiente libre de plagas.
                      </li>
                      <li>
                        <strong>Comercios:</strong> recomendamos un servicio
                        mensual o bimensual, especialmente si hay almacenamiento
                        de alimentos.
                      </li>
                      <li>
                        <strong>Industrias y restaurantes:</strong> servicios
                        mensuales o incluso quincenales, de acuerdo con normas
                        de salubridad.
                      </li>
                    </ul>
                    <p>
                      Nuestros técnicos evalúan tu caso y generan un plan
                      personalizado según el nivel de infestación y las
                      características del lugar.
                    </p>
                         {' '}
                  </AccordionContent>
                     {' '}
                </AccordionItem>
                   {' '}
                <AccordionItem value="item-4">
                       {' '}
                  <AccordionTrigger className="text-lg text-cyan-500 no-underline hover:text-cyan-700 hover:no-underline">
                    4. ¿Ofrecen servicios de control de plagas de emergencia?
                  </AccordionTrigger>
                       {' '}
                  <AccordionContent className="flex flex-col text-left">
                           {' '}
                    <p>
                      Sí, contamos con servicios de emergencia para
                      infestaciones severas o situaciones que requieren atención
                      inmediata, como:{' '}
                    </p>
                    <br />
                    <ul>
                      <li>
                        <strong>Nidos de avispas</strong>{' '}
                      </li>
                                 {' '}
                      <li>
                        <strong>Presencia elevada de roedores</strong>{' '}
                      </li>
                                 {' '}
                      <li>
                        <strong>
                          Brotes de cucarachas en cocinas o negocios
                        </strong>{' '}
                      </li>
                                 {' '}
                      <li>
                        <strong>Invasión de chinches</strong>{' '}
                      </li>
                                 {' '}
                      <li>
                        <strong>
                          Plagas que afecten la operación de tu empresa
                        </strong>{' '}
                      </li>
                    </ul>
                               {' '}
                    <p>
                      Atendemos en el menor tiempo posible para controlar
                      rápidamente el problema y evitar riesgos para tu salud o
                      tu actividad comercial.        {' '}
                    </p>
                         {' '}
                  </AccordionContent>
                     {' '}
                </AccordionItem>
                   {' '}
                <AccordionItem value="item-5">
                       {' '}
                  <AccordionTrigger className="text-lg text-cyan-500 no-underline hover:text-cyan-700 hover:no-underline">
                    5. ¿Cómo sé si tengo una plaga?
                  </AccordionTrigger>
                       {' '}
                  <AccordionContent className="flex flex-col text-left">
                            <p>Algunas señales comunes incluyen: </p>
                    <ul>
                               {' '}
                      <li>
                        <strong>
                          Excrementos pequeños o manchas oscuras (roedores,
                          cucarachas).
                        </strong>
                      </li>
                               {' '}
                      <li>
                        <strong>Ruidos dentro de paredes o techos.</strong>
                      </li>
                               {' '}
                      <li>
                        <strong>
                          Olores fuertes o desagradables, especialmente en
                          cocinas o depósitos.
                        </strong>
                      </li>
                               {' '}
                      <li>
                        <strong>
                          Huecos o montículos en madera o suelo (termitas).{' '}
                        </strong>
                      </li>
                    </ul>
                             {' '}
                    <p>
                      Si notas cualquiera de estos signos, lo ideal es solicitar
                      una inspección profesional, ya que muchas plagas se
                      esconden y solo un técnico puede detectarlas a tiempo.    
                         {' '}
                    </p>
                         {' '}
                  </AccordionContent>
                     {' '}
                </AccordionItem>
              </Accordion>
            </div>
          </div>
        </div>
      </section>
      {/* <!-- CTA --> */}
      <section
  className={`about-your mt-2 md:mt-6 lg:mt-10 ${styles.ctaSection} bg-gray-50 dark:bg-gray-900 py-12 md:py-16 lg:py-20`}
  id="contacto"
>
  <div className="container mx-auto px-4 sm:px-6 lg:px-8 max-w-7xl">
    <div className="grid grid-cols-1 lg:grid-cols-2 gap-10 lg:gap-16 items-center">

      {/* Columna izquierda - Información / Imagen / Mensaje motivador */}
      <div className="space-y-6 lg:space-y-8 order-2 lg:order-1">
        {/* Imagen decorativa o ilustración (puedes cambiarla) */}
        <div className="relative rounded-2xl overflow-hidden shadow-xl">
          <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d239.0954346072869!2d-68.12636138046955!3d-16.499473655781642!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x915f210059ecf6c7%3A0xca158fcbb8866f59!2sBolivianPest!5e0!3m2!1ses!2sbo!4v1772571664453!5m2!1ses!2sbo"
          width="600" height="450"  loading="lazy"></iframe>
          {/* Overlay opcional con gradiente */}
          <div className="absolute inset-0 bg-gradient-to-t from-black/40 to-transparent" />
        </div>

        {/* Información adicional (opcional pero profesional) */}
        <div className="space-y-4 text-gray-600 dark:text-gray-300">

              <div className="space-y-4">
                {/* Teléfono */}
                <div
                  className={`contact-item flex items-center gap-4 ${styles.footerContactItem}`}
                >
                  <div className="flex h-10 w-10 shrink-0 items-center justify-center rounded-full bg-cyan-600 text-white">
                    <Phone className="h-5 w-5" strokeWidth={2.5} />
                  </div>
                  <div>
                    <p className="text-sm text-gray-400">Teléfono / WhatsApp</p>
                    <a
                      href="https://wa.me/59176738282"
                      className="hover:text-white-400 text-white transition"
                    >
                      +591 76738282
                    </a>
                  </div>
                </div>

                {/* Email */}
                <div
                  className={`contact-item flex items-center gap-4 ${styles.footerContactItem}`}
                >
                  <div className="flex h-10 w-10 shrink-0 items-center justify-center rounded-full bg-cyan-600 text-white">
                    <Mail className="h-5 w-5" strokeWidth={2.5} />
                  </div>
                  <div>
                    <p className="text-sm text-gray-400">Correo electrónico</p>
                    <a
                      href="mailto:info@bolivianpest.com"
                      className="hover:text-white-400 text-white transition"
                    >
                      info@bolivianpest.com
                    </a>
                  </div>
                </div>
              </div>
        </div>
      </div>

      {/* Columna derecha - Formulario */}
      <div className="bg-white dark:bg-gray-800 rounded-2xl shadow-lg p-6 md:p-8 lg:p-10 order-1 lg:order-2">
        <form className="space-y-8">
          <h3 className="text-2xl font-semibold text-gray-900 dark:text-white">
            Contáctanos
          </h3>

          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div>
              <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">
                Nombre completo
              </label>
              <input
                type="text"
                className="w-full px-4 py-3 rounded-lg border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-700 text-gray-900 dark:text-white focus:ring-2 focus:ring-primary focus:border-primary outline-none transition"
                placeholder="Tu nombre"
                required
              />
            </div>

            <div>
              <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">
                Ciudad
              </label>
              <input
                type="text"
                className="w-full px-4 py-3 rounded-lg border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-700 text-gray-900 dark:text-white focus:ring-2 focus:ring-primary focus:border-primary outline-none transition"
                placeholder="La Paz, Santa Cruz, etc."
              />
            </div>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div>
              <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">
                Email
              </label>
              <input
                type="email"
                className="w-full px-4 py-3 rounded-lg border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-700 text-gray-900 dark:text-white focus:ring-2 focus:ring-primary focus:border-primary outline-none transition"
                placeholder="tu@email.com"
                required
              />
            </div>

            <div>
              <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">
                Teléfono
              </label>
              <input
                type="tel"
                className="w-full px-4 py-3 rounded-lg border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-700 text-gray-900 dark:text-white focus:ring-2 focus:ring-primary focus:border-primary outline-none transition"
                placeholder="+591 7XXX XXXX"
              />
            </div>
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">
              Mensaje
            </label>
            <textarea
              rows={5}
              className="w-full px-4 py-3 rounded-lg border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-700 text-gray-900 dark:text-white focus:ring-2 focus:ring-primary focus:border-primary outline-none transition resize-none"
              placeholder="Cuéntanos sobre tu proyecto, requerimientos o cualquier consulta..."
              required
            />
          </div>

          <div className="flex justify-end">
            <button
              type="submit"
              className="px-8 py-3 bg-primary/10 hover:bg-primary/50 font-medium rounded-lg shadow-md transition focus:outline-none focus:ring-2 focus:ring-primary focus:ring-offset-2"
            >
              Enviar mensaje
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
</section>

      {/* <!-- Footer --> */}
      <footer className={`footer flex justify-center ${styles.footer}`}>
        <div className="container w-full">
          {/* <!-- Parte superior: 4 columnas --> */}
          <div className={`footer-top ${styles.footerTop}`}>
            {/* <!-- Columna 1: About Petronus --> */}
            <div className={`footer-column about ${styles.footerColumn}`}>
              <h3>Acerca de Bolivian Pest</h3>
              <p>
                Nos dedicamos a crear entornos seguros y libres de plagas para
                hogares y negocios. Contamos con años de experiencia en el
                sector del control de plagas. Nos enorgullecemos de ofrecer
                soluciones eficaces y ecológicas adaptadas a sus necesidades.
              </p>
            </div>

            {/* <!-- Columna 2: Services --> */}
            <div className={`footer-column ${styles.footerColumn}`}>
              <h3>Servicios</h3>
              <ul>
                <li>
                  <a href="#">Acerca de la Compañia</a>
                </li>
                <li>
                  <a href="#">Servicios</a>
                </li>
                <li>
                  <a href="#">Por que elegirnos?</a>
                </li>
                <li>
                  <a href="#">Testimonios</a>
                </li>
                <li>
                  <a href="https://wa.me/59176738282">Contáctanos</a>
                </li>
              </ul>
            </div>

            {/* <!-- Columna 3: Links --> */}
            <div className={`footer-column about ${styles.footerColumn}`}>
              <h3>Enlaces a:</h3>
              <ul>
                <li>
                  <a href="#">riesgos de plagas</a>
                </li>
                <li>
                  <a href="#">plagas en centro comerciales</a>
                </li>
                <li>
                  <a href="#">Roedores & Termitas</a>
                </li>
                <li>
                  <a href="#">Tratamientos Eco-Friendly</a>
                </li>
                <li>
                  <a href="#">Eliminación de fauna silvestre</a>
                </li>
                <li>
                  <a href="/login">Acceso a Sistema</a>
                </li>
              </ul>
            </div>
          </div>

          <hr className={`footer-divider${styles.footerDivider}`} />

          {/* <!-- Parte inferior: Logo + Redes + Copyright --> */}
          <div className={`footer-bottom ${styles.footerBottom}`}>
            <div className={`footer-logo ${styles.footerLogo}`}>
              {/* <!-- Puedes reemplazar este SVG con tu logo real --> */}
              <svg
                width="50"
                height="50"
                viewBox="0 0 100 100"
                fill="none"
                xmlns="http://www.w3.org/2000/svg"
              >
                <circle
                  cx="50"
                  cy="50"
                  r="45"
                  stroke="#013147"
                  stroke-width="6"
                />
                <path
                  d="M30 50L45 65L70 35"
                  stroke="#013147"
                  stroke-width="8"
                  stroke-linecap="round"
                />
              </svg>
              <span className={`logo-text ${styles.footerLogoText}`}>
                BolivianPest
              </span>
            </div>
            <div className={`social-links ${styles.footerSocialLinks}`}>
              <a
                href="https://www.instagram.com/bolivian_pest?igsh=MTF4dHFjZGoxMzlocQ=="
                target="_blank"
                rel="noopener noreferrer"
                aria-label="Instagram"
                className="group"
              >
                <Instagram className="h-6 w-6 transition-all group-hover:scale-110 group-hover:text-pink-500" />
              </a>

              <a
                href="https://www.facebook.com/p/Bolivian-Pest-Higiene-Ambiental-61572172198692/"
                target="_blank"
                rel="noopener noreferrer"
                aria-label="Facebook"
                className="group"
              >
                <Facebook className="h-6 w-6 transition-all group-hover:scale-110 group-hover:text-blue-600" />
              </a>
              <a
                href="https://wa.me/59176738282"
                target="_blank"
                rel="noopener noreferrer"
                aria-label="WhatsApp"
                className="group"
              >
                <Phone className="h-6 w-6 transition-all group-hover:scale-110 group-hover:text-green-500" />
              </a>
            </div>

            <div className={`copyright ${styles.footerCopyright}`}>
              Copyright <a href="https://bitdesarrollo.net">Bitdesarrollo</a> © 2026 All Rights Reserved.
            </div>
          </div>
        </div>
      </footer>
    </>
  );
}
