-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 18, 2025 at 02:01 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `retseptiraamatposvystak`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `addKoostis` (IN `kogus` INT, IN `retsept_retsept_id` INT, IN `toiduaine_id` INT, IN `yhik_id` INT)   begin 
select * from koostis;
insert into koostis(kogus,retsept_retsept_id,toiduaine_id,yhik_id)
values(kogus,retsept_retsept_id,toiduaine_id,yhik_id);
select * from koostis;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `addRetsept` (IN `Rnimi` VARCHAR(100), IN `kirjeldus` VARCHAR(200), IN `juhend` VARCHAR(500), IN `sis_kp` DATE, IN `kas_id ` INT, IN `kat_id` INT)   begin
select * from retsept;
insert into retsept(retsepti_nimi, kirjeldus, juhend, 
sisestatud_kp, kasutaja_id,kategooria_id)
values (Rnimi, kirjeldus, juhend, sis_kp, kas_id, kat_id);
select * from retsept;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `addTehtud` (IN `tehtud_kp` INT, IN `retsept_id` INT)   begin 
select * from tehtud;
insert into tehtud(tehtud_kp, retsept_id)
values (tehtud_kp, retsept_id);
select * from tehtud;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `jookid` (IN `jook_id` INT)   begin
select * from soovitatav_jook;
delete from soovitatav_jook Where jook_id=jook_id;
select * from soovitatav_jook;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `lisajookid` (IN `jook_nimi` VARCHAR(50), IN `retsept_id` INT)   begin
select * from soovitatav_jook;
insert into  soovitatav_jook(jook_nimi,retsept_id)
values (jook_nimi,retsept_id);
select * from soovitatav_jook;
end$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `hind`
--

CREATE TABLE `hind` (
  `hind_id` int(11) NOT NULL,
  `retsept_id` int(11) DEFAULT NULL,
  `hind` decimal(3,1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `kasutaja`
--

CREATE TABLE `kasutaja` (
  `kasutaja_id` int(11) NOT NULL,
  `eesnimi` varchar(50) DEFAULT NULL,
  `perenimi` varchar(50) NOT NULL,
  `email` varchar(150) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kasutaja`
--

INSERT INTO `kasutaja` (`kasutaja_id`, `eesnimi`, `perenimi`, `email`) VALUES
(1, 'Kira', 'Kira', 'kira@tthk.ee'),
(2, 'Nikita', 'Nikita', 'nikita@tthk.ee'),
(3, 'Mark', 'Mark', 'mark@tthk.ee'),
(4, 'Roman', 'Roman', '´roman@tthk.ee'),
(5, 'Mariia', 'Mariia', 'mariia@tthk.ee');

-- --------------------------------------------------------

--
-- Table structure for table `kategooria`
--

CREATE TABLE `kategooria` (
  `kategooria_id` int(11) NOT NULL,
  `kategooria_nimi` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kategooria`
--

INSERT INTO `kategooria` (`kategooria_id`, `kategooria_nimi`) VALUES
(1, 'kondiitritooted'),
(2, 'magus'),
(3, 'supid'),
(4, 'röstitud'),
(5, 'salatid');

-- --------------------------------------------------------

--
-- Table structure for table `koostis`
--

CREATE TABLE `koostis` (
  `koostis_id` int(11) NOT NULL,
  `kogus` int(11) DEFAULT NULL,
  `retsept_retsept_id` int(11) DEFAULT NULL,
  `toiduaine_id` int(11) DEFAULT NULL,
  `yhik_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `koostis`
--

INSERT INTO `koostis` (`koostis_id`, `kogus`, `retsept_retsept_id`, `toiduaine_id`, `yhik_id`) VALUES
(1, 3, 1, 1, 1),
(2, 2, 4, 5, 1),
(3, 2, 3, 1, 4),
(4, 1, 5, 2, 3),
(5, 5, 1, 3, 2);

-- --------------------------------------------------------

--
-- Table structure for table `retsept`
--

CREATE TABLE `retsept` (
  `retsept_id` int(11) NOT NULL,
  `retsepti_nimi` varchar(100) DEFAULT NULL,
  `kirjeldus` varchar(200) DEFAULT NULL,
  `juhend` varchar(500) DEFAULT NULL,
  `sisestatud_kp` date DEFAULT NULL,
  `kasutaja_id` int(11) DEFAULT NULL,
  `kategooria_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `retsept`
--

INSERT INTO `retsept` (`retsept_id`, `retsepti_nimi`, `kirjeldus`, `juhend`, `sisestatud_kp`, `kasutaja_id`, `kategooria_id`) VALUES
(1, 'supp', 'maitsev supp', 'keeta koostisained', '2003-01-01', 1, 2),
(2, 'Caesar', 'maitsev salat', 'tükeldage köögivilju', '2008-10-12', 5, 4),
(3, 'Steak', 'maitsev steak', 'praetud liha', '2009-08-21', 2, 3),
(4, 'juustukook', 'maitsev magus', 'segage koostisosad kokku', '2025-10-25', 3, 1),
(5, 'supp', 'maitsev supp', 'keeta koostisained', '2023-12-15', 4, 1);

-- --------------------------------------------------------

--
-- Table structure for table `soovitatav_jook`
--

CREATE TABLE `soovitatav_jook` (
  `jook_id` int(11) NOT NULL,
  `jook_nimi` varchar(50) DEFAULT NULL,
  `retsept_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `soovitatav_jook`
--

INSERT INTO `soovitatav_jook` (`jook_id`, `jook_nimi`, `retsept_id`) VALUES
(1, 'ouzvar', 1),
(2, 'tee', 2),
(3, 'punane vein', 3),
(4, 'kohv', 4),
(5, 'ouzvar', 5);

-- --------------------------------------------------------

--
-- Table structure for table `tehtud`
--

CREATE TABLE `tehtud` (
  `tehtud_id` int(11) NOT NULL,
  `tehtud_kp` date DEFAULT NULL,
  `retsept_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tehtud`
--

INSERT INTO `tehtud` (`tehtud_id`, `tehtud_kp`, `retsept_id`) VALUES
(1, '2023-10-30', 1),
(2, '2015-06-03', 2),
(3, '2018-05-13', 3),
(4, '2020-11-26', 4),
(5, '2021-02-24', 5);

-- --------------------------------------------------------

--
-- Table structure for table `toiduaine`
--

CREATE TABLE `toiduaine` (
  `toiduaine_id` int(11) NOT NULL,
  `toiduaine_nimi` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `toiduaine`
--

INSERT INTO `toiduaine` (`toiduaine_id`, `toiduaine_nimi`) VALUES
(1, 'juust'),
(2, 'liha'),
(3, 'tomatid'),
(4, 'munad'),
(5, 'leivapuru');

-- --------------------------------------------------------

--
-- Table structure for table `yhik`
--

CREATE TABLE `yhik` (
  `yhik_id` int(11) NOT NULL,
  `yhik_nimi` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `yhik`
--

INSERT INTO `yhik` (`yhik_id`, `yhik_nimi`) VALUES
(1, 'ml'),
(2, 'g'),
(3, 'kg'),
(4, 'tl'),
(5, 'sl');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `hind`
--
ALTER TABLE `hind`
  ADD PRIMARY KEY (`hind_id`),
  ADD KEY `retsept_id` (`retsept_id`);

--
-- Indexes for table `kasutaja`
--
ALTER TABLE `kasutaja`
  ADD PRIMARY KEY (`kasutaja_id`);

--
-- Indexes for table `kategooria`
--
ALTER TABLE `kategooria`
  ADD PRIMARY KEY (`kategooria_id`);

--
-- Indexes for table `koostis`
--
ALTER TABLE `koostis`
  ADD PRIMARY KEY (`koostis_id`),
  ADD KEY `retsept_retsept_id` (`retsept_retsept_id`),
  ADD KEY `toiduaine_id` (`toiduaine_id`),
  ADD KEY `yhik_id` (`yhik_id`);

--
-- Indexes for table `retsept`
--
ALTER TABLE `retsept`
  ADD PRIMARY KEY (`retsept_id`),
  ADD KEY `kasutaja_id` (`kasutaja_id`),
  ADD KEY `kategooria_id` (`kategooria_id`);

--
-- Indexes for table `soovitatav_jook`
--
ALTER TABLE `soovitatav_jook`
  ADD PRIMARY KEY (`jook_id`),
  ADD KEY `retsept_id` (`retsept_id`);

--
-- Indexes for table `tehtud`
--
ALTER TABLE `tehtud`
  ADD PRIMARY KEY (`tehtud_id`),
  ADD KEY `retsept_id` (`retsept_id`);

--
-- Indexes for table `toiduaine`
--
ALTER TABLE `toiduaine`
  ADD PRIMARY KEY (`toiduaine_id`);

--
-- Indexes for table `yhik`
--
ALTER TABLE `yhik`
  ADD PRIMARY KEY (`yhik_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `hind`
--
ALTER TABLE `hind`
  MODIFY `hind_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kasutaja`
--
ALTER TABLE `kasutaja`
  MODIFY `kasutaja_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `kategooria`
--
ALTER TABLE `kategooria`
  MODIFY `kategooria_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `koostis`
--
ALTER TABLE `koostis`
  MODIFY `koostis_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `retsept`
--
ALTER TABLE `retsept`
  MODIFY `retsept_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `soovitatav_jook`
--
ALTER TABLE `soovitatav_jook`
  MODIFY `jook_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `tehtud`
--
ALTER TABLE `tehtud`
  MODIFY `tehtud_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `toiduaine`
--
ALTER TABLE `toiduaine`
  MODIFY `toiduaine_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `yhik`
--
ALTER TABLE `yhik`
  MODIFY `yhik_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `hind`
--
ALTER TABLE `hind`
  ADD CONSTRAINT `hind_ibfk_1` FOREIGN KEY (`retsept_id`) REFERENCES `retsept` (`retsept_id`);

--
-- Constraints for table `koostis`
--
ALTER TABLE `koostis`
  ADD CONSTRAINT `koostis_ibfk_1` FOREIGN KEY (`retsept_retsept_id`) REFERENCES `retsept` (`retsept_id`),
  ADD CONSTRAINT `koostis_ibfk_2` FOREIGN KEY (`toiduaine_id`) REFERENCES `toiduaine` (`toiduaine_id`),
  ADD CONSTRAINT `koostis_ibfk_3` FOREIGN KEY (`yhik_id`) REFERENCES `yhik` (`yhik_id`);

--
-- Constraints for table `retsept`
--
ALTER TABLE `retsept`
  ADD CONSTRAINT `retsept_ibfk_1` FOREIGN KEY (`kasutaja_id`) REFERENCES `kasutaja` (`kasutaja_id`),
  ADD CONSTRAINT `retsept_ibfk_2` FOREIGN KEY (`kategooria_id`) REFERENCES `kategooria` (`kategooria_id`);

--
-- Constraints for table `soovitatav_jook`
--
ALTER TABLE `soovitatav_jook`
  ADD CONSTRAINT `soovitatav_jook_ibfk_1` FOREIGN KEY (`retsept_id`) REFERENCES `retsept` (`retsept_id`);

--
-- Constraints for table `tehtud`
--
ALTER TABLE `tehtud`
  ADD CONSTRAINT `tehtud_ibfk_1` FOREIGN KEY (`retsept_id`) REFERENCES `retsept` (`retsept_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
