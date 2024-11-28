<?php
session_start();

// Check if user is not logged in or is not an admin
if (!isset($_SESSION['user_role']) || $_SESSION['user_role'] !== 'admin') {
    header("Location: ../choose.php"); // Redirect to login page if not logged in as admin
    exit();
}

// Include the database connection script
require '../config.php';

// Initialize message variable
$message = "";

// Handle reset button click
if (isset($_POST['reset'])) {
    $reset_sql = "UPDATE employee_registration SET is_assigned_department = 0";
    if ($conn->query($reset_sql) === TRUE) {
        $message = "All assignments reset successfully.";
    } else {
        $message = "Error resetting assignments: " . $conn->error;
    }
    echo json_encode(array('message' => $message));
    exit(); // Stop further execution after resetting
}

// Check if an employee is clicked for assignment
if (isset($_GET['employee_id'])) {
    $employee_id = $_GET['employee_id'];

    // Check if employee is already assigned
    $check_sql = "SELECT is_assigned_department FROM employee_registration WHERE employee_id = ?";
    $check_stmt = $conn->prepare($check_sql);
    $check_stmt->bind_param("i", $employee_id);
    $check_stmt->execute();
    $check_result = $check_stmt->get_result();

    if ($check_result->num_rows > 0) {
        $row = $check_result->fetch_assoc();
        if ($row['is_assigned_department'] > 0) {
            $message = "Employee is already assigned.";
        } else {
            // Update is_assigned_department for the clicked employee
            $update_sql = "UPDATE employee_registration SET is_assigned_department = 1 WHERE employee_id = ?";
            $update_stmt = $conn->prepare($update_sql);
            $update_stmt->bind_param("i", $employee_id);

            if ($update_stmt->execute()) {
                $message = "Employee assigned successfully.";
            } else {
                $message = "Error assigning employee: " . $update_stmt->error;
            }

            $update_stmt->close();
        }
    } else {
        $message = "Employee not found.";
    }

    echo json_encode(array('message' => $message));
    exit(); // Stop further execution after assigning or error
}

// Check if there is a search term
$search = isset($_GET['search']) ? $_GET['search'] : '';

// Modify SQL to filter based on search term
$sql = "SELECT * FROM employee_registration WHERE is_admin = 0 AND (first_name LIKE ? OR last_name LIKE ? OR email LIKE ?)";
$stmt = $conn->prepare($sql);
$search_term = "%$search%";
$stmt->bind_param("sss", $search_term, $search_term, $search_term);
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

    <!-- Helpers -->
    <script src="../../assets/vendor/js/helpers.js"></script>

    <!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
    <!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
    <script src="../../assets/js/config.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

    <script>
        $(document).ready(function() {
            // AJAX function to assign employee and update UI
            $(".assign-button").click(function(e) {
                e.preventDefault();
                var employee_id = $(this).data('employee-id');
                $.ajax({
                    type: "GET",
                    url: "assign_employee_department.php",
                    data: { employee_id: employee_id },
                    dataType: 'json',
                    success: function(response) {
                        Swal.fire({
                            icon: 'success',
                            title: 'Success',
                            text: response.message
                        }).then(() => {
                            location.reload();
                        });
                    },
                    error: function(xhr, status, error) {
                        var errorMessage = xhr.responseJSON.message || "Error assigning employee.";
                        Swal.fire({
                            icon: 'error',
                            title: 'Oops...',
                            text: errorMessage
                        });
                    }
                });
            });

            // AJAX function to handle reset button click
            $("#resetButton").click(function(e) {
                e.preventDefault();
                $.ajax({
                    type: "POST",
                    url: "assign_employee_department.php",
                    data: { reset: true },
                    dataType: 'json',
                    success: function(response) {
                        Swal.fire({
                            icon: 'success',
                            title: 'Success',
                            text: response.message
                        }).then(() => {
                            location.reload();
                        });
                    },
                    error: function(xhr, status, error) {
                        var errorMessage = xhr.responseJSON.message || "Error resetting assignments.";
                        Swal.fire({
                            icon: 'error',
                            title: 'Oops...',
                            text: errorMessage
                        });
                    }
                });
            });

            // Filter table based on search input
            $("#searchInput").on("keyup", function() {
                var value = $(this).val().toLowerCase();
                $("#employeeTableBody tr").filter(function() {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
                });
            });
        });
    </script>
    <style>
        body, .btn, .menu-link, .navbar-nav-right, .footer, .app-brand, .queue-number {
            font-family: 'Poppins', sans-serif;
        }

        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .btn-primary {
            background-color: #007bff;
            color: #fff;
        }

        .btn-primary:hover {
            background-color: #0056b3;
        }

        .btn-success {
            background-color: #28a745;
            color: #fff;
        }

        .btn-success:hover {
            background-color: #218838;
        }

        .queue-number {
            font-size: 24px;
            font-weight: bold;
            margin: 0 20px;
        }

        .centered-button {
            text-align: center;
            margin-top: 20px;
        }

        /* Ensure the card maintains its style and size even when wrapped in a link */
        .card-link {
            text-decoration: none; /* Remove underline from the link */
            color: inherit; /* Inherit text color */
            display: block; /* Make the link block to cover the entire card */
        }

        .badge.badge-danger {
            color: #fff; /* Set text color to white */
            background-color: #dc3545; /* Set background color to red */
            display: inline-block;
            padding: 0.35em 0.65em;
            font-size: 0.75em;
            font-weight: 700;
            line-height: 1;
            text-align: center;
            white-space: nowrap;
            vertical-align: baseline;
            border-radius: 0.25rem;
        }

        .alert-success {
            color: #155724; /* Text color */
            background-color: #d4edda; /* Background color */
            border-color: #c3e6cb; /* Border color */
            padding: 10px;
            margin-top: 10px;
        }

        .success-message {
            color: #28a745; /* Green color for success */
            font-weight: bold;
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
                        <div class="row mb-3">
                            <div class="col-lg-12">
                                <form class="d-flex" method="GET" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>">
                                    <input class="form-control me-2" type="search" id="searchInput" placeholder="Search by Name" aria-label="Search" name="search" value="<?php echo htmlspecialchars($search); ?>">
                                </form>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-12 mb-4 order-0">
                                <div class="card">
                                    <div class="card-body">
                                        <h1 class="mb-4">Assign Employee for Flag Ceremony Attendance</h1>
                                        <div id="message" class="alert alert-success" role="alert" style="display: none;"></div>
                                        <button id="resetButton" class="btn btn-danger mb-4">Reset Assignments</button>
                                        <div class="table-responsive">
                                            <table class="table table-striped">
                                                <thead>
                                                    <tr>
                                                        <th>#</th>
                                                        <th>Action</th>
                                                        <th>First Name</th>
                                                        <th>Last Name</th>
                                                        <th>Department</th>
                                                    </tr>
                                                </thead>
                                                <tbody id="employeeTableBody">
                                                    <?php
                                                    $counter = 1;
                                                    if ($result->num_rows > 0) {
                                                        while ($row = $result->fetch_assoc()) {
                                                            echo "<tr>";
                                                            echo "<td class='text-nowrap'>{$counter}</td>";
                                                            echo "<td class='text-nowrap'>";
                                                            if ($row['is_assigned_department'] == 0) {
                                                                echo "<button class='btn btn-primary assign-button' data-employee-id='{$row['employee_id']}'>Assign for Attendance</button>";
                                                            } else {
                                                                echo "<span class='badge badge-danger'>Already Assigned</span>";
                                                            }
                                                            echo "</td>";
                                                            echo "<td class='text-nowrap'>{$row['first_name']}</td>";
                                                            echo "<td class='text-nowrap'>{$row['last_name']}</td>";
                                                            echo "<td class='text-nowrap'>{$row['department']}</td>";
                                                            echo "</tr>";
                                                            $counter++;
                                                        }
                                                    } else {
                                                        echo "<tr><td colspan='6'>No non-admin employees found.</td></tr>";
                                                    }
                                                    ?>
                                                </tbody>
                                            </table>
                                        </div>
                                        <div class="centered-button">
                                            <a href="attendance_flag.php" class="btn btn-primary">
                                                <i class="bx bx-chevron-left"></i> Back
                                            </a>
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
</body>
</html>

<?php
// Close connection
$conn->close();
?>