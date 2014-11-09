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
        $username = "You";
    } else {
        $username = $event['username'];
    }

    $eventType = $event['event_type'];
    switch($eventType) {
        // add comment
        case 'add_comment':
            $comment = Album::getComment($event['data'])['text'];

            echo '<li>';//$user/you added the comment: $data[0] to the album $data[1]
            echo $username .' added the comment "'. $comment .'" to the album "'. $event['album_name'] .'" - '. date("M j, g:i a", strtotime($event['when_happened']));
            echo '</li>';
            break;

        // add album
        case 'add_album':
            echo '<li>';//$user/you added the album: $data
            echo $username .' added the album "'. $event['album_name'] .'" - '. date("M j, g:i a", strtotime($event['when_happened']));
            echo '</li>';
            break;

        //add track
        case 'add_track':
            $dataArray = explode(",", $event['album_name']);
            
            echo '<li>';//$user/you added the track: $data[0] to the album $data[1]
            echo $username.' added the track "'. $event['data'] .'" to the album "'. $dataArray[0] .'" by '. $dataArray[1] . '- '. date("M j, g:i a", strtotime($event['when_happened']));
            echo '</li>';
            break;

        //added a collaborator
        case 'add_collaborator1':
            echo '<li>';//$username added $data/you as a collaborator
            echo $username .' added '. $event['data'] .' as a collaborator - ' . date("M j, g:i a", strtotime($event['when_happened']));
            echo '</li>';
            break;
        
        //added as a collaborator
        case 'add_collaborator2':
            echo '<li>';//You/$user are/is collaborating with $username
            if ($username == "You") {
                echo $username .' are collaborating with '. $event['data'] . date("M j, g:i a", strtotime($event['when_happened']));
            } else {
                echo $username .' is collaborating with '. $event['data'] . date("M j, g:i a", strtotime($event['when_happened']));
            }
            echo '</li>';
            break;
    }
}
