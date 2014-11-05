<?php

require_once '../global.php';
$uploads_dir = '../uploads';

//Gets all the albums associated with the user
$albums = Album::getAlbums("album_owner", $_SESSION['username']);

//Deletes the user's albums, files and artwork from the server
foreach ($albums as $a) {
	Album::deleteAlbum($a["album_name"], $_SESSION['username']);
	$artwork_path = $uploads_dir . "/" . $_SESSION['username'] . "_" . $a['album_name'] . ".jpg";
	unlink($artwork_path);
}

//Deletes the user from the database
$curUser = User::deleteUser("username", $_SESSION['username']);

//Logs off user on success
if ($curUser == null) {
	$_SESSION['error'] = "Error in deleteing user!";
} else {
	require_once './user_logoff.php';
}

?>