<?php
// Enable error reporting for debugging
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

session_start();
include 'includes/db.php';

if (!isset($_SESSION["customerID"])) {
    header("Location: login.php");
    exit();
}

$customerID = $_SESSION["customerID"];

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $email = $_POST["email"];
    $phone = $_POST["phone"];
    $address = $_POST["address"];

    // Update customer details
    $stmt = $conn->prepare("UPDATE customer SET email = ?, phone = ?, address = ? WHERE customerID = ?");
    $stmt->bind_param("sssi", $email, $phone, $address, $customerID);

    if ($stmt->execute()) {
        header("Location: profile.php?success=1");
        exit();
    } else {
        echo "Error updating profile: " . $conn->error;
    }

    $stmt->close();
}
?>
