<?php
require_once '../global.php';

$promoteUser = $_POST['promote'];

User::promoteUser($promoteUser);

?>