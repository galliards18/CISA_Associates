<?php
session_start();

// Check if user is not logged in or is not a student
if (!isset($_SESSION['user_role']) || $_SESSION['user_role'] !== 'student') {
    header("Location: ../choose.php"); // Redirect to login page if not logged in as student
    exit();
}

// Include the database connection script
require '../config.php';

$student_id = $_SESSION['student_id'];
$attendance_flags = []; // Initialize $attendance_flags as an empty array
$selected_month = isset($_GET['month']) ? $_GET['month'] : date('Y-m');

// Fetch all attendance records for the logged-in student grouped by month
$stmt_all = $conn->prepare("SELECT attendance_date, attendance_status FROM student_attendance_flag WHERE student_id = ? AND DATE_FORMAT(attendance_date, '%Y-%m') = ? ORDER BY attendance_date DESC");
$stmt_all->bind_param("is", $student_id, $selected_month);
$stmt_all->execute();
$result_all = $stmt_all->get_result();

// Initialize an array to hold attendance data grouped by month
$attendance_by_month = [];

while ($row = $result_all->fetch_assoc()) {
    $month = date('F Y', strtotime($row['attendance_date'])); // Get the month and year
    $attendance_by_month[$month][] = $row; // Group data by month
}

// Close the statement
$stmt_all->close();

// Fetch is_assigned status for the student
$stmt_assigned = $conn->prepare("SELECT is_assigned FROM student_registration WHERE student_id = ?");
$stmt_assigned->bind_param("i", $student_id);
$stmt_assigned->execute();
$stmt_assigned->bind_result($is_assigned); // Only bind the is_assigned value
$stmt_assigned->fetch();
$stmt_assigned->close();
?>
<!DOCTYPE html>
<html lang="en" class="light-style layout-menu-fixed" dir="ltr" data-theme="theme-default" data-assets-path="../../assets/" data-template="vertical-menu-template-free">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />
    <title>Attendance Monitoring System</title>
    <meta name="description" content="" />
    <!-- Favicon -->
    <link rel="icon" type="image/x-icon" href="../../assets/img/avatars/logo.png"/>
    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- FullCalendar CSS -->
    <link href="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.0/main.min.css" rel="stylesheet" />
    <!-- FullCalendar JS -->
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.0/main.min.js"></script>


    <!-- Icons. Uncomment required icon fonts -->
    <link rel="stylesheet" href="../../assets/vendor/fonts/boxicons.css" />
    <!-- Core CSS -->
    <link rel="stylesheet" href="../../assets/vendor/css/core.css" class="template-customizer-core-css" />
    <link rel="stylesheet" href="../../assets/vendor/css/theme-default.css" class="template-customizer-theme-css" />
    <link rel="stylesheet" href="../../assets/css/demo.css" />
    <!-- Vendors CSS -->
    <link rel="stylesheet" href="../../assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />
    <link rel="stylesheet" href="../../assets/vendor/libs/apex-charts/apex-charts.css" />
    <!-- Helpers -->
    <script src="../../assets/vendor/js/helpers.js"></script>
    <!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
    <!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
    <script src="../../assets/js/config.js"></script>
    <style>
        body {
            font-family: poppins, sans-serif;
            background-color: #f9f9f9;
        }
        .container {
            max-width: 800px;
            margin: 50px auto;
            background-color: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }
        h4 {
            margin-bottom: 20px;
        }
        form {
            margin-bottom: 20px;
        }
        .table-responsive {
            margin-top: 20px;
        }
        ul {
            list-style-type: none;
            padding: 0;
        }
        ul li {
            margin-bottom: 10px;
        }
        .present {
            color: green;
            font-weight: bold;
        }
        .absent {
            color: red;
            font-weight: bold;
        }
        .late {
            color: orange;
            font-weight: bold;
        }
        .centered-button {
            text-align: center;
            margin-top: 20px;
        }
        .attendance-table th, .attendance-table td {
            padding: 10px;
            text-align: left;
        }
        .attendance-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 30px;
        }
        .attendance-table th {
            background-color: #f1f1f1;
        }
        .attendance-table tr:nth-child(even) {
            background-color: #f9f9f9;
        }
    </style>
</head>

<body>
    <!-- Layout wrapper -->
    <div class="layout-wrapper layout-content-navbar">
        <div class="layout-container">
            <!-- Menu -->
            <aside id="layout-menu" class="layout-menu menu-vertical menu bg-menu-theme">
                <div class="app-brand demo" style=" padding: 70px;">
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
                <div class="menu-inner-shadow"></div>
                <ul class="menu-inner py-1">
                    <!-- Profile -->
                    <li class="menu-item">
                        <a href="dashboard.php" class="menu-link">
                            <i class="menu-icon tf-icons bx bx-chalkboard"></i>
                            <div data-i18n="Layouts">Dashboard</div>
                        </a>
                    </li>
                    <li class="menu-item active">
                        <a href="javascript:void(0);" class="menu-link menu-toggle">
                            <i class="menu-icon tf-icons bx bx-calendar-check"></i>
                            <div data-i18n="Layouts">Attendance</div>
                        </a>
                        <ul class="menu-sub">
                            <!-- <li class="menu-item">
                                <a href="employee_attendance_information_gate.php" class="menu-link">
                                    <div data-i18n="Without menu">Gate Marking</div>
                                </a>
                            </li> -->
                            <li class="menu-item active">
                                <a href="student_attendance_information_flag.php" class="menu-link">
                                    <div data-i18n="Without menu">Flag Ceremony</div>
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
                            <!-- User -->
                            <li class="nav-item navbar-dropdown dropdown-user dropdown">
                                <a class="nav-link dropdown-toggle hide-arrow" href="javascript:void(0);" data-bs-toggle="dropdown">
                                    <div class="avatar avatar-online">
                                        <img src="../../assets/img/avatars/profile.png" alts class="w-px-40 h-auto rounded-circle" />
                                    </div>
                                    <?php
                                    // SQL query to select student details by student_id
                                    $sql = "SELECT * FROM student_registration WHERE student_id = ?";

                                    // Use prepared statement to prevent SQL injection
                                    $stmt = $conn->prepare($sql);
                                    if ($stmt) {
                                        $stmt->bind_param("i", $student_id);

                                        // Execute query
                                        $stmt->execute();

                                        // Get result
                                        $result = $stmt->get_result();

                                        // Check if student exists
                                        if ($result->num_rows > 0) {
                                            // Fetch student details as an associative array
                                            $row = $result->fetch_assoc();
                                        } else {
                                            echo "Employee not found";
                                        }

                                        // Close prepared statement
                                        $stmt->close();
                                    } else {
                                        echo "Database query failed"; // Handle potential SQL statement preparation error
                                    }
                                    ?>
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end">
                                    <li>
                                        <a class="dropdown-item" href="student.php">
                                            <div class="d-flex">
                                                <div class="flex-shrink-0 me-3">
                                                    <div class="avatar avatar-online">
                                                        <img src="../../assets/img/avatars/profile.png" alt class="w-px-40 h-auto rounded-circle" />
                                                    </div>
                                                </div>
                                                <div class="flex-grow-1">
                                                    <span class="fw-semibold d-block"></span>
                                                    <small class="text-muted"><?php echo isset($row['first_name']) ? htmlspecialchars($row['first_name']) : ''; ?><br><?php echo isset($row['last_name']) ? htmlspecialchars($row['last_name']) : ''; ?></small>
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
                        <!-- Search form -->
                        <div class="row mb-3">
                            <div class="col-lg-12">
                                <form class="d-flex" method="get">
                                    <input class="form-control me-2" id="month" type="month" name="month" aria-label="Search" name="search" value="<?php echo htmlspecialchars($selected_month); ?>" required>
                                    <button class="btn btn-outline-primary" type="submit">Search</button>
                                </form>
                            </div>
                        </div>
                        <!-- /Search form -->
                    <div class="row">
                        <div class="col-lg-12 mb-4 order-0">
                            <div class="card">
                                <div class="d-flex align-items-end row">
                                    <div class="col-lg-10">
                                        <div class="container-xxl flex-grow-1 container-p-y">
                                            <div class="row">
                                                <h2>Student Attendance: Flag Ceremony</h2>
                                                <div class="col-lg-12 mb-4 order-0">
                                                    <?php if ($is_assigned == 1) : ?>
                                                        <div class="centered-button mb-3 mt-3">
                                                            <a href="assign_attendance.php" class="btn btn-primary">
                                                                Assigned for Attendance
                                                            </a>
                                                        </div>
                                                    <?php endif; ?>
                                                    
                                                    <!-- Display attendance flags -->
                                                    <div class="table-responsive">
                                                        <?php if (!empty($attendance_by_month)) : ?>
                                                            <?php foreach ($attendance_by_month as $month => $attendance_records) : ?>
                                                                <h4>Attendance for <?php echo $month; ?></h4>
                                                                <table class="attendance-table">
                                                                    <thead>
                                                                        <tr>
                                                                            <th>Date</th>
                                                                            <th>Status</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                        <?php foreach ($attendance_records as $record) : ?>
                                                                            <tr>
                                                                                <td><?php echo date('F j, Y', strtotime($record['attendance_date'])); ?></td>
                                                                                <td><?php echo ucfirst(strtolower(htmlspecialchars($record['attendance_status']))); ?></td>
                                                                            </tr>
                                                                        <?php endforeach; ?>
                                                                    </tbody>
                                                                </table>
                                                            <?php endforeach; ?>
                                                        <?php else : ?>
                                                            <h2>No attendance records found for <?php echo htmlspecialchars($selected_month); ?></h2>
                                                        <?php endif; ?>
                                                    </div>

                                                    <!-- Back button -->
                                                    <div class="centered-button">
                                                        <a href="dashboard.php" class="btn btn-primary">
                                                            <i class="bx bx-chevron-left"></i> Back to Dashboard
                                                        </a>
                                                    </div>
                                                    <style>
                                                        .attendance-flags li {
                                                            font-size: 25px; /* Adjust the font size as needed */
                                                            text-transform: capitalize; /* Capitalize the text */
                                                            margin-bottom: 10px; /* Optional: Adjust spacing between list items */
                                                        }
                                                    </style>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    </div>
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
                </div>
                <!-- Footer -->
                <!-- / Footer -->
                <div class="content-backdrop fade"></div>
            </div>
            <!-- Content wrapper -->
        </div>
        <!-- / Layout page -->
    </div>
    <!-- Overlay -->
    <div class="layout-overlay layout-menu-toggle"></div>
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

</body>
</html>
