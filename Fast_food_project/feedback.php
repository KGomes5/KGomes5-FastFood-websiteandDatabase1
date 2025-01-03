<?php
session_start();
include 'includes/db.php';

if (!isset($_SESSION["customerID"])) {
    header("Location: login.php");
    exit();
}

$customerID = $_SESSION["customerID"];

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $orderID = $_POST["orderID"];
    $rating = $_POST["rating"];
    $comment = $_POST["comment"];

    $stmt = $conn->prepare("INSERT INTO feedback (customerID, orderID, rating, comment) VALUES (?, ?, ?, ?)");
    $stmt->bind_param("iiis", $customerID, $orderID, $rating, $comment);

    if ($stmt->execute()) {
        $success_message = "Thank you for your feedback!";
    } else {
        $error_message = "Error: " . $conn->error;
    }
}

// Fetch completed orders for feedback
$completedOrders = $conn->prepare("
    SELECT orderID FROM orders WHERE customerID = ? AND status = 1
");
$completedOrders->bind_param("i", $customerID);
$completedOrders->execute();
$result = $completedOrders->get_result();
?>

<!DOCTYPE html>
<html>
<head>
    <title>Feedback</title>
    <link rel="stylesheet" type="text/css" href="assets/style.css">
</head>
<body>
    <div class="container">
        <h2>Provide Feedback</h2>

        <?php if (!empty($success_message)) echo "<p style='color:green;'>$success_message</p>"; ?>
        <?php if (!empty($error_message)) echo "<p style='color:red;'>$error_message</p>"; ?>

        <form method="POST" action="">
            <label for="orderID">Select Order:</label>
            <select name="orderID" required>
                <?php while ($row = $result->fetch_assoc()): ?>
                    <option value="<?= $row['orderID'] ?>">Order #<?= $row['orderID'] ?></option>
                <?php endwhile; ?>
            </select>
            <br>

            <label for="rating">Rating (1-5):</label>
            <input type="number" name="rating" min="1" max="5" required>
            <br>

            <label for="comment">Comment:</label>
            <textarea name="comment" rows="4" cols="50"></textarea>
            <br>

            <button type="submit">Submit Feedback</button>
        </form>

        <a href="dashboard.php">Back to Dashboard</a>
    </div>
</body>
</html>
