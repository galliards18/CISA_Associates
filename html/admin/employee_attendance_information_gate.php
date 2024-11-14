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


    <!-- Icons -->
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

    <!-- Theme Config & Customizer -->
    <script src="../../assets/js/config.js"></script>

    <style>
      /* Updated styles to use Poppins */
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
      /* Table Row Colors */
      tr.in {
          background-color: #dff0d8; /* Light green background for 'In' */
      }
      tr.out {
          background-color: #f8d7da; /* Light red background for 'Out' */
      }

      /* Entry Type Text Color */
      .entry-type-in {
          color: green; /* Green text color for 'In' */
      }
      .entry-type-out {
          color: red; /* Red text color for 'Out' */
      }

      .custom-outline-button {
          border: 2px solid #007bff; /* Outline color and thickness */
          background-color: transparent; /* Transparent background */
          color: #007bff; /* Text color matching the outline */
          padding: 10px 20px; /* Padding inside the button */
          font-size: 16px; /* Font size */
          border-radius: 5px; /* Rounded corners */
          cursor: pointer; /* Pointer cursor on hover */
          transition: all 0.3s ease; /* Smooth transition for hover effects */
      }

      .custom-outline-button:hover {
          background-color: #007bff; /* Blue background on hover */
          color: white; /* White text on hover */
      }

      .custom-outline-button:focus {
          outline: none; /* Remove default focus outline */
          box-shadow: 0 0 5px rgba(0, 123, 255, 0.5); /* Custom focus effect */
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
              <img style="border-radius: 500px; box-shadow: 2px 2px 20px #00008b; margin-top: 30px; margin-bottom: 5px;" src="../../assets/img/avatars/logo.png" width="100" height="100" alt="" />
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
            <!-- Dashboard -->
            <li class="menu-item">
              <a href="dashboard.php" class="menu-link">
                <i class="menu-icon tf-icons bx bx-chalkboard"></i>
                <div data-i18n="Analytics">Dashboard</div>
              </a>
            </li>
            <!-- User -->
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
            <!-- Attendance -->
            <li class="menu-item active">
              <a href="javascript:void(0);" class="menu-link menu-toggle">
                <i class="menu-icon tf-icons bx bx-calendar-check"></i>
                <div data-i18n="Analytics">Attendance</div>
              </a>
              <ul class="menu-sub">
                <li class="menu-item active">
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
            <!-- Event -->
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
            <!-- Report -->
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
                      <img src="../../assets/img/avatars/user.png" alt class="w-px-40 h-auto rounded-circle" />
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

              <div class="row mb-3">
                <div class="col-lg-12">
                  <form class="d-flex" method="post">
                    <input class="form-control me-2" type="date" id="search_date" name="search_date" aria-label="Search" name="search" value="<?php echo $search_date; ?>" required>
                    <button type="submit" class="custom-outline-button">Search</button>
                  </form>
                </div>
              </div>

              <div class="row">
                <div class="col-lg-12 mb-4 order-0">
                  <div class="card">
                    <div class="d-flex align-items-end row">
                      <div class="col-lg-10">
                        <div class="container-xxl flex-grow-1 container-p-y">
                          <div class="row">
                            <div class="col-lg-12 mb-4 order-0">
                              <div class="">
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
                                          <td class="entry-type-<?php echo strtolower($attendance['entry_type']); ?>">
                                            <?php echo htmlspecialchars($attendance['entry_type']); ?>
                                          </td>
                                          <td><?php echo htmlspecialchars($attendance['description']); ?></td>
                                      </tr>
                                    <?php endforeach; ?>
                                    </tbody>
                                  </table>  
                                </div>
                                <!-- After the table in your existing code -->
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

            <!-- Footer -->
            <footer class="content-footer footer bg-footer-theme">
              <div class="container-xxl d-flex flex-wrap justify-content-between py-2 flex-md-row flex-column">
                <div class="mb-2 mb-md-0">
                  © <script>document.write(new Date().getFullYear());</script>, made with ❤️ by <a href="https://www.facebook.com/james.jeager.3" target="_blank" class="footer-link fw-bolder">MeProfile</a>
                </div>
              </div>
            </footer>
            <!-- / Footer -->
          </div>
          <!-- / Content wrapper -->
        </div>
        <!-- / Layout container -->
      </div>
      <!-- / Layout container -->
    </div>
    <!-- / Layout wrapper -->

    <!-- Core JS -->
    <script src="../../assets/vendor/libs/jquery/jquery.js"></script>
    <script src="../../assets/vendor/libs/popper/popper.js"></script>
    <script src="../../assets/vendor/js/bootstrap.js"></script>
    <script src="../../assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>
    <script src="../../assets/vendor/js/menu.js"></script>
    
    <!-- Vendors JS -->
    <script src="../../assets/vendor/libs/apex-charts/apexcharts.js"></script>

    <!-- Main JS -->
    <script src="../../assets/js/main.js"></script>

    <!-- Page JS -->
    <script src="../../assets/js/dashboards-analytics.js"></script>

    <!-- GitHub buttons script -->
    <script async defer src="https://buttons.github.io/buttons.js"></script>
  </body>
</html>
