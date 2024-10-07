<?php
include '../config.php';

$employee_id = $_GET['employee_id'];

mysqli_query($conn, 'SET FOREIGN_KEY_CHECKS = 0');

$sql = "DELETE FROM employee_registration WHERE employee_id=$employee_id";

if (mysqli_query($conn, $sql)) {
    header('location: employee.php');
} else {
    echo "Error deleting record: " . mysqli_error($conn);
}

mysqli_query($conn, 'SET FOREIGN_KEY_CHECKS = 1');

mysqli_close($conn);
?>
