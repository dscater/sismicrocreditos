-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 22-11-2023 a las 17:20:15
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
  `caja` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `saldo` decimal(24,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `caja_movimientos`
--

CREATE TABLE `caja_movimientos` (
  `id` bigint UNSIGNED NOT NULL,
  `caja_id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `monto` decimal(24,2) NOT NULL,
  `tipo` enum('CRÉDITO','DEBITO') COLLATE utf8mb4_unicode_ci NOT NULL,
  `glosa` enum('GASTOS ADMINISTRATIVOS','DESEMBOLSO','PAGO CUOTA PRESTAMO','INTERES','PAGO MORA','ABONO CAPITAL') COLLATE utf8mb4_unicode_ci NOT NULL,
  `prestamo_id` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(155) COLLATE utf8mb4_unicode_ci NOT NULL,
  `segundo_nombre` varchar(155) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paterno` varchar(155) COLLATE utf8mb4_unicode_ci NOT NULL,
  `materno` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dir` varchar(300) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ci` varchar(155) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ci_exp` varchar(155) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cel` varchar(155) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fono` varchar(155) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `edad` int NOT NULL,
  `referencia` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cel_ref` varchar(155) COLLATE utf8mb4_unicode_ci NOT NULL,
  `parentesco` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_registro` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`id`, `nombre`, `segundo_nombre`, `paterno`, `materno`, `dir`, `ci`, `ci_exp`, `cel`, `fono`, `edad`, `referencia`, `cel_ref`, `parentesco`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(1, 'LUIS', 'ALBERTO', 'GONZALES', '', 'LOS OLIVOS', '1111', 'LP', '666666', '', 26, 'MARIO GONZALES', '666666', 'HERMANO', '2023-11-22', '2023-11-22 16:58:18', '2023-11-22 16:58:18');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `configuracions`
--

CREATE TABLE `configuracions` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre_sistema` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `alias` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `razon_social` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dir` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nit` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fono` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `actividad` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `correo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
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
-- Estructura de tabla para la tabla `grupos`
--

CREATE TABLE `grupos` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `integrantes` int NOT NULL,
  `monto` decimal(24,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_accions`
--

CREATE TABLE `historial_accions` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `accion` varchar(155) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `datos_original` text COLLATE utf8mb4_unicode_ci,
  `datos_nuevo` text COLLATE utf8mb4_unicode_ci,
  `modulo` varchar(155) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `historial_accions`
--

INSERT INTO `historial_accions` (`id`, `user_id`, `accion`, `descripcion`, `datos_original`, `datos_nuevo`, `modulo`, `fecha`, `hora`, `created_at`, `updated_at`) VALUES
(1, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ LA CONFIGURACIÓN', 'actividad: ACTIVIDAD<br/>alias: SISMICROCREDITOS<br/>correo: sismicrocreditos@gmail.com<br/>created_at: <br/>dir: LOS OLIVOS<br/>fono: 7777777<br/>id: 1<br/>logo: logo.png<br/>nit: 11111111<br/>nombre_sistema: SISMICROCREDITOS<br/>razon_social: SISMICROCREDITOS<br/>updated_at: <br/>', 'actividad: ACTIVIDAD<br/>alias: SISMICROCREDITOS<br/>correo: sismicrocreditos@gmail.com<br/>created_at: <br/>dir: LOS OLIVOS<br/>fono: 7777777<br/>id: 1<br/>logo: 1700500574_logo.png<br/>nit: 11111111<br/>nombre_sistema: SISMICROCREDITOS<br/>razon_social: SISMICROCREDITOS<br/>updated_at: 2023-11-20 13:16:14<br/>', 'CONFIGURACIÓN', '2023-11-20', '13:16:14', '2023-11-20 17:16:14', '2023-11-20 17:16:14'),
(2, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ LA CONFIGURACIÓN', 'actividad: ACTIVIDAD<br/>alias: SISMICROCREDITOS<br/>correo: sismicrocreditos@gmail.com<br/>created_at: <br/>dir: LOS OLIVOS<br/>fono: 7777777<br/>id: 1<br/>logo: 1700500574_logo.png<br/>nit: 11111111<br/>nombre_sistema: SISMICROCREDITOS<br/>razon_social: SISMICROCREDITOS<br/>updated_at: 2023-11-20 13:16:14<br/>', 'actividad: ACTIVIDAD<br/>alias: SISMICROCREDITOS<br/>correo: sismicrocreditos@gmail.com<br/>created_at: <br/>dir: LOS OLIVOS<br/>fono: 7777777<br/>id: 1<br/>logo: 1700500875_logo.png<br/>nit: 11111111<br/>nombre_sistema: SISMICROCREDITOS<br/>razon_social: SISMICROCREDITOS<br/>updated_at: 2023-11-20 13:21:15<br/>', 'CONFIGURACIÓN', '2023-11-20', '13:21:15', '2023-11-20 17:21:15', '2023-11-20 17:21:15'),
(3, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN USUARIO', 'id: 2<br/>usuario: JPERES<br/>nombre: JUAN<br/>paterno: PERES<br/>materno: MAMANI<br/>tipo: CAJERO<br/>foto: <br/>password: $2Y$10$32ZXFBMLP4JIUI3SLL0Q/O4BST6SGNRYOTHUQOM083UJKIO8IEBL6<br/>acceso: 1<br/>fecha_registro: 2023-11-22<br/>created_at: 2023-11-22 10:57:15<br/>updated_at: 2023-11-22 10:57:15<br/>', NULL, 'USUARIOS', '2023-11-22', '10:57:15', '2023-11-22 14:57:15', '2023-11-22 14:57:15'),
(4, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN USUARIO', 'id: 3<br/>usuario: MMAMANI<br/>nombre: MARIA<br/>paterno: MAMANI<br/>materno: MAMANI<br/>tipo: CAJERO<br/>foto: <br/>password: $2y$10$OXGvRuXBIIOwMqJi4bvojuQEMYifzjbD7brvcynYdoEn16DltW94C<br/>acceso: 1<br/>fecha_registro: 2023-11-22<br/>created_at: 2023-11-22 10:59:26<br/>updated_at: 2023-11-22 10:59:26<br/>', NULL, 'USUARIOS', '2023-11-22', '10:59:26', '2023-11-22 14:59:26', '2023-11-22 14:59:26'),
(5, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN USUARIO', 'id: 2<br/>usuario: JPERES<br/>nombre: JUAN<br/>paterno: PERES<br/>materno: MAMANI<br/>tipo: CAJERO<br/>foto: <br/>password: $2y$10$gNDUj6n68JU6Amr1qGOuwe8RBFf8jW0v76PsL.V/zjhFwvh6SdtfO<br/>acceso: 1<br/>fecha_registro: 2023-11-22<br/>created_at: 2023-11-22 10:57:15<br/>updated_at: 2023-11-22 10:59:01<br/>', 'id: 2<br/>usuario: JMAMANI<br/>nombre: JUAN<br/>paterno: PERES<br/>materno: MAMANI<br/>tipo: CAJERO<br/>foto: <br/>password: <br/>acceso: 1<br/>fecha_registro: 2023-11-22<br/>created_at: 2023-11-22 10:57:15<br/>updated_at: 2023-11-22 10:59:47<br/>', 'USUARIOS', '2023-11-22', '10:59:47', '2023-11-22 14:59:47', '2023-11-22 14:59:47'),
(6, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN USUARIO', 'id: 2<br/>usuario: JMAMANI<br/>nombre: JUAN<br/>paterno: PERES<br/>materno: MAMANI<br/>tipo: CAJERO<br/>foto: <br/>password: <br/>acceso: 1<br/>fecha_registro: 2023-11-22<br/>created_at: 2023-11-22 10:57:15<br/>updated_at: 2023-11-22 10:59:47<br/>', 'id: 2<br/>usuario: JPERES<br/>nombre: JUAN<br/>paterno: PERES<br/>materno: MAMANI<br/>tipo: CAJERO<br/>foto: <br/>password: <br/>acceso: 1<br/>fecha_registro: 2023-11-22<br/>created_at: 2023-11-22 10:57:15<br/>updated_at: 2023-11-22 10:59:58<br/>', 'USUARIOS', '2023-11-22', '10:59:58', '2023-11-22 14:59:58', '2023-11-22 14:59:58'),
(7, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UN USUARIO', 'id: 3<br/>usuario: MMAMANI<br/>nombre: MARIA<br/>paterno: MAMANI<br/>materno: MAMANI<br/>tipo: CAJERO<br/>foto: <br/>password: $2y$10$OXGvRuXBIIOwMqJi4bvojuQEMYifzjbD7brvcynYdoEn16DltW94C<br/>acceso: 1<br/>fecha_registro: 2023-11-22<br/>created_at: 2023-11-22 10:59:26<br/>updated_at: 2023-11-22 10:59:26<br/>', NULL, 'USUARIOS', '2023-11-22', '11:00:10', '2023-11-22 15:00:10', '2023-11-22 15:00:10'),
(8, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN CLIENTE', 'id: 1<br/>nombre: MARCOS<br/>segundo_nombre: <br/>paterno: GONZALES<br/>materno: GONZALES<br/>dir: LOS OLIVOS<br/>ci: 1111<br/>ci_exp: LP<br/>cel: 777777<br/>fono: <br/>edad: 24<br/>referencia: JUAN PERES<br/>cel_ref: 666666<br/>parentesco: HERMANO<br/>fecha_registro: 2023-11-22<br/>created_at: 2023-11-22 11:29:58<br/>updated_at: 2023-11-22 11:29:58<br/>', NULL, 'CLIENTES', '2023-11-22', '11:29:58', '2023-11-22 15:29:58', '2023-11-22 15:29:58'),
(9, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN CLIENTE', 'id: 1<br/>nombre: MARCOS<br/>segundo_nombre: <br/>paterno: GONZALES<br/>materno: GONZALES<br/>dir: LOS OLIVOS<br/>ci: 1111<br/>ci_exp: LP<br/>cel: 777777<br/>fono: <br/>edad: 24<br/>referencia: JUAN PERES<br/>cel_ref: 666666<br/>parentesco: HERMANO<br/>fecha_registro: 2023-11-22<br/>created_at: 2023-11-22 11:29:58<br/>updated_at: 2023-11-22 11:29:58<br/>', 'id: 1<br/>nombre: MARCOS<br/>segundo_nombre: ASD<br/>paterno: GONZALES<br/>materno: GONZALES<br/>dir: LOS OLIVOS<br/>ci: 1111<br/>ci_exp: LP<br/>cel: 777777<br/>fono: <br/>edad: 24<br/>referencia: JUAN PERES<br/>cel_ref: 666666<br/>parentesco: HERMANO<br/>fecha_registro: 2023-11-22<br/>created_at: 2023-11-22 11:29:58<br/>updated_at: 2023-11-22 11:33:17<br/>', 'CLIENTES', '2023-11-22', '11:33:17', '2023-11-22 15:33:17', '2023-11-22 15:33:17'),
(10, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN CLIENTE', 'id: 1<br/>nombre: MARCOS<br/>segundo_nombre: ASD<br/>paterno: GONZALES<br/>materno: GONZALES<br/>dir: LOS OLIVOS<br/>ci: 1111<br/>ci_exp: LP<br/>cel: 777777<br/>fono: <br/>edad: 24<br/>referencia: JUAN PERES<br/>cel_ref: 666666<br/>parentesco: HERMANO<br/>fecha_registro: 2023-11-22<br/>created_at: 2023-11-22 11:29:58<br/>updated_at: 2023-11-22 11:33:17<br/>', 'id: 1<br/>nombre: MARCOS<br/>segundo_nombre: <br/>paterno: GONZALES<br/>materno: GONZALES<br/>dir: LOS OLIVOS<br/>ci: 1111<br/>ci_exp: LP<br/>cel: 777777<br/>fono: <br/>edad: 24<br/>referencia: JUAN PERES<br/>cel_ref: 666666<br/>parentesco: HERMANO<br/>fecha_registro: 2023-11-22<br/>created_at: 2023-11-22 11:29:58<br/>updated_at: 2023-11-22 11:33:57<br/>', 'CLIENTES', '2023-11-22', '11:33:57', '2023-11-22 15:33:57', '2023-11-22 15:33:57'),
(11, 1, 'ELIMINACIÓN', 'EL USUARIO  ELIMINÓ UN CLIENTE', 'id: 1<br/>nombre: MARCOS<br/>segundo_nombre: <br/>paterno: GONZALES<br/>materno: GONZALES<br/>dir: LOS OLIVOS<br/>ci: 1111<br/>ci_exp: LP<br/>cel: 777777<br/>fono: <br/>edad: 24<br/>referencia: JUAN PERES<br/>cel_ref: 666666<br/>parentesco: HERMANO<br/>fecha_registro: 2023-11-22<br/>created_at: 2023-11-22 11:29:58<br/>updated_at: 2023-11-22 11:33:57<br/>', NULL, 'CLIENTES', '2023-11-22', '11:34:28', '2023-11-22 15:34:28', '2023-11-22 15:34:28'),
(12, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN CLIENTE', 'id: 1<br/>nombre: LUIS<br/>segundo_nombre: ALBERTO<br/>paterno: GONZALES<br/>materno: <br/>dir: LOS OLIVOS<br/>ci: 1111<br/>ci_exp: LP<br/>cel: 666666<br/>fono: <br/>edad: 26<br/>referencia: MARIO GONZALES<br/>cel_ref: 666666<br/>parentesco: HERMANO<br/>fecha_registro: 2023-11-22<br/>created_at: 2023-11-22 12:58:18<br/>updated_at: 2023-11-22 12:58:18<br/>', NULL, 'CLIENTES', '2023-11-22', '12:58:18', '2023-11-22 16:58:18', '2023-11-22 16:58:18');

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
(11, '2023_11_21_143314_create_caja_movimientos_table', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pagos`
--

CREATE TABLE `pagos` (
  `id` bigint UNSIGNED NOT NULL,
  `prestamo_id` bigint UNSIGNED NOT NULL,
  `cliente_id` bigint UNSIGNED NOT NULL,
  `nro_cuota` int NOT NULL,
  `monto` decimal(24,2) NOT NULL,
  `monto_mora` decimal(24,2) DEFAULT NULL,
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
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
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
  `cancelado` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_pago` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `prestamos`
--

CREATE TABLE `prestamos` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `cliente_id` bigint UNSIGNED NOT NULL,
  `tipo` varchar(155) COLLATE utf8mb4_unicode_ci NOT NULL,
  `grupo_id` bigint UNSIGNED DEFAULT NULL,
  `monto` decimal(24,2) NOT NULL,
  `plazo` int NOT NULL DEFAULT '12',
  `f_ci` int NOT NULL,
  `f_luz` int NOT NULL,
  `f_agua` int NOT NULL,
  `croquis` int NOT NULL,
  `documento_1` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `documento_2` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `documento_3` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `documento_4` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estado` varchar(155) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_registro` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `usuario` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `paterno` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `materno` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tipo` enum('ADMINISTRADOR','GERENTE','CAJERO','OFICIAL DE CRÉDITO') COLLATE utf8mb4_unicode_ci NOT NULL,
  `foto` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `acceso` int NOT NULL,
  `fecha_registro` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `usuario`, `nombre`, `paterno`, `materno`, `tipo`, `foto`, `password`, `acceso`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'admin', 'admin', NULL, 'ADMINISTRADOR', NULL, '$2y$10$wuTuUildBSgVYfvHomvXWuVLF6T1PWByEZJelnC9LOSQ/Xwcw2N3S', 1, '2023-11-20', NULL, NULL),
(2, 'JPERES', 'JUAN', 'PERES', 'MAMANI', 'CAJERO', NULL, '', 1, '2023-11-22', '2023-11-22 14:57:15', '2023-11-22 14:59:58');

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
-- Indices de la tabla `grupos`
--
ALTER TABLE `grupos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `grupos_nombre_unique` (`nombre`);

--
-- Indices de la tabla `historial_accions`
--
ALTER TABLE `historial_accions`
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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `caja_movimientos`
--
ALTER TABLE `caja_movimientos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `configuracions`
--
ALTER TABLE `configuracions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `grupos`
--
ALTER TABLE `grupos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `historial_accions`
--
ALTER TABLE `historial_accions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `prestamos`
--
ALTER TABLE `prestamos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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
