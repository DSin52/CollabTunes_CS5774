<?php

require_once '../global.php';
//registers the user for creation of account
$fName = $_POST['firstname'];
$lName = $_POST['lastname'];
$email = $_POST['email'];
$username = $_POST['username'];
$password1 = $_POST['password1'];
$password2 = $_POST['password2'];
$user_type = $_POST['user_type'];

// do the passwords match?
if($password1 != $password2) {
    echo "Passwords do not match!";
    exit();
} else { //does email exist?
    if (User::userExists("email", $email)) {
        echo "Email already exists!";
        exit();
    } else if (User::userExists("username", $username)) { //does username exist?
        echo "Username already exists!";
        exit();
    } else { //Create account
        $info = array(
            'email' => $email, 
            'username'=> $username, 
            'first_name'=> $fName, 
            'last_name'=> $lName, 
            'password'=> $password1,
            'user_type'=>$user_type
            );

        $newUser = new User($info);
        $newUser->save();
        $_SESSION['success'] = "User Created!";
        exit();
    }
}