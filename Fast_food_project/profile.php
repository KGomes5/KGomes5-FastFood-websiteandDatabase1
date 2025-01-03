<?php
// Enable error reporting for debugging
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

session_start();
include 'includes/db.php';

// Check if user is logged in
if (!isset($_SESSION["customerID"])) {
    header("Location: login.php");
    exit();
}

$customerID = $_SESSION["customerID"];

// Fetch customer details
$stmt = $conn->prepare("SELECT name, email, phone, address FROM customer WHERE customerID = ?");
$stmt->bind_param("i", $customerID);
$stmt->execute();
$result = $stmt->get_result();
$user = $result->fetch_assoc();

$stmt->close();
?>

<!DOCTYPE html>
<html>
<head>
    <title>Profile</title>
</head>
<body>
    <h2>Welcome, <?= htmlspecialchars($user["name"]) ?></h2>
    <form method="POST" action="update_profile.php">
        <label>Email:</label>
        <input type="email" name="email" value="<?= htmlspecialchars($user["email"]) ?>" required>
        <br>
        <label>Phone:</label>
        <input type="text" name="phone" value="<?= htmlspecialchars($user["phone"]) ?>" required>
        <br>
        <label>Address:</label>
        <input type="text" name="address" value="<?= htmlspecialchars($user["address"]) ?>" required>
        <br>
        <button type="submit">Update Profile</button>
    </form>
    <a href="logout.php">Logout</a>
</body>
</html>
