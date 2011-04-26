<?php
$server = "eclip196.db.7093929.hostedresource.com";
$dbname = "eclip196";
$username = "eclip196";
$password = "Clip196";

$table = "dailyLIPS";

mysql_connect($server,$username,$password) OR die('Couldn\'t connect <br />');
mysql_select_db($dbname);
?>