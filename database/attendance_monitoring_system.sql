-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 28, 2024 at 04:17 PM
-- Server version: 8.0.30
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `attendance_monitoring_system`
--

-- --------------------------------------------------------

--
-- Table structure for table `employee_attendance_department`
--

CREATE TABLE `employee_attendance_department` (
  `attendance_id` int NOT NULL,
  `employee_id` int NOT NULL,
  `attendance_date` datetime NOT NULL,
  `attendance_status` varchar(20) NOT NULL,
  `flag_id` int DEFAULT NULL,
  `department` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `employee_attendance_department`
--

INSERT INTO `employee_attendance_department` (`attendance_id`, `employee_id`, `attendance_date`, `attendance_status`, `flag_id`, `department`) VALUES
(1, 2, '2024-09-04 16:20:00', 'present', 1, 'BSN'),
(2, 2, '2024-11-16 21:38:45', 'absent', 1, 'BSIT'),
(3, 2, '2024-11-22 21:06:43', 'present', 2, 'BSIT'),
(4, 3, '2024-11-22 21:06:49', 'present', 2, 'BSIT'),
(5, 9, '2024-11-22 21:06:53', 'present', 2, 'BSIT');

-- --------------------------------------------------------

--
-- Table structure for table `employee_attendance_flag`
--

CREATE TABLE `employee_attendance_flag` (
  `attendance_id` int NOT NULL,
  `employee_id` int NOT NULL,
  `attendance_date` datetime NOT NULL,
  `attendance_status` varchar(20) NOT NULL,
  `flag_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `employee_attendance_gate`
--

CREATE TABLE `employee_attendance_gate` (
  `attendance_id` int NOT NULL,
  `employee_id` int NOT NULL,
  `entry_time` datetime NOT NULL,
  `entry_type` enum('in','out') NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `attendance_status` int DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `employee_qr_log`
--

CREATE TABLE `employee_qr_log` (
  `log_id` int NOT NULL,
  `employee_id` int NOT NULL,
  `entry_type` enum('in','out') NOT NULL,
  `log_time` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `employee_registration`
--

CREATE TABLE `employee_registration` (
  `employee_id` int NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone_number` varchar(15) DEFAULT NULL,
  `department` varchar(50) DEFAULT NULL,
  `position` varchar(50) DEFAULT NULL,
  `is_admin` tinyint(1) NOT NULL DEFAULT '0',
  `hire_date` date DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `postal_code` varchar(20) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `emergency_contact_name` varchar(100) DEFAULT NULL,
  `emergency_contact_number` varchar(15) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_assigned` tinyint(1) NOT NULL DEFAULT '0',
  `is_assigned_department` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `employee_registration`
--

INSERT INTO `employee_registration` (`employee_id`, `first_name`, `last_name`, `email`, `password`, `phone_number`, `department`, `position`, `is_admin`, `hire_date`, `address`, `city`, `postal_code`, `country`, `date_of_birth`, `gender`, `emergency_contact_name`, `emergency_contact_number`, `created_at`, `updated_at`, `is_assigned`, `is_assigned_department`) VALUES
(2, 'Re Ann', 'Nunez', 'reannsabandal544@gmail.com', '$2y$10$o3.YKXQaRdHjqtSV0Tnqgu1RMXKHs7p19tTS5tI7Siw.Mi.bW3nRq', '09383403973', 'BSIT', 'Employee', 0, '2024-06-07', 'Cambite, Tomas Oppus, Southern Leyte', 'Maasin City', '6605', 'Philippines', '2002-11-10', 'Male', 'Re Ann Nunez', '09383403973', '2024-06-24 12:50:33', '2024-11-16 00:36:36', 1, 1),
(3, 'Rico James', 'Sabandal', 'jamessabandal544@gmail.com', '$2y$10$15d10bryJmLT3bEpP7akTOEEoE9sFMzwCz3vjUQhITwdPrm4uIGsC', '09383403973', 'BSIT', 'Dean', 0, '2024-06-05', 'Tinago, Tomas Oppus, Southern leyte', 'Maasin City', '6605', 'Philippines', '2000-12-18', 'Male', 're ann nunez', '09383403973', '2024-06-24 16:31:46', '2024-11-20 12:32:39', 1, 1),
(4, 'Ryan', 'Nunez', 'ryansabandal544@gmail.com', '$2y$10$uWI7M1XgJ5fwIq0qZrEM3OZVS8o.2TI8NZpjVALVvF5wMH1Dn3Rh.', '09383403973', 'BSN', 'Dean', 0, NULL, 'Cambite, Tomas Oppus, Southern leyte', 'Maasin City', '6605', 'Philippines', '2024-06-20', 'Male', 're ann nunez', '09383403973', '2024-06-25 01:46:44', '2024-11-20 12:32:42', 1, 1),
(5, 'Riche Jim', 'Sabandal', 'richesabandal544@gmail.com', '$2y$10$LbwbWv7PfBJ6xNhWz3OV/.Kyx7nmqnaP2sOzQ7Ci/BXEkpvGI09Lm', '09383403973', 'BSN', 'Dean', 0, NULL, 'Tinago, Tomas Oppus, Southern leyte', 'Maasin City', '6605', 'Philippines', '2024-06-14', 'Male', 'RICO JAMES MAITIM SABANDAL', '09383403973', '2024-06-25 09:39:22', '2024-11-20 12:32:45', 1, 1),
(6, 'admin', 'admin', 'admin@admin', '$2y$10$FiopApI/9wwk.c2.WWeEFeyiEOQaxEY4ZCcen.WdLHSbG0JsEg6Le', 'admin', 'admin', 'admin', 1, NULL, 'admin', 'admin', 'admin', 'admin', '2024-06-25', 'Male', 'admin', 'admin', '2024-06-25 12:00:08', '2024-07-04 02:28:34', 0, 0),
(7, 'Susana', 'Sabandal', 'susanasabanda544l@gmail.com', '$2y$10$YSlUlY9yntBgJnJAVZ5t/eCNkuBYlw6XAhVk9t5PuTygRQOHyy.ry', '09383403973', 'BSMB', 'Manager', 0, NULL, 'Tinago, Tomas Oppus, Southern leyte', 'Maasin City', '6605', 'Philippines', '1978-05-26', 'Female', 'Antero Sabandal', '09383403973', '2024-06-26 10:20:46', '2024-11-20 12:32:47', 1, 1),
(9, 'Roland', 'Nacano', 'jayjaynax152@gmail.com', '$2y$10$oyQ0yVQKPskfrp/zd/gEXuc3ih06OCp4Gi6WPCfaCUt3dRFadruuS', '09559104489', 'BSIT', 'Instructor', 0, NULL, 'Bogo Tomas Oppus Southern Leyte', 'Southern Leyte', '5508', 'Philippines', '2004-03-10', 'Male', 'Roland', '09738926321', '2024-07-04 06:07:15', '2024-11-20 12:32:50', 1, 1),
(10, 'Pearl Princess', 'Sabandal', 'pearlsabandal544@gmail.com', '$2y$10$geI2gLoEKcb1kramBResveO/52bu8QHHib1/Oc8CCUq4ab96r36.a', '09383403973', 'BSFI', 'Employee', 0, NULL, 'Tinago, Tomas Oppus, Southern Leyte', 'Maasin City', '3444', 'Philippines', '2000-12-18', 'Female', 'Re Ann Nunez', '09383403973', '2024-11-16 00:06:00', '2024-11-20 12:32:52', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `flag_type`
--

CREATE TABLE `flag_type` (
  `flag_id` int NOT NULL,
  `flag_type` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `flag_type`
--

INSERT INTO `flag_type` (`flag_id`, `flag_type`) VALUES
(1, 'Flag Raising'),
(2, 'Flag Retreat');

-- --------------------------------------------------------

--
-- Table structure for table `student_attendance_flag`
--

CREATE TABLE `student_attendance_flag` (
  `attendance_id` int NOT NULL,
  `student_id` int NOT NULL,
  `attendance_date` datetime NOT NULL,
  `attendance_status` varchar(20) NOT NULL,
  `flag_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `student_registration`
--

CREATE TABLE `student_registration` (
  `student_id` int NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone_number` varchar(15) DEFAULT NULL,
  `department` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `year_level` int DEFAULT NULL,
  `section` varchar(50) DEFAULT NULL,
  `enrollment_date` date DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `postal_code` varchar(20) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `emergency_contact_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `emergency_contact_number` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_assigned` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `student_registration`
--

INSERT INTO `student_registration` (`student_id`, `first_name`, `last_name`, `email`, `password`, `phone_number`, `department`, `year_level`, `section`, `enrollment_date`, `address`, `city`, `postal_code`, `country`, `date_of_birth`, `gender`, `emergency_contact_name`, `emergency_contact_number`, `created_at`, `updated_at`, `is_assigned`) VALUES
(1597, 'Rico', 'Abenoja', 'abenoja@gmail.com', '$2y$10$bkukNtTGwvh/ODVaOsNh4uAkUQEJifjKXtD1tZ25yys63WDlgZCFO', NULL, 'BAT', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:09', '2024-11-28 13:50:09', 0),
(1598, 'Jhea', 'Ichon', 'ichon@gmail.com', '$2y$10$dpVrSn/AQPn5ROdlUqwhz..VE/aSzyCwGQeCg6itXUGgu1xrisXNe', NULL, 'BAT', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:09', '2024-11-28 13:50:09', 0),
(1599, 'Jhenny Bave', 'Bibera', 'bibera@gmail.com', '$2y$10$K7wmHwcw0KaZSEAQ6g3ar.WK9k348IlsYaL9wmr1WyaupneRLYSGS', NULL, 'BAT', 4, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:09', '2024-11-28 13:50:09', 0),
(1600, 'Marbelyn', 'Sayson', 'sayson@gmail.com', '$2y$10$7wrOAUv2l.jzWDSU0lE5AeOotR5B2lZODaIpwMh3A0dX0uoKV.lVW', NULL, 'BAT', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:09', '2024-11-28 13:50:09', 0),
(1601, 'Joyce', 'Lampong', 'lampong@gmail.com', '$2y$10$aMDwAL.b6y/vX5SLT9TR9OFu5m9Qysd8ZyeOSAa24D3PUxYbQs/.W', NULL, 'BAT', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:09', '2024-11-28 13:50:09', 0),
(1602, 'Cathline', 'Salva', 'salva@gmail.com', '$2y$10$ALxJMlvk.D/.ZgsqGL.eH.zI5F9pskZA7f89H9Qkr9m/WikwRHrAe', NULL, 'BAT', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:09', '2024-11-28 13:50:09', 0),
(1603, 'Analyn', 'Odo', 'odo@gmail.com', '$2y$10$X3JDQaglmPV4b8abMxVVT.lCTNjB9mRH98qsZzRyHR3Z66xtrt11m', NULL, 'BAT', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:09', '2024-11-28 13:50:09', 0),
(1604, 'Frad Enno', 'Ongy', 'ongy@gmail.com', '$2y$10$Ll85X35mZcf1Hlp8XCQ/i.wMs1ov7sdRSRqAA5Hz/fgY5UQcsZeOO', NULL, 'BAT', 4, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:09', '2024-11-28 13:50:09', 0),
(1605, 'Sheila Mae', 'Diva', 'diva@gmail.com', '$2y$10$LbfVF2mkOmnf27GYYe13ROw.vl9RcWGyPLsaSFVRDQqz5Y0FDFpJ2', NULL, 'BAT', 4, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:09', '2024-11-28 13:50:09', 0),
(1606, 'Maylyn', 'Dumangcas', 'dumangcas@gmail.com', '$2y$10$TTC0qub7jR04X97Z7svntu48PHaoQyahPjRjwRa5ETTbVq3GB/f9i', NULL, 'BAT', 4, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:10', '2024-11-28 13:50:10', 0),
(1607, 'Arjay', 'Umapas', 'umapas@gmail.com', '$2y$10$rnJS7lrlP6RGZMcwtv1DkOpMjIWcynPX118Rph28ms6bIQyJS.E.O', NULL, 'BAT', 4, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:10', '2024-11-28 13:50:10', 0),
(1608, 'Alice', 'Malunas', 'malunas@gmail.com', '$2y$10$s6VSI3lG.TLiVR/Pmp.im.2gEt5w8LfVUW3VgUfe05v/zRVSLt1k6', NULL, 'BAT', 4, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:10', '2024-11-28 13:50:10', 0),
(1609, 'Daisy Mae', 'Suarez', 'suarez@gmail.com', '$2y$10$5Nlacde/s5h1z3SUqcFsm.PDuYCLzIdaiO2FMwi8Fo4hm40ih25Hm', NULL, 'BAT', 4, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:10', '2024-11-28 13:50:10', 0),
(1610, 'Lovely', 'Merino', 'merino@gmail.com', '$2y$10$ZK/XCn2JkzYiM79cXMS42OlRN4whurO3BycnKnWmQF7YasK8FRZ8i', NULL, 'BAT', 4, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:10', '2024-11-28 13:50:10', 0),
(1611, 'Charles', 'Vete', 'vete@gmail.com', '$2y$10$Iq2/guBgv8ofOGvmF7Z47O5Q5crkQIq4f2wpzvAQlIb1DT2ZrBX1y', NULL, 'BAT', 4, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:10', '2024-11-28 13:50:10', 0),
(1612, 'Almer Jun', 'Oppus', 'oppus@gmail.com', '$2y$10$y5.RMG8Asb7x4b8KBoBWV.4xVjWlDAKSD9Gm6BsNEJ4KFTorgJYdC', NULL, 'BAT', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:10', '2024-11-28 13:50:10', 0),
(1613, 'Donnafe', 'Pracuelles', 'pracuelles@gmail.com', '$2y$10$Zgw6uPNBPe8ewtebFTr5Ned56a1E1FY4d57YMQNGYEWBRl9P7.Wva', NULL, 'BAT', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:10', '2024-11-28 13:50:10', 0),
(1614, 'Niña Monica', 'Dausin', 'dausin@gmail.com', '$2y$10$HPMDsflRsUBtJqHoCQGNmeYNbJV2q4uOU/vF6DqtqYyid7QknhVSK', NULL, 'BAT', 4, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:10', '2024-11-28 13:50:10', 0),
(1615, 'Rochelle', 'Monte De Ramos', 'monte de ramos@gmail.com', '$2y$10$hoH.347q/nhAjaKlHtC.rOdfiKkL8eUGrN./ozEV6jWHuVVMXH1me', NULL, 'BAT', 4, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:11', '2024-11-28 13:50:11', 0),
(1616, 'Shanen Erica', 'Cerro', 'cerro@gmail.com', '$2y$10$ciKHWj/8wkx4kKdixRwpr.Qw6oPcfneGcDubWWxJMHhiJeSdggT/.', NULL, 'BAT', 4, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:11', '2024-11-28 13:50:11', 0),
(1617, 'Erwin', 'Oppus', 'oppus@gmail.com', '$2y$10$VymDi.tiYDiEpP/G6D5sRuDcs69N3w9P5onv6jNfK9d55iiDzTePK', NULL, 'BAT', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:11', '2024-11-28 13:50:11', 0),
(1618, 'Jaylord', 'Tagalog', 'tagalog@gmail.com', '$2y$10$Jx3Fc7ajO5D9euOm9GMMA.AE5QTEdTGecPuFjF8ldMxZY89Sqv28u', NULL, 'BAT', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:11', '2024-11-28 13:50:11', 0),
(1619, 'Jovy', 'Bello', 'bello@gmail.com', '$2y$10$JSuUH7nwwm.lf5S..SXO3eMPsvn77Sn9DJiSf.o.WyKrvBbD5OCZO', NULL, 'BAT', 4, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:11', '2024-11-28 13:50:11', 0),
(1620, 'Rogelio, Jr.', 'Maglinte', 'maglinte@gmail.com', '$2y$10$Pw2ZfWFVDQosgmZ..ZccguQ0xUvu8LctRGpBSTD6BMPbjeS2x0Ooi', NULL, 'BAT', 4, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:11', '2024-11-28 13:50:11', 0),
(1621, 'Sharmie', 'Pere', 'pere@gmail.com', '$2y$10$f8XwvKbxzkqs2fQun7Dnq.CXWZaVoXNzC3fP5fzV9DrXZyuUm2.Ba', NULL, 'BAT', 4, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:11', '2024-11-28 13:50:11', 0),
(1622, 'Lyka Mae', 'Paule', 'paule@gmail.com', '$2y$10$B2yz3K65L4Mwd1elFanW/.Ru3JPDMh39lggViE3uedt0wvxMljhUy', NULL, 'BAT', 4, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:11', '2024-11-28 13:50:11', 0),
(1623, 'Vincent', 'Salvaleon', 'salvaleon@gmail.com', '$2y$10$Wi74jkwIlH6zerOHej5oMOCF1GPfnjzsSUGXOwVcL7gEpGIuvmC8u', NULL, 'BAT', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:11', '2024-11-28 13:50:11', 0),
(1624, 'Jerald Mark', 'Surio', 'surio@gmail.com', '$2y$10$K/YcTX8msvg5cmHgr/Q3kee23ETOVkvwTDtP19o8Fir5paoIy47ce', NULL, 'BAT', 4, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:12', '2024-11-28 13:50:12', 0),
(1625, 'Jervey', 'Besas', 'besas@gmail.com', '$2y$10$EgUccJypo6hRaljhIfpJjeEJrYTzfxTYO4HbhoVT1h7lO4q8m5TW6', NULL, 'BAT', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:12', '2024-11-28 13:50:12', 0),
(1626, 'Mark John', 'Ibag', 'ibag@gmail.com', '$2y$10$S5Uv9RlnfRtsrKkg99Ijwu.WvvjYKRdkPszF/dWtZwqreyAkYD08i', NULL, 'BAT', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:12', '2024-11-28 13:50:12', 0),
(1627, 'Mark Daniel', 'Arnibal', 'arnibal@gmail.com', '$2y$10$L3HXMC/InXaNtXIhJ.U4AeIikefhq3nDq/oevReq0kAABWOhrv7Ey', NULL, 'BAT', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:13', '2024-11-28 13:50:13', 0),
(1628, 'Mary Ann', 'Galolo', 'galolo@gmail.com', '$2y$10$DTarbQtAuZH69DLMzs1poeLoMR4prWi7opkcx5.VDKZYgkQhmSbGq', NULL, 'BAT', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:13', '2024-11-28 13:50:13', 0),
(1629, 'Roy', 'Obra', 'obra@gmail.com', '$2y$10$Hr.HYmb5McCnNqgh83zvm.R83xvTxw0RXxicVZWVf5JGc.6duieau', NULL, 'BAT', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:13', '2024-11-28 13:50:13', 0),
(1630, 'Kirstine', 'Boybanting', 'boybanting@gmail.com', '$2y$10$SSv0o3HFBSLWgbjmY3jVguJIfNlGGVjKvBC3vrog2HR936sT6UthO', NULL, 'BAT', 4, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:14', '2024-11-28 13:50:14', 0),
(1631, 'Shella', 'Quillope', 'quillope@gmail.com', '$2y$10$X6Hf3PYBFJW9cx/dpYmp3OabAx9ejLTlWsW6s2i8aVOKnpZx5Pm0S', NULL, 'BAT', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:14', '2024-11-28 13:50:14', 0),
(1632, 'Noel John', 'Porlares', 'porlares@gmail.com', '$2y$10$SfJZSjk4i.LqnnQs0rFgMeIVTUH2lOVo6.cbRgoXAgG05TRIg7i26', NULL, 'BAT', 4, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:14', '2024-11-28 13:50:14', 0),
(1633, 'Gea', 'Espiritu', 'espiritu@gmail.com', '$2y$10$QUEQeup9BK9RgFtTFa9s3OJ3D25BcjuCrivFOn6uUlmoGPjxSQJfy', NULL, 'BAT', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:14', '2024-11-28 13:50:14', 0),
(1634, 'Juvily Ann', 'Unabia', 'unabia@gmail.com', '$2y$10$PNho.ze72unwLatZw.Y5YundT/9whJr0EJaVfjChqWQ6dELbIsd8m', NULL, 'BAT', 4, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:14', '2024-11-28 13:50:14', 0),
(1635, 'Rosalyn', 'Dumandan', 'dumandan@gmail.com', '$2y$10$8mJpEfDV9MvZ0ojWkygNNunLMuMDdiP9NeGy9kwAVjnRrNjD.IpyK', NULL, 'BAT', 4, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:15', '2024-11-28 13:50:15', 0),
(1636, 'Jeuanie', 'Lacerna', 'lacerna@gmail.com', '$2y$10$0sm2bEBj.Ie5xYZZLmr1GelLTZAYWVMAFq8ukkYFQ.WlebHutHMBS', NULL, 'BAT', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:15', '2024-11-28 13:50:15', 0),
(1637, 'Annalou', 'Cadayona', 'cadayona@gmail.com', '$2y$10$TNNZwwJrefYd/mXcArlOUu6qRW8rvg9EyQDJ6etpEefXqfV3kpxTS', NULL, 'BAT', 4, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:15', '2024-11-28 13:50:15', 0),
(1638, 'Mae Joy', 'Enato', 'enato@gmail.com', '$2y$10$Y2gvMfbo.bRojp9EypQCcu3rg1I31uzS0caM5x/GU/k6d5jmkXmc.', NULL, 'BAT', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:15', '2024-11-28 13:50:15', 0),
(1639, 'Joan', 'Autida', 'autida@gmail.com', '$2y$10$9llwVG8SMi7T6Rb7KC.pN.KrzxZ9PKhCpdANdetjW9ZTJ/SWwurEi', NULL, 'BAT', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:16', '2024-11-28 13:50:16', 0),
(1640, 'Eva Mae', 'Espinosa', 'espinosa@gmail.com', '$2y$10$AnY1vQpOoo2j/3MphAjdTekW8tE2VHtpaTYFCMVPLII7ifejdonMu', NULL, 'BAT', 4, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:16', '2024-11-28 13:50:16', 0),
(1641, 'Harold', 'Yepes', 'yepes@gmail.com', '$2y$10$oLab8zHRB8PVBD/DhJ1HYuC3jrTHqNxWu6bMRTxxiZNW8wbj9RDhe', NULL, 'BAT', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:16', '2024-11-28 13:50:16', 0),
(1642, 'Jericho', 'Tabada', 'tabada@gmail.com', '$2y$10$rgbIV3qxF7.rb.W4.p3QJ.PUd0GbJunZPedU5jFuqi72e3S7Pqsou', NULL, 'BAT', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:16', '2024-11-28 13:50:16', 0),
(1643, 'Hazel Mae', 'Dullano', 'dullano@gmail.com', '$2y$10$tBj3LtqgUlywCqfkmBj2Je8kBfFBCwgUUM//QQ8jav3fusWsLefbu', NULL, 'BAT', 4, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:16', '2024-11-28 13:50:16', 0),
(1644, 'Jessica', 'Panal', 'panal@gmail.com', '$2y$10$NMtrMCAzAchzXzSFZ/LlLOIiCMpyiymp34msZsGB.C4L83iYLTPXu', NULL, 'BAT', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:16', '2024-11-28 13:50:16', 0),
(1645, 'Wen Jay', 'Rule', 'rule@gmail.com', '$2y$10$49zHLOa4DfUyyhx0c0whtus4Ou6g5j9pKRt0h/R/9ywdHMg4uiXWO', NULL, 'BAT', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:16', '2024-11-28 13:50:16', 0),
(1646, 'Basilisa', 'Peñafiel', 'peñafiel@gmail.com', '$2y$10$tgJZV0482j2bwR5pMnpviObD9AyiLCfCU9/YLcPb/NNuQq3RrMKfq', NULL, 'BAT', 4, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:17', '2024-11-28 13:50:17', 0),
(1647, 'Jan Rey', 'Gonato', 'gonato@gmail.com', '$2y$10$LFIES3pzJp5icvywFibAtOWXymxF/hcmDixRdj81zcL3BVd105uVq', NULL, 'BAT', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:17', '2024-11-28 13:50:17', 0),
(1648, 'Rommel', 'Batiao', 'batiao@gmail.com', '$2y$10$IvFE6O96UEO88EViVHjbheTgAwk2x19P6nuoZZRf714zKpxF8m5TS', NULL, 'BAT', 4, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:17', '2024-11-28 13:50:17', 0),
(1649, 'Jenny Lou', 'Tabale', 'tabale@gmail.com', '$2y$10$6evUgv4Ps9jzkX5ElRTXVOxQs26w5ezqROjtges3AVURC4XNzBbSG', NULL, 'BAT', 4, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:17', '2024-11-28 13:50:17', 0),
(1650, 'Ailyn', 'Pitoc', 'pitoc@gmail.com', '$2y$10$1Y8VcamIJAZuJy5uRC9t8.4mxNvYQ530A1WTkKy4Rw006O/lGk.Xy', NULL, 'BAT', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:17', '2024-11-28 13:50:17', 0),
(1651, 'Angelika', 'Gopio', 'gopio@gmail.com', '$2y$10$1T3rPCWLdx/k8NGw0kUzXurGQOmASCqgg1PLzoZ934YlXt.BK4g5G', NULL, 'BAT', 4, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:17', '2024-11-28 13:50:17', 0),
(1652, 'Marck Joseph', 'Balcos', 'balcos@gmail.com', '$2y$10$PKo0LaBhOOnoQmEhbinnVefnbgFppLLaT0zhVzjqh.9Hcjy/cU0DG', NULL, 'BAT', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:18', '2024-11-28 13:50:18', 0),
(1653, 'Jonathan', 'Consad', 'consad@gmail.com', '$2y$10$jBH870C0DojbuFPoK1I2IOfk.jnEGXTs6OP55pxc/IuWg98UmO8oS', NULL, 'BAT', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:18', '2024-11-28 13:50:18', 0),
(1654, 'Fern Ann', 'Betita', 'betita@gmail.com', '$2y$10$6tdEZW7z6bEsewFhtCL8iOhvTV7ljcgsARDnYskr7370AIs1Kkfg.', NULL, 'BAT', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:18', '2024-11-28 13:50:18', 0),
(1655, 'Klea Rose', 'Campilan', 'campilan@gmail.com', '$2y$10$Rr0SKAdKxcaRxdDNHKwnTuGGhnmpXCLDfRfbPweQlNNyPNwvRcTZm', NULL, 'BAT', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:18', '2024-11-28 13:50:18', 0),
(1656, 'Lovely Jean', 'Canta', 'canta@gmail.com', '$2y$10$kDCcBzOTg5vy7RBfVItAxe.PPt97ORwkkZFy23y28sqR1aW9Nf8nG', NULL, 'BAT', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:18', '2024-11-28 13:50:18', 0),
(1657, 'Mary Jean', 'Canta', 'canta@gmail.com', '$2y$10$GV3NI89195xkdGFUvYF8UO.rca1r9WugcOiKjDwfHD9cnbDBstU8O', NULL, 'BAT', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:18', '2024-11-28 13:50:18', 0),
(1658, 'Jazer Mae', 'Sotto', 'sotto@gmail.com', '$2y$10$NkRqOHUG5mjCQjNVMRP5V.Xv8Yd/UcbwVtK7pxYC.TTYj3z/VYvdS', NULL, 'BSMB', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:18', '2024-11-28 13:50:18', 0),
(1659, 'Steven', 'Lauria', 'lauria@gmail.com', '$2y$10$EA7Dq7AESQILgLteF6WAvumCvlz12JkcLn9MDOdaqFRvadCRHd3WO', NULL, 'BSMB', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:18', '2024-11-28 13:50:18', 0),
(1660, 'Sherwin Brian', 'Palero', 'palero@gmail.com', '$2y$10$hswphDjrPRDjyonW5fY7WuyC7GiGtgUZ7xwTtN93nQTp1.hC4x6te', NULL, 'BSMB', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:18', '2024-11-28 13:50:18', 0),
(1661, 'Jerwen', 'Limen', 'limen@gmail.com', '$2y$10$TWU/M4w1CvLVGtkj.xFtcuPhttbov.QGW5w3vePDB6GKao7t1DZwa', NULL, 'BSMB', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:19', '2024-11-28 13:50:19', 0),
(1662, 'John Niño', 'Rebayla', 'rebayla@gmail.com', '$2y$10$H9u0Ib.5a0gbBAsO8gemau4B86KQ8b1u6sMqAkakFWB5IzHyrxqAq', NULL, 'BSMB', 2, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:19', '2024-11-28 13:50:19', 0),
(1663, 'Elmar', 'Quileste', 'quileste@gmail.com', '$2y$10$0ieWM4cC/DcXOM6F.4N5cOyYVaMHBfzcv6QcUMi8i7ide4WbONayC', NULL, 'BSMB', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:19', '2024-11-28 13:50:19', 0),
(1664, 'Jeofrey Nechole', 'Matulen', 'matulen@gmail.com', '$2y$10$ZJWqZLwxqsm4HwHthRruzOqtrrGJLJMRxCi5gdJrUd1CzuVmmn1tm', NULL, 'BSMB', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:19', '2024-11-28 13:50:19', 0),
(1665, 'Ronel', 'Trimucha', 'trimucha@gmail.com', '$2y$10$CUtKH5pp8KIb1./WLmrBg.GOoNO/P88BZakbj7.2BPIpNkfl/gEnq', NULL, 'BSMB', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:19', '2024-11-28 13:50:19', 0),
(1666, 'Camille', 'Capistrano', 'capistrano@gmail.com', '$2y$10$3w9i1b0FLnLiXHdE8qo/DOswy/ug0TM6m/X.IPjij5KQ4N0NCDVA2', NULL, 'BSMB', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:19', '2024-11-28 13:50:19', 0),
(1667, 'Catherine Kaye', 'Capusoran', 'capusoran@gmail.com', '$2y$10$VLN3YuycockcDBNLmMNf2eFqE6u4Qgy3JixNJEV9g8Xp0CqhwZ43C', NULL, 'BSMB', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:19', '2024-11-28 13:50:19', 0),
(1668, 'Rea May', 'Iway', 'iway@gmail.com', '$2y$10$phPU/frdl8n2CydxK5Lm1e.5uYj3PhbKNjs3tVOIY7QcOMcODpzIS', NULL, 'BSMB', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:19', '2024-11-28 13:50:19', 0),
(1669, 'Rheachell', 'Letrero', 'letrero@gmail.com', '$2y$10$LUjXzkg4CJJ71bvILKY7UenM0CmG0Khy3NJgGfIJ3EqjO14M4aPlK', NULL, 'BSMB', 2, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:19', '2024-11-28 13:50:19', 0),
(1670, 'Rovelyn', 'Aniog', 'aniog@gmail.com', '$2y$10$CKT6W9qOGa8PbHpr/0YUyOGP/bkADggcZi0NVkrVopnQpt0v4b3Gm', NULL, 'BSMB', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:20', '2024-11-28 13:50:20', 0),
(1671, 'Christian Bert', 'Espinosa', 'espinosa@gmail.com', '$2y$10$Erl487gQMX5Z3IBLIb08b.MrEx8ZQENa9hH9alhwsiFt4.hyqTc9O', NULL, 'BSMB', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:20', '2024-11-28 13:50:20', 0),
(1672, 'Jacinta', 'Porlas', 'porlas@gmail.com', '$2y$10$cTLNS3qlF10r/p7L2Mc37ueJH4MLVJ5IRFeocmDCU/qwN/aiUwo1.', NULL, 'BSMB', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:20', '2024-11-28 13:50:20', 0),
(1673, 'Jannelle', 'Torres', 'torres@gmail.com', '$2y$10$uYn6b.fzhNPX4Uw1TCATHeHgZWJ6cn2oQIeBX3IjRp8LpYM0Z9WOa', NULL, 'BSMB', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:20', '2024-11-28 13:50:20', 0),
(1674, 'Gwendolyn', 'Jabines', 'jabines@gmail.com', '$2y$10$brPU9watKFS8RoVJTuSkQeCohiHhPF2lVE7Cu1iSSlnWWbmNcIJgC', NULL, 'BSMB', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:20', '2024-11-28 13:50:20', 0),
(1675, 'Aj Carlo', 'Ajoc', 'ajoc@gmail.com', '$2y$10$rxkD/dflnHaJvWXfPc26zuAI/TRheNpM91xMCB3s0566l7DZOA.RG', NULL, 'BSMB', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:20', '2024-11-28 13:50:20', 0),
(1676, 'Christian John', 'Santiago', 'santiago@gmail.com', '$2y$10$PoytNcFlNbKKDK8MXJZfbOeXRN.qxDClgw5zTTfzYAxicpVxB.Am6', NULL, 'BSMB', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:20', '2024-11-28 13:50:20', 0),
(1677, 'John Kevin', 'Cortez', 'cortez@gmail.com', '$2y$10$Mld35J.gP6gE.Q0DiTDEreN5iw/.IHKgqtTfY1RrCXixe8BVTuxgG', NULL, 'BSMB', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:20', '2024-11-28 13:50:20', 0),
(1678, 'Gerald', 'Manatad', 'manatad@gmail.com', '$2y$10$cjhS8hTioDMw5oSpewlfEuCS4yL9Y79E/QxmfO/.yyyzTPBorr8vC', NULL, 'BSMB', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:20', '2024-11-28 13:50:20', 0),
(1679, 'Aiza Mae', 'Udarbe', 'udarbe@gmail.com', '$2y$10$6VRUjHltSUuFlGUg8T9nPeoZnCDt1rfFvAVJ0au8CC/XNufuq4YjS', NULL, 'BSMB', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:20', '2024-11-28 13:50:20', 0),
(1680, 'Rechel Grace', 'Aguillon', 'aguillon@gmail.com', '$2y$10$/I7fHRoyJSTMLfQw6EtKN.27i3HsxyqC2vzeQDj5bSGsFScUkTo8S', NULL, 'BSMB', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:20', '2024-11-28 13:50:20', 0),
(1681, 'Lyka Jane', 'Baron', 'baron@gmail.com', '$2y$10$VFj3wjeepBhe8bHjYVLQiOFrSozU.6ocDBPzurcaORbwWfMJkur8O', NULL, 'BSMB', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:21', '2024-11-28 13:50:21', 0),
(1682, 'Beverly', 'Baldo', 'baldo@gmail.com', '$2y$10$XjlzhLODxLCEmSTu91xnnuXSpvERuY9tE3JIzK0II5JMwyLn1E5AG', NULL, 'BSMB', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:21', '2024-11-28 13:50:21', 0),
(1683, 'Ma. Cristina', 'Dumajel', 'dumajel@gmail.com', '$2y$10$vygvdUud8BDadYXliux/aOTjUh6bhqg3yQhHT9vQwsTiCLmH9fHsy', NULL, 'BSMB', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:21', '2024-11-28 13:50:21', 0),
(1684, 'Jonalyn', 'Polistico', 'polistico@gmail.com', '$2y$10$WbKPGEmocnKKO8bwbfhfnezvM1oq7UKzXErQe7PO54E7bovNx3Qe.', NULL, 'BSMB', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:21', '2024-11-28 13:50:21', 0),
(1685, 'Neil Andrea', 'Gabronino', 'gabronino@gmail.com', '$2y$10$HYb//a3ujs0xJ3pY/NO7RuxnamB2iVfuQ/ivWkmZ8tPPE4Nv/QztC', NULL, 'BSMB', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:21', '2024-11-28 13:50:21', 0),
(1686, 'Jeansley', 'Abadinas', 'abadinas@gmail.com', '$2y$10$mptQlsuLeyxEgHKKDoXuveKYDS.Y9n01nOlXLoURG8wC8INuucTfu', NULL, 'BSMB', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:21', '2024-11-28 13:50:21', 0),
(1687, 'Devena', 'Abines', 'abines@gmail.com', '$2y$10$LieHaN7VCYM58E9iYOBgXe6LcZBDmF9p2ggsZBM8LOmQwFtmlLwPO', NULL, 'BSMB', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:21', '2024-11-28 13:50:21', 0),
(1688, 'Vanzai', 'Consuelo', 'consuelo@gmail.com', '$2y$10$M1BQTVJh4al0SlW/BEEQ2O3DdwaYrCPShFPdBB22Gyqe4xlyetv7O', NULL, 'BSMB', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:21', '2024-11-28 13:50:21', 0),
(1689, 'Jerome', 'Lagaran', 'lagaran@gmail.com', '$2y$10$7GnoNd33b4iW90YbWE0pyu0YlXF2vdoDoNLUQbhl5cBU26JOfurXa', NULL, 'BSMB', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:21', '2024-11-28 13:50:21', 0),
(1690, 'Maurice', 'Legalig', 'legalig@gmail.com', '$2y$10$j8nEvZqjyM69QWA09CxlDuCL9JNdTbK6F5WWOpewREcmgDegwMxdy', NULL, 'BSMB', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:21', '2024-11-28 13:50:21', 0),
(1691, 'Aprilyn', 'Libas', 'libas@gmail.com', '$2y$10$LX6SzfyKKGHM84NudjywQ.5SJ3y3SwcOMhwHnLJxjZ9YoVG2dUQKm', NULL, 'BSMB', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:21', '2024-11-28 13:50:21', 0),
(1692, 'Jemmalyn', 'Barnobal', 'barnobal@gmail.com', '$2y$10$1daoyaFwW83t4zpUpjnecu3/usE77f4eCcbhVr.brx9Gpi7ZckgV2', NULL, 'BSMB', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:22', '2024-11-28 13:50:22', 0),
(1693, 'Gev', 'Cano', 'cano@gmail.com', '$2y$10$hRlWeFA/B30UZNhFOnSmJe65..Nt92IUFr.vKDMNNIy6rhpC7VVI6', NULL, 'BSMB', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:22', '2024-11-28 13:50:22', 0),
(1694, 'Chynae', 'Sanchez', 'sanchez@gmail.com', '$2y$10$AfyvVtRjE1ZSMj0tHmI8SuGwExuLmB9wQufUoFdM9TiMuL1Fo1IJC', NULL, 'BSMB', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:22', '2024-11-28 13:50:22', 0),
(1695, 'Rolando Jr.', 'Joven', 'joven@gmail.com', '$2y$10$GDBebEd3dbmQOaxcx8jlDO0rHQj1RjQwnrAdje040z6cKkZQCW0ue', NULL, 'BSMB', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:22', '2024-11-28 13:50:22', 0),
(1696, 'Faith Micah', 'Balbon', 'balbon@gmail.com', '$2y$10$srkjhDTeusKZ3yHK6Ns69erUHNUIuqUZjIyZ5VeQOWRxZMiRTkCg.', NULL, 'BSMB', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:22', '2024-11-28 13:50:22', 0),
(1697, 'Criselda', 'Dinglasa', 'dinglasa@gmail.com', '$2y$10$ZF5GARw9yaryWxyOL7Xt7.B4552clPMBmKBtKLWo.e931T75VNik.', NULL, 'BSMB', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:22', '2024-11-28 13:50:22', 0),
(1698, 'Jimuel', 'Vertudazo', 'vertudazo@gmail.com', '$2y$10$u0IZ7Jcdx.vkGh5KTZyiXuEZlKM51dresxOHBzZBENmsQGskeSyfW', NULL, 'BSMB', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:22', '2024-11-28 13:50:22', 0),
(1699, 'Julie Ann', 'Curtina', 'curtina@gmail.com', '$2y$10$b0MgV1eush0aVysZN2am9eqK3UOQs5T2hpdZcNkT.HCALq1U.AX6e', NULL, 'BSMB', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:22', '2024-11-28 13:50:22', 0),
(1700, 'Jelian Rose', 'Tambis', 'tambis@gmail.com', '$2y$10$0zjwtYHt7HgfA7sGWI1oeenNu7cwTS.qZrgEdKjAHblQSodvsWsjO', NULL, 'BSMB', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:22', '2024-11-28 13:50:22', 0),
(1701, 'Jastine', 'Villarosa', 'villarosa@gmail.com', '$2y$10$7zTvnpvX3PfQR7feQZsQLu6FQXhCMV3mCuWqvKbZu1OUaVb4YvV3i', NULL, 'BSMB', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:22', '2024-11-28 13:50:22', 0),
(1702, 'Anthony', 'Quimpan', 'quimpan@gmail.com', '$2y$10$6ZcF3WkywlGnQ8NmSyvBKOjXI73sUJT43IG1eB48bzxceDfCPSr8a', NULL, 'BSMB', 2, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:23', '2024-11-28 13:50:23', 0),
(1703, 'Rhoegie', 'Ibañez', 'ibañez@gmail.com', '$2y$10$XG6gyrnif5Q87NIYI4U8r.tSp6VzrobWlpJBwY5uThAkf3G9KDuUy', NULL, 'BSMB', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:23', '2024-11-28 13:50:23', 0),
(1704, 'Aerol Kate', 'Bantaculo', 'bantaculo@gmail.com', '$2y$10$gTThRnrNsqseNGTTL2kDXei95RavLPtLdSzqYkdPzqNhKJSi9EZeK', NULL, 'BSMB', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:23', '2024-11-28 13:50:23', 0),
(1705, 'Apple May', 'Montederamos', 'montederamos@gmail.com', '$2y$10$t4PUhq6KfKr0vN3w3yCA9uUpFqBi0TBTXoQitGS59W1gj3ph.cS9O', NULL, 'BSMB', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:23', '2024-11-28 13:50:23', 0),
(1706, 'Melissa', 'Sabalo', 'sabalo@gmail.com', '$2y$10$efHLF9nwQYml/VBS1Pzld.tLiJ1gTEA1NLFVm4TS5p7VtkCuHh4X6', NULL, 'BSMB', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:23', '2024-11-28 13:50:23', 0),
(1707, 'Dianisa', 'Cojano', 'cojano@gmail.com', '$2y$10$BLdd6eqIo6y0xlKar2Rfb.u9fNVaq6Zk3HCnQFqyRC0EA7ncGyj9O', NULL, 'BSMB', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:23', '2024-11-28 13:50:23', 0),
(1708, 'Rico', 'Serdan', 'serdan@gmail.com', '$2y$10$cGSJu1d1pZYxq.T.sINXJ.v8AW272nLYypgyenFokx1BVe14LM08W', NULL, 'BSMB', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:23', '2024-11-28 13:50:23', 0),
(1709, 'Conching', 'Alboleras', 'alboleras@gmail.com', '$2y$10$AsquvYqG7E2frP1ia.TZNOdrjcad7HFlLg.7ot/3cb0iREumSkgQu', NULL, 'BSMB', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:23', '2024-11-28 13:50:23', 0),
(1710, 'Trisha Marie', 'Denoy', 'denoy@gmail.com', '$2y$10$wnY37LFATeAj3RdBTQ.q/.FKiEKT3V4Mo3o/PRQovOpysY3Acd0GO', NULL, 'BSMB', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:23', '2024-11-28 13:50:23', 0),
(1711, 'Marilou', 'Dalinog', 'dalinog@gmail.com', '$2y$10$I5Z01YBalu1DAAq/3lOQlOhghHgUAp7OwX0TXntfKgWJANd6kzonu', NULL, 'BSMB', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:24', '2024-11-28 13:50:24', 0),
(1712, 'Mariecon', 'Tambis', 'tambis@gmail.com', '$2y$10$onjFky5C1oWO2p5kyiP5p.obfSREJUQ06t1gQcbJ9bVJaFeecVlNW', NULL, 'BSMB', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:24', '2024-11-28 13:50:24', 0),
(1713, 'Rida', 'Munda', 'munda@gmail.com', '$2y$10$JjYIBh6LyDUZu4xo3t.a4OhNSvoEypCbkdasIqmSE/YY9UpYQTI0a', NULL, 'BSMB', 2, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:24', '2024-11-28 13:50:24', 0),
(1714, 'John Michael', 'Arroyo', 'arroyo@gmail.com', '$2y$10$9TVWTJecZQgxkYO7lce8eucGV6rbAwF0eADB6k1tUJ9valxUZ7ZAy', NULL, 'BSMB', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:24', '2024-11-28 13:50:24', 0),
(1715, 'Christian Van', 'Nudalo', 'nudalo@gmail.com', '$2y$10$Is.jDwiZpjxUd9yos8LgcunLAT3ARmDxo0p/HusnzLeTPFQKACzum', NULL, 'BSMB', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:24', '2024-11-28 13:50:24', 0),
(1716, 'Judith', 'Palen', 'palen@gmail.com', '$2y$10$xhhfaeFb2TbtYbUrfCjT5OR1RWVsHCXVm6QByGZ.IEeI5L0jScZ86', NULL, 'BSMB', 2, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:24', '2024-11-28 13:50:24', 0),
(1717, 'Grecille', 'Quimpan', 'quimpan@gmail.com', '$2y$10$I.aEb9f5U9/MuNk0Xw0XYubEp4yBuMm7bL1PqePVwCm7segoUMv9e', NULL, 'BSMB', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:24', '2024-11-28 13:50:24', 0),
(1718, 'Melchor', 'Amper', 'amper@gmail.com', '$2y$10$HPdFFBQd8fDnobNiUlheMOLkF95dMoWCCVhZiPf6VEqsBvnTQO4.i', NULL, 'BSMB', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:24', '2024-11-28 13:50:24', 0),
(1719, 'Alven', 'Balaba', 'balaba@gmail.com', '$2y$10$gT6/sGT7bqfU/szZM3KISudR8yit0CpZfEZlhEiWneC2E.L7b.4u6', NULL, 'BSMB', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:24', '2024-11-28 13:50:24', 0),
(1720, 'Ashlie', 'Bermiso', 'bermiso@gmail.com', '$2y$10$CwSS.0o2/BvkoBrfOA8z7OaEcxKQcW/KeylRNY8kcx2HcSULvmT4i', NULL, 'BSMB', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:25', '2024-11-28 13:50:25', 0),
(1721, 'Mae', 'Lingatong', 'lingatong@gmail.com', '$2y$10$8dcNutyzoqvtMz4TN.8kGu9a/uqRlCknBMCKPrPUcxLIw55IMrbwW', NULL, 'BSMB', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:25', '2024-11-28 13:50:25', 0),
(1722, 'James Kenneth', 'Amogues', 'amogues@gmail.com', '$2y$10$4CjKHHRt9DZfDfQmXi1AN.C1lGuM8HsgWZOnf2t7mjNsxPy0D.6D6', NULL, 'BSMB', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:25', '2024-11-28 13:50:25', 0),
(1723, 'Allysa', 'Tomaub', 'tomaub@gmail.com', '$2y$10$y/cvfRBqQs1mh/X5aWrKwuGGtKI.bGFSymJx19PbDrB03WAuZ2tTO', NULL, 'BSMB', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:25', '2024-11-28 13:50:25', 0),
(1724, 'Xcyl Rose', 'Vertudazo', 'vertudazo@gmail.com', '$2y$10$/ZB6Y6mMaTHr1AjnxEnfvuIDF2eEh7vYRekCStZ4WH.dCO0/pgiaC', NULL, 'BSMB', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:25', '2024-11-28 13:50:25', 0),
(1725, 'Ma. Christelle', 'Salem', 'salem@gmail.com', '$2y$10$ya2kCmyvDHDplNv0bXoxB.EraYBtjxhrmUmvhOsVWWA60Gj7ra2Ta', NULL, 'BSMB', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:25', '2024-11-28 13:50:25', 0),
(1726, 'Jundel', 'Betoa', 'betoa@gmail.com', '$2y$10$AUC6ABTc017Iw/wV1JOTfOHDCc9zlZ6.UpyQTW/7aCunWEuY2invG', NULL, 'BSMB', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:25', '2024-11-28 13:50:25', 0),
(1727, 'Christian Dave', 'Adobas', 'adobas@gmail.com', '$2y$10$jvS5tHlNLK7UCwKT0wx0Uewt0MkqlGBuQ0C6nKrbwd.By8Mu8k6f6', NULL, 'BSMB', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:25', '2024-11-28 13:50:25', 0),
(1728, 'Johsua', 'Tello', 'tello@gmail.com', '$2y$10$8tMy5Pk7MXzeFZmgq7YW6.9a8ud6tDSHZOmx4Cw0xdAUb8qZWzcCC', NULL, 'BSMB', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:25', '2024-11-28 13:50:25', 0),
(1729, 'Lynette', 'LLano', 'llano@gmail.com', '$2y$10$G45noPPjpHO.liHFWzSAVOrgpdEN7.rrPRr4YD/0qDwyS0uOukT1.', NULL, 'BSMB', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:25', '2024-11-28 13:50:25', 0),
(1730, 'Kimberly', 'Tabada', 'tabada@gmail.com', '$2y$10$ofHgsBJLBGSB9vrK7dpO4ezu.qMx.I.pM3tTz5/826cKi2/5xfcDu', NULL, 'BSMB', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:26', '2024-11-28 13:50:26', 0),
(1731, 'Nikki Ace', 'Cabel', 'cabel@gmail.com', '$2y$10$tBBe/fIqWJPQpLuD0j6nsevlJpNPaQ1ijdF6eNbtPaBBOb2nc5ySy', NULL, 'BSMB', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:26', '2024-11-28 13:50:26', 0),
(1732, 'Anthony R', 'Labastida', 'labastida@gmail.com', '$2y$10$.qxjZh0tz9gFW2Gvwkr0r.G4ybRcVZfs5rfv9Guy.B5BydT6Rwlnu', NULL, 'BSMB', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:26', '2024-11-28 13:50:26', 0),
(1733, 'Juvy', 'Peras', 'peras@gmail.com', '$2y$10$A9rGeSnCmkllUVkKYbIay.Shs4c6sPwG2QObct.hycJbo1y82aBbe', NULL, 'BSMB', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:26', '2024-11-28 13:50:26', 0),
(1734, 'Rolydel', 'Dayrit', 'dayrit@gmail.com', '$2y$10$tPLaq62tf/.cHjtpkJddcOska6tJx3pwo7hUSORmxAxXOm/QIESom', NULL, 'BSMB', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:26', '2024-11-28 13:50:26', 0),
(1735, 'Hanna Maerell', 'Armogenia', 'armogenia@gmail.com', '$2y$10$Gki1awqTyQkGsU0GpU5dfuxFhBlsSWSvGTw0TRhIMW.WeuImSV0WC', NULL, 'BSMB', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:26', '2024-11-28 13:50:26', 0),
(1736, 'Allysa Shane', 'Gorduiz', 'gorduiz@gmail.com', '$2y$10$mpokflFyovffvbnOI6t5t.sz4auyodja39aBj4ScylD5KIiJlOg2a', NULL, 'BSMB', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:26', '2024-11-28 13:50:26', 0),
(1737, 'Alaiza Marie', 'Mejorada', 'mejorada@gmail.com', '$2y$10$wvwMJrDX/9D4v6VUgUQ0gOQ3brDlm8U8a774VRvRjQ8KUO/2f98k6', NULL, 'BSMB', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:26', '2024-11-28 13:50:26', 0),
(1738, 'Jessil', 'Temario', 'temario@gmail.com', '$2y$10$yimHIYCT2h//PvhooHcw8u1Bm/.Fq9GJE5M46UPLVKcsT08.mXz3e', NULL, 'BSMB', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:26', '2024-11-28 13:50:26', 0),
(1739, 'Nante', 'Bernales', 'bernales@gmail.com', '$2y$10$7cVHRjGaVATu0BxK1.jv7eGNRzz9nkAuB5Z7S/fKp3rChLfmrY8ke', NULL, 'BSMB', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:26', '2024-11-28 13:50:26', 0),
(1740, 'Xander', 'Narollo', 'narollo@gmail.com', '$2y$10$bAyvA8N7GXzGvQrj5g2XO.KJWFIzAdSAmOqtbJpSe8ZnUP5uDoRgW', NULL, 'BSMB', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:26', '2024-11-28 13:50:26', 0),
(1741, 'Analiza', 'Morgia', 'morgia@gmail.com', '$2y$10$tPOexsx76T7zBtp6jqZBwuqHvT4x5UkbtrwCOgelxw45QfvhPSbPW', NULL, 'BSMB', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:27', '2024-11-28 13:50:27', 0),
(1742, 'Alfredo', 'Tiempo', 'tiempo@gmail.com', '$2y$10$y4H2Pkd3SeEk7xXIGG2OLuWQ0x8Wad9ZN74cg3N1BLOLjHj3oetFi', NULL, 'BSMB', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:27', '2024-11-28 13:50:27', 0),
(1743, 'Cherie', 'Erquilang', 'erquilang@gmail.com', '$2y$10$ZfTMhC9So6s0GJS/a3DJ3egfbzeqTiBPMtCVvZXtxdTbf/HSLbrdK', NULL, 'BSMB', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:27', '2024-11-28 13:50:27', 0),
(1744, 'Meg Ryan', 'Osa', 'osa@gmail.com', '$2y$10$6tFJcvB7mmpjZvEa8ocUFue06jK2/LipWHFBoQuq632m4S33NDd02', NULL, 'BSMB', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:27', '2024-11-28 13:50:27', 0),
(1745, 'Chabby Kharl', 'Tomon', 'tomon@gmail.com', '$2y$10$gGB0BJkOEsWh04x4Lo5EdOTH9jKtrHePHRMFhxKjGbNDg.oU71hEu', NULL, 'BSMB', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:27', '2024-11-28 13:50:27', 0),
(1746, 'Johnny', 'Castillon', 'castillon@gmail.com', '$2y$10$CabLvsTJzssRAaEFnMjmXub/b4JZd/3R.nFeA2XtB57M3zCTNWCqe', NULL, 'BSMB', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:27', '2024-11-28 13:50:27', 0),
(1747, 'Hecille', 'Tantoy', 'tantoy@gmail.com', '$2y$10$XsLbjdWYdyYAix310Du3lO99fQFVIZxG6CQd4YmN4YbUCHUMr2uSW', NULL, 'BSMB', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:27', '2024-11-28 13:50:27', 0),
(1748, 'Khristel Mona', 'Olayvar', 'olayvar@gmail.com', '$2y$10$5iXjyTrt21CtnFoowHGiF.apBTZSnqNfSsEOkkUMK8ILCLJ3apk9u', NULL, 'BSMB', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:27', '2024-11-28 13:50:27', 0),
(1749, 'Jerick Vincent', 'Siega', 'siega@gmail.com', '$2y$10$HoqLto3TyU1kovGmbfZypeB2z98QJ7Q42slJyytYQgWOHKGYYnv1S', NULL, 'BSMB', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:27', '2024-11-28 13:50:27', 0),
(1750, 'Rain Alfonso', 'Dairo', 'dairo@gmail.com', '$2y$10$MNv5IhgY0EhKR1zDJH3FSezV52W34xMd5Q0rHR2nlz5/dBTG5TpT6', NULL, 'BSMB', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:28', '2024-11-28 13:50:28', 0),
(1751, 'Jhon Reco', 'Salizon', 'salizon@gmail.com', '$2y$10$ChyS.ogSJDAgcoLFUKVIx.olK5Wl72qBYAlVxz5JQASyuWyV2it9S', NULL, 'BSMB', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:28', '2024-11-28 13:50:28', 0),
(1752, 'Myca', 'Mercado', 'mercado@gmail.com', '$2y$10$okghvJwTrThI16V97W9yeOVCIQpxyF.kGptDlbbnZcgr7c40BD9mS', NULL, 'BSMB', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:28', '2024-11-28 13:50:28', 0),
(1753, 'John Mark', 'Culpa', 'culpa@gmail.com', '$2y$10$.6qOAQ6Ja/3rxgJNo39VSucN/3hg9VxLuGcRgtf/g1vq3JHQzhMYi', NULL, 'BSMB', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:28', '2024-11-28 13:50:28', 0),
(1754, 'Sherwin Ace', 'Gorduiz', 'gorduiz@gmail.com', '$2y$10$TPeaBmqGosoHv5oIS9QloO9zBYGc4yqbBLHhTJgI4QHwvuWKOAE4y', NULL, 'BSMB', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:28', '2024-11-28 13:50:28', 0),
(1755, 'Kenneth', 'Quimson', 'quimson@gmail.com', '$2y$10$wOd0bAIuOg92V1uYBNE8zuvRnL7R9amFr/Mz.zwayQdIoO9qAa2ry', NULL, 'BSMB', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:28', '2024-11-28 13:50:28', 0),
(1756, 'Michael', 'Gonato', 'gonato@gmail.com', '$2y$10$9KWVnWKuZZK/pBcYHtbzTuHmUQ2dxng9L.uxfbA3FK6KIWTRmvegi', NULL, 'BSMB', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:28', '2024-11-28 13:50:28', 0),
(1757, 'Danica', 'Lawas', 'lawas@gmail.com', '$2y$10$ooHwcmvl8zeRjBHJgxYD3.R4TkIsazR3VRmrowO6R.DsgJww4ljBm', NULL, 'BSMB', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:28', '2024-11-28 13:50:28', 0),
(1758, 'Jayza', 'Olvina', 'olvina@gmail.com', '$2y$10$vBjQ/ZafQqlS1iHxZgiPAeHWK.42YIVujOOBzQdWrLF7kPU3Z2opq', NULL, 'BSMB', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:28', '2024-11-28 13:50:28', 0),
(1759, 'Rohan', 'Quijano', 'quijano@gmail.com', '$2y$10$nvx6FAkCrOrJucKMab4hkOSMyGTBH39oqIIuSZcmHsa5Y9RfH/hq2', NULL, 'BSMB', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:29', '2024-11-28 13:50:29', 0),
(1760, 'Maverick', 'Gantala', 'gantala@gmail.com', '$2y$10$eSUaIchuVAsmHD3jXxYSBeiHxxOVmAv1aCoPHWXA7/m1azHPNAv62', NULL, 'BSMB', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:29', '2024-11-28 13:50:29', 0),
(1761, 'Ghila', 'Galing', 'galing@gmail.com', '$2y$10$E0Yg06/df1BmADT1lDM9DeMwQ04Gg0iCYOJ7V7SSk1FqimrILNUue', NULL, 'BSMB', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:29', '2024-11-28 13:50:29', 0),
(1762, 'Angel Emmalou', 'Las Marias', 'las marias@gmail.com', '$2y$10$sAkySJZ647ltaSgSL.7dt.hS4RtoLLLZzpyLKIRVI8PnpsIZeMGaK', NULL, 'BSMB', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:29', '2024-11-28 13:50:29', 0),
(1763, 'Jhadia', 'Platero', 'platero@gmail.com', '$2y$10$mlJoXuDy8Bv/tSYb3iTMzuU3R3FC6c2Yun7zG.W6/de3q2Yd4WZPK', NULL, 'BSMB', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:29', '2024-11-28 13:50:29', 0),
(1764, 'Erwin', 'Torremonia', 'torremonia@gmail.com', '$2y$10$ZaV34cb5dgZ6IFXFzuA7WOGY4oEolRD0zpu5.ASqlf2aze0y9xAte', NULL, 'BSMB', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:29', '2024-11-28 13:50:29', 0),
(1765, 'Christine Joy', 'Lawas', 'lawas@gmail.com', '$2y$10$eMehBgIu5Z2RZ5bH9O.7QOtLFJ3jtXsHo2fclpgVVb6puHuUxNzZe', NULL, 'BSMB', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:29', '2024-11-28 13:50:29', 0),
(1766, 'Jhon Manuel', 'Aninipot', 'aninipot@gmail.com', '$2y$10$wmOOUcTgj3kJcIh4RHzUz.DAelsW40HDw7UP6JSNOrxkPwjw22HxC', NULL, 'BSMB', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:29', '2024-11-28 13:50:29', 0),
(1767, 'Ariel', 'Ongao', 'ongao@gmail.com', '$2y$10$mjk8dIiPJvr8VW886nkRT.WjTBfJV7ytMrq2LeklEsObvcQS02qmu', NULL, 'BSMB', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:30', '2024-11-28 13:50:30', 0),
(1768, 'Louie Jay', 'Cabaylo', 'cabaylo@gmail.com', '$2y$10$kLoicVSiKIjO6ycevBe1zeG1sFQ8OLcgbrc/yLO6weYbAEBNvBWm.', NULL, 'BSMB', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:30', '2024-11-28 13:50:30', 0),
(1769, 'Joseph', 'De Veyra', 'de veyra@gmail.com', '$2y$10$PACxnbuOQe22LY1bR8bv.ueJEstxFa8AQexvFNpDc4wQsP2dElFTq', NULL, 'BSMB', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:30', '2024-11-28 13:50:30', 0),
(1770, 'Nick Ryan', 'Tapasao', 'tapasao@gmail.com', '$2y$10$lq.2w0R.5.S3YFD.47cTHuTxVPS8ggP30ujIJt7enMhI9EJm.Sd3a', NULL, 'BSMB', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:30', '2024-11-28 13:50:30', 0),
(1771, 'Ranel', 'Bayron', 'bayron@gmail.com', '$2y$10$V0168eyFu0VVlghQHyjSLO/p4mx6CmMnL4HOOd.PRFI3YSO1prkZm', NULL, 'BSMB', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:30', '2024-11-28 13:50:30', 0),
(1772, 'Jack Jaeger', 'Napala', 'napala@gmail.com', '$2y$10$u4DzMdyua5DpOru/6PcWdOOhaUIO7AIjoLWvzuEUaeab/hQdOYMde', NULL, 'BSMB', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:30', '2024-11-28 13:50:30', 0),
(1773, 'Gerald', 'Kuizon', 'kuizon@gmail.com', '$2y$10$Q97GgFXxDade0FZoGnk47etWWZLI4XkmPoj9VTULU5YHLLgp/obt.', NULL, 'BSMB', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:30', '2024-11-28 13:50:30', 0),
(1774, 'Sheilla Marie', 'Padon', 'padon@gmail.com', '$2y$10$jVDSWpeYuBUl8c5W6bTG..5Aw7LcglQaC4MOEpleK76riR1qLRtsW', NULL, 'BSMB', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:30', '2024-11-28 13:50:30', 0),
(1775, 'Jerick', 'Sotto', 'sotto@gmail.com', '$2y$10$n81lnNwvOkAi4Fl5XGM/hOBW377HKWQP86u7/DKk1RkOvYf/5rf7y', NULL, 'BSMB', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:30', '2024-11-28 13:50:30', 0),
(1776, 'Oliver', 'Galudo', 'galudo@gmail.com', '$2y$10$kaeV3dkgRNfSK.RgiQ77Zu9Ozb4wdrnbJv2ibA22wcgJ6WekMukQi', NULL, 'BSMB', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:30', '2024-11-28 13:50:30', 0),
(1777, 'Gerard', 'Capistrano', 'capistrano@gmail.com', '$2y$10$pTWsXmroFSxyUpC6HTLK6O/p0qMEiAPFVrcIus4glzrD1Sw7v7ldG', NULL, 'BSMB', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:31', '2024-11-28 13:50:31', 0),
(1778, 'Gerswine', 'Baul', 'baul@gmail.com', '$2y$10$dZBp206H6DKIGouVWjqh9.Rn/pC/TVsbX8TBqmZFKGM5ZlnQm3tZG', NULL, 'BSMB', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:31', '2024-11-28 13:50:31', 0),
(1779, 'Alejandro, Jr.', 'Amper', 'amper@gmail.com', '$2y$10$/i0A8XA8jCcFzZRfKrseZua/9nI3WqLVvX5Rq18daxtmSVW11Z34i', NULL, 'BSMB', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:31', '2024-11-28 13:50:31', 0),
(1780, 'Jan Glemar', 'Agudera', 'agudera@gmail.com', '$2y$10$vACPhH.UhzfQTWbmk4C0gem288uF67Uu/UkXZPLF6p2yi7a/41NyC', NULL, 'BSMB', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:31', '2024-11-28 13:50:31', 0),
(1781, 'Reymark', 'Bernales', 'bernales@gmail.com', '$2y$10$SFUipw6gbYqCp3QA3Av4XemHhRKENnFmb.sxCND3vYYHEp7xVlnk.', NULL, 'BSMB', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:31', '2024-11-28 13:50:31', 0),
(1782, 'Rojhun', 'Enide', 'enide@gmail.com', '$2y$10$.hI54wD4llRrwtA8iuynweiNuJfsmdVbbUdVNJyLVG9/7B2IEB51G', NULL, 'BSMB', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:31', '2024-11-28 13:50:31', 0),
(1783, 'Mark Anthony', 'Lamoste', 'lamoste@gmail.com', '$2y$10$yFCkTTY2EOg.OA9Spo6MG.ISzEU5EXpbzL7tMMT5NtRyXQBrWtSiC', NULL, 'BSMB', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:31', '2024-11-28 13:50:31', 0),
(1784, 'Mark Ian', 'Baloro', 'baloro@gmail.com', '$2y$10$/0tlQpf1xy3r0Wg25QPSPOSSryW6CxDF47oh5Gc1nAQ6j.hJyAtuC', NULL, 'BSMB', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:31', '2024-11-28 13:50:31', 0),
(1785, 'Janesa', 'Inso', 'inso@gmail.com', '$2y$10$SIIyLLiTdUgSFgshWxH8Xeu7Bge4HOU1MpNUQpUP2mrFPWG796YoG', NULL, 'BSMB', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:31', '2024-11-28 13:50:31', 0),
(1786, 'Sionavic', 'Alapag', 'alapag@gmail.com', '$2y$10$IAE19at/fQhVIHyx9cE7/eBGJogGUbTOrmrwdUi5wZ1/9.RUDTLH6', NULL, 'BSMB', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:31', '2024-11-28 13:50:31', 0),
(1787, 'Dianna Rose', 'Maique', 'maique@gmail.com', '$2y$10$JK0Lb7PJbj2ncD9Wis7smu0s3xBCO4HvJpyJcmTLXQteSadGWcct6', NULL, 'BSMB', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:31', '2024-11-28 13:50:31', 0),
(1788, 'Alexa Maui', 'Villamor', 'villamor@gmail.com', '$2y$10$c3KkC0vmzCxGBuCydZtI4.Iy/v83C7xE3tRGKRs.XVUbt58K1Ye.6', NULL, 'BSMB', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:32', '2024-11-28 13:50:32', 0),
(1789, 'Kenth James', 'Ruales', 'ruales@gmail.com', '$2y$10$XYTmEnF9Uxhd.1sWlOyOHevAeazZeTKFjuVvwDbOBAiVSXqRuF6dm', NULL, 'BSMB', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:32', '2024-11-28 13:50:32', 0),
(1790, 'Jayson', 'Managbanag', 'managbanag@gmail.com', '$2y$10$y8kiLD1W/sTkWJd53O0j3e5jtoIHbdiMmLc3cn6Hnl3v.bdUDVIkC', NULL, 'BSMB', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:32', '2024-11-28 13:50:32', 0),
(1791, 'Joseph', 'Siervo', 'siervo@gmail.com', '$2y$10$q4FTS8GqLCWib36fnvlKW.2jhA6EZaCLX5dZ/qS/kT.nCOUa.HZ1S', NULL, 'BSMB', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:32', '2024-11-28 13:50:32', 0),
(1792, 'Ralph Emerson', 'Rivera', 'rivera@gmail.com', '$2y$10$OGSKa6D3kSZwOeNWHVn5helNQpLy7GzdbomLaWpParR9BvHAWW2.W', NULL, 'BSMB', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:32', '2024-11-28 13:50:32', 0),
(1793, 'Julius', 'Butad', 'butad@gmail.com', '$2y$10$ztQdkjqlvjN7YKOETIa.GO44TVeCDgSw5hofTNGkoRb/KXOWK1eUi', NULL, 'BSMB', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:32', '2024-11-28 13:50:32', 0),
(1794, 'Junna', 'Tampus', 'tampus@gmail.com', '$2y$10$Nqtt5QXQ3bUZyVn8ZP14IuutrX6g3HVzQyNyYE45bOPPlhk1ql6J2', NULL, 'BSMB', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:32', '2024-11-28 13:50:32', 0),
(1795, 'Charlene', 'Lelis', 'lelis@gmail.com', '$2y$10$owSY.XMhQkOVRzLZkWVSnORU6Zdl2vjR21nKPWOH6/yz//wpXnQJ.', NULL, 'BSMB', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:32', '2024-11-28 13:50:32', 0),
(1796, 'Joed', 'Macasocol', 'macasocol@gmail.com', '$2y$10$PsYB/d1r5pMWSQtTsHR45Oe/wmNCabqCO1bJHi1hfmzt51qw2cnTm', NULL, 'BSMB', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:32', '2024-11-28 13:50:32', 0),
(1797, 'Sharie', 'Letrero', 'letrero@gmail.com', '$2y$10$8.lIauLHUKA86Q0gAiPGIOoxY56ViRjqwfJZvFm0wnn0M9hl/3rx6', NULL, 'BSMB', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:32', '2024-11-28 13:50:32', 0),
(1798, 'Meynard', 'Lansane', 'lansane@gmail.com', '$2y$10$2mvEhpYa9QtSwgu4xUsqVu2x6jmv4t.3VupAMGZSd06qGYSgiYWH.', NULL, 'BSMB', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:32', '2024-11-28 13:50:32', 0),
(1799, 'Chryanne Mae', 'Limen', 'limen@gmail.com', '$2y$10$3945N9SzakQMbOJGf5feuuFoQnD1oej5k8iF1mwzOMDWbQF/HgLJq', NULL, 'BSMB', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:33', '2024-11-28 13:50:33', 0),
(1800, 'Mariz', 'Cero', 'cero@gmail.com', '$2y$10$4If8Hd0.eooBZJfBk1iTke3kl9R7MCzVaQttZGwPLj/s.d1i3BkgG', NULL, 'BSMB', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:33', '2024-11-28 13:50:33', 0),
(1801, 'Grace', 'Himarangan', 'himarangan@gmail.com', '$2y$10$6.X78OFj.Sb1MaG/eJ3KqeW05ll40NKH1rLO.EnDQ/.lWh08mYLm.', NULL, 'BSMB', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:33', '2024-11-28 13:50:33', 0),
(1802, 'Lea', 'Dagaas', 'dagaas@gmail.com', '$2y$10$il8nHujracAPCbimoyq7i.zgikmljjduA9rkubSAJ.HwWnWdeE6Ai', NULL, 'BSMB', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:33', '2024-11-28 13:50:33', 0);
INSERT INTO `student_registration` (`student_id`, `first_name`, `last_name`, `email`, `password`, `phone_number`, `department`, `year_level`, `section`, `enrollment_date`, `address`, `city`, `postal_code`, `country`, `date_of_birth`, `gender`, `emergency_contact_name`, `emergency_contact_number`, `created_at`, `updated_at`, `is_assigned`) VALUES
(1803, 'Jorina Mae', 'Dumali', 'dumali@gmail.com', '$2y$10$teFyFXtDECG69ydwZhlK/e4t6CpYDH.IYnN.3UbT300I8DY9r60h6', NULL, 'BSMB', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:33', '2024-11-28 13:50:33', 0),
(1804, 'Mary Jorgina', 'Kuizon', 'kuizon@gmail.com', '$2y$10$iKufQkmgqsYZGSZx5YFKeOt0EVvGKzSuCPdhCVUI91tnGUFRwA3TW', NULL, 'BSMB', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:33', '2024-11-28 13:50:33', 0),
(1805, 'Racky Luis', 'Cañon', 'cañon@gmail.com', '$2y$10$26/nyPD9ZLDVilIFQhmSK.66r3IEtyxWQQrS0vYVz1cfIKvKnBE3W', NULL, 'BSMB', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:33', '2024-11-28 13:50:33', 0),
(1806, 'Melyn', 'Malabad', 'malabad@gmail.com', '$2y$10$DIL2/d8nFAVxmLD0azf3Q.mSr2K1PJSi0IIxFPs.bmcAmlJ1vK5oO', NULL, 'BSMB', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:33', '2024-11-28 13:50:33', 0),
(1807, 'Christian Andrew', 'Reputana', 'reputana@gmail.com', '$2y$10$BRil6RHNbEbs1TOHFlv1BuX2YezO7NkCQJiKnNkyvYFuR7u11kbnq', NULL, 'BSMB', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:33', '2024-11-28 13:50:33', 0),
(1808, 'Ma. Gladys', 'Telin', 'telin@gmail.com', '$2y$10$ggO9otjTJbe3yDmAsGp8D.03YklcGnU6al0jXJOfY02keN5WIcyCu', NULL, 'BSMB', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:33', '2024-11-28 13:50:33', 0),
(1809, 'Kirby', 'Basas', 'basas@gmail.com', '$2y$10$v82HWGBRRmtv3Tfs9ReMwu5983zfPeFTWR5h0t2.tztMyJmCZUepW', NULL, 'BSMB', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:33', '2024-11-28 13:50:33', 0),
(1810, 'Cres Angel', 'Payao', 'payao@gmail.com', '$2y$10$uHrYnpPAXKFsIfPOnb8t/.qUyfgtRg7i6DU0wjI51/4IdsJvR9e6S', NULL, 'BSMB', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:33', '2024-11-28 13:50:33', 0),
(1811, 'Mark Angel', 'Calubay', 'calubay@gmail.com', '$2y$10$GN3NHl7egu63qkcqSca/dOj2MomS78jWJ/OayCByry9rwf2R72VGO', NULL, 'BSMB', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:34', '2024-11-28 13:50:34', 0),
(1812, 'Junrey', 'Tereso', 'tereso@gmail.com', '$2y$10$oe9vkm4GbfKmZfrqaWq2SeDpxoyKobzuHagfogfJ63XhG82jlR9iy', NULL, 'BSMB', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:34', '2024-11-28 13:50:34', 0),
(1813, 'Jea Flor', 'Tumanda', 'tumanda@gmail.com', '$2y$10$FqjhJSU/nGVjaoE2XhCDSuyXooD1NJSGA7l6QRS6YxlrLdCLvJCNy', NULL, 'BSMB', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:34', '2024-11-28 13:50:34', 0),
(1814, 'Rica', 'Nobile', 'nobile@gmail.com', '$2y$10$q0x.9sNiU0syZSL/cAH2BOxVN.xhK2XJFhHZKL/6yyD1IzXnJPmGm', NULL, 'BSMB', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:34', '2024-11-28 13:50:34', 0),
(1815, 'Clent John', 'Reputana', 'reputana@gmail.com', '$2y$10$NCT4s6J0ucmAr94OdiztEuNdk5L85YwWJsQgV6Lb5rA/MPia9NQWa', NULL, 'BSMB', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:34', '2024-11-28 13:50:34', 0),
(1816, 'Liv Nathalie', 'Delen', 'delen@gmail.com', '$2y$10$m8weJSJ64Lg8THHdqTSfWeHMa7HKoc3humSli0hTO3e5HzgCn5BjC', NULL, 'BSMB', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:34', '2024-11-28 13:50:34', 0),
(1817, 'Marjorie', 'Hermosilla', 'hermosilla@gmail.com', '$2y$10$nmKXPsEX48t4zL3E0C3BB..EjDH.RQWOwOmlX4ytTlId1i7/rmEh.', NULL, 'BSMB', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:35', '2024-11-28 13:50:35', 0),
(1818, 'Joanne', 'Vienes', 'vienes@gmail.com', '$2y$10$CX7p3YjaPvUzcbgtWxeYM.W5uls14k3S.MJEq.ougBZKTYWNOBa9S', NULL, 'BSMB', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:35', '2024-11-28 13:50:35', 0),
(1819, 'Shayne', 'Ranes', 'ranes@gmail.com', '$2y$10$inoOQsn4g5nDd.63Cxc0bOZ42eu7yZNpXOyJFbD61q4IWFX9NspIy', NULL, 'BSMB', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:35', '2024-11-28 13:50:35', 0),
(1820, 'Rj Clint Rainiel', 'Hindang', 'hindang@gmail.com', '$2y$10$zrWjS9/WiIFQEWujDuGpEu.e35uuMoIbaYlI3ny7Ln5KUXflCuVe2', NULL, 'BSMB', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:35', '2024-11-28 13:50:35', 0),
(1821, 'John Paul', 'Entino', 'entino@gmail.com', '$2y$10$r6htDe08T3a1EWw05oRAEO.XvhSdbSGBSqBUql38Oe1CfmZYdUUdO', NULL, 'BSMB', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:35', '2024-11-28 13:50:35', 0),
(1822, 'Sean David', 'Felicilda', 'felicilda@gmail.com', '$2y$10$srPhDUc8mLqg/Pwp86xeb.6GzRUV0UQZYRTWc89MvuneYrqTSSVTC', NULL, 'BSMB', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:35', '2024-11-28 13:50:35', 0),
(1823, 'Steven Carl', 'Felicilda', 'felicilda@gmail.com', '$2y$10$So7cAT.GpS7kbtcDaUJub.V49JKMlIXS5dRwldBlMt4yidxYRwKSi', NULL, 'BSMB', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:35', '2024-11-28 13:50:35', 0),
(1824, 'Miregen', 'Balaguer', 'balaguer@gmail.com', '$2y$10$oNDndRa2We2K6YvzyoSYpu0T8jNXeXI4vKQCQ3kKeyZpiaIV8B966', NULL, 'BSMB', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:35', '2024-11-28 13:50:35', 0),
(1825, 'Anne Rica', 'Sumaya', 'sumaya@gmail.com', '$2y$10$YyltkedXUMWkF1BO80RGfOGoIyW65frc2eEQrOi1/5gKP0sakiIZ.', NULL, 'BSMB', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:35', '2024-11-28 13:50:35', 0),
(1826, 'Juliet', 'Ajoc', 'ajoc@gmail.com', '$2y$10$g6H8vQAJF7l70jmbJ4utteEIUDo4xXu8vQRvAyvQIWaNKUVgrsa/e', NULL, 'BSMB', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:35', '2024-11-28 13:50:35', 0),
(1827, 'Remafie', 'Refugio', 'refugio@gmail.com', '$2y$10$V0K4o20R0HoAfWvx6sXl2uG1U8VIELqPKRr9JozhtDmtae.FJb1LO', NULL, 'BSMB', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:36', '2024-11-28 13:50:36', 0),
(1828, 'Fellisarda', 'Cillo', 'cillo@gmail.com', '$2y$10$57DUpj9uD4vIDb8fJJ4jJuUeCTHnfWeG5sZiZrA0FSn.2gyBV5nM6', NULL, 'BSMB', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:36', '2024-11-28 13:50:36', 0),
(1829, 'Mekylla Jed', 'Lagbas', 'lagbas@gmail.com', '$2y$10$jNUYO8MxUhzw6vpCwiN8ZO89lQBI.MXA7TXVGP5AzyfqkXdVAwEOW', NULL, 'BSMB', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:36', '2024-11-28 13:50:36', 0),
(1830, 'Rohann John', 'Bogate', 'bogate@gmail.com', '$2y$10$q0qAqmHm8MiZQmdQwt7Oc.9eRadSBkHTZDHpxBqQLAILOGFMmtzni', NULL, 'BSMB', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:36', '2024-11-28 13:50:36', 0),
(1831, 'John Pierre', 'Bogate', 'bogate@gmail.com', '$2y$10$OYUUeCViGQeSOhTApg53quDJYZqpKWZYlziUevKib/UV/0JJ.6EP6', NULL, 'BSMB', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:36', '2024-11-28 13:50:36', 0),
(1832, 'Sophia Cyril', 'Iligan', 'iligan@gmail.com', '$2y$10$/XWrYJlEybApglQUKfMZeOrdp7VV1KqGU.rOBE7eRn7rAS2A0Gg7C', NULL, 'BSMB', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:37', '2024-11-28 13:50:37', 0),
(1833, 'Hyacinth', 'Gulo', 'gulo@gmail.com', '$2y$10$8pFb.3sgnveN2Ah3ngpUOODYep8LQYQM507n21Td73eOXcK/ofjSu', NULL, 'BSMB', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:37', '2024-11-28 13:50:37', 0),
(1834, 'John Jacob', 'Bautista', 'bautista@gmail.com', '$2y$10$mjUrXdHAzYteSFHSJwzCQOJYAoLFtL9q6WONq6LwCEPvdDWt.0c6i', NULL, 'BSMB', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:37', '2024-11-28 13:50:37', 0),
(1835, 'Jhon Reven', 'Inso', 'inso@gmail.com', '$2y$10$0iheoPAH2Iuc/tXIZ45F7urkBiz0bBesxU.FDffsVeD1El0FQBKhS', NULL, 'BSMB', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:37', '2024-11-28 13:50:37', 0),
(1836, 'Jermalyn', 'Isaga', 'isaga@gmail.com', '$2y$10$xSewUZ/scpGbdfk6pERWUeABTMxTpKy6LDAskej2p35oWWH0NVLkC', NULL, 'BSMB', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:37', '2024-11-28 13:50:37', 0),
(1837, 'Jella Marie', 'Monter', 'monter@gmail.com', '$2y$10$nUyBQBLC1wQ/2DgkXUm3t.H2VBoHg1jkdqSO7H94H1yaVBa4B/xSS', NULL, 'BSMB', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:37', '2024-11-28 13:50:37', 0),
(1838, 'Zyra Je', 'Supangan', 'supangan@gmail.com', '$2y$10$6qNXNNiQalUlnknPZ7U5SeYrQcK/Y/6CjMARKJUbMHqrhykTUMZWe', NULL, 'BSMB', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:37', '2024-11-28 13:50:37', 0),
(1839, 'Mark Niño', 'Maymay', 'maymay@gmail.com', '$2y$10$hy6ZrtCVOunOfYq2BeVbHeJWPM25ERnj90ISrPEuornV3/7Sk4JIu', NULL, 'BSMB', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:37', '2024-11-28 13:50:37', 0),
(1840, 'Reina', 'Comilang', 'comilang@gmail.com', '$2y$10$124W5T6lgb0hFDPJyOEMxun4qegYobwVoLNDlwEaIxReJDW3wEb0G', NULL, 'BSMB', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:37', '2024-11-28 13:50:37', 0),
(1841, 'Joseph', 'Oring', 'oring@gmail.com', '$2y$10$0vZhw3ZMgoks1bOCe16gr.inrbgTGRag.Sgd.zgU1VAnh1z//NBD6', NULL, 'BSMB', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:38', '2024-11-28 13:50:38', 0),
(1842, 'Hero', 'Julio', 'julio@gmail.com', '$2y$10$vmNdgFOYOMcEgRtz8AkJ7ugM8LO//I0Pm1DJ2b0PpcTJ1LIQxXs6i', NULL, 'BSMB', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:38', '2024-11-28 13:50:38', 0),
(1843, 'Abel John', 'Cempron', 'cempron@gmail.com', '$2y$10$gMniMTK/idqy7A/mBClN3eJFsDXvwIAbniPFC7qJkwbF5Ab4QJB1u', NULL, 'BSMB', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:38', '2024-11-28 13:50:38', 0),
(1844, 'Niño Gian Elliakim', 'Pattaguan', 'pattaguan@gmail.com', '$2y$10$DiKVIWsQqPd.IzmnapjfQuVkyMk1ffCK6MUjBYAArYpQlK1lGHS0C', NULL, 'BSMB', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:38', '2024-11-28 13:50:38', 0),
(1845, 'Jesel', 'Terante', 'terante@gmail.com', '$2y$10$PeE70Rvg3nfSDlupotUr4.YkzO0DJoA2MfsQcis2WgqYFE4ecpNa.', NULL, 'BSMB', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:39', '2024-11-28 13:50:39', 0),
(1846, 'Joseph', 'Castolome', 'castolome@gmail.com', '$2y$10$rbzOPSJU4v9wR2dk.l.qG.QUuh1QiLO.f0EvLoTFPzqGgzVoxEdjm', NULL, 'BSMB', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:39', '2024-11-28 13:50:39', 0),
(1847, 'Ira Gabriel', 'Escamis', 'escamis@gmail.com', '$2y$10$D2hK//TIE1n5VAkEIpm6v.dKHIcnK7G5nTUnqQNUyIZXfD7UXusAK', NULL, 'BSMB', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:39', '2024-11-28 13:50:39', 0),
(1848, 'Aheizer', 'Pagula', 'pagula@gmail.com', '$2y$10$Qxgtk14t0bw9Z7SdzMdIwu9eu6oEmP0OjN6I4qsxSyA.rmVe4kf4e', NULL, 'BSMB', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:40', '2024-11-28 13:50:40', 0),
(1849, 'Reynaldo Jr.', 'Romorosa', 'romorosa@gmail.com', '$2y$10$Mo4fyVxik00c.Cj.af5sh.4aarbncj4wzg8mvz7h26MX6JYLbUjte', NULL, 'BSMB', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:40', '2024-11-28 13:50:40', 0),
(1850, 'Abegail', 'Ani', 'ani@gmail.com', '$2y$10$U4rZ/nb5wMgPGK0qrGijfOZLkTqOrJj2Rzz3pSrqhFK7dkv5P4On2', NULL, 'BSMB', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:40', '2024-11-28 13:50:40', 0),
(1851, 'Justine', 'Navarrosa', 'navarrosa@gmail.com', '$2y$10$NUBcLtiz7VitzWLAmvyQIe2M8fjnucZLfMv.C25HE7YqveXL8hkK6', NULL, 'BSMB', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:40', '2024-11-28 13:50:40', 0),
(1852, 'Joseph', 'Sumodlayon', 'sumodlayon@gmail.com', '$2y$10$oNXvQe5ak0Uexeeq6FtHTuhGvu2LyP9amVdGEDbWSm69mXQIK.XbS', NULL, 'BSMB', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:40', '2024-11-28 13:50:40', 0),
(1853, 'Rouela', 'Saavedra', 'saavedra@gmail.com', '$2y$10$PKKyoyr3SVyOiBSOhgDSx.fK2dNLwngu.Xe/MaIchckhiCAU1HVdu', NULL, 'BSMB', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:40', '2024-11-28 13:50:40', 0),
(1854, 'Kathlenne May', 'Flores', 'flores@gmail.com', '$2y$10$eVi.r7Ur42/W90k6vg8skuOi44w2ZtFnmSyCRYaIii8qlpXfo/a7C', NULL, 'BSMB', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:41', '2024-11-28 13:50:41', 0),
(1855, 'Jemar', 'Trajano', 'trajano@gmail.com', '$2y$10$kw4yAtfXTrwNMirI17L0Z.DLAZTHTTHcb95.9TZFKwkuGFHXyV7mu', NULL, 'BSMB', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:41', '2024-11-28 13:50:41', 0),
(1856, 'Julieven', 'Leyes', 'leyes@gmail.com', '$2y$10$D6KWsFdlmdh394Gvcc21AuLIHBE4Z.T2jv2nhDCCZvzPmd5GO/6Ju', NULL, 'BSMB', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:41', '2024-11-28 13:50:41', 0),
(1857, 'Anabel', 'Namoc', 'namoc@gmail.com', '$2y$10$KLJkV.sV4Lgq0Nf3bXMb/eNc89iWm8RLoeeYsF2eWfuUQTxAoBT.m', NULL, 'BSMB', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:41', '2024-11-28 13:50:41', 0),
(1858, 'Reyze Marie', 'Anadon', 'anadon@gmail.com', '$2y$10$BQ3PPYgRf3zXdZxnlQUD8O8PtlrFBdZHsB84.QAHysWNpUUDT7q4.', NULL, 'BSMB', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:41', '2024-11-28 13:50:41', 0),
(1859, 'Reynaldo', 'Sabalo', 'sabalo@gmail.com', '$2y$10$M1TKCAHAZ3vH37DJS5yY.eDSgVh1tjeFaA6rqxSb06tlHIea8kWly', NULL, 'BSMB', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:42', '2024-11-28 13:50:42', 0),
(1860, 'Joan', 'Naol', 'naol@gmail.com', '$2y$10$jNnugAVDOq6J1b87VYA/7OyzCqQB/lbbbbAQerPPzvLUCY8lwIKii', NULL, 'BSMB', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:42', '2024-11-28 13:50:42', 0),
(1861, 'Venice Maya', 'Vilbar', 'vilbar@gmail.com', '$2y$10$z9YRjtGxgvNoB1lPC5roSOqnvAR54zF/eGjYOphfSnaotFYCgZdFm', NULL, 'BSMB', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:43', '2024-11-28 13:50:43', 0),
(1862, 'Yra Grace', 'Alpas', 'alpas@gmail.com', '$2y$10$rCdfyDTVvEurqIXbntHUTOg1T1gLb2E6E4ekgOKtmI88vHSWwGfMi', NULL, 'BSMB', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:43', '2024-11-28 13:50:43', 0),
(1863, 'Jenny Rose', 'Medalle', 'medalle@gmail.com', '$2y$10$b55.cskKbjwiqRhUnNiv.uamgGqinSK6.mDwscj8qOiyPY0MOapQ.', NULL, 'BSMB', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:43', '2024-11-28 13:50:43', 0),
(1864, 'Jelly Beth', 'Gagan', 'gagan@gmail.com', '$2y$10$6csjTVvM7QN8VuYtPKPkAeqBJMjCuItc4yjL4wYIzxzF4qolSXJy2', NULL, 'BSMB', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:43', '2024-11-28 13:50:43', 0),
(1865, 'Ailicka', 'Cojano', 'cojano@gmail.com', '$2y$10$UntM6cmV4WOu4YovWy/96evhqm39TUIz7WgARawzDScxZ1i2EYgKe', NULL, 'BSMB', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:44', '2024-11-28 13:50:44', 0),
(1866, 'Kris Angel', 'Tindugan', 'tindugan@gmail.com', '$2y$10$Sk49WnXspvrSMvIlV4KrcuU/2Dy0/WJhK98ySOAZvLaZEd9tw5oAi', NULL, 'BSMB', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:44', '2024-11-28 13:50:44', 0),
(1867, 'Kim Angela', 'Ingente', 'ingente@gmail.com', '$2y$10$2i9uc1.KxTYankdVuVZpx.ZRVCKOKjmU1WXCVIWNIi7Nsr5jM3.W.', NULL, 'BSMB', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:44', '2024-11-28 13:50:44', 0),
(1868, 'Cordiro', 'Quileste', 'quileste@gmail.com', '$2y$10$LScXUDWsImu3/rV/yjc7O.P443MX6nriGwsNz/Y1IyHJ96ZJzo0zC', NULL, 'BSMB', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:44', '2024-11-28 13:50:44', 0),
(1869, 'Domingo Jr.', 'Maimot', 'maimot@gmail.com', '$2y$10$9.0ixMsJ/GUwxCDodAovD.zry5143StD748xS67vyaTTbpinxQnUy', NULL, 'BSMB', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:44', '2024-11-28 13:50:44', 0),
(1870, 'Arianne Mae', 'Senoc', 'senoc@gmail.com', '$2y$10$GXxSa0Xclo4k3ZWq8Nh0VeH7OGM5NagaA9dB6sd1y4SkMD6haR15q', NULL, 'BSMB', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:44', '2024-11-28 13:50:44', 0),
(1871, 'Lyra Ann', 'Cabrera', 'cabrera@gmail.com', '$2y$10$XJVdHYK6YmDz9mn9h6MKaOq0pnvUK78mmU.zedW.ws7oZEBlNRzpG', NULL, 'BSMB', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:44', '2024-11-28 13:50:44', 0),
(1872, 'Syra Eve', 'Ayop', 'ayop@gmail.com', '$2y$10$qo.tDnsn22ddEHYn.k22IeMU7lHTkaNw.Fw3Wd7SUnU/aVLhXaWHS', NULL, 'BSMB', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:44', '2024-11-28 13:50:44', 0),
(1873, 'Jesel', 'Nelmida', 'nelmida@gmail.com', '$2y$10$mLrotSwxwipSMRqbLglcLutRgAnWuJI0qJt3LkxcG1Yr6jXaF0XVq', NULL, 'BSMB', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:45', '2024-11-28 13:50:45', 0),
(1874, 'Ryan Kevin', 'Geonzon', 'geonzon@gmail.com', '$2y$10$YqTaShTvKaMcRyxTDh32JOHMn2/0EfsudB2QFa1sVlAc.ZaDijdCq', NULL, 'BSMB', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:45', '2024-11-28 13:50:45', 0),
(1875, 'Robert', 'Segovia', 'segovia@gmail.com', '$2y$10$BrWWiRH1b4KGyLtP13yzz.p2FTVoXNfwqntM7mO9nRSLnbN5q5iXO', NULL, 'BSMB', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:45', '2024-11-28 13:50:45', 0),
(1876, 'Uri John', 'Ballos', 'ballos@gmail.com', '$2y$10$9aihVqYuhd1W8NcXy4L1veFOfyzCrzYtth.q0YcEvMEDIBhL2jssK', NULL, 'BSMB', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:45', '2024-11-28 13:50:45', 0),
(1877, 'Clifford', 'Odarbe', 'odarbe@gmail.com', '$2y$10$dpnqMqhOpV2I3zXOzfjCi.SLRagoc/pFWJm3TKtQENeHYbPiMdEAu', NULL, 'BSMB', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:46', '2024-11-28 13:50:46', 0),
(1878, 'Katrina Mae', 'Gomez', 'gomez@gmail.com', '$2y$10$urGaYPqZ0IgaJwEfzRoRQu8D6CQK1JNrMQ87Hck6E5R/u.89wqDm6', NULL, 'BSMB', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:46', '2024-11-28 13:50:46', 0),
(1879, 'Mark Rommel', 'Arañez', 'arañez@gmail.com', '$2y$10$Q7X7nGRct48Ce0iOzDdmK.bouh0xCfDkS6qsGlheS3nM.bSvvgaAW', NULL, 'BSMB', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:46', '2024-11-28 13:50:46', 0),
(1880, 'Gea Ann', 'Del Valle', 'del valle@gmail.com', '$2y$10$EQ17Uo2ZrqB08xRuxNWIJOlde9qb/vQ.DiCR0M7WQWY3yA72.UKiO', NULL, 'BSMB', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:46', '2024-11-28 13:50:46', 0),
(1881, 'Ernelyn', 'Gono', 'gono@gmail.com', '$2y$10$Xy36vV2VmNwt3Nf140Es0OzWDsSiidqhEPSOu/3AkVZFQymR5zCjK', NULL, 'BSMB', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:46', '2024-11-28 13:50:46', 0),
(1882, 'Jerome', 'Cambalon', 'cambalon@gmail.com', '$2y$10$uDmzL8nVjQuK9EOoIvcto.MDZ/4WKV/aX8R.l.oyNNnkKoxJ.RwF2', NULL, 'BSMB', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:46', '2024-11-28 13:50:46', 0),
(1883, 'Micaella', 'Singzon', 'singzon@gmail.com', '$2y$10$sh9Q0Sxvjs8DSADhoSFPPuHphXLpIFPlct/3y9Y4713xRmPtWUcOG', NULL, 'BSMB', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:46', '2024-11-28 13:50:46', 0),
(1884, 'Sarah Iris', 'Bello', 'bello@gmail.com', '$2y$10$mEO4jLUGTCWxT1R7ww4c5.CW773YFfKREkqOxtd4utabLfJ3CSJXG', NULL, 'BSMB', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:47', '2024-11-28 13:50:47', 0),
(1885, 'Kurt Liander', 'Aniga', 'aniga@gmail.com', '$2y$10$J0/fpdDp3KY6jYjVqwR9/eA./Nnc0NMpc7HeZj2h9rj7mwvkkRnjK', NULL, 'BSMB', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:47', '2024-11-28 13:50:47', 0),
(1886, 'Darwin', 'Dotollo', 'dotollo@gmail.com', '$2y$10$CffxqHlTfEfQRTg7kXt/Ae22WnH/28hl6BvKNivZ6doaR2fhx9tpy', NULL, 'BSMB', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:47', '2024-11-28 13:50:47', 0),
(1887, 'Ivan', 'Ico', 'ico@gmail.com', '$2y$10$jeM/8mUEH2E5neStMNYF..QKML8rDp.JYHTW6ul9EXZIbYNc5bFzO', NULL, 'BSMB', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:47', '2024-11-28 13:50:47', 0),
(1888, 'Kristele', 'Camarador', 'camarador@gmail.com', '$2y$10$93cROgLl0c3f/qmWG6nyw.WVAmTTR3nplaXwS47VpObdyXt/8qlKe', NULL, 'BSMB', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:47', '2024-11-28 13:50:47', 0),
(1889, 'Joshua', 'Lamoste', 'lamoste@gmail.com', '$2y$10$mHz1MD.9Gbfqk.FC/98b3eO8H/iIl5Bagp5iUFUHpCyqdqcdcjZe2', NULL, 'BSMB', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:47', '2024-11-28 13:50:47', 0),
(1890, 'Jinky', 'Sulla', 'sulla@gmail.com', '$2y$10$5nBK2Vuf/keD9C3r9upxb.I4WjMaq0BEVcES6nALU8Jkd3Wn.OAaW', NULL, 'BSMB', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:47', '2024-11-28 13:50:47', 0),
(1891, 'Alexel', 'Sulla', 'sulla@gmail.com', '$2y$10$KLsFfZfxIQ6efdccSYbYre2i0pjyMThdktxxw0JBUS2J3lcecF6sy', NULL, 'BSMB', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:48', '2024-11-28 13:50:48', 0),
(1892, 'Erly', 'Arroyo', 'arroyo@gmail.com', '$2y$10$2BauLuEUT/ElnshMBN2wEuj/6Fb1e5DNqDo9GYMXrofRKL8eB8VUu', NULL, 'BSMB', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:48', '2024-11-28 13:50:48', 0),
(1893, 'Loejie', 'Masbate', 'masbate@gmail.com', '$2y$10$uS2G99E64pu9BTueJbSZtenDopqp8YXRbCiZhYI1RFxoXXsMDnUeu', NULL, 'BSMB', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:48', '2024-11-28 13:50:48', 0),
(1894, 'Mary Concepcion', 'Dominguez', 'dominguez@gmail.com', '$2y$10$DtwAiiXJt4dDBMqUNQo2y.Ci5X6jFL/qWELJhgT9UggGhORAnBtzi', NULL, 'BSMB', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:48', '2024-11-28 13:50:48', 0),
(1895, 'Rhea', 'Catarman', 'catarman@gmail.com', '$2y$10$ulMxinBpvwozH.BJkifTnObd9ueJzw9xQHw8FCnqLSATiTz.ClUJG', NULL, 'BSMB', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:49', '2024-11-28 13:50:49', 0),
(1896, 'Romer', 'Balondro', 'balondro@gmail.com', '$2y$10$WTz8nfpPckAYCygzPLqlbeGZzDfsXM8kXx4.sxrecH92Eg/eIGWDG', NULL, 'BSMB', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:49', '2024-11-28 13:50:49', 0),
(1897, 'Nelsie', 'Amper', 'amper@gmail.com', '$2y$10$HZFCyZkZiAD/r0fvz43hy.2RPgACazvVhP4.hh3IR2sUj4qygLg3y', NULL, 'BSMB', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:50', '2024-11-28 13:50:50', 0),
(1898, 'Erjohn', 'Florida', 'florida@gmail.com', '$2y$10$N7eFaDMsumgoOqg1/FTor.rdYkXn5S8YcF0mFPr6rIbSxbWNLXvSm', NULL, 'BSMB', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:50', '2024-11-28 13:50:50', 0),
(1899, 'Jayke', 'Beronio', 'beronio@gmail.com', '$2y$10$IECCUuYnTaAcRsytwNB66uTGSTOcPc34jX6AYDET1wONPq8rirfrq', NULL, 'BSMB', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:50', '2024-11-28 13:50:50', 0),
(1900, 'Jennifer', 'Semogan', 'semogan@gmail.com', '$2y$10$nWpOEyUzJB4Uh1bESlLKY.EV5iJBYP8wrMxyO.vjxL6rG4mUNxo2y', NULL, 'BSMB', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:50', '2024-11-28 13:50:50', 0),
(1901, 'Jondel', 'Conato', 'conato@gmail.com', '$2y$10$a3e8Fz97AzJWFyL99yhwTeA/PfLRBbqyiz9y6sQII6VZALLGysGb2', NULL, 'BSMB', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:51', '2024-11-28 13:50:51', 0),
(1902, 'Jiesel', 'Gallemaso', 'gallemaso@gmail.com', '$2y$10$Ffjx9jQ1Y/SilAp8tTS3h.LXX.eu1HBq0szc2mg.MGKQITBp3jilW', NULL, 'BSMB', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:51', '2024-11-28 13:50:51', 0),
(1903, 'Marvin', 'Gamutan', 'gamutan@gmail.com', '$2y$10$AqFC05if1sQuP24XCSKZzexolLCqb1JBW1UIHxU0fevIhKfv/IcJS', NULL, 'BSMB', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:51', '2024-11-28 13:50:51', 0),
(1904, 'Mercy', 'Tidalgo', 'tidalgo@gmail.com', '$2y$10$9TfiNh/nhaEMO6kgDXTcv.Qv7C8CKhLjKE5CbNZ.CGjO9osku3AKi', NULL, 'BSMB', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:51', '2024-11-28 13:50:51', 0),
(1905, 'Robert', 'Tabis', 'tabis@gmail.com', '$2y$10$Rw089lm5dce48MA2gnn7keRQk3LOJvdUZAcdInPhFuuwKpFdqsw06', NULL, 'BSMB', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:51', '2024-11-28 13:50:51', 0),
(1906, 'Ariana Mae', 'Huera', 'huera@gmail.com', '$2y$10$QXpcFL8ZpfpD5MRJYoXEAeWmKvIKz1fR3LVGVEJToai1oUOY.BwMG', NULL, 'BSMB', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:51', '2024-11-28 13:50:51', 0),
(1907, 'Humphrey Godwin', 'Permano', 'permano@gmail.com', '$2y$10$3bz1OxLMAqj5QeazUKUPgOMTD4Q/a9hUGsUirX628Nbxe1lNUqlKG', NULL, 'BSMB', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:52', '2024-11-28 13:50:52', 0),
(1908, 'Kim Erika', 'Repaja', 'repaja@gmail.com', '$2y$10$EKbNrWMcmG96jc2d1tpbiu2F20grZaE1PYxcW5DlBhvMuMY1upi9m', NULL, 'BSMB', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:52', '2024-11-28 13:50:52', 0),
(1909, 'Angeline', 'Aguylo', 'aguylo@gmail.com', '$2y$10$2fX8IjkOpkc459bgSN63lePt3FZpyUAlTmthVt/eYmszNvwPL5h9W', NULL, 'BSMB', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:52', '2024-11-28 13:50:52', 0),
(1910, 'Reign Angelle', 'Gotis', 'gotis@gmail.com', '$2y$10$/mFMrKo.JTwN4EooxxZFLeAlERWesEUKstOwj0lzjEBQrJ7gIR75S', NULL, 'BSMB', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:52', '2024-11-28 13:50:52', 0),
(1911, 'Jhersah', 'Abrea', 'abrea@gmail.com', '$2y$10$P3/0/2qUHAwFPadiXK1nZeqhKawN0LHJKFb8TgijEsTtrs49z3qq2', NULL, 'BSMB', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:52', '2024-11-28 13:50:52', 0),
(1912, 'Glenys', 'Calubag', 'calubag@gmail.com', '$2y$10$9whNY04l1.cEO.sV5uWvhOno2Rr9McpjSzjS.gad/4h.uuwyLiXZK', NULL, 'BSMB', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:52', '2024-11-28 13:50:52', 0),
(1913, 'Ma. Christine', 'Cillo', 'cillo@gmail.com', '$2y$10$Y0fHE9iKD2TruKfi.1yLSeu0Pq/tE8JRRK7xcG/o2ZTDYO3CZ80aa', NULL, 'BSMB', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:53', '2024-11-28 13:50:53', 0),
(1914, 'Lemuel', 'Panal', 'panal@gmail.com', '$2y$10$x68YK4v2HvlhOjHQIwboI.HfyWDO5vpIpMmm1oM0ZWf.QTH4sx9Ye', NULL, 'BSMB', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:53', '2024-11-28 13:50:53', 0),
(1915, 'Eric', 'Punay', 'punay@gmail.com', '$2y$10$1kEI50e.kSYTi6h41/eKCeksIomzLQuLHCusZ4q4cEHAh.W/QYg36', NULL, 'BSMB', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:53', '2024-11-28 13:50:53', 0),
(1916, 'Cheryl', 'Seno', 'seno@gmail.com', '$2y$10$Txs/YQdbFGAnMQuert7JjujmNY2fKO6xRbqdUBgBS566bYNcYsYTq', NULL, 'BSMB', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:54', '2024-11-28 13:50:54', 0),
(1917, 'Daisyryl', 'Villarin', 'villarin@gmail.com', '$2y$10$caCb50alVsPUJRTTNkWozux33sNg3tqAr0IhnHJsf8iBlFiwBRA1q', NULL, 'BSMB', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:54', '2024-11-28 13:50:54', 0),
(1918, 'Gemmalyn', 'Majestrado', 'majestrado@gmail.com', '$2y$10$THx73Cm19FVGS1hfWjPHE.gXg6jBS3arTIjAA0bVfna.8NCerkGpW', NULL, 'BSMB', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:54', '2024-11-28 13:50:54', 0),
(1919, 'Jesyl', 'Gerona', 'gerona@gmail.com', '$2y$10$Wxb.zOF3TgWP.8wk8/8MSe3h8/N4B6cv6qAuhg0mtC.99oyDsexuC', NULL, 'BSMB', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:55', '2024-11-28 13:50:55', 0),
(1920, 'Divine', 'Dacera', 'dacera@gmail.com', '$2y$10$5xkClS1LtAJMq6LyTWjEI.Ev018h4XwbpGJXM7BfzTA5Y.QGIPpb.', NULL, 'BSMB', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:55', '2024-11-28 13:50:55', 0),
(1921, 'Kirby', 'Gisulga', 'gisulga@gmail.com', '$2y$10$W.AOQDt7CfkONR97RdSjjOO8sdd/VwYqp50U1um70lsgrn8qmz7rW', NULL, 'BSMB', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:55', '2024-11-28 13:50:55', 0),
(1922, 'Archie', 'Balaba', 'balaba@gmail.com', '$2y$10$U0WH3JpzhphWQmIySfVMPOEXMl4u/aLB4oblBTqQNYyKGOX5jKami', NULL, 'BSMB', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:55', '2024-11-28 13:50:55', 0),
(1923, 'John Rafael', 'Gales', 'gales@gmail.com', '$2y$10$W4wAjn9Ux7237CaTnn7EQOB4TLPJanhc3gEBSDxja6KnI3kGjRAKq', NULL, 'BSMB', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:56', '2024-11-28 13:50:56', 0),
(1924, 'Kian', 'Eco', 'eco@gmail.com', '$2y$10$Gq8gQgmigJa4Dcg.joxRq.grL2oY726BMXi77JZ.oXjA5cLSTK4lq', NULL, 'BSMB', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:56', '2024-11-28 13:50:56', 0),
(1925, 'Shiela Mae', 'Auguis', 'auguis@gmail.com', '$2y$10$e.X8gx9UmxAqhU8flu8/1O0Ilmgpsb3w3Xy5w45/BpVZKhqSiUct.', NULL, 'BSFi', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:56', '2024-11-28 13:50:56', 0),
(1926, 'Rose Mae', 'Beltran', 'beltran@gmail.com', '$2y$10$lw/Jbwk.9TgS42.hsBhl9uF1llStNyt6ggS.ZOQv/xcy10TdPYK3O', NULL, 'BSFi', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:56', '2024-11-28 13:50:56', 0),
(1927, 'Manny', 'Gonzales', 'gonzales@gmail.com', '$2y$10$9sfKi2v4M.HQfd6Z03HBz.u2wzAN64C76XaBWXhfIIMjW3dNRAjcO', NULL, 'BSFi', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:56', '2024-11-28 13:50:56', 0),
(1928, 'Jowie', 'Goda', 'goda@gmail.com', '$2y$10$WAi4fT1HaWArR6m1uAJbFOe48PyuAoLdnZ6yKREJZhAgCIt68DpX2', NULL, 'BSFi', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:56', '2024-11-28 13:50:56', 0),
(1929, 'Marvelita', 'Rin', 'rin@gmail.com', '$2y$10$bRvK4z0x0BT8KtdHEqOYa.C0g6ZlWVuKhSEOetzZTw3kUYXcK4Yy.', NULL, 'BSFi', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:56', '2024-11-28 13:50:56', 0),
(1930, 'Eralyn', 'Magallanes', 'magallanes@gmail.com', '$2y$10$gZTo1LgFslq01D8XnmSWweWXBc4O/BIWK6krvQ5cRqXYESbBwpXcW', NULL, 'BSFi', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:56', '2024-11-28 13:50:56', 0),
(1931, 'Rona Mae', 'Esmani', 'esmani@gmail.com', '$2y$10$2fzRGcZTM/k/5Ev8zg8R..y/T/LJCXRcDgjimCXWakh0tJ4hI/37y', NULL, 'BSFi', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:57', '2024-11-28 13:50:57', 0),
(1932, 'Clark Eugene', 'Lopez', 'lopez@gmail.com', '$2y$10$r3cwBFlk5NvtTg1EV4Xl2.b6E2mq5aStqs1FAWercW/yNmixE0F0m', NULL, 'BSFi', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:57', '2024-11-28 13:50:57', 0),
(1933, 'Mekayla', 'Lumata', 'lumata@gmail.com', '$2y$10$S2UyJ/VsT5lqMMPzw9oALuA77t2fPixJWUsuJ1dj51YPJaB5U3Pgq', NULL, 'BSFi', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:57', '2024-11-28 13:50:57', 0),
(1934, 'Kerby Klier', 'Aroy', 'aroy@gmail.com', '$2y$10$B726cVl.tLhV7.LuFVqjrOUzX226sMx90lSyyf5YsxkUaGtqLIwtm', NULL, 'BSFi', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:57', '2024-11-28 13:50:57', 0),
(1935, 'Shanealle', 'Cagas', 'cagas@gmail.com', '$2y$10$ZEO.Eaf/8swheLTAaHPYdOgOG9pQ.KVgYq2PPemFbJrCEcVZmbaza', NULL, 'BSFi', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:57', '2024-11-28 13:50:57', 0),
(1936, 'Carlo', 'Montehermoso', 'montehermoso@gmail.com', '$2y$10$auPbtctc4Ys2irOPr5Gmd.CP62fbOaXb7CMA37dDiwZgTMqrWXqYu', NULL, 'BSFi', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:57', '2024-11-28 13:50:57', 0),
(1937, 'John Michael', 'Eme', 'eme@gmail.com', '$2y$10$4Cct01YxWAaGRShFha5dzehF.bbRH6LecIb9p1uXbaerDgbW4rtu.', NULL, 'BSFi', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:57', '2024-11-28 13:50:57', 0),
(1938, 'Reca', 'Saavedra', 'saavedra@gmail.com', '$2y$10$SpWD/QsN7PNVlPslx1QiNemoby4TzaBwSdbL.OXuVLj0MAFu4SpEm', NULL, 'BSFi', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:57', '2024-11-28 13:50:57', 0),
(1939, 'Jhunry', 'Abonita', 'abonita@gmail.com', '$2y$10$DpStmRpo6M2NJYCdyfKdWO6VGJQbAHugtPQxeS1tc05PXOWgho7cy', NULL, 'BSFi', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:58', '2024-11-28 13:50:58', 0),
(1940, 'Jesmark', 'Necosia', 'necosia@gmail.com', '$2y$10$28C5dt9WcjqeBzUQifXsjuOQLUH.GVLfUHCOFp3lj5nhMVKvc3HAS', NULL, 'BSFi', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:58', '2024-11-28 13:50:58', 0),
(1941, 'Akhiera', 'Plando', 'plando@gmail.com', '$2y$10$B.MN5Gg74mE7bjJXRxMAQeVfQHQ0.9jNW2ggQmGvVQrIQz.4kgF1S', NULL, 'BSFi', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:58', '2024-11-28 13:50:58', 0),
(1942, 'Emely', 'Juban', 'juban@gmail.com', '$2y$10$PgiRnP8Xwj/tMt2tDUMGBOSqAW178dMS4L4FpuVvvw9Kg8sCNzuqe', NULL, 'BSFi', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:58', '2024-11-28 13:50:58', 0),
(1943, 'Janene', 'Legaspi', 'legaspi@gmail.com', '$2y$10$Szsa.KGLSVppQxH22LPMTOr.lBtpDiMBJsMWADWtk7xQuLIDpt.N.', NULL, 'BSFi', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:58', '2024-11-28 13:50:58', 0),
(1944, 'Arabella', 'Angcoy', 'angcoy@gmail.com', '$2y$10$unkcZ7CeOWXwinXpxSFOA.jbtkF82v/kA9Ep3Zz7Tm.cKQ69Y/k2O', NULL, 'BSFi', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:58', '2024-11-28 13:50:58', 0),
(1945, 'Ivy', 'Ajoc', 'ajoc@gmail.com', '$2y$10$oFvL3IlIn8oG5IgqiI/2AuHaM6xl2TpGvgbJi7ZqXMWC9K5Jl06lm', NULL, 'BSFi', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:58', '2024-11-28 13:50:58', 0),
(1946, 'Jennifer', 'Pacaldo', 'pacaldo@gmail.com', '$2y$10$h2/sXpR7948YERX8RV6oheFhoLguHckHG/MULZ7YYdZQd71cW0ady', NULL, 'BSFi', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:58', '2024-11-28 13:50:58', 0),
(1947, 'Diana', 'Salva', 'salva@gmail.com', '$2y$10$N.ylXMKnBkEQyPtZk.a9SOYDVG8jN8WzDjAfHrYDNcEfR1fqy6vRm', NULL, 'BSFi', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:58', '2024-11-28 13:50:58', 0),
(1948, 'Aiza', 'Añosa', 'añosa@gmail.com', '$2y$10$xfWkQqLiycSkiq49xkQxb.Vizwkf6HaZKTa/psrbRPq6e6Wcyl7HC', NULL, 'BSFi', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:58', '2024-11-28 13:50:58', 0),
(1949, 'Celso, Jr.', 'Mendez', 'mendez@gmail.com', '$2y$10$4V1dwOpazNAYkAYIk9.RB.6msox54mDaRSYFAiLwK1aziiROskIyq', NULL, 'BSFi', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:58', '2024-11-28 13:50:58', 0),
(1950, 'Kenneth', 'Coñado', 'coñado@gmail.com', '$2y$10$2y0QKzxLRWCkzwKm8RSate9GsK5D7ed3/gvqJ.6V.R9s5mlUde7Y.', NULL, 'BSFi', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:59', '2024-11-28 13:50:59', 0),
(1951, 'Anna Rose', 'Florida', 'florida@gmail.com', '$2y$10$gIMrNxymNs/AT11UumFCG.GxxZD9CH8G8rmbCKMJhTNLXiUfceCEW', NULL, 'BSFi', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:59', '2024-11-28 13:50:59', 0),
(1952, 'Ivei', 'Dalida', 'dalida@gmail.com', '$2y$10$DQg5QAqvyc/TXiz8wRNBaeUogG5YNNyV7uQQL5KYpvXle8ODWZhN.', NULL, 'BSFi', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:59', '2024-11-28 13:50:59', 0),
(1953, 'Rhuszel', 'Arcena', 'arcena@gmail.com', '$2y$10$DFDT0SOKIllusqPV8SOcYO5LgzbLuILXVH3Ssu4g/58GfKCa/RXuS', NULL, 'BSFi', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:59', '2024-11-28 13:50:59', 0),
(1954, 'Jasmine', 'Salizon', 'salizon@gmail.com', '$2y$10$7LMXNECYJH5cBO.it/8z9uPdGVznZpYB5Vndjuo/ZBzZdg7jp.ay6', NULL, 'BSFi', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:59', '2024-11-28 13:50:59', 0),
(1955, 'Shiela Mae', 'Lingo', 'lingo@gmail.com', '$2y$10$bWgU8F8KpIlSIpWqd5Rm4.Ojw2Oc1GLLIGuM9MfNDuTAn7gaQ6eJy', NULL, 'BSFi', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:59', '2024-11-28 13:50:59', 0),
(1956, 'Queeny Joy', 'Rubio', 'rubio@gmail.com', '$2y$10$X9DLLRtwIRNaH3rLBNcX7ORoIno5IDyrCbeG8NKYPmq0nW.w0uBci', NULL, 'BSFi', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:59', '2024-11-28 13:50:59', 0),
(1957, 'Jenny', 'Sabandal', 'sabandal@gmail.com', '$2y$10$u2BkhF5/eckiH1nqdvCs1e9JNrZuL5zHoC9ERjzC3mkBS0aeNCiYe', NULL, 'BSFi', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:59', '2024-11-28 13:50:59', 0),
(1958, 'Jessa Mae', 'Dagaas', 'dagaas@gmail.com', '$2y$10$/qpa87T.2xDjWcy.46FZK.l9CWCTRF3swqME/iRvftfVvt/qfraPm', NULL, 'BSFi', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:50:59', '2024-11-28 13:50:59', 0),
(1959, 'Rafael Ted', 'Villacin', 'villacin@gmail.com', '$2y$10$zeKHfXLvBEwWfPmogHucLegperv9HTXPdHxfFfvienV2rdnA6jxg2', NULL, 'BSFi', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:50:59', '2024-11-28 13:50:59', 0),
(1960, 'Reyben', 'Lopez', 'lopez@gmail.com', '$2y$10$2Gv4Cm/nJ1p41aXNIKoT0e0FCi7FeCzeJUXpXRCz6Gskb2CEN8/O6', NULL, 'BSFi', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:00', '2024-11-28 13:51:00', 0),
(1961, 'Dhyenna', 'Serdan', 'serdan@gmail.com', '$2y$10$zqPj61cNY2VVNVFzg7GdT.eWv3fNx86BNO7.a/DaQW.miR3Jhct6a', NULL, 'BSFi', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:00', '2024-11-28 13:51:00', 0),
(1962, 'Geraldine', 'Garing', 'garing@gmail.com', '$2y$10$ntNoKZbKV0a8WmSvEreCCOybrSseAItomnnRC48LULzRXUevD1hrm', NULL, 'BSFi', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:00', '2024-11-28 13:51:00', 0),
(1963, 'Richie Jim', 'Sabandal', 'sabandal@gmail.com', '$2y$10$7gB0MgOZn3qfvMMhVwZ9WOfku4PYhIxqXh4Nzy/jkO8AzbItbGpw2', NULL, 'BSFi', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:00', '2024-11-28 13:51:00', 0),
(1964, 'Rachalle', 'Taotao', 'taotao@gmail.com', '$2y$10$aWC0yw2xUiWyPhfiTAFGD.gsnhnm/dEdlBpZNzOJXVlHTzMYESYLO', NULL, 'BSFi', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:00', '2024-11-28 13:51:00', 0),
(1965, 'Maria Luz', 'Amparo', 'amparo@gmail.com', '$2y$10$kjdCfUNSzG5OwQ2XleCpCuKaobLS7rXZBBxOX2actPSwOSWUPMaqy', NULL, 'BSFi', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:00', '2024-11-28 13:51:00', 0),
(1966, 'Arianne', 'Natividad', 'natividad@gmail.com', '$2y$10$fOSnhe14Yvhk2ir6OOql4.adKz2CJu1O/8s1F0shdQEUshQS5wMOi', NULL, 'BSFi', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:00', '2024-11-28 13:51:00', 0),
(1967, 'Lorena', 'Capusoran', 'capusoran@gmail.com', '$2y$10$n4Kk7TRAPd6gPXx.SHD5euwspcpbB32Ao.va1U048Lo8PXZHbG2eC', NULL, 'BSFi', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:00', '2024-11-28 13:51:00', 0),
(1968, 'Kristien', 'Semblante', 'semblante@gmail.com', '$2y$10$7BydRAvs56n7bjjuyiHU0OR0Ot1J6Ij9X8E6zrR4nCq97x83lKVZS', NULL, 'BSFi', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:00', '2024-11-28 13:51:00', 0),
(1969, 'Rose Mylin', 'Pael', 'pael@gmail.com', '$2y$10$C25yzX.Ekh5cce2aRja3.egUv3.fGuBiuz1S.pqpOdBYu5yUuSjJe', NULL, 'BSFi', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:00', '2024-11-28 13:51:00', 0),
(1970, 'Princes Grace', 'Jesto', 'jesto@gmail.com', '$2y$10$wu5lPcNBA4MVUJbCMffu8ecoMPqdkiqNMatZAzYHVwo7GJYC405AW', NULL, 'BSFi', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:01', '2024-11-28 13:51:01', 0),
(1971, 'Nicole', 'Gay', 'gay@gmail.com', '$2y$10$vCCiiroRCS006RfCz2JHQugCarPv8aLMr8wy2sS13t396LhJV.u52', NULL, 'BSFi', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:01', '2024-11-28 13:51:01', 0),
(1972, 'Levy', 'Monghit', 'monghit@gmail.com', '$2y$10$CotMJAcxfmjf0vraM0ghIe58FtErDi/nTFgRnwr6c/5hJZcJkAQKS', NULL, 'BSFi', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:01', '2024-11-28 13:51:01', 0),
(1973, 'Edcel', 'Ruales', 'ruales@gmail.com', '$2y$10$5jGyVUBOySeqHKU9rReWNejxmQbKelUXOvmewEsTvZkoSVB.3paq2', NULL, 'BSFi', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:01', '2024-11-28 13:51:01', 0),
(1974, 'Joel', 'Resus', 'resus@gmail.com', '$2y$10$EK3bRA0ueHTFGdT/tj5F/eco7Y3gFUPsx0p82j6OlXOxwItFtO2s.', NULL, 'BSFi', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:01', '2024-11-28 13:51:01', 0),
(1975, 'Myline', 'Rosal', 'rosal@gmail.com', '$2y$10$WgTtcYDwILhujZLwNtqY.eWHzUcCAtiLTO9tjg1mep8Dk7XBh4Qkm', NULL, 'BSFi', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:01', '2024-11-28 13:51:01', 0),
(1976, 'Deacy', 'Banga', 'banga@gmail.com', '$2y$10$bsmIflopD7fB1KU69XnyoeGiks93k6mscezut83zdyhGQPekcCy26', NULL, 'BSFi', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:01', '2024-11-28 13:51:01', 0),
(1977, 'Joanna Amor', 'Lumayag', 'lumayag@gmail.com', '$2y$10$9IoQxo9LWB2mme5pcLI5Y.8YveOgxIfWwYW5Fa2X3OJOtB5RchhhG', NULL, 'BSFi', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:01', '2024-11-28 13:51:01', 0),
(1978, 'Jane', 'Macla', 'macla@gmail.com', '$2y$10$.YXShk1zi1hDmLtTnu0j5uXfJyo.czOgcyV4CKtYbkmILk0dUXuzC', NULL, 'BSFi', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:02', '2024-11-28 13:51:02', 0),
(1979, 'Alrich James', 'Castolo', 'castolo@gmail.com', '$2y$10$FqPpP1dJusxxZlfqJ8Rbl.NgHmmzgqDou68skAYOUZCc.YyfZtnnC', NULL, 'BSFi', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:02', '2024-11-28 13:51:02', 0),
(1980, 'Jomar', 'Vocal', 'vocal@gmail.com', '$2y$10$xQEfkwv8Rr0jBt/k9TT.ye8qDfuA35KZvKkjuD6HgzZ1cI8.DH0PC', NULL, 'BSFi', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:02', '2024-11-28 13:51:02', 0),
(1981, 'Ruche', 'Catambacan', 'catambacan@gmail.com', '$2y$10$KbMDLpNv36MEVhoJY2kpQ./D/BVb3J90bZNNwJjbVjWrn930KPhhy', NULL, 'BSFi', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:02', '2024-11-28 13:51:02', 0),
(1982, 'Realyn', 'Sebari', 'sebari@gmail.com', '$2y$10$zeld46rZdzaIgTXn2jRFxu4eFaglg9CPQk6IzxdVcB0nvUqoGkAD.', NULL, 'BSFi', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:02', '2024-11-28 13:51:02', 0),
(1983, 'Jolanie', 'Gumapac', 'gumapac@gmail.com', '$2y$10$rFQPTE1MN39XQ10bJdq6burb/ZUAAIRPZkC7xPuw8/MOQj/fqX4cq', NULL, 'BSFi', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:02', '2024-11-28 13:51:02', 0),
(1984, 'James Uno', 'Simpao', 'simpao@gmail.com', '$2y$10$Y7qvb3DM3xP7nOoxuHpKjOhGx29X0po/pYhok0vHv7YTXbsnSPZHq', NULL, 'BSFi', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:02', '2024-11-28 13:51:02', 0),
(1985, 'Sheva Marie', 'De Paz', 'de paz@gmail.com', '$2y$10$cbH86Bh4oE98JBDjZC7XgeXOgFqVs4M2S2ydbJZziRSbkAypCYEx2', NULL, 'BSFi', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:02', '2024-11-28 13:51:02', 0),
(1986, 'Allysa Mae', 'Ravelo', 'ravelo@gmail.com', '$2y$10$M3bv72tcyC.WLzvYoQrl6u.uVUskU04rfRiG2FtTzlh5TdSVIE8PW', NULL, 'BSFi', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:02', '2024-11-28 13:51:02', 0),
(1987, 'Julia Antonette', 'Capistrano', 'capistrano@gmail.com', '$2y$10$w3RVGfa/6FDL/Ydyvz37ieJGcuA3jMvsIfTtXS6X4Kjo.rqe/B/nq', NULL, 'BSFi', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:03', '2024-11-28 13:51:03', 0),
(1988, 'Zoraiza', 'Loquias', 'loquias@gmail.com', '$2y$10$ZLhVwtxfg4Q6wCaYdjQACeihYevPfhLTPp1HByyCjLpNqNEw3DuL.', NULL, 'BSFi', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:03', '2024-11-28 13:51:03', 0),
(1989, 'Jhon Marven', 'Sulinay', 'sulinay@gmail.com', '$2y$10$RdlThQaaP8o5e7zgBNAsKOQ2.lfy0rbL5KcXYTFD2I0A2zFmuH5Ce', NULL, 'BSFi', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:03', '2024-11-28 13:51:03', 0),
(1990, 'Justine Mae', 'Labastida', 'labastida@gmail.com', '$2y$10$jSSsbzYoO5lLtvXkIJQTLOrfbJ48yv7GajOm9vxkRuyKJlsBivC3S', NULL, 'BSFi', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:03', '2024-11-28 13:51:03', 0),
(1991, 'Cris Angel', 'Gerona', 'gerona@gmail.com', '$2y$10$77/AGI2nzMoPpln.n9k3seshfnLcWjRjgiyhNh8EHyRn67O8VWo0C', NULL, 'BSFi', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:03', '2024-11-28 13:51:03', 0),
(1992, 'Kenny Lee', 'Claveria', 'claveria@gmail.com', '$2y$10$0KIcpwX42q8QoMLsur7czemw/ERrIPWpFih9iMEsW0tKptX1JfR9.', NULL, 'BSFi', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:03', '2024-11-28 13:51:03', 0),
(1993, 'Jellan', 'Baloro', 'baloro@gmail.com', '$2y$10$kAPNXF.7hsm5p15yGikrl.pOuUcRs.Eb2L5lgiL/pECAqj2FMEqPC', NULL, 'BSFi', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:03', '2024-11-28 13:51:03', 0),
(1994, 'Ma. Liza', 'Baloro', 'baloro@gmail.com', '$2y$10$6WMULPG5idFBzP89Vq/76esKRtOejRC5i.iyAaLXYvOEuR5r8qvB2', NULL, 'BSFi', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:03', '2024-11-28 13:51:03', 0),
(1995, 'Marie Chris', 'Cabelos', 'cabelos@gmail.com', '$2y$10$Cmd2.h8rVd6jqOCB.S1nm.mocmLfpzXePHyL/irWfa1NqNnwT3Cnm', NULL, 'BSFi', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:03', '2024-11-28 13:51:03', 0),
(1996, 'Jonalyn', 'Magtahas', 'magtahas@gmail.com', '$2y$10$fq74VZg77hISw89J8dDJYOAAUHLHHWmyR9glrLB7ECFGi9A22XkVC', NULL, 'BSFi', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:04', '2024-11-28 13:51:04', 0),
(1997, 'Jell', 'Manlimos', 'manlimos@gmail.com', '$2y$10$vVBC6meHPYS.u/YRQ/9CJO4VsAg6ogjtb/LadZMMGMcu0BUqvS4UW', NULL, 'BSFi', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:04', '2024-11-28 13:51:04', 0),
(1998, 'Dochan Leigh', 'Martinez', 'martinez@gmail.com', '$2y$10$eDxG0fQDExxglhqE5zTby.KzwE3ZJCdch1k0JWJXt3kpFQaZkzTre', NULL, 'BSFi', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:04', '2024-11-28 13:51:04', 0),
(1999, 'Charlene', 'Amparo', 'amparo@gmail.com', '$2y$10$XGOCCbagXkPtcbNM.D72IeRwvso8nvjMeNy5ORj9qvauSrZPgAVWy', NULL, 'BSFi', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:04', '2024-11-28 13:51:04', 0),
(2000, 'Michelle', 'Munez', 'munez@gmail.com', '$2y$10$b0LVvQQu44DeNNDsYhjKvOZHnH6nlz9oUA9/LEZhLfczM4enENpS.', NULL, 'BSFi', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:04', '2024-11-28 13:51:04', 0),
(2001, 'Avegel', 'Garcia', 'garcia@gmail.com', '$2y$10$w0sovhJY8okqIYQWE/WpueVBVgVjAzSqxFw03w3u/jrgXBetz/FbO', NULL, 'BSFi', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:04', '2024-11-28 13:51:04', 0),
(2002, 'Liza Mae', 'Magadan', 'magadan@gmail.com', '$2y$10$Ig/b2j8q5Ctyb1DhxNCVjOgPbOjmgBTRvNXzqfrVCJSEfqOv1o44a', NULL, 'BSFi', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:05', '2024-11-28 13:51:05', 0),
(2003, 'Keanna Kate', 'Catambacan', 'catambacan@gmail.com', '$2y$10$bXF77qkegp6rhlX6nDMzteqxIL9rU9xHNNqkdIpYILd5kItt9KQvq', NULL, 'BSFi', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:05', '2024-11-28 13:51:05', 0),
(2004, 'Mark Joshua', 'Vinculado', 'vinculado@gmail.com', '$2y$10$bosSqn4XQRR83oonieEuiedBpN6JJLh2fkH./r/klZwXXFJYYtx3G', NULL, 'BSFi', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:05', '2024-11-28 13:51:05', 0),
(2005, 'Arnel', 'Oriquez', 'oriquez@gmail.com', '$2y$10$d4GHxdOoZakdw9Nv5t9xHOBLzJQS9JhJCF4MjDbz5RKLKiwPYsnLe', NULL, 'BSInfoTech', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:05', '2024-11-28 13:51:05', 0),
(2006, 'Giovannie', 'Agad', 'agad@gmail.com', '$2y$10$YUlkEvpN4Dw7dWJhEzFSNu0qnxHX2yhaZXJs3MxTT5pOmhgdgg0dK', NULL, 'BSInfoTech', 3, 'C', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:05', '2024-11-28 13:51:05', 0),
(2007, 'Gene Anrey', 'Elona', 'elona@gmail.com', '$2y$10$2Tm.CHXE8p7.Z4hvXp3Cn.5Icmi69GCoyGknA7bpZzQbJv7StdGAe', NULL, 'BSInfoTech', 3, 'C', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:05', '2024-11-28 13:51:05', 0);
INSERT INTO `student_registration` (`student_id`, `first_name`, `last_name`, `email`, `password`, `phone_number`, `department`, `year_level`, `section`, `enrollment_date`, `address`, `city`, `postal_code`, `country`, `date_of_birth`, `gender`, `emergency_contact_name`, `emergency_contact_number`, `created_at`, `updated_at`, `is_assigned`) VALUES
(2008, 'Fred', 'Cag-ong', 'cag-ong@gmail.com', '$2y$10$gGP768zpDIKoJOisBzt.aeiktwqjVXlNkmiLuuoS356BjKR8yDssK', NULL, 'BSInfoTech', 3, 'C', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:05', '2024-11-28 13:51:05', 0),
(2009, 'Jessalyn', 'Lontoco', 'lontoco@gmail.com', '$2y$10$/KqQXHfq4IJT2zAZ/f1LcOc4/oraphPtOqEIz6JSYYq9V3ecRCnCK', NULL, 'BSInfoTech', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:05', '2024-11-28 13:51:05', 0),
(2010, 'Angelyn', 'Espinosa', 'espinosa@gmail.com', '$2y$10$ahZZCK6UGA6KO99OxFvroeCxqB3pUf3tWZvdDeS.ZWXgCOZxThfai', NULL, 'BSInfoTech', 2, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:05', '2024-11-28 13:51:05', 0),
(2011, 'Cristian Keneth', 'Costorio', 'costorio@gmail.com', '$2y$10$ME44KA8UyEYAsLu2Q4NtoeF6aZ.xyl/Aup7BwnJhKfjTMMmFNTwuC', NULL, 'BSInfoTech', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:05', '2024-11-28 13:51:05', 0),
(2012, 'John Michael', 'Macaldo', 'macaldo@gmail.com', '$2y$10$2KuTGvfwO9hrUXNnZhA6reuoq5.zjCDlhR09fKW6OIh//FpVW7hxe', NULL, 'BSInfoTech', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:06', '2024-11-28 13:51:06', 0),
(2013, 'John Jasper', 'Gatila', 'gatila@gmail.com', '$2y$10$9F45NkryjA14aav7.LJyW.6iatpxGn.vLDIv.buBF8qrsxpEVxYO6', NULL, 'BSInfoTech', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:06', '2024-11-28 13:51:06', 0),
(2014, 'Regine', 'Abrea', 'abrea@gmail.com', '$2y$10$qCzIv4t7PoO.oY5mVX/itut33rUAKpcWJ2AIMUX0azKSFLw0dntJK', NULL, 'BSInfoTech', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:06', '2024-11-28 13:51:06', 0),
(2015, 'Mary Grace', 'Siega', 'siega@gmail.com', '$2y$10$Ct9mvcERx76o92LH7dEMR.XFzsPGSooOIGx5swD4849hls6ocPB2.', NULL, 'BSInfoTech', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:06', '2024-11-28 13:51:06', 0),
(2016, 'Rhemcel', 'Templa', 'templa@gmail.com', '$2y$10$oqt02DnF9hWqM0IuyjS.JOiDTPPenSn5CSntEaYkv3yY1xy4pu5.G', NULL, 'BSInfoTech', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:06', '2024-11-28 13:51:06', 0),
(2017, 'Cherryl', 'Mainit', 'mainit@gmail.com', '$2y$10$fVH0xiwz2CEIyRov5vzAnOj4xUAExpC/XfIP7qBNaVcktH4H.X9nO', NULL, 'BSInfoTech', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:06', '2024-11-28 13:51:06', 0),
(2018, 'Vanessa', 'Lawag', 'lawag@gmail.com', '$2y$10$cNxiY3dRVsIKOfJnqdFN8e2Nyn9MjrpHMauRrEZCex9Xr42rOWoja', NULL, 'BSInfoTech', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:06', '2024-11-28 13:51:06', 0),
(2019, 'Niña', 'Gay', 'gay@gmail.com', '$2y$10$YzRgAdWtcwkduA0jIR51zOuvVj8hgtQ5T5KC3krktc46Em6L1zdhG', NULL, 'BSInfoTech', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:06', '2024-11-28 13:51:06', 0),
(2020, 'Joedane', 'Simo', 'simo@gmail.com', '$2y$10$P/WNkr5SX.WlUXz4tELSB.U7mIj6eL.N1nLwcuZKIUGeKACYxHfnu', NULL, 'BSInfoTech', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:06', '2024-11-28 13:51:06', 0),
(2021, 'Maurine Angel', 'Noveda', 'noveda@gmail.com', '$2y$10$Q7cqS/H2F7gDNjgMgqa6POYnguRjgmYsmrcNkV.jwBj6l7QLKtopq', NULL, 'BSInfoTech', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:06', '2024-11-28 13:51:06', 0),
(2022, 'Sandra', 'Baul', 'baul@gmail.com', '$2y$10$aa8fc3eWE9Gh.M.Or21/b.ieLW5P/JihftOIKtkKOpXM0YmojHuxa', NULL, 'BSInfoTech', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:07', '2024-11-28 13:51:07', 0),
(2023, 'Jeliebeth', 'Galimba', 'galimba@gmail.com', '$2y$10$s85VCK8ruDhsdd/z37UuTuH4p2mj3Mje1GoEFFqp4SCopJ9oDYKpW', NULL, 'BSInfoTech', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:07', '2024-11-28 13:51:07', 0),
(2024, 'Ehla', 'Arellano', 'arellano@gmail.com', '$2y$10$I4HhLXXVZAYr.ApXpHDWSuS04L.5.BYHSm984gbhw2VQw9wxZAySK', NULL, 'BSInfoTech', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:07', '2024-11-28 13:51:07', 0),
(2025, 'Mari Jon', 'Himaya', 'himaya@gmail.com', '$2y$10$/mod9l2x4K2wArh3y5p/u.i/qfCYSMbuckkKd5SoICOklnrh.bfK.', NULL, 'BSInfoTech', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:07', '2024-11-28 13:51:07', 0),
(2026, 'Rico James', 'Sabandal', 'sabandal@gmail.com', '$2y$10$IYl8h9aqDbQ83B/aUaisMOC8xV5TX6uzKuHSIjcxAG4VXXKjwdK.i', NULL, 'BSInfoTech', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:07', '2024-11-28 16:08:27', 1),
(2027, 'Kylla Jane', 'Octobre', 'octobre@gmail.com', '$2y$10$4fMiWfo1il9DyTJ.TGXNIul3i5di3aaaCUtG9fv165VSwp9RVacX6', NULL, 'BSInfoTech', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:07', '2024-11-28 13:51:07', 0),
(2028, 'Mary Grace', 'Briones', 'briones@gmail.com', '$2y$10$9gd3EUk8yTPXKgfaJ7H48e3XP842iMD.ZplEC39crTrvLy2WNerkm', NULL, 'BSInfoTech', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:07', '2024-11-28 13:51:07', 0),
(2029, 'Ana Leona', 'Pontud', 'pontud@gmail.com', '$2y$10$vBQLXrhEwS0tqYkcbIqF1.rFhuEF3K5yXprDOV2V7UtolqDxEaNpa', NULL, 'BSInfoTech', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:07', '2024-11-28 13:51:07', 0),
(2030, 'Erica Ann', 'Subiaga', 'subiaga@gmail.com', '$2y$10$DOaZ5UNkhNi3y9FINPYPAeC0HhNZfYFgzMB1.hMqaSz8wmbgEcfzO', NULL, 'BSInfoTech', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:07', '2024-11-28 13:51:07', 0),
(2031, 'Jay', 'Sabalo', 'sabalo@gmail.com', '$2y$10$zASgszRIdzj/jU39ZOkSCumLUitPypTw4EiwB/dylJMGouFFcRssC', NULL, 'BSInfoTech', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:07', '2024-11-28 13:51:07', 0),
(2032, 'Anthony', 'Saguisa', 'saguisa@gmail.com', '$2y$10$ncEfFTQr8Hd2qLnp27VGGefz8bXyao1Sc7bQ68S5gTkeNLJZj6.Wi', NULL, 'BSInfoTech', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:08', '2024-11-28 13:51:08', 0),
(2033, 'Golda Mae', 'Culpa', 'culpa@gmail.com', '$2y$10$LlVU/7SFcDrMpDrkN88oJeWm7eEAr424qctyBfaqdC624zRZaAStm', NULL, 'BSInfoTech', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:08', '2024-11-28 13:51:08', 0),
(2034, 'Dianne', 'Olayvar', 'olayvar@gmail.com', '$2y$10$obKTjDhctfZjMuJHBDYRoOzzIJtq0asb.eU4FxIRwjtqD429MJC4S', NULL, 'BSInfoTech', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:08', '2024-11-28 13:51:08', 0),
(2035, 'Elmeraflor', 'Merka', 'merka@gmail.com', '$2y$10$mtPZn5RmEObBSZ1a/byPc.9HQ/IC3Sq10qt6PFE4qqDHjryuOfeQ6', NULL, 'BSInfoTech', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:08', '2024-11-28 13:51:08', 0),
(2036, 'Meryjie', 'Meking', 'meking@gmail.com', '$2y$10$nLrN3il6hutBJXPsC173IuPk6.l3dcJ1ibFAfNP6l6Hnkp8Jxbuju', NULL, 'BSInfoTech', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:08', '2024-11-28 13:51:08', 0),
(2037, 'Beberlly', 'Palconit', 'palconit@gmail.com', '$2y$10$hL37ioPalrLAJnLF4KiJ7.fR1Xr3anFIFCoAofx6ERbu89LEfrwPu', NULL, 'BSInfoTech', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:08', '2024-11-28 13:51:08', 0),
(2038, 'John Kenneth', 'Pamogas', 'pamogas@gmail.com', '$2y$10$eUOLYB4hfoPwDeqvw95LCO8eLv5pJqr/aSPyls82KyQHqdw2p0uny', NULL, 'BSInfoTech', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:08', '2024-11-28 13:51:08', 0),
(2039, 'Zal Gabriel', 'Banque', 'banque@gmail.com', '$2y$10$nHczVlVBoDY8nQsUWCnIJ.aVB7RhU4oVyqf7QQcfUgf1w9use8aBW', NULL, 'BSInfoTech', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:08', '2024-11-28 13:51:08', 0),
(2040, 'Mark Raymond', 'Loquias', 'loquias@gmail.com', '$2y$10$UxfCtCyTei1u/V9Hfp38PuJPfjlspgMtHsMR2JG.s8PH2Y.aEH5aa', NULL, 'BSInfoTech', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:08', '2024-11-28 13:51:08', 0),
(2041, 'Jomaico', 'Abusca', 'abusca@gmail.com', '$2y$10$sQPt2lTSqoMy443grjRXTenvjhtZDW3fW44LIfZQoCpm1sqD7k9SO', NULL, 'BSInfoTech', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:09', '2024-11-28 13:51:09', 0),
(2042, 'Angela', 'Ladao', 'ladao@gmail.com', '$2y$10$rbzCVoJ10kzW/eLXBxTaEulY9E6akIpJvSTX9M5/8JbdJkv1/Sdz.', NULL, 'BSInfoTech', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:09', '2024-11-28 13:51:09', 0),
(2043, 'Clarence Dave', 'Sulla', 'sulla@gmail.com', '$2y$10$e72eoF2w.kpPA2ptTPS1.uPf2UDMTvQDttEA8E/tSkW9NYbSHNJ5S', NULL, 'BSInfoTech', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:09', '2024-11-28 13:51:09', 0),
(2044, 'Melissa Mae', 'Sibunga', 'sibunga@gmail.com', '$2y$10$UTOWQx4bjdX/rg0/czas/.64536q1aJam5vjPnhT4poB9qiGclvSy', NULL, 'BSInfoTech', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:09', '2024-11-28 13:51:09', 0),
(2045, 'April Jean', 'Bucog', 'bucog@gmail.com', '$2y$10$xh6sspwtB1HkFat9hC8Rmuphk.UerkOzDSsO62GuKRKLvPndyPtz6', NULL, 'BSInfoTech', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:09', '2024-11-28 13:51:09', 0),
(2046, 'John Wendell', 'Cuadra', 'cuadra@gmail.com', '$2y$10$or1/xE/rGj4qUeGUPd4/kO3BPrHdPUcMUNIqVXJ4nqW7nUQu4BA.i', NULL, 'BSInfoTech', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:09', '2024-11-28 13:51:09', 0),
(2047, 'Aljohn Faith', 'Divinagracia', 'divinagracia@gmail.com', '$2y$10$nfmGJrOFTLA56YT6/bLDZuxQF5lTaFbcnywAit/ZmtAs6W1VuNd5i', NULL, 'BSInfoTech', 2, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:09', '2024-11-28 13:51:09', 0),
(2048, 'Helee Joy', 'Oppus', 'oppus@gmail.com', '$2y$10$31HzgYf.wPnSROgez8VPi.6P9Qm.3qwhllfunKD9JFZqpissa4YH.', NULL, 'BSInfoTech', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:09', '2024-11-28 13:51:09', 0),
(2049, 'Ira Marie', 'Salar', 'salar@gmail.com', '$2y$10$170MgVWJvY0uwcgq3s6aGuHbIPygz9ty6Y8NMLuLIKdyqqMSWP90C', NULL, 'BSInfoTech', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:09', '2024-11-28 13:51:09', 0),
(2050, 'Ryan', 'Baslot', 'baslot@gmail.com', '$2y$10$E7T17gtT0aQMLx4ri1xqD.43T4UC8IPbLFao24rcQtClNNr5WqeL.', NULL, 'BSInfoTech', 2, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:10', '2024-11-28 13:51:10', 0),
(2051, 'Ahnjellou', 'Gesulga', 'gesulga@gmail.com', '$2y$10$jvsD81OIeWEgOzLxPbSnb.nT3oOPn9AGSbNeNWv4wHzTHWQBFfLWC', NULL, 'BSInfoTech', 2, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:10', '2024-11-28 13:51:10', 0),
(2052, 'Dariel', 'Beronilla', 'beronilla@gmail.com', '$2y$10$NA5kve2L0GGjqSaBS6HK5ebFE/drrdzzRutBzim7fRF4ZUPXLU.7C', NULL, 'BSInfoTech', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:10', '2024-11-28 13:51:10', 0),
(2053, 'Janel', 'Astillero', 'astillero@gmail.com', '$2y$10$MhulXKFDHTo0j.NOCPrhpOiW.SGbsfUl1AAHu2Jh0JEaQK1.6HfVW', NULL, 'BSInfoTech', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:10', '2024-11-28 13:51:10', 0),
(2054, 'Kent', 'Dayola', 'dayola@gmail.com', '$2y$10$5lUqrrMmTg4LbVaYKz08re9ZUmDlaG0pA/vtFp7D/RGs5wq6y.CY6', NULL, 'BSInfoTech', 3, 'C', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:10', '2024-11-28 13:51:10', 0),
(2055, 'Gherelyn', 'Sampinit', 'sampinit@gmail.com', '$2y$10$4OchySZCoUZHIgz9Kf8c0ObiLKPeAIN81fk.TsRZlSrc5IvBy2aCq', NULL, 'BSInfoTech', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:10', '2024-11-28 13:51:10', 0),
(2056, 'Niñan', 'Layo', 'layo@gmail.com', '$2y$10$iKYGzxrx.SM1p230DKB55.gAjlEXP9ham.g6OjvgqvOHWxat3R4hS', NULL, 'BSInfoTech', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:10', '2024-11-28 13:51:10', 0),
(2057, 'John Lloyd', 'Moralde', 'moralde@gmail.com', '$2y$10$rDMp9/hBn73zSIEQikmiQejwL6TBcRaimvvBo0YGtYZtvx452drcy', NULL, 'BSInfoTech', 3, 'C', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:10', '2024-11-28 13:51:10', 0),
(2058, 'Jason', 'Melicado', 'melicado@gmail.com', '$2y$10$YBMSUs/U5ORrTKYLd8RJhO7kG6yGUgpjhFX5EsUrc6R3Sml/nNjkq', NULL, 'BSInfoTech', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:10', '2024-11-28 13:51:10', 0),
(2059, 'Renzo Marlou', 'LLanto', 'llanto@gmail.com', '$2y$10$QnPkuUoGOq3A5Mad0ha0hOFN7SRHh3nvmjr2pxaokhoGFL1SBNYDu', NULL, 'BSInfoTech', 3, 'C', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:10', '2024-11-28 13:51:10', 0),
(2060, 'Righe', 'Timkang', 'timkang@gmail.com', '$2y$10$yqD7xVZWGFDjiEifBk529OE8cj6jp5zRCDQATkc/LvWjkRTD0K93q', NULL, 'BSInfoTech', 3, 'C', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:10', '2024-11-28 13:51:10', 0),
(2061, 'John Mark', 'Vecina', 'vecina@gmail.com', '$2y$10$LGAjnFSNwN5gk8u/dVgwVOGl7/GnGM7DFSwajA.mmBUEkjFNzAhW6', NULL, 'BSInfoTech', 3, 'C', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:11', '2024-11-28 13:51:11', 0),
(2062, 'Jiah', 'Seno', 'seno@gmail.com', '$2y$10$nPoehG4DfsE//2XiElCYLeGxVgSFYUQgaU0t27y62vfTRv.rmgEYO', NULL, 'BSInfoTech', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:11', '2024-11-28 13:51:11', 0),
(2063, 'Ranniel', 'Capilitan', 'capilitan@gmail.com', '$2y$10$G/9/7dMYoDkjuFZIvlMZi./x/PbSahjQZJADZ9TCFGJxTpAbUTE/u', NULL, 'BSInfoTech', 3, 'C', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:11', '2024-11-28 13:51:11', 0),
(2064, 'Roland, Jr.', 'Nacano', 'nacano@gmail.com', '$2y$10$Gp1SUp6dR9kCynX4rs02puIBnAcIHebT6HIP4nmpH7nHNvWMDPhaG', NULL, 'BSInfoTech', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:11', '2024-11-28 13:51:11', 0),
(2065, 'Donessa Merced', 'Castillon', 'castillon@gmail.com', '$2y$10$b94.2c7.HGLi40V4JR2i9.wAZwX3Gx2wxmHJC7.D0ZleikopuMzxm', NULL, 'BSInfoTech', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:11', '2024-11-28 13:51:11', 0),
(2066, 'Christian Carl', 'Cagurol', 'cagurol@gmail.com', '$2y$10$3ScnBiLLb30HIY6tDX0GIuGx3jJM5MrzO.X0lxQxL6qWwXfiHJcW2', NULL, 'BSInfoTech', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:11', '2024-11-28 13:51:11', 0),
(2067, 'Jayson', 'Napalan', 'napalan@gmail.com', '$2y$10$wmmGFQxaGMRjwhd.KrB.ruAseSpZ7OWR43pppOyf/4VyTVkot9.bG', NULL, 'BSInfoTech', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:11', '2024-11-28 13:51:11', 0),
(2068, 'Razel', 'Sescon', 'sescon@gmail.com', '$2y$10$Hwu3Y1PSaZfZ7G/Q9VFExedepPNL4Bdw7yA5Ugtbcbhw4g0v.WJ4W', NULL, 'BSInfoTech', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:11', '2024-11-28 13:51:11', 0),
(2069, 'Irene Mae', 'Cualteros', 'cualteros@gmail.com', '$2y$10$Z2fcUf/zHPQQSRDp4Y8LN.rx9G7ExrwUl5UXzwiGGLUZ2QLhqR.9.', NULL, 'BSInfoTech', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:11', '2024-11-28 13:51:11', 0),
(2070, 'Jamaica', 'Reloz', 'reloz@gmail.com', '$2y$10$VazBi5neQVFKR7cS6RC0TOIZWG23iItoHvgT5rg5WR0u0oho/eKki', NULL, 'BSInfoTech', 3, 'C', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:12', '2024-11-28 13:51:12', 0),
(2071, 'Shiena', 'Reloz', 'reloz@gmail.com', '$2y$10$IO14c5DWEY1aXWgqJPT8VOGSA5mCkk6a5VhA2McnWS3U/OS5PeHda', NULL, 'BSInfoTech', 3, 'C', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:12', '2024-11-28 13:51:12', 0),
(2072, 'Jerry Leo', 'Kaindoy', 'kaindoy@gmail.com', '$2y$10$5FWsY0MJCF9FaGxpAQEkPuZ2j5SKCv8eyfRZkANwHx9fIkFCV98da', NULL, 'BSInfoTech', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:12', '2024-11-28 13:51:12', 0),
(2073, 'Gerald', 'Daga', 'daga@gmail.com', '$2y$10$X3ugtCFWi7vG3xBIu8k0AuOpiQguDTcjfw20CesmS1i2Qf0K4Hula', NULL, 'BSInfoTech', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:12', '2024-11-28 13:51:12', 0),
(2074, 'Aaron Angelo', 'Lasala', 'lasala@gmail.com', '$2y$10$.hfF6Q32AiOqFlPDlQIE6ufH4bbImqEleS2/7lydG4uR6pJR7Z7q.', NULL, 'BSInfoTech', 3, 'C', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:12', '2024-11-28 13:51:12', 0),
(2075, 'Kirara', 'Baco', 'baco@gmail.com', '$2y$10$cBbpi4JkgpURZSCrw/eDF.kQuK9hU6nwm4w8Y7Et8KW4cDlIj4pNu', NULL, 'BSInfoTech', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:12', '2024-11-28 13:51:12', 0),
(2076, 'Rachel Mae', 'Tantoy', 'tantoy@gmail.com', '$2y$10$Xq7iZpuL9FhnA3Wx0NUgjOeWeg6uImlBhu1ieAIPCBXAVtRpDROHa', NULL, 'BSInfoTech', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:12', '2024-11-28 13:51:12', 0),
(2077, 'John Lloyd', 'Hagnaya', 'hagnaya@gmail.com', '$2y$10$KJ5pe/vM0s41YaD8tfkXgeuSDIxEtrIA6K3he5/3kFO6rfDdfn9pC', NULL, 'BSInfoTech', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:12', '2024-11-28 13:51:12', 0),
(2078, 'Marievel', 'Bermiso', 'bermiso@gmail.com', '$2y$10$GvIsNeACXH7qIARsj8T.WODyqarpUIVg8rr7VnBHU9pB43ZGGisd6', NULL, 'BSInfoTech', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:12', '2024-11-28 13:51:12', 0),
(2079, 'Sherie Pearl', 'De Paz', 'de paz@gmail.com', '$2y$10$XZYwOcrwLHYb1fjTVcVYPuSuAkAjJR9i8IqhzdDgoFa/oaGhsFfEa', NULL, 'BSInfoTech', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:12', '2024-11-28 13:51:12', 0),
(2080, 'Jesiel Ann', 'Salvaleon', 'salvaleon@gmail.com', '$2y$10$lDmmEwDECfhrHlLzEk7wJO/BnXpeVrbTqpnW95WNy88HaVLYgSeq.', NULL, 'BSInfoTech', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:12', '2024-11-28 13:51:12', 0),
(2081, 'Lea', 'Peña', 'peña@gmail.com', '$2y$10$jG7PwcfjNjoh4z6/SZzhVeP0iibvfxb7HVHumtOuFCw1tC0k6pnpe', NULL, 'BSInfoTech', 3, 'C', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:13', '2024-11-28 13:51:13', 0),
(2082, 'Myca', 'Maymay', 'maymay@gmail.com', '$2y$10$Pu4xwFnFrZHbAkHaAdFXeuy1arFtOmQ3t9.e5UEygcVuTow1zoWGW', NULL, 'BSInfoTech', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:13', '2024-11-28 13:51:13', 0),
(2083, 'Gemmalyn', 'Sumodlayon', 'sumodlayon@gmail.com', '$2y$10$reSSoKBWorNM.FA7662hT.XilgADeJ/r6qSKXDAm3rB0/YKkpH1Ue', NULL, 'BSInfoTech', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:13', '2024-11-28 13:51:13', 0),
(2084, 'Ana Lou', 'Catajoy', 'catajoy@gmail.com', '$2y$10$kfYQECVxsMMzivpaq.9CLOqK9.sUyIW/JX5cXf5NYCeMx1rPIrnhW', NULL, 'BSInfoTech', 3, 'C', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:13', '2024-11-28 13:51:13', 0),
(2085, 'Jevanie', 'Capon', 'capon@gmail.com', '$2y$10$alGoL0ujLIrOhRfRnVb5k.TaRU/Te3gsGwA7zV7GPlUqPH7YA.EYO', NULL, 'BSInfoTech', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:13', '2024-11-28 13:51:13', 0),
(2086, 'Erika', 'Olayvar', 'olayvar@gmail.com', '$2y$10$3EW9.6wDvQKjAqkdT8J7heuR/72Mj1XMoKRYjO8l9PzG.DGT7HbZG', NULL, 'BSInfoTech', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:13', '2024-11-28 13:51:13', 0),
(2087, 'Jelou', 'Rana', 'rana@gmail.com', '$2y$10$UCWhPSa8ZuDY1znsolhgZeX1hyYM3P/1pypjzFDd04q95Kt11SJR.', NULL, 'BSInfoTech', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:13', '2024-11-28 13:51:13', 0),
(2088, 'Manny', 'Merino', 'merino@gmail.com', '$2y$10$dz2PDWJcwWKOi9i1M./QyehNrJOcg0qi2Hl5O6qnq/PEHwDvOSI9C', NULL, 'BSInfoTech', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:13', '2024-11-28 13:51:13', 0),
(2089, 'Josephine', 'Bedon', 'bedon@gmail.com', '$2y$10$fxtc6MSME0KgC50I7mg9demad.ot1TwVTm0FDbYwYD6BoYn8qFvJm', NULL, 'BSInfoTech', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:13', '2024-11-28 13:51:13', 0),
(2090, 'Ronalyn', 'Pitogo', 'pitogo@gmail.com', '$2y$10$cE5x5pK.Yq4BPofW88AEPe32aGF5KdRV/ArLib069cL3qK6xixiKq', NULL, 'BSInfoTech', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:13', '2024-11-28 13:51:13', 0),
(2091, 'Kimberly', 'Palen', 'palen@gmail.com', '$2y$10$yewa5Fd/wFVqNrnVBincBeem7aGoOGbUJkeaK9SY0Otki2Fhrqqxq', NULL, 'BSInfoTech', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:14', '2024-11-28 13:51:14', 0),
(2092, 'Jericho', 'Timkang', 'timkang@gmail.com', '$2y$10$Ja1hHWeluoxUBvFYYbsjbui9AvqFmMr2U8IIxkvfGrhDTaEl669Da', NULL, 'BSInfoTech', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:14', '2024-11-28 13:51:14', 0),
(2093, 'Roshpet Jay', 'Diapolet', 'diapolet@gmail.com', '$2y$10$f2jFFCucBQrhzTFTN69Ikuq9FUxy8a7CH4qmETAbS6qDkZz1kavry', NULL, 'BSInfoTech', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:14', '2024-11-28 13:51:14', 0),
(2094, 'Lester', 'Pizon', 'pizon@gmail.com', '$2y$10$HYK6OlYPshR0sgvXNwcKDuTU4Od6y5uG4sgks2QgWrVPwAsuWa7Pe', NULL, 'BSInfoTech', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:14', '2024-11-28 13:51:14', 0),
(2095, 'Harold', 'Piramede', 'piramede@gmail.com', '$2y$10$TXv5.kJunTNWwVPZzBsoHee.xl60wspBOmqKuM1lFrXwQzA7.FoSy', NULL, 'BSInfoTech', 3, 'C', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:14', '2024-11-28 13:51:14', 0),
(2096, 'Jessica', 'Tomon', 'tomon@gmail.com', '$2y$10$ckmK62qsEgW4T7U4Oxhmeufwsm6vMdVPGqfxaY7PttQVJt6Yuh87.', NULL, 'BSInfoTech', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:14', '2024-11-28 13:51:14', 0),
(2097, 'Decemae', 'Robles', 'robles@gmail.com', '$2y$10$OV4zIcMwPeRT0iBfmixhGefip9XXacPMkLUm9WrE2FUBAbC8586bq', NULL, 'BSInfoTech', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:14', '2024-11-28 13:51:14', 0),
(2098, 'Ruby', 'Tomon', 'tomon@gmail.com', '$2y$10$Cpn2QG.NdmZm3cqfOZw9VOb4LBJAAjlyRWDzOmI39RFTw66ghbrx.', NULL, 'BSInfoTech', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:14', '2024-11-28 13:51:14', 0),
(2099, 'Jhon Christiane', 'Amolato', 'amolato@gmail.com', '$2y$10$Fd2be7ZGWE4MqEBWBKfwe.oyaSYRtO0VfnLz090MEfGZlqWBachYS', NULL, 'BSInfoTech', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:14', '2024-11-28 13:51:14', 0),
(2100, 'John Michael', 'Monteza', 'monteza@gmail.com', '$2y$10$M7OdtbEhfDFrnmB865eR9OFeKO2lwaoVHIVE1AR/pAOiKJ05TLZ0a', NULL, 'BSInfoTech', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:14', '2024-11-28 13:51:14', 0),
(2101, 'Joshua Luis', 'Alboleras', 'alboleras@gmail.com', '$2y$10$Ex9sbCOXdecox492wjnl3eGDJPXp7zJxawNEQBnWjZm/DFwub7ITK', NULL, 'BSInfoTech', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:15', '2024-11-28 13:51:15', 0),
(2102, 'Romwel', 'Bayona', 'bayona@gmail.com', '$2y$10$KCUHknQG1ZEuOeKF35uj/uzen0Soz2eBJ0jPF5iTauBjuHZX.Kd6y', NULL, 'BSInfoTech', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:15', '2024-11-28 13:51:15', 0),
(2103, 'Adrian', 'Bernales', 'bernales@gmail.com', '$2y$10$mxtV4Zi51gS/uE31GqBvA.sxHX0hq3C.BgsTSX/I7Rp3AVk1D7j7C', NULL, 'BSInfoTech', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:15', '2024-11-28 13:51:15', 0),
(2104, 'Mark Steven', 'Peligro', 'peligro@gmail.com', '$2y$10$Tm1j6Sj2zXejQC0v885sUeekxMcArlVm80M8.CTQwuX044qH4VZW.', NULL, 'BSInfoTech', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:15', '2024-11-28 13:51:15', 0),
(2105, 'Jay', 'Maunes', 'maunes@gmail.com', '$2y$10$gutY/6AOjCCe1Qe0CD7mgOP5vlrhahzPjxOraPQnEAXfOeWW9y7ji', NULL, 'BSInfoTech', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:15', '2024-11-28 13:51:15', 0),
(2106, 'Trini', 'Cabel', 'cabel@gmail.com', '$2y$10$3idaNqAWDvWrcTktsQnWCOfNIKXOtrC.lFf3.h6Ql8TPDWbCqxYUa', NULL, 'BSInfoTech', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:15', '2024-11-28 13:51:15', 0),
(2107, 'Chevy Love', 'Saja', 'saja@gmail.com', '$2y$10$RcCKFzBvMrd5EqG2jax7u.9fwZrai8x4ys6kxRwLoru2Qp6bad/Ju', NULL, 'BSInfoTech', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:15', '2024-11-28 13:51:15', 0),
(2108, 'Alzelou', 'Tagalog', 'tagalog@gmail.com', '$2y$10$f./DNsJfxGaeG/yo9ngxpOzuhdRx.EuUeEFIY8uyN9zL4rzqUDb5O', NULL, 'BSInfoTech', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:15', '2024-11-28 13:51:15', 0),
(2109, 'Jamail', 'Mangutara', 'mangutara@gmail.com', '$2y$10$zX.TTpbTZljkW./cBfKE4.HenGWxsnB6593CmeIg54g/6X34T/IgC', NULL, 'BSInfoTech', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:15', '2024-11-28 13:51:15', 0),
(2110, 'Jose Emmanuel', 'Lagura', 'lagura@gmail.com', '$2y$10$80CAWBVerWGWkhPYBRzm/eEZrONieta0J0oMpMAFQAb61KMmSCwTW', NULL, 'BSInfoTech', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:15', '2024-11-28 13:51:15', 0),
(2111, 'Janssen', 'Requierme', 'requierme@gmail.com', '$2y$10$qKm5zplaK07mtO/T5F2KsO6isJPpj4zPUnoStCbEM9K9djYsZJeuu', NULL, 'BSInfoTech', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:16', '2024-11-28 13:51:16', 0),
(2112, 'Jovelyn', 'Gisulga', 'gisulga@gmail.com', '$2y$10$FUck5SkQ3D1yrfAffABqKukVAEv/NxckR/jEUYgxqn8ooCnnd71sK', NULL, 'BSInfoTech', 3, 'C', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:16', '2024-11-28 13:51:16', 0),
(2113, 'Melanie', 'Nuñez', 'nuñez@gmail.com', '$2y$10$1vM1S4k7ELdR1oq4tA5t5uWyttO6HDCZpzkB0BA1CGyiTgKFrUZZW', NULL, 'BSInfoTech', 3, 'C', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:16', '2024-11-28 13:51:16', 0),
(2114, 'Glaizel', 'Amper', 'amper@gmail.com', '$2y$10$SRaJK3u4urGrv16FvntODel3Y5R1Vjk3Yem7xWRZwwShZ/DE.aWoC', NULL, 'BSInfoTech', 3, 'C', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:16', '2024-11-28 13:51:16', 0),
(2115, 'Rufa Mae', 'Daniel', 'daniel@gmail.com', '$2y$10$KxVcwSJZf5QaGdbuCBj7Cew8KnT6J1xbUMapxS/a4tDFz3iDKGdQS', NULL, 'BSInfoTech', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:16', '2024-11-28 13:51:16', 0),
(2116, 'Jerrel Angel', 'Padalapat', 'padalapat@gmail.com', '$2y$10$N1Ps33P8HNLnqaAtyRgeXOzINv8JR59o/Bw7NQtTVJavCx/8qo.4S', NULL, 'BSInfoTech', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:16', '2024-11-28 13:51:16', 0),
(2117, 'Nikki', 'Rodes', 'rodes@gmail.com', '$2y$10$e36Ay8RJt05PoaAVKYYz4uvyVTROy6O/.qGPN/cTIOcuB7Z46QhhK', NULL, 'BSInfoTech', 3, 'C', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:16', '2024-11-28 13:51:16', 0),
(2118, 'Chelsea', 'Formentera', 'formentera@gmail.com', '$2y$10$GSjcAcTQj6n.muBWMhPlneLmca1tFce4M7t9x3o.Bqorlauw71y72', NULL, 'BSInfoTech', 3, 'C', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:16', '2024-11-28 13:51:16', 0),
(2119, 'Marielle', 'Verano', 'verano@gmail.com', '$2y$10$rELw9ZXiWMsEoKDGUAPiHu679qAXr2wIynvSlccXiQYr9.vDsT542', NULL, 'BSInfoTech', 3, 'C', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:16', '2024-11-28 13:51:16', 0),
(2120, 'Alyssa Blessie', 'Siega', 'siega@gmail.com', '$2y$10$Qfg4POOWSnhDHN6Fr4A6NOlRNp3TuHRGplw9vuubcR1XGBVTBHojG', NULL, 'BSInfoTech', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:17', '2024-11-28 13:51:17', 0),
(2121, 'Jan Mar', 'Maquilang', 'maquilang@gmail.com', '$2y$10$nmZEZ2aUzddkxvaREzcMC.600e6294plvEQj0JlFCRiGp56df9UbS', NULL, 'BSInfoTech', 3, 'C', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:17', '2024-11-28 13:51:17', 0),
(2122, 'Francis Ryan', 'Rebaldo', 'rebaldo@gmail.com', '$2y$10$MHrfGHkWCSGLsscabkt7C.hN2hSWWx7yKpIaWNMwnzEVE6cYcualu', NULL, 'BSInfoTech', 3, 'C', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:17', '2024-11-28 13:51:17', 0),
(2123, 'Christian', 'Trimucha', 'trimucha@gmail.com', '$2y$10$bzhJUE1UH5xLafL4jwEjOuDXnphBTJi8QzFz0JGd9PMGa.OyKEcjG', NULL, 'BSInfoTech', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:17', '2024-11-28 13:51:17', 0),
(2124, 'Jake Laurence', 'Tambis', 'tambis@gmail.com', '$2y$10$Bz8gzmUYVpUUvJ7JU1U/OuZrbOPsE5SpmU7QtjoQoowGaBcnvshw2', NULL, 'BSInfoTech', 3, 'C', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:17', '2024-11-28 13:51:17', 0),
(2125, 'Arielle Kate', 'Mosot', 'mosot@gmail.com', '$2y$10$wG2jZB0pptiKPWnczKpNHOPQUZ795zMYMw8ljXoKnQlSa0PRLG34i', NULL, 'BSInfoTech', 3, 'C', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:17', '2024-11-28 13:51:17', 0),
(2126, 'Jireh Faith', 'Ilogon', 'ilogon@gmail.com', '$2y$10$xQ5ntfV03Ih8jSeR2mMGCuxRS8oFvbKECGnUPFvnwxNp8MJr3Ynta', NULL, 'BSInfoTech', 3, 'C', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:17', '2024-11-28 13:51:17', 0),
(2127, 'Jessica', 'Flores', 'flores@gmail.com', '$2y$10$MJ30XhMtvvpbB2LToROlj.CMs8o4GAzgO3ze1pKx3WqJOdkTQr.cu', NULL, 'BSInfoTech', 3, 'C', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:17', '2024-11-28 13:51:17', 0),
(2128, 'James', 'Sabesaje', 'sabesaje@gmail.com', '$2y$10$kME5aah8FpBfs/LWgydkd.25vipFiulky/HpBw8lcf/KIvVQBo4Vq', NULL, 'BSInfoTech', 3, 'C', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:17', '2024-11-28 13:51:17', 0),
(2129, 'Hannah', 'Pagola', 'pagola@gmail.com', '$2y$10$VeXO.at.0wU8bNSIeYRQSOjXXqS0Gb8mMvOLOjdWvxBtNipCajXh2', NULL, 'BSInfoTech', 3, 'C', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:17', '2024-11-28 13:51:17', 0),
(2130, 'Loren', 'Salva', 'salva@gmail.com', '$2y$10$WdW6NyeM9ll9PuxEkuV/beEDigmn98xeocammPPldrEnWpIDKOF9W', NULL, 'BSInfoTech', 3, 'C', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:18', '2024-11-28 13:51:18', 0),
(2131, 'Romelyn', 'Guzmana', 'guzmana@gmail.com', '$2y$10$1rR4oH79v.vVdhyOJ6bEGupu3CAZd.AQ9CjShUKQLIHukW1VmPU2.', NULL, 'BSInfoTech', 3, 'C', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:18', '2024-11-28 13:51:18', 0),
(2132, 'Mark Angelo', 'Lasala', 'lasala@gmail.com', '$2y$10$F1GexKh9iMdko0tLODwbeuJrjSUhbVGSa7MIE.ZNZazFwHTr/S9/a', NULL, 'BSInfoTech', 3, 'C', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:18', '2024-11-28 13:51:18', 0),
(2133, 'Jericho', 'Espinosa', 'espinosa@gmail.com', '$2y$10$BCfcrsb0PlYoSrZDC4nD0ugQ3dQhwDH7RDMSJgZqZGzYI8U48YdXy', NULL, 'BSInfoTech', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:18', '2024-11-28 13:51:18', 0),
(2134, 'Chris Vincent', 'Gesulga', 'gesulga@gmail.com', '$2y$10$euwKRz89g2R.TrU3leL3OeQXpEbtT8lq2K9eaxpiGKmk3e1QUveY2', NULL, 'BSInfoTech', 3, 'C', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:18', '2024-11-28 13:51:18', 0),
(2135, 'Mark Marie', 'Luengo', 'luengo@gmail.com', '$2y$10$0PECrljhd8hpoksU/IoF2.tU4rYGkKcugV/houJ7eP8zCky.cEuNe', NULL, 'BSInfoTech', 3, 'C', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:18', '2024-11-28 13:51:18', 0),
(2136, 'Leonel', 'Abrea', 'abrea@gmail.com', '$2y$10$Vi6C0ApW79NPUIkm6MVoa.fPVt1m/disk7fOoph8/MonFS3iUcJii', NULL, 'BSInfoTech', 2, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:18', '2024-11-28 13:51:18', 0),
(2137, 'Jhoann Mae', 'Gesulga', 'gesulga@gmail.com', '$2y$10$AbcAuiaD8j7Ccv0BAWTEVuxJxNwvMMyJexlH.2a9KtSEkFj7dmG.C', NULL, 'BSInfoTech', 2, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:18', '2024-11-28 13:51:18', 0),
(2138, 'Elyn Joy', 'Batalon', 'batalon@gmail.com', '$2y$10$0mH73NaDahr2gjsQGXbGceaXmuUmS0RIJAIJ68kbiWr7xxy09xega', NULL, 'BSInfoTech', 2, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:18', '2024-11-28 13:51:18', 0),
(2139, 'Vismark', 'Cotanda', 'cotanda@gmail.com', '$2y$10$tY0nnijJCv9hW6d3a5gP7.5Y9IuHUQeTeC6W5X7NZ/ZTKthf1t4h6', NULL, 'BSInfoTech', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:18', '2024-11-28 13:51:18', 0),
(2140, 'Christen', 'Amparo', 'amparo@gmail.com', '$2y$10$F8mmF6uLFAFGGmEVNeSHL.7dimm3zCk89ILkhD2FDjGdWqIs1/srK', NULL, 'BSInfoTech', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:18', '2024-11-28 13:51:18', 0),
(2141, 'Akissah Beth', 'Apilan', 'apilan@gmail.com', '$2y$10$b4S/EZAgcDKg70GBstw1E.wxyQQUBpg3HM7eaUPApkAaLloEaXeJa', NULL, 'BSInfoTech', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:19', '2024-11-28 13:51:19', 0),
(2142, 'Clarice', 'Gumapi', 'gumapi@gmail.com', '$2y$10$rela1JVMDTCDbl/s92e8b.vteXmQdZ2iRMXVDI0zKSQ2YegarxcY6', NULL, 'BSInfoTech', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:19', '2024-11-28 13:51:19', 0),
(2143, 'Rian Danz', 'Ruales', 'ruales@gmail.com', '$2y$10$juUKEzNjctqM9YRaxZg.X.Z0A1E6gQOA4AlhThunMz4EdGZDYvDa.', NULL, 'BSInfoTech', 2, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:19', '2024-11-28 13:51:19', 0),
(2144, 'Karyl', 'Gesto', 'gesto@gmail.com', '$2y$10$tDDfm7Basfz0TlnEeBCt3OipvXak38G1hCyTuJ/vSecHS1C5/dofW', NULL, 'BSInfoTech', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:19', '2024-11-28 13:51:19', 0),
(2145, 'Leanne Krista', 'Vilbar', 'vilbar@gmail.com', '$2y$10$FkK16GXdHskn2XsOzdKVf.q84zrl5sbICDCJ9VP5V5gE4dTdYuSQC', NULL, 'BSInfoTech', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:19', '2024-11-28 13:51:19', 0),
(2146, 'Anna Mae', 'Guzon', 'guzon@gmail.com', '$2y$10$qdvfVnskfd9GKY7ppgc.jOmvVRBGFYrHDZKi6UGjGy.JOLsZ/G5x.', NULL, 'BSInfoTech', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:19', '2024-11-28 13:51:19', 0),
(2147, 'Danica Marie', 'Cabahug', 'cabahug@gmail.com', '$2y$10$xReoSXsHPOJV72uFA3GCvOtkGDCnzUWC7b06NItg75dGtAsk7a.Je', NULL, 'BSInfoTech', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:19', '2024-11-28 13:51:19', 0),
(2148, 'Danilo, Jr.', 'Dumagat', 'dumagat@gmail.com', '$2y$10$esTZP8.0Y4WLvRMfh4CfpurI04tCht3SS1aYlwXlq5FVTXlwbHeu.', NULL, 'BSInfoTech', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:19', '2024-11-28 13:51:19', 0),
(2149, 'Baby Charlot', 'Reyes', 'reyes@gmail.com', '$2y$10$L9tOsLID0gqjwup6Zc4xf.h4aO4JXZS70icWMGmtBFyaLcWUL/4le', NULL, 'BSInfoTech', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:19', '2024-11-28 13:51:19', 0),
(2150, 'Marrisa', 'Ruales', 'ruales@gmail.com', '$2y$10$7COFfEBsvML4NHQRefk3be8HNUDZ7wWU.GsLapyLaIQ3BBsCAtAAe', NULL, 'BSInfoTech', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:19', '2024-11-28 13:51:19', 0),
(2151, 'Carmela', 'Hernandez', 'hernandez@gmail.com', '$2y$10$aGvDZ2RvechGSJXj8EGNqu.nHsb7DrUlP5ZrCISF2P.GAnYAaEthe', NULL, 'BSInfoTech', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:19', '2024-11-28 13:51:19', 0),
(2152, 'James', 'Cabillada', 'cabillada@gmail.com', '$2y$10$0gdK0QHY9CArUlzUE53GN.UZ5BkSc1qY2Usi/3t7X2d7alpdtTg0C', NULL, 'BSInfoTech', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:20', '2024-11-28 13:51:20', 0),
(2153, 'Karyl', 'Viure', 'viure@gmail.com', '$2y$10$4S8NigznhmfTGFaWFYgGeebS412/ADDIEzVXFdgbdKZfmo53HDim.', NULL, 'BSInfoTech', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:20', '2024-11-28 13:51:20', 0),
(2154, 'Cherry Ann', 'Himo', 'himo@gmail.com', '$2y$10$n1OAESLVo0xnw/e763hCFuoKTGIHaYJ0l8U4f6tAKh333zjSkNrWq', NULL, 'BSInfoTech', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:20', '2024-11-28 13:51:20', 0),
(2155, 'Annielys', 'Conato', 'conato@gmail.com', '$2y$10$HJ9aIhihrR6CO51tEgTQJe.Z0nRbKP0sHslF8jYEIxI4F/xkxcY8m', NULL, 'BSInfoTech', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:20', '2024-11-28 13:51:20', 0),
(2156, 'Grace', 'Gula', 'gula@gmail.com', '$2y$10$3sSTbRuvqUd1sV.VTeHV2eLgEMTsEfzXuIVf67xQc0ZYV218ZLfbq', NULL, 'BSInfoTech', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:20', '2024-11-28 13:51:20', 0),
(2157, 'Jaylynne Gayle', 'Libodlibod', 'libodlibod@gmail.com', '$2y$10$jW3LQZtwF/yK0oeGbWs3CegCLvQqVrTa3qOOq.V4ialiX74ie9d3y', NULL, 'BSInfoTech', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:20', '2024-11-28 13:51:20', 0),
(2158, 'Cristina Marie', 'Dublois', 'dublois@gmail.com', '$2y$10$i0lcwFqB15LV/kpFvjh6T.vmecLIuRxPKQAQcLb4LILQ4V9nVRJFC', NULL, 'BSInfoTech', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:20', '2024-11-28 13:51:20', 0),
(2159, 'Cristina', 'Tago-on', 'tago-on@gmail.com', '$2y$10$/Q25HuehPI8TTG8vXSxonOx3ug/DPlCPV0pbueepw9br/bs.UQIKa', NULL, 'BSInfoTech', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:20', '2024-11-28 13:51:20', 0),
(2160, 'Eva Mae', 'Cabilic', 'cabilic@gmail.com', '$2y$10$KJ/i8qYbQRuwSc0bfRE5KuMsOdZaWeUfMiljoE0iVBLdH9OMFTeNi', NULL, 'BSInfoTech', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:20', '2024-11-28 13:51:20', 0),
(2161, 'Xyrelle Dianne', 'Solomon', 'solomon@gmail.com', '$2y$10$WXenzWlRkUmjICU4dGQFquzryiHGfDo2HoIdAk9kTvfh94CpRgtBu', NULL, 'BSInfoTech', 2, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:20', '2024-11-28 13:51:20', 0),
(2162, 'Jonh Rogiel', 'Tumanda', 'tumanda@gmail.com', '$2y$10$Kf7IFiQF4RWZsWSzO4bI9O4Ccjhd4GvZ.FVT3vpQ4jOmZzJcbOZLK', NULL, 'BSInfoTech', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:20', '2024-11-28 13:51:20', 0),
(2163, 'Rizaly', 'Arañez', 'arañez@gmail.com', '$2y$10$dGai20CWhB5ch6fC45/Pr.SzLUGCZPp0Yzpq5uEFzKA4A6GXc2yxK', NULL, 'BSInfoTech', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:21', '2024-11-28 13:51:21', 0),
(2164, 'April Grace', 'Aton', 'aton@gmail.com', '$2y$10$ffLr9GgzjdcuN12C5xePAedhkCrbiYOwc0UiycF0/CVOOOFi5WXDq', NULL, 'BSInfoTech', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:21', '2024-11-28 13:51:21', 0),
(2165, 'Efmarjoy', 'Timkang', 'timkang@gmail.com', '$2y$10$qlylgvLjTic3uOhx3Wlq2.FbbuGVRCKLFOMBp4BkRepSYKgtwgROW', NULL, 'BSInfoTech', 2, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:21', '2024-11-28 13:51:21', 0),
(2166, 'Emil Jon', 'Amora', 'amora@gmail.com', '$2y$10$Zgh2/6LOwyZFoI95FplJX.9XnSxp0wxHp/v1PNpFwzhWjWSrHSBNa', NULL, 'BSInfoTech', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:21', '2024-11-28 13:51:21', 0),
(2167, 'Dexter', 'Hermogino', 'hermogino@gmail.com', '$2y$10$4DXVCvoswTuH2DhMeFH8LOZ.RR4vApIqEgwr.nOdthxtukVmrheAK', NULL, 'BSInfoTech', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:21', '2024-11-28 13:51:21', 0),
(2168, 'Gian Del', 'Calunsod', 'calunsod@gmail.com', '$2y$10$4ZUGwK7ohQ8/RkT8j0f7W.Cc.wKsjyoOZCETAqkjTPQOblQmNbOxe', NULL, 'BSInfoTech', 2, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:21', '2024-11-28 13:51:21', 0),
(2169, 'Vhan Mariz', 'Consuelo', 'consuelo@gmail.com', '$2y$10$0XJ5/LCVi5oetp4E3rA/qOggukoD369ELk7JPkKGbqM0FAWZsv88a', NULL, 'BSInfoTech', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:21', '2024-11-28 13:51:21', 0),
(2170, 'Miles Aidrian', 'Lopez', 'lopez@gmail.com', '$2y$10$Pt0jTTxTotW0LauHXhuV4ulihZOPkj8cQ2fvrtmbCKMKckV0fO4VS', NULL, 'BSInfoTech', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:21', '2024-11-28 13:51:21', 0),
(2171, 'Allyna Marie', 'Quilla', 'quilla@gmail.com', '$2y$10$9LVUlIVvZ04TP9D7.uCm3eRpnXu48d8798bRulpEqjc7Y2KMApRcW', NULL, 'BSInfoTech', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:21', '2024-11-28 13:51:21', 0),
(2172, 'Ronell', 'Morillo', 'morillo@gmail.com', '$2y$10$t..rnP5a6wKC/vFtJ1K3gudU7OxkHZDOvxdbLXfa/lVb.MAUWjt1u', NULL, 'BSInfoTech', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:21', '2024-11-28 13:51:21', 0),
(2173, 'Elisha Mae', 'Abande', 'abande@gmail.com', '$2y$10$AtCQLV3GnHMeVVIQX0FG8uWQpnwxhS8ZUGGF52Af/ge5zLNLapgEO', NULL, 'BSInfoTech', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:21', '2024-11-28 13:51:21', 0),
(2174, 'Henre Aidenry', 'Saludo', 'saludo@gmail.com', '$2y$10$nbYinUuTr1NkOcCxqHEMJOaUZELVWESxjGjr.pvNtNwQbG7uMhSl6', NULL, 'BSInfoTech', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:21', '2024-11-28 13:51:21', 0),
(2175, 'Annalou', 'Oclarit', 'oclarit@gmail.com', '$2y$10$BncU0KWFghR1qfLsJuQE4esNIw0c70L6HhGBx82CV3.WTkgrZe2gS', NULL, 'BSInfoTech', 2, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:22', '2024-11-28 13:51:22', 0),
(2176, 'Dean Dale', 'Ruales', 'ruales@gmail.com', '$2y$10$qElXMwuZ.E4AaoXhJs0blOVqWlygg2/HNUrXFawQM7lmWH2WtlvqO', NULL, 'BSInfoTech', 2, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:22', '2024-11-28 13:51:22', 0),
(2177, 'Angel Mae', 'Serdan', 'serdan@gmail.com', '$2y$10$83IQYK07tg3f/jzSJz56PujVna.JMxUiVmJKzl6NfvFMWnbHgRz6G', NULL, 'BSInfoTech', 2, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:22', '2024-11-28 13:51:22', 0),
(2178, 'Kierby', 'Diabordo', 'diabordo@gmail.com', '$2y$10$BKHrnAw8Uzzv1xf0RDzfuOkL9VJ42Bg0FuXmtevK3xNXaB0tkW6IS', NULL, 'BSInfoTech', 2, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:22', '2024-11-28 13:51:22', 0),
(2179, 'Mary Grace', 'Lamoste', 'lamoste@gmail.com', '$2y$10$CbDk8OUMAILrxnAZIaBycuHlcH0trAc4u6sW9nNkKne9ZGMH/eI8m', NULL, 'BSInfoTech', 2, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:22', '2024-11-28 13:51:22', 0),
(2180, 'Stella Marie', 'Sinco', 'sinco@gmail.com', '$2y$10$ngT1aMeBtpgOEU5KvL5NQeaC73ZY6w.2ewIlf.W88V2kLiqOjSDu2', NULL, 'BSInfoTech', 2, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:22', '2024-11-28 13:51:22', 0),
(2181, 'Charlene', 'Makilang', 'makilang@gmail.com', '$2y$10$RgOHkKDnj4F2Ty84OuZ.buFf4bOk79UnMg05plzDk6Hw2ik13FN1W', NULL, 'BSInfoTech', 2, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:23', '2024-11-28 13:51:23', 0),
(2182, 'Cliff Jhone', 'Bugnos', 'bugnos@gmail.com', '$2y$10$UTN9lD2gxsJSzBOyu4HnvesoXzqRBTEYLz6ZSdow1ZNLzmNPFAfYa', NULL, 'BSInfoTech', 2, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:23', '2024-11-28 13:51:23', 0),
(2183, 'Wendy Ann', 'Tablada', 'tablada@gmail.com', '$2y$10$mkRrWEJZji84ZhPRVSrOGucWQeaqELJMqZZzagjQL76QQLTHFGPIi', NULL, 'BSInfoTech', 2, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:23', '2024-11-28 13:51:23', 0),
(2184, 'John Clifford', 'Lamoste', 'lamoste@gmail.com', '$2y$10$pwtfCLqJLMqzOR752lyqrOYl9gLS4eajetVW4ILWSYMfeWSUroh.K', NULL, 'BSInfoTech', 2, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:23', '2024-11-28 13:51:23', 0),
(2185, 'Sean Carlo', 'Magadan', 'magadan@gmail.com', '$2y$10$FoQE338Vav.6PxSr3Es6XOott6gJEmK9QkwnXZBsQifMxei14hAiC', NULL, 'BSInfoTech', 2, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:23', '2024-11-28 13:51:23', 0),
(2186, 'John Mark', 'Yecyec', 'yecyec@gmail.com', '$2y$10$sbfq3oewREx3Uf7NHNS72Ol8kLnHOB/r8lxAaYUDJj3MNI.5.zS4m', NULL, 'BSInfoTech', 2, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:23', '2024-11-28 13:51:23', 0),
(2187, 'Rica', 'Cataylo', 'cataylo@gmail.com', '$2y$10$b..L1hcpocodybvYJKv6ouTkcP2uU3RJlHD7sBgv/GKZzcJSLkqHS', NULL, 'BSInfoTech', 2, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:23', '2024-11-28 13:51:23', 0),
(2188, 'Mayrich', 'Orit', 'orit@gmail.com', '$2y$10$U8vQYB.olskFWgrbMh4Kh.vdiLsPGxhdUsknd8qyPXg/PLvcLAEPy', NULL, 'BSInfoTech', 2, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:23', '2024-11-28 13:51:23', 0),
(2189, 'Joren', 'Agot', 'agot@gmail.com', '$2y$10$.ApZL/ar2.N81XMtSp3yJ.Vdq4w.2JnJfPAGp6RwNt2oKGTNL6g..', NULL, 'BSInfoTech', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:23', '2024-11-28 13:51:23', 0),
(2190, 'Renz Arthur', 'Caube', 'caube@gmail.com', '$2y$10$UtVSHvzx2zSiCmXWEKtug.ujgidnQWSs7nO2kfBQJvmYrUlmmC2/K', NULL, 'BSInfoTech', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:23', '2024-11-28 13:51:23', 0),
(2191, 'Jomarie', 'Bernales', 'bernales@gmail.com', '$2y$10$kQ1gLmNAyCfbK3/h2Xg5D.lXek7KwiA.CG9hti/n8fHJlfyjCmcBu', NULL, 'BSInfoTech', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:23', '2024-11-28 13:51:23', 0),
(2192, 'Erica', 'Gayo', 'gayo@gmail.com', '$2y$10$M1B/8zft7UDzhWlyAfHcseji0Vf.S5x2RJo5.bqGAmz5Q1O3IpZYC', NULL, 'BSInfoTech', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:24', '2024-11-28 13:51:24', 0),
(2193, 'Jevie', 'Tocmo', 'tocmo@gmail.com', '$2y$10$w7yDbHx9TBnoXgAbrhRlZe8RJ9XYu.PpbIOLQ6kuaIZXsQGDYjQL.', NULL, 'BSInfoTech', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:24', '2024-11-28 13:51:24', 0),
(2194, 'Dave', 'Robles', 'robles@gmail.com', '$2y$10$6.ti2tQbqsBQ2.NVyDkPqeKe1P/jrqJGuS91M0X65c72HXvQOBsNa', NULL, 'BSInfoTech', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:24', '2024-11-28 13:51:24', 0),
(2195, 'Lian Yi Shin', 'Abengoza', 'abengoza@gmail.com', '$2y$10$4mKTdqtt3f6Kr6Vb4iKFt.I2i/5lUMxhRJ3D5Bt3hLwrKoCdmLkFm', NULL, 'BSInfoTech', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:24', '2024-11-28 13:51:24', 0),
(2196, 'Kevin', 'Lozada', 'lozada@gmail.com', '$2y$10$oFmKnBncih/S3Uo9rxjnIeQPkVCKGZAV1MWgCosRiBnwlkg0Q.N/q', NULL, 'BSInfoTech', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:24', '2024-11-28 13:51:24', 0),
(2197, 'John Brunz', 'Camarista', 'camarista@gmail.com', '$2y$10$79oqOW6plSnRWK99zGit9uflmvXxjyCNw0OYKQE/TtmWie0BV.sS2', NULL, 'BSInfoTech', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:24', '2024-11-28 13:51:24', 0),
(2198, 'Jake', 'Ello', 'ello@gmail.com', '$2y$10$WO/SmNPGbsJvYTJMzfB9TOzHo2oadvisDv.ix4jKWh.cgOLAwKLsi', NULL, 'BSInfoTech', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:24', '2024-11-28 13:51:24', 0),
(2199, 'Kristin', 'Andam', 'andam@gmail.com', '$2y$10$io3mgWn4eRoe5s6QJ7pCRu3MJ4IEU9jG/rVjO1S7nFnn0bXhIr5F.', NULL, 'BSInfoTech', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:24', '2024-11-28 13:51:24', 0),
(2200, 'Glydel', 'Esclamado', 'esclamado@gmail.com', '$2y$10$rGCxAmTbJZlEq9u63feHTuP.gqIBIfU4AfsRiAOthYVMM7.kJT.wy', NULL, 'BSInfoTech', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:24', '2024-11-28 13:51:24', 0),
(2201, 'Angel Marie', 'Liad', 'liad@gmail.com', '$2y$10$ln.kfWgUxmKJbSTpyqbgJOfU1onM5.RhFoIDSYRcszhya3C0WwrSW', NULL, 'BSInfoTech', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:24', '2024-11-28 13:51:24', 0),
(2202, 'Mariel', 'Cañon', 'cañon@gmail.com', '$2y$10$YHXJyxf3Zym9tRqOlXaLkerCD1OO7aUIEaD9tnPFtOMMNRr6Fqyye', NULL, 'BSInfoTech', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:25', '2024-11-28 13:51:25', 0),
(2203, 'Emarie', 'Cebuala', 'cebuala@gmail.com', '$2y$10$hM7azLJLLFLAMXBkcR/iTOcF6KKzF41QZlJilMrDWOALkQlT1yZB2', NULL, 'BSInfoTech', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:25', '2024-11-28 13:51:25', 0),
(2204, 'Wyndel', 'Medina', 'medina@gmail.com', '$2y$10$rna7SCNVT7JEiAkquxGeE.kpiOhdvkbVLIQU89VblMkOWNGXz/NW2', NULL, 'BSInfoTech', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:25', '2024-11-28 13:51:25', 0),
(2205, 'Jona Mae', 'Del Castillo', 'del castillo@gmail.com', '$2y$10$jSCi3YPhyYk7/M72WH2E1.2KPSIEC1VFfgHR7yLLF8/lXrVdyDQfe', NULL, 'BSInfoTech', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:25', '2024-11-28 13:51:25', 0),
(2206, 'Jeriel Kish', 'Ilogon', 'ilogon@gmail.com', '$2y$10$h23Ctn.eIbQVRUI0Kqr6u.m6fOmEvms4sDK2BRfC3x8DREPo4cV..', NULL, 'BSInfoTech', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:25', '2024-11-28 13:51:25', 0),
(2207, 'Mark Vincent', 'Tamarion', 'tamarion@gmail.com', '$2y$10$81XZQOiYDNXzxwiG2vFs9.idUNE7nL0jpLlKII2q2VH0Jlx.0kmi.', NULL, 'BSInfoTech', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:25', '2024-11-28 13:51:25', 0);
INSERT INTO `student_registration` (`student_id`, `first_name`, `last_name`, `email`, `password`, `phone_number`, `department`, `year_level`, `section`, `enrollment_date`, `address`, `city`, `postal_code`, `country`, `date_of_birth`, `gender`, `emergency_contact_name`, `emergency_contact_number`, `created_at`, `updated_at`, `is_assigned`) VALUES
(2208, 'Rogelniño Mondido Fe', 'Inal', 'inal@gmail.com', '$2y$10$n/m9CWCz3uUsukh43t/EkOEB9OyKfuRvokIm1jMj9dyRKSPG3Z4u.', NULL, 'BSInfoTech', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:25', '2024-11-28 13:51:25', 0),
(2209, 'Bryll Jane', 'Mori', 'mori@gmail.com', '$2y$10$0Dpf3sd88VyLqSJGUSNcxe4c11DMALNOvbFFP8qbxxx4HrVX07/oG', NULL, 'BSInfoTech', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:25', '2024-11-28 13:51:25', 0),
(2210, 'Gelbert', 'Basuga', 'basuga@gmail.com', '$2y$10$X7zlMVtEiWZjjq5G/dZIGODAeo7tzlqKeKR1j/or4M7ti3APEaTki', NULL, 'BSInfoTech', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:25', '2024-11-28 13:51:25', 0),
(2211, 'Glenda', 'Narte', 'narte@gmail.com', '$2y$10$PTdux7EAQ1WJMT2zpkg66e4Ga0nqtrJi.UYVHJ9TEbrDuiwUKSls.', NULL, 'BSInfoTech', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:26', '2024-11-28 13:51:26', 0),
(2212, 'Danessa', 'Tomon', 'tomon@gmail.com', '$2y$10$B.gqKPikhwioal.YAv7Jtue6TCEv744zOilYITgMkJF3G24Dmg5.q', NULL, 'BSInfoTech', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:26', '2024-11-28 13:51:26', 0),
(2213, 'Daisy Mae', 'Bendijo', 'bendijo@gmail.com', '$2y$10$wwoMQr9MrOERMr6maYEQKOF2CbWFF7cBWr6K/OcJFNVRgbNlS0tXO', NULL, 'BSInfoTech', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:26', '2024-11-28 13:51:26', 0),
(2214, 'Lotis', 'Tabada', 'tabada@gmail.com', '$2y$10$fCs4AJICGM3FVKfEXRVJnOpeuI6vrvPwzEDSXhLGDIwserAFh45W6', NULL, 'BSInfoTech', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:26', '2024-11-28 13:51:26', 0),
(2215, 'Ana Rose', 'Orcullo', 'orcullo@gmail.com', '$2y$10$UC2TeLgm.N4taaHD46Tlke.mGSoWYPq/wCF9KYQka2MhviwE/Houm', NULL, 'BSInfoTech', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:26', '2024-11-28 13:51:26', 0),
(2216, 'Rodel', 'Queroben', 'queroben@gmail.com', '$2y$10$MT9r6AT.tSTQVTPyByNK9.HA69N5C/gbPZZ8GubRRqDvMrfrQz5cO', NULL, 'BSInfoTech', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:26', '2024-11-28 13:51:26', 0),
(2217, 'Raymond', 'Mariño', 'mariño@gmail.com', '$2y$10$1cwwtqbngiBoCPrTJTloCu85bf.PdxZRjPT/Lxn7.G2nQM3NlxuP6', NULL, 'BSInfoTech', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:26', '2024-11-28 13:51:26', 0),
(2218, 'Rodel', 'Davis', 'davis@gmail.com', '$2y$10$kNy0CFyBJ6hggSr7zi3XFOpZgiZ592v5uR4h88lWmmAbo8hMeVDZK', NULL, 'BSInfoTech', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:26', '2024-11-28 13:51:26', 0),
(2219, 'Cherrie', 'Necosia', 'necosia@gmail.com', '$2y$10$GLJ6z3lWhEja.4QCec3i5O3skaeF0jdcQsG22sWBhl1Urc/HChxYy', NULL, 'BSInfoTech', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:26', '2024-11-28 13:51:26', 0),
(2220, 'Dianne', 'Bedon', 'bedon@gmail.com', '$2y$10$388Rh4XjPNxJgIznn9NU1OVEA7Pqv5WmTpklbf99EjKz4rIMmxbEq', NULL, 'BSInfoTech', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:26', '2024-11-28 13:51:26', 0),
(2221, 'Elisa Jasmine', 'Homer', 'homer@gmail.com', '$2y$10$yM1C208szvnZ4jt9WiyXEe/NMYpjuwhLHclhCqEbUhR9O6cZ5M0Fm', NULL, 'BSInfoTech', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:26', '2024-11-28 13:51:26', 0),
(2222, 'Chanill Lay', 'Sueno', 'sueno@gmail.com', '$2y$10$w26dtNOAhbUUBWn5VOvrq.DhFYueZz5MWhCmEtjhthv2PbGwtaif6', NULL, 'BSInfoTech', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:27', '2024-11-28 13:51:27', 0),
(2223, 'Altheazean', 'Gonzales', 'gonzales@gmail.com', '$2y$10$POs96erbOkaaFaHo0oA5UOiuKb7yOHNy6VbDTXHzz7/KMukF0qo9m', NULL, 'BSInfoTech', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:27', '2024-11-28 13:51:27', 0),
(2224, 'Samantha', 'Daga', 'daga@gmail.com', '$2y$10$vME5QoFRMMiBNML0g46aDOWl8XtPL9.6njWDx.aVBmpGackYsxPFO', NULL, 'BSInfoTech', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:27', '2024-11-28 13:51:27', 0),
(2225, 'Diana', 'Gula', 'gula@gmail.com', '$2y$10$4lsXEfWzsNvf6x9WTevwGOf14QovIxa9WEYmzS8KE80i/oI/guXL6', NULL, 'BSInfoTech', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:27', '2024-11-28 13:51:27', 0),
(2226, 'Jhastine', 'Hilo', 'hilo@gmail.com', '$2y$10$IdKHpzeDsNi/iMXgFFiaDuqkTXdyPpfrXpCiGEzVpn950hHNNuHV2', NULL, 'BSInfoTech', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:27', '2024-11-28 13:51:27', 0),
(2227, 'Lenard Kier', 'Garcia', 'garcia@gmail.com', '$2y$10$Kv/bHgQFTNzsLbOHBGry5OX6s0zfOnOwMMU6B3w.vrbcoL.Bvp2SS', NULL, 'BSInfoTech', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:27', '2024-11-28 13:51:27', 0),
(2228, 'Ronel', 'Lisbos', 'lisbos@gmail.com', '$2y$10$1p0/Dgzdb9ClYNAGJHWRNOSwMhK1JoCgBnqGEpqCe3B3pWEmd/hja', NULL, 'BSInfoTech', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:27', '2024-11-28 13:51:27', 0),
(2229, 'Jerome', 'Epis', 'epis@gmail.com', '$2y$10$OBX97EXXQGwvzvH/t6y3UuLQ9ccaCiojR77noX8kFBmksSBfuLwPS', NULL, 'BSInfoTech', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:27', '2024-11-28 13:51:27', 0),
(2230, 'Jenny Babe', 'Villamor', 'villamor@gmail.com', '$2y$10$/HoVltIquUOKSR2FUe4EW.z67z.bCMZdDl.NWLcAGKY.OkSbj0b56', NULL, 'BSInfoTech', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:27', '2024-11-28 13:51:27', 0),
(2231, 'Marlie', 'Sarsaba', 'sarsaba@gmail.com', '$2y$10$5e80T4MP33CWkgcNMa20R.fOQSjQiuzCBhBGaZJWQFiuOmHPphDzO', NULL, 'BSInfoTech', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:28', '2024-11-28 13:51:28', 0),
(2232, 'Ramila Jean', 'Carungay', 'carungay@gmail.com', '$2y$10$nF7XkOo5ihBn2jmh67hqHOjI5bQsLsYQXPNMSvPRAX3ToEWT/58vC', NULL, 'BSInfoTech', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:28', '2024-11-28 13:51:28', 0),
(2233, 'Allen Justine', 'Araniel', 'araniel@gmail.com', '$2y$10$4xRTWIvkBZnAnpfAyocODuUxgfYOB2/991eFwWku9EcfEqSvvhQ3C', NULL, 'BSInfoTech', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:28', '2024-11-28 13:51:28', 0),
(2234, 'Kimberly Anne', 'Gaspay', 'gaspay@gmail.com', '$2y$10$XkUKJA3jctfDf26XyMKQ3eA3/b947ysGmHMzfZTjBh91CBsRifrAu', NULL, 'BSInfoTech', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:28', '2024-11-28 13:51:28', 0),
(2235, 'Berny', 'Talisaysay', 'talisaysay@gmail.com', '$2y$10$uvS7OdtOZBx4xZkrl8cFXue1aeqmmFhYlHnmKQ3ZYwcxYl.w/XLuO', NULL, 'BSInfoTech', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:28', '2024-11-28 13:51:28', 0),
(2236, 'Kemuel', 'Casono', 'casono@gmail.com', '$2y$10$D.f.G1bB1sDJJnjhc6Ok2uTceqyH5Swegj7icWuokN/pjOd/HG7cG', NULL, 'BSInfoTech', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:28', '2024-11-28 13:51:28', 0),
(2237, 'Phobie', 'Dalmacio', 'dalmacio@gmail.com', '$2y$10$jQctUXSnXgJz2RoiH00lH.bexJ2lI6P18Ran134RcMiTg7Y2Nig5C', NULL, 'BSInfoTech', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:28', '2024-11-28 13:51:28', 0),
(2238, 'Cristina Jane', 'Cabodbud', 'cabodbud@gmail.com', '$2y$10$oc7FbW6cqlNoAmmBqH0DreXjwnviy9S6OfZYau9ecwgn1pDxuzqmO', NULL, 'BSInfoTech', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:28', '2024-11-28 13:51:28', 0),
(2239, 'Ashley Bernadette', 'De Los Santos', 'de los santos@gmail.com', '$2y$10$wbZpoOrVw1gSxDfvXI6PuOO1CyeZ4u8Jrwk2z016BNSeoK8GEJQK.', NULL, 'BSInfoTech', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:28', '2024-11-28 13:51:28', 0),
(2240, 'Jessie Boy', 'Gerong', 'gerong@gmail.com', '$2y$10$wemOAPdwhQNBjgK4StEQEuuoqN2jnKF3EyDnE5sY3BU1ylQ.J4a0G', NULL, 'BSInfoTech', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:28', '2024-11-28 13:51:28', 0),
(2241, 'Ricky, Jr.', 'Fabillar', 'fabillar@gmail.com', '$2y$10$NpDjoh3K4Ir5jCbioBqv8OcWNYwaNMAJ.ZBYJrVY9WCiZv9E8vm2.', NULL, 'BSInfoTech', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:29', '2024-11-28 13:51:29', 0),
(2242, 'Jean Ann', 'Talamo', 'talamo@gmail.com', '$2y$10$UMy11doGNycA.dhtIFijEOUd174f9XefQkI6fMQCxAx9sez38PrAC', NULL, 'BSInfoTech', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:29', '2024-11-28 13:51:29', 0),
(2243, 'Lallyn', 'Dinolan', 'dinolan@gmail.com', '$2y$10$pC1GrMSKRnYOMyVwY9dEwe4.YewFN4r0HvpLMOEHkb2Cz2oKCGGhq', NULL, 'BSInfoTech', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:29', '2024-11-28 13:51:29', 0),
(2244, 'Jerson', 'Amandoron', 'amandoron@gmail.com', '$2y$10$7HY9Fq5g50a3wA9CfFvUauARPd6CNB0L.1L6KnrkakNGVmRPAQIT2', NULL, 'BSInfoTech', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:29', '2024-11-28 13:51:29', 0),
(2245, 'Denzen Dwight', 'Deniega', 'deniega@gmail.com', '$2y$10$fZOJCeqqCg.Rbhlqt7ffne3f5vrl4Ce4aySSy9rSbDYxcrBvhtKNe', NULL, 'BSInfoTech', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:29', '2024-11-28 13:51:29', 0),
(2246, 'Christine Joy', 'Esperanza', 'esperanza@gmail.com', '$2y$10$ExNq4AJssNtSDlqSkD110.XdOW3ZlnZ7gD0.ewvjCi9nrg287VzHW', NULL, 'BSInfoTech', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:29', '2024-11-28 13:51:29', 0),
(2247, 'Reymart', 'Siega', 'siega@gmail.com', '$2y$10$FD5KVXbpDza3IB6lmnjkQuPzw2tuq/Hfqyj5sdz1TgyCEihKR/CZO', NULL, 'BSInfoTech', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:29', '2024-11-28 13:51:29', 0),
(2248, 'Rio', 'Endico', 'endico@gmail.com', '$2y$10$/YWCagczRe0hYSC.wL.AkO9frCoLjg8E2aNMKcAQpjKwjSq1UJP9G', NULL, 'BSInfoTech', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:29', '2024-11-28 13:51:29', 0),
(2249, 'John', 'Cagadas', 'cagadas@gmail.com', '$2y$10$bf.WiT5hYLvzWepLV.gg/O06E6K9YatX5u1fH21w8aDjtq8tAn/ee', NULL, 'BSInfoTech', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:29', '2024-11-28 13:51:29', 0),
(2250, 'Klaire', 'Vanzuela', 'vanzuela@gmail.com', '$2y$10$K6vljDvyBzFs1vtNNqelKuFac1MG099FKYmNa1MlTp3xBvvXSc6K6', NULL, 'BSInfoTech', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:29', '2024-11-28 13:51:29', 0),
(2251, 'Jericho', 'Kuizon', 'kuizon@gmail.com', '$2y$10$4eDT5vjfimjjK4I21H8Kg.DUoD//DkU.Ms4wiRz6CaQiIZvXvY5HO', NULL, 'BSInfoTech', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:30', '2024-11-28 13:51:30', 0),
(2252, 'Jiros', 'Gultiano', 'gultiano@gmail.com', '$2y$10$l4kofZU/D0HfCwHigdM.WOIJvUoRut44uaMjhdsXfvAUOvG18sKuu', NULL, 'BSInfoTech', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:30', '2024-11-28 13:51:30', 0),
(2253, 'Joel, Jr.', 'Keliste', 'keliste@gmail.com', '$2y$10$scQ6mC/PBhbAMcqcDBKGnuYpqyQyhzDgxnin9peBC7hRZInuAf8.K', NULL, 'BSInfoTech', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:30', '2024-11-28 13:51:30', 0),
(2254, 'Jonathan, Jr', 'Layo', 'layo@gmail.com', '$2y$10$xA07yvd5Xg5RKtGRO6h1pOybqne3I10GzuYdeDpJ5jkUOWH.F3vCe', NULL, 'BSInfoTech', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:30', '2024-11-28 13:51:30', 0),
(2255, 'Marjun', 'Gilo', 'gilo@gmail.com', '$2y$10$GtkBvAFR0BYMhPjQv8vss.rJUrW.g27P0w.nW6Ir0NBoDoC8Hzfk.', NULL, 'BSInfoTech', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:30', '2024-11-28 13:51:30', 0),
(2256, 'Rosevie', 'Magsinolog', 'magsinolog@gmail.com', '$2y$10$qiS7GoqwhdnCNm/dhFzJNuqvqr2GbRUbsRusA37ED8u4vk2ECW51W', NULL, 'BSInfoTech', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:30', '2024-11-28 13:51:30', 0),
(2257, 'Johnathan', 'Escorpion', 'escorpion@gmail.com', '$2y$10$YM0lqluX0zHLVmX9LizICerncUVUrn6lsGWdTZ8T4VNRSd4Z1Lhue', NULL, 'BSInfoTech', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:30', '2024-11-28 13:51:30', 0),
(2258, 'Marianne Rose', 'Tablada', 'tablada@gmail.com', '$2y$10$X2ztPfAsk7EC1GvvQeMMS.XZfMaeEvysJV4FjuR91MTezUIXyya3q', NULL, 'BSInfoTech', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:30', '2024-11-28 13:51:30', 0),
(2259, 'Alfrich', 'Ocubillo', 'ocubillo@gmail.com', '$2y$10$.5MpESCPEw/g1SqpFJ45QudknhZu/23ZgSnqHoXvqnES1mN9OSQM2', NULL, 'BSInfoTech', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:30', '2024-11-28 13:51:30', 0),
(2260, 'Rex Thadeus', 'Villacin', 'villacin@gmail.com', '$2y$10$eMubUhaOBuAdXuVlnbswTenWVpb54XCjXXkcD7ktepg6UGiFAyaxC', NULL, 'BSInfoTech', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:30', '2024-11-28 13:51:30', 0),
(2261, 'Ma. Patricia', 'Albesa', 'albesa@gmail.com', '$2y$10$Pc5gdVZvPvUv90rYDXIQj.O/UsI0uDoefL8RTVdmUlFk3x6aEo1V.', NULL, 'BSInfoTech', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:31', '2024-11-28 13:51:31', 0),
(2262, 'Glen Mark', 'Garcia', 'garcia@gmail.com', '$2y$10$/mGQoVMYM5jHFbTcvJJXcuLTKDA2hED2fa2SAxLXQ0psIP/.ciPLe', NULL, 'BSInfoTech', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:31', '2024-11-28 13:51:31', 0),
(2263, 'Robert', 'Arco', 'arco@gmail.com', '$2y$10$7/xmJ0iOtS/1ZyZwrM4rkuAR9ArdRoKEOjIcTOPQpiaLexg04GSWi', NULL, 'BSInfoTech', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:31', '2024-11-28 13:51:31', 0),
(2264, 'Erich Karyl', 'Garcia', 'garcia@gmail.com', '$2y$10$ehCqQ7tRhQ.Y88vT88GrV.jBt7HiySA7CJhyyyrOHFAFBKC.BXpQm', NULL, 'BSInfoTech', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:31', '2024-11-28 13:51:31', 0),
(2265, 'Niel John', 'Basas', 'basas@gmail.com', '$2y$10$7eFxzICSCkA8Td/7zqUSRO1Jb6gWurdzjiQZamGvDs.yQ3eSg5uzK', NULL, 'BSInfoTech', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:31', '2024-11-28 13:51:31', 0),
(2266, 'Kyssiah', 'Sasing', 'sasing@gmail.com', '$2y$10$pve5gydjcZfEmG1oWXIK4OjCKshv9wsEPLho964uTlBBpz0ngE1Qy', NULL, 'BSInfoTech', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:31', '2024-11-28 13:51:31', 0),
(2267, 'John Remar', 'Albotra', 'albotra@gmail.com', '$2y$10$pyQtsCgbCMLyuWZnpFEuBu6Vq0kTsx91Jdl934ZzVqNP6orB5wYva', NULL, 'BSInfoTech', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:31', '2024-11-28 13:51:31', 0),
(2268, 'Jay', 'Tinga', 'tinga@gmail.com', '$2y$10$41jCEjjEEDrAnY.CgMEJtO2LtX2J0N3jyOyj9sWo9erwBfQkh3HJ2', NULL, 'BSInfoTech', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:31', '2024-11-28 13:51:31', 0),
(2269, 'Amie', 'Maputol', 'maputol@gmail.com', '$2y$10$p0qumUVHNvsVekHq2d8Z/e2.JOac5rxx1CA5WflKvFkq0fQnIw4k6', NULL, 'BSInfoTech', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:31', '2024-11-28 13:51:31', 0),
(2270, 'Angelica', 'Velasco', 'velasco@gmail.com', '$2y$10$kxk2arb7NAB9NJ5xwqk/c.C30sbzJgbdsrm7pQ6l7HDZnu1SwY0nW', NULL, 'BSA', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:32', '2024-11-28 13:51:32', 0),
(2271, 'Christine', 'Casil', 'casil@gmail.com', '$2y$10$HQmDMJ3nVKt2Fbch.RSkIOLI79/hGuCBnvKErkkc7O54SQw8kX7hy', NULL, 'BSA', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:32', '2024-11-28 13:51:32', 0),
(2272, 'Aliza', 'Batiao', 'batiao@gmail.com', '$2y$10$vBTORkQtVQxYJpYyj/IPT.j258kjupGgwHOb.GlpI/iZgJuYcpiVK', NULL, 'BSA', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:32', '2024-11-28 13:51:32', 0),
(2273, 'Jietly', 'Vete', 'vete@gmail.com', '$2y$10$KLHxtBEQbi8kJ/5sl8fi2uACxVwN9CCoCsx4bwjWepJ8XnNaESn0C', NULL, 'BSA', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:32', '2024-11-28 13:51:32', 0),
(2274, 'Roenjohn', 'Albert', 'albert@gmail.com', '$2y$10$lIxOwe8SJfIP7XGYKiWrlOg755VAon.WdNLYqtBWFPE2anVR.repa', NULL, 'BSA', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:32', '2024-11-28 13:51:32', 0),
(2275, 'Nordelyn', 'Cojano', 'cojano@gmail.com', '$2y$10$jPqquiMhWWWrnN/Gw9eFvOKgvi/Yrc.kqvl9iCn9mieL0fswkMJme', NULL, 'BSA', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:32', '2024-11-28 13:51:32', 0),
(2276, 'Donabel', 'Junio', 'junio@gmail.com', '$2y$10$RRJKORENnQJ495SxhzOsM.5u1F8ywDK9KBox6L0zGC5GSkzMyo5fa', NULL, 'BSA', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:32', '2024-11-28 13:51:32', 0),
(2277, 'Zhyra', 'Ongy', 'ongy@gmail.com', '$2y$10$On2OADne.abD.OKBbzZ7pO/icSpDamJAyE6ihTo91wA2EDyZg1a8u', NULL, 'BSA', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:32', '2024-11-28 13:51:32', 0),
(2278, 'Aiza', 'Adaron', 'adaron@gmail.com', '$2y$10$FCLRjp1CXa/3rv2OhP6yXOdWkq4l7LZe7auBvZGs71wxj8RhWvRwK', NULL, 'BSA', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:32', '2024-11-28 13:51:32', 0),
(2279, 'Andrea Nicole', 'Sotto', 'sotto@gmail.com', '$2y$10$DPrPtKYZAc3kkTU9tlXzVekaKuTDTrnRYQs1y7G0YPHtuIYIlhr2G', NULL, 'BSA', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:32', '2024-11-28 13:51:32', 0),
(2280, 'Joannie Jane', 'Galapin', 'galapin@gmail.com', '$2y$10$FUX8fYVQBjbUVxfHpNIk5u/WC3FU9pUd3uxPNcvDTEqHgxid2rRVW', NULL, 'BSA', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:33', '2024-11-28 13:51:33', 0),
(2281, 'Benjamen Jr.', 'Añasco', 'añasco@gmail.com', '$2y$10$MK2kOvv6jmgD3b4d/zvdMe0cJdQQ9EAgow78.R3Ury3KD7jqrFfX.', NULL, 'BSA', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:33', '2024-11-28 13:51:33', 0),
(2282, 'Rhea', 'Layola', 'layola@gmail.com', '$2y$10$PRLoViTKSZI11FjApblaaOPdk6xiIE2QpGcuCwu6C/f1WV6rdbmhC', NULL, 'BSA', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:33', '2024-11-28 13:51:33', 0),
(2283, 'Ednalyn', 'Trigo', 'trigo@gmail.com', '$2y$10$jFXgzgwYcmD4N7Gkxp/2yOuDwAj.2eLImmryHvGKiau86Ry3p12Q2', NULL, 'BSA', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:33', '2024-11-28 13:51:33', 0),
(2284, 'Jefferson', 'Felicilda', 'felicilda@gmail.com', '$2y$10$2FxtvzCtniZEVwsLr8XjrueS1NMryJbdHwi7seVW4TSpEv9xBvRHO', NULL, 'BSA', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:33', '2024-11-28 13:51:33', 0),
(2285, 'Brenda', 'Pogosa', 'pogosa@gmail.com', '$2y$10$gqiGSnrnfeSffqSiRpqFouCPNBj77XhZWuGzxSaHPpFhU.DZ21bvC', NULL, 'BSA', 4, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:33', '2024-11-28 13:51:33', 0),
(2286, 'Kyla', 'Borlasa', 'borlasa@gmail.com', '$2y$10$CGnbT8cPuCyz/samYwdCre7VGo03QLSERixKlor.hoJF3fvLfo3Sa', NULL, 'BSA', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:33', '2024-11-28 13:51:33', 0),
(2287, 'Benjie Mar', 'Pilo', 'pilo@gmail.com', '$2y$10$4IMrC2aZMdhQ2ZsfixTPiuhLSHGrQ2gOmOXt.4xLojxlVGjLSW/zS', NULL, 'BSA', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:33', '2024-11-28 13:51:33', 0),
(2288, 'Rommel', 'Bermiso', 'bermiso@gmail.com', '$2y$10$6tQWfgAhRW9VvJpTSBW11uXzMQ9K0/Jh6D0rZWkxe0wHU3zPlXahO', NULL, 'BSA', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:33', '2024-11-28 13:51:33', 0),
(2289, 'Cristine Joy', 'Vallente', 'vallente@gmail.com', '$2y$10$Lcq/E62GNhzlN67.fHqbNOXGeFtFn89WNOu3tpr7NGFbRjYV112NW', NULL, 'BSA', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:33', '2024-11-28 13:51:33', 0),
(2290, 'Adela Joyce', 'Sabalo', 'sabalo@gmail.com', '$2y$10$WCgBYKxaNPdqC6ze1x9WheRpsbH9s7fFWkxqB4VDSTjV0lSVinyzm', NULL, 'BSA', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:34', '2024-11-28 13:51:34', 0),
(2291, 'Gebilyn', 'Empon', 'empon@gmail.com', '$2y$10$Zk8CRE34UvxktfU8N2ju.O4CbK91MoUOKP65oHoVcqbBEsZHiLd1i', NULL, 'BSA', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:34', '2024-11-28 13:51:34', 0),
(2292, 'Drexter', 'Coquilla', 'coquilla@gmail.com', '$2y$10$xy52//evPWTZjc4O7VzpzuXu9K4yjR9D0uh0cqx5wnTXQMx7S9R7C', NULL, 'BSA', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:34', '2024-11-28 13:51:34', 0),
(2293, 'Christine', 'Talisaysay', 'talisaysay@gmail.com', '$2y$10$2/RR7eyFzzBzqEUgwQpYUuXSrPpqT2s59HGMS/DrDpQpxPaOJbCJO', NULL, 'BSA', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:34', '2024-11-28 13:51:34', 0),
(2294, 'Mary Ariadne', 'Cardiño', 'cardiño@gmail.com', '$2y$10$Fq9SabtrFevbvA.ObECJDOuEQ.HHtUtpoBd4/EKObxCgTe8DSaaXi', NULL, 'BSA', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:34', '2024-11-28 13:51:34', 0),
(2295, 'Carmelle', 'Layola', 'layola@gmail.com', '$2y$10$ofSANXfzmiQGhnP1BMCFweO4N5Q/4BI.R6kJUuNWop0gEJW.Ci7e.', NULL, 'BSA', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:34', '2024-11-28 13:51:34', 0),
(2296, 'Maria Agnes', 'Cadao', 'cadao@gmail.com', '$2y$10$YADnzndkrtwnqV70CTN/1.KGumGogKLPEv8zXnP8HsHHQBCVOsV4S', NULL, 'BSA', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:34', '2024-11-28 13:51:34', 0),
(2297, 'Aryl Rez', 'Cabel', 'cabel@gmail.com', '$2y$10$Z7vK973BQnGAYnC9KWJAh.q6WL/vyMfaDA9x3/8LhnT2HgSSc5qIe', NULL, 'BSA', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:34', '2024-11-28 13:51:34', 0),
(2298, 'Imee', 'Bragas', 'bragas@gmail.com', '$2y$10$3MrGoBNZCIOgRilpSbDkyuN5O24k8ZPVOZ9DEi1bzvkYnpkYZ5MH6', NULL, 'BSA', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:34', '2024-11-28 13:51:34', 0),
(2299, 'Persel Mae', 'Salan', 'salan@gmail.com', '$2y$10$jT1VWZQPqO8RtlCsJs5RUeTyapzWHLsJYChZJQHn2r6k36p.4xScW', NULL, 'BSA', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:34', '2024-11-28 13:51:34', 0),
(2300, 'Dovie', 'Dolorito', 'dolorito@gmail.com', '$2y$10$WCi6LIelfMvYrjm9rnYQQ.5C/uGazC5GvhYOsZ1h7PSKY4s3HNhw2', NULL, 'BSA', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:35', '2024-11-28 13:51:35', 0),
(2301, 'Flordeliza', 'Omac', 'omac@gmail.com', '$2y$10$qYoJR3OINeu73hTaB03TNugJRxnqLG5jO.g2g0fmTrL2akRWR5oP6', NULL, 'BSA', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:35', '2024-11-28 13:51:35', 0),
(2302, 'Ana Marie', 'Estillore', 'estillore@gmail.com', '$2y$10$5WbyD01.WOejdX1OHuBLW.6RWkXFcM807RIkyqOw8koICWfpG236.', NULL, 'BSA', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:35', '2024-11-28 13:51:35', 0),
(2303, 'Kayla Marie', 'Tutor', 'tutor@gmail.com', '$2y$10$L2oBTdK3UiFmC5Zs/OKjiunN9L6Sj.tS8r1yvzBxP7XHK3JedyfSi', NULL, 'BSA', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:35', '2024-11-28 13:51:35', 0),
(2304, 'Mica', 'Baral', 'baral@gmail.com', '$2y$10$yzLP2/O0jckWhyetJIUMf.YNPyIggljJnOaOsFNVdqgJSj.qjTD4m', NULL, 'BSA', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:35', '2024-11-28 13:51:35', 0),
(2305, 'Milodie', 'Juranes', 'juranes@gmail.com', '$2y$10$NwLNipMHkqJm5SJQuT0fnOST8XlvMFxu9Ch6.uNsTqqDwVCOGBKkC', NULL, 'BSA', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:35', '2024-11-28 13:51:35', 0),
(2306, 'Shaira', 'Sanchez', 'sanchez@gmail.com', '$2y$10$306DjdrPoyvzo3JZhygRFOK7OnEB6.KRDo/oxBFYSa7tSP1/B07nu', NULL, 'BSA', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:35', '2024-11-28 13:51:35', 0),
(2307, 'Oliver', 'Saldivar', 'saldivar@gmail.com', '$2y$10$/bJk6ktsoP3KuKBdUqfUH.o8MkXa6guFNnbuxXy55l6K593ONdAie', NULL, 'BSA', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:35', '2024-11-28 13:51:35', 0),
(2308, 'Neil Matthew', 'Rago', 'rago@gmail.com', '$2y$10$SBJ.UjuAHFu8k3k2KkyNaucxAw9GsbTHuVP7Do3w9oSKV6CZ/rT/S', NULL, 'BSA', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:35', '2024-11-28 13:51:35', 0),
(2309, 'Sarah', 'Braquil', 'braquil@gmail.com', '$2y$10$bhgyR8U/tnvaG9P4TBmzmuMp3cQKl/NczbZy2SsM//huQLKQIjDTG', NULL, 'BSA', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:36', '2024-11-28 13:51:36', 0),
(2310, 'Ladylyn', 'Ningala', 'ningala@gmail.com', '$2y$10$5qDkuS3sXqS80xGyBdsZP.U/.24FSb/TOD1jIKiG6vEJQKkNY3Rai', NULL, 'BSA', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:36', '2024-11-28 13:51:36', 0),
(2311, 'Judy Ann', 'Bello', 'bello@gmail.com', '$2y$10$eQNxcwE8g5lEnrHeC5BxUe/oxN7WMKv22v1v3xWK1PLOYqxIc5TA.', NULL, 'BSA', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:36', '2024-11-28 13:51:36', 0),
(2312, 'Janna Mae', 'Hernandez', 'hernandez@gmail.com', '$2y$10$xhMB0R.T/E9JKjcE5IPInuqYwEz5bSmlpLLmm9Ru/X89FuF/WJzAG', NULL, 'BSA', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:36', '2024-11-28 13:51:36', 0),
(2313, 'Maria Kim', 'Datig', 'datig@gmail.com', '$2y$10$jL4ZAFyLAtbr5r9KbfZe2.LmEgrSjCCOQO3tNYlZkMziYDg4fPo6G', NULL, 'BSA', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:36', '2024-11-28 13:51:36', 0),
(2314, 'Marianne Joyce', 'Sagaysay', 'sagaysay@gmail.com', '$2y$10$SRBaZwIoX6XpfWdFIj9Zw.ceihPZQy30KndJNcfCV0uLi2fvr3Zu.', NULL, 'BSA', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:36', '2024-11-28 13:51:36', 0),
(2315, 'Ella Mae', 'Orit', 'orit@gmail.com', '$2y$10$cyNXTjHl5v3SXad5wrQj/.pz2yPUt1bbOhTTTxz6noofYSdWA3kKG', NULL, 'BSA', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:36', '2024-11-28 13:51:36', 0),
(2316, 'Joan', 'Panal', 'panal@gmail.com', '$2y$10$TD.yLKexMc/4l4r9/rIS3ewykqt55eBqqsRrZn6ymSIjW4Pm44OaK', NULL, 'BSA', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:36', '2024-11-28 13:51:36', 0),
(2317, 'Jan Kyle', 'Alfornon', 'alfornon@gmail.com', '$2y$10$zzubAn3rj3QPOmhiq2VHW.S9iHKoLYQWhbdxfJTOEGu/PV9bJQ7G6', NULL, 'BSA', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:36', '2024-11-28 13:51:36', 0),
(2318, 'Aljun', 'Uypala', 'uypala@gmail.com', '$2y$10$XfOvSdVX/lQdbqlMXlZ54.Q6/vgu5/ri8ZPJxyR4hWCE8worFYpQq', NULL, 'BSA', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:36', '2024-11-28 13:51:36', 0),
(2319, 'Lara Mae', 'Peteros', 'peteros@gmail.com', '$2y$10$2DQcU2OXib0hGg4HaUbiAeV4wZQrYocbUprDN0dyYkP3Gt93Jk.TC', NULL, 'BSA', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:37', '2024-11-28 13:51:37', 0),
(2320, 'Chalmer', 'Ichon', 'ichon@gmail.com', '$2y$10$jqrbuVrxNKaodJZmndGXV.zLoiLXqBekuGnr7./eVGV4qlgFbbmYi', NULL, 'BSA', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:37', '2024-11-28 13:51:37', 0),
(2321, 'Arah', 'Doquila', 'doquila@gmail.com', '$2y$10$UmCriZAA5ufRy5o4BEdxWOt83L6/ej9Sn7UKvGjnUhiCudxENZ3wS', NULL, 'BSA', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:37', '2024-11-28 13:51:37', 0),
(2322, 'Ana Mae', 'Arco', 'arco@gmail.com', '$2y$10$9AAmHe4x8NkFm9tjN6S7Be4r5jNEVupPjBhJc3o5.CIW0.c5rkSfm', NULL, 'BSA', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:37', '2024-11-28 13:51:37', 0),
(2323, 'Cristine', 'Calledo', 'calledo@gmail.com', '$2y$10$DMsInC7BnYOjtx31zMVkhuIcidGQjfrAYrQ4ytAVFzURJYUDKkwXS', NULL, 'BSA', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:37', '2024-11-28 13:51:37', 0),
(2324, 'Leonel Miko', 'Galdo', 'galdo@gmail.com', '$2y$10$kj76nsrWUPEWcZGIu6iRteLlERl03J9VN/U42spkj3c1lqfSk0crK', NULL, 'BSA', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:37', '2024-11-28 13:51:37', 0),
(2325, 'Jandy', 'Nable', 'nable@gmail.com', '$2y$10$XCXtoagZTf0VraF9P6LgA.tMf2Aejxz92ueUgwynZemTHnhJsfTq2', NULL, 'BSA', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:37', '2024-11-28 13:51:37', 0),
(2326, 'Arnel', 'Evale', 'evale@gmail.com', '$2y$10$hXyagU2aTHqkaTdpW8UCGO3aWLHZC9MBg3a.dDJUoYSn36JY7XWTe', NULL, 'BSA', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:38', '2024-11-28 13:51:38', 0),
(2327, 'Gerald', 'Albesa', 'albesa@gmail.com', '$2y$10$H.9WCxHHgonVLzqSDhtm/uaVBdz1YfJwVEePgk2DFktV2mYIctUIC', NULL, 'BSA', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:38', '2024-11-28 13:51:38', 0),
(2328, 'Jean', 'Ragas', 'ragas@gmail.com', '$2y$10$jZclfvddu2rIXLa1sLP.3OCqZhyBivWhV9WzER3WyJ8AhzZD5TRr6', NULL, 'BSA', 3, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:38', '2024-11-28 13:51:38', 0),
(2329, 'Vincent', 'Dizon', 'dizon@gmail.com', '$2y$10$vxO4EtEpFoMjyMGcyradNOZdjfSk.R8H7ss55yglhOYfEHse9MR2e', NULL, 'BSA', 3, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:38', '2024-11-28 13:51:38', 0),
(2330, 'Stella Marie', 'Alvarado', 'alvarado@gmail.com', '$2y$10$340GgWMDdBlBvSz8BaK5G.A8JsjlTCeEyyoNlvI773DKfHtTeGrFG', NULL, 'BSA', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:38', '2024-11-28 13:51:38', 0),
(2331, 'Vincent', 'Tablo', 'tablo@gmail.com', '$2y$10$McmaZXbg0kuRhG0Dwyu5G.mt8mXcS9T8ncSx09mZOUK1IAXVkjVEG', NULL, 'BSA', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:38', '2024-11-28 13:51:38', 0),
(2332, 'Rey Ann Mae', 'Timkang', 'timkang@gmail.com', '$2y$10$y7n6pSfJKV6o/INuByvBIOdWzOToBq/ExYAl0USyq..vIcdiSyRyO', NULL, 'BSA', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:38', '2024-11-28 13:51:38', 0),
(2333, 'John Norbert', 'Guma', 'guma@gmail.com', '$2y$10$sv7pVCaQT98KIQAEtqqqA.1bVF/ZohZ9yZO6hIssiMTmyRcCGNJCu', NULL, 'BSA', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:38', '2024-11-28 13:51:38', 0),
(2334, 'Anna Reshelle', 'Goyo', 'goyo@gmail.com', '$2y$10$KkOLVfI9h3TQy/cgEv8GtuucW2OAT5DU6jIrqx0Gr7Vp2eEVkhU36', NULL, 'BSA', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:38', '2024-11-28 13:51:38', 0),
(2335, 'Kristine', 'Embalsado', 'embalsado@gmail.com', '$2y$10$fYuYnJ.iub4SLXxVijBHuOc/Ouo3kMva5dE.y66rqtlVzhUCEPZ12', NULL, 'BSA', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:38', '2024-11-28 13:51:38', 0),
(2336, 'Josh', 'Montederamos', 'montederamos@gmail.com', '$2y$10$4PUxPvLVNRbPOmmr.Z7VIuNga4BKOm895XZii7lBxEwS/E2osM522', NULL, 'BSA', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:39', '2024-11-28 13:51:39', 0),
(2337, 'Chariel Jetta', 'Paras', 'paras@gmail.com', '$2y$10$XajqkqfEAKhnk1HLteqtwOX/3IWOVdyN8eayovvhCq8eBatS31vCO', NULL, 'BSA', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:39', '2024-11-28 13:51:39', 0),
(2338, 'Judea Loui', 'Marfil', 'marfil@gmail.com', '$2y$10$Mh0aucCQvvGT8CpyicpFPOcubGmMugxTYs3FZZ7LpaacbE7W83Hiq', NULL, 'BSA', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:39', '2024-11-28 13:51:39', 0),
(2339, 'Allean Zane', 'Gabriel', 'gabriel@gmail.com', '$2y$10$9/jWVyXQTwm4/zsJ8R2pre40fSJZhojdTfYvbf8tAHJgd6NHNf6KK', NULL, 'BSA', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:39', '2024-11-28 13:51:39', 0),
(2340, 'Khirstine Mae', 'Oja', 'oja@gmail.com', '$2y$10$Sizyav8BLJEFEJkHiG5BFumL9fTB5.ck6Y88pUe4470sKAemHD9HS', NULL, 'BSA', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:39', '2024-11-28 13:51:39', 0),
(2341, 'Mary Franly', 'Senajonon', 'senajonon@gmail.com', '$2y$10$Pi3gcg0GpuOnC3DqVh.Xlei00lvDfzfZbHXagRiNn889L0fGIHbr6', NULL, 'BSA', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:39', '2024-11-28 13:51:39', 0),
(2342, 'Fe', 'Laspiñas', 'laspiñas@gmail.com', '$2y$10$ZzeOrTgKP1y1.1LhgkWcAO7KNCUaQ.OWRipeyqDTuOX9OvFj25G6C', NULL, 'BSA', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:39', '2024-11-28 13:51:39', 0),
(2343, 'Honey Joy', 'Cortez', 'cortez@gmail.com', '$2y$10$E1RGA1Y5H857P97VDt/m5.gFk5JFi9LRbuITduO/4.rL5aXPM/T7C', NULL, 'BSA', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:39', '2024-11-28 13:51:39', 0),
(2344, 'Chariz', 'Gilo', 'gilo@gmail.com', '$2y$10$OQGK.wU4Hm8ZnKF7iQUnLeX/28IwLxoxDOLw7qJSCKGw.rSOvPO6C', NULL, 'BSA', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:39', '2024-11-28 13:51:39', 0),
(2345, 'Kenzies Dwight David', 'Quilos', 'quilos@gmail.com', '$2y$10$hIL1H54C.gb/hdbXxJSfa.mLMUl43XPEvVIeCpUTAkkrTXUcp0AXW', NULL, 'BSA', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:40', '2024-11-28 13:51:40', 0),
(2346, 'Neil Jhon', 'Tesado', 'tesado@gmail.com', '$2y$10$7KLfr5Gm6X3.ETcdRrrlSe7kvoeTHEe28bw16bVtt2ZBFUPSEkHV.', NULL, 'BSA', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:40', '2024-11-28 13:51:40', 0),
(2347, 'Bredilyn', 'Abadines', 'abadines@gmail.com', '$2y$10$ij10nVdqtpeblPj7/7p.D.3OPKUGIjs7kLwqjmuqVe9fyaxzCsjfW', NULL, 'BSA', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:40', '2024-11-28 13:51:40', 0),
(2348, 'Jenalyn', 'Espere', 'espere@gmail.com', '$2y$10$6ltGxSJfSNe1C68M7I.WT.cfTybuzrf4olVLbx.DliX5dl2B8zjZ2', NULL, 'BSA', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:40', '2024-11-28 13:51:40', 0),
(2349, 'Sherwin Jay', 'Auguis', 'auguis@gmail.com', '$2y$10$9i0mtIXmQ1Z1jspEmraodulssZT0qhPGtWnn8qy/jS9klgYb15Nmi', NULL, 'BSA', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:40', '2024-11-28 13:51:40', 0),
(2350, 'Shaira Lee', 'Maldo', 'maldo@gmail.com', '$2y$10$8O4RFGF8hvjTSl/t5Vs3h.KS4gmbFiMa6xYK4qohiDQM4Fi7qLmKS', NULL, 'BSA', 2, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:40', '2024-11-28 13:51:40', 0),
(2351, 'Caren', 'Traboc', 'traboc@gmail.com', '$2y$10$yCmY4HfsZWSaRYmbgmCYu.AxViUuaGB4U2I0g9.nGI6Py/pI64X0e', NULL, 'BSA', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:40', '2024-11-28 13:51:40', 0),
(2352, 'Trixia Mae', 'Rafalle', 'rafalle@gmail.com', '$2y$10$k9U4UCTeCIZ9hqJGFT06L.7Ljth0OjVi1nPSXzsYt6gjw5utAEla.', NULL, 'BSA', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:40', '2024-11-28 13:51:40', 0),
(2353, 'Julian', 'Redondo', 'redondo@gmail.com', '$2y$10$0fh99mKyhCfqUIrF6oC0.OuMmVTsAGBRW3NyDq60LzUlO3pPllAXm', NULL, 'BSA', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:40', '2024-11-28 13:51:40', 0),
(2354, 'Claire Angelie', 'Bulabos', 'bulabos@gmail.com', '$2y$10$uYqL6LXlNPL36tThVl2m.ODJox1IBJ/e66J4lAmRS0jlkysZdv7ei', NULL, 'BSA', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:40', '2024-11-28 13:51:40', 0),
(2355, 'Rhea', 'Maraveles', 'maraveles@gmail.com', '$2y$10$kNFvOEoJz7.ftiy3HdydwOQrf3hnWDZPre.NjG4uYAy1tJygSWXty', NULL, 'BSA', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:41', '2024-11-28 13:51:41', 0),
(2356, 'Daryl', 'Amad', 'amad@gmail.com', '$2y$10$FdEahp7QHhFAuuC5FZJ4XOUIJfuxE4otSNZ0L0xkSpdq2EfPqwfyq', NULL, 'BSA', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:41', '2024-11-28 13:51:41', 0),
(2357, 'Meah', 'Makilang', 'makilang@gmail.com', '$2y$10$oqdT2WxUoK56.SMOk1ShneCnEsAUa2BxHlIsfFWcupvnEN11S/KIu', NULL, 'BSA', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:41', '2024-11-28 13:51:41', 0),
(2358, 'Krizia Marie', 'Lastra', 'lastra@gmail.com', '$2y$10$toLuuhyUZZ3P7ceMu6mWKOXlHn/xhHHKZeWcDg21XpNv71SPfTZv6', NULL, 'BSA', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:41', '2024-11-28 13:51:41', 0),
(2359, 'Antonette', 'Gantala', 'gantala@gmail.com', '$2y$10$htnhQy.gtGpKtbz/IR1SBexnoW99.diSCxaKvD93FKj6qPXiSMw/e', NULL, 'BSA', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:41', '2024-11-28 13:51:41', 0),
(2360, 'Kyrelle Jhane', 'Ronato', 'ronato@gmail.com', '$2y$10$yTsAcwjOeU1dKHBrL2J1Ue4C.ExsC9dS04S0AHHvfcPN63MwUjPzO', NULL, 'BSA', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:41', '2024-11-28 13:51:41', 0),
(2361, 'Rosemarie', 'Espinosa', 'espinosa@gmail.com', '$2y$10$gvJMNEDVjtA9RG01SbH6i.x9jfJpq.hpolFjIiMqt6y5WqfSGU24i', NULL, 'BSA', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:41', '2024-11-28 13:51:41', 0),
(2362, 'Alfredo, Jr.', 'Beloy', 'beloy@gmail.com', '$2y$10$qrS396lR8aFX4PVNKQqwHuBg7le7mvbGPZRauAHCp23LwCAY5rtSW', NULL, 'BSA', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:41', '2024-11-28 13:51:41', 0),
(2363, 'Janelle', 'Batas', 'batas@gmail.com', '$2y$10$mhvwvQatp/GKsr97Fs7FWeuiTEoBa4HT9rz.EvePtOXBICPsSRxzy', NULL, 'BSA', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:41', '2024-11-28 13:51:41', 0),
(2364, 'Dennis', 'Auza', 'auza@gmail.com', '$2y$10$zdd9mFq2ATckty0mh7zBY.i4KmgyLvOk4ReMZK8opYFIGj5rRsxV2', NULL, 'BSA', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:42', '2024-11-28 13:51:42', 0),
(2365, 'Asriel', 'Doroy', 'doroy@gmail.com', '$2y$10$aoY792obGMZbIlepcHd.LOb06SDgD6uyJFYupSNYa7lXPnkp8nmY6', NULL, 'BSA', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:42', '2024-11-28 13:51:42', 0),
(2366, 'Mary Lyn', 'Marte', 'marte@gmail.com', '$2y$10$JMsDHNQxPGDIV6QDuZBhyeeEEkim4RnNviZla/ppKJ/TBoDe7fmMK', NULL, 'BSA', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:42', '2024-11-28 13:51:42', 0),
(2367, 'Jodel', 'Acampado', 'acampado@gmail.com', '$2y$10$UC5qIVJ.zyUzBINNpoSIPeV30F.yTY6vW6cGSkdnyG3.dDw13kYpy', NULL, 'BSA', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:42', '2024-11-28 13:51:42', 0),
(2368, 'Dave', 'Delute', 'delute@gmail.com', '$2y$10$qVl5mX5vZVxMvEMIekD05uYvnxQACJ6x3KE0MP/jiRl2e2zfqwMra', NULL, 'BSA', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:42', '2024-11-28 13:51:42', 0),
(2369, 'Danica', 'Delute', 'delute@gmail.com', '$2y$10$hDgxdQ.nnH7pdZOffUEOqOjTFBglIgJx0OH6C5mz1W9rXKzZ4Qoku', NULL, 'BSA', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:42', '2024-11-28 13:51:42', 0),
(2370, 'April Rose', 'Caadyang', 'caadyang@gmail.com', '$2y$10$.dkQS39D8etA2lLZnZl8aeUHVXfNl9DKiuPEizxPDS/ka2XsN8uT6', NULL, 'BSA', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:42', '2024-11-28 13:51:42', 0),
(2371, 'Shanice', 'Capistrano', 'capistrano@gmail.com', '$2y$10$.8n3zkwVLpCfbM7T1mtZCOElKyDHopqGuHXr63d/lroTJA4kngGaS', NULL, 'BSA', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:42', '2024-11-28 13:51:42', 0),
(2372, 'Mikke John', 'Abuyabor', 'abuyabor@gmail.com', '$2y$10$2LBNzXYRSVP7WSMiXGkxoeJtql4I8pL/huBcZqd6bz6E.Jq3k.LZW', NULL, 'BSA', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:42', '2024-11-28 13:51:42', 0),
(2373, 'Merlyn', 'Mejia', 'mejia@gmail.com', '$2y$10$cIKitBRqrZvvJC.B3y4X4ek5vANMlAzJGkeU77HH52ldBQbk.cXG6', NULL, 'BSA', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:42', '2024-11-28 13:51:42', 0),
(2374, 'John Peter', 'Pedaria', 'pedaria@gmail.com', '$2y$10$Ar4XJ9.9S2eysSTAxWRzxO78VI4Xamwqt562O.4c1u2JOX5kdO9V.', NULL, 'BSA', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:43', '2024-11-28 13:51:43', 0),
(2375, 'Jimuel', 'Pagay', 'pagay@gmail.com', '$2y$10$vSLZ6eZMZpLCbAPHbMO9p.O2x3xpUDSMEtdzDg1ai.nW/U7SXRw2.', NULL, 'BSA', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:43', '2024-11-28 13:51:43', 0),
(2376, 'Mikee Anne', 'Corcilles', 'corcilles@gmail.com', '$2y$10$pAfoFs5d9L0YYvQcJKq4HO4p.MTr0LZKKOI920sBHZ1asYS5uVMqi', NULL, 'BSA', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:43', '2024-11-28 13:51:43', 0),
(2377, 'Roxan', 'Nambatac', 'nambatac@gmail.com', '$2y$10$Ttu6BmAStz1CLiaRIDv4TuGKCiR4kvL2s9QHaMIpwgTROMb120g7.', NULL, 'BSA', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:43', '2024-11-28 13:51:43', 0),
(2378, 'French', 'Gayo', 'gayo@gmail.com', '$2y$10$LjzCy7t5UhA85kHcWWGWq.r/356NmX4fRzAN8y5bVKckkAZ7yL4A6', NULL, 'BSA', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:43', '2024-11-28 13:51:43', 0),
(2379, 'Jessamie', 'Labastida', 'labastida@gmail.com', '$2y$10$.9iElxLQZ573BdD2btu59O6w1zBggPG/5M2bHj7.v3Z53vSohO9Cu', NULL, 'BSA', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:43', '2024-11-28 13:51:43', 0),
(2380, 'Irene', 'Espere', 'espere@gmail.com', '$2y$10$AW/md3TpP7QMpSSwPa62oeLYqdTW3Bwbg0/2ftrwVLV0E0kuJE9I6', NULL, 'BSA', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:43', '2024-11-28 13:51:43', 0),
(2381, 'Genesis Melquisedec', 'Padilla', 'padilla@gmail.com', '$2y$10$ltjABnIQXD4xiI8XAW14p.DjhLvFhiIHxI/7PADPAzd4hT3OPrF/e', NULL, 'BSA', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:43', '2024-11-28 13:51:43', 0),
(2382, 'Joanah', 'Odog', 'odog@gmail.com', '$2y$10$tpfdBIWl8oeQwTcQMZxOl.kT0.SBRNK2gBixX69ODesp6L28zRyJ2', NULL, 'BSA', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:43', '2024-11-28 13:51:43', 0),
(2383, 'Ryza Mae', 'Gelio', 'gelio@gmail.com', '$2y$10$7d9DgEwR/Q87Lb6HkqIHL.zyWLzEpDUgVlLRaiHcGUiktXMiZeKG2', NULL, 'BSA', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:43', '2024-11-28 13:51:43', 0),
(2384, 'Jenico', 'Obado', 'obado@gmail.com', '$2y$10$vs379hlROZHgf8f/Pkq.7uXzlevoDKzJGzG9Ye90sJfk8rj0VSi8q', NULL, 'BSA', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:44', '2024-11-28 13:51:44', 0),
(2385, 'Krishia Marie', 'Castaños', 'castaños@gmail.com', '$2y$10$UDarRolPuCwqcazt578zMeJGNk8eBy2gTWvbaDdJ6kVb6Y9CdBUZi', NULL, 'BSA', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:44', '2024-11-28 13:51:44', 0),
(2386, 'Charlien', 'Celeste', 'celeste@gmail.com', '$2y$10$xN2FpKPUGnVPpJzCPp/rRuEH83Y2b4m7v/P1jL7IS4bI2/RzFdfru', NULL, 'BSA', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:44', '2024-11-28 13:51:44', 0),
(2387, 'Haide Grace', 'Alvarez', 'alvarez@gmail.com', '$2y$10$d4cMagyf703k7cfiNqceLOjcPTzuI3vPSWWw9m/1xtcPA.fs/LkdK', NULL, 'BSA', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:44', '2024-11-28 13:51:44', 0),
(2388, 'Trixie', 'Malayag', 'malayag@gmail.com', '$2y$10$2aLUZ9cL//EqBVCibj8bU.Krg8h1NBwc222MjFcMgpFs.ZYF1SfgS', NULL, 'BSA', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:44', '2024-11-28 13:51:44', 0),
(2389, 'Cris Ann Gaye', 'Oja', 'oja@gmail.com', '$2y$10$H92YLghKpecO5SOEw8FnKeXdrTU7jEZM6MaaRyvtulrpnYpxJDhyC', NULL, 'BSA', 1, 'A', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:44', '2024-11-28 13:51:44', 0),
(2390, 'Joshua', 'Rebecca', 'rebecca@gmail.com', '$2y$10$77GAKE3Vibbo.CUIrmE0Tuw.skoBvp2ThuZU18w23SI9axKnIQcq.', NULL, 'BSA', 1, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:44', '2024-11-28 13:51:44', 0),
(2391, 'Theodore', 'Laban', 'laban@gmail.com', '$2y$10$i8yDzzxL6BTmH38PDntvX.NcbimqRM.8E0VvqN6vQlWPAIPB65bPG', NULL, 'BAT', 4, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:44', '2024-11-28 13:51:44', 0),
(2392, 'Joseph', 'Endriga', 'endriga@gmail.com', '$2y$10$Qt/Eq/KMCuoDk4vlrQqYxeFzfLeCQu0mOUnxLbHbtpxEx1Hyrsfbi', NULL, 'BAT', 4, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:44', '2024-11-28 13:51:44', 0),
(2393, 'Reza', 'De Vera', 'de vera@gmail.com', '$2y$10$U02E48EWE7zG7Jxby3CJwu/crLa1ZuC3g09XwGCHmfPNmavl3OhQS', NULL, 'BAT', 4, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Female', NULL, NULL, '2024-11-28 13:51:44', '2024-11-28 13:51:44', 0),
(2394, 'Jerome', 'Salar', 'salar@gmail.com', '$2y$10$PIlllUHYiZJYAJBxU.b/meDZqo5SwkDHiWpcrgz4wj3k/TDzSO6tu', NULL, 'BAT', 4, 'B', NULL, NULL, NULL, NULL, NULL, NULL, 'Male', NULL, NULL, '2024-11-28 13:51:45', '2024-11-28 13:51:45', 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `employee_attendance_department`
--
ALTER TABLE `employee_attendance_department`
  ADD PRIMARY KEY (`attendance_id`),
  ADD KEY `employee_id` (`employee_id`),
  ADD KEY `flag_id` (`flag_id`);

--
-- Indexes for table `employee_attendance_flag`
--
ALTER TABLE `employee_attendance_flag`
  ADD PRIMARY KEY (`attendance_id`),
  ADD KEY `employee_id` (`employee_id`),
  ADD KEY `flag_id` (`flag_id`);

--
-- Indexes for table `employee_attendance_gate`
--
ALTER TABLE `employee_attendance_gate`
  ADD PRIMARY KEY (`attendance_id`),
  ADD UNIQUE KEY `unique_entry_per_employee` (`employee_id`,`entry_time`),
  ADD KEY `idx_employee_entry_time` (`employee_id`,`entry_time`);

--
-- Indexes for table `employee_qr_log`
--
ALTER TABLE `employee_qr_log`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `employee_id` (`employee_id`);

--
-- Indexes for table `employee_registration`
--
ALTER TABLE `employee_registration`
  ADD PRIMARY KEY (`employee_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `flag_type`
--
ALTER TABLE `flag_type`
  ADD PRIMARY KEY (`flag_id`);

--
-- Indexes for table `student_attendance_flag`
--
ALTER TABLE `student_attendance_flag`
  ADD PRIMARY KEY (`attendance_id`),
  ADD KEY `student_id` (`student_id`),
  ADD KEY `flag_id` (`flag_id`);

--
-- Indexes for table `student_registration`
--
ALTER TABLE `student_registration`
  ADD PRIMARY KEY (`student_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `employee_attendance_department`
--
ALTER TABLE `employee_attendance_department`
  MODIFY `attendance_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `employee_attendance_flag`
--
ALTER TABLE `employee_attendance_flag`
  MODIFY `attendance_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=199;

--
-- AUTO_INCREMENT for table `employee_attendance_gate`
--
ALTER TABLE `employee_attendance_gate`
  MODIFY `attendance_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=251;

--
-- AUTO_INCREMENT for table `employee_qr_log`
--
ALTER TABLE `employee_qr_log`
  MODIFY `log_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `employee_registration`
--
ALTER TABLE `employee_registration`
  MODIFY `employee_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `flag_type`
--
ALTER TABLE `flag_type`
  MODIFY `flag_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `student_attendance_flag`
--
ALTER TABLE `student_attendance_flag`
  MODIFY `attendance_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `student_registration`
--
ALTER TABLE `student_registration`
  MODIFY `student_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2395;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `employee_attendance_department`
--
ALTER TABLE `employee_attendance_department`
  ADD CONSTRAINT `employee_attendance_department_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employee_registration` (`employee_id`),
  ADD CONSTRAINT `employee_attendance_department_ibfk_2` FOREIGN KEY (`flag_id`) REFERENCES `flag_type` (`flag_id`);

--
-- Constraints for table `employee_attendance_flag`
--
ALTER TABLE `employee_attendance_flag`
  ADD CONSTRAINT `employee_attendance_flag_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employee_registration` (`employee_id`),
  ADD CONSTRAINT `employee_attendance_flag_ibfk_2` FOREIGN KEY (`flag_id`) REFERENCES `flag_type` (`flag_id`);

--
-- Constraints for table `employee_attendance_gate`
--
ALTER TABLE `employee_attendance_gate`
  ADD CONSTRAINT `employee_attendance_gate_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employee_registration` (`employee_id`) ON DELETE CASCADE;

--
-- Constraints for table `employee_qr_log`
--
ALTER TABLE `employee_qr_log`
  ADD CONSTRAINT `employee_qr_log_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employee_registration` (`employee_id`) ON DELETE CASCADE;

--
-- Constraints for table `student_attendance_flag`
--
ALTER TABLE `student_attendance_flag`
  ADD CONSTRAINT `student_attendance_flag_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `student_registration` (`student_id`),
  ADD CONSTRAINT `student_attendance_flag_ibfk_2` FOREIGN KEY (`flag_id`) REFERENCES `flag_type` (`flag_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
