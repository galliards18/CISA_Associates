<?php
session_start();

// Check if user is not logged in or is not an employee
if (!isset($_SESSION['user_role']) || $_SESSION['user_role'] !== 'employee') {
    header("Location: ../choose.php"); // Redirect to login page if not logged in as employee
    exit();
}

// Include the database connection script
require '../config.php';

// Function to sanitize input data
function sanitize_input($data) {
    $data = trim($data);            // Remove leading/trailing whitespace
    $data = stripslashes($data);    // Remove backslashes
    $data = htmlspecialchars($data);// Convert special characters to HTML entities
    return $data;
}

// Get the employee ID from the session
$employee_id = $_SESSION['employee_id'];

// Fetch the department of the logged-in employee
$departmentSql = "SELECT department FROM employee_registration WHERE employee_id = ?";
$departmentStmt = $conn->prepare($departmentSql);
$departmentStmt->bind_param("i", $employee_id);
$departmentStmt->execute();
$departmentResult = $departmentStmt->get_result();

if ($departmentResult->num_rows > 0) {
    $departmentRow = $departmentResult->fetch_assoc();
    $userDepartment = $departmentRow['department'];
} else {
    echo json_encode(array('status' => 'error', 'message' => 'Department not found'));
    exit();
}

// Fetch employees based on search criteria
$search = '';
$search_param1 = '';
$search_param2 = '';

if (isset($_GET['search']) && !empty($_GET['search'])) {
    // Sanitize search input
    $search = sanitize_input($_GET['search']);
    $sql = "SELECT e.employee_id, e.first_name, e.last_name, e.department, COALESCE(f.attendance_status, 'no record') AS attendance_status
            FROM employee_registration e
            LEFT JOIN (
                SELECT employee_id, MAX(attendance_date) AS max_date
                FROM employee_attendance_department
                WHERE DATE(attendance_date) = CURDATE()
                GROUP BY employee_id
            ) af ON e.employee_id = af.employee_id
            LEFT JOIN employee_attendance_department f ON af.employee_id = f.employee_id AND af.max_date = f.attendance_date
            WHERE (e.first_name LIKE ? OR e.last_name LIKE ?) AND e.department = ?";
    $stmt = $conn->prepare($sql);
    $search_param1 = "%" . $search . "%";
    $search_param2 = "%" . $search . "%";
    $stmt->bind_param("sss", $search_param1, $search_param2, $userDepartment);
} else {
    $sql = "SELECT e.employee_id, e.first_name, e.last_name, e.department, COALESCE(f.attendance_status, 'no record') AS attendance_status
            FROM employee_registration e
            LEFT JOIN (
                SELECT employee_id, MAX(attendance_date) AS max_date
                FROM employee_attendance_department
                WHERE DATE(attendance_date) = CURDATE()
                GROUP BY employee_id
            ) af ON e.employee_id = af.employee_id
            LEFT JOIN employee_attendance_department f ON af.employee_id = f.employee_id AND af.max_date = f.attendance_date
            WHERE e.department = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("s", $userDepartment);
}

// Execute the statement and get the result set
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
                                        <div class="card-body d-flex justify-content-between align-items-center mb-1">
                                            <h1 class="mb-0">
                                                <?php
                                                $today = date('N'); // Get the numeric representation of the day (1 for Monday, ..., 7 for Sunday)
                                                $flagType = ($today == 5) ? 'Flag Retreat' : 'Flag Raising'; // Check if today is Friday
                                                echo "Employee Attendance: $flagType";
                                                ?>
                                            </h1>
                                        </div>
                                        <div class="table-responsive">
                                            <table class="table table-bordered table-striped">
                                                <thead>
                                                    <tr>
                                                        <th>#</th>
                                                        <th>Attendance</th>
                                                        <th>First Name</th>
                                                        <th>Last Name</th>
                                                        <th>Department</th>
                                                        <th>Status</th>
                                                    </tr>
                                                </thead>
                                                <tbody id="employeeTableBody">
                                                    <?php
                                                    $index = 0; // Initialize index counter
                                                    while ($row = $result->fetch_assoc()) :
                                                        $index++; // Increment index for each row
                                                    ?>
                                                    <tr id="employee_<?php echo $row['employee_id']; ?>">
                                                        <td><?php echo $index; ?></td>
                                                        <td>
                                                            <form id="attendanceForm_<?php echo $row['employee_id']; ?>" class="attendance-form">
                                                                <input type="hidden" name="employee_id" value="<?php echo $row['employee_id']; ?>">
                                                                <div class="row g-2">
                                                                    <div class="col mb-1">
                                                                        <button type="button" class="btn btn-success btn-sm mark-attendance w-100 mb-0.5" data-status="present">
                                                                            <span class="d-none d-sm-inline">Present</span>
                                                                            <span class="d-inline d-sm-none">Present</span>
                                                                        </button>
                                                                    </div>
                                                                    <div class="col mb-1">
                                                                        <button type="button" class="btn btn-warning btn-sm mark-attendance w-100 mb-0.5" data-status="late">
                                                                            <span class="d-none d-sm-inline">Late</span>
                                                                            <span class="d-inline d-sm-none">Late</span>
                                                                        </button>
                                                                    </div>
                                                                    <div class="col mb-1">
                                                                        <button type="button" class="btn btn-danger btn-sm mark-attendance w-100 mb-1" data-status="absent">
                                                                            <span class="d-none d-sm-inline">Absent</span>
                                                                            <span class="d-inline d-sm-none">Absent</span>
                                                                        </button>
                                                                    </div>
                                                                </div>
                                                            </form>
                                                        </td>
                                                        <td><?php echo htmlspecialchars($row['first_name']); ?></td>
                                                        <td><?php echo htmlspecialchars($row['last_name']); ?></td>
                                                        <td><?php echo htmlspecialchars($row['department']); ?></td>
                                                        <td>
                                                            <?php
                                                            $status = htmlspecialchars($row['attendance_status']);
                                                            $statusClass = '';
                                                            switch ($status) {
                                                                case 'present':
                                                                    $statusClass = 'text-success'; // Green text for present
                                                                    break;
                                                                case 'late':
                                                                    $statusClass = 'text-warning'; // Orange text for late
                                                                    break;
                                                                case 'absent':
                                                                    $statusClass = 'text-danger'; // Red text for absent
                                                                    break;
                                                                default:
                                                                    $statusClass = 'text-primary'; // Blue text for no record
                                                                    break;
                                                            }
                                                            ?>
                                                            <span class="<?php echo $statusClass; ?>" id="status_<?php echo $row['employee_id']; ?>">
                                                                <?php echo ucfirst($status); ?>
                                                            </span>
                                                        </td>
                                                    </tr>
                                                <?php endwhile; ?>
                                                </tbody>
                                            </table>
                                        </div>
                                        <div class="centered-button mt-3">
                                            <center>
                                                <a href="dashboard.php" class="btn btn-primary">
                                                    <i class="bx bx-chevron-left"></i> Back to Dashboard
                                                </a>
                                            </center>
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

    <script>
        $(document).ready(function() {
            function updateStatusIcon(employeeId, status) {
                var statusElement = $('#status_' + employeeId);
                statusElement.removeClass('text-success text-warning text-danger text-primary');

                switch (status) {
                    case 'present':
                        statusElement.addClass('text-success').text('Present');
                        break;
                    case 'late':
                        statusElement.addClass('text-warning').text('Late');
                        break;
                    case 'absent':
                        statusElement.addClass('text-danger').text('Absent');
                        break;
                    default:
                        statusElement.addClass('text-primary').text('No Record');
                        break;
                }
            }

            function refreshTable() {
                location.reload(); // Reload the whole page
                // Alternatively, you could fetch and update only the table content with AJAX here
            }

            $('.mark-attendance').click(function() {
                var employeeId = $(this).closest('.attendance-form').find('input[name="employee_id"]').val();
                var status = $(this).data('status');

                Swal.fire({
                    title: 'Are you sure?',
                    text: "You want to mark attendance?",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes, mark it!'
                }).then((result) => {
                    if (result.isConfirmed) {
                        $.ajax({
                            url: 'process_attendance_department.php',
                            method: 'POST',
                            dataType: 'json', // Expect JSON response
                            data: {
                                employee_id: employeeId,
                                attendance_status: status
                            },
                            success: function(response) {
                                if (response.status === 'success') {
                                    updateStatusIcon(employeeId, status);
                                    Swal.fire(
                                        'Success!',
                                        response.message,
                                        'success'
                                    ).then(() => {
                                        // Add a delay of 2 seconds before refreshing the table
                                        setTimeout(function() {
                                            refreshTable(); // Refresh the table or page
                                        }, 1000); // 2000 milliseconds = 2 seconds
                                    });
                                } else {
                                    Swal.fire(
                                        'Error!',
                                        response.message,
                                        'error'
                                    );
                                }
                            },
                            error: function(xhr, status, error) {
                                console.error('AJAX Error: ' + status, error);
                                Swal.fire(
                                    'Failed!',
                                    'Failed to mark attendance.',
                                    'error'
                                );
                            }
                        });
                    }
                });
            });
        });
    </script>
</body>
</html>