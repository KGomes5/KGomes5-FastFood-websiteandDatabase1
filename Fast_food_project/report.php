<?php
session_start();
include 'includes/db.php';

if (!isset($_SESSION["customerID"])) {
    header("Location: login.php");
    exit();
}

$customerID = $_SESSION["customerID"];

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $issueType = $_POST["issueType"];
    $description = $_POST["description"];

    $stmt = $conn->prepare("INSERT INTO report (customerID, issueType, description) VALUES (?, ?, ?)");
    $stmt->bind_param("iss", $customerID, $issueType, $description);

    if ($stmt->execute()) {
        $success_message = "Your report has been submitted.";
    } else {
        $error_message = "Error: " . $conn->error;
    }
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Report an Issue</title>
    <link rel="stylesheet" type="text/css" href="assets/style.css">
</head>
<body>
    <div class="container">
        <h2>Report an Issue</h2>

        <?php if (!empty($success_message)) echo "<p style='color:green;'>$success_message</p>"; ?>
        <?php if (!empty($error_message)) echo "<p style='color:red;'>$error_message</p>"; ?>

        <form method="POST" action="">
            <label for="issueType">Issue Type:</label>
            <select name="issueType" required>
                <option value="Order Issue">Order Issue</option>
                <option value="App Bug">App Bug</option>
                <option value="Other">Other</option>
            </select>
            <br>

            <label for="description">Description:</label>
            <textarea name="description" rows="4" cols="50" required></textarea>
            <br>

            <button type="submit">Submit Report</button>
        </form>

        <a href="dashboard.php">Back to Dashboard</a>
    </div>
</body>
</html>
