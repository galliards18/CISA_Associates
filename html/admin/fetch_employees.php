<?php
include '../config.php'; // Make sure this file contains your DB connection code

// Function to sanitize input
function sanitize_input($data) {
    $data = trim($data);
    $data = stripslashes($data);
    $data = htmlspecialchars($data);
    return $data;
}

if (isset($_GET['department']) && !empty($_GET['department'])) {
    $selected_department = $_GET['department'];

    // Fetch employees based on the selected department
    $sql = "SELECT e.employee_id, e.first_name, e.last_name, e.is_assigned_department 
            FROM employee_registration e
            WHERE e.department = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("s", $selected_department);
    $stmt->execute();
    $result = $stmt->get_result();

    echo "<div class='mt-3'><h5>Employees in $selected_department Department:</h5><ul>";
    while ($row = $result->fetch_assoc()) {
        $assigned = $row['is_assigned_department'] == 1 ? ' (Already Assigned)' : '';
        $disabled = $row['is_assigned_department'] == 1 ? 'disabled' : '';
        echo "<li>
                <input type='radio' name='employee_id' value='" . htmlspecialchars($row['employee_id']) . "' $disabled>
                " . htmlspecialchars($row['first_name']) . " " . htmlspecialchars($row['last_name']) . $assigned . "
              </li>";
    }
    echo "</ul></div>";

    $stmt->close();
}
?>