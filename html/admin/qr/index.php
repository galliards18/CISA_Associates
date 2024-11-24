<?php
session_start();

// Check if user is not logged in or is not an admin
if (!isset($_SESSION['user_role']) || $_SESSION['user_role'] !== 'admin') {
    header("Location: ../choose.php"); // Redirect to login page if not logged in as admin
    exit();
}

// Include the database connection script
require '../../config.php';

date_default_timezone_set('Asia/Manila'); // Set to your local timezone

// Fetch today's logs from employee_qr_log
$today = date('Y-m-d');
$logSql = "SELECT employee_registration.first_name, employee_registration.last_name, 
                  employee_qr_log.entry_type, employee_qr_log.log_time
           FROM employee_qr_log
           JOIN employee_registration ON employee_qr_log.employee_id = employee_registration.employee_id
           WHERE DATE(employee_qr_log.log_time) = ?";
$logStmt = $conn->prepare($logSql);
$logStmt->bind_param("s", $today);
$logStmt->execute();
$logResult = $logStmt->get_result();

// Prepare the logs array
$logs = [];
while ($logRow = $logResult->fetch_assoc()) {
    $logs[] = [
        'employee_name' => $logRow['first_name'] . ' ' . $logRow['last_name'],
        'entry_type' => $logRow['entry_type'],
        'log_time' => $logRow['log_time']
    ];
}

$logStmt->close();
$conn->close();
?>

<!DOCTYPE html>
<html lang="en" class="light-style layout-menu-fixed" dir="ltr" data-theme="theme-default" data-assets-path="../../assets/" data-template="vertical-menu-template-free">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />
    <title>Attendance Monitoring System</title>
    <meta name="description" content="" />

    <!-- Favicon -->
    <link rel="icon" type="image/x-icon" href="../../../assets/img/avatars/logo.png"/>

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
    <link rel="stylesheet" href="../../../assets/vendor/fonts/boxicons.css" />

    <!-- Core CSS -->
    <link rel="stylesheet" href="../../../assets/vendor/css/core.css" class="template-customizer-core-css" />
    <link rel="stylesheet" href="../../../assets/vendor/css/theme-default.css" class="template-customizer-theme-css" />
    <link rel="stylesheet" href="../../../assets/css/demo.css" />

    <!-- Vendors CSS -->
    <link rel="stylesheet" href="../../../assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />
    <link rel="stylesheet" href="../../../assets/vendor/libs/apex-charts/apex-charts.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <!-- Helpers -->
    <script src="../../../assets/vendor/js/helpers.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
    <!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
    <script src="../../../assets/js/config.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

    <!-- Include Instascan library -->
    <script src="https://rawgit.com/schmich/instascan-builds/master/instascan.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> <!-- Include jQuery -->
    <script src="../../../assets/js/config.js"></script>

</head>
<body>
    <!-- Layout wrapper -->
    <div class="layout-wrapper layout-content-navbar">
        <div class="layout-container">
            <!-- Menu -->
            <aside id="layout-menu" class="layout-menu menu-vertical menu bg-menu-theme">
                <div class="app-brand demo" style="padding: 70px;">
                    <div class="logo">
                        <img style="border-radius: 500px; box-shadow: 2px 2px 20px #00008b; margin-top: 30px; margin-bottom: 5px;" src="../../../assets/img/avatars/logo.png" width="100" height="100" alt="">
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
                        <a href="../dashboard.php" class="menu-link">
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
                                <a href="../student.php" class="menu-link">
                                    <div data-i18n="Analytics">Student</div>
                                </a>
                            </li>
                            <li class="menu-item">
                                <a href="../employee.php" class="menu-link">
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
                                <a href="../attendance_gate.php" class="menu-link">
                                    <div data-i18n="Analytics">Gate Marking</div>
                                </a>
                            </li>
                            <li class="menu-item">
                                <a href="../attendance_flag.php" class="menu-link">
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
                                        <img src="../../../assets/img/avatars/user.png" alt="" class="w-px-40 h-auto rounded-circle" />
                                    </div>
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end">
                                    <li>
                                        <a class="dropdown-item" href="#">
                                            <div class="d-flex">
                                                <div class="flex-shrink-0 me-3">
                                                    <div class="avatar avatar-online">
                                                        <img src="../../../assets/img/avatars/user.png" alt="" class="w-px-40 h-auto rounded-circle" />
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
                                        <a class="dropdown-item" href="../admin_profile.php">
                                            <i class="bx bx-user me-2"></i><span>My Profile</span>
                                        </a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="#">
                                            <i class="bx bx-cog me-2"></i><span>Settings</span>
                                        </a>
                                    </li>
                                    <li class="dropdown">
                                        <div class="dropdown-item d-flex align-items-center">
                                            <i class="bx bx-printer me-2"></i>
                                            <select id="print-options" class="form-select" onchange="handlePrintRedirect(this)">
                                                <option value="" disabled selected>Select an option</option>
                                                <option value="print/print_flag.php">Flag Ceremony Employee</option>
                                                <option value="print/print_flag_student.php">Flag Ceremony Student</option>
                                                <option value="print/print_gate.php">Gate Marking</option>
                                            </select>
                                        </div>
                                    </li>
                                    <script>
                                        function handlePrintRedirect(select) {
                                            const selectedValue = select.value;
                                            if (selectedValue) {
                                                window.location.href = selectedValue;
                                            }
                                        }
                                    </script>
                                    <li>
                                        <a class="dropdown-item" href="index.php">
                                            <i class="bx bx-qr me-2"></i><span>Scan QR Code</span>
                                        </a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="../../logout.php">
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
                        <div class="row">
                            <div class="col-lg-12 mb-4 order-0">
                                <div class="card">
                                    <div class="card-header">
                                        <h1 class="mb-0">QR Code Scanner</h1>
                                    </div>
                                    <div class="card-body">
                                        <!-- Camera Preview & QR Scan Area -->
                                        <div class="row">
                                            <div class="col-md-6">
                                                <video id="preview" width="100%" autoplay class="rounded border shadow-sm"></video>
                                            </div>
                                            <div class="col-md-6">
                                                <label for="text" class="form-label">Scan QR Code</label>
                                                <input type="text" name="text" id="text" readonly placeholder="Scan QR Code" class="form-control shadow-sm">

                                                <!-- Alert Message -->
                                                <div id="alert-message" class="alert mt-3" style="display: none;"></div>

                                                <!-- Buttons for QR Scan -->
                                                <div id="entry-buttons" class="mt-3" style="display: none;">
                                                    <button class="btn btn-success shadow-sm rounded-3 w-100 mb-2 hover-shadow" id="in-button">
                                                        <i class="fas fa-sign-in-alt me-2"></i> In
                                                    </button>
                                                    <button class="btn btn-danger shadow-sm rounded-3 w-100 mb-2 hover-shadow" id="out-button">
                                                        <i class="fas fa-sign-out-alt me-2"></i> Out
                                                    </button>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Display QR Log Data -->
                                        <div class="mt-5">
                                            <h4>Today's QR Scan Logs</h4>
                                            <table class="table table-bordered table-striped">
                                                <thead>
                                                    <tr>
                                                        <th>Employee Name</th>
                                                        <th>Entry Type</th>
                                                        <th>Log Time</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <?php if (count($logs) > 0): ?>
                                                        <?php foreach ($logs as $log): ?>
                                                            <tr>
                                                                <td><?php echo htmlspecialchars($log['employee_name']); ?></td>
                                                                <td><?php echo htmlspecialchars($log['entry_type']); ?></td>
                                                                <td><?php echo htmlspecialchars($log['log_time']); ?></td>
                                                            </tr>
                                                        <?php endforeach; ?>
                                                    <?php else: ?>
                                                        <tr>
                                                            <td colspan="3">No logs found for today.</td>
                                                        </tr>
                                                    <?php endif; ?>
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
    <script src="../../../assets/vendor/libs/jquery/jquery.js"></script>
    <script src="../../../assets/vendor/libs/popper/popper.js"></script>
    <script src="../../../assets/vendor/js/bootstrap.js"></script>
    <script src="../../../assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>
    <script src="../../../assets/vendor/js/menu.js"></script>
    <!-- endbuild -->

    <!-- Vendors JS -->
    <script src="../../../assets/vendor/libs/apex-charts/apexcharts.js"></script>

    <!-- Main JS -->
    <script src="../../../assets/js/main.js"></script>

    <!-- Page JS -->
    <script src="../../../assets/js/pages-account-settings-account.js"></script>

    <!-- Place this tag in your head or just before your close body tag. -->
    <script async defer src="https://buttons.github.io/buttons.js"></script>

    <script>
    // Initialize the scanner
    let scanner = new Instascan.Scanner({ video: document.getElementById('preview') });

    // Get available cameras
    Instascan.Camera.getCameras().then(function(cameras) {
        if (cameras.length > 0) {
            scanner.start(cameras[0]); // Start the first available camera
        } else {
            alert('No cameras found.');
        }
    }).catch(function(e) {
        console.error(e);
    });

    // Listener for scanned QR codes
    scanner.addListener('scan', function(content) {
        // Send the scanned employee ID to the server to fetch employee name
        $.ajax({
            url: 'process_qr.php', // Path to your PHP script
            type: 'POST',
            data: { text: content },
            success: function(response) {
                try {
                    // Parse the response as JSON
                    const data = JSON.parse(response);

                    // Check if the employee data was fetched successfully
                    if (data.success) {
                        // Display the employee's name in the input field
                        document.getElementById('text').value = data.first_name + ' ' + data.last_name;

                        // Show the "in" and "out" buttons
                        $('#entry-buttons').show();

                        // Handle "in" button click
                        $('#in-button').on('click', function() {
                            submitEntry(content, 'in');
                        });

                        // Handle "out" button click
                        $('#out-button').on('click', function() {
                            submitEntry(content, 'out');
                        });

                    } else {
                        // Display error message if employee is not found
                        let alertBox = document.getElementById('alert-message');
                        alertBox.innerHTML = data.message;
                        alertBox.className = 'alert alert-danger'; // Error style
                        alertBox.style.display = 'block';
                    }
                } catch (error) {
                    console.error("Error processing response: ", response);
                }
            },
            error: function(xhr, status, error) {
                console.error("Error: " + error);
            }
        });
    });

    // Function to submit entry type to the server
    function submitEntry(employeeId, entryType) {
        // Send QR code data and entry type to the server via AJAX
        $.ajax({
            url: 'process_qr.php', // Path to your PHP script
            type: 'POST',
            data: { text: employeeId, entry_type: entryType },
            success: function(response) {
                try {
                    // Parse the response as JSON
                    const data = JSON.parse(response);

                    // Show success or error message
                    let alertBox = document.getElementById('alert-message');
                    if (data.success) {
                        alertBox.innerHTML = data.message;
                        alertBox.className = 'alert alert-success'; // Success style
                    } else {
                        alertBox.innerHTML = data.message;
                        alertBox.className = 'alert alert-danger'; // Error style
                    }
                    alertBox.style.display = 'block';

                    // Hide the entry buttons after submission
                    $('#entry-buttons').hide();

                    // Reload the page after 3 seconds (optional)
                    setTimeout(function() {
                        location.reload();
                    }, 3000);
                } catch (error) {
                    console.error("Error processing log response: ", response);
                }
            },
            error: function(xhr, status, error) {
                console.error("Error: " + error);
            }
        });
    }
</script>

</body>
</html>