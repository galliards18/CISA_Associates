<?php
// Start session
session_start();

// Check if user is not logged in or is not an admin
if (!isset($_SESSION['user_role']) || $_SESSION['user_role'] !== 'admin') {
    header("Location: ../choose.php"); // Redirect to login page if not logged in as admin
    exit();
}

// Include the database connection script
require '../config.php';

// Check if form is submitted
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    
    // Retrieve form data
    $student_id = $_POST['student_id'];
    $firstname = $_POST['firstname'];
    $lastname = $_POST['lastname'];
    $email = $_POST['email'];
    $phone_number = $_POST['phone_number'];
    $department = $_POST['department'];
    $year_level = $_POST['year_level'];
    $section = $_POST['section'];
    $enrollment_date = $_POST['enrollment_date'];
    $address = $_POST['address'];
    $city = $_POST['city'];
    $postal_code = $_POST['postal_code'];
    $country = $_POST['country'];
    $date_of_birth = $_POST['date_of_birth'];
    $gender = $_POST['gender'];
    $emergency_contact_name = $_POST['emergency_contact_name'];
    $emergency_contact_number = $_POST['emergency_contact_number'];

    // Validate and sanitize input if needed
    // Example: $firstname = htmlspecialchars($firstname);

    // Update student information in the database
    $sql = "UPDATE student_registration SET 
            first_name = '$firstname', 
            last_name = '$lastname', 
            email = '$email', 
            phone_number = '$phone_number', 
            department = '$department', 
            year_level = '$year_level',
            section = '$section',
            enrollment_date = '$enrollment_date', 
            address = '$address', 
            city = '$city', 
            postal_code = '$postal_code', 
            country = '$country', 
            date_of_birth = '$date_of_birth', 
            gender = '$gender', 
            emergency_contact_name = '$emergency_contact_name', 
            emergency_contact_number = '$emergency_contact_number' 
            WHERE student_id = $student_id";

    // Execute the query
    if (mysqli_query($conn, $sql)) {
        // Redirect back to student profile page after update
        header("Location: student.php?id=$student_id");
        exit();
    } else {
        echo "Error updating record: " . mysqli_error($conn);
    }
}

// Close database connection
mysqli_close($conn);
?>
