<?php
session_start();
require_once('config.php');

ini_set('display_errors', 1);
error_reporting(E_ALL);

function sanitize_input($data) {
    return htmlspecialchars(stripslashes(trim($data)));
}

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $email = sanitize_input($_POST["email"]);
    $password = sanitize_input($_POST["password"]);
    $role = sanitize_input($_POST["role"]);

    if (!$email || !$password || !$role) {
        echo "<script>Swal.fire('Error', 'All fields are required.', 'error');</script>";
        exit();
    }

    // Modify the query to select all users based on the role
    $sql = ($role == 'employee') 
        ? "SELECT * FROM employee_registration"  // Fetch all employees
        : "SELECT * FROM student_registration";   // Fetch all students

    $stmt = $conn->prepare($sql);

    if ($stmt->execute()) {
        $result = $stmt->get_result();
        if ($result->num_rows > 0) {
            // Loop through all rows and process them
            while ($row = $result->fetch_assoc()) {
                // Process the row
                // Check if email and password match for each record
                if ($row['email'] == $email && password_verify($password, $row['password'])) {
                    if ($role == 'employee') {
                        $_SESSION['employee_id'] = $row['employee_id'];
                        $_SESSION['user_role'] = $row['is_admin'] ? 'admin' : 'employee';
                        $redirect = $row['is_admin'] ? 'admin/dashboard.php' : 'employee/dashboard.php';
                    } else {
                        $_SESSION['student_id'] = $row['student_id'];
                        $_SESSION['user_role'] = 'student';
                        $redirect = 'student/dashboard.php';
                    }
                    echo "<script>Swal.fire('Success', 'Login successful. Redirecting...', 'success');</script>";
                    header("refresh:2;url=$redirect");
                    exit();
                }
            }
            // If no match is found, show error
            echo "<script>Swal.fire('Error', 'Invalid email or password.', 'error');</script>";
        } else {
            echo "<script>Swal.fire('Error', 'No records found.', 'error');</script>";
        }
    } else {
        echo "<script>Swal.fire('Error', 'Query execution failed.', 'error');</script>";
    }
    $stmt->close();
    $conn->close();
}
?>

<!DOCTYPE html>
<html lang="en" class="light-style customizer-hide" dir="ltr" data-theme="theme-default" data-assets-path="../assets/" data-template="vertical-menu-template-free">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    <title>Login</title>
    <meta name="description" content="" />

    <!-- Favicon -->
    <link rel="icon" type="image/x-icon" href="../assets/img/avatars/logo.png"/>

    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <!-- Icons -->
    <link rel="stylesheet" href="../assets/vendor/fonts/boxicons.css" />

    <!-- Core CSS -->
    <link rel="stylesheet" href="../assets/vendor/css/core.css" class="template-customizer-core-css" />
    <link rel="stylesheet" href="../assets/vendor/css/theme-default.css" class="template-customizer-theme-css" />
    <link rel="stylesheet" href="../assets/css/demo.css" />

    <!-- Vendors CSS -->
    <link rel="stylesheet" href="../assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />

    <!-- Page CSS -->
    <link rel="stylesheet" href="../assets/vendor/css/pages/page-auth.css" />

    <!-- SweetAlert2 CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.24/dist/sweetalert2.min.css">

    <!-- Helpers -->
    <script src="../assets/vendor/js/helpers.js"></script>
    <script src="../assets/js/config.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.24/dist/sweetalert2.min.js"></script>

    <style>
        body {
            font-family: 'Poppins', sans-serif;
        }
    </style>
</head>
<body>
    <div class="container-xxl">
        <div class="authentication-wrapper authentication-basic container-p-y">
            <div class="authentication-inner">
                <div class="card">
                    <div class="card-body">
                        <center>
                            <div class="justify-content-center">
                                <a class=" gap-2" style="font-size: 30px;">
                                    <span class=" fw-bolder">Sign In</span>
                                </a>
                            </div>
                        </center>
                        <form id="formAuthentication" class="mb-3" method="POST">
                            <div class="mb-3">
                                <label for="email" class="form-label">Email</label>
                                <input type="text" class="form-control" id="email" name="email" placeholder="Enter your Email" autofocus required/>
                            </div>
                            <div class="mb-3 form-password-toggle">
                                <div class="d-flex justify-content-between">
                                    <label class="form-label" for="password">Password</label>
                                </div>
                                <div class="input-group input-group-merge">
                                    <input type="password" id="password" class="form-control" name="password" placeholder="Enter your password" required/>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label for="role" class="form-label">Select Role</label>
                                <select class="form-control" id="role" name="role" required>
                                    <option value="">Select Role</option>
                                    <option value="employee">Employee</option>
                                    <option value="student">Student</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <button class="btn btn-primary d-grid w-100" type="submit">Sign in</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
        // Ensure that the script is executed after the page is loaded
        document.addEventListener('DOMContentLoaded', function () {
            <?php if ($result->num_rows == 0 || !password_verify($password, $row['password'])): ?>
                Swal.fire({
                    icon: 'error',
                    title: 'Invalid Credentials',
                    text: 'Invalid email or password. Please try again.',
                });
            <?php endif; ?>
        });
    </script>
</body>
</html>
