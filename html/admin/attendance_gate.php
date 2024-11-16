<?php
session_start();

// Check if user is not logged in or is not an admin
if (!isset($_SESSION['user_role']) || $_SESSION['user_role'] !== 'admin') {
    header("Location: ../choose.php"); // Redirect to login page if not logged in as admin
    exit();
}

// Include the database connection script
require '../config.php';

// Initialize alert variables
$alert_message = '';
$alert_class = ''; // CSS class for the alert box

// Handle attendance marking
if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['mark_attendance'])) {
    // Get employee_id and entry_type from the POST request
    $employee_id = sanitize_input($_POST['employee_id']);
    $entry_type = sanitize_input($_POST['entry_type']); // 'in' or 'out'
    $description = sanitize_input($_POST['description']);

    // Check the last attendance entry for the employee
    $sql = "SELECT entry_type FROM employee_attendance_gate WHERE employee_id = ? ORDER BY entry_time DESC LIMIT 1";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $employee_id);
    $stmt->execute();
    $result = $stmt->get_result();
    $last_entry = $result->fetch_assoc();

    // Logic to check the validity of the new entry
    $can_mark_attendance = true;
    if ($last_entry) {
        if ($entry_type == 'in' && $last_entry['entry_type'] == 'in') {
            $can_mark_attendance = false;
            $alert_message = "Error! You just marked in.";
            $alert_class = 'alert-danger';
        } elseif ($entry_type == 'out' && $last_entry['entry_type'] == 'out') {
            $can_mark_attendance = false;
            $alert_message = "Error! You just marked out.";
            $alert_class = 'alert-danger';
        }
    } elseif ($entry_type == 'out') {
        $can_mark_attendance = false;
        $alert_message = "Error! You didn't mark in or no record in the system yet.";
        $alert_class = 'alert-danger';
    }

    // If valid, insert the new attendance record
    if ($can_mark_attendance) {
        // Determine the attendance status
        $attendance_status = ($entry_type == 'in') ? 1 : 2; // 1 for marked_in, 2 for marked_out

        $sql = "INSERT INTO employee_attendance_gate (employee_id, entry_time, entry_type, description, attendance_status) 
                VALUES (?, NOW(), ?, ?, ?)";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("isss", $employee_id, $entry_type, $description, $attendance_status);

        if ($stmt->execute()) {
            $alert_message = "Attendance marked successfully.";
            $alert_class = 'alert-success';
        } else {
            $alert_message = "Error marking attendance. Please try again.";
            $alert_class = 'alert-danger';
        }

        // Close statement
        $stmt->close();
    }
}

// Function to sanitize input data
function sanitize_input($data) {
    // Implement your own sanitization logic here, such as:
    $data = trim($data);            // Remove leading/trailing whitespace
    $data = stripslashes($data);    // Remove backslashes
    $data = htmlspecialchars($data);// Convert special characters to HTML entities
    return $data;
}


// Fetch employees based on search criteria
$search = '';
if (isset($_GET['search']) && !empty($_GET['search'])) {
    $search = sanitize_input($_GET['search']);
    $sql = "SELECT employee_id, first_name, last_name 
            FROM employee_registration 
            WHERE first_name LIKE ? OR last_name LIKE ?";
    $stmt = $conn->prepare($sql);
    $search_param = "%" . $search . "%";
    $stmt->bind_param("ss", $search_param, $search_param);
} else {
    $sql = "SELECT employee_id, first_name, last_name FROM employee_registration";
    $stmt = $conn->prepare($sql);
}

$stmt->execute();
$result = $stmt->get_result();
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

    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap" rel="stylesheet" />

    <!-- FullCalendar JS -->
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.0/main.min.js"></script>

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

    <!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
    <!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
    <script src="../../assets/js/config.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

    <style>
        body {
            font-family: 'Poppins', sans-serif;
        }

        .alert {
            margin-bottom: 10px;
            font-weight: bold;
        }

        .status-icon {
            font-size: 24px;
        }

        .status-icon-empty:before {
            content: "\f10c";
            color: gray;
        }

        .status-icon-checked:before {
            content: "\f058";
            color: green;
        }

        .status-icon-wrong:before {
            content: "\f057";
            color: red;
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
                <ul class="menu-inner py-1">
                    <!-- Dashboard -->
                    <li class="menu-item">
                        <a href="dashboard.php" class="menu-link">
                            <i class="menu-icon tf-icons bx bx-chalkboard"></i>
                            <div data-i18n="Analytics">Dashboard</div>
                        </a>
                    </li>
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
                                <a href="attendance_flag.php" class="menu-link">
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
                                    <div data-i18n="Analytics">Flag Ceremony of Employee</div>
                                </a>
                            </li>
                            <li class="menu-item">
                                <a href="print/print_flag_student.php" class="menu-link">
                                    <div data-i18n="Analytics">Flag Ceremony of Student</div>
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
                        <!-- Search form -->
                        <div class="row mb-3">
                            <div class="col-lg-12">
                                <form class="d-flex" method="GET" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>">
                                    <input class="form-control me-2" type="search" placeholder="Search by Name" aria-label="Search" name="search" value="<?php echo htmlspecialchars($search); ?>">
                                    <button class="btn btn-outline-primary" type="submit">Search</button>
                                </form>
                            </div>
                        </div>
                        <!-- /Search form -->
                        <div class="row">
                            <div class="col-lg-12 mb-4">
                                <div class="card">
                                    <div class="card-body">
                                        <h1 class="mb-4">Employee Attendance: Gate Marking</h1>
                                        <?php if (!empty($alert_message)) : ?>
                                            <div class="alert <?php echo $alert_class; ?> mb-4"><?php echo $alert_message; ?></div>
                                            <script>
                                              setTimeout(function() {
                                                document.querySelector('.alert').style.display = 'none';
                                              }, 1500);
                                            </script>
                                        <?php endif; ?>
                                        <div class="table-responsive">
                                            <table class="table table-bordered table-striped">
                                                <thead>
                                                    <tr>
                                                        <th>Status</th>
                                                        <th>Mark In</th>
                                                        <th>Mark Out</th>
                                                        <th>Last Name</th>
                                                        <th>First Name</th>
                                                        <th>Action</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <?php
                                                    if ($result->num_rows > 0) {
                                                        while ($row = $result->fetch_assoc()) {
                                                            echo "<tr>";
                                                            // Status column
                                                            $sql_status = "SELECT attendance_status FROM employee_attendance_gate WHERE employee_id = ? ORDER BY entry_time DESC LIMIT 1";
                                                            $stmt_status = $conn->prepare($sql_status);
                                                            $stmt_status->bind_param("i", $row["employee_id"]);
                                                            $stmt_status->execute();
                                                            $result_status = $stmt_status->get_result();
                                                            if ($result_status->num_rows > 0) {
                                                                $status_row = $result_status->fetch_assoc();
                                                                echo '<td class="status-icon">';
                                                                if ($status_row['attendance_status'] == '0') {
                                                                    echo "<td>Not Marked from the System</td>";
                                                                } elseif ($status_row['attendance_status'] == '1') {
                                                                    echo '<i class="fas fa-check-circle status-icon-checked"></i>';
                                                                } elseif ($status_row['attendance_status'] == '2') {
                                                                    echo '<i class="fas fa-times-circle status-icon-wrong"></i>';
                                                                }
                                                                echo '</td>';
                                                            } else {
                                                                echo "<td>Not Marked from the System</td>";
                                                            }
                                                          
                                                            // Mark In column
                                                            echo '<td class="mark-column">
                                                                <form method="post" action="" class="d-flex flex-column flex-sm-row align-items-center">
                                                                    <input type="hidden" name="employee_id" value="' . $row["employee_id"] . '">
                                                                    <input type="hidden" name="entry_type" value="in">
                                                                    <input type="text" name="description" class="form-control mb-2 mb-sm-0 me-sm-2" placeholder="Description (optional)">
                                                                    <button type="submit" name="mark_attendance" class="btn btn-success">
                                                                        <span class="d-none d-sm-inline">Mark In</span>
                                                                        <span class="d-inline d-sm-none">In</span>
                                                                    </button>
                                                                </form>
                                                            </td>';
                                                          
                                                            // Mark Out column
                                                            echo '<td class="mark-column">
                                                                <form method="post" action="" class="d-flex flex-column flex-sm-row align-items-center">
                                                                    <input type="hidden" name="employee_id" value="' . $row["employee_id"] . '">
                                                                    <input type="hidden" name="entry_type" value="out">
                                                                    <input type="text" name="description" class="form-control mb-2 mb-sm-0 me-sm-2" placeholder="Description (optional)">
                                                                    <button type="submit" name="mark_attendance" class="btn btn-danger">
                                                                        <span class="d-none d-sm-inline">Mark Out</span>
                                                                        <span class="d-inline d-sm-none">Out</span>
                                                                    </button>
                                                                </form>
                                                            </td>';
                                                            echo "<td>" . $row["last_name"] . "</td>";
                                                            echo "<td>" . $row["first_name"] . "</td>";
                                                            echo "<td><a href='attendance_gate_history.php?employee_id=" . $row['employee_id'] . "'><i class='menu-icon tf-icons bx bx-show'></i></a></td>";
                                                            echo "</tr>";
                                                            }
                                                        } else {
                                                            echo "<tr><td colspan='6'>No employees found.</td></tr>";
                                                        }
                                                    ?>
                                                </tbody>
                                            </table>
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