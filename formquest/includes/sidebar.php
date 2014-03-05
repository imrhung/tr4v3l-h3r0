<!-- Collect the nav links, forms, and other content for toggling -->
<div class="collapse navbar-collapse navbar-ex1-collapse">
  <ul class="nav navbar-nav side-nav">
	<li class="active"><a href="index.php"><i class="fa fa-dashboard"></i> Dashboard</a></li>
	<li><a href="quest_form.php"><i class="fa fa-edit"></i> Quest</a></li>
	<li><a href="partner_form.php"><i class="fa fa-edit"></i> Partner</a></li>
  </ul>

  <ul class="nav navbar-nav navbar-right navbar-user">
	<li class="dropdown user-dropdown">
	  <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user"></i> John Smith <b class="caret"></b></a>
	  <ul class="dropdown-menu">
		<li><a href="#"><i class="fa fa-user"></i> Profile</a></li>
		<!--<li><a href="#"><i class="fa fa-envelope"></i> Inbox <span class="badge">7</span></a></li>-->
		<li><a href="#"><i class="fa fa-gear"></i> Settings</a></li>
		<li class="divider"></li>
		<li><a href="<?php echo $_SERVER['PHP_SELF']; ?>?logout=1"><i class="fa fa-power-off"></i> Log Out</a></li>
	  </ul>
	</li>
  </ul>
</div><!-- /.navbar-collapse -->
</nav>