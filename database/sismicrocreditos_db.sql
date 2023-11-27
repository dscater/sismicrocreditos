-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 27-11-2023 a las 16:32:20
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
(1, 'Pago por Cuotas', -9532.80, NULL, '2023-11-27 16:14:38'),
(2, 'Gastos Administrativos', 0.00, NULL, '2023-11-27 16:14:38'),
(3, 'Cargos por Multa', 0.00, NULL, '2023-11-27 16:14:38'),
(4, 'Intereses', 73.50, NULL, '2023-11-27 16:14:38');

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
  `prestamo_id` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `caja_movimientos`
--

INSERT INTO `caja_movimientos` (`id`, `caja_id`, `user_id`, `monto`, `tipo`, `glosa`, `prestamo_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 6000.00, 'DEBITO', 'DESEMBOLSO', 2, '2023-11-23 15:55:22', '2023-11-23 15:55:22'),
(2, 1, 1, 4000.00, 'DEBITO', 'DESEMBOLSO', 1, '2023-11-24 02:44:24', '2023-11-24 02:44:24'),
(3, 1, 1, 467.20, 'CRÉDITO', 'PAGO CUOTA PRESTAMO', 2, '2023-11-27 16:14:38', '2023-11-27 16:14:38'),
(4, 4, 1, 73.50, 'CRÉDITO', 'INTERES', 2, '2023-11-27 16:14:38', '2023-11-27 16:14:38');

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
(3, 'JUAN', 'LUIS', 'CONDORI', 'CONDORI', 'LOS OLIVOS', '2222', 'LP', '777777', '222222', 26, 'EDUARDO CONDORI', '6666666', 'PADRE', '2023-11-23', '2023-11-23 13:05:08', '2023-11-23 13:05:08');

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
-- Estructura de tabla para la tabla `grupos`
--

CREATE TABLE `grupos` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
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
(12, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN CLIENTE', 'id: 1<br/>nombre: LUIS<br/>segundo_nombre: ALBERTO<br/>paterno: GONZALES<br/>materno: <br/>dir: LOS OLIVOS<br/>ci: 1111<br/>ci_exp: LP<br/>cel: 666666<br/>fono: <br/>edad: 26<br/>referencia: MARIO GONZALES<br/>cel_ref: 666666<br/>parentesco: HERMANO<br/>fecha_registro: 2023-11-22<br/>created_at: 2023-11-22 12:58:18<br/>updated_at: 2023-11-22 12:58:18<br/>', NULL, 'CLIENTES', '2023-11-22', '12:58:18', '2023-11-22 16:58:18', '2023-11-22 16:58:18'),
(13, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PRESTAMO', 'id: 1<br/>user_id: 1<br/>cliente_id: 3<br/>tipo: INDIVIDUAL<br/>grupo_id: <br/>monto: 4000<br/>plazo: 12<br/>f_ci: 1<br/>f_luz: 1<br/>f_agua: 1<br/>croquis: 1<br/>documento_1: documentos de vehiculo<br/>documento_2: <br/>documento_3: <br/>documento_4: <br/>estado: PRE APROBADO<br/>fecha_registro: 2023-11-23<br/>created_at: 2023-11-23 09:05:08<br/>updated_at: 2023-11-23 09:05:08<br/>', NULL, 'PRESTAMOS', '2023-11-23', '09:05:08', '2023-11-23 13:05:08', '2023-11-23 13:05:08'),
(14, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PRESTAMO', 'id: 2<br/>user_id: 1<br/>cliente_id: 1<br/>tipo: INDIVIDUAL<br/>grupo_id: <br/>monto: 6000<br/>plazo: 12<br/>f_ci: 1<br/>f_luz: 1<br/>f_agua: 1<br/>croquis: 1<br/>documento_1: documentos de vehiculo<br/>documento_2: documento 2<br/>documento_3: documento #3<br/>documento_4: doc. #4<br/>estado: PRE APROBADO<br/>fecha_registro: 2023-11-23<br/>created_at: 2023-11-23 09:08:00<br/>updated_at: 2023-11-23 09:08:00<br/>', NULL, 'PRESTAMOS', '2023-11-23', '09:08:00', '2023-11-23 13:08:00', '2023-11-23 13:08:00'),
(16, 1, 'MODIFICACIÓN', 'EL USUARIO admin APROBO UN PRÉSTAMO', 'id: 2<br/>user_id: 1<br/>cliente_id: 1<br/>tipo: INDIVIDUAL<br/>grupo_id: <br/>monto: 6000.00<br/>plazo: 12<br/>f_ci: 1<br/>f_luz: 1<br/>f_agua: 1<br/>croquis: 1<br/>documento_1: documentos de vehiculo<br/>documento_2: documento 2<br/>documento_3: documento #3<br/>documento_4: doc. #4<br/>estado: PRE APROBADO<br/>desembolso: 0<br/>finalizado: 0<br/>fecha_desembolso: <br/>fecha_registro: 2023-11-23<br/>created_at: 2023-11-23 09:08:00<br/>updated_at: 2023-11-23 09:08:00<br/>', 'id: 2<br/>user_id: 1<br/>cliente_id: 1<br/>tipo: INDIVIDUAL<br/>grupo_id: <br/>monto: 6000.00<br/>plazo: 12<br/>f_ci: 1<br/>f_luz: 1<br/>f_agua: 1<br/>croquis: 1<br/>documento_1: documentos de vehiculo<br/>documento_2: documento 2<br/>documento_3: documento #3<br/>documento_4: doc. #4<br/>estado: APROBADO<br/>desembolso: 0<br/>finalizado: 0<br/>fecha_desembolso: <br/>fecha_registro: 2023-11-23<br/>created_at: 2023-11-23 09:08:00<br/>updated_at: 2023-11-23 09:58:07<br/>', 'PRESTAMOS', '2023-11-23', '09:58:07', '2023-11-23 13:58:07', '2023-11-23 13:58:07'),
(17, 1, 'MODIFICACIÓN', 'EL USUARIO admin RECHAZO UN PRÉSTAMO', 'id: 2<br/>user_id: 1<br/>cliente_id: 1<br/>tipo: INDIVIDUAL<br/>grupo_id: <br/>monto: 6000.00<br/>plazo: 12<br/>f_ci: 1<br/>f_luz: 1<br/>f_agua: 1<br/>croquis: 1<br/>documento_1: documentos de vehiculo<br/>documento_2: documento 2<br/>documento_3: documento #3<br/>documento_4: doc. #4<br/>estado: APROBADO<br/>desembolso: 0<br/>finalizado: 0<br/>fecha_desembolso: <br/>fecha_registro: 2023-11-23<br/>created_at: 2023-11-23 09:08:00<br/>updated_at: 2023-11-23 09:58:07<br/>', 'id: 2<br/>user_id: 1<br/>cliente_id: 1<br/>tipo: INDIVIDUAL<br/>grupo_id: <br/>monto: 6000.00<br/>plazo: 12<br/>f_ci: 1<br/>f_luz: 1<br/>f_agua: 1<br/>croquis: 1<br/>documento_1: documentos de vehiculo<br/>documento_2: documento 2<br/>documento_3: documento #3<br/>documento_4: doc. #4<br/>estado: RECHAZADO<br/>desembolso: 0<br/>finalizado: 0<br/>fecha_desembolso: <br/>fecha_registro: 2023-11-23<br/>created_at: 2023-11-23 09:08:00<br/>updated_at: 2023-11-23 10:20:07<br/>', 'PRESTAMOS', '2023-11-23', '10:20:07', '2023-11-23 14:20:07', '2023-11-23 14:20:07'),
(18, 1, 'MODIFICACIÓN', 'EL USUARIO admin RECHAZO UN PRÉSTAMO', 'id: 2<br/>user_id: 1<br/>cliente_id: 1<br/>tipo: INDIVIDUAL<br/>grupo_id: <br/>monto: 6000.00<br/>plazo: 12<br/>f_ci: 1<br/>f_luz: 1<br/>f_agua: 1<br/>croquis: 1<br/>documento_1: documentos de vehiculo<br/>documento_2: documento 2<br/>documento_3: documento #3<br/>documento_4: doc. #4<br/>estado: RECHAZADO<br/>desembolso: 0<br/>finalizado: 0<br/>fecha_desembolso: <br/>fecha_registro: 2023-11-23<br/>created_at: 2023-11-23 09:08:00<br/>updated_at: 2023-11-23 10:20:07<br/>', 'id: 2<br/>user_id: 1<br/>cliente_id: 1<br/>tipo: INDIVIDUAL<br/>grupo_id: <br/>monto: 6000.00<br/>plazo: 12<br/>f_ci: 1<br/>f_luz: 1<br/>f_agua: 1<br/>croquis: 1<br/>documento_1: documentos de vehiculo<br/>documento_2: documento 2<br/>documento_3: documento #3<br/>documento_4: doc. #4<br/>estado: RECHAZADO<br/>desembolso: 0<br/>finalizado: 0<br/>fecha_desembolso: <br/>fecha_registro: 2023-11-23<br/>created_at: 2023-11-23 09:08:00<br/>updated_at: 2023-11-23 10:20:07<br/>', 'PRESTAMOS', '2023-11-23', '10:21:16', '2023-11-23 14:21:16', '2023-11-23 14:21:16'),
(19, 1, 'MODIFICACIÓN', 'EL USUARIO admin RECHAZO UN PRÉSTAMO', 'id: 2<br/>user_id: 1<br/>cliente_id: 1<br/>tipo: INDIVIDUAL<br/>grupo_id: <br/>monto: 6000.00<br/>plazo: 12<br/>f_ci: 1<br/>f_luz: 1<br/>f_agua: 1<br/>croquis: 1<br/>documento_1: documentos de vehiculo<br/>documento_2: documento 2<br/>documento_3: documento #3<br/>documento_4: doc. #4<br/>estado: RECHAZADO<br/>desembolso: 0<br/>finalizado: 0<br/>fecha_desembolso: <br/>fecha_registro: 2023-11-23<br/>created_at: 2023-11-23 09:08:00<br/>updated_at: 2023-11-23 10:20:07<br/>', 'id: 2<br/>user_id: 1<br/>cliente_id: 1<br/>tipo: INDIVIDUAL<br/>grupo_id: <br/>monto: 6000.00<br/>plazo: 12<br/>f_ci: 1<br/>f_luz: 1<br/>f_agua: 1<br/>croquis: 1<br/>documento_1: documentos de vehiculo<br/>documento_2: documento 2<br/>documento_3: documento #3<br/>documento_4: doc. #4<br/>estado: RECHAZADO<br/>desembolso: 0<br/>finalizado: 0<br/>fecha_desembolso: <br/>fecha_registro: 2023-11-23<br/>created_at: 2023-11-23 09:08:00<br/>updated_at: 2023-11-23 10:20:07<br/>', 'PRESTAMOS', '2023-11-23', '10:21:40', '2023-11-23 14:21:40', '2023-11-23 14:21:40'),
(20, 1, 'MODIFICACIÓN', 'EL USUARIO admin APROBO UN PRÉSTAMO', 'id: 2<br/>user_id: 1<br/>cliente_id: 1<br/>tipo: INDIVIDUAL<br/>grupo_id: <br/>monto: 6000.00<br/>plazo: 12<br/>f_ci: 1<br/>f_luz: 1<br/>f_agua: 1<br/>croquis: 1<br/>documento_1: documentos de vehiculo<br/>documento_2: documento 2<br/>documento_3: documento #3<br/>documento_4: doc. #4<br/>estado: RECHAZADO<br/>desembolso: 0<br/>finalizado: 0<br/>fecha_desembolso: <br/>fecha_registro: 2023-11-23<br/>created_at: 2023-11-23 09:08:00<br/>updated_at: 2023-11-23 10:20:07<br/>', 'id: 2<br/>user_id: 1<br/>cliente_id: 1<br/>tipo: INDIVIDUAL<br/>grupo_id: <br/>monto: 6000.00<br/>plazo: 12<br/>f_ci: 1<br/>f_luz: 1<br/>f_agua: 1<br/>croquis: 1<br/>documento_1: documentos de vehiculo<br/>documento_2: documento 2<br/>documento_3: documento #3<br/>documento_4: doc. #4<br/>estado: APROBADO<br/>desembolso: 0<br/>finalizado: 0<br/>fecha_desembolso: 2023-11-27<br/>fecha_registro: 2023-11-23<br/>created_at: 2023-11-23 09:08:00<br/>updated_at: 2023-11-23 10:25:01<br/>', 'PRESTAMOS', '2023-11-23', '10:25:01', '2023-11-23 14:25:01', '2023-11-23 14:25:01'),
(21, 1, 'MODIFICACIÓN', 'EL USUARIO admin APROBO UN PRÉSTAMO', 'id: 2<br/>user_id: 1<br/>cliente_id: 1<br/>tipo: INDIVIDUAL<br/>grupo_id: <br/>monto: 6000.00<br/>plazo: 12<br/>f_ci: 1<br/>f_luz: 1<br/>f_agua: 1<br/>croquis: 1<br/>documento_1: documentos de vehiculo<br/>documento_2: documento 2<br/>documento_3: documento #3<br/>documento_4: doc. #4<br/>estado: APROBADO<br/>desembolso: 0<br/>finalizado: 0<br/>fecha_desembolso: 2023-11-27<br/>fecha_registro: 2023-11-23<br/>created_at: 2023-11-23 09:08:00<br/>updated_at: 2023-11-23 10:25:01<br/>', 'id: 2<br/>user_id: 1<br/>cliente_id: 1<br/>tipo: INDIVIDUAL<br/>grupo_id: <br/>monto: 6000.00<br/>plazo: 12<br/>f_ci: 1<br/>f_luz: 1<br/>f_agua: 1<br/>croquis: 1<br/>documento_1: documentos de vehiculo<br/>documento_2: documento 2<br/>documento_3: documento #3<br/>documento_4: doc. #4<br/>estado: APROBADO<br/>desembolso: 0<br/>finalizado: 0<br/>fecha_desembolso: 2023-11-27<br/>fecha_registro: 2023-11-23<br/>created_at: 2023-11-23 09:08:00<br/>updated_at: 2023-11-23 10:25:01<br/>', 'PRESTAMOS', '2023-11-23', '10:25:32', '2023-11-23 14:25:32', '2023-11-23 14:25:32'),
(22, 1, 'MODIFICACIÓN', 'EL USUARIO admin RECHAZO UN PRÉSTAMO', 'id: 2<br/>user_id: 1<br/>cliente_id: 1<br/>tipo: INDIVIDUAL<br/>grupo_id: <br/>monto: 6000.00<br/>plazo: 12<br/>f_ci: 1<br/>f_luz: 1<br/>f_agua: 1<br/>croquis: 1<br/>documento_1: documentos de vehiculo<br/>documento_2: documento 2<br/>documento_3: documento #3<br/>documento_4: doc. #4<br/>estado: APROBADO<br/>desembolso: 0<br/>finalizado: 0<br/>fecha_desembolso: 2023-11-27<br/>fecha_registro: 2023-11-23<br/>created_at: 2023-11-23 09:08:00<br/>updated_at: 2023-11-23 10:25:01<br/>', 'id: 2<br/>user_id: 1<br/>cliente_id: 1<br/>tipo: INDIVIDUAL<br/>grupo_id: <br/>monto: 6000.00<br/>plazo: 12<br/>f_ci: 1<br/>f_luz: 1<br/>f_agua: 1<br/>croquis: 1<br/>documento_1: documentos de vehiculo<br/>documento_2: documento 2<br/>documento_3: documento #3<br/>documento_4: doc. #4<br/>estado: RECHAZADO<br/>desembolso: 0<br/>finalizado: 0<br/>fecha_desembolso: 2023-11-27<br/>fecha_registro: 2023-11-23<br/>created_at: 2023-11-23 09:08:00<br/>updated_at: 2023-11-23 10:27:28<br/>', 'PRESTAMOS', '2023-11-23', '10:27:28', '2023-11-23 14:27:28', '2023-11-23 14:27:28'),
(23, 1, 'MODIFICACIÓN', 'EL USUARIO admin APROBO UN PRÉSTAMO', 'id: 2<br/>user_id: 1<br/>cliente_id: 1<br/>tipo: INDIVIDUAL<br/>grupo_id: <br/>monto: 6000.00<br/>plazo: 12<br/>f_ci: 1<br/>f_luz: 1<br/>f_agua: 1<br/>croquis: 1<br/>documento_1: documentos de vehiculo<br/>documento_2: documento 2<br/>documento_3: documento #3<br/>documento_4: doc. #4<br/>estado: RECHAZADO<br/>desembolso: 0<br/>finalizado: 0<br/>fecha_desembolso: 2023-11-27<br/>fecha_registro: 2023-11-23<br/>created_at: 2023-11-23 09:08:00<br/>updated_at: 2023-11-23 10:27:28<br/>', 'id: 2<br/>user_id: 1<br/>cliente_id: 1<br/>tipo: INDIVIDUAL<br/>grupo_id: <br/>monto: 6000.00<br/>plazo: 12<br/>f_ci: 1<br/>f_luz: 1<br/>f_agua: 1<br/>croquis: 1<br/>documento_1: documentos de vehiculo<br/>documento_2: documento 2<br/>documento_3: documento #3<br/>documento_4: doc. #4<br/>estado: APROBADO<br/>desembolso: 0<br/>finalizado: 0<br/>fecha_desembolso: 2023-11-27<br/>fecha_registro: 2023-11-23<br/>created_at: 2023-11-23 09:08:00<br/>updated_at: 2023-11-23 10:27:35<br/>', 'PRESTAMOS', '2023-11-23', '10:27:35', '2023-11-23 14:27:35', '2023-11-23 14:27:35'),
(24, 1, 'MODIFICACIÓN', 'EL USUARIO admin RECHAZO UN PRÉSTAMO', 'id: 2<br/>user_id: 1<br/>cliente_id: 1<br/>tipo: INDIVIDUAL<br/>grupo_id: <br/>monto: 6000.00<br/>plazo: 12<br/>f_ci: 1<br/>f_luz: 1<br/>f_agua: 1<br/>croquis: 1<br/>documento_1: documentos de vehiculo<br/>documento_2: documento 2<br/>documento_3: documento #3<br/>documento_4: doc. #4<br/>estado: APROBADO<br/>desembolso: 0<br/>finalizado: 0<br/>fecha_desembolso: 2023-11-27<br/>fecha_registro: 2023-11-23<br/>created_at: 2023-11-23 09:08:00<br/>updated_at: 2023-11-23 10:27:35<br/>', 'id: 2<br/>user_id: 1<br/>cliente_id: 1<br/>tipo: INDIVIDUAL<br/>grupo_id: <br/>monto: 6000.00<br/>plazo: 12<br/>f_ci: 1<br/>f_luz: 1<br/>f_agua: 1<br/>croquis: 1<br/>documento_1: documentos de vehiculo<br/>documento_2: documento 2<br/>documento_3: documento #3<br/>documento_4: doc. #4<br/>estado: RECHAZADO<br/>desembolso: 0<br/>finalizado: 0<br/>fecha_desembolso: 2023-11-27<br/>fecha_registro: 2023-11-23<br/>created_at: 2023-11-23 09:08:00<br/>updated_at: 2023-11-23 11:12:03<br/>', 'PRESTAMOS', '2023-11-23', '11:12:03', '2023-11-23 15:12:03', '2023-11-23 15:12:03'),
(25, 1, 'MODIFICACIÓN', 'EL USUARIO admin APROBO UN PRÉSTAMO', 'id: 2<br/>user_id: 1<br/>cliente_id: 1<br/>tipo: INDIVIDUAL<br/>grupo_id: <br/>monto: 6000.00<br/>plazo: 12<br/>f_ci: 1<br/>f_luz: 1<br/>f_agua: 1<br/>croquis: 1<br/>documento_1: documentos de vehiculo<br/>documento_2: documento 2<br/>documento_3: documento #3<br/>documento_4: doc. #4<br/>estado: RECHAZADO<br/>desembolso: 0<br/>finalizado: 0<br/>fecha_desembolso: 2023-11-27<br/>fecha_registro: 2023-11-23<br/>created_at: 2023-11-23 09:08:00<br/>updated_at: 2023-11-23 11:12:03<br/>', 'id: 2<br/>user_id: 1<br/>cliente_id: 1<br/>tipo: INDIVIDUAL<br/>grupo_id: <br/>monto: 6000.00<br/>plazo: 12<br/>f_ci: 1<br/>f_luz: 1<br/>f_agua: 1<br/>croquis: 1<br/>documento_1: documentos de vehiculo<br/>documento_2: documento 2<br/>documento_3: documento #3<br/>documento_4: doc. #4<br/>estado: APROBADO<br/>desembolso: 0<br/>finalizado: 0<br/>fecha_desembolso: 2023-11-24<br/>fecha_registro: 2023-11-23<br/>created_at: 2023-11-23 09:08:00<br/>updated_at: 2023-11-23 11:12:15<br/>', 'PRESTAMOS', '2023-11-23', '11:12:15', '2023-11-23 15:12:15', '2023-11-23 15:12:15'),
(26, 1, 'MODIFICACIÓN', 'EL USUARIO admin REALIZÓ EL DESEMBOLSO DE UN PRESTAMO', 'id: 2<br/>user_id: 1<br/>cliente_id: 1<br/>tipo: INDIVIDUAL<br/>grupo_id: <br/>monto: 6000.00<br/>plazo: 12<br/>f_ci: 1<br/>f_luz: 1<br/>f_agua: 1<br/>croquis: 1<br/>documento_1: documentos de vehiculo<br/>documento_2: documento 2<br/>documento_3: documento #3<br/>documento_4: doc. #4<br/>estado: APROBADO<br/>desembolso: 0<br/>finalizado: 0<br/>fecha_desembolso: 2023-11-23<br/>fecha_registro: 2023-11-23<br/>created_at: 2023-11-23 09:08:00<br/>updated_at: 2023-11-23 11:12:15<br/>', 'id: 2<br/>user_id: 1<br/>cliente_id: 1<br/>tipo: INDIVIDUAL<br/>grupo_id: <br/>monto: 6000.00<br/>plazo: 12<br/>f_ci: 1<br/>f_luz: 1<br/>f_agua: 1<br/>croquis: 1<br/>documento_1: documentos de vehiculo<br/>documento_2: documento 2<br/>documento_3: documento #3<br/>documento_4: doc. #4<br/>estado: APROBADO<br/>desembolso: 1<br/>finalizado: 0<br/>fecha_desembolso: 2023-11-23<br/>fecha_registro: 2023-11-23<br/>created_at: 2023-11-23 09:08:00<br/>updated_at: 2023-11-23 11:52:28<br/>', 'PRESTAMOS', '2023-11-23', '11:52:28', '2023-11-23 15:52:28', '2023-11-23 15:52:28'),
(27, 1, 'MODIFICACIÓN', 'EL USUARIO admin REALIZÓ EL DESEMBOLSO DE UN PRESTAMO', 'id: 2<br/>user_id: 1<br/>cliente_id: 1<br/>tipo: INDIVIDUAL<br/>grupo_id: <br/>monto: 6000.00<br/>plazo: 12<br/>f_ci: 1<br/>f_luz: 1<br/>f_agua: 1<br/>croquis: 1<br/>documento_1: documentos de vehiculo<br/>documento_2: documento 2<br/>documento_3: documento #3<br/>documento_4: doc. #4<br/>estado: APROBADO<br/>desembolso: 0<br/>finalizado: 0<br/>fecha_desembolso: 2023-11-23<br/>fecha_registro: 2023-11-23<br/>created_at: 2023-11-23 09:08:00<br/>updated_at: 2023-11-23 11:52:28<br/>', 'id: 2<br/>user_id: 1<br/>cliente_id: 1<br/>tipo: INDIVIDUAL<br/>grupo_id: <br/>monto: 6000.00<br/>plazo: 12<br/>f_ci: 1<br/>f_luz: 1<br/>f_agua: 1<br/>croquis: 1<br/>documento_1: documentos de vehiculo<br/>documento_2: documento 2<br/>documento_3: documento #3<br/>documento_4: doc. #4<br/>estado: APROBADO<br/>desembolso: 1<br/>finalizado: 0<br/>fecha_desembolso: 2023-11-23<br/>fecha_registro: 2023-11-23<br/>created_at: 2023-11-23 09:08:00<br/>updated_at: 2023-11-23 11:55:22<br/>', 'PRESTAMOS', '2023-11-23', '11:55:22', '2023-11-23 15:55:22', '2023-11-23 15:55:22'),
(28, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PRESTAMO', 'cliente_id: 3<br/>created_at: 2023-11-23 22:41:18<br/>croquis: 1<br/>desembolso: <br/>documento_1: papeles del coche<br/>documento_2: <br/>documento_3: <br/>documento_4: <br/>estado: PRE APROBADO<br/>f_agua: 1<br/>f_ci: 1<br/>f_luz: 1<br/>fecha_desembolso: <br/>fecha_registro: 2023-11-23<br/>finalizado: <br/>grupo_id: <br/>id: 3<br/>monto: 4000<br/>plazo: 12<br/>tipo: INDIVIDUAL<br/>updated_at: 2023-11-23 22:41:18<br/>user_id: 1<br/>', NULL, 'PRESTAMOS', '2023-11-23', '22:41:18', '2023-11-24 02:41:18', '2023-11-24 02:41:18'),
(29, 1, 'MODIFICACIÓN', 'EL USUARIO admin APROBO UN PRÉSTAMO', 'cliente_id: 3<br/>created_at: 2023-11-23 09:05:08<br/>croquis: 1<br/>desembolso: 0<br/>documento_1: documentos de vehiculo<br/>documento_2: <br/>documento_3: <br/>documento_4: <br/>estado: PRE APROBADO<br/>f_agua: 1<br/>f_ci: 1<br/>f_luz: 1<br/>fecha_desembolso: <br/>fecha_registro: 2023-11-23<br/>finalizado: 0<br/>grupo_id: <br/>id: 1<br/>monto: 4000.00<br/>plazo: 12<br/>tipo: INDIVIDUAL<br/>updated_at: 2023-11-23 09:05:08<br/>user_id: 1<br/>', 'cliente_id: 3<br/>created_at: 2023-11-23 09:05:08<br/>croquis: 1<br/>desembolso: 0<br/>documento_1: documentos de vehiculo<br/>documento_2: <br/>documento_3: <br/>documento_4: <br/>estado: APROBADO<br/>f_agua: 1<br/>f_ci: 1<br/>f_luz: 1<br/>fecha_desembolso: 2023-11-27<br/>fecha_registro: 2023-11-23<br/>finalizado: 0<br/>grupo_id: <br/>id: 1<br/>monto: 4000.00<br/>plazo: 12<br/>tipo: INDIVIDUAL<br/>updated_at: 2023-11-23 22:42:31<br/>user_id: 1<br/>', 'PRESTAMOS', '2023-11-23', '22:42:31', '2023-11-24 02:42:31', '2023-11-24 02:42:31'),
(30, 1, 'MODIFICACIÓN', 'EL USUARIO admin REALIZÓ EL DESEMBOLSO DE UN PRESTAMO', 'cliente_id: 3<br/>created_at: 2023-11-23 09:05:08<br/>croquis: 1<br/>desembolso: 0<br/>documento_1: documentos de vehiculo<br/>documento_2: <br/>documento_3: <br/>documento_4: <br/>estado: APROBADO<br/>f_agua: 1<br/>f_ci: 1<br/>f_luz: 1<br/>fecha_desembolso: 2023-11-23<br/>fecha_registro: 2023-11-23<br/>finalizado: 0<br/>grupo_id: <br/>id: 1<br/>monto: 4000.00<br/>plazo: 12<br/>tipo: INDIVIDUAL<br/>updated_at: 2023-11-23 22:42:31<br/>user_id: 1<br/>', 'cliente_id: 3<br/>created_at: 2023-11-23 09:05:08<br/>croquis: 1<br/>desembolso: 1<br/>documento_1: documentos de vehiculo<br/>documento_2: <br/>documento_3: <br/>documento_4: <br/>estado: APROBADO<br/>f_agua: 1<br/>f_ci: 1<br/>f_luz: 1<br/>fecha_desembolso: 2023-11-23<br/>fecha_registro: 2023-11-23<br/>finalizado: 0<br/>grupo_id: <br/>id: 1<br/>monto: 4000.00<br/>plazo: 12<br/>tipo: INDIVIDUAL<br/>updated_at: 2023-11-23 22:44:24<br/>user_id: 1<br/>', 'PRESTAMOS', '2023-11-23', '22:44:24', '2023-11-24 02:44:24', '2023-11-24 02:44:24'),
(31, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN USUARIO', 'acceso: 1<br/>created_at: 2023-11-22 10:57:15<br/>fecha_registro: 2023-11-22<br/>foto: <br/>id: 2<br/>materno: MAMANI<br/>nombre: JUAN<br/>password: <br/>paterno: PERES<br/>tipo: CAJERO<br/>updated_at: 2023-11-22 10:59:58<br/>usuario: JPERES<br/>', 'acceso: 0<br/>created_at: 2023-11-22 10:57:15<br/>fecha_registro: 2023-11-22<br/>foto: <br/>id: 2<br/>materno: MAMANI<br/>nombre: JUAN<br/>password: <br/>paterno: PERES<br/>tipo: CAJERO<br/>updated_at: 2023-11-23 23:07:19<br/>usuario: JPERES<br/>', 'USUARIOS', '2023-11-23', '23:07:19', '2023-11-24 03:07:19', '2023-11-24 03:07:19'),
(32, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN USUARIO', 'acceso: 0<br/>created_at: 2023-11-22 10:57:15<br/>fecha_registro: 2023-11-22<br/>foto: <br/>id: 2<br/>materno: MAMANI<br/>nombre: JUAN<br/>password: <br/>paterno: PERES<br/>tipo: CAJERO<br/>updated_at: 2023-11-23 23:07:19<br/>usuario: JPERES<br/>', 'acceso: 1<br/>created_at: 2023-11-22 10:57:15<br/>fecha_registro: 2023-11-22<br/>foto: <br/>id: 2<br/>materno: MAMANI<br/>nombre: JUAN<br/>password: <br/>paterno: PERES<br/>tipo: CAJERO<br/>updated_at: 2023-11-23 23:07:47<br/>usuario: JPERES<br/>', 'USUARIOS', '2023-11-23', '23:07:47', '2023-11-24 03:07:47', '2023-11-24 03:07:47'),
(33, 1, 'MODIFICACIÓN', 'EL USUARIO admin REGISTRO EL PAGO DE UN PRESTAMO', 'id: 1<br/>prestamo_id: 2<br/>plan_pago_id: 13<br/>cliente_id: 1<br/>nro_cuota: 1<br/>monto: 467.20<br/>interes: 73.50<br/>dias_mora: -3<br/>monto_mora: 0<br/>monto_total: 540.70<br/>fecha_pago: 2023-11-27<br/>created_at: 2023-11-27 12:14:38<br/>updated_at: 2023-11-27 12:14:38<br/>', NULL, 'PAGOS', '2023-11-27', '12:14:38', '2023-11-27 16:14:38', '2023-11-27 16:14:38');

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
(12, '2023_11_22_233737_create_interes_table', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pagos`
--

CREATE TABLE `pagos` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `prestamo_id` bigint UNSIGNED NOT NULL,
  `plan_pago_id` bigint UNSIGNED NOT NULL,
  `cliente_id` bigint UNSIGNED NOT NULL,
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

INSERT INTO `pagos` (`id`, `user_id`, `prestamo_id`, `plan_pago_id`, `cliente_id`, `nro_cuota`, `monto`, `interes`, `dias_mora`, `monto_mora`, `monto_total`, `fecha_pago`, `created_at`, `updated_at`) VALUES
(1, 1, 2, 13, 1, 1, 467.20, 73.50, -3, 0.00, 540.70, '2023-11-27', '2023-11-27 16:14:38', '2023-11-27 16:14:38');

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
(1, 1, 1, 4000.00, 311.47, 49.00, 3688.53, 360.47, 'NO', '2023-11-30', '2023-11-23 13:05:08', '2023-11-24 02:44:24'),
(2, 1, 2, 3688.53, 315.28, 45.18, 3373.25, 360.47, 'NO', '2023-12-07', '2023-11-23 13:05:08', '2023-11-24 02:44:24'),
(3, 1, 3, 3373.25, 319.14, 41.32, 3054.11, 360.47, 'NO', '2023-12-14', '2023-11-23 13:05:08', '2023-11-24 02:44:24'),
(4, 1, 4, 3054.11, 323.05, 37.41, 2731.06, 360.47, 'NO', '2023-12-21', '2023-11-23 13:05:08', '2023-11-24 02:44:24'),
(5, 1, 5, 2731.06, 327.01, 33.46, 2404.05, 360.47, 'NO', '2023-12-28', '2023-11-23 13:05:08', '2023-11-24 02:44:24'),
(6, 1, 6, 2404.05, 331.02, 29.45, 2073.03, 360.47, 'NO', '2024-01-04', '2023-11-23 13:05:08', '2023-11-24 02:44:24'),
(7, 1, 7, 2073.03, 335.07, 25.39, 1737.96, 360.47, 'NO', '2024-01-11', '2023-11-23 13:05:08', '2023-11-24 02:44:24'),
(8, 1, 8, 1737.96, 339.17, 21.29, 1398.79, 360.47, 'NO', '2024-01-18', '2023-11-23 13:05:08', '2023-11-24 02:44:24'),
(9, 1, 9, 1398.79, 343.33, 17.14, 1055.46, 360.47, 'NO', '2024-01-25', '2023-11-23 13:05:08', '2023-11-24 02:44:24'),
(10, 1, 10, 1055.46, 347.54, 12.93, 707.92, 360.47, 'NO', '2024-02-01', '2023-11-23 13:05:08', '2023-11-24 02:44:24'),
(11, 1, 11, 707.92, 351.79, 8.67, 356.13, 360.47, 'NO', '2024-02-08', '2023-11-23 13:05:08', '2023-11-24 02:44:24'),
(12, 1, 12, 356.13, 356.13, 4.36, 0.00, 360.47, 'NO', '2024-02-15', '2023-11-23 13:05:08', '2023-11-24 02:44:24'),
(13, 2, 1, 6000.00, 467.20, 73.50, 5532.80, 540.70, 'SI', '2023-11-30', '2023-11-23 13:08:00', '2023-11-27 16:14:38'),
(14, 2, 2, 5532.80, 472.92, 67.78, 5059.88, 540.70, 'NO', '2023-12-07', '2023-11-23 13:08:00', '2023-11-23 15:55:22'),
(15, 2, 3, 5059.88, 478.71, 61.98, 4581.17, 540.70, 'NO', '2023-12-14', '2023-11-23 13:08:00', '2023-11-23 15:55:22'),
(16, 2, 4, 4581.17, 484.58, 56.12, 4096.59, 540.70, 'NO', '2023-12-21', '2023-11-23 13:08:00', '2023-11-23 15:55:22'),
(17, 2, 5, 4096.59, 490.51, 50.18, 3606.08, 540.70, 'NO', '2023-12-28', '2023-11-23 13:08:00', '2023-11-23 15:55:22'),
(18, 2, 6, 3606.08, 496.52, 44.17, 3109.56, 540.70, 'NO', '2024-01-04', '2023-11-23 13:08:00', '2023-11-23 15:55:22'),
(19, 2, 7, 3109.56, 502.60, 38.09, 2606.96, 540.70, 'NO', '2024-01-11', '2023-11-23 13:08:00', '2023-11-23 15:55:22'),
(20, 2, 8, 2606.96, 508.76, 31.94, 2098.19, 540.70, 'NO', '2024-01-18', '2023-11-23 13:08:00', '2023-11-23 15:55:22'),
(21, 2, 9, 2098.20, 514.99, 25.70, 1583.20, 540.70, 'NO', '2024-01-25', '2023-11-23 13:08:00', '2023-11-23 15:55:22'),
(22, 2, 10, 1583.21, 521.30, 19.39, 1061.90, 540.70, 'NO', '2024-02-01', '2023-11-23 13:08:00', '2023-11-23 15:55:22'),
(23, 2, 11, 1061.91, 527.69, 13.01, 534.21, 540.70, 'NO', '2024-02-08', '2023-11-23 13:08:00', '2023-11-23 15:55:22'),
(24, 2, 12, 534.22, 534.22, 6.54, 0.00, 540.70, 'NO', '2024-02-15', '2023-11-23 13:08:00', '2023-11-23 15:55:22'),
(25, 3, 1, 4000.00, 311.47, 49.00, 3688.53, 360.47, 'NO', NULL, '2023-11-24 02:41:18', '2023-11-24 02:41:18'),
(26, 3, 2, 3688.53, 315.28, 45.18, 3373.25, 360.47, 'NO', NULL, '2023-11-24 02:41:18', '2023-11-24 02:41:18'),
(27, 3, 3, 3373.25, 319.14, 41.32, 3054.11, 360.47, 'NO', NULL, '2023-11-24 02:41:18', '2023-11-24 02:41:18'),
(28, 3, 4, 3054.11, 323.05, 37.41, 2731.06, 360.47, 'NO', NULL, '2023-11-24 02:41:18', '2023-11-24 02:41:18'),
(29, 3, 5, 2731.06, 327.01, 33.46, 2404.05, 360.47, 'NO', NULL, '2023-11-24 02:41:18', '2023-11-24 02:41:18'),
(30, 3, 6, 2404.05, 331.02, 29.45, 2073.03, 360.47, 'NO', NULL, '2023-11-24 02:41:18', '2023-11-24 02:41:18'),
(31, 3, 7, 2073.03, 335.07, 25.39, 1737.96, 360.47, 'NO', NULL, '2023-11-24 02:41:18', '2023-11-24 02:41:18'),
(32, 3, 8, 1737.96, 339.17, 21.29, 1398.79, 360.47, 'NO', NULL, '2023-11-24 02:41:18', '2023-11-24 02:41:18'),
(33, 3, 9, 1398.79, 343.33, 17.14, 1055.46, 360.47, 'NO', NULL, '2023-11-24 02:41:18', '2023-11-24 02:41:18'),
(34, 3, 10, 1055.46, 347.54, 12.93, 707.92, 360.47, 'NO', NULL, '2023-11-24 02:41:18', '2023-11-24 02:41:18'),
(35, 3, 11, 707.92, 351.79, 8.67, 356.13, 360.47, 'NO', NULL, '2023-11-24 02:41:18', '2023-11-24 02:41:18'),
(36, 3, 12, 356.13, 356.13, 4.36, 0.00, 360.47, 'NO', NULL, '2023-11-24 02:41:18', '2023-11-24 02:41:18');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `prestamos`
--

CREATE TABLE `prestamos` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
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

INSERT INTO `prestamos` (`id`, `user_id`, `cliente_id`, `tipo`, `grupo_id`, `monto`, `plazo`, `f_ci`, `f_luz`, `f_agua`, `croquis`, `documento_1`, `documento_2`, `documento_3`, `documento_4`, `estado`, `desembolso`, `finalizado`, `fecha_desembolso`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(1, 1, 3, 'INDIVIDUAL', NULL, 4000.00, 12, 1, 1, 1, 1, 'documentos de vehiculo', NULL, NULL, NULL, 'APROBADO', 1, 0, '2023-11-23', '2023-11-23', '2023-11-23 13:05:08', '2023-11-24 02:44:24'),
(2, 1, 1, 'INDIVIDUAL', NULL, 6000.00, 12, 1, 1, 1, 1, 'documentos de vehiculo', 'documento 2', 'documento #3', 'doc. #4', 'APROBADO', 1, 0, '2023-11-23', '2023-11-23', '2023-11-23 13:08:00', '2023-11-23 15:55:22'),
(3, 1, 3, 'INDIVIDUAL', NULL, 4000.00, 12, 1, 1, 1, 1, 'papeles del coche', NULL, NULL, NULL, 'PRE APROBADO', 0, 0, NULL, '2023-11-23', '2023-11-24 02:41:18', '2023-11-24 02:41:18');

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

INSERT INTO `users` (`id`, `usuario`, `nombre`, `paterno`, `materno`, `tipo`, `foto`, `password`, `acceso`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'admin', 'admin', NULL, 'ADMINISTRADOR', NULL, '$2y$10$wuTuUildBSgVYfvHomvXWuVLF6T1PWByEZJelnC9LOSQ/Xwcw2N3S', 1, '2023-11-20', NULL, NULL),
(2, 'JPERES', 'JUAN', 'PERES', 'MAMANI', 'CAJERO', NULL, '', 1, '2023-11-22', '2023-11-22 14:57:15', '2023-11-24 03:07:47');

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT de la tabla `interes`
--
ALTER TABLE `interes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `pagos`
--
ALTER TABLE `pagos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

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
