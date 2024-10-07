<!DOCTYPE html>
<html lang="en" class="light-style layout-menu-fixed" dir="ltr" data-theme="theme-default" data-assets-path="../../assets/" data-template="vertical-menu-template-free">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />
    <title>Attendance Monitoring System</title>
    <meta name="description" content="" />

    <!-- Favicon -->
    <link rel="icon" type="image/x-icon" href="../../assets/img/avatars/logo.png"/>

    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap" rel="stylesheet" />
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

    <!-- Page CSS -->

    <!-- Helpers -->
    <script src="../../assets/vendor/js/helpers.js"></script>

    <!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
    <!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
    <script src="../../assets/js/config.js"></script>
    <style>
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-family: 'Poppins', sans-serif;
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
            font-family: 'Poppins', sans-serif;
        }

        .centered-button {
            text-align: center;
            margin-top: 20px;
        }

        body, p, label, .card-title {
            font-family: 'Poppins', sans-serif;
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
                        <b><p style="font-size: 20px; color: blue; text-shadow: 2px 2px 50px #00008b; padding-left: 18px;">S L S U</p></b>
                    </div>

                    <a href="javascript:void(0);" class="layout-menu-toggle menu-link text-large ms-auto d-block d-xl-none">
                        <i class="bx bx-chevron-left bx-sm align-middle"></i>
                    </a>
                </div>

                <div class="menu-inner-shadow"></div>

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
                              <a href="admin_profile.php" class="menu-link">
                                <div data-i18n="Analytics">Profile</div>
                              </a>
                            </li>
                            <li class="menu-item">
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
                    <!-- <li class="menu-item active">
                        <a href="javascript:void(0);" class="menu-link menu-toggle">
                            <i class="menu-icon tf-icons bx bx-calendar-event"></i>
                            <div data-i18n="Layouts">Event</div>
                        </a>
                        <ul class="menu-sub">
                            <li class="menu-item active">
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
                            <!-- User -->
                            <li class="nav-item navbar-dropdown dropdown-user dropdown">
                                <a class="nav-link dropdown-toggle hide-arrow" href="javascript:void(0);" data-bs-toggle="dropdown">
                                    <div class="avatar avatar-online">
                                        <img src="../../assets/img/avatars/user.png" alt class="w-px-40 h-auto rounded-circle" />
                                    </div>
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end">
                                    <li>
                                        <a class="dropdown-item" href="admin_profile.php">
                                            <div class="d-flex">
                                                <div class="flex-shrink-0 me-3">
                                                    <div class="avatar avatar-online">
                                                        <img src="../../assets/img/avatars/user.png" alt class="w-px-40 h-auto rounded-circle" />
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
                        <div class="row">
                            <div class="col-lg-12 mb-4 order-0">
                                <div class="card">
                                    <div class="d-flex align-items-end row">
                                        <div class="col-sm-7">
                                            <!-- Event Management Form -->
                                            <div class="card-body pb-0 px-0 px-md-4">
                                                <h4 class="card-title">Event Management</h4>
                                                <form method="POST" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>" enctype="multipart/form-data">
                                                    <div class="mb-3">
                                                        <label for="event_name" class="form-label">Event Name</label>
                                                        <input type="text" class="form-control" id="event_name" name="event_name" required>
                                                    </div>
                                                    <div class="mb-3">
                                                        <label for="description" class="form-label">Description</label>
                                                        <textarea class="form-control" id="description" name="description" rows="3" required></textarea>
                                                    </div>
                                                    <div class="mb-3">
                                                        <label for="event_date" class="form-label">Event Date</label>
                                                        <input type="date" class="form-control" id="event_date" name="event_date" required>
                                                    </div>
                                                    <div class="mb-3">
                                                        <label for="time_in" class="form-label">Time In</label>
                                                        <input type="time" class="form-control" id="time_in" name="time_in" required>
                                                    </div>
                                                    <div class="mb-3">
                                                        <label for="time_in_limit" class="form-label">Time In Limit</label>
                                                        <input type="time" class="form-control" id="time_in_limit" name="time_in_limit" required>
                                                    </div>
                                                    <div class="mb-3">
                                                        <label for="time_out" class="form-label">Time Out</label>
                                                        <input type="time" class="form-control" id="time_out" name="time_out" required>
                                                    </div>
                                                    <div class="mb-3">
                                                        <label for="time_out_limit" class="form-label">Time Out Limit</label>
                                                        <input type="time" class="form-control" id="time_out_limit" name="time_out_limit" required>
                                                    </div>
                                                    <button type="submit" class="btn btn-primary mb-3 mt-3">Add Event</button>
                                                </form>
                                            </div>
                                            <!-- End Event Management Form -->
                                        </div>
                                        <div class="col-sm-5 text-center text-sm-left">
                                            <div class="card-body pb-0 px-0 px-md-4">
                                                <img src="../../assets/img/illustrations/man-with-laptop-light.png" height="140" alt="View Badge User" data-app-dark-img="illustrations/man-with-laptop-dark.png" data-app-light-img="illustrations/man-with-laptop-light.png" />
                                            </div>
                                        </div>
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
                </div>
                <!-- / Content wrapper -->
            </div>
            <!-- / Layout page -->
        </div>

        <!-- Overlay -->
        <div class="layout-overlay layout-menu-toggle"></div>
    </div>

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
    <script src="../../assets/js/dashboards-analytics.js"></script>

    <!-- Place this tag in your head or just before your close body tag. -->
    <script async defer src="https://buttons.github.io/buttons.js"></script>
</body>
</html>
