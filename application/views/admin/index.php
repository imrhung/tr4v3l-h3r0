<div class="alert alert-danger alert-dismissable top-alert">
  <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
  <strong>Hi Super Admin!</strong> You are loged in as super admin, this means you're top dogs. So please be aware what you do affect others below you.
</div>

<div id="wrapper">


    <div id="page-wrapper">

        <h1><b>Welcome to Hero for Zero.</b></h1>
        <p>We are excited to introduce to you our new program. Below you will find some link to help you understand our program.</p>
        <div><div class="fload-left">
                <a href="#">
                    <button class="btn btn-large big-btn">How does it all work?</button>
                </a>
            </div>
            <div class="fload-left">
                <a href="#">
                    <input type="image" src="<?php echo base_url() ?>assets/img/download_app_btn.png" name="download-app" class="" id="download-app" />
                </a>
            </div></div>
        <div>
            <br>
            <br>
            <hr class="hr-light-blue">
        </div>

        <!-- Main content -->
        <h3>Please approve recent Quest</h3>
        <p>Below are quest that have been created. To create a new Quest, <a href="<?php echo base_url() ?>admin/create_quest">Click here</a></p>
        
        <div id="quest"></div>
        <br><br><br>
        
        <!-- Quest approval -->
        <h3>Please approve recent quiz</h3>
        <p>Below are quiz that have been created by other organizations. Please approve or deny them.</p>
        
        
        <div id="quiz"></div>
        
        <br><br><br>
        <!-- Activity approval -->
        <h3>Please approve recent activity</h3>
        <p>Below are activities that have been created by other organizations. Please approve or deny them.</p>
        
        <div id="activity"></div>

        <br><br><br>
        
        <!-- Donation approval -->
        <h3>Please approve recent Donation suggestions</h3>
        <p>Below are Donation suggestions that have been created by other organizations. Please approve or deny them.</p>

        <div id="donation"></div>
        

    </div><!-- /#page-wrapper -->
</div><!-- /#wrapper -->