<?php

require_once '../global.php';

$cancel_request = $_POST['collaborator'];

User::removeCollaborator($_SESSION['username'], $cancel_request);

?>