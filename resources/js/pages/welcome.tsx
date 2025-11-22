import { type SharedData } from '@/types';
import { Head, usePage } from '@inertiajs/react';
import { Swiper, SwiperSlide } from 'swiper/react';
import styles from './welcome.module.css';

import { Autoplay, Navigation, Pagination } from 'swiper/modules';

import { ChevronLeftIcon, ChevronRightIcon } from 'lucide-react';
import 'swiper/css';
import 'swiper/css/autoplay';
import 'swiper/css/effect-fade';
import 'swiper/css/navigation';
import 'swiper/css/pagination';

export default function Welcome({
  canRegister = true,
}: {
  canRegister?: boolean;
}) {
  const { auth } = usePage<SharedData>().props;

  return (
    <>
      {/* pestaña de navegador */}
      <Head title="Inicio">
        <link rel="preconnect" href="https://fonts.bunny.net" />
        {/* <link
                    href="https://fonts.bunny.net/css?family=instrument-sans:400,500,600"
                    rel="stylesheet"
                /> */}
        <link
          href="https://fonts.bunny.net/css?family=inter:200,300,300i,400,400i,500,500i,600,600i,700,800,900"
          rel="stylesheet"
        />
      </Head>

      <header>
        <div className={styles.navContainer}>
          <div className={styles.logo}>
            <img src="/images/LogoHFCWhite.png" alt="" />
          </div>
          <nav>
            <ul>
              <li>
                <a href="#">Inicio</a>
              </li>
              <li>
                <a href="#">Acerca de Nosotros</a>
              </li>
              <li>
                <a href="#">Servicios</a>
              </li>
              <li>
                <a href="#">Caracteristicas</a>
              </li>
              <li>
                <a href="#">Portafolio</a>
              </li>
              <li>
                <a href="#">Porque elegirnos</a>
              </li>
              <li>
                <a href="#">Testimonios</a>
              </li>
            </ul>
          </nav>
          <a href="tel:+1 323-782-568" className={styles.btn}>
            Probar Ahora
          </a>
        </div>
      </header>

      <Swiper
        pagination={{
          type: 'fraction',
        }}
        navigation={true}
        loop={true}
        autoplay={{ delay: 9000, disableOnInteraction: false }}
        modules={[Autoplay, Pagination, Navigation]}
        className="mySwiper"
      >
        <SwiperSlide>
          <img src="/images/slider/slider1.webp" alt="Slide 1" />
          <div className={styles.heroContent}>
            <h1>
              Servicios confiables de control de plagas e insectos en los que
              puede confiar.
            </h1>
            <p>
              Proteja su hogar y negocio con nuestras soluciones efectivas para
              el control de plagas. Desde termitas hasta roedores, eliminamos
              las plagas de forma rápida y segura.
            </p>
            <div>
              <a
                href="#"
                className={styles.btn}
                // style="margin-right: 15px"
              >
                reservar un servicio
              </a>
              <a
                href="#"
                className={styles.btn}
                // style="background: transparent;border: 2px solid white;"
              >
                Ver todos los servicios
              </a>
            </div>
          </div>
        </SwiperSlide>
        <SwiperSlide>
          <img src="/images/slider/slider1.webp" alt="Slide 2" />
          <div className={styles.heroContent}>
            <h1>
              Servicios confiables de control de plagas e insectos en los que
              puede confiar.
            </h1>
            <p>
              Proteja su hogar y negocio con nuestras soluciones efectivas para
              el control de plagas. Desde termitas hasta roedores, eliminamos
              las plagas de forma rápida y segura.
            </p>
            <div>
              <a
                href="#"
                className={styles.btn}
                // style="margin-right: 15px"
              >
                reservar un servicio
              </a>
              <a
                href="#"
                className={styles.btn}
                // style="background: transparent;border: 2px solid white;"
              >
                Ver todos los servicios
              </a>
            </div>
          </div>
        </SwiperSlide>
        <SwiperSlide>
          <img src="/images/slider/slider1.webp" alt="Slide 3" />
          <div className={styles.heroContent}>
            <h1>
              Servicios confiables de control de plagas e insectos en los que
              puede confiar.
            </h1>
            <p>
              Proteja su hogar y negocio con nuestras soluciones efectivas para
              el control de plagas. Desde termitas hasta roedores, eliminamos
              las plagas de forma rápida y segura.
            </p>
            <div>
              <a
                href="#"
                className={styles.btn}
                // style="margin-right: 15px"
              >
                reservar un servicio
              </a>
              <a
                href="#"
                className={styles.btn}
                // style="background: transparent;border: 2px solid white;"
              >
                Ver todos los servicios
              </a>
            </div>
          </div>
        </SwiperSlide>
      </Swiper>

      {/* <section className={styles.hero}>
                <div className={styles.slider}>
                    <div className={styles.slides}>
                        <div className={styles.slide}>
                            <img
                                src="/images/slider/slider1.webp"
                                alt="Slide 1"
                            />
                            <div className={styles.heroContent}>
                                <h1>
                                    Servicios confiables de control de plagas e
                                    insectos en los que puede confiar.
                                </h1>
                                <p>
                                    Proteja su hogar y negocio con nuestras
                                    soluciones efectivas para el control de
                                    plagas. Desde termitas hasta roedores,
                                    eliminamos las plagas de forma rápida y
                                    segura.
                                </p>
                                <div>
                                    <a
                                        href="#"
                                        className={styles.btn}
                                        // style="margin-right: 15px"
                                    >
                                        reservar un servicio
                                    </a>
                                    <a
                                        href="#"
                                        className={styles.btn}
                                        // style="background: transparent;border: 2px solid white;"
                                    >
                                        Ver todos los servicios
                                    </a>
                                </div>
                            </div>
                        </div>

                        <div className={styles.slide}>
                            <img
                                src="/images/slider/slider1.jpg"
                                alt="Slide 2"
                            />
                            <div className={styles.heroContent}>
                                <h1>
                                    Servicios confiables de control de plagas e
                                    insectos en los que puede confiar.
                                </h1>
                                <p>
                                    Proteja su hogar y negocio con nuestras
                                    soluciones efectivas para el control de
                                    plagas. Desde termitas hasta roedores,
                                    eliminamos las plagas de forma rápida y
                                    segura.
                                </p>
                                <div>
                                    <a
                                        href="#"
                                        className={styles.btn}
                                        // style="margin-right: 15px"
                                    >
                                        reservar un servicio
                                    </a>
                                    <a
                                        href="#"
                                        className={styles.btn}
                                        // style="background: transparent;border: 2px solid white;"
                                    >
                                        Ver todos los servicios
                                    </a>
                                </div>
                            </div>
                        </div>

                        <div className={styles.slide}>
                            <img
                                src="/images/slider/slider1.jpg"
                                alt="Slide 3"
                            />
                            <div className={styles.heroContent}>
                                <h1>
                                    Servicios confiables de control de plagas e
                                    insectos en los que puede confiar.
                                </h1>
                                <p>
                                    Proteja su hogar y negocio con nuestras
                                    soluciones efectivas para el control de
                                    plagas. Desde termitas hasta roedores,
                                    eliminamos las plagas de forma rápida y
                                    segura.
                                </p>
                                <div>
                                    <a
                                        href="#"
                                        className={styles.btn}
                                        // style="margin-right: 15px"
                                    >
                                        reservar un servicio
                                    </a>
                                    <a
                                        href="#"
                                        className={styles.btn}
                                        // style="background: transparent;border: 2px solid white;"
                                    >
                                        Ver todos los servicios
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section> */}

      {/* <!-- Features --> */}
      <section className={styles.features}>
        <div className={styles.featureBox}>
          <div className={styles.iconCircle}>
            <img src="/images/icons/coberturab.svg" alt="Icon 1" />
          </div>
          <h3>
            Cobertura <br />
            Integral
          </h3>
          <a href="#" className={styles.readMore}>
            Leer más <span>→</span>
          </a>
        </div>

        <div className={styles.featureBox}>
          <div className={styles.iconCircle}>
            <img src="/images/icons/tiempob.svg" alt="Icon 2" />
          </div>
          <h3>
            Tiempos de <br />
            Resouesta rapidos
          </h3>
          <a href="#" className={styles.readMore}>
            Leer más <span>→</span>
          </a>
        </div>

        <div className={styles.featureBox}>
          <div className={styles.iconCircle}>
            <img src="/images/icons/serviciob.svg" alt="Icon 3" />
          </div>
          <h3>
            Servicios <br />
            Comerciales
          </h3>
          <a href="#" className={styles.readMore}>
            Leer más <span>→</span>
          </a>
        </div>

        <div className={styles.featureBox}>
          <div className={styles.iconCircle}>
            <img src="/images/icons/emergenciab.svg" alt="Icon 4" />
          </div>
          <h3>
            Servicio de <br />
            Emergencia 24/7
          </h3>
          <a href="#" className={styles.readMore}>
            Leer más <span>→</span>
          </a>
        </div>
      </section>

      {/* <!-- about us --> */}
      <section className={styles.aboutUs} id="about">
        <div className={styles.container}>
          <div className={styles.aboutWrapper}>
            {/* <!-- Columna Izquierda - Imagen Principal + Círculos de Insectos --> */}
            <div className={styles.aboutImage}>
              <div className={styles.mainCircle}>
                <img src="/images/about/cuatro.webp" alt="Técnico fumigando" />
              </div>

              {/* <!-- Círculos flotantes de insectos --> */}
              <div className={styles.floatingBug}>
                <img src="/images/about/dos.webp" alt="Mosquito" />
              </div>
              <div className={styles.floatingBug}>
                <img src="/images/about/uno.webp" alt="Escarabajo" />
              </div>
              <div className={styles.floatingBug}>
                <img src="/images/about/siete.webp" alt="Cucaracha" />
              </div>
            </div>

            {/* <!-- Columna Derecha - Texto y Estadísticas --> */}
            <div className={styles.aboutContent}>
              <span className={styles.sectionTag}>Acerca de Nosotros</span>
              <h2>
                Protegiendo hogares,
                <span className={styles.textGreen}>negocios y comunidades</span>
              </h2>

              <p className={styles.aboutText}>
                Nuestra misión es simple: brindar servicios confiables de
                control de plagas que garanticen un ambiente limpio, seguro y
                confortable para todos. Con años de experiencia y un enfoque
                centrado en el cliente, nos esforzamos al máximo para eliminar
                las plagas y prevenir su regreso.
              </p>

              <div className={styles.benefitsGrid}>
                <div className={styles.benefitItem}>
                  <span className="check">✔</span> Experiencia en la que puede
                  confiar
                </div>
                <div className={styles.benefitItem}>
                  <span className="check">✔</span> Disponibilidad 24/7
                </div>
                <div className={styles.benefitItem}>
                  <span className="check">✔</span> Profesionales certificados
                </div>
                <div className={styles.benefitItem}>
                  <span className="check">✔</span> Soluciones asequibles
                </div>
                <div className={styles.benefitItem}>
                  <span className="check">✔</span> Enfoque ecológico
                </div>
                <div className={styles.benefitItem}>
                  <span className="check">✔</span> Técnicas avanzadas
                </div>
                <div className={styles.benefitItem}>
                  <span className="check">✔</span> Servicio centrado en el
                  cliente
                </div>
                <div className={styles.benefitItem}>
                  <span className="check">✔</span> Compromiso con la excelencia
                </div>
              </div>

              {/* <!-- Video Thumbnail --> */}
              <div className={styles.videoThumb}>
                <img src="/images/about/diez.webp" alt="Nuestro equipo" />
                <div className={styles.playButton}>▶</div>
              </div>

              {/* <!-- Estadísticas --> */}
              <div className={styles.statsGrid}>
                <div className={styles.stat}>
                  <h3>29+</h3>
                  <p>Años de experiencia</p>
                </div>
                <div className={styles.stat}>
                  <h3>2K</h3>
                  <p>Proyectos finalizados</p>
                </div>
                <div className={styles.stat}>
                  <h3>50</h3>
                  <p>Equipo dedicado</p>
                </div>
                <div className={styles.stat}>
                  <h3>98%</h3>
                  <p>Clientes satisfechos</p>
                </div>
              </div>
            </div>
          </div>
        </div>

        <style></style>
      </section>

      {/* <!-- Services --> */}
      <section className={styles.services} id="services">
        <div className={styles.container}>
          {/* <!-- Tag y título --> */}
          <div className={styles.sectionHeader}>
            <span className={styles.sectionTag}>Servicios</span>
            <h2>
              Soluciones expertas para cualquier
              <span className={styles.textGreen}>problema de plagas</span>
            </h2>
          </div>

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
                  <i className="fas fa-building"></i>
                </div>
                <h3>Soluciones comerciales para el control de plagas</h3>
                <p>
                  Soluciones personalizadas para proteger su hogar de las plagas
                  comunes
                </p>
                <a href="#" className={styles.readMore}>
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
                  <i className="fas fa-bug"></i>
                </div>
                <h3>Control de termitas y roedores</h3>
                <p>
                  Soluciones personalizadas para proteger su hogar de las plagas
                  comunes
                </p>
                <a href="#" className={styles.readMore}>
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
                  <i className="fas fa-leaf"></i>
                </div>
                <h3>Control de plagas en exteriores</h3>
                <p>
                  Soluciones personalizadas para proteger su hogar de las plagas
                  comunes
                </p>
                <a href="#" className={styles.readMore}>
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
                  <i className="fas fa-home"></i>
                </div>
                <h3>Integración de hogares inteligentes</h3>
                <p>
                  Soluciones personalizadas para proteger su hogar de las plagas
                  comunes
                </p>
                <a href="#" className={styles.readMore}>
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
                  <i className="fas fa-home"></i>
                </div>
                <h3>Control de plagas residenciales</h3>
                <p>
                  Soluciones personalizadas para proteger su hogar de las plagas
                  comunes
                </p>
                <a href="#" className={styles.readMore}>
                  Read More →
                </a>
              </div>
            </SwiperSlide>
          </Swiper>

          {/* <!-- Slider de Servicios --> */}
          {/* <div className="swiper services-slider"> */}
          {/* <div className={styles.servicesSlider}>
                        <div className={styles.swiperWrapper}>                            
                            <div className={styles.swiperSlide}>
                                <div className={styles.serviceCard}>
                                    <div className={styles.serviceImg}>
                                        <img
                                            src="/images/services/uno.webp"
                                            alt="Commercial"
                                        />
                                    </div>
                                    <div className={styles.serviceIcon}>
                                        <i className="fas fa-building"></i>
                                    </div>
                                    <h3>
                                        Soluciones comerciales para el control
                                        de plagas
                                    </h3>
                                    <p>
                                        Soluciones personalizadas para proteger
                                        su hogar de las plagas comunes
                                    </p>
                                    <a href="#" className={styles.readMore}>
                                        Read More →
                                    </a>
                                </div>
                            </div>                            
                            <div className={styles.swiperSlide}>
                                <div className={styles.serviceCard}>
                                    <div className={styles.serviceImg}>
                                        <img
                                            src="/images/services/dos.webp"
                                            alt="Termite"
                                        />
                                    </div>
                                    <div className={styles.serviceIcon}>
                                        <i className="fas fa-bug"></i>
                                    </div>
                                    <h3>Control de termitas y roedores</h3>
                                    <p>
                                        Soluciones personalizadas para proteger
                                        su hogar de las plagas comunes
                                    </p>
                                    <a href="#" className={styles.readMore}>
                                        Read More →
                                    </a>
                                </div>
                            </div>                            
                            <div className={styles.swiperSlide}>
                                <div className={styles.serviceCard}>
                                    <div className={styles.serviceImg}>
                                        <img
                                            src="/images/services/tres.webp"
                                            alt="Outdoor"
                                        />
                                    </div>
                                    <div className={styles.serviceIcon}>
                                        <i className="fas fa-leaf"></i>
                                    </div>
                                    <h3>Control de plagas en exteriores</h3>
                                    <p>
                                        Soluciones personalizadas para proteger
                                        su hogar de las plagas comunes
                                    </p>
                                    <a href="#" className={styles.readMore}>
                                        Read More →
                                    </a>
                                </div>
                            </div>                            
                            <div className={styles.swiperSlide}>
                                <div className={styles.serviceCard}>
                                    <div className={styles.serviceImg}>
                                        <img
                                            src="/images/services/cuatro.webp"
                                            alt="Smart Home"
                                        />
                                    </div>
                                    <div className={styles.serviceIcon}>
                                        <i className="fas fa-home"></i>
                                    </div>
                                    <h3>Integración de hogares inteligentes</h3>
                                    <p>
                                        Soluciones personalizadas para proteger
                                        su hogar de las plagas comunes
                                    </p>
                                    <a href="#" className={styles.readMore}>
                                        Read More →
                                    </a>
                                </div>
                            </div>                            
                            <div className={styles.swiperSlide}>
                                <div className={styles.serviceCard}>
                                    <div className={styles.serviceImg}>
                                        <img
                                            src="/images/services/cinco.webp"
                                            alt="Smart Home"
                                        />
                                    </div>
                                    <div className={styles.serviceIcon}>
                                        <i className="fas fa-home"></i>
                                    </div>
                                    <h3>Control de plagas residenciales</h3>
                                    <p>
                                        Soluciones personalizadas para proteger
                                        su hogar de las plagas comunes
                                    </p>
                                    <a href="#" className={styles.readMore}>
                                        Read More →
                                    </a>
                                </div>
                            </div>
                        </div>                        
                        <div className={styles.swiperPagination}></div>                        
                        <div className={styles.swiperButtonNext}></div>
                        <div className={styles.swiperButtonPrev}></div>
                    </div> */}

          {/* <!-- Texto final --> */}
          <div className={styles.servicesCta}>
            <p>
              ¿Listo para un hogar libre de plagas?
              <a href="#contact" className={styles.ctaLink}>
                ¡Contáctenos hoy!
              </a>
            </p>
          </div>
        </div>

        <style></style>

        {/* <!-- Inicialización del Slider --> */}
        {/* <script>
                const servicesSlider = new Swiper('.services-slider', {
                    loop: true,
                    autoplay: {
                        delay: 4000,
                        disableOnInteraction: false,
                    },
                    speed: 800,
                    spaceBetween: 30,
                    pagination: {
                        el: '.swiper-pagination',
                        clickable: true,
                    },
                    navigation: {
                        nextEl: '.swiper-button-next',
                        prevEl: '.swiper-button-prev',
                    },
                    breakpoints: {
                        320: { slidesPerView: 1 },
                        768: { slidesPerView: 2 },
                        1024: { slidesPerView: 3 },
                        1200: { slidesPerView: 4 },
                    },
                });
            </script> */}
      </section>

      {/* <!-- our features --> */}
      <section className={styles.ourFeatures} id="our-features">
        <div className={styles.container}>
          <div className={styles.featuresWrapper}>
            {/* <!-- Columna Izquierda - Texto + Características --> */}
            <div className={styles.featuresContent}>
              <span className={styles.sectionTag}>Nuestros servicios</span>
              <h2>
                Su socio de confianza en
                <span className={styles.textGreen}>control de plagas</span>
              </h2>

              <p className={styles.featuresText}>
                Entendemos lo frustrantes y molestas que pueden ser las plagas,
                por eso nos comprometemos a brindar soluciones rápidas,
                confiables y efectivas. Contamos con un equipo de expertos
                certificados, métodos ecológicos y una atención al cliente
                inigualable.
              </p>

              <div className={styles.featuresGrid}>
                {/* <!-- Feature 1 --> */}
                <div className={styles.featureItem}>
                  <div className={styles.featureIcon}>
                    <i className="fas fa-clock"></i>
                  </div>
                  <div className={styles.featureText}>
                    <h4>Servicios de emergencia</h4>
                    <p>
                      Estamos disponibles las 24 horas para atender su
                      emergencia.
                    </p>
                  </div>
                </div>

                {/* <!-- Feature 2 --> */}
                <div className={styles.featureItem}>
                  <div className={styles.featureIcon}>
                    <i className="fas fa-cogs"></i>
                  </div>
                  <div className={styles.featureText}>
                    <h4>Tratamientos personalizados</h4>
                    <p>
                      Cada propiedad es única, por lo que ofrecemos tratamientos
                      personalizados contra plagas.
                    </p>
                  </div>
                </div>

                {/* <!-- Feature 3 --> */}
                <div className={styles.featureItem}>
                  <div className={styles.featureIcon}>
                    <i className="fas fa-user-shield"></i>
                  </div>
                  <div className={styles.featureText}>
                    <h4>Profesionales certificados</h4>
                    <p>
                      Nuestro equipo está altamente capacitado, certificado y
                      cuenta con amplia experiencia.
                    </p>
                  </div>
                </div>

                {/* <!-- Feature 4 --> */}
                <div className={styles.featureItem}>
                  <div className={styles.featureIcon}>
                    <i className="fas fa-check-circle"></i>
                  </div>
                  <div className={styles.featureText}>
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
            <div className={styles.featuresImage}>
              <img
                src="/images/features/seis.webp"
                alt="Técnico profesional fumigando"
              />

              {/* <!-- Botón circular flotante --> */}
              <a href="#contact" className={styles.floatingContactBtn}>
                <i className="fas fa-phone"></i>
                <span>Contact Us</span>
              </a>
            </div>
          </div>
        </div>

        <style></style>
      </section>

      {/* <!-- our portafolio  --> */}
      {/* <!-- CDN de Isotope (solo si aún no lo tienes) --> */}
      <script src="https://unpkg.com/isotope-layout@3/dist/isotope.pkgd.min.js"></script>

      <section className={styles.ourPortfolio} id="our-portfolio">
        <div className={styles.container}>
          {/* <!-- Tag y título --> */}
          <div className={styles.sectionHeader}>
            <span className={styles.sectionTag}>Portafolio</span>
            <h2>
              Descubra nuestra trayectoria comprobada en
              <span className={styles.textGreen}>
                soluciones para eliminar plagas
              </span>
            </h2>
          </div>

          {/* <!-- Filtros --> */}
          <div className={styles.portfolioFilters}>
            {/* <button className="filter-btn active" data-filter="*"> */}
            <button className={styles.filterBtn} data-filter="*">
              Todo
            </button>
            <button className={styles.filterBtn} data-filter=".home">
              Plaga en Hogar
            </button>
            <button className={styles.filterBtn} data-filter=".commercial">
              Plaga Comercial
            </button>
            <button className={styles.filterBtn} data-filter=".eco">
              Eco-Friendly
            </button>
            <button className={styles.filterBtn} data-filter=".termite">
              Termitas y Roedores
            </button>
            <button className={styles.filterBtn} data-filter=".outdoor">
              Plagas en Exteriores
            </button>
          </div>

          {/* <!-- Galería con hover + overlay --> */}
          <div className={styles.portfolioGrid} id="portfolioGrid">
            {/* <div className="portfolio-item home"> */}
            <div className={styles.portfolioItem}>
              <img src="/images/portfolio/ocho.webp" alt="Plaga en Hogar" />
              <div className={styles.portfolioOverlay}>
                <div className={styles.overlayContent}>
                  <h4>Control de Plagas en Hogar</h4>
                  <p>
                    Soluciones efectivas y seguras para mantener tu hogar libre
                    de insectos y roedores.
                  </p>
                </div>
              </div>
            </div>

            {/* <div className="portfolio-item commercial"> */}
            <div className={styles.portfolioItem}>
              <img src="/images/portfolio/nueve.webp" alt="Plaga Comercial" />
              <div className={styles.portfolioOverlay}>
                <div className={styles.overlayContent}>
                  <h4>Plagas en Negocios</h4>
                  <p>
                    Protección profesional para oficinas, restaurantes y locales
                    comerciales.
                  </p>
                </div>
              </div>
            </div>

            {/* <div className="portfolio-item termite"> */}
            <div className={styles.portfolioItem}>
              <img src="/images/portfolio/diez.webp" alt="Termitas" />
              <div className={styles.portfolioOverlay}>
                <div className={styles.overlayContent}>
                  <h4>Control de Termitas</h4>
                  <p>
                    Eliminación total y prevención de daños estructurales por
                    termitas.
                  </p>
                </div>
              </div>
            </div>

            {/* <div className="portfolio-item commercial"> */}
            <div className={styles.portfolioItem}>
              <img src="/images/portfolio/uno.webp" alt="Oficina" />
              <div className={styles.portfolioOverlay}>
                <div className={styles.overlayContent}>
                  <h4>Oficinas Libres de Plagas</h4>
                  <p>
                    Servicios discretos y efectivos para entornos corporativos.
                  </p>
                </div>
              </div>
            </div>

            {/* <div className="portfolio-item eco"> */}
            <div className={styles.portfolioItem}>
              <img src="/images/portfolio/dos.webp" alt="Eco-Friendly" />
              <div className={styles.portfolioOverlay}>
                <div className={styles.overlayContent}>
                  <h4>Tratamiento Eco-Friendly</h4>
                  <p>
                    Métodos ecológicos seguros para niños, mascotas y el medio
                    ambiente.
                  </p>
                </div>
              </div>
            </div>

            {/* <div className="portfolio-item outdoor"> */}
            <div className={styles.portfolioItem}>
              <img src="/images/portfolio/tres.webp" alt="Exteriores" />
              <div className={styles.portfolioOverlay}>
                <div className={styles.overlayContent}>
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

        <style></style>

        {/* <!-- Script Isotope + Filtros --> */}
        {/* <script>
                document.addEventListener('DOMContentLoaded', function () {
                    const grid = document.querySelector('#portfolioGrid');
                    const iso = new Isotope(grid, {
                        itemSelector: '.portfolio-item',
                        layoutMode: 'fitRows',
                        transitionDuration: '0.6s',
                    });

                    document
                        .querySelectorAll('.filter-btn')
                        .forEach((button) => {
                            button.addEventListener('click', function () {
                                document
                                    .querySelector('.filter-btn.active')
                                    .classList.remove('active');
                                this.classList.add('active');
                                const filterValue =
                                    this.getAttribute('data-filter');
                                iso.arrange({ filter: filterValue });
                            });
                        });
                });
            </script> */}
      </section>

      {/* <!-- por que elegirnos --> */}

      <section className={styles.whyChoose} id="why-choose">
        <div className={styles.container}>
          {/* <!-- Tag y título --> */}
          <div className={styles.sectionHeader}>
            <span className={styles.sectionTag}>¿Por qué elegirnos?</span>
            <h2>
              ¿Qué nos convierte en la mejor opción
              <span className={styles.textGreen}>para usted?</span>
            </h2>
            <p className={styles.sectionDesc}>
              Entendemos lo frustrantes y molestas que pueden ser las plagas,
              por eso nos comprometemos a brindar soluciones rápidas, confiables
              y efectivas..
            </p>
          </div>

          <div className={styles.whyGrid}>
            {/* <!-- Tarjeta 1 --> */}
            <div className={styles.whyCard}>
              <div className={styles.whyIcon}>
                <i className="fas fa-clock"></i>
              </div>
              <h3>Servicios de emergencia</h3>
              <p>Disponibles las 24 horas.</p>
            </div>

            {/* <!-- Tarjeta 2 --> */}
            <div className={styles.whyCard}>
              <div className={styles.whyIcon}>
                <i className="fas fa-cogs"></i>
              </div>
              <h3>Tratamientos personalizados</h3>
              <p>Disponibles las 24 horas.</p>
            </div>

            {/* <!-- Tarjeta 3 --> */}
            <div className={styles.whyCard}>
              <div className={styles.whyIcon}>
                <i className="fas fa-user-shield"></i>
              </div>
              <h3>Profesionales certificados</h3>
              <p>Disponibles las 24 horas.</p>
            </div>

            {/* <!-- Tarjeta destacada con imagen --> */}
            <div className={styles.whyHighlightCard}>
              <img src="/images/choice/seis.webp" alt="Take Back Your Home" />
              <div className={styles.highlightContent}>
                <h3>¡Recupere su hogar de las plagas hoy mismo!</h3>
                <a href="tel:+1322782968" className={styles.highlightBtn}>
                  <i className="fas fa-phone"></i> Llame ahora +591 74392912
                </a>
              </div>
            </div>
          </div>

          {/* <!-- CTA final --> */}
          <div className={styles.whyCta}>
            <a href="#contact" className={styles.btnFree}>
              ¡Creemos un ambiente libre de plagas! – ¡Contáctenos hoy!
            </a>
          </div>
        </div>

        <style></style>
      </section>

      {/* <!-- frequently questions --> */}

      <section className={styles.faqSection} id="faq">
        <div className={styles.container}>
          <div className={styles.faqWrapper}>
            {/* <!-- Imágenes decorativas izquierda --> */}
            <div className={styles.faqImages}>
              <img
                src="/images/questions/doce.webp"
                alt="Técnico fumigando"
                className={styles.img1}
              />
              <img
                src="/images/questions/uno.webp"
                alt="Equipo profesional"
                className={styles.img2}
              />
              <img
                src="/images/questions/seis.webp"
                alt="Fumigación exterior"
                className={styles.img3}
              />
            </div>

            {/* <!-- Contenido FAQ derecha --> */}
            <div className={styles.faqContent}>
              <span className={styles.sectionTag}>Preguntas frecuentes</span>
              <h2>
                Encuentre respuestas útiles a sus dudas sobre
                <span className={styles.textGreen}>el control de plagas</span>
              </h2>

              <div className={styles.faqAccordion}>
                {/* <!-- Pregunta 1 --> */}
                {/* <div className="faq-item active"> */}
                <div className={styles.faqItem}>
                  <div className={styles.faqQuestion}>
                    <h3>1. ¿Qué tipos de plagas tratan?</h3>
                    <span className={styles.faqToggle}>↑</span>
                  </div>
                  <div className={styles.faqAnswer}>
                    <p>
                      Controlamos una amplia variedad de plagas, incluyendo
                      roedores, hormigas, cucarachas, termitas, chinches,
                      mosquitos, arañas y fauna silvestre.
                    </p>
                  </div>
                </div>

                {/* <!-- Pregunta 2 --> */}
                <div className={styles.faqItem}>
                  <div className={styles.faqQuestion}>
                    <h3>
                      2. ¿Son seguros sus métodos de control de plagas para mis
                      mascotas?
                    </h3>
                    <span className={styles.faqToggle}>↓</span>
                  </div>
                  <div className={styles.faqAnswer}>
                    <p>
                      Controlamos una amplia variedad de plagas, incluyendo
                      roedores, hormigas, cucarachas, termitas, chinches,
                      mosquitos, arañas y fauna silvestre.
                    </p>
                  </div>
                </div>

                {/* <!-- Pregunta 3 --> */}
                <div className={styles.faqItem}>
                  <div className={styles.faqQuestion}>
                    <h3>
                      3. ¿Con qué frecuencia debo programar los servicios de
                      control de plagas?
                    </h3>
                    <span className={styles.faqToggle}>↓</span>
                  </div>
                  <div className={styles.faqAnswer}>
                    <p>
                      Controlamos una amplia variedad de plagas, incluyendo
                      roedores, hormigas, cucarachas, termitas, chinches,
                      mosquitos, arañas y fauna silvestre.
                    </p>
                  </div>
                </div>

                {/* <!-- Pregunta 4 --> */}
                <div className={styles.faqItem}>
                  <div className={styles.faqQuestion}>
                    <h3>
                      4. ¿Ofrecen servicios de control de plagas de emergencia?
                    </h3>
                    <span className={styles.faqToggle}>↓</span>
                  </div>
                  <div className={styles.faqAnswer}>
                    <p>
                      Controlamos una amplia variedad de plagas, incluyendo
                      roedores, hormigas, cucarachas, termitas, chinches,
                      mosquitos, arañas y fauna silvestre.
                    </p>
                  </div>
                </div>

                {/* <!-- Pregunta 5 --> */}
                <div className={styles.faqItem}>
                  <div className={styles.faqQuestion}>
                    <h3>5. ¿Cómo sé si tengo una plaga?</h3>
                    <span className={styles.faqToggle}>↓</span>
                  </div>
                  <div className={styles.faqAnswer}>
                    <p>
                      Nos encargamos de una amplia variedad de plagas,
                      incluyendo roedores, hormigas, cucarachas, termitas,
                      chinches, mosquitos, arañas y fauna silvestre.
                    </p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <style></style>

        {/* <!-- Script del acordeón (sin dependencias) --> */}
        {/* <script>
                document.querySelectorAll('.faq-question').forEach((item) => {
                    item.addEventListener('click', () => {
                        const parent = item.parentElement;
                        const isActive = parent.classList.contains('active');

                        // Cerrar todas
                        document
                            .querySelectorAll('.faq-item')
                            .forEach((el) => el.classList.remove('active'));

                        // Abrir la clickeada (si no estaba activa)
                        if (!isActive) {
                            parent.classList.add('active');
                        }
                    });
                });
            </script> */}
      </section>

      {/* <!-- Testimonials --> */}

      <section className={styles.testimonials} id="testimonials">
        <div className={styles.container}>
          {/* <!-- Tag centrado --> */}
          <div className={styles.sectionHeader}>
            <span className={styles.sectionTag}>Testimonials</span>
            <h2>
              Cientos de personas confían en nosotros para obtener soluciones
              <span className={styles.textGreen}>
                confiables de control de plagas
              </span>
            </h2>
          </div>

          {/* <!-- Slider de testimonios --> */}
          <Swiper
            // pagination={{
            //     type: 'fraction',
            // }}
            pagination={false}
            navigation={{
              nextEl: '#testimonialBtnNext',
              prevEl: '#testimonialBtnPrev',
            }}
            autoplay={{ delay: 9000, disableOnInteraction: false }}
            modules={[Autoplay, Pagination, Navigation]}
            className="mySwiper"
            slidesPerView={3}
            spaceBetween={30}
            loop={true}
          >
            <SwiperSlide>
              <div className={styles.testimonial}>
                <div className={styles.stars}>5 ★★★★★</div>
                <p>
                  "Excellent service! We had a major ant problem, and they took
                  care of it quickly and professionally."
                </p>
                <strong>Ronald Richards</strong>
              </div>
            </SwiperSlide>
            <SwiperSlide>
              <div className={styles.testimonial}>
                <div className={styles.stars}>5 ★★★★★</div>
                <p>
                  "Very professional team. They explained everything and the
                  results have been amazing."
                </p>
                <strong>Brooklyn Simmons</strong>
              </div>
            </SwiperSlide>
            <SwiperSlide>
              <div className={styles.testimonial}>
                <div className={styles.stars}>5 ★★★★★</div>
                <p>"Best pest control company we've used. Highly recommend!"</p>
                <strong>Emily Williams</strong>
              </div>
            </SwiperSlide>
            <SwiperSlide>
              <div className={styles.testimonial}>
                <div className={styles.stars}>5 ★★★★★</div>
                <p>
                  "Fast response, friendly staff, and completely pest-free after
                  just one visit. Incredible!"
                </p>
                <strong>Jacob Jones</strong>
              </div>
            </SwiperSlide>
            <SwiperSlide>
              <div className={styles.testimonial}>
                <div className={styles.stars}>5 ★★★★★</div>
                <p>
                  "They saved our restaurant from a serious cockroach issue.
                  True professionals!"
                </p>
                <strong>Leslie Alexander</strong>
              </div>
            </SwiperSlide>
          </Swiper>
          <div className={styles.testimonialBtnNext} id="testimonialBtnNext">
            <ChevronLeftIcon className="" />
          </div>
          <div
            // className={styles.testimonialBtnPrev}
            className="absolute right-6 -translate-y-1/2"
            id="testimonialBtnPrev"
          >
            <ChevronRightIcon className="" />
          </div>

          {/* <div className="swiper testimonials-slider"> */}
          {/* <div className={styles.testimonialsSlider}>
                        <div className={styles.swiperWrapper}>
                            <div className={styles.swiperSlide}>
                                <div className={styles.testimonial}>
                                    <div className={styles.stars}>5 ★★★★★</div>
                                    <p>
                                        "Excellent service! We had a major ant
                                        problem, and they took care of it
                                        quickly and professionally."
                                    </p>
                                    <strong>Ronald Richards</strong>
                                </div>
                            </div>

                            <div className={styles.swiperSlide}>
                                <div className={styles.testimonial}>
                                    <div className={styles.stars}>5 ★★★★★</div>
                                    <p>
                                        "Very professional team. They explained
                                        everything and the results have been
                                        amazing."
                                    </p>
                                    <strong>Brooklyn Simmons</strong>
                                </div>
                            </div>

                            <div className={styles.swiperSlide}>
                                <div className={styles.testimonial}>
                                    <div className={styles.stars}>5 ★★★★★</div>
                                    <p>
                                        "Best pest control company we've used.
                                        Highly recommend!"
                                    </p>
                                    <strong>Emily Williams</strong>
                                </div>
                            </div>

                            <div className={styles.swiperSlide}>
                                <div className={styles.testimonial}>
                                    <div className={styles.stars}>5 ★★★★★</div>
                                    <p>
                                        "Fast response, friendly staff, and
                                        completely pest-free after just one
                                        visit. Incredible!"
                                    </p>
                                    <strong>Jacob Jones</strong>
                                </div>
                            </div>

                            <div className={styles.swiperSlide}>
                                <div className={styles.testimonial}>
                                    <div className={styles.stars}>5 ★★★★★</div>
                                    <p>
                                        "They saved our restaurant from a
                                        serious cockroach issue. True
                                        professionals!"
                                    </p>
                                    <strong>Leslie Alexander</strong>
                                </div>
                            </div>
                        </div>                        
                        <div className={styles.swiperButtonPrev}></div>
                        <div className={styles.swiperButtonNext}></div>
                        <div className={styles.swiperPagination}></div>
                    </div> */}
        </div>

        <style></style>

        {/* <!-- Inicialización del slider --> */}
        {/* <script>
                const testimonialsSlider = new Swiper('.testimonials-slider', {
                    loop: true,
                    autoplay: {
                        delay: 5000,
                        disableOnInteraction: false,
                    },
                    speed: 800,
                    spaceBetween: 30,
                    pagination: {
                        el: '.swiper-pagination',
                        clickable: true,
                    },
                    navigation: {
                        nextEl: '.swiper-button-next',
                        prevEl: '.swiper-button-prev',
                    },
                    breakpoints: {
                        320: { slidesPerView: 1 },
                        768: { slidesPerView: 2 },
                        1024: { slidesPerView: 3 },
                    },
                });
            </script> */}
      </section>

      {/* <!-- CTA --> */}
      <section className={styles.aboutYour} id="about-your">
        <div className={styles.container}>
          <div className={styles.aboutYourWrapper}>
            {/* <!-- Imagen del técnico (izquierda) --> */}
            <div className={styles.aboutYourImage}>
              <img
                src="/images/cta/personaje.webp"
                alt="Técnico profesional listo para ayudarte"
              />
            </div>

            {/* <!-- Contenido (derecha) --> */}
            <div className={styles.aboutYourContent}>
              <h2>
                Hablemos de sus necesidades de
                <span className={styles.textGreen}>control de plagas</span>
              </h2>

              <ul className={styles.aboutYourList}>
                <li>
                  <span className="list-icon">Check</span>
                  Agende su inspección gratuita
                </li>
                <li>
                  <span className="list-icon">Check</span>
                  Prevenga futuras infestaciones
                </li>
                <li>
                  <span className="list-icon">Check</span>
                  Reserva fácil y rápida
                </li>
              </ul>

              <a href="#contact" className={styles.btnMembership}>
                Empieza Ahora
                <span className="arrow-circle">Check</span>
              </a>
            </div>
          </div>
        </div>

        <style></style>
      </section>

      {/* <!-- Footer --> */}
      <footer className={styles.footer}>
        <div className={styles.container}>
          {/* <!-- Parte superior: 4 columnas --> */}
          <div className={styles.footerTop}>
            {/* <!-- Columna 1: About Petronus --> */}
            {/* <div className="footer-column about"> */}
            <div className={styles.footerColumn}>
              <h3>Acerca de Bolivian Pest</h3>
              <p>
                Nos dedicamos a crear entornos seguros y libres de plagas para
                hogares y negocios. Contamos con años de experiencia en el
                sector del control de plagas. Nos enorgullecemos de ofrecer
                soluciones eficaces y ecológicas adaptadas a sus necesidades.
              </p>
            </div>

            {/* <!-- Columna 2: Services --> */}
            <div className={styles.footerColumn}>
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
            <div className={styles.footerColumn}>
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
            {/* <div className="footer-column contact"> */}
            <div className={styles.footerColumn}>
              <h3>Contáctanos</h3>
              <div className={styles.contactItem}>
                <span className={styles.contactIcon}>Phone</span>
                <a href="tel:+19123456789">+591 32221344</a>
              </div>
              <div className={styles.contactItem}>
                {/* <span className="contact-icon phone"> */}
                <span className={styles.contactIcon}>Email</span>
                <a href="mailto:info@domainname.com">info@BolivianPest.com</a>
              </div>
            </div>
          </div>

          <hr className={styles.footerDivider} />

          {/* <!-- Parte inferior: Logo + Redes + Copyright --> */}
          <div className={styles.footerBottom}>
            <div className={styles.footerLogo}>
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
              <span className={styles.logoText}>Bolivian Pest</span>
            </div>

            <div className={styles.socialLinks}>
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

            <div className={styles.copyright}>
              Copyright Bitdesarrollo © 2025 All Rights Reserved.
            </div>
          </div>
        </div>

        <style></style>
      </footer>

      {/* <script>
            //slider
            let index = 0;

            function moveSlider() {
                index++;
                if (index > 2) index = 0;
                document.querySelector('.slides').style.transform =
                    `translateX(-${index * 100}%)`;
            }

            setInterval(moveSlider, 4000); // cambia cada 4 segundos

            // Simple scroll effect for header
            window.addEventListener('scroll', () => {
                document.querySelector('header').style.background =
                    window.scrollY > 50
                        ? 'rgba(45,52,54,0.95)'
                        : 'linear-gradient(rgba(0,0,0,0.7),rgba(0,0,0,0.7))';
            });
        </script> */}
    </>
  );
}
