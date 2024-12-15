<?php
session_start();

// Ensure no redirect happens before this point
if (!isset($_SESSION['user_role']) || $_SESSION['user_role'] !== 'admin') {
    header("Location: ../../choose.php");
    exit();
}

// Include the database connection script
require '../../config.php';

// Initialize response variables
$response = ['success' => false, 'message' => '']; // Default response

// Handle QR code scanning and attendance marking
if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['text'])) {
    // Sanitize the scanned QR code input
    $employee_id = sanitize_input($_POST['text']);

    // Check if the employee_id exists in the employee_registration table
    $sql = "SELECT employee_id, first_name, last_name FROM employee_registration WHERE employee_id = ?";
    if ($stmt = $conn->prepare($sql)) {
        $stmt->bind_param("i", $employee_id);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows > 0) {
            // Employee exists, proceed with attendance marking
            $employee = $result->fetch_assoc();
            $first_name = $employee['first_name'];
            $last_name = $employee['last_name'];

            // Check the last attendance entry for the employee
            $sql = "SELECT entry_type FROM employee_attendance_gate WHERE employee_id = ? ORDER BY entry_time DESC LIMIT 1";
            if ($stmt2 = $conn->prepare($sql)) {
                $stmt2->bind_param("i", $employee_id);
                $stmt2->execute();
                $result2 = $stmt2->get_result();
                $last_entry = $result2->fetch_assoc();

                // Determine entry type (auto-toggle between 'in' and 'out')
                $entry_type = 'in'; // Default to 'in'
                if ($last_entry && $last_entry['entry_type'] == 'in') {
                    $entry_type = 'out';
                }

                // Insert the new attendance record
                $attendance_status = ($entry_type == 'in') ? 1 : 2; // 1 for marked_in, 2 for marked_out
                $description = ($entry_type == 'in') ? 'Marked In via QR' : 'Marked Out via QR';

                $sql = "INSERT INTO employee_attendance_gate (employee_id, entry_time, entry_type, description, attendance_status) 
                        VALUES (?, NOW(), ?, ?, ?)";
                if ($stmt3 = $conn->prepare($sql)) {
                    $stmt3->bind_param("isss", $employee_id, $entry_type, $description, $attendance_status);
                    if ($stmt3->execute()) {
                        $response['success'] = true;
                        $response['message'] = "Attendance for {$first_name} {$last_name} marked successfully: " . ucfirst($entry_type);
                    } else {
                        $response['message'] = "Error marking attendance. Please try again.";
                    }
                    $stmt3->close();
                } else {
                    $response['message'] = "Error preparing attendance insert statement.";
                }

                $stmt2->close();
            } else {
                $response['message'] = "Error preparing last entry query.";
            }

        } else {
            // Employee ID does not exist in the employee_registration table
            $response['message'] = "Invalid Employee ID. Please scan a valid employee QR code.";
        }

        $stmt->close();
    } else {
        $response['message'] = "Error preparing employee select statement.";
    }
} else {
    $response['message'] = "No data received or invalid POST request.";
}

// Function to sanitize input data
function sanitize_input($data) {
    $data = trim($data);            // Remove leading/trailing whitespace
    $data = stripslashes($data);    // Remove backslashes
    $data = htmlspecialchars($data);// Convert special characters to HTML entities
    return $data;
}

// Close the database connection
$conn->close();

// Return response as JSON
echo json_encode($response);
?>
