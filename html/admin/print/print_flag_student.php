<?php
session_start();

// Check if the user is not logged in or is not an admin
if (!isset($_SESSION['user_role']) || $_SESSION['user_role'] !== 'admin') {
    header("Location: ../../choose.php");
    exit();
}

require '../../config.php';

$date_filter = "";
$filter_type = "daily";
$first_name_filter = "";
$last_name_filter = "";
$flag_type = "";
$department = "";
$section = "";
$year_level = "";
$attendance_data = [];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $date_filter = $_POST['date_filter'] ?? "";
    $filter_type = $_POST['filter_type'] ?? "daily";
    $first_name_filter = $_POST['first_name_filter'] ?? "";
    $last_name_filter = $_POST['last_name_filter'] ?? "";
    $flag_type = $_POST['flag_type'] ?? "";
    $department = $_POST['department'] ?? "";
    $section = $_POST['section'] ?? "";
    $year_level = $_POST['year_level'] ?? "";

    $query = "SELECT saf.*, sr.first_name, sr.last_name, ft.flag_type, sr.department, sr.section, sr.year_level
              FROM student_attendance_flag AS saf
              LEFT JOIN student_registration AS sr ON saf.student_id = sr.student_id
              LEFT JOIN flag_type AS ft ON saf.flag_id = ft.flag_id";

    $conditions = [];
    $params = [];
    $param_types = "";

    switch ($filter_type) {
        case 'weekly':
            $conditions[] = "YEARWEEK(saf.attendance_date, 1) = YEARWEEK(?, 1)";
            $param_types .= "s";
            $params[] = $date_filter;
            break;
        case 'monthly':
            $conditions[] = "YEAR(saf.attendance_date) = YEAR(?) AND MONTH(saf.attendance_date) = MONTH(?)";
            $param_types .= "ss";
            $params[] = $date_filter;
            $params[] = $date_filter;
            break;
        case 'yearly':
            $conditions[] = "YEAR(saf.attendance_date) = YEAR(?)";
            $param_types .= "s";
            $params[] = $date_filter;
            break;
        default:
            $conditions[] = "DATE(saf.attendance_date) = ?";
            $param_types .= "s";
            $params[] = $date_filter;
            break;
    }

    if (!empty($flag_type)) {
        $conditions[] = "ft.flag_type = ?";
        $param_types .= "s";
        $params[] = $flag_type;
    }
    if (!empty($first_name_filter)) {
        $conditions[] = "sr.first_name LIKE ?";
        $param_types .= "s";
        $params[] = "%" . $first_name_filter . "%";
    }
    if (!empty($last_name_filter)) {
        $conditions[] = "sr.last_name LIKE ?";
        $param_types .= "s";
        $params[] = "%" . $last_name_filter . "%";
    }
    if (!empty($department)) {
        $conditions[] = "sr.department = ?";
        $param_types .= "s";
        $params[] = $department;
    }
    if (!empty($section)) {
        $conditions[] = "sr.section = ?";
        $param_types .= "s";
        $params[] = $section;
    }
    if (!empty($year_level)) {
        $conditions[] = "sr.year_level = ?";
        $param_types .= "s";
        $params[] = $year_level;
    }

    if (count($conditions) > 0) {
        $query .= " WHERE " . implode(" AND ", $conditions);
    }

    $query .= " ORDER BY saf.attendance_date ASC";
    $stmt = $conn->prepare($query);

    if ($param_types) {
        $stmt->bind_param($param_types, ...$params);
    }

    $stmt->execute();
    $result = $stmt->get_result();

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
        <div class="search-panel">
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

                <label for="flag_type">Flag Type:</label>
                <select id="flag_type" name="flag_type">
                    <option value="">All</option>
                    <option value="Flag Ceremony" <?php echo ($flag_type == 'Flag Ceremony') ? 'selected' : ''; ?>>Flag Raising</option>
                    <option value="Flag Retreat" <?php echo ($flag_type == 'Flag Retreat') ? 'selected' : ''; ?>>Flag Retreat</option>
                </select>

                <label for="first_name_filter">First Name:</label>
                <input type="text" id="first_name_filter" name="first_name_filter" value="<?php echo htmlspecialchars($first_name_filter); ?>">

                <label for="last_name_filter">Last Name:</label>
                <input type="text" id="last_name_filter" name="last_name_filter" value="<?php echo htmlspecialchars($last_name_filter); ?>">

                <label for="department">Department:</label>
                <select id="department" name="department">
                    <option value="">All</option>
                    <option value="BSIT" <?php echo ($department == 'BSIT') ? 'selected' : ''; ?>>BSIT</option>
                    <option value="BSA" <?php echo ($department == 'BSA') ? 'selected' : ''; ?>>BSA</option>
                    <option value="BSFI" <?php echo ($department == 'BSFI') ? 'selected' : ''; ?>>BSFI</option>
                </select>

                <label for="section">Section:</label>
                <select id="section" name="section">
                    <option value="">All</option>
                    <option value="A" <?php echo ($section == 'A') ? 'selected' : ''; ?>>A</option>
                    <option value="B" <?php echo ($section == 'B') ? 'selected' : ''; ?>>B</option>
                    <option value="C" <?php echo ($section == 'C') ? 'selected' : ''; ?>>C</option>
                </select>

                <label for="year_level">Year Level:</label>
                <select id="year_level" name="year_level">
                    <option value="">All</option>
                    <option value="1" <?php echo ($year_level == '1') ? 'selected' : ''; ?>>1</option>
                    <option value="2" <?php echo ($year_level == '2') ? 'selected' : ''; ?>>2</option>
                    <option value="3" <?php echo ($year_level == '3') ? 'selected' : ''; ?>>3</option>
                    <option value="4" <?php echo ($year_level == '4') ? 'selected' : ''; ?>>4</option>
                </select>

                <button type="submit">Search</button>
            </form>
        </div>

        <div class="table-container">
            <?php if (!empty($attendance_data)) : ?>
                <table class="table">
                    <thead>
                        <tr>
                            <th>First Name</th>
                            <th>Last Name</th>
                            <th>Attendance Date</th>
                            <th>Flag Type</th>
                            <th>Department</th>
                            <th>Section</th>
                            <th>Year Level</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php foreach ($attendance_data as $row) : ?>
                            <tr>
                                <td><?php echo htmlspecialchars($row['first_name']); ?></td>
                                <td><?php echo htmlspecialchars($row['last_name']); ?></td>
                                <td><?php echo htmlspecialchars($row['attendance_date']); ?></td>
                                <td><?php echo htmlspecialchars($row['flag_type']); ?></td>
                                <td><?php echo htmlspecialchars($row['department']); ?></td>
                                <td><?php echo htmlspecialchars($row['section']); ?></td>
                                <td><?php echo htmlspecialchars($row['year_level']); ?></td>
                            </tr>
                        <?php endforeach; ?>
                    </tbody>
                </table>
            <?php else : ?>
                <p>No attendance data found for the selected filters.</p>
            <?php endif; ?>
        </div>
    </div>
</body>
</html>
