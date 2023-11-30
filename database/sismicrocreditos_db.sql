-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 30-11-2023 a las 21:33:57
-- Versión del servidor: 8.0.30
-- Versión de PHP: 7.4.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `sismicrocreditos_db`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cajas`
--

CREATE TABLE `cajas` (
  `id` bigint UNSIGNED NOT NULL,
  `caja` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `saldo` decimal(24,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `cajas`
--

INSERT INTO `cajas` (`id`, `caja`, `saldo`, `created_at`, `updated_at`) VALUES
(1, 'Pago por Cuotas', 27405.42, NULL, '2023-11-30 19:16:34'),
(2, 'Gastos Administrativos', 280.00, NULL, '2023-11-30 21:30:04'),
(3, 'Cargos por Multa', 0.00, NULL, '2023-11-30 21:30:04'),
(4, 'Intereses', 216.68, NULL, '2023-11-30 19:16:34');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `caja_movimientos`
--

CREATE TABLE `caja_movimientos` (
  `id` bigint UNSIGNED NOT NULL,
  `caja_id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `monto` decimal(24,2) NOT NULL,
  `tipo` enum('CRÉDITO','DEBITO') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `glosa` enum('GASTOS ADMINISTRATIVOS','DESEMBOLSO','PAGO CUOTA PRESTAMO','INTERES','PAGO MORA','ABONO CAPITAL') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo_prestamo` varchar(155) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `prestamo_id` bigint UNSIGNED DEFAULT NULL,
  `grupo_id` bigint UNSIGNED DEFAULT NULL,
  `fecha_registro` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `caja_movimientos`
--

INSERT INTO `caja_movimientos` (`id`, `caja_id`, `user_id`, `monto`, `tipo`, `glosa`, `tipo_prestamo`, `prestamo_id`, `grupo_id`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 10000.00, 'CRÉDITO', 'ABONO CAPITAL', NULL, NULL, NULL, '2023-11-30', '2023-11-30 16:57:05', '2023-11-30 16:57:05'),
(2, 1, 1, 4000.00, 'DEBITO', 'DESEMBOLSO', 'INDIVIDUAL', 1, NULL, '2023-11-30', '2023-11-30 16:58:24', '2023-11-30 16:58:24'),
(3, 2, 1, 80.00, 'CRÉDITO', 'GASTOS ADMINISTRATIVOS', 'INDIVIDUAL', 1, NULL, '2023-11-30', '2023-11-30 16:58:24', '2023-11-30 16:58:24'),
(4, 1, 1, 311.47, 'CRÉDITO', 'PAGO CUOTA PRESTAMO', 'GRUPAL', 1, NULL, '2023-11-30', '2023-11-30 18:08:59', '2023-11-30 18:08:59'),
(5, 4, 1, 49.00, 'CRÉDITO', 'INTERES', 'GRUPAL', 1, NULL, '2023-11-30', '2023-11-30 18:08:59', '2023-11-30 18:08:59'),
(6, 1, 1, 315.28, 'CRÉDITO', 'PAGO CUOTA PRESTAMO', 'GRUPAL', 1, NULL, '2023-11-30', '2023-11-30 18:23:42', '2023-11-30 18:23:42'),
(7, 4, 1, 45.18, 'CRÉDITO', 'INTERES', 'GRUPAL', 1, NULL, '2023-11-30', '2023-11-30 18:23:42', '2023-11-30 18:23:42'),
(8, 1, 1, 30000.00, 'CRÉDITO', 'ABONO CAPITAL', NULL, NULL, NULL, '2023-11-30', '2023-11-30 19:10:12', '2023-11-30 19:10:12'),
(9, 1, 1, 10000.00, 'DEBITO', 'DESEMBOLSO', 'GRUPAL', NULL, 1, '2023-11-30', '2023-11-30 19:10:23', '2023-11-30 19:10:23'),
(10, 2, 1, 200.00, 'CRÉDITO', 'GASTOS ADMINISTRATIVOS', 'GRUPAL', NULL, 1, '2023-11-30', '2023-11-30 19:10:23', '2023-11-30 19:10:23'),
(11, 1, 1, 778.67, 'CRÉDITO', 'PAGO CUOTA PRESTAMO', 'GRUPAL', NULL, 1, '2023-11-30', '2023-11-30 19:16:34', '2023-11-30 19:16:34'),
(12, 4, 1, 122.50, 'CRÉDITO', 'INTERES', 'GRUPAL', NULL, 1, '2023-11-30', '2023-11-30 19:16:34', '2023-11-30 19:16:34');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(155) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `segundo_nombre` varchar(155) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paterno` varchar(155) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `materno` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dir` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ci` varchar(155) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ci_exp` varchar(155) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `cel` varchar(155) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `fono` varchar(155) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `edad` int NOT NULL,
  `referencia` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `cel_ref` varchar(155) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `parentesco` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_registro` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`id`, `nombre`, `segundo_nombre`, `paterno`, `materno`, `dir`, `ci`, `ci_exp`, `cel`, `fono`, `edad`, `referencia`, `cel_ref`, `parentesco`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(1, 'LUIS', 'ALBERTO', 'GONZALES', '', 'LOS OLIVOS', '1111', 'LP', '666666', '', 26, 'MARIO GONZALES', '666666', 'HERMANO', '2023-11-22', '2023-11-22 16:58:18', '2023-11-22 16:58:18'),
(3, 'JUAN', 'LUIS', 'CONDORI', 'CONDORI', 'LOS OLIVOS', '2222', 'LP', '777777', '222222', 26, 'EDUARDO CONDORI', '6666666', 'PADRE', '2023-11-23', '2023-11-23 13:05:08', '2023-11-23 13:05:08'),
(7, 'RUTH', '', 'MAMANI', 'MAMANI', 'LOS OLIVOS', '3333', 'LP', '777777', '222222', 26, 'JAVIER MAMANI', '66666', 'HERMANO', '2023-11-27', '2023-11-27 21:59:45', '2023-11-27 21:59:45'),
(8, 'LOURDES', '', 'CHOQUE', 'MAMANI', 'LOS OLIVOS', '4444', 'LP', '666666', '', 28, 'JOSE CHOQUE', '66666', 'PADRE', '2023-11-27', '2023-11-27 21:59:45', '2023-11-27 21:59:45'),
(9, 'RAMIRO', 'EDUARDO', 'GONZALES', 'GONZALES', 'LOS OLIVOS', '5555', 'SC', '65656565', '222222', 35, 'JUAN GONZALES', '76767676', 'HERMANO', '2023-11-30', '2023-11-30 20:22:16', '2023-11-30 20:22:16');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `configuracions`
--

CREATE TABLE `configuracions` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre_sistema` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `alias` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `razon_social` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `dir` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nit` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fono` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `actividad` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `correo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `configuracions`
--

INSERT INTO `configuracions` (`id`, `nombre_sistema`, `alias`, `razon_social`, `dir`, `nit`, `fono`, `actividad`, `correo`, `logo`, `created_at`, `updated_at`) VALUES
(1, 'SISMICROCREDITOS', 'SISMICROCREDITOS', 'SISMICROCREDITOS', 'LOS OLIVOS', '11111111', '7777777', 'ACTIVIDAD', 'sismicrocreditos@gmail.com', '1700500875_logo.png', NULL, '2023-11-20 17:21:15');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `desembolsos`
--

CREATE TABLE `desembolsos` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `tipo_prestamo` varchar(155) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `prestamo_id` bigint UNSIGNED DEFAULT NULL,
  `grupo_id` bigint UNSIGNED DEFAULT NULL,
  `monto` decimal(24,2) NOT NULL,
  `cancelado` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_registro` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `desembolsos`
--

INSERT INTO `desembolsos` (`id`, `user_id`, `tipo_prestamo`, `prestamo_id`, `grupo_id`, `monto`, `cancelado`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(1, 1, 'INDIVIDUAL', 1, NULL, 80.00, 'SI', '2023-11-30', '2023-11-30 16:58:24', '2023-11-30 16:58:24'),
(2, 1, 'GRUPAL', NULL, 1, 200.00, 'SI', '2023-11-30', '2023-11-30 19:10:23', '2023-11-30 19:10:23');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `grupos`
--

CREATE TABLE `grupos` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `user_desembolso_id` bigint UNSIGNED DEFAULT NULL,
  `user_aprobado_id` bigint UNSIGNED DEFAULT NULL,
  `nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `integrantes` int NOT NULL,
  `monto` decimal(24,2) NOT NULL,
  `plazo` int NOT NULL,
  `desembolso` int NOT NULL DEFAULT '0',
  `fecha_desembolso` date DEFAULT NULL,
  `estado` varchar(155) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `finalizado` int NOT NULL DEFAULT '0',
  `fecha_registro` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `grupos`
--

INSERT INTO `grupos` (`id`, `user_id`, `user_desembolso_id`, `user_aprobado_id`, `nombre`, `integrantes`, `monto`, `plazo`, `desembolso`, `fecha_desembolso`, `estado`, `finalizado`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 'GRUPO UNO', 2, 10000.00, 12, 1, '2023-11-30', 'APROBADO', 0, '2023-11-30', '2023-11-30 18:29:35', '2023-11-30 19:10:23'),
(2, 1, NULL, 1, 'GRUPO DOS', 2, 5000.00, 12, 0, '2023-11-30', 'APROBADO', 0, '2023-11-30', '2023-11-30 20:17:51', '2023-11-30 20:18:38'),
(3, 1, NULL, 1, 'GRUPO TRES', 3, 6000.00, 12, 0, '2023-12-04', 'APROBADO', 0, '2023-11-30', '2023-11-30 20:22:16', '2023-11-30 20:22:58');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `grupo_plan_pagos`
--

CREATE TABLE `grupo_plan_pagos` (
  `id` bigint UNSIGNED NOT NULL,
  `grupo_id` bigint UNSIGNED NOT NULL,
  `nro_cuota` int NOT NULL,
  `saldo_inicial` decimal(24,2) NOT NULL,
  `capital` decimal(24,2) NOT NULL,
  `interes` decimal(24,2) NOT NULL,
  `saldo` decimal(24,2) NOT NULL,
  `cuota` decimal(24,2) NOT NULL,
  `cancelado` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_pago` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `grupo_plan_pagos`
--

INSERT INTO `grupo_plan_pagos` (`id`, `grupo_id`, `nro_cuota`, `saldo_inicial`, `capital`, `interes`, `saldo`, `cuota`, `cancelado`, `fecha_pago`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 10000.00, 778.67, 122.50, 9221.33, 901.17, 'SI', '2023-12-07', '2023-11-30 18:29:35', '2023-11-30 19:16:34'),
(2, 1, 2, 9221.33, 788.20, 112.96, 8433.12, 901.17, 'NO', '2023-12-14', '2023-11-30 18:29:35', '2023-11-30 18:39:24'),
(3, 1, 3, 8433.13, 797.86, 103.31, 7635.27, 901.17, 'NO', '2023-12-21', '2023-11-30 18:29:35', '2023-11-30 18:39:24'),
(4, 1, 4, 7635.27, 807.63, 93.53, 6827.64, 901.17, 'NO', '2023-12-28', '2023-11-30 18:29:35', '2023-11-30 18:39:24'),
(5, 1, 5, 6827.64, 817.53, 83.64, 6010.11, 901.17, 'NO', '2024-01-04', '2023-11-30 18:29:35', '2023-11-30 18:39:24'),
(6, 1, 6, 6010.11, 827.54, 73.62, 5182.57, 901.17, 'NO', '2024-01-11', '2023-11-30 18:29:35', '2023-11-30 18:39:24'),
(7, 1, 7, 5182.57, 837.68, 63.49, 4344.88, 901.17, 'NO', '2024-01-18', '2023-11-30 18:29:35', '2023-11-30 18:39:24'),
(8, 1, 8, 4344.89, 847.94, 53.22, 3496.94, 901.17, 'NO', '2024-01-25', '2023-11-30 18:29:35', '2023-11-30 18:39:24'),
(9, 1, 9, 3496.95, 858.33, 42.84, 2638.61, 901.17, 'NO', '2024-02-01', '2023-11-30 18:29:35', '2023-11-30 18:39:24'),
(10, 1, 10, 2638.62, 868.84, 32.32, 1769.77, 901.17, 'NO', '2024-02-08', '2023-11-30 18:29:35', '2023-11-30 18:39:24'),
(11, 1, 11, 1769.78, 879.49, 21.68, 890.28, 901.17, 'NO', '2024-02-15', '2023-11-30 18:29:35', '2023-11-30 18:39:24'),
(12, 1, 12, 890.29, 890.29, 10.91, 0.00, 901.17, 'NO', '2024-02-22', '2023-11-30 18:29:35', '2023-11-30 18:39:24'),
(13, 2, 1, 5000.00, 389.33, 61.25, 4610.67, 450.58, 'NO', '2023-12-18', '2023-11-30 20:17:51', '2023-11-30 20:18:38'),
(14, 2, 2, 4610.67, 394.09, 56.48, 4216.58, 450.58, 'NO', '2023-12-25', '2023-11-30 20:17:51', '2023-11-30 20:18:38'),
(15, 2, 3, 4216.58, 398.92, 51.65, 3817.66, 450.58, 'NO', '2024-01-01', '2023-11-30 20:17:51', '2023-11-30 20:18:38'),
(16, 2, 4, 3817.66, 403.81, 46.77, 3413.85, 450.58, 'NO', '2024-01-08', '2023-11-30 20:17:51', '2023-11-30 20:18:38'),
(17, 2, 5, 3413.85, 408.76, 41.82, 3005.09, 450.58, 'NO', '2024-01-15', '2023-11-30 20:17:51', '2023-11-30 20:18:38'),
(18, 2, 6, 3005.09, 413.76, 36.81, 2591.33, 450.58, 'NO', '2024-01-22', '2023-11-30 20:17:51', '2023-11-30 20:18:38'),
(19, 2, 7, 2591.33, 418.83, 31.74, 2172.50, 450.58, 'NO', '2024-01-29', '2023-11-30 20:17:51', '2023-11-30 20:18:38'),
(20, 2, 8, 2172.50, 423.96, 26.61, 1748.54, 450.58, 'NO', '2024-02-05', '2023-11-30 20:17:51', '2023-11-30 20:18:38'),
(21, 2, 9, 1748.54, 429.16, 21.42, 1319.38, 450.58, 'NO', '2024-02-12', '2023-11-30 20:17:51', '2023-11-30 20:18:38'),
(22, 2, 10, 1319.38, 434.41, 16.16, 884.96, 450.58, 'NO', '2024-02-19', '2023-11-30 20:17:51', '2023-11-30 20:18:38'),
(23, 2, 11, 884.97, 439.73, 10.84, 445.23, 450.58, 'NO', '2024-02-26', '2023-11-30 20:17:51', '2023-11-30 20:18:38'),
(24, 2, 12, 445.24, 445.24, 5.45, 0.00, 450.58, 'NO', '2024-03-04', '2023-11-30 20:17:51', '2023-11-30 20:18:38'),
(25, 3, 1, 6000.00, 467.20, 73.50, 5532.80, 540.70, 'NO', '2023-12-11', '2023-11-30 20:22:16', '2023-11-30 20:22:58'),
(26, 3, 2, 5532.80, 472.92, 67.78, 5059.88, 540.70, 'NO', '2023-12-18', '2023-11-30 20:22:16', '2023-11-30 20:22:58'),
(27, 3, 3, 5059.88, 478.71, 61.98, 4581.17, 540.70, 'NO', '2023-12-25', '2023-11-30 20:22:16', '2023-11-30 20:22:58'),
(28, 3, 4, 4581.17, 484.58, 56.12, 4096.59, 540.70, 'NO', '2024-01-01', '2023-11-30 20:22:16', '2023-11-30 20:22:58'),
(29, 3, 5, 4096.59, 490.51, 50.18, 3606.08, 540.70, 'NO', '2024-01-08', '2023-11-30 20:22:16', '2023-11-30 20:22:58'),
(30, 3, 6, 3606.08, 496.52, 44.17, 3109.56, 540.70, 'NO', '2024-01-15', '2023-11-30 20:22:16', '2023-11-30 20:22:58'),
(31, 3, 7, 3109.56, 502.60, 38.09, 2606.96, 540.70, 'NO', '2024-01-22', '2023-11-30 20:22:16', '2023-11-30 20:22:58'),
(32, 3, 8, 2606.96, 508.76, 31.94, 2098.19, 540.70, 'NO', '2024-01-29', '2023-11-30 20:22:16', '2023-11-30 20:22:58'),
(33, 3, 9, 2098.20, 514.99, 25.70, 1583.20, 540.70, 'NO', '2024-02-05', '2023-11-30 20:22:16', '2023-11-30 20:22:58'),
(34, 3, 10, 1583.21, 521.30, 19.39, 1061.90, 540.70, 'NO', '2024-02-12', '2023-11-30 20:22:16', '2023-11-30 20:22:58'),
(35, 3, 11, 1061.91, 527.69, 13.01, 534.21, 540.70, 'NO', '2024-02-19', '2023-11-30 20:22:16', '2023-11-30 20:22:58'),
(36, 3, 12, 534.22, 534.22, 6.54, 0.00, 540.70, 'NO', '2024-02-26', '2023-11-30 20:22:16', '2023-11-30 20:22:58');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_accions`
--

CREATE TABLE `historial_accions` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `accion` varchar(155) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `datos_original` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `datos_nuevo` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `modulo` varchar(155) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `historial_accions`
--

INSERT INTO `historial_accions` (`id`, `user_id`, `accion`, `descripcion`, `datos_original`, `datos_nuevo`, `modulo`, `fecha`, `hora`, `created_at`, `updated_at`) VALUES
(1, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN MOVIMINETO DE CAJA', 'caja_id: 1<br/>created_at: 2023-11-30 12:57:05<br/>fecha_registro: 2023-11-30<br/>glosa: ABONO CAPITAL<br/>grupo_id: <br/>id: 1<br/>monto: 10000<br/>prestamo_id: <br/>tipo: CRÉDITO<br/>tipo_prestamo: <br/>updated_at: 2023-11-30 12:57:05<br/>user_id: 1<br/>', NULL, 'CAJA', '2023-11-30', '12:57:05', '2023-11-30 16:57:05', '2023-11-30 16:57:05'),
(2, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PRESTAMO', 'cliente_id: 1<br/>created_at: 2023-11-30 12:57:31<br/>croquis: 1<br/>desembolso: <br/>documento_1: <br/>documento_2: <br/>documento_3: <br/>documento_4: <br/>estado: PRE APROBADO<br/>f_agua: 1<br/>f_ci: 1<br/>f_luz: 1<br/>fecha_desembolso: <br/>fecha_registro: 2023-11-30<br/>finalizado: <br/>grupo_id: <br/>id: 1<br/>monto: 4000<br/>plazo: 12<br/>tipo: INDIVIDUAL<br/>updated_at: 2023-11-30 12:57:31<br/>user_desembolso_id: <br/>user_id: 1<br/>', NULL, 'PRESTAMOS', '2023-11-30', '12:57:31', '2023-11-30 16:57:31', '2023-11-30 16:57:31'),
(3, 1, 'MODIFICACIÓN', 'EL USUARIO admin APROBO UN PRÉSTAMO', 'cliente_id: 1<br/>created_at: 2023-11-30 12:57:31<br/>croquis: 1<br/>desembolso: 0<br/>documento_1: <br/>documento_2: <br/>documento_3: <br/>documento_4: <br/>estado: PRE APROBADO<br/>f_agua: 1<br/>f_ci: 1<br/>f_luz: 1<br/>fecha_desembolso: <br/>fecha_registro: 2023-11-30<br/>finalizado: 0<br/>grupo_id: <br/>id: 1<br/>monto: 4000.00<br/>plazo: 12<br/>tipo: INDIVIDUAL<br/>updated_at: 2023-11-30 12:57:31<br/>user_desembolso_id: <br/>user_id: 1<br/>', 'cliente_id: 1<br/>created_at: 2023-11-30 12:57:31<br/>croquis: 1<br/>desembolso: 0<br/>documento_1: <br/>documento_2: <br/>documento_3: <br/>documento_4: <br/>estado: APROBADO<br/>f_agua: 1<br/>f_ci: 1<br/>f_luz: 1<br/>fecha_desembolso: 2023-11-30<br/>fecha_registro: 2023-11-30<br/>finalizado: 0<br/>grupo_id: <br/>id: 1<br/>monto: 4000.00<br/>plazo: 12<br/>tipo: INDIVIDUAL<br/>updated_at: 2023-11-30 12:57:41<br/>user_desembolso_id: <br/>user_id: 1<br/>', 'PRESTAMOS', '2023-11-30', '12:57:41', '2023-11-30 16:57:41', '2023-11-30 16:57:41'),
(4, 1, 'MODIFICACIÓN', 'EL USUARIO admin REALIZÓ EL DESEMBOLSO DE UN PRESTAMO', 'cliente_id: 1<br/>created_at: 2023-11-30 12:57:31<br/>croquis: 1<br/>desembolso: 0<br/>documento_1: <br/>documento_2: <br/>documento_3: <br/>documento_4: <br/>estado: APROBADO<br/>f_agua: 1<br/>f_ci: 1<br/>f_luz: 1<br/>fecha_desembolso: 2023-11-30<br/>fecha_registro: 2023-11-30<br/>finalizado: 0<br/>grupo_id: <br/>id: 1<br/>monto: 4000.00<br/>plazo: 12<br/>tipo: INDIVIDUAL<br/>updated_at: 2023-11-30 12:57:41<br/>user_desembolso_id: <br/>user_id: 1<br/>', 'cliente_id: 1<br/>created_at: 2023-11-30 12:57:31<br/>croquis: 1<br/>desembolso: 1<br/>documento_1: <br/>documento_2: <br/>documento_3: <br/>documento_4: <br/>estado: APROBADO<br/>f_agua: 1<br/>f_ci: 1<br/>f_luz: 1<br/>fecha_desembolso: 2023-11-30<br/>fecha_registro: 2023-11-30<br/>finalizado: 0<br/>grupo_id: <br/>id: 1<br/>monto: 4000.00<br/>plazo: 12<br/>tipo: INDIVIDUAL<br/>updated_at: 2023-11-30 12:58:24<br/>user_desembolso_id: 1<br/>user_id: 1<br/>', 'PRESTAMOS', '2023-11-30', '12:58:24', '2023-11-30 16:58:24', '2023-11-30 16:58:24'),
(5, 1, 'MODIFICACIÓN', 'EL USUARIO admin REGISTRO EL PAGO DE UN PRESTAMO', 'cliente_id: 1<br/>created_at: 2023-11-30 14:08:59<br/>dias_mora: -7<br/>fecha_pago: 2023-11-30<br/>grupo_id: <br/>grupo_plan_pago_id: <br/>id: 1<br/>interes: 49.00<br/>monto: 311.47<br/>monto_mora: 0<br/>monto_total: 360.47<br/>nro_cuota: 1<br/>plan_pago_id: 1<br/>prestamo_id: 1<br/>tipo_prestamo: INDIVIDUAL<br/>updated_at: 2023-11-30 14:08:59<br/>user_id: 1<br/>', NULL, 'PAGOS', '2023-11-30', '14:09:00', '2023-11-30 18:09:00', '2023-11-30 18:09:00'),
(6, 1, 'MODIFICACIÓN', 'EL USUARIO admin REGISTRO EL PAGO DE UN PRESTAMO', 'cliente_id: 1<br/>created_at: 2023-11-30 14:23:42<br/>dias_mora: -14<br/>fecha_pago: 2023-11-30<br/>grupo_id: <br/>grupo_plan_pago_id: <br/>id: 2<br/>interes: 45.18<br/>monto: 315.28<br/>monto_mora: 0<br/>monto_total: 360.46<br/>nro_cuota: 2<br/>plan_pago_id: 2<br/>prestamo_id: 1<br/>tipo_prestamo: INDIVIDUAL<br/>updated_at: 2023-11-30 14:23:42<br/>user_id: 1<br/>', NULL, 'PAGOS', '2023-11-30', '14:23:42', '2023-11-30 18:23:42', '2023-11-30 18:23:42'),
(7, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PRESTAMO', 'cliente_id: 7<br/>created_at: 2023-11-30 14:29:35<br/>croquis: 1<br/>desembolso: <br/>documento_1: <br/>documento_2: <br/>documento_3: <br/>documento_4: <br/>estado: PRE APROBADO<br/>f_agua: 1<br/>f_ci: 1<br/>f_luz: 1<br/>fecha_desembolso: <br/>fecha_registro: 2023-11-30<br/>finalizado: <br/>grupo_id: 1<br/>id: 2<br/>monto: 6000<br/>plazo: 12<br/>tipo: GRUPAL<br/>updated_at: 2023-11-30 14:29:35<br/>user_desembolso_id: <br/>user_id: 1<br/>', NULL, 'PRESTAMOS', '2023-11-30', '14:29:35', '2023-11-30 18:29:35', '2023-11-30 18:29:35'),
(8, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PRESTAMO', 'cliente_id: 8<br/>created_at: 2023-11-30 14:29:35<br/>croquis: 1<br/>desembolso: <br/>documento_1: <br/>documento_2: <br/>documento_3: <br/>documento_4: <br/>estado: PRE APROBADO<br/>f_agua: 1<br/>f_ci: 1<br/>f_luz: 1<br/>fecha_desembolso: <br/>fecha_registro: 2023-11-30<br/>finalizado: <br/>grupo_id: 1<br/>id: 3<br/>monto: 4000<br/>plazo: 12<br/>tipo: GRUPAL<br/>updated_at: 2023-11-30 14:29:35<br/>user_desembolso_id: <br/>user_id: 1<br/>', NULL, 'PRESTAMOS', '2023-11-30', '14:29:35', '2023-11-30 18:29:35', '2023-11-30 18:29:35'),
(9, 1, 'MODIFICACIÓN', 'EL USUARIO admin APROBO UN PRÉSTAMO GRUPAL', 'created_at: 2023-11-30 14:29:35<br/>desembolso: 0<br/>estado: PRE APROBADO<br/>fecha_desembolso: <br/>fecha_registro: <br/>id: 1<br/>integrantes: 2<br/>monto: 10000.00<br/>nombre: GRUPO UNO<br/>plazo: 12<br/>updated_at: 2023-11-30 14:29:35<br/>user_aprobado_id: 0<br/>user_desembolso_id: <br/>user_id: 1<br/>', 'created_at: 2023-11-30 14:29:35<br/>desembolso: 0<br/>estado: APROBADO<br/>fecha_desembolso: 2023-11-30<br/>fecha_registro: <br/>id: 1<br/>integrantes: 2<br/>monto: 10000.00<br/>nombre: GRUPO UNO<br/>plazo: 12<br/>updated_at: 2023-11-30 14:39:24<br/>user_aprobado_id: 1<br/>user_desembolso_id: <br/>user_id: 1<br/>', 'PRESTAMOS', '2023-11-30', '14:39:24', '2023-11-30 18:39:24', '2023-11-30 18:39:24'),
(10, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN MOVIMINETO DE CAJA', 'caja_id: 1<br/>created_at: 2023-11-30 15:10:12<br/>fecha_registro: 2023-11-30<br/>glosa: ABONO CAPITAL<br/>grupo_id: <br/>id: 8<br/>monto: 30000<br/>prestamo_id: <br/>tipo: CRÉDITO<br/>tipo_prestamo: <br/>updated_at: 2023-11-30 15:10:12<br/>user_id: 1<br/>', NULL, 'CAJA', '2023-11-30', '15:10:12', '2023-11-30 19:10:12', '2023-11-30 19:10:12'),
(11, 1, 'MODIFICACIÓN', 'EL USUARIO admin REALIZÓ EL DESEMBOLSO DE UN PRESTAMO GRUPAL', 'created_at: 2023-11-30 14:29:35<br/>desembolso: 0<br/>estado: APROBADO<br/>fecha_desembolso: 2023-11-30<br/>fecha_registro: <br/>id: 1<br/>integrantes: 2<br/>monto: 10000.00<br/>nombre: GRUPO UNO<br/>plazo: 12<br/>updated_at: 2023-11-30 14:39:24<br/>user_aprobado_id: 1<br/>user_desembolso_id: <br/>user_id: 1<br/>', 'created_at: 2023-11-30 14:29:35<br/>desembolso: 1<br/>estado: APROBADO<br/>fecha_desembolso: 2023-11-30<br/>fecha_registro: <br/>id: 1<br/>integrantes: 2<br/>monto: 10000.00<br/>nombre: GRUPO UNO<br/>plazo: 12<br/>updated_at: 2023-11-30 15:10:23<br/>user_aprobado_id: 1<br/>user_desembolso_id: 1<br/>user_id: 1<br/>', 'PRESTAMOS', '2023-11-30', '15:10:23', '2023-11-30 19:10:23', '2023-11-30 19:10:23'),
(12, 1, 'MODIFICACIÓN', 'EL USUARIO admin REGISTRO EL PAGO DE UN PRESTAMO GRUPAL', 'cliente_id: <br/>created_at: 2023-11-30 15:16:34<br/>dias_mora: -7<br/>fecha_pago: 2023-11-30<br/>grupo_id: 1<br/>grupo_plan_pago_id: 1<br/>id: 3<br/>interes: 122.50<br/>monto: 778.67<br/>monto_mora: 0<br/>monto_total: 901.17<br/>nro_cuota: 1<br/>plan_pago_id: <br/>prestamo_id: <br/>tipo_prestamo: GRUPAL<br/>updated_at: 2023-11-30 15:16:34<br/>user_id: 1<br/>', NULL, 'PAGOS', '2023-11-30', '15:16:34', '2023-11-30 19:16:34', '2023-11-30 19:16:34'),
(13, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PRESTAMO', 'cliente_id: 7<br/>created_at: 2023-11-30 16:08:34<br/>croquis: 1<br/>desembolso: <br/>documento_1: documento vehiculo<br/>documento_2: <br/>documento_3: <br/>documento_4: <br/>estado: PRE APROBADO<br/>f_agua: 1<br/>f_ci: 1<br/>f_luz: 1<br/>fecha_desembolso: <br/>fecha_registro: 2023-11-30<br/>finalizado: <br/>grupo_id: <br/>id: 4<br/>monto: 3000<br/>plazo: 12<br/>tipo: INDIVIDUAL<br/>updated_at: 2023-11-30 16:08:34<br/>user_aprobado_id: <br/>user_desembolso_id: <br/>user_id: 1<br/>', NULL, 'PRESTAMOS', '2023-11-30', '16:08:34', '2023-11-30 20:08:34', '2023-11-30 20:08:34'),
(14, 1, 'MODIFICACIÓN', 'EL USUARIO admin APROBO UN PRÉSTAMO', 'cliente_id: 7<br/>created_at: 2023-11-30 16:08:34<br/>croquis: 1<br/>desembolso: 0<br/>documento_1: documento vehiculo<br/>documento_2: <br/>documento_3: <br/>documento_4: <br/>estado: PRE APROBADO<br/>f_agua: 1<br/>f_ci: 1<br/>f_luz: 1<br/>fecha_desembolso: <br/>fecha_registro: 2023-11-30<br/>finalizado: 0<br/>grupo_id: <br/>id: 4<br/>monto: 3000.00<br/>plazo: 12<br/>tipo: INDIVIDUAL<br/>updated_at: 2023-11-30 16:08:34<br/>user_aprobado_id: <br/>user_desembolso_id: <br/>user_id: 1<br/>', 'cliente_id: 7<br/>created_at: 2023-11-30 16:08:34<br/>croquis: 1<br/>desembolso: 0<br/>documento_1: documento vehiculo<br/>documento_2: <br/>documento_3: <br/>documento_4: <br/>estado: APROBADO<br/>f_agua: 1<br/>f_ci: 1<br/>f_luz: 1<br/>fecha_desembolso: 2023-12-04<br/>fecha_registro: 2023-11-30<br/>finalizado: 0<br/>grupo_id: <br/>id: 4<br/>monto: 3000.00<br/>plazo: 12<br/>tipo: INDIVIDUAL<br/>updated_at: 2023-11-30 16:08:52<br/>user_aprobado_id: 1<br/>user_desembolso_id: <br/>user_id: 1<br/>', 'PRESTAMOS', '2023-11-30', '16:08:52', '2023-11-30 20:08:52', '2023-11-30 20:08:52'),
(15, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PRESTAMO', 'cliente_id: 3<br/>created_at: 2023-11-30 16:17:51<br/>croquis: 1<br/>desembolso: <br/>documento_1: <br/>documento_2: <br/>documento_3: <br/>documento_4: <br/>estado: PRE APROBADO<br/>f_agua: 1<br/>f_ci: 1<br/>f_luz: 1<br/>fecha_desembolso: <br/>fecha_registro: 2023-11-30<br/>finalizado: <br/>grupo_id: 2<br/>id: 5<br/>monto: 2500.00<br/>plazo: 12<br/>tipo: GRUPAL<br/>updated_at: 2023-11-30 16:17:51<br/>user_aprobado_id: <br/>user_desembolso_id: <br/>user_id: 1<br/>', NULL, 'PRESTAMOS', '2023-11-30', '16:17:51', '2023-11-30 20:17:51', '2023-11-30 20:17:51'),
(16, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PRESTAMO', 'cliente_id: 7<br/>created_at: 2023-11-30 16:17:51<br/>croquis: 1<br/>desembolso: <br/>documento_1: <br/>documento_2: <br/>documento_3: <br/>documento_4: <br/>estado: PRE APROBADO<br/>f_agua: 1<br/>f_ci: 1<br/>f_luz: 1<br/>fecha_desembolso: <br/>fecha_registro: 2023-11-30<br/>finalizado: <br/>grupo_id: 2<br/>id: 6<br/>monto: 2500.00<br/>plazo: 12<br/>tipo: GRUPAL<br/>updated_at: 2023-11-30 16:17:51<br/>user_aprobado_id: <br/>user_desembolso_id: <br/>user_id: 1<br/>', NULL, 'PRESTAMOS', '2023-11-30', '16:17:51', '2023-11-30 20:17:51', '2023-11-30 20:17:51'),
(17, 1, 'MODIFICACIÓN', 'EL USUARIO admin APROBO UN PRÉSTAMO GRUPAL', 'created_at: 2023-11-30 16:17:51<br/>desembolso: 0<br/>estado: PRE APROBADO<br/>fecha_desembolso: <br/>fecha_registro: 2023-11-30<br/>id: 2<br/>integrantes: 2<br/>monto: 5000.00<br/>nombre: GRUPO DOS<br/>plazo: 12<br/>updated_at: 2023-11-30 16:17:51<br/>user_aprobado_id: <br/>user_desembolso_id: <br/>user_id: 1<br/>', 'created_at: 2023-11-30 16:17:51<br/>desembolso: 0<br/>estado: APROBADO<br/>fecha_desembolso: 2023-12-11<br/>fecha_registro: 2023-11-30<br/>id: 2<br/>integrantes: 2<br/>monto: 5000.00<br/>nombre: GRUPO DOS<br/>plazo: 12<br/>updated_at: 2023-11-30 16:18:38<br/>user_aprobado_id: 1<br/>user_desembolso_id: <br/>user_id: 1<br/>', 'PRESTAMOS', '2023-11-30', '16:18:38', '2023-11-30 20:18:38', '2023-11-30 20:18:38'),
(18, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PRESTAMO', 'cliente_id: 9<br/>created_at: 2023-11-30 16:22:16<br/>croquis: 1<br/>desembolso: <br/>documento_1: <br/>documento_2: <br/>documento_3: <br/>documento_4: <br/>estado: PRE APROBADO<br/>f_agua: 1<br/>f_ci: 1<br/>f_luz: 1<br/>fecha_desembolso: <br/>fecha_registro: 2023-11-30<br/>finalizado: <br/>grupo_id: 3<br/>id: 7<br/>monto: 2000.00<br/>plazo: 12<br/>tipo: GRUPAL<br/>updated_at: 2023-11-30 16:22:16<br/>user_aprobado_id: <br/>user_desembolso_id: <br/>user_id: 1<br/>', NULL, 'PRESTAMOS', '2023-11-30', '16:22:16', '2023-11-30 20:22:16', '2023-11-30 20:22:16'),
(19, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PRESTAMO', 'cliente_id: 1<br/>created_at: 2023-11-30 16:22:16<br/>croquis: 1<br/>desembolso: <br/>documento_1: <br/>documento_2: <br/>documento_3: <br/>documento_4: <br/>estado: PRE APROBADO<br/>f_agua: 1<br/>f_ci: 1<br/>f_luz: 1<br/>fecha_desembolso: <br/>fecha_registro: 2023-11-30<br/>finalizado: <br/>grupo_id: 3<br/>id: 8<br/>monto: 2000.00<br/>plazo: 12<br/>tipo: GRUPAL<br/>updated_at: 2023-11-30 16:22:16<br/>user_aprobado_id: <br/>user_desembolso_id: <br/>user_id: 1<br/>', NULL, 'PRESTAMOS', '2023-11-30', '16:22:16', '2023-11-30 20:22:16', '2023-11-30 20:22:16'),
(20, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PRESTAMO', 'cliente_id: 3<br/>created_at: 2023-11-30 16:22:16<br/>croquis: 1<br/>desembolso: <br/>documento_1: <br/>documento_2: <br/>documento_3: <br/>documento_4: <br/>estado: PRE APROBADO<br/>f_agua: 1<br/>f_ci: 1<br/>f_luz: 1<br/>fecha_desembolso: <br/>fecha_registro: 2023-11-30<br/>finalizado: <br/>grupo_id: 3<br/>id: 9<br/>monto: 2000.00<br/>plazo: 12<br/>tipo: GRUPAL<br/>updated_at: 2023-11-30 16:22:16<br/>user_aprobado_id: <br/>user_desembolso_id: <br/>user_id: 1<br/>', NULL, 'PRESTAMOS', '2023-11-30', '16:22:16', '2023-11-30 20:22:16', '2023-11-30 20:22:16'),
(21, 1, 'MODIFICACIÓN', 'EL USUARIO admin APROBO UN PRÉSTAMO GRUPAL', 'created_at: 2023-11-30 16:22:16<br/>desembolso: 0<br/>estado: PRE APROBADO<br/>fecha_desembolso: <br/>fecha_registro: 2023-11-30<br/>id: 3<br/>integrantes: 3<br/>monto: 6000.00<br/>nombre: GRUPO TRES<br/>plazo: 12<br/>updated_at: 2023-11-30 16:22:16<br/>user_aprobado_id: <br/>user_desembolso_id: <br/>user_id: 1<br/>', 'created_at: 2023-11-30 16:22:16<br/>desembolso: 0<br/>estado: APROBADO<br/>fecha_desembolso: 2023-12-04<br/>fecha_registro: 2023-11-30<br/>id: 3<br/>integrantes: 3<br/>monto: 6000.00<br/>nombre: GRUPO TRES<br/>plazo: 12<br/>updated_at: 2023-11-30 16:22:58<br/>user_aprobado_id: 1<br/>user_desembolso_id: <br/>user_id: 1<br/>', 'PRESTAMOS', '2023-11-30', '16:22:58', '2023-11-30 20:22:58', '2023-11-30 20:22:58'),
(22, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN USUARIO', 'acceso: 1<br/>ci: 3333<br/>ci_exp: CH<br/>created_at: 2023-11-30 17:24:19<br/>fecha_registro: 2023-11-30<br/>foto: <br/>id: 4<br/>materno: CORTEZ<br/>nombre: JUAN<br/>password: $2y$10$Gin5D4asPWJFPJzvn9H56u6wy9YF3R5qqBMiOUqPGSfBshPnv3kG2<br/>paterno: CORTEZ<br/>tipo: GERENTE<br/>updated_at: 2023-11-30 17:24:19<br/>usuario: JCORTEZ<br/>', NULL, 'USUARIOS', '2023-11-30', '17:24:19', '2023-11-30 21:24:19', '2023-11-30 21:24:19');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `interes`
--

CREATE TABLE `interes` (
  `id` bigint UNSIGNED NOT NULL,
  `interes` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `interes`
--

INSERT INTO `interes` (`id`, `interes`, `created_at`, `updated_at`) VALUES
(1, 4.9, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000002_create_users_table', 1),
(2, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(3, '2022_10_13_132625_create_configuracions_table', 1),
(4, '2023_08_26_190801_create_historial_accions_table', 1),
(5, '2023_11_21_142832_create_clientes_table', 2),
(6, '2023_11_21_143120_create_grupos_table', 2),
(7, '2023_11_21_143201_create_prestamos_table', 2),
(8, '2023_11_21_143214_create_plan_pagos_table', 2),
(9, '2023_11_21_143240_create_pagos_table', 2),
(10, '2023_11_21_143306_create_cajas_table', 2),
(11, '2023_11_21_143314_create_caja_movimientos_table', 2),
(12, '2023_11_22_233737_create_interes_table', 3),
(15, '2023_11_27_175039_create_grupo_plan_pagos_table', 4),
(17, '2023_11_30_115539_create_desembolsos_table', 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pagos`
--

CREATE TABLE `pagos` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `tipo_prestamo` varchar(155) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `prestamo_id` bigint UNSIGNED DEFAULT NULL,
  `plan_pago_id` bigint UNSIGNED DEFAULT NULL,
  `grupo_id` bigint UNSIGNED DEFAULT NULL,
  `grupo_plan_pago_id` bigint UNSIGNED DEFAULT NULL,
  `cliente_id` bigint UNSIGNED DEFAULT NULL,
  `nro_cuota` int NOT NULL,
  `monto` decimal(24,2) NOT NULL,
  `interes` decimal(24,2) NOT NULL,
  `dias_mora` int NOT NULL,
  `monto_mora` decimal(24,2) DEFAULT NULL,
  `monto_total` decimal(24,2) NOT NULL,
  `fecha_pago` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `pagos`
--

INSERT INTO `pagos` (`id`, `user_id`, `tipo_prestamo`, `prestamo_id`, `plan_pago_id`, `grupo_id`, `grupo_plan_pago_id`, `cliente_id`, `nro_cuota`, `monto`, `interes`, `dias_mora`, `monto_mora`, `monto_total`, `fecha_pago`, `created_at`, `updated_at`) VALUES
(1, 1, 'INDIVIDUAL', 1, 1, NULL, NULL, 1, 1, 311.47, 49.00, -7, 0.00, 360.47, '2023-11-30', '2023-11-30 18:08:59', '2023-11-30 18:08:59'),
(2, 1, 'INDIVIDUAL', 1, 2, NULL, NULL, 1, 2, 315.28, 45.18, -14, 0.00, 360.46, '2023-11-30', '2023-11-30 18:23:42', '2023-11-30 18:23:42'),
(3, 1, 'GRUPAL', NULL, NULL, 1, 1, NULL, 1, 778.67, 122.50, -7, 0.00, 901.17, '2023-11-30', '2023-11-30 19:16:34', '2023-11-30 19:16:34');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `plan_pagos`
--

CREATE TABLE `plan_pagos` (
  `id` bigint UNSIGNED NOT NULL,
  `prestamo_id` bigint UNSIGNED NOT NULL,
  `nro_cuota` int NOT NULL,
  `saldo_inicial` decimal(24,2) NOT NULL,
  `capital` decimal(24,2) NOT NULL,
  `interes` decimal(24,2) NOT NULL,
  `saldo` decimal(24,2) NOT NULL,
  `cuota` decimal(24,2) NOT NULL,
  `cancelado` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_pago` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `plan_pagos`
--

INSERT INTO `plan_pagos` (`id`, `prestamo_id`, `nro_cuota`, `saldo_inicial`, `capital`, `interes`, `saldo`, `cuota`, `cancelado`, `fecha_pago`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 4000.00, 311.47, 49.00, 3688.53, 360.47, 'SI', '2023-12-07', '2023-11-30 16:57:31', '2023-11-30 18:09:00'),
(2, 1, 2, 3688.53, 315.28, 45.18, 3373.25, 360.47, 'SI', '2023-12-14', '2023-11-30 16:57:31', '2023-11-30 18:23:42'),
(3, 1, 3, 3373.25, 319.14, 41.32, 3054.11, 360.47, 'NO', '2023-12-21', '2023-11-30 16:57:31', '2023-11-30 16:57:41'),
(4, 1, 4, 3054.11, 323.05, 37.41, 2731.06, 360.47, 'NO', '2023-12-28', '2023-11-30 16:57:31', '2023-11-30 16:57:41'),
(5, 1, 5, 2731.06, 327.01, 33.46, 2404.05, 360.47, 'NO', '2024-01-04', '2023-11-30 16:57:31', '2023-11-30 16:57:41'),
(6, 1, 6, 2404.05, 331.02, 29.45, 2073.03, 360.47, 'NO', '2024-01-11', '2023-11-30 16:57:31', '2023-11-30 16:57:41'),
(7, 1, 7, 2073.03, 335.07, 25.39, 1737.96, 360.47, 'NO', '2024-01-18', '2023-11-30 16:57:31', '2023-11-30 16:57:41'),
(8, 1, 8, 1737.96, 339.17, 21.29, 1398.79, 360.47, 'NO', '2024-01-25', '2023-11-30 16:57:31', '2023-11-30 16:57:41'),
(9, 1, 9, 1398.79, 343.33, 17.14, 1055.46, 360.47, 'NO', '2024-02-01', '2023-11-30 16:57:31', '2023-11-30 16:57:41'),
(10, 1, 10, 1055.46, 347.54, 12.93, 707.92, 360.47, 'NO', '2024-02-08', '2023-11-30 16:57:31', '2023-11-30 16:57:41'),
(11, 1, 11, 707.92, 351.79, 8.67, 356.13, 360.47, 'NO', '2024-02-15', '2023-11-30 16:57:31', '2023-11-30 16:57:41'),
(12, 1, 12, 356.13, 356.13, 4.36, 0.00, 360.47, 'NO', '2024-02-22', '2023-11-30 16:57:31', '2023-11-30 16:57:41'),
(13, 2, 1, 6000.00, 467.20, 73.50, 5532.80, 540.70, 'SI', '2023-12-07', '2023-11-30 18:29:35', '2023-11-30 19:16:34'),
(14, 2, 2, 5532.80, 472.92, 67.78, 5059.88, 540.70, 'NO', '2023-12-14', '2023-11-30 18:29:35', '2023-11-30 18:39:24'),
(15, 2, 3, 5059.88, 478.71, 61.98, 4581.17, 540.70, 'NO', '2023-12-21', '2023-11-30 18:29:35', '2023-11-30 18:39:24'),
(16, 2, 4, 4581.17, 484.58, 56.12, 4096.59, 540.70, 'NO', '2023-12-28', '2023-11-30 18:29:35', '2023-11-30 18:39:24'),
(17, 2, 5, 4096.59, 490.51, 50.18, 3606.08, 540.70, 'NO', '2024-01-04', '2023-11-30 18:29:35', '2023-11-30 18:39:24'),
(18, 2, 6, 3606.08, 496.52, 44.17, 3109.56, 540.70, 'NO', '2024-01-11', '2023-11-30 18:29:35', '2023-11-30 18:39:24'),
(19, 2, 7, 3109.56, 502.60, 38.09, 2606.96, 540.70, 'NO', '2024-01-18', '2023-11-30 18:29:35', '2023-11-30 18:39:24'),
(20, 2, 8, 2606.96, 508.76, 31.94, 2098.19, 540.70, 'NO', '2024-01-25', '2023-11-30 18:29:35', '2023-11-30 18:39:24'),
(21, 2, 9, 2098.20, 514.99, 25.70, 1583.20, 540.70, 'NO', '2024-02-01', '2023-11-30 18:29:35', '2023-11-30 18:39:24'),
(22, 2, 10, 1583.21, 521.30, 19.39, 1061.90, 540.70, 'NO', '2024-02-08', '2023-11-30 18:29:35', '2023-11-30 18:39:24'),
(23, 2, 11, 1061.91, 527.69, 13.01, 534.21, 540.70, 'NO', '2024-02-15', '2023-11-30 18:29:35', '2023-11-30 18:39:24'),
(24, 2, 12, 534.22, 534.22, 6.54, 0.00, 540.70, 'NO', '2024-02-22', '2023-11-30 18:29:35', '2023-11-30 18:39:24'),
(25, 3, 1, 4000.00, 311.47, 49.00, 3688.53, 360.47, 'SI', '2023-12-07', '2023-11-30 18:29:35', '2023-11-30 19:16:34'),
(26, 3, 2, 3688.53, 315.28, 45.18, 3373.25, 360.47, 'NO', '2023-12-14', '2023-11-30 18:29:35', '2023-11-30 18:39:24'),
(27, 3, 3, 3373.25, 319.14, 41.32, 3054.11, 360.47, 'NO', '2023-12-21', '2023-11-30 18:29:35', '2023-11-30 18:39:24'),
(28, 3, 4, 3054.11, 323.05, 37.41, 2731.06, 360.47, 'NO', '2023-12-28', '2023-11-30 18:29:35', '2023-11-30 18:39:24'),
(29, 3, 5, 2731.06, 327.01, 33.46, 2404.05, 360.47, 'NO', '2024-01-04', '2023-11-30 18:29:35', '2023-11-30 18:39:24'),
(30, 3, 6, 2404.05, 331.02, 29.45, 2073.03, 360.47, 'NO', '2024-01-11', '2023-11-30 18:29:35', '2023-11-30 18:39:24'),
(31, 3, 7, 2073.03, 335.07, 25.39, 1737.96, 360.47, 'NO', '2024-01-18', '2023-11-30 18:29:35', '2023-11-30 18:39:24'),
(32, 3, 8, 1737.96, 339.17, 21.29, 1398.79, 360.47, 'NO', '2024-01-25', '2023-11-30 18:29:35', '2023-11-30 18:39:24'),
(33, 3, 9, 1398.79, 343.33, 17.14, 1055.46, 360.47, 'NO', '2024-02-01', '2023-11-30 18:29:35', '2023-11-30 18:39:24'),
(34, 3, 10, 1055.46, 347.54, 12.93, 707.92, 360.47, 'NO', '2024-02-08', '2023-11-30 18:29:35', '2023-11-30 18:39:24'),
(35, 3, 11, 707.92, 351.79, 8.67, 356.13, 360.47, 'NO', '2024-02-15', '2023-11-30 18:29:35', '2023-11-30 18:39:24'),
(36, 3, 12, 356.13, 356.13, 4.36, 0.00, 360.47, 'NO', '2024-02-22', '2023-11-30 18:29:35', '2023-11-30 18:39:24'),
(37, 4, 1, 3000.00, 233.60, 36.75, 2766.40, 270.35, 'NO', '2023-12-11', '2023-11-30 20:08:34', '2023-11-30 20:08:52'),
(38, 4, 2, 2766.40, 236.46, 33.89, 2529.94, 270.35, 'NO', '2023-12-18', '2023-11-30 20:08:34', '2023-11-30 20:08:52'),
(39, 4, 3, 2529.94, 239.35, 30.99, 2290.59, 270.35, 'NO', '2023-12-25', '2023-11-30 20:08:34', '2023-11-30 20:08:52'),
(40, 4, 4, 2290.59, 242.29, 28.06, 2048.30, 270.35, 'NO', '2024-01-01', '2023-11-30 20:08:34', '2023-11-30 20:08:52'),
(41, 4, 5, 2048.30, 245.25, 25.09, 1803.05, 270.35, 'NO', '2024-01-08', '2023-11-30 20:08:34', '2023-11-30 20:08:52'),
(42, 4, 6, 1803.05, 248.26, 22.09, 1554.79, 270.35, 'NO', '2024-01-15', '2023-11-30 20:08:34', '2023-11-30 20:08:52'),
(43, 4, 7, 1554.79, 251.30, 19.05, 1303.49, 270.35, 'NO', '2024-01-22', '2023-11-30 20:08:34', '2023-11-30 20:08:52'),
(44, 4, 8, 1303.49, 254.38, 15.97, 1049.11, 270.35, 'NO', '2024-01-29', '2023-11-30 20:08:34', '2023-11-30 20:08:52'),
(45, 4, 9, 1049.11, 257.49, 12.85, 791.62, 270.35, 'NO', '2024-02-05', '2023-11-30 20:08:34', '2023-11-30 20:08:52'),
(46, 4, 10, 791.62, 260.65, 9.70, 530.97, 270.35, 'NO', '2024-02-12', '2023-11-30 20:08:34', '2023-11-30 20:08:52'),
(47, 4, 11, 530.97, 263.84, 6.50, 267.13, 270.35, 'NO', '2024-02-19', '2023-11-30 20:08:34', '2023-11-30 20:08:52'),
(48, 4, 12, 267.13, 267.13, 3.27, 0.00, 270.35, 'NO', '2024-02-26', '2023-11-30 20:08:34', '2023-11-30 20:08:52'),
(49, 5, 1, 2500.00, 194.66, 30.63, 2305.34, 225.29, 'NO', '2023-12-18', '2023-11-30 20:17:51', '2023-11-30 20:18:38'),
(50, 5, 2, 2305.34, 197.04, 28.24, 2108.30, 225.29, 'NO', '2023-12-25', '2023-11-30 20:17:51', '2023-11-30 20:18:38'),
(51, 5, 3, 2108.30, 199.46, 25.83, 1908.84, 225.29, 'NO', '2024-01-01', '2023-11-30 20:17:51', '2023-11-30 20:18:38'),
(52, 5, 4, 1908.84, 201.90, 23.38, 1706.94, 225.29, 'NO', '2024-01-08', '2023-11-30 20:17:51', '2023-11-30 20:18:38'),
(53, 5, 5, 1706.94, 204.37, 20.91, 1502.57, 225.29, 'NO', '2024-01-15', '2023-11-30 20:17:51', '2023-11-30 20:18:38'),
(54, 5, 6, 1502.57, 206.88, 18.41, 1295.69, 225.29, 'NO', '2024-01-22', '2023-11-30 20:17:51', '2023-11-30 20:18:38'),
(55, 5, 7, 1295.69, 209.41, 15.87, 1086.28, 225.29, 'NO', '2024-01-29', '2023-11-30 20:17:51', '2023-11-30 20:18:38'),
(56, 5, 8, 1086.28, 211.98, 13.31, 874.30, 225.29, 'NO', '2024-02-05', '2023-11-30 20:17:51', '2023-11-30 20:18:38'),
(57, 5, 9, 874.30, 214.57, 10.71, 659.73, 225.29, 'NO', '2024-02-12', '2023-11-30 20:17:51', '2023-11-30 20:18:38'),
(58, 5, 10, 659.73, 217.20, 8.08, 442.53, 225.29, 'NO', '2024-02-19', '2023-11-30 20:17:51', '2023-11-30 20:18:38'),
(59, 5, 11, 442.53, 219.86, 5.42, 222.67, 225.29, 'NO', '2024-02-26', '2023-11-30 20:17:51', '2023-11-30 20:18:38'),
(60, 5, 12, 222.67, 222.67, 2.73, 0.00, 225.29, 'NO', '2024-03-04', '2023-11-30 20:17:51', '2023-11-30 20:18:38'),
(61, 6, 1, 2500.00, 194.66, 30.63, 2305.34, 225.29, 'NO', '2023-12-18', '2023-11-30 20:17:51', '2023-11-30 20:18:38'),
(62, 6, 2, 2305.34, 197.04, 28.24, 2108.30, 225.29, 'NO', '2023-12-25', '2023-11-30 20:17:51', '2023-11-30 20:18:38'),
(63, 6, 3, 2108.30, 199.46, 25.83, 1908.84, 225.29, 'NO', '2024-01-01', '2023-11-30 20:17:51', '2023-11-30 20:18:38'),
(64, 6, 4, 1908.84, 201.90, 23.38, 1706.94, 225.29, 'NO', '2024-01-08', '2023-11-30 20:17:51', '2023-11-30 20:18:38'),
(65, 6, 5, 1706.94, 204.37, 20.91, 1502.57, 225.29, 'NO', '2024-01-15', '2023-11-30 20:17:51', '2023-11-30 20:18:38'),
(66, 6, 6, 1502.57, 206.88, 18.41, 1295.69, 225.29, 'NO', '2024-01-22', '2023-11-30 20:17:51', '2023-11-30 20:18:38'),
(67, 6, 7, 1295.69, 209.41, 15.87, 1086.28, 225.29, 'NO', '2024-01-29', '2023-11-30 20:17:51', '2023-11-30 20:18:38'),
(68, 6, 8, 1086.28, 211.98, 13.31, 874.30, 225.29, 'NO', '2024-02-05', '2023-11-30 20:17:51', '2023-11-30 20:18:38'),
(69, 6, 9, 874.30, 214.57, 10.71, 659.73, 225.29, 'NO', '2024-02-12', '2023-11-30 20:17:51', '2023-11-30 20:18:38'),
(70, 6, 10, 659.73, 217.20, 8.08, 442.53, 225.29, 'NO', '2024-02-19', '2023-11-30 20:17:51', '2023-11-30 20:18:38'),
(71, 6, 11, 442.53, 219.86, 5.42, 222.67, 225.29, 'NO', '2024-02-26', '2023-11-30 20:17:51', '2023-11-30 20:18:38'),
(72, 6, 12, 222.67, 222.67, 2.73, 0.00, 225.29, 'NO', '2024-03-04', '2023-11-30 20:17:51', '2023-11-30 20:18:38'),
(73, 7, 1, 2000.00, 155.72, 24.50, 1844.28, 180.23, 'NO', '2023-12-11', '2023-11-30 20:22:16', '2023-11-30 20:22:58'),
(74, 7, 2, 1844.28, 157.63, 22.59, 1686.65, 180.23, 'NO', '2023-12-18', '2023-11-30 20:22:16', '2023-11-30 20:22:58'),
(75, 7, 3, 1686.65, 159.56, 20.66, 1527.09, 180.23, 'NO', '2023-12-25', '2023-11-30 20:22:16', '2023-11-30 20:22:58'),
(76, 7, 4, 1527.09, 161.52, 18.71, 1365.57, 180.23, 'NO', '2024-01-01', '2023-11-30 20:22:16', '2023-11-30 20:22:58'),
(77, 7, 5, 1365.57, 163.50, 16.73, 1202.07, 180.23, 'NO', '2024-01-08', '2023-11-30 20:22:16', '2023-11-30 20:22:58'),
(78, 7, 6, 1202.07, 165.50, 14.73, 1036.57, 180.23, 'NO', '2024-01-15', '2023-11-30 20:22:16', '2023-11-30 20:22:58'),
(79, 7, 7, 1036.57, 167.53, 12.70, 869.04, 180.23, 'NO', '2024-01-22', '2023-11-30 20:22:16', '2023-11-30 20:22:58'),
(80, 7, 8, 869.04, 169.58, 10.65, 699.46, 180.23, 'NO', '2024-01-29', '2023-11-30 20:22:16', '2023-11-30 20:22:58'),
(81, 7, 9, 699.46, 171.66, 8.57, 527.80, 180.23, 'NO', '2024-02-05', '2023-11-30 20:22:16', '2023-11-30 20:22:58'),
(82, 7, 10, 527.80, 173.76, 6.47, 354.04, 180.23, 'NO', '2024-02-12', '2023-11-30 20:22:16', '2023-11-30 20:22:58'),
(83, 7, 11, 354.04, 175.89, 4.34, 178.15, 180.23, 'NO', '2024-02-19', '2023-11-30 20:22:16', '2023-11-30 20:22:58'),
(84, 7, 12, 178.15, 178.15, 2.18, 0.00, 180.23, 'NO', '2024-02-26', '2023-11-30 20:22:16', '2023-11-30 20:22:58'),
(85, 8, 1, 2000.00, 155.72, 24.50, 1844.28, 180.23, 'NO', '2023-12-11', '2023-11-30 20:22:16', '2023-11-30 20:22:58'),
(86, 8, 2, 1844.28, 157.63, 22.59, 1686.65, 180.23, 'NO', '2023-12-18', '2023-11-30 20:22:16', '2023-11-30 20:22:58'),
(87, 8, 3, 1686.65, 159.56, 20.66, 1527.09, 180.23, 'NO', '2023-12-25', '2023-11-30 20:22:16', '2023-11-30 20:22:58'),
(88, 8, 4, 1527.09, 161.52, 18.71, 1365.57, 180.23, 'NO', '2024-01-01', '2023-11-30 20:22:16', '2023-11-30 20:22:58'),
(89, 8, 5, 1365.57, 163.50, 16.73, 1202.07, 180.23, 'NO', '2024-01-08', '2023-11-30 20:22:16', '2023-11-30 20:22:58'),
(90, 8, 6, 1202.07, 165.50, 14.73, 1036.57, 180.23, 'NO', '2024-01-15', '2023-11-30 20:22:16', '2023-11-30 20:22:58'),
(91, 8, 7, 1036.57, 167.53, 12.70, 869.04, 180.23, 'NO', '2024-01-22', '2023-11-30 20:22:16', '2023-11-30 20:22:58'),
(92, 8, 8, 869.04, 169.58, 10.65, 699.46, 180.23, 'NO', '2024-01-29', '2023-11-30 20:22:16', '2023-11-30 20:22:58'),
(93, 8, 9, 699.46, 171.66, 8.57, 527.80, 180.23, 'NO', '2024-02-05', '2023-11-30 20:22:16', '2023-11-30 20:22:58'),
(94, 8, 10, 527.80, 173.76, 6.47, 354.04, 180.23, 'NO', '2024-02-12', '2023-11-30 20:22:16', '2023-11-30 20:22:58'),
(95, 8, 11, 354.04, 175.89, 4.34, 178.15, 180.23, 'NO', '2024-02-19', '2023-11-30 20:22:16', '2023-11-30 20:22:58'),
(96, 8, 12, 178.15, 178.15, 2.18, 0.00, 180.23, 'NO', '2024-02-26', '2023-11-30 20:22:16', '2023-11-30 20:22:58'),
(97, 9, 1, 2000.00, 155.72, 24.50, 1844.28, 180.23, 'NO', '2023-12-11', '2023-11-30 20:22:16', '2023-11-30 20:22:58'),
(98, 9, 2, 1844.28, 157.63, 22.59, 1686.65, 180.23, 'NO', '2023-12-18', '2023-11-30 20:22:16', '2023-11-30 20:22:58'),
(99, 9, 3, 1686.65, 159.56, 20.66, 1527.09, 180.23, 'NO', '2023-12-25', '2023-11-30 20:22:16', '2023-11-30 20:22:58'),
(100, 9, 4, 1527.09, 161.52, 18.71, 1365.57, 180.23, 'NO', '2024-01-01', '2023-11-30 20:22:16', '2023-11-30 20:22:58'),
(101, 9, 5, 1365.57, 163.50, 16.73, 1202.07, 180.23, 'NO', '2024-01-08', '2023-11-30 20:22:16', '2023-11-30 20:22:58'),
(102, 9, 6, 1202.07, 165.50, 14.73, 1036.57, 180.23, 'NO', '2024-01-15', '2023-11-30 20:22:16', '2023-11-30 20:22:58'),
(103, 9, 7, 1036.57, 167.53, 12.70, 869.04, 180.23, 'NO', '2024-01-22', '2023-11-30 20:22:16', '2023-11-30 20:22:58'),
(104, 9, 8, 869.04, 169.58, 10.65, 699.46, 180.23, 'NO', '2024-01-29', '2023-11-30 20:22:16', '2023-11-30 20:22:58'),
(105, 9, 9, 699.46, 171.66, 8.57, 527.80, 180.23, 'NO', '2024-02-05', '2023-11-30 20:22:16', '2023-11-30 20:22:58'),
(106, 9, 10, 527.80, 173.76, 6.47, 354.04, 180.23, 'NO', '2024-02-12', '2023-11-30 20:22:16', '2023-11-30 20:22:58'),
(107, 9, 11, 354.04, 175.89, 4.34, 178.15, 180.23, 'NO', '2024-02-19', '2023-11-30 20:22:16', '2023-11-30 20:22:58'),
(108, 9, 12, 178.15, 178.15, 2.18, 0.00, 180.23, 'NO', '2024-02-26', '2023-11-30 20:22:16', '2023-11-30 20:22:58');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `prestamos`
--

CREATE TABLE `prestamos` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `user_desembolso_id` bigint UNSIGNED DEFAULT NULL,
  `user_aprobado_id` bigint UNSIGNED DEFAULT NULL,
  `cliente_id` bigint UNSIGNED NOT NULL,
  `tipo` varchar(155) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `grupo_id` bigint UNSIGNED DEFAULT NULL,
  `monto` decimal(24,2) NOT NULL,
  `plazo` int NOT NULL DEFAULT '12',
  `f_ci` int NOT NULL,
  `f_luz` int NOT NULL,
  `f_agua` int NOT NULL,
  `croquis` int NOT NULL,
  `documento_1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `documento_2` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `documento_3` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `documento_4` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estado` varchar(155) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `desembolso` int NOT NULL DEFAULT '0',
  `finalizado` int NOT NULL DEFAULT '0',
  `fecha_desembolso` date DEFAULT NULL,
  `fecha_registro` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `prestamos`
--

INSERT INTO `prestamos` (`id`, `user_id`, `user_desembolso_id`, `user_aprobado_id`, `cliente_id`, `tipo`, `grupo_id`, `monto`, `plazo`, `f_ci`, `f_luz`, `f_agua`, `croquis`, `documento_1`, `documento_2`, `documento_3`, `documento_4`, `estado`, `desembolso`, `finalizado`, `fecha_desembolso`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 1, 'INDIVIDUAL', NULL, 4000.00, 12, 1, 1, 1, 1, NULL, NULL, NULL, NULL, 'APROBADO', 1, 0, '2023-11-30', '2023-11-30', '2023-11-30 16:57:31', '2023-11-30 16:58:24'),
(2, 1, 1, 1, 7, 'GRUPAL', 1, 6000.00, 12, 1, 1, 1, 1, NULL, NULL, NULL, NULL, 'APROBADO', 1, 0, '2023-11-30', '2023-11-30', '2023-11-30 18:29:35', '2023-11-30 18:39:24'),
(3, 1, 1, 1, 8, 'GRUPAL', 1, 4000.00, 12, 1, 1, 1, 1, NULL, NULL, NULL, NULL, 'APROBADO', 1, 0, '2023-11-30', '2023-11-30', '2023-11-30 18:29:35', '2023-11-30 18:39:24'),
(4, 1, NULL, 1, 7, 'INDIVIDUAL', NULL, 3000.00, 12, 1, 1, 1, 1, 'documento vehiculo', NULL, NULL, NULL, 'APROBADO', 0, 0, '2023-12-04', '2023-11-30', '2023-11-30 20:08:34', '2023-11-30 20:08:52'),
(5, 1, 1, 1, 3, 'GRUPAL', 2, 2500.00, 12, 1, 1, 1, 1, NULL, NULL, NULL, NULL, 'APROBADO', 1, 0, '2023-12-11', '2023-11-30', '2023-11-30 20:17:51', '2023-11-30 20:18:38'),
(6, 1, 1, 1, 7, 'GRUPAL', 2, 2500.00, 12, 1, 1, 1, 1, NULL, NULL, NULL, NULL, 'APROBADO', 1, 0, '2023-12-11', '2023-11-30', '2023-11-30 20:17:51', '2023-11-30 20:18:38'),
(7, 1, 1, 1, 9, 'GRUPAL', 3, 2000.00, 12, 1, 1, 1, 1, NULL, NULL, NULL, NULL, 'APROBADO', 1, 0, '2023-12-04', '2023-11-30', '2023-11-30 20:22:16', '2023-11-30 20:22:58'),
(8, 1, 1, 1, 1, 'GRUPAL', 3, 2000.00, 12, 1, 1, 1, 1, NULL, NULL, NULL, NULL, 'APROBADO', 1, 0, '2023-12-04', '2023-11-30', '2023-11-30 20:22:16', '2023-11-30 20:22:58'),
(9, 1, 1, 1, 3, 'GRUPAL', 3, 2000.00, 12, 1, 1, 1, 1, NULL, NULL, NULL, NULL, 'APROBADO', 1, 0, '2023-12-04', '2023-11-30', '2023-11-30 20:22:16', '2023-11-30 20:22:58');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `usuario` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `paterno` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `materno` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ci` varchar(155) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ci_exp` varchar(155) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tipo` enum('ADMINISTRADOR','GERENTE','CAJERO','OFICIAL DE CRÉDITO') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `foto` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `acceso` int NOT NULL,
  `fecha_registro` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `usuario`, `nombre`, `paterno`, `materno`, `ci`, `ci_exp`, `tipo`, `foto`, `password`, `acceso`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'admin', 'admin', NULL, '', NULL, 'ADMINISTRADOR', NULL, '$2y$10$wuTuUildBSgVYfvHomvXWuVLF6T1PWByEZJelnC9LOSQ/Xwcw2N3S', 1, '2023-11-20', NULL, NULL),
(2, 'JPERES', 'JUAN', 'PERES', 'MAMANI', '1234', 'CB', 'CAJERO', NULL, '$2y$10$.q1IOQLn2Zbg3xyQL7sSQ.Xf1HV5NNz6YGrKsSBsTziGm0sWqr9.S', 1, '2023-11-22', '2023-11-22 14:57:15', '2023-11-30 21:29:57'),
(3, 'NBURGOS', 'NORMA ROXANA', 'MAMANI', 'BURGOS', '4849549', 'LP', 'OFICIAL DE CRÉDITO', '1701184355_NBURGOS.jpg', '$2y$10$WsSoVwTbEbK64PcC8Q/7O.Zso4rlXLvViCZ6f2VmZt5opNgKOBUPe', 1, '2023-11-28', '2023-11-28 15:12:35', '2023-11-28 15:12:35'),
(4, 'JCORTEZ', 'JUAN', 'CORTEZ', 'CORTEZ', '3333', 'CH', 'GERENTE', NULL, '$2y$10$Gin5D4asPWJFPJzvn9H56u6wy9YF3R5qqBMiOUqPGSfBshPnv3kG2', 1, '2023-11-30', '2023-11-30 21:24:19', '2023-11-30 21:24:19');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cajas`
--
ALTER TABLE `cajas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `caja_movimientos`
--
ALTER TABLE `caja_movimientos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `configuracions`
--
ALTER TABLE `configuracions`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `desembolsos`
--
ALTER TABLE `desembolsos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `grupos`
--
ALTER TABLE `grupos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `grupos_nombre_unique` (`nombre`);

--
-- Indices de la tabla `grupo_plan_pagos`
--
ALTER TABLE `grupo_plan_pagos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `historial_accions`
--
ALTER TABLE `historial_accions`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `interes`
--
ALTER TABLE `interes`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `pagos`
--
ALTER TABLE `pagos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indices de la tabla `plan_pagos`
--
ALTER TABLE `plan_pagos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `prestamos`
--
ALTER TABLE `prestamos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `prestamos_user_id_foreign` (`user_id`),
  ADD KEY `prestamos_cliente_id_foreign` (`cliente_id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_usuario_unique` (`usuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `cajas`
--
ALTER TABLE `cajas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `caja_movimientos`
--
ALTER TABLE `caja_movimientos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `configuracions`
--
ALTER TABLE `configuracions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `desembolsos`
--
ALTER TABLE `desembolsos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `grupos`
--
ALTER TABLE `grupos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `grupo_plan_pagos`
--
ALTER TABLE `grupo_plan_pagos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT de la tabla `historial_accions`
--
ALTER TABLE `historial_accions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de la tabla `interes`
--
ALTER TABLE `interes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de la tabla `pagos`
--
ALTER TABLE `pagos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `plan_pagos`
--
ALTER TABLE `plan_pagos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=109;

--
-- AUTO_INCREMENT de la tabla `prestamos`
--
ALTER TABLE `prestamos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `prestamos`
--
ALTER TABLE `prestamos`
  ADD CONSTRAINT `prestamos_cliente_id_foreign` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`),
  ADD CONSTRAINT `prestamos_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
