-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 28-02-2026 a las 01:41:08
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `BolivianPest`
--

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
(1, 1, 'Central El Alto', 'Zona Villa Adela, Calle 3 #890', 'Juan Mamani', '77654321', 'central@elandino.bo', 'El Alto', '2026-02-27 22:49:13', '2026-02-27 22:49:13'),
(2, 1, 'Sucursal Sur', 'Calacoto, Calle 21 #123', 'María Quispe', '70789012', 'sur@elandino.bo', 'La Paz', '2026-02-27 22:49:14', '2026-02-27 22:49:14'),
(3, 2, 'Planta Principal', 'calle aroma #231', 'Carlos Rojas', '70711223', 'principal@andinafoods.bo', 'Cochabamba', '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(4, 2, 'Depósito Seco', 'blacut #897', 'Rosa López', '75634343', 'seco@andinafoods.bo', 'Sacaba', '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(5, 2, 'Área Frigorífica', 'blanco galindo #124', 'carlos perez', '78231243', 'frigorifica@andinafoods.bo', 'Cochabamba', '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(6, 3, 'Centro de Distribución El Alto', 'miraflores #124', 'Pedro Condori', '76543210', 'distribucion@logipaz.bo', 'la paz', '2026-02-27 23:37:34', '2026-02-27 23:37:34'),
(7, 4, 'Depósito Central', 'ramiro blacutt #895', 'Luis Fernández', '70765432', 'central@distvalle.bo', 'cochabamba', '2026-02-27 23:55:34', '2026-02-27 23:55:34');

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
(1, 1, NULL, 120, 6, 50, 36000, '2026-02-27 22:49:13', '2026-02-27 22:49:13'),
(2, 2, NULL, 120, 6, 15, 10800, '2026-02-27 22:49:14', '2026-02-27 22:49:14'),
(3, 3, NULL, 120, 4, 15, 7200, '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(4, 4, NULL, 120, 6, 12, 8640, '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(5, 5, NULL, 100, 6, 23, 13800, '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(6, 6, NULL, 190, 6, 40, 45600, '2026-02-27 23:37:34', '2026-02-27 23:37:34'),
(7, 7, NULL, 300, 4, 19, 22800, '2026-02-27 23:55:34', '2026-02-27 23:55:34');

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
(1, 1, NULL, 8, 12, 120, 11520, '2026-02-27 22:49:13', '2026-02-27 22:49:13'),
(2, 2, NULL, 8, 6, 120, 5760, '2026-02-27 22:49:14', '2026-02-27 22:49:14'),
(3, 3, NULL, 8, 12, 120, 11520, '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(4, 4, NULL, 8, 6, 120, 5760, '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(5, 5, NULL, 8, 6, 120, 5760, '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(6, 6, NULL, 8, 6, 122, 5856, '2026-02-27 23:37:34', '2026-02-27 23:37:34'),
(7, 7, NULL, 8, 12, 90, 8640, '2026-02-27 23:55:34', '2026-02-27 23:55:34');

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
(1, 1, NULL, 2, 4, 150, 600, '2026-02-27 22:49:13', '2026-02-27 22:49:13'),
(2, 2, NULL, 2, 6, 300, 1800, '2026-02-27 22:49:14', '2026-02-27 22:49:14'),
(3, 3, NULL, 2, 4, 150, 600, '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(4, 4, NULL, 2, 12, 150, 1800, '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(5, 5, NULL, 2, 6, 190, 1140, '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(6, 6, NULL, 2, 6, 50, 300, '2026-02-27 23:37:34', '2026-02-27 23:37:34'),
(7, 7, NULL, 2, 6, 190, 1140, '2026-02-27 23:55:34', '2026-02-27 23:55:34');

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
(1, 1, 0, 0, 0, 5, 3, 8, 8, 2, '2026-02-28 00:35:31', '2026-02-28 00:35:31'),
(2, 2, 1, 0, 1, 0, 0, 0, 0, 0, '2026-02-28 00:37:06', '2026-02-28 00:37:06'),
(3, 3, 1, 1, 1, 0, 0, 0, 0, 0, '2026-02-28 00:39:14', '2026-02-28 00:39:14');

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
(1, 'Adulto', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(2, 'Huevo', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(3, 'Larva', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(4, 'Ninfa', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(5, 'Pupa', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(6, 'Otros', '2026-02-27 22:15:45', '2026-02-27 22:15:45');

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
(1, 1, 2, '2026-02-28 00:35:31', '2026-02-28 00:39:14');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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

--
-- Volcado de datos para la tabla `compras`
--

INSERT INTO `compras` (`id`, `user_id`, `proveedor_id`, `total`, `tipo`, `observaciones`, `created_at`, `updated_at`) VALUES
(1, 2, NULL, 0, 'Compra', '', '2026-02-28 00:11:00', '2026-02-28 00:11:00'),
(2, 2, 1, 0, 'Compra', '', '2026-02-28 00:11:29', '2026-02-28 00:11:29'),
(3, 2, NULL, 0, 'Compra', '', '2026-02-28 00:11:51', '2026-02-28 00:11:51');

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
(1, 1, 1, 10, 0, 10, '', '2026-02-28 00:11:00', '2026-02-28 00:11:00'),
(2, 2, 2, 10, 0, 12, '', '2026-02-28 00:11:29', '2026-02-28 00:11:29'),
(3, 3, 3, 12, 0, 32, '', '2026-02-28 00:11:51', '2026-02-28 00:11:51');

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
(1, 1, 66480.00, '2026-12-31', '2026-02-27 22:49:13', '2026-02-27 22:49:13'),
(2, 2, 56220.00, '2026-12-31', '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(3, 3, 51756.00, '2026-12-31', '2026-02-27 23:37:34', '2026-02-27 23:37:34'),
(4, 4, 32580.00, '2026-12-31', '2026-02-27 23:55:34', '2026-02-27 23:55:34');

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
(1, 1, 'Central El Alto', '8', '12', '120', '11520', '120', '6', '50', '36000', '2', '4', '150', '600', 0.00, '2026-02-27 22:49:13', '2026-02-27 22:49:13'),
(2, 1, 'Sucursal Sur', '8', '6', '120', '5760', '120', '6', '15', '10800', '2', '6', '300', '1800', 0.00, '2026-02-27 22:49:14', '2026-02-27 22:49:14'),
(3, 2, 'Planta Principal', '8', '12', '120', '11520', '120', '4', '15', '7200', '2', '4', '150', '600', 0.00, '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(4, 2, 'Depósito Seco', '8', '6', '120', '5760', '120', '6', '12', '8640', '2', '12', '150', '1800', 0.00, '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(5, 2, 'Área Frigorífica', '8', '6', '120', '5760', '100', '6', '23', '13800', '2', '6', '190', '1140', 0.00, '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(6, 3, 'Centro de Distribución El Alto', '8', '6', '122', '5856', '190', '6', '40', '45600', '2', '6', '50', '300', 0.00, '2026-02-27 23:37:34', '2026-02-27 23:37:34'),
(7, 4, 'Depósito Central', '8', '12', '90', '8640', '300', '4', '19', '22800', '2', '6', '190', '1140', 0.00, '2026-02-27 23:55:34', '2026-02-27 23:55:34');

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
(1, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-01-08', 'bg-yellow-500', 'completado', '2026-02-27 22:49:14', '2026-02-28 00:35:31'),
(2, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-02-05', 'bg-yellow-500', 'pendiente', '2026-02-27 22:49:14', '2026-02-27 22:49:14'),
(3, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-03-05', 'bg-yellow-500', 'pendiente', '2026-02-27 22:49:14', '2026-02-27 22:49:14'),
(4, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-04-09', 'bg-yellow-500', 'pendiente', '2026-02-27 22:49:14', '2026-02-27 22:49:14'),
(5, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-05-14', 'bg-yellow-500', 'pendiente', '2026-02-27 22:49:14', '2026-02-27 22:49:14'),
(6, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-06-11', 'bg-yellow-500', 'pendiente', '2026-02-27 22:49:14', '2026-02-27 22:49:14'),
(7, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-07-08', 'bg-yellow-500', 'pendiente', '2026-02-27 22:49:14', '2026-02-27 22:49:14'),
(8, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-08-12', 'bg-yellow-500', 'pendiente', '2026-02-27 22:49:14', '2026-02-27 22:49:14'),
(9, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-09-11', 'bg-yellow-500', 'pendiente', '2026-02-27 22:49:14', '2026-02-27 22:49:14'),
(10, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-10-14', 'bg-yellow-500', 'pendiente', '2026-02-27 22:49:14', '2026-02-27 22:49:14'),
(11, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-11-12', 'bg-yellow-500', 'pendiente', '2026-02-27 22:49:14', '2026-02-27 22:49:14'),
(12, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-12-17', 'bg-yellow-500', 'pendiente', '2026-02-27 22:49:14', '2026-02-27 22:49:14'),
(13, 1, 1, 2, 2, 2, 'DESINFECCION', '2026-02-12', 'bg-blue-500', 'completado', '2026-02-27 22:49:14', '2026-02-28 00:37:06'),
(14, 1, 1, 2, 2, 2, 'DESINFECCION', '2026-04-16', 'bg-blue-500', 'pendiente', '2026-02-27 22:49:14', '2026-02-27 22:49:14'),
(15, 1, 1, 2, 2, 2, 'DESINFECCION', '2026-06-11', 'bg-blue-500', 'pendiente', '2026-02-27 22:49:14', '2026-02-27 22:49:14'),
(16, 1, 1, 2, 2, 2, 'DESINFECCION', '2026-08-13', 'bg-blue-500', 'pendiente', '2026-02-27 22:49:14', '2026-02-27 22:49:14'),
(17, 1, 1, 2, 2, 2, 'DESINFECCION', '2026-10-15', 'bg-blue-500', 'pendiente', '2026-02-27 22:49:14', '2026-02-27 22:49:14'),
(18, 1, 1, 2, 2, 2, 'DESINFECCION', '2026-12-16', 'bg-blue-500', 'pendiente', '2026-02-27 22:49:14', '2026-02-27 22:49:14'),
(19, 1, 1, 2, 2, 3, 'DESINSECTACION', '2026-03-12', 'bg-pink-600', 'completado', '2026-02-27 22:49:14', '2026-02-28 00:39:14'),
(20, 1, 1, 2, 2, 3, 'DESINSECTACION', '2026-06-18', 'bg-pink-600', 'pendiente', '2026-02-27 22:49:14', '2026-02-27 22:49:14'),
(21, 1, 1, 2, 2, 3, 'DESINSECTACION', '2026-09-16', 'bg-pink-600', 'pendiente', '2026-02-27 22:49:14', '2026-02-27 22:49:14'),
(22, 1, 1, 2, 2, 3, 'DESINSECTACION', '2026-12-16', 'bg-pink-600', 'pendiente', '2026-02-27 22:49:14', '2026-02-27 22:49:14'),
(23, 1, 2, 2, 2, 1, 'DESRATIZACION', '2026-02-12', 'bg-yellow-500', 'pendiente', '2026-02-27 22:49:14', '2026-02-27 22:49:14'),
(24, 1, 2, 2, 2, 1, 'DESRATIZACION', '2026-04-16', 'bg-yellow-500', 'pendiente', '2026-02-27 22:49:14', '2026-02-27 22:49:14'),
(25, 1, 2, 2, 2, 1, 'DESRATIZACION', '2026-06-17', 'bg-yellow-500', 'pendiente', '2026-02-27 22:49:14', '2026-02-27 22:49:14'),
(26, 1, 2, 2, 2, 1, 'DESRATIZACION', '2026-08-12', 'bg-yellow-500', 'pendiente', '2026-02-27 22:49:14', '2026-02-27 22:49:14'),
(27, 1, 2, 2, 2, 1, 'DESRATIZACION', '2026-10-14', 'bg-yellow-500', 'pendiente', '2026-02-27 22:49:14', '2026-02-27 22:49:14'),
(28, 1, 2, 2, 2, 1, 'DESRATIZACION', '2026-12-16', 'bg-yellow-500', 'pendiente', '2026-02-27 22:49:14', '2026-02-27 22:49:14'),
(29, 1, 2, 2, 2, 2, 'DESINFECCION', '2026-02-12', 'bg-blue-500', 'pendiente', '2026-02-27 22:49:14', '2026-02-27 22:49:14'),
(30, 1, 2, 2, 2, 2, 'DESINFECCION', '2026-04-15', 'bg-blue-500', 'pendiente', '2026-02-27 22:49:14', '2026-02-27 22:49:14'),
(31, 1, 2, 2, 2, 2, 'DESINFECCION', '2026-06-10', 'bg-blue-500', 'pendiente', '2026-02-27 22:49:14', '2026-02-27 22:49:14'),
(32, 1, 2, 2, 2, 2, 'DESINFECCION', '2026-08-11', 'bg-blue-500', 'pendiente', '2026-02-27 22:49:14', '2026-02-27 22:49:14'),
(33, 1, 2, 2, 2, 2, 'DESINFECCION', '2026-10-15', 'bg-blue-500', 'pendiente', '2026-02-27 22:49:14', '2026-02-27 22:49:14'),
(34, 1, 2, 2, 2, 2, 'DESINFECCION', '2026-12-16', 'bg-blue-500', 'pendiente', '2026-02-27 22:49:14', '2026-02-27 22:49:14'),
(35, 1, 2, 2, 2, 3, 'DESINSECTACION', '2026-02-12', 'bg-pink-600', 'pendiente', '2026-02-27 22:49:14', '2026-02-27 22:49:14'),
(36, 1, 2, 2, 2, 3, 'DESINSECTACION', '2026-04-15', 'bg-pink-600', 'pendiente', '2026-02-27 22:49:14', '2026-02-27 22:49:14'),
(37, 1, 2, 2, 2, 3, 'DESINSECTACION', '2026-06-18', 'bg-pink-600', 'pendiente', '2026-02-27 22:49:14', '2026-02-27 22:49:14'),
(38, 1, 2, 2, 2, 3, 'DESINSECTACION', '2026-08-13', 'bg-pink-600', 'pendiente', '2026-02-27 22:49:14', '2026-02-27 22:49:14'),
(39, 1, 2, 2, 2, 3, 'DESINSECTACION', '2026-10-14', 'bg-pink-600', 'pendiente', '2026-02-27 22:49:14', '2026-02-27 22:49:14'),
(40, 1, 2, 2, 2, 3, 'DESINSECTACION', '2026-12-16', 'bg-pink-600', 'pendiente', '2026-02-27 22:49:14', '2026-02-27 22:49:14'),
(41, 2, 3, 2, 2, 1, 'DESRATIZACION', '2026-01-08', 'bg-yellow-500', 'pendiente', '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(42, 2, 3, 2, 2, 1, 'DESRATIZACION', '2026-02-12', 'bg-yellow-500', 'pendiente', '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(43, 2, 3, 2, 2, 1, 'DESRATIZACION', '2026-03-04', 'bg-yellow-500', 'pendiente', '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(44, 2, 3, 2, 2, 1, 'DESRATIZACION', '2026-04-08', 'bg-yellow-500', 'pendiente', '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(45, 2, 3, 2, 2, 1, 'DESRATIZACION', '2026-05-14', 'bg-yellow-500', 'pendiente', '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(46, 2, 3, 2, 2, 1, 'DESRATIZACION', '2026-06-13', 'bg-yellow-500', 'pendiente', '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(47, 2, 3, 2, 2, 1, 'DESRATIZACION', '2026-07-07', 'bg-yellow-500', 'pendiente', '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(48, 2, 3, 2, 2, 1, 'DESRATIZACION', '2026-08-11', 'bg-yellow-500', 'pendiente', '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(49, 2, 3, 2, 2, 1, 'DESRATIZACION', '2026-09-15', 'bg-yellow-500', 'pendiente', '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(50, 2, 3, 2, 2, 1, 'DESRATIZACION', '2026-10-14', 'bg-yellow-500', 'pendiente', '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(51, 2, 3, 2, 2, 1, 'DESRATIZACION', '2026-11-11', 'bg-yellow-500', 'pendiente', '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(52, 2, 3, 2, 2, 1, 'DESRATIZACION', '2026-12-16', 'bg-yellow-500', 'pendiente', '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(53, 2, 3, 2, 2, 2, 'DESINFECCION', '2026-03-12', 'bg-blue-500', 'pendiente', '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(54, 2, 3, 2, 2, 2, 'DESINFECCION', '2026-06-17', 'bg-blue-500', 'pendiente', '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(55, 2, 3, 2, 2, 2, 'DESINFECCION', '2026-09-16', 'bg-blue-500', 'pendiente', '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(56, 2, 3, 2, 2, 2, 'DESINFECCION', '2026-12-10', 'bg-blue-500', 'pendiente', '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(57, 2, 3, 2, 2, 3, 'DESINSECTACION', '2026-03-18', 'bg-pink-600', 'pendiente', '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(58, 2, 3, 2, 2, 3, 'DESINSECTACION', '2026-06-19', 'bg-pink-600', 'pendiente', '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(59, 2, 3, 2, 2, 3, 'DESINSECTACION', '2026-09-24', 'bg-pink-600', 'pendiente', '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(60, 2, 3, 2, 2, 3, 'DESINSECTACION', '2026-12-16', 'bg-pink-600', 'pendiente', '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(61, 2, 4, 2, 2, 1, 'DESRATIZACION', '2026-02-11', 'bg-yellow-500', 'pendiente', '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(62, 2, 4, 2, 2, 1, 'DESRATIZACION', '2026-04-16', 'bg-yellow-500', 'pendiente', '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(63, 2, 4, 2, 2, 1, 'DESRATIZACION', '2026-06-10', 'bg-yellow-500', 'pendiente', '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(64, 2, 4, 2, 2, 1, 'DESRATIZACION', '2026-08-12', 'bg-yellow-500', 'pendiente', '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(65, 2, 4, 2, 2, 1, 'DESRATIZACION', '2026-10-15', 'bg-yellow-500', 'pendiente', '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(66, 2, 4, 2, 2, 1, 'DESRATIZACION', '2026-12-10', 'bg-yellow-500', 'pendiente', '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(67, 2, 4, 2, 2, 2, 'DESINFECCION', '2026-02-13', 'bg-blue-500', 'pendiente', '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(68, 2, 4, 2, 2, 2, 'DESINFECCION', '2026-04-15', 'bg-blue-500', 'pendiente', '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(69, 2, 4, 2, 2, 2, 'DESINFECCION', '2026-06-11', 'bg-blue-500', 'pendiente', '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(70, 2, 4, 2, 2, 2, 'DESINFECCION', '2026-08-12', 'bg-blue-500', 'pendiente', '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(71, 2, 4, 2, 2, 2, 'DESINFECCION', '2026-10-14', 'bg-blue-500', 'pendiente', '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(72, 2, 4, 2, 2, 2, 'DESINFECCION', '2026-12-09', 'bg-blue-500', 'pendiente', '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(73, 2, 4, 2, 2, 3, 'DESINSECTACION', '2026-01-07', 'bg-pink-600', 'pendiente', '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(74, 2, 4, 2, 2, 3, 'DESINSECTACION', '2026-02-12', 'bg-pink-600', 'pendiente', '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(75, 2, 4, 2, 2, 3, 'DESINSECTACION', '2026-03-05', 'bg-pink-600', 'pendiente', '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(76, 2, 4, 2, 2, 3, 'DESINSECTACION', '2026-04-08', 'bg-pink-600', 'pendiente', '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(77, 2, 4, 2, 2, 3, 'DESINSECTACION', '2026-05-14', 'bg-pink-600', 'pendiente', '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(78, 2, 4, 2, 2, 3, 'DESINSECTACION', '2026-06-11', 'bg-pink-600', 'pendiente', '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(79, 2, 4, 2, 2, 3, 'DESINSECTACION', '2026-07-08', 'bg-pink-600', 'pendiente', '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(80, 2, 4, 2, 2, 3, 'DESINSECTACION', '2026-08-12', 'bg-pink-600', 'pendiente', '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(81, 2, 4, 2, 2, 3, 'DESINSECTACION', '2026-09-17', 'bg-pink-600', 'pendiente', '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(82, 2, 4, 2, 2, 3, 'DESINSECTACION', '2026-10-09', 'bg-pink-600', 'pendiente', '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(83, 2, 4, 2, 2, 3, 'DESINSECTACION', '2026-11-05', 'bg-pink-600', 'pendiente', '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(84, 2, 4, 2, 2, 3, 'DESINSECTACION', '2026-12-29', 'bg-pink-600', 'pendiente', '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(85, 2, 5, 2, 2, 1, 'DESRATIZACION', '2026-02-12', 'bg-yellow-500', 'pendiente', '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(86, 2, 5, 2, 2, 1, 'DESRATIZACION', '2026-03-12', 'bg-yellow-500', 'pendiente', '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(87, 2, 5, 2, 2, 1, 'DESRATIZACION', '2026-04-15', 'bg-yellow-500', 'pendiente', '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(88, 2, 5, 2, 2, 1, 'DESRATIZACION', '2026-05-13', 'bg-yellow-500', 'pendiente', '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(89, 2, 5, 2, 2, 1, 'DESRATIZACION', '2026-06-17', 'bg-yellow-500', 'pendiente', '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(90, 2, 5, 2, 2, 1, 'DESRATIZACION', '2026-07-15', 'bg-yellow-500', 'pendiente', '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(91, 2, 5, 2, 2, 2, 'DESINFECCION', '2026-02-12', 'bg-blue-500', 'pendiente', '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(92, 2, 5, 2, 2, 2, 'DESINFECCION', '2026-03-12', 'bg-blue-500', 'pendiente', '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(93, 2, 5, 2, 2, 2, 'DESINFECCION', '2026-04-15', 'bg-blue-500', 'pendiente', '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(94, 2, 5, 2, 2, 2, 'DESINFECCION', '2026-05-13', 'bg-blue-500', 'pendiente', '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(95, 2, 5, 2, 2, 2, 'DESINFECCION', '2026-06-17', 'bg-blue-500', 'pendiente', '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(96, 2, 5, 2, 2, 2, 'DESINFECCION', '2026-07-15', 'bg-blue-500', 'pendiente', '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(97, 2, 5, 2, 2, 3, 'DESINSECTACION', '2026-02-12', 'bg-pink-600', 'pendiente', '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(98, 2, 5, 2, 2, 3, 'DESINSECTACION', '2026-03-12', 'bg-pink-600', 'pendiente', '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(99, 2, 5, 2, 2, 3, 'DESINSECTACION', '2026-04-15', 'bg-pink-600', 'pendiente', '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(100, 2, 5, 2, 2, 3, 'DESINSECTACION', '2026-05-13', 'bg-pink-600', 'pendiente', '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(101, 2, 5, 2, 2, 3, 'DESINSECTACION', '2026-06-17', 'bg-pink-600', 'pendiente', '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(102, 2, 5, 2, 2, 3, 'DESINSECTACION', '2026-07-15', 'bg-pink-600', 'pendiente', '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(103, 3, 6, 2, 2, 1, 'DESRATIZACION', '2026-02-12', 'bg-yellow-500', 'pendiente', '2026-02-27 23:37:34', '2026-02-27 23:37:34'),
(104, 3, 6, 2, 2, 1, 'DESRATIZACION', '2026-03-12', 'bg-yellow-500', 'pendiente', '2026-02-27 23:37:34', '2026-02-27 23:37:34'),
(105, 3, 6, 2, 2, 1, 'DESRATIZACION', '2026-04-16', 'bg-yellow-500', 'pendiente', '2026-02-27 23:37:34', '2026-02-27 23:37:34'),
(106, 3, 6, 2, 2, 1, 'DESRATIZACION', '2026-05-13', 'bg-yellow-500', 'pendiente', '2026-02-27 23:37:34', '2026-02-27 23:37:34'),
(107, 3, 6, 2, 2, 1, 'DESRATIZACION', '2026-06-18', 'bg-yellow-500', 'pendiente', '2026-02-27 23:37:34', '2026-02-27 23:37:34'),
(108, 3, 6, 2, 2, 1, 'DESRATIZACION', '2026-07-29', 'bg-yellow-500', 'pendiente', '2026-02-27 23:37:34', '2026-02-27 23:37:34'),
(109, 3, 6, 2, 2, 2, 'DESINFECCION', '2026-02-12', 'bg-blue-500', 'pendiente', '2026-02-27 23:37:34', '2026-02-27 23:37:34'),
(110, 3, 6, 2, 2, 2, 'DESINFECCION', '2026-04-16', 'bg-blue-500', 'pendiente', '2026-02-27 23:37:34', '2026-02-27 23:37:34'),
(111, 3, 6, 2, 2, 2, 'DESINFECCION', '2026-06-18', 'bg-blue-500', 'pendiente', '2026-02-27 23:37:34', '2026-02-27 23:37:34'),
(112, 3, 6, 2, 2, 2, 'DESINFECCION', '2026-08-13', 'bg-blue-500', 'pendiente', '2026-02-27 23:37:34', '2026-02-27 23:37:34'),
(113, 3, 6, 2, 2, 2, 'DESINFECCION', '2026-10-15', 'bg-blue-500', 'pendiente', '2026-02-27 23:37:34', '2026-02-27 23:37:34'),
(114, 3, 6, 2, 2, 2, 'DESINFECCION', '2026-12-16', 'bg-blue-500', 'pendiente', '2026-02-27 23:37:34', '2026-02-27 23:37:34'),
(115, 3, 6, 2, 2, 3, 'DESINSECTACION', '2026-02-12', 'bg-pink-600', 'pendiente', '2026-02-27 23:37:34', '2026-02-27 23:37:34'),
(116, 3, 6, 2, 2, 3, 'DESINSECTACION', '2026-04-16', 'bg-pink-600', 'pendiente', '2026-02-27 23:37:34', '2026-02-27 23:37:34'),
(117, 3, 6, 2, 2, 3, 'DESINSECTACION', '2026-06-11', 'bg-pink-600', 'pendiente', '2026-02-27 23:37:34', '2026-02-27 23:37:34'),
(118, 3, 6, 2, 2, 3, 'DESINSECTACION', '2026-08-11', 'bg-pink-600', 'pendiente', '2026-02-27 23:37:34', '2026-02-27 23:37:34'),
(119, 3, 6, 2, 2, 3, 'DESINSECTACION', '2026-10-09', 'bg-pink-600', 'pendiente', '2026-02-27 23:37:34', '2026-02-27 23:37:34'),
(120, 3, 6, 2, 2, 3, 'DESINSECTACION', '2026-12-15', 'bg-pink-600', 'pendiente', '2026-02-27 23:37:34', '2026-02-27 23:37:34'),
(121, 4, 7, 2, 2, 1, 'DESRATIZACION', '2026-01-08', 'bg-yellow-500', 'pendiente', '2026-02-27 23:55:34', '2026-02-27 23:55:34'),
(122, 4, 7, 2, 2, 1, 'DESRATIZACION', '2026-02-12', 'bg-yellow-500', 'pendiente', '2026-02-27 23:55:34', '2026-02-27 23:55:34'),
(123, 4, 7, 2, 2, 1, 'DESRATIZACION', '2026-03-11', 'bg-yellow-500', 'pendiente', '2026-02-27 23:55:34', '2026-02-27 23:55:34'),
(124, 4, 7, 2, 2, 1, 'DESRATIZACION', '2026-04-08', 'bg-yellow-500', 'pendiente', '2026-02-27 23:55:34', '2026-02-27 23:55:34'),
(125, 4, 7, 2, 2, 1, 'DESRATIZACION', '2026-05-06', 'bg-yellow-500', 'pendiente', '2026-02-27 23:55:34', '2026-02-27 23:55:34'),
(126, 4, 7, 2, 2, 1, 'DESRATIZACION', '2026-06-18', 'bg-yellow-500', 'pendiente', '2026-02-27 23:55:34', '2026-02-27 23:55:34'),
(127, 4, 7, 2, 2, 1, 'DESRATIZACION', '2026-07-09', 'bg-yellow-500', 'pendiente', '2026-02-27 23:55:34', '2026-02-27 23:55:34'),
(128, 4, 7, 2, 2, 1, 'DESRATIZACION', '2026-08-05', 'bg-yellow-500', 'pendiente', '2026-02-27 23:55:34', '2026-02-27 23:55:34'),
(129, 4, 7, 2, 2, 1, 'DESRATIZACION', '2026-09-16', 'bg-yellow-500', 'pendiente', '2026-02-27 23:55:34', '2026-02-27 23:55:34'),
(130, 4, 7, 2, 2, 1, 'DESRATIZACION', '2026-10-15', 'bg-yellow-500', 'pendiente', '2026-02-27 23:55:34', '2026-02-27 23:55:34'),
(131, 4, 7, 2, 2, 1, 'DESRATIZACION', '2026-11-05', 'bg-yellow-500', 'pendiente', '2026-02-27 23:55:34', '2026-02-27 23:55:34'),
(132, 4, 7, 2, 2, 1, 'DESRATIZACION', '2026-12-09', 'bg-yellow-500', 'pendiente', '2026-02-27 23:55:34', '2026-02-27 23:55:34'),
(133, 4, 7, 2, 2, 2, 'DESINFECCION', '2026-03-11', 'bg-blue-500', 'pendiente', '2026-02-27 23:55:34', '2026-02-27 23:55:34'),
(134, 4, 7, 2, 2, 2, 'DESINFECCION', '2026-06-22', 'bg-blue-500', 'pendiente', '2026-02-27 23:55:34', '2026-02-27 23:55:34'),
(135, 4, 7, 2, 2, 2, 'DESINFECCION', '2026-09-17', 'bg-blue-500', 'pendiente', '2026-02-27 23:55:34', '2026-02-27 23:55:34'),
(136, 4, 7, 2, 2, 2, 'DESINFECCION', '2026-12-17', 'bg-blue-500', 'pendiente', '2026-02-27 23:55:34', '2026-02-27 23:55:34'),
(137, 4, 7, 2, 2, 3, 'DESINSECTACION', '2026-02-12', 'bg-pink-600', 'pendiente', '2026-02-27 23:55:34', '2026-02-27 23:55:34'),
(138, 4, 7, 2, 2, 3, 'DESINSECTACION', '2026-04-27', 'bg-pink-600', 'pendiente', '2026-02-27 23:55:34', '2026-02-27 23:55:34'),
(139, 4, 7, 2, 2, 3, 'DESINSECTACION', '2026-06-27', 'bg-pink-600', 'pendiente', '2026-02-27 23:55:34', '2026-02-27 23:55:34'),
(140, 4, 7, 2, 2, 3, 'DESINSECTACION', '2026-08-27', 'bg-pink-600', 'pendiente', '2026-02-27 23:55:34', '2026-02-27 23:55:34'),
(141, 4, 7, 2, 2, 3, 'DESINSECTACION', '2026-10-27', 'bg-pink-600', 'pendiente', '2026-02-27 23:55:34', '2026-02-27 23:55:34'),
(142, 4, 7, 2, 2, 3, 'DESINSECTACION', '2026-12-27', 'bg-pink-600', 'pendiente', '2026-02-27 23:55:34', '2026-02-27 23:55:34');

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
(1, NULL, 1, NULL, 2, 'Contrato por cobrar #1', 'Saldo pendiento por cobrar sobre contrato', 66480, 66480, 'Pendiente', NULL, 0, '2026-02-27 22:49:14', '2026-02-27 22:49:14'),
(2, NULL, 2, NULL, 2, 'Contrato por cobrar #2', 'Saldo pendiento por cobrar sobre contrato', 56220, 56220, 'Pendiente', NULL, 0, '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(3, NULL, 3, NULL, 2, 'Contrato por cobrar #3', 'Saldo pendiento por cobrar sobre contrato', 51756, 51756, 'Pendiente', NULL, 0, '2026-02-27 23:37:34', '2026-02-27 23:37:34'),
(4, NULL, 4, NULL, 2, 'Contrato por cobrar #4', 'Saldo pendiento por cobrar sobre contrato', 32580, 32580, 'Pendiente', NULL, 0, '2026-02-27 23:55:34', '2026-02-27 23:55:34');

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
(1, 'Gastos bancarios operativos', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(2, 'Capacitacion y cursos', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(3, 'Licencias de Software', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(4, 'Gastos de representación', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(5, 'Eventos y actividades', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(6, 'Seguridad y vigilancia', '2026-02-27 22:15:45', '2026-02-27 22:15:45');

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
(1, 'Sueldos administrativos', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(2, 'Honorarios profesionales', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(3, 'Utiles de oficina', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(4, 'Alquiler de oficina', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(5, 'Energia Electrica', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(6, 'Agua', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(7, 'Telefono', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(8, 'Mantenimiento y reparaciones', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(9, 'Limpieza', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(10, 'Seguros', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(11, 'Depresiacion', '2026-02-27 22:15:45', '2026-02-27 22:15:45');

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
(1, 'Sueldos personal', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(2, 'Comisiones sobre ventas', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(3, 'Marketing digital', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(4, 'Material promocional', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(5, 'Transporte y distribucion', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(6, 'Combustible', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(7, 'Viaticos y movilidad', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(8, 'Empaques y embalajes', '2026-02-27 22:15:45', '2026-02-27 22:15:45');

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
(1, 'Supermercados El Andino S.A.', 'Av. Ballivián #456, Calacoto', '22456789', 'info@elandino.bo', 'La Paz', 1, '2026-02-27 22:49:13', '2026-02-27 22:49:13'),
(2, 'Industrias Alimenticias Andina Ltda.', 'Km 7 carretera a Quillacollo', '22567890', 'contacto@andinafoods.bo', 'Cochabamba', 1, '2026-02-27 23:27:49', '2026-02-27 23:27:49'),
(3, 'Logística Paceña S.R.L.', 'Zona Villa Dolores, Av. Panorámica #234', '22345678', 'operaciones@logipaz.bo', 'El Alto', 1, '2026-02-27 23:37:34', '2026-02-27 23:37:34'),
(4, 'Distribuidora del Valle S.A.', 'Av. Oquendo #789', '44567890', 'ventas@distvalle.bo', 'Cochabamba', 1, '2026-02-27 23:55:34', '2026-02-27 23:55:34');

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
(1, 'Ropa de trabajo', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(2, 'Casco de proteccion', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(3, 'Gorra', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(4, 'Guantes', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(5, 'Overol', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(6, 'Botas', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(7, 'Gafas', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(8, 'Antiparras', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(9, 'Respirados', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(10, 'Full face', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(11, 'Otros', '2026-02-27 22:15:45', '2026-02-27 22:15:45');

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
(1, 'Moscas', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(2, 'Polillas', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(3, 'Mosquitos', '2026-02-27 22:15:45', '2026-02-27 22:15:45');

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

--
-- Volcado de datos para la tabla `kardexes`
--

INSERT INTO `kardexes` (`id`, `venta_id`, `compra_id`, `producto_id`, `tipo`, `cantidad`, `cantidad_saldo`, `costo_unitario`, `created_at`, `updated_at`) VALUES
(1, NULL, 1, 1, 'Entrada', 10, 10, 0, '2026-02-28 00:11:00', '2026-02-28 00:11:00'),
(2, NULL, 2, 2, 'Entrada', 10, 10, 0, '2026-02-28 00:11:29', '2026-02-28 00:11:29'),
(3, NULL, 3, 3, 'Entrada', 12, 12, 0, '2026-02-28 00:11:51', '2026-02-28 00:11:51'),
(4, NULL, NULL, 1, 'Salida', 0, 10, 0, '2026-02-28 00:35:31', '2026-02-28 00:35:31'),
(5, NULL, NULL, 2, 'Salida', 1, 9, 0, '2026-02-28 00:37:06', '2026-02-28 00:37:06'),
(6, NULL, NULL, 1, 'Salida', 0, 10, 0, '2026-02-28 00:39:14', '2026-02-28 00:39:14');

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
(1, 1, 1, 2, NULL, NULL, 'images/mapas/1_1772237631.jpeg', '2026-02-28 00:13:51', '2026-02-28 00:13:51'),
(2, 1, 2, 2, NULL, NULL, 'images/mapas/2_1772237707.jpeg', '2026-02-28 00:15:07', '2026-02-28 00:15:07'),
(3, 2, 3, 2, NULL, NULL, 'images/mapas/3_1772237801.jpeg', '2026-02-28 00:16:41', '2026-02-28 00:16:41'),
(4, 2, 4, 2, NULL, NULL, 'images/mapas/4_1772237877.jpeg', '2026-02-28 00:17:57', '2026-02-28 00:17:57'),
(5, 2, 5, 2, NULL, NULL, 'images/mapas/5_1772238012.jpeg', '2026-02-28 00:20:12', '2026-02-28 00:20:12'),
(6, 3, 6, 2, NULL, NULL, 'images/mapas/6_1772238131.jpeg', '2026-02-28 00:22:11', '2026-02-28 00:22:11'),
(7, 4, 7, 2, NULL, NULL, 'images/mapas/7_1772238255.jpeg', '2026-02-28 00:24:15', '2026-02-28 00:24:15');

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
(1, 'Alimento con veneno', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(2, 'Sustancia pegajosa', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(3, 'Alimento', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(4, 'Aspersion', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(5, 'Niebla', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(6, 'Nebulizacion', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(7, 'Fumigacion', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(8, 'Otros', '2026-02-27 22:15:45', '2026-02-27 22:15:45');

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
(82, '2026_02_25_082320_create_buffer_productos_table', 1);

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
(1, 'empresas', 'web', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(2, 'cotizaciones', 'web', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(3, 'contratos', 'web', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(4, 'almacenes', 'web', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(5, 'cronogramas', 'web', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(6, 'mapas', 'web', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(7, 'seguimientos', 'web', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(8, 'certificados', 'web', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(9, 'cuentascobrar', 'web', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(10, 'cuentaspagar', 'web', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(11, 'compras', 'web', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(12, 'ingresos', 'web', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(13, 'retiros', 'web', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(14, 'gastos', 'web', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(15, 'productos', 'web', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(16, 'categorias', 'web', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(17, 'subcategorias', 'web', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(18, 'marcas', 'web', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(19, 'etiquetas', 'web', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(20, 'proveedores', 'web', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(21, 'inventario', 'web', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(22, 'agenda', 'web', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(23, 'documentos', 'web', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(24, 'usuarios', 'web', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(25, 'configuraciones', 'web', '2026-02-27 22:15:45', '2026-02-27 22:15:45');

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
(1, NULL, NULL, 1, 'Contrac Bloque', 'Bloques de bromadiolona para control de roedores en almacenes y áreas industriales.', 120, 10, 5, 0.00, 10.00, '2026-02-28 00:06:40', '2026-02-28 00:11:00'),
(2, NULL, NULL, 4, 'Tempo SC Ultra', 'Concentrado suspensión de beta-ciflutrina de rápida knockdown para control de mosquitos y moscas.', 1, 9, 5, 0.00, 12.00, '2026-02-28 00:07:09', '2026-02-28 00:37:06'),
(3, NULL, NULL, 1, 'Racumin Pasta', 'Pasta anticoagulante de primera generación para roedores en ambientes húmedos.', 750, 12, 5, 0.00, 32.00, '2026-02-28 00:07:38', '2026-02-28 00:11:51');

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
(1, 1, 1, 1, 1, '2026-02-28 00:35:31', '2026-02-28 00:35:31'),
(2, 2, 2, 4, 1, '2026-02-28 00:37:06', '2026-02-28 00:37:06'),
(3, 1, 3, 1, 1, '2026-02-28 00:39:14', '2026-02-28 00:39:14');

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
(1, 'Señalizacion', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(2, 'Hoja de seguimiento', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(3, 'Otros', '2026-02-27 22:15:45', '2026-02-27 22:15:45');

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

--
-- Volcado de datos para la tabla `proveedores`
--

INSERT INTO `proveedores` (`id`, `nombre`, `direccion`, `telefono`, `email`, `contacto`, `created_at`, `updated_at`) VALUES
(1, 'Agroquímicos Andinos S.R.L.', 'Av. Ballivián #1456, Zona Calacoto, La Paz', '70123456', 'ventas@agroandinos.bo', 'Roberto Mamani', '2026-02-28 00:08:24', '2026-02-28 00:08:24'),
(2, 'Distribuidora Plaguicidas Bolivia Ltda.', 'Calle Mercado #789, Miraflores, La Paz', '77789012', 'info@distplaguicidas.bo', 'Carla Vargas', '2026-02-28 00:08:58', '2026-02-28 00:08:58'),
(3, 'BioProtect Agroquímicos', 'Zona Sur, Calle 21 de Calacoto #567, La Paz', '75567890', 'contacto@bioprotect.bo', 'Miguel Ángel Torres', '2026-02-28 00:09:32', '2026-02-28 00:09:32');

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
(1, 'superadmin', 'web', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(2, 'admin', 'web', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(3, 'tecnico', 'web', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(4, 'cliente', 'web', '2026-02-27 22:15:45', '2026-02-27 22:15:45');

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
(1, 1, 1, 2, 1, NULL, 1, 'AQ', 'WS', 'images/firmas/firma_encargado_1772238931.png', 'images/firmas/firma_supervisor_1772238931.png', NULL, NULL, '2026-02-28 00:35:31', '2026-02-28 00:35:31'),
(2, 1, 1, 2, 2, NULL, 13, 'QA', 'DE', 'images/firmas/firma_encargado_1772239026.png', 'images/firmas/firma_supervisor_1772239026.png', NULL, NULL, '2026-02-28 00:37:06', '2026-02-28 00:37:06'),
(3, 1, 1, 2, 3, NULL, 19, 'XC', 'SD', 'images/firmas/firma_encargado_1772239154.png', 'images/firmas/firma_supervisor_1772239154.png', NULL, NULL, '2026-02-28 00:39:14', '2026-02-28 00:39:14');

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
(1, 2, 1, '2026-02-28 00:37:06', '2026-02-28 00:37:06'),
(2, 2, 3, '2026-02-28 00:37:06', '2026-02-28 00:37:06');

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
(1, 1, 10, '2026-02-28 00:35:31', '2026-02-28 00:35:31'),
(2, 1, 2, '2026-02-28 00:35:31', '2026-02-28 00:35:31'),
(3, 1, 4, '2026-02-28 00:35:31', '2026-02-28 00:35:31'),
(4, 1, 3, '2026-02-28 00:35:31', '2026-02-28 00:35:31'),
(5, 2, 8, '2026-02-28 00:37:06', '2026-02-28 00:37:06'),
(6, 2, 7, '2026-02-28 00:37:06', '2026-02-28 00:37:06'),
(7, 2, 3, '2026-02-28 00:37:06', '2026-02-28 00:37:06'),
(8, 2, 4, '2026-02-28 00:37:06', '2026-02-28 00:37:06'),
(9, 3, 2, '2026-02-28 00:39:14', '2026-02-28 00:39:14'),
(10, 3, 7, '2026-02-28 00:39:14', '2026-02-28 00:39:14'),
(11, 3, 4, '2026-02-28 00:39:14', '2026-02-28 00:39:14'),
(12, 3, 5, '2026-02-28 00:39:14', '2026-02-28 00:39:14');

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

--
-- Volcado de datos para la tabla `seguimiento_metodos`
--

INSERT INTO `seguimiento_metodos` (`id`, `seguimiento_id`, `metodo_id`, `created_at`, `updated_at`) VALUES
(1, 1, 3, '2026-02-28 00:35:31', '2026-02-28 00:35:31'),
(2, 1, 2, '2026-02-28 00:35:31', '2026-02-28 00:35:31'),
(3, 1, 1, '2026-02-28 00:35:31', '2026-02-28 00:35:31'),
(4, 2, 4, '2026-02-28 00:37:06', '2026-02-28 00:37:06'),
(5, 2, 5, '2026-02-28 00:37:06', '2026-02-28 00:37:06'),
(6, 3, 4, '2026-02-28 00:39:14', '2026-02-28 00:39:14'),
(7, 3, 6, '2026-02-28 00:39:14', '2026-02-28 00:39:14'),
(8, 3, 7, '2026-02-28 00:39:14', '2026-02-28 00:39:14');

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
(1, 1, 2, '2026-02-28 00:35:31', '2026-02-28 00:35:31'),
(2, 1, 1, '2026-02-28 00:35:31', '2026-02-28 00:35:31'),
(3, 2, 2, '2026-02-28 00:37:06', '2026-02-28 00:37:06'),
(4, 2, 1, '2026-02-28 00:37:06', '2026-02-28 00:37:06'),
(5, 3, 2, '2026-02-28 00:39:14', '2026-02-28 00:39:14'),
(6, 3, 1, '2026-02-28 00:39:14', '2026-02-28 00:39:14');

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
(1, 1, 3, '2026-02-28 00:35:31', '2026-02-28 00:35:31'),
(2, 1, 1, '2026-02-28 00:35:31', '2026-02-28 00:35:31'),
(3, 1, 2, '2026-02-28 00:35:31', '2026-02-28 00:35:31');

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
('5hbRxEOAVsNSGAIiIhPGE3PlQfwsR5C3nVztOjFD', 2, '127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiMWVsbmlXRndvdlBSWXp1T0pqR3lMb2VEWnpIQXJIRDBqOERKQ1JLVCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDk6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC90cmFtcGFzZWd1aW1pZW50b3MvZXNwZWNpZXMiO3M6NToicm91dGUiO3M6Mjc6InRyYW1wYXNlZ3VpbWllbnRvcy5lc3BlY2llcyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjI7fQ==', 1772239252);

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
(1, 'Huellas', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(2, 'Roeduras', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(3, 'Madriguera', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(4, 'Senda', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(5, 'Excrementos', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(6, 'Marca de orina', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(7, 'Otros', '2026-02-27 22:15:45', '2026-02-27 22:15:45');

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
(1, 'DESRATIZACION', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(2, 'DESINFECCION', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(3, 'DESINSECTACION', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(4, 'CONTROL DE AVES', '2026-02-27 22:15:45', '2026-02-27 22:15:45');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `trampas`
--

CREATE TABLE `trampas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `almacen_id` bigint(20) UNSIGNED NOT NULL,
  `mapa_id` bigint(20) UNSIGNED NOT NULL,
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
(1, 1, 1, 1, 1, 'null', 364, 38, 'g1', 'activo', '2026-02-28 00:13:51', '2026-02-28 00:13:51'),
(2, 1, 1, 1, 2, 'null', 661, 68, 'g2', 'activo', '2026-02-28 00:13:51', '2026-02-28 00:13:51'),
(3, 1, 1, 2, 3, 'null', 62, 512, 'i1', 'activo', '2026-02-28 00:13:51', '2026-02-28 00:13:51'),
(4, 1, 1, 2, 4, 'null', 649, 510, 'i2', 'activo', '2026-02-28 00:13:51', '2026-02-28 00:13:51'),
(5, 1, 1, 3, 5, 'null', 290, 159, 'c1', 'activo', '2026-02-28 00:13:51', '2026-02-28 00:13:51'),
(6, 1, 1, 3, 6, 'null', 587, 379, 'c2', 'activo', '2026-02-28 00:13:51', '2026-02-28 00:13:51'),
(7, 1, 1, 4, 7, 'null', 276, 665, 'v1', 'activo', '2026-02-28 00:13:51', '2026-02-28 00:13:51'),
(8, 1, 1, 4, 8, 'null', 375, 376, 'v2', 'activo', '2026-02-28 00:13:51', '2026-02-28 00:13:51'),
(9, 1, 1, 5, 9, 'null', 889, 345, 'p1', 'activo', '2026-02-28 00:13:51', '2026-02-28 00:13:51'),
(10, 1, 1, 5, 10, 'null', 809, 212, 'p2', 'activo', '2026-02-28 00:13:51', '2026-02-28 00:13:51'),
(11, 2, 2, 1, 1, 'null', 142, 46, 'g1', 'activo', '2026-02-28 00:15:07', '2026-02-28 00:15:07'),
(12, 2, 2, 1, 2, 'null', 529, 399, 'g2', 'activo', '2026-02-28 00:15:07', '2026-02-28 00:15:07'),
(13, 2, 2, 2, 3, 'null', 942, 341, 'i1', 'activo', '2026-02-28 00:15:07', '2026-02-28 00:15:07'),
(14, 2, 2, 2, 4, 'null', 644, 50, 'i2', 'activo', '2026-02-28 00:15:07', '2026-02-28 00:15:07'),
(15, 2, 2, 3, 5, 'null', 312, 195, 'c1', 'activo', '2026-02-28 00:15:07', '2026-02-28 00:15:07'),
(16, 2, 2, 3, 6, 'null', 873, 108, 'c2', 'activo', '2026-02-28 00:15:07', '2026-02-28 00:15:07'),
(17, 2, 2, 4, 7, 'null', 133, 414, 'v1', 'activo', '2026-02-28 00:15:07', '2026-02-28 00:15:07'),
(18, 2, 2, 4, 8, 'null', 417, 596, 'v2', 'activo', '2026-02-28 00:15:07', '2026-02-28 00:15:07'),
(19, 2, 2, 5, 9, 'null', 771, 619, 'p1', 'activo', '2026-02-28 00:15:07', '2026-02-28 00:15:07'),
(20, 2, 2, 5, 10, 'null', 585, 612, 'p2', 'activo', '2026-02-28 00:15:07', '2026-02-28 00:15:07'),
(21, 3, 3, 1, 1, 'null', 169, 120, 'g1', 'activo', '2026-02-28 00:16:41', '2026-02-28 00:16:41'),
(22, 3, 3, 1, 2, 'null', 793, 338, 'g2', 'activo', '2026-02-28 00:16:41', '2026-02-28 00:16:41'),
(23, 3, 3, 2, 3, 'null', 889, 462, 'i1', 'activo', '2026-02-28 00:16:41', '2026-02-28 00:16:41'),
(24, 3, 3, 2, 4, 'null', 474, 87, 'i2', 'activo', '2026-02-28 00:16:41', '2026-02-28 00:16:41'),
(25, 3, 3, 3, 5, 'null', 231, 231, 'c1', 'activo', '2026-02-28 00:16:41', '2026-02-28 00:16:41'),
(26, 3, 3, 3, 6, 'null', 778, 234, 'c2', 'activo', '2026-02-28 00:16:41', '2026-02-28 00:16:41'),
(27, 3, 3, 4, 7, 'null', 244, 333, 'v1', 'activo', '2026-02-28 00:16:41', '2026-02-28 00:16:41'),
(28, 3, 3, 4, 8, 'null', 793, 106, 'v2', 'activo', '2026-02-28 00:16:41', '2026-02-28 00:16:41'),
(29, 3, 3, 5, 9, 'null', 276, 431, 'p1', 'activo', '2026-02-28 00:16:41', '2026-02-28 00:16:41'),
(30, 3, 3, 5, 10, 'null', 671, 595, 'p2', 'activo', '2026-02-28 00:16:41', '2026-02-28 00:16:41'),
(31, 4, 4, 1, 1, 'null', 179, 153, 'g1', 'activo', '2026-02-28 00:17:57', '2026-02-28 00:17:57'),
(32, 4, 4, 1, 2, 'null', 290, 482, 'g2', 'activo', '2026-02-28 00:17:57', '2026-02-28 00:17:57'),
(33, 4, 4, 2, 3, 'null', 177, 247, 'i1', 'activo', '2026-02-28 00:17:57', '2026-02-28 00:17:57'),
(34, 4, 4, 2, 4, 'null', 568, 484, 'i2', 'activo', '2026-02-28 00:17:57', '2026-02-28 00:17:57'),
(35, 4, 4, 3, 5, 'null', 863, 154, 'c1', 'activo', '2026-02-28 00:17:57', '2026-02-28 00:17:57'),
(36, 4, 4, 3, 6, 'null', 868, 307, 'c2', 'activo', '2026-02-28 00:17:57', '2026-02-28 00:17:57'),
(37, 4, 4, 4, 7, 'null', 745, 207, 'v1', 'activo', '2026-02-28 00:17:57', '2026-02-28 00:17:57'),
(38, 4, 4, 4, 8, 'null', 747, 304, 'v2', 'activo', '2026-02-28 00:17:57', '2026-02-28 00:17:57'),
(39, 4, 4, 5, 9, 'null', 854, 460, 'p1', 'activo', '2026-02-28 00:17:57', '2026-02-28 00:17:57'),
(40, 4, 4, 5, 10, 'null', 486, 293, 'p2', 'activo', '2026-02-28 00:17:57', '2026-02-28 00:17:57'),
(41, 5, 5, 1, 1, 'null', 531, 65, 'g1', 'activo', '2026-02-28 00:20:12', '2026-02-28 00:20:12'),
(42, 5, 5, 1, 2, 'null', 635, 69, 'g2', 'activo', '2026-02-28 00:20:12', '2026-02-28 00:20:12'),
(43, 5, 5, 2, 3, 'null', 528, 254, 'i1', 'activo', '2026-02-28 00:20:12', '2026-02-28 00:20:12'),
(44, 5, 5, 2, 4, 'null', 806, 67, 'i2', 'activo', '2026-02-28 00:20:12', '2026-02-28 00:20:12'),
(45, 5, 5, 3, 5, 'null', 913, 214, 'c1', 'activo', '2026-02-28 00:20:12', '2026-02-28 00:20:12'),
(46, 5, 5, 3, 6, 'null', 534, 351, 'c2', 'activo', '2026-02-28 00:20:12', '2026-02-28 00:20:12'),
(47, 5, 5, 4, 7, 'null', 646, 218, 'v1', 'activo', '2026-02-28 00:20:12', '2026-02-28 00:20:12'),
(48, 5, 5, 4, 8, 'null', 915, 122, 'v2', 'activo', '2026-02-28 00:20:12', '2026-02-28 00:20:12'),
(49, 5, 5, 5, 9, 'null', 751, 272, 'p1', 'activo', '2026-02-28 00:20:12', '2026-02-28 00:20:12'),
(50, 5, 5, 5, 10, 'null', 841, 273, 'p2', 'activo', '2026-02-28 00:20:12', '2026-02-28 00:20:12'),
(51, 6, 6, 1, 1, 'null', 62, 44, 'g1', 'activo', '2026-02-28 00:22:11', '2026-02-28 00:22:11'),
(52, 6, 6, 1, 2, 'null', 773, 51, 'g2', 'activo', '2026-02-28 00:22:11', '2026-02-28 00:22:11'),
(53, 6, 6, 2, 3, 'null', 956, 361, 'i1', 'activo', '2026-02-28 00:22:11', '2026-02-28 00:22:11'),
(54, 6, 6, 2, 4, 'null', 305, 234, 'i2', 'activo', '2026-02-28 00:22:11', '2026-02-28 00:22:11'),
(55, 6, 6, 3, 5, 'null', 228, 444, 'c1', 'activo', '2026-02-28 00:22:11', '2026-02-28 00:22:11'),
(56, 6, 6, 3, 6, 'null', 872, 559, 'c2', 'activo', '2026-02-28 00:22:11', '2026-02-28 00:22:11'),
(57, 6, 6, 4, 7, 'null', 507, 550, 'v1', 'activo', '2026-02-28 00:22:11', '2026-02-28 00:22:11'),
(58, 6, 6, 4, 8, 'null', 706, 550, 'v2', 'activo', '2026-02-28 00:22:11', '2026-02-28 00:22:11'),
(59, 6, 6, 5, 9, 'null', 211, 588, 'p1', 'activo', '2026-02-28 00:22:11', '2026-02-28 00:22:11'),
(60, 6, 6, 5, 10, 'null', 362, 632, 'p2', 'activo', '2026-02-28 00:22:11', '2026-02-28 00:22:11'),
(61, 7, 7, 1, 1, 'null', 269, 148, 'g1', 'activo', '2026-02-28 00:24:15', '2026-02-28 00:24:15'),
(62, 7, 7, 1, 2, 'null', 709, 568, 'g2', 'activo', '2026-02-28 00:24:15', '2026-02-28 00:24:15'),
(63, 7, 7, 2, 3, 'null', 258, 334, 'i1', 'activo', '2026-02-28 00:24:15', '2026-02-28 00:24:15'),
(64, 7, 7, 2, 4, 'null', 524, 148, 'i2', 'activo', '2026-02-28 00:24:15', '2026-02-28 00:24:15'),
(65, 7, 7, 3, 5, 'null', 497, 550, 'c1', 'activo', '2026-02-28 00:24:15', '2026-02-28 00:24:15'),
(66, 7, 7, 3, 6, 'null', 693, 178, 'c2', 'activo', '2026-02-28 00:24:15', '2026-02-28 00:24:15'),
(67, 7, 7, 4, 7, 'null', 559, 292, 'v1', 'activo', '2026-02-28 00:24:15', '2026-02-28 00:24:15'),
(68, 7, 7, 4, 8, 'null', 281, 494, 'v2', 'activo', '2026-02-28 00:24:15', '2026-02-28 00:24:15'),
(69, 7, 7, 5, 9, 'null', 668, 413, 'p1', 'activo', '2026-02-28 00:24:15', '2026-02-28 00:24:15'),
(70, 7, 7, 5, 10, 'null', 444, 432, 'p2', 'activo', '2026-02-28 00:24:15', '2026-02-28 00:24:15');

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
(1, 2, 3, 1, 5, '2026-02-28 00:37:06', '2026-02-28 00:37:06'),
(2, 2, 3, 2, 8, '2026-02-28 00:37:06', '2026-02-28 00:37:06'),
(3, 2, 3, 3, 9, '2026-02-28 00:37:06', '2026-02-28 00:37:06'),
(4, 2, 4, 1, 3, '2026-02-28 00:37:06', '2026-02-28 00:37:06'),
(5, 2, 4, 2, 4, '2026-02-28 00:37:06', '2026-02-28 00:37:06'),
(6, 2, 4, 3, 6, '2026-02-28 00:37:06', '2026-02-28 00:37:06'),
(7, 3, 3, 2, 3, '2026-02-28 00:39:14', '2026-02-28 00:39:14'),
(8, 3, 3, 1, 2, '2026-02-28 00:39:14', '2026-02-28 00:39:14'),
(9, 3, 3, 3, 1, '2026-02-28 00:39:14', '2026-02-28 00:39:14'),
(10, 3, 4, 1, 3, '2026-02-28 00:39:14', '2026-02-28 00:39:14'),
(11, 3, 4, 2, 2, '2026-02-28 00:39:14', '2026-02-28 00:39:14'),
(12, 3, 4, 3, 2, '2026-02-28 00:39:14', '2026-02-28 00:39:14');

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
(1, 1, 1, 'MA', 0, 150, 50, 100, '2026-02-28 00:35:31', '2026-02-28 00:35:31'),
(2, 1, 2, 'MA', 0, 150, 50, 100, '2026-02-28 00:35:31', '2026-02-28 00:35:31'),
(3, 1, 5, 'C', 1, 150, 70, 80, '2026-02-28 00:35:31', '2026-02-28 00:35:31'),
(4, 1, 6, 'MA', 0, 150, 50, 100, '2026-02-28 00:35:31', '2026-02-28 00:35:31'),
(5, 1, 7, 'MA', 0, 150, 50, 100, '2026-02-28 00:35:31', '2026-02-28 00:35:31'),
(6, 1, 8, 'C', 1, 150, 70, 80, '2026-02-28 00:35:31', '2026-02-28 00:35:31'),
(7, 1, 9, 'MA', 0, 150, 50, 100, '2026-02-28 00:35:31', '2026-02-28 00:35:31'),
(8, 1, 10, 'MA', 0, 150, 50, 100, '2026-02-28 00:35:31', '2026-02-28 00:35:31');

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
(1, 'golpe', '/images/trampas/trampa_raton.jpg', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(2, 'insecto', '/images/trampas/trampa_insecto.jpg', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(3, 'caja', '/images/trampas/caja_negra.jpg', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(4, 'viva', '/images/trampas/captura_viva.jpg', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(5, 'pegajosa', '/images/trampas/pegajosa.png', '2026-02-27 22:15:45', '2026-02-27 22:15:45');

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
(1, 'Gramos', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(2, 'C.C.', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(3, 'Unidad', '2026-02-27 22:15:45', '2026-02-27 22:15:45'),
(4, 'Litros', '2026-02-27 22:15:45', '2026-02-27 22:15:45');

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
(1, 'uno', 'uno@uno.com', NULL, '$2y$12$ajnCPSVPIGyHl4BK7ZN0zup5oG0NWxkepHE.2UqPC0XQXCkHrcAxG', NULL, NULL, NULL, NULL, '2026-02-27 22:15:02', '2026-02-27 22:15:02'),
(2, 'uno', 'uno1@uno.com', NULL, '$2y$12$N6fqghWYOjHBTvMVQ7/uReaz/dFeBgugpy1vS9ms9H/BFZmnfn4/S', NULL, NULL, NULL, NULL, '2026-02-27 22:16:38', '2026-02-27 22:16:38');

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `biologicos`
--
ALTER TABLE `biologicos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `buffer_productos`
--
ALTER TABLE `buffer_productos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `compra_detalles`
--
ALTER TABLE `compra_detalles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=143;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `mapas`
--
ALTER TABLE `mapas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=83;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `producto_usos`
--
ALTER TABLE `producto_usos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `seguimiento_biologicos`
--
ALTER TABLE `seguimiento_biologicos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `seguimiento_epps`
--
ALTER TABLE `seguimiento_epps`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `seguimiento_protecciones`
--
ALTER TABLE `seguimiento_protecciones`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `seguimiento_signos`
--
ALTER TABLE `seguimiento_signos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

--
-- AUTO_INCREMENT de la tabla `trampa_especie_seguimientos`
--
ALTER TABLE `trampa_especie_seguimientos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `trampa_roedor_seguimientos`
--
ALTER TABLE `trampa_roedor_seguimientos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

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
