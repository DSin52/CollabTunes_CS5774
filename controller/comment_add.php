<?php

require_once '../global.php';

$album_owner = $_POST['album_owner'];
$album_name = urldecode($_POST['album_name']);
$currentCommenter = $_SESSION['username'];
$comment = $_POST['comment'];
$timeStamp = date("Y-m-d H:i:s");

$id = Album::comment($album_name, $album_owner, $comment, $currentCommenter, $timeStamp);

$eventProperties = [
    'event_type' => 'add_comment',
    'username' => $currentCommenter,
    'data' => $id,
    'album_name' => $album_name
];

$e = new Event($eventProperties);
$e->save();

?>