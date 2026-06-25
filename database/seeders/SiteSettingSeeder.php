<?php

declare(strict_types=1);

namespace Database\Seeders;

use App\Models\SiteSetting;
use Illuminate\Database\Seeder;

class SiteSettingSeeder extends Seeder
{
    /**
     * Carga todas las configuraciones del landing con sus valores actuales
     * como valores por defecto. Usa updateOrCreate para ser idempotente:
     * vuelve a correrlo agrega claves nuevas sin pisar lo que el admin editó.
     */
    public function run(): void
    {
        $order = 0;

        foreach ($this->definitions() as $def) {
            $default = $def['value'];
            if (($def['type'] ?? 'text') === 'json') {
                $default = json_encode($default, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
            }

            $existing = SiteSetting::where('key', $def['key'])->first();

            SiteSetting::updateOrCreate(
                ['key' => $def['key']],
                [
                    'type'  => $def['type'] ?? 'text',
                    'group' => $def['group'],
                    'label' => $def['label'],
                    'order' => $order++,
                    // Conserva el valor editado si la fila ya existe; si es nueva usa el default.
                    'value' => $existing ? $existing->value : $default,
                ]
            );
        }
    }

    /**
     * @return array<int, array<string, mixed>>
     */
    private function definitions(): array
    {
        return [
            // ===================== MARCA =====================
            ['key' => 'brand.logo_navbar', 'group' => 'brand', 'type' => 'image', 'label' => 'Logo barra de navegación', 'value' => '/images/LogoHFCWhite.png'],
            ['key' => 'brand.logo_footer', 'group' => 'brand', 'type' => 'image', 'label' => 'Logo del pie de página', 'value' => '/images/LogoHFCWhite.png'],
            ['key' => 'brand.logo_splash', 'group' => 'brand', 'type' => 'image', 'label' => 'Logo de carga (splash)', 'value' => '/images/LogoBlack.png'],
            ['key' => 'brand.footer_description', 'group' => 'brand', 'type' => 'textarea', 'label' => 'Descripción del pie de página', 'value' => 'Creamos entornos seguros y libres de plagas para hogares y negocios en toda Bolivia, con soluciones eficaces, ecológicas y certificadas.'],
            ['key' => 'brand.navbar_cta', 'group' => 'brand', 'type' => 'text', 'label' => 'Texto botón "Cotizar" (navbar)', 'value' => 'Cotizar'],

            // ===================== HERO =====================
            ['key' => 'hero.badge', 'group' => 'hero', 'type' => 'text', 'label' => 'Insignia superior', 'value' => 'Técnicos certificados SENASAG'],
            ['key' => 'hero.title', 'group' => 'hero', 'type' => 'text', 'label' => 'Título', 'value' => 'Elimine cualquier plaga en'],
            ['key' => 'hero.title_highlight', 'group' => 'hero', 'type' => 'text', 'label' => 'Título (palabra destacada)', 'value' => '24 horas'],
            ['key' => 'hero.subtitle', 'group' => 'hero', 'type' => 'textarea', 'label' => 'Subtítulo', 'value' => 'Desde termitas hasta roedores, exterminación profesional garantizada. Sin compromiso — agende su inspección hoy.'],
            ['key' => 'hero.chips', 'group' => 'hero', 'type' => 'json', 'label' => 'Chips de confianza', 'value' => ['Disponibles 24/7', 'En toda Bolivia', 'Garantía por escrito']],
            ['key' => 'hero.cta_text', 'group' => 'hero', 'type' => 'text', 'label' => 'Texto botón principal', 'value' => 'Llamar ahora +591 76738282'],
            ['key' => 'hero.cta_link', 'group' => 'hero', 'type' => 'url', 'label' => 'Enlace botón principal', 'value' => 'https://wa.me/59176738282'],
            ['key' => 'hero.character_image', 'group' => 'hero', 'type' => 'image', 'label' => 'Imagen del personaje', 'value' => '/images/cta/personaje.webp'],
            ['key' => 'hero.slides', 'group' => 'hero', 'type' => 'json', 'label' => 'Imágenes del slider', 'value' => [
                ['img' => '/images/slider/sli1.webp', 'alt' => 'Servicio de control de plagas en hogar boliviano - Fumigación profesional'],
                ['img' => '/images/slider/sli2.webp', 'alt' => 'Equipo profesional de Bolivian Pest realizando fumigación comercial'],
                ['img' => '/images/slider/sli3.webp', 'alt' => 'Control de termitas y roedores en oficinas y negocios'],
                ['img' => '/images/slider/sli4.webp', 'alt' => 'Servicio de fumigación 24/7 para emergencias de plagas'],
            ]],

            // ===================== FEATURES (4 tarjetas) =====================
            ['key' => 'features.items', 'group' => 'features', 'type' => 'json', 'label' => 'Tarjetas de características', 'value' => [
                ['icon' => '/images/icons/coberturab.svg', 'title' => 'Cobertura Integral', 'alt' => 'Servicio de control de plagas con cobertura nacional en Bolivia'],
                ['icon' => '/images/icons/tiempob.svg', 'title' => 'Tiempos de respuesta rápidos', 'alt' => 'Respuesta rápida de emergencia en control de plagas'],
                ['icon' => '/images/icons/serviciob.svg', 'title' => 'Servicios comerciales', 'alt' => 'Servicios de fumigación para negocios y empresas'],
                ['icon' => '/images/icons/emergenciab.svg', 'title' => 'Servicio de Emergencia 24/7', 'alt' => 'Servicio de emergencia de control de plagas disponible 24 horas'],
            ]],

            // ===================== NOSOTROS =====================
            ['key' => 'about.tag', 'group' => 'about', 'type' => 'text', 'label' => 'Etiqueta de sección', 'value' => 'Acerca de Nosotros'],
            ['key' => 'about.title', 'group' => 'about', 'type' => 'text', 'label' => 'Título', 'value' => 'Protegiendo hogares,'],
            ['key' => 'about.title_highlight', 'group' => 'about', 'type' => 'text', 'label' => 'Título (destacado)', 'value' => 'negocios y comunidades'],
            ['key' => 'about.text', 'group' => 'about', 'type' => 'textarea', 'label' => 'Texto descriptivo', 'value' => 'Nuestra misión es simple: brindar servicios confiables de control de plagas que garanticen un ambiente limpio, seguro y confortable para todos. Con años de experiencia y un enfoque centrado en el cliente, nos esforzamos al máximo para eliminar las plagas y prevenir su regreso.'],
            ['key' => 'about.image_main', 'group' => 'about', 'type' => 'image', 'label' => 'Imagen principal', 'value' => '/images/about-equipo-trabajo.webp'],
            ['key' => 'about.image_1', 'group' => 'about', 'type' => 'image', 'label' => 'Imagen flotante 1', 'value' => '/images/about-mosquito.webp'],
            ['key' => 'about.image_2', 'group' => 'about', 'type' => 'image', 'label' => 'Imagen flotante 2', 'value' => '/images/about-tecnico-fumigando.webp'],
            ['key' => 'about.image_3', 'group' => 'about', 'type' => 'image', 'label' => 'Imagen flotante 3', 'value' => '/images/about/siete.webp'],
            ['key' => 'about.video_thumb', 'group' => 'about', 'type' => 'image', 'label' => 'Miniatura de video', 'value' => '/images/about/diez.webp'],
            ['key' => 'about.benefits', 'group' => 'about', 'type' => 'json', 'label' => 'Lista de beneficios', 'value' => [
                'Experiencia en la que puede confiar',
                'Disponibilidad 24/7',
                'Profesionales certificados',
                'Soluciones asequibles',
                'Enfoque ecológico',
                'Técnicas avanzadas',
                'Servicio centrado en el cliente',
                'Compromiso con la excelencia',
            ]],
            ['key' => 'about.stats', 'group' => 'about', 'type' => 'json', 'label' => 'Estadísticas', 'value' => [
                ['end' => 29, 'suffix' => '+', 'label' => 'Años de experiencia'],
                ['end' => 2, 'suffix' => 'K', 'label' => 'Proyectos finalizados'],
                ['end' => 50, 'suffix' => '', 'label' => 'Equipo dedicado'],
                ['end' => 98, 'suffix' => '%', 'label' => 'Clientes satisfechos'],
            ]],

            // ===================== SERVICIOS =====================
            ['key' => 'services.tag', 'group' => 'services', 'type' => 'text', 'label' => 'Etiqueta de sección', 'value' => 'Servicios'],
            ['key' => 'services.title', 'group' => 'services', 'type' => 'text', 'label' => 'Título', 'value' => 'Soluciones expertas para cualquier'],
            ['key' => 'services.title_highlight', 'group' => 'services', 'type' => 'text', 'label' => 'Título (destacado)', 'value' => 'problema de plagas'],
            ['key' => 'services.cta_text', 'group' => 'services', 'type' => 'text', 'label' => 'Texto CTA final', 'value' => '¿Listo para un hogar libre de plagas?'],
            ['key' => 'services.cta_link_text', 'group' => 'services', 'type' => 'text', 'label' => 'Texto enlace CTA', 'value' => '¡Contáctenos hoy!'],
            ['key' => 'services.items', 'group' => 'services', 'type' => 'json', 'label' => 'Tarjetas de servicios', 'value' => [
                ['img' => '/images/servicio-fumigacion-comercial.webp', 'alt' => 'Fumigación comercial para negocios', 'icon' => 'Factory', 'category' => 'Comercial', 'title' => 'Soluciones comerciales para el control de plagas', 'desc' => 'Protección completa para restaurantes, oficinas y negocios. Cumplimos normas de salubridad — garantía de resultados.'],
                ['img' => '/images/servicio-exterminacion-termitas.webp', 'alt' => 'Exterminación profesional de termitas y roedores', 'icon' => 'Rat', 'category' => 'Termitas & Roedores', 'title' => 'Control de termitas y roedores', 'desc' => 'Eliminación total y prevención de daños estructurales. Si vuelven, volvemos gratis — garantía escrita.'],
                ['img' => '/images/servicio-hogar-inteligente.webp', 'alt' => 'Control de plagas en espacios exteriores', 'icon' => 'Snail', 'category' => 'Exteriores', 'title' => 'Control de plagas en exteriores', 'desc' => 'Disfrute su patio sin mosquitos, hormigas ni plagas. Tratamientos ecológicos seguros para mascotas.'],
                ['img' => '/images/servicio-control-exteriores.webp', 'alt' => 'Protección completa del hogar contra plagas', 'icon' => 'HouseWifi', 'category' => 'Residencial', 'title' => 'Protección residencial completa', 'desc' => 'Hogar seguro para su familia — sin cucarachas, hormigas ni chinches. Inspección gratuita incluida.'],
                ['img' => '/images/servicio-fumigacion-residencial.webp', 'alt' => 'Protección completa del hogar contra plagas', 'icon' => 'Building2', 'category' => 'Hogar', 'title' => 'Control de plagas residenciales', 'desc' => 'Protección completa para su hogar — cucarachas, hormigas y más. Visitas programadas o servicio único. Sin compromiso.'],
            ]],

            // ===================== PORTAFOLIO =====================
            ['key' => 'portfolio.tag', 'group' => 'portfolio', 'type' => 'text', 'label' => 'Etiqueta de sección', 'value' => 'Portafolio'],
            ['key' => 'portfolio.title', 'group' => 'portfolio', 'type' => 'text', 'label' => 'Título', 'value' => 'Descubra nuestra trayectoria comprobada en'],
            ['key' => 'portfolio.title_highlight', 'group' => 'portfolio', 'type' => 'text', 'label' => 'Título (destacado)', 'value' => 'soluciones para eliminar plagas'],
            ['key' => 'portfolio.desc', 'group' => 'portfolio', 'type' => 'textarea', 'label' => 'Descripción', 'value' => 'Vea nuestro trabajo real en acción. Casos de control de plagas en hogares, negocios y exteriores, directo desde nuestro TikTok.'],
            ['key' => 'portfolio.tiktok_user', 'group' => 'portfolio', 'type' => 'text', 'label' => 'Usuario de TikTok', 'value' => 'bolivian_pest'],
            ['key' => 'portfolio.videos', 'group' => 'portfolio', 'type' => 'json', 'label' => 'Videos de TikTok', 'value' => [
                ['id' => '7471413968603467063', 'label' => 'Control en hogares'],
                ['id' => '7470332967810780422', 'label' => 'Plagas en negocios'],
                ['id' => '7468916199028509957', 'label' => 'Control en exteriores'],
            ]],

            // ===================== NUESTROS SERVICIOS (why features) =====================
            ['key' => 'ourfeatures.tag', 'group' => 'ourfeatures', 'type' => 'text', 'label' => 'Etiqueta de sección', 'value' => 'Nuestros servicios'],
            ['key' => 'ourfeatures.title', 'group' => 'ourfeatures', 'type' => 'text', 'label' => 'Título', 'value' => 'Su socio de confianza en'],
            ['key' => 'ourfeatures.title_highlight', 'group' => 'ourfeatures', 'type' => 'text', 'label' => 'Título (destacado)', 'value' => 'control de plagas'],
            ['key' => 'ourfeatures.text', 'group' => 'ourfeatures', 'type' => 'textarea', 'label' => 'Texto descriptivo', 'value' => 'Entendemos lo frustrantes y molestas que pueden ser las plagas, por eso nos comprometemos a brindar soluciones rápidas, confiables y efectivas. Contamos con un equipo de expertos certificados, métodos ecológicos y una atención al cliente inigualable.'],
            ['key' => 'ourfeatures.image', 'group' => 'ourfeatures', 'type' => 'image', 'label' => 'Imagen lateral', 'value' => '/images/features/seis.webp'],
            ['key' => 'ourfeatures.badge_years', 'group' => 'ourfeatures', 'type' => 'text', 'label' => 'Insignia (años)', 'value' => '29+ años'],
            ['key' => 'ourfeatures.badge_text', 'group' => 'ourfeatures', 'type' => 'text', 'label' => 'Insignia (texto)', 'value' => 'protegiendo Bolivia'],
            ['key' => 'ourfeatures.items', 'group' => 'ourfeatures', 'type' => 'json', 'label' => 'Características', 'value' => [
                ['icon' => 'Siren', 'iconWrap' => 'bg-red-50 text-red-600 dark:bg-red-950/40 dark:text-red-400', 'title' => 'Servicios de emergencia', 'desc' => 'Estamos disponibles las 24 horas para atender su emergencia, incluso feriados.'],
                ['icon' => 'Settings', 'iconWrap' => 'bg-blue-50 text-blue-600 dark:bg-blue-950/40 dark:text-blue-400', 'title' => 'Tratamientos personalizados', 'desc' => 'Cada propiedad es única, por lo que diseñamos soluciones específicas para su caso.'],
                ['icon' => 'ShieldCheck', 'iconWrap' => 'bg-green-50 text-green-600 dark:bg-green-950/40 dark:text-green-400', 'title' => 'Profesionales certificados', 'desc' => 'Nuestro equipo está altamente capacitado, certificado y con años de experiencia comprobada.'],
                ['icon' => 'BadgeCheck', 'iconWrap' => 'bg-emerald-50 text-emerald-600 dark:bg-emerald-950/40 dark:text-emerald-400', 'title' => 'Resultados garantizados', 'desc' => 'Respaldamos nuestro trabajo con garantía por escrito. Si vuelven, ¡volvemos gratis!'],
            ]],

            // ===================== POR QUÉ ELEGIRNOS =====================
            ['key' => 'why.tag', 'group' => 'why', 'type' => 'text', 'label' => 'Etiqueta de sección', 'value' => '¿Por qué elegirnos?'],
            ['key' => 'why.title', 'group' => 'why', 'type' => 'text', 'label' => 'Título', 'value' => '¿Qué nos convierte en la mejor opción'],
            ['key' => 'why.title_highlight', 'group' => 'why', 'type' => 'text', 'label' => 'Título (destacado)', 'value' => 'para usted?'],
            ['key' => 'why.desc', 'group' => 'why', 'type' => 'textarea', 'label' => 'Descripción', 'value' => '29 años de experiencia en Bolivia. Técnicos certificados SENASAG. Productos ecológicos seguros para niños y mascotas. Atención 24/7.'],
            ['key' => 'why.cta_text', 'group' => 'why', 'type' => 'textarea', 'label' => 'Texto botón CTA', 'value' => '¡Haga su cita hoy! Disponible de inmediato — Inspección gratuita sin compromiso'],
            ['key' => 'why.cta_link', 'group' => 'why', 'type' => 'url', 'label' => 'Enlace botón CTA', 'value' => 'mailto:info@bolivianpest.com'],

            // ===================== FAQ =====================
            ['key' => 'faq.tag', 'group' => 'faq', 'type' => 'text', 'label' => 'Etiqueta de sección', 'value' => 'Preguntas frecuentes'],
            ['key' => 'faq.title', 'group' => 'faq', 'type' => 'text', 'label' => 'Título', 'value' => 'Encuentre respuestas útiles a sus dudas sobre'],
            ['key' => 'faq.title_highlight', 'group' => 'faq', 'type' => 'text', 'label' => 'Título (destacado)', 'value' => 'el control de plagas'],
            ['key' => 'faq.image_1', 'group' => 'faq', 'type' => 'image', 'label' => 'Imagen decorativa 1', 'value' => '/images/questions/doce.webp'],
            ['key' => 'faq.image_2', 'group' => 'faq', 'type' => 'image', 'label' => 'Imagen decorativa 2', 'value' => '/images/questions-equipo-profesional.webp'],
            ['key' => 'faq.image_3', 'group' => 'faq', 'type' => 'image', 'label' => 'Imagen decorativa 3', 'value' => '/images/questions/seis.webp'],
            ['key' => 'faq.items', 'group' => 'faq', 'type' => 'json', 'label' => 'Preguntas y respuestas', 'value' => [
                ['question' => '¿Qué tipos de plagas tratan?', 'answer' => '<p>Controlamos una amplia variedad de plagas, incluyendo <strong>roedores, hormigas, cucarachas, termitas, chinches, mosquitos, arañas y fauna silvestre.</strong></p><p>Aplicamos métodos específicos según la especie para garantizar resultados efectivos.</p>'],
                ['question' => '¿Son seguros sus métodos de control de plagas para mis mascotas?', 'answer' => '<p>Sí. Todos nuestros productos y procedimientos están certificados y son seguros para mascotas y personas, siempre y cuando se sigan las indicaciones del técnico. Utilizamos productos de baja toxicidad, aprobados por <strong>SENASAG</strong>, y aplicados bajo estándares profesionales para evitar cualquier riesgo. Además, brindamos instrucciones claras sobre el tiempo de reingreso y cuidados posteriores para garantizar la seguridad de tus animales domésticos.</p>'],
                ['question' => '¿Con qué frecuencia debo programar los servicios?', 'answer' => '<p>La frecuencia depende del tipo de plaga y del entorno:</p><ul><li><strong>Hogares:</strong> cada 3 a 4 meses suele ser suficiente para mantener un ambiente libre de plagas.</li><li><strong>Comercios:</strong> recomendamos un servicio mensual o bimensual, especialmente si hay almacenamiento de alimentos.</li><li><strong>Industrias y restaurantes:</strong> servicios mensuales o incluso quincenales, de acuerdo con normas de salubridad.</li></ul><p>Nuestros técnicos evalúan tu caso y generan un plan personalizado según el nivel de infestación y las características del lugar.</p>'],
                ['question' => '¿Ofrecen servicios de control de plagas de emergencia?', 'answer' => '<p>Sí, contamos con servicios de emergencia para infestaciones severas o situaciones que requieren atención inmediata, como:</p><ul><li><strong>Nidos de avispas</strong></li><li><strong>Presencia elevada de roedores</strong></li><li><strong>Brotes de cucarachas en cocinas o negocios</strong></li><li><strong>Invasión de chinches</strong></li><li><strong>Plagas que afecten la operación de tu empresa</strong></li></ul><p>Atendemos en el menor tiempo posible para controlar rápidamente el problema y evitar riesgos para tu salud o tu actividad comercial.</p>'],
                ['question' => '¿Cómo sé si tengo una plaga?', 'answer' => '<p>Algunas señales comunes incluyen:</p><ul><li><strong>Excrementos pequeños o manchas oscuras (roedores, cucarachas).</strong></li><li><strong>Ruidos dentro de paredes o techos.</strong></li><li><strong>Olores fuertes o desagradables, especialmente en cocinas o depósitos.</strong></li><li><strong>Huecos o montículos en madera o suelo (termitas).</strong></li></ul><p>Si notas cualquiera de estos signos, lo ideal es solicitar una inspección profesional, ya que muchas plagas se esconden y solo un técnico puede detectarlas a tiempo.</p>'],
            ]],

            // ===================== CONTACTO =====================
            ['key' => 'contact.tag', 'group' => 'contact', 'type' => 'text', 'label' => 'Etiqueta de sección', 'value' => 'Contacto'],
            ['key' => 'contact.title', 'group' => 'contact', 'type' => 'text', 'label' => 'Título', 'value' => '¿Listo para un espacio libre de plagas?'],
            ['key' => 'contact.subtitle', 'group' => 'contact', 'type' => 'textarea', 'label' => 'Subtítulo', 'value' => 'Escríbanos y le respondemos a la brevedad. Inspección sin compromiso — atención en toda Bolivia.'],
            ['key' => 'contact.phone', 'group' => 'contact', 'type' => 'text', 'label' => 'Teléfono / WhatsApp (texto)', 'value' => '+591 76738282'],
            ['key' => 'contact.email', 'group' => 'contact', 'type' => 'text', 'label' => 'Correo electrónico', 'value' => 'info@bolivianpest.com'],
            ['key' => 'contact.location', 'group' => 'contact', 'type' => 'text', 'label' => 'Ubicación (texto)', 'value' => 'La Paz, Bolivia'],
            ['key' => 'contact.location_link', 'group' => 'contact', 'type' => 'url', 'label' => 'Enlace de ubicación (Maps)', 'value' => 'https://maps.app.goo.gl/jUskCwmwawdAVt9A8?g_st=awb'],
            ['key' => 'contact.schedule', 'group' => 'contact', 'type' => 'text', 'label' => 'Horario de atención', 'value' => '24/7 · los 365 días'],
            ['key' => 'contact.whatsapp_number', 'group' => 'contact', 'type' => 'text', 'label' => 'Número WhatsApp (solo dígitos)', 'value' => '59176738282'],
            ['key' => 'contact.map_embed', 'group' => 'contact', 'type' => 'textarea', 'label' => 'URL del mapa embebido (iframe src)', 'value' => 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d239.0954346072869!2d-68.12636138046955!3d-16.499473655781642!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x915f210059ecf6c7%3A0xca158fcbb8866f59!2sBolivianPest!5e0!3m2!1ses!2sbo!4v1772571664453!5m2!1ses!2sbo'],
            ['key' => 'contact.form_title', 'group' => 'contact', 'type' => 'text', 'label' => 'Título del formulario', 'value' => 'Solicite su cotización'],
            ['key' => 'contact.form_subtitle', 'group' => 'contact', 'type' => 'text', 'label' => 'Subtítulo del formulario', 'value' => 'Complete el formulario y le escribimos por WhatsApp.'],

            // ===================== REDES SOCIALES =====================
            ['key' => 'social.facebook', 'group' => 'social', 'type' => 'url', 'label' => 'Facebook', 'value' => 'https://www.facebook.com/p/Bolivian-Pest-Higiene-Ambiental-61572172198692/'],
            ['key' => 'social.instagram', 'group' => 'social', 'type' => 'url', 'label' => 'Instagram', 'value' => 'https://www.instagram.com/bolivian_pest?igsh=MTF4dHFjZGoxMzlocQ=='],
            ['key' => 'social.tiktok', 'group' => 'social', 'type' => 'url', 'label' => 'TikTok', 'value' => 'https://www.tiktok.com/@bolivian_pest'],
            ['key' => 'social.whatsapp', 'group' => 'social', 'type' => 'url', 'label' => 'WhatsApp', 'value' => 'https://wa.me/59176738282'],

            // ===================== SEO =====================
            ['key' => 'seo.title', 'group' => 'seo', 'type' => 'text', 'label' => 'Meta título', 'value' => 'Control de Plagas en Bolivia | Bolivian Pest - Fumigación Profesional'],
            ['key' => 'seo.description', 'group' => 'seo', 'type' => 'textarea', 'label' => 'Meta descripción', 'value' => 'Bolivian Pest: Servicios profesionales de control de plagas en Bolivia. Fumigación, exterminación de termitas, roedores y más. Atención 24/7. Contacto: +591 76738282'],
            ['key' => 'seo.keywords', 'group' => 'seo', 'type' => 'textarea', 'label' => 'Palabras clave', 'value' => 'control de plagas Bolivia, fumigación La Paz, exterminación de termitas, exterminador roedores, servicios de fumigación Bolivia, empresa control plagas'],
            ['key' => 'seo.og_image', 'group' => 'seo', 'type' => 'image', 'label' => 'Imagen para compartir (OG)', 'value' => '/images/og-image.svg'],
        ];
    }
}
