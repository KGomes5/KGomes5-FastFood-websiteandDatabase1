<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

session_start();
include 'includes/db.php';

// Ensure only admin can access
if (!isset($_SESSION["customerID"]) || $_SESSION["role"] !== 'admin') {
    header("Location: login.php");
    exit();
}

// Fetch orders
$result = $conn->query("
    SELECT 
        o.orderID, 
        c.name AS customerName, 
        o.dateTime, 
        o.totalPrice, 
        d.type AS deliveryMethod, 
        l.address AS location, 
        o.status 
    FROM orders o
    JOIN customer c ON o.customerID = c.customerID
    JOIN delivery_method d ON o.deliveryMethodID = d.deliveryMethodID
    JOIN location l ON o.locationID = l.locationID
    ORDER BY o.dateTime DESC
");

if (!$result) {
    die("SQL Error: " . $conn->error);
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>View Orders</title>
</head>
<body>
    <h2>All Orders</h2>
    <?php if ($result->num_rows > 0): ?>
        <table border="1">
            <tr>
                <th>Order ID</th>
                <th>Customer</th>
                <th>Date</th>
                <th>Total Price</th>
                <th>Delivery Method</th>
                <th>Location</th>
                <th>Status</th>
            </tr>
            <?php while ($row = $result->fetch_assoc()): ?>
                <tr>
                    <td><?= htmlspecialchars($row["orderID"]) ?></td>
                    <td><?= htmlspecialchars($row["customerName"]) ?></td>
                    <td><?= htmlspecialchars($row["dateTime"]) ?></td>
                    <td>$<?= number_format($row["totalPrice"], 2) ?></td>
                    <td><?= htmlspecialchars($row["deliveryMethod"]) ?></td>
                    <td><?= htmlspecialchars($row["location"]) ?></td>
                    <td><?= ($row["status"] == 0) ? "Pending" : (($row["status"] == 1) ? "Completed" : "Cancelled") ?></td>
                </tr>
            <?php endwhile; ?>
        </table>
    <?php else: ?>
        <p>No orders found.</p>
    <?php endif; ?>
    <a href="admin_dashboard.php">Back to Dashboard</a>
</body>
</html>
