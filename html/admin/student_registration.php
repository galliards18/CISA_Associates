<?php
session_start();

// Check if user is not logged in or is not an admin
if (!isset($_SESSION['user_role']) || $_SESSION['user_role'] !== 'admin') {
    header("Location: ../choose.php"); // Redirect to login page if not logged in as admin
    exit();
}

// Include the database connection script
require '../config.php';

// Processing form data when form is submitted
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Initialize variables with empty values
    $first_name = $last_name = $email = $password = $phone_number = $department = $year_level = $section = $address = $city = $postal_code = $country = $date_of_birth = $gender = $emergency_contact_name = $emergency_contact_number = '';

    // Validate and sanitize input
    $first_name = isset($_POST['first_name']) ? trim($_POST['first_name']) : '';
    $last_name = isset($_POST['last_name']) ? trim($_POST['last_name']) : '';
    $email = isset($_POST['email']) ? trim($_POST['email']) : '';
    $password = isset($_POST['password']) ? password_hash(trim($_POST['password']), PASSWORD_DEFAULT) : ''; // Hash password for security
    $phone_number = isset($_POST['phone_number']) ? trim($_POST['phone_number']) : '';
    $department = isset($_POST['department']) ? trim($_POST['department']) : '';
    $year_level = isset($_POST['year_level']) ? trim($_POST['year_level']) : '';
    $section = isset($_POST['section']) ? trim($_POST['section']) : '';
    $address = isset($_POST['address']) ? trim($_POST['address']) : '';
    $city = isset($_POST['city']) ? trim($_POST['city']) : '';
    $postal_code = isset($_POST['postal_code']) ? trim($_POST['postal_code']) : '';
    $country = isset($_POST['country']) ? trim($_POST['country']) : '';
    $date_of_birth = isset($_POST['date_of_birth']) ? $_POST['date_of_birth'] : null;
    $gender = isset($_POST['gender']) ? $_POST['gender'] : '';
    $emergency_contact_name = isset($_POST['emergency_contact_name']) ? trim($_POST['emergency_contact_name']) : '';
    $emergency_contact_number = isset($_POST['emergency_contact_number']) ? trim($_POST['emergency_contact_number']) : '';

    // Prepared statement for secure SQL execution
    $stmt = $conn->prepare("INSERT INTO student_registration (first_name, last_name, email, password, phone_number, department, year_level, section, enrollment_date, address, city, postal_code, country, date_of_birth, gender, emergency_contact_name, emergency_contact_number)
                            VALUES (?, ?, ?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP, ?, ?, ?, ?, ?, ?, ?, ?)");

    if ($stmt) {
        // Bind parameters to prevent SQL injection
        $stmt->bind_param("ssssssssssssssss", $first_name, $last_name, $email, $password, $phone_number, $department, $year_level, $section, $address, $city, $postal_code, $country, $date_of_birth, $gender, $emergency_contact_name, $emergency_contact_number);

        // Execute statement and check for success
        if ($stmt->execute()) {
            echo "<script>alert('Student registered successfully.');</script>";
            header("Location: student.php"); // Redirect after successful registration
            exit();
        } else {
            echo "Error: " . $stmt->error;
        }
        $stmt->close();
    } else {
        echo "Error preparing statement: " . $conn->error;
    }

    // Close connection
    $conn->close();
}
?>


<!DOCTYPE html>
<html
  lang="en"
  class="light-style layout-menu-fixed"
  dir="ltr"
  data-theme="theme-default"
  data-assets-path="../../assets/"
>
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
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap"/>
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

    <!-- Page CSS -->

    <!-- Helpers -->
    <script src="../../assets/vendor/js/helpers.js"></script>

    <!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
    <!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
    <script src="../../assets/js/config.js"></script>
    <style>
      body, .menu, .form-label, .form-control, .btn, .footer-link {
        font-family: 'Poppins', sans-serif;
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
              <b><p style="font-size: 20px; color: blue; text-shadow: 2px 2px 50px #00008b; padding-left: 18px;">S L S U</p></b>
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
                        <ul class="menu-sub">
                            <li class="menu-item">
                              <a href="student.php" class="menu-link">
                                <div data-i18n="Analytics">Student</div>
                              </a>
                            </li>
                            <li class="menu-item active">
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
<!--                     <li class="menu-item">
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
                <div class="col-lg-12 mb-12 order-12">
                  <div class="card">
                    <div class="d-flex align-items-end row">
                      <div class="col-lg-12">
                        <div class="card-body">
                          <div class="col-sm-12">
                            <form action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>" method="post">
                              <!-- Personal Details -->
                              <h3>Personal Details</h3>
                              <div class="row">
                                <div class="mb-3 col-md-6">
                                  <label for="first_name" class="form-label">First Name:</label>
                                  <input type="text" id="first_name" name="first_name" class="form-control" required>
                                </div>
                                <div class="mb-3 col-md-6">
                                  <label for="last_name" class="form-label">Last Name:</label>
                                  <input type="text" id="last_name" name="last_name" class="form-control" required>
                                </div>
                                <div class="mb-3 col-md-6">
                                  <label for="email" class="form-label">Email:</label>
                                  <input type="email" id="email" name="email" class="form-control" required>
                                </div>
                                <div class="mb-3 col-md-6">
                                  <label for="password" class="form-label">Password:</label>
                                  <input type="password" id="password" name="password" class="form-control" required>
                                </div>
                                <div class="mb-3 col-md-6">
                                  <label for="date_of_birth" class="form-label">Date of Birth:</label>
                                  <input type="date" id="date_of_birth" name="date_of_birth" class="form-control">
                                </div>
                                <div class="mb-3 col-md-6">
                                  <label for="gender" class="form-label">Gender:</label>
                                  <select id="gender" name="gender" class="form-control">
                                    <option value="">Select</option>
                                    <option value="Male">Male</option>
                                    <option value="Female">Female</option>
                                  </select>
                                </div>
                              </div>

                              <!-- Contact Information -->
                              <h3>Contact Information</h3>
                              <div class="row">
                                <div class="mb-3 col-md-6">
                                  <label for="phone_number" class="form-label">Phone Number:</label>
                                  <input type="text" id="phone_number" name="phone_number" class="form-control">
                                </div>
                                <div class="mb-3 col-md-6">
                                  <label for="department" class="form-label">Department:</label>
                                  <select id="department" name="department" class="form-control">
                                    <option value="">Select Department</option>
                                    <option value="BSIT">BS in Information Technology (BSIT)</option>
                                    <option value="BSFI">BS in Financial Engineering (BSFI)</option>
                                    <option value="BSA">BS in Accountancy (BSA)</option>
                                  </select>
                                </div>
                                <div class="mb-3 col-md-6">
                                  <label for="year_level" class="form-label">Year Level:</label>
                                  <input type="number" id="year_level" name="year_level" class="form-control" min="1" max="5">
                                </div>
                                <div class="mb-3 col-md-6">
                                  <label for="section" class="form-label">Section:</label>
                                  <select id="section" name="section" class="form-control">
                                    <option value="">Select Section</option>
                                    <option value="A">A</option>
                                    <option value="B">B</option>
                                    <option value="C">C</option>
                                  </select>
                                </div>
                                <div class="mb-3 col-md-6">
                                  <label for="address" class="form-label">Address:</label>
                                  <input type="text" id="address" name="address" class="form-control">
                                </div>
                                <div class="mb-3 col-md-6">
                                  <label for="city" class="form-label">City:</label>
                                  <input type="text" id="city" name="city" class="form-control">
                                </div>
                                <div class="mb-3 col-md-6">
                                  <label for="postal_code" class="form-label">Postal Code:</label>
                                  <input type="text" id="postal_code" name="postal_code" class="form-control">
                                </div>
                                <div class="mb-3 col-md-6">
                                  <label for="country" class="form-label">Country:</label>
                                  <input type="text" id="country" name="country" class="form-control">
                                </div>
                              </div>

                              <!-- Emergency Contact -->
                              <h3>Emergency Contact</h3>
                              <div class="row">
                                <div class="mb-3 col-md-6">
                                  <label for="emergency_contact_name" class="form-label">Guardian's Name:</label>
                                  <input type="text" id="emergency_contact_name" name="emergency_contact_name" class="form-control">
                                </div>
                                <div class="mb-3 col-md-6">
                                  <label for="emergency_contact_number" class="form-label">Guardian's Contact Number:</label>
                                  <input type="text" id="emergency_contact_number" name="emergency_contact_number" class="form-control">
                                </div>
                              </div>

                              <!-- Submit Button -->
                              <button type="submit" class="btn btn-primary">Register Student</button>
                            </form>

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
  </body>
</html>


