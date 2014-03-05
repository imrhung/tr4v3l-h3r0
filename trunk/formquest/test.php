<?php include_once 'access.inc.php' ?>
<!DOCTYPE html>
<html>
	<head>
		<title></title>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	</head>
	
	<body>
		<?php if(loggedIn()): ?>
			<p>Yor are currently logged in!<a href="<?php echo $_SERVER['PHP_SELF']; ?>?logout=1">Logout</a></p>
		<?php endif; ?>
	</body>
</html>