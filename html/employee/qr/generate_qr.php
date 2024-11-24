<?php
session_start();

// Check if user is not logged in or is not an employee
if (!isset($_SESSION['user_role']) || $_SESSION['user_role'] !== 'employee') {
    header("Location: ../../choose.php"); // Redirect to login page if not logged in as employee
    exit();
}

// Include the database connection script
require '../../config.php';

// Include PHP QR Code library
include('../../phpqrcode/qrlib.php');

// Get the logged-in employee's ID from the session (assuming `employee_id` is stored in the session)
$employee_id = $_SESSION['employee_id'];

// Fetch the employee email from the database (optional, but useful if needed for other purposes)
$sql = "SELECT email FROM employee_registration WHERE employee_id = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $employee_id);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows > 0) {
    $row = $result->fetch_assoc();
    $email = $row['email']; // Fetch email for potential use later

    // Generate QR code when button is clicked
    if (isset($_POST['generate_qr'])) {
        $qrDir = 'qrcodes/'; // Directory to save QR codes
        if (!file_exists($qrDir)) {
            mkdir($qrDir, 0777, true); // Create directory if it doesn't exist
        }

        $qrFilePath = $qrDir . 'employee_' . $employee_id . '.png'; // QR Code file name
        QRcode::png($employee_id, $qrFilePath, QR_ECLEVEL_L, 10); // Generate QR code with employee_id

        // Provide the download link
        $downloadLink = "<a href='$qrFilePath' download='employee_qr.png' class='btn btn-success'>Download QR Code</a>";
    }
} else {
    $errorMessage = "Employee not found.";
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Generate QR Code</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <h1>Generate QR Code</h1>
        <form method="POST">
            <button type="submit" name="generate_qr" class="btn btn-primary">Generate QR Code</button>
        </form>

        <?php if (isset($qrFilePath)): ?>
            <div class="mt-4">
                <h3>QR Code for Employee ID: <?php echo htmlspecialchars($employee_id); ?></h3>
                <img src="<?php echo $qrFilePath; ?>" alt="QR Code for Employee ID: <?php echo htmlspecialchars($employee_id); ?>" class="img-thumbnail">
            </div>
            <div class="mt-3">
                <?php echo $downloadLink; ?>
            </div>
        <?php elseif (isset($errorMessage)): ?>
            <div class="mt-4 text-danger">
                <?php echo $errorMessage; ?>
            </div>
        <?php endif; ?>

        <div class="mt-4">
            <a href="../dashboard.php" class="btn btn-danger">Back to Dashboard</a>
        </div>
    </div>
</body>
</html>
