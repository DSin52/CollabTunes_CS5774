<?php 

require_once '../global.php';

$collabWith = $_POST['collaborator'];

$result = User::collab_request($_SESSION['username'], $collabWith);

if ($result == 1) {
    $eventProperties = [
        'event_type' => 'add_collaborator1',
        'username' => $collabWith,
        'data' => $_SESSION['username']
    ];

    $e = new Event($eventProperties);
    $e->save();
    
    $eventProperties = [
        'event_type' => 'add_collaborator2',
        'username' => $_SESSION['username'],
        'data' => $collabWith
    ];

    $e = new Event($eventProperties);
    $e->save();
}

?>