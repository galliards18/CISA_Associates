<?php
session_start();

// Check if user is not logged in or is not an admin
if (!isset($_SESSION['user_role']) || $_SESSION['user_role'] !== 'admin') {
    header("HTTP/1.1 403 Forbidden");
    exit();
}

// Include the database connection script
require '../config.php';

// Function to sanitize input data
function sanitize_input($data) {
    // Implement your own sanitization logic here, such as:
    $data = trim($data);            // Remove leading/trailing whitespace
    $data = stripslashes($data);    // Remove backslashes
    $data = htmlspecialchars($data);// Convert special characters to HTML entities
    return $data;
}

// Check if employee_id is provided and sanitize it
if (isset($_GET['employee_id'])) {
    $employee_id = sanitize_input($_GET['employee_id']);

    // Fetch the latest attendance status for the employee
    $sql = "SELECT attendance_status FROM employee_attendance_gate WHERE employee_id = ? ORDER BY entry_time DESC LIMIT 1";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $employee_id);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        $status_row = $result->fetch_assoc();
        $attendance_status = $status_row['attendance_status'];
        // Determine and return appropriate status based on attendance_status
        if ($attendance_status == '1') {
            echo 'Marked In'; // Change this according to your status logic
        } elseif ($attendance_status == '2') {
            echo 'Marked Out'; // Change this according to your status logic
        } else {
            echo 'Unknown Status'; // Handle other statuses as needed
        }
    } else {
        echo 'No record for today'; // If no record found for the employee today
    }

    // Close statement and database connection
    $stmt->close();
    $conn->close();
} else {
    echo 'Employee ID not provided'; // Handle case where employee_id is not provided
}
?>
