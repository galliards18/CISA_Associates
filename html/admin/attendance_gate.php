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
                                        <h1 class="mb-4 d-inline-flex align-items-center">
                                            Employee Attendance: Gate Marking
                                            <div class="dropdown ms-2">
                                                <button class="btn btn-link text-decoration-none p-0" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
                                                    <i class="bx bx-printer"></i>
                                                </button>
                                                <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                                    <li><a class="dropdown-item" href="print/print_gate.php">Print Gate Record</a></li>
                                                </ul>
                                            </div>
                                        </h1>
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