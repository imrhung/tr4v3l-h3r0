<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<title>Login Form</title>
	<link rel="stylesheet" href="css/login-style.css">
</head>
	
<body>
	<form action="<?php echo $_SERVER['PHP_SELF']; ?>" method="post"  class="login">
		<p>
			<label for="login">Username:</label>
			<input type="text" name="username" value="" />
		</p>

		<p>
			<label for="password">Password:</label>
			<input type="password" name="password" value="" />
		</p>

		<p class="login-submit">
			<button type="submit" class="login-button">Login</button>
		</p>

		<p class="forgot-password"><a href="index.html">Forgot your password?</a></p>
	</form>
</body>
</html>