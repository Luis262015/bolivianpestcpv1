-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 24-06-2026 a las 09:50:21
-- Versión del servidor: 11.4.12-MariaDB
-- Versión de PHP: 8.4.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bolivianpest_sc`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `acciones`
--

CREATE TABLE `acciones` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `empresa_id` bigint(20) UNSIGNED NOT NULL,
  `almacen_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `descripcion` text NOT NULL,
  `costo` double NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `accion_imagenes`
--

CREATE TABLE `accion_imagenes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `accion_id` bigint(20) UNSIGNED NOT NULL,
  `imagen` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `accion_productos`
--

CREATE TABLE `accion_productos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `accion_id` bigint(20) UNSIGNED NOT NULL,
  `producto_id` bigint(20) UNSIGNED NOT NULL,
  `unidad_id` bigint(20) UNSIGNED NOT NULL,
  `cantidad` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `accion_trampas`
--

CREATE TABLE `accion_trampas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `accion_id` bigint(20) UNSIGNED NOT NULL,
  `trampa_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `agendas`
--

CREATE TABLE `agendas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `date` date NOT NULL,
  `hour` time DEFAULT NULL,
  `color` varchar(255) NOT NULL DEFAULT 'bg-blue-500',
  `status` enum('pendiente','postergado','completado') NOT NULL DEFAULT 'pendiente',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `agendas`
--

INSERT INTO `agendas` (`id`, `user_id`, `title`, `date`, `hour`, `color`, `status`, `created_at`, `updated_at`) VALUES
(1, 2, 'RANSA SANTA CRUZ COCHABAMBA', '2026-06-01', NULL, 'bg-red-500', 'completado', '2026-05-31 19:58:19', '2026-06-02 00:16:47'),
(5, 2, 'RANSA LP', '2026-06-05', NULL, 'bg-red-500', 'pendiente', '2026-05-31 19:59:57', '2026-05-31 19:59:57'),
(6, 2, 'LAQ  FAGAL  FUMIGACION', '2026-06-05', NULL, 'bg-yellow-500', 'pendiente', '2026-05-31 20:00:32', '2026-05-31 20:00:32'),
(7, 2, 'RANSA FUMIGACION COCHA SANTA', '2026-06-06', NULL, 'bg-red-500', 'pendiente', '2026-05-31 20:00:57', '2026-05-31 20:00:57'),
(9, 2, 'CBES DESRATIZACION', '2026-06-08', NULL, 'bg-purple-500', 'pendiente', '2026-05-31 20:01:45', '2026-05-31 20:01:45'),
(10, 2, 'WINDSOR DESRATIZACION', '2026-06-08', NULL, 'bg-green-500', 'pendiente', '2026-05-31 20:02:17', '2026-05-31 20:02:17'),
(11, 2, 'RANSA INSECTOCUTORES', '2026-06-09', NULL, 'bg-red-500', 'pendiente', '2026-05-31 20:02:37', '2026-05-31 20:02:37'),
(12, 2, 'MARECBOL DESRATIZACION', '2026-06-09', NULL, 'bg-yellow-500', 'pendiente', '2026-05-31 20:02:52', '2026-05-31 20:02:52'),
(13, 2, 'CASCADA VISCACHANI', '2026-06-10', NULL, 'bg-teal-500', 'pendiente', '2026-05-31 20:03:18', '2026-05-31 20:03:18'),
(14, 2, 'CASCADA VF  LLOJETA', '2026-06-11', NULL, 'bg-teal-500', 'pendiente', '2026-05-31 20:03:36', '2026-05-31 20:03:36'),
(15, 2, 'CASCADA EL ALTO', '2026-06-12', NULL, 'bg-teal-500', 'pendiente', '2026-05-31 20:03:52', '2026-05-31 20:03:52'),
(17, 2, 'WINDSOR   FUMIGACION', '2026-06-13', NULL, 'bg-green-500', 'pendiente', '2026-05-31 20:04:19', '2026-05-31 20:04:19'),
(18, 2, 'RANSA COCHA  SANTA CRUZ', '2026-06-15', NULL, 'bg-red-500', 'pendiente', '2026-05-31 20:04:48', '2026-05-31 20:04:48'),
(19, 2, 'AIDISA LP', '2026-06-15', NULL, 'bg-yellow-500', 'pendiente', '2026-05-31 20:05:03', '2026-05-31 20:05:03'),
(21, 2, 'LAQ FAGAL', '2026-06-15', NULL, 'bg-blue-500', 'pendiente', '2026-05-31 20:05:44', '2026-05-31 20:05:44'),
(22, 2, 'RANSA INSECTOCUTOR', '2026-06-16', NULL, 'bg-red-500', 'pendiente', '2026-05-31 20:06:01', '2026-05-31 20:06:01'),
(23, 2, 'FARMEDICAL', '2026-06-17', NULL, 'bg-purple-500', 'pendiente', '2026-05-31 20:06:16', '2026-05-31 20:06:16'),
(24, 2, 'INTERQUIMICA', '2026-06-18', NULL, 'bg-green-500', 'pendiente', '2026-05-31 20:06:28', '2026-05-31 20:06:28'),
(25, 2, 'ENALPAZ', '2026-06-19', NULL, 'bg-pink-600', 'pendiente', '2026-05-31 20:06:43', '2026-05-31 20:06:43'),
(26, 2, 'RANSA LP', '2026-06-20', NULL, 'bg-red-500', 'pendiente', '2026-05-31 20:06:59', '2026-05-31 20:06:59'),
(27, 2, 'QUIMIZA SANTA CRUZ', '2026-06-20', NULL, 'bg-yellow-500', 'pendiente', '2026-05-31 20:07:15', '2026-05-31 20:07:15'),
(28, 2, 'BQ SRL LP', '2026-06-20', NULL, 'bg-blue-500', 'pendiente', '2026-05-31 20:07:35', '2026-05-31 20:07:35'),
(29, 2, 'OMNILIFE  SANTA TARIJA', '2026-06-20', NULL, 'bg-green-500', 'pendiente', '2026-05-31 20:07:58', '2026-05-31 20:07:58'),
(30, 2, 'WINDSOR', '2026-06-22', NULL, 'bg-green-500', 'pendiente', '2026-05-31 20:08:15', '2026-05-31 20:08:15'),
(31, 2, 'CBES', '2026-06-22', NULL, 'bg-purple-500', 'pendiente', '2026-05-31 20:08:28', '2026-05-31 20:08:28'),
(32, 2, 'RANSA INSECTOCUTOR', '2026-06-23', NULL, 'bg-red-500', 'pendiente', '2026-05-31 20:08:46', '2026-05-31 20:08:46'),
(33, 2, 'EXPRINTER', '2026-06-23', NULL, 'bg-yellow-500', 'pendiente', '2026-05-31 20:08:59', '2026-05-31 20:08:59'),
(34, 2, 'CASCADA VISCACHANI', '2026-06-24', NULL, 'bg-teal-500', 'pendiente', '2026-05-31 20:09:26', '2026-05-31 20:09:26'),
(36, 2, 'MARECBOL', '2026-06-24', NULL, 'bg-yellow-500', 'pendiente', '2026-05-31 20:10:17', '2026-05-31 20:10:17'),
(37, 2, 'CASCADA VF  LLOJETA', '2026-06-25', NULL, 'bg-teal-500', 'pendiente', '2026-05-31 20:10:32', '2026-05-31 20:10:32'),
(38, 2, 'CASCADA EA', '2026-06-26', NULL, 'bg-teal-500', 'pendiente', '2026-05-31 20:10:44', '2026-05-31 20:10:44'),
(39, 2, 'FARMACIA CHAVEZ ST.', '2026-06-27', NULL, 'bg-purple-500', 'pendiente', '2026-05-31 20:11:07', '2026-05-31 20:11:07'),
(40, 2, 'BOLIVIAN FOOD  LP', '2026-06-27', NULL, 'bg-pink-600', 'pendiente', '2026-05-31 20:11:25', '2026-05-31 20:11:25'),
(42, 2, 'AIDISA LP', '2026-06-29', NULL, 'bg-yellow-500', 'pendiente', '2026-05-31 20:12:13', '2026-05-31 20:12:13'),
(44, 2, 'AIDISA FUMIGACION MASCOTA', '2026-06-06', NULL, 'bg-yellow-500', 'pendiente', '2026-06-01 14:02:11', '2026-06-01 14:02:11'),
(45, 2, 'AIDISA FUMIGACION MASCOTA', '2026-06-13', NULL, 'bg-yellow-500', 'pendiente', '2026-06-01 14:02:33', '2026-06-01 14:02:33'),
(46, 2, 'AIDISA FUMIGACION MASCOTA', '2026-06-20', NULL, 'bg-yellow-500', 'pendiente', '2026-06-01 14:02:52', '2026-06-01 14:02:52'),
(47, 2, 'AIDISA  FUMIGACION MASCOTA', '2026-06-27', NULL, 'bg-yellow-500', 'pendiente', '2026-06-01 14:03:14', '2026-06-01 14:03:14'),
(48, 2, 'RANSA INSECTO SANTA CRUZ', '2026-06-11', NULL, 'bg-pink-600', 'pendiente', '2026-06-01 14:03:57', '2026-06-01 14:03:57'),
(49, 2, 'RANSA INSECTO SANTA CRUZ', '2026-06-18', NULL, 'bg-pink-600', 'pendiente', '2026-06-01 14:04:16', '2026-06-01 14:04:16'),
(50, 2, 'RANSA INSECTO SANTA CRUZ', '2026-06-25', NULL, 'bg-pink-600', 'pendiente', '2026-06-01 14:06:57', '2026-06-01 14:06:57'),
(51, 2, 'FERIADO CORPUS CRISTI', '2026-06-04', NULL, 'bg-red-500', 'pendiente', '2026-06-01 14:07:42', '2026-06-01 14:07:42'),
(52, 2, 'RANSA INSECTOCUTORES SANTA CRUZ', '2026-06-04', NULL, 'bg-pink-600', 'pendiente', '2026-06-01 14:08:33', '2026-06-01 14:08:33'),
(53, 2, 'AIDISA PAITITI CORONADO', '2026-06-08', NULL, 'bg-blue-500', 'pendiente', '2026-06-01 14:12:24', '2026-06-01 14:12:24'),
(54, 2, 'AIDISA OFICINAS SATN CRUZ', '2026-06-22', NULL, 'bg-red-500', 'pendiente', '2026-06-01 14:13:06', '2026-06-01 14:13:06'),
(55, 2, 'BOLIVIAN FOOD SANTA CRUZ', '2026-06-27', NULL, 'bg-green-500', 'pendiente', '2026-06-01 14:14:05', '2026-06-01 14:14:05'),
(56, 2, 'INTERQUIMICA  FUMIGACION', '2026-06-02', NULL, 'bg-pink-600', 'pendiente', '2026-06-02 00:17:20', '2026-06-02 00:17:20'),
(58, 2, 'CASCADA DESRATIZACION', '2026-06-02', NULL, 'bg-yellow-500', 'pendiente', '2026-06-02 00:18:11', '2026-06-02 00:18:11'),
(59, 2, 'URKUPIÑA    DESRATIZACION', '2026-06-01', NULL, 'bg-teal-500', 'completado', '2026-06-02 00:18:40', '2026-06-02 00:18:48'),
(60, 2, 'HOSPITAL TUNARI CNS', '2026-06-03', '16:30:00', 'bg-purple-500', 'pendiente', '2026-06-02 00:19:17', '2026-06-02 00:20:21'),
(62, 2, 'TAHUAMANU FUMIGACION', '2026-06-01', NULL, 'bg-yellow-500', 'completado', '2026-06-02 09:50:18', '2026-06-02 09:50:24'),
(63, 2, 'ALCON CERTIFICADO', '2026-06-01', NULL, 'bg-blue-500', 'completado', '2026-06-02 09:51:08', '2026-06-02 09:51:16'),
(64, 2, 'FUMIGACION CAJA DE HERRAMIENTAS SANTA CRUZ', '2026-06-01', NULL, 'bg-red-500', 'completado', '2026-06-02 12:52:11', '2026-06-02 12:52:11'),
(65, 2, 'FUMIGACION DIFUNTO CUARTO', '2026-06-02', '18:00:00', 'bg-green-500', 'pendiente', '2026-06-02 13:39:40', '2026-06-02 13:39:40'),
(66, 2, 'NOVOPHARMA', '2026-06-03', NULL, 'bg-pink-600', 'pendiente', '2026-06-02 13:40:00', '2026-06-02 13:40:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `almacenes`
--

CREATE TABLE `almacenes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `empresa_id` bigint(20) UNSIGNED NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `encargado` varchar(255) DEFAULT NULL,
  `telefono` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `ciudad` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `almacenes`
--

INSERT INTO `almacenes` (`id`, `empresa_id`, `nombre`, `direccion`, `encargado`, `telefono`, `email`, `ciudad`, `created_at`, `updated_at`) VALUES
(1, 1, 'PLANTA VILLA FATIMA', 'CALLE SANTA ROSA NRO. 471 VILLA FATIMA', 'FRANKLIN PEREZ', '70103966', 'jessica_escobar@lacascada.com.bo', 'LA PAZ', '2026-04-29 17:59:23', '2026-04-29 17:59:23'),
(4, 2, 'PLANTA    EL   ALTO', 'CALLE LOS CEDROS  CAMINO A VIACHA KM 5 S/N', 'PABLO ECHENIQUE', '69722610', 'jessica_escobar@lacascada.com.bo', 'EL ALTO', '2026-04-29 18:53:56', '2026-04-29 18:53:56'),
(5, 3, 'ALMACEN DISTRIBUCION LLOJETA', 'BAJO LLOJETA CALLE LAS PALMAS NRO. 2000', 'MIGUEL VARGAS', '69722558', 'jessica_escobar@lacascada.com.bo', 'LA  PAZ', '2026-04-29 19:49:13', '2026-04-29 19:49:13'),
(7, 4, 'PLANTA VISCACHANI', 'VISCACHANI', 'ALDO COLPARI', '69722555', 'jessica_escobar@lacascada.com.bo', 'LA  PAZ', '2026-04-29 20:03:22', '2026-04-29 20:03:22'),
(8, 5, 'EL ALTO', 'Av. LAS AMERICAS', 'ROBERTO CARLOS JULIAN', '70525322', 'mmariscal@quimiza.com', 'CIUDAD DE EL ALTO', '2026-05-09 01:57:04', '2026-05-09 01:57:04'),
(9, 6, 'ILLIMANI', 'AV. ROQUE DALTON Nro.130 ZONA 29 DE JUNIO SENKATA CIUDAD DE EL ALTO', 'DRA. KIMBERLY CONTRERAS CANAZA', '776922359', 'rfarmaceuticobol@ransa.net', 'LA PAZ', '2026-06-06 10:36:22', '2026-06-06 10:36:22'),
(12, 9, 'CEDI   EL ALTO', 'ROSAS PAMPA  CIUDAD DE EL ALTO', 'ANTONIO  ALVAREZ', '79698267', 'aalvarez@bolivianfoods.com.bo', 'LA PAZ', '2026-06-06 14:14:49', '2026-06-06 14:14:49'),
(13, 10, 'CEDI   SANTA CRUZ', 'AVENIDA AL NORTE CIUDAD DE SANTA CRUZ', 'ANTONIO  ALVAREZ', '79698267', 'aalvarez@bolivianfoods.com.bo', 'SANTA CRUZ', '2026-06-09 15:12:03', '2026-06-09 15:12:03'),
(14, 11, 'CIMFA', 'villa tunari', 'Lic. Mauricio Maydana', '61281922', 'williammaydanaarevalo@gmail.com', 'el alto', '2026-06-10 12:50:12', '2026-06-10 12:50:12');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `almacen_areas`
--

CREATE TABLE `almacen_areas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `almacen_id` bigint(20) UNSIGNED NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `area` int(11) NOT NULL,
  `visitas` int(11) NOT NULL,
  `precio` double NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `almacen_areas`
--

INSERT INTO `almacen_areas` (`id`, `almacen_id`, `descripcion`, `area`, `visitas`, `precio`, `total`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, 2000, 4, 0.4, 3200, '2026-04-29 17:59:23', '2026-04-29 21:10:30'),
(4, 4, NULL, 8900, 4, 0.4, 14240, '2026-04-29 18:53:56', '2026-04-29 18:53:56'),
(5, 5, NULL, 2990, 4, 0.4, 4784, '2026-04-29 19:49:13', '2026-04-29 21:11:36'),
(7, 7, NULL, 2700, 4, 0.4, 4320, '2026-04-29 20:03:22', '2026-04-29 20:03:22'),
(8, 8, NULL, 500, 2, 1, 1000, '2026-05-09 01:57:04', '2026-05-09 01:57:04'),
(9, 9, NULL, 9216, 7, 0.3, 19353.6, '2026-06-06 10:36:22', '2026-06-06 10:36:22'),
(12, 12, NULL, 600, 3, 2, 3600, '2026-06-06 14:14:49', '2026-06-06 14:14:49'),
(13, 13, NULL, 760, 12, 1.3, 11856, '2026-06-09 15:12:03', '2026-06-09 15:12:03'),
(14, 14, NULL, 300, 4, 10, 12000, '2026-06-10 12:50:12', '2026-06-10 12:50:12');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `almacen_trampas`
--

CREATE TABLE `almacen_trampas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `almacen_id` bigint(20) UNSIGNED NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `cantidad` int(11) NOT NULL,
  `visitas` int(11) NOT NULL,
  `precio` double NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `almacen_trampas`
--

INSERT INTO `almacen_trampas` (`id`, `almacen_id`, `descripcion`, `cantidad`, `visitas`, `precio`, `total`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, 78, 24, 6, 11232, '2026-04-29 17:59:23', '2026-04-29 21:10:30'),
(4, 4, NULL, 130, 24, 6, 18720, '2026-04-29 18:53:56', '2026-04-29 18:53:56'),
(5, 5, NULL, 42, 24, 6, 6048, '2026-04-29 19:49:13', '2026-04-29 21:11:36'),
(7, 7, NULL, 29, 24, 6, 4176, '2026-04-29 20:03:22', '2026-04-29 20:03:22'),
(8, 8, NULL, 17, 6, 29.42, 3000.84, '2026-05-09 01:57:04', '2026-05-09 01:57:04'),
(9, 9, NULL, 32, 14, 12, 5376, '2026-06-06 10:36:22', '2026-06-06 10:36:22'),
(12, 12, NULL, 60, 12, 10, 7200, '2026-06-06 14:14:49', '2026-06-06 14:14:49'),
(13, 13, NULL, 40, 24, 12, 11520, '2026-06-09 15:12:03', '2026-06-09 15:12:03'),
(14, 14, NULL, 11, 7, 50, 3850, '2026-06-10 12:50:12', '2026-06-10 12:50:12');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `almancen_insectocutores`
--

CREATE TABLE `almancen_insectocutores` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `almacen_id` bigint(20) UNSIGNED NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `cantidad` int(11) NOT NULL,
  `visitas` int(11) NOT NULL,
  `precio` double NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `almancen_insectocutores`
--

INSERT INTO `almancen_insectocutores` (`id`, `almacen_id`, `descripcion`, `cantidad`, `visitas`, `precio`, `total`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, 1, 24, 10, 240, '2026-04-29 17:59:23', '2026-04-29 17:59:23'),
(4, 4, NULL, 1, 24, 10, 240, '2026-04-29 18:53:56', '2026-04-29 18:53:56'),
(5, 5, NULL, 0, 0, 0, 0, '2026-04-29 19:49:13', '2026-04-29 19:49:13'),
(7, 7, NULL, 1, 24, 10, 240, '2026-04-29 20:03:22', '2026-04-29 20:03:22'),
(8, 8, NULL, 0, 0, 0, 0, '2026-05-09 01:57:04', '2026-05-09 01:57:04'),
(9, 9, NULL, 3, 28, 50, 1400, '2026-06-06 10:36:22', '2026-06-10 13:10:15'),
(12, 12, NULL, 2, 12, 100, 1200, '2026-06-06 14:14:49', '2026-06-06 14:14:49'),
(13, 13, NULL, 4, 24, 26, 624, '2026-06-09 15:12:03', '2026-06-09 15:12:03'),
(14, 14, NULL, 4, 7, 21.43, 150.01, '2026-06-10 12:50:12', '2026-06-10 12:50:12');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aplicaciones`
--

CREATE TABLE `aplicaciones` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `seguimiento_id` bigint(20) UNSIGNED NOT NULL,
  `pisos` int(11) NOT NULL,
  `paredes_internas` int(11) NOT NULL,
  `ambientes` int(11) NOT NULL,
  `internas` int(11) NOT NULL,
  `externas` int(11) NOT NULL,
  `trampas` int(11) NOT NULL,
  `trampas_cambiar` int(11) NOT NULL,
  `roedores` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `aplicaciones`
--

INSERT INTO `aplicaciones` (`id`, `seguimiento_id`, `pisos`, `paredes_internas`, `ambientes`, `internas`, `externas`, `trampas`, `trampas_cambiar`, `roedores`, `created_at`, `updated_at`) VALUES
(1, 1, 0, 0, 0, 71, 7, 78, 78, 0, '2026-05-03 13:53:25', '2026-05-03 13:53:25'),
(2, 2, 0, 0, 0, 0, 0, 0, 0, 0, '2026-05-03 14:09:03', '2026-05-03 14:09:03'),
(3, 3, 0, 0, 0, 71, 7, 78, 78, 0, '2026-05-04 12:05:30', '2026-05-04 12:05:30'),
(4, 4, 0, 0, 0, 0, 0, 0, 0, 0, '2026-05-04 12:20:03', '2026-05-04 12:20:03'),
(5, 5, 0, 0, 0, 71, 7, 78, 78, 0, '2026-05-04 13:57:30', '2026-05-04 13:57:30'),
(6, 6, 0, 0, 0, 0, 0, 0, 0, 0, '2026-05-04 14:00:50', '2026-05-04 14:00:50'),
(7, 7, 0, 0, 0, 71, 7, 78, 78, 0, '2026-05-04 14:20:46', '2026-05-04 14:20:46'),
(8, 8, 0, 0, 0, 0, 0, 0, 0, 0, '2026-05-04 14:23:56', '2026-05-04 14:23:56'),
(9, 9, 0, 0, 0, 71, 7, 78, 78, 0, '2026-05-04 17:19:59', '2026-05-04 17:19:59'),
(10, 10, 0, 0, 0, 0, 0, 0, 0, 0, '2026-05-04 17:50:41', '2026-05-04 17:50:41'),
(11, 11, 0, 0, 0, 71, 7, 78, 78, 0, '2026-05-04 18:18:37', '2026-05-04 18:18:37'),
(12, 12, 0, 0, 0, 0, 0, 0, 0, 0, '2026-05-04 18:22:44', '2026-05-04 18:22:44'),
(13, 13, 0, 0, 0, 71, 7, 78, 78, 0, '2026-05-04 19:18:51', '2026-05-04 19:18:51'),
(14, 14, 0, 0, 0, 0, 0, 0, 0, 0, '2026-05-04 19:22:33', '2026-05-04 19:22:33'),
(15, 15, 0, 0, 0, 71, 7, 78, 78, 0, '2026-05-04 19:37:27', '2026-05-04 19:37:27'),
(16, 16, 0, 0, 0, 0, 0, 0, 0, 0, '2026-05-04 19:46:21', '2026-05-04 19:46:21'),
(17, 17, 0, 0, 0, 71, 7, 78, 78, 0, '2026-05-07 19:09:44', '2026-05-07 19:09:44'),
(18, 18, 0, 0, 0, 0, 0, 0, 0, 0, '2026-05-07 19:57:07', '2026-05-07 19:57:07'),
(19, 19, 0, 0, 0, 0, 0, 0, 0, 0, '2026-05-08 19:34:05', '2026-05-08 19:34:05'),
(20, 20, 0, 0, 0, 75, 55, 130, 130, 0, '2026-05-08 19:49:07', '2026-05-08 19:49:07'),
(21, 21, 0, 0, 0, 17, 0, 17, 17, 1, '2026-05-10 18:39:08', '2026-05-10 18:39:08'),
(22, 22, 1, 16, 4, 0, 0, 0, 0, 0, '2026-05-10 18:49:38', '2026-05-10 18:49:38'),
(23, 23, 0, 0, 0, 32, 10, 42, 42, 0, '2026-05-13 13:50:25', '2026-05-13 13:50:25'),
(24, 24, 0, 0, 0, 55, 75, 130, 130, 0, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(25, 25, 0, 0, 0, 75, 55, 130, 130, 0, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(26, 26, 0, 0, 0, 75, 55, 130, 130, 0, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(27, 27, 0, 0, 0, 75, 55, 130, 130, 0, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(28, 28, 0, 0, 0, 75, 55, 130, 130, 0, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(29, 29, 0, 0, 0, 32, 10, 42, 42, 0, '2026-05-18 14:55:42', '2026-05-18 14:55:42'),
(30, 30, 0, 0, 0, 32, 10, 42, 42, 0, '2026-05-18 15:56:33', '2026-05-18 15:56:33'),
(31, 31, 0, 0, 0, 32, 10, 42, 42, 0, '2026-05-18 16:34:39', '2026-05-18 16:34:39'),
(32, 32, 0, 0, 0, 32, 10, 42, 42, 0, '2026-05-18 20:43:18', '2026-05-18 20:43:18'),
(33, 33, 0, 0, 0, 32, 10, 42, 42, 0, '2026-05-18 20:57:53', '2026-05-18 20:57:53'),
(34, 34, 0, 0, 0, 32, 10, 42, 42, 0, '2026-05-18 21:18:23', '2026-05-18 21:18:23'),
(35, 35, 0, 0, 0, 32, 10, 42, 42, 0, '2026-05-18 21:31:23', '2026-05-18 21:31:23'),
(36, 36, 0, 0, 0, 21, 8, 29, 29, 0, '2026-05-18 22:35:45', '2026-05-18 22:35:45'),
(37, 37, 0, 0, 0, 21, 8, 29, 29, 0, '2026-05-18 23:21:01', '2026-05-18 23:21:01'),
(38, 38, 0, 0, 0, 21, 8, 29, 29, 0, '2026-05-18 23:36:03', '2026-05-18 23:36:03'),
(39, 39, 0, 0, 0, 21, 8, 29, 29, 0, '2026-05-18 23:43:16', '2026-05-18 23:43:16'),
(40, 40, 0, 0, 0, 21, 8, 29, 29, 1, '2026-05-18 23:50:52', '2026-05-19 21:17:31'),
(41, 41, 0, 0, 0, 21, 8, 29, 29, 0, '2026-05-18 23:57:41', '2026-05-18 23:57:41'),
(42, 42, 0, 0, 0, 21, 8, 29, 29, 0, '2026-05-19 00:04:18', '2026-05-19 00:04:18'),
(43, 43, 13, 26, 13, 0, 0, 0, 0, 0, '2026-05-19 19:50:31', '2026-05-19 19:50:31'),
(44, 44, 13, 26, 13, 0, 0, 0, 0, 0, '2026-05-19 19:54:03', '2026-05-19 19:54:03'),
(45, 45, 0, 0, 0, 0, 0, 0, 0, 0, '2026-05-19 20:05:04', '2026-05-19 20:05:04'),
(46, 46, 0, 0, 0, 0, 0, 0, 0, 0, '2026-05-19 20:08:03', '2026-05-19 20:08:03'),
(47, 47, 0, 0, 0, 0, 0, 0, 0, 0, '2026-05-19 20:10:27', '2026-05-19 20:10:27'),
(48, 48, 0, 0, 0, 0, 0, 0, 0, 0, '2026-05-19 20:21:06', '2026-05-19 20:21:06'),
(49, 49, 0, 0, 0, 0, 0, 0, 0, 0, '2026-05-19 20:23:15', '2026-05-19 20:23:15'),
(50, 50, 0, 0, 0, 0, 0, 0, 0, 0, '2026-05-19 20:30:11', '2026-05-19 20:30:11'),
(51, 51, 0, 0, 0, 0, 0, 0, 0, 0, '2026-05-19 20:33:30', '2026-05-19 20:33:30'),
(52, 52, 0, 0, 0, 71, 7, 78, 78, 0, '2026-05-21 15:57:44', '2026-05-21 15:57:44'),
(53, 53, 0, 0, 0, 0, 0, 0, 0, 0, '2026-05-21 16:01:20', '2026-05-21 16:01:20'),
(54, 54, 0, 0, 0, 32, 10, 42, 42, 0, '2026-05-21 18:13:30', '2026-05-21 18:13:30'),
(55, 55, 0, 0, 0, 75, 55, 130, 130, 0, '2026-05-22 15:53:09', '2026-05-22 15:53:09'),
(56, 56, 0, 0, 0, 0, 0, 0, 0, 0, '2026-05-22 15:56:04', '2026-05-22 15:56:04'),
(57, 57, 0, 0, 0, 22, 10, 32, 32, 0, '2026-06-06 17:55:47', '2026-06-06 17:55:47'),
(58, 58, 1, 4, 1, 0, 0, 0, 0, 0, '2026-06-06 17:59:07', '2026-06-06 17:59:07'),
(59, 59, 0, 0, 0, 0, 0, 0, 0, 0, '2026-06-06 18:03:17', '2026-06-06 18:03:17'),
(60, 60, 0, 0, 0, 0, 11, 11, 11, 0, '2026-06-10 13:26:01', '2026-06-10 13:26:01'),
(61, 61, 30, 12, 30, 0, 0, 0, 0, 0, '2026-06-10 13:45:59', '2026-06-10 13:45:59'),
(62, 62, 0, 0, 0, 0, 0, 0, 0, 0, '2026-06-10 14:06:42', '2026-06-10 14:06:42'),
(63, 63, 0, 0, 0, 71, 7, 78, 78, 0, '2026-06-11 16:28:22', '2026-06-11 16:28:22'),
(64, 64, 0, 0, 0, 0, 0, 0, 0, 0, '2026-06-11 16:31:29', '2026-06-11 16:31:29'),
(65, 65, 0, 0, 0, 32, 10, 42, 42, 0, '2026-06-11 18:31:40', '2026-06-11 18:31:40'),
(66, 66, 0, 0, 0, 75, 55, 130, 130, 0, '2026-06-12 15:08:16', '2026-06-12 15:08:16'),
(67, 67, 0, 0, 0, 0, 0, 0, 0, 0, '2026-06-12 21:55:02', '2026-06-12 21:55:02'),
(68, 68, 3, 12, 3, 0, 0, 0, 0, 0, '2026-06-14 00:16:41', '2026-06-14 00:16:41'),
(69, 69, 0, 0, 0, 22, 10, 32, 32, 0, '2026-06-19 18:55:41', '2026-06-19 18:55:41'),
(70, 70, 0, 0, 0, 0, 0, 0, 0, 0, '2026-06-19 19:02:45', '2026-06-19 19:02:45'),
(71, 71, 1, 32, 8, 0, 0, 0, 0, 0, '2026-06-22 16:03:53', '2026-06-22 16:03:53');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `biologicos`
--

CREATE TABLE `biologicos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `biologicos`
--

INSERT INTO `biologicos` (`id`, `nombre`, `created_at`, `updated_at`) VALUES
(1, 'Adulto', '2026-04-13 13:42:19', '2026-04-13 13:42:19'),
(2, 'Huevo', '2026-04-13 13:42:19', '2026-04-13 13:42:19'),
(3, 'Larva', '2026-04-13 13:42:19', '2026-04-13 13:42:19'),
(4, 'Ninfa', '2026-04-13 13:42:19', '2026-04-13 13:42:19'),
(5, 'Pupa', '2026-04-13 13:42:19', '2026-04-13 13:42:19'),
(6, 'Otros', '2026-04-13 13:42:19', '2026-04-13 13:42:19');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `buffer_productos`
--

CREATE TABLE `buffer_productos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `producto_id` bigint(20) UNSIGNED NOT NULL,
  `cantidad` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `buffer_productos`
--

INSERT INTO `buffer_productos` (`id`, `producto_id`, `cantidad`, `created_at`, `updated_at`) VALUES
(1, 5, 1, '2026-05-03 13:53:25', '2026-05-03 13:53:25'),
(2, 2, 73, '2026-05-04 12:05:30', '2026-06-19 18:55:41'),
(3, 1, 4, '2026-05-19 19:50:31', '2026-06-14 00:16:41');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `cache`
--

INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('bolivianpest-cache-015953ae8be0cbf8d82405752c23922a', 'i:1;', 1778613507),
('bolivianpest-cache-015953ae8be0cbf8d82405752c23922a:timer', 'i:1778613507;', 1778613507),
('bolivianpest-cache-05aa689665a6c3ad371de368c0dc76ed', 'i:1;', 1777636406),
('bolivianpest-cache-05aa689665a6c3ad371de368c0dc76ed:timer', 'i:1777636406;', 1777636406),
('bolivianpest-cache-068c60fb3fc0659e06b20ec89664d9c2', 'i:1;', 1778079162),
('bolivianpest-cache-068c60fb3fc0659e06b20ec89664d9c2:timer', 'i:1778079162;', 1778079162),
('bolivianpest-cache-094333ac63e94d496aeb7e5a57b2422a', 'i:1;', 1778253245),
('bolivianpest-cache-094333ac63e94d496aeb7e5a57b2422a:timer', 'i:1778253245;', 1778253245),
('bolivianpest-cache-0c967b5a1c644f01ffcfc85708a7ca03', 'i:1;', 1778274368),
('bolivianpest-cache-0c967b5a1c644f01ffcfc85708a7ca03:timer', 'i:1778274368;', 1778274368),
('bolivianpest-cache-15574a430dce08216586573eabbee1e5', 'i:1;', 1779203299),
('bolivianpest-cache-15574a430dce08216586573eabbee1e5:timer', 'i:1779203299;', 1779203299),
('bolivianpest-cache-217d408fcb242f3d168ae381b136ac6d', 'i:1;', 1781627305),
('bolivianpest-cache-217d408fcb242f3d168ae381b136ac6d:timer', 'i:1781627305;', 1781627305),
('bolivianpest-cache-2806dfacaee277ee3c1182cdc4142763', 'i:1;', 1780763633),
('bolivianpest-cache-2806dfacaee277ee3c1182cdc4142763:timer', 'i:1780763633;', 1780763633),
('bolivianpest-cache-2bd96e957af080dc3a3fd756d2e3d53f', 'i:1;', 1780327538),
('bolivianpest-cache-2bd96e957af080dc3a3fd756d2e3d53f:timer', 'i:1780327538;', 1780327538),
('bolivianpest-cache-2d4618f7edd20c2163d0631fc310ef85', 'i:1;', 1781898353),
('bolivianpest-cache-2d4618f7edd20c2163d0631fc310ef85:timer', 'i:1781898353;', 1781898353),
('bolivianpest-cache-2dd12b068a56923e27bdecb240a967fe', 'i:1;', 1782253106),
('bolivianpest-cache-2dd12b068a56923e27bdecb240a967fe:timer', 'i:1782253106;', 1782253106),
('bolivianpest-cache-2e4f7669bb28cda196b7d6dd67ef11e6', 'i:1;', 1778260801),
('bolivianpest-cache-2e4f7669bb28cda196b7d6dd67ef11e6:timer', 'i:1778260801;', 1778260801),
('bolivianpest-cache-30651b5b6d8a4f1a6574ad111be676fb', 'i:3;', 1778293833),
('bolivianpest-cache-30651b5b6d8a4f1a6574ad111be676fb:timer', 'i:1778293833;', 1778293833),
('bolivianpest-cache-38ec15953b77be5d2b09fa1201874531', 'i:2;', 1778261603),
('bolivianpest-cache-38ec15953b77be5d2b09fa1201874531:timer', 'i:1778261603;', 1778261603),
('bolivianpest-cache-5455fb8303af8a6b672a09c6fab50df7', 'i:1;', 1778027543),
('bolivianpest-cache-5455fb8303af8a6b672a09c6fab50df7:timer', 'i:1778027543;', 1778027543),
('bolivianpest-cache-54e6e89ab6df900516f81602a7bc9003', 'i:5;', 1778078927),
('bolivianpest-cache-54e6e89ab6df900516f81602a7bc9003:timer', 'i:1778078927;', 1778078927),
('bolivianpest-cache-55f353bb0e849196e0f6d0a2fa57ce1b', 'i:1;', 1778459986),
('bolivianpest-cache-55f353bb0e849196e0f6d0a2fa57ce1b:timer', 'i:1778459986;', 1778459986),
('bolivianpest-cache-6af5130be7768d6e942ecb99de329bc2', 'i:2;', 1779285795),
('bolivianpest-cache-6af5130be7768d6e942ecb99de329bc2:timer', 'i:1779285795;', 1779285795),
('bolivianpest-cache-6c6253c61eedc2d8e2b598c192ad87fe', 'i:1;', 1778506297),
('bolivianpest-cache-6c6253c61eedc2d8e2b598c192ad87fe:timer', 'i:1778506297;', 1778506297),
('bolivianpest-cache-7d0f72f5e8ef0afb7379de833e5f9db4', 'i:1;', 1776260696),
('bolivianpest-cache-7d0f72f5e8ef0afb7379de833e5f9db4:timer', 'i:1776260696;', 1776260696),
('bolivianpest-cache-80c25ede6acb0be64082c320a72a8304', 'i:1;', 1779382377),
('bolivianpest-cache-80c25ede6acb0be64082c320a72a8304:timer', 'i:1779382377;', 1779382377),
('bolivianpest-cache-81a3e17d9fa37e1a480d1619dea2d550', 'i:1;', 1777821178),
('bolivianpest-cache-81a3e17d9fa37e1a480d1619dea2d550:timer', 'i:1777821178;', 1777821178),
('bolivianpest-cache-90e12e0258da157788c159128647fd4b', 'i:1;', 1779145229),
('bolivianpest-cache-90e12e0258da157788c159128647fd4b:timer', 'i:1779145229;', 1779145229),
('bolivianpest-cache-9acdf23a7a091a3118d8f0841f528405', 'i:1;', 1778687574),
('bolivianpest-cache-9acdf23a7a091a3118d8f0841f528405:timer', 'i:1778687574;', 1778687574),
('bolivianpest-cache-a42710b44ba01987ea8f14f638bab2ba', 'i:3;', 1781267886),
('bolivianpest-cache-a42710b44ba01987ea8f14f638bab2ba:timer', 'i:1781267886;', 1781267886),
('bolivianpest-cache-a8ea529c78b20c6bba2885cbd53b9baf', 'i:1;', 1779468642),
('bolivianpest-cache-a8ea529c78b20c6bba2885cbd53b9baf:timer', 'i:1779468642;', 1779468642),
('bolivianpest-cache-ab24290774a809a0a0c309d5389375e0', 'i:1;', 1780494621),
('bolivianpest-cache-ab24290774a809a0a0c309d5389375e0:timer', 'i:1780494621;', 1780494621),
('bolivianpest-cache-adim@adim.com|177.222.112.216', 'i:1;', 1777636406),
('bolivianpest-cache-adim@adim.com|177.222.112.216:timer', 'i:1777636406;', 1777636406),
('bolivianpest-cache-adim@admin.com|177.222.112.216', 'i:3;', 1778293833),
('bolivianpest-cache-adim@admin.com|177.222.112.216:timer', 'i:1778293833;', 1778293833),
('bolivianpest-cache-admin@admin.com|189.28.89.127', 'i:3;', 1781267886),
('bolivianpest-cache-admin@admin.com|189.28.89.127:timer', 'i:1781267886;', 1781267886),
('bolivianpest-cache-b5dae317c839e904812ac4263a1a9c46', 'i:1;', 1778508404),
('bolivianpest-cache-b5dae317c839e904812ac4263a1a9c46:timer', 'i:1778508404;', 1778508404),
('bolivianpest-cache-b6db9f623997a984fca2716dea2ff1f5', 'i:1;', 1781097733),
('bolivianpest-cache-b6db9f623997a984fca2716dea2ff1f5:timer', 'i:1781097733;', 1781097733),
('bolivianpest-cache-b973ec5653b4b0c64549a2f4a9211292', 'i:3;', 1778683230),
('bolivianpest-cache-b973ec5653b4b0c64549a2f4a9211292:timer', 'i:1778683230;', 1778683230),
('bolivianpest-cache-bc5b95e361f76d73b548855a530bdbbf', 'i:3;', 1781304522),
('bolivianpest-cache-bc5b95e361f76d73b548855a530bdbbf:timer', 'i:1781304522;', 1781304522),
('bolivianpest-cache-bcda8ba14702a936a86c58ac90357387', 'i:1;', 1778643542),
('bolivianpest-cache-bcda8ba14702a936a86c58ac90357387:timer', 'i:1778643542;', 1778643542),
('bolivianpest-cache-bd86049de4959c154b488e7865f04fac', 'i:1;', 1781279888),
('bolivianpest-cache-bd86049de4959c154b488e7865f04fac:timer', 'i:1781279888;', 1781279888),
('bolivianpest-cache-be62b8ecf799c83bba5d54a30e0c7fa9', 'i:1;', 1778194381),
('bolivianpest-cache-be62b8ecf799c83bba5d54a30e0c7fa9:timer', 'i:1778194381;', 1778194381),
('bolivianpest-cache-cdc043ccf776ce4def3f5613d3fb12a7', 'i:1;', 1781899064),
('bolivianpest-cache-cdc043ccf776ce4def3f5613d3fb12a7:timer', 'i:1781899064;', 1781899064),
('bolivianpest-cache-d053096853369b1a838c2916e56d92b2', 'i:1;', 1778285347),
('bolivianpest-cache-d053096853369b1a838c2916e56d92b2:timer', 'i:1778285347;', 1778285347),
('bolivianpest-cache-d16680ebbc8bd946eaeb663d2196bf9d', 'i:1;', 1782231711),
('bolivianpest-cache-d16680ebbc8bd946eaeb663d2196bf9d:timer', 'i:1782231711;', 1782231711),
('bolivianpest-cache-d2d6874d472bb6a1a7842b486f7b9b8c', 'i:1;', 1782147433),
('bolivianpest-cache-d2d6874d472bb6a1a7842b486f7b9b8c:timer', 'i:1782147433;', 1782147433),
('bolivianpest-cache-dc63d5e1a7440c369dd1d5cc2a3dcdbc', 'i:1;', 1778164208),
('bolivianpest-cache-dc63d5e1a7440c369dd1d5cc2a3dcdbc:timer', 'i:1778164208;', 1778164208),
('bolivianpest-cache-ddd190e3923c23efe4505e45a617323a', 'i:1;', 1777937948),
('bolivianpest-cache-ddd190e3923c23efe4505e45a617323a:timer', 'i:1777937948;', 1777937948),
('bolivianpest-cache-de4791e66fedfc050915e664a4eec010', 'i:1;', 1778186834),
('bolivianpest-cache-de4791e66fedfc050915e664a4eec010:timer', 'i:1778186834;', 1778186834),
('bolivianpest-cache-e56ba7095089ab392e776306a4aaaae8', 'i:1;', 1781281559),
('bolivianpest-cache-e56ba7095089ab392e776306a4aaaae8:timer', 'i:1781281559;', 1781281559),
('bolivianpest-cache-eb6f868bcb9928199794b9c355eaaefb', 'i:1;', 1777689621),
('bolivianpest-cache-eb6f868bcb9928199794b9c355eaaefb:timer', 'i:1777689621;', 1777689621),
('bolivianpest-cache-edd7bead9e3589d46c6853b4d2913d83', 'i:2;', 1778683309),
('bolivianpest-cache-edd7bead9e3589d46c6853b4d2913d83:timer', 'i:1778683309;', 1778683309),
('bolivianpest-cache-f52f3ab1e975682126a5e09c90a0a961', 'i:2;', 1778158171),
('bolivianpest-cache-f52f3ab1e975682126a5e09c90a0a961:timer', 'i:1778158171;', 1778158171),
('bolivianpest-cache-fbd1f9f124368684c1127f8bdfd07c7e', 'i:1;', 1781197998),
('bolivianpest-cache-fbd1f9f124368684c1127f8bdfd07c7e:timer', 'i:1781197998;', 1781197998),
('bolivianpest-cache-fed55005054b860caa09a13550ab2f48', 'i:1;', 1779467960),
('bolivianpest-cache-fed55005054b860caa09a13550ab2f48:timer', 'i:1779467960;', 1779467960),
('bolivianpest-cache-fernadezhenry623@gmail.com|189.28.73.167', 'i:3;', 1778683230),
('bolivianpest-cache-fernadezhenry623@gmail.com|189.28.73.167:timer', 'i:1778683230;', 1778683230),
('bolivianpest-cache-fernandezhenrry623@gmail.com|177.222.112.216', 'i:5;', 1778078927),
('bolivianpest-cache-fernandezhenrry623@gmail.com|177.222.112.216:timer', 'i:1778078927;', 1778078927),
('bolivianpest-cache-islaluis25@gmail.com|190.109.225.22', 'i:2;', 1778261603),
('bolivianpest-cache-islaluis25@gmail.com|190.109.225.22:timer', 'i:1778261603;', 1778261603),
('bolivianpest-cache-islaluis25@gmail.com|190.109.225.31', 'i:1;', 1776260696),
('bolivianpest-cache-islaluis25@gmail.com|190.109.225.31:timer', 'i:1776260696;', 1776260696),
('bolivianpest-cache-uno@uno.com|177.222.49.62', 'i:2;', 1779285795),
('bolivianpest-cache-uno@uno.com|177.222.49.62:timer', 'i:1779285795;', 1779285795);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `certificados`
--

CREATE TABLE `certificados` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `empresa_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `qrcode` varchar(255) DEFAULT NULL,
  `firmadigital` varchar(255) DEFAULT NULL,
  `titulo` varchar(255) DEFAULT NULL,
  `establecimiento` varchar(255) DEFAULT NULL,
  `actividad` varchar(255) DEFAULT NULL,
  `validez` varchar(255) DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `diagnostico` varchar(255) DEFAULT NULL,
  `condicion` varchar(255) DEFAULT NULL,
  `trabajo` varchar(255) DEFAULT NULL,
  `plaguicidas` varchar(255) DEFAULT NULL,
  `registro` varchar(255) DEFAULT NULL,
  `area` varchar(255) DEFAULT NULL,
  `acciones` varchar(255) DEFAULT NULL,
  `ingredientes` varchar(255) DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `certificados`
--

INSERT INTO `certificados` (`id`, `empresa_id`, `user_id`, `qrcode`, `firmadigital`, `titulo`, `establecimiento`, `actividad`, `validez`, `direccion`, `diagnostico`, `condicion`, `trabajo`, `plaguicidas`, `registro`, `area`, `acciones`, `ingredientes`, `logo`, `created_at`, `updated_at`) VALUES
(4, 1, 2, '', '', 'CONTROL DE VECTORES', 'LA CASCADA LTDA VILLA FATIMA', 'EMPRESA ELABORADORA Y COMERCIALIZADORA DE BEBIDAS', '90 DIAS HABILES DEL 4/04/20206 AL 04/07/2026', 'CALLE SANTA ROSA NRO. 471 VILLA FATIMA CIUDAD DE LA PAZ', 'NO EXISTE PRESENCIA DE VECTORES CONTAMINANTES CONTROL PREVENTIVO', 'CUMPLE CON TODAS LAS CONDICIONES DE HIGIENE Y LIMPIEZA', 'DESINFECCION, DESINSECTACION, DESRATIZACION', 'INSECTICIDA FENDONA, DESINFECTANTE\r\nHDQ NEUTRAL, RODENTICIDA KLERAT', 'INSO NRO. BR1212ILSC02, AGEMED NRO.\r\n2020/2026, INSO NRO. BR1020ROAB01', '5000 M2', 'CONTINUAR CON EL ORDEN Y LIMPIEZA', 'ALFACIPERMETRINA, AMONIO CUATERNARIO,  BRODIFACOUM', 'images/certificado/69f55c6b176d7_la-cascada-seeklogo.png', '2026-04-04 03:00:00', '2026-05-02 01:07:39'),
(5, 2, 2, '', '', 'CONTROL DE VECTORES', 'LA CASCADA LTDA', 'EMPRESA ELABORADORA Y COMERCIALIZADORA DE BEBIDAS', '90 DIAS HABILES DEL 04-04-2026 AL 04-07-2026', 'CALLE LOS CEDROS CAMINO A VICHA KM5 S/N CIUDAD DE EL ALTO', 'NO EXISTE PRESENCIA DE VECTORES CONTAMINANTES CONTROL PREVENTIVO', 'CUMPLE CON TODAS LAS CONDICIONES SANITARIAS', 'DESINFECCION, DESINSECTACION, DESRATIZACION', 'DESINFECTANTE HDQ NEUTRAL, INSECTICIDA FENDONA, RODENTICIDA  KLERAT', 'INSO: BR1212ILSC02, AGEMED 2020/2028, INSO BR 1020 ROAB01.', '10000 M2', 'CONTINUAR CON EL ORDEN Y LIMPIEZA', 'AMONIO CUATERNARIO, ALFACIPERMETRINA, BRODIFACOUM', 'images/certificado/69f77abf670ce_CASCADA IMAGEN.webp', '2026-04-04 03:00:00', '2026-05-03 15:41:35'),
(6, 3, 2, '', '', 'CONTROL DE VECTORES', 'LA CASCADA LTDA', 'EMPRESA ELABORADORA Y COMERCIALIZADORA DE BEBIDAS', '90 DIAS HABILES DEL 04-04-2026 AL 04-07-2026', 'BAJO LLOJETA CALLE LAS PALMAS NRO. 2000 CIUDAD DE LA PAZ', 'NO EXISTE PRESENCIA DE VECTORES CONTAMINANTES CONTROL PREVENTIVO', 'CUMPLE CON TODAS LAS CONDICIONES SANITARIAS', 'DESINSECTACION, \r\nDESINFECCION,\r\n DESRATIZACION.', 'INSECTICIDA FENDONA, \r\nDESINFECTANTE,\r\nRODENTICIDA  KLERAT', 'INSO: BR1212ILSC02,\r\nAGEMED 2020/2026,\r\nINSO: BR1020ROAB01', '5000', 'CONTINUAR CON EL ORDEN Y LIMPIEZA', 'ALFACIPERMETRINA,\r\nAMONIO CUATERNARIO,\r\nBRODIFACOUM.', 'images/certificado/69f77d62d1d6f_CASCADA IMAGEN.webp', '2026-04-04 03:00:00', '2026-05-03 15:52:50'),
(7, 4, 2, '', '', 'CONTROL DE VECTORES', 'LA CASCADA LTDA', 'EMPRESA ELAORADORA Y COMERCIALIZADORA DE BEBIDAS', '90 DIAS HABILES DEL 04-04-2026 AL 04-07-2026', 'VISCACHANI', 'NO EXISTE PRESENCIA DE VECTORES CONTAMINANTES CONTROL PREVENTIVO', 'CUMPLE CON TODAS LAS CONDICIONES SANITARIAS', 'DESINSECTACION,\r\nDESINFECCION,\r\nDESRATIZACION.', 'INSECTICIDA FENDONA,\r\nDESINFECTANTE HDQ NEUTRAL,\r\nRODENTICIDA KLERAT.', 'INSO: BL1212ILSCO2,\r\nAGEMED 2020/2026,\r\nINSO: BR1020ROAB01.', '5000 M2', 'CONTINUAR CON EL ORDEN Y LIMPIEZA', 'ALFACIPERMETRINA,\r\nAMONIO CUATERNARIO,\r\nBRODIFACOUM', 'images/certificado/69f77f2588cf9_CASCADA IMAGEN.webp', '2026-04-04 03:00:00', '2026-05-03 16:00:21'),
(9, 1, 2, '', '', 'CONTROL DE VECTORES', 'LA CASCADA LTDA', 'EMPRESA ELABORADORA Y COMERCIALIZADORA DE BEBIDAS', '90 DIAS HABILES DEL 4/01/2026 AL 4/04/2026', 'CALLE SANTA ROSA NRO. 471 VILLA FATIMA CIUDAD DE LA PAZ', 'NO EXISTE PRESENCIA DE VECTORES CONTAMINANTES CONTROL PREVENTIVO', 'CUMPLE CON TODAS LAS CONDICIONES DE HIGIENE Y LIMPIEZA', 'DESINFECCION,\r\nDESINSECTACION,\r\nDESRATIZACION', 'INSECTICIDA FENDONA,\r\nDESINFECTANTE HDQ NEUTRAL,\r\nRODENTICIDA KLERAT.', 'INSO NRO. BR1212ILSC02,\r\nAGEMED NRO. 2020/2026,\r\nINSO NRO. BR1020ROAB01.', '5000 M2', 'CONTINUAR CON EL ORDEN Y LIMPIEZA', 'ALFACIPERMETRINA,\r\nAMONIO CUATERNARIO,\r\nBRODIFACOUM.', 'images/certificado/69fa6ed76f8f8_CASCADA IMAGEN.webp', '2026-01-04 03:00:00', '2026-05-05 21:27:35'),
(10, 2, 2, '', '', 'CONTROL DE VECTORES', 'LA CASCADA LTDA', 'EMPRESA ELABORADORA Y COMERCIALIZADORA DE BEBIDAS', '90 DIAS HABILES DEL 4/01/2026 AL 4/04/2026', 'CALLE LOS CEDROS CAMINO A VICHA KM5 S/N CIUDAD DE EL ALTO', 'NO EXISTE PRESENCIA DE VECTORES CONTAMINANTES CONTROL PREVENTIVO', 'CUMPLE CON TODAS LAS CONDICIONES SANITARIAS', 'DESINFECCION,\r\nDESINSECTACION,\r\nDESRATIZACION.', 'DESINFECTANTE HDQ NEUTRAL,\r\nINSECTICIDA FENDONA,\r\nRODENTICIDA KLERA.', 'INSO: BR1212ILSC02,\r\nAGEMED 2020/2028,\r\nINSO BR 1020 ROAB01.', '10000 M2', 'CONTINUAR CON EL OREDEN Y LIMPIEZA', 'AMONIO CUATERNARIO,\r\nALFACIPERMETRINA,\r\nBRODIFACOUM.', 'images/certificado/69fa7038361e2_CASCADA IMAGEN.webp', '2026-01-04 03:00:00', '2026-05-05 21:33:28'),
(11, 3, 2, '', '', 'CONTROL DE VECTORES', 'LA CASCADA LTDA', 'EMPRESA ELABORADORA Y COMERCIALIZADORA DE BEBIDAS', '90 DIAS HABILES DEL 04-01-2026 AL 04-04-2026', 'BAJO LLOJETA CALLE LAS PALMAS NRO. 2000 CIUDAD DE LA PAZ', 'NO EXISTE PRESENCIA DE VECTORES CONTAMINANTES CONTROL PREVENTIVO', 'CUMPLE CON TODAS LAS CONDICIONES SANITARIAS', 'DESINSECTACION,\r\nDESINFECCION,\r\nDESRATIZACION.', 'INSECTICIDA FENDONA,\r\nDESINFECTANTE,\r\nRODENTICIDA KLERAT.', 'INSO: BR1212ILSC02,\r\nAGEMED 2020/2026,\r\nINSO: BR1020ROAB01.', '5000 M2', 'CONTINUAR CON EL OREDEN Y LIMPIEZA', 'ALFACIPERMETRINA,\r\nAMONIO CUATERNARIO,\r\nBRODIFACOUM.', 'images/certificado/69fa716f068c1_CASCADA IMAGEN.webp', '2026-01-04 03:00:00', '2026-05-05 21:38:39'),
(12, 4, 2, '', '', 'CONTROL DE VECTORES', 'LA CASCADA LTDA', 'EMPRESA ELAORADORA Y COMERCIALIZADORA DE BEBIDAS', '90 DIAS HABILES DEL 04-01-2026 AL 04-04-2026', 'VISCACHANI', 'NO EXISTE PRESENCIA DE VECTORES CONTAMINANTES CONTROL PREVENTIVO', 'CUMPLE CON TODAS LAS CONDICIONES SANITARIAS', 'DESINSECTACION,\r\nDESINFECCION,\r\nDESRATIZACION.', 'INSECTICIDA FENDONA,\r\nDESINFECTANTE HDQ NEUTRAL,\r\nRODENTICIDA KLERAT.', 'INSO: BL1212ILSCO2,\r\nAGEMED 2020/2026,\r\nINSO: BR1020ROAB01.', '5000 M2', 'CONTINUAR CON EL ORDEN Y LIMPIEZA', 'ALFACIPERMETRINA,\r\nAMONIO CUATERNARIO,\r\nBRODIFACOUM.', 'images/certificado/69fa72b260c41_CASCADA IMAGEN.webp', '2026-01-01 03:00:00', '2026-05-05 21:44:02'),
(15, 6, 2, '', '', 'CONTROL DE VECTORES', 'RANSA BODEGA ILLIMANI', 'EMPRESA ALMACENADOR DE PRODUCTOS', '30 DIAS HABILES DEL 05/06/2026  AL  05/07/2026', 'AV. ROQUE DALTON NRO. 130 ZONA 29 DE JUNIO SENKATA CIUDAD DE EL ALTO', 'NO EXISTE PRESENCIA DE VECTORES CONTAMINANTES  CONTROL  PREVENTIVO', 'BUENA LIMPIEZA', 'DESINSECTACION   (X)', 'FENDONA  6 SC', 'INSO  NRO. BR1212ILSCO2', '9000', 'CONTINUAR CON EL OREDEN Y LIMPIEZA', 'ALFACIPERMETRINA  ( INSECTICIDA  PIRETROIDE)', '', '2026-06-05 03:00:00', '2026-06-06 12:15:22'),
(16, 6, 2, '', '', 'CONTROL DE VECTORES', 'RANSA  BODEGA  ILLIMANI', 'EMPRESA  ALMACENADORA  DE  PRODUCTOS', '15  DIAS HABILES DEL 05/06/2026  AL  20/06/2026', 'AV. ROQUE DALTON NRO. 130 ZONA 29 DE JUNIO SENKATA CIUDAD DE EL ALTO', 'NO EXISTE PRESENCIA DE VECTORES CONTAMINANTES CONTROL PREVENTIVO', 'BUENA  LIMPIEZA', 'DESRATIZACION', 'RODENTICIDA KLERAT', 'INSO NRO. BR1020ROAB01', '9000 M2', 'CONTINUAR CON EL ORDEN Y LIMPIEZA', 'BRODIFACOUM  ( RODENTICIDA  ANTICUAGULANTE  2DA  GENERACION )', '', '2026-06-05 03:00:00', '2026-06-06 12:19:43');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nombres` varchar(255) NOT NULL,
  `celular` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `nit` varchar(255) DEFAULT NULL,
  `razon_social` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cobrar_cuotas`
--

CREATE TABLE `cobrar_cuotas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `cuenta_cobrar_id` bigint(20) UNSIGNED NOT NULL,
  `numero_cuota` int(11) NOT NULL,
  `fecha_vencimiento` date NOT NULL,
  `monto` decimal(12,2) NOT NULL,
  `estado` enum('pendiente','pagado','vencido') NOT NULL DEFAULT 'pendiente',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cobrar_pagos`
--

CREATE TABLE `cobrar_pagos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `cuenta_cobrar_id` bigint(20) UNSIGNED NOT NULL,
  `cuota_id` bigint(20) UNSIGNED DEFAULT NULL,
  `fecha_pago` date NOT NULL,
  `monto` decimal(12,2) NOT NULL,
  `metodo_pago` varchar(255) DEFAULT NULL,
  `observacion` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compras`
--

CREATE TABLE `compras` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `proveedor_id` bigint(20) UNSIGNED DEFAULT NULL,
  `total` double NOT NULL,
  `tipo` enum('Compra','Credito','Adelanto','Anulado') NOT NULL,
  `observaciones` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `compras`
--

INSERT INTO `compras` (`id`, `user_id`, `proveedor_id`, `total`, `tipo`, `observaciones`, `created_at`, `updated_at`) VALUES
(1, 2, NULL, 2750, 'Compra', '', '2026-05-03 11:36:30', '2026-05-03 11:36:30'),
(2, 2, NULL, 10, 'Compra', '', '2026-05-04 11:33:19', '2026-05-04 11:33:19');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compra_detalles`
--

CREATE TABLE `compra_detalles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `compra_id` bigint(20) UNSIGNED NOT NULL,
  `producto_id` bigint(20) UNSIGNED DEFAULT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_compra` double NOT NULL,
  `precio_venta` double NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `compra_detalles`
--

INSERT INTO `compra_detalles` (`id`, `compra_id`, `producto_id`, `cantidad`, `precio_compra`, `precio_venta`, `descripcion`, `created_at`, `updated_at`) VALUES
(1, 1, 5, 275, 10, 15, '', '2026-05-03 11:36:30', '2026-05-03 11:36:30'),
(2, 2, 2, 1, 10, 15, '', '2026-05-04 11:33:19', '2026-05-04 11:33:19');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contactos`
--

CREATE TABLE `contactos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `almacen_id` bigint(20) UNSIGNED NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `telefono` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `ci` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contratos`
--

CREATE TABLE `contratos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `empresa_id` bigint(20) UNSIGNED NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `expiracion` date NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `contratos`
--

INSERT INTO `contratos` (`id`, `empresa_id`, `total`, `expiracion`, `created_at`, `updated_at`) VALUES
(1, 1, 14672.00, '2026-12-31', '2026-04-29 17:59:23', '2026-05-02 03:04:42'),
(2, 2, 33200.00, '2026-12-31', '2026-04-29 18:53:56', '2026-04-29 21:12:18'),
(3, 3, 10832.00, '2026-12-31', '2026-04-29 19:49:13', '2026-04-29 21:14:57'),
(4, 4, 8736.00, '2026-12-31', '2026-04-29 20:03:22', '2026-04-29 21:15:18'),
(5, 5, 4000.84, '2026-12-31', '2026-05-09 01:57:04', '2026-05-09 01:57:04'),
(6, 6, 26129.60, '2026-12-31', '2026-06-06 10:36:22', '2026-06-10 13:10:15'),
(9, 9, 12000.00, '2026-12-31', '2026-06-06 14:14:49', '2026-06-06 14:14:49'),
(10, 10, 24000.00, '2026-12-31', '2026-06-09 15:12:03', '2026-06-09 15:12:03'),
(11, 11, 16000.01, '2026-12-31', '2026-06-10 12:50:12', '2026-06-10 12:50:12');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contrato_detalles`
--

CREATE TABLE `contrato_detalles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `contrato_id` bigint(20) UNSIGNED NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `t_cantidad` varchar(255) NOT NULL,
  `t_visitas` varchar(255) NOT NULL,
  `t_precio` varchar(255) NOT NULL,
  `t_total` varchar(255) NOT NULL,
  `a_area` varchar(255) NOT NULL,
  `a_visitas` varchar(255) NOT NULL,
  `a_precio` varchar(255) NOT NULL,
  `a_total` varchar(255) NOT NULL,
  `i_cantidad` varchar(255) NOT NULL,
  `i_visitas` varchar(255) NOT NULL,
  `i_precio` varchar(255) NOT NULL,
  `i_total` varchar(255) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `contrato_detalles`
--

INSERT INTO `contrato_detalles` (`id`, `contrato_id`, `nombre`, `t_cantidad`, `t_visitas`, `t_precio`, `t_total`, `a_area`, `a_visitas`, `a_precio`, `a_total`, `i_cantidad`, `i_visitas`, `i_precio`, `i_total`, `total`, `created_at`, `updated_at`) VALUES
(1, 1, 'PLANTA VILLA FATIMA', '78', '24', '6', '11232', '2000', '4', '0.4', '3200', '1', '24', '10', '240', 0.00, '2026-04-29 17:59:23', '2026-04-29 21:10:30'),
(4, 2, 'PLANTA    EL   ALTO', '130', '24', '6', '18720', '8900', '4', '0.4', '14240', '1', '24', '10', '240', 0.00, '2026-04-29 18:53:56', '2026-04-29 18:53:56'),
(5, 3, 'ALMACEN DISTRIBUCION LLOJETA', '42', '24', '6', '6048', '2990', '4', '0.4', '4784', '0', '0', '0', '0', 0.00, '2026-04-29 19:49:13', '2026-04-29 21:11:36'),
(7, 4, 'PLANTA VISCACHANI', '29', '24', '6', '4176', '2700', '4', '0.4', '4320', '1', '24', '10', '240', 0.00, '2026-04-29 20:03:22', '2026-04-29 20:03:22'),
(8, 5, 'EL ALTO', '17', '6', '29.42', '3000.84', '500', '2', '1', '1000', '0', '0', '0', '0', 0.00, '2026-05-09 01:57:04', '2026-05-09 01:57:04'),
(9, 6, 'ILLIMANI', '32', '14', '12', '5376', '9216', '7', '0.3', '19353.6', '3', '28', '50', '1400', 0.00, '2026-06-06 10:36:22', '2026-06-10 13:10:15'),
(12, 9, 'CEDI   EL ALTO', '60', '12', '10', '7200', '600', '3', '2', '3600', '2', '12', '100', '1200', 0.00, '2026-06-06 14:14:49', '2026-06-06 14:14:49'),
(13, 10, 'CEDI   SANTA CRUZ', '40', '24', '12', '11520', '760', '12', '1.3', '11856', '4', '24', '26', '624', 0.00, '2026-06-09 15:12:03', '2026-06-09 15:12:03'),
(14, 11, 'CIMFA', '11', '7', '50', '3850', '300', '4', '10', '12000', '4', '7', '21.43', '150.01', 0.00, '2026-06-10 12:50:12', '2026-06-10 12:50:12');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cotizaciones`
--

CREATE TABLE `cotizaciones` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `telefono` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cotizacion_detalles`
--

CREATE TABLE `cotizacion_detalles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `cotizacion_id` bigint(20) UNSIGNED NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `t_cantidad` int(11) NOT NULL,
  `t_visitas` int(11) NOT NULL,
  `t_precio` decimal(10,2) NOT NULL,
  `t_total` decimal(10,2) NOT NULL,
  `a_area` int(11) NOT NULL,
  `a_visitas` int(11) NOT NULL,
  `a_precio` decimal(10,2) NOT NULL,
  `a_total` decimal(10,2) NOT NULL,
  `i_cantidad` int(11) NOT NULL,
  `i_precio` decimal(10,2) NOT NULL,
  `i_total` decimal(10,2) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cronogramas`
--

CREATE TABLE `cronogramas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `empresa_id` bigint(20) UNSIGNED NOT NULL,
  `almacen_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `tecnico_id` bigint(20) UNSIGNED NOT NULL,
  `tipo_seguimiento_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `date` date NOT NULL,
  `color` varchar(255) NOT NULL DEFAULT 'bg-blue-500',
  `status` enum('pendiente','postergado','completado') NOT NULL DEFAULT 'pendiente',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `cronogramas`
--

INSERT INTO `cronogramas` (`id`, `empresa_id`, `almacen_id`, `user_id`, `tecnico_id`, `tipo_seguimiento_id`, `title`, `date`, `color`, `status`, `created_at`, `updated_at`) VALUES
(429, 2, 4, 2, 2, 1, 'DESRATIZACION', '2026-01-13', 'bg-yellow-500', 'pendiente', '2026-04-29 21:12:18', '2026-04-29 21:12:18'),
(430, 2, 4, 2, 2, 1, 'DESRATIZACION', '2026-01-31', 'bg-yellow-500', 'completado', '2026-04-29 21:12:18', '2026-05-16 23:24:19'),
(431, 2, 4, 2, 2, 1, 'DESRATIZACION', '2026-02-13', 'bg-yellow-500', 'completado', '2026-04-29 21:12:18', '2026-05-17 02:22:50'),
(432, 2, 4, 2, 2, 1, 'DESRATIZACION', '2026-02-27', 'bg-yellow-500', 'completado', '2026-04-29 21:12:18', '2026-05-17 03:20:53'),
(433, 2, 4, 2, 2, 1, 'DESRATIZACION', '2026-03-13', 'bg-yellow-500', 'completado', '2026-04-29 21:12:18', '2026-05-17 04:16:34'),
(434, 2, 4, 2, 2, 1, 'DESRATIZACION', '2026-03-27', 'bg-yellow-500', 'completado', '2026-04-29 21:12:18', '2026-05-17 04:42:08'),
(435, 2, 4, 2, 2, 1, 'DESRATIZACION', '2026-04-10', 'bg-yellow-500', 'pendiente', '2026-04-29 21:12:18', '2026-04-29 21:12:18'),
(436, 2, 4, 2, 2, 1, 'DESRATIZACION', '2026-04-24', 'bg-yellow-500', 'pendiente', '2026-04-29 21:12:18', '2026-04-29 21:12:18'),
(437, 2, 4, 2, 2, 1, 'DESRATIZACION', '2026-05-08', 'bg-yellow-500', 'completado', '2026-04-29 21:12:18', '2026-05-08 19:49:07'),
(438, 2, 4, 2, 2, 1, 'DESRATIZACION', '2026-05-22', 'bg-yellow-500', 'completado', '2026-04-29 21:12:18', '2026-05-22 15:53:09'),
(439, 2, 4, 2, 2, 1, 'DESRATIZACION', '2026-06-12', 'bg-yellow-500', 'completado', '2026-04-29 21:12:18', '2026-06-12 15:08:16'),
(440, 2, 4, 2, 2, 1, 'DESRATIZACION', '2026-06-26', 'bg-yellow-500', 'pendiente', '2026-04-29 21:12:18', '2026-04-29 21:12:18'),
(441, 2, 4, 2, 2, 1, 'DESRATIZACION', '2026-07-10', 'bg-yellow-500', 'pendiente', '2026-04-29 21:12:18', '2026-04-29 21:12:18'),
(442, 2, 4, 2, 2, 1, 'DESRATIZACION', '2026-07-24', 'bg-yellow-500', 'pendiente', '2026-04-29 21:12:18', '2026-04-29 21:12:18'),
(443, 2, 4, 2, 2, 1, 'DESRATIZACION', '2026-08-07', 'bg-yellow-500', 'pendiente', '2026-04-29 21:12:18', '2026-04-29 21:12:18'),
(444, 2, 4, 2, 2, 1, 'DESRATIZACION', '2026-08-21', 'bg-yellow-500', 'pendiente', '2026-04-29 21:12:18', '2026-04-29 21:12:18'),
(445, 2, 4, 2, 2, 1, 'DESRATIZACION', '2026-09-11', 'bg-yellow-500', 'pendiente', '2026-04-29 21:12:18', '2026-04-29 21:12:18'),
(446, 2, 4, 2, 2, 1, 'DESRATIZACION', '2026-09-23', 'bg-yellow-500', 'pendiente', '2026-04-29 21:12:18', '2026-04-29 21:12:18'),
(447, 2, 4, 2, 2, 1, 'DESRATIZACION', '2026-10-09', 'bg-yellow-500', 'pendiente', '2026-04-29 21:12:18', '2026-04-29 21:12:18'),
(448, 2, 4, 2, 2, 1, 'DESRATIZACION', '2026-10-23', 'bg-yellow-500', 'pendiente', '2026-04-29 21:12:18', '2026-04-29 21:12:18'),
(449, 2, 4, 2, 2, 1, 'DESRATIZACION', '2026-11-13', 'bg-yellow-500', 'pendiente', '2026-04-29 21:12:18', '2026-04-29 21:12:18'),
(450, 2, 4, 2, 2, 1, 'DESRATIZACION', '2026-11-27', 'bg-yellow-500', 'pendiente', '2026-04-29 21:12:18', '2026-04-29 21:12:18'),
(451, 2, 4, 2, 2, 1, 'DESRATIZACION', '2026-12-10', 'bg-yellow-500', 'pendiente', '2026-04-29 21:12:18', '2026-04-29 21:12:18'),
(452, 2, 4, 2, 2, 1, 'DESRATIZACION', '2026-12-24', 'bg-yellow-500', 'pendiente', '2026-04-29 21:12:18', '2026-04-29 21:12:18'),
(453, 2, 4, 2, 2, 2, 'FUMIGACION', '2026-03-14', 'bg-blue-500', 'pendiente', '2026-04-29 21:12:18', '2026-04-29 21:12:18'),
(454, 2, 4, 2, 2, 2, 'FUMIGACION', '2026-06-20', 'bg-blue-500', 'completado', '2026-04-29 21:12:18', '2026-06-22 16:03:53'),
(455, 2, 4, 2, 2, 2, 'FUMIGACION', '2026-09-26', 'bg-blue-500', 'pendiente', '2026-04-29 21:12:18', '2026-04-29 21:12:18'),
(456, 2, 4, 2, 2, 2, 'FUMIGACION', '2026-12-19', 'bg-blue-500', 'pendiente', '2026-04-29 21:12:18', '2026-04-29 21:12:18'),
(457, 2, 4, 2, 2, 3, 'INSECTOCUTORES', '2026-01-13', 'bg-pink-600', 'pendiente', '2026-04-29 21:12:18', '2026-04-29 21:12:18'),
(458, 2, 4, 2, 2, 3, 'INSECTOCUTORES', '2026-01-31', 'bg-pink-600', 'pendiente', '2026-04-29 21:12:18', '2026-04-29 21:12:18'),
(459, 2, 4, 2, 2, 3, 'INSECTOCUTORES', '2026-02-13', 'bg-pink-600', 'pendiente', '2026-04-29 21:12:18', '2026-04-29 21:12:18'),
(460, 2, 4, 2, 2, 3, 'INSECTOCUTORES', '2026-02-27', 'bg-pink-600', 'pendiente', '2026-04-29 21:12:18', '2026-04-29 21:12:18'),
(461, 2, 4, 2, 2, 3, 'INSECTOCUTORES', '2026-03-13', 'bg-pink-600', 'pendiente', '2026-04-29 21:12:18', '2026-04-29 21:12:18'),
(462, 2, 4, 2, 2, 3, 'INSECTOCUTORES', '2026-03-27', 'bg-pink-600', 'pendiente', '2026-04-29 21:12:18', '2026-04-29 21:12:18'),
(463, 2, 4, 2, 2, 3, 'INSECTOCUTORES', '2026-04-10', 'bg-pink-600', 'pendiente', '2026-04-29 21:12:18', '2026-04-29 21:12:18'),
(464, 2, 4, 2, 2, 3, 'INSECTOCUTORES', '2026-04-24', 'bg-pink-600', 'pendiente', '2026-04-29 21:12:18', '2026-04-29 21:12:18'),
(465, 2, 4, 2, 2, 3, 'INSECTOCUTORES', '2026-05-08', 'bg-pink-600', 'completado', '2026-04-29 21:12:18', '2026-05-08 19:34:05'),
(466, 2, 4, 2, 2, 3, 'INSECTOCUTORES', '2026-05-22', 'bg-pink-600', 'completado', '2026-04-29 21:12:18', '2026-05-22 15:56:04'),
(467, 2, 4, 2, 2, 3, 'INSECTOCUTORES', '2026-06-12', 'bg-pink-600', 'completado', '2026-04-29 21:12:18', '2026-06-12 21:55:02'),
(468, 2, 4, 2, 2, 3, 'INSECTOCUTORES', '2026-06-26', 'bg-pink-600', 'pendiente', '2026-04-29 21:12:18', '2026-04-29 21:12:18'),
(469, 2, 4, 2, 2, 3, 'INSECTOCUTORES', '2026-07-10', 'bg-pink-600', 'pendiente', '2026-04-29 21:12:18', '2026-04-29 21:12:18'),
(470, 2, 4, 2, 2, 3, 'INSECTOCUTORES', '2026-08-21', 'bg-pink-600', 'pendiente', '2026-04-29 21:12:18', '2026-05-02 00:14:58'),
(471, 2, 4, 2, 2, 3, 'INSECTOCUTORES', '2026-07-24', 'bg-pink-600', 'pendiente', '2026-04-29 21:12:18', '2026-04-29 21:12:18'),
(472, 2, 4, 2, 2, 3, 'INSECTOCUTORES', '2026-08-07', 'bg-pink-600', 'pendiente', '2026-04-29 21:12:18', '2026-04-29 21:12:18'),
(473, 2, 4, 2, 2, 3, 'INSECTOCUTORES', '2026-09-11', 'bg-pink-600', 'pendiente', '2026-04-29 21:12:18', '2026-04-29 21:12:18'),
(474, 2, 4, 2, 2, 3, 'INSECTOCUTORES', '2026-09-25', 'bg-pink-600', 'pendiente', '2026-04-29 21:12:18', '2026-04-29 21:12:18'),
(475, 2, 4, 2, 2, 3, 'INSECTOCUTORES', '2026-10-09', 'bg-pink-600', 'pendiente', '2026-04-29 21:12:18', '2026-04-29 21:12:18'),
(476, 2, 4, 2, 2, 3, 'INSECTOCUTORES', '2026-10-23', 'bg-pink-600', 'pendiente', '2026-04-29 21:12:18', '2026-04-29 21:12:18'),
(477, 2, 4, 2, 2, 3, 'INSECTOCUTORES', '2026-11-13', 'bg-pink-600', 'pendiente', '2026-04-29 21:12:18', '2026-04-29 21:12:18'),
(478, 2, 4, 2, 2, 3, 'INSECTOCUTORES', '2026-11-27', 'bg-pink-600', 'pendiente', '2026-04-29 21:12:18', '2026-04-29 21:12:18'),
(479, 2, 4, 2, 2, 3, 'INSECTOCUTORES', '2026-12-10', 'bg-pink-600', 'pendiente', '2026-04-29 21:12:18', '2026-04-29 21:12:18'),
(480, 2, 4, 2, 2, 3, 'INSECTOCUTORES', '2026-12-24', 'bg-pink-600', 'pendiente', '2026-04-29 21:12:18', '2026-04-29 21:12:18'),
(602, 3, 5, 2, 2, 1, 'DESRATIZACION', '2026-01-13', 'bg-yellow-500', 'pendiente', '2026-04-29 21:14:57', '2026-04-29 21:14:57'),
(603, 3, 5, 2, 2, 1, 'DESRATIZACION', '2026-01-30', 'bg-yellow-500', 'completado', '2026-04-29 21:14:57', '2026-05-18 14:55:42'),
(604, 3, 5, 2, 2, 1, 'DESRATIZACION', '2026-02-12', 'bg-yellow-500', 'completado', '2026-04-29 21:14:57', '2026-05-18 15:56:33'),
(605, 3, 5, 2, 2, 1, 'DESRATIZACION', '2026-02-26', 'bg-yellow-500', 'completado', '2026-04-29 21:14:57', '2026-05-18 16:34:39'),
(606, 3, 5, 2, 2, 1, 'DESRATIZACION', '2026-03-12', 'bg-yellow-500', 'completado', '2026-04-29 21:14:57', '2026-05-18 20:43:18'),
(607, 3, 5, 2, 2, 1, 'DESRATIZACION', '2026-03-26', 'bg-yellow-500', 'completado', '2026-04-29 21:14:57', '2026-05-18 20:57:53'),
(608, 3, 5, 2, 2, 1, 'DESRATIZACION', '2026-04-09', 'bg-yellow-500', 'completado', '2026-04-29 21:14:57', '2026-05-18 21:18:23'),
(609, 3, 5, 2, 2, 1, 'DESRATIZACION', '2026-04-23', 'bg-yellow-500', 'completado', '2026-04-29 21:14:57', '2026-05-18 21:31:23'),
(610, 3, 5, 2, 2, 1, 'DESRATIZACION', '2026-05-07', 'bg-yellow-500', 'completado', '2026-04-29 21:14:57', '2026-05-13 13:50:25'),
(611, 3, 5, 2, 2, 1, 'DESRATIZACION', '2026-05-21', 'bg-yellow-500', 'completado', '2026-04-29 21:14:57', '2026-05-21 18:13:30'),
(612, 3, 5, 2, 2, 1, 'DESRATIZACION', '2026-06-11', 'bg-yellow-500', 'completado', '2026-04-29 21:14:57', '2026-06-11 18:31:40'),
(613, 3, 5, 2, 2, 1, 'DESRATIZACION', '2026-06-25', 'bg-yellow-500', 'pendiente', '2026-04-29 21:14:57', '2026-04-29 21:14:57'),
(614, 3, 5, 2, 2, 1, 'DESRATIZACION', '2026-07-09', 'bg-yellow-500', 'pendiente', '2026-04-29 21:14:57', '2026-04-29 21:14:57'),
(615, 3, 5, 2, 2, 1, 'DESRATIZACION', '2026-07-23', 'bg-yellow-500', 'pendiente', '2026-04-29 21:14:57', '2026-04-29 21:14:57'),
(616, 3, 5, 2, 2, 1, 'DESRATIZACION', '2026-08-07', 'bg-yellow-500', 'pendiente', '2026-04-29 21:14:57', '2026-04-29 21:14:57'),
(617, 3, 5, 2, 2, 1, 'DESRATIZACION', '2026-08-20', 'bg-yellow-500', 'pendiente', '2026-04-29 21:14:57', '2026-04-29 21:14:57'),
(618, 3, 5, 2, 2, 1, 'DESRATIZACION', '2026-09-10', 'bg-yellow-500', 'pendiente', '2026-04-29 21:14:57', '2026-04-29 21:14:57'),
(619, 3, 5, 2, 2, 1, 'DESRATIZACION', '2026-09-24', 'bg-yellow-500', 'pendiente', '2026-04-29 21:14:57', '2026-04-29 21:14:57'),
(620, 3, 5, 2, 2, 1, 'DESRATIZACION', '2026-10-08', 'bg-yellow-500', 'pendiente', '2026-04-29 21:14:57', '2026-04-29 21:14:57'),
(621, 3, 5, 2, 2, 1, 'DESRATIZACION', '2026-10-22', 'bg-yellow-500', 'pendiente', '2026-04-29 21:14:57', '2026-04-29 21:14:57'),
(622, 3, 5, 2, 2, 1, 'DESRATIZACION', '2026-11-12', 'bg-yellow-500', 'pendiente', '2026-04-29 21:14:57', '2026-04-29 21:14:57'),
(623, 3, 5, 2, 2, 1, 'DESRATIZACION', '2026-11-26', 'bg-yellow-500', 'pendiente', '2026-04-29 21:14:57', '2026-04-29 21:14:57'),
(624, 3, 5, 2, 2, 1, 'DESRATIZACION', '2026-12-09', 'bg-yellow-500', 'pendiente', '2026-04-29 21:14:57', '2026-04-29 21:14:57'),
(625, 3, 5, 2, 2, 1, 'DESRATIZACION', '2026-12-23', 'bg-yellow-500', 'pendiente', '2026-04-29 21:14:57', '2026-04-29 21:14:57'),
(626, 3, 5, 2, 2, 2, 'FUMIGACION', '2026-01-17', 'bg-blue-500', 'pendiente', '2026-04-29 21:14:57', '2026-04-29 21:14:57'),
(627, 3, 5, 2, 2, 2, 'FUMIGACION', '2026-04-18', 'bg-blue-500', 'pendiente', '2026-04-29 21:14:57', '2026-04-29 21:14:57'),
(628, 3, 5, 2, 2, 2, 'FUMIGACION', '2026-07-18', 'bg-blue-500', 'pendiente', '2026-04-29 21:14:57', '2026-04-29 21:14:57'),
(629, 3, 5, 2, 2, 2, 'FUMIGACION', '2026-10-24', 'bg-blue-500', 'pendiente', '2026-04-29 21:14:57', '2026-04-29 21:14:57'),
(630, 4, 7, 2, 2, 1, 'DESRATIZACION', '2026-01-14', 'bg-yellow-500', 'pendiente', '2026-04-29 21:15:18', '2026-04-29 21:15:18'),
(631, 4, 7, 2, 2, 1, 'DESRATIZACION', '2026-01-24', 'bg-yellow-500', 'completado', '2026-04-29 21:15:18', '2026-05-18 22:35:45'),
(632, 4, 7, 2, 2, 1, 'DESRATIZACION', '2026-02-07', 'bg-yellow-500', 'completado', '2026-04-29 21:15:18', '2026-05-18 23:21:01'),
(633, 4, 7, 2, 2, 1, 'DESRATIZACION', '2026-02-20', 'bg-yellow-500', 'completado', '2026-04-29 21:15:18', '2026-05-18 23:36:03'),
(634, 4, 7, 2, 2, 1, 'DESRATIZACION', '2026-03-11', 'bg-yellow-500', 'completado', '2026-04-29 21:15:18', '2026-05-18 23:43:16'),
(635, 4, 7, 2, 2, 1, 'DESRATIZACION', '2026-03-25', 'bg-yellow-500', 'completado', '2026-04-29 21:15:18', '2026-05-18 23:50:52'),
(636, 4, 7, 2, 2, 1, 'DESRATIZACION', '2026-04-14', 'bg-yellow-500', 'completado', '2026-04-29 21:15:18', '2026-05-18 23:57:41'),
(637, 4, 7, 2, 2, 1, 'DESRATIZACION', '2026-04-28', 'bg-yellow-500', 'completado', '2026-04-29 21:15:18', '2026-05-19 00:04:18'),
(638, 4, 7, 2, 2, 1, 'DESRATIZACION', '2026-05-02', 'bg-yellow-500', 'pendiente', '2026-04-29 21:15:18', '2026-04-29 21:15:18'),
(639, 4, 7, 2, 2, 1, 'DESRATIZACION', '2026-05-19', 'bg-yellow-500', 'pendiente', '2026-04-29 21:15:18', '2026-04-29 21:15:18'),
(640, 4, 7, 2, 2, 1, 'DESRATIZACION', '2026-06-10', 'bg-yellow-500', 'pendiente', '2026-04-29 21:15:18', '2026-04-29 21:15:18'),
(641, 4, 7, 2, 2, 1, 'DESRATIZACION', '2026-06-24', 'bg-yellow-500', 'pendiente', '2026-04-29 21:15:18', '2026-04-29 21:15:18'),
(642, 4, 7, 2, 2, 1, 'DESRATIZACION', '2026-07-08', 'bg-yellow-500', 'pendiente', '2026-04-29 21:15:18', '2026-04-29 21:15:18'),
(643, 4, 7, 2, 2, 1, 'DESRATIZACION', '2026-07-22', 'bg-yellow-500', 'pendiente', '2026-04-29 21:15:18', '2026-04-29 21:15:18'),
(644, 4, 7, 2, 2, 1, 'DESRATIZACION', '2026-08-01', 'bg-yellow-500', 'pendiente', '2026-04-29 21:15:18', '2026-04-29 21:15:18'),
(645, 4, 7, 2, 2, 1, 'DESRATIZACION', '2026-08-18', 'bg-yellow-500', 'pendiente', '2026-04-29 21:15:18', '2026-04-29 21:15:18'),
(646, 4, 7, 2, 2, 1, 'DESRATIZACION', '2026-09-09', 'bg-yellow-500', 'pendiente', '2026-04-29 21:15:18', '2026-04-29 21:15:18'),
(647, 4, 7, 2, 2, 1, 'DESRATIZACION', '2026-09-23', 'bg-yellow-500', 'pendiente', '2026-04-29 21:15:18', '2026-04-29 21:15:18'),
(648, 4, 7, 2, 2, 1, 'DESRATIZACION', '2026-10-07', 'bg-yellow-500', 'pendiente', '2026-04-29 21:15:18', '2026-04-29 21:15:18'),
(649, 4, 7, 2, 2, 1, 'DESRATIZACION', '2026-10-21', 'bg-yellow-500', 'pendiente', '2026-04-29 21:15:18', '2026-04-29 21:15:18'),
(650, 4, 7, 2, 2, 1, 'DESRATIZACION', '2026-11-07', 'bg-yellow-500', 'pendiente', '2026-04-29 21:15:18', '2026-04-29 21:15:18'),
(651, 4, 7, 2, 2, 1, 'DESRATIZACION', '2026-11-24', 'bg-yellow-500', 'pendiente', '2026-04-29 21:15:18', '2026-04-29 21:15:18'),
(652, 4, 7, 2, 2, 1, 'DESRATIZACION', '2026-12-08', 'bg-yellow-500', 'pendiente', '2026-04-29 21:15:18', '2026-04-29 21:15:18'),
(653, 4, 7, 2, 2, 1, 'DESRATIZACION', '2026-12-22', 'bg-yellow-500', 'pendiente', '2026-04-29 21:15:18', '2026-04-29 21:15:18'),
(654, 4, 7, 2, 2, 2, 'FUMIGACION', '2026-01-24', 'bg-blue-500', 'completado', '2026-04-29 21:15:18', '2026-05-19 19:50:31'),
(655, 4, 7, 2, 2, 2, 'FUMIGACION', '2026-04-28', 'bg-blue-500', 'completado', '2026-04-29 21:15:18', '2026-05-19 19:54:03'),
(656, 4, 7, 2, 2, 2, 'FUMIGACION', '2026-07-25', 'bg-blue-500', 'pendiente', '2026-04-29 21:15:18', '2026-04-29 21:15:18'),
(657, 4, 7, 2, 2, 2, 'FUMIGACION', '2026-10-31', 'bg-blue-500', 'pendiente', '2026-04-29 21:15:18', '2026-04-29 21:15:18'),
(658, 4, 7, 2, 2, 3, 'INSECTOCUTORES', '2026-01-14', 'bg-pink-600', 'pendiente', '2026-04-29 21:15:18', '2026-04-29 21:15:18'),
(659, 4, 7, 2, 2, 3, 'INSECTOCUTORES', '2026-01-24', 'bg-pink-600', 'completado', '2026-04-29 21:15:18', '2026-05-19 20:05:04'),
(660, 4, 7, 2, 2, 3, 'INSECTOCUTORES', '2026-02-07', 'bg-pink-600', 'completado', '2026-04-29 21:15:18', '2026-05-19 20:08:03'),
(661, 4, 7, 2, 2, 3, 'INSECTOCUTORES', '2026-02-20', 'bg-pink-600', 'completado', '2026-04-29 21:15:18', '2026-05-19 20:10:27'),
(662, 4, 7, 2, 2, 3, 'INSECTOCUTORES', '2026-03-11', 'bg-pink-600', 'completado', '2026-04-29 21:15:18', '2026-05-19 20:21:06'),
(663, 4, 7, 2, 2, 3, 'INSECTOCUTORES', '2026-03-25', 'bg-pink-600', 'completado', '2026-04-29 21:15:18', '2026-05-19 20:23:15'),
(664, 4, 7, 2, 2, 3, 'INSECTOCUTORES', '2026-04-14', 'bg-pink-600', 'completado', '2026-04-29 21:15:18', '2026-05-19 20:30:11'),
(665, 4, 7, 2, 2, 3, 'INSECTOCUTORES', '2026-04-28', 'bg-pink-600', 'completado', '2026-04-29 21:15:18', '2026-05-19 20:33:30'),
(666, 4, 7, 2, 2, 3, 'INSECTOCUTORES', '2026-05-02', 'bg-pink-600', 'pendiente', '2026-04-29 21:15:18', '2026-04-29 21:15:18'),
(667, 4, 7, 2, 2, 3, 'INSECTOCUTORES', '2026-05-19', 'bg-pink-600', 'pendiente', '2026-04-29 21:15:18', '2026-04-29 21:15:18'),
(668, 4, 7, 2, 2, 3, 'INSECTOCUTORES', '2026-06-10', 'bg-pink-600', 'pendiente', '2026-04-29 21:15:18', '2026-04-29 21:15:18'),
(669, 4, 7, 2, 2, 3, 'INSECTOCUTORES', '2026-06-24', 'bg-pink-600', 'pendiente', '2026-04-29 21:15:18', '2026-04-29 21:15:18'),
(670, 4, 7, 2, 2, 3, 'INSECTOCUTORES', '2026-07-08', 'bg-pink-600', 'pendiente', '2026-04-29 21:15:18', '2026-04-29 21:15:18'),
(671, 4, 7, 2, 2, 3, 'INSECTOCUTORES', '2026-07-22', 'bg-pink-600', 'pendiente', '2026-04-29 21:15:18', '2026-04-29 21:15:18'),
(672, 4, 7, 2, 2, 3, 'INSECTOCUTORES', '2026-08-01', 'bg-pink-600', 'pendiente', '2026-04-29 21:15:18', '2026-04-29 21:15:18'),
(673, 4, 7, 2, 2, 3, 'INSECTOCUTORES', '2026-08-18', 'bg-pink-600', 'pendiente', '2026-04-29 21:15:18', '2026-04-29 21:15:18'),
(674, 4, 7, 2, 2, 3, 'INSECTOCUTORES', '2026-09-09', 'bg-pink-600', 'pendiente', '2026-04-29 21:15:18', '2026-04-29 21:15:18'),
(675, 4, 7, 2, 2, 3, 'INSECTOCUTORES', '2026-09-23', 'bg-pink-600', 'pendiente', '2026-04-29 21:15:18', '2026-04-29 21:15:18'),
(676, 4, 7, 2, 2, 3, 'INSECTOCUTORES', '2026-10-07', 'bg-pink-600', 'pendiente', '2026-04-29 21:15:18', '2026-04-29 21:15:18'),
(677, 4, 7, 2, 2, 3, 'INSECTOCUTORES', '2026-10-21', 'bg-pink-600', 'pendiente', '2026-04-29 21:15:18', '2026-04-29 21:15:18'),
(678, 4, 7, 2, 2, 3, 'INSECTOCUTORES', '2026-11-07', 'bg-pink-600', 'pendiente', '2026-04-29 21:15:18', '2026-04-29 21:15:18'),
(679, 4, 7, 2, 2, 3, 'INSECTOCUTORES', '2026-11-24', 'bg-pink-600', 'pendiente', '2026-04-29 21:15:18', '2026-04-29 21:15:18'),
(680, 4, 7, 2, 2, 3, 'INSECTOCUTORES', '2026-12-08', 'bg-pink-600', 'pendiente', '2026-04-29 21:15:18', '2026-04-29 21:15:18'),
(681, 4, 7, 2, 2, 3, 'INSECTOCUTORES', '2026-12-22', 'bg-pink-600', 'pendiente', '2026-04-29 21:15:18', '2026-04-29 21:15:18'),
(872, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-01-13', 'bg-yellow-500', 'completado', '2026-05-02 03:04:42', '2026-05-03 13:53:25'),
(873, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-01-30', 'bg-yellow-500', 'completado', '2026-05-02 03:04:42', '2026-05-04 12:05:30'),
(874, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-02-12', 'bg-yellow-500', 'completado', '2026-05-02 03:04:42', '2026-05-04 13:57:30'),
(875, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-02-26', 'bg-yellow-500', 'completado', '2026-05-02 03:04:42', '2026-05-04 14:20:46'),
(876, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-03-12', 'bg-yellow-500', 'completado', '2026-05-02 03:04:42', '2026-05-04 17:19:59'),
(877, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-03-26', 'bg-yellow-500', 'completado', '2026-05-02 03:04:42', '2026-05-04 18:18:37'),
(878, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-04-09', 'bg-yellow-500', 'completado', '2026-05-02 03:04:42', '2026-05-04 19:18:51'),
(879, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-04-23', 'bg-yellow-500', 'completado', '2026-05-02 03:04:42', '2026-05-04 19:37:27'),
(880, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-05-07', 'bg-yellow-500', 'completado', '2026-05-02 03:04:42', '2026-05-07 19:09:44'),
(881, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-05-21', 'bg-yellow-500', 'completado', '2026-05-02 03:04:42', '2026-05-21 15:57:44'),
(882, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-06-11', 'bg-yellow-500', 'completado', '2026-05-02 03:04:42', '2026-06-11 16:28:22'),
(883, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-06-25', 'bg-yellow-500', 'pendiente', '2026-05-02 03:04:42', '2026-05-02 03:04:42'),
(884, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-07-09', 'bg-yellow-500', 'pendiente', '2026-05-02 03:04:42', '2026-05-02 03:04:42'),
(885, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-07-23', 'bg-yellow-500', 'pendiente', '2026-05-02 03:04:42', '2026-05-02 03:04:42'),
(886, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-08-07', 'bg-yellow-500', 'pendiente', '2026-05-02 03:04:42', '2026-05-02 03:04:42'),
(887, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-08-20', 'bg-yellow-500', 'pendiente', '2026-05-02 03:04:42', '2026-05-02 03:04:42'),
(888, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-09-10', 'bg-yellow-500', 'pendiente', '2026-05-02 03:04:42', '2026-05-02 03:04:42'),
(889, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-09-24', 'bg-yellow-500', 'pendiente', '2026-05-02 03:04:42', '2026-05-02 03:04:42'),
(890, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-10-08', 'bg-yellow-500', 'pendiente', '2026-05-02 03:04:42', '2026-05-02 03:04:42'),
(891, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-10-22', 'bg-yellow-500', 'pendiente', '2026-05-02 03:04:42', '2026-05-02 03:04:42'),
(892, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-11-12', 'bg-yellow-500', 'pendiente', '2026-05-02 03:04:42', '2026-05-02 03:04:42'),
(893, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-11-26', 'bg-yellow-500', 'pendiente', '2026-05-02 03:04:42', '2026-05-02 03:04:42'),
(894, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-12-09', 'bg-yellow-500', 'pendiente', '2026-05-02 03:04:42', '2026-05-02 03:04:42'),
(895, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-12-23', 'bg-yellow-500', 'pendiente', '2026-05-02 03:04:42', '2026-05-02 03:04:42'),
(896, 1, 1, 2, 2, 2, 'FUMIGACION', '2026-03-07', 'bg-blue-500', 'pendiente', '2026-05-02 03:04:42', '2026-05-02 03:04:42'),
(897, 1, 1, 2, 2, 2, 'FUMIGACION', '2026-06-13', 'bg-blue-500', 'completado', '2026-05-02 03:04:42', '2026-06-14 00:16:41'),
(898, 1, 1, 2, 2, 2, 'FUMIGACION', '2026-09-19', 'bg-blue-500', 'pendiente', '2026-05-02 03:04:42', '2026-05-02 03:04:42'),
(899, 1, 1, 2, 2, 2, 'FUMIGACION', '2026-12-12', 'bg-blue-500', 'pendiente', '2026-05-02 03:04:42', '2026-05-02 03:04:42'),
(900, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-01-13', 'bg-pink-600', 'completado', '2026-05-02 03:04:42', '2026-05-03 14:09:03'),
(901, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-01-30', 'bg-pink-600', 'completado', '2026-05-02 03:04:42', '2026-05-04 12:20:03'),
(902, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-02-12', 'bg-pink-600', 'completado', '2026-05-02 03:04:42', '2026-05-04 14:00:50'),
(903, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-02-26', 'bg-pink-600', 'completado', '2026-05-02 03:04:42', '2026-05-04 14:23:56'),
(904, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-03-12', 'bg-pink-600', 'completado', '2026-05-02 03:04:42', '2026-05-04 17:50:41'),
(905, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-03-26', 'bg-pink-600', 'completado', '2026-05-02 03:04:42', '2026-05-04 18:22:44'),
(906, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-04-09', 'bg-pink-600', 'completado', '2026-05-02 03:04:42', '2026-05-04 19:22:33'),
(907, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-04-23', 'bg-pink-600', 'completado', '2026-05-02 03:04:42', '2026-05-04 19:46:21'),
(908, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-05-07', 'bg-pink-600', 'completado', '2026-05-02 03:04:42', '2026-05-07 19:57:07'),
(909, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-05-21', 'bg-pink-600', 'completado', '2026-05-02 03:04:42', '2026-05-21 16:01:20'),
(910, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-06-11', 'bg-pink-600', 'completado', '2026-05-02 03:04:42', '2026-06-11 16:31:29'),
(911, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-06-25', 'bg-pink-600', 'pendiente', '2026-05-02 03:04:42', '2026-05-02 03:04:42'),
(912, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-07-09', 'bg-pink-600', 'pendiente', '2026-05-02 03:04:42', '2026-05-02 03:04:42'),
(913, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-07-23', 'bg-pink-600', 'pendiente', '2026-05-02 03:04:42', '2026-05-02 03:04:42'),
(914, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-08-07', 'bg-pink-600', 'pendiente', '2026-05-02 03:04:42', '2026-05-02 03:04:42'),
(915, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-08-20', 'bg-pink-600', 'pendiente', '2026-05-02 03:04:42', '2026-05-02 03:04:42'),
(916, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-09-10', 'bg-pink-600', 'pendiente', '2026-05-02 03:04:42', '2026-05-02 03:04:42'),
(917, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-09-24', 'bg-pink-600', 'pendiente', '2026-05-02 03:04:42', '2026-05-02 03:04:42'),
(918, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-10-08', 'bg-pink-600', 'pendiente', '2026-05-02 03:04:42', '2026-05-02 03:04:42'),
(919, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-10-22', 'bg-pink-600', 'pendiente', '2026-05-02 03:04:42', '2026-05-02 03:04:42'),
(920, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-11-12', 'bg-pink-600', 'pendiente', '2026-05-02 03:04:42', '2026-05-02 03:04:42'),
(921, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-11-26', 'bg-pink-600', 'pendiente', '2026-05-02 03:04:42', '2026-05-02 03:04:42'),
(922, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-12-09', 'bg-pink-600', 'pendiente', '2026-05-02 03:04:42', '2026-05-02 03:04:42'),
(923, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-12-23', 'bg-pink-600', 'pendiente', '2026-05-02 03:04:42', '2026-05-02 03:04:42'),
(932, 5, 8, 2, 2, 1, 'DESRATIZACION', '2026-01-09', 'bg-yellow-500', 'pendiente', '2026-05-09 02:03:41', '2026-05-09 02:03:41'),
(933, 5, 8, 2, 2, 1, 'DESRATIZACION', '2026-03-20', 'bg-yellow-500', 'pendiente', '2026-05-09 02:03:41', '2026-05-09 02:03:41'),
(934, 5, 8, 2, 2, 1, 'DESRATIZACION', '2026-05-09', 'bg-yellow-500', 'completado', '2026-05-09 02:03:41', '2026-05-10 18:39:08'),
(935, 5, 8, 2, 2, 1, 'DESRATIZACION', '2026-07-11', 'bg-yellow-500', 'pendiente', '2026-05-09 02:03:41', '2026-05-09 02:03:41'),
(936, 5, 8, 2, 2, 1, 'DESRATIZACION', '2026-09-12', 'bg-yellow-500', 'pendiente', '2026-05-09 02:03:41', '2026-05-09 02:03:41'),
(937, 5, 8, 2, 2, 1, 'DESRATIZACION', '2026-11-14', 'bg-yellow-500', 'pendiente', '2026-05-09 02:03:41', '2026-05-09 02:03:41'),
(938, 5, 8, 2, 2, 2, 'FUMIGACION', '2026-01-09', 'bg-blue-500', 'pendiente', '2026-05-09 02:03:41', '2026-05-09 02:03:41'),
(939, 5, 8, 2, 2, 2, 'FUMIGACION', '2026-05-09', 'bg-blue-500', 'completado', '2026-05-09 02:03:41', '2026-05-10 18:49:38'),
(940, 6, 9, 2, 2, 1, 'DESRATIZACION', '2026-06-06', 'bg-yellow-500', 'completado', '2026-06-06 10:36:22', '2026-06-06 17:55:47'),
(954, 6, 9, 2, 2, 2, 'FUMIGACION', '2026-06-06', 'bg-blue-500', 'completado', '2026-06-06 10:36:22', '2026-06-06 17:59:07'),
(961, 6, 9, 2, 2, 3, 'INSECTOCUTORES', '2026-06-06', 'bg-pink-600', 'completado', '2026-06-06 10:36:22', '2026-06-06 18:03:17'),
(1001, 9, 12, 2, 2, 1, 'DESRATIZACION', '2026-01-27', 'bg-yellow-500', 'pendiente', '2026-06-06 14:14:49', '2026-06-06 14:14:49'),
(1002, 9, 12, 2, 2, 1, 'DESRATIZACION', '2026-02-27', 'bg-yellow-500', 'pendiente', '2026-06-06 14:14:49', '2026-06-06 14:14:49'),
(1003, 9, 12, 2, 2, 1, 'DESRATIZACION', '2026-03-27', 'bg-yellow-500', 'pendiente', '2026-06-06 14:14:49', '2026-06-06 14:14:49'),
(1004, 9, 12, 2, 2, 1, 'DESRATIZACION', '2026-04-27', 'bg-yellow-500', 'pendiente', '2026-06-06 14:14:49', '2026-06-06 14:14:49'),
(1005, 9, 12, 2, 2, 1, 'DESRATIZACION', '2026-05-27', 'bg-yellow-500', 'pendiente', '2026-06-06 14:14:49', '2026-06-06 14:14:49'),
(1006, 9, 12, 2, 2, 1, 'DESRATIZACION', '2026-06-26', 'bg-yellow-500', 'pendiente', '2026-06-06 14:14:49', '2026-06-06 14:14:49'),
(1007, 9, 12, 2, 2, 1, 'DESRATIZACION', '2026-07-27', 'bg-yellow-500', 'pendiente', '2026-06-06 14:14:49', '2026-06-06 14:14:49'),
(1008, 9, 12, 2, 2, 1, 'DESRATIZACION', '2026-08-27', 'bg-yellow-500', 'pendiente', '2026-06-06 14:14:49', '2026-06-06 14:14:49'),
(1009, 9, 12, 2, 2, 1, 'DESRATIZACION', '2026-09-28', 'bg-yellow-500', 'pendiente', '2026-06-06 14:14:49', '2026-06-06 14:14:49'),
(1010, 9, 12, 2, 2, 1, 'DESRATIZACION', '2026-10-27', 'bg-yellow-500', 'pendiente', '2026-06-06 14:14:49', '2026-06-06 14:14:49'),
(1011, 9, 12, 2, 2, 1, 'DESRATIZACION', '2026-11-27', 'bg-yellow-500', 'pendiente', '2026-06-06 14:14:49', '2026-06-06 14:14:49'),
(1012, 9, 12, 2, 2, 1, 'DESRATIZACION', '2026-12-28', 'bg-yellow-500', 'pendiente', '2026-06-06 14:14:49', '2026-06-06 14:14:49'),
(1013, 9, 12, 2, 2, 2, 'FUMIGACION', '2026-01-27', 'bg-blue-500', 'pendiente', '2026-06-06 14:14:49', '2026-06-06 14:14:49'),
(1014, 9, 12, 2, 2, 2, 'FUMIGACION', '2026-05-27', 'bg-blue-500', 'pendiente', '2026-06-06 14:14:49', '2026-06-06 14:14:49'),
(1015, 9, 12, 2, 2, 2, 'FUMIGACION', '2026-09-26', 'bg-blue-500', 'pendiente', '2026-06-06 14:14:49', '2026-06-06 14:14:49'),
(1016, 9, 12, 2, 2, 3, 'INSECTOCUTORES', '2026-01-27', 'bg-pink-600', 'pendiente', '2026-06-06 14:14:49', '2026-06-06 14:14:49'),
(1017, 9, 12, 2, 2, 3, 'INSECTOCUTORES', '2026-02-27', 'bg-pink-600', 'pendiente', '2026-06-06 14:14:49', '2026-06-06 14:14:49'),
(1018, 9, 12, 2, 2, 3, 'INSECTOCUTORES', '2026-03-27', 'bg-pink-600', 'pendiente', '2026-06-06 14:14:49', '2026-06-06 14:14:49'),
(1019, 9, 12, 2, 2, 3, 'INSECTOCUTORES', '2026-04-27', 'bg-pink-600', 'pendiente', '2026-06-06 14:14:49', '2026-06-06 14:14:49'),
(1020, 9, 12, 2, 2, 3, 'INSECTOCUTORES', '2026-05-27', 'bg-pink-600', 'pendiente', '2026-06-06 14:14:49', '2026-06-06 14:14:49'),
(1021, 9, 12, 2, 2, 3, 'INSECTOCUTORES', '2026-06-26', 'bg-pink-600', 'pendiente', '2026-06-06 14:14:49', '2026-06-06 14:14:49'),
(1022, 9, 12, 2, 2, 3, 'INSECTOCUTORES', '2026-07-27', 'bg-pink-600', 'pendiente', '2026-06-06 14:14:49', '2026-06-06 14:14:49'),
(1023, 9, 12, 2, 2, 3, 'INSECTOCUTORES', '2026-08-27', 'bg-pink-600', 'pendiente', '2026-06-06 14:14:49', '2026-06-06 14:14:49'),
(1024, 9, 12, 2, 2, 3, 'INSECTOCUTORES', '2026-09-27', 'bg-pink-600', 'pendiente', '2026-06-06 14:14:49', '2026-06-06 14:14:49'),
(1025, 9, 12, 2, 2, 3, 'INSECTOCUTORES', '2026-10-28', 'bg-pink-600', 'pendiente', '2026-06-06 14:14:49', '2026-06-06 14:14:49'),
(1026, 9, 12, 2, 2, 3, 'INSECTOCUTORES', '2026-11-27', 'bg-pink-600', 'pendiente', '2026-06-06 14:14:49', '2026-06-06 14:14:49'),
(1027, 9, 12, 2, 2, 3, 'INSECTOCUTORES', '2026-12-28', 'bg-pink-600', 'pendiente', '2026-06-06 14:14:49', '2026-06-06 14:14:49'),
(1028, 10, 13, 2, 2, 1, 'DESRATIZACION', '2026-01-15', 'bg-yellow-500', 'pendiente', '2026-06-09 15:12:03', '2026-06-09 15:12:03'),
(1029, 10, 13, 2, 2, 1, 'DESRATIZACION', '2026-01-30', 'bg-yellow-500', 'pendiente', '2026-06-09 15:12:03', '2026-06-09 15:12:03'),
(1030, 10, 13, 2, 2, 1, 'DESRATIZACION', '2026-02-13', 'bg-yellow-500', 'pendiente', '2026-06-09 15:12:03', '2026-06-09 15:12:03'),
(1031, 10, 13, 2, 2, 1, 'DESRATIZACION', '2026-02-28', 'bg-yellow-500', 'pendiente', '2026-06-09 15:12:03', '2026-06-09 15:12:03'),
(1032, 10, 13, 2, 2, 1, 'DESRATIZACION', '2026-03-07', 'bg-yellow-500', 'pendiente', '2026-06-09 15:12:03', '2026-06-09 15:12:03'),
(1033, 10, 13, 2, 2, 1, 'DESRATIZACION', '2026-03-21', 'bg-yellow-500', 'pendiente', '2026-06-09 15:12:03', '2026-06-09 15:12:03'),
(1034, 10, 13, 2, 2, 1, 'DESRATIZACION', '2026-04-11', 'bg-yellow-500', 'pendiente', '2026-06-09 15:12:03', '2026-06-09 15:12:03'),
(1035, 10, 13, 2, 2, 1, 'DESRATIZACION', '2026-04-25', 'bg-yellow-500', 'pendiente', '2026-06-09 15:12:03', '2026-06-09 15:12:03'),
(1036, 10, 13, 2, 2, 1, 'DESRATIZACION', '2026-05-09', 'bg-yellow-500', 'pendiente', '2026-06-09 15:12:03', '2026-06-09 15:12:03'),
(1037, 10, 13, 2, 2, 1, 'DESRATIZACION', '2026-05-23', 'bg-yellow-500', 'pendiente', '2026-06-09 15:12:03', '2026-06-09 15:12:03'),
(1038, 10, 13, 2, 2, 1, 'DESRATIZACION', '2026-06-13', 'bg-yellow-500', 'pendiente', '2026-06-09 15:12:03', '2026-06-09 15:12:03'),
(1039, 10, 13, 2, 2, 1, 'DESRATIZACION', '2026-06-27', 'bg-yellow-500', 'pendiente', '2026-06-09 15:12:03', '2026-06-09 15:12:03'),
(1040, 10, 13, 2, 2, 1, 'DESRATIZACION', '2026-07-11', 'bg-yellow-500', 'pendiente', '2026-06-09 15:12:03', '2026-06-09 15:12:03'),
(1041, 10, 13, 2, 2, 1, 'DESRATIZACION', '2026-07-25', 'bg-yellow-500', 'pendiente', '2026-06-09 15:12:03', '2026-06-09 15:12:03'),
(1042, 10, 13, 2, 2, 1, 'DESRATIZACION', '2026-08-08', 'bg-yellow-500', 'pendiente', '2026-06-09 15:12:03', '2026-06-09 15:12:03'),
(1043, 10, 13, 2, 2, 1, 'DESRATIZACION', '2026-08-22', 'bg-yellow-500', 'pendiente', '2026-06-09 15:12:03', '2026-06-09 15:12:03'),
(1044, 10, 13, 2, 2, 1, 'DESRATIZACION', '2026-09-12', 'bg-yellow-500', 'pendiente', '2026-06-09 15:12:03', '2026-06-09 15:12:03'),
(1045, 10, 13, 2, 2, 1, 'DESRATIZACION', '2026-09-26', 'bg-yellow-500', 'pendiente', '2026-06-09 15:12:03', '2026-06-09 15:12:03'),
(1046, 10, 13, 2, 2, 1, 'DESRATIZACION', '2026-10-10', 'bg-yellow-500', 'pendiente', '2026-06-09 15:12:03', '2026-06-09 15:12:03'),
(1047, 10, 13, 2, 2, 1, 'DESRATIZACION', '2026-10-24', 'bg-yellow-500', 'pendiente', '2026-06-09 15:12:03', '2026-06-09 15:12:03'),
(1048, 10, 13, 2, 2, 1, 'DESRATIZACION', '2026-11-14', 'bg-yellow-500', 'pendiente', '2026-06-09 15:12:03', '2026-06-09 15:12:03'),
(1049, 10, 13, 2, 2, 1, 'DESRATIZACION', '2026-11-28', 'bg-yellow-500', 'pendiente', '2026-06-09 15:12:03', '2026-06-09 15:12:03'),
(1050, 10, 13, 2, 2, 1, 'DESRATIZACION', '2026-12-12', 'bg-yellow-500', 'pendiente', '2026-06-09 15:12:03', '2026-06-09 15:12:03'),
(1051, 10, 13, 2, 2, 1, 'DESRATIZACION', '2026-12-26', 'bg-yellow-500', 'pendiente', '2026-06-09 15:12:03', '2026-06-09 15:12:03'),
(1052, 10, 13, 2, 2, 2, 'FUMIGACION', '2026-01-15', 'bg-blue-500', 'pendiente', '2026-06-09 15:12:03', '2026-06-09 15:12:03'),
(1053, 10, 13, 2, 2, 2, 'FUMIGACION', '2026-02-28', 'bg-blue-500', 'pendiente', '2026-06-09 15:12:03', '2026-06-09 15:12:03'),
(1054, 10, 13, 2, 2, 2, 'FUMIGACION', '2026-03-07', 'bg-blue-500', 'pendiente', '2026-06-09 15:12:03', '2026-06-09 15:12:03'),
(1055, 10, 13, 2, 2, 2, 'FUMIGACION', '2026-04-11', 'bg-blue-500', 'pendiente', '2026-06-09 15:12:03', '2026-06-09 15:12:03'),
(1056, 10, 13, 2, 2, 2, 'FUMIGACION', '2026-05-09', 'bg-blue-500', 'pendiente', '2026-06-09 15:12:03', '2026-06-09 15:12:03'),
(1057, 10, 13, 2, 2, 2, 'FUMIGACION', '2026-06-13', 'bg-blue-500', 'pendiente', '2026-06-09 15:12:03', '2026-06-09 15:12:03'),
(1058, 10, 13, 2, 2, 2, 'FUMIGACION', '2026-07-11', 'bg-blue-500', 'pendiente', '2026-06-09 15:12:03', '2026-06-09 15:12:03'),
(1059, 10, 13, 2, 2, 2, 'FUMIGACION', '2026-08-08', 'bg-blue-500', 'pendiente', '2026-06-09 15:12:03', '2026-06-09 15:12:03'),
(1060, 10, 13, 2, 2, 2, 'FUMIGACION', '2026-09-12', 'bg-blue-500', 'pendiente', '2026-06-09 15:12:03', '2026-06-09 15:12:03'),
(1061, 10, 13, 2, 2, 2, 'FUMIGACION', '2026-10-10', 'bg-blue-500', 'pendiente', '2026-06-09 15:12:03', '2026-06-09 15:12:03'),
(1062, 10, 13, 2, 2, 2, 'FUMIGACION', '2026-11-14', 'bg-blue-500', 'pendiente', '2026-06-09 15:12:03', '2026-06-09 15:12:03'),
(1063, 10, 13, 2, 2, 2, 'FUMIGACION', '2026-12-12', 'bg-blue-500', 'pendiente', '2026-06-09 15:12:03', '2026-06-09 15:12:03'),
(1064, 10, 13, 2, 2, 3, 'INSECTOCUTORES', '2026-01-15', 'bg-pink-600', 'pendiente', '2026-06-09 15:12:03', '2026-06-09 15:12:03'),
(1065, 10, 13, 2, 2, 3, 'INSECTOCUTORES', '2026-01-30', 'bg-pink-600', 'pendiente', '2026-06-09 15:12:03', '2026-06-09 15:12:03'),
(1066, 10, 13, 2, 2, 3, 'INSECTOCUTORES', '2026-02-13', 'bg-pink-600', 'pendiente', '2026-06-09 15:12:03', '2026-06-09 15:12:03'),
(1067, 10, 13, 2, 2, 3, 'INSECTOCUTORES', '2026-02-28', 'bg-pink-600', 'pendiente', '2026-06-09 15:12:03', '2026-06-09 15:12:03'),
(1068, 10, 13, 2, 2, 3, 'INSECTOCUTORES', '2026-03-07', 'bg-pink-600', 'pendiente', '2026-06-09 15:12:03', '2026-06-09 15:12:03'),
(1069, 10, 13, 2, 2, 3, 'INSECTOCUTORES', '2026-03-21', 'bg-pink-600', 'pendiente', '2026-06-09 15:12:03', '2026-06-09 15:12:03'),
(1070, 10, 13, 2, 2, 3, 'INSECTOCUTORES', '2026-04-11', 'bg-pink-600', 'pendiente', '2026-06-09 15:12:03', '2026-06-09 15:12:03'),
(1071, 10, 13, 2, 2, 3, 'INSECTOCUTORES', '2026-04-25', 'bg-pink-600', 'pendiente', '2026-06-09 15:12:03', '2026-06-09 15:12:03'),
(1072, 10, 13, 2, 2, 3, 'INSECTOCUTORES', '2026-05-09', 'bg-pink-600', 'pendiente', '2026-06-09 15:12:03', '2026-06-09 15:12:03'),
(1073, 10, 13, 2, 2, 3, 'INSECTOCUTORES', '2026-05-23', 'bg-pink-600', 'pendiente', '2026-06-09 15:12:03', '2026-06-09 15:12:03'),
(1074, 10, 13, 2, 2, 3, 'INSECTOCUTORES', '2026-06-13', 'bg-pink-600', 'pendiente', '2026-06-09 15:12:03', '2026-06-09 15:12:03'),
(1075, 10, 13, 2, 2, 3, 'INSECTOCUTORES', '2026-06-27', 'bg-pink-600', 'pendiente', '2026-06-09 15:12:03', '2026-06-09 15:12:03'),
(1076, 10, 13, 2, 2, 3, 'INSECTOCUTORES', '2026-07-11', 'bg-pink-600', 'pendiente', '2026-06-09 15:12:03', '2026-06-09 15:12:03'),
(1077, 10, 13, 2, 2, 3, 'INSECTOCUTORES', '2026-07-25', 'bg-pink-600', 'pendiente', '2026-06-09 15:12:03', '2026-06-09 15:12:03'),
(1078, 10, 13, 2, 2, 3, 'INSECTOCUTORES', '2026-08-08', 'bg-pink-600', 'pendiente', '2026-06-09 15:12:03', '2026-06-09 15:12:03'),
(1079, 10, 13, 2, 2, 3, 'INSECTOCUTORES', '2026-08-22', 'bg-pink-600', 'pendiente', '2026-06-09 15:12:03', '2026-06-09 15:12:03'),
(1080, 10, 13, 2, 2, 3, 'INSECTOCUTORES', '2026-09-12', 'bg-pink-600', 'pendiente', '2026-06-09 15:12:03', '2026-06-09 15:12:03'),
(1081, 10, 13, 2, 2, 3, 'INSECTOCUTORES', '2026-09-26', 'bg-pink-600', 'pendiente', '2026-06-09 15:12:03', '2026-06-09 15:12:03'),
(1082, 10, 13, 2, 2, 3, 'INSECTOCUTORES', '2026-10-10', 'bg-pink-600', 'pendiente', '2026-06-09 15:12:03', '2026-06-09 15:12:03'),
(1083, 10, 13, 2, 2, 3, 'INSECTOCUTORES', '2026-10-24', 'bg-pink-600', 'pendiente', '2026-06-09 15:12:03', '2026-06-09 15:12:03'),
(1084, 10, 13, 2, 2, 3, 'INSECTOCUTORES', '2026-11-14', 'bg-pink-600', 'pendiente', '2026-06-09 15:12:03', '2026-06-09 15:12:03'),
(1085, 10, 13, 2, 2, 3, 'INSECTOCUTORES', '2026-11-28', 'bg-pink-600', 'pendiente', '2026-06-09 15:12:03', '2026-06-09 15:12:03'),
(1086, 10, 13, 2, 2, 3, 'INSECTOCUTORES', '2026-12-12', 'bg-pink-600', 'pendiente', '2026-06-09 15:12:03', '2026-06-09 15:12:03'),
(1087, 10, 13, 2, 2, 3, 'INSECTOCUTORES', '2026-12-26', 'bg-pink-600', 'pendiente', '2026-06-09 15:12:03', '2026-06-09 15:12:03'),
(1106, 6, 9, 2, 2, 1, 'DESRATIZACION', '2026-06-05', 'bg-yellow-500', 'pendiente', '2026-06-10 13:10:15', '2026-06-10 13:10:15'),
(1107, 6, 9, 2, 2, 1, 'DESRATIZACION', '2026-06-20', 'bg-yellow-500', 'completado', '2026-06-10 13:10:15', '2026-06-19 18:55:41'),
(1108, 6, 9, 2, 2, 1, 'DESRATIZACION', '2026-07-04', 'bg-yellow-500', 'pendiente', '2026-06-10 13:10:15', '2026-06-10 13:10:15'),
(1109, 6, 9, 2, 2, 1, 'DESRATIZACION', '2026-07-20', 'bg-yellow-500', 'pendiente', '2026-06-10 13:10:15', '2026-06-10 13:10:15'),
(1110, 6, 9, 2, 2, 1, 'DESRATIZACION', '2026-08-05', 'bg-yellow-500', 'pendiente', '2026-06-10 13:10:15', '2026-06-10 13:10:15'),
(1111, 6, 9, 2, 2, 1, 'DESRATIZACION', '2026-08-20', 'bg-yellow-500', 'pendiente', '2026-06-10 13:10:15', '2026-06-10 13:10:15'),
(1112, 6, 9, 2, 2, 1, 'DESRATIZACION', '2026-09-05', 'bg-yellow-500', 'pendiente', '2026-06-10 13:10:15', '2026-06-10 13:10:15'),
(1113, 6, 9, 2, 2, 1, 'DESRATIZACION', '2026-09-19', 'bg-yellow-500', 'pendiente', '2026-06-10 13:10:15', '2026-06-10 13:10:15'),
(1114, 6, 9, 2, 2, 1, 'DESRATIZACION', '2026-10-05', 'bg-yellow-500', 'pendiente', '2026-06-10 13:10:15', '2026-06-10 13:10:15'),
(1115, 6, 9, 2, 2, 1, 'DESRATIZACION', '2026-10-20', 'bg-yellow-500', 'pendiente', '2026-06-10 13:10:15', '2026-06-10 13:10:15'),
(1116, 6, 9, 2, 2, 1, 'DESRATIZACION', '2026-11-05', 'bg-yellow-500', 'pendiente', '2026-06-10 13:10:15', '2026-06-10 13:10:15'),
(1117, 6, 9, 2, 2, 1, 'DESRATIZACION', '2026-11-20', 'bg-yellow-500', 'pendiente', '2026-06-10 13:10:15', '2026-06-10 13:10:15'),
(1118, 6, 9, 2, 2, 1, 'DESRATIZACION', '2026-12-05', 'bg-yellow-500', 'pendiente', '2026-06-10 13:10:15', '2026-06-10 13:10:15'),
(1119, 6, 9, 2, 2, 1, 'DESRATIZACION', '2026-12-21', 'bg-yellow-500', 'pendiente', '2026-06-10 13:10:15', '2026-06-10 13:10:15'),
(1120, 6, 9, 2, 2, 2, 'FUMIGACION', '2026-06-06', 'bg-blue-500', 'pendiente', '2026-06-10 13:10:15', '2026-06-10 13:10:15'),
(1121, 6, 9, 2, 2, 2, 'FUMIGACION', '2026-07-04', 'bg-blue-500', 'pendiente', '2026-06-10 13:10:15', '2026-06-10 13:10:15'),
(1122, 6, 9, 2, 2, 2, 'FUMIGACION', '2026-08-08', 'bg-blue-500', 'pendiente', '2026-06-10 13:10:15', '2026-06-10 13:10:15'),
(1123, 6, 9, 2, 2, 2, 'FUMIGACION', '2026-09-05', 'bg-blue-500', 'pendiente', '2026-06-10 13:10:15', '2026-06-10 13:10:15'),
(1124, 6, 9, 2, 2, 2, 'FUMIGACION', '2026-10-03', 'bg-blue-500', 'pendiente', '2026-06-10 13:10:15', '2026-06-10 13:10:15'),
(1125, 6, 9, 2, 2, 2, 'FUMIGACION', '2026-11-07', 'bg-blue-500', 'pendiente', '2026-06-10 13:10:15', '2026-06-10 13:10:15'),
(1126, 6, 9, 2, 2, 2, 'FUMIGACION', '2026-12-05', 'bg-blue-500', 'pendiente', '2026-06-10 13:10:15', '2026-06-10 13:10:15'),
(1127, 6, 9, 2, 2, 3, 'INSECTOCUTORES', '2026-06-05', 'bg-pink-600', 'pendiente', '2026-06-10 13:10:15', '2026-06-10 13:10:15'),
(1128, 6, 9, 2, 2, 3, 'INSECTOCUTORES', '2026-06-09', 'bg-pink-600', 'completado', '2026-06-10 13:10:15', '2026-06-10 14:06:42'),
(1129, 6, 9, 2, 2, 3, 'INSECTOCUTORES', '2026-06-16', 'bg-pink-600', 'completado', '2026-06-10 13:10:15', '2026-06-19 19:02:45'),
(1130, 6, 9, 2, 2, 3, 'INSECTOCUTORES', '2026-06-23', 'bg-pink-600', 'pendiente', '2026-06-10 13:10:15', '2026-06-10 13:10:15'),
(1131, 6, 9, 2, 2, 3, 'INSECTOCUTORES', '2026-07-07', 'bg-pink-600', 'pendiente', '2026-06-10 13:10:15', '2026-06-10 13:10:15'),
(1132, 6, 9, 2, 2, 3, 'INSECTOCUTORES', '2026-07-14', 'bg-pink-600', 'pendiente', '2026-06-10 13:10:15', '2026-06-10 13:10:15'),
(1133, 6, 9, 2, 2, 3, 'INSECTOCUTORES', '2026-07-21', 'bg-pink-600', 'pendiente', '2026-06-10 13:10:15', '2026-06-10 13:10:15'),
(1134, 6, 9, 2, 2, 3, 'INSECTOCUTORES', '2026-07-28', 'bg-pink-600', 'pendiente', '2026-06-10 13:10:15', '2026-06-10 13:10:15'),
(1135, 6, 9, 2, 2, 3, 'INSECTOCUTORES', '2026-08-05', 'bg-pink-600', 'pendiente', '2026-06-10 13:10:15', '2026-06-10 13:10:15'),
(1136, 6, 9, 2, 2, 3, 'INSECTOCUTORES', '2026-08-11', 'bg-pink-600', 'pendiente', '2026-06-10 13:10:15', '2026-06-10 13:10:15'),
(1137, 6, 9, 2, 2, 3, 'INSECTOCUTORES', '2026-08-18', 'bg-pink-600', 'pendiente', '2026-06-10 13:10:15', '2026-06-10 13:10:15'),
(1138, 6, 9, 2, 2, 3, 'INSECTOCUTORES', '2026-08-25', 'bg-pink-600', 'pendiente', '2026-06-10 13:10:15', '2026-06-10 13:10:15'),
(1139, 6, 9, 2, 2, 3, 'INSECTOCUTORES', '2026-09-05', 'bg-pink-600', 'pendiente', '2026-06-10 13:10:15', '2026-06-10 13:10:15'),
(1140, 6, 9, 2, 2, 3, 'INSECTOCUTORES', '2026-09-08', 'bg-pink-600', 'pendiente', '2026-06-10 13:10:15', '2026-06-10 13:10:15'),
(1141, 6, 9, 2, 2, 3, 'INSECTOCUTORES', '2026-09-15', 'bg-pink-600', 'pendiente', '2026-06-10 13:10:15', '2026-06-10 13:10:15'),
(1142, 6, 9, 2, 2, 3, 'INSECTOCUTORES', '2026-09-22', 'bg-pink-600', 'pendiente', '2026-06-10 13:10:15', '2026-06-10 13:10:15'),
(1143, 6, 9, 2, 2, 3, 'INSECTOCUTORES', '2026-10-05', 'bg-pink-600', 'pendiente', '2026-06-10 13:10:15', '2026-06-10 13:10:15'),
(1144, 6, 9, 2, 2, 3, 'INSECTOCUTORES', '2026-10-13', 'bg-pink-600', 'pendiente', '2026-06-10 13:10:15', '2026-06-10 13:10:15'),
(1145, 6, 9, 2, 2, 3, 'INSECTOCUTORES', '2026-10-20', 'bg-pink-600', 'pendiente', '2026-06-10 13:10:15', '2026-06-10 13:10:15'),
(1146, 6, 9, 2, 2, 3, 'INSECTOCUTORES', '2026-10-27', 'bg-pink-600', 'pendiente', '2026-06-10 13:10:15', '2026-06-10 13:10:15'),
(1147, 6, 9, 2, 2, 3, 'INSECTOCUTORES', '2026-11-05', 'bg-pink-600', 'pendiente', '2026-06-10 13:10:15', '2026-06-10 13:10:15'),
(1148, 6, 9, 2, 2, 3, 'INSECTOCUTORES', '2026-11-10', 'bg-pink-600', 'pendiente', '2026-06-10 13:10:15', '2026-06-10 13:10:15'),
(1149, 6, 9, 2, 2, 3, 'INSECTOCUTORES', '2026-11-17', 'bg-pink-600', 'pendiente', '2026-06-10 13:10:15', '2026-06-10 13:10:15'),
(1150, 6, 9, 2, 2, 3, 'INSECTOCUTORES', '2026-11-24', 'bg-pink-600', 'pendiente', '2026-06-10 13:10:15', '2026-06-10 13:10:15'),
(1151, 6, 9, 2, 2, 3, 'INSECTOCUTORES', '2026-12-05', 'bg-pink-600', 'pendiente', '2026-06-10 13:10:15', '2026-06-10 13:10:15'),
(1152, 6, 9, 2, 2, 3, 'INSECTOCUTORES', '2026-12-08', 'bg-pink-600', 'pendiente', '2026-06-10 13:10:15', '2026-06-10 13:10:15'),
(1153, 6, 9, 2, 2, 3, 'INSECTOCUTORES', '2026-12-15', 'bg-pink-600', 'pendiente', '2026-06-10 13:10:15', '2026-06-10 13:10:15'),
(1154, 6, 9, 2, 2, 3, 'INSECTOCUTORES', '2026-12-22', 'bg-pink-600', 'pendiente', '2026-06-10 13:10:15', '2026-06-10 13:10:15'),
(1173, 11, 14, 2, 2, 1, 'DESRATIZACION', '2026-06-03', 'bg-yellow-500', 'completado', '2026-06-10 13:17:31', '2026-06-10 13:26:01'),
(1174, 11, 14, 2, 2, 1, 'DESRATIZACION', '2026-07-03', 'bg-yellow-500', 'pendiente', '2026-06-10 13:17:31', '2026-06-10 13:17:31'),
(1175, 11, 14, 2, 2, 1, 'DESRATIZACION', '2026-08-14', 'bg-yellow-500', 'pendiente', '2026-06-10 13:17:31', '2026-06-10 13:17:31'),
(1176, 11, 14, 2, 2, 1, 'DESRATIZACION', '2026-09-18', 'bg-yellow-500', 'pendiente', '2026-06-10 13:17:31', '2026-06-10 13:17:31'),
(1177, 11, 14, 2, 2, 1, 'DESRATIZACION', '2026-10-16', 'bg-yellow-500', 'pendiente', '2026-06-10 13:17:31', '2026-06-10 13:17:31'),
(1178, 11, 14, 2, 2, 1, 'DESRATIZACION', '2026-11-13', 'bg-yellow-500', 'pendiente', '2026-06-10 13:17:31', '2026-06-10 13:17:31'),
(1179, 11, 14, 2, 2, 1, 'DESRATIZACION', '2026-12-18', 'bg-yellow-500', 'pendiente', '2026-06-10 13:17:31', '2026-06-10 13:17:31'),
(1180, 11, 14, 2, 2, 2, 'FUMIGACION', '2026-06-03', 'bg-blue-500', 'completado', '2026-06-10 13:17:31', '2026-06-10 13:45:59'),
(1181, 11, 14, 2, 2, 2, 'FUMIGACION', '2026-08-14', 'bg-blue-500', 'pendiente', '2026-06-10 13:17:31', '2026-06-10 13:17:31'),
(1182, 11, 14, 2, 2, 2, 'FUMIGACION', '2026-10-16', 'bg-blue-500', 'pendiente', '2026-06-10 13:17:31', '2026-06-10 13:17:31'),
(1183, 11, 14, 2, 2, 2, 'FUMIGACION', '2026-12-18', 'bg-blue-500', 'pendiente', '2026-06-10 13:17:31', '2026-06-10 13:17:31'),
(1184, 11, 14, 2, 2, 3, 'INSECTOCUTORES', '2026-06-03', 'bg-pink-600', 'pendiente', '2026-06-10 13:17:31', '2026-06-10 13:17:31'),
(1185, 11, 14, 2, 2, 3, 'INSECTOCUTORES', '2026-07-03', 'bg-pink-600', 'pendiente', '2026-06-10 13:17:31', '2026-06-10 13:17:31'),
(1186, 11, 14, 2, 2, 3, 'INSECTOCUTORES', '2026-08-14', 'bg-pink-600', 'pendiente', '2026-06-10 13:17:31', '2026-06-10 13:17:31'),
(1187, 11, 14, 2, 2, 3, 'INSECTOCUTORES', '2026-09-18', 'bg-pink-600', 'pendiente', '2026-06-10 13:17:31', '2026-06-10 13:17:31'),
(1188, 11, 14, 2, 2, 3, 'INSECTOCUTORES', '2026-10-16', 'bg-pink-600', 'pendiente', '2026-06-10 13:17:31', '2026-06-10 13:17:31'),
(1189, 11, 14, 2, 2, 3, 'INSECTOCUTORES', '2026-11-13', 'bg-pink-600', 'pendiente', '2026-06-10 13:17:31', '2026-06-10 13:17:31'),
(1190, 11, 14, 2, 2, 3, 'INSECTOCUTORES', '2026-12-18', 'bg-pink-600', 'pendiente', '2026-06-10 13:17:31', '2026-06-10 13:17:31');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuentas_cobrar`
--

CREATE TABLE `cuentas_cobrar` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `venta_id` bigint(20) UNSIGNED DEFAULT NULL,
  `contrato_id` bigint(20) UNSIGNED DEFAULT NULL,
  `cliente_id` bigint(20) UNSIGNED DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `concepto` varchar(255) NOT NULL,
  `detalles` varchar(255) NOT NULL,
  `total` double NOT NULL,
  `saldo` double NOT NULL,
  `estado` enum('Pendiente','Cancelado') NOT NULL,
  `fecha_pago` date DEFAULT NULL,
  `plan_pagos` tinyint(1) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `cuentas_cobrar`
--

INSERT INTO `cuentas_cobrar` (`id`, `venta_id`, `contrato_id`, `cliente_id`, `user_id`, `concepto`, `detalles`, `total`, `saldo`, `estado`, `fecha_pago`, `plan_pagos`, `created_at`, `updated_at`) VALUES
(1, NULL, 1, NULL, 2, 'Contrato por cobrar #1', 'Saldo pendiento por cobrar sobre contrato', 14672, 14672, 'Pendiente', NULL, 0, '2026-04-29 17:59:23', '2026-04-29 21:10:30'),
(2, NULL, 2, NULL, 2, 'Contrato por cobrar #2', 'Saldo pendiento por cobrar sobre contrato', 33200, 33200, 'Pendiente', NULL, 0, '2026-04-29 18:53:56', '2026-04-29 18:53:56'),
(3, NULL, 3, NULL, 2, 'Contrato por cobrar #3', 'Saldo pendiento por cobrar sobre contrato', 10832, 10832, 'Pendiente', NULL, 0, '2026-04-29 19:49:13', '2026-04-29 19:49:13'),
(4, NULL, 4, NULL, 2, 'Contrato por cobrar #4', 'Saldo pendiento por cobrar sobre contrato', 8736, 8736, 'Pendiente', NULL, 0, '2026-04-29 20:03:22', '2026-04-29 20:03:22'),
(5, NULL, 5, NULL, 2, 'Contrato por cobrar #5', 'Saldo pendiento por cobrar sobre contrato', 4000.84, 4000.84, 'Pendiente', NULL, 0, '2026-05-09 01:57:04', '2026-05-09 01:57:04'),
(6, NULL, 6, NULL, 2, 'Contrato por cobrar #6', 'Saldo pendiento por cobrar sobre contrato', 26129.6, 26129.6, 'Pendiente', NULL, 0, '2026-06-06 10:36:22', '2026-06-10 13:10:15'),
(7, NULL, 9, NULL, 2, 'Contrato por cobrar #9', 'Saldo pendiento por cobrar sobre contrato', 12000, 12000, 'Pendiente', NULL, 0, '2026-06-06 14:14:49', '2026-06-06 14:14:49'),
(8, NULL, 10, NULL, 2, 'Contrato por cobrar #10', 'Saldo pendiento por cobrar sobre contrato', 24000, 24000, 'Pendiente', NULL, 0, '2026-06-09 15:12:03', '2026-06-09 15:12:03'),
(9, NULL, 11, NULL, 2, 'Contrato por cobrar #11', 'Saldo pendiento por cobrar sobre contrato', 16000.01, 16000.01, 'Pendiente', NULL, 0, '2026-06-10 12:50:12', '2026-06-10 12:50:12');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuentas_pagar`
--

CREATE TABLE `cuentas_pagar` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `compra_id` bigint(20) UNSIGNED DEFAULT NULL,
  `proveedor_id` bigint(20) UNSIGNED DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `concepto` varchar(255) NOT NULL,
  `detalles` varchar(255) NOT NULL,
  `total` double NOT NULL,
  `saldo` double NOT NULL,
  `estado` enum('Pendiente','Cancelado') NOT NULL,
  `fecha_pago` date DEFAULT NULL,
  `plan_pagos` tinyint(1) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuenta_extras`
--

CREATE TABLE `cuenta_extras` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `cuenta_extras`
--

INSERT INTO `cuenta_extras` (`id`, `nombre`, `created_at`, `updated_at`) VALUES
(1, 'Gastos bancarios operativos', '2026-04-13 13:42:19', '2026-04-13 13:42:19'),
(2, 'Capacitacion y cursos', '2026-04-13 13:42:19', '2026-04-13 13:42:19'),
(3, 'Licencias de Software', '2026-04-13 13:42:19', '2026-04-13 13:42:19'),
(4, 'Gastos de representación', '2026-04-13 13:42:19', '2026-04-13 13:42:19'),
(5, 'Eventos y actividades', '2026-04-13 13:42:19', '2026-04-13 13:42:19'),
(6, 'Seguridad y vigilancia', '2026-04-13 13:42:19', '2026-04-13 13:42:19');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuenta_financieros`
--

CREATE TABLE `cuenta_financieros` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `cuenta_financieros`
--

INSERT INTO `cuenta_financieros` (`id`, `nombre`, `created_at`, `updated_at`) VALUES
(1, 'Sueldos administrativos', '2026-04-13 13:42:19', '2026-04-13 13:42:19'),
(2, 'Honorarios profesionales', '2026-04-13 13:42:19', '2026-04-13 13:42:19'),
(3, 'Utiles de oficina', '2026-04-13 13:42:19', '2026-04-13 13:42:19'),
(4, 'Alquiler de oficina', '2026-04-13 13:42:19', '2026-04-13 13:42:19'),
(5, 'Energia Electrica', '2026-04-13 13:42:19', '2026-04-13 13:42:19'),
(6, 'Agua', '2026-04-13 13:42:19', '2026-04-13 13:42:19'),
(7, 'Telefono', '2026-04-13 13:42:19', '2026-04-13 13:42:19'),
(8, 'Mantenimiento y reparaciones', '2026-04-13 13:42:19', '2026-04-13 13:42:19'),
(9, 'Limpieza', '2026-04-13 13:42:19', '2026-04-13 13:42:19'),
(10, 'Seguros', '2026-04-13 13:42:19', '2026-04-13 13:42:19'),
(11, 'Depresiacion', '2026-04-13 13:42:19', '2026-04-13 13:42:19');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuenta_operativos`
--

CREATE TABLE `cuenta_operativos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `cuenta_operativos`
--

INSERT INTO `cuenta_operativos` (`id`, `nombre`, `created_at`, `updated_at`) VALUES
(1, 'Sueldos personal', '2026-04-13 13:42:19', '2026-04-13 13:42:19'),
(2, 'Comisiones sobre ventas', '2026-04-13 13:42:19', '2026-04-13 13:42:19'),
(3, 'Marketing digital', '2026-04-13 13:42:19', '2026-04-13 13:42:19'),
(4, 'Material promocional', '2026-04-13 13:42:19', '2026-04-13 13:42:19'),
(5, 'Transporte y distribucion', '2026-04-13 13:42:19', '2026-04-13 13:42:19'),
(6, 'Combustible', '2026-04-13 13:42:19', '2026-04-13 13:42:19'),
(7, 'Viaticos y movilidad', '2026-04-13 13:42:19', '2026-04-13 13:42:19'),
(8, 'Empaques y embalajes', '2026-04-13 13:42:19', '2026-04-13 13:42:19');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `documentos`
--

CREATE TABLE `documentos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `tipo` varchar(255) NOT NULL,
  `ruta` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `documentos`
--

INSERT INTO `documentos` (`id`, `nombre`, `descripcion`, `tipo`, `ruta`, `created_at`, `updated_at`) VALUES
(1, 'NIT', 'NUMERO DE IDENTIFICACION TRIBUTARIO', 'pdf', 'documents/rqDompYGRtTZYBbCUV57N7KDwQLoBKX734stpWlt.pdf', '2026-05-01 16:22:54', '2026-05-01 16:22:54'),
(2, 'SENASAG', 'SERVICIO NACIONAL DE SEGURIDAD ALIMENTARIA', 'pdf', 'documents/9NRWrNgklFShzkUGdy1hX8nIE6Yj86YtwG1qsiQB.pdf', '2026-05-01 16:24:34', '2026-05-01 16:24:34'),
(4, 'LICENCIA MUNICIPAL DE FUNCIONAMIENTO', 'REGISTRO EN EL GAMLP ALCALDIA', 'pdf', 'documents/KUBjbRinrRoWNPJEBOA3kw5Y5Ac5JyYc7XUJogO8.pdf', '2026-05-01 16:27:02', '2026-05-01 16:27:02'),
(5, 'SEDES', 'SERVICIO DEPARTAMENTAL DE SALUD SANTA CRUZ', 'pdf', 'documents/puJniAcuT5S8YDHF6v8bQ72lW76cJCcp0UOf8Tk7.pdf', '2026-05-01 16:28:22', '2026-05-01 16:28:22'),
(8, 'LICENCIA AMBIENTAL', 'LASP 1', 'pdf', 'documents/Dml0pcdUCI5jRPiPziKwMd76jSzxHIatYQVVUZim.pdf', '2026-05-01 17:39:36', '2026-05-01 17:39:36'),
(9, 'LICENCIA AMBIENTAL', 'LASP 2', 'pdf', 'documents/ive26hXR8QFV5mLyDdezXK3UICAG8TMsvDiNDScv.pdf', '2026-05-01 17:40:06', '2026-05-01 17:40:06'),
(10, 'LICENCIA AMBIENTAL', 'LASP 3', 'pdf', 'documents/GTXiyJyf7dx6KM8VgJhvJaII5KdI2atf5WdO03aQ.pdf', '2026-05-01 17:40:40', '2026-05-01 17:40:40'),
(13, 'SEPREC 2026', 'REGISTRO DE COMERCIO DE BOLIVIA', 'pdf', 'documents/QwvmoDX4ReHIGkL5gJBbKD0sSOz3RLwZzoWkUVEx.pdf', '2026-06-02 09:52:54', '2026-06-02 09:52:54'),
(14, 'INSO 2026', 'INSTITUTO NACIONAL DE SALUD OCUPACIONAL', 'pdf', 'documents/UyXroGw8O09x8S37sMlMCtN6pWxI9DrNFdR6LEnr.pdf', '2026-06-02 10:00:09', '2026-06-02 10:00:09'),
(15, 'NIT ELECTRONICO RNC', 'REGISTRO NACIONAL DE CONTRIBUYENTES RNC', 'pdf', 'documents/SAIkC9t8t1A84xk99zghznYZq7G1c84BsQQnNE0d.pdf', '2026-06-02 10:01:48', '2026-06-02 10:01:48');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empresas`
--

CREATE TABLE `empresas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `direccion` varchar(255) NOT NULL,
  `telefono` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `ciudad` varchar(255) NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `empresas`
--

INSERT INTO `empresas` (`id`, `nombre`, `direccion`, `telefono`, `email`, `ciudad`, `activo`, `created_at`, `updated_at`) VALUES
(1, 'LA CASCADA  PLANTA VILLA FATIMA', 'CALLE SANTA ROSA NRO. 471 VILLA FATIMA', '69722664', 'jessica_escobar@lacascada.com.bo', 'LA PAZ', 1, '2026-04-29 17:59:23', '2026-04-29 21:13:51'),
(2, 'LA CASCADA PLANTA EL ALTO', 'CALLE SANTA ROSA NRO. 471 VILLA FATIMA', '69722664', 'jessica_escobar@lacascada.com.bo', 'LA PAZ', 1, '2026-04-29 18:53:56', '2026-04-29 18:53:56'),
(3, 'LA CASCADA DITRIBUIDORA  LLOJETA', 'CALLE SANTA ROSA NRO. 471 VILLA FATIMA', '69722664', 'jessica_escobar@lacascada.com.bo', 'LA PAZ', 1, '2026-04-29 19:49:13', '2026-04-29 21:14:57'),
(4, 'LA CASCADA  PLANTA VISCACHANI', 'CALLE SANTA ROSA NRO. 471 VILLA FATIMA', '69722664', 'jessica_escobar@lacascada.com.bo', 'LA PAZ', 1, '2026-04-29 20:03:22', '2026-04-29 21:15:18'),
(5, 'QUIMIZA LTDA', 'AV. LAS AMERICAS CIUDAD DE EL ALTO', '76402235', 'mmariscal@quimiza.com', 'LA PAZ', 1, '2026-05-09 01:57:04', '2026-05-09 01:57:04'),
(6, 'RANSA OPERADOR LOGISTICO', 'AV. ROQUE DALTON Nro.130 ZONA 29 DE JUNIO SENKATA CIUDAD DE EL ALTO', '776922359', 'rfarmaceuticobol@ransa.net', 'EL ALTO', 1, '2026-06-06 10:36:22', '2026-06-06 10:36:22'),
(9, 'BOLIVIAN FOOD  LA PAZ', 'ROSAS PAMPA ELALTO', '79698267', 'aalvarez@bolivianfoods.com.bo', 'EL ALTO', 1, '2026-06-06 14:14:49', '2026-06-06 14:14:49'),
(10, 'BOLIVIAN FOOD SANTA CRUZ', 'AVENIDA AL NORTE', '79698267', 'aalvarez@bolivianfoods.com.bo', 'SANTA CRUZ', 1, '2026-06-09 15:12:03', '2026-06-09 15:12:03'),
(11, 'CIMFA  VILLA TUNARI CNS', 'Villa Tunari', '61281922', 'williammaydanaarevalo@gmail.com', 'el alto', 1, '2026-06-10 12:50:12', '2026-06-10 12:50:12');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `epps`
--

CREATE TABLE `epps` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `epps`
--

INSERT INTO `epps` (`id`, `nombre`, `created_at`, `updated_at`) VALUES
(1, 'Ropa de trabajo', '2026-04-13 13:42:19', '2026-04-13 13:42:19'),
(2, 'Casco de proteccion', '2026-04-13 13:42:19', '2026-04-13 13:42:19'),
(3, 'Gorra', '2026-04-13 13:42:19', '2026-04-13 13:42:19'),
(4, 'Guantes', '2026-04-13 13:42:19', '2026-04-13 13:42:19'),
(5, 'Overol', '2026-04-13 13:42:19', '2026-04-13 13:42:19'),
(6, 'Botas', '2026-04-13 13:42:19', '2026-04-13 13:42:19'),
(7, 'Gafas', '2026-04-13 13:42:19', '2026-04-13 13:42:19'),
(8, 'Antiparras', '2026-04-13 13:42:19', '2026-04-13 13:42:19'),
(9, 'Respirados', '2026-04-13 13:42:19', '2026-04-13 13:42:19'),
(10, 'Full face', '2026-04-13 13:42:19', '2026-04-13 13:42:19'),
(11, 'Otros', '2026-04-13 13:42:19', '2026-04-13 13:42:19');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `especies`
--

CREATE TABLE `especies` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `especies`
--

INSERT INTO `especies` (`id`, `nombre`, `created_at`, `updated_at`) VALUES
(1, 'Moscas', '2026-04-13 13:42:19', '2026-04-13 13:42:19'),
(2, 'Polillas', '2026-04-13 13:42:19', '2026-04-13 13:42:19'),
(3, 'Mosquitos', '2026-04-13 13:42:19', '2026-04-13 13:42:19');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado_extras`
--

CREATE TABLE `estado_extras` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `estado_id` bigint(20) UNSIGNED NOT NULL,
  `gasto_id` bigint(20) UNSIGNED NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado_financieros`
--

CREATE TABLE `estado_financieros` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `estado_id` bigint(20) UNSIGNED NOT NULL,
  `gasto_id` bigint(20) UNSIGNED NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado_operativos`
--

CREATE TABLE `estado_operativos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `estado_id` bigint(20) UNSIGNED NOT NULL,
  `gasto_id` bigint(20) UNSIGNED NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado_resultados`
--

CREATE TABLE `estado_resultados` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `fecha_inicio` timestamp NULL DEFAULT NULL,
  `fecha_fin` timestamp NULL DEFAULT NULL,
  `ventas` double NOT NULL,
  `cobrado` double NOT NULL,
  `otros_ingresos` double NOT NULL,
  `ingresos_totales` double NOT NULL,
  `compras` double NOT NULL,
  `costo_total` double NOT NULL,
  `utilidad_bruta` double NOT NULL,
  `gastosop` double NOT NULL,
  `gastosfin` double NOT NULL,
  `gastosext` double NOT NULL,
  `gastos` double NOT NULL,
  `pagos` double NOT NULL,
  `total_gastos` double NOT NULL,
  `utilidad_neta` double NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `etiquetas`
--

CREATE TABLE `etiquetas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `etiqueta_productos`
--

CREATE TABLE `etiqueta_productos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `etiqueta_id` bigint(20) UNSIGNED NOT NULL,
  `producto_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `gastos`
--

CREATE TABLE `gastos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `concepto` varchar(255) NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `gasto_extras`
--

CREATE TABLE `gasto_extras` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `cuenta_id` bigint(20) UNSIGNED NOT NULL,
  `concepto` varchar(255) NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `gasto_financieros`
--

CREATE TABLE `gasto_financieros` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `cuenta_id` bigint(20) UNSIGNED NOT NULL,
  `concepto` varchar(255) NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `gasto_operativos`
--

CREATE TABLE `gasto_operativos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `cuenta_id` bigint(20) UNSIGNED NOT NULL,
  `concepto` varchar(255) NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `hoja_tecnicas`
--

CREATE TABLE `hoja_tecnicas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `producto_id` bigint(20) UNSIGNED NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `archivo` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `imagen` varchar(255) DEFAULT NULL,
  `ruta` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `hoja_tecnicas`
--

INSERT INTO `hoja_tecnicas` (`id`, `producto_id`, `titulo`, `archivo`, `url`, `imagen`, `ruta`, `created_at`, `updated_at`) VALUES
(1, 1, 'FICHA TECNICA FENDONA', 'hojas-tecnicas/qyC8drktbLqTzrq45ZEhLfnXVkPkXIIQRBnnsJuN.pdf', NULL, NULL, NULL, '2026-05-01 21:10:58', '2026-05-01 21:10:58'),
(2, 1, 'HOJA DE SEGURIDAD', 'hojas-tecnicas/oxHwLTScfCOlOLz4isUzcSR5W997ektCLfnURMv9.pdf', NULL, NULL, NULL, '2026-05-01 21:12:59', '2026-05-01 21:12:59'),
(3, 2, 'FICHA TECNICA KLERAT', 'hojas-tecnicas/Ghc4LDo9Sb6pmWAWYwGqp8tozipUZ5ZZQPx24nVF.pdf', NULL, NULL, NULL, '2026-05-01 21:14:46', '2026-05-01 21:14:46'),
(4, 2, 'HOJA DE SEGURIDAD', 'hojas-tecnicas/amJunBg2gLTfkJ8mUT7ON58xaIzuC4H8cWUI18dc.pdf', NULL, NULL, NULL, '2026-05-01 21:16:28', '2026-05-01 21:16:28'),
(5, 1, 'REGISTRO INSO FENDONA', 'hojas-tecnicas/D6H1N3TxM1NYDEiXjAqscX1GfG9XzdspuggJkEay.pdf', NULL, NULL, NULL, '2026-05-01 21:18:06', '2026-05-01 21:18:06'),
(6, 2, 'REGISTRO INSO KLERAT', 'hojas-tecnicas/nO4r3wGPPT7Rm9L2IgoZOmtxURDM2PhZ1yafBUJq.pdf', NULL, NULL, NULL, '2026-05-01 21:19:41', '2026-05-01 21:19:41'),
(7, 3, 'FICHA TECNICA TITANE 5 EC', 'hojas-tecnicas/MpbgbkC0bsbJs8SeWKleJZUovYuA90RZavsryfb7.pdf', NULL, NULL, NULL, '2026-05-01 21:26:38', '2026-05-01 21:26:38'),
(8, 3, 'HOJA DE SEGURIDAD TITANE 5EC', 'hojas-tecnicas/yqDeMBD50DNdKP5EVIBIJkN01VtOzQ3SZ3ItS2xY.pdf', NULL, NULL, NULL, '2026-05-01 21:30:20', '2026-05-01 21:30:20'),
(9, 3, 'REGISTRO INSO TITANE 5EC', 'hojas-tecnicas/682wByrcqjoqbev8W5GVVuCeKqzirTUggBkR1Cju.pdf', NULL, NULL, NULL, '2026-05-01 21:34:39', '2026-05-01 21:34:39'),
(10, 4, 'TITANE DELTA REGISTRO INSO', 'hojas-tecnicas/lT7dwb6u0Nt2YUHHaFpjHg6zlVYnGzueu5mAkEJG.pdf', NULL, NULL, NULL, '2026-05-01 21:37:36', '2026-05-01 21:37:36'),
(11, 4, 'FICHA TECNICA TITANE DELTA', 'hojas-tecnicas/YgCsmdtRvwzYqdoX6GBWo2GGyVw2AoZSqzaWDRyc.pdf', NULL, NULL, NULL, '2026-05-01 22:32:33', '2026-05-01 22:32:33'),
(12, 4, 'HOJA DE SEGURIDAD TITANE DELTA', 'hojas-tecnicas/MSU8DoGrOECLZkHlVdWvOZ4U63uunD7NsjH7blhA.pdf', NULL, NULL, NULL, '2026-05-01 23:22:57', '2026-05-01 23:22:57'),
(13, 5, 'HOJA DE SEGURIDAD', 'hojas-tecnicas/T58jFp2uhdEBgx5pr9JS3EEafYYEApxKa6QvacLv.pdf', NULL, NULL, NULL, '2026-05-01 23:36:11', '2026-05-01 23:36:11'),
(14, 5, 'FICHA TECNICA RATIMOR', 'hojas-tecnicas/ZjANASyj52sW1YHxYHOlZ5OjhovH449CqVzwrYHe.pdf', NULL, NULL, NULL, '2026-05-01 23:36:44', '2026-05-01 23:36:44'),
(15, 5, 'REGISTRO SENASAG', 'hojas-tecnicas/jZmP1VxnXpRxmgeES7lCnWCVJ8HhLfVsVRVjTEq5.pdf', NULL, NULL, NULL, '2026-05-01 23:38:30', '2026-05-01 23:38:30'),
(16, 6, 'FICHA TECNICA', 'hojas-tecnicas/4YZ7ROSMc0vwnNYx66PNQSDEUfk1LWjYIJgj22ME.pdf', NULL, NULL, NULL, '2026-05-01 23:41:33', '2026-05-01 23:41:33'),
(17, 6, 'REGISTRO AGEMED', 'hojas-tecnicas/3HDF0s90gr6qIdt3ryQaJqSGg1FvZXP9P2wZjSya.pdf', NULL, NULL, NULL, '2026-05-01 23:42:06', '2026-05-01 23:42:06'),
(18, 6, 'HOJA DE SEGURIDAD', 'hojas-tecnicas/V1UTSS104BtFdh4xApoyS8nX3U9GVLOcBEv5w82O.pdf', NULL, NULL, NULL, '2026-05-01 23:43:12', '2026-05-01 23:43:12');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `informe_archivos`
--

CREATE TABLE `informe_archivos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `empresa_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `nombre_original` varchar(255) NOT NULL,
  `ruta` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ingresos`
--

CREATE TABLE `ingresos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `concepto` varchar(255) NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `insectocutores`
--

CREATE TABLE `insectocutores` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `almacen_id` bigint(20) UNSIGNED NOT NULL,
  `mapa_id` bigint(20) UNSIGNED NOT NULL,
  `posx` int(11) NOT NULL,
  `posy` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `kardexes`
--

CREATE TABLE `kardexes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `venta_id` bigint(20) UNSIGNED DEFAULT NULL,
  `compra_id` bigint(20) UNSIGNED DEFAULT NULL,
  `producto_id` bigint(20) UNSIGNED DEFAULT NULL,
  `tipo` enum('Entrada','Salida') NOT NULL,
  `cantidad` int(11) NOT NULL,
  `cantidad_saldo` int(11) NOT NULL,
  `costo_unitario` double NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `kardexes`
--

INSERT INTO `kardexes` (`id`, `venta_id`, `compra_id`, `producto_id`, `tipo`, `cantidad`, `cantidad_saldo`, `costo_unitario`, `created_at`, `updated_at`) VALUES
(1, NULL, 1, 5, 'Entrada', 275, 275, 10, '2026-05-03 11:36:30', '2026-05-03 11:36:30'),
(2, NULL, NULL, 5, 'Salida', 0, 275, 10, '2026-05-03 13:53:25', '2026-05-03 13:53:25'),
(3, NULL, 2, 2, 'Entrada', 1, 1, 10, '2026-05-04 11:33:19', '2026-05-04 11:33:19'),
(4, NULL, NULL, 2, 'Salida', 0, 1, 10, '2026-05-04 12:05:30', '2026-05-04 12:05:30'),
(5, NULL, NULL, 2, 'Salida', 0, 1, 10, '2026-05-04 13:57:30', '2026-05-04 13:57:30'),
(6, NULL, NULL, 2, 'Salida', 0, 1, 10, '2026-05-04 14:20:46', '2026-05-04 14:20:46'),
(7, NULL, NULL, 2, 'Salida', 0, 1, 10, '2026-05-04 17:19:59', '2026-05-04 17:19:59'),
(8, NULL, NULL, 2, 'Salida', 0, 1, 10, '2026-05-04 18:18:37', '2026-05-04 18:18:37'),
(9, NULL, NULL, 2, 'Salida', 0, 1, 10, '2026-05-04 19:18:51', '2026-05-04 19:18:51'),
(10, NULL, NULL, 2, 'Salida', 0, 1, 10, '2026-05-04 19:37:27', '2026-05-04 19:37:27'),
(11, NULL, NULL, 2, 'Salida', 0, 1, 10, '2026-05-13 13:50:25', '2026-05-13 13:50:25'),
(12, NULL, NULL, 2, 'Salida', 0, 1, 10, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(13, NULL, NULL, 2, 'Salida', 0, 1, 10, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(14, NULL, NULL, 2, 'Salida', 0, 1, 10, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(15, NULL, NULL, 2, 'Salida', 0, 1, 10, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(16, NULL, NULL, 2, 'Salida', 0, 1, 10, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(17, NULL, NULL, 2, 'Salida', 0, 1, 10, '2026-05-18 14:55:42', '2026-05-18 14:55:42'),
(18, NULL, NULL, 2, 'Salida', 0, 1, 10, '2026-05-18 15:56:33', '2026-05-18 15:56:33'),
(19, NULL, NULL, 2, 'Salida', 0, 1, 10, '2026-05-18 16:34:39', '2026-05-18 16:34:39'),
(20, NULL, NULL, 2, 'Salida', 0, 1, 10, '2026-05-18 20:43:18', '2026-05-18 20:43:18'),
(21, NULL, NULL, 2, 'Salida', 0, 1, 10, '2026-05-18 20:57:53', '2026-05-18 20:57:53'),
(22, NULL, NULL, 2, 'Salida', 0, 1, 10, '2026-05-18 21:18:23', '2026-05-18 21:18:23'),
(23, NULL, NULL, 2, 'Salida', 0, 1, 10, '2026-05-18 21:31:23', '2026-05-18 21:31:23'),
(24, NULL, NULL, 2, 'Salida', 0, 1, 10, '2026-05-18 22:35:46', '2026-05-18 22:35:46'),
(25, NULL, NULL, 2, 'Salida', 0, 1, 10, '2026-05-18 23:21:01', '2026-05-18 23:21:01'),
(26, NULL, NULL, 2, 'Salida', 0, 1, 10, '2026-05-18 23:36:03', '2026-05-18 23:36:03'),
(27, NULL, NULL, 2, 'Salida', 0, 1, 10, '2026-05-18 23:43:16', '2026-05-18 23:43:16'),
(28, NULL, NULL, 2, 'Salida', 0, 1, 10, '2026-05-18 23:50:52', '2026-05-18 23:50:52'),
(29, NULL, NULL, 2, 'Salida', 0, 1, 10, '2026-05-18 23:57:41', '2026-05-18 23:57:41'),
(30, NULL, NULL, 2, 'Salida', 0, 1, 10, '2026-05-19 00:04:18', '2026-05-19 00:04:18'),
(31, NULL, NULL, 1, 'Salida', 0, 0, 0, '2026-05-19 19:50:31', '2026-05-19 19:50:31'),
(32, NULL, NULL, 1, 'Salida', 0, 0, 0, '2026-05-19 19:54:03', '2026-05-19 19:54:03'),
(33, NULL, NULL, 7, 'Salida', 1, -1, 0, '2026-05-19 20:08:03', '2026-05-19 20:08:03'),
(34, NULL, NULL, 7, 'Salida', 1, -2, 0, '2026-05-19 20:10:27', '2026-05-19 20:10:27'),
(35, NULL, NULL, 7, 'Salida', 1, -3, 0, '2026-05-19 20:21:06', '2026-05-19 20:21:06'),
(36, NULL, NULL, 7, 'Salida', 1, -4, 0, '2026-05-19 20:23:15', '2026-05-19 20:23:15'),
(37, NULL, NULL, 7, 'Salida', 1, -5, 0, '2026-05-19 20:30:11', '2026-05-19 20:30:11'),
(38, NULL, NULL, 7, 'Salida', 1, -6, 0, '2026-05-19 20:33:30', '2026-05-19 20:33:30'),
(39, NULL, NULL, 2, 'Salida', 0, 1, 10, '2026-05-21 15:57:44', '2026-05-21 15:57:44'),
(40, NULL, NULL, 7, 'Salida', 3, -9, 0, '2026-05-21 16:01:20', '2026-05-21 16:01:20'),
(41, NULL, NULL, 2, 'Salida', 0, 1, 10, '2026-05-21 18:13:30', '2026-05-21 18:13:30'),
(42, NULL, NULL, 2, 'Salida', 0, 1, 10, '2026-05-22 15:53:09', '2026-05-22 15:53:09'),
(43, NULL, NULL, 2, 'Salida', 0, 1, 10, '2026-06-06 17:55:47', '2026-06-06 17:55:47'),
(44, NULL, NULL, 4, 'Salida', 1, -1, 0, '2026-06-06 17:59:07', '2026-06-06 17:59:07'),
(45, NULL, NULL, 7, 'Salida', 3, -12, 0, '2026-06-06 18:03:17', '2026-06-06 18:03:17'),
(46, NULL, NULL, 2, 'Salida', 0, 1, 10, '2026-06-10 13:26:01', '2026-06-10 13:26:01'),
(47, NULL, NULL, 1, 'Salida', 0, 0, 0, '2026-06-10 13:45:59', '2026-06-10 13:45:59'),
(48, NULL, NULL, 3, 'Salida', 1, -1, 0, '2026-06-10 13:45:59', '2026-06-10 13:45:59'),
(49, NULL, NULL, 7, 'Salida', 3, -15, 0, '2026-06-10 14:06:42', '2026-06-10 14:06:42'),
(50, NULL, NULL, 7, 'Salida', 3, -18, 0, '2026-06-11 16:31:29', '2026-06-11 16:31:29'),
(51, NULL, NULL, 2, 'Salida', 0, 1, 10, '2026-06-11 18:31:40', '2026-06-11 18:31:40'),
(52, NULL, NULL, 2, 'Salida', 0, 1, 10, '2026-06-12 15:08:16', '2026-06-12 15:08:16'),
(53, NULL, NULL, 7, 'Salida', 1, -19, 0, '2026-06-12 21:55:02', '2026-06-12 21:55:02'),
(54, NULL, NULL, 1, 'Salida', 0, 0, 0, '2026-06-14 00:16:41', '2026-06-14 00:16:41'),
(55, NULL, NULL, 6, 'Salida', 1, -1, 0, '2026-06-14 00:16:41', '2026-06-14 00:16:41'),
(56, NULL, NULL, 2, 'Salida', 0, 1, 10, '2026-06-19 18:55:41', '2026-06-19 18:55:41'),
(57, NULL, NULL, 7, 'Salida', 3, -22, 0, '2026-06-19 19:02:45', '2026-06-19 19:02:45'),
(58, NULL, NULL, 4, 'Salida', 1, -2, 0, '2026-06-22 16:03:53', '2026-06-22 16:03:53'),
(59, NULL, NULL, 3, 'Salida', 1, -2, 0, '2026-06-22 16:03:53', '2026-06-22 16:03:53');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mapas`
--

CREATE TABLE `mapas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `empresa_id` bigint(20) UNSIGNED NOT NULL,
  `almacen_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `titulo` varchar(255) DEFAULT NULL,
  `data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`data`)),
  `background` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `mapas`
--

INSERT INTO `mapas` (`id`, `empresa_id`, `almacen_id`, `user_id`, `titulo`, `data`, `background`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 2, 'PLANO DE UBICACION DE ROEDORES PLANTA VF', '16', 'images/mapas/1_1777507656.png', '2026-04-29 23:07:36', '2026-05-01 11:11:18'),
(2, 1, 1, 2, 'PLANO DE UBICACION DE ROEDORES GARAJE DOS VF', '24', 'images/mapas/1_1777508873.png', '2026-04-29 23:27:53', '2026-05-01 11:20:16'),
(3, 1, 1, 2, 'PLANO DE UBICACION DE ROEDORES ALMACEN EVENTOS', '30', 'images/mapas/1_1777637896.png', '2026-05-01 11:18:16', '2026-05-01 11:18:16'),
(4, 2, 4, 2, 'PLANO DE UBICACION DE  ROEDORES PLANTA EL ALTO', '14', 'images/mapas/4_1777640008.png', '2026-05-01 11:53:28', '2026-05-01 12:41:36'),
(5, 3, 5, 2, 'PLANO DE UBICACION DE ROEDORES DISTRIBUIDORA LLOJETA', '22', 'images/mapas/5_1777650639.png', '2026-05-01 14:50:39', '2026-05-01 14:50:39'),
(6, 3, 5, 2, 'LLOJETA ANEXO', '36', 'images/mapas/5_1777653754.png', '2026-05-01 15:42:34', '2026-05-01 15:42:34'),
(7, 4, 7, 2, 'PLANO DE UBICACION DE ROEDORES PLANTA VISCACHANI', '28', 'images/mapas/7_1777654811.png', '2026-05-01 16:00:11', '2026-05-01 16:05:26'),
(8, 5, 8, 2, 'PLANO DE UBICACION DE TRAMPAS', '24', 'images/mapas/8_1778295727.png', '2026-05-09 02:02:07', '2026-05-09 02:06:16'),
(9, 6, 9, 2, 'ALMACEN ILLIMANI', '18', 'images/mapas/9_1780747842.png', '2026-06-06 11:10:42', '2026-06-06 11:10:42'),
(10, 9, 12, 2, 'BOLIVIAN  FOODS CEDI  LA PAZ', '18', 'images/mapas/12_1780759677.png', '2026-06-06 14:27:57', '2026-06-06 14:44:19'),
(11, 10, 13, 2, 'MAPA DE UBICACION DE TRAMPAS DE ROEDORES', '30', 'images/mapas/13_1781022354.png', '2026-06-09 15:25:54', '2026-06-11 14:32:39'),
(12, 11, 14, 2, 'PLANO DE ROEDORES CIMFA CNS', '30', 'images/mapas/14_1781099666.png', '2026-06-10 12:54:26', '2026-06-10 17:47:43');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mapa_revisiones`
--

CREATE TABLE `mapa_revisiones` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `marcas`
--

CREATE TABLE `marcas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `metodos`
--

CREATE TABLE `metodos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `metodos`
--

INSERT INTO `metodos` (`id`, `nombre`, `created_at`, `updated_at`) VALUES
(1, 'Alimento con veneno', '2026-04-13 13:42:19', '2026-04-13 13:42:19'),
(2, 'Sustancia pegajosa', '2026-04-13 13:42:19', '2026-04-13 13:42:19'),
(3, 'Alimento', '2026-04-13 13:42:19', '2026-04-13 13:42:19'),
(4, 'Aspersion', '2026-04-13 13:42:19', '2026-04-13 13:42:19'),
(5, 'Niebla', '2026-04-13 13:42:19', '2026-04-13 13:42:19'),
(6, 'Nebulizacion', '2026-04-13 13:42:19', '2026-04-13 13:42:19'),
(7, 'Fumigacion', '2026-04-13 13:42:19', '2026-04-13 13:42:19'),
(8, 'Otros', '2026-04-13 13:42:19', '2026-04-13 13:42:19');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2025_08_26_100418_add_two_factor_columns_to_users_table', 1),
(5, '2025_11_12_132859_create_personal_access_tokens_table', 1),
(6, '2025_11_12_133243_create_permission_tables', 1),
(7, '2025_11_25_051552_create_empresas_table', 1),
(8, '2025_11_25_051553_create_almacenes_table', 1),
(9, '2025_11_25_051554_create_almacen_areas_table', 1),
(10, '2025_11_25_051555_create_almacen_trampas_table', 1),
(11, '2025_11_25_051556_create_almancen_insectocutores_table', 1),
(12, '2025_11_25_051615_create_contactos_table', 1),
(13, '2025_11_25_051616_create_contratos_table', 1),
(14, '2025_11_25_051617_create_contrato_detalles_table', 1),
(15, '2025_11_25_051629_create_documentos_table', 1),
(16, '2025_11_25_051653_create_certificados_table', 1),
(17, '2025_11_25_051654_create_tipo_seguimientos_table', 1),
(18, '2025_11_25_051717_create_cronogramas_table', 1),
(19, '2025_11_25_051718_create_seguimientos_table', 1),
(20, '2025_11_25_051739_create_mapas_table', 1),
(21, '2025_11_25_051751_create_aplicaciones_table', 1),
(22, '2025_11_25_051805_create_metodos_table', 1),
(23, '2025_11_25_051806_create_epps_table', 1),
(24, '2025_11_25_051807_create_protecciones_table', 1),
(25, '2025_11_25_051808_create_signos_table', 1),
(26, '2025_11_25_051809_create_biologicos_table', 1),
(27, '2025_11_25_051810_create_seguimiento_metodos_table', 1),
(28, '2025_11_25_051816_create_seguimiento_epps_table', 1),
(29, '2025_11_25_051822_create_seguimiento_protecciones_table', 1),
(30, '2025_11_25_051827_create_seguimiento_signos_table', 1),
(31, '2025_11_25_051842_create_seguimiento_biologicos_table', 1),
(32, '2025_11_25_051843_create_especies_table', 1),
(33, '2025_11_25_051844_create_seguimiento_especies_table', 1),
(34, '2025_11_25_051845_create_seguimiento_images_table', 1),
(35, '2025_11_25_052118_create_mapa_revisiones_table', 1),
(36, '2025_11_25_052226_create_categorias_table', 1),
(37, '2025_11_25_052230_create_subcategorias_table', 1),
(38, '2025_11_25_052236_create_marcas_table', 1),
(39, '2025_11_25_052242_create_etiquetas_table', 1),
(40, '2025_11_25_052243_create_proveedores_table', 1),
(41, '2025_11_25_052254_create_unidades_table', 1),
(42, '2025_11_25_052255_create_productos_table', 1),
(43, '2025_11_25_052303_create_hoja_tecnicas_table', 1),
(44, '2025_11_25_052319_create_producto_usos_table', 1),
(45, '2025_11_25_182100_create_cotizaciones_table', 1),
(46, '2025_11_26_123624_create_cotizacion_detalles_table', 1),
(47, '2025_11_27_052237_create_clientes_table', 1),
(48, '2025_11_27_142733_create_ventas_table', 1),
(49, '2025_11_27_142742_create_compras_table', 1),
(50, '2025_11_27_142854_create_compra_detalles_table', 1),
(51, '2025_11_27_142901_create_venta_detalles_table', 1),
(52, '2025_11_27_142932_create_cuentas_pagar_table', 1),
(53, '2025_11_27_142938_create_cuentas_cobrar_table', 1),
(54, '2025_11_27_143009_create_gastos_table', 1),
(55, '2025_11_27_143019_create_ingresos_table', 1),
(56, '2025_11_27_143024_create_retiros_table', 1),
(57, '2025_12_02_203419_create_etiqueta_productos_table', 1),
(58, '2025_12_02_205646_create_kardexes_table', 1),
(59, '2025_12_03_055753_create_agendas_table', 1),
(60, '2025_12_09_220637_create_trampa_tipos_table', 1),
(61, '2025_12_09_220638_create_trampas_table', 1),
(62, '2025_12_10_031413_create_cobrar_cuotas_table', 1),
(63, '2025_12_10_031434_create_cobrar_pagos_table', 1),
(64, '2025_12_11_191449_create_producto_vencimientos_table', 1),
(65, '2025_12_12_173602_create_estado_resultados_table', 1),
(66, '2025_12_12_173603_create_cuenta_financieros_table', 1),
(67, '2025_12_12_173604_create_cuenta_operativos_table', 1),
(68, '2025_12_12_173605_create_cuenta_extras_table', 1),
(69, '2025_12_12_173640_create_gasto_operativos_table', 1),
(70, '2025_12_12_173647_create_gasto_financieros_table', 1),
(71, '2025_12_12_173652_create_gasto_extras_table', 1),
(72, '2025_12_12_173709_create_estado_operativos_table', 1),
(73, '2025_12_12_173721_create_estado_financieros_table', 1),
(74, '2025_12_12_173731_create_estado_extras_table', 1),
(75, '2025_12_18_153541_create_insectocutores_table', 1),
(76, '2025_12_24_135938_create_pagar_cuotas_table', 1),
(77, '2025_12_24_135947_create_pagar_pagos_table', 1),
(78, '2026_01_13_142508_create_usuario_empresas_table', 1),
(79, '2026_01_13_143244_create_trampa_seguimientos_table', 1),
(80, '2026_01_13_143646_create_trampa_especie_seguimientos_table', 1),
(81, '2026_01_13_143809_create_trampa_roedor_seguimientos_table', 1),
(82, '2026_02_25_082320_create_buffer_productos_table', 1),
(83, '2026_03_03_111616_create_acciones_table', 1),
(84, '2026_03_03_112149_create_accion_trampas_table', 1),
(85, '2026_03_03_112205_create_accion_productos_table', 1),
(86, '2026_03_04_021409_create_accion_imagenes_table', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(2, 'App\\Models\\User', 2),
(3, 'App\\Models\\User', 3),
(3, 'App\\Models\\User', 5),
(4, 'App\\Models\\User', 6),
(4, 'App\\Models\\User', 7);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pagar_cuotas`
--

CREATE TABLE `pagar_cuotas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `cuenta_pagar_id` bigint(20) UNSIGNED NOT NULL,
  `numero_cuota` int(11) NOT NULL,
  `fecha_vencimiento` date NOT NULL,
  `monto` decimal(12,2) NOT NULL,
  `estado` enum('pendiente','pagado','vencido') NOT NULL DEFAULT 'pendiente',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pagar_pagos`
--

CREATE TABLE `pagar_pagos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `cuenta_pagar_id` bigint(20) UNSIGNED NOT NULL,
  `cuota_id` bigint(20) UNSIGNED DEFAULT NULL,
  `fecha_pago` date NOT NULL,
  `monto` decimal(12,2) NOT NULL,
  `metodo_pago` varchar(255) DEFAULT NULL,
  `observacion` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'empresas', 'web', '2026-04-13 13:42:18', '2026-04-13 13:42:18'),
(2, 'cotizaciones', 'web', '2026-04-13 13:42:18', '2026-04-13 13:42:18'),
(3, 'contratos', 'web', '2026-04-13 13:42:18', '2026-04-13 13:42:18'),
(4, 'almacenes', 'web', '2026-04-13 13:42:18', '2026-04-13 13:42:18'),
(5, 'cronogramas', 'web', '2026-04-13 13:42:18', '2026-04-13 13:42:18'),
(6, 'mapas', 'web', '2026-04-13 13:42:18', '2026-04-13 13:42:18'),
(7, 'seguimientos', 'web', '2026-04-13 13:42:18', '2026-04-13 13:42:18'),
(8, 'certificados', 'web', '2026-04-13 13:42:18', '2026-04-13 13:42:18'),
(9, 'cuentascobrar', 'web', '2026-04-13 13:42:18', '2026-04-13 13:42:18'),
(10, 'cuentaspagar', 'web', '2026-04-13 13:42:18', '2026-04-13 13:42:18'),
(11, 'compras', 'web', '2026-04-13 13:42:18', '2026-04-13 13:42:18'),
(12, 'ingresos', 'web', '2026-04-13 13:42:18', '2026-04-13 13:42:18'),
(13, 'retiros', 'web', '2026-04-13 13:42:18', '2026-04-13 13:42:18'),
(14, 'gastos', 'web', '2026-04-13 13:42:18', '2026-04-13 13:42:18'),
(15, 'productos', 'web', '2026-04-13 13:42:18', '2026-04-13 13:42:18'),
(16, 'categorias', 'web', '2026-04-13 13:42:18', '2026-04-13 13:42:18'),
(17, 'subcategorias', 'web', '2026-04-13 13:42:18', '2026-04-13 13:42:18'),
(18, 'marcas', 'web', '2026-04-13 13:42:18', '2026-04-13 13:42:18'),
(19, 'etiquetas', 'web', '2026-04-13 13:42:18', '2026-04-13 13:42:18'),
(20, 'proveedores', 'web', '2026-04-13 13:42:18', '2026-04-13 13:42:18'),
(21, 'inventario', 'web', '2026-04-13 13:42:18', '2026-04-13 13:42:18'),
(22, 'agenda', 'web', '2026-04-13 13:42:18', '2026-04-13 13:42:18'),
(23, 'documentos', 'web', '2026-04-13 13:42:18', '2026-04-13 13:42:18'),
(24, 'usuarios', 'web', '2026-04-13 13:42:18', '2026-04-13 13:42:18'),
(25, 'configuraciones', 'web', '2026-04-13 13:42:18', '2026-04-13 13:42:18');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` text NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `categoria_id` bigint(20) UNSIGNED DEFAULT NULL,
  `marca_id` bigint(20) UNSIGNED DEFAULT NULL,
  `unidad_id` bigint(20) UNSIGNED DEFAULT NULL,
  `nombre` varchar(255) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `unidad_valor` int(11) NOT NULL DEFAULT 1,
  `stock` int(11) DEFAULT NULL,
  `stock_min` int(11) NOT NULL DEFAULT 1,
  `precio_compra` decimal(10,2) DEFAULT NULL,
  `precio_venta` decimal(10,2) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id`, `categoria_id`, `marca_id`, `unidad_id`, `nombre`, `descripcion`, `unidad_valor`, `stock`, `stock_min`, `precio_compra`, `precio_venta`, `created_at`, `updated_at`) VALUES
(1, NULL, NULL, 2, 'FENDONA 6 SC', 'es un insecticida piretroide de acción residual para el control de plagas urbanas y domésticas:', 250, 0, 24, NULL, NULL, '2026-05-01 20:48:25', '2026-05-19 19:50:31'),
(2, NULL, NULL, 1, 'KLERAT', 'es un rodenticida anticoagulante de segunda generación que controla eficazmente guarenes o ratas de alcantarilla (Rattus norvegicus), ratas del tejado (Rattus rattus), lauchas o ratones (Mus musculus) y otras especies peligrosas y dañinas.', 150, 1, 80, 10.00, 15.00, '2026-05-01 20:50:20', '2026-05-04 11:33:19'),
(3, NULL, NULL, 4, 'TITANE 5 EC', 'Es un insecticida piretroide de amplio espectro con alta actividad de contacto y residual recomendado para  control de insectos voladores y rastreros', 1, -2, 5, NULL, NULL, '2026-05-01 20:53:28', '2026-06-22 16:03:53'),
(4, NULL, NULL, 4, 'TITANE DELTA', 'Es un insecticida piretroide a base de deltametrina recomendado para el control de insectos rastreros y voladores la formulacion del producto permite tener un buen efecto inicial y un prolongado efecto residual en las superficies', 1, -2, 5, NULL, NULL, '2026-05-01 20:56:49', '2026-06-22 16:03:53'),
(5, NULL, NULL, 1, 'RATIMOR', 'Es un cebo rodenticida anticuagulante su ingrediente activo es BROMADIOLONA indicado para realizar control de roedores enespacios exteriores y humedos', 150, 275, 10, 10.00, 15.00, '2026-05-01 20:59:31', '2026-05-03 11:36:30'),
(6, NULL, NULL, 4, 'HDQ NEUTRAL', 'Limpiador desodorante  y desinfectante germicida de uso hospitalario de un solo paso diseñado para la limpieza y desinfeccion de superficies cuyo ingrediente activo es amonio cuaternario', 1, -1, 5, NULL, NULL, '2026-05-01 21:03:25', '2026-06-14 00:16:41'),
(7, NULL, NULL, 3, 'INSECTOCUTOR', 'CAPTURA DE INSECTOS VOLADORES', 1, -22, 10, NULL, NULL, '2026-05-19 20:06:12', '2026-06-19 19:02:45');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto_usos`
--

CREATE TABLE `producto_usos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `producto_id` bigint(20) UNSIGNED NOT NULL,
  `seguimiento_id` bigint(20) UNSIGNED NOT NULL,
  `unidad_id` bigint(20) UNSIGNED NOT NULL,
  `cantidad` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `producto_usos`
--

INSERT INTO `producto_usos` (`id`, `producto_id`, `seguimiento_id`, `unidad_id`, `cantidad`, `created_at`, `updated_at`) VALUES
(10, 5, 1, 1, 1, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(12, 2, 3, 1, 1, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(13, 2, 5, 1, 1, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(14, 2, 7, 1, 1, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(15, 2, 9, 1, 1, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(16, 2, 11, 1, 1, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(17, 2, 13, 1, 1, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(18, 2, 15, 1, 1, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(21, 2, 21, 1, 1, '2026-05-13 02:42:02', '2026-05-13 02:42:02'),
(23, 2, 23, 1, 1, '2026-05-14 17:01:10', '2026-05-14 17:01:10'),
(24, 2, 24, 1, 1, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(25, 2, 25, 1, 1, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(26, 2, 26, 1, 1, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(27, 2, 27, 1, 1, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(28, 2, 28, 1, 1, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(29, 2, 29, 1, 1, '2026-05-18 14:55:42', '2026-05-18 14:55:42'),
(30, 2, 30, 1, 1, '2026-05-18 15:56:33', '2026-05-18 15:56:33'),
(31, 2, 31, 1, 1, '2026-05-18 16:34:39', '2026-05-18 16:34:39'),
(32, 2, 32, 1, 1, '2026-05-18 20:43:18', '2026-05-18 20:43:18'),
(33, 2, 33, 1, 1, '2026-05-18 20:57:53', '2026-05-18 20:57:53'),
(34, 2, 34, 1, 1, '2026-05-18 21:18:23', '2026-05-18 21:18:23'),
(35, 2, 35, 1, 1, '2026-05-18 21:31:23', '2026-05-18 21:31:23'),
(36, 2, 36, 1, 1, '2026-05-18 22:35:46', '2026-05-18 22:35:46'),
(37, 2, 37, 1, 1, '2026-05-18 23:21:01', '2026-05-18 23:21:01'),
(38, 2, 38, 1, 1, '2026-05-18 23:36:03', '2026-05-18 23:36:03'),
(39, 2, 39, 1, 1, '2026-05-18 23:43:16', '2026-05-18 23:43:16'),
(41, 2, 41, 1, 1, '2026-05-18 23:57:41', '2026-05-18 23:57:41'),
(42, 2, 42, 1, 1, '2026-05-19 00:04:18', '2026-05-19 00:04:18'),
(43, 1, 43, 2, 1, '2026-05-19 19:50:31', '2026-05-19 19:50:31'),
(44, 1, 44, 2, 1, '2026-05-19 19:54:03', '2026-05-19 19:54:03'),
(45, 7, 46, 3, 1, '2026-05-19 20:08:03', '2026-05-19 20:08:03'),
(46, 7, 47, 3, 1, '2026-05-19 20:10:27', '2026-05-19 20:10:27'),
(47, 7, 45, 3, 1, '2026-05-19 20:11:43', '2026-05-19 20:11:43'),
(48, 7, 48, 3, 1, '2026-05-19 20:21:06', '2026-05-19 20:21:06'),
(49, 7, 49, 3, 1, '2026-05-19 20:23:15', '2026-05-19 20:23:15'),
(51, 7, 51, 3, 1, '2026-05-19 20:33:30', '2026-05-19 20:33:30'),
(52, 7, 50, 3, 1, '2026-05-19 20:48:38', '2026-05-19 20:48:38'),
(55, 2, 40, 1, 1, '2026-05-19 21:17:31', '2026-05-19 21:17:31'),
(59, 2, 52, 1, 1, '2026-05-22 01:59:29', '2026-05-22 01:59:29'),
(61, 7, 53, 3, 3, '2026-05-22 02:03:18', '2026-05-22 02:03:18'),
(62, 2, 54, 1, 20, '2026-05-22 02:09:35', '2026-05-22 02:09:35'),
(73, 2, 20, 1, 1, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(74, 2, 55, 1, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(75, 7, 56, 3, 1, '2026-05-25 22:05:53', '2026-05-25 22:05:53'),
(76, 2, 57, 1, 1, '2026-06-06 17:55:47', '2026-06-06 17:55:47'),
(77, 4, 58, 4, 1, '2026-06-06 17:59:07', '2026-06-06 17:59:07'),
(78, 7, 59, 3, 3, '2026-06-06 18:03:17', '2026-06-06 18:03:17'),
(83, 2, 60, 1, 1, '2026-06-10 13:48:17', '2026-06-10 13:48:17'),
(84, 1, 61, 2, 1, '2026-06-10 13:49:03', '2026-06-10 13:49:03'),
(85, 3, 61, 4, 1, '2026-06-10 13:49:03', '2026-06-10 13:49:03'),
(88, 2, 65, 1, 1, '2026-06-11 18:31:40', '2026-06-11 18:31:40'),
(89, 2, 63, 1, 1, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(93, 7, 64, 3, 3, '2026-06-11 23:17:30', '2026-06-11 23:17:30'),
(95, 7, 67, 3, 1, '2026-06-12 21:55:02', '2026-06-12 21:55:02'),
(96, 2, 66, 1, 1, '2026-06-12 21:59:56', '2026-06-12 21:59:56'),
(99, 1, 68, 2, 1, '2026-06-14 00:18:55', '2026-06-14 00:18:55'),
(100, 6, 68, 4, 1, '2026-06-14 00:18:55', '2026-06-14 00:18:55'),
(101, 2, 69, 1, 1, '2026-06-19 18:55:41', '2026-06-19 18:55:41'),
(102, 7, 70, 3, 3, '2026-06-19 19:02:45', '2026-06-19 19:02:45'),
(103, 7, 62, 3, 3, '2026-06-19 19:04:02', '2026-06-19 19:04:02'),
(104, 4, 71, 4, 1, '2026-06-22 16:03:53', '2026-06-22 16:03:53'),
(105, 3, 71, 4, 1, '2026-06-22 16:03:53', '2026-06-22 16:03:53');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto_vencimientos`
--

CREATE TABLE `producto_vencimientos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `producto_id` bigint(20) UNSIGNED NOT NULL,
  `codigo` varchar(255) NOT NULL,
  `vencimiento` date NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `producto_vencimientos`
--

INSERT INTO `producto_vencimientos` (`id`, `producto_id`, `codigo`, `vencimiento`, `created_at`, `updated_at`) VALUES
(1, 2, '000298', '2026-09-05', '2026-05-03 10:54:30', '2026-05-03 10:54:30');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `protecciones`
--

CREATE TABLE `protecciones` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `protecciones`
--

INSERT INTO `protecciones` (`id`, `nombre`, `created_at`, `updated_at`) VALUES
(1, 'Señalizacion', '2026-04-13 13:42:19', '2026-04-13 13:42:19'),
(2, 'Hoja de seguimiento', '2026-04-13 13:42:19', '2026-04-13 13:42:19'),
(3, 'Otros', '2026-04-13 13:42:19', '2026-04-13 13:42:19');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores`
--

CREATE TABLE `proveedores` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `telefono` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `contacto` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `retiros`
--

CREATE TABLE `retiros` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `concepto` varchar(255) NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'superadmin', 'web', '2026-04-13 13:42:18', '2026-04-13 13:42:18'),
(2, 'admin', 'web', '2026-04-13 13:42:18', '2026-04-13 13:42:18'),
(3, 'tecnico', 'web', '2026-04-13 13:42:18', '2026-04-13 13:42:18'),
(4, 'cliente', 'web', '2026-04-13 13:42:18', '2026-04-13 13:42:18');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `role_has_permissions`
--

INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 1),
(8, 1),
(9, 1),
(10, 1),
(11, 1),
(12, 1),
(13, 1),
(14, 1),
(15, 1),
(16, 1),
(17, 1),
(18, 1),
(19, 1),
(20, 1),
(21, 1),
(22, 1),
(23, 1),
(24, 1),
(25, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `seguimientos`
--

CREATE TABLE `seguimientos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `empresa_id` bigint(20) UNSIGNED NOT NULL,
  `almacen_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `tipo_seguimiento_id` bigint(20) UNSIGNED DEFAULT NULL,
  `contacto_id` bigint(20) UNSIGNED DEFAULT NULL,
  `cronograma_id` bigint(20) UNSIGNED NOT NULL,
  `encargado_nombre` varchar(255) DEFAULT NULL,
  `encargado_cargo` varchar(255) DEFAULT NULL,
  `firma_encargado` varchar(255) DEFAULT NULL,
  `firma_supervisor` varchar(255) DEFAULT NULL,
  `observaciones` text DEFAULT NULL,
  `observacionesp` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `seguimientos`
--

INSERT INTO `seguimientos` (`id`, `empresa_id`, `almacen_id`, `user_id`, `tipo_seguimiento_id`, `contacto_id`, `cronograma_id`, `encargado_nombre`, `encargado_cargo`, `firma_encargado`, `firma_supervisor`, `observaciones`, `observacionesp`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 2, 1, NULL, 872, 'FRANKLIN  PEREZ', 'ENCARGADO VF CASCADA', 'images/firmas/firma_encargado_1777939684.png', 'images/firmas/firma_supervisor_1777939684.png', 'INICIO DE  DESRATIZACION ENERO', 'IMPLEMENTACION DEL SISTEMA INICIO DE TRABAJO', '2026-05-06 03:00:00', '2026-05-04 23:08:04'),
(2, 1, 1, 2, 3, NULL, 900, 'FRANKLIN  PERES', 'ENCARGADO VF', 'images/firmas/firma_encargado_1777820943.png', 'images/firmas/firma_supervisor_1777820943.png', NULL, 'PRIMER SEGUIMIENTO', '2026-05-03 14:09:03', '2026-05-03 14:09:03'),
(3, 1, 1, 2, 1, NULL, 873, 'FRANKLIN  CHAVEZ', 'ENCARGADO DE PLANTA', 'images/firmas/firma_encargado_1778027155.png', 'images/firmas/firma_supervisor_1778027155.png', NULL, 'primer seguimiento febrero', '2026-01-30 03:00:00', '2026-05-05 23:25:55'),
(4, 1, 1, 2, 3, NULL, 901, 'FRANKLIN  PEREZ', 'ENCARGADO DE PLANTA', 'images/firmas/firma_encargado_1777900803.png', 'images/firmas/firma_supervisor_1778027179.png', NULL, 'PRIMER SEGUIMIENTO', '2026-01-30 03:00:00', '2026-05-05 23:26:19'),
(5, 1, 1, 2, 1, NULL, 874, 'FRANKLIN  PEREZ', 'ENCARGADO DE PLANTA', 'images/firmas/firma_encargado_1778027455.png', 'images/firmas/firma_supervisor_1778027455.png', NULL, 'SEGUNDO SEGUIMIENTO 12-12-2026', '2026-02-12 03:00:00', '2026-05-05 23:30:55'),
(6, 1, 1, 2, 3, NULL, 902, 'FRANKLIN PERES', 'ENCARGADO DE PLANTA', 'images/firmas/firma_encargado_1778027530.png', 'images/firmas/firma_supervisor_1778027530.png', NULL, 'SEGUNDA EVALUACION', '2026-02-12 03:00:00', '2026-05-05 23:32:10'),
(7, 1, 1, 2, 1, NULL, 875, 'FRANKLIN   PEREZ', 'ENCARGADO DE PLANTA VF', 'images/firmas/firma_encargado_1778027582.png', 'images/firmas/firma_supervisor_1778027582.png', NULL, 'TERCER SEGUIMIENTO 26/02/2026', '2026-02-26 03:00:00', '2026-05-05 23:33:02'),
(8, 1, 1, 2, 3, NULL, 903, 'FRANKLIN  PEREZ', 'ENCARGADO DE PLANTA', 'images/firmas/firma_encargado_1777908236.png', 'images/firmas/firma_supervisor_1778028214.png', NULL, 'TERCER SEGUIMIENTO 26/02/2026', '2026-02-26 03:00:00', '2026-05-05 23:43:34'),
(9, 1, 1, 2, 1, NULL, 876, 'FRANKLIN   PEREZ', 'ENCARGADO DE PLANTA', 'images/firmas/firma_encargado_1777918799.png', 'images/firmas/firma_supervisor_1778028251.png', NULL, 'CUARTO SEGUIMIENTO 13/3/2026', '2026-03-12 03:00:00', '2026-05-05 23:44:11'),
(10, 1, 1, 2, 3, NULL, 904, 'FRANKLIN PEREDO', 'ENCARGADO DE PLANTA', 'images/firmas/firma_encargado_1777920641.png', 'images/firmas/firma_supervisor_1778028277.png', NULL, 'CUARTA EVALUACION 12/3/2026', '2026-03-12 03:00:00', '2026-05-05 23:44:37'),
(11, 1, 1, 2, 1, NULL, 877, 'FRANKLIN    PEREZ', 'ENCARGADO  PLANTA', 'images/firmas/firma_encargado_1777922317.png', 'images/firmas/firma_supervisor_1778028304.png', NULL, 'QUINTO SEGUIMIENTO 23/03/2026', '2026-03-26 03:00:00', '2026-05-05 23:45:04'),
(12, 1, 1, 2, 3, NULL, 905, 'FRANKLIN PEREZ', 'ENCARGADO  PLANTA VF', 'images/firmas/firma_encargado_1777922564.png', 'images/firmas/firma_supervisor_1778028338.png', NULL, 'QUINTO SEGUIMIENTO 26/03/2026', '2026-03-26 03:00:00', '2026-05-05 23:45:38'),
(13, 1, 1, 2, 1, NULL, 878, 'FRANKLIN   PEREZ', 'ENCARGADO DE PLANTA VF', 'images/firmas/firma_encargado_1777925931.png', 'images/firmas/firma_supervisor_1778028417.png', NULL, 'SEXTO SEGUIMIENTO 09-04-2026', '2026-04-09 03:00:00', '2026-05-05 23:46:57'),
(14, 1, 1, 2, 3, NULL, 906, 'FRANKLIN PEREZ', 'ENCARGADO PLANTA VF', 'images/firmas/firma_encargado_1777926153.png', 'images/firmas/firma_supervisor_1778028443.png', NULL, 'SEGUIMIENTO SEXTO 09-04-2026', '2026-04-09 03:00:00', '2026-05-05 23:47:23'),
(15, 1, 1, 2, 1, NULL, 879, 'FRANKLIN PEREZ', 'ENCARGADO  PLANTA VF', 'images/firmas/firma_encargado_1777927047.png', 'images/firmas/firma_supervisor_1778028478.png', NULL, 'SEGUIMIENTO SEPTIMO 24-04-2026', '2026-04-23 03:00:00', '2026-05-05 23:47:58'),
(16, 1, 1, 2, 3, NULL, 907, 'FRANKLIN   PEREZ', 'ENCARGADO PLANTA VF', 'images/firmas/firma_encargado_1777927581.png', 'images/firmas/firma_supervisor_1778028508.png', NULL, 'SEGUIMIENTO SIETE 24-4-2026', '2026-04-23 03:00:00', '2026-05-05 23:48:28'),
(17, 1, 1, 3, 1, NULL, 880, 'Rodrigo Velázquez', 'Jefe de planta', 'images/firmas/firma_encargado_1779750603.png', 'images/firmas/firma_supervisor_1779750603.png', 'Seguir manteniendo orden y no tratar de obstáculisar las unidades de control de roedores', NULL, '2026-05-07 03:00:00', '2026-05-25 22:10:03'),
(18, 1, 1, 3, 3, NULL, 908, 'Rodrigo Velázquez', 'Jefe de planta', 'images/firmas/firma_encargado_1778187427.png', 'images/firmas/firma_supervisor_1778187427.png', NULL, 'Se realizó la limpieza de los tres equipos', '2026-05-07 03:00:00', '2026-05-07 03:00:00'),
(19, 2, 4, 5, 3, NULL, 465, 'David Foronda Lopez', 'Analista de calidad', 'images/firmas/firma_encargado_1779750522.png', 'images/firmas/firma_supervisor_1779750522.png', NULL, 'Mantener orden y limpieza', '2026-05-08 03:00:00', '2026-05-25 22:08:42'),
(20, 2, 4, 5, 1, NULL, 437, 'David Foronda Lopez', 'Auxiliar de calidad', 'images/firmas/firma_encargado_1779750206.png', 'images/firmas/firma_supervisor_1779750206.png', NULL, 'Se encotro una rata muerta en trampa captura viva nro. 7  Mantener orden y limpieza,se recomienda mantener despejado las unidades de control', '2026-05-08 03:00:00', '2026-05-25 22:03:26'),
(21, 5, 8, 5, 1, NULL, 934, 'Carlos Julian', 'Jefe de centro de distribución', 'images/firmas/firma_encargado_1778643722.png', 'images/firmas/firma_supervisor_1778643722.png', NULL, 'Se capturo un roedor en la unidad de control #2 , mantener orden y limpieza, mantener despejado las unidades de control', '2026-05-09 03:00:00', '2026-05-13 02:42:02'),
(22, 5, 8, 5, 2, NULL, 939, 'Carlos Julian', 'Jefe de centro de distribución', 'images/firmas/firma_encargado_1779750459.png', 'images/firmas/firma_supervisor_1779750459.png', NULL, NULL, '2026-05-09 03:00:00', '2026-05-25 22:07:39'),
(23, 3, 5, 5, 1, NULL, 610, 'henrry', 'encargado', 'images/firmas/firma_encargado_1778781670.png', 'images/firmas/firma_supervisor_1778781670.png', NULL, 'Mantener orden y limpieza, mantener despejado las unidades de control interno', '2026-05-07 03:00:00', '2026-05-14 17:01:10'),
(24, 2, 4, 2, 1, NULL, 430, 'FRANKLIN PAREJA', 'ENCARGADO DE PLANTA', 'images/firmas/firma_encargado_1778977459.png', 'images/firmas/firma_supervisor_1778977459.png', NULL, 'PLANTA LIMPIA Y ORDENADA', '2026-01-31 03:00:00', '2026-01-31 03:00:00'),
(25, 2, 4, 2, 1, NULL, 431, 'FRANKLIN  PAREJA', 'ENCARGADO  DE  PLANTA', 'images/firmas/firma_encargado_1778988170.png', 'images/firmas/firma_supervisor_1778988170.png', NULL, 'MANTENER LIMPIO Y ORDENADO TODA LA PLANTA', '2026-02-13 03:00:00', '2026-02-13 03:00:00'),
(26, 2, 4, 2, 1, NULL, 432, 'FRANKLIN     PAREJA', 'ENCARGADO DE PLANTA', 'images/firmas/firma_encargado_1778991653.png', 'images/firmas/firma_supervisor_1778991653.png', NULL, 'PLANTA  LIMPIA Y ORDENADA SE RECOMIENDA MANTENIEMENTO DE LAS PUESRTAS  DE INGRESO.NER', '2026-02-27 03:00:00', '2026-02-27 03:00:00'),
(27, 2, 4, 2, 1, NULL, 433, 'FRANKLIN   PAREJA', 'ENCARGADO   DE  PLANTA', 'images/firmas/firma_encargado_1778994994.png', 'images/firmas/firma_supervisor_1778994994.png', NULL, 'PLANTA LIMPIA Y ORDENADA', '2026-03-13 03:00:00', '2026-03-13 03:00:00'),
(28, 2, 4, 2, 1, NULL, 434, 'FRANKLIN  PAREJA', 'ENCARGADO DE PLANTA', 'images/firmas/firma_encargado_1778996528.png', 'images/firmas/firma_supervisor_1778996528.png', 'TRABAJO REALIZADO SEGUN CRONOGRAMA', 'PLANTA LIMPIA Y ORDENADA', '2026-03-27 03:00:00', '2026-03-27 03:00:00'),
(29, 3, 5, 2, 1, NULL, 603, 'MIGUEL VARGAS', 'ENCARGADO DE PLANTA', 'images/firmas/firma_encargado_1779119742.png', 'images/firmas/firma_supervisor_1779119742.png', 'SE  CUMPLIO  CON  EL CRONOGRAMA PROPUESTO', 'DISTRIBUIDORA LIMPIA Y ORDENADA', '2026-01-30 03:00:00', '2026-01-30 03:00:00'),
(30, 3, 5, 2, 1, NULL, 604, 'MIGUEL VARGAS', 'ENCARGADO LLOJETA', 'images/firmas/firma_encargado_1779123393.png', 'images/firmas/firma_supervisor_1779123393.png', NULL, 'DISTRIBUIDORA LIMPIA Y ORDENADA', '2026-02-12 03:00:00', '2026-02-12 03:00:00'),
(31, 3, 5, 2, 1, NULL, 605, 'MIGUEL  VARGAS', 'ENCARGADO DE PLANTA', 'images/firmas/firma_encargado_1779125679.png', 'images/firmas/firma_supervisor_1779125679.png', NULL, 'DISTRIBUIDORA LIMPIA Y ORDENADA', '2026-02-26 03:00:00', '2026-02-26 03:00:00'),
(32, 3, 5, 2, 1, NULL, 606, 'MIGUEL VARGAS', 'ENCARGADO DE PLANTA', 'images/firmas/firma_encargado_1779140598.png', 'images/firmas/firma_supervisor_1779140598.png', NULL, 'PLANTA LIMPIA Y ORDENADA', '2026-03-12 03:00:00', '2026-03-12 03:00:00'),
(33, 3, 5, 2, 1, NULL, 607, 'MIGUEL  VARGAS', 'ENCARGADO DE PLANTA', 'images/firmas/firma_encargado_1779141473.png', 'images/firmas/firma_supervisor_1779141473.png', NULL, 'PLANTA LIMPIA Y ORDENADA', '2026-03-26 03:00:00', '2026-03-26 03:00:00'),
(34, 3, 5, 2, 1, NULL, 608, 'MIGUEL VARGAS', 'ENCARGADO DE PLANTA', 'images/firmas/firma_encargado_1779142703.png', 'images/firmas/firma_supervisor_1779142703.png', NULL, 'PLANTA LIMPIA Y ORDENADA', '2026-04-09 03:00:00', '2026-04-09 03:00:00'),
(35, 3, 5, 2, 1, NULL, 609, 'MIGUEL VARGAS', 'ENCARGADO DE PLANTA', 'images/firmas/firma_encargado_1779143483.png', 'images/firmas/firma_supervisor_1779143483.png', NULL, 'PLANTA LIMPIA Y ORDENADA', '2026-04-23 03:00:00', '2026-04-23 03:00:00'),
(36, 4, 7, 2, 1, NULL, 631, 'ALDO COLPARI', 'ENCARGADO DE PLANTA', 'images/firmas/firma_encargado_1779147345.png', 'images/firmas/firma_supervisor_1779147345.png', NULL, 'PLANTA LIMPIA Y ORDENADA', '2026-01-24 03:00:00', '2026-01-24 03:00:00'),
(37, 4, 7, 2, 1, NULL, 632, 'ALDO COLPARI', 'ENCARGADO DE PLANTA', 'images/firmas/firma_encargado_1779150061.png', 'images/firmas/firma_supervisor_1779150061.png', NULL, 'PLANTA LIMPIA Y ORDENADA', '2026-02-07 03:00:00', '2026-02-07 03:00:00'),
(38, 4, 7, 2, 1, NULL, 633, 'ALDO  COLPARI', 'ENCARGADO DE  PLANTA', 'images/firmas/firma_encargado_1779150963.png', 'images/firmas/firma_supervisor_1779150963.png', NULL, 'PLANTA LIMPIA Y ORDENADA', '2026-02-20 03:00:00', '2026-02-20 03:00:00'),
(39, 4, 7, 2, 1, NULL, 634, 'ALDO  COLPARI', 'ENCARGADO DE PLANTA', 'images/firmas/firma_encargado_1779151396.png', 'images/firmas/firma_supervisor_1779151396.png', NULL, 'PLANTA  LIMPIA Y ORDENADA', '2026-03-11 03:00:00', '2026-03-11 03:00:00'),
(40, 4, 7, 2, 1, NULL, 635, 'ALDO COLPARI', 'ENCARGADO DE PLANTA', 'images/firmas/firma_encargado_1779229051.png', 'images/firmas/firma_supervisor_1779229051.png', NULL, 'PLANTA LIMPIA Y ORDENADA SE CAPTURO UN ROEDOR TRAMPA 14', '2026-03-25 03:00:00', '2026-05-19 21:17:31'),
(41, 4, 7, 2, 1, NULL, 636, 'ALDO  COLPARI', 'ENCARGADO DE PLANTA', 'images/firmas/firma_encargado_1779152261.png', 'images/firmas/firma_supervisor_1779152261.png', NULL, 'PLANTA LIMPIA Y ORDENADA', '2026-04-14 03:00:00', '2026-04-14 03:00:00'),
(42, 4, 7, 2, 1, NULL, 637, 'ALDO  COLPARI', 'ENCARGADO DE PLANTA', 'images/firmas/firma_encargado_1779152658.png', 'images/firmas/firma_supervisor_1779152658.png', NULL, 'PLANTA LIMPIA Y ORDENADA', '2026-04-28 03:00:00', '2026-04-28 03:00:00'),
(43, 4, 7, 2, 2, NULL, 654, 'ALDO    COLPARI', 'ENCARGADO DE PLANTA', 'images/firmas/firma_encargado_1779223831.png', 'images/firmas/firma_supervisor_1779223831.png', NULL, 'PLANTA LIMPIA Y ORDENADA', '2026-01-24 03:00:00', '2026-01-24 03:00:00'),
(44, 4, 7, 2, 2, NULL, 655, 'ALDO COLPARI', 'ENCARGADO DE PLANTA', 'images/firmas/firma_encargado_1779224043.png', 'images/firmas/firma_supervisor_1779224043.png', NULL, 'PLANTA LIMPIA Y ORDENADA', '2026-04-28 03:00:00', '2026-04-28 03:00:00'),
(45, 4, 7, 2, 3, NULL, 659, 'ALDO COLPANI', 'ENCARGADO DE PLANTA', 'images/firmas/firma_encargado_1779225103.png', 'images/firmas/firma_supervisor_1779225103.png', NULL, 'EQUIPO RECIEN INSTALADO', '2026-01-24 03:00:00', '2026-05-19 20:11:43'),
(46, 4, 7, 2, 3, NULL, 660, 'ALDO COLPARI', 'ENCARGADO DE PLANTA', 'images/firmas/firma_encargado_1779224883.png', 'images/firmas/firma_supervisor_1779224883.png', NULL, 'PRIMER SEGUIMIENTO', '2026-02-07 03:00:00', '2026-02-07 03:00:00'),
(47, 4, 7, 2, 3, NULL, 661, 'ALDO COLPANI', 'ENCARGADO DE PLANTA', 'images/firmas/firma_encargado_1779225027.png', 'images/firmas/firma_supervisor_1779225027.png', NULL, 'SEGUNDO SEGUIMIENTO', '2026-02-20 03:00:00', '2026-02-20 03:00:00'),
(48, 4, 7, 2, 3, NULL, 662, 'ALDO   COLPANI', 'ENCARGADO DE PLANTA', 'images/firmas/firma_encargado_1779225666.png', 'images/firmas/firma_supervisor_1779225666.png', NULL, 'TERCER SEGUIMIENTO', '2026-03-11 03:00:00', '2026-03-11 03:00:00'),
(49, 4, 7, 2, 3, NULL, 663, 'ALDO COLPANI', 'ENCARGADO DE PLANTA', 'images/firmas/firma_encargado_1779225795.png', 'images/firmas/firma_supervisor_1779225795.png', NULL, 'CUARTO SEGUIMIENTO', '2026-03-25 03:00:00', '2026-03-25 03:00:00'),
(50, 4, 7, 2, 3, NULL, 664, 'ALDO  COLPARI', 'ENCARGADO DE PLANTA', 'images/firmas/firma_encargado_1779227318.png', 'images/firmas/firma_supervisor_1779227318.png', NULL, 'QUINTA EVALUACION', '2026-04-14 03:00:00', '2026-05-19 20:48:38'),
(51, 4, 7, 2, 3, NULL, 665, 'ALDO  COLPANI', 'ENCARGADO DE PLANTA', 'images/firmas/firma_encargado_1779226410.png', 'images/firmas/firma_supervisor_1779226410.png', NULL, 'SEXTO SEGUIMIENTO', '2026-04-28 03:00:00', '2026-04-28 03:00:00'),
(52, 1, 1, 5, 1, NULL, 881, 'Rodrigo Velázquez', 'Jefe de planta', 'images/firmas/firma_encargado_1779382664.png', 'images/firmas/firma_supervisor_1779382664.png', NULL, 'Mantener orden y limpieza y mantener despejado las unidades de control interno', '2026-05-21 03:00:00', '2026-05-21 03:00:00'),
(53, 1, 1, 5, 3, NULL, 909, 'Rodrigo Velázquez', 'Jefe de planta', 'images/firmas/firma_encargado_1779382880.png', 'images/firmas/firma_supervisor_1779382880.png', NULL, 'Mantener orden y limpieza mantener encendido los equipos', '2026-05-21 03:00:00', '2026-05-22 02:03:18'),
(54, 3, 5, 5, 1, NULL, 611, 'Henry Cejas', 'Recepcionista', 'images/firmas/firma_encargado_1779390810.png', 'images/firmas/firma_supervisor_1779419375.png', NULL, 'Mantener orden y limpieza, mantener despejado las unidades de control', '2026-05-21 03:00:00', '2026-05-22 02:09:35'),
(55, 2, 4, 5, 1, NULL, 438, 'David Foronda Lopez', 'Analista de calidad', 'images/firmas/firma_encargado_1779750290.png', 'images/firmas/firma_supervisor_1779750290.png', NULL, 'Mantener orden y limpieza, mantener despejado las unidades de control interno', '2026-05-22 03:00:00', '2026-05-25 22:04:50'),
(56, 2, 4, 5, 3, NULL, 466, 'David Foronda Lopez', 'Analista de calidad', 'images/firmas/firma_encargado_1779468964.png', 'images/firmas/firma_supervisor_1779750353.png', NULL, 'Mantener despejado la unidad de control', '2026-05-22 03:00:00', '2026-05-25 22:05:53'),
(57, 6, 9, 5, 1, NULL, 940, 'Dra Kimberly Contreras Canazas', 'Regente farmacéutico', NULL, 'images/firmas/firma_supervisor_1780772147.png', 'Mantener orden y limpieza cerrar los posibles accesos para evitar el ingreso de vectores', 'Mantener orden y limpieza, mantener despejado las unidades de control interno', '2026-06-06 03:00:00', '2026-06-06 03:00:00'),
(58, 6, 9, 5, 2, NULL, 954, 'Dra Kimberly Contreras Canazas', 'Regente farmacéutico', 'images/firmas/firma_encargado_1780772347.png', 'images/firmas/firma_supervisor_1780772347.png', NULL, 'Mantener orden y limpieza', '2026-06-06 03:00:00', '2026-06-06 03:00:00'),
(59, 6, 9, 5, 3, NULL, 961, 'Dra Kimberly Contreras Canazas', 'Regente farmacéutico', 'images/firmas/firma_encargado_1780772597.png', 'images/firmas/firma_supervisor_1780772597.png', NULL, 'Mantener orden y limpieza', '2026-06-06 03:00:00', '2026-06-06 03:00:00'),
(60, 11, 14, 2, 1, NULL, 1173, 'LIC. MAURICIO MAYDANA', 'ADMINISTRADOR', 'images/firmas/firma_encargado_1781102869.png', 'images/firmas/firma_supervisor_1781101561.png', 'AMBIENTES LIMPIOS Y ORDENADOS', 'INICIO DEL SISTEMA DE CONTROL DE ROEDORES', '2026-06-03 03:00:00', '2026-06-10 13:47:49'),
(61, 11, 14, 2, 2, NULL, 1180, 'LIC. MAURICIO MAYDANA', 'ADMINISTRADOR', 'images/firmas/firma_encargado_1781102943.png', 'images/firmas/firma_supervisor_1781102759.png', 'INICIO DE LOS TRATAMIENTOS', 'PRIMERA APLICACION DESINSECTACION  DESINFECCION', '2026-06-03 03:00:00', '2026-06-10 13:49:03'),
(62, 6, 9, 5, 3, NULL, 1128, 'Dra Kimberly Contreras canazas', 'Regente farmacaseutica', 'images/firmas/firma_encargado_1781899442.png', 'images/firmas/firma_supervisor_1781104002.png', NULL, 'Mantener orden y limpieza', '2026-06-09 03:00:00', '2026-06-19 19:04:02'),
(63, 1, 1, 5, 1, NULL, 882, 'ING Rodrigo Velázquez', 'Jefe de planta de producción', 'images/firmas/firma_encargado_1781198902.png', 'images/firmas/firma_supervisor_1781198902.png', 'Mantener orden y limpieza mantener despejado las unidades de control y tener cuidado con las unidades para no dañarlas', 'Se realizó el cambio de unidades de control interno a unidades de control físico sin ningún tipo de rodenticida se cambiaron, 7 unidades cebaderos a captura víva', '2026-06-11 03:00:00', '2026-06-11 03:00:00'),
(64, 1, 1, 5, 3, NULL, 910, 'ING Rodrigo Velázquez', 'Jefe de planta de producción', 'images/firmas/firma_encargado_1781199089.png', 'images/firmas/firma_supervisor_1781199089.png', NULL, 'Mantener despejado las unidades de control, mantener encendido las. Unidades de control', '2026-06-11 03:00:00', '2026-06-11 23:17:30'),
(65, 3, 5, 5, 1, NULL, 612, 'Henry cejas', 'Recepcionista', 'images/firmas/firma_encargado_1781206300.png', 'images/firmas/firma_supervisor_1781206300.png', NULL, 'Mantener orden y limpieza, mantener despejado las unidades de control interno', '2026-06-11 03:00:00', '2026-06-11 03:00:00'),
(66, 2, 4, 5, 1, NULL, 439, 'ING PABLO ECHARIQUE', 'Encargado de calidad', 'images/firmas/firma_encargado_1781280496.png', 'images/firmas/firma_supervisor_1781280496.png', NULL, 'Mantener orden y limpieza ,mantener despejado las unidades de control para evitar posibles daños se, realizó el implemento de sustancias pegajosas en los almacenes internos de las unidades 54 a 98', '2026-06-12 03:00:00', '2026-06-12 21:59:56'),
(67, 2, 4, 5, 3, NULL, 467, 'ING Pablo Echarique', 'Encargado de calidad', 'images/firmas/firma_encargado_1781304902.png', 'images/firmas/firma_supervisor_1781304902.png', NULL, 'Mantener despejado la unidad de control', '2026-06-12 03:00:00', '2026-06-12 03:00:00'),
(68, 1, 1, 2, 2, NULL, 897, 'Ing. Rodrigo Velasquez', 'ENCARGADO DE PLANTA', 'images/firmas/firma_encargado_1781399935.png', 'images/firmas/firma_supervisor_1781399801.png', 'PLANTA LIMPIA Y ORDENADA', 'SEGUNDA APLICACION', '2026-06-13 03:00:00', '2026-06-14 00:18:55'),
(69, 6, 9, 5, 1, NULL, 1107, 'Dra Kimberly Contreras Canazas', 'Regente farmacaseutico', 'images/firmas/firma_encargado_1781898941.png', 'images/firmas/firma_supervisor_1781898941.png', NULL, 'Mantener orden y limpieza, mantener despejado las unidades de control interno', '2026-06-20 03:00:00', '2026-06-20 03:00:00'),
(70, 6, 9, 5, 3, NULL, 1129, 'Dra Kimberly Contreras Canazas', 'Regente farmacaseutico', 'images/firmas/firma_encargado_1781899365.png', 'images/firmas/firma_supervisor_1781899365.png', NULL, NULL, '2026-06-19 03:00:00', '2026-06-19 03:00:00'),
(71, 2, 4, 5, 2, NULL, 454, 'ING Pablo Echarique', 'Encargado de calidad', NULL, 'images/firmas/firma_supervisor_1782147833.png', NULL, 'Mantener limpieza en almacenes', '2026-06-22 03:00:00', '2026-06-22 03:00:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `seguimiento_biologicos`
--

CREATE TABLE `seguimiento_biologicos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `seguimiento_id` bigint(20) UNSIGNED NOT NULL,
  `biologico_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `seguimiento_biologicos`
--

INSERT INTO `seguimiento_biologicos` (`id`, `seguimiento_id`, `biologico_id`, `created_at`, `updated_at`) VALUES
(2, 22, 6, '2026-05-25 22:07:39', '2026-05-25 22:07:39'),
(3, 71, 6, '2026-06-22 16:03:53', '2026-06-22 16:03:53');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `seguimiento_epps`
--

CREATE TABLE `seguimiento_epps` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `seguimiento_id` bigint(20) UNSIGNED NOT NULL,
  `epp_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `seguimiento_epps`
--

INSERT INTO `seguimiento_epps` (`id`, `seguimiento_id`, `epp_id`, `created_at`, `updated_at`) VALUES
(6, 2, 2, '2026-05-03 14:09:03', '2026-05-03 14:09:03'),
(7, 2, 4, '2026-05-03 14:09:03', '2026-05-03 14:09:03'),
(8, 2, 5, '2026-05-03 14:09:03', '2026-05-03 14:09:03'),
(9, 2, 1, '2026-05-03 14:09:03', '2026-05-03 14:09:03'),
(10, 2, 6, '2026-05-03 14:09:03', '2026-05-03 14:09:03'),
(81, 1, 2, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(82, 1, 4, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(83, 1, 5, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(84, 1, 1, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(85, 1, 6, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(94, 3, 4, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(95, 3, 5, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(96, 3, 1, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(97, 3, 6, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(98, 4, 4, '2026-05-05 23:26:19', '2026-05-05 23:26:19'),
(99, 4, 5, '2026-05-05 23:26:19', '2026-05-05 23:26:19'),
(100, 4, 1, '2026-05-05 23:26:19', '2026-05-05 23:26:19'),
(101, 4, 6, '2026-05-05 23:26:19', '2026-05-05 23:26:19'),
(102, 5, 2, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(103, 5, 4, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(104, 5, 5, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(105, 5, 1, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(106, 5, 6, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(110, 6, 4, '2026-05-05 23:32:10', '2026-05-05 23:32:10'),
(111, 6, 5, '2026-05-05 23:32:10', '2026-05-05 23:32:10'),
(112, 6, 1, '2026-05-05 23:32:10', '2026-05-05 23:32:10'),
(113, 7, 2, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(114, 7, 4, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(115, 7, 5, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(116, 7, 1, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(117, 7, 6, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(118, 8, 2, '2026-05-05 23:43:34', '2026-05-05 23:43:34'),
(119, 8, 4, '2026-05-05 23:43:34', '2026-05-05 23:43:34'),
(120, 8, 5, '2026-05-05 23:43:34', '2026-05-05 23:43:34'),
(121, 8, 1, '2026-05-05 23:43:34', '2026-05-05 23:43:34'),
(122, 8, 6, '2026-05-05 23:43:34', '2026-05-05 23:43:34'),
(123, 9, 2, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(124, 9, 4, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(125, 9, 5, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(126, 9, 1, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(127, 9, 6, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(128, 10, 4, '2026-05-05 23:44:37', '2026-05-05 23:44:37'),
(129, 10, 5, '2026-05-05 23:44:37', '2026-05-05 23:44:37'),
(130, 10, 1, '2026-05-05 23:44:37', '2026-05-05 23:44:37'),
(131, 10, 6, '2026-05-05 23:44:37', '2026-05-05 23:44:37'),
(132, 11, 2, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(133, 11, 4, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(134, 11, 5, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(135, 11, 1, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(136, 11, 6, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(137, 12, 2, '2026-05-05 23:45:38', '2026-05-05 23:45:38'),
(138, 12, 4, '2026-05-05 23:45:38', '2026-05-05 23:45:38'),
(139, 12, 5, '2026-05-05 23:45:38', '2026-05-05 23:45:38'),
(140, 12, 1, '2026-05-05 23:45:38', '2026-05-05 23:45:38'),
(141, 12, 6, '2026-05-05 23:45:38', '2026-05-05 23:45:38'),
(142, 13, 2, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(143, 13, 4, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(144, 13, 5, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(145, 13, 1, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(146, 13, 6, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(147, 14, 2, '2026-05-05 23:47:23', '2026-05-05 23:47:23'),
(148, 14, 4, '2026-05-05 23:47:23', '2026-05-05 23:47:23'),
(149, 14, 5, '2026-05-05 23:47:23', '2026-05-05 23:47:23'),
(150, 14, 1, '2026-05-05 23:47:23', '2026-05-05 23:47:23'),
(151, 14, 6, '2026-05-05 23:47:23', '2026-05-05 23:47:23'),
(152, 15, 2, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(153, 15, 4, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(154, 15, 5, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(155, 15, 1, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(156, 15, 6, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(157, 16, 2, '2026-05-05 23:48:28', '2026-05-05 23:48:28'),
(158, 16, 4, '2026-05-05 23:48:28', '2026-05-05 23:48:28'),
(159, 16, 5, '2026-05-05 23:48:28', '2026-05-05 23:48:28'),
(160, 16, 1, '2026-05-05 23:48:28', '2026-05-05 23:48:28'),
(161, 16, 6, '2026-05-05 23:48:28', '2026-05-05 23:48:28'),
(214, 18, 6, '2026-05-12 11:58:42', '2026-05-12 11:58:42'),
(215, 18, 2, '2026-05-12 11:58:42', '2026-05-12 11:58:42'),
(216, 18, 4, '2026-05-12 11:58:42', '2026-05-12 11:58:42'),
(217, 18, 5, '2026-05-12 11:58:42', '2026-05-12 11:58:42'),
(218, 18, 9, '2026-05-12 11:58:42', '2026-05-12 11:58:42'),
(219, 18, 1, '2026-05-12 11:58:42', '2026-05-12 11:58:42'),
(237, 21, 6, '2026-05-13 02:42:02', '2026-05-13 02:42:02'),
(238, 21, 2, '2026-05-13 02:42:02', '2026-05-13 02:42:02'),
(239, 21, 4, '2026-05-13 02:42:02', '2026-05-13 02:42:02'),
(240, 21, 5, '2026-05-13 02:42:02', '2026-05-13 02:42:02'),
(241, 21, 1, '2026-05-13 02:42:02', '2026-05-13 02:42:02'),
(248, 23, 6, '2026-05-14 17:01:10', '2026-05-14 17:01:10'),
(249, 23, 2, '2026-05-14 17:01:10', '2026-05-14 17:01:10'),
(250, 23, 4, '2026-05-14 17:01:10', '2026-05-14 17:01:10'),
(251, 23, 5, '2026-05-14 17:01:10', '2026-05-14 17:01:10'),
(252, 23, 1, '2026-05-14 17:01:10', '2026-05-14 17:01:10'),
(253, 23, 11, '2026-05-14 17:01:10', '2026-05-14 17:01:10'),
(254, 24, 2, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(255, 24, 4, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(256, 24, 5, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(257, 24, 1, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(258, 24, 6, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(259, 25, 2, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(260, 25, 4, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(261, 25, 5, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(262, 25, 6, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(263, 26, 2, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(264, 26, 5, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(265, 26, 6, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(266, 26, 4, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(267, 27, 2, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(268, 27, 4, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(269, 27, 5, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(270, 27, 6, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(271, 28, 2, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(272, 28, 4, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(273, 28, 5, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(274, 28, 6, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(275, 29, 2, '2026-05-18 14:55:42', '2026-05-18 14:55:42'),
(276, 29, 4, '2026-05-18 14:55:42', '2026-05-18 14:55:42'),
(277, 29, 5, '2026-05-18 14:55:42', '2026-05-18 14:55:42'),
(278, 29, 6, '2026-05-18 14:55:42', '2026-05-18 14:55:42'),
(279, 30, 2, '2026-05-18 15:56:33', '2026-05-18 15:56:33'),
(280, 30, 4, '2026-05-18 15:56:33', '2026-05-18 15:56:33'),
(281, 30, 5, '2026-05-18 15:56:33', '2026-05-18 15:56:33'),
(282, 30, 6, '2026-05-18 15:56:33', '2026-05-18 15:56:33'),
(283, 31, 5, '2026-05-18 16:34:39', '2026-05-18 16:34:39'),
(284, 31, 6, '2026-05-18 16:34:39', '2026-05-18 16:34:39'),
(285, 31, 2, '2026-05-18 16:34:39', '2026-05-18 16:34:39'),
(286, 31, 4, '2026-05-18 16:34:39', '2026-05-18 16:34:39'),
(287, 32, 2, '2026-05-18 20:43:18', '2026-05-18 20:43:18'),
(288, 32, 4, '2026-05-18 20:43:18', '2026-05-18 20:43:18'),
(289, 32, 5, '2026-05-18 20:43:18', '2026-05-18 20:43:18'),
(290, 32, 6, '2026-05-18 20:43:18', '2026-05-18 20:43:18'),
(291, 33, 2, '2026-05-18 20:57:53', '2026-05-18 20:57:53'),
(292, 33, 4, '2026-05-18 20:57:53', '2026-05-18 20:57:53'),
(293, 33, 5, '2026-05-18 20:57:53', '2026-05-18 20:57:53'),
(294, 33, 6, '2026-05-18 20:57:53', '2026-05-18 20:57:53'),
(295, 34, 2, '2026-05-18 21:18:23', '2026-05-18 21:18:23'),
(296, 34, 5, '2026-05-18 21:18:23', '2026-05-18 21:18:23'),
(297, 34, 4, '2026-05-18 21:18:23', '2026-05-18 21:18:23'),
(298, 34, 6, '2026-05-18 21:18:23', '2026-05-18 21:18:23'),
(299, 35, 2, '2026-05-18 21:31:23', '2026-05-18 21:31:23'),
(300, 35, 7, '2026-05-18 21:31:23', '2026-05-18 21:31:23'),
(301, 35, 4, '2026-05-18 21:31:23', '2026-05-18 21:31:23'),
(302, 35, 5, '2026-05-18 21:31:23', '2026-05-18 21:31:23'),
(303, 35, 6, '2026-05-18 21:31:23', '2026-05-18 21:31:23'),
(304, 36, 2, '2026-05-18 22:35:45', '2026-05-18 22:35:45'),
(305, 36, 4, '2026-05-18 22:35:45', '2026-05-18 22:35:45'),
(306, 36, 5, '2026-05-18 22:35:45', '2026-05-18 22:35:45'),
(307, 36, 7, '2026-05-18 22:35:45', '2026-05-18 22:35:45'),
(308, 36, 6, '2026-05-18 22:35:46', '2026-05-18 22:35:46'),
(309, 37, 2, '2026-05-18 23:21:01', '2026-05-18 23:21:01'),
(310, 37, 7, '2026-05-18 23:21:01', '2026-05-18 23:21:01'),
(311, 37, 4, '2026-05-18 23:21:01', '2026-05-18 23:21:01'),
(312, 37, 5, '2026-05-18 23:21:01', '2026-05-18 23:21:01'),
(313, 37, 6, '2026-05-18 23:21:01', '2026-05-18 23:21:01'),
(314, 38, 2, '2026-05-18 23:36:03', '2026-05-18 23:36:03'),
(315, 38, 4, '2026-05-18 23:36:03', '2026-05-18 23:36:03'),
(316, 38, 5, '2026-05-18 23:36:03', '2026-05-18 23:36:03'),
(317, 38, 1, '2026-05-18 23:36:03', '2026-05-18 23:36:03'),
(318, 38, 7, '2026-05-18 23:36:03', '2026-05-18 23:36:03'),
(319, 38, 6, '2026-05-18 23:36:03', '2026-05-18 23:36:03'),
(320, 39, 2, '2026-05-18 23:43:16', '2026-05-18 23:43:16'),
(321, 39, 7, '2026-05-18 23:43:16', '2026-05-18 23:43:16'),
(322, 39, 4, '2026-05-18 23:43:16', '2026-05-18 23:43:16'),
(323, 39, 5, '2026-05-18 23:43:16', '2026-05-18 23:43:16'),
(324, 39, 6, '2026-05-18 23:43:16', '2026-05-18 23:43:16'),
(330, 41, 4, '2026-05-18 23:57:41', '2026-05-18 23:57:41'),
(331, 41, 5, '2026-05-18 23:57:41', '2026-05-18 23:57:41'),
(332, 41, 7, '2026-05-18 23:57:41', '2026-05-18 23:57:41'),
(333, 41, 2, '2026-05-18 23:57:41', '2026-05-18 23:57:41'),
(334, 41, 6, '2026-05-18 23:57:41', '2026-05-18 23:57:41'),
(335, 42, 2, '2026-05-19 00:04:18', '2026-05-19 00:04:18'),
(336, 42, 7, '2026-05-19 00:04:18', '2026-05-19 00:04:18'),
(337, 42, 4, '2026-05-19 00:04:18', '2026-05-19 00:04:18'),
(338, 42, 5, '2026-05-19 00:04:18', '2026-05-19 00:04:18'),
(339, 42, 6, '2026-05-19 00:04:18', '2026-05-19 00:04:18'),
(340, 43, 4, '2026-05-19 19:50:31', '2026-05-19 19:50:31'),
(341, 43, 5, '2026-05-19 19:50:31', '2026-05-19 19:50:31'),
(342, 43, 6, '2026-05-19 19:50:31', '2026-05-19 19:50:31'),
(343, 43, 10, '2026-05-19 19:50:31', '2026-05-19 19:50:31'),
(344, 44, 2, '2026-05-19 19:54:03', '2026-05-19 19:54:03'),
(345, 44, 4, '2026-05-19 19:54:03', '2026-05-19 19:54:03'),
(346, 44, 5, '2026-05-19 19:54:03', '2026-05-19 19:54:03'),
(347, 44, 10, '2026-05-19 19:54:03', '2026-05-19 19:54:03'),
(352, 46, 2, '2026-05-19 20:08:03', '2026-05-19 20:08:03'),
(353, 46, 4, '2026-05-19 20:08:03', '2026-05-19 20:08:03'),
(354, 46, 5, '2026-05-19 20:08:03', '2026-05-19 20:08:03'),
(355, 46, 6, '2026-05-19 20:08:03', '2026-05-19 20:08:03'),
(356, 46, 7, '2026-05-19 20:08:03', '2026-05-19 20:08:03'),
(357, 47, 2, '2026-05-19 20:10:27', '2026-05-19 20:10:27'),
(358, 47, 7, '2026-05-19 20:10:27', '2026-05-19 20:10:27'),
(359, 47, 4, '2026-05-19 20:10:27', '2026-05-19 20:10:27'),
(360, 47, 5, '2026-05-19 20:10:27', '2026-05-19 20:10:27'),
(361, 47, 6, '2026-05-19 20:10:27', '2026-05-19 20:10:27'),
(362, 45, 2, '2026-05-19 20:11:43', '2026-05-19 20:11:43'),
(363, 45, 4, '2026-05-19 20:11:43', '2026-05-19 20:11:43'),
(364, 45, 5, '2026-05-19 20:11:43', '2026-05-19 20:11:43'),
(365, 45, 6, '2026-05-19 20:11:43', '2026-05-19 20:11:43'),
(366, 45, 7, '2026-05-19 20:11:43', '2026-05-19 20:11:43'),
(367, 48, 2, '2026-05-19 20:21:06', '2026-05-19 20:21:06'),
(368, 48, 7, '2026-05-19 20:21:06', '2026-05-19 20:21:06'),
(369, 48, 4, '2026-05-19 20:21:06', '2026-05-19 20:21:06'),
(370, 48, 5, '2026-05-19 20:21:06', '2026-05-19 20:21:06'),
(371, 48, 6, '2026-05-19 20:21:06', '2026-05-19 20:21:06'),
(372, 49, 2, '2026-05-19 20:23:15', '2026-05-19 20:23:15'),
(373, 49, 7, '2026-05-19 20:23:15', '2026-05-19 20:23:15'),
(374, 49, 4, '2026-05-19 20:23:15', '2026-05-19 20:23:15'),
(375, 49, 5, '2026-05-19 20:23:15', '2026-05-19 20:23:15'),
(376, 49, 6, '2026-05-19 20:23:15', '2026-05-19 20:23:15'),
(382, 51, 2, '2026-05-19 20:33:30', '2026-05-19 20:33:30'),
(383, 51, 7, '2026-05-19 20:33:30', '2026-05-19 20:33:30'),
(384, 51, 4, '2026-05-19 20:33:30', '2026-05-19 20:33:30'),
(385, 51, 5, '2026-05-19 20:33:30', '2026-05-19 20:33:30'),
(386, 51, 6, '2026-05-19 20:33:30', '2026-05-19 20:33:30'),
(387, 50, 2, '2026-05-19 20:48:38', '2026-05-19 20:48:38'),
(388, 50, 7, '2026-05-19 20:48:38', '2026-05-19 20:48:38'),
(389, 50, 4, '2026-05-19 20:48:38', '2026-05-19 20:48:38'),
(390, 50, 5, '2026-05-19 20:48:38', '2026-05-19 20:48:38'),
(391, 50, 6, '2026-05-19 20:48:38', '2026-05-19 20:48:38'),
(402, 40, 2, '2026-05-19 21:17:31', '2026-05-19 21:17:31'),
(403, 40, 7, '2026-05-19 21:17:31', '2026-05-19 21:17:31'),
(404, 40, 4, '2026-05-19 21:17:31', '2026-05-19 21:17:31'),
(405, 40, 5, '2026-05-19 21:17:31', '2026-05-19 21:17:31'),
(406, 40, 6, '2026-05-19 21:17:31', '2026-05-19 21:17:31'),
(425, 52, 6, '2026-05-22 01:59:29', '2026-05-22 01:59:29'),
(426, 52, 2, '2026-05-22 01:59:29', '2026-05-22 01:59:29'),
(427, 52, 4, '2026-05-22 01:59:29', '2026-05-22 01:59:29'),
(428, 52, 5, '2026-05-22 01:59:29', '2026-05-22 01:59:29'),
(429, 52, 1, '2026-05-22 01:59:29', '2026-05-22 01:59:29'),
(430, 52, 11, '2026-05-22 01:59:29', '2026-05-22 01:59:29'),
(437, 53, 8, '2026-05-22 02:03:18', '2026-05-22 02:03:18'),
(438, 53, 6, '2026-05-22 02:03:18', '2026-05-22 02:03:18'),
(439, 53, 2, '2026-05-22 02:03:18', '2026-05-22 02:03:18'),
(440, 53, 4, '2026-05-22 02:03:18', '2026-05-22 02:03:18'),
(441, 53, 5, '2026-05-22 02:03:18', '2026-05-22 02:03:18'),
(442, 53, 11, '2026-05-22 02:03:18', '2026-05-22 02:03:18'),
(443, 54, 8, '2026-05-22 02:09:35', '2026-05-22 02:09:35'),
(444, 54, 6, '2026-05-22 02:09:35', '2026-05-22 02:09:35'),
(445, 54, 2, '2026-05-22 02:09:35', '2026-05-22 02:09:35'),
(446, 54, 4, '2026-05-22 02:09:35', '2026-05-22 02:09:35'),
(447, 54, 11, '2026-05-22 02:09:35', '2026-05-22 02:09:35'),
(448, 54, 5, '2026-05-22 02:09:35', '2026-05-22 02:09:35'),
(519, 20, 6, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(520, 20, 2, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(521, 20, 4, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(522, 20, 5, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(523, 20, 1, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(524, 55, 2, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(525, 55, 4, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(526, 55, 5, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(527, 55, 1, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(528, 55, 6, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(529, 55, 11, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(530, 56, 8, '2026-05-25 22:05:53', '2026-05-25 22:05:53'),
(531, 56, 6, '2026-05-25 22:05:53', '2026-05-25 22:05:53'),
(532, 56, 2, '2026-05-25 22:05:53', '2026-05-25 22:05:53'),
(533, 56, 4, '2026-05-25 22:05:53', '2026-05-25 22:05:53'),
(534, 56, 11, '2026-05-25 22:05:53', '2026-05-25 22:05:53'),
(535, 56, 5, '2026-05-25 22:05:53', '2026-05-25 22:05:53'),
(536, 56, 1, '2026-05-25 22:05:53', '2026-05-25 22:05:53'),
(537, 22, 6, '2026-05-25 22:07:39', '2026-05-25 22:07:39'),
(538, 22, 2, '2026-05-25 22:07:39', '2026-05-25 22:07:39'),
(539, 22, 10, '2026-05-25 22:07:39', '2026-05-25 22:07:39'),
(540, 22, 4, '2026-05-25 22:07:39', '2026-05-25 22:07:39'),
(541, 22, 5, '2026-05-25 22:07:39', '2026-05-25 22:07:39'),
(542, 22, 1, '2026-05-25 22:07:39', '2026-05-25 22:07:39'),
(543, 19, 2, '2026-05-25 22:08:42', '2026-05-25 22:08:42'),
(544, 19, 6, '2026-05-25 22:08:42', '2026-05-25 22:08:42'),
(545, 19, 4, '2026-05-25 22:08:42', '2026-05-25 22:08:42'),
(546, 19, 5, '2026-05-25 22:08:42', '2026-05-25 22:08:42'),
(547, 19, 1, '2026-05-25 22:08:42', '2026-05-25 22:08:42'),
(548, 19, 9, '2026-05-25 22:08:42', '2026-05-25 22:08:42'),
(549, 17, 2, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(550, 17, 6, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(551, 17, 1, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(552, 17, 5, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(553, 17, 4, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(554, 57, 6, '2026-06-06 17:55:47', '2026-06-06 17:55:47'),
(555, 57, 2, '2026-06-06 17:55:47', '2026-06-06 17:55:47'),
(556, 57, 10, '2026-06-06 17:55:47', '2026-06-06 17:55:47'),
(557, 57, 4, '2026-06-06 17:55:47', '2026-06-06 17:55:47'),
(558, 57, 5, '2026-06-06 17:55:47', '2026-06-06 17:55:47'),
(559, 57, 1, '2026-06-06 17:55:47', '2026-06-06 17:55:47'),
(560, 58, 6, '2026-06-06 17:59:07', '2026-06-06 17:59:07'),
(561, 58, 2, '2026-06-06 17:59:07', '2026-06-06 17:59:07'),
(562, 58, 10, '2026-06-06 17:59:07', '2026-06-06 17:59:07'),
(563, 58, 4, '2026-06-06 17:59:07', '2026-06-06 17:59:07'),
(564, 58, 5, '2026-06-06 17:59:07', '2026-06-06 17:59:07'),
(565, 58, 9, '2026-06-06 17:59:07', '2026-06-06 17:59:07'),
(566, 58, 1, '2026-06-06 17:59:07', '2026-06-06 17:59:07'),
(567, 59, 2, '2026-06-06 18:03:17', '2026-06-06 18:03:17'),
(568, 59, 4, '2026-06-06 18:03:17', '2026-06-06 18:03:17'),
(569, 59, 11, '2026-06-06 18:03:17', '2026-06-06 18:03:17'),
(570, 59, 5, '2026-06-06 18:03:17', '2026-06-06 18:03:17'),
(571, 59, 1, '2026-06-06 18:03:17', '2026-06-06 18:03:17'),
(588, 60, 2, '2026-06-10 13:48:17', '2026-06-10 13:48:17'),
(589, 60, 4, '2026-06-10 13:48:17', '2026-06-10 13:48:17'),
(590, 60, 5, '2026-06-10 13:48:17', '2026-06-10 13:48:17'),
(591, 60, 6, '2026-06-10 13:48:17', '2026-06-10 13:48:17'),
(592, 60, 3, '2026-06-10 13:48:17', '2026-06-10 13:48:17'),
(593, 61, 2, '2026-06-10 13:49:03', '2026-06-10 13:49:03'),
(594, 61, 4, '2026-06-10 13:49:03', '2026-06-10 13:49:03'),
(595, 61, 5, '2026-06-10 13:49:03', '2026-06-10 13:49:03'),
(596, 61, 1, '2026-06-10 13:49:03', '2026-06-10 13:49:03'),
(597, 61, 10, '2026-06-10 13:49:03', '2026-06-10 13:49:03'),
(598, 61, 6, '2026-06-10 13:49:03', '2026-06-10 13:49:03'),
(621, 65, 8, '2026-06-11 18:31:40', '2026-06-11 18:31:40'),
(622, 65, 6, '2026-06-11 18:31:40', '2026-06-11 18:31:40'),
(623, 65, 2, '2026-06-11 18:31:40', '2026-06-11 18:31:40'),
(624, 65, 4, '2026-06-11 18:31:40', '2026-06-11 18:31:40'),
(625, 65, 5, '2026-06-11 18:31:40', '2026-06-11 18:31:40'),
(626, 65, 1, '2026-06-11 18:31:40', '2026-06-11 18:31:40'),
(627, 63, 8, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(628, 63, 6, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(629, 63, 2, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(630, 63, 10, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(631, 63, 7, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(632, 63, 3, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(633, 63, 4, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(634, 63, 5, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(635, 63, 9, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(660, 64, 8, '2026-06-11 23:17:30', '2026-06-11 23:17:30'),
(661, 64, 2, '2026-06-11 23:17:30', '2026-06-11 23:17:30'),
(662, 64, 10, '2026-06-11 23:17:30', '2026-06-11 23:17:30'),
(663, 64, 7, '2026-06-11 23:17:30', '2026-06-11 23:17:30'),
(664, 64, 3, '2026-06-11 23:17:30', '2026-06-11 23:17:30'),
(665, 64, 4, '2026-06-11 23:17:30', '2026-06-11 23:17:30'),
(666, 64, 11, '2026-06-11 23:17:30', '2026-06-11 23:17:30'),
(667, 64, 5, '2026-06-11 23:17:30', '2026-06-11 23:17:30'),
(673, 67, 6, '2026-06-12 21:55:02', '2026-06-12 21:55:02'),
(674, 67, 2, '2026-06-12 21:55:02', '2026-06-12 21:55:02'),
(675, 67, 4, '2026-06-12 21:55:02', '2026-06-12 21:55:02'),
(676, 67, 5, '2026-06-12 21:55:02', '2026-06-12 21:55:02'),
(677, 66, 2, '2026-06-12 21:59:56', '2026-06-12 21:59:56'),
(678, 66, 4, '2026-06-12 21:59:56', '2026-06-12 21:59:56'),
(679, 66, 5, '2026-06-12 21:59:56', '2026-06-12 21:59:56'),
(680, 66, 1, '2026-06-12 21:59:56', '2026-06-12 21:59:56'),
(681, 66, 6, '2026-06-12 21:59:56', '2026-06-12 21:59:56'),
(687, 68, 2, '2026-06-14 00:18:55', '2026-06-14 00:18:55'),
(688, 68, 4, '2026-06-14 00:18:55', '2026-06-14 00:18:55'),
(689, 68, 5, '2026-06-14 00:18:55', '2026-06-14 00:18:55'),
(690, 68, 6, '2026-06-14 00:18:55', '2026-06-14 00:18:55'),
(691, 68, 10, '2026-06-14 00:18:55', '2026-06-14 00:18:55'),
(692, 69, 6, '2026-06-19 18:55:41', '2026-06-19 18:55:41'),
(693, 69, 2, '2026-06-19 18:55:41', '2026-06-19 18:55:41'),
(694, 69, 4, '2026-06-19 18:55:41', '2026-06-19 18:55:41'),
(695, 69, 5, '2026-06-19 18:55:41', '2026-06-19 18:55:41'),
(696, 69, 1, '2026-06-19 18:55:41', '2026-06-19 18:55:41'),
(697, 70, 6, '2026-06-19 19:02:45', '2026-06-19 19:02:45'),
(698, 70, 2, '2026-06-19 19:02:45', '2026-06-19 19:02:45'),
(699, 70, 4, '2026-06-19 19:02:45', '2026-06-19 19:02:45'),
(700, 70, 5, '2026-06-19 19:02:45', '2026-06-19 19:02:45'),
(701, 70, 1, '2026-06-19 19:02:45', '2026-06-19 19:02:45'),
(702, 62, 6, '2026-06-19 19:04:02', '2026-06-19 19:04:02'),
(703, 62, 2, '2026-06-19 19:04:02', '2026-06-19 19:04:02'),
(704, 62, 3, '2026-06-19 19:04:02', '2026-06-19 19:04:02'),
(705, 62, 4, '2026-06-19 19:04:02', '2026-06-19 19:04:02'),
(706, 62, 5, '2026-06-19 19:04:02', '2026-06-19 19:04:02'),
(707, 71, 2, '2026-06-22 16:03:53', '2026-06-22 16:03:53'),
(708, 71, 6, '2026-06-22 16:03:53', '2026-06-22 16:03:53'),
(709, 71, 3, '2026-06-22 16:03:53', '2026-06-22 16:03:53'),
(710, 71, 1, '2026-06-22 16:03:53', '2026-06-22 16:03:53'),
(711, 71, 5, '2026-06-22 16:03:53', '2026-06-22 16:03:53'),
(712, 71, 4, '2026-06-22 16:03:53', '2026-06-22 16:03:53'),
(713, 71, 9, '2026-06-22 16:03:53', '2026-06-22 16:03:53'),
(714, 71, 10, '2026-06-22 16:03:53', '2026-06-22 16:03:53');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `seguimiento_especies`
--

CREATE TABLE `seguimiento_especies` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `seguimiento_id` bigint(20) UNSIGNED NOT NULL,
  `especie_id` bigint(20) UNSIGNED NOT NULL,
  `cantidad` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `seguimiento_images`
--

CREATE TABLE `seguimiento_images` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `seguimiento_id` bigint(20) UNSIGNED NOT NULL,
  `imagen` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `seguimiento_images`
--

INSERT INTO `seguimiento_images` (`id`, `seguimiento_id`, `imagen`, `created_at`, `updated_at`) VALUES
(1, 1, 'images/seguimientos/69f7616599892_cea 1.jpeg', '2026-05-03 13:53:25', '2026-05-03 13:53:25'),
(2, 1, 'images/seguimientos/69f7616599e9b_cea 4.jpeg', '2026-05-03 13:53:25', '2026-05-03 13:53:25'),
(3, 1, 'images/seguimientos/69f761659a0cd_cea 5.jpeg', '2026-05-03 13:53:25', '2026-05-03 13:53:25'),
(4, 1, 'images/seguimientos/69f761659a2fc_cea 8.jpeg', '2026-05-03 13:53:25', '2026-05-03 13:53:25'),
(5, 1, 'images/seguimientos/69f761659a4f8_cea 9.jpeg', '2026-05-03 13:53:25', '2026-05-03 13:53:25'),
(6, 2, 'images/seguimientos/69f7650f2de45_IMAGEN POLLILLAS.jpeg', '2026-05-03 14:09:03', '2026-05-03 14:09:03'),
(7, 3, 'images/seguimientos/69f8999a46c97_roe vf 3.jpeg', '2026-05-04 12:05:30', '2026-05-04 12:05:30'),
(8, 3, 'images/seguimientos/69f8999a4737b_vf 1-3.jpeg', '2026-05-04 12:05:30', '2026-05-04 12:05:30'),
(9, 3, 'images/seguimientos/69f8999a47624_vf 4-3.jpeg', '2026-05-04 12:05:30', '2026-05-04 12:05:30'),
(10, 3, 'images/seguimientos/69f8999a47857_vf 5-3.jpeg', '2026-05-04 12:05:30', '2026-05-04 12:05:30'),
(11, 4, 'images/seguimientos/69f89d03e8a89_vf 7-3.jpeg', '2026-05-04 12:20:03', '2026-05-04 12:20:03'),
(12, 5, 'images/seguimientos/69f8b3da8d20a_roe vf 3.jpeg', '2026-05-04 13:57:30', '2026-05-04 13:57:30'),
(13, 5, 'images/seguimientos/69f8b3da8d9cf_vf 6-3.jpeg', '2026-05-04 13:57:30', '2026-05-04 13:57:30'),
(14, 5, 'images/seguimientos/69f8b3da8dcbc_vf3-3.jpeg', '2026-05-04 13:57:30', '2026-05-04 13:57:30'),
(15, 6, 'images/seguimientos/69f8b4a2d72b0_vf9-3.jpeg', '2026-05-04 14:00:50', '2026-05-04 14:00:50'),
(16, 7, 'images/seguimientos/69f8b94ee5029_raton atrapado.jpeg', '2026-05-04 14:20:46', '2026-05-04 14:20:46'),
(17, 7, 'images/seguimientos/69f8b94ee5607_TRAMPA 17.jpeg', '2026-05-04 14:20:46', '2026-05-04 14:20:46'),
(18, 7, 'images/seguimientos/69f8b94ee587e_trampa caja negra  pegajosa.jpeg', '2026-05-04 14:20:46', '2026-05-04 14:20:46'),
(19, 8, 'images/seguimientos/69f8ba0cd9035_cvf24-7.jpeg', '2026-05-04 14:23:56', '2026-05-04 14:23:56'),
(20, 9, 'images/seguimientos/69f8e34fdc8f4_roe vf 3.jpeg', '2026-05-04 17:19:59', '2026-05-04 17:19:59'),
(21, 9, 'images/seguimientos/69f8e34fdcec4_vf 4-3.jpeg', '2026-05-04 17:19:59', '2026-05-04 17:19:59'),
(22, 9, 'images/seguimientos/69f8e34fdd0a0_vf 5-3.jpeg', '2026-05-04 17:19:59', '2026-05-04 17:19:59'),
(23, 10, 'images/seguimientos/69f8ea81e881c_vf9-3.jpeg', '2026-05-04 17:50:41', '2026-05-04 17:50:41'),
(24, 11, 'images/seguimientos/69f8f10d62294_roe vf marzo.jpeg', '2026-05-04 18:18:37', '2026-05-04 18:18:37'),
(25, 11, 'images/seguimientos/69f8f10d628d6_vf 2-3.jpeg', '2026-05-04 18:18:37', '2026-05-04 18:18:37'),
(26, 12, 'images/seguimientos/69f8f204a044d_vf 7-3.jpeg', '2026-05-04 18:22:44', '2026-05-04 18:22:44'),
(27, 13, 'images/seguimientos/69f8ff2b5b15c_cvf9-1.jpeg', '2026-05-04 19:18:51', '2026-05-04 19:18:51'),
(28, 13, 'images/seguimientos/69f8ff2b5b7b5_cvf9-3.jpeg', '2026-05-04 19:18:51', '2026-05-04 19:18:51'),
(29, 13, 'images/seguimientos/69f8ff2b5ba19_cvf9-4.jpeg', '2026-05-04 19:18:51', '2026-05-04 19:18:51'),
(30, 13, 'images/seguimientos/69f8ff2b5bde2_cvf24-3.jpeg', '2026-05-04 19:18:51', '2026-05-04 19:18:51'),
(31, 13, 'images/seguimientos/69f8ff2b5bffd_cvf24-6.jpeg', '2026-05-04 19:18:51', '2026-05-04 19:18:51'),
(32, 14, 'images/seguimientos/69f90009612df_cvf24-7.jpeg', '2026-05-04 19:22:33', '2026-05-04 19:22:33'),
(33, 15, 'images/seguimientos/69f903878f7fb_cvf9-5.jpeg', '2026-05-04 19:37:27', '2026-05-04 19:37:27'),
(34, 15, 'images/seguimientos/69f903878fc74_cvf24-5.jpeg', '2026-05-04 19:37:27', '2026-05-04 19:37:27'),
(35, 15, 'images/seguimientos/69f903878fea7_cvf24-6.jpeg', '2026-05-04 19:37:27', '2026-05-04 19:37:27'),
(36, 15, 'images/seguimientos/69f903879010e_cvf26-3.jpeg', '2026-05-04 19:37:27', '2026-05-04 19:37:27'),
(37, 16, 'images/seguimientos/69f9059d22480_cvf24-7.jpeg', '2026-05-04 19:46:21', '2026-05-04 19:46:21'),
(38, 17, 'images/seguimientos/69fcf1885c075_1000004209.jpg', '2026-05-07 19:09:44', '2026-05-07 19:09:44'),
(39, 17, 'images/seguimientos/69fcf1885c643_1000004208.jpg', '2026-05-07 19:09:44', '2026-05-07 19:09:44'),
(40, 17, 'images/seguimientos/69fcf1885c859_1000004210.jpg', '2026-05-07 19:09:44', '2026-05-07 19:09:44'),
(41, 17, 'images/seguimientos/69fcf1885ca46_1000004211.jpg', '2026-05-07 19:09:44', '2026-05-07 19:09:44'),
(42, 17, 'images/seguimientos/69fcf18866024_1000004215.jpg', '2026-05-07 19:09:44', '2026-05-07 19:09:44'),
(43, 17, 'images/seguimientos/69fcf188769a1_1000004213.jpg', '2026-05-07 19:09:44', '2026-05-07 19:09:44'),
(44, 17, 'images/seguimientos/69fcf188882ef_1000004216.jpg', '2026-05-07 19:09:44', '2026-05-07 19:09:44'),
(45, 17, 'images/seguimientos/69fcf1889daa1_1000004217.jpg', '2026-05-07 19:09:44', '2026-05-07 19:09:44'),
(46, 17, 'images/seguimientos/69fcf188af42b_1000004219.jpg', '2026-05-07 19:09:44', '2026-05-07 19:09:44'),
(47, 17, 'images/seguimientos/69fcf188c4bab_1000004218.jpg', '2026-05-07 19:09:44', '2026-05-07 19:09:44'),
(48, 17, 'images/seguimientos/69fcf188d2a50_1000004207.jpg', '2026-05-07 19:09:44', '2026-05-07 19:09:44'),
(49, 18, 'images/seguimientos/69fcfca3baea2_1000004218.jpg', '2026-05-07 19:57:07', '2026-05-07 19:57:07'),
(50, 18, 'images/seguimientos/69fcfca3bb301_1000004217.jpg', '2026-05-07 19:57:07', '2026-05-07 19:57:07'),
(51, 18, 'images/seguimientos/69fcfca3bb50b_1000004211.jpg', '2026-05-07 19:57:07', '2026-05-07 19:57:07'),
(52, 19, 'images/seguimientos/69fe48bda7955_1000004321.jpg', '2026-05-08 19:34:05', '2026-05-08 19:34:05'),
(53, 19, 'images/seguimientos/69fe48bda7f9e_1000004322.jpg', '2026-05-08 19:34:05', '2026-05-08 19:34:05'),
(54, 20, 'images/seguimientos/69fe4c4357574_1000004292.jpg', '2026-05-08 19:49:07', '2026-05-08 19:49:07'),
(55, 20, 'images/seguimientos/69fe4c4357a30_1000004283.jpg', '2026-05-08 19:49:07', '2026-05-08 19:49:07'),
(56, 20, 'images/seguimientos/69fe4c4361095_1000004286.jpg', '2026-05-08 19:49:07', '2026-05-08 19:49:07'),
(57, 20, 'images/seguimientos/69fe4c438c895_1000004271.jpg', '2026-05-08 19:49:07', '2026-05-08 19:49:07'),
(58, 20, 'images/seguimientos/69fe4c43afa94_1000004274.jpg', '2026-05-08 19:49:07', '2026-05-08 19:49:07'),
(64, 20, 'images/seguimientos/69fe764f9d853_imagen 1.jpeg', '2026-05-08 22:48:31', '2026-05-08 22:48:31'),
(65, 20, 'images/seguimientos/69fe764f9dd95_imagen 2.jpeg', '2026-05-08 22:48:31', '2026-05-08 22:48:31'),
(66, 20, 'images/seguimientos/69fe764f9e00e_imagen 3.jpeg', '2026-05-08 22:48:31', '2026-05-08 22:48:31'),
(67, 20, 'images/seguimientos/69fe764faa926_imagen 4.jpeg', '2026-05-08 22:48:31', '2026-05-08 22:48:31'),
(68, 20, 'images/seguimientos/69fe764fdc9db_imagen 5.jpeg', '2026-05-08 22:48:32', '2026-05-08 22:48:32'),
(69, 21, 'images/seguimientos/6a00dedc6c07e_1000005847.jpg', '2026-05-10 18:39:08', '2026-05-10 18:39:08'),
(70, 21, 'images/seguimientos/6a00dedc6d2a7_1000005846.jpg', '2026-05-10 18:39:08', '2026-05-10 18:39:08'),
(71, 21, 'images/seguimientos/6a00dedc6d4f5_1000005845.jpg', '2026-05-10 18:39:08', '2026-05-10 18:39:08'),
(72, 22, 'images/seguimientos/6a00e1529347d_1000005868.jpg', '2026-05-10 18:49:38', '2026-05-10 18:49:38'),
(73, 22, 'images/seguimientos/6a00e15293851_1000005867.jpg', '2026-05-10 18:49:38', '2026-05-10 18:49:38'),
(74, 22, 'images/seguimientos/6a00e15293ad4_1000005865.jpg', '2026-05-10 18:49:38', '2026-05-10 18:49:38'),
(75, 22, 'images/seguimientos/6a00e15293d2f_1000005866.jpg', '2026-05-10 18:49:38', '2026-05-10 18:49:38'),
(77, 23, 'images/seguimientos/6a060de69f872_1000006416.jpg', '2026-05-14 17:01:10', '2026-05-14 17:01:10'),
(78, 23, 'images/seguimientos/6a060de69fbcf_1000006415.jpg', '2026-05-14 17:01:10', '2026-05-14 17:01:10'),
(79, 23, 'images/seguimientos/6a060de69fed8_1000006414.jpg', '2026-05-14 17:01:10', '2026-05-14 17:01:10'),
(80, 23, 'images/seguimientos/6a060de6a01c6_1000006413.jpg', '2026-05-14 17:01:10', '2026-05-14 17:01:10'),
(81, 24, 'images/seguimientos/6a090ab35b23f_EA 1.jpeg', '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(82, 24, 'images/seguimientos/6a090ab361c8e_EA 4.jpeg', '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(83, 24, 'images/seguimientos/6a090ab382613_EA 116.jpeg', '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(84, 24, 'images/seguimientos/6a090ab397d72_EA 121 RATON ATRAPADO 27 FEBRERO.jpeg', '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(85, 24, 'images/seguimientos/6a090ab3af46d_EA8.jpeg', '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(86, 24, 'images/seguimientos/6a090ab3e6360_EA10.jpeg', '2026-05-16 23:24:20', '2026-05-16 23:24:20'),
(87, 24, 'images/seguimientos/6a090ab4055a9_ROTA EA.jpeg', '2026-05-16 23:24:20', '2026-05-16 23:24:20'),
(88, 25, 'images/seguimientos/6a09348a872e1_EA2.jpeg', '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(89, 25, 'images/seguimientos/6a09348a87bba_EA5.jpeg', '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(90, 25, 'images/seguimientos/6a09348a87dc9_EA6.jpeg', '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(91, 25, 'images/seguimientos/6a09348a87fdb_EA10.jpeg', '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(92, 25, 'images/seguimientos/6a09348a881af_TRAMPA 4.jpeg', '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(93, 26, 'images/seguimientos/6a094225207a1_EA 1.jpeg', '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(94, 26, 'images/seguimientos/6a09422520bbb_EA 123 CV.jpeg', '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(95, 26, 'images/seguimientos/6a09422520d8e_EA 130.jpeg', '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(96, 26, 'images/seguimientos/6a09422520f3b_EA7.jpeg', '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(97, 26, 'images/seguimientos/6a09422521131_EA11.jpeg', '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(98, 27, 'images/seguimientos/6a094f32d14c4_EA 118.jpeg', '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(99, 27, 'images/seguimientos/6a094f32d1a4a_EA 130.jpeg', '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(100, 27, 'images/seguimientos/6a094f32d1c5f_EA6.jpeg', '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(101, 27, 'images/seguimientos/6a094f32d1e86_EA9.jpeg', '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(102, 27, 'images/seguimientos/6a094f32d212b_EA11.jpeg', '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(103, 28, 'images/seguimientos/6a09553076537_cea 4.jpeg', '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(104, 28, 'images/seguimientos/6a09553076b3d_cea 6.jpeg', '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(105, 28, 'images/seguimientos/6a09553076df6_cea 8.jpeg', '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(106, 28, 'images/seguimientos/6a0955308302d_cea 9.jpeg', '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(107, 28, 'images/seguimientos/6a095530b1e84_cea 10.jpeg', '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(108, 28, 'images/seguimientos/6a095530e4b26_cea3.jpeg', '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(109, 28, 'images/seguimientos/6a095530f2936_cea7.jpeg', '2026-05-17 04:42:09', '2026-05-17 04:42:09'),
(110, 29, 'images/seguimientos/6a0b367edf6d4_lloje 3.jpeg', '2026-05-18 14:55:42', '2026-05-18 14:55:42'),
(111, 29, 'images/seguimientos/6a0b367edfc32_lloje 4.jpeg', '2026-05-18 14:55:42', '2026-05-18 14:55:42'),
(112, 29, 'images/seguimientos/6a0b367edfea5_lloje 5.jpeg', '2026-05-18 14:55:42', '2026-05-18 14:55:42'),
(113, 29, 'images/seguimientos/6a0b367ee00b5_lloje 6.jpeg', '2026-05-18 14:55:42', '2026-05-18 14:55:42'),
(114, 29, 'images/seguimientos/6a0b367ee0300_lloje 7.jpeg', '2026-05-18 14:55:42', '2026-05-18 14:55:42'),
(115, 30, 'images/seguimientos/6a0b44c152e11_lloje 18-fumi 10.jpeg', '2026-05-18 15:56:33', '2026-05-18 15:56:33'),
(116, 30, 'images/seguimientos/6a0b44c1532e6_lloje 22-4-1.jpeg', '2026-05-18 15:56:33', '2026-05-18 15:56:33'),
(117, 30, 'images/seguimientos/6a0b44c153829_lloje 23-4-2.jpeg', '2026-05-18 15:56:33', '2026-05-18 15:56:33'),
(118, 30, 'images/seguimientos/6a0b44c153b10_lloje 26-1.jpeg', '2026-05-18 15:56:33', '2026-05-18 15:56:33'),
(119, 30, 'images/seguimientos/6a0b44c166387_lloje 26-2.jpeg', '2026-05-18 15:56:33', '2026-05-18 15:56:33'),
(120, 31, 'images/seguimientos/6a0b4daf3bf87_lloje9-2.jpeg', '2026-05-18 16:34:39', '2026-05-18 16:34:39'),
(121, 31, 'images/seguimientos/6a0b4daf3c40e_lloje9-3.jpeg', '2026-05-18 16:34:39', '2026-05-18 16:34:39'),
(122, 31, 'images/seguimientos/6a0b4daf3c679_lloje9-4.jpeg', '2026-05-18 16:34:39', '2026-05-18 16:34:39'),
(123, 31, 'images/seguimientos/6a0b4daf3c8cd_lloje9-5.jpeg', '2026-05-18 16:34:39', '2026-05-18 16:34:39'),
(124, 31, 'images/seguimientos/6a0b4daf427c8_lloje9-rota 1.jpeg', '2026-05-18 16:34:39', '2026-05-18 16:34:39'),
(125, 31, 'images/seguimientos/6a0b4daf58c91_lloje9-rota2.jpeg', '2026-05-18 16:34:39', '2026-05-18 16:34:39'),
(126, 31, 'images/seguimientos/6a0b4daf77c99_lloje18-4.jpeg', '2026-05-18 16:34:39', '2026-05-18 16:34:39'),
(127, 32, 'images/seguimientos/6a0b87f61647f_lloje 7.jpeg', '2026-05-18 20:43:18', '2026-05-18 20:43:18'),
(128, 32, 'images/seguimientos/6a0b87f6169dd_lloje23-4-3.jpeg', '2026-05-18 20:43:18', '2026-05-18 20:43:18'),
(129, 32, 'images/seguimientos/6a0b87f616c40_lloje23-4-6.jpeg', '2026-05-18 20:43:18', '2026-05-18 20:43:18'),
(130, 32, 'images/seguimientos/6a0b87f616e73_lloje23-4-7.jpeg', '2026-05-18 20:43:18', '2026-05-18 20:43:18'),
(131, 33, 'images/seguimientos/6a0b8b61a46f6_lloje23-4-3.jpeg', '2026-05-18 20:57:53', '2026-05-18 20:57:53'),
(132, 33, 'images/seguimientos/6a0b8b61a4b0d_lloje23-4-4.jpeg', '2026-05-18 20:57:53', '2026-05-18 20:57:53'),
(133, 33, 'images/seguimientos/6a0b8b61a4d3e_lloje23-4-5.jpeg', '2026-05-18 20:57:53', '2026-05-18 20:57:53'),
(134, 34, 'images/seguimientos/6a0b902f33411_lloje23-4-4.jpeg', '2026-05-18 21:18:23', '2026-05-18 21:18:23'),
(135, 34, 'images/seguimientos/6a0b902f3385b_lloje23-4-7.jpeg', '2026-05-18 21:18:23', '2026-05-18 21:18:23'),
(136, 34, 'images/seguimientos/6a0b902f33ab9_lloje26-3.jpeg', '2026-05-18 21:18:23', '2026-05-18 21:18:23'),
(137, 34, 'images/seguimientos/6a0b902f33cce_lloje26-5.jpeg', '2026-05-18 21:18:23', '2026-05-18 21:18:23'),
(138, 35, 'images/seguimientos/6a0b933b29413_lloje 8.jpeg', '2026-05-18 21:31:23', '2026-05-18 21:31:23'),
(139, 35, 'images/seguimientos/6a0b933b29894_lloje 22-4-1.jpeg', '2026-05-18 21:31:23', '2026-05-18 21:31:23'),
(140, 35, 'images/seguimientos/6a0b933b29b20_lloje 23-4-2.jpeg', '2026-05-18 21:31:23', '2026-05-18 21:31:23'),
(141, 35, 'images/seguimientos/6a0b933b29d43_lloje9-1.jpeg', '2026-05-18 21:31:23', '2026-05-18 21:31:23'),
(142, 36, 'images/seguimientos/6a0ba25203e06_VISCA 9(1).jpeg', '2026-05-18 22:35:46', '2026-05-18 22:35:46'),
(143, 36, 'images/seguimientos/6a0ba25204438_VISCA 10.jpeg', '2026-05-18 22:35:46', '2026-05-18 22:35:46'),
(144, 36, 'images/seguimientos/6a0ba252046f7_VISCA 11.jpeg', '2026-05-18 22:35:46', '2026-05-18 22:35:46'),
(145, 36, 'images/seguimientos/6a0ba2520499f_VISCA 12.jpeg', '2026-05-18 22:35:46', '2026-05-18 22:35:46'),
(146, 37, 'images/seguimientos/6a0bacedd7e21_VISCA 9(1).jpeg', '2026-05-18 23:21:01', '2026-05-18 23:21:01'),
(147, 37, 'images/seguimientos/6a0bacedd82e8_VISCA 9.jpeg', '2026-05-18 23:21:01', '2026-05-18 23:21:01'),
(148, 37, 'images/seguimientos/6a0bacedd85de_VISCA 10.jpeg', '2026-05-18 23:21:01', '2026-05-18 23:21:01'),
(149, 37, 'images/seguimientos/6a0bacedd886c_VISCA 12.jpeg', '2026-05-18 23:21:01', '2026-05-18 23:21:01'),
(150, 38, 'images/seguimientos/6a0bb0731d531_HEN  7.jpeg', '2026-05-18 23:36:03', '2026-05-18 23:36:03'),
(151, 38, 'images/seguimientos/6a0bb0731d920_HEN 2.jpeg', '2026-05-18 23:36:03', '2026-05-18 23:36:03'),
(152, 38, 'images/seguimientos/6a0bb0731dbd3_HEN 6.jpeg', '2026-05-18 23:36:03', '2026-05-18 23:36:03'),
(153, 38, 'images/seguimientos/6a0bb0731de56_HEN 8.jpeg', '2026-05-18 23:36:03', '2026-05-18 23:36:03'),
(154, 39, 'images/seguimientos/6a0bb22453093_VISCA 9(1).jpeg', '2026-05-18 23:43:16', '2026-05-18 23:43:16'),
(155, 39, 'images/seguimientos/6a0bb22453524_VISCA 9.jpeg', '2026-05-18 23:43:16', '2026-05-18 23:43:16'),
(156, 39, 'images/seguimientos/6a0bb22453783_VISCA 10.jpeg', '2026-05-18 23:43:16', '2026-05-18 23:43:16'),
(157, 39, 'images/seguimientos/6a0bb22453994_visca105.jpeg', '2026-05-18 23:43:16', '2026-05-18 23:43:16'),
(158, 40, 'images/seguimientos/6a0bb3ec12fd9_HEN  7.jpeg', '2026-05-18 23:50:52', '2026-05-18 23:50:52'),
(159, 40, 'images/seguimientos/6a0bb3ec13465_HEN 1.jpeg', '2026-05-18 23:50:52', '2026-05-18 23:50:52'),
(160, 40, 'images/seguimientos/6a0bb3ec1371c_HEN 2.jpeg', '2026-05-18 23:50:52', '2026-05-18 23:50:52'),
(161, 40, 'images/seguimientos/6a0bb3ec139b1_HEN 3.jpeg', '2026-05-18 23:50:52', '2026-05-18 23:50:52'),
(162, 41, 'images/seguimientos/6a0bb58566cf1_HEN 8.jpeg', '2026-05-18 23:57:41', '2026-05-18 23:57:41'),
(163, 41, 'images/seguimientos/6a0bb58567261_VISCA 9(1).jpeg', '2026-05-18 23:57:41', '2026-05-18 23:57:41'),
(164, 41, 'images/seguimientos/6a0bb5856755c_VISCA 9.jpeg', '2026-05-18 23:57:41', '2026-05-18 23:57:41'),
(165, 41, 'images/seguimientos/6a0bb58567835_VISCA 10.jpeg', '2026-05-18 23:57:41', '2026-05-18 23:57:41'),
(166, 42, 'images/seguimientos/6a0bb7122f129_VISCA 9(1).jpeg', '2026-05-19 00:04:18', '2026-05-19 00:04:18'),
(167, 42, 'images/seguimientos/6a0bb7122f650_VISCA 9.jpeg', '2026-05-19 00:04:18', '2026-05-19 00:04:18'),
(168, 42, 'images/seguimientos/6a0bb7122f8dd_VISCA 10.jpeg', '2026-05-19 00:04:18', '2026-05-19 00:04:18'),
(169, 43, 'images/seguimientos/6a0ccd1799d07_VISCA 6.jpeg', '2026-05-19 19:50:31', '2026-05-19 19:50:31'),
(170, 43, 'images/seguimientos/6a0ccd179a1f1_VISCA 7.jpeg', '2026-05-19 19:50:31', '2026-05-19 19:50:31'),
(171, 43, 'images/seguimientos/6a0ccd179a441_VISCA 8.jpeg', '2026-05-19 19:50:31', '2026-05-19 19:50:31'),
(172, 43, 'images/seguimientos/6a0ccd17b6f68_visca 16(1).jpeg', '2026-05-19 19:50:31', '2026-05-19 19:50:31'),
(173, 43, 'images/seguimientos/6a0ccd17d05d3_visca 16.jpeg', '2026-05-19 19:50:31', '2026-05-19 19:50:31'),
(174, 43, 'images/seguimientos/6a0ccd17ebb57_visca 103.jpeg', '2026-05-19 19:50:32', '2026-05-19 19:50:32'),
(175, 43, 'images/seguimientos/6a0ccd1828675_visca 104.jpeg', '2026-05-19 19:50:32', '2026-05-19 19:50:32'),
(176, 44, 'images/seguimientos/6a0ccdeb6f4cb_ALDO 4.jpeg', '2026-05-19 19:54:03', '2026-05-19 19:54:03'),
(177, 44, 'images/seguimientos/6a0ccdeb6f8de_ALDO 6.jpeg', '2026-05-19 19:54:03', '2026-05-19 19:54:03'),
(178, 44, 'images/seguimientos/6a0ccdeb6fb09_ALDO 9.jpeg', '2026-05-19 19:54:03', '2026-05-19 19:54:03'),
(179, 44, 'images/seguimientos/6a0ccdeb71c6e_visca 15.jpeg', '2026-05-19 19:54:03', '2026-05-19 19:54:03'),
(180, 44, 'images/seguimientos/6a0ccdeb8a0c9_visca 16(1).jpeg', '2026-05-19 19:54:03', '2026-05-19 19:54:03'),
(181, 44, 'images/seguimientos/6a0ccdeba36ee_visca 100.jpeg', '2026-05-19 19:54:03', '2026-05-19 19:54:03'),
(182, 44, 'images/seguimientos/6a0ccdebc0c26_visca 101.jpeg', '2026-05-19 19:54:04', '2026-05-19 19:54:04'),
(183, 45, 'images/seguimientos/6a0cd0801e8c1_HEN 4.jpeg', '2026-05-19 20:05:04', '2026-05-19 20:05:04'),
(184, 46, 'images/seguimientos/6a0cd133e6f4c_HEN 5.jpeg', '2026-05-19 20:08:03', '2026-05-19 20:08:03'),
(185, 47, 'images/seguimientos/6a0cd1c3892c3_IMAGEN POLLILLAS(1).jpeg', '2026-05-19 20:10:27', '2026-05-19 20:10:27'),
(186, 48, 'images/seguimientos/6a0cd4426e337_Imagen de WPS(1).jpeg', '2026-05-19 20:21:06', '2026-05-19 20:21:06'),
(187, 49, 'images/seguimientos/6a0cd4c33480c_IMAGEN POLLILLAS.jpeg', '2026-05-19 20:23:15', '2026-05-19 20:23:15'),
(188, 50, 'images/seguimientos/6a0cd663219ee_Imagen de WPS(1).jpeg', '2026-05-19 20:30:11', '2026-05-19 20:30:11'),
(189, 51, 'images/seguimientos/6a0cd72a92a9b_IMAGEN POLLILLAS.jpeg', '2026-05-19 20:33:30', '2026-05-19 20:33:30'),
(190, 40, 'images/seguimientos/6a0ce05a76f6f_Imagen de WPS(1).jpeg', '2026-05-19 21:12:42', '2026-05-19 21:12:42'),
(195, 52, 'images/seguimientos/6a0fc692042e0_1000006847.jpg', '2026-05-22 01:59:30', '2026-05-22 01:59:30'),
(196, 52, 'images/seguimientos/6a0fc69204c41_1000006851.jpg', '2026-05-22 01:59:30', '2026-05-22 01:59:30'),
(197, 52, 'images/seguimientos/6a0fc69204e6d_1000006854.jpg', '2026-05-22 01:59:30', '2026-05-22 01:59:30'),
(198, 52, 'images/seguimientos/6a0fc6920541b_1000006856.jpg', '2026-05-22 01:59:30', '2026-05-22 01:59:30'),
(199, 52, 'images/seguimientos/6a0fc6920568e_1000006859.jpg', '2026-05-22 01:59:30', '2026-05-22 01:59:30'),
(200, 52, 'images/seguimientos/6a0fc692058bf_1000006860.jpg', '2026-05-22 01:59:30', '2026-05-22 01:59:30'),
(201, 52, 'images/seguimientos/6a0fc69205b01_1000006858.jpg', '2026-05-22 01:59:30', '2026-05-22 01:59:30'),
(202, 52, 'images/seguimientos/6a0fc69205d21_1000006857.jpg', '2026-05-22 01:59:30', '2026-05-22 01:59:30'),
(203, 53, 'images/seguimientos/6a0fc7769e3c0_1000006850.jpg', '2026-05-22 02:03:18', '2026-05-22 02:03:18'),
(204, 53, 'images/seguimientos/6a0fc7769e7e7_1000006855.jpg', '2026-05-22 02:03:18', '2026-05-22 02:03:18'),
(205, 53, 'images/seguimientos/6a0fc7769ea18_1000006852.jpg', '2026-05-22 02:03:18', '2026-05-22 02:03:18'),
(206, 54, 'images/seguimientos/6a0fc8efead88_1000006919.jpg', '2026-05-22 02:09:35', '2026-05-22 02:09:35'),
(207, 54, 'images/seguimientos/6a0fc8efeb096_1000006920.jpg', '2026-05-22 02:09:35', '2026-05-22 02:09:35'),
(208, 54, 'images/seguimientos/6a0fc8efeb2be_1000006923.jpg', '2026-05-22 02:09:35', '2026-05-22 02:09:35'),
(209, 54, 'images/seguimientos/6a0fc8efeb4db_1000006924.jpg', '2026-05-22 02:09:35', '2026-05-22 02:09:35'),
(210, 54, 'images/seguimientos/6a0fc8efeb6e5_1000006917.jpg', '2026-05-22 02:09:36', '2026-05-22 02:09:36'),
(211, 54, 'images/seguimientos/6a0fc8f003c8b_1000006863.jpg', '2026-05-22 02:09:36', '2026-05-22 02:09:36'),
(212, 55, 'images/seguimientos/6a10f921a4dcc_1000008807.jpg', '2026-05-22 23:47:29', '2026-05-22 23:47:29'),
(213, 55, 'images/seguimientos/6a10f921d4075_1000008806.jpg', '2026-05-22 23:47:30', '2026-05-22 23:47:30'),
(214, 55, 'images/seguimientos/6a10f92202e69_1000008803.jpg', '2026-05-22 23:47:30', '2026-05-22 23:47:30'),
(215, 55, 'images/seguimientos/6a10f9221c556_1000008802.jpg', '2026-05-22 23:47:30', '2026-05-22 23:47:30'),
(216, 55, 'images/seguimientos/6a10f92237a67_1000008801.jpg', '2026-05-22 23:47:30', '2026-05-22 23:47:30'),
(217, 55, 'images/seguimientos/6a10f922510e6_1000008800.jpg', '2026-05-22 23:47:30', '2026-05-22 23:47:30'),
(218, 55, 'images/seguimientos/6a10f9226e569_1000008796.jpg', '2026-05-22 23:47:30', '2026-05-22 23:47:30'),
(219, 55, 'images/seguimientos/6a10f9229b477_1000008797.jpg', '2026-05-22 23:47:30', '2026-05-22 23:47:30'),
(220, 55, 'images/seguimientos/6a10f922aece3_1000008798.jpg', '2026-05-22 23:47:30', '2026-05-22 23:47:30'),
(221, 55, 'images/seguimientos/6a10f922dbb52_1000008799.jpg', '2026-05-22 23:47:31', '2026-05-22 23:47:31'),
(222, 56, 'images/seguimientos/6a10fa6f598eb_1000008805.jpg', '2026-05-22 23:53:03', '2026-05-22 23:53:03'),
(223, 56, 'images/seguimientos/6a10fa6f59cd9_1000008804.jpg', '2026-05-22 23:53:03', '2026-05-22 23:53:03'),
(224, 57, 'images/seguimientos/6a246d3401759_1000010986.jpg', '2026-06-06 17:55:48', '2026-06-06 17:55:48'),
(225, 57, 'images/seguimientos/6a246d3401cce_1000010990.jpg', '2026-06-06 17:55:48', '2026-06-06 17:55:48'),
(226, 57, 'images/seguimientos/6a246d3401eea_1000010987.jpg', '2026-06-06 17:55:48', '2026-06-06 17:55:48'),
(227, 57, 'images/seguimientos/6a246d3402148_1000010991.jpg', '2026-06-06 17:55:48', '2026-06-06 17:55:48'),
(228, 57, 'images/seguimientos/6a246d3402341_1000010992.jpg', '2026-06-06 17:55:48', '2026-06-06 17:55:48'),
(229, 57, 'images/seguimientos/6a246d3402600_1000010993.jpg', '2026-06-06 17:55:48', '2026-06-06 17:55:48'),
(230, 58, 'images/seguimientos/6a246dfb4b47d_1000010989.jpg', '2026-06-06 17:59:07', '2026-06-06 17:59:07'),
(231, 58, 'images/seguimientos/6a246dfb4b914_1000010988.jpg', '2026-06-06 17:59:07', '2026-06-06 17:59:07'),
(232, 58, 'images/seguimientos/6a246dfb4bb83_1000010983.jpg', '2026-06-06 17:59:07', '2026-06-06 17:59:07'),
(233, 58, 'images/seguimientos/6a246dfb4bd70_1000010984.jpg', '2026-06-06 17:59:07', '2026-06-06 17:59:07'),
(234, 58, 'images/seguimientos/6a246dfb4bf5a_1000010985.jpg', '2026-06-06 17:59:07', '2026-06-06 17:59:07'),
(235, 59, 'images/seguimientos/6a246ef515bad_1000010999.jpg', '2026-06-06 18:03:17', '2026-06-06 18:03:17'),
(236, 59, 'images/seguimientos/6a246ef515f2f_1000011000.jpg', '2026-06-06 18:03:17', '2026-06-06 18:03:17'),
(237, 59, 'images/seguimientos/6a246ef5160f5_1000011001.jpg', '2026-06-06 18:03:17', '2026-06-06 18:03:17'),
(238, 60, 'images/seguimientos/6a2973f93bb80_CIMFA 1.jpeg', '2026-06-10 13:26:01', '2026-06-10 13:26:01'),
(239, 60, 'images/seguimientos/6a2973f93c3c8_CIMFA 2.jpeg', '2026-06-10 13:26:01', '2026-06-10 13:26:01'),
(240, 60, 'images/seguimientos/6a2973f93c682_CIMFA 3.jpeg', '2026-06-10 13:26:01', '2026-06-10 13:26:01'),
(241, 61, 'images/seguimientos/6a2978a79c198_FUMI 3.jpeg', '2026-06-10 13:45:59', '2026-06-10 13:45:59'),
(242, 61, 'images/seguimientos/6a2978a79c875_FUMI 4.jpeg', '2026-06-10 13:45:59', '2026-06-10 13:45:59'),
(243, 61, 'images/seguimientos/6a2978a79cb3d_FUMI 5.jpeg', '2026-06-10 13:45:59', '2026-06-10 13:45:59'),
(244, 61, 'images/seguimientos/6a2978a79cef6_FUMI 7.jpeg', '2026-06-10 13:45:59', '2026-06-10 13:45:59'),
(245, 61, 'images/seguimientos/6a2978a7b062b_FUMI 8.jpeg', '2026-06-10 13:45:59', '2026-06-10 13:45:59'),
(246, 61, 'images/seguimientos/6a2978a7d764a_FUMI 15.jpeg', '2026-06-10 13:46:00', '2026-06-10 13:46:00'),
(247, 61, 'images/seguimientos/6a2978a80f778_PILVE 4.jpeg', '2026-06-10 13:46:00', '2026-06-10 13:46:00'),
(248, 61, 'images/seguimientos/6a2978a843009_PULVE 1.jpeg', '2026-06-10 13:46:00', '2026-06-10 13:46:00'),
(249, 61, 'images/seguimientos/6a2978a877baf_PULVE 4.jpeg', '2026-06-10 13:46:00', '2026-06-10 13:46:00'),
(250, 61, 'images/seguimientos/6a2978a8b6375_PULVE 6.jpeg', '2026-06-10 13:46:00', '2026-06-10 13:46:00'),
(251, 61, 'images/seguimientos/6a2978a8d57af_PULVE 7.jpeg', '2026-06-10 13:46:00', '2026-06-10 13:46:00'),
(252, 61, 'images/seguimientos/6a2978a8f2c0c_PULVE 10.jpeg', '2026-06-10 13:46:01', '2026-06-10 13:46:01'),
(253, 61, 'images/seguimientos/6a2978a929909_PULVE 12.jpeg', '2026-06-10 13:46:01', '2026-06-10 13:46:01'),
(254, 61, 'images/seguimientos/6a2978a9567be_PULVE 13.jpeg', '2026-06-10 13:46:01', '2026-06-10 13:46:01'),
(255, 61, 'images/seguimientos/6a2978a983671_PULVE 14.jpeg', '2026-06-10 13:46:01', '2026-06-10 13:46:01'),
(256, 62, 'images/seguimientos/6a297d82abfa0_1000011572.jpg', '2026-06-10 14:06:42', '2026-06-10 14:06:42'),
(257, 62, 'images/seguimientos/6a297d82acc85_1000011571.jpg', '2026-06-10 14:06:42', '2026-06-10 14:06:42'),
(258, 62, 'images/seguimientos/6a297d82b179f_1000011570.jpg', '2026-06-10 14:06:42', '2026-06-10 14:06:42'),
(259, 62, 'images/seguimientos/6a297d82b1a49_1000011569.jpg', '2026-06-10 14:06:42', '2026-06-10 14:06:42'),
(260, 63, 'images/seguimientos/6a2b4e6e6d4f1_1000012345.jpg', '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(261, 63, 'images/seguimientos/6a2b4e6e7f5ed_1000012344.jpg', '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(262, 63, 'images/seguimientos/6a2b4e6e82671_1000012343.jpg', '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(263, 63, 'images/seguimientos/6a2b4e6e97b7f_1000012347.jpg', '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(264, 63, 'images/seguimientos/6a2b4e6e9810c_1000012348.jpg', '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(265, 63, 'images/seguimientos/6a2b4e6e984ef_1000012349.jpg', '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(266, 63, 'images/seguimientos/6a2b4e6eae80e_1000012350.jpg', '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(267, 63, 'images/seguimientos/6a2b4e6ec7be5_1000012353.jpg', '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(268, 63, 'images/seguimientos/6a2b4e6ee1430_1000012354.jpg', '2026-06-11 23:10:23', '2026-06-11 23:10:23'),
(269, 63, 'images/seguimientos/6a2b4e6f061c7_1000012356.jpg', '2026-06-11 23:10:23', '2026-06-11 23:10:23'),
(270, 63, 'images/seguimientos/6a2b4e6f06e35_1000012357.jpg', '2026-06-11 23:10:23', '2026-06-11 23:10:23'),
(271, 63, 'images/seguimientos/6a2b4e6f1c99f_1000012358.jpg', '2026-06-11 23:10:23', '2026-06-11 23:10:23'),
(272, 63, 'images/seguimientos/6a2b4e6f37f41_1000012366.jpg', '2026-06-11 23:10:23', '2026-06-11 23:10:23'),
(273, 63, 'images/seguimientos/6a2b4e6f383e1_1000012365.jpg', '2026-06-11 23:10:23', '2026-06-11 23:10:23'),
(274, 63, 'images/seguimientos/6a2b4e6f4eb83_1000012364.jpg', '2026-06-11 23:10:23', '2026-06-11 23:10:23'),
(275, 63, 'images/seguimientos/6a2b4e6f681b7_1000012363.jpg', '2026-06-11 23:10:23', '2026-06-11 23:10:23'),
(276, 64, 'images/seguimientos/6a2b501a254ab_1000012361.jpg', '2026-06-11 23:17:30', '2026-06-11 23:17:30'),
(277, 64, 'images/seguimientos/6a2b501a25b20_1000012360.jpg', '2026-06-11 23:17:30', '2026-06-11 23:17:30'),
(278, 64, 'images/seguimientos/6a2b501a25d28_1000012359.jpg', '2026-06-11 23:17:30', '2026-06-11 23:17:30'),
(279, 64, 'images/seguimientos/6a2b501a25f0c_1000012355.jpg', '2026-06-11 23:17:30', '2026-06-11 23:17:30'),
(280, 64, 'images/seguimientos/6a2b501a260ef_1000012352.jpg', '2026-06-11 23:17:30', '2026-06-11 23:17:30'),
(281, 64, 'images/seguimientos/6a2b501a262db_1000012370.jpg', '2026-06-11 23:17:30', '2026-06-11 23:17:30'),
(282, 67, 'images/seguimientos/6a2c8e4639dca_1000012471.jpg', '2026-06-12 21:55:02', '2026-06-12 21:55:02'),
(283, 67, 'images/seguimientos/6a2c8e463a55f_1000012470.jpg', '2026-06-12 21:55:02', '2026-06-12 21:55:02'),
(284, 66, 'images/seguimientos/6a2c8f6c76047_1000012469.jpg', '2026-06-12 21:59:56', '2026-06-12 21:59:56'),
(285, 66, 'images/seguimientos/6a2c8f6c76501_1000012468.jpg', '2026-06-12 21:59:56', '2026-06-12 21:59:56'),
(286, 66, 'images/seguimientos/6a2c8f6c76721_1000012464.jpg', '2026-06-12 21:59:56', '2026-06-12 21:59:56'),
(287, 66, 'images/seguimientos/6a2c8f6c76a5c_1000012460.jpg', '2026-06-12 21:59:56', '2026-06-12 21:59:56'),
(288, 66, 'images/seguimientos/6a2c8f6c87a77_1000012461.jpg', '2026-06-12 21:59:56', '2026-06-12 21:59:56'),
(289, 66, 'images/seguimientos/6a2c8f6ca300d_1000012465.jpg', '2026-06-12 21:59:56', '2026-06-12 21:59:56'),
(290, 66, 'images/seguimientos/6a2c8f6cb87ff_1000012462.jpg', '2026-06-12 21:59:56', '2026-06-12 21:59:56'),
(291, 66, 'images/seguimientos/6a2c8f6cd1e4e_1000012463.jpg', '2026-06-12 21:59:56', '2026-06-12 21:59:56'),
(292, 66, 'images/seguimientos/6a2c8f6ce75ea_1000012457.jpg', '2026-06-12 21:59:57', '2026-06-12 21:59:57'),
(293, 66, 'images/seguimientos/6a2c8f6d10974_1000012456.jpg', '2026-06-12 21:59:57', '2026-06-12 21:59:57'),
(294, 66, 'images/seguimientos/6a2c8f6d240d0_1000012458.jpg', '2026-06-12 21:59:57', '2026-06-12 21:59:57'),
(295, 66, 'images/seguimientos/6a2c8f6d31b80_1000012459.jpg', '2026-06-12 21:59:57', '2026-06-12 21:59:57'),
(296, 66, 'images/seguimientos/6a2c8f6d4d199_1000012466.jpg', '2026-06-12 21:59:57', '2026-06-12 21:59:57'),
(297, 68, 'images/seguimientos/6a2e00f927118_FUMI 1.jpeg', '2026-06-14 00:16:41', '2026-06-14 00:16:41'),
(298, 68, 'images/seguimientos/6a2e00f94b016_FUMI 3.jpeg', '2026-06-14 00:16:41', '2026-06-14 00:16:41'),
(299, 68, 'images/seguimientos/6a2e00f97c492_FUMI 4.jpeg', '2026-06-14 00:16:41', '2026-06-14 00:16:41'),
(300, 68, 'images/seguimientos/6a2e00f9adc42_FUMI 5.jpeg', '2026-06-14 00:16:41', '2026-06-14 00:16:41'),
(301, 68, 'images/seguimientos/6a2e00f9c0342_FUMI 6.jpeg', '2026-06-14 00:16:41', '2026-06-14 00:16:41'),
(302, 68, 'images/seguimientos/6a2e00f9e145c_FUMI 7.jpeg', '2026-06-14 00:16:42', '2026-06-14 00:16:42'),
(303, 68, 'images/seguimientos/6a2e00fa102e4_FUMI 8.jpeg', '2026-06-14 00:16:42', '2026-06-14 00:16:42'),
(304, 68, 'images/seguimientos/6a2e00fa4cb7c_FUMI 9.jpeg', '2026-06-14 00:16:42', '2026-06-14 00:16:42'),
(305, 68, 'images/seguimientos/6a2e00fa89487_FUMI 10.jpeg', '2026-06-14 00:16:42', '2026-06-14 00:16:42'),
(306, 68, 'images/seguimientos/6a2e00fabf2f6_FUMI 11.jpeg', '2026-06-14 00:16:42', '2026-06-14 00:16:42'),
(307, 68, 'images/seguimientos/6a2e00faf0d2f_FUMI2.jpeg', '2026-06-14 00:16:43', '2026-06-14 00:16:43'),
(308, 68, 'images/seguimientos/6a2e00fb28ba3_FUMI 6 - copia.jpeg', '2026-06-14 00:16:43', '2026-06-14 00:16:43'),
(309, 68, 'images/seguimientos/6a2e00fb42f46_FUMI 1 - copia.jpeg', '2026-06-14 00:16:43', '2026-06-14 00:16:43'),
(310, 68, 'images/seguimientos/6a2e00fb764cc_FUMI 3 - copia.jpeg', '2026-06-14 00:16:43', '2026-06-14 00:16:43'),
(311, 68, 'images/seguimientos/6a2e00fb96f0e_FUMI 4 - copia.jpeg', '2026-06-14 00:16:43', '2026-06-14 00:16:43'),
(312, 68, 'images/seguimientos/6a2e00fbc3dc9_FUMI 5 - copia.jpeg', '2026-06-14 00:16:43', '2026-06-14 00:16:43'),
(313, 69, 'images/seguimientos/6a359ebdaa511_1000013451.jpg', '2026-06-19 18:55:41', '2026-06-19 18:55:41'),
(314, 69, 'images/seguimientos/6a359ebdaacce_1000013450.jpg', '2026-06-19 18:55:41', '2026-06-19 18:55:41'),
(315, 69, 'images/seguimientos/6a359ebdaaf3f_1000013449.jpg', '2026-06-19 18:55:41', '2026-06-19 18:55:41'),
(316, 69, 'images/seguimientos/6a359ebdab200_1000013448.jpg', '2026-06-19 18:55:41', '2026-06-19 18:55:41'),
(317, 69, 'images/seguimientos/6a359ebdab40c_1000013445.jpg', '2026-06-19 18:55:41', '2026-06-19 18:55:41'),
(318, 69, 'images/seguimientos/6a359ebdb416c_1000013446.jpg', '2026-06-19 18:55:41', '2026-06-19 18:55:41'),
(319, 71, 'images/seguimientos/6a396af9d7440_1000013675.jpg', '2026-06-22 16:03:53', '2026-06-22 16:03:53'),
(320, 71, 'images/seguimientos/6a396af9d7b93_1000013674.jpg', '2026-06-22 16:03:53', '2026-06-22 16:03:53'),
(321, 71, 'images/seguimientos/6a396af9ecaad_1000013673.jpg', '2026-06-22 16:03:54', '2026-06-22 16:03:54'),
(322, 71, 'images/seguimientos/6a396afa0a803_1000013672.jpg', '2026-06-22 16:03:54', '2026-06-22 16:03:54'),
(323, 71, 'images/seguimientos/6a396afa1b8b4_1000013668.jpg', '2026-06-22 16:03:54', '2026-06-22 16:03:54'),
(324, 71, 'images/seguimientos/6a396afa32e4a_1000013671.jpg', '2026-06-22 16:03:54', '2026-06-22 16:03:54'),
(325, 71, 'images/seguimientos/6a396afa3f4a2_1000013670.jpg', '2026-06-22 16:03:54', '2026-06-22 16:03:54'),
(326, 71, 'images/seguimientos/6a396afa4c131_1000013669.jpg', '2026-06-22 16:03:54', '2026-06-22 16:03:54'),
(327, 71, 'images/seguimientos/6a396afa54860_1000013664.jpg', '2026-06-22 16:03:54', '2026-06-22 16:03:54'),
(328, 71, 'images/seguimientos/6a396afa7ba87_1000013665.jpg', '2026-06-22 16:03:54', '2026-06-22 16:03:54'),
(329, 71, 'images/seguimientos/6a396afa9aa4a_1000013666.jpg', '2026-06-22 16:03:54', '2026-06-22 16:03:54'),
(330, 71, 'images/seguimientos/6a396afabbd54_1000013667.jpg', '2026-06-22 16:03:54', '2026-06-22 16:03:54'),
(331, 71, 'images/seguimientos/6a396afae0f14_1000013663.jpg', '2026-06-22 16:03:55', '2026-06-22 16:03:55');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `seguimiento_metodos`
--

CREATE TABLE `seguimiento_metodos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `seguimiento_id` bigint(20) UNSIGNED NOT NULL,
  `metodo_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `seguimiento_metodos`
--

INSERT INTO `seguimiento_metodos` (`id`, `seguimiento_id`, `metodo_id`, `created_at`, `updated_at`) VALUES
(27, 1, 3, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(28, 1, 2, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(29, 1, 1, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(33, 3, 3, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(34, 3, 2, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(35, 3, 1, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(36, 5, 3, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(37, 5, 2, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(38, 5, 1, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(39, 7, 3, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(40, 7, 2, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(41, 7, 1, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(42, 9, 3, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(43, 9, 2, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(44, 9, 1, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(45, 11, 3, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(46, 11, 2, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(47, 11, 1, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(48, 13, 3, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(49, 13, 2, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(50, 13, 1, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(51, 15, 3, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(52, 15, 2, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(64, 21, 2, '2026-05-13 02:42:02', '2026-05-13 02:42:02'),
(65, 21, 1, '2026-05-13 02:42:02', '2026-05-13 02:42:02'),
(68, 23, 3, '2026-05-14 17:01:10', '2026-05-14 17:01:10'),
(69, 23, 1, '2026-05-14 17:01:10', '2026-05-14 17:01:10'),
(70, 24, 3, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(71, 24, 1, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(72, 25, 3, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(73, 25, 1, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(74, 26, 3, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(75, 26, 1, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(76, 27, 3, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(77, 27, 1, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(78, 28, 3, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(79, 28, 1, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(80, 29, 3, '2026-05-18 14:55:42', '2026-05-18 14:55:42'),
(81, 29, 1, '2026-05-18 14:55:42', '2026-05-18 14:55:42'),
(82, 30, 3, '2026-05-18 15:56:33', '2026-05-18 15:56:33'),
(83, 30, 1, '2026-05-18 15:56:33', '2026-05-18 15:56:33'),
(84, 31, 3, '2026-05-18 16:34:39', '2026-05-18 16:34:39'),
(85, 31, 1, '2026-05-18 16:34:39', '2026-05-18 16:34:39'),
(86, 32, 3, '2026-05-18 20:43:18', '2026-05-18 20:43:18'),
(87, 32, 1, '2026-05-18 20:43:18', '2026-05-18 20:43:18'),
(88, 33, 3, '2026-05-18 20:57:53', '2026-05-18 20:57:53'),
(89, 33, 1, '2026-05-18 20:57:53', '2026-05-18 20:57:53'),
(90, 34, 3, '2026-05-18 21:18:23', '2026-05-18 21:18:23'),
(91, 34, 1, '2026-05-18 21:18:23', '2026-05-18 21:18:23'),
(92, 35, 3, '2026-05-18 21:31:23', '2026-05-18 21:31:23'),
(93, 35, 1, '2026-05-18 21:31:23', '2026-05-18 21:31:23'),
(94, 36, 3, '2026-05-18 22:35:45', '2026-05-18 22:35:45'),
(95, 36, 1, '2026-05-18 22:35:45', '2026-05-18 22:35:45'),
(96, 37, 3, '2026-05-18 23:21:01', '2026-05-18 23:21:01'),
(97, 37, 1, '2026-05-18 23:21:01', '2026-05-18 23:21:01'),
(98, 38, 3, '2026-05-18 23:36:03', '2026-05-18 23:36:03'),
(99, 38, 1, '2026-05-18 23:36:03', '2026-05-18 23:36:03'),
(100, 39, 3, '2026-05-18 23:43:16', '2026-05-18 23:43:16'),
(101, 39, 1, '2026-05-18 23:43:16', '2026-05-18 23:43:16'),
(102, 39, 2, '2026-05-18 23:43:16', '2026-05-18 23:43:16'),
(106, 41, 2, '2026-05-18 23:57:41', '2026-05-18 23:57:41'),
(107, 41, 1, '2026-05-18 23:57:41', '2026-05-18 23:57:41'),
(108, 42, 2, '2026-05-19 00:04:18', '2026-05-19 00:04:18'),
(109, 42, 1, '2026-05-19 00:04:18', '2026-05-19 00:04:18'),
(110, 43, 4, '2026-05-19 19:50:31', '2026-05-19 19:50:31'),
(111, 43, 6, '2026-05-19 19:50:31', '2026-05-19 19:50:31'),
(112, 44, 4, '2026-05-19 19:54:03', '2026-05-19 19:54:03'),
(113, 44, 6, '2026-05-19 19:54:03', '2026-05-19 19:54:03'),
(120, 40, 3, '2026-05-19 21:17:31', '2026-05-19 21:17:31'),
(121, 40, 2, '2026-05-19 21:17:31', '2026-05-19 21:17:31'),
(122, 40, 1, '2026-05-19 21:17:31', '2026-05-19 21:17:31'),
(128, 52, 3, '2026-05-22 01:59:29', '2026-05-22 01:59:29'),
(129, 52, 1, '2026-05-22 01:59:29', '2026-05-22 01:59:29'),
(130, 52, 2, '2026-05-22 01:59:29', '2026-05-22 01:59:29'),
(131, 54, 3, '2026-05-22 02:09:35', '2026-05-22 02:09:35'),
(132, 54, 1, '2026-05-22 02:09:35', '2026-05-22 02:09:35'),
(147, 20, 1, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(148, 55, 3, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(149, 55, 1, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(150, 22, 4, '2026-05-25 22:07:39', '2026-05-25 22:07:39'),
(151, 17, 1, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(152, 17, 2, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(153, 57, 3, '2026-06-06 17:55:47', '2026-06-06 17:55:47'),
(154, 57, 1, '2026-06-06 17:55:47', '2026-06-06 17:55:47'),
(155, 57, 2, '2026-06-06 17:55:47', '2026-06-06 17:55:47'),
(156, 58, 4, '2026-06-06 17:59:07', '2026-06-06 17:59:07'),
(163, 60, 3, '2026-06-10 13:48:17', '2026-06-10 13:48:17'),
(164, 60, 1, '2026-06-10 13:48:17', '2026-06-10 13:48:17'),
(165, 61, 4, '2026-06-10 13:49:03', '2026-06-10 13:49:03'),
(166, 61, 7, '2026-06-10 13:49:03', '2026-06-10 13:49:03'),
(170, 65, 3, '2026-06-11 18:31:40', '2026-06-11 18:31:40'),
(171, 65, 1, '2026-06-11 18:31:40', '2026-06-11 18:31:40'),
(172, 65, 2, '2026-06-11 18:31:40', '2026-06-11 18:31:40'),
(173, 63, 3, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(174, 63, 1, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(175, 63, 2, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(178, 66, 2, '2026-06-12 21:59:56', '2026-06-12 21:59:56'),
(179, 66, 1, '2026-06-12 21:59:56', '2026-06-12 21:59:56'),
(182, 68, 4, '2026-06-14 00:18:55', '2026-06-14 00:18:55'),
(183, 68, 7, '2026-06-14 00:18:55', '2026-06-14 00:18:55'),
(184, 69, 3, '2026-06-19 18:55:41', '2026-06-19 18:55:41'),
(185, 69, 1, '2026-06-19 18:55:41', '2026-06-19 18:55:41'),
(186, 69, 2, '2026-06-19 18:55:41', '2026-06-19 18:55:41'),
(187, 71, 4, '2026-06-22 16:03:53', '2026-06-22 16:03:53'),
(188, 71, 5, '2026-06-22 16:03:53', '2026-06-22 16:03:53');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `seguimiento_protecciones`
--

CREATE TABLE `seguimiento_protecciones` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `seguimiento_id` bigint(20) UNSIGNED NOT NULL,
  `proteccion_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `seguimiento_protecciones`
--

INSERT INTO `seguimiento_protecciones` (`id`, `seguimiento_id`, `proteccion_id`, `created_at`, `updated_at`) VALUES
(3, 2, 2, '2026-05-03 14:09:03', '2026-05-03 14:09:03'),
(4, 2, 1, '2026-05-03 14:09:03', '2026-05-03 14:09:03'),
(35, 1, 1, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(36, 1, 2, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(41, 3, 1, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(42, 3, 2, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(43, 4, 1, '2026-05-05 23:26:19', '2026-05-05 23:26:19'),
(44, 4, 2, '2026-05-05 23:26:19', '2026-05-05 23:26:19'),
(45, 5, 1, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(46, 5, 2, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(49, 6, 1, '2026-05-05 23:32:10', '2026-05-05 23:32:10'),
(50, 6, 2, '2026-05-05 23:32:10', '2026-05-05 23:32:10'),
(51, 7, 1, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(52, 7, 2, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(53, 8, 1, '2026-05-05 23:43:34', '2026-05-05 23:43:34'),
(54, 8, 2, '2026-05-05 23:43:34', '2026-05-05 23:43:34'),
(55, 9, 1, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(56, 9, 2, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(57, 10, 1, '2026-05-05 23:44:37', '2026-05-05 23:44:37'),
(58, 10, 2, '2026-05-05 23:44:37', '2026-05-05 23:44:37'),
(59, 11, 1, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(60, 11, 2, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(61, 12, 1, '2026-05-05 23:45:38', '2026-05-05 23:45:38'),
(62, 12, 2, '2026-05-05 23:45:38', '2026-05-05 23:45:38'),
(63, 13, 1, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(64, 13, 2, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(65, 14, 1, '2026-05-05 23:47:23', '2026-05-05 23:47:23'),
(66, 14, 2, '2026-05-05 23:47:23', '2026-05-05 23:47:23'),
(67, 15, 1, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(68, 15, 2, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(69, 16, 1, '2026-05-05 23:48:28', '2026-05-05 23:48:28'),
(70, 16, 2, '2026-05-05 23:48:28', '2026-05-05 23:48:28'),
(87, 18, 2, '2026-05-12 11:58:42', '2026-05-12 11:58:42'),
(94, 21, 1, '2026-05-13 02:42:02', '2026-05-13 02:42:02'),
(95, 21, 2, '2026-05-13 02:42:02', '2026-05-13 02:42:02'),
(98, 23, 2, '2026-05-14 17:01:10', '2026-05-14 17:01:10'),
(99, 23, 1, '2026-05-14 17:01:10', '2026-05-14 17:01:10'),
(100, 24, 2, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(101, 24, 1, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(102, 25, 2, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(103, 25, 1, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(104, 26, 2, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(105, 26, 1, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(106, 27, 2, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(107, 27, 1, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(108, 28, 2, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(109, 28, 1, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(110, 29, 2, '2026-05-18 14:55:42', '2026-05-18 14:55:42'),
(111, 29, 1, '2026-05-18 14:55:42', '2026-05-18 14:55:42'),
(112, 30, 2, '2026-05-18 15:56:33', '2026-05-18 15:56:33'),
(113, 30, 1, '2026-05-18 15:56:33', '2026-05-18 15:56:33'),
(114, 31, 2, '2026-05-18 16:34:39', '2026-05-18 16:34:39'),
(115, 31, 1, '2026-05-18 16:34:39', '2026-05-18 16:34:39'),
(116, 32, 2, '2026-05-18 20:43:18', '2026-05-18 20:43:18'),
(117, 32, 1, '2026-05-18 20:43:18', '2026-05-18 20:43:18'),
(118, 33, 2, '2026-05-18 20:57:53', '2026-05-18 20:57:53'),
(119, 33, 1, '2026-05-18 20:57:53', '2026-05-18 20:57:53'),
(120, 34, 2, '2026-05-18 21:18:23', '2026-05-18 21:18:23'),
(121, 34, 1, '2026-05-18 21:18:23', '2026-05-18 21:18:23'),
(122, 35, 2, '2026-05-18 21:31:23', '2026-05-18 21:31:23'),
(123, 35, 1, '2026-05-18 21:31:23', '2026-05-18 21:31:23'),
(124, 36, 2, '2026-05-18 22:35:46', '2026-05-18 22:35:46'),
(125, 36, 1, '2026-05-18 22:35:46', '2026-05-18 22:35:46'),
(126, 37, 2, '2026-05-18 23:21:01', '2026-05-18 23:21:01'),
(127, 37, 1, '2026-05-18 23:21:01', '2026-05-18 23:21:01'),
(128, 38, 2, '2026-05-18 23:36:03', '2026-05-18 23:36:03'),
(129, 38, 1, '2026-05-18 23:36:03', '2026-05-18 23:36:03'),
(130, 39, 2, '2026-05-18 23:43:16', '2026-05-18 23:43:16'),
(131, 39, 1, '2026-05-18 23:43:16', '2026-05-18 23:43:16'),
(134, 41, 2, '2026-05-18 23:57:41', '2026-05-18 23:57:41'),
(135, 41, 1, '2026-05-18 23:57:41', '2026-05-18 23:57:41'),
(136, 42, 2, '2026-05-19 00:04:18', '2026-05-19 00:04:18'),
(137, 42, 1, '2026-05-19 00:04:18', '2026-05-19 00:04:18'),
(138, 43, 2, '2026-05-19 19:50:31', '2026-05-19 19:50:31'),
(139, 43, 1, '2026-05-19 19:50:31', '2026-05-19 19:50:31'),
(140, 44, 1, '2026-05-19 19:54:03', '2026-05-19 19:54:03'),
(141, 44, 2, '2026-05-19 19:54:03', '2026-05-19 19:54:03'),
(144, 46, 2, '2026-05-19 20:08:03', '2026-05-19 20:08:03'),
(145, 46, 1, '2026-05-19 20:08:03', '2026-05-19 20:08:03'),
(146, 47, 2, '2026-05-19 20:10:27', '2026-05-19 20:10:27'),
(147, 47, 1, '2026-05-19 20:10:27', '2026-05-19 20:10:27'),
(148, 45, 2, '2026-05-19 20:11:43', '2026-05-19 20:11:43'),
(149, 45, 1, '2026-05-19 20:11:43', '2026-05-19 20:11:43'),
(150, 48, 2, '2026-05-19 20:21:06', '2026-05-19 20:21:06'),
(151, 48, 1, '2026-05-19 20:21:06', '2026-05-19 20:21:06'),
(152, 49, 2, '2026-05-19 20:23:15', '2026-05-19 20:23:15'),
(153, 49, 1, '2026-05-19 20:23:15', '2026-05-19 20:23:15'),
(156, 51, 1, '2026-05-19 20:33:30', '2026-05-19 20:33:30'),
(157, 51, 2, '2026-05-19 20:33:30', '2026-05-19 20:33:30'),
(158, 50, 2, '2026-05-19 20:48:38', '2026-05-19 20:48:38'),
(159, 50, 1, '2026-05-19 20:48:38', '2026-05-19 20:48:38'),
(164, 40, 2, '2026-05-19 21:17:31', '2026-05-19 21:17:31'),
(165, 40, 1, '2026-05-19 21:17:31', '2026-05-19 21:17:31'),
(171, 52, 2, '2026-05-22 01:59:29', '2026-05-22 01:59:29'),
(172, 52, 1, '2026-05-22 01:59:29', '2026-05-22 01:59:29'),
(174, 53, 2, '2026-05-22 02:03:18', '2026-05-22 02:03:18'),
(175, 54, 2, '2026-05-22 02:09:35', '2026-05-22 02:09:35'),
(176, 54, 1, '2026-05-22 02:09:35', '2026-05-22 02:09:35'),
(195, 20, 1, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(196, 20, 2, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(197, 55, 2, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(198, 55, 1, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(199, 56, 2, '2026-05-25 22:05:53', '2026-05-25 22:05:53'),
(200, 22, 3, '2026-05-25 22:07:39', '2026-05-25 22:07:39'),
(201, 19, 1, '2026-05-25 22:08:42', '2026-05-25 22:08:42'),
(202, 19, 2, '2026-05-25 22:08:42', '2026-05-25 22:08:42'),
(203, 17, 2, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(204, 17, 1, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(205, 57, 2, '2026-06-06 17:55:47', '2026-06-06 17:55:47'),
(206, 57, 1, '2026-06-06 17:55:47', '2026-06-06 17:55:47'),
(207, 57, 3, '2026-06-06 17:55:47', '2026-06-06 17:55:47'),
(208, 58, 2, '2026-06-06 17:59:07', '2026-06-06 17:59:07'),
(209, 58, 3, '2026-06-06 17:59:07', '2026-06-06 17:59:07'),
(210, 59, 2, '2026-06-06 18:03:17', '2026-06-06 18:03:17'),
(211, 59, 3, '2026-06-06 18:03:17', '2026-06-06 18:03:17'),
(212, 59, 1, '2026-06-06 18:03:17', '2026-06-06 18:03:17'),
(219, 60, 2, '2026-06-10 13:48:17', '2026-06-10 13:48:17'),
(220, 60, 1, '2026-06-10 13:48:17', '2026-06-10 13:48:17'),
(221, 61, 2, '2026-06-10 13:49:03', '2026-06-10 13:49:03'),
(222, 61, 1, '2026-06-10 13:49:03', '2026-06-10 13:49:03'),
(230, 65, 2, '2026-06-11 18:31:40', '2026-06-11 18:31:40'),
(231, 65, 1, '2026-06-11 18:31:40', '2026-06-11 18:31:40'),
(232, 63, 2, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(233, 63, 3, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(234, 63, 1, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(241, 64, 3, '2026-06-11 23:17:30', '2026-06-11 23:17:30'),
(242, 64, 1, '2026-06-11 23:17:30', '2026-06-11 23:17:30'),
(245, 67, 2, '2026-06-12 21:55:02', '2026-06-12 21:55:02'),
(246, 66, 2, '2026-06-12 21:59:56', '2026-06-12 21:59:56'),
(247, 66, 1, '2026-06-12 21:59:56', '2026-06-12 21:59:56'),
(250, 68, 2, '2026-06-14 00:18:55', '2026-06-14 00:18:55'),
(251, 68, 1, '2026-06-14 00:18:55', '2026-06-14 00:18:55'),
(252, 69, 2, '2026-06-19 18:55:41', '2026-06-19 18:55:41'),
(253, 69, 1, '2026-06-19 18:55:41', '2026-06-19 18:55:41'),
(254, 70, 2, '2026-06-19 19:02:45', '2026-06-19 19:02:45'),
(255, 70, 1, '2026-06-19 19:02:45', '2026-06-19 19:02:45'),
(256, 62, 3, '2026-06-19 19:04:02', '2026-06-19 19:04:02'),
(257, 62, 1, '2026-06-19 19:04:02', '2026-06-19 19:04:02'),
(258, 71, 2, '2026-06-22 16:03:53', '2026-06-22 16:03:53');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `seguimiento_signos`
--

CREATE TABLE `seguimiento_signos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `seguimiento_id` bigint(20) UNSIGNED NOT NULL,
  `signo_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `seguimiento_signos`
--

INSERT INTO `seguimiento_signos` (`id`, `seguimiento_id`, `signo_id`, `created_at`, `updated_at`) VALUES
(8, 21, 7, '2026-05-13 02:42:02', '2026-05-13 02:42:02'),
(10, 23, 7, '2026-05-14 17:01:10', '2026-05-14 17:01:10'),
(11, 24, 7, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(12, 25, 7, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(13, 27, 7, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(14, 28, 7, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(15, 29, 7, '2026-05-18 14:55:42', '2026-05-18 14:55:42'),
(16, 30, 7, '2026-05-18 15:56:33', '2026-05-18 15:56:33'),
(17, 31, 7, '2026-05-18 16:34:39', '2026-05-18 16:34:39'),
(18, 32, 7, '2026-05-18 20:43:18', '2026-05-18 20:43:18'),
(19, 33, 7, '2026-05-18 20:57:53', '2026-05-18 20:57:53'),
(20, 34, 7, '2026-05-18 21:18:23', '2026-05-18 21:18:23'),
(21, 35, 7, '2026-05-18 21:31:23', '2026-05-18 21:31:23'),
(22, 36, 7, '2026-05-18 22:35:46', '2026-05-18 22:35:46'),
(23, 37, 7, '2026-05-18 23:21:01', '2026-05-18 23:21:01'),
(24, 38, 7, '2026-05-18 23:36:03', '2026-05-18 23:36:03'),
(25, 39, 7, '2026-05-18 23:43:16', '2026-05-18 23:43:16'),
(27, 41, 7, '2026-05-18 23:57:41', '2026-05-18 23:57:41'),
(28, 42, 7, '2026-05-19 00:04:18', '2026-05-19 00:04:18'),
(31, 40, 7, '2026-05-19 21:17:31', '2026-05-19 21:17:31'),
(34, 52, 7, '2026-05-22 01:59:29', '2026-05-22 01:59:29'),
(35, 54, 7, '2026-05-22 02:09:35', '2026-05-22 02:09:35'),
(43, 20, 7, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(44, 55, 7, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(47, 66, 1, '2026-06-12 21:59:56', '2026-06-12 21:59:56'),
(48, 69, 1, '2026-06-19 18:55:41', '2026-06-19 18:55:41');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('6iHccZGEMHPQWcW2DwuzraTfziPtLqh60Hg5933U', NULL, '40.77.167.78', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibnFKNm1OWmdscmZZRUg5UkpYaUdsM3JyTElWQ2dLak9EbTNIOTNPYiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzA6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmNvbS9sb2dpbiI7czo1OiJyb3V0ZSI7czo1OiJsb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1782268850),
('aB5vIJKQUxdUeY6k9CelKCkvXUGLMctVv4qSPnQi', NULL, '43.130.139.177', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTjBmaENQWkU0ckIwVFBHOUQzdWpvQVhoMHVEVHhtcVgzTUoyZ0ZhdyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjM6Imh0dHA6Ly9ib2xpdmlhbnBlc3QuY29tIjtzOjU6InJvdXRlIjtzOjQ6ImhvbWUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1782275376),
('BIKdqRSyTT2kGhj4uf68fAxFWYojuJpNOfs7AYFf', NULL, '198.235.24.132', 'Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYmZlOW1nT0N3eWZubEhmSm1raGRlTFVnUWFia2RNSUtPblJRNTg2WiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjQ6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmNvbSI7czo1OiJyb3V0ZSI7czo0OiJob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1782282698),
('dGeFPJ7H1eVOo6vR9PEPmcAltc45xnKKeowvDy7Z', NULL, '135.181.215.47', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRFdEYWo2SFhUTzFtdnF6SHB4ZWVFWGRoOGY1Vk05U3MxMnZ6RjFOVCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjQ6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmNvbSI7czo1OiJyb3V0ZSI7czo0OiJob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1782294838),
('E0DC7TfS1iarKLAXQg9yoANSOpYs66siyC6mhk4L', NULL, '72.1.130.71', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.3', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQ1RZaUxuYU5IMlF6TWVCZ01lNXhTd2t5WjBEbjdyOENwR1c2enVGMyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjQ6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmNvbSI7czo1OiJyb3V0ZSI7czo0OiJob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1782294842),
('FKBPKtBeLPzy7BnuxOSKXyuL88HkZT5TBdRzQaB2', NULL, '43.153.27.244', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiREVlSEVESmpXbDZYQkNsUGlVQXlKS2Nyb3drTVZMRDRUcTJ0T3VXVSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly93d3cuYm9saXZpYW5wZXN0LmNvbSI7czo1OiJyb3V0ZSI7czo0OiJob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1782292087),
('J15k7Apy4ii7xvwNpejl4jMYbti7FD1uzF7n6SyZ', NULL, '162.14.114.97', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQkY3U1BjOTgyWHpYdzRScWlZbTJMNDNpb2pDOWMyNDNJVEVxUGhkVSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjM6Imh0dHA6Ly9ib2xpdmlhbnBlc3QuY29tIjtzOjU6InJvdXRlIjtzOjQ6ImhvbWUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1782300897),
('nafqYXdgkworJnIxJ98EUjjXJpXA0ajlxcVsmO6p', NULL, '150.109.46.88', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYXNRSld2N3BLWFBjVFV3TTFVRkNxYVFqODZ0ZmZYQ1BRWVNsTzZIQyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly93d3cuYm9saXZpYW5wZXN0LmNvbSI7czo1OiJyb3V0ZSI7czo0OiJob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1782277876),
('Ns1OTqODzjT3VZI8wK2Zax96VJEJMHryffH5eGSu', NULL, '52.167.144.176', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUDNCUXVtSExMQTdYTUNsbm5zMmtFMGhUOVJjUWJJRVEzSjg5OUdjSCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzA6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmNvbS9sb2dpbiI7czo1OiJyb3V0ZSI7czo1OiJsb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1782297526),
('QXSFWbG9ht04klIISK4NE6t2K2TL3ZKiRxOewQRb', NULL, '49.235.136.28', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNXp4MGk1U3JyZTh6MEtJeGxHeHprZldsbjZORjR2THFsV0lJbXdHOCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly93d3cuYm9saXZpYW5wZXN0LmNvbSI7czo1OiJyb3V0ZSI7czo0OiJob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1782277902),
('vHnvneNUbOitAT1KKqcmCGYYwd5g8W8ptdqF1Qaj', NULL, '43.166.142.76', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiM3RPNzRSZlZhSlF2WUFpMUdlVTlwWUxUclo1eWxGTjhZNE1vemRmRiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjM6Imh0dHA6Ly9ib2xpdmlhbnBlc3QuY29tIjtzOjU6InJvdXRlIjtzOjQ6ImhvbWUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1782289751),
('zxFckulynjH8ABURTHPPLhQ21wLeH2rPhVova2LP', NULL, '43.165.125.66', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYmxYWFgxRVpSc3pGQTIzaGc1aXhpWndDdnVVNlN3UkQ5Qkk0Q21scSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjM6Imh0dHA6Ly9ib2xpdmlhbnBlc3QuY29tIjtzOjU6InJvdXRlIjtzOjQ6ImhvbWUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1782302654);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `signos`
--

CREATE TABLE `signos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `signos`
--

INSERT INTO `signos` (`id`, `nombre`, `created_at`, `updated_at`) VALUES
(1, 'Huellas', '2026-04-13 13:42:19', '2026-04-13 13:42:19'),
(2, 'Roeduras', '2026-04-13 13:42:19', '2026-04-13 13:42:19'),
(3, 'Madriguera', '2026-04-13 13:42:19', '2026-04-13 13:42:19'),
(4, 'Senda', '2026-04-13 13:42:19', '2026-04-13 13:42:19'),
(5, 'Excrementos', '2026-04-13 13:42:19', '2026-04-13 13:42:19'),
(6, 'Marca de orina', '2026-04-13 13:42:19', '2026-04-13 13:42:19'),
(7, 'Otros', '2026-04-13 13:42:19', '2026-04-13 13:42:19');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `subcategorias`
--

CREATE TABLE `subcategorias` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `categoria_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_seguimientos`
--

CREATE TABLE `tipo_seguimientos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `tipo_seguimientos`
--

INSERT INTO `tipo_seguimientos` (`id`, `nombre`, `created_at`, `updated_at`) VALUES
(1, 'DESRATIZACION', '2026-04-13 13:42:19', '2026-04-13 13:42:19'),
(2, 'FUMIGACION', '2026-04-13 13:42:19', '2026-04-13 13:42:19'),
(3, 'INSECTOCUTORES', '2026-04-13 13:42:19', '2026-04-13 13:42:19'),
(4, 'CONTROL DE AVES', '2026-04-13 13:42:19', '2026-04-13 13:42:19');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `trampas`
--

CREATE TABLE `trampas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `almacen_id` bigint(20) UNSIGNED NOT NULL,
  `mapa_id` bigint(20) UNSIGNED DEFAULT NULL,
  `trampa_tipo_id` bigint(20) UNSIGNED NOT NULL,
  `numero` int(11) NOT NULL,
  `tipo` varchar(255) DEFAULT NULL,
  `posx` int(11) NOT NULL,
  `posy` int(11) NOT NULL,
  `identificador` varchar(255) NOT NULL,
  `estado` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `trampas`
--

INSERT INTO `trampas` (`id`, `almacen_id`, `mapa_id`, `trampa_tipo_id`, `numero`, `tipo`, `posx`, `posy`, `identificador`, `estado`, `created_at`, `updated_at`) VALUES
(848, 1, 2, 3, 1, NULL, 403, 642, '1', 'inactivo', '2026-05-01 11:22:22', '2026-06-18 13:15:17'),
(849, 1, 2, 3, 2, NULL, 496, 640, '2', 'inactivo', '2026-05-01 11:22:22', '2026-06-18 13:15:17'),
(850, 1, 2, 3, 3, NULL, 543, 635, '3', 'inactivo', '2026-05-01 11:22:22', '2026-06-18 13:15:17'),
(851, 1, 2, 3, 4, NULL, 658, 639, '4', 'inactivo', '2026-05-01 11:22:22', '2026-06-18 13:15:17'),
(852, 1, 2, 3, 5, NULL, 766, 644, '5', 'inactivo', '2026-05-01 11:22:22', '2026-06-18 13:15:17'),
(853, 1, 2, 3, 6, NULL, 831, 643, '6', 'inactivo', '2026-05-01 11:22:22', '2026-06-18 13:15:17'),
(854, 1, 2, 3, 7, NULL, 706, 231, '7', 'inactivo', '2026-05-01 11:22:22', '2026-06-18 13:15:17'),
(855, 1, 2, 3, 8, NULL, 395, 210, '8', 'inactivo', '2026-05-01 11:22:22', '2026-06-18 13:15:17'),
(856, 1, 2, 3, 9, NULL, 469, 168, '9', 'inactivo', '2026-05-01 11:22:22', '2026-06-18 13:15:17'),
(857, 1, 2, 3, 10, NULL, 626, 79, '10', 'inactivo', '2026-05-01 11:22:22', '2026-06-18 13:15:17'),
(858, 1, 2, 3, 11, NULL, 351, 67, '11', 'inactivo', '2026-05-01 11:22:22', '2026-06-18 13:15:17'),
(859, 1, 2, 3, 12, NULL, 153, 61, '12', 'inactivo', '2026-05-01 11:22:22', '2026-06-18 13:15:17'),
(860, 1, 2, 3, 13, NULL, 597, 582, '13', 'inactivo', '2026-05-01 11:22:22', '2026-06-18 13:15:17'),
(1152, 4, 4, 3, 1, NULL, 855, 667, '10', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1153, 4, 4, 3, 2, NULL, 919, 672, '9', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1154, 4, 4, 3, 3, NULL, 878, 521, '8', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1155, 4, 4, 3, 4, NULL, 874, 444, '7', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1156, 4, 4, 3, 5, NULL, 878, 328, '6', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1157, 4, 4, 3, 6, NULL, 879, 200, '5', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1158, 4, 4, 3, 7, NULL, 882, 107, '4', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1159, 4, 4, 3, 8, NULL, 881, 68, '3', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1160, 4, 4, 3, 9, NULL, 905, 43, '2', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1161, 4, 4, 3, 10, NULL, 843, 46, '1', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1162, 4, 4, 3, 11, NULL, 814, 667, '11', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1163, 4, 4, 3, 12, NULL, 799, 612, '12', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1164, 4, 4, 3, 13, NULL, 793, 544, '13', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1165, 4, 4, 3, 14, NULL, 784, 413, '14', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1166, 4, 4, 3, 15, NULL, 693, 415, '15', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1167, 4, 4, 3, 16, NULL, 695, 464, '16', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1168, 4, 4, 3, 17, NULL, 571, 592, '17', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1169, 4, 4, 3, 18, NULL, 524, 672, '18', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1170, 4, 4, 3, 19, NULL, 448, 673, '19', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1171, 4, 4, 3, 20, NULL, 278, 673, '21', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1172, 4, 4, 3, 21, NULL, 358, 669, '20', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1173, 4, 4, 3, 22, NULL, 95, 670, '25', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1174, 4, 4, 3, 23, NULL, 141, 671, '24', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1175, 4, 4, 3, 24, NULL, 248, 672, '22', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1176, 4, 4, 3, 25, NULL, 193, 674, '23', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1177, 4, 4, 3, 26, NULL, 39, 359, '29', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1178, 4, 4, 3, 27, NULL, 40, 414, '28', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1179, 4, 4, 3, 28, NULL, 40, 479, '27', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1180, 4, 4, 3, 29, NULL, 41, 557, '26', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1181, 4, 4, 3, 30, NULL, 38, 256, '30', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1182, 4, 4, 3, 31, NULL, 37, 173, '31', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1183, 4, 4, 3, 32, NULL, 36, 58, '32', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1184, 4, 4, 3, 33, NULL, 221, 52, '35', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1185, 4, 4, 3, 34, NULL, 84, 53, '33', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1186, 4, 4, 3, 35, NULL, 146, 53, '34', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1187, 4, 4, 3, 36, NULL, 223, 88, '36', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1188, 4, 4, 3, 37, NULL, 282, 53, '37', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1189, 4, 4, 3, 38, NULL, 342, 52, '38', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1190, 4, 4, 3, 39, NULL, 516, 49, '40', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1191, 4, 4, 3, 40, NULL, 424, 50, '39', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1192, 4, 4, 3, 41, NULL, 565, 50, '41', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1193, 4, 4, 3, 42, NULL, 607, 51, '42', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1194, 4, 4, 3, 43, NULL, 674, 50, '43', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1195, 4, 4, 3, 44, NULL, 739, 51, '44', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1196, 4, 4, 3, 45, NULL, 749, 186, '45', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1197, 4, 4, 3, 46, NULL, 753, 251, '46', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1198, 4, 4, 3, 47, NULL, 760, 336, '47', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1199, 4, 4, 3, 48, NULL, 830, 328, '48', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1200, 4, 4, 3, 49, NULL, 827, 231, '49', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1201, 4, 4, 3, 50, NULL, 820, 129, '50', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1202, 4, 4, 3, 51, NULL, 816, 45, '51', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1203, 4, 4, 3, 52, NULL, 762, 50, '52', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1204, 4, 4, 3, 53, NULL, 922, 61, '53', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1205, 4, 4, 3, 54, NULL, 901, 151, '54', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1206, 4, 4, 3, 55, NULL, 953, 77, '55', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1207, 4, 4, 3, 56, NULL, 948, 190, '60', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1208, 4, 4, 3, 57, NULL, 951, 153, '57', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1209, 4, 4, 3, 58, NULL, 954, 108, '56', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1210, 4, 4, 3, 59, NULL, 902, 192, '58', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1211, 4, 4, 3, 60, NULL, 902, 274, '59', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1212, 4, 4, 3, 61, NULL, 949, 280, '61', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1213, 4, 4, 3, 62, NULL, 929, 208, '62', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1214, 4, 4, 3, 63, NULL, 951, 228, '63', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1215, 4, 4, 3, 64, NULL, 931, 245, '64', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1216, 4, 4, 3, 65, NULL, 900, 312, '65', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1217, 4, 4, 3, 66, NULL, 953, 312, '66', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1218, 4, 4, 3, 67, NULL, 902, 374, '68', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1219, 4, 4, 3, 68, NULL, 951, 368, '67', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1220, 4, 4, 3, 69, NULL, 904, 521, '69', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1221, 4, 4, 3, 70, NULL, 947, 607, '70', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1222, 4, 4, 3, 71, NULL, 900, 609, '71', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1223, 4, 4, 3, 72, NULL, 764, 434, '72', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1224, 4, 4, 3, 73, NULL, 717, 439, '73', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1225, 4, 4, 3, 74, NULL, 738, 669, '76', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1226, 4, 4, 3, 75, NULL, 722, 507, '74', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1227, 4, 4, 3, 76, NULL, 730, 580, '75', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1228, 4, 4, 3, 77, NULL, 770, 669, '77', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1229, 4, 4, 3, 78, NULL, 759, 580, '78', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1230, 4, 4, 3, 79, NULL, 754, 507, '79', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1231, 4, 4, 3, 80, NULL, 682, 564, '80', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1232, 4, 4, 3, 81, NULL, 679, 670, '82', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1233, 4, 4, 3, 82, NULL, 674, 610, '81', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1234, 4, 4, 3, 83, NULL, 718, 674, '83', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1235, 4, 4, 3, 84, NULL, 707, 590, '84', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1236, 4, 4, 3, 85, NULL, 701, 513, '85', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1237, 4, 4, 3, 86, NULL, 804, 209, '86', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1238, 4, 4, 3, 87, NULL, 799, 127, '87', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1239, 4, 4, 3, 88, NULL, 793, 69, '88', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1240, 4, 4, 3, 89, NULL, 762, 73, '89', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1241, 4, 4, 3, 90, NULL, 768, 130, '90', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1242, 4, 4, 3, 91, NULL, 774, 210, '91', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1243, 4, 4, 3, 92, NULL, 775, 270, '92', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1244, 4, 4, 3, 93, NULL, 780, 313, '93', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1245, 4, 4, 3, 94, NULL, 811, 309, '94', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1246, 4, 4, 3, 95, NULL, 809, 267, '95', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1247, 4, 4, 3, 96, NULL, 944, 394, '96', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1248, 4, 4, 3, 97, NULL, 944, 487, '97', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1249, 4, 4, 3, 98, NULL, 901, 483, '98', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1250, 4, 4, 3, 99, NULL, 582, 493, '99', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1251, 4, 4, 3, 100, NULL, 514, 495, '100', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1252, 4, 4, 4, 101, NULL, 542, 176, '1V', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1253, 4, 4, 4, 102, NULL, 554, 150, '2V', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1254, 4, 4, 4, 103, NULL, 528, 148, '3V', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1255, 4, 4, 4, 104, NULL, 504, 150, '4V', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1256, 4, 4, 4, 105, NULL, 484, 153, '5V', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1257, 4, 4, 4, 106, NULL, 517, 176, '6V', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1258, 4, 4, 4, 107, NULL, 394, 148, '7V', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1259, 4, 4, 4, 108, NULL, 311, 154, '8V', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1260, 4, 4, 4, 109, NULL, 271, 134, '9V', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1261, 4, 4, 4, 110, NULL, 243, 135, '10V', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1262, 4, 4, 4, 111, NULL, 245, 182, '11V', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1263, 4, 4, 4, 112, NULL, 248, 207, '12V', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1264, 4, 4, 4, 113, NULL, 278, 198, '13V', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1265, 4, 4, 4, 114, NULL, 248, 252, '14V', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1266, 4, 4, 4, 115, NULL, 276, 281, '15V', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1267, 4, 4, 4, 116, NULL, 280, 374, '16V', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1268, 4, 4, 4, 117, NULL, 254, 375, '17V', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1269, 4, 4, 4, 118, NULL, 254, 399, '18V', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1270, 4, 4, 4, 119, NULL, 280, 399, '19V', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1271, 4, 4, 4, 120, NULL, 279, 452, '20V', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1272, 4, 4, 4, 121, NULL, 300, 486, '21V', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1273, 4, 4, 4, 122, NULL, 359, 478, '22V', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1274, 4, 4, 4, 123, NULL, 415, 472, '23V', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1275, 4, 4, 4, 124, NULL, 410, 414, '24V', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1276, 4, 4, 4, 125, NULL, 464, 378, '25V', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1277, 4, 4, 4, 126, NULL, 593, 457, '26V', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1278, 4, 4, 4, 127, NULL, 527, 371, '27V', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1279, 4, 4, 4, 128, NULL, 608, 396, '28V', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1280, 4, 4, 4, 129, NULL, 643, 332, '29V', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1281, 4, 4, 4, 130, NULL, 636, 260, '30V', 'activo', '2026-05-01 12:45:14', '2026-05-01 12:45:14'),
(1340, 5, 5, 3, 1, 'null', 744, 592, '1', 'activo', '2026-05-01 14:50:39', '2026-05-01 14:50:39'),
(1341, 5, 5, 3, 2, 'null', 603, 549, '2', 'activo', '2026-05-01 14:50:39', '2026-05-01 14:50:39'),
(1342, 5, 5, 3, 3, 'null', 489, 468, '3', 'activo', '2026-05-01 14:50:39', '2026-05-01 14:50:39'),
(1343, 5, 5, 3, 4, 'null', 389, 406, '4', 'activo', '2026-05-01 14:50:39', '2026-05-01 14:50:39'),
(1344, 5, 5, 3, 5, 'null', 271, 331, '5', 'activo', '2026-05-01 14:50:39', '2026-05-01 14:50:39'),
(1345, 5, 5, 3, 6, 'null', 144, 251, '6', 'activo', '2026-05-01 14:50:39', '2026-05-01 14:50:39'),
(1346, 5, 5, 3, 7, 'null', 120, 149, '7', 'activo', '2026-05-01 14:50:39', '2026-05-01 14:50:39'),
(1347, 5, 5, 3, 8, 'null', 52, 121, '8', 'activo', '2026-05-01 14:50:39', '2026-05-01 14:50:39'),
(1348, 5, 5, 3, 9, 'null', 263, 39, '9', 'activo', '2026-05-01 14:50:39', '2026-05-01 14:50:39'),
(1349, 5, 5, 3, 10, 'null', 263, 183, '10', 'activo', '2026-05-01 14:50:39', '2026-05-01 14:50:39'),
(1350, 5, 5, 3, 11, 'null', 307, 85, '11', 'activo', '2026-05-01 14:50:39', '2026-05-01 14:50:39'),
(1351, 5, 5, 3, 12, 'null', 301, 210, '12', 'activo', '2026-05-01 14:50:39', '2026-05-01 14:50:39'),
(1352, 5, 5, 3, 13, 'null', 534, 188, '13', 'activo', '2026-05-01 14:50:39', '2026-05-01 14:50:39'),
(1353, 5, 5, 3, 14, 'null', 429, 181, '14', 'activo', '2026-05-01 14:50:39', '2026-05-01 14:50:39'),
(1354, 5, 5, 3, 15, 'null', 334, 184, '15', 'activo', '2026-05-01 14:50:39', '2026-05-01 14:50:39'),
(1355, 5, 5, 3, 16, 'null', 338, 39, '16', 'activo', '2026-05-01 14:50:39', '2026-05-01 14:50:39'),
(1356, 5, 5, 3, 17, 'null', 434, 35, '17', 'activo', '2026-05-01 14:50:39', '2026-05-01 14:50:39'),
(1357, 5, 5, 3, 18, 'null', 619, 36, '18', 'activo', '2026-05-01 14:50:39', '2026-05-01 14:50:39'),
(1358, 5, 5, 3, 19, 'null', 622, 183, '19', 'activo', '2026-05-01 14:50:39', '2026-05-01 14:50:39'),
(1359, 5, 5, 3, 20, 'null', 700, 203, '20', 'activo', '2026-05-01 14:50:39', '2026-05-01 14:50:39'),
(1360, 5, 5, 3, 21, 'null', 784, 208, '21', 'activo', '2026-05-01 14:50:39', '2026-05-01 14:50:39'),
(1361, 5, 5, 3, 22, 'null', 836, 208, '23', 'activo', '2026-05-01 14:50:39', '2026-05-01 14:50:39'),
(1362, 5, 5, 3, 23, 'null', 950, 209, '24', 'activo', '2026-05-01 14:50:39', '2026-05-01 14:50:39'),
(1363, 5, 5, 3, 24, 'null', 818, 399, '22', 'activo', '2026-05-01 14:50:39', '2026-05-01 14:50:39'),
(1364, 5, 5, 3, 25, 'null', 945, 645, '25', 'activo', '2026-05-01 14:50:39', '2026-05-01 14:50:39'),
(1365, 5, 5, 3, 26, 'null', 838, 644, '26', 'activo', '2026-05-01 14:50:39', '2026-05-01 14:50:39'),
(1366, 5, 5, 4, 27, 'null', 763, 510, '27', 'activo', '2026-05-01 14:50:39', '2026-05-01 14:50:39'),
(1367, 5, 5, 4, 28, 'null', 812, 511, '28', 'activo', '2026-05-01 14:50:39', '2026-05-01 14:50:39'),
(1368, 5, 5, 4, 29, 'null', 812, 593, '29', 'activo', '2026-05-01 14:50:39', '2026-05-01 14:50:39'),
(1369, 5, 5, 4, 30, 'null', 812, 653, '30', 'activo', '2026-05-01 14:50:39', '2026-05-01 14:50:39'),
(1394, 5, 6, 3, 1, NULL, 292, 637, '31', 'activo', '2026-05-01 15:47:26', '2026-05-01 15:47:26'),
(1395, 5, 6, 3, 2, NULL, 700, 632, '32', 'activo', '2026-05-01 15:47:26', '2026-05-01 15:47:26'),
(1396, 5, 6, 3, 3, NULL, 925, 328, '33', 'activo', '2026-05-01 15:47:26', '2026-05-01 15:47:26'),
(1397, 5, 6, 3, 4, NULL, 925, 219, '34', 'activo', '2026-05-01 15:47:26', '2026-05-01 15:47:26'),
(1398, 5, 6, 3, 5, NULL, 680, 206, '35', 'activo', '2026-05-01 15:47:26', '2026-05-01 15:47:26'),
(1399, 5, 6, 3, 6, NULL, 680, 78, '36', 'activo', '2026-05-01 15:47:26', '2026-05-01 15:47:26'),
(1400, 5, 6, 3, 7, NULL, 333, 85, '37', 'activo', '2026-05-01 15:47:26', '2026-05-01 15:47:26'),
(1401, 5, 6, 3, 8, NULL, 338, 210, '38', 'activo', '2026-05-01 15:47:26', '2026-05-01 15:47:26'),
(1402, 5, 6, 3, 9, NULL, 460, 259, '39', 'activo', '2026-05-01 15:47:26', '2026-05-01 15:47:26'),
(1403, 5, 6, 3, 10, NULL, 83, 257, '40', 'activo', '2026-05-01 15:47:26', '2026-05-01 15:47:26'),
(1404, 5, 6, 3, 11, NULL, 83, 402, '41', 'activo', '2026-05-01 15:47:26', '2026-05-01 15:47:26'),
(1405, 5, 6, 3, 12, NULL, 75, 637, '42', 'activo', '2026-05-01 15:47:26', '2026-05-01 15:47:26'),
(1435, 7, 7, 3, 1, NULL, 982, 500, '1', 'activo', '2026-05-01 16:05:26', '2026-05-01 16:05:26'),
(1436, 7, 7, 3, 2, NULL, 981, 643, '2', 'activo', '2026-05-01 16:05:26', '2026-05-01 16:05:26'),
(1437, 7, 7, 3, 3, NULL, 987, 395, '3', 'activo', '2026-05-01 16:05:26', '2026-05-01 16:05:26'),
(1438, 7, 7, 3, 4, NULL, 908, 397, '4', 'activo', '2026-05-01 16:05:26', '2026-05-01 16:05:26'),
(1439, 7, 7, 3, 5, NULL, 732, 687, '5', 'activo', '2026-05-01 16:05:26', '2026-05-01 16:05:26'),
(1440, 7, 7, 3, 6, NULL, 441, 686, '6', 'activo', '2026-05-01 16:05:26', '2026-05-01 16:05:26'),
(1441, 7, 7, 3, 7, NULL, 274, 678, '7', 'activo', '2026-05-01 16:05:26', '2026-05-01 16:05:26'),
(1442, 7, 7, 3, 8, NULL, 192, 630, '8', 'activo', '2026-05-01 16:05:26', '2026-05-01 16:05:26'),
(1443, 7, 7, 3, 9, NULL, 148, 397, '9', 'activo', '2026-05-01 16:05:26', '2026-05-01 16:05:26'),
(1444, 7, 7, 3, 10, NULL, 52, 679, '10', 'activo', '2026-05-01 16:05:26', '2026-05-01 16:05:26'),
(1445, 7, 7, 3, 11, NULL, 604, 641, '11', 'activo', '2026-05-01 16:05:26', '2026-05-01 16:05:26'),
(1446, 7, 7, 3, 12, NULL, 544, 641, '12', 'activo', '2026-05-01 16:05:26', '2026-05-01 16:05:26'),
(1447, 7, 7, 3, 13, NULL, 374, 642, '13', 'activo', '2026-05-01 16:05:26', '2026-05-01 16:05:26'),
(1448, 7, 7, 3, 14, NULL, 226, 642, '14', 'activo', '2026-05-01 16:05:26', '2026-05-01 16:05:26'),
(1449, 7, 7, 3, 15, NULL, 325, 404, '15', 'activo', '2026-05-01 16:05:26', '2026-05-01 16:05:26'),
(1450, 7, 7, 3, 16, NULL, 378, 406, '16', 'activo', '2026-05-01 16:05:26', '2026-05-01 16:05:26'),
(1451, 7, 7, 4, 17, NULL, 553, 374, '17', 'activo', '2026-05-01 16:05:26', '2026-05-01 16:05:26'),
(1452, 7, 7, 3, 18, NULL, 225, 370, '18', 'activo', '2026-05-01 16:05:26', '2026-05-01 16:05:26'),
(1453, 7, 7, 3, 19, NULL, 338, 336, '19', 'activo', '2026-05-01 16:05:26', '2026-05-01 16:05:26'),
(1454, 7, 7, 3, 20, NULL, 232, 123, '20', 'activo', '2026-05-01 16:05:26', '2026-05-01 16:05:26'),
(1455, 7, 7, 4, 21, NULL, 378, 122, '21', 'activo', '2026-05-01 16:05:26', '2026-05-01 16:05:26'),
(1456, 7, 7, 4, 22, NULL, 810, 117, '22', 'activo', '2026-05-01 16:05:26', '2026-05-01 16:05:26'),
(1457, 7, 7, 4, 23, NULL, 838, 360, '23', 'activo', '2026-05-01 16:05:26', '2026-05-01 16:05:26'),
(1458, 7, 7, 4, 24, NULL, 880, 649, '24', 'activo', '2026-05-01 16:05:26', '2026-05-01 16:05:26'),
(1459, 7, 7, 4, 25, NULL, 654, 644, '25', 'activo', '2026-05-01 16:05:26', '2026-05-01 16:05:26'),
(1460, 7, 7, 4, 26, NULL, 104, 639, '26', 'activo', '2026-05-01 16:05:26', '2026-05-01 16:05:26'),
(1461, 7, 7, 4, 27, NULL, 27, 481, '27', 'activo', '2026-05-01 16:05:26', '2026-05-01 16:05:26'),
(1462, 7, 7, 4, 28, NULL, 975, 259, '28', 'activo', '2026-05-01 16:05:26', '2026-05-01 16:05:26'),
(1463, 7, 7, 4, 29, NULL, 915, 119, '29', 'activo', '2026-05-01 16:05:26', '2026-05-01 16:05:26'),
(1464, 7, 7, 2, 30, NULL, 596, 502, 'INSECT', 'activo', '2026-05-01 16:05:26', '2026-05-01 16:05:26'),
(1465, 1, 3, 3, 1, NULL, 85, 180, '1', 'activo', '2026-05-01 19:35:38', '2026-06-18 13:24:39'),
(1466, 1, 3, 3, 2, NULL, 270, 62, '2', 'activo', '2026-05-01 19:35:38', '2026-06-18 13:24:39'),
(1467, 1, 3, 3, 3, NULL, 574, 54, '3', 'activo', '2026-05-01 19:35:38', '2026-06-18 13:24:39'),
(1468, 1, 3, 3, 4, NULL, 590, 182, '4', 'activo', '2026-05-01 19:35:38', '2026-06-18 13:24:39'),
(1469, 1, 3, 3, 5, NULL, 581, 276, '5', 'activo', '2026-05-01 19:35:38', '2026-06-18 13:24:39'),
(1470, 1, 3, 3, 6, NULL, 408, 402, '6', 'activo', '2026-05-01 19:35:38', '2026-06-18 13:24:39'),
(1471, 1, 3, 3, 7, NULL, 738, 63, '7', 'activo', '2026-05-01 19:35:38', '2026-06-18 13:24:39'),
(1472, 1, 3, 3, 8, NULL, 900, 206, '8', 'activo', '2026-05-01 19:35:38', '2026-06-18 13:24:39'),
(1473, 1, 3, 3, 9, NULL, 741, 254, '9', 'activo', '2026-05-01 19:35:38', '2026-06-18 13:24:39'),
(1474, 1, 3, 3, 10, NULL, 730, 370, '10', 'activo', '2026-05-01 19:35:38', '2026-06-18 13:24:39'),
(1475, 1, 1, 3, 1, NULL, 715, 324, '1', 'inactivo', '2026-05-03 13:27:31', '2026-06-18 13:24:04'),
(1476, 1, 1, 3, 2, NULL, 639, 323, '2', 'inactivo', '2026-05-03 13:27:31', '2026-06-18 13:24:04'),
(1477, 1, 1, 3, 3, NULL, 378, 322, '3', 'inactivo', '2026-05-03 13:27:31', '2026-06-18 13:24:04'),
(1478, 1, 1, 4, 1, NULL, 555, 431, '4', 'activo', '2026-05-03 13:27:31', '2026-06-18 13:24:30'),
(1479, 1, 1, 4, 2, NULL, 470, 513, '5', 'activo', '2026-05-03 13:27:31', '2026-06-18 13:24:30'),
(1480, 1, 1, 4, 3, NULL, 724, 418, '6', 'activo', '2026-05-03 13:27:31', '2026-06-18 13:24:30'),
(1481, 1, 1, 4, 4, NULL, 653, 411, '7', 'activo', '2026-05-03 13:27:31', '2026-06-18 13:24:30'),
(1482, 1, 1, 3, 8, NULL, 664, 465, '8', 'inactivo', '2026-05-03 13:27:31', '2026-06-18 13:24:04'),
(1483, 1, 1, 3, 9, NULL, 531, 508, '9', 'inactivo', '2026-05-03 13:27:31', '2026-06-18 13:24:04'),
(1484, 1, 1, 3, 10, NULL, 556, 455, '10', 'inactivo', '2026-05-03 13:27:31', '2026-06-18 13:24:04'),
(1485, 1, 1, 3, 11, NULL, 573, 510, '11', 'inactivo', '2026-05-03 13:27:31', '2026-06-18 13:24:04'),
(1486, 1, 1, 3, 12, NULL, 721, 505, '12', 'inactivo', '2026-05-03 13:27:31', '2026-06-18 13:24:04'),
(1487, 1, 1, 3, 13, NULL, 407, 477, '13', 'inactivo', '2026-05-03 13:27:31', '2026-06-18 13:24:04'),
(1488, 1, 1, 3, 14, NULL, 375, 474, '14', 'inactivo', '2026-05-03 13:27:31', '2026-06-18 13:24:04'),
(1489, 1, 1, 3, 15, NULL, 376, 511, '15', 'inactivo', '2026-05-03 13:27:31', '2026-06-18 13:24:04'),
(1490, 1, 1, 3, 16, NULL, 288, 654, '16', 'inactivo', '2026-05-03 13:27:31', '2026-06-18 13:24:04'),
(1491, 1, 1, 3, 17, NULL, 283, 472, '17', 'inactivo', '2026-05-03 13:27:31', '2026-06-18 13:24:04'),
(1492, 1, 1, 3, 18, NULL, 353, 326, '18', 'inactivo', '2026-05-03 13:27:31', '2026-06-18 13:24:04'),
(1493, 1, 1, 3, 19, NULL, 349, 623, '19', 'inactivo', '2026-05-03 13:27:31', '2026-06-18 13:24:04'),
(1494, 1, 1, 3, 20, NULL, 323, 663, '20', 'inactivo', '2026-05-03 13:27:31', '2026-06-18 13:24:04'),
(1495, 1, 1, 3, 21, NULL, 661, 671, '21', 'inactivo', '2026-05-03 13:27:31', '2026-06-18 13:24:04'),
(1496, 1, 1, 3, 22, NULL, 725, 596, '22', 'inactivo', '2026-05-03 13:27:31', '2026-06-18 13:24:04'),
(1497, 1, 1, 3, 23, NULL, 626, 486, '24', 'inactivo', '2026-05-03 13:27:31', '2026-06-18 13:24:04'),
(1498, 1, 1, 4, 5, NULL, 724, 538, '23', 'activo', '2026-05-03 13:27:31', '2026-06-18 13:24:30'),
(1499, 1, 1, 4, 6, NULL, 705, 255, '28', 'activo', '2026-05-03 13:27:31', '2026-06-18 13:24:30'),
(1500, 1, 1, 4, 7, NULL, 732, 254, '29', 'activo', '2026-05-03 13:27:31', '2026-06-18 13:24:30'),
(1501, 1, 1, 4, 8, NULL, 376, 281, '30', 'activo', '2026-05-03 13:27:31', '2026-06-18 13:24:30'),
(1502, 1, 1, 4, 9, NULL, 382, 82, '31', 'activo', '2026-05-03 13:27:31', '2026-06-18 13:24:30'),
(1503, 1, 1, 4, 10, NULL, 709, 85, '32', 'activo', '2026-05-03 13:27:31', '2026-06-18 13:24:30'),
(1504, 1, 1, 4, 11, NULL, 767, 111, '33', 'activo', '2026-05-03 13:27:31', '2026-06-18 13:24:30'),
(1505, 1, 1, 4, 12, NULL, 838, 160, '34', 'activo', '2026-05-03 13:27:31', '2026-06-18 13:24:30'),
(1506, 1, 1, 4, 13, NULL, 761, 31, '35', 'activo', '2026-05-03 13:27:31', '2026-06-18 13:24:30'),
(1507, 1, 1, 4, 14, NULL, 967, 27, '36', 'activo', '2026-05-03 13:27:31', '2026-06-18 13:24:30'),
(1508, 1, 1, 4, 15, NULL, 645, 28, '37', 'activo', '2026-05-03 13:27:31', '2026-06-18 13:24:30'),
(1509, 1, 1, 4, 16, NULL, 352, 67, '38', 'activo', '2026-05-03 13:27:31', '2026-06-18 13:24:30'),
(1510, 1, 1, 4, 17, NULL, 371, 22, '39', 'activo', '2026-05-03 13:27:31', '2026-06-18 13:24:30'),
(1511, 1, 1, 4, 18, NULL, 47, 22, '40', 'activo', '2026-05-03 13:27:31', '2026-06-18 13:24:30'),
(1512, 1, 1, 4, 19, NULL, 48, 56, '41', 'activo', '2026-05-03 13:27:31', '2026-06-18 13:24:30'),
(1513, 1, 1, 5, 20, NULL, 577, 332, '46', 'activo', '2026-05-03 13:27:31', '2026-06-18 13:24:30'),
(1514, 1, 1, 5, 21, NULL, 578, 363, '47', 'activo', '2026-05-03 13:27:31', '2026-06-18 13:24:30'),
(1515, 1, 1, 5, 22, NULL, 620, 326, '48', 'activo', '2026-05-03 13:27:31', '2026-06-18 13:24:30'),
(1516, 1, 1, 5, 23, NULL, 620, 365, '49', 'activo', '2026-05-03 13:27:31', '2026-06-18 13:24:30'),
(1517, 1, 1, 5, 24, NULL, 660, 325, '50', 'activo', '2026-05-03 13:27:31', '2026-06-18 13:24:30'),
(1518, 1, 1, 5, 25, NULL, 656, 364, '51', 'activo', '2026-05-03 13:27:31', '2026-06-18 13:24:30'),
(1519, 1, 1, 5, 26, NULL, 689, 324, '52', 'activo', '2026-05-03 13:27:31', '2026-06-18 13:24:30'),
(1520, 1, 1, 5, 27, NULL, 691, 365, '53', 'activo', '2026-05-03 13:27:31', '2026-06-18 13:24:30'),
(1521, 1, 1, 5, 28, NULL, 724, 364, '54', 'activo', '2026-05-03 13:27:31', '2026-06-18 13:24:30'),
(1522, 1, 1, 5, 29, NULL, 732, 316, '55', 'activo', '2026-05-03 13:27:31', '2026-06-18 13:24:30'),
(1523, 1, 1, 2, 30, NULL, 601, 356, 'insect1', 'activo', '2026-05-03 13:27:31', '2026-06-18 13:24:30'),
(1524, 1, 1, 2, 31, NULL, 562, 224, 'insect2', 'activo', '2026-05-03 13:27:31', '2026-06-18 13:24:30'),
(1525, 1, 1, 2, 32, NULL, 707, 216, 'Insect3', 'activo', '2026-05-03 13:27:31', '2026-06-18 13:24:30'),
(1526, 1, 1, 3, 33, NULL, 762, 195, '25', 'activo', '2026-05-03 13:27:31', '2026-06-18 13:24:30'),
(1527, 1, 1, 3, 34, NULL, 727, 155, '26', 'activo', '2026-05-03 13:27:31', '2026-06-18 13:24:30'),
(1528, 1, 1, 3, 35, NULL, 729, 221, '27', 'activo', '2026-05-03 13:27:31', '2026-06-18 13:24:30'),
(1529, 1, 1, 3, 36, NULL, 282, 274, '42', 'activo', '2026-05-03 13:27:31', '2026-06-18 13:24:30'),
(1530, 1, 1, 3, 37, NULL, 195, 187, '43', 'activo', '2026-05-03 13:27:31', '2026-06-18 13:24:30'),
(1531, 1, 1, 3, 38, NULL, 116, 111, '44', 'activo', '2026-05-03 13:27:31', '2026-06-18 13:24:30'),
(1532, 1, 1, 3, 39, NULL, 353, 87, '45', 'activo', '2026-05-03 13:27:31', '2026-06-18 13:24:30'),
(1565, 8, 8, 3, 1, NULL, 677, 62, '1', 'activo', '2026-05-09 02:06:16', '2026-05-09 02:06:16'),
(1566, 8, 8, 3, 2, NULL, 926, 116, '2', 'activo', '2026-05-09 02:06:16', '2026-05-09 02:06:16'),
(1567, 8, 8, 3, 3, NULL, 928, 243, '3', 'activo', '2026-05-09 02:06:16', '2026-05-09 02:06:16'),
(1568, 8, 8, 3, 4, NULL, 930, 656, '8', 'activo', '2026-05-09 02:06:16', '2026-05-09 02:06:16'),
(1569, 8, 8, 3, 5, NULL, 933, 530, '7', 'activo', '2026-05-09 02:06:16', '2026-05-09 02:06:16'),
(1570, 8, 8, 3, 6, NULL, 921, 323, '4', 'activo', '2026-05-09 02:06:16', '2026-05-09 02:06:16'),
(1571, 8, 8, 3, 7, NULL, 924, 424, '6', 'activo', '2026-05-09 02:06:16', '2026-05-09 02:06:16'),
(1572, 8, 8, 3, 8, NULL, 60, 626, '9', 'activo', '2026-05-09 02:06:16', '2026-05-09 02:06:16'),
(1573, 8, 8, 3, 9, NULL, 60, 438, '10', 'activo', '2026-05-09 02:06:16', '2026-05-09 02:06:16'),
(1574, 8, 8, 3, 10, NULL, 211, 497, '11', 'activo', '2026-05-09 02:06:16', '2026-05-09 02:06:16'),
(1575, 8, 8, 3, 11, NULL, 318, 361, '15', 'activo', '2026-05-09 02:06:16', '2026-05-09 02:06:16'),
(1576, 8, 8, 3, 12, NULL, 434, 498, '12', 'activo', '2026-05-09 02:06:16', '2026-05-09 02:06:16'),
(1577, 8, 8, 3, 13, NULL, 758, 367, '13', 'activo', '2026-05-09 02:06:16', '2026-05-09 02:06:16'),
(1578, 8, 8, 3, 14, NULL, 564, 367, '14', 'activo', '2026-05-09 02:06:16', '2026-05-09 02:06:16'),
(1579, 8, 8, 3, 15, NULL, 63, 310, '16', 'activo', '2026-05-09 02:06:16', '2026-05-09 02:06:16'),
(1580, 8, 8, 3, 16, NULL, 210, 237, '17', 'activo', '2026-05-09 02:06:16', '2026-05-09 02:06:16'),
(1711, 4, 4, 2, 131, NULL, 354, 257, 'insecto', 'activo', '2026-05-12 11:57:38', '2026-05-12 11:57:38'),
(1712, 9, 9, 3, 1, NULL, 342, 674, '1', 'activo', '2026-06-06 11:10:42', '2026-06-06 11:14:16'),
(1713, 9, 9, 3, 2, NULL, 422, 675, '2', 'activo', '2026-06-06 11:10:42', '2026-06-06 11:14:16'),
(1714, 9, 9, 3, 3, NULL, 518, 681, '3', 'activo', '2026-06-06 11:10:42', '2026-06-06 11:14:16'),
(1715, 9, 9, 3, 4, NULL, 610, 683, '4', 'activo', '2026-06-06 11:10:42', '2026-06-06 11:14:16'),
(1716, 9, 9, 3, 5, NULL, 698, 683, '5', 'activo', '2026-06-06 11:10:42', '2026-06-06 11:14:16'),
(1717, 9, 9, 3, 6, NULL, 825, 688, '6', 'activo', '2026-06-06 11:10:42', '2026-06-06 11:14:16'),
(1718, 9, 9, 3, 7, NULL, 910, 688, '7', 'activo', '2026-06-06 11:10:42', '2026-06-06 11:14:16'),
(1719, 9, 9, 3, 8, NULL, 989, 691, '8', 'activo', '2026-06-06 11:10:42', '2026-06-06 11:14:16'),
(1720, 9, 9, 3, 9, NULL, 968, 580, '9', 'activo', '2026-06-06 11:10:42', '2026-06-06 11:14:16'),
(1721, 9, 9, 3, 10, NULL, 944, 478, '10', 'activo', '2026-06-06 11:10:42', '2026-06-06 11:14:16'),
(1722, 9, 9, 3, 11, NULL, 930, 414, '11', 'activo', '2026-06-06 11:10:42', '2026-06-06 11:14:16'),
(1723, 9, 9, 3, 12, NULL, 908, 339, '12', 'activo', '2026-06-06 11:10:42', '2026-06-06 11:14:16'),
(1724, 9, 9, 3, 13, NULL, 883, 242, '13', 'activo', '2026-06-06 11:10:42', '2026-06-06 11:14:16'),
(1725, 9, 9, 3, 14, NULL, 868, 147, '14', 'activo', '2026-06-06 11:10:42', '2026-06-06 11:14:16'),
(1726, 9, 9, 3, 15, NULL, 854, 92, '15', 'activo', '2026-06-06 11:10:42', '2026-06-06 11:14:16'),
(1727, 9, 9, 3, 16, NULL, 839, 10, '16', 'activo', '2026-06-06 11:10:42', '2026-06-06 11:14:16'),
(1728, 9, 9, 3, 17, NULL, 768, 39, '17', 'activo', '2026-06-06 11:10:42', '2026-06-06 11:14:16'),
(1729, 9, 9, 3, 18, NULL, 677, 80, '18', 'activo', '2026-06-06 11:10:42', '2026-06-06 11:14:16'),
(1730, 9, 9, 3, 19, NULL, 564, 118, '19', 'activo', '2026-06-06 11:10:42', '2026-06-06 11:14:16'),
(1731, 9, 9, 3, 20, NULL, 504, 142, '20', 'activo', '2026-06-06 11:10:42', '2026-06-06 11:14:16'),
(1732, 9, 9, 3, 21, NULL, 426, 172, '21', 'activo', '2026-06-06 11:10:42', '2026-06-06 11:14:16'),
(1733, 9, 9, 3, 22, NULL, 337, 208, '22', 'activo', '2026-06-06 11:10:42', '2026-06-06 11:14:16'),
(1734, 9, 9, 3, 23, NULL, 257, 238, '23', 'activo', '2026-06-06 11:10:42', '2026-06-06 11:14:16'),
(1735, 9, 9, 3, 24, NULL, 195, 261, '24', 'activo', '2026-06-06 11:10:42', '2026-06-06 11:14:16'),
(1736, 9, 9, 3, 25, NULL, 100, 292, '25', 'activo', '2026-06-06 11:10:42', '2026-06-06 11:14:16'),
(1737, 9, 9, 3, 26, NULL, 14, 326, '26', 'activo', '2026-06-06 11:10:42', '2026-06-06 11:14:16'),
(1738, 9, 9, 3, 27, NULL, 17, 674, '30', 'activo', '2026-06-06 11:10:42', '2026-06-06 11:14:16'),
(1739, 9, 9, 3, 28, NULL, 12, 475, '28', 'activo', '2026-06-06 11:10:42', '2026-06-06 11:14:16'),
(1740, 9, 9, 3, 29, NULL, 14, 390, '27', 'activo', '2026-06-06 11:10:42', '2026-06-06 11:14:16'),
(1741, 9, 9, 3, 30, NULL, 12, 570, '29', 'activo', '2026-06-06 11:10:42', '2026-06-06 11:14:16'),
(1742, 9, 9, 3, 31, NULL, 198, 678, '31', 'activo', '2026-06-06 11:10:42', '2026-06-06 11:14:16'),
(1743, 9, 9, 3, 32, NULL, 252, 678, '32', 'activo', '2026-06-06 11:10:42', '2026-06-06 11:14:16'),
(1744, 9, 9, 2, 33, NULL, 340, 629, 'INSECT 1', 'activo', '2026-06-06 11:14:16', '2026-06-06 11:14:16'),
(1745, 9, 9, 2, 34, NULL, 348, 330, 'INSECT2', 'activo', '2026-06-06 11:14:16', '2026-06-06 11:14:16'),
(1746, 9, 9, 2, 35, NULL, 591, 112, 'INSECT3', 'activo', '2026-06-06 11:14:16', '2026-06-06 11:14:16'),
(1750, 12, 10, 1, 1, NULL, 970, 604, '4', 'activo', '2026-06-06 14:27:57', '2026-06-08 20:13:22'),
(1751, 12, 10, 1, 2, NULL, 913, 672, '5', 'activo', '2026-06-06 14:27:57', '2026-06-08 20:13:22'),
(1752, 12, 10, 1, 3, NULL, 748, 669, '6', 'activo', '2026-06-06 14:27:57', '2026-06-08 20:13:22'),
(1753, 12, 10, 3, 4, NULL, 560, 669, '7', 'activo', '2026-06-06 14:27:57', '2026-06-08 20:13:22'),
(1754, 12, 10, 3, 5, NULL, 155, 671, '9', 'activo', '2026-06-06 14:27:57', '2026-06-08 20:13:22'),
(1755, 12, 10, 4, 6, NULL, 343, 671, '8', 'activo', '2026-06-06 14:27:57', '2026-06-08 20:13:22'),
(1756, 12, 10, 4, 7, NULL, 30, 620, '10', 'activo', '2026-06-06 14:27:57', '2026-06-08 20:13:22'),
(1757, 12, 10, 1, 8, NULL, 28, 456, '11', 'activo', '2026-06-06 14:27:57', '2026-06-08 20:13:22'),
(1758, 12, 10, 3, 9, NULL, 29, 321, '12', 'activo', '2026-06-06 14:27:57', '2026-06-08 20:13:22'),
(1759, 12, 10, 3, 10, NULL, 33, 167, '13', 'activo', '2026-06-06 14:27:57', '2026-06-08 20:13:22'),
(1760, 12, 10, 4, 11, NULL, 30, 97, '14', 'activo', '2026-06-06 14:27:57', '2026-06-08 20:13:22'),
(1761, 12, 10, 3, 12, NULL, 288, 38, '15', 'activo', '2026-06-06 14:27:57', '2026-06-08 20:13:22'),
(1762, 12, 10, 1, 13, NULL, 439, 38, '16', 'activo', '2026-06-06 14:27:57', '2026-06-08 20:13:22'),
(1763, 12, 10, 1, 14, NULL, 695, 34, '18', 'activo', '2026-06-06 14:27:57', '2026-06-08 20:13:22'),
(1764, 12, 10, 1, 15, NULL, 971, 33, '20', 'activo', '2026-06-06 14:27:57', '2026-06-08 20:13:22'),
(1765, 12, 10, 3, 16, NULL, 566, 36, '17', 'activo', '2026-06-06 14:27:57', '2026-06-08 20:13:22'),
(1766, 12, 10, 3, 17, NULL, 816, 36, '19', 'activo', '2026-06-06 14:27:57', '2026-06-08 20:13:22'),
(1767, 12, 10, 1, 18, NULL, 977, 101, '21', 'activo', '2026-06-06 14:27:57', '2026-06-08 20:13:22'),
(1768, 12, 10, 3, 19, NULL, 973, 147, '22', 'activo', '2026-06-06 14:27:57', '2026-06-08 20:13:22'),
(1769, 12, 10, 1, 20, NULL, 972, 195, '23', 'activo', '2026-06-06 14:27:57', '2026-06-08 20:13:22'),
(1771, 12, 10, 3, 21, NULL, 671, 533, 'I1', 'activo', '2026-06-06 14:40:00', '2026-06-08 20:13:22'),
(1772, 12, 10, 3, 22, NULL, 772, 373, 'I3', 'activo', '2026-06-06 14:40:00', '2026-06-08 20:13:22'),
(1773, 12, 10, 3, 23, NULL, 770, 270, 'I4', 'activo', '2026-06-06 14:40:00', '2026-06-08 20:13:22'),
(1774, 12, 10, 3, 24, NULL, 509, 192, 'I6', 'activo', '2026-06-06 14:40:00', '2026-06-08 20:13:22'),
(1775, 12, 10, 3, 25, NULL, 375, 195, 'I7', 'activo', '2026-06-06 14:40:00', '2026-06-08 20:13:22'),
(1776, 12, 10, 3, 26, NULL, 243, 196, 'I8', 'activo', '2026-06-06 14:40:00', '2026-06-08 20:13:22'),
(1777, 12, 10, 3, 27, NULL, 212, 240, 'I9', 'activo', '2026-06-06 14:40:00', '2026-06-08 20:13:22'),
(1778, 12, 10, 3, 28, NULL, 211, 373, 'I11', 'activo', '2026-06-06 14:40:00', '2026-06-08 20:13:22'),
(1779, 12, 10, 3, 29, NULL, 423, 530, 'I13', 'activo', '2026-06-06 14:40:00', '2026-06-08 20:13:22'),
(1780, 12, 10, 3, 30, NULL, 506, 532, 'I14', 'activo', '2026-06-06 14:40:00', '2026-06-08 20:13:22'),
(1781, 12, 10, 4, 31, NULL, 750, 529, 'I2', 'activo', '2026-06-06 14:40:00', '2026-06-08 20:13:22'),
(1782, 12, 10, 4, 32, NULL, 736, 194, 'I5', 'activo', '2026-06-06 14:40:00', '2026-06-08 20:13:22'),
(1783, 12, 10, 4, 33, NULL, 211, 296, 'I10', 'activo', '2026-06-06 14:40:00', '2026-06-08 20:13:22'),
(1784, 12, 10, 4, 34, NULL, 209, 483, 'I12', 'activo', '2026-06-06 14:40:00', '2026-06-08 20:13:22'),
(1785, 12, 10, 5, 35, NULL, 244, 349, 'P1', 'activo', '2026-06-06 14:40:00', '2026-06-08 20:13:22'),
(1786, 12, 10, 5, 36, NULL, 244, 293, 'P2', 'activo', '2026-06-06 14:40:00', '2026-06-08 20:13:22'),
(1787, 12, 10, 5, 37, NULL, 247, 245, 'P3', 'activo', '2026-06-06 14:40:00', '2026-06-08 20:13:22'),
(1788, 12, 10, 5, 38, NULL, 315, 247, 'P4', 'activo', '2026-06-06 14:40:00', '2026-06-08 20:13:22'),
(1789, 12, 10, 5, 39, NULL, 392, 244, 'P5', 'activo', '2026-06-06 14:40:00', '2026-06-08 20:13:22'),
(1790, 12, 10, 5, 40, NULL, 470, 243, 'P6', 'activo', '2026-06-06 14:40:00', '2026-06-08 20:13:22'),
(1791, 12, 10, 5, 41, NULL, 474, 298, 'P7', 'activo', '2026-06-06 14:40:00', '2026-06-08 20:13:22'),
(1792, 12, 10, 5, 42, NULL, 471, 351, 'P8', 'activo', '2026-06-06 14:40:00', '2026-06-08 20:13:22'),
(1793, 12, 10, 5, 43, NULL, 384, 346, 'P9', 'activo', '2026-06-06 14:40:00', '2026-06-08 20:13:22'),
(1794, 12, 10, 5, 44, NULL, 314, 348, 'P10', 'activo', '2026-06-06 14:40:00', '2026-06-08 20:13:22'),
(1795, 12, 10, 5, 45, NULL, 410, 400, 'P11', 'activo', '2026-06-06 14:40:00', '2026-06-08 20:13:22'),
(1796, 12, 10, 5, 46, NULL, 410, 475, 'P12', 'activo', '2026-06-06 14:40:00', '2026-06-08 20:13:22'),
(1797, 12, 10, 5, 47, NULL, 542, 482, 'P13', 'activo', '2026-06-06 14:40:00', '2026-06-08 20:13:22'),
(1798, 12, 10, 5, 48, NULL, 473, 398, 'P14', 'activo', '2026-06-06 14:40:00', '2026-06-08 20:13:22'),
(1799, 12, 10, 5, 49, NULL, 551, 351, 'P15', 'activo', '2026-06-06 14:40:00', '2026-06-08 20:13:22'),
(1800, 12, 10, 5, 50, NULL, 550, 291, 'P16', 'activo', '2026-06-06 14:40:00', '2026-06-08 20:13:22'),
(1801, 12, 10, 5, 51, NULL, 506, 292, 'P17', 'activo', '2026-06-06 14:40:00', '2026-06-08 20:13:22'),
(1802, 12, 10, 5, 52, NULL, 502, 337, 'P18', 'activo', '2026-06-06 14:40:00', '2026-06-08 20:13:22'),
(1803, 12, 10, 5, 53, NULL, 581, 332, 'P19', 'activo', '2026-06-06 14:40:00', '2026-06-08 20:13:22'),
(1804, 12, 10, 5, 54, NULL, 744, 332, 'P20', 'activo', '2026-06-06 14:40:00', '2026-06-08 20:13:22'),
(1805, 12, 10, 5, 55, NULL, 738, 478, 'P21', 'activo', '2026-06-06 14:40:00', '2026-06-08 20:13:22'),
(1806, 12, 10, 5, 56, NULL, 581, 480, 'P22', 'activo', '2026-06-06 14:40:00', '2026-06-08 20:13:22'),
(1807, 12, 10, 3, 57, NULL, 857, 197, '24', 'activo', '2026-06-06 19:59:39', '2026-06-08 20:13:22'),
(1808, 12, 10, 3, 58, NULL, 977, 299, '1', 'activo', '2026-06-06 19:59:39', '2026-06-08 20:13:22'),
(1809, 12, 10, 3, 59, NULL, 976, 408, '2', 'activo', '2026-06-06 19:59:39', '2026-06-08 20:13:22'),
(1810, 12, 10, 3, 60, NULL, 972, 529, '3', 'activo', '2026-06-06 19:59:39', '2026-06-08 20:13:22'),
(1811, 12, 10, 2, 61, NULL, 581, 402, 'insecto1', 'activo', '2026-06-08 20:13:22', '2026-06-08 20:13:22'),
(1812, 12, 10, 2, 62, NULL, 420, 354, 'insecto2', 'activo', '2026-06-08 20:13:22', '2026-06-08 20:13:22'),
(1813, 13, 11, 3, 1, NULL, 42, 572, '1', 'activo', '2026-06-09 15:25:54', '2026-06-11 14:32:39'),
(1814, 13, 11, 3, 2, NULL, 54, 666, '2', 'activo', '2026-06-09 15:25:54', '2026-06-11 14:32:39'),
(1815, 13, 11, 3, 3, NULL, 337, 667, '3', 'activo', '2026-06-09 15:25:54', '2026-06-11 14:32:39'),
(1816, 13, 11, 3, 4, NULL, 607, 663, '4', 'activo', '2026-06-09 15:25:54', '2026-06-11 14:32:39'),
(1817, 13, 11, 3, 5, NULL, 838, 667, '5', 'activo', '2026-06-09 15:25:54', '2026-06-11 14:32:39'),
(1818, 13, 11, 3, 6, NULL, 959, 572, '6', 'activo', '2026-06-09 15:25:54', '2026-06-11 14:32:39'),
(1819, 13, 11, 3, 7, NULL, 962, 388, '7', 'activo', '2026-06-09 15:25:54', '2026-06-11 14:32:39'),
(1820, 13, 11, 3, 8, NULL, 955, 226, '8', 'activo', '2026-06-09 15:25:54', '2026-06-11 14:32:39'),
(1821, 13, 11, 3, 9, NULL, 889, 155, '9', 'activo', '2026-06-09 15:25:54', '2026-06-11 14:32:39'),
(1822, 13, 11, 3, 10, NULL, 783, 363, '10', 'activo', '2026-06-09 15:25:54', '2026-06-11 14:32:39'),
(1823, 13, 11, 3, 11, NULL, 784, 540, '11', 'activo', '2026-06-09 15:25:54', '2026-06-11 14:32:39'),
(1824, 13, 11, 3, 12, NULL, 713, 575, '12', 'activo', '2026-06-09 15:25:54', '2026-06-11 14:32:39'),
(1825, 13, 11, 3, 13, NULL, 563, 579, '13', 'activo', '2026-06-09 15:25:54', '2026-06-11 14:32:39'),
(1826, 13, 11, 3, 14, NULL, 545, 453, '14', 'activo', '2026-06-09 15:25:54', '2026-06-11 14:32:39'),
(1827, 13, 11, 3, 15, NULL, 545, 336, '15', 'activo', '2026-06-09 15:25:54', '2026-06-11 14:32:39'),
(1828, 13, 11, 3, 16, NULL, 467, 334, '16', 'activo', '2026-06-09 15:25:54', '2026-06-11 14:32:39'),
(1829, 13, 11, 3, 17, NULL, 465, 431, '17', 'activo', '2026-06-09 15:25:54', '2026-06-11 14:32:39'),
(1830, 13, 11, 3, 18, NULL, 468, 518, '18', 'activo', '2026-06-09 15:25:54', '2026-06-11 14:32:39'),
(1831, 13, 11, 3, 19, NULL, 320, 515, '19', 'activo', '2026-06-09 15:25:54', '2026-06-11 14:32:39'),
(1832, 13, 11, 3, 20, NULL, 318, 102, '20', 'activo', '2026-06-09 15:25:54', '2026-06-11 14:32:39'),
(1833, 13, 11, 4, 21, NULL, 68, 273, 'V1', 'activo', '2026-06-09 15:25:54', '2026-06-11 14:32:39'),
(1834, 13, 11, 4, 22, NULL, 205, 543, 'V2', 'activo', '2026-06-09 15:25:54', '2026-06-11 14:32:39'),
(1835, 13, 11, 4, 23, NULL, 360, 420, 'V3', 'activo', '2026-06-09 15:25:54', '2026-06-11 14:32:39'),
(1836, 13, 11, 4, 24, NULL, 407, 312, 'V4', 'activo', '2026-06-09 15:25:54', '2026-06-11 14:32:39'),
(1837, 13, 11, 4, 25, NULL, 426, 547, 'V5', 'activo', '2026-06-09 15:25:54', '2026-06-11 14:32:39'),
(1838, 13, 11, 4, 26, NULL, 600, 537, 'V6', 'activo', '2026-06-09 15:25:54', '2026-06-11 14:32:39'),
(1839, 13, 11, 4, 27, NULL, 580, 419, 'V7', 'activo', '2026-06-09 15:25:54', '2026-06-11 14:32:39'),
(1840, 13, 11, 4, 28, NULL, 579, 308, 'V8', 'activo', '2026-06-09 15:25:54', '2026-06-11 14:32:39'),
(1841, 13, 11, 4, 29, NULL, 640, 312, 'V9', 'activo', '2026-06-09 15:25:54', '2026-06-11 14:32:39'),
(1842, 13, 11, 4, 30, NULL, 648, 380, 'V10', 'activo', '2026-06-09 15:25:54', '2026-06-11 14:32:39'),
(1843, 13, 11, 4, 31, NULL, 648, 446, 'V11', 'activo', '2026-06-09 15:25:54', '2026-06-11 14:32:39'),
(1844, 13, 11, 4, 32, NULL, 645, 525, 'V12', 'activo', '2026-06-09 15:25:54', '2026-06-11 14:32:39'),
(1845, 13, 11, 4, 33, NULL, 685, 549, 'V13', 'activo', '2026-06-09 15:25:54', '2026-06-11 14:32:39'),
(1846, 13, 11, 4, 34, NULL, 683, 470, 'V14', 'activo', '2026-06-09 15:25:54', '2026-06-11 14:32:39'),
(1847, 13, 11, 4, 35, NULL, 686, 405, 'V15', 'activo', '2026-06-09 15:25:54', '2026-06-11 14:32:39'),
(1848, 13, 11, 4, 36, NULL, 683, 310, 'V16', 'activo', '2026-06-09 15:25:54', '2026-06-11 14:32:39'),
(1849, 13, 11, 4, 37, NULL, 732, 309, 'V17', 'activo', '2026-06-09 15:25:54', '2026-06-11 14:32:39'),
(1850, 13, 11, 4, 38, NULL, 746, 351, 'V18', 'activo', '2026-06-09 15:25:54', '2026-06-11 14:32:39'),
(1851, 13, 11, 4, 39, NULL, 756, 431, 'V19', 'activo', '2026-06-09 15:25:54', '2026-06-11 14:32:39'),
(1852, 13, 11, 4, 40, NULL, 752, 503, 'V20', 'activo', '2026-06-09 15:25:54', '2026-06-11 14:32:39'),
(1853, 14, 12, 3, 1, NULL, 132, 64, '1', 'activo', '2026-06-10 12:54:26', '2026-06-10 17:47:43'),
(1854, 14, 12, 3, 2, NULL, 33, 159, '2', 'activo', '2026-06-10 12:54:26', '2026-06-10 17:47:43'),
(1855, 14, 12, 3, 3, NULL, 136, 289, '3', 'activo', '2026-06-10 12:54:26', '2026-06-10 17:47:43'),
(1856, 14, 12, 3, 4, NULL, 137, 454, '4', 'activo', '2026-06-10 12:54:26', '2026-06-10 17:47:43'),
(1857, 14, 12, 3, 5, NULL, 902, 515, '5', 'activo', '2026-06-10 12:54:26', '2026-06-10 17:47:43'),
(1858, 14, 12, 3, 6, NULL, 838, 579, '6', 'activo', '2026-06-10 12:54:26', '2026-06-10 17:47:43'),
(1859, 14, 12, 3, 7, NULL, 756, 443, '7', 'activo', '2026-06-10 12:54:26', '2026-06-10 17:47:43'),
(1860, 14, 12, 3, 8, NULL, 774, 631, '8', 'activo', '2026-06-10 12:54:26', '2026-06-10 17:47:43'),
(1861, 14, 12, 3, 9, NULL, 518, 633, '9', 'activo', '2026-06-10 12:54:26', '2026-06-10 17:47:43'),
(1862, 14, 12, 3, 10, NULL, 298, 632, '10', 'activo', '2026-06-10 12:54:26', '2026-06-10 17:47:43'),
(1863, 14, 12, 3, 11, NULL, 167, 531, '11', 'activo', '2026-06-10 12:54:26', '2026-06-10 17:47:43'),
(1864, 14, 12, 2, 12, NULL, 188, 326, 'insect 1', 'activo', '2026-06-10 12:54:26', '2026-06-10 17:47:43'),
(1865, 14, 12, 2, 13, NULL, 902, 120, 'insect 2', 'activo', '2026-06-10 12:54:26', '2026-06-10 17:47:43'),
(1866, 14, 12, 2, 14, NULL, 772, 138, 'insect 3', 'activo', '2026-06-10 12:54:26', '2026-06-10 17:47:43'),
(1867, 14, 12, 2, 15, NULL, 470, 103, 'insect 4', 'activo', '2026-06-10 12:54:26', '2026-06-10 17:47:43'),
(1868, 13, 11, 2, 41, NULL, 240, 233, 'insecto 1', 'activo', '2026-06-10 18:57:42', '2026-06-11 14:32:39'),
(1869, 13, 11, 2, 42, NULL, 367, 544, 'insecto 2', 'activo', '2026-06-10 18:57:42', '2026-06-11 14:32:39'),
(1870, 13, 11, 2, 43, NULL, 643, 576, 'insecto 3', 'activo', '2026-06-10 18:57:42', '2026-06-11 14:32:39'),
(1871, 13, 11, 2, 44, NULL, 370, 146, 'insecto 4', 'activo', '2026-06-10 18:57:42', '2026-06-11 14:32:39'),
(1872, 1, 2, 4, 1, NULL, 476, 168, '8', 'activo', '2026-06-18 13:15:17', '2026-06-18 13:24:34'),
(1873, 1, 2, 4, 2, NULL, 628, 80, '9', 'activo', '2026-06-18 13:15:17', '2026-06-18 13:24:34'),
(1874, 1, 2, 4, 3, NULL, 357, 63, '10', 'activo', '2026-06-18 13:15:17', '2026-06-18 13:24:34'),
(1875, 1, 2, 4, 4, NULL, 150, 59, '11', 'activo', '2026-06-18 13:15:17', '2026-06-18 13:24:34'),
(1876, 1, 2, 5, 5, NULL, 404, 636, '1', 'activo', '2026-06-18 13:15:17', '2026-06-18 13:24:34'),
(1877, 1, 2, 5, 6, NULL, 500, 634, '2', 'activo', '2026-06-18 13:15:17', '2026-06-18 13:24:34'),
(1878, 1, 2, 5, 7, NULL, 680, 636, '3', 'activo', '2026-06-18 13:15:17', '2026-06-18 13:24:34'),
(1879, 1, 2, 5, 8, NULL, 763, 635, '4', 'activo', '2026-06-18 13:15:17', '2026-06-18 13:24:34'),
(1880, 1, 2, 5, 9, NULL, 825, 636, '5', 'activo', '2026-06-18 13:15:17', '2026-06-18 13:24:34'),
(1881, 1, 2, 5, 10, NULL, 700, 232, '6', 'activo', '2026-06-18 13:15:17', '2026-06-18 13:24:34'),
(1882, 1, 2, 5, 11, NULL, 402, 232, '7', 'activo', '2026-06-18 13:15:17', '2026-06-18 13:24:34'),
(1883, 1, 2, 5, 12, NULL, 594, 625, '12', 'activo', '2026-06-18 13:15:17', '2026-06-18 13:24:34'),
(1884, 1, 2, 5, 13, NULL, 729, 580, '13', 'activo', '2026-06-18 13:15:17', '2026-06-18 13:24:34'),
(1885, 1, 1, 4, 40, NULL, 714, 321, '1', 'activo', '2026-06-18 13:24:04', '2026-06-18 13:24:30'),
(1886, 1, 1, 4, 41, NULL, 641, 325, '2', 'activo', '2026-06-18 13:24:04', '2026-06-18 13:24:30'),
(1887, 1, 1, 4, 42, NULL, 383, 319, '3', 'activo', '2026-06-18 13:24:04', '2026-06-18 13:24:30'),
(1888, 1, 1, 5, 43, NULL, 357, 330, '18', 'activo', '2026-06-18 13:24:04', '2026-06-18 13:24:30'),
(1889, 1, 1, 5, 44, NULL, 284, 476, '17', 'activo', '2026-06-18 13:24:04', '2026-06-18 13:24:30'),
(1890, 1, 1, 5, 45, NULL, 285, 639, '16', 'activo', '2026-06-18 13:24:04', '2026-06-18 13:24:30'),
(1891, 1, 1, 5, 46, NULL, 351, 626, '19', 'activo', '2026-06-18 13:24:04', '2026-06-18 13:24:30'),
(1892, 1, 1, 5, 47, NULL, 325, 666, '20', 'activo', '2026-06-18 13:24:04', '2026-06-18 13:24:30'),
(1893, 1, 1, 5, 48, NULL, 660, 674, '21', 'activo', '2026-06-18 13:24:04', '2026-06-18 13:24:30'),
(1894, 1, 1, 5, 49, NULL, 377, 507, '15', 'activo', '2026-06-18 13:24:04', '2026-06-18 13:24:30'),
(1895, 1, 1, 5, 50, NULL, 406, 481, '13', 'activo', '2026-06-18 13:24:04', '2026-06-18 13:24:30'),
(1896, 1, 1, 5, 51, NULL, 380, 469, '14', 'activo', '2026-06-18 13:24:04', '2026-06-18 13:24:30'),
(1897, 1, 1, 5, 52, NULL, 722, 597, '22', 'activo', '2026-06-18 13:24:04', '2026-06-18 13:24:30'),
(1898, 1, 1, 5, 53, NULL, 665, 468, '8', 'activo', '2026-06-18 13:24:04', '2026-06-18 13:24:30'),
(1899, 1, 1, 5, 54, NULL, 628, 480, '24', 'activo', '2026-06-18 13:24:04', '2026-06-18 13:24:30'),
(1900, 1, 1, 5, 55, NULL, 576, 503, '11', 'activo', '2026-06-18 13:24:04', '2026-06-18 13:24:30'),
(1901, 1, 1, 5, 56, NULL, 536, 508, '9', 'activo', '2026-06-18 13:24:04', '2026-06-18 13:24:30'),
(1902, 1, 1, 5, 57, NULL, 552, 456, '10', 'activo', '2026-06-18 13:24:04', '2026-06-18 13:24:30'),
(1903, 1, 1, 5, 58, NULL, 627, 434, '12', 'activo', '2026-06-18 13:24:04', '2026-06-18 13:24:30');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `trampa_especie_seguimientos`
--

CREATE TABLE `trampa_especie_seguimientos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `seguimiento_id` bigint(20) UNSIGNED NOT NULL,
  `trampa_id` bigint(20) UNSIGNED NOT NULL,
  `especie_id` bigint(20) UNSIGNED NOT NULL,
  `cantidad` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `trampa_especie_seguimientos`
--

INSERT INTO `trampa_especie_seguimientos` (`id`, `seguimiento_id`, `trampa_id`, `especie_id`, `cantidad`, `created_at`, `updated_at`) VALUES
(1, 2, 1523, 1, 5, '2026-05-03 14:09:03', '2026-05-03 14:09:03'),
(2, 2, 1524, 3, 10, '2026-05-03 14:09:03', '2026-05-03 14:09:03'),
(3, 2, 1525, 2, 0, '2026-05-03 14:09:03', '2026-05-03 14:09:03'),
(31, 4, 1523, 1, 5, '2026-05-05 23:26:19', '2026-05-05 23:26:19'),
(32, 4, 1524, 3, 10, '2026-05-05 23:26:19', '2026-05-05 23:26:19'),
(33, 4, 1525, 2, 0, '2026-05-05 23:26:19', '2026-05-05 23:26:19'),
(37, 6, 1523, 1, 3, '2026-05-05 23:32:10', '2026-05-05 23:32:10'),
(38, 6, 1524, 3, 8, '2026-05-05 23:32:10', '2026-05-05 23:32:10'),
(39, 6, 1525, 2, 5, '2026-05-05 23:32:10', '2026-05-05 23:32:10'),
(40, 8, 1523, 1, 4, '2026-05-05 23:43:34', '2026-05-05 23:43:34'),
(41, 8, 1524, 3, 9, '2026-05-05 23:43:34', '2026-05-05 23:43:34'),
(42, 8, 1525, 2, 3, '2026-05-05 23:43:34', '2026-05-05 23:43:34'),
(43, 10, 1523, 1, 4, '2026-05-05 23:44:37', '2026-05-05 23:44:37'),
(44, 10, 1524, 3, 12, '2026-05-05 23:44:37', '2026-05-05 23:44:37'),
(45, 10, 1525, 2, 0, '2026-05-05 23:44:37', '2026-05-05 23:44:37'),
(46, 12, 1523, 1, 6, '2026-05-05 23:45:38', '2026-05-05 23:45:38'),
(47, 12, 1524, 3, 10, '2026-05-05 23:45:38', '2026-05-05 23:45:38'),
(48, 12, 1525, 2, 8, '2026-05-05 23:45:38', '2026-05-05 23:45:38'),
(49, 14, 1523, 1, 4, '2026-05-05 23:47:23', '2026-05-05 23:47:23'),
(50, 14, 1524, 3, 8, '2026-05-05 23:47:23', '2026-05-05 23:47:23'),
(51, 14, 1525, 2, 7, '2026-05-05 23:47:23', '2026-05-05 23:47:23'),
(52, 16, 1523, 1, 4, '2026-05-05 23:48:28', '2026-05-05 23:48:28'),
(53, 16, 1524, 3, 8, '2026-05-05 23:48:28', '2026-05-05 23:48:28'),
(54, 16, 1525, 2, 7, '2026-05-05 23:48:28', '2026-05-05 23:48:28'),
(59, 18, 1523, 3, 2, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(60, 18, 1524, 1, 1, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(61, 18, 1525, 2, 1, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(74, 46, 1464, 1, 4, '2026-05-19 20:08:03', '2026-05-19 20:08:03'),
(75, 46, 1464, 3, 7, '2026-05-19 20:08:03', '2026-05-19 20:08:03'),
(76, 46, 1464, 2, 6, '2026-05-19 20:08:03', '2026-05-19 20:08:03'),
(77, 47, 1464, 1, 4, '2026-05-19 20:10:27', '2026-05-19 20:10:27'),
(78, 47, 1464, 3, 6, '2026-05-19 20:10:27', '2026-05-19 20:10:27'),
(79, 47, 1464, 2, 5, '2026-05-19 20:10:27', '2026-05-19 20:10:27'),
(80, 45, 1464, 1, 3, '2026-05-19 20:11:43', '2026-05-19 20:11:43'),
(81, 45, 1464, 3, 6, '2026-05-19 20:11:43', '2026-05-19 20:11:43'),
(82, 45, 1464, 2, 10, '2026-05-19 20:11:43', '2026-05-19 20:11:43'),
(83, 48, 1464, 1, 3, '2026-05-19 20:21:06', '2026-05-19 20:21:06'),
(84, 48, 1464, 3, 7, '2026-05-19 20:21:06', '2026-05-19 20:21:06'),
(85, 48, 1464, 2, 5, '2026-05-19 20:21:06', '2026-05-19 20:21:06'),
(86, 49, 1464, 1, 2, '2026-05-19 20:23:15', '2026-05-19 20:23:15'),
(87, 49, 1464, 3, 7, '2026-05-19 20:23:15', '2026-05-19 20:23:15'),
(88, 49, 1464, 2, 5, '2026-05-19 20:23:15', '2026-05-19 20:23:15'),
(92, 51, 1464, 1, 6, '2026-05-19 20:33:30', '2026-05-19 20:33:30'),
(93, 51, 1464, 3, 13, '2026-05-19 20:33:30', '2026-05-19 20:33:30'),
(94, 51, 1464, 2, 10, '2026-05-19 20:33:30', '2026-05-19 20:33:30'),
(95, 50, 1464, 1, 4, '2026-05-19 20:48:38', '2026-05-19 20:48:38'),
(96, 50, 1464, 3, 15, '2026-05-19 20:48:38', '2026-05-19 20:48:38'),
(97, 50, 1464, 2, 14, '2026-05-19 20:48:38', '2026-05-19 20:48:38'),
(103, 53, 1523, 1, 2, '2026-05-22 02:03:18', '2026-05-22 02:03:18'),
(104, 53, 1523, 2, 4, '2026-05-22 02:03:18', '2026-05-22 02:03:18'),
(105, 53, 1524, 1, 1, '2026-05-22 02:03:18', '2026-05-22 02:03:18'),
(106, 53, 1525, 1, 3, '2026-05-22 02:03:18', '2026-05-22 02:03:18'),
(116, 56, 1711, 1, 7, '2026-05-25 22:05:53', '2026-05-25 22:05:53'),
(117, 56, 1711, 3, 11, '2026-05-25 22:05:53', '2026-05-25 22:05:53'),
(118, 56, 1711, 2, 4, '2026-05-25 22:05:53', '2026-05-25 22:05:53'),
(119, 19, 1711, 2, 1, '2026-05-25 22:08:42', '2026-05-25 22:08:42'),
(120, 19, 1711, 1, 1, '2026-05-25 22:08:42', '2026-05-25 22:08:42'),
(121, 19, 1711, 3, 2, '2026-05-25 22:08:42', '2026-05-25 22:08:42'),
(129, 64, 1523, 3, 6, '2026-06-11 23:17:30', '2026-06-11 23:17:30'),
(130, 64, 1524, 3, 2, '2026-06-11 23:17:30', '2026-06-11 23:17:30'),
(131, 64, 1525, 3, 30, '2026-06-11 23:17:30', '2026-06-11 23:17:30'),
(132, 67, 1711, 1, 5, '2026-06-12 21:55:02', '2026-06-12 21:55:02'),
(133, 67, 1711, 2, 6, '2026-06-12 21:55:02', '2026-06-12 21:55:02'),
(134, 67, 1711, 3, 10, '2026-06-12 21:55:02', '2026-06-12 21:55:02'),
(135, 62, 1745, 1, 1, '2026-06-19 19:04:02', '2026-06-19 19:04:02');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `trampa_roedor_seguimientos`
--

CREATE TABLE `trampa_roedor_seguimientos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `seguimiento_id` bigint(20) UNSIGNED NOT NULL,
  `trampa_id` bigint(20) UNSIGNED NOT NULL,
  `observacion` varchar(255) DEFAULT NULL,
  `cantidad` int(11) NOT NULL,
  `inicial` double NOT NULL,
  `merma` double NOT NULL,
  `actual` double NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `trampa_roedor_seguimientos`
--

INSERT INTO `trampa_roedor_seguimientos` (`id`, `seguimiento_id`, `trampa_id`, `observacion`, `cantidad`, `inicial`, `merma`, `actual`, `created_at`, `updated_at`) VALUES
(1015, 1, 848, 'G1', 0, 20, 0, 20, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1016, 1, 849, 'G2', 0, 20, 1, 19, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1017, 1, 850, 'G3', 0, 20, 0, 20, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1018, 1, 851, 'G4', 0, 20, 0, 20, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1019, 1, 852, 'G5', 0, 20, 0, 20, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1020, 1, 853, 'G6', 0, 20, 2, 18, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1021, 1, 854, 'G7', 0, 20, 0, 20, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1022, 1, 855, 'G8', 0, 20, 1, 19, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1023, 1, 856, 'G9', 0, 20, 0, 20, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1024, 1, 857, 'G10', 0, 20, 0, 20, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1025, 1, 858, 'G11', 0, 20, 0, 20, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1026, 1, 859, 'G12', 0, 20, 0, 20, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1027, 1, 860, 'G13', 0, 20, 1, 19, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1028, 1, 1465, 'E1', 0, 20, 0, 20, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1029, 1, 1466, 'E2', 0, 20, 0, 20, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1030, 1, 1467, 'E3', 0, 20, 2, 18, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1031, 1, 1468, 'E4', 0, 20, 1, 19, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1032, 1, 1469, 'E5', 0, 20, 0, 20, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1033, 1, 1470, 'E6', 0, 20, 1, 19, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1034, 1, 1471, 'E7', 0, 20, 0, 20, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1035, 1, 1472, 'E8', 0, 20, 0, 20, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1036, 1, 1473, 'E9', 0, 20, 1, 19, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1037, 1, 1474, 'E10', 0, 20, 0, 20, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1038, 1, 1475, 'P1', 0, 20, 0, 20, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1039, 1, 1476, 'P2', 0, 20, 0, 20, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1040, 1, 1477, 'P3', 0, 20, 0, 20, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1041, 1, 1478, 'P4', 0, 0, 0, 0, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1042, 1, 1479, 'P5', 0, 0, 0, 0, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1043, 1, 1480, 'P6', 0, 0, 0, 0, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1044, 1, 1481, 'P7', 0, 0, 0, 0, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1045, 1, 1482, 'P8', 0, 20, 1, 19, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1046, 1, 1483, 'P9', 0, 20, 0, 20, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1047, 1, 1484, 'P10', 0, 20, 2, 18, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1048, 1, 1485, 'P11', 0, 20, 1, 19, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1049, 1, 1486, 'P12', 0, 20, 0, 20, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1050, 1, 1487, 'P13', 0, 20, 1, 19, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1051, 1, 1488, 'P14', 0, 20, 2, 18, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1052, 1, 1489, 'P15', 0, 20, 0, 20, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1053, 1, 1490, 'P16', 0, 20, 0, 20, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1054, 1, 1491, 'P17', 0, 20, 0, 20, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1055, 1, 1492, 'P18', 0, 20, 1, 19, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1056, 1, 1493, 'P19', 0, 20, 0, 20, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1057, 1, 1494, 'P20', 0, 20, 2, 18, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1058, 1, 1495, 'P21', 0, 20, 0, 20, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1059, 1, 1496, 'P22', 0, 20, 1, 19, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1060, 1, 1497, 'P24', 0, 20, 2, 18, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1061, 1, 1498, 'P23', 0, 0, 0, 0, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1062, 1, 1499, 'P28', 0, 0, 0, 0, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1063, 1, 1500, 'P29', 0, 0, 0, 0, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1064, 1, 1501, 'P30', 0, 0, 0, 0, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1065, 1, 1502, 'P31', 0, 0, 0, 0, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1066, 1, 1503, 'P32', 0, 0, 0, 0, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1067, 1, 1504, 'P33', 0, 0, 0, 0, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1068, 1, 1505, 'P34', 0, 0, 0, 0, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1069, 1, 1506, 'P35', 0, 0, 0, 0, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1070, 1, 1507, 'P36', 0, 0, 0, 0, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1071, 1, 1508, 'P37', 0, 0, 0, 0, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1072, 1, 1509, 'P38', 0, 0, 0, 0, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1073, 1, 1510, 'P39', 0, 0, 0, 0, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1074, 1, 1511, 'P40', 0, 0, 0, 0, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1075, 1, 1512, 'P41', 0, 0, 0, 0, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1076, 1, 1513, 'P46', 0, 0, 0, 0, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1077, 1, 1514, 'P47', 0, 0, 0, 0, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1078, 1, 1515, 'P48', 0, 0, 0, 0, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1079, 1, 1516, 'P49', 0, 0, 0, 0, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1080, 1, 1517, 'P50', 0, 0, 0, 0, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1081, 1, 1518, 'P51', 0, 0, 0, 0, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1082, 1, 1519, 'P52', 0, 0, 0, 0, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1083, 1, 1520, 'P53', 0, 0, 0, 0, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1084, 1, 1521, 'P54', 0, 0, 0, 0, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1085, 1, 1522, 'P55', 0, 0, 0, 0, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1086, 1, 1526, 'P25', 0, 20, 1, 19, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1087, 1, 1527, 'P26', 0, 20, 0, 20, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1088, 1, 1528, 'P27', 0, 20, 0, 20, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1089, 1, 1529, 'P42', 0, 20, 1, 19, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1090, 1, 1530, 'P43', 0, 20, 2, 18, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1091, 1, 1531, 'P44', 0, 20, 1, 19, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1092, 1, 1532, 'P45', 0, 20, 0, 20, '2026-05-04 23:08:04', '2026-05-04 23:08:04'),
(1249, 3, 848, NULL, 0, 20, 0, 20, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1250, 3, 849, NULL, 0, 20, 1, 19, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1251, 3, 850, NULL, 0, 20, 0, 20, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1252, 3, 851, NULL, 0, 20, 0, 20, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1253, 3, 852, NULL, 0, 20, 0, 20, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1254, 3, 853, NULL, 0, 20, 2, 18, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1255, 3, 854, NULL, 0, 20, 0, 20, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1256, 3, 855, NULL, 0, 20, 1, 19, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1257, 3, 856, NULL, 0, 20, 0, 20, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1258, 3, 857, NULL, 0, 20, 0, 20, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1259, 3, 858, NULL, 0, 20, 0, 20, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1260, 3, 859, NULL, 0, 20, 0, 20, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1261, 3, 860, NULL, 0, 20, 3, 17, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1262, 3, 1465, NULL, 0, 20, 0, 20, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1263, 3, 1466, NULL, 0, 20, 0, 20, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1264, 3, 1467, NULL, 0, 20, 2, 18, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1265, 3, 1468, NULL, 0, 20, 1, 19, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1266, 3, 1469, NULL, 0, 20, 0, 20, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1267, 3, 1470, NULL, 0, 20, 1, 19, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1268, 3, 1471, NULL, 0, 20, 0, 20, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1269, 3, 1472, NULL, 0, 20, 0, 20, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1270, 3, 1473, NULL, 0, 20, 1, 19, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1271, 3, 1474, NULL, 0, 20, 1, 19, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1272, 3, 1475, NULL, 0, 20, 0, 20, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1273, 3, 1476, NULL, 0, 20, 0, 20, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1274, 3, 1477, NULL, 0, 20, 0, 20, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1275, 3, 1478, NULL, 0, 0, 0, 0, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1276, 3, 1479, NULL, 0, 0, 0, 0, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1277, 3, 1480, NULL, 0, 0, 0, 0, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1278, 3, 1481, NULL, 0, 0, 0, 0, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1279, 3, 1482, NULL, 0, 20, 1, 19, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1280, 3, 1483, NULL, 0, 20, 0, 20, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1281, 3, 1484, NULL, 0, 20, 2, 18, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1282, 3, 1485, NULL, 0, 20, 1, 19, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1283, 3, 1486, NULL, 0, 20, 0, 20, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1284, 3, 1487, NULL, 0, 20, 1, 19, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1285, 3, 1488, NULL, 0, 20, 2, 18, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1286, 3, 1489, NULL, 0, 20, 0, 20, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1287, 3, 1490, NULL, 0, 20, 0, 20, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1288, 3, 1491, NULL, 0, 20, 0, 20, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1289, 3, 1492, NULL, 0, 20, 1, 19, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1290, 3, 1493, NULL, 0, 20, 0, 20, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1291, 3, 1494, NULL, 0, 20, 2, 18, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1292, 3, 1495, NULL, 0, 20, 0, 20, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1293, 3, 1496, NULL, 0, 20, 1, 19, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1294, 3, 1497, NULL, 0, 20, 2, 18, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1295, 3, 1498, NULL, 0, 0, 0, 0, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1296, 3, 1499, NULL, 0, 0, 0, 0, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1297, 3, 1500, NULL, 0, 0, 0, 0, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1298, 3, 1501, NULL, 0, 0, 0, 0, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1299, 3, 1502, NULL, 0, 0, 0, 0, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1300, 3, 1503, NULL, 0, 0, 0, 0, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1301, 3, 1504, NULL, 0, 0, 0, 0, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1302, 3, 1505, NULL, 0, 0, 0, 0, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1303, 3, 1506, NULL, 0, 0, 0, 0, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1304, 3, 1507, NULL, 0, 0, 0, 0, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1305, 3, 1508, NULL, 0, 0, 0, 0, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1306, 3, 1509, NULL, 0, 0, 0, 0, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1307, 3, 1510, NULL, 0, 0, 0, 0, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1308, 3, 1511, NULL, 0, 0, 0, 0, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1309, 3, 1512, NULL, 0, 0, 0, 0, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1310, 3, 1513, NULL, 0, 0, 0, 0, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1311, 3, 1514, NULL, 0, 0, 0, 0, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1312, 3, 1515, NULL, 0, 0, 0, 0, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1313, 3, 1516, NULL, 0, 0, 0, 0, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1314, 3, 1517, NULL, 0, 0, 0, 0, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1315, 3, 1518, NULL, 0, 0, 0, 0, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1316, 3, 1519, NULL, 0, 0, 0, 0, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1317, 3, 1520, NULL, 0, 0, 0, 0, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1318, 3, 1521, NULL, 0, 0, 0, 0, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1319, 3, 1522, NULL, 0, 0, 0, 0, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1320, 3, 1526, NULL, 0, 20, 1, 19, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1321, 3, 1527, NULL, 0, 20, 0, 20, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1322, 3, 1528, NULL, 0, 20, 0, 20, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1323, 3, 1529, NULL, 0, 20, 1, 19, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1324, 3, 1530, NULL, 0, 20, 2, 18, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1325, 3, 1531, NULL, 0, 20, 1, 19, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1326, 3, 1532, NULL, 0, 20, 0, 20, '2026-05-05 23:25:55', '2026-05-05 23:25:55'),
(1327, 5, 848, NULL, 0, 20, 1, 19, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1328, 5, 849, NULL, 0, 20, 1, 19, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1329, 5, 850, NULL, 0, 20, 0, 20, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1330, 5, 851, NULL, 0, 20, 4, 16, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1331, 5, 852, NULL, 0, 20, 0, 20, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1332, 5, 853, NULL, 0, 20, 1, 19, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1333, 5, 854, NULL, 0, 20, 0, 20, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1334, 5, 855, NULL, 0, 20, 1, 19, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1335, 5, 856, NULL, 0, 20, 0, 20, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1336, 5, 857, NULL, 0, 20, 2, 18, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1337, 5, 858, NULL, 0, 20, 0, 20, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1338, 5, 859, NULL, 0, 20, 2, 18, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1339, 5, 860, NULL, 0, 20, 1, 19, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1340, 5, 1465, NULL, 0, 20, 0, 20, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1341, 5, 1466, NULL, 0, 20, 1, 19, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1342, 5, 1467, NULL, 0, 20, 2, 18, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1343, 5, 1468, NULL, 0, 20, 1, 19, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1344, 5, 1469, NULL, 0, 20, 0, 20, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1345, 5, 1470, NULL, 0, 20, 0, 20, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1346, 5, 1471, NULL, 0, 20, 0, 20, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1347, 5, 1472, NULL, 0, 20, 0, 20, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1348, 5, 1473, NULL, 0, 20, 1, 19, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1349, 5, 1474, NULL, 0, 20, 2, 18, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1350, 5, 1475, NULL, 0, 20, 0, 20, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1351, 5, 1476, NULL, 0, 20, 0, 20, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1352, 5, 1477, NULL, 0, 20, 0, 20, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1353, 5, 1478, NULL, 0, 0, 0, 0, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1354, 5, 1479, NULL, 0, 0, 0, 0, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1355, 5, 1480, NULL, 0, 0, 0, 0, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1356, 5, 1481, NULL, 0, 0, 0, 0, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1357, 5, 1482, NULL, 0, 20, 0, 20, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1358, 5, 1483, NULL, 0, 20, 0, 20, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1359, 5, 1484, NULL, 0, 20, 1, 19, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1360, 5, 1485, NULL, 0, 20, 0, 20, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1361, 5, 1486, NULL, 0, 20, 0, 20, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1362, 5, 1487, NULL, 0, 20, 1, 19, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1363, 5, 1488, NULL, 0, 20, 1, 19, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1364, 5, 1489, NULL, 0, 20, 0, 20, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1365, 5, 1490, NULL, 0, 20, 0, 20, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1366, 5, 1491, NULL, 0, 20, 0, 20, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1367, 5, 1492, NULL, 0, 20, 1, 19, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1368, 5, 1493, NULL, 0, 20, 1, 19, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1369, 5, 1494, NULL, 0, 20, 2, 18, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1370, 5, 1495, NULL, 0, 20, 2, 18, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1371, 5, 1496, NULL, 0, 20, 0, 20, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1372, 5, 1497, NULL, 0, 20, 2, 18, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1373, 5, 1498, NULL, 0, 0, 0, 0, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1374, 5, 1499, NULL, 0, 0, 0, 0, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1375, 5, 1500, NULL, 0, 0, 0, 0, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1376, 5, 1501, NULL, 0, 0, 0, 0, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1377, 5, 1502, NULL, 0, 0, 0, 0, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1378, 5, 1503, NULL, 0, 0, 0, 0, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1379, 5, 1504, NULL, 0, 0, 0, 0, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1380, 5, 1505, NULL, 0, 0, 0, 0, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1381, 5, 1506, NULL, 0, 0, 0, 0, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1382, 5, 1507, NULL, 0, 0, 0, 0, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1383, 5, 1508, NULL, 0, 0, 0, 0, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1384, 5, 1509, NULL, 0, 0, 0, 0, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1385, 5, 1510, NULL, 0, 0, 0, 0, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1386, 5, 1511, NULL, 0, 0, 0, 0, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1387, 5, 1512, NULL, 0, 0, 0, 0, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1388, 5, 1513, NULL, 0, 0, 0, 0, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1389, 5, 1514, NULL, 0, 0, 0, 0, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1390, 5, 1515, NULL, 0, 0, 0, 0, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1391, 5, 1516, NULL, 0, 0, 0, 0, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1392, 5, 1517, NULL, 0, 0, 0, 0, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1393, 5, 1518, NULL, 0, 0, 0, 0, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1394, 5, 1519, NULL, 0, 0, 0, 0, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1395, 5, 1520, NULL, 0, 0, 0, 0, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1396, 5, 1521, NULL, 0, 0, 0, 0, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1397, 5, 1522, NULL, 0, 0, 0, 0, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1398, 5, 1526, NULL, 0, 20, 1, 19, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1399, 5, 1527, NULL, 0, 20, 2, 18, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1400, 5, 1528, NULL, 0, 20, 0, 20, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1401, 5, 1529, NULL, 0, 20, 3, 17, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1402, 5, 1530, NULL, 0, 20, 2, 18, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1403, 5, 1531, NULL, 0, 20, 3, 17, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1404, 5, 1532, NULL, 0, 20, 0, 20, '2026-05-05 23:30:55', '2026-05-05 23:30:55'),
(1405, 7, 848, NULL, 0, 20, 1, 19, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1406, 7, 849, NULL, 0, 20, 1, 19, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1407, 7, 850, NULL, 0, 20, 0, 20, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1408, 7, 851, NULL, 0, 20, 2, 18, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1409, 7, 852, NULL, 0, 20, 0, 20, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1410, 7, 853, NULL, 0, 20, 2, 18, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1411, 7, 854, NULL, 0, 20, 0, 20, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1412, 7, 855, NULL, 0, 20, 1, 19, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1413, 7, 856, NULL, 0, 20, 0, 20, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1414, 7, 857, NULL, 0, 20, 1, 19, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1415, 7, 858, NULL, 0, 20, 0, 20, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1416, 7, 859, NULL, 0, 20, 2, 18, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1417, 7, 860, NULL, 0, 20, 1, 19, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1418, 7, 1465, NULL, 0, 20, 2, 18, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1419, 7, 1466, NULL, 0, 20, 0, 20, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1420, 7, 1467, NULL, 0, 20, 2, 18, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1421, 7, 1468, NULL, 0, 20, 1, 19, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1422, 7, 1469, NULL, 0, 20, 0, 20, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1423, 7, 1470, NULL, 0, 20, 1, 19, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1424, 7, 1471, NULL, 0, 20, 0, 20, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1425, 7, 1472, NULL, 0, 20, 2, 18, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1426, 7, 1473, NULL, 0, 20, 1, 19, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1427, 7, 1474, NULL, 0, 20, 2, 18, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1428, 7, 1475, NULL, 0, 20, 0, 20, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1429, 7, 1476, NULL, 0, 20, 0, 20, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1430, 7, 1477, NULL, 0, 20, 0, 20, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1431, 7, 1478, NULL, 0, 0, 0, 0, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1432, 7, 1479, NULL, 0, 0, 0, 0, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1433, 7, 1480, NULL, 0, 0, 0, 0, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1434, 7, 1481, NULL, 0, 0, 0, 0, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1435, 7, 1482, NULL, 0, 20, 0, 20, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1436, 7, 1483, NULL, 0, 20, 1, 19, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1437, 7, 1484, NULL, 0, 20, 1, 19, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1438, 7, 1485, NULL, 0, 20, 2, 18, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1439, 7, 1486, NULL, 0, 20, 0, 20, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1440, 7, 1487, NULL, 0, 20, 1, 19, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1441, 7, 1488, NULL, 0, 20, 1, 19, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1442, 7, 1489, NULL, 0, 20, 0, 20, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1443, 7, 1490, NULL, 0, 20, 0, 20, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1444, 7, 1491, NULL, 0, 20, 0, 20, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1445, 7, 1492, NULL, 0, 20, 1, 19, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1446, 7, 1493, NULL, 0, 20, 1, 19, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1447, 7, 1494, NULL, 0, 20, 2, 18, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1448, 7, 1495, NULL, 0, 20, 1, 19, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1449, 7, 1496, NULL, 0, 20, 0, 20, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1450, 7, 1497, NULL, 0, 20, 2, 18, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1451, 7, 1498, NULL, 0, 0, 0, 0, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1452, 7, 1499, NULL, 0, 0, 0, 0, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1453, 7, 1500, NULL, 0, 0, 0, 0, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1454, 7, 1501, NULL, 0, 0, 0, 0, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1455, 7, 1502, NULL, 0, 0, 0, 0, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1456, 7, 1503, NULL, 0, 0, 0, 0, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1457, 7, 1504, NULL, 0, 0, 0, 0, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1458, 7, 1505, NULL, 0, 0, 0, 0, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1459, 7, 1506, NULL, 0, 0, 0, 0, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1460, 7, 1507, NULL, 0, 0, 0, 0, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1461, 7, 1508, NULL, 0, 0, 0, 0, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1462, 7, 1509, NULL, 0, 0, 0, 0, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1463, 7, 1510, NULL, 0, 0, 0, 0, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1464, 7, 1511, NULL, 0, 0, 0, 0, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1465, 7, 1512, NULL, 0, 0, 0, 0, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1466, 7, 1513, NULL, 0, 0, 0, 0, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1467, 7, 1514, NULL, 0, 0, 0, 0, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1468, 7, 1515, NULL, 0, 0, 0, 0, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1469, 7, 1516, NULL, 0, 0, 0, 0, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1470, 7, 1517, NULL, 0, 0, 0, 0, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1471, 7, 1518, NULL, 0, 0, 0, 0, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1472, 7, 1519, NULL, 0, 0, 0, 0, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1473, 7, 1520, NULL, 0, 0, 0, 0, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1474, 7, 1521, NULL, 0, 0, 0, 0, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1475, 7, 1522, NULL, 0, 0, 0, 0, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1476, 7, 1526, NULL, 0, 20, 1, 19, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1477, 7, 1527, NULL, 0, 20, 1, 19, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1478, 7, 1528, NULL, 0, 20, 2, 18, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1479, 7, 1529, NULL, 0, 20, 3, 17, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1480, 7, 1530, NULL, 0, 20, 2, 18, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1481, 7, 1531, NULL, 0, 20, 3, 17, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1482, 7, 1532, NULL, 0, 20, 2, 18, '2026-05-05 23:33:02', '2026-05-05 23:33:02'),
(1483, 9, 848, NULL, 0, 20, 1, 19, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1484, 9, 849, NULL, 0, 20, 1, 19, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1485, 9, 850, NULL, 0, 20, 0, 20, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1486, 9, 851, NULL, 0, 20, 0, 20, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1487, 9, 852, NULL, 0, 20, 0, 20, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1488, 9, 853, NULL, 0, 20, 1, 19, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1489, 9, 854, NULL, 0, 20, 0, 20, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1490, 9, 855, NULL, 0, 20, 1, 19, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1491, 9, 856, NULL, 0, 20, 0, 20, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1492, 9, 857, NULL, 0, 20, 0, 20, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1493, 9, 858, NULL, 0, 20, 0, 20, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1494, 9, 859, NULL, 0, 20, 1, 19, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1495, 9, 860, NULL, 0, 20, 1, 19, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1496, 9, 1465, NULL, 0, 20, 0, 20, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1497, 9, 1466, NULL, 0, 20, 1, 19, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1498, 9, 1467, NULL, 0, 20, 2, 18, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1499, 9, 1468, NULL, 0, 20, 1, 19, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1500, 9, 1469, NULL, 0, 20, 0, 20, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1501, 9, 1470, NULL, 0, 20, 0, 20, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1502, 9, 1471, NULL, 0, 20, 0, 20, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1503, 9, 1472, NULL, 0, 20, 2, 18, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1504, 9, 1473, NULL, 0, 20, 1, 19, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1505, 9, 1474, NULL, 0, 20, 2, 18, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1506, 9, 1475, NULL, 0, 20, 0, 20, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1507, 9, 1476, NULL, 0, 20, 0, 20, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1508, 9, 1477, NULL, 0, 20, 0, 20, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1509, 9, 1478, NULL, 0, 0, 0, 0, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1510, 9, 1479, NULL, 0, 0, 0, 0, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1511, 9, 1480, NULL, 0, 0, 0, 0, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1512, 9, 1481, NULL, 0, 0, 0, 0, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1513, 9, 1482, NULL, 0, 20, 0, 20, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1514, 9, 1483, NULL, 0, 20, 0, 20, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1515, 9, 1484, NULL, 0, 20, 1, 19, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1516, 9, 1485, NULL, 0, 20, 0, 20, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1517, 9, 1486, NULL, 0, 20, 0, 20, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1518, 9, 1487, NULL, 0, 20, 1, 19, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1519, 9, 1488, NULL, 0, 20, 1, 19, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1520, 9, 1489, NULL, 0, 20, 0, 20, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1521, 9, 1490, NULL, 0, 20, 0, 20, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1522, 9, 1491, NULL, 0, 20, 0, 20, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1523, 9, 1492, NULL, 0, 20, 1, 19, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1524, 9, 1493, NULL, 0, 20, 1, 19, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1525, 9, 1494, NULL, 0, 20, 2, 18, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1526, 9, 1495, NULL, 0, 20, 1, 19, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1527, 9, 1496, NULL, 0, 20, 0, 20, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1528, 9, 1497, NULL, 0, 20, 2, 18, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1529, 9, 1498, NULL, 0, 0, 0, 0, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1530, 9, 1499, NULL, 0, 0, 0, 0, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1531, 9, 1500, NULL, 0, 0, 0, 0, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1532, 9, 1501, NULL, 0, 0, 0, 0, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1533, 9, 1502, NULL, 0, 0, 0, 0, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1534, 9, 1503, NULL, 0, 0, 0, 0, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1535, 9, 1504, NULL, 0, 0, 0, 0, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1536, 9, 1505, NULL, 0, 0, 0, 0, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1537, 9, 1506, NULL, 0, 0, 0, 0, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1538, 9, 1507, NULL, 0, 0, 0, 0, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1539, 9, 1508, NULL, 0, 0, 0, 0, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1540, 9, 1509, NULL, 0, 0, 0, 0, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1541, 9, 1510, NULL, 0, 0, 0, 0, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1542, 9, 1511, NULL, 0, 0, 0, 0, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1543, 9, 1512, NULL, 0, 0, 0, 0, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1544, 9, 1513, NULL, 0, 0, 0, 0, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1545, 9, 1514, NULL, 0, 0, 0, 0, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1546, 9, 1515, NULL, 0, 0, 0, 0, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1547, 9, 1516, NULL, 0, 0, 0, 0, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1548, 9, 1517, NULL, 0, 0, 0, 0, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1549, 9, 1518, NULL, 0, 0, 0, 0, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1550, 9, 1519, NULL, 0, 0, 0, 0, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1551, 9, 1520, NULL, 0, 0, 0, 0, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1552, 9, 1521, NULL, 0, 0, 0, 0, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1553, 9, 1522, NULL, 0, 0, 0, 0, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1554, 9, 1526, NULL, 0, 20, 1, 19, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1555, 9, 1527, NULL, 0, 20, 1, 19, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1556, 9, 1528, NULL, 0, 20, 0, 20, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1557, 9, 1529, NULL, 0, 20, 3, 17, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1558, 9, 1530, NULL, 0, 20, 2, 18, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1559, 9, 1531, NULL, 0, 20, 0, 20, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1560, 9, 1532, NULL, 0, 20, 0, 20, '2026-05-05 23:44:11', '2026-05-05 23:44:11'),
(1561, 11, 848, NULL, 0, 20, 1, 19, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1562, 11, 849, NULL, 0, 20, 0, 20, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1563, 11, 850, NULL, 0, 20, 0, 20, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1564, 11, 851, NULL, 0, 20, 2, 18, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1565, 11, 852, NULL, 0, 20, 0, 20, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1566, 11, 853, NULL, 0, 20, 1, 19, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1567, 11, 854, NULL, 0, 20, 0, 20, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1568, 11, 855, NULL, 0, 20, 1, 19, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1569, 11, 856, NULL, 0, 20, 0, 20, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1570, 11, 857, NULL, 0, 20, 1, 19, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1571, 11, 858, NULL, 0, 20, 0, 20, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1572, 11, 859, NULL, 0, 20, 1, 19, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1573, 11, 860, NULL, 0, 20, 1, 19, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1574, 11, 1465, NULL, 0, 20, 1, 19, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1575, 11, 1466, NULL, 0, 20, 0, 20, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1576, 11, 1467, NULL, 0, 20, 1, 19, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1577, 11, 1468, NULL, 0, 20, 1, 19, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1578, 11, 1469, NULL, 0, 20, 0, 20, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1579, 11, 1470, NULL, 0, 20, 1, 19, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1580, 11, 1471, NULL, 0, 20, 0, 20, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1581, 11, 1472, NULL, 0, 20, 2, 18, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1582, 11, 1473, NULL, 0, 20, 1, 19, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1583, 11, 1474, NULL, 0, 20, 1, 19, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1584, 11, 1475, NULL, 0, 20, 0, 20, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1585, 11, 1476, NULL, 0, 20, 0, 20, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1586, 11, 1477, NULL, 0, 20, 0, 20, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1587, 11, 1478, NULL, 0, 0, 0, 0, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1588, 11, 1479, NULL, 0, 0, 0, 0, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1589, 11, 1480, NULL, 0, 0, 0, 0, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1590, 11, 1481, NULL, 0, 0, 0, 0, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1591, 11, 1482, NULL, 0, 20, 0, 20, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1592, 11, 1483, NULL, 0, 20, 1, 19, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1593, 11, 1484, NULL, 0, 20, 1, 19, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1594, 11, 1485, NULL, 0, 20, 0, 20, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1595, 11, 1486, NULL, 0, 20, 0, 20, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1596, 11, 1487, NULL, 0, 20, 1, 19, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1597, 11, 1488, NULL, 0, 20, 1, 19, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1598, 11, 1489, NULL, 0, 20, 0, 20, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1599, 11, 1490, NULL, 0, 20, 0, 20, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1600, 11, 1491, NULL, 0, 20, 0, 20, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1601, 11, 1492, NULL, 0, 20, 1, 19, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1602, 11, 1493, NULL, 0, 20, 1, 19, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1603, 11, 1494, NULL, 0, 20, 0, 20, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1604, 11, 1495, NULL, 0, 20, 1, 19, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1605, 11, 1496, NULL, 0, 20, 0, 20, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1606, 11, 1497, NULL, 0, 20, 2, 18, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1607, 11, 1498, NULL, 0, 0, 0, 0, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1608, 11, 1499, NULL, 0, 0, 0, 0, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1609, 11, 1500, NULL, 0, 0, 0, 0, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1610, 11, 1501, NULL, 0, 0, 0, 0, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1611, 11, 1502, NULL, 0, 0, 0, 0, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1612, 11, 1503, NULL, 0, 0, 0, 0, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1613, 11, 1504, NULL, 0, 0, 0, 0, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1614, 11, 1505, NULL, 0, 0, 0, 0, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1615, 11, 1506, NULL, 0, 0, 0, 0, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1616, 11, 1507, NULL, 0, 0, 0, 0, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1617, 11, 1508, NULL, 0, 0, 0, 0, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1618, 11, 1509, NULL, 0, 0, 0, 0, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1619, 11, 1510, NULL, 0, 0, 0, 0, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1620, 11, 1511, NULL, 0, 0, 0, 0, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1621, 11, 1512, NULL, 0, 0, 0, 0, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1622, 11, 1513, NULL, 0, 0, 0, 0, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1623, 11, 1514, NULL, 0, 0, 0, 0, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1624, 11, 1515, NULL, 0, 0, 0, 0, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1625, 11, 1516, NULL, 0, 0, 0, 0, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1626, 11, 1517, NULL, 0, 0, 0, 0, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1627, 11, 1518, NULL, 0, 0, 0, 0, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1628, 11, 1519, NULL, 0, 0, 0, 0, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1629, 11, 1520, NULL, 0, 0, 0, 0, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1630, 11, 1521, NULL, 0, 0, 0, 0, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1631, 11, 1522, NULL, 0, 0, 0, 0, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1632, 11, 1526, NULL, 0, 20, 1, 19, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1633, 11, 1527, NULL, 0, 20, 1, 19, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1634, 11, 1528, NULL, 0, 20, 0, 20, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1635, 11, 1529, NULL, 0, 20, 1, 19, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1636, 11, 1530, NULL, 0, 20, 2, 18, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1637, 11, 1531, NULL, 0, 20, 3, 17, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1638, 11, 1532, NULL, 0, 20, 2, 18, '2026-05-05 23:45:04', '2026-05-05 23:45:04'),
(1639, 13, 848, NULL, 0, 20, 0, 20, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1640, 13, 849, NULL, 0, 20, 1, 19, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1641, 13, 850, NULL, 0, 20, 0, 20, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1642, 13, 851, NULL, 0, 20, 2, 18, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1643, 13, 852, NULL, 0, 20, 0, 20, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1644, 13, 853, NULL, 0, 20, 2, 18, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1645, 13, 854, NULL, 0, 20, 0, 20, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1646, 13, 855, NULL, 0, 20, 3, 17, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1647, 13, 856, NULL, 0, 20, 0, 20, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1648, 13, 857, NULL, 0, 20, 0, 20, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1649, 13, 858, NULL, 0, 20, 0, 20, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1650, 13, 859, NULL, 0, 20, 1, 19, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1651, 13, 860, NULL, 0, 20, 1, 19, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1652, 13, 1465, NULL, 0, 20, 0, 20, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1653, 13, 1466, NULL, 0, 20, 0, 20, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1654, 13, 1467, NULL, 0, 20, 2, 18, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1655, 13, 1468, NULL, 0, 20, 1, 19, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1656, 13, 1469, NULL, 0, 20, 0, 20, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1657, 13, 1470, NULL, 0, 20, 1, 19, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1658, 13, 1471, NULL, 0, 20, 0, 20, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1659, 13, 1472, NULL, 0, 20, 0, 20, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1660, 13, 1473, NULL, 0, 20, 1, 19, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1661, 13, 1474, NULL, 0, 20, 1, 19, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1662, 13, 1475, NULL, 0, 20, 0, 20, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1663, 13, 1476, NULL, 0, 20, 0, 20, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1664, 13, 1477, NULL, 0, 20, 0, 20, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1665, 13, 1478, NULL, 0, 0, 0, 0, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1666, 13, 1479, NULL, 0, 0, 0, 0, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1667, 13, 1480, NULL, 0, 0, 0, 0, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1668, 13, 1481, NULL, 0, 0, 0, 0, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1669, 13, 1482, NULL, 0, 20, 1, 19, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1670, 13, 1483, NULL, 0, 20, 0, 20, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1671, 13, 1484, NULL, 0, 20, 2, 18, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1672, 13, 1485, NULL, 0, 20, 1, 19, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1673, 13, 1486, NULL, 0, 20, 0, 20, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1674, 13, 1487, NULL, 0, 20, 1, 19, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1675, 13, 1488, NULL, 0, 20, 2, 18, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1676, 13, 1489, NULL, 0, 20, 0, 20, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1677, 13, 1490, NULL, 0, 20, 0, 20, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1678, 13, 1491, NULL, 0, 20, 0, 20, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1679, 13, 1492, NULL, 0, 20, 1, 19, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1680, 13, 1493, NULL, 0, 20, 0, 20, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1681, 13, 1494, NULL, 0, 20, 2, 18, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1682, 13, 1495, NULL, 0, 20, 0, 20, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1683, 13, 1496, NULL, 0, 20, 1, 19, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1684, 13, 1497, NULL, 0, 20, 2, 18, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1685, 13, 1498, NULL, 0, 0, 0, 0, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1686, 13, 1499, NULL, 0, 0, 0, 0, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1687, 13, 1500, NULL, 0, 0, 0, 0, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1688, 13, 1501, NULL, 0, 0, 0, 0, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1689, 13, 1502, NULL, 0, 0, 0, 0, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1690, 13, 1503, NULL, 0, 0, 0, 0, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1691, 13, 1504, NULL, 0, 0, 0, 0, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1692, 13, 1505, NULL, 0, 0, 0, 0, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1693, 13, 1506, NULL, 0, 0, 0, 0, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1694, 13, 1507, NULL, 0, 0, 0, 0, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1695, 13, 1508, NULL, 0, 0, 0, 0, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1696, 13, 1509, NULL, 0, 0, 0, 0, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1697, 13, 1510, NULL, 0, 0, 0, 0, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1698, 13, 1511, NULL, 0, 0, 0, 0, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1699, 13, 1512, NULL, 0, 0, 0, 0, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1700, 13, 1513, NULL, 0, 0, 0, 0, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1701, 13, 1514, NULL, 0, 0, 0, 0, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1702, 13, 1515, NULL, 0, 0, 0, 0, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1703, 13, 1516, NULL, 0, 0, 0, 0, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1704, 13, 1517, NULL, 0, 0, 0, 0, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1705, 13, 1518, NULL, 0, 0, 0, 0, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1706, 13, 1519, NULL, 0, 0, 0, 0, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1707, 13, 1520, NULL, 0, 0, 0, 0, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1708, 13, 1521, NULL, 0, 0, 0, 0, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1709, 13, 1522, NULL, 0, 0, 0, 0, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1710, 13, 1526, NULL, 0, 20, 1, 19, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1711, 13, 1527, NULL, 0, 20, 0, 20, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1712, 13, 1528, NULL, 0, 20, 0, 20, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1713, 13, 1529, NULL, 0, 20, 1, 19, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1714, 13, 1530, NULL, 0, 20, 2, 18, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1715, 13, 1531, NULL, 0, 20, 1, 19, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1716, 13, 1532, NULL, 0, 20, 1, 19, '2026-05-05 23:46:57', '2026-05-05 23:46:57'),
(1717, 15, 848, NULL, 0, 20, 1, 19, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1718, 15, 849, NULL, 0, 20, 1, 19, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1719, 15, 850, NULL, 0, 20, 0, 20, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1720, 15, 851, NULL, 0, 20, 0, 20, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1721, 15, 852, NULL, 0, 20, 0, 20, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1722, 15, 853, NULL, 0, 20, 1, 19, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1723, 15, 854, NULL, 0, 20, 0, 20, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1724, 15, 855, NULL, 0, 20, 1, 19, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1725, 15, 856, NULL, 0, 20, 0, 20, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1726, 15, 857, NULL, 0, 20, 2, 18, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1727, 15, 858, NULL, 0, 20, 0, 20, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1728, 15, 859, NULL, 0, 20, 2, 18, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1729, 15, 860, NULL, 0, 20, 0, 20, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1730, 15, 1465, NULL, 0, 20, 0, 20, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1731, 15, 1466, NULL, 0, 20, 1, 19, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1732, 15, 1467, NULL, 0, 20, 0, 20, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1733, 15, 1468, NULL, 0, 20, 1, 19, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1734, 15, 1469, NULL, 0, 20, 0, 20, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1735, 15, 1470, NULL, 0, 20, 1, 19, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1736, 15, 1471, NULL, 0, 20, 0, 20, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1737, 15, 1472, NULL, 0, 20, 0, 20, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1738, 15, 1473, NULL, 0, 20, 1, 19, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1739, 15, 1474, NULL, 0, 20, 0, 20, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1740, 15, 1475, NULL, 0, 20, 0, 20, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1741, 15, 1476, NULL, 0, 20, 1, 19, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1742, 15, 1477, NULL, 0, 20, 0, 20, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1743, 15, 1478, NULL, 0, 0, 0, 0, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1744, 15, 1479, NULL, 0, 0, 0, 0, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1745, 15, 1480, NULL, 0, 0, 0, 0, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1746, 15, 1481, NULL, 0, 0, 0, 0, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1747, 15, 1482, NULL, 0, 20, 0, 20, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1748, 15, 1483, NULL, 0, 20, 0, 20, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1749, 15, 1484, NULL, 0, 20, 1, 19, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1750, 15, 1485, NULL, 0, 20, 0, 20, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1751, 15, 1486, NULL, 0, 20, 0, 20, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1752, 15, 1487, NULL, 0, 20, 2, 18, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1753, 15, 1488, NULL, 0, 20, 1, 19, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1754, 15, 1489, NULL, 0, 20, 0, 20, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1755, 15, 1490, NULL, 0, 20, 0, 20, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1756, 15, 1491, NULL, 0, 20, 0, 20, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1757, 15, 1492, NULL, 0, 20, 1, 19, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1758, 15, 1493, NULL, 0, 20, 1, 19, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1759, 15, 1494, NULL, 0, 20, 2, 18, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1760, 15, 1495, NULL, 0, 20, 1, 19, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1761, 15, 1496, NULL, 0, 20, 0, 20, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1762, 15, 1497, NULL, 0, 20, 2, 18, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1763, 15, 1498, NULL, 0, 0, 0, 0, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1764, 15, 1499, NULL, 0, 0, 0, 0, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1765, 15, 1500, NULL, 0, 0, 0, 0, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1766, 15, 1501, NULL, 0, 0, 0, 0, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1767, 15, 1502, NULL, 0, 0, 0, 0, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1768, 15, 1503, NULL, 0, 0, 0, 0, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1769, 15, 1504, NULL, 0, 0, 0, 0, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1770, 15, 1505, NULL, 0, 0, 0, 0, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1771, 15, 1506, NULL, 0, 0, 0, 0, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1772, 15, 1507, NULL, 0, 0, 0, 0, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1773, 15, 1508, NULL, 0, 0, 0, 0, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1774, 15, 1509, NULL, 0, 0, 0, 0, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1775, 15, 1510, NULL, 0, 0, 0, 0, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1776, 15, 1511, NULL, 0, 0, 0, 0, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1777, 15, 1512, NULL, 0, 0, 0, 0, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1778, 15, 1513, NULL, 0, 0, 0, 0, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1779, 15, 1514, NULL, 0, 0, 0, 0, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1780, 15, 1515, NULL, 0, 0, 0, 0, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1781, 15, 1516, NULL, 0, 0, 0, 0, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1782, 15, 1517, NULL, 0, 0, 0, 0, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1783, 15, 1518, NULL, 0, 0, 0, 0, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1784, 15, 1519, NULL, 0, 0, 0, 0, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1785, 15, 1520, NULL, 0, 0, 0, 0, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1786, 15, 1521, NULL, 0, 0, 0, 0, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1787, 15, 1522, NULL, 0, 0, 0, 0, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1788, 15, 1526, NULL, 0, 20, 1, 19, '2026-05-05 23:47:58', '2026-05-05 23:47:58');
INSERT INTO `trampa_roedor_seguimientos` (`id`, `seguimiento_id`, `trampa_id`, `observacion`, `cantidad`, `inicial`, `merma`, `actual`, `created_at`, `updated_at`) VALUES
(1789, 15, 1527, NULL, 0, 20, 1, 19, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1790, 15, 1528, NULL, 0, 20, 0, 20, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1791, 15, 1529, NULL, 0, 20, 3, 17, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1792, 15, 1530, NULL, 0, 20, 2, 18, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1793, 15, 1531, NULL, 0, 20, 3, 17, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(1794, 15, 1532, NULL, 0, 20, 0, 20, '2026-05-05 23:47:58', '2026-05-05 23:47:58'),
(2695, 18, 848, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2696, 18, 849, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2697, 18, 850, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2698, 18, 851, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2699, 18, 852, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2700, 18, 853, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2701, 18, 854, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2702, 18, 855, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2703, 18, 856, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2704, 18, 857, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2705, 18, 858, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2706, 18, 859, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2707, 18, 860, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2708, 18, 1465, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2709, 18, 1466, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2710, 18, 1467, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2711, 18, 1468, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2712, 18, 1469, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2713, 18, 1470, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2714, 18, 1471, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2715, 18, 1472, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2716, 18, 1473, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2717, 18, 1474, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2718, 18, 1475, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2719, 18, 1476, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2720, 18, 1477, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2721, 18, 1478, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2722, 18, 1479, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2723, 18, 1480, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2724, 18, 1481, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2725, 18, 1482, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2726, 18, 1483, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2727, 18, 1484, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2728, 18, 1485, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2729, 18, 1486, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2730, 18, 1487, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2731, 18, 1488, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2732, 18, 1489, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2733, 18, 1490, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2734, 18, 1491, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2735, 18, 1492, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2736, 18, 1493, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2737, 18, 1494, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2738, 18, 1495, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2739, 18, 1496, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2740, 18, 1497, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2741, 18, 1498, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2742, 18, 1499, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2743, 18, 1500, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2744, 18, 1501, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2745, 18, 1502, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2746, 18, 1503, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2747, 18, 1504, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2748, 18, 1505, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2749, 18, 1506, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2750, 18, 1507, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2751, 18, 1508, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2752, 18, 1509, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2753, 18, 1510, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2754, 18, 1511, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2755, 18, 1512, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2756, 18, 1513, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2757, 18, 1514, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2758, 18, 1515, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2759, 18, 1516, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2760, 18, 1517, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2761, 18, 1518, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2762, 18, 1519, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2763, 18, 1520, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2764, 18, 1521, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2765, 18, 1522, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2766, 18, 1526, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2767, 18, 1527, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2768, 18, 1528, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2769, 18, 1529, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2770, 18, 1530, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2771, 18, 1531, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(2772, 18, 1532, NULL, 0, 0, 0, 0, '2026-05-12 12:01:46', '2026-05-12 12:01:46'),
(3553, 21, 1565, '', 0, 40, 0, 40, '2026-05-13 02:42:02', '2026-05-13 02:42:02'),
(3554, 21, 1566, '', 1, 40, 0, 40, '2026-05-13 02:42:02', '2026-05-13 02:42:02'),
(3555, 21, 1567, '', 0, 40, 0, 40, '2026-05-13 02:42:02', '2026-05-13 02:42:02'),
(3556, 21, 1568, '', 0, 40, 0, 40, '2026-05-13 02:42:02', '2026-05-13 02:42:02'),
(3557, 21, 1569, '', 0, 40, 0, 40, '2026-05-13 02:42:02', '2026-05-13 02:42:02'),
(3558, 21, 1570, '', 0, 40, 0, 40, '2026-05-13 02:42:02', '2026-05-13 02:42:02'),
(3559, 21, 1571, '', 0, 40, 0, 40, '2026-05-13 02:42:02', '2026-05-13 02:42:02'),
(3560, 21, 1572, '', 0, 40, 0, 40, '2026-05-13 02:42:02', '2026-05-13 02:42:02'),
(3561, 21, 1573, '', 0, 40, 0, 40, '2026-05-13 02:42:02', '2026-05-13 02:42:02'),
(3562, 21, 1574, '', 0, 40, 0, 40, '2026-05-13 02:42:02', '2026-05-13 02:42:02'),
(3563, 21, 1575, '', 0, 48, 8, 40, '2026-05-13 02:42:02', '2026-05-13 02:42:02'),
(3564, 21, 1576, '', 0, 40, 0, 40, '2026-05-13 02:42:02', '2026-05-13 02:42:02'),
(3565, 21, 1577, '', 0, 40, 0, 40, '2026-05-13 02:42:02', '2026-05-13 02:42:02'),
(3566, 21, 1578, '', 0, 40, 0, 40, '2026-05-13 02:42:02', '2026-05-13 02:42:02'),
(3567, 21, 1579, '', 0, 40, 0, 40, '2026-05-13 02:42:02', '2026-05-13 02:42:02'),
(3568, 21, 1580, '', 0, 40, 0, 40, '2026-05-13 02:42:02', '2026-05-13 02:42:02'),
(3611, 23, 1340, '', 0, 20, 0, 20, '2026-05-14 17:01:10', '2026-05-14 17:01:10'),
(3612, 23, 1341, '', 0, 20, 2, 18, '2026-05-14 17:01:10', '2026-05-14 17:01:10'),
(3613, 23, 1342, '', 0, 20, 2, 18, '2026-05-14 17:01:10', '2026-05-14 17:01:10'),
(3614, 23, 1343, '', 0, 20, 1, 19, '2026-05-14 17:01:10', '2026-05-14 17:01:10'),
(3615, 23, 1344, '', 0, 20, 1, 19, '2026-05-14 17:01:10', '2026-05-14 17:01:10'),
(3616, 23, 1345, '', 0, 20, 2, 18, '2026-05-14 17:01:10', '2026-05-14 17:01:10'),
(3617, 23, 1346, '', 0, 20, 0, 20, '2026-05-14 17:01:10', '2026-05-14 17:01:10'),
(3618, 23, 1347, '', 0, 20, 0, 20, '2026-05-14 17:01:10', '2026-05-14 17:01:10'),
(3619, 23, 1348, '', 0, 20, 0, 20, '2026-05-14 17:01:10', '2026-05-14 17:01:10'),
(3620, 23, 1349, '', 0, 20, 1, 19, '2026-05-14 17:01:10', '2026-05-14 17:01:10'),
(3621, 23, 1350, '', 0, 20, 0, 20, '2026-05-14 17:01:10', '2026-05-14 17:01:10'),
(3622, 23, 1351, '', 0, 20, 2, 18, '2026-05-14 17:01:10', '2026-05-14 17:01:10'),
(3623, 23, 1352, '', 0, 20, 1, 19, '2026-05-14 17:01:10', '2026-05-14 17:01:10'),
(3624, 23, 1353, '', 0, 20, 0, 20, '2026-05-14 17:01:10', '2026-05-14 17:01:10'),
(3625, 23, 1354, '', 0, 20, 1, 19, '2026-05-14 17:01:10', '2026-05-14 17:01:10'),
(3626, 23, 1355, '', 0, 20, 0, 20, '2026-05-14 17:01:10', '2026-05-14 17:01:10'),
(3627, 23, 1356, '', 0, 20, 0, 20, '2026-05-14 17:01:10', '2026-05-14 17:01:10'),
(3628, 23, 1357, '', 0, 20, -59, 79, '2026-05-14 17:01:10', '2026-05-14 17:01:10'),
(3629, 23, 1358, '', 0, 20, 0, 20, '2026-05-14 17:01:10', '2026-05-14 17:01:10'),
(3630, 23, 1359, '', 0, 20, 1, 19, '2026-05-14 17:01:10', '2026-05-14 17:01:10'),
(3631, 23, 1360, '', 0, 20, 1, 19, '2026-05-14 17:01:10', '2026-05-14 17:01:10'),
(3632, 23, 1361, '', 0, 20, 2, 18, '2026-05-14 17:01:10', '2026-05-14 17:01:10'),
(3633, 23, 1362, '', 0, 20, 0, 20, '2026-05-14 17:01:10', '2026-05-14 17:01:10'),
(3634, 23, 1363, '', 0, 20, 1, 19, '2026-05-14 17:01:10', '2026-05-14 17:01:10'),
(3635, 23, 1364, '', 0, 20, 0, 20, '2026-05-14 17:01:10', '2026-05-14 17:01:10'),
(3636, 23, 1365, '', 0, 20, 0, 20, '2026-05-14 17:01:10', '2026-05-14 17:01:10'),
(3637, 23, 1366, '', 0, 0, 0, 0, '2026-05-14 17:01:10', '2026-05-14 17:01:10'),
(3638, 23, 1367, '', 0, 0, 0, 0, '2026-05-14 17:01:10', '2026-05-14 17:01:10'),
(3639, 23, 1368, '', 0, 0, 0, 0, '2026-05-14 17:01:10', '2026-05-14 17:01:10'),
(3640, 23, 1369, '', 0, 0, 0, 0, '2026-05-14 17:01:10', '2026-05-14 17:01:10'),
(3641, 23, 1394, '', 0, 20, 0, 20, '2026-05-14 17:01:10', '2026-05-14 17:01:10'),
(3642, 23, 1395, '', 0, 20, 0, 20, '2026-05-14 17:01:10', '2026-05-14 17:01:10'),
(3643, 23, 1396, '', 0, 20, 1, 19, '2026-05-14 17:01:10', '2026-05-14 17:01:10'),
(3644, 23, 1397, '', 0, 20, 2, 18, '2026-05-14 17:01:10', '2026-05-14 17:01:10'),
(3645, 23, 1398, '', 0, 20, 3, 17, '2026-05-14 17:01:10', '2026-05-14 17:01:10'),
(3646, 23, 1399, '', 0, 20, 0, 20, '2026-05-14 17:01:10', '2026-05-14 17:01:10'),
(3647, 23, 1400, '', 0, 20, 1, 19, '2026-05-14 17:01:10', '2026-05-14 17:01:10'),
(3648, 23, 1401, '', 0, 20, 1, 19, '2026-05-14 17:01:10', '2026-05-14 17:01:10'),
(3649, 23, 1402, '', 0, 20, 0, 20, '2026-05-14 17:01:10', '2026-05-14 17:01:10'),
(3650, 23, 1403, '', 0, 20, 1, 19, '2026-05-14 17:01:10', '2026-05-14 17:01:10'),
(3651, 23, 1404, '', 0, 20, 2, 18, '2026-05-14 17:01:10', '2026-05-14 17:01:10'),
(3652, 23, 1405, '', 0, 20, 3, 17, '2026-05-14 17:01:10', '2026-05-14 17:01:10'),
(3653, 24, 1152, NULL, 0, 20, 2, 18, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3654, 24, 1153, NULL, 0, 20, 0, 20, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3655, 24, 1154, NULL, 0, 20, 1, 19, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3656, 24, 1155, NULL, 0, 20, 2, 18, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3657, 24, 1156, NULL, 0, 20, 1, 19, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3658, 24, 1157, NULL, 0, 20, 0, 20, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3659, 24, 1158, NULL, 0, 20, 1, 19, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3660, 24, 1159, NULL, 0, 20, 2, 18, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3661, 24, 1160, NULL, 0, 20, 0, 20, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3662, 24, 1161, NULL, 0, 20, 0, 20, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3663, 24, 1162, NULL, 0, 20, 1, 19, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3664, 24, 1163, NULL, 0, 20, 0, 20, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3665, 24, 1164, NULL, 0, 20, 1, 19, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3666, 24, 1165, NULL, 0, 20, 2, 18, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3667, 24, 1166, NULL, 0, 20, 0, 20, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3668, 24, 1167, NULL, 0, 20, 3, 17, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3669, 24, 1168, NULL, 0, 20, 0, 20, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3670, 24, 1169, NULL, 0, 20, 1, 19, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3671, 24, 1170, NULL, 0, 20, 0, 20, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3672, 24, 1171, NULL, 0, 20, 0, 20, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3673, 24, 1172, NULL, 0, 20, 2, 18, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3674, 24, 1173, NULL, 0, 20, 2, 18, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3675, 24, 1174, NULL, 0, 20, 0, 20, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3676, 24, 1175, NULL, 0, 20, 1, 19, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3677, 24, 1176, NULL, 0, 20, 1, 19, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3678, 24, 1177, NULL, 0, 20, 2, 18, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3679, 24, 1178, NULL, 0, 20, 2, 18, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3680, 24, 1179, NULL, 0, 20, 0, 20, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3681, 24, 1180, NULL, 0, 20, 3, 17, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3682, 24, 1181, NULL, 0, 20, 0, 20, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3683, 24, 1182, NULL, 0, 20, 2, 18, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3684, 24, 1183, NULL, 0, 20, 0, 20, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3685, 24, 1184, NULL, 0, 20, 2, 18, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3686, 24, 1185, NULL, 0, 20, 1, 19, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3687, 24, 1186, NULL, 0, 20, 0, 20, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3688, 24, 1187, NULL, 0, 20, 3, 17, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3689, 24, 1188, NULL, 0, 20, 1, 19, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3690, 24, 1189, NULL, 0, 20, 1, 19, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3691, 24, 1190, NULL, 0, 20, 2, 18, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3692, 24, 1191, NULL, 0, 20, 0, 20, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3693, 24, 1192, NULL, 0, 20, 1, 19, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3694, 24, 1193, NULL, 0, 20, 0, 20, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3695, 24, 1194, NULL, 0, 20, 1, 19, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3696, 24, 1195, NULL, 0, 20, 2, 18, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3697, 24, 1196, NULL, 0, 20, 3, 17, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3698, 24, 1197, NULL, 0, 20, 0, 20, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3699, 24, 1198, NULL, 0, 20, 2, 18, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3700, 24, 1199, NULL, 0, 20, 1, 19, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3701, 24, 1200, NULL, 0, 20, 0, 20, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3702, 24, 1201, NULL, 0, 20, 2, 18, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3703, 24, 1202, NULL, 0, 20, 0, 20, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3704, 24, 1203, NULL, 0, 20, 1, 19, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3705, 24, 1204, NULL, 0, 20, 1, 19, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3706, 24, 1205, NULL, 0, 20, 0, 20, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3707, 24, 1206, NULL, 0, 20, 2, 18, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3708, 24, 1207, NULL, 0, 20, 2, 18, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3709, 24, 1208, NULL, 0, 20, 0, 20, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3710, 24, 1209, NULL, 0, 20, 1, 19, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3711, 24, 1210, NULL, 0, 20, 1, 19, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3712, 24, 1211, NULL, 0, 20, 2, 18, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3713, 24, 1212, NULL, 0, 20, 3, 17, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3714, 24, 1213, NULL, 0, 20, 0, 20, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3715, 24, 1214, NULL, 0, 20, 1, 19, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3716, 24, 1215, NULL, 0, 20, 0, 20, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3717, 24, 1216, NULL, 0, 20, 2, 18, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3718, 24, 1217, NULL, 0, 20, 0, 20, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3719, 24, 1218, NULL, 0, 20, 3, 17, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3720, 24, 1219, NULL, 0, 20, 1, 19, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3721, 24, 1220, NULL, 0, 20, 0, 20, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3722, 24, 1221, NULL, 0, 20, 2, 18, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3723, 24, 1222, NULL, 0, 20, 1, 19, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3724, 24, 1223, NULL, 0, 20, 0, 20, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3725, 24, 1224, NULL, 0, 20, 1, 19, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3726, 24, 1225, NULL, 0, 20, 0, 20, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3727, 24, 1226, NULL, 0, 20, 2, 18, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3728, 24, 1227, NULL, 0, 20, 0, 20, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3729, 24, 1228, NULL, 0, 20, 3, 17, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3730, 24, 1229, NULL, 0, 20, 1, 19, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3731, 24, 1230, NULL, 0, 20, 0, 20, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3732, 24, 1231, NULL, 0, 20, 2, 18, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3733, 24, 1232, NULL, 0, 20, 2, 18, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3734, 24, 1233, NULL, 0, 20, 0, 20, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3735, 24, 1234, NULL, 0, 20, 0, 20, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3736, 24, 1235, NULL, 0, 20, 1, 19, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3737, 24, 1236, NULL, 0, 20, 3, 17, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3738, 24, 1237, NULL, 0, 20, 0, 20, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3739, 24, 1238, NULL, 0, 20, 2, 18, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3740, 24, 1239, NULL, 0, 20, 1, 19, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3741, 24, 1240, NULL, 0, 20, 0, 20, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3742, 24, 1241, NULL, 0, 20, 1, 19, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3743, 24, 1242, NULL, 0, 20, 2, 18, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3744, 24, 1243, NULL, 0, 20, 1, 19, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3745, 24, 1244, NULL, 0, 20, 3, 17, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3746, 24, 1245, NULL, 0, 20, 2, 18, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3747, 24, 1246, NULL, 0, 20, 1, 19, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3748, 24, 1247, NULL, 0, 20, 0, 20, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3749, 24, 1248, NULL, 0, 20, 2, 18, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3750, 24, 1249, NULL, 0, 20, 2, 18, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3751, 24, 1250, NULL, 0, 20, 0, 20, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3752, 24, 1251, NULL, 0, 20, 3, 17, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3753, 24, 1252, NULL, 0, 0, 0, 0, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3754, 24, 1253, NULL, 0, 0, 0, 0, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3755, 24, 1254, NULL, 0, 0, 0, 0, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3756, 24, 1255, NULL, 0, 0, 0, 0, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3757, 24, 1256, NULL, 0, 0, 0, 0, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3758, 24, 1257, NULL, 0, 0, 0, 0, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3759, 24, 1258, NULL, 0, 0, 0, 0, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3760, 24, 1259, NULL, 0, 0, 0, 0, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3761, 24, 1260, NULL, 0, 0, 0, 0, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3762, 24, 1261, NULL, 0, 0, 0, 0, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3763, 24, 1262, NULL, 0, 0, 0, 0, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3764, 24, 1263, NULL, 0, 0, 0, 0, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3765, 24, 1264, NULL, 0, 0, 0, 0, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3766, 24, 1265, NULL, 0, 0, 0, 0, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3767, 24, 1266, NULL, 0, 0, 0, 0, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3768, 24, 1267, NULL, 0, 0, 0, 0, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3769, 24, 1268, NULL, 0, 0, 0, 0, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3770, 24, 1269, NULL, 0, 0, 0, 0, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3771, 24, 1270, NULL, 0, 0, 0, 0, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3772, 24, 1271, NULL, 0, 0, 0, 0, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3773, 24, 1272, NULL, 0, 0, 0, 0, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3774, 24, 1273, NULL, 0, 0, 0, 0, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3775, 24, 1274, NULL, 0, 0, 0, 0, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3776, 24, 1275, NULL, 0, 0, 0, 0, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3777, 24, 1276, NULL, 0, 0, 0, 0, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3778, 24, 1277, NULL, 0, 0, 0, 0, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3779, 24, 1278, NULL, 0, 0, 0, 0, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3780, 24, 1279, NULL, 0, 0, 0, 0, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3781, 24, 1280, NULL, 0, 0, 0, 0, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3782, 24, 1281, NULL, 0, 0, 0, 0, '2026-05-16 23:24:19', '2026-05-16 23:24:19'),
(3913, 25, 1152, NULL, 0, 20, 2, 18, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3914, 25, 1153, NULL, 0, 20, 0, 20, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3915, 25, 1154, NULL, 0, 20, 1, 19, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3916, 25, 1155, NULL, 0, 20, 2, 18, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3917, 25, 1156, NULL, 0, 20, 1, 19, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3918, 25, 1157, NULL, 0, 20, 0, 20, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3919, 25, 1158, NULL, 0, 20, 1, 19, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3920, 25, 1159, NULL, 0, 20, 2, 18, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3921, 25, 1160, NULL, 0, 20, 0, 20, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3922, 25, 1161, NULL, 0, 20, 0, 20, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3923, 25, 1162, NULL, 0, 20, 1, 19, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3924, 25, 1163, NULL, 0, 20, 0, 20, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3925, 25, 1164, NULL, 0, 20, 1, 19, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3926, 25, 1165, NULL, 0, 20, 2, 18, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3927, 25, 1166, NULL, 0, 20, 0, 20, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3928, 25, 1167, NULL, 0, 20, 0, 20, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3929, 25, 1168, NULL, 0, 20, 0, 20, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3930, 25, 1169, NULL, 0, 20, 1, 19, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3931, 25, 1170, NULL, 0, 20, 1, 19, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3932, 25, 1171, NULL, 0, 20, 0, 20, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3933, 25, 1172, NULL, 0, 20, 2, 18, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3934, 25, 1173, NULL, 0, 20, 2, 18, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3935, 25, 1174, NULL, 0, 20, 0, 20, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3936, 25, 1175, NULL, 0, 20, 1, 19, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3937, 25, 1176, NULL, 0, 20, 1, 19, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3938, 25, 1177, NULL, 0, 20, 2, 18, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3939, 25, 1178, NULL, 0, 20, 1, 19, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3940, 25, 1179, NULL, 0, 20, 0, 20, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3941, 25, 1180, NULL, 0, 20, 1, 19, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3942, 25, 1181, NULL, 0, 20, 0, 20, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3943, 25, 1182, NULL, 0, 20, 0, 20, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3944, 25, 1183, NULL, 0, 20, 0, 20, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3945, 25, 1184, NULL, 0, 20, 2, 18, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3946, 25, 1185, NULL, 0, 20, 1, 19, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3947, 25, 1186, NULL, 0, 20, 0, 20, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3948, 25, 1187, NULL, 0, 20, 0, 20, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3949, 25, 1188, NULL, 0, 20, 1, 19, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3950, 25, 1189, NULL, 0, 20, 2, 18, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3951, 25, 1190, NULL, 0, 20, 2, 18, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3952, 25, 1191, NULL, 0, 20, 1, 19, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3953, 25, 1192, NULL, 0, 20, 1, 19, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3954, 25, 1193, NULL, 0, 20, 0, 20, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3955, 25, 1194, NULL, 0, 20, 1, 19, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3956, 25, 1195, NULL, 0, 20, 2, 18, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3957, 25, 1196, NULL, 0, 20, 0, 20, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3958, 25, 1197, NULL, 0, 20, 0, 20, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3959, 25, 1198, NULL, 0, 20, 0, 20, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3960, 25, 1199, NULL, 0, 20, 1, 19, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3961, 25, 1200, NULL, 0, 20, 0, 20, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3962, 25, 1201, NULL, 0, 20, 2, 18, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3963, 25, 1202, NULL, 0, 20, 0, 20, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3964, 25, 1203, NULL, 0, 20, 1, 19, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3965, 25, 1204, NULL, 0, 20, 1, 19, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3966, 25, 1205, NULL, 0, 20, 0, 20, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3967, 25, 1206, NULL, 0, 20, 1, 19, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3968, 25, 1207, NULL, 0, 20, 2, 18, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3969, 25, 1208, NULL, 0, 20, 2, 18, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3970, 25, 1209, NULL, 0, 20, 1, 19, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3971, 25, 1210, NULL, 0, 20, 1, 19, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3972, 25, 1211, NULL, 0, 20, 3, 17, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3973, 25, 1212, NULL, 0, 20, 0, 20, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3974, 25, 1213, NULL, 0, 20, 0, 20, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3975, 25, 1214, NULL, 0, 20, 1, 19, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3976, 25, 1215, NULL, 0, 20, 0, 20, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3977, 25, 1216, NULL, 0, 20, 2, 18, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3978, 25, 1217, NULL, 0, 20, 0, 20, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3979, 25, 1218, NULL, 0, 20, 3, 17, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3980, 25, 1219, NULL, 0, 20, 1, 19, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3981, 25, 1220, NULL, 0, 20, 0, 20, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3982, 25, 1221, NULL, 0, 20, 2, 18, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3983, 25, 1222, NULL, 0, 20, 1, 19, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3984, 25, 1223, NULL, 0, 20, 0, 20, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3985, 25, 1224, NULL, 0, 20, 2, 18, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3986, 25, 1225, NULL, 0, 20, 0, 20, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3987, 25, 1226, NULL, 0, 20, 2, 18, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3988, 25, 1227, NULL, 0, 20, 0, 20, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3989, 25, 1228, NULL, 0, 20, 3, 17, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3990, 25, 1229, NULL, 0, 20, 1, 19, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3991, 25, 1230, NULL, 0, 20, 0, 20, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3992, 25, 1231, NULL, 0, 20, 2, 18, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3993, 25, 1232, NULL, 0, 20, 2, 18, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3994, 25, 1233, NULL, 0, 20, 0, 20, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3995, 25, 1234, NULL, 0, 20, 0, 20, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3996, 25, 1235, NULL, 0, 20, 1, 19, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3997, 25, 1236, NULL, 0, 20, 3, 17, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3998, 25, 1237, NULL, 0, 20, 0, 20, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(3999, 25, 1238, NULL, 0, 20, 2, 18, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(4000, 25, 1239, NULL, 0, 20, 1, 19, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(4001, 25, 1240, NULL, 0, 20, 0, 20, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(4002, 25, 1241, NULL, 0, 20, 1, 19, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(4003, 25, 1242, NULL, 0, 20, 2, 18, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(4004, 25, 1243, NULL, 0, 20, 1, 19, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(4005, 25, 1244, NULL, 0, 20, 3, 17, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(4006, 25, 1245, NULL, 0, 20, 2, 18, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(4007, 25, 1246, NULL, 0, 20, 1, 19, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(4008, 25, 1247, NULL, 0, 20, 0, 20, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(4009, 25, 1248, NULL, 0, 20, 2, 18, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(4010, 25, 1249, NULL, 0, 20, 2, 18, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(4011, 25, 1250, NULL, 0, 20, 0, 20, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(4012, 25, 1251, NULL, 0, 20, 3, 17, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(4013, 25, 1252, NULL, 0, 0, 0, 0, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(4014, 25, 1253, NULL, 0, 0, 0, 0, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(4015, 25, 1254, NULL, 0, 0, 0, 0, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(4016, 25, 1255, NULL, 0, 0, 0, 0, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(4017, 25, 1256, NULL, 0, 0, 0, 0, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(4018, 25, 1257, NULL, 0, 0, 0, 0, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(4019, 25, 1258, NULL, 0, 0, 0, 0, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(4020, 25, 1259, NULL, 0, 0, 0, 0, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(4021, 25, 1260, NULL, 0, 0, 0, 0, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(4022, 25, 1261, NULL, 0, 0, 0, 0, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(4023, 25, 1262, NULL, 0, 0, 0, 0, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(4024, 25, 1263, NULL, 0, 0, 0, 0, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(4025, 25, 1264, NULL, 0, 0, 0, 0, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(4026, 25, 1265, NULL, 0, 0, 0, 0, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(4027, 25, 1266, NULL, 0, 0, 0, 0, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(4028, 25, 1267, NULL, 0, 0, 0, 0, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(4029, 25, 1268, NULL, 0, 0, 0, 0, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(4030, 25, 1269, NULL, 0, 0, 0, 0, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(4031, 25, 1270, NULL, 0, 0, 0, 0, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(4032, 25, 1271, NULL, 0, 0, 0, 0, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(4033, 25, 1272, NULL, 0, 0, 0, 0, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(4034, 25, 1273, NULL, 0, 0, 0, 0, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(4035, 25, 1274, NULL, 0, 0, 0, 0, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(4036, 25, 1275, NULL, 0, 0, 0, 0, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(4037, 25, 1276, NULL, 0, 0, 0, 0, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(4038, 25, 1277, NULL, 0, 0, 0, 0, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(4039, 25, 1278, NULL, 0, 0, 0, 0, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(4040, 25, 1279, NULL, 0, 0, 0, 0, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(4041, 25, 1280, NULL, 0, 0, 0, 0, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(4042, 25, 1281, NULL, 0, 0, 0, 0, '2026-05-17 02:22:50', '2026-05-17 02:22:50'),
(4173, 26, 1152, NULL, 0, 20, 0, 20, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4174, 26, 1153, NULL, 0, 20, 1, 19, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4175, 26, 1154, NULL, 0, 20, 3, 17, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4176, 26, 1155, NULL, 0, 20, 0, 20, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4177, 26, 1156, NULL, 0, 20, 0, 20, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4178, 26, 1157, NULL, 0, 20, 2, 18, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4179, 26, 1158, NULL, 0, 20, 1, 19, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4180, 26, 1159, NULL, 0, 20, 0, 20, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4181, 26, 1160, NULL, 0, 20, 1, 19, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4182, 26, 1161, NULL, 0, 20, 2, 18, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4183, 26, 1162, NULL, 0, 20, 2, 18, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4184, 26, 1163, NULL, 0, 20, 0, 20, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4185, 26, 1164, NULL, 0, 20, 2, 18, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4186, 26, 1165, NULL, 0, 20, 0, 20, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4187, 26, 1166, NULL, 0, 20, 1, 19, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4188, 26, 1167, NULL, 0, 20, 3, 17, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4189, 26, 1168, NULL, 0, 20, 0, 20, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4190, 26, 1169, NULL, 0, 20, 2, 18, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4191, 26, 1170, NULL, 0, 20, 1, 19, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4192, 26, 1171, NULL, 0, 20, 1, 19, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4193, 26, 1172, NULL, 0, 20, 0, 20, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4194, 26, 1173, NULL, 0, 20, 2, 18, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4195, 26, 1174, NULL, 0, 20, 0, 20, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4196, 26, 1175, NULL, 0, 20, 2, 18, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4197, 26, 1176, NULL, 0, 20, -170, 190, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4198, 26, 1177, NULL, 0, 20, 2, 18, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4199, 26, 1178, NULL, 0, 20, 1, 19, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4200, 26, 1179, NULL, 0, 20, 0, 20, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4201, 26, 1180, NULL, 0, 20, 1, 19, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4202, 26, 1181, NULL, 0, 20, 3, 17, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4203, 26, 1182, NULL, 0, 20, 2, 18, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4204, 26, 1183, NULL, 0, 21, 4, 17, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4205, 26, 1184, NULL, 0, 20, 0, 20, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4206, 26, 1185, NULL, 0, 20, 1, 19, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4207, 26, 1186, NULL, 0, 20, 0, 20, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4208, 26, 1187, NULL, 0, 20, 2, 18, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4209, 26, 1188, NULL, 0, 20, 3, 17, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4210, 26, 1189, NULL, 0, 20, 1, 19, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4211, 26, 1190, NULL, 0, 20, 2, 18, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4212, 26, 1191, NULL, 0, 20, 0, 20, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4213, 26, 1192, NULL, 0, 20, 0, 20, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4214, 26, 1193, NULL, 0, 20, 2, 18, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4215, 26, 1194, NULL, 0, 20, 2, 18, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4216, 26, 1195, NULL, 0, 20, 1, 19, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4217, 26, 1196, NULL, 0, 20, 3, 17, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4218, 26, 1197, NULL, 0, 20, 3, 17, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4219, 26, 1198, NULL, 0, 20, 2, 18, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4220, 26, 1199, NULL, 0, 20, 1, 19, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4221, 26, 1200, NULL, 0, 20, 0, 20, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4222, 26, 1201, NULL, 0, 20, 3, 17, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4223, 26, 1202, NULL, 0, 20, 2, 18, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4224, 26, 1203, NULL, 0, 20, 1, 19, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4225, 26, 1204, NULL, 0, 20, 2, 18, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4226, 26, 1205, NULL, 0, 20, 2, 18, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4227, 26, 1206, NULL, 0, 20, 1, 19, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4228, 26, 1207, NULL, 0, 20, 0, 20, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4229, 26, 1208, NULL, 0, 20, 1, 19, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4230, 26, 1209, NULL, 0, 20, 0, 20, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4231, 26, 1210, NULL, 0, 20, 2, 18, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4232, 26, 1211, NULL, 0, 20, 4, 16, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4233, 26, 1212, NULL, 0, 20, 3, 17, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4234, 26, 1213, NULL, 0, 20, 3, 17, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4235, 26, 1214, NULL, 0, 20, 0, 20, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4236, 26, 1215, NULL, 0, 20, 2, 18, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4237, 26, 1216, NULL, 0, 20, 0, 20, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4238, 26, 1217, NULL, 0, 20, 2, 18, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4239, 26, 1218, NULL, 0, 20, 4, 16, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4240, 26, 1219, NULL, 0, 20, 0, 20, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4241, 26, 1220, NULL, 0, 20, 3, 17, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4242, 26, 1221, NULL, 0, 20, 1, 19, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4243, 26, 1222, NULL, 0, 20, 2, 18, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4244, 26, 1223, NULL, 0, 20, 1, 19, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4245, 26, 1224, NULL, 0, 20, 0, 20, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4246, 26, 1225, NULL, 0, 20, 1, 19, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4247, 26, 1226, NULL, 0, 20, 1, 19, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4248, 26, 1227, NULL, 0, 20, 2, 18, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4249, 26, 1228, NULL, 0, 20, 3, 17, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4250, 26, 1229, NULL, 0, 20, 2, 18, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4251, 26, 1230, NULL, 0, 20, 1, 19, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4252, 26, 1231, NULL, 0, 20, 3, 17, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4253, 26, 1232, NULL, 0, 20, 2, 18, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4254, 26, 1233, NULL, 0, 20, 2, 18, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4255, 26, 1234, NULL, 0, 20, 3, 17, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4256, 26, 1235, NULL, 0, 20, 2, 18, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4257, 26, 1236, NULL, 0, 20, 1, 19, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4258, 26, 1237, NULL, 0, 20, 0, 20, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4259, 26, 1238, NULL, 0, 20, 1, 19, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4260, 26, 1239, NULL, 0, 20, 2, 18, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4261, 26, 1240, NULL, 0, 20, 1, 19, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4262, 26, 1241, NULL, 0, 20, 8, 12, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4263, 26, 1242, NULL, 0, 20, 2, 18, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4264, 26, 1243, NULL, 0, 20, 0, 20, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4265, 26, 1244, NULL, 0, 20, 1, 19, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4266, 26, 1245, NULL, 0, 20, 2, 18, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4267, 26, 1246, NULL, 0, 20, 2, 18, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4268, 26, 1247, NULL, 0, 20, 0, 20, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4269, 26, 1248, NULL, 0, 20, 1, 19, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4270, 26, 1249, NULL, 0, 20, 3, 17, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4271, 26, 1250, NULL, 0, 20, 3, 17, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4272, 26, 1251, NULL, 0, 20, 3, 17, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4273, 26, 1252, NULL, 0, 0, 0, 0, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4274, 26, 1253, NULL, 0, 0, 0, 0, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4275, 26, 1254, NULL, 0, 0, 0, 0, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4276, 26, 1255, NULL, 0, 0, 0, 0, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4277, 26, 1256, NULL, 0, 0, 0, 0, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4278, 26, 1257, NULL, 0, 0, 0, 0, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4279, 26, 1258, NULL, 0, 0, 0, 0, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4280, 26, 1259, NULL, 0, 0, 0, 0, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4281, 26, 1260, NULL, 0, 0, 0, 0, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4282, 26, 1261, NULL, 0, 0, 0, 0, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4283, 26, 1262, NULL, 0, 0, 0, 0, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4284, 26, 1263, NULL, 0, 0, 0, 0, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4285, 26, 1264, NULL, 0, 0, 0, 0, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4286, 26, 1265, NULL, 0, 0, 0, 0, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4287, 26, 1266, NULL, 0, 0, 0, 0, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4288, 26, 1267, NULL, 0, 0, 0, 0, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4289, 26, 1268, NULL, 0, 0, 0, 0, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4290, 26, 1269, NULL, 0, 0, 0, 0, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4291, 26, 1270, NULL, 0, 0, 0, 0, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4292, 26, 1271, NULL, 0, 0, 0, 0, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4293, 26, 1272, NULL, 0, 0, 0, 0, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4294, 26, 1273, NULL, 0, 0, 0, 0, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4295, 26, 1274, NULL, 0, 0, 0, 0, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4296, 26, 1275, NULL, 0, 0, 0, 0, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4297, 26, 1276, NULL, 0, 0, 0, 0, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4298, 26, 1277, NULL, 0, 0, 0, 0, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4299, 26, 1278, NULL, 0, 0, 0, 0, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4300, 26, 1279, NULL, 0, 0, 0, 0, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4301, 26, 1280, NULL, 0, 0, 0, 0, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4302, 26, 1281, NULL, 0, 0, 0, 0, '2026-05-17 03:20:53', '2026-05-17 03:20:53'),
(4433, 27, 1152, NULL, 0, 20, 0, 20, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4434, 27, 1153, NULL, 0, 20, 1, 19, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4435, 27, 1154, NULL, 0, 20, 0, 20, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4436, 27, 1155, NULL, 0, 20, 0, 20, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4437, 27, 1156, NULL, 0, 20, 0, 20, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4438, 27, 1157, NULL, 0, 20, 2, 18, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4439, 27, 1158, NULL, 0, 20, 1, 19, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4440, 27, 1159, NULL, 0, 20, 0, 20, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4441, 27, 1160, NULL, 0, 20, 1, 19, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4442, 27, 1161, NULL, 0, 20, 2, 18, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4443, 27, 1162, NULL, 0, 20, 0, 20, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4444, 27, 1163, NULL, 0, 20, 0, 20, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4445, 27, 1164, NULL, 0, 20, 2, 18, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4446, 27, 1165, NULL, 0, 20, 5, 15, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4447, 27, 1166, NULL, 0, 20, 1, 19, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4448, 27, 1167, NULL, 0, 20, 0, 20, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4449, 27, 1168, NULL, 0, 20, 0, 20, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4450, 27, 1169, NULL, 0, 20, 2, 18, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4451, 27, 1170, NULL, 0, 20, 0, 20, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4452, 27, 1171, NULL, 0, 20, 1, 19, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4453, 27, 1172, NULL, 0, 20, 0, 20, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4454, 27, 1173, NULL, 0, 20, 2, 18, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4455, 27, 1174, NULL, 0, 20, 0, 20, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4456, 27, 1175, NULL, 0, 20, 2, 18, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4457, 27, 1176, NULL, 0, 20, 1, 19, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4458, 27, 1177, NULL, 0, 20, 2, 18, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4459, 27, 1178, NULL, 0, 20, 5, 15, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4460, 27, 1179, NULL, 0, 20, 0, 20, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4461, 27, 1180, NULL, 0, 20, 1, 19, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4462, 27, 1181, NULL, 0, 20, 0, 20, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4463, 27, 1182, NULL, 0, 20, 2, 18, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4464, 27, 1183, NULL, 0, 20, 0, 20, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4465, 27, 1184, NULL, 0, 20, 0, 20, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4466, 27, 1185, NULL, 0, 20, 1, 19, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4467, 27, 1186, NULL, 0, 20, 0, 20, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4468, 27, 1187, NULL, 0, 20, 2, 18, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4469, 27, 1188, NULL, 0, 20, 0, 20, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4470, 27, 1189, NULL, 0, 20, 1, 19, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4471, 27, 1190, NULL, 0, 20, 2, 18, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4472, 27, 1191, NULL, 0, 20, 0, 20, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4473, 27, 1192, NULL, 0, 20, 0, 20, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4474, 27, 1193, NULL, 0, 20, 2, 18, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4475, 27, 1194, NULL, 0, 20, 2, 18, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4476, 27, 1195, NULL, 0, 20, 1, 19, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4477, 27, 1196, NULL, 0, 20, 3, 17, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4478, 27, 1197, NULL, 0, 20, 3, 17, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4479, 27, 1198, NULL, 0, 20, 0, 20, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4480, 27, 1199, NULL, 0, 20, 1, 19, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4481, 27, 1200, NULL, 0, 20, 0, 20, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4482, 27, 1201, NULL, 0, 20, 3, 17, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4483, 27, 1202, NULL, 0, 20, 2, 18, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4484, 27, 1203, NULL, 0, 20, 1, 19, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4485, 27, 1204, NULL, 0, 20, 2, 18, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4486, 27, 1205, NULL, 0, 20, 0, 20, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4487, 27, 1206, NULL, 0, 20, 1, 19, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4488, 27, 1207, NULL, 0, 20, 0, 20, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4489, 27, 1208, NULL, 0, 20, 0, 20, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4490, 27, 1209, NULL, 0, 20, 5, 15, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4491, 27, 1210, NULL, 0, 20, 2, 18, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4492, 27, 1211, NULL, 0, 20, 20, 0, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4493, 27, 1212, NULL, 0, 20, 3, 17, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4494, 27, 1213, NULL, 0, 20, 3, 17, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4495, 27, 1214, NULL, 0, 20, 3, 17, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4496, 27, 1215, NULL, 0, 20, 2, 18, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4497, 27, 1216, NULL, 0, 20, 0, 20, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4498, 27, 1217, NULL, 0, 20, 2, 18, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4499, 27, 1218, NULL, 0, 20, 4, 16, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4500, 27, 1219, NULL, 0, 20, 0, 20, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4501, 27, 1220, NULL, 0, 20, 0, 20, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4502, 27, 1221, NULL, 0, 20, 1, 19, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4503, 27, 1222, NULL, 0, 20, 2, 18, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4504, 27, 1223, NULL, 0, 20, 1, 19, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4505, 27, 1224, NULL, 0, 20, 0, 20, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4506, 27, 1225, NULL, 0, 20, 0, 20, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4507, 27, 1226, NULL, 0, 20, 1, 19, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4508, 27, 1227, NULL, 0, 20, 0, 20, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4509, 27, 1228, NULL, 0, 20, 3, 17, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4510, 27, 1229, NULL, 0, 20, 2, 18, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4511, 27, 1230, NULL, 0, 20, 1, 19, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4512, 27, 1231, NULL, 0, 20, 0, 20, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4513, 27, 1232, NULL, 0, 20, 2, 18, '2026-05-17 04:16:34', '2026-05-17 04:16:34');
INSERT INTO `trampa_roedor_seguimientos` (`id`, `seguimiento_id`, `trampa_id`, `observacion`, `cantidad`, `inicial`, `merma`, `actual`, `created_at`, `updated_at`) VALUES
(4514, 27, 1233, NULL, 0, 20, 2, 18, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4515, 27, 1234, NULL, 0, 20, 3, 17, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4516, 27, 1235, NULL, 0, 20, 2, 18, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4517, 27, 1236, NULL, 0, 20, 0, 20, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4518, 27, 1237, NULL, 0, 20, 4, 16, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4519, 27, 1238, NULL, 0, 20, 1, 19, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4520, 27, 1239, NULL, 0, 20, 1, 19, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4521, 27, 1240, NULL, 0, 20, 1, 19, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4522, 27, 1241, NULL, 0, 20, 0, 20, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4523, 27, 1242, NULL, 0, 20, 2, 18, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4524, 27, 1243, NULL, 0, 20, 0, 20, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4525, 27, 1244, NULL, 0, 20, 1, 19, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4526, 27, 1245, NULL, 0, 20, 1, 19, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4527, 27, 1246, NULL, 0, 20, 1, 19, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4528, 27, 1247, NULL, 0, 20, 0, 20, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4529, 27, 1248, NULL, 0, 20, 0, 20, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4530, 27, 1249, NULL, 0, 20, 0, 20, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4531, 27, 1250, NULL, 0, 20, 0, 20, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4532, 27, 1251, NULL, 0, 20, 0, 20, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4533, 27, 1252, NULL, 0, 0, 0, 0, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4534, 27, 1253, NULL, 0, 0, 0, 0, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4535, 27, 1254, NULL, 0, 0, 0, 0, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4536, 27, 1255, NULL, 0, 0, 0, 0, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4537, 27, 1256, NULL, 0, 0, 0, 0, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4538, 27, 1257, NULL, 0, 0, 0, 0, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4539, 27, 1258, NULL, 0, 0, 0, 0, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4540, 27, 1259, NULL, 0, 0, 0, 0, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4541, 27, 1260, NULL, 0, 0, 0, 0, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4542, 27, 1261, NULL, 0, 0, 0, 0, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4543, 27, 1262, NULL, 0, 0, 0, 0, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4544, 27, 1263, NULL, 0, 0, 0, 0, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4545, 27, 1264, NULL, 0, 0, 0, 0, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4546, 27, 1265, NULL, 0, 0, 0, 0, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4547, 27, 1266, NULL, 0, 0, 0, 0, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4548, 27, 1267, NULL, 0, 0, 0, 0, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4549, 27, 1268, NULL, 0, 0, 0, 0, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4550, 27, 1269, NULL, 0, 0, 0, 0, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4551, 27, 1270, NULL, 0, 0, 0, 0, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4552, 27, 1271, NULL, 0, 0, 0, 0, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4553, 27, 1272, NULL, 0, 0, 0, 0, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4554, 27, 1273, NULL, 0, 0, 0, 0, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4555, 27, 1274, NULL, 0, 0, 0, 0, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4556, 27, 1275, NULL, 0, 0, 0, 0, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4557, 27, 1276, NULL, 0, 0, 0, 0, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4558, 27, 1277, NULL, 0, 0, 0, 0, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4559, 27, 1278, NULL, 0, 0, 0, 0, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4560, 27, 1279, NULL, 0, 0, 0, 0, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4561, 27, 1280, NULL, 0, 0, 0, 0, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4562, 27, 1281, NULL, 0, 0, 0, 0, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
(4693, 28, 1152, NULL, 0, 20, 0, 20, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4694, 28, 1153, NULL, 0, 20, 0, 20, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4695, 28, 1154, NULL, 0, 20, 1, 19, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4696, 28, 1155, NULL, 0, 20, 2, 18, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4697, 28, 1156, NULL, 0, 20, 1, 19, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4698, 28, 1157, NULL, 0, 20, 0, 20, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4699, 28, 1158, NULL, 0, 20, 1, 19, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4700, 28, 1159, NULL, 0, 20, 2, 18, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4701, 28, 1160, NULL, 0, 20, 0, 20, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4702, 28, 1161, NULL, 0, 20, 0, 20, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4703, 28, 1162, NULL, 0, 20, 1, 19, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4704, 28, 1163, NULL, 0, 20, 0, 20, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4705, 28, 1164, NULL, 0, 20, 1, 19, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4706, 28, 1165, NULL, 0, 20, 2, 18, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4707, 28, 1166, NULL, 0, 20, 0, 20, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4708, 28, 1167, NULL, 0, 20, 0, 20, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4709, 28, 1168, NULL, 0, 20, 0, 20, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4710, 28, 1169, NULL, 0, 20, 1, 19, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4711, 28, 1170, NULL, 0, 20, 0, 20, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4712, 28, 1171, NULL, 0, 20, 0, 20, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4713, 28, 1172, NULL, 0, 20, 0, 20, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4714, 28, 1173, NULL, 0, 20, 2, 18, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4715, 28, 1174, NULL, 0, 20, -2, 22, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4716, 28, 1175, NULL, 0, 20, 1, 19, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4717, 28, 1176, NULL, 0, 20, 1, 19, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4718, 28, 1177, NULL, 0, 20, 2, 18, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4719, 28, 1178, NULL, 0, 20, 1, 19, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4720, 28, 1179, NULL, 0, 20, 0, 20, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4721, 28, 1180, NULL, 0, 20, 1, 19, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4722, 28, 1181, NULL, 0, 20, 0, 20, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4723, 28, 1182, NULL, 0, 20, 0, 20, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4724, 28, 1183, NULL, 0, 20, 0, 20, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4725, 28, 1184, NULL, 0, 20, 0, 20, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4726, 28, 1185, NULL, 0, 20, 1, 19, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4727, 28, 1186, NULL, 0, 20, 0, 20, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4728, 28, 1187, NULL, 0, 20, 0, 20, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4729, 28, 1188, NULL, 0, 20, 1, 19, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4730, 28, 1189, NULL, 0, 20, 1, 19, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4731, 28, 1190, NULL, 0, 20, 2, 18, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4732, 28, 1191, NULL, 0, 20, 0, 20, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4733, 28, 1192, NULL, 0, 20, 1, 19, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4734, 28, 1193, NULL, 0, 20, 0, 20, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4735, 28, 1194, NULL, 0, 20, 1, 19, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4736, 28, 1195, NULL, 0, 20, 2, 18, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4737, 28, 1196, NULL, 0, 20, 0, 20, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4738, 28, 1197, NULL, 0, 20, 0, 20, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4739, 28, 1198, NULL, 0, 20, 0, 20, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4740, 28, 1199, NULL, 0, 20, 1, 19, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4741, 28, 1200, NULL, 0, 20, 0, 20, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4742, 28, 1201, NULL, 0, 20, 0, 20, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4743, 28, 1202, NULL, 0, 20, 0, 20, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4744, 28, 1203, NULL, 0, 20, 1, 19, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4745, 28, 1204, NULL, 0, 20, 1, 19, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4746, 28, 1205, NULL, 0, 20, 0, 20, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4747, 28, 1206, NULL, 0, 20, 0, 20, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4748, 28, 1207, NULL, 0, 20, 0, 20, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4749, 28, 1208, NULL, 0, 20, 2, 18, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4750, 28, 1209, NULL, 0, 20, 1, 19, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4751, 28, 1210, NULL, 0, 20, 1, 19, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4752, 28, 1211, NULL, 0, 20, 3, 17, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4753, 28, 1212, NULL, 0, 20, 0, 20, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4754, 28, 1213, NULL, 0, 20, 0, 20, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4755, 28, 1214, NULL, 0, 20, 1, 19, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4756, 28, 1215, NULL, 0, 20, 0, 20, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4757, 28, 1216, NULL, 0, 20, 2, 18, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4758, 28, 1217, NULL, 0, 20, 0, 20, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4759, 28, 1218, NULL, 0, 20, 3, 17, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4760, 28, 1219, NULL, 0, 20, 1, 19, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4761, 28, 1220, NULL, 0, 20, 0, 20, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4762, 28, 1221, NULL, 0, 20, 2, 18, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4763, 28, 1222, NULL, 0, 20, 1, 19, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4764, 28, 1223, NULL, 0, 20, 0, 20, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4765, 28, 1224, NULL, 0, 20, 1, 19, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4766, 28, 1225, NULL, 0, 20, 0, 20, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4767, 28, 1226, NULL, 0, 20, 2, 18, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4768, 28, 1227, NULL, 0, 20, 0, 20, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4769, 28, 1228, NULL, 0, 20, 3, 17, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4770, 28, 1229, NULL, 0, 20, 1, 19, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4771, 28, 1230, NULL, 0, 20, 0, 20, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4772, 28, 1231, NULL, 0, 20, 2, 18, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4773, 28, 1232, NULL, 0, 20, 2, 18, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4774, 28, 1233, NULL, 0, 20, 0, 20, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4775, 28, 1234, NULL, 0, 20, 0, 20, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4776, 28, 1235, NULL, 0, 20, 1, 19, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4777, 28, 1236, NULL, 0, 20, 3, 17, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4778, 28, 1237, NULL, 0, 20, 5, 15, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4779, 28, 1238, NULL, 0, 20, 2, 18, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4780, 28, 1239, NULL, 0, 20, 1, 19, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4781, 28, 1240, NULL, 0, 20, 0, 20, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4782, 28, 1241, NULL, 0, 20, 1, 19, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4783, 28, 1242, NULL, 0, 20, 2, 18, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4784, 28, 1243, NULL, 0, 20, 0, 20, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4785, 28, 1244, NULL, 0, 20, 3, 17, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4786, 28, 1245, NULL, 0, 20, 2, 18, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4787, 28, 1246, NULL, 0, 20, 1, 19, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4788, 28, 1247, NULL, 0, 20, 0, 20, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4789, 28, 1248, NULL, 0, 20, 3, 17, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4790, 28, 1249, NULL, 0, 20, 3, 17, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4791, 28, 1250, NULL, 0, 20, 0, 20, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4792, 28, 1251, NULL, 0, 20, 3, 17, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4793, 28, 1252, NULL, 0, 0, 0, 0, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4794, 28, 1253, NULL, 0, 0, 0, 0, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4795, 28, 1254, NULL, 0, 0, 0, 0, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4796, 28, 1255, NULL, 0, 0, 0, 0, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4797, 28, 1256, NULL, 0, 0, 0, 0, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4798, 28, 1257, NULL, 0, 0, 0, 0, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4799, 28, 1258, NULL, 0, 0, 0, 0, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4800, 28, 1259, NULL, 0, 0, 0, 0, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4801, 28, 1260, NULL, 0, 0, 0, 0, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4802, 28, 1261, NULL, 0, 0, 0, 0, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4803, 28, 1262, NULL, 0, 0, 0, 0, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4804, 28, 1263, NULL, 0, 0, 0, 0, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4805, 28, 1264, NULL, 0, 0, 0, 0, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4806, 28, 1265, NULL, 0, 0, 0, 0, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4807, 28, 1266, NULL, 0, 0, 0, 0, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4808, 28, 1267, NULL, 0, 0, 0, 0, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4809, 28, 1268, NULL, 0, 0, 0, 0, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4810, 28, 1269, NULL, 0, 0, 0, 0, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4811, 28, 1270, NULL, 0, 0, 0, 0, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4812, 28, 1271, NULL, 0, 0, 0, 0, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4813, 28, 1272, NULL, 0, 0, 0, 0, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4814, 28, 1273, NULL, 0, 0, 0, 0, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4815, 28, 1274, NULL, 0, 0, 0, 0, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4816, 28, 1275, NULL, 0, 0, 0, 0, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4817, 28, 1276, NULL, 0, 0, 0, 0, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4818, 28, 1277, NULL, 0, 0, 0, 0, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4819, 28, 1278, NULL, 0, 0, 0, 0, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4820, 28, 1279, NULL, 0, 0, 0, 0, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4821, 28, 1280, NULL, 0, 0, 0, 0, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4822, 28, 1281, NULL, 0, 0, 0, 0, '2026-05-17 04:42:08', '2026-05-17 04:42:08'),
(4953, 29, 1340, NULL, 0, 20, 0, 20, '2026-05-18 14:55:42', '2026-05-18 14:55:42'),
(4954, 29, 1341, NULL, 0, 20, 0, 20, '2026-05-18 14:55:42', '2026-05-18 14:55:42'),
(4955, 29, 1342, NULL, 0, 20, 0, 20, '2026-05-18 14:55:42', '2026-05-18 14:55:42'),
(4956, 29, 1343, NULL, 0, 20, 1, 19, '2026-05-18 14:55:42', '2026-05-18 14:55:42'),
(4957, 29, 1344, NULL, 0, 20, 2, 18, '2026-05-18 14:55:42', '2026-05-18 14:55:42'),
(4958, 29, 1345, NULL, 0, 20, 1, 19, '2026-05-18 14:55:42', '2026-05-18 14:55:42'),
(4959, 29, 1346, NULL, 0, 20, 2, 18, '2026-05-18 14:55:42', '2026-05-18 14:55:42'),
(4960, 29, 1347, NULL, 0, 20, 1, 19, '2026-05-18 14:55:42', '2026-05-18 14:55:42'),
(4961, 29, 1348, NULL, 0, 20, 0, 20, '2026-05-18 14:55:42', '2026-05-18 14:55:42'),
(4962, 29, 1349, NULL, 0, 20, 2, 18, '2026-05-18 14:55:42', '2026-05-18 14:55:42'),
(4963, 29, 1350, NULL, 0, 20, 1, 19, '2026-05-18 14:55:42', '2026-05-18 14:55:42'),
(4964, 29, 1351, NULL, 0, 20, 0, 20, '2026-05-18 14:55:42', '2026-05-18 14:55:42'),
(4965, 29, 1352, NULL, 0, 20, 1, 19, '2026-05-18 14:55:42', '2026-05-18 14:55:42'),
(4966, 29, 1353, NULL, 0, 20, 2, 18, '2026-05-18 14:55:42', '2026-05-18 14:55:42'),
(4967, 29, 1354, NULL, 0, 20, 0, 20, '2026-05-18 14:55:42', '2026-05-18 14:55:42'),
(4968, 29, 1355, NULL, 0, 20, 0, 20, '2026-05-18 14:55:42', '2026-05-18 14:55:42'),
(4969, 29, 1356, NULL, 0, 20, 0, 20, '2026-05-18 14:55:42', '2026-05-18 14:55:42'),
(4970, 29, 1357, NULL, 0, 20, 1, 19, '2026-05-18 14:55:42', '2026-05-18 14:55:42'),
(4971, 29, 1358, NULL, 0, 20, 0, 20, '2026-05-18 14:55:42', '2026-05-18 14:55:42'),
(4972, 29, 1359, NULL, 0, 20, 2, 18, '2026-05-18 14:55:42', '2026-05-18 14:55:42'),
(4973, 29, 1360, NULL, 0, 20, 0, 20, '2026-05-18 14:55:42', '2026-05-18 14:55:42'),
(4974, 29, 1361, NULL, 0, 20, 0, 20, '2026-05-18 14:55:42', '2026-05-18 14:55:42'),
(4975, 29, 1362, NULL, 0, 20, 2, 18, '2026-05-18 14:55:42', '2026-05-18 14:55:42'),
(4976, 29, 1363, NULL, 0, 20, 1, 19, '2026-05-18 14:55:42', '2026-05-18 14:55:42'),
(4977, 29, 1364, NULL, 0, 20, 1, 19, '2026-05-18 14:55:42', '2026-05-18 14:55:42'),
(4978, 29, 1365, NULL, 0, 20, 0, 20, '2026-05-18 14:55:42', '2026-05-18 14:55:42'),
(4979, 29, 1366, NULL, 0, 0, 0, 0, '2026-05-18 14:55:42', '2026-05-18 14:55:42'),
(4980, 29, 1367, NULL, 0, 0, 0, 0, '2026-05-18 14:55:42', '2026-05-18 14:55:42'),
(4981, 29, 1368, NULL, 0, 0, 0, 0, '2026-05-18 14:55:42', '2026-05-18 14:55:42'),
(4982, 29, 1369, NULL, 0, 0, 0, 0, '2026-05-18 14:55:42', '2026-05-18 14:55:42'),
(4983, 29, 1394, NULL, 0, 20, 0, 20, '2026-05-18 14:55:42', '2026-05-18 14:55:42'),
(4984, 29, 1395, NULL, 0, 20, 1, 19, '2026-05-18 14:55:42', '2026-05-18 14:55:42'),
(4985, 29, 1396, NULL, 0, 20, 0, 20, '2026-05-18 14:55:42', '2026-05-18 14:55:42'),
(4986, 29, 1397, NULL, 0, 20, 0, 20, '2026-05-18 14:55:42', '2026-05-18 14:55:42'),
(4987, 29, 1398, NULL, 0, 20, 0, 20, '2026-05-18 14:55:42', '2026-05-18 14:55:42'),
(4988, 29, 1399, NULL, 0, 20, 2, 18, '2026-05-18 14:55:42', '2026-05-18 14:55:42'),
(4989, 29, 1400, NULL, 0, 20, 0, 20, '2026-05-18 14:55:42', '2026-05-18 14:55:42'),
(4990, 29, 1401, NULL, 0, 20, 1, 19, '2026-05-18 14:55:42', '2026-05-18 14:55:42'),
(4991, 29, 1402, NULL, 0, 20, 0, 20, '2026-05-18 14:55:42', '2026-05-18 14:55:42'),
(4992, 29, 1403, NULL, 0, 20, 0, 20, '2026-05-18 14:55:42', '2026-05-18 14:55:42'),
(4993, 29, 1404, NULL, 0, 20, 0, 20, '2026-05-18 14:55:42', '2026-05-18 14:55:42'),
(4994, 29, 1405, NULL, 0, 20, 0, 20, '2026-05-18 14:55:42', '2026-05-18 14:55:42'),
(4995, 30, 1340, NULL, 0, 20, 0, 20, '2026-05-18 15:56:33', '2026-05-18 15:56:33'),
(4996, 30, 1341, NULL, 0, 20, 2, 18, '2026-05-18 15:56:33', '2026-05-18 15:56:33'),
(4997, 30, 1342, NULL, 0, 20, 1, 19, '2026-05-18 15:56:33', '2026-05-18 15:56:33'),
(4998, 30, 1343, NULL, 0, 20, 1, 19, '2026-05-18 15:56:33', '2026-05-18 15:56:33'),
(4999, 30, 1344, NULL, 0, 20, 3, 17, '2026-05-18 15:56:33', '2026-05-18 15:56:33'),
(5000, 30, 1345, NULL, 0, 20, 2, 18, '2026-05-18 15:56:33', '2026-05-18 15:56:33'),
(5001, 30, 1346, NULL, 0, 20, 1, 19, '2026-05-18 15:56:33', '2026-05-18 15:56:33'),
(5002, 30, 1347, NULL, 0, 20, 2, 18, '2026-05-18 15:56:33', '2026-05-18 15:56:33'),
(5003, 30, 1348, NULL, 0, 20, 0, 20, '2026-05-18 15:56:33', '2026-05-18 15:56:33'),
(5004, 30, 1349, NULL, 0, 20, 0, 20, '2026-05-18 15:56:33', '2026-05-18 15:56:33'),
(5005, 30, 1350, NULL, 0, 20, 0, 20, '2026-05-18 15:56:33', '2026-05-18 15:56:33'),
(5006, 30, 1351, NULL, 0, 20, 2, 18, '2026-05-18 15:56:33', '2026-05-18 15:56:33'),
(5007, 30, 1352, NULL, 0, 20, 1, 19, '2026-05-18 15:56:33', '2026-05-18 15:56:33'),
(5008, 30, 1353, NULL, 0, 20, 3, 17, '2026-05-18 15:56:33', '2026-05-18 15:56:33'),
(5009, 30, 1354, NULL, 0, 20, 0, 20, '2026-05-18 15:56:33', '2026-05-18 15:56:33'),
(5010, 30, 1355, NULL, 0, 20, 1, 19, '2026-05-18 15:56:33', '2026-05-18 15:56:33'),
(5011, 30, 1356, NULL, 0, 20, 2, 18, '2026-05-18 15:56:33', '2026-05-18 15:56:33'),
(5012, 30, 1357, NULL, 0, 20, 3, 17, '2026-05-18 15:56:33', '2026-05-18 15:56:33'),
(5013, 30, 1358, NULL, 0, 20, 0, 20, '2026-05-18 15:56:33', '2026-05-18 15:56:33'),
(5014, 30, 1359, NULL, 0, 20, 0, 20, '2026-05-18 15:56:33', '2026-05-18 15:56:33'),
(5015, 30, 1360, NULL, 0, 20, 0, 20, '2026-05-18 15:56:33', '2026-05-18 15:56:33'),
(5016, 30, 1361, NULL, 0, 20, 0, 20, '2026-05-18 15:56:33', '2026-05-18 15:56:33'),
(5017, 30, 1362, NULL, 0, 20, 1, 19, '2026-05-18 15:56:33', '2026-05-18 15:56:33'),
(5018, 30, 1363, NULL, 0, 20, 2, 18, '2026-05-18 15:56:33', '2026-05-18 15:56:33'),
(5019, 30, 1364, NULL, 0, 20, 0, 20, '2026-05-18 15:56:33', '2026-05-18 15:56:33'),
(5020, 30, 1365, NULL, 0, 20, 0, 20, '2026-05-18 15:56:33', '2026-05-18 15:56:33'),
(5021, 30, 1366, NULL, 0, 0, 0, 0, '2026-05-18 15:56:33', '2026-05-18 15:56:33'),
(5022, 30, 1367, NULL, 0, 0, 0, 0, '2026-05-18 15:56:33', '2026-05-18 15:56:33'),
(5023, 30, 1368, NULL, 0, 0, 0, 0, '2026-05-18 15:56:33', '2026-05-18 15:56:33'),
(5024, 30, 1369, NULL, 0, 0, 0, 0, '2026-05-18 15:56:33', '2026-05-18 15:56:33'),
(5025, 30, 1394, NULL, 0, 20, 0, 20, '2026-05-18 15:56:33', '2026-05-18 15:56:33'),
(5026, 30, 1395, NULL, 0, 20, 1, 19, '2026-05-18 15:56:33', '2026-05-18 15:56:33'),
(5027, 30, 1396, NULL, 0, 20, 2, 18, '2026-05-18 15:56:33', '2026-05-18 15:56:33'),
(5028, 30, 1397, NULL, 0, 20, 0, 20, '2026-05-18 15:56:33', '2026-05-18 15:56:33'),
(5029, 30, 1398, NULL, 0, 20, 1, 19, '2026-05-18 15:56:33', '2026-05-18 15:56:33'),
(5030, 30, 1399, NULL, 0, 20, 2, 18, '2026-05-18 15:56:33', '2026-05-18 15:56:33'),
(5031, 30, 1400, NULL, 0, 20, 0, 20, '2026-05-18 15:56:33', '2026-05-18 15:56:33'),
(5032, 30, 1401, NULL, 0, 20, 1, 19, '2026-05-18 15:56:33', '2026-05-18 15:56:33'),
(5033, 30, 1402, NULL, 0, 20, 0, 20, '2026-05-18 15:56:33', '2026-05-18 15:56:33'),
(5034, 30, 1403, NULL, 0, 20, 2, 18, '2026-05-18 15:56:33', '2026-05-18 15:56:33'),
(5035, 30, 1404, NULL, 0, 20, 0, 20, '2026-05-18 15:56:33', '2026-05-18 15:56:33'),
(5036, 30, 1405, NULL, 0, 20, 0, 20, '2026-05-18 15:56:33', '2026-05-18 15:56:33'),
(5037, 31, 1340, NULL, 0, 20, 0, 20, '2026-05-18 16:34:39', '2026-05-18 16:34:39'),
(5038, 31, 1341, NULL, 0, 20, 2, 18, '2026-05-18 16:34:39', '2026-05-18 16:34:39'),
(5039, 31, 1342, NULL, 0, 20, 0, 20, '2026-05-18 16:34:39', '2026-05-18 16:34:39'),
(5040, 31, 1343, NULL, 0, 20, 1, 19, '2026-05-18 16:34:39', '2026-05-18 16:34:39'),
(5041, 31, 1344, NULL, 0, 20, 2, 18, '2026-05-18 16:34:39', '2026-05-18 16:34:39'),
(5042, 31, 1345, NULL, 0, 20, 2, 18, '2026-05-18 16:34:39', '2026-05-18 16:34:39'),
(5043, 31, 1346, NULL, 0, 20, 0, 20, '2026-05-18 16:34:39', '2026-05-18 16:34:39'),
(5044, 31, 1347, NULL, 0, 20, 2, 18, '2026-05-18 16:34:39', '2026-05-18 16:34:39'),
(5045, 31, 1348, NULL, 0, 20, 0, 20, '2026-05-18 16:34:39', '2026-05-18 16:34:39'),
(5046, 31, 1349, NULL, 0, 20, 0, 20, '2026-05-18 16:34:39', '2026-05-18 16:34:39'),
(5047, 31, 1350, NULL, 0, 20, 0, 20, '2026-05-18 16:34:39', '2026-05-18 16:34:39'),
(5048, 31, 1351, NULL, 0, 20, 2, 18, '2026-05-18 16:34:39', '2026-05-18 16:34:39'),
(5049, 31, 1352, NULL, 0, 20, 0, 20, '2026-05-18 16:34:39', '2026-05-18 16:34:39'),
(5050, 31, 1353, NULL, 0, 20, 3, 17, '2026-05-18 16:34:39', '2026-05-18 16:34:39'),
(5051, 31, 1354, NULL, 0, 20, 0, 20, '2026-05-18 16:34:39', '2026-05-18 16:34:39'),
(5052, 31, 1355, NULL, 0, 20, 1, 19, '2026-05-18 16:34:39', '2026-05-18 16:34:39'),
(5053, 31, 1356, NULL, 0, 20, 3, 17, '2026-05-18 16:34:39', '2026-05-18 16:34:39'),
(5054, 31, 1357, NULL, 0, 20, 3, 17, '2026-05-18 16:34:39', '2026-05-18 16:34:39'),
(5055, 31, 1358, NULL, 0, 20, 0, 20, '2026-05-18 16:34:39', '2026-05-18 16:34:39'),
(5056, 31, 1359, NULL, 0, 20, 1, 19, '2026-05-18 16:34:39', '2026-05-18 16:34:39'),
(5057, 31, 1360, NULL, 0, 20, 0, 20, '2026-05-18 16:34:39', '2026-05-18 16:34:39'),
(5058, 31, 1361, NULL, 0, 20, 2, 18, '2026-05-18 16:34:39', '2026-05-18 16:34:39'),
(5059, 31, 1362, NULL, 0, 20, 1, 19, '2026-05-18 16:34:39', '2026-05-18 16:34:39'),
(5060, 31, 1363, NULL, 0, 20, 0, 20, '2026-05-18 16:34:39', '2026-05-18 16:34:39'),
(5061, 31, 1364, NULL, 0, 20, 2, 18, '2026-05-18 16:34:39', '2026-05-18 16:34:39'),
(5062, 31, 1365, NULL, 0, 20, 3, 17, '2026-05-18 16:34:39', '2026-05-18 16:34:39'),
(5063, 31, 1366, NULL, 0, 0, 0, 0, '2026-05-18 16:34:39', '2026-05-18 16:34:39'),
(5064, 31, 1367, NULL, 0, 0, 0, 0, '2026-05-18 16:34:39', '2026-05-18 16:34:39'),
(5065, 31, 1368, NULL, 0, 0, 0, 0, '2026-05-18 16:34:39', '2026-05-18 16:34:39'),
(5066, 31, 1369, NULL, 0, 0, 0, 0, '2026-05-18 16:34:39', '2026-05-18 16:34:39'),
(5067, 31, 1394, NULL, 0, 20, 0, 20, '2026-05-18 16:34:39', '2026-05-18 16:34:39'),
(5068, 31, 1395, NULL, 0, 20, 1, 19, '2026-05-18 16:34:39', '2026-05-18 16:34:39'),
(5069, 31, 1396, NULL, 0, 20, 2, 18, '2026-05-18 16:34:39', '2026-05-18 16:34:39'),
(5070, 31, 1397, NULL, 0, 20, 0, 20, '2026-05-18 16:34:39', '2026-05-18 16:34:39'),
(5071, 31, 1398, NULL, 0, 20, 1, 19, '2026-05-18 16:34:39', '2026-05-18 16:34:39'),
(5072, 31, 1399, NULL, 0, 20, 0, 20, '2026-05-18 16:34:39', '2026-05-18 16:34:39'),
(5073, 31, 1400, NULL, 0, 20, 1, 19, '2026-05-18 16:34:39', '2026-05-18 16:34:39'),
(5074, 31, 1401, NULL, 0, 20, 2, 18, '2026-05-18 16:34:39', '2026-05-18 16:34:39'),
(5075, 31, 1402, NULL, 0, 20, 0, 20, '2026-05-18 16:34:39', '2026-05-18 16:34:39'),
(5076, 31, 1403, NULL, 0, 20, 2, 18, '2026-05-18 16:34:39', '2026-05-18 16:34:39'),
(5077, 31, 1404, NULL, 0, 20, 1, 19, '2026-05-18 16:34:39', '2026-05-18 16:34:39'),
(5078, 31, 1405, NULL, 0, 20, 3, 17, '2026-05-18 16:34:39', '2026-05-18 16:34:39'),
(5079, 32, 1340, NULL, 0, 20, 0, 20, '2026-05-18 20:43:18', '2026-05-18 20:43:18'),
(5080, 32, 1341, NULL, 0, 20, 2, 18, '2026-05-18 20:43:18', '2026-05-18 20:43:18'),
(5081, 32, 1342, NULL, 0, 20, 0, 20, '2026-05-18 20:43:18', '2026-05-18 20:43:18'),
(5082, 32, 1343, NULL, 0, 20, 1, 19, '2026-05-18 20:43:18', '2026-05-18 20:43:18'),
(5083, 32, 1344, NULL, 0, 20, 0, 20, '2026-05-18 20:43:18', '2026-05-18 20:43:18'),
(5084, 32, 1345, NULL, 0, 20, 2, 18, '2026-05-18 20:43:18', '2026-05-18 20:43:18'),
(5085, 32, 1346, NULL, 0, 20, 0, 20, '2026-05-18 20:43:18', '2026-05-18 20:43:18'),
(5086, 32, 1347, NULL, 0, 20, 2, 18, '2026-05-18 20:43:18', '2026-05-18 20:43:18'),
(5087, 32, 1348, NULL, 0, 20, 0, 20, '2026-05-18 20:43:18', '2026-05-18 20:43:18'),
(5088, 32, 1349, NULL, 0, 20, 0, 20, '2026-05-18 20:43:18', '2026-05-18 20:43:18'),
(5089, 32, 1350, NULL, 0, 20, 0, 20, '2026-05-18 20:43:18', '2026-05-18 20:43:18'),
(5090, 32, 1351, NULL, 0, 20, 2, 18, '2026-05-18 20:43:18', '2026-05-18 20:43:18'),
(5091, 32, 1352, NULL, 0, 20, 0, 20, '2026-05-18 20:43:18', '2026-05-18 20:43:18'),
(5092, 32, 1353, NULL, 0, 20, 0, 20, '2026-05-18 20:43:18', '2026-05-18 20:43:18'),
(5093, 32, 1354, NULL, 0, 20, 0, 20, '2026-05-18 20:43:18', '2026-05-18 20:43:18'),
(5094, 32, 1355, NULL, 0, 20, 1, 19, '2026-05-18 20:43:18', '2026-05-18 20:43:18'),
(5095, 32, 1356, NULL, 0, 20, 3, 17, '2026-05-18 20:43:18', '2026-05-18 20:43:18'),
(5096, 32, 1357, NULL, 0, 20, 3, 17, '2026-05-18 20:43:18', '2026-05-18 20:43:18'),
(5097, 32, 1358, NULL, 0, 20, 0, 20, '2026-05-18 20:43:18', '2026-05-18 20:43:18'),
(5098, 32, 1359, NULL, 0, 20, 1, 19, '2026-05-18 20:43:18', '2026-05-18 20:43:18'),
(5099, 32, 1360, NULL, 0, 20, 0, 20, '2026-05-18 20:43:18', '2026-05-18 20:43:18'),
(5100, 32, 1361, NULL, 0, 20, 2, 18, '2026-05-18 20:43:18', '2026-05-18 20:43:18'),
(5101, 32, 1362, NULL, 0, 20, 1, 19, '2026-05-18 20:43:18', '2026-05-18 20:43:18'),
(5102, 32, 1363, NULL, 0, 20, 0, 20, '2026-05-18 20:43:18', '2026-05-18 20:43:18'),
(5103, 32, 1364, NULL, 0, 20, 2, 18, '2026-05-18 20:43:18', '2026-05-18 20:43:18'),
(5104, 32, 1365, NULL, 0, 20, 0, 20, '2026-05-18 20:43:18', '2026-05-18 20:43:18'),
(5105, 32, 1366, NULL, 0, 0, 0, 0, '2026-05-18 20:43:18', '2026-05-18 20:43:18'),
(5106, 32, 1367, NULL, 0, 0, 0, 0, '2026-05-18 20:43:18', '2026-05-18 20:43:18'),
(5107, 32, 1368, NULL, 0, 0, 0, 0, '2026-05-18 20:43:18', '2026-05-18 20:43:18'),
(5108, 32, 1369, NULL, 0, 0, 0, 0, '2026-05-18 20:43:18', '2026-05-18 20:43:18'),
(5109, 32, 1394, NULL, 0, 20, 0, 20, '2026-05-18 20:43:18', '2026-05-18 20:43:18'),
(5110, 32, 1395, NULL, 0, 20, 1, 19, '2026-05-18 20:43:18', '2026-05-18 20:43:18'),
(5111, 32, 1396, NULL, 0, 20, 2, 18, '2026-05-18 20:43:18', '2026-05-18 20:43:18'),
(5112, 32, 1397, NULL, 0, 20, 0, 20, '2026-05-18 20:43:18', '2026-05-18 20:43:18'),
(5113, 32, 1398, NULL, 0, 20, 1, 19, '2026-05-18 20:43:18', '2026-05-18 20:43:18'),
(5114, 32, 1399, NULL, 0, 20, 0, 20, '2026-05-18 20:43:18', '2026-05-18 20:43:18'),
(5115, 32, 1400, NULL, 0, 20, 1, 19, '2026-05-18 20:43:18', '2026-05-18 20:43:18'),
(5116, 32, 1401, NULL, 0, 20, 2, 18, '2026-05-18 20:43:18', '2026-05-18 20:43:18'),
(5117, 32, 1402, NULL, 0, 20, 0, 20, '2026-05-18 20:43:18', '2026-05-18 20:43:18'),
(5118, 32, 1403, NULL, 0, 20, 2, 18, '2026-05-18 20:43:18', '2026-05-18 20:43:18'),
(5119, 32, 1404, NULL, 0, 20, 1, 19, '2026-05-18 20:43:18', '2026-05-18 20:43:18'),
(5120, 32, 1405, NULL, 0, 20, 3, 17, '2026-05-18 20:43:18', '2026-05-18 20:43:18'),
(5121, 33, 1340, NULL, 0, 20, 0, 20, '2026-05-18 20:57:53', '2026-05-18 20:57:53'),
(5122, 33, 1341, NULL, 0, 20, 2, 18, '2026-05-18 20:57:53', '2026-05-18 20:57:53'),
(5123, 33, 1342, NULL, 0, 20, 0, 20, '2026-05-18 20:57:53', '2026-05-18 20:57:53'),
(5124, 33, 1343, NULL, 0, 20, 1, 19, '2026-05-18 20:57:53', '2026-05-18 20:57:53'),
(5125, 33, 1344, NULL, 0, 20, 0, 20, '2026-05-18 20:57:53', '2026-05-18 20:57:53'),
(5126, 33, 1345, NULL, 0, 20, 0, 20, '2026-05-18 20:57:53', '2026-05-18 20:57:53'),
(5127, 33, 1346, NULL, 0, 20, 0, 20, '2026-05-18 20:57:53', '2026-05-18 20:57:53'),
(5128, 33, 1347, NULL, 0, 20, 2, 18, '2026-05-18 20:57:53', '2026-05-18 20:57:53'),
(5129, 33, 1348, NULL, 0, 20, 0, 20, '2026-05-18 20:57:53', '2026-05-18 20:57:53'),
(5130, 33, 1349, NULL, 0, 20, 0, 20, '2026-05-18 20:57:53', '2026-05-18 20:57:53'),
(5131, 33, 1350, NULL, 0, 20, 0, 20, '2026-05-18 20:57:53', '2026-05-18 20:57:53'),
(5132, 33, 1351, NULL, 0, 20, 2, 18, '2026-05-18 20:57:53', '2026-05-18 20:57:53'),
(5133, 33, 1352, NULL, 0, 20, 0, 20, '2026-05-18 20:57:53', '2026-05-18 20:57:53'),
(5134, 33, 1353, NULL, 0, 20, 0, 20, '2026-05-18 20:57:53', '2026-05-18 20:57:53'),
(5135, 33, 1354, NULL, 0, 20, 0, 20, '2026-05-18 20:57:53', '2026-05-18 20:57:53'),
(5136, 33, 1355, NULL, 0, 20, 1, 19, '2026-05-18 20:57:53', '2026-05-18 20:57:53'),
(5137, 33, 1356, NULL, 0, 20, 3, 17, '2026-05-18 20:57:53', '2026-05-18 20:57:53'),
(5138, 33, 1357, NULL, 0, 20, 3, 17, '2026-05-18 20:57:53', '2026-05-18 20:57:53'),
(5139, 33, 1358, NULL, 0, 20, 0, 20, '2026-05-18 20:57:53', '2026-05-18 20:57:53'),
(5140, 33, 1359, NULL, 0, 20, 1, 19, '2026-05-18 20:57:53', '2026-05-18 20:57:53'),
(5141, 33, 1360, NULL, 0, 20, 0, 20, '2026-05-18 20:57:53', '2026-05-18 20:57:53'),
(5142, 33, 1361, NULL, 0, 20, 2, 18, '2026-05-18 20:57:53', '2026-05-18 20:57:53'),
(5143, 33, 1362, NULL, 0, 20, 1, 19, '2026-05-18 20:57:53', '2026-05-18 20:57:53'),
(5144, 33, 1363, NULL, 0, 20, 0, 20, '2026-05-18 20:57:53', '2026-05-18 20:57:53'),
(5145, 33, 1364, NULL, 0, 20, 2, 18, '2026-05-18 20:57:53', '2026-05-18 20:57:53'),
(5146, 33, 1365, NULL, 0, 20, 0, 20, '2026-05-18 20:57:53', '2026-05-18 20:57:53'),
(5147, 33, 1366, NULL, 0, 0, 0, 0, '2026-05-18 20:57:53', '2026-05-18 20:57:53'),
(5148, 33, 1367, NULL, 0, 0, 0, 0, '2026-05-18 20:57:53', '2026-05-18 20:57:53'),
(5149, 33, 1368, NULL, 0, 0, 0, 0, '2026-05-18 20:57:53', '2026-05-18 20:57:53'),
(5150, 33, 1369, NULL, 0, 0, 0, 0, '2026-05-18 20:57:53', '2026-05-18 20:57:53'),
(5151, 33, 1394, NULL, 0, 20, 0, 20, '2026-05-18 20:57:53', '2026-05-18 20:57:53'),
(5152, 33, 1395, NULL, 0, 20, 1, 19, '2026-05-18 20:57:53', '2026-05-18 20:57:53'),
(5153, 33, 1396, NULL, 0, 20, 2, 18, '2026-05-18 20:57:53', '2026-05-18 20:57:53'),
(5154, 33, 1397, NULL, 0, 20, 0, 20, '2026-05-18 20:57:53', '2026-05-18 20:57:53'),
(5155, 33, 1398, NULL, 0, 20, 1, 19, '2026-05-18 20:57:53', '2026-05-18 20:57:53'),
(5156, 33, 1399, NULL, 0, 20, 0, 20, '2026-05-18 20:57:53', '2026-05-18 20:57:53'),
(5157, 33, 1400, NULL, 0, 20, 1, 19, '2026-05-18 20:57:53', '2026-05-18 20:57:53'),
(5158, 33, 1401, NULL, 0, 20, 2, 18, '2026-05-18 20:57:53', '2026-05-18 20:57:53'),
(5159, 33, 1402, NULL, 0, 20, 0, 20, '2026-05-18 20:57:53', '2026-05-18 20:57:53'),
(5160, 33, 1403, NULL, 0, 20, 2, 18, '2026-05-18 20:57:53', '2026-05-18 20:57:53'),
(5161, 33, 1404, NULL, 0, 20, 1, 19, '2026-05-18 20:57:53', '2026-05-18 20:57:53'),
(5162, 33, 1405, NULL, 0, 20, 3, 17, '2026-05-18 20:57:53', '2026-05-18 20:57:53'),
(5163, 34, 1340, NULL, 0, 20, 0, 20, '2026-05-18 21:18:23', '2026-05-18 21:18:23'),
(5164, 34, 1341, NULL, 0, 20, 2, 18, '2026-05-18 21:18:23', '2026-05-18 21:18:23'),
(5165, 34, 1342, NULL, 0, 20, 0, 20, '2026-05-18 21:18:23', '2026-05-18 21:18:23'),
(5166, 34, 1343, NULL, 0, 20, 1, 19, '2026-05-18 21:18:23', '2026-05-18 21:18:23'),
(5167, 34, 1344, NULL, 0, 20, 0, 20, '2026-05-18 21:18:23', '2026-05-18 21:18:23'),
(5168, 34, 1345, NULL, 0, 20, 2, 18, '2026-05-18 21:18:23', '2026-05-18 21:18:23'),
(5169, 34, 1346, NULL, 0, 20, 0, 20, '2026-05-18 21:18:23', '2026-05-18 21:18:23'),
(5170, 34, 1347, NULL, 0, 20, 2, 18, '2026-05-18 21:18:23', '2026-05-18 21:18:23'),
(5171, 34, 1348, NULL, 0, 20, 0, 20, '2026-05-18 21:18:23', '2026-05-18 21:18:23'),
(5172, 34, 1349, NULL, 0, 20, 0, 20, '2026-05-18 21:18:23', '2026-05-18 21:18:23'),
(5173, 34, 1350, NULL, 0, 20, 0, 20, '2026-05-18 21:18:23', '2026-05-18 21:18:23'),
(5174, 34, 1351, NULL, 0, 20, 2, 18, '2026-05-18 21:18:23', '2026-05-18 21:18:23'),
(5175, 34, 1352, NULL, 0, 20, 0, 20, '2026-05-18 21:18:23', '2026-05-18 21:18:23'),
(5176, 34, 1353, NULL, 0, 20, 0, 20, '2026-05-18 21:18:23', '2026-05-18 21:18:23'),
(5177, 34, 1354, NULL, 0, 20, 0, 20, '2026-05-18 21:18:23', '2026-05-18 21:18:23'),
(5178, 34, 1355, NULL, 0, 20, 1, 19, '2026-05-18 21:18:23', '2026-05-18 21:18:23'),
(5179, 34, 1356, NULL, 0, 20, 3, 17, '2026-05-18 21:18:23', '2026-05-18 21:18:23'),
(5180, 34, 1357, NULL, 0, 20, 3, 17, '2026-05-18 21:18:23', '2026-05-18 21:18:23'),
(5181, 34, 1358, NULL, 0, 20, 0, 20, '2026-05-18 21:18:23', '2026-05-18 21:18:23'),
(5182, 34, 1359, NULL, 0, 20, 1, 19, '2026-05-18 21:18:23', '2026-05-18 21:18:23'),
(5183, 34, 1360, NULL, 0, 20, 0, 20, '2026-05-18 21:18:23', '2026-05-18 21:18:23'),
(5184, 34, 1361, NULL, 0, 20, 2, 18, '2026-05-18 21:18:23', '2026-05-18 21:18:23'),
(5185, 34, 1362, NULL, 0, 20, 1, 19, '2026-05-18 21:18:23', '2026-05-18 21:18:23'),
(5186, 34, 1363, NULL, 0, 20, 2, 18, '2026-05-18 21:18:23', '2026-05-18 21:18:23'),
(5187, 34, 1364, NULL, 0, 20, 2, 18, '2026-05-18 21:18:23', '2026-05-18 21:18:23'),
(5188, 34, 1365, NULL, 0, 20, 0, 20, '2026-05-18 21:18:23', '2026-05-18 21:18:23'),
(5189, 34, 1366, NULL, 0, 0, 0, 0, '2026-05-18 21:18:23', '2026-05-18 21:18:23'),
(5190, 34, 1367, NULL, 0, 0, 0, 0, '2026-05-18 21:18:23', '2026-05-18 21:18:23'),
(5191, 34, 1368, NULL, 0, 0, 0, 0, '2026-05-18 21:18:23', '2026-05-18 21:18:23'),
(5192, 34, 1369, NULL, 0, 0, 0, 0, '2026-05-18 21:18:23', '2026-05-18 21:18:23'),
(5193, 34, 1394, NULL, 0, 20, 0, 20, '2026-05-18 21:18:23', '2026-05-18 21:18:23'),
(5194, 34, 1395, NULL, 0, 20, 1, 19, '2026-05-18 21:18:23', '2026-05-18 21:18:23'),
(5195, 34, 1396, NULL, 0, 20, 2, 18, '2026-05-18 21:18:23', '2026-05-18 21:18:23'),
(5196, 34, 1397, NULL, 0, 20, 0, 20, '2026-05-18 21:18:23', '2026-05-18 21:18:23'),
(5197, 34, 1398, NULL, 0, 20, 1, 19, '2026-05-18 21:18:23', '2026-05-18 21:18:23'),
(5198, 34, 1399, NULL, 0, 20, 0, 20, '2026-05-18 21:18:23', '2026-05-18 21:18:23'),
(5199, 34, 1400, NULL, 0, 20, 1, 19, '2026-05-18 21:18:23', '2026-05-18 21:18:23'),
(5200, 34, 1401, NULL, 0, 20, 1, 19, '2026-05-18 21:18:23', '2026-05-18 21:18:23'),
(5201, 34, 1402, NULL, 0, 20, 1, 19, '2026-05-18 21:18:23', '2026-05-18 21:18:23'),
(5202, 34, 1403, NULL, 0, 20, 2, 18, '2026-05-18 21:18:23', '2026-05-18 21:18:23'),
(5203, 34, 1404, NULL, 0, 20, 1, 19, '2026-05-18 21:18:23', '2026-05-18 21:18:23'),
(5204, 34, 1405, NULL, 0, 20, 3, 17, '2026-05-18 21:18:23', '2026-05-18 21:18:23'),
(5205, 35, 1340, NULL, 0, 20, 0, 20, '2026-05-18 21:31:23', '2026-05-18 21:31:23'),
(5206, 35, 1341, NULL, 0, 20, 2, 18, '2026-05-18 21:31:23', '2026-05-18 21:31:23'),
(5207, 35, 1342, NULL, 0, 20, 0, 20, '2026-05-18 21:31:23', '2026-05-18 21:31:23'),
(5208, 35, 1343, NULL, 0, 20, 1, 19, '2026-05-18 21:31:23', '2026-05-18 21:31:23'),
(5209, 35, 1344, NULL, 0, 20, 0, 20, '2026-05-18 21:31:23', '2026-05-18 21:31:23'),
(5210, 35, 1345, NULL, 0, 20, 0, 20, '2026-05-18 21:31:23', '2026-05-18 21:31:23'),
(5211, 35, 1346, NULL, 0, 20, 0, 20, '2026-05-18 21:31:23', '2026-05-18 21:31:23'),
(5212, 35, 1347, NULL, 0, 20, 2, 18, '2026-05-18 21:31:23', '2026-05-18 21:31:23'),
(5213, 35, 1348, NULL, 0, 20, 0, 20, '2026-05-18 21:31:23', '2026-05-18 21:31:23'),
(5214, 35, 1349, NULL, 0, 20, 0, 20, '2026-05-18 21:31:23', '2026-05-18 21:31:23'),
(5215, 35, 1350, NULL, 0, 20, 0, 20, '2026-05-18 21:31:23', '2026-05-18 21:31:23'),
(5216, 35, 1351, NULL, 0, 20, 2, 18, '2026-05-18 21:31:23', '2026-05-18 21:31:23'),
(5217, 35, 1352, NULL, 0, 20, 0, 20, '2026-05-18 21:31:23', '2026-05-18 21:31:23'),
(5218, 35, 1353, NULL, 0, 20, 0, 20, '2026-05-18 21:31:23', '2026-05-18 21:31:23'),
(5219, 35, 1354, NULL, 0, 20, 0, 20, '2026-05-18 21:31:23', '2026-05-18 21:31:23'),
(5220, 35, 1355, NULL, 0, 20, 1, 19, '2026-05-18 21:31:23', '2026-05-18 21:31:23'),
(5221, 35, 1356, NULL, 0, 20, 1, 19, '2026-05-18 21:31:23', '2026-05-18 21:31:23'),
(5222, 35, 1357, NULL, 0, 20, 1, 19, '2026-05-18 21:31:23', '2026-05-18 21:31:23'),
(5223, 35, 1358, NULL, 0, 20, 0, 20, '2026-05-18 21:31:23', '2026-05-18 21:31:23'),
(5224, 35, 1359, NULL, 0, 20, 1, 19, '2026-05-18 21:31:23', '2026-05-18 21:31:23'),
(5225, 35, 1360, NULL, 0, 20, 0, 20, '2026-05-18 21:31:23', '2026-05-18 21:31:23'),
(5226, 35, 1361, NULL, 0, 20, 2, 18, '2026-05-18 21:31:23', '2026-05-18 21:31:23'),
(5227, 35, 1362, NULL, 0, 20, 1, 19, '2026-05-18 21:31:23', '2026-05-18 21:31:23'),
(5228, 35, 1363, NULL, 0, 20, 0, 20, '2026-05-18 21:31:23', '2026-05-18 21:31:23'),
(5229, 35, 1364, NULL, 0, 20, 2, 18, '2026-05-18 21:31:23', '2026-05-18 21:31:23'),
(5230, 35, 1365, NULL, 0, 20, 0, 20, '2026-05-18 21:31:23', '2026-05-18 21:31:23'),
(5231, 35, 1366, NULL, 0, 0, 0, 0, '2026-05-18 21:31:23', '2026-05-18 21:31:23'),
(5232, 35, 1367, NULL, 0, 0, 0, 0, '2026-05-18 21:31:23', '2026-05-18 21:31:23'),
(5233, 35, 1368, NULL, 0, 0, 0, 0, '2026-05-18 21:31:23', '2026-05-18 21:31:23'),
(5234, 35, 1369, NULL, 0, 0, 0, 0, '2026-05-18 21:31:23', '2026-05-18 21:31:23'),
(5235, 35, 1394, NULL, 0, 20, 0, 20, '2026-05-18 21:31:23', '2026-05-18 21:31:23'),
(5236, 35, 1395, NULL, 0, 20, 1, 19, '2026-05-18 21:31:23', '2026-05-18 21:31:23'),
(5237, 35, 1396, NULL, 0, 20, 2, 18, '2026-05-18 21:31:23', '2026-05-18 21:31:23'),
(5238, 35, 1397, NULL, 0, 20, 0, 20, '2026-05-18 21:31:23', '2026-05-18 21:31:23'),
(5239, 35, 1398, NULL, 0, 20, 1, 19, '2026-05-18 21:31:23', '2026-05-18 21:31:23'),
(5240, 35, 1399, NULL, 0, 20, 0, 20, '2026-05-18 21:31:23', '2026-05-18 21:31:23'),
(5241, 35, 1400, NULL, 0, 20, 1, 19, '2026-05-18 21:31:23', '2026-05-18 21:31:23'),
(5242, 35, 1401, NULL, 0, 20, 2, 18, '2026-05-18 21:31:23', '2026-05-18 21:31:23'),
(5243, 35, 1402, NULL, 0, 20, 0, 20, '2026-05-18 21:31:23', '2026-05-18 21:31:23'),
(5244, 35, 1403, NULL, 0, 20, 2, 18, '2026-05-18 21:31:23', '2026-05-18 21:31:23'),
(5245, 35, 1404, NULL, 0, 20, 1, 19, '2026-05-18 21:31:23', '2026-05-18 21:31:23'),
(5246, 35, 1405, NULL, 0, 20, 3, 17, '2026-05-18 21:31:23', '2026-05-18 21:31:23'),
(5276, 36, 1435, NULL, 0, 20, 0, 20, '2026-05-18 22:53:04', '2026-05-18 22:53:04'),
(5277, 36, 1436, NULL, 0, 20, 0, 20, '2026-05-18 22:53:04', '2026-05-18 22:53:04'),
(5278, 36, 1437, NULL, 0, 20, 0, 20, '2026-05-18 22:53:04', '2026-05-18 22:53:04'),
(5279, 36, 1438, NULL, 0, 20, 1, 19, '2026-05-18 22:53:04', '2026-05-18 22:53:04'),
(5280, 36, 1439, NULL, 0, 20, 2, 18, '2026-05-18 22:53:04', '2026-05-18 22:53:04'),
(5281, 36, 1440, NULL, 0, 20, 1, 19, '2026-05-18 22:53:04', '2026-05-18 22:53:04'),
(5282, 36, 1441, NULL, 0, 20, 2, 18, '2026-05-18 22:53:04', '2026-05-18 22:53:04'),
(5283, 36, 1442, NULL, 0, 20, 1, 19, '2026-05-18 22:53:04', '2026-05-18 22:53:04'),
(5284, 36, 1443, NULL, 0, 20, 0, 20, '2026-05-18 22:53:04', '2026-05-18 22:53:04'),
(5285, 36, 1444, NULL, 0, 20, 2, 18, '2026-05-18 22:53:04', '2026-05-18 22:53:04'),
(5286, 36, 1445, NULL, 0, 20, 1, 19, '2026-05-18 22:53:04', '2026-05-18 22:53:04'),
(5287, 36, 1446, NULL, 0, 20, 0, 20, '2026-05-18 22:53:04', '2026-05-18 22:53:04'),
(5288, 36, 1447, NULL, 0, 20, 1, 19, '2026-05-18 22:53:04', '2026-05-18 22:53:04'),
(5289, 36, 1448, NULL, 0, 20, 2, 18, '2026-05-18 22:53:04', '2026-05-18 22:53:04'),
(5290, 36, 1449, NULL, 0, 20, 0, 20, '2026-05-18 22:53:04', '2026-05-18 22:53:04'),
(5291, 36, 1450, NULL, 0, 20, 0, 20, '2026-05-18 22:53:04', '2026-05-18 22:53:04'),
(5292, 36, 1451, NULL, 0, 0, 0, 0, '2026-05-18 22:53:04', '2026-05-18 22:53:04'),
(5293, 36, 1452, NULL, 0, 20, 0, 20, '2026-05-18 22:53:04', '2026-05-18 22:53:04'),
(5294, 36, 1453, NULL, 0, 20, 0, 20, '2026-05-18 22:53:04', '2026-05-18 22:53:04'),
(5295, 36, 1454, NULL, 0, 20, 2, 18, '2026-05-18 22:53:04', '2026-05-18 22:53:04'),
(5296, 36, 1455, NULL, 0, 0, 0, 0, '2026-05-18 22:53:04', '2026-05-18 22:53:04'),
(5297, 36, 1456, NULL, 0, 0, 0, 0, '2026-05-18 22:53:04', '2026-05-18 22:53:04'),
(5298, 36, 1457, NULL, 0, 0, 0, 0, '2026-05-18 22:53:04', '2026-05-18 22:53:04'),
(5299, 36, 1458, NULL, 0, 0, 0, 0, '2026-05-18 22:53:04', '2026-05-18 22:53:04'),
(5300, 36, 1459, NULL, 0, 0, 0, 0, '2026-05-18 22:53:04', '2026-05-18 22:53:04'),
(5301, 36, 1460, NULL, 0, 0, 0, 0, '2026-05-18 22:53:04', '2026-05-18 22:53:04'),
(5302, 36, 1461, NULL, 0, 0, 0, 0, '2026-05-18 22:53:04', '2026-05-18 22:53:04'),
(5303, 36, 1462, NULL, 0, 0, 0, 0, '2026-05-18 22:53:04', '2026-05-18 22:53:04'),
(5304, 36, 1463, NULL, 0, 0, 0, 0, '2026-05-18 22:53:04', '2026-05-18 22:53:04'),
(5305, 37, 1435, NULL, 0, 20, 0, 20, '2026-05-18 23:21:01', '2026-05-18 23:21:01'),
(5306, 37, 1436, NULL, 0, 20, 2, 18, '2026-05-18 23:21:01', '2026-05-18 23:21:01'),
(5307, 37, 1437, NULL, 0, 20, 0, 20, '2026-05-18 23:21:01', '2026-05-18 23:21:01'),
(5308, 37, 1438, NULL, 0, 20, 0, 20, '2026-05-18 23:21:01', '2026-05-18 23:21:01'),
(5309, 37, 1439, NULL, 0, 20, 3, 17, '2026-05-18 23:21:01', '2026-05-18 23:21:01'),
(5310, 37, 1440, NULL, 0, 20, 0, 20, '2026-05-18 23:21:01', '2026-05-18 23:21:01'),
(5311, 37, 1441, NULL, 0, 20, 2, 18, '2026-05-18 23:21:01', '2026-05-18 23:21:01'),
(5312, 37, 1442, NULL, 0, 20, 0, 20, '2026-05-18 23:21:01', '2026-05-18 23:21:01'),
(5313, 37, 1443, NULL, 0, 20, 0, 20, '2026-05-18 23:21:01', '2026-05-18 23:21:01'),
(5314, 37, 1444, NULL, 0, 20, 2, 18, '2026-05-18 23:21:01', '2026-05-18 23:21:01'),
(5315, 37, 1445, NULL, 0, 20, 0, 20, '2026-05-18 23:21:01', '2026-05-18 23:21:01'),
(5316, 37, 1446, NULL, 0, 20, 1, 19, '2026-05-18 23:21:01', '2026-05-18 23:21:01'),
(5317, 37, 1447, NULL, 0, 20, 1, 19, '2026-05-18 23:21:01', '2026-05-18 23:21:01'),
(5318, 37, 1448, NULL, 0, 20, 2, 18, '2026-05-18 23:21:01', '2026-05-18 23:21:01'),
(5319, 37, 1449, NULL, 0, 20, 3, 17, '2026-05-18 23:21:01', '2026-05-18 23:21:01'),
(5320, 37, 1450, NULL, 0, 20, 1, 19, '2026-05-18 23:21:01', '2026-05-18 23:21:01'),
(5321, 37, 1451, NULL, 0, 0, 0, 0, '2026-05-18 23:21:01', '2026-05-18 23:21:01'),
(5322, 37, 1452, NULL, 0, 20, 0, 20, '2026-05-18 23:21:01', '2026-05-18 23:21:01'),
(5323, 37, 1453, NULL, 0, 20, 2, 18, '2026-05-18 23:21:01', '2026-05-18 23:21:01'),
(5324, 37, 1454, NULL, 0, 20, 1, 19, '2026-05-18 23:21:01', '2026-05-18 23:21:01'),
(5325, 37, 1455, NULL, 0, 0, 0, 0, '2026-05-18 23:21:01', '2026-05-18 23:21:01'),
(5326, 37, 1456, NULL, 0, 0, 0, 0, '2026-05-18 23:21:01', '2026-05-18 23:21:01'),
(5327, 37, 1457, NULL, 0, 0, 0, 0, '2026-05-18 23:21:01', '2026-05-18 23:21:01'),
(5328, 37, 1458, NULL, 0, 0, 0, 0, '2026-05-18 23:21:01', '2026-05-18 23:21:01'),
(5329, 37, 1459, NULL, 0, 0, 0, 0, '2026-05-18 23:21:01', '2026-05-18 23:21:01'),
(5330, 37, 1460, NULL, 0, 0, 0, 0, '2026-05-18 23:21:01', '2026-05-18 23:21:01'),
(5331, 37, 1461, NULL, 0, 0, 0, 0, '2026-05-18 23:21:01', '2026-05-18 23:21:01'),
(5332, 37, 1462, NULL, 0, 0, 0, 0, '2026-05-18 23:21:01', '2026-05-18 23:21:01'),
(5333, 37, 1463, NULL, 0, 0, 0, 0, '2026-05-18 23:21:01', '2026-05-18 23:21:01'),
(5334, 38, 1435, NULL, 0, 20, 1, 19, '2026-05-18 23:36:03', '2026-05-18 23:36:03'),
(5335, 38, 1436, NULL, 0, 20, 2, 18, '2026-05-18 23:36:03', '2026-05-18 23:36:03'),
(5336, 38, 1437, NULL, 0, 20, 0, 20, '2026-05-18 23:36:03', '2026-05-18 23:36:03'),
(5337, 38, 1438, NULL, 0, 20, 2, 18, '2026-05-18 23:36:03', '2026-05-18 23:36:03'),
(5338, 38, 1439, NULL, 0, 20, 1, 19, '2026-05-18 23:36:03', '2026-05-18 23:36:03'),
(5339, 38, 1440, NULL, 0, 20, 1, 19, '2026-05-18 23:36:03', '2026-05-18 23:36:03'),
(5340, 38, 1441, NULL, 0, 20, 3, 17, '2026-05-18 23:36:03', '2026-05-18 23:36:03'),
(5341, 38, 1442, NULL, 0, 20, 2, 18, '2026-05-18 23:36:03', '2026-05-18 23:36:03'),
(5342, 38, 1443, NULL, 0, 20, 1, 19, '2026-05-18 23:36:03', '2026-05-18 23:36:03'),
(5343, 38, 1444, NULL, 0, 20, 2, 18, '2026-05-18 23:36:03', '2026-05-18 23:36:03'),
(5344, 38, 1445, NULL, 0, 20, 0, 20, '2026-05-18 23:36:03', '2026-05-18 23:36:03'),
(5345, 38, 1446, NULL, 0, 20, 3, 17, '2026-05-18 23:36:03', '2026-05-18 23:36:03'),
(5346, 38, 1447, NULL, 0, 20, 3, 17, '2026-05-18 23:36:03', '2026-05-18 23:36:03'),
(5347, 38, 1448, NULL, 0, 20, 2, 18, '2026-05-18 23:36:03', '2026-05-18 23:36:03'),
(5348, 38, 1449, NULL, 0, 20, 2, 18, '2026-05-18 23:36:03', '2026-05-18 23:36:03'),
(5349, 38, 1450, NULL, 0, 20, 1, 19, '2026-05-18 23:36:03', '2026-05-18 23:36:03'),
(5350, 38, 1451, NULL, 0, 0, 0, 0, '2026-05-18 23:36:03', '2026-05-18 23:36:03'),
(5351, 38, 1452, NULL, 0, 20, 1, 19, '2026-05-18 23:36:03', '2026-05-18 23:36:03'),
(5352, 38, 1453, NULL, 0, 20, 2, 18, '2026-05-18 23:36:03', '2026-05-18 23:36:03'),
(5353, 38, 1454, NULL, 0, 20, 1, 19, '2026-05-18 23:36:03', '2026-05-18 23:36:03'),
(5354, 38, 1455, NULL, 0, 0, 0, 0, '2026-05-18 23:36:03', '2026-05-18 23:36:03'),
(5355, 38, 1456, NULL, 0, 0, 0, 0, '2026-05-18 23:36:03', '2026-05-18 23:36:03'),
(5356, 38, 1457, NULL, 0, 0, 0, 0, '2026-05-18 23:36:03', '2026-05-18 23:36:03'),
(5357, 38, 1458, NULL, 0, 0, 0, 0, '2026-05-18 23:36:03', '2026-05-18 23:36:03'),
(5358, 38, 1459, NULL, 0, 0, 0, 0, '2026-05-18 23:36:03', '2026-05-18 23:36:03'),
(5359, 38, 1460, NULL, 0, 0, 0, 0, '2026-05-18 23:36:03', '2026-05-18 23:36:03'),
(5360, 38, 1461, NULL, 0, 0, 0, 0, '2026-05-18 23:36:03', '2026-05-18 23:36:03'),
(5361, 38, 1462, NULL, 0, 0, 0, 0, '2026-05-18 23:36:03', '2026-05-18 23:36:03'),
(5362, 38, 1463, NULL, 0, 0, 0, 0, '2026-05-18 23:36:03', '2026-05-18 23:36:03'),
(5363, 39, 1435, NULL, 0, 20, 0, 20, '2026-05-18 23:43:16', '2026-05-18 23:43:16'),
(5364, 39, 1436, NULL, 0, 20, 2, 18, '2026-05-18 23:43:16', '2026-05-18 23:43:16'),
(5365, 39, 1437, NULL, 0, 20, 0, 20, '2026-05-18 23:43:16', '2026-05-18 23:43:16'),
(5366, 39, 1438, NULL, 0, 20, 0, 20, '2026-05-18 23:43:16', '2026-05-18 23:43:16'),
(5367, 39, 1439, NULL, 0, 20, 3, 17, '2026-05-18 23:43:16', '2026-05-18 23:43:16'),
(5368, 39, 1440, NULL, 0, 20, 0, 20, '2026-05-18 23:43:16', '2026-05-18 23:43:16'),
(5369, 39, 1441, NULL, 0, 20, 2, 18, '2026-05-18 23:43:16', '2026-05-18 23:43:16'),
(5370, 39, 1442, NULL, 0, 20, 0, 20, '2026-05-18 23:43:16', '2026-05-18 23:43:16'),
(5371, 39, 1443, NULL, 0, 20, 0, 20, '2026-05-18 23:43:16', '2026-05-18 23:43:16'),
(5372, 39, 1444, NULL, 0, 20, 2, 18, '2026-05-18 23:43:16', '2026-05-18 23:43:16'),
(5373, 39, 1445, NULL, 0, 20, 0, 20, '2026-05-18 23:43:16', '2026-05-18 23:43:16'),
(5374, 39, 1446, NULL, 0, 20, 1, 19, '2026-05-18 23:43:16', '2026-05-18 23:43:16'),
(5375, 39, 1447, NULL, 0, 20, 1, 19, '2026-05-18 23:43:16', '2026-05-18 23:43:16'),
(5376, 39, 1448, NULL, 0, 20, 2, 18, '2026-05-18 23:43:16', '2026-05-18 23:43:16'),
(5377, 39, 1449, NULL, 0, 20, 3, 17, '2026-05-18 23:43:16', '2026-05-18 23:43:16'),
(5378, 39, 1450, NULL, 0, 20, 1, 19, '2026-05-18 23:43:16', '2026-05-18 23:43:16'),
(5379, 39, 1451, NULL, 0, 0, 0, 0, '2026-05-18 23:43:16', '2026-05-18 23:43:16'),
(5380, 39, 1452, NULL, 0, 20, 0, 20, '2026-05-18 23:43:16', '2026-05-18 23:43:16'),
(5381, 39, 1453, NULL, 0, 20, 7, 13, '2026-05-18 23:43:16', '2026-05-18 23:43:16'),
(5382, 39, 1454, NULL, 0, 20, 1, 19, '2026-05-18 23:43:16', '2026-05-18 23:43:16'),
(5383, 39, 1455, NULL, 0, 0, 0, 0, '2026-05-18 23:43:16', '2026-05-18 23:43:16'),
(5384, 39, 1456, NULL, 0, 0, 0, 0, '2026-05-18 23:43:16', '2026-05-18 23:43:16'),
(5385, 39, 1457, NULL, 0, 0, 0, 0, '2026-05-18 23:43:16', '2026-05-18 23:43:16'),
(5386, 39, 1458, NULL, 0, 0, 0, 0, '2026-05-18 23:43:16', '2026-05-18 23:43:16'),
(5387, 39, 1459, NULL, 0, 0, 0, 0, '2026-05-18 23:43:16', '2026-05-18 23:43:16'),
(5388, 39, 1460, NULL, 0, 0, 0, 0, '2026-05-18 23:43:16', '2026-05-18 23:43:16'),
(5389, 39, 1461, NULL, 0, 0, 0, 0, '2026-05-18 23:43:16', '2026-05-18 23:43:16'),
(5390, 39, 1462, NULL, 0, 0, 0, 0, '2026-05-18 23:43:16', '2026-05-18 23:43:16'),
(5391, 39, 1463, NULL, 0, 0, 0, 0, '2026-05-18 23:43:16', '2026-05-18 23:43:16'),
(5421, 41, 1435, NULL, 0, 20, 0, 20, '2026-05-18 23:57:41', '2026-05-18 23:57:41'),
(5422, 41, 1436, NULL, 0, 20, 2, 18, '2026-05-18 23:57:41', '2026-05-18 23:57:41'),
(5423, 41, 1437, NULL, 0, 20, 0, 20, '2026-05-18 23:57:41', '2026-05-18 23:57:41'),
(5424, 41, 1438, NULL, 0, 20, 0, 20, '2026-05-18 23:57:41', '2026-05-18 23:57:41'),
(5425, 41, 1439, NULL, 0, 20, 3, 17, '2026-05-18 23:57:41', '2026-05-18 23:57:41'),
(5426, 41, 1440, NULL, 0, 20, 0, 20, '2026-05-18 23:57:41', '2026-05-18 23:57:41'),
(5427, 41, 1441, NULL, 0, 20, 2, 18, '2026-05-18 23:57:41', '2026-05-18 23:57:41'),
(5428, 41, 1442, NULL, 0, 20, 3, 17, '2026-05-18 23:57:41', '2026-05-18 23:57:41'),
(5429, 41, 1443, NULL, 0, 20, 2, 18, '2026-05-18 23:57:41', '2026-05-18 23:57:41'),
(5430, 41, 1444, NULL, 0, 20, 2, 18, '2026-05-18 23:57:41', '2026-05-18 23:57:41'),
(5431, 41, 1445, NULL, 0, 20, 0, 20, '2026-05-18 23:57:41', '2026-05-18 23:57:41'),
(5432, 41, 1446, NULL, 0, 20, 1, 19, '2026-05-18 23:57:41', '2026-05-18 23:57:41'),
(5433, 41, 1447, NULL, 0, 20, 1, 19, '2026-05-18 23:57:41', '2026-05-18 23:57:41'),
(5434, 41, 1448, NULL, 0, 20, 2, 18, '2026-05-18 23:57:41', '2026-05-18 23:57:41'),
(5435, 41, 1449, NULL, 0, 20, 3, 17, '2026-05-18 23:57:41', '2026-05-18 23:57:41'),
(5436, 41, 1450, NULL, 0, 20, 1, 19, '2026-05-18 23:57:41', '2026-05-18 23:57:41'),
(5437, 41, 1451, NULL, 0, 0, 0, 0, '2026-05-18 23:57:41', '2026-05-18 23:57:41'),
(5438, 41, 1452, NULL, 0, 20, 0, 20, '2026-05-18 23:57:41', '2026-05-18 23:57:41'),
(5439, 41, 1453, NULL, 0, 20, 2, 18, '2026-05-18 23:57:41', '2026-05-18 23:57:41'),
(5440, 41, 1454, NULL, 0, 20, 1, 19, '2026-05-18 23:57:41', '2026-05-18 23:57:41'),
(5441, 41, 1455, NULL, 0, 0, 0, 0, '2026-05-18 23:57:41', '2026-05-18 23:57:41');
INSERT INTO `trampa_roedor_seguimientos` (`id`, `seguimiento_id`, `trampa_id`, `observacion`, `cantidad`, `inicial`, `merma`, `actual`, `created_at`, `updated_at`) VALUES
(5442, 41, 1456, NULL, 0, 0, 0, 0, '2026-05-18 23:57:41', '2026-05-18 23:57:41'),
(5443, 41, 1457, NULL, 0, 0, 0, 0, '2026-05-18 23:57:41', '2026-05-18 23:57:41'),
(5444, 41, 1458, NULL, 0, 0, 0, 0, '2026-05-18 23:57:41', '2026-05-18 23:57:41'),
(5445, 41, 1459, NULL, 0, 0, 0, 0, '2026-05-18 23:57:41', '2026-05-18 23:57:41'),
(5446, 41, 1460, NULL, 0, 0, 0, 0, '2026-05-18 23:57:41', '2026-05-18 23:57:41'),
(5447, 41, 1461, NULL, 0, 0, 0, 0, '2026-05-18 23:57:41', '2026-05-18 23:57:41'),
(5448, 41, 1462, NULL, 0, 0, 0, 0, '2026-05-18 23:57:41', '2026-05-18 23:57:41'),
(5449, 41, 1463, NULL, 0, 0, 0, 0, '2026-05-18 23:57:41', '2026-05-18 23:57:41'),
(5450, 42, 1435, NULL, 0, 20, 1, 19, '2026-05-19 00:04:18', '2026-05-19 00:04:18'),
(5451, 42, 1436, NULL, 0, 20, 2, 18, '2026-05-19 00:04:18', '2026-05-19 00:04:18'),
(5452, 42, 1437, NULL, 0, 20, 0, 20, '2026-05-19 00:04:18', '2026-05-19 00:04:18'),
(5453, 42, 1438, NULL, 0, 20, 2, 18, '2026-05-19 00:04:18', '2026-05-19 00:04:18'),
(5454, 42, 1439, NULL, 0, 20, 1, 19, '2026-05-19 00:04:18', '2026-05-19 00:04:18'),
(5455, 42, 1440, NULL, 0, 20, 1, 19, '2026-05-19 00:04:18', '2026-05-19 00:04:18'),
(5456, 42, 1441, NULL, 0, 20, 0, 20, '2026-05-19 00:04:18', '2026-05-19 00:04:18'),
(5457, 42, 1442, NULL, 0, 20, 2, 18, '2026-05-19 00:04:18', '2026-05-19 00:04:18'),
(5458, 42, 1443, NULL, 0, 20, 2, 18, '2026-05-19 00:04:18', '2026-05-19 00:04:18'),
(5459, 42, 1444, NULL, 0, 20, 0, 20, '2026-05-19 00:04:18', '2026-05-19 00:04:18'),
(5460, 42, 1445, NULL, 0, 20, 0, 20, '2026-05-19 00:04:18', '2026-05-19 00:04:18'),
(5461, 42, 1446, NULL, 0, 20, 0, 20, '2026-05-19 00:04:18', '2026-05-19 00:04:18'),
(5462, 42, 1447, NULL, 0, 20, 3, 17, '2026-05-19 00:04:18', '2026-05-19 00:04:18'),
(5463, 42, 1448, NULL, 0, 20, 2, 18, '2026-05-19 00:04:18', '2026-05-19 00:04:18'),
(5464, 42, 1449, NULL, 0, 20, 2, 18, '2026-05-19 00:04:18', '2026-05-19 00:04:18'),
(5465, 42, 1450, NULL, 0, 20, 1, 19, '2026-05-19 00:04:18', '2026-05-19 00:04:18'),
(5466, 42, 1451, NULL, 0, 0, 0, 0, '2026-05-19 00:04:18', '2026-05-19 00:04:18'),
(5467, 42, 1452, NULL, 0, 20, 1, 19, '2026-05-19 00:04:18', '2026-05-19 00:04:18'),
(5468, 42, 1453, NULL, 0, 20, 2, 18, '2026-05-19 00:04:18', '2026-05-19 00:04:18'),
(5469, 42, 1454, NULL, 0, 20, 1, 19, '2026-05-19 00:04:18', '2026-05-19 00:04:18'),
(5470, 42, 1455, NULL, 0, 0, 0, 0, '2026-05-19 00:04:18', '2026-05-19 00:04:18'),
(5471, 42, 1456, NULL, 0, 0, 0, 0, '2026-05-19 00:04:18', '2026-05-19 00:04:18'),
(5472, 42, 1457, NULL, 0, 0, 0, 0, '2026-05-19 00:04:18', '2026-05-19 00:04:18'),
(5473, 42, 1458, NULL, 0, 0, 0, 0, '2026-05-19 00:04:18', '2026-05-19 00:04:18'),
(5474, 42, 1459, NULL, 0, 0, 0, 0, '2026-05-19 00:04:18', '2026-05-19 00:04:18'),
(5475, 42, 1460, NULL, 0, 0, 0, 0, '2026-05-19 00:04:18', '2026-05-19 00:04:18'),
(5476, 42, 1461, NULL, 0, 0, 0, 0, '2026-05-19 00:04:18', '2026-05-19 00:04:18'),
(5477, 42, 1462, NULL, 0, 0, 0, 0, '2026-05-19 00:04:18', '2026-05-19 00:04:18'),
(5478, 42, 1463, NULL, 0, 0, 0, 0, '2026-05-19 00:04:18', '2026-05-19 00:04:18'),
(5537, 40, 1435, '', 0, 20, 2, 18, '2026-05-19 21:17:31', '2026-05-19 21:17:31'),
(5538, 40, 1436, '', 0, 20, 4, 16, '2026-05-19 21:17:31', '2026-05-19 21:17:31'),
(5539, 40, 1437, '', 0, 20, 0, 20, '2026-05-19 21:17:31', '2026-05-19 21:17:31'),
(5540, 40, 1438, '', 0, 20, 2, 18, '2026-05-19 21:17:31', '2026-05-19 21:17:31'),
(5541, 40, 1439, '', 0, 20, 1, 19, '2026-05-19 21:17:31', '2026-05-19 21:17:31'),
(5542, 40, 1440, '', 0, 20, 4, 16, '2026-05-19 21:17:31', '2026-05-19 21:17:31'),
(5543, 40, 1441, '', 0, 20, 0, 20, '2026-05-19 21:17:31', '2026-05-19 21:17:31'),
(5544, 40, 1442, '', 0, 20, 2, 18, '2026-05-19 21:17:31', '2026-05-19 21:17:31'),
(5545, 40, 1443, '', 0, 20, 2, 18, '2026-05-19 21:17:31', '2026-05-19 21:17:31'),
(5546, 40, 1444, '', 0, 20, 1, 19, '2026-05-19 21:17:31', '2026-05-19 21:17:31'),
(5547, 40, 1445, '', 0, 20, 2, 18, '2026-05-19 21:17:31', '2026-05-19 21:17:31'),
(5548, 40, 1446, '', 0, 20, 3, 17, '2026-05-19 21:17:31', '2026-05-19 21:17:31'),
(5549, 40, 1447, '', 0, 20, 3, 17, '2026-05-19 21:17:31', '2026-05-19 21:17:31'),
(5550, 40, 1448, '', 1, 20, 2, 18, '2026-05-19 21:17:31', '2026-05-19 21:17:31'),
(5551, 40, 1449, '', 0, 20, 2, 18, '2026-05-19 21:17:31', '2026-05-19 21:17:31'),
(5552, 40, 1450, '', 0, 20, 2, 18, '2026-05-19 21:17:31', '2026-05-19 21:17:31'),
(5553, 40, 1451, '', 0, 0, 0, 0, '2026-05-19 21:17:31', '2026-05-19 21:17:31'),
(5554, 40, 1452, '', 0, 20, 3, 17, '2026-05-19 21:17:31', '2026-05-19 21:17:31'),
(5555, 40, 1453, '', 0, 20, 4, 16, '2026-05-19 21:17:31', '2026-05-19 21:17:31'),
(5556, 40, 1454, '', 0, 20, 1, 19, '2026-05-19 21:17:31', '2026-05-19 21:17:31'),
(5557, 40, 1455, '', 0, 0, 0, 0, '2026-05-19 21:17:31', '2026-05-19 21:17:31'),
(5558, 40, 1456, '', 0, 0, 0, 0, '2026-05-19 21:17:31', '2026-05-19 21:17:31'),
(5559, 40, 1457, '', 0, 0, 0, 0, '2026-05-19 21:17:31', '2026-05-19 21:17:31'),
(5560, 40, 1458, '', 0, 0, 0, 0, '2026-05-19 21:17:31', '2026-05-19 21:17:31'),
(5561, 40, 1459, '', 0, 0, 0, 0, '2026-05-19 21:17:31', '2026-05-19 21:17:31'),
(5562, 40, 1460, '', 0, 0, 0, 0, '2026-05-19 21:17:31', '2026-05-19 21:17:31'),
(5563, 40, 1461, '', 0, 0, 0, 0, '2026-05-19 21:17:31', '2026-05-19 21:17:31'),
(5564, 40, 1462, '', 0, 0, 0, 0, '2026-05-19 21:17:31', '2026-05-19 21:17:31'),
(5565, 40, 1463, '', 0, 0, 0, 0, '2026-05-19 21:17:31', '2026-05-19 21:17:31'),
(6410, 52, 848, NULL, 0, 20, 1, 19, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6411, 52, 849, NULL, 0, 20, 0, 20, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6412, 52, 850, NULL, 0, 20, 1, 19, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6413, 52, 851, NULL, 0, 20, 3, 17, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6414, 52, 852, NULL, 0, 20, 0, 20, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6415, 52, 853, NULL, 0, 20, 1, 19, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6416, 52, 854, NULL, 0, 20, 17, 3, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6417, 52, 855, NULL, 0, 20, 2, 18, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6418, 52, 856, NULL, 0, 20, 1, 19, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6419, 52, 857, NULL, 0, 20, 0, 20, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6420, 52, 858, NULL, 0, 20, 0, 20, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6421, 52, 859, NULL, 0, 20, 0, 20, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6422, 52, 860, NULL, 0, 20, 0, 20, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6423, 52, 1465, NULL, 0, 20, 0, 20, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6424, 52, 1466, NULL, 0, 20, 0, 20, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6425, 52, 1467, NULL, 0, 20, 0, 20, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6426, 52, 1468, NULL, 0, 20, 0, 20, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6427, 52, 1469, NULL, 0, 20, 0, 20, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6428, 52, 1470, NULL, 0, 20, 0, 20, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6429, 52, 1471, NULL, 0, 20, 0, 20, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6430, 52, 1472, NULL, 0, 20, 0, 20, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6431, 52, 1473, NULL, 0, 20, 0, 20, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6432, 52, 1474, NULL, 0, 20, 0, 20, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6433, 52, 1475, NULL, 0, 20, 1, 19, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6434, 52, 1476, NULL, 0, 20, 2, 18, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6435, 52, 1477, NULL, 0, 20, 0, 20, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6436, 52, 1478, NULL, 0, 0, 0, 0, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6437, 52, 1479, NULL, 0, 0, 0, 0, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6438, 52, 1480, NULL, 0, 0, 0, 0, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6439, 52, 1481, NULL, 0, 0, 0, 0, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6440, 52, 1482, NULL, 0, 20, 0, 20, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6441, 52, 1483, NULL, 0, 20, 0, 20, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6442, 52, 1484, NULL, 0, 20, 1, 19, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6443, 52, 1485, NULL, 0, 20, 0, 20, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6444, 52, 1486, NULL, 0, 20, 1, 19, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6445, 52, 1487, NULL, 0, 20, 0, 20, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6446, 52, 1488, NULL, 0, 20, 4, 16, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6447, 52, 1489, NULL, 0, 20, 0, 20, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6448, 52, 1490, NULL, 0, 20, 2, 18, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6449, 52, 1491, NULL, 0, 20, 0, 20, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6450, 52, 1492, NULL, 0, 20, 0, 20, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6451, 52, 1493, NULL, 0, 20, 0, 20, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6452, 52, 1494, NULL, 0, 20, 0, 20, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6453, 52, 1495, NULL, 0, 20, 2, 18, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6454, 52, 1496, NULL, 0, 20, 0, 20, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6455, 52, 1497, NULL, 0, 20, 20, 0, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6456, 52, 1498, NULL, 0, 0, 0, 0, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6457, 52, 1499, NULL, 0, 0, 0, 0, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6458, 52, 1500, NULL, 0, 0, 0, 0, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6459, 52, 1501, NULL, 0, 0, 0, 0, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6460, 52, 1502, NULL, 0, 0, 0, 0, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6461, 52, 1503, NULL, 0, 0, 0, 0, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6462, 52, 1504, NULL, 0, 0, 0, 0, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6463, 52, 1505, NULL, 0, 0, 0, 0, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6464, 52, 1506, NULL, 0, 0, 0, 0, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6465, 52, 1507, NULL, 0, 0, 0, 0, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6466, 52, 1508, NULL, 0, 0, 0, 0, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6467, 52, 1509, NULL, 0, 0, 0, 0, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6468, 52, 1510, NULL, 0, 0, 0, 0, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6469, 52, 1511, NULL, 0, 0, 0, 0, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6470, 52, 1512, NULL, 0, 0, 0, 0, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6471, 52, 1513, NULL, 0, 0, 0, 0, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6472, 52, 1514, NULL, 0, 0, 0, 0, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6473, 52, 1515, NULL, 0, 0, 0, 0, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6474, 52, 1516, NULL, 0, 0, 0, 0, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6475, 52, 1517, NULL, 0, 0, 0, 0, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6476, 52, 1518, NULL, 0, 0, 0, 0, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6477, 52, 1519, NULL, 0, 0, 0, 0, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6478, 52, 1520, NULL, 0, 0, 0, 0, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6479, 52, 1521, NULL, 0, 0, 0, 0, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6480, 52, 1522, NULL, 0, 0, 0, 0, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6481, 52, 1526, NULL, 0, 20, 2, 18, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6482, 52, 1527, NULL, 0, 20, 1, 19, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6483, 52, 1528, NULL, 0, 20, 2, 18, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6484, 52, 1529, NULL, 0, 20, 2, 18, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6485, 52, 1530, NULL, 0, 20, 0, 20, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6486, 52, 1531, NULL, 0, 20, 0, 20, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(6487, 52, 1532, NULL, 0, 20, 20, 0, '2026-05-22 19:18:00', '2026-05-22 19:18:00'),
(7528, 20, 1152, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7529, 20, 1153, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7530, 20, 1154, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7531, 20, 1155, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7532, 20, 1156, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7533, 20, 1157, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7534, 20, 1158, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7535, 20, 1159, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7536, 20, 1160, '', 0, 20, 3, 17, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7537, 20, 1161, '', 0, 20, 2, 18, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7538, 20, 1162, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7539, 20, 1163, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7540, 20, 1164, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7541, 20, 1165, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7542, 20, 1166, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7543, 20, 1167, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7544, 20, 1168, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7545, 20, 1169, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7546, 20, 1170, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7547, 20, 1171, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7548, 20, 1172, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7549, 20, 1173, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7550, 20, 1174, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7551, 20, 1175, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7552, 20, 1176, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7553, 20, 1177, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7554, 20, 1178, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7555, 20, 1179, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7556, 20, 1180, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7557, 20, 1181, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7558, 20, 1182, '', 0, 20, 1, 19, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7559, 20, 1183, '', 0, 20, 2, 18, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7560, 20, 1184, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7561, 20, 1185, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7562, 20, 1186, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7563, 20, 1187, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7564, 20, 1188, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7565, 20, 1189, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7566, 20, 1190, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7567, 20, 1191, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7568, 20, 1192, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7569, 20, 1193, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7570, 20, 1194, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7571, 20, 1195, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7572, 20, 1196, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7573, 20, 1197, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7574, 20, 1198, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7575, 20, 1199, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7576, 20, 1200, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7577, 20, 1201, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7578, 20, 1202, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7579, 20, 1203, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7580, 20, 1204, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7581, 20, 1205, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7582, 20, 1206, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7583, 20, 1207, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7584, 20, 1208, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7585, 20, 1209, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7586, 20, 1210, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7587, 20, 1211, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7588, 20, 1212, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7589, 20, 1213, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7590, 20, 1214, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7591, 20, 1215, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7592, 20, 1216, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7593, 20, 1217, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7594, 20, 1218, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7595, 20, 1219, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7596, 20, 1220, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7597, 20, 1221, '', 0, 20, 20, 0, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7598, 20, 1222, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7599, 20, 1223, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7600, 20, 1224, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7601, 20, 1225, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7602, 20, 1226, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7603, 20, 1227, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7604, 20, 1228, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7605, 20, 1229, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7606, 20, 1230, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7607, 20, 1231, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7608, 20, 1232, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7609, 20, 1233, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7610, 20, 1234, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7611, 20, 1235, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7612, 20, 1236, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7613, 20, 1237, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7614, 20, 1238, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7615, 20, 1239, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7616, 20, 1240, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7617, 20, 1241, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7618, 20, 1242, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7619, 20, 1243, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7620, 20, 1244, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7621, 20, 1245, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7622, 20, 1246, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7623, 20, 1247, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7624, 20, 1248, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7625, 20, 1249, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7626, 20, 1250, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7627, 20, 1251, '', 0, 20, 0, 20, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7628, 20, 1252, '', 0, 0, 0, 0, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7629, 20, 1253, '', 0, 0, 0, 0, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7630, 20, 1254, '', 0, 0, 0, 0, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7631, 20, 1255, '', 0, 0, 0, 0, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7632, 20, 1256, '', 0, 0, 0, 0, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7633, 20, 1257, '', 0, 0, 0, 0, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7634, 20, 1258, 'Se capturo un roedor', 1, 0, 0, 0, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7635, 20, 1259, '', 0, 0, 0, 0, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7636, 20, 1260, '', 0, 0, 0, 0, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7637, 20, 1261, '', 0, 0, 0, 0, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7638, 20, 1262, '', 0, 0, 0, 0, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7639, 20, 1263, '', 0, 0, 0, 0, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7640, 20, 1264, '', 0, 0, 0, 0, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7641, 20, 1265, '', 0, 0, 0, 0, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7642, 20, 1266, '', 0, 0, 0, 0, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7643, 20, 1267, '', 0, 0, 0, 0, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7644, 20, 1268, '', 0, 0, 0, 0, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7645, 20, 1269, '', 0, 0, 0, 0, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7646, 20, 1270, '', 0, 0, 0, 0, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7647, 20, 1271, '', 0, 0, 0, 0, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7648, 20, 1272, '', 0, 0, 0, 0, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7649, 20, 1273, '', 0, 0, 0, 0, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7650, 20, 1274, '', 0, 0, 0, 0, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7651, 20, 1275, '', 0, 0, 0, 0, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7652, 20, 1276, '', 0, 0, 0, 0, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7653, 20, 1277, '', 0, 0, 0, 0, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7654, 20, 1278, '', 0, 0, 0, 0, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7655, 20, 1279, '', 0, 0, 0, 0, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7656, 20, 1280, '', 0, 0, 0, 0, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7657, 20, 1281, '', 0, 0, 0, 0, '2026-05-25 22:03:26', '2026-05-25 22:03:26'),
(7658, 55, 1152, '', 0, 20, 2, 18, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7659, 55, 1153, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7660, 55, 1154, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7661, 55, 1155, '', 0, 20, -8, 28, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7662, 55, 1156, '', 0, 20, 1, 19, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7663, 55, 1157, '', 0, 0, 0, 0, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7664, 55, 1158, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7665, 55, 1159, '', 0, 20, 3, 17, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7666, 55, 1160, '', 0, 20, 4, 16, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7667, 55, 1161, '', 0, 20, 1, 19, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7668, 55, 1162, '', 0, 20, 1, 19, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7669, 55, 1163, '', 0, 20, 1, 19, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7670, 55, 1164, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7671, 55, 1165, '', 0, 28, 8, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7672, 55, 1166, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7673, 55, 1167, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7674, 55, 1168, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7675, 55, 1169, '', 0, 20, 1, 19, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7676, 55, 1170, '', 0, 20, 1, 19, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7677, 55, 1171, '', 0, 20, 1, 19, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7678, 55, 1172, '', 0, 20, 2, 18, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7679, 55, 1173, '', 0, 20, 1, 19, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7680, 55, 1174, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7681, 55, 1175, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7682, 55, 1176, '', 0, 20, 18, 2, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7683, 55, 1177, '', 0, 20, 20, 0, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7684, 55, 1178, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7685, 55, 1179, '', 0, 20, 1, 19, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7686, 55, 1180, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7687, 55, 1181, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7688, 55, 1182, '', 0, 20, 1, 19, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7689, 55, 1183, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7690, 55, 1184, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7691, 55, 1185, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7692, 55, 1186, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7693, 55, 1187, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7694, 55, 1188, '', 0, 20, 1, 19, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7695, 55, 1189, '', 0, 20, 1, 19, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7696, 55, 1190, '', 0, 20, -8, 28, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7697, 55, 1191, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7698, 55, 1192, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7699, 55, 1193, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7700, 55, 1194, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7701, 55, 1195, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7702, 55, 1196, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7703, 55, 1197, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7704, 55, 1198, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7705, 55, 1199, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7706, 55, 1200, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7707, 55, 1201, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7708, 55, 1202, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7709, 55, 1203, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7710, 55, 1204, '', 0, 20, 2, 18, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7711, 55, 1205, '', 0, 20, 2, 18, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7712, 55, 1206, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7713, 55, 1207, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7714, 55, 1208, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7715, 55, 1209, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7716, 55, 1210, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7717, 55, 1211, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7718, 55, 1212, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7719, 55, 1213, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7720, 55, 1214, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7721, 55, 1215, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7722, 55, 1216, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7723, 55, 1217, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7724, 55, 1218, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7725, 55, 1219, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7726, 55, 1220, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7727, 55, 1221, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7728, 55, 1222, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7729, 55, 1223, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7730, 55, 1224, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7731, 55, 1225, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7732, 55, 1226, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7733, 55, 1227, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7734, 55, 1228, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7735, 55, 1229, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7736, 55, 1230, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7737, 55, 1231, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7738, 55, 1232, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7739, 55, 1233, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7740, 55, 1234, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7741, 55, 1235, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7742, 55, 1236, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7743, 55, 1237, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7744, 55, 1238, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7745, 55, 1239, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7746, 55, 1240, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7747, 55, 1241, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7748, 55, 1242, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7749, 55, 1243, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7750, 55, 1244, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7751, 55, 1245, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7752, 55, 1246, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7753, 55, 1247, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7754, 55, 1248, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7755, 55, 1249, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7756, 55, 1250, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7757, 55, 1251, '', 0, 20, 0, 20, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7758, 55, 1252, '', 0, 0, 0, 0, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7759, 55, 1253, '', 0, 0, 0, 0, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7760, 55, 1254, '', 0, 0, 0, 0, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7761, 55, 1255, '', 0, 0, 0, 0, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7762, 55, 1256, '', 0, 0, 0, 0, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7763, 55, 1257, '', 0, 0, 0, 0, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7764, 55, 1258, '', 0, 0, 0, 0, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7765, 55, 1259, '', 0, 0, 0, 0, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7766, 55, 1260, '', 0, 0, 0, 0, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7767, 55, 1261, '', 0, 0, 0, 0, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7768, 55, 1262, '', 0, 0, 0, 0, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7769, 55, 1263, '', 0, 0, 0, 0, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7770, 55, 1264, '', 0, 0, 0, 0, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7771, 55, 1265, '', 0, 0, 0, 0, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7772, 55, 1266, '', 0, 0, 0, 0, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7773, 55, 1267, '', 0, 0, 0, 0, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7774, 55, 1268, '', 0, 0, 0, 0, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7775, 55, 1269, '', 0, 0, 0, 0, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7776, 55, 1270, '', 0, 0, 0, 0, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7777, 55, 1271, '', 0, 0, 0, 0, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7778, 55, 1272, '', 0, 0, 0, 0, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7779, 55, 1273, '', 0, 0, 0, 0, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7780, 55, 1274, '', 0, 0, 0, 0, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7781, 55, 1275, '', 0, 0, 0, 0, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7782, 55, 1276, '', 0, 0, 0, 0, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7783, 55, 1277, '', 0, 0, 0, 0, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7784, 55, 1278, '', 0, 0, 0, 0, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7785, 55, 1279, '', 0, 0, 0, 0, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7786, 55, 1280, '', 0, 0, 0, 0, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7787, 55, 1281, '', 0, 0, 0, 0, '2026-05-25 22:04:50', '2026-05-25 22:04:50'),
(7788, 17, 848, '', 0, 20, 0, 20, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7789, 17, 849, '', 0, 20, 0, 20, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7790, 17, 850, '', 0, 20, 0, 20, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7791, 17, 851, '', 0, 20, 0, 20, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7792, 17, 852, '', 0, 20, 0, 20, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7793, 17, 853, '', 0, 20, 0, 20, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7794, 17, 854, '', 0, 20, 0, 20, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7795, 17, 855, '', 0, 28, 8, 20, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7796, 17, 856, '', 0, 20, 0, 20, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7797, 17, 857, '', 0, 20, 0, 20, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7798, 17, 858, '', 0, 20, 0, 20, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7799, 17, 859, '', 0, 20, 0, 20, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7800, 17, 860, '', 0, 20, 0, 20, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7801, 17, 1465, '', 0, 20, 0, 20, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7802, 17, 1466, '', 0, 20, 0, 20, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7803, 17, 1467, '', 0, 20, 0, 20, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7804, 17, 1468, '', 0, 20, 0, 20, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7805, 17, 1469, '', 0, 20, 0, 20, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7806, 17, 1470, '', 0, 20, 0, 20, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7807, 17, 1471, '', 0, 20, 0, 20, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7808, 17, 1472, '', 0, 20, 0, 20, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7809, 17, 1473, '', 0, 20, 0, 20, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7810, 17, 1474, '', 0, 20, 0, 20, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7811, 17, 1475, '', 0, 20, 0, 20, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7812, 17, 1476, '', 0, 20, 0, 20, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7813, 17, 1477, '', 0, 20, 0, 20, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7814, 17, 1478, '', 0, 0, 0, 0, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7815, 17, 1479, '', 0, 0, 0, 0, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7816, 17, 1480, '', 0, 0, 0, 0, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7817, 17, 1481, '', 0, 0, 0, 0, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7818, 17, 1482, '', 0, 20, 0, 20, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7819, 17, 1483, '', 0, 20, 0, 20, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7820, 17, 1484, '', 0, 20, 0, 20, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7821, 17, 1485, '', 0, 20, 0, 20, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7822, 17, 1486, '', 0, 20, 0, 20, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7823, 17, 1487, '', 0, 20, 0, 20, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7824, 17, 1488, '', 0, 20, 0, 20, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7825, 17, 1489, '', 0, 20, 0, 20, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7826, 17, 1490, '', 0, 20, 0, 20, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7827, 17, 1491, '', 0, 20, 0, 20, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7828, 17, 1492, '', 0, 20, 0, 20, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7829, 17, 1493, '', 0, 20, 0, 20, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7830, 17, 1494, '', 0, 20, 0, 20, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7831, 17, 1495, '', 0, 20, 0, 20, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7832, 17, 1496, '', 0, 20, 0, 20, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7833, 17, 1497, '', 0, 20, 0, 20, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7834, 17, 1498, '', 0, 0, 0, 0, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7835, 17, 1499, '', 0, 0, 0, 0, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7836, 17, 1500, '', 0, 0, 0, 0, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7837, 17, 1501, '', 0, 0, 0, 0, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7838, 17, 1502, '', 0, 0, 0, 0, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7839, 17, 1503, '', 0, 0, 0, 0, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7840, 17, 1504, '', 0, 0, 0, 0, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7841, 17, 1505, '', 0, 0, 0, 0, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7842, 17, 1506, '', 0, 0, 0, 0, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7843, 17, 1507, '', 0, 0, 0, 0, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7844, 17, 1508, '', 0, 0, 0, 0, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7845, 17, 1509, '', 0, 0, 0, 0, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7846, 17, 1510, '', 0, 0, 0, 0, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7847, 17, 1511, '', 0, 0, 0, 0, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7848, 17, 1512, '', 0, 0, 0, 0, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7849, 17, 1513, '', 0, 0, 0, 0, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7850, 17, 1514, '', 0, 0, 0, 0, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7851, 17, 1515, '', 0, 0, 0, 0, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7852, 17, 1516, '', 0, 0, 0, 0, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7853, 17, 1517, '', 0, 0, 0, 0, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7854, 17, 1518, '', 0, 0, 0, 0, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7855, 17, 1519, '', 0, 0, 0, 0, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7856, 17, 1520, '', 0, 0, 0, 0, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7857, 17, 1521, '', 0, 0, 0, 0, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7858, 17, 1522, '', 0, 0, 0, 0, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7859, 17, 1526, '', 0, 20, 0, 20, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7860, 17, 1527, '', 0, 20, 1, 19, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7861, 17, 1528, '', 0, 20, 0, 20, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7862, 17, 1529, '', 0, 20, 1, 19, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7863, 17, 1530, '', 0, 20, 2, 18, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7864, 17, 1531, '', 0, 20, 0, 20, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7865, 17, 1532, '', 0, 20, 1, 19, '2026-05-25 22:10:03', '2026-05-25 22:10:03'),
(7866, 54, 1340, NULL, 0, 20, 0, 20, '2026-06-06 15:42:10', '2026-06-06 15:42:10'),
(7867, 54, 1341, NULL, 0, 20, 10, 10, '2026-06-06 15:42:10', '2026-06-06 15:42:10'),
(7868, 54, 1342, NULL, 0, 20, 0, 20, '2026-06-06 15:42:10', '2026-06-06 15:42:10'),
(7869, 54, 1343, NULL, 0, 20, 0, 20, '2026-06-06 15:42:10', '2026-06-06 15:42:10'),
(7870, 54, 1344, NULL, 0, 20, 0, 20, '2026-06-06 15:42:10', '2026-06-06 15:42:10'),
(7871, 54, 1345, NULL, 0, 20, 0, 20, '2026-06-06 15:42:10', '2026-06-06 15:42:10'),
(7872, 54, 1346, NULL, 0, 20, 0, 20, '2026-06-06 15:42:10', '2026-06-06 15:42:10'),
(7873, 54, 1347, NULL, 0, 20, 0, 20, '2026-06-06 15:42:10', '2026-06-06 15:42:10'),
(7874, 54, 1348, NULL, 0, 20, 0, 20, '2026-06-06 15:42:10', '2026-06-06 15:42:10'),
(7875, 54, 1349, NULL, 0, 20, 20, 0, '2026-06-06 15:42:10', '2026-06-06 15:42:10'),
(7876, 54, 1350, NULL, 0, 20, 3, 17, '2026-06-06 15:42:10', '2026-06-06 15:42:10'),
(7877, 54, 1351, NULL, 0, 20, 0, 20, '2026-06-06 15:42:10', '2026-06-06 15:42:10'),
(7878, 54, 1352, NULL, 0, 20, 1, 19, '2026-06-06 15:42:10', '2026-06-06 15:42:10'),
(7879, 54, 1353, NULL, 0, 20, 0, 20, '2026-06-06 15:42:10', '2026-06-06 15:42:10'),
(7880, 54, 1354, NULL, 0, 20, 18, 2, '2026-06-06 15:42:10', '2026-06-06 15:42:10'),
(7881, 54, 1355, NULL, 0, 20, 0, 20, '2026-06-06 15:42:10', '2026-06-06 15:42:10'),
(7882, 54, 1356, NULL, 0, 20, 0, 20, '2026-06-06 15:42:10', '2026-06-06 15:42:10'),
(7883, 54, 1357, NULL, 0, 20, 0, 20, '2026-06-06 15:42:10', '2026-06-06 15:42:10'),
(7884, 54, 1358, NULL, 0, 20, 0, 20, '2026-06-06 15:42:10', '2026-06-06 15:42:10'),
(7885, 54, 1359, NULL, 0, 20, 0, 20, '2026-06-06 15:42:10', '2026-06-06 15:42:10'),
(7886, 54, 1360, NULL, 0, 20, 0, 20, '2026-06-06 15:42:10', '2026-06-06 15:42:10'),
(7887, 54, 1361, NULL, 0, 20, 0, 20, '2026-06-06 15:42:10', '2026-06-06 15:42:10'),
(7888, 54, 1362, NULL, 0, 20, 0, 20, '2026-06-06 15:42:10', '2026-06-06 15:42:10'),
(7889, 54, 1363, NULL, 0, 20, 0, 20, '2026-06-06 15:42:10', '2026-06-06 15:42:10'),
(7890, 54, 1364, NULL, 0, 20, 0, 20, '2026-06-06 15:42:10', '2026-06-06 15:42:10'),
(7891, 54, 1365, NULL, 0, 20, 1, 19, '2026-06-06 15:42:10', '2026-06-06 15:42:10'),
(7892, 54, 1366, NULL, 0, 0, 0, 0, '2026-06-06 15:42:10', '2026-06-06 15:42:10'),
(7893, 54, 1367, NULL, 0, 0, 0, 0, '2026-06-06 15:42:10', '2026-06-06 15:42:10'),
(7894, 54, 1368, NULL, 0, 0, 0, 0, '2026-06-06 15:42:10', '2026-06-06 15:42:10'),
(7895, 54, 1369, NULL, 0, 0, 0, 0, '2026-06-06 15:42:10', '2026-06-06 15:42:10'),
(7896, 54, 1394, NULL, 0, 20, 1, 19, '2026-06-06 15:42:10', '2026-06-06 15:42:10'),
(7897, 54, 1395, NULL, 0, 20, 1, 19, '2026-06-06 15:42:10', '2026-06-06 15:42:10'),
(7898, 54, 1396, NULL, 0, 20, 2, 18, '2026-06-06 15:42:10', '2026-06-06 15:42:10'),
(7899, 54, 1397, NULL, 0, 20, 0, 20, '2026-06-06 15:42:10', '2026-06-06 15:42:10'),
(7900, 54, 1398, NULL, 0, 20, 0, 20, '2026-06-06 15:42:10', '2026-06-06 15:42:10'),
(7901, 54, 1399, NULL, 0, 20, 0, 20, '2026-06-06 15:42:10', '2026-06-06 15:42:10'),
(7902, 54, 1400, NULL, 0, 20, 0, 20, '2026-06-06 15:42:10', '2026-06-06 15:42:10'),
(7903, 54, 1401, NULL, 0, 20, 0, 20, '2026-06-06 15:42:10', '2026-06-06 15:42:10'),
(7904, 54, 1402, NULL, 0, 20, 0, 20, '2026-06-06 15:42:10', '2026-06-06 15:42:10'),
(7905, 54, 1403, NULL, 0, 20, 0, 20, '2026-06-06 15:42:10', '2026-06-06 15:42:10'),
(7906, 54, 1404, NULL, 0, 20, 5, 15, '2026-06-06 15:42:10', '2026-06-06 15:42:10'),
(7907, 54, 1405, NULL, 0, 20, 2, 18, '2026-06-06 15:42:10', '2026-06-06 15:42:10'),
(7908, 57, 1712, NULL, 0, 150, 1, 149, '2026-06-06 17:55:47', '2026-06-06 17:55:47'),
(7909, 57, 1713, NULL, 0, 150, 3, 147, '2026-06-06 17:55:47', '2026-06-06 17:55:47'),
(7910, 57, 1714, NULL, 0, 150, 5, 145, '2026-06-06 17:55:47', '2026-06-06 17:55:47'),
(7911, 57, 1715, NULL, 0, 150, 3, 147, '2026-06-06 17:55:47', '2026-06-06 17:55:47'),
(7912, 57, 1716, NULL, 0, 150, 1, 149, '2026-06-06 17:55:47', '2026-06-06 17:55:47'),
(7913, 57, 1717, NULL, 0, 150, 4, 146, '2026-06-06 17:55:47', '2026-06-06 17:55:47'),
(7914, 57, 1718, NULL, 0, 150, 0, 150, '2026-06-06 17:55:47', '2026-06-06 17:55:47'),
(7915, 57, 1719, NULL, 0, 150, 4, 146, '2026-06-06 17:55:48', '2026-06-06 17:55:48'),
(7916, 57, 1720, NULL, 0, 150, 3, 147, '2026-06-06 17:55:48', '2026-06-06 17:55:48'),
(7917, 57, 1721, NULL, 0, 150, 2, 148, '2026-06-06 17:55:48', '2026-06-06 17:55:48'),
(7918, 57, 1722, NULL, 0, 150, 2, 148, '2026-06-06 17:55:48', '2026-06-06 17:55:48'),
(7919, 57, 1723, NULL, 0, 150, 1, 149, '2026-06-06 17:55:48', '2026-06-06 17:55:48'),
(7920, 57, 1724, NULL, 0, 150, 3, 147, '2026-06-06 17:55:48', '2026-06-06 17:55:48'),
(7921, 57, 1725, NULL, 0, 150, 2, 148, '2026-06-06 17:55:48', '2026-06-06 17:55:48'),
(7922, 57, 1726, NULL, 0, 150, 4, 146, '2026-06-06 17:55:48', '2026-06-06 17:55:48'),
(7923, 57, 1727, NULL, 0, 150, 1, 149, '2026-06-06 17:55:48', '2026-06-06 17:55:48'),
(7924, 57, 1728, NULL, 0, 150, 3, 147, '2026-06-06 17:55:48', '2026-06-06 17:55:48'),
(7925, 57, 1729, NULL, 0, 150, 4, 146, '2026-06-06 17:55:48', '2026-06-06 17:55:48'),
(7926, 57, 1730, NULL, 0, 150, 2, 148, '2026-06-06 17:55:48', '2026-06-06 17:55:48'),
(7927, 57, 1731, NULL, 0, 150, 4, 146, '2026-06-06 17:55:48', '2026-06-06 17:55:48'),
(7928, 57, 1732, NULL, 0, 150, 5, 145, '2026-06-06 17:55:48', '2026-06-06 17:55:48'),
(7929, 57, 1733, NULL, 0, 150, 5, 145, '2026-06-06 17:55:48', '2026-06-06 17:55:48'),
(7930, 57, 1734, NULL, 0, 150, 5, 145, '2026-06-06 17:55:48', '2026-06-06 17:55:48'),
(7931, 57, 1735, NULL, 0, 150, 6, 144, '2026-06-06 17:55:48', '2026-06-06 17:55:48'),
(7932, 57, 1736, NULL, 0, 150, 4, 146, '2026-06-06 17:55:48', '2026-06-06 17:55:48'),
(7933, 57, 1737, NULL, 0, 150, 5, 145, '2026-06-06 17:55:48', '2026-06-06 17:55:48'),
(7934, 57, 1738, NULL, 0, 150, 4, 146, '2026-06-06 17:55:48', '2026-06-06 17:55:48'),
(7935, 57, 1739, NULL, 0, 150, 5, 145, '2026-06-06 17:55:48', '2026-06-06 17:55:48'),
(7936, 57, 1740, NULL, 0, 150, 4, 146, '2026-06-06 17:55:48', '2026-06-06 17:55:48'),
(7937, 57, 1741, NULL, 0, 150, 10, 140, '2026-06-06 17:55:48', '2026-06-06 17:55:48'),
(7938, 57, 1742, NULL, 0, 150, 7, 143, '2026-06-06 17:55:48', '2026-06-06 17:55:48'),
(7939, 57, 1743, NULL, 0, 150, 5, 145, '2026-06-06 17:55:48', '2026-06-06 17:55:48'),
(7962, 60, 1853, '', 0, 20, 0, 20, '2026-06-10 13:48:17', '2026-06-10 13:48:17'),
(7963, 60, 1854, '', 0, 20, 0, 20, '2026-06-10 13:48:17', '2026-06-10 13:48:17'),
(7964, 60, 1855, '', 0, 20, 0, 20, '2026-06-10 13:48:17', '2026-06-10 13:48:17'),
(7965, 60, 1856, '', 0, 20, 0, 20, '2026-06-10 13:48:17', '2026-06-10 13:48:17'),
(7966, 60, 1857, '', 0, 20, 0, 20, '2026-06-10 13:48:17', '2026-06-10 13:48:17'),
(7967, 60, 1858, '', 0, 20, 0, 20, '2026-06-10 13:48:17', '2026-06-10 13:48:17'),
(7968, 60, 1859, '', 0, 20, 0, 20, '2026-06-10 13:48:17', '2026-06-10 13:48:17'),
(7969, 60, 1860, '', 0, 20, 0, 20, '2026-06-10 13:48:17', '2026-06-10 13:48:17'),
(7970, 60, 1861, '', 0, 20, 0, 20, '2026-06-10 13:48:17', '2026-06-10 13:48:17'),
(7971, 60, 1862, '', 0, 20, 0, 20, '2026-06-10 13:48:17', '2026-06-10 13:48:17'),
(7972, 60, 1863, '', 0, 20, 0, 20, '2026-06-10 13:48:17', '2026-06-10 13:48:17'),
(8051, 65, 1340, NULL, 0, 0, 0, 0, '2026-06-11 18:31:40', '2026-06-11 18:31:40'),
(8052, 65, 1341, NULL, 0, 0, 0, 0, '2026-06-11 18:31:40', '2026-06-11 18:31:40'),
(8053, 65, 1342, NULL, 0, 0, 0, 0, '2026-06-11 18:31:40', '2026-06-11 18:31:40'),
(8054, 65, 1343, NULL, 0, 0, 0, 0, '2026-06-11 18:31:40', '2026-06-11 18:31:40'),
(8055, 65, 1344, NULL, 0, 0, 0, 0, '2026-06-11 18:31:40', '2026-06-11 18:31:40'),
(8056, 65, 1345, NULL, 0, 0, 0, 0, '2026-06-11 18:31:40', '2026-06-11 18:31:40'),
(8057, 65, 1346, NULL, 0, 0, 0, 0, '2026-06-11 18:31:40', '2026-06-11 18:31:40'),
(8058, 65, 1347, NULL, 0, 0, 0, 0, '2026-06-11 18:31:40', '2026-06-11 18:31:40'),
(8059, 65, 1348, NULL, 0, 0, 0, 0, '2026-06-11 18:31:40', '2026-06-11 18:31:40'),
(8060, 65, 1349, NULL, 0, 0, 0, 0, '2026-06-11 18:31:40', '2026-06-11 18:31:40'),
(8061, 65, 1350, NULL, 0, 0, 0, 0, '2026-06-11 18:31:40', '2026-06-11 18:31:40'),
(8062, 65, 1351, NULL, 0, 0, 0, 0, '2026-06-11 18:31:40', '2026-06-11 18:31:40'),
(8063, 65, 1352, NULL, 0, 0, 0, 0, '2026-06-11 18:31:40', '2026-06-11 18:31:40'),
(8064, 65, 1353, NULL, 0, 0, 0, 0, '2026-06-11 18:31:40', '2026-06-11 18:31:40'),
(8065, 65, 1354, NULL, 0, 0, 0, 0, '2026-06-11 18:31:40', '2026-06-11 18:31:40'),
(8066, 65, 1355, NULL, 0, 0, 0, 0, '2026-06-11 18:31:40', '2026-06-11 18:31:40'),
(8067, 65, 1356, NULL, 0, 0, 0, 0, '2026-06-11 18:31:40', '2026-06-11 18:31:40'),
(8068, 65, 1357, NULL, 0, 0, 0, 0, '2026-06-11 18:31:40', '2026-06-11 18:31:40'),
(8069, 65, 1358, NULL, 0, 0, 0, 0, '2026-06-11 18:31:40', '2026-06-11 18:31:40'),
(8070, 65, 1359, NULL, 0, 0, 0, 0, '2026-06-11 18:31:40', '2026-06-11 18:31:40'),
(8071, 65, 1360, NULL, 0, 0, 0, 0, '2026-06-11 18:31:40', '2026-06-11 18:31:40'),
(8072, 65, 1361, NULL, 0, 0, 0, 0, '2026-06-11 18:31:40', '2026-06-11 18:31:40'),
(8073, 65, 1362, NULL, 0, 0, 0, 0, '2026-06-11 18:31:40', '2026-06-11 18:31:40'),
(8074, 65, 1363, NULL, 0, 0, 0, 0, '2026-06-11 18:31:40', '2026-06-11 18:31:40'),
(8075, 65, 1364, NULL, 0, 0, 0, 0, '2026-06-11 18:31:40', '2026-06-11 18:31:40'),
(8076, 65, 1365, NULL, 0, 0, 0, 0, '2026-06-11 18:31:40', '2026-06-11 18:31:40'),
(8077, 65, 1366, NULL, 0, 0, 0, 0, '2026-06-11 18:31:40', '2026-06-11 18:31:40'),
(8078, 65, 1367, NULL, 0, 0, 0, 0, '2026-06-11 18:31:40', '2026-06-11 18:31:40'),
(8079, 65, 1368, NULL, 0, 0, 0, 0, '2026-06-11 18:31:40', '2026-06-11 18:31:40'),
(8080, 65, 1369, NULL, 0, 0, 0, 0, '2026-06-11 18:31:40', '2026-06-11 18:31:40'),
(8081, 65, 1394, NULL, 0, 0, 0, 0, '2026-06-11 18:31:40', '2026-06-11 18:31:40'),
(8082, 65, 1395, NULL, 0, 0, 0, 0, '2026-06-11 18:31:40', '2026-06-11 18:31:40'),
(8083, 65, 1396, NULL, 0, 0, 0, 0, '2026-06-11 18:31:40', '2026-06-11 18:31:40'),
(8084, 65, 1397, NULL, 0, 0, 0, 0, '2026-06-11 18:31:40', '2026-06-11 18:31:40'),
(8085, 65, 1398, NULL, 0, 0, 0, 0, '2026-06-11 18:31:40', '2026-06-11 18:31:40'),
(8086, 65, 1399, NULL, 0, 0, 0, 0, '2026-06-11 18:31:40', '2026-06-11 18:31:40'),
(8087, 65, 1400, NULL, 0, 0, 0, 0, '2026-06-11 18:31:40', '2026-06-11 18:31:40'),
(8088, 65, 1401, NULL, 0, 0, 0, 0, '2026-06-11 18:31:40', '2026-06-11 18:31:40'),
(8089, 65, 1402, NULL, 0, 0, 0, 0, '2026-06-11 18:31:40', '2026-06-11 18:31:40'),
(8090, 65, 1403, NULL, 0, 0, 0, 0, '2026-06-11 18:31:40', '2026-06-11 18:31:40'),
(8091, 65, 1404, NULL, 0, 0, 0, 0, '2026-06-11 18:31:40', '2026-06-11 18:31:40'),
(8092, 65, 1405, NULL, 0, 0, 0, 0, '2026-06-11 18:31:40', '2026-06-11 18:31:40'),
(8093, 63, 848, '', 0, 20, 1, 19, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8094, 63, 849, '', 0, 20, 0, 20, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8095, 63, 850, '', 0, 20, 1, 19, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8096, 63, 851, '', 0, 20, 0, 20, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8097, 63, 852, '', 0, 20, 6, 14, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8098, 63, 853, '', 0, 20, 1, 19, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8099, 63, 854, '', 0, 20, 7.7, 12.3, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8100, 63, 855, '', 0, 20, 0, 20, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8101, 63, 856, '', 0, 20, 0, 20, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8102, 63, 857, '', 0, 20, 0, 20, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8103, 63, 858, '', 0, 20, 0, 20, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8104, 63, 859, '', 0, 20, 0, 20, '2026-06-11 23:10:22', '2026-06-11 23:10:22');
INSERT INTO `trampa_roedor_seguimientos` (`id`, `seguimiento_id`, `trampa_id`, `observacion`, `cantidad`, `inicial`, `merma`, `actual`, `created_at`, `updated_at`) VALUES
(8105, 63, 860, '', 0, 20, 0, 20, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8106, 63, 1465, '', 0, 20, 1, 19, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8107, 63, 1466, '', 0, 20, 1, 19, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8108, 63, 1467, '', 0, 20, 2, 18, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8109, 63, 1468, '', 0, 20, 0, 20, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8110, 63, 1469, '', 0, 20, 1, 19, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8111, 63, 1470, '', 0, 20, 2, 18, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8112, 63, 1471, '', 0, 20, 0, 20, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8113, 63, 1472, '', 0, 20, 1, 19, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8114, 63, 1473, '', 0, 20, 0, 20, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8115, 63, 1474, '', 0, 20, 1, 19, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8116, 63, 1475, '', 0, 20, 1, 19, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8117, 63, 1476, '', 0, 20, 0, 20, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8118, 63, 1477, '', 0, 20, 1, 19, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8119, 63, 1478, '', 0, 0, 0, 0, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8120, 63, 1479, '', 0, 0, 0, 0, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8121, 63, 1480, '', 0, 0, 0, 0, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8122, 63, 1481, '', 0, 0, 0, 0, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8123, 63, 1482, '', 0, 20, 0, 20, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8124, 63, 1483, '', 0, 20, 1, 19, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8125, 63, 1484, '', 0, 20, 0, 20, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8126, 63, 1485, '', 0, 20, 1, 19, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8127, 63, 1486, '', 0, 20, 0, 20, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8128, 63, 1487, '', 0, 20, 1, 19, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8129, 63, 1488, '', 0, 20, 2, 18, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8130, 63, 1489, '', 0, 20, 1, 19, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8131, 63, 1490, '', 0, 20, 1, 19, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8132, 63, 1491, '', 0, 20, 2, 18, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8133, 63, 1492, '', 0, 20, 0, 20, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8134, 63, 1493, '', 0, 20, 2, 18, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8135, 63, 1494, '', 0, 20, 3, 17, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8136, 63, 1495, '', 0, 20, 6, 14, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8137, 63, 1496, '', 0, 20, 0, 20, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8138, 63, 1497, '', 0, 20, 0, 20, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8139, 63, 1498, '', 0, 0, 0, 0, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8140, 63, 1499, '', 0, 0, 0, 0, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8141, 63, 1500, '', 0, 0, 0, 0, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8142, 63, 1501, '', 0, 0, 0, 0, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8143, 63, 1502, '', 0, 0, 0, 0, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8144, 63, 1503, '', 0, 0, 0, 0, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8145, 63, 1504, '', 0, 0, 0, 0, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8146, 63, 1505, '', 0, 0, 0, 0, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8147, 63, 1506, '', 0, 0, 0, 0, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8148, 63, 1507, '', 0, 0, 0, 0, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8149, 63, 1508, '', 0, 0, 0, 0, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8150, 63, 1509, '', 0, 0, 0, 0, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8151, 63, 1510, '', 0, 0, 0, 0, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8152, 63, 1511, '', 0, 0, 0, 0, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8153, 63, 1512, '', 0, 0, 0, 0, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8154, 63, 1513, '', 0, 0, 0, 0, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8155, 63, 1514, '', 0, 0, 0, 0, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8156, 63, 1515, '', 0, 0, 0, 0, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8157, 63, 1516, '', 0, 0, 0, 0, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8158, 63, 1517, '', 0, 0, 0, 0, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8159, 63, 1518, '', 0, 0, 0, 0, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8160, 63, 1519, '', 0, 0, 0, 0, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8161, 63, 1520, '', 0, 0, 0, 0, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8162, 63, 1521, '', 0, 0, 0, 0, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8163, 63, 1522, '', 0, 0, 0, 0, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8164, 63, 1526, '', 0, 20, 11.7, 8.3, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8165, 63, 1527, '', 0, 20, 2, 18, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8166, 63, 1528, '', 0, 20, 4, 16, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8167, 63, 1529, '', 0, 20, 4.7, 15.3, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8168, 63, 1530, '', 0, 20, 2, 18, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8169, 63, 1531, '', 0, 20, 0, 20, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8170, 63, 1532, '', 0, 20, 12, 8, '2026-06-11 23:10:22', '2026-06-11 23:10:22'),
(8431, 66, 1152, NULL, 0, 28, 8, 20, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8432, 66, 1153, NULL, 0, 20, 0, 20, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8433, 66, 1154, NULL, 0, 20, 1, 19, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8434, 66, 1155, NULL, 0, 20, 0, 20, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8435, 66, 1156, NULL, 0, 20, 2, 18, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8436, 66, 1157, NULL, 0, 0, -17, 17, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8437, 66, 1158, NULL, 0, 20, 0, 20, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8438, 66, 1159, NULL, 0, 20, 5, 15, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8439, 66, 1160, NULL, 0, 20, 8, 12, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8440, 66, 1161, NULL, 0, 20, 9, 11, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8441, 66, 1162, NULL, 0, 20, 0, 20, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8442, 66, 1163, NULL, 0, 20, 0, 20, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8443, 66, 1164, NULL, 0, 20, 0, 20, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8444, 66, 1165, NULL, 0, 20, 1, 19, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8445, 66, 1166, NULL, 0, 20, 0, 20, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8446, 66, 1167, NULL, 0, 20, 0, 20, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8447, 66, 1168, NULL, 0, 20, 1, 19, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8448, 66, 1169, NULL, 0, 20, 2, 18, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8449, 66, 1170, NULL, 0, 20, 1, 19, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8450, 66, 1171, NULL, 0, 20, 1, 19, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8451, 66, 1172, NULL, 0, 20, 2, 18, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8452, 66, 1173, NULL, 0, 20, 3, 17, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8453, 66, 1174, NULL, 0, 20, 1, 19, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8454, 66, 1175, NULL, 0, 20, 0, 20, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8455, 66, 1176, NULL, 0, 20, 2, 18, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8456, 66, 1177, NULL, 0, 20, 20, 0, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8457, 66, 1178, NULL, 0, 20, 12, 8, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8458, 66, 1179, NULL, 0, 20, 4, 16, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8459, 66, 1180, NULL, 0, 20, 1, 19, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8460, 66, 1181, NULL, 0, 20, 20, 0, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8461, 66, 1182, NULL, 0, 20, 1, 19, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8462, 66, 1183, NULL, 0, 20, 10, 10, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8463, 66, 1184, NULL, 0, 20, 2, 18, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8464, 66, 1185, NULL, 0, 20, 3, 17, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8465, 66, 1186, NULL, 0, 20, 0, 20, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8466, 66, 1187, NULL, 0, 20, 0, 20, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8467, 66, 1188, NULL, 0, 20, 1, 19, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8468, 66, 1189, NULL, 0, 20, 1, 19, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8469, 66, 1190, NULL, 0, 20, 0, 20, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8470, 66, 1191, NULL, 0, 20, 0, 20, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8471, 66, 1192, NULL, 0, 20, 0, 20, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8472, 66, 1193, NULL, 0, 20, 1, 19, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8473, 66, 1194, NULL, 0, 20, 1, 19, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8474, 66, 1195, NULL, 0, 20, 0, 20, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8475, 66, 1196, NULL, 0, 20, 0, 20, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8476, 66, 1197, NULL, 0, 20, 0, 20, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8477, 66, 1198, NULL, 0, 20, 2, 18, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8478, 66, 1199, NULL, 0, 20, 1, 19, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8479, 66, 1200, NULL, 0, 20, 0, 20, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8480, 66, 1201, NULL, 0, 20, 0, 20, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8481, 66, 1202, NULL, 0, 20, 0, 20, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8482, 66, 1203, NULL, 0, 20, 0, 20, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8483, 66, 1204, NULL, 0, 20, 0, 20, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8484, 66, 1205, NULL, 0, 20, 0, 20, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8485, 66, 1206, NULL, 0, 20, 0, 20, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8486, 66, 1207, NULL, 0, 20, 0, 20, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8487, 66, 1208, NULL, 0, 20, 0, 20, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8488, 66, 1209, NULL, 0, 20, 0, 20, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8489, 66, 1210, NULL, 0, 20, 0, 20, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8490, 66, 1211, NULL, 0, 20, 1, 19, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8491, 66, 1212, NULL, 0, 20, 0, 20, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8492, 66, 1213, NULL, 0, 20, 0, 20, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8493, 66, 1214, NULL, 0, 20, 0, 20, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8494, 66, 1215, NULL, 0, 20, 0, 20, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8495, 66, 1216, NULL, 0, 20, 0, 20, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8496, 66, 1217, NULL, 0, 20, 0, 20, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8497, 66, 1218, NULL, 0, 20, 0, 20, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8498, 66, 1219, NULL, 0, 20, 0, 20, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8499, 66, 1220, NULL, 0, 20, -2000, 2020, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8500, 66, 1221, NULL, 0, 0, -20, 20, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8501, 66, 1222, NULL, 0, 28, 8, 20, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8502, 66, 1223, NULL, 0, 20, 0, 20, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8503, 66, 1224, NULL, 0, 28, 8, 20, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8504, 66, 1225, NULL, 0, 20, 0, 20, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8505, 66, 1226, NULL, 0, 20, 0, 20, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8506, 66, 1227, NULL, 0, 20, 0, 20, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8507, 66, 1228, NULL, 0, 20, 0, 20, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8508, 66, 1229, NULL, 0, 20, 0, 20, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8509, 66, 1230, NULL, 0, 20, 0, 20, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8510, 66, 1231, NULL, 0, 20, 0, 20, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8511, 66, 1232, NULL, 0, 20, 0, 20, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8512, 66, 1233, NULL, 0, 20, 0, 20, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8513, 66, 1234, NULL, 0, 28, 8, 20, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8514, 66, 1235, NULL, 0, 20, 0, 20, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8515, 66, 1236, NULL, 0, 20, 0, 20, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8516, 66, 1237, NULL, 0, 20, 0, 20, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8517, 66, 1238, NULL, 0, 20, 0, 20, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8518, 66, 1239, NULL, 0, 20, 0, 20, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8519, 66, 1240, NULL, 0, 20, 0, 20, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8520, 66, 1241, NULL, 0, 20, 0, 20, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8521, 66, 1242, NULL, 0, 20, 0, 20, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8522, 66, 1243, NULL, 0, 20, 0, 20, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8523, 66, 1244, NULL, 0, 20, 0, 20, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8524, 66, 1245, NULL, 0, 20, 0, 20, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8525, 66, 1246, NULL, 0, 20, 0, 20, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8526, 66, 1247, NULL, 0, 20, 0, 20, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8527, 66, 1248, NULL, 0, 20, 0, 20, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8528, 66, 1249, NULL, 0, 20, 0, 20, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8529, 66, 1250, NULL, 0, 20, 2, 18, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8530, 66, 1251, NULL, 0, 20, 1, 19, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8531, 66, 1252, NULL, 0, 0, 0, 0, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8532, 66, 1253, NULL, 0, 0, 0, 0, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8533, 66, 1254, NULL, 0, 0, 0, 0, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8534, 66, 1255, NULL, 0, 0, 0, 0, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8535, 66, 1256, NULL, 0, 0, 0, 0, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8536, 66, 1257, NULL, 0, 0, 0, 0, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8537, 66, 1258, NULL, 0, 0, 0, 0, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8538, 66, 1259, NULL, 0, 0, 0, 0, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8539, 66, 1260, NULL, 0, 0, 0, 0, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8540, 66, 1261, NULL, 0, 0, 0, 0, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8541, 66, 1262, NULL, 0, 0, 0, 0, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8542, 66, 1263, NULL, 0, 0, 0, 0, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8543, 66, 1264, NULL, 0, 0, 0, 0, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8544, 66, 1265, NULL, 0, 0, 0, 0, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8545, 66, 1266, NULL, 0, 0, 0, 0, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8546, 66, 1267, NULL, 0, 0, 0, 0, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8547, 66, 1268, NULL, 0, 0, 0, 0, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8548, 66, 1269, NULL, 0, 0, 0, 0, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8549, 66, 1270, NULL, 0, 0, 0, 0, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8550, 66, 1271, NULL, 0, 0, 0, 0, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8551, 66, 1272, NULL, 0, 0, 0, 0, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8552, 66, 1273, NULL, 0, 0, 0, 0, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8553, 66, 1274, NULL, 0, 0, 0, 0, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8554, 66, 1275, NULL, 0, 0, 0, 0, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8555, 66, 1276, NULL, 0, 0, 0, 0, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8556, 66, 1277, NULL, 0, 0, 0, 0, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8557, 66, 1278, NULL, 0, 0, 0, 0, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8558, 66, 1279, NULL, 0, 0, 0, 0, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8559, 66, 1280, NULL, 0, 0, 0, 0, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8560, 66, 1281, NULL, 0, 0, 0, 0, '2026-06-12 22:39:27', '2026-06-12 22:39:27'),
(8561, 69, 1712, NULL, 0, 0, 0, 0, '2026-06-19 18:55:41', '2026-06-19 18:55:41'),
(8562, 69, 1713, NULL, 0, 0, 0, 0, '2026-06-19 18:55:41', '2026-06-19 18:55:41'),
(8563, 69, 1714, NULL, 0, 0, 0, 0, '2026-06-19 18:55:41', '2026-06-19 18:55:41'),
(8564, 69, 1715, NULL, 0, 0, 0, 0, '2026-06-19 18:55:41', '2026-06-19 18:55:41'),
(8565, 69, 1716, NULL, 0, 0, 0, 0, '2026-06-19 18:55:41', '2026-06-19 18:55:41'),
(8566, 69, 1717, NULL, 0, 0, 0, 0, '2026-06-19 18:55:41', '2026-06-19 18:55:41'),
(8567, 69, 1718, NULL, 0, 0, 0, 0, '2026-06-19 18:55:41', '2026-06-19 18:55:41'),
(8568, 69, 1719, NULL, 0, 0, 0, 0, '2026-06-19 18:55:41', '2026-06-19 18:55:41'),
(8569, 69, 1720, NULL, 0, 0, 0, 0, '2026-06-19 18:55:41', '2026-06-19 18:55:41'),
(8570, 69, 1721, NULL, 0, 0, 0, 0, '2026-06-19 18:55:41', '2026-06-19 18:55:41'),
(8571, 69, 1722, NULL, 0, 0, 0, 0, '2026-06-19 18:55:41', '2026-06-19 18:55:41'),
(8572, 69, 1723, NULL, 0, 0, 0, 0, '2026-06-19 18:55:41', '2026-06-19 18:55:41'),
(8573, 69, 1724, NULL, 0, 0, 0, 0, '2026-06-19 18:55:41', '2026-06-19 18:55:41'),
(8574, 69, 1725, NULL, 0, 0, 0, 0, '2026-06-19 18:55:41', '2026-06-19 18:55:41'),
(8575, 69, 1726, NULL, 0, 0, 0, 0, '2026-06-19 18:55:41', '2026-06-19 18:55:41'),
(8576, 69, 1727, NULL, 0, 0, 0, 0, '2026-06-19 18:55:41', '2026-06-19 18:55:41'),
(8577, 69, 1728, NULL, 0, 0, 0, 0, '2026-06-19 18:55:41', '2026-06-19 18:55:41'),
(8578, 69, 1729, NULL, 0, 0, 0, 0, '2026-06-19 18:55:41', '2026-06-19 18:55:41'),
(8579, 69, 1730, NULL, 0, 0, 0, 0, '2026-06-19 18:55:41', '2026-06-19 18:55:41'),
(8580, 69, 1731, NULL, 0, 0, 0, 0, '2026-06-19 18:55:41', '2026-06-19 18:55:41'),
(8581, 69, 1732, NULL, 0, 0, 0, 0, '2026-06-19 18:55:41', '2026-06-19 18:55:41'),
(8582, 69, 1733, NULL, 0, 0, 0, 0, '2026-06-19 18:55:41', '2026-06-19 18:55:41'),
(8583, 69, 1734, NULL, 0, 0, 0, 0, '2026-06-19 18:55:41', '2026-06-19 18:55:41'),
(8584, 69, 1735, NULL, 0, 0, 0, 0, '2026-06-19 18:55:41', '2026-06-19 18:55:41'),
(8585, 69, 1736, NULL, 0, 0, 0, 0, '2026-06-19 18:55:41', '2026-06-19 18:55:41'),
(8586, 69, 1737, NULL, 0, 0, 0, 0, '2026-06-19 18:55:41', '2026-06-19 18:55:41'),
(8587, 69, 1738, NULL, 0, 0, 0, 0, '2026-06-19 18:55:41', '2026-06-19 18:55:41'),
(8588, 69, 1739, NULL, 0, 0, 0, 0, '2026-06-19 18:55:41', '2026-06-19 18:55:41'),
(8589, 69, 1740, NULL, 0, 0, 0, 0, '2026-06-19 18:55:41', '2026-06-19 18:55:41'),
(8590, 69, 1741, NULL, 0, 0, 0, 0, '2026-06-19 18:55:41', '2026-06-19 18:55:41'),
(8591, 69, 1742, NULL, 0, 0, 0, 0, '2026-06-19 18:55:41', '2026-06-19 18:55:41'),
(8592, 69, 1743, NULL, 0, 0, 0, 0, '2026-06-19 18:55:41', '2026-06-19 18:55:41');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `trampa_seguimientos`
--

CREATE TABLE `trampa_seguimientos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `almacen_id` bigint(20) UNSIGNED NOT NULL,
  `mapa_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `observaciones` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `trampa_tipos`
--

CREATE TABLE `trampa_tipos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `imagen` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `trampa_tipos`
--

INSERT INTO `trampa_tipos` (`id`, `nombre`, `imagen`, `created_at`, `updated_at`) VALUES
(1, 'golpe', '/images/trampas/trampa_raton.jpg', '2026-04-13 13:42:19', '2026-04-13 13:42:19'),
(2, 'insecto', '/images/trampas/trampa_insecto.jpg', '2026-04-13 13:42:19', '2026-04-13 13:42:19'),
(3, 'caja', '/images/trampas/caja_negra.jpg', '2026-04-13 13:42:19', '2026-04-13 13:42:19'),
(4, 'viva', '/images/trampas/captura_viva.jpg', '2026-04-13 13:42:19', '2026-04-13 13:42:19'),
(5, 'pegajosa', '/images/trampas/pegajosa.png', '2026-04-13 13:42:19', '2026-04-13 13:42:19');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `unidades`
--

CREATE TABLE `unidades` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `unidades`
--

INSERT INTO `unidades` (`id`, `nombre`, `created_at`, `updated_at`) VALUES
(1, 'Gramos', '2026-04-13 13:42:19', '2026-04-13 13:42:19'),
(2, 'C.C.', '2026-04-13 13:42:19', '2026-04-13 13:42:19'),
(3, 'Unidad', '2026-04-13 13:42:19', '2026-04-13 13:42:19'),
(4, 'Litros', '2026-04-13 13:42:19', '2026-04-13 13:42:19');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `two_factor_secret` text DEFAULT NULL,
  `two_factor_recovery_codes` text DEFAULT NULL,
  `two_factor_confirmed_at` timestamp NULL DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `two_factor_secret`, `two_factor_recovery_codes`, `two_factor_confirmed_at`, `remember_token`, `created_at`, `updated_at`) VALUES
(2, 'admin', 'admin@admin.com', NULL, '$2y$12$Bp2xVW1KGcRy/TSrpPy8FOrmy5cWcLKPe4aNr9rGNhKo6L59nplne', NULL, NULL, NULL, '7qJ8q10xoBp3Y9g9WzeZQEEd036Q16Bcozwotag69DfveBPqKGASbGPYYkmL', '2026-04-15 12:44:45', '2026-04-15 12:44:45'),
(3, 'FERNANDEZ', 'fernandezhenry623x@gmail.com', NULL, '$2y$12$brR.O4EoZymcVOuAGr1L9O16ecHadrzBV2ZwjHI7FktjhYx37Br0G', NULL, NULL, NULL, NULL, '2026-05-06 13:41:21', '2026-05-08 17:33:27'),
(5, 'HENRRY FERNANDEZ', 'fernandezhenry623@gmail.com', NULL, '$2y$12$KX7YscEohFCoL./ilgezg.W.N491g0BMbAz8j/RL7EqOAQtUB7HHK', NULL, NULL, NULL, NULL, '2026-05-08 17:35:15', '2026-05-08 17:35:15'),
(6, 'Kimberly Contreras', 'rfarmaceuticobol@ransa.net', NULL, '$2y$12$vTFHKjnMvix7PluQhrcO4uwIkXQDpZ8fqE.EyiaQPEL6vrUjzua/e', NULL, NULL, NULL, NULL, '2026-06-08 14:40:33', '2026-06-08 14:40:33'),
(7, 'Jessica Escobar', 'jessica_escobar@lacascada.com.bo', NULL, '$2y$12$E2MAe/WxJuofc5C.rrMu2OSPdse/RZspqB36z40a8wAZ/fp5jxlKq', NULL, NULL, NULL, NULL, '2026-06-23 15:33:11', '2026-06-23 15:33:11');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_empresas`
--

CREATE TABLE `usuario_empresas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `empresa_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `usuario_empresas`
--

INSERT INTO `usuario_empresas` (`id`, `user_id`, `empresa_id`, `created_at`, `updated_at`) VALUES
(1, 7, 4, NULL, NULL),
(2, 7, 3, NULL, NULL),
(3, 7, 2, NULL, NULL),
(4, 7, 1, NULL, NULL),
(5, 7, 5, NULL, NULL),
(6, 6, 6, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `cliente_id` bigint(20) UNSIGNED DEFAULT NULL,
  `total` double NOT NULL,
  `tipo` enum('Venta','Pago','Adelanto','Anulado') NOT NULL,
  `metodo` enum('Efectivo','QR','Transferencia') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta_detalles`
--

CREATE TABLE `venta_detalles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `venta_id` bigint(20) UNSIGNED NOT NULL,
  `producto_id` bigint(20) UNSIGNED DEFAULT NULL,
  `precio_venta` double NOT NULL,
  `cantidad` int(11) NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `acciones`
--
ALTER TABLE `acciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `acciones_empresa_id_foreign` (`empresa_id`),
  ADD KEY `acciones_almacen_id_foreign` (`almacen_id`),
  ADD KEY `acciones_user_id_foreign` (`user_id`);

--
-- Indices de la tabla `accion_imagenes`
--
ALTER TABLE `accion_imagenes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `accion_imagenes_accion_id_foreign` (`accion_id`);

--
-- Indices de la tabla `accion_productos`
--
ALTER TABLE `accion_productos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `accion_productos_accion_id_foreign` (`accion_id`),
  ADD KEY `accion_productos_producto_id_foreign` (`producto_id`),
  ADD KEY `accion_productos_unidad_id_foreign` (`unidad_id`);

--
-- Indices de la tabla `accion_trampas`
--
ALTER TABLE `accion_trampas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `accion_trampas_accion_id_foreign` (`accion_id`),
  ADD KEY `accion_trampas_trampa_id_foreign` (`trampa_id`);

--
-- Indices de la tabla `agendas`
--
ALTER TABLE `agendas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `agendas_user_id_foreign` (`user_id`);

--
-- Indices de la tabla `almacenes`
--
ALTER TABLE `almacenes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `almacenes_empresa_id_foreign` (`empresa_id`);

--
-- Indices de la tabla `almacen_areas`
--
ALTER TABLE `almacen_areas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `almacen_areas_almacen_id_foreign` (`almacen_id`);

--
-- Indices de la tabla `almacen_trampas`
--
ALTER TABLE `almacen_trampas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `almacen_trampas_almacen_id_foreign` (`almacen_id`);

--
-- Indices de la tabla `almancen_insectocutores`
--
ALTER TABLE `almancen_insectocutores`
  ADD PRIMARY KEY (`id`),
  ADD KEY `almancen_insectocutores_almacen_id_foreign` (`almacen_id`);

--
-- Indices de la tabla `aplicaciones`
--
ALTER TABLE `aplicaciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `aplicaciones_seguimiento_id_foreign` (`seguimiento_id`);

--
-- Indices de la tabla `biologicos`
--
ALTER TABLE `biologicos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `buffer_productos`
--
ALTER TABLE `buffer_productos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `buffer_productos_producto_id_foreign` (`producto_id`);

--
-- Indices de la tabla `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indices de la tabla `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `certificados`
--
ALTER TABLE `certificados`
  ADD PRIMARY KEY (`id`),
  ADD KEY `certificados_empresa_id_foreign` (`empresa_id`),
  ADD KEY `certificados_user_id_foreign` (`user_id`);

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `cobrar_cuotas`
--
ALTER TABLE `cobrar_cuotas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cobrar_cuotas_cuenta_cobrar_id_foreign` (`cuenta_cobrar_id`);

--
-- Indices de la tabla `cobrar_pagos`
--
ALTER TABLE `cobrar_pagos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cobrar_pagos_cuenta_cobrar_id_foreign` (`cuenta_cobrar_id`),
  ADD KEY `cobrar_pagos_cuota_id_foreign` (`cuota_id`);

--
-- Indices de la tabla `compras`
--
ALTER TABLE `compras`
  ADD PRIMARY KEY (`id`),
  ADD KEY `compras_user_id_foreign` (`user_id`),
  ADD KEY `compras_proveedor_id_foreign` (`proveedor_id`);

--
-- Indices de la tabla `compra_detalles`
--
ALTER TABLE `compra_detalles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `compra_detalles_compra_id_foreign` (`compra_id`),
  ADD KEY `compra_detalles_producto_id_foreign` (`producto_id`);

--
-- Indices de la tabla `contactos`
--
ALTER TABLE `contactos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `contactos_almacen_id_foreign` (`almacen_id`);

--
-- Indices de la tabla `contratos`
--
ALTER TABLE `contratos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `contratos_empresa_id_foreign` (`empresa_id`);

--
-- Indices de la tabla `contrato_detalles`
--
ALTER TABLE `contrato_detalles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `contrato_detalles_contrato_id_foreign` (`contrato_id`);

--
-- Indices de la tabla `cotizaciones`
--
ALTER TABLE `cotizaciones`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `cotizacion_detalles`
--
ALTER TABLE `cotizacion_detalles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cotizacion_detalles_cotizacion_id_foreign` (`cotizacion_id`);

--
-- Indices de la tabla `cronogramas`
--
ALTER TABLE `cronogramas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cronogramas_empresa_id_foreign` (`empresa_id`),
  ADD KEY `cronogramas_almacen_id_foreign` (`almacen_id`),
  ADD KEY `cronogramas_user_id_foreign` (`user_id`),
  ADD KEY `cronogramas_tecnico_id_foreign` (`tecnico_id`),
  ADD KEY `cronogramas_tipo_seguimiento_id_foreign` (`tipo_seguimiento_id`);

--
-- Indices de la tabla `cuentas_cobrar`
--
ALTER TABLE `cuentas_cobrar`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cuentas_cobrar_venta_id_foreign` (`venta_id`),
  ADD KEY `cuentas_cobrar_contrato_id_foreign` (`contrato_id`),
  ADD KEY `cuentas_cobrar_cliente_id_foreign` (`cliente_id`),
  ADD KEY `cuentas_cobrar_user_id_foreign` (`user_id`);

--
-- Indices de la tabla `cuentas_pagar`
--
ALTER TABLE `cuentas_pagar`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cuentas_pagar_compra_id_foreign` (`compra_id`),
  ADD KEY `cuentas_pagar_proveedor_id_foreign` (`proveedor_id`),
  ADD KEY `cuentas_pagar_user_id_foreign` (`user_id`);

--
-- Indices de la tabla `cuenta_extras`
--
ALTER TABLE `cuenta_extras`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `cuenta_financieros`
--
ALTER TABLE `cuenta_financieros`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `cuenta_operativos`
--
ALTER TABLE `cuenta_operativos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `documentos`
--
ALTER TABLE `documentos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `empresas`
--
ALTER TABLE `empresas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `epps`
--
ALTER TABLE `epps`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `especies`
--
ALTER TABLE `especies`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `estado_extras`
--
ALTER TABLE `estado_extras`
  ADD PRIMARY KEY (`id`),
  ADD KEY `estado_extras_estado_id_foreign` (`estado_id`),
  ADD KEY `estado_extras_gasto_id_foreign` (`gasto_id`);

--
-- Indices de la tabla `estado_financieros`
--
ALTER TABLE `estado_financieros`
  ADD PRIMARY KEY (`id`),
  ADD KEY `estado_financieros_estado_id_foreign` (`estado_id`),
  ADD KEY `estado_financieros_gasto_id_foreign` (`gasto_id`);

--
-- Indices de la tabla `estado_operativos`
--
ALTER TABLE `estado_operativos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `estado_operativos_estado_id_foreign` (`estado_id`),
  ADD KEY `estado_operativos_gasto_id_foreign` (`gasto_id`);

--
-- Indices de la tabla `estado_resultados`
--
ALTER TABLE `estado_resultados`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `etiquetas`
--
ALTER TABLE `etiquetas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `etiqueta_productos`
--
ALTER TABLE `etiqueta_productos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `etiqueta_productos_etiqueta_id_foreign` (`etiqueta_id`),
  ADD KEY `etiqueta_productos_producto_id_foreign` (`producto_id`);

--
-- Indices de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indices de la tabla `gastos`
--
ALTER TABLE `gastos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `gastos_user_id_foreign` (`user_id`);

--
-- Indices de la tabla `gasto_extras`
--
ALTER TABLE `gasto_extras`
  ADD PRIMARY KEY (`id`),
  ADD KEY `gasto_extras_cuenta_id_foreign` (`cuenta_id`);

--
-- Indices de la tabla `gasto_financieros`
--
ALTER TABLE `gasto_financieros`
  ADD PRIMARY KEY (`id`),
  ADD KEY `gasto_financieros_cuenta_id_foreign` (`cuenta_id`);

--
-- Indices de la tabla `gasto_operativos`
--
ALTER TABLE `gasto_operativos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `gasto_operativos_cuenta_id_foreign` (`cuenta_id`);

--
-- Indices de la tabla `hoja_tecnicas`
--
ALTER TABLE `hoja_tecnicas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `hoja_tecnicas_producto_id_foreign` (`producto_id`);

--
-- Indices de la tabla `informe_archivos`
--
ALTER TABLE `informe_archivos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `informe_archivos_empresa_id_foreign` (`empresa_id`),
  ADD KEY `informe_archivos_user_id_foreign` (`user_id`);

--
-- Indices de la tabla `ingresos`
--
ALTER TABLE `ingresos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ingresos_user_id_foreign` (`user_id`);

--
-- Indices de la tabla `insectocutores`
--
ALTER TABLE `insectocutores`
  ADD PRIMARY KEY (`id`),
  ADD KEY `insectocutores_almacen_id_foreign` (`almacen_id`),
  ADD KEY `insectocutores_mapa_id_foreign` (`mapa_id`);

--
-- Indices de la tabla `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indices de la tabla `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `kardexes`
--
ALTER TABLE `kardexes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `kardexes_venta_id_foreign` (`venta_id`),
  ADD KEY `kardexes_compra_id_foreign` (`compra_id`),
  ADD KEY `kardexes_producto_id_foreign` (`producto_id`);

--
-- Indices de la tabla `mapas`
--
ALTER TABLE `mapas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mapas_empresa_id_foreign` (`empresa_id`),
  ADD KEY `mapas_almacen_id_foreign` (`almacen_id`),
  ADD KEY `mapas_user_id_foreign` (`user_id`);

--
-- Indices de la tabla `mapa_revisiones`
--
ALTER TABLE `mapa_revisiones`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `marcas`
--
ALTER TABLE `marcas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `metodos`
--
ALTER TABLE `metodos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indices de la tabla `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indices de la tabla `pagar_cuotas`
--
ALTER TABLE `pagar_cuotas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pagar_cuotas_cuenta_pagar_id_foreign` (`cuenta_pagar_id`);

--
-- Indices de la tabla `pagar_pagos`
--
ALTER TABLE `pagar_pagos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pagar_pagos_cuenta_pagar_id_foreign` (`cuenta_pagar_id`),
  ADD KEY `pagar_pagos_cuota_id_foreign` (`cuota_id`);

--
-- Indices de la tabla `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indices de la tabla `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indices de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  ADD KEY `personal_access_tokens_expires_at_index` (`expires_at`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `productos_categoria_id_foreign` (`categoria_id`),
  ADD KEY `productos_marca_id_foreign` (`marca_id`),
  ADD KEY `productos_unidad_id_foreign` (`unidad_id`);

--
-- Indices de la tabla `producto_usos`
--
ALTER TABLE `producto_usos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `producto_usos_producto_id_foreign` (`producto_id`),
  ADD KEY `producto_usos_seguimiento_id_foreign` (`seguimiento_id`),
  ADD KEY `producto_usos_unidad_id_foreign` (`unidad_id`);

--
-- Indices de la tabla `producto_vencimientos`
--
ALTER TABLE `producto_vencimientos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `producto_vencimientos_producto_id_foreign` (`producto_id`);

--
-- Indices de la tabla `protecciones`
--
ALTER TABLE `protecciones`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `retiros`
--
ALTER TABLE `retiros`
  ADD PRIMARY KEY (`id`),
  ADD KEY `retiros_user_id_foreign` (`user_id`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indices de la tabla `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indices de la tabla `seguimientos`
--
ALTER TABLE `seguimientos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `seguimientos_empresa_id_foreign` (`empresa_id`),
  ADD KEY `seguimientos_almacen_id_foreign` (`almacen_id`),
  ADD KEY `seguimientos_user_id_foreign` (`user_id`),
  ADD KEY `seguimientos_tipo_seguimiento_id_foreign` (`tipo_seguimiento_id`),
  ADD KEY `seguimientos_contacto_id_foreign` (`contacto_id`),
  ADD KEY `seguimientos_cronograma_id_foreign` (`cronograma_id`);

--
-- Indices de la tabla `seguimiento_biologicos`
--
ALTER TABLE `seguimiento_biologicos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `seguimiento_biologicos_seguimiento_id_foreign` (`seguimiento_id`),
  ADD KEY `seguimiento_biologicos_biologico_id_foreign` (`biologico_id`);

--
-- Indices de la tabla `seguimiento_epps`
--
ALTER TABLE `seguimiento_epps`
  ADD PRIMARY KEY (`id`),
  ADD KEY `seguimiento_epps_seguimiento_id_foreign` (`seguimiento_id`),
  ADD KEY `seguimiento_epps_epp_id_foreign` (`epp_id`);

--
-- Indices de la tabla `seguimiento_especies`
--
ALTER TABLE `seguimiento_especies`
  ADD PRIMARY KEY (`id`),
  ADD KEY `seguimiento_especies_seguimiento_id_foreign` (`seguimiento_id`),
  ADD KEY `seguimiento_especies_especie_id_foreign` (`especie_id`);

--
-- Indices de la tabla `seguimiento_images`
--
ALTER TABLE `seguimiento_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `seguimiento_images_seguimiento_id_foreign` (`seguimiento_id`);

--
-- Indices de la tabla `seguimiento_metodos`
--
ALTER TABLE `seguimiento_metodos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `seguimiento_metodos_seguimiento_id_foreign` (`seguimiento_id`),
  ADD KEY `seguimiento_metodos_metodo_id_foreign` (`metodo_id`);

--
-- Indices de la tabla `seguimiento_protecciones`
--
ALTER TABLE `seguimiento_protecciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `seguimiento_protecciones_seguimiento_id_foreign` (`seguimiento_id`),
  ADD KEY `seguimiento_protecciones_proteccion_id_foreign` (`proteccion_id`);

--
-- Indices de la tabla `seguimiento_signos`
--
ALTER TABLE `seguimiento_signos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `seguimiento_signos_seguimiento_id_foreign` (`seguimiento_id`),
  ADD KEY `seguimiento_signos_signo_id_foreign` (`signo_id`);

--
-- Indices de la tabla `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indices de la tabla `signos`
--
ALTER TABLE `signos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `subcategorias`
--
ALTER TABLE `subcategorias`
  ADD PRIMARY KEY (`id`),
  ADD KEY `subcategorias_categoria_id_foreign` (`categoria_id`);

--
-- Indices de la tabla `tipo_seguimientos`
--
ALTER TABLE `tipo_seguimientos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `trampas`
--
ALTER TABLE `trampas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `trampas_almacen_id_foreign` (`almacen_id`),
  ADD KEY `trampas_mapa_id_foreign` (`mapa_id`),
  ADD KEY `trampas_trampa_tipo_id_foreign` (`trampa_tipo_id`);

--
-- Indices de la tabla `trampa_especie_seguimientos`
--
ALTER TABLE `trampa_especie_seguimientos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `trampa_especie_seguimientos_seguimiento_id_foreign` (`seguimiento_id`),
  ADD KEY `trampa_especie_seguimientos_trampa_id_foreign` (`trampa_id`),
  ADD KEY `trampa_especie_seguimientos_especie_id_foreign` (`especie_id`);

--
-- Indices de la tabla `trampa_roedor_seguimientos`
--
ALTER TABLE `trampa_roedor_seguimientos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `trampa_roedor_seguimientos_seguimiento_id_foreign` (`seguimiento_id`),
  ADD KEY `trampa_roedor_seguimientos_trampa_id_foreign` (`trampa_id`);

--
-- Indices de la tabla `trampa_seguimientos`
--
ALTER TABLE `trampa_seguimientos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `trampa_seguimientos_almacen_id_foreign` (`almacen_id`),
  ADD KEY `trampa_seguimientos_mapa_id_foreign` (`mapa_id`),
  ADD KEY `trampa_seguimientos_user_id_foreign` (`user_id`);

--
-- Indices de la tabla `trampa_tipos`
--
ALTER TABLE `trampa_tipos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `unidades`
--
ALTER TABLE `unidades`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indices de la tabla `usuario_empresas`
--
ALTER TABLE `usuario_empresas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_empresas_user_id_foreign` (`user_id`),
  ADD KEY `usuario_empresas_empresa_id_foreign` (`empresa_id`);

--
-- Indices de la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ventas_user_id_foreign` (`user_id`),
  ADD KEY `ventas_cliente_id_foreign` (`cliente_id`);

--
-- Indices de la tabla `venta_detalles`
--
ALTER TABLE `venta_detalles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `venta_detalles_venta_id_foreign` (`venta_id`),
  ADD KEY `venta_detalles_producto_id_foreign` (`producto_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `acciones`
--
ALTER TABLE `acciones`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `accion_imagenes`
--
ALTER TABLE `accion_imagenes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `accion_productos`
--
ALTER TABLE `accion_productos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `accion_trampas`
--
ALTER TABLE `accion_trampas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `agendas`
--
ALTER TABLE `agendas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;

--
-- AUTO_INCREMENT de la tabla `almacenes`
--
ALTER TABLE `almacenes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `almacen_areas`
--
ALTER TABLE `almacen_areas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `almacen_trampas`
--
ALTER TABLE `almacen_trampas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `almancen_insectocutores`
--
ALTER TABLE `almancen_insectocutores`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `aplicaciones`
--
ALTER TABLE `aplicaciones`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=72;

--
-- AUTO_INCREMENT de la tabla `biologicos`
--
ALTER TABLE `biologicos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `buffer_productos`
--
ALTER TABLE `buffer_productos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `certificados`
--
ALTER TABLE `certificados`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cobrar_cuotas`
--
ALTER TABLE `cobrar_cuotas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cobrar_pagos`
--
ALTER TABLE `cobrar_pagos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `compras`
--
ALTER TABLE `compras`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `compra_detalles`
--
ALTER TABLE `compra_detalles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `contactos`
--
ALTER TABLE `contactos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `contratos`
--
ALTER TABLE `contratos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `contrato_detalles`
--
ALTER TABLE `contrato_detalles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `cotizaciones`
--
ALTER TABLE `cotizaciones`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cotizacion_detalles`
--
ALTER TABLE `cotizacion_detalles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cronogramas`
--
ALTER TABLE `cronogramas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1191;

--
-- AUTO_INCREMENT de la tabla `cuentas_cobrar`
--
ALTER TABLE `cuentas_cobrar`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `cuentas_pagar`
--
ALTER TABLE `cuentas_pagar`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cuenta_extras`
--
ALTER TABLE `cuenta_extras`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `cuenta_financieros`
--
ALTER TABLE `cuenta_financieros`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `cuenta_operativos`
--
ALTER TABLE `cuenta_operativos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `documentos`
--
ALTER TABLE `documentos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `empresas`
--
ALTER TABLE `empresas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `epps`
--
ALTER TABLE `epps`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `especies`
--
ALTER TABLE `especies`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `estado_extras`
--
ALTER TABLE `estado_extras`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `estado_financieros`
--
ALTER TABLE `estado_financieros`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `estado_operativos`
--
ALTER TABLE `estado_operativos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `estado_resultados`
--
ALTER TABLE `estado_resultados`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `etiquetas`
--
ALTER TABLE `etiquetas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `etiqueta_productos`
--
ALTER TABLE `etiqueta_productos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `gastos`
--
ALTER TABLE `gastos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `gasto_extras`
--
ALTER TABLE `gasto_extras`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `gasto_financieros`
--
ALTER TABLE `gasto_financieros`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `gasto_operativos`
--
ALTER TABLE `gasto_operativos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `hoja_tecnicas`
--
ALTER TABLE `hoja_tecnicas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `informe_archivos`
--
ALTER TABLE `informe_archivos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `ingresos`
--
ALTER TABLE `ingresos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `insectocutores`
--
ALTER TABLE `insectocutores`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `kardexes`
--
ALTER TABLE `kardexes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT de la tabla `mapas`
--
ALTER TABLE `mapas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `mapa_revisiones`
--
ALTER TABLE `mapa_revisiones`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `marcas`
--
ALTER TABLE `marcas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `metodos`
--
ALTER TABLE `metodos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=87;

--
-- AUTO_INCREMENT de la tabla `pagar_cuotas`
--
ALTER TABLE `pagar_cuotas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pagar_pagos`
--
ALTER TABLE `pagar_pagos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `producto_usos`
--
ALTER TABLE `producto_usos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=106;

--
-- AUTO_INCREMENT de la tabla `producto_vencimientos`
--
ALTER TABLE `producto_vencimientos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `protecciones`
--
ALTER TABLE `protecciones`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `retiros`
--
ALTER TABLE `retiros`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `seguimientos`
--
ALTER TABLE `seguimientos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=72;

--
-- AUTO_INCREMENT de la tabla `seguimiento_biologicos`
--
ALTER TABLE `seguimiento_biologicos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `seguimiento_epps`
--
ALTER TABLE `seguimiento_epps`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=715;

--
-- AUTO_INCREMENT de la tabla `seguimiento_especies`
--
ALTER TABLE `seguimiento_especies`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `seguimiento_images`
--
ALTER TABLE `seguimiento_images`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=332;

--
-- AUTO_INCREMENT de la tabla `seguimiento_metodos`
--
ALTER TABLE `seguimiento_metodos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=189;

--
-- AUTO_INCREMENT de la tabla `seguimiento_protecciones`
--
ALTER TABLE `seguimiento_protecciones`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=259;

--
-- AUTO_INCREMENT de la tabla `seguimiento_signos`
--
ALTER TABLE `seguimiento_signos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT de la tabla `signos`
--
ALTER TABLE `signos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `subcategorias`
--
ALTER TABLE `subcategorias`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tipo_seguimientos`
--
ALTER TABLE `tipo_seguimientos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `trampas`
--
ALTER TABLE `trampas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1904;

--
-- AUTO_INCREMENT de la tabla `trampa_especie_seguimientos`
--
ALTER TABLE `trampa_especie_seguimientos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=136;

--
-- AUTO_INCREMENT de la tabla `trampa_roedor_seguimientos`
--
ALTER TABLE `trampa_roedor_seguimientos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8593;

--
-- AUTO_INCREMENT de la tabla `trampa_seguimientos`
--
ALTER TABLE `trampa_seguimientos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `trampa_tipos`
--
ALTER TABLE `trampa_tipos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `unidades`
--
ALTER TABLE `unidades`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `usuario_empresas`
--
ALTER TABLE `usuario_empresas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `venta_detalles`
--
ALTER TABLE `venta_detalles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `acciones`
--
ALTER TABLE `acciones`
  ADD CONSTRAINT `acciones_almacen_id_foreign` FOREIGN KEY (`almacen_id`) REFERENCES `almacenes` (`id`),
  ADD CONSTRAINT `acciones_empresa_id_foreign` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`),
  ADD CONSTRAINT `acciones_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `accion_imagenes`
--
ALTER TABLE `accion_imagenes`
  ADD CONSTRAINT `accion_imagenes_accion_id_foreign` FOREIGN KEY (`accion_id`) REFERENCES `acciones` (`id`);

--
-- Filtros para la tabla `accion_productos`
--
ALTER TABLE `accion_productos`
  ADD CONSTRAINT `accion_productos_accion_id_foreign` FOREIGN KEY (`accion_id`) REFERENCES `acciones` (`id`),
  ADD CONSTRAINT `accion_productos_producto_id_foreign` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`),
  ADD CONSTRAINT `accion_productos_unidad_id_foreign` FOREIGN KEY (`unidad_id`) REFERENCES `unidades` (`id`);

--
-- Filtros para la tabla `accion_trampas`
--
ALTER TABLE `accion_trampas`
  ADD CONSTRAINT `accion_trampas_accion_id_foreign` FOREIGN KEY (`accion_id`) REFERENCES `acciones` (`id`),
  ADD CONSTRAINT `accion_trampas_trampa_id_foreign` FOREIGN KEY (`trampa_id`) REFERENCES `trampas` (`id`);

--
-- Filtros para la tabla `agendas`
--
ALTER TABLE `agendas`
  ADD CONSTRAINT `agendas_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `almacenes`
--
ALTER TABLE `almacenes`
  ADD CONSTRAINT `almacenes_empresa_id_foreign` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`);

--
-- Filtros para la tabla `almacen_areas`
--
ALTER TABLE `almacen_areas`
  ADD CONSTRAINT `almacen_areas_almacen_id_foreign` FOREIGN KEY (`almacen_id`) REFERENCES `almacenes` (`id`);

--
-- Filtros para la tabla `almacen_trampas`
--
ALTER TABLE `almacen_trampas`
  ADD CONSTRAINT `almacen_trampas_almacen_id_foreign` FOREIGN KEY (`almacen_id`) REFERENCES `almacenes` (`id`);

--
-- Filtros para la tabla `almancen_insectocutores`
--
ALTER TABLE `almancen_insectocutores`
  ADD CONSTRAINT `almancen_insectocutores_almacen_id_foreign` FOREIGN KEY (`almacen_id`) REFERENCES `almacenes` (`id`);

--
-- Filtros para la tabla `aplicaciones`
--
ALTER TABLE `aplicaciones`
  ADD CONSTRAINT `aplicaciones_seguimiento_id_foreign` FOREIGN KEY (`seguimiento_id`) REFERENCES `seguimientos` (`id`);

--
-- Filtros para la tabla `buffer_productos`
--
ALTER TABLE `buffer_productos`
  ADD CONSTRAINT `buffer_productos_producto_id_foreign` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`);

--
-- Filtros para la tabla `certificados`
--
ALTER TABLE `certificados`
  ADD CONSTRAINT `certificados_empresa_id_foreign` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`),
  ADD CONSTRAINT `certificados_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `cobrar_cuotas`
--
ALTER TABLE `cobrar_cuotas`
  ADD CONSTRAINT `cobrar_cuotas_cuenta_cobrar_id_foreign` FOREIGN KEY (`cuenta_cobrar_id`) REFERENCES `cuentas_cobrar` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `cobrar_pagos`
--
ALTER TABLE `cobrar_pagos`
  ADD CONSTRAINT `cobrar_pagos_cuenta_cobrar_id_foreign` FOREIGN KEY (`cuenta_cobrar_id`) REFERENCES `cuentas_cobrar` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cobrar_pagos_cuota_id_foreign` FOREIGN KEY (`cuota_id`) REFERENCES `cobrar_cuotas` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `compras`
--
ALTER TABLE `compras`
  ADD CONSTRAINT `compras_proveedor_id_foreign` FOREIGN KEY (`proveedor_id`) REFERENCES `proveedores` (`id`),
  ADD CONSTRAINT `compras_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `compra_detalles`
--
ALTER TABLE `compra_detalles`
  ADD CONSTRAINT `compra_detalles_compra_id_foreign` FOREIGN KEY (`compra_id`) REFERENCES `compras` (`id`),
  ADD CONSTRAINT `compra_detalles_producto_id_foreign` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`);

--
-- Filtros para la tabla `contactos`
--
ALTER TABLE `contactos`
  ADD CONSTRAINT `contactos_almacen_id_foreign` FOREIGN KEY (`almacen_id`) REFERENCES `almacenes` (`id`);

--
-- Filtros para la tabla `contratos`
--
ALTER TABLE `contratos`
  ADD CONSTRAINT `contratos_empresa_id_foreign` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`);

--
-- Filtros para la tabla `contrato_detalles`
--
ALTER TABLE `contrato_detalles`
  ADD CONSTRAINT `contrato_detalles_contrato_id_foreign` FOREIGN KEY (`contrato_id`) REFERENCES `contratos` (`id`);

--
-- Filtros para la tabla `cotizacion_detalles`
--
ALTER TABLE `cotizacion_detalles`
  ADD CONSTRAINT `cotizacion_detalles_cotizacion_id_foreign` FOREIGN KEY (`cotizacion_id`) REFERENCES `cotizaciones` (`id`);

--
-- Filtros para la tabla `cronogramas`
--
ALTER TABLE `cronogramas`
  ADD CONSTRAINT `cronogramas_almacen_id_foreign` FOREIGN KEY (`almacen_id`) REFERENCES `almacenes` (`id`),
  ADD CONSTRAINT `cronogramas_empresa_id_foreign` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`),
  ADD CONSTRAINT `cronogramas_tecnico_id_foreign` FOREIGN KEY (`tecnico_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `cronogramas_tipo_seguimiento_id_foreign` FOREIGN KEY (`tipo_seguimiento_id`) REFERENCES `tipo_seguimientos` (`id`),
  ADD CONSTRAINT `cronogramas_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `cuentas_cobrar`
--
ALTER TABLE `cuentas_cobrar`
  ADD CONSTRAINT `cuentas_cobrar_cliente_id_foreign` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`),
  ADD CONSTRAINT `cuentas_cobrar_contrato_id_foreign` FOREIGN KEY (`contrato_id`) REFERENCES `contratos` (`id`),
  ADD CONSTRAINT `cuentas_cobrar_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `cuentas_cobrar_venta_id_foreign` FOREIGN KEY (`venta_id`) REFERENCES `ventas` (`id`);

--
-- Filtros para la tabla `cuentas_pagar`
--
ALTER TABLE `cuentas_pagar`
  ADD CONSTRAINT `cuentas_pagar_compra_id_foreign` FOREIGN KEY (`compra_id`) REFERENCES `compras` (`id`),
  ADD CONSTRAINT `cuentas_pagar_proveedor_id_foreign` FOREIGN KEY (`proveedor_id`) REFERENCES `proveedores` (`id`),
  ADD CONSTRAINT `cuentas_pagar_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `estado_extras`
--
ALTER TABLE `estado_extras`
  ADD CONSTRAINT `estado_extras_estado_id_foreign` FOREIGN KEY (`estado_id`) REFERENCES `estado_resultados` (`id`),
  ADD CONSTRAINT `estado_extras_gasto_id_foreign` FOREIGN KEY (`gasto_id`) REFERENCES `gasto_extras` (`id`);

--
-- Filtros para la tabla `estado_financieros`
--
ALTER TABLE `estado_financieros`
  ADD CONSTRAINT `estado_financieros_estado_id_foreign` FOREIGN KEY (`estado_id`) REFERENCES `estado_resultados` (`id`),
  ADD CONSTRAINT `estado_financieros_gasto_id_foreign` FOREIGN KEY (`gasto_id`) REFERENCES `gasto_financieros` (`id`);

--
-- Filtros para la tabla `estado_operativos`
--
ALTER TABLE `estado_operativos`
  ADD CONSTRAINT `estado_operativos_estado_id_foreign` FOREIGN KEY (`estado_id`) REFERENCES `estado_resultados` (`id`),
  ADD CONSTRAINT `estado_operativos_gasto_id_foreign` FOREIGN KEY (`gasto_id`) REFERENCES `gasto_operativos` (`id`);

--
-- Filtros para la tabla `etiqueta_productos`
--
ALTER TABLE `etiqueta_productos`
  ADD CONSTRAINT `etiqueta_productos_etiqueta_id_foreign` FOREIGN KEY (`etiqueta_id`) REFERENCES `etiquetas` (`id`),
  ADD CONSTRAINT `etiqueta_productos_producto_id_foreign` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`);

--
-- Filtros para la tabla `gastos`
--
ALTER TABLE `gastos`
  ADD CONSTRAINT `gastos_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `gasto_extras`
--
ALTER TABLE `gasto_extras`
  ADD CONSTRAINT `gasto_extras_cuenta_id_foreign` FOREIGN KEY (`cuenta_id`) REFERENCES `cuenta_extras` (`id`);

--
-- Filtros para la tabla `gasto_financieros`
--
ALTER TABLE `gasto_financieros`
  ADD CONSTRAINT `gasto_financieros_cuenta_id_foreign` FOREIGN KEY (`cuenta_id`) REFERENCES `cuenta_financieros` (`id`);

--
-- Filtros para la tabla `gasto_operativos`
--
ALTER TABLE `gasto_operativos`
  ADD CONSTRAINT `gasto_operativos_cuenta_id_foreign` FOREIGN KEY (`cuenta_id`) REFERENCES `cuenta_operativos` (`id`);

--
-- Filtros para la tabla `hoja_tecnicas`
--
ALTER TABLE `hoja_tecnicas`
  ADD CONSTRAINT `hoja_tecnicas_producto_id_foreign` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`);

--
-- Filtros para la tabla `informe_archivos`
--
ALTER TABLE `informe_archivos`
  ADD CONSTRAINT `informe_archivos_empresa_id_foreign` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `informe_archivos_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `ingresos`
--
ALTER TABLE `ingresos`
  ADD CONSTRAINT `ingresos_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `insectocutores`
--
ALTER TABLE `insectocutores`
  ADD CONSTRAINT `insectocutores_almacen_id_foreign` FOREIGN KEY (`almacen_id`) REFERENCES `almacenes` (`id`),
  ADD CONSTRAINT `insectocutores_mapa_id_foreign` FOREIGN KEY (`mapa_id`) REFERENCES `mapas` (`id`);

--
-- Filtros para la tabla `kardexes`
--
ALTER TABLE `kardexes`
  ADD CONSTRAINT `kardexes_compra_id_foreign` FOREIGN KEY (`compra_id`) REFERENCES `compras` (`id`),
  ADD CONSTRAINT `kardexes_producto_id_foreign` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`),
  ADD CONSTRAINT `kardexes_venta_id_foreign` FOREIGN KEY (`venta_id`) REFERENCES `ventas` (`id`);

--
-- Filtros para la tabla `mapas`
--
ALTER TABLE `mapas`
  ADD CONSTRAINT `mapas_almacen_id_foreign` FOREIGN KEY (`almacen_id`) REFERENCES `almacenes` (`id`),
  ADD CONSTRAINT `mapas_empresa_id_foreign` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`),
  ADD CONSTRAINT `mapas_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `pagar_cuotas`
--
ALTER TABLE `pagar_cuotas`
  ADD CONSTRAINT `pagar_cuotas_cuenta_pagar_id_foreign` FOREIGN KEY (`cuenta_pagar_id`) REFERENCES `cuentas_pagar` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `pagar_pagos`
--
ALTER TABLE `pagar_pagos`
  ADD CONSTRAINT `pagar_pagos_cuenta_pagar_id_foreign` FOREIGN KEY (`cuenta_pagar_id`) REFERENCES `cuentas_pagar` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `pagar_pagos_cuota_id_foreign` FOREIGN KEY (`cuota_id`) REFERENCES `pagar_cuotas` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `productos_categoria_id_foreign` FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`id`),
  ADD CONSTRAINT `productos_marca_id_foreign` FOREIGN KEY (`marca_id`) REFERENCES `marcas` (`id`),
  ADD CONSTRAINT `productos_unidad_id_foreign` FOREIGN KEY (`unidad_id`) REFERENCES `unidades` (`id`);

--
-- Filtros para la tabla `producto_usos`
--
ALTER TABLE `producto_usos`
  ADD CONSTRAINT `producto_usos_producto_id_foreign` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`),
  ADD CONSTRAINT `producto_usos_seguimiento_id_foreign` FOREIGN KEY (`seguimiento_id`) REFERENCES `seguimientos` (`id`),
  ADD CONSTRAINT `producto_usos_unidad_id_foreign` FOREIGN KEY (`unidad_id`) REFERENCES `unidades` (`id`);

--
-- Filtros para la tabla `producto_vencimientos`
--
ALTER TABLE `producto_vencimientos`
  ADD CONSTRAINT `producto_vencimientos_producto_id_foreign` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`);

--
-- Filtros para la tabla `retiros`
--
ALTER TABLE `retiros`
  ADD CONSTRAINT `retiros_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `seguimientos`
--
ALTER TABLE `seguimientos`
  ADD CONSTRAINT `seguimientos_almacen_id_foreign` FOREIGN KEY (`almacen_id`) REFERENCES `almacenes` (`id`),
  ADD CONSTRAINT `seguimientos_contacto_id_foreign` FOREIGN KEY (`contacto_id`) REFERENCES `contactos` (`id`),
  ADD CONSTRAINT `seguimientos_cronograma_id_foreign` FOREIGN KEY (`cronograma_id`) REFERENCES `cronogramas` (`id`),
  ADD CONSTRAINT `seguimientos_empresa_id_foreign` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`),
  ADD CONSTRAINT `seguimientos_tipo_seguimiento_id_foreign` FOREIGN KEY (`tipo_seguimiento_id`) REFERENCES `tipo_seguimientos` (`id`),
  ADD CONSTRAINT `seguimientos_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `seguimiento_biologicos`
--
ALTER TABLE `seguimiento_biologicos`
  ADD CONSTRAINT `seguimiento_biologicos_biologico_id_foreign` FOREIGN KEY (`biologico_id`) REFERENCES `biologicos` (`id`),
  ADD CONSTRAINT `seguimiento_biologicos_seguimiento_id_foreign` FOREIGN KEY (`seguimiento_id`) REFERENCES `seguimientos` (`id`);

--
-- Filtros para la tabla `seguimiento_epps`
--
ALTER TABLE `seguimiento_epps`
  ADD CONSTRAINT `seguimiento_epps_epp_id_foreign` FOREIGN KEY (`epp_id`) REFERENCES `epps` (`id`),
  ADD CONSTRAINT `seguimiento_epps_seguimiento_id_foreign` FOREIGN KEY (`seguimiento_id`) REFERENCES `seguimientos` (`id`);

--
-- Filtros para la tabla `seguimiento_especies`
--
ALTER TABLE `seguimiento_especies`
  ADD CONSTRAINT `seguimiento_especies_especie_id_foreign` FOREIGN KEY (`especie_id`) REFERENCES `especies` (`id`),
  ADD CONSTRAINT `seguimiento_especies_seguimiento_id_foreign` FOREIGN KEY (`seguimiento_id`) REFERENCES `seguimientos` (`id`);

--
-- Filtros para la tabla `seguimiento_images`
--
ALTER TABLE `seguimiento_images`
  ADD CONSTRAINT `seguimiento_images_seguimiento_id_foreign` FOREIGN KEY (`seguimiento_id`) REFERENCES `seguimientos` (`id`);

--
-- Filtros para la tabla `seguimiento_metodos`
--
ALTER TABLE `seguimiento_metodos`
  ADD CONSTRAINT `seguimiento_metodos_metodo_id_foreign` FOREIGN KEY (`metodo_id`) REFERENCES `metodos` (`id`),
  ADD CONSTRAINT `seguimiento_metodos_seguimiento_id_foreign` FOREIGN KEY (`seguimiento_id`) REFERENCES `seguimientos` (`id`);

--
-- Filtros para la tabla `seguimiento_protecciones`
--
ALTER TABLE `seguimiento_protecciones`
  ADD CONSTRAINT `seguimiento_protecciones_proteccion_id_foreign` FOREIGN KEY (`proteccion_id`) REFERENCES `protecciones` (`id`),
  ADD CONSTRAINT `seguimiento_protecciones_seguimiento_id_foreign` FOREIGN KEY (`seguimiento_id`) REFERENCES `seguimientos` (`id`);

--
-- Filtros para la tabla `seguimiento_signos`
--
ALTER TABLE `seguimiento_signos`
  ADD CONSTRAINT `seguimiento_signos_seguimiento_id_foreign` FOREIGN KEY (`seguimiento_id`) REFERENCES `seguimientos` (`id`),
  ADD CONSTRAINT `seguimiento_signos_signo_id_foreign` FOREIGN KEY (`signo_id`) REFERENCES `signos` (`id`);

--
-- Filtros para la tabla `subcategorias`
--
ALTER TABLE `subcategorias`
  ADD CONSTRAINT `subcategorias_categoria_id_foreign` FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`id`);

--
-- Filtros para la tabla `trampas`
--
ALTER TABLE `trampas`
  ADD CONSTRAINT `trampas_almacen_id_foreign` FOREIGN KEY (`almacen_id`) REFERENCES `almacenes` (`id`),
  ADD CONSTRAINT `trampas_mapa_id_foreign` FOREIGN KEY (`mapa_id`) REFERENCES `mapas` (`id`),
  ADD CONSTRAINT `trampas_trampa_tipo_id_foreign` FOREIGN KEY (`trampa_tipo_id`) REFERENCES `trampa_tipos` (`id`);

--
-- Filtros para la tabla `trampa_especie_seguimientos`
--
ALTER TABLE `trampa_especie_seguimientos`
  ADD CONSTRAINT `trampa_especie_seguimientos_especie_id_foreign` FOREIGN KEY (`especie_id`) REFERENCES `especies` (`id`),
  ADD CONSTRAINT `trampa_especie_seguimientos_seguimiento_id_foreign` FOREIGN KEY (`seguimiento_id`) REFERENCES `seguimientos` (`id`),
  ADD CONSTRAINT `trampa_especie_seguimientos_trampa_id_foreign` FOREIGN KEY (`trampa_id`) REFERENCES `trampas` (`id`);

--
-- Filtros para la tabla `trampa_roedor_seguimientos`
--
ALTER TABLE `trampa_roedor_seguimientos`
  ADD CONSTRAINT `trampa_roedor_seguimientos_seguimiento_id_foreign` FOREIGN KEY (`seguimiento_id`) REFERENCES `seguimientos` (`id`),
  ADD CONSTRAINT `trampa_roedor_seguimientos_trampa_id_foreign` FOREIGN KEY (`trampa_id`) REFERENCES `trampas` (`id`);

--
-- Filtros para la tabla `trampa_seguimientos`
--
ALTER TABLE `trampa_seguimientos`
  ADD CONSTRAINT `trampa_seguimientos_almacen_id_foreign` FOREIGN KEY (`almacen_id`) REFERENCES `almacenes` (`id`),
  ADD CONSTRAINT `trampa_seguimientos_mapa_id_foreign` FOREIGN KEY (`mapa_id`) REFERENCES `mapas` (`id`),
  ADD CONSTRAINT `trampa_seguimientos_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `usuario_empresas`
--
ALTER TABLE `usuario_empresas`
  ADD CONSTRAINT `usuario_empresas_empresa_id_foreign` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`),
  ADD CONSTRAINT `usuario_empresas_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD CONSTRAINT `ventas_cliente_id_foreign` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`),
  ADD CONSTRAINT `ventas_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `venta_detalles`
--
ALTER TABLE `venta_detalles`
  ADD CONSTRAINT `venta_detalles_producto_id_foreign` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`),
  ADD CONSTRAINT `venta_detalles_venta_id_foreign` FOREIGN KEY (`venta_id`) REFERENCES `ventas` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
