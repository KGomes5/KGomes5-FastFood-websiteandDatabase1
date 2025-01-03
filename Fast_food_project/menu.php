<?php
// Enable error reporting for debugging
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

session_start();
include 'includes/db.php';

// Fetch menu items
$result = $conn->query("SELECT m.menuName, mi.itemName, mi.description, mi.price, mi.availability
                        FROM menu m
                        JOIN menu_item mi ON m.menuID = mi.menuID");
?>

<!DOCTYPE html>
<html>
<head>
    <title>Menu</title>
    <link rel="stylesheet" type="text/css" href="assets/style.css">
</head>
<body>
    <div class="container">
        <h2>Menu</h2>
        <?php if ($result->num_rows > 0): ?>
            <ul>
                <?php while ($row = $result->fetch_assoc()): ?>
                    <li>
                        <h3><?= htmlspecialchars($row["itemName"]) ?> (<?= htmlspecialchars($row["menuName"]) ?>)</h3>
                        <p><?= htmlspecialchars($row["description"]) ?></p>
                        <p>Price: $<?= number_format($row["price"], 2) ?></p>
                        <p>Status: <?= $row["availability"] ? "Available" : "Out of Stock" ?></p>
                    </li>
                <?php endwhile; ?>
            </ul>
        <?php else: ?>
            <p>No items found in the menu.</p>
        <?php endif; ?>
    </div>
</body>
</html>
