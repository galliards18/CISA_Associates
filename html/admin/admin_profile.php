<?php
session_start();

// Check if user is not logged in or is not an admin
if (!isset($_SESSION['user_role']) || $_SESSION['user_role'] !== 'admin') {
    header("Location: ../choose.php"); // Redirect to login page if not logged in as admin
    exit();
}

// Include the database connection script
require '../config.php';

$employee_id = $_SESSION['employee_id'];

// SQL query to select employee details by employee_id
$sql = "SELECT * FROM employee_registration WHERE employee_id = ?";

// Use prepared statement to prevent SQL injection
$stmt = $conn->prepare($sql);
if ($stmt) {
    $stmt->bind_param("i", $employee_id);

    // Execute query
    $stmt->execute();

    // Get result
    $result = $stmt->get_result();

    // Check if employee exists
    if ($result->num_rows > 0) {
        // Fetch employee details as an associative array
        $row = $result->fetch_assoc();
    } else {
        echo "Employee not found";
    }

    // Close prepared statement
    $stmt->close();
} else {
    echo "Database query failed"; // Handle potential SQL statement preparation error
}

// Close database connection
$conn->close();
?>

<!DOCTYPE html>
<!-- beautify ignore:start -->
<html lang="en" class="light-style layout-menu-fixed" dir="ltr" data-theme="theme-default" data-assets-path="../assets/" data-template="vertical-menu-template-free">
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
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet" />


    <!-- Icons. Uncomment required icon fonts -->
    <link rel="stylesheet" href="../../assets/vendor/fonts/boxicons.css" />

    <!-- Core CSS -->
    <link rel="stylesheet" href="../../assets/vendor/css/core.css" class="template-customizer-core-css" />
    <link rel="stylesheet" href="../../assets/vendor/css/theme-default.css" class="template-customizer-theme-css" />
    <link rel="stylesheet" href="../../assets/css/demo.css" />

    <!-- Vendors CSS -->
    <link rel="stylesheet" href="../../assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />

    <!-- Page CSS -->

    <!-- Helpers -->
    <script src="../../assets/vendor/js/helpers.js"></script>

    <!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
    <!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
    <script src="../../assets/js/config.js"></script>
    <style>
      .card-header-design {
        color: #fff;
        margin-left: 400px;
      }
      /* Use Poppins as the default font */
      body {
        font-family: 'Poppins', sans-serif;
      }
      .card-header-design {
        color: #fff;
        margin-left: 400px;
      }
      .app-brand p {
        font-family: 'Poppins', sans-serif; /* Ensure the custom text uses Poppins */
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
          <div class="menu-inner-shadow"></div>
          <ul class="menu-inner py-1">
            <!-- Dashboard -->
            <li class="menu-item">
              <a href="dashboard.php" class="menu-link">
                <i class="menu-icon tf-icons bx bx-chalkboard"></i>
                <div data-i18n="Analytics">Dashboard</div>
              </a>
            </li>
            <li class="menu-item active">
              <a href="javascript:void(0);" class="menu-link menu-toggle">
                <i class="menu-icon tf-icons bx bx-user-circle"></i>
                <div data-i18n="Layouts">User</div>
              </a>
              <ul class="menu-sub active">
                <li class="menu-item active">
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
                      <img src="../../assets/img/avatars/user.png" alt="" class="w-px-40 h-auto rounded-circle" />
                    </div>
                  </a>
                  <ul class="dropdown-menu dropdown-menu-end">
                    <li>
                      <a class="dropdown-item" href="admin_profile.php">
                        <div class="d-flex">
                          <div class="flex-shrink-0 me-3">
                            <div class="avatar avatar-online">
                              <img src="../../assets/img/avatars/user.png" alt="" class="w-px-40 h-auto rounded-circle" />
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
                <div class="col-md-12">
                  <div class="card mb-4">
                    <h5 class="card-header">Profile Details</h5>
                    <!-- Account -->
                    <div class="card-body">
                      <hr class="my-0" />
                      <!-- Form -->
                      <div class="card mb-4">
                        <h5 class="card-header">Profile Details:</h5>
                        <!-- Display employee details -->
                        <div class="card-body">
                          <form action="#" id="formAccountSettings" method="POST">
                            <div class="row">
                              <div class="mb-3 col-md-6">
                                <label for="firstName" class="form-label">First Name</label>
                                <p class="form-control" id="firstName"><?php echo isset($row['first_name']) ? htmlspecialchars($row['first_name']) : ''; ?></p>
                              </div>
                              <div class="mb-3 col-md-6">
                                <label for="lastName" class="form-label">Last Name</label>
                                <p class="form-control" id="lastName"><?php echo isset($row['last_name']) ? htmlspecialchars($row['last_name']) : ''; ?></p>
                              </div>
                              <div class="mb-3 col-md-6">
                                <label for="email" class="form-label">Email</label>
                                <p class="form-control" id="email"><?php echo isset($row['email']) ? htmlspecialchars($row['email']) : ''; ?></p>
                              </div>
                              <div class="mb-3 col-md-6">
                                <label for="phoneNumber" class="form-label">Phone Number</label>
                                <p class="form-control" id="phoneNumber"><?php echo isset($row['phone_number']) ? htmlspecialchars($row['phone_number']) : ''; ?></p>
                              </div>
                              <div class="mb-3 col-md-6">
                                <label for="department" class="form-label">Department</label>
                                <p class="form-control" id="department"><?php echo isset($row['department']) ? htmlspecialchars($row['department']) : ''; ?></p>
                              </div>
                              <div class="mb-3 col-md-6">
                                <label for="position" class="form-label">Position</label>
                                <p class="form-control" id="position"><?php echo isset($row['position']) ? htmlspecialchars($row['position']) : ''; ?></p>
                              </div>
                              <div class="mb-3 col-md-6">
                                <label for="address" class="form-label">Address</label>
                                <p class="form-control" id="address"><?php echo isset($row['address']) ? htmlspecialchars($row['address']) : ''; ?></p>
                              </div>
                              <div class="mb-3 col-md-6">
                                <label for="city" class="form-label">City</label>
                                <p class="form-control" id="city"><?php echo isset($row['city']) ? htmlspecialchars($row['city']) : ''; ?></p>
                              </div>
                              <div class="mb-3 col-md-6">
                                <label for="postalCode" class="form-label">Postal Code</label>
                                <p class="form-control" id="postalCode"><?php echo isset($row['postal_code']) ? htmlspecialchars($row['postal_code']) : ''; ?></p>
                              </div>
                              <div class="mb-3 col-md-6">
                                <label for="country" class="form-label">Country</label>
                                <p class="form-control" id="country"><?php echo isset($row['country']) ? htmlspecialchars($row['country']) : ''; ?></p>
                              </div>
                              <div class="mb-3 col-md-6">
                                <label for="dateOfBirth" class="form-label">Date of Birth</label>
                                <p class="form-control" id="dateOfBirth"><?php echo isset($row['date_of_birth']) ? htmlspecialchars($row['date_of_birth']) : ''; ?></p>
                              </div>
                              <div class="mb-3 col-md-6">
                                <label for="gender" class="form-label">Gender</label>
                                <p class="form-control" id="gender"><?php echo isset($row['gender']) ? htmlspecialchars($row['gender']) : ''; ?></p>
                              </div>
                              <h5 class="card-header">Incase of Emergency Please Contact:</h5>
                              <div class="mb-3 col-md-6">
                                <label for="emergencyContactName" class="form-label">Emergency Contact Name</label>
                                <p class="form-control" id="emergencyContactName"><?php echo isset($row['emergency_contact_name']) ? htmlspecialchars($row['emergency_contact_name']) : ''; ?></p>
                              </div>
                              <div class="mb-3 col-md-6">
                                <label for="emergencyContactNumber" class="form-label">Emergency Contact Number</label>
                                <p class="form-control" id="emergencyContactNumber"><?php echo isset($row['emergency_contact_number']) ? htmlspecialchars($row['emergency_contact_number']) : ''; ?></p>
                              </div>
                            </div>
                          </form>
                        </div>
                        <!-- /Display employee details -->
                      </div>
                      <!-- /Account -->
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
                  ©
                  <script>
                    document.write(new Date().getFullYear());
                  </script>, made with ❤️ by
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

    <!-- Main JS -->
    <script src="../../assets/js/main.js"></script>

    <!-- Page JS -->
    <script src="../../assets/js/pages-account-settings-account.js"></script>

    <!-- Place this tag in your head or just before your close body tag. -->
    <script async defer src="https://buttons.github.io/buttons.js"></script>
  </body>
</html>
