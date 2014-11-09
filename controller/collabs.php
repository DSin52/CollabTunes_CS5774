<?php
require_once '../global.php';

$pageName = 'Collaborators';

$collabs = User::getCollaborators($_SESSION['username'], 2);
//$events = Event::getEvents('username', $_SESSION['username']);
//$events = array_merge(Event::getEvents('username', $_SESSION['username']), Event::getEvents('event_type', 'add_collaborator'));
require_once '../views/header.html';

require_once '../views/collabs.html';