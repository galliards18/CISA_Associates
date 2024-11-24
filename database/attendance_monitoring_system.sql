-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 24, 2024 at 04:58 PM
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

--
-- Dumping data for table `student_attendance_flag`
--

INSERT INTO `student_attendance_flag` (`attendance_id`, `student_id`, `attendance_date`, `attendance_status`, `flag_id`) VALUES
(1, 1, '2024-11-14 22:12:29', 'present', 1),
(2, 4, '2024-11-14 22:12:51', 'present', 1),
(3, 4, '2024-11-16 19:45:34', 'present', 1),
(4, 4, '2024-11-20 20:18:27', 'present', 1),
(5, 4, '2024-11-22 20:39:24', 'present', 2),
(6, 5, '2024-11-22 20:51:38', 'present', 2);

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
(1, 'Rico James', 'Sabandal', 'ricosabandal544@gmail.com', '$2y$10$k76qFas1u.cBHrHiA.DJwOFHgkaC0kU5KQQTmBQFmSk7wMsY5t53i', '09383403973', 'BSIT', 1, 'A', '2024-11-16', 'Tinago, Tomas Oppus, Southern Leyte', 'Maasin City', '3444', 'Philippines', '2000-12-18', 'Male', 'Re Ann Nunez', '09383403973', '2024-11-13 03:39:04', '2024-11-17 02:55:15', 1),
(3, 'Re Ann', 'Sabandal', 'reannsabandal544@gmail.com', '$2y$10$S3BT7c8SI3SkH7FQmuGFuuUfxJbmBTNbxUSCIvcsa8Fk2w0PyYSD6', '09383403973', 'BSIT', 3, 'A', '2024-11-13', 'Tinago, Tomas Oppus, Southern Leyte', 'Maasin City', '3444', 'Philippines', '2002-11-10', 'Female', 'Re Ann Nunez', '09383403973', '2024-11-13 14:16:12', '2024-11-20 12:34:00', 1),
(4, 'admin', 'admin', 'admin@admin', '$2y$10$l7VO7pC3XKX03h2xfi1I3./bvJYo6DWhK7Th4yrtKUToGqKJlvO12', '09383403973', 'BSA', 1, 'B', '2024-11-14', 'admin', 'admin', 'admin', 'admin', '2000-12-18', 'Male', 'admin', 'admin', '2024-11-14 12:37:07', '2024-11-16 01:11:27', 1),
(5, 'Re Ann', 'Nunez', 'reannsabandal544@gmail.com', '$2y$10$vQZA16PJphhTqYBZ/gpP..6NC3H1hQ8GOnrHDJxEfbwdsNE.1gGnq', '09383403973', 'BSA', 1, 'B', '2024-11-14', 'Tinago, Tomas Oppus, Southern Leyte', 'Maasin City', '3444', 'Philippines', '2002-11-10', 'Female', 'Re Ann Nunez', '09383403973', '2024-11-14 15:59:55', '2024-11-22 12:51:13', 1),
(6, 'Pearl Princess', 'Sabandal', 'pearlsabandal544@gmail.com', '$2y$10$UVQt9FdUy6TwD7a.z.I8N.LEofMJSEkZ0k/ucoAAzFrZuxp9bQbVi', '09383403973', 'BSFI', 4, 'C', '2024-11-16', 'Tinago, Tomas Oppus, Southern Leyte', 'Maasin City', '3444', 'Philippines', '2000-12-18', 'Female', 'Re Ann Nunez', '09383403973', '2024-11-16 00:07:21', '2024-11-20 12:34:06', 1);

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
  MODIFY `attendance_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=240;

--
-- AUTO_INCREMENT for table `employee_qr_log`
--
ALTER TABLE `employee_qr_log`
  MODIFY `log_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

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
  MODIFY `attendance_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `student_registration`
--
ALTER TABLE `student_registration`
  MODIFY `student_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

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
