-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 02-03-2026 a las 13:06:45
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
(1, 1, 'PLANTA VILLA FATIMA', 'CALLE SANTA ROSA NRO. 471 VILLA FATIMA', 'FRANKLIN CHAVEZ', '70103966', 'jessica_escobar@lacascada.com.bo', 'LA PAZ', '2026-02-13 21:15:29', '2026-02-13 21:15:29'),
(2, 2, 'DISTRIBUIDORA LLOJETA', 'LLOJETA', 'MIGUEL A VARGAS', '69722558', 'jessica_escobar@lacascada.com.bo', 'LA PAZ', '2026-02-13 22:34:45', '2026-02-13 22:34:45'),
(3, 3, 'PLANTA VISCACHANI', 'LLOJETA', 'ALDO COLPARI', '69722555', 'jessica_escobar@lacascada.com.bo', 'LA PAZ', '2026-02-13 23:38:01', '2026-02-13 23:38:01'),
(4, 4, 'PLANTA EL ALTO', 'CAMINO A VIACHA', 'PABLO ECHENIQUE', '69722610', 'jessica_escobar@lacascada.com.bo', 'EL ALTO', '2026-02-14 01:17:29', '2026-02-14 01:17:29');

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
(1, 1, NULL, 1950, 4, 0.4, 3120, '2026-02-13 21:15:29', '2026-02-14 01:36:53'),
(2, 2, NULL, 2850, 4, 0.4, 4560, '2026-02-13 22:34:45', '2026-02-14 01:37:30'),
(3, 3, NULL, 2480, 4, 0.4, 3968, '2026-02-13 23:38:01', '2026-02-13 23:38:01'),
(4, 4, NULL, 8500, 4, 0.4, 13600, '2026-02-14 01:17:29', '2026-02-14 01:38:00');

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
(1, 1, NULL, 77, 24, 6, 11088, '2026-02-13 21:15:29', '2026-02-13 21:15:29'),
(2, 2, NULL, 42, 24, 6, 6048, '2026-02-13 22:34:45', '2026-02-13 22:34:45'),
(3, 3, NULL, 29, 24, 6, 4176, '2026-02-13 23:38:01', '2026-02-13 23:38:01'),
(4, 4, NULL, 130, 24, 6, 18720, '2026-02-14 01:17:29', '2026-02-14 01:17:29');

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
(1, 1, NULL, 1, 24, 10, 240, '2026-02-13 21:15:29', '2026-02-13 21:15:29'),
(2, 2, NULL, 0, 1, 0, 0, '2026-02-13 22:34:45', '2026-02-13 22:34:45'),
(3, 3, NULL, 1, 24, 10, 240, '2026-02-13 23:38:01', '2026-02-13 23:38:01'),
(4, 4, NULL, 1, 24, 10, 240, '2026-02-14 01:17:29', '2026-02-14 01:17:29');

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
('bolivianpest-cache-45d9d1ce828bb199a81e70ff4c37b106', 'i:1;', 1770815077),
('bolivianpest-cache-45d9d1ce828bb199a81e70ff4c37b106:timer', 'i:1770815077;', 1770815077),
('bolivianpest-cache-8a6e29ef31baaa7dde48d797e626ffc2', 'i:1;', 1769794282),
('bolivianpest-cache-8a6e29ef31baaa7dde48d797e626ffc2:timer', 'i:1769794282;', 1769794282),
('bolivianpest-cache-a6cf3449fbccdc26d9aeadb6f26b8c25', 'i:1;', 1770930223),
('bolivianpest-cache-a6cf3449fbccdc26d9aeadb6f26b8c25:timer', 'i:1770930223;', 1770930223),
('bolivianpest-cache-bcda8ba14702a936a86c58ac90357387', 'i:1;', 1770843768),
('bolivianpest-cache-bcda8ba14702a936a86c58ac90357387:timer', 'i:1770843768;', 1770843768),
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
(1, 1, 14448.00, '2026-12-31', '2026-02-13 21:15:29', '2026-02-14 01:36:53'),
(2, 2, 10608.00, '2026-12-31', '2026-02-13 22:34:44', '2026-02-14 01:37:30'),
(3, 3, 8384.00, '2026-12-31', '2026-02-13 23:38:01', '2026-02-14 01:26:11'),
(4, 4, 32560.00, '2026-12-31', '2026-02-14 01:17:29', '2026-02-14 01:38:00');

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
(1, 1, 'PLANTA VILLA FATIMA', '77', '24', '6', '11088', '1950', '4', '0.4', '3120', '1', '24', '10', '240', 0.00, '2026-02-13 21:15:29', '2026-02-14 01:36:53'),
(2, 2, 'DISTRIBUIDORA LLOJETA', '42', '24', '6', '6048', '2850', '4', '0.4', '4560', '0', '1', '0', '0', 0.00, '2026-02-13 22:34:45', '2026-02-14 01:37:30'),
(3, 3, 'PLANTA VISCACHANI', '29', '24', '6', '4176', '2480', '4', '0.4', '3968', '1', '24', '10', '240', 0.00, '2026-02-13 23:38:01', '2026-02-13 23:38:01'),
(4, 4, 'PLANTA EL ALTO', '130', '24', '6', '18720', '8500', '4', '0.4', '13600', '1', '24', '10', '240', 0.00, '2026-02-14 01:17:29', '2026-02-14 01:38:00');

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
(1, 1, 2, 2, 'Desratización', '2026-01-13', 'bg-yellow-500', 'completado', '2026-02-13 21:15:29', '2026-02-13 21:16:39'),
(2, 1, 2, 2, 'Desratización', '2026-01-30', 'bg-yellow-500', 'completado', '2026-02-13 21:15:29', '2026-02-13 21:17:06'),
(3, 1, 2, 2, 'Desratización', '2026-02-12', 'bg-yellow-500', 'completado', '2026-02-13 21:15:29', '2026-02-13 21:17:33'),
(4, 1, 2, 2, 'Desratización', '2026-02-26', 'bg-yellow-500', 'pendiente', '2026-02-13 21:15:29', '2026-02-13 21:15:29'),
(5, 1, 2, 2, 'Desratización', '2026-03-12', 'bg-yellow-500', 'pendiente', '2026-02-13 21:15:29', '2026-02-13 21:15:29'),
(6, 1, 2, 2, 'Desratización', '2026-03-26', 'bg-yellow-500', 'pendiente', '2026-02-13 21:15:29', '2026-02-13 21:15:29'),
(7, 1, 2, 2, 'Desratización', '2026-04-09', 'bg-yellow-500', 'pendiente', '2026-02-13 21:15:29', '2026-02-13 21:15:29'),
(8, 1, 2, 2, 'Desratización', '2026-04-23', 'bg-yellow-500', 'pendiente', '2026-02-13 21:15:30', '2026-02-13 21:15:30'),
(9, 1, 2, 2, 'Desratización', '2026-05-07', 'bg-yellow-500', 'pendiente', '2026-02-13 21:15:30', '2026-02-13 21:15:30'),
(10, 1, 2, 2, 'Desratización', '2026-05-21', 'bg-yellow-500', 'pendiente', '2026-02-13 21:15:30', '2026-02-13 21:15:30'),
(11, 1, 2, 2, 'Desratización', '2026-06-11', 'bg-yellow-500', 'pendiente', '2026-02-13 21:15:30', '2026-02-13 21:15:30'),
(12, 1, 2, 2, 'Desratización', '2026-06-25', 'bg-yellow-500', 'pendiente', '2026-02-13 21:15:30', '2026-02-13 21:15:30'),
(13, 1, 2, 2, 'Desratización', '2026-07-09', 'bg-yellow-500', 'pendiente', '2026-02-13 21:15:30', '2026-02-13 21:15:30'),
(14, 1, 2, 2, 'Desratización', '2026-07-23', 'bg-yellow-500', 'pendiente', '2026-02-13 21:15:30', '2026-02-13 21:15:30'),
(15, 1, 2, 2, 'Desratización', '2026-08-05', 'bg-yellow-500', 'pendiente', '2026-02-13 21:15:30', '2026-02-13 21:15:30'),
(16, 1, 2, 2, 'Desratización', '2026-08-20', 'bg-yellow-500', 'pendiente', '2026-02-13 21:15:30', '2026-02-13 21:15:30'),
(17, 1, 2, 2, 'Desratización', '2026-09-10', 'bg-yellow-500', 'pendiente', '2026-02-13 21:15:30', '2026-02-13 21:15:30'),
(18, 1, 2, 2, 'Desratización', '2026-09-24', 'bg-yellow-500', 'pendiente', '2026-02-13 21:15:30', '2026-02-13 21:15:30'),
(19, 1, 2, 2, 'Desratización', '2026-10-08', 'bg-yellow-500', 'pendiente', '2026-02-13 21:15:30', '2026-02-13 21:15:30'),
(20, 1, 2, 2, 'Desratización', '2026-10-22', 'bg-yellow-500', 'pendiente', '2026-02-13 21:15:30', '2026-02-13 21:15:30'),
(21, 1, 2, 2, 'Desratización', '2026-11-12', 'bg-yellow-500', 'pendiente', '2026-02-13 21:15:30', '2026-02-13 21:15:30'),
(22, 1, 2, 2, 'Desratización', '2026-11-26', 'bg-yellow-500', 'pendiente', '2026-02-13 21:15:30', '2026-02-13 21:15:30'),
(23, 1, 2, 2, 'Desratización', '2026-12-09', 'bg-yellow-500', 'pendiente', '2026-02-13 21:15:30', '2026-02-13 21:15:30'),
(24, 1, 2, 2, 'Desratización', '2026-12-23', 'bg-yellow-500', 'pendiente', '2026-02-13 21:15:30', '2026-02-13 21:15:30'),
(25, 1, 2, 2, 'Fumigación', '2026-02-21', 'bg-blue-500', 'pendiente', '2026-02-13 21:15:30', '2026-02-13 21:15:30'),
(26, 1, 2, 2, 'Fumigación', '2026-05-23', 'bg-blue-500', 'pendiente', '2026-02-13 21:15:30', '2026-02-13 21:15:30'),
(27, 1, 2, 2, 'Fumigación', '2026-08-22', 'bg-blue-500', 'pendiente', '2026-02-13 21:15:30', '2026-02-13 21:15:30'),
(28, 1, 2, 2, 'Fumigación', '2026-11-21', 'bg-blue-500', 'pendiente', '2026-02-13 21:15:30', '2026-02-13 21:15:30'),
(29, 1, 2, 2, 'Insectocutores', '2026-01-13', 'bg-pink-600', 'completado', '2026-02-13 21:15:30', '2026-02-13 21:16:56'),
(30, 1, 2, 2, 'Insectocutores', '2026-01-30', 'bg-pink-600', 'completado', '2026-02-13 21:15:30', '2026-02-13 21:17:18'),
(31, 1, 2, 2, 'Insectocutores', '2026-02-12', 'bg-pink-600', 'completado', '2026-02-13 21:15:30', '2026-02-13 21:18:02'),
(32, 1, 2, 2, 'Insectocutores', '2026-02-26', 'bg-pink-600', 'pendiente', '2026-02-13 21:15:30', '2026-02-13 21:15:30'),
(33, 1, 2, 2, 'Insectocutores', '2026-03-12', 'bg-pink-600', 'pendiente', '2026-02-13 21:15:31', '2026-02-13 21:15:31'),
(34, 1, 2, 2, 'Insectocutores', '2026-03-26', 'bg-pink-600', 'pendiente', '2026-02-13 21:15:31', '2026-02-13 21:15:31'),
(35, 1, 2, 2, 'Insectocutores', '2026-04-09', 'bg-pink-600', 'pendiente', '2026-02-13 21:15:31', '2026-02-13 21:15:31'),
(36, 1, 2, 2, 'Insectocutores', '2026-04-23', 'bg-pink-600', 'pendiente', '2026-02-13 21:15:31', '2026-02-13 21:15:31'),
(37, 1, 2, 2, 'Insectocutores', '2026-05-07', 'bg-pink-600', 'pendiente', '2026-02-13 21:15:31', '2026-02-13 21:15:31'),
(38, 1, 2, 2, 'Insectocutores', '2026-05-21', 'bg-pink-600', 'pendiente', '2026-02-13 21:15:31', '2026-02-13 21:15:31'),
(39, 1, 2, 2, 'Insectocutores', '2026-06-11', 'bg-pink-600', 'pendiente', '2026-02-13 21:15:31', '2026-02-13 21:15:31'),
(40, 1, 2, 2, 'Insectocutores', '2026-06-25', 'bg-pink-600', 'pendiente', '2026-02-13 21:15:31', '2026-02-13 21:15:31'),
(41, 1, 2, 2, 'Insectocutores', '2026-07-09', 'bg-pink-600', 'pendiente', '2026-02-13 21:15:31', '2026-02-13 21:15:31'),
(42, 1, 2, 2, 'Insectocutores', '2026-07-23', 'bg-pink-600', 'pendiente', '2026-02-13 21:15:31', '2026-02-13 21:15:31'),
(43, 1, 2, 2, 'Insectocutores', '2026-08-05', 'bg-pink-600', 'pendiente', '2026-02-13 21:15:31', '2026-02-13 21:15:31'),
(44, 1, 2, 2, 'Insectocutores', '2026-08-20', 'bg-pink-600', 'pendiente', '2026-02-13 21:15:31', '2026-02-13 21:15:31'),
(45, 1, 2, 2, 'Insectocutores', '2026-09-10', 'bg-pink-600', 'pendiente', '2026-02-13 21:15:31', '2026-02-13 21:15:31'),
(46, 1, 2, 2, 'Insectocutores', '2026-09-24', 'bg-pink-600', 'pendiente', '2026-02-13 21:15:31', '2026-02-13 21:15:31'),
(47, 1, 2, 2, 'Insectocutores', '2026-10-08', 'bg-pink-600', 'pendiente', '2026-02-13 21:15:31', '2026-02-13 21:15:31'),
(48, 1, 2, 2, 'Insectocutores', '2026-10-22', 'bg-pink-600', 'pendiente', '2026-02-13 21:15:31', '2026-02-13 21:15:31'),
(49, 1, 2, 2, 'Insectocutores', '2026-11-12', 'bg-pink-600', 'pendiente', '2026-02-13 21:15:31', '2026-02-13 21:15:31'),
(50, 1, 2, 2, 'Insectocutores', '2026-11-26', 'bg-pink-600', 'pendiente', '2026-02-13 21:15:31', '2026-02-13 21:15:31'),
(51, 1, 2, 2, 'Insectocutores', '2026-12-09', 'bg-pink-600', 'pendiente', '2026-02-13 21:15:31', '2026-02-13 21:15:31'),
(52, 1, 2, 2, 'Insectocutores', '2026-12-23', 'bg-pink-600', 'pendiente', '2026-02-13 21:15:31', '2026-02-13 21:15:31'),
(53, 2, 2, 2, 'Desratización', '2026-01-13', 'bg-yellow-500', 'pendiente', '2026-02-13 22:34:45', '2026-02-13 22:34:45'),
(54, 2, 2, 2, 'Desratización', '2026-01-30', 'bg-yellow-500', 'pendiente', '2026-02-13 22:34:45', '2026-02-13 22:34:45'),
(55, 2, 2, 2, 'Desratización', '2026-02-12', 'bg-yellow-500', 'pendiente', '2026-02-13 22:34:45', '2026-02-13 22:34:45'),
(56, 2, 2, 2, 'Desratización', '2026-02-26', 'bg-yellow-500', 'pendiente', '2026-02-13 22:34:45', '2026-02-13 22:34:45'),
(57, 2, 2, 2, 'Desratización', '2026-03-12', 'bg-yellow-500', 'pendiente', '2026-02-13 22:34:45', '2026-02-13 22:34:45'),
(58, 2, 2, 2, 'Desratización', '2026-03-26', 'bg-yellow-500', 'pendiente', '2026-02-13 22:34:45', '2026-02-13 22:34:45'),
(59, 2, 2, 2, 'Desratización', '2026-04-09', 'bg-yellow-500', 'pendiente', '2026-02-13 22:34:45', '2026-02-13 22:34:45'),
(60, 2, 2, 2, 'Desratización', '2026-04-23', 'bg-yellow-500', 'pendiente', '2026-02-13 22:34:45', '2026-02-13 22:34:45'),
(61, 2, 2, 2, 'Desratización', '2026-05-07', 'bg-yellow-500', 'pendiente', '2026-02-13 22:34:45', '2026-02-13 22:34:45'),
(62, 2, 2, 2, 'Desratización', '2026-05-21', 'bg-yellow-500', 'pendiente', '2026-02-13 22:34:45', '2026-02-13 22:34:45'),
(63, 2, 2, 2, 'Desratización', '2026-06-11', 'bg-yellow-500', 'pendiente', '2026-02-13 22:34:45', '2026-02-13 22:34:45'),
(64, 2, 2, 2, 'Desratización', '2026-06-25', 'bg-yellow-500', 'pendiente', '2026-02-13 22:34:45', '2026-02-13 22:34:45'),
(65, 2, 2, 2, 'Desratización', '2026-07-09', 'bg-yellow-500', 'pendiente', '2026-02-13 22:34:45', '2026-02-13 22:34:45'),
(66, 2, 2, 2, 'Desratización', '2026-07-23', 'bg-yellow-500', 'pendiente', '2026-02-13 22:34:45', '2026-02-13 22:34:45'),
(67, 2, 2, 2, 'Desratización', '2026-08-05', 'bg-yellow-500', 'pendiente', '2026-02-13 22:34:45', '2026-02-13 22:34:45'),
(68, 2, 2, 2, 'Desratización', '2026-08-20', 'bg-yellow-500', 'pendiente', '2026-02-13 22:34:45', '2026-02-13 22:34:45'),
(69, 2, 2, 2, 'Desratización', '2026-09-10', 'bg-yellow-500', 'pendiente', '2026-02-13 22:34:45', '2026-02-13 22:34:45'),
(70, 2, 2, 2, 'Desratización', '2026-09-24', 'bg-yellow-500', 'pendiente', '2026-02-13 22:34:45', '2026-02-13 22:34:45'),
(71, 2, 2, 2, 'Desratización', '2026-10-08', 'bg-yellow-500', 'pendiente', '2026-02-13 22:34:45', '2026-02-13 22:34:45'),
(72, 2, 2, 2, 'Desratización', '2026-10-22', 'bg-yellow-500', 'pendiente', '2026-02-13 22:34:45', '2026-02-13 22:34:45'),
(73, 2, 2, 2, 'Desratización', '2026-11-12', 'bg-yellow-500', 'pendiente', '2026-02-13 22:34:46', '2026-02-13 22:34:46'),
(74, 2, 2, 2, 'Desratización', '2026-11-26', 'bg-yellow-500', 'pendiente', '2026-02-13 22:34:46', '2026-02-13 22:34:46'),
(75, 2, 2, 2, 'Desratización', '2026-12-09', 'bg-yellow-500', 'pendiente', '2026-02-13 22:34:46', '2026-02-13 22:34:46'),
(76, 2, 2, 2, 'Desratización', '2026-12-23', 'bg-yellow-500', 'pendiente', '2026-02-13 22:34:46', '2026-02-13 22:34:46'),
(77, 2, 2, 2, 'Fumigación', '2026-01-17', 'bg-blue-500', 'pendiente', '2026-02-13 22:34:46', '2026-02-13 22:34:46'),
(78, 2, 2, 2, 'Fumigación', '2026-04-18', 'bg-blue-500', 'pendiente', '2026-02-13 22:34:46', '2026-02-13 22:34:46'),
(79, 2, 2, 2, 'Fumigación', '2026-07-18', 'bg-blue-500', 'pendiente', '2026-02-13 22:34:46', '2026-02-13 22:34:46'),
(80, 2, 2, 2, 'Fumigación', '2026-10-24', 'bg-blue-500', 'pendiente', '2026-02-13 22:34:46', '2026-02-13 22:34:46'),
(81, 2, 2, 2, 'Insectocutores', '2026-01-13', 'bg-pink-600', 'pendiente', '2026-02-13 22:34:46', '2026-02-13 22:34:46'),
(82, 3, 2, 2, 'Desratización', '2026-01-14', 'bg-yellow-500', 'pendiente', '2026-02-13 23:38:01', '2026-02-13 23:38:01'),
(83, 3, 2, 2, 'Desratización', '2026-01-24', 'bg-yellow-500', 'pendiente', '2026-02-13 23:38:01', '2026-02-13 23:38:01'),
(84, 3, 2, 2, 'Desratización', '2026-02-07', 'bg-yellow-500', 'pendiente', '2026-02-13 23:38:01', '2026-02-13 23:38:01'),
(85, 3, 2, 2, 'Desratización', '2026-02-17', 'bg-yellow-500', 'pendiente', '2026-02-13 23:38:01', '2026-02-13 23:38:01'),
(86, 3, 2, 2, 'Desratización', '2026-03-11', 'bg-yellow-500', 'pendiente', '2026-02-13 23:38:01', '2026-02-13 23:38:01'),
(87, 3, 2, 2, 'Desratización', '2026-03-25', 'bg-yellow-500', 'pendiente', '2026-02-13 23:38:01', '2026-02-13 23:38:01'),
(88, 3, 2, 2, 'Desratización', '2026-04-14', 'bg-yellow-500', 'pendiente', '2026-02-13 23:38:01', '2026-02-13 23:38:01'),
(89, 3, 2, 2, 'Desratización', '2026-04-28', 'bg-yellow-500', 'pendiente', '2026-02-13 23:38:02', '2026-02-13 23:38:02'),
(90, 3, 2, 2, 'Desratización', '2026-05-02', 'bg-yellow-500', 'pendiente', '2026-02-13 23:38:02', '2026-02-13 23:38:02'),
(91, 3, 2, 2, 'Desratización', '2026-05-19', 'bg-yellow-500', 'pendiente', '2026-02-13 23:38:02', '2026-02-13 23:38:02'),
(92, 3, 2, 2, 'Desratización', '2026-06-10', 'bg-yellow-500', 'pendiente', '2026-02-13 23:38:02', '2026-02-13 23:38:02'),
(93, 3, 2, 2, 'Desratización', '2026-06-24', 'bg-yellow-500', 'pendiente', '2026-02-13 23:38:02', '2026-02-13 23:38:02'),
(94, 3, 2, 2, 'Desratización', '2026-07-08', 'bg-yellow-500', 'pendiente', '2026-02-13 23:38:02', '2026-02-13 23:38:02'),
(95, 3, 2, 2, 'Desratización', '2026-07-22', 'bg-yellow-500', 'pendiente', '2026-02-13 23:38:02', '2026-02-13 23:38:02'),
(96, 3, 2, 2, 'Desratización', '2026-08-01', 'bg-yellow-500', 'pendiente', '2026-02-13 23:38:02', '2026-02-13 23:38:02'),
(97, 3, 2, 2, 'Desratización', '2026-08-18', 'bg-yellow-500', 'pendiente', '2026-02-13 23:38:02', '2026-02-13 23:38:02'),
(98, 3, 2, 2, 'Desratización', '2026-09-09', 'bg-yellow-500', 'pendiente', '2026-02-13 23:38:02', '2026-02-13 23:38:02'),
(99, 3, 2, 2, 'Desratización', '2026-09-23', 'bg-yellow-500', 'pendiente', '2026-02-13 23:38:02', '2026-02-13 23:38:02'),
(100, 3, 2, 2, 'Desratización', '2026-10-07', 'bg-yellow-500', 'pendiente', '2026-02-13 23:38:02', '2026-02-13 23:38:02'),
(101, 3, 2, 2, 'Desratización', '2026-10-21', 'bg-yellow-500', 'pendiente', '2026-02-13 23:38:02', '2026-02-13 23:38:02'),
(102, 3, 2, 2, 'Desratización', '2026-11-07', 'bg-yellow-500', 'pendiente', '2026-02-13 23:38:02', '2026-02-13 23:38:02'),
(103, 3, 2, 2, 'Desratización', '2026-11-24', 'bg-yellow-500', 'pendiente', '2026-02-13 23:38:02', '2026-02-13 23:38:02'),
(104, 3, 2, 2, 'Desratización', '2026-12-08', 'bg-yellow-500', 'pendiente', '2026-02-13 23:38:02', '2026-02-13 23:38:02'),
(105, 3, 2, 2, 'Desratización', '2026-12-22', 'bg-yellow-500', 'pendiente', '2026-02-13 23:38:02', '2026-02-13 23:38:02'),
(106, 3, 2, 2, 'Fumigación', '2026-01-24', 'bg-blue-500', 'pendiente', '2026-02-13 23:38:02', '2026-02-13 23:38:02'),
(107, 3, 2, 2, 'Fumigación', '2026-05-02', 'bg-blue-500', 'pendiente', '2026-02-13 23:38:02', '2026-02-13 23:38:02'),
(108, 3, 2, 2, 'Fumigación', '2026-08-01', 'bg-blue-500', 'pendiente', '2026-02-13 23:38:02', '2026-02-13 23:38:02'),
(109, 3, 2, 2, 'Fumigación', '2026-11-07', 'bg-blue-500', 'pendiente', '2026-02-13 23:38:02', '2026-02-13 23:38:02'),
(110, 3, 2, 2, 'Insectocutores', '2026-01-14', 'bg-pink-600', 'pendiente', '2026-02-13 23:38:02', '2026-02-13 23:38:02'),
(111, 3, 2, 2, 'Insectocutores', '2026-01-24', 'bg-pink-600', 'pendiente', '2026-02-13 23:38:02', '2026-02-13 23:38:02'),
(112, 3, 2, 2, 'Insectocutores', '2026-02-07', 'bg-pink-600', 'pendiente', '2026-02-13 23:38:02', '2026-02-13 23:38:02'),
(113, 3, 2, 2, 'Insectocutores', '2026-02-20', 'bg-pink-600', 'pendiente', '2026-02-13 23:38:02', '2026-02-13 23:38:02'),
(114, 3, 2, 2, 'Insectocutores', '2026-03-11', 'bg-pink-600', 'pendiente', '2026-02-13 23:38:03', '2026-02-13 23:38:03'),
(115, 3, 2, 2, 'Insectocutores', '2026-03-25', 'bg-pink-600', 'pendiente', '2026-02-13 23:38:03', '2026-02-13 23:38:03'),
(116, 3, 2, 2, 'Insectocutores', '2026-04-14', 'bg-pink-600', 'pendiente', '2026-02-13 23:38:03', '2026-02-13 23:38:03'),
(117, 3, 2, 2, 'Insectocutores', '2026-04-28', 'bg-pink-600', 'pendiente', '2026-02-13 23:38:03', '2026-02-13 23:38:03'),
(118, 3, 2, 2, 'Insectocutores', '2026-05-02', 'bg-pink-600', 'pendiente', '2026-02-13 23:38:03', '2026-02-13 23:38:03'),
(119, 3, 2, 2, 'Insectocutores', '2026-05-19', 'bg-pink-600', 'pendiente', '2026-02-13 23:38:03', '2026-02-13 23:38:03'),
(120, 3, 2, 2, 'Insectocutores', '2026-06-10', 'bg-pink-600', 'pendiente', '2026-02-13 23:38:03', '2026-02-13 23:38:03'),
(121, 3, 2, 2, 'Insectocutores', '2026-06-24', 'bg-pink-600', 'pendiente', '2026-02-13 23:38:03', '2026-02-13 23:38:03'),
(122, 3, 2, 2, 'Insectocutores', '2026-07-08', 'bg-pink-600', 'pendiente', '2026-02-13 23:38:03', '2026-02-13 23:38:03'),
(123, 3, 2, 2, 'Insectocutores', '2026-07-22', 'bg-pink-600', 'pendiente', '2026-02-13 23:38:03', '2026-02-13 23:38:03'),
(124, 3, 2, 2, 'Insectocutores', '2026-08-01', 'bg-pink-600', 'pendiente', '2026-02-13 23:38:03', '2026-02-13 23:38:03'),
(125, 3, 2, 2, 'Insectocutores', '2026-08-18', 'bg-pink-600', 'pendiente', '2026-02-13 23:38:03', '2026-02-13 23:38:03'),
(126, 3, 2, 2, 'Insectocutores', '2026-09-09', 'bg-pink-600', 'pendiente', '2026-02-13 23:38:03', '2026-02-13 23:38:03'),
(127, 3, 2, 2, 'Insectocutores', '2026-09-23', 'bg-pink-600', 'pendiente', '2026-02-13 23:38:03', '2026-02-13 23:38:03'),
(128, 3, 2, 2, 'Insectocutores', '2026-10-07', 'bg-pink-600', 'pendiente', '2026-02-13 23:38:03', '2026-02-13 23:38:03'),
(129, 3, 2, 2, 'Insectocutores', '2026-10-21', 'bg-pink-600', 'pendiente', '2026-02-13 23:38:03', '2026-02-13 23:38:03'),
(130, 3, 2, 2, 'Insectocutores', '2026-11-07', 'bg-pink-600', 'pendiente', '2026-02-13 23:38:03', '2026-02-13 23:38:03'),
(131, 3, 2, 2, 'Insectocutores', '2026-11-24', 'bg-pink-600', 'pendiente', '2026-02-13 23:38:03', '2026-02-13 23:38:03'),
(132, 3, 2, 2, 'Insectocutores', '2026-12-08', 'bg-pink-600', 'pendiente', '2026-02-13 23:38:03', '2026-02-13 23:38:03'),
(133, 3, 2, 2, 'Insectocutores', '2026-12-22', 'bg-pink-600', 'pendiente', '2026-02-13 23:38:03', '2026-02-13 23:38:03'),
(134, 4, 2, 2, 'Desratización', '2026-01-17', 'bg-yellow-500', 'pendiente', '2026-02-14 01:17:29', '2026-02-14 01:17:29'),
(135, 4, 2, 2, 'Desratización', '2026-01-31', 'bg-yellow-500', 'pendiente', '2026-02-14 01:17:29', '2026-02-14 01:17:29'),
(136, 4, 2, 2, 'Desratización', '2026-02-13', 'bg-yellow-500', 'pendiente', '2026-02-14 01:17:29', '2026-02-14 01:17:29'),
(137, 4, 2, 2, 'Desratización', '2026-02-27', 'bg-yellow-500', 'pendiente', '2026-02-14 01:17:29', '2026-02-14 01:17:29'),
(138, 4, 2, 2, 'Desratización', '2026-03-13', 'bg-yellow-500', 'pendiente', '2026-02-14 01:17:29', '2026-02-14 01:17:29'),
(139, 4, 2, 2, 'Desratización', '2026-03-27', 'bg-yellow-500', 'pendiente', '2026-02-14 01:17:29', '2026-02-14 01:17:29'),
(140, 4, 2, 2, 'Desratización', '2026-04-10', 'bg-yellow-500', 'pendiente', '2026-02-14 01:17:29', '2026-02-14 01:17:29'),
(141, 4, 2, 2, 'Desratización', '2026-04-24', 'bg-yellow-500', 'pendiente', '2026-02-14 01:17:29', '2026-02-14 01:17:29'),
(142, 4, 2, 2, 'Desratización', '2026-05-08', 'bg-yellow-500', 'pendiente', '2026-02-14 01:17:29', '2026-02-14 01:17:29'),
(143, 4, 2, 2, 'Desratización', '2026-05-22', 'bg-yellow-500', 'pendiente', '2026-02-14 01:17:29', '2026-02-14 01:17:29'),
(144, 4, 2, 2, 'Desratización', '2026-06-12', 'bg-yellow-500', 'pendiente', '2026-02-14 01:17:29', '2026-02-14 01:17:29'),
(145, 4, 2, 2, 'Desratización', '2026-06-26', 'bg-yellow-500', 'pendiente', '2026-02-14 01:17:29', '2026-02-14 01:17:29'),
(146, 4, 2, 2, 'Desratización', '2026-07-10', 'bg-yellow-500', 'pendiente', '2026-02-14 01:17:29', '2026-02-14 01:17:29'),
(147, 4, 2, 2, 'Desratización', '2026-07-24', 'bg-yellow-500', 'pendiente', '2026-02-14 01:17:29', '2026-02-14 01:17:29'),
(148, 4, 2, 2, 'Desratización', '2026-08-07', 'bg-yellow-500', 'pendiente', '2026-02-14 01:17:29', '2026-02-14 01:17:29'),
(149, 4, 2, 2, 'Desratización', '2026-08-21', 'bg-yellow-500', 'pendiente', '2026-02-14 01:17:29', '2026-02-14 01:17:29'),
(150, 4, 2, 2, 'Desratización', '2026-09-11', 'bg-yellow-500', 'pendiente', '2026-02-14 01:17:29', '2026-02-14 01:17:29'),
(151, 4, 2, 2, 'Desratización', '2026-09-25', 'bg-yellow-500', 'pendiente', '2026-02-14 01:17:29', '2026-02-14 01:17:29'),
(152, 4, 2, 2, 'Desratización', '2026-10-09', 'bg-yellow-500', 'pendiente', '2026-02-14 01:17:29', '2026-02-14 01:17:29'),
(153, 4, 2, 2, 'Desratización', '2026-10-23', 'bg-yellow-500', 'pendiente', '2026-02-14 01:17:30', '2026-02-14 01:17:30'),
(154, 4, 2, 2, 'Desratización', '2026-11-13', 'bg-yellow-500', 'pendiente', '2026-02-14 01:17:30', '2026-02-14 01:17:30'),
(155, 4, 2, 2, 'Desratización', '2026-11-27', 'bg-yellow-500', 'pendiente', '2026-02-14 01:17:30', '2026-02-14 01:17:30'),
(156, 4, 2, 2, 'Desratización', '2026-12-10', 'bg-yellow-500', 'pendiente', '2026-02-14 01:17:30', '2026-02-14 01:17:30'),
(157, 4, 2, 2, 'Desratización', '2026-12-24', 'bg-yellow-500', 'pendiente', '2026-02-14 01:17:30', '2026-02-14 01:17:30'),
(158, 4, 2, 2, 'Fumigación', '2026-02-28', 'bg-blue-500', 'pendiente', '2026-02-14 01:17:30', '2026-02-14 01:17:30'),
(159, 4, 2, 2, 'Fumigación', '2026-05-30', 'bg-blue-500', 'pendiente', '2026-02-14 01:17:30', '2026-02-14 01:17:30'),
(160, 4, 2, 2, 'Fumigación', '2026-08-29', 'bg-blue-500', 'pendiente', '2026-02-14 01:17:30', '2026-02-14 01:17:30'),
(161, 4, 2, 2, 'Fumigación', '2026-11-28', 'bg-blue-500', 'pendiente', '2026-02-14 01:17:30', '2026-02-14 01:17:30'),
(162, 4, 2, 2, 'Insectocutores', '2026-01-17', 'bg-pink-600', 'pendiente', '2026-02-14 01:17:30', '2026-02-14 01:17:30'),
(163, 4, 2, 2, 'Insectocutores', '2026-01-31', 'bg-pink-600', 'pendiente', '2026-02-14 01:17:30', '2026-02-14 01:17:30'),
(164, 4, 2, 2, 'Insectocutores', '2026-02-13', 'bg-pink-600', 'pendiente', '2026-02-14 01:17:30', '2026-02-14 01:17:30'),
(165, 4, 2, 2, 'Insectocutores', '2026-02-27', 'bg-pink-600', 'pendiente', '2026-02-14 01:17:30', '2026-02-14 01:17:30'),
(166, 4, 2, 2, 'Insectocutores', '2026-03-13', 'bg-pink-600', 'pendiente', '2026-02-14 01:17:30', '2026-02-14 01:17:30'),
(167, 4, 2, 2, 'Insectocutores', '2026-03-27', 'bg-pink-600', 'pendiente', '2026-02-14 01:17:30', '2026-02-14 01:17:30'),
(168, 4, 2, 2, 'Insectocutores', '2026-04-10', 'bg-pink-600', 'pendiente', '2026-02-14 01:17:30', '2026-02-14 01:17:30'),
(169, 4, 2, 2, 'Insectocutores', '2026-04-24', 'bg-pink-600', 'pendiente', '2026-02-14 01:17:30', '2026-02-14 01:17:30'),
(170, 4, 2, 2, 'Insectocutores', '2026-05-08', 'bg-pink-600', 'pendiente', '2026-02-14 01:17:30', '2026-02-14 01:17:30'),
(171, 4, 2, 2, 'Insectocutores', '2026-05-22', 'bg-pink-600', 'pendiente', '2026-02-14 01:17:30', '2026-02-14 01:17:30'),
(172, 4, 2, 2, 'Insectocutores', '2026-06-12', 'bg-pink-600', 'pendiente', '2026-02-14 01:17:30', '2026-02-14 01:17:30'),
(173, 4, 2, 2, 'Insectocutores', '2026-06-25', 'bg-pink-600', 'pendiente', '2026-02-14 01:17:30', '2026-02-14 01:17:30'),
(174, 4, 2, 2, 'Insectocutores', '2026-07-10', 'bg-pink-600', 'pendiente', '2026-02-14 01:17:30', '2026-02-14 01:17:30'),
(175, 4, 2, 2, 'Insectocutores', '2026-07-24', 'bg-pink-600', 'pendiente', '2026-02-14 01:17:30', '2026-02-14 01:17:30'),
(176, 4, 2, 2, 'Insectocutores', '2026-08-07', 'bg-pink-600', 'pendiente', '2026-02-14 01:17:30', '2026-02-14 01:17:30'),
(177, 4, 2, 2, 'Insectocutores', '2026-08-21', 'bg-pink-600', 'pendiente', '2026-02-14 01:17:31', '2026-02-14 01:17:31'),
(178, 4, 2, 2, 'Insectocutores', '2026-09-09', 'bg-pink-600', 'pendiente', '2026-02-14 01:17:31', '2026-02-14 01:17:31'),
(179, 4, 2, 2, 'Insectocutores', '2026-09-25', 'bg-pink-600', 'pendiente', '2026-02-14 01:17:31', '2026-02-14 01:17:31'),
(180, 4, 2, 2, 'Insectocutores', '2026-10-09', 'bg-pink-600', 'pendiente', '2026-02-14 01:17:31', '2026-02-14 01:17:31'),
(181, 4, 2, 2, 'Insectocutores', '2026-10-23', 'bg-pink-600', 'pendiente', '2026-02-14 01:17:31', '2026-02-14 01:17:31'),
(182, 4, 2, 2, 'Insectocutores', '2026-11-13', 'bg-pink-600', 'pendiente', '2026-02-14 01:17:31', '2026-02-14 01:17:31'),
(183, 4, 2, 2, 'Insectocutores', '2026-11-27', 'bg-pink-600', 'pendiente', '2026-02-14 01:17:31', '2026-02-14 01:17:31'),
(184, 4, 2, 2, 'Insectocutores', '2026-12-10', 'bg-pink-600', 'pendiente', '2026-02-14 01:17:31', '2026-02-14 01:17:31'),
(185, 4, 2, 2, 'Insectocutores', '2026-12-24', 'bg-pink-600', 'pendiente', '2026-02-14 01:17:31', '2026-02-14 01:17:31');

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
(1, NULL, 1, NULL, 2, 'Contrato por cobrar #1', 'Saldo pendiento por cobrar sobre contrato', 14448, 14448, 'Pendiente', NULL, 0, '2026-02-13 21:15:31', '2026-02-14 01:36:53'),
(2, NULL, 2, NULL, 2, 'Contrato por cobrar #2', 'Saldo pendiento por cobrar sobre contrato', 10608, 10608, 'Pendiente', NULL, 0, '2026-02-13 22:34:46', '2026-02-14 01:37:30'),
(3, NULL, 3, NULL, 2, 'Contrato por cobrar #3', 'Saldo pendiento por cobrar sobre contrato', 8384, 8384, 'Pendiente', NULL, 0, '2026-02-13 23:38:03', '2026-02-13 23:38:03'),
(4, NULL, 4, NULL, 2, 'Contrato por cobrar #4', 'Saldo pendiento por cobrar sobre contrato', 32560, 32560, 'Pendiente', NULL, 0, '2026-02-14 01:17:31', '2026-02-14 01:38:00');

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
(1, 'LA CASCADA VF', 'CALLE SANTA ROSA NRO. 471 VILLA FATIMA', '69722664', 'jessica_escobar@lacascada.com.bo', 'la paz', 1, '2026-02-13 21:15:29', '2026-02-14 01:01:54'),
(2, 'LA CASCADA LLOJETA', 'CALLE SANTA ROSA NRO. 471 VILLA FATIMA', '69722664', 'jessica_escobar@lacascada.com.bo', 'la paz', 1, '2026-02-13 22:34:44', '2026-02-14 01:02:11'),
(3, 'LA CASCADA VISCACHANI', 'CALLE SANTA ROSA NRO. 471 VILLA FATIMA', '69722664', 'jessica_escobar@lacascada.com.bo', 'la paz', 1, '2026-02-13 23:38:01', '2026-02-14 01:02:32'),
(4, 'LA CASCADA EA', 'CARRETERA  A VIACHA', '69722664', 'jessica_escobar@lacascada.com.bo', 'EL ALTO', 1, '2026-02-14 01:17:29', '2026-02-14 01:17:29');

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
(1, 1, 1, 2, NULL, 'images/mapas/1_1771023065.png', '2026-02-13 21:33:42', '2026-02-13 21:51:05'),
(2, 1, 1, 2, NULL, 'images/mapas/1_1771023259.png', '2026-02-13 21:54:19', '2026-02-13 21:54:19'),
(3, 1, 1, 2, NULL, 'images/mapas/1_1771023771.png', '2026-02-13 22:02:51', '2026-02-13 22:02:51'),
(4, 2, 2, 2, NULL, 'images/mapas/2_1771026613.png', '2026-02-13 22:50:13', '2026-02-13 22:50:13'),
(5, 2, 2, 2, NULL, 'images/mapas/2_1771026892.png', '2026-02-13 22:54:52', '2026-02-13 22:54:52'),
(6, 3, 3, 2, NULL, 'images/mapas/3_1771030223.png', '2026-02-13 23:50:23', '2026-02-13 23:50:23'),
(7, 4, 4, 2, NULL, 'images/mapas/4_1771039775.png', '2026-02-14 02:29:35', '2026-02-14 02:29:35');

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
(1, 'App\\Models\\User', 1),
(1, 'App\\Models\\User', 2);

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
('2lKLGqOQZ8FhrH5Avt2JJzLPICA0Qk8bofEKC0ga', NULL, '40.77.167.53', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiYUtVVDFVak5oWmt5VVBCRDNzWlY2TEl5S1V5b0R0cmNZMzZCOW96QiI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czo0ODoiaHR0cHM6Ly9ib2xpdmlhbnBlc3QuYml0ZGVzYXJyb2xsby5uZXQvY29udHJhdG9zIjt9czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDQ6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmJpdGRlc2Fycm9sbG8ubmV0L2xvZ2luIjtzOjU6InJvdXRlIjtzOjU6ImxvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1772203578),
('34hdJTuC79vz774fmYCaCw4owokuhwzPt4i7KQG6', NULL, '40.77.167.36', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiaWUzUTdvOFFuaHc5UVU5Zkd1MTVsakd3NjZhOTdjSFFPMWN5SE83USI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czo1NzoiaHR0cHM6Ly9ib2xpdmlhbnBlc3QuYml0ZGVzYXJyb2xsby5uZXQvdHJhbXBhc2VndWltaWVudG9zIjt9czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDQ6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmJpdGRlc2Fycm9sbG8ubmV0L2xvZ2luIjtzOjU6InJvdXRlIjtzOjU6ImxvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1772333470),
('4PwRH0S5yea1KSPZXd6bYJPHhHIHdp3F5e7M4WAa', NULL, '40.77.167.77', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiRnVQRVVIV3RiNDdBdzd6MndXQUVMcGtJN1RyYVFJWFJLVnBwblZaaCI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czo1NzoiaHR0cHM6Ly9ib2xpdmlhbnBlc3QuYml0ZGVzYXJyb2xsby5uZXQvdHJhbXBhc2VndWltaWVudG9zIjt9czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDQ6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmJpdGRlc2Fycm9sbG8ubmV0L2xvZ2luIjtzOjU6InJvdXRlIjtzOjU6ImxvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1772325579),
('87e6xwMoGhkQhYPTxTEaAIgPSCaEi8qfu11vthsW', 2, '177.222.112.216', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiSUk1VFZLVzFMNWZXY05jcE1oaE5TQkgxV1FUcURRNGpJQkw5ZGpFQyI7czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MjtzOjk6Il9wcmV2aW91cyI7YToyOntzOjM6InVybCI7czo0NDoiaHR0cHM6Ly9ib2xpdmlhbnBlc3QuYml0ZGVzYXJyb2xsby5uZXQvbWFwYXMiO3M6NToicm91dGUiO3M6MTE6Im1hcGFzLmluZGV4Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1772377078),
('93x9UFG1feImvT4URuWNHA7iXarcfyYI5pHMHq2K', NULL, '189.28.88.39', 'Mozilla/5.0 (iPhone; CPU iPhone OS 26_2_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/145.0.7632.108 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUVdRVmxXak5mYnd2UDJVenJJeXl5UE1zMVBnWEFtamJKQUppVjZweiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mzg6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmJpdGRlc2Fycm9sbG8ubmV0IjtzOjU6InJvdXRlIjtzOjQ6ImhvbWUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1772211860),
('ALoPx2HyVrXkeTueHVEF39xCt2JtGp2cuGgnC6CV', 2, '181.188.178.193', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiZlliV3hBU0Fwb290dElzZk9jaHV2UnV4c05iWlV1WGNFUXJtZG9hTyI7czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MjtzOjk6Il9wcmV2aW91cyI7YToyOntzOjM6InVybCI7czo0NDoiaHR0cHM6Ly9ib2xpdmlhbnBlc3QuYml0ZGVzYXJyb2xsby5uZXQvbWFwYXMiO3M6NToicm91dGUiO3M6MTE6Im1hcGFzLmluZGV4Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1772260113),
('Bmwr2t2TEnT7HzigLurn8I5sQrUcXEzE1gSUz0Mb', NULL, '52.167.144.193', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWXRhN2tFd09ja1V3eWRaQkFUTWFTRXh5VGJoZ0xPcGF5M0V5SlJRdSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDc6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmJpdGRlc2Fycm9sbG8ubmV0L3JlZ2lzdGVyIjtzOjU6InJvdXRlIjtzOjg6InJlZ2lzdGVyIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1772389021),
('BvZxWDTAu2RwnTCQwSQ8QHrj7Rw3Vr8dm42mf3oJ', NULL, '52.167.144.149', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMmFWRzNTWXdTMDBidXY5OHMxa1dwS281MTRSajhiVWlHZW1OT1Q4MyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDc6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmJpdGRlc2Fycm9sbG8ubmV0L3JlZ2lzdGVyIjtzOjU6InJvdXRlIjtzOjg6InJlZ2lzdGVyIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1772247245),
('cmB2kOLuCLlgDNEKT62g8kcYOQnw6UQiLok5eFPy', NULL, '52.167.144.166', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiMTY4ZEtoeFJZS2JMNXZWZ004WHNNY3B1VG91RGhRMkxiNDU5a0dobCI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czo0ODoiaHR0cHM6Ly9ib2xpdmlhbnBlc3QuYml0ZGVzYXJyb2xsby5uZXQvY29udHJhdG9zIjt9czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDQ6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmJpdGRlc2Fycm9sbG8ubmV0L2xvZ2luIjtzOjU6InJvdXRlIjtzOjU6ImxvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1772199911),
('fYOs7kG0tvYkgbVF8Et6oLLyquios03EEBpeaSL8', NULL, '2800:cd0:166:9605:1:0:6701:510f', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidVF2Y2NpeEpjVkliQjVsY0ZHWXIxSVJ0UlE0YkUxbW9nUXNsRERBSCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mzg6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmJpdGRlc2Fycm9sbG8ubmV0IjtzOjU6InJvdXRlIjtzOjQ6ImhvbWUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1772204914),
('GDBL3Nq8mxIPgwDOp1oCAEgIyVBK6uVq6UYh0SOj', NULL, '40.77.167.235', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiN253dERySHM4MXdVMUhZOTVDZHhhZ3lseXlHM0Y2eWRnRWJoUzAxQSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDc6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmJpdGRlc2Fycm9sbG8ubmV0L3JlZ2lzdGVyIjtzOjU6InJvdXRlIjtzOjg6InJlZ2lzdGVyIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1772331921),
('LRTfkbJ79F73jYyMVTZcnc3DCUP9gFSWoNnXf2Sm', 2, '177.222.112.216', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoieXBhUWdyYUl6eWw5ZkNvQW5oYU1IVkNIUXJFZ1M5RlZ2N1VFQTZWYyI7czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MjtzOjk6Il9wcmV2aW91cyI7YToyOntzOjM6InVybCI7czo0NDoiaHR0cHM6Ly9ib2xpdmlhbnBlc3QuYml0ZGVzYXJyb2xsby5uZXQvbWFwYXMiO3M6NToicm91dGUiO3M6MTE6Im1hcGFzLmluZGV4Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1772418348),
('NANiEZdWKw5ySKwdcvIMdaQOMIgyMAv4Sj8OKnoW', NULL, '181.115.172.247', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWHZsUHRDcmJIYldGRkdGQlZrMHphSTRRcGpYT3o5UU1Gbm1aT3UxMiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mzg6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmJpdGRlc2Fycm9sbG8ubmV0IjtzOjU6InJvdXRlIjtzOjQ6ImhvbWUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1772204718),
('P6U4Ib2u633kCuy216XuUrWJNaw9RMd6kYKUFBdG', NULL, '52.167.144.149', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibjJ5cjJ1RDNNWE9MQVNrS1FMbG1ueEc3a3J0SEtGS1JpaWpkYk5vcCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDQ6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmJpdGRlc2Fycm9sbG8ubmV0L2xvZ2luIjtzOjU6InJvdXRlIjtzOjU6ImxvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1772196525),
('PU8NmJQdbj9wqW5Crt7ajZ4Xe15WezNBUg4RZGYV', 2, '181.188.178.193', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiT3oxMFZYRHJFT0xtWkk2bHFJQ2h0YzFKWkV6aDJWTkhFTTY0RFhxUCI7czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MjtzOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1772214503),
('PxKY2O3Gwb0JpgdPRzWnEayxJPFQ4n5NcY4p1f25', 2, '177.222.112.216', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoib3FHVEViVWpLVzVzQmVaVWdnNjJuaUc1YXYzVDRpc3VLZVlmNXJzOCI7czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MjtzOjk6Il9wcmV2aW91cyI7YToyOntzOjM6InVybCI7czo0NDoiaHR0cHM6Ly9ib2xpdmlhbnBlc3QuYml0ZGVzYXJyb2xsby5uZXQvbWFwYXMiO3M6NToicm91dGUiO3M6MTE6Im1hcGFzLmluZGV4Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1772464766),
('q9gD7t92HKku5hFiObOR0wQFcWDMI8YjH1BLpziR', NULL, '200.105.212.40', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZTRxb0dWWm9BS0xZSmdqQmhkMW84NlN6c1g1RmVTdml1S2Ywd2JiUSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mzg6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmJpdGRlc2Fycm9sbG8ubmV0IjtzOjU6InJvdXRlIjtzOjQ6ImhvbWUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1772206443),
('SaTuVzjOM2qSgCLnKOJc6xcAm9ZBhP5ZaBq17cGz', NULL, '2800:320:c0b7:6300:68d9:1ee2:d1a9:d61e', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoieGdRamdqanh6VHQ3d2t3TzVqY0swUGlVOVJvTnlZaHJ0bVhBVVpjRSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mzg6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmJpdGRlc2Fycm9sbG8ubmV0IjtzOjU6InJvdXRlIjtzOjQ6ImhvbWUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1772204248),
('tpq5fOgd3ZftkPhMLlvqx8jmN7jT7IhEMfz3unPV', NULL, '158.172.153.53', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTjVLeXhKQ0hlbDRvUFp5ZDI3a0V2bzZ2T2h4enZscVNlR0U5OEFyUiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mzg6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmJpdGRlc2Fycm9sbG8ubmV0IjtzOjU6InJvdXRlIjtzOjQ6ImhvbWUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1772288970),
('TqsVc6DduiBkw2t9MhoLYAnzC9imPHk1CnOCpikB', 2, '181.188.178.193', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiZXZwNGxBOG5aTDlvdWVQOGpaS2lnV050YXJxNkFRbUNVY1g5c1JmZCI7czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MjtzOjk6Il9wcmV2aW91cyI7YToyOntzOjM6InVybCI7czo1NzoiaHR0cHM6Ly9ib2xpdmlhbnBlc3QuYml0ZGVzYXJyb2xsby5uZXQvbWFwYXM/YWxtYWNlbl9pZD0yIjtzOjU6InJvdXRlIjtzOjExOiJtYXBhcy5pbmRleCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1772203001),
('U2r01VGcmYfu8rqEz3HR1ihSrbLzBqri4O2z2JMk', NULL, '52.167.144.192', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoibVd1bWIxQzFsaUN5TjdDQmV0WGR4bjF1VXFjTGpoSnh4dGhwcFRaQiI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czo1NzoiaHR0cHM6Ly9ib2xpdmlhbnBlc3QuYml0ZGVzYXJyb2xsby5uZXQvdHJhbXBhc2VndWltaWVudG9zIjt9czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDQ6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmJpdGRlc2Fycm9sbG8ubmV0L2xvZ2luIjtzOjU6InJvdXRlIjtzOjU6ImxvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1772461460),
('UF7aEqRiFJruUKG3cp3am6sHxa2BYViDVXpHPevq', NULL, '40.77.167.55', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoib2dvVlJ3TUl3ZDk1Nk5jTDYwYzJjWWNLU3drOUZNbTBYQm5sYktQYyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDc6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmJpdGRlc2Fycm9sbG8ubmV0L3JlZ2lzdGVyIjtzOjU6InJvdXRlIjtzOjg6InJlZ2lzdGVyIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1772456180),
('vgCZ2PyBafcw8G7tfMoUUzv0eY8l2f2wlzfGGRhD', NULL, '189.28.92.101', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWWwzSmlpaGxUQkNCQnlLMUFqaXJkd05yVTVRTmNDOHVyVGc4NTY0RiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mzg6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmJpdGRlc2Fycm9sbG8ubmV0IjtzOjU6InJvdXRlIjtzOjQ6ImhvbWUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1772205345),
('Y8HRJAa8QGASTz6Yh7kZ9RS3rFiDIKdTCX11dOMh', 2, '177.222.112.216', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZlRmNW5UZ0J6aU9NVklWZzJ6VFdjNTZydHZtVUxwMVRBa1hMWDNjSSI7czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MjtzOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1772327722),
('zPuvsWjNMDuNDR5n4D5lVS4cw0gq1k0hoGvsb1Fu', NULL, '2800:cd0:166:1998:1:0:6298:dd6d', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZmJUdVBzdWtQcXRBNnBXQll4U3owSzFydEJpemEyVktvUTY5WHdTZyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mzg6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmJpdGRlc2Fycm9sbG8ubmV0IjtzOjU6InJvdXRlIjtzOjQ6ImhvbWUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1772204569),
('zY3GuSGZSwYjpFvAhxlG1X7CvtOJgokMEF8aQGwk', 2, '177.222.112.216', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiekdoaFhkUnpGY1p0R0pHNjFLQ3FneW1NQ1dKQlhFSHdOTGNLZEttaSI7czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MjtzOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1772387236);

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
(1, 1, 1, 3, 1, NULL, 736, 321, 'activo', '2026-02-13 21:51:05', '2026-03-01 00:15:20'),
(2, 1, 1, 3, 2, NULL, 650, 318, 'activo', '2026-02-13 21:51:05', '2026-03-01 00:15:20'),
(3, 1, 1, 3, 3, NULL, 394, 318, 'activo', '2026-02-13 21:51:05', '2026-03-01 00:15:20'),
(4, 1, 1, 4, 4, NULL, 567, 447, 'activo', '2026-02-13 21:51:05', '2026-03-01 00:15:20'),
(5, 1, 1, 4, 5, NULL, 495, 508, 'activo', '2026-02-13 21:51:05', '2026-03-01 00:15:20'),
(6, 1, 1, 4, 6, NULL, 740, 419, 'activo', '2026-02-13 21:51:06', '2026-03-01 00:15:20'),
(7, 1, 1, 4, 7, NULL, 682, 416, 'activo', '2026-02-13 21:51:06', '2026-03-01 00:15:20'),
(8, 1, 1, 3, 8, NULL, 677, 475, 'activo', '2026-02-13 21:51:06', '2026-03-01 00:15:20'),
(9, 1, 1, 3, 9, NULL, 539, 507, 'activo', '2026-02-13 21:51:06', '2026-03-01 00:15:20'),
(10, 1, 1, 3, 10, NULL, 569, 473, 'activo', '2026-02-13 21:51:06', '2026-03-01 00:15:20'),
(11, 1, 1, 3, 11, NULL, 586, 512, 'activo', '2026-02-13 21:51:06', '2026-03-01 00:15:20'),
(12, 1, 1, 3, 12, NULL, 739, 509, 'activo', '2026-02-13 21:51:06', '2026-03-01 00:15:20'),
(13, 1, 1, 3, 13, NULL, 419, 479, 'activo', '2026-02-13 21:51:06', '2026-03-01 00:15:21'),
(14, 1, 1, 3, 14, NULL, 390, 476, 'activo', '2026-02-13 21:51:06', '2026-03-01 00:15:21'),
(15, 1, 1, 3, 15, NULL, 388, 510, 'activo', '2026-02-13 21:51:06', '2026-03-01 00:15:21'),
(16, 1, 1, 3, 16, NULL, 301, 667, 'activo', '2026-02-13 21:51:06', '2026-03-01 00:15:21'),
(17, 1, 1, 3, 17, NULL, 294, 471, 'activo', '2026-02-13 21:51:06', '2026-03-01 00:15:21'),
(18, 1, 1, 3, 18, NULL, 372, 314, 'activo', '2026-02-13 21:51:06', '2026-03-01 00:15:21'),
(19, 1, 1, 3, 19, NULL, 359, 634, 'activo', '2026-02-13 21:51:06', '2026-03-01 00:15:21'),
(20, 1, 1, 3, 20, NULL, 338, 676, 'activo', '2026-02-13 21:51:06', '2026-03-01 00:15:21'),
(21, 1, 1, 3, 21, NULL, 671, 675, 'activo', '2026-02-13 21:51:06', '2026-03-01 00:15:21'),
(22, 1, 1, 3, 22, NULL, 740, 592, 'activo', '2026-02-13 21:51:06', '2026-03-01 00:15:21'),
(23, 1, 1, 4, 23, NULL, 737, 533, 'activo', '2026-02-13 21:51:06', '2026-03-01 00:15:21'),
(24, 1, 1, 3, 24, NULL, 641, 489, 'activo', '2026-02-13 21:51:06', '2026-03-01 00:15:21'),
(25, 1, 1, 4, 25, NULL, 773, 206, 'activo', '2026-02-13 21:51:06', '2026-03-01 00:15:21'),
(26, 1, 1, 4, 26, NULL, 740, 154, 'activo', '2026-02-13 21:51:06', '2026-03-01 00:15:21'),
(27, 1, 1, 4, 27, NULL, 744, 247, 'activo', '2026-02-13 21:51:06', '2026-03-01 00:15:21'),
(28, 1, 1, 4, 28, NULL, 725, 280, 'activo', '2026-02-13 21:51:06', '2026-03-01 00:15:21'),
(29, 1, 1, 4, 29, NULL, 746, 280, 'activo', '2026-02-13 21:51:06', '2026-03-01 00:15:21'),
(30, 1, 1, 4, 30, NULL, 390, 286, 'activo', '2026-02-13 21:51:06', '2026-03-01 00:15:21'),
(31, 1, 1, 4, 31, NULL, 394, 70, 'activo', '2026-02-13 21:51:07', '2026-03-01 00:15:21'),
(32, 1, 1, 4, 32, NULL, 552, 69, 'activo', '2026-02-13 21:51:07', '2026-03-01 00:15:21'),
(33, 1, 1, 4, 33, NULL, 774, 105, 'activo', '2026-02-13 21:51:07', '2026-03-01 00:15:21'),
(34, 1, 1, 4, 34, NULL, 849, 149, 'activo', '2026-02-13 21:51:07', '2026-03-01 00:15:21'),
(35, 1, 1, 4, 35, NULL, 778, 17, 'activo', '2026-02-13 21:51:07', '2026-03-01 00:15:21'),
(36, 1, 1, 4, 36, NULL, 975, 17, 'activo', '2026-02-13 21:51:07', '2026-03-01 00:15:21'),
(37, 1, 1, 4, 37, NULL, 671, 13, 'activo', '2026-02-13 21:51:07', '2026-03-01 00:15:21'),
(38, 1, 1, 4, 38, NULL, 359, 55, 'activo', '2026-02-13 21:51:07', '2026-03-01 00:15:22'),
(39, 1, 1, 4, 39, NULL, 380, 14, 'activo', '2026-02-13 21:51:07', '2026-03-01 00:15:22'),
(40, 1, 1, 4, 40, NULL, 58, 18, 'activo', '2026-02-13 21:51:07', '2026-03-01 00:15:22'),
(41, 1, 1, 4, 41, NULL, 59, 40, 'activo', '2026-02-13 21:51:07', '2026-03-01 00:15:22'),
(42, 1, 1, 4, 42, NULL, 294, 286, 'activo', '2026-02-13 21:51:07', '2026-03-01 00:15:22'),
(43, 1, 1, 4, 43, NULL, 203, 168, 'activo', '2026-02-13 21:51:07', '2026-03-01 00:15:22'),
(44, 1, 1, 4, 44, NULL, 125, 92, 'activo', '2026-02-13 21:51:07', '2026-03-01 00:15:22'),
(45, 1, 1, 4, 45, NULL, 337, 71, 'activo', '2026-02-13 21:51:07', '2026-03-01 00:15:22'),
(46, 1, 2, 3, 1, 'null', 386, 617, 'activo', '2026-02-13 21:54:19', '2026-02-14 03:44:03'),
(47, 1, 2, 3, 2, 'null', 481, 621, 'activo', '2026-02-13 21:54:19', '2026-02-14 03:44:03'),
(48, 1, 2, 3, 3, 'null', 522, 606, 'activo', '2026-02-13 21:54:19', '2026-02-14 03:44:03'),
(49, 1, 2, 3, 4, 'null', 640, 607, 'activo', '2026-02-13 21:54:19', '2026-02-14 03:44:03'),
(50, 1, 2, 3, 5, 'null', 752, 611, 'activo', '2026-02-13 21:54:19', '2026-02-14 03:44:03'),
(51, 1, 2, 3, 6, 'null', 812, 609, 'activo', '2026-02-13 21:54:19', '2026-02-14 03:44:03'),
(52, 1, 2, 3, 7, 'null', 684, 207, 'activo', '2026-02-13 21:54:19', '2026-02-14 03:44:03'),
(53, 1, 2, 3, 8, 'null', 389, 201, 'activo', '2026-02-13 21:54:19', '2026-02-14 03:44:03'),
(54, 1, 2, 3, 9, 'null', 451, 159, 'activo', '2026-02-13 21:54:19', '2026-02-14 03:44:03'),
(55, 1, 2, 3, 10, 'null', 609, 72, 'activo', '2026-02-13 21:54:19', '2026-02-14 03:44:03'),
(56, 1, 2, 3, 11, 'null', 332, 65, 'activo', '2026-02-13 21:54:19', '2026-02-14 03:44:03'),
(57, 1, 2, 3, 12, 'null', 142, 62, 'activo', '2026-02-13 21:54:19', '2026-02-14 03:44:03'),
(58, 1, 2, 3, 13, 'null', 580, 554, 'activo', '2026-02-13 21:54:19', '2026-02-14 03:44:03'),
(59, 1, 3, 3, 1, 'null', 301, 139, 'activo', '2026-02-13 22:02:51', '2026-02-13 22:02:51'),
(60, 1, 3, 3, 2, 'null', 150, 249, 'activo', '2026-02-13 22:02:51', '2026-02-13 22:02:51'),
(61, 1, 3, 3, 3, 'null', 546, 143, 'activo', '2026-02-13 22:02:51', '2026-02-13 22:02:51'),
(62, 1, 3, 3, 4, 'null', 553, 255, 'activo', '2026-02-13 22:02:51', '2026-02-13 22:02:51'),
(63, 1, 3, 3, 5, 'null', 550, 323, 'activo', '2026-02-13 22:02:51', '2026-02-13 22:02:51'),
(64, 1, 3, 3, 6, 'null', 405, 388, 'activo', '2026-02-13 22:02:51', '2026-02-13 22:02:51'),
(65, 1, 3, 3, 7, 'null', 665, 183, 'activo', '2026-02-13 22:02:51', '2026-02-13 22:02:51'),
(66, 1, 3, 3, 8, 'null', 812, 246, 'activo', '2026-02-13 22:02:51', '2026-02-13 22:02:51'),
(67, 1, 3, 3, 9, 'null', 662, 300, 'activo', '2026-02-13 22:02:51', '2026-02-13 22:02:51'),
(68, 1, 3, 3, 10, 'null', 670, 387, 'activo', '2026-02-13 22:02:51', '2026-02-13 22:02:51'),
(69, 2, 4, 3, 1, 'null', 723, 592, 'activo', '2026-02-13 22:50:13', '2026-02-27 11:57:13'),
(70, 2, 4, 3, 2, 'null', 598, 556, 'activo', '2026-02-13 22:50:13', '2026-02-27 11:57:13'),
(71, 2, 4, 3, 3, 'null', 492, 481, 'activo', '2026-02-13 22:50:13', '2026-02-27 11:57:13'),
(72, 2, 4, 3, 4, 'null', 403, 419, 'activo', '2026-02-13 22:50:13', '2026-02-27 11:57:13'),
(73, 2, 4, 3, 5, 'null', 274, 339, 'activo', '2026-02-13 22:50:13', '2026-02-27 11:57:13'),
(74, 2, 4, 3, 6, 'null', 143, 253, 'activo', '2026-02-13 22:50:13', '2026-02-27 11:57:13'),
(75, 2, 4, 3, 7, 'null', 116, 157, 'activo', '2026-02-13 22:50:13', '2026-02-27 11:57:13'),
(76, 2, 4, 3, 8, 'null', 54, 138, 'activo', '2026-02-13 22:50:13', '2026-02-27 11:57:13'),
(77, 2, 4, 3, 9, 'null', 252, 39, 'activo', '2026-02-13 22:50:13', '2026-02-27 11:57:13'),
(78, 2, 4, 3, 10, 'null', 251, 173, 'activo', '2026-02-13 22:50:13', '2026-02-27 11:57:13'),
(79, 2, 4, 3, 11, 'null', 293, 82, 'activo', '2026-02-13 22:50:13', '2026-02-27 11:57:13'),
(80, 2, 4, 3, 12, 'null', 292, 203, 'activo', '2026-02-13 22:50:13', '2026-02-27 11:57:13'),
(81, 2, 4, 4, 13, 'null', 523, 189, 'activo', '2026-02-13 22:50:13', '2026-02-27 11:57:13'),
(82, 2, 4, 3, 14, 'null', 441, 187, 'activo', '2026-02-13 22:50:13', '2026-02-27 11:57:13'),
(83, 2, 4, 3, 15, 'null', 312, 185, 'activo', '2026-02-13 22:50:13', '2026-02-27 11:57:13'),
(84, 2, 4, 3, 16, 'null', 313, 28, 'activo', '2026-02-13 22:50:13', '2026-02-27 11:57:13'),
(85, 2, 4, 3, 17, 'null', 434, 24, 'activo', '2026-02-13 22:50:13', '2026-02-27 11:57:13'),
(86, 2, 4, 3, 18, 'null', 606, 30, 'activo', '2026-02-13 22:50:13', '2026-02-27 11:57:13'),
(87, 2, 4, 3, 19, 'null', 604, 184, 'activo', '2026-02-13 22:50:14', '2026-02-27 11:57:13'),
(88, 2, 4, 3, 20, 'null', 663, 194, 'activo', '2026-02-13 22:50:14', '2026-02-27 11:57:13'),
(89, 2, 4, 3, 21, 'null', 753, 199, 'activo', '2026-02-13 22:50:14', '2026-02-27 11:57:13'),
(90, 2, 4, 3, 22, 'null', 788, 387, 'activo', '2026-02-13 22:50:14', '2026-02-27 11:57:13'),
(91, 2, 4, 3, 23, 'null', 799, 202, 'activo', '2026-02-13 22:50:14', '2026-02-27 11:57:13'),
(92, 2, 4, 3, 24, 'null', 926, 200, 'activo', '2026-02-13 22:50:14', '2026-02-27 11:57:14'),
(93, 2, 4, 3, 25, 'null', 925, 644, 'activo', '2026-02-13 22:50:14', '2026-02-27 11:57:14'),
(94, 2, 4, 3, 26, 'null', 804, 650, 'activo', '2026-02-13 22:50:14', '2026-02-27 11:57:14'),
(95, 2, 4, 4, 27, 'null', 740, 507, 'activo', '2026-02-13 22:50:14', '2026-02-27 11:57:14'),
(96, 2, 4, 4, 28, 'null', 780, 510, 'activo', '2026-02-13 22:50:14', '2026-02-27 11:57:14'),
(97, 2, 4, 4, 29, 'null', 789, 602, 'activo', '2026-02-13 22:50:14', '2026-02-27 11:57:14'),
(98, 2, 4, 4, 30, 'null', 787, 650, 'activo', '2026-02-13 22:50:14', '2026-02-27 11:57:14'),
(101, 2, 5, 3, 1, 'null', 278, 122, 'activo', '2026-02-13 22:54:52', '2026-02-14 03:21:00'),
(102, 2, 5, 3, 2, 'null', 282, 15, 'activo', '2026-02-13 22:54:52', '2026-02-14 03:21:00'),
(103, 2, 5, 3, 3, 'null', 725, 18, 'activo', '2026-02-13 22:54:52', '2026-02-14 03:21:00'),
(104, 2, 5, 3, 4, 'null', 722, 123, 'activo', '2026-02-13 22:54:52', '2026-02-14 03:21:00'),
(105, 2, 5, 3, 5, 'null', 393, 150, 'activo', '2026-02-13 22:54:52', '2026-02-14 03:21:00'),
(106, 2, 5, 3, 6, 'null', 81, 152, 'activo', '2026-02-13 22:54:52', '2026-02-14 03:21:00'),
(107, 2, 5, 3, 7, 'null', 83, 340, 'activo', '2026-02-13 22:54:52', '2026-02-14 03:21:00'),
(108, 2, 5, 3, 8, 'null', 81, 609, 'activo', '2026-02-13 22:54:52', '2026-02-14 03:21:00'),
(109, 2, 5, 3, 9, 'null', 473, 623, 'activo', '2026-02-13 22:54:52', '2026-02-14 03:21:00'),
(110, 2, 5, 3, 10, 'null', 717, 623, 'activo', '2026-02-13 22:54:52', '2026-02-14 03:21:00'),
(111, 2, 5, 3, 11, 'null', 816, 442, 'activo', '2026-02-13 22:54:52', '2026-02-14 03:21:00'),
(112, 2, 5, 3, 12, 'null', 915, 240, 'activo', '2026-02-13 22:54:52', '2026-02-14 03:21:00'),
(142, 4, 7, 3, 1, 'null', 859, 35, 'activo', '2026-02-14 02:29:35', '2026-03-01 16:47:10'),
(143, 4, 7, 3, 2, 'null', 914, 34, 'activo', '2026-02-14 02:29:35', '2026-03-01 16:47:10'),
(144, 4, 7, 3, 3, 'null', 896, 54, 'activo', '2026-02-14 02:29:35', '2026-03-01 16:47:10'),
(145, 4, 7, 3, 4, 'null', 896, 102, 'activo', '2026-02-14 02:29:35', '2026-03-01 16:47:10'),
(146, 4, 7, 3, 5, 'null', 895, 213, 'activo', '2026-02-14 02:29:35', '2026-03-01 16:47:10'),
(147, 4, 7, 3, 6, 'null', 895, 320, 'activo', '2026-02-14 02:29:35', '2026-03-01 16:47:10'),
(148, 4, 7, 3, 7, 'null', 893, 425, 'activo', '2026-02-14 02:29:35', '2026-03-01 16:47:10'),
(149, 4, 7, 3, 8, 'null', 890, 507, 'activo', '2026-02-14 02:29:35', '2026-03-01 16:47:10'),
(150, 4, 7, 3, 9, 'null', 932, 659, 'activo', '2026-02-14 02:29:35', '2026-03-01 16:47:10'),
(151, 4, 7, 3, 10, 'null', 870, 659, 'activo', '2026-02-14 02:29:35', '2026-03-01 16:47:10'),
(152, 4, 7, 3, 11, 'null', 821, 662, 'activo', '2026-02-14 02:29:35', '2026-03-01 16:47:10'),
(153, 4, 7, 3, 12, 'null', 803, 618, 'activo', '2026-02-14 02:29:35', '2026-03-01 16:47:10'),
(154, 4, 7, 3, 13, 'null', 795, 531, 'activo', '2026-02-14 02:29:35', '2026-03-01 16:47:10'),
(155, 4, 7, 3, 14, 'null', 783, 395, 'activo', '2026-02-14 02:29:35', '2026-03-01 16:47:10'),
(156, 4, 7, 3, 15, 'null', 707, 397, 'activo', '2026-02-14 02:29:35', '2026-03-01 16:47:10'),
(157, 4, 7, 3, 16, 'null', 707, 455, 'activo', '2026-02-14 02:29:35', '2026-03-01 16:47:10'),
(158, 4, 7, 3, 17, 'null', 567, 583, 'activo', '2026-02-14 02:29:35', '2026-03-01 16:47:10'),
(159, 4, 7, 3, 18, 'null', 528, 660, 'activo', '2026-02-14 02:29:35', '2026-03-01 16:47:10'),
(160, 4, 7, 3, 19, 'null', 446, 662, 'activo', '2026-02-14 02:29:35', '2026-03-01 16:47:10'),
(161, 4, 7, 3, 20, 'null', 358, 662, 'activo', '2026-02-14 02:29:36', '2026-03-01 16:47:10'),
(162, 4, 7, 3, 21, 'null', 263, 662, 'activo', '2026-02-14 02:29:36', '2026-03-01 16:47:10'),
(163, 4, 7, 3, 22, 'null', 236, 662, 'activo', '2026-02-14 02:29:36', '2026-03-01 16:47:10'),
(164, 4, 7, 3, 23, 'null', 203, 662, 'activo', '2026-02-14 02:29:36', '2026-03-01 16:47:10'),
(165, 4, 7, 3, 24, 'null', 143, 659, 'activo', '2026-02-14 02:29:36', '2026-03-01 16:47:11'),
(166, 4, 7, 3, 25, 'null', 91, 661, 'activo', '2026-02-14 02:29:36', '2026-03-01 16:47:11'),
(167, 4, 7, 3, 26, 'null', 26, 550, 'activo', '2026-02-14 02:29:36', '2026-03-01 16:47:11'),
(168, 4, 7, 3, 27, 'null', 27, 486, 'activo', '2026-02-14 02:29:36', '2026-03-01 16:47:11'),
(169, 4, 7, 3, 28, 'null', 30, 424, 'activo', '2026-02-14 02:29:36', '2026-03-01 16:47:11'),
(170, 4, 7, 3, 29, 'null', 27, 367, 'activo', '2026-02-14 02:29:36', '2026-03-01 16:47:11'),
(171, 4, 7, 3, 30, 'null', 25, 245, 'activo', '2026-02-14 02:29:36', '2026-03-01 16:47:11'),
(172, 4, 7, 3, 31, 'null', 25, 157, 'activo', '2026-02-14 02:29:36', '2026-03-01 16:47:11'),
(173, 4, 7, 3, 32, 'null', 23, 40, 'activo', '2026-02-14 02:29:36', '2026-03-01 16:47:11'),
(174, 4, 7, 3, 33, 'null', 80, 37, 'activo', '2026-02-14 02:29:36', '2026-03-01 16:47:11'),
(175, 4, 7, 3, 34, 'null', 140, 32, 'activo', '2026-02-14 02:29:36', '2026-03-01 16:47:11'),
(176, 4, 7, 3, 35, 'null', 210, 32, 'activo', '2026-02-14 02:29:36', '2026-03-01 16:47:11'),
(177, 4, 7, 3, 36, 'null', 230, 76, 'activo', '2026-02-14 02:29:36', '2026-03-01 16:47:11'),
(178, 4, 7, 3, 37, 'null', 286, 36, 'activo', '2026-02-14 02:29:36', '2026-03-01 16:47:11'),
(179, 4, 7, 3, 38, 'null', 342, 34, 'activo', '2026-02-14 02:29:36', '2026-03-01 16:47:11'),
(180, 4, 7, 3, 39, 'null', 423, 35, 'activo', '2026-02-14 02:29:36', '2026-03-01 16:47:11'),
(181, 4, 7, 3, 40, 'null', 522, 33, 'activo', '2026-02-14 02:29:36', '2026-03-01 16:47:11'),
(182, 4, 7, 3, 41, 'null', 568, 33, 'activo', '2026-02-14 02:29:36', '2026-03-01 16:47:11'),
(183, 4, 7, 3, 42, 'null', 608, 33, 'activo', '2026-02-14 02:29:36', '2026-03-01 16:47:11'),
(184, 4, 7, 3, 43, 'null', 679, 32, 'activo', '2026-02-14 02:29:36', '2026-03-01 16:47:11'),
(185, 4, 7, 3, 44, 'null', 751, 33, 'activo', '2026-02-14 02:29:37', '2026-03-01 16:47:11'),
(186, 4, 7, 3, 45, 'null', 760, 163, 'activo', '2026-02-14 02:29:37', '2026-03-01 16:47:11'),
(187, 4, 7, 3, 46, 'null', 766, 241, 'activo', '2026-02-14 02:29:37', '2026-03-01 16:47:11'),
(188, 4, 7, 3, 47, 'null', 776, 313, 'activo', '2026-02-14 02:29:37', '2026-03-01 16:47:11'),
(189, 4, 7, 3, 48, 'null', 836, 307, 'activo', '2026-02-14 02:29:37', '2026-03-01 16:47:11'),
(190, 4, 7, 3, 49, 'null', 827, 218, 'activo', '2026-02-14 02:29:37', '2026-03-01 16:47:12'),
(191, 4, 7, 3, 50, 'null', 823, 123, 'activo', '2026-02-14 02:29:37', '2026-03-01 16:47:12'),
(192, 4, 7, 3, 51, 'null', 812, 45, 'activo', '2026-02-14 02:29:37', '2026-03-01 16:47:12'),
(193, 4, 7, 3, 52, 'null', 771, 31, 'activo', '2026-02-14 02:29:37', '2026-03-01 16:47:12'),
(194, 4, 7, 3, 53, 'null', 915, 60, 'activo', '2026-02-14 02:29:37', '2026-03-01 16:47:12'),
(195, 4, 7, 3, 54, 'null', 905, 149, 'activo', '2026-02-14 02:29:37', '2026-03-01 16:47:12'),
(196, 4, 7, 3, 55, 'null', 961, 59, 'activo', '2026-02-14 02:29:37', '2026-03-01 16:47:12'),
(197, 4, 7, 3, 56, 'null', 961, 108, 'activo', '2026-02-14 02:29:37', '2026-03-01 16:47:12'),
(198, 4, 7, 3, 57, 'null', 961, 143, 'activo', '2026-02-14 02:29:37', '2026-03-01 16:47:12'),
(199, 4, 7, 3, 58, 'null', 910, 174, 'activo', '2026-02-14 02:29:37', '2026-03-01 16:47:12'),
(200, 4, 7, 3, 59, 'null', 912, 268, 'activo', '2026-02-14 02:29:37', '2026-03-01 16:47:12'),
(201, 4, 7, 3, 60, 'null', 962, 171, 'activo', '2026-02-14 02:29:37', '2026-03-01 16:47:12'),
(202, 4, 7, 3, 61, 'null', 962, 269, 'activo', '2026-02-14 02:29:37', '2026-03-01 16:47:12'),
(203, 4, 7, 3, 62, 'null', 945, 199, 'activo', '2026-02-14 02:29:37', '2026-03-01 16:47:12'),
(204, 4, 7, 3, 63, 'null', 966, 209, 'activo', '2026-02-14 02:29:37', '2026-03-01 16:47:12'),
(205, 4, 7, 3, 64, 'null', 945, 228, 'activo', '2026-02-14 02:29:37', '2026-03-01 16:47:12'),
(206, 4, 7, 3, 65, 'null', 905, 291, 'activo', '2026-02-14 02:29:37', '2026-03-01 16:47:12'),
(207, 4, 7, 3, 66, 'null', 962, 295, 'activo', '2026-02-14 02:29:37', '2026-03-01 16:47:12'),
(208, 4, 7, 3, 67, 'null', 964, 355, 'activo', '2026-02-14 02:29:37', '2026-03-01 16:47:12'),
(209, 4, 7, 3, 68, 'null', 904, 370, 'activo', '2026-02-14 02:29:38', '2026-03-01 16:47:12'),
(210, 4, 7, 3, 69, 'null', 903, 523, 'activo', '2026-02-14 02:29:38', '2026-03-01 16:47:12'),
(211, 4, 7, 3, 70, 'null', 942, 593, 'activo', '2026-02-14 02:29:38', '2026-03-01 16:47:12'),
(212, 4, 7, 3, 71, 'null', 900, 611, 'activo', '2026-02-14 02:29:38', '2026-03-01 16:47:12'),
(213, 4, 7, 3, 72, 'null', 767, 407, 'activo', '2026-02-14 02:29:38', '2026-03-01 16:47:12'),
(214, 4, 7, 3, 73, 'null', 719, 412, 'activo', '2026-02-14 02:29:38', '2026-03-01 16:47:12'),
(215, 4, 7, 3, 74, 'null', 723, 463, 'activo', '2026-02-14 02:29:38', '2026-03-01 16:47:13'),
(216, 4, 7, 3, 75, 'null', 725, 518, 'activo', '2026-02-14 02:29:38', '2026-03-01 16:47:13'),
(217, 4, 7, 3, 76, 'null', 739, 659, 'activo', '2026-02-14 02:29:38', '2026-03-01 16:47:13'),
(218, 4, 7, 3, 77, 'null', 780, 661, 'activo', '2026-02-14 02:29:38', '2026-03-01 16:47:13'),
(219, 4, 7, 3, 78, 'null', 768, 517, 'activo', '2026-02-14 02:29:38', '2026-03-01 16:47:13'),
(220, 4, 7, 3, 79, 'null', 761, 452, 'activo', '2026-02-14 02:29:38', '2026-03-01 16:47:13'),
(221, 4, 7, 3, 80, 'null', 675, 553, 'activo', '2026-02-14 02:29:38', '2026-03-01 16:47:13'),
(222, 4, 7, 3, 81, 'null', 677, 591, 'activo', '2026-02-14 02:29:38', '2026-03-01 16:47:13'),
(223, 4, 7, 3, 82, 'null', 684, 663, 'activo', '2026-02-14 02:29:38', '2026-03-01 16:47:13'),
(224, 4, 7, 3, 83, 'null', 722, 662, 'activo', '2026-02-14 02:29:38', '2026-03-01 16:47:13'),
(225, 4, 7, 3, 84, 'null', 716, 586, 'activo', '2026-02-14 02:29:38', '2026-03-01 16:47:13'),
(226, 4, 7, 3, 85, 'null', 709, 479, 'activo', '2026-02-14 02:29:38', '2026-03-01 16:47:13'),
(227, 4, 7, 3, 86, 'null', 816, 195, 'activo', '2026-02-14 02:29:38', '2026-03-01 16:47:13'),
(228, 4, 7, 3, 87, 'null', 809, 116, 'activo', '2026-02-14 02:29:38', '2026-03-01 16:47:13'),
(229, 4, 7, 3, 88, 'null', 803, 54, 'activo', '2026-02-14 02:29:38', '2026-03-01 16:47:13'),
(230, 4, 7, 3, 89, 'null', 763, 58, 'activo', '2026-02-14 02:29:38', '2026-03-01 16:47:13'),
(231, 4, 7, 3, 90, 'null', 771, 123, 'activo', '2026-02-14 02:29:38', '2026-03-01 16:47:13'),
(232, 4, 7, 3, 91, 'null', 776, 200, 'activo', '2026-02-14 02:29:38', '2026-03-01 16:47:13'),
(233, 4, 7, 3, 92, 'null', 779, 262, 'activo', '2026-02-14 02:29:38', '2026-03-01 16:47:13'),
(234, 4, 7, 3, 93, 'null', 787, 303, 'activo', '2026-02-14 02:29:39', '2026-03-01 16:47:13'),
(235, 4, 7, 3, 94, 'null', 821, 296, 'activo', '2026-02-14 02:29:39', '2026-03-01 16:47:13'),
(236, 4, 7, 3, 95, 'null', 818, 255, 'activo', '2026-02-14 02:29:39', '2026-03-01 16:47:13'),
(237, 4, 7, 3, 96, 'null', 959, 380, 'activo', '2026-02-14 02:29:39', '2026-03-01 16:47:13'),
(238, 4, 7, 3, 97, 'null', 959, 479, 'activo', '2026-02-14 02:29:39', '2026-03-01 16:47:13'),
(239, 4, 7, 3, 98, 'null', 904, 477, 'activo', '2026-02-14 02:29:39', '2026-03-01 16:47:14'),
(240, 4, 7, 3, 99, 'null', 592, 481, 'activo', '2026-02-14 02:29:39', '2026-03-01 16:47:14'),
(241, 4, 7, 3, 100, 'null', 529, 483, 'activo', '2026-02-14 02:29:39', '2026-03-01 16:47:14'),
(242, 4, 7, 4, 101, 'null', 540, 163, 'activo', '2026-02-14 02:29:39', '2026-03-01 16:47:14'),
(243, 4, 7, 4, 102, 'null', 558, 135, 'activo', '2026-02-14 02:29:39', '2026-03-01 16:47:14'),
(244, 4, 7, 4, 103, 'null', 522, 136, 'activo', '2026-02-14 02:29:39', '2026-03-01 16:47:14'),
(245, 4, 7, 4, 104, 'null', 501, 138, 'activo', '2026-02-14 02:29:39', '2026-03-01 16:47:14'),
(246, 4, 7, 4, 105, 'null', 481, 137, 'activo', '2026-02-14 02:29:39', '2026-03-01 16:47:14'),
(247, 4, 7, 4, 106, 'null', 509, 165, 'activo', '2026-02-14 02:29:39', '2026-03-01 16:47:14'),
(248, 4, 7, 4, 107, 'null', 394, 139, 'activo', '2026-02-14 02:29:39', '2026-03-01 16:47:14'),
(249, 4, 7, 4, 108, 'null', 307, 143, 'activo', '2026-02-14 02:29:39', '2026-03-01 16:47:14'),
(250, 4, 7, 4, 109, 'null', 238, 120, 'activo', '2026-02-14 02:29:39', '2026-03-01 16:47:14'),
(251, 4, 7, 4, 110, 'null', 273, 120, 'activo', '2026-02-14 02:29:39', '2026-03-01 16:47:14'),
(252, 4, 7, 4, 111, 'null', 243, 180, 'activo', '2026-02-14 02:29:39', '2026-03-01 16:47:14'),
(253, 4, 7, 4, 112, 'null', 245, 209, 'activo', '2026-02-14 02:29:39', '2026-03-01 16:47:14'),
(254, 4, 7, 4, 113, 'null', 273, 182, 'activo', '2026-02-14 02:29:39', '2026-03-01 16:47:14'),
(255, 4, 7, 4, 114, 'null', 246, 260, 'activo', '2026-02-14 02:29:39', '2026-03-01 16:47:14'),
(256, 4, 7, 4, 115, 'null', 280, 276, 'activo', '2026-02-14 02:29:39', '2026-03-01 16:47:14'),
(257, 4, 7, 4, 116, 'null', 284, 361, 'activo', '2026-02-14 02:29:39', '2026-03-01 16:47:14'),
(258, 4, 7, 4, 117, 'null', 252, 359, 'activo', '2026-02-14 02:29:39', '2026-03-01 16:47:14'),
(259, 4, 7, 4, 118, 'null', 252, 385, 'activo', '2026-02-14 02:29:40', '2026-03-01 16:47:14'),
(260, 4, 7, 4, 119, 'null', 282, 384, 'activo', '2026-02-14 02:29:40', '2026-03-01 16:47:14'),
(261, 4, 7, 4, 120, 'null', 284, 439, 'activo', '2026-02-14 02:29:40', '2026-03-01 16:47:14'),
(262, 4, 7, 4, 121, 'null', 294, 469, 'activo', '2026-02-14 02:29:40', '2026-03-01 16:47:14'),
(263, 4, 7, 4, 122, 'null', 352, 465, 'activo', '2026-02-14 02:29:40', '2026-03-01 16:47:14'),
(264, 4, 7, 4, 123, 'null', 416, 459, 'activo', '2026-02-14 02:29:40', '2026-03-01 16:47:15'),
(265, 4, 7, 4, 124, 'null', 409, 398, 'activo', '2026-02-14 02:29:40', '2026-03-01 16:47:15'),
(266, 4, 7, 4, 125, 'null', 464, 362, 'activo', '2026-02-14 02:29:40', '2026-03-01 16:47:15'),
(267, 4, 7, 4, 126, 'null', 601, 444, 'activo', '2026-02-14 02:29:40', '2026-03-01 16:47:15'),
(268, 4, 7, 4, 127, 'null', 544, 354, 'activo', '2026-02-14 02:29:40', '2026-03-01 16:47:15'),
(269, 4, 7, 4, 128, 'null', 618, 386, 'activo', '2026-02-14 02:29:40', '2026-03-01 16:47:15'),
(270, 4, 7, 4, 129, 'null', 642, 330, 'activo', '2026-02-14 02:29:40', '2026-03-01 16:47:15'),
(271, 4, 7, 4, 130, 'null', 639, 264, 'activo', '2026-02-14 02:29:40', '2026-03-01 16:47:15'),
(274, 3, 6, 3, 1, NULL, 992, 276, 'activo', '2026-02-14 03:39:03', '2026-02-14 03:56:58'),
(275, 3, 6, 3, 2, NULL, 998, 511, 'activo', '2026-02-14 03:39:03', '2026-02-14 03:56:58'),
(276, 3, 6, 3, 3, NULL, 961, 366, 'activo', '2026-02-14 03:39:03', '2026-02-14 03:56:58'),
(277, 3, 6, 3, 4, NULL, 879, 373, 'activo', '2026-02-14 03:39:03', '2026-02-14 03:56:58'),
(278, 3, 6, 3, 5, NULL, 690, 639, 'activo', '2026-02-14 03:39:03', '2026-02-14 03:56:58'),
(279, 3, 6, 3, 6, NULL, 454, 637, 'activo', '2026-02-14 03:39:03', '2026-02-14 03:56:58'),
(280, 3, 6, 3, 7, NULL, 280, 635, 'activo', '2026-02-14 03:39:03', '2026-02-14 03:56:58'),
(281, 3, 6, 3, 8, NULL, 209, 606, 'activo', '2026-02-14 03:39:03', '2026-02-14 03:56:58'),
(282, 3, 6, 3, 9, NULL, 158, 386, 'activo', '2026-02-14 03:39:03', '2026-02-14 03:56:58'),
(283, 3, 6, 3, 10, NULL, 55, 637, 'activo', '2026-02-14 03:39:03', '2026-02-14 03:56:58'),
(284, 3, 6, 3, 11, NULL, 605, 616, 'activo', '2026-02-14 03:39:03', '2026-02-14 03:56:58'),
(285, 3, 6, 3, 12, NULL, 542, 617, 'activo', '2026-02-14 03:39:03', '2026-02-14 03:56:58'),
(286, 3, 6, 3, 13, NULL, 364, 617, 'activo', '2026-02-14 03:39:04', '2026-02-14 03:56:58'),
(287, 3, 6, 3, 14, NULL, 232, 608, 'activo', '2026-02-14 03:39:04', '2026-02-14 03:56:58'),
(288, 3, 6, 3, 15, NULL, 335, 382, 'activo', '2026-02-14 03:39:04', '2026-02-14 03:56:58'),
(289, 3, 6, 3, 16, NULL, 367, 376, 'activo', '2026-02-14 03:39:04', '2026-02-14 03:56:59'),
(290, 3, 6, 4, 17, NULL, 544, 350, 'activo', '2026-02-14 03:39:04', '2026-02-14 03:56:59'),
(291, 3, 6, 3, 18, NULL, 232, 352, 'activo', '2026-02-14 03:39:04', '2026-02-14 03:56:59'),
(292, 3, 6, 3, 19, NULL, 343, 349, 'activo', '2026-02-14 03:39:04', '2026-02-14 03:56:59'),
(293, 3, 6, 3, 20, NULL, 234, 104, 'activo', '2026-02-14 03:39:04', '2026-02-14 03:56:59'),
(294, 3, 6, 4, 21, NULL, 367, 104, 'activo', '2026-02-14 03:39:04', '2026-02-14 03:56:59'),
(295, 3, 6, 4, 22, NULL, 803, 101, 'activo', '2026-02-14 03:39:04', '2026-02-14 03:56:59'),
(296, 3, 6, 4, 23, NULL, 817, 345, 'activo', '2026-02-14 03:39:04', '2026-02-14 03:56:59'),
(297, 3, 6, 4, 24, NULL, 867, 620, 'activo', '2026-02-14 03:39:04', '2026-02-14 03:56:59'),
(298, 3, 6, 4, 25, NULL, 626, 616, 'activo', '2026-02-14 03:39:04', '2026-02-14 03:56:59'),
(299, 3, 6, 4, 26, NULL, 111, 608, 'activo', '2026-02-14 03:39:04', '2026-02-14 03:56:59'),
(300, 3, 6, 4, 27, NULL, 42, 478, 'activo', '2026-02-14 03:39:04', '2026-02-14 03:56:59'),
(301, 3, 6, 4, 28, NULL, 954, 252, 'activo', '2026-02-14 03:39:04', '2026-02-14 03:56:59'),
(302, 3, 6, 4, 29, NULL, 887, 116, 'activo', '2026-02-14 03:39:04', '2026-02-14 03:56:59'),
(303, 3, 6, 2, 30, NULL, 589, 470, 'activo', '2026-02-14 03:39:04', '2026-02-14 03:56:59'),
(304, 4, 7, 2, 131, NULL, 403, 170, 'activo', '2026-02-14 03:50:03', '2026-03-01 16:47:15');

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
(1, 'Luis Isla', 'islaluis25@gmail.com', NULL, '$2y$12$sh74MDDrZRSHClf5KCpcCO3rWocNUKC90ZFUokxiYHWDOZ4TNJ3i.', NULL, NULL, NULL, NULL, '2026-01-30 17:30:34', '2026-01-30 17:30:34'),
(2, 'Prueba1', 'admin@admin.com', NULL, '$2y$12$InosZxlgqNtcJ0mH6NXb5uSC4THhSWntYYJXqkrru.Fgw4YHqQg8m', NULL, NULL, NULL, 'jgfqaqcFcGUbf4TGfQOSMUdPHfX1dElRLec1CYYd7ym9qphhlzorlBjMBKp8', '2026-01-30 17:30:55', '2026-01-30 17:30:55');

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `almacenes`
--
ALTER TABLE `almacenes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `almacen_areas`
--
ALTER TABLE `almacen_areas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `almacen_trampas`
--
ALTER TABLE `almacen_trampas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `almancen_insectocutores`
--
ALTER TABLE `almancen_insectocutores`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `aplicaciones`
--
ALTER TABLE `aplicaciones`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `contrato_detalles`
--
ALTER TABLE `contrato_detalles`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=186;

--
-- AUTO_INCREMENT de la tabla `cuentas_cobrar`
--
ALTER TABLE `cuentas_cobrar`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `empresas`
--
ALTER TABLE `empresas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `producto_usos`
--
ALTER TABLE `producto_usos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `seguimiento_biologicos`
--
ALTER TABLE `seguimiento_biologicos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `seguimiento_epps`
--
ALTER TABLE `seguimiento_epps`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `seguimiento_especies`
--
ALTER TABLE `seguimiento_especies`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `seguimiento_images`
--
ALTER TABLE `seguimiento_images`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `seguimiento_metodos`
--
ALTER TABLE `seguimiento_metodos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `seguimiento_protecciones`
--
ALTER TABLE `seguimiento_protecciones`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=305;

--
-- AUTO_INCREMENT de la tabla `trampa_especie_seguimientos`
--
ALTER TABLE `trampa_especie_seguimientos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `trampa_roedor_seguimientos`
--
ALTER TABLE `trampa_roedor_seguimientos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `usuario_empresas`
--
ALTER TABLE `usuario_empresas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

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
