-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 16, 2023 at 12:16 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `maqpro`
--

-- --------------------------------------------------------

--
-- Table structure for table `herramienta`
--

CREATE TABLE `herramienta` (
  `medida` varchar(255) NOT NULL,
  `codigo` varchar(255) NOT NULL,
  `cantidad` int(11) NOT NULL DEFAULT 0,
  `ultimaFecha` date NOT NULL,
  `tipo` varchar(255) NOT NULL,
  `isCarburo` tinyint(1) DEFAULT NULL,
  `bola-flat` varchar(255) DEFAULT NULL,
  `filos` int(11) DEFAULT NULL,
  `nombreHerramienta` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `herramienta`
--

INSERT INTO `herramienta` (`medida`, `codigo`, `cantidad`, `ultimaFecha`, `tipo`, `isCarburo`, `bola-flat`, `filos`, `nombreHerramienta`) VALUES
('1/4', 'BE1/4', 10, '2023-11-15', 'Estandar', 0, 'bola', 4, 'Broca'),
('2mm', 'CCBE2', 20, '2023-11-15', 'Estandar', 1, 'Bola', 4, 'Cortador');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `herramienta`
--
ALTER TABLE `herramienta`
  ADD PRIMARY KEY (`codigo`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
