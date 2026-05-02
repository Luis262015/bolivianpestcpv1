-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 30-04-2026 a las 10:40:43
-- Versión del servidor: 10.6.25-MariaDB
-- Versión de PHP: 8.4.20

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
(7, 4, 'PLANTA VISCACHANI', 'VISCACHANI', 'ALDO COLPARI', '69722555', 'jessica_escobar@lacascada.com.bo', 'LA  PAZ', '2026-04-29 20:03:22', '2026-04-29 20:03:22');

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
(7, 7, NULL, 2700, 4, 0.4, 4320, '2026-04-29 20:03:22', '2026-04-29 20:03:22');

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
(7, 7, NULL, 29, 24, 6, 4176, '2026-04-29 20:03:22', '2026-04-29 20:03:22');

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
(7, 7, NULL, 1, 24, 10, 240, '2026-04-29 20:03:22', '2026-04-29 20:03:22');

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
('bolivianpest-cache-6c6253c61eedc2d8e2b598c192ad87fe', 'i:1;', 1777489614),
('bolivianpest-cache-6c6253c61eedc2d8e2b598c192ad87fe:timer', 'i:1777489614;', 1777489614),
('bolivianpest-cache-7d0f72f5e8ef0afb7379de833e5f9db4', 'i:1;', 1776260696),
('bolivianpest-cache-7d0f72f5e8ef0afb7379de833e5f9db4:timer', 'i:1776260696;', 1776260696),
('bolivianpest-cache-bcda8ba14702a936a86c58ac90357387', 'i:2;', 1777486870),
('bolivianpest-cache-bcda8ba14702a936a86c58ac90357387:timer', 'i:1777486870;', 1777486870),
('bolivianpest-cache-d16680ebbc8bd946eaeb663d2196bf9d', 'i:1;', 1777519853),
('bolivianpest-cache-d16680ebbc8bd946eaeb663d2196bf9d:timer', 'i:1777519853;', 1777519853),
('bolivianpest-cache-islaluis25@gmail.com|190.109.225.31', 'i:1;', 1776260696),
('bolivianpest-cache-islaluis25@gmail.com|190.109.225.31:timer', 'i:1776260696;', 1776260696);

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
(1, 1, 14672.00, '2026-12-31', '2026-04-29 17:59:23', '2026-04-29 21:13:51'),
(2, 2, 33200.00, '2026-12-31', '2026-04-29 18:53:56', '2026-04-29 21:12:18'),
(3, 3, 10832.00, '2026-12-31', '2026-04-29 19:49:13', '2026-04-29 21:14:57'),
(4, 4, 8736.00, '2026-12-31', '2026-04-29 20:03:22', '2026-04-29 21:15:18');

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
(7, 4, 'PLANTA VISCACHANI', '29', '24', '6', '4176', '2700', '4', '0.4', '4320', '1', '24', '10', '240', 0.00, '2026-04-29 20:03:22', '2026-04-29 20:03:22');

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
(81, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-01-13', 'bg-yellow-500', 'completado', '2026-04-29 18:25:27', '2026-04-29 18:27:59'),
(82, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-01-30', 'bg-yellow-500', 'completado', '2026-04-29 18:25:27', '2026-04-29 18:28:13'),
(83, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-02-12', 'bg-yellow-500', 'completado', '2026-04-29 18:25:27', '2026-04-29 18:27:28'),
(84, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-02-26', 'bg-yellow-500', 'completado', '2026-04-29 18:25:27', '2026-04-29 18:27:44'),
(85, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-03-12', 'bg-yellow-500', 'completado', '2026-04-29 18:25:27', '2026-04-29 18:26:46'),
(86, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-03-26', 'bg-yellow-500', 'completado', '2026-04-29 18:25:27', '2026-04-29 18:27:03'),
(87, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-04-09', 'bg-yellow-500', 'completado', '2026-04-29 18:25:27', '2026-04-29 18:26:14'),
(88, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-04-23', 'bg-yellow-500', 'completado', '2026-04-29 18:25:27', '2026-04-29 18:26:26'),
(105, 1, 1, 2, 2, 2, 'FUMIGACION', '2026-03-07', 'bg-blue-500', 'completado', '2026-04-29 18:25:27', '2026-04-29 18:27:18'),
(109, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-01-13', 'bg-pink-600', 'completado', '2026-04-29 18:25:27', '2026-04-29 18:28:06'),
(110, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-01-30', 'bg-pink-600', 'completado', '2026-04-29 18:25:27', '2026-04-29 18:28:19'),
(111, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-02-12', 'bg-pink-600', 'completado', '2026-04-29 18:25:27', '2026-04-29 18:27:37'),
(112, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-02-26', 'bg-pink-600', 'completado', '2026-04-29 18:25:27', '2026-04-29 18:27:48'),
(113, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-03-12', 'bg-pink-600', 'completado', '2026-04-29 18:25:27', '2026-04-29 18:26:53'),
(114, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-03-26', 'bg-pink-600', 'completado', '2026-04-29 18:25:27', '2026-04-29 18:27:09'),
(115, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-04-09', 'bg-pink-600', 'completado', '2026-04-29 18:25:27', '2026-04-29 18:26:20'),
(116, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-04-23', 'bg-pink-600', 'completado', '2026-04-29 18:25:27', '2026-04-29 18:26:30'),
(429, 2, 4, 2, 2, 1, 'DESRATIZACION', '2026-01-13', 'bg-yellow-500', 'pendiente', '2026-04-29 21:12:18', '2026-04-29 21:12:18'),
(430, 2, 4, 2, 2, 1, 'DESRATIZACION', '2026-01-31', 'bg-yellow-500', 'pendiente', '2026-04-29 21:12:18', '2026-04-29 21:12:18'),
(431, 2, 4, 2, 2, 1, 'DESRATIZACION', '2026-02-13', 'bg-yellow-500', 'pendiente', '2026-04-29 21:12:18', '2026-04-29 21:12:18'),
(432, 2, 4, 2, 2, 1, 'DESRATIZACION', '2026-02-27', 'bg-yellow-500', 'pendiente', '2026-04-29 21:12:18', '2026-04-29 21:12:18'),
(433, 2, 4, 2, 2, 1, 'DESRATIZACION', '2026-03-13', 'bg-yellow-500', 'pendiente', '2026-04-29 21:12:18', '2026-04-29 21:12:18'),
(434, 2, 4, 2, 2, 1, 'DESRATIZACION', '2026-03-27', 'bg-yellow-500', 'pendiente', '2026-04-29 21:12:18', '2026-04-29 21:12:18'),
(435, 2, 4, 2, 2, 1, 'DESRATIZACION', '2026-04-10', 'bg-yellow-500', 'pendiente', '2026-04-29 21:12:18', '2026-04-29 21:12:18'),
(436, 2, 4, 2, 2, 1, 'DESRATIZACION', '2026-04-24', 'bg-yellow-500', 'pendiente', '2026-04-29 21:12:18', '2026-04-29 21:12:18'),
(437, 2, 4, 2, 2, 1, 'DESRATIZACION', '2026-05-08', 'bg-yellow-500', 'pendiente', '2026-04-29 21:12:18', '2026-04-29 21:12:18'),
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
(465, 2, 4, 2, 2, 3, 'INSECTOCUTORES', '2026-05-08', 'bg-pink-600', 'pendiente', '2026-04-29 21:12:18', '2026-04-29 21:12:18'),
(466, 2, 4, 2, 2, 3, 'INSECTOCUTORES', '2026-05-22', 'bg-pink-600', 'pendiente', '2026-04-29 21:12:18', '2026-04-29 21:12:18'),
(467, 2, 4, 2, 2, 3, 'INSECTOCUTORES', '2026-06-12', 'bg-pink-600', 'pendiente', '2026-04-29 21:12:18', '2026-04-29 21:12:18'),
(468, 2, 4, 2, 2, 3, 'INSECTOCUTORES', '2026-06-26', 'bg-pink-600', 'pendiente', '2026-04-29 21:12:18', '2026-04-29 21:12:18'),
(469, 2, 4, 2, 2, 3, 'INSECTOCUTORES', '2026-07-10', 'bg-pink-600', 'pendiente', '2026-04-29 21:12:18', '2026-04-29 21:12:18'),
(470, 2, 4, 2, 2, 3, 'INSECTOCUTORES', '2026-07-21', 'bg-pink-600', 'pendiente', '2026-04-29 21:12:18', '2026-04-29 21:12:18'),
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
(533, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-01-13', 'bg-yellow-500', 'pendiente', '2026-04-29 21:13:51', '2026-04-29 21:13:51'),
(534, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-01-13', 'bg-yellow-500', 'pendiente', '2026-04-29 21:13:51', '2026-04-29 21:13:51'),
(535, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-01-30', 'bg-yellow-500', 'pendiente', '2026-04-29 21:13:51', '2026-04-29 21:13:51'),
(536, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-01-30', 'bg-yellow-500', 'pendiente', '2026-04-29 21:13:51', '2026-04-29 21:13:51'),
(537, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-02-12', 'bg-yellow-500', 'pendiente', '2026-04-29 21:13:51', '2026-04-29 21:13:51'),
(538, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-02-12', 'bg-yellow-500', 'pendiente', '2026-04-29 21:13:51', '2026-04-29 21:13:51'),
(539, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-02-26', 'bg-yellow-500', 'pendiente', '2026-04-29 21:13:51', '2026-04-29 21:13:51'),
(540, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-02-26', 'bg-yellow-500', 'pendiente', '2026-04-29 21:13:51', '2026-04-29 21:13:51'),
(541, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-03-12', 'bg-yellow-500', 'pendiente', '2026-04-29 21:13:51', '2026-04-29 21:13:51'),
(542, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-03-12', 'bg-yellow-500', 'pendiente', '2026-04-29 21:13:51', '2026-04-29 21:13:51'),
(543, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-03-26', 'bg-yellow-500', 'pendiente', '2026-04-29 21:13:51', '2026-04-29 21:13:51'),
(544, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-03-26', 'bg-yellow-500', 'pendiente', '2026-04-29 21:13:51', '2026-04-29 21:13:51'),
(545, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-04-09', 'bg-yellow-500', 'pendiente', '2026-04-29 21:13:51', '2026-04-29 21:13:51'),
(546, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-04-09', 'bg-yellow-500', 'pendiente', '2026-04-29 21:13:51', '2026-04-29 21:13:51'),
(547, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-04-23', 'bg-yellow-500', 'pendiente', '2026-04-29 21:13:51', '2026-04-29 21:13:51'),
(548, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-04-23', 'bg-yellow-500', 'pendiente', '2026-04-29 21:13:51', '2026-04-29 21:13:51'),
(549, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-05-07', 'bg-yellow-500', 'pendiente', '2026-04-29 21:13:51', '2026-04-29 21:13:51'),
(550, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-05-21', 'bg-yellow-500', 'pendiente', '2026-04-29 21:13:51', '2026-04-29 21:13:51'),
(551, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-06-11', 'bg-yellow-500', 'pendiente', '2026-04-29 21:13:51', '2026-04-29 21:13:51'),
(552, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-06-25', 'bg-yellow-500', 'pendiente', '2026-04-29 21:13:51', '2026-04-29 21:13:51'),
(553, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-07-09', 'bg-yellow-500', 'pendiente', '2026-04-29 21:13:51', '2026-04-29 21:13:51'),
(554, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-07-23', 'bg-yellow-500', 'pendiente', '2026-04-29 21:13:51', '2026-04-29 21:13:51'),
(555, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-08-07', 'bg-yellow-500', 'pendiente', '2026-04-29 21:13:51', '2026-04-29 21:13:51'),
(556, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-08-20', 'bg-yellow-500', 'pendiente', '2026-04-29 21:13:51', '2026-04-29 21:13:51'),
(557, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-09-10', 'bg-yellow-500', 'pendiente', '2026-04-29 21:13:51', '2026-04-29 21:13:51'),
(558, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-09-24', 'bg-yellow-500', 'pendiente', '2026-04-29 21:13:51', '2026-04-29 21:13:51'),
(559, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-10-08', 'bg-yellow-500', 'pendiente', '2026-04-29 21:13:51', '2026-04-29 21:13:51'),
(560, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-10-22', 'bg-yellow-500', 'pendiente', '2026-04-29 21:13:51', '2026-04-29 21:13:51'),
(561, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-11-12', 'bg-yellow-500', 'pendiente', '2026-04-29 21:13:51', '2026-04-29 21:13:51'),
(562, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-11-26', 'bg-yellow-500', 'pendiente', '2026-04-29 21:13:51', '2026-04-29 21:13:51'),
(563, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-12-09', 'bg-yellow-500', 'pendiente', '2026-04-29 21:13:51', '2026-04-29 21:13:51'),
(564, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-12-23', 'bg-yellow-500', 'pendiente', '2026-04-29 21:13:51', '2026-04-29 21:13:51'),
(565, 1, 1, 2, 2, 2, 'FUMIGACION', '2026-03-07', 'bg-blue-500', 'pendiente', '2026-04-29 21:13:51', '2026-04-29 21:13:51'),
(566, 1, 1, 2, 2, 2, 'FUMIGACION', '2026-03-07', 'bg-blue-500', 'pendiente', '2026-04-29 21:13:51', '2026-04-29 21:13:51'),
(567, 1, 1, 2, 2, 2, 'FUMIGACION', '2026-06-13', 'bg-blue-500', 'pendiente', '2026-04-29 21:13:51', '2026-04-29 21:13:51'),
(568, 1, 1, 2, 2, 2, 'FUMIGACION', '2026-09-19', 'bg-blue-500', 'pendiente', '2026-04-29 21:13:51', '2026-04-29 21:13:51'),
(569, 1, 1, 2, 2, 2, 'FUMIGACION', '2026-12-12', 'bg-blue-500', 'pendiente', '2026-04-29 21:13:51', '2026-04-29 21:13:51'),
(570, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-01-13', 'bg-pink-600', 'pendiente', '2026-04-29 21:13:51', '2026-04-29 21:13:51'),
(571, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-01-13', 'bg-pink-600', 'pendiente', '2026-04-29 21:13:51', '2026-04-29 21:13:51'),
(572, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-01-30', 'bg-pink-600', 'pendiente', '2026-04-29 21:13:51', '2026-04-29 21:13:51'),
(573, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-01-30', 'bg-pink-600', 'pendiente', '2026-04-29 21:13:51', '2026-04-29 21:13:51'),
(574, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-02-12', 'bg-pink-600', 'pendiente', '2026-04-29 21:13:51', '2026-04-29 21:13:51'),
(575, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-02-12', 'bg-pink-600', 'pendiente', '2026-04-29 21:13:51', '2026-04-29 21:13:51'),
(576, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-02-26', 'bg-pink-600', 'pendiente', '2026-04-29 21:13:51', '2026-04-29 21:13:51'),
(577, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-02-26', 'bg-pink-600', 'pendiente', '2026-04-29 21:13:51', '2026-04-29 21:13:51'),
(578, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-03-12', 'bg-pink-600', 'pendiente', '2026-04-29 21:13:51', '2026-04-29 21:13:51'),
(579, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-03-12', 'bg-pink-600', 'pendiente', '2026-04-29 21:13:51', '2026-04-29 21:13:51'),
(580, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-03-26', 'bg-pink-600', 'pendiente', '2026-04-29 21:13:51', '2026-04-29 21:13:51'),
(581, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-03-26', 'bg-pink-600', 'pendiente', '2026-04-29 21:13:51', '2026-04-29 21:13:51'),
(582, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-04-09', 'bg-pink-600', 'pendiente', '2026-04-29 21:13:51', '2026-04-29 21:13:51'),
(583, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-04-09', 'bg-pink-600', 'pendiente', '2026-04-29 21:13:51', '2026-04-29 21:13:51'),
(584, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-04-23', 'bg-pink-600', 'pendiente', '2026-04-29 21:13:51', '2026-04-29 21:13:51'),
(585, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-04-23', 'bg-pink-600', 'pendiente', '2026-04-29 21:13:51', '2026-04-29 21:13:51'),
(586, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-05-07', 'bg-pink-600', 'pendiente', '2026-04-29 21:13:51', '2026-04-29 21:13:51'),
(587, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-05-21', 'bg-pink-600', 'pendiente', '2026-04-29 21:13:51', '2026-04-29 21:13:51'),
(588, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-06-11', 'bg-pink-600', 'pendiente', '2026-04-29 21:13:51', '2026-04-29 21:13:51'),
(589, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-06-25', 'bg-pink-600', 'pendiente', '2026-04-29 21:13:51', '2026-04-29 21:13:51'),
(590, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-07-09', 'bg-pink-600', 'pendiente', '2026-04-29 21:13:51', '2026-04-29 21:13:51'),
(591, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-07-23', 'bg-pink-600', 'pendiente', '2026-04-29 21:13:51', '2026-04-29 21:13:51'),
(592, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-08-07', 'bg-pink-600', 'pendiente', '2026-04-29 21:13:51', '2026-04-29 21:13:51'),
(593, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-08-20', 'bg-pink-600', 'pendiente', '2026-04-29 21:13:51', '2026-04-29 21:13:51'),
(594, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-09-10', 'bg-pink-600', 'pendiente', '2026-04-29 21:13:51', '2026-04-29 21:13:51'),
(595, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-09-24', 'bg-pink-600', 'pendiente', '2026-04-29 21:13:51', '2026-04-29 21:13:51'),
(596, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-10-08', 'bg-pink-600', 'pendiente', '2026-04-29 21:13:51', '2026-04-29 21:13:51'),
(597, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-10-22', 'bg-pink-600', 'pendiente', '2026-04-29 21:13:51', '2026-04-29 21:13:51'),
(598, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-11-12', 'bg-pink-600', 'pendiente', '2026-04-29 21:13:51', '2026-04-29 21:13:51'),
(599, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-11-26', 'bg-pink-600', 'pendiente', '2026-04-29 21:13:51', '2026-04-29 21:13:51'),
(600, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-12-09', 'bg-pink-600', 'pendiente', '2026-04-29 21:13:51', '2026-04-29 21:13:51'),
(601, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-12-23', 'bg-pink-600', 'pendiente', '2026-04-29 21:13:51', '2026-04-29 21:13:51'),
(602, 3, 5, 2, 2, 1, 'DESRATIZACION', '2026-01-13', 'bg-yellow-500', 'pendiente', '2026-04-29 21:14:57', '2026-04-29 21:14:57'),
(603, 3, 5, 2, 2, 1, 'DESRATIZACION', '2026-01-30', 'bg-yellow-500', 'pendiente', '2026-04-29 21:14:57', '2026-04-29 21:14:57'),
(604, 3, 5, 2, 2, 1, 'DESRATIZACION', '2026-02-12', 'bg-yellow-500', 'pendiente', '2026-04-29 21:14:57', '2026-04-29 21:14:57'),
(605, 3, 5, 2, 2, 1, 'DESRATIZACION', '2026-02-26', 'bg-yellow-500', 'pendiente', '2026-04-29 21:14:57', '2026-04-29 21:14:57'),
(606, 3, 5, 2, 2, 1, 'DESRATIZACION', '2026-03-12', 'bg-yellow-500', 'pendiente', '2026-04-29 21:14:57', '2026-04-29 21:14:57'),
(607, 3, 5, 2, 2, 1, 'DESRATIZACION', '2026-03-26', 'bg-yellow-500', 'pendiente', '2026-04-29 21:14:57', '2026-04-29 21:14:57'),
(608, 3, 5, 2, 2, 1, 'DESRATIZACION', '2026-04-09', 'bg-yellow-500', 'pendiente', '2026-04-29 21:14:57', '2026-04-29 21:14:57'),
(609, 3, 5, 2, 2, 1, 'DESRATIZACION', '2026-04-23', 'bg-yellow-500', 'pendiente', '2026-04-29 21:14:57', '2026-04-29 21:14:57'),
(610, 3, 5, 2, 2, 1, 'DESRATIZACION', '2026-05-07', 'bg-yellow-500', 'pendiente', '2026-04-29 21:14:57', '2026-04-29 21:14:57'),
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
(631, 4, 7, 2, 2, 1, 'DESRATIZACION', '2026-01-24', 'bg-yellow-500', 'pendiente', '2026-04-29 21:15:18', '2026-04-29 21:15:18'),
(632, 4, 7, 2, 2, 1, 'DESRATIZACION', '2026-02-07', 'bg-yellow-500', 'pendiente', '2026-04-29 21:15:18', '2026-04-29 21:15:18'),
(633, 4, 7, 2, 2, 1, 'DESRATIZACION', '2026-02-20', 'bg-yellow-500', 'pendiente', '2026-04-29 21:15:18', '2026-04-29 21:15:18'),
(634, 4, 7, 2, 2, 1, 'DESRATIZACION', '2026-03-11', 'bg-yellow-500', 'pendiente', '2026-04-29 21:15:18', '2026-04-29 21:15:18'),
(635, 4, 7, 2, 2, 1, 'DESRATIZACION', '2026-03-25', 'bg-yellow-500', 'pendiente', '2026-04-29 21:15:18', '2026-04-29 21:15:18'),
(636, 4, 7, 2, 2, 1, 'DESRATIZACION', '2026-04-14', 'bg-yellow-500', 'pendiente', '2026-04-29 21:15:18', '2026-04-29 21:15:18'),
(637, 4, 7, 2, 2, 1, 'DESRATIZACION', '2026-04-28', 'bg-yellow-500', 'pendiente', '2026-04-29 21:15:18', '2026-04-29 21:15:18'),
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
(654, 4, 7, 2, 2, 2, 'FUMIGACION', '2026-01-24', 'bg-blue-500', 'pendiente', '2026-04-29 21:15:18', '2026-04-29 21:15:18'),
(655, 4, 7, 2, 2, 2, 'FUMIGACION', '2026-04-28', 'bg-blue-500', 'pendiente', '2026-04-29 21:15:18', '2026-04-29 21:15:18'),
(656, 4, 7, 2, 2, 2, 'FUMIGACION', '2026-07-25', 'bg-blue-500', 'pendiente', '2026-04-29 21:15:18', '2026-04-29 21:15:18'),
(657, 4, 7, 2, 2, 2, 'FUMIGACION', '2026-10-31', 'bg-blue-500', 'pendiente', '2026-04-29 21:15:18', '2026-04-29 21:15:18'),
(658, 4, 7, 2, 2, 3, 'INSECTOCUTORES', '2026-01-14', 'bg-pink-600', 'pendiente', '2026-04-29 21:15:18', '2026-04-29 21:15:18'),
(659, 4, 7, 2, 2, 3, 'INSECTOCUTORES', '2026-01-24', 'bg-pink-600', 'pendiente', '2026-04-29 21:15:18', '2026-04-29 21:15:18'),
(660, 4, 7, 2, 2, 3, 'INSECTOCUTORES', '2026-02-07', 'bg-pink-600', 'pendiente', '2026-04-29 21:15:18', '2026-04-29 21:15:18'),
(661, 4, 7, 2, 2, 3, 'INSECTOCUTORES', '2026-02-20', 'bg-pink-600', 'pendiente', '2026-04-29 21:15:18', '2026-04-29 21:15:18'),
(662, 4, 7, 2, 2, 3, 'INSECTOCUTORES', '2026-03-11', 'bg-pink-600', 'pendiente', '2026-04-29 21:15:18', '2026-04-29 21:15:18'),
(663, 4, 7, 2, 2, 3, 'INSECTOCUTORES', '2026-03-25', 'bg-pink-600', 'pendiente', '2026-04-29 21:15:18', '2026-04-29 21:15:18'),
(664, 4, 7, 2, 2, 3, 'INSECTOCUTORES', '2026-04-14', 'bg-pink-600', 'pendiente', '2026-04-29 21:15:18', '2026-04-29 21:15:18'),
(665, 4, 7, 2, 2, 3, 'INSECTOCUTORES', '2026-04-28', 'bg-pink-600', 'pendiente', '2026-04-29 21:15:18', '2026-04-29 21:15:18'),
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
(681, 4, 7, 2, 2, 3, 'INSECTOCUTORES', '2026-12-22', 'bg-pink-600', 'pendiente', '2026-04-29 21:15:18', '2026-04-29 21:15:18');

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
(4, NULL, 4, NULL, 2, 'Contrato por cobrar #4', 'Saldo pendiento por cobrar sobre contrato', 8736, 8736, 'Pendiente', NULL, 0, '2026-04-29 20:03:22', '2026-04-29 20:03:22');

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
(4, 'LA CASCADA  PLANTA VISCACHANI', 'CALLE SANTA ROSA NRO. 471 VILLA FATIMA', '69722664', 'jessica_escobar@lacascada.com.bo', 'LA PAZ', 1, '2026-04-29 20:03:22', '2026-04-29 21:15:18');

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
(1, 1, 1, 2, 'PLANO DE UBICACION DE ROEDORES PLANTA VF', NULL, 'images/mapas/1_1777507656.png', '2026-04-29 23:07:36', '2026-04-29 23:28:06'),
(2, 1, 1, 2, 'PLANO DE UBICACION DE ROEDORES GARAJE DOS VF', NULL, 'images/mapas/1_1777508873.png', '2026-04-29 23:27:53', '2026-04-29 23:27:53');

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
(1, 'App\\Models\\User', 1),
(1, 'App\\Models\\User', 2);

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
('11GzDMjfXnOWSX4MVB69HKNHlWgocC1OMawtwazt', NULL, '161.115.235.77', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:135.0) Gecko/20100101 Firefox/135.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiN1BrVm5pTGlkRVdSY2paMXlPc01OWW85cUkxTW8xeTdtS0tWNUFrQSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjQ6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmNvbSI7czo1OiJyb3V0ZSI7czo0OiJob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1777487473),
('11msKCM3ltqtuCyAqGE25QdQNXwQN9fgAyI4h2Qh', 2, '177.222.112.216', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiemR4b0x2ZlIzbUFmTVc3aVAxRTZQWVM2alFwblpUVW9qVHBTdjlZVCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDA6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmNvbS9jb250cmF0b3MvMS9wZGYiO3M6NToicm91dGUiO3M6MTM6ImNvbnRyYXRvcy5wZGYiO31zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToyO30=', 1777509828),
('59wqo2tFaO0lKuQtpBSEHW7iuhLlJnkZNzIQsFDB', 2, '177.222.49.62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiQkVVbURTQzRGOXN0eUc0TWd6SEllTk1mNkFzZFhyNnhJbkJ1TU9jMSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzA6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmNvbS9sb2dpbiI7czo1OiJyb3V0ZSI7czo1OiJsb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjI7fQ==', 1777520131),
('9eGePo0GUdrhnmPSilIuGf4zzgCcGaKKhBQjf6dh', NULL, '109.199.105.90', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.2 Safari/605.1.15', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNFVTdnRiSWxQWlBLZHNGbXY3WFZHRXNseERIWnFHNGxoWkdzd3JYdiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjQ6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmNvbSI7czo1OiJyb3V0ZSI7czo0OiJob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1777518134),
('9xxNg3ZxYaXyYxq8EaW8nSriPw8UG0LBD2VGlg3a', NULL, '43.156.50.197', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZDVxNzFmUVA2NUZsRlM3UUd2Q29tOHZPbFVhVVJkMWpqbVY5RWl0WCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjM6Imh0dHA6Ly9ib2xpdmlhbnBlc3QuY29tIjtzOjU6InJvdXRlIjtzOjQ6ImhvbWUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1777550288),
('AjgO57g1YT0CsMFASvviyImMWgAIicLiQPcIWAtB', NULL, '204.101.161.15', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQWJqWXVQekQ4Wnppekk4enV2MzRuazBScnRHWjJiaUJxeWJPV29IaSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjM6Imh0dHA6Ly9ib2xpdmlhbnBlc3QuY29tIjtzOjU6InJvdXRlIjtzOjQ6ImhvbWUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1777554279),
('AYOjmxfTMSz5QBFkoVIqLcg6jWqRoSmlTqokWOBs', NULL, '192.36.109.115', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Agency/93.8.2357.5', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoieXY5QTNMUzB6TU16bU5xR2EyTXJLOWxvUkRsV2Q1NUFRVEhXWUlZYSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjM6Imh0dHA6Ly9ib2xpdmlhbnBlc3QuY29tIjtzOjU6InJvdXRlIjtzOjQ6ImhvbWUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1777485449),
('ecEsNaD6m3hMud9oVdtQfEo08RgpScm4hVE1uk0Z', NULL, '178.104.181.169', 'Mozilla/5.0 (compatible; WebatlaBot/1.0; +https://bot.webatla.com; abuse@webatla.com)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZlB2SGVqNEZiSGRjQ1UyZ1JjOHB6eFlpQ0xDWEVWZkpzNTVNakNUbSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjQ6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmNvbSI7czo1OiJyb3V0ZSI7czo0OiJob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1777514565),
('EHuDCQ8j2y5SNGqNSWJKFr9JCyXILfkZl8annjFF', NULL, '66.249.66.40', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.7727.116 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoieGNPQVlBeWpmdEpxOE1Kc3RveTRKM0ZEVVpCQmJmeVFmbm5xQ3N4MiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjM6Imh0dHA6Ly9ib2xpdmlhbnBlc3QuY29tIjtzOjU6InJvdXRlIjtzOjQ6ImhvbWUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1777522234),
('KXD1j7mBgnkFem73zXOTej2xaqOv4QQ2AjisUYjt', NULL, '52.167.144.142', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiOHpjT2paV0p5RldNUnlPYW1UTHR5SGRwWDZQbzVEYVRDSk9BQkZHdSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzA6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmNvbS9sb2dpbiI7czo1OiJyb3V0ZSI7czo1OiJsb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1777487523),
('KyRqrFvndKba9Mdo5inrLUkzuX3f7WZbmYv2Eynh', NULL, '46.224.208.228', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoieEoxVWlid0k5Z2xiNXlLZ0xLSXVGREF4VWRsR3hLWVR2anQ5N2xOUSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjQ6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmNvbSI7czo1OiJyb3V0ZSI7czo0OiJob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1777518130),
('MddYZ88iHaAViXgZ9NzYAy6IbFkcSHAuebScSn2K', NULL, '190.129.21.92', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidng4a21vZDNMSDhPQVZ2R0hZV1MyZ0xxeXN4Z202Q1AzWFBCYVMzUiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzA6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmNvbS9sb2dpbiI7czo1OiJyb3V0ZSI7czo1OiJsb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1777485305),
('me3fpUnxrfH7M5DJlmi8hvdS1HQp171AMdQFe0ef', NULL, '66.249.66.39', 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidE1IeTFyamZFcWFoM0lCWW92V1R0elhQS210eFNlQWRwV3FRbmVrbiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjQ6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmNvbSI7czo1OiJyb3V0ZSI7czo0OiJob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1777496351),
('n1O2G07ESsPOLlunNpx48m3jpafKJidLL5GLQHSN', NULL, '192.36.121.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.3.1 Safari/605.1.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiN1VlYmdhUjZHZmlUM0RNYXl6cThPdHpqR3pvWFlUR0dKcFM4QTRtUCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjM6Imh0dHA6Ly9ib2xpdmlhbnBlc3QuY29tIjtzOjU6InJvdXRlIjtzOjQ6ImhvbWUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1777555605),
('n57Uwn9g9Kmmi2auiswpEnCGyWd6b27WHUy004Xb', NULL, '43.131.253.14', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidUhkNmtmSmxPWnhvaEZjZFRGMkhkUGNBN2JVYnJ4c1BmNHRYbWV5TiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjM6Imh0dHA6Ly9ib2xpdmlhbnBlc3QuY29tIjtzOjU6InJvdXRlIjtzOjQ6ImhvbWUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1777512361),
('O6fie83LoP8Ep0KBWY7ONhcceOBr7MGlafLriUtt', NULL, '5.189.131.241', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.2 Safari/605.1.15', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZ0FiMVFnTlZhbUR1bWdwdU1hUXFPcW5GMFgxWDIzS2lkSWV6cUVkWCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjQ6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmNvbSI7czo1OiJyb3V0ZSI7czo0OiJob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1777518184),
('pL1cNS109H7smI0bAQlPlQZa6hU9aZ7qCZpYAioK', 2, '190.109.225.22', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiWlE1Wm1aM0lFUGw1dkFYckJxNnZtbENTazVQbUxYQ2VPdXVocDNrVCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzA6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmNvbS9sb2dpbiI7czo1OiJyb3V0ZSI7czo1OiJsb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjI7fQ==', 1777500518),
('PoOOLIKaCrjT1YnmqlxE4hfptv3NThduurBHrjQ4', NULL, '66.249.66.40', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.7727.116 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicHFXM3I0RE9CanFITGhDVGVpVTdTTmRXMGlqeXhxRTVtV2dlbElqaiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjM6Imh0dHA6Ly9ib2xpdmlhbnBlc3QuY29tIjtzOjU6InJvdXRlIjtzOjQ6ImhvbWUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1777522265),
('RSWNKZfEtzqCU9qBjckH3yEpprv1wXOnMDlp8vi8', NULL, '161.115.234.155', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36 Edg/99.0.1150.30', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUWJkSjZvYWhvY24ySThURjNrS25LdXRvc0R6MzRSZ2tJQXZEeFJpdCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjQ6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmNvbSI7czo1OiJyb3V0ZSI7czo0OiJob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1777487436),
('v7I9AAsFVlNhRv7N45vVUfOLrvHYCIyudkvonfIA', NULL, '204.101.161.15', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicjZmSzBBM0h6TUxtQkF4Y0F2TEZzc0hLQzhxdmRmMHBYeVFpVkZJciI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjQ6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmNvbSI7czo1OiJyb3V0ZSI7czo0OiJob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1777554280),
('WgRyhjAsjOUwiq8wcGkKHmdO2i620XkDhIDLWN6n', NULL, '200.87.246.135', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/29.0 Chrome/136.0.0.0 Mobile Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiR0x1T1cxdFRVbmlCU1Z4bXEyUUtEeDg4MEV2aWRjcjMwWG9peGtlUCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzA6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmNvbS9sb2dpbiI7czo1OiJyb3V0ZSI7czo1OiJsb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1777517292),
('woDn7BfzHd4lFfxqD9Qz0dYF3hr9KtZoTNLHHhEf', NULL, '43.153.86.78', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNUtBOUllZ0w5cVpUSFRqdnRjMzNGZE5sZk5LWFpuU210OWptQjZYeiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjM6Imh0dHA6Ly9ib2xpdmlhbnBlc3QuY29tIjtzOjU6InJvdXRlIjtzOjQ6ImhvbWUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1777490646),
('WT5fwBS8WIOEXG01p1o9xnGhmssoTV6J506d0TAV', 2, '177.222.49.62', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiMWlPOWhsdGxRSkhYUEVFakp2cjAwblRKVXo1R0lGSXFQenRKSVVYWCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzA6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmNvbS9sb2dpbiI7czo1OiJyb3V0ZSI7czo1OiJsb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjI7fQ==', 1777517308),
('WVZBS3Q2jZRjF55CaUrG3tbysLE1ewx6SrK38JYC', NULL, '43.163.84.198', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVlVwV2pOQ1RNSnNuaGFZR1VTaEVSb0RDTlNnME95YkhvVkwxNjkxeSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly93d3cuYm9saXZpYW5wZXN0LmNvbSI7czo1OiJyb3V0ZSI7czo0OiJob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1777541642),
('Y4qsXNXK2lExfcFaUU9LE3seaF7igRDBNA53Bzfz', NULL, '200.87.246.135', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSEpRRmplWVVabzFTTWRHakFZdTVSVk1qNjFWZU41SHF3WmhZZW1LRiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjM6Imh0dHA6Ly9ib2xpdmlhbnBlc3QuY29tIjtzOjU6InJvdXRlIjtzOjQ6ImhvbWUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1777489539);

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
(405, 1, 1, 3, 1, NULL, 715, 324, '1', 'activo', '2026-04-29 23:43:41', '2026-04-29 23:43:41'),
(406, 1, 1, 3, 2, NULL, 639, 323, '2', 'activo', '2026-04-29 23:43:41', '2026-04-29 23:43:41'),
(407, 1, 1, 3, 3, NULL, 378, 322, '3', 'activo', '2026-04-29 23:43:41', '2026-04-29 23:43:41'),
(408, 1, 1, 4, 4, NULL, 555, 431, '4', 'activo', '2026-04-29 23:43:41', '2026-04-29 23:43:41'),
(409, 1, 1, 4, 5, NULL, 470, 513, '5', 'activo', '2026-04-29 23:43:41', '2026-04-29 23:43:41'),
(410, 1, 1, 4, 6, NULL, 724, 418, '6', 'activo', '2026-04-29 23:43:41', '2026-04-29 23:43:41'),
(411, 1, 1, 4, 7, NULL, 653, 411, '7', 'activo', '2026-04-29 23:43:41', '2026-04-29 23:43:41'),
(412, 1, 1, 3, 8, NULL, 664, 465, '8', 'activo', '2026-04-29 23:43:41', '2026-04-29 23:43:41'),
(413, 1, 1, 3, 9, NULL, 531, 508, '9', 'activo', '2026-04-29 23:43:41', '2026-04-29 23:43:41'),
(414, 1, 1, 3, 10, NULL, 556, 455, '10', 'activo', '2026-04-29 23:43:41', '2026-04-29 23:43:41'),
(415, 1, 1, 3, 11, NULL, 573, 510, '11', 'activo', '2026-04-29 23:43:41', '2026-04-29 23:43:41'),
(416, 1, 1, 3, 12, NULL, 721, 505, '12', 'activo', '2026-04-29 23:43:41', '2026-04-29 23:43:41'),
(417, 1, 1, 3, 13, NULL, 407, 477, '13', 'activo', '2026-04-29 23:43:41', '2026-04-29 23:43:41'),
(418, 1, 1, 3, 14, NULL, 375, 474, '14', 'activo', '2026-04-29 23:43:41', '2026-04-29 23:43:41'),
(419, 1, 1, 3, 15, NULL, 376, 511, '15', 'activo', '2026-04-29 23:43:41', '2026-04-29 23:43:41'),
(420, 1, 1, 3, 16, NULL, 288, 654, '16', 'activo', '2026-04-29 23:43:41', '2026-04-29 23:43:41'),
(421, 1, 1, 3, 17, NULL, 283, 472, '17', 'activo', '2026-04-29 23:43:41', '2026-04-29 23:43:41'),
(422, 1, 1, 3, 18, NULL, 353, 326, '18', 'activo', '2026-04-29 23:43:41', '2026-04-29 23:43:41'),
(423, 1, 1, 3, 19, NULL, 349, 623, '19', 'activo', '2026-04-29 23:43:41', '2026-04-29 23:43:41'),
(424, 1, 1, 3, 20, NULL, 323, 663, '20', 'activo', '2026-04-29 23:43:41', '2026-04-29 23:43:41'),
(425, 1, 1, 3, 21, NULL, 661, 671, '21', 'activo', '2026-04-29 23:43:41', '2026-04-29 23:43:41'),
(426, 1, 1, 3, 22, NULL, 725, 596, '22', 'activo', '2026-04-29 23:43:41', '2026-04-29 23:43:41'),
(427, 1, 1, 3, 23, NULL, 626, 486, '24', 'activo', '2026-04-29 23:43:41', '2026-04-29 23:43:41'),
(428, 1, 1, 4, 24, NULL, 723, 531, '23', 'activo', '2026-04-29 23:43:41', '2026-04-29 23:43:41'),
(429, 1, 1, 4, 25, NULL, 760, 205, '25', 'activo', '2026-04-29 23:43:41', '2026-04-29 23:43:41'),
(430, 1, 1, 4, 26, NULL, 727, 161, '26', 'activo', '2026-04-29 23:43:41', '2026-04-29 23:43:41'),
(431, 1, 1, 4, 27, NULL, 727, 220, '27', 'activo', '2026-04-29 23:43:41', '2026-04-29 23:43:41'),
(432, 1, 1, 4, 28, NULL, 705, 255, '28', 'activo', '2026-04-29 23:43:41', '2026-04-29 23:43:41'),
(433, 1, 1, 4, 29, NULL, 732, 254, '29', 'activo', '2026-04-29 23:43:41', '2026-04-29 23:43:41'),
(434, 1, 1, 4, 30, NULL, 376, 281, '30', 'activo', '2026-04-29 23:43:41', '2026-04-29 23:43:41'),
(435, 1, 1, 4, 31, NULL, 382, 82, '31', 'activo', '2026-04-29 23:43:41', '2026-04-29 23:43:41'),
(436, 1, 1, 4, 32, NULL, 709, 85, '32', 'activo', '2026-04-29 23:43:41', '2026-04-29 23:43:41'),
(437, 1, 1, 4, 33, NULL, 767, 111, '33', 'activo', '2026-04-29 23:43:41', '2026-04-29 23:43:41'),
(438, 1, 1, 4, 34, NULL, 838, 160, '34', 'activo', '2026-04-29 23:43:41', '2026-04-29 23:43:41'),
(439, 1, 1, 4, 35, NULL, 761, 31, '35', 'activo', '2026-04-29 23:43:41', '2026-04-29 23:43:41'),
(440, 1, 1, 4, 36, NULL, 967, 27, '36', 'activo', '2026-04-29 23:43:41', '2026-04-29 23:43:41'),
(441, 1, 1, 4, 37, NULL, 645, 28, '37', 'activo', '2026-04-29 23:43:41', '2026-04-29 23:43:41'),
(442, 1, 1, 4, 38, NULL, 352, 67, '38', 'activo', '2026-04-29 23:43:41', '2026-04-29 23:43:41'),
(443, 1, 1, 4, 39, NULL, 371, 22, '39', 'activo', '2026-04-29 23:43:41', '2026-04-29 23:43:41'),
(444, 1, 1, 4, 40, NULL, 47, 22, '40', 'activo', '2026-04-29 23:43:41', '2026-04-29 23:43:41'),
(445, 1, 1, 4, 41, NULL, 48, 56, '41', 'activo', '2026-04-29 23:43:41', '2026-04-29 23:43:41'),
(446, 1, 1, 4, 42, NULL, 281, 275, '42', 'activo', '2026-04-29 23:43:41', '2026-04-29 23:43:41'),
(447, 1, 1, 4, 43, NULL, 191, 185, '43', 'activo', '2026-04-29 23:43:41', '2026-04-29 23:43:41'),
(448, 1, 1, 4, 44, NULL, 116, 108, '44', 'activo', '2026-04-29 23:43:41', '2026-04-29 23:43:41'),
(449, 1, 1, 4, 45, NULL, 356, 88, '45', 'activo', '2026-04-29 23:43:41', '2026-04-29 23:43:41'),
(450, 1, 1, 5, 46, NULL, 577, 332, '46', 'activo', '2026-04-29 23:43:41', '2026-04-29 23:43:41'),
(451, 1, 1, 5, 47, NULL, 578, 363, '47', 'activo', '2026-04-29 23:43:41', '2026-04-29 23:43:41'),
(452, 1, 1, 5, 48, NULL, 620, 326, '48', 'activo', '2026-04-29 23:43:41', '2026-04-29 23:43:41'),
(453, 1, 1, 5, 49, NULL, 620, 365, '49', 'activo', '2026-04-29 23:43:41', '2026-04-29 23:43:41'),
(454, 1, 1, 5, 50, NULL, 660, 325, '50', 'activo', '2026-04-29 23:43:41', '2026-04-29 23:43:41'),
(455, 1, 1, 5, 51, NULL, 656, 364, '51', 'activo', '2026-04-29 23:43:41', '2026-04-29 23:43:41'),
(456, 1, 1, 5, 52, NULL, 689, 324, '52', 'activo', '2026-04-29 23:43:41', '2026-04-29 23:43:41'),
(457, 1, 1, 5, 53, NULL, 691, 365, '53', 'activo', '2026-04-29 23:43:41', '2026-04-29 23:43:41'),
(458, 1, 1, 5, 54, NULL, 724, 364, '54', 'activo', '2026-04-29 23:43:41', '2026-04-29 23:43:41'),
(459, 1, 1, 5, 55, NULL, 732, 316, '55', 'activo', '2026-04-29 23:43:41', '2026-04-29 23:43:41'),
(460, 1, 2, 3, 1, NULL, 403, 642, '1', 'activo', '2026-04-29 23:43:47', '2026-04-29 23:43:47'),
(461, 1, 2, 3, 2, NULL, 496, 640, '2', 'activo', '2026-04-29 23:43:47', '2026-04-29 23:43:47'),
(462, 1, 2, 3, 3, NULL, 543, 635, '3', 'activo', '2026-04-29 23:43:47', '2026-04-29 23:43:47'),
(463, 1, 2, 3, 4, NULL, 658, 639, '4', 'activo', '2026-04-29 23:43:47', '2026-04-29 23:43:47'),
(464, 1, 2, 3, 5, NULL, 766, 644, '5', 'activo', '2026-04-29 23:43:47', '2026-04-29 23:43:47'),
(465, 1, 2, 3, 6, NULL, 831, 643, '6', 'activo', '2026-04-29 23:43:47', '2026-04-29 23:43:47'),
(466, 1, 2, 3, 7, NULL, 706, 231, '7', 'activo', '2026-04-29 23:43:47', '2026-04-29 23:43:47'),
(467, 1, 2, 3, 8, NULL, 395, 210, '8', 'activo', '2026-04-29 23:43:47', '2026-04-29 23:43:47'),
(468, 1, 2, 3, 9, NULL, 469, 168, '9', 'activo', '2026-04-29 23:43:47', '2026-04-29 23:43:47'),
(469, 1, 2, 3, 10, NULL, 626, 79, '10', 'activo', '2026-04-29 23:43:47', '2026-04-29 23:43:47'),
(470, 1, 2, 3, 11, NULL, 351, 67, '11', 'activo', '2026-04-29 23:43:47', '2026-04-29 23:43:47'),
(471, 1, 2, 3, 12, NULL, 153, 61, '12', 'activo', '2026-04-29 23:43:47', '2026-04-29 23:43:47'),
(472, 1, 2, 3, 13, NULL, 597, 582, '13', 'activo', '2026-04-29 23:43:47', '2026-04-29 23:43:47');

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
(1, 'Luis Isla', 'islaluis25@gmail.com', NULL, '$2y$12$631OK8kqnd0o0rDvAhHQmuA5diaagCaHJA.R40gaODUlWQgCIGGrW', NULL, NULL, NULL, NULL, '2026-04-15 12:44:08', '2026-04-15 12:44:08'),
(2, 'admin', 'admin@admin.com', NULL, '$2y$12$Bp2xVW1KGcRy/TSrpPy8FOrmy5cWcLKPe4aNr9rGNhKo6L59nplne', NULL, NULL, NULL, NULL, '2026-04-15 12:44:45', '2026-04-15 12:44:45');

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `almacen_areas`
--
ALTER TABLE `almacen_areas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `almacen_trampas`
--
ALTER TABLE `almacen_trampas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `almancen_insectocutores`
--
ALTER TABLE `almancen_insectocutores`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `aplicaciones`
--
ALTER TABLE `aplicaciones`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `biologicos`
--
ALTER TABLE `biologicos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `buffer_productos`
--
ALTER TABLE `buffer_productos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `certificados`
--
ALTER TABLE `certificados`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `compra_detalles`
--
ALTER TABLE `compra_detalles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `contactos`
--
ALTER TABLE `contactos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `contratos`
--
ALTER TABLE `contratos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `contrato_detalles`
--
ALTER TABLE `contrato_detalles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=682;

--
-- AUTO_INCREMENT de la tabla `cuentas_cobrar`
--
ALTER TABLE `cuentas_cobrar`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `empresas`
--
ALTER TABLE `empresas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `mapas`
--
ALTER TABLE `mapas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `producto_usos`
--
ALTER TABLE `producto_usos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `producto_vencimientos`
--
ALTER TABLE `producto_vencimientos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `seguimiento_biologicos`
--
ALTER TABLE `seguimiento_biologicos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `seguimiento_epps`
--
ALTER TABLE `seguimiento_epps`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `seguimiento_especies`
--
ALTER TABLE `seguimiento_especies`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `seguimiento_images`
--
ALTER TABLE `seguimiento_images`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `seguimiento_metodos`
--
ALTER TABLE `seguimiento_metodos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `seguimiento_protecciones`
--
ALTER TABLE `seguimiento_protecciones`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `seguimiento_signos`
--
ALTER TABLE `seguimiento_signos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=473;

--
-- AUTO_INCREMENT de la tabla `trampa_especie_seguimientos`
--
ALTER TABLE `trampa_especie_seguimientos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `trampa_roedor_seguimientos`
--
ALTER TABLE `trampa_roedor_seguimientos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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
