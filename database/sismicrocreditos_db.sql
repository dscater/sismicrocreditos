-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 05-04-2024 a las 22:05:31
-- Versión del servidor: 8.0.30
-- Versión de PHP: 8.1.10

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
(1, 'Pago por Cuotas', 30000.00, NULL, '2024-04-05 21:47:09'),
(2, 'Gastos Administrativos', 100.00, NULL, '2024-04-05 21:47:09'),
(3, 'Cargos por Multa', 0.00, NULL, '2024-04-05 21:47:09'),
(4, 'Intereses', 814.00, NULL, '2024-04-05 21:47:09');

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
(1, 1, 1, 30000.00, 'CRÉDITO', 'ABONO CAPITAL', NULL, NULL, NULL, '2023-12-05', '2023-12-05 20:33:01', '2023-12-05 20:33:01'),
(2, 1, 1, 5000.00, 'DEBITO', 'DESEMBOLSO', 'INDIVIDUAL', 1, NULL, '2023-12-05', '2023-12-05 20:33:05', '2023-12-05 20:33:05'),
(3, 2, 1, 100.00, 'CRÉDITO', 'GASTOS ADMINISTRATIVOS', 'INDIVIDUAL', 1, NULL, '2023-12-05', '2023-12-05 20:33:05', '2023-12-05 20:33:05'),
(7, 1, 2, 5000.00, 'CRÉDITO', 'PAGO CUOTA PRESTAMO', 'INDIVIDUAL', 1, NULL, '2024-04-05', '2024-04-05 21:29:34', '2024-04-05 21:29:34'),
(8, 4, 2, 407.00, 'CRÉDITO', 'INTERES', 'INDIVIDUAL', 1, NULL, '2024-04-05', '2024-04-05 21:29:34', '2024-04-05 21:29:34'),
(9, 4, 2, 407.00, 'CRÉDITO', 'PAGO MORA', 'INDIVIDUAL', 1, NULL, '2024-04-05', '2024-04-05 21:29:34', '2024-04-05 21:29:34');

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
(1, 'FELIPE', '', 'MAMANI', 'MAMANI', 'LOS OLIVOS', '1111', 'LP', '77777777', '', 24, 'JUAN MAMANI', '66666666', 'HERMANO', '2023-12-05', '2023-12-05 20:32:13', '2024-04-03 18:52:37'),
(2, 'EDUARDO', '', 'MARTINEZ', 'MAMANI', 'LOS OLIVOS', '3434', 'LP', '77777777', '', 23, 'JUAN PERES', '66666666', 'HERMANO', '2024-04-03', '2024-04-03 18:52:21', '2024-04-03 18:52:21'),
(3, 'JUAN', '', 'CHOQUE', 'MAMANI', 'LOS OLIVOS', '5454', 'LP', '77777777', '', 34, 'PEDRO CHOQUE', '66666666', 'HERMANO', '2024-04-03', '2024-04-03 19:19:24', '2024-04-03 19:19:24'),
(4, 'MARIA', '', 'GONZALES', 'MAMANI', 'LOS OLIVOS', '6555', 'LP', '77667766', '', 24, 'JUAN MAMANI', '77667766', 'HERMANO', '2024-04-03', '2024-04-03 19:48:37', '2024-04-03 19:48:37'),
(5, 'JUAN', '', 'BAUTISTA', '', 'LOS OLIVOS', '8778', 'LP', '77667766', '', 31, 'EDUARDO BAUTISTA', '77667766', 'PADRE', '2024-04-03', '2024-04-03 19:48:37', '2024-04-03 19:48:37');

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
(1, 'SISMICROCREDITOS', 'SISMICROCREDITOS', 'SISMICROCREDITOS S.A.', 'LOS OLIVOS', '11111111', '7777777', 'ACTIVIDAD', 'sismicrocreditos@gmail.com', '1700500875_logo.png', NULL, '2024-04-05 20:01:55');

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
(1, 1, 'INDIVIDUAL', 1, NULL, 100.00, 'SI', '2023-12-05', '2023-12-05 20:33:05', '2023-12-05 20:33:05');

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
  `fecha_aprobado` date DEFAULT NULL,
  `fecha_rechazado` date DEFAULT NULL,
  `fecha_registro` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `grupos`
--

INSERT INTO `grupos` (`id`, `user_id`, `user_desembolso_id`, `user_aprobado_id`, `nombre`, `integrantes`, `monto`, `plazo`, `desembolso`, `fecha_desembolso`, `estado`, `finalizado`, `fecha_aprobado`, `fecha_rechazado`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, 1, 'GRUPO UNO', 2, 6000.00, 12, 0, '2024-04-05', 'APROBADO', 0, '2024-04-03', NULL, '2024-04-03', '2024-04-03 19:19:23', '2024-04-05 19:14:37'),
(2, 1, NULL, NULL, 'GRUPOS', 3, 5000.00, 12, 0, NULL, 'PRE APROBADO', 0, '2024-04-03', NULL, '2024-04-03', '2024-04-03 19:48:37', '2024-04-03 19:48:37');

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
(1, 1, 1, 6000.00, 467.20, 73.50, 5532.80, 540.70, 'NO', '2024-04-11', '2024-04-03 19:19:24', '2024-04-03 19:19:55'),
(2, 1, 2, 5532.80, 472.92, 67.78, 5059.88, 540.70, 'NO', '2024-04-18', '2024-04-03 19:19:24', '2024-04-03 19:19:56'),
(3, 1, 3, 5059.88, 478.71, 61.98, 4581.17, 540.70, 'NO', '2024-04-25', '2024-04-03 19:19:24', '2024-04-03 19:19:56'),
(4, 1, 4, 4581.17, 484.58, 56.12, 4096.59, 540.70, 'NO', '2024-05-02', '2024-04-03 19:19:24', '2024-04-03 19:19:56'),
(5, 1, 5, 4096.59, 490.51, 50.18, 3606.08, 540.70, 'NO', '2024-05-09', '2024-04-03 19:19:24', '2024-04-03 19:19:56'),
(6, 1, 6, 3606.08, 496.52, 44.17, 3109.56, 540.70, 'NO', '2024-05-16', '2024-04-03 19:19:24', '2024-04-03 19:19:56'),
(7, 1, 7, 3109.56, 502.60, 38.09, 2606.96, 540.70, 'NO', '2024-05-23', '2024-04-03 19:19:24', '2024-04-03 19:19:56'),
(8, 1, 8, 2606.96, 508.76, 31.94, 2098.19, 540.70, 'NO', '2024-05-30', '2024-04-03 19:19:24', '2024-04-03 19:19:56'),
(9, 1, 9, 2098.20, 514.99, 25.70, 1583.20, 540.70, 'NO', '2024-06-06', '2024-04-03 19:19:24', '2024-04-03 19:19:56'),
(10, 1, 10, 1583.21, 521.30, 19.39, 1061.90, 540.70, 'NO', '2024-06-13', '2024-04-03 19:19:24', '2024-04-03 19:19:56'),
(11, 1, 11, 1061.91, 527.69, 13.01, 534.21, 540.70, 'NO', '2024-06-20', '2024-04-03 19:19:24', '2024-04-03 19:19:56'),
(12, 1, 12, 534.22, 534.22, 6.54, 0.00, 540.70, 'NO', '2024-06-27', '2024-04-03 19:19:24', '2024-04-03 19:19:56'),
(13, 2, 1, 5000.00, 389.33, 61.25, 4610.67, 450.58, 'NO', NULL, '2024-04-03 19:48:37', '2024-04-03 19:48:37'),
(14, 2, 2, 4610.67, 394.09, 56.48, 4216.58, 450.58, 'NO', NULL, '2024-04-03 19:48:37', '2024-04-03 19:48:37'),
(15, 2, 3, 4216.58, 398.92, 51.65, 3817.66, 450.58, 'NO', NULL, '2024-04-03 19:48:37', '2024-04-03 19:48:37'),
(16, 2, 4, 3817.66, 403.81, 46.77, 3413.85, 450.58, 'NO', NULL, '2024-04-03 19:48:37', '2024-04-03 19:48:37'),
(17, 2, 5, 3413.85, 408.76, 41.82, 3005.09, 450.58, 'NO', NULL, '2024-04-03 19:48:37', '2024-04-03 19:48:37'),
(18, 2, 6, 3005.09, 413.76, 36.81, 2591.33, 450.58, 'NO', NULL, '2024-04-03 19:48:37', '2024-04-03 19:48:37'),
(19, 2, 7, 2591.33, 418.83, 31.74, 2172.50, 450.58, 'NO', NULL, '2024-04-03 19:48:37', '2024-04-03 19:48:37'),
(20, 2, 8, 2172.50, 423.96, 26.61, 1748.54, 450.58, 'NO', NULL, '2024-04-03 19:48:37', '2024-04-03 19:48:37'),
(21, 2, 9, 1748.54, 429.16, 21.42, 1319.38, 450.58, 'NO', NULL, '2024-04-03 19:48:37', '2024-04-03 19:48:37'),
(22, 2, 10, 1319.38, 434.41, 16.16, 884.96, 450.58, 'NO', NULL, '2024-04-03 19:48:37', '2024-04-03 19:48:37'),
(23, 2, 11, 884.97, 439.73, 10.84, 445.23, 450.58, 'NO', NULL, '2024-04-03 19:48:37', '2024-04-03 19:48:37'),
(24, 2, 12, 445.24, 445.24, 5.45, 0.00, 450.58, 'NO', NULL, '2024-04-03 19:48:37', '2024-04-03 19:48:37');

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
(1, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PRESTAMO', 'cliente_id: 1<br/>created_at: 2023-12-05 16:32:13<br/>croquis: 1<br/>desembolso: <br/>documento_1: <br/>documento_2: <br/>documento_3: <br/>documento_4: <br/>estado: PRE APROBADO<br/>f_agua: 1<br/>f_ci: 1<br/>f_luz: 1<br/>fecha_desembolso: <br/>fecha_registro: 2023-12-05<br/>finalizado: <br/>grupo_id: <br/>id: 1<br/>monto: 5000<br/>plazo: 12<br/>tipo: INDIVIDUAL<br/>updated_at: 2023-12-05 16:32:13<br/>user_aprobado_id: <br/>user_desembolso_id: <br/>user_id: 1<br/>', NULL, 'PRESTAMOS', '2023-12-05', '16:32:13', '2023-12-05 20:32:13', '2023-12-05 20:32:13'),
(2, 1, 'MODIFICACIÓN', 'EL USUARIO admin APROBO UN PRÉSTAMO', 'cliente_id: 1<br/>created_at: 2023-12-05 16:32:13<br/>croquis: 1<br/>desembolso: 0<br/>documento_1: <br/>documento_2: <br/>documento_3: <br/>documento_4: <br/>estado: PRE APROBADO<br/>f_agua: 1<br/>f_ci: 1<br/>f_luz: 1<br/>fecha_desembolso: <br/>fecha_registro: 2023-12-05<br/>finalizado: 0<br/>grupo_id: <br/>id: 1<br/>monto: 5000.00<br/>plazo: 12<br/>tipo: INDIVIDUAL<br/>updated_at: 2023-12-05 16:32:13<br/>user_aprobado_id: <br/>user_desembolso_id: <br/>user_id: 1<br/>', 'cliente_id: 1<br/>created_at: 2023-12-05 16:32:13<br/>croquis: 1<br/>desembolso: 0<br/>documento_1: <br/>documento_2: <br/>documento_3: <br/>documento_4: <br/>estado: APROBADO<br/>f_agua: 1<br/>f_ci: 1<br/>f_luz: 1<br/>fecha_desembolso: 2023-12-05<br/>fecha_registro: 2023-12-05<br/>finalizado: 0<br/>grupo_id: <br/>id: 1<br/>monto: 5000.00<br/>plazo: 12<br/>tipo: INDIVIDUAL<br/>updated_at: 2023-12-05 16:32:23<br/>user_aprobado_id: 1<br/>user_desembolso_id: <br/>user_id: 1<br/>', 'PRESTAMOS', '2023-12-05', '16:32:23', '2023-12-05 20:32:23', '2023-12-05 20:32:23'),
(3, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN MOVIMINETO DE CAJA', 'caja_id: 1<br/>created_at: 2023-12-05 16:33:01<br/>fecha_registro: 2023-12-05<br/>glosa: ABONO CAPITAL<br/>grupo_id: <br/>id: 1<br/>monto: 30000<br/>prestamo_id: <br/>tipo: CRÉDITO<br/>tipo_prestamo: <br/>updated_at: 2023-12-05 16:33:01<br/>user_id: 1<br/>', NULL, 'CAJA', '2023-12-05', '16:33:01', '2023-12-05 20:33:01', '2023-12-05 20:33:01'),
(4, 1, 'MODIFICACIÓN', 'EL USUARIO admin REALIZÓ EL DESEMBOLSO DE UN PRESTAMO', 'cliente_id: 1<br/>created_at: 2023-12-05 16:32:13<br/>croquis: 1<br/>desembolso: 0<br/>documento_1: <br/>documento_2: <br/>documento_3: <br/>documento_4: <br/>estado: APROBADO<br/>f_agua: 1<br/>f_ci: 1<br/>f_luz: 1<br/>fecha_desembolso: 2023-12-05<br/>fecha_registro: 2023-12-05<br/>finalizado: 0<br/>grupo_id: <br/>id: 1<br/>monto: 5000.00<br/>plazo: 12<br/>tipo: INDIVIDUAL<br/>updated_at: 2023-12-05 16:32:23<br/>user_aprobado_id: 1<br/>user_desembolso_id: <br/>user_id: 1<br/>', 'cliente_id: 1<br/>created_at: 2023-12-05 16:32:13<br/>croquis: 1<br/>desembolso: 1<br/>documento_1: <br/>documento_2: <br/>documento_3: <br/>documento_4: <br/>estado: APROBADO<br/>f_agua: 1<br/>f_ci: 1<br/>f_luz: 1<br/>fecha_desembolso: 2023-12-05<br/>fecha_registro: 2023-12-05<br/>finalizado: 0<br/>grupo_id: <br/>id: 1<br/>monto: 5000.00<br/>plazo: 12<br/>tipo: INDIVIDUAL<br/>updated_at: 2023-12-05 16:33:05<br/>user_aprobado_id: 1<br/>user_desembolso_id: 1<br/>user_id: 1<br/>', 'PRESTAMOS', '2023-12-05', '16:33:05', '2023-12-05 20:33:05', '2023-12-05 20:33:05'),
(5, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ LA CONFIGURACIÓN', 'actividad: ACTIVIDAD<br/>alias: SISMICROCREDITOS<br/>correo: sismicrocreditos@gmail.com<br/>created_at: <br/>dir: LOS OLIVOS<br/>fono: 7777777<br/>id: 1<br/>logo: 1700500875_logo.png<br/>nit: 11111111<br/>nombre_sistema: SISMICROCREDITOS<br/>razon_social: SISMICROCREDITOS S.A.<br/>updated_at: 2023-12-05 14:48:08<br/>', 'actividad: ACTIVIDAD<br/>alias: SISMICROCREDITOS<br/>correo: sismicrocreditos@gmail.com<br/>created_at: <br/>dir: LOS OLIVOS<br/>fono: 7777777<br/>id: 1<br/>logo: 1700500875_logo.png<br/>nit: 11111111<br/>nombre_sistema: QWEQWE<br/>razon_social: SISMICROCREDITOS S.A.<br/>updated_at: 2023-12-05 16:40:03<br/>', 'CONFIGURACIÓN', '2023-12-05', '16:40:03', '2023-12-05 20:40:03', '2023-12-05 20:40:03'),
(6, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ LA CONFIGURACIÓN', 'actividad: ACTIVIDAD<br/>alias: SISMICROCREDITOS<br/>correo: sismicrocreditos@gmail.com<br/>created_at: <br/>dir: LOS OLIVOS<br/>fono: 7777777<br/>id: 1<br/>logo: 1700500875_logo.png<br/>nit: 11111111<br/>nombre_sistema: QWEQWE<br/>razon_social: SISMICROCREDITOS S.A.<br/>updated_at: 2023-12-05 16:40:03<br/>', 'actividad: ACTIVIDAD<br/>alias: SDASDASD<br/>correo: sismicrocreditos@gmail.com<br/>created_at: <br/>dir: LOS OLIVOS<br/>fono: 7777777<br/>id: 1<br/>logo: 1700500875_logo.png<br/>nit: 11111111<br/>nombre_sistema: QWEQWE<br/>razon_social: SISMICROCREDITOS S.A.<br/>updated_at: 2023-12-05 16:40:11<br/>', 'CONFIGURACIÓN', '2023-12-05', '16:40:11', '2023-12-05 20:40:11', '2023-12-05 20:40:11'),
(7, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN CLIENTE', 'id: 2<br/>nombre: EDUARDO<br/>segundo_nombre: <br/>paterno: MARTINEZ<br/>materno: MAMANI<br/>dir: LOS OLIVOS<br/>ci: 3434<br/>ci_exp: LP<br/>cel: 77777777<br/>fono: <br/>edad: 23<br/>referencia: JUAN PERES<br/>cel_ref: 66666666<br/>parentesco: HERMANO<br/>fecha_registro: 2024-04-03<br/>created_at: 2024-04-03 14:52:21<br/>updated_at: 2024-04-03 14:52:21<br/>', NULL, 'CLIENTES', '2024-04-03', '14:52:21', '2024-04-03 18:52:21', '2024-04-03 18:52:21'),
(8, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN CLIENTE', 'id: 1<br/>nombre: FELIPE<br/>segundo_nombre: <br/>paterno: MAMANI<br/>materno: MAMANI<br/>dir: LOS OLIVOS<br/>ci: 1111<br/>ci_exp: LP<br/>cel: 77777<br/>fono: <br/>edad: 24<br/>referencia: JUAN MAMANI<br/>cel_ref: 66666<br/>parentesco: HERMANO<br/>fecha_registro: 2023-12-05<br/>created_at: 2023-12-05 16:32:13<br/>updated_at: 2023-12-05 16:32:13<br/>', 'id: 1<br/>nombre: FELIPE<br/>segundo_nombre: <br/>paterno: MAMANI<br/>materno: MAMANI<br/>dir: LOS OLIVOS<br/>ci: 1111<br/>ci_exp: LP<br/>cel: 77777777<br/>fono: <br/>edad: 24<br/>referencia: JUAN MAMANI<br/>cel_ref: 66666666<br/>parentesco: HERMANO<br/>fecha_registro: 2023-12-05<br/>created_at: 2023-12-05 16:32:13<br/>updated_at: 2024-04-03 14:52:37<br/>', 'CLIENTES', '2024-04-03', '14:52:37', '2024-04-03 18:52:37', '2024-04-03 18:52:37'),
(9, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PRESTAMO', 'id: 2<br/>user_id: 1<br/>user_desembolso_id: <br/>user_aprobado_id: <br/>cliente_id: 2<br/>tipo: INDIVIDUAL<br/>grupo_id: <br/>monto: 6000<br/>plazo: 12<br/>f_ci: 1<br/>f_luz: 1<br/>f_agua: 1<br/>croquis: 1<br/>documento_1: <br/>documento_2: <br/>documento_3: <br/>documento_4: <br/>estado: PRE APROBADO<br/>desembolso: <br/>finalizado: <br/>fecha_desembolso: <br/>fecha_registro: 2024-04-03<br/>created_at: 2024-04-03 14:53:13<br/>updated_at: 2024-04-03 14:53:13<br/>', NULL, 'PRESTAMOS', '2024-04-03', '14:53:13', '2024-04-03 18:53:13', '2024-04-03 18:53:13'),
(10, 1, 'MODIFICACIÓN', 'EL USUARIO admin APROBO UN PRÉSTAMO', 'id: 2<br/>user_id: 1<br/>user_desembolso_id: <br/>user_aprobado_id: <br/>cliente_id: 2<br/>tipo: INDIVIDUAL<br/>grupo_id: <br/>monto: 6000.00<br/>plazo: 12<br/>f_ci: 1<br/>f_luz: 1<br/>f_agua: 1<br/>croquis: 1<br/>documento_1: <br/>documento_2: <br/>documento_3: <br/>documento_4: <br/>estado: PRE APROBADO<br/>desembolso: 0<br/>finalizado: 0<br/>fecha_desembolso: <br/>fecha_registro: 2024-04-03<br/>created_at: 2024-04-03 14:53:13<br/>updated_at: 2024-04-03 14:53:13<br/>', 'id: 2<br/>user_id: 1<br/>user_desembolso_id: <br/>user_aprobado_id: 1<br/>cliente_id: 2<br/>tipo: INDIVIDUAL<br/>grupo_id: <br/>monto: 6000.00<br/>plazo: 12<br/>f_ci: 1<br/>f_luz: 1<br/>f_agua: 1<br/>croquis: 1<br/>documento_1: <br/>documento_2: <br/>documento_3: <br/>documento_4: <br/>estado: APROBADO<br/>desembolso: 0<br/>finalizado: 0<br/>fecha_desembolso: 2024-04-04<br/>fecha_registro: 2024-04-03<br/>created_at: 2024-04-03 14:53:13<br/>updated_at: 2024-04-03 14:53:42<br/>', 'PRESTAMOS', '2024-04-03', '14:53:42', '2024-04-03 18:53:42', '2024-04-03 18:53:42'),
(11, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PRESTAMO', 'cliente_id: 2<br/>created_at: 2024-04-03 15:19:23<br/>croquis: 1<br/>desembolso: <br/>documento_1: <br/>documento_2: <br/>documento_3: <br/>documento_4: <br/>estado: PRE APROBADO<br/>f_agua: 1<br/>f_ci: 1<br/>f_luz: 1<br/>fecha_desembolso: <br/>fecha_registro: 2024-04-03<br/>finalizado: <br/>grupo_id: 1<br/>id: 3<br/>monto: 3000.00<br/>plazo: 12<br/>tipo: GRUPAL<br/>updated_at: 2024-04-03 15:19:23<br/>user_aprobado_id: <br/>user_desembolso_id: <br/>user_id: 1<br/>', NULL, 'PRESTAMOS', '2024-04-03', '15:19:24', '2024-04-03 19:19:24', '2024-04-03 19:19:24'),
(12, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PRESTAMO', 'cliente_id: 3<br/>created_at: 2024-04-03 15:19:24<br/>croquis: 1<br/>desembolso: <br/>documento_1: <br/>documento_2: <br/>documento_3: <br/>documento_4: <br/>estado: PRE APROBADO<br/>f_agua: 1<br/>f_ci: 1<br/>f_luz: 1<br/>fecha_desembolso: <br/>fecha_registro: 2024-04-03<br/>finalizado: <br/>grupo_id: 1<br/>id: 4<br/>monto: 3000.00<br/>plazo: 12<br/>tipo: GRUPAL<br/>updated_at: 2024-04-03 15:19:24<br/>user_aprobado_id: <br/>user_desembolso_id: <br/>user_id: 1<br/>', NULL, 'PRESTAMOS', '2024-04-03', '15:19:24', '2024-04-03 19:19:24', '2024-04-03 19:19:24'),
(13, 1, 'MODIFICACIÓN', 'EL USUARIO admin APROBO UN PRÉSTAMO GRUPAL', 'created_at: 2024-04-03 15:19:23<br/>desembolso: 0<br/>estado: PRE APROBADO<br/>fecha_desembolso: <br/>fecha_registro: 2024-04-03<br/>finalizado: 0<br/>id: 1<br/>integrantes: 2<br/>monto: 6000.00<br/>nombre: GRUPO UNO<br/>plazo: 12<br/>updated_at: 2024-04-03 15:19:23<br/>user_aprobado_id: <br/>user_desembolso_id: <br/>user_id: 1<br/>', 'created_at: 2024-04-03 15:19:23<br/>desembolso: 0<br/>estado: APROBADO<br/>fecha_desembolso: 2024-04-04<br/>fecha_registro: 2024-04-03<br/>finalizado: 0<br/>id: 1<br/>integrantes: 2<br/>monto: 6000.00<br/>nombre: GRUPO UNO<br/>plazo: 12<br/>updated_at: 2024-04-03 15:19:55<br/>user_aprobado_id: 1<br/>user_desembolso_id: <br/>user_id: 1<br/>', 'PRESTAMOS', '2024-04-03', '15:19:56', '2024-04-03 19:19:56', '2024-04-03 19:19:56'),
(14, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PRESTAMO', 'cliente_id: 4<br/>created_at: 2024-04-03 15:48:37<br/>croquis: 1<br/>desembolso: <br/>documento_1: <br/>documento_2: <br/>documento_3: <br/>documento_4: <br/>estado: PRE APROBADO<br/>f_agua: 1<br/>f_ci: 1<br/>f_luz: 1<br/>fecha_desembolso: <br/>fecha_registro: 2024-04-03<br/>finalizado: <br/>grupo_id: 2<br/>id: 5<br/>monto: 1666.67<br/>plazo: 12<br/>tipo: GRUPAL<br/>updated_at: 2024-04-03 15:48:37<br/>user_aprobado_id: <br/>user_desembolso_id: <br/>user_id: 1<br/>', NULL, 'PRESTAMOS', '2024-04-03', '15:48:37', '2024-04-03 19:48:37', '2024-04-03 19:48:37'),
(15, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PRESTAMO', 'cliente_id: 5<br/>created_at: 2024-04-03 15:48:37<br/>croquis: 1<br/>desembolso: <br/>documento_1: <br/>documento_2: <br/>documento_3: <br/>documento_4: <br/>estado: PRE APROBADO<br/>f_agua: 1<br/>f_ci: 1<br/>f_luz: 1<br/>fecha_desembolso: <br/>fecha_registro: 2024-04-03<br/>finalizado: <br/>grupo_id: 2<br/>id: 6<br/>monto: 1666.67<br/>plazo: 12<br/>tipo: GRUPAL<br/>updated_at: 2024-04-03 15:48:37<br/>user_aprobado_id: <br/>user_desembolso_id: <br/>user_id: 1<br/>', NULL, 'PRESTAMOS', '2024-04-03', '15:48:37', '2024-04-03 19:48:37', '2024-04-03 19:48:37'),
(16, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PRESTAMO', 'cliente_id: 3<br/>created_at: 2024-04-03 15:48:37<br/>croquis: 1<br/>desembolso: <br/>documento_1: <br/>documento_2: <br/>documento_3: <br/>documento_4: <br/>estado: PRE APROBADO<br/>f_agua: 1<br/>f_ci: 1<br/>f_luz: 1<br/>fecha_desembolso: <br/>fecha_registro: 2024-04-03<br/>finalizado: <br/>grupo_id: 2<br/>id: 7<br/>monto: 1666.67<br/>plazo: 12<br/>tipo: GRUPAL<br/>updated_at: 2024-04-03 15:48:37<br/>user_aprobado_id: <br/>user_desembolso_id: <br/>user_id: 1<br/>', NULL, 'PRESTAMOS', '2024-04-03', '15:48:37', '2024-04-03 19:48:37', '2024-04-03 19:48:37'),
(17, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ LA CONFIGURACIÓN', 'actividad: ACTIVIDAD<br/>alias: SDASDASD<br/>correo: sismicrocreditos@gmail.com<br/>created_at: <br/>dir: LOS OLIVOS<br/>fono: 7777777<br/>id: 1<br/>logo: 1700500875_logo.png<br/>nit: 11111111<br/>nombre_sistema: QWEQWE<br/>razon_social: SISMICROCREDITOS S.A.<br/>updated_at: 2023-12-05 16:40:11<br/>', 'actividad: ACTIVIDAD<br/>alias: SISMICROCREDITOS<br/>correo: sismicrocreditos@gmail.com<br/>created_at: <br/>dir: LOS OLIVOS<br/>fono: 7777777<br/>id: 1<br/>logo: 1700500875_logo.png<br/>nit: 11111111<br/>nombre_sistema: SISMICROCREDITOS<br/>razon_social: SISMICROCREDITOS S.A.<br/>updated_at: 2024-04-05 16:01:55<br/>', 'CONFIGURACIÓN', '2024-04-05', '16:01:55', '2024-04-05 20:01:55', '2024-04-05 20:01:55'),
(18, 2, 'MODIFICACIÓN', 'EL USUARIO JPERES REGISTRO EL PAGO DE UN PRESTAMO', 'cliente_id: 1<br/>created_at: 2024-04-05 17:29:34<br/>dias_mora: 918<br/>fecha_pago: 2024-04-05<br/>grupo_id: <br/>grupo_plan_pago_id: <br/>id: 2<br/>interes: 407.00<br/>monto: 5000.00<br/>monto_mora: 13770.00<br/>monto_total: 19177.00<br/>nro_cuota: 0<br/>plan_pago_id: <br/>prestamo_id: 1<br/>tipo_pago: TOTAL<br/>tipo_prestamo: INDIVIDUAL<br/>updated_at: 2024-04-05 17:29:34<br/>user_id: 2<br/>', NULL, 'PAGOS', '2024-04-05', '17:29:34', '2024-04-05 21:29:34', '2024-04-05 21:29:34');

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
(17, '2023_11_30_115539_create_desembolsos_table', 5),
(18, '2023_11_30_225153_create_salarios_table', 6);

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
  `tipo_pago` varchar(155) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_pago` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `pagos`
--

INSERT INTO `pagos` (`id`, `user_id`, `tipo_prestamo`, `prestamo_id`, `plan_pago_id`, `grupo_id`, `grupo_plan_pago_id`, `cliente_id`, `nro_cuota`, `monto`, `interes`, `dias_mora`, `monto_mora`, `monto_total`, `tipo_pago`, `fecha_pago`, `created_at`, `updated_at`) VALUES
(2, 2, 'INDIVIDUAL', 1, NULL, NULL, NULL, 1, 0, 5000.00, 407.00, 918, 13770.00, 19177.00, 'TOTAL', '2024-04-05', '2024-04-05 21:29:34', '2024-04-05 21:29:34');

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
(1, 1, 1, 5000.00, 389.33, 61.25, 4610.67, 450.58, 'SI', '2023-12-12', '2023-12-05 20:32:13', '2024-04-05 21:29:34'),
(2, 1, 2, 4610.67, 394.09, 56.48, 4216.58, 450.58, 'SI', '2023-12-19', '2023-12-05 20:32:13', '2024-04-05 21:29:34'),
(3, 1, 3, 4216.58, 398.92, 51.65, 3817.66, 450.58, 'SI', '2023-12-26', '2023-12-05 20:32:13', '2024-04-05 21:29:34'),
(4, 1, 4, 3817.66, 403.81, 46.77, 3413.85, 450.58, 'SI', '2024-01-02', '2023-12-05 20:32:13', '2024-04-05 21:29:34'),
(5, 1, 5, 3413.85, 408.76, 41.82, 3005.09, 450.58, 'SI', '2024-01-09', '2023-12-05 20:32:13', '2024-04-05 21:29:34'),
(6, 1, 6, 3005.09, 413.76, 36.81, 2591.33, 450.58, 'SI', '2024-01-16', '2023-12-05 20:32:13', '2024-04-05 21:29:34'),
(7, 1, 7, 2591.33, 418.83, 31.74, 2172.50, 450.58, 'SI', '2024-01-23', '2023-12-05 20:32:13', '2024-04-05 21:29:34'),
(8, 1, 8, 2172.50, 423.96, 26.61, 1748.54, 450.58, 'SI', '2024-01-30', '2023-12-05 20:32:13', '2024-04-05 21:29:34'),
(9, 1, 9, 1748.54, 429.16, 21.42, 1319.38, 450.58, 'SI', '2024-02-06', '2023-12-05 20:32:13', '2024-04-05 21:29:34'),
(10, 1, 10, 1319.38, 434.41, 16.16, 884.96, 450.58, 'SI', '2024-02-13', '2023-12-05 20:32:13', '2024-04-05 21:29:34'),
(11, 1, 11, 884.97, 439.73, 10.84, 445.23, 450.58, 'SI', '2024-02-20', '2023-12-05 20:32:13', '2024-04-05 21:29:34'),
(12, 1, 12, 445.24, 445.24, 5.45, 0.00, 450.58, 'SI', '2024-02-27', '2023-12-05 20:32:13', '2024-04-05 21:29:34'),
(13, 2, 1, 6000.00, 467.20, 73.50, 5532.80, 540.70, 'NO', '2024-04-11', '2024-04-03 18:53:13', '2024-04-03 18:53:42'),
(14, 2, 2, 5532.80, 472.92, 67.78, 5059.88, 540.70, 'NO', '2024-04-18', '2024-04-03 18:53:13', '2024-04-03 18:53:42'),
(15, 2, 3, 5059.88, 478.71, 61.98, 4581.17, 540.70, 'NO', '2024-04-25', '2024-04-03 18:53:13', '2024-04-03 18:53:42'),
(16, 2, 4, 4581.17, 484.58, 56.12, 4096.59, 540.70, 'NO', '2024-05-02', '2024-04-03 18:53:13', '2024-04-03 18:53:42'),
(17, 2, 5, 4096.59, 490.51, 50.18, 3606.08, 540.70, 'NO', '2024-05-09', '2024-04-03 18:53:13', '2024-04-03 18:53:42'),
(18, 2, 6, 3606.08, 496.52, 44.17, 3109.56, 540.70, 'NO', '2024-05-16', '2024-04-03 18:53:13', '2024-04-03 18:53:42'),
(19, 2, 7, 3109.56, 502.60, 38.09, 2606.96, 540.70, 'NO', '2024-05-23', '2024-04-03 18:53:13', '2024-04-03 18:53:42'),
(20, 2, 8, 2606.96, 508.76, 31.94, 2098.19, 540.70, 'NO', '2024-05-30', '2024-04-03 18:53:13', '2024-04-03 18:53:42'),
(21, 2, 9, 2098.20, 514.99, 25.70, 1583.20, 540.70, 'NO', '2024-06-06', '2024-04-03 18:53:13', '2024-04-03 18:53:42'),
(22, 2, 10, 1583.21, 521.30, 19.39, 1061.90, 540.70, 'NO', '2024-06-13', '2024-04-03 18:53:13', '2024-04-03 18:53:42'),
(23, 2, 11, 1061.91, 527.69, 13.01, 534.21, 540.70, 'NO', '2024-06-20', '2024-04-03 18:53:13', '2024-04-03 18:53:42'),
(24, 2, 12, 534.22, 534.22, 6.54, 0.00, 540.70, 'NO', '2024-06-27', '2024-04-03 18:53:13', '2024-04-03 18:53:42'),
(25, 3, 1, 3000.00, 233.60, 36.75, 2766.40, 270.35, 'NO', '2024-04-11', '2024-04-03 19:19:23', '2024-04-03 19:19:56'),
(26, 3, 2, 2766.40, 236.46, 33.89, 2529.94, 270.35, 'NO', '2024-04-18', '2024-04-03 19:19:23', '2024-04-03 19:19:56'),
(27, 3, 3, 2529.94, 239.35, 30.99, 2290.59, 270.35, 'NO', '2024-04-25', '2024-04-03 19:19:23', '2024-04-03 19:19:56'),
(28, 3, 4, 2290.59, 242.29, 28.06, 2048.30, 270.35, 'NO', '2024-05-02', '2024-04-03 19:19:23', '2024-04-03 19:19:56'),
(29, 3, 5, 2048.30, 245.25, 25.09, 1803.05, 270.35, 'NO', '2024-05-09', '2024-04-03 19:19:23', '2024-04-03 19:19:56'),
(30, 3, 6, 1803.05, 248.26, 22.09, 1554.79, 270.35, 'NO', '2024-05-16', '2024-04-03 19:19:23', '2024-04-03 19:19:56'),
(31, 3, 7, 1554.79, 251.30, 19.05, 1303.49, 270.35, 'NO', '2024-05-23', '2024-04-03 19:19:23', '2024-04-03 19:19:56'),
(32, 3, 8, 1303.49, 254.38, 15.97, 1049.11, 270.35, 'NO', '2024-05-30', '2024-04-03 19:19:23', '2024-04-03 19:19:56'),
(33, 3, 9, 1049.11, 257.49, 12.85, 791.62, 270.35, 'NO', '2024-06-06', '2024-04-03 19:19:24', '2024-04-03 19:19:56'),
(34, 3, 10, 791.62, 260.65, 9.70, 530.97, 270.35, 'NO', '2024-06-13', '2024-04-03 19:19:24', '2024-04-03 19:19:56'),
(35, 3, 11, 530.97, 263.84, 6.50, 267.13, 270.35, 'NO', '2024-06-20', '2024-04-03 19:19:24', '2024-04-03 19:19:56'),
(36, 3, 12, 267.13, 267.13, 3.27, 0.00, 270.35, 'NO', '2024-06-27', '2024-04-03 19:19:24', '2024-04-03 19:19:56'),
(37, 4, 1, 3000.00, 233.60, 36.75, 2766.40, 270.35, 'NO', '2024-04-11', '2024-04-03 19:19:24', '2024-04-03 19:19:56'),
(38, 4, 2, 2766.40, 236.46, 33.89, 2529.94, 270.35, 'NO', '2024-04-18', '2024-04-03 19:19:24', '2024-04-03 19:19:56'),
(39, 4, 3, 2529.94, 239.35, 30.99, 2290.59, 270.35, 'NO', '2024-04-25', '2024-04-03 19:19:24', '2024-04-03 19:19:56'),
(40, 4, 4, 2290.59, 242.29, 28.06, 2048.30, 270.35, 'NO', '2024-05-02', '2024-04-03 19:19:24', '2024-04-03 19:19:56'),
(41, 4, 5, 2048.30, 245.25, 25.09, 1803.05, 270.35, 'NO', '2024-05-09', '2024-04-03 19:19:24', '2024-04-03 19:19:56'),
(42, 4, 6, 1803.05, 248.26, 22.09, 1554.79, 270.35, 'NO', '2024-05-16', '2024-04-03 19:19:24', '2024-04-03 19:19:56'),
(43, 4, 7, 1554.79, 251.30, 19.05, 1303.49, 270.35, 'NO', '2024-05-23', '2024-04-03 19:19:24', '2024-04-03 19:19:56'),
(44, 4, 8, 1303.49, 254.38, 15.97, 1049.11, 270.35, 'NO', '2024-05-30', '2024-04-03 19:19:24', '2024-04-03 19:19:56'),
(45, 4, 9, 1049.11, 257.49, 12.85, 791.62, 270.35, 'NO', '2024-06-06', '2024-04-03 19:19:24', '2024-04-03 19:19:56'),
(46, 4, 10, 791.62, 260.65, 9.70, 530.97, 270.35, 'NO', '2024-06-13', '2024-04-03 19:19:24', '2024-04-03 19:19:56'),
(47, 4, 11, 530.97, 263.84, 6.50, 267.13, 270.35, 'NO', '2024-06-20', '2024-04-03 19:19:24', '2024-04-03 19:19:56'),
(48, 4, 12, 267.13, 267.13, 3.27, 0.00, 270.35, 'NO', '2024-06-27', '2024-04-03 19:19:24', '2024-04-03 19:19:56'),
(49, 5, 1, 1666.67, 129.77, 20.42, 1536.90, 150.19, 'NO', NULL, '2024-04-03 19:48:37', '2024-04-03 19:48:37'),
(50, 5, 2, 1536.90, 131.36, 18.83, 1405.54, 150.19, 'NO', NULL, '2024-04-03 19:48:37', '2024-04-03 19:48:37'),
(51, 5, 3, 1405.54, 132.97, 17.22, 1272.57, 150.19, 'NO', NULL, '2024-04-03 19:48:37', '2024-04-03 19:48:37'),
(52, 5, 4, 1272.57, 134.60, 15.59, 1137.97, 150.19, 'NO', NULL, '2024-04-03 19:48:37', '2024-04-03 19:48:37'),
(53, 5, 5, 1137.97, 136.24, 13.94, 1001.73, 150.19, 'NO', NULL, '2024-04-03 19:48:37', '2024-04-03 19:48:37'),
(54, 5, 6, 1001.73, 137.91, 12.27, 863.82, 150.19, 'NO', NULL, '2024-04-03 19:48:37', '2024-04-03 19:48:37'),
(55, 5, 7, 863.82, 139.60, 10.58, 724.22, 150.19, 'NO', NULL, '2024-04-03 19:48:37', '2024-04-03 19:48:37'),
(56, 5, 8, 724.22, 141.31, 8.87, 582.91, 150.19, 'NO', NULL, '2024-04-03 19:48:37', '2024-04-03 19:48:37'),
(57, 5, 9, 582.91, 143.04, 7.14, 439.87, 150.19, 'NO', NULL, '2024-04-03 19:48:37', '2024-04-03 19:48:37'),
(58, 5, 10, 439.87, 144.80, 5.39, 295.07, 150.19, 'NO', NULL, '2024-04-03 19:48:37', '2024-04-03 19:48:37'),
(59, 5, 11, 295.07, 146.57, 3.61, 148.50, 150.19, 'NO', NULL, '2024-04-03 19:48:37', '2024-04-03 19:48:37'),
(60, 5, 12, 148.50, 148.50, 1.82, 0.00, 150.19, 'NO', NULL, '2024-04-03 19:48:37', '2024-04-03 19:48:37'),
(61, 6, 1, 1666.67, 129.77, 20.42, 1536.90, 150.19, 'NO', NULL, '2024-04-03 19:48:37', '2024-04-03 19:48:37'),
(62, 6, 2, 1536.90, 131.36, 18.83, 1405.54, 150.19, 'NO', NULL, '2024-04-03 19:48:37', '2024-04-03 19:48:37'),
(63, 6, 3, 1405.54, 132.97, 17.22, 1272.57, 150.19, 'NO', NULL, '2024-04-03 19:48:37', '2024-04-03 19:48:37'),
(64, 6, 4, 1272.57, 134.60, 15.59, 1137.97, 150.19, 'NO', NULL, '2024-04-03 19:48:37', '2024-04-03 19:48:37'),
(65, 6, 5, 1137.97, 136.24, 13.94, 1001.73, 150.19, 'NO', NULL, '2024-04-03 19:48:37', '2024-04-03 19:48:37'),
(66, 6, 6, 1001.73, 137.91, 12.27, 863.82, 150.19, 'NO', NULL, '2024-04-03 19:48:37', '2024-04-03 19:48:37'),
(67, 6, 7, 863.82, 139.60, 10.58, 724.22, 150.19, 'NO', NULL, '2024-04-03 19:48:37', '2024-04-03 19:48:37'),
(68, 6, 8, 724.22, 141.31, 8.87, 582.91, 150.19, 'NO', NULL, '2024-04-03 19:48:37', '2024-04-03 19:48:37'),
(69, 6, 9, 582.91, 143.04, 7.14, 439.87, 150.19, 'NO', NULL, '2024-04-03 19:48:37', '2024-04-03 19:48:37'),
(70, 6, 10, 439.87, 144.80, 5.39, 295.07, 150.19, 'NO', NULL, '2024-04-03 19:48:37', '2024-04-03 19:48:37'),
(71, 6, 11, 295.07, 146.57, 3.61, 148.50, 150.19, 'NO', NULL, '2024-04-03 19:48:37', '2024-04-03 19:48:37'),
(72, 6, 12, 148.50, 148.50, 1.82, 0.00, 150.19, 'NO', NULL, '2024-04-03 19:48:37', '2024-04-03 19:48:37'),
(73, 7, 1, 1666.67, 129.77, 20.42, 1536.90, 150.19, 'NO', NULL, '2024-04-03 19:48:37', '2024-04-03 19:48:37'),
(74, 7, 2, 1536.90, 131.36, 18.83, 1405.54, 150.19, 'NO', NULL, '2024-04-03 19:48:37', '2024-04-03 19:48:37'),
(75, 7, 3, 1405.54, 132.97, 17.22, 1272.57, 150.19, 'NO', NULL, '2024-04-03 19:48:37', '2024-04-03 19:48:37'),
(76, 7, 4, 1272.57, 134.60, 15.59, 1137.97, 150.19, 'NO', NULL, '2024-04-03 19:48:37', '2024-04-03 19:48:37'),
(77, 7, 5, 1137.97, 136.24, 13.94, 1001.73, 150.19, 'NO', NULL, '2024-04-03 19:48:37', '2024-04-03 19:48:37'),
(78, 7, 6, 1001.73, 137.91, 12.27, 863.82, 150.19, 'NO', NULL, '2024-04-03 19:48:37', '2024-04-03 19:48:37'),
(79, 7, 7, 863.82, 139.60, 10.58, 724.22, 150.19, 'NO', NULL, '2024-04-03 19:48:37', '2024-04-03 19:48:37'),
(80, 7, 8, 724.22, 141.31, 8.87, 582.91, 150.19, 'NO', NULL, '2024-04-03 19:48:37', '2024-04-03 19:48:37'),
(81, 7, 9, 582.91, 143.04, 7.14, 439.87, 150.19, 'NO', NULL, '2024-04-03 19:48:37', '2024-04-03 19:48:37'),
(82, 7, 10, 439.87, 144.80, 5.39, 295.07, 150.19, 'NO', NULL, '2024-04-03 19:48:37', '2024-04-03 19:48:37'),
(83, 7, 11, 295.07, 146.57, 3.61, 148.50, 150.19, 'NO', NULL, '2024-04-03 19:48:37', '2024-04-03 19:48:37'),
(84, 7, 12, 148.50, 148.50, 1.82, 0.00, 150.19, 'NO', NULL, '2024-04-03 19:48:37', '2024-04-03 19:48:37');

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
  `fecha_aprobado` date DEFAULT NULL,
  `fecha_rechazado` date DEFAULT NULL,
  `fecha_desembolso` date DEFAULT NULL,
  `fecha_registro` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `prestamos`
--

INSERT INTO `prestamos` (`id`, `user_id`, `user_desembolso_id`, `user_aprobado_id`, `cliente_id`, `tipo`, `grupo_id`, `monto`, `plazo`, `f_ci`, `f_luz`, `f_agua`, `croquis`, `documento_1`, `documento_2`, `documento_3`, `documento_4`, `estado`, `desembolso`, `finalizado`, `fecha_aprobado`, `fecha_rechazado`, `fecha_desembolso`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 1, 'INDIVIDUAL', NULL, 5000.00, 12, 1, 1, 1, 1, NULL, NULL, NULL, NULL, 'APROBADO', 1, 1, '2023-12-05', NULL, '2023-12-05', '2023-12-05', '2023-12-05 20:32:13', '2024-04-05 21:29:34'),
(2, 1, NULL, 1, 2, 'INDIVIDUAL', NULL, 6000.00, 12, 1, 1, 1, 1, NULL, NULL, NULL, NULL, 'APROBADO', 0, 0, '2024-04-03', NULL, '2024-04-05', '2024-04-03', '2024-04-03 18:53:13', '2024-04-05 19:14:28'),
(3, 1, 1, 1, 2, 'GRUPAL', 1, 3000.00, 12, 1, 1, 1, 1, NULL, NULL, NULL, NULL, 'APROBADO', 1, 0, '2024-04-03', NULL, '2024-04-05', '2024-04-03', '2024-04-03 19:19:23', '2024-04-05 19:14:37'),
(4, 1, 1, 1, 3, 'GRUPAL', 1, 3000.00, 12, 1, 1, 1, 1, NULL, NULL, NULL, NULL, 'APROBADO', 1, 0, '2024-04-03', NULL, '2024-04-05', '2024-04-03', '2024-04-03 19:19:24', '2024-04-05 19:14:37'),
(5, 1, NULL, NULL, 4, 'GRUPAL', 2, 1666.67, 12, 1, 1, 1, 1, NULL, NULL, NULL, NULL, 'PRE APROBADO', 0, 0, NULL, NULL, NULL, '2024-04-03', '2024-04-03 19:48:37', '2024-04-03 19:48:37'),
(6, 1, NULL, NULL, 5, 'GRUPAL', 2, 1666.67, 12, 1, 1, 1, 1, NULL, NULL, NULL, NULL, 'PRE APROBADO', 0, 0, NULL, NULL, NULL, '2024-04-03', '2024-04-03 19:48:37', '2024-04-03 19:48:37'),
(7, 1, NULL, NULL, 3, 'GRUPAL', 2, 1666.67, 12, 1, 1, 1, 1, NULL, NULL, NULL, NULL, 'PRE APROBADO', 0, 0, NULL, NULL, NULL, '2024-04-03', '2024-04-03 19:48:37', '2024-04-03 19:48:37');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `salarios`
--

CREATE TABLE `salarios` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `salario` decimal(24,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(2, 'JPERES', 'JUAN', 'PERES', 'MAMANI', '1234', 'CB', 'CAJERO', NULL, '$2y$10$Q5aCkg5uV1q5P1iuHLZaXu2..Qn4RnNXb1JI8cG56EHuy.Zupyeli', 1, '2023-11-22', '2023-11-22 14:57:15', '2024-04-05 20:08:10'),
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
-- Indices de la tabla `salarios`
--
ALTER TABLE `salarios`
  ADD PRIMARY KEY (`id`);

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `configuracions`
--
ALTER TABLE `configuracions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `desembolsos`
--
ALTER TABLE `desembolsos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `grupos`
--
ALTER TABLE `grupos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `grupo_plan_pagos`
--
ALTER TABLE `grupo_plan_pagos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT de la tabla `historial_accions`
--
ALTER TABLE `historial_accions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `interes`
--
ALTER TABLE `interes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `pagos`
--
ALTER TABLE `pagos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `plan_pagos`
--
ALTER TABLE `plan_pagos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=85;

--
-- AUTO_INCREMENT de la tabla `prestamos`
--
ALTER TABLE `prestamos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `salarios`
--
ALTER TABLE `salarios`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

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
