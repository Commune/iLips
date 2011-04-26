<html>
<head>
<title>eCLIP Daily LIPS Patient Manager</title>
<style type="text/css">
table {
	text-align:center; 	
	border-collapse:collapse;
}
th {
	border:1px solid black;
	font-weight:700;
}
td {
	border:1px solid black;
	padding:2px;
}
.row0 {
	background-color:#DDDDFF;
}
.row1 {
	background-color:#FFFFFF;
}
</style>

</head>
<body>


<?php
include "dbconnect.php";

$query = "select id,day,score,time from $table order by time asc";
$result = mysql_query($query);

$patientLatestUpdateTimes = array();
$patientLatestScores = array();
$patientNumberOfScores = array();
$patientLatestDays = array();

while($row = mysql_fetch_array($result)) {
	$id = $row['id'];
	$patientNumberOfScores[$id]++;
	$patientLatestUpdateTimes[$id] = $row['time'];
	$patientLatestScores[$id] = $row['score'];
	$patientLatestDays[$id] = $row['day'];
}
?>
<form method="POST" action="deletepatients.php">
<table>
<tr>
<th>Patient ID</th>
<th>Latest Score</th>
<th>Day</th>
<th>Number of Updates</th>
<th>Last Updated</th>
<th>Delete Patient</th>
</tr>

<?php
if($patientNumberOfScores==array()) {
	echo "<tr><td colspan='6'>No patients are stored yet.</td></tr>";
}
$rowtype = 0;
foreach(array_keys($patientNumberOfScores) as $patient) {
	echo "<tr class='row$rowtype'><td>$patient</td>";
	echo "<td>{$patientLatestScores[$patient]}</td>";
	echo "<td>{$patientLatestDays[$patient]}</td>";
	echo "<td>{$patientNumberOfScores[$patient]}</td>";
	echo "<td>{$patientLatestUpdateTimes[$patient]}</td>";
	echo "<td><input type='checkbox' name='$patient'></td></tr>";
	$rowtype = 1-$rowtype;
}
?>
</table>
<input type="submit" value="Delete Selected Patients">
</form>
</body>