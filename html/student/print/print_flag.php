<?php
session_start();

// Check if user is not logged in or is not a student
if (!isset($_SESSION['user_role']) || $_SESSION['user_role'] !== 'student') {
    header("Location: ../choose.php"); // Redirect to login page if not logged in as student
    exit();
}

// Include the database connection script
require '../../config.php';

// Get the logged-in student's ID
$student_id = $_SESSION['student_id']; // Assuming student_id is stored in the session

// Initialize variables
$date_filter = date("Y-m-d"); // Default to today's date
$attendance_data = [];

// Check if the form has been submitted
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Retrieve and sanitize input values
    $date_filter = $_POST['date_filter'] ?? date("Y-m-d");

    // Query to fetch attendance data for the logged-in student and the selected date
    $query = "SELECT sr.first_name, sr.last_name, eaf.attendance_date, eaf.attendance_status, ft.flag_type
            FROM student_attendance_flag AS eaf
            LEFT JOIN flag_type AS ft ON eaf.flag_id = ft.flag_id
            LEFT JOIN student_registration AS sr ON eaf.student_id = sr.student_id
            WHERE eaf.student_id = ? AND DATE(eaf.attendance_date) = ?
            ORDER BY eaf.attendance_date ASC";


    $stmt = $conn->prepare($query);
    $stmt->bind_param("is", $student_id, $date_filter);
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
            <form method="POST" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>">
                <label for="date_filter">Select Date:</label>
                <input type="date" id="date_filter" name="date_filter" value="<?php echo htmlspecialchars($date_filter); ?>" required>
                <button type="submit">Search</button>
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
