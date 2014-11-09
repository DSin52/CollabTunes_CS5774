<?php

require_once '../global.php';

$id = $_POST['id'];
Album::deleteComment(intval($id));

?>