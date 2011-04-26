<?php
include "dbconnect.php";

$qualifier = "";
foreach($_POST as $id=>$value) {
	if($value=="on") {
		$qualifier .= "id = $id OR ";
	}
}
$qualifier = substr($qualifier,0,strlen($qualifier)-4);

$query = "delete from $table where $qualifier";

mysql_query($query);

header('Location: patientmanager.php');

?>