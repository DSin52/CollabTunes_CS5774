<?php 

require_once '../global.php';

$collabWith = $_POST['collaborator'];

User::collab_request($_SESSION['username'], $collabWith);

?>