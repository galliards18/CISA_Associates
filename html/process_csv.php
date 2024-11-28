<?php
// Database connection
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "attendance_monitoring_system";

$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Path to the CSV file
$csvFile = "for-attendance_masterlist.csv";

// Department mapping
$department_map = [
    "BSInfoTech" => "BSInfoTech",
    "BSFi" => "BSFi",
    "BSA" => "BSA",
    "BSMB" => "BSMB",
    "BAT" => "BAT"
];

// Open the CSV file
if (($handle = fopen($csvFile, "r")) !== FALSE) {
    // Skip the header row
    fgetcsv($handle);

    // Process each row
    while (($data = fgetcsv($handle, 1000, ",")) !== FALSE) {
        // Assign CSV columns to variables
        $student_no = $data[0]; // Used for password and gender logic
        $surname = $data[1];
        $first_name = $data[2];
        $middle_name = $data[3]; // Not used but available
        $course = $data[4]; // Used to determine department
        $major = $data[5]; // Not used
        $year_level = $data[6];
        $section = $data[7];

        // Generate email using the surname
        $email = strtolower($surname) . "@gmail.com";

        // Hash the student_no to use as the password
        $hashed_password = password_hash(trim($student_no), PASSWORD_DEFAULT);

        // Map department based on the course value
        $department = isset($department_map[$course]) ? $course : NULL;

        // Determine gender based on student_no suffix
        $gender = str_ends_with($student_no, '-1') ? 'Male' : (str_ends_with($student_no, '-2') ? 'Female' : NULL);

        // Prepare the SQL statement
        $stmt = $conn->prepare("
            INSERT INTO student_registration (
                first_name, last_name, email, password, 
                department, year_level, section, gender, created_at, updated_at, is_assigned
            ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, NOW(), NOW(), 0)
        ");

        if ($stmt) {
            // Bind parameters
            $stmt->bind_param(
                "ssssssss",
                $first_name,
                $surname,
                $email,
                $hashed_password,
                $department,
                $year_level,
                $section,
                $gender
            );

            // Execute the statement
            if (!$stmt->execute()) {
                echo "Error inserting record: " . $stmt->error . "\n";
            }
        } else {
            echo "Error preparing statement: " . $conn->error . "\n";
        }
    }

    // Close the file
    fclose($handle);
} else {
    echo "Unable to open the CSV file.";
}

// Close the database connection
$conn->close();
?>
