<?php
session_start();

// Check if user is not logged in or is not an admin
if (!isset($_SESSION['user_role']) || $_SESSION['user_role'] !== 'admin') {
    header("Location: ../choose.php"); // Redirect to login page if not logged in as admin
    exit();
}

// Include the database connection script
require_once('../config.php');

function sanitize($data) {
    return htmlspecialchars(strip_tags($data));
}

$firstnameFilter = '';
$itemsPerPage = 50;
$totalItems = 0;
$totalPages = 1;
$current_page = 1;

// Check if a search query is provided
if ($_SERVER['REQUEST_METHOD'] == "GET") {
    if (isset($_GET['firstname'])) {
        $firstnameFilter = sanitize($_GET['firstname']);
    }

    // Prepare the SQL query to count total items
    $sqlCountQuery = "SELECT COUNT(*) AS total FROM student_registration WHERE 1";

    if (!empty($firstnameFilter)) {
        // Search in both first and last names
        $sqlCountQuery .= " AND (first_name LIKE '%$firstnameFilter%' OR last_name LIKE '%$firstnameFilter%')";
    }

    // Execute the count query
    $countResult = mysqli_query($conn, $sqlCountQuery);
    if ($countRow = mysqli_fetch_assoc($countResult)) {
        $totalItems = $countRow['total'];
    }

    // Calculate total pages
    $totalPages = ceil($totalItems / $itemsPerPage);

    // Get current page from the URL, default to 1
    if (isset($_GET['page']) && is_numeric($_GET['page'])) {
        $current_page = (int)$_GET['page'];
    }
    if ($current_page < 1) {
        $current_page = 1;
    } elseif ($current_page > $totalPages) {
        $current_page = $totalPages;
    }

    // Calculate offset
    $offset = ($current_page - 1) * $itemsPerPage;

    // Prepare the SQL query to fetch paginated data
    $sqlquery = "SELECT * FROM student_registration WHERE 1";

    if (!empty($firstnameFilter)) {
        // Search in both first and last names
        $sqlquery .= " AND (first_name LIKE '%$firstnameFilter%' OR last_name LIKE '%$firstnameFilter%')";
    }

    $sqlquery .= " LIMIT $itemsPerPage OFFSET $offset";

    // Execute the paginated query
    $result = mysqli_query($conn, $sqlquery);
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
        .btn > a {
            color: white;
        }
        body, html {
            font-family: 'Poppins', sans-serif;
        }
        .btn > a {
            color: white;
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
                                                    <h1 class="text-center mb-4 student-enrolle"><a href="dashboard.php">Available Student</a></h1>
                                                    <!-- Search -->
                                                    <form method="GET" action="student.php" class="mb-4">
                                                        <div class="input-group">
                                                            <input type="text" class="form-control" name="firstname" placeholder="Search by First or Last Name" value="<?php echo $firstnameFilter; ?>">
                                                            <button class="btn btn-primary" type="submit">Search</button>
                                                        </div>
                                                    </form>
                                                    <!-- / Search  -->
                                                    <button class="btn btn-primary mb-2"><a href="student_registration.php">Add New Student</a></button>
                                                    <div class="table-responsive">
                                                        <table class="table table-bordered table-striped">
                                                            <thead>
                                                                <tr>
                                                                    <th>Student ID</th>
                                                                    <th>First Name</th>
                                                                    <th>Last Name</th>
                                                                    <th>Address</th>
                                                                    <th>Gender</th>
                                                                    <th>Email</th>
                                                                    <th>Birthday</th>
                                                                    <th>Phone</th>
                                                                    <th>Action</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <?php
                                                                $counter = 1; 
                                                                if (isset($result) && mysqli_num_rows($result) > 0) {
                                                                    while ($row = mysqli_fetch_array($result)) {
                                                                        echo "<tr>";
                                                                        echo "<td class='text-nowrap'>{$counter}</td>"; 
                                                                        echo "<td class='text-nowrap'>" . $row['first_name'] . "</td>";
                                                                        echo "<td class='text-nowrap'>" . $row['last_name'] . "</td>";
                                                                        echo "<td class='text-nowrap'>" . $row['address'] . "</td>";
                                                                        echo "<td class='text-nowrap'>" . $row['gender'] . "</td>";
                                                                        echo "<td class='text-nowrap'>" . $row['email'] . "</td>";
                                                                        echo "<td class='text-nowrap'>" . $row['date_of_birth'] . "</td>";
                                                                        echo "<td class='text-nowrap'>" . $row['phone_number'] . "</td>";
                                                                        echo "<td class='action-icons text-nowrap'>";
                                                                        echo "<a href='view_student_profile.php?student_id=" . $row['student_id'] . "'><i class='menu-icon tf-icons bx bx-show'></i></a>";
                                                                        echo "<a onclick=\"return confirm('Are you sure?')\" href='delete_student.php?student_id=" . $row['student_id'] . "'><i class='menu-icon tf-icons bx bx-trash'></i></a>";
                                                                        echo "</td>";
                                                                        echo "</tr>";
                                                                        $counter++; 
                                                                    }
                                                                } else {
                                                                    echo "<tr><td colspan='9'>No records found</td></tr>";
                                                                }
                                                                ?>
                                                            </tbody>
                                                        </table>
                                                    </div>

                                                    <!-- Pagination Links -->
                                                    <nav class="mt-3">
                                                        <ul class="pagination justify-content-center">
                                                            <?php if ($current_page > 1): ?>
                                                                <li class="page-item">
                                                                    <a class="page-link" href="?page=<?php echo $current_page - 1; ?>&firstname=<?php echo $firstnameFilter; ?>">Previous</a>
                                                                </li>
                                                            <?php endif; ?>

                                                            <?php for ($i = 1; $i <= $totalPages; $i++): ?>
                                                                <li class="page-item <?php echo $i == $current_page ? 'active' : ''; ?>">
                                                                    <a class="page-link" href="?page=<?php echo $i; ?>&firstname=<?php echo $firstnameFilter; ?>"><?php echo $i; ?></a>
                                                                </li>
                                                            <?php endfor; ?>

                                                            <?php if ($current_page < $totalPages): ?>
                                                                <li class="page-item">
                                                                    <a class="page-link" href="?page=<?php echo $current_page + 1; ?>&firstname=<?php echo $firstnameFilter; ?>">Next</a>
                                                                </li>
                                                            <?php endif; ?>
                                                        </ul>
                                                    </nav>
                                                    <div class="text-center mt-3">
                                                        <p>Total Employees Available: <?php echo isset($totalItems) ? $totalItems : '0'; ?></p>
                                                    </div>
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