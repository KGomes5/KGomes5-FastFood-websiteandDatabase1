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
    $itemIDs = $_POST["itemIDs"]; // Array of selected item IDs
    $quantities = $_POST["quantities"]; // Array of quantities
    $deliveryMethodID = $_POST["deliveryMethodID"];
    $locationID = $_POST["locationID"];
    $totalPrice = 0;

    // Calculate total price
    foreach ($itemIDs as $key => $itemID) {
        $stmt = $conn->prepare("SELECT price FROM menu_item WHERE itemID = ?");
        $stmt->bind_param("i", $itemID);
        $stmt->execute();
        $result = $stmt->get_result();
        $item = $result->fetch_assoc();
        $totalPrice += $item["price"] * $quantities[$key];
    }

    // Insert order
    $stmt = $conn->prepare("INSERT INTO orders (customerID, deliveryMethodID, locationID, dateTime, totalPrice, status)
                            VALUES (?, ?, ?, NOW(), ?, 0)");
    $stmt->bind_param("iiid", $customerID, $deliveryMethodID, $locationID, $totalPrice);
    $stmt->execute();
    $orderID = $conn->insert_id;

    // Insert order items
    foreach ($itemIDs as $key => $itemID) {
        $quantity = $quantities[$key];
        $stmt = $conn->prepare("INSERT INTO orderItem (orderID, itemID, quantity) VALUES (?, ?, ?)");
        $stmt->bind_param("iii", $orderID, $itemID, $quantity);
        $stmt->execute();
    }

    echo "Order placed successfully!";
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Place an Order</title>
    <link rel="stylesheet" type="text/css" href="assets/style.css">
</head>
<body>
    <div class="container">
        <h2>Place an Order</h2>
        <form method="POST" action="">
            <label>Select Items:</label>
            <?php
            $items = $conn->query("SELECT itemID, itemName, price FROM menu_item WHERE availability = 1");
            while ($row = $items->fetch_assoc()): ?>
                <div>
                    <input type="checkbox" name="itemIDs[]" value="<?= $row['itemID'] ?>">
                    <?= htmlspecialchars($row['itemName']) ?> ($<?= number_format($row['price'], 2) ?>)
                    <input type="number" name="quantities[]" min="1" value="1">
                </div>
            <?php endwhile; ?>
            <br>

            <label>Delivery Method:</label>
            <select name="deliveryMethodID" required>
                <?php
                $methods = $conn->query("SELECT * FROM delivery_method");
                while ($row = $methods->fetch_assoc()): ?>
                    <option value="<?= $row['deliveryMethodID'] ?>"><?= htmlspecialchars($row['type']) ?></option>
                <?php endwhile; ?>
            </select>
            <br>

            <label>Location:</label>
            <select name="locationID" required>
                <?php
                $locations = $conn->query("SELECT * FROM location");
                while ($row = $locations->fetch_assoc()): ?>
                    <option value="<?= $row['locationID'] ?>"><?= htmlspecialchars($row['address']) ?></option>
                <?php endwhile; ?>
            </select>
            <br>

            <button type="submit">Submit Order</button>
        </form>
    </div>
</body>
</html>
