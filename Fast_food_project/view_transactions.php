<?php
session_start();
include 'includes/db.php';

// Ensure only admin can access
if (!isset($_SESSION["customerID"]) || $_SESSION["role"] !== 'admin') {
    header("Location: login.php");
    exit();
}

// Fetch transactions
$result = $conn->query("
    SELECT 
        t.transactionID, 
        o.orderID, 
        c.name AS customerName, 
        t.amount, 
        t.status, 
        t.dateTime 
    FROM transaction t
    JOIN orders o ON t.orderID = o.orderID
    JOIN customer c ON o.customerID = c.customerID
    ORDER BY t.dateTime DESC
");
?>

<!DOCTYPE html>
<html>
<head>
    <title>View Transactions</title>
</head>
<body>
    <h2>All Transactions</h2>
    <table border="1">
        <tr>
            <th>Transaction ID</th>
            <th>Order ID</th>
            <th>Customer</th>
            <th>Amount</th>
            <th>Status</th>
            <th>Date</th>
        </tr>
        <?php while ($row = $result->fetch_assoc()): ?>
            <tr>
                <td><?= htmlspecialchars($row["transactionID"]) ?></td>
                <td><?= htmlspecialchars($row["orderID"]) ?></td>
                <td><?= htmlspecialchars($row["customerName"]) ?></td>
                <td>$<?= number_format($row["amount"], 2) ?></td>
                <td><?= htmlspecialchars($row["status"]) ?></td>
                <td><?= htmlspecialchars($row["dateTime"]) ?></td>
            </tr>
        <?php endwhile; ?>
    </table>
    <a href="admin_dashboard.php">Back to Dashboard</a>
</body>
</html>
