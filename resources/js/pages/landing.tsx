import Navbar from '@/components/landing/Navbar';
import { Head } from '@inertiajs/react';
import { Autoplay, EffectFade, Navigation, Pagination } from 'swiper/modules';
import { Swiper, SwiperSlide } from 'swiper/react';
import styles from './landing.module.css';

import { Check, Play } from 'lucide-react';
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
              src="/images/slider/slider1.webp"
              className="h-full w-full object-cover"
              alt="Slide 2"
            />
          </SwiperSlide>
          <SwiperSlide>
            <img
              src="/images/slider/slider1.webp"
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
      <section className="services" id="services">
        <div className="container">
          {/* <!-- Tag y título --> */}
          <div className="section-header">
            <span className="section-tag">Servicios</span>
            <h2>
              Soluciones expertas para cualquier
              <span className="text-green">problema de plagas</span>
            </h2>
          </div>

          {/* <!-- Slider de Servicios --> */}
          <div className="swiper services-slider">
            <div className="swiper-wrapper">
              {/* <!-- Tarjeta 1 --> */}
              <div className="swiper-slide">
                <div className="service-card">
                  <div className="service-img">
                    <img src="uno.png" alt="Commercial" />
                  </div>
                  <div className="service-icon">
                    <i className="fas fa-building"></i>
                  </div>
                  <h3>Soluciones comerciales para el control de plagas</h3>
                  <p>
                    Soluciones personalizadas para proteger su hogar de las
                    plagas comunes
                  </p>
                  <a href="#" className="read-more">
                    Read More →
                  </a>
                </div>
              </div>

              {/* <!-- Tarjeta 2 --> */}
              <div className="swiper-slide">
                <div className="service-card">
                  <div className="service-img">
                    <img src="dos.png" alt="Termite" />
                  </div>
                  <div className="service-icon">
                    <i className="fas fa-bug"></i>
                  </div>
                  <h3>Control de termitas y roedores</h3>
                  <p>
                    Soluciones personalizadas para proteger su hogar de las
                    plagas comunes
                  </p>
                  <a href="#" className="read-more">
                    Read More →
                  </a>
                </div>
              </div>

              {/* <!-- Tarjeta 3 --> */}
              <div className="swiper-slide">
                <div className="service-card">
                  <div className="service-img">
                    <img src="tres.png" alt="Outdoor" />
                  </div>
                  <div className="service-icon">
                    <i className="fas fa-leaf"></i>
                  </div>
                  <h3>Control de plagas en exteriores</h3>
                  <p>
                    Soluciones personalizadas para proteger su hogar de las
                    plagas comunes
                  </p>
                  <a href="#" className="read-more">
                    Read More →
                  </a>
                </div>
              </div>

              {/* <!-- Tarjeta 4 --> */}
              <div className="swiper-slide">
                <div className="service-card">
                  <div className="service-img">
                    <img src="cuatro.png" alt="Smart Home" />
                  </div>
                  <div className="service-icon">
                    <i className="fas fa-home"></i>
                  </div>
                  <h3>Integración de hogares inteligentes</h3>
                  <p>
                    Soluciones personalizadas para proteger su hogar de las
                    plagas comunes
                  </p>
                  <a href="#" className="read-more">
                    Read More →
                  </a>
                </div>
              </div>

              {/* <!-- Tarjeta 5 --> */}
              <div className="swiper-slide">
                <div className="service-card">
                  <div className="service-img">
                    <img src="cinco.png" alt="Smart Home" />
                  </div>
                  <div className="service-icon">
                    <i className="fas fa-home"></i>
                  </div>
                  <h3>Control de plagas residenciales</h3>
                  <p>
                    Soluciones personalizadas para proteger su hogar de las
                    plagas comunes
                  </p>
                  <a href="#" className="read-more">
                    Read More →
                  </a>
                </div>
              </div>

              {/* <!-- Puedes agregar más tarjetas si quieres --> */}
            </div>

            {/* <!-- Dots (paginación) --> */}
            <div className="swiper-pagination"></div>

            {/* <!-- Flechas opcionales (puedes quitar si no las quieres) --> */}
            <div className="swiper-button-next"></div>
            <div className="swiper-button-prev"></div>
          </div>

          {/* <!-- Texto final --> */}
          <div className="services-cta">
            <p>
              ¿Listo para un hogar libre de plagas?
              <a href="#contact" className="cta-link">
                ¡Contáctenos hoy!
              </a>
            </p>
          </div>
        </div>
      </section>
    </>
  );
}
