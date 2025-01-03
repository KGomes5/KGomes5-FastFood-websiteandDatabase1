<?php
session_start();
include 'includes/db.php';

// Ensure only admin can access
if (!isset($_SESSION["customerID"]) || $_SESSION["role"] !== 'admin') {
    header("Location: login.php");
    exit();
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
</head>
<body>
    <h2>Welcome to the Admin Dashboard</h2>
    <ul>
        <li><a href="view_orders.php">View Orders</a></li>
        <li><a href="view_transactions.php">View Transactions</a></li>
        <li><a href="logout.php">Logout</a></li>
    </ul>
</body>
</html>
