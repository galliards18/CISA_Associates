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
$employee_id = null;
$attendance_data = array();
$search_date = '';

// Check if employee_id is set in GET parameters
if (isset($_GET['employee_id']) && is_numeric($_GET['employee_id'])) {
    $employee_id = $_GET['employee_id'];
} else {
    // Redirect or handle error if employee_id is not provided
    header("Location: dashboard.php");
    exit();
}

// Process search form submission
if (isset($_POST['search_date'])) {
    $search_date = $_POST['search_date'];
    // Validate date format if needed
    // For simplicity, assuming date is in YYYY-MM-DD format
}

// Get today's date in the correct format for MySQL comparison (assuming your database stores dates in YYYY-MM-DD format)
$current_date = date('Y-m-d');

// If search date is provided, use it instead of today's date
if (!empty($search_date)) {
    $current_date = $search_date;
}

// Query to fetch attendance records for the employee for the selected date
$sql = "SELECT entry_time, entry_type, description FROM employee_attendance_gate WHERE employee_id = ? AND DATE(entry_time) = ?";
$stmt = $conn->prepare($sql);

if ($stmt === false) {
    // Handle prepare error
    die('MySQL prepare error: ' . $conn->error);
}

$stmt->bind_param("is", $employee_id, $current_date);
$stmt->execute();
$result = $stmt->get_result();

// Fetch and store attendance records
while ($row = $result->fetch_assoc()) {
    $attendance_data[] = $row;
}

// Close statement and result set
$stmt->close();
$result->close();

?>

<!DOCTYPE html>
<html lang="en" class="light-style layout-menu-fixed" dir="ltr" data-theme="theme-default" data-assets-path="../assets/" data-template="vertical-menu-template-free">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />
    <title>Attendance Monitoring System</title>
    <meta name="description" content="" />

    <!-- Favicon -->
    <link rel="icon" type="image/x-icon" href="../../assets/img/avatars/logo.png"/>

    <!-- SweetAlert CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">

    <!-- SweetAlert JS -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <!-- FullCalendar JS -->
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.0/main.min.js"></script>

    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap" rel="stylesheet" />

    <!-- Link Poppins font -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <!-- Icons. Uncomment required icon fonts -->
    <link rel="stylesheet" href="../../assets/vendor/fonts/boxicons.css" />

    <!-- Core CSS -->
    <link rel="stylesheet" href="../../assets/vendor/css/core.css" class="template-customizer-core-css" />
    <link rel="stylesheet" href="../../assets/vendor/css/theme-default.css" class="template-customizer-theme-css" />
    <link rel="stylesheet" href="../../assets/css/demo.css" />

    <!-- Vendors CSS -->
    <link rel="stylesheet" href="../../assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />
    <link rel="stylesheet" href="../../assets/vendor/libs/apex-charts/apex-charts.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <!-- Helpers -->
    <script src="../../assets/vendor/js/helpers.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
    <!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
    <script src="../../assets/js/config.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

    <style>
        body, .btn, .navbar-nav .nav-link, .dropdown-item, .card-title, h4, th, td, .form-control {
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

        .table-responsive {
            margin-top: 50px;
            margin-left: 50px;
        }

        .table {
            margin-bottom: 0;
        }

        .in {
            color: green;
            font-weight: bold;
        }

        .out {
            color: red;
            font-weight: bold;
        }

        tr.in {
            background-color: #dff0d8;  
        }
        tr.out {
            background-color: #f8d7da; 
        }

        .entry-type-in {
            color: green;  
        }
        .entry-type-out {
            color: red; 
        }

        .custom-outline-button {
            border: 2px solid #007bff;  
            background-color: transparent; 
            color: #007bff;  
            padding: 10px 20px;  
            font-size: 16px;  
            border-radius: 5px; 
            cursor: pointer;  
            transition: all 0.3s ease;  
        }

        .custom-outline-button:hover {
            background-color: #007bff;  
            color: white;  
        }

        .custom-outline-button:focus {
            outline: none; 
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);  
        }
    </style>
</head>
<body>
    <!-- Layout wrapper -->
    <div class="layout-wrapper layout-content-navbar">
        <div class="layout-container">
            <!-- Menu -->
            <?php include('../navbar/admin/sidenavbar.php'); ?>
            <!-- / Menu -->

            <!-- Layout container -->
            <div class="layout-page">
                <!-- Navbar -->
                <?php include('../navbar/admin/navbar.php'); ?>
                <!-- / Navbar -->

                <!-- Content wrapper -->
                <div class="content-wrapper">
                    <!-- Content -->
                    <div class="container-xxl flex-grow-1 container-p-y">
                        <!-- Search -->
                        <div class="row mb-3">
                            <div class="col-lg-12">
                                <form class="d-flex" method="post">
                                    <input class="form-control me-2" type="date" id="search_date" name="search_date" aria-label="Search" name="search" value="<?php echo $search_date; ?>" required>
                                    <button type="submit" class="custom-outline-button">Search</button>
                                </form>
                            </div>
                        </div>
                        <!-- / Search -->
                        <div class="row">
                            <div class="col-lg-12 mb-4 order-0">
                                <div class="card">
                                    <div class="d-flex align-items-end row">
                                        <div class="col-lg-10">
                                            <div class="container-xxl flex-grow-1 container-p-y">
                                                <div class="row">
                                                    <div class="col-lg-12 mb-4 order-0">
                                                        <div>
                                                            <h4>Attendance for <?php echo !empty($search_date) ? $search_date : 'today'; ?></h4>
                                                            <div class="table-responsive mt-2">
                                                                <table class="table table-bordered table-hover">
                                                                    <thead>
                                                                        <tr>
                                                                            <th>#</th>
                                                                            <th>Entry Time</th>
                                                                            <th>Entry Type</th>
                                                                            <th>Description</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                        <?php foreach ($attendance_data as $index => $attendance) : ?>
                                                                        <tr class="<?php echo strtolower($attendance['entry_type']); ?>">
                                                                            <td><?php echo $index + 1; ?></td>
                                                                            <td><?php echo htmlspecialchars($attendance['entry_time']); ?></td>
                                                                            <td class="entry-type-<?php echo strtolower($attendance['entry_type']); ?>"><?php echo htmlspecialchars($attendance['entry_type']); ?>
                                                                            </td>
                                                                            <td><?php echo htmlspecialchars($attendance['description']); ?></td>
                                                                        </tr>
                                                                        <?php endforeach; ?>
                                                                    </tbody>
                                                                </table>  
                                                            </div>
                                                            <div class="centered-button">
                                                                <a href="attendance_gate.php" class="btn btn-primary">
                                                                    <i class="bx bx-chevron-left"></i> Back
                                                                </a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- / Content -->
                </div>
                <!-- / Content wrapper -->

                <!-- Footer -->
                <footer class="content-footer footer bg-footer-theme">
                    <div class="container-xxl d-flex flex-wrap justify-content-between py-2 flex-md-row flex-column">
                        <div class="mb-2 mb-md-0">
                            ©
                            <script>
                                document.write(new Date().getFullYear());
                            </script>, made with ❤️ by
                            <a href="https://www.facebook.com/james.jeager.3" target="_blank" class="footer-link fw-bolder">MeProfile</a>
                        </div>
                    </div>
                </footer>
                <!-- / Footer -->
            </div>
            <!-- / Layout page -->
        </div>
    </div>
    <!-- / Layout wrapper -->

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
</body>
</html>