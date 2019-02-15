<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<style>
table, th, td {
  border: 1px solid black;
  border-collapse: collapse;
}
th, td {
  padding: 5px;
  text-align: left;
}
</style>
</head>
<body>

<?php

$hostname = "mariadb-service";
$username = "root";
$password = "VMware1!";
$db = "nginx";

$dbconnect=mysqli_connect($hostname,$username,$password,$db);

if ($dbconnect->connect_error) {
  die("Database connection failed: " . $dbconnect->connect_error);
}

$result = $dbconnect->query("select * from web");

echo "<table style=\"width:100%\"><tr><th>Name</th><th>Description</th></tr>";

if ($result->num_rows > 0) {
    // Read the records
    while($row = $result->fetch_assoc()) {
	echo "<tr><td>".$row["name"]."</td><td>".$row["description"]."</td></tr>";
    }
}
else
    echo "No record found";

echo "</table>";

$dbconnect->close();

?>

</body>
</html>
