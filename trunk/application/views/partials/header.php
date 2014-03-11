<div class="navbar navbar-nav" role="navigation">
    <div class="container">
        <div class="collapse navbar-collapse">
            <ul class="nav navbar-nav side-nav">
                <li><div class="navbar-pad-left nav-header header-image"><a class="navbar-brand" href="<?php echo site_url('organization/index') ?>">
                        <input type="image"  src="<?php echo base_url() ?>assets/img/ngo_logo.jpg"/>
                    </a></div></li>
                    <br>
                    <hr class="hr-light-blue">
                
                <!-- Create button -->
                <li class="<?php echo ($current_section == 'quiz') ? 'active' : '' ?>"><a href="<?php echo site_url('organization/create_quiz') ?>"><i class="fa fa-question-circle"></i>  Create Quiz</a></li>
                <li class="<?php echo ($current_section == 'activity') ? 'active' : '' ?>"><a href="<?php echo site_url('organization/create_activity') ?>"><i class="fa fa-fire"></i>  Create Activity</a></li>
                <li class="<?php echo ($current_section == 'donation') ? 'active' : '' ?>"><a href="<?php echo site_url('organization/create_donation') ?>"><i class="fa fa-heart"></i>  Create Donation</a></li>
                
                <!-- Management button -->
                <li class="<?php echo ($current_section == 'home') ? 'active' : '' ?>"><a id="base-url" href="<?php echo site_url('') ?>"><i class="fa fa-home"></i>  Home</a></li>
                <li class="<?php echo ($current_section == 'profile') ? 'active' : '' ?>"><a href="<?php echo site_url('organization/partnerform') ?>"><i class="fa fa-pencil"></i>  Edit profile</a></li>
                <li class="<?php echo ($current_section == 'noti') ? 'active' : '' ?>"><a href="<?php echo site_url('organization/index') ?>"><i class="fa fa-bell"></i><span class="badge pull-right badge-green">4</span>  Notifications</a></li>
                <li class="<?php echo ($current_section == 'stat') ? 'active' : '' ?>"><a href="<?php echo site_url('organization/index') ?>"><i class="fa fa-bar-chart-o"></i></span>  Statistics</a></li>
                
            </ul>
            
            <!-- Buttom button -->
            <ul class="nav navbar-nav side-nav bottom-left-nav">
                <li class="<?php echo ($current_section == 'help') ? 'active' : '' ?>"><a href="<?php echo site_url('organization/index') ?>"><i class="fa fa-shield"></i>  Help me!</a></li>
                <li class="<?php echo ($current_section == 'signout') ? 'active' : '' ?>"><a href="<?php echo site_url('organization/index') ?>"><i class="fa fa-power-off"></i>  Sign me out</a></li>
            </ul>
        </div>
    </div>
</div>
<div id="watermark">
    
</div>
