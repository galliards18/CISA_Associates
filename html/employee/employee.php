<?php
session_start();

// Check if user is not logged in or is not an employee
if (!isset($_SESSION['user_role']) || $_SESSION['user_role'] !== 'employee') {
    header("Location: ../choose.php"); // Redirect to login page if not logged in as employee
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
        body, .navbar, .card, .btn, .form-control, .dropdown-menu, .avatar, .dropdown-item, .navbar-dropdown, .nav-link, .menu-item, .menu-link, .menu-sub, .status-icon {
            font-family: 'Poppins', sans-serif;
        }

        .card-header-design {
            color: #fff;
            margin-left: 400px;
        }
    </style>
</head>
<body>
    <!-- Layout wrapper -->
    <div class="layout-wrapper layout-content-navbar">
        <div class="layout-container">
            <!-- Menu -->
            <?php include('../navbar/employee/sidenavbar.php'); ?>
            <!-- / Menu -->

            <!-- Layout container -->
            <div class="layout-page">
                <!-- Navbar -->
                <?php include('../navbar/employee/navbar.php'); ?>
                <!-- / Navbar -->

                <!-- Content wrapper -->
                <div class="content-wrapper">
                    <!-- Content -->
                    <div class="container-xxl flex-grow-1 container-p-y">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="card mb-4">
                                    <h5 class="card-header">Profile Details</h5>
                                    <div class="card-body">
                                        <hr class="my-0" />
                                        <div class="card mb-4">
                                            <h5 class="card-header">Profile Details:</h5>
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