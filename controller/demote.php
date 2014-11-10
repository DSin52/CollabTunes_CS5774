<?php
require_once '../global.php';

$demoteUser = $_POST['demote'];

User::demoteUser($demoteUser);

echo 'test';
?>