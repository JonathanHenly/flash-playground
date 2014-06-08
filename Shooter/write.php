<?php 

$upgrades   = $_POST['upgrades'];
$filename = $_POST['filename'];

// Strip slashes on the Local variables 
$upgrades   = stripslashes($upgrades); 

$filename = stripslashes($filename);

$file = fopen($filename, "w");
if( $file == false )
{
   echo ("WASABI!");
   exit();
}
fwrite($file, $upgrades);
fclose($file);
// Let's make sure the file exists and is writable first. 
if (is_writable($filename)) { 

    // In our example we're opening $filename in append mode. 
    // The file pointer is at the bottom of the file hence 
    // that's where $somecontent will go when we fwrite() it. 
    if (!$handle = fopen($filename, 'wb')) { 
         echo "Cannot open file ($filename)"; 
         exit; 
    } 

    // Write $somecontent to our opened file. 
    if (fwrite($handle, $upgrades) === FALSE) { 
        echo "Cannot write to file ($filename)"; 
        exit; 
    } 

    echo "Success, wrote ($upgrades) to file ($filename)"; 

    fclose($handle); 

} else { 
    echo "The file $filename is not writable, or doesn't exist"; 
} 
?> 