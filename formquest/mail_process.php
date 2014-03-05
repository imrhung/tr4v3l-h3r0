<?php

$data='Organization info: ';/*
foreach($_POST as $val){
	$data .= $val;
}
*/
if(@mail('truongquang.hau93@gmail.com', 'Form Partner Email', 'Test', 'hauquangtruong@gmail.com')) 
	echo 'OK';
else
	echo 'Error';

