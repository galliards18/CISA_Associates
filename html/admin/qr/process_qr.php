<?php
session_start();

// Check if user is not logged in or is not an admin
if (!isset($_SESSION['user_role']) || $_SESSION['user_role'] !== 'admin') {
    header("Location: ../choose.php"); // Redirect to login page if not logged in as admin
    exit();
}

// Include the database connection script
require '../../config.php';

// Handle QR scan and logging
if (isset($_POST['text'])) {
    $employeeId = $_POST['text'];
    $entryType = isset($_POST['entry_type']) ? $_POST['entry_type'] : '';

    if (!empty($employeeId)) {
        // Fetch employee details (name) using the employee ID
        $sql = "SELECT first_name, last_name FROM employee_registration WHERE employee_id = ?";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("i", $employeeId);
        $stmt->execute();
        $result = $stmt->get_result();
        $employee = $result->fetch_assoc();

        if ($employee) {
            // If entryType is provided, log the entry
            if ($entryType) {
                $logTime = date('Y-m-d H:i:s');
                $logSql = "INSERT INTO employee_qr_log (employee_id, entry_type, log_time) VALUES (?, ?, ?)";
                $logStmt = $conn->prepare($logSql);
                $logStmt->bind_param("iss", $employeeId, $entryType, $logTime);
                $logStmt->execute();

                // Send success response
                echo json_encode([
                    'success' => true,
                    'message' => "{$employee['first_name']} {$employee['last_name']} logged as {$entryType}."
                ]);
            } else {
                // If no entry type, return employee's name and ID for frontend
                echo json_encode([
                    'success' => true,
                    'message' => "{$employee['first_name']} {$employee['last_name']}",
                    'employee_id' => $employeeId,
                    'first_name' => $employee['first_name'],
                    'last_name' => $employee['last_name']
                ]);
            }
        } else {
            echo json_encode([
                'success' => false,
                'message' => 'Employee not found.'
            ]);
        }
    } else {
        echo json_encode([
            'success' => false,
            'message' => 'Invalid QR code data.'
        ]);
    }

    exit;
}


// Fetch today's logs
$today = date('Y-m-d');
$logSql = "SELECT employee_registration.first_name, employee_registration.last_name, 
                  employee_qr_log.entry_type, employee_qr_log.log_time
           FROM employee_qr_log
           JOIN employee_registration ON employee_qr_log.employee_id = employee_registration.employee_id
           WHERE DATE(employee_qr_log.log_time) = ?";
$logStmt = $conn->prepare($logSql);
$logStmt->bind_param("s", $today);
$logStmt->execute();
$logResult = $logStmt->get_result();

// Prepare the logs array
$logs = [];
while ($logRow = $logResult->fetch_assoc()) {
    $logs[] = [
        'employee_name' => $logRow['first_name'] . ' ' . $logRow['last_name'],
        'entry_type' => $logRow['entry_type'],
        'log_time' => $logRow['log_time']
    ];
}

// Return logs as JSON
echo json_encode($logs);

// Close the database connection
$logStmt->close();
$stmt->close();
$conn->close();
?>