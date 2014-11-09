<?php

session_start();

// return session errors, if any
$errorMessage = '';
if(isset($_SESSION['error'])) {
    $errorMessage = $_SESSION['error'];
    unset($_SESSION['error']);
}

$successMessage = '';
if(isset($_SESSION['success'])) {
    $successMessage = $_SESSION['success'];
    unset($_SESSION['success']);
}


function renderEvent($event=null, $user) {
    if($event == null)
        echo '';
    
    if ($event['username'] == $user) {
        $username = "<a href=".SERVER_PATH.$event['username']."> You </a>";
    } else {
        $username = "<a href=".SERVER_PATH.$event['username'].">".$event['username']."</a>";
    }

    $eventType = $event['event_type'];
    switch($eventType) {
        // add comment
        case 'add_comment':
            $commentData = Album::getComment($event['data']);
            $comment = $commentData['text'];
            $album_owner = $commentData['album_owner'];
            echo '<li>';//$user/you added the comment: $data[0] to the album $data[1]
            echo $username .' added the comment "'. $comment .'" to the album "'. "<a href=".SERVER_PATH.$album_owner.'/'.str_replace(" ", "%20", $event['album_name']).">" .$event['album_name']."</a>" .'" - '. date("M j, g:i a", strtotime($event['when_happened']));
            echo '</li>';
            break;

        // add album
        case 'add_album':
            echo '<li>';//$user/you added the album: $data
            echo $username .' added the album "'. "<a href=".SERVER_PATH.$event['username'].'/'.str_replace(" ", "%20", $event['album_name']).">".$event['album_name']."</a>" .'" - '. date("M j, g:i a", strtotime($event['when_happened']));
            echo '</li>';
            break;

        //add track
        case 'add_track':
            $dataArray = explode(",", $event['album_name']);
            
            echo '<li>';//$user/you added the track: $data[0] to the album $data[1]
            echo $username . ' added the track '. $event['data'] .' to the album '. "<a href=".SERVER_PATH.$dataArray[1].'/'.str_replace(" ", "%20", $dataArray[0]).">".$dataArray[0]."</a>" .' by '. "<a href=".SERVER_PATH.$dataArray[1].">".$dataArray[1]."</a>" . ' - '. date("M j, g:i a", strtotime($event['when_happened']));
            echo '</li>';
            break;

        //added a collaborator
        case 'add_collaborator1':
            echo '<li>';//$username added $data/you as a collaborator
            echo $username .' added '. "<a href=".SERVER_PATH.$event['data'].">".$event['data']."</a>" .' as a collaborator - ' . date("M j, g:i a", strtotime($event['when_happened']));
            echo '</li>';
            break;
        
        //added as a collaborator
        case 'add_collaborator2':
            echo '<li>';//You/$user are/is collaborating with $username
            if (strpos($username, 'You') !== false) {
                echo $username .' are collaborating with '. "<a href=".SERVER_PATH.$event['data'].">".$event['data']."</a>" . ' - '  . date("M j, g:i a", strtotime($event['when_happened']));
            } else {
                echo $username .' is collaborating with '. "<a href=".SERVER_PATH.$event['data'].">".$event['data']."</a>" . ' - ' . date("M j, g:i a", strtotime($event['when_happened']));
            }
            echo '</li>';
            break;
    }
}
