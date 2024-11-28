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
    // Define variables and initialize with empty values
    $first_name = $last_name = $email = $password = $phone_number = $department = $position = $address = $city = $postal_code = $country = $date_of_birth = $gender = $emergency_contact_name = $emergency_contact_number = '';
    $is_admin = isset($_POST['is_admin']) ? 1 : 0; // Check if admin checkbox is checked

    // Validate input (you may add more specific validations as needed)
    $first_name = trim($_POST['first_name']);
    $last_name = trim($_POST['last_name']);
    $email = trim($_POST['email']);
    $password = password_hash($_POST['password'], PASSWORD_DEFAULT); // Hash password for security
    $phone_number = trim($_POST['phone_number']);
    $department = trim($_POST['department']);
    $position = trim($_POST['position']);
    $address = trim($_POST['address']);
    $city = trim($_POST['city']);
    $postal_code = trim($_POST['postal_code']);
    $country = trim($_POST['country']);
    $date_of_birth = $_POST['date_of_birth'];
    $gender = $_POST['gender'];
    $emergency_contact_name = trim($_POST['emergency_contact_name']);
    $emergency_contact_number = trim($_POST['emergency_contact_number']);

    // SQL statement to insert data
    $sql = "INSERT INTO employee_registration (first_name, last_name, email, password, phone_number, department, position, is_admin, address, city, postal_code, country, date_of_birth, gender, emergency_contact_name, emergency_contact_number)
            VALUES ('$first_name', '$last_name', '$email', '$password', '$phone_number', '$department', '$position', '$is_admin', '$address', '$city', '$postal_code', '$country', '$date_of_birth', '$gender', '$emergency_contact_name', '$emergency_contact_number')";

    if ($conn->query($sql) === TRUE) {
        echo "<script>alert('Employee registered successfully.');</script>";
        // Redirect or show success message
        header("Location: employee.php"); // Redirect to employee list page after successful registration
        exit();
    } else {
        echo "Error: " . $sql . "<br>" . $conn->error;
    }

    // Close connection
    $conn->close();
}
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
                                                        <!-- Employment Details -->
                                                        <h3>Employment Details</h3>
                                                        <div class="row">
                                                            <div class="mb-3 col-md-6">
                                                                <label for="department" class="form-label">Select Department:</label>
                                                                <select id="department" name="department" class="form-control">
                                                                    <option value="BSIT">BS in Information Technology (BSIT)</option>
                                                                    <option value="BSFi">BS in Fisheries (BSFi)</option>
                                                                    <option value="BSA">BS in Agriculture (BSA)</option>
                                                                    <option value="BSA">BS in Marine Biology (BSMB)</option>
                                                                </select>
                                                            </div>
                                                            <div class="mb-3 col-md-6">
                                                                <label for="position" class="form-label">Position:</label>
                                                                <input type="text" id="position" name="position" class="form-control">
                                                            </div>
                                                            <div class="mb-3 col-md-6">
                                                                <label for="hire_date" class="form-label">Hire Date:</label>
                                                                <input type="date" id="hire_date" name="hire_date" class="form-control" required>
                                                            </div>
                                                            <div class="mb-3 col-md-6">
                                                                <label for="is_admin" class="form-label">Is Admin:</label>
                                                                <input type="checkbox" id="is_admin" name="is_admin" value="1" class="form-check-input form-control">
                                                            </div>
                                                        </div>
                                                        <!-- Emergency Contact -->
                                                        <h3>Emergency Contact</h3>
                                                        <div class="row">
                                                            <div class="mb-3 col-md-6">
                                                                <label for="emergency_contact_name" class="form-label">Contact Name:</label>
                                                                <input type="text" id="emergency_contact_name" name="emergency_contact_name" class="form-control">
                                                            </div>
                                                            <div class="mb-3 col-md-6">
                                                                <label for="emergency_contact_number" class="form-label">Contact Number:</label>
                                                                <input type="text" id="emergency_contact_number" name="emergency_contact_number" class="form-control">
                                                            </div>
                                                        </div>
                                                        <!-- Submit -->
                                                        <input type="submit" value="Register" class="btn btn-primary">
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