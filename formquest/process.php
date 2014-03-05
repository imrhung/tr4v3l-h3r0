<?php
$donateUrl = mysql_real_escape_string($_POST['donateUrl']);
$image_url = mysql_real_escape_string($_POST['photoUrl']);

$con=mysqli_connect("127.0.0.1","user_hau","123456","travel_hero");
if (mysqli_connect_errno()) 
	echo 'Could not connect: ' . mysqli_connect_error();

$query_string = "INSERT INTO `travel_hero`.`quest_temp`(`name`, `description`, `latitude`, `longitude`, `parent_quest_id`, `image_url`, `address`, `points`, `donate_url`) VALUES ('" . $_POST['questName'] . "','" . $_POST['questDescription'] . "'," . $_POST['latitude'] . "," . $_POST['longitude'] . "," . $_POST['parentQuest'] . ",'" . $image_url . "','" . $_POST['address'] . "'," . $_POST['questPoint'] . ",'" . $donateUrl . "')";

if(mysqli_query($con, $query_string) OR die(mysql_error()))
	echo 'OK';
else
	echo 'BAD';
mysqli_close($con);