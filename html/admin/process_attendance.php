<?php
session_start();

// Check if user is not logged in or is not an admin
if (!isset($_SESSION['user_role']) || $_SESSION['user_role'] !== 'admin') {
    // Return error response if not authorized
    echo json_encode(array('status' => 'error', 'message' => 'Unauthorized access'));
    exit();
}

// Include the database connection script
require '../config.php';

// Function to sanitize input data (optional based on your needs)
function sanitize_input($data) {
    $data = trim($data);            // Remove leading/trailing whitespace
    $data = stripslashes($data);    // Remove backslashes
    $data = htmlspecialchars($data);// Convert special characters to HTML entities
    return $data;
}

// Function to get flag id based on current day
function getFlagIdByDayOfWeek() {
    $dayOfWeek = date('N'); // Get numeric representation of the day (1 = Monday, 5 = Friday)
    
    // Define flag_id based on day of the week
    switch ($dayOfWeek) {
        case 1: // Monday
        case 2: // Tuesday
        case 3: // Wednesday
        case 4: // Thursday
        case 6: // Saturday
        case 7: // Sunday
            return 1;
        case 5: // Friday
            return 2;
        default:
            return null; // Return null for unexpected cases
    }
}

// Check if required POST data is received
if (isset($_POST['employee_id'], $_POST['attendance_status'])) {
    // Sanitize input data
    $employeeId = sanitize_input($_POST['employee_id']);
    $attendanceStatus = sanitize_input($_POST['attendance_status']);
    $flagId = getFlagIdByDayOfWeek(); // Get flag_id dynamically based on day of the week
    
    // Validate attendance status (you can add more validation as needed)
    if (!in_array($attendanceStatus, ['present', 'late', 'absent']) || !is_numeric($employeeId) || $flagId === null) {
        echo json_encode(array('status' => 'error', 'message' => 'Invalid data received'));
        exit();
    }

    try {
        // Check if there's an existing record for today's date
        $checkSql = "SELECT * FROM employee_attendance_flag WHERE employee_id = ? AND DATE(attendance_date) = CURDATE()";
        $checkStmt = $conn->prepare($checkSql);
        $checkStmt->bind_param("i", $employeeId);
        $checkStmt->execute();
        $checkResult = $checkStmt->get_result();

        if ($checkResult->num_rows > 0) {
            // Update existing record
            $updateSql = "UPDATE employee_attendance_flag SET attendance_status = ?, flag_id = ? WHERE employee_id = ? AND DATE(attendance_date) = CURDATE()";
            $updateStmt = $conn->prepare($updateSql);
            $updateStmt->bind_param("sii", $attendanceStatus, $flagId, $employeeId);
            $updateStmt->execute();

            if ($updateStmt->affected_rows > 0) {
                echo json_encode(array('status' => 'success', 'message' => 'Attendance updated successfully'));
            } else {
                echo json_encode(array('status' => 'error', 'message' => 'Failed to update attendance'));
            }
        } else {
            // Insert new record
            $insertSql = "INSERT INTO employee_attendance_flag (employee_id, attendance_date, attendance_status, flag_id) VALUES (?, NOW(), ?, ?)";
            $insertStmt = $conn->prepare($insertSql);
            $insertStmt->bind_param("iss", $employeeId, $attendanceStatus, $flagId);
            $insertStmt->execute();

            if ($insertStmt->affected_rows > 0) {
                echo json_encode(array('status' => 'success', 'message' => 'Attendance marked successfully'));
            } else {
                echo json_encode(array('status' => 'error', 'message' => 'Failed to mark attendance'));
            }
        }
    } catch (Exception $e) {
        echo json_encode(array('status' => 'error', 'message' => 'Database error: ' . $e->getMessage()));
    }
} else {
    echo json_encode(array('status' => 'error', 'message' => 'Incomplete data received'));
}
?>
