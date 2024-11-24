<?php
session_start();

// Check if user is not logged in or is not an employee
if (!isset($_SESSION['user_role']) || $_SESSION['user_role'] !== 'employee') {
    header("Location: ../choose.php"); // Redirect to login page if not logged in as employee
    exit();
}

// Include the database connection script
require '../../config.php';

// Get the logged-in employee ID
$employee_id = $_SESSION['employee_id'] ?? null; 

if (!$employee_id) {
    die("Employee ID is missing. Please log in again.");
}

// Initialize variables
$date_filter = "";
$filter_type = "daily"; // Default filter type
$attendance_data = [];

// Check if the form has been submitted
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Retrieve and sanitize input values
    $date_filter = $_POST['date_filter'] ?? "";
    $filter_type = $_POST['filter_type'] ?? "daily";

    // Prepare SQL base query
    $query = "SELECT eag.*, er.first_name, er.last_name 
              FROM employee_attendance_gate AS eag
              LEFT JOIN employee_registration AS er ON eag.employee_id = er.employee_id
              WHERE eag.employee_id = ?"; // Restrict to logged-in employee

    // Add date filter conditions
    switch ($filter_type) {
        case 'weekly':
            $query .= " AND YEARWEEK(eag.entry_time, 1) = YEARWEEK(?, 1)";
            break;
        case 'monthly':
            $query .= " AND YEAR(eag.entry_time) = YEAR(?) AND MONTH(eag.entry_time) = MONTH(?)";
            break;
        case 'yearly':
            $query .= " AND YEAR(eag.entry_time) = YEAR(?)";
            break;
        default: // daily
            $query .= " AND DATE(eag.entry_time) = ?";
            break;
    }

    // Add order by clause to sort by entry_time in ascending order
    $query .= " ORDER BY eag.entry_time ASC";

    // Prepare and bind parameters for the query
    $stmt = $conn->prepare($query);

    if ($filter_type === 'monthly') {
        $param_types = "iss";
        $params = [$employee_id, $date_filter, $date_filter];
    } else {
        $param_types = "is";
        $params = [$employee_id, $date_filter];
    }

    $stmt->bind_param($param_types, ...$params);
    $stmt->execute();
    $result = $stmt->get_result();

    // Fetch all the results into an array
    if ($result->num_rows > 0) {
        $attendance_data = $result->fetch_all(MYSQLI_ASSOC);
    } else {
        $attendance_data = [];
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Attendance Monitoring System - Gate Attendance</title>
    <!-- CSS and Styles omitted for brevity -->
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
                justify-content: center; /* Center horizontally for printing */
                align-items: center; /* Center vertically for printing */
            }
            .logo-left {
                left: 0; /* Reset left positioning for centered alignment */
                margin: auto; /* Center the image */
                right: 0; /* Ensure it's centered horizontally */
            }
        }

        @media print and (orientation: landscape) {
            .logo-left {
                position: absolute;
                left: 50%; /* Move the image to the center */
                transform: translateX(-50%); /* Center the image */
            }
        }
    </style>
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
        <div class="search-panel" id="search-panel">
            <form method="POST" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>">
                <label for="date_filter">Select Date:</label>
                <input type="date" id="date_filter" name="date_filter" value="<?php echo htmlspecialchars($date_filter); ?>" required>
                <label for="filter_type">Filter By:</label>
                <select id="filter_type" name="filter_type">
                    <option value="daily" <?php echo ($filter_type == 'daily') ? 'selected' : ''; ?>>Daily</option>
                    <option value="weekly" <?php echo ($filter_type == 'weekly') ? 'selected' : ''; ?>>Weekly</option>
                    <option value="monthly" <?php echo ($filter_type == 'monthly') ? 'selected' : ''; ?>>Monthly</option>
                    <option value="yearly" <?php echo ($filter_type == 'yearly') ? 'selected' : ''; ?>>Yearly</option>
                </select>
                <button type="submit">Search</button>
            </form>
        </div>
      <!--   <div class="mb-1 mt-2">
            <center>
                <h4>Attendance Gate Data</h4>
                <p>Filter: <?php echo ucfirst($filter_type ?? "daily"); ?> | Selected Date: <?php echo htmlspecialchars($date_filter); ?></p>
            </center>
        </div> -->

        <?php if (!empty($attendance_data)) : ?>
            <div class="table-container">
                <table class="table">
                    <thead>
                        <tr>
                            <th>First Name</th>
                            <th>Last Name</th>
                            <th>Entry Time</th>
                            <th>Entry Type</th>
                            <th>Description</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php foreach ($attendance_data as $row) : ?>
                            <tr>
                                <td><?php echo htmlspecialchars($row['first_name']); ?></td>
                                <td><?php echo htmlspecialchars($row['last_name']); ?></td>
                                <td><?php echo htmlspecialchars($row['entry_time']); ?></td>
                                <td><?php echo htmlspecialchars($row['entry_type']); ?></td>
                                <td><?php echo htmlspecialchars($row['description']); ?></td>
                            </tr>
                        <?php endforeach; ?>
                    </tbody>
                </table>
            </div>
        <?php else : ?>
            <p>No attendance data found for the selected filters.</p>
        <?php endif; ?>
    </div>
</body>
</html>
