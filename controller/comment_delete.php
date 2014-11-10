<?php

require_once '../global.php';

$id = $_POST['id'];
Comment::deleteComment(intval($id));

?>