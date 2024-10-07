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
    $hire_date = $row['hire_date'];
    $address = $row['address'];
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
<html lang="en" class="light-style layout-menu-fixed" dir="ltr" data-theme="theme-default" data-assets-path="../../assets/" data-template="vertical-menu-template-free">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />
    <title>Attendance Monitoring System</title>
    <meta name="description" content="" />
    <link rel="icon" type="image/x-icon" href="../../assets/img/avatars/logo.png"/>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="../../assets/vendor/fonts/boxicons.css" />
    <link rel="stylesheet" href="../../assets/vendor/css/core.css" class="template-customizer-core-css" />
    <link rel="stylesheet" href="../../assets/vendor/css/theme-default.css" class="template-customizer-theme-css" />
    <link rel="stylesheet" href="../../assets/css/demo.css" />
    <link rel="stylesheet" href="../../assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />
    <script src="../../assets/vendor/js/helpers.js"></script>
    <script src="../../assets/js/config.js"></script>
    <style>
        body {
    font-family: 'Poppins', sans-serif;
    }
    </style>
</head>
<body>
    <div class="layout-wrapper layout-content-navbar">
        <div class="layout-container">
            <aside id="layout-menu" class="layout-menu menu-vertical menu bg-menu-theme">
                <div class="app-brand demo" style="padding: 70px;">
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
                              <a href="admin_profile.php" class="menu-link">
                                <div data-i18n="Analytics">Profile</div>
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
            <div class="layout-page">
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
                            <li class="nav-item navbar-dropdown dropdown-user dropdown">
                                <a class="nav-link dropdown-toggle hide-arrow" href="javascript:void(0);" data-bs-toggle="dropdown">
                                    <div class="avatar avatar-online">
                                        <img src="../../assets/img/avatars/user.png" alt="User Avatar" class="w-px-40 h-auto rounded-circle" />
                                    </div>
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end">
                                    <li>
                                        <a class="dropdown-item" href="admin_profile.php">
                                            <div class="d-flex">
                                                <div class="flex-shrink-0 me-3">
                                                    <div class="avatar avatar-online">
                                                        <img src="../../assets/img/avatars/user.png" alt="User Avatar" class="w-px-40 h-auto rounded-circle" />
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
                        </ul>
                    </div>
                </nav>
                <div class="content-wrapper">
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
                                            <label for="department" class="col-sm-2 col-form-label">Department</label>
                                            <div class="col-sm-10">
                                                <input type="text" class="form-control" id="department" name="department" value="<?php echo htmlspecialchars($department); ?>">
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
                                            <label for="hire_date" class="col-sm-2 col-form-label">Hire Date</label>
                                            <div class="col-sm-10">
                                                <input type="date" class="form-control" id="hire_date" name="hire_date" value="<?php echo htmlspecialchars($hire_date); ?>" required>
                                            </div>
                                        </div>

                                        <div class="form-group row mb-3">
                                            <label for="address" class="col-sm-2 col-form-label">Address</label>
                                            <div class="col-sm-10">
                                                <input type="text" class="form-control" id="address" name="address" value="<?php echo htmlspecialchars($address); ?>">
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
                                                    <option value="Other" <?php if ($gender === 'Other') echo 'selected'; ?>>Other</option>
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
                <div class="content-backdrop fade"></div>
            </div>
        </div>
        <div class="layout-overlay layout-menu-toggle"></div>
    </div>
    <script src="../../assets/vendor/libs/jquery/jquery.js"></script>
    <script src="../../assets/vendor/libs/popper/popper.js"></script>
    <script src="../../assets/vendor/js/bootstrap.js"></script>
    <script src="../../assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>
    <script src="../../assets/vendor/js/menu.js"></script>
    <script src="../../assets/js/main.js"></script>
    <script src="../../assets/js/pages-account-settings-account.js"></script>
    <script async defer src="https://buttons.github.io/buttons.js"></script>
</body>
</html>
