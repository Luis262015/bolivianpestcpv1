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

import { BugOff, Check, Play } from 'lucide-react';
import 'swiper/css';
import 'swiper/css/autoplay';
import 'swiper/css/effect-fade';
import 'swiper/css/navigation';
import 'swiper/css/pagination';

export default function Landing() {
  return (
    <>
      {/* pestaña de navegador */}
      <Head title="Inicio">
        <link rel="preconnect" href="https://fonts.bunny.net" />
        <link
          href="https://fonts.bunny.net/css?family=inter:200,300,300i,400,400i,500,500i,600,600i,700,800,900"
          rel="stylesheet"
        />
      </Head>

      <Navbar logo="/images/LogoHFCWhite.png" />

      <div className="relative h-[500px] w-full md:h-[800px]">
        <Swiper
          spaceBetween={30}
          effect={'fade'}
          // navigation={true}
          // pagination={{
          //   clickable: true,
          // }}
          loop={true}
          autoplay={{ delay: 9000, disableOnInteraction: false }}
          modules={[Autoplay, EffectFade, Navigation, Pagination]}
          className="mySwiper h-[800px]"
        >
          <SwiperSlide>
            <img
              src="/images/slider/slider1.webp"
              className="h-full w-full object-cover"
              alt="Slide 1"
            />
          </SwiperSlide>
          <SwiperSlide>
            <img
              src="/images/slider/hero-bg.webp"
              className="h-full w-full object-cover"
              alt="Slide 2"
            />
          </SwiperSlide>
          <SwiperSlide>
            <img
              src="/images/slider/hero-bg-2.webp"
              className="h-full w-full object-cover"
              alt="Slide 3"
            />
          </SwiperSlide>
        </Swiper>
        <div className="absolute inset-0 z-3 flex justify-center">
          <div className="flex h-full w-[1300px] items-center justify-center">
            <img src="/images/cta/personaje.webp" alt="Logo" className="" />
            <div>
              <h1 className="mb-2 text-left text-[2.2rem] font-bold text-white text-shadow-lg/40">
                Servicios confiables de control de plagas e insectos en los que
                puede confiar.
              </h1>
              <p className="mb-2 text-left text-[1.3rem] text-white text-shadow-lg/40">
                Proteja su hogar y negocio con nuestras soluciones efectivas
                para el control de plagas. Desde termitas hasta roedores,
                eliminamos las plagas de forma rápida y segura.
              </p>
            </div>
          </div>
        </div>
      </div>
      {/* <Swiper
        spaceBetween={30}
        effect={'fade'}
        navigation={true}
        pagination={{
          clickable: true,
        }}
        loop={true}
        autoplay={{ delay: 9000, disableOnInteraction: false }}
        modules={[Autoplay, EffectFade, Navigation, Pagination]}
        className="mySwiper"
      >
        <SwiperSlide>
          <img src="/images/slider/slider1.webp" alt="Slide 1" />
        </SwiperSlide>
        <SwiperSlide>
          <img src="/images/slider/slider1.webp" alt="Slide 2" />
        </SwiperSlide>
        <SwiperSlide>
          <img src="/images/slider/slider1.webp" alt="Slide 3" />
        </SwiperSlide>
      </Swiper> */}

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
              <a href="#" className="read-more">
                Leer más <span>→</span>
              </a>
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
              <a href="#" className="read-more">
                Leer más <span>→</span>
              </a>
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
              <a href="#" className="read-more">
                Leer más <span>→</span>
              </a>
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
              <a href="#" className="read-more">
                Leer más <span>→</span>
              </a>
            </div>
          </div>
        </div>
      </section>

      {/* <!-- about us --> */}
      <section className="about-us flex justify-center" id="about">
        <div className="container w-[1300px]">
          <div className="about-wrapper grid grid-cols-2 items-center gap-[10px]">
            {/* <!-- Columna Izquierda - Imagen Principal + Círculos de Insectos --> */}
            <div className="about-image relative h-[600px]">
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
            <div className="about-content">
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
      <section className="services flex justify-center" id="services">
        <div className="container w-[1300px]">
          {/* <!-- Tag y título --> */}
          <div className="section-header text-center">
            <span className={`section-tag ${styles.sectionTag}`}>
              Servicios
            </span>
            <h2 className={`section-title ${styles.sectionTitle}`}>
              Soluciones expertas para cualquier
              <span className="text-green">problema de plagas</span>
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
            className="mySwiper"
            slidesPerView={3}
            spaceBetween={30}
            loop={true}
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
        className={`our-features flex justify-center ${styles.ourFeatures}`}
        id="our-features"
      >
        <div className="container w-[1300px]">
          <div className="features-wrapper grid grid-cols-2 items-center gap-[80px]">
            {/* <!-- Columna Izquierda - Texto + Características --> */}
            <div className="features-content">
              <span className={`section-tag ${styles.sectionTag}`}>
                Nuestros servicios
              </span>
              <h2 className={`section-title ${styles.sectionTitle}`}>
                Su socio de confianza en
                <span className="text-green">control de plagas</span>
              </h2>

              <p className={`features-text ${styles.featuresText}`}>
                Entendemos lo frustrantes y molestas que pueden ser las plagas,
                por eso nos comprometemos a brindar soluciones rápidas,
                confiables y efectivas. Contamos con un equipo de expertos
                certificados, métodos ecológicos y una atención al cliente
                inigualable.
              </p>

              <div className={`features-grid ${styles.featuresGrid}`}>
                {/* <!-- Feature 1 --> */}
                <div className={`features-item ${styles.featuresItem}`}>
                  <div className={`features-icon ${styles.featuresIcon}`}>
                    <i className="fas fa-clock"></i>
                  </div>
                  <div className={`features-text ${styles.featuresText}`}>
                    <h4>Servicios de emergencia</h4>
                    <p>
                      Estamos disponibles las 24 horas para atender su
                      emergencia.
                    </p>
                  </div>
                </div>

                {/* <!-- Feature 2 --> */}
                <div className={`features-item ${styles.featuresItem}`}>
                  <div className={`features-icon ${styles.featuresIcon}`}>
                    <i className="fas fa-cogs"></i>
                  </div>
                  <div className={`features-text ${styles.featuresText}`}>
                    <h4>Tratamientos personalizados</h4>
                    <p>
                      Cada propiedad es única, por lo que ofrecemos tratamientos
                      personalizados contra plagas.
                    </p>
                  </div>
                </div>

                {/* <!-- Feature 3 --> */}
                <div className={`features-item ${styles.featuresItem}`}>
                  <div className={`features-icon ${styles.featuresIcon}`}>
                    <i className="fas fa-user-shield"></i>
                  </div>
                  <div className={`features-text ${styles.featuresText}`}>
                    <h4>Profesionales certificados</h4>
                    <p>
                      Nuestro equipo está altamente capacitado, certificado y
                      cuenta con amplia experiencia.
                    </p>
                  </div>
                </div>

                {/* <!-- Feature 4 --> */}
                <div className={`features-item ${styles.featuresItem}`}>
                  <div className={`features-icon ${styles.featuresIcon}`}>
                    <i className="fas fa-check-circle"></i>
                  </div>
                  <div className={`features-text ${styles.featuresText}`}>
                    <h4>Resultados garantizados</h4>
                    <p>
                      Respaldamos nuestro servicio con una garantia de
                      satisfaccion
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
                href="#contact"
                className={`features-btn ${styles.featuresBtn}`}
              >
                <i className="fas fa-phone"></i>
                <span>Contact Us</span>
              </a>
            </div>
          </div>
        </div>
      </section>

      {/* <!-- our portafolio  --> */}
      <section className="our-portfolio flex justify-center" id="our-portfolio">
        <div className="container w-[1300px]">
          {/* <!-- Tag y título --> */}
          <div className="section-header text-center">
            <span className={`section-tag ${styles.sectionTag}`}>
              Portafolio
            </span>
            <h2 className={`section-title ${styles.sectionTitle}`}>
              Descubra nuestra trayectoria comprobada en
              <span className="text-green">
                soluciones para eliminar plagas
              </span>
            </h2>
          </div>

          {/* <!-- Filtros --> */}
          <div className={`portfolio-filters ${styles.portfolioFilters}`}>
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
          </div>

          {/* <!-- Galería con hover + overlay --> */}
          <div
            className={`portfolio-grid ${styles.portfolioGrid}`}
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
      <section className="why-choose flex justify-center" id="why-choose">
        <div className="container w-[1300px]">
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
            {/* <!-- Tarjeta 1 --> */}
            <div className={`why-card ${styles.whyCard}`}>
              <div className={`why-icon ${styles.whyIcon}`}>
                <i className="fas fa-clock"></i>
              </div>
              <h3>Servicios de emergencia</h3>
              <p>Disponibles las 24 horas.</p>
            </div>

            {/* <!-- Tarjeta 2 --> */}
            <div className={`why-card ${styles.whyCard}`}>
              <div className={`why-icon ${styles.whyIcon}`}>
                <i className="fas fa-cogs"></i>
              </div>
              <h3>Tratamientos personalizados</h3>
              <p>Disponibles las 24 horas.</p>
            </div>

            {/* <!-- Tarjeta 3 --> */}
            <div className={`why-card ${styles.whyCard}`}>
              <div className={`why-icon ${styles.whyIcon}`}>
                <i className="fas fa-user-shield"></i>
              </div>
              <h3>Profesionales certificados</h3>
              <p>Disponibles las 24 horas.</p>
            </div>

            {/* <!-- Tarjeta destacada con imagen --> */}
            <div className={`why-highlight-card ${styles.whyHighCard}`}>
              <img src="/images/choice/seis.webp" alt="Take Back Your Home" />
              <div className={`highlight-content ${styles.whyHighContent}`}>
                <h3>¡Recupere su hogar de las plagas hoy mismo!</h3>
                <a href="tel:+1322782968" className="highlight-btn">
                  <i className="fas fa-phone"></i> Llame ahora +591 74392912
                </a>
              </div>
            </div>
          </div>

          {/* <!-- CTA final --> */}
          <div className={`why-cta ${styles.whyCta}`}>
            <a href="#contact" className="btn-free">
              ¡Creemos un ambiente libre de plagas! – ¡Contáctenos hoy!
            </a>
          </div>
        </div>
      </section>

      {/* <!-- frequently questions --> */}
      <section className="faq-section flex justify-center" id="faq">
        <div className="container w-[1300px]">
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
                  <AccordionTrigger>Product Information</AccordionTrigger>
                  <AccordionContent className="flex flex-col gap-4 text-balance">
                    <p>
                      Our flagship product combines cutting-edge technology with
                      sleek design. Built with premium materials, it offers
                      unparalleled performance and reliability.
                    </p>
                    <p>
                      Key features include advanced processing capabilities, and
                      an intuitive user interface designed for both beginners
                      and experts.
                    </p>
                  </AccordionContent>
                </AccordionItem>
                <AccordionItem value="item-2">
                  <AccordionTrigger>Shipping Details</AccordionTrigger>
                  <AccordionContent className="flex flex-col gap-4 text-balance">
                    <p>
                      We offer worldwide shipping through trusted courier
                      partners. Standard delivery takes 3-5 business days, while
                      express shipping ensures delivery within 1-2 business
                      days.
                    </p>
                    <p>
                      All orders are carefully packaged and fully insured. Track
                      your shipment in real-time through our dedicated tracking
                      portal.
                    </p>
                  </AccordionContent>
                </AccordionItem>
                <AccordionItem value="item-3">
                  <AccordionTrigger>Return Policy</AccordionTrigger>
                  <AccordionContent className="flex flex-col gap-4 text-balance">
                    <p>
                      We stand behind our products with a comprehensive 30-day
                      return policy. If you&apos;re not completely satisfied,
                      simply return the item in its original condition.
                    </p>
                    <p>
                      Our hassle-free return process includes free return
                      shipping and full refunds processed within 48 hours of
                      receiving the returned item.
                    </p>
                  </AccordionContent>
                </AccordionItem>
              </Accordion>
            </div>
          </div>
        </div>
      </section>
      {/* <!-- CTA --> */}
      <section className={`about-your ${styles.ctaSection}`} id="about-your">
        <div className="container w-[1300px]">
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
                <span className="text-green">control de plagas</span>
              </h2>

              <ul className={`about-your-list ${styles.ctaList}`}>
                <li>
                  <span className={`list-icon ${styles.ctaListIcon}`}>
                    Check
                  </span>
                  Agende su inspección gratuita
                </li>
                <li>
                  <span className={`list-icon ${styles.ctaListIcon}`}>
                    Check
                  </span>
                  Prevenga futuras infestaciones
                </li>
                <li>
                  <span className={`list-icon ${styles.ctaListIcon}`}>
                    Check
                  </span>
                  Reserva fácil y rápida
                </li>
              </ul>

              <a
                href="#contact"
                className={`btn-membership ${styles.ctaBtnMember}`}
              >
                Empieza Ahora
                <span className={`arrow-circle ${styles.ctaArrowCircle}`}>
                  Check
                </span>
              </a>
            </div>
          </div>
        </div>
      </section>

      {/* <!-- Footer --> */}
      <footer className={`footer flex justify-center ${styles.footer}`}>
        <div className="container w-[1300px]">
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
                  <a href="#">Contáctanos</a>
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

            {/* <!-- Columna 4: Contact Us --> */}
            <div className={`footer-column contact ${styles.footerColumn}`}>
              <h3>Contáctanos</h3>
              <div className={`contact-item ${styles.footerContactItem}`}>
                <span className="contact-icon">Phone</span>
                <a href="tel:+19123456789">+591 32221344</a>
              </div>
              <div className={`contact-item ${styles.footerContactItem}`}>
                <span className="contact-icon phone">Email</span>
                <a href="mailto:info@domainname.com">info@BolivianPest.com</a>
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
                  stroke="#00b894"
                  stroke-width="6"
                />
                <path
                  d="M30 50L45 65L70 35"
                  stroke="#00b894"
                  stroke-width="8"
                  stroke-linecap="round"
                />
              </svg>
              <span className={`logo-text ${styles.footerLogoText}`}>
                Bolivian Pest
              </span>
            </div>

            <div className={`social-links ${styles.footerSocialLinks}`}>
              <a href="#" aria-label="Instagram">
                <i className="fab fa-instagram"></i>
              </a>
              <a href="#" aria-label="Facebook">
                <i className="fab fa-facebook-f"></i>
              </a>
              <a href="#" aria-label="Twitter">
                <i className="fab fa-tiktok"></i>
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
