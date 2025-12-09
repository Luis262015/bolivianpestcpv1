import Navbar from '@/components/landing/Navbar';
import {
  Accordion,
  AccordionContent,
  AccordionItem,
  AccordionTrigger,
} from '@/components/ui/accordion';
import { Head } from '@inertiajs/react';
import { Autoplay, EffectFade, Navigation, Pagination } from 'swiper/modules';
import { Swiper, SwiperSlide } from 'swiper/react';

import styles from './landing.module.css';

import { BugOff, Check, Play, CheckCircle2, Phone, Mail,Clock, 
  Settings, 
  ShieldCheck, 
  Zap, 
  Award, 
  Users,
 Instagram, Facebook, Siren, BadgeCheck  } from 'lucide-react';
import 'swiper/css';
import 'swiper/css/autoplay';
import 'swiper/css/effect-fade';
import 'swiper/css/navigation';
import 'swiper/css/pagination';
import SplashScreen from '@/components/SplashScreen';

export default function Landing() {
  return (
    <>
    <SplashScreen screen="/images/LogoBlack.png" />

      {/* pestaña de navegador */}
      <Head title="Inicio">
        <link rel="preconnect" href="https://fonts.bunny.net" />
        <link
          href="https://fonts.bunny.net/css?family=inter:200,300,300i,400,400i,500,500i,600,600i,700,800,900"
          rel="stylesheet"
        />
      </Head>

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
  <div className="absolute inset-0 bg-gray-900/80 pointer-events-none z-10" />
    <SwiperSlide>
      <img
        src="/images/slider/sli1.webp"
        className="h-full w-full object-cover"
        alt="Slide 1"
        loading="lazy"
      />
    </SwiperSlide>
    <SwiperSlide>
      <img
        src="/images/slider/sli2.webp"
        className="h-full w-full object-cover"
        alt="Slide 2"
        loading="lazy"
      />
    </SwiperSlide>
    <SwiperSlide>
      <img
        src="/images/slider/sli3.webp"
        className="h-full w-full object-cover"
        alt="Slide 3"
        loading="lazy"
      />
    </SwiperSlide>
    <SwiperSlide>
      <img
        src="/images/slider/sli4.webp"
        className="h-full w-full object-cover"
        alt="Slide 4"
        loading="lazy"
      />
    </SwiperSlide>
  </Swiper>

  {/* Overlay con texto y personaje */}
  <div className="absolute inset-0 z-10 flex items-center justify-center">
    <div className="max-w-[1000px] w-full px-6 md:px-10">
      <div className="grid grid-cols-1 lg:grid-cols-2 items-center gap-8 lg:gap-12">
        
        {/* Personaje - se oculta en ≤1024px (lg y menores) */}
        <div className="hidden lg:block justify-self-end">
          <img 
            src="/images/cta/personaje.webp" 
            alt="Personaje" 
            className="max-w-full h-auto"
          />
        </div>

        {/* Texto - centrado en móvil, alineado a la izquierda en desktop */}
        <div className="text-center lg:text-left">
          <h1 className="
            mb-3 sm:mb-4 
            font-bold text-white drop-shadow-2xl
            text-2xl     /* ≤ 425px */
            sm:text-3xl  /* 426px - 640px */
            md:text-4xl  /* 768px+ */
            lg:text-5xl  /* 1024px+ */
            xl:text-[2.8rem]
            leading-tight
          ">
            Servicios confiables de control de plagas e insectos en los que puede confiar.
          </h1>

          <p className="
            text-white drop-shadow-lg
            text-sm      /* ≤ 425px → más pequeño */
            sm:text-base /* 426px - 640px */
            md:text-lg   /* 768px+ */
            lg:text-xl   /* 1024px+ */
            leading-relaxed
          ">
            Proteja su hogar y negocio con nuestras soluciones efectivas para el control de plagas. 
            Desde termitas hasta roedores, eliminamos las plagas de forma rápida y segura.
          </p>
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
                alt="Icon 1"
              />
            </div>
            <div className="ms-4">
              <h3 className="text-[20px] font-bold">Cobertura Integral</h3>
              {/* <a href="#" className="read-more">
                Leer más <span>→</span>
              </a> */}
            </div>
          </div>

          <div className="feature-box flex border-2 border-s-0 p-[20px] text-left">
            <div className="icon-circle flex h-[70px] w-[70px] items-center justify-center rounded-full bg-[#013147]">
              <img
                src="/images/icons/tiempob.svg"
                className="w-[35px]"
                alt="Icon 2"
              />
            </div>
            <div className="ms-4">
              <h3 className="text-[20px] font-bold">
                Tiempos de respuesta <br />
                rapidos
              </h3>
              {/* <a href="#" className="read-more">
                Leer más <span>→</span>
              </a> */}
            </div>
          </div>

          <div className="feature-box flex border-2 border-s-0 p-[20px] text-left">
            <div className="icon-circle flex h-[70px] w-[70px] items-center justify-center rounded-full bg-[#013147]">
              <img
                src="/images/icons/serviciob.svg"
                className="w-[35px]"
                alt="Icon 3"
              />
            </div>
            <div className="ms-4">
              <h3
                className="text-[20px] font-bold"
                // style={{ background: 'var(--color-text-title)' }}
              >
                Servicios <br /> comerciales
              </h3>
              {/* <a href="#" className="read-more">
                Leer más <span>→</span>
              </a> */}
            </div>
          </div>

          <div className="feature-box flex border-2 border-s-0 border-e-0 p-[20px] text-left">
            <div className="icon-circle flex h-[70px] w-[70px] items-center justify-center rounded-full bg-[#013147]">
              <img
                src="/images/icons/emergenciab.svg"
                className="w-[35px]"
                alt="Icon 4"
              />
            </div>
            <div className="ms-4">
              <h3 className="text-[20px] font-bold">
                Servicio de <br /> Emergencia 24/7
              </h3>
              {/* <a href="#" className="read-more">
                Leer más <span>→</span>
              </a> */}
            </div>
          </div>
        </div>
      </section>

      {/* <!-- about us --> */}
      <section className="about-us flex justify-center" id="nosotros">
        <div className="container w-full">
          <div className="about-wrapper grid grid-cols-1  lg:grid-cols-2 items-center gap-[10px]">
            {/* <!-- Columna Izquierda - Imagen Principal + Círculos de Insectos --> */}
            <div className="about-image relative h-[600px] mt-8 md:mt-12 lg:mt-20">
              <div className="main-circle absolute h-[520px] w-[520px] overflow-hidden rounded-full border-[12px] shadow-2xl">
                <img
                  src="/images/about/cuatro.webp"
                  className="h-[100%] w-[100%] object-cover"
                  alt="Técnico fumigando"
                />
              </div>
              {/* <!-- Círculos flotantes de insectos --> */}
              <div className="floating-bug bug-1 absolute mt-[340px] h-[120px] w-[120px] overflow-hidden rounded-full border-[8px] shadow-2xl">
                <img
                  src="/images/about/dos.webp"
                  className="h-[100%] w-[100%] object-cover"
                  alt="Mosquito"
                />
              </div>
              <div className="floating-bug bug-2 absolute ms-[420px] mt-[100px] h-[120px] w-[120px] overflow-hidden rounded-full border-[8px] shadow-2xl">
                <img
                  src="/images/about/uno.webp"
                  className="h-[100%] w-[100%] object-cover"
                  alt="Escarabajo"
                />
              </div>
              <div className="floating-bug bug-3 absolute h-[120px] w-[120px] overflow-hidden rounded-full border-[8px] shadow-2xl">
                <img
                  src="/images/about/siete.webp"
                  className="h-[100%] w-[100%] object-cover"
                  alt="Cucaracha"
                />
              </div>
            </div>

            {/* <!-- Columna Derecha - Texto y Estadísticas --> */}
            <div className="mt-8 md:mt-12 lg:mt-20 ml-2 md:ml-12 lg:ml-20  about-content">
              <span className={`section-tag ${styles.sectionTag}`}>
                Acerca de Nosotros
              </span>
              <h2 className={`section-title ${styles.sectionTitle}`}>
                Protegiendo hogares,
                <span>negocios y comunidades</span>
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
      <section className="mt-8 md:mt-12 lg:mt-20 services flex justify-center" id="servicios">
        <div className="container w-full">
          {/* <!-- Tag y título --> */}
          <div className=" section-header text-center">
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
            className="mt-2 md:mt-6 lg:mt-10 mySwiper"
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
                  <img src="/images/services/uno.webp" alt="Commercial" />
                </div>
                <div className={styles.serviceIcon}>
                  {/* <i className="fas fa-building"></i> */}
                  <BugOff size={30} />
                </div>
                <h3>Soluciones comerciales para el control de plagas</h3>
                <p>
                  Soluciones personalizadas para proteger su hogar de las plagas
                  comunes
                </p>
                <a href="#" className={styles.serviceReadMore}>
                  Read More →
                </a>
              </div>
            </SwiperSlide>
            <SwiperSlide>
              <div className={styles.serviceCard}>
                <div className={styles.serviceImg}>
                  <img src="/images/services/dos.webp" alt="Termite" />
                </div>
                <div className={styles.serviceIcon}>
                  <BugOff size={30} />
                </div>
                <h3>Control de termitas y roedores</h3>
                <p>
                  Soluciones personalizadas para proteger su hogar de las plagas
                  comunes
                </p>
                <a href="#" className={styles.serviceReadMore}>
                  Read More →
                </a>
              </div>
            </SwiperSlide>
            <SwiperSlide>
              <div className={styles.serviceCard}>
                <div className={styles.serviceImg}>
                  <img src="/images/services/tres.webp" alt="Outdoor" />
                </div>
                <div className={styles.serviceIcon}>
                  <BugOff size={30} />
                </div>
                <h3>Control de plagas en exteriores</h3>
                <p>
                  Soluciones personalizadas para proteger su hogar de las plagas
                  comunes
                </p>
                <a href="#" className={styles.serviceReadMore}>
                  Read More →
                </a>
              </div>
            </SwiperSlide>
            <SwiperSlide>
              <div className={styles.serviceCard}>
                <div className={styles.serviceImg}>
                  <img src="/images/services/cuatro.webp" alt="Smart Home" />
                </div>
                <div className={styles.serviceIcon}>
                  <BugOff size={30} />
                </div>
                <h3>Integración de hogares inteligentes</h3>
                <p>
                  Soluciones personalizadas para proteger su hogar de las plagas
                  comunes
                </p>
                <a href="#" className={styles.serviceReadMore}>
                  Read More →
                </a>
              </div>
            </SwiperSlide>
            <SwiperSlide>
              <div className={styles.serviceCard}>
                <div className={styles.serviceImg}>
                  <img src="/images/services/cinco.webp" alt="Smart Home" />
                </div>
                <div className={styles.serviceIcon}>
                  <BugOff size={30} />
                </div>
                <h3>Control de plagas residenciales</h3>
                <p>
                  Soluciones personalizadas para proteger su hogar de las plagas
                  comunes
                </p>
                <a href="#" className={styles.serviceReadMore}>
                  Read More →
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
        className={`mt-2 md:mt-6 lg:mt-10 our-features flex justify-center ${styles.ourFeatures}`}
        id="#"
      >
        <div className="container w-full">
          <div className="features-wrapper grid 
    grid-cols-1   /* Móvil: 1 columna por defecto (sm) */
    md:grid-cols-2 /* Tabletas y Escritorios medianos: 2 columnas */
    items-center 
    gap-[80px]">
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

              <div className={`mt-12 md:mt-16 lg:mt-24 features-grid ${styles.featuresGrid}`}>
  
                  {/* Feature 1 - Servicios de emergencia */}
                  <div className={`features-item ${styles.featuresItem} group transition-all duration-300 hover:scale-105 hover:shadow-xl hover:-translate-y-2`}>
                    <div className={`features-icon ${styles.featuresIcon} text-red-600 group-hover:text-red-500`}>
                      <Siren className="h-12 w-12" strokeWidth={2.2} />
                    </div>
                    <div className={`features-text ${styles.featuresText}`}>
                      <h4 className="text-xl md:text-2xl font-bold text-white-900 mb-2 group-hover:text-red-700 transition-colors">
                        Servicios de emergencia
                      </h4>
                      <p className="text-gray-500 leading-relaxed">
                        Estamos disponibles las 24 horas para atender su emergencia, incluso feriados.
                      </p>
                    </div>
                  </div>

                  {/* Feature 2 - Tratamientos personalizados */}
                  <div className={`features-item ${styles.featuresItem} group transition-all duration-300 hover:scale-105 hover:shadow-xl hover:-translate-y-2`}>
                    <div className={`features-icon ${styles.featuresIcon} text-blue-600 group-hover:text-blue-500`}>
                      <Settings className="h-12 w-12" strokeWidth={2.2} />
                    </div>
                    <div className={`features-text ${styles.featuresText}`}>
                      <h4 className="text-xl md:text-2xl font-bold text-white-900 mb-2 group-hover:text-blue-700 transition-colors">
                        Tratamientos personalizados
                      </h4>
                      <p className="text-gray-500 leading-relaxed">
                        Cada propiedad es única, por lo que diseñamos soluciones específicas para su caso.
                      </p>
                    </div>
                  </div>

                  {/* Feature 3 - Profesionales certificados */}
                  <div className={`features-item ${styles.featuresItem} group transition-all duration-300 hover:scale-105 hover:shadow-xl hover:-translate-y-2`}>
                    <div className={`features-icon ${styles.featuresIcon} text-green-600 group-hover:text-green-500`}>
                      <ShieldCheck className="h-12 w-12" strokeWidth={2.2} />
                    </div>
                    <div className={`features-text ${styles.featuresText}`}>
                      <h4 className="text-xl md:text-2xl font-bold text-white-900 mb-2 group-hover:text-green-700 transition-colors">
                        <strong>Profesionales certificados</strong>
                      </h4>
                      <p className="text-gray-500 leading-relaxed">
                        Nuestro equipo está altamente capacitado, certificado y con años de experiencia comprobada.
                      </p>
                    </div>
                  </div>

                  {/* Feature 4 - Resultados garantizados */}
                  <div className={`features-item ${styles.featuresItem} group transition-all duration-300 hover:scale-105 hover:shadow-xl hover:-translate-y-2`}>
                    <div className={`features-icon ${styles.featuresIcon} text-emerald-600 group-hover:text-emerald-500`}>
                      <BadgeCheck className="h-12 w-12" strokeWidth={2.2} />
                    </div>
                    <div className={`features-text ${styles.featuresText}`}>
                      <h4 className="text-xl md:text-2xl font-bold text-white-900 mb-2 group-hover:text-emerald-700 transition-colors">
                        Resultados garantizados
                      </h4>
                      <p className="text-gray-500 leading-relaxed">
                        Respaldamos nuestro trabajo con garantía por escrito. Si vuelven, ¡volvemos gratis!
                      </p>
                    </div>
                  </div>

                </div>
            </div>
            {/* <!-- Columna Derecha - Imagen + Botón flotante --> */}
            <div className={`features-image ${styles.featuresImage}`}>
              <img
                src="/images/features/seis.webp"
                alt="Técnico profesional fumigando"
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
      <section className="mt-8 md:mt-16 lg:mt-24 our-portfolio flex justify-center" id="portafolio">
        <div className="container w-full">
          {/* <!-- Tag y título --> */}
          <div className="section-header text-center">
            <span className={`section-tag ${styles.sectionTag}`}>
              Portafolio
            </span>
            <h2 className={`section-title ${styles.sectionTitle}`}>
              Descubra nuestra trayectoria comprobada en 
              <span className="text-green"> soluciones para eliminar plagas
              </span>
            </h2>
          </div>

          {/* <!-- Filtros --> */}
          {/* <div className={`portfolio-filters ${styles.portfolioFilters}`}>
            <button
              className={`filter-btn ${styles.portfolioFilterBtn}`}
              data-filter="*"
            >
              Todo
            </button>
            <button
              className={`filter-btn ${styles.portfolioFilterBtn}`}
              data-filter=".home"
            >
              Plaga en Hogar
            </button>
            <button
              className={`filter-btn ${styles.portfolioFilterBtn}`}
              data-filter=".commercial"
            >
              Plaga Comercial
            </button>
            <button
              className={`filter-btn ${styles.portfolioFilterBtn}`}
              data-filter=".eco"
            >
              Eco-Friendly
            </button>
            <button
              className={`filter-btn ${styles.portfolioFilterBtn}`}
              data-filter=".termite"
            >
              Termitas y Roedores
            </button>
            <button
              className={`filter-btn ${styles.portfolioFilterBtn}`}
              data-filter=".outdoor"
            >
              Plagas en Exteriores
            </button>
          </div> */}

          {/* <!-- Galería con hover + overlay --> */}
          <div
            className={`mt-8 md:mt-16 lg:mt-24 portfolio-grid ${styles.portfolioGrid}`}
            id="portfolioGrid"
          >
            <div className={`portfolio-item home ${styles.portfolioItem}`}>
              <img src="/images/portfolio/ocho.webp" alt="Plaga en Hogar" />
              <div className={`portfolio-overlay ${styles.portfolioOverlay}`}>
                <div className="overlay-content">
                  <h4>Control de Plagas en Hogar</h4>
                  <p>
                    Soluciones efectivas y seguras para mantener tu hogar libre
                    de insectos y roedores.
                  </p>
                </div>
              </div>
            </div>

            <div
              className={`portfolio-item commercial ${styles.portfolioItem}`}
            >
              <img src="/images/portfolio/nueve.webp" alt="Plaga Comercial" />
              <div className={`portfolio-overlay ${styles.portfolioOverlay}`}>
                <div className="overlay-content">
                  <h4>Plagas en Negocios</h4>
                  <p>
                    Protección profesional para oficinas, restaurantes y locales
                    comerciales.
                  </p>
                </div>
              </div>
            </div>

            <div className={`portfolio-item termite ${styles.portfolioItem}`}>
              <img src="/images/portfolio/diez.webp" alt="Termitas" />
              <div className={`portfolio-overlay ${styles.portfolioOverlay}`}>
                <div className="overlay-content">
                  <h4>Control de Termitas</h4>
                  <p>
                    Eliminación total y prevención de daños estructurales por
                    termitas.
                  </p>
                </div>
              </div>
            </div>

            <div
              className={`portfolio-item commercial ${styles.portfolioItem}`}
            >
              <img src="/images/portfolio/uno.webp" alt="Oficina" />
              <div className={`portfolio-overlay ${styles.portfolioOverlay}`}>
                <div className="overlay-content">
                  <h4>Oficinas Libres de Plagas</h4>
                  <p>
                    Servicios discretos y efectivos para entornos corporativos.
                  </p>
                </div>
              </div>
            </div>

            <div className={`portfolio-item eco ${styles.portfolioItem}`}>
              <img src="/images/portfolio/dos.webp" alt="Eco-Friendly" />
              <div className={`portfolio-overlay ${styles.portfolioOverlay}`}>
                <div className="overlay-content">
                  <h4>Tratamiento Eco-Friendly</h4>
                  <p>
                    Métodos ecológicos seguros para niños, mascotas y el medio
                    ambiente.
                  </p>
                </div>
              </div>
            </div>

            <div className={`portfolio-item outdoor ${styles.portfolioItem}`}>
              <img src="/images/portfolio/tres.webp" alt="Exteriores" />
              <div className={`portfolio-overlay ${styles.portfolioOverlay}`}>
                <div className="overlay-content">
                  <h4>Control en Jardines y Exteriores</h4>
                  <p>
                    Disfruta tu patio sin mosquitos, hormigas ni plagas
                    molestas.
                  </p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* <!-- por que elegirnos --> */}
      <section className="why-choose flex justify-center mt-8 md:mt-16 lg:mt-24" id="why-choose">
        <div className="container w-full">
          {/* <!-- Tag y título --> */}
          <div className="section-header text-center">
            <span className={`section-tag ${styles.sectionTag}`}>
              ¿Por qué elegirnos?
            </span>
            <h2 className={`section-title ${styles.sectionTitle}`}>
              ¿Qué nos convierte en la mejor opción
              <span className="text-green">para usted?</span>
            </h2>
            <p className={`section-desc ${styles.sectionDescription}`}>
              Entendemos lo frustrantes y molestas que pueden ser las plagas,
              por eso nos comprometemos a brindar soluciones rápidas, confiables
              y efectivas..
            </p>
          </div>

          <div className={`why-grid ${styles.whyGrid}`}>
  {/* Tarjeta 1 - Servicios de emergencia */}
  <div className={`why-card ${styles.whyCard}`}>
    <div className={`why-icon ${styles.whyIcon}`}>
      <Clock className="h-10 w-10 text-white-600" strokeWidth={2} />
    </div>
    <h3 className='text-center'>Servicios de emergencia</h3>
    <p className='text-center'>Atención inmediata 24/7, incluso feriados.</p>
  </div>

  {/* Tarjeta 2 - Tratamientos personalizados */}
  <div className={`why-card ${styles.whyCard}`}>
    <div className={`why-icon ${styles.whyIcon}`}>
      <Settings className="h-10 w-10 text-white-600" strokeWidth={2} />
      {/* o también puedes usar: <Target /> o <Wrench /> */}
    </div>
    <h3 className='text-center'>Tratamientos personalizados</h3>
    <p className='text-center'>Soluciones adaptadas al tipo de plaga y propiedad.</p>
  </div>

  {/* Tarjeta 3 - Profesionales certificados */}
  <div className={`why-card ${styles.whyCard}`}>
    <div className={`why-icon ${styles.whyIcon}`}>
      <ShieldCheck className="h-10 w-10 text-white-600" strokeWidth={2} />
      {/* Alternativas bonitas: <Award />, <UserCheck />, <Certificate /> */}
    </div>
    <h3 className='text-center'>Profesionales certificados</h3>
    <p className='text-center'>Técnicos capacitados y con licencia oficial.</p>
  </div>

  {/* Tarjeta destacada con imagen */}
  <div className={`why-highlight-card ${styles.whyHighCard}`}>
    <img src="/images/choice/seis.webp" alt="Recupera tu hogar de plagas" />
    <div className={`highlight-content ${styles.whyHighContent}`}>
      <h3 className="text-2xl md:text-3xl font-bold mb-4">
        ¡Recupere su hogar de las plagas hoy mismo!
      </h3>
      <a href="https://wa.me/59176738282" target="_blank" className="highlight-btn inline-flex items-center gap-3 text-lg font-semibold">
        <Phone className="h-6 w-6" />
        Llame ahora +591 76738282
      </a>
    </div>
  </div>
</div>


          {/* <!-- CTA final --> */}
          <div className={`why-cta ${styles.whyCta}`}>
            <a href="mailto:info@bolivianpest.com" target="_blank" className="btn-free">
              ¡Creemos un ambiente libre de plagas! – ¡Contáctenos hoy!
            </a>
          </div>
        </div>
      </section>

      {/* <!-- frequently questions --> */}
      <section className="faq-section flex justify-center mt-10 md:mt-16 lg:mt-24 xl:mt-28" id="faq">
        <div className="container w-full">
          <div className={`faq-wrapper ${styles.faqWrapper}`}>
            {/* <!-- Imágenes decorativas izquierda --> */}
            <div className={`faqImages ${styles.faqImages}`}>
              <img
                src="/images/questions/doce.webp"
                alt="Técnico fumigando"
                className={`img-1 ${styles.faqImg1}`}
              />
              <img
                src="/images/questions/uno.webp"
                alt="Equipo profesional"
                className={`img-2 ${styles.faqImg2}`}
              />
              <img
                src="/images/questions/seis.webp"
                alt="Fumigación exterior"
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
    className="w-full"
    defaultValue="item-1"
>
    <AccordionItem value="item-1">
      <AccordionTrigger className="text-lg text-cyan-500 hover:text-cyan-700 no-underline hover:no-underline">
          1. ¿Qué tipos de plagas tratan? 
      </AccordionTrigger>
      <AccordionContent className="flex flex-col  text-left">
        <p>Controlamos una amplia variedad de plagas, incluyendo</p>
          <p><strong> roedores, hormigas, cucarachas, termitas, chinches, mosquitos, arañas y fauna silvestre.</strong></p>
          <p>Aplicamos métodos específicos según la especie para garantizar resultados efectivos.
        </p>
      </AccordionContent>
    </AccordionItem>
    <AccordionItem value="item-2">
      <AccordionTrigger className="text-lg text-cyan-500 hover:text-cyan-700 no-underline hover:no-underline">
          2. ¿Son seguros sus métodos de control de plagas para mis mascotas? 
      </AccordionTrigger>
      <AccordionContent className="flex flex-col  text-left">
        <p> Sí. Todos nuestros productos y procedimientos están certificados y son seguros para mascotas y personas, siempre y cuando se sigan las indicaciones del técnico. Utilizamos productos de baja toxicidad, aprobados por <strong>SENASAG</strong>, y aplicados bajo estándares profesionales para evitar cualquier riesgo. Además, brindamos instrucciones claras sobre el tiempo de reingreso y cuidados posteriores para garantizar la seguridad de tus animales domésticos.
        </p>
      </AccordionContent>
    </AccordionItem>
    <AccordionItem value="item-3">
      <AccordionTrigger className="text-lg text-cyan-500 hover:text-cyan-700 no-underline hover:no-underline">
          3. ¿Con qué frecuencia debo programar los servicios de control de plagas? 
      </AccordionTrigger>
      <AccordionContent className="flex flex-col text-left">
        <p>
    La frecuencia depende del tipo de plaga y del entorno:
  </p>

  <ul>
    <li>
      <strong>Hogares:</strong> cada 3 a 4 meses suele ser suficiente para mantener un ambiente libre de plagas.
    </li>
    <li>
      <strong>Comercios:</strong> recomendamos un servicio mensual o bimensual, especialmente si hay almacenamiento de alimentos.
    </li>
    <li>
      <strong>Industrias y restaurantes:</strong> servicios mensuales o incluso quincenales, de acuerdo con normas de salubridad.
    </li>
  </ul>
  
  <p>
    Nuestros técnicos evalúan tu caso y generan un plan personalizado según el nivel de infestación y las características del lugar.
  </p>
      </AccordionContent>
    </AccordionItem>
    <AccordionItem value="item-4">
      <AccordionTrigger className="text-lg text-cyan-500 hover:text-cyan-700 no-underline hover:no-underline">
          4. ¿Ofrecen servicios de control de plagas de emergencia? 
      </AccordionTrigger>
      <AccordionContent className="flex flex-col text-left">
        <p>Sí, contamos con servicios de emergencia para infestaciones severas o situaciones que requieren atención inmediata, como: </p>
        <br />
        <ul>
            <li><strong>Nidos de avispas</strong> </li>
            <li><strong>Presencia elevada de roedores</strong> </li>
            <li><strong>Brotes de cucarachas en cocinas o negocios</strong> </li>
            <li><strong>Invasión de chinches</strong> </li>
            <li><strong>Plagas que afecten la operación de tu empresa</strong> </li>
        </ul>
            <p>Atendemos en el menor tiempo posible para controlar rápidamente el problema y evitar riesgos para tu salud o tu actividad comercial.
        </p>
      </AccordionContent>
    </AccordionItem>
    <AccordionItem value="item-5">
      <AccordionTrigger className="text-lg text-cyan-500 hover:text-cyan-700 no-underline hover:no-underline">
          5. ¿Cómo sé si tengo una plaga? 
      </AccordionTrigger>
      <AccordionContent className="flex flex-col text-left">
        <p>Algunas señales comunes incluyen: </p>
          <ul>      
          <li><strong>Excrementos pequeños o manchas oscuras (roedores, cucarachas).</strong></li> 

          <li><strong>Ruidos dentro de paredes o techos.</strong></li> 

          <li><strong>Olores fuertes o desagradables, especialmente en cocinas o depósitos.</strong></li> 

          <li><strong>Huecos o montículos en madera o suelo (termitas). </strong></li>
          </ul>      
          <p>Si notas cualquiera de estos signos, lo ideal es solicitar una inspección profesional, ya que muchas plagas se esconden y solo un técnico puede detectarlas a tiempo.
        </p>
      </AccordionContent>
    </AccordionItem>
</Accordion>

            </div>
          </div>
        </div>
      </section>
      {/* <!-- CTA --> */}
      <section className={`mt-2 md:mt-6 lg:mt-10 about-your ${styles.ctaSection}`} id="contacto">
        <div className="container w-full">
          <div className={`about-your-wrapper ${styles.ctaWrapper}`}>
            {/* <!-- Imagen del técnico (izquierda) --> */}
            <div className={`about-your-image ${styles.ctaImage}`}>
              <img
                src="/images/cta/personaje.webp"
                alt="Técnico profesional listo para ayudarte"
              />
            </div>

            {/* <!-- Contenido (derecha) --> */}
            <div className={`about-your-content ${styles.ctaContent}`}>
              <h2 className={`section-title mb-5 ${styles.sectionTitle}`}>
                Hablemos de sus necesidades de
                <span className="text-green"> control de plagas</span>
              </h2>

              <ul className={`about-your-list ${styles.ctaList}`}>
                
                <li className="flex items-center gap-4 group">
                <CheckCircle2 className="h-9 w-9 shrink-0 text-emerald-500 transition-transform group-hover:scale-110" />
                <span className="transition-colors group-hover:text-emerald-600">Agende su inspección gratuita</span>
              </li>
                <li className="flex items-center gap-4 group">
                <CheckCircle2 className="h-9 w-9 shrink-0 text-emerald-500 transition-transform group-hover:scale-110" />
                <span className="transition-colors group-hover:text-emerald-600">Prevenga futuras infestaciones</span>
              </li>
              <li className="flex items-center gap-4 group">
                <CheckCircle2 className="h-9 w-9 shrink-0 text-emerald-500 transition-transform group-hover:scale-110" />
                <span className="transition-colors group-hover:text-emerald-600">Reserva fácil y rápida</span>
              </li>
                {/* <li>
                  <span className={`list-icon ${styles.ctaListIcon}`}>
                    Check
                  </span>
                  Reserva fácil y rápida
                </li> */}
              </ul>

              <a
                href="https://wa.me/59176738282"
                target="_blank"
                className={`btn-membership ${styles.ctaBtnMember}`}
              >
                Empieza Ahora
                <span className={`arrow-circle ${styles.ctaArrowCircle}`}>
                  <CheckCircle2 className="h-9 w-9 shrink-0 text-white-500 transition-transform group-hover:scale-110" />
                </span>
              </a>
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
              </ul>
            </div>
            

<div className={`footer-column contact ${styles.footerColumn}`}>
  <h3 className="text-xl font-bold mb-6">Contáctanos</h3>

  <div className="space-y-4">
    {/* Teléfono */}
    <div className={`contact-item flex items-center gap-4 ${styles.footerContactItem}`}>
      <div className="flex h-10 w-10 shrink-0 items-center justify-center rounded-full bg-cyan-600 text-white">
        <Phone className="h-5 w-5" strokeWidth={2.5} />
      </div>
      <div>
        <p className="text-sm text-gray-400">Teléfono / WhatsApp</p>
        <a href="https://wa.me/59176738282" className="text-white hover:text-white-400 transition">
          +591 76738282
        </a>
      </div>
    </div>

    {/* Email */}
    <div className={`contact-item flex items-center gap-4 ${styles.footerContactItem}`}>
      <div className="flex h-10 w-10 shrink-0 items-center justify-center rounded-full bg-cyan-600 text-white">
        <Mail className="h-5 w-5" strokeWidth={2.5} />
      </div>
      <div>
        <p className="text-sm text-gray-400">Correo electrónico</p>
        <a href="mailto:info@bolivianpest.com" className="text-white hover:text-white-400 transition">
          info@bolivianpest.com
        </a>
      </div>
    </div>
  </div>
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
                Bolivian Pest
              </span>
            </div>

            {/* <div className={`social-links ${styles.footerSocialLinks}`}>
              <a href="#" aria-label="Instagram">
                <i className="fab fa-instagram"></i>
              </a>
              <a href="#" aria-label="Facebook">
                <i className="fab fa-facebook-f"></i>
              </a>
              <a href="#" aria-label="Twitter">
                <i className="fab fa-tiktok"></i>
              </a>
            </div> */}
            <div className={`social-links ${styles.footerSocialLinks}`}>
  <a
    href="https://instagram.com/tuempresa"
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

  {/* <a
    href="https://tiktok.com/@tuempresa"
    target="_blank"
    rel="noopener noreferrer"
    aria-label="TikTok"
    className="group"
  >
    <TikTok className="h-6 w-6 transition-all group-hover:scale-110 group-hover:text-white" />
  </a>

  {/* Bonus muy usado en Bolivia: WhatsApp directo */}
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
              Copyright Bitdesarrollo © 2025 All Rights Reserved.
            </div>
          </div>
        </div>
      </footer>
    </>
  );
}
