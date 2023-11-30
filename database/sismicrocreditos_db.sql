-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 30-11-2023 a las 22:06:02
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
(1, 'Pago por Cuotas', 0.00, NULL, '2023-11-30 21:40:12'),
(2, 'Gastos Administrativos', 0.00, NULL, '2023-11-30 21:40:12'),
(3, 'Cargos por Multa', 0.00, NULL, '2023-11-30 21:40:12'),
(4, 'Intereses', 0.00, NULL, '2023-11-30 21:40:12');

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
(1, 3, NULL, NULL, 'GRUPO UNO', 2, 10000.00, 12, 0, NULL, 'PRE APROBADO', 0, '2023-11-30', '2023-11-30 21:59:55', '2023-11-30 21:59:55');

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
(1, 1, 1, 10000.00, 778.67, 122.50, 9221.33, 901.17, 'NO', NULL, '2023-11-30 21:59:55', '2023-11-30 21:59:55'),
(2, 1, 2, 9221.33, 788.20, 112.96, 8433.12, 901.17, 'NO', NULL, '2023-11-30 21:59:55', '2023-11-30 21:59:55'),
(3, 1, 3, 8433.13, 797.86, 103.31, 7635.27, 901.17, 'NO', NULL, '2023-11-30 21:59:55', '2023-11-30 21:59:55'),
(4, 1, 4, 7635.27, 807.63, 93.53, 6827.64, 901.17, 'NO', NULL, '2023-11-30 21:59:55', '2023-11-30 21:59:55'),
(5, 1, 5, 6827.64, 817.53, 83.64, 6010.11, 901.17, 'NO', NULL, '2023-11-30 21:59:55', '2023-11-30 21:59:55'),
(6, 1, 6, 6010.11, 827.54, 73.62, 5182.57, 901.17, 'NO', NULL, '2023-11-30 21:59:55', '2023-11-30 21:59:55'),
(7, 1, 7, 5182.57, 837.68, 63.49, 4344.88, 901.17, 'NO', NULL, '2023-11-30 21:59:55', '2023-11-30 21:59:55'),
(8, 1, 8, 4344.89, 847.94, 53.22, 3496.94, 901.17, 'NO', NULL, '2023-11-30 21:59:55', '2023-11-30 21:59:55'),
(9, 1, 9, 3496.95, 858.33, 42.84, 2638.61, 901.17, 'NO', NULL, '2023-11-30 21:59:55', '2023-11-30 21:59:55'),
(10, 1, 10, 2638.62, 868.84, 32.32, 1769.77, 901.17, 'NO', NULL, '2023-11-30 21:59:55', '2023-11-30 21:59:55'),
(11, 1, 11, 1769.78, 879.49, 21.68, 890.28, 901.17, 'NO', NULL, '2023-11-30 21:59:55', '2023-11-30 21:59:55'),
(12, 1, 12, 890.29, 890.29, 10.91, 0.00, 901.17, 'NO', NULL, '2023-11-30 21:59:55', '2023-11-30 21:59:55');

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
(1, 3, 'CREACIÓN', 'EL USUARIO NBURGOS REGISTRO UN PRESTAMO', 'cliente_id: 1<br/>created_at: 2023-11-30 17:49:40<br/>croquis: 1<br/>desembolso: <br/>documento_1: <br/>documento_2: <br/>documento_3: <br/>documento_4: <br/>estado: PRE APROBADO<br/>f_agua: 1<br/>f_ci: 1<br/>f_luz: 1<br/>fecha_desembolso: <br/>fecha_registro: 2023-11-30<br/>finalizado: <br/>grupo_id: <br/>id: 1<br/>monto: 4000<br/>plazo: 12<br/>tipo: INDIVIDUAL<br/>updated_at: 2023-11-30 17:49:40<br/>user_aprobado_id: <br/>user_desembolso_id: <br/>user_id: 3<br/>', NULL, 'PRESTAMOS', '2023-11-30', '17:49:40', '2023-11-30 21:49:40', '2023-11-30 21:49:40'),
(2, 3, 'CREACIÓN', 'EL USUARIO NBURGOS REGISTRO UN PRESTAMO', 'cliente_id: 3<br/>created_at: 2023-11-30 17:59:55<br/>croquis: 1<br/>desembolso: <br/>documento_1: <br/>documento_2: <br/>documento_3: <br/>documento_4: <br/>estado: PRE APROBADO<br/>f_agua: 1<br/>f_ci: 1<br/>f_luz: 1<br/>fecha_desembolso: <br/>fecha_registro: 2023-11-30<br/>finalizado: <br/>grupo_id: 1<br/>id: 2<br/>monto: 6000<br/>plazo: 12<br/>tipo: GRUPAL<br/>updated_at: 2023-11-30 17:59:55<br/>user_aprobado_id: <br/>user_desembolso_id: <br/>user_id: 3<br/>', NULL, 'PRESTAMOS', '2023-11-30', '17:59:55', '2023-11-30 21:59:55', '2023-11-30 21:59:55'),
(3, 3, 'CREACIÓN', 'EL USUARIO NBURGOS REGISTRO UN PRESTAMO', 'cliente_id: 7<br/>created_at: 2023-11-30 17:59:55<br/>croquis: 1<br/>desembolso: <br/>documento_1: <br/>documento_2: <br/>documento_3: <br/>documento_4: <br/>estado: PRE APROBADO<br/>f_agua: 1<br/>f_ci: 1<br/>f_luz: 1<br/>fecha_desembolso: <br/>fecha_registro: 2023-11-30<br/>finalizado: <br/>grupo_id: 1<br/>id: 3<br/>monto: 4000<br/>plazo: 12<br/>tipo: GRUPAL<br/>updated_at: 2023-11-30 17:59:55<br/>user_aprobado_id: <br/>user_desembolso_id: <br/>user_id: 3<br/>', NULL, 'PRESTAMOS', '2023-11-30', '17:59:55', '2023-11-30 21:59:55', '2023-11-30 21:59:55'),
(4, 3, 'MODIFICACIÓN', 'EL USUARIO NBURGOS APROBO UN PRÉSTAMO', 'cliente_id: 1<br/>created_at: 2023-11-30 17:49:40<br/>croquis: 1<br/>desembolso: 0<br/>documento_1: <br/>documento_2: <br/>documento_3: <br/>documento_4: <br/>estado: PRE APROBADO<br/>f_agua: 1<br/>f_ci: 1<br/>f_luz: 1<br/>fecha_desembolso: <br/>fecha_registro: 2023-11-30<br/>finalizado: 0<br/>grupo_id: <br/>id: 1<br/>monto: 4000.00<br/>plazo: 12<br/>tipo: INDIVIDUAL<br/>updated_at: 2023-11-30 17:49:40<br/>user_aprobado_id: <br/>user_desembolso_id: <br/>user_id: 3<br/>', 'cliente_id: 1<br/>created_at: 2023-11-30 17:49:40<br/>croquis: 1<br/>desembolso: 0<br/>documento_1: <br/>documento_2: <br/>documento_3: <br/>documento_4: <br/>estado: APROBADO<br/>f_agua: 1<br/>f_ci: 1<br/>f_luz: 1<br/>fecha_desembolso: 2023-11-30<br/>fecha_registro: 2023-11-30<br/>finalizado: 0<br/>grupo_id: <br/>id: 1<br/>monto: 4000.00<br/>plazo: 12<br/>tipo: INDIVIDUAL<br/>updated_at: 2023-11-30 18:04:22<br/>user_aprobado_id: 3<br/>user_desembolso_id: <br/>user_id: 3<br/>', 'PRESTAMOS', '2023-11-30', '18:04:22', '2023-11-30 22:04:22', '2023-11-30 22:04:22');

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
(1, 1, 1, 4000.00, 311.47, 49.00, 3688.53, 360.47, 'NO', '2023-12-07', '2023-11-30 21:49:40', '2023-11-30 22:04:22'),
(2, 1, 2, 3688.53, 315.28, 45.18, 3373.25, 360.47, 'NO', '2023-12-14', '2023-11-30 21:49:40', '2023-11-30 22:04:22'),
(3, 1, 3, 3373.25, 319.14, 41.32, 3054.11, 360.47, 'NO', '2023-12-21', '2023-11-30 21:49:40', '2023-11-30 22:04:22'),
(4, 1, 4, 3054.11, 323.05, 37.41, 2731.06, 360.47, 'NO', '2023-12-28', '2023-11-30 21:49:40', '2023-11-30 22:04:22'),
(5, 1, 5, 2731.06, 327.01, 33.46, 2404.05, 360.47, 'NO', '2024-01-04', '2023-11-30 21:49:40', '2023-11-30 22:04:22'),
(6, 1, 6, 2404.05, 331.02, 29.45, 2073.03, 360.47, 'NO', '2024-01-11', '2023-11-30 21:49:40', '2023-11-30 22:04:22'),
(7, 1, 7, 2073.03, 335.07, 25.39, 1737.96, 360.47, 'NO', '2024-01-18', '2023-11-30 21:49:40', '2023-11-30 22:04:22'),
(8, 1, 8, 1737.96, 339.17, 21.29, 1398.79, 360.47, 'NO', '2024-01-25', '2023-11-30 21:49:40', '2023-11-30 22:04:22'),
(9, 1, 9, 1398.79, 343.33, 17.14, 1055.46, 360.47, 'NO', '2024-02-01', '2023-11-30 21:49:40', '2023-11-30 22:04:22'),
(10, 1, 10, 1055.46, 347.54, 12.93, 707.92, 360.47, 'NO', '2024-02-08', '2023-11-30 21:49:40', '2023-11-30 22:04:22'),
(11, 1, 11, 707.92, 351.79, 8.67, 356.13, 360.47, 'NO', '2024-02-15', '2023-11-30 21:49:40', '2023-11-30 22:04:22'),
(12, 1, 12, 356.13, 356.13, 4.36, 0.00, 360.47, 'NO', '2024-02-22', '2023-11-30 21:49:40', '2023-11-30 22:04:22'),
(13, 2, 1, 6000.00, 467.20, 73.50, 5532.80, 540.70, 'NO', NULL, '2023-11-30 21:59:55', '2023-11-30 21:59:55'),
(14, 2, 2, 5532.80, 472.92, 67.78, 5059.88, 540.70, 'NO', NULL, '2023-11-30 21:59:55', '2023-11-30 21:59:55'),
(15, 2, 3, 5059.88, 478.71, 61.98, 4581.17, 540.70, 'NO', NULL, '2023-11-30 21:59:55', '2023-11-30 21:59:55'),
(16, 2, 4, 4581.17, 484.58, 56.12, 4096.59, 540.70, 'NO', NULL, '2023-11-30 21:59:55', '2023-11-30 21:59:55'),
(17, 2, 5, 4096.59, 490.51, 50.18, 3606.08, 540.70, 'NO', NULL, '2023-11-30 21:59:55', '2023-11-30 21:59:55'),
(18, 2, 6, 3606.08, 496.52, 44.17, 3109.56, 540.70, 'NO', NULL, '2023-11-30 21:59:55', '2023-11-30 21:59:55'),
(19, 2, 7, 3109.56, 502.60, 38.09, 2606.96, 540.70, 'NO', NULL, '2023-11-30 21:59:55', '2023-11-30 21:59:55'),
(20, 2, 8, 2606.96, 508.76, 31.94, 2098.19, 540.70, 'NO', NULL, '2023-11-30 21:59:55', '2023-11-30 21:59:55'),
(21, 2, 9, 2098.20, 514.99, 25.70, 1583.20, 540.70, 'NO', NULL, '2023-11-30 21:59:55', '2023-11-30 21:59:55'),
(22, 2, 10, 1583.21, 521.30, 19.39, 1061.90, 540.70, 'NO', NULL, '2023-11-30 21:59:55', '2023-11-30 21:59:55'),
(23, 2, 11, 1061.91, 527.69, 13.01, 534.21, 540.70, 'NO', NULL, '2023-11-30 21:59:55', '2023-11-30 21:59:55'),
(24, 2, 12, 534.22, 534.22, 6.54, 0.00, 540.70, 'NO', NULL, '2023-11-30 21:59:55', '2023-11-30 21:59:55'),
(25, 3, 1, 4000.00, 311.47, 49.00, 3688.53, 360.47, 'NO', NULL, '2023-11-30 21:59:55', '2023-11-30 21:59:55'),
(26, 3, 2, 3688.53, 315.28, 45.18, 3373.25, 360.47, 'NO', NULL, '2023-11-30 21:59:55', '2023-11-30 21:59:55'),
(27, 3, 3, 3373.25, 319.14, 41.32, 3054.11, 360.47, 'NO', NULL, '2023-11-30 21:59:55', '2023-11-30 21:59:55'),
(28, 3, 4, 3054.11, 323.05, 37.41, 2731.06, 360.47, 'NO', NULL, '2023-11-30 21:59:55', '2023-11-30 21:59:55'),
(29, 3, 5, 2731.06, 327.01, 33.46, 2404.05, 360.47, 'NO', NULL, '2023-11-30 21:59:55', '2023-11-30 21:59:55'),
(30, 3, 6, 2404.05, 331.02, 29.45, 2073.03, 360.47, 'NO', NULL, '2023-11-30 21:59:55', '2023-11-30 21:59:55'),
(31, 3, 7, 2073.03, 335.07, 25.39, 1737.96, 360.47, 'NO', NULL, '2023-11-30 21:59:55', '2023-11-30 21:59:55'),
(32, 3, 8, 1737.96, 339.17, 21.29, 1398.79, 360.47, 'NO', NULL, '2023-11-30 21:59:55', '2023-11-30 21:59:55'),
(33, 3, 9, 1398.79, 343.33, 17.14, 1055.46, 360.47, 'NO', NULL, '2023-11-30 21:59:55', '2023-11-30 21:59:55'),
(34, 3, 10, 1055.46, 347.54, 12.93, 707.92, 360.47, 'NO', NULL, '2023-11-30 21:59:55', '2023-11-30 21:59:55'),
(35, 3, 11, 707.92, 351.79, 8.67, 356.13, 360.47, 'NO', NULL, '2023-11-30 21:59:55', '2023-11-30 21:59:55'),
(36, 3, 12, 356.13, 356.13, 4.36, 0.00, 360.47, 'NO', NULL, '2023-11-30 21:59:55', '2023-11-30 21:59:55');

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
(1, 3, NULL, 3, 1, 'INDIVIDUAL', NULL, 4000.00, 12, 1, 1, 1, 1, NULL, NULL, NULL, NULL, 'APROBADO', 0, 0, '2023-11-30', '2023-11-30', '2023-11-30 21:49:40', '2023-11-30 22:04:22'),
(2, 3, NULL, NULL, 3, 'GRUPAL', 1, 6000.00, 12, 1, 1, 1, 1, NULL, NULL, NULL, NULL, 'PRE APROBADO', 0, 0, NULL, '2023-11-30', '2023-11-30 21:59:55', '2023-11-30 21:59:55'),
(3, 3, NULL, NULL, 7, 'GRUPAL', 1, 4000.00, 12, 1, 1, 1, 1, NULL, NULL, NULL, NULL, 'PRE APROBADO', 0, 0, NULL, '2023-11-30', '2023-11-30 21:59:55', '2023-11-30 21:59:55');

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `grupos`
--
ALTER TABLE `grupos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `grupo_plan_pagos`
--
ALTER TABLE `grupo_plan_pagos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `historial_accions`
--
ALTER TABLE `historial_accions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `plan_pagos`
--
ALTER TABLE `plan_pagos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT de la tabla `prestamos`
--
ALTER TABLE `prestamos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
