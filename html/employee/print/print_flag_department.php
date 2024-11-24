<?php
session_start();

// Check if user is not logged in or is not an employee
if (!isset($_SESSION['user_role']) || $_SESSION['user_role'] !== 'employee') {
    header("Location: ../choose.php"); // Redirect to login page if not logged in as employee
    exit();
}

// Include the database connection script
require '../../config.php';

// Get the logged-in employee's ID and department from the session
$employee_id = $_SESSION['employee_id']; // Assuming employee_id is stored in the session

// Initialize variables
$date_filter = date("Y-m-d"); // Default to today's date
$time_filter = 'daily'; // Default time filter
$flag_type_filter = ''; // No default for flag type
$view_filter = 'own'; // Default to viewing own information
$attendance_data = [];

// Fetch all available flag types for the dropdown
$flag_types_query = "SELECT flag_id, flag_type FROM flag_type";
$flag_types_result = $conn->query($flag_types_query);
$flag_types = $flag_types_result->num_rows > 0 ? $flag_types_result->fetch_all(MYSQLI_ASSOC) : [];

// Check if the form has been submitted
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Retrieve and sanitize input values
    $date_filter = $_POST['date_filter'] ?? date("Y-m-d");
    $time_filter = $_POST['time_filter'] ?? 'daily';
    $flag_type_filter = $_POST['flag_type'] ?? '';
    $view_filter = $_POST['view_filter'] ?? 'own';

    // Determine the date range based on the time filter
    $start_date = $date_filter;
    $end_date = $date_filter;

    if ($time_filter === 'weekly') {
        $start_date = date('Y-m-d', strtotime('last Sunday', strtotime($date_filter)));
        $end_date = date('Y-m-d', strtotime('next Saturday', strtotime($date_filter)));
    } elseif ($time_filter === 'monthly') {
        $start_date = date('Y-m-01', strtotime($date_filter));
        $end_date = date('Y-m-t', strtotime($date_filter));
    } elseif ($time_filter === 'yearly') {
        $start_date = date('Y-01-01', strtotime($date_filter));
        $end_date = date('Y-12-31', strtotime($date_filter));
    }

    // Start constructing the query
    $query = "SELECT er.first_name, er.last_name, eaf.attendance_date, eaf.attendance_status, ft.flag_type
              FROM employee_attendance_department AS eaf
              LEFT JOIN flag_type AS ft ON eaf.flag_id = ft.flag_id
              LEFT JOIN employee_registration AS er ON eaf.employee_id = er.employee_id
              WHERE eaf.attendance_date BETWEEN ? AND ?";

    // Array to hold bind types and parameters
    $bind_types = "ss"; // Start with date parameters
    $bind_params = [$start_date, $end_date];

    // Add filters based on `view_filter`
    if ($view_filter === 'own') {
        $query .= " AND eaf.employee_id = ?";
        $bind_types .= "i";
        $bind_params[] = $employee_id;
    } elseif ($view_filter === 'department') {
        // Add department filter from the employee_registration table
        $query .= " AND er.department = (SELECT department FROM employee_registration WHERE employee_id = ?)";
        $bind_types .= "i";
        $bind_params[] = $employee_id; // Use the employee's ID to get the department
    }

    // Add flag type filter if specified
    if ($flag_type_filter) {
        $query .= " AND ft.flag_id = ?";
        $bind_types .= "i";
        $bind_params[] = $flag_type_filter;
    }

    $query .= " ORDER BY eaf.attendance_date ASC";

    // Prepare the statement
    $stmt = $conn->prepare($query);
    if ($stmt === false) {
        die("Error preparing the statement: " . $conn->error);
    }

    // Bind parameters dynamically
    $stmt->bind_param($bind_types, ...$bind_params);

    // Execute the query
    $stmt->execute();
    $result = $stmt->get_result();

    // Fetch all the results into an array
    $attendance_data = $result->num_rows > 0 ? $result->fetch_all(MYSQLI_ASSOC) : [];
}
?>



<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Attendance Monitoring System - Print Attendance</title>
    <!-- Favicon -->
    <link rel="icon" type="image/x-icon" href="../../assets/img/favicon/favicon.ico" />
    <!-- Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet" />
    <!-- Icons -->
    <link rel="stylesheet" href="../../assets/vendor/fonts/boxicons.css" />
    <!-- Core CSS -->
    <link rel="stylesheet" href="../../assets/vendor/css/core.css" />
    <link rel="stylesheet" href="../../assets/vendor/css/theme-default.css" />
    <link rel="stylesheet" href="../../assets/css/demo.css" />
    <!-- Page CSS -->
    <!-- Helpers -->
    <script src="../../assets/vendor/js/helpers.js"></script>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            font-size: 16pt;
            margin: 0;
            padding: 0;
        }

        .header {
            display: flex;
            justify-content: center; /* Center horizontally */
            align-items: center; /* Center vertically */
            height: 150px; /* Adjust height as needed */
            padding: 10px;
            width: 100%; /* Ensure the header takes the full width */
            box-sizing: border-box; /* Include padding in the width */
            position: relative; /* Needed for absolute positioning of children */
        }

        .logo-left {
            position: absolute; /* Position the logo relative to the header */
            top: 0;
            left: 50px; /* Move the image 50px to the left */
            max-height: 150px; /* Set a maximum height if needed */
            object-fit: cover; /* Cover the full width while maintaining aspect ratio */
            object-position: center; /* Center the image */
        }

        .logo-right {
            position: absolute; /* Position the logo relative to the header */
            top: 0;
            right: 90px;
            height: 50px;
            margin-top: 10px;
        }

        .content-wrapper {
            text-align: center;
        }

        .print-btn-container {
            text-align: right;
            margin-bottom: 20px;
        }

        .print-btn {
            background-color: #007bff;
            color: #fff;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            border-radius: 5px;
            font-size: 14px;
        }

        .print-btn:hover {
            background-color: #0056b3;
        }

        .back-btn {
            background-color: #dc3545;
            color: #fff;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            border-radius: 5px;
            font-size: 14px;
            text-decoration: none;
        }

        .back-btn:hover {
            background-color: #c82333;
        }

        .table-container {
            margin-top: 10px;
            text-align: center;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            text-align: center;
        }

        th, td {
            padding: 4px;
            border: 1px solid #ddd;
            font-size: 8pt;
        }

        .search-panel {
            margin-bottom: 20px;
        }

        .search-panel input[type="date"],
        .search-panel input[type="text"],
        .search-panel select {
            padding: 8px;
            font-size: 14px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        .search-panel button {
            background-color: #28a745;
            color: #fff;
            border: none;
            padding: 8px 16px;
            cursor: pointer;
            border-radius: 5px;
            font-size: 14px;
        }

        .search-panel button:hover {
            background-color: #218838;
        }

        @media print {
            .print-btn-container,
            .search-panel {
                display: none;
            }
            .table-container {
                margin-top: 0;
            }
            .header {
                height: auto;
                text-align: center;
            }
            .logo-left {
                position: static;
                display: block;
                margin: 0 auto;
            }
        }
        
        @media print and (orientation: landscape) {
            .header {
                height: auto;
            }
            .logo-left {
                position: static;
                display: block;
                margin: 0 auto;
            }
        }
    </style>
    <link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Serif:wght@400;500;600&display=swap" rel="stylesheet">
</head>
<body>
    <div class="header">
        <img src="../../../assets/img/avatars/template.png" alt="Logo" class="logo-left">
    </div>

    <div class="print-btn-container">
        <center>
            <a href="../dashboard.php" class="back-btn">Back to Dashboard</a>
            <button class="print-btn" onclick="window.print()">Print</button>
        </center>
    </div>

    <div class="content-wrapper">
        <!-- Search panel form -->
        <div class="search-panel">
            <form method="POST" action="">
                <label for="date_filter">Date:</label>
                <input type="date" id="date_filter" name="date_filter" value="<?php echo $date_filter; ?>">

                <label for="time_filter">Time Filter:</label>
                <select id="time_filter" name="time_filter">
                    <option value="daily" <?php echo $time_filter === 'daily' ? 'selected' : ''; ?>>Daily</option>
                    <option value="weekly" <?php echo $time_filter === 'weekly' ? 'selected' : ''; ?>>Weekly</option>
                    <option value="monthly" <?php echo $time_filter === 'monthly' ? 'selected' : ''; ?>>Monthly</option>
                    <option value="yearly" <?php echo $time_filter === 'yearly' ? 'selected' : ''; ?>>Yearly</option>
                </select>

                <label for="flag_type">Flag Type:</label>
                <select id="flag_type" name="flag_type">
                    <option value="">All</option>
                    <?php foreach ($flag_types as $flag): ?>
                        <option value="<?php echo $flag['flag_id']; ?>" <?php echo $flag_type_filter == $flag['flag_id'] ? 'selected' : ''; ?>>
                            <?php echo $flag['flag_type']; ?>
                        </option>
                    <?php endforeach; ?>
                </select>

                <label for="view_filter">View:</label>
                <select id="view_filter" name="view_filter">
                    <option value="own" <?php echo $view_filter === 'own' ? 'selected' : ''; ?>>My Information</option>
                    <option value="department" <?php echo $view_filter === 'department' ? 'selected' : ''; ?>>Same Department</option>
                </select>

                <button type="submit">Filter</button>
            </form>
        </div>

        <div class="table-container">
            <?php if (!empty($attendance_data)) : ?>
                <table>
                    <thead>
                        <tr>
                            <th>First Name</th>
                            <th>Last Name</th>
                            <th>Attendance Date</th>
                            <th>Attendance Status</th>
                            <th>Flag Type</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php foreach ($attendance_data as $row) : ?>
                            <tr>
                                <td><?php echo htmlspecialchars($row['first_name']); ?></td>
                                <td><?php echo htmlspecialchars($row['last_name']); ?></td>
                                <td><?php echo htmlspecialchars($row['attendance_date']); ?></td>
                                <td><?php echo htmlspecialchars($row['attendance_status']); ?></td>
                                <td><?php echo htmlspecialchars($row['flag_type']); ?></td>
                            </tr>
                        <?php endforeach; ?>
                    </tbody>
                </table>
            <?php else : ?>
                <p class="no-data">No attendance data found for the selected date.</p>
            <?php endif; ?>
        </div>
    </div>
</body>
</html>
