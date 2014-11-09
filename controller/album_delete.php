<?php

require_once '../global.php';
$uploads_dir = '../uploads';

$artwork_path = $uploads_dir . "/" . $_SESSION['username'] . "_" . $_POST['album_name'] . ".jpg";

//Delete the album
if (Album::deleteAlbum($_POST['album_name'], $_POST['album_owner']) !== null) {
	$_SESSION['success'] = "Album deleted";
	unlink($artwork_path);
    
//    Event::deleteEvent($_POST['album_owner'], 'add_album', $_POST['album_name']);
    
} else {
	echo "Album not found!";
}
?>