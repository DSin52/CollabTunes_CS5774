<?php
require_once '../global.php';
//Edit the user information
if (User::editUser($_SESSION['username'], $_POST)) {
	$_SESSION['success'] = "Updated Profile!";
}

?>