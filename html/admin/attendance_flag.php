<?php
session_start();

// Check if user is not logged in or is not an admin
if (!isset($_SESSION['user_role']) || $_SESSION['user_role'] !== 'admin') {
    header("Location: ../choose.php"); // Redirect to login page if not logged in as admin
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

// Fetch employees based on search criteria
$search = '';
$search_param1 = '';
$search_param2 = '';

if (isset($_GET['search']) && !empty($_GET['search'])) {
    // Sanitize search input
    $search = sanitize_input($_GET['search']);
    $sql = "SELECT e.employee_id, e.first_name, e.last_name, COALESCE(f.attendance_status, 'no record') AS attendance_status
            FROM employee_registration e
            LEFT JOIN (
                SELECT employee_id, MAX(attendance_date) AS max_date
                FROM employee_attendance_flag
                WHERE DATE(attendance_date) = CURDATE()
                GROUP BY employee_id
            ) af ON e.employee_id = af.employee_id
            LEFT JOIN employee_attendance_flag f ON af.employee_id = f.employee_id AND af.max_date = f.attendance_date
            WHERE e.first_name LIKE ? OR e.last_name LIKE ?";
    $stmt = $conn->prepare($sql);
    $search_param1 = "%" . $search . "%";
    $search_param2 = "%" . $search . "%";
    $stmt->bind_param("ss", $search_param1, $search_param2);
} else {
    $sql = "SELECT e.employee_id, e.first_name, e.last_name, COALESCE(f.attendance_status, 'no record') AS attendance_status
            FROM employee_registration e
            LEFT JOIN (
                SELECT employee_id, MAX(attendance_date) AS max_date
                FROM employee_attendance_flag
                WHERE DATE(attendance_date) = CURDATE()
                GROUP BY employee_id
            ) af ON e.employee_id = af.employee_id
            LEFT JOIN employee_attendance_flag f ON af.employee_id = f.employee_id AND af.max_date = f.attendance_date";
    $stmt = $conn->prepare($sql);
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

    <script>
        function fetchEmployees() {
            var department = document.getElementById("department").value;
            var xhr = new XMLHttpRequest();
            xhr.open("GET", "fetch_employees.php?department=" + encodeURIComponent(department), true);
            xhr.onload = function() {
                if (xhr.status === 200) {
                    document.getElementById("employeeList").innerHTML = xhr.responseText;
                } else {
                    console.error("Failed to fetch employees");
                }
            };
            xhr.send();
        }

        function assignEmployee() {
            var selectedEmployee = document.querySelector('input[name="employee_id"]:checked');
            if (selectedEmployee) {
                var employeeId = selectedEmployee.value;
                var xhr = new XMLHttpRequest();
                xhr.open("POST", "assign_employee.php", true);
                xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                xhr.onload = function() {
                    if (xhr.status === 200) {
                        alert(xhr.responseText);
                        fetchEmployees(); // Refresh the employee list
                    } else {
                        console.error("Failed to assign employee");
                    }
                };
                xhr.send("employee_id=" + encodeURIComponent(employeeId));
            } else {
                alert("Please select an employee.");
            }
        }
    </script>
    <style>
        .custom-dropdown-menu {
            min-width: 100%;
        }

        .custom-dropdown-item {
            padding: 8px 15px;
            font-size: 1rem; 
        }

        .assign-link {
            color: #0d6efd;
            font-weight: 500;
            text-decoration: none;
        }

        .btn-secondary.btn-sm {
            font-size: 0.875rem; 
            padding: 5px 10px; 
        }

        .dropdown-toggle {
            font-size: 1.1rem;
            padding: 10px 15px;
        }

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
                                        <h1 class="mb-0">
                                            <?php
                                            $today = date('N'); // Get the numeric representation of the day (1 for Monday, ..., 7 for Sunday)
                                            $flagType = ($today == 5) ? 'Flag Retreat' : 'Flag Raising'; // Check if today is Friday
                                            echo "Employee Attendance: $flagType";
                                            ?>
                                            <div class="dropdown d-inline">
                                                <button class="btn btn-link text-decoration-none p-0" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
                                                    <i class="bx bx-printer"></i>
                                                </button>
                                                <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                                    <li><a class="dropdown-item" href="print/print_flag_student.php">Print Student Flag Record</a></li>
                                                    <li><a class="dropdown-item" href="print/print_flag.php">Print Employee Flag Record</a></li>
                                                </ul>
                                            </div>
                                        </h1>
                                    </div>
                                    <div class="col">
                                        <div class="row justify-content-start align-items-start p-4">
                                            <div class="col">
                                                <div class="row justify-content-start align-items-start">
                                                    <div class="col-lg-5 mb-0 text-start">
                                                        <div class="dropdown mb-3">
                                                            <button class="btn btn-primary dropdown-toggle w-100" type="button" id="assignDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                                                Assign Options
                                                            </button>
                                                            <ul class="dropdown-menu w-100 custom-dropdown-menu" aria-labelledby="assignDropdown">
                                                                <li class="dropdown-item custom-dropdown-item d-flex flex-column flex-sm-row align-items-start align-items-sm-center justify-content-between">
                                                                    <a href="assign_employee.php" class="assign-link w-100 text-start">Assign Employee for Attendance</a>
                                                                    <a href="attendance_flag_history_employee.php" class="btn btn-secondary btn-sm mt-2 mt-sm-0">History</a>
                                                                </li>
                                                                <li class="dropdown-item custom-dropdown-item d-flex flex-column flex-sm-row align-items-start align-items-sm-center justify-content-between">
                                                                    <a href="assign_employee_department.php" class="assign-link w-100 text-start">Assign Employee for Department</a>
                                                                    <a href="attendance_flag_history_department.php" class="btn btn-secondary btn-sm mt-2 mt-sm-0">History</a>
                                                                </li>
                                                                <li class="dropdown-item custom-dropdown-item d-flex flex-column flex-sm-row align-items-start align-items-sm-center justify-content-between">
                                                                    <a href="assign_student.php" class="assign-link w-100 text-start">Assign Student for Attendance</a>
                                                                    <a href="attendance_flag_history_student.php" class="btn btn-secondary btn-sm mt-2 mt-sm-0">History</a>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="table-responsive p-4">
                                            <table class="table table-bordered table-striped">
                                                <thead>
                                                    <tr>
                                                        <th>#</th>
                                                        <th>Status</th>
                                                        <th>Attendance</th>
                                                        <th>Last Name</th>
                                                        <th>First Name</th>
                                                    </tr>
                                                </thead>
                                                <tbody id="employeeTableBody">
                                                    <?php
                                                    $index = 0;
                                                    while ($row = $result->fetch_assoc()) :
                                                        $index++;
                                                    ?>
                                                    <tr id="employee_<?php echo $row['employee_id']; ?>">
                                                        <td><?php echo $index; ?></td>
                                                        <td>
                                                            <?php
                                                            $status = htmlspecialchars($row['attendance_status']);
                                                            $statusClass = '';
                                                            switch ($status) {
                                                                case 'present':
                                                                    $statusClass = 'text-success'; 
                                                                    break;
                                                                case 'late':
                                                                    $statusClass = 'text-warning'; 
                                                                    break;
                                                                case 'absent':
                                                                    $statusClass = 'text-danger'; 
                                                                    break;
                                                                default:
                                                                    $statusClass = 'text-primary';
                                                                    break;
                                                                }
                                                            ?>
                                                            <span class="<?php echo $statusClass; ?>" id="status_<?php echo $row['employee_id']; ?>">
                                                                <?php echo ucfirst($status); ?>
                                                            </span>
                                                        </td>
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
                                                        <td><?php echo htmlspecialchars($row['last_name']); ?></td>
                                                        <td><?php echo htmlspecialchars($row['first_name']); ?></td>
                                                    </tr>
                                                    <?php endwhile; ?>
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
                location.reload();
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
                            url: 'process_attendance.php',
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
                                        setTimeout(function() {
                                            refreshTable(); 
                                        }, 1000); 
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