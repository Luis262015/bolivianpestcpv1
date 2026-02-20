-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 11-02-2026 a las 10:01:52
-- Versión del servidor: 8.0.43
-- Versión de PHP: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `c2681564_boliv`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `agendas`
--

CREATE TABLE `agendas` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` date NOT NULL,
  `hour` time DEFAULT NULL,
  `color` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'bg-blue-500',
  `status` enum('pendiente','postergado','completado') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pendiente',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `agendas`
--

INSERT INTO `agendas` (`id`, `user_id`, `title`, `date`, `hour`, `color`, `status`, `created_at`, `updated_at`) VALUES
(11, 2, 'BQSRL', '2026-02-07', NULL, 'bg-pink-600', 'completado', '2026-02-09 10:37:20', '2026-02-10 11:28:55'),
(12, 2, 'BQSRL', '2026-02-28', NULL, 'bg-pink-600', 'pendiente', '2026-02-09 10:37:33', '2026-02-09 10:37:33'),
(14, 2, 'WINDSOR', '2026-02-19', NULL, 'bg-teal-500', 'pendiente', '2026-02-09 10:38:33', '2026-02-09 10:38:33'),
(15, 2, 'WINDSOR  FUMIGACION', '2026-02-14', NULL, 'bg-teal-500', 'pendiente', '2026-02-09 10:39:02', '2026-02-09 10:39:02'),
(16, 2, 'RANSA ILLIMANI ARCHIVO', '2026-02-05', NULL, 'bg-red-500', 'completado', '2026-02-09 10:40:11', '2026-02-09 11:11:31'),
(17, 2, 'RANSA ILLIMANI ARCHIVO', '2026-02-20', NULL, 'bg-red-500', 'pendiente', '2026-02-09 10:40:33', '2026-02-09 10:40:33'),
(18, 2, 'INSECTOCUTOR RANSA', '2026-02-10', NULL, 'bg-red-500', 'pendiente', '2026-02-09 10:40:59', '2026-02-09 10:40:59'),
(20, 2, 'INSECTOCUTOR RANSA', '2026-02-24', NULL, 'bg-red-500', 'pendiente', '2026-02-09 10:41:26', '2026-02-09 10:41:26'),
(22, 2, 'OMNILIFE TARIJA', '2026-02-21', NULL, 'bg-yellow-500', 'pendiente', '2026-02-09 10:44:01', '2026-02-09 10:44:01'),
(27, 2, 'CASCADA VILLA FATIMA', '2026-02-12', NULL, 'bg-blue-500', 'pendiente', '2026-02-09 10:48:17', '2026-02-09 10:48:17'),
(28, 2, 'CASCADA V F FUMIGACION', '2026-02-21', NULL, 'bg-blue-500', 'pendiente', '2026-02-09 10:48:35', '2026-02-10 11:38:32'),
(32, 2, 'CASCADA EL ALTO', '2026-02-13', NULL, 'bg-blue-500', 'pendiente', '2026-02-09 10:50:44', '2026-02-09 10:50:44'),
(34, 2, 'CASCADA EA FUMIGACION', '2026-02-28', NULL, 'bg-blue-500', 'pendiente', '2026-02-09 10:51:28', '2026-02-09 10:51:28'),
(35, 2, 'CASCADA LLOJETA', '2026-02-12', NULL, 'bg-blue-500', 'pendiente', '2026-02-09 10:52:32', '2026-02-09 10:52:32'),
(37, 2, 'CASCADA LLOJETA', '2026-02-26', NULL, 'bg-blue-500', 'pendiente', '2026-02-09 10:53:08', '2026-02-09 10:53:08'),
(38, 2, 'LAQFAGAL FUMIGACION', '2026-02-20', NULL, 'bg-yellow-500', 'pendiente', '2026-02-09 10:54:31', '2026-02-09 10:54:31'),
(39, 2, 'PROESA', '2026-02-18', NULL, 'bg-red-500', 'pendiente', '2026-02-09 10:55:16', '2026-02-09 10:55:16'),
(41, 2, 'CASCADA VISCACHANI', '2026-02-07', NULL, 'bg-blue-500', 'completado', '2026-02-09 10:57:27', '2026-02-09 10:57:59'),
(42, 2, 'CASCADA VISCACHANI', '2026-02-20', NULL, 'bg-blue-500', 'pendiente', '2026-02-09 10:57:48', '2026-02-09 10:57:48'),
(43, 2, 'CARNAVAL', '2026-02-15', NULL, 'bg-teal-500', 'pendiente', '2026-02-09 10:59:26', '2026-02-09 10:59:26'),
(44, 2, 'CARNAVAL', '2026-02-16', NULL, 'bg-teal-500', 'pendiente', '2026-02-09 10:59:35', '2026-02-09 10:59:35'),
(45, 2, 'CARNAVAL', '2026-02-17', NULL, 'bg-teal-500', 'pendiente', '2026-02-09 11:00:06', '2026-02-09 11:00:06'),
(46, 2, 'PROESA ORURO', '2026-02-02', NULL, 'bg-red-500', 'completado', '2026-02-09 11:08:40', '2026-02-09 11:10:38'),
(48, 2, 'FUMIGACION CASTAÑA', '2026-02-03', NULL, 'bg-green-500', 'completado', '2026-02-09 11:09:31', '2026-02-09 11:09:31'),
(49, 2, 'CASA DEL CAMBA', '2026-02-03', NULL, 'bg-purple-500', 'completado', '2026-02-09 11:09:48', '2026-02-10 11:28:27'),
(50, 2, 'CASCADA URKUPIÑA DESRATIZACION', '2026-02-04', NULL, 'bg-red-500', 'completado', '2026-02-09 11:12:07', '2026-02-09 11:12:07'),
(54, 2, 'BON GUSTO', '2026-02-28', NULL, 'bg-yellow-500', 'pendiente', '2026-02-09 11:16:12', '2026-02-09 11:16:12'),
(55, 2, 'PALLETS JUAN CARLOS', '2026-02-03', NULL, 'bg-yellow-500', 'completado', '2026-02-10 11:25:01', '2026-02-10 11:25:20'),
(56, 2, 'TIENDA TJJA', '2026-02-04', NULL, 'bg-teal-500', 'completado', '2026-02-10 11:25:52', '2026-02-10 11:25:52'),
(57, 2, 'PROESA', '2026-02-05', NULL, 'bg-yellow-500', 'completado', '2026-02-10 11:26:23', '2026-02-10 11:28:35'),
(58, 2, 'WINDSOR', '2026-02-06', NULL, 'bg-green-500', 'completado', '2026-02-10 11:27:16', '2026-02-10 11:28:48'),
(59, 2, 'INTERQUIMICA FUMIGACION', '2026-02-06', NULL, 'bg-red-500', 'completado', '2026-02-10 11:27:35', '2026-02-10 11:28:44'),
(61, 2, 'QUANTICA', '2026-02-06', NULL, 'bg-blue-500', 'completado', '2026-02-10 11:28:17', '2026-02-10 11:28:39'),
(62, 2, 'MARECBOL DESRA', '2026-02-09', NULL, 'bg-red-500', 'completado', '2026-02-10 11:29:34', '2026-02-10 11:40:20'),
(63, 2, 'INTERQUIMICA DESRA', '2026-02-09', NULL, 'bg-green-500', 'completado', '2026-02-10 11:29:49', '2026-02-10 11:40:37'),
(64, 2, 'AIDISA', '2026-02-10', NULL, 'bg-teal-500', 'pendiente', '2026-02-10 11:30:14', '2026-02-10 11:30:14'),
(65, 2, 'LAQFAGAL PALOMAS', '2026-02-11', NULL, 'bg-blue-500', 'pendiente', '2026-02-10 11:30:37', '2026-02-10 11:30:37'),
(66, 2, 'FARMEDICAL', '2026-02-11', NULL, 'bg-green-500', 'pendiente', '2026-02-10 11:31:01', '2026-02-10 11:31:01'),
(67, 2, 'NOVOPHARMA', '2026-02-11', NULL, 'bg-pink-600', 'pendiente', '2026-02-10 11:31:16', '2026-02-10 11:31:16'),
(68, 2, 'LAQ FAGAL DESRA', '2026-02-13', NULL, 'bg-yellow-500', 'pendiente', '2026-02-10 11:32:00', '2026-02-10 11:32:00'),
(69, 2, 'MI FARMA RAM', '2026-02-13', NULL, 'bg-pink-600', 'pendiente', '2026-02-10 11:32:13', '2026-02-10 11:32:13'),
(70, 2, 'ICAL', '2026-02-14', NULL, 'bg-red-500', 'pendiente', '2026-02-10 11:32:46', '2026-02-10 11:32:46'),
(71, 2, 'AIDISA DESRA', '2026-02-18', NULL, 'bg-yellow-500', 'pendiente', '2026-02-10 11:33:17', '2026-02-10 11:33:17'),
(72, 2, 'PROESA LA PAZ', '2026-02-19', NULL, 'bg-purple-500', 'pendiente', '2026-02-10 11:33:40', '2026-02-10 11:33:40'),
(74, 2, 'AIDISA LP DESRA', '2026-02-23', NULL, 'bg-red-500', 'pendiente', '2026-02-10 11:35:34', '2026-02-10 11:35:34'),
(75, 2, 'ENALPAZ', '2026-02-23', NULL, 'bg-blue-500', 'pendiente', '2026-02-10 11:35:50', '2026-02-10 11:35:50'),
(76, 2, 'EXPRINTER', '2026-02-24', NULL, 'bg-green-500', 'pendiente', '2026-02-10 11:36:14', '2026-02-10 11:36:14'),
(77, 2, 'MARECBOL', '2026-02-25', NULL, 'bg-yellow-500', 'pendiente', '2026-02-10 11:36:32', '2026-02-10 11:36:32'),
(78, 2, 'CASCADA VF DESRATIZACION', '2026-02-26', NULL, 'bg-yellow-500', 'pendiente', '2026-02-10 11:39:00', '2026-02-10 11:39:00'),
(79, 2, 'BOLIVIAN FOOD', '2026-02-27', NULL, 'bg-pink-600', 'pendiente', '2026-02-10 11:39:22', '2026-02-10 11:39:22');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `almacenes`
--

CREATE TABLE `almacenes` (
  `id` bigint UNSIGNED NOT NULL,
  `empresa_id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `direccion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `encargado` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telefono` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ciudad` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `almacenes`
--

INSERT INTO `almacenes` (`id`, `empresa_id`, `nombre`, `direccion`, `encargado`, `telefono`, `email`, `ciudad`, `created_at`, `updated_at`) VALUES
(1, 1, 'PLANTA VILLA FATIMA', 'CALLE SANTA ROSA NRO. 471 VILLA FATIMA', 'Franklin Chavez', '70103966', 'jessica_escobar@lacascada.com.bo', 'LA PAZ', '2026-01-30 19:35:59', '2026-02-10 19:51:05');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `almacen_areas`
--

CREATE TABLE `almacen_areas` (
  `id` bigint UNSIGNED NOT NULL,
  `almacen_id` bigint UNSIGNED NOT NULL,
  `descripcion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `area` int NOT NULL,
  `visitas` int NOT NULL,
  `precio` double NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `almacen_areas`
--

INSERT INTO `almacen_areas` (`id`, `almacen_id`, `descripcion`, `area`, `visitas`, `precio`, `total`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, 1850, 4, 0.4, 2960, '2026-01-30 19:35:59', '2026-02-10 19:51:06');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `almacen_trampas`
--

CREATE TABLE `almacen_trampas` (
  `id` bigint UNSIGNED NOT NULL,
  `almacen_id` bigint UNSIGNED NOT NULL,
  `descripcion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cantidad` int NOT NULL,
  `visitas` int NOT NULL,
  `precio` double NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `almacen_trampas`
--

INSERT INTO `almacen_trampas` (`id`, `almacen_id`, `descripcion`, `cantidad`, `visitas`, `precio`, `total`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, 77, 24, 6, 11088, '2026-01-30 19:35:59', '2026-02-10 19:51:06');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `almancen_insectocutores`
--

CREATE TABLE `almancen_insectocutores` (
  `id` bigint UNSIGNED NOT NULL,
  `almacen_id` bigint UNSIGNED NOT NULL,
  `descripcion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cantidad` int NOT NULL,
  `visitas` int NOT NULL,
  `precio` double NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `almancen_insectocutores`
--

INSERT INTO `almancen_insectocutores` (`id`, `almacen_id`, `descripcion`, `cantidad`, `visitas`, `precio`, `total`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, 1, 24, 10, 240, '2026-01-30 19:35:59', '2026-02-10 19:51:06');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aplicaciones`
--

CREATE TABLE `aplicaciones` (
  `id` bigint UNSIGNED NOT NULL,
  `seguimiento_id` bigint UNSIGNED NOT NULL,
  `pisos` int NOT NULL,
  `paredes_internas` int NOT NULL,
  `ambientes` int NOT NULL,
  `internas` int NOT NULL,
  `externas` int NOT NULL,
  `trampas` int NOT NULL,
  `trampas_cambiar` int NOT NULL,
  `roedores` int NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `aplicaciones`
--

INSERT INTO `aplicaciones` (`id`, `seguimiento_id`, `pisos`, `paredes_internas`, `ambientes`, `internas`, `externas`, `trampas`, `trampas_cambiar`, `roedores`, `created_at`, `updated_at`) VALUES
(1, 1, 0, 0, 0, 57, 10, 67, 67, 0, '2026-01-30 20:09:03', '2026-01-30 20:09:03'),
(2, 2, 4, 4, 1, 0, 0, 0, 0, 0, '2026-01-30 20:16:06', '2026-01-30 20:16:06'),
(3, 3, 0, 0, 0, 4, 4, 8, 8, 0, '2026-02-10 18:21:45', '2026-02-10 18:21:45'),
(4, 4, 0, 0, 0, 0, 0, 0, 0, 0, '2026-02-10 18:26:24', '2026-02-10 18:26:24'),
(5, 5, 0, 0, 0, 0, 0, 0, 0, 0, '2026-02-10 18:30:18', '2026-02-10 18:30:18');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `biologicos`
--

CREATE TABLE `biologicos` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `biologicos`
--

INSERT INTO `biologicos` (`id`, `nombre`, `created_at`, `updated_at`) VALUES
(1, 'Adulto', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(2, 'Huevo', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(3, 'Larva', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(4, 'Ninfa', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(5, 'Pupa', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(6, 'Otros', '2026-01-30 17:28:01', '2026-01-30 17:28:01');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `cache`
--

INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('bolivianpest-cache-30651b5b6d8a4f1a6574ad111be676fb', 'i:1;', 1769796624),
('bolivianpest-cache-30651b5b6d8a4f1a6574ad111be676fb:timer', 'i:1769796624;', 1769796624),
('bolivianpest-cache-50706508b082f5215575b458242b6604', 'i:1;', 1769808670),
('bolivianpest-cache-50706508b082f5215575b458242b6604:timer', 'i:1769808670;', 1769808670),
('bolivianpest-cache-5e25ec995a4fe627ddcc7c05459a25fc', 'i:1;', 1770760761),
('bolivianpest-cache-5e25ec995a4fe627ddcc7c05459a25fc:timer', 'i:1770760761;', 1770760761),
('bolivianpest-cache-6d216c2f817d2670d412ad089d8e499c', 'i:1;', 1770748307),
('bolivianpest-cache-6d216c2f817d2670d412ad089d8e499c:timer', 'i:1770748307;', 1770748307),
('bolivianpest-cache-801bd739cfcebc6f57977b437c55fac9', 'i:1;', 1769794372),
('bolivianpest-cache-801bd739cfcebc6f57977b437c55fac9:timer', 'i:1769794372;', 1769794372),
('bolivianpest-cache-8a6e29ef31baaa7dde48d797e626ffc2', 'i:1;', 1769794282),
('bolivianpest-cache-8a6e29ef31baaa7dde48d797e626ffc2:timer', 'i:1769794282;', 1769794282),
('bolivianpest-cache-adim@admin.com|177.222.112.216', 'i:1;', 1769796624),
('bolivianpest-cache-adim@admin.com|177.222.112.216:timer', 'i:1769796624;', 1769796624),
('bolivianpest-cache-bcda8ba14702a936a86c58ac90357387', 'i:1;', 1770759503),
('bolivianpest-cache-bcda8ba14702a936a86c58ac90357387:timer', 'i:1770759503;', 1770759503),
('bolivianpest-cache-islaluis25@gmail.com|127.0.0.1', 'i:1;', 1769794282),
('bolivianpest-cache-islaluis25@gmail.com|127.0.0.1:timer', 'i:1769794282;', 1769794282);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `certificados`
--

CREATE TABLE `certificados` (
  `id` bigint UNSIGNED NOT NULL,
  `empresa_id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `qrcode` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `firmadigital` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `titulo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `establecimiento` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `actividad` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `validez` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `direccion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `diagnostico` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `condicion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `trabajo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `plaguicidas` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `registro` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `area` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `acciones` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `certificados`
--

INSERT INTO `certificados` (`id`, `empresa_id`, `user_id`, `qrcode`, `firmadigital`, `titulo`, `establecimiento`, `actividad`, `validez`, `direccion`, `diagnostico`, `condicion`, `trabajo`, `plaguicidas`, `registro`, `area`, `acciones`, `logo`, `created_at`, `updated_at`) VALUES
(1, 1, 2, '', '', 'CERTIFICADO DE FUMIGACION', 'DIVICION WINDSOR HANSA LTDA', 'INDUSTRIA', '60  DIAS', 'AV. 6 DE MARZO FRENTE AL REGIMIENTO INGAVI', 'NO EXISTE PRESENCIA DE VECTORES', NULL, 'DESINSECTACION', 'FENDONA', 'INSO 1234566', '10000M2', 'CONTINUAR ORDEN Y LIMPIEZA', '', '2026-02-10 18:48:20', '2026-02-10 18:48:20');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `id` bigint UNSIGNED NOT NULL,
  `nombres` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `celular` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nit` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `razon_social` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cobrar_cuotas`
--

CREATE TABLE `cobrar_cuotas` (
  `id` bigint UNSIGNED NOT NULL,
  `cuenta_cobrar_id` bigint UNSIGNED NOT NULL,
  `numero_cuota` int NOT NULL,
  `fecha_vencimiento` date NOT NULL,
  `monto` decimal(12,2) NOT NULL,
  `estado` enum('pendiente','pagado','vencido') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pendiente',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cobrar_pagos`
--

CREATE TABLE `cobrar_pagos` (
  `id` bigint UNSIGNED NOT NULL,
  `cuenta_cobrar_id` bigint UNSIGNED NOT NULL,
  `cuota_id` bigint UNSIGNED DEFAULT NULL,
  `fecha_pago` date NOT NULL,
  `monto` decimal(12,2) NOT NULL,
  `metodo_pago` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `observacion` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compras`
--

CREATE TABLE `compras` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `proveedor_id` bigint UNSIGNED DEFAULT NULL,
  `total` double NOT NULL,
  `tipo` enum('Compra','Credito','Adelanto','Anulado') COLLATE utf8mb4_unicode_ci NOT NULL,
  `observaciones` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compra_detalles`
--

CREATE TABLE `compra_detalles` (
  `id` bigint UNSIGNED NOT NULL,
  `compra_id` bigint UNSIGNED NOT NULL,
  `producto_id` bigint UNSIGNED DEFAULT NULL,
  `cantidad` int NOT NULL,
  `precio_compra` double NOT NULL,
  `precio_venta` double NOT NULL,
  `descripcion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contactos`
--

CREATE TABLE `contactos` (
  `id` bigint UNSIGNED NOT NULL,
  `almacen_id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telefono` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ci` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contratos`
--

CREATE TABLE `contratos` (
  `id` bigint UNSIGNED NOT NULL,
  `empresa_id` bigint UNSIGNED NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `expiracion` date NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `contratos`
--

INSERT INTO `contratos` (`id`, `empresa_id`, `total`, `expiracion`, `created_at`, `updated_at`) VALUES
(1, 1, 14288.00, '2026-12-31', '2026-01-30 19:35:59', '2026-02-10 19:51:05');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contrato_detalles`
--

CREATE TABLE `contrato_detalles` (
  `id` bigint UNSIGNED NOT NULL,
  `contrato_id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `t_cantidad` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `t_visitas` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `t_precio` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `t_total` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `a_area` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `a_visitas` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `a_precio` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `a_total` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `i_cantidad` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `i_visitas` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `i_precio` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `i_total` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `contrato_detalles`
--

INSERT INTO `contrato_detalles` (`id`, `contrato_id`, `nombre`, `t_cantidad`, `t_visitas`, `t_precio`, `t_total`, `a_area`, `a_visitas`, `a_precio`, `a_total`, `i_cantidad`, `i_visitas`, `i_precio`, `i_total`, `total`, `created_at`, `updated_at`) VALUES
(1, 1, 'PLANTA VILLA FATIMA', '77', '24', '6', '11088', '1850', '4', '0.4', '2960', '1', '24', '10', '240', 0.00, '2026-01-30 19:35:59', '2026-02-10 19:51:06');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cotizaciones`
--

CREATE TABLE `cotizaciones` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telefono` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cotizacion_detalles`
--

CREATE TABLE `cotizacion_detalles` (
  `id` bigint UNSIGNED NOT NULL,
  `cotizacion_id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `t_cantidad` int NOT NULL,
  `t_visitas` int NOT NULL,
  `t_precio` decimal(10,2) NOT NULL,
  `t_total` decimal(10,2) NOT NULL,
  `a_area` int NOT NULL,
  `a_visitas` int NOT NULL,
  `a_precio` decimal(10,2) NOT NULL,
  `a_total` decimal(10,2) NOT NULL,
  `i_cantidad` int NOT NULL,
  `i_precio` decimal(10,2) NOT NULL,
  `i_total` decimal(10,2) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cronogramas`
--

CREATE TABLE `cronogramas` (
  `id` bigint UNSIGNED NOT NULL,
  `almacen_id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `tecnico_id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` date NOT NULL,
  `color` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'bg-blue-500',
  `status` enum('pendiente','postergado','completado') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pendiente',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `cronogramas`
--

INSERT INTO `cronogramas` (`id`, `almacen_id`, `user_id`, `tecnico_id`, `title`, `date`, `color`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 2, 2, 'Desratización', '2026-01-13', 'bg-yellow-500', 'pendiente', '2026-01-30 19:35:59', '2026-01-30 19:35:59'),
(2, 1, 2, 2, 'Desratización', '2026-01-30', 'bg-yellow-500', 'pendiente', '2026-01-30 19:35:59', '2026-01-30 19:35:59'),
(3, 1, 2, 2, 'Desratización', '2026-02-12', 'bg-yellow-500', 'completado', '2026-01-30 19:35:59', '2026-01-30 20:09:02'),
(4, 1, 2, 2, 'Desratización', '2026-02-26', 'bg-yellow-500', 'completado', '2026-01-30 19:36:00', '2026-02-10 18:21:45'),
(5, 1, 2, 2, 'Desratización', '2026-03-12', 'bg-yellow-500', 'pendiente', '2026-01-30 19:36:00', '2026-01-30 19:36:00'),
(6, 1, 2, 2, 'Desratización', '2026-03-26', 'bg-yellow-500', 'pendiente', '2026-01-30 19:36:00', '2026-01-30 19:36:00'),
(7, 1, 2, 2, 'Desratización', '2026-04-12', 'bg-yellow-500', 'pendiente', '2026-01-30 19:36:00', '2026-01-30 19:36:00'),
(8, 1, 2, 2, 'Desratización', '2026-04-26', 'bg-yellow-500', 'pendiente', '2026-01-30 19:36:00', '2026-01-30 19:36:00'),
(9, 1, 2, 2, 'Desratización', '2026-05-07', 'bg-yellow-500', 'pendiente', '2026-01-30 19:36:00', '2026-01-30 19:36:00'),
(10, 1, 2, 2, 'Desratización', '2026-05-21', 'bg-yellow-500', 'pendiente', '2026-01-30 19:36:00', '2026-01-30 19:36:00'),
(11, 1, 2, 2, 'Desratización', '2026-06-11', 'bg-yellow-500', 'pendiente', '2026-01-30 19:36:00', '2026-01-30 19:36:00'),
(12, 1, 2, 2, 'Desratización', '2026-06-25', 'bg-yellow-500', 'pendiente', '2026-01-30 19:36:00', '2026-01-30 19:36:00'),
(13, 1, 2, 2, 'Desratización', '2026-07-09', 'bg-yellow-500', 'pendiente', '2026-01-30 19:36:00', '2026-01-30 19:36:00'),
(14, 1, 2, 2, 'Desratización', '2026-07-23', 'bg-yellow-500', 'pendiente', '2026-01-30 19:36:00', '2026-01-30 19:36:00'),
(15, 1, 2, 2, 'Desratización', '2026-08-06', 'bg-yellow-500', 'pendiente', '2026-01-30 19:36:00', '2026-01-30 19:36:00'),
(16, 1, 2, 2, 'Desratización', '2026-08-20', 'bg-yellow-500', 'pendiente', '2026-01-30 19:36:00', '2026-01-30 19:36:00'),
(17, 1, 2, 2, 'Desratización', '2026-09-10', 'bg-yellow-500', 'pendiente', '2026-01-30 19:36:00', '2026-01-30 19:36:00'),
(18, 1, 2, 2, 'Desratización', '2026-09-24', 'bg-yellow-500', 'pendiente', '2026-01-30 19:36:00', '2026-01-30 19:36:00'),
(19, 1, 2, 2, 'Desratización', '2026-10-08', 'bg-yellow-500', 'pendiente', '2026-01-30 19:36:00', '2026-01-30 19:36:00'),
(20, 1, 2, 2, 'Desratización', '2026-10-22', 'bg-yellow-500', 'pendiente', '2026-01-30 19:36:00', '2026-01-30 19:36:00'),
(21, 1, 2, 2, 'Desratización', '2026-11-12', 'bg-yellow-500', 'pendiente', '2026-01-30 19:36:01', '2026-01-30 19:36:01'),
(22, 1, 2, 2, 'Desratización', '2026-11-26', 'bg-yellow-500', 'pendiente', '2026-01-30 19:36:01', '2026-01-30 19:36:01'),
(23, 1, 2, 2, 'Desratización', '2026-12-09', 'bg-yellow-500', 'pendiente', '2026-01-30 19:36:01', '2026-01-30 19:36:01'),
(24, 1, 2, 2, 'Desratización', '2026-12-23', 'bg-yellow-500', 'pendiente', '2026-01-30 19:36:01', '2026-01-30 19:36:01'),
(25, 1, 2, 2, 'Fumigación', '2026-02-21', 'bg-blue-500', 'completado', '2026-01-30 19:36:01', '2026-01-30 20:16:06'),
(26, 1, 2, 2, 'Fumigación', '2026-05-23', 'bg-blue-500', 'pendiente', '2026-01-30 19:36:01', '2026-01-30 19:36:01'),
(27, 1, 2, 2, 'Fumigación', '2026-08-22', 'bg-blue-500', 'pendiente', '2026-01-30 19:36:01', '2026-01-30 19:36:01'),
(28, 1, 2, 2, 'Fumigación', '2026-11-21', 'bg-blue-500', 'pendiente', '2026-01-30 19:36:01', '2026-01-30 19:36:01'),
(29, 1, 2, 2, 'Insectocutores', '2026-01-13', 'bg-pink-600', 'pendiente', '2026-01-30 19:36:01', '2026-01-30 19:36:01'),
(30, 1, 2, 2, 'Insectocutores', '2026-01-30', 'bg-pink-600', 'pendiente', '2026-01-30 19:36:01', '2026-01-30 19:36:01'),
(31, 1, 2, 2, 'Insectocutores', '2026-02-12', 'bg-pink-600', 'completado', '2026-01-30 19:36:01', '2026-02-10 18:26:24'),
(32, 1, 2, 2, 'Insectocutores', '2026-02-26', 'bg-pink-600', 'completado', '2026-01-30 19:36:01', '2026-02-10 18:30:18'),
(33, 1, 2, 2, 'Insectocutores', '2026-03-12', 'bg-pink-600', 'pendiente', '2026-01-30 19:36:01', '2026-01-30 19:36:01'),
(34, 1, 2, 2, 'Insectocutores', '2026-03-26', 'bg-pink-600', 'pendiente', '2026-01-30 19:36:01', '2026-01-30 19:36:01'),
(35, 1, 2, 2, 'Insectocutores', '2026-04-09', 'bg-pink-600', 'pendiente', '2026-01-30 19:36:01', '2026-01-30 19:36:01'),
(36, 1, 2, 2, 'Insectocutores', '2026-04-23', 'bg-pink-600', 'pendiente', '2026-01-30 19:36:01', '2026-01-30 19:36:01'),
(37, 1, 2, 2, 'Insectocutores', '2026-05-07', 'bg-pink-600', 'pendiente', '2026-01-30 19:36:01', '2026-01-30 19:36:01'),
(38, 1, 2, 2, 'Insectocutores', '2026-05-21', 'bg-pink-600', 'pendiente', '2026-01-30 19:36:02', '2026-01-30 19:36:02'),
(39, 1, 2, 2, 'Insectocutores', '2026-06-11', 'bg-pink-600', 'pendiente', '2026-01-30 19:36:02', '2026-01-30 19:36:02'),
(40, 1, 2, 2, 'Insectocutores', '2026-06-25', 'bg-pink-600', 'pendiente', '2026-01-30 19:36:02', '2026-01-30 19:36:02'),
(41, 1, 2, 2, 'Insectocutores', '2026-07-09', 'bg-pink-600', 'pendiente', '2026-01-30 19:36:02', '2026-01-30 19:36:02'),
(42, 1, 2, 2, 'Insectocutores', '2026-07-23', 'bg-pink-600', 'pendiente', '2026-01-30 19:36:02', '2026-01-30 19:36:02'),
(43, 1, 2, 2, 'Insectocutores', '2026-08-06', 'bg-pink-600', 'pendiente', '2026-01-30 19:36:02', '2026-01-30 19:36:02'),
(44, 1, 2, 2, 'Insectocutores', '2026-08-20', 'bg-pink-600', 'pendiente', '2026-01-30 19:36:02', '2026-01-30 19:36:02'),
(45, 1, 2, 2, 'Insectocutores', '2026-09-10', 'bg-pink-600', 'pendiente', '2026-01-30 19:36:02', '2026-01-30 19:36:02'),
(46, 1, 2, 2, 'Insectocutores', '2026-09-24', 'bg-pink-600', 'pendiente', '2026-01-30 19:36:02', '2026-01-30 19:36:02'),
(47, 1, 2, 2, 'Insectocutores', '2026-10-08', 'bg-pink-600', 'pendiente', '2026-01-30 19:36:02', '2026-01-30 19:36:02'),
(48, 1, 2, 2, 'Insectocutores', '2026-10-22', 'bg-pink-600', 'pendiente', '2026-01-30 19:36:02', '2026-01-30 19:36:02'),
(49, 1, 2, 2, 'Insectocutores', '2026-11-12', 'bg-pink-600', 'pendiente', '2026-01-30 19:36:02', '2026-01-30 19:36:02'),
(50, 1, 2, 2, 'Insectocutores', '2026-11-26', 'bg-pink-600', 'pendiente', '2026-01-30 19:36:02', '2026-01-30 19:36:02'),
(51, 1, 2, 2, 'Insectocutores', '2026-12-09', 'bg-pink-600', 'pendiente', '2026-01-30 19:36:02', '2026-01-30 19:36:02'),
(52, 1, 2, 2, 'Insectocutores', '2026-12-23', 'bg-pink-600', 'pendiente', '2026-01-30 19:36:02', '2026-01-30 19:36:02'),
(53, 1, 3, 3, 'DESRATIZACION', '2026-01-13', 'bg-red-500', 'completado', '2026-02-10 20:34:53', '2026-02-10 20:34:53'),
(54, 1, 3, 3, 'DESRATIZACION', '2026-01-13', 'bg-red-500', 'pendiente', '2026-02-10 20:35:25', '2026-02-10 20:35:25'),
(55, 1, 3, 3, 'desratizacion', '2026-01-13', 'bg-red-500', 'pendiente', '2026-02-10 20:38:54', '2026-02-10 20:38:54'),
(56, 1, 2, 2, 'desratizacion', '2026-01-13', 'bg-red-500', 'completado', '2026-02-10 20:44:32', '2026-02-10 20:44:32'),
(57, 1, 2, 2, 'desratizacion', '2026-01-13', 'bg-red-500', 'pendiente', '2026-02-10 20:51:58', '2026-02-10 20:51:58'),
(58, 1, 2, 2, 'desra', '2026-01-13', 'bg-red-500', 'pendiente', '2026-02-10 20:55:00', '2026-02-10 20:55:00'),
(59, 1, 2, 2, 'desratizacion', '2026-01-13', 'bg-red-500', 'pendiente', '2026-02-10 21:05:48', '2026-02-10 21:05:48');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuentas_cobrar`
--

CREATE TABLE `cuentas_cobrar` (
  `id` bigint UNSIGNED NOT NULL,
  `venta_id` bigint UNSIGNED DEFAULT NULL,
  `contrato_id` bigint UNSIGNED DEFAULT NULL,
  `cliente_id` bigint UNSIGNED DEFAULT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `concepto` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `detalles` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total` double NOT NULL,
  `saldo` double NOT NULL,
  `estado` enum('Pendiente','Cancelado') COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_pago` date DEFAULT NULL,
  `plan_pagos` tinyint(1) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `cuentas_cobrar`
--

INSERT INTO `cuentas_cobrar` (`id`, `venta_id`, `contrato_id`, `cliente_id`, `user_id`, `concepto`, `detalles`, `total`, `saldo`, `estado`, `fecha_pago`, `plan_pagos`, `created_at`, `updated_at`) VALUES
(1, NULL, 1, NULL, 2, 'Contrato por cobrar #1', 'Saldo pendiento por cobrar sobre contrato', 14288, 14288, 'Pendiente', NULL, 0, '2026-01-30 19:36:02', '2026-02-10 19:51:06');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuentas_pagar`
--

CREATE TABLE `cuentas_pagar` (
  `id` bigint UNSIGNED NOT NULL,
  `compra_id` bigint UNSIGNED DEFAULT NULL,
  `proveedor_id` bigint UNSIGNED DEFAULT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `concepto` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `detalles` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total` double NOT NULL,
  `saldo` double NOT NULL,
  `estado` enum('Pendiente','Cancelado') COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_pago` date DEFAULT NULL,
  `plan_pagos` tinyint(1) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuenta_extras`
--

CREATE TABLE `cuenta_extras` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `cuenta_extras`
--

INSERT INTO `cuenta_extras` (`id`, `nombre`, `created_at`, `updated_at`) VALUES
(1, 'Gastos bancarios operativos', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(2, 'Capacitacion y cursos', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(3, 'Licencias de Software', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(4, 'Gastos de representación', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(5, 'Eventos y actividades', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(6, 'Seguridad y vigilancia', '2026-01-30 17:28:01', '2026-01-30 17:28:01');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuenta_financieros`
--

CREATE TABLE `cuenta_financieros` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `cuenta_financieros`
--

INSERT INTO `cuenta_financieros` (`id`, `nombre`, `created_at`, `updated_at`) VALUES
(1, 'Sueldos administrativos', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(2, 'Honorarios profesionales', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(3, 'Utiles de oficina', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(4, 'Alquiler de oficina', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(5, 'Energia Electrica', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(6, 'Agua', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(7, 'Telefono', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(8, 'Mantenimiento y reparaciones', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(9, 'Limpieza', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(10, 'Seguros', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(11, 'Depresiacion', '2026-01-30 17:28:01', '2026-01-30 17:28:01');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuenta_operativos`
--

CREATE TABLE `cuenta_operativos` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `cuenta_operativos`
--

INSERT INTO `cuenta_operativos` (`id`, `nombre`, `created_at`, `updated_at`) VALUES
(1, 'Sueldos personal', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(2, 'Comisiones sobre ventas', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(3, 'Marketing digital', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(4, 'Material promocional', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(5, 'Transporte y distribucion', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(6, 'Combustible', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(7, 'Viaticos y movilidad', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(8, 'Empaques y embalajes', '2026-01-30 17:28:01', '2026-01-30 17:28:01');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `documentos`
--

CREATE TABLE `documentos` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ruta` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `documentos`
--

INSERT INTO `documentos` (`id`, `nombre`, `descripcion`, `tipo`, `ruta`, `created_at`, `updated_at`) VALUES
(1, 'nit', '2331017014 unipersonal', 'pdf', 'documents/7hTJH470Z15R2V6FwHB0QUsIWuHewvVV1wmTsGc0.pdf', '2026-01-30 20:27:18', '2026-01-30 20:27:18');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empresas`
--

CREATE TABLE `empresas` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `direccion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telefono` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ciudad` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `empresas`
--

INSERT INTO `empresas` (`id`, `nombre`, `direccion`, `telefono`, `email`, `ciudad`, `activo`, `created_at`, `updated_at`) VALUES
(1, 'cascada', 'PLANTA VILLA FATIMA', '69722664', 'jessica_escobar@lacascada.com.bo', 'la paz', 1, '2026-01-30 19:35:59', '2026-02-10 19:51:05');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `epps`
--

CREATE TABLE `epps` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `epps`
--

INSERT INTO `epps` (`id`, `nombre`, `created_at`, `updated_at`) VALUES
(1, 'Ropa de trabajo', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(2, 'Casco de proteccion', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(3, 'Gorra', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(4, 'Guantes', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(5, 'Overol', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(6, 'Botas', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(7, 'Gafas', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(8, 'Antiparras', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(9, 'Respirados', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(10, 'Full face', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(11, 'Otros', '2026-01-30 17:28:01', '2026-01-30 17:28:01');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `especies`
--

CREATE TABLE `especies` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `especies`
--

INSERT INTO `especies` (`id`, `nombre`, `created_at`, `updated_at`) VALUES
(1, 'Moscas', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(2, 'Polillas', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(3, 'Mosquitos', '2026-01-30 17:28:01', '2026-01-30 17:28:01');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado_extras`
--

CREATE TABLE `estado_extras` (
  `id` bigint UNSIGNED NOT NULL,
  `estado_id` bigint UNSIGNED NOT NULL,
  `gasto_id` bigint UNSIGNED NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado_financieros`
--

CREATE TABLE `estado_financieros` (
  `id` bigint UNSIGNED NOT NULL,
  `estado_id` bigint UNSIGNED NOT NULL,
  `gasto_id` bigint UNSIGNED NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado_operativos`
--

CREATE TABLE `estado_operativos` (
  `id` bigint UNSIGNED NOT NULL,
  `estado_id` bigint UNSIGNED NOT NULL,
  `gasto_id` bigint UNSIGNED NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado_resultados`
--

CREATE TABLE `estado_resultados` (
  `id` bigint UNSIGNED NOT NULL,
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
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `etiquetas`
--

CREATE TABLE `etiquetas` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `etiqueta_productos`
--

CREATE TABLE `etiqueta_productos` (
  `id` bigint UNSIGNED NOT NULL,
  `etiqueta_id` bigint UNSIGNED NOT NULL,
  `producto_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `gastos`
--

CREATE TABLE `gastos` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `concepto` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `gasto_extras`
--

CREATE TABLE `gasto_extras` (
  `id` bigint UNSIGNED NOT NULL,
  `cuenta_id` bigint UNSIGNED NOT NULL,
  `concepto` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `gasto_financieros`
--

CREATE TABLE `gasto_financieros` (
  `id` bigint UNSIGNED NOT NULL,
  `cuenta_id` bigint UNSIGNED NOT NULL,
  `concepto` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `gasto_operativos`
--

CREATE TABLE `gasto_operativos` (
  `id` bigint UNSIGNED NOT NULL,
  `cuenta_id` bigint UNSIGNED NOT NULL,
  `concepto` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `hoja_tecnicas`
--

CREATE TABLE `hoja_tecnicas` (
  `id` bigint UNSIGNED NOT NULL,
  `producto_id` bigint UNSIGNED NOT NULL,
  `titulo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `archivo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `imagen` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ruta` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `hoja_tecnicas`
--

INSERT INTO `hoja_tecnicas` (`id`, `producto_id`, `titulo`, `archivo`, `url`, `imagen`, `ruta`, `created_at`, `updated_at`) VALUES
(1, 1, 'INSECTICIDA TITANE 5 EC', 'hojas-tecnicas/AuGGLAIIPN5FEJ2f5pA9eLa8RXpjuXJlIPQBtXtg.jpg', NULL, NULL, NULL, '2026-02-10 18:34:35', '2026-02-10 18:34:35'),
(2, 1, 'HOJA TECNICA', 'hojas-tecnicas/cVF1QOviuQXumXrwirqg2K0rXeSQQVq6GONqkJ4R.pdf', NULL, NULL, NULL, '2026-02-10 18:35:42', '2026-02-10 18:35:42');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ingresos`
--

CREATE TABLE `ingresos` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `concepto` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `insectocutores`
--

CREATE TABLE `insectocutores` (
  `id` bigint UNSIGNED NOT NULL,
  `almacen_id` bigint UNSIGNED NOT NULL,
  `mapa_id` bigint UNSIGNED NOT NULL,
  `posx` int NOT NULL,
  `posy` int NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `kardexes`
--

CREATE TABLE `kardexes` (
  `id` bigint UNSIGNED NOT NULL,
  `venta_id` bigint UNSIGNED DEFAULT NULL,
  `compra_id` bigint UNSIGNED DEFAULT NULL,
  `producto_id` bigint UNSIGNED DEFAULT NULL,
  `tipo` enum('Entrada','Salida') COLLATE utf8mb4_unicode_ci NOT NULL,
  `cantidad` int NOT NULL,
  `cantidad_saldo` int NOT NULL,
  `costo_unitario` double NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mapas`
--

CREATE TABLE `mapas` (
  `id` bigint UNSIGNED NOT NULL,
  `empresa_id` bigint UNSIGNED NOT NULL,
  `almacen_id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `background` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ;

--
-- Volcado de datos para la tabla `mapas`
--

INSERT INTO `mapas` (`id`, `empresa_id`, `almacen_id`, `user_id`, `data`, `background`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 2, NULL, 'images/mapas/1_1769806159.png', '2026-01-30 19:49:19', '2026-01-30 19:49:19'),
(2, 1, 1, 2, NULL, 'images/mapas/1_1770750867.png', '2026-02-10 18:14:27', '2026-02-10 18:14:27');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mapa_revisiones`
--

CREATE TABLE `mapa_revisiones` (
  `id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `marcas`
--

CREATE TABLE `marcas` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `metodos`
--

CREATE TABLE `metodos` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `metodos`
--

INSERT INTO `metodos` (`id`, `nombre`, `created_at`, `updated_at`) VALUES
(1, 'Alimento con veneno', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(2, 'Sustancia pegajosa', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(3, 'Alimento', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(4, 'Aspersion', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(5, 'Niebla', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(6, 'Nebulizacion', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(7, 'Fumigacion', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(8, 'Otros', '2026-01-30 17:28:01', '2026-01-30 17:28:01');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
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
(18, '2025_11_25_051718_create_seguimientos_table', 1),
(19, '2025_11_25_051734_create_cronogramas_table', 1),
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
(81, '2026_01_13_143809_create_trampa_roedor_seguimientos_table', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1, 'App\\Models\\User', 2),
(4, 'App\\Models\\User', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pagar_cuotas`
--

CREATE TABLE `pagar_cuotas` (
  `id` bigint UNSIGNED NOT NULL,
  `cuenta_pagar_id` bigint UNSIGNED NOT NULL,
  `numero_cuota` int NOT NULL,
  `fecha_vencimiento` date NOT NULL,
  `monto` decimal(12,2) NOT NULL,
  `estado` enum('pendiente','pagado','vencido') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pendiente',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pagar_pagos`
--

CREATE TABLE `pagar_pagos` (
  `id` bigint UNSIGNED NOT NULL,
  `cuenta_pagar_id` bigint UNSIGNED NOT NULL,
  `cuota_id` bigint UNSIGNED DEFAULT NULL,
  `fecha_pago` date NOT NULL,
  `monto` decimal(12,2) NOT NULL,
  `metodo_pago` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `observacion` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'empresas', 'web', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(2, 'cotizaciones', 'web', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(3, 'contratos', 'web', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(4, 'almacenes', 'web', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(5, 'cronogramas', 'web', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(6, 'mapas', 'web', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(7, 'seguimientos', 'web', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(8, 'certificados', 'web', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(9, 'cuentascobrar', 'web', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(10, 'cuentaspagar', 'web', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(11, 'compras', 'web', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(12, 'ingresos', 'web', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(13, 'retiros', 'web', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(14, 'gastos', 'web', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(15, 'productos', 'web', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(16, 'categorias', 'web', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(17, 'subcategorias', 'web', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(18, 'marcas', 'web', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(19, 'etiquetas', 'web', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(20, 'proveedores', 'web', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(21, 'inventario', 'web', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(22, 'agenda', 'web', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(23, 'documentos', 'web', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(24, 'usuarios', 'web', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(25, 'configuraciones', 'web', '2026-01-30 17:28:01', '2026-01-30 17:28:01');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
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
  `id` bigint UNSIGNED NOT NULL,
  `categoria_id` bigint UNSIGNED DEFAULT NULL,
  `marca_id` bigint UNSIGNED DEFAULT NULL,
  `unidad_id` bigint UNSIGNED DEFAULT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `unidad_valor` int NOT NULL DEFAULT '1',
  `stock` int DEFAULT NULL,
  `stock_min` int NOT NULL DEFAULT '1',
  `precio_compra` decimal(10,2) DEFAULT NULL,
  `precio_venta` decimal(10,2) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id`, `categoria_id`, `marca_id`, `unidad_id`, `nombre`, `descripcion`, `unidad_valor`, `stock`, `stock_min`, `precio_compra`, `precio_venta`, `created_at`, `updated_at`) VALUES
(1, NULL, NULL, 1, 'klerat', 'raticida', 150, NULL, 50, NULL, NULL, '2026-01-30 20:04:57', '2026-01-30 20:04:57'),
(2, NULL, NULL, 2, 'titane', 'insecticida', 100, NULL, 3, NULL, NULL, '2026-01-30 20:05:31', '2026-01-30 20:05:31');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto_usos`
--

CREATE TABLE `producto_usos` (
  `id` bigint UNSIGNED NOT NULL,
  `producto_id` bigint UNSIGNED NOT NULL,
  `seguimiento_id` bigint UNSIGNED NOT NULL,
  `unidad_id` bigint UNSIGNED NOT NULL,
  `cantidad` int NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `producto_usos`
--

INSERT INTO `producto_usos` (`id`, `producto_id`, `seguimiento_id`, `unidad_id`, `cantidad`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 150, '2026-01-30 20:09:03', '2026-01-30 20:09:03'),
(2, 2, 2, 2, 100, '2026-01-30 20:16:07', '2026-01-30 20:16:07'),
(3, 1, 3, 1, 100, '2026-02-10 18:21:45', '2026-02-10 18:21:45');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto_vencimientos`
--

CREATE TABLE `producto_vencimientos` (
  `id` bigint UNSIGNED NOT NULL,
  `producto_id` bigint UNSIGNED NOT NULL,
  `codigo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `vencimiento` date NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `protecciones`
--

CREATE TABLE `protecciones` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `protecciones`
--

INSERT INTO `protecciones` (`id`, `nombre`, `created_at`, `updated_at`) VALUES
(1, 'Señalizacion', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(2, 'Hoja de seguimiento', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(3, 'Otros', '2026-01-30 17:28:01', '2026-01-30 17:28:01');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores`
--

CREATE TABLE `proveedores` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `direccion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telefono` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contacto` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `retiros`
--

CREATE TABLE `retiros` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `concepto` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'superadmin', 'web', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(2, 'admin', 'web', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(3, 'tecnico', 'web', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(4, 'cliente', 'web', '2026-01-30 17:28:01', '2026-01-30 17:28:01');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` bigint UNSIGNED NOT NULL,
  `role_id` bigint UNSIGNED NOT NULL
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
  `id` bigint UNSIGNED NOT NULL,
  `empresa_id` bigint UNSIGNED NOT NULL,
  `almacen_id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `tipo_seguimiento_id` bigint UNSIGNED DEFAULT NULL,
  `contacto_id` bigint UNSIGNED DEFAULT NULL,
  `encargado_nombre` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `encargado_cargo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `firma_encargado` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `firma_supervisor` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `observaciones` text COLLATE utf8mb4_unicode_ci,
  `observacionesp` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `seguimientos`
--

INSERT INTO `seguimientos` (`id`, `empresa_id`, `almacen_id`, `user_id`, `tipo_seguimiento_id`, `contacto_id`, `encargado_nombre`, `encargado_cargo`, `firma_encargado`, `firma_supervisor`, `observaciones`, `observacionesp`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 2, 2, NULL, 'franklin', 'almacenero', 'images/firmas/firma_encargado_1769807342.png', 'images/firmas/firma_supervisor_1769807342.png', 'se cumplio con el cronograma', 'inicio de trabajo', '2026-01-30 20:09:02', '2026-01-30 20:09:02'),
(2, 1, 1, 2, 3, NULL, 'franklin', 'almacenero', 'images/firmas/firma_encargado_1769807766.png', 'images/firmas/firma_supervisor_1769807766.png', 'fumigacion planta cascada', 'primera aplicacion', '2026-01-30 20:16:06', '2026-01-30 20:16:06'),
(3, 1, 1, 2, 2, NULL, 'JUAN PERES', 'ALMACENERO', 'images/firmas/firma_encargado_1770751305.png', 'images/firmas/firma_supervisor_1770751305.png', 'PRIMER ENSAYO', 'PRIMERA EVALUACION', '2026-02-10 18:21:45', '2026-02-10 18:21:45'),
(4, 1, 1, 2, 3, NULL, 'JOTA', 'CHEF', 'images/firmas/firma_encargado_1770751584.png', 'images/firmas/firma_supervisor_1770751584.png', NULL, 'SIN OBSERVACIONES', '2026-02-10 18:26:24', '2026-02-10 18:26:24'),
(5, 1, 1, 2, 3, NULL, 'FREDDY', 'CHEF', 'images/firmas/firma_encargado_1770751818.png', 'images/firmas/firma_supervisor_1770751818.png', NULL, NULL, '2026-02-10 18:30:18', '2026-02-10 18:30:18');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `seguimiento_biologicos`
--

CREATE TABLE `seguimiento_biologicos` (
  `id` bigint UNSIGNED NOT NULL,
  `seguimiento_id` bigint UNSIGNED NOT NULL,
  `biologico_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `seguimiento_epps`
--

CREATE TABLE `seguimiento_epps` (
  `id` bigint UNSIGNED NOT NULL,
  `seguimiento_id` bigint UNSIGNED NOT NULL,
  `epp_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `seguimiento_epps`
--

INSERT INTO `seguimiento_epps` (`id`, `seguimiento_id`, `epp_id`, `created_at`, `updated_at`) VALUES
(1, 1, 2, '2026-01-30 20:09:03', '2026-01-30 20:09:03'),
(2, 1, 4, '2026-01-30 20:09:03', '2026-01-30 20:09:03'),
(3, 1, 5, '2026-01-30 20:09:03', '2026-01-30 20:09:03'),
(4, 1, 6, '2026-01-30 20:09:03', '2026-01-30 20:09:03'),
(5, 2, 2, '2026-01-30 20:16:06', '2026-01-30 20:16:06'),
(6, 2, 4, '2026-01-30 20:16:06', '2026-01-30 20:16:06'),
(7, 2, 5, '2026-01-30 20:16:06', '2026-01-30 20:16:06'),
(8, 2, 10, '2026-01-30 20:16:06', '2026-01-30 20:16:06'),
(9, 2, 6, '2026-01-30 20:16:06', '2026-01-30 20:16:06'),
(10, 3, 4, '2026-02-10 18:21:45', '2026-02-10 18:21:45'),
(11, 3, 5, '2026-02-10 18:21:45', '2026-02-10 18:21:45'),
(12, 3, 6, '2026-02-10 18:21:45', '2026-02-10 18:21:45'),
(13, 3, 3, '2026-02-10 18:21:45', '2026-02-10 18:21:45'),
(14, 4, 2, '2026-02-10 18:26:24', '2026-02-10 18:26:24'),
(15, 4, 5, '2026-02-10 18:26:24', '2026-02-10 18:26:24'),
(16, 4, 6, '2026-02-10 18:26:24', '2026-02-10 18:26:24'),
(17, 4, 9, '2026-02-10 18:26:24', '2026-02-10 18:26:24'),
(18, 5, 5, '2026-02-10 18:30:18', '2026-02-10 18:30:18'),
(19, 5, 2, '2026-02-10 18:30:19', '2026-02-10 18:30:19'),
(20, 5, 6, '2026-02-10 18:30:19', '2026-02-10 18:30:19'),
(21, 5, 9, '2026-02-10 18:30:19', '2026-02-10 18:30:19');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `seguimiento_especies`
--

CREATE TABLE `seguimiento_especies` (
  `id` bigint UNSIGNED NOT NULL,
  `seguimiento_id` bigint UNSIGNED NOT NULL,
  `especie_id` bigint UNSIGNED NOT NULL,
  `cantidad` int NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `seguimiento_images`
--

CREATE TABLE `seguimiento_images` (
  `id` bigint UNSIGNED NOT NULL,
  `seguimiento_id` bigint UNSIGNED NOT NULL,
  `imagen` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `seguimiento_images`
--

INSERT INTO `seguimiento_images` (`id`, `seguimiento_id`, `imagen`, `created_at`, `updated_at`) VALUES
(1, 1, 'images/seguimientos/697d1df2117d2_bcb 9.jpg', '2026-01-30 20:09:06', '2026-01-30 20:09:06'),
(2, 2, 'images/seguimientos/697d1f9987127_bcb 6.jpg', '2026-01-30 20:16:09', '2026-01-30 20:16:09'),
(3, 2, 'images/seguimientos/697d1f9994c5b_bcb 8.jpg', '2026-01-30 20:16:09', '2026-01-30 20:16:09'),
(4, 3, 'images/seguimientos/698b854b969a1_CAJA 9.jpg', '2026-02-10 18:21:47', '2026-02-10 18:21:47'),
(5, 3, 'images/seguimientos/698b854ba0e60_CAJA 12 ROEDOR.jpg', '2026-02-10 18:21:47', '2026-02-10 18:21:47'),
(6, 3, 'images/seguimientos/698b854baae2e_CAJA 17.jpg', '2026-02-10 18:21:47', '2026-02-10 18:21:47');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `seguimiento_metodos`
--

CREATE TABLE `seguimiento_metodos` (
  `id` bigint UNSIGNED NOT NULL,
  `seguimiento_id` bigint UNSIGNED NOT NULL,
  `metodo_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `seguimiento_metodos`
--

INSERT INTO `seguimiento_metodos` (`id`, `seguimiento_id`, `metodo_id`, `created_at`, `updated_at`) VALUES
(1, 1, 3, '2026-01-30 20:09:03', '2026-01-30 20:09:03'),
(2, 1, 1, '2026-01-30 20:09:03', '2026-01-30 20:09:03'),
(3, 1, 2, '2026-01-30 20:09:03', '2026-01-30 20:09:03'),
(4, 2, 7, '2026-01-30 20:16:06', '2026-01-30 20:16:06'),
(5, 3, 3, '2026-02-10 18:21:45', '2026-02-10 18:21:45'),
(6, 3, 1, '2026-02-10 18:21:45', '2026-02-10 18:21:45');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `seguimiento_protecciones`
--

CREATE TABLE `seguimiento_protecciones` (
  `id` bigint UNSIGNED NOT NULL,
  `seguimiento_id` bigint UNSIGNED NOT NULL,
  `proteccion_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `seguimiento_protecciones`
--

INSERT INTO `seguimiento_protecciones` (`id`, `seguimiento_id`, `proteccion_id`, `created_at`, `updated_at`) VALUES
(1, 1, 2, '2026-01-30 20:09:03', '2026-01-30 20:09:03'),
(2, 1, 1, '2026-01-30 20:09:03', '2026-01-30 20:09:03'),
(3, 2, 2, '2026-01-30 20:16:06', '2026-01-30 20:16:06'),
(4, 2, 1, '2026-01-30 20:16:06', '2026-01-30 20:16:06'),
(5, 3, 2, '2026-02-10 18:21:45', '2026-02-10 18:21:45'),
(6, 3, 1, '2026-02-10 18:21:45', '2026-02-10 18:21:45'),
(7, 4, 2, '2026-02-10 18:26:24', '2026-02-10 18:26:24'),
(8, 4, 1, '2026-02-10 18:26:24', '2026-02-10 18:26:24'),
(9, 5, 2, '2026-02-10 18:30:19', '2026-02-10 18:30:19'),
(10, 5, 1, '2026-02-10 18:30:19', '2026-02-10 18:30:19');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `seguimiento_signos`
--

CREATE TABLE `seguimiento_signos` (
  `id` bigint UNSIGNED NOT NULL,
  `seguimiento_id` bigint UNSIGNED NOT NULL,
  `signo_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('8613wP8jTZJJN1y6o8u0KmS5IQg5BjWbUz1ZJLdP', 1, '2800:cd0:161:8d25:773d:f43b:c7b1:65ea', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiWkZDd1pnS2lWSE9qNDJZVUJoTWs2bjkzc0xhSW9wZVIzcDBGNHhFdiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mzg6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmJpdGRlc2Fycm9sbG8ubmV0IjtzOjU6InJvdXRlIjtzOjQ6ImhvbWUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO30=', 1770753681),
('CbaSHlNE4aheWq4y5vyFTKMIE4SeB6lsml4DwJoq', NULL, '200.87.246.135', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMlg0cFJJRk9YOVdGVUFGSEV1RzdRMWpFbnk0Q2RzZEtyRENDZVVkdSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDQ6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmJpdGRlc2Fycm9sbG8ubmV0L2xvZ2luIjtzOjU6InJvdXRlIjtzOjU6ImxvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1770769099),
('E1w3zuAardFSAs2QuWeAV6PqnG1FxgpaykVBiEMU', 2, '190.129.164.30', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiYWMyY0NjUU5uekMxWUtyeEwwWFBTeHQ3ekNzRFdGU0V2OXZCNXRjayI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDQ6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmJpdGRlc2Fycm9sbG8ubmV0L2xvZ2luIjtzOjU6InJvdXRlIjtzOjU6ImxvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6Mjt9', 1770761066),
('MSCUKAoVeNCMcCoVhXXf8lRAzsSBoj8Y3IuZkHwR', NULL, '66.249.88.162', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidUhZMjhLOUs3S1NzZ3dXTjRtQVR6QmZ2NVBHc0xvV0M1NnlDMlY2SCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mzg6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmJpdGRlc2Fycm9sbG8ubmV0IjtzOjU6InJvdXRlIjtzOjQ6ImhvbWUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1770753686),
('ohlskXrgc3PMvROWKT9vW5M97M2jZtoPJe7eORET', NULL, '66.249.85.96', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiajdhMjJ5M1J0NUN6ZFJpSXNVZ3c5R1hVSU0yUGdaS0xYdU02R3A4cSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mzg6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmJpdGRlc2Fycm9sbG8ubmV0IjtzOjU6InJvdXRlIjtzOjQ6ImhvbWUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1770753685),
('OnTvzkPLFpZWGgSwLb7DySg0LZgpfyQ4O4kAwnDg', 2, '177.222.112.216', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiQXBIUnhmajV3dlRXWHE3UDF2M2tFQXhaZFhOUlJWZ1BueFdTU0tlTiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDg6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmJpdGRlc2Fycm9sbG8ubmV0L2Rhc2hib2FyZCI7czo1OiJyb3V0ZSI7czo5OiJkYXNoYm9hcmQiO31zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToyO30=', 1770762845),
('RJEqT08xwwi1UhnwlZPb9jAaSf6vsyFstxrshRJg', NULL, '177.222.49.62', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiU0R6YTdUYUZSWkRNaUQ2Z1JEbGRTZjFVYmppRGQ1VWpBbTFXWkFVVyI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czo3NjoiaHR0cHM6Ly9ib2xpdmlhbnBlc3QuYml0ZGVzYXJyb2xsby5uZXQvY3Jvbm9ncmFtYXM/YWxtYWNlbl9pZD0xJmVtcHJlc2FfaWQ9MSI7fXM6OToiX3ByZXZpb3VzIjthOjI6e3M6MzoidXJsIjtzOjQ0OiJodHRwczovL2JvbGl2aWFucGVzdC5iaXRkZXNhcnJvbGxvLm5ldC9sb2dpbiI7czo1OiJyb3V0ZSI7czo1OiJsb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1770769094),
('Tja4aCEK6qHOMgqNKgxTgTOnoWIkmLJAaEG9cBKj', NULL, '66.249.88.163', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUzJmaHVVZjRLRnlGUzkwWktMalVMYnhnTkd1bEtqUGlSQUF0MXhKdCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mzg6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmJpdGRlc2Fycm9sbG8ubmV0IjtzOjU6InJvdXRlIjtzOjQ6ImhvbWUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1770753686);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `signos`
--

CREATE TABLE `signos` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `signos`
--

INSERT INTO `signos` (`id`, `nombre`, `created_at`, `updated_at`) VALUES
(1, 'Huellas', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(2, 'Roeduras', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(3, 'Madriguera', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(4, 'Senda', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(5, 'Excrementos', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(6, 'Marca de orina', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(7, 'Otros', '2026-01-30 17:28:01', '2026-01-30 17:28:01');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `subcategorias`
--

CREATE TABLE `subcategorias` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `categoria_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_seguimientos`
--

CREATE TABLE `tipo_seguimientos` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `tipo_seguimientos`
--

INSERT INTO `tipo_seguimientos` (`id`, `nombre`, `created_at`, `updated_at`) VALUES
(1, 'DESINFECCION', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(2, 'DESRATIZACION', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(3, 'DESINSECTACION', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(4, 'CONTROL DE AVES', '2026-01-30 17:28:01', '2026-01-30 17:28:01');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `trampas`
--

CREATE TABLE `trampas` (
  `id` bigint UNSIGNED NOT NULL,
  `almacen_id` bigint UNSIGNED NOT NULL,
  `mapa_id` bigint UNSIGNED NOT NULL,
  `trampa_tipo_id` bigint UNSIGNED NOT NULL,
  `numero` int NOT NULL,
  `tipo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `posx` int NOT NULL,
  `posy` int NOT NULL,
  `estado` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `trampas`
--

INSERT INTO `trampas` (`id`, `almacen_id`, `mapa_id`, `trampa_tipo_id`, `numero`, `tipo`, `posx`, `posy`, `estado`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 3, 1, 'null', 962, 19, 'activo', '2026-01-30 19:49:19', '2026-02-10 18:27:28'),
(2, 1, 1, 3, 2, 'null', 781, 22, 'activo', '2026-01-30 19:49:19', '2026-02-10 18:27:28'),
(3, 1, 1, 3, 3, 'null', 782, 142, 'activo', '2026-01-30 19:49:19', '2026-02-10 18:27:28'),
(4, 1, 1, 3, 4, 'null', 853, 150, 'activo', '2026-01-30 19:49:19', '2026-02-10 18:27:28'),
(5, 1, 1, 3, 5, 'null', 785, 203, 'activo', '2026-01-30 19:49:19', '2026-02-10 18:27:29'),
(6, 1, 1, 3, 6, 'null', 753, 19, 'activo', '2026-01-30 19:49:20', '2026-02-10 18:27:29'),
(7, 1, 1, 3, 7, 'null', 537, 21, 'activo', '2026-01-30 19:49:20', '2026-02-10 18:27:29'),
(8, 1, 1, 3, 8, 'null', 349, 18, 'activo', '2026-01-30 19:49:20', '2026-02-10 18:27:29'),
(9, 1, 1, 3, 9, 'null', 190, 17, 'activo', '2026-01-30 19:49:20', '2026-02-10 18:27:29'),
(10, 1, 1, 3, 10, 'null', 60, 21, 'activo', '2026-01-30 19:49:20', '2026-02-10 18:27:29'),
(11, 1, 1, 4, 11, 'null', 131, 95, 'activo', '2026-01-30 19:49:20', '2026-02-10 18:27:29'),
(12, 1, 1, 4, 12, 'null', 340, 73, 'activo', '2026-01-30 19:49:20', '2026-02-10 18:27:29'),
(13, 1, 1, 4, 13, 'null', 550, 65, 'activo', '2026-01-30 19:49:20', '2026-02-10 18:27:29'),
(14, 1, 1, 4, 14, 'null', 558, 229, 'activo', '2026-01-30 19:49:20', '2026-02-10 18:27:29'),
(15, 1, 1, 4, 15, 'null', 394, 69, 'activo', '2026-01-30 19:49:20', '2026-02-10 18:27:29'),
(16, 1, 1, 4, 16, 'null', 395, 252, 'activo', '2026-01-30 19:49:20', '2026-02-10 18:27:29'),
(17, 1, 1, 4, 17, 'null', 727, 62, 'activo', '2026-01-30 19:49:20', '2026-02-10 18:27:29'),
(18, 1, 1, 4, 18, 'null', 718, 239, 'activo', '2026-01-30 19:49:20', '2026-02-10 18:27:29'),
(19, 1, 1, 4, 19, 'null', 726, 321, 'activo', '2026-01-30 19:49:20', '2026-02-10 18:27:29'),
(20, 1, 1, 4, 20, 'null', 610, 320, 'activo', '2026-01-30 19:49:20', '2026-02-10 18:27:29'),
(21, 1, 1, 4, 21, 'null', 717, 378, 'activo', '2026-01-30 19:49:20', '2026-02-10 18:27:29'),
(22, 1, 1, 4, 22, 'null', 738, 405, 'activo', '2026-01-30 19:49:20', '2026-02-10 18:27:29'),
(23, 1, 1, 4, 23, 'null', 731, 430, 'activo', '2026-01-30 19:49:21', '2026-02-10 18:27:29'),
(24, 1, 1, 4, 24, 'null', 734, 461, 'activo', '2026-01-30 19:49:21', '2026-02-10 18:27:29'),
(25, 1, 1, 4, 25, 'null', 663, 460, 'activo', '2026-01-30 19:49:21', '2026-02-10 18:27:29'),
(26, 1, 1, 4, 26, 'null', 619, 461, 'activo', '2026-01-30 19:49:21', '2026-02-10 18:27:29'),
(27, 1, 1, 4, 27, 'null', 583, 462, 'activo', '2026-01-30 19:49:21', '2026-02-10 18:27:29'),
(28, 1, 1, 4, 28, 'null', 735, 504, 'activo', '2026-01-30 19:49:21', '2026-02-10 18:27:29'),
(29, 1, 1, 4, 29, 'null', 733, 550, 'activo', '2026-01-30 19:49:21', '2026-02-10 18:27:30'),
(30, 1, 1, 4, 30, 'null', 735, 644, 'activo', '2026-01-30 19:49:21', '2026-02-10 18:27:30'),
(31, 1, 1, 4, 31, 'null', 687, 675, 'activo', '2026-01-30 19:49:21', '2026-02-10 18:27:30'),
(32, 1, 1, 4, 32, 'null', 341, 676, 'activo', '2026-01-30 19:49:21', '2026-02-10 18:27:30'),
(33, 1, 1, 4, 33, 'null', 360, 635, 'activo', '2026-01-30 19:49:21', '2026-02-10 18:27:30'),
(34, 1, 1, 3, 34, 'null', 377, 520, 'activo', '2026-01-30 19:49:21', '2026-02-10 18:27:30'),
(35, 1, 1, 3, 35, 'null', 306, 515, 'activo', '2026-01-30 19:49:21', '2026-02-10 18:27:30'),
(36, 1, 1, 3, 36, 'null', 296, 385, 'activo', '2026-01-30 19:49:21', '2026-02-10 18:27:30'),
(37, 1, 1, 3, 37, 'null', 379, 378, 'activo', '2026-01-30 19:49:21', '2026-02-10 18:27:30'),
(38, 1, 1, 3, 38, 'null', 382, 303, 'activo', '2026-01-30 19:49:21', '2026-02-10 18:27:30'),
(39, 1, 1, 3, 39, 'null', 298, 304, 'activo', '2026-01-30 19:49:21', '2026-02-10 18:27:30'),
(40, 1, 1, 3, 40, 'null', 339, 271, 'activo', '2026-01-30 19:49:22', '2026-02-10 18:27:30'),
(41, 1, 1, 3, 41, 'null', 258, 214, 'activo', '2026-01-30 19:49:22', '2026-02-10 18:27:30'),
(42, 1, 1, 3, 42, 'null', 178, 145, 'activo', '2026-01-30 19:49:22', '2026-02-10 18:27:30'),
(43, 1, 1, 3, 43, 'null', 185, 68, 'activo', '2026-01-30 19:49:22', '2026-02-10 18:27:30'),
(44, 1, 1, 3, 44, 'null', 284, 68, 'activo', '2026-01-30 19:49:22', '2026-02-10 18:27:30'),
(45, 1, 2, 3, 1, 'null', 516, 628, 'activo', '2026-02-10 18:14:27', '2026-02-10 18:14:27'),
(46, 1, 2, 3, 2, 'null', 771, 624, 'activo', '2026-02-10 18:14:27', '2026-02-10 18:14:27'),
(47, 1, 2, 3, 3, 'null', 739, 356, 'activo', '2026-02-10 18:14:28', '2026-02-10 18:14:28'),
(48, 1, 2, 3, 4, 'null', 594, 195, 'activo', '2026-02-10 18:14:28', '2026-02-10 18:14:28'),
(49, 1, 2, 3, 5, 'null', 264, 190, 'activo', '2026-02-10 18:14:28', '2026-02-10 18:14:28'),
(50, 1, 2, 3, 6, 'null', 95, 188, 'activo', '2026-02-10 18:14:28', '2026-02-10 18:14:28'),
(51, 1, 1, 2, 45, NULL, 627, 200, 'activo', '2026-02-10 18:27:30', '2026-02-10 18:27:30'),
(52, 1, 1, 2, 46, NULL, 583, 556, 'activo', '2026-02-10 18:27:30', '2026-02-10 18:27:30'),
(53, 1, 1, 2, 47, NULL, 407, 628, 'activo', '2026-02-10 18:27:30', '2026-02-10 18:27:30');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `trampa_especie_seguimientos`
--

CREATE TABLE `trampa_especie_seguimientos` (
  `id` bigint UNSIGNED NOT NULL,
  `seguimiento_id` bigint UNSIGNED NOT NULL,
  `trampa_id` bigint UNSIGNED NOT NULL,
  `especie_id` bigint UNSIGNED NOT NULL,
  `cantidad` int NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `trampa_especie_seguimientos`
--

INSERT INTO `trampa_especie_seguimientos` (`id`, `seguimiento_id`, `trampa_id`, `especie_id`, `cantidad`, `created_at`, `updated_at`) VALUES
(1, 5, 51, 1, 5, '2026-02-10 18:31:59', '2026-02-10 18:31:59'),
(2, 5, 51, 2, 5, '2026-02-10 18:31:59', '2026-02-10 18:31:59'),
(3, 5, 52, 2, 3, '2026-02-10 18:31:59', '2026-02-10 18:31:59'),
(4, 5, 52, 1, 3, '2026-02-10 18:31:59', '2026-02-10 18:31:59'),
(5, 5, 53, 1, 5, '2026-02-10 18:31:59', '2026-02-10 18:31:59');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `trampa_roedor_seguimientos`
--

CREATE TABLE `trampa_roedor_seguimientos` (
  `id` bigint UNSIGNED NOT NULL,
  `seguimiento_id` bigint UNSIGNED NOT NULL,
  `trampa_id` bigint UNSIGNED NOT NULL,
  `observacion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cantidad` int NOT NULL,
  `inicial` double NOT NULL,
  `merma` double NOT NULL,
  `actual` double NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `trampa_roedor_seguimientos`
--

INSERT INTO `trampa_roedor_seguimientos` (`id`, `seguimiento_id`, `trampa_id`, `observacion`, `cantidad`, `inicial`, `merma`, `actual`, `created_at`, `updated_at`) VALUES
(45, 2, 1, NULL, 0, 0, 0, 0, '2026-01-30 20:16:07', '2026-01-30 20:16:07'),
(46, 2, 2, NULL, 0, 0, 0, 0, '2026-01-30 20:16:07', '2026-01-30 20:16:07'),
(47, 2, 3, NULL, 0, 0, 0, 0, '2026-01-30 20:16:07', '2026-01-30 20:16:07'),
(48, 2, 4, NULL, 0, 0, 0, 0, '2026-01-30 20:16:07', '2026-01-30 20:16:07'),
(49, 2, 5, NULL, 0, 0, 0, 0, '2026-01-30 20:16:07', '2026-01-30 20:16:07'),
(50, 2, 6, NULL, 0, 0, 0, 0, '2026-01-30 20:16:07', '2026-01-30 20:16:07'),
(51, 2, 7, NULL, 0, 0, 0, 0, '2026-01-30 20:16:07', '2026-01-30 20:16:07'),
(52, 2, 8, NULL, 0, 0, 0, 0, '2026-01-30 20:16:07', '2026-01-30 20:16:07'),
(53, 2, 9, NULL, 0, 0, 0, 0, '2026-01-30 20:16:07', '2026-01-30 20:16:07'),
(54, 2, 10, NULL, 0, 0, 0, 0, '2026-01-30 20:16:07', '2026-01-30 20:16:07'),
(55, 2, 11, NULL, 0, 0, 0, 0, '2026-01-30 20:16:07', '2026-01-30 20:16:07'),
(56, 2, 12, NULL, 0, 0, 0, 0, '2026-01-30 20:16:07', '2026-01-30 20:16:07'),
(57, 2, 13, NULL, 0, 0, 0, 0, '2026-01-30 20:16:07', '2026-01-30 20:16:07'),
(58, 2, 14, NULL, 0, 0, 0, 0, '2026-01-30 20:16:07', '2026-01-30 20:16:07'),
(59, 2, 15, NULL, 0, 0, 0, 0, '2026-01-30 20:16:07', '2026-01-30 20:16:07'),
(60, 2, 16, NULL, 0, 0, 0, 0, '2026-01-30 20:16:07', '2026-01-30 20:16:07'),
(61, 2, 17, NULL, 0, 0, 0, 0, '2026-01-30 20:16:08', '2026-01-30 20:16:08'),
(62, 2, 18, NULL, 0, 0, 0, 0, '2026-01-30 20:16:08', '2026-01-30 20:16:08'),
(63, 2, 19, NULL, 0, 0, 0, 0, '2026-01-30 20:16:08', '2026-01-30 20:16:08'),
(64, 2, 20, NULL, 0, 0, 0, 0, '2026-01-30 20:16:08', '2026-01-30 20:16:08'),
(65, 2, 21, NULL, 0, 0, 0, 0, '2026-01-30 20:16:08', '2026-01-30 20:16:08'),
(66, 2, 22, NULL, 0, 0, 0, 0, '2026-01-30 20:16:08', '2026-01-30 20:16:08'),
(67, 2, 23, NULL, 0, 0, 0, 0, '2026-01-30 20:16:08', '2026-01-30 20:16:08'),
(68, 2, 24, NULL, 0, 0, 0, 0, '2026-01-30 20:16:08', '2026-01-30 20:16:08'),
(69, 2, 25, NULL, 0, 0, 0, 0, '2026-01-30 20:16:08', '2026-01-30 20:16:08'),
(70, 2, 26, NULL, 0, 0, 0, 0, '2026-01-30 20:16:08', '2026-01-30 20:16:08'),
(71, 2, 27, NULL, 0, 0, 0, 0, '2026-01-30 20:16:08', '2026-01-30 20:16:08'),
(72, 2, 28, NULL, 0, 0, 0, 0, '2026-01-30 20:16:08', '2026-01-30 20:16:08'),
(73, 2, 29, NULL, 0, 0, 0, 0, '2026-01-30 20:16:08', '2026-01-30 20:16:08'),
(74, 2, 30, NULL, 0, 0, 0, 0, '2026-01-30 20:16:08', '2026-01-30 20:16:08'),
(75, 2, 31, NULL, 0, 0, 0, 0, '2026-01-30 20:16:08', '2026-01-30 20:16:08'),
(76, 2, 32, NULL, 0, 0, 0, 0, '2026-01-30 20:16:08', '2026-01-30 20:16:08'),
(77, 2, 33, NULL, 0, 0, 0, 0, '2026-01-30 20:16:08', '2026-01-30 20:16:08'),
(78, 2, 34, NULL, 0, 0, 0, 0, '2026-01-30 20:16:08', '2026-01-30 20:16:08'),
(79, 2, 35, NULL, 0, 0, 0, 0, '2026-01-30 20:16:08', '2026-01-30 20:16:08'),
(80, 2, 36, NULL, 0, 0, 0, 0, '2026-01-30 20:16:09', '2026-01-30 20:16:09'),
(81, 2, 37, NULL, 0, 0, 0, 0, '2026-01-30 20:16:09', '2026-01-30 20:16:09'),
(82, 2, 38, NULL, 0, 0, 0, 0, '2026-01-30 20:16:09', '2026-01-30 20:16:09'),
(83, 2, 39, NULL, 0, 0, 0, 0, '2026-01-30 20:16:09', '2026-01-30 20:16:09'),
(84, 2, 40, NULL, 0, 0, 0, 0, '2026-01-30 20:16:09', '2026-01-30 20:16:09'),
(85, 2, 41, NULL, 0, 0, 0, 0, '2026-01-30 20:16:09', '2026-01-30 20:16:09'),
(86, 2, 42, NULL, 0, 0, 0, 0, '2026-01-30 20:16:09', '2026-01-30 20:16:09'),
(87, 2, 43, NULL, 0, 0, 0, 0, '2026-01-30 20:16:09', '2026-01-30 20:16:09'),
(88, 2, 44, NULL, 0, 0, 0, 0, '2026-01-30 20:16:09', '2026-01-30 20:16:09'),
(89, 3, 1, NULL, 0, 0, 0, 0, '2026-02-10 18:21:45', '2026-02-10 18:21:45'),
(90, 3, 2, NULL, 0, 0, 0, 0, '2026-02-10 18:21:45', '2026-02-10 18:21:45'),
(91, 3, 3, NULL, 0, 0, 0, 0, '2026-02-10 18:21:45', '2026-02-10 18:21:45'),
(92, 3, 4, NULL, 0, 0, 0, 0, '2026-02-10 18:21:45', '2026-02-10 18:21:45'),
(93, 3, 5, NULL, 0, 0, 0, 0, '2026-02-10 18:21:45', '2026-02-10 18:21:45'),
(94, 3, 6, NULL, 0, 0, 0, 0, '2026-02-10 18:21:45', '2026-02-10 18:21:45'),
(95, 3, 7, NULL, 0, 0, 0, 0, '2026-02-10 18:21:45', '2026-02-10 18:21:45'),
(96, 3, 8, NULL, 0, 0, 0, 0, '2026-02-10 18:21:45', '2026-02-10 18:21:45'),
(97, 3, 9, NULL, 0, 0, 0, 0, '2026-02-10 18:21:45', '2026-02-10 18:21:45'),
(98, 3, 10, NULL, 0, 0, 0, 0, '2026-02-10 18:21:45', '2026-02-10 18:21:45'),
(99, 3, 11, NULL, 0, 0, 0, 0, '2026-02-10 18:21:45', '2026-02-10 18:21:45'),
(100, 3, 12, NULL, 0, 0, 0, 0, '2026-02-10 18:21:46', '2026-02-10 18:21:46'),
(101, 3, 13, NULL, 0, 0, 0, 0, '2026-02-10 18:21:46', '2026-02-10 18:21:46'),
(102, 3, 14, NULL, 0, 0, 0, 0, '2026-02-10 18:21:46', '2026-02-10 18:21:46'),
(103, 3, 15, NULL, 0, 0, 0, 0, '2026-02-10 18:21:46', '2026-02-10 18:21:46'),
(104, 3, 16, NULL, 0, 0, 0, 0, '2026-02-10 18:21:46', '2026-02-10 18:21:46'),
(105, 3, 17, NULL, 0, 0, 0, 0, '2026-02-10 18:21:46', '2026-02-10 18:21:46'),
(106, 3, 18, NULL, 0, 0, 0, 0, '2026-02-10 18:21:46', '2026-02-10 18:21:46'),
(107, 3, 19, NULL, 0, 0, 0, 0, '2026-02-10 18:21:46', '2026-02-10 18:21:46'),
(108, 3, 20, NULL, 0, 0, 0, 0, '2026-02-10 18:21:46', '2026-02-10 18:21:46'),
(109, 3, 21, NULL, 0, 0, 0, 0, '2026-02-10 18:21:46', '2026-02-10 18:21:46'),
(110, 3, 22, NULL, 0, 0, 0, 0, '2026-02-10 18:21:46', '2026-02-10 18:21:46'),
(111, 3, 23, NULL, 0, 0, 0, 0, '2026-02-10 18:21:46', '2026-02-10 18:21:46'),
(112, 3, 24, NULL, 0, 0, 0, 0, '2026-02-10 18:21:46', '2026-02-10 18:21:46'),
(113, 3, 25, NULL, 0, 0, 0, 0, '2026-02-10 18:21:46', '2026-02-10 18:21:46'),
(114, 3, 26, NULL, 0, 0, 0, 0, '2026-02-10 18:21:46', '2026-02-10 18:21:46'),
(115, 3, 27, NULL, 0, 0, 0, 0, '2026-02-10 18:21:46', '2026-02-10 18:21:46'),
(116, 3, 28, NULL, 0, 0, 0, 0, '2026-02-10 18:21:46', '2026-02-10 18:21:46'),
(117, 3, 29, NULL, 0, 0, 0, 0, '2026-02-10 18:21:46', '2026-02-10 18:21:46'),
(118, 3, 30, NULL, 0, 0, 0, 0, '2026-02-10 18:21:46', '2026-02-10 18:21:46'),
(119, 3, 31, NULL, 0, 0, 0, 0, '2026-02-10 18:21:46', '2026-02-10 18:21:46'),
(120, 3, 32, NULL, 0, 0, 0, 0, '2026-02-10 18:21:46', '2026-02-10 18:21:46'),
(121, 3, 33, NULL, 0, 0, 0, 0, '2026-02-10 18:21:46', '2026-02-10 18:21:46'),
(122, 3, 34, NULL, 0, 0, 0, 0, '2026-02-10 18:21:46', '2026-02-10 18:21:46'),
(123, 3, 35, NULL, 0, 0, 0, 0, '2026-02-10 18:21:46', '2026-02-10 18:21:46'),
(124, 3, 36, NULL, 0, 0, 0, 0, '2026-02-10 18:21:47', '2026-02-10 18:21:47'),
(125, 3, 37, NULL, 0, 0, 0, 0, '2026-02-10 18:21:47', '2026-02-10 18:21:47'),
(126, 3, 38, NULL, 0, 0, 0, 0, '2026-02-10 18:21:47', '2026-02-10 18:21:47'),
(127, 3, 39, NULL, 0, 0, 0, 0, '2026-02-10 18:21:47', '2026-02-10 18:21:47'),
(128, 3, 40, NULL, 0, 0, 0, 0, '2026-02-10 18:21:47', '2026-02-10 18:21:47'),
(129, 3, 41, NULL, 0, 0, 0, 0, '2026-02-10 18:21:47', '2026-02-10 18:21:47'),
(130, 3, 42, NULL, 0, 0, 0, 0, '2026-02-10 18:21:47', '2026-02-10 18:21:47'),
(131, 3, 43, NULL, 0, 0, 0, 0, '2026-02-10 18:21:47', '2026-02-10 18:21:47'),
(132, 3, 44, NULL, 0, 0, 0, 0, '2026-02-10 18:21:47', '2026-02-10 18:21:47'),
(133, 3, 45, NULL, 0, 0, 0, 0, '2026-02-10 18:21:47', '2026-02-10 18:21:47'),
(134, 3, 46, NULL, 0, 0, 0, 0, '2026-02-10 18:21:47', '2026-02-10 18:21:47'),
(135, 3, 47, NULL, 0, 0, 0, 0, '2026-02-10 18:21:47', '2026-02-10 18:21:47'),
(136, 3, 48, NULL, 0, 0, 0, 0, '2026-02-10 18:21:47', '2026-02-10 18:21:47'),
(137, 3, 49, NULL, 0, 0, 0, 0, '2026-02-10 18:21:47', '2026-02-10 18:21:47'),
(138, 3, 50, NULL, 0, 0, 0, 0, '2026-02-10 18:21:47', '2026-02-10 18:21:47'),
(139, 4, 1, NULL, 0, 0, 0, 0, '2026-02-10 18:26:24', '2026-02-10 18:26:24'),
(140, 4, 2, NULL, 0, 0, 0, 0, '2026-02-10 18:26:24', '2026-02-10 18:26:24'),
(141, 4, 3, NULL, 0, 0, 0, 0, '2026-02-10 18:26:24', '2026-02-10 18:26:24'),
(142, 4, 4, NULL, 0, 0, 0, 0, '2026-02-10 18:26:24', '2026-02-10 18:26:24'),
(143, 4, 5, NULL, 0, 0, 0, 0, '2026-02-10 18:26:24', '2026-02-10 18:26:24'),
(144, 4, 6, NULL, 0, 0, 0, 0, '2026-02-10 18:26:24', '2026-02-10 18:26:24'),
(145, 4, 7, NULL, 0, 0, 0, 0, '2026-02-10 18:26:24', '2026-02-10 18:26:24'),
(146, 4, 8, NULL, 0, 0, 0, 0, '2026-02-10 18:26:24', '2026-02-10 18:26:24'),
(147, 4, 9, NULL, 0, 0, 0, 0, '2026-02-10 18:26:25', '2026-02-10 18:26:25'),
(148, 4, 10, NULL, 0, 0, 0, 0, '2026-02-10 18:26:25', '2026-02-10 18:26:25'),
(149, 4, 11, NULL, 0, 0, 0, 0, '2026-02-10 18:26:25', '2026-02-10 18:26:25'),
(150, 4, 12, NULL, 0, 0, 0, 0, '2026-02-10 18:26:25', '2026-02-10 18:26:25'),
(151, 4, 13, NULL, 0, 0, 0, 0, '2026-02-10 18:26:25', '2026-02-10 18:26:25'),
(152, 4, 14, NULL, 0, 0, 0, 0, '2026-02-10 18:26:25', '2026-02-10 18:26:25'),
(153, 4, 15, NULL, 0, 0, 0, 0, '2026-02-10 18:26:25', '2026-02-10 18:26:25'),
(154, 4, 16, NULL, 0, 0, 0, 0, '2026-02-10 18:26:25', '2026-02-10 18:26:25'),
(155, 4, 17, NULL, 0, 0, 0, 0, '2026-02-10 18:26:25', '2026-02-10 18:26:25'),
(156, 4, 18, NULL, 0, 0, 0, 0, '2026-02-10 18:26:25', '2026-02-10 18:26:25'),
(157, 4, 19, NULL, 0, 0, 0, 0, '2026-02-10 18:26:25', '2026-02-10 18:26:25'),
(158, 4, 20, NULL, 0, 0, 0, 0, '2026-02-10 18:26:25', '2026-02-10 18:26:25'),
(159, 4, 21, NULL, 0, 0, 0, 0, '2026-02-10 18:26:25', '2026-02-10 18:26:25'),
(160, 4, 22, NULL, 0, 0, 0, 0, '2026-02-10 18:26:25', '2026-02-10 18:26:25'),
(161, 4, 23, NULL, 0, 0, 0, 0, '2026-02-10 18:26:25', '2026-02-10 18:26:25'),
(162, 4, 24, NULL, 0, 0, 0, 0, '2026-02-10 18:26:25', '2026-02-10 18:26:25'),
(163, 4, 25, NULL, 0, 0, 0, 0, '2026-02-10 18:26:25', '2026-02-10 18:26:25'),
(164, 4, 26, NULL, 0, 0, 0, 0, '2026-02-10 18:26:25', '2026-02-10 18:26:25'),
(165, 4, 27, NULL, 0, 0, 0, 0, '2026-02-10 18:26:25', '2026-02-10 18:26:25'),
(166, 4, 28, NULL, 0, 0, 0, 0, '2026-02-10 18:26:25', '2026-02-10 18:26:25'),
(167, 4, 29, NULL, 0, 0, 0, 0, '2026-02-10 18:26:25', '2026-02-10 18:26:25'),
(168, 4, 30, NULL, 0, 0, 0, 0, '2026-02-10 18:26:25', '2026-02-10 18:26:25'),
(169, 4, 31, NULL, 0, 0, 0, 0, '2026-02-10 18:26:25', '2026-02-10 18:26:25'),
(170, 4, 32, NULL, 0, 0, 0, 0, '2026-02-10 18:26:25', '2026-02-10 18:26:25'),
(171, 4, 33, NULL, 0, 0, 0, 0, '2026-02-10 18:26:25', '2026-02-10 18:26:25'),
(172, 4, 34, NULL, 0, 0, 0, 0, '2026-02-10 18:26:26', '2026-02-10 18:26:26'),
(173, 4, 35, NULL, 0, 0, 0, 0, '2026-02-10 18:26:26', '2026-02-10 18:26:26'),
(174, 4, 36, NULL, 0, 0, 0, 0, '2026-02-10 18:26:26', '2026-02-10 18:26:26'),
(175, 4, 37, NULL, 0, 0, 0, 0, '2026-02-10 18:26:26', '2026-02-10 18:26:26'),
(176, 4, 38, NULL, 0, 0, 0, 0, '2026-02-10 18:26:26', '2026-02-10 18:26:26'),
(177, 4, 39, NULL, 0, 0, 0, 0, '2026-02-10 18:26:26', '2026-02-10 18:26:26'),
(178, 4, 40, NULL, 0, 0, 0, 0, '2026-02-10 18:26:26', '2026-02-10 18:26:26'),
(179, 4, 41, NULL, 0, 0, 0, 0, '2026-02-10 18:26:26', '2026-02-10 18:26:26'),
(180, 4, 42, NULL, 0, 0, 0, 0, '2026-02-10 18:26:26', '2026-02-10 18:26:26'),
(181, 4, 43, NULL, 0, 0, 0, 0, '2026-02-10 18:26:26', '2026-02-10 18:26:26'),
(182, 4, 44, NULL, 0, 0, 0, 0, '2026-02-10 18:26:26', '2026-02-10 18:26:26'),
(183, 4, 45, NULL, 0, 0, 0, 0, '2026-02-10 18:26:26', '2026-02-10 18:26:26'),
(184, 4, 46, NULL, 0, 0, 0, 0, '2026-02-10 18:26:26', '2026-02-10 18:26:26'),
(185, 4, 47, NULL, 0, 0, 0, 0, '2026-02-10 18:26:26', '2026-02-10 18:26:26'),
(186, 4, 48, NULL, 0, 0, 0, 0, '2026-02-10 18:26:26', '2026-02-10 18:26:26'),
(187, 4, 49, NULL, 0, 0, 0, 0, '2026-02-10 18:26:26', '2026-02-10 18:26:26'),
(188, 4, 50, NULL, 0, 0, 0, 0, '2026-02-10 18:26:26', '2026-02-10 18:26:26'),
(189, 5, 1, NULL, 0, 0, 0, 0, '2026-02-10 18:30:19', '2026-02-10 18:30:19'),
(190, 5, 2, NULL, 0, 0, 0, 0, '2026-02-10 18:30:19', '2026-02-10 18:30:19'),
(191, 5, 3, NULL, 0, 0, 0, 0, '2026-02-10 18:30:19', '2026-02-10 18:30:19'),
(192, 5, 4, NULL, 0, 0, 0, 0, '2026-02-10 18:30:19', '2026-02-10 18:30:19'),
(193, 5, 5, NULL, 0, 0, 0, 0, '2026-02-10 18:30:19', '2026-02-10 18:30:19'),
(194, 5, 6, NULL, 0, 0, 0, 0, '2026-02-10 18:30:19', '2026-02-10 18:30:19'),
(195, 5, 7, NULL, 0, 0, 0, 0, '2026-02-10 18:30:19', '2026-02-10 18:30:19'),
(196, 5, 8, NULL, 0, 0, 0, 0, '2026-02-10 18:30:19', '2026-02-10 18:30:19'),
(197, 5, 9, NULL, 0, 0, 0, 0, '2026-02-10 18:30:19', '2026-02-10 18:30:19'),
(198, 5, 10, NULL, 0, 0, 0, 0, '2026-02-10 18:30:19', '2026-02-10 18:30:19'),
(199, 5, 11, NULL, 0, 0, 0, 0, '2026-02-10 18:30:19', '2026-02-10 18:30:19'),
(200, 5, 12, NULL, 0, 0, 0, 0, '2026-02-10 18:30:19', '2026-02-10 18:30:19'),
(201, 5, 13, NULL, 0, 0, 0, 0, '2026-02-10 18:30:19', '2026-02-10 18:30:19'),
(202, 5, 14, NULL, 0, 0, 0, 0, '2026-02-10 18:30:19', '2026-02-10 18:30:19'),
(203, 5, 15, NULL, 0, 0, 0, 0, '2026-02-10 18:30:19', '2026-02-10 18:30:19'),
(204, 5, 16, NULL, 0, 0, 0, 0, '2026-02-10 18:30:19', '2026-02-10 18:30:19'),
(205, 5, 17, NULL, 0, 0, 0, 0, '2026-02-10 18:30:19', '2026-02-10 18:30:19'),
(206, 5, 18, NULL, 0, 0, 0, 0, '2026-02-10 18:30:19', '2026-02-10 18:30:19'),
(207, 5, 19, NULL, 0, 0, 0, 0, '2026-02-10 18:30:19', '2026-02-10 18:30:19'),
(208, 5, 20, NULL, 0, 0, 0, 0, '2026-02-10 18:30:19', '2026-02-10 18:30:19'),
(209, 5, 21, NULL, 0, 0, 0, 0, '2026-02-10 18:30:20', '2026-02-10 18:30:20'),
(210, 5, 22, NULL, 0, 0, 0, 0, '2026-02-10 18:30:20', '2026-02-10 18:30:20'),
(211, 5, 23, NULL, 0, 0, 0, 0, '2026-02-10 18:30:20', '2026-02-10 18:30:20'),
(212, 5, 24, NULL, 0, 0, 0, 0, '2026-02-10 18:30:20', '2026-02-10 18:30:20'),
(213, 5, 25, NULL, 0, 0, 0, 0, '2026-02-10 18:30:20', '2026-02-10 18:30:20'),
(214, 5, 26, NULL, 0, 0, 0, 0, '2026-02-10 18:30:20', '2026-02-10 18:30:20'),
(215, 5, 27, NULL, 0, 0, 0, 0, '2026-02-10 18:30:20', '2026-02-10 18:30:20'),
(216, 5, 28, NULL, 0, 0, 0, 0, '2026-02-10 18:30:20', '2026-02-10 18:30:20'),
(217, 5, 29, NULL, 0, 0, 0, 0, '2026-02-10 18:30:20', '2026-02-10 18:30:20'),
(218, 5, 30, NULL, 0, 0, 0, 0, '2026-02-10 18:30:20', '2026-02-10 18:30:20'),
(219, 5, 31, NULL, 0, 0, 0, 0, '2026-02-10 18:30:20', '2026-02-10 18:30:20'),
(220, 5, 32, NULL, 0, 0, 0, 0, '2026-02-10 18:30:20', '2026-02-10 18:30:20'),
(221, 5, 33, NULL, 0, 0, 0, 0, '2026-02-10 18:30:20', '2026-02-10 18:30:20'),
(222, 5, 34, NULL, 0, 0, 0, 0, '2026-02-10 18:30:20', '2026-02-10 18:30:20'),
(223, 5, 35, NULL, 0, 0, 0, 0, '2026-02-10 18:30:20', '2026-02-10 18:30:20'),
(224, 5, 36, NULL, 0, 0, 0, 0, '2026-02-10 18:30:20', '2026-02-10 18:30:20'),
(225, 5, 37, NULL, 0, 0, 0, 0, '2026-02-10 18:30:20', '2026-02-10 18:30:20'),
(226, 5, 38, NULL, 0, 0, 0, 0, '2026-02-10 18:30:20', '2026-02-10 18:30:20'),
(227, 5, 39, NULL, 0, 0, 0, 0, '2026-02-10 18:30:20', '2026-02-10 18:30:20'),
(228, 5, 40, NULL, 0, 0, 0, 0, '2026-02-10 18:30:20', '2026-02-10 18:30:20'),
(229, 5, 41, NULL, 0, 0, 0, 0, '2026-02-10 18:30:20', '2026-02-10 18:30:20'),
(230, 5, 42, NULL, 0, 0, 0, 0, '2026-02-10 18:30:20', '2026-02-10 18:30:20'),
(231, 5, 43, NULL, 0, 0, 0, 0, '2026-02-10 18:30:20', '2026-02-10 18:30:20'),
(232, 5, 44, NULL, 0, 0, 0, 0, '2026-02-10 18:30:20', '2026-02-10 18:30:20'),
(233, 5, 45, NULL, 0, 0, 0, 0, '2026-02-10 18:30:21', '2026-02-10 18:30:21'),
(234, 5, 46, NULL, 0, 0, 0, 0, '2026-02-10 18:30:21', '2026-02-10 18:30:21'),
(235, 5, 47, NULL, 0, 0, 0, 0, '2026-02-10 18:30:21', '2026-02-10 18:30:21'),
(236, 5, 48, NULL, 0, 0, 0, 0, '2026-02-10 18:30:21', '2026-02-10 18:30:21'),
(237, 5, 49, NULL, 0, 0, 0, 0, '2026-02-10 18:30:21', '2026-02-10 18:30:21'),
(238, 5, 50, NULL, 0, 0, 0, 0, '2026-02-10 18:30:21', '2026-02-10 18:30:21'),
(239, 5, 1, NULL, 0, 0, 0, 0, '2026-02-10 18:32:03', '2026-02-10 18:32:03'),
(240, 5, 2, NULL, 0, 0, 0, 0, '2026-02-10 18:32:03', '2026-02-10 18:32:03'),
(241, 5, 3, NULL, 0, 0, 0, 0, '2026-02-10 18:32:03', '2026-02-10 18:32:03'),
(242, 5, 4, NULL, 0, 0, 0, 0, '2026-02-10 18:32:03', '2026-02-10 18:32:03'),
(243, 5, 5, NULL, 0, 0, 0, 0, '2026-02-10 18:32:03', '2026-02-10 18:32:03'),
(244, 5, 6, NULL, 0, 0, 0, 0, '2026-02-10 18:32:03', '2026-02-10 18:32:03'),
(245, 5, 7, NULL, 0, 0, 0, 0, '2026-02-10 18:32:03', '2026-02-10 18:32:03'),
(246, 5, 8, NULL, 0, 0, 0, 0, '2026-02-10 18:32:03', '2026-02-10 18:32:03'),
(247, 5, 9, NULL, 0, 0, 0, 0, '2026-02-10 18:32:03', '2026-02-10 18:32:03'),
(248, 5, 10, NULL, 0, 0, 0, 0, '2026-02-10 18:32:03', '2026-02-10 18:32:03'),
(249, 5, 11, NULL, 0, 0, 0, 0, '2026-02-10 18:32:03', '2026-02-10 18:32:03'),
(250, 5, 12, NULL, 0, 0, 0, 0, '2026-02-10 18:32:03', '2026-02-10 18:32:03'),
(251, 5, 13, NULL, 0, 0, 0, 0, '2026-02-10 18:32:03', '2026-02-10 18:32:03'),
(252, 5, 14, NULL, 0, 0, 0, 0, '2026-02-10 18:32:03', '2026-02-10 18:32:03'),
(253, 5, 15, NULL, 0, 0, 0, 0, '2026-02-10 18:32:03', '2026-02-10 18:32:03'),
(254, 5, 16, NULL, 0, 0, 0, 0, '2026-02-10 18:32:03', '2026-02-10 18:32:03'),
(255, 5, 17, NULL, 0, 0, 0, 0, '2026-02-10 18:32:03', '2026-02-10 18:32:03'),
(256, 5, 18, NULL, 0, 0, 0, 0, '2026-02-10 18:32:03', '2026-02-10 18:32:03'),
(257, 5, 19, NULL, 0, 0, 0, 0, '2026-02-10 18:32:03', '2026-02-10 18:32:03'),
(258, 5, 20, NULL, 0, 0, 0, 0, '2026-02-10 18:32:03', '2026-02-10 18:32:03'),
(259, 5, 21, NULL, 0, 0, 0, 0, '2026-02-10 18:32:03', '2026-02-10 18:32:03'),
(260, 5, 22, NULL, 0, 0, 0, 0, '2026-02-10 18:32:03', '2026-02-10 18:32:03'),
(261, 5, 23, NULL, 0, 0, 0, 0, '2026-02-10 18:32:03', '2026-02-10 18:32:03'),
(262, 5, 24, NULL, 0, 0, 0, 0, '2026-02-10 18:32:03', '2026-02-10 18:32:03'),
(263, 5, 25, NULL, 0, 0, 0, 0, '2026-02-10 18:32:04', '2026-02-10 18:32:04'),
(264, 5, 26, NULL, 0, 0, 0, 0, '2026-02-10 18:32:04', '2026-02-10 18:32:04'),
(265, 5, 27, NULL, 0, 0, 0, 0, '2026-02-10 18:32:04', '2026-02-10 18:32:04'),
(266, 5, 28, NULL, 0, 0, 0, 0, '2026-02-10 18:32:04', '2026-02-10 18:32:04'),
(267, 5, 29, NULL, 0, 0, 0, 0, '2026-02-10 18:32:04', '2026-02-10 18:32:04'),
(268, 5, 30, NULL, 0, 0, 0, 0, '2026-02-10 18:32:04', '2026-02-10 18:32:04'),
(269, 5, 31, NULL, 0, 0, 0, 0, '2026-02-10 18:32:04', '2026-02-10 18:32:04'),
(270, 5, 32, NULL, 0, 0, 0, 0, '2026-02-10 18:32:04', '2026-02-10 18:32:04'),
(271, 5, 33, NULL, 0, 0, 0, 0, '2026-02-10 18:32:04', '2026-02-10 18:32:04'),
(272, 5, 34, NULL, 0, 0, 0, 0, '2026-02-10 18:32:04', '2026-02-10 18:32:04'),
(273, 5, 35, NULL, 0, 0, 0, 0, '2026-02-10 18:32:04', '2026-02-10 18:32:04'),
(274, 5, 36, NULL, 0, 0, 0, 0, '2026-02-10 18:32:04', '2026-02-10 18:32:04'),
(275, 5, 37, NULL, 0, 0, 0, 0, '2026-02-10 18:32:04', '2026-02-10 18:32:04'),
(276, 5, 38, NULL, 0, 0, 0, 0, '2026-02-10 18:32:04', '2026-02-10 18:32:04'),
(277, 5, 39, NULL, 0, 0, 0, 0, '2026-02-10 18:32:04', '2026-02-10 18:32:04'),
(278, 5, 40, NULL, 0, 0, 0, 0, '2026-02-10 18:32:04', '2026-02-10 18:32:04'),
(279, 5, 41, NULL, 0, 0, 0, 0, '2026-02-10 18:32:04', '2026-02-10 18:32:04'),
(280, 5, 42, NULL, 0, 0, 0, 0, '2026-02-10 18:32:04', '2026-02-10 18:32:04'),
(281, 5, 43, NULL, 0, 0, 0, 0, '2026-02-10 18:32:04', '2026-02-10 18:32:04'),
(282, 5, 44, NULL, 0, 0, 0, 0, '2026-02-10 18:32:04', '2026-02-10 18:32:04'),
(283, 5, 45, NULL, 0, 0, 0, 0, '2026-02-10 18:32:04', '2026-02-10 18:32:04'),
(284, 5, 46, NULL, 0, 0, 0, 0, '2026-02-10 18:32:04', '2026-02-10 18:32:04'),
(285, 5, 47, NULL, 0, 0, 0, 0, '2026-02-10 18:32:04', '2026-02-10 18:32:04'),
(286, 5, 48, NULL, 0, 0, 0, 0, '2026-02-10 18:32:04', '2026-02-10 18:32:04'),
(287, 5, 49, NULL, 0, 0, 0, 0, '2026-02-10 18:32:05', '2026-02-10 18:32:05'),
(288, 5, 50, NULL, 0, 0, 0, 0, '2026-02-10 18:32:05', '2026-02-10 18:32:05');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `trampa_seguimientos`
--

CREATE TABLE `trampa_seguimientos` (
  `id` bigint UNSIGNED NOT NULL,
  `almacen_id` bigint UNSIGNED NOT NULL,
  `mapa_id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `observaciones` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `trampa_tipos`
--

CREATE TABLE `trampa_tipos` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `imagen` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `trampa_tipos`
--

INSERT INTO `trampa_tipos` (`id`, `nombre`, `imagen`, `created_at`, `updated_at`) VALUES
(1, 'golpe', '/images/trampas/trampa_raton.jpg', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(2, 'insecto', '/images/trampas/trampa_insecto.jpg', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(3, 'caja', '/images/trampas/caja_negra.jpg', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(4, 'viva', '/images/trampas/captura_viva.jpg', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(5, 'pegajosa', '/images/trampas/pegajosa.png', '2026-01-30 17:28:01', '2026-01-30 17:28:01');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `unidades`
--

CREATE TABLE `unidades` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `unidades`
--

INSERT INTO `unidades` (`id`, `nombre`, `created_at`, `updated_at`) VALUES
(1, 'Gramos', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(2, 'C.C.', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(3, 'Unidad', '2026-01-30 17:28:01', '2026-01-30 17:28:01'),
(4, 'Litros', '2026-01-30 17:28:01', '2026-01-30 17:28:01');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `two_factor_secret` text COLLATE utf8mb4_unicode_ci,
  `two_factor_recovery_codes` text COLLATE utf8mb4_unicode_ci,
  `two_factor_confirmed_at` timestamp NULL DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `two_factor_secret`, `two_factor_recovery_codes`, `two_factor_confirmed_at`, `remember_token`, `created_at`, `updated_at`) VALUES
(2, 'FREDDY', 'admin@admin.com', NULL, '$2y$12$InosZxlgqNtcJ0mH6NXb5uSC4THhSWntYYJXqkrru.Fgw4YHqQg8m', NULL, NULL, NULL, '4euEH7q8AEGkTrSEQg8G64frjuPqNF09N6YbBm3zplFOgtEXCJZBojACzdPr', '2026-01-30 17:30:55', '2026-02-10 20:36:14'),
(3, 'jessica', 'jotamontero.fm@gmail.com', NULL, '$2y$12$JVsOd48eOGe36yd1LBlo0OG0YkvP5HrAmipiDOUsLLdIdMORYK8Pu', NULL, NULL, NULL, NULL, '2026-01-30 20:29:38', '2026-02-10 20:49:56');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_empresas`
--

CREATE TABLE `usuario_empresas` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `empresa_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `cliente_id` bigint UNSIGNED DEFAULT NULL,
  `total` double NOT NULL,
  `tipo` enum('Venta','Pago','Adelanto','Anulado') COLLATE utf8mb4_unicode_ci NOT NULL,
  `metodo` enum('Efectivo','QR','Transferencia') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta_detalles`
--

CREATE TABLE `venta_detalles` (
  `id` bigint UNSIGNED NOT NULL,
  `venta_id` bigint UNSIGNED NOT NULL,
  `producto_id` bigint UNSIGNED DEFAULT NULL,
  `precio_venta` double NOT NULL,
  `cantidad` int NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Índices para tablas volcadas
--

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
  ADD KEY `cronogramas_almacen_id_foreign` (`almacen_id`),
  ADD KEY `cronogramas_user_id_foreign` (`user_id`),
  ADD KEY `cronogramas_tecnico_id_foreign` (`tecnico_id`);

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
  ADD KEY `seguimientos_contacto_id_foreign` (`contacto_id`);

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
-- AUTO_INCREMENT de la tabla `agendas`
--
ALTER TABLE `agendas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=80;

--
-- AUTO_INCREMENT de la tabla `almacenes`
--
ALTER TABLE `almacenes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `almacen_areas`
--
ALTER TABLE `almacen_areas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `almacen_trampas`
--
ALTER TABLE `almacen_trampas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `almancen_insectocutores`
--
ALTER TABLE `almancen_insectocutores`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `aplicaciones`
--
ALTER TABLE `aplicaciones`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `biologicos`
--
ALTER TABLE `biologicos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `certificados`
--
ALTER TABLE `certificados`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cobrar_cuotas`
--
ALTER TABLE `cobrar_cuotas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cobrar_pagos`
--
ALTER TABLE `cobrar_pagos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `compras`
--
ALTER TABLE `compras`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `compra_detalles`
--
ALTER TABLE `compra_detalles`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `contactos`
--
ALTER TABLE `contactos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `contratos`
--
ALTER TABLE `contratos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `contrato_detalles`
--
ALTER TABLE `contrato_detalles`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `cotizaciones`
--
ALTER TABLE `cotizaciones`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cotizacion_detalles`
--
ALTER TABLE `cotizacion_detalles`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cronogramas`
--
ALTER TABLE `cronogramas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT de la tabla `cuentas_cobrar`
--
ALTER TABLE `cuentas_cobrar`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `cuentas_pagar`
--
ALTER TABLE `cuentas_pagar`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cuenta_extras`
--
ALTER TABLE `cuenta_extras`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `cuenta_financieros`
--
ALTER TABLE `cuenta_financieros`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `cuenta_operativos`
--
ALTER TABLE `cuenta_operativos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `documentos`
--
ALTER TABLE `documentos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `empresas`
--
ALTER TABLE `empresas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `epps`
--
ALTER TABLE `epps`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `especies`
--
ALTER TABLE `especies`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `estado_extras`
--
ALTER TABLE `estado_extras`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `estado_financieros`
--
ALTER TABLE `estado_financieros`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `estado_operativos`
--
ALTER TABLE `estado_operativos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `estado_resultados`
--
ALTER TABLE `estado_resultados`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `etiquetas`
--
ALTER TABLE `etiquetas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `etiqueta_productos`
--
ALTER TABLE `etiqueta_productos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `gastos`
--
ALTER TABLE `gastos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `gasto_extras`
--
ALTER TABLE `gasto_extras`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `gasto_financieros`
--
ALTER TABLE `gasto_financieros`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `gasto_operativos`
--
ALTER TABLE `gasto_operativos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `hoja_tecnicas`
--
ALTER TABLE `hoja_tecnicas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `ingresos`
--
ALTER TABLE `ingresos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `insectocutores`
--
ALTER TABLE `insectocutores`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `kardexes`
--
ALTER TABLE `kardexes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `mapas`
--
ALTER TABLE `mapas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `mapa_revisiones`
--
ALTER TABLE `mapa_revisiones`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `marcas`
--
ALTER TABLE `marcas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `metodos`
--
ALTER TABLE `metodos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=82;

--
-- AUTO_INCREMENT de la tabla `pagar_cuotas`
--
ALTER TABLE `pagar_cuotas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pagar_pagos`
--
ALTER TABLE `pagar_pagos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `producto_usos`
--
ALTER TABLE `producto_usos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `producto_vencimientos`
--
ALTER TABLE `producto_vencimientos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `protecciones`
--
ALTER TABLE `protecciones`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `retiros`
--
ALTER TABLE `retiros`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `seguimientos`
--
ALTER TABLE `seguimientos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `seguimiento_biologicos`
--
ALTER TABLE `seguimiento_biologicos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `seguimiento_epps`
--
ALTER TABLE `seguimiento_epps`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de la tabla `seguimiento_especies`
--
ALTER TABLE `seguimiento_especies`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `seguimiento_images`
--
ALTER TABLE `seguimiento_images`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `seguimiento_metodos`
--
ALTER TABLE `seguimiento_metodos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `seguimiento_protecciones`
--
ALTER TABLE `seguimiento_protecciones`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `seguimiento_signos`
--
ALTER TABLE `seguimiento_signos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `signos`
--
ALTER TABLE `signos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `subcategorias`
--
ALTER TABLE `subcategorias`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tipo_seguimientos`
--
ALTER TABLE `tipo_seguimientos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `trampas`
--
ALTER TABLE `trampas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT de la tabla `trampa_especie_seguimientos`
--
ALTER TABLE `trampa_especie_seguimientos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `trampa_roedor_seguimientos`
--
ALTER TABLE `trampa_roedor_seguimientos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=289;

--
-- AUTO_INCREMENT de la tabla `trampa_seguimientos`
--
ALTER TABLE `trampa_seguimientos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `trampa_tipos`
--
ALTER TABLE `trampa_tipos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `unidades`
--
ALTER TABLE `unidades`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `usuario_empresas`
--
ALTER TABLE `usuario_empresas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `venta_detalles`
--
ALTER TABLE `venta_detalles`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

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
  ADD CONSTRAINT `cronogramas_tecnico_id_foreign` FOREIGN KEY (`tecnico_id`) REFERENCES `users` (`id`),
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
