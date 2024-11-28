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
$employee_id = $firstname = $lastname = $email = $password = $phone_number = $department = $position = '';
$is_admin = $hire_date = $address = $city = $postal_code = $country = $date_of_birth = $gender = '';
$emergency_contact_name = $emergency_contact_number = '';

$id = $_GET['employee_id']; // Get employee ID from URL

// Retrieve employee details from database using prepared statement
$sql = "SELECT * FROM employee_registration WHERE employee_id = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $id);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows > 0) {
    $row = $result->fetch_assoc();
    $employee_id = $row['employee_id'];
    $firstname = $row['first_name'];
    $lastname = $row['last_name'];
    $email = $row['email'];
    $phone_number = $row['phone_number'];
    $department = $row['department'];
    $position = $row['position'];
    $is_admin = $row['is_admin'];
    $address = $row['address'];
    $hire_date = $row['hire_date'];
    $city = $row['city'];
    $postal_code = $row['postal_code'];
    $country = $row['country'];
    $date_of_birth = $row['date_of_birth'];
    $gender = $row['gender'];
    $emergency_contact_name = $row['emergency_contact_name'];
    $emergency_contact_number = $row['emergency_contact_number'];
} else {
    echo "Employee not found";
    exit(); // Stop further execution
}

$stmt->close();
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
        body {
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
                            <div class="col-md-12">
                                <div class="container">
                                    <h2 class="my-4">Edit Employee</h2>
                                    <form action="update_employee.php" method="POST">
                                        <input type="hidden" name="employee_id" value="<?php echo $employee_id; ?>">
                                        <div class="form-group row mb-3">
                                            <label for="firstname" class="col-sm-2 col-form-label">First Name</label>
                                            <div class="col-sm-10">
                                                <input type="text" class="form-control" id="firstname" name="firstname" value="<?php echo htmlspecialchars($firstname); ?>" required>
                                            </div>
                                        </div>
                                        <div class="form-group row mb-3">
                                            <label for="lastname" class="col-sm-2 col-form-label">Last Name</label>
                                            <div class="col-sm-10">
                                                <input type="text" class="form-control" id="lastname" name="lastname" value="<?php echo htmlspecialchars($lastname); ?>" required>
                                            </div>
                                        </div>
                                        <div class="form-group row mb-3">
                                            <label for="email" class="col-sm-2 col-form-label">Email</label>
                                            <div class="col-sm-10">
                                                <input type="email" class="form-control" id="email" name="email" value="<?php echo htmlspecialchars($email); ?>" required>
                                            </div>
                                        </div>
                                        <div class="form-group row mb-3">
                                            <label for="phone_number" class="col-sm-2 col-form-label">Phone Number</label>
                                            <div class="col-sm-10">
                                                <input type="text" class="form-control" id="phone_number" name="phone_number" value="<?php echo htmlspecialchars($phone_number); ?>">
                                            </div>
                                        </div>
                                        <div class="form-group row mb-3">
                                            <label for="department" class="col-sm-2 col-form-label">Select Department</label>
                                            <div class="col-sm-10">
                                                <select id="department" name="department" class="form-control">
                                                    <option value="BSIT" <?php if ($department === 'BSIT') echo 'selected'; ?>>BS in Information Technology (BSIT)</option>
                                                    <option value="BSFi" <?php if ($department === 'BSFi') echo 'selected'; ?>>BS in Fisheries (BSFi)</option>
                                                    <option value="BSA" <?php if ($department === 'BSA') echo 'selected'; ?>>BS in Agriculture (BSA)</option>
                                                    <option value="BSA" <?php if ($department === 'BSA') echo 'selected'; ?>>BS in Marine Biology (BSMB)</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="form-group row mb-3">
                                            <label for="position" class="col-sm-2 col-form-label">Position</label>
                                            <div class="col-sm-10">
                                                <input type="text" class="form-control" id="position" name="position" value="<?php echo htmlspecialchars($position); ?>">
                                            </div>
                                        </div>
                                        <div class="form-group row mb-3">
                                            <label for="is_admin" class="col-sm-2 col-form-label">Is Admin?</label>
                                            <div class="col-sm-10">
                                                <div class="form-check">
                                                    <input class="form-check-input" type="checkbox" id="is_admin" name="is_admin" value="1" <?php if ($is_admin == 1) echo 'checked'; ?>>
                                                    <label class="form-check-label" for="is_admin">Yes, this user is an admin</label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group row mb-3">
                                            <label for="address" class="col-sm-2 col-form-label">Address</label>
                                            <div class="col-sm-10">
                                                <input type="text" class="form-control" id="address" name="address" value="<?php echo htmlspecialchars($address); ?>">
                                            </div>
                                        </div>
                                        <div class="form-group row mb-3">
                                            <label for="hire_date" class="col-sm-2 col-form-label">Hire Date</label>
                                            <div class="col-sm-10">
                                                <input type="date" class="form-control" id="hire_date" name="hire_date" value="<?php echo htmlspecialchars($hire_date); ?>" required>
                                            </div>
                                        </div>
                                        <div class="form-group row mb-3">
                                            <label for="city" class="col-sm-2 col-form-label">City</label>
                                            <div class="col-sm-10">
                                                <input type="text" class="form-control" id="city" name="city" value="<?php echo htmlspecialchars($city); ?>">
                                            </div>
                                        </div>
                                        <div class="form-group row mb-3">
                                            <label for="postal_code" class="col-sm-2 col-form-label">Postal Code</label>
                                            <div class="col-sm-10">
                                                <input type="text" class="form-control" id="postal_code" name="postal_code" value="<?php echo htmlspecialchars($postal_code); ?>">
                                            </div>
                                        </div>
                                        <div class="form-group row mb-3">
                                            <label for="country" class="col-sm-2 col-form-label">Country</label>
                                            <div class="col-sm-10">
                                                <input type="text" class="form-control" id="country" name="country" value="<?php echo htmlspecialchars($country); ?>">
                                            </div>
                                        </div>
                                        <div class="form-group row mb-3">
                                            <label for="date_of_birth" class="col-sm-2 col-form-label">Date of Birth</label>
                                            <div class="col-sm-10">
                                                <input type="date" class="form-control" id="date_of_birth" name="date_of_birth" value="<?php echo htmlspecialchars($date_of_birth); ?>">
                                            </div>
                                        </div>
                                        <div class="form-group row mb-3">
                                            <label for="gender" class="col-sm-2 col-form-label">Gender</label>
                                            <div class="col-sm-10">
                                                <select class="form-control" id="gender" name="gender">
                                                    <option value="Male" <?php if ($gender === 'Male') echo 'selected'; ?>>Male</option>
                                                    <option value="Female" <?php if ($gender === 'Female') echo 'selected'; ?>>Female</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="form-group row mb-3">
                                            <label for="emergency_contact_name" class="col-sm-2 col-form-label">Emergency Contact Name</label>
                                            <div class="col-sm-10">
                                                <input type="text" class="form-control" id="emergency_contact_name" name="emergency_contact_name" value="<?php echo htmlspecialchars($emergency_contact_name); ?>">
                                            </div>
                                        </div>
                                        <div class="form-group row mb-5">
                                            <label for="emergency_contact_number" class="col-sm-2 col-form-label">Emergency Contact Number</label>
                                            <div class="col-sm-10">
                                                <input type="text" class="form-control" id="emergency_contact_number" name="emergency_contact_number" value="<?php echo htmlspecialchars($emergency_contact_number); ?>">
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <div class="col-sm-10 offset-sm-2">
                                                <button type="submit" class="btn btn-primary">Update</button>
                                                <a href="employee.php?id=<?php echo $id; ?>" class="btn btn-secondary">Cancel</a>
                                            </div>
                                        </div>
                                    </form>
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