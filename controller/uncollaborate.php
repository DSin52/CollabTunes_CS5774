<?php

require_once '../global.php';

$cancel_request = $_POST['collaborator'];

Collaborator::removeCollaborator($_SESSION['username'], $cancel_request);

Event::deleteEvent($_SESSION['username'], 'add_collaborator1', $cancel_request);
Event::deleteEvent($_SESSION['username'], 'add_collaborator2', $cancel_request);

Event::deleteEvent($cancel_request, 'add_collaborator1', $_SESSION['username']);
Event::deleteEvent($cancel_request, 'add_collaborator2', $_SESSION['username']);


?>