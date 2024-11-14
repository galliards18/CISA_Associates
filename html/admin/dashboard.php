<?php
session_start();

// Check if user is not logged in or is not an admin
if (!isset($_SESSION['user_role']) || $_SESSION['user_role'] !== 'admin') {
    header("Location: ../choose.php"); // Redirect to login page if not logged in as admin
    exit();
}

// Include the database connection script
require '../config.php';

// Initialize variables
$first_name = ''; // Initialize $first_name variable
$last_name = '';  // Initialize $last_name variable

// Fetch employee information based on session employee_id
if (isset($_SESSION['employee_id'])) {
    $employee_id = $_SESSION['employee_id'];
    // Example query to fetch employee first and last names
    $query = "SELECT first_name, last_name FROM employee_registration WHERE employee_id = $employee_id";
    $result = $conn->query($query);
    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();
        $first_name = $row['first_name']; // Assign fetched first name to $first_name
        $last_name = $row['last_name'];   // Assign fetched last name to $last_name
    }
}

// Query to count the total number of employees
$employeeCountQuery = "SELECT COUNT(*) AS totalEmployees FROM employee_registration";
$result = $conn->query($employeeCountQuery);
$totalEmployees = $result->fetch_assoc()['totalEmployees'];

// Query to count the total number of students
$studentCountQuery = "SELECT COUNT(*) AS totalStudents FROM student_registration";
$result = $conn->query($studentCountQuery);
$totalStudents = $result->fetch_assoc()['totalStudents'];

// Query to count the number of employees present today based on the `employee_attendance_flag` table
$today = date('Y-m-d');

// Count employees present today
$presentCountQuery = "SELECT COUNT(*) AS totalPresent 
                      FROM employee_attendance_flag 
                      WHERE DATE(attendance_date) = '$today' 
                      AND attendance_status = 'present'";
$result = $conn->query($presentCountQuery);
$totalPresent = $result->fetch_assoc()['totalPresent'];

// Query to count the number of employees currently inside the campus based on the `employee_attendance_gate` table
$insideCampusQuery = "SELECT COUNT(DISTINCT employee_id) AS totalInside 
                      FROM employee_attendance_gate 
                      WHERE DATE(entry_time) = '$today' AND entry_type = 'in'
                      AND attendance_id > IFNULL(
                          (SELECT MAX(attendance_id) 
                           FROM employee_attendance_gate AS eg 
                           WHERE eg.entry_type = 'out' 
                           AND DATE(eg.entry_time) = '$today' 
                           AND eg.employee_id = employee_attendance_gate.employee_id), 0)";
$result = $conn->query($insideCampusQuery);
$totalInside = $result->fetch_assoc()['totalInside'];
?>


<!DOCTYPE html>
<html lang="en" class="light-style layout-menu-fixed" dir="ltr" data-theme="theme-default" data-assets-path="../../assets/" data-template="vertical-menu-template-free">
<head>
    <meta charset="utf-8" />
    <meta
      name="viewport"
      content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0"
    />

    <title>Attendance Monitoring System</title>

    <meta name="description" content="" />

    <!-- Favicon -->
    <link rel="icon" type="image/x-icon" href="../../assets/img/avatars/logo.png"/>

    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <!-- Link Poppins font -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <!-- Icons. Uncomment required icon fonts -->
    <link rel="stylesheet" href="../../assets/vendor/fonts/boxicons.css" />
    <link href="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.0/main.min.css" rel="stylesheet" />
    <!-- FullCalendar JS -->
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.0/main.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> <!-- Include jQuery -->



    <!-- Core CSS -->
    <link rel="stylesheet" href="../../assets/vendor/css/core.css" class="template-customizer-core-css" />
    <link rel="stylesheet" href="../../assets/vendor/css/theme-default.css" class="template-customizer-theme-css" />
    <link rel="stylesheet" href="../../assets/css/demo.css" />

    <!-- Vendors CSS -->
    <link rel="stylesheet" href="../../assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />

    <link rel="stylesheet" href="../../assets/vendor/libs/apex-charts/apex-charts.css" />

    <!-- Page CSS -->

    <!-- Helpers -->
    <script src="../../assets/vendor/js/helpers.js"></script>

    <!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
    <!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
    <script src="../../assets/js/config.js"></script>

    <!-- Apply Poppins font globally -->
    <style>
        body, .btn, .menu-link, .navbar-nav-right, .footer, .app-brand, .queue-number {
            font-family: 'Poppins', sans-serif;
        }

        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .btn-primary {
            background-color: #007bff;
            color: #fff;
        }

        .btn-primary:hover {
            background-color: #0056b3;
        }

        .btn-success {
            background-color: #28a745;
            color: #fff;
        }

        .btn-success:hover {
            background-color: #218838;
        }

        .queue-number {
            font-size: 24px;
            font-weight: bold;
            margin: 0 20px;
        }

        .centered-button {
            text-align: center;
            margin-top: 20px;
        }

        /* Ensure the card maintains its style and size even when wrapped in a link */
        .card-link {
            text-decoration: none; /* Remove underline from the link */
            color: inherit; /* Inherit text color */
            display: block; /* Make the link block to cover the entire card */
        }

        /* Calendar styling */
        #calendar {
            max-width: 100%;
            margin: 20px auto;
        }
    </style>
</head>

<body>
    <!-- Layout wrapper -->
    <div class="layout-wrapper layout-content-navbar">
        <div class="layout-container">
            <aside id="layout-menu" class="layout-menu menu-vertical menu bg-menu-theme">
                <div class="app-brand demo" style="padding: 70px;">
                    <div class="logo">
                        <img style="border-radius: 500px; box-shadow: 2px 2px 20px #00008b; margin-top: 30px; margin-bottom: 5px;" src="../../assets/img/avatars/logo.png" width="100" height="100" alt="">
                        <b><p style="font-size: 20px; color: blue; text-shadow: 2px 2px 50px #00008b; padding-left: 18px;">S L S U</p></b>
                    </div>

                    <a href="javascript:void(0);" class="layout-menu-toggle menu-link text-large ms-auto d-block d-xl-none">
                        <i class="bx bx-chevron-left bx-sm align-middle"></i>
                    </a>
                </div>

                <div class="menu-inner-shadow"></div>

                <ul class="menu-inner py-1">
                    <!-- Dashboard -->
                    <li class="menu-item active">
                        <a href="dashboard.php" class="menu-link">
                            <i class="menu-icon tf-icons bx bx-chalkboard"></i>
                            <div data-i18n="Analytics">Dashboard</div>
                        </a>
                    </li>
                    <li class="menu-item">
                        <a href="javascript:void(0);" class="menu-link menu-toggle">
                            <i class="menu-icon tf-icons bx bx-user-circle"></i>
                            <div data-i18n="Layouts">User</div>
                        </a>
                        <ul class="menu-sub">
                            <li class="menu-item">
                              <a href="student.php" class="menu-link">
                                <div data-i18n="Analytics">Student</div>
                              </a>
                            </li>
                            <li class="menu-item">
                                <a href="employee.php" class="menu-link">
                                    <div data-i18n="Analytics">Employee</div>
                                </a>
                            </li>
                        </ul>
                    </li>
                    <li class="menu-item">
                        <a href="javascript:void(0);" class="menu-link menu-toggle">
                            <i class="menu-icon tf-icons bx bx-calendar-check"></i>
                            <div data-i18n="Analytics">Attendance</div>
                        </a>
                        <ul class="menu-sub">
                            <li class="menu-item">
                              <a href="attendance_gate.php" class="menu-link">
                                <div data-i18n="Analytics">Gate Marking</div>
                              </a>
                            </li>
                            <li class="menu-item">
                              <a href="employee_attendance_information_flag.php" class="menu-link">
                                <div data-i18n="Analytics">Flag Ceremony</div>
                              </a>
                            </li>
                        </ul>
                    </li>
                    <!-- <li class="menu-item">
                        <a href="javascript:void(0);" class="menu-link menu-toggle">
                            <i class="menu-icon tf-icons bx bx-calendar-event"></i>
                            <div data-i18n="Layouts">Event</div>
                        </a>
                        <ul class="menu-sub">
                            <li class="menu-item">
                                <a href="create_event.php" class="menu-link">
                                    <div data-i18n="Analytics">Create Event</div>
                                </a>
                            </li>
                            <li class="menu-item">
                                <a href="archive_event.php" class="menu-link">
                                    <div data-i18n="Analytics">Archive Event</div>
                                </a>
                            </li>
                        </ul>
                    </li> -->
                    <li class="menu-item">
                        <a href="javascript:void(0);" class="menu-link menu-toggle">
                            <i class="menu-icon tf-icons bx bx-printer"></i>
                            <div data-i18n="Analytics">Print</div>
                        </a>
                        <ul class="menu-sub">
                            <li class="menu-item">
                                <a href="print/print_flag.php" class="menu-link">
                                    <div data-i18n="Analytics">Flag Ceremony Record</div>
                                </a>
                            </li>
                            <li class="menu-item">
                                <a href="print/print_gate.php" class="menu-link">
                                    <div data-i18n="Analytics">Gate Marking Record</div>
                                </a>
                            </li>
                        </ul>
                    </li>
                </ul>
            </aside>
            <!-- / Menu -->

            <!-- Layout container -->
            <div class="layout-page">
                <!-- Navbar -->
                <nav
                    class="layout-navbar container-xxl navbar navbar-expand-xl navbar-detached align-items-center bg-navbar-theme"
                    id="layout-navbar"
                >
                    <div class="layout-menu-toggle navbar-nav align-items-xl-center me-3 me-xl-0 d-xl-none">
                        <a class="nav-item nav-link px-0 me-xl-4" href="javascript:void(0)">
                            <i class="bx bx-menu bx-sm"></i>
                        </a>
                    </div>

                    <div class="navbar-nav-right d-flex align-items-center" id="navbar-collapse">
                            <center> 
                                <p style="font-size: 18px; padding-top: 15px;"><b>Southern Leyte State University</b></p>  
                            </center>
                        <ul class="navbar-nav flex-row align-items-center ms-auto">

                            <!-- User -->
                            <li class="nav-item navbar-dropdown dropdown-user dropdown">
                                <a class="nav-link dropdown-toggle hide-arrow" href="javascript:void(0);" data-bs-toggle="dropdown">
                                    <div class="avatar avatar-online">
                                        <img src="../../assets/img/avatars/user.png" alts class="w-px-40 h-auto rounded-circle" />
                                    </div>
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end">
                                    <li>
                                        <a class="dropdown-item" href="admin_profile.php">
                                            <div class="d-flex">
                                                <div class="flex-shrink-0 me-3">
                                                    <div class="avatar avatar-online">
                                                        <img src="../../assets/img/avatars/user.png" alt class="w-px-40 h-auto rounded-circle" />
                                                    </div>
                                                </div>
                                                <div class="flex-grow-1">
                                                    <span class="fw-semibold d-block"></span>
                                                    <small class="text-muted">Admin</small>
                                                </div>
                                            </div>
                                        </a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="../logout.php">
                                            <i class="bx bx-power-off me-2"></i>
                                            <span class="align-middle">Log Out</span>
                                        </a>
                                    </li>
                                </ul>
                            </li>
                            <!--/ User -->

                        </ul>
                    </div>
                </nav>
                <!-- / Navbar -->

                <!-- Content wrapper -->
                <div class="content-wrapper">
                    <!-- Content -->
                    <div class="container-xxl flex-grow-1 container-p-y">
                        <div class="row">
                            <div class="col-lg-12 mb-1 order-0">
                                <div class="card">
                                    <div class="d-flex align-items-end row">
                                        <div class="col-sm-7">
                                            <!-- Calendar Container -->
                                            <div style="padding: 20px;">
                                                <div id="calendar" style="max-width: 600px; width: 100%; margin: 20px auto;"></div>
                                            </div>
                                        </div>
                                        <div class="col-sm-5 text-center text-sm-left">
                                            <div class="card-body">
                                                <h1 class="text-primary">Welcome, <?php echo $first_name . ' ' . $last_name; ?>!</h1>
                                                <h3 class="card-text">You have access to administrative features.</h3>
                                            </div>
                                            <div class="card-body pb-0 px-0 px-md-4 mt-5">
                                                <img
                                                    src="../../assets/img/illustrations/man-with-laptop-light.png"
                                                    height="140"
                                                    alt="View Badge User"
                                                    data-app-dark-img="illustrations/man-with-laptop-dark.png"
                                                    data-app-light-img="illustrations/man-with-laptop-light.png"
                                                />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-12 mb-1 order-0 container-p-y">
                                <div class="row">
                                    <!-- Total Employees & Total Students Card (Merged into one column) -->
                                    <div class="col-lg-4 mb-4">
                                        <div class="row">
                                            <!-- Total Employees Card -->
                                            <div class="col-6 mb-4">
                                                <a href="employee.php" class="card-link">
                                                    <div class="card">
                                                        <div class="card-body">
                                                            <h5 class="card-title">Total Employees</h5>
                                                            <p class="card-text">
                                                                <span class="queue-number"><?php echo $totalEmployees; ?></span>
                                                            </p>
                                                        </div>
                                                    </div>
                                                </a>
                                            </div>
                                            <!-- Total Students Card -->
                                            <div class="col-6 mb-4">
                                                <a href="student.php" class="card-link">
                                                    <div class="card">
                                                        <div class="card-body">
                                                            <h5 class="card-title">Total Students</h5>
                                                            <p class="card-text">
                                                                <span class="queue-number"><?php echo $totalStudents; ?></span>
                                                            </p>
                                                        </div>
                                                    </div>
                                                </a>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Attendance Today Card -->
                                    <div class="col-lg-4 mb-4">
                                        <a href="employee_attendance_information_flag.php" class="card-link">
                                            <div class="card">
                                                <div class="card-body">
                                                    <h5 class="card-title text-center">Flag Attendance Today</h5>
                                                    <div class="attendance-summary">
                                                        <?php
                                                        // Today's date
                                                        $today = date('Y-m-d');

                                                        // Employee attendance queries
                                                        $presentCountQuery = "SELECT COUNT(*) AS totalPresent FROM employee_attendance_flag WHERE DATE(attendance_date) = '$today' AND attendance_status = 'present'";
                                                        $result = $conn->query($presentCountQuery);
                                                        $totalEmployeePresent = $result->fetch_assoc()['totalPresent'];

                                                        $absentCountQuery = "SELECT COUNT(*) AS totalAbsent FROM employee_attendance_flag WHERE DATE(attendance_date) = '$today' AND attendance_status = 'absent'";
                                                        $result = $conn->query($absentCountQuery);
                                                        $totalEmployeeAbsent = $result->fetch_assoc()['totalAbsent'];

                                                        $lateCountQuery = "SELECT COUNT(*) AS totalLate FROM employee_attendance_flag WHERE DATE(attendance_date) = '$today' AND attendance_status = 'late'";
                                                        $result = $conn->query($lateCountQuery);
                                                        $totalEmployeeLate = $result->fetch_assoc()['totalLate'];

                                                        // Student attendance queries
                                                        $presentStudentCountQuery = "SELECT COUNT(*) AS totalPresent FROM student_attendance_flag WHERE DATE(attendance_date) = '$today' AND attendance_status = 'present'";
                                                        $result = $conn->query($presentStudentCountQuery);
                                                        $totalStudentPresent = $result->fetch_assoc()['totalPresent'];

                                                        $absentStudentCountQuery = "SELECT COUNT(*) AS totalAbsent FROM student_attendance_flag WHERE DATE(attendance_date) = '$today' AND attendance_status = 'absent'";
                                                        $result = $conn->query($absentStudentCountQuery);
                                                        $totalStudentAbsent = $result->fetch_assoc()['totalAbsent'];

                                                        $lateStudentCountQuery = "SELECT COUNT(*) AS totalLate FROM student_attendance_flag WHERE DATE(attendance_date) = '$today' AND attendance_status = 'late'";
                                                        $result = $conn->query($lateStudentCountQuery);
                                                        $totalStudentLate = $result->fetch_assoc()['totalLate'];
                                                        ?>

                                                        <!-- Display on mobile screens -->
                                                        <div class="d-sm-none">
                                                            <div class="text-center">
                                                                <div class="row">
                                                                    <div class="col-12">
                                                                        <strong>Employees</strong>
                                                                        <div>Present: <span class="queue-number"><?php echo $totalEmployeePresent; ?></span></div>
                                                                        <div>Absent: <span class="queue-number"><?php echo $totalEmployeeAbsent; ?></span></div>
                                                                        <div>Late: <span class="queue-number"><?php echo $totalEmployeeLate; ?></span></div>
                                                                    </div>
                                                                </div>
                                                                <div class="row mt-3">
                                                                    <div class="col-12">
                                                                        <strong>Students</strong>
                                                                        <div>Present: <span class="queue-number"><?php echo $totalStudentPresent; ?></span></div>
                                                                        <div>Absent: <span class="queue-number"><?php echo $totalStudentAbsent; ?></span></div>
                                                                        <div>Late: <span class="queue-number"><?php echo $totalStudentLate; ?></span></div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        
                                                        <!-- Display on larger screens -->
                                                        <div class="d-none d-sm-block">
                                                            <div class="row text-center">
                                                                <div class="col-md-6">
                                                                    <strong>Employees</strong>
                                                                    <div>Present: <span class="queue-number"><?php echo $totalEmployeePresent; ?></span></div>
                                                                    <div>Absent: <span class="queue-number"><?php echo $totalEmployeeAbsent; ?></span></div>
                                                                    <div>Late: <span class="queue-number"><?php echo $totalEmployeeLate; ?></span></div>
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <strong>Students</strong>
                                                                    <div>Present: <span class="queue-number"><?php echo $totalStudentPresent; ?></span></div>
                                                                    <div>Absent: <span class="queue-number"><?php echo $totalStudentAbsent; ?></span></div>
                                                                    <div>Late: <span class="queue-number"><?php echo $totalStudentLate; ?></span></div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </a>
                                    </div>

                                    <!-- Employees Inside Campus Card -->
                                    <div class="col-lg-4 mb-4">
                                        <a href="attendance_gate.php" class="card-link">
                                            <div class="card">
                                                <div class="card-body">
                                                    <h5 class="card-title">Employee Currently Inside Campus</h5>
                                                    <p class="card-text">
                                                        <span class="queue-number"><?php echo $totalInside; ?></span>
                                                    </p>
                                                </div>
                                            </div>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Footer -->
                    <footer class="content-footer footer bg-footer-theme">
                        <div class="container-xxl d-flex flex-wrap justify-content-between py-2 flex-md-row flex-column">
                            <div class="mb-2 mb-md-0">
                                ©
                                <script>
                                    document.write(new Date().getFullYear());
                                </script>
                                , made with ❤️ by
                                <a href="https://www.facebook.com/james.jeager.3" target="_blank" class="footer-link fw-bolder">MeProfile</a>
                            </div>
                        </div>
                    </footer>
                    <!-- / Footer -->

                    <div class="content-backdrop fade"></div>
                </div>
                <!-- Content wrapper -->
            </div>
            <!-- / Layout page -->
        </div>

        <!-- Overlay -->
        <div class="layout-overlay layout-menu-toggle"></div>
    </div>

    <!-- Core JS -->
    <!-- build:js assets/vendor/js/core.js -->
    <script src="../../assets/vendor/libs/jquery/jquery.js"></script>
    <script src="../../assets/vendor/libs/popper/popper.js"></script>
    <script src="../../assets/vendor/js/bootstrap.js"></script>
    <script src="../../assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>

    <script src="../../assets/vendor/js/menu.js"></script>
    <!-- endbuild -->

    <!-- Vendors JS -->
    <script src="../../assets/vendor/libs/apex-charts/apexcharts.js"></script>

    <!-- Main JS -->
    <script src="../../assets/js/main.js"></script>

    <!-- Page JS -->
    <script src="../../assets/js/dashboards-analytics.js"></script>

    <!-- Place this tag in your head or just before your close body tag. -->
    <script async defer src="https://buttons.github.io/buttons.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            var calendarEl = document.getElementById('calendar');
            var calendar = new FullCalendar.Calendar(calendarEl, {
                initialView: 'dayGridMonth',
                headerToolbar: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'dayGridMonth,timeGridWeek,timeGridDay'
                },
                events: [
                    // Add your events here if needed.
                    // Example event:
                    {
                        title: 'Event 1',
                        start: '2024-06-01'
                    },
                    {
                        title: 'Event 2',
                        start: '2024-06-15',
                        end: '2024-06-17'
                    }
                ]
            });
            calendar.render();
        });
    </script>       
</body>
</html>
