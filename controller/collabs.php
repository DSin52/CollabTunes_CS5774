<?php
require_once '../global.php';

$pageName = 'Collaborators';

$collabs = User::getCollaborators($_SESSION['username']);

require_once '../views/header.html';

require_once '../views/collabs.html';