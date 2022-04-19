<?php
function filterRequest($requestName){
   return htmlspecialchars(strip_tags($_POST[$requestName]));
}
//1 MB = 1024*1024 = 1048576 
// Define => const
define('MB',1048576);

//name of file requestd
function imageUpload($imageRequest)
{
   global $msgError;
   $imagename = $_FILES[$imageRequest]['name'];
   $imagetmp = $_FILES[$imageRequest]['tmp_name'];
   $imagesize = $_FILES[$imageRequest]['size'];
   $allowExt = array("jpg","png","gif","mp3","pdf");
   $strToArray = explode(".", $imagename);
   $ext = end($strToArray);
   $ext = strtolower($ext);
   if(!empty($imagename) && !in_array($ext,$allowExt)){
      $msgError[] = "EXT is Error";
   }
   if($imagesize > 10 *MB){
      $msgError[] = "Size is Error";
   }

   if(empty($msgError)){
   move_uploaded_file($imagetmp, "../upload/".$imagename);
   return $imagename;
   }else{
      return "fail";
   }
}

function deleteFile($dir, $imagename){
   if(file_exists($dir."/".$imagename)){
      unlink($dir."/".$imagename);
   }
}
?>