<?php
require_once 'config.inc.php';

session_start();

function loggedIn() {
	return isset($_SESSION['authorized']);
}

if(isset($_POST['username'])) {
	if($_POST['username'] == ADMIN_USER and $_POST['password'] == ADMIN_PASS) {
		$_SESSION['authorized'] = TRUE;
	}
}

if(isset($_REQUEST['logout'])) {
	unset($_SESSION['authorized']);
}