<?php
session_start();

// Check if user is not logged in or is not an employee
if (!isset($_SESSION['user_role']) || $_SESSION['user_role'] !== 'employee') {
    header("Location: ../choose.php"); // Redirect to login page if not logged in as employee
    exit();
}

// Include the database connection script
require '../config.php';

// Fetch employee information based on session employee_id
if (isset($_SESSION['employee_id'])) {
    $employee_id = $_SESSION['employee_id'];

    // Fetch employee name
    $query_employee = "SELECT first_name, last_name FROM employee_registration WHERE employee_id = ?";
    $stmt_employee = $conn->prepare($query_employee);
    $stmt_employee->bind_param("i", $employee_id);
    $stmt_employee->execute();
    $stmt_employee->bind_result($first_name, $last_name);
    $stmt_employee->fetch();
    $stmt_employee->close();

    // Fetch attendance status for the current date
    $current_date = date("Y-m-d");
    
    // Attendance status (present, absent, late)
    $query_status = "SELECT attendance_status FROM employee_attendance_flag WHERE employee_id = ? AND DATE(attendance_date) = ?";
    $stmt_status = $conn->prepare($query_status);
    $stmt_status->bind_param("is", $employee_id, $current_date);
    $stmt_status->execute();
    $stmt_status->bind_result($attendance_status);
    $stmt_status->fetch();
    $stmt_status->close();

    // Number of times marked in
    $query_marked_in = "SELECT COUNT(*) AS total_marked_in FROM employee_attendance_gate WHERE employee_id = ? AND entry_type = 'in' AND DATE(entry_time) = ?";
    $stmt_marked_in = $conn->prepare($query_marked_in);
    $stmt_marked_in->bind_param("is", $employee_id, $current_date);
    $stmt_marked_in->execute();
    $stmt_marked_in->bind_result($total_marked_in);
    $stmt_marked_in->fetch();
    $stmt_marked_in->close();

    // Number of times marked out
    $query_marked_out = "SELECT COUNT(*) AS total_marked_out FROM employee_attendance_gate WHERE employee_id = ? AND entry_type = 'out' AND DATE(entry_time) = ?";
    $stmt_marked_out = $conn->prepare($query_marked_out);
    $stmt_marked_out->bind_param("is", $employee_id, $current_date);
    $stmt_marked_out->execute();
    $stmt_marked_out->bind_result($total_marked_out);
    $stmt_marked_out->fetch();
    $stmt_marked_out->close();
} else {
    // Handle case where employee_id is not set in session
    die("Employee ID not set in session.");
}
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
    </style>
</head>

<body>
    <!-- Layout wrapper -->
    <div class="layout-wrapper layout-content-navbar">
        <div class="layout-container">
            <!-- Menu -->
            <aside id="layout-menu" class="layout-menu menu-vertical menu bg-menu-theme">
                <div class="app-brand demo" style="padding: 70px;">
                    <div class="logo">
                        <img style="border-radius: 500px; box-shadow: 2px 2px 20px #00008b; margin-top: 30px; margin-bottom: 5px;" src="../../assets/img/avatars/logo.png" width="100" height="100" alt="">
                        <b>
                            <p style="font-size: 20px; color: blue; text-shadow: 2px 2px 50px #00008b; padding-left: 18px;">S L S U</p>
                        </b>
                    </div>
                        <a href="javascript:void(0);" class="layout-menu-toggle menu-link text-large ms-auto d-block d-xl-none">
                            <i class="bx bx-chevron-left bx-sm align-middle"></i>
                        </a>
                </div>
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
                            <div data-i18n="Layouts">Attendance</div>
                        </a>
                        <ul class="menu-sub">
                            <li class="menu-item">
                                <a href="employee_attendance_information_gate.php" class="menu-link">
                                    <div data-i18n="Without menu">Gate</div>
                                </a>
                            </li>
                            <li class="menu-item">
                                <a href="employee_attendance_information_flag.php" class="menu-link">
                                    <div data-i18n="Without menu">Flag</div>
                                </a>
                            </li>
                        </ul>
                    </li>
                    <!-- <li class="menu-item">
                        <a href="javascript:void(0);" class="menu-link menu-toggle">
                            <i class="menu-icon tf-icons bx bx-user-circle"></i>
                            <div data-i18n="Layouts">Me</div>
                        </a>
                        <ul class="menu-sub">
                            <li class="menu-item">
                                <a href="employee.php" class="menu-link">
                                    <div data-i18n="Without menu">Profile</div>
                                </a>
                            </li>
                            <li class="menu-item">
                                <a href="#.php" class="menu-link">
                                    <div data-i18n="Without menu">OTQRC</div>
                                </a>
                            </li>
                            <li class="menu-item">
                                <a href="#.php" class="menu-link">
                                    <div data-i18n="Without menu">History Log</div>
                                </a>
                            </li>
                        </ul>
                    </li> -->
                </ul>
            </aside>
            <!-- / Menu -->

            <!-- Layout container -->
            <div class="layout-page">
                <!-- Navbar -->
                <nav class="layout-navbar container-xxl navbar navbar-expand-xl navbar-detached align-items-center bg-navbar-theme" id="layout-navbar">
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
                            <!-- Place this tag where you want the button to render. -->
                            <!-- User -->
                            <li class="nav-item navbar-dropdown dropdown-user dropdown">
                                <a class="nav-link dropdown-toggle hide-arrow" href="javascript:void(0);" data-bs-toggle="dropdown">
                                    <div class="avatar avatar-online">
                                    <img src="../../assets/img/avatars/profile.png" alts class="w-px-40 h-auto rounded-circle" />
                                    </div>
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end">
                                    <li>
                                        <a class="dropdown-item" href="#">
                                            <div class="d-flex">
                                                <div class="flex-shrink-0 me-3">
                                                    <div class="avatar avatar-online">
                                                        <img src="../../assets/img/avatars/profile.png" alt class="w-px-40 h-auto rounded-circle" />
                                                    </div>
                                                </div>
                                                <div class="flex-grow-1">
                                                    <span class="fw-semibold d-block"></span>
                                                    <small class="text-muted">Employee</small>
                                                </div>
                                            </div>
                                        </a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="employee.php">
                                            <i class="bx bx-user me-2"></i><span>My Profile</span>
                                        </a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="#">
                                            <i class="bx bx-cog me-2"></i><span>Settings</span>
                                        </a>
                                    </li>
                                    <li class="dropdown">
                                        <div class="dropdown-item d-flex align-items-center">
                                            <i class="bx bx-printer me-2"></i>
                                            <select id="print-options" class="form-select" onchange="handlePrintRedirect(this)">
                                                <option value="" disabled selected>Select an option</option>
                                                <option value="print/print_flag.php">Flag Ceremony Campus</option>
                                                <option value="print/print_flag_department.php">Flag Ceremony Department</option>
                                                <option value="print/print_gate.php">Gate Marking</option>
                                            </select>
                                        </div>
                                    </li>
                                    <script>
                                        function handlePrintRedirect(select) {
                                            const selectedValue = select.value;
                                            if (selectedValue) {
                                                window.location.href = selectedValue;
                                            }
                                        }
                                    </script>
                                    <li>
                                        <a class="dropdown-item" href="qr/generate_qr.php">
                                            <i class="bx bx-qr me-2"></i><span>OTQRC</span>
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
                                            <div class="card-body pb-0 px-0 px-md-4">
                                                <div class="card-body">
                                                    <h1 class="text-primary">Welcome, <?php echo $first_name; ?>!</h1>
                                                    <h3>You have access to employee features.</h3>
                                                </div>
                                                </div>
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
                                    <!-- Attendance Status Card -->
                                    <div class="col-lg-4 mb-4">
                                        <a href="employee_attendance_information_flag.php" class="card-link">
                                            <div class="card">
                                                <div class="card-body">
                                                    <h5 class="card-title">Attendance Status</h5>
                                                    <p class="card-text">
                                                        <span class="queue-number"><?php echo isset($attendance_status) ? $attendance_status : 'Not marked'; ?></span>
                                                    </p>
                                                </div>
                                            </div>
                                        </a>
                                    </div>
                                  
                                    <!-- Mark In Count Card -->
                                    <div class="col-lg-4 mb-4">
                                        <a href="employee_attendance_information_gate.php" class="card-link">
                                            <div class="card">
                                                <div class="card-body">
                                                    <h5 class="card-title">Mark In Count for Today</h5>
                                                    <p class="card-text">
                                                        <span class="queue-number"><?php echo isset($total_marked_in) ? $total_marked_in : 0; ?></span>
                                                    </p>
                                                </div>
                                            </div>
                                        </a>
                                    </div>

                                    <!-- Mark Out Count Card -->
                                    <div class="col-lg-4 mb-4">
                                        <a href="employee_attendance_information_gate.php" class="card-link">
                                            <div class="card">
                                                <div class="card-body">
                                                    <h5 class="card-title">Mark Out Count for Today</h5>
                                                    <p class="card-text">
                                                        <span class="queue-number"><?php echo isset($total_marked_out) ? $total_marked_out : 0; ?></span>
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

                </div>
                <!-- Content wrapper -->
            </div>
            <!-- / Layout page -->
        </div>
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
    <script src="../../assets/js/pages-account-settings-account.js"></script>

    <!-- Place this tag in your head or just before your close body tag. -->
    <script async defer src="https://buttons.github.io/buttons.js"></script>

    <!-- GitHub buttons script -->
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
