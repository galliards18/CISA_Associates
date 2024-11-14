<?php
session_start();

// Include configuration file for database connection
require_once('config.php');

// Initialize variables to store user input
$email = $password = $role = "";

// Function to sanitize input
function sanitize_input($data) {
    $data = trim($data);
    $data = stripslashes($data);
    $data = htmlspecialchars($data);
    return $data;
}

// Check if form is submitted
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Sanitize and store user input
    $email = sanitize_input($_POST["email"]);
    $password = sanitize_input($_POST["password"]);
    $role = sanitize_input($_POST["role"]);  // Get the selected role (Employee or Student)

    // Determine the SQL query based on the role
    if ($role == 'employee') {
        // SQL query to fetch employee details based on email
        $sql = "SELECT * FROM employee_registration WHERE email = ?";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("s", $email);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows == 1) {
            $row = $result->fetch_assoc();
            if (password_verify($password, $row['password'])) {
                $_SESSION['employee_id'] = $row['employee_id'];

                if ($row['is_admin'] == 1) {
                    $_SESSION['user_role'] = 'admin';
                    echo "<script>Swal.fire('Success', 'Admin login successful. Redirecting...', 'success');</script>";
                    header("refresh:2;url=admin/dashboard.php");
                    exit();
                } else {
                    $_SESSION['user_role'] = 'employee';
                    echo "<script>Swal.fire('Success', 'Employee login successful. Redirecting...', 'success');</script>";
                    header("refresh:2;url=employee/dashboard.php");
                    exit();
                }
            } else {
                echo "<script>Swal.fire('Error', 'Invalid password. Please try again.', 'error');</script>";
            }
        } else {
            echo "<script>Swal.fire('Error', 'Invalid email. Please try again.', 'error');</script>";
        }
    } elseif ($role == 'student') {
        // SQL query to fetch student details based on email
        $sql = "SELECT * FROM student_registration WHERE email = ?";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("s", $email);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows == 1) {
            $row = $result->fetch_assoc();
            if (password_verify($password, $row['password'])) {
                $_SESSION['student_id'] = $row['student_id'];
                $_SESSION['user_role'] = 'student';
                echo "<script>Swal.fire('Success', 'Student login successful. Redirecting...', 'success');</script>";
                header("refresh:2;url=student/dashboard.php");
                exit();
            } else {
                echo "<script>Swal.fire('Error', 'Invalid password. Please try again.', 'error');</script>";
            }
        } else {
            echo "<script>Swal.fire('Error', 'Invalid email. Please try again.', 'error');</script>";
        }
    } else {
        echo "<script>Swal.fire('Error', 'Please select a valid role.', 'error');</script>";
    }

    // Close statement and connection
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
