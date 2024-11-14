<?php
session_start();

// Set PHP timezone
date_default_timezone_set('Asia/Kolkata'); // Adjust as per your timezone

// Check if user is logged in and is an admin
if (!isset($_SESSION['user_role']) || $_SESSION['user_role'] !== 'admin') {
    header("Location: ../choose.php");
    exit();
}

// Include database connection
require '../config.php';

// Sanitize input function
function sanitize_input($data) {
    $data = trim($data);
    $data = stripslashes($data);
    $data = htmlspecialchars($data);
    return $data;
}

// Initialize variables
$date = '';
$department = '';
$whereClause = '';
$searchMessage = '';

// Handle form submission
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    if (isset($_POST['date'])) {
        $date = sanitize_input($_POST['date']);
    }
    
    if (isset($_POST['department'])) {
        $department = sanitize_input($_POST['department']);
    }

    // Build WHERE clause based on filters
    $conditions = [];
    if ($date) {
        $conditions[] = "DATE(f.attendance_date) = ?";
    }
    if ($department) {
        $conditions[] = "e.department = ?";
    }

    if (count($conditions) > 0) {
        $whereClause = "WHERE " . implode(" AND ", $conditions);
        $searchMessage = "Showing results";
        if ($date) {
            $searchMessage .= " for date: $date";
        }
        if ($department) {
            $searchMessage .= " and department: $department";
        }
    }
}

// SQL query with filters
$sql = "SELECT e.first_name, e.last_name, e.department, DATE(f.attendance_date) AS attendance_date, f.attendance_status, ft.flag_type
        FROM employee_registration e
        INNER JOIN employee_attendance_department f ON e.employee_id = f.employee_id
        INNER JOIN flag_type ft ON f.flag_id = ft.flag_id
        $whereClause
        ORDER BY f.attendance_date DESC";

$stmt = $conn->prepare($sql);

$types = '';
$params = [];
if ($date) {
    $types .= 's'; // Add type specifier for date
    $params[] = $date;
}
if ($department) {
    $types .= 's'; // Add type specifier for department
    $params[] = $department;
}

if ($types) {
    $stmt->bind_param($types, ...$params);
}

$stmt->execute();
$result = $stmt->get_result();
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
                <li class="menu-item">
                  <a href="attendance_gate.php" class="menu-link">
                    <div data-i18n="Analytics">Gate Marking</div>
                  </a>
                </li>
                <li class="menu-item active">
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
              <!-- Search Form -->
            <form method="POST" action="<?php echo $_SERVER['PHP_SELF']; ?>" class="d-flex mb-3">
                <input type="date" name="date" id="date" class="form-control me-2" aria-label="Search" value="<?php echo htmlspecialchars($date); ?>">
                <select name="department" id="department" class="form-control me-2">
                    <option value="">Select Department</option>
                    <?php
                    // Fetch departments from the database, excluding 'admin'
                    $departmentQuery = "SELECT DISTINCT department FROM employee_registration WHERE department != 'admin'";
                    $departmentResult = $conn->query($departmentQuery);
                    while ($dept = $departmentResult->fetch_assoc()) {
                        $selected = ($department === $dept['department']) ? 'selected' : '';
                        echo "<option value=\"" . htmlspecialchars($dept['department']) . "\" $selected>" . htmlspecialchars($dept['department']) . "</option>";
                    }
                    ?>
                </select>
                <button type="submit" class="custom-outline-button">Search</button>
            </form>
              <!-- Search Form -->
              <div class="row">
                <div class="col-lg-12 mb-4 order-0">
                  <div class="card">
                    <div class="d-flex align-items-end row">
                      <div class="col-lg-12">
                        <div class="container-xxl flex-grow-1 container-p-y">
                          <div class="row">
                            <div class="col-lg-12 mb-4 order-0">
                              <div class="card-header">
                                <h2 class="mb-3">Attendance Flag Ceremony History</h2>
                                <!-- Display message if date range is used for filtering -->
                                <?php if ($searchMessage): ?>
                                  <h4><?php echo $searchMessage; ?></h4>
                                <?php endif; ?>
                              </div>
                                <div class=" mt-2">
                                  <div class="table-responsive mt-2">
                                    <table class="table table-bordered">
                                      <thead>
                                          <tr>
                                              <th>#</th>
                                              <th>Employee Name</th>
                                              <th>Attendance Date</th>
                                              <th>Status</th>
                                              <th>Department</th>
                                              <th>Flag Ceremony Type</th>
                                          </tr>
                                      </thead>
                                      <tbody>
                                          <?php
                                          $index = 1;
                                          while ($row = $result->fetch_assoc()) {
                                              // Determine the row color based on attendance status
                                              $rowColor = '';
                                              switch (strtolower($row['attendance_status'])) {
                                                  case 'present':
                                                      $rowColor = 'bg-success text-white'; // Green for present
                                                      break;
                                                  case 'absent':
                                                      $rowColor = 'bg-danger text-white'; // Red for absent
                                                      break;
                                                  case 'late':
                                                      $rowColor = 'bg-warning text-dark'; // Orange for late
                                                      break;
                                                  case 'no record':
                                                      $rowColor = 'bg-primary text-white'; // Blue for no record
                                                      break;
                                                  default:
                                                      $rowColor = ''; // Default color if no match
                                                      break;
                                              }
                                              ?>
                                              <tr class="<?php echo $rowColor; ?>">
                                                  <td><?php echo $index++; ?></td>
                                                  <td><?php echo htmlspecialchars($row['first_name'] . ' ' . $row['last_name']); ?></td>
                                                  <td><?php echo htmlspecialchars($row['attendance_date']); ?></td>
                                                  <td><?php echo ucfirst(htmlspecialchars($row['attendance_status'])); ?></td>
                                                  <td><?php echo htmlspecialchars($row['department']); ?></td>
                                                  <td><?php echo ucfirst(htmlspecialchars($row['flag_type'])); ?></td>
                                              </tr>
                                              <?php
                                          }
                                          ?>
                                      </tbody>
                                  </table>
                                  </div>
                                  <!-- After the table in your existing code -->
                                  <div class="centered-button">
                                    <a href="employee_attendance_information_flag.php" class="btn btn-primary">
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
