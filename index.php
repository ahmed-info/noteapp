<?php

include "connect.php";

//$stmt = $con->prepare("SELECT * FROM users");
//$stmt->execute();
//$users = $stmt->fetchAll(PDO::FETCH_ASSOC);
//$count = $stmt->rowCount();
//print_r($users);
//print_r($count);
//echo json_encode($users);
//insert
//$stmt = $con->prepare("INSERT INTO `users`(`username`, `email`) VALUES (?,?)");
//$stmt->execute(array("yaser","yaser@gmail.com"));
// $count = $stmt->rowCount();
// if($count >0){
//     echo "success insert";
// }else{
//     echo "fail";
// }

//update
// $stmt = $con->prepare("UPDATE `users` SET `username`=?,`email`=? WHERE `id`=?");
// $stmt->execute(array("mohammed","mohammed@gmail.com",4));
// $count = $stmt->rowCount();
// if($count >0){
//     echo "success update";
// }else{
//     echo "fail";
// }

//DELETE
$stmt = $con->prepare("DELETE FROM `users` WHERE `id`=?");
$stmt->execute(array(5));
$count = $stmt->rowCount();
if($count >0){
    echo "Success Deleted";
}else{
    echo "fail";
}

