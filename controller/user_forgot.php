<?php
require_once '../global.php';

if (User::userExists("email", $_POST['email'])) {
	echo 'test';
	echo mail($_POST['email'], "CollabTunes Password Reset", "Password is: ", "From: dsingh5270@gmail.com");
} else {
	echo "blah";
}

?>