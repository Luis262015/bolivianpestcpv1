-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 25-03-2026 a las 18:51:22
-- Versión del servidor: 10.6.25-MariaDB
-- Versión de PHP: 8.4.18

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
(1, 1, 'Almacén Central Zona Industrial', 'Calle 7 de Obrajes #1234', 'Carlos Mamani Quispe', '+591 77654321', 'almacen1@iaalimento.bo', 'La Paz', '2026-03-25 15:27:18', '2026-03-25 15:27:18'),
(2, 2, 'Bodega Norte', 'Av. Cristo Redentor #4521', 'María Elena Vargas Pinto', '+591 71234567', 'bodeganorte@dicropro.com.bo', 'Santa Cruz de la Sierra', '2026-03-25 15:45:48', '2026-03-25 15:45:48'),
(3, 2, 'Almacén de Materia Prima', 'Calle Sucre #789, Zona Norte', 'Juan Pablo Rojas Méndez', '+591 79876543', 'almacen.mp@textilescbba.bo', 'Cochabamba', '2026-03-25 15:45:48', '2026-03-25 15:45:48');

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
(1, 1, NULL, 850, 6, 3.5, 17850, '2026-03-25 15:27:18', '2026-03-25 15:27:18'),
(2, 2, NULL, 1200, 6, 4, 28800, '2026-03-25 15:45:48', '2026-03-25 15:45:48'),
(3, 3, NULL, 950, 6, 3.2, 18240, '2026-03-25 15:45:48', '2026-03-25 15:45:48');

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
(1, 1, NULL, 25, 12, 40, 12000, '2026-03-25 15:27:18', '2026-03-25 15:27:18'),
(2, 2, NULL, 40, 12, 68, 32640, '2026-03-25 15:45:48', '2026-03-25 15:45:48'),
(3, 3, NULL, 30, 12, 54, 19440, '2026-03-25 15:45:48', '2026-03-25 15:45:48');

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
(1, 1, NULL, 8, 4, 180, 720, '2026-03-25 15:27:18', '2026-03-25 15:27:18'),
(2, 2, NULL, 3, 4, 220, 880, '2026-03-25 15:45:48', '2026-03-25 15:45:48'),
(3, 3, NULL, 4, 4, 200, 800, '2026-03-25 15:45:48', '2026-03-25 15:45:48');

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
(1, 'Adulto', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(2, 'Huevo', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(3, 'Larva', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(4, 'Ninfa', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(5, 'Pupa', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(6, 'Otros', '2026-03-25 14:13:55', '2026-03-25 14:13:55');

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
('bolivianpest-cache-51c586aa5e1c412a0f745dc07d6d0893', 'i:1;', 1774453614),
('bolivianpest-cache-51c586aa5e1c412a0f745dc07d6d0893:timer', 'i:1774453614;', 1774453614),
('bolivianpest-cache-d16680ebbc8bd946eaeb663d2196bf9d', 'i:1;', 1774455139),
('bolivianpest-cache-d16680ebbc8bd946eaeb663d2196bf9d:timer', 'i:1774455139;', 1774455139),
('bolivianpest-cache-d3ad692d7f1f5c2a2e6b28b87e4d8d21', 'i:1;', 1774465705),
('bolivianpest-cache-d3ad692d7f1f5c2a2e6b28b87e4d8d21:timer', 'i:1774465705;', 1774465705);

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
(1, 1, 30570.00, '2026-12-31', '2026-03-25 15:27:18', '2026-03-25 15:27:18'),
(2, 2, 100800.00, '2026-12-31', '2026-03-25 15:45:48', '2026-03-25 15:45:48');

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
(1, 1, 'Almacén Central Zona Industrial', '25', '12', '40', '12000', '850', '6', '3.5', '17850', '8', '4', '180', '720', 0.00, '2026-03-25 15:27:18', '2026-03-25 15:27:18'),
(2, 2, 'Bodega Norte', '40', '12', '68', '32640', '1200', '6', '4', '28800', '3', '4', '220', '880', 0.00, '2026-03-25 15:45:48', '2026-03-25 15:45:48'),
(3, 2, 'Almacén de Materia Prima', '30', '12', '54', '19440', '950', '6', '3.2', '18240', '4', '4', '200', '800', 0.00, '2026-03-25 15:45:48', '2026-03-25 15:45:48');

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
(1, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-01-14', 'bg-yellow-500', 'pendiente', '2026-03-25 15:27:18', '2026-03-25 15:27:18'),
(2, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-02-18', 'bg-yellow-500', 'pendiente', '2026-03-25 15:27:18', '2026-03-25 15:27:18'),
(3, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-03-17', 'bg-yellow-500', 'pendiente', '2026-03-25 15:27:18', '2026-03-25 15:27:18'),
(4, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-04-14', 'bg-yellow-500', 'pendiente', '2026-03-25 15:27:18', '2026-03-25 15:27:18'),
(5, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-05-12', 'bg-yellow-500', 'pendiente', '2026-03-25 15:27:18', '2026-03-25 15:27:18'),
(6, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-06-18', 'bg-yellow-500', 'pendiente', '2026-03-25 15:27:18', '2026-03-25 15:27:18'),
(7, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-07-16', 'bg-yellow-500', 'pendiente', '2026-03-25 15:27:18', '2026-03-25 15:27:18'),
(8, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-08-13', 'bg-yellow-500', 'pendiente', '2026-03-25 15:27:18', '2026-03-25 15:27:18'),
(9, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-09-16', 'bg-yellow-500', 'pendiente', '2026-03-25 15:27:18', '2026-03-25 15:27:18'),
(10, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-10-14', 'bg-yellow-500', 'pendiente', '2026-03-25 15:27:18', '2026-03-25 15:27:18'),
(11, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-11-19', 'bg-yellow-500', 'pendiente', '2026-03-25 15:27:18', '2026-03-25 15:27:18'),
(12, 1, 1, 2, 2, 1, 'DESRATIZACION', '2026-12-15', 'bg-yellow-500', 'pendiente', '2026-03-25 15:27:18', '2026-03-25 15:27:18'),
(13, 1, 1, 2, 2, 2, 'FUMIGACION', '2026-02-18', 'bg-blue-500', 'pendiente', '2026-03-25 15:27:18', '2026-03-25 15:27:18'),
(14, 1, 1, 2, 2, 2, 'FUMIGACION', '2026-04-15', 'bg-blue-500', 'pendiente', '2026-03-25 15:27:18', '2026-03-25 15:27:18'),
(15, 1, 1, 2, 2, 2, 'FUMIGACION', '2026-06-17', 'bg-blue-500', 'pendiente', '2026-03-25 15:27:18', '2026-03-25 15:27:18'),
(16, 1, 1, 2, 2, 2, 'FUMIGACION', '2026-08-12', 'bg-blue-500', 'pendiente', '2026-03-25 15:27:18', '2026-03-25 15:27:18'),
(17, 1, 1, 2, 2, 2, 'FUMIGACION', '2026-10-21', 'bg-blue-500', 'pendiente', '2026-03-25 15:27:18', '2026-03-25 15:27:18'),
(18, 1, 1, 2, 2, 2, 'FUMIGACION', '2026-12-16', 'bg-blue-500', 'pendiente', '2026-03-25 15:27:18', '2026-03-25 15:27:18'),
(19, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-03-11', 'bg-pink-600', 'pendiente', '2026-03-25 15:27:18', '2026-03-25 18:08:46'),
(20, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-06-17', 'bg-pink-600', 'pendiente', '2026-03-25 15:27:18', '2026-03-25 15:27:18'),
(21, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-09-16', 'bg-pink-600', 'pendiente', '2026-03-25 15:27:18', '2026-03-25 15:27:18'),
(22, 1, 1, 2, 2, 3, 'INSECTOCUTORES', '2026-12-16', 'bg-pink-600', 'pendiente', '2026-03-25 15:27:18', '2026-03-25 15:27:18'),
(23, 2, 2, 2, 2, 1, 'DESRATIZACION', '2026-01-14', 'bg-yellow-500', 'pendiente', '2026-03-25 15:45:48', '2026-03-25 15:45:48'),
(24, 2, 2, 2, 2, 1, 'DESRATIZACION', '2026-02-18', 'bg-yellow-500', 'pendiente', '2026-03-25 15:45:48', '2026-03-25 15:45:48'),
(25, 2, 2, 2, 2, 1, 'DESRATIZACION', '2026-03-17', 'bg-yellow-500', 'pendiente', '2026-03-25 15:45:48', '2026-03-25 15:45:48'),
(26, 2, 2, 2, 2, 1, 'DESRATIZACION', '2026-04-19', 'bg-yellow-500', 'pendiente', '2026-03-25 15:45:48', '2026-03-25 15:45:48'),
(27, 2, 2, 2, 2, 1, 'DESRATIZACION', '2026-05-12', 'bg-yellow-500', 'pendiente', '2026-03-25 15:45:48', '2026-03-25 15:45:48'),
(28, 2, 2, 2, 2, 1, 'DESRATIZACION', '2026-06-10', 'bg-yellow-500', 'pendiente', '2026-03-25 15:45:48', '2026-03-25 15:45:48'),
(29, 2, 2, 2, 2, 1, 'DESRATIZACION', '2026-07-15', 'bg-yellow-500', 'pendiente', '2026-03-25 15:45:48', '2026-03-25 15:45:48'),
(30, 2, 2, 2, 2, 1, 'DESRATIZACION', '2026-08-10', 'bg-yellow-500', 'pendiente', '2026-03-25 15:45:48', '2026-03-25 15:45:48'),
(31, 2, 2, 2, 2, 1, 'DESRATIZACION', '2026-09-16', 'bg-yellow-500', 'pendiente', '2026-03-25 15:45:48', '2026-03-25 15:45:48'),
(32, 2, 2, 2, 2, 1, 'DESRATIZACION', '2026-10-13', 'bg-yellow-500', 'pendiente', '2026-03-25 15:45:48', '2026-03-25 15:45:48'),
(33, 2, 2, 2, 2, 1, 'DESRATIZACION', '2026-11-24', 'bg-yellow-500', 'pendiente', '2026-03-25 15:45:48', '2026-03-25 15:45:48'),
(34, 2, 2, 2, 2, 1, 'DESRATIZACION', '2026-12-15', 'bg-yellow-500', 'pendiente', '2026-03-25 15:45:48', '2026-03-25 15:45:48'),
(35, 2, 2, 2, 2, 2, 'FUMIGACION', '2026-02-17', 'bg-blue-500', 'pendiente', '2026-03-25 15:45:48', '2026-03-25 15:45:48'),
(36, 2, 2, 2, 2, 2, 'FUMIGACION', '2026-04-15', 'bg-blue-500', 'pendiente', '2026-03-25 15:45:48', '2026-03-25 15:45:48'),
(37, 2, 2, 2, 2, 2, 'FUMIGACION', '2026-06-25', 'bg-blue-500', 'pendiente', '2026-03-25 15:45:48', '2026-03-25 15:45:48'),
(38, 2, 2, 2, 2, 2, 'FUMIGACION', '2026-08-25', 'bg-blue-500', 'pendiente', '2026-03-25 15:45:48', '2026-03-25 15:45:48'),
(39, 2, 2, 2, 2, 2, 'FUMIGACION', '2026-09-25', 'bg-blue-500', 'pendiente', '2026-03-25 15:45:48', '2026-03-25 15:45:48'),
(40, 2, 2, 2, 2, 2, 'FUMIGACION', '2026-12-16', 'bg-blue-500', 'pendiente', '2026-03-25 15:45:48', '2026-03-25 15:45:48'),
(41, 2, 2, 2, 2, 3, 'INSECTOCUTORES', '2026-03-18', 'bg-pink-600', 'pendiente', '2026-03-25 15:45:48', '2026-03-25 15:45:48'),
(42, 2, 2, 2, 2, 3, 'INSECTOCUTORES', '2026-06-25', 'bg-pink-600', 'pendiente', '2026-03-25 15:45:48', '2026-03-25 15:45:48'),
(43, 2, 2, 2, 2, 3, 'INSECTOCUTORES', '2026-09-25', 'bg-pink-600', 'pendiente', '2026-03-25 15:45:48', '2026-03-25 15:45:48'),
(44, 2, 2, 2, 2, 3, 'INSECTOCUTORES', '2026-12-16', 'bg-pink-600', 'pendiente', '2026-03-25 15:45:48', '2026-03-25 15:45:48'),
(45, 2, 3, 2, 2, 1, 'DESRATIZACION', '2026-01-14', 'bg-yellow-500', 'pendiente', '2026-03-25 15:45:48', '2026-03-25 15:45:48'),
(46, 2, 3, 2, 2, 1, 'DESRATIZACION', '2026-02-10', 'bg-yellow-500', 'pendiente', '2026-03-25 15:45:48', '2026-03-25 15:45:48'),
(47, 2, 3, 2, 2, 1, 'DESRATIZACION', '2026-03-11', 'bg-yellow-500', 'pendiente', '2026-03-25 15:45:48', '2026-03-25 15:45:48'),
(48, 2, 3, 2, 2, 1, 'DESRATIZACION', '2026-04-07', 'bg-yellow-500', 'pendiente', '2026-03-25 15:45:48', '2026-03-25 15:45:48'),
(49, 2, 3, 2, 2, 1, 'DESRATIZACION', '2026-05-05', 'bg-yellow-500', 'pendiente', '2026-03-25 15:45:48', '2026-03-25 15:45:48'),
(50, 2, 3, 2, 2, 1, 'DESRATIZACION', '2026-06-09', 'bg-yellow-500', 'pendiente', '2026-03-25 15:45:48', '2026-03-25 15:45:48'),
(51, 2, 3, 2, 2, 1, 'DESRATIZACION', '2026-07-25', 'bg-yellow-500', 'pendiente', '2026-03-25 15:45:48', '2026-03-25 15:45:48'),
(52, 2, 3, 2, 2, 1, 'DESRATIZACION', '2026-08-25', 'bg-yellow-500', 'pendiente', '2026-03-25 15:45:48', '2026-03-25 15:45:48'),
(53, 2, 3, 2, 2, 1, 'DESRATIZACION', '2026-09-17', 'bg-yellow-500', 'pendiente', '2026-03-25 15:45:48', '2026-03-25 15:45:48'),
(54, 2, 3, 2, 2, 1, 'DESRATIZACION', '2026-10-13', 'bg-yellow-500', 'pendiente', '2026-03-25 15:45:48', '2026-03-25 15:45:48'),
(55, 2, 3, 2, 2, 1, 'DESRATIZACION', '2026-11-18', 'bg-yellow-500', 'pendiente', '2026-03-25 15:45:48', '2026-03-25 15:45:48'),
(56, 2, 3, 2, 2, 1, 'DESRATIZACION', '2026-12-15', 'bg-yellow-500', 'pendiente', '2026-03-25 15:45:48', '2026-03-25 15:45:48'),
(57, 2, 3, 2, 2, 2, 'FUMIGACION', '2026-02-10', 'bg-blue-500', 'pendiente', '2026-03-25 15:45:48', '2026-03-25 15:45:48'),
(58, 2, 3, 2, 2, 2, 'FUMIGACION', '2026-04-25', 'bg-blue-500', 'pendiente', '2026-03-25 15:45:48', '2026-03-25 15:45:48'),
(59, 2, 3, 2, 2, 2, 'FUMIGACION', '2026-06-25', 'bg-blue-500', 'pendiente', '2026-03-25 15:45:48', '2026-03-25 15:45:48'),
(60, 2, 3, 2, 2, 2, 'FUMIGACION', '2026-08-25', 'bg-blue-500', 'pendiente', '2026-03-25 15:45:48', '2026-03-25 15:45:48'),
(61, 2, 3, 2, 2, 2, 'FUMIGACION', '2026-10-25', 'bg-blue-500', 'pendiente', '2026-03-25 15:45:48', '2026-03-25 15:45:48'),
(62, 2, 3, 2, 2, 2, 'FUMIGACION', '2026-12-15', 'bg-blue-500', 'pendiente', '2026-03-25 15:45:48', '2026-03-25 15:45:48'),
(63, 2, 3, 2, 2, 3, 'INSECTOCUTORES', '2026-03-11', 'bg-pink-600', 'pendiente', '2026-03-25 15:45:48', '2026-03-25 15:45:48'),
(64, 2, 3, 2, 2, 3, 'INSECTOCUTORES', '2026-06-16', 'bg-pink-600', 'pendiente', '2026-03-25 15:45:48', '2026-03-25 15:45:48'),
(65, 2, 3, 2, 2, 3, 'INSECTOCUTORES', '2026-09-25', 'bg-pink-600', 'pendiente', '2026-03-25 15:45:48', '2026-03-25 15:45:48'),
(66, 2, 3, 2, 2, 3, 'INSECTOCUTORES', '2026-12-15', 'bg-pink-600', 'pendiente', '2026-03-25 15:45:48', '2026-03-25 15:45:48');

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
(1, NULL, 1, NULL, 2, 'Contrato por cobrar #1', 'Saldo pendiento por cobrar sobre contrato', 30570, 30570, 'Pendiente', NULL, 0, '2026-03-25 15:27:18', '2026-03-25 15:27:18'),
(2, NULL, 2, NULL, 2, 'Contrato por cobrar #2', 'Saldo pendiento por cobrar sobre contrato', 100800, 100800, 'Pendiente', NULL, 0, '2026-03-25 15:45:48', '2026-03-25 15:45:48');

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
(1, 'Gastos bancarios operativos', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(2, 'Capacitacion y cursos', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(3, 'Licencias de Software', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(4, 'Gastos de representación', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(5, 'Eventos y actividades', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(6, 'Seguridad y vigilancia', '2026-03-25 14:13:55', '2026-03-25 14:13:55');

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
(1, 'Sueldos administrativos', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(2, 'Honorarios profesionales', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(3, 'Utiles de oficina', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(4, 'Alquiler de oficina', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(5, 'Energia Electrica', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(6, 'Agua', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(7, 'Telefono', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(8, 'Mantenimiento y reparaciones', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(9, 'Limpieza', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(10, 'Seguros', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(11, 'Depresiacion', '2026-03-25 14:13:55', '2026-03-25 14:13:55');

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
(1, 'Sueldos personal', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(2, 'Comisiones sobre ventas', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(3, 'Marketing digital', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(4, 'Material promocional', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(5, 'Transporte y distribucion', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(6, 'Combustible', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(7, 'Viaticos y movilidad', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(8, 'Empaques y embalajes', '2026-03-25 14:13:55', '2026-03-25 14:13:55');

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
(1, 'Industrias Alimenticias del Altiplano S.R.L.', 'Av. Arce #2547, Edif. Torre Empresarial, Piso 8', '+591 2-2789456', 'contacto@iaalimento.bo', 'La Paz', 1, '2026-03-25 15:27:18', '2026-03-25 15:27:18'),
(2, 'Distribuidora Cruceña de Productos S.A.', 'Av. Banzer Km 5.5, Zona Industrial', '+591 3-3456789', 'admin@dicropro.com.bo', 'Santa Cruz de la Sierra', 1, '2026-03-25 15:45:48', '2026-03-25 15:45:48');

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
(1, 'Ropa de trabajo', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(2, 'Casco de proteccion', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(3, 'Gorra', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(4, 'Guantes', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(5, 'Overol', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(6, 'Botas', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(7, 'Gafas', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(8, 'Antiparras', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(9, 'Respirados', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(10, 'Full face', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(11, 'Otros', '2026-03-25 14:13:55', '2026-03-25 14:13:55');

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
(1, 'Moscas', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(2, 'Polillas', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(3, 'Mosquitos', '2026-03-25 14:13:55', '2026-03-25 14:13:55');

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
(1, 1, 1, 2, NULL, NULL, 'images/mapas/1_1774466426.jpeg', '2026-03-25 18:20:26', '2026-03-25 18:20:26'),
(2, 2, 2, 2, 'planta produccion', NULL, 'images/mapas/2_1774466966.jpeg', '2026-03-25 18:29:26', '2026-03-25 18:30:21'),
(3, 2, 2, 2, 'oficina', NULL, 'images/mapas/2_1774467170.jpeg', '2026-03-25 18:32:50', '2026-03-25 18:32:50'),
(4, 2, 3, 2, 'eventos', NULL, 'images/mapas/3_1774469494.jpeg', '2026-03-25 19:11:34', '2026-03-25 19:11:34');

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
(1, 'Alimento con veneno', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(2, 'Sustancia pegajosa', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(3, 'Alimento', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(4, 'Aspersion', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(5, 'Niebla', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(6, 'Nebulizacion', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(7, 'Fumigacion', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(8, 'Otros', '2026-03-25 14:13:55', '2026-03-25 14:13:55');

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
(1, 'empresas', 'web', '2026-03-25 14:13:54', '2026-03-25 14:13:54'),
(2, 'cotizaciones', 'web', '2026-03-25 14:13:54', '2026-03-25 14:13:54'),
(3, 'contratos', 'web', '2026-03-25 14:13:54', '2026-03-25 14:13:54'),
(4, 'almacenes', 'web', '2026-03-25 14:13:54', '2026-03-25 14:13:54'),
(5, 'cronogramas', 'web', '2026-03-25 14:13:54', '2026-03-25 14:13:54'),
(6, 'mapas', 'web', '2026-03-25 14:13:54', '2026-03-25 14:13:54'),
(7, 'seguimientos', 'web', '2026-03-25 14:13:54', '2026-03-25 14:13:54'),
(8, 'certificados', 'web', '2026-03-25 14:13:54', '2026-03-25 14:13:54'),
(9, 'cuentascobrar', 'web', '2026-03-25 14:13:54', '2026-03-25 14:13:54'),
(10, 'cuentaspagar', 'web', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(11, 'compras', 'web', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(12, 'ingresos', 'web', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(13, 'retiros', 'web', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(14, 'gastos', 'web', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(15, 'productos', 'web', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(16, 'categorias', 'web', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(17, 'subcategorias', 'web', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(18, 'marcas', 'web', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(19, 'etiquetas', 'web', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(20, 'proveedores', 'web', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(21, 'inventario', 'web', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(22, 'agenda', 'web', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(23, 'documentos', 'web', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(24, 'usuarios', 'web', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(25, 'configuraciones', 'web', '2026-03-25 14:13:55', '2026-03-25 14:13:55');

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
(1, NULL, NULL, 1, 'klerat', 'matar ratones', 150, NULL, 2, NULL, NULL, '2026-03-25 19:23:04', '2026-03-25 19:23:04'),
(2, NULL, NULL, 4, 'fumi', 'fumigacion', 1, NULL, 2, NULL, NULL, '2026-03-25 19:23:46', '2026-03-25 19:23:46');

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
(1, 'Señalizacion', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(2, 'Hoja de seguimiento', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(3, 'Otros', '2026-03-25 14:13:55', '2026-03-25 14:13:55');

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
(1, 'superadmin', 'web', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(2, 'admin', 'web', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(3, 'tecnico', 'web', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(4, 'cliente', 'web', '2026-03-25 14:13:55', '2026-03-25 14:13:55');

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
('6gFSavik5LgnZaqR4eKiNk8ettzQrdNo7z8v0RzA', 2, '190.109.225.3', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoibXh6b0RTRUxnVUlOaFNGSjZHRTIyN1lQeW1LSmVKbjh6NHQ2enVmTyI7czozOiJ1cmwiO2E6MDp7fXM6OToiX3ByZXZpb3VzIjthOjI6e3M6MzoidXJsIjtzOjI0OiJodHRwczovL2JvbGl2aWFucGVzdC5jb20iO3M6NToicm91dGUiO3M6NDoiaG9tZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjI7fQ==', 1774474810),
('9nZl33svMnD6gQo3eLVzLxeHRAILeta0Ey8ICSFO', 1, '190.109.225.3', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoiZ09pQ1AzbFJTSUJRRHZIYVNCQkNQUHcwemw2VlRmaTdtRWprQjRUayI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDc6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmNvbS9wcm9kdWN0b3Mvc2VhcmNoP3E9a2xlIjtzOjU6InJvdXRlIjtzOjE2OiJwcm9kdWN0b3Muc2VhcmNoIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czozOiJ1cmwiO2E6MDp7fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjE7fQ==', 1774475143),
('DearCUFkMKtKXiUM9tVWCtVHgeHJ3twJkvKwVa3i', NULL, '190.109.225.3', 'Claude-User (claude-code/2.1.83; +https://support.anthropic.com/)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQ0R4aUJqbXFOZnlwWDJUalNiZUNYdmJrN3Iwb25WVjZKZXk5ZWoweCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjQ6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmNvbSI7czo1OiJyb3V0ZSI7czo0OiJob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1774470496),
('gEFIiInVtosM0Zzbjms8A2DEJF4oHngJ7akpCg7w', NULL, '190.109.225.3', 'Claude-User (claude-code/2.1.83; +https://support.anthropic.com/)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSW5hNW9hbWExTWd1dWNMVE1CRHl4b0EwRkRxVHBLdlVXZFJBYmVIRyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjQ6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmNvbSI7czo1OiJyb3V0ZSI7czo0OiJob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1774469978),
('HkH3kVYcIssQcuSjGM2QoqBGzlDuNHhrC7k90PEd', NULL, '190.109.225.3', 'Claude-User (claude-code/2.1.83; +https://support.anthropic.com/)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVlhyZkRzRDBVa3oyVzNxQ045cEpCOGV3WG1qWXBNSDVtVmdwaW9EbSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjQ6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmNvbSI7czo1OiJyb3V0ZSI7czo0OiJob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1774474831),
('jDsoaboDwOUtO5wnGM29eyP37Nfwx5S7iPSWOKMy', NULL, '190.109.225.3', 'curl/8.7.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiR3VCRHVuVEJFeVhXOE1tTUN0Vlo3bFZqNXBuYWE1eHVGSG03TjNWbyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjQ6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmNvbSI7czo1OiJyb3V0ZSI7czo0OiJob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1774470203),
('t7wRRUDqhSUUxLt2KI3Hb3mvMkAFOfucf9gSdizd', NULL, '190.109.225.3', 'curl/8.7.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNlFpOXgyRmVNNWRPWTBWd2g2UTVzTEtVUlZsVnlLN0pIVHhMZ2xTOCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjQ6Imh0dHBzOi8vYm9saXZpYW5wZXN0LmNvbSI7czo1OiJyb3V0ZSI7czo0OiJob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1774470669);

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
(1, 'Huellas', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(2, 'Roeduras', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(3, 'Madriguera', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(4, 'Senda', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(5, 'Excrementos', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(6, 'Marca de orina', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(7, 'Otros', '2026-03-25 14:13:55', '2026-03-25 14:13:55');

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
(1, 'DESRATIZACION', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(2, 'FUMIGACION', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(3, 'INSECTOCUTORES', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(4, 'CONTROL DE AVES', '2026-03-25 14:13:55', '2026-03-25 14:13:55');

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
(1, 1, 1, 1, 1, 'null', 174, 143, 'g1', 'activo', '2026-03-25 18:20:26', '2026-03-25 18:20:26'),
(2, 1, 1, 1, 2, 'null', 214, 143, 'g2', 'activo', '2026-03-25 18:20:26', '2026-03-25 18:20:26'),
(3, 1, 1, 1, 3, 'null', 265, 144, 'g3', 'activo', '2026-03-25 18:20:26', '2026-03-25 18:20:26'),
(4, 1, 1, 1, 4, 'null', 306, 143, 'g4', 'activo', '2026-03-25 18:20:26', '2026-03-25 18:20:26'),
(5, 1, 1, 1, 5, 'null', 344, 148, 'g5', 'activo', '2026-03-25 18:20:26', '2026-03-25 18:20:26'),
(6, 1, 1, 1, 6, 'null', 385, 146, 'g6', 'activo', '2026-03-25 18:20:26', '2026-03-25 18:20:26'),
(7, 1, 1, 1, 7, 'null', 428, 145, 'g7', 'activo', '2026-03-25 18:20:26', '2026-03-25 18:20:26'),
(8, 1, 1, 2, 8, 'null', 188, 461, 'i1', 'activo', '2026-03-25 18:20:26', '2026-03-25 18:20:26'),
(9, 1, 1, 2, 9, 'null', 466, 398, 'i2', 'activo', '2026-03-25 18:20:26', '2026-03-25 18:20:26'),
(10, 1, 1, 3, 10, 'null', 706, 149, 'c1', 'activo', '2026-03-25 18:20:26', '2026-03-25 18:20:26'),
(11, 1, 1, 3, 11, 'null', 600, 298, 'c2', 'activo', '2026-03-25 18:20:26', '2026-03-25 18:20:26'),
(12, 1, 1, 3, 12, 'null', 714, 241, 'c3', 'activo', '2026-03-25 18:20:26', '2026-03-25 18:20:26'),
(13, 1, 1, 3, 13, 'null', 571, 482, 'c4', 'activo', '2026-03-25 18:20:26', '2026-03-25 18:20:26'),
(14, 1, 1, 4, 14, 'null', 177, 207, 'v1', 'activo', '2026-03-25 18:20:26', '2026-03-25 18:20:26'),
(15, 1, 1, 4, 15, 'null', 178, 280, 'v2', 'activo', '2026-03-25 18:20:26', '2026-03-25 18:20:26'),
(16, 1, 1, 4, 16, 'null', 175, 356, 'v3', 'activo', '2026-03-25 18:20:26', '2026-03-25 18:20:26'),
(17, 1, 1, 4, 17, 'null', 293, 475, 'v4', 'activo', '2026-03-25 18:20:26', '2026-03-25 18:20:26'),
(18, 1, 1, 4, 18, 'null', 428, 476, 'v5', 'activo', '2026-03-25 18:20:26', '2026-03-25 18:20:26'),
(19, 1, 1, 4, 19, 'null', 519, 145, 'v6', 'activo', '2026-03-25 18:20:26', '2026-03-25 18:20:26'),
(20, 1, 1, 4, 20, 'null', 615, 147, 'v7', 'activo', '2026-03-25 18:20:26', '2026-03-25 18:20:26'),
(21, 1, 1, 5, 21, 'null', 896, 347, 'p1', 'activo', '2026-03-25 18:20:26', '2026-03-25 18:20:26'),
(22, 1, 1, 5, 22, 'null', 896, 397, 'p2', 'activo', '2026-03-25 18:20:26', '2026-03-25 18:20:26'),
(23, 1, 1, 5, 23, 'null', 895, 440, 'p3', 'activo', '2026-03-25 18:20:26', '2026-03-25 18:20:26'),
(24, 1, 1, 5, 24, 'null', 870, 486, 'p4', 'activo', '2026-03-25 18:20:26', '2026-03-25 18:20:26'),
(25, 1, 1, 5, 25, 'null', 729, 483, 'p5', 'activo', '2026-03-25 18:20:26', '2026-03-25 18:20:26'),
(46, 2, 2, 1, 1, NULL, 258, 147, 'g1', 'activo', '2026-03-25 18:30:21', '2026-03-25 18:30:21'),
(47, 2, 2, 1, 2, NULL, 261, 295, 'g2', 'activo', '2026-03-25 18:30:21', '2026-03-25 18:30:21'),
(48, 2, 2, 1, 3, NULL, 261, 441, 'g3', 'activo', '2026-03-25 18:30:21', '2026-03-25 18:30:21'),
(49, 2, 2, 1, 4, NULL, 325, 521, 'g4', 'activo', '2026-03-25 18:30:21', '2026-03-25 18:30:21'),
(50, 2, 2, 1, 5, NULL, 566, 293, 'g5', 'activo', '2026-03-25 18:30:21', '2026-03-25 18:30:21'),
(51, 2, 2, 2, 6, NULL, 452, 168, 'i1', 'activo', '2026-03-25 18:30:21', '2026-03-25 18:30:21'),
(52, 2, 2, 2, 7, NULL, 497, 506, 'i2', 'activo', '2026-03-25 18:30:21', '2026-03-25 18:30:21'),
(53, 2, 2, 3, 8, NULL, 709, 185, 'c1', 'activo', '2026-03-25 18:30:21', '2026-03-25 18:30:21'),
(54, 2, 2, 3, 9, NULL, 689, 299, 'c2', 'activo', '2026-03-25 18:30:21', '2026-03-25 18:30:21'),
(55, 2, 2, 3, 10, NULL, 728, 391, 'c3', 'activo', '2026-03-25 18:30:21', '2026-03-25 18:30:21'),
(56, 2, 2, 3, 11, NULL, 675, 513, 'c4', 'activo', '2026-03-25 18:30:21', '2026-03-25 18:30:21'),
(57, 2, 2, 3, 12, NULL, 479, 345, 'c5', 'activo', '2026-03-25 18:30:21', '2026-03-25 18:30:21'),
(58, 2, 2, 4, 13, NULL, 338, 226, 'v1', 'activo', '2026-03-25 18:30:21', '2026-03-25 18:30:21'),
(59, 2, 2, 4, 14, NULL, 361, 413, 'v2', 'activo', '2026-03-25 18:30:21', '2026-03-25 18:30:21'),
(60, 2, 2, 4, 15, NULL, 476, 227, 'v3', 'activo', '2026-03-25 18:30:21', '2026-03-25 18:30:21'),
(61, 2, 2, 4, 16, NULL, 441, 439, 'v4', 'activo', '2026-03-25 18:30:21', '2026-03-25 18:30:21'),
(62, 2, 2, 5, 17, NULL, 616, 165, 'p1', 'activo', '2026-03-25 18:30:21', '2026-03-25 18:30:21'),
(63, 2, 2, 5, 18, NULL, 629, 239, 'p2', 'activo', '2026-03-25 18:30:21', '2026-03-25 18:30:21'),
(64, 2, 2, 5, 19, NULL, 569, 418, 'p3', 'activo', '2026-03-25 18:30:21', '2026-03-25 18:30:21'),
(65, 2, 2, 5, 20, NULL, 707, 445, 'p4', 'activo', '2026-03-25 18:30:22', '2026-03-25 18:30:22'),
(66, 2, 3, 1, 1, 'null', 40, 39, 'g1', 'activo', '2026-03-25 18:32:50', '2026-03-25 18:32:50'),
(67, 2, 3, 1, 2, 'null', 392, 40, 'g3', 'activo', '2026-03-25 18:32:50', '2026-03-25 18:32:50'),
(68, 2, 3, 1, 3, 'null', 186, 133, 'g2', 'activo', '2026-03-25 18:32:50', '2026-03-25 18:32:50'),
(69, 2, 3, 1, 4, 'null', 43, 318, 'g4', 'activo', '2026-03-25 18:32:50', '2026-03-25 18:32:50'),
(70, 2, 3, 1, 5, 'null', 459, 186, 'g5', 'activo', '2026-03-25 18:32:50', '2026-03-25 18:32:50'),
(71, 2, 3, 2, 6, 'null', 940, 344, 'i1', 'activo', '2026-03-25 18:32:50', '2026-03-25 18:32:50'),
(72, 2, 3, 2, 7, 'null', 285, 484, 'i2', 'activo', '2026-03-25 18:32:50', '2026-03-25 18:32:50'),
(73, 2, 3, 3, 8, 'null', 934, 45, 'c1', 'activo', '2026-03-25 18:32:50', '2026-03-25 18:32:50'),
(74, 2, 3, 3, 9, 'null', 798, 195, 'c2', 'activo', '2026-03-25 18:32:50', '2026-03-25 18:32:50'),
(75, 2, 3, 3, 10, 'null', 519, 430, 'c3', 'activo', '2026-03-25 18:32:50', '2026-03-25 18:32:50'),
(76, 2, 3, 3, 11, 'null', 885, 432, 'c4', 'activo', '2026-03-25 18:32:50', '2026-03-25 18:32:50'),
(77, 2, 3, 4, 12, 'null', 356, 647, 'v1', 'activo', '2026-03-25 18:32:50', '2026-03-25 18:32:50'),
(78, 2, 3, 4, 13, 'null', 537, 581, 'v2', 'activo', '2026-03-25 18:32:50', '2026-03-25 18:32:50'),
(79, 2, 3, 4, 14, 'null', 756, 572, 'v3', 'activo', '2026-03-25 18:32:50', '2026-03-25 18:32:50'),
(80, 2, 3, 4, 15, 'null', 918, 617, 'v4', 'activo', '2026-03-25 18:32:50', '2026-03-25 18:32:50'),
(81, 2, 3, 5, 16, 'null', 94, 463, 'p1', 'activo', '2026-03-25 18:32:50', '2026-03-25 18:32:50'),
(82, 2, 3, 5, 17, 'null', 661, 115, 'p2', 'activo', '2026-03-25 18:32:50', '2026-03-25 18:32:50'),
(83, 2, 3, 5, 18, 'null', 372, 305, 'p3', 'activo', '2026-03-25 18:32:50', '2026-03-25 18:32:50'),
(84, 2, 3, 5, 19, 'null', 214, 433, 'p4', 'activo', '2026-03-25 18:32:50', '2026-03-25 18:32:50'),
(85, 2, 3, 5, 20, 'null', 215, 598, 'p5', 'activo', '2026-03-25 18:32:50', '2026-03-25 18:32:50'),
(86, 3, 4, 1, 1, 'null', 42, 370, 'g1', 'activo', '2026-03-25 19:11:34', '2026-03-25 19:11:34'),
(87, 3, 4, 1, 2, 'null', 153, 369, 'g2', 'activo', '2026-03-25 19:11:34', '2026-03-25 19:11:34'),
(88, 3, 4, 1, 3, 'null', 300, 364, 'g3', 'activo', '2026-03-25 19:11:34', '2026-03-25 19:11:34'),
(89, 3, 4, 1, 4, 'null', 534, 184, 'g4', 'activo', '2026-03-25 19:11:34', '2026-03-25 19:11:34'),
(90, 3, 4, 1, 5, 'null', 533, 290, 'g5', 'activo', '2026-03-25 19:11:34', '2026-03-25 19:11:34'),
(91, 3, 4, 2, 6, 'null', 308, 634, 'i1', 'activo', '2026-03-25 19:11:34', '2026-03-25 19:11:34'),
(92, 3, 4, 2, 7, 'null', 673, 650, 'i2', 'activo', '2026-03-25 19:11:34', '2026-03-25 19:11:34'),
(93, 3, 4, 3, 8, 'null', 113, 525, 'c1', 'activo', '2026-03-25 19:11:34', '2026-03-25 19:11:34'),
(94, 3, 4, 3, 9, 'null', 378, 476, 'c2', 'activo', '2026-03-25 19:11:34', '2026-03-25 19:11:34'),
(95, 3, 4, 3, 10, 'null', 619, 434, 'c3', 'activo', '2026-03-25 19:11:34', '2026-03-25 19:11:34'),
(96, 3, 4, 3, 11, 'null', 806, 378, 'c4', 'activo', '2026-03-25 19:11:34', '2026-03-25 19:11:34'),
(97, 3, 4, 3, 12, 'null', 866, 159, 'c5', 'activo', '2026-03-25 19:11:34', '2026-03-25 19:11:34'),
(98, 3, 4, 4, 13, 'null', 191, 452, 'v1', 'activo', '2026-03-25 19:11:34', '2026-03-25 19:11:34'),
(99, 3, 4, 4, 14, 'null', 750, 474, 'v2', 'activo', '2026-03-25 19:11:34', '2026-03-25 19:11:34'),
(100, 3, 4, 4, 15, 'null', 848, 634, 'v3', 'activo', '2026-03-25 19:11:34', '2026-03-25 19:11:34'),
(101, 3, 4, 4, 16, 'null', 717, 117, 'v4', 'activo', '2026-03-25 19:11:34', '2026-03-25 19:11:34'),
(102, 3, 4, 5, 17, 'null', 914, 255, 'p1', 'activo', '2026-03-25 19:11:34', '2026-03-25 19:11:34'),
(103, 3, 4, 5, 18, 'null', 913, 439, 'p2', 'activo', '2026-03-25 19:11:34', '2026-03-25 19:11:34'),
(104, 3, 4, 5, 19, 'null', 409, 603, 'p3', 'activo', '2026-03-25 19:11:34', '2026-03-25 19:11:34');

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
(1, 'golpe', '/images/trampas/trampa_raton.jpg', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(2, 'insecto', '/images/trampas/trampa_insecto.jpg', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(3, 'caja', '/images/trampas/caja_negra.jpg', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(4, 'viva', '/images/trampas/captura_viva.jpg', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(5, 'pegajosa', '/images/trampas/pegajosa.png', '2026-03-25 14:13:55', '2026-03-25 14:13:55');

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
(1, 'Gramos', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(2, 'C.C.', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(3, 'Unidad', '2026-03-25 14:13:55', '2026-03-25 14:13:55'),
(4, 'Litros', '2026-03-25 14:13:55', '2026-03-25 14:13:55');

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
(1, 'Luis Isla', 'islaluis25@gmail.com', NULL, '$2y$12$XRW.dIjR4XaEhLqVBsati.Y/rECX24v/VXRd0vVYMFulUDL8PW2ky', NULL, NULL, NULL, NULL, '2026-03-25 14:14:43', '2026-03-25 14:14:43'),
(2, 'admin', 'admin@admin.com', NULL, '$2y$12$Piirz72qTh7HTQnkY4BnC.wSD38Z7TrHuL2BtKtrNfIzARfeIzCuO', NULL, NULL, NULL, NULL, '2026-03-25 14:15:18', '2026-03-25 14:15:18');

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `almacen_areas`
--
ALTER TABLE `almacen_areas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `almacen_trampas`
--
ALTER TABLE `almacen_trampas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `almancen_insectocutores`
--
ALTER TABLE `almancen_insectocutores`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `aplicaciones`
--
ALTER TABLE `aplicaciones`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `contrato_detalles`
--
ALTER TABLE `contrato_detalles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;

--
-- AUTO_INCREMENT de la tabla `cuentas_cobrar`
--
ALTER TABLE `cuentas_cobrar`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `producto_usos`
--
ALTER TABLE `producto_usos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `seguimiento_biologicos`
--
ALTER TABLE `seguimiento_biologicos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `seguimiento_epps`
--
ALTER TABLE `seguimiento_epps`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `seguimiento_protecciones`
--
ALTER TABLE `seguimiento_protecciones`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=105;

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
