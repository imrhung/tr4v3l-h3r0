<?php
require_once 'access.inc.php';
if(!loggedIn()) {
	include 'login.inc.php';
	exit;
}