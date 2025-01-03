<?php
$stored_hash = '$2y$12$e6PfYc9U0s2GybJXE4G1SeQKnY9syGafDej3t7g7L3hfKN0V.XUzG'; // Replace with the hash in your database
$entered_password = 'adminpassword'; // The password you're trying to log in with

if (password_verify($entered_password, $stored_hash)) {
    echo "Password matches!";
} else {
    echo "Password does not match!";
}
?>
