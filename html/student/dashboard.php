<?php
session_start();

// Check if user is not logged in or is not a student
if (!isset($_SESSION['user_role']) || $_SESSION['user_role'] !== 'student') {
    header("Location: ../choose.php"); // Redirect to login page if not logged in as student
    exit();
}

// Include the database connection script
require '../config.php';

// Fetch student information based on session student_id
if (isset($_SESSION['student_id'])) {
    $student_id = $_SESSION['student_id'];

    // Fetch student name
    $query_student = "SELECT first_name, last_name FROM student_registration WHERE student_id = ?";
    $stmt_student = $conn->prepare($query_student);
    $stmt_student->bind_param("i", $student_id);
    $stmt_student->execute();
    $stmt_student->bind_result($first_name, $last_name);
    $stmt_student->fetch();
    $stmt_student->close();

    // Fetch attendance status for the current date
    $current_date = date("Y-m-d");
    
    // Attendance status (present, absent, late)
    $query_status = "SELECT attendance_status FROM student_attendance_flag WHERE student_id = ? AND DATE(attendance_date) = ?";
    $stmt_status = $conn->prepare($query_status);
    $stmt_status->bind_param("is", $student_id, $current_date);
    $stmt_status->execute();
    $stmt_status->bind_result($attendance_status);
    $stmt_status->fetch();
    $stmt_status->close();
} else {
    // Handle case where student_id is not set in session
    die("Student ID not set in session.");
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
            <?php include('../navbar/student/sidenavbar.php'); ?>
            <!-- / Menu -->

            <!-- Layout container -->
            <div class="layout-page">
                <!-- Navbar -->
                <?php include('../navbar/student/navbar.php'); ?>
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
                                                    <h3>You have access to student features.</h3>
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
                                        <a href="student_attendance_information_flag.php" class="card-link">
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

        <!-- Overlay -->
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
