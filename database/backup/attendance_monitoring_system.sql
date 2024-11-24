-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 14, 2024 at 01:00 PM
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4  ;

--
-- Dumping data for table `employee_attendance_department`
--

INSERT INTO `employee_attendance_department` (`attendance_id`, `employee_id`, `attendance_date`, `attendance_status`, `flag_id`, `department`) VALUES
(1, 2, '2024-09-04 16:20:00', 'present', 1, 'BSN');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4  ;

--
-- Dumping data for table `employee_attendance_flag`
--

INSERT INTO `employee_attendance_flag` (`attendance_id`, `employee_id`, `attendance_date`, `attendance_status`, `flag_id`) VALUES
(161, 2, '2024-07-02 10:18:24', 'absent', 1),
(162, 3, '2024-07-02 10:22:16', 'absent', 1),
(163, 2, '2024-07-04 10:31:27', 'absent', 1),
(164, 3, '2024-07-04 10:33:14', 'present', 1),
(165, 4, '2024-07-04 10:33:20', 'late', 1),
(166, 5, '2024-07-04 10:33:25', 'present', 1),
(167, 6, '2024-07-04 10:33:31', 'absent', 1),
(168, 7, '2024-07-04 10:33:37', 'absent', 1),
(169, 9, '2024-07-04 14:55:14', 'absent', 1),
(170, 2, '2024-07-29 10:35:05', 'present', 1),
(171, 3, '2024-07-29 10:35:11', 'late', 1),
(172, 2, '2024-09-04 15:48:22', 'present', 1),
(173, 2, '2024-11-14 19:35:28', 'present', 1),
(174, 3, '2024-11-14 19:35:34', 'late', 1),
(175, 4, '2024-11-14 19:35:40', 'absent', 1),
(176, 5, '2024-11-14 19:35:44', 'present', 1),
(177, 6, '2024-11-14 19:35:49', 'present', 1),
(178, 7, '2024-11-14 19:35:53', 'late', 1),
(179, 9, '2024-11-14 19:35:58', 'present', 1);

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4  ;

--
-- Dumping data for table `employee_attendance_gate`
--

INSERT INTO `employee_attendance_gate` (`attendance_id`, `employee_id`, `entry_time`, `entry_type`, `description`, `attendance_status`) VALUES
(174, 3, '2024-07-04 10:46:19', 'in', '', 1),
(175, 3, '2024-07-04 10:46:27', 'out', '', 2),
(176, 3, '2024-07-04 10:46:58', 'in', '', 1),
(177, 2, '2024-07-04 14:19:47', 'in', '', 1),
(178, 2, '2024-07-04 14:19:50', 'out', '', 2),
(179, 2, '2024-07-04 14:19:55', 'in', '', 1),
(180, 9, '2024-07-04 14:20:02', 'in', '', 1),
(181, 9, '2024-07-04 14:20:05', 'out', '', 2),
(182, 9, '2024-07-04 14:20:40', 'in', '', 1),
(183, 2, '2024-07-04 14:20:57', 'out', '', 2),
(184, 3, '2024-07-04 14:23:52', 'out', 'xasdas', 2),
(185, 9, '2024-07-04 14:24:04', 'out', 'Hello', 2),
(186, 9, '2024-07-04 14:24:10', 'in', '', 1),
(187, 7, '2024-07-04 14:43:47', 'in', '', 1),
(188, 2, '2024-07-04 14:56:45', 'in', '', 1),
(189, 2, '2024-07-04 14:56:49', 'out', '', 2),
(190, 9, '2024-07-04 14:58:28', 'out', '', 2),
(191, 7, '2024-07-04 14:58:32', 'out', '', 2),
(192, 7, '2024-07-04 14:58:34', 'in', '', 1),
(193, 6, '2024-07-04 14:58:42', 'in', '', 1),
(194, 7, '2024-07-04 14:58:44', 'out', '', 2),
(195, 7, '2024-07-04 14:58:48', 'in', '', 1),
(196, 2, '2024-07-04 14:58:55', 'in', '', 1),
(197, 2, '2024-07-04 14:58:58', 'out', '', 2),
(198, 3, '2024-07-04 14:59:00', 'in', '', 1),
(199, 4, '2024-07-29 10:28:13', 'in', 'in monday', 1),
(200, 4, '2024-07-29 10:29:52', 'out', 'out', 2);

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4  ;

--
-- Dumping data for table `employee_registration`
--

INSERT INTO `employee_registration` (`employee_id`, `first_name`, `last_name`, `email`, `password`, `phone_number`, `department`, `position`, `is_admin`, `hire_date`, `address`, `city`, `postal_code`, `country`, `date_of_birth`, `gender`, `emergency_contact_name`, `emergency_contact_number`, `created_at`, `updated_at`, `is_assigned`, `is_assigned_department`) VALUES
(2, 'Re Ann', 'Nunez', 'reannsabandal544@gmail.com', '$2y$10$o3.YKXQaRdHjqtSV0Tnqgu1RMXKHs7p19tTS5tI7Siw.Mi.bW3nRq', '09383403973', 'BSN', 'Employee', 0, '2024-06-07', 'Cambite, Tomas Oppus, Southern Leyte', 'Maasin City', '6605', 'Philippines', '2002-11-10', 'Male', 'RICO JAMES MAITIM SABANDAL', '09383403973', '2024-06-24 12:50:33', '2024-11-13 15:07:30', 0, 1),
(3, 'Rico James', 'Sabandal', 'jamessabandal544@gmail.com', '$2y$10$15d10bryJmLT3bEpP7akTOEEoE9sFMzwCz3vjUQhITwdPrm4uIGsC', '09383403973', 'BSIT', 'Dean', 0, '2024-06-05', 'Tinago, Tomas Oppus, Southern leyte', 'Maasin City', '6605', 'Philippines', '2000-12-18', 'Male', 're ann nunez', '09383403973', '2024-06-24 16:31:46', '2024-09-04 09:41:56', 0, 0),
(4, 'Ryan', 'Nunez', 'ryansabandal544@gmail.com', '$2y$10$uWI7M1XgJ5fwIq0qZrEM3OZVS8o.2TI8NZpjVALVvF5wMH1Dn3Rh.', '09383403973', 'BSN', 'Dean', 0, NULL, 'Cambite, Tomas Oppus, Southern leyte', 'Maasin City', '6605', 'Philippines', '2024-06-20', 'Male', 're ann nunez', '09383403973', '2024-06-25 01:46:44', '2024-07-04 02:28:34', 0, 0),
(5, 'Riche Jim', 'Sabandal', 'richesabandal544@gmail.com', '$2y$10$LbwbWv7PfBJ6xNhWz3OV/.Kyx7nmqnaP2sOzQ7Ci/BXEkpvGI09Lm', '09383403973', 'BSN', 'Dean', 0, NULL, 'Tinago, Tomas Oppus, Southern leyte', 'Maasin City', '6605', 'Philippines', '2024-06-14', 'Male', 'RICO JAMES MAITIM SABANDAL', '09383403973', '2024-06-25 09:39:22', '2024-09-04 09:41:56', 0, 0),
(6, 'admin', 'admin', 'admin@admin', '$2y$10$FiopApI/9wwk.c2.WWeEFeyiEOQaxEY4ZCcen.WdLHSbG0JsEg6Le', 'admin', 'admin', 'admin', 1, NULL, 'admin', 'admin', 'admin', 'admin', '2024-06-25', 'Male', 'admin', 'admin', '2024-06-25 12:00:08', '2024-07-04 02:28:34', 0, 0),
(7, 'Susana', 'Sabandal', 'susanasabanda544l@gmail.com', '$2y$10$YSlUlY9yntBgJnJAVZ5t/eCNkuBYlw6XAhVk9t5PuTygRQOHyy.ry', '09383403973', 'BSMB', 'Manager', 0, NULL, 'Tinago, Tomas Oppus, Southern leyte', 'Maasin City', '6605', 'Philippines', '1978-05-26', 'Female', 'Antero Sabandal', '09383403973', '2024-06-26 10:20:46', '2024-07-29 02:32:37', 0, 0),
(9, 'Roland', 'Nacano', 'jayjaynax152@gmail.com', '$2y$10$oyQ0yVQKPskfrp/zd/gEXuc3ih06OCp4Gi6WPCfaCUt3dRFadruuS', '09559104489', 'BSIT', 'Instructor', 0, NULL, 'Bogo Tomas Oppus Southern Leyte', 'Southern Leyte', '5508', 'Philippines', '2004-03-10', 'Male', 'Roland', '09738926321', '2024-07-04 06:07:15', '2024-07-29 02:32:37', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `flag_type`
--

CREATE TABLE `flag_type` (
  `flag_id` int NOT NULL,
  `flag_type` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4  ;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4  ;

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
  `department` varchar(100) CHARACTER SET utf8mb4   DEFAULT NULL,
  `year_level` int DEFAULT NULL,
  `section` varchar(50) DEFAULT NULL,
  `enrollment_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `postal_code` varchar(20) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `emergency_contact_name` varchar(100) CHARACTER SET utf8mb4   DEFAULT NULL,
  `emergency_contact_number` varchar(15) CHARACTER SET utf8mb4   DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_assigned` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4  ;

--
-- Dumping data for table `student_registration`
--

INSERT INTO `student_registration` (`student_id`, `first_name`, `last_name`, `email`, `password`, `phone_number`, `department`, `year_level`, `section`, `enrollment_date`, `address`, `city`, `postal_code`, `country`, `date_of_birth`, `gender`, `emergency_contact_name`, `emergency_contact_number`, `created_at`, `updated_at`, `is_assigned`) VALUES
(1, 'Rico James', 'Sabandal', 'ricosabandal544@gmail.com', '$2y$10$k76qFas1u.cBHrHiA.DJwOFHgkaC0kU5KQQTmBQFmSk7wMsY5t53i', '09383403973', 'BSIT', 3, 'A', '2000-12-17 16:00:00', 'Tinago, Tomas Oppus, Southern Leyte', 'Maasin City', '3444', 'Philippines', '2000-12-18', 'Male', 'Re Ann Nunez', '09383403973', '2024-11-13 03:39:04', '2024-11-14 10:59:03', 0),
(2, 'qqq', 'qqqq', 'qqq@qqq', '$2y$10$iDryjXAOuIcxmgipIXxCTOaOiv14KzTQ3ysZX4L.lzGSlAYEsAhsW', '09383403973', '', NULL, NULL, NULL, 'Tinago, Tomas Oppus, Southern Leyte', 'Maasin City', '3444', 'Philippines', '2000-12-18', 'Male', '', '', '2024-11-13 14:03:36', '2024-11-13 14:03:36', 0),
(3, 'Re Ann', 'Sabandal', 'reannsabandal544@gmail.com', '$2y$10$S3BT7c8SI3SkH7FQmuGFuuUfxJbmBTNbxUSCIvcsa8Fk2w0PyYSD6', '09383403973', 'BSIT', 3, 'A', '2024-11-13 14:16:12', 'Tinago, Tomas Oppus, Southern Leyte', 'Maasin City', '3444', 'Philippines', '2002-11-10', 'Female', 'Re Ann Nunez', '09383403973', '2024-11-13 14:16:12', '2024-11-13 14:16:12', 0),
(4, 'admin', 'admin', 'admin@admin', '$2y$10$l7VO7pC3XKX03h2xfi1I3./bvJYo6DWhK7Th4yrtKUToGqKJlvO12', '09383403973', 'BSIT', 3, 'B', '2024-11-14 12:37:07', 'admin', 'admin', 'admin', 'admin', '2000-12-18', 'Male', 'admin', 'admin', '2024-11-14 12:37:07', '2024-11-14 12:37:07', 0);

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
  MODIFY `attendance_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `employee_attendance_flag`
--
ALTER TABLE `employee_attendance_flag`
  MODIFY `attendance_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=180;

--
-- AUTO_INCREMENT for table `employee_attendance_gate`
--
ALTER TABLE `employee_attendance_gate`
  MODIFY `attendance_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=201;

--
-- AUTO_INCREMENT for table `employee_registration`
--
ALTER TABLE `employee_registration`
  MODIFY `employee_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `flag_type`
--
ALTER TABLE `flag_type`
  MODIFY `flag_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `student_attendance_flag`
--
ALTER TABLE `student_attendance_flag`
  MODIFY `attendance_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `student_registration`
--
ALTER TABLE `student_registration`
  MODIFY `student_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

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
-- Constraints for table `student_attendance_flag`
--
ALTER TABLE `student_attendance_flag`
  ADD CONSTRAINT `student_attendance_flag_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `student_registration` (`student_id`),
  ADD CONSTRAINT `student_attendance_flag_ibfk_2` FOREIGN KEY (`flag_id`) REFERENCES `flag_type` (`flag_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
