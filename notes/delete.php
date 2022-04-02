<?php
 include "../connect.php";
 
 $noteid = filterRequest('id');



 $stmt = $con->prepare("DELETE FROM notes WHERE notes_id =?");

 $stmt->execute(array($noteid));

 $count = $stmt->rowCount();
 if($count > 0){
    echo json_encode(array("status"=>"success"));
 }else{
    echo json_encode(array("status"=>"error"));
 }