-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 30-01-2026 a las 14:29:13
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
(1, 1, 'distribucion', 'llojeta', 'henrry fernandez', '78837795', 'gabriel.montram@gmail.com', 'la paz', '2026-01-28 12:59:23', '2026-01-28 12:59:23'),
(2, 2, 'el alto', 'C. GUERRILLEROS LANZA #1328, MIRAFLORES', 'juan crispin', '76738282', 'jotamontero.fm@gmail.com', 'La Paz', '2026-01-28 14:29:19', '2026-01-28 14:29:19'),
(3, 3, 'TOBOROCHI I', 'Bolivia| P.I. Mz.40, Almacenes Ferrotodo, Nave 3 y 4 -Santa Cruz.', 'Alvaro  Quispe', '77695930', 'AquispeB@ransa.net', 'santa cruz', '2026-01-30 00:18:47', '2026-01-30 00:18:47'),
(4, 4, 'uno alm', 'man', 'yo', '9879546', 'alm@uno.com', 'lp', '2026-01-30 13:12:11', '2026-01-30 13:12:11');

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
(1, 1, NULL, 300, 1, 2, 600, '2026-01-28 12:59:23', '2026-01-28 12:59:23'),
(2, 2, NULL, 300, 1, 70, 21000, '2026-01-28 14:29:19', '2026-01-28 14:29:19'),
(3, 3, NULL, 4629, 12, 0.3, 16664.4, '2026-01-30 00:18:47', '2026-01-30 00:18:47'),
(4, 4, NULL, 120, 1, 20, 2400, '2026-01-30 13:12:12', '2026-01-30 13:12:12');

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
(1, 1, NULL, 40, 1, 100, 4000, '2026-01-28 12:59:23', '2026-01-28 12:59:23'),
(2, 2, NULL, 1, 1, 50, 50, '2026-01-28 14:29:19', '2026-01-28 14:29:19'),
(3, 3, NULL, 30, 24, 12, 8640, '2026-01-30 00:18:47', '2026-01-30 00:18:47'),
(4, 4, NULL, 1, 1, 200, 200, '2026-01-30 13:12:12', '2026-01-30 13:12:12');

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
(1, 1, NULL, 2, 1, 50, 50, '2026-01-28 12:59:23', '2026-01-28 12:59:23'),
(2, 2, NULL, 1, 1, 80, 80, '2026-01-28 14:29:19', '2026-01-28 14:29:19'),
(3, 3, NULL, 1, 48, 100, 4800, '2026-01-30 00:18:47', '2026-01-30 00:18:47'),
(4, 4, NULL, 2, 1, 200, 200, '2026-01-30 13:12:12', '2026-01-30 13:12:12');

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
(1, 1, 0, 0, 0, 10, 10, 20, 20, 0, '2026-01-28 13:24:02', '2026-01-28 13:24:02'),
(2, 2, 0, 0, 0, 0, 0, 0, 0, 0, '2026-01-28 13:41:18', '2026-01-28 13:41:18'),
(3, 3, 4, 4, 1, 0, 0, 0, 0, 0, '2026-01-28 13:46:38', '2026-01-28 13:46:38');

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
(1, 'Adulto', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(2, 'Huevo', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(3, 'Larva', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(4, 'Ninfa', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(5, 'Pupa', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(6, 'Otros', '2026-01-28 12:31:34', '2026-01-28 12:31:34');

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
('bolivianpest-cache-0032efb07f1b16be8d896afd7a4863f7', 'i:1;', 1769603796),
('bolivianpest-cache-0032efb07f1b16be8d896afd7a4863f7:timer', 'i:1769603796;', 1769603796),
('bolivianpest-cache-09a8b7893d241ac23337ab3e80b86ab9', 'i:1;', 1769631044),
('bolivianpest-cache-09a8b7893d241ac23337ab3e80b86ab9:timer', 'i:1769631044;', 1769631044),
('bolivianpest-cache-50706508b082f5215575b458242b6604', 'i:1;', 1769614270),
('bolivianpest-cache-50706508b082f5215575b458242b6604:timer', 'i:1769614270;', 1769614270),
('bolivianpest-cache-7c7d314c816e4d30713e15dbd11bcf93', 'i:1;', 1769613824),
('bolivianpest-cache-7c7d314c816e4d30713e15dbd11bcf93:timer', 'i:1769613824;', 1769613824),
('bolivianpest-cache-bcda8ba14702a936a86c58ac90357387', 'i:2;', 1769734610),
('bolivianpest-cache-bcda8ba14702a936a86c58ac90357387:timer', 'i:1769734609;', 1769734610),
('bolivianpest-cache-d16680ebbc8bd946eaeb663d2196bf9d', 'i:1;', 1769782267),
('bolivianpest-cache-d16680ebbc8bd946eaeb663d2196bf9d:timer', 'i:1769782267;', 1769782267);

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
  `qrcode` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `firmadigital` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `titulo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `establecimiento` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `actividad` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `validez` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `direccion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `diagnostico` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `condicion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `trabajo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `plaguicidas` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `registro` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `area` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `acciones` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `logo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `certificados`
--

INSERT INTO `certificados` (`id`, `empresa_id`, `user_id`, `qrcode`, `firmadigital`, `titulo`, `establecimiento`, `actividad`, `validez`, `direccion`, `diagnostico`, `condicion`, `trabajo`, `plaguicidas`, `registro`, `area`, `acciones`, `logo`, `created_at`, `updated_at`) VALUES
(1, 1, 2, '', '', 'DESRATIZACION', 'DIVISION WINDSOR HANSA', 'INDUSTRIA', '90 DIAS HABILES DEL 28/9/2026 AL 28/12/2026', 'AV. 6 DE MARZO', 'NO EXISTE VECTORES CONTAMINANTES', 'AREA LIBRE', 'DESINSECTACION        X,  DESRATIZACION     X', 'KLERAT,  ICON 5EC', 'INSO NRO. BR111LP,  INSO NRO. BK24415', '40 M2', 'CONTINUAR CON EL ORDEN Y LIMPIEZA', '', '2026-01-28 14:17:37', '2026-01-28 14:17:37');

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
(1, 1, 4650.00, '2026-12-31', '2026-01-28 12:59:23', '2026-01-28 12:59:23'),
(2, 2, 21130.00, '2026-12-31', '2026-01-28 14:29:19', '2026-01-28 14:29:19'),
(3, 3, 30104.40, '2026-12-31', '2026-01-30 00:18:47', '2026-01-30 00:18:47'),
(4, 4, 2800.00, '2026-03-12', '2026-01-30 13:12:11', '2026-01-30 13:12:11');

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
(1, 1, 'distribucion', '40', '1', '100', '4000', '300', '1', '2', '600', '2', '1', '50', '50', 0.00, '2026-01-28 12:59:23', '2026-01-28 12:59:23'),
(2, 2, 'el alto', '1', '1', '50', '50', '300', '1', '70', '21000', '1', '1', '80', '80', 0.00, '2026-01-28 14:29:19', '2026-01-28 14:29:19'),
(3, 3, 'TOBOROCHI I', '30', '24', '12', '8640', '4629', '12', '0.3', '16664.4', '1', '48', '100', '4800', 0.00, '2026-01-30 00:18:47', '2026-01-30 00:18:47'),
(4, 4, 'uno alm', '1', '1', '200', '200', '120', '1', '20', '2400', '2', '1', '200', '200', 0.00, '2026-01-30 13:12:12', '2026-01-30 13:12:12');

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
(1, 1, 2, 2, 'Desratización', '2026-02-01', 'bg-yellow-500', 'completado', '2026-01-28 12:59:23', '2026-01-28 13:24:02'),
(2, 1, 2, 2, 'Fumigación', '2026-02-05', 'bg-blue-500', 'completado', '2026-01-28 12:59:23', '2026-01-28 13:46:37'),
(3, 1, 2, 2, 'Insectocutores', '2026-02-03', 'bg-pink-600', 'completado', '2026-01-28 12:59:24', '2026-01-28 13:41:18'),
(4, 2, 2, 2, 'Desratización', '2026-01-29', 'bg-yellow-500', 'pendiente', '2026-01-28 14:29:19', '2026-01-28 14:29:19'),
(5, 2, 2, 2, 'Fumigación', '2026-01-29', 'bg-blue-500', 'pendiente', '2026-01-28 14:29:19', '2026-01-28 14:29:19'),
(6, 2, 2, 2, 'Insectocutores', '2026-01-29', 'bg-pink-600', 'pendiente', '2026-01-28 14:29:19', '2026-01-28 14:29:19'),
(7, 3, 2, 2, 'Desratización', '2026-01-05', 'bg-yellow-500', 'pendiente', '2026-01-30 00:18:47', '2026-01-30 00:18:47'),
(8, 3, 2, 2, 'Desratización', '2026-01-20', 'bg-yellow-500', 'pendiente', '2026-01-30 00:18:47', '2026-01-30 00:18:47'),
(9, 3, 2, 2, 'Desratización', '2026-01-05', 'bg-yellow-500', 'pendiente', '2026-01-30 00:18:47', '2026-01-30 00:18:47'),
(10, 3, 2, 2, 'Desratización', '2026-01-20', 'bg-yellow-500', 'pendiente', '2026-01-30 00:18:47', '2026-01-30 00:18:47'),
(11, 3, 2, 2, 'Desratización', '2026-01-05', 'bg-yellow-500', 'pendiente', '2026-01-30 00:18:47', '2026-01-30 00:18:47'),
(12, 3, 2, 2, 'Desratización', '2026-01-20', 'bg-yellow-500', 'pendiente', '2026-01-30 00:18:48', '2026-01-30 00:18:48'),
(13, 3, 2, 2, 'Desratización', '2026-01-05', 'bg-yellow-500', 'pendiente', '2026-01-30 00:18:48', '2026-01-30 00:18:48'),
(14, 3, 2, 2, 'Desratización', '2026-01-20', 'bg-yellow-500', 'pendiente', '2026-01-30 00:18:48', '2026-01-30 00:18:48'),
(15, 3, 2, 2, 'Desratización', '2026-01-05', 'bg-yellow-500', 'pendiente', '2026-01-30 00:18:48', '2026-01-30 00:18:48'),
(16, 3, 2, 2, 'Desratización', '2026-01-20', 'bg-yellow-500', 'pendiente', '2026-01-30 00:18:48', '2026-01-30 00:18:48'),
(17, 3, 2, 2, 'Desratización', '2026-01-05', 'bg-yellow-500', 'pendiente', '2026-01-30 00:18:48', '2026-01-30 00:18:48'),
(18, 3, 2, 2, 'Desratización', '2026-01-20', 'bg-yellow-500', 'pendiente', '2026-01-30 00:18:48', '2026-01-30 00:18:48'),
(19, 3, 2, 2, 'Desratización', '2026-01-05', 'bg-yellow-500', 'pendiente', '2026-01-30 00:18:48', '2026-01-30 00:18:48'),
(20, 3, 2, 2, 'Desratización', '2026-01-20', 'bg-yellow-500', 'pendiente', '2026-01-30 00:18:48', '2026-01-30 00:18:48'),
(21, 3, 2, 2, 'Desratización', '2026-01-05', 'bg-yellow-500', 'pendiente', '2026-01-30 00:18:48', '2026-01-30 00:18:48'),
(22, 3, 2, 2, 'Desratización', '2026-01-20', 'bg-yellow-500', 'pendiente', '2026-01-30 00:18:48', '2026-01-30 00:18:48'),
(23, 3, 2, 2, 'Desratización', '2026-01-05', 'bg-yellow-500', 'pendiente', '2026-01-30 00:18:48', '2026-01-30 00:18:48'),
(24, 3, 2, 2, 'Desratización', '2026-01-20', 'bg-yellow-500', 'pendiente', '2026-01-30 00:18:49', '2026-01-30 00:18:49'),
(25, 3, 2, 2, 'Desratización', '2026-01-05', 'bg-yellow-500', 'pendiente', '2026-01-30 00:18:49', '2026-01-30 00:18:49'),
(26, 3, 2, 2, 'Desratización', '2026-01-20', 'bg-yellow-500', 'pendiente', '2026-01-30 00:18:49', '2026-01-30 00:18:49'),
(27, 3, 2, 2, 'Desratización', '2026-01-05', 'bg-yellow-500', 'pendiente', '2026-01-30 00:18:49', '2026-01-30 00:18:49'),
(28, 3, 2, 2, 'Desratización', '2026-01-20', 'bg-yellow-500', 'pendiente', '2026-01-30 00:18:49', '2026-01-30 00:18:49'),
(29, 3, 2, 2, 'Desratización', '2026-01-05', 'bg-yellow-500', 'pendiente', '2026-01-30 00:18:49', '2026-01-30 00:18:49'),
(30, 3, 2, 2, 'Desratización', '2026-01-20', 'bg-yellow-500', 'pendiente', '2026-01-30 00:18:49', '2026-01-30 00:18:49'),
(31, 3, 2, 2, 'Fumigación', '2026-01-20', 'bg-blue-500', 'pendiente', '2026-01-30 00:18:49', '2026-01-30 00:18:49'),
(32, 3, 2, 2, 'Fumigación', '2026-01-20', 'bg-blue-500', 'pendiente', '2026-01-30 00:18:49', '2026-01-30 00:18:49'),
(33, 3, 2, 2, 'Fumigación', '2026-01-20', 'bg-blue-500', 'pendiente', '2026-01-30 00:18:49', '2026-01-30 00:18:49'),
(34, 3, 2, 2, 'Fumigación', '2026-01-20', 'bg-blue-500', 'pendiente', '2026-01-30 00:18:49', '2026-01-30 00:18:49'),
(35, 3, 2, 2, 'Fumigación', '2026-01-20', 'bg-blue-500', 'pendiente', '2026-01-30 00:18:49', '2026-01-30 00:18:49'),
(36, 3, 2, 2, 'Fumigación', '2026-01-20', 'bg-blue-500', 'pendiente', '2026-01-30 00:18:50', '2026-01-30 00:18:50'),
(37, 3, 2, 2, 'Fumigación', '2026-01-20', 'bg-blue-500', 'pendiente', '2026-01-30 00:18:50', '2026-01-30 00:18:50'),
(38, 3, 2, 2, 'Fumigación', '2026-01-20', 'bg-blue-500', 'pendiente', '2026-01-30 00:18:50', '2026-01-30 00:18:50'),
(39, 3, 2, 2, 'Fumigación', '2026-01-20', 'bg-blue-500', 'pendiente', '2026-01-30 00:18:50', '2026-01-30 00:18:50'),
(40, 3, 2, 2, 'Fumigación', '2026-01-20', 'bg-blue-500', 'pendiente', '2026-01-30 00:18:50', '2026-01-30 00:18:50'),
(41, 3, 2, 2, 'Fumigación', '2026-01-20', 'bg-blue-500', 'pendiente', '2026-01-30 00:18:50', '2026-01-30 00:18:50'),
(42, 3, 2, 2, 'Fumigación', '2026-01-20', 'bg-blue-500', 'pendiente', '2026-01-30 00:18:50', '2026-01-30 00:18:50'),
(43, 3, 2, 2, 'Insectocutores', '2026-01-06', 'bg-pink-600', 'pendiente', '2026-01-30 00:18:50', '2026-01-30 00:18:50'),
(44, 3, 2, 2, 'Insectocutores', '2026-01-13', 'bg-pink-600', 'pendiente', '2026-01-30 00:18:50', '2026-01-30 00:18:50'),
(45, 3, 2, 2, 'Insectocutores', '2026-01-20', 'bg-pink-600', 'pendiente', '2026-01-30 00:18:50', '2026-01-30 00:18:50'),
(46, 3, 2, 2, 'Insectocutores', '2026-01-27', 'bg-pink-600', 'pendiente', '2026-01-30 00:18:50', '2026-01-30 00:18:50'),
(47, 3, 2, 2, 'Insectocutores', '2026-02-03', 'bg-pink-600', 'pendiente', '2026-01-30 00:18:50', '2026-01-30 00:18:50'),
(48, 3, 2, 2, 'Insectocutores', '2026-02-10', 'bg-pink-600', 'pendiente', '2026-01-30 00:18:51', '2026-01-30 00:18:51'),
(49, 3, 2, 2, 'Insectocutores', '2026-02-17', 'bg-pink-600', 'pendiente', '2026-01-30 00:18:51', '2026-01-30 00:18:51'),
(50, 3, 2, 2, 'Insectocutores', '2026-02-24', 'bg-pink-600', 'pendiente', '2026-01-30 00:18:51', '2026-01-30 00:18:51'),
(51, 3, 2, 2, 'Insectocutores', '2026-03-03', 'bg-pink-600', 'pendiente', '2026-01-30 00:18:51', '2026-01-30 00:18:51'),
(52, 3, 2, 2, 'Insectocutores', '2026-03-10', 'bg-pink-600', 'pendiente', '2026-01-30 00:18:51', '2026-01-30 00:18:51'),
(53, 3, 2, 2, 'Insectocutores', '2026-03-17', 'bg-pink-600', 'pendiente', '2026-01-30 00:18:51', '2026-01-30 00:18:51'),
(54, 3, 2, 2, 'Insectocutores', '2026-03-24', 'bg-pink-600', 'pendiente', '2026-01-30 00:18:51', '2026-01-30 00:18:51'),
(55, 3, 2, 2, 'Insectocutores', '2026-04-07', 'bg-pink-600', 'pendiente', '2026-01-30 00:18:51', '2026-01-30 00:18:51'),
(56, 3, 2, 2, 'Insectocutores', '2026-04-14', 'bg-pink-600', 'pendiente', '2026-01-30 00:18:51', '2026-01-30 00:18:51'),
(57, 3, 2, 2, 'Insectocutores', '2026-04-21', 'bg-pink-600', 'pendiente', '2026-01-30 00:18:51', '2026-01-30 00:18:51'),
(58, 3, 2, 2, 'Insectocutores', '2026-04-28', 'bg-pink-600', 'pendiente', '2026-01-30 00:18:51', '2026-01-30 00:18:51'),
(59, 3, 2, 2, 'Insectocutores', '2026-05-05', 'bg-pink-600', 'pendiente', '2026-01-30 00:18:51', '2026-01-30 00:18:51'),
(60, 3, 2, 2, 'Insectocutores', '2026-05-12', 'bg-pink-600', 'pendiente', '2026-01-30 00:18:52', '2026-01-30 00:18:52'),
(61, 3, 2, 2, 'Insectocutores', '2026-05-19', 'bg-pink-600', 'pendiente', '2026-01-30 00:18:52', '2026-01-30 00:18:52'),
(62, 3, 2, 2, 'Insectocutores', '2026-05-26', 'bg-pink-600', 'pendiente', '2026-01-30 00:18:52', '2026-01-30 00:18:52'),
(63, 3, 2, 2, 'Insectocutores', '2026-06-02', 'bg-pink-600', 'pendiente', '2026-01-30 00:18:52', '2026-01-30 00:18:52'),
(64, 3, 2, 2, 'Insectocutores', '2026-06-09', 'bg-pink-600', 'pendiente', '2026-01-30 00:18:52', '2026-01-30 00:18:52'),
(65, 3, 2, 2, 'Insectocutores', '2026-06-16', 'bg-pink-600', 'pendiente', '2026-01-30 00:18:52', '2026-01-30 00:18:52'),
(66, 3, 2, 2, 'Insectocutores', '2026-06-23', 'bg-pink-600', 'pendiente', '2026-01-30 00:18:52', '2026-01-30 00:18:52'),
(67, 3, 2, 2, 'Insectocutores', '2026-07-07', 'bg-pink-600', 'pendiente', '2026-01-30 00:18:52', '2026-01-30 00:18:52'),
(68, 3, 2, 2, 'Insectocutores', '2026-07-14', 'bg-pink-600', 'pendiente', '2026-01-30 00:18:52', '2026-01-30 00:18:52'),
(69, 3, 2, 2, 'Insectocutores', '2026-07-21', 'bg-pink-600', 'pendiente', '2026-01-30 00:18:52', '2026-01-30 00:18:52'),
(70, 3, 2, 2, 'Insectocutores', '2026-07-28', 'bg-pink-600', 'pendiente', '2026-01-30 00:18:52', '2026-01-30 00:18:52'),
(71, 3, 2, 2, 'Insectocutores', '2026-08-04', 'bg-pink-600', 'pendiente', '2026-01-30 00:18:52', '2026-01-30 00:18:52'),
(72, 3, 2, 2, 'Insectocutores', '2026-08-11', 'bg-pink-600', 'pendiente', '2026-01-30 00:18:53', '2026-01-30 00:18:53'),
(73, 3, 2, 2, 'Insectocutores', '2026-08-18', 'bg-pink-600', 'pendiente', '2026-01-30 00:18:53', '2026-01-30 00:18:53'),
(74, 3, 2, 2, 'Insectocutores', '2026-08-25', 'bg-pink-600', 'pendiente', '2026-01-30 00:18:53', '2026-01-30 00:18:53'),
(75, 3, 2, 2, 'Insectocutores', '2026-09-01', 'bg-pink-600', 'pendiente', '2026-01-30 00:18:53', '2026-01-30 00:18:53'),
(76, 3, 2, 2, 'Insectocutores', '2026-09-08', 'bg-pink-600', 'pendiente', '2026-01-30 00:18:53', '2026-01-30 00:18:53'),
(77, 3, 2, 2, 'Insectocutores', '2026-09-15', 'bg-pink-600', 'pendiente', '2026-01-30 00:18:53', '2026-01-30 00:18:53'),
(78, 3, 2, 2, 'Insectocutores', '2026-09-22', 'bg-pink-600', 'pendiente', '2026-01-30 00:18:53', '2026-01-30 00:18:53'),
(79, 3, 2, 2, 'Insectocutores', '2026-10-06', 'bg-pink-600', 'pendiente', '2026-01-30 00:18:53', '2026-01-30 00:18:53'),
(80, 3, 2, 2, 'Insectocutores', '2026-10-13', 'bg-pink-600', 'pendiente', '2026-01-30 00:18:53', '2026-01-30 00:18:53'),
(81, 3, 2, 2, 'Insectocutores', '2026-10-20', 'bg-pink-600', 'pendiente', '2026-01-30 00:18:53', '2026-01-30 00:18:53'),
(82, 3, 2, 2, 'Insectocutores', '2026-10-27', 'bg-pink-600', 'pendiente', '2026-01-30 00:18:53', '2026-01-30 00:18:53'),
(83, 3, 2, 2, 'Insectocutores', '2026-11-03', 'bg-pink-600', 'pendiente', '2026-01-30 00:18:53', '2026-01-30 00:18:53'),
(84, 3, 2, 2, 'Insectocutores', '2026-11-10', 'bg-pink-600', 'pendiente', '2026-01-30 00:18:54', '2026-01-30 00:18:54'),
(85, 3, 2, 2, 'Insectocutores', '2026-11-17', 'bg-pink-600', 'pendiente', '2026-01-30 00:18:54', '2026-01-30 00:18:54'),
(86, 3, 2, 2, 'Insectocutores', '2026-11-24', 'bg-pink-600', 'pendiente', '2026-01-30 00:18:54', '2026-01-30 00:18:54'),
(87, 3, 2, 2, 'Insectocutores', '2026-12-01', 'bg-pink-600', 'pendiente', '2026-01-30 00:18:54', '2026-01-30 00:18:54'),
(88, 3, 2, 2, 'Insectocutores', '2026-12-08', 'bg-pink-600', 'pendiente', '2026-01-30 00:18:54', '2026-01-30 00:18:54'),
(89, 3, 2, 2, 'Insectocutores', '2026-12-15', 'bg-pink-600', 'pendiente', '2026-01-30 00:18:54', '2026-01-30 00:18:54'),
(90, 3, 2, 2, 'Insectocutores', '2026-12-22', 'bg-pink-600', 'pendiente', '2026-01-30 00:18:54', '2026-01-30 00:18:54'),
(91, 4, 2, 2, 'Desratización', '2026-02-10', 'bg-yellow-500', 'pendiente', '2026-01-30 13:12:12', '2026-01-30 13:12:12'),
(92, 4, 2, 2, 'Fumigación', '2026-02-24', 'bg-blue-500', 'pendiente', '2026-01-30 13:12:12', '2026-01-30 13:12:12'),
(93, 4, 2, 2, 'Insectocutores', '2026-02-20', 'bg-pink-600', 'pendiente', '2026-01-30 13:12:12', '2026-01-30 13:12:12');

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
(1, NULL, 1, NULL, 2, 'Contrato por cobrar #1', 'Saldo pendiento por cobrar sobre contrato', 4650, 4650, 'Pendiente', NULL, 0, '2026-01-28 12:59:24', '2026-01-28 12:59:24'),
(2, NULL, 2, NULL, 2, 'Contrato por cobrar #2', 'Saldo pendiento por cobrar sobre contrato', 21130, 21130, 'Pendiente', NULL, 0, '2026-01-28 14:29:19', '2026-01-28 14:29:19'),
(3, NULL, 3, NULL, 2, 'Contrato por cobrar #3', 'Saldo pendiento por cobrar sobre contrato', 30104.4, 30104.4, 'Pendiente', NULL, 0, '2026-01-30 00:18:54', '2026-01-30 00:18:54'),
(4, NULL, 4, NULL, 2, 'Contrato por cobrar #4', 'Saldo pendiento por cobrar sobre contrato', 2800, 2800, 'Pendiente', NULL, 0, '2026-01-30 13:12:13', '2026-01-30 13:12:13');

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
(1, 'Gastos bancarios operativos', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(2, 'Capacitacion y cursos', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(3, 'Licencias de Software', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(4, 'Gastos de representación', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(5, 'Eventos y actividades', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(6, 'Seguridad y vigilancia', '2026-01-28 12:31:34', '2026-01-28 12:31:34');

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
(1, 'Sueldos administrativos', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(2, 'Honorarios profesionales', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(3, 'Utiles de oficina', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(4, 'Alquiler de oficina', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(5, 'Energia Electrica', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(6, 'Agua', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(7, 'Telefono', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(8, 'Mantenimiento y reparaciones', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(9, 'Limpieza', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(10, 'Seguros', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(11, 'Depresiacion', '2026-01-28 12:31:34', '2026-01-28 12:31:34');

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
(1, 'Sueldos personal', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(2, 'Comisiones sobre ventas', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(3, 'Marketing digital', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(4, 'Material promocional', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(5, 'Transporte y distribucion', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(6, 'Combustible', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(7, 'Viaticos y movilidad', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(8, 'Empaques y embalajes', '2026-01-28 12:31:34', '2026-01-28 12:31:34');

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
(1, 'cascada', 'C. GUERRILLEROS LANZA #1328, MIRAFLORES', '76738282', 'jotamontero.fm@gmail.com', 'La Paz', 1, '2026-01-28 12:59:23', '2026-01-28 12:59:23'),
(2, 'quimiza', 'C. GUERRILLEROS LANZA #1328, MIRAFLORES', '76738282', 'jotamontero.fm@gmail.com', 'La Paz', 1, '2026-01-28 14:29:19', '2026-01-28 14:29:19'),
(3, 'ransa', 'Bolivia| P.I. Mz.40, Almacenes Ferrotodo, Nave 3 y 4 -Santa Cruz.', '77695930', 'AquispeB@ransa.net', 'SANTA CRUZ', 1, '2026-01-30 00:18:47', '2026-01-30 00:18:47'),
(4, 'uno', 'ma', '87979879', 'uno@uno.com', 'lp', 1, '2026-01-30 13:12:11', '2026-01-30 13:12:11');

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
(1, 'Ropa de trabajo', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(2, 'Casco de proteccion', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(3, 'Gorra', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(4, 'Guantes', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(5, 'Overol', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(6, 'Botas', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(7, 'Gafas', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(8, 'Antiparras', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(9, 'Respirados', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(10, 'Full face', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(11, 'Otros', '2026-01-28 12:31:34', '2026-01-28 12:31:34');

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
(1, 'Moscas', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(2, 'Polillas', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(3, 'Mosquitos', '2026-01-28 12:31:34', '2026-01-28 12:31:34');

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
(1, 2, 'INSECTICIDA PIRETROIDE AMPLIO ESPECTRO', 'hojas-tecnicas/2ALdCYmOtYIIUTA3FZOVbKyUoWJcG9dtrTKN4Pzd.pdf', NULL, NULL, NULL, '2026-01-28 13:29:29', '2026-01-28 13:29:29'),
(2, 2, 'REGISTRO INSO', 'hojas-tecnicas/VPaKyC1OzF7wBCLUzg4epuSv1Uaf6cTIgLtMKh31.jpg', NULL, NULL, NULL, '2026-01-28 13:30:49', '2026-01-28 13:30:49');

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
(1, 1, 1, 2, NULL, 'images/mapas/1_1769609100.png', '2026-01-28 13:05:00', '2026-01-28 13:05:00'),
(2, 2, 2, 2, NULL, 'images/mapas/2_1769614656.png', '2026-01-28 14:37:36', '2026-01-28 14:37:36'),
(3, 4, 4, 2, NULL, 'images/mapas/4_1769782362.jpeg', '2026-01-30 13:12:42', '2026-01-30 13:12:42'),
(4, 4, 4, 2, NULL, 'images/mapas/4_1769782377.jpeg', '2026-01-30 13:12:57', '2026-01-30 13:12:57'),
(5, 4, 4, 2, NULL, NULL, '2026-01-30 13:13:21', '2026-01-30 13:13:21');

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
(1, 'Alimento con veneno', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(2, 'Sustancia pegajosa', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(3, 'Alimento', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(4, 'Aspersion', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(5, 'Niebla', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(6, 'Nebulizacion', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(7, 'Fumigacion', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(8, 'Otros', '2026-01-28 12:31:34', '2026-01-28 12:31:34');

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
(1, 'App\\Models\\User', 2),
(3, 'App\\Models\\User', 3),
(4, 'App\\Models\\User', 4);

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
(1, 'empresas', 'web', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(2, 'cotizaciones', 'web', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(3, 'contratos', 'web', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(4, 'almacenes', 'web', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(5, 'cronogramas', 'web', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(6, 'mapas', 'web', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(7, 'seguimientos', 'web', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(8, 'certificados', 'web', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(9, 'cuentascobrar', 'web', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(10, 'cuentaspagar', 'web', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(11, 'compras', 'web', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(12, 'ingresos', 'web', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(13, 'retiros', 'web', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(14, 'gastos', 'web', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(15, 'productos', 'web', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(16, 'categorias', 'web', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(17, 'subcategorias', 'web', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(18, 'marcas', 'web', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(19, 'etiquetas', 'web', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(20, 'proveedores', 'web', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(21, 'inventario', 'web', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(22, 'agenda', 'web', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(23, 'documentos', 'web', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(24, 'usuarios', 'web', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(25, 'configuraciones', 'web', '2026-01-28 12:31:34', '2026-01-28 12:31:34');

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
(1, NULL, NULL, 1, 'klerat', 'rodenticida anticuagulante', 150, NULL, 1, NULL, NULL, '2026-01-28 13:09:30', '2026-01-28 13:09:30'),
(2, NULL, NULL, 4, 'TITANE DELTA', 'INSECTICIDA PIRETROIDE', 1, NULL, 5, NULL, NULL, '2026-01-28 13:27:45', '2026-01-28 13:27:45');

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
(1, 1, 1, 1, 450, '2026-01-28 13:24:03', '2026-01-28 13:24:03'),
(2, 2, 3, 4, 1, '2026-01-28 13:46:38', '2026-01-28 13:46:38');

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
(1, 'Señalizacion', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(2, 'Hoja de seguimiento', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(3, 'Otros', '2026-01-28 12:31:34', '2026-01-28 12:31:34');

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
(1, 'superadmin', 'web', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(2, 'admin', 'web', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(3, 'tecnico', 'web', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(4, 'cliente', 'web', '2026-01-28 12:31:34', '2026-01-28 12:31:34');

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
(1, 1, 1, 2, 2, NULL, 'FRANKLIN FLORES', 'ENCARGADO DE PLANTA', 'images/firmas/firma_encargado_1769610242.png', 'images/firmas/firma_supervisor_1769610242.png', 'SE CUMPLIO CON EL CRONOGRAMA DE ACTIVIDADES', 'SE REALIZO LA PRIMERA EVALUACION DE CONTROL DE ROEDORES', '2026-01-28 13:24:02', '2026-01-28 13:24:02'),
(2, 1, 1, 2, 3, NULL, 'FRANKLIN PAREJA', 'ENCARGADO ALMACEN', 'images/firmas/firma_encargado_1769611278.png', 'images/firmas/firma_supervisor_1769611278.png', NULL, 'SE TRABAJO CON LOS TRES INSECTOCUTORES', '2026-01-28 13:41:18', '2026-01-28 13:41:18'),
(3, 1, 1, 2, 1, NULL, 'FRANKLIN FLORES', 'ENCARGADO DE ALMACEN', 'images/firmas/firma_encargado_1769611597.png', 'images/firmas/firma_supervisor_1769611597.png', NULL, 'PRIMERA APLICACION', '2026-01-28 13:46:37', '2026-01-28 13:46:37');

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
(1, 1, 2, '2026-01-28 13:24:03', '2026-01-28 13:24:03'),
(2, 1, 4, '2026-01-28 13:24:03', '2026-01-28 13:24:03'),
(3, 1, 5, '2026-01-28 13:24:03', '2026-01-28 13:24:03'),
(4, 1, 1, '2026-01-28 13:24:03', '2026-01-28 13:24:03'),
(5, 1, 6, '2026-01-28 13:24:03', '2026-01-28 13:24:03'),
(6, 2, 2, '2026-01-28 13:41:18', '2026-01-28 13:41:18'),
(7, 2, 4, '2026-01-28 13:41:18', '2026-01-28 13:41:18'),
(8, 2, 5, '2026-01-28 13:41:19', '2026-01-28 13:41:19'),
(9, 2, 6, '2026-01-28 13:41:19', '2026-01-28 13:41:19'),
(10, 2, 1, '2026-01-28 13:41:19', '2026-01-28 13:41:19'),
(11, 3, 10, '2026-01-28 13:46:38', '2026-01-28 13:46:38'),
(12, 3, 6, '2026-01-28 13:46:38', '2026-01-28 13:46:38'),
(13, 3, 4, '2026-01-28 13:46:38', '2026-01-28 13:46:38'),
(14, 3, 5, '2026-01-28 13:46:38', '2026-01-28 13:46:38'),
(15, 3, 2, '2026-01-28 13:46:38', '2026-01-28 13:46:38'),
(16, 3, 1, '2026-01-28 13:46:38', '2026-01-28 13:46:38');

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
(1, 1, 'images/seguimientos/697a1c045cc14_CAJA 6 ROEDOR.jpg', '2026-01-28 13:24:04', '2026-01-28 13:24:04'),
(2, 1, 'images/seguimientos/697a1c04669db_CAJA 10.jpg', '2026-01-28 13:24:04', '2026-01-28 13:24:04'),
(3, 1, 'images/seguimientos/697a1c0470f5f_CAJA 21.jpg', '2026-01-28 13:24:04', '2026-01-28 13:24:04'),
(4, 1, 'images/seguimientos/697a1c047abd3_CAJA19.jpg', '2026-01-28 13:24:04', '2026-01-28 13:24:04'),
(5, 2, 'images/seguimientos/697a2011262f3_bcb 4.jpg', '2026-01-28 13:41:21', '2026-01-28 13:41:21'),
(6, 2, 'images/seguimientos/697a2011300bc_bcb 6.jpg', '2026-01-28 13:41:21', '2026-01-28 13:41:21'),
(7, 2, 'images/seguimientos/697a201139e3a_bcb 8.jpg', '2026-01-28 13:41:21', '2026-01-28 13:41:21'),
(8, 3, 'images/seguimientos/697a21504398c_bcb 8.jpg', '2026-01-28 13:46:40', '2026-01-28 13:46:40');

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
(1, 1, 3, '2026-01-28 13:24:02', '2026-01-28 13:24:02'),
(2, 1, 1, '2026-01-28 13:24:03', '2026-01-28 13:24:03'),
(3, 1, 2, '2026-01-28 13:24:03', '2026-01-28 13:24:03'),
(4, 3, 4, '2026-01-28 13:46:38', '2026-01-28 13:46:38'),
(5, 3, 6, '2026-01-28 13:46:38', '2026-01-28 13:46:38');

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
(1, 1, 2, '2026-01-28 13:24:03', '2026-01-28 13:24:03'),
(2, 1, 1, '2026-01-28 13:24:03', '2026-01-28 13:24:03'),
(3, 2, 2, '2026-01-28 13:41:19', '2026-01-28 13:41:19'),
(4, 2, 1, '2026-01-28 13:41:19', '2026-01-28 13:41:19'),
(5, 3, 2, '2026-01-28 13:46:38', '2026-01-28 13:46:38'),
(6, 3, 1, '2026-01-28 13:46:38', '2026-01-28 13:46:38');

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
('1oFSMLPLAfao6fjyxkYrzMCGbcwkSwCdYShOvjXG', NULL, '66.249.83.110', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWVhMeTBKb0lqU1RZNTdkNDdlOFhsNk1sZTFhbEwwY1k3VFZ2YlpOVCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mzg6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmJpdGRlc2Fycm9sbG8ubmV0IjtzOjU6InJvdXRlIjtzOjQ6ImhvbWUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1769776116),
('DiViI70dOi08xYlKgaihDpWt8jdtzTwBRYcsUtFj', NULL, '66.249.83.110', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiS2xJdnd6Vk51b2lHZkhDT3o2bjE0V0tMempLajR2SFZrNldxY2lUQSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mzg6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmJpdGRlc2Fycm9sbG8ubmV0IjtzOjU6InJvdXRlIjtzOjQ6ImhvbWUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1769776115),
('E9Lyrfit5OOqDWqZV85dQXsFEW4NfIrS4Fg9ZVTj', 2, '177.222.49.62', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiZWxLNEFIY0JncHhXYVVSWkJzd09qMzR4cUZVN0RlSUV1TEVkN25YTiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NjY6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmJpdGRlc2Fycm9sbG8ubmV0L3RyYW1wYXNlZ3VpbWllbnRvcy9lc3BlY2llcyI7czo1OiJyb3V0ZSI7czoyNzoidHJhbXBhc2VndWltaWVudG9zLmVzcGVjaWVzIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6Mjt9', 1769777473),
('ksHDuay7NcKVYza2R22wRbkYafkpnJMEpHhT2uUi', NULL, '66.249.83.132', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNG0wZnNFZFgxZWJuYURyc2dGeGZjaG9PUUw3SDRyQ1dNSG9zMXFVViI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mzg6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmJpdGRlc2Fycm9sbG8ubmV0IjtzOjU6InJvdXRlIjtzOjQ6ImhvbWUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1769776114),
('lLHao6geA0l4rrLlgEF2A5cOI5raXon5z7BHmbwC', 2, '177.222.49.62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoicWY5ZXpveXlZV09pM3NvaDdwY3VaYVBpQUJuVUhaaHc5VnhDaEN0ciI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NjY6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmJpdGRlc2Fycm9sbG8ubmV0L3RyYW1wYXNlZ3VpbWllbnRvcy9lc3BlY2llcyI7czo1OiJyb3V0ZSI7czoyNzoidHJhbXBhc2VndWltaWVudG9zLmVzcGVjaWVzIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6Mjt9', 1769782796);

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
(1, 'Huellas', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(2, 'Roeduras', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(3, 'Madriguera', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(4, 'Senda', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(5, 'Excrementos', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(6, 'Marca de orina', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(7, 'Otros', '2026-01-28 12:31:34', '2026-01-28 12:31:34');

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
(1, 'DESINFECCION', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(2, 'DESRATIZACION', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(3, 'DESINSECTACION', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(4, 'CONTROL DE AVES', '2026-01-28 12:31:34', '2026-01-28 12:31:34');

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
(1, 1, 1, 3, 1, 'null', 911, 683, 'activo', '2026-01-28 13:05:01', '2026-01-28 13:05:01'),
(2, 1, 1, 3, 2, 'null', 729, 682, 'activo', '2026-01-28 13:05:01', '2026-01-28 13:05:01'),
(3, 1, 1, 3, 3, 'null', 557, 581, 'activo', '2026-01-28 13:05:01', '2026-01-28 13:05:01'),
(4, 1, 1, 3, 4, 'null', 457, 517, 'activo', '2026-01-28 13:05:01', '2026-01-28 13:05:01'),
(5, 1, 1, 3, 5, 'null', 325, 431, 'activo', '2026-01-28 13:05:01', '2026-01-28 13:05:01'),
(6, 1, 1, 3, 6, 'null', 204, 356, 'activo', '2026-01-28 13:05:01', '2026-01-28 13:05:01'),
(7, 1, 1, 3, 7, 'null', 126, 299, 'activo', '2026-01-28 13:05:01', '2026-01-28 13:05:01'),
(8, 1, 1, 3, 8, 'null', 24, 169, 'activo', '2026-01-28 13:05:01', '2026-01-28 13:05:01'),
(9, 1, 1, 3, 9, 'null', 230, 89, 'activo', '2026-01-28 13:05:01', '2026-01-28 13:05:01'),
(10, 1, 1, 3, 10, 'null', 234, 228, 'activo', '2026-01-28 13:05:01', '2026-01-28 13:05:01'),
(11, 1, 1, 3, 11, 'null', 308, 82, 'activo', '2026-01-28 13:05:01', '2026-01-28 13:05:01'),
(12, 1, 1, 3, 12, 'null', 310, 215, 'activo', '2026-01-28 13:05:01', '2026-01-28 13:05:01'),
(13, 1, 1, 4, 13, 'null', 593, 82, 'activo', '2026-01-28 13:05:01', '2026-01-28 13:05:01'),
(14, 1, 1, 4, 14, 'null', 430, 76, 'activo', '2026-01-28 13:05:01', '2026-01-28 13:05:01'),
(15, 1, 1, 4, 15, 'null', 371, 229, 'activo', '2026-01-28 13:05:01', '2026-01-28 13:05:01'),
(16, 1, 1, 4, 16, 'null', 470, 230, 'activo', '2026-01-28 13:05:01', '2026-01-28 13:05:01'),
(17, 1, 1, 4, 17, 'null', 583, 225, 'activo', '2026-01-28 13:05:01', '2026-01-28 13:05:01'),
(18, 1, 1, 4, 18, 'null', 591, 138, 'activo', '2026-01-28 13:05:01', '2026-01-28 13:05:01'),
(19, 1, 1, 4, 19, 'null', 604, 245, 'activo', '2026-01-28 13:05:01', '2026-01-28 13:05:01'),
(20, 1, 1, 4, 20, 'null', 690, 244, 'activo', '2026-01-28 13:05:01', '2026-01-28 13:05:01'),
(21, 1, 1, 3, 1, NULL, 911, 683, 'activo', '2026-01-28 13:37:08', '2026-01-28 13:37:08'),
(22, 1, 1, 3, 2, NULL, 729, 682, 'activo', '2026-01-28 13:37:08', '2026-01-28 13:37:08'),
(23, 1, 1, 3, 3, NULL, 557, 581, 'activo', '2026-01-28 13:37:08', '2026-01-28 13:37:08'),
(24, 1, 1, 3, 4, NULL, 457, 517, 'activo', '2026-01-28 13:37:08', '2026-01-28 13:37:08'),
(25, 1, 1, 3, 5, NULL, 325, 431, 'activo', '2026-01-28 13:37:08', '2026-01-28 13:37:08'),
(26, 1, 1, 3, 6, NULL, 204, 356, 'activo', '2026-01-28 13:37:08', '2026-01-28 13:37:08'),
(27, 1, 1, 3, 7, NULL, 126, 299, 'activo', '2026-01-28 13:37:08', '2026-01-28 13:37:08'),
(28, 1, 1, 3, 8, NULL, 24, 169, 'activo', '2026-01-28 13:37:08', '2026-01-28 13:37:08'),
(29, 1, 1, 3, 9, NULL, 230, 89, 'activo', '2026-01-28 13:37:08', '2026-01-28 13:37:08'),
(30, 1, 1, 3, 10, NULL, 234, 228, 'activo', '2026-01-28 13:37:08', '2026-01-28 13:37:08'),
(31, 1, 1, 3, 11, NULL, 308, 82, 'activo', '2026-01-28 13:37:08', '2026-01-28 13:37:08'),
(32, 1, 1, 3, 12, NULL, 310, 215, 'activo', '2026-01-28 13:37:08', '2026-01-28 13:37:08'),
(33, 1, 1, 4, 13, NULL, 593, 82, 'activo', '2026-01-28 13:37:08', '2026-01-28 13:37:08'),
(34, 1, 1, 4, 14, NULL, 430, 76, 'activo', '2026-01-28 13:37:08', '2026-01-28 13:37:08'),
(35, 1, 1, 4, 15, NULL, 371, 229, 'activo', '2026-01-28 13:37:08', '2026-01-28 13:37:08'),
(36, 1, 1, 4, 16, NULL, 470, 230, 'activo', '2026-01-28 13:37:08', '2026-01-28 13:37:08'),
(37, 1, 1, 4, 17, NULL, 583, 225, 'activo', '2026-01-28 13:37:08', '2026-01-28 13:37:08'),
(38, 1, 1, 4, 18, NULL, 591, 138, 'activo', '2026-01-28 13:37:09', '2026-01-28 13:37:09'),
(39, 1, 1, 4, 19, NULL, 604, 245, 'activo', '2026-01-28 13:37:09', '2026-01-28 13:37:09'),
(40, 1, 1, 4, 20, NULL, 690, 244, 'activo', '2026-01-28 13:37:09', '2026-01-28 13:37:09'),
(41, 1, 1, 2, 21, NULL, 669, 572, 'activo', '2026-01-28 13:37:09', '2026-01-28 13:37:09'),
(42, 1, 1, 2, 22, NULL, 796, 440, 'activo', '2026-01-28 13:37:09', '2026-01-28 13:37:09'),
(43, 1, 1, 2, 23, NULL, 421, 249, 'activo', '2026-01-28 13:37:09', '2026-01-28 13:37:09'),
(44, 1, 1, 3, 1, NULL, 911, 683, 'activo', '2026-01-28 14:07:16', '2026-01-28 14:07:16'),
(45, 1, 1, 3, 2, NULL, 729, 682, 'activo', '2026-01-28 14:07:16', '2026-01-28 14:07:16'),
(46, 1, 1, 3, 3, NULL, 557, 581, 'activo', '2026-01-28 14:07:16', '2026-01-28 14:07:16'),
(47, 1, 1, 3, 4, NULL, 457, 517, 'activo', '2026-01-28 14:07:16', '2026-01-28 14:07:16'),
(48, 1, 1, 3, 5, NULL, 325, 431, 'activo', '2026-01-28 14:07:16', '2026-01-28 14:07:16'),
(49, 1, 1, 3, 6, NULL, 204, 356, 'activo', '2026-01-28 14:07:16', '2026-01-28 14:07:16'),
(50, 1, 1, 3, 7, NULL, 126, 299, 'activo', '2026-01-28 14:07:16', '2026-01-28 14:07:16'),
(51, 1, 1, 3, 8, NULL, 24, 169, 'activo', '2026-01-28 14:07:17', '2026-01-28 14:07:17'),
(52, 1, 1, 3, 9, NULL, 230, 89, 'activo', '2026-01-28 14:07:17', '2026-01-28 14:07:17'),
(53, 1, 1, 3, 10, NULL, 234, 228, 'activo', '2026-01-28 14:07:17', '2026-01-28 14:07:17'),
(54, 1, 1, 3, 11, NULL, 308, 82, 'activo', '2026-01-28 14:07:17', '2026-01-28 14:07:17'),
(55, 1, 1, 3, 12, NULL, 310, 215, 'activo', '2026-01-28 14:07:17', '2026-01-28 14:07:17'),
(56, 1, 1, 4, 13, NULL, 593, 82, 'activo', '2026-01-28 14:07:17', '2026-01-28 14:07:17'),
(57, 1, 1, 4, 14, NULL, 430, 76, 'activo', '2026-01-28 14:07:17', '2026-01-28 14:07:17'),
(58, 1, 1, 4, 15, NULL, 371, 229, 'activo', '2026-01-28 14:07:17', '2026-01-28 14:07:17'),
(59, 1, 1, 4, 16, NULL, 470, 230, 'activo', '2026-01-28 14:07:17', '2026-01-28 14:07:17'),
(60, 1, 1, 4, 17, NULL, 583, 225, 'activo', '2026-01-28 14:07:17', '2026-01-28 14:07:17'),
(61, 1, 1, 4, 18, NULL, 591, 138, 'activo', '2026-01-28 14:07:17', '2026-01-28 14:07:17'),
(62, 1, 1, 4, 19, NULL, 604, 245, 'activo', '2026-01-28 14:07:17', '2026-01-28 14:07:17'),
(63, 1, 1, 4, 20, NULL, 690, 244, 'activo', '2026-01-28 14:07:17', '2026-01-28 14:07:17'),
(64, 1, 1, 3, 21, NULL, 911, 683, 'activo', '2026-01-28 14:07:17', '2026-01-28 14:07:17'),
(65, 1, 1, 3, 22, NULL, 729, 682, 'activo', '2026-01-28 14:07:17', '2026-01-28 14:07:17'),
(66, 1, 1, 3, 23, NULL, 557, 581, 'activo', '2026-01-28 14:07:17', '2026-01-28 14:07:17'),
(67, 1, 1, 3, 24, NULL, 457, 517, 'activo', '2026-01-28 14:07:17', '2026-01-28 14:07:17'),
(68, 1, 1, 3, 25, NULL, 325, 431, 'activo', '2026-01-28 14:07:17', '2026-01-28 14:07:17'),
(69, 1, 1, 3, 26, NULL, 204, 356, 'activo', '2026-01-28 14:07:17', '2026-01-28 14:07:17'),
(70, 1, 1, 3, 27, NULL, 126, 299, 'activo', '2026-01-28 14:07:17', '2026-01-28 14:07:17'),
(71, 1, 1, 3, 28, NULL, 24, 169, 'activo', '2026-01-28 14:07:17', '2026-01-28 14:07:17'),
(72, 1, 1, 3, 29, NULL, 230, 89, 'activo', '2026-01-28 14:07:18', '2026-01-28 14:07:18'),
(73, 1, 1, 3, 30, NULL, 234, 228, 'activo', '2026-01-28 14:07:18', '2026-01-28 14:07:18'),
(74, 1, 1, 3, 31, NULL, 308, 82, 'activo', '2026-01-28 14:07:18', '2026-01-28 14:07:18'),
(75, 1, 1, 3, 32, NULL, 310, 215, 'activo', '2026-01-28 14:07:18', '2026-01-28 14:07:18'),
(76, 1, 1, 4, 33, NULL, 593, 82, 'activo', '2026-01-28 14:07:18', '2026-01-28 14:07:18'),
(77, 1, 1, 4, 34, NULL, 430, 76, 'activo', '2026-01-28 14:07:18', '2026-01-28 14:07:18'),
(78, 1, 1, 4, 35, NULL, 371, 229, 'activo', '2026-01-28 14:07:18', '2026-01-28 14:07:18'),
(79, 1, 1, 4, 36, NULL, 470, 230, 'activo', '2026-01-28 14:07:18', '2026-01-28 14:07:18'),
(80, 1, 1, 4, 37, NULL, 583, 225, 'activo', '2026-01-28 14:07:18', '2026-01-28 14:07:18'),
(81, 1, 1, 4, 38, NULL, 591, 138, 'activo', '2026-01-28 14:07:18', '2026-01-28 14:07:18'),
(82, 1, 1, 4, 39, NULL, 604, 245, 'activo', '2026-01-28 14:07:18', '2026-01-28 14:07:18'),
(83, 1, 1, 4, 40, NULL, 690, 244, 'activo', '2026-01-28 14:07:18', '2026-01-28 14:07:18'),
(84, 1, 1, 2, 41, NULL, 669, 572, 'activo', '2026-01-28 14:07:18', '2026-01-28 14:07:18'),
(85, 1, 1, 2, 42, NULL, 796, 440, 'activo', '2026-01-28 14:07:18', '2026-01-28 14:07:18'),
(86, 1, 1, 2, 43, NULL, 421, 249, 'activo', '2026-01-28 14:07:18', '2026-01-28 14:07:18'),
(87, 2, 2, 4, 1, 'null', 282, 55, 'activo', '2026-01-28 14:37:36', '2026-01-28 14:37:36'),
(88, 2, 2, 4, 2, 'null', 667, 198, 'activo', '2026-01-28 14:37:36', '2026-01-28 14:37:36'),
(89, 2, 2, 4, 3, 'null', 243, 106, 'activo', '2026-01-28 14:37:36', '2026-01-28 14:37:36'),
(90, 2, 2, 4, 4, 'null', 182, 123, 'activo', '2026-01-28 14:37:36', '2026-01-28 14:37:36'),
(93, 4, 4, 1, 1, 'null', 226, 216, 'activo', '2026-01-30 13:12:57', '2026-01-30 13:12:57'),
(94, 4, 4, 5, 2, 'null', 561, 256, 'activo', '2026-01-30 13:12:57', '2026-01-30 13:12:57'),
(98, 4, 5, 1, 1, 'null', 226, 216, 'activo', '2026-01-30 13:13:21', '2026-01-30 13:13:21'),
(99, 4, 5, 5, 2, 'null', 561, 256, 'activo', '2026-01-30 13:13:21', '2026-01-30 13:13:21'),
(100, 4, 5, 2, 3, 'null', 902, 136, 'activo', '2026-01-30 13:13:21', '2026-01-30 13:13:21'),
(105, 4, 3, 1, 1, NULL, 226, 216, 'activo', '2026-01-30 13:14:26', '2026-01-30 13:14:26'),
(106, 4, 3, 5, 2, NULL, 561, 256, 'activo', '2026-01-30 13:14:26', '2026-01-30 13:14:26'),
(107, 4, 3, 2, 3, NULL, 902, 136, 'activo', '2026-01-30 13:14:26', '2026-01-30 13:14:26'),
(108, 4, 3, 3, 4, NULL, 412, 381, 'activo', '2026-01-30 13:14:27', '2026-01-30 13:14:27'),
(109, 4, 3, 4, 5, NULL, 594, 106, 'activo', '2026-01-30 13:14:27', '2026-01-30 13:14:27');

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
(1, 2, 41, 1, 10, '2026-01-28 13:41:19', '2026-01-28 13:41:19'),
(2, 2, 41, 2, 5, '2026-01-28 13:41:19', '2026-01-28 13:41:19'),
(3, 2, 42, 2, 3, '2026-01-28 13:41:19', '2026-01-28 13:41:19'),
(4, 2, 42, 1, 8, '2026-01-28 13:41:19', '2026-01-28 13:41:19'),
(5, 2, 42, 3, 10, '2026-01-28 13:41:19', '2026-01-28 13:41:19'),
(6, 2, 43, 1, 5, '2026-01-28 13:41:19', '2026-01-28 13:41:19');

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
(1, 1, 1, 'MA', 0, 40, 20, 20, '2026-01-28 13:24:03', '2026-01-28 13:24:03'),
(2, 1, 2, 'MA', 0, 40, 15, 25, '2026-01-28 13:24:03', '2026-01-28 13:24:03'),
(3, 1, 3, 'MA', 0, 40, 12, 28, '2026-01-28 13:24:03', '2026-01-28 13:24:03'),
(4, 1, 4, 'MA', 0, 40, 14, 26, '2026-01-28 13:24:03', '2026-01-28 13:24:03'),
(5, 1, 5, 'C', 1, 40, 5, 35, '2026-01-28 13:24:03', '2026-01-28 13:24:03'),
(6, 1, 6, 'MA', 0, 40, 12, 28, '2026-01-28 13:24:03', '2026-01-28 13:24:03'),
(7, 1, 7, 'MA', 0, 40, 18, 22, '2026-01-28 13:24:03', '2026-01-28 13:24:03'),
(8, 1, 8, 'C', 0, 40, 5, 35, '2026-01-28 13:24:03', '2026-01-28 13:24:03'),
(9, 1, 9, 'MA', 0, 40, 22, 18, '2026-01-28 13:24:03', '2026-01-28 13:24:03'),
(10, 1, 10, 'C', 0, 40, 18, 22, '2026-01-28 13:24:03', '2026-01-28 13:24:03'),
(11, 1, 11, 'C', 0, 40, 10, 30, '2026-01-28 13:24:03', '2026-01-28 13:24:03'),
(12, 1, 12, 'MA', 0, 40, 21, 19, '2026-01-28 13:24:03', '2026-01-28 13:24:03'),
(13, 1, 13, 'MA', 0, 40, 25, 15, '2026-01-28 13:24:04', '2026-01-28 13:24:04'),
(14, 1, 14, 'MA', 0, 40, 22, 18, '2026-01-28 13:24:04', '2026-01-28 13:24:04'),
(15, 1, 15, 'MA', 0, 40, 25, 15, '2026-01-28 13:24:04', '2026-01-28 13:24:04'),
(16, 1, 16, 'MA', 0, 40, 22, 18, '2026-01-28 13:24:04', '2026-01-28 13:24:04'),
(17, 1, 17, 'MA', 0, 40, 23, 17, '2026-01-28 13:24:04', '2026-01-28 13:24:04'),
(18, 1, 18, 'MA', 0, 40, 24, 16, '2026-01-28 13:24:04', '2026-01-28 13:24:04'),
(19, 1, 19, 'C', 0, 40, 10, 30, '2026-01-28 13:24:04', '2026-01-28 13:24:04'),
(20, 1, 20, 'MA', 0, 40, 22, 18, '2026-01-28 13:24:04', '2026-01-28 13:24:04'),
(21, 2, 1, NULL, 0, 0, 0, 0, '2026-01-28 13:41:19', '2026-01-28 13:41:19'),
(22, 2, 2, NULL, 0, 0, 0, 0, '2026-01-28 13:41:19', '2026-01-28 13:41:19'),
(23, 2, 3, NULL, 0, 0, 0, 0, '2026-01-28 13:41:19', '2026-01-28 13:41:19'),
(24, 2, 4, NULL, 0, 0, 0, 0, '2026-01-28 13:41:19', '2026-01-28 13:41:19'),
(25, 2, 5, NULL, 0, 0, 0, 0, '2026-01-28 13:41:19', '2026-01-28 13:41:19'),
(26, 2, 6, NULL, 0, 0, 0, 0, '2026-01-28 13:41:19', '2026-01-28 13:41:19'),
(27, 2, 7, NULL, 0, 0, 0, 0, '2026-01-28 13:41:19', '2026-01-28 13:41:19'),
(28, 2, 8, NULL, 0, 0, 0, 0, '2026-01-28 13:41:19', '2026-01-28 13:41:19'),
(29, 2, 9, NULL, 0, 0, 0, 0, '2026-01-28 13:41:19', '2026-01-28 13:41:19'),
(30, 2, 10, NULL, 0, 0, 0, 0, '2026-01-28 13:41:19', '2026-01-28 13:41:19'),
(31, 2, 11, NULL, 0, 0, 0, 0, '2026-01-28 13:41:19', '2026-01-28 13:41:19'),
(32, 2, 12, NULL, 0, 0, 0, 0, '2026-01-28 13:41:19', '2026-01-28 13:41:19'),
(33, 2, 13, NULL, 0, 0, 0, 0, '2026-01-28 13:41:20', '2026-01-28 13:41:20'),
(34, 2, 14, NULL, 0, 0, 0, 0, '2026-01-28 13:41:20', '2026-01-28 13:41:20'),
(35, 2, 15, NULL, 0, 0, 0, 0, '2026-01-28 13:41:20', '2026-01-28 13:41:20'),
(36, 2, 16, NULL, 0, 0, 0, 0, '2026-01-28 13:41:20', '2026-01-28 13:41:20'),
(37, 2, 17, NULL, 0, 0, 0, 0, '2026-01-28 13:41:20', '2026-01-28 13:41:20'),
(38, 2, 18, NULL, 0, 0, 0, 0, '2026-01-28 13:41:20', '2026-01-28 13:41:20'),
(39, 2, 19, NULL, 0, 0, 0, 0, '2026-01-28 13:41:20', '2026-01-28 13:41:20'),
(40, 2, 20, NULL, 0, 0, 0, 0, '2026-01-28 13:41:20', '2026-01-28 13:41:20'),
(41, 2, 21, NULL, 0, 0, 0, 0, '2026-01-28 13:41:20', '2026-01-28 13:41:20'),
(42, 2, 22, NULL, 0, 0, 0, 0, '2026-01-28 13:41:20', '2026-01-28 13:41:20'),
(43, 2, 23, NULL, 0, 0, 0, 0, '2026-01-28 13:41:20', '2026-01-28 13:41:20'),
(44, 2, 24, NULL, 0, 0, 0, 0, '2026-01-28 13:41:20', '2026-01-28 13:41:20'),
(45, 2, 25, NULL, 0, 0, 0, 0, '2026-01-28 13:41:20', '2026-01-28 13:41:20'),
(46, 2, 26, NULL, 0, 0, 0, 0, '2026-01-28 13:41:20', '2026-01-28 13:41:20'),
(47, 2, 27, NULL, 0, 0, 0, 0, '2026-01-28 13:41:20', '2026-01-28 13:41:20'),
(48, 2, 28, NULL, 0, 0, 0, 0, '2026-01-28 13:41:20', '2026-01-28 13:41:20'),
(49, 2, 29, NULL, 0, 0, 0, 0, '2026-01-28 13:41:20', '2026-01-28 13:41:20'),
(50, 2, 30, NULL, 0, 0, 0, 0, '2026-01-28 13:41:20', '2026-01-28 13:41:20'),
(51, 2, 31, NULL, 0, 0, 0, 0, '2026-01-28 13:41:20', '2026-01-28 13:41:20'),
(52, 2, 32, NULL, 0, 0, 0, 0, '2026-01-28 13:41:20', '2026-01-28 13:41:20'),
(53, 2, 33, NULL, 0, 0, 0, 0, '2026-01-28 13:41:20', '2026-01-28 13:41:20'),
(54, 2, 34, NULL, 0, 0, 0, 0, '2026-01-28 13:41:20', '2026-01-28 13:41:20'),
(55, 2, 35, NULL, 0, 0, 0, 0, '2026-01-28 13:41:20', '2026-01-28 13:41:20'),
(56, 2, 36, NULL, 0, 0, 0, 0, '2026-01-28 13:41:20', '2026-01-28 13:41:20'),
(57, 2, 37, NULL, 0, 0, 0, 0, '2026-01-28 13:41:20', '2026-01-28 13:41:20'),
(58, 2, 38, NULL, 0, 0, 0, 0, '2026-01-28 13:41:21', '2026-01-28 13:41:21'),
(59, 2, 39, NULL, 0, 0, 0, 0, '2026-01-28 13:41:21', '2026-01-28 13:41:21'),
(60, 2, 40, NULL, 0, 0, 0, 0, '2026-01-28 13:41:21', '2026-01-28 13:41:21'),
(61, 3, 1, NULL, 0, 0, 0, 0, '2026-01-28 13:46:38', '2026-01-28 13:46:38'),
(62, 3, 2, NULL, 0, 0, 0, 0, '2026-01-28 13:46:38', '2026-01-28 13:46:38'),
(63, 3, 3, NULL, 0, 0, 0, 0, '2026-01-28 13:46:38', '2026-01-28 13:46:38'),
(64, 3, 4, NULL, 0, 0, 0, 0, '2026-01-28 13:46:38', '2026-01-28 13:46:38'),
(65, 3, 5, NULL, 0, 0, 0, 0, '2026-01-28 13:46:38', '2026-01-28 13:46:38'),
(66, 3, 6, NULL, 0, 0, 0, 0, '2026-01-28 13:46:38', '2026-01-28 13:46:38'),
(67, 3, 7, NULL, 0, 0, 0, 0, '2026-01-28 13:46:38', '2026-01-28 13:46:38'),
(68, 3, 8, NULL, 0, 0, 0, 0, '2026-01-28 13:46:38', '2026-01-28 13:46:38'),
(69, 3, 9, NULL, 0, 0, 0, 0, '2026-01-28 13:46:38', '2026-01-28 13:46:38'),
(70, 3, 10, NULL, 0, 0, 0, 0, '2026-01-28 13:46:38', '2026-01-28 13:46:38'),
(71, 3, 11, NULL, 0, 0, 0, 0, '2026-01-28 13:46:38', '2026-01-28 13:46:38'),
(72, 3, 12, NULL, 0, 0, 0, 0, '2026-01-28 13:46:39', '2026-01-28 13:46:39'),
(73, 3, 13, NULL, 0, 0, 0, 0, '2026-01-28 13:46:39', '2026-01-28 13:46:39'),
(74, 3, 14, NULL, 0, 0, 0, 0, '2026-01-28 13:46:39', '2026-01-28 13:46:39'),
(75, 3, 15, NULL, 0, 0, 0, 0, '2026-01-28 13:46:39', '2026-01-28 13:46:39'),
(76, 3, 16, NULL, 0, 0, 0, 0, '2026-01-28 13:46:39', '2026-01-28 13:46:39'),
(77, 3, 17, NULL, 0, 0, 0, 0, '2026-01-28 13:46:39', '2026-01-28 13:46:39'),
(78, 3, 18, NULL, 0, 0, 0, 0, '2026-01-28 13:46:39', '2026-01-28 13:46:39'),
(79, 3, 19, NULL, 0, 0, 0, 0, '2026-01-28 13:46:39', '2026-01-28 13:46:39'),
(80, 3, 20, NULL, 0, 0, 0, 0, '2026-01-28 13:46:39', '2026-01-28 13:46:39'),
(81, 3, 21, NULL, 0, 0, 0, 0, '2026-01-28 13:46:39', '2026-01-28 13:46:39'),
(82, 3, 22, NULL, 0, 0, 0, 0, '2026-01-28 13:46:39', '2026-01-28 13:46:39'),
(83, 3, 23, NULL, 0, 0, 0, 0, '2026-01-28 13:46:39', '2026-01-28 13:46:39'),
(84, 3, 24, NULL, 0, 0, 0, 0, '2026-01-28 13:46:39', '2026-01-28 13:46:39'),
(85, 3, 25, NULL, 0, 0, 0, 0, '2026-01-28 13:46:39', '2026-01-28 13:46:39'),
(86, 3, 26, NULL, 0, 0, 0, 0, '2026-01-28 13:46:39', '2026-01-28 13:46:39'),
(87, 3, 27, NULL, 0, 0, 0, 0, '2026-01-28 13:46:39', '2026-01-28 13:46:39'),
(88, 3, 28, NULL, 0, 0, 0, 0, '2026-01-28 13:46:39', '2026-01-28 13:46:39'),
(89, 3, 29, NULL, 0, 0, 0, 0, '2026-01-28 13:46:39', '2026-01-28 13:46:39'),
(90, 3, 30, NULL, 0, 0, 0, 0, '2026-01-28 13:46:39', '2026-01-28 13:46:39'),
(91, 3, 31, NULL, 0, 0, 0, 0, '2026-01-28 13:46:39', '2026-01-28 13:46:39'),
(92, 3, 32, NULL, 0, 0, 0, 0, '2026-01-28 13:46:39', '2026-01-28 13:46:39'),
(93, 3, 33, NULL, 0, 0, 0, 0, '2026-01-28 13:46:39', '2026-01-28 13:46:39'),
(94, 3, 34, NULL, 0, 0, 0, 0, '2026-01-28 13:46:39', '2026-01-28 13:46:39'),
(95, 3, 35, NULL, 0, 0, 0, 0, '2026-01-28 13:46:40', '2026-01-28 13:46:40'),
(96, 3, 36, NULL, 0, 0, 0, 0, '2026-01-28 13:46:40', '2026-01-28 13:46:40'),
(97, 3, 37, NULL, 0, 0, 0, 0, '2026-01-28 13:46:40', '2026-01-28 13:46:40'),
(98, 3, 38, NULL, 0, 0, 0, 0, '2026-01-28 13:46:40', '2026-01-28 13:46:40'),
(99, 3, 39, NULL, 0, 0, 0, 0, '2026-01-28 13:46:40', '2026-01-28 13:46:40'),
(100, 3, 40, NULL, 0, 0, 0, 0, '2026-01-28 13:46:40', '2026-01-28 13:46:40');

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
(1, 'golpe', '/images/trampas/trampa_raton.jpg', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(2, 'insecto', '/images/trampas/trampa_insecto.jpg', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(3, 'caja', '/images/trampas/caja_negra.jpg', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(4, 'viva', '/images/trampas/captura_viva.jpg', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(5, 'pegajosa', '/images/trampas/pegajosa.png', '2026-01-28 12:31:34', '2026-01-28 12:31:34');

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
(1, 'Gramos', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(2, 'C.C.', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(3, 'Unidad', '2026-01-28 12:31:34', '2026-01-28 12:31:34'),
(4, 'Litros', '2026-01-28 12:31:34', '2026-01-28 12:31:34');

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
(1, 'Luis Isla', 'islaluis25@gmail.com', NULL, '$2y$12$J/xd8qCJRmGfUFAAsTak/.FyRfqiIWhB9ckLB0EZMWzWUcd.UyH5y', NULL, NULL, NULL, NULL, '2026-01-28 12:31:49', '2026-01-28 12:31:49'),
(2, 'Prueba1', 'admin@admin.com', NULL, '$2y$12$BlAwNhCzpyw4/cpgrsKpx.ckqR43eUMcuDlAkBNFRuAF6/tQgNGEC', NULL, NULL, NULL, NULL, '2026-01-28 12:32:23', '2026-01-28 12:32:23'),
(3, 'HENRRY FERNANDEZ', 'leoncito@gmail.com', NULL, '$2y$12$bkYpoNRNkb1vRxXOYCLG1O0cJC.ZhurTIeHTO7ronEp5e9v4Ex846', NULL, NULL, NULL, NULL, '2026-01-28 14:21:56', '2026-01-28 14:21:56'),
(4, 'lic escobar', 'jotamontero.fm@gmail.com', NULL, '$2y$12$nzyBAMDdoFnivI3M7HRw6u0sqe3GT5GxFdf9CAKHWEQobX08qM7Am', NULL, NULL, NULL, NULL, '2026-01-28 14:27:10', '2026-01-28 14:27:10');

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

--
-- Volcado de datos para la tabla `usuario_empresas`
--

INSERT INTO `usuario_empresas` (`id`, `user_id`, `empresa_id`, `created_at`, `updated_at`) VALUES
(1, 4, 1, '2026-01-28 14:27:10', '2026-01-28 14:27:10');

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=94;

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `seguimiento_biologicos`
--
ALTER TABLE `seguimiento_biologicos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `seguimiento_epps`
--
ALTER TABLE `seguimiento_epps`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `seguimiento_especies`
--
ALTER TABLE `seguimiento_especies`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `seguimiento_images`
--
ALTER TABLE `seguimiento_images`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `seguimiento_metodos`
--
ALTER TABLE `seguimiento_metodos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `seguimiento_protecciones`
--
ALTER TABLE `seguimiento_protecciones`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `trampas`
--
ALTER TABLE `trampas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=110;

--
-- AUTO_INCREMENT de la tabla `trampa_especie_seguimientos`
--
ALTER TABLE `trampa_especie_seguimientos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `trampa_roedor_seguimientos`
--
ALTER TABLE `trampa_roedor_seguimientos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

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
