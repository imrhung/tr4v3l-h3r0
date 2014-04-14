<div class="navbar navbar-nav" role="navigation">
    <div class="container">
        <button type="button" class="navbar-toggle btn-primary" id="navbar-btn" data-toggle="collapse" data-target="#hero-side-nav">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>Menu
      </button>
        <div class="collapse navbar-collapse" id="hero-side-nav">
            <ul class="nav navbar-nav side-nav">
                <li><div class="navbar-pad-left nav-header header-image"><a class="navbar-brand" href="<?php echo site_url('organization/index') ?>">
                        <input type="image" alt="NGO" src="<?php echo base_url() ?>assets/img/ngo_logo.png"/>
                    </a>
                    
                    </div></li>
                    <br>
                    <hr class="hr-light-blue">
                
                <!-- Create button -->
                <li class="<?php echo ($current_section == 'quiz') ? 'active' : '' ?> list-background" id="list-background-top"><a href="<?php echo site_url('organization/create_quiz') ?>"><i class="fa fa-question-circle"></i>  Tạo câu hỏi</a></li>
                <li class="<?php echo ($current_section == 'activity') ? 'active' : '' ?> list-background"><a href="<?php echo site_url('organization/create_activity') ?>"><i class="fa fa-calendar"></i>  Tạo hoạt động</a></li>
                <li class="<?php echo ($current_section == 'donation') ? 'active' : '' ?> list-background" id="list-background-bottom"><a href="<?php echo site_url('organization/create_donation') ?>"><i class="fa fa-gift"></i>  Tạo đóng góp</a></li>
                
                <!-- Management button -->
                <li class="<?php echo ($current_section == 'home') ? 'active' : '' ?>"><a id="base-url" href="<?php echo site_url('') ?>"><i class="fa fa-home"></i>  Trang chủ</a></li>
                <li class="<?php echo ($current_section == 'profile') ? 'active' : '' ?> disable"><a href="<?php echo site_url('organization/under_construction') ?>" TITLE="Function under construction"><i class="fa fa-pencil"></i>  Hồ sơ</a></li>
                <li class="<?php echo ($current_section == 'noti') ? 'active' : '' ?>  disable"><a href="<?php echo site_url('organization/under_construction') ?>" TITLE="Function under construction"><i class="fa fa-bell"></i><span class="badge pull-right badge-green"></span>  Thông báo</a></li>
                <li class="<?php echo ($current_section == 'stat') ? 'active' : '' ?> disable"><a href="<?php echo site_url('organization/under_construction') ?>" TITLE="Function under construction"><i class="fa fa-bar-chart-o"></i></span>  Thống kê</a></li>
                
            </ul>
            
            <!-- Buttom button -->
            <ul class="nav navbar-nav side-nav bottom-left-nav">
                <li class="<?php echo ($current_section == 'help') ? 'active' : '' ?>"><a href="<?php echo site_url('organization/help') ?>"><i class="fa fa-question"></i>  Giúp đỡ</a></li>
                <li class="<?php echo ($current_section == 'signout') ? 'active' : '' ?>"><a href="<?php echo site_url('logout') ?>"><i class="fa fa-power-off"></i> Thoát</a></li>
                <li style="padding-left: 50px;">
                    <select id="language" name="language" class="" onchange="var href=this[this.selectedIndex].value; if (href!=''){window.location.href =href};">
                        <option value="/organization/lang/vi">Tiếng Việt</option>
                        <option value="/organization/lang/en">English</option>
                    </select></li>
            </ul>
        </div>
    </div>
</div>
<div id="watermark">
    
</div>
