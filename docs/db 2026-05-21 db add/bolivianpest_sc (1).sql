-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 21-05-2026 a las 09:46:06
-- Versión del servidor: 11.4.11-MariaDB
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
(8, 5, 'EL ALTO', 'Av. LAS AMERICAS', 'ROBERTO CARLOS JULIAN', '70525322', 'mmariscal@quimiza.com', 'CIUDAD DE EL ALTO', '2026-05-09 01:57:04', '2026-05-09 01:57:04');

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
(8, 8, NULL, 500, 2, 1, 1000, '2026-05-09 01:57:04', '2026-05-09 01:57:04');

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
(8, 8, NULL, 17, 6, 29.42, 3000.84, '2026-05-09 01:57:04', '2026-05-09 01:57:04');

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
(8, 8, NULL, 0, 0, 0, 0, '2026-05-09 01:57:04', '2026-05-09 01:57:04');

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
(51, 51, 0, 0, 0, 0, 0, 0, 0, 0, '2026-05-19 20:33:30', '2026-05-19 20:33:30');

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
(2, 2, 27, '2026-05-04 12:05:30', '2026-05-19 00:04:18'),
(3, 1, 2, '2026-05-19 19:50:31', '2026-05-19 19:54:03');

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
('bolivianpest-cache-81a3e17d9fa37e1a480d1619dea2d550', 'i:1;', 1777821178),
('bolivianpest-cache-81a3e17d9fa37e1a480d1619dea2d550:timer', 'i:1777821178;', 1777821178),
('bolivianpest-cache-90e12e0258da157788c159128647fd4b', 'i:1;', 1779145229),
('bolivianpest-cache-90e12e0258da157788c159128647fd4b:timer', 'i:1779145229;', 1779145229),
('bolivianpest-cache-9acdf23a7a091a3118d8f0841f528405', 'i:1;', 1778687574),
('bolivianpest-cache-9acdf23a7a091a3118d8f0841f528405:timer', 'i:1778687574;', 1778687574),
('bolivianpest-cache-adim@adim.com|177.222.112.216', 'i:1;', 1777636406),
('bolivianpest-cache-adim@adim.com|177.222.112.216:timer', 'i:1777636406;', 1777636406),
('bolivianpest-cache-adim@admin.com|177.222.112.216', 'i:3;', 1778293833),
('bolivianpest-cache-adim@admin.com|177.222.112.216:timer', 'i:1778293833;', 1778293833),
('bolivianpest-cache-b5dae317c839e904812ac4263a1a9c46', 'i:1;', 1778508404),
('bolivianpest-cache-b5dae317c839e904812ac4263a1a9c46:timer', 'i:1778508404;', 1778508404),
('bolivianpest-cache-b973ec5653b4b0c64549a2f4a9211292', 'i:3;', 1778683230),
('bolivianpest-cache-b973ec5653b4b0c64549a2f4a9211292:timer', 'i:1778683230;', 1778683230),
('bolivianpest-cache-bc5b95e361f76d73b548855a530bdbbf', 'i:1;', 1778780650),
('bolivianpest-cache-bc5b95e361f76d73b548855a530bdbbf:timer', 'i:1778780650;', 1778780650),
('bolivianpest-cache-bcda8ba14702a936a86c58ac90357387', 'i:1;', 1778643542),
('bolivianpest-cache-bcda8ba14702a936a86c58ac90357387:timer', 'i:1778643542;', 1778643542),
('bolivianpest-cache-be62b8ecf799c83bba5d54a30e0c7fa9', 'i:1;', 1778194381),
('bolivianpest-cache-be62b8ecf799c83bba5d54a30e0c7fa9:timer', 'i:1778194381;', 1778194381),
('bolivianpest-cache-d053096853369b1a838c2916e56d92b2', 'i:1;', 1778285347),
('bolivianpest-cache-d053096853369b1a838c2916e56d92b2:timer', 'i:1778285347;', 1778285347),
('bolivianpest-cache-d16680ebbc8bd946eaeb663d2196bf9d', 'i:1;', 1779241062),
('bolivianpest-cache-d16680ebbc8bd946eaeb663d2196bf9d:timer', 'i:1779241062;', 1779241062),
('bolivianpest-cache-dc63d5e1a7440c369dd1d5cc2a3dcdbc', 'i:1;', 1778164208),
('bolivianpest-cache-dc63d5e1a7440c369dd1d5cc2a3dcdbc:timer', 'i:1778164208;', 1778164208),
('bolivianpest-cache-ddd190e3923c23efe4505e45a617323a', 'i:1;', 1777937948),
('bolivianpest-cache-ddd190e3923c23efe4505e45a617323a:timer', 'i:1777937948;', 1777937948),
('bolivianpest-cache-de4791e66fedfc050915e664a4eec010', 'i:1;', 1778186834),
('bolivianpest-cache-de4791e66fedfc050915e664a4eec010:timer', 'i:1778186834;', 1778186834),
('bolivianpest-cache-eb6f868bcb9928199794b9c355eaaefb', 'i:1;', 1777689621),
('bolivianpest-cache-eb6f868bcb9928199794b9c355eaaefb:timer', 'i:1777689621;', 1777689621),
('bolivianpest-cache-edd7bead9e3589d46c6853b4d2913d83', 'i:2;', 1778683309),
('bolivianpest-cache-edd7bead9e3589d46c6853b4d2913d83:timer', 'i:1778683309;', 1778683309),
('bolivianpest-cache-f52f3ab1e975682126a5e09c90a0a961', 'i:2;', 1778158171),
('bolivianpest-cache-f52f3ab1e975682126a5e09c90a0a961:timer', 'i:1778158171;', 1778158171),
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
(12, 4, 2, '', '', 'CONTROL DE VECTORES', 'LA CASCADA LTDA', 'EMPRESA ELAORADORA Y COMERCIALIZADORA DE BEBIDAS', '90 DIAS HABILES DEL 04-01-2026 AL 04-04-2026', 'VISCACHANI', 'NO EXISTE PRESENCIA DE VECTORES CONTAMINANTES CONTROL PREVENTIVO', 'CUMPLE CON TODAS LAS CONDICIONES SANITARIAS', 'DESINSECTACION,\r\nDESINFECCION,\r\nDESRATIZACION.', 'INSECTICIDA FENDONA,\r\nDESINFECTANTE HDQ NEUTRAL,\r\nRODENTICIDA KLERAT.', 'INSO: BL1212ILSCO2,\r\nAGEMED 2020/2026,\r\nINSO: BR1020ROAB01.', '5000 M2', 'CONTINUAR CON EL ORDEN Y LIMPIEZA', 'ALFACIPERMETRINA,\r\nAMONIO CUATERNARIO,\r\nBRODIFACOUM.', 'images/certificado/69fa72b260c41_CASCADA IMAGEN.webp', '2026-01-01 03:00:00', '2026-05-05 21:44:02');

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
(5, 5, 4000.84, '2026-12-31', '2026-05-09 01:57:04', '2026-05-09 01:57:04');

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
(8, 5, 'EL ALTO', '17', '6', '29.42', '3000.84', '500', '2', '1', '1000', '0', '0', '0', '0', 0.00, '2026-05-09 01:57:04', '2026-05-09 01:57:04');

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
(438, 2, 4, 2, 2, 1, 'DESRATIZACION', '2026-05-22', 'bg-yellow-500', 'pendiente', '2026-04-29 21:12:18', '2026-04-29 21:12:18'),
(439, 2, 4, 2, 2, 1, 'DESRATIZACION', '2026-06-12', 'bg-yellow-500', 'pendiente', '2026-04-29 21:12:18', '2026-04-29 21:12:18'),
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
(454, 2, 4, 2, 2, 2, 'FUMIGACION', '2026-06-20', 'bg-blue-500', 'pendiente', '2026-04-29 21:12:18', '2026-04-29 21:12:18'),
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
(466, 2, 4, 2, 2, 3, 'INSECTOCUTORES', '2026-05-22', 'bg-pink-600', 'pendiente', '2026-04-29 21:12:18', '2026-04-29 21:12:18'),
(467, 2, 4, 2, 2, 3, 'INSECTOCUTORES', '2026-06-12', 'bg-pink-600', 'pendiente', '2026-04-29 21:12:18', '2026-04-29 21:12:18'),
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
(611, 3, 5, 2, 2, 1, 'DESRATIZACION', '2026-05-21', 'bg-yellow-500', 'pendiente', '2026-04-29 21:14:57', '2026-04-29 21:14:57'),
(612, 3, 5, 2, 2, 1, 'DESRATIZACION', '2026-06-11', 'bg-yellow-500', 'pendiente', '2026-04-29 21:14:57', '2026-04-29 21:14:57'),
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
(881, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-05-21', 'bg-yellow-500', 'pendiente', '2026-05-02 03:04:42', '2026-05-02 03:04:42'),
(882, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-06-11', 'bg-yellow-500', 'pendiente', '2026-05-02 03:04:42', '2026-05-02 03:04:42'),
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
(897, 1, 1, 2, 2, 2, 'FUMIGACION', '2026-06-13', 'bg-blue-500', 'pendiente', '2026-05-02 03:04:42', '2026-05-02 03:04:42'),
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
(909, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-05-21', 'bg-pink-600', 'pendiente', '2026-05-02 03:04:42', '2026-05-02 03:04:42'),
(910, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-06-11', 'bg-pink-600', 'pendiente', '2026-05-02 03:04:42', '2026-05-02 03:04:42'),
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
(939, 5, 8, 2, 2, 2, 'FUMIGACION', '2026-05-09', 'bg-blue-500', 'completado', '2026-05-09 02:03:41', '2026-05-10 18:49:38');

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
(5, NULL, 5, NULL, 2, 'Contrato por cobrar #5', 'Saldo pendiento por cobrar sobre contrato', 4000.84, 4000.84, 'Pendiente', NULL, 0, '2026-05-09 01:57:04', '2026-05-09 01:57:04');

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
(7, 'SEPREC', 'SERVICIO PLURINACIONAL DE REGISTRO DE COMERCIO', 'pdf', 'documents/LxKlmL1LOLX6z9WGwjCUWD6Jp74hnkSiKBO6mezV.pdf', '2026-05-01 16:31:46', '2026-05-01 16:31:46'),
(8, 'LICENCIA AMBIENTAL', 'LASP 1', 'pdf', 'documents/Dml0pcdUCI5jRPiPziKwMd76jSzxHIatYQVVUZim.pdf', '2026-05-01 17:39:36', '2026-05-01 17:39:36'),
(9, 'LICENCIA AMBIENTAL', 'LASP 2', 'pdf', 'documents/ive26hXR8QFV5mLyDdezXK3UICAG8TMsvDiNDScv.pdf', '2026-05-01 17:40:06', '2026-05-01 17:40:06'),
(10, 'LICENCIA AMBIENTAL', 'LASP 3', 'pdf', 'documents/GTXiyJyf7dx6KM8VgJhvJaII5KdI2atf5WdO03aQ.pdf', '2026-05-01 17:40:40', '2026-05-01 17:40:40'),
(11, 'INSO', 'INSTITUTO NACIONAL DE SALUD OCUPACIONAL', 'docx', 'documents/jwUji6TshSpdlQWngqQWn6FWbXGJ1knaj2pbmRO8.docx', '2026-05-01 17:51:26', '2026-05-01 17:51:26');

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
(5, 'QUIMIZA LTDA', 'AV. LAS AMERICAS CIUDAD DE EL ALTO', '76402235', 'mmariscal@quimiza.com', 'LA PAZ', 1, '2026-05-09 01:57:04', '2026-05-09 01:57:04');

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
(38, NULL, NULL, 7, 'Salida', 1, -6, 0, '2026-05-19 20:33:30', '2026-05-19 20:33:30');

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
(8, 5, 8, 2, 'PLANO DE UBICACION DE TRAMPAS', '24', 'images/mapas/8_1778295727.png', '2026-05-09 02:02:07', '2026-05-09 02:06:16');

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
(3, 'App\\Models\\User', 5);

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
(3, NULL, NULL, 4, 'TITANE 5 EC', 'Es un insecticida piretroide de amplio espectro con alta actividad de contacto y residual recomendado para  control de insectos voladores y rastreros', 1, NULL, 5, NULL, NULL, '2026-05-01 20:53:28', '2026-05-01 20:53:28'),
(4, NULL, NULL, 4, 'TITANE DELTA', 'Es un insecticida piretroide a base de deltametrina recomendado para el control de insectos rastreros y voladores la formulacion del producto permite tener un buen efecto inicial y un prolongado efecto residual en las superficies', 1, NULL, 5, NULL, NULL, '2026-05-01 20:56:49', '2026-05-01 20:56:49'),
(5, NULL, NULL, 1, 'RATIMOR', 'Es un cebo rodenticida anticuagulante su ingrediente activo es BROMADIOLONA indicado para realizar control de roedores enespacios exteriores y humedos', 150, 275, 10, 10.00, 15.00, '2026-05-01 20:59:31', '2026-05-03 11:36:30'),
(6, NULL, NULL, 4, 'HDQ NEUTRAL', 'Limpiador desodorante  y desinfectante germicida de uso hospitalario de un solo paso diseñado para la limpieza y desinfeccion de superficies cuyo ingrediente activo es amonio cuaternario', 1, NULL, 5, NULL, NULL, '2026-05-01 21:03:25', '2026-05-01 21:03:25'),
(7, NULL, NULL, 3, 'INSECTOCUTOR', 'CAPTURA DE INSECTOS VOLADORES', 1, -6, 10, NULL, NULL, '2026-05-19 20:06:12', '2026-05-19 20:33:30');

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
(20, 2, 20, 1, 1, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
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
(55, 2, 40, 1, 1, '2026-05-19 21:17:31', '2026-05-19 21:17:31');

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
(17, 1, 1, 3, 1, NULL, 880, 'Rodrigo Velázquez', 'Jefe de planta', NULL, NULL, 'Seguir manteniendo orden y no tratar de obstáculisar las unidades de control de roedores', NULL, '2026-05-07 03:00:00', '2026-05-07 03:00:00'),
(18, 1, 1, 3, 3, NULL, 908, 'Rodrigo Velázquez', 'Jefe de planta', 'images/firmas/firma_encargado_1778187427.png', 'images/firmas/firma_supervisor_1778187427.png', NULL, 'Se realizó la limpieza de los tres equipos', '2026-05-07 03:00:00', '2026-05-07 03:00:00'),
(19, 2, 4, 5, 3, NULL, 465, 'David Foronda Lopez', 'Analista de calidad', 'images/firmas/firma_encargado_1778591038.png', 'images/firmas/firma_supervisor_1778591038.png', NULL, 'Mantener orden y limpieza', '2026-05-08 03:00:00', '2026-05-12 12:03:58'),
(20, 2, 4, 5, 1, NULL, 437, 'David Foronda Lopez', 'Auxiliar de calidad', 'images/firmas/firma_encargado_1778273347.png', 'images/firmas/firma_supervisor_1778591303.png', NULL, 'Se encotro una rata muerta en trampa captura viva nro. 7  Mantener orden y limpieza,se recomienda mantener despejado las unidades de control', '2026-05-08 03:00:00', '2026-05-12 12:08:23'),
(21, 5, 8, 5, 1, NULL, 934, 'Carlos Julian', 'Jefe de centro de distribución', 'images/firmas/firma_encargado_1778643722.png', 'images/firmas/firma_supervisor_1778643722.png', NULL, 'Se capturo un roedor en la unidad de control #2 , mantener orden y limpieza, mantener despejado las unidades de control', '2026-05-09 03:00:00', '2026-05-13 02:42:02'),
(22, 5, 8, 5, 2, NULL, 939, 'Carlos Julian', 'Jefe de centro de distribución', 'images/firmas/firma_encargado_1778442578.png', 'images/firmas/firma_supervisor_1778442578.png', NULL, NULL, '2026-05-09 03:00:00', '2026-05-09 03:00:00'),
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
(51, 4, 7, 2, 3, NULL, 665, 'ALDO  COLPANI', 'ENCARGADO DE PLANTA', 'images/firmas/firma_encargado_1779226410.png', 'images/firmas/firma_supervisor_1779226410.png', NULL, 'SEXTO SEGUIMIENTO', '2026-04-28 03:00:00', '2026-04-28 03:00:00');

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
(1, 22, 6, '2026-05-10 18:49:38', '2026-05-10 18:49:38');

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
(162, 17, 2, '2026-05-07 19:09:44', '2026-05-07 19:09:44'),
(163, 17, 6, '2026-05-07 19:09:44', '2026-05-07 19:09:44'),
(164, 17, 1, '2026-05-07 19:09:44', '2026-05-07 19:09:44'),
(165, 17, 5, '2026-05-07 19:09:44', '2026-05-07 19:09:44'),
(166, 17, 4, '2026-05-07 19:09:44', '2026-05-07 19:09:44'),
(208, 22, 6, '2026-05-10 18:49:38', '2026-05-10 18:49:38'),
(209, 22, 2, '2026-05-10 18:49:38', '2026-05-10 18:49:38'),
(210, 22, 10, '2026-05-10 18:49:38', '2026-05-10 18:49:38'),
(211, 22, 4, '2026-05-10 18:49:38', '2026-05-10 18:49:38'),
(212, 22, 5, '2026-05-10 18:49:38', '2026-05-10 18:49:38'),
(213, 22, 1, '2026-05-10 18:49:38', '2026-05-10 18:49:38'),
(214, 18, 6, '2026-05-12 11:58:42', '2026-05-12 11:58:42'),
(215, 18, 2, '2026-05-12 11:58:42', '2026-05-12 11:58:42'),
(216, 18, 4, '2026-05-12 11:58:42', '2026-05-12 11:58:42'),
(217, 18, 5, '2026-05-12 11:58:42', '2026-05-12 11:58:42'),
(218, 18, 9, '2026-05-12 11:58:42', '2026-05-12 11:58:42'),
(219, 18, 1, '2026-05-12 11:58:42', '2026-05-12 11:58:42'),
(226, 19, 2, '2026-05-12 12:03:58', '2026-05-12 12:03:58'),
(227, 19, 6, '2026-05-12 12:03:58', '2026-05-12 12:03:58'),
(228, 19, 4, '2026-05-12 12:03:58', '2026-05-12 12:03:58'),
(229, 19, 5, '2026-05-12 12:03:58', '2026-05-12 12:03:58'),
(230, 19, 1, '2026-05-12 12:03:58', '2026-05-12 12:03:58'),
(231, 19, 9, '2026-05-12 12:03:58', '2026-05-12 12:03:58'),
(232, 20, 6, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(233, 20, 2, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(234, 20, 4, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(235, 20, 5, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(236, 20, 1, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
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
(406, 40, 6, '2026-05-19 21:17:31', '2026-05-19 21:17:31');

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
(190, 40, 'images/seguimientos/6a0ce05a76f6f_Imagen de WPS(1).jpeg', '2026-05-19 21:12:42', '2026-05-19 21:12:42');

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
(53, 17, 1, '2026-05-07 19:09:44', '2026-05-07 19:09:44'),
(54, 17, 2, '2026-05-07 19:09:44', '2026-05-07 19:09:44'),
(62, 22, 4, '2026-05-10 18:49:38', '2026-05-10 18:49:38'),
(63, 20, 1, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
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
(122, 40, 1, '2026-05-19 21:17:31', '2026-05-19 21:17:31');

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
(71, 17, 2, '2026-05-07 19:09:44', '2026-05-07 19:09:44'),
(72, 17, 1, '2026-05-07 19:09:44', '2026-05-07 19:09:44'),
(86, 22, 3, '2026-05-10 18:49:38', '2026-05-10 18:49:38'),
(87, 18, 2, '2026-05-12 11:58:42', '2026-05-12 11:58:42'),
(90, 19, 1, '2026-05-12 12:03:58', '2026-05-12 12:03:58'),
(91, 19, 2, '2026-05-12 12:03:58', '2026-05-12 12:03:58'),
(92, 20, 1, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(93, 20, 2, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
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
(165, 40, 1, '2026-05-19 21:17:31', '2026-05-19 21:17:31');

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
(7, 20, 7, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
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
(31, 40, 7, '2026-05-19 21:17:31', '2026-05-19 21:17:31');

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
('2YcAZw0U0naCknyU9nH67WscbUJmB8lFlcD0dH31', NULL, '138.68.158.95', 'Mozilla/5.0 (X11; Linux x86_64; rv:142.0) Gecko/20100101 Firefox/142.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiV2JGS2VCbTcxTFl0bWtmbm1wc1dYMlFKNzg5UTZwa0FjWmU4eDMzMiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjQ6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmNvbSI7czo1OiJyb3V0ZSI7czo0OiJob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1779307058),
('3YHqP08CQedRuJ1M8JmlEUxq8i3v1BKyBlf2wFYw', NULL, '193.186.4.214', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Mobile Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQ3Ztb2ZBZjQ1cWtXd3FHQWJ6S2ZDYlROMHY0UXlqVGZpYmlKSjJCTCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjQ6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmNvbSI7czo1OiJyb3V0ZSI7czo0OiJob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1779307799),
('5VcoG0QEY2uW9qf686Lq40p4a2a6siFEVATfWL0A', NULL, '43.135.145.73', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZDhscmQyVWdWa2Z1WXlIdWhSeVVJRDVlb0ZqNmNUTDJtdFdYeFc2OSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjM6Imh0dHA6Ly9ib2xpdmlhbnBlc3QuY29tIjtzOjU6InJvdXRlIjtzOjQ6ImhvbWUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1779244356),
('70V6J7sF6VeMCktDg8QH2fKlcRCsoYtcparwnSd1', NULL, '93.158.91.24', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiT1VGRFdIejVRZE1oTGFwSW1XaU5KeURTRnUzdE9rWEllVWNGSEpHdiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjQ6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmNvbSI7czo1OiJyb3V0ZSI7czo0OiJob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1779272003),
('AzedrQfKBS5Fl8G1KnOSEoco1FkNimaVfEvErcWG', NULL, '43.138.68.113', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTVhrSUV1TjhhV0VrMThaSlBaaTNhVmNVcHBwZ1BPeGFNNHZaSTh5ZCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjM6Imh0dHA6Ly9ib2xpdmlhbnBlc3QuY29tIjtzOjU6InJvdXRlIjtzOjQ6ImhvbWUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1779256070),
('C36D7SA0a3ucRbAxvTH7pzQmBxpliyi4KhgiuSv6', NULL, '49.232.104.223', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibW1yNVdWODZTZmkyMHBBaTNLcTlLOVhRWjlBY2NrOVg2R2ljaFRpeCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjM6Imh0dHA6Ly9ib2xpdmlhbnBlc3QuY29tIjtzOjU6InJvdXRlIjtzOjQ6ImhvbWUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1779320730),
('C4wOZ43WgpkOgCAiULV9MCcox21fQySJDT8UwVtQ', NULL, '51.195.215.99', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZkwyUzZwSzY1TWJyaVRDUmZWemhUdDRINGRwU1l2MVRvMFpSYzVvZiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjQ6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmNvbSI7czo1OiJyb3V0ZSI7czo0OiJob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1779289560),
('D3Y5guedJw3OlePZoNp9cfRMPy4DXjwUpqoTaVoI', NULL, '138.68.158.95', 'Mozilla/5.0 (X11; Linux x86_64; rv:142.0) Gecko/20100101 Firefox/142.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiREpwc0dSYkZlTXc0dG41ZlFlRFFWMkxUNGhSbHlFZG1hZEVvV3ZxbiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjM6Imh0dHA6Ly9ib2xpdmlhbnBlc3QuY29tIjtzOjU6InJvdXRlIjtzOjQ6ImhvbWUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1779307058),
('e6UrC3PB08jbKiT27Ldjm2Yfn5eJPHIyYEtAvc6E', NULL, '87.99.135.65', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNTVHVnc3dmV5YmtERUFpUk8wa2p6MWpuejFEUzA0UVpvc2RsSTZZNCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjQ6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmNvbSI7czo1OiJyb3V0ZSI7czo0OiJob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1779329046),
('e7KLgnLoAiaehV8xFoSYpHK1ZUe79YNMWNS7W9iU', NULL, '180.153.236.252', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0; 360Spider', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSG0zQjdzd1hGZk8zeVoxOXg2b2hxUExjd091SDN4WHZiRmtwa09DSyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly93d3cuYm9saXZpYW5wZXN0LmNvbSI7czo1OiJyb3V0ZSI7czo0OiJob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1779348771),
('epKXRnoOteYkC2sf8301G1lLASteJmo4Iqypbeho', NULL, '1.13.158.23', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoieExoVHIxdUl3UFhYT3I1VDhMeENSVThtczFGR0x2NGhuUTFPaDNkRiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly93d3cuYm9saXZpYW5wZXN0LmNvbSI7czo1OiJyb3V0ZSI7czo0OiJob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1779261712),
('ezANYOb780lhHRV3Q3OZVTeGA4ZWs2hnVVLrp6Fu', NULL, '43.133.61.171', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiU2s4VmE2NFg0VEx2enJFeW5sanpubUM2VkI2d0FhVDd5MlpVU1gzTCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly93d3cuYm9saXZpYW5wZXN0LmNvbSI7czo1OiJyb3V0ZSI7czo0OiJob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1779250145),
('f55zHSmP4WlCCtHMICD3TWJo2vzlcG9NBa6cTPtf', NULL, '161.115.234.187', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:135.0) Gecko/20100101 Firefox/135.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYkJhMFIydjZTck5TVWRPcktsVWlmdnNROW9JS2xXWHpxbUpMaTEybCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjQ6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmNvbSI7czo1OiJyb3V0ZSI7czo0OiJob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1779303486),
('FVBEXL6gSh6HtGaWRAVNOAuhccEEd9BH6Jn9dXbL', NULL, '43.134.98.88', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaDRrdlVMUVBXclFNMUxxUVNSVjljMFNkeW90VnhGSEw5RGV4eGRJRCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjM6Imh0dHA6Ly9ib2xpdmlhbnBlc3QuY29tIjtzOjU6InJvdXRlIjtzOjQ6ImhvbWUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1779271577),
('g2efqPU0Pz54u61htR3RPMh4iainOP2YPLd2D1aD', NULL, '161.115.235.56', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36 Edg/99.0.1150.30', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiemVZaG1xNDdZUnhSenNOcnI0UUZ6WHlEU1l4bzVOSElHaWdJSXQwYSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjQ6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmNvbSI7czo1OiJyb3V0ZSI7czo0OiJob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1779303421),
('GlIQbAvtmMj1qCHvfdz0IwT5GatvXh3xkExICK1U', NULL, '72.1.179.240', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.3', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiU2g4OWNUaXE3eVlJVkx5N091VEJVMDM5dlZ2ak13azBCWXl0cG43cSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjQ6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmNvbSI7czo1OiJyb3V0ZSI7czo0OiJob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1779255310),
('Gv7paw8eESq0G0OnT5Uv0X4faNNxwA0E6KSj8K3R', NULL, '23.27.145.151', 'Mozilla/5.0 (X11; Linux i686; rv:109.0) Gecko/20100101 Firefox/120.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiR3NXemNhaG16Y3NhckoybGFJaXpEcXNOZGRHSklSeFp2bTRjMXBOViI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjQ6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmNvbSI7czo1OiJyb3V0ZSI7czo0OiJob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1779315544),
('jE2e6JnKrjhwaREWdVLpIiqulrT9oEX0Rq6yz7Oc', NULL, '176.65.139.234', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiczhKSnpZRkZpWTByNG9ROHVCYmJFdnltQk5rRkxxSUVJVm92NGk5MSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjQ6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmNvbSI7czo1OiJyb3V0ZSI7czo0OiJob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1779362431),
('knLGPGPbQb51YnuvfMfcThzXocD9nmAJp32NcYUB', NULL, '34.41.44.162', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYkpldEhSRng2NDIwSVNGd2lwWm96RjNGTUtUNFJpWXJXSXJEMHJnNiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjM6Imh0dHA6Ly9ib2xpdmlhbnBlc3QuY29tIjtzOjU6InJvdXRlIjtzOjQ6ImhvbWUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1779329641),
('lnTwRis1882bYoiDQpoBURbcp47mxYBf6KqTCGKC', NULL, '43.130.150.80', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSVkxdTJYazhzbXd1ZG1ISmJzWXFudk4wNUx2TzgwMjFLMGEwM2ZwaCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly93d3cuYm9saXZpYW5wZXN0LmNvbSI7czo1OiJyb3V0ZSI7czo0OiJob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1779236159),
('MMzpa4d04FLwXEnQNuQxcIyz85uxykYGBY72Wlu4', 2, '177.222.112.216', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36 Edg/148.0.0.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoidHI4Y1RYRXJWR3hlVXNPemdQckpsT3V3WEs2VGFkM2JqQ2lwU0pwUSI7czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MjtzOjk6Il9wcmV2aW91cyI7YToyOntzOjM6InVybCI7czoxMzI6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmNvbS9pbmZvcm1lcz9hbG1hY2VuX2lkPTcmYnVzY2FyPTEmZW1wcmVzYV9pZD00JmZlY2hhX2Zpbj0yMDI2LTA0LTI4JmZlY2hhX2luaWNpbz0yMDI2LTA0LTE0JnRpcG9fZmlsdHJvPWZlY2hhcyI7czo1OiJyb3V0ZSI7czoxNDoiaW5mb3JtZXMuaW5kZXgiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1779309010),
('MQntaC69hbXO7NgVjGtgs7OwqxIqaGCkXYs0VGTw', NULL, '177.222.49.62', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:148.0) Gecko/20100101 Firefox/148.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTXpZaHlxU2VaREFVclpTWnpsOVJEbUpubkNiSjlqT2oyVllrUTJCZSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzA6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmNvbS9sb2dpbiI7czo1OiJyb3V0ZSI7czo1OiJsb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1779285758),
('mvjJIpnYRKjSbjleBqzC5KYVeZfRZeOBuB8E9tno', 2, '177.222.112.216', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36 Edg/148.0.0.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoid2tLeHQ3OFJUSjFKaXc3MXJnS1NlQUZ0cGxpN0lWd0tKQm1BUExHRCI7czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MjtzOjk6Il9wcmV2aW91cyI7YToyOntzOjM6InVybCI7czoyNDoiaHR0cHM6Ly9ib2xpdmlhbnBlc3QuY29tIjtzOjU6InJvdXRlIjtzOjQ6ImhvbWUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1779309010),
('OgEwX26vYw3sQ45G3YdFIt92zDISMbvB73g9YTis', NULL, '49.51.180.2', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicnZIcFpUUWdaU1Bvb0w2Mm1XSTVNVlZYdWFKMGE3aTdCTk5ldTRMeSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly93d3cuYm9saXZpYW5wZXN0LmNvbSI7czo1OiJyb3V0ZSI7czo0OiJob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1779277383),
('OlsLXbjoHtzbN56jGMmp9Pjo1h9Bwp0Uk6lNuyAj', NULL, '170.106.35.187', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYmtaajFjRHp3VVA4aWdteGl3ejJ4VXZHdFNBUGNpWFJOT3gyV1g1YyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjM6Imh0dHA6Ly9ib2xpdmlhbnBlc3QuY29tIjtzOjU6InJvdXRlIjtzOjQ6ImhvbWUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1779258067),
('Q013u74HtiDGPhMIstMXMBEc40fDgmNle9jHbU1z', NULL, '5.133.192.188', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:123.0) Gecko/20100101 Firefox/123', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSTVVT1RrOGVTaHE5RW9oUzlaVkIzWUtkYm9oRW1jalE2ZFJtRkdzciI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjM6Imh0dHA6Ly9ib2xpdmlhbnBlc3QuY29tIjtzOjU6InJvdXRlIjtzOjQ6ImhvbWUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1779351047),
('qV2ZuMlQ1FZD7HvKo3SdFglpqVfUyyIKs44oU4Zw', NULL, '35.94.176.231', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:125.0) Gecko/20100101 Firefox/125.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoialZWQjNlWWZ3d1VFZ0dONmlnbTZxSUx5eEFka042TjJXaGV4UFZpYiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjM6Imh0dHA6Ly9ib2xpdmlhbnBlc3QuY29tIjtzOjU6InJvdXRlIjtzOjQ6ImhvbWUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1779344168),
('rOj9Ot7DCutG16XyCoOpexaZcHLwoAm9UwfuE3lX', NULL, '54.39.89.75', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZ1lvTjhXRTlHR1Z1QTBLMW1iY0xNQUtFeGNKR2cyVFozb1RRcE5aYyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjM6Imh0dHA6Ly9ib2xpdmlhbnBlc3QuY29tIjtzOjU6InJvdXRlIjtzOjQ6ImhvbWUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1779277693),
('RtSJ9My8grMnzSrxSx1M3ha9nfUpRUuLnyiDmCs0', 2, '177.222.112.216', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36 Edg/148.0.0.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiN3JrTnBvcnpHS2dubndWSTE5dGlWVVFCdHRTM1FsYnhvdjd6YjdINCI7czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MjtzOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjk6Il9wcmV2aW91cyI7YToyOntzOjM6InVybCI7czo1NjoiaHR0cHM6Ly9ib2xpdmlhbnBlc3QuY29tL2luZm9ybWVzL2V4cG9ydGFyLXdvcmQtZG93bmxvYWQiO3M6NToicm91dGUiO047fX0=', 1779241562),
('SP3IwOp9slA3dMxfhIxIGkzFDrsjfR6JuTQcrhjF', NULL, '205.210.31.34', 'Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicTdjaHVNT1RwZ3p1bHYwcjFnM2tTelNKTDlHRFFNQmZiNTRhS1phUiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjQ6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmNvbSI7czo1OiJyb3V0ZSI7czo0OiJob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1779278880),
('tTMjk1HD8AYq3TxxODVPnPsBnIP72Z1d2WZcM7p3', NULL, '104.248.211.93', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSHhpdlQ5T0lRdVcyMHR4ak41T1FXV1N2MDlIcGVyYnBMdXlOQm84cCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjQ6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmNvbSI7czo1OiJyb3V0ZSI7czo0OiJob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1779272376),
('UvA144NhJZTe20nzYzPky3k7sAi65a4FHw1uVq2q', NULL, '180.153.236.2', 'User-Agent:Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0; 360Spider', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoid2laUGRDVkhEVUMzS3l3SnRNMTFkcmVtaHRYWFhhdE9RNWVXa3FDNiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjM6Imh0dHA6Ly9ib2xpdmlhbnBlc3QuY29tIjtzOjU6InJvdXRlIjtzOjQ6ImhvbWUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1779343133),
('UXhm4Rml5KLjjLG6PgQONP6Sow6DkeINospMtCVU', NULL, '162.120.186.184', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Mobile Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibEJnTFZrblA3eXYxenF4M3JrZFN2VEtXbVFnRDZmdlNnckdlMGI0YyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjQ6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmNvbSI7czo1OiJyb3V0ZSI7czo0OiJob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1779307841),
('WY13VRcrr7XoLbUSJMXZD5KZgVs8Zf2Z8K1W8wnF', NULL, '157.55.39.60', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibUFDWTRDRTZvWTZRMk5TQnVWMHcyaVdTMnJwcjJGM3FNRmNOT1luUCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjQ6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmNvbSI7czo1OiJyb3V0ZSI7czo0OiJob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1779348786),
('Xghv7lC5rdq5R585NneINncwkTHi0rUFXaigClCQ', 2, '177.222.49.62', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoib2FwOUJ5U2psR05BS3FwQlBEVjlqU1pEcm5td3ZNYm13SU9LbnZtayI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzA6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmNvbS9sb2dpbiI7czo1OiJyb3V0ZSI7czo1OiJsb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjI7fQ==', 1779241260),
('XnSHBfjlYCSyeaUtvjel4SeWB10DSH2nMODtMFqk', NULL, '161.115.235.198', 'Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/119.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNU12UmFoeEU4RU1kVUw5OG1vUWF6a29QcWpsbTJIMTZOWUpQcFZlYSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjM6Imh0dHA6Ly9ib2xpdmlhbnBlc3QuY29tIjtzOjU6InJvdXRlIjtzOjQ6ImhvbWUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1779240276),
('xNwWitZE1YorHhbuqsB9FHp1iOzz6WLt7vPDusU3', 2, '177.222.49.62', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:148.0) Gecko/20100101 Firefox/148.0', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoiUEppMVVUWnZDMGlxWkswcksxRGo1aHM4UHJ6dkxCT2pSTm90QklZbSI7czozOiJ1cmwiO2E6MDp7fXM6OToiX3ByZXZpb3VzIjthOjI6e3M6MzoidXJsIjtzOjMwOiJodHRwczovL2JvbGl2aWFucGVzdC5jb20vbG9naW4iO3M6NToicm91dGUiO3M6NToibG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToyO30=', 1779239414),
('XTFxgX0db4BU17bbCIg7TuojU57VI00d3pJpBzfK', NULL, '57.141.0.48', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidkxSeVZaaWFIUFlwSEVFZGlRd1Z4MGVwTHRFQ0FXeUxwazdYMU5QTSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjg6Imh0dHBzOi8vd3d3LmJvbGl2aWFucGVzdC5jb20iO3M6NToicm91dGUiO3M6NDoiaG9tZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1779314785),
('xUJ6UTr7e756oMnUwplZ8MpDZUOWfAEaoO4oT2Ln', NULL, '43.131.45.213', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiajJBNFRLWFlSWFpDMHRNSTRETGF6b1F3ZUc2WkRzSG02WDMyTGVySyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly93d3cuYm9saXZpYW5wZXN0LmNvbSI7czo1OiJyb3V0ZSI7czo0OiJob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1779263895);

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
(848, 1, 2, 3, 1, NULL, 403, 642, '1', 'activo', '2026-05-01 11:22:22', '2026-05-01 11:22:22'),
(849, 1, 2, 3, 2, NULL, 496, 640, '2', 'activo', '2026-05-01 11:22:22', '2026-05-01 11:22:22'),
(850, 1, 2, 3, 3, NULL, 543, 635, '3', 'activo', '2026-05-01 11:22:22', '2026-05-01 11:22:22'),
(851, 1, 2, 3, 4, NULL, 658, 639, '4', 'activo', '2026-05-01 11:22:22', '2026-05-01 11:22:22'),
(852, 1, 2, 3, 5, NULL, 766, 644, '5', 'activo', '2026-05-01 11:22:22', '2026-05-01 11:22:22'),
(853, 1, 2, 3, 6, NULL, 831, 643, '6', 'activo', '2026-05-01 11:22:22', '2026-05-01 11:22:22'),
(854, 1, 2, 3, 7, NULL, 706, 231, '7', 'activo', '2026-05-01 11:22:22', '2026-05-01 11:22:22'),
(855, 1, 2, 3, 8, NULL, 395, 210, '8', 'activo', '2026-05-01 11:22:22', '2026-05-01 11:22:22'),
(856, 1, 2, 3, 9, NULL, 469, 168, '9', 'activo', '2026-05-01 11:22:22', '2026-05-01 11:22:22'),
(857, 1, 2, 3, 10, NULL, 626, 79, '10', 'activo', '2026-05-01 11:22:22', '2026-05-01 11:22:22'),
(858, 1, 2, 3, 11, NULL, 351, 67, '11', 'activo', '2026-05-01 11:22:22', '2026-05-01 11:22:22'),
(859, 1, 2, 3, 12, NULL, 153, 61, '12', 'activo', '2026-05-01 11:22:22', '2026-05-01 11:22:22'),
(860, 1, 2, 3, 13, NULL, 597, 582, '13', 'activo', '2026-05-01 11:22:22', '2026-05-01 11:22:22'),
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
(1465, 1, 3, 3, 1, NULL, 85, 180, '1', 'activo', '2026-05-01 19:35:38', '2026-05-01 19:35:38'),
(1466, 1, 3, 3, 2, NULL, 270, 62, '2', 'activo', '2026-05-01 19:35:38', '2026-05-01 19:35:38'),
(1467, 1, 3, 3, 3, NULL, 574, 54, '3', 'activo', '2026-05-01 19:35:38', '2026-05-01 19:35:38'),
(1468, 1, 3, 3, 4, NULL, 590, 182, '4', 'activo', '2026-05-01 19:35:38', '2026-05-01 19:35:38'),
(1469, 1, 3, 3, 5, NULL, 581, 276, '5', 'activo', '2026-05-01 19:35:38', '2026-05-01 19:35:38'),
(1470, 1, 3, 3, 6, NULL, 408, 402, '6', 'activo', '2026-05-01 19:35:38', '2026-05-01 19:35:38'),
(1471, 1, 3, 3, 7, NULL, 738, 63, '7', 'activo', '2026-05-01 19:35:38', '2026-05-01 19:35:38'),
(1472, 1, 3, 3, 8, NULL, 900, 206, '8', 'activo', '2026-05-01 19:35:38', '2026-05-01 19:35:38'),
(1473, 1, 3, 3, 9, NULL, 741, 254, '9', 'activo', '2026-05-01 19:35:38', '2026-05-01 19:35:38'),
(1474, 1, 3, 3, 10, NULL, 730, 370, '10', 'activo', '2026-05-01 19:35:38', '2026-05-01 19:35:38'),
(1475, 1, 1, 3, 1, NULL, 715, 324, '1', 'activo', '2026-05-03 13:27:31', '2026-05-03 13:27:31'),
(1476, 1, 1, 3, 2, NULL, 639, 323, '2', 'activo', '2026-05-03 13:27:31', '2026-05-03 13:27:31'),
(1477, 1, 1, 3, 3, NULL, 378, 322, '3', 'activo', '2026-05-03 13:27:31', '2026-05-03 13:27:31'),
(1478, 1, 1, 4, 4, NULL, 555, 431, '4', 'activo', '2026-05-03 13:27:31', '2026-05-03 13:27:31'),
(1479, 1, 1, 4, 5, NULL, 470, 513, '5', 'activo', '2026-05-03 13:27:31', '2026-05-03 13:27:31'),
(1480, 1, 1, 4, 6, NULL, 724, 418, '6', 'activo', '2026-05-03 13:27:31', '2026-05-03 13:27:31'),
(1481, 1, 1, 4, 7, NULL, 653, 411, '7', 'activo', '2026-05-03 13:27:31', '2026-05-03 13:27:31'),
(1482, 1, 1, 3, 8, NULL, 664, 465, '8', 'activo', '2026-05-03 13:27:31', '2026-05-03 13:27:31'),
(1483, 1, 1, 3, 9, NULL, 531, 508, '9', 'activo', '2026-05-03 13:27:31', '2026-05-03 13:27:31'),
(1484, 1, 1, 3, 10, NULL, 556, 455, '10', 'activo', '2026-05-03 13:27:31', '2026-05-03 13:27:31'),
(1485, 1, 1, 3, 11, NULL, 573, 510, '11', 'activo', '2026-05-03 13:27:31', '2026-05-03 13:27:31'),
(1486, 1, 1, 3, 12, NULL, 721, 505, '12', 'activo', '2026-05-03 13:27:31', '2026-05-03 13:27:31'),
(1487, 1, 1, 3, 13, NULL, 407, 477, '13', 'activo', '2026-05-03 13:27:31', '2026-05-03 13:27:31'),
(1488, 1, 1, 3, 14, NULL, 375, 474, '14', 'activo', '2026-05-03 13:27:31', '2026-05-03 13:27:31'),
(1489, 1, 1, 3, 15, NULL, 376, 511, '15', 'activo', '2026-05-03 13:27:31', '2026-05-03 13:27:31'),
(1490, 1, 1, 3, 16, NULL, 288, 654, '16', 'activo', '2026-05-03 13:27:31', '2026-05-03 13:27:31'),
(1491, 1, 1, 3, 17, NULL, 283, 472, '17', 'activo', '2026-05-03 13:27:31', '2026-05-03 13:27:31'),
(1492, 1, 1, 3, 18, NULL, 353, 326, '18', 'activo', '2026-05-03 13:27:31', '2026-05-03 13:27:31'),
(1493, 1, 1, 3, 19, NULL, 349, 623, '19', 'activo', '2026-05-03 13:27:31', '2026-05-03 13:27:31'),
(1494, 1, 1, 3, 20, NULL, 323, 663, '20', 'activo', '2026-05-03 13:27:31', '2026-05-03 13:27:31'),
(1495, 1, 1, 3, 21, NULL, 661, 671, '21', 'activo', '2026-05-03 13:27:31', '2026-05-03 13:27:31'),
(1496, 1, 1, 3, 22, NULL, 725, 596, '22', 'activo', '2026-05-03 13:27:31', '2026-05-03 13:27:31'),
(1497, 1, 1, 3, 23, NULL, 626, 486, '24', 'activo', '2026-05-03 13:27:31', '2026-05-03 13:27:31'),
(1498, 1, 1, 4, 24, NULL, 723, 531, '23', 'activo', '2026-05-03 13:27:31', '2026-05-03 13:27:31'),
(1499, 1, 1, 4, 25, NULL, 705, 255, '28', 'activo', '2026-05-03 13:27:31', '2026-05-03 13:27:31'),
(1500, 1, 1, 4, 26, NULL, 732, 254, '29', 'activo', '2026-05-03 13:27:31', '2026-05-03 13:27:31'),
(1501, 1, 1, 4, 27, NULL, 376, 281, '30', 'activo', '2026-05-03 13:27:31', '2026-05-03 13:27:31'),
(1502, 1, 1, 4, 28, NULL, 382, 82, '31', 'activo', '2026-05-03 13:27:31', '2026-05-03 13:27:31'),
(1503, 1, 1, 4, 29, NULL, 709, 85, '32', 'activo', '2026-05-03 13:27:31', '2026-05-03 13:27:31'),
(1504, 1, 1, 4, 30, NULL, 767, 111, '33', 'activo', '2026-05-03 13:27:31', '2026-05-03 13:27:31'),
(1505, 1, 1, 4, 31, NULL, 838, 160, '34', 'activo', '2026-05-03 13:27:31', '2026-05-03 13:27:31'),
(1506, 1, 1, 4, 32, NULL, 761, 31, '35', 'activo', '2026-05-03 13:27:31', '2026-05-03 13:27:31'),
(1507, 1, 1, 4, 33, NULL, 967, 27, '36', 'activo', '2026-05-03 13:27:31', '2026-05-03 13:27:31'),
(1508, 1, 1, 4, 34, NULL, 645, 28, '37', 'activo', '2026-05-03 13:27:31', '2026-05-03 13:27:31'),
(1509, 1, 1, 4, 35, NULL, 352, 67, '38', 'activo', '2026-05-03 13:27:31', '2026-05-03 13:27:31'),
(1510, 1, 1, 4, 36, NULL, 371, 22, '39', 'activo', '2026-05-03 13:27:31', '2026-05-03 13:27:31'),
(1511, 1, 1, 4, 37, NULL, 47, 22, '40', 'activo', '2026-05-03 13:27:31', '2026-05-03 13:27:31'),
(1512, 1, 1, 4, 38, NULL, 48, 56, '41', 'activo', '2026-05-03 13:27:31', '2026-05-03 13:27:31'),
(1513, 1, 1, 5, 39, NULL, 577, 332, '46', 'activo', '2026-05-03 13:27:31', '2026-05-03 13:27:31'),
(1514, 1, 1, 5, 40, NULL, 578, 363, '47', 'activo', '2026-05-03 13:27:31', '2026-05-03 13:27:31'),
(1515, 1, 1, 5, 41, NULL, 620, 326, '48', 'activo', '2026-05-03 13:27:31', '2026-05-03 13:27:31'),
(1516, 1, 1, 5, 42, NULL, 620, 365, '49', 'activo', '2026-05-03 13:27:31', '2026-05-03 13:27:31'),
(1517, 1, 1, 5, 43, NULL, 660, 325, '50', 'activo', '2026-05-03 13:27:31', '2026-05-03 13:27:31'),
(1518, 1, 1, 5, 44, NULL, 656, 364, '51', 'activo', '2026-05-03 13:27:31', '2026-05-03 13:27:31'),
(1519, 1, 1, 5, 45, NULL, 689, 324, '52', 'activo', '2026-05-03 13:27:31', '2026-05-03 13:27:31'),
(1520, 1, 1, 5, 46, NULL, 691, 365, '53', 'activo', '2026-05-03 13:27:31', '2026-05-03 13:27:31'),
(1521, 1, 1, 5, 47, NULL, 724, 364, '54', 'activo', '2026-05-03 13:27:31', '2026-05-03 13:27:31'),
(1522, 1, 1, 5, 48, NULL, 732, 316, '55', 'activo', '2026-05-03 13:27:31', '2026-05-03 13:27:31'),
(1523, 1, 1, 2, 49, NULL, 601, 356, 'insect1', 'activo', '2026-05-03 13:27:31', '2026-05-03 13:27:31'),
(1524, 1, 1, 2, 50, NULL, 562, 224, 'insect2', 'activo', '2026-05-03 13:27:31', '2026-05-03 13:27:31'),
(1525, 1, 1, 2, 51, NULL, 707, 216, 'Insect3', 'activo', '2026-05-03 13:27:31', '2026-05-03 13:27:31'),
(1526, 1, 1, 3, 52, NULL, 762, 195, '25', 'activo', '2026-05-03 13:27:31', '2026-05-03 13:27:31'),
(1527, 1, 1, 3, 53, NULL, 727, 155, '26', 'activo', '2026-05-03 13:27:31', '2026-05-03 13:27:31'),
(1528, 1, 1, 3, 54, NULL, 729, 221, '27', 'activo', '2026-05-03 13:27:31', '2026-05-03 13:27:31'),
(1529, 1, 1, 3, 55, NULL, 282, 274, '42', 'activo', '2026-05-03 13:27:31', '2026-05-03 13:27:31'),
(1530, 1, 1, 3, 56, NULL, 195, 187, '43', 'activo', '2026-05-03 13:27:31', '2026-05-03 13:27:31'),
(1531, 1, 1, 3, 57, NULL, 116, 111, '44', 'activo', '2026-05-03 13:27:31', '2026-05-03 13:27:31'),
(1532, 1, 1, 3, 58, NULL, 353, 87, '45', 'activo', '2026-05-03 13:27:31', '2026-05-03 13:27:31'),
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
(1711, 4, 4, 2, 131, NULL, 354, 257, 'insecto', 'activo', '2026-05-12 11:57:38', '2026-05-12 11:57:38');

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
(68, 19, 1711, 2, 1, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(69, 19, 1711, 1, 1, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(70, 19, 1711, 3, 2, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
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
(97, 50, 1464, 2, 14, '2026-05-19 20:48:38', '2026-05-19 20:48:38');

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
(1873, 17, 848, NULL, 0, 20, 0, 20, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1874, 17, 849, NULL, 0, 20, 0, 20, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1875, 17, 850, NULL, 0, 20, 0, 20, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1876, 17, 851, NULL, 0, 20, 0, 20, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1877, 17, 852, NULL, 0, 20, 0, 20, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1878, 17, 853, NULL, 0, 20, 0, 20, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1879, 17, 854, NULL, 0, 20, 0, 20, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1880, 17, 855, NULL, 0, 28, 8, 20, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1881, 17, 856, NULL, 0, 20, 0, 20, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1882, 17, 857, NULL, 0, 20, 0, 20, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1883, 17, 858, NULL, 0, 20, 0, 20, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1884, 17, 859, NULL, 0, 20, 0, 20, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1885, 17, 860, NULL, 0, 20, 0, 20, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1886, 17, 1465, NULL, 0, 20, 0, 20, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1887, 17, 1466, NULL, 0, 20, 0, 20, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1888, 17, 1467, NULL, 0, 20, 0, 20, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1889, 17, 1468, NULL, 0, 20, 0, 20, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1890, 17, 1469, NULL, 0, 20, 0, 20, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1891, 17, 1470, NULL, 0, 20, 0, 20, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1892, 17, 1471, NULL, 0, 20, 0, 20, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1893, 17, 1472, NULL, 0, 20, 0, 20, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1894, 17, 1473, NULL, 0, 20, 0, 20, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1895, 17, 1474, NULL, 0, 20, 0, 20, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1896, 17, 1475, NULL, 0, 20, 0, 20, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1897, 17, 1476, NULL, 0, 20, 0, 20, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1898, 17, 1477, NULL, 0, 20, 0, 20, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1899, 17, 1478, NULL, 0, 0, 0, 0, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1900, 17, 1479, NULL, 0, 0, 0, 0, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1901, 17, 1480, NULL, 0, 0, 0, 0, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1902, 17, 1481, NULL, 0, 0, 0, 0, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1903, 17, 1482, NULL, 0, 20, 0, 20, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1904, 17, 1483, NULL, 0, 20, 0, 20, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1905, 17, 1484, NULL, 0, 20, 0, 20, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1906, 17, 1485, NULL, 0, 20, 0, 20, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1907, 17, 1486, NULL, 0, 20, 0, 20, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1908, 17, 1487, NULL, 0, 20, 0, 20, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1909, 17, 1488, NULL, 0, 20, 0, 20, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1910, 17, 1489, NULL, 0, 20, 0, 20, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1911, 17, 1490, NULL, 0, 20, 0, 20, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1912, 17, 1491, NULL, 0, 20, 0, 20, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1913, 17, 1492, NULL, 0, 20, 0, 20, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1914, 17, 1493, NULL, 0, 20, 0, 20, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1915, 17, 1494, NULL, 0, 20, 0, 20, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1916, 17, 1495, NULL, 0, 20, 0, 20, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1917, 17, 1496, NULL, 0, 20, 0, 20, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1918, 17, 1497, NULL, 0, 20, 0, 20, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1919, 17, 1498, NULL, 0, 0, 0, 0, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1920, 17, 1499, NULL, 0, 0, 0, 0, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1921, 17, 1500, NULL, 0, 0, 0, 0, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1922, 17, 1501, NULL, 0, 0, 0, 0, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1923, 17, 1502, NULL, 0, 0, 0, 0, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1924, 17, 1503, NULL, 0, 0, 0, 0, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1925, 17, 1504, NULL, 0, 0, 0, 0, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1926, 17, 1505, NULL, 0, 0, 0, 0, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1927, 17, 1506, NULL, 0, 0, 0, 0, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1928, 17, 1507, NULL, 0, 0, 0, 0, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1929, 17, 1508, NULL, 0, 0, 0, 0, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1930, 17, 1509, NULL, 0, 0, 0, 0, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1931, 17, 1510, NULL, 0, 0, 0, 0, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1932, 17, 1511, NULL, 0, 0, 0, 0, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1933, 17, 1512, NULL, 0, 0, 0, 0, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1934, 17, 1513, NULL, 0, 0, 0, 0, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1935, 17, 1514, NULL, 0, 0, 0, 0, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1936, 17, 1515, NULL, 0, 0, 0, 0, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1937, 17, 1516, NULL, 0, 0, 0, 0, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1938, 17, 1517, NULL, 0, 0, 0, 0, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1939, 17, 1518, NULL, 0, 0, 0, 0, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1940, 17, 1519, NULL, 0, 0, 0, 0, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1941, 17, 1520, NULL, 0, 0, 0, 0, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1942, 17, 1521, NULL, 0, 0, 0, 0, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1943, 17, 1522, NULL, 0, 0, 0, 0, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1944, 17, 1526, NULL, 0, 20, 0, 20, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1945, 17, 1527, NULL, 0, 20, 1, 19, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1946, 17, 1528, NULL, 0, 20, 0, 20, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1947, 17, 1529, NULL, 0, 20, 1, 19, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1948, 17, 1530, NULL, 0, 20, 2, 18, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1949, 17, 1531, NULL, 0, 20, 0, 20, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
(1950, 17, 1532, NULL, 0, 20, 1, 19, '2026-05-07 19:13:07', '2026-05-07 19:13:07'),
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
(3033, 19, 1152, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3034, 19, 1153, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3035, 19, 1154, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3036, 19, 1155, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3037, 19, 1156, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3038, 19, 1157, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3039, 19, 1158, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3040, 19, 1159, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3041, 19, 1160, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3042, 19, 1161, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3043, 19, 1162, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3044, 19, 1163, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3045, 19, 1164, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3046, 19, 1165, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3047, 19, 1166, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3048, 19, 1167, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3049, 19, 1168, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3050, 19, 1169, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3051, 19, 1170, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3052, 19, 1171, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3053, 19, 1172, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3054, 19, 1173, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3055, 19, 1174, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3056, 19, 1175, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3057, 19, 1176, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3058, 19, 1177, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3059, 19, 1178, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3060, 19, 1179, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3061, 19, 1180, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3062, 19, 1181, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3063, 19, 1182, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3064, 19, 1183, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3065, 19, 1184, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3066, 19, 1185, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3067, 19, 1186, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3068, 19, 1187, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3069, 19, 1188, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3070, 19, 1189, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3071, 19, 1190, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3072, 19, 1191, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3073, 19, 1192, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3074, 19, 1193, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3075, 19, 1194, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3076, 19, 1195, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3077, 19, 1196, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3078, 19, 1197, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3079, 19, 1198, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3080, 19, 1199, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3081, 19, 1200, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3082, 19, 1201, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3083, 19, 1202, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3084, 19, 1203, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3085, 19, 1204, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3086, 19, 1205, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3087, 19, 1206, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3088, 19, 1207, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3089, 19, 1208, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3090, 19, 1209, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3091, 19, 1210, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3092, 19, 1211, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3093, 19, 1212, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3094, 19, 1213, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3095, 19, 1214, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3096, 19, 1215, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3097, 19, 1216, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3098, 19, 1217, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3099, 19, 1218, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3100, 19, 1219, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3101, 19, 1220, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3102, 19, 1221, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3103, 19, 1222, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3104, 19, 1223, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3105, 19, 1224, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3106, 19, 1225, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3107, 19, 1226, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3108, 19, 1227, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3109, 19, 1228, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3110, 19, 1229, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3111, 19, 1230, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3112, 19, 1231, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3113, 19, 1232, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3114, 19, 1233, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3115, 19, 1234, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3116, 19, 1235, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3117, 19, 1236, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3118, 19, 1237, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3119, 19, 1238, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3120, 19, 1239, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3121, 19, 1240, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3122, 19, 1241, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3123, 19, 1242, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3124, 19, 1243, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3125, 19, 1244, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3126, 19, 1245, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3127, 19, 1246, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3128, 19, 1247, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3129, 19, 1248, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3130, 19, 1249, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3131, 19, 1250, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3132, 19, 1251, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3133, 19, 1252, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3134, 19, 1253, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3135, 19, 1254, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3136, 19, 1255, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3137, 19, 1256, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3138, 19, 1257, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3139, 19, 1258, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3140, 19, 1259, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3141, 19, 1260, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3142, 19, 1261, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3143, 19, 1262, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3144, 19, 1263, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3145, 19, 1264, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3146, 19, 1265, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3147, 19, 1266, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3148, 19, 1267, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3149, 19, 1268, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3150, 19, 1269, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3151, 19, 1270, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3152, 19, 1271, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3153, 19, 1272, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3154, 19, 1273, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3155, 19, 1274, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3156, 19, 1275, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3157, 19, 1276, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3158, 19, 1277, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3159, 19, 1278, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3160, 19, 1279, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3161, 19, 1280, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3162, 19, 1281, NULL, 0, 0, 0, 0, '2026-05-12 12:04:22', '2026-05-12 12:04:22'),
(3293, 20, 1152, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3294, 20, 1153, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3295, 20, 1154, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3296, 20, 1155, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3297, 20, 1156, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3298, 20, 1157, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3299, 20, 1158, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3300, 20, 1159, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3301, 20, 1160, NULL, 0, 20, 3, 17, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3302, 20, 1161, NULL, 0, 20, 2, 18, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3303, 20, 1162, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3304, 20, 1163, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3305, 20, 1164, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3306, 20, 1165, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3307, 20, 1166, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3308, 20, 1167, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3309, 20, 1168, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3310, 20, 1169, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3311, 20, 1170, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3312, 20, 1171, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3313, 20, 1172, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3314, 20, 1173, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3315, 20, 1174, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3316, 20, 1175, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3317, 20, 1176, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3318, 20, 1177, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3319, 20, 1178, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3320, 20, 1179, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3321, 20, 1180, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3322, 20, 1181, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3323, 20, 1182, NULL, 0, 20, 1, 19, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3324, 20, 1183, NULL, 0, 20, 2, 18, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3325, 20, 1184, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3326, 20, 1185, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3327, 20, 1186, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3328, 20, 1187, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3329, 20, 1188, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3330, 20, 1189, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3331, 20, 1190, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3332, 20, 1191, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3333, 20, 1192, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3334, 20, 1193, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3335, 20, 1194, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3336, 20, 1195, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3337, 20, 1196, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3338, 20, 1197, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3339, 20, 1198, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3340, 20, 1199, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3341, 20, 1200, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3342, 20, 1201, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3343, 20, 1202, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3344, 20, 1203, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3345, 20, 1204, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3346, 20, 1205, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3347, 20, 1206, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3348, 20, 1207, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3349, 20, 1208, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3350, 20, 1209, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3351, 20, 1210, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3352, 20, 1211, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3353, 20, 1212, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3354, 20, 1213, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3355, 20, 1214, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3356, 20, 1215, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3357, 20, 1216, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3358, 20, 1217, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3359, 20, 1218, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3360, 20, 1219, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3361, 20, 1220, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3362, 20, 1221, NULL, 0, 20, 20, 0, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3363, 20, 1222, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3364, 20, 1223, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3365, 20, 1224, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3366, 20, 1225, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3367, 20, 1226, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3368, 20, 1227, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3369, 20, 1228, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3370, 20, 1229, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3371, 20, 1230, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3372, 20, 1231, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3373, 20, 1232, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3374, 20, 1233, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3375, 20, 1234, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3376, 20, 1235, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3377, 20, 1236, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3378, 20, 1237, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3379, 20, 1238, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3380, 20, 1239, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3381, 20, 1240, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3382, 20, 1241, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3383, 20, 1242, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3384, 20, 1243, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3385, 20, 1244, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3386, 20, 1245, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3387, 20, 1246, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3388, 20, 1247, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3389, 20, 1248, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3390, 20, 1249, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3391, 20, 1250, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3392, 20, 1251, NULL, 0, 20, 0, 20, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3393, 20, 1252, NULL, 0, 0, 0, 0, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3394, 20, 1253, NULL, 0, 0, 0, 0, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3395, 20, 1254, NULL, 0, 0, 0, 0, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3396, 20, 1255, NULL, 0, 0, 0, 0, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3397, 20, 1256, NULL, 0, 0, 0, 0, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3398, 20, 1257, NULL, 0, 0, 0, 0, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3399, 20, 1258, 'Se capturo un roedor', 1, 0, 0, 0, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3400, 20, 1259, NULL, 0, 0, 0, 0, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3401, 20, 1260, NULL, 0, 0, 0, 0, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3402, 20, 1261, NULL, 0, 0, 0, 0, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3403, 20, 1262, NULL, 0, 0, 0, 0, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3404, 20, 1263, NULL, 0, 0, 0, 0, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3405, 20, 1264, NULL, 0, 0, 0, 0, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3406, 20, 1265, NULL, 0, 0, 0, 0, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3407, 20, 1266, NULL, 0, 0, 0, 0, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3408, 20, 1267, NULL, 0, 0, 0, 0, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3409, 20, 1268, NULL, 0, 0, 0, 0, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3410, 20, 1269, NULL, 0, 0, 0, 0, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3411, 20, 1270, NULL, 0, 0, 0, 0, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3412, 20, 1271, NULL, 0, 0, 0, 0, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3413, 20, 1272, NULL, 0, 0, 0, 0, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3414, 20, 1273, NULL, 0, 0, 0, 0, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3415, 20, 1274, NULL, 0, 0, 0, 0, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3416, 20, 1275, NULL, 0, 0, 0, 0, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3417, 20, 1276, NULL, 0, 0, 0, 0, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3418, 20, 1277, NULL, 0, 0, 0, 0, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3419, 20, 1278, NULL, 0, 0, 0, 0, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3420, 20, 1279, NULL, 0, 0, 0, 0, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3421, 20, 1280, NULL, 0, 0, 0, 0, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
(3422, 20, 1281, NULL, 0, 0, 0, 0, '2026-05-12 12:08:23', '2026-05-12 12:08:23'),
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
(3918, 25, 1157, NULL, 0, 20, 0, 20, '2026-05-17 02:22:50', '2026-05-17 02:22:50');
INSERT INTO `trampa_roedor_seguimientos` (`id`, `seguimiento_id`, `trampa_id`, `observacion`, `cantidad`, `inicial`, `merma`, `actual`, `created_at`, `updated_at`) VALUES
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
(4513, 27, 1232, NULL, 0, 20, 2, 18, '2026-05-17 04:16:34', '2026-05-17 04:16:34'),
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
(5048, 31, 1351, NULL, 0, 20, 2, 18, '2026-05-18 16:34:39', '2026-05-18 16:34:39');
INSERT INTO `trampa_roedor_seguimientos` (`id`, `seguimiento_id`, `trampa_id`, `observacion`, `cantidad`, `inicial`, `merma`, `actual`, `created_at`, `updated_at`) VALUES
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
(5441, 41, 1455, NULL, 0, 0, 0, 0, '2026-05-18 23:57:41', '2026-05-18 23:57:41'),
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
(5565, 40, 1463, '', 0, 0, 0, 0, '2026-05-19 21:17:31', '2026-05-19 21:17:31');

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
(5, 'HENRRY FERNANDEZ', 'fernandezhenry623@gmail.com', NULL, '$2y$12$KX7YscEohFCoL./ilgezg.W.N491g0BMbAz8j/RL7EqOAQtUB7HHK', NULL, NULL, NULL, NULL, '2026-05-08 17:35:15', '2026-05-08 17:35:15');

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `almacenes`
--
ALTER TABLE `almacenes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `almacen_areas`
--
ALTER TABLE `almacen_areas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `almacen_trampas`
--
ALTER TABLE `almacen_trampas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `almancen_insectocutores`
--
ALTER TABLE `almancen_insectocutores`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `aplicaciones`
--
ALTER TABLE `aplicaciones`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `contrato_detalles`
--
ALTER TABLE `contrato_detalles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=940;

--
-- AUTO_INCREMENT de la tabla `cuentas_cobrar`
--
ALTER TABLE `cuentas_cobrar`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `empresas`
--
ALTER TABLE `empresas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT de la tabla `mapas`
--
ALTER TABLE `mapas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT de la tabla `seguimiento_biologicos`
--
ALTER TABLE `seguimiento_biologicos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `seguimiento_epps`
--
ALTER TABLE `seguimiento_epps`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=407;

--
-- AUTO_INCREMENT de la tabla `seguimiento_especies`
--
ALTER TABLE `seguimiento_especies`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `seguimiento_images`
--
ALTER TABLE `seguimiento_images`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=191;

--
-- AUTO_INCREMENT de la tabla `seguimiento_metodos`
--
ALTER TABLE `seguimiento_metodos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=123;

--
-- AUTO_INCREMENT de la tabla `seguimiento_protecciones`
--
ALTER TABLE `seguimiento_protecciones`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=166;

--
-- AUTO_INCREMENT de la tabla `seguimiento_signos`
--
ALTER TABLE `seguimiento_signos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1712;

--
-- AUTO_INCREMENT de la tabla `trampa_especie_seguimientos`
--
ALTER TABLE `trampa_especie_seguimientos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=98;

--
-- AUTO_INCREMENT de la tabla `trampa_roedor_seguimientos`
--
ALTER TABLE `trampa_roedor_seguimientos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5566;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `usuario_empresas`
--
ALTER TABLE `usuario_empresas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

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
